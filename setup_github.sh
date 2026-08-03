#!/usr/bin/env bash
# Paper Deck을 GitHub에 새 저장소로 생성하고 푸시하는 스크립트
# 사전 준비: GitHub CLI(gh) 설치 + `gh auth login` 완료되어 있어야 함
#   설치: https://cli.github.com/
set -euo pipefail

REPO_NAME="${1:-paper-deck}"
VISIBILITY="${2:-private}"   # private 또는 public

if ! command -v gh &> /dev/null; then
  echo "❌ GitHub CLI(gh)가 설치되어 있지 않습니다. https://cli.github.com/ 에서 설치 후 'gh auth login'을 실행하세요."
  exit 1
fi

if ! gh auth status &> /dev/null; then
  echo "❌ GitHub 로그인이 되어 있지 않습니다. 'gh auth login'을 먼저 실행하세요."
  exit 1
fi

echo "▶ GitHub 저장소 생성: $REPO_NAME ($VISIBILITY)"
gh repo create "$REPO_NAME" --"$VISIBILITY" --source=. --remote=origin --push

echo "✅ 완료! 저장소 URL:"
gh repo view --web --json url -q .url 2>/dev/null || gh repo view --json url -q .url

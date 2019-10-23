#!/bin/sh

REPO="117/demon"
OS="$(tr [A-Z] [a-z] <<<$(uname))"
TAG=$(curl --silent "https://api.github.com/repos/$REPO/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
EXECUTABLE="demon-$OS-$TAG"

if [[ $UNAME == CYGWIN* || $UNAME == MINGW* ]]; then
    exit "Sorry your operating system is not supported."
fi

echo "--- (117/demon) Release Snapshot ---"
echo "os            $OS"
echo "tag           $TAG"
echo "executable    $EXECUTABLE"

RELEASE_ASSET="https://github.com/$REPO/releases/download/$TAG/$EXECUTABLE"

echo "--- Confirm ---"
echo "You may be prompted for your password to make the executable."
echo "Press any key to contine or CTRL + C to abort..."

read

curl -s https://api.github.com/repos/$REPO/releases/latest |
    grep "browser_download_url.*$EXECUTABLE" |
    cut -d : -f 2,3 |
    tr -d \" |
    wget -qi -

#!/bin/bash

VERSION="${1/version-}"

if [ -z "$VERSION" ]; then
    echo "Usage: $0 new-version" >&2
    exit 1
fi

BL_INFO_VER=$(echo "$VERSION" | sed 's/\./, /g')

sed "s/version='[^']*'/version='$VERSION'/" -i setup.py
sed "s/'version': ([^)]*)/'version': ($BL_INFO_VER)/" -i pose_thumbnails/__init__.py

git diff
echo
echo "Don't forget to commit and tag:"
echo git commit -m \'Bumped version to $VERSION\' setup.py pose_thumbnails/__init__.py
echo git tag -a version-$VERSION -m \'Tagged version $VERSION\'

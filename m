Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F5967F9E5
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 18:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbjA1Riw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 12:38:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbjA1Riv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 12:38:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86E059E9;
        Sat, 28 Jan 2023 09:38:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4559660C33;
        Sat, 28 Jan 2023 17:38:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F54C433EF;
        Sat, 28 Jan 2023 17:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674927528;
        bh=yzi89IhCB78iNCVxrj1M/NJav/gcGQem7RXofjXR3Vk=;
        h=From:To:Cc:Subject:Date:From;
        b=iNw+ZlK362yBc8Aw1Tzu2eiULCLiKww0MbyVMDWgkHB8kcvnPGs6c9sg7UpjYiOy+
         UUPou6RyEITGqMnAMbC377NSPHSSdyVamEUzmIJ71XuBsqt48oGA9HTsyvgvpmngDJ
         vvKaHz3sEUU/t3nbtbYaThVTvbsm2Cl3F+me0Ddf0BGavzlEsAv3mdh/O1S5ooSoyr
         CHr2YahljpYRn0sxmpd/Ic/vFrfNrc30mN2vjTwUjaUmT/MPXyXmQ3Pfl6WXSJ9LuU
         P5sIk857JB5fry+wQgpvusjtC2abr0kZbns55+3mEBaCpLRfYmKC8B5jisKJK1Cn1M
         40UR0qiZle/YA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 1/4] kbuild: add a script to generate a list of files ignored by git
Date:   Sun, 29 Jan 2023 02:38:40 +0900
Message-Id: <20230128173843.765212-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In short, the motivation of this commit is to build a source package
without cleaning the source tree.

The deb-pkg and (src)rpm-pkg targets first run 'make clean' before
creating a source tarball. Otherwise build artifacts such as *.o,
*.a, etc. would be included in the tarball. Yet, the tarball ends
up containing several garbage files since 'make clean' does not clean
everything.

Clearning the tree everytime is annoying since it makes the incremental
build impossible. It is desireable to create a source tarball without
cleaning the tree.

In fact, there are some ways to archive this.

The easiest way is "git archive". Actually, "make perf-tar*-src-pkg"
does this way, but I do not like it because it works only when the source
tree is managed by git, and all files you want in the tarball must be
committed in advance.

I want to make it work without relying on git. We can do this.

Files that are not tracked by git are generated files. We can list them
out by parsing the .gitignore files. Of course, .gitignore does not cover
all the cases, but it works well mostly.

tar(1) claims to support it:

  --exclude-vcs-ignores

    Exclude files that match patterns read from VCS-specific ignore files.
    Supported files are: .cvsignore, .gitignore, .bzrignore, and .hgignore.

The best scenario would be to use "tar --exclude-vcs-ignores", but this
option does not work. --exclude-vcs-ignore does not understand any of
the negation (!), preceding slash, following slash. So, this option is
just useless.

I explored some libraries.

- libgit2

  libgit2 supports git_ignore_path_is_ignored(), but it only works in a
  git-managed tree. So, this does not fit to my purpose.

- Python's gitignore-parser

  This library does not work. For example, if .gitignore is like this:

    $ cat .gitignore
    foo/

  You will get this:

    >>> gitignore_parser.parse_gitignore('.gitignore')('foo.a')
    True

  I do not understand why 'foo.a' matches 'foo/'. This library is buggy.

- Perl's Parse::Gitignore

  It does not understand glob patterns at all. 'foo.o' does not match
  '*.o'. Hence, this library is also useless.

After all, I decided to write the code by myself. It is much faster.
Hence, this tool.

The new script, scripts/gen-exclude.py, tarverses the source tree,
parsing the .gitignore files. It prints the file paths that are not
tracked by git. This is suitable to be passed to tar's --exclude-from=
option.

A drawback is this script is so slow. It takes more than a minutes to
traverse the kernel tree. It is better to rewrite it in C or something,
but this is useful at least for proof of concept.

[How to test this script]

  $ git clean -dfx
  $ make -s -j$(nproc) defconfig all                       # or allmodconifg or whatever
  $ git archive -o ../linux1.tar --prefix=./ HEAD
  $ tar tf ../linux1.tar | LANG=C sort > ../file-list1     # files emitted by 'git archive'
  $ scripts/gen-exclude.py --prefix=./ > ../exclude-list
  $ tar cf ../linux2.tar --exclude-from=../exclude-list .
  $ tar tf ../linux2.tar | LANG=C sort > ../file-list2     # files emitted by 'tar'
  $ diff  ../file-list1 ../file-list2 | grep -E '^(<|>)'
  < ./Documentation/devicetree/bindings/.yamllint
  < ./drivers/clk/.kunitconfig
  < ./drivers/gpu/drm/tests/.kunitconfig
  < ./drivers/hid/.kunitconfig
  < ./fs/ext4/.kunitconfig
  < ./fs/fat/.kunitconfig
  < ./kernel/kcsan/.kunitconfig
  < ./lib/kunit/.kunitconfig
  < ./mm/kfence/.kunitconfig
  < ./tools/testing/selftests/arm64/tags/
  < ./tools/testing/selftests/arm64/tags/.gitignore
  < ./tools/testing/selftests/arm64/tags/Makefile
  < ./tools/testing/selftests/arm64/tags/run_tags_test.sh
  < ./tools/testing/selftests/arm64/tags/tags_test.c
  < ./tools/testing/selftests/kvm/.gitignore
  < ./tools/testing/selftests/kvm/Makefile
  < ./tools/testing/selftests/kvm/config
  < ./tools/testing/selftests/kvm/settings

The source tarball contains most of files that are tracked by git. You
see some diffs, but it is just because some .gitignore files are wrong.

  $ git ls-files -i -c --exclude-per-directory=.gitignore
  Documentation/devicetree/bindings/.yamllint
  drivers/clk/.kunitconfig
  drivers/gpu/drm/tests/.kunitconfig
  drivers/hid/.kunitconfig
  fs/ext4/.kunitconfig
  fs/fat/.kunitconfig
  kernel/kcsan/.kunitconfig
  lib/kunit/.kunitconfig
  mm/kfence/.kunitconfig
  tools/testing/selftests/arm64/tags/.gitignore
  tools/testing/selftests/arm64/tags/Makefile
  tools/testing/selftests/arm64/tags/run_tags_test.sh
  tools/testing/selftests/arm64/tags/tags_test.c
  tools/testing/selftests/kvm/.gitignore
  tools/testing/selftests/kvm/Makefile
  tools/testing/selftests/kvm/config
  tools/testing/selftests/kvm/settings

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/gen-exclude.py | 201 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 201 insertions(+)
 create mode 100755 scripts/gen-exclude.py

diff --git a/scripts/gen-exclude.py b/scripts/gen-exclude.py
new file mode 100755
index 000000000000..308c30779c79
--- /dev/null
+++ b/scripts/gen-exclude.py
@@ -0,0 +1,201 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0 only
+#
+# Copyright: Masahiro Yamada <masahiroy@kernel.org>
+
+import argparse
+import collections
+import logging
+import os
+import pathlib
+
+
+class IgnorePattern:
+
+    def __init__(self, pattern, dirpath):
+
+        logging.debug(f"    Add pattern: {pattern}")
+
+        self.orig = pattern
+        self.negate = False
+        self.dir_only = False
+        self.double_asterisk = False
+
+        # The prefix '!' negates the pattern.
+        if pattern[0] == '!':
+            self.negate = True
+            pattern = pattern[1:]
+
+        # a pattern with a trailing slash only matches to directories
+        if pattern[-1] == '/':
+            self.dir_only = True
+            pattern = pattern[:-1]
+
+        # FIXME:
+        # Escape sequence ('\') does not work correctly.
+        # Just strip a backslash at the beginning to support '\#*#'.
+        if pattern[0] == '\\':
+            pattern = pattern[1:]
+
+        # It is tricky to handle double asterisks ("**").
+        # pathlib's match() cannot handle it but glob() can.
+        if '**' in pattern:
+            self.double_asterisk = True
+            if pattern[0] == '/':
+                pattern = pattern[1:]
+
+            self.pattern = []
+
+            for f in dirpath.glob(pattern):
+                self.pattern.append(f.absolute())
+
+            return
+        # If a slash appears at the beginning or middle of the pattern,
+        # (e.g. "/a", "a/b", etc.) it is relative to the directory level.
+        elif '/' in pattern:
+            if pattern[0] == '/':
+                pattern = pattern[1:]
+            pattern = str(dirpath.joinpath(pattern).absolute())
+
+        self.pattern = pattern
+
+    def is_ignored(self, path):
+
+        if path.is_dir() and path.name == '.git':
+            logging.debug(f'  Ignore: {path}')
+            return True
+
+        if self.dir_only and not path.is_dir():
+            return None
+
+        if self.double_asterisk:
+            # Special handling for double asterisks
+            if not path.absolute() in self.pattern:
+                return None
+        else:
+            # make the path abosolute before matching, so it works for patterns
+            # that contain slash(es) such as "/a", "a/b".
+            if not path.absolute().match(self.pattern):
+                return None
+
+        logging.debug(f'  {"Not" if self.negate else ""}Ignore: {path} (pattern: {self.orig})')
+
+        return not self.negate
+
+
+class GitIgnore:
+    def __init__(self, path):
+        # If a path matches multiple patterns, the last one wins.
+        # So, patterns must be checked in the reverse order.
+        # Use deque's appendleft() to add a new pattern.
+        self.patterns = collections.deque()
+        if path is not None:
+            logging.debug(f"  Add gitignore: {path}")
+            self._parse(path)
+
+    def _parse(self, path):
+        with open(path) as f:
+            for line in f:
+                if line.startswith('#'):
+                    continue
+
+                line = line.strip()
+                if not line:
+                    continue
+
+                self.patterns.appendleft(IgnorePattern(line, path.parent))
+
+    def is_ignored(self, path):
+        for pattern in self.patterns:
+            ret = pattern.is_ignored(path)
+            if ret is not None:
+                return ret
+
+        return None
+
+
+class GitIgnores:
+    def __init__(self):
+        self.ignore_files = collections.deque()
+
+    def append(self, path):
+        self.ignore_files.appendleft(GitIgnore(path))
+
+    def pop(self):
+        self.ignore_files.popleft()
+
+    def is_ignored(self, path):
+
+        for gitignore in self.ignore_files:
+            ret = gitignore.is_ignored(path)
+            if ret is not None:
+                return ret
+
+        logging.debug(f"  NoMatch: {path}")
+
+        return False
+
+
+def parse_arguments():
+
+    parser = argparse.ArgumentParser(description='Print files that are not ignored by .gitignore')
+
+    parser.add_argument('-d', '--debug', action='store_true', help='enable debug log')
+
+    parser.add_argument('--prefix', default='', help='prefix added to each path')
+
+    parser.add_argument('--rootdir', default='.', help='root of the source tree (default: current working directory)')
+
+    args = parser.parse_args()
+
+    return args
+
+
+def traverse_directory(path, gitignores, printer):
+
+    logging.debug(f"Enter: {path}")
+
+    gitignore_file = None
+    all_ignored = True
+
+    for f in path.iterdir():
+        if f.is_file() and f.name == '.gitignore':
+            gitignore_file = f
+
+    gitignores.append(gitignore_file)
+
+    for f in path.iterdir():
+        logging.debug(f"  Check: {f}")
+        if gitignores.is_ignored(f):
+            printer(f)
+        else:
+            if f.is_dir() and not f.is_symlink():
+                ret = traverse_directory(f, gitignores, printer)
+                all_ignored = all_ignored and ret
+            else:
+                all_ignored = False
+
+    if all_ignored:
+        printer(path)
+
+    gitignores.pop()
+    logging.debug(f"Leave: {path}")
+
+    return all_ignored
+
+
+def main():
+
+    args = parse_arguments()
+
+    logging.basicConfig(format='%(levelname)s: %(message)s',
+                        level='DEBUG' if args.debug else 'WARNING')
+
+    os.chdir(args.rootdir)
+
+    traverse_directory(pathlib.Path('.'), GitIgnores(),
+                       lambda path: print(f'{args.prefix}{str(path)}'))
+
+
+if __name__ == '__main__':
+    main()
-- 
2.34.1


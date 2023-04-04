Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5CA66D56A3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 04:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbjDDCSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 22:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjDDCST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 22:18:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9314E1BEA;
        Mon,  3 Apr 2023 19:18:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15908623D8;
        Tue,  4 Apr 2023 02:18:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F66AC433EF;
        Tue,  4 Apr 2023 02:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680574697;
        bh=p/p3V4BgkOr/Neip3+vXCyP5CG771gQvUeVYNYDisGs=;
        h=From:To:Cc:Subject:Date:From;
        b=iHoc5bYAH6bT+wc1TXqFY8mlISVmazb9CSc3NRLefppa1QHdxb6b61cAsfKQuloPL
         0pO9i7PhodYwG+MrVssdCQ+z2Z9wBGgedLBh8jl6EFEZlgJ4a0UNDUFi4STRnMPkH8
         doNpuz7Y+h1gD9LcbJlUZ8vH4Np1scOTGHWgBmrOemGaobKVpXmYNOx/RpiBKwzthn
         If9awwwLOWfwRkMFLPpc0m6bSf2VOjMqK99LJoSvmi6+77300pBp7oi+0of9XsFUEG
         o+qMNdH3YwV/k++kFA1SroOeY04PAX88j19H57SmRLWBbKrs5Z4uwYB/qTA55Q42VO
         yrEPFqoBLQQQA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH] kbuild: give up untracked files for source package builds
Date:   Tue,  4 Apr 2023 11:17:58 +0900
Message-Id: <20230404021758.1194687-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the source tree is dirty and contains untracked files, package
builds may fail. For example, when a broken symlink exists, a file
path contains whitespaces, etc.

Since commit 05e96e96a315 ("kbuild: use git-archive for source package
creation"), the source tarball only contains committed files because
it is created by 'git archive'. scripts/package/gen-diff-patch tries
to address the diff from HEAD, but including untracked files by the
hand-crafted script introduces more complexity. I wrote a patch [1] to
make it work in most cases, but still wonder if this is what we should
aim for.

This patch just gives up untracked files. Going forward, it is your
responsibility to do 'git add' for what you want in the source package.
The script shows a warning just in case you forgot to do so. It should
be checked only when building source packages.

[1]: https://lore.kernel.org/all/CAK7LNAShbZ56gSh9PrbLnBDYKnjtTkHMoCXeGrhcxMvqXGq9=g@mail.gmail.com/2-0001-kbuild-make-package-builds-more-robust.patch

Fixes: 05e96e96a315 ("kbuild: use git-archive for source package creation")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.package       |  3 +-
 scripts/package/gen-diff-patch | 57 +++++++++++++----------------
 scripts/package/mkdebian       | 66 +++++++++++++++++++---------------
 scripts/package/mkspec         | 11 ++----
 4 files changed, 67 insertions(+), 70 deletions(-)

diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index 61f72eb8d9be..49aff12cb6ab 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -94,7 +94,7 @@ binrpm-pkg:
 		$(UTS_MACHINE)-linux -bb $(objtree)/binkernel.spec
 
 quiet_cmd_debianize = GEN     $@
-      cmd_debianize = $(srctree)/scripts/package/mkdebian
+      cmd_debianize = $(srctree)/scripts/package/mkdebian $(mkdebian-opts)
 
 debian: FORCE
 	$(call cmd,debianize)
@@ -103,6 +103,7 @@ PHONY += debian-orig
 debian-orig: private source = $(shell dpkg-parsechangelog -S Source)
 debian-orig: private version = $(shell dpkg-parsechangelog -S Version | sed 's/-[^-]*$$//')
 debian-orig: private orig-name = $(source)_$(version).orig.tar.gz
+debian-orig: mkdebian-opts = --need-source
 debian-orig: linux.tar.gz debian
 	$(Q)if [ "$(df  --output=target .. 2>/dev/null)" = "$(df --output=target $< 2>/dev/null)" ]; then \
 		ln -f $< ../$(orig-name); \
diff --git a/scripts/package/gen-diff-patch b/scripts/package/gen-diff-patch
index f842ab50a780..a180ff94f655 100755
--- a/scripts/package/gen-diff-patch
+++ b/scripts/package/gen-diff-patch
@@ -2,43 +2,36 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 diff_patch="${1}"
-untracked_patch="${2}"
 srctree=$(dirname $0)/../..
 
-rm -f ${diff_patch} ${untracked_patch}
-
-if ! ${srctree}/scripts/check-git; then
-	exit
-fi
-
-mkdir -p "$(dirname ${diff_patch})" "$(dirname ${untracked_patch})"
+mkdir -p "$(dirname ${diff_patch})"
 
 git -C "${srctree}" diff HEAD > "${diff_patch}"
 
-if [ ! -s "${diff_patch}" ]; then
-	rm -f "${diff_patch}"
+if [ ! -s "${diff_patch}" ] ||
+   [ -z "$(git -C "${srctree}" ls-files --other --exclude-standard | head -n1)" ]; then
 	exit
 fi
 
-git -C ${srctree} status --porcelain --untracked-files=all |
-while read stat path
-do
-	if [ "${stat}" = '??' ]; then
-
-		if ! diff -u /dev/null "${srctree}/${path}" > .tmp_diff &&
-			! head -n1 .tmp_diff | grep -q "Binary files"; then
-			{
-				echo "--- /dev/null"
-				echo "+++ linux/$path"
-				cat .tmp_diff | tail -n +3
-			} >> ${untracked_patch}
-		fi
-	fi
-done
-
-rm -f .tmp_diff
-
-if [ ! -s "${diff_patch}" ]; then
-	rm -f "${diff_patch}"
-	exit
-fi
+# The source tarball, which is generated by 'git archive', contains everything
+# you committed in the repository. If you have local diff ('git diff HEAD'),
+# it will go into ${diff_patch}. If untracked files are remaining, the resulting
+# source package may not be correct.
+#
+# Examples:
+#  - You modified a source file to add #include <linux/new-header.h>
+#    but forgot to add include/linux/new-header.h
+#  - You modified a Makefile to add 'obj-$(CONFIG_FOO) += new-dirver.o'
+#    but you forgot to add new-driver.c
+#
+# You need to commit them, or at least stage them by 'git add'.
+#
+# This script does not take care of untracked files because doing so would
+# introduce additional complexity. Instead, print a warning message here if
+# untracked files are found.
+# If all untracked files are just garbage, you can ignore this warning.
+echo >&2 "============================ WARNING ============================"
+echo >&2 "Your working tree has diff from HEAD, and also untracked file(s)."
+echo >&2 "Please make sure you did 'git add' for all new files you need in"
+echo >&2 "the source package."
+echo >&2 "================================================================="
diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
index e20a2b5be9eb..220b5e35fc13 100755
--- a/scripts/package/mkdebian
+++ b/scripts/package/mkdebian
@@ -84,7 +84,45 @@ set_debarch() {
 	fi
 }
 
+# Create debian/source/ if it is a source package build
+gen_source ()
+{
+	mkdir -p debian/source
+
+	echo "3.0 (quilt)" > debian/source/format
+
+	{
+		echo "diff-ignore"
+		echo "extend-diff-ignore = .*"
+	} > debian/source/local-options
+
+	# Add .config as a patch
+	mkdir -p debian/patches
+	{
+		echo "Subject: Add .config"
+		echo "Author: ${maintainer}"
+		echo
+		echo "--- /dev/null"
+		echo "+++ linux/.config"
+		diff -u /dev/null "${KCONFIG_CONFIG}" | tail -n +3
+	} > debian/patches/config
+	echo config > debian/patches/series
+
+	$(dirname $0)/gen-diff-patch debian/patches/diff.patch
+	if [ -s debian/patches/diff.patch ]; then
+		echo diff.patch >> debian/patches/series
+	else
+		rm -f debian/patches/diff.patch
+	fi
+}
+
 rm -rf debian
+mkdir debian
+
+if [ "$1" = --need-source ]; then
+	gen_source
+	shift
+fi
 
 # Some variables and settings used throughout the script
 version=$KERNELRELEASE
@@ -132,34 +170,6 @@ else
         echo >&2 "Install lsb-release or set \$KDEB_CHANGELOG_DIST explicitly"
 fi
 
-mkdir -p debian/source/
-echo "3.0 (quilt)" > debian/source/format
-
-{
-	echo "diff-ignore"
-	echo "extend-diff-ignore = .*"
-} > debian/source/local-options
-
-# Add .config as a patch
-mkdir -p debian/patches
-{
-	echo "Subject: Add .config"
-	echo "Author: ${maintainer}"
-	echo
-	echo "--- /dev/null"
-	echo "+++ linux/.config"
-	diff -u /dev/null "${KCONFIG_CONFIG}" | tail -n +3
-} > debian/patches/config
-echo config > debian/patches/series
-
-$(dirname $0)/gen-diff-patch debian/patches/diff.patch debian/patches/untracked.patch
-if [ -f debian/patches/diff.patch ]; then
-	echo diff.patch >> debian/patches/series
-fi
-if [ -f debian/patches/untracked.patch ]; then
-	echo untracked.patch >> debian/patches/series
-fi
-
 echo $debarch > debian/arch
 extra_build_depends=", $(if_enabled_echo CONFIG_UNWINDER_ORC libelf-dev:native)"
 extra_build_depends="$extra_build_depends, $(if_enabled_echo CONFIG_SYSTEM_TRUSTED_KEYRING libssl-dev:native)"
diff --git a/scripts/package/mkspec b/scripts/package/mkspec
index b7d1dc28a5d6..b45020d64218 100755
--- a/scripts/package/mkspec
+++ b/scripts/package/mkspec
@@ -19,8 +19,7 @@ else
 	mkdir -p rpmbuild/SOURCES
 	cp linux.tar.gz rpmbuild/SOURCES
 	cp "${KCONFIG_CONFIG}" rpmbuild/SOURCES/config
-	$(dirname $0)/gen-diff-patch rpmbuild/SOURCES/diff.patch rpmbuild/SOURCES/untracked.patch
-	touch rpmbuild/SOURCES/diff.patch rpmbuild/SOURCES/untracked.patch
+	$(dirname $0)/gen-diff-patch rpmbuild/SOURCES/diff.patch
 fi
 
 if grep -q CONFIG_MODULES=y include/config/auto.conf; then
@@ -56,7 +55,6 @@ sed -e '/^DEL/d' -e 's/^\t*//' <<EOF
 $S	Source0: linux.tar.gz
 $S	Source1: config
 $S	Source2: diff.patch
-$S	Source3: untracked.patch
 	Provides: $PROVIDES
 $S	BuildRequires: bc binutils bison dwarves
 $S	BuildRequires: (elfutils-libelf-devel or libelf-devel) flex
@@ -94,12 +92,7 @@ $S$M
 $S	%prep
 $S	%setup -q -n linux
 $S	cp %{SOURCE1} .config
-$S	if [ -s %{SOURCE2} ]; then
-$S		patch -p1 < %{SOURCE2}
-$S	fi
-$S	if [ -s %{SOURCE3} ]; then
-$S		patch -p1 < %{SOURCE3}
-$S	fi
+$S	patch -p1 < %{SOURCE2}
 $S
 $S	%build
 $S	$MAKE %{?_smp_mflags} KERNELRELEASE=$KERNELRELEASE KBUILD_BUILD_VERSION=%{release}
-- 
2.37.2


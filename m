Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C4D692530
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 19:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbjBJSSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 13:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbjBJSSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 13:18:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3653C56EE7;
        Fri, 10 Feb 2023 10:18:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B9403B824DC;
        Fri, 10 Feb 2023 18:18:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9687C4339E;
        Fri, 10 Feb 2023 18:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676053118;
        bh=OOnQiLtiUJOqoDdzJaP936hrThLt6/kh3l2/k+KX7a4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TcnPILo3ifUOzSjnjIJD8HddzLBYjFKyGJWT2qDyb8TEg3hHJZhrbyMm5CifS1SOi
         7wNojkMhvLvjxjNFQFCqrP/FsXzQ7X1JE3unugRnE6KNkRbXXLhgBx9SukXe0xNVSh
         YRRSa/KV40FwBltSA6l7JZCxOVIHyVPzBFW7uFy7tHEcC0UZWhqScxOkSOeLQIx6s1
         vM9oV1lQjvATqH35a5Q2OzKoLIegya7YhzHbOLQWubjS8v3Ho+1pduf7XwOCnEVRZF
         gcs537M8ATNLtaJ/geUJR97AUp5ZKM2fq2OkfAi35j+IKL9YwM2mrEe8+iz9GaIjaS
         auZQpo86cSaJA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Ben Hutchings <ben@decadent.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev
Subject: [PATCH v5 2/7] kbuild: deb-pkg: create source package without cleaning
Date:   Sat, 11 Feb 2023 03:18:23 +0900
Message-Id: <20230210181828.124765-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230210181828.124765-1-masahiroy@kernel.org>
References: <20230210181828.124765-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you run 'make deb-pkg', all objects are lost due to 'make clean',
which makes the incremental builds impossible.

Instead of cleaning, pass the exclude list to tar's --exclude-from
option.

Previously, *.diff.gz contained some check-in files such as
.clang-format, .cocciconfig.

With this commit, *.diff.gz will only contain the .config and debian/.
The other source files will go into the .orig tarball.

linux.tar.gz is rebuilt only when the source files that would go into
the tarball are changed.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v5:
  - Avoid unneeded rebuild of the tarball when nothing in the source tree
    is changed.

Changes in v4:
  - Fix a typo in comment

Changes in v3:
  - Add --extra-pattern='*.rej'
  - Exclude symlinks at the toplevel
  - Add --sort=name tar option

 scripts/Makefile.package | 40 ++++++++++++++++++++++++++++++++++------
 scripts/package/mkdebian | 24 ++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 6 deletions(-)

diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index dfbf40454a99..0dda909f87a9 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -80,13 +80,12 @@ binrpm-pkg:
 		$(UTS_MACHINE)-linux -bb $(objtree)/binkernel.spec
 
 PHONY += deb-pkg
-deb-pkg:
-	$(MAKE) clean
+deb-pkg: linux.tar.gz
 	$(CONFIG_SHELL) $(srctree)/scripts/package/mkdebian
-	$(call cmd,src_tar,$(KDEB_SOURCENAME))
-	origversion=$$(dpkg-parsechangelog -SVersion |sed 's/-[^-]*$$//');\
-		mv $(KDEB_SOURCENAME).tar.gz ../$(KDEB_SOURCENAME)_$${origversion}.orig.tar.gz
-	+dpkg-buildpackage -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch) $(DPKG_FLAGS) --source-option=-sP -i.git -us -uc
+	$(Q)origversion=$$(dpkg-parsechangelog -SVersion |sed 's/-[^-]*$$//');\
+		cp linux.tar.gz ../$(KDEB_SOURCENAME)_$${origversion}.orig.tar.gz
+	+dpkg-buildpackage -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch) $(DPKG_FLAGS) \
+		--build=source,binary --source-option=-sP -nc -us -uc
 
 PHONY += bindeb-pkg
 bindeb-pkg:
@@ -120,6 +119,32 @@ $(tar-pkgs):
 	$(MAKE) -f $(srctree)/Makefile
 	+$(CONFIG_SHELL) $(srctree)/scripts/package/buildtar $@
 
+# Source Tarball
+# ---------------------------------------------------------------------------
+
+scripts/list-gitignored: FORCE
+	$(Q)$(MAKE) -f $(srctree)/Makefile scripts_package
+
+# 1f5d3a6b6532e25a5cdf1f311956b2b03d343a48 removed '*.rej' from .gitignore,
+# but it is definitely a generated file.
+filechk_filelist = \
+	$< --exclude='*.rej' --output=$@_exclude --prefix=./ --rootdir=$(srctree) --stat=-
+
+.tmp_filelist: scripts/list-gitignored FORCE
+	$(call filechk,filelist)
+
+quiet_cmd_tar = TAR     $@
+      cmd_tar = tar $(compress-opt) -c -f $@ \
+                --exclude=./$@ --exclude-from=$<_exclude \
+                --owner=0 --group=0 --sort=name \
+                --transform 's:^\.:$*:S' -C $(tar-rootdir) .
+
+tar-rootdir := $(srctree)
+
+%.tar.gz: compress-opt := -I $(KGZIP)
+%.tar.gz: .tmp_filelist
+	$(call cmd,tar)
+
 # perf-pkg - generate a source tarball with perf source
 # ---------------------------------------------------------------------------
 
@@ -174,4 +199,7 @@ help:
 	@echo '  perf-tarxz-src-pkg  - Build $(perf-tar).tar.xz source tarball'
 	@echo '  perf-tarzst-src-pkg - Build $(perf-tar).tar.zst source tarball'
 
+PHONY += FORCE
+FORCE:
+
 .PHONY: $(PHONY)
diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
index c3bbef7a6754..68b13ef590ba 100755
--- a/scripts/package/mkdebian
+++ b/scripts/package/mkdebian
@@ -84,6 +84,8 @@ set_debarch() {
 	fi
 }
 
+rm -rf debian
+
 # Some variables and settings used throughout the script
 version=$KERNELRELEASE
 if [ -n "$KDEB_PKGVERSION" ]; then
@@ -135,6 +137,28 @@ fi
 mkdir -p debian/source/
 echo "1.0" > debian/source/format
 
+# Ugly: ignore anything except .config or debian/
+cat<<'EOF' > debian/source/local-options
+diff-ignore
+
+extend-diff-ignore = ^[^.d]
+
+extend-diff-ignore = ^\.[^c]
+extend-diff-ignore = ^\.c($|[^o])
+extend-diff-ignore = ^\.co($|[^n])
+extend-diff-ignore = ^\.con($|[^f])
+extend-diff-ignore = ^\.conf($|[^i])
+extend-diff-ignore = ^\.confi($|[^g])
+extend-diff-ignore = ^\.config.
+
+extend-diff-ignore = ^d($|[^e])
+extend-diff-ignore = ^de($|[^b])
+extend-diff-ignore = ^deb($|[^i])
+extend-diff-ignore = ^debi($|[^a])
+extend-diff-ignore = ^debia($|[^n])
+extend-diff-ignore = ^debian[^/]
+EOF
+
 echo $debarch > debian/arch
 extra_build_depends=", $(if_enabled_echo CONFIG_UNWINDER_ORC libelf-dev:native)"
 extra_build_depends="$extra_build_depends, $(if_enabled_echo CONFIG_SYSTEM_TRUSTED_KEYRING libssl-dev:native)"
-- 
2.34.1


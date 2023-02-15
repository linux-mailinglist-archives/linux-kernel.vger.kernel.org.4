Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648F669737E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 02:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbjBOBWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 20:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbjBOBWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 20:22:14 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B397EEC;
        Tue, 14 Feb 2023 17:21:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8CB3ECE2317;
        Wed, 15 Feb 2023 01:21:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 338DCC4339E;
        Wed, 15 Feb 2023 01:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676424095;
        bh=x5ONHmD9axTWl2ROxj07e1ofChMPlgTyKLO4V4lNEIw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XTGt8ux85AQXhQI319C7K8yqIoGEXDYu9nX2yHvUA3kMCxc0xwn+2KBT/VSPeehpK
         imtbeyEfToMP/dxPY6opYBcjvGYuUcgyAiOgJE2Qm+9aSJGT3FR06vCdZJIehTNmXu
         Y+UgH2vcwlcc5LW1Gkj4wOgG5F9MjoCFUtP7QkNf1e3qT1WVA//GuvYkz2w7O/X8KK
         yKJy2C2ejSyz/eN5gc2k4lbqUy9ugcRuV7GtPr0+e+P0TLE7DJ8uOXZFhRfIz5JTsQ
         j06LtRkgdntpRlocZwLdAERa9iH2ATX2S5ykLABTxqJH9H6cGwR+jwpqQS1/2pE3Un
         y4/KdXMnIvfQQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        llvm@lists.linux.dev
Subject: [PATCH v6 02/12] kbuild: deb-pkg: create source package without cleaning
Date:   Wed, 15 Feb 2023 10:20:24 +0900
Message-Id: <20230215012034.403356-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230215012034.403356-1-masahiroy@kernel.org>
References: <20230215012034.403356-1-masahiroy@kernel.org>
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

Changes in v6:
  - Add more stubs to cmd_tar so I can reuse it for the other rules

Changes in v5:
  - Avoid unneeded rebuild of the tarball when nothing in the source tree
    is changed.

Changes in v4:
  - Fix a typo in comment

Changes in v3:
  - Add --extra-pattern='*.rej'
  - Exclude symlinks at the toplevel
  - Add --sort=name tar option

 scripts/Makefile.package | 48 +++++++++++++++++++++++++++++++++++-----
 scripts/package/mkdebian | 24 ++++++++++++++++++++
 2 files changed, 66 insertions(+), 6 deletions(-)

diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index dfbf40454a99..f0002ace4156 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -43,13 +43,47 @@ if test "$(objtree)" != "$(srctree)"; then \
 	echo >&2 "  ERROR:"; \
 	echo >&2 "  Building source tarball is not possible outside the"; \
 	echo >&2 "  kernel source tree. Don't set KBUILD_OUTPUT, or use the"; \
-	echo >&2 "  binrpm-pkg or bindeb-pkg target instead."; \
+	echo >&2 "  binrpm-pkg target instead."; \
 	echo >&2; \
 	false; \
 fi ; \
 tar -I $(KGZIP) -c $(RCS_TAR_IGNORE) -f $(2).tar.gz \
 	--transform 's:^:$(2)/:S' $(TAR_CONTENT) $(3)
 
+# .tmp_filelist .tmp_filelist_exclude
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
+# tarball
+# ---------------------------------------------------------------------------
+
+quiet_cmd_tar = TAR     $@
+      cmd_tar = tar -c -f $@ $(tar-compress-opt) $(tar-exclude-opt) \
+                --owner=0 --group=0 --sort=name \
+                --transform 's:^\.:$*:S' -C $(tar-rootdir) .
+
+tar-rootdir := $(srctree)
+
+%.tar.gz: private tar-compress-opt := -I $(KGZIP)
+%.tar.gz:
+	$(call cmd,tar)
+
+# Linux source tarball
+# ---------------------------------------------------------------------------
+
+linux.tar.gz: tar-exclude-opt = --exclude=./$@ --exclude-from=$<_exclude
+linux.tar.gz: .tmp_filelist
+
 # rpm-pkg
 # ---------------------------------------------------------------------------
 PHONY += rpm-pkg
@@ -80,13 +114,12 @@ binrpm-pkg:
 		$(UTS_MACHINE)-linux -bb $(objtree)/binkernel.spec
 
 PHONY += deb-pkg
-deb-pkg:
-	$(MAKE) clean
+deb-pkg: linux.tar.gz
 	$(CONFIG_SHELL) $(srctree)/scripts/package/mkdebian
-	$(call cmd,src_tar,$(KDEB_SOURCENAME))
 	origversion=$$(dpkg-parsechangelog -SVersion |sed 's/-[^-]*$$//');\
-		mv $(KDEB_SOURCENAME).tar.gz ../$(KDEB_SOURCENAME)_$${origversion}.orig.tar.gz
-	+dpkg-buildpackage -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch) $(DPKG_FLAGS) --source-option=-sP -i.git -us -uc
+		cp linux.tar.gz ../$(KDEB_SOURCENAME)_$${origversion}.orig.tar.gz
+	+dpkg-buildpackage -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch) $(DPKG_FLAGS) \
+		--build=source,binary --source-option=-sP -nc -us -uc
 
 PHONY += bindeb-pkg
 bindeb-pkg:
@@ -174,4 +207,7 @@ help:
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


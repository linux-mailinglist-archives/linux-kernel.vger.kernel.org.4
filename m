Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8FC46873FE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 04:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbjBBDjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 22:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjBBDii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 22:38:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C1F7B419;
        Wed,  1 Feb 2023 19:38:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A97BA619E5;
        Thu,  2 Feb 2023 03:38:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36ABBC433A1;
        Thu,  2 Feb 2023 03:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675309109;
        bh=q+FdDvjhNstlnFeTmy4laRxc/ZnBwhI+dZWJtjSZSRM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bj1VfFc1j+hElkksF/9w6LutWhVo2oBLFKRb/8IKQApLk0OYGZBUwtt2I0OwwVF6p
         gV44yfhYiKp1+wcZWMhpr5FcrCmxlDPJj08C81saF6+S9v3WL0tb4VDgn5joWxOdSq
         3+N8fXPpYLQ7UmL0vrZyaSF5VJs6TfaJAQVJ6ol5GxbAE0X+gVQHyDymNlILpl6s/H
         8xJzGRjLeh4CsGw0ToHu6yXMx+ZNnpGj3p7XNDs4MmhOd2LVkhRQ2iJmU/M8EEIUEW
         /R+5nIvCDmEPrbbD72pfwBRlG9+Winl0Coo7FkX4Sa0wHCn0PO2qBX877Vi+/ssHpo
         5Paxf8AGQ2vBQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Ben Hutchings <ben@decadent.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev
Subject: [PATCH v4 2/6] kbuild: deb-pkg: create source package without cleaning
Date:   Thu,  2 Feb 2023 12:37:12 +0900
Message-Id: <20230202033716.341858-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230202033716.341858-1-masahiroy@kernel.org>
References: <20230202033716.341858-1-masahiroy@kernel.org>
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
The other source files will go into the tarball.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v4:
  - Fix a typo in comment

Changes in v3:
  - Add --extra-pattern='*.rej'
  - Exclude symlinks at the toplevel
  - Add --sort=name tar option

 scripts/Makefile.package | 38 +++++++++++++++++++++++++++++++++-----
 scripts/package/mkdebian | 25 +++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 5 deletions(-)

diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index dfbf40454a99..14567043a8af 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -50,6 +50,32 @@ fi ; \
 tar -I $(KGZIP) -c $(RCS_TAR_IGNORE) -f $(2).tar.gz \
 	--transform 's:^:$(2)/:S' $(TAR_CONTENT) $(3)
 
+# Source Tarball
+# ---------------------------------------------------------------------------
+
+PHONY += gen-exclude
+gen-exclude:
+	$(Q)$(MAKE) -f $(srctree)/Makefile scripts_exclude
+
+# - Commit 1f5d3a6b6532e25a5cdf1f311956b2b03d343a48 removed '*.rej' from
+#   .gitignore, but it is definitely a generated file.
+# - The kernel tree has no symlink at the toplevel. If it does, it is a
+#   generated one.
+quiet_cmd_exclude_list = GEN     $@
+      cmd_exclude_list = \
+	scripts/gen-exclude --extra-pattern='*.rej' --prefix=./ --rootdir=$(srctree) > $@; \
+	find . -maxdepth 1 -type l >> $@; \
+	echo "./$@" >> $@
+
+.exclude-list: gen-exclude
+	$(call cmd,exclude_list)
+
+quiet_cmd_tar = TAR     $@
+      cmd_tar = tar -I $(KGZIP) -c -f $@ -C $(srctree) --exclude-from=$< --exclude=./$@ --sort=name --transform 's:^\.:linux:S' .
+
+%.tar.gz: .exclude-list
+	$(call cmd,tar)
+
 # rpm-pkg
 # ---------------------------------------------------------------------------
 PHONY += rpm-pkg
@@ -81,12 +107,11 @@ binrpm-pkg:
 
 PHONY += deb-pkg
 deb-pkg:
-	$(MAKE) clean
 	$(CONFIG_SHELL) $(srctree)/scripts/package/mkdebian
-	$(call cmd,src_tar,$(KDEB_SOURCENAME))
-	origversion=$$(dpkg-parsechangelog -SVersion |sed 's/-[^-]*$$//');\
-		mv $(KDEB_SOURCENAME).tar.gz ../$(KDEB_SOURCENAME)_$${origversion}.orig.tar.gz
-	+dpkg-buildpackage -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch) $(DPKG_FLAGS) --source-option=-sP -i.git -us -uc
+	$(Q)origversion=$$(dpkg-parsechangelog -SVersion |sed 's/-[^-]*$$//');\
+		$(MAKE) -f $(srctree)/scripts/Makefile.package ../$(KDEB_SOURCENAME)_$${origversion}.orig.tar.gz
+	+dpkg-buildpackage -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch) $(DPKG_FLAGS) \
+		--build=source,binary --source-option=-sP -nc -us -uc
 
 PHONY += bindeb-pkg
 bindeb-pkg:
@@ -174,4 +199,7 @@ help:
 	@echo '  perf-tarxz-src-pkg  - Build $(perf-tar).tar.xz source tarball'
 	@echo '  perf-tarzst-src-pkg - Build $(perf-tar).tar.zst source tarball'
 
+PHONY += FORCE
+FORCE:
+
 .PHONY: $(PHONY)
diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
index c3bbef7a6754..2f612617cbcf 100755
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
@@ -135,6 +137,29 @@ fi
 mkdir -p debian/source/
 echo "1.0" > debian/source/format
 
+# Ugly: ignore anything except .config or debian/
+# (is there a cleaner way to do this?)
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


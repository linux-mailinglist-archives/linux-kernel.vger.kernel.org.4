Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A982F69737F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 02:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbjBOBW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 20:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbjBOBWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 20:22:16 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27AB59FD;
        Tue, 14 Feb 2023 17:21:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EDC45CE2312;
        Wed, 15 Feb 2023 01:21:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00AD3C433EF;
        Wed, 15 Feb 2023 01:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676424099;
        bh=cUer3+ZFLO/LgmrihaytqwQfyiyEi5va0uACiX5PzjU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pKCvBNDzdJuWbdfhIqMA0XaTFxBw75yUiceXlGQdN4nX+Tar7kmNMzwR22pNKTIrh
         sqlbDG+agka93SgGyHEd+pRp5r1nclicHfSmdmXchqV7amvGcwdrVomEh8BqCFtNgF
         jsyZQls4aTHqw80cogDmiKTu9tniw9AJ+3yKF7WqalsKOX32fl6X2BweSbJblnFBMP
         6EEBd3dRQeDIrLntX9dAxLC7fU9GaJi4ilECoY+DjnZJKxFG4rinVCIRb7/jNZSapL
         COsCOKgEY7MudtlyUxSwQdPALGKujjUam4KK+wbJu80Ssl2QWfzSm8ZtBPE4EBbVF3
         hnnAad9iInB9A==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH v6 04/12] kbuild: srcrpm-pkg: create source package without cleaning
Date:   Wed, 15 Feb 2023 10:20:26 +0900
Message-Id: <20230215012034.403356-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230215012034.403356-1-masahiroy@kernel.org>
References: <20230215012034.403356-1-masahiroy@kernel.org>
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

If you run 'make (src)rpm-pkg', all objects are lost due to 'make clean',
which makes the incremental builds impossible.

Instead of cleaning, pass the exclude list to tar's --exclude-from
option.

Previously, the .config was contained in the source tarball.

With this commit, the source rpm consists of separate linux.tar.gz
and .config.

Remove stale comments. Now, 'make (src)rpm-pkg' works with O= option.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

(no changes since v4)

Changes in v4:
  - Do not delete the old tar command because it is still used
    by snap-pkg although snap-pkg is broken, and it does not work at all.

 scripts/Makefile.package | 32 ++++----------------------------
 scripts/package/mkspec   |  8 ++++----
 2 files changed, 8 insertions(+), 32 deletions(-)

diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index 55441d776d70..7266a11855f4 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -3,27 +3,6 @@
 
 include $(srctree)/scripts/Kbuild.include
 
-# RPM target
-# ---------------------------------------------------------------------------
-# The rpm target generates two rpm files:
-# /usr/src/packages/SRPMS/kernel-2.6.7rc2-1.src.rpm
-# /usr/src/packages/RPMS/i386/kernel-2.6.7rc2-1.<arch>.rpm
-# The src.rpm files includes all source for the kernel being built
-# The <arch>.rpm includes kernel configuration, modules etc.
-#
-# Process to create the rpm files
-# a) clean the kernel
-# b) Generate .spec file
-# c) Build a tar ball, using symlink to make kernel version
-#    first entry in the path
-# d) and pack the result to a tar.gz file
-# e) generate the rpm files, based on kernel.spec
-# - Use /. to avoid tar packing just the symlink
-
-# Note that the rpm-pkg target cannot be used with KBUILD_OUTPUT,
-# but the binrpm-pkg target can; for some reason O= gets ignored.
-
-# Remove hyphens since they have special meaning in RPM filenames
 KERNELPATH := kernel-$(subst -,_,$(KERNELRELEASE))
 KDEB_SOURCENAME ?= linux-upstream
 KBUILD_PKG_ROOTCMD ?="fakeroot -u"
@@ -42,8 +21,7 @@ if test "$(objtree)" != "$(srctree)"; then \
 	echo >&2; \
 	echo >&2 "  ERROR:"; \
 	echo >&2 "  Building source tarball is not possible outside the"; \
-	echo >&2 "  kernel source tree. Don't set KBUILD_OUTPUT, or use the"; \
-	echo >&2 "  binrpm-pkg target instead."; \
+	echo >&2 "  kernel source tree. Don't set KBUILD_OUTPUT"; \
 	echo >&2; \
 	false; \
 fi ; \
@@ -95,12 +73,10 @@ rpm-pkg: srcrpm-pkg
 # srcrpm-pkg
 # ---------------------------------------------------------------------------
 PHONY += srcrpm-pkg
-srcrpm-pkg:
-	$(MAKE) clean
+srcrpm-pkg: linux.tar.gz
 	$(CONFIG_SHELL) $(MKSPEC) >$(objtree)/kernel.spec
-	$(call cmd,src_tar,$(KERNELPATH),kernel.spec)
-	+rpmbuild $(RPMOPTS) --target $(UTS_MACHINE)-linux -ts $(KERNELPATH).tar.gz \
-	--define='_smp_mflags %{nil}' --define='_srcrpmdir $(srctree)'
+	+rpmbuild $(RPMOPTS) --target $(UTS_MACHINE)-linux -bs kernel.spec \
+	--define='_smp_mflags %{nil}' --define='_sourcedir .' --define='_srcrpmdir .'
 
 # binrpm-pkg
 # ---------------------------------------------------------------------------
diff --git a/scripts/package/mkspec b/scripts/package/mkspec
index 108c0cb95436..83a64d9d7372 100755
--- a/scripts/package/mkspec
+++ b/scripts/package/mkspec
@@ -47,7 +47,8 @@ sed -e '/^DEL/d' -e 's/^\t*//' <<EOF
 	Group: System Environment/Kernel
 	Vendor: The Linux Community
 	URL: https://www.kernel.org
-$S	Source: kernel-$__KERNELRELEASE.tar.gz
+$S	Source0: linux.tar.gz
+$S	Source1: .config
 	Provides: $PROVIDES
 $S	BuildRequires: bc binutils bison dwarves
 $S	BuildRequires: (elfutils-libelf-devel or libelf-devel) flex
@@ -83,9 +84,8 @@ $S$M	This package provides kernel headers and makefiles sufficient to build modu
 $S$M	against the $__KERNELRELEASE kernel package.
 $S$M
 $S	%prep
-$S	%setup -q
-$S	rm -f scripts/basic/fixdep scripts/kconfig/conf
-$S	rm -f tools/objtool/{fixdep,objtool}
+$S	%setup -q -n linux
+$S	cp %{SOURCE1} .
 $S
 $S	%build
 $S	$MAKE %{?_smp_mflags} KERNELRELEASE=$KERNELRELEASE KBUILD_BUILD_VERSION=%{release}
-- 
2.34.1


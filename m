Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEC6692535
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 19:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbjBJSS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 13:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbjBJSSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 13:18:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EB15DC37;
        Fri, 10 Feb 2023 10:18:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0089E61E6E;
        Fri, 10 Feb 2023 18:18:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 323C1C433A1;
        Fri, 10 Feb 2023 18:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676053122;
        bh=4Qxghh6QU4N932aY/0tlyYMGET6IecDHbvbpkYpyZTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S/yK6gJxX2E0Y+4e3Z47a9QDTM40XVFXSnhwq1fgcVSCvaoiNGRdrDc7dGw1AlFwG
         oQKE2o+qeNyMPdTs9n8B9ThgrCB4ZPDkJ577/NDAr7sqTCWfzFzxCZqQqw2QEW7FQA
         fI6ubo5YZKi5SaaVxNxodZzutRj9uikOq4J/bIoNZ1/peeOI8St1RMgTZiXCgI8rM/
         slU7ll0DYEQ8TPBSJTOhzSZKoVLmErqkwAu/w5H3JHVS/bvb5I0psWEIxjA+KApM4s
         TkcYpoWgYEuHwDMbRVCCOWzYhTCATotRBFrPqKt1EjyzXkT5qSAd4SqnpY63FutTUm
         sWkvWQaHXgrig==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Ben Hutchings <ben@decadent.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v5 4/7] kbuild: srcrpm-pkg: create source package without cleaning
Date:   Sat, 11 Feb 2023 03:18:25 +0900
Message-Id: <20230210181828.124765-4-masahiroy@kernel.org>
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

 scripts/Makefile.package | 29 +++--------------------------
 scripts/package/mkspec   |  8 ++++----
 2 files changed, 7 insertions(+), 30 deletions(-)

diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index 0b66bd667212..39f67f876092 100644
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
@@ -61,12 +40,10 @@ rpm-pkg: srcrpm-pkg
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


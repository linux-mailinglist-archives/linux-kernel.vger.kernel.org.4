Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10DC67F9EB
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 18:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234741AbjA1RjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 12:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234556AbjA1RjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 12:39:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F492A16E;
        Sat, 28 Jan 2023 09:38:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37C92B80B57;
        Sat, 28 Jan 2023 17:38:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F58FC433A0;
        Sat, 28 Jan 2023 17:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674927535;
        bh=P19kYlGfD3VxBVIeWwkF+xYQQvFrLROr+eyRMXl63m8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KloQZ1aiZfD75B8qAlJ1PJVdb0nqw3EncU3v/lftBFLC1C98PXfsqx9Nmctkf9KBP
         PiOywUKd9jApp1kZuKHz1LxCz2Ntr1AwA5C56xxoQcS9wf9hSsT722Xqse+MyQNOL8
         V80VheaSJB4H7j1H4s3oPABql/qv6mxrHy4rgTCmTQr4d4+N9KUAyljgCekRpp/dz8
         t1L078mlDpZ3JlnFTW3NKB6qvSoYojKidJU4oPZXl4QAO4bkH1jN+vA8f/o3VRcwrv
         2gTfUee9U3iLzpASeu2XXrvna8ci3cZGJPUA6n8S//XZW5MVzIYyajDfM2UpgcwzfE
         tH8xYDGjBTfwQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org
Subject: [PATCH 4/4] kbuild: srcrpm-pkg: create source package without cleaning
Date:   Sun, 29 Jan 2023 02:38:43 +0900
Message-Id: <20230128173843.765212-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230128173843.765212-1-masahiroy@kernel.org>
References: <20230128173843.765212-1-masahiroy@kernel.org>
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

 scripts/Makefile.package | 50 +++-------------------------------------
 scripts/package/mkspec   |  8 +++----
 2 files changed, 7 insertions(+), 51 deletions(-)

diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index 8fa6f05967aa..b899fe747bc9 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -3,53 +3,11 @@
 
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
-KERNELPATH := kernel-$(subst -,_,$(KERNELRELEASE))
 KDEB_SOURCENAME ?= linux-upstream
 KBUILD_PKG_ROOTCMD ?="fakeroot -u"
 export KDEB_SOURCENAME
-# Include only those top-level files that are needed by make, plus the GPL copy
-TAR_CONTENT := Documentation LICENSES arch block certs crypto drivers fs \
-               include init io_uring ipc kernel lib mm net rust \
-               samples scripts security sound tools usr virt \
-               .config Makefile \
-               Kbuild Kconfig COPYING $(wildcard localversion*)
 MKSPEC     := $(srctree)/scripts/package/mkspec
 
-quiet_cmd_src_tar = TAR     $(2).tar.gz
-      cmd_src_tar = \
-if test "$(objtree)" != "$(srctree)"; then \
-	echo >&2; \
-	echo >&2 "  ERROR:"; \
-	echo >&2 "  Building source tarball is not possible outside the"; \
-	echo >&2 "  kernel source tree. Don't set KBUILD_OUTPUT, or use the"; \
-	echo >&2 "  binrpm-pkg or bindeb-pkg target instead."; \
-	echo >&2; \
-	false; \
-fi ; \
-tar -I $(KGZIP) -c $(RCS_TAR_IGNORE) -f $(2).tar.gz \
-	--transform 's:^:$(2)/:S' $(TAR_CONTENT) $(3)
-
 # Source Tarball
 # ---------------------------------------------------------------------------
 
@@ -76,12 +34,10 @@ rpm-pkg: srcrpm-pkg
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2036BB876
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 16:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbjCOPue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 11:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbjCOPuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 11:50:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0F7193C2;
        Wed, 15 Mar 2023 08:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2655861DD6;
        Wed, 15 Mar 2023 15:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82479C433D2;
        Wed, 15 Mar 2023 15:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678895422;
        bh=MREmtrPYTrtbXEVhwH1tcbWookBujYUv0XZWROUTVDs=;
        h=From:To:Cc:Subject:Date:From;
        b=i03HwWgahUZ7cvVwrD3EQmZKUcDTMZvVyTgqTL6BZU2Vo873ljnGoE38sJ6k7KkII
         lSkNfxHvpdEoKlO86YQzdqGpOag5B9yS47/Wg4Tx/Z1TU6RRhzDmmmU37MKuzn0KbM
         8yow9g8tNmmnOraVQD5azLia8Q3cnOi4GbrA1gwOMxkNtAH45ThLFMLtAgMyZpqKzo
         ePpBPzKv8sQRcXJm198c0NChUvXZtHmrslINsxqVxF+5LybOFuP9ITDTrdluj4VzPE
         QE84qkbzSh9eOtiwudiTNFeXN0/dxKMNG9wcAGWy65sYDC75wGgnmGThpQcYJ8RokJ
         7DRmXZQj5Dn8A==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2 6/7] kbuild: rpm-pkg: move source components to rpmbuild/SOURCES
Date:   Thu, 16 Mar 2023 00:50:17 +0900
Message-Id: <20230315155018.99531-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare to add more files to the source RPM.

Also, fix the build error when KCONFIG_CONFIG is set:
  error: Bad file: ./.config: No such file or directory

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
 - Split into a separate patch

 .gitignore               |  1 +
 Makefile                 |  2 +-
 scripts/Makefile.package |  2 +-
 scripts/package/mkspec   | 12 ++++++++----
 4 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/.gitignore b/.gitignore
index 8fe465f251c0..70ec6037fa7a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -78,6 +78,7 @@ modules.order
 # RPM spec file (make rpm-pkg)
 #
 /*.spec
+/rpmbuild/
 
 #
 # Debian directory (make deb-pkg)
diff --git a/Makefile b/Makefile
index d0a0ba8e5a2e..dfff9f8d28e5 100644
--- a/Makefile
+++ b/Makefile
@@ -1605,7 +1605,7 @@ MRPROPER_FILES += include/config include/generated          \
 		  certs/signing_key.pem \
 		  certs/x509.genkey \
 		  vmlinux-gdb.py \
-		  *.spec \
+		  *.spec rpmbuild \
 		  rust/libmacros.so
 
 # clean - Delete most, but leave enough to build external modules
diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index b941e6341b36..a0355bdeebff 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -89,7 +89,7 @@ PHONY += srcrpm-pkg
 srcrpm-pkg: linux.tar.gz
 	$(CONFIG_SHELL) $(MKSPEC) >$(objtree)/kernel.spec
 	+rpmbuild $(RPMOPTS) --target $(UTS_MACHINE)-linux -bs kernel.spec \
-	--define='_smp_mflags %{nil}' --define='_sourcedir .' --define='_srcrpmdir .'
+	--define='_smp_mflags %{nil}' --define='_sourcedir rpmbuild/SOURCES' --define='_srcrpmdir .'
 
 # binrpm-pkg
 # ---------------------------------------------------------------------------
diff --git a/scripts/package/mkspec b/scripts/package/mkspec
index 3c550960dd39..5f007137f5a0 100755
--- a/scripts/package/mkspec
+++ b/scripts/package/mkspec
@@ -15,15 +15,19 @@ if [ "$1" = prebuilt ]; then
 	MAKE="$MAKE -f $srctree/Makefile"
 else
 	S=
+
+	mkdir -p rpmbuild/SOURCES
+	cp linux.tar.gz rpmbuild/SOURCES
+	cp "${KCONFIG_CONFIG}" rpmbuild/SOURCES/config
 fi
 
-if grep -q CONFIG_MODULES=y .config; then
+if grep -q CONFIG_MODULES=y include/config/auto.conf; then
 	M=
 else
 	M=DEL
 fi
 
-if grep -q CONFIG_DRM=y .config; then
+if grep -q CONFIG_DRM=y include/config/auto.conf; then
 	PROVIDES=kernel-drm
 fi
 
@@ -48,7 +52,7 @@ sed -e '/^DEL/d' -e 's/^\t*//' <<EOF
 	Vendor: The Linux Community
 	URL: https://www.kernel.org
 $S	Source0: linux.tar.gz
-$S	Source1: .config
+$S	Source1: config
 	Provides: $PROVIDES
 $S	BuildRequires: bc binutils bison dwarves
 $S	BuildRequires: (elfutils-libelf-devel or libelf-devel) flex
@@ -85,7 +89,7 @@ $S$M	against the $__KERNELRELEASE kernel package.
 $S$M
 $S	%prep
 $S	%setup -q -n linux
-$S	cp %{SOURCE1} .
+$S	cp %{SOURCE1} .config
 $S
 $S	%build
 $S	$MAKE %{?_smp_mflags} KERNELRELEASE=$KERNELRELEASE KBUILD_BUILD_VERSION=%{release}
-- 
2.34.1


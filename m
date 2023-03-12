Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1726B6AE6
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 21:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjCLUH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 16:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjCLUHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 16:07:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6583E2CC5D;
        Sun, 12 Mar 2023 13:07:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E93FF60FC5;
        Sun, 12 Mar 2023 20:07:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1771C433D2;
        Sun, 12 Mar 2023 20:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678651665;
        bh=Su3scJdModDm3BhC+wn0A6LlLdEtZxRokwKcfkvWOrk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ULNIk25MY76i+mXjqaTN97EPLT7kw60H1du0XM3KfO28bJ7QN8BgB+aLY1ai5Bu6v
         AnG8xseYbhG5pYAVOgcVd8dB5OTyyoTwyO+fe0HR1B87MFL0DdLm+JTIfDSxe1rUyN
         8W8bbdm1hIQXAqJF0bI3xDDAIUtXumGGSeyXSH4Swnn0cpkDG83Z0SZaDUz/5CLbWP
         Zn5tD48H6tCEsWD42N1JsnI6tagQrtaAs1qJL0m0osszJlnAFQwhxPB4jpM/eYuiY/
         eskA0SrxTdmiJl9P+J3+OBgUzV+n80B2hmjVbuGj8I8Vse/YSKphF97+Sa0EnGaO0S
         zZ16H3Ht7edAg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 5/6] kbuild: deb-pkg: use dh_listpackages to know enabled packages
Date:   Mon, 13 Mar 2023 05:07:30 +0900
Message-Id: <20230312200731.599706-6-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230312200731.599706-1-masahiroy@kernel.org>
References: <20230312200731.599706-1-masahiroy@kernel.org>
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

Use dh_listpackages to get a list of all binary packages.

With this, debian/control lists which binary packages will be produced.
Previously, ARCH=um listed linux-libc-dev in debian/control, but it
was not generated because each of mkdebian and builddeb independently
maintained the if-conditionals.

Another motivation is to allow scripts/package/builddeb to get the
package name (linux-image-*, etc.) dynamically from debian/control.

This will also allow the BuildProfile to control the generation of
the binary packages.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/package/builddeb | 61 ++++++++++++++++++++++------------------
 scripts/package/mkdebian |  7 ++++-
 2 files changed, 39 insertions(+), 29 deletions(-)

diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index 906889b304a4..c5ae57167d7c 100755
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -160,7 +160,7 @@ install_linux_image_dbg () {
 	ln -s lib/modules/${KERNELRELEASE}/vmlinux ${pdir}/usr/lib/debug/vmlinux-${KERNELRELEASE}
 }
 
-deploy_kernel_headers () {
+install_kernel_headers () {
 	pdir=$1
 
 	rm -rf $pdir
@@ -198,7 +198,7 @@ deploy_kernel_headers () {
 	ln -s /usr/src/linux-headers-$version $pdir/lib/modules/$version/build
 }
 
-deploy_libc_headers () {
+install_libc_headers () {
 	pdir=$1
 
 	rm -rf $pdir
@@ -213,33 +213,38 @@ deploy_libc_headers () {
 	mv $pdir/usr/include/asm $pdir/usr/include/$host_arch/
 }
 
-version=$KERNELRELEASE
-packagename=linux-image-$version
-dbg_packagename=$packagename-dbg
-
-if [ "$ARCH" = "um" ] ; then
-	packagename=user-mode-linux-$version
-fi
-
 rm -f debian/files
 
-if [ "$ARCH" != "um" ]; then
-	if is_enabled CONFIG_MODULES; then
-		deploy_kernel_headers debian/linux-headers
-		create_package linux-headers-$version debian/linux-headers
-	fi
-
-	deploy_libc_headers debian/linux-libc-dev
-	create_package linux-libc-dev debian/linux-libc-dev
-fi
-
-install_linux_image debian/linux-image "$packagename"
-
-if is_enabled CONFIG_DEBUG_INFO; then
-	install_linux_image_dbg debian/linux-image-dbg debian/linux-image
-	create_package "$dbg_packagename" debian/linux-image-dbg
-fi
-
-create_package "$packagename" debian/linux-image
+packages_enabled=$(dh_listpackages)
+
+for package in ${packages_enabled}
+do
+	case ${package} in
+	*-dbg)
+		# This must be done after linux-image, that is, we expect the
+		# debug package appears after linux-image in debian/control.
+		install_linux_image_dbg debian/linux-image-dbg debian/linux-image;;
+	linux-image-*|user-mode-linux-*)
+		install_linux_image debian/linux-image ${package};;
+	linux-libc-dev)
+		install_libc_headers debian/linux-libc-dev;;
+	linux-headers-*)
+		install_kernel_headers debian/linux-headers;;
+	esac
+done
+
+for package in ${packages_enabled}
+do
+	case ${package} in
+	*-dbg)
+		create_package ${package} debian/linux-image-dbg;;
+	linux-image-*|user-mode-linux-*)
+		create_package ${package} debian/linux-image;;
+	linux-libc-dev)
+		create_package ${package} debian/linux-libc-dev;;
+	linux-headers-*)
+		create_package ${package} debian/linux-headers;;
+	esac
+done
 
 exit 0
diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
index 31b050368cd0..e80a661a79ee 100755
--- a/scripts/package/mkdebian
+++ b/scripts/package/mkdebian
@@ -192,7 +192,7 @@ Section: kernel
 Priority: optional
 Maintainer: $maintainer
 Rules-Requires-Root: no
-Build-Depends: bc, rsync, kmod, cpio, bison, flex $extra_build_depends
+Build-Depends: bc, debhelper, rsync, kmod, cpio, bison, flex $extra_build_depends
 Homepage: https://www.kernel.org/
 
 Package: $packagename-$version
@@ -200,6 +200,10 @@ Architecture: $debarch
 Description: Linux kernel, version $version
  This package contains the Linux kernel, modules and corresponding other
  files, version: $version.
+EOF
+
+if [ "${SRCARCH}" != um ]; then
+cat <<EOF >> debian/control
 
 Package: linux-libc-dev
 Section: devel
@@ -222,6 +226,7 @@ Description: Linux kernel headers for $version on $debarch
  This is useful for people who need to build external modules
 EOF
 fi
+fi
 
 if is_enabled CONFIG_DEBUG_INFO; then
 cat <<EOF >> debian/control
-- 
2.34.1


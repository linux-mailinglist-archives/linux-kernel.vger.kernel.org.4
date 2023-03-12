Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B796B6AE5
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 21:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjCLUHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 16:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjCLUHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 16:07:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8076B2C645;
        Sun, 12 Mar 2023 13:07:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0554E60FB8;
        Sun, 12 Mar 2023 20:07:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8147C4339B;
        Sun, 12 Mar 2023 20:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678651663;
        bh=7GkS17GKl3ZNTSvkKca585P/2hq5bbCvfZPAnQXncoE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YCjMvfW9dYEoxWjXpcJfSb5m8XT2UYoAZQmu4xJNfqkg2qYD4b6AkH0CVULZsSyvM
         wngTq1IEnZK7wOyjmH1739oHUSphgSTLwG2lrmrCLHsWQncsaSJvyEbftczpbjn3Zv
         j5slAF4km3GbLTn5Y2Shl2M8So+WBDgql9RLsFahIg4RsDVNwTnHivQCWDlEhzX5uW
         PImJGbSrw+Z6Uki8Hnd+bsinwqE1CMd88kAMK41xUcEZQIn7LGOlVjxiQ/xfhe6ImY
         COxxaK04Je7w1m2DMJirsYvi9CRsDOHp79/lvyu/Zzu7W3oYATId4YDmM9bgig6mw+
         sPkb54lHvRGZw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 4/6] kbuild: deb-pkg: split image and debug objects staging out into functions
Date:   Mon, 13 Mar 2023 05:07:29 +0900
Message-Id: <20230312200731.599706-5-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230312200731.599706-1-masahiroy@kernel.org>
References: <20230312200731.599706-1-masahiroy@kernel.org>
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

Prepare for the refactoring in the next commit.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/package/builddeb | 222 ++++++++++++++++++++-------------------
 1 file changed, 116 insertions(+), 106 deletions(-)

diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index ff5e7d8e380b..906889b304a4 100755
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -51,6 +51,115 @@ create_package() {
 	dpkg-deb $dpkg_deb_opts ${KDEB_COMPRESS:+-Z$KDEB_COMPRESS} --build "$pdir" ..
 }
 
+install_linux_image () {
+	pdir=$1
+	pname=$2
+
+	rm -rf ${pdir}
+
+	# Only some architectures with OF support have this target
+	if is_enabled CONFIG_OF_EARLY_FLATTREE && [ -d "${srctree}/arch/${SRCARCH}/boot/dts" ]; then
+		${MAKE} -f ${srctree}/Makefile INSTALL_DTBS_PATH="${pdir}/usr/lib/linux-image-${KERNELRELEASE}" dtbs_install
+	fi
+
+	if is_enabled CONFIG_MODULES; then
+		${MAKE} -f ${srctree}/Makefile INSTALL_MOD_PATH="${pdir}" modules_install
+		rm -f "${pdir}/lib/modules/${KERNELRELEASE}/build"
+		rm -f "${pdir}/lib/modules/${KERNELRELEASE}/source"
+		if [ "${SRCARCH}" = um ] ; then
+			mkdir -p "${pdir}/usr/lib/uml/modules"
+			mv "${pdir}/lib/modules/${KERNELRELEASE}" "${pdir}/usr/lib/uml/modules/${KERNELRELEASE}"
+		fi
+	fi
+
+	# Install the kernel
+	if [ "${ARCH}" = um ] ; then
+		mkdir -p "${pdir}/usr/bin" "${pdir}/usr/share/doc/${pname}"
+		cp System.map "${pdir}/usr/lib/uml/modules/${KERNELRELEASE}/System.map"
+		cp ${KCONFIG_CONFIG} "${pdir}/usr/share/doc/${pname}/config"
+		gzip "${pdir}/usr/share/doc/${pname}/config"
+	else
+		mkdir -p "${pdir}/boot"
+		cp System.map "${pdir}/boot/System.map-${KERNELRELEASE}"
+		cp ${KCONFIG_CONFIG} "${pdir}/boot/config-${KERNELRELEASE}"
+	fi
+
+	# Not all arches have the same installed path in debian
+	# XXX: have each arch Makefile export a variable of the canonical image install
+	# path instead
+	case "${SRCARCH}" in
+	um)
+		installed_image_path="usr/bin/linux-${KERNELRELEASE}";;
+	parisc|mips|powerpc)
+		installed_image_path="boot/vmlinux-${KERNELRELEASE}";;
+	*)
+		installed_image_path="boot/vmlinuz-${KERNELRELEASE}";;
+	esac
+	cp "$(${MAKE} -s -f ${srctree}/Makefile image_name)" "${pdir}/${installed_image_path}"
+
+	# Install the maintainer scripts
+	# Note: hook scripts under /etc/kernel are also executed by official Debian
+	# kernel packages, as well as kernel packages built using make-kpkg.
+	# make-kpkg sets $INITRD to indicate whether an initramfs is wanted, and
+	# so do we; recent versions of dracut and initramfs-tools will obey this.
+	debhookdir=${KDEB_HOOKDIR:-/etc/kernel}
+	for script in postinst postrm preinst prerm; do
+		mkdir -p "${pdir}${debhookdir}/${script}.d"
+
+		mkdir -p "${pdir}/DEBIAN"
+		cat <<-EOF > "${pdir}/DEBIAN/${script}"
+
+		#!/bin/sh
+
+		set -e
+
+		# Pass maintainer script parameters to hook scripts
+		export DEB_MAINT_PARAMS="\$*"
+
+		# Tell initramfs builder whether it's wanted
+		export INITRD=$(if_enabled_echo CONFIG_BLK_DEV_INITRD Yes No)
+
+		test -d ${debhookdir}/${script}.d && run-parts --arg="${KERNELRELEASE}" --arg="/${installed_image_path}" ${debhookdir}/${script}.d
+		exit 0
+		EOF
+		chmod 755 "${pdir}/DEBIAN/${script}"
+	done
+}
+
+install_linux_image_dbg () {
+	pdir=$1
+	image_pdir=$2
+
+	rm -rf ${pdir}
+
+	for module in $(find ${image_pdir}/lib/modules/ -name *.ko -printf '%P\n'); do
+		module=lib/modules/${module}
+		mkdir -p $(dirname ${pdir}/usr/lib/debug/${module})
+		# only keep debug symbols in the debug file
+		${OBJCOPY} --only-keep-debug ${image_pdir}/${module} ${pdir}/usr/lib/debug/${module}
+		# strip original module from debug symbols
+		${OBJCOPY} --strip-debug ${image_pdir}/${module}
+		# then add a link to those
+		${OBJCOPY} --add-gnu-debuglink=${pdir}/usr/lib/debug/${module} ${image_pdir}/${module}
+	done
+
+	# re-sign stripped modules
+	if is_enabled CONFIG_MODULE_SIG_ALL; then
+		${MAKE} -f ${srctree}/Makefile INSTALL_MOD_PATH="${image_pdir}" modules_sign
+	fi
+
+	# Build debug package
+	# Different tools want the image in different locations
+	# perf
+	mkdir -p ${pdir}/usr/lib/debug/lib/modules/${KERNELRELEASE}/
+	cp vmlinux ${pdir}/usr/lib/debug/lib/modules/${KERNELRELEASE}/
+	# systemtap
+	mkdir -p ${pdir}/usr/lib/debug/boot/
+	ln -s ../lib/modules/${KERNELRELEASE}/vmlinux ${pdir}/usr/lib/debug/boot/vmlinux-${KERNELRELEASE}
+	# kdump-tools
+	ln -s lib/modules/${KERNELRELEASE}/vmlinux ${pdir}/usr/lib/debug/vmlinux-${KERNELRELEASE}
+}
+
 deploy_kernel_headers () {
 	pdir=$1
 
@@ -105,8 +214,6 @@ deploy_libc_headers () {
 }
 
 version=$KERNELRELEASE
-tmpdir=debian/linux-image
-dbg_dir=debian/linux-image-dbg
 packagename=linux-image-$version
 dbg_packagename=$packagename-dbg
 
@@ -114,97 +221,7 @@ if [ "$ARCH" = "um" ] ; then
 	packagename=user-mode-linux-$version
 fi
 
-# Not all arches have the same installed path in debian
-# XXX: have each arch Makefile export a variable of the canonical image install
-# path instead
-case $ARCH in
-um)
-	installed_image_path="usr/bin/linux-$version"
-	;;
-parisc|mips|powerpc)
-	installed_image_path="boot/vmlinux-$version"
-	;;
-*)
-	installed_image_path="boot/vmlinuz-$version"
-esac
-
-BUILD_DEBUG=$(if_enabled_echo CONFIG_DEBUG_INFO Yes)
-
-# Setup the directory structure
-rm -rf "$tmpdir" "$dbg_dir" debian/files
-mkdir -m 755 -p "$tmpdir/DEBIAN"
-mkdir -p "$tmpdir/lib" "$tmpdir/boot"
-
-# Install the kernel
-if [ "$ARCH" = "um" ] ; then
-	mkdir -p "$tmpdir/usr/lib/uml/modules/$version" "$tmpdir/usr/bin" "$tmpdir/usr/share/doc/$packagename"
-	cp System.map "$tmpdir/usr/lib/uml/modules/$version/System.map"
-	cp $KCONFIG_CONFIG "$tmpdir/usr/share/doc/$packagename/config"
-	gzip "$tmpdir/usr/share/doc/$packagename/config"
-else
-	cp System.map "$tmpdir/boot/System.map-$version"
-	cp $KCONFIG_CONFIG "$tmpdir/boot/config-$version"
-fi
-cp "$($MAKE -s -f $srctree/Makefile image_name)" "$tmpdir/$installed_image_path"
-
-if is_enabled CONFIG_OF_EARLY_FLATTREE; then
-	# Only some architectures with OF support have this target
-	if [ -d "${srctree}/arch/$SRCARCH/boot/dts" ]; then
-		$MAKE -f $srctree/Makefile INSTALL_DTBS_PATH="$tmpdir/usr/lib/$packagename" dtbs_install
-	fi
-fi
-
-if is_enabled CONFIG_MODULES; then
-	INSTALL_MOD_PATH="$tmpdir" $MAKE -f $srctree/Makefile modules_install
-	rm -f "$tmpdir/lib/modules/$version/build"
-	rm -f "$tmpdir/lib/modules/$version/source"
-	if [ "$ARCH" = "um" ] ; then
-		mv "$tmpdir/lib/modules/$version"/* "$tmpdir/usr/lib/uml/modules/$version/"
-		rmdir "$tmpdir/lib/modules/$version"
-	fi
-	if [ -n "$BUILD_DEBUG" ] ; then
-		for module in $(find $tmpdir/lib/modules/ -name *.ko -printf '%P\n'); do
-			module=lib/modules/$module
-			mkdir -p $(dirname $dbg_dir/usr/lib/debug/$module)
-			# only keep debug symbols in the debug file
-			$OBJCOPY --only-keep-debug $tmpdir/$module $dbg_dir/usr/lib/debug/$module
-			# strip original module from debug symbols
-			$OBJCOPY --strip-debug $tmpdir/$module
-			# then add a link to those
-			$OBJCOPY --add-gnu-debuglink=$dbg_dir/usr/lib/debug/$module $tmpdir/$module
-		done
-
-		# resign stripped modules
-		if is_enabled CONFIG_MODULE_SIG_ALL; then
-			INSTALL_MOD_PATH="$tmpdir" $MAKE -f $srctree/Makefile modules_sign
-		fi
-	fi
-fi
-
-# Install the maintainer scripts
-# Note: hook scripts under /etc/kernel are also executed by official Debian
-# kernel packages, as well as kernel packages built using make-kpkg.
-# make-kpkg sets $INITRD to indicate whether an initramfs is wanted, and
-# so do we; recent versions of dracut and initramfs-tools will obey this.
-debhookdir=${KDEB_HOOKDIR:-/etc/kernel}
-for script in postinst postrm preinst prerm ; do
-	mkdir -p "$tmpdir$debhookdir/$script.d"
-	cat <<EOF > "$tmpdir/DEBIAN/$script"
-#!/bin/sh
-
-set -e
-
-# Pass maintainer script parameters to hook scripts
-export DEB_MAINT_PARAMS="\$*"
-
-# Tell initramfs builder whether it's wanted
-export INITRD=$(if_enabled_echo CONFIG_BLK_DEV_INITRD Yes No)
-
-test -d $debhookdir/$script.d && run-parts --arg="$version" --arg="/$installed_image_path" $debhookdir/$script.d
-exit 0
-EOF
-	chmod 755 "$tmpdir/DEBIAN/$script"
-done
+rm -f debian/files
 
 if [ "$ARCH" != "um" ]; then
 	if is_enabled CONFIG_MODULES; then
@@ -216,20 +233,13 @@ if [ "$ARCH" != "um" ]; then
 	create_package linux-libc-dev debian/linux-libc-dev
 fi
 
-create_package "$packagename" "$tmpdir"
+install_linux_image debian/linux-image "$packagename"
 
-if [ -n "$BUILD_DEBUG" ] ; then
-	# Build debug package
-	# Different tools want the image in different locations
-	# perf
-	mkdir -p $dbg_dir/usr/lib/debug/lib/modules/$version/
-	cp vmlinux $dbg_dir/usr/lib/debug/lib/modules/$version/
-	# systemtap
-	mkdir -p $dbg_dir/usr/lib/debug/boot/
-	ln -s ../lib/modules/$version/vmlinux $dbg_dir/usr/lib/debug/boot/vmlinux-$version
-	# kdump-tools
-	ln -s lib/modules/$version/vmlinux $dbg_dir/usr/lib/debug/vmlinux-$version
-	create_package "$dbg_packagename" "$dbg_dir"
+if is_enabled CONFIG_DEBUG_INFO; then
+	install_linux_image_dbg debian/linux-image-dbg debian/linux-image
+	create_package "$dbg_packagename" debian/linux-image-dbg
 fi
 
+create_package "$packagename" debian/linux-image
+
 exit 0
-- 
2.34.1


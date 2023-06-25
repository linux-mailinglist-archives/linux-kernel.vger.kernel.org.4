Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8194F73D2E7
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 20:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjFYSQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 14:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFYSQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 14:16:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2C91B9;
        Sun, 25 Jun 2023 11:16:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 893AD60BFC;
        Sun, 25 Jun 2023 18:16:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F47C433C0;
        Sun, 25 Jun 2023 18:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687716993;
        bh=n9VaGSVflGs2NZDQUV1xewtUL+wrQ9Xx5IQp2n1jwAY=;
        h=From:To:Cc:Subject:Date:From;
        b=ABISlHKjVWp6QGmiA4Utc6/kxfr7dMWP5j68xqZXgOQTOfKr7XY95IT4OWBXyHFYG
         D6eZVM6E2mj82/0mwhMPz9oErzt+CIctzSLCX74LSgSuoQt91ZWiF6pJEE4IUF2YMC
         oG8XBBXfY/Z5PEiI78ni/5D/U5Gsby+dwOfh3tXkeQgOFiJHFdFMjScOb/yl99SM22
         CsuLs3OL1dZcDrvGXY249cfQayG1Tg9s+/qqWquKONlTUYmeiJ1aXvqaPDDkbc3bQq
         ANWhMuhKIaZFRoN9iarg2pN1lWmGHQtoAactpS6DbrYsp3f15RNpj8Ujkh/lkspDpW
         Un6Aq9leNNeCA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH] kbuild: deb-pkg: remove the CONFIG_MODULES check in buildeb
Date:   Mon, 26 Jun 2023 03:16:23 +0900
Message-Id: <20230625181623.2473308-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_MODULES is disabled for ARCH=um, 'make (bin)deb-pkg' fails
with an error like follows:

  cp: cannot create regular file 'debian/linux-image/usr/lib/uml/modules/6.4.0-rc2+/System.map': No such file or directory

Remove the CONFIG_MODULES check completely to always create the directory
${pdir}/usr/lib/uml/modules for ARCH=um.

Fixes: b611daae5efc ("kbuild: deb-pkg: split image and debug objects staging out into functions")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/package/builddeb | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index e3109e67c33e..bf3f8561aa68 100755
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -63,17 +63,13 @@ install_linux_image () {
 	fi
 
 	${MAKE} -f ${srctree}/Makefile INSTALL_MOD_PATH="${pdir}" modules_install
-	if is_enabled CONFIG_MODULES; then
-		rm -f "${pdir}/lib/modules/${KERNELRELEASE}/build"
-		rm -f "${pdir}/lib/modules/${KERNELRELEASE}/source"
-		if [ "${SRCARCH}" = um ] ; then
-			mkdir -p "${pdir}/usr/lib/uml/modules"
-			mv "${pdir}/lib/modules/${KERNELRELEASE}" "${pdir}/usr/lib/uml/modules/${KERNELRELEASE}"
-		fi
-	fi
+	rm -f "${pdir}/lib/modules/${KERNELRELEASE}/build"
+	rm -f "${pdir}/lib/modules/${KERNELRELEASE}/source"
 
 	# Install the kernel
 	if [ "${ARCH}" = um ] ; then
+		mkdir -p "${pdir}/usr/lib/uml/modules"
+		mv "${pdir}/lib/modules/${KERNELRELEASE}" "${pdir}/usr/lib/uml/modules/${KERNELRELEASE}"
 		mkdir -p "${pdir}/usr/bin" "${pdir}/usr/share/doc/${pname}"
 		cp System.map "${pdir}/usr/lib/uml/modules/${KERNELRELEASE}/System.map"
 		cp ${KCONFIG_CONFIG} "${pdir}/usr/share/doc/${pname}/config"
-- 
2.39.2


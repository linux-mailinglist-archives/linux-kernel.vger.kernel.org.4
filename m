Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9DB6B6AE1
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 21:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjCLUHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 16:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjCLUHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 16:07:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B899F2B62A;
        Sun, 12 Mar 2023 13:07:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 621F1B800C1;
        Sun, 12 Mar 2023 20:07:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47CAFC433D2;
        Sun, 12 Mar 2023 20:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678651659;
        bh=SI4KrO3CvzpG6Y/Rp16w4y1l1Nd7kr9KP+ChdCjrOeQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q+2+5fa4v5cYlQ+p8KguN3K7xXgWQIobJ2DE5WgySuLDWDLzGbbxshaX1ghB0jkr7
         m3YLN0RteXm6hDcZg3v4FZ7sjF3qtdIAarJBhPULG8oOhBmCZjttqV9Xoo/yuxgMSN
         Ol6FN4QbtZsX7d+vECxsqA2KNkxFs15uW2nutkX6JpdxCj5aSlcLsDrYR0+pRfTOAt
         VDc5HxOrtSQqiYyEE700/fGWmCputAxGbFNAiRStl8mkidc21cnpt9/eE+0M4lKRh5
         eY6qdcgHPd2flcem3+Bsxn56zAY0U/GjbZYvctLX8dd/w3X2Ho65J6G++DvzmEUSRb
         qfuY7rkhyEwHw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 2/6] kbuild: deb-pkg: do not take KERNELRELEASE from the source version
Date:   Mon, 13 Mar 2023 05:07:27 +0900
Message-Id: <20230312200731.599706-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230312200731.599706-1-masahiroy@kernel.org>
References: <20230312200731.599706-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KERNELRELEASE does not need to match the package version in changelog.
Rather, it conventially matches what is called 'ABINAME', which is a
part of the binary package names.

Both are the same by default, but the former might be overridden by
KDEB_PKGVERSION. In this case, the resulting package would not boot
because /lib/modules/$(uname -r) does not point the module directory.

Partially revert 3ab18a625ce4 ("kbuild: deb-pkg: improve the usability
of source package").

Reported-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Fixes: 3ab18a625ce4 ("kbuild: deb-pkg: improve the usability of source package")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/package/deb-build-option | 9 ++++-----
 scripts/package/mkdebian         | 1 +
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/scripts/package/deb-build-option b/scripts/package/deb-build-option
index b079b0d121d4..bd53624318f2 100755
--- a/scripts/package/deb-build-option
+++ b/scripts/package/deb-build-option
@@ -8,9 +8,8 @@ if [ -z "${CROSS_COMPILE}${cross_compiling}" -a "${DEB_HOST_ARCH}" != "${DEB_BUI
 fi
 
 version=$(dpkg-parsechangelog -S Version)
-version_upstream="${version%-*}"
-debian_revision="${version#${version_upstream}}"
-debian_revision="${debian_revision#*-}"
+debian_revision="${version##*-}"
 
-echo KERNELRELEASE=${version_upstream}
-echo KBUILD_BUILD_VERSION=${debian_revision}
+if [ "${version}" != "${debian_revision}" ]; then
+	echo KBUILD_BUILD_VERSION=${debian_revision}
+fi
diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
index c6fbfb9f74ba..31b050368cd0 100755
--- a/scripts/package/mkdebian
+++ b/scripts/package/mkdebian
@@ -244,6 +244,7 @@ KERNELRELEASE = ${KERNELRELEASE}
 build-indep:
 build-arch:
 	\$(MAKE) -f \$(srctree)/Makefile ARCH=${ARCH} \
+	KERNELRELEASE=\$(KERNELRELEASE) \
 	\$(shell \$(srctree)/scripts/package/deb-build-option) \
 	olddefconfig all
 
-- 
2.34.1


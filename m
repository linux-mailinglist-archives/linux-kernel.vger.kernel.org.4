Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5855E6B67
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 21:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbiIVTDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 15:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiIVTDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 15:03:14 -0400
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 22 Sep 2022 12:03:12 PDT
Received: from letterbox.kde.org (letterbox.kde.org [46.43.1.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B35BFB300;
        Thu, 22 Sep 2022 12:03:12 -0700 (PDT)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net [173.49.113.140])
        (Authenticated sender: zack)
        by letterbox.kde.org (Postfix) with ESMTPSA id 68B6B33CA5E;
        Thu, 22 Sep 2022 19:45:29 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kde.org; s=users;
        t=1663872330; bh=KXR8aFo7IH4MA/ibI65C7sV8IgOxAzdBucUz3STBYMM=;
        h=From:To:Cc:Subject:Date:From;
        b=Wzq8w4AZNvIbdNn4rk/xDh84qL1TfMVadvxauUIhNwLpn3o4LW1oYVbM4c0sk2mJm
         kEP9lU8cqqdVUZ3ehX4kZbGtqdQDv4hleu646pjsfY0uKFPjPRByZ3TBhoFkCTtDUw
         +03D8PjyYTBYzn2cBFHG1mYAO770Co+jehX+ybDG4YIg/EW/aHIlY7DFFT+9YYrQSL
         RTEdZLTHFTLGgD4LyU8rbC5rzrpIZHuLNSCC7tuAA3FgnT0nigr/FYE6+MO5/cldzb
         Mk4Z414+ofgPrn7qUw2Wx32Bk93tJsnbGVU28coR8TWc05GdGk+aUpMrVMHDWeJjpQ
         FtHwIylLSiCOw==
From:   Zack Rusin <zack@kde.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Zack Rusin <zackr@vmware.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: Add an option to skip vmlinux.bz2 in the rpm's
Date:   Thu, 22 Sep 2022 14:45:25 -0400
Message-Id: <20220922184525.3021522-1-zack@kde.org>
X-Mailer: git-send-email 2.34.1
Reply-To: Zack Rusin <zackr@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zack Rusin <zackr@vmware.com>

The debug vmlinux takes up the vast majority of space in the built
rpm's. While having it enabled by default is a good idea because it
makes debugging easier, having an option to skip it is highly valuable
for CI/CD systems where small packages are a lot easier to deal with
e.g. kernel rpm built using binrpm-pkg on Fedora 36 default 5.19.8 kernel
config and localmodconfig goes from 255MB to 65MB which is an almost
4x difference.

To skip adding vmlinux.bz2 to the built rpm add SKIP_RPM_VMLINUX
environment variable which when set to "y", e.g. via
"SKIP_RPM_VMLINUX=y make binrpm-pkg" won't include vmlinux.bz2 in the
built rpm.

Signed-off-by: Zack Rusin <zackr@vmware.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 scripts/package/mkspec | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/scripts/package/mkspec b/scripts/package/mkspec
index 7c477ca7dc98..5a71fc0852b0 100755
--- a/scripts/package/mkspec
+++ b/scripts/package/mkspec
@@ -23,6 +23,12 @@ else
 	M=DEL
 fi
 
+if [ "$RPM_SKIP_VMLINUX" = y ]; then
+	D=DEL
+else
+	D=
+fi
+
 if grep -q CONFIG_DRM=y .config; then
 	PROVIDES=kernel-drm
 fi
@@ -94,8 +100,8 @@ $M	$MAKE %{?_smp_mflags} INSTALL_MOD_PATH=%{buildroot} modules_install
 	$MAKE %{?_smp_mflags} INSTALL_HDR_PATH=%{buildroot}/usr headers_install
 	cp System.map %{buildroot}/boot/System.map-$KERNELRELEASE
 	cp .config %{buildroot}/boot/config-$KERNELRELEASE
-	bzip2 -9 --keep vmlinux
-	mv vmlinux.bz2 %{buildroot}/boot/vmlinux-$KERNELRELEASE.bz2
+$D	bzip2 -9 --keep vmlinux
+$D	mv vmlinux.bz2 %{buildroot}/boot/vmlinux-$KERNELRELEASE.bz2
 $S$M	rm -f %{buildroot}/lib/modules/$KERNELRELEASE/build
 $S$M	rm -f %{buildroot}/lib/modules/$KERNELRELEASE/source
 $S$M	mkdir -p %{buildroot}/usr/src/kernels/$KERNELRELEASE
-- 
2.34.1


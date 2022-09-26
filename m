Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0685E994B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 08:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbiIZGLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 02:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiIZGLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 02:11:06 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DE827B1F;
        Sun, 25 Sep 2022 23:11:03 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MbXLv4MynzHtfk;
        Mon, 26 Sep 2022 14:06:15 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 14:11:01 +0800
Received: from huawei.com (10.67.175.34) by dggpeml500008.china.huawei.com
 (7.185.36.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 26 Sep
 2022 14:11:01 +0800
From:   Ren Zhijie <renzhijie2@huawei.com>
To:     <prabhakar.csengg@gmail.com>, <mchehab@kernel.org>,
        <gregkh@linuxfoundation.org>, <hverkuil-cisco@xs4all.nl>
CC:     <linux-media@vger.kernel.org>, <linux-staging@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, Ren Zhijie <renzhijie2@huawei.com>
Subject: [PATCH -next] media: davinci: Fix Kconfig dependency
Date:   Mon, 26 Sep 2022 06:07:26 +0000
Message-ID: <20220926060726.44556-1-renzhijie2@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.34]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500008.china.huawei.com (7.185.36.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_VIDEO_DAVINCI_VPBE_DISPLAY is not set,
make ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu-,
will be failed, like this:

drivers/staging/media/deprecated/vpfe_capture/dm644x_ccdc.o: In function `ccdc_configure':
dm644x_ccdc.c:(.text+0xa46): undefined reference to `vpss_clear_wbl_overflow'
dm644x_ccdc.c:(.text+0xd46): undefined reference to `vpss_clear_wbl_overflow'
drivers/staging/media/deprecated/vpfe_capture/dm644x_ccdc.o: In function `ccdc_sbl_reset':
dm644x_ccdc.c:(.text+0x696): undefined reference to `vpss_clear_wbl_overflow'
drivers/staging/media/deprecated/vpfe_capture/dm355_ccdc.o: In function `ccdc_restore_defaults':
dm355_ccdc.c:(.text+0x43a): undefined reference to `vpss_select_ccdc_source'
dm355_ccdc.c:(.text+0x453): undefined reference to `vpss_enable_clock'
drivers/staging/media/deprecated/vpfe_capture/dm355_ccdc.o: In function `ccdc_close':
dm355_ccdc.c:(.text+0x475): undefined reference to `vpss_enable_clock'
drivers/staging/media/deprecated/vpfe_capture/isif.o: In function `isif_open':
isif.c:(.text+0x654): undefined reference to `vpss_enable_clock'
isif.c:(.text+0x663): undefined reference to `vpss_enable_clock'
isif.c:(.text+0x672): undefined reference to `vpss_enable_clock'
isif.c:(.text+0x67e): undefined reference to `vpss_select_ccdc_source'
drivers/staging/media/deprecated/vpfe_capture/isif.o: In function `isif_configure':
isif.c:(.text+0xe61): undefined reference to `dm365_vpss_set_sync_pol'
isif.c:(.text+0xe7b): undefined reference to `dm365_vpss_set_pg_frame_size'
isif.c:(.text+0xe85): undefined reference to `vpss_select_ccdc_source'

Add select VIDEO_DAVINCI_VPBE_DISPLAY dependency to Kconfig.

Fixes: 6971757bdccc ("media: davinci: deprecate dm644x_ccdc, dm355_cddc and dm365_isif")
Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
---
 drivers/staging/media/deprecated/vpfe_capture/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/media/deprecated/vpfe_capture/Kconfig b/drivers/staging/media/deprecated/vpfe_capture/Kconfig
index 10250e7e566b..63a0808ed104 100644
--- a/drivers/staging/media/deprecated/vpfe_capture/Kconfig
+++ b/drivers/staging/media/deprecated/vpfe_capture/Kconfig
@@ -6,6 +6,7 @@ config VIDEO_DM6446_CCDC
 	depends on ARCH_DAVINCI || COMPILE_TEST
 	depends on I2C
 	select VIDEOBUF_DMA_CONTIG
+	select VIDEO_DAVINCI_VPBE_DISPLAY
 	help
 	  Enables DaVinci CCD hw module. DaVinci CCDC hw interfaces
 	  with decoder modules such as TVP5146 over BT656 or
@@ -26,6 +27,7 @@ config VIDEO_DM355_CCDC
 	depends on ARCH_DAVINCI || COMPILE_TEST
 	depends on I2C
 	select VIDEOBUF_DMA_CONTIG
+	select VIDEO_DAVINCI_VPBE_DISPLAY
 	help
 	  Enables DM355 CCD hw module. DM355 CCDC hw interfaces
 	  with decoder modules such as TVP5146 over BT656 or
@@ -46,6 +48,7 @@ config VIDEO_DM365_ISIF
 	depends on ARCH_DAVINCI || COMPILE_TEST
 	depends on I2C
 	select VIDEOBUF_DMA_CONTIG
+	select VIDEO_DAVINCI_VPBE_DISPLAY
 	help
 	  Enables ISIF hw module. This is the hardware module for
 	  configuring ISIF in VPFE to capture Raw Bayer RGB data from
-- 
2.17.1


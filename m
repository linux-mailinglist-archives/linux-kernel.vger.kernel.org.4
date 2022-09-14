Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5695B7F94
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 05:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiINDkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 23:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiINDkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 23:40:11 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A39C564CC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 20:40:01 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MS5bG2hplzcn58;
        Wed, 14 Sep 2022 11:36:10 +0800 (CST)
Received: from dggpeml500010.china.huawei.com (7.185.36.155) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 14 Sep 2022 11:39:55 +0800
Received: from huawei.com (10.67.175.33) by dggpeml500010.china.huawei.com
 (7.185.36.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 14 Sep
 2022 11:39:55 +0800
From:   Lin Yujun <linyujun809@huawei.com>
To:     <daniel@zonque.org>, <haojian.zhuang@gmail.com>,
        <robert.jarzmik@free.fr>, <linux@armlinux.org.uk>,
        <eric.miao@marvell.com>, <krzysztof.h1@wp.pl>,
        <jayakumar.lkml@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] [ARM] am200epd: Release platform device in case of platform_device_add_data() fails
Date:   Wed, 14 Sep 2022 11:36:21 +0800
Message-ID: <20220914033621.99499-1-linyujun809@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.33]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500010.china.huawei.com (7.185.36.155)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform resources need to be released when platform_device_add_data()
fails. Release the platform device and unregister the client notifier like
the error handling of platform_device_add().

Fixes: 922613436ae5 ("[ARM] 5200/1: am200epd: use fb notifiers and gpio api")
Signed-off-by: Lin Yujun <linyujun809@huawei.com>
---
 arch/arm/mach-pxa/am200epd.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/am200epd.c b/arch/arm/mach-pxa/am200epd.c
index cac0bb09db14..069b90df0759 100644
--- a/arch/arm/mach-pxa/am200epd.c
+++ b/arch/arm/mach-pxa/am200epd.c
@@ -370,12 +370,16 @@ int __init am200_init(void)
 		return -ENOMEM;
 
 	/* the am200_board that will be seen by metronomefb is a copy */
-	platform_device_add_data(am200_device, &am200_board,
+	ret = platform_device_add_data(am200_device, &am200_board,
 					sizeof(am200_board));
+	if (ret) {
+		platform_device_put(am200_device);
+		fb_unregister_client(&am200_fb_notif);
+		return ret;
+	}
 
 	/* this _add binds metronomefb to am200. metronomefb refcounts am200 */
 	ret = platform_device_add(am200_device);
-
 	if (ret) {
 		platform_device_put(am200_device);
 		fb_unregister_client(&am200_fb_notif);
-- 
2.17.1


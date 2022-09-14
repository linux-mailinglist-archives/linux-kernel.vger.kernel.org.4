Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB65B5B7F89
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 05:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiINDhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 23:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiINDgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 23:36:54 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720AF5FAFC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 20:36:52 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MS5Vl2KhZzNm7X;
        Wed, 14 Sep 2022 11:32:15 +0800 (CST)
Received: from dggpeml500010.china.huawei.com (7.185.36.155) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 14 Sep 2022 11:36:50 +0800
Received: from huawei.com (10.67.175.33) by dggpeml500010.china.huawei.com
 (7.185.36.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 14 Sep
 2022 11:36:50 +0800
From:   Lin Yujun <linyujun809@huawei.com>
To:     <daniel@zonque.org>, <haojian.zhuang@gmail.com>,
        <robert.jarzmik@free.fr>, <linux@armlinux.org.uk>, <lg@denx.de>,
        <eric.miao@marvell.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] ARM pxa2xx: Add missing platform_device_put() in pxa2xx_set_spi_info()
Date:   Wed, 14 Sep 2022 11:33:17 +0800
Message-ID: <20220914033317.98469-1-linyujun809@huawei.com>
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

In error case in pxa2xx_set_spi_info() after calling
platform_device_add(), the failed 'pdev' need to be
release or it will be leak, call platform_device_put()
to fix this problem.

Fixes: e172274ccc55 ("[ARM] 5088/3: pxa2xx: add pxa2xx_set_spi_info to register pxa2xx-spi platform devices")
Signed-off-by: Lin Yujun <linyujun809@huawei.com>
---
 arch/arm/mach-pxa/devices.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index a7b92dd1ca9e..2727f0138758 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -1087,7 +1087,11 @@ void __init pxa2xx_set_spi_info(unsigned id, struct pxa2xx_spi_controller *info)
 	}
 
 	pd->dev.platform_data = info;
-	platform_device_add(pd);
+	if (platform_device_add(pd)) {
+		printk(KERN_ERR "pxa2xx-spi: failed to add platform device %d\n",
+			id);
+		platform_device_put(pd);
+	}
 }
 
 static struct resource pxa_dma_resource[] = {
-- 
2.17.1


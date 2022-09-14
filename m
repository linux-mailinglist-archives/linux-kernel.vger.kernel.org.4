Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A662D5B7F5E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 05:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiIND2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 23:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiIND2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 23:28:15 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9132496F
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 20:28:14 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MS5KW4GbhzlVkv;
        Wed, 14 Sep 2022 11:24:15 +0800 (CST)
Received: from dggpeml500010.china.huawei.com (7.185.36.155) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 14 Sep 2022 11:28:11 +0800
Received: from huawei.com (10.67.175.33) by dggpeml500010.china.huawei.com
 (7.185.36.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 14 Sep
 2022 11:28:11 +0800
From:   Lin Yujun <linyujun809@huawei.com>
To:     <lkundrak@v3.sk>, <linux@armlinux.org.uk>, <arnd@arndb.de>,
        <eric.miao@marvell.com>, <chagas@marvell.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] pxa: Release platform device in case of platform_device_add() fails.
Date:   Wed, 14 Sep 2022 11:24:37 +0800
Message-ID: <20220914032437.95609-1-linyujun809@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.33]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

The platform device is not released when platform_device_add()
fails. Use platform_device_put() to release these resource.

Fixes: 49cbe78637eb ("[ARM] pxa: add base support for Marvell's PXA168 processor line")
Signed-off-by: Lin Yujun <linyujun809@huawei.com>
---
 arch/arm/mach-mmp/devices.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-mmp/devices.c b/arch/arm/mach-mmp/devices.c
index 79f4a2aa5475..e918f419bc4c 100644
--- a/arch/arm/mach-mmp/devices.c
+++ b/arch/arm/mach-mmp/devices.c
@@ -53,20 +53,23 @@ int __init mmp_register_device(struct mmp_device_desc *desc,
 	}
 
 	ret = platform_device_add_resources(pdev, res, nres);
-	if (ret) {
-		platform_device_put(pdev);
-		return ret;
-	}
+	if (ret)
+		goto err_put_pdev;
 
 	if (data && size) {
 		ret = platform_device_add_data(pdev, data, size);
-		if (ret) {
-			platform_device_put(pdev);
-			return ret;
-		}
+		if (ret)
+			goto err_put_pdev;
 	}
 
-	return platform_device_add(pdev);
+	ret = platform_device_add(pdev);
+	if (ret)
+		goto err_put_pdev;
+	return ret;
+
+err_put_pdev:
+	platform_device_put(pdev);
+	return ret;
 }
 
 #if IS_ENABLED(CONFIG_USB) || IS_ENABLED(CONFIG_USB_GADGET)
-- 
2.17.1


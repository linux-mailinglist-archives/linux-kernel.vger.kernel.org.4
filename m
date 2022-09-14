Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D765B7F70
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 05:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiINDc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 23:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiINDcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 23:32:54 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694705A8B0;
        Tue, 13 Sep 2022 20:32:52 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MS5SK2j7pznTwp;
        Wed, 14 Sep 2022 11:30:09 +0800 (CST)
Received: from dggpeml500010.china.huawei.com (7.185.36.155) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 14 Sep 2022 11:32:50 +0800
Received: from huawei.com (10.67.175.33) by dggpeml500010.china.huawei.com
 (7.185.36.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 14 Sep
 2022 11:32:50 +0800
From:   Lin Yujun <linyujun809@huawei.com>
To:     <tsbogend@alpha.franken.de>, <christophe.jaillet@wanadoo.fr>,
        <paulburton@kernel.org>
CC:     <linux-mips@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] MIPS: SGI-IP27: Fix platform-device leak in bridge_platform_create()
Date:   Wed, 14 Sep 2022 11:29:17 +0800
Message-ID: <20220914032917.97203-1-linyujun809@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.33]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

In error case in bridge_platform_create after calling
platform_device_add()/platform_device_add_data()/
platform_device_add_resources(), release the failed
'pdev' or it will be leak, call platform_device_put()
to fix this problem.

Besides, 'pdev' is divided into 'pdev_wd' and 'pdev_bd',
use platform_device_unregister() to release sgi_w1
resources when xtalk-bridge registration fails.

Fixes: 5dc76a96e95a ("MIPS: PCI: use information from 1-wire PROM for IOC3 detection")
Signed-off-by: Lin Yujun <linyujun809@huawei.com>
---
 arch/mips/sgi-ip27/ip27-xtalk.c | 70 +++++++++++++++++++++++----------
 1 file changed, 50 insertions(+), 20 deletions(-)

diff --git a/arch/mips/sgi-ip27/ip27-xtalk.c b/arch/mips/sgi-ip27/ip27-xtalk.c
index e762886d1dda..5143d1cf8984 100644
--- a/arch/mips/sgi-ip27/ip27-xtalk.c
+++ b/arch/mips/sgi-ip27/ip27-xtalk.c
@@ -27,15 +27,18 @@ static void bridge_platform_create(nasid_t nasid, int widget, int masterwid)
 {
 	struct xtalk_bridge_platform_data *bd;
 	struct sgi_w1_platform_data *wd;
-	struct platform_device *pdev;
+	struct platform_device *pdev_wd;
+	struct platform_device *pdev_bd;
 	struct resource w1_res;
 	unsigned long offset;
 
 	offset = NODE_OFFSET(nasid);
 
 	wd = kzalloc(sizeof(*wd), GFP_KERNEL);
-	if (!wd)
-		goto no_mem;
+	if (!wd) {
+		pr_warn("xtalk:n%d/%x bridge create out of memory\n", nasid, widget);
+		return;
+	}
 
 	snprintf(wd->dev_id, sizeof(wd->dev_id), "bridge-%012lx",
 		 offset + (widget << SWIN_SIZE_BITS));
@@ -46,24 +49,35 @@ static void bridge_platform_create(nasid_t nasid, int widget, int masterwid)
 	w1_res.end = w1_res.start + 3;
 	w1_res.flags = IORESOURCE_MEM;
 
-	pdev = platform_device_alloc("sgi_w1", PLATFORM_DEVID_AUTO);
-	if (!pdev) {
-		kfree(wd);
-		goto no_mem;
+	pdev_wd = platform_device_alloc("sgi_w1", PLATFORM_DEVID_AUTO);
+	if (!pdev_wd) {
+		pr_warn("xtalk:n%d/%x bridge create out of memory\n", nasid, widget);
+		goto err_kfree_wd;
+	}
+	if (platform_device_add_resources(pdev_wd, &w1_res, 1)) {
+		pr_warn("xtalk:n%d/%x bridge failed to add platform resources.\n", nasid, widget);
+		goto err_put_pdev_wd;
+	}
+	if (platform_device_add_data(pdev_wd, wd, sizeof(*wd))) {
+		pr_warn("xtalk:n%d/%x bridge failed to add platform data.\n", nasid, widget);
+		goto err_put_pdev_wd;
+	}
+	if (platform_device_add(pdev_wd)) {
+		pr_warn("xtalk:n%d/%x bridge failed to add platform device.\n", nasid, widget);
+		goto err_put_pdev_wd;
 	}
-	platform_device_add_resources(pdev, &w1_res, 1);
-	platform_device_add_data(pdev, wd, sizeof(*wd));
 	/* platform_device_add_data() duplicates the data */
 	kfree(wd);
-	platform_device_add(pdev);
 
 	bd = kzalloc(sizeof(*bd), GFP_KERNEL);
-	if (!bd)
-		goto no_mem;
-	pdev = platform_device_alloc("xtalk-bridge", PLATFORM_DEVID_AUTO);
-	if (!pdev) {
-		kfree(bd);
-		goto no_mem;
+	if (!bd) {
+		pr_warn("xtalk:n%d/%x bridge create out of memory\n", nasid, widget);
+		goto err_unregister_pdev_wd;
+	}
+	pdev_bd = platform_device_alloc("xtalk-bridge", PLATFORM_DEVID_AUTO);
+	if (!pdev_bd) {
+		pr_warn("xtalk:n%d/%x bridge create out of memory\n", nasid, widget);
+		goto err_kfree_bd;
 	}
 
 
@@ -84,15 +98,31 @@ static void bridge_platform_create(nasid_t nasid, int widget, int masterwid)
 	bd->io.flags	= IORESOURCE_IO;
 	bd->io_offset	= offset;
 
-	platform_device_add_data(pdev, bd, sizeof(*bd));
+	if (platform_device_add_data(pdev_bd, bd, sizeof(*bd))) {
+		pr_warn("xtalk:n%d/%x bridge failed to add platform data.\n", nasid, widget);
+		goto err_put_pdev_bd;
+	}
+	if (platform_device_add(pdev_bd)) {
+		pr_warn("xtalk:n%d/%x bridge failed to add platform device.\n", nasid, widget);
+		goto err_put_pdev_bd;
+	}
 	/* platform_device_add_data() duplicates the data */
 	kfree(bd);
-	platform_device_add(pdev);
 	pr_info("xtalk:n%d/%x bridge widget\n", nasid, widget);
 	return;
 
-no_mem:
-	pr_warn("xtalk:n%d/%x bridge create out of memory\n", nasid, widget);
+err_put_pdev_bd:
+	platform_device_put(pdev_bd);
+err_kfree_bd:
+	kfree(bd);
+err_unregister_pdev_wd:
+	platform_device_unregister(pdev_wd);
+	return;
+err_put_pdev_wd:
+	platform_device_put(pdev_wd);
+err_kfree_wd:
+	kfree(wd);
+	return;
 }
 
 static int probe_one_port(nasid_t nasid, int widget, int masterwid)
-- 
2.17.1


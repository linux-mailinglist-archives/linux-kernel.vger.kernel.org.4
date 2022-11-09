Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE9D622569
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 09:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiKII2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 03:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiKII1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 03:27:55 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A34013D63;
        Wed,  9 Nov 2022 00:27:54 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N6dPm5WCCz15MR9;
        Wed,  9 Nov 2022 16:27:40 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 16:27:52 +0800
From:   Wang Yufen <wangyufen@huawei.com>
To:     <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <pavel@ucw.cz>, Wang Yufen <wangyufen@huawei.com>,
        Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Subject: [PATCH 10/13] leds: powernv: Fix devm vs. non-devm ordering
Date:   Wed, 9 Nov 2022 16:48:11 +0800
Message-ID: <1667983694-15040-11-git-send-email-wangyufen@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1667983694-15040-1-git-send-email-wangyufen@huawei.com>
References: <1667983694-15040-1-git-send-email-wangyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.70]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When non-devm resources are allocated they mustn't be followed by devm
allocations, otherwise it will break the tear down ordering and might
lead to crashes or other bugs during ->remove() stage. Fix this by
wrapping mutex_destroy() call with devm_add_action_or_reset().

Fixes: 84ad6e5cd3e8 ("leds/powernv: Add driver for PowerNV platform")
Signed-off-by: Wang Yufen <wangyufen@huawei.com>
Cc: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
---
 drivers/leds/leds-powernv.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/leds-powernv.c b/drivers/leds/leds-powernv.c
index 743e2cd..535f295 100644
--- a/drivers/leds/leds-powernv.c
+++ b/drivers/leds/leds-powernv.c
@@ -275,6 +275,11 @@ static int powernv_led_classdev(struct platform_device *pdev,
 	return rc;
 }
 
+static void powernv_led_mutex_destroy(void *lock)
+{
+	mutex_destroy(lock);
+}
+
 /* Platform driver probe */
 static int powernv_led_probe(struct platform_device *pdev)
 {
@@ -298,6 +303,10 @@ static int powernv_led_probe(struct platform_device *pdev)
 	}
 
 	mutex_init(&powernv_led_common->lock);
+	ret = devm_add_action_or_reset(dev, powernv_led_mutex_destroy,
+				       &powernv_led_common->lock);
+	if (ret)
+		return ret;
 	powernv_led_common->max_led_type = cpu_to_be64(OPAL_SLOT_LED_TYPE_MAX);
 
 	platform_set_drvdata(pdev, powernv_led_common);
@@ -317,9 +326,6 @@ static int powernv_led_remove(struct platform_device *pdev)
 	powernv_led_common = platform_get_drvdata(pdev);
 	powernv_led_common->led_disabled = true;
 
-	/* Destroy lock */
-	mutex_destroy(&powernv_led_common->lock);
-
 	dev_info(&pdev->dev, "PowerNV led module unregistered\n");
 	return 0;
 }
-- 
1.8.3.1


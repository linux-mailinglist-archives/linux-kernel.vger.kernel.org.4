Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFE762256A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 09:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiKII2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 03:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiKII1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 03:27:55 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F355213DFC;
        Wed,  9 Nov 2022 00:27:54 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N6dPX5JqSzHvkj;
        Wed,  9 Nov 2022 16:27:28 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 16:27:53 +0800
From:   Wang Yufen <wangyufen@huawei.com>
To:     <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <pavel@ucw.cz>, Wang Yufen <wangyufen@huawei.com>,
        Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 11/13] leds: sc27xx: Fix devm vs. non-devm ordering
Date:   Wed, 9 Nov 2022 16:48:12 +0800
Message-ID: <1667983694-15040-12-git-send-email-wangyufen@huawei.com>
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

Fixes: e081c49e30ec ("leds: Add Spreadtrum SC27xx breathing light controller driver")
Signed-off-by: Wang Yufen <wangyufen@huawei.com>
Cc: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/leds/leds-sc27xx-bltc.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/leds/leds-sc27xx-bltc.c b/drivers/leds/leds-sc27xx-bltc.c
index e199ea1..43a821c 100644
--- a/drivers/leds/leds-sc27xx-bltc.c
+++ b/drivers/leds/leds-sc27xx-bltc.c
@@ -273,6 +273,11 @@ static int sc27xx_led_register(struct device *dev, struct sc27xx_led_priv *priv)
 	return 0;
 }
 
+static void sc27xx_led_mutex_destroy(void *lock)
+{
+	mutex_destroy(lock);
+}
+
 static int sc27xx_led_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -297,6 +302,11 @@ static int sc27xx_led_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 	mutex_init(&priv->lock);
+	err = devm_add_action_or_reset(dev, sc27xx_led_mutex_destroy,
+				       &priv->lock);
+	if (err)
+		return err;
+
 	priv->base = base;
 	priv->regmap = dev_get_regmap(dev->parent, NULL);
 	if (!priv->regmap) {
@@ -309,13 +319,11 @@ static int sc27xx_led_probe(struct platform_device *pdev)
 		err = of_property_read_u32(child, "reg", &reg);
 		if (err) {
 			of_node_put(child);
-			mutex_destroy(&priv->lock);
 			return err;
 		}
 
 		if (reg >= SC27XX_LEDS_MAX || priv->leds[reg].active) {
 			of_node_put(child);
-			mutex_destroy(&priv->lock);
 			return -EINVAL;
 		}
 
@@ -323,19 +331,7 @@ static int sc27xx_led_probe(struct platform_device *pdev)
 		priv->leds[reg].active = true;
 	}
 
-	err = sc27xx_led_register(dev, priv);
-	if (err)
-		mutex_destroy(&priv->lock);
-
-	return err;
-}
-
-static int sc27xx_led_remove(struct platform_device *pdev)
-{
-	struct sc27xx_led_priv *priv = platform_get_drvdata(pdev);
-
-	mutex_destroy(&priv->lock);
-	return 0;
+	return sc27xx_led_register(dev, priv);
 }
 
 static const struct of_device_id sc27xx_led_of_match[] = {
@@ -350,7 +346,6 @@ static int sc27xx_led_remove(struct platform_device *pdev)
 		.of_match_table = sc27xx_led_of_match,
 	},
 	.probe = sc27xx_led_probe,
-	.remove = sc27xx_led_remove,
 };
 
 module_platform_driver(sc27xx_led_driver);
-- 
1.8.3.1


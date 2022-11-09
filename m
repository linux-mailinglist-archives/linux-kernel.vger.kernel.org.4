Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06662622565
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 09:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiKII2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 03:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiKII1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 03:27:54 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F0E13D52;
        Wed,  9 Nov 2022 00:27:53 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N6dPl12WNzmVnl;
        Wed,  9 Nov 2022 16:27:39 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 16:27:51 +0800
From:   Wang Yufen <wangyufen@huawei.com>
To:     <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <pavel@ucw.cz>, Wang Yufen <wangyufen@huawei.com>,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: [PATCH 08/13] leds: mlxreg: Fix devm vs. non-devm ordering
Date:   Wed, 9 Nov 2022 16:48:09 +0800
Message-ID: <1667983694-15040-9-git-send-email-wangyufen@huawei.com>
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

Fixes: 386570d76f2f ("leds: add driver for support Mellanox regmap LEDs for BMC and x86 platform")
Signed-off-by: Wang Yufen <wangyufen@huawei.com>
Cc: Vadim Pasternak <vadimp@mellanox.com>
---
 drivers/leds/leds-mlxreg.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/leds/leds-mlxreg.c b/drivers/leds/leds-mlxreg.c
index b7855c9..b7c58fb 100644
--- a/drivers/leds/leds-mlxreg.c
+++ b/drivers/leds/leds-mlxreg.c
@@ -254,10 +254,16 @@ static int mlxreg_led_config(struct mlxreg_led_priv_data *priv)
 	return 0;
 }
 
+static void mlxreg_led_mutex_destroy(void *lock)
+{
+	mutex_destroy(lock);
+}
+
 static int mlxreg_led_probe(struct platform_device *pdev)
 {
 	struct mlxreg_core_platform_data *led_pdata;
 	struct mlxreg_led_priv_data *priv;
+	int ret;
 
 	led_pdata = dev_get_platdata(&pdev->dev);
 	if (!led_pdata) {
@@ -273,24 +279,18 @@ static int mlxreg_led_probe(struct platform_device *pdev)
 	priv->pdev = pdev;
 	priv->pdata = led_pdata;
 
+	ret = devm_add_action_or_reset(&pdev->dev, mlxreg_led_mutex_destroy,
+				       &priv->access_lock);
+	if (ret)
+		return ret;
 	return mlxreg_led_config(priv);
 }
 
-static int mlxreg_led_remove(struct platform_device *pdev)
-{
-	struct mlxreg_led_priv_data *priv = dev_get_drvdata(&pdev->dev);
-
-	mutex_destroy(&priv->access_lock);
-
-	return 0;
-}
-
 static struct platform_driver mlxreg_led_driver = {
 	.driver = {
 	    .name = "leds-mlxreg",
 	},
 	.probe = mlxreg_led_probe,
-	.remove = mlxreg_led_remove,
 };
 
 module_platform_driver(mlxreg_led_driver);
-- 
1.8.3.1


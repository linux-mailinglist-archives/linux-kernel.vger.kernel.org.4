Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF8B5E90C0
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 04:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiIYCGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 22:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiIYCGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 22:06:16 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DB240542;
        Sat, 24 Sep 2022 19:06:14 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MZpzX4gsGzlWlj;
        Sun, 25 Sep 2022 10:02:00 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 25 Sep 2022 10:06:12 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sun, 25 Sep
 2022 10:06:12 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linus.walleij@linaro.org>, <p.zabel@pengutronix.de>,
        <horatiu.vultur@microchip.com>, <andy.shevchenko@gmail.com>
Subject: [PATCH -next v3] pinctrl: ocelot: add missing destroy_workqueue() in error path in ocelot_pinctrl_probe()
Date:   Sun, 25 Sep 2022 10:12:58 +0800
Message-ID: <20220925021258.1492905-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using devm_add_action_or_reset() to make workqueue device-managed, so it can be
destroy whenever the driver is unbound.

Fixes: c297561bc98a ("pinctrl: ocelot: Fix interrupt controller")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
v3:
  Using devm_add_action_or_reset().

v2:
  move alloc_ordered_workqueue() after ocelot_pinctrl_register().
---
 drivers/pinctrl/pinctrl-ocelot.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
index 62ce3957abe4..266fbc957273 100644
--- a/drivers/pinctrl/pinctrl-ocelot.c
+++ b/drivers/pinctrl/pinctrl-ocelot.c
@@ -2038,6 +2038,11 @@ static struct regmap *ocelot_pinctrl_create_pincfg(struct platform_device *pdev,
 	return devm_regmap_init_mmio(&pdev->dev, base, &regmap_config);
 }
 
+static void ocelot_destroy_workqueue(void *data)
+{
+	destroy_workqueue(data);
+}
+
 static int ocelot_pinctrl_probe(struct platform_device *pdev)
 {
 	const struct ocelot_match_data *data;
@@ -2069,6 +2074,11 @@ static int ocelot_pinctrl_probe(struct platform_device *pdev)
 	if (!info->wq)
 		return -ENOMEM;
 
+	ret = devm_add_action_or_reset(dev, ocelot_destroy_workqueue,
+				       info->wq);
+	if (ret)
+		return ret;
+
 	info->pincfg_data = &data->pincfg_data;
 
 	reset = devm_reset_control_get_optional_shared(dev, "switch");
@@ -2110,15 +2120,6 @@ static int ocelot_pinctrl_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int ocelot_pinctrl_remove(struct platform_device *pdev)
-{
-	struct ocelot_pinctrl *info = platform_get_drvdata(pdev);
-
-	destroy_workqueue(info->wq);
-
-	return 0;
-}
-
 static struct platform_driver ocelot_pinctrl_driver = {
 	.driver = {
 		.name = "pinctrl-ocelot",
@@ -2126,7 +2127,6 @@ static struct platform_driver ocelot_pinctrl_driver = {
 		.suppress_bind_attrs = true,
 	},
 	.probe = ocelot_pinctrl_probe,
-	.remove = ocelot_pinctrl_remove,
 };
 module_platform_driver(ocelot_pinctrl_driver);
 
-- 
2.25.1


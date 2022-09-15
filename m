Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC485B9E80
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 17:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiIOPOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 11:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbiIOPN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 11:13:57 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C770D9F8CF;
        Thu, 15 Sep 2022 08:07:49 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MT0p93hDpz14QVt;
        Thu, 15 Sep 2022 23:03:45 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 15 Sep 2022 23:07:34 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 15 Sep
 2022 23:07:34 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linus.walleij@linaro.org>, <p.zabel@pengutronix.de>,
        <horatiu.vultur@microchip.com>
Subject: [PATCH -next 1/2] pinctrl: ocelot: add missing destroy_workqueue() in error path in ocelot_pinctrl_probe()
Date:   Thu, 15 Sep 2022 23:14:37 +0800
Message-ID: <20220915151438.699763-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing destroy_workqueue() before return from ocelot_pinctrl_probe()
in error path.

Fixes: c297561bc98a ("pinctrl: ocelot: Fix interrupt controller")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/pinctrl/pinctrl-ocelot.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
index d9c0184c077f..83703a3d291c 100644
--- a/drivers/pinctrl/pinctrl-ocelot.c
+++ b/drivers/pinctrl/pinctrl-ocelot.c
@@ -2072,15 +2072,19 @@ static int ocelot_pinctrl_probe(struct platform_device *pdev)
 	info->pincfg_data = &data->pincfg_data;
 
 	reset = devm_reset_control_get_optional_shared(dev, "switch");
-	if (IS_ERR(reset))
-		return dev_err_probe(dev, PTR_ERR(reset),
-				     "Failed to get reset\n");
+	if (IS_ERR(reset)) {
+		ret = dev_err_probe(dev, PTR_ERR(reset),
+				    "Failed to get reset\n");
+		goto err_out;
+	}
 	reset_control_reset(reset);
 
 	base = devm_ioremap_resource(dev,
 			platform_get_resource(pdev, IORESOURCE_MEM, 0));
-	if (IS_ERR(base))
-		return PTR_ERR(base);
+	if (IS_ERR(base)) {
+		ret = PTR_ERR(base);
+		goto err_out;
+	}
 
 	info->stride = 1 + (info->desc->npins - 1) / 32;
 
@@ -2089,7 +2093,8 @@ static int ocelot_pinctrl_probe(struct platform_device *pdev)
 	info->map = devm_regmap_init_mmio(dev, base, &regmap_config);
 	if (IS_ERR(info->map)) {
 		dev_err(dev, "Failed to create regmap\n");
-		return PTR_ERR(info->map);
+		ret = PTR_ERR(info->map);
+		goto err_out;
 	}
 	dev_set_drvdata(dev, info);
 	info->dev = dev;
@@ -2105,15 +2110,19 @@ static int ocelot_pinctrl_probe(struct platform_device *pdev)
 
 	ret = ocelot_pinctrl_register(pdev, info);
 	if (ret)
-		return ret;
+		goto err_out;
 
 	ret = ocelot_gpiochip_register(pdev, info);
 	if (ret)
-		return ret;
+		goto err_out;
 
 	dev_info(dev, "driver registered\n");
 
 	return 0;
+
+err_out:
+	destroy_workqueue(info->wq);
+	return ret;
 }
 
 static int ocelot_pinctrl_remove(struct platform_device *pdev)
-- 
2.25.1


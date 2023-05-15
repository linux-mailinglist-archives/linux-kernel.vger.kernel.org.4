Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508827039F6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 19:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244736AbjEORq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 13:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242536AbjEORqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 13:46:40 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AAB16EBD;
        Mon, 15 May 2023 10:45:24 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34FHjKHo009760;
        Mon, 15 May 2023 12:45:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684172720;
        bh=V9tiruoX9ztjEFpmdpDyiAFpY7IRTPlA8j2mNpdmPkU=;
        h=From:To:CC:Subject:Date;
        b=CYL4s58w8JTFaCB/8ZtAFJ3BSdSPv2Wn5OQDk0q7SiC6GFJJ+t0d0A3YV3p+Qn4Qg
         oh6I+OwbPfC+ncW+FhY03wew/yPFTrT+r4FK3O//D37kog/87IJeH3RQlVIKNwMsWf
         GYA8agU5k9Js5Q7WUkyfQQ9FV+eF/UISvSc/9+J0=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34FHjKpa121378
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 May 2023 12:45:20 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 May 2023 12:45:19 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 May 2023 12:45:19 -0500
Received: from lelv0326.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34FHjJxR098698;
        Mon, 15 May 2023 12:45:19 -0500
From:   Andrew Davis <afd@ti.com>
To:     Peter Tyser <ptyser@xes-inc.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH v3] gpio: tps65086: Use devm_gpiochip_add_data() to simplify remove path
Date:   Mon, 15 May 2023 12:45:18 -0500
Message-ID: <20230515174518.494907-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm version of gpiochip add function to handle removal for us.

While here update copyright and module author.

Signed-off-by: Andrew Davis <afd@ti.com>
---

Changes from v2:
 - Remove unused var "ret"

 drivers/gpio/gpio-tps65086.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/gpio/gpio-tps65086.c b/drivers/gpio/gpio-tps65086.c
index 1e9d8262d0ff..8f5827554e1e 100644
--- a/drivers/gpio/gpio-tps65086.c
+++ b/drivers/gpio/gpio-tps65086.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) 2015 Texas Instruments Incorporated - http://www.ti.com/
- *	Andrew F. Davis <afd@ti.com>
+ * Copyright (C) 2015-2023 Texas Instruments Incorporated - https://www.ti.com/
+ *	Andrew Davis <afd@ti.com>
  *
  * Based on the TPS65912 driver
  */
@@ -80,34 +80,16 @@ static const struct gpio_chip template_chip = {
 static int tps65086_gpio_probe(struct platform_device *pdev)
 {
 	struct tps65086_gpio *gpio;
-	int ret;
 
 	gpio = devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
 	if (!gpio)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, gpio);
-
 	gpio->tps = dev_get_drvdata(pdev->dev.parent);
 	gpio->chip = template_chip;
 	gpio->chip.parent = gpio->tps->dev;
 
-	ret = gpiochip_add_data(&gpio->chip, gpio);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Could not register gpiochip, %d\n", ret);
-		return ret;
-	}
-
-	return 0;
-}
-
-static int tps65086_gpio_remove(struct platform_device *pdev)
-{
-	struct tps65086_gpio *gpio = platform_get_drvdata(pdev);
-
-	gpiochip_remove(&gpio->chip);
-
-	return 0;
+	return devm_gpiochip_add_data(&pdev->dev, &gpio->chip, gpio);
 }
 
 static const struct platform_device_id tps65086_gpio_id_table[] = {
@@ -121,11 +103,10 @@ static struct platform_driver tps65086_gpio_driver = {
 		.name = "tps65086-gpio",
 	},
 	.probe = tps65086_gpio_probe,
-	.remove = tps65086_gpio_remove,
 	.id_table = tps65086_gpio_id_table,
 };
 module_platform_driver(tps65086_gpio_driver);
 
-MODULE_AUTHOR("Andrew F. Davis <afd@ti.com>");
+MODULE_AUTHOR("Andrew Davis <afd@ti.com>");
 MODULE_DESCRIPTION("TPS65086 GPIO driver");
 MODULE_LICENSE("GPL v2");
-- 
2.39.2


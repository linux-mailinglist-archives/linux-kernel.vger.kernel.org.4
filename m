Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7020B6AE79E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjCGQ7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjCGQ6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:58:08 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63B890088;
        Tue,  7 Mar 2023 08:54:37 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 327GsXc6035084;
        Tue, 7 Mar 2023 10:54:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678208073;
        bh=ZZ2CX0VbEpPFPtwgXxUtM9c1eVceTlwlTZUDyoR3v1Y=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=uLpS7k5x6y32pXjaMtJNAMZumh9tSr8KlTbCH8phJ0teUmE2jlhAzl8LpGbc2Za8c
         OqPs3JCzE0+vatp/CKca4s7yfvwnTKsxvvL9tIq8qfhQ2c/X0H9VbDVKVE6OkFJjnT
         1B9vBAMwHLY43+wHTXVIhGQWJkletRPlm9MBn5DY=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 327GsXIw000965
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Mar 2023 10:54:33 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 7
 Mar 2023 10:54:33 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 7 Mar 2023 10:54:33 -0600
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 327GsWdX084852;
        Tue, 7 Mar 2023 10:54:33 -0600
From:   Andrew Davis <afd@ti.com>
To:     Peter Tyser <ptyser@xes-inc.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH 6/6] gpio: tps65086: Use devm_gpiochip_add_data() to simplify remove path
Date:   Tue, 7 Mar 2023 10:54:32 -0600
Message-ID: <20230307165432.25484-6-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307165432.25484-1-afd@ti.com>
References: <20230307165432.25484-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm version of gpiochip add function to handle removal for us.

While here update copyright and module author.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/gpio/gpio-tps65086.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/gpio/gpio-tps65086.c b/drivers/gpio/gpio-tps65086.c
index 1e9d8262d0ff..0b8b631441ae 100644
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
@@ -86,13 +86,11 @@ static int tps65086_gpio_probe(struct platform_device *pdev)
 	if (!gpio)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, gpio);
-
 	gpio->tps = dev_get_drvdata(pdev->dev.parent);
 	gpio->chip = template_chip;
 	gpio->chip.parent = gpio->tps->dev;
 
-	ret = gpiochip_add_data(&gpio->chip, gpio);
+	ret = devm_gpiochip_add_data(&pdev->dev, &gpio->chip, gpio);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Could not register gpiochip, %d\n", ret);
 		return ret;
@@ -101,15 +99,6 @@ static int tps65086_gpio_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int tps65086_gpio_remove(struct platform_device *pdev)
-{
-	struct tps65086_gpio *gpio = platform_get_drvdata(pdev);
-
-	gpiochip_remove(&gpio->chip);
-
-	return 0;
-}
-
 static const struct platform_device_id tps65086_gpio_id_table[] = {
 	{ "tps65086-gpio", },
 	{ /* sentinel */ }
@@ -121,11 +110,10 @@ static struct platform_driver tps65086_gpio_driver = {
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


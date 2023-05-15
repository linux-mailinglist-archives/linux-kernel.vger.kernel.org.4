Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68727039DE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 19:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244394AbjEORq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 13:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244581AbjEORqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 13:46:09 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3527110A02;
        Mon, 15 May 2023 10:44:14 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34FHiAxw009335;
        Mon, 15 May 2023 12:44:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684172650;
        bh=oj7d3cRmVnICSKrHBOY8BVdU7GVxrr7m1scZoQUbyy4=;
        h=From:To:CC:Subject:Date;
        b=JxWT45KpEfhuKZ3RLwn8oYfIexStHs4G1GjwBhAhsAlueJesDQ0zpsvZ72Na6Zjsc
         tjwIFYj3XvpbDXoPg39jQsRcLRq/vHYW1krpnRaHeogP+jW++OozX9gxIdLKqscqBh
         JOAH8/nNiqI4M7bWau2+0xUYb+KJyoiAnjPss+MI=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34FHiAcT095799
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 May 2023 12:44:10 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 May 2023 12:44:09 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 May 2023 12:44:09 -0500
Received: from fllv0040.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34FHi9uj097394;
        Mon, 15 May 2023 12:44:09 -0500
From:   Andrew Davis <afd@ti.com>
To:     Peter Tyser <ptyser@xes-inc.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH v3] gpio: tpic2810: Use devm_gpiochip_add_data() to simplify remove path
Date:   Mon, 15 May 2023 12:44:08 -0500
Message-ID: <20230515174408.494811-1-afd@ti.com>
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

 drivers/gpio/gpio-tpic2810.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/gpio/gpio-tpic2810.c b/drivers/gpio/gpio-tpic2810.c
index 349c5fbd9b02..642ed82b9de2 100644
--- a/drivers/gpio/gpio-tpic2810.c
+++ b/drivers/gpio/gpio-tpic2810.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2015 Texas Instruments Incorporated - http://www.ti.com/
- *	Andrew F. Davis <afd@ti.com>
+ * Copyright (C) 2015-2023 Texas Instruments Incorporated - https://www.ti.com/
+ *	Andrew Davis <afd@ti.com>
  */
 
 #include <linux/gpio/driver.h>
@@ -101,14 +101,11 @@ MODULE_DEVICE_TABLE(of, tpic2810_of_match_table);
 static int tpic2810_probe(struct i2c_client *client)
 {
 	struct tpic2810 *gpio;
-	int ret;
 
 	gpio = devm_kzalloc(&client->dev, sizeof(*gpio), GFP_KERNEL);
 	if (!gpio)
 		return -ENOMEM;
 
-	i2c_set_clientdata(client, gpio);
-
 	gpio->chip = template_chip;
 	gpio->chip.parent = &client->dev;
 
@@ -116,20 +113,7 @@ static int tpic2810_probe(struct i2c_client *client)
 
 	mutex_init(&gpio->lock);
 
-	ret = gpiochip_add_data(&gpio->chip, gpio);
-	if (ret < 0) {
-		dev_err(&client->dev, "Unable to register gpiochip\n");
-		return ret;
-	}
-
-	return 0;
-}
-
-static void tpic2810_remove(struct i2c_client *client)
-{
-	struct tpic2810 *gpio = i2c_get_clientdata(client);
-
-	gpiochip_remove(&gpio->chip);
+	return devm_gpiochip_add_data(&client->dev, &gpio->chip, gpio);
 }
 
 static const struct i2c_device_id tpic2810_id_table[] = {
@@ -144,11 +128,10 @@ static struct i2c_driver tpic2810_driver = {
 		.of_match_table = tpic2810_of_match_table,
 	},
 	.probe_new = tpic2810_probe,
-	.remove = tpic2810_remove,
 	.id_table = tpic2810_id_table,
 };
 module_i2c_driver(tpic2810_driver);
 
-MODULE_AUTHOR("Andrew F. Davis <afd@ti.com>");
+MODULE_AUTHOR("Andrew Davis <afd@ti.com>");
 MODULE_DESCRIPTION("TPIC2810 8-Bit LED Driver GPIO Driver");
 MODULE_LICENSE("GPL v2");
-- 
2.39.2


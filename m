Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085C06AF60E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 20:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjCGTqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 14:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjCGTod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 14:44:33 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A324A98850;
        Tue,  7 Mar 2023 11:33:51 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 327JXk43032053;
        Tue, 7 Mar 2023 13:33:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678217626;
        bh=MjozjsM7oc2HrtgkTcGYDiESorMVaDXnh/A+VTPqizc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=oVGE1yOnfCxQuT8mDvLuDK359VltJfZcdeDlDg8J1L2l5CL2+bLWKb3f8nB3BOWMw
         5/7k0czFmU+HEAECuEn14y1C8k6iJ/PkMstb0kwGaHlgLIXhJlWEFFFG5+UItmbar/
         4Q5GYmZv/meOe/QC2sOwy2rQLtDbofV6YdLB0jIA=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 327JXkY3123444
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Mar 2023 13:33:46 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 7
 Mar 2023 13:33:46 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 7 Mar 2023 13:33:46 -0600
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 327JXkWq026389;
        Tue, 7 Mar 2023 13:33:46 -0600
From:   Andrew Davis <afd@ti.com>
To:     Peter Tyser <ptyser@xes-inc.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH v2 5/6] gpio: tpic2810: Use devm_gpiochip_add_data() to simplify remove path
Date:   Tue, 7 Mar 2023 13:33:45 -0600
Message-ID: <20230307193346.8718-5-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307193346.8718-1-afd@ti.com>
References: <20230307193346.8718-1-afd@ti.com>
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
 drivers/gpio/gpio-tpic2810.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/gpio/gpio-tpic2810.c b/drivers/gpio/gpio-tpic2810.c
index 349c5fbd9b02..718053edd76a 100644
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
@@ -107,8 +107,6 @@ static int tpic2810_probe(struct i2c_client *client)
 	if (!gpio)
 		return -ENOMEM;
 
-	i2c_set_clientdata(client, gpio);
-
 	gpio->chip = template_chip;
 	gpio->chip.parent = &client->dev;
 
@@ -116,7 +114,7 @@ static int tpic2810_probe(struct i2c_client *client)
 
 	mutex_init(&gpio->lock);
 
-	ret = gpiochip_add_data(&gpio->chip, gpio);
+	ret = devm_gpiochip_add_data(&client->dev, &gpio->chip, gpio);
 	if (ret < 0) {
 		dev_err(&client->dev, "Unable to register gpiochip\n");
 		return ret;
@@ -125,13 +123,6 @@ static int tpic2810_probe(struct i2c_client *client)
 	return 0;
 }
 
-static void tpic2810_remove(struct i2c_client *client)
-{
-	struct tpic2810 *gpio = i2c_get_clientdata(client);
-
-	gpiochip_remove(&gpio->chip);
-}
-
 static const struct i2c_device_id tpic2810_id_table[] = {
 	{ "tpic2810", },
 	{ /* sentinel */ }
@@ -144,11 +135,10 @@ static struct i2c_driver tpic2810_driver = {
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


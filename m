Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06EA6AE7A3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjCGQ7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjCGQ6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:58:08 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65B893137;
        Tue,  7 Mar 2023 08:54:37 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 327GsXr7035079;
        Tue, 7 Mar 2023 10:54:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678208073;
        bh=MjozjsM7oc2HrtgkTcGYDiESorMVaDXnh/A+VTPqizc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Vw6YFdmGzKxXPek7Eam0A8IyjM6Bio0bug4jr1z2ixBYY98q6APibUNXZwl2pWlqt
         uOfl4TTFs9y0dUP8TaJkJeKaJRhU4Z3LPrL+QNMtJCj5Bj2EM+emnzirXAmFC+aHfc
         JJVLadp1+PQEjk8PUWznh9JENcyPbfflP+yd2uOU=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 327GsXQE000962
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Mar 2023 10:54:33 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 7
 Mar 2023 10:54:33 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 7 Mar 2023 10:54:33 -0600
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 327GsWdW084852;
        Tue, 7 Mar 2023 10:54:33 -0600
From:   Andrew Davis <afd@ti.com>
To:     Peter Tyser <ptyser@xes-inc.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH 5/6] gpio: tpic2810: Use devm_gpiochip_add_data() to simplify remove path
Date:   Tue, 7 Mar 2023 10:54:31 -0600
Message-ID: <20230307165432.25484-5-afd@ti.com>
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166B57039CD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 19:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244557AbjEORqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 13:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243060AbjEORpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 13:45:38 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBD016937;
        Mon, 15 May 2023 10:43:29 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34FHhN49025249;
        Mon, 15 May 2023 12:43:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684172603;
        bh=wuQzSnyQkkwLAmyWQAxv902h9goyora1EbmiXeOjzZs=;
        h=From:To:CC:Subject:Date;
        b=Pasd+Uv1JLwa65D6KT88loYcaRmO0e+ZlE/rHj9lOGgmgel4glxH/VVXZ9QJPmTET
         0/9mlljcRi5xLkWnpjgdMHjnvHhpiIv7Bq7u/4vmWjYSA5mDJTaiaM51z0ivODmdIb
         hLb5nRJtIWvFGvSjjVFBOpo+u3UEAsqTNNF/oiaM=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34FHhNkh095481
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 May 2023 12:43:23 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 May 2023 12:43:23 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 May 2023 12:43:23 -0500
Received: from fllv0039.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34FHhMNi054591;
        Mon, 15 May 2023 12:43:22 -0500
From:   Andrew Davis <afd@ti.com>
To:     Peter Tyser <ptyser@xes-inc.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH v3] gpio: pisosr: Use devm_gpiochip_add_data() to simplify remove path
Date:   Mon, 15 May 2023 12:43:21 -0500
Message-ID: <20230515174321.494714-1-afd@ti.com>
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
 - Rebase on v6.4-rc2

Changes from v1:
 - Use devm to cleanup mutex

 drivers/gpio/gpio-pisosr.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/gpio/gpio-pisosr.c b/drivers/gpio/gpio-pisosr.c
index 67071bea08c2..4c9d138a7dc7 100644
--- a/drivers/gpio/gpio-pisosr.c
+++ b/drivers/gpio/gpio-pisosr.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2015 Texas Instruments Incorporated - http://www.ti.com/
- *	Andrew F. Davis <afd@ti.com>
+ * Copyright (C) 2015-2023 Texas Instruments Incorporated - https://www.ti.com/
+ *	Andrew Davis <afd@ti.com>
  */
 
 #include <linux/bitmap.h>
@@ -116,6 +116,13 @@ static const struct gpio_chip template_chip = {
 	.can_sleep		= true,
 };
 
+static void pisosr_mutex_destroy(void *data)
+{
+	struct mutex *lock = data;
+
+	mutex_destroy(lock);
+}
+
 static int pisosr_gpio_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
@@ -126,8 +133,6 @@ static int pisosr_gpio_probe(struct spi_device *spi)
 	if (!gpio)
 		return -ENOMEM;
 
-	spi_set_drvdata(spi, gpio);
-
 	gpio->chip = template_chip;
 	gpio->chip.parent = dev;
 	of_property_read_u16(dev->of_node, "ngpios", &gpio->chip.ngpio);
@@ -145,8 +150,11 @@ static int pisosr_gpio_probe(struct spi_device *spi)
 				     "Unable to allocate load GPIO\n");
 
 	mutex_init(&gpio->lock);
+	ret = devm_add_action_or_reset(dev, pisosr_mutex_destroy, &gpio->lock);
+	if (ret)
+		return ret;
 
-	ret = gpiochip_add_data(&gpio->chip, gpio);
+	ret = devm_gpiochip_add_data(dev, &gpio->chip, gpio);
 	if (ret < 0) {
 		dev_err(dev, "Unable to register gpiochip\n");
 		return ret;
@@ -155,15 +163,6 @@ static int pisosr_gpio_probe(struct spi_device *spi)
 	return 0;
 }
 
-static void pisosr_gpio_remove(struct spi_device *spi)
-{
-	struct pisosr_gpio *gpio = spi_get_drvdata(spi);
-
-	gpiochip_remove(&gpio->chip);
-
-	mutex_destroy(&gpio->lock);
-}
-
 static const struct spi_device_id pisosr_gpio_id_table[] = {
 	{ "pisosr-gpio", },
 	{ /* sentinel */ }
@@ -182,11 +181,10 @@ static struct spi_driver pisosr_gpio_driver = {
 		.of_match_table = pisosr_gpio_of_match_table,
 	},
 	.probe = pisosr_gpio_probe,
-	.remove = pisosr_gpio_remove,
 	.id_table = pisosr_gpio_id_table,
 };
 module_spi_driver(pisosr_gpio_driver);
 
-MODULE_AUTHOR("Andrew F. Davis <afd@ti.com>");
+MODULE_AUTHOR("Andrew Davis <afd@ti.com>");
 MODULE_DESCRIPTION("SPI Compatible PISO Shift Register GPIO Driver");
 MODULE_LICENSE("GPL v2");
-- 
2.39.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0506AE7A6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjCGQ7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjCGQ6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:58:09 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501003B3E5;
        Tue,  7 Mar 2023 08:54:40 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 327GsXlq094197;
        Tue, 7 Mar 2023 10:54:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678208073;
        bh=3mZeuBv+KHlgKSK9toGY2kGnCo4J2rlgKrh4etaAP9w=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=X4aeWevlBO7RlsEr5p49WIa3wpXbbNk0jO7hvB1+PxBKanKH+6RX6hehV07REPRNj
         Njsp5ZggNpBekbJtN1nk7IrrRwMalehS1q/AeH2PMligrDxq7Qyo+NGDy0rUCK5lS6
         /wa8oItGQseKp3JdD1qlETgTdaWI6H8tU0Aozb2k=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 327GsXka052512
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Mar 2023 10:54:33 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 7
 Mar 2023 10:54:33 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 7 Mar 2023 10:54:32 -0600
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 327GsWdV084852;
        Tue, 7 Mar 2023 10:54:32 -0600
From:   Andrew Davis <afd@ti.com>
To:     Peter Tyser <ptyser@xes-inc.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH 4/6] gpio: pisosr: Use devm_gpiochip_add_data() to simplify remove path
Date:   Tue, 7 Mar 2023 10:54:30 -0600
Message-ID: <20230307165432.25484-4-afd@ti.com>
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
 drivers/gpio/gpio-pisosr.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/gpio/gpio-pisosr.c b/drivers/gpio/gpio-pisosr.c
index 67071bea08c2..eaf65606035d 100644
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
@@ -126,8 +126,6 @@ static int pisosr_gpio_probe(struct spi_device *spi)
 	if (!gpio)
 		return -ENOMEM;
 
-	spi_set_drvdata(spi, gpio);
-
 	gpio->chip = template_chip;
 	gpio->chip.parent = dev;
 	of_property_read_u16(dev->of_node, "ngpios", &gpio->chip.ngpio);
@@ -146,7 +144,7 @@ static int pisosr_gpio_probe(struct spi_device *spi)
 
 	mutex_init(&gpio->lock);
 
-	ret = gpiochip_add_data(&gpio->chip, gpio);
+	ret = devm_gpiochip_add_data(dev, &gpio->chip, gpio);
 	if (ret < 0) {
 		dev_err(dev, "Unable to register gpiochip\n");
 		return ret;
@@ -155,15 +153,6 @@ static int pisosr_gpio_probe(struct spi_device *spi)
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
@@ -182,11 +171,10 @@ static struct spi_driver pisosr_gpio_driver = {
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


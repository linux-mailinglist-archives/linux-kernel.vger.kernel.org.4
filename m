Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5086C1599
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbjCTOwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbjCTOwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:52:05 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5666928D0E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 07:50:32 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d7so13273776qtr.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 07:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679323827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pn9VGQBxO0VW8CThpup8iOfOpiJuYyrE48H21arWabA=;
        b=PPOV3xzK+7nwJdGa5mz7vqiQRiXzw677QBbck0mYP/jr+bKo3tFkmHx/pPMW1Tyl18
         IpKhhBXpD7UAFS3OafL5z/0LZQasbe/tivkm9pTXL5KPewQ1tdimFO0u+PY7c+DnfDsf
         C60nJQLuTSpqcWigH9ZrHKL21rIC+kszpNiaPBPwYOoDJWRXIRRtOPvdTCbulHcMcoIb
         sXiIeg4z2ibqGZN2F0ju4p5GtmvU1adwcjalaQDNpe+PQbDgXxQaEH4NlKDGB02MZM50
         3bUhgWzE4pJN5VsP9bf5GmErm+GoU9Ac67hn6/J9iOHZv7E/rgPdz79mwRLYXBs4kZJ8
         HvzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679323827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pn9VGQBxO0VW8CThpup8iOfOpiJuYyrE48H21arWabA=;
        b=S9m0fROgrJ+oXPewfee9xiXLHCaL0OQIHNW8uELOgYgLYneyKvnC4i86mfKWGL+f2r
         YoevhvOm40nXzeX6HM/Y6qYrYMU887ZbFGAWHn8Y3X3He2sCgtZH23maUd1v+27Qr6rk
         0lsPI5QV0N/0tvjICS5GCePFWDQwdolm/lOQNz3enD4/r9MZkXL8Ws0uf3EyVRbG4S+Z
         710q7/6VqqNlcqs+bqIgBzkYFj8/MvFBbfdRCYE8xvZJcif6JMThKU+UBSElliwX5YCc
         e+o7Z/DaiPkFZFsyc3OYghjVFxHOKg3r65PtBX97i2VQujtWIL2fMrDZFZP/Zwkivn6y
         5SEQ==
X-Gm-Message-State: AO0yUKX0Lho094MDi1oC2SkUa1NFgr8SvayXjzi3DqyGklU+IqB9oU83
        WcXNNVPXOgKpxCGTvgXuutjdhQ==
X-Google-Smtp-Source: AK7set9+0mXLe9k4QN0nTZcqYPZiCiU0cUy0Xx1hGyeToTdtbFtDMgwcB2Tonh4UaemzWE1WSbXZRg==
X-Received: by 2002:a05:622a:15d0:b0:3b4:7efb:36a7 with SMTP id d16-20020a05622a15d000b003b47efb36a7mr19636317qty.27.1679323826323;
        Mon, 20 Mar 2023 07:50:26 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id o14-20020ac872ce000000b003e03178112dsm2661003qtp.13.2023.03.20.07.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 07:50:26 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v3 1/2] gpio: 104-dio-48e: Implement struct dio48e_gpio
Date:   Mon, 20 Mar 2023 10:50:15 -0400
Message-Id: <ca710d14a710fee44f7911f2a84b6a55570561ee.1679323449.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679323449.git.william.gray@linaro.org>
References: <cover.1679323449.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A private data structure struct dio48e_gpio is introduced to facilitate
passage of the regmap and IRQ mask state for the device to the callback
dio48e_handle_mask_sync(). This is in preparation for the removal of the
handle_mask_sync() map parameter in a subsequent patch.

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
Changes in v3:
 - Inline dio48gpio->map usage in dio48e_handle_mask_sync() to avoid
   redefining map parameter

 drivers/gpio/gpio-104-dio-48e.c | 35 ++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpio-104-dio-48e.c b/drivers/gpio/gpio-104-dio-48e.c
index 74e2721f2613..3516321c92b0 100644
--- a/drivers/gpio/gpio-104-dio-48e.c
+++ b/drivers/gpio/gpio-104-dio-48e.c
@@ -99,13 +99,23 @@ static const struct regmap_irq dio48e_regmap_irqs[] = {
 	DIO48E_REGMAP_IRQ(0), DIO48E_REGMAP_IRQ(1),
 };
 
+/**
+ * struct dio48e_gpio - GPIO device private data structure
+ * @map:	Regmap for the device
+ * @irq_mask:	Current IRQ mask state on the device
+ */
+struct dio48e_gpio {
+	struct regmap *map;
+	unsigned int irq_mask;
+};
+
 static int dio48e_handle_mask_sync(struct regmap *const map, const int index,
 				   const unsigned int mask_buf_def,
 				   const unsigned int mask_buf,
 				   void *const irq_drv_data)
 {
-	unsigned int *const irq_mask = irq_drv_data;
-	const unsigned int prev_mask = *irq_mask;
+	struct dio48e_gpio *const dio48egpio = irq_drv_data;
+	const unsigned int prev_mask = dio48egpio->irq_mask;
 	int err;
 	unsigned int val;
 
@@ -114,19 +124,19 @@ static int dio48e_handle_mask_sync(struct regmap *const map, const int index,
 		return 0;
 
 	/* remember the current mask for the next mask sync */
-	*irq_mask = mask_buf;
+	dio48egpio->irq_mask = mask_buf;
 
 	/* if all previously masked, enable interrupts when unmasking */
 	if (prev_mask == mask_buf_def) {
-		err = regmap_write(map, DIO48E_CLEAR_INTERRUPT, 0x00);
+		err = regmap_write(dio48egpio->map, DIO48E_CLEAR_INTERRUPT, 0x00);
 		if (err)
 			return err;
-		return regmap_write(map, DIO48E_ENABLE_INTERRUPT, 0x00);
+		return regmap_write(dio48egpio->map, DIO48E_ENABLE_INTERRUPT, 0x00);
 	}
 
 	/* if all are currently masked, disable interrupts */
 	if (mask_buf == mask_buf_def)
-		return regmap_read(map, DIO48E_DISABLE_INTERRUPT, &val);
+		return regmap_read(dio48egpio->map, DIO48E_DISABLE_INTERRUPT, &val);
 
 	return 0;
 }
@@ -167,7 +177,7 @@ static int dio48e_probe(struct device *dev, unsigned int id)
 	struct regmap *map;
 	int err;
 	struct regmap_irq_chip *chip;
-	unsigned int irq_mask;
+	struct dio48e_gpio *dio48egpio;
 	struct regmap_irq_chip_data *chip_data;
 
 	if (!devm_request_region(dev, base[id], DIO48E_EXTENT, name)) {
@@ -185,12 +195,14 @@ static int dio48e_probe(struct device *dev, unsigned int id)
 		return dev_err_probe(dev, PTR_ERR(map),
 				     "Unable to initialize register map\n");
 
-	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
-	if (!chip)
+	dio48egpio = devm_kzalloc(dev, sizeof(*dio48egpio), GFP_KERNEL);
+	if (!dio48egpio)
 		return -ENOMEM;
 
-	chip->irq_drv_data = devm_kzalloc(dev, sizeof(irq_mask), GFP_KERNEL);
-	if (!chip->irq_drv_data)
+	dio48egpio->map = map;
+
+	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
 		return -ENOMEM;
 
 	chip->name = name;
@@ -205,6 +217,7 @@ static int dio48e_probe(struct device *dev, unsigned int id)
 	chip->irqs = dio48e_regmap_irqs;
 	chip->num_irqs = ARRAY_SIZE(dio48e_regmap_irqs);
 	chip->handle_mask_sync = dio48e_handle_mask_sync;
+	chip->irq_drv_data = dio48egpio;
 
 	/* Initialize to prevent spurious interrupts before we're ready */
 	err = dio48e_irq_init_hw(map);
-- 
2.39.2


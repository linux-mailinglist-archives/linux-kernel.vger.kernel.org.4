Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F166C0525
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 22:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjCSVC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 17:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjCSVCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 17:02:18 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BFC17CE6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 14:02:17 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id c18so11146111qte.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 14:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679259736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fLfrZckZk1Fuq5Ln/Mq3M52wJ96atQRmLdDjYWc7lMs=;
        b=azcUgysThVCEkeyqSAFU5xGBSU1ZUbGELy3s88HXbBy66v7YCBgrPUlqqKBjXmBoWs
         z9GsCcyLkDHHUXoWFOyHL1vDmcv5tzhFaHh+92kkJWOanh69ul7i13XxGvXII2MM6HUZ
         woHCSBx3Z13aJWvWfM2vEoZ3jP7DPi0zOAIqhgjVPXDA8g9D3SdR+QmmYSf8Eeh43l0l
         OpefGPg0QCDgEnDqloMIZBGhCEhTUPeAcfnrmKtfumLSC17x2AVobf6IWcS3owHebY9x
         kEfONZ8Cg4R4pXKOXVa9Ov2/WLahFeceZ5U6kl8m451gpzXcnhdfKcNvJ9JcSg0vSAEg
         wOmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679259736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fLfrZckZk1Fuq5Ln/Mq3M52wJ96atQRmLdDjYWc7lMs=;
        b=uFUnluFoOONv0v2oQmPEhS4zdiIc11sLLYWrt2jFk6YcEfFkrFzYEdohSz4xnyl2if
         OFoYfEJUrJI1NTNP2QqpJDkGq+ngnWlOB7rhgspeX9WSp4puQLTtg7CR4tShIdUwCegu
         n5lySaZH6WxnzjszNqNEEcGX9D9de+tvfyebUHFiYz1DP/n6yjdOysUNu3ljP5LmzKE/
         nCh7i9J8ZPov276f2aB+GMuSI1TbJYquoISC9tjBFk9bNcn3qGOmXwK6aFyLm/XbLc2I
         MBQsmgbTXxHNMhDGOb0CZ5v/R37Ti/4ftSy9BBSbB1WRimV3waMbChYd5YUTWnbiIG+i
         60iw==
X-Gm-Message-State: AO0yUKV7KT4kMReIUbrkPNORDglgoTtOv/Z8caKvAIDBahvuNed8DlK4
        9IO7sRr/P9ulnfVhHz6/EjkWbQ==
X-Google-Smtp-Source: AK7set/Ln8+hXPizFX4Wzwo7dEmUc+S2cxuTHyXISpX60Uw+zVKxD8MqvQ3LjHn5+iYJRI5dszZ8Eg==
X-Received: by 2002:ac8:5a06:0:b0:3e2:4280:bc4a with SMTP id n6-20020ac85a06000000b003e24280bc4amr474412qta.23.1679259736532;
        Sun, 19 Mar 2023 14:02:16 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id o16-20020ac86990000000b003bf9f9f1844sm5225762qtq.71.2023.03.19.14.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 14:02:16 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v2 1/2] gpio: 104-dio-48e: Implement struct dio48e_gpio
Date:   Sun, 19 Mar 2023 17:02:01 -0400
Message-Id: <296c8d808a4a9753ae3aa66d04b746c52df6b8ae.1679259085.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679259085.git.william.gray@linaro.org>
References: <cover.1679259085.git.william.gray@linaro.org>
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
 drivers/gpio/gpio-104-dio-48e.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpio-104-dio-48e.c b/drivers/gpio/gpio-104-dio-48e.c
index 74e2721f2613..ef64c33e2685 100644
--- a/drivers/gpio/gpio-104-dio-48e.c
+++ b/drivers/gpio/gpio-104-dio-48e.c
@@ -99,14 +99,25 @@ static const struct regmap_irq dio48e_regmap_irqs[] = {
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
+	struct regmap *const map = dio48egpio->map;
 	unsigned int val;
 
 	/* exit early if no change since the previous mask */
@@ -114,7 +125,7 @@ static int dio48e_handle_mask_sync(struct regmap *const map, const int index,
 		return 0;
 
 	/* remember the current mask for the next mask sync */
-	*irq_mask = mask_buf;
+	dio48egpio->irq_mask = mask_buf;
 
 	/* if all previously masked, enable interrupts when unmasking */
 	if (prev_mask == mask_buf_def) {
@@ -167,7 +178,7 @@ static int dio48e_probe(struct device *dev, unsigned int id)
 	struct regmap *map;
 	int err;
 	struct regmap_irq_chip *chip;
-	unsigned int irq_mask;
+	struct dio48e_gpio *dio48egpio;
 	struct regmap_irq_chip_data *chip_data;
 
 	if (!devm_request_region(dev, base[id], DIO48E_EXTENT, name)) {
@@ -185,12 +196,14 @@ static int dio48e_probe(struct device *dev, unsigned int id)
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
@@ -205,6 +218,7 @@ static int dio48e_probe(struct device *dev, unsigned int id)
 	chip->irqs = dio48e_regmap_irqs;
 	chip->num_irqs = ARRAY_SIZE(dio48e_regmap_irqs);
 	chip->handle_mask_sync = dio48e_handle_mask_sync;
+	chip->irq_drv_data = dio48egpio;
 
 	/* Initialize to prevent spurious interrupts before we're ready */
 	err = dio48e_irq_init_hw(map);
-- 
2.39.2


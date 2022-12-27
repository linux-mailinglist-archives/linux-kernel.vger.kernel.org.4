Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68EF6656BE9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 15:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbiL0Odd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 09:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbiL0Oc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 09:32:58 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D827CBCBA
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 06:32:49 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id s186so12547219oia.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 06:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhPywnIu0oHq46vQgQ1v3uZDHE34LJl/8jn0V5hUOLk=;
        b=vmoMp0OzfWaG073gvBNXZoHaUT8xZAjxs0EW257xMxsE/BuyMVsMNd8tExuSv5T25m
         q5lhqgGwoi/wNKDF2fQUDZv3JQcLICo1WtvO5Xa8RUFqkG+0jG2kds5IQv+muvXmejAf
         fUtl5yzdnneUi/JI09CelbExNuxOY2qdWXhkoVXow+iVhzXjyWzFcZ+YTqroDc19JDvN
         oSD1SE73gRmqur/tYa4uUOd5UsEMALjAmoC1XhypH/gx+vZClrH7P6lXXDUs93ahn48l
         C5ly7CpGdwMOvGwswFBbytp5wGiBVFYAvIHF7WgsRA+JlkBqP63UneL82DodKweZhEf8
         zEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhPywnIu0oHq46vQgQ1v3uZDHE34LJl/8jn0V5hUOLk=;
        b=2nlBs5ijwi/eqJDZ0wFtPYnLOpbsbRYlP5Us3q/ydsKu3X+nW/zlmZPd59HsS9AE7S
         gjWkz140QorDVM6oit/4PlkbsTFOpNIqmyOZJum571tG5g8eQgI0E7NQvIfT0umsji7i
         2SShaL4QKAw6/UGr0mUxH7owIhatALcGQxgmoNjupllkGuUn5+syW36gI2NQb7lzfrcV
         rsYzJAnop4dBDLHVfo90H6D+8cQDBP3R5M3f6VErnqXP1AO83BjvPSKjy+BKUQjH+Rf4
         jqblL52qUuIQaY0ZdIDncAF5tjfaTIK2DtaQv2Ux9jH+oKy+pNTCBUTBz79S6L2aSUjy
         zyfA==
X-Gm-Message-State: AFqh2kpfKxkbPN+9fpOXjGtZkIWKEqCz0Jj6SDfLCQQcouLq6WhwoS7e
        6zBrHNwcBvAQcLYSqB48gelEFw==
X-Google-Smtp-Source: AMrXdXsvMx5pfrKgqtmJ7r34ccZpqKyL2UyRjyZ1bxuKYIfq58PznfRePNaE4GKCfqW0bgKX8OQo9w==
X-Received: by 2002:a05:6808:2908:b0:35a:6f80:63c5 with SMTP id ev8-20020a056808290800b0035a6f8063c5mr9388884oib.2.1672151569422;
        Tue, 27 Dec 2022 06:32:49 -0800 (PST)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id q205-20020acac0d6000000b0035bce2a39c7sm5864969oif.21.2022.12.27.06.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 06:32:49 -0800 (PST)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     andriy.shevchenko@linux.intel.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael@walle.cc,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v5 6/8] gpio: 104-dio-48e: Migrate to regmap API
Date:   Tue, 27 Dec 2022 09:09:44 -0500
Message-Id: <3749203f86a048ae6c0915ec793fafc9b3b3f739.1672149007.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1672149007.git.william.gray@linaro.org>
References: <cover.1672149007.git.william.gray@linaro.org>
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

The regmap API supports IO port accessors so we can take advantage of
regmap abstractions rather than handling access to the device registers
directly in the driver. The 104-dio-48e module is migrated to the new
i8255 library interface leveraging the gpio-regmap API.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/gpio/gpio-104-dio-48e.c | 137 ++------------------------------
 1 file changed, 7 insertions(+), 130 deletions(-)

diff --git a/drivers/gpio/gpio-104-dio-48e.c b/drivers/gpio/gpio-104-dio-48e.c
index e053a4e46b27..a3846faf3780 100644
--- a/drivers/gpio/gpio-104-dio-48e.c
+++ b/drivers/gpio/gpio-104-dio-48e.c
@@ -9,7 +9,6 @@
 #include <linux/bits.h>
 #include <linux/device.h>
 #include <linux/err.h>
-#include <linux/gpio/driver.h>
 #include <linux/ioport.h>
 #include <linux/irq.h>
 #include <linux/isa.h>
@@ -42,90 +41,6 @@ MODULE_PARM_DESC(irq, "ACCES 104-DIO-48E interrupt line numbers");
 
 #define DIO48E_NUM_PPI 2
 
-/**
- * struct dio48e_reg - device register structure
- * @ppi:		Programmable Peripheral Interface groups
- */
-struct dio48e_reg {
-	struct i8255 ppi[DIO48E_NUM_PPI];
-};
-
-/**
- * struct dio48e_gpio - GPIO device private data structure
- * @chip:		instance of the gpio_chip
- * @ppi_state:		PPI device states
- * @reg:		I/O address offset for the device registers
- */
-struct dio48e_gpio {
-	struct gpio_chip chip;
-	struct i8255_state ppi_state[DIO48E_NUM_PPI];
-	struct dio48e_reg __iomem *reg;
-};
-
-static int dio48e_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
-{
-	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
-
-	if (i8255_get_direction(dio48egpio->ppi_state, offset))
-		return GPIO_LINE_DIRECTION_IN;
-
-	return GPIO_LINE_DIRECTION_OUT;
-}
-
-static int dio48e_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
-{
-	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
-
-	i8255_direction_input(dio48egpio->reg->ppi, dio48egpio->ppi_state,
-			      offset);
-
-	return 0;
-}
-
-static int dio48e_gpio_direction_output(struct gpio_chip *chip, unsigned int offset,
-					int value)
-{
-	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
-
-	i8255_direction_output(dio48egpio->reg->ppi, dio48egpio->ppi_state,
-			       offset, value);
-
-	return 0;
-}
-
-static int dio48e_gpio_get(struct gpio_chip *chip, unsigned int offset)
-{
-	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
-
-	return i8255_get(dio48egpio->reg->ppi, offset);
-}
-
-static int dio48e_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
-	unsigned long *bits)
-{
-	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
-
-	i8255_get_multiple(dio48egpio->reg->ppi, mask, bits, chip->ngpio);
-
-	return 0;
-}
-
-static void dio48e_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
-{
-	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
-
-	i8255_set(dio48egpio->reg->ppi, dio48egpio->ppi_state, offset, value);
-}
-
-static void dio48e_gpio_set_multiple(struct gpio_chip *chip,
-	unsigned long *mask, unsigned long *bits)
-{
-	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
-
-	i8255_set_multiple(dio48egpio->reg->ppi, dio48egpio->ppi_state, mask,
-			   bits, chip->ngpio);
-}
-
 static const struct regmap_range dio48e_wr_ranges[] = {
 	regmap_reg_range(0x0, 0x9), regmap_reg_range(0xB, 0xB),
 	regmap_reg_range(0xD, 0xD), regmap_reg_range(0xF, 0xF),
@@ -245,25 +160,10 @@ static int dio48e_irq_init_hw(struct regmap *const map)
 	return regmap_read(map, DIO48E_DISABLE_INTERRUPT, &val);
 }
 
-static void dio48e_init_ppi(struct i8255 __iomem *const ppi,
-			    struct i8255_state *const ppi_state)
-{
-	const unsigned long ngpio = 24;
-	const unsigned long mask = GENMASK(ngpio - 1, 0);
-	const unsigned long bits = 0;
-	unsigned long i;
-
-	/* Initialize all GPIO to output 0 */
-	for (i = 0; i < DIO48E_NUM_PPI; i++) {
-		i8255_mode0_output(&ppi[i]);
-		i8255_set_multiple(&ppi[i], &ppi_state[i], &mask, &bits, ngpio);
-	}
-}
-
 static int dio48e_probe(struct device *dev, unsigned int id)
 {
-	struct dio48e_gpio *dio48egpio;
 	const char *const name = dev_name(dev);
+	struct i8255_regmap_config config = {};
 	void __iomem *regs;
 	struct regmap *map;
 	int err;
@@ -271,10 +171,6 @@ static int dio48e_probe(struct device *dev, unsigned int id)
 	unsigned int irq_mask;
 	struct regmap_irq_chip_data *chip_data;
 
-	dio48egpio = devm_kzalloc(dev, sizeof(*dio48egpio), GFP_KERNEL);
-	if (!dio48egpio)
-		return -ENOMEM;
-
 	if (!devm_request_region(dev, base[id], DIO48E_EXTENT, name)) {
 		dev_err(dev, "Unable to lock port addresses (0x%X-0x%X)\n",
 			base[id], base[id] + DIO48E_EXTENT);
@@ -284,7 +180,6 @@ static int dio48e_probe(struct device *dev, unsigned int id)
 	regs = devm_ioport_map(dev, base[id], DIO48E_EXTENT);
 	if (!regs)
 		return -ENOMEM;
-	dio48egpio->reg = regs;
 
 	map = devm_regmap_init_mmio(dev, regs, &dio48e_regmap_config);
 	if (IS_ERR(map))
@@ -321,31 +216,13 @@ static int dio48e_probe(struct device *dev, unsigned int id)
 	if (err)
 		return dev_err_probe(dev, err, "IRQ registration failed\n");
 
-	dio48egpio->chip.label = name;
-	dio48egpio->chip.parent = dev;
-	dio48egpio->chip.owner = THIS_MODULE;
-	dio48egpio->chip.base = -1;
-	dio48egpio->chip.ngpio = DIO48E_NGPIO;
-	dio48egpio->chip.names = dio48e_names;
-	dio48egpio->chip.get_direction = dio48e_gpio_get_direction;
-	dio48egpio->chip.direction_input = dio48e_gpio_direction_input;
-	dio48egpio->chip.direction_output = dio48e_gpio_direction_output;
-	dio48egpio->chip.get = dio48e_gpio_get;
-	dio48egpio->chip.get_multiple = dio48e_gpio_get_multiple;
-	dio48egpio->chip.set = dio48e_gpio_set;
-	dio48egpio->chip.set_multiple = dio48e_gpio_set_multiple;
-
-	i8255_state_init(dio48egpio->ppi_state, DIO48E_NUM_PPI);
-	dio48e_init_ppi(dio48egpio->reg->ppi, dio48egpio->ppi_state);
-
-	err = devm_gpiochip_add_data(dev, &dio48egpio->chip, dio48egpio);
-	if (err) {
-		dev_err(dev, "GPIO registering failed (%d)\n", err);
-		return err;
-	}
+	config.parent = dev;
+	config.map = map;
+	config.num_ppi = DIO48E_NUM_PPI;
+	config.names = dio48e_names;
+	config.domain = regmap_irq_get_domain(chip_data);
 
-	return gpiochip_irqchip_add_domain(&dio48egpio->chip,
-					   regmap_irq_get_domain(chip_data));
+	return devm_i8255_regmap_register(dev, &config);
 }
 
 static struct isa_driver dio48e_driver = {
-- 
2.38.1


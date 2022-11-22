Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F046361B4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238694AbiKWO1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238028AbiKWO0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:26:16 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A462656F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:25:27 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id h16so2848627qtu.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJRh491Zgpxh8keQMALDUd7iJtOqvD26bSubs6KZMzY=;
        b=ZnKgW1Qs8LjbZcvLzWF+yN9qhoJhMCR2Dqydq+rQeq3jInS09AZoD7B01BhblCvACK
         tzyzZNzTMjUHYmAt231V6xSqI7OqrcovJQ6UPtFa8qRcmLQZD6N6di/mCGUrPIqKLY6e
         aMT1wGuvXWrC+ZzeibR2Jxv19GEicAhq0ZCToYtTYTs0/noVCboPVDbaJlgVCLMgIXC7
         qRhHmtOm3doHrA05F6qofW/DN059ehzEDmhEsNHqd66BIDbuhHAAt4fUiqKR6XCi9+UI
         6W42bo5t5lIuXiTIPQ8tT545XSfSRqFCjB66ca4kOBV7ojAQ5OHh6hbsDumuaj+c67u/
         wCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJRh491Zgpxh8keQMALDUd7iJtOqvD26bSubs6KZMzY=;
        b=LTVW/8FqKjd6V6xibvltu5+vPzBu28cayKq2JKr5VSXweHjpkU3HM2uoZ6Y+ALi3j2
         oK8MgDJGL7cU6kGZMX9QSxqi7hQtmN7lXpe6YjJBFhF/dbDBwgfQ3QTh8SNfXxBxZH27
         ECWc8JhFtsXppHoPZ4IvNIpCAiZTd5ohbDYfrgyq5BkRVtkfQuDLLgBoGH6ffc0QTu8O
         zUvpbO+TnqWY8a/tHD0+nsUjsdc7rvg2b6f2L1mpWyJfOrZvybt1DFNOMvUS+DkIsyKi
         2YHsJR+ffP1vTjEkPIWTcXcx147RpXGH2XcZNjGPg2FlbtfQrKdjskOEgr6qgK5lxy0B
         ZLqA==
X-Gm-Message-State: ANoB5pkoKXvUpkXksdXqlQYBkrGM6+rJd+ZxPC3d97ezTWZ/lBR85Nz2
        MM5RU+0XvdrOluxKhe86oVhzVA==
X-Google-Smtp-Source: AA0mqf4fzUMiro5kjBspsz4W93gxpPeqRcm2407PzOEDAmocGYggmINxxEN9q773XNGsDHu0r3WI9Q==
X-Received: by 2002:a05:622a:260d:b0:3a5:829a:7e92 with SMTP id ci13-20020a05622a260d00b003a5829a7e92mr12360406qtb.528.1669213521374;
        Wed, 23 Nov 2022 06:25:21 -0800 (PST)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id b28-20020a05620a127c00b006f9c2be0b4bsm11718802qkl.135.2022.11.23.06.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 06:25:20 -0800 (PST)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     andriy.shevchenko@linux.intel.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael@walle.cc, broonie@kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v3 5/9] gpio: 104-idi-48: Migrate to gpio-regmap API
Date:   Tue, 22 Nov 2022 02:11:02 -0500
Message-Id: <5cf249405b0ac5f7408ec06cf7a65382a2ef5126.1669100542.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1669100542.git.william.gray@linaro.org>
References: <cover.1669100542.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regmap API supports IO port accessors so we can take advantage of
regmap abstractions rather than handling access to the device registers
directly in the driver. Despite the underlying interface being based on
i8255, it is simpler to use the gpio-regmap API directly because the
104-IDI-48 device features only input signals. Therefore, the dependence
on the i8255 GPIO library is removed in this patch.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/gpio/Kconfig           |  2 +-
 drivers/gpio/gpio-104-idi-48.c | 97 +++++++---------------------------
 2 files changed, 21 insertions(+), 78 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 6892979e511a..dd34039fc31b 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -873,7 +873,7 @@ config GPIO_104_IDI_48
 	select ISA_BUS_API
 	select REGMAP_IRQ
 	select GPIOLIB_IRQCHIP
-	select GPIO_I8255
+	select GPIO_REGMAP
 	help
 	  Enables GPIO support for the ACCES 104-IDI-48 family (104-IDI-48A,
 	  104-IDI-48AC, 104-IDI-48B, 104-IDI-48BC). The base port addresses for
diff --git a/drivers/gpio/gpio-104-idi-48.c b/drivers/gpio/gpio-104-idi-48.c
index f77c05571062..2584f411ae67 100644
--- a/drivers/gpio/gpio-104-idi-48.c
+++ b/drivers/gpio/gpio-104-idi-48.c
@@ -9,7 +9,7 @@
 #include <linux/bits.h>
 #include <linux/device.h>
 #include <linux/err.h>
-#include <linux/gpio/driver.h>
+#include <linux/gpio/regmap.h>
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
 #include <linux/irq.h>
@@ -20,10 +20,6 @@
 #include <linux/regmap.h>
 #include <linux/types.h>
 
-#include "gpio-i8255.h"
-
-MODULE_IMPORT_NS(I8255);
-
 #define IDI_48_EXTENT 8
 #define MAX_NUM_IDI_48 max_num_isa_dev(IDI_48_EXTENT)
 
@@ -40,56 +36,17 @@ MODULE_PARM_DESC(irq, "ACCES 104-IDI-48 interrupt line numbers");
 #define IDI48_IRQ_STATUS 0x7
 #define IDI48_IRQ_ENABLE IDI48_IRQ_STATUS
 
-/**
- * struct idi_48_reg - device register structure
- * @port0:	Port 0 Inputs
- * @unused:	Unused
- * @port1:	Port 1 Inputs
- * @irq:	Read: IRQ Status Register/IRQ Clear
- *		Write: IRQ Enable/Disable
- */
-struct idi_48_reg {
-	u8 port0[3];
-	u8 unused;
-	u8 port1[3];
-	u8 irq;
-};
-
-/**
- * struct idi_48_gpio - GPIO device private data structure
- * @chip:	instance of the gpio_chip
- * @reg:	I/O address offset for the device registers
- */
-struct idi_48_gpio {
-	struct gpio_chip chip;
-	struct idi_48_reg __iomem *reg;
-};
-
-static int idi_48_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
-{
-	return GPIO_LINE_DIRECTION_IN;
-}
-
-static int idi_48_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
-{
-	return 0;
-}
-
-static int idi_48_gpio_get(struct gpio_chip *chip, unsigned int offset)
-{
-	struct idi_48_gpio *const idi48gpio = gpiochip_get_data(chip);
-	void __iomem *const ppi = idi48gpio->reg;
-
-	return i8255_get(ppi, offset);
-}
-
-static int idi_48_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
-	unsigned long *bits)
+static int idi_48_reg_mask_xlate(struct gpio_regmap *gpio, unsigned int base,
+				 unsigned int offset, unsigned int *reg,
+				 unsigned int *mask)
 {
-	struct idi_48_gpio *const idi48gpio = gpiochip_get_data(chip);
-	void __iomem *const ppi = idi48gpio->reg;
+	const unsigned int line = offset % 8;
+	const unsigned int stride = offset / 8;
+	const unsigned int port = (stride / 3) * 4;
+	const unsigned int port_stride = stride % 3;
 
-	i8255_get_multiple(ppi, mask, bits, chip->ngpio);
+	*reg = base + port + port_stride;
+	*mask = BIT(line);
 
 	return 0;
 }
@@ -166,18 +123,14 @@ static const char *idi48_names[IDI48_NGPIO] = {
 
 static int idi_48_probe(struct device *dev, unsigned int id)
 {
-	struct idi_48_gpio *idi48gpio;
 	const char *const name = dev_name(dev);
+	struct gpio_regmap_config config = {0};
 	void __iomem *regs;
 	struct regmap *map;
 	struct regmap_irq_chip *chip;
 	struct regmap_irq_chip_data *chip_data;
 	int err;
 
-	idi48gpio = devm_kzalloc(dev, sizeof(*idi48gpio), GFP_KERNEL);
-	if (!idi48gpio)
-		return -ENOMEM;
-
 	if (!devm_request_region(dev, base[id], IDI_48_EXTENT, name)) {
 		dev_err(dev, "Unable to lock port addresses (0x%X-0x%X)\n",
 			base[id], base[id] + IDI_48_EXTENT);
@@ -187,7 +140,6 @@ static int idi_48_probe(struct device *dev, unsigned int id)
 	regs = devm_ioport_map(dev, base[id], IDI_48_EXTENT);
 	if (!regs)
 		return -ENOMEM;
-	idi48gpio->reg = regs;
 
 	map = devm_regmap_init_mmio(dev, regs, &idi48_regmap_config);
 	if (IS_ERR(map))
@@ -212,25 +164,16 @@ static int idi_48_probe(struct device *dev, unsigned int id)
 		return err;
 	}
 
-	idi48gpio->chip.label = name;
-	idi48gpio->chip.parent = dev;
-	idi48gpio->chip.owner = THIS_MODULE;
-	idi48gpio->chip.base = -1;
-	idi48gpio->chip.ngpio = IDI48_NGPIO;
-	idi48gpio->chip.names = idi48_names;
-	idi48gpio->chip.get_direction = idi_48_gpio_get_direction;
-	idi48gpio->chip.direction_input = idi_48_gpio_direction_input;
-	idi48gpio->chip.get = idi_48_gpio_get;
-	idi48gpio->chip.get_multiple = idi_48_gpio_get_multiple;
-
-	err = devm_gpiochip_add_data(dev, &idi48gpio->chip, idi48gpio);
-	if (err) {
-		dev_err(dev, "GPIO registering failed (%d)\n", err);
-		return err;
-	}
+	config.parent = dev;
+	config.regmap = map;
+	config.ngpio = IDI48_NGPIO;
+	config.names = idi48_names;
+	config.reg_dat_base = GPIO_REGMAP_ADDR(0x0);
+	config.ngpio_per_reg = 8;
+	config.reg_mask_xlate = idi_48_reg_mask_xlate;
+	config.irq_domain = regmap_irq_get_domain(chip_data);
 
-	return gpiochip_irqchip_add_domain(&idi48gpio->chip,
-					   regmap_irq_get_domain(chip_data));
+	return PTR_ERR_OR_ZERO(devm_gpio_regmap_register(dev, &config));
 }
 
 static struct isa_driver idi_48_driver = {
-- 
2.38.1


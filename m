Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB686656BE7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 15:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbiL0Od1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 09:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbiL0Oct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 09:32:49 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143CAA47F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 06:32:48 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id o66so12544275oia.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 06:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNp7uGPW9jsY51/S2PIwAMe5JoUFVPui7ZQaf3/kblM=;
        b=MpJ7UksEgNqMArIicRBKncWVhZ3fUx23I+v+lt/iNBdbXZjQDZ/pDBuP0I41VdNCNs
         2/zcOaU4p2hAyAP0C48qGV89sRLZR5fVBJ2LcZJ8CDVxeMMO95lUVZGTEK7LjcJMTXiO
         P3v5StHw7Hxwr0aYoUOk9jyo8L/p7BuymvALPchbyu3WMHvlJl7OmHGCr3/cCbQHfSfo
         1rZRT5ifuxwoKu3VaDQNLVX1tTTVa5x1enqxuN9LOdZSdv0RPPLDg8D6ozUIwHLv121Z
         fo7VbVFTGwRXJeDKhZBhKgHNCUCqtvkeZg3mhmJ9lEwEYwzUhJb3nN1s/HlrZKULkDY7
         gtGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WNp7uGPW9jsY51/S2PIwAMe5JoUFVPui7ZQaf3/kblM=;
        b=wfkMLWTAbZ9ddjFkKivrBF8PFK1BTAe4TfifhnRE8zj27z5OGVltHA0abWWWcNSJtX
         SVfYhosqKPD4iPGMoVo33qeOP/FJuPBNiMN8MaFjtYsyEBG6uYnqagw/xO3CKdKBnk8K
         SPaBNgR56RE+YZ9JGGtBMdNi29AntnTFcvqfInuo2C78PIB/EZOHUdUJpUJvvxXOWYz9
         C6k8T5/4EHo+/RbOTSTzjA+vyMyJpafasZYAGtU3pfC84QLIvC7MN3pwIdBN9eplAwW8
         rb6yQO6ECZhjYqEcMXEDh8FQqEOFAdPeVsdaIt/4MXYFWobVQhwRlG9fTXvW4yrd9+pi
         a7+w==
X-Gm-Message-State: AFqh2kq/gQMrNtzYOksNkMTbooAfVwEm69CrWfglds92rXDj7r8kWu6t
        YInJ+bafeG4WOMJZp7Y6z39BCw==
X-Google-Smtp-Source: AMrXdXsnKZngJL9r7cJVLTar4E9TmuVww7mUq92OtMTyQJVbMlCThQ6wH0M39D4D6QpB2VWSWUR2JA==
X-Received: by 2002:a05:6808:1b12:b0:35a:463e:258d with SMTP id bx18-20020a0568081b1200b0035a463e258dmr11843405oib.5.1672151567386;
        Tue, 27 Dec 2022 06:32:47 -0800 (PST)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id q205-20020acac0d6000000b0035bce2a39c7sm5864969oif.21.2022.12.27.06.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 06:32:47 -0800 (PST)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     andriy.shevchenko@linux.intel.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael@walle.cc,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v5 4/8] gpio: 104-idi-48: Migrate to gpio-regmap API
Date:   Tue, 27 Dec 2022 09:09:42 -0500
Message-Id: <1219e41557e5426e1486e56a5c9318bd3acc2f37.1672149007.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1672149007.git.william.gray@linaro.org>
References: <cover.1672149007.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/gpio/Kconfig           |  2 +-
 drivers/gpio/gpio-104-idi-48.c | 97 +++++++---------------------------
 2 files changed, 21 insertions(+), 78 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 30f9e3f48559..84316924574f 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -875,7 +875,7 @@ config GPIO_104_IDI_48
 	select REGMAP_MMIO
 	select REGMAP_IRQ
 	select GPIOLIB_IRQCHIP
-	select GPIO_I8255
+	select GPIO_REGMAP
 	help
 	  Enables GPIO support for the ACCES 104-IDI-48 family (104-IDI-48A,
 	  104-IDI-48AC, 104-IDI-48B, 104-IDI-48BC). The base port addresses for
diff --git a/drivers/gpio/gpio-104-idi-48.c b/drivers/gpio/gpio-104-idi-48.c
index f936e3e0ff12..ca2175b84e24 100644
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
+static int idi_48_reg_mask_xlate(struct gpio_regmap *gpio, unsigned int base,
+				 unsigned int offset, unsigned int *reg,
+				 unsigned int *mask)
 {
-	return 0;
-}
-
-static int idi_48_gpio_get(struct gpio_chip *chip, unsigned int offset)
-{
-	struct idi_48_gpio *const idi48gpio = gpiochip_get_data(chip);
-	void __iomem *const ppi = idi48gpio->reg;
+	const unsigned int line = offset % 8;
+	const unsigned int stride = offset / 8;
+	const unsigned int port = (stride / 3) * 4;
+	const unsigned int port_stride = stride % 3;
 
-	return i8255_get(ppi, offset);
-}
-
-static int idi_48_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
-	unsigned long *bits)
-{
-	struct idi_48_gpio *const idi48gpio = gpiochip_get_data(chip);
-	void __iomem *const ppi = idi48gpio->reg;
-
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
+	struct gpio_regmap_config config = {};
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
@@ -211,25 +163,16 @@ static int idi_48_probe(struct device *dev, unsigned int id)
 	if (err)
 		return dev_err_probe(dev, err, "IRQ registration failed\n");
 
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


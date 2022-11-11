Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3F8626D48
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 02:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbiKMBKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 20:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235142AbiKMBJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 20:09:53 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053D213F41
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 17:09:51 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id s4so5040036qtx.6
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 17:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/0JAbgjN2ElnKmRPhHAgembeeaVqiU36Slm+rVKp9k=;
        b=ezo3S942E9hVJBAs51k4EM965jR7Z6tdzr/GQLKiVjTNucafe52rtZzKwKP9qWu+fF
         ZiIIBmegw6ZGgNRm6banlMgBcutmT2jyKzlrVyolze6HTB68CfOqM3p27XYnQNNcbiyF
         0R/5WEuKR8R4xH87S58avA/u7xwGMwcfs7odMX/g/NXmMG6PHUG8NIQ75dZWbTnqEkI+
         hqWGOymdUK1uQ/sW1AwqqOqWw4ZQk3Aft8ZIva2rqXB+uItVbG9AWkZt5wD14MLHJfAr
         0OTdKeYa7a1l1DEg25onVzmVcvFj9Dyy3oGWGLeqacevikMF1k4rM9Jy/Hg8wf83Upni
         GBVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M/0JAbgjN2ElnKmRPhHAgembeeaVqiU36Slm+rVKp9k=;
        b=7ZgiYnGNfU8R943Yd7woEeFlLBbJ2XDIlmIQPn9FH7xLn20kNQ//z2OZwc8nyoO2lc
         M3P38nBX6Q/SUhx8Vnoe9ZgOC/X9SIHHC8+JnywisChy2wdEC5O7Jc3t9A+0HyYnrRGH
         IR/UcpTwAXFBxmsRbtNaExqtBCJEHlon9aXPxvHpTIE3KvnWAKF6aIpIVQUnU8TbiX1V
         dr1XJIcd7oAXaxfVsq2az7sNKu6dhS97+OLF9TGPt1ilerCFp3/qM9XArNTgPXvxF/Aq
         kg5rrTWM0lUN7PNwX8zKXuuuoZHTmp4DDVX1cJj7uv74GruMf8Q04qQD4zehfk4uK2i5
         kCew==
X-Gm-Message-State: ANoB5pmumyV/G6grBRl6sj1/6YOyhu3HorxecsSB457mPRo8ZrRNJtD8
        x5R+8bpMronpuRA1sHDL0kafOg==
X-Google-Smtp-Source: AA0mqf6m3cxnqqSVeTjtP/3SJ0hfuzoG1Gq+nKKMz4MOBS5JDTgRGmc2GWvxPR5amSXzWlTk/aRgLw==
X-Received: by 2002:ac8:140e:0:b0:398:5f25:649 with SMTP id k14-20020ac8140e000000b003985f250649mr7260742qtj.673.1668301790391;
        Sat, 12 Nov 2022 17:09:50 -0800 (PST)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id t6-20020a05622a180600b00343057845f7sm3552498qtc.20.2022.11.12.17.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 17:09:49 -0800 (PST)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     andriy.shevchenko@linux.intel.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael@walle.cc, broonie@kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v2 4/4] gpio: i8255: Migrate to regmap API
Date:   Thu, 10 Nov 2022 20:55:53 -0500
Message-Id: <61327a67cc308af413471a69a4810b2785e53e8e.1668129763.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1668129763.git.william.gray@linaro.org>
References: <cover.1668129763.git.william.gray@linaro.org>
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
directly in the driver. The 104-dio-48e and gpio-mm modules depend on
the i8255 library and are thus updated accordingly.

By leveraging the gpio_regmap API, the i8255 library is reduced to
simply a devm_i8255_regmap_register() function, a configuration
structure struct i8255_regmap_config, and a helper macro
i8255_volatile_regmap_range() provided to simplify volatile PPI register
hinting for the regmap.

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/gpio/Kconfig            |   2 +
 drivers/gpio/gpio-104-dio-48e.c | 397 ++++++++++-------------------
 drivers/gpio/gpio-gpio-mm.c     | 151 +++--------
 drivers/gpio/gpio-i8255.c       | 429 +++++++++++---------------------
 drivers/gpio/gpio-i8255.h       |  80 +++---
 5 files changed, 337 insertions(+), 722 deletions(-)
 rewrite drivers/gpio/gpio-i8255.c (89%)
 rewrite drivers/gpio/gpio-i8255.h (89%)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index a9852782566d..7e1c89c4cb17 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -831,6 +831,7 @@ menu "Port-mapped I/O GPIO drivers"
 
 config GPIO_I8255
 	tristate
+	select GPIO_REGMAP
 	help
 	  Enables support for the i8255 interface library functions. The i8255
 	  interface library provides functions to facilitate communication with
@@ -846,6 +847,7 @@ config GPIO_104_DIO_48E
 	depends on PC104
 	select ISA_BUS_API
 	select GPIOLIB_IRQCHIP
+	select REGMAP_IRQ
 	select GPIO_I8255
 	help
 	  Enables GPIO support for the ACCES 104-DIO-48E series (104-DIO-48E,
diff --git a/drivers/gpio/gpio-104-dio-48e.c b/drivers/gpio/gpio-104-dio-48e.c
index 7b8829c8e423..b6905bc39303 100644
--- a/drivers/gpio/gpio-104-dio-48e.c
+++ b/drivers/gpio/gpio-104-dio-48e.c
@@ -8,17 +8,14 @@
  */
 #include <linux/bits.h>
 #include <linux/device.h>
-#include <linux/errno.h>
-#include <linux/gpio/driver.h>
-#include <linux/io.h>
+#include <linux/err.h>
 #include <linux/ioport.h>
-#include <linux/interrupt.h>
-#include <linux/irqdesc.h>
+#include <linux/irq.h>
 #include <linux/isa.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/spinlock.h>
+#include <linux/regmap.h>
 #include <linux/types.h>
 
 #include "gpio-i8255.h"
@@ -38,212 +35,102 @@ static unsigned int num_irq;
 module_param_hw_array(irq, uint, irq, &num_irq, 0);
 MODULE_PARM_DESC(irq, "ACCES 104-DIO-48E interrupt line numbers");
 
+#define DIO48E_ENABLE_INTERRUPT 0xB
+#define DIO48E_DISABLE_INTERRUPT DIO48E_ENABLE_INTERRUPT
+#define DIO48E_CLEAR_INTERRUPT 0xF
+
 #define DIO48E_NUM_PPI 2
 
-/**
- * struct dio48e_reg - device register structure
- * @ppi:		Programmable Peripheral Interface groups
- * @enable_buffer:	Enable/Disable Buffer groups
- * @unused1:		Unused
- * @enable_interrupt:	Write: Enable Interrupt
- *			Read: Disable Interrupt
- * @unused2:		Unused
- * @enable_counter:	Write: Enable Counter/Timer Addressing
- *			Read: Disable Counter/Timer Addressing
- * @unused3:		Unused
- * @clear_interrupt:	Clear Interrupt
- */
-struct dio48e_reg {
-	struct i8255 ppi[DIO48E_NUM_PPI];
-	u8 enable_buffer[DIO48E_NUM_PPI];
-	u8 unused1;
-	u8 enable_interrupt;
-	u8 unused2;
-	u8 enable_counter;
-	u8 unused3;
-	u8 clear_interrupt;
+static const struct regmap_range dio48e_wr_ranges[] = {
+	regmap_reg_range(0x0, 0x9), regmap_reg_range(0xB, 0xB),
+	regmap_reg_range(0xD, 0xD), regmap_reg_range(0xF, 0xF),
+};
+static const struct regmap_range dio48e_rd_ranges[] = {
+	regmap_reg_range(0x0, 0x2), regmap_reg_range(0x4, 0x6),
+	regmap_reg_range(0xB, 0xB), regmap_reg_range(0xD, 0xD),
+	regmap_reg_range(0xF, 0xF),
+};
+static const struct regmap_range dio48e_volatile_ranges[] = {
+	i8255_volatile_regmap_range(0x0), i8255_volatile_regmap_range(0x4),
+	regmap_reg_range(0xB, 0xB), regmap_reg_range(0xD, 0xD),
+	regmap_reg_range(0xF, 0xF),
+};
+static const struct regmap_range dio48e_precious_ranges[] = {
+	regmap_reg_range(0xB, 0xB), regmap_reg_range(0xD, 0xD),
+	regmap_reg_range(0xF, 0xF),
+};
+static const struct regmap_access_table dio48e_wr_table = {
+	.yes_ranges = dio48e_wr_ranges,
+	.n_yes_ranges = ARRAY_SIZE(dio48e_wr_ranges),
+};
+static const struct regmap_access_table dio48e_rd_table = {
+	.yes_ranges = dio48e_rd_ranges,
+	.n_yes_ranges = ARRAY_SIZE(dio48e_rd_ranges),
+};
+static const struct regmap_access_table dio48e_volatile_table = {
+	.yes_ranges = dio48e_volatile_ranges,
+	.n_yes_ranges = ARRAY_SIZE(dio48e_volatile_ranges),
+};
+static const struct regmap_access_table dio48e_precious_table = {
+	.yes_ranges = dio48e_precious_ranges,
+	.n_yes_ranges = ARRAY_SIZE(dio48e_precious_ranges),
+};
+static const struct regmap_config dio48e_regmap_config = {
+	.reg_bits = 8,
+	.reg_stride = 1,
+	.val_bits = 8,
+	.io_port = true,
+	.max_register = 0xF,
+	.wr_table = &dio48e_wr_table,
+	.rd_table = &dio48e_rd_table,
+	.volatile_table = &dio48e_volatile_table,
+	.precious_table = &dio48e_precious_table,
+	.cache_type = REGCACHE_FLAT,
 };
 
-/**
- * struct dio48e_gpio - GPIO device private data structure
- * @chip:		instance of the gpio_chip
- * @ppi_state:		PPI device states
- * @lock:		synchronization lock to prevent I/O race conditions
- * @reg:		I/O address offset for the device registers
- * @irq_mask:		I/O bits affected by interrupts
- */
-struct dio48e_gpio {
-	struct gpio_chip chip;
-	struct i8255_state ppi_state[DIO48E_NUM_PPI];
-	raw_spinlock_t lock;
-	struct dio48e_reg __iomem *reg;
-	unsigned char irq_mask;
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
-static void dio48e_irq_ack(struct irq_data *data)
-{
-}
-
-static void dio48e_irq_mask(struct irq_data *data)
-{
-	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
-	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
-	const unsigned long offset = irqd_to_hwirq(data);
-	unsigned long flags;
-
-	/* only bit 3 on each respective Port C supports interrupts */
-	if (offset != 19 && offset != 43)
-		return;
-
-	raw_spin_lock_irqsave(&dio48egpio->lock, flags);
-
-	if (offset == 19)
-		dio48egpio->irq_mask &= ~BIT(0);
-	else
-		dio48egpio->irq_mask &= ~BIT(1);
-	gpiochip_disable_irq(chip, offset);
-
-	if (!dio48egpio->irq_mask)
-		/* disable interrupts */
-		ioread8(&dio48egpio->reg->enable_interrupt);
-
-	raw_spin_unlock_irqrestore(&dio48egpio->lock, flags);
-}
-
-static void dio48e_irq_unmask(struct irq_data *data)
-{
-	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
-	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
-	const unsigned long offset = irqd_to_hwirq(data);
-	unsigned long flags;
-
-	/* only bit 3 on each respective Port C supports interrupts */
-	if (offset != 19 && offset != 43)
-		return;
-
-	raw_spin_lock_irqsave(&dio48egpio->lock, flags);
-
-	if (!dio48egpio->irq_mask) {
-		/* enable interrupts */
-		iowrite8(0x00, &dio48egpio->reg->clear_interrupt);
-		iowrite8(0x00, &dio48egpio->reg->enable_interrupt);
+/* only bit 3 on each respective Port C supports interrupts */
+#define DIO48E_REGMAP_IRQ(_ppi) \
+	[19 + (_ppi) * 24] = { \
+		.mask = BIT(_ppi), \
+		.type = { .types_supported = IRQ_TYPE_EDGE_RISING, }, \
 	}
 
-	gpiochip_enable_irq(chip, offset);
-	if (offset == 19)
-		dio48egpio->irq_mask |= BIT(0);
-	else
-		dio48egpio->irq_mask |= BIT(1);
-
-	raw_spin_unlock_irqrestore(&dio48egpio->lock, flags);
-}
-
-static int dio48e_irq_set_type(struct irq_data *data, unsigned int flow_type)
-{
-	const unsigned long offset = irqd_to_hwirq(data);
-
-	/* only bit 3 on each respective Port C supports interrupts */
-	if (offset != 19 && offset != 43)
-		return -EINVAL;
-
-	if (flow_type != IRQ_TYPE_NONE && flow_type != IRQ_TYPE_EDGE_RISING)
-		return -EINVAL;
-
-	return 0;
-}
-
-static const struct irq_chip dio48e_irqchip = {
-	.name = "104-dio-48e",
-	.irq_ack = dio48e_irq_ack,
-	.irq_mask = dio48e_irq_mask,
-	.irq_unmask = dio48e_irq_unmask,
-	.irq_set_type = dio48e_irq_set_type,
-	.flags = IRQCHIP_IMMUTABLE,
-	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+static const struct regmap_irq dio48e_regmap_irqs[] = {
+	DIO48E_REGMAP_IRQ(0), DIO48E_REGMAP_IRQ(1),
 };
 
-static irqreturn_t dio48e_irq_handler(int irq, void *dev_id)
+static int dio48e_handle_mask_sync(struct regmap *const map, const int index,
+				   const unsigned int mask_buf_def,
+				   const unsigned int mask_buf,
+				   void *const irq_drv_data)
 {
-	struct dio48e_gpio *const dio48egpio = dev_id;
-	struct gpio_chip *const chip = &dio48egpio->chip;
-	const unsigned long irq_mask = dio48egpio->irq_mask;
-	unsigned long gpio;
+	unsigned int *const irq_mask = irq_drv_data;
+	const unsigned int prev_irq_mask = *irq_mask;
+	const bool mask_change = (mask_buf != prev_irq_mask);
+	const bool interrupts_disabled = (prev_irq_mask == mask_buf_def);
+	const bool all_masked = (mask_buf == mask_buf_def);
+	unsigned int val;
+	int err;
 
-	for_each_set_bit(gpio, &irq_mask, 2)
-		generic_handle_domain_irq(chip->irq.domain,
-					  19 + gpio*24);
+	/* exit early if no change */
+	if (!mask_change)
+		return 0;
 
-	raw_spin_lock(&dio48egpio->lock);
+	*irq_mask = mask_buf;
 
-	iowrite8(0x00, &dio48egpio->reg->clear_interrupt);
+	if (interrupts_disabled) {
+		/* enable interrupts */
+		err = regmap_write(map, DIO48E_ENABLE_INTERRUPT, 0x00);
+		if (err)
+			return err;
+	} else if (all_masked) {
+		/* disable interrupts */
+		err = regmap_read(map, DIO48E_DISABLE_INTERRUPT, &val);
+		if (err)
+			return err;
+	}
 
-	raw_spin_unlock(&dio48egpio->lock);
-
-	return IRQ_HANDLED;
+	return 0;
 }
 
 #define DIO48E_NGPIO 48
@@ -266,41 +153,17 @@ static const char *dio48e_names[DIO48E_NGPIO] = {
 	"PPI Group 1 Port C 5", "PPI Group 1 Port C 6", "PPI Group 1 Port C 7"
 };
 
-static int dio48e_irq_init_hw(struct gpio_chip *gc)
-{
-	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(gc);
-
-	/* Disable IRQ by default */
-	ioread8(&dio48egpio->reg->enable_interrupt);
-
-	return 0;
-}
-
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
-	struct gpio_irq_chip *girq;
+	struct i8255_regmap_config config = {0};
+	void __iomem *regs;
+	struct regmap *map;
+	unsigned int val;
 	int err;
-
-	dio48egpio = devm_kzalloc(dev, sizeof(*dio48egpio), GFP_KERNEL);
-	if (!dio48egpio)
-		return -ENOMEM;
+	struct regmap_irq_chip *chip;
+	unsigned int irq_mask;
+	struct regmap_irq_chip_data *chip_data;
 
 	if (!devm_request_region(dev, base[id], DIO48E_EXTENT, name)) {
 		dev_err(dev, "Unable to lock port addresses (0x%X-0x%X)\n",
@@ -308,53 +171,55 @@ static int dio48e_probe(struct device *dev, unsigned int id)
 		return -EBUSY;
 	}
 
-	dio48egpio->reg = devm_ioport_map(dev, base[id], DIO48E_EXTENT);
-	if (!dio48egpio->reg)
+	regs = devm_ioport_map(dev, base[id], DIO48E_EXTENT);
+	if (!regs)
 		return -ENOMEM;
 
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
+	map = devm_regmap_init_mmio(dev, regs, &dio48e_regmap_config);
+	if (IS_ERR(map))
+		return PTR_ERR(map);
 
-	girq = &dio48egpio->chip.irq;
-	gpio_irq_chip_set_chip(girq, &dio48e_irqchip);
-	/* This will let us handle the parent IRQ in the driver */
-	girq->parent_handler = NULL;
-	girq->num_parents = 0;
-	girq->parents = NULL;
-	girq->default_type = IRQ_TYPE_NONE;
-	girq->handler = handle_edge_irq;
-	girq->init_hw = dio48e_irq_init_hw;
+	/* Initialize device interrupt state */
+	err = regmap_read(map, DIO48E_DISABLE_INTERRUPT, &val);
+	if (err)
+		return err;
+	err = regmap_write(map, DIO48E_CLEAR_INTERRUPT, 0x00);
+	if (err)
+		return err;
 
-	raw_spin_lock_init(&dio48egpio->lock);
+	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
 
-	i8255_state_init(dio48egpio->ppi_state, DIO48E_NUM_PPI);
-	dio48e_init_ppi(dio48egpio->reg->ppi, dio48egpio->ppi_state);
+	chip->irq_drv_data = devm_kzalloc(dev, sizeof(irq_mask), GFP_KERNEL);
+	if (!chip->irq_drv_data)
+		return -ENOMEM;
 
-	err = devm_gpiochip_add_data(dev, &dio48egpio->chip, dio48egpio);
+	chip->name = name;
+	/* No IRQ status register so use CLEAR_INTERRUPT register instead */
+	chip->status_base = DIO48E_CLEAR_INTERRUPT;
+	chip->mask_base = DIO48E_ENABLE_INTERRUPT;
+	chip->clear_on_unmask = true;
+	chip->status_invert = true;
+	chip->num_regs = 1;
+	chip->irqs = dio48e_regmap_irqs;
+	chip->num_irqs = ARRAY_SIZE(dio48e_regmap_irqs);
+	chip->handle_mask_sync = dio48e_handle_mask_sync;
+
+	err = devm_regmap_add_irq_chip(dev, map, irq[id], 0, 0, chip,
+				       &chip_data);
 	if (err) {
-		dev_err(dev, "GPIO registering failed (%d)\n", err);
+		dev_err(dev, "IRQ registration failed (%d)\n", err);
 		return err;
 	}
 
-	err = devm_request_irq(dev, irq[id], dio48e_irq_handler, 0, name,
-		dio48egpio);
-	if (err) {
-		dev_err(dev, "IRQ handler registering failed (%d)\n", err);
-		return err;
-	}
+	config.parent = dev;
+	config.map = map;
+	config.num_ppi = DIO48E_NUM_PPI;
+	config.names = dio48e_names;
+	config.domain = regmap_irq_get_domain(chip_data);
 
-	return 0;
+	return devm_i8255_regmap_register(dev, &config);
 }
 
 static struct isa_driver dio48e_driver = {
diff --git a/drivers/gpio/gpio-gpio-mm.c b/drivers/gpio/gpio-gpio-mm.c
index 2689671b6b01..ba8847485660 100644
--- a/drivers/gpio/gpio-gpio-mm.c
+++ b/drivers/gpio/gpio-gpio-mm.c
@@ -8,13 +8,13 @@
  */
 #include <linux/device.h>
 #include <linux/errno.h>
-#include <linux/gpio/driver.h>
-#include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/isa.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
 
 #include "gpio-i8255.h"
 
@@ -30,83 +30,22 @@ MODULE_PARM_DESC(base, "Diamond Systems GPIO-MM base addresses");
 
 #define GPIOMM_NUM_PPI 2
 
-/**
- * struct gpiomm_gpio - GPIO device private data structure
- * @chip:		instance of the gpio_chip
- * @ppi_state:		Programmable Peripheral Interface group states
- * @ppi:		Programmable Peripheral Interface groups
- */
-struct gpiomm_gpio {
-	struct gpio_chip chip;
-	struct i8255_state ppi_state[GPIOMM_NUM_PPI];
-	struct i8255 __iomem *ppi;
+static const struct regmap_range gpiomm_volatile_ranges[] = {
+	i8255_volatile_regmap_range(0x0), i8255_volatile_regmap_range(0x4),
+};
+static const struct regmap_access_table gpiomm_volatile_table = {
+	.yes_ranges = gpiomm_volatile_ranges,
+	.n_yes_ranges = ARRAY_SIZE(gpiomm_volatile_ranges),
+};
+static const struct regmap_config gpiomm_regmap_config = {
+	.reg_bits = 8,
+	.reg_stride = 1,
+	.val_bits = 8,
+	.io_port = true,
+	.max_register = 0x7,
+	.volatile_table = &gpiomm_volatile_table,
+	.cache_type = REGCACHE_FLAT,
 };
-
-static int gpiomm_gpio_get_direction(struct gpio_chip *chip,
-	unsigned int offset)
-{
-	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
-
-	if (i8255_get_direction(gpiommgpio->ppi_state, offset))
-		return GPIO_LINE_DIRECTION_IN;
-
-	return GPIO_LINE_DIRECTION_OUT;
-}
-
-static int gpiomm_gpio_direction_input(struct gpio_chip *chip,
-	unsigned int offset)
-{
-	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
-
-	i8255_direction_input(gpiommgpio->ppi, gpiommgpio->ppi_state, offset);
-
-	return 0;
-}
-
-static int gpiomm_gpio_direction_output(struct gpio_chip *chip,
-	unsigned int offset, int value)
-{
-	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
-
-	i8255_direction_output(gpiommgpio->ppi, gpiommgpio->ppi_state, offset,
-			       value);
-
-	return 0;
-}
-
-static int gpiomm_gpio_get(struct gpio_chip *chip, unsigned int offset)
-{
-	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
-
-	return i8255_get(gpiommgpio->ppi, offset);
-}
-
-static int gpiomm_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
-	unsigned long *bits)
-{
-	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
-
-	i8255_get_multiple(gpiommgpio->ppi, mask, bits, chip->ngpio);
-
-	return 0;
-}
-
-static void gpiomm_gpio_set(struct gpio_chip *chip, unsigned int offset,
-	int value)
-{
-	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
-
-	i8255_set(gpiommgpio->ppi, gpiommgpio->ppi_state, offset, value);
-}
-
-static void gpiomm_gpio_set_multiple(struct gpio_chip *chip,
-	unsigned long *mask, unsigned long *bits)
-{
-	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
-
-	i8255_set_multiple(gpiommgpio->ppi, gpiommgpio->ppi_state, mask, bits,
-			   chip->ngpio);
-}
 
 #define GPIOMM_NGPIO 48
 static const char *gpiomm_names[GPIOMM_NGPIO] = {
@@ -120,30 +59,11 @@ static const char *gpiomm_names[GPIOMM_NGPIO] = {
 	"Port 2C2", "Port 2C3", "Port 2C4", "Port 2C5", "Port 2C6", "Port 2C7",
 };
 
-static void gpiomm_init_dio(struct i8255 __iomem *const ppi,
-			    struct i8255_state *const ppi_state)
-{
-	const unsigned long ngpio = 24;
-	const unsigned long mask = GENMASK(ngpio - 1, 0);
-	const unsigned long bits = 0;
-	unsigned long i;
-
-	/* Initialize all GPIO to output 0 */
-	for (i = 0; i < GPIOMM_NUM_PPI; i++) {
-		i8255_mode0_output(&ppi[i]);
-		i8255_set_multiple(&ppi[i], &ppi_state[i], &mask, &bits, ngpio);
-	}
-}
-
 static int gpiomm_probe(struct device *dev, unsigned int id)
 {
-	struct gpiomm_gpio *gpiommgpio;
 	const char *const name = dev_name(dev);
-	int err;
-
-	gpiommgpio = devm_kzalloc(dev, sizeof(*gpiommgpio), GFP_KERNEL);
-	if (!gpiommgpio)
-		return -ENOMEM;
+	struct i8255_regmap_config config = {0};
+	void __iomem *regs;
 
 	if (!devm_request_region(dev, base[id], GPIOMM_EXTENT, name)) {
 		dev_err(dev, "Unable to lock port addresses (0x%X-0x%X)\n",
@@ -151,34 +71,19 @@ static int gpiomm_probe(struct device *dev, unsigned int id)
 		return -EBUSY;
 	}
 
-	gpiommgpio->ppi = devm_ioport_map(dev, base[id], GPIOMM_EXTENT);
-	if (!gpiommgpio->ppi)
+	regs = devm_ioport_map(dev, base[id], GPIOMM_EXTENT);
+	if (!regs)
 		return -ENOMEM;
 
-	gpiommgpio->chip.label = name;
-	gpiommgpio->chip.parent = dev;
-	gpiommgpio->chip.owner = THIS_MODULE;
-	gpiommgpio->chip.base = -1;
-	gpiommgpio->chip.ngpio = GPIOMM_NGPIO;
-	gpiommgpio->chip.names = gpiomm_names;
-	gpiommgpio->chip.get_direction = gpiomm_gpio_get_direction;
-	gpiommgpio->chip.direction_input = gpiomm_gpio_direction_input;
-	gpiommgpio->chip.direction_output = gpiomm_gpio_direction_output;
-	gpiommgpio->chip.get = gpiomm_gpio_get;
-	gpiommgpio->chip.get_multiple = gpiomm_gpio_get_multiple;
-	gpiommgpio->chip.set = gpiomm_gpio_set;
-	gpiommgpio->chip.set_multiple = gpiomm_gpio_set_multiple;
+	config.map = devm_regmap_init_mmio(dev, regs, &gpiomm_regmap_config);
+	if (IS_ERR(config.map))
+		return PTR_ERR(config.map);
 
-	i8255_state_init(gpiommgpio->ppi_state, GPIOMM_NUM_PPI);
-	gpiomm_init_dio(gpiommgpio->ppi, gpiommgpio->ppi_state);
+	config.parent = dev;
+	config.num_ppi = GPIOMM_NUM_PPI;
+	config.names = gpiomm_names;
 
-	err = devm_gpiochip_add_data(dev, &gpiommgpio->chip, gpiommgpio);
-	if (err) {
-		dev_err(dev, "GPIO registering failed (%d)\n", err);
-		return err;
-	}
-
-	return 0;
+	return devm_i8255_regmap_register(dev, &config);
 }
 
 static struct isa_driver gpiomm_driver = {
diff --git a/drivers/gpio/gpio-i8255.c b/drivers/gpio/gpio-i8255.c
dissimilarity index 89%
index 9b97db418df1..db6dab9aa1ef 100644
--- a/drivers/gpio/gpio-i8255.c
+++ b/drivers/gpio/gpio-i8255.c
@@ -1,287 +1,142 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Intel 8255 Programmable Peripheral Interface
- * Copyright (C) 2022 William Breathitt Gray
- */
-#include <linux/bitmap.h>
-#include <linux/err.h>
-#include <linux/export.h>
-#include <linux/io.h>
-#include <linux/module.h>
-#include <linux/spinlock.h>
-#include <linux/types.h>
-
-#include "gpio-i8255.h"
-
-#define I8255_CONTROL_PORTC_LOWER_DIRECTION BIT(0)
-#define I8255_CONTROL_PORTB_DIRECTION BIT(1)
-#define I8255_CONTROL_PORTC_UPPER_DIRECTION BIT(3)
-#define I8255_CONTROL_PORTA_DIRECTION BIT(4)
-#define I8255_CONTROL_MODE_SET BIT(7)
-#define I8255_PORTA 0
-#define I8255_PORTB 1
-#define I8255_PORTC 2
-
-static int i8255_get_port(struct i8255 __iomem *const ppi,
-			  const unsigned long io_port, const unsigned long mask)
-{
-	const unsigned long bank = io_port / 3;
-	const unsigned long ppi_port = io_port % 3;
-
-	return ioread8(&ppi[bank].port[ppi_port]) & mask;
-}
-
-static u8 i8255_direction_mask(const unsigned long offset)
-{
-	const unsigned long port_offset = offset % 8;
-	const unsigned long io_port = offset / 8;
-	const unsigned long ppi_port = io_port % 3;
-
-	switch (ppi_port) {
-	case I8255_PORTA:
-		return I8255_CONTROL_PORTA_DIRECTION;
-	case I8255_PORTB:
-		return I8255_CONTROL_PORTB_DIRECTION;
-	case I8255_PORTC:
-		/* Port C can be configured by nibble */
-		if (port_offset >= 4)
-			return I8255_CONTROL_PORTC_UPPER_DIRECTION;
-		return I8255_CONTROL_PORTC_LOWER_DIRECTION;
-	default:
-		/* Should never reach this path */
-		return 0;
-	}
-}
-
-static void i8255_set_port(struct i8255 __iomem *const ppi,
-			   struct i8255_state *const state,
-			   const unsigned long io_port,
-			   const unsigned long mask, const unsigned long bits)
-{
-	const unsigned long bank = io_port / 3;
-	const unsigned long ppi_port = io_port % 3;
-	unsigned long flags;
-	unsigned long out_state;
-
-	spin_lock_irqsave(&state[bank].lock, flags);
-
-	out_state = ioread8(&ppi[bank].port[ppi_port]);
-	out_state = (out_state & ~mask) | (bits & mask);
-	iowrite8(out_state, &ppi[bank].port[ppi_port]);
-
-	spin_unlock_irqrestore(&state[bank].lock, flags);
-}
-
-/**
- * i8255_direction_input - configure signal offset as input
- * @ppi:	Intel 8255 Programmable Peripheral Interface banks
- * @state:	devices states of the respective PPI banks
- * @offset:	signal offset to configure as input
- *
- * Configures a signal @offset as input for the respective Intel 8255
- * Programmable Peripheral Interface (@ppi) banks. The @state control_state
- * values are updated to reflect the new configuration.
- */
-void i8255_direction_input(struct i8255 __iomem *const ppi,
-			   struct i8255_state *const state,
-			   const unsigned long offset)
-{
-	const unsigned long io_port = offset / 8;
-	const unsigned long bank = io_port / 3;
-	unsigned long flags;
-
-	spin_lock_irqsave(&state[bank].lock, flags);
-
-	state[bank].control_state |= I8255_CONTROL_MODE_SET;
-	state[bank].control_state |= i8255_direction_mask(offset);
-
-	iowrite8(state[bank].control_state, &ppi[bank].control);
-
-	spin_unlock_irqrestore(&state[bank].lock, flags);
-}
-EXPORT_SYMBOL_NS_GPL(i8255_direction_input, I8255);
-
-/**
- * i8255_direction_output - configure signal offset as output
- * @ppi:	Intel 8255 Programmable Peripheral Interface banks
- * @state:	devices states of the respective PPI banks
- * @offset:	signal offset to configure as output
- * @value:	signal value to output
- *
- * Configures a signal @offset as output for the respective Intel 8255
- * Programmable Peripheral Interface (@ppi) banks and sets the respective signal
- * output to the desired @value. The @state control_state values are updated to
- * reflect the new configuration.
- */
-void i8255_direction_output(struct i8255 __iomem *const ppi,
-			    struct i8255_state *const state,
-			    const unsigned long offset,
-			    const unsigned long value)
-{
-	const unsigned long io_port = offset / 8;
-	const unsigned long bank = io_port / 3;
-	unsigned long flags;
-
-	spin_lock_irqsave(&state[bank].lock, flags);
-
-	state[bank].control_state |= I8255_CONTROL_MODE_SET;
-	state[bank].control_state &= ~i8255_direction_mask(offset);
-
-	iowrite8(state[bank].control_state, &ppi[bank].control);
-
-	spin_unlock_irqrestore(&state[bank].lock, flags);
-
-	i8255_set(ppi, state, offset, value);
-}
-EXPORT_SYMBOL_NS_GPL(i8255_direction_output, I8255);
-
-/**
- * i8255_get - get signal value at signal offset
- * @ppi:	Intel 8255 Programmable Peripheral Interface banks
- * @offset:	offset of signal to get
- *
- * Returns the signal value (0=low, 1=high) for the signal at @offset for the
- * respective Intel 8255 Programmable Peripheral Interface (@ppi) banks.
- */
-int i8255_get(struct i8255 __iomem *const ppi, const unsigned long offset)
-{
-	const unsigned long io_port = offset / 8;
-	const unsigned long offset_mask = BIT(offset % 8);
-
-	return !!i8255_get_port(ppi, io_port, offset_mask);
-}
-EXPORT_SYMBOL_NS_GPL(i8255_get, I8255);
-
-/**
- * i8255_get_direction - get the I/O direction for a signal offset
- * @state:	devices states of the respective PPI banks
- * @offset:	offset of signal to get direction
- *
- * Returns the signal direction (0=output, 1=input) for the signal at @offset.
- */
-int i8255_get_direction(const struct i8255_state *const state,
-			const unsigned long offset)
-{
-	const unsigned long io_port = offset / 8;
-	const unsigned long bank = io_port / 3;
-
-	return !!(state[bank].control_state & i8255_direction_mask(offset));
-}
-EXPORT_SYMBOL_NS_GPL(i8255_get_direction, I8255);
-
-/**
- * i8255_get_multiple - get multiple signal values at multiple signal offsets
- * @ppi:	Intel 8255 Programmable Peripheral Interface banks
- * @mask:	mask of signals to get
- * @bits:	bitmap to store signal values
- * @ngpio:	number of GPIO signals of the respective PPI banks
- *
- * Stores in @bits the values (0=low, 1=high) for the signals defined by @mask
- * for the respective Intel 8255 Programmable Peripheral Interface (@ppi) banks.
- */
-void i8255_get_multiple(struct i8255 __iomem *const ppi,
-			const unsigned long *const mask,
-			unsigned long *const bits, const unsigned long ngpio)
-{
-	unsigned long offset;
-	unsigned long port_mask;
-	unsigned long io_port;
-	unsigned long port_state;
-
-	bitmap_zero(bits, ngpio);
-
-	for_each_set_clump8(offset, port_mask, mask, ngpio) {
-		io_port = offset / 8;
-		port_state = i8255_get_port(ppi, io_port, port_mask);
-
-		bitmap_set_value8(bits, port_state, offset);
-	}
-}
-EXPORT_SYMBOL_NS_GPL(i8255_get_multiple, I8255);
-
-/**
- * i8255_mode0_output - configure all PPI ports to MODE 0 output mode
- * @ppi:	Intel 8255 Programmable Peripheral Interface bank
- *
- * Configures all Intel 8255 Programmable Peripheral Interface (@ppi) ports to
- * MODE 0 (Basic Input/Output) output mode.
- */
-void i8255_mode0_output(struct i8255 __iomem *const ppi)
-{
-	iowrite8(I8255_CONTROL_MODE_SET, &ppi->control);
-}
-EXPORT_SYMBOL_NS_GPL(i8255_mode0_output, I8255);
-
-/**
- * i8255_set - set signal value at signal offset
- * @ppi:	Intel 8255 Programmable Peripheral Interface banks
- * @state:	devices states of the respective PPI banks
- * @offset:	offset of signal to set
- * @value:	value of signal to set
- *
- * Assigns output @value for the signal at @offset for the respective Intel 8255
- * Programmable Peripheral Interface (@ppi) banks.
- */
-void i8255_set(struct i8255 __iomem *const ppi, struct i8255_state *const state,
-	       const unsigned long offset, const unsigned long value)
-{
-	const unsigned long io_port = offset / 8;
-	const unsigned long port_offset = offset % 8;
-	const unsigned long mask = BIT(port_offset);
-	const unsigned long bits = value << port_offset;
-
-	i8255_set_port(ppi, state, io_port, mask, bits);
-}
-EXPORT_SYMBOL_NS_GPL(i8255_set, I8255);
-
-/**
- * i8255_set_multiple - set signal values at multiple signal offsets
- * @ppi:	Intel 8255 Programmable Peripheral Interface banks
- * @state:	devices states of the respective PPI banks
- * @mask:	mask of signals to set
- * @bits:	bitmap of signal output values
- * @ngpio:	number of GPIO signals of the respective PPI banks
- *
- * Assigns output values defined by @bits for the signals defined by @mask for
- * the respective Intel 8255 Programmable Peripheral Interface (@ppi) banks.
- */
-void i8255_set_multiple(struct i8255 __iomem *const ppi,
-			struct i8255_state *const state,
-			const unsigned long *const mask,
-			const unsigned long *const bits,
-			const unsigned long ngpio)
-{
-	unsigned long offset;
-	unsigned long port_mask;
-	unsigned long io_port;
-	unsigned long value;
-
-	for_each_set_clump8(offset, port_mask, mask, ngpio) {
-		io_port = offset / 8;
-		value = bitmap_get_value8(bits, offset);
-		i8255_set_port(ppi, state, io_port, port_mask, value);
-	}
-}
-EXPORT_SYMBOL_NS_GPL(i8255_set_multiple, I8255);
-
-/**
- * i8255_state_init - initialize i8255_state structure
- * @state:	devices states of the respective PPI banks
- * @nbanks:	number of Intel 8255 Programmable Peripheral Interface banks
- *
- * Initializes the @state of each Intel 8255 Programmable Peripheral Interface
- * bank for use in i8255 library functions.
- */
-void i8255_state_init(struct i8255_state *const state,
-		      const unsigned long nbanks)
-{
-	unsigned long bank;
-
-	for (bank = 0; bank < nbanks; bank++)
-		spin_lock_init(&state[bank].lock);
-}
-EXPORT_SYMBOL_NS_GPL(i8255_state_init, I8255);
-
-MODULE_AUTHOR("William Breathitt Gray");
-MODULE_DESCRIPTION("Intel 8255 Programmable Peripheral Interface");
-MODULE_LICENSE("GPL");
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Intel 8255 Programmable Peripheral Interface
+ * Copyright (C) 2022 William Breathitt Gray
+ */
+#include <linux/bits.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/gpio/regmap.h>
+#include <linux/irqdomain.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#include "gpio-i8255.h"
+
+#define I8255_NGPIO 24
+#define I8255_NGPIO_PER_REG 8
+#define I8255_CONTROL_PORTC_LOWER_DIRECTION BIT(0)
+#define I8255_CONTROL_PORTB_DIRECTION BIT(1)
+#define I8255_CONTROL_PORTC_UPPER_DIRECTION BIT(3)
+#define I8255_CONTROL_PORTA_DIRECTION BIT(4)
+#define I8255_CONTROL_MODE_SET BIT(7)
+#define I8255_PORTA 0x0
+#define I8255_PORTB 0x1
+#define I8255_PORTC 0x2
+#define I8255_CONTROL 0x3
+#define I8255_REG_DAT_BASE I8255_PORTA
+#define I8255_REG_DIR_IN_BASE I8255_CONTROL
+
+static int i8255_ppi_init(struct regmap *const map, const unsigned int base)
+{
+	int err;
+
+	/* Configure all ports to MODE 0 output mode */
+	err = regmap_write(map, base + I8255_CONTROL, I8255_CONTROL_MODE_SET);
+	if (err)
+		return err;
+
+	/* Initialize all GPIO to output 0 */
+	err = regmap_write(map, base + I8255_PORTA, 0x00);
+	if (err)
+		return err;
+	err = regmap_write(map, base + I8255_PORTB, 0x00);
+	if (err)
+		return err;
+	return regmap_write(map, base + I8255_PORTC, 0x00);
+}
+
+static int i8255_direction_mask(const unsigned int offset)
+{
+	const unsigned int stride = offset / I8255_NGPIO_PER_REG;
+	const unsigned int line = offset % I8255_NGPIO_PER_REG;
+
+	switch (stride) {
+	case I8255_PORTA:
+		return I8255_CONTROL_PORTA_DIRECTION;
+	case I8255_PORTB:
+		return I8255_CONTROL_PORTB_DIRECTION;
+	case I8255_PORTC:
+		/* Port C can be configured by nibble */
+		if (line >= 4)
+			return I8255_CONTROL_PORTC_UPPER_DIRECTION;
+		return I8255_CONTROL_PORTC_LOWER_DIRECTION;
+	default:
+		/* Should never reach this path */
+		return 0;
+	}
+}
+
+static int i8255_reg_mask_xlate(struct gpio_regmap *gpio, unsigned int base,
+				unsigned int offset, unsigned int *reg,
+				unsigned int *mask)
+{
+	const unsigned int ppi = offset / I8255_NGPIO;
+	const unsigned int ppi_offset = offset % I8255_NGPIO;
+	const unsigned int stride = ppi_offset / I8255_NGPIO_PER_REG;
+	const unsigned int line = ppi_offset % I8255_NGPIO_PER_REG;
+
+	switch (base) {
+	case I8255_REG_DAT_BASE:
+		*reg = base + stride + ppi * 4;
+		*mask = BIT(line);
+		return 0;
+	case I8255_REG_DIR_IN_BASE:
+		*reg = base + ppi * 4;
+		*mask = i8255_direction_mask(ppi_offset);
+		return 0;
+	default:
+		/* Should never reach this path */
+		return -EINVAL;
+	}
+}
+
+/**
+ * devm_i8255_regmap_register - Register an i8255 GPIO controller
+ * @dev:	device that is registering this i8255 GPIO device
+ * @config:	configuration for i8255_regmap_config
+ *
+ * Registers an Intel 8255 Programmable Peripheral Interface GPIO controller.
+ * Returns 0 on success and negative error number on failure.
+ */
+int devm_i8255_regmap_register(struct device *const dev,
+			       const struct i8255_regmap_config *const config)
+{
+	struct gpio_regmap_config gpio_config = {0};
+	unsigned long i;
+	int err;
+
+	if (!config->parent)
+		return -EINVAL;
+
+	if (!config->map)
+		return -EINVAL;
+
+	if (!config->num_ppi)
+		return -EINVAL;
+
+	for (i = 0; i < config->num_ppi; i++) {
+		err = i8255_ppi_init(config->map, i * 4);
+		if (err)
+			return err;
+	}
+
+	gpio_config.parent = config->parent;
+	gpio_config.regmap = config->map;
+	gpio_config.ngpio = I8255_NGPIO * config->num_ppi;
+	gpio_config.names = config->names;
+	gpio_config.reg_dat_base = GPIO_REGMAP_ADDR(I8255_REG_DAT_BASE);
+	gpio_config.reg_set_base = GPIO_REGMAP_ADDR(I8255_REG_DAT_BASE);
+	gpio_config.reg_dir_in_base = GPIO_REGMAP_ADDR(I8255_REG_DIR_IN_BASE);
+	gpio_config.ngpio_per_reg = I8255_NGPIO_PER_REG;
+	gpio_config.irq_domain = config->domain;
+	gpio_config.reg_mask_xlate = i8255_reg_mask_xlate;
+
+	return PTR_ERR_OR_ZERO(devm_gpio_regmap_register(dev, &gpio_config));
+}
+EXPORT_SYMBOL_NS_GPL(devm_i8255_regmap_register, I8255);
+
+MODULE_AUTHOR("William Breathitt Gray");
+MODULE_DESCRIPTION("Intel 8255 Programmable Peripheral Interface");
+MODULE_LICENSE("GPL");
diff --git a/drivers/gpio/gpio-i8255.h b/drivers/gpio/gpio-i8255.h
dissimilarity index 89%
index d9084aae9446..ec12ef923dfc 100644
--- a/drivers/gpio/gpio-i8255.h
+++ b/drivers/gpio/gpio-i8255.h
@@ -1,46 +1,34 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright 2022 William Breathitt Gray */
-#ifndef _I8255_H_
-#define _I8255_H_
-
-#include <linux/spinlock.h>
-#include <linux/types.h>
-
-/**
- * struct i8255 - Intel 8255 register structure
- * @port:	Port A, B, and C
- * @control:	Control register
- */
-struct i8255 {
-	u8 port[3];
-	u8 control;
-};
-
-/**
- * struct i8255_state - Intel 8255 state structure
- * @lock:		synchronization lock for accessing device state
- * @control_state:	Control register state
- */
-struct i8255_state {
-	spinlock_t lock;
-	u8 control_state;
-};
-
-void i8255_direction_input(struct i8255 __iomem *ppi, struct i8255_state *state,
-			   unsigned long offset);
-void i8255_direction_output(struct i8255 __iomem *ppi,
-			    struct i8255_state *state, unsigned long offset,
-			    unsigned long value);
-int i8255_get(struct i8255 __iomem *ppi, unsigned long offset);
-int i8255_get_direction(const struct i8255_state *state, unsigned long offset);
-void i8255_get_multiple(struct i8255 __iomem *ppi, const unsigned long *mask,
-			unsigned long *bits, unsigned long ngpio);
-void i8255_mode0_output(struct i8255 __iomem *const ppi);
-void i8255_set(struct i8255 __iomem *ppi, struct i8255_state *state,
-	       unsigned long offset, unsigned long value);
-void i8255_set_multiple(struct i8255 __iomem *ppi, struct i8255_state *state,
-			const unsigned long *mask, const unsigned long *bits,
-			unsigned long ngpio);
-void i8255_state_init(struct i8255_state *const state, unsigned long nbanks);
-
-#endif /* _I8255_H_ */
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright 2022 William Breathitt Gray */
+#ifndef _I8255_H_
+#define _I8255_H_
+
+#include <linux/device.h>
+#include <linux/irqdomain.h>
+#include <linux/regmap.h>
+
+/**
+ * struct i8255_regmap_config - Configuration for the register map of an i8255
+ * @parent:	parent device
+ * @map:	regmap for the i8255
+ * @num_ppi:	number of i8255 Programmable Peripheral Interface
+ * @names:	(optional) array of names for gpios
+ * @domain:	(optional) IRQ domain if the controller is interrupt-capable
+ *
+ * Note: The regmap is expected to have cache enabled and i8255 control
+ * registers not marked as volatile.
+ */
+struct i8255_regmap_config {
+	struct device *parent;
+	struct regmap *map;
+	int num_ppi;
+	const char *const *names;
+	struct irq_domain *domain;
+};
+
+int devm_i8255_regmap_register(struct device *dev,
+			       const struct i8255_regmap_config *config);
+
+#define i8255_volatile_regmap_range(_base) regmap_reg_range(_base, _base + 0x2)
+
+#endif /* _I8255_H_ */
-- 
2.38.1


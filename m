Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD4769B15B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 17:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjBQQuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 11:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjBQQtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 11:49:46 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAB14AFEF
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 08:49:43 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id d14so2785164qvo.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 08:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EO2TDvCxW5bdpkgQexId4Kr4mUY6IRwX6v1/DJgH6x8=;
        b=lJywd+xvLxHHeEBEroWMXbbFFpaMu8EefedsHoksKs4YOK3SGQ7k7WM23z0HdhISch
         Cl8b2O4DaPBmjwytD8jb6DtgvzUitJ6qjpcuWGpmc3sN7/kBeC+f06NZTfiqyOxEjZuA
         ce18UiRXv4Do8S+D72LMph7jg/xZ8ArVji3ToeNrIcwLWwBNgFvP3S3P9RsBDZqTBpc1
         edLIPV6nmyma1boaQj/6Cj4PLuv80CiffNT9O6A9JRX34obqMsbKrjV3+MKB6ueCZR/E
         rFY39QCQJH2RV77U8ht5IUqxg5I9qfdlXFcQOcppVuRCMSJDjnmmroYBGs6/IAdHOD+d
         VLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EO2TDvCxW5bdpkgQexId4Kr4mUY6IRwX6v1/DJgH6x8=;
        b=5nuvcfRgCy7xg2Y95ZC1G4NKdt4kJGIMf2uvpyZiXVdVesDFXKdJnLKnP3HSJhYWKr
         W5ejaGXdBRgwzcJ5ba4WX3pt1UGNGvSGAH+WacjJad/zfKAnd6fQzG8nwm3tPIj5hLra
         ISC2rexwJ5ewyAOX8rjRKc3olNc5LzLWd7DVnmYnOalXVaSJ8wWWb1OiUolsT49ygxQj
         6SByawqrE4FwLknNODfTWeP00LJ1vtW7ioXv8i8+dDjM+hYKxqeLPD7hbitU6EynPjEE
         ew8/W7IAt+Za/T3x9fPz0kpsBbRf/HvvzAQZ+grOqeGAl31KWzu5TjhjP9S+xN+XEIke
         yb+w==
X-Gm-Message-State: AO0yUKXL5XwCIS94oRj/O88bXfis3/9/FxUMo+7NH7wcJq9rsPyr2eNc
        VNo5SwJnqa5dR8Z4NMgg5O4EOw==
X-Google-Smtp-Source: AK7set/wrVm0UMOvUPB8sPhr3lJO9aiu9yICayzhPU+lx/a6zcViL3/oLZsxjgjVOCEjwWLkjTclag==
X-Received: by 2002:ad4:5ba3:0:b0:56e:f4e0:a4ec with SMTP id 3-20020ad45ba3000000b0056ef4e0a4ecmr12096996qvq.46.1676652582364;
        Fri, 17 Feb 2023 08:49:42 -0800 (PST)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id b68-20020a37b247000000b0073980414888sm3569161qkf.42.2023.02.17.08.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 08:49:42 -0800 (PST)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     broonie@kernel.org, andriy.shevchenko@linux.intel.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH 4/6] gpio: 104-idio-16: Migrate to the regmap API
Date:   Wed,  8 Feb 2023 12:18:19 -0500
Message-Id: <013141e0daf5f82dbd85310b498727b105a8523a.1675876659.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1675876659.git.william.gray@linaro.org>
References: <cover.1675876659.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regmap API supports IO port accessors so we can take advantage of
regmap abstractions rather than handling access to the device registers
directly in the driver. Migrate the 104-idio-16 module to the new
idio-16 library interface leveraging the gpio-regmap API.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/gpio/Kconfig            |   2 +-
 drivers/gpio/gpio-104-idio-16.c | 294 ++++++++------------------------
 2 files changed, 72 insertions(+), 224 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index b4de83a3616d..8eb1f21c019e 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -863,7 +863,7 @@ config GPIO_104_IDIO_16
 	tristate "ACCES 104-IDIO-16 GPIO support"
 	depends on PC104
 	select ISA_BUS_API
-	select GPIOLIB_IRQCHIP
+	select REGMAP_MMIO
 	select GPIO_IDIO_16
 	help
 	  Enables GPIO support for the ACCES 104-IDIO-16 family (104-IDIO-16,
diff --git a/drivers/gpio/gpio-104-idio-16.c b/drivers/gpio/gpio-104-idio-16.c
index 098fbefdbe22..79d3a089061e 100644
--- a/drivers/gpio/gpio-104-idio-16.c
+++ b/drivers/gpio/gpio-104-idio-16.c
@@ -6,19 +6,16 @@
  * This driver supports the following ACCES devices: 104-IDIO-16,
  * 104-IDIO-16E, 104-IDO-16, 104-IDIO-8, 104-IDIO-8E, and 104-IDO-8.
  */
-#include <linux/bitmap.h>
+#include <linux/bits.h>
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
 
 #include "gpio-idio-16.h"
@@ -36,187 +33,69 @@ static unsigned int num_irq;
 module_param_hw_array(irq, uint, irq, &num_irq, 0);
 MODULE_PARM_DESC(irq, "ACCES 104-IDIO-16 interrupt line numbers");
 
-/**
- * struct idio_16_gpio - GPIO device private data structure
- * @chip:	instance of the gpio_chip
- * @lock:	synchronization lock to prevent I/O race conditions
- * @irq_mask:	I/O bits affected by interrupts
- * @reg:	I/O address offset for the device registers
- * @state:	ACCES IDIO-16 device state
- */
-struct idio_16_gpio {
-	struct gpio_chip chip;
-	raw_spinlock_t lock;
-	unsigned long irq_mask;
-	struct idio_16 __iomem *reg;
-	struct idio_16_state state;
+static const struct regmap_range idio_16_wr_ranges[] = {
+	regmap_reg_range(0x0, 0x2), regmap_reg_range(0x4, 0x4),
 };
-
-static int idio_16_gpio_get_direction(struct gpio_chip *chip,
-				      unsigned int offset)
-{
-	if (idio_16_get_direction(offset))
-		return GPIO_LINE_DIRECTION_IN;
-
-	return GPIO_LINE_DIRECTION_OUT;
-}
-
-static int idio_16_gpio_direction_input(struct gpio_chip *chip,
-					unsigned int offset)
-{
-	return 0;
-}
-
-static int idio_16_gpio_direction_output(struct gpio_chip *chip,
-	unsigned int offset, int value)
-{
-	chip->set(chip, offset, value);
-	return 0;
-}
-
-static int idio_16_gpio_get(struct gpio_chip *chip, unsigned int offset)
-{
-	struct idio_16_gpio *const idio16gpio = gpiochip_get_data(chip);
-
-	return idio_16_get(idio16gpio->reg, &idio16gpio->state, offset);
-}
-
-static int idio_16_gpio_get_multiple(struct gpio_chip *chip,
-	unsigned long *mask, unsigned long *bits)
-{
-	struct idio_16_gpio *const idio16gpio = gpiochip_get_data(chip);
-
-	idio_16_get_multiple(idio16gpio->reg, &idio16gpio->state, mask, bits);
-
-	return 0;
-}
-
-static void idio_16_gpio_set(struct gpio_chip *chip, unsigned int offset,
-			     int value)
-{
-	struct idio_16_gpio *const idio16gpio = gpiochip_get_data(chip);
-
-	idio_16_set(idio16gpio->reg, &idio16gpio->state, offset, value);
-}
-
-static void idio_16_gpio_set_multiple(struct gpio_chip *chip,
-	unsigned long *mask, unsigned long *bits)
-{
-	struct idio_16_gpio *const idio16gpio = gpiochip_get_data(chip);
-
-	idio_16_set_multiple(idio16gpio->reg, &idio16gpio->state, mask, bits);
-}
-
-static void idio_16_irq_ack(struct irq_data *data)
-{
-}
-
-static void idio_16_irq_mask(struct irq_data *data)
-{
-	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
-	struct idio_16_gpio *const idio16gpio = gpiochip_get_data(chip);
-	const unsigned long offset = irqd_to_hwirq(data);
-	unsigned long flags;
-
-	idio16gpio->irq_mask &= ~BIT(offset);
-	gpiochip_disable_irq(chip, offset);
-
-	if (!idio16gpio->irq_mask) {
-		raw_spin_lock_irqsave(&idio16gpio->lock, flags);
-
-		iowrite8(0, &idio16gpio->reg->irq_ctl);
-
-		raw_spin_unlock_irqrestore(&idio16gpio->lock, flags);
-	}
-}
-
-static void idio_16_irq_unmask(struct irq_data *data)
-{
-	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
-	struct idio_16_gpio *const idio16gpio = gpiochip_get_data(chip);
-	const unsigned long offset = irqd_to_hwirq(data);
-	const unsigned long prev_irq_mask = idio16gpio->irq_mask;
-	unsigned long flags;
-
-	gpiochip_enable_irq(chip, offset);
-	idio16gpio->irq_mask |= BIT(offset);
-
-	if (!prev_irq_mask) {
-		raw_spin_lock_irqsave(&idio16gpio->lock, flags);
-
-		ioread8(&idio16gpio->reg->irq_ctl);
-
-		raw_spin_unlock_irqrestore(&idio16gpio->lock, flags);
-	}
-}
-
-static int idio_16_irq_set_type(struct irq_data *data, unsigned int flow_type)
-{
-	/* The only valid irq types are none and both-edges */
-	if (flow_type != IRQ_TYPE_NONE &&
-		(flow_type & IRQ_TYPE_EDGE_BOTH) != IRQ_TYPE_EDGE_BOTH)
-		return -EINVAL;
-
-	return 0;
-}
-
-static const struct irq_chip idio_16_irqchip = {
-	.name = "104-idio-16",
-	.irq_ack = idio_16_irq_ack,
-	.irq_mask = idio_16_irq_mask,
-	.irq_unmask = idio_16_irq_unmask,
-	.irq_set_type = idio_16_irq_set_type,
-	.flags = IRQCHIP_IMMUTABLE,
-	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+static const struct regmap_range idio_16_rd_ranges[] = {
+	regmap_reg_range(0x1, 0x2), regmap_reg_range(0x5, 0x5),
 };
-
-static irqreturn_t idio_16_irq_handler(int irq, void *dev_id)
-{
-	struct idio_16_gpio *const idio16gpio = dev_id;
-	struct gpio_chip *const chip = &idio16gpio->chip;
-	int gpio;
-
-	for_each_set_bit(gpio, &idio16gpio->irq_mask, chip->ngpio)
-		generic_handle_domain_irq(chip->irq.domain, gpio);
-
-	raw_spin_lock(&idio16gpio->lock);
-
-	iowrite8(0, &idio16gpio->reg->in0_7);
-
-	raw_spin_unlock(&idio16gpio->lock);
-
-	return IRQ_HANDLED;
-}
-
-#define IDIO_16_NGPIO 32
-static const char *idio_16_names[IDIO_16_NGPIO] = {
-	"OUT0", "OUT1", "OUT2", "OUT3", "OUT4", "OUT5", "OUT6", "OUT7",
-	"OUT8", "OUT9", "OUT10", "OUT11", "OUT12", "OUT13", "OUT14", "OUT15",
-	"IIN0", "IIN1", "IIN2", "IIN3", "IIN4", "IIN5", "IIN6", "IIN7",
-	"IIN8", "IIN9", "IIN10", "IIN11", "IIN12", "IIN13", "IIN14", "IIN15"
+static const struct regmap_range idio_16_volatile_ranges[] = {
+	regmap_reg_range(0x1, 0x2), regmap_reg_range(0x5, 0x5),
+};
+static const struct regmap_range idio_16_precious_ranges[] = {
+	regmap_reg_range(0x2, 0x2),
+};
+static const struct regmap_access_table idio_16_wr_table = {
+	.yes_ranges = idio_16_wr_ranges,
+	.n_yes_ranges = ARRAY_SIZE(idio_16_wr_ranges),
+};
+static const struct regmap_access_table idio_16_rd_table = {
+	.yes_ranges = idio_16_rd_ranges,
+	.n_yes_ranges = ARRAY_SIZE(idio_16_rd_ranges),
+};
+static const struct regmap_access_table idio_16_volatile_table = {
+	.yes_ranges = idio_16_volatile_ranges,
+	.n_yes_ranges = ARRAY_SIZE(idio_16_volatile_ranges),
+};
+static const struct regmap_access_table idio_16_precious_table = {
+	.yes_ranges = idio_16_precious_ranges,
+	.n_yes_ranges = ARRAY_SIZE(idio_16_precious_ranges),
+};
+static const struct regmap_config idio_16_regmap_config = {
+	.reg_bits = 8,
+	.reg_stride = 1,
+	.val_bits = 8,
+	.io_port = true,
+	.max_register = 0x5,
+	.wr_table = &idio_16_wr_table,
+	.rd_table = &idio_16_rd_table,
+	.volatile_table = &idio_16_volatile_table,
+	.precious_table = &idio_16_precious_table,
+	.cache_type = REGCACHE_FLAT,
 };
 
-static int idio_16_irq_init_hw(struct gpio_chip *gc)
-{
-	struct idio_16_gpio *const idio16gpio = gpiochip_get_data(gc);
-
-	/* Disable IRQ by default */
-	iowrite8(0, &idio16gpio->reg->irq_ctl);
-	iowrite8(0, &idio16gpio->reg->in0_7);
+/* Only input lines (GPIO 16-31) support interrupts */
+#define IDIO_16_REGMAP_IRQ(_id)						\
+	[16 + _id] = {							\
+		.mask = BIT(_id),					\
+		.type = { .types_supported = IRQ_TYPE_EDGE_BOTH },	\
+	}
 
-	return 0;
-}
+static const struct regmap_irq idio_16_regmap_irqs[] = {
+	IDIO_16_REGMAP_IRQ(0), IDIO_16_REGMAP_IRQ(1), IDIO_16_REGMAP_IRQ(2), /* 0-2 */
+	IDIO_16_REGMAP_IRQ(3), IDIO_16_REGMAP_IRQ(4), IDIO_16_REGMAP_IRQ(5), /* 3-5 */
+	IDIO_16_REGMAP_IRQ(6), IDIO_16_REGMAP_IRQ(7), IDIO_16_REGMAP_IRQ(8), /* 6-8 */
+	IDIO_16_REGMAP_IRQ(9), IDIO_16_REGMAP_IRQ(10), IDIO_16_REGMAP_IRQ(11), /* 9-11 */
+	IDIO_16_REGMAP_IRQ(12), IDIO_16_REGMAP_IRQ(13), IDIO_16_REGMAP_IRQ(14), /* 12-14 */
+	IDIO_16_REGMAP_IRQ(15), /* 15 */
+};
 
 static int idio_16_probe(struct device *dev, unsigned int id)
 {
-	struct idio_16_gpio *idio16gpio;
 	const char *const name = dev_name(dev);
-	struct gpio_irq_chip *girq;
-	int err;
-
-	idio16gpio = devm_kzalloc(dev, sizeof(*idio16gpio), GFP_KERNEL);
-	if (!idio16gpio)
-		return -ENOMEM;
+	struct idio_16_regmap_config config = {};
+	void __iomem *regs;
+	struct regmap *map;
 
 	if (!devm_request_region(dev, base[id], IDIO_16_EXTENT, name)) {
 		dev_err(dev, "Unable to lock port addresses (0x%X-0x%X)\n",
@@ -224,54 +103,23 @@ static int idio_16_probe(struct device *dev, unsigned int id)
 		return -EBUSY;
 	}
 
-	idio16gpio->reg = devm_ioport_map(dev, base[id], IDIO_16_EXTENT);
-	if (!idio16gpio->reg)
+	regs = devm_ioport_map(dev, base[id], IDIO_16_EXTENT);
+	if (!regs)
 		return -ENOMEM;
 
-	idio16gpio->chip.label = name;
-	idio16gpio->chip.parent = dev;
-	idio16gpio->chip.owner = THIS_MODULE;
-	idio16gpio->chip.base = -1;
-	idio16gpio->chip.ngpio = IDIO_16_NGPIO;
-	idio16gpio->chip.names = idio_16_names;
-	idio16gpio->chip.get_direction = idio_16_gpio_get_direction;
-	idio16gpio->chip.direction_input = idio_16_gpio_direction_input;
-	idio16gpio->chip.direction_output = idio_16_gpio_direction_output;
-	idio16gpio->chip.get = idio_16_gpio_get;
-	idio16gpio->chip.get_multiple = idio_16_gpio_get_multiple;
-	idio16gpio->chip.set = idio_16_gpio_set;
-	idio16gpio->chip.set_multiple = idio_16_gpio_set_multiple;
-
-	idio_16_state_init(&idio16gpio->state);
-	/* FET off states are represented by bit values of "1" */
-	bitmap_fill(idio16gpio->state.out_state, IDIO_16_NOUT);
+	map = devm_regmap_init_mmio(dev, regs, &idio_16_regmap_config);
+	if (IS_ERR(map))
+		return dev_err_probe(dev, PTR_ERR(map),
+				     "Unable to initialize register map\n");
 
-	girq = &idio16gpio->chip.irq;
-	gpio_irq_chip_set_chip(girq, &idio_16_irqchip);
-	/* This will let us handle the parent IRQ in the driver */
-	girq->parent_handler = NULL;
-	girq->num_parents = 0;
-	girq->parents = NULL;
-	girq->default_type = IRQ_TYPE_NONE;
-	girq->handler = handle_edge_irq;
-	girq->init_hw = idio_16_irq_init_hw;
-
-	raw_spin_lock_init(&idio16gpio->lock);
-
-	err = devm_gpiochip_add_data(dev, &idio16gpio->chip, idio16gpio);
-	if (err) {
-		dev_err(dev, "GPIO registering failed (%d)\n", err);
-		return err;
-	}
-
-	err = devm_request_irq(dev, irq[id], idio_16_irq_handler, 0, name,
-		idio16gpio);
-	if (err) {
-		dev_err(dev, "IRQ handler registering failed (%d)\n", err);
-		return err;
-	}
+	config.parent = dev;
+	config.map = map;
+	config.regmap_irqs = idio_16_regmap_irqs;
+	config.num_regmap_irqs = ARRAY_SIZE(idio_16_regmap_irqs);
+	config.irq = irq[id];
+	config.no_status = true;
 
-	return 0;
+	return devm_idio_16_regmap_register(dev, &config);
 }
 
 static struct isa_driver idio_16_driver = {
-- 
2.39.1


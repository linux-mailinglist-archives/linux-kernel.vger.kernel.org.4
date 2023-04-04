Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85386D656D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 16:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235745AbjDDOdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 10:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235488AbjDDOc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:32:59 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4C4F1
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 07:32:57 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-536af432ee5so617973327b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 07:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680618777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iANCBm41OS/1Z6/HHVJJYPk/G08OqB7xsKoOs+tcOoE=;
        b=uz16t2VIz5a+h1q/WYsxloTkqq11ZVy4tjyoCnR96LOVrs+B5N+ZQ5Q9Gw/vYAushS
         rUCy/1D6Jtn9n2hI8jgwRnVn2RUmYvTsYXWeh+xmA9mFdMXjog3DQ11QCEL/zWH/2ziZ
         m+io4VWpZb5FdSs/pUiTvfft6VwNrsfzYrebs1d8HQEGohv2a83oXcVc1nvOEOL+BhU3
         Yv2ksRGxt6vxUt3Xza346ju31Mw3+E9YvQmHiQYLZAxIyZfUYYnyWmc7cQd5q+EF2x0/
         mLMlsZOxD+kFYpS0ufAUtcoEe9jCRiJGDNakG/+2yVTP2tjgmkjnl9uB0UsFhd4vYWIT
         aZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680618777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iANCBm41OS/1Z6/HHVJJYPk/G08OqB7xsKoOs+tcOoE=;
        b=0gAkw4rgzIZMvdVeRuqrd6kjIp+YGD7vLWzbYH7tQfTsJBprmyv7gWMXiDWbbKngr7
         5QPwgQ8+g65vthGYReuuOW6Eu6xJUkZ39sHscACkJRuUG/3hUSHIJExz12ecAzX14jcd
         lCN1dqgTOqDwGOLu1meR3U6qfRr9HDfKMFQNCMPyvt3cJjvKRf5ie+NoosAoEylI7P+i
         hLoqJ0nyue91IgWdwjfCoPcjWAdCoV9dnek9gHVRyy6KWQkd98/JSbqkXnufmfmlIfeJ
         x34hyiY15YbaFnIGXSoqvqSsacvQwfNINWRce5y5rVhTdPgJXA1+yW/0SffsdByIrdc1
         /BYw==
X-Gm-Message-State: AAQBX9eq/6gBtBwBRsSAqJ249meB1YqGZLW7yUaKj3VMAn4VORJv4BsY
        YceOF2M3mTNUWLMh9sA75ZfIsw==
X-Google-Smtp-Source: AKy350aASIovVAVFE9D9Ad0uWCZg+EIvhxby5WSzQlTVg0FJWgL+yZkRqYcJR9q1/ekbtNuzdp2I7Q==
X-Received: by 2002:a81:6c0a:0:b0:543:1d8c:7fc with SMTP id h10-20020a816c0a000000b005431d8c07fcmr2386622ywc.26.1680618776823;
        Tue, 04 Apr 2023 07:32:56 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id p76-20020a81984f000000b00545a0818489sm3234439ywg.25.2023.04.04.07.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 07:32:56 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v5 2/4] gpio: 104-idio-16: Migrate to the regmap API
Date:   Tue,  4 Apr 2023 10:32:46 -0400
Message-Id: <1f24a1f18c9a9daa4983713e0a5b53e838d624a8.1680618405.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1680618405.git.william.gray@linaro.org>
References: <cover.1680618405.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
Changes in v5:
 - Remove regmap_config max_register line as superfluous
 - Enable use_raw_spinlock to prevent deadlocks when running -rt kernels

 drivers/gpio/Kconfig            |   2 +-
 drivers/gpio/gpio-104-idio-16.c | 286 +++++++-------------------------
 2 files changed, 64 insertions(+), 224 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 415b86cfd1a9..9f7ec4f3fdbf 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -860,7 +860,7 @@ config GPIO_104_IDIO_16
 	tristate "ACCES 104-IDIO-16 GPIO support"
 	depends on PC104
 	select ISA_BUS_API
-	select GPIOLIB_IRQCHIP
+	select REGMAP_MMIO
 	select GPIO_IDIO_16
 	help
 	  Enables GPIO support for the ACCES 104-IDIO-16 family (104-IDIO-16,
diff --git a/drivers/gpio/gpio-104-idio-16.c b/drivers/gpio/gpio-104-idio-16.c
index 098fbefdbe22..f03ccd0f534c 100644
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
@@ -36,187 +33,62 @@ static unsigned int num_irq;
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
+static const struct regmap_access_table idio_16_precious_table = {
+	.yes_ranges = idio_16_precious_ranges,
+	.n_yes_ranges = ARRAY_SIZE(idio_16_precious_ranges),
+};
+static const struct regmap_config idio_16_regmap_config = {
+	.reg_bits = 8,
+	.reg_stride = 1,
+	.val_bits = 8,
+	.io_port = true,
+	.wr_table = &idio_16_wr_table,
+	.rd_table = &idio_16_rd_table,
+	.volatile_table = &idio_16_rd_table,
+	.precious_table = &idio_16_precious_table,
+	.cache_type = REGCACHE_FLAT,
+	.use_raw_spinlock = true,
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
@@ -224,54 +96,22 @@ static int idio_16_probe(struct device *dev, unsigned int id)
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
-
-	girq = &idio16gpio->chip.irq;
-	gpio_irq_chip_set_chip(girq, &idio_16_irqchip);
-	/* This will let us handle the parent IRQ in the driver */
-	girq->parent_handler = NULL;
-	girq->num_parents = 0;
-	girq->parents = NULL;
-	girq->default_type = IRQ_TYPE_NONE;
-	girq->handler = handle_edge_irq;
-	girq->init_hw = idio_16_irq_init_hw;
+	map = devm_regmap_init_mmio(dev, regs, &idio_16_regmap_config);
+	if (IS_ERR(map))
+		return dev_err_probe(dev, PTR_ERR(map), "Unable to initialize register map\n");
 
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
2.39.2


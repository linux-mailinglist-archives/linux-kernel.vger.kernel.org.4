Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7677656BDE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 15:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbiL0Ocx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 09:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbiL0Ocq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 09:32:46 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774E3B1E
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 06:32:45 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id u204so12064921oib.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 06:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8/L0fjGmelRY1w1zXRaRkpn8vBd8u1KBvpXVWvyaHM=;
        b=ffjdghcU3/Igjaeg6IHe7XH9dJBtq4/t6/BVkmGTXDu3G6ifvcm3TIDRnZG+TBPJB0
         9ydSWuCnCWCR9AFjpESW1CJ0ceYuMCocGTBJtOx4SHHVgljepllo7yZQwb2+/sCyOHgw
         dqp9RH2wmzwqgg82EjapGy0je9Fc0UCQmRr2fNZYJRCSgIpYSUj2DrYwL6u5zjtITeYu
         goetUW48000zKzeV7mDB4+AV4uP8B2g98MLctD/HuIMj3yaw/M+pXJVJsE80PlR74x04
         T9LKAYEsWXNrxVUtVAHv+uPa1TVy9CMFPi4+dXAW60/56ZeZuxY3LYad5kNEipOkXHkn
         eMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S8/L0fjGmelRY1w1zXRaRkpn8vBd8u1KBvpXVWvyaHM=;
        b=w4+llY2xagUOssGBPYOehXKIJ+kIxJiKkiNX7hCGOAuTvph6wm0mn4XnGhLLQonVUz
         GITDt0gTAohV6lMXYnbT0JWb4ynY3WH8/Ri6MNIioFWrzlyoZ3R7Co0nygDISwaqlg/Y
         9Advb4uP+C33I5foLHx9gpeBWHkZr3ccaFHvcEN4SNMToYNyikxVM22nS/Bx38ETRsdx
         F+Sa7hY0xzNsi4lqsX+ZFDrAiyhVhwQvAFpR8mmhGutjGd+F+jc7YUmVkozge7uL4upS
         0Fil58NU2WAgkxrqwlOR7SBi9BIgsWALF6cPmlA4d/BBFa8/HJ7XMdlDZTBa50yuvZ9t
         xE3A==
X-Gm-Message-State: AFqh2kp/tzLjLIkqSXs44n7ESg+SuOx1ukH2L/It6/kVxBhlw4ftGNmm
        N4vxjuW4sT4mtuGTEJcsD5xUyA==
X-Google-Smtp-Source: AMrXdXvq9ODv7EsWCJl7M1zVc0621ohTSA1IsHEmmWWQfqBasWw6IW2HY+KDhFpbly/qi2ER0RtnhA==
X-Received: by 2002:aca:1918:0:b0:35c:560f:e2ee with SMTP id l24-20020aca1918000000b0035c560fe2eemr10275887oii.34.1672151565087;
        Tue, 27 Dec 2022 06:32:45 -0800 (PST)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id q205-20020acac0d6000000b0035bce2a39c7sm5864969oif.21.2022.12.27.06.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 06:32:44 -0800 (PST)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     andriy.shevchenko@linux.intel.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael@walle.cc,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v5 2/8] gpio: 104-dio-48e: Migrate to the regmap-irq API
Date:   Tue, 27 Dec 2022 09:09:40 -0500
Message-Id: <3db2ae905ffad298d14005472a823aa66a8afbce.1672149007.git.william.gray@linaro.org>
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
directly in the driver.

For the 104-dio-48e we have the following IRQ registers (0xB and 0xF):

    Base Address +B (Write): Enable Interrupt
    Base Address +B (Read): Disable Interrupt
    Base Address +F (Read/Write): Clear Interrupt

Any write to 0xB will enable interrupts, while any read will disable
interrupts. Interrupts are cleared by a write to 0xF. There's no IRQ
status register, so software has to assume that if an interrupt is
raised then it was for the 104-DIO-48E device.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/gpio/Kconfig            |   2 +
 drivers/gpio/gpio-104-dio-48e.c | 275 +++++++++++++++-----------------
 2 files changed, 135 insertions(+), 142 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index ec7cfd4f52b1..2f8cb03bd975 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -845,6 +845,8 @@ config GPIO_104_DIO_48E
 	tristate "ACCES 104-DIO-48E GPIO support"
 	depends on PC104
 	select ISA_BUS_API
+	select REGMAP_MMIO
+	select REGMAP_IRQ
 	select GPIOLIB_IRQCHIP
 	select GPIO_I8255
 	help
diff --git a/drivers/gpio/gpio-104-dio-48e.c b/drivers/gpio/gpio-104-dio-48e.c
index 7b8829c8e423..e053a4e46b27 100644
--- a/drivers/gpio/gpio-104-dio-48e.c
+++ b/drivers/gpio/gpio-104-dio-48e.c
@@ -8,17 +8,15 @@
  */
 #include <linux/bits.h>
 #include <linux/device.h>
-#include <linux/errno.h>
+#include <linux/err.h>
 #include <linux/gpio/driver.h>
-#include <linux/io.h>
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
@@ -38,46 +36,30 @@ static unsigned int num_irq;
 module_param_hw_array(irq, uint, irq, &num_irq, 0);
 MODULE_PARM_DESC(irq, "ACCES 104-DIO-48E interrupt line numbers");
 
+#define DIO48E_ENABLE_INTERRUPT 0xB
+#define DIO48E_DISABLE_INTERRUPT DIO48E_ENABLE_INTERRUPT
+#define DIO48E_CLEAR_INTERRUPT 0xF
+
 #define DIO48E_NUM_PPI 2
 
 /**
  * struct dio48e_reg - device register structure
  * @ppi:		Programmable Peripheral Interface groups
- * @enable_buffer:	Enable/Disable Buffer groups
- * @unused1:		Unused
- * @enable_interrupt:	Write: Enable Interrupt
- *			Read: Disable Interrupt
- * @unused2:		Unused
- * @enable_counter:	Write: Enable Counter/Timer Addressing
- *			Read: Disable Counter/Timer Addressing
- * @unused3:		Unused
- * @clear_interrupt:	Clear Interrupt
  */
 struct dio48e_reg {
 	struct i8255 ppi[DIO48E_NUM_PPI];
-	u8 enable_buffer[DIO48E_NUM_PPI];
-	u8 unused1;
-	u8 enable_interrupt;
-	u8 unused2;
-	u8 enable_counter;
-	u8 unused3;
-	u8 clear_interrupt;
 };
 
 /**
  * struct dio48e_gpio - GPIO device private data structure
  * @chip:		instance of the gpio_chip
  * @ppi_state:		PPI device states
- * @lock:		synchronization lock to prevent I/O race conditions
  * @reg:		I/O address offset for the device registers
- * @irq_mask:		I/O bits affected by interrupts
  */
 struct dio48e_gpio {
 	struct gpio_chip chip;
 	struct i8255_state ppi_state[DIO48E_NUM_PPI];
-	raw_spinlock_t lock;
 	struct dio48e_reg __iomem *reg;
-	unsigned char irq_mask;
 };
 
 static int dio48e_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
@@ -144,106 +126,95 @@ static void dio48e_gpio_set_multiple(struct gpio_chip *chip,
 			   bits, chip->ngpio);
 }
 
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
+};
 
-	if (!dio48egpio->irq_mask) {
-		/* enable interrupts */
-		iowrite8(0x00, &dio48egpio->reg->clear_interrupt);
-		iowrite8(0x00, &dio48egpio->reg->enable_interrupt);
+/* only bit 3 on each respective Port C supports interrupts */
+#define DIO48E_REGMAP_IRQ(_ppi)						\
+	[19 + (_ppi) * 24] = {						\
+		.mask = BIT(_ppi),					\
+		.type = { .types_supported = IRQ_TYPE_EDGE_RISING },	\
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
+	const unsigned int prev_mask = *irq_mask;
+	const unsigned int all_masked = GENMASK(1, 0);
+	int err;
+	unsigned int val;
 
-	for_each_set_bit(gpio, &irq_mask, 2)
-		generic_handle_domain_irq(chip->irq.domain,
-					  19 + gpio*24);
+	/* exit early if no change since the previous mask */
+	if (mask_buf == prev_mask)
+		return 0;
 
-	raw_spin_lock(&dio48egpio->lock);
+	/* remember the current mask for the next mask sync */
+	*irq_mask = mask_buf;
 
-	iowrite8(0x00, &dio48egpio->reg->clear_interrupt);
+	/* if all previously masked, enable interrupts when unmasking */
+	if (prev_mask == all_masked) {
+		err = regmap_write(map, DIO48E_CLEAR_INTERRUPT, 0x00);
+		if (err)
+			return err;
+		return regmap_write(map, DIO48E_ENABLE_INTERRUPT, 0x00);
+	}
 
-	raw_spin_unlock(&dio48egpio->lock);
+	/* if all are currently masked, disable interrupts */
+	if (mask_buf == all_masked)
+		return regmap_read(map, DIO48E_DISABLE_INTERRUPT, &val);
 
-	return IRQ_HANDLED;
+	return 0;
 }
 
 #define DIO48E_NGPIO 48
@@ -266,14 +237,12 @@ static const char *dio48e_names[DIO48E_NGPIO] = {
 	"PPI Group 1 Port C 5", "PPI Group 1 Port C 6", "PPI Group 1 Port C 7"
 };
 
-static int dio48e_irq_init_hw(struct gpio_chip *gc)
+static int dio48e_irq_init_hw(struct regmap *const map)
 {
-	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(gc);
+	unsigned int val;
 
 	/* Disable IRQ by default */
-	ioread8(&dio48egpio->reg->enable_interrupt);
-
-	return 0;
+	return regmap_read(map, DIO48E_DISABLE_INTERRUPT, &val);
 }
 
 static void dio48e_init_ppi(struct i8255 __iomem *const ppi,
@@ -295,8 +264,12 @@ static int dio48e_probe(struct device *dev, unsigned int id)
 {
 	struct dio48e_gpio *dio48egpio;
 	const char *const name = dev_name(dev);
-	struct gpio_irq_chip *girq;
+	void __iomem *regs;
+	struct regmap *map;
 	int err;
+	struct regmap_irq_chip *chip;
+	unsigned int irq_mask;
+	struct regmap_irq_chip_data *chip_data;
 
 	dio48egpio = devm_kzalloc(dev, sizeof(*dio48egpio), GFP_KERNEL);
 	if (!dio48egpio)
@@ -308,10 +281,46 @@ static int dio48e_probe(struct device *dev, unsigned int id)
 		return -EBUSY;
 	}
 
-	dio48egpio->reg = devm_ioport_map(dev, base[id], DIO48E_EXTENT);
-	if (!dio48egpio->reg)
+	regs = devm_ioport_map(dev, base[id], DIO48E_EXTENT);
+	if (!regs)
+		return -ENOMEM;
+	dio48egpio->reg = regs;
+
+	map = devm_regmap_init_mmio(dev, regs, &dio48e_regmap_config);
+	if (IS_ERR(map))
+		return dev_err_probe(dev, PTR_ERR(map),
+				     "Unable to initialize register map\n");
+
+	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	chip->irq_drv_data = devm_kzalloc(dev, sizeof(irq_mask), GFP_KERNEL);
+	if (!chip->irq_drv_data)
 		return -ENOMEM;
 
+	chip->name = name;
+	/* No IRQ status register so use CLEAR_INTERRUPT register instead */
+	chip->status_base = DIO48E_CLEAR_INTERRUPT;
+	chip->mask_base = DIO48E_ENABLE_INTERRUPT;
+	chip->ack_base = DIO48E_CLEAR_INTERRUPT;
+	/* CLEAR_INTERRUPT doubles as status register so we need it cleared */
+	chip->clear_ack = true;
+	chip->status_invert = true;
+	chip->num_regs = 1;
+	chip->irqs = dio48e_regmap_irqs;
+	chip->num_irqs = ARRAY_SIZE(dio48e_regmap_irqs);
+	chip->handle_mask_sync = dio48e_handle_mask_sync;
+
+	/* Initialize to prevent spurious interrupts before we're ready */
+	err = dio48e_irq_init_hw(map);
+	if (err)
+		return err;
+
+	err = devm_regmap_add_irq_chip(dev, map, irq[id], 0, 0, chip, &chip_data);
+	if (err)
+		return dev_err_probe(dev, err, "IRQ registration failed\n");
+
 	dio48egpio->chip.label = name;
 	dio48egpio->chip.parent = dev;
 	dio48egpio->chip.owner = THIS_MODULE;
@@ -326,18 +335,6 @@ static int dio48e_probe(struct device *dev, unsigned int id)
 	dio48egpio->chip.set = dio48e_gpio_set;
 	dio48egpio->chip.set_multiple = dio48e_gpio_set_multiple;
 
-	girq = &dio48egpio->chip.irq;
-	gpio_irq_chip_set_chip(girq, &dio48e_irqchip);
-	/* This will let us handle the parent IRQ in the driver */
-	girq->parent_handler = NULL;
-	girq->num_parents = 0;
-	girq->parents = NULL;
-	girq->default_type = IRQ_TYPE_NONE;
-	girq->handler = handle_edge_irq;
-	girq->init_hw = dio48e_irq_init_hw;
-
-	raw_spin_lock_init(&dio48egpio->lock);
-
 	i8255_state_init(dio48egpio->ppi_state, DIO48E_NUM_PPI);
 	dio48e_init_ppi(dio48egpio->reg->ppi, dio48egpio->ppi_state);
 
@@ -347,14 +344,8 @@ static int dio48e_probe(struct device *dev, unsigned int id)
 		return err;
 	}
 
-	err = devm_request_irq(dev, irq[id], dio48e_irq_handler, 0, name,
-		dio48egpio);
-	if (err) {
-		dev_err(dev, "IRQ handler registering failed (%d)\n", err);
-		return err;
-	}
-
-	return 0;
+	return gpiochip_irqchip_add_domain(&dio48egpio->chip,
+					   regmap_irq_get_domain(chip_data));
 }
 
 static struct isa_driver dio48e_driver = {
-- 
2.38.1


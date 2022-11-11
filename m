Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514CD626D46
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 02:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235165AbiKMBJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 20:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235143AbiKMBJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 20:09:50 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964ED140AC
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 17:09:48 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id s4so5040008qtx.6
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 17:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCizZ3AFWVpYxg+w13MO/OuiqXytWKoIVvBigEvt7tw=;
        b=EKH9vUsqp3DsMCowyBU3FA8yho1/0Q13WFf3iaZeFdmandcyTAsE88bkrj1TmLPyY2
         IZb4ykeiKrp1L005OBx1UkcCAL+rX4z8WPkJT4ZK1cTGsPKIbH2f0sCu5jy/uG5+027F
         af9N0kPfBScck88ImMRn08ypxw9Wv8RacYR/TmNywx+Dhdn216fSdU0v0zHvkIYRVHI+
         KsC6Pp/rlV9SbDUG00JCCwW+wUCp2+hDjB1vcJCcmC0zrANU0Z8iMt2ceUQgDD3Db71i
         fQQj2OFtCgUfcMHGQZ3qrvV/NjGJ7aX5wCX8XwBCFgmz3ULJ5M9zfKrKBEs6SgLMKWk+
         bYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SCizZ3AFWVpYxg+w13MO/OuiqXytWKoIVvBigEvt7tw=;
        b=t5jMmVc8XhP3rgA8J58P7r+Ep9W3cg8ZL2Opk7tRiPqB//dUO391Cv90d1v/pNwxvW
         cBDXobFiZfpwSEs8MY8w+7By2IzZY3Qg1DRyineFrGTv2Ex7QVZs2ZIfj4b4bInsP8Rx
         wbTD/e3NehYjiJNYYMPSTgrsOXWxk82vyuMXHFv7kJ5cUkekqyRqoJdXIKjP3IbqwkSE
         NQIe42Xt+XiXKwxtVjyg1fcsVGi4U/sLTwkfzecz+rVyS5is28M+eOufdaiGp7IDDK8E
         MPJVvmZ66DlCbU2kkuiPtSis6ycV7LJXCExvKx6YL+haOuAIKDGjalh2HTDwVBT797H3
         MaTg==
X-Gm-Message-State: ANoB5plV0YJHGt6MoN5O0+AjKLUoYhh/fNdoUSyKecffTREfAF3Slt5c
        vloGo3UKa2yqmCjf8VShgLUJUg==
X-Google-Smtp-Source: AA0mqf5myYeMHXpUW7Qn8biIY/0l0crpQLL9nKEwE3OQ9mAvmv9X7m1KYnpgMZ99KXUgYlaqcLGzUA==
X-Received: by 2002:ac8:4e87:0:b0:3a5:6797:c57a with SMTP id 7-20020ac84e87000000b003a56797c57amr7222298qtp.34.1668301788207;
        Sat, 12 Nov 2022 17:09:48 -0800 (PST)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id t6-20020a05622a180600b00343057845f7sm3552498qtc.20.2022.11.12.17.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 17:09:47 -0800 (PST)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     andriy.shevchenko@linux.intel.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael@walle.cc, broonie@kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v2 3/4] gpio: 104-idi-48: Migrate to regmap API
Date:   Thu, 10 Nov 2022 20:55:52 -0500
Message-Id: <849f73b288185249880839791bfc49056ae36d50.1668129763.git.william.gray@linaro.org>
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
directly in the driver. Despite the underlying interface being based on
i8255, it is simpler to use the gpio_regmap API directly because the
104-IDI-48 device features only input signals. Therefore, the dependence
on the i8255 GPIO library is removed in this patch.

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/gpio/Kconfig           |   3 +-
 drivers/gpio/gpio-104-idi-48.c | 329 ++++++++++-----------------------
 2 files changed, 104 insertions(+), 228 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index ec7cfd4f52b1..a9852782566d 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -871,7 +871,8 @@ config GPIO_104_IDI_48
 	depends on PC104
 	select ISA_BUS_API
 	select GPIOLIB_IRQCHIP
-	select GPIO_I8255
+	select REGMAP_IRQ
+	select GPIO_REGMAP
 	help
 	  Enables GPIO support for the ACCES 104-IDI-48 family (104-IDI-48A,
 	  104-IDI-48AC, 104-IDI-48B, 104-IDI-48BC). The base port addresses for
diff --git a/drivers/gpio/gpio-104-idi-48.c b/drivers/gpio/gpio-104-idi-48.c
index c5e231fde1af..120ae6d01f43 100644
--- a/drivers/gpio/gpio-104-idi-48.c
+++ b/drivers/gpio/gpio-104-idi-48.c
@@ -8,23 +8,18 @@
  */
 #include <linux/bits.h>
 #include <linux/device.h>
-#include <linux/errno.h>
-#include <linux/gpio/driver.h>
-#include <linux/io.h>
-#include <linux/ioport.h>
+#include <linux/err.h>
+#include <linux/gpio/regmap.h>
 #include <linux/interrupt.h>
-#include <linux/irqdesc.h>
+#include <linux/ioport.h>
+#include <linux/irq.h>
 #include <linux/isa.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/spinlock.h>
+#include <linux/regmap.h>
 #include <linux/types.h>
 
-#include "gpio-i8255.h"
-
-MODULE_IMPORT_NS(I8255);
-
 #define IDI_48_EXTENT 8
 #define MAX_NUM_IDI_48 max_num_isa_dev(IDI_48_EXTENT)
 
@@ -38,185 +33,82 @@ static unsigned int num_irq;
 module_param_hw_array(irq, uint, irq, &num_irq, 0);
 MODULE_PARM_DESC(irq, "ACCES 104-IDI-48 interrupt line numbers");
 
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
+#define IDI48_IRQ_REG 0x7
 
-/**
- * struct idi_48_gpio - GPIO device private data structure
- * @chip:	instance of the gpio_chip
- * @lock:	synchronization lock to prevent I/O race conditions
- * @irq_mask:	input bits affected by interrupts
- * @reg:	I/O address offset for the device registers
- * @cos_enb:	Change-Of-State IRQ enable boundaries mask
- */
-struct idi_48_gpio {
-	struct gpio_chip chip;
-	spinlock_t lock;
-	unsigned char irq_mask[6];
-	struct idi_48_reg __iomem *reg;
-	unsigned char cos_enb;
-};
-
-static int idi_48_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
+static int idi_48_reg_mask_xlate(struct gpio_regmap *gpio, unsigned int base,
+				 unsigned int offset, unsigned int *reg,
+				 unsigned int *mask)
 {
-	return GPIO_LINE_DIRECTION_IN;
-}
+	const unsigned int line = offset % 8;
+	const unsigned int stride = offset / 8;
+	const unsigned int port = (stride / 3) * 4;
+	const unsigned int port_stride = stride % 3;
 
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
-{
-	struct idi_48_gpio *const idi48gpio = gpiochip_get_data(chip);
-	void __iomem *const ppi = idi48gpio->reg;
-
-	i8255_get_multiple(ppi, mask, bits, chip->ngpio);
+	*reg = base + port + port_stride;
+	*mask = BIT(line);
 
 	return 0;
 }
 
-static void idi_48_irq_ack(struct irq_data *data)
-{
-}
-
-static void idi_48_irq_mask(struct irq_data *data)
-{
-	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
-	struct idi_48_gpio *const idi48gpio = gpiochip_get_data(chip);
-	const unsigned int offset = irqd_to_hwirq(data);
-	const unsigned long boundary = offset / 8;
-	const unsigned long mask = BIT(offset % 8);
-	unsigned long flags;
-
-	spin_lock_irqsave(&idi48gpio->lock, flags);
-
-	idi48gpio->irq_mask[boundary] &= ~mask;
-	gpiochip_disable_irq(chip, offset);
-
-	/* Exit early if there are still input lines with IRQ unmasked */
-	if (idi48gpio->irq_mask[boundary])
-		goto exit;
-
-	idi48gpio->cos_enb &= ~BIT(boundary);
-
-	iowrite8(idi48gpio->cos_enb, &idi48gpio->reg->irq);
-
-exit:
-	spin_unlock_irqrestore(&idi48gpio->lock, flags);
-}
-
-static void idi_48_irq_unmask(struct irq_data *data)
-{
-	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
-	struct idi_48_gpio *const idi48gpio = gpiochip_get_data(chip);
-	const unsigned int offset = irqd_to_hwirq(data);
-	const unsigned long boundary = offset / 8;
-	const unsigned long mask = BIT(offset % 8);
-	unsigned int prev_irq_mask;
-	unsigned long flags;
-
-	spin_lock_irqsave(&idi48gpio->lock, flags);
-
-	prev_irq_mask = idi48gpio->irq_mask[boundary];
-
-	gpiochip_enable_irq(chip, offset);
-	idi48gpio->irq_mask[boundary] |= mask;
-
-	/* Exit early if IRQ was already unmasked for this boundary */
-	if (prev_irq_mask)
-		goto exit;
-
-	idi48gpio->cos_enb |= BIT(boundary);
-
-	iowrite8(idi48gpio->cos_enb, &idi48gpio->reg->irq);
-
-exit:
-	spin_unlock_irqrestore(&idi48gpio->lock, flags);
-}
-
-static int idi_48_irq_set_type(struct irq_data *data, unsigned int flow_type)
-{
-	/* The only valid irq types are none and both-edges */
-	if (flow_type != IRQ_TYPE_NONE &&
-		(flow_type & IRQ_TYPE_EDGE_BOTH) != IRQ_TYPE_EDGE_BOTH)
-		return -EINVAL;
-
-	return 0;
-}
-
-static const struct irq_chip idi_48_irqchip = {
-	.name = "104-idi-48",
-	.irq_ack = idi_48_irq_ack,
-	.irq_mask = idi_48_irq_mask,
-	.irq_unmask = idi_48_irq_unmask,
-	.irq_set_type = idi_48_irq_set_type,
-	.flags = IRQCHIP_IMMUTABLE,
-	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+static const struct regmap_range idi_48_wr_ranges[] = {
+	regmap_reg_range(0x0, 0x6),
+};
+static const struct regmap_range idi_48_rd_ranges[] = {
+	regmap_reg_range(0x0, 0x2), regmap_reg_range(0x4, 0x7),
+};
+static const struct regmap_range idi_48_precious_ranges[] = {
+	regmap_reg_range(0x7, 0x7),
+};
+static const struct regmap_access_table idi_48_wr_table = {
+	.no_ranges = idi_48_wr_ranges,
+	.n_no_ranges = ARRAY_SIZE(idi_48_wr_ranges),
+};
+static const struct regmap_access_table idi_48_rd_table = {
+	.yes_ranges = idi_48_rd_ranges,
+	.n_yes_ranges = ARRAY_SIZE(idi_48_rd_ranges),
+};
+static const struct regmap_access_table idi_48_precious_table = {
+	.yes_ranges = idi_48_precious_ranges,
+	.n_yes_ranges = ARRAY_SIZE(idi_48_precious_ranges),
+};
+static const struct regmap_config idi48_regmap_config = {
+	.reg_bits = 8,
+	.reg_stride = 1,
+	.val_bits = 8,
+	.io_port = true,
+	.max_register = 0x6,
+	.wr_table = &idi_48_wr_table,
+	.rd_table = &idi_48_rd_table,
+	.precious_table = &idi_48_precious_table,
 };
-
-static irqreturn_t idi_48_irq_handler(int irq, void *dev_id)
-{
-	struct idi_48_gpio *const idi48gpio = dev_id;
-	unsigned long cos_status;
-	unsigned long boundary;
-	unsigned long irq_mask;
-	unsigned long bit_num;
-	unsigned long gpio;
-	struct gpio_chip *const chip = &idi48gpio->chip;
-
-	spin_lock(&idi48gpio->lock);
-
-	cos_status = ioread8(&idi48gpio->reg->irq);
-
-	/* IRQ Status (bit 6) is active low (0 = IRQ generated by device) */
-	if (cos_status & BIT(6)) {
-		spin_unlock(&idi48gpio->lock);
-		return IRQ_NONE;
-	}
-
-	/* Bit 0-5 indicate which Change-Of-State boundary triggered the IRQ */
-	cos_status &= 0x3F;
-
-	for_each_set_bit(boundary, &cos_status, 6) {
-		irq_mask = idi48gpio->irq_mask[boundary];
-
-		for_each_set_bit(bit_num, &irq_mask, 8) {
-			gpio = bit_num + boundary * 8;
-
-			generic_handle_domain_irq(chip->irq.domain,
-						  gpio);
-		}
-	}
-
-	spin_unlock(&idi48gpio->lock);
-
-	return IRQ_HANDLED;
-}
 
 #define IDI48_NGPIO 48
+
+#define IDI48_REGMAP_IRQ(_id) \
+	[_id] = { \
+		.mask = BIT((_id) / 8), \
+		.type = { .types_supported = IRQ_TYPE_EDGE_BOTH, }, \
+	}
+
+static const struct regmap_irq idi48_regmap_irqs[IDI48_NGPIO] = {
+	IDI48_REGMAP_IRQ(0), IDI48_REGMAP_IRQ(1), IDI48_REGMAP_IRQ(2),
+	IDI48_REGMAP_IRQ(3), IDI48_REGMAP_IRQ(4), IDI48_REGMAP_IRQ(5),
+	IDI48_REGMAP_IRQ(6), IDI48_REGMAP_IRQ(7), IDI48_REGMAP_IRQ(8),
+	IDI48_REGMAP_IRQ(9), IDI48_REGMAP_IRQ(10), IDI48_REGMAP_IRQ(11),
+	IDI48_REGMAP_IRQ(12), IDI48_REGMAP_IRQ(13), IDI48_REGMAP_IRQ(14),
+	IDI48_REGMAP_IRQ(15), IDI48_REGMAP_IRQ(16), IDI48_REGMAP_IRQ(17),
+	IDI48_REGMAP_IRQ(18), IDI48_REGMAP_IRQ(19), IDI48_REGMAP_IRQ(20),
+	IDI48_REGMAP_IRQ(21), IDI48_REGMAP_IRQ(22), IDI48_REGMAP_IRQ(23),
+	IDI48_REGMAP_IRQ(24), IDI48_REGMAP_IRQ(25), IDI48_REGMAP_IRQ(26),
+	IDI48_REGMAP_IRQ(27), IDI48_REGMAP_IRQ(28), IDI48_REGMAP_IRQ(29),
+	IDI48_REGMAP_IRQ(30), IDI48_REGMAP_IRQ(31), IDI48_REGMAP_IRQ(32),
+	IDI48_REGMAP_IRQ(33), IDI48_REGMAP_IRQ(34), IDI48_REGMAP_IRQ(35),
+	IDI48_REGMAP_IRQ(36), IDI48_REGMAP_IRQ(37), IDI48_REGMAP_IRQ(38),
+	IDI48_REGMAP_IRQ(39), IDI48_REGMAP_IRQ(40), IDI48_REGMAP_IRQ(41),
+	IDI48_REGMAP_IRQ(42), IDI48_REGMAP_IRQ(43), IDI48_REGMAP_IRQ(44),
+	IDI48_REGMAP_IRQ(45), IDI48_REGMAP_IRQ(46), IDI48_REGMAP_IRQ(47),
+};
+
 static const char *idi48_names[IDI48_NGPIO] = {
 	"Bit 0 A", "Bit 1 A", "Bit 2 A", "Bit 3 A", "Bit 4 A", "Bit 5 A",
 	"Bit 6 A", "Bit 7 A", "Bit 8 A", "Bit 9 A", "Bit 10 A", "Bit 11 A",
@@ -228,75 +120,58 @@ static const char *idi48_names[IDI48_NGPIO] = {
 	"Bit 18 B", "Bit 19 B", "Bit 20 B", "Bit 21 B", "Bit 22 B", "Bit 23 B"
 };
 
-static int idi_48_irq_init_hw(struct gpio_chip *gc)
-{
-	struct idi_48_gpio *const idi48gpio = gpiochip_get_data(gc);
-
-	/* Disable IRQ by default */
-	iowrite8(0, &idi48gpio->reg->irq);
-	ioread8(&idi48gpio->reg->irq);
-
-	return 0;
-}
-
 static int idi_48_probe(struct device *dev, unsigned int id)
 {
-	struct idi_48_gpio *idi48gpio;
 	const char *const name = dev_name(dev);
-	struct gpio_irq_chip *girq;
+	struct gpio_regmap_config config = {0};
+	void __iomem *regs;
+	struct regmap_irq_chip *chip;
+	struct regmap_irq_chip_data *chip_data;
 	int err;
 
-	idi48gpio = devm_kzalloc(dev, sizeof(*idi48gpio), GFP_KERNEL);
-	if (!idi48gpio)
-		return -ENOMEM;
-
 	if (!devm_request_region(dev, base[id], IDI_48_EXTENT, name)) {
 		dev_err(dev, "Unable to lock port addresses (0x%X-0x%X)\n",
 			base[id], base[id] + IDI_48_EXTENT);
 		return -EBUSY;
 	}
 
-	idi48gpio->reg = devm_ioport_map(dev, base[id], IDI_48_EXTENT);
-	if (!idi48gpio->reg)
+	regs = devm_ioport_map(dev, base[id], IDI_48_EXTENT);
+	if (!regs)
 		return -ENOMEM;
 
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
+	config.regmap = devm_regmap_init_mmio(dev, regs, &idi48_regmap_config);
+	if (IS_ERR(config.regmap))
+		return PTR_ERR(config.regmap);
 
-	girq = &idi48gpio->chip.irq;
-	gpio_irq_chip_set_chip(girq, &idi_48_irqchip);
-	/* This will let us handle the parent IRQ in the driver */
-	girq->parent_handler = NULL;
-	girq->num_parents = 0;
-	girq->parents = NULL;
-	girq->default_type = IRQ_TYPE_NONE;
-	girq->handler = handle_edge_irq;
-	girq->init_hw = idi_48_irq_init_hw;
+	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
 
-	spin_lock_init(&idi48gpio->lock);
+	chip->name = name;
+	chip->status_base = IDI48_IRQ_REG;
+	chip->unmask_base = IDI48_IRQ_REG;
+	chip->clear_on_unmask = true;
+	chip->num_regs = 1;
+	chip->irqs = idi48_regmap_irqs;
+	chip->num_irqs = ARRAY_SIZE(idi48_regmap_irqs);
+
+	err = devm_regmap_add_irq_chip(dev, config.regmap, irq[id], IRQF_SHARED,
+				       0, chip, &chip_data);
 
-	err = devm_gpiochip_add_data(dev, &idi48gpio->chip, idi48gpio);
 	if (err) {
-		dev_err(dev, "GPIO registering failed (%d)\n", err);
+		dev_err(dev, "IRQ registration failed (%d)\n", err);
 		return err;
 	}
 
-	err = devm_request_irq(dev, irq[id], idi_48_irq_handler, IRQF_SHARED,
-		name, idi48gpio);
-	if (err) {
-		dev_err(dev, "IRQ handler registering failed (%d)\n", err);
-		return err;
-	}
+	config.parent = dev;
+	config.ngpio = IDI48_NGPIO;
+	config.names = idi48_names;
+	config.reg_dat_base = GPIO_REGMAP_ADDR(0x0);
+	config.ngpio_per_reg = 8;
+	config.reg_mask_xlate = idi_48_reg_mask_xlate;
+	config.irq_domain = regmap_irq_get_domain(chip_data);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(devm_gpio_regmap_register(dev, &config));
 }
 
 static struct isa_driver idi_48_driver = {
-- 
2.38.1


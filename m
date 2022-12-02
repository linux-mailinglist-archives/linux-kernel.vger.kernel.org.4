Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1CC640AB7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234140AbiLBQ1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234083AbiLBQ12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:27:28 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48EF55A2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 08:27:26 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id a27so5822967qtw.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 08:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TqC2qQi/m5/bMJ/IGRccY1o0CwWxGaNKxplVl7YEMaw=;
        b=wPPUf/BHvj30vXef1lm0dCJkD7yMNhgG2baLoK/EHeIgFd4T0Uhrm4FwCK52WA2rql
         GsNTvwSl3ewCLeDfPuLbP2A5pQ+RdqnoFLqqbsDYCGBhbJjI1eAUNqeGMlfPxvOv8y1b
         bNnor8sLxEkEQtLE6sUSPitHDZF+c1OIZvgrTfXJS9nYNfy7EmNBYicn3PXZ8Ct7K51j
         OZu7/9eV8zAmtyjWWuJep570zduIxLd5ilYL0BUMYjlsQb0hQo2pcSkSM9Bc1m0DMGz5
         sKOTO1of9ku5Qq9qoE2mxFJudM1ZTcBY7w3RajHAsusGmOMlZhgk3dsga+z5qIoszlmV
         14YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TqC2qQi/m5/bMJ/IGRccY1o0CwWxGaNKxplVl7YEMaw=;
        b=P54hoUV5cjkdfAc6r4nS78MSvYjv6XyEvp1VFMtPJBMd1Ifpe4a81LBy8PTeH4D/6n
         LAx5A8EUpKFQmErsO0vAOoZu1rSTKI7pOH8v3xNKAyU8axpybl/3M3jHBiNqB1sWfKVY
         XF21RLniEMMCHO7mEvURjoKtmWsasAYCD23MdzQUXoV5jI+F8WXwHtbjWXSOTU7lUI8R
         wAC3i4Gs6Zf6le1Ft7YwLQdzj+p1tVi4t82xFELvQW1MsijxWygNXiIhoGTXlPExZdrf
         QCTtMP2PtAr1S/Vy6+vxriT2ZqQ6KyjQojj2LYqZkzaCOgIM+1idc2ELCRwzBCZqEyeq
         tZYw==
X-Gm-Message-State: ANoB5pkNk83soc4bOS9H5u/+jLxBJTMD8J1HhJdyQ+2O/6pkMNBP+3tQ
        H3IEvpP0f5XWFvIHZ2HhykthkQ==
X-Google-Smtp-Source: AA0mqf5nUbbBG7b2QOept4qBOv9VyVG+IdOWD0nL/8G5FOaZebJG34AXSk2bWu8XKq1NNO5ph25lsw==
X-Received: by 2002:a05:620a:22a2:b0:6fa:2ec7:3e0 with SMTP id p2-20020a05620a22a200b006fa2ec703e0mr47349417qkh.392.1669998445892;
        Fri, 02 Dec 2022 08:27:25 -0800 (PST)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id fp38-20020a05622a50a600b00343057845f7sm4391887qtb.20.2022.12.02.08.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 08:27:25 -0800 (PST)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     andriy.shevchenko@linux.intel.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael@walle.cc, broonie@kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v4 4/9] gpio: 104-idi-48: Migrate to the regmap-irq API
Date:   Fri,  2 Dec 2022 11:27:10 -0500
Message-Id: <ee81eff1736903e444f89e88b83205eb3fadaf3a.1669996867.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1669996866.git.william.gray@linaro.org>
References: <cover.1669996866.git.william.gray@linaro.org>
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

For the 104-idi-48, we get an IRQ register with some status information
and basic masking, but it's broken down by banks rather than individual
GPIO. There are six banks (8 GPIO lines each) that correspond to the
lower six bits of the IRQ register (bits 0-5):

    Base Address + 7 (Read): IRQ Status Register/IRQ Clear
        Bit 0-5: Respective Bank IRQ Statuses
        Bit 6: IRQ Status (Active Low)
        Bit 7: IRQ Enable Status
    Base Address + 7 (Write): IRQ Enable/Disable
        Bit 0-5: Respective Bank IRQ Enable/Disable

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/gpio/Kconfig           |   1 +
 drivers/gpio/gpio-104-idi-48.c | 249 ++++++++++++---------------------
 2 files changed, 92 insertions(+), 158 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index b62bef4e563d..6892979e511a 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -871,6 +871,7 @@ config GPIO_104_IDI_48
 	tristate "ACCES 104-IDI-48 GPIO support"
 	depends on PC104
 	select ISA_BUS_API
+	select REGMAP_IRQ
 	select GPIOLIB_IRQCHIP
 	select GPIO_I8255
 	help
diff --git a/drivers/gpio/gpio-104-idi-48.c b/drivers/gpio/gpio-104-idi-48.c
index c5e231fde1af..f936e3e0ff12 100644
--- a/drivers/gpio/gpio-104-idi-48.c
+++ b/drivers/gpio/gpio-104-idi-48.c
@@ -8,17 +8,16 @@
  */
 #include <linux/bits.h>
 #include <linux/device.h>
-#include <linux/errno.h>
+#include <linux/err.h>
 #include <linux/gpio/driver.h>
-#include <linux/io.h>
-#include <linux/ioport.h>
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
 
 #include "gpio-i8255.h"
@@ -38,6 +37,9 @@ static unsigned int num_irq;
 module_param_hw_array(irq, uint, irq, &num_irq, 0);
 MODULE_PARM_DESC(irq, "ACCES 104-IDI-48 interrupt line numbers");
 
+#define IDI48_IRQ_STATUS 0x7
+#define IDI48_IRQ_ENABLE IDI48_IRQ_STATUS
+
 /**
  * struct idi_48_reg - device register structure
  * @port0:	Port 0 Inputs
@@ -56,17 +58,11 @@ struct idi_48_reg {
 /**
  * struct idi_48_gpio - GPIO device private data structure
  * @chip:	instance of the gpio_chip
- * @lock:	synchronization lock to prevent I/O race conditions
- * @irq_mask:	input bits affected by interrupts
  * @reg:	I/O address offset for the device registers
- * @cos_enb:	Change-Of-State IRQ enable boundaries mask
  */
 struct idi_48_gpio {
 	struct gpio_chip chip;
-	spinlock_t lock;
-	unsigned char irq_mask[6];
 	struct idi_48_reg __iomem *reg;
-	unsigned char cos_enb;
 };
 
 static int idi_48_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
@@ -98,125 +94,65 @@ static int idi_48_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
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
+#define IDI48_NGPIO 48
 
-			generic_handle_domain_irq(chip->irq.domain,
-						  gpio);
-		}
+#define IDI48_REGMAP_IRQ(_id)						\
+	[_id] = {							\
+		.mask = BIT((_id) / 8),					\
+		.type = { .types_supported = IRQ_TYPE_EDGE_BOTH },	\
 	}
 
-	spin_unlock(&idi48gpio->lock);
-
-	return IRQ_HANDLED;
-}
+static const struct regmap_irq idi48_regmap_irqs[IDI48_NGPIO] = {
+	IDI48_REGMAP_IRQ(0), IDI48_REGMAP_IRQ(1), IDI48_REGMAP_IRQ(2), /* 0-2 */
+	IDI48_REGMAP_IRQ(3), IDI48_REGMAP_IRQ(4), IDI48_REGMAP_IRQ(5), /* 3-5 */
+	IDI48_REGMAP_IRQ(6), IDI48_REGMAP_IRQ(7), IDI48_REGMAP_IRQ(8), /* 6-8 */
+	IDI48_REGMAP_IRQ(9), IDI48_REGMAP_IRQ(10), IDI48_REGMAP_IRQ(11), /* 9-11 */
+	IDI48_REGMAP_IRQ(12), IDI48_REGMAP_IRQ(13), IDI48_REGMAP_IRQ(14), /* 12-14 */
+	IDI48_REGMAP_IRQ(15), IDI48_REGMAP_IRQ(16), IDI48_REGMAP_IRQ(17), /* 15-17 */
+	IDI48_REGMAP_IRQ(18), IDI48_REGMAP_IRQ(19), IDI48_REGMAP_IRQ(20), /* 18-20 */
+	IDI48_REGMAP_IRQ(21), IDI48_REGMAP_IRQ(22), IDI48_REGMAP_IRQ(23), /* 21-23 */
+	IDI48_REGMAP_IRQ(24), IDI48_REGMAP_IRQ(25), IDI48_REGMAP_IRQ(26), /* 24-26 */
+	IDI48_REGMAP_IRQ(27), IDI48_REGMAP_IRQ(28), IDI48_REGMAP_IRQ(29), /* 27-29 */
+	IDI48_REGMAP_IRQ(30), IDI48_REGMAP_IRQ(31), IDI48_REGMAP_IRQ(32), /* 30-32 */
+	IDI48_REGMAP_IRQ(33), IDI48_REGMAP_IRQ(34), IDI48_REGMAP_IRQ(35), /* 33-35 */
+	IDI48_REGMAP_IRQ(36), IDI48_REGMAP_IRQ(37), IDI48_REGMAP_IRQ(38), /* 36-38 */
+	IDI48_REGMAP_IRQ(39), IDI48_REGMAP_IRQ(40), IDI48_REGMAP_IRQ(41), /* 39-41 */
+	IDI48_REGMAP_IRQ(42), IDI48_REGMAP_IRQ(43), IDI48_REGMAP_IRQ(44), /* 42-44 */
+	IDI48_REGMAP_IRQ(45), IDI48_REGMAP_IRQ(46), IDI48_REGMAP_IRQ(47), /* 45-47 */
+};
 
-#define IDI48_NGPIO 48
 static const char *idi48_names[IDI48_NGPIO] = {
 	"Bit 0 A", "Bit 1 A", "Bit 2 A", "Bit 3 A", "Bit 4 A", "Bit 5 A",
 	"Bit 6 A", "Bit 7 A", "Bit 8 A", "Bit 9 A", "Bit 10 A", "Bit 11 A",
@@ -228,22 +164,14 @@ static const char *idi48_names[IDI48_NGPIO] = {
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
 	struct idi_48_gpio *idi48gpio;
 	const char *const name = dev_name(dev);
-	struct gpio_irq_chip *girq;
+	void __iomem *regs;
+	struct regmap *map;
+	struct regmap_irq_chip *chip;
+	struct regmap_irq_chip_data *chip_data;
 	int err;
 
 	idi48gpio = devm_kzalloc(dev, sizeof(*idi48gpio), GFP_KERNEL);
@@ -256,9 +184,32 @@ static int idi_48_probe(struct device *dev, unsigned int id)
 		return -EBUSY;
 	}
 
-	idi48gpio->reg = devm_ioport_map(dev, base[id], IDI_48_EXTENT);
-	if (!idi48gpio->reg)
+	regs = devm_ioport_map(dev, base[id], IDI_48_EXTENT);
+	if (!regs)
 		return -ENOMEM;
+	idi48gpio->reg = regs;
+
+	map = devm_regmap_init_mmio(dev, regs, &idi48_regmap_config);
+	if (IS_ERR(map))
+		return dev_err_probe(dev, PTR_ERR(map),
+				     "Unable to initialize register map\n");
+
+	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	chip->name = name;
+	chip->status_base = IDI48_IRQ_STATUS;
+	chip->unmask_base = IDI48_IRQ_ENABLE;
+	chip->clear_on_unmask = true;
+	chip->num_regs = 1;
+	chip->irqs = idi48_regmap_irqs;
+	chip->num_irqs = ARRAY_SIZE(idi48_regmap_irqs);
+
+	err = devm_regmap_add_irq_chip(dev, map, irq[id], IRQF_SHARED, 0, chip,
+				       &chip_data);
+	if (err)
+		return dev_err_probe(dev, err, "IRQ registration failed\n");
 
 	idi48gpio->chip.label = name;
 	idi48gpio->chip.parent = dev;
@@ -271,32 +222,14 @@ static int idi_48_probe(struct device *dev, unsigned int id)
 	idi48gpio->chip.get = idi_48_gpio_get;
 	idi48gpio->chip.get_multiple = idi_48_gpio_get_multiple;
 
-	girq = &idi48gpio->chip.irq;
-	gpio_irq_chip_set_chip(girq, &idi_48_irqchip);
-	/* This will let us handle the parent IRQ in the driver */
-	girq->parent_handler = NULL;
-	girq->num_parents = 0;
-	girq->parents = NULL;
-	girq->default_type = IRQ_TYPE_NONE;
-	girq->handler = handle_edge_irq;
-	girq->init_hw = idi_48_irq_init_hw;
-
-	spin_lock_init(&idi48gpio->lock);
-
 	err = devm_gpiochip_add_data(dev, &idi48gpio->chip, idi48gpio);
 	if (err) {
 		dev_err(dev, "GPIO registering failed (%d)\n", err);
 		return err;
 	}
 
-	err = devm_request_irq(dev, irq[id], idi_48_irq_handler, IRQF_SHARED,
-		name, idi48gpio);
-	if (err) {
-		dev_err(dev, "IRQ handler registering failed (%d)\n", err);
-		return err;
-	}
-
-	return 0;
+	return gpiochip_irqchip_add_domain(&idi48gpio->chip,
+					   regmap_irq_get_domain(chip_data));
 }
 
 static struct isa_driver idi_48_driver = {
-- 
2.38.1


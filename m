Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5010A61E09B
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 08:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiKFHOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 02:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiKFHO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 02:14:26 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BECCBC1F
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 00:14:25 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id i12so6210008qvs.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 00:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jSI7IEY3QF+DmTY4W7lcFELHzLANUdf1FEu53c2Ef5k=;
        b=n6AyiiL0R6uOG+W1qwiXARF/nvrusLX/gTs4WBpAK4FE1PeQUJdvEfJgBRDhyIdzpk
         MF9iNC3kisnOjXaPTDZUMBxWa+T6l4uU0TD1ZVZYSuUX/pcP6FVvEhnbxKcIrZs4GZzI
         4oClv+o1q8Kko/PzmYAXRLnZz7kULZH7TaDKiQIms/QdRf9GDD4Is1N71X0A5KR/nIa/
         xsi96h48sXzhWYmpNwQq+ghAnNjoCMEdOZqJwbFcp3ZZuLSc/d3/Xd3gzcfiS0cvIAYU
         YGHYTb1IgCicvi/SOZnDWa4F1AP4cKnjAeAw7ZE6DGxMzPZZcvHL12C7KIM/DI8IlEHs
         EkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jSI7IEY3QF+DmTY4W7lcFELHzLANUdf1FEu53c2Ef5k=;
        b=AWU/4h94iWdML+qSraOvYbgbWjMZqTX4xyeLzWjyjAAPwkPlP0e6/ciAoHeKno3fkb
         IWZt7eomy0vhg8KHYKyzapq57fmXkW1Slbaty0hDdiAdovLBG4hzZVbp8w2Bpe5q+x28
         MWoJo0Wtffr8QtiggOQlohv+QDKdmfvm7xWibE+ba5YoIbRyMytfizv7Cwkq4y6YkzYI
         Niatt3LiwNh++dPlsHqdu1xJ+e9ieDhuyYNMtpW/4AXPDSyETMLsNdZXwwRQQ90FCSkd
         I4Fdf+AnpM0aRRoc2tzUF+rV+zG+Mq/eKg5Z7yDCQIpgEc/gFjVd+dI2AHXCJN9UU8ab
         VP5g==
X-Gm-Message-State: ACrzQf0tMO2GxJ/v3TacNbMYnZKGwrYHqLPbprpWIwuLADtxKKC03wa4
        W/u4ufSliR5iJhaOzQlv8KQEpQ==
X-Google-Smtp-Source: AMsMyM5M7TZKzmHkMbn2Zuo4nSAyt7d0RRXzAFK9FTEXWRw/Out2tW0rh4k3SUkMTx52QU04sIay+A==
X-Received: by 2002:a05:6214:5289:b0:4bb:6a33:37d7 with SMTP id kj9-20020a056214528900b004bb6a3337d7mr39554002qvb.31.1667718864477;
        Sun, 06 Nov 2022 00:14:24 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id t29-20020a37ea1d000000b006af0ce13499sm3719038qkj.115.2022.11.06.00.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 00:14:24 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     andriy.shevchenko@linux.intel.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH 1/3] gpio: 104-dio-48e: Migrate to regmap API
Date:   Thu,  3 Nov 2022 07:20:47 -0400
Message-Id: <523cfe2bfbf804e64e8c9f6ed38339e850e6d9d9.1667472555.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1667472555.git.william.gray@linaro.org>
References: <cover.1667472555.git.william.gray@linaro.org>
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

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/gpio/gpio-104-dio-48e.c | 95 ++++++++++++++++++++++-----------
 1 file changed, 64 insertions(+), 31 deletions(-)

diff --git a/drivers/gpio/gpio-104-dio-48e.c b/drivers/gpio/gpio-104-dio-48e.c
index 7b8829c8e423..134e3dd12ae9 100644
--- a/drivers/gpio/gpio-104-dio-48e.c
+++ b/drivers/gpio/gpio-104-dio-48e.c
@@ -8,9 +8,9 @@
  */
 #include <linux/bits.h>
 #include <linux/device.h>
+#include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/gpio/driver.h>
-#include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/interrupt.h>
 #include <linux/irqdesc.h>
@@ -18,6 +18,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/regmap.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
 
@@ -38,30 +39,25 @@ static unsigned int num_irq;
 module_param_hw_array(irq, uint, irq, &num_irq, 0);
 MODULE_PARM_DESC(irq, "ACCES 104-DIO-48E interrupt line numbers");
 
+#define DIO48E_NAME "104-dio-48e"
+
+#define DIO48E_REGS_OFFSET 0x8
+#define DIO48E_ENABLE_BUFFER_GRP0 0x0
+#define DIO48E_ENABLE_BUFFER_GRP1 0x1
+#define DIO48E_ENABLE_INTERRUPT 0x3
+#define DIO48E_DISABLE_INTERRUPT 0x3
+#define DIO48E_ENABLE_COUNTER 0x5
+#define DIO48E_DISABLE_COUNTER 0x5
+#define DIO48E_CLEAR_INTERRUPT 0x7
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
@@ -70,6 +66,7 @@ struct dio48e_reg {
  * @ppi_state:		PPI device states
  * @lock:		synchronization lock to prevent I/O race conditions
  * @reg:		I/O address offset for the device registers
+ * @map:		device register map
  * @irq_mask:		I/O bits affected by interrupts
  */
 struct dio48e_gpio {
@@ -77,6 +74,7 @@ struct dio48e_gpio {
 	struct i8255_state ppi_state[DIO48E_NUM_PPI];
 	raw_spinlock_t lock;
 	struct dio48e_reg __iomem *reg;
+	struct regmap *map;
 	unsigned char irq_mask;
 };
 
@@ -154,6 +152,7 @@ static void dio48e_irq_mask(struct irq_data *data)
 	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
 	const unsigned long offset = irqd_to_hwirq(data);
 	unsigned long flags;
+	unsigned int val;
 
 	/* only bit 3 on each respective Port C supports interrupts */
 	if (offset != 19 && offset != 43)
@@ -168,8 +167,7 @@ static void dio48e_irq_mask(struct irq_data *data)
 	gpiochip_disable_irq(chip, offset);
 
 	if (!dio48egpio->irq_mask)
-		/* disable interrupts */
-		ioread8(&dio48egpio->reg->enable_interrupt);
+		regmap_read(dio48egpio->map, DIO48E_DISABLE_INTERRUPT, &val);
 
 	raw_spin_unlock_irqrestore(&dio48egpio->lock, flags);
 }
@@ -188,9 +186,8 @@ static void dio48e_irq_unmask(struct irq_data *data)
 	raw_spin_lock_irqsave(&dio48egpio->lock, flags);
 
 	if (!dio48egpio->irq_mask) {
-		/* enable interrupts */
-		iowrite8(0x00, &dio48egpio->reg->clear_interrupt);
-		iowrite8(0x00, &dio48egpio->reg->enable_interrupt);
+		regmap_write(dio48egpio->map, DIO48E_CLEAR_INTERRUPT, 0x00);
+		regmap_write(dio48egpio->map, DIO48E_ENABLE_INTERRUPT, 0x00);
 	}
 
 	gpiochip_enable_irq(chip, offset);
@@ -217,7 +214,7 @@ static int dio48e_irq_set_type(struct irq_data *data, unsigned int flow_type)
 }
 
 static const struct irq_chip dio48e_irqchip = {
-	.name = "104-dio-48e",
+	.name = DIO48E_NAME,
 	.irq_ack = dio48e_irq_ack,
 	.irq_mask = dio48e_irq_mask,
 	.irq_unmask = dio48e_irq_unmask,
@@ -239,7 +236,7 @@ static irqreturn_t dio48e_irq_handler(int irq, void *dev_id)
 
 	raw_spin_lock(&dio48egpio->lock);
 
-	iowrite8(0x00, &dio48egpio->reg->clear_interrupt);
+	regmap_write(dio48egpio->map, DIO48E_CLEAR_INTERRUPT, 0x00);
 
 	raw_spin_unlock(&dio48egpio->lock);
 
@@ -269,11 +266,9 @@ static const char *dio48e_names[DIO48E_NGPIO] = {
 static int dio48e_irq_init_hw(struct gpio_chip *gc)
 {
 	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(gc);
+	unsigned int val;
 
-	/* Disable IRQ by default */
-	ioread8(&dio48egpio->reg->enable_interrupt);
-
-	return 0;
+	return regmap_read(dio48egpio->map, DIO48E_DISABLE_INTERRUPT, &val);
 }
 
 static void dio48e_init_ppi(struct i8255 __iomem *const ppi,
@@ -291,10 +286,42 @@ static void dio48e_init_ppi(struct i8255 __iomem *const ppi,
 	}
 }
 
+static const struct regmap_range dio48e_wr_ranges[] = {
+	regmap_reg_range(0x0, 0x1),
+	regmap_reg_range(0x3, 0x3),
+	regmap_reg_range(0x5, 0x5),
+	regmap_reg_range(0x7, 0x7),
+};
+static const struct regmap_range dio48e_rd_ranges[] = {
+	regmap_reg_range(0x3, 0x3),
+	regmap_reg_range(0x5, 0x5),
+	regmap_reg_range(0x7, 0x7),
+};
+static const struct regmap_access_table dio48e_wr_table = {
+	.yes_ranges = dio48e_wr_ranges,
+	.n_yes_ranges = ARRAY_SIZE(dio48e_wr_ranges),
+};
+static const struct regmap_access_table dio48e_rd_table = {
+	.yes_ranges = dio48e_rd_ranges,
+	.n_yes_ranges = ARRAY_SIZE(dio48e_rd_ranges),
+};
+
+static const struct regmap_config dio48e_regmap_config = {
+	.name = DIO48E_NAME,
+	.reg_bits = 8,
+	.val_bits = 8,
+	.reg_stride = 1,
+	.io_port = true,
+	.max_register = 0x7,
+	.wr_table = &dio48e_wr_table,
+	.rd_table = &dio48e_rd_table,
+};
+
 static int dio48e_probe(struct device *dev, unsigned int id)
 {
 	struct dio48e_gpio *dio48egpio;
 	const char *const name = dev_name(dev);
+	void __iomem *regs;
 	struct gpio_irq_chip *girq;
 	int err;
 
@@ -308,9 +335,15 @@ static int dio48e_probe(struct device *dev, unsigned int id)
 		return -EBUSY;
 	}
 
-	dio48egpio->reg = devm_ioport_map(dev, base[id], DIO48E_EXTENT);
-	if (!dio48egpio->reg)
+	regs = devm_ioport_map(dev, base[id], DIO48E_EXTENT);
+	if (!regs)
 		return -ENOMEM;
+	dio48egpio->reg = regs;
+
+	dio48egpio->map = devm_regmap_init_mmio(dev, regs + DIO48E_REGS_OFFSET,
+						&dio48e_regmap_config);
+	if (IS_ERR(dio48egpio->map))
+		return PTR_ERR(dio48egpio->map);
 
 	dio48egpio->chip.label = name;
 	dio48egpio->chip.parent = dev;
@@ -360,7 +393,7 @@ static int dio48e_probe(struct device *dev, unsigned int id)
 static struct isa_driver dio48e_driver = {
 	.probe = dio48e_probe,
 	.driver = {
-		.name = "104-dio-48e"
+		.name = DIO48E_NAME,
 	},
 };
 module_isa_driver_with_irq(dio48e_driver, num_dio48e, num_irq);
-- 
2.37.3


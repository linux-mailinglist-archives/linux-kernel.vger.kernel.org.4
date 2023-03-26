Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D6A6C96D4
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 18:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbjCZQ0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 12:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbjCZQ0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 12:26:21 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0F749D5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 09:26:18 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-545ce8e77fcso50478287b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 09:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679847977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QME+i29c7TXie8xSDczxu04dQbhAgli3lDIjdb9WxEQ=;
        b=tSNDRjSeDcNAwiA+7QwhpIv4jS1WeXupPYVMotep2mvRI887dj6xh3k7cybo+QVjEm
         m2ndoExVUkemp8qa6jjFL9NNJDGdBKYfSef4PWmzZm66zi8g6F8Osge22siHKlRw/Btw
         xL+b0j/KdQDxO+SvZ+jnT1gkwg9h7pW8hsIgPYf1art38eG3Yip3nfG5I6dODMgJeiCR
         F3pA9q84ZqdHQW90zI3xIhGHvlYF2ammwWtKB7+gmeLvrziecEi0gc/v/ai9C0fwaLzb
         xCs34i40l5dDQbwtg4PgtWMa/xnXMMqXLHGgUYXZc6CJLG1qoXYWiB50VfJTG+cyER3p
         K9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679847977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QME+i29c7TXie8xSDczxu04dQbhAgli3lDIjdb9WxEQ=;
        b=CxdRzi2FN1dub6lStdJhnAkAROcWyn9QCdyFDzHCShzgyqhcCGxe2N5pZzPrBQ23D2
         3qCdQq2zR/gFvo3LX4uS+mmzOrB/MNduN/v5BGoxhQELnPfibS7uLItu3R8peO8/JjuS
         6dmwS+bTO7ifcFA61JbBB07KsiUL33ScF1BFlYpapP8raxSN6Dd5aEUbP5pVC2KaaCDu
         MDotJgDC1ROr98P+hkB3ssCNK7nfmntdT+BD2mCQJ1MHQbGxrL3aMLyNx2jA9z6tNyBm
         OBra1779gNfegAUuNM7rDi+T6Pg1nmxCcDyX0V0m4Klqi8Im7ln6qITYHz7DyF8brRWs
         GRNQ==
X-Gm-Message-State: AAQBX9dFHuZVPc5kj1GgJdF/+RuN6a9yNedtnG2i5KYL8lQzwraZ2Y1B
        r5TfjRaz/Mrf8S3CNu5aYB81Dw==
X-Google-Smtp-Source: AKy350asq64jcJrNXkTLXPUxp/UAOQk9vlcbTVMWARtguSa9iJDQzxUr4Ez09kyKBH1wbl49JqcYxA==
X-Received: by 2002:a81:6c58:0:b0:541:728b:edbb with SMTP id h85-20020a816c58000000b00541728bedbbmr8417706ywc.26.1679847977151;
        Sun, 26 Mar 2023 09:26:17 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id ci9-20020a05690c0a8900b00545a08184e9sm1543168ywb.121.2023.03.26.09.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 09:26:16 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        techsupport@winsystems.com,
        Paul Demetrotion <pdemetrotion@winsystems.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v5 3/3] gpio: ws16c48: Migrate to the regmap API
Date:   Sun, 26 Mar 2023 12:25:59 -0400
Message-Id: <58531b1b2428e4d5d2ea79e721f7ef6450665280.1679845842.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679845842.git.william.gray@linaro.org>
References: <cover.1679845842.git.william.gray@linaro.org>
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
directly in the driver.

The WinSystems WS16C48 provides the following registers:

    Offset 0x0-0x5: Port 0-5 I/O
    Offset 0x6: Int_Pending
    Offset 0x7: Page/Lock
    Offset 0x8-0xA (Page 1): Pol_0-Pol_2
    Offset 0x8-0xA (Page 2): Enab_0-Enab_2
    Offset 0x8-0xA (Page 3): Int_ID0-Int_ID2

Port 0-5 I/O provides access to 48 lines of digital I/O across six
registers, each bit position corresponding to the respective line.
Writing a 1 to a respective bit position causes that output pin to sink
current, while writing a 0 to the same bit position causes that output
pin to go to a high-impedance state and allows it to be used an input.
Reads on a port report the inverted state (0 = high, 1 = low) of an I/O
pin when used in input mode. Interrupts are supported on Port 0-2.

Int_Pending is a read-only register that reports the combined state of
the INT_ID0 through INT_ID2 registers; an interrupt pending is indicated
when any of the low three bits are set.

The Page/Lock register provides the following bits:

    Bit 0-5: Port 0-5 I/O Lock
    Bit 6-7: Page 0-3 Selection

For Bits 0-5, writing a 1 to a respective bit position locks the output
state of the corresponding I/O port. Writing the page number to Bits 6-7
selects that respective register page for use.

Pol_0-Pol_2 are accessible when Page 1 is selected. Writing a 1 to a
respective bit position selects the rising edge detection interrupts for
that input line, while writing a 0 to the same bit position selects the
falling edge detection interrupts.

Enab_0-Enab_2 are accessible when Page 2 is selected. Writing a 1 to a
respective bit position enables interrupts for that input line, while
writing a 0 to that same bit position clears and disables interrupts for
that input line.

Int_ID0-Int_ID2 are accessible when Page 3 is selected. A respective bit
when read as a 1 indicates that an edge of the polarity set in the
corresponding polarity register was detected for the corresponding input
line. Writing any value to this register clears all pending interrupts
for the register.

Cc: Paul Demetrotion <pdemetrotion@winsystems.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Michael Walle <michael@walle.cc>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
Changes in v5:
 - Refactor for map parameter removal from handle_mask_sync()
 - Cleanups and lines to 100 characters rather than 80
 - Rename PAGE_FIELD_PAGE_* defines to POL_PAGE, ENAB_PAGE, and
   INT_ID_PAGE
 - Adjust to change spinlock_t lock to raw_spin_lock
Changes in v4: none

 drivers/gpio/Kconfig        |   3 +
 drivers/gpio/gpio-ws16c48.c | 552 ++++++++++++------------------------
 2 files changed, 188 insertions(+), 367 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 79359f663b3d..2f6098034753 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -983,7 +983,10 @@ config GPIO_WINBOND
 config GPIO_WS16C48
 	tristate "WinSystems WS16C48 GPIO support"
 	select ISA_BUS_API
+	select REGMAP_IRQ
+	select REGMAP_MMIO
 	select GPIOLIB_IRQCHIP
+	select GPIO_REGMAP
 	help
 	  Enables GPIO support for the WinSystems WS16C48. The base port
 	  addresses for the devices may be configured via the base module
diff --git a/drivers/gpio/gpio-ws16c48.c b/drivers/gpio/gpio-ws16c48.c
index e73885a4dc32..dc11878f397e 100644
--- a/drivers/gpio/gpio-ws16c48.c
+++ b/drivers/gpio/gpio-ws16c48.c
@@ -3,19 +3,18 @@
  * GPIO driver for the WinSystems WS16C48
  * Copyright (C) 2016 William Breathitt Gray
  */
-#include <linux/bitmap.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
 #include <linux/device.h>
-#include <linux/errno.h>
-#include <linux/gpio/driver.h>
-#include <linux/io.h>
-#include <linux/ioport.h>
-#include <linux/interrupt.h>
-#include <linux/irqdesc.h>
+#include <linux/err.h>
+#include <linux/gpio/regmap.h>
+#include <linux/irq.h>
 #include <linux/isa.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/spinlock.h>
+#include <linux/regmap.h>
 #include <linux/types.h>
 
 #define WS16C48_EXTENT 10
@@ -31,371 +30,178 @@ static unsigned int num_irq;
 module_param_hw_array(irq, uint, irq, &num_irq, 0);
 MODULE_PARM_DESC(irq, "WinSystems WS16C48 interrupt line numbers");
 
-/**
- * struct ws16c48_reg - device register structure
- * @port:		Port 0 through 5 I/O
- * @int_pending:	Interrupt Pending
- * @page_lock:		Register page (Bits 7-6) and I/O port lock (Bits 5-0)
- * @pol_enab_int_id:	Interrupt polarity, enable, and ID
- */
-struct ws16c48_reg {
-	u8 port[6];
-	u8 int_pending;
-	u8 page_lock;
-	u8 pol_enab_int_id[3];
+#define WS16C48_DAT_BASE 0x0
+#define WS16C48_PAGE_LOCK 0x7
+#define WS16C48_PAGE_BASE 0x8
+#define WS16C48_POL WS16C48_PAGE_BASE
+#define WS16C48_ENAB WS16C48_PAGE_BASE
+#define WS16C48_INT_ID WS16C48_PAGE_BASE
+
+#define PAGE_LOCK_PAGE_FIELD GENMASK(7, 6)
+#define POL_PAGE u8_encode_bits(1, PAGE_LOCK_PAGE_FIELD)
+#define ENAB_PAGE u8_encode_bits(2, PAGE_LOCK_PAGE_FIELD)
+#define INT_ID_PAGE u8_encode_bits(3, PAGE_LOCK_PAGE_FIELD)
+
+static const struct regmap_range ws16c48_wr_ranges[] = {
+	regmap_reg_range(0x0, 0x5), regmap_reg_range(0x7, 0xA),
+};
+static const struct regmap_range ws16c48_rd_ranges[] = {
+	regmap_reg_range(0x0, 0xA),
+};
+static const struct regmap_range ws16c48_volatile_ranges[] = {
+	regmap_reg_range(0x0, 0x6), regmap_reg_range(0x8, 0xA),
+};
+static const struct regmap_access_table ws16c48_wr_table = {
+	.yes_ranges = ws16c48_wr_ranges,
+	.n_yes_ranges = ARRAY_SIZE(ws16c48_wr_ranges),
+};
+static const struct regmap_access_table ws16c48_rd_table = {
+	.yes_ranges = ws16c48_rd_ranges,
+	.n_yes_ranges = ARRAY_SIZE(ws16c48_rd_ranges),
+};
+static const struct regmap_access_table ws16c48_volatile_table = {
+	.yes_ranges = ws16c48_volatile_ranges,
+	.n_yes_ranges = ARRAY_SIZE(ws16c48_volatile_ranges),
+};
+static const struct regmap_config ws16c48_regmap_config = {
+	.reg_bits = 8,
+	.reg_stride = 1,
+	.val_bits = 8,
+	.io_port = true,
+	.max_register = 0xA,
+	.wr_table = &ws16c48_wr_table,
+	.rd_table = &ws16c48_rd_table,
+	.volatile_table = &ws16c48_volatile_table,
+	.cache_type = REGCACHE_FLAT,
+};
+
+#define WS16C48_NGPIO_PER_REG 8
+#define WS16C48_REGMAP_IRQ(_id)							\
+	[_id] = {								\
+		.reg_offset = (_id) / WS16C48_NGPIO_PER_REG,			\
+		.mask = BIT((_id) % WS16C48_NGPIO_PER_REG),			\
+		.type = {							\
+			.type_reg_offset = (_id) / WS16C48_NGPIO_PER_REG,	\
+			.types_supported = IRQ_TYPE_EDGE_BOTH,			\
+		},								\
+	}
+
+/* Only the first 24 lines (Port 0-2) support interrupts */
+#define WS16C48_NUM_IRQS 24
+static const struct regmap_irq ws16c48_regmap_irqs[WS16C48_NUM_IRQS] = {
+	WS16C48_REGMAP_IRQ(0), WS16C48_REGMAP_IRQ(1), WS16C48_REGMAP_IRQ(2), /* 0-2 */
+	WS16C48_REGMAP_IRQ(3), WS16C48_REGMAP_IRQ(4), WS16C48_REGMAP_IRQ(5), /* 3-5 */
+	WS16C48_REGMAP_IRQ(6), WS16C48_REGMAP_IRQ(7), WS16C48_REGMAP_IRQ(8), /* 6-8 */
+	WS16C48_REGMAP_IRQ(9), WS16C48_REGMAP_IRQ(10), WS16C48_REGMAP_IRQ(11), /* 9-11 */
+	WS16C48_REGMAP_IRQ(12), WS16C48_REGMAP_IRQ(13), WS16C48_REGMAP_IRQ(14), /* 12-14 */
+	WS16C48_REGMAP_IRQ(15), WS16C48_REGMAP_IRQ(16), WS16C48_REGMAP_IRQ(17), /* 15-17 */
+	WS16C48_REGMAP_IRQ(18), WS16C48_REGMAP_IRQ(19), WS16C48_REGMAP_IRQ(20), /* 18-20 */
+	WS16C48_REGMAP_IRQ(21), WS16C48_REGMAP_IRQ(22), WS16C48_REGMAP_IRQ(23), /* 21-23 */
 };
 
 /**
  * struct ws16c48_gpio - GPIO device private data structure
- * @chip:	instance of the gpio_chip
- * @io_state:	bit I/O state (whether bit is set to input or output)
- * @out_state:	output bits state
+ * @map:	regmap for the device
  * @lock:	synchronization lock to prevent I/O race conditions
  * @irq_mask:	I/O bits affected by interrupts
- * @flow_mask:	IRQ flow type mask for the respective I/O bits
- * @reg:	I/O address offset for the device registers
  */
 struct ws16c48_gpio {
-	struct gpio_chip chip;
-	unsigned char io_state[6];
-	unsigned char out_state[6];
+	struct regmap *map;
 	raw_spinlock_t lock;
-	unsigned long irq_mask;
-	unsigned long flow_mask;
-	struct ws16c48_reg __iomem *reg;
+	u8 irq_mask[WS16C48_NUM_IRQS / WS16C48_NGPIO_PER_REG];
 };
 
-static int ws16c48_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
+static int ws16c48_handle_pre_irq(void *const irq_drv_data)
 {
-	struct ws16c48_gpio *const ws16c48gpio = gpiochip_get_data(chip);
-	const unsigned port = offset / 8;
-	const unsigned mask = BIT(offset % 8);
+	struct ws16c48_gpio *const ws16c48gpio = irq_drv_data;
 
-	if (ws16c48gpio->io_state[port] & mask)
-		return GPIO_LINE_DIRECTION_IN;
-
-	return GPIO_LINE_DIRECTION_OUT;
-}
-
-static int ws16c48_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
-{
-	struct ws16c48_gpio *const ws16c48gpio = gpiochip_get_data(chip);
-	const unsigned port = offset / 8;
-	const unsigned mask = BIT(offset % 8);
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&ws16c48gpio->lock, flags);
-
-	ws16c48gpio->io_state[port] |= mask;
-	ws16c48gpio->out_state[port] &= ~mask;
-	iowrite8(ws16c48gpio->out_state[port], ws16c48gpio->reg->port + port);
-
-	raw_spin_unlock_irqrestore(&ws16c48gpio->lock, flags);
+	/* Lock to prevent Page/Lock register change while we handle IRQ */
+	raw_spin_lock(&ws16c48gpio->lock);
 
 	return 0;
 }
 
-static int ws16c48_gpio_direction_output(struct gpio_chip *chip,
-	unsigned offset, int value)
+static int ws16c48_handle_post_irq(void *const irq_drv_data)
 {
-	struct ws16c48_gpio *const ws16c48gpio = gpiochip_get_data(chip);
-	const unsigned port = offset / 8;
-	const unsigned mask = BIT(offset % 8);
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&ws16c48gpio->lock, flags);
+	struct ws16c48_gpio *const ws16c48gpio = irq_drv_data;
 
-	ws16c48gpio->io_state[port] &= ~mask;
-	if (value)
-		ws16c48gpio->out_state[port] |= mask;
-	else
-		ws16c48gpio->out_state[port] &= ~mask;
-	iowrite8(ws16c48gpio->out_state[port], ws16c48gpio->reg->port + port);
-
-	raw_spin_unlock_irqrestore(&ws16c48gpio->lock, flags);
+	raw_spin_unlock(&ws16c48gpio->lock);
 
 	return 0;
 }
 
-static int ws16c48_gpio_get(struct gpio_chip *chip, unsigned offset)
-{
-	struct ws16c48_gpio *const ws16c48gpio = gpiochip_get_data(chip);
-	const unsigned port = offset / 8;
-	const unsigned mask = BIT(offset % 8);
-	unsigned long flags;
-	unsigned port_state;
-
-	raw_spin_lock_irqsave(&ws16c48gpio->lock, flags);
-
-	/* ensure that GPIO is set for input */
-	if (!(ws16c48gpio->io_state[port] & mask)) {
-		raw_spin_unlock_irqrestore(&ws16c48gpio->lock, flags);
-		return -EINVAL;
-	}
-
-	port_state = ioread8(ws16c48gpio->reg->port + port);
-
-	raw_spin_unlock_irqrestore(&ws16c48gpio->lock, flags);
-
-	return !!(port_state & mask);
-}
-
-static int ws16c48_gpio_get_multiple(struct gpio_chip *chip,
-	unsigned long *mask, unsigned long *bits)
-{
-	struct ws16c48_gpio *const ws16c48gpio = gpiochip_get_data(chip);
-	unsigned long offset;
-	unsigned long gpio_mask;
-	size_t index;
-	u8 __iomem *port_addr;
-	unsigned long port_state;
-
-	/* clear bits array to a clean slate */
-	bitmap_zero(bits, chip->ngpio);
-
-	for_each_set_clump8(offset, gpio_mask, mask, chip->ngpio) {
-		index = offset / 8;
-		port_addr = ws16c48gpio->reg->port + index;
-		port_state = ioread8(port_addr) & gpio_mask;
-
-		bitmap_set_value8(bits, port_state, offset);
-	}
-
-	return 0;
-}
-
-static void ws16c48_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
-{
-	struct ws16c48_gpio *const ws16c48gpio = gpiochip_get_data(chip);
-	const unsigned port = offset / 8;
-	const unsigned mask = BIT(offset % 8);
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&ws16c48gpio->lock, flags);
-
-	/* ensure that GPIO is set for output */
-	if (ws16c48gpio->io_state[port] & mask) {
-		raw_spin_unlock_irqrestore(&ws16c48gpio->lock, flags);
-		return;
-	}
-
-	if (value)
-		ws16c48gpio->out_state[port] |= mask;
-	else
-		ws16c48gpio->out_state[port] &= ~mask;
-	iowrite8(ws16c48gpio->out_state[port], ws16c48gpio->reg->port + port);
-
-	raw_spin_unlock_irqrestore(&ws16c48gpio->lock, flags);
-}
-
-static void ws16c48_gpio_set_multiple(struct gpio_chip *chip,
-	unsigned long *mask, unsigned long *bits)
-{
-	struct ws16c48_gpio *const ws16c48gpio = gpiochip_get_data(chip);
-	unsigned long offset;
-	unsigned long gpio_mask;
-	size_t index;
-	u8 __iomem *port_addr;
-	unsigned long bitmask;
-	unsigned long flags;
-
-	for_each_set_clump8(offset, gpio_mask, mask, chip->ngpio) {
-		index = offset / 8;
-		port_addr = ws16c48gpio->reg->port + index;
-
-		/* mask out GPIO configured for input */
-		gpio_mask &= ~ws16c48gpio->io_state[index];
-		bitmask = bitmap_get_value8(bits, offset) & gpio_mask;
-
-		raw_spin_lock_irqsave(&ws16c48gpio->lock, flags);
-
-		/* update output state data and set device gpio register */
-		ws16c48gpio->out_state[index] &= ~gpio_mask;
-		ws16c48gpio->out_state[index] |= bitmask;
-		iowrite8(ws16c48gpio->out_state[index], port_addr);
-
-		raw_spin_unlock_irqrestore(&ws16c48gpio->lock, flags);
-	}
-}
-
-static void ws16c48_irq_ack(struct irq_data *data)
+static int ws16c48_handle_mask_sync(const int index, const unsigned int mask_buf_def,
+				    const unsigned int mask_buf, void *const irq_drv_data)
 {
-	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
-	struct ws16c48_gpio *const ws16c48gpio = gpiochip_get_data(chip);
-	const unsigned long offset = irqd_to_hwirq(data);
-	const unsigned port = offset / 8;
-	const unsigned mask = BIT(offset % 8);
+	struct ws16c48_gpio *const ws16c48gpio = irq_drv_data;
 	unsigned long flags;
-	unsigned port_state;
-
-	/* only the first 3 ports support interrupts */
-	if (port > 2)
-		return;
+	int ret = 0;
 
 	raw_spin_lock_irqsave(&ws16c48gpio->lock, flags);
 
-	port_state = ws16c48gpio->irq_mask >> (8*port);
+	/* exit early if no change since the last mask sync */
+	if (mask_buf == ws16c48gpio->irq_mask[index])
+		goto exit_early;
+	ws16c48gpio->irq_mask[index] = mask_buf;
 
-	/* Select Register Page 2; Unlock all I/O ports */
-	iowrite8(0x80, &ws16c48gpio->reg->page_lock);
+	ret = regmap_write(ws16c48gpio->map, WS16C48_PAGE_LOCK, ENAB_PAGE);
+	if (ret)
+		goto exit_early;
 
-	/* Clear pending interrupt */
-	iowrite8(port_state & ~mask, ws16c48gpio->reg->pol_enab_int_id + port);
-	iowrite8(port_state | mask, ws16c48gpio->reg->pol_enab_int_id + port);
+	/* Update ENAB register (inverted mask) */
+	ret = regmap_write(ws16c48gpio->map, WS16C48_ENAB + index, ~mask_buf);
+	if (ret)
+		goto exit_early;
 
-	/* Select Register Page 3; Unlock all I/O ports */
-	iowrite8(0xC0, &ws16c48gpio->reg->page_lock);
+	ret = regmap_write(ws16c48gpio->map, WS16C48_PAGE_LOCK, INT_ID_PAGE);
+	if (ret)
+		goto exit_early;
 
+exit_early:
 	raw_spin_unlock_irqrestore(&ws16c48gpio->lock, flags);
-}
-
-static void ws16c48_irq_mask(struct irq_data *data)
-{
-	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
-	struct ws16c48_gpio *const ws16c48gpio = gpiochip_get_data(chip);
-	const unsigned long offset = irqd_to_hwirq(data);
-	const unsigned long mask = BIT(offset);
-	const unsigned port = offset / 8;
-	unsigned long flags;
-	unsigned long port_state;
-
-	/* only the first 3 ports support interrupts */
-	if (port > 2)
-		return;
-
-	raw_spin_lock_irqsave(&ws16c48gpio->lock, flags);
 
-	ws16c48gpio->irq_mask &= ~mask;
-	gpiochip_disable_irq(chip, offset);
-	port_state = ws16c48gpio->irq_mask >> (8 * port);
-
-	/* Select Register Page 2; Unlock all I/O ports */
-	iowrite8(0x80, &ws16c48gpio->reg->page_lock);
-
-	/* Disable interrupt */
-	iowrite8(port_state, ws16c48gpio->reg->pol_enab_int_id + port);
-
-	/* Select Register Page 3; Unlock all I/O ports */
-	iowrite8(0xC0, &ws16c48gpio->reg->page_lock);
-
-	raw_spin_unlock_irqrestore(&ws16c48gpio->lock, flags);
+	return ret;
 }
 
-static void ws16c48_irq_unmask(struct irq_data *data)
+static int ws16c48_set_type_config(unsigned int **const buf, const unsigned int type,
+				   const struct regmap_irq *const irq_data, const int idx,
+				   void *const irq_drv_data)
 {
-	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
-	struct ws16c48_gpio *const ws16c48gpio = gpiochip_get_data(chip);
-	const unsigned long offset = irqd_to_hwirq(data);
-	const unsigned long mask = BIT(offset);
-	const unsigned port = offset / 8;
+	struct ws16c48_gpio *const ws16c48gpio = irq_drv_data;
+	unsigned int polarity;
 	unsigned long flags;
-	unsigned long port_state;
-
-	/* only the first 3 ports support interrupts */
-	if (port > 2)
-		return;
-
-	raw_spin_lock_irqsave(&ws16c48gpio->lock, flags);
-
-	gpiochip_enable_irq(chip, offset);
-	ws16c48gpio->irq_mask |= mask;
-	port_state = ws16c48gpio->irq_mask >> (8 * port);
-
-	/* Select Register Page 2; Unlock all I/O ports */
-	iowrite8(0x80, &ws16c48gpio->reg->page_lock);
-
-	/* Enable interrupt */
-	iowrite8(port_state, ws16c48gpio->reg->pol_enab_int_id + port);
-
-	/* Select Register Page 3; Unlock all I/O ports */
-	iowrite8(0xC0, &ws16c48gpio->reg->page_lock);
-
-	raw_spin_unlock_irqrestore(&ws16c48gpio->lock, flags);
-}
+	int ret;
 
-static int ws16c48_irq_set_type(struct irq_data *data, unsigned flow_type)
-{
-	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
-	struct ws16c48_gpio *const ws16c48gpio = gpiochip_get_data(chip);
-	const unsigned long offset = irqd_to_hwirq(data);
-	const unsigned long mask = BIT(offset);
-	const unsigned port = offset / 8;
-	unsigned long flags;
-	unsigned long port_state;
-
-	/* only the first 3 ports support interrupts */
-	if (port > 2)
-		return -EINVAL;
-
-	raw_spin_lock_irqsave(&ws16c48gpio->lock, flags);
-
-	switch (flow_type) {
-	case IRQ_TYPE_NONE:
-		break;
+	switch (type) {
 	case IRQ_TYPE_EDGE_RISING:
-		ws16c48gpio->flow_mask |= mask;
+		polarity = irq_data->mask;
 		break;
 	case IRQ_TYPE_EDGE_FALLING:
-		ws16c48gpio->flow_mask &= ~mask;
+		polarity = 0;
 		break;
 	default:
-		raw_spin_unlock_irqrestore(&ws16c48gpio->lock, flags);
 		return -EINVAL;
 	}
 
-	port_state = ws16c48gpio->flow_mask >> (8 * port);
+	raw_spin_lock_irqsave(&ws16c48gpio->lock, flags);
 
-	/* Select Register Page 1; Unlock all I/O ports */
-	iowrite8(0x40, &ws16c48gpio->reg->page_lock);
+	ret = regmap_write(ws16c48gpio->map, WS16C48_PAGE_LOCK, POL_PAGE);
+	if (ret)
+		goto exit_early;
 
 	/* Set interrupt polarity */
-	iowrite8(port_state, ws16c48gpio->reg->pol_enab_int_id + port);
+	ret = regmap_update_bits(ws16c48gpio->map, WS16C48_POL + idx, irq_data->mask, polarity);
+	if (ret)
+		goto exit_early;
 
-	/* Select Register Page 3; Unlock all I/O ports */
-	iowrite8(0xC0, &ws16c48gpio->reg->page_lock);
+	ret = regmap_write(ws16c48gpio->map, WS16C48_PAGE_LOCK, INT_ID_PAGE);
+	if (ret)
+		goto exit_early;
 
+exit_early:
 	raw_spin_unlock_irqrestore(&ws16c48gpio->lock, flags);
 
-	return 0;
-}
-
-static const struct irq_chip ws16c48_irqchip = {
-	.name = "ws16c48",
-	.irq_ack = ws16c48_irq_ack,
-	.irq_mask = ws16c48_irq_mask,
-	.irq_unmask = ws16c48_irq_unmask,
-	.irq_set_type = ws16c48_irq_set_type,
-	.flags = IRQCHIP_IMMUTABLE,
-	GPIOCHIP_IRQ_RESOURCE_HELPERS,
-};
-
-static irqreturn_t ws16c48_irq_handler(int irq, void *dev_id)
-{
-	struct ws16c48_gpio *const ws16c48gpio = dev_id;
-	struct gpio_chip *const chip = &ws16c48gpio->chip;
-	struct ws16c48_reg __iomem *const reg = ws16c48gpio->reg;
-	unsigned long int_pending;
-	unsigned long port;
-	unsigned long int_id;
-	unsigned long gpio;
-
-	int_pending = ioread8(&reg->int_pending) & 0x7;
-	if (!int_pending)
-		return IRQ_NONE;
-
-	/* loop until all pending interrupts are handled */
-	do {
-		for_each_set_bit(port, &int_pending, 3) {
-			int_id = ioread8(reg->pol_enab_int_id + port);
-			for_each_set_bit(gpio, &int_id, 8)
-				generic_handle_domain_irq(chip->irq.domain,
-							  gpio + 8*port);
-		}
-
-		int_pending = ioread8(&reg->int_pending) & 0x7;
-	} while (int_pending);
-
-	return IRQ_HANDLED;
+	return ret;
 }
 
 #define WS16C48_NGPIO 48
@@ -414,30 +220,37 @@ static const char *ws16c48_names[WS16C48_NGPIO] = {
 	"Port 5 Bit 4", "Port 5 Bit 5", "Port 5 Bit 6", "Port 5 Bit 7"
 };
 
-static int ws16c48_irq_init_hw(struct gpio_chip *gc)
+static int ws16c48_irq_init_hw(struct regmap *const map)
 {
-	struct ws16c48_gpio *const ws16c48gpio = gpiochip_get_data(gc);
+	int err;
 
-	/* Select Register Page 2; Unlock all I/O ports */
-	iowrite8(0x80, &ws16c48gpio->reg->page_lock);
+	err = regmap_write(map, WS16C48_PAGE_LOCK, ENAB_PAGE);
+	if (err)
+		return err;
 
 	/* Disable interrupts for all lines */
-	iowrite8(0, &ws16c48gpio->reg->pol_enab_int_id[0]);
-	iowrite8(0, &ws16c48gpio->reg->pol_enab_int_id[1]);
-	iowrite8(0, &ws16c48gpio->reg->pol_enab_int_id[2]);
-
-	/* Select Register Page 3; Unlock all I/O ports */
-	iowrite8(0xC0, &ws16c48gpio->reg->page_lock);
+	err = regmap_write(map, WS16C48_ENAB, 0x00);
+	if (err)
+		return err;
+	err = regmap_write(map, WS16C48_ENAB + 1, 0x00);
+	if (err)
+		return err;
+	err = regmap_write(map, WS16C48_ENAB + 2, 0x00);
+	if (err)
+		return err;
 
-	return 0;
+	return regmap_write(map, WS16C48_PAGE_LOCK, INT_ID_PAGE);
 }
 
 static int ws16c48_probe(struct device *dev, unsigned int id)
 {
 	struct ws16c48_gpio *ws16c48gpio;
 	const char *const name = dev_name(dev);
-	struct gpio_irq_chip *girq;
 	int err;
+	struct gpio_regmap_config gpio_config = {};
+	void __iomem *regs;
+	struct regmap_irq_chip *chip;
+	struct regmap_irq_chip_data *chip_data;
 
 	ws16c48gpio = devm_kzalloc(dev, sizeof(*ws16c48gpio), GFP_KERNEL);
 	if (!ws16c48gpio)
@@ -449,50 +262,55 @@ static int ws16c48_probe(struct device *dev, unsigned int id)
 		return -EBUSY;
 	}
 
-	ws16c48gpio->reg = devm_ioport_map(dev, base[id], WS16C48_EXTENT);
-	if (!ws16c48gpio->reg)
+	regs = devm_ioport_map(dev, base[id], WS16C48_EXTENT);
+	if (!regs)
 		return -ENOMEM;
 
-	ws16c48gpio->chip.label = name;
-	ws16c48gpio->chip.parent = dev;
-	ws16c48gpio->chip.owner = THIS_MODULE;
-	ws16c48gpio->chip.base = -1;
-	ws16c48gpio->chip.ngpio = WS16C48_NGPIO;
-	ws16c48gpio->chip.names = ws16c48_names;
-	ws16c48gpio->chip.get_direction = ws16c48_gpio_get_direction;
-	ws16c48gpio->chip.direction_input = ws16c48_gpio_direction_input;
-	ws16c48gpio->chip.direction_output = ws16c48_gpio_direction_output;
-	ws16c48gpio->chip.get = ws16c48_gpio_get;
-	ws16c48gpio->chip.get_multiple = ws16c48_gpio_get_multiple;
-	ws16c48gpio->chip.set = ws16c48_gpio_set;
-	ws16c48gpio->chip.set_multiple = ws16c48_gpio_set_multiple;
-
-	girq = &ws16c48gpio->chip.irq;
-	gpio_irq_chip_set_chip(girq, &ws16c48_irqchip);
-	/* This will let us handle the parent IRQ in the driver */
-	girq->parent_handler = NULL;
-	girq->num_parents = 0;
-	girq->parents = NULL;
-	girq->default_type = IRQ_TYPE_NONE;
-	girq->handler = handle_edge_irq;
-	girq->init_hw = ws16c48_irq_init_hw;
+	ws16c48gpio->map = devm_regmap_init_mmio(dev, regs, &ws16c48_regmap_config);
+	if (IS_ERR(ws16c48gpio->map))
+		return dev_err_probe(dev, PTR_ERR(ws16c48gpio->map),
+				     "Unable to initialize register map\n");
 
-	raw_spin_lock_init(&ws16c48gpio->lock);
+	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
 
-	err = devm_gpiochip_add_data(dev, &ws16c48gpio->chip, ws16c48gpio);
-	if (err) {
-		dev_err(dev, "GPIO registering failed (%d)\n", err);
-		return err;
-	}
+	chip->name = name;
+	chip->status_base = WS16C48_INT_ID;
+	chip->mask_base = WS16C48_ENAB;
+	chip->ack_base = WS16C48_INT_ID;
+	chip->num_regs = 3;
+	chip->irqs = ws16c48_regmap_irqs;
+	chip->num_irqs = ARRAY_SIZE(ws16c48_regmap_irqs);
+	chip->handle_pre_irq = ws16c48_handle_pre_irq;
+	chip->handle_post_irq = ws16c48_handle_post_irq;
+	chip->handle_mask_sync = ws16c48_handle_mask_sync;
+	chip->set_type_config = ws16c48_set_type_config;
+	chip->irq_drv_data = ws16c48gpio;
 
-	err = devm_request_irq(dev, irq[id], ws16c48_irq_handler, IRQF_SHARED,
-		name, ws16c48gpio);
-	if (err) {
-		dev_err(dev, "IRQ handler registering failed (%d)\n", err);
+	raw_spin_lock_init(&ws16c48gpio->lock);
+
+	/* Initialize to prevent spurious interrupts before we're ready */
+	err = ws16c48_irq_init_hw(ws16c48gpio->map);
+	if (err)
 		return err;
-	}
 
-	return 0;
+	err = devm_regmap_add_irq_chip(dev, ws16c48gpio->map, irq[id], 0, 0, chip, &chip_data);
+	if (err)
+		return dev_err_probe(dev, err, "IRQ registration failed\n");
+
+	gpio_config.parent = dev;
+	gpio_config.regmap = ws16c48gpio->map;
+	gpio_config.ngpio = WS16C48_NGPIO;
+	gpio_config.names = ws16c48_names;
+	gpio_config.reg_dat_base = GPIO_REGMAP_ADDR(WS16C48_DAT_BASE);
+	gpio_config.reg_set_base = GPIO_REGMAP_ADDR(WS16C48_DAT_BASE);
+	/* Setting a GPIO to 0 allows it to be used as an input */
+	gpio_config.reg_dir_out_base = GPIO_REGMAP_ADDR(WS16C48_DAT_BASE);
+	gpio_config.ngpio_per_reg = WS16C48_NGPIO_PER_REG;
+	gpio_config.irq_domain = regmap_irq_get_domain(chip_data);
+
+	return PTR_ERR_OR_ZERO(devm_gpio_regmap_register(dev, &gpio_config));
 }
 
 static struct isa_driver ws16c48_driver = {
-- 
2.39.2


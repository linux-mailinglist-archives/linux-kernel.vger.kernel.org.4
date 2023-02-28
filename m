Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1950B6A5F20
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 19:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjB1S7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 13:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjB1S7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 13:59:41 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E352CC55
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 10:59:37 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id c3so7435554qtc.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 10:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677610776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nV5M3uPVxozCgxj+eg1dCSs4VNsJDcnF1UpVidjbi1U=;
        b=Udutf5Th8zcEUuxdNP0dhfzJDxpNIyvwh411MWVNZWB4YKsG6uJ0PywRVrn/so7ni5
         7jm/ok4k5eb4j98ScPcNzAvPVUgnwuEE6JzHbQQfQqiacVAIMKeZE7Uff1s4TZpnIR+U
         B2l12vRmHpKX8ztfFd/vxFPMTPnz8QLcS9jS9ncmJK83c2RmJH8B5jiv9Y4O+hFtzqym
         ilXyxs+DrcKx673fUEtrVQYgfOzeDP0ghLgm382pN66jHt/8BQVK2n0jtVus66UKIJx5
         HDD17MuZLc8+8Ok61Wyf3bc1VDs2ok83ZxVsAHWddJbwDMSexIKES6Cd1W86hGmLlfXM
         nb5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677610776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nV5M3uPVxozCgxj+eg1dCSs4VNsJDcnF1UpVidjbi1U=;
        b=kas10gtTJ7xNlVPk/IGCr0V7lgm2QAbfXkQSYkwOROCtVWby2wACbg9GuPA/ESN37l
         7NRkoHs1VwEz2vhPjg8X1i/Ko1w8otWBgOe8PaFdO/53i3QeUvUBdGf9ULh9UtGyx9cL
         eBfwmHqTgdhmjPt46WhiZk+rDUYt6pkbrtRtvz8QHoCW64pDg+CaPYmaf6Ufk4RJXZwJ
         MuP5tQU6xthQZDayUDqKlHSVrXLuYKnFRbRyeF2/z8AYoDh3kP0cq73JRXoYw0qo7LyQ
         0LNOWBBgdeUk3WmUHavN6UiIraaHFkwDQywHLF6W8YQPplrEiW2r2AwSxITiNSc8foHf
         rHIw==
X-Gm-Message-State: AO0yUKVRrIqyCn6yopZuyIA8/J3yYjF4dNxUGrndCJKVs8ybScXCjb6p
        5FYUfn2hI+w4widIFgOyFR3OPw==
X-Google-Smtp-Source: AK7set82RyXX174TyiU6ds8HV29B4p1kb6Dvd6+g674kR4A9gYN0mEHiAyk/LOjMXqAUXo8jWRtXbw==
X-Received: by 2002:a05:622a:448:b0:3bf:a3fc:c70a with SMTP id o8-20020a05622a044800b003bfa3fcc70amr6693699qtx.28.1677610776324;
        Tue, 28 Feb 2023 10:59:36 -0800 (PST)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id e22-20020ac84b56000000b003b646123691sm6905181qts.31.2023.02.28.10.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 10:59:35 -0800 (PST)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     broonie@kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael@walle.cc, quarium@gmail.com,
        jhentges@accesio.com, jay.dolan@accesio.com,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH 3/3] gpio: pcie-idio-24: Migrate to the regmap API
Date:   Mon, 27 Feb 2023 20:53:42 -0500
Message-Id: <39f4c4b7083b2a50973e0ac5b4b1db5040fcda53.1677547393.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1677547393.git.william.gray@linaro.org>
References: <cover.1677547393.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regmap API supports IO port accessors so we can take advantage of
regmap abstractions rather than handling access to the device registers
directly in the driver.

For the PCIe-IDIO-24 series of devices, the following BARs are
available:

    BAR[0]: memory mapped PEX8311
    BAR[1]: I/O mapped PEX8311
    BAR[2]: I/O mapped card registers

There are 24 FET Output lines, 24 Isolated Input lines, and 8 TTL/CMOS
lines (which may be configured for either output or input). The GPIO
lines are exposed by the following card registers:

    Base +0x0-0x2 (Read/Write): FET Outputs
    Base +0xB (Read/Write): TTL/CMOS
    Base +0x4-0x6 (Read): Isolated Inputs
    Base +0x7 (Read): TTL/CMOS

In order for the device to support interrupts, the PLX PEX8311 internal
PCI wire interrupt and local interrupt input must first be enabled.

The following card registers for Change-Of-State may be used:

    Base +0x8-0xA (Read): COS Status Inputs
    Base +0x8-0xA (Write): COS Clear Inputs
    Base +0xB (Read): COS Status TTL/CMOS
    Base +0xB (Write): COS Clear TTL/CMOS
    Base +0xE (Read/Write): COS Enable

The COS Enable register is used to enable/disable interrupts and
configure the interrupt levels; each bit maps to a group of eight inputs
as described below:

    Bit 0: IRQ EN Rising Edge IN0-7
    Bit 1: IRQ EN Rising Edge IN8-15
    Bit 2: IRQ EN Rising Edge IN16-23
    Bit 3: IRQ EN Rising Edge TTL0-7
    Bit 4: IRQ EN Falling Edge IN0-7
    Bit 5: IRQ EN Falling Edge IN8-15
    Bit 6: IRQ EN Falling Edge IN16-23
    Bit 7: IRQ EN Falling Edge TTL0-7

An interrupt is asserted when a change-of-state matching the interrupt
level configuration respective for a particular group of eight inputs
with enabled COS is detected.

The COS Status registers may be read to determine which inputs have
changed; if interrupts were enabled, an IRQ will be generated for the
set bits in these registers. Writing the value read from the COS Status
register back to the respective COS Clear register will clear just those
interrupts.

Cc: Arnaud de Turckheim <quarium@gmail.com>
Cc: John Hentges <jhentges@accesio.com>
Cc: Jay Dolan <jay.dolan@accesio.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/gpio/Kconfig             |   3 +
 drivers/gpio/gpio-pcie-idio-24.c | 697 ++++++++++++-------------------
 2 files changed, 264 insertions(+), 436 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 406e8bda487f..06c7a96e6033 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1578,7 +1578,10 @@ config GPIO_PCI_IDIO_16
 
 config GPIO_PCIE_IDIO_24
 	tristate "ACCES PCIe-IDIO-24 GPIO support"
+	select REGMAP_IRQ
+	select REGMAP_MMIO
 	select GPIOLIB_IRQCHIP
+	select GPIO_REGMAP
 	help
 	  Enables GPIO support for the ACCES PCIe-IDIO-24 family (PCIe-IDIO-24,
 	  PCIe-IDI-24, PCIe-IDO-24, PCIe-IDIO-12). An interrupt is generated
diff --git a/drivers/gpio/gpio-pcie-idio-24.c b/drivers/gpio/gpio-pcie-idio-24.c
index 8a9b98fa418f..b643ad3ab6f6 100644
--- a/drivers/gpio/gpio-pcie-idio-24.c
+++ b/drivers/gpio/gpio-pcie-idio-24.c
@@ -15,17 +15,15 @@
  * This driver supports the following ACCES devices: PCIe-IDIO-24,
  * PCIe-IDI-24, PCIe-IDO-24, and PCIe-IDIO-12.
  */
-#include <linux/bitmap.h>
-#include <linux/bitops.h>
+#include <linux/bits.h>
 #include <linux/device.h>
-#include <linux/errno.h>
-#include <linux/gpio/driver.h>
-#include <linux/interrupt.h>
-#include <linux/irqdesc.h>
+#include <linux/err.h>
+#include <linux/gpio/regmap.h>
+#include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
-#include <linux/spinlock.h>
+#include <linux/regmap.h>
 #include <linux/types.h>
 
 /*
@@ -68,416 +66,230 @@
 #define PLX_PEX8311_PCI_LCS_INTCSR  0x68
 #define INTCSR_INTERNAL_PCI_WIRE    BIT(8)
 #define INTCSR_LOCAL_INPUT          BIT(11)
-
-/**
- * struct idio_24_gpio_reg - GPIO device registers structure
- * @out0_7:	Read: FET Outputs 0-7
- *		Write: FET Outputs 0-7
- * @out8_15:	Read: FET Outputs 8-15
- *		Write: FET Outputs 8-15
- * @out16_23:	Read: FET Outputs 16-23
- *		Write: FET Outputs 16-23
- * @ttl_out0_7:	Read: TTL/CMOS Outputs 0-7
- *		Write: TTL/CMOS Outputs 0-7
- * @in0_7:	Read: Isolated Inputs 0-7
- *		Write: Reserved
- * @in8_15:	Read: Isolated Inputs 8-15
- *		Write: Reserved
- * @in16_23:	Read: Isolated Inputs 16-23
- *		Write: Reserved
- * @ttl_in0_7:	Read: TTL/CMOS Inputs 0-7
- *		Write: Reserved
- * @cos0_7:	Read: COS Status Inputs 0-7
- *		Write: COS Clear Inputs 0-7
- * @cos8_15:	Read: COS Status Inputs 8-15
- *		Write: COS Clear Inputs 8-15
- * @cos16_23:	Read: COS Status Inputs 16-23
- *		Write: COS Clear Inputs 16-23
- * @cos_ttl0_7:	Read: COS Status TTL/CMOS 0-7
- *		Write: COS Clear TTL/CMOS 0-7
- * @ctl:	Read: Control Register
- *		Write: Control Register
- * @reserved:	Read: Reserved
- *		Write: Reserved
- * @cos_enable:	Read: COS Enable
- *		Write: COS Enable
- * @soft_reset:	Read: IRQ Output Pin Status
- *		Write: Software Board Reset
- */
-struct idio_24_gpio_reg {
-	u8 out0_7;
-	u8 out8_15;
-	u8 out16_23;
-	u8 ttl_out0_7;
-	u8 in0_7;
-	u8 in8_15;
-	u8 in16_23;
-	u8 ttl_in0_7;
-	u8 cos0_7;
-	u8 cos8_15;
-	u8 cos16_23;
-	u8 cos_ttl0_7;
-	u8 ctl;
-	u8 reserved;
-	u8 cos_enable;
-	u8 soft_reset;
+#define IDIO_24_ENABLE_IRQ          (INTCSR_INTERNAL_PCI_WIRE | INTCSR_LOCAL_INPUT)
+
+#define IDIO_24_DAT_BASE 0x0
+#define IDIO_24_OUT_BASE IDIO_24_DAT_BASE
+#define IDIO_24_TTLCMOS_OUT_REG (IDIO_24_DAT_BASE + 0x3)
+#define IDIO_24_IN_BASE (IDIO_24_DAT_BASE + 0x4)
+#define IDIO_24_TTLCMOS_IN_REG (IDIO_24_DAT_BASE + 0x7)
+#define IDIO_24_STATUS_BASE (IDIO_24_DAT_BASE + 0x8)
+#define IDIO_24_ACK_BASE IDIO_24_STATUS_BASE
+#define IDIO_24_CONTROL_REG (IDIO_24_DAT_BASE + 0xC)
+#define IDIO_24_COS_ENABLE (IDIO_24_DAT_BASE + 0xE)
+#define IDIO_24_SOFT_RESET (IDIO_24_DAT_BASE + 0xF)
+
+#define CONTROL_REG_OUT_MODE BIT(1)
+
+#define COS_ENABLE_RISING BIT(1)
+#define COS_ENABLE_FALLING BIT(4)
+#define COS_ENABLE_BOTH (COS_ENABLE_RISING | COS_ENABLE_FALLING)
+
+static const struct regmap_range pex8311_intcsr_wr_ranges[] = {
+	regmap_reg_range(0x0, 0x0),
 };
-
-/**
- * struct idio_24_gpio - GPIO device private data structure
- * @chip:	instance of the gpio_chip
- * @lock:	synchronization lock to prevent I/O race conditions
- * @reg:	I/O address offset for the GPIO device registers
- * @irq_mask:	I/O bits affected by interrupts
- */
-struct idio_24_gpio {
-	struct gpio_chip chip;
-	raw_spinlock_t lock;
-	__u8 __iomem *plx;
-	struct idio_24_gpio_reg __iomem *reg;
-	unsigned long irq_mask;
+static const struct regmap_range pex8311_intcsr_rd_ranges[] = {
+	regmap_reg_range(0x0, 0x0),
+};
+static const struct regmap_range pex8311_intcsr_volatile_ranges[] = {
+	regmap_reg_range(0x0, 0x0),
+};
+static const struct regmap_access_table pex8311_intcsr_wr_table = {
+	.yes_ranges = pex8311_intcsr_wr_ranges,
+	.n_yes_ranges = ARRAY_SIZE(pex8311_intcsr_wr_ranges),
+};
+static const struct regmap_access_table pex8311_intcsr_rd_table = {
+	.yes_ranges = pex8311_intcsr_rd_ranges,
+	.n_yes_ranges = ARRAY_SIZE(pex8311_intcsr_rd_ranges),
+};
+static const struct regmap_access_table pex8311_intcsr_volatile_table = {
+	.yes_ranges = pex8311_intcsr_volatile_ranges,
+	.n_yes_ranges = ARRAY_SIZE(pex8311_intcsr_volatile_ranges),
 };
 
-static int idio_24_gpio_get_direction(struct gpio_chip *chip,
-	unsigned int offset)
-{
-	struct idio_24_gpio *const idio24gpio = gpiochip_get_data(chip);
-	const unsigned long out_mode_mask = BIT(1);
-
-	/* FET Outputs */
-	if (offset < 24)
-		return GPIO_LINE_DIRECTION_OUT;
-
-	/* Isolated Inputs */
-	if (offset < 48)
-		return GPIO_LINE_DIRECTION_IN;
-
-	/* TTL/CMOS I/O */
-	/* OUT MODE = 1 when TTL/CMOS Output Mode is set */
-	if (ioread8(&idio24gpio->reg->ctl) & out_mode_mask)
-		return GPIO_LINE_DIRECTION_OUT;
-
-	return GPIO_LINE_DIRECTION_IN;
-}
-
-static int idio_24_gpio_direction_input(struct gpio_chip *chip,
-	unsigned int offset)
-{
-	struct idio_24_gpio *const idio24gpio = gpiochip_get_data(chip);
-	unsigned long flags;
-	unsigned int ctl_state;
-	const unsigned long out_mode_mask = BIT(1);
+static const struct regmap_config pex8311_intcsr_regmap_config = {
+	.name = "pex8311_intcsr",
+	.reg_bits = 32,
+	.reg_stride = 1,
+	.val_bits = 32,
+	.io_port = true,
+	.max_register = 0x0,
+	.wr_table = &pex8311_intcsr_wr_table,
+	.rd_table = &pex8311_intcsr_rd_table,
+	.volatile_table = &pex8311_intcsr_volatile_table,
+};
 
-	/* TTL/CMOS I/O */
-	if (offset > 47) {
-		raw_spin_lock_irqsave(&idio24gpio->lock, flags);
+static const struct regmap_range idio_24_wr_ranges[] = {
+	regmap_reg_range(0x0, 0x3), regmap_reg_range(0x8, 0xC),
+	regmap_reg_range(0xE, 0xF),
+};
+static const struct regmap_range idio_24_rd_ranges[] = {
+	regmap_reg_range(0x0, 0xC), regmap_reg_range(0xE, 0xF),
+};
+static const struct regmap_range idio_24_volatile_ranges[] = {
+	regmap_reg_range(0x4, 0xB), regmap_reg_range(0xF, 0xF),
+};
+static const struct regmap_access_table idio_24_wr_table = {
+	.yes_ranges = idio_24_wr_ranges,
+	.n_yes_ranges = ARRAY_SIZE(idio_24_wr_ranges),
+};
+static const struct regmap_access_table idio_24_rd_table = {
+	.yes_ranges = idio_24_rd_ranges,
+	.n_yes_ranges = ARRAY_SIZE(idio_24_rd_ranges),
+};
+static const struct regmap_access_table idio_24_volatile_table = {
+	.yes_ranges = idio_24_volatile_ranges,
+	.n_yes_ranges = ARRAY_SIZE(idio_24_volatile_ranges),
+};
 
-		/* Clear TTL/CMOS Output Mode */
-		ctl_state = ioread8(&idio24gpio->reg->ctl) & ~out_mode_mask;
-		iowrite8(ctl_state, &idio24gpio->reg->ctl);
+static const struct regmap_config idio_24_regmap_config = {
+	.reg_bits = 8,
+	.reg_stride = 1,
+	.val_bits = 8,
+	.io_port = true,
+	.max_register = 0xF,
+	.wr_table = &idio_24_wr_table,
+	.rd_table = &idio_24_rd_table,
+	.volatile_table = &idio_24_volatile_table,
+	.cache_type = REGCACHE_FLAT,
+};
 
-		raw_spin_unlock_irqrestore(&idio24gpio->lock, flags);
+#define IDIO_24_NGPIO_PER_REG 8
+#define IDIO_24_REGMAP_IRQ(_id)						\
+	[24 + _id] = {							\
+		.reg_offset = (_id) / IDIO_24_NGPIO_PER_REG,		\
+		.mask = BIT((_id) % IDIO_24_NGPIO_PER_REG),		\
+		.type = { .types_supported = IRQ_TYPE_EDGE_BOTH },	\
 	}
+#define IDIO_24_IIN_IRQ(_id) IDIO_24_REGMAP_IRQ(_id)
+#define IDIO_24_TTL_IRQ(_id) IDIO_24_REGMAP_IRQ(24 + _id)
+
+static const struct regmap_irq idio_24_regmap_irqs[] = {
+	IDIO_24_IIN_IRQ(0), IDIO_24_IIN_IRQ(1), IDIO_24_IIN_IRQ(2), /* IIN 0-2 */
+	IDIO_24_IIN_IRQ(3), IDIO_24_IIN_IRQ(4), IDIO_24_IIN_IRQ(5), /* IIN 3-5 */
+	IDIO_24_IIN_IRQ(6), IDIO_24_IIN_IRQ(7), IDIO_24_IIN_IRQ(8), /* IIN 6-8 */
+	IDIO_24_IIN_IRQ(9), IDIO_24_IIN_IRQ(10), IDIO_24_IIN_IRQ(11), /* IIN 9-11 */
+	IDIO_24_IIN_IRQ(12), IDIO_24_IIN_IRQ(13), IDIO_24_IIN_IRQ(14), /* IIN 12-14 */
+	IDIO_24_IIN_IRQ(15), IDIO_24_IIN_IRQ(16), IDIO_24_IIN_IRQ(17), /* IIN 15-17 */
+	IDIO_24_IIN_IRQ(18), IDIO_24_IIN_IRQ(19), IDIO_24_IIN_IRQ(20), /* IIN 18-20 */
+	IDIO_24_IIN_IRQ(21), IDIO_24_IIN_IRQ(22), IDIO_24_IIN_IRQ(23), /* IIN 21-23 */
+	IDIO_24_TTL_IRQ(0), IDIO_24_TTL_IRQ(1), IDIO_24_TTL_IRQ(2), /* TTL 0-2 */
+	IDIO_24_TTL_IRQ(3), IDIO_24_TTL_IRQ(4), IDIO_24_TTL_IRQ(5), /* TTL 3-5 */
+	IDIO_24_TTL_IRQ(6), IDIO_24_TTL_IRQ(7), /* TTL 6-7 */
+};
 
-	return 0;
-}
-
-static int idio_24_gpio_direction_output(struct gpio_chip *chip,
-	unsigned int offset, int value)
+static int idio_24_set_type_config(struct regmap *const map,
+				   unsigned int **const buf,
+				   const unsigned int type,
+				   const struct regmap_irq *const irq_data,
+				   const int idx, void *const irq_drv_data)
 {
-	struct idio_24_gpio *const idio24gpio = gpiochip_get_data(chip);
-	unsigned long flags;
-	unsigned int ctl_state;
-	const unsigned long out_mode_mask = BIT(1);
-
-	/* TTL/CMOS I/O */
-	if (offset > 47) {
-		raw_spin_lock_irqsave(&idio24gpio->lock, flags);
-
-		/* Set TTL/CMOS Output Mode */
-		ctl_state = ioread8(&idio24gpio->reg->ctl) | out_mode_mask;
-		iowrite8(ctl_state, &idio24gpio->reg->ctl);
+	const unsigned int offset = irq_data->reg_offset;
+	const unsigned int rising = COS_ENABLE_RISING << offset;
+	const unsigned int falling = COS_ENABLE_FALLING << offset;
+	const unsigned int mask = COS_ENABLE_BOTH << offset;
+	unsigned int *const irq_type = irq_drv_data;
+	unsigned int new;
+	unsigned int cos_enable;
+	int err;
 
-		raw_spin_unlock_irqrestore(&idio24gpio->lock, flags);
+	switch (type) {
+	case IRQ_TYPE_EDGE_RISING:
+		new = rising;
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		new = falling;
+		break;
+	case IRQ_TYPE_EDGE_BOTH:
+		new = mask;
+		break;
+	default:
+		return -EINVAL;
 	}
 
-	chip->set(chip, offset, value);
-	return 0;
-}
-
-static int idio_24_gpio_get(struct gpio_chip *chip, unsigned int offset)
-{
-	struct idio_24_gpio *const idio24gpio = gpiochip_get_data(chip);
-	const unsigned long offset_mask = BIT(offset % 8);
-	const unsigned long out_mode_mask = BIT(1);
-
-	/* FET Outputs */
-	if (offset < 8)
-		return !!(ioread8(&idio24gpio->reg->out0_7) & offset_mask);
-
-	if (offset < 16)
-		return !!(ioread8(&idio24gpio->reg->out8_15) & offset_mask);
-
-	if (offset < 24)
-		return !!(ioread8(&idio24gpio->reg->out16_23) & offset_mask);
-
-	/* Isolated Inputs */
-	if (offset < 32)
-		return !!(ioread8(&idio24gpio->reg->in0_7) & offset_mask);
-
-	if (offset < 40)
-		return !!(ioread8(&idio24gpio->reg->in8_15) & offset_mask);
-
-	if (offset < 48)
-		return !!(ioread8(&idio24gpio->reg->in16_23) & offset_mask);
+	/* replace old bitmap with new bitmap */
+	*irq_type = (*irq_type & ~mask) | (new & mask);
 
-	/* TTL/CMOS Outputs */
-	if (ioread8(&idio24gpio->reg->ctl) & out_mode_mask)
-		return !!(ioread8(&idio24gpio->reg->ttl_out0_7) & offset_mask);
-
-	/* TTL/CMOS Inputs */
-	return !!(ioread8(&idio24gpio->reg->ttl_in0_7) & offset_mask);
-}
-
-static int idio_24_gpio_get_multiple(struct gpio_chip *chip,
-	unsigned long *mask, unsigned long *bits)
-{
-	struct idio_24_gpio *const idio24gpio = gpiochip_get_data(chip);
-	unsigned long offset;
-	unsigned long gpio_mask;
-	void __iomem *ports[] = {
-		&idio24gpio->reg->out0_7, &idio24gpio->reg->out8_15,
-		&idio24gpio->reg->out16_23, &idio24gpio->reg->in0_7,
-		&idio24gpio->reg->in8_15, &idio24gpio->reg->in16_23,
-	};
-	size_t index;
-	unsigned long port_state;
-	const unsigned long out_mode_mask = BIT(1);
-
-	/* clear bits array to a clean slate */
-	bitmap_zero(bits, chip->ngpio);
-
-	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
-		index = offset / 8;
-
-		/* read bits from current gpio port (port 6 is TTL GPIO) */
-		if (index < 6)
-			port_state = ioread8(ports[index]);
-		else if (ioread8(&idio24gpio->reg->ctl) & out_mode_mask)
-			port_state = ioread8(&idio24gpio->reg->ttl_out0_7);
-		else
-			port_state = ioread8(&idio24gpio->reg->ttl_in0_7);
-
-		port_state &= gpio_mask;
-
-		bitmap_set_value8(bits, port_state, offset);
-	}
+	err = regmap_read(map, IDIO_24_COS_ENABLE, &cos_enable);
+	if (err)
+		return err;
 
+	/* if COS is currently enabled */
+	if (cos_enable & mask)
+		return regmap_update_bits(map, IDIO_24_COS_ENABLE, mask,
+					  *irq_type);
 	return 0;
 }
 
-static void idio_24_gpio_set(struct gpio_chip *chip, unsigned int offset,
-	int value)
+static int idio_24_handle_mask_sync(struct regmap *const map, const int index,
+				    const unsigned int mask_buf_def,
+				    const unsigned int mask_buf,
+				    void *const irq_drv_data)
 {
-	struct idio_24_gpio *const idio24gpio = gpiochip_get_data(chip);
-	const unsigned long out_mode_mask = BIT(1);
-	void __iomem *base;
-	const unsigned int mask = BIT(offset % 8);
-	unsigned long flags;
-	unsigned int out_state;
-
-	/* Isolated Inputs */
-	if (offset > 23 && offset < 48)
-		return;
-
-	/* TTL/CMOS Inputs */
-	if (offset > 47 && !(ioread8(&idio24gpio->reg->ctl) & out_mode_mask))
-		return;
-
-	/* TTL/CMOS Outputs */
-	if (offset > 47)
-		base = &idio24gpio->reg->ttl_out0_7;
-	/* FET Outputs */
-	else if (offset > 15)
-		base = &idio24gpio->reg->out16_23;
-	else if (offset > 7)
-		base = &idio24gpio->reg->out8_15;
-	else
-		base = &idio24gpio->reg->out0_7;
-
-	raw_spin_lock_irqsave(&idio24gpio->lock, flags);
-
-	if (value)
-		out_state = ioread8(base) | mask;
-	else
-		out_state = ioread8(base) & ~mask;
-
-	iowrite8(out_state, base);
-
-	raw_spin_unlock_irqrestore(&idio24gpio->lock, flags);
-}
+	const unsigned int irq_type_mask = COS_ENABLE_BOTH << index;
+	unsigned int *const irq_type = irq_drv_data;
 
-static void idio_24_gpio_set_multiple(struct gpio_chip *chip,
-	unsigned long *mask, unsigned long *bits)
-{
-	struct idio_24_gpio *const idio24gpio = gpiochip_get_data(chip);
-	unsigned long offset;
-	unsigned long gpio_mask;
-	void __iomem *ports[] = {
-		&idio24gpio->reg->out0_7, &idio24gpio->reg->out8_15,
-		&idio24gpio->reg->out16_23
-	};
-	size_t index;
-	unsigned long bitmask;
-	unsigned long flags;
-	unsigned long out_state;
-	const unsigned long out_mode_mask = BIT(1);
-
-	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
-		index = offset / 8;
-
-		bitmask = bitmap_get_value8(bits, offset) & gpio_mask;
-
-		raw_spin_lock_irqsave(&idio24gpio->lock, flags);
-
-		/* read bits from current gpio port (port 6 is TTL GPIO) */
-		if (index < 6) {
-			out_state = ioread8(ports[index]);
-		} else if (ioread8(&idio24gpio->reg->ctl) & out_mode_mask) {
-			out_state = ioread8(&idio24gpio->reg->ttl_out0_7);
-		} else {
-			/* skip TTL GPIO if set for input */
-			raw_spin_unlock_irqrestore(&idio24gpio->lock, flags);
-			continue;
-		}
-
-		/* set requested bit states */
-		out_state &= ~gpio_mask;
-		out_state |= bitmask;
+	/* if all are masked, disable interrupts */
+	if (mask_buf == mask_buf_def)
+		return regmap_update_bits(map, IDIO_24_COS_ENABLE,
+					  irq_type_mask, ~irq_type_mask);
 
-		/* write bits for current gpio port (port 6 is TTL GPIO) */
-		if (index < 6)
-			iowrite8(out_state, ports[index]);
-		else
-			iowrite8(out_state, &idio24gpio->reg->ttl_out0_7);
-
-		raw_spin_unlock_irqrestore(&idio24gpio->lock, flags);
-	}
+	return regmap_update_bits(map, IDIO_24_COS_ENABLE, irq_type_mask,
+				  *irq_type);
 }
 
-static void idio_24_irq_ack(struct irq_data *data)
+static int idio_24_reg_mask_xlate(struct gpio_regmap *const gpio,
+				  const unsigned int base,
+				  const unsigned int offset,
+				  unsigned int *const reg,
+				  unsigned int *const mask)
 {
-}
-
-static void idio_24_irq_mask(struct irq_data *data)
-{
-	struct gpio_chip *const chip = irq_data_get_irq_chip_data(data);
-	struct idio_24_gpio *const idio24gpio = gpiochip_get_data(chip);
-	unsigned long flags;
-	const unsigned long bit_offset = irqd_to_hwirq(data) - 24;
-	unsigned char new_irq_mask;
-	const unsigned long bank_offset = bit_offset / 8;
-	unsigned char cos_enable_state;
-
-	raw_spin_lock_irqsave(&idio24gpio->lock, flags);
-
-	idio24gpio->irq_mask &= ~BIT(bit_offset);
-	new_irq_mask = idio24gpio->irq_mask >> bank_offset * 8;
-
-	if (!new_irq_mask) {
-		cos_enable_state = ioread8(&idio24gpio->reg->cos_enable);
-
-		/* Disable Rising Edge detection */
-		cos_enable_state &= ~BIT(bank_offset);
-		/* Disable Falling Edge detection */
-		cos_enable_state &= ~BIT(bank_offset + 4);
-
-		iowrite8(cos_enable_state, &idio24gpio->reg->cos_enable);
-	}
-
-	raw_spin_unlock_irqrestore(&idio24gpio->lock, flags);
-}
-
-static void idio_24_irq_unmask(struct irq_data *data)
-{
-	struct gpio_chip *const chip = irq_data_get_irq_chip_data(data);
-	struct idio_24_gpio *const idio24gpio = gpiochip_get_data(chip);
-	unsigned long flags;
-	unsigned char prev_irq_mask;
-	const unsigned long bit_offset = irqd_to_hwirq(data) - 24;
-	const unsigned long bank_offset = bit_offset / 8;
-	unsigned char cos_enable_state;
-
-	raw_spin_lock_irqsave(&idio24gpio->lock, flags);
+	const unsigned int out_stride = offset / IDIO_24_NGPIO_PER_REG;
+	const unsigned int in_stride = (offset - 24) / IDIO_24_NGPIO_PER_REG;
+	int err;
+	unsigned int ctrl_reg;
 
-	prev_irq_mask = idio24gpio->irq_mask >> bank_offset * 8;
-	idio24gpio->irq_mask |= BIT(bit_offset);
+	switch (base) {
+	case IDIO_24_DAT_BASE:
+		*mask = BIT(offset % IDIO_24_NGPIO_PER_REG);
 
-	if (!prev_irq_mask) {
-		cos_enable_state = ioread8(&idio24gpio->reg->cos_enable);
+		/* FET Outputs */
+		if (offset < 24) {
+			*reg = IDIO_24_OUT_BASE + out_stride;
+			return 0;
+		}
 
-		/* Enable Rising Edge detection */
-		cos_enable_state |= BIT(bank_offset);
-		/* Enable Falling Edge detection */
-		cos_enable_state |= BIT(bank_offset + 4);
+		/* Isolated Inputs */
+		if (offset < 48) {
+			*reg = IDIO_24_IN_BASE + in_stride;
+			return 0;
+		}
 
-		iowrite8(cos_enable_state, &idio24gpio->reg->cos_enable);
-	}
+		err = regmap_read(gpio->regmap, IDIO_24_CONTROL_REG, &ctrl_reg);
+		if (err)
+			return err;
 
-	raw_spin_unlock_irqrestore(&idio24gpio->lock, flags);
-}
+		/* TTL/CMOS Outputs */
+		if (ctrl_reg & CONTROL_REG_OUT_MODE) {
+			*reg = IDIO_24_TTLCMOS_OUT_REG;
+			return 0;
+		}
 
-static int idio_24_irq_set_type(struct irq_data *data, unsigned int flow_type)
-{
-	/* The only valid irq types are none and both-edges */
-	if (flow_type != IRQ_TYPE_NONE &&
-		(flow_type & IRQ_TYPE_EDGE_BOTH) != IRQ_TYPE_EDGE_BOTH)
+		/* TTL/CMOS Inputs */
+		*reg = IDIO_24_TTLCMOS_IN_REG;
+		return 0;
+	case IDIO_24_CONTROL_REG:
+		/* We can only set direction for TTL/CMOS lines */
+		if (offset < 48)
+			return -EOPNOTSUPP;
+
+		*reg = IDIO_24_CONTROL_REG;
+		*mask = CONTROL_REG_OUT_MODE;
+		return 0;
+	default:
+		/* Should never reach this path */
 		return -EINVAL;
-
-	return 0;
-}
-
-static struct irq_chip idio_24_irqchip = {
-	.name = "pcie-idio-24",
-	.irq_ack = idio_24_irq_ack,
-	.irq_mask = idio_24_irq_mask,
-	.irq_unmask = idio_24_irq_unmask,
-	.irq_set_type = idio_24_irq_set_type
-};
-
-static irqreturn_t idio_24_irq_handler(int irq, void *dev_id)
-{
-	struct idio_24_gpio *const idio24gpio = dev_id;
-	unsigned long irq_status;
-	struct gpio_chip *const chip = &idio24gpio->chip;
-	unsigned long irq_mask;
-	int gpio;
-
-	raw_spin_lock(&idio24gpio->lock);
-
-	/* Read Change-Of-State status */
-	irq_status = ioread32(&idio24gpio->reg->cos0_7);
-
-	raw_spin_unlock(&idio24gpio->lock);
-
-	/* Make sure our device generated IRQ */
-	if (!irq_status)
-		return IRQ_NONE;
-
-	/* Handle only unmasked IRQ */
-	irq_mask = idio24gpio->irq_mask & irq_status;
-
-	for_each_set_bit(gpio, &irq_mask, chip->ngpio - 24)
-		generic_handle_domain_irq(chip->irq.domain, gpio + 24);
-
-	raw_spin_lock(&idio24gpio->lock);
-
-	/* Clear Change-Of-State status */
-	iowrite32(irq_status, &idio24gpio->reg->cos0_7);
-
-	raw_spin_unlock(&idio24gpio->lock);
-
-	return IRQ_HANDLED;
+	}
 }
 
 #define IDIO_24_NGPIO 56
@@ -494,16 +306,18 @@ static const char *idio_24_names[IDIO_24_NGPIO] = {
 static int idio_24_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct device *const dev = &pdev->dev;
-	struct idio_24_gpio *idio24gpio;
 	int err;
 	const size_t pci_plx_bar_index = 1;
 	const size_t pci_bar_index = 2;
 	const char *const name = pci_name(pdev);
-	struct gpio_irq_chip *girq;
-
-	idio24gpio = devm_kzalloc(dev, sizeof(*idio24gpio), GFP_KERNEL);
-	if (!idio24gpio)
-		return -ENOMEM;
+	struct gpio_regmap_config gpio_config = {};
+	void __iomem *pex8311_intcsr;
+	void __iomem *idio_24_regs;
+	struct regmap *pex8311_intcsr_map;
+	struct regmap *idio_24_map;
+	struct regmap_irq_chip *chip;
+	unsigned int irq_type;
+	struct regmap_irq_chip_data *chip_data;
 
 	err = pcim_enable_device(pdev);
 	if (err) {
@@ -517,57 +331,68 @@ static int idio_24_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return err;
 	}
 
-	idio24gpio->plx = pcim_iomap_table(pdev)[pci_plx_bar_index];
-	idio24gpio->reg = pcim_iomap_table(pdev)[pci_bar_index];
-
-	idio24gpio->chip.label = name;
-	idio24gpio->chip.parent = dev;
-	idio24gpio->chip.owner = THIS_MODULE;
-	idio24gpio->chip.base = -1;
-	idio24gpio->chip.ngpio = IDIO_24_NGPIO;
-	idio24gpio->chip.names = idio_24_names;
-	idio24gpio->chip.get_direction = idio_24_gpio_get_direction;
-	idio24gpio->chip.direction_input = idio_24_gpio_direction_input;
-	idio24gpio->chip.direction_output = idio_24_gpio_direction_output;
-	idio24gpio->chip.get = idio_24_gpio_get;
-	idio24gpio->chip.get_multiple = idio_24_gpio_get_multiple;
-	idio24gpio->chip.set = idio_24_gpio_set;
-	idio24gpio->chip.set_multiple = idio_24_gpio_set_multiple;
-
-	girq = &idio24gpio->chip.irq;
-	girq->chip = &idio_24_irqchip;
-	/* This will let us handle the parent IRQ in the driver */
-	girq->parent_handler = NULL;
-	girq->num_parents = 0;
-	girq->parents = NULL;
-	girq->default_type = IRQ_TYPE_NONE;
-	girq->handler = handle_edge_irq;
-
-	raw_spin_lock_init(&idio24gpio->lock);
+	pex8311_intcsr = pcim_iomap_table(pdev)[pci_plx_bar_index] + PLX_PEX8311_PCI_LCS_INTCSR;
+	idio_24_regs = pcim_iomap_table(pdev)[pci_bar_index];
+
+	pex8311_intcsr_map = devm_regmap_init_mmio(dev, pex8311_intcsr,
+						   &pex8311_intcsr_regmap_config);
+	if (IS_ERR(pex8311_intcsr_map))
+		return dev_err_probe(dev, PTR_ERR(pex8311_intcsr_map),
+				     "Unable to initialize PEX8311 register map\n");
+	idio_24_map = devm_regmap_init_mmio(dev, idio_24_regs,
+					    &idio_24_regmap_config);
+	if (IS_ERR(idio_24_map))
+		return dev_err_probe(dev, PTR_ERR(idio_24_map),
+				     "Unable to initialize register map\n");
+
+	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	chip->irq_drv_data = devm_kzalloc(dev, sizeof(irq_type), GFP_KERNEL);
+	if (!irq_type)
+		return -ENOMEM;
+
+	chip->name = name;
+	chip->status_base = IDIO_24_STATUS_BASE;
+	chip->mask_base = IDIO_24_COS_ENABLE;
+	chip->ack_base = IDIO_24_ACK_BASE;
+	chip->num_regs = 4;
+	chip->irqs = idio_24_regmap_irqs;
+	chip->num_irqs = ARRAY_SIZE(idio_24_regmap_irqs);
+	chip->handle_mask_sync = idio_24_handle_mask_sync;
+	chip->set_type_config = idio_24_set_type_config;
 
 	/* Software board reset */
-	iowrite8(0, &idio24gpio->reg->soft_reset);
+	err = regmap_write(idio_24_map, IDIO_24_SOFT_RESET, 0);
+	if (err)
+		return err;
 	/*
 	 * enable PLX PEX8311 internal PCI wire interrupt and local interrupt
 	 * input
 	 */
-	iowrite8((INTCSR_INTERNAL_PCI_WIRE | INTCSR_LOCAL_INPUT) >> 8,
-		 idio24gpio->plx + PLX_PEX8311_PCI_LCS_INTCSR + 1);
-
-	err = devm_gpiochip_add_data(dev, &idio24gpio->chip, idio24gpio);
-	if (err) {
-		dev_err(dev, "GPIO registering failed (%d)\n", err);
+	err = regmap_update_bits(pex8311_intcsr_map, 0x0, IDIO_24_ENABLE_IRQ,
+				 IDIO_24_ENABLE_IRQ);
+	if (err)
 		return err;
-	}
-
-	err = devm_request_irq(dev, pdev->irq, idio_24_irq_handler, IRQF_SHARED,
-		name, idio24gpio);
-	if (err) {
-		dev_err(dev, "IRQ handler registering failed (%d)\n", err);
-		return err;
-	}
 
-	return 0;
+	err = devm_regmap_add_irq_chip(dev, idio_24_map, pdev->irq, 0, 0, chip,
+				       &chip_data);
+	if (err)
+		return dev_err_probe(dev, err, "IRQ registration failed\n");
+
+	gpio_config.parent = dev;
+	gpio_config.regmap = idio_24_map;
+	gpio_config.ngpio = IDIO_24_NGPIO;
+	gpio_config.names = idio_24_names;
+	gpio_config.reg_dat_base = GPIO_REGMAP_ADDR(IDIO_24_DAT_BASE);
+	gpio_config.reg_set_base = GPIO_REGMAP_ADDR(IDIO_24_DAT_BASE);
+	gpio_config.reg_dir_out_base = GPIO_REGMAP_ADDR(IDIO_24_CONTROL_REG);
+	gpio_config.ngpio_per_reg = IDIO_24_NGPIO_PER_REG;
+	gpio_config.irq_domain = regmap_irq_get_domain(chip_data);
+	gpio_config.reg_mask_xlate = idio_24_reg_mask_xlate;
+
+	return PTR_ERR_OR_ZERO(devm_gpio_regmap_register(dev, &gpio_config));
 }
 
 static const struct pci_device_id idio_24_pci_dev_id[] = {
-- 
2.39.2


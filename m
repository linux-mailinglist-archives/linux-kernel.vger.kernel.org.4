Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25E85B8B9A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 17:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiINPQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 11:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbiINPQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 11:16:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD357D1D7;
        Wed, 14 Sep 2022 08:16:11 -0700 (PDT)
Received: from pan.home (unknown [IPv6:2a00:23c6:c311:3401:435d:1590:4ce7:da62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: martyn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3F7DE6601F8A;
        Wed, 14 Sep 2022 16:16:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.co.uk;
        s=mail; t=1663168570;
        bh=CA/WywfPQQScGkgl615Yy8QuTzhulgWCGeY4bkluZxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZZ0moBoptUzw0YgfekFpvTBa6HyJwsLbzoLLRXDrUC44mSzsZxiSNBZvQtnLYxi7V
         JJQgIBIbcayBXsvL0HDMeGZdcHBJ5ZcgB+a71s9U80oi8Wgq94xembb78zPnVR+09X
         XzEme6TdCw8Ze26Jr3y5foBkgXhgK0Yu5OpluUqDrDlklZdUd+FONh5GmwrEH3jr9Z
         pVE9gqXeddmBcrYnVyfJIJij7O7iJMuE2uYi/+zh9YXQgSidUVkkEbfW95YjR0rK2U
         ZuhqeXmjsMorKg77zsxV/Teej0Ldn59xCV6HXds6SBkhHl1soVv/z6VqF00FqicnmX
         xbT1B+FKOj/cw==
From:   Martyn Welch <martyn.welch@collabora.co.uk>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Martyn Welch <martyn.welch@collabora.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 5/5] gpio: pca953x: Add support for PCAL6534
Date:   Wed, 14 Sep 2022 16:15:57 +0100
Message-Id: <20220914151558.536226-5-martyn.welch@collabora.co.uk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220914151558.536226-1-martyn.welch@collabora.co.uk>
References: <20220914151558.536226-1-martyn.welch@collabora.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martyn Welch <martyn.welch@collabora.com>

Add support for the NXP PCAL6534. This device is broadly a 34-bit version
of the PCAL6524. However, whilst the registers are broadly what you'd
expect for a 34-bit version of the PCAL6524, the spacing of the registers
has been compacted. This has the unfortunate effect of breaking the bit
shift based mechanism that is employed to work out register locations used
by the other chips supported by this driver. To accommodate ths, callback
functions have been added to allow alterate implementations of
pca953x_recalc_addr() and pca953x_check_register() for the PCAL6534.

Datasheet: https://www.nxp.com/docs/en/data-sheet/PCAL6534.pdf
Datasheet: https://www.diodes.com/assets/Datasheets/PI4IOE5V6534Q.pdf
Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
---

Changes in v2:
 - Removed stray change
 - Removed pi4ioe5v6534q ID (should use pcal6534)
 - Added callbacks to allow differing implementations of check_register and
   recalc_addr to be provided

Changes in v3:
 - Removed spurious newline
 - Shifted from ">" to ">=" to improve code readbility
 - Correct comment style
 - Remove spurious change to pca953x_recalc_addr()
 - Correct indentation

Changes in v4:
 - None

Changes in v5:
 - None

 drivers/gpio/gpio-pca953x.c | 136 +++++++++++++++++++++++++++++++-----
 1 file changed, 117 insertions(+), 19 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index c27b83bbbfe1..61e874c0cde4 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -66,6 +66,7 @@
 #define PCA_LATCH_INT		(PCA_PCAL | PCA_INT)
 #define PCA953X_TYPE		BIT(12)
 #define PCA957X_TYPE		BIT(13)
+#define PCAL653X_TYPE		BIT(14)
 #define PCA_TYPE_MASK		GENMASK(15, 12)
 
 #define PCA_CHIP_TYPE(x)	((x) & PCA_TYPE_MASK)
@@ -92,6 +93,7 @@ static const struct i2c_device_id pca953x_id[] = {
 	{ "pcal6408", 8 | PCA953X_TYPE | PCA_LATCH_INT, },
 	{ "pcal6416", 16 | PCA953X_TYPE | PCA_LATCH_INT, },
 	{ "pcal6524", 24 | PCA953X_TYPE | PCA_LATCH_INT, },
+	{ "pcal6534", 34 | PCAL653X_TYPE | PCA_LATCH_INT, },
 	{ "pcal9535", 16 | PCA953X_TYPE | PCA_LATCH_INT, },
 	{ "pcal9554b", 8  | PCA953X_TYPE | PCA_LATCH_INT, },
 	{ "pcal9555a", 16 | PCA953X_TYPE | PCA_LATCH_INT, },
@@ -212,6 +214,10 @@ struct pca953x_chip {
 	struct regulator *regulator;
 
 	const struct pca953x_reg_config *regs;
+
+	u8 (*recalc_addr)(struct pca953x_chip *chip, int reg, int off);
+	bool (*check_reg)(struct pca953x_chip *chip, unsigned int reg,
+			  u32 checkbank);
 };
 
 static int pca953x_bank_shift(struct pca953x_chip *chip)
@@ -289,6 +295,55 @@ static bool pca953x_check_register(struct pca953x_chip *chip, unsigned int reg,
 	return true;
 }
 
+/*
+ * Unfortunately, whilst the PCAL6534 chip (and compatibles) broadly follow the
+ * same register layout as the PCAL6524, the spacing of the registers has been
+ * fundamentally altered by compacting them and thus does not obey the same
+ * rules, including being able to use bit shifting to determine bank. These
+ * chips hence need special handling here.
+ */
+static bool pcal6534_check_register(struct pca953x_chip *chip, unsigned int reg,
+				    u32 checkbank)
+{
+	int bank;
+	int offset;
+
+	if (reg >= 0x30) {
+		/*
+		 * Reserved block between 14h and 2Fh does not align on
+		 * expected bank boundaries like other devices.
+		 */
+		int temp = reg - 0x30;
+
+		bank = temp / NBANK(chip);
+		offset = temp - (bank * NBANK(chip));
+		bank += 8;
+	} else if (reg >= 0x54) {
+		/*
+		 * Handle lack of reserved registers after output port
+		 * configuration register to form a bank.
+		 */
+		int temp = reg - 0x54;
+
+		bank = temp / NBANK(chip);
+		offset = temp - (bank * NBANK(chip));
+		bank += 16;
+	} else {
+		bank = reg / NBANK(chip);
+		offset = reg - (bank * NBANK(chip));
+	}
+
+	/* Register is not in the matching bank. */
+	if (!(BIT(bank) & checkbank))
+		return false;
+
+	/* Register is not within allowed range of bank. */
+	if (offset >= NBANK(chip))
+		return false;
+
+	return true;
+}
+
 static bool pca953x_readable_register(struct device *dev, unsigned int reg)
 {
 	struct pca953x_chip *chip = dev_get_drvdata(dev);
@@ -309,7 +364,7 @@ static bool pca953x_readable_register(struct device *dev, unsigned int reg)
 			PCAL9xxx_BANK_IRQ_STAT;
 	}
 
-	return pca953x_check_register(chip, reg, bank);
+	return chip->check_reg(chip, reg, bank);
 }
 
 static bool pca953x_writeable_register(struct device *dev, unsigned int reg)
@@ -329,7 +384,7 @@ static bool pca953x_writeable_register(struct device *dev, unsigned int reg)
 		bank |= PCAL9xxx_BANK_IN_LATCH | PCAL9xxx_BANK_PULL_EN |
 			PCAL9xxx_BANK_PULL_SEL | PCAL9xxx_BANK_IRQ_MASK;
 
-	return pca953x_check_register(chip, reg, bank);
+	return chip->check_reg(chip, reg, bank);
 }
 
 static bool pca953x_volatile_register(struct device *dev, unsigned int reg)
@@ -345,7 +400,7 @@ static bool pca953x_volatile_register(struct device *dev, unsigned int reg)
 	if (chip->driver_data & PCA_PCAL)
 		bank |= PCAL9xxx_BANK_IRQ_STAT;
 
-	return pca953x_check_register(chip, reg, bank);
+	return chip->check_reg(chip, reg, bank);
 }
 
 static const struct regmap_config pca953x_i2c_regmap = {
@@ -390,9 +445,42 @@ static u8 pca953x_recalc_addr(struct pca953x_chip *chip, int reg, int off)
 	return regaddr;
 }
 
+/*
+ * The PCAL6534 and compatible chips have altered bank alignment that doesn't
+ * fit within the bit shifting scheme used for other devices.
+ */
+static u8 pcal6534_recalc_addr(struct pca953x_chip *chip, int reg, int off)
+{
+	int addr;
+	int pinctrl;
+
+	addr = (reg & PCAL_GPIO_MASK) * NBANK(chip);
+
+	switch (reg) {
+	case PCAL953X_OUT_STRENGTH:
+	case PCAL953X_IN_LATCH:
+	case PCAL953X_PULL_EN:
+	case PCAL953X_PULL_SEL:
+	case PCAL953X_INT_MASK:
+	case PCAL953X_INT_STAT:
+	case PCAL953X_OUT_CONF:
+		pinctrl = ((reg & PCAL_PINCTRL_MASK) >> 1) + 0x20;
+		break;
+	case PCAL6524_INT_EDGE:
+	case PCAL6524_INT_CLR:
+	case PCAL6524_IN_STATUS:
+	case PCAL6524_OUT_INDCONF:
+	case PCAL6524_DEBOUNCE:
+		pinctrl = ((reg & PCAL_PINCTRL_MASK) >> 1) + 0x1c;
+		break;
+	}
+
+	return pinctrl + addr + (off / BANK_SZ);
+}
+
 static int pca953x_write_regs(struct pca953x_chip *chip, int reg, unsigned long *val)
 {
-	u8 regaddr = pca953x_recalc_addr(chip, reg, 0);
+	u8 regaddr = chip->recalc_addr(chip, reg, 0);
 	u8 value[MAX_BANK];
 	int i, ret;
 
@@ -410,7 +498,7 @@ static int pca953x_write_regs(struct pca953x_chip *chip, int reg, unsigned long
 
 static int pca953x_read_regs(struct pca953x_chip *chip, int reg, unsigned long *val)
 {
-	u8 regaddr = pca953x_recalc_addr(chip, reg, 0);
+	u8 regaddr = chip->recalc_addr(chip, reg, 0);
 	u8 value[MAX_BANK];
 	int i, ret;
 
@@ -429,7 +517,7 @@ static int pca953x_read_regs(struct pca953x_chip *chip, int reg, unsigned long *
 static int pca953x_gpio_direction_input(struct gpio_chip *gc, unsigned off)
 {
 	struct pca953x_chip *chip = gpiochip_get_data(gc);
-	u8 dirreg = pca953x_recalc_addr(chip, chip->regs->direction, off);
+	u8 dirreg = chip->recalc_addr(chip, chip->regs->direction, off);
 	u8 bit = BIT(off % BANK_SZ);
 	int ret;
 
@@ -443,8 +531,8 @@ static int pca953x_gpio_direction_output(struct gpio_chip *gc,
 		unsigned off, int val)
 {
 	struct pca953x_chip *chip = gpiochip_get_data(gc);
-	u8 dirreg = pca953x_recalc_addr(chip, chip->regs->direction, off);
-	u8 outreg = pca953x_recalc_addr(chip, chip->regs->output, off);
+	u8 dirreg = chip->recalc_addr(chip, chip->regs->direction, off);
+	u8 outreg = chip->recalc_addr(chip, chip->regs->output, off);
 	u8 bit = BIT(off % BANK_SZ);
 	int ret;
 
@@ -464,7 +552,7 @@ static int pca953x_gpio_direction_output(struct gpio_chip *gc,
 static int pca953x_gpio_get_value(struct gpio_chip *gc, unsigned off)
 {
 	struct pca953x_chip *chip = gpiochip_get_data(gc);
-	u8 inreg = pca953x_recalc_addr(chip, chip->regs->input, off);
+	u8 inreg = chip->recalc_addr(chip, chip->regs->input, off);
 	u8 bit = BIT(off % BANK_SZ);
 	u32 reg_val;
 	int ret;
@@ -481,7 +569,7 @@ static int pca953x_gpio_get_value(struct gpio_chip *gc, unsigned off)
 static void pca953x_gpio_set_value(struct gpio_chip *gc, unsigned off, int val)
 {
 	struct pca953x_chip *chip = gpiochip_get_data(gc);
-	u8 outreg = pca953x_recalc_addr(chip, chip->regs->output, off);
+	u8 outreg = chip->recalc_addr(chip, chip->regs->output, off);
 	u8 bit = BIT(off % BANK_SZ);
 
 	mutex_lock(&chip->i2c_lock);
@@ -492,7 +580,7 @@ static void pca953x_gpio_set_value(struct gpio_chip *gc, unsigned off, int val)
 static int pca953x_gpio_get_direction(struct gpio_chip *gc, unsigned off)
 {
 	struct pca953x_chip *chip = gpiochip_get_data(gc);
-	u8 dirreg = pca953x_recalc_addr(chip, chip->regs->direction, off);
+	u8 dirreg = chip->recalc_addr(chip, chip->regs->direction, off);
 	u8 bit = BIT(off % BANK_SZ);
 	u32 reg_val;
 	int ret;
@@ -551,8 +639,8 @@ static int pca953x_gpio_set_pull_up_down(struct pca953x_chip *chip,
 {
 	enum pin_config_param param = pinconf_to_config_param(config);
 
-	u8 pull_en_reg = pca953x_recalc_addr(chip, PCAL953X_PULL_EN, offset);
-	u8 pull_sel_reg = pca953x_recalc_addr(chip, PCAL953X_PULL_SEL, offset);
+	u8 pull_en_reg = chip->recalc_addr(chip, PCAL953X_PULL_EN, offset);
+	u8 pull_sel_reg = chip->recalc_addr(chip, PCAL953X_PULL_SEL, offset);
 	u8 bit = BIT(offset % BANK_SZ);
 	int ret;
 
@@ -915,13 +1003,13 @@ static int device_pca95xx_init(struct pca953x_chip *chip, u32 invert)
 	u8 regaddr;
 	int ret;
 
-	regaddr = pca953x_recalc_addr(chip, chip->regs->output, 0);
+	regaddr = chip->recalc_addr(chip, chip->regs->output, 0);
 	ret = regcache_sync_region(chip->regmap, regaddr,
 				   regaddr + NBANK(chip) - 1);
 	if (ret)
 		goto out;
 
-	regaddr = pca953x_recalc_addr(chip, chip->regs->direction, 0);
+	regaddr = chip->recalc_addr(chip, chip->regs->direction, 0);
 	ret = regcache_sync_region(chip->regmap, regaddr,
 				   regaddr + NBANK(chip) - 1);
 	if (ret)
@@ -1040,6 +1128,14 @@ static int pca953x_probe(struct i2c_client *client,
 		regmap_config = &pca953x_i2c_regmap;
 	}
 
+	if (PCA_CHIP_TYPE(chip->driver_data) == PCAL653X_TYPE) {
+		chip->recalc_addr = pcal6534_recalc_addr;
+		chip->check_reg = pcal6534_check_register;
+	} else {
+		chip->recalc_addr = pca953x_recalc_addr;
+		chip->check_reg = pca953x_check_register;
+	}
+
 	chip->regmap = devm_regmap_init_i2c(client, regmap_config);
 	if (IS_ERR(chip->regmap)) {
 		ret = PTR_ERR(chip->regmap);
@@ -1134,14 +1230,14 @@ static int pca953x_regcache_sync(struct device *dev)
 	 * The ordering between direction and output is important,
 	 * sync these registers first and only then sync the rest.
 	 */
-	regaddr = pca953x_recalc_addr(chip, chip->regs->direction, 0);
+	regaddr = chip->recalc_addr(chip, chip->regs->direction, 0);
 	ret = regcache_sync_region(chip->regmap, regaddr, regaddr + NBANK(chip) - 1);
 	if (ret) {
 		dev_err(dev, "Failed to sync GPIO dir registers: %d\n", ret);
 		return ret;
 	}
 
-	regaddr = pca953x_recalc_addr(chip, chip->regs->output, 0);
+	regaddr = chip->recalc_addr(chip, chip->regs->output, 0);
 	ret = regcache_sync_region(chip->regmap, regaddr, regaddr + NBANK(chip) - 1);
 	if (ret) {
 		dev_err(dev, "Failed to sync GPIO out registers: %d\n", ret);
@@ -1150,7 +1246,7 @@ static int pca953x_regcache_sync(struct device *dev)
 
 #ifdef CONFIG_GPIO_PCA953X_IRQ
 	if (chip->driver_data & PCA_PCAL) {
-		regaddr = pca953x_recalc_addr(chip, PCAL953X_IN_LATCH, 0);
+		regaddr = chip->recalc_addr(chip, PCAL953X_IN_LATCH, 0);
 		ret = regcache_sync_region(chip->regmap, regaddr,
 					   regaddr + NBANK(chip) - 1);
 		if (ret) {
@@ -1159,7 +1255,7 @@ static int pca953x_regcache_sync(struct device *dev)
 			return ret;
 		}
 
-		regaddr = pca953x_recalc_addr(chip, PCAL953X_INT_MASK, 0);
+		regaddr = chip->recalc_addr(chip, PCAL953X_INT_MASK, 0);
 		ret = regcache_sync_region(chip->regmap, regaddr,
 					   regaddr + NBANK(chip) - 1);
 		if (ret) {
@@ -1217,6 +1313,7 @@ static int pca953x_resume(struct device *dev)
 #endif
 
 /* convenience to stop overlong match-table lines */
+#define OF_653X(__nrgpio, __int) ((void *)(__nrgpio | PCAL653X_TYPE | __int))
 #define OF_953X(__nrgpio, __int) (void *)(__nrgpio | PCA953X_TYPE | __int)
 #define OF_957X(__nrgpio, __int) (void *)(__nrgpio | PCA957X_TYPE | __int)
 
@@ -1242,6 +1339,7 @@ static const struct of_device_id pca953x_dt_ids[] = {
 	{ .compatible = "nxp,pcal6408", .data = OF_953X(8, PCA_LATCH_INT), },
 	{ .compatible = "nxp,pcal6416", .data = OF_953X(16, PCA_LATCH_INT), },
 	{ .compatible = "nxp,pcal6524", .data = OF_953X(24, PCA_LATCH_INT), },
+	{ .compatible = "nxp,pcal6534", .data = OF_653X(34, PCA_LATCH_INT), },
 	{ .compatible = "nxp,pcal9535", .data = OF_953X(16, PCA_LATCH_INT), },
 	{ .compatible = "nxp,pcal9554b", .data = OF_953X( 8, PCA_LATCH_INT), },
 	{ .compatible = "nxp,pcal9555a", .data = OF_953X(16, PCA_LATCH_INT), },
-- 
2.35.1


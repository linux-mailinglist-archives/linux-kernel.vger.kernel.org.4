Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86DEF66C292
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 15:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjAPOqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 09:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjAPOpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 09:45:25 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ADC552749D
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 06:25:28 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99CB115A1;
        Mon, 16 Jan 2023 06:26:10 -0800 (PST)
Received: from donnerap.cambridge.arm.com (donnerap.cambridge.arm.com [10.1.197.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D36413F67D;
        Mon, 16 Jan 2023 06:25:26 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
        Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>,
        Martin Botka <martin.botka@somainline.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        martin.botka1@gmail.com, Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/3] mfd: axp20x: Add support for AXP313a PMIC
Date:   Mon, 16 Jan 2023 14:25:00 +0000
Message-Id: <20230116142501.767142-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230116142501.767142-1-andre.przywara@arm.com>
References: <20230116142501.767142-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Botka <martin.botka@somainline.org>

The AXP313a is a PMIC chip produced by X-Powers, it can be connected via
an I2C bus.
The name AXP1530 seems to appear as well, and this is what is used in
the BSP driver. From all we know it's the same chip, just a different
name. However we have only seen AXP313a chips in the wild, so go with
this name.

Compared to the other AXP PMICs it's a rather simple affair: just three
DCDC converters, three LDOs, and no battery charging support.

Describe the regmap and the MFD bits, along with the registers exposed
via I2C. Eventually advertise the device using the new compatible
string.

Signed-off-by: Martin Botka <martin.botka@somainline.org>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/mfd/axp20x-i2c.c   |  2 ++
 drivers/mfd/axp20x.c       | 61 ++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/axp20x.h | 32 ++++++++++++++++++++
 3 files changed, 95 insertions(+)

diff --git a/drivers/mfd/axp20x-i2c.c b/drivers/mfd/axp20x-i2c.c
index f49fbd3079589..5a592c29cccce 100644
--- a/drivers/mfd/axp20x-i2c.c
+++ b/drivers/mfd/axp20x-i2c.c
@@ -59,6 +59,7 @@ static void axp20x_i2c_remove(struct i2c_client *i2c)
 #ifdef CONFIG_OF
 static const struct of_device_id axp20x_i2c_of_match[] = {
 	{ .compatible = "x-powers,axp152", .data = (void *)AXP152_ID },
+	{ .compatible = "x-powers,axp313a", .data = (void *)AXP313A_ID},
 	{ .compatible = "x-powers,axp202", .data = (void *)AXP202_ID },
 	{ .compatible = "x-powers,axp209", .data = (void *)AXP209_ID },
 	{ .compatible = "x-powers,axp221", .data = (void *)AXP221_ID },
@@ -72,6 +73,7 @@ MODULE_DEVICE_TABLE(of, axp20x_i2c_of_match);
 
 static const struct i2c_device_id axp20x_i2c_id[] = {
 	{ "axp152", 0 },
+	{ "axp313a", 0 },
 	{ "axp202", 0 },
 	{ "axp209", 0 },
 	{ "axp221", 0 },
diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 47fd700f284f1..3019f091882fa 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -34,6 +34,7 @@
 
 static const char * const axp20x_model_names[] = {
 	"AXP152",
+	"AXP313a",
 	"AXP202",
 	"AXP209",
 	"AXP221",
@@ -66,6 +67,24 @@ static const struct regmap_access_table axp152_volatile_table = {
 	.n_yes_ranges	= ARRAY_SIZE(axp152_volatile_ranges),
 };
 
+static const struct regmap_range axp313a_writeable_ranges[] = {
+	regmap_reg_range(AXP313A_ON_INDICATE, AXP313A_IRQ_STATE),
+};
+
+static const struct regmap_range axp313a_volatile_ranges[] = {
+	regmap_reg_range(AXP313A_ON_INDICATE, AXP313A_IRQ_STATE),
+};
+
+static const struct regmap_access_table axp313a_writeable_table = {
+	.yes_ranges = axp313a_writeable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(axp313a_writeable_ranges),
+};
+
+static const struct regmap_access_table axp313a_volatile_table = {
+	.yes_ranges = axp313a_volatile_ranges,
+	.n_yes_ranges = ARRAY_SIZE(axp313a_volatile_ranges),
+};
+
 static const struct regmap_range axp20x_writeable_ranges[] = {
 	regmap_reg_range(AXP20X_DATACACHE(0), AXP20X_IRQ5_STATE),
 	regmap_reg_range(AXP20X_CHRG_CTRL1, AXP20X_CHRG_CTRL2),
@@ -245,6 +264,15 @@ static const struct regmap_config axp152_regmap_config = {
 	.cache_type	= REGCACHE_RBTREE,
 };
 
+static const struct regmap_config axp313a_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.wr_table = &axp313a_writeable_table,
+	.volatile_table = &axp313a_volatile_table,
+	.max_register = AXP313A_IRQ_STATE,
+	.cache_type = REGCACHE_RBTREE,
+};
+
 static const struct regmap_config axp20x_regmap_config = {
 	.reg_bits	= 8,
 	.val_bits	= 8,
@@ -304,6 +332,16 @@ static const struct regmap_irq axp152_regmap_irqs[] = {
 	INIT_REGMAP_IRQ(AXP152, GPIO0_INPUT,		2, 0),
 };
 
+static const struct regmap_irq axp313a_regmap_irqs[] = {
+	INIT_REGMAP_IRQ(AXP313A, PEK_RIS_EDGE,		0, 7),
+	INIT_REGMAP_IRQ(AXP313A, PEK_FAL_EDGE,		0, 6),
+	INIT_REGMAP_IRQ(AXP313A, PEK_SHORT,		0, 5),
+	INIT_REGMAP_IRQ(AXP313A, PEK_LONG,		0, 4),
+	INIT_REGMAP_IRQ(AXP313A, DCDC3_V_LOW,		0, 3),
+	INIT_REGMAP_IRQ(AXP313A, DCDC2_V_LOW,		0, 2),
+	INIT_REGMAP_IRQ(AXP313A, DIE_TEMP_HIGH,		0, 0),
+};
+
 static const struct regmap_irq axp20x_regmap_irqs[] = {
 	INIT_REGMAP_IRQ(AXP20X, ACIN_OVER_V,		0, 7),
 	INIT_REGMAP_IRQ(AXP20X, ACIN_PLUGIN,		0, 6),
@@ -513,6 +551,17 @@ static const struct regmap_irq_chip axp152_regmap_irq_chip = {
 	.num_regs		= 3,
 };
 
+static const struct regmap_irq_chip axp313a_regmap_irq_chip = {
+	.name			= "axp313a_irq_chip",
+	.status_base		= AXP313A_IRQ_STATE,
+	.ack_base		= AXP313A_IRQ_STATE,
+	.unmask_base		= AXP313A_IRQ_EN,
+	.init_ack_masked	= true,
+	.irqs			= axp313a_regmap_irqs,
+	.num_irqs		= ARRAY_SIZE(axp313a_regmap_irqs),
+	.num_regs		= 1,
+};
+
 static const struct regmap_irq_chip axp20x_regmap_irq_chip = {
 	.name			= "axp20x_irq_chip",
 	.status_base		= AXP20X_IRQ1_STATE,
@@ -676,6 +725,12 @@ static const struct mfd_cell axp152_cells[] = {
 	},
 };
 
+static struct mfd_cell axp313a_cells[] = {
+	{
+		.name = "axp20x-regulator",
+	},
+};
+
 static const struct resource axp288_adc_resources[] = {
 	DEFINE_RES_IRQ_NAMED(AXP288_IRQ_GPADC, "GPADC"),
 };
@@ -867,6 +922,12 @@ int axp20x_match_device(struct axp20x_dev *axp20x)
 		axp20x->regmap_cfg = &axp152_regmap_config;
 		axp20x->regmap_irq_chip = &axp152_regmap_irq_chip;
 		break;
+	case AXP313A_ID:
+		axp20x->nr_cells = ARRAY_SIZE(axp313a_cells);
+		axp20x->cells = axp313a_cells;
+		axp20x->regmap_cfg = &axp313a_regmap_config;
+		axp20x->regmap_irq_chip = &axp313a_regmap_irq_chip;
+		break;
 	case AXP202_ID:
 	case AXP209_ID:
 		axp20x->nr_cells = ARRAY_SIZE(axp20x_cells);
diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
index 9ab0e2fca7eac..ae18f8630238c 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -12,6 +12,7 @@
 
 enum axp20x_variants {
 	AXP152_ID = 0,
+	AXP313A_ID,
 	AXP202_ID,
 	AXP209_ID,
 	AXP221_ID,
@@ -45,6 +46,17 @@ enum axp20x_variants {
 #define AXP152_DCDC_FREQ		0x37
 #define AXP152_DCDC_MODE		0x80
 
+#define AXP313A_ON_INDICATE		0x00
+#define AXP313A_OUTPUT_CONTROL		0x10
+#define AXP313A_DCDC1_CONRTOL		0x13
+#define AXP313A_DCDC2_CONRTOL		0x14
+#define AXP313A_DCDC3_CONRTOL		0x15
+#define AXP313A_ALDO1_CONRTOL		0x16
+#define AXP313A_DLDO1_CONRTOL		0x17
+#define AXP313A_OUTPUT_MONITOR		0x1d
+#define AXP313A_IRQ_EN			0x20
+#define AXP313A_IRQ_STATE		0x21
+
 #define AXP20X_PWR_INPUT_STATUS		0x00
 #define AXP20X_PWR_OP_MODE		0x01
 #define AXP20X_USB_OTG_STATUS		0x02
@@ -287,6 +299,16 @@ enum axp20x_variants {
 #define AXP288_FG_TUNE5             0xed
 
 /* Regulators IDs */
+enum {
+	AXP313A_DCDC1 = 0,
+	AXP313A_DCDC2,
+	AXP313A_DCDC3,
+	AXP313A_LDO1,
+	AXP313A_LDO2,
+	AXP313A_RTC_LDO,
+	AXP313A_REG_ID_MAX,
+};
+
 enum {
 	AXP20X_LDO1 = 0,
 	AXP20X_LDO2,
@@ -440,6 +462,16 @@ enum {
 	AXP152_IRQ_GPIO0_INPUT,
 };
 
+enum axp313a_irqs {
+	AXP313A_IRQ_DIE_TEMP_HIGH,
+	AXP313A_IRQ_DCDC2_V_LOW = 2,
+	AXP313A_IRQ_DCDC3_V_LOW,
+	AXP313A_IRQ_PEK_LONG,
+	AXP313A_IRQ_PEK_SHORT,
+	AXP313A_IRQ_PEK_FAL_EDGE,
+	AXP313A_IRQ_PEK_RIS_EDGE,
+};
+
 enum {
 	AXP20X_IRQ_ACIN_OVER_V = 1,
 	AXP20X_IRQ_ACIN_PLUGIN,
-- 
2.25.1


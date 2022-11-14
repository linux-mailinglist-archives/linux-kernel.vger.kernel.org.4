Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B0162858F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237785AbiKNQiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238090AbiKNQhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:37:15 -0500
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [5.144.164.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329A02F64F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:32:46 -0800 (PST)
Received: from TimeMachine.lan (bband-dyn193.178-41-216.t-com.sk [178.41.216.193])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id 86E9D40195;
        Mon, 14 Nov 2022 17:23:54 +0100 (CET)
From:   Martin Botka <martin.botka@somainline.org>
To:     martin.botka1@gmail.com
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Yenda <jtrmal@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        Lee Jones <lee@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mfd: ax20x: Add suppport for AXP1530 PMIC
Date:   Mon, 14 Nov 2022 17:23:33 +0100
Message-Id: <20221114162334.1801137-1-martin.botka@somainline.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AXP1530 is a PMIC chip produced by X-Powers and an be connected via
I2C or RSB bus.
Where AXP313A seems to be closely related so the same driver can be used and
seen it only paired with H616 SoC.

Signed-off-by: Martin Botka <martin.botka@somainline.org>
---
 drivers/mfd/axp20x-i2c.c   |  2 ++
 drivers/mfd/axp20x-rsb.c   |  1 +
 drivers/mfd/axp20x.c       | 63 ++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/axp20x.h | 34 ++++++++++++++++++++
 4 files changed, 100 insertions(+)

diff --git a/drivers/mfd/axp20x-i2c.c b/drivers/mfd/axp20x-i2c.c
index 8fd6727dc30a..49c4acee3927 100644
--- a/drivers/mfd/axp20x-i2c.c
+++ b/drivers/mfd/axp20x-i2c.c
@@ -66,6 +66,7 @@ static const struct of_device_id axp20x_i2c_of_match[] = {
 	{ .compatible = "x-powers,axp223", .data = (void *)AXP223_ID },
 	{ .compatible = "x-powers,axp803", .data = (void *)AXP803_ID },
 	{ .compatible = "x-powers,axp806", .data = (void *)AXP806_ID },
+	{ .compatible = "x-powers,axp1530", .data = (void *)AXP1530_ID},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, axp20x_i2c_of_match);
@@ -79,6 +80,7 @@ static const struct i2c_device_id axp20x_i2c_id[] = {
 	{ "axp223", 0 },
 	{ "axp803", 0 },
 	{ "axp806", 0 },
+	{ "axp1530", 0 },
 	{ },
 };
 MODULE_DEVICE_TABLE(i2c, axp20x_i2c_id);
diff --git a/drivers/mfd/axp20x-rsb.c b/drivers/mfd/axp20x-rsb.c
index 214bc0d84d44..29d38be29904 100644
--- a/drivers/mfd/axp20x-rsb.c
+++ b/drivers/mfd/axp20x-rsb.c
@@ -62,6 +62,7 @@ static const struct of_device_id axp20x_rsb_of_match[] = {
 	{ .compatible = "x-powers,axp806", .data = (void *)AXP806_ID },
 	{ .compatible = "x-powers,axp809", .data = (void *)AXP809_ID },
 	{ .compatible = "x-powers,axp813", .data = (void *)AXP813_ID },
+	{ .compatible = "x-powers,axp1530", .data = (void *)AXP1530_ID },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, axp20x_rsb_of_match);
diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 880c41fa7021..a24bc2b926ce 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -43,6 +43,7 @@ static const char * const axp20x_model_names[] = {
 	"AXP806",
 	"AXP809",
 	"AXP813",
+	"AXP1530",
 };
 
 static const struct regmap_range axp152_writeable_ranges[] = {
@@ -168,6 +169,24 @@ static const struct regmap_access_table axp806_volatile_table = {
 	.n_yes_ranges	= ARRAY_SIZE(axp806_volatile_ranges),
 };
 
+static const struct regmap_range axp1530_writeable_ranges[] = {
+	regmap_reg_range(AXP1530_ON_INDICATE, AXP1530_FREQUENCY),
+};
+
+static const struct regmap_range axp1530_volatile_ranges[] = {
+	regmap_reg_range(AXP1530_ON_INDICATE, AXP1530_FREQUENCY),
+};
+
+static const struct regmap_access_table axp1530_writeable_table = {
+	.yes_ranges = axp1530_writeable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(axp1530_writeable_ranges),
+};
+
+static const struct regmap_access_table axp1530_volatile_table = {
+	.yes_ranges = axp1530_volatile_ranges,
+	.n_yes_ranges = ARRAY_SIZE(axp1530_volatile_ranges),
+};
+
 static const struct resource axp152_pek_resources[] = {
 	DEFINE_RES_IRQ_NAMED(AXP152_IRQ_PEK_RIS_EDGE, "PEK_DBR"),
 	DEFINE_RES_IRQ_NAMED(AXP152_IRQ_PEK_FAL_EDGE, "PEK_DBF"),
@@ -281,6 +300,15 @@ static const struct regmap_config axp806_regmap_config = {
 	.cache_type	= REGCACHE_RBTREE,
 };
 
+static const struct regmap_config axp1530_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.wr_table = &axp1530_writeable_table,
+	.volatile_table = &axp1530_volatile_table,
+	.max_register = AXP1530_FREQUENCY,
+	.cache_type = REGCACHE_RBTREE,
+};
+
 #define INIT_REGMAP_IRQ(_variant, _irq, _off, _mask)			\
 	[_variant##_IRQ_##_irq] = { .reg_offset = (_off), .mask = BIT(_mask) }
 
@@ -502,6 +530,16 @@ static const struct regmap_irq axp809_regmap_irqs[] = {
 	INIT_REGMAP_IRQ(AXP809, GPIO0_INPUT,		4, 0),
 };
 
+static const struct regmap_irq axp1530_regmap_irqs[] = {
+	INIT_REGMAP_IRQ(AXP1530, KEY_L2H_EN, 0, 7),
+	INIT_REGMAP_IRQ(AXP1530, KEY_H2L_EN, 0, 6),
+	INIT_REGMAP_IRQ(AXP1530, POKSIRQ_EN, 0, 5),
+	INIT_REGMAP_IRQ(AXP1530, POKLIRQ_EN, 0, 4),
+	INIT_REGMAP_IRQ(AXP1530, DCDC3_UNDER, 0, 3),
+	INIT_REGMAP_IRQ(AXP1530, DCDC2_UNDER, 0, 2),
+	INIT_REGMAP_IRQ(AXP1530, TEMP_OVER, 0, 0),
+};
+
 static const struct regmap_irq_chip axp152_regmap_irq_chip = {
 	.name			= "axp152_irq_chip",
 	.status_base		= AXP152_IRQ1_STATE,
@@ -588,6 +626,18 @@ static const struct regmap_irq_chip axp809_regmap_irq_chip = {
 	.num_regs		= 5,
 };
 
+static const struct regmap_irq_chip axp1530_regmap_irq_chip = {
+	.name = "axp1530_irq_chip",
+	.status_base = AXP1530_IRQ_STATUS1,
+	.ack_base = AXP1530_IRQ_STATUS1,
+	.mask_base = AXP1530_IRQ_ENABLE1,
+	.mask_invert = true,
+	.init_ack_masked = true,
+	.irqs = axp1530_regmap_irqs,
+	.num_irqs = ARRAY_SIZE(axp1530_regmap_irqs),
+	.num_regs = 1,
+};
+
 static const struct mfd_cell axp20x_cells[] = {
 	{
 		.name		= "axp20x-gpio",
@@ -832,6 +882,13 @@ static const struct mfd_cell axp813_cells[] = {
 	},
 };
 
+static struct mfd_cell axp1530_cells[] = {
+	{
+		.id = 0,
+		.name = "axp20x-regulator",
+	},
+};
+
 static struct axp20x_dev *axp20x_pm_power_off;
 static void axp20x_power_off(void)
 {
@@ -942,6 +999,12 @@ int axp20x_match_device(struct axp20x_dev *axp20x)
 		 */
 		axp20x->regmap_irq_chip = &axp803_regmap_irq_chip;
 		break;
+	case AXP1530_ID:
+		axp20x->nr_cells = ARRAY_SIZE(axp1530_cells);
+		axp20x->cells = axp1530_cells;
+		axp20x->regmap_cfg = &axp1530_regmap_config;
+		axp20x->regmap_irq_chip = &axp1530_regmap_irq_chip;
+		break;
 	default:
 		dev_err(dev, "unsupported AXP20X ID %lu\n", axp20x->variant);
 		return -EINVAL;
diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
index 9ab0e2fca7ea..75dcc2411940 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -21,6 +21,7 @@ enum axp20x_variants {
 	AXP806_ID,
 	AXP809_ID,
 	AXP813_ID,
+	AXP1530_ID,
 	NR_AXP20X_VARIANTS,
 };
 
@@ -128,6 +129,18 @@ enum axp20x_variants {
 #define AXP803_DCDC6_V_OUT		0x25
 #define AXP803_DCDC_FREQ_CTRL		0x3b
 
+#define AXP1530_ON_INDICATE		0x00
+#define AXP1530_OUTPUT_CONTROL	0x10
+#define AXP1530_DCDC1_CONRTOL	0x13
+#define AXP1530_DCDC2_CONRTOL	0x14
+#define AXP1530_DCDC3_CONRTOL	0x15
+#define AXP1530_ALDO1_CONRTOL	0x16
+#define AXP1530_DLDO1_CONRTOL	0x17
+#define AXP1530_OUTOUT_MONITOR	0x1D
+#define AXP1530_IRQ_ENABLE1		0x20
+#define AXP1530_IRQ_STATUS1		0x21
+#define AXP1530_FREQUENCY		0x87
+
 /* Other DCDC regulator control registers are the same as AXP803 */
 #define AXP813_DCDC7_V_OUT		0x26
 
@@ -419,6 +432,16 @@ enum {
 	AXP813_REG_ID_MAX,
 };
 
+enum
+{
+    AXP1530_DCDC1 = 0,
+    AXP1530_DCDC2,
+    AXP1530_DCDC3,
+    AXP1530_LDO1,
+    AXP1530_LDO2,
+    AXP1530_REG_ID_MAX,
+};
+
 /* IRQs */
 enum {
 	AXP152_IRQ_LDO0IN_CONNECT = 1,
@@ -632,6 +655,17 @@ enum axp809_irqs {
 	AXP809_IRQ_GPIO0_INPUT,
 };
 
+enum axp1530_irqs
+{
+	AXP1530_IRQ_TEMP_OVER,
+	AXP1530_IRQ_DCDC2_UNDER = 2,
+	AXP1530_IRQ_DCDC3_UNDER,
+	AXP1530_IRQ_POKLIRQ_EN,
+	AXP1530_IRQ_POKSIRQ_EN,
+	AXP1530_IRQ_KEY_L2H_EN,
+	AXP1530_IRQ_KEY_H2L_EN,
+};
+
 struct axp20x_dev {
 	struct device			*dev;
 	int				irq;
-- 
2.38.1


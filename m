Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F697487F6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 17:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbjGEP12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 11:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbjGEP11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:27:27 -0400
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A4CB10F2
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 08:27:23 -0700 (PDT)
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
Received: from 192.168.10.47
        by mg.richtek.com with MailGates ESMTP Server V6.0(297524:0:AUTH_RELAY)
        (envelope-from <alina_yu@richtek.com>); Wed, 05 Jul 2023 23:27:09 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Wed, 5 Jul
 2023 23:27:09 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Wed, 5 Jul 2023 23:27:09 +0800
From:   <alina_yu@richtek.com>
To:     <broonie@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <alina_yu@richtek.com>, <cy_huang@richtek.com>
Subject: [PATCH v2 2/2] regulator: rtq2208: Add Richtek RTQ2208 SubPMIC driver
Date:   Wed, 5 Jul 2023 23:27:09 +0800
Message-ID: <5fc248e0b2c4d3f59c2af3ec89cc333c8acbc372.1688569987.git.alina_yu@richtek.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1688569987.git.alina_yu@richtek.com>
References: <cover.1688569987.git.alina_yu@richtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: alinayu <alina_yu@richtek.com>

Add support for the RTQ2208 SubPMIC
This ic integrates with configurable, synchrnous buck converters and two ldos.

Signed-off-by: alinayu <alina_yu@richtek.com>
---
 drivers/regulator/Kconfig             |  12 +
 drivers/regulator/Makefile            |   1 +
 drivers/regulator/rtq2208-regulator.c | 550 ++++++++++++++++++++++++++++++++++
 3 files changed, 563 insertions(+)
 create mode 100644 drivers/regulator/rtq2208-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index e5f3613..e754034 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1213,6 +1213,18 @@ config REGULATOR_RTQ6752
 	  synchronous boost converters for PAVDD, and one synchronous NAVDD
 	  buck-boost. This device is suitable for automotive TFT-LCD panel.
 
+config REGULATOR_RTQ2208
+	tristate "Richtek RTQ2208 SubPMIC Regulator"
+	depends on I2C
+	select REGMAP_I2C
+	select RTGMAP_IRQ
+	help
+	  This driver adds support for RTQ2208 SubPMIC regulators.
+	  The RTQ2208 is a multi-phase, programmable power management IC that
+	  integrate with dual multi-configurable, synchronous buck converters
+	  and two ldos. It features wide output voltage range from 0.4V to 2.05V
+	  and the capability to configure the corresponding power stages.
+
 config REGULATOR_S2MPA01
 	tristate "Samsung S2MPA01 voltage regulator"
 	depends on MFD_SEC_CORE || COMPILE_TEST
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 58dfe01..04cbad17 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -143,6 +143,7 @@ obj-$(CONFIG_REGULATOR_RT6245)	+= rt6245-regulator.o
 obj-$(CONFIG_REGULATOR_RTMV20)	+= rtmv20-regulator.o
 obj-$(CONFIG_REGULATOR_RTQ2134) += rtq2134-regulator.o
 obj-$(CONFIG_REGULATOR_RTQ6752)	+= rtq6752-regulator.o
+obj-$(CONFIG_REGULATOR_RTQ2208) += rtq2208-regulator.o
 obj-$(CONFIG_REGULATOR_S2MPA01) += s2mpa01.o
 obj-$(CONFIG_REGULATOR_S2MPS11) += s2mps11.o
 obj-$(CONFIG_REGULATOR_S5M8767) += s5m8767.o
diff --git a/drivers/regulator/rtq2208-regulator.c b/drivers/regulator/rtq2208-regulator.c
new file mode 100644
index 0000000..22b6d90
--- /dev/null
+++ b/drivers/regulator/rtq2208-regulator.c
@@ -0,0 +1,550 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <linux/bitops.h>
+#include <linux/util_macros.h>
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+
+/* Register */
+#define RTQ2208_REG_GLOBAL_INT1			0x12
+#define RTQ2208_REG_FLT_RECORDBUCK_CB		0x18
+#define RTQ2208_REG_GLOBAL_INT1_MASK		0x1D
+#define RTQ2208_REG_FLT_MASKBUCK_CB		0x1F
+#define RTQ2208_REG_BUCK_C_CFG0			0x32
+#define RTQ2208_REG_BUCK_B_CFG0			0x42
+#define RTQ2208_REG_BUCK_A_CFG0			0x52
+#define RTQ2208_REG_BUCK_D_CFG0			0x62
+#define RTQ2208_REG_BUCK_G_CFG0			0x72
+#define RTQ2208_REG_BUCK_F_CFG0			0x82
+#define RTQ2208_REG_BUCK_E_CFG0			0x92
+#define RTQ2208_REG_BUCK_H_CFG0			0xA2
+#define RTQ2208_REG_LDO1_CFG			0xB1
+#define RTQ2208_REG_LDO2_CFG			0xC1
+
+/* Mask */
+#define RTQ2208_BUCK_NR_MTP_SEL_MASK		GENMASK(7, 0)
+#define RTQ2208_BUCK_EN_NR_MTP_SEL0_MASK	BIT(0)
+#define RTQ2208_BUCK_EN_NR_MTP_SEL1_MASK	BIT(1)
+#define RTQ2208_BUCK_RSPUP_MASK			GENMASK(6, 4)
+#define RTQ2208_BUCK_RSPDN_MASK			GENMASK(2, 0)
+#define RTQ2208_BUCK_NRMODE_MASK		BIT(5)
+#define RTQ2208_BUCK_STRMODE_MASK		BIT(5)
+#define RTQ2208_BUCK_EN_STR_MASK		BIT(0)
+#define RTQ2208_LDO_EN_STR_MASK			BIT(7)
+#define RTQ2208_EN_DIS_MASK			BIT(0)
+#define RTQ2208_RAMP_MASK			GENMASK(2, 0)
+
+/* Size */
+#define RTQ2208_VOUT_MAXNUM			256
+#define RTQ2208_BUCK_NUM_IRQ_REGS		5
+#define RTQ2208_STS_NUM_IRQ_REGS		2
+
+/* Value */
+#define RTQ2208_RAMP_VALUE_MIN			500
+#define RTQ2208_RAMP_VALUE_MAX			64000
+
+enum {
+	RTQ2208_BUCK_B = 0,
+	RTQ2208_BUCK_C,
+	RTQ2208_BUCK_D,
+	RTQ2208_BUCK_A,
+	RTQ2208_BUCK_F,
+	RTQ2208_BUCK_G,
+	RTQ2208_BUCK_H,
+	RTQ2208_BUCK_E,
+	RTQ2208_LDO2,
+	RTQ2208_LDO1,
+	RTQ2208_LDO_MAX,
+};
+
+enum {
+	RTQ2208_AUTO_MODE = 0,
+	RTQ2208_FCCM,
+};
+
+struct rtq2208_regulator_desc {
+	struct regulator_desc desc;
+	unsigned int mtp_sel_reg;
+	unsigned int mtp_sel_mask;
+	unsigned int mode_reg;
+	unsigned int mode_mask;
+	unsigned int suspend_config_reg;
+	unsigned int suspend_enable_mask;
+	unsigned int suspend_mode_mask;
+	unsigned int fixed_uV;
+};
+
+struct rtq2208_rdev_map {
+	struct regulator_dev *rdev[RTQ2208_LDO_MAX];
+	struct regmap *regmap;
+	struct device *dev;
+};
+
+/* set Normal Auto/FCCM mode */
+static int rtq2208_set_mode(struct regulator_dev *rdev, unsigned int mode)
+{
+	struct rtq2208_regulator_desc *rdesc =
+		(struct rtq2208_regulator_desc *)rdev->desc;
+	unsigned int val, shift;
+
+	switch (mode) {
+	case REGULATOR_MODE_NORMAL:
+		val = RTQ2208_AUTO_MODE;
+		break;
+	case REGULATOR_MODE_FAST:
+		val = RTQ2208_FCCM;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	shift = ffs(rdesc->mode_mask) - 1;
+	return regmap_update_bits(rdev->regmap, rdesc->mode_reg,
+				  rdesc->mode_mask, val << shift);
+}
+
+static unsigned int rtq2208_get_mode(struct regulator_dev *rdev)
+{
+	struct rtq2208_regulator_desc *rdesc =
+		(struct rtq2208_regulator_desc *)rdev->desc;
+	unsigned int mode_val;
+	int ret;
+
+	ret = regmap_read(rdev->regmap, rdesc->mode_reg, &mode_val);
+	if (ret)
+		return REGULATOR_MODE_INVALID;
+
+	return (mode_val & rdesc->mode_mask) ? REGULATOR_MODE_FAST : REGULATOR_MODE_NORMAL;
+}
+
+static int rtq2208_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
+{
+	const struct regulator_desc *rdesc = rdev->desc;
+	unsigned int sel = 0, val;
+
+	ramp_delay = max(ramp_delay, RTQ2208_RAMP_VALUE_MIN);
+	ramp_delay = min(ramp_delay, RTQ2208_RAMP_VALUE_MAX);
+
+	ramp_delay /= RTQ2208_RAMP_VALUE_MIN;
+	sel = RTQ2208_RAMP_MASK - (fls(ramp_delay) - 1);
+
+	val = FIELD_PREP(RTQ2208_BUCK_RSPUP_MASK, sel) | FIELD_PREP(RTQ2208_BUCK_RSPDN_MASK, sel);
+
+	return regmap_update_bits(rdev->regmap, rdesc->ramp_reg,
+				  RTQ2208_BUCK_RSPUP_MASK | RTQ2208_BUCK_RSPDN_MASK, val);
+}
+
+static int rtq2208_set_suspend_enable(struct regulator_dev *rdev)
+{
+	struct rtq2208_regulator_desc *rdesc =
+		(struct rtq2208_regulator_desc *)rdev->desc;
+
+	return regmap_set_bits(rdev->regmap, rdesc->suspend_config_reg, rdesc->suspend_enable_mask);
+}
+
+static int rtq2208_set_suspend_disable(struct regulator_dev *rdev)
+{
+	struct rtq2208_regulator_desc *rdesc =
+		(struct rtq2208_regulator_desc *)rdev->desc;
+
+	return regmap_update_bits(rdev->regmap, rdesc->suspend_config_reg, rdesc->suspend_enable_mask, 0);
+}
+
+static int rtq2208_set_suspend_mode(struct regulator_dev *rdev, unsigned int mode)
+{
+	struct rtq2208_regulator_desc *rdesc =
+		(struct rtq2208_regulator_desc *)rdev->desc;
+	unsigned int val, shift;
+
+	switch (mode) {
+	case REGULATOR_MODE_NORMAL:
+		val = RTQ2208_AUTO_MODE;
+		break;
+	case REGULATOR_MODE_FAST:
+		val = RTQ2208_FCCM;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	shift = ffs(rdesc->suspend_mode_mask) - 1;
+
+	return regmap_update_bits(rdev->regmap, rdesc->suspend_config_reg,
+			rdesc->suspend_mode_mask, val << shift);
+}
+
+static int rtq2208_ldo_get_voltage(struct regulator_dev *rdev)
+{
+	struct rtq2208_regulator_desc *rdesc =
+		(struct rtq2208_regulator_desc *)rdev->desc;
+
+	return rdesc->fixed_uV;
+}
+
+static const struct regulator_ops rtq2208_regulator_buck_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_linear_range,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_mode = rtq2208_set_mode,
+	.get_mode = rtq2208_get_mode,
+	.set_ramp_delay = rtq2208_set_ramp_delay,
+	.set_active_discharge = regulator_set_active_discharge_regmap,
+	.set_suspend_enable = rtq2208_set_suspend_enable,
+	.set_suspend_disable = rtq2208_set_suspend_disable,
+	.set_suspend_mode = rtq2208_set_suspend_mode,
+};
+
+static const struct regulator_ops rtq2208_regulator_ldo_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.set_active_discharge = regulator_set_active_discharge_regmap,
+	.set_suspend_enable = rtq2208_set_suspend_enable,
+	.set_suspend_disable = rtq2208_set_suspend_disable,
+	.get_voltage = rtq2208_ldo_get_voltage,
+};
+
+static int rtq2208_of_parse_cb(struct device_node *np,
+				const struct regulator_desc *desc,
+				struct regulator_config *config)
+{
+	struct rtq2208_regulator_desc *rdesc =
+		(struct rtq2208_regulator_desc *)desc;
+
+	if (desc->id != RTQ2208_LDO1 && desc->id != RTQ2208_LDO2)
+		return 0;
+
+	/* ldo voltage depends on factory setting */
+	return of_property_read_u32(np, "richtek,fixed_uV", &rdesc->fixed_uV);
+}
+
+static unsigned int rtq2208_of_map_mode(unsigned int mode)
+{
+	switch (mode) {
+	case RTQ2208_AUTO_MODE:
+		return REGULATOR_MODE_NORMAL;
+	case RTQ2208_FCCM:
+		return REGULATOR_MODE_FAST;
+	default:
+		return REGULATOR_MODE_INVALID;
+	}
+}
+
+static int rtq2208_init_alert_mask(struct rtq2208_rdev_map *rdev_map)
+{
+	struct regulator_dev *rdev;
+	const struct regulator_desc *desc;
+	unsigned int reg, mask, uv_irq, ov_irq;
+	unsigned char clr_mask[] = {0x33, 0x33, 0x33, 0x33, 0x33};
+	int i, ret;
+
+	/* write clear all irq once */
+	ret = regmap_bulk_write(rdev_map->regmap, RTQ2208_REG_FLT_RECORDBUCK_CB,
+				clr_mask, ARRAY_SIZE(clr_mask));
+	if (ret)
+		return dev_err_probe(rdev_map->dev, ret, "Failed to clr buck irqs\n");
+
+	/* write clear sts hd */
+	ret = regmap_update_bits(rdev_map->regmap, 0x1E, 0x01, 0x01);
+	if (ret)
+		return dev_err_probe(rdev_map->dev, ret, "Failed to clr sts hd irq\n");
+
+	/* unmask buck ov/uv irq */
+	for (i = 0; i < RTQ2208_LDO_MAX; i++) {
+		rdev = rdev_map->rdev[i];
+		if (!rdev)
+			continue;
+
+		desc = rdev[i].desc;
+		uv_irq = 4 * (desc->id);
+		ov_irq = 4 * (desc->id) + 1;
+		reg = RTQ2208_REG_FLT_MASKBUCK_CB + uv_irq / 8;
+		mask = uv_irq % 8 | ov_irq % 8;
+
+		ret = regmap_update_bits(rdev_map->regmap, reg, mask, 0x00);
+		if (ret)
+			return dev_err_probe(rdev_map->dev, ret, "Failed to unmask 0x%02x\n", reg);
+	}
+
+	/* unmask sts hd irq */
+	return regmap_update_bits(rdev_map->regmap, 0x1E, 0x01, 0x00);
+}
+
+static irqreturn_t rtq2208_buck_irq_handler(int irqno, void *devid)
+{
+	unsigned char buck_flags[RTQ2208_BUCK_NUM_IRQ_REGS], buck_masks[RTQ2208_BUCK_NUM_IRQ_REGS],
+			sts_flags[RTQ2208_STS_NUM_IRQ_REGS], sts_masks[RTQ2208_STS_NUM_IRQ_REGS];
+	int ret = 0, i, j, irq, mask, idx;
+	struct rtq2208_rdev_map *rdev_map = devid;
+	struct regulator_dev *rdev;
+
+	if (!rdev_map)
+		return IRQ_NONE;
+
+	ret = regmap_bulk_read(rdev_map->regmap, RTQ2208_REG_FLT_RECORDBUCK_CB,
+				buck_flags, ARRAY_SIZE(buck_flags));
+	if (ret)
+		return IRQ_NONE;
+
+	ret = regmap_bulk_read(rdev_map->regmap, RTQ2208_REG_GLOBAL_INT1,
+				sts_flags, ARRAY_SIZE(sts_flags));
+	if (ret)
+		goto out;
+
+	ret = regmap_bulk_read(rdev_map->regmap, RTQ2208_REG_FLT_MASKBUCK_CB,
+				buck_masks, ARRAY_SIZE(buck_masks));
+	if (ret)
+		goto out;
+
+	ret = regmap_bulk_read(rdev_map->regmap, RTQ2208_REG_GLOBAL_INT1_MASK,
+				sts_masks, ARRAY_SIZE(sts_masks));
+	if (ret)
+		goto out;
+
+	for (i = 0; i < RTQ2208_BUCK_NUM_IRQ_REGS; i++) {
+		buck_flags[i] &= buck_masks[i];
+		if (!buck_flags[i])
+			continue;
+
+		for (j = 0; j < 8; j++) {
+			irq = i * 8 + j;
+			mask = 1 << j;
+			idx = irq / 4;
+
+			rdev = rdev_map->rdev[idx];
+
+			if (mask & buck_flags[i] && rdev) {
+				/* uv irq */
+				if (irq % 4 == 0)
+					regulator_notifier_call_chain(rdev,
+							REGULATOR_EVENT_UNDER_VOLTAGE, NULL);
+				/* ov irq */
+				else if (irq % 4 == 1)
+					regulator_notifier_call_chain(rdev,
+							REGULATOR_EVENT_REGULATION_OUT, NULL);
+			}
+		}
+	}
+
+	for (i = 0; i < RTQ2208_STS_NUM_IRQ_REGS; i++) {
+		sts_flags[i] &= sts_masks[i];
+
+		/* sts hd_irq */
+		if (i == 1 && (sts_flags[i] & BIT(0))) {
+			for (j = 0; j < RTQ2208_LDO_MAX; j++) {
+				rdev = rdev_map->rdev[j];
+				if (!rdev)
+					continue;
+				regulator_notifier_call_chain(rdev, REGULATOR_EVENT_OVER_TEMP, NULL);
+			}
+		}
+	}
+
+out:
+	/* write clear irqs */
+	regmap_bulk_write(rdev_map->regmap, RTQ2208_REG_FLT_RECORDBUCK_CB,
+				buck_flags, ARRAY_SIZE(buck_flags));
+
+	regmap_bulk_write(rdev_map->regmap, RTQ2208_REG_GLOBAL_INT1,
+				sts_flags, ARRAY_SIZE(sts_flags));
+
+	return ret ? IRQ_NONE : IRQ_HANDLED;
+}
+
+#define RTQ2208_REGULATOR_INFO(_name, _base) \
+{ \
+	.name = #_name, \
+	.base = _base, \
+}
+
+#define BUCK_RG_BASE(_id)	RTQ2208_REG_BUCK_##_id##_CFG0
+#define BUCK_RG_SHIFT(_base, _shift)	(_base + _shift)
+#define LDO_RG_BASE(_id)	RTQ2208_REG_LDO##_id##_CFG
+#define LDO_RG_SHIFT(_base, _shift)	(_base + _shift)
+#define	VSEL_SHIFT(_sel)	(_sel ? 3 : 1)
+#define MTP_SEL_MASK(_sel)	RTQ2208_BUCK_EN_NR_MTP_SEL##_sel##_MASK
+
+static const struct linear_range rtq2208_vout_range[] = {
+	REGULATOR_LINEAR_RANGE(400000, 0, 180, 5000),
+	REGULATOR_LINEAR_RANGE(1310000, 181, 255, 10000),
+};
+
+static void rtq2208_init_regulator_desc(struct rtq2208_regulator_desc *rdesc, int mtp_sel, int idx)
+{
+	struct regulator_desc *desc;
+	static const struct {
+		char *name;
+		int base;
+	} regulator_info[] = {
+		RTQ2208_REGULATOR_INFO(BUCK_B, BUCK_RG_BASE(B)),
+		RTQ2208_REGULATOR_INFO(BUCK_C, BUCK_RG_BASE(C)),
+		RTQ2208_REGULATOR_INFO(BUCK_D, BUCK_RG_BASE(D)),
+		RTQ2208_REGULATOR_INFO(BUCK_A, BUCK_RG_BASE(A)),
+		RTQ2208_REGULATOR_INFO(BUCK_F, BUCK_RG_BASE(F)),
+		RTQ2208_REGULATOR_INFO(BUCK_G, BUCK_RG_BASE(G)),
+		RTQ2208_REGULATOR_INFO(BUCK_H, BUCK_RG_BASE(H)),
+		RTQ2208_REGULATOR_INFO(BUCK_E, BUCK_RG_BASE(E)),
+		RTQ2208_REGULATOR_INFO(LDO2, LDO_RG_BASE(2)),
+		RTQ2208_REGULATOR_INFO(LDO1, LDO_RG_BASE(1)),
+	}, *curr_info;
+
+	curr_info = regulator_info + idx;
+	desc = &rdesc->desc;
+	desc->name = curr_info->name;
+	desc->of_match = of_match_ptr(curr_info->name);
+	desc->id = idx;
+	desc->owner = THIS_MODULE;
+	desc->type = REGULATOR_VOLTAGE;
+	desc->enable_mask = mtp_sel ? MTP_SEL_MASK(1) : MTP_SEL_MASK(0);
+	desc->active_discharge_on = RTQ2208_EN_DIS_MASK;
+	desc->active_discharge_off = 0;
+	desc->active_discharge_mask = RTQ2208_EN_DIS_MASK;
+
+	rdesc->mode_mask = RTQ2208_BUCK_NRMODE_MASK;
+
+	if (idx >= RTQ2208_BUCK_B && idx <= RTQ2208_BUCK_E) {
+		/* init buck desc */
+		desc->enable_reg = BUCK_RG_SHIFT(curr_info->base, 2);
+		desc->ops = &rtq2208_regulator_buck_ops;
+		desc->vsel_reg = curr_info->base + VSEL_SHIFT(mtp_sel);
+		desc->vsel_mask = RTQ2208_BUCK_NR_MTP_SEL_MASK;
+		desc->n_voltages = RTQ2208_VOUT_MAXNUM;
+		desc->linear_ranges = rtq2208_vout_range;
+		desc->n_linear_ranges = ARRAY_SIZE(rtq2208_vout_range);
+		desc->ramp_reg = BUCK_RG_SHIFT(curr_info->base, 5);
+		desc->active_discharge_reg = curr_info->base;
+		desc->of_map_mode = rtq2208_of_map_mode;
+
+		rdesc->mode_reg = BUCK_RG_SHIFT(curr_info->base, 2);
+		rdesc->suspend_config_reg = BUCK_RG_SHIFT(curr_info->base, 4);
+		rdesc->suspend_enable_mask = RTQ2208_BUCK_EN_STR_MASK;
+		rdesc->suspend_mode_mask = RTQ2208_BUCK_STRMODE_MASK;
+	} else {
+		/* init ldo desc */
+		desc->enable_reg = curr_info->base;
+		desc->ops = &rtq2208_regulator_ldo_ops;
+		desc->n_voltages = 1;
+		desc->active_discharge_reg = LDO_RG_SHIFT(curr_info->base, 2);
+		desc->of_parse_cb = rtq2208_of_parse_cb;
+
+		rdesc->suspend_config_reg = curr_info->base;
+		rdesc->suspend_enable_mask = RTQ2208_LDO_EN_STR_MASK;
+	}
+}
+
+/** different slave address corresponds different used bucks
+ * slave address 0x10: BUCK[BCA FGE]
+ * slave address 0x20: BUCK[BC FGHE]
+ * slave address 0x40: BUCK[C G]
+ */
+static int rtq2208_regulator_check(int slave_addr, int *num, int *regulator_idx_table)
+{
+	static bool rtq2208_used_table[3][RTQ2208_LDO_MAX] = {
+		/* BUCK[BCA FGE], LDO[12] */
+		{1, 1, 0, 1, 1, 1, 0, 1, 1, 1},
+		/* BUCK[BC FGHE], LDO[12]*/
+		{1, 1, 0, 0, 1, 1, 1, 1, 1, 1},
+		/* BUCK[C G], LDO[12] */
+		{0, 1, 0, 0, 0, 1, 0, 0, 1, 1},
+	};
+	int i, idx = ffs(slave_addr >> 4) - 1;
+
+	for (i = 0; i < RTQ2208_LDO_MAX; i++) {
+		if (!rtq2208_used_table[idx][i])
+			continue;
+
+		regulator_idx_table[(*num)++] = i;
+	}
+
+	return 0;
+}
+
+static const struct regmap_config rtq2208_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0xEF,
+};
+
+static int rtq2208_probe(struct i2c_client *i2c)
+{
+	struct device *dev = &i2c->dev;
+	struct regmap *regmap;
+	struct rtq2208_regulator_desc *rdesc;
+	struct regulator_dev *rdev;
+	struct regulator_config cfg;
+	struct rtq2208_rdev_map *rdev_map;
+	int i, ret = 0, idx, mtp_sel, n_regulator = 0, regulator_idx_table[RTQ2208_LDO_MAX];
+
+	rdev_map = devm_kzalloc(dev, sizeof(struct rtq2208_rdev_map), GFP_KERNEL);
+	if (!rdev_map)
+		return -ENOMEM;
+
+	/* get mtp_sel0 or mtp_sel1 */
+	mtp_sel = device_property_read_bool(dev, "richtek,mtp-sel");
+
+	regmap = devm_regmap_init_i2c(i2c, &rtq2208_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap), "Failed to allocate regmap\n");
+
+	/* get needed regulator */
+	ret = rtq2208_regulator_check(i2c->addr, &n_regulator, regulator_idx_table);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to check used regulators\n");
+
+	rdev_map->regmap = regmap;
+	rdev_map->dev = dev;
+
+	cfg.dev = dev;
+	for (i = 0; i < n_regulator; i++) {
+		idx = regulator_idx_table[i];
+
+		rdesc = devm_kcalloc(dev, 1, sizeof(struct rtq2208_regulator_desc), GFP_KERNEL);
+		if (!rdesc)
+			return -ENOMEM;
+
+		/* init regulator desc */
+		rtq2208_init_regulator_desc(rdesc, mtp_sel, idx);
+
+		/* regiser regulator */
+		rdev = devm_regulator_register(dev, &rdesc->desc, &cfg);
+		if (IS_ERR(rdev))
+			return PTR_ERR(rdev);
+
+		rdev_map->rdev[idx] = rdev;
+	}
+
+	/* register interrupt */
+	ret = devm_request_threaded_irq(dev, i2c->irq, NULL, rtq2208_buck_irq_handler,
+					IRQF_ONESHOT, rdev_get_name(rdev), rdev_map);
+	if (ret)
+		return ret;
+
+	/* init interrupt mask */
+	ret = rtq2208_init_alert_mask(rdev_map);
+
+	return ret;
+}
+
+static const struct of_device_id __maybe_unused rtq2208_device_tables[] = {
+	{ .compatible = "richtek,rtq2208", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, rtq2208_device_tables);
+
+static struct i2c_driver rtq2208_driver = {
+	.driver = {
+		.name = "rtq2208",
+		.of_match_table = rtq2208_device_tables,
+	},
+	.probe_new = rtq2208_probe,
+};
+module_i2c_driver(rtq2208_driver);
+
+MODULE_AUTHOR("Alina Yu <alina_yu@richtek.com>");
+MODULE_DESCRIPTION("Richtek RTQ2208 Regulator Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4


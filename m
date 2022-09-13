Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF4D5B6D58
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 14:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbiIMMf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 08:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiIMMfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 08:35:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4E2186D9;
        Tue, 13 Sep 2022 05:35:08 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E18E76602024;
        Tue, 13 Sep 2022 13:35:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663072507;
        bh=KIRlqRzHAy77/ujJkdoPNvV4m9aTBRG3pftlreV4yMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mwn5Gq8bOr2zzkJUloYYW17UBQsnhRApfat3Jm7LN9INGDRRA2EhxlPX1I4jm8YOj
         0hqP8Drbxz9IPG8rwnn7MjOuhpkEU0P5AWXUKt3Uc3vwKGWaU37GxbtqJL8DhvmIjj
         hktNMsCVdsoE5fZxpaInQ2fr4hq7PA8e8ZLeGjKDUpC4RiXXXZlvBT/EGnCRoQOZ0Q
         PU1F2MLU8XNKcRCJ5BmPxRf/wgEY8llUnCUTw6phEPJOLQJ0KU59iRIA0ks0vmEMFv
         0oOKWOZb84N/odmVKZh7aBayn4dmWJJyj6U5viXwHMIO1yNKrOFAulEShiN/oeH0Ix
         QGgOU52lYWWPw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v4 4/4] regulator: Add driver for MT6332 PMIC regulators
Date:   Tue, 13 Sep 2022 14:34:56 +0200
Message-Id: <20220913123456.384513-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220913123456.384513-1-angelogioacchino.delregno@collabora.com>
References: <20220913123456.384513-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for the regulators found in the MT6332 PMICs,
including six buck and four LDO regulators.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/regulator/Kconfig                  |   9 +
 drivers/regulator/Makefile                 |   1 +
 drivers/regulator/mt6332-regulator.c       | 422 +++++++++++++++++++++
 include/linux/regulator/mt6332-regulator.h |  27 ++
 4 files changed, 459 insertions(+)
 create mode 100644 drivers/regulator/mt6332-regulator.c
 create mode 100644 include/linux/regulator/mt6332-regulator.h

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index e231294b1aa3..070e4403c6c2 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -796,6 +796,15 @@ config REGULATOR_MT6331
 	  This driver supports the control of different power rails of device
 	  through regulator interface
 
+config REGULATOR_MT6332
+	tristate "MediaTek MT6332 PMIC"
+	depends on MFD_MT6397
+	help
+	  Say y here to select this option to enable the power regulator of
+	  MediaTek MT6332 PMIC.
+	  This driver supports the control of different power rails of device
+	  through regulator interface
+
 config REGULATOR_MT6358
 	tristate "MediaTek MT6358 PMIC"
 	depends on MFD_MT6397
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index b75f11c50756..5962307e1130 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -96,6 +96,7 @@ obj-$(CONFIG_REGULATOR_MT6311) += mt6311-regulator.o
 obj-$(CONFIG_REGULATOR_MT6315) += mt6315-regulator.o
 obj-$(CONFIG_REGULATOR_MT6323)	+= mt6323-regulator.o
 obj-$(CONFIG_REGULATOR_MT6331)	+= mt6331-regulator.o
+obj-$(CONFIG_REGULATOR_MT6332)	+= mt6332-regulator.o
 obj-$(CONFIG_REGULATOR_MT6358)	+= mt6358-regulator.o
 obj-$(CONFIG_REGULATOR_MT6359)	+= mt6359-regulator.o
 obj-$(CONFIG_REGULATOR_MT6360) += mt6360-regulator.o
diff --git a/drivers/regulator/mt6332-regulator.c b/drivers/regulator/mt6332-regulator.c
new file mode 100644
index 000000000000..77a27d8127a3
--- /dev/null
+++ b/drivers/regulator/mt6332-regulator.c
@@ -0,0 +1,422 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2022 Collabora Ltd.
+// Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+//
+// Based on mt6323-regulator.c,
+//     Copyright (c) 2016 MediaTek Inc.
+//
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/mfd/mt6397/core.h>
+#include <linux/mfd/mt6332/registers.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/mt6332-regulator.h>
+#include <linux/regulator/of_regulator.h>
+
+#define MT6332_LDO_MODE_NORMAL	0
+#define MT6332_LDO_MODE_LP	1
+
+/*
+ * MT6332 regulators information
+ *
+ * @desc: standard fields of regulator description.
+ * @qi: Mask for query enable signal status of regulators
+ * @vselon_reg: Register sections for hardware control mode of bucks
+ * @vselctrl_reg: Register for controlling the buck control mode.
+ * @vselctrl_mask: Mask for query buck's voltage control mode.
+ * @status_reg: Register for regulator enable status where qi unavailable
+ * @status_mask: Mask for querying regulator enable status
+ */
+struct mt6332_regulator_info {
+	struct regulator_desc desc;
+	u32 qi;
+	u32 vselon_reg;
+	u32 vselctrl_reg;
+	u32 vselctrl_mask;
+	u32 modeset_reg;
+	u32 modeset_mask;
+	u32 status_reg;
+	u32 status_mask;
+};
+
+#define MT6332_BUCK(match, vreg, min, max, step, volt_ranges, enreg,	\
+		vosel, vosel_mask, voselon, vosel_ctrl)			\
+[MT6332_ID_##vreg] = {							\
+	.desc = {							\
+		.name = #vreg,						\
+		.of_match = of_match_ptr(match),			\
+		.ops = &mt6332_buck_volt_range_ops,			\
+		.type = REGULATOR_VOLTAGE,				\
+		.id = MT6332_ID_##vreg,					\
+		.owner = THIS_MODULE,					\
+		.n_voltages = (max - min)/step + 1,			\
+		.linear_ranges = volt_ranges,				\
+		.n_linear_ranges = ARRAY_SIZE(volt_ranges),		\
+		.vsel_reg = vosel,					\
+		.vsel_mask = vosel_mask,				\
+		.enable_reg = enreg,					\
+		.enable_mask = BIT(0),					\
+	},								\
+	.qi = BIT(13),							\
+	.vselon_reg = voselon,						\
+	.vselctrl_reg = vosel_ctrl,					\
+	.vselctrl_mask = BIT(1),					\
+	.status_mask = 0,						\
+}
+
+#define MT6332_LDO_LINEAR(match, vreg, min, max, step, volt_ranges,	\
+			  enreg, vosel, vosel_mask, voselon,		\
+			  vosel_ctrl, _modeset_reg, _modeset_mask)	\
+[MT6332_ID_##vreg] = {							\
+	.desc = {							\
+		.name = #vreg,						\
+		.of_match = of_match_ptr(match),			\
+		.ops = &mt6332_ldo_volt_range_ops,			\
+		.type = REGULATOR_VOLTAGE,				\
+		.id = MT6332_ID_##vreg,					\
+		.owner = THIS_MODULE,					\
+		.n_voltages = (max - min)/step + 1,			\
+		.linear_ranges = volt_ranges,				\
+		.n_linear_ranges = ARRAY_SIZE(volt_ranges),		\
+		.vsel_reg = vosel,					\
+		.vsel_mask = vosel_mask,				\
+		.enable_reg = enreg,					\
+		.enable_mask = BIT(0),					\
+	},								\
+	.qi = BIT(15),							\
+	.vselon_reg = voselon,						\
+	.vselctrl_reg = vosel_ctrl,					\
+	.vselctrl_mask = BIT(1),					\
+	.modeset_reg = _modeset_reg,					\
+	.modeset_mask = _modeset_mask,					\
+	.status_mask = 0,						\
+}
+
+#define MT6332_LDO_AO(match, vreg, ldo_volt_table, vosel, vosel_mask)	\
+[MT6332_ID_##vreg] = {							\
+	.desc = {							\
+		.name = #vreg,						\
+		.of_match = of_match_ptr(match),			\
+		.ops = &mt6332_volt_table_ao_ops,			\
+		.type = REGULATOR_VOLTAGE,				\
+		.id = MT6332_ID_##vreg,					\
+		.owner = THIS_MODULE,					\
+		.n_voltages = ARRAY_SIZE(ldo_volt_table),		\
+		.volt_table = ldo_volt_table,				\
+		.vsel_reg = vosel,					\
+		.vsel_mask = vosel_mask,				\
+	},								\
+}
+
+#define MT6332_LDO(match, vreg, ldo_volt_table, enreg, enbit, vosel,	\
+		   vosel_mask, _modeset_reg, _modeset_mask)		\
+[MT6332_ID_##vreg] = {							\
+	.desc = {							\
+		.name = #vreg,						\
+		.of_match = of_match_ptr(match),			\
+		.ops = &mt6332_volt_table_ops,				\
+		.type = REGULATOR_VOLTAGE,				\
+		.id = MT6332_ID_##vreg,					\
+		.owner = THIS_MODULE,					\
+		.n_voltages = ARRAY_SIZE(ldo_volt_table),		\
+		.volt_table = ldo_volt_table,				\
+		.vsel_reg = vosel,					\
+		.vsel_mask = vosel_mask,				\
+		.enable_reg = enreg,					\
+		.enable_mask = BIT(enbit),				\
+	},								\
+	.qi = BIT(15),							\
+	.modeset_reg = _modeset_reg,					\
+	.modeset_mask = _modeset_mask,					\
+	.status_mask = 0,						\
+}
+
+#define MT6332_REG_FIXED(match, vreg, enreg, enbit, qibit, volt, stbit)	\
+[MT6332_ID_##vreg] = {							\
+	.desc = {							\
+		.name = #vreg,						\
+		.of_match = of_match_ptr(match),			\
+		.ops = &mt6332_volt_fixed_ops,				\
+		.type = REGULATOR_VOLTAGE,				\
+		.id = MT6332_ID_##vreg,					\
+		.owner = THIS_MODULE,					\
+		.n_voltages = 1,					\
+		.enable_reg = enreg,					\
+		.enable_mask = BIT(enbit),				\
+		.min_uV = volt,						\
+	},								\
+	.qi = BIT(qibit),						\
+	.status_reg = MT6332_EN_STATUS0,				\
+	.status_mask = BIT(stbit),					\
+}
+
+static const struct linear_range boost_volt_range[] = {
+	REGULATOR_LINEAR_RANGE(3500000, 0, 0x7f, 31250),
+};
+
+static const struct linear_range buck_volt_range[] = {
+	REGULATOR_LINEAR_RANGE(700000, 0, 0x7f, 6250),
+};
+
+static const struct linear_range buck_pa_volt_range[] = {
+	REGULATOR_LINEAR_RANGE(500000, 0, 0x3f, 50000),
+};
+
+static const struct linear_range buck_rf_volt_range[] = {
+	REGULATOR_LINEAR_RANGE(1050000, 0, 0x7f, 9375),
+};
+
+static const unsigned int ldo_volt_table1[] = {
+	2800000, 3000000, 0, 3200000
+};
+
+static const unsigned int ldo_volt_table2[] = {
+	1200000, 1300000, 1400000, 1500000, 1600000, 1700000, 1800000, 1800000,
+};
+
+static int mt6332_get_status(struct regulator_dev *rdev)
+{
+	struct mt6332_regulator_info *info = rdev_get_drvdata(rdev);
+	u32 reg, en_mask, regval;
+	int ret;
+
+	if (info->qi > 0) {
+		reg = info->desc.enable_reg;
+		en_mask = info->qi;
+	} else {
+		reg = info->status_reg;
+		en_mask = info->status_mask;
+	}
+
+	ret = regmap_read(rdev->regmap, reg, &regval);
+	if (ret != 0) {
+		dev_err(&rdev->dev, "Failed to get enable reg: %d\n", ret);
+		return ret;
+	}
+
+	return (regval & en_mask) ? REGULATOR_STATUS_ON : REGULATOR_STATUS_OFF;
+}
+
+static int mt6332_ldo_set_mode(struct regulator_dev *rdev, unsigned int mode)
+{
+	struct mt6332_regulator_info *info = rdev_get_drvdata(rdev);
+	int val;
+
+	switch (mode) {
+	case REGULATOR_MODE_STANDBY:
+		val = MT6332_LDO_MODE_LP;
+		break;
+	case REGULATOR_MODE_NORMAL:
+		val = MT6332_LDO_MODE_NORMAL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	val <<= ffs(info->modeset_mask) - 1;
+
+	return regmap_update_bits(rdev->regmap, info->modeset_reg,
+				  info->modeset_mask, val);
+}
+
+static unsigned int mt6332_ldo_get_mode(struct regulator_dev *rdev)
+{
+	struct mt6332_regulator_info *info = rdev_get_drvdata(rdev);
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(rdev->regmap, info->modeset_reg, &val);
+	if (ret < 0)
+		return ret;
+
+	val &= info->modeset_mask;
+	val >>= ffs(info->modeset_mask) - 1;
+
+	return (val & BIT(0)) ? REGULATOR_MODE_STANDBY : REGULATOR_MODE_NORMAL;
+}
+
+static const struct regulator_ops mt6332_buck_volt_range_ops = {
+	.list_voltage = regulator_list_voltage_linear_range,
+	.map_voltage = regulator_map_voltage_linear_range,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.get_status = mt6332_get_status,
+};
+
+static const struct regulator_ops mt6332_ldo_volt_range_ops = {
+	.list_voltage = regulator_list_voltage_linear_range,
+	.map_voltage = regulator_map_voltage_linear_range,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.get_status = mt6332_get_status,
+	.set_mode = mt6332_ldo_set_mode,
+	.get_mode = mt6332_ldo_get_mode,
+};
+
+static const struct regulator_ops mt6332_volt_table_ops = {
+	.list_voltage = regulator_list_voltage_table,
+	.map_voltage = regulator_map_voltage_iterate,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.get_status = mt6332_get_status,
+	.set_mode = mt6332_ldo_set_mode,
+	.get_mode = mt6332_ldo_get_mode,
+};
+
+static const struct regulator_ops mt6332_volt_table_ao_ops = {
+	.list_voltage = regulator_list_voltage_table,
+	.map_voltage = regulator_map_voltage_iterate,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+};
+
+static const struct regulator_ops mt6332_volt_fixed_ops = {
+	.list_voltage = regulator_list_voltage_linear,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.get_status = mt6332_get_status,
+};
+
+/* The array is indexed by id(MT6332_ID_XXX) */
+static struct mt6332_regulator_info mt6332_regulators[] = {
+	MT6332_BUCK("buck-vdram", VDRAM, 700000, 1493750, 6250, buck_volt_range,
+		    MT6332_EN_STATUS0, MT6332_VDRAM_CON11, GENMASK(6, 0),
+		    MT6332_VDRAM_CON12, MT6332_VDRAM_CON7),
+	MT6332_BUCK("buck-vdvfs2", VDVFS2, 700000, 1312500, 6250, buck_volt_range,
+		    MT6332_VDVFS2_CON9, MT6332_VDVFS2_CON11, GENMASK(6, 0),
+		    MT6332_VDVFS2_CON12, MT6332_VDVFS2_CON7),
+	MT6332_BUCK("buck-vpa", VPA, 500000, 3400000, 50000, buck_pa_volt_range,
+		    MT6332_VPA_CON9, MT6332_VPA_CON11, GENMASK(5, 0),
+		    MT6332_VPA_CON12, MT6332_VPA_CON7),
+	MT6332_BUCK("buck-vrf18a", VRF1, 1050000, 2240625, 9375, buck_rf_volt_range,
+		    MT6332_VRF1_CON9, MT6332_VRF1_CON11, GENMASK(6, 0),
+		    MT6332_VRF1_CON12, MT6332_VRF1_CON7),
+	MT6332_BUCK("buck-vrf18b", VRF2, 1050000, 2240625, 9375, buck_rf_volt_range,
+		    MT6332_VRF2_CON9, MT6332_VRF2_CON11, GENMASK(6, 0),
+		    MT6332_VRF2_CON12, MT6332_VRF2_CON7),
+	MT6332_BUCK("buck-vsbst", VSBST, 3500000, 7468750, 31250, boost_volt_range,
+		    MT6332_VSBST_CON8, MT6332_VSBST_CON12, GENMASK(6, 0),
+		    MT6332_VSBST_CON13, MT6332_VSBST_CON8),
+	MT6332_LDO("ldo-vauxb32", VAUXB32, ldo_volt_table1, MT6332_LDO_CON1, 10,
+		   MT6332_LDO_CON9, GENMASK(6, 5), MT6332_LDO_CON1, GENMASK(1, 0)),
+	MT6332_REG_FIXED("ldo-vbif28", VBIF28, MT6332_LDO_CON2, 10, 0, 2800000, 1),
+	MT6332_REG_FIXED("ldo-vusb33", VUSB33, MT6332_LDO_CON3, 10, 0, 3300000, 2),
+	MT6332_LDO_LINEAR("ldo-vsram", VSRAM_DVFS2, 700000, 1493750, 6250, buck_volt_range,
+			  MT6332_EN_STATUS0, MT6332_LDO_CON8, GENMASK(15, 9),
+			  MT6332_VDVFS2_CON23, MT6332_VDVFS2_CON22,
+			  MT6332_LDO_CON5, GENMASK(1, 0)),
+	MT6332_LDO_AO("ldo-vdig18", VDIG18, ldo_volt_table2, MT6332_LDO_CON12, GENMASK(11, 9)),
+};
+
+static int mt6332_set_buck_vosel_reg(struct platform_device *pdev)
+{
+	struct mt6397_chip *mt6332 = dev_get_drvdata(pdev->dev.parent);
+	int i;
+	u32 regval;
+
+	for (i = 0; i < MT6332_ID_VREG_MAX; i++) {
+		if (mt6332_regulators[i].vselctrl_reg) {
+			if (regmap_read(mt6332->regmap,
+				mt6332_regulators[i].vselctrl_reg,
+				&regval) < 0) {
+				dev_err(&pdev->dev,
+					"Failed to read buck ctrl\n");
+				return -EIO;
+			}
+
+			if (regval & mt6332_regulators[i].vselctrl_mask) {
+				mt6332_regulators[i].desc.vsel_reg =
+				mt6332_regulators[i].vselon_reg;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int mt6332_regulator_probe(struct platform_device *pdev)
+{
+	struct mt6397_chip *mt6332 = dev_get_drvdata(pdev->dev.parent);
+	struct regulator_config config = {};
+	struct regulator_dev *rdev;
+	int i;
+	u32 reg_value;
+
+	/* Query buck controller to select activated voltage register part */
+	if (mt6332_set_buck_vosel_reg(pdev))
+		return -EIO;
+
+	/* Read PMIC chip revision to update constraints and voltage table */
+	if (regmap_read(mt6332->regmap, MT6332_HWCID, &reg_value) < 0) {
+		dev_err(&pdev->dev, "Failed to read Chip ID\n");
+		return -EIO;
+	}
+	reg_value &= GENMASK(7, 0);
+
+	dev_info(&pdev->dev, "Chip ID = 0x%x\n", reg_value);
+
+	/*
+	 * ChipID 0x10 is "MT6332 E1", has a different voltage table and
+	 * it's currently not supported in this driver. Upon detection of
+	 * this ID, refuse to register the regulators, as we will wrongly
+	 * interpret the VSEL for this revision, potentially overvolting
+	 * some device.
+	 */
+	if (reg_value == 0x10) {
+		dev_err(&pdev->dev, "Chip version not supported. Bailing out.\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < MT6332_ID_VREG_MAX; i++) {
+		config.dev = &pdev->dev;
+		config.driver_data = &mt6332_regulators[i];
+		config.regmap = mt6332->regmap;
+		rdev = devm_regulator_register(&pdev->dev,
+				&mt6332_regulators[i].desc, &config);
+		if (IS_ERR(rdev)) {
+			dev_err(&pdev->dev, "failed to register %s\n",
+				mt6332_regulators[i].desc.name);
+			return PTR_ERR(rdev);
+		}
+	}
+	return 0;
+}
+
+static const struct platform_device_id mt6332_platform_ids[] = {
+	{"mt6332-regulator", 0},
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(platform, mt6332_platform_ids);
+
+static struct platform_driver mt6332_regulator_driver = {
+	.driver = {
+		.name = "mt6332-regulator",
+	},
+	.probe = mt6332_regulator_probe,
+	.id_table = mt6332_platform_ids,
+};
+
+module_platform_driver(mt6332_regulator_driver);
+
+MODULE_AUTHOR("AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>");
+MODULE_DESCRIPTION("Regulator Driver for MediaTek MT6332 PMIC");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/regulator/mt6332-regulator.h b/include/linux/regulator/mt6332-regulator.h
new file mode 100644
index 000000000000..af5e3ed31029
--- /dev/null
+++ b/include/linux/regulator/mt6332-regulator.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022 Collabora Ltd.
+ * Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+
+#ifndef __LINUX_REGULATOR_MT6332_H
+#define __LINUX_REGULATOR_MT6332_H
+
+enum {
+	/* BUCK */
+	MT6332_ID_VDRAM = 0,
+	MT6332_ID_VDVFS2,
+	MT6332_ID_VPA,
+	MT6332_ID_VRF1,
+	MT6332_ID_VRF2,
+	MT6332_ID_VSBST,
+	/* LDO */
+	MT6332_ID_VAUXB32,
+	MT6332_ID_VBIF28,
+	MT6332_ID_VDIG18,
+	MT6332_ID_VSRAM_DVFS2,
+	MT6332_ID_VUSB33,
+	MT6332_ID_VREG_MAX
+};
+
+#endif /* __LINUX_REGULATOR_MT6332_H */
-- 
2.37.2


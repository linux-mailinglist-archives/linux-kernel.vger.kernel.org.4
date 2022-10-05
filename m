Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4325F56EA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 16:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiJEO6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 10:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiJEO5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 10:57:49 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5322644A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 07:57:46 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id bu30so6462191wrb.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 07:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=wNowIsRFCpdTy8thAGpB28NdQRlzq6hS3+3pT15MUFM=;
        b=rnFRDTQ3mkpIqfdpUEtuMFthYlpo9J4jJCFmIB2+a0tjqp4tyba8oBurSzL0AfbkVn
         Una4wTj1EAH/Hq0RIKbL9GLz2XhGAn97QguQt5tf3OiCuK7t0LGfCrCw+PziBN9iJGpo
         aEUC8uQLsKD+RMhn+TQfWzXs5KXo4RiRj5TWk55NybIF4fs/TrVGLmxZCOZdhEg9Y59a
         nBlrUSTMQo70U09iDf6YIf5zWWa+UOnTwIy6vkb/rFvpKz4afPiGN0j6wIWzGUauZuTm
         qgUZf7gbJZ1ilm+0nj6C48cCJvRiuNrqeoo4ZomIU7WzJjpGi3ivp2fKN63B7o5bTs8a
         yVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=wNowIsRFCpdTy8thAGpB28NdQRlzq6hS3+3pT15MUFM=;
        b=1Cl6z499nLNwNLjzJPUlir9s8dwNXUfqZkrxt4wEiJvGFgAwTE/fqXUG1X8AK6UnoM
         HGz40oyJP8jM/s9zpos632lOURFExjJc7C68amsTHVEF3fX9rIK+gaj3Nuk8rca2LBfc
         3KKSzXKZRUUHCHC9lkQxvmbnvc3O2iH+8rYBCZ769BB7RaV4YV8/KWRtQ5qTPDiVwCFy
         Y2eIsOtazSwkVnQ82MhWYAz8hdRh3/PQH0VAiRrC8rTIfNc6/eI353UvauR0ZJn5QxZW
         YoP7oBLz/a5bR0RCWP4o9krM2q9HTYw49C8+wUG2z+OdWFf12JrGxYA8BEu5EQMxkxEh
         iweg==
X-Gm-Message-State: ACrzQf3ql3SNCnt5Nr/akEoKXXdxzQCwGOmKFMUpsIiHahJAWI1t5Mcd
        3uVBuE8ZrSAP7QuSHmCHdtmnHw==
X-Google-Smtp-Source: AMsMyM61T6qNYrUkfEwi3FQ8mWEJdrJ9l5uQFK0jNiBo9/Gnyus3ACHfy25nFqSSeZ0rVClF3sw5fg==
X-Received: by 2002:a05:6000:1a8b:b0:22a:cb74:eaea with SMTP id f11-20020a0560001a8b00b0022acb74eaeamr76176wry.253.1664981865048;
        Wed, 05 Oct 2022 07:57:45 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id k38-20020a05600c1ca600b003a3170a7af9sm2313758wms.4.2022.10.05.07.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 07:57:44 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Wed, 05 Oct 2022 16:57:24 +0200
Subject: [PATCH v2 4/5] regulator: add mt6357 regulator
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221005-mt6357-support-v2-4-f17ba2d2d0a9@baylibre.com>
References: <20221005-mt6357-support-v2-0-f17ba2d2d0a9@baylibre.com>
In-Reply-To: <20221005-mt6357-support-v2-0-f17ba2d2d0a9@baylibre.com>
To:     Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chen Zhong <chen.zhong@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, Fabien Parent <fparent@baylibre.com>,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=16868;
 i=amergnat@baylibre.com; h=from:subject:message-id;
 bh=7m89e7rgerIPtJUkEwKURLiggz85Nh8CJoiONbInp/w=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjPZtiENgNxuuF2yW4Fl3jCMyRN8eD/t07xLWPy2b7
 +++IjNiJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCYz2bYgAKCRArRkmdfjHURQ5VD/
 0YWw788pdQlUinJS0kO5iTi5m7W7CZGSZJ+GQgA5MY1YwPowx0Rou5gTIn7FYjb3Hxo58DYi5bNmr8
 NHnyOhZ3L3piBFoZqRjftMMKNQ9Lqeg0PwYU7g6abJAYoFzIGps8A6bznlEZ52edb78ypMSWBuHXKg
 Ifp2/cHStSZ9fwOLVBxviTVrLwhn7xi9HQ3ibKk9heBXBphdd4pvoSwveIk6sVq4yMSIrdf3DmxLPY
 0FbNmRJqyG2N7Z+z2ixi5aBbn3xwQ9pWED+oJDeU0FXI4hELgEz4Xpm3dM4tOVrHkcGX3IFA6Ct5gM
 o2lmuYlV86ewUe5aJY3fn4H3f3RAmgYAnwWgPVDNrIAp/dBur4QGwtoVap5bM1z3ruUnbR35Km4z5K
 nXJbQnhLo8K4OeUL7hHCjeviRLf05G797iS8sP6G7q3s0UAIdfRKyqQYIlt+mYRvUhbMVJuIxnVUmn
 SYp2yoR3d6YEfhfGC6QT3IzLcltIqE9Np3s8w8sUKgvk49g3pEG+j6S+UU1Sa0jdPAETFZpdZP/DqJ
 X12ZEer7kMCZpZodOAyK84aOrbStsvP24PdsWsc93KOb6ybaU6L6udNyAKkshrwJWe5r6bbL3nu1NX
 Vuh3xlvWrWRL9jqkjlzqD1LJZdARZTlqzWpVBM+ZWiZ+JDqtJ83yxtDheeRw==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabien Parent <fparent@baylibre.com>

Add regulator driver for the MT6357 PMIC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 drivers/regulator/Kconfig                  |   9 +
 drivers/regulator/Makefile                 |   1 +
 drivers/regulator/mt6357-regulator.c       | 485 +++++++++++++++++++++++++++++
 include/linux/regulator/mt6357-regulator.h |  51 +++
 4 files changed, 546 insertions(+)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 070e4403c6c2..a659a57438f4 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -805,6 +805,15 @@ config REGULATOR_MT6332
 	  This driver supports the control of different power rails of device
 	  through regulator interface
 
+config REGULATOR_MT6357
+	tristate "MediaTek MT6357 PMIC"
+	depends on MFD_MT6397
+	help
+	  Say y here to select this option to enable the power regulator of
+	  MediaTek MT6357 PMIC.
+	  This driver supports the control of different power rails of device
+	  through regulator interface.
+
 config REGULATOR_MT6358
 	tristate "MediaTek MT6358 PMIC"
 	depends on MFD_MT6397
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 5962307e1130..e4d67b7b1af6 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -97,6 +97,7 @@ obj-$(CONFIG_REGULATOR_MT6315) += mt6315-regulator.o
 obj-$(CONFIG_REGULATOR_MT6323)	+= mt6323-regulator.o
 obj-$(CONFIG_REGULATOR_MT6331)	+= mt6331-regulator.o
 obj-$(CONFIG_REGULATOR_MT6332)	+= mt6332-regulator.o
+obj-$(CONFIG_REGULATOR_MT6357)	+= mt6357-regulator.o
 obj-$(CONFIG_REGULATOR_MT6358)	+= mt6358-regulator.o
 obj-$(CONFIG_REGULATOR_MT6359)	+= mt6359-regulator.o
 obj-$(CONFIG_REGULATOR_MT6360) += mt6360-regulator.o
diff --git a/drivers/regulator/mt6357-regulator.c b/drivers/regulator/mt6357-regulator.c
new file mode 100644
index 000000000000..4ecd41429448
--- /dev/null
+++ b/drivers/regulator/mt6357-regulator.c
@@ -0,0 +1,485 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2022 MediaTek Inc.
+// Copyright (c) 2022 BayLibre, SAS.
+// Author: Chen Zhong <chen.zhong@mediatek.com>
+// Author: Fabien Parent <fparent@baylibre.com>
+//
+// Based on mt6397-regulator.c
+//
+
+#include <linux/module.h>
+#include <linux/linear_range.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/mfd/mt6397/core.h>
+#include <linux/mfd/mt6357/registers.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/mt6357-regulator.h>
+#include <linux/regulator/of_regulator.h>
+
+/*
+ * MT6357 regulators' information
+ *
+ * @desc: standard fields of regulator description.
+ * @vselon_reg: Register sections for hardware control mode of bucks
+ * @vselctrl_reg: Register for controlling the buck control mode.
+ * @vselctrl_mask: Mask for query buck's voltage control mode.
+ */
+struct mt6357_regulator_info {
+	struct regulator_desc desc;
+	const u32 *index_table;
+	unsigned int n_table;
+	u32 vsel_shift;
+	u32 da_vsel_reg;
+	u32 da_vsel_mask;
+	u32 da_vsel_shift;
+};
+
+#define MT6357_BUCK(match, vreg, min, max, step,		\
+	volt_ranges, vosel_reg, vosel_mask, _da_vsel_mask)		\
+[MT6357_ID_##vreg] = {	\
+	.desc = {	\
+		.name = #vreg,	\
+		.of_match = of_match_ptr(match),	\
+		.regulators_node = "regulators",			\
+		.ops = &mt6357_volt_range_ops,	\
+		.type = REGULATOR_VOLTAGE,	\
+		.id = MT6357_ID_##vreg,		\
+		.owner = THIS_MODULE,		\
+		.n_voltages = ((max) - (min)) / (step) + 1,	\
+		.linear_ranges = volt_ranges,		\
+		.n_linear_ranges = ARRAY_SIZE(volt_ranges),	\
+		.vsel_reg = vosel_reg,	\
+		.vsel_mask = vosel_mask,	\
+		.enable_reg = MT6357_BUCK_##vreg##_CON0,	\
+		.enable_mask = BIT(0),	\
+	},	\
+	.da_vsel_reg = MT6357_BUCK_##vreg##_DBG0,	\
+	.da_vsel_mask = vosel_mask,	\
+	.da_vsel_shift = 0,	\
+}
+
+#define MT6357_LDO(match, vreg, ldo_volt_table,	\
+	ldo_index_table, enreg, vosel,	\
+	vosel_mask)	\
+[MT6357_ID_##vreg] = {	\
+	.desc = {	\
+		.name = #vreg,	\
+		.of_match = of_match_ptr(match),	\
+		.regulators_node = "regulators",			\
+		.ops = &mt6357_volt_table_ops,	\
+		.type = REGULATOR_VOLTAGE,	\
+		.id = MT6357_ID_##vreg,	\
+		.owner = THIS_MODULE,	\
+		.n_voltages = ARRAY_SIZE(ldo_volt_table),	\
+		.volt_table = ldo_volt_table,	\
+		.vsel_reg = vosel,	\
+		.vsel_mask = vosel_mask << 8,	\
+		.enable_reg = enreg,	\
+		.enable_mask = BIT(0),	\
+	},	\
+	.index_table = ldo_index_table,	\
+	.n_table = ARRAY_SIZE(ldo_index_table),	\
+}
+
+#define MT6357_LDO1(match, vreg, min, max, step, volt_ranges,	\
+	enreg, vosel, vosel_mask)	\
+[MT6357_ID_##vreg] = {	\
+	.desc = {	\
+		.name = #vreg,	\
+		.of_match = of_match_ptr(match),	\
+		.regulators_node = "regulators",			\
+		.ops = &mt6357_volt_range_ops,	\
+		.type = REGULATOR_VOLTAGE,	\
+		.id = MT6357_ID_##vreg,	\
+		.owner = THIS_MODULE,	\
+		.n_voltages = ((max) - (min)) / (step) + 1,	\
+		.linear_ranges = volt_ranges,		\
+		.n_linear_ranges = ARRAY_SIZE(volt_ranges),	\
+		.vsel_reg = vosel,	\
+		.vsel_mask = vosel_mask,	\
+		.enable_reg = enreg,	\
+		.enable_mask = BIT(0),	\
+	},	\
+	.da_vsel_reg = MT6357_LDO_##vreg##_DBG0,	\
+	.da_vsel_mask = 0x7f,	\
+	.da_vsel_shift = 8,	\
+}
+
+#define MT6357_REG_FIXED(match, vreg, volt)	\
+[MT6357_ID_##vreg] = {					\
+	.desc = {					\
+		.name = #vreg,				\
+		.of_match = of_match_ptr(match),	\
+		.regulators_node = "regulators",	\
+		.ops = &mt6357_volt_fixed_ops,		\
+		.type = REGULATOR_VOLTAGE,		\
+		.id = MT6357_ID_##vreg,			\
+		.owner = THIS_MODULE,			\
+		.n_voltages = 1,			\
+		.enable_reg = MT6357_LDO_##vreg##_CON0,	\
+		.enable_mask = BIT(0),			\
+		.min_uV = volt,				\
+	},						\
+}
+
+static int mt6357_set_voltage_sel(struct regulator_dev *rdev,
+				  unsigned int selector)
+{
+	int idx, ret;
+	const u32 *pvol;
+	struct mt6357_regulator_info *info = rdev_get_drvdata(rdev);
+
+	pvol = info->index_table;
+
+	idx = pvol[selector];
+	ret = regmap_update_bits(rdev->regmap, info->desc.vsel_reg,
+				 info->desc.vsel_mask,
+				 idx << 8);
+
+	return ret;
+}
+
+static int mt6357_get_voltage_sel(struct regulator_dev *rdev)
+{
+	int idx, ret;
+	u32 selector;
+	struct mt6357_regulator_info *info = rdev_get_drvdata(rdev);
+	const u32 *pvol;
+
+	ret = regmap_read(rdev->regmap, info->desc.vsel_reg, &selector);
+	if (ret != 0) {
+		dev_info(&rdev->dev,
+			 "Failed to get mt6357 %s vsel reg: %d\n",
+			 info->desc.name, ret);
+		return ret;
+	}
+
+	selector = (selector & info->desc.vsel_mask) >> 8;
+	pvol = info->index_table;
+	for (idx = 0; idx < info->desc.n_voltages; idx++) {
+		if (pvol[idx] == selector)
+			return idx;
+	}
+
+	return -EINVAL;
+}
+
+static int mt6357_get_buck_voltage_sel(struct regulator_dev *rdev)
+{
+	int ret, regval;
+	struct mt6357_regulator_info *info = rdev_get_drvdata(rdev);
+
+	ret = regmap_read(rdev->regmap, info->da_vsel_reg, &regval);
+	if (ret != 0) {
+		dev_err(&rdev->dev,
+			"Failed to get mt6357 Buck %s vsel reg: %d\n",
+			info->desc.name, ret);
+		return ret;
+	}
+
+	ret = (regval & info->da_vsel_mask) >> info->da_vsel_shift;
+
+	return ret;
+}
+
+static const struct regulator_ops mt6357_volt_range_ops = {
+	.list_voltage = regulator_list_voltage_linear_range,
+	.map_voltage = regulator_map_voltage_linear_range,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = mt6357_get_buck_voltage_sel,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+};
+
+static const struct regulator_ops mt6357_volt_table_ops = {
+	.list_voltage = regulator_list_voltage_table,
+	.map_voltage = regulator_map_voltage_iterate,
+	.set_voltage_sel = mt6357_set_voltage_sel,
+	.get_voltage_sel = mt6357_get_voltage_sel,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+};
+
+static const struct regulator_ops mt6357_volt_fixed_ops = {
+	.list_voltage = regulator_list_voltage_linear,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+};
+
+static const int vxo22_voltages[] = {
+	2200000,
+	2400000,
+};
+
+static const int vefuse_voltages[] = {
+	1200000,
+	1300000,
+	1500000,
+	1800000,
+	2800000,
+	2900000,
+	3000000,
+	3300000,
+};
+
+static const int vcn33_voltages[] = {
+	3300000,
+	3400000,
+	3500000,
+};
+
+static const int vcama_voltages[] = {
+	2500000,
+	2800000,
+};
+
+static const int vcamd_voltages[] = {
+	1000000,
+	1100000,
+	1200000,
+	1300000,
+	1500000,
+	1800000,
+};
+
+static const int vldo28_voltages[] = {
+	2800000,
+	3000000,
+};
+
+static const int vdram_voltages[] = {
+	1100000,
+	1200000,
+};
+
+static const int vsim_voltages[] = {
+	1700000,
+	1800000,
+	2700000,
+	3000000,
+	3100000,
+};
+
+static const int vibr_voltages[] = {
+	1200000,
+	1300000,
+	1500000,
+	1800000,
+	2000000,
+	2800000,
+	3000000,
+	3300000,
+};
+
+static const int vmc_voltages[] = {
+	1800000,
+	2900000,
+	3000000,
+	3300000,
+};
+
+static const int vmch_voltages[] = {
+	2900000,
+	3000000,
+	3300000,
+};
+
+static const int vemc_voltages[] = {
+	2900000,
+	3000000,
+	3300000,
+};
+
+static const int vusb_voltages[] = {
+	3000000,
+	3100000,
+};
+
+static const int vmc_idx[] = {
+	4, 10, 11, 13,
+};
+
+static const int vmch_idx[] = {
+	2, 3, 5,
+};
+
+static const int vemc_idx[] = {
+	2, 3, 5,
+};
+
+static const int vusb_idx[] = {
+	3, 4,
+};
+
+static const int vxo22_idx[] = {
+	0, 2,
+};
+
+static const int vefuse_idx[] = {
+	0, 1, 2, 4, 9, 10, 11, 13,
+};
+
+static const int vcn33_idx[] = {
+	1, 2, 3,
+};
+
+static const int vcama_idx[] = {
+	7, 10,
+};
+
+static const int vcamd_idx[] = {
+	4, 5, 6, 7, 9, 12,
+};
+
+static const int vldo28_idx[] = {
+	1, 3,
+};
+
+static const int vdram_idx[] = {
+	1, 2,
+};
+
+static const int vsim_idx[] = {
+	3, 4, 8, 11, 12,
+};
+
+static const int vibr_idx[] = {
+	0, 1, 2, 4, 5, 9, 11, 13,
+};
+
+static const struct linear_range buck_volt_range1[] = {
+	REGULATOR_LINEAR_RANGE(518750, 0, 0x7f, 6250),
+};
+
+static const struct linear_range buck_volt_range2[] = {
+	REGULATOR_LINEAR_RANGE(500000, 0, 0x7f, 6250),
+};
+
+static const struct linear_range buck_volt_range3[] = {
+	REGULATOR_LINEAR_RANGE(500000, 0, 0x3f, 50000),
+};
+
+static const struct linear_range buck_volt_range4[] = {
+	REGULATOR_LINEAR_RANGE(1200000, 0, 0x7f, 12500),
+};
+
+/* The array is indexed by id(MT6357_ID_XXX) */
+static struct mt6357_regulator_info mt6357_regulators[] = {
+	/* Bucks */
+	MT6357_BUCK("buck-vcore", VCORE, 518750, 1312500, 6250,
+		buck_volt_range1, MT6357_BUCK_VCORE_ELR0, 0x7f, 0x7f),
+	MT6357_BUCK("buck-vproc", VPROC, 518750, 1312500, 6250,
+		buck_volt_range1, MT6357_BUCK_VPROC_ELR0, 0x7f, 0x7f),
+	MT6357_BUCK("buck-vmodem", VMODEM, 500000, 1293750, 6250,
+		buck_volt_range2, MT6357_BUCK_VMODEM_ELR0, 0x7f, 0x7f),
+	MT6357_BUCK("buck-vpa", VPA, 500000, 3650000, 50000,
+		buck_volt_range3, MT6357_BUCK_VPA_CON1, 0x3f, 0x3f),
+	MT6357_BUCK("buck-vs1", VS1, 1200000, 2787500, 12500,
+		buck_volt_range4, MT6357_BUCK_VS1_ELR0, 0x7f, 0x7f),
+
+	/* LDOs */
+	MT6357_LDO("ldo-vcama", VCAMA, vcama_voltages, vcama_idx,
+		   MT6357_LDO_VCAMA_CON0, MT6357_VCAMA_ANA_CON0, 0xf),
+	MT6357_LDO("ldo-vcamd", VCAMD, vcamd_voltages, vcamd_idx,
+		   MT6357_LDO_VCAMD_CON0, MT6357_VCAMD_ANA_CON0, 0xf),
+	MT6357_LDO("ldo-vcn33-bt", VCN33_BT, vcn33_voltages, vcn33_idx,
+		   MT6357_LDO_VCN33_CON0_0, MT6357_VCN33_ANA_CON0, 0x3),
+	MT6357_LDO("ldo-vcn33-wifi", VCN33_WIFI, vcn33_voltages, vcn33_idx,
+		   MT6357_LDO_VCN33_CON0_1, MT6357_VCN33_ANA_CON0, 0x3),
+	MT6357_LDO("ldo-vdram", VDRAM, vdram_voltages, vdram_idx,
+		   MT6357_LDO_VDRAM_CON0, MT6357_VDRAM_ELR_2, 0x3),
+	MT6357_LDO("ldo-vefuse", VEFUSE, vefuse_voltages, vefuse_idx,
+		   MT6357_LDO_VEFUSE_CON0, MT6357_VEFUSE_ANA_CON0, 0xf),
+	MT6357_LDO("ldo-vemc", VEMC, vemc_voltages, vemc_idx,
+		   MT6357_LDO_VEMC_CON0, MT6357_VEMC_ANA_CON0, 0x7),
+	MT6357_LDO("ldo-vibr", VIBR, vibr_voltages, vibr_idx,
+		   MT6357_LDO_VIBR_CON0, MT6357_VIBR_ANA_CON0, 0xf),
+	MT6357_LDO("ldo-vldo28", VLDO28, vldo28_voltages, vldo28_idx,
+		   MT6357_LDO_VLDO28_CON0_0, MT6357_VLDO28_ANA_CON0, 0x3),
+	MT6357_LDO("ldo-vmc", VMC, vmc_voltages, vmc_idx,
+		   MT6357_LDO_VMC_CON0, MT6357_VMC_ANA_CON0, 0xf),
+	MT6357_LDO("ldo-vmch", VMCH, vmch_voltages, vmch_idx,
+		   MT6357_LDO_VMCH_CON0, MT6357_VMCH_ANA_CON0, 0x7),
+	MT6357_LDO("ldo-vsim1", VSIM1, vsim_voltages, vsim_idx,
+		   MT6357_LDO_VSIM1_CON0, MT6357_VSIM1_ANA_CON0, 0xf),
+	MT6357_LDO("ldo-vsim2", VSIM2, vsim_voltages, vsim_idx,
+		   MT6357_LDO_VSIM2_CON0, MT6357_VSIM2_ANA_CON0, 0xf),
+	MT6357_LDO("ldo-vusb33", VUSB33, vusb_voltages, vusb_idx,
+		   MT6357_LDO_VUSB33_CON0_0, MT6357_VUSB33_ANA_CON0, 0x7),
+	MT6357_LDO("ldo-vxo22", VXO22, vxo22_voltages, vxo22_idx,
+		   MT6357_LDO_VXO22_CON0, MT6357_VXO22_ANA_CON0, 0x3),
+
+	MT6357_LDO1("ldo-vsram-proc", VSRAM_PROC, 518750, 1312500, 6250,
+		   buck_volt_range1, MT6357_LDO_VSRAM_PROC_CON0,
+		   MT6357_LDO_VSRAM_CON0, 0x7f),
+	MT6357_LDO1("ldo-vsram-others", VSRAM_OTHERS, 518750, 1312500, 6250,
+		   buck_volt_range1, MT6357_LDO_VSRAM_OTHERS_CON0,
+		   MT6357_LDO_VSRAM_CON1, 0x7f),
+
+	MT6357_REG_FIXED("ldo-vaud28", VAUD28, 2800000),
+	MT6357_REG_FIXED("ldo-vaux18", VAUX18, 1800000),
+	MT6357_REG_FIXED("ldo-vcamio18", VCAMIO, 1800000),
+	MT6357_REG_FIXED("ldo-vcn18", VCN18, 1800000),
+	MT6357_REG_FIXED("ldo-vcn28", VCN28, 2800000),
+	MT6357_REG_FIXED("ldo-vfe28", VFE28, 2800000),
+	MT6357_REG_FIXED("ldo-vio18", VIO18, 1800000),
+	MT6357_REG_FIXED("ldo-vio28", VIO28, 2800000),
+	MT6357_REG_FIXED("ldo-vrf12", VRF12, 1200000),
+	MT6357_REG_FIXED("ldo-vrf18", VRF18, 1800000),
+};
+
+static int mt6357_regulator_probe(struct platform_device *pdev)
+{
+	struct mt6397_chip *mt6357 = dev_get_drvdata(pdev->dev.parent);
+	struct regulator_config config = {};
+	struct regulator_dev *rdev;
+	int i;
+
+	pdev->dev.of_node = pdev->dev.parent->of_node;
+
+	for (i = 0; i < MT6357_MAX_REGULATOR; i++) {
+		config.dev = &pdev->dev;
+		config.driver_data = &mt6357_regulators[i];
+		config.regmap = mt6357->regmap;
+
+		rdev = devm_regulator_register(&pdev->dev,
+					       &mt6357_regulators[i].desc,
+					       &config);
+		if (IS_ERR(rdev)) {
+			dev_err(&pdev->dev, "failed to register %s\n",
+				mt6357_regulators[i].desc.name);
+			return PTR_ERR(rdev);
+		}
+	}
+
+	return 0;
+}
+
+static const struct platform_device_id mt6357_platform_ids[] = {
+	{ "mt6357-regulator" },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(platform, mt6357_platform_ids);
+
+static struct platform_driver mt6357_regulator_driver = {
+	.driver = {
+		.name = "mt6357-regulator",
+	},
+	.probe = mt6357_regulator_probe,
+	.id_table = mt6357_platform_ids,
+};
+
+module_platform_driver(mt6357_regulator_driver);
+
+MODULE_AUTHOR("Fabien Parent <fparent@baylibre.com>");
+MODULE_DESCRIPTION("Regulator Driver for MediaTek MT6357 PMIC");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/regulator/mt6357-regulator.h b/include/linux/regulator/mt6357-regulator.h
new file mode 100644
index 000000000000..238b1ee77ea6
--- /dev/null
+++ b/include/linux/regulator/mt6357-regulator.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ */
+
+#ifndef __LINUX_REGULATOR_MT6357_H
+#define __LINUX_REGULATOR_MT6357_H
+
+enum {
+	/* Bucks */
+	MT6357_ID_VCORE,
+	MT6357_ID_VMODEM,
+	MT6357_ID_VPA,
+	MT6357_ID_VPROC,
+	MT6357_ID_VS1,
+
+	/* LDOs */
+	MT6357_ID_VAUX18,
+	MT6357_ID_VAUD28,
+	MT6357_ID_VCAMA,
+	MT6357_ID_VCAMD,
+	MT6357_ID_VCAMIO,
+	MT6357_ID_VCN18,
+	MT6357_ID_VCN28,
+	MT6357_ID_VCN33_BT,
+	MT6357_ID_VCN33_WIFI,
+	MT6357_ID_VDRAM,
+	MT6357_ID_VEFUSE,
+	MT6357_ID_VEMC,
+	MT6357_ID_VFE28,
+	MT6357_ID_VIBR,
+	MT6357_ID_VIO18,
+	MT6357_ID_VIO28,
+	MT6357_ID_VLDO28,
+	MT6357_ID_VMC,
+	MT6357_ID_VMCH,
+	MT6357_ID_VRF12,
+	MT6357_ID_VRF18,
+	MT6357_ID_VSIM1,
+	MT6357_ID_VSIM2,
+	MT6357_ID_VSRAM_OTHERS,
+	MT6357_ID_VSRAM_PROC,
+	MT6357_ID_VUSB33,
+	MT6357_ID_VXO22,
+
+	MT6357_ID_RG_MAX,
+};
+
+#define MT6357_MAX_REGULATOR	MT6357_ID_RG_MAX
+
+#endif /* __LINUX_REGULATOR_MT6357_H */

-- 
b4 0.10.1

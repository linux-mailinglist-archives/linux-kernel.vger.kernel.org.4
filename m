Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129066FB124
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 15:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234166AbjEHNQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 09:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234124AbjEHNP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 09:15:56 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5182FA3E;
        Mon,  8 May 2023 06:15:54 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3489YdRE003696;
        Mon, 8 May 2023 09:15:50 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3qdkt9b8d4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 May 2023 09:15:50 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 348DFn0Z053402
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 May 2023 09:15:49 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 8 May 2023
 09:15:48 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 8 May 2023 09:15:48 -0400
Received: from IST-LT-42339.ad.analog.com ([10.158.19.231])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 348DBdTK009014;
        Mon, 8 May 2023 09:15:37 -0400
From:   Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <sre@kernel.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <Zeynep.Arslanbenzer@analog.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Nurettin Bolucu <Nurettin.Bolucu@analog.com>
Subject: [PATCH v3 1/7] regulator: max77658: Add ADI MAX77643/54/58/59 Regulator Support
Date:   Mon, 8 May 2023 16:10:39 +0300
Message-ID: <20230508131045.9399-2-Zeynep.Arslanbenzer@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230508131045.9399-1-Zeynep.Arslanbenzer@analog.com>
References: <20230508131045.9399-1-Zeynep.Arslanbenzer@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 05JPMQVkTBXiXtcXqht1i4_H5FQhTLy6
X-Proofpoint-ORIG-GUID: 05JPMQVkTBXiXtcXqht1i4_H5FQhTLy6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-08_09,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2305080089
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regulator driver for ADI MAX77643/54/58/59.

MAX77643/MAX77659 has 1 LDO regulator.
MAX77654/MAX77658 has two LDO regulators.

Signed-off-by: Nurettin Bolucu <Nurettin.Bolucu@analog.com>
Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
---
 drivers/regulator/Kconfig              |   8 ++
 drivers/regulator/Makefile             |   1 +
 drivers/regulator/max77658-regulator.c | 170 +++++++++++++++++++++++++
 3 files changed, 179 insertions(+)
 create mode 100644 drivers/regulator/max77658-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 820c9a0788e5..aba32f8be1a5 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -573,6 +573,14 @@ config REGULATOR_MAX77650
 	  Semiconductor. This device has a SIMO with three independent
 	  power rails and an LDO.
 
+config REGULATOR_MAX77658
+	tristate "Analog Devices MAX77643/54/58/59 Regulator"
+	depends on MFD_MAX77658
+	help
+	  Regulator driver for MAX77643/54/58/59 PMIC from Analog Devices.
+	  This driver supports LDO regulators.
+	  Say Y here to enable the regulator driver.
+
 config REGULATOR_MAX8649
 	tristate "Maxim 8649 voltage regulator"
 	depends on I2C
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index b9f5eb35bf5f..14b5f9fd75bf 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -70,6 +70,7 @@ obj-$(CONFIG_REGULATOR_MAX1586) += max1586.o
 obj-$(CONFIG_REGULATOR_MAX597X) += max597x-regulator.o
 obj-$(CONFIG_REGULATOR_MAX77620) += max77620-regulator.o
 obj-$(CONFIG_REGULATOR_MAX77650) += max77650-regulator.o
+obj-$(CONFIG_REGULATOR_MAX77658) += max77658-regulator.o
 obj-$(CONFIG_REGULATOR_MAX8649)	+= max8649.o
 obj-$(CONFIG_REGULATOR_MAX8660) += max8660.o
 obj-$(CONFIG_REGULATOR_MAX8893) += max8893.o
diff --git a/drivers/regulator/max77658-regulator.c b/drivers/regulator/max77658-regulator.c
new file mode 100644
index 000000000000..f8a98c79d5f0
--- /dev/null
+++ b/drivers/regulator/max77658-regulator.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 Analog Devices, Inc.
+ * ADI regulator driver for the MAX77643/54/58/59
+ */
+
+#include <linux/mfd/max77658.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/of_regulator.h>
+
+#define MAX77658_REG_MAX		2
+#define MAX77658_LDO_VOLT_REG_MAX	0x7F
+#define MAX77658_LDO_VOLT_N_RANGE	0x80
+#define MAX77658_LDO_VOLT_STEP		25000
+#define MAX77658_LDO_VOLT_BASE		500000
+#define MAX77654_LDO_VOLT_BASE		800000
+
+#define MAX77658_REG_CNFG_LDO0_A	0x48
+#define MAX77658_REG_CNFG_LDO0_B	0x49
+
+#define MAX77654_REG_CNFG_LDO0_A	0x38
+#define MAX77654_REG_CNFG_LDO0_B	0x39
+
+#define MAX77658_REG_CNFG_LDO1_A	0x4A
+#define MAX77658_REG_CNFG_LDO1_B	0x4B
+
+#define MAX77654_REG_CNFG_LDO1_A	0x3A
+#define MAX77654_REG_CNFG_LDO1_B	0x3B
+
+#define MAX77658_BITS_CONFIG_LDOX_A_TV_LDO	GENMASK(6, 0)
+#define MAX77658_BITS_CONFIG_LDOX_B_EN_LDO	GENMASK(2, 0)
+
+/*
+ * 0.500 to 3.675V (25mV step)
+ */
+static const struct linear_range MAX77658_LDO_volts[] = {
+	REGULATOR_LINEAR_RANGE(MAX77658_LDO_VOLT_BASE, 0x00,
+			       MAX77658_LDO_VOLT_REG_MAX,
+			       MAX77658_LDO_VOLT_STEP),
+};
+
+/*
+ * 0.800 to 3.975V (25mV step)
+ */
+static const struct linear_range MAX77654_LDO_volts[] = {
+	REGULATOR_LINEAR_RANGE(MAX77654_LDO_VOLT_BASE, 0x00,
+			       MAX77658_LDO_VOLT_REG_MAX,
+			       MAX77658_LDO_VOLT_STEP),
+};
+
+static const struct regulator_ops max77658_LDO_ops = {
+	.list_voltage	 = regulator_list_voltage_linear_range,
+	.map_voltage	 = regulator_map_voltage_ascend,
+	.is_enabled	 = regulator_is_enabled_regmap,
+	.enable		 = regulator_enable_regmap,
+	.disable	 = regulator_disable_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+};
+
+#define REGULATOR_DESC_LDO(num, volts, vsel_r, vsel_m, enable_r, enable_m) { \
+	.name			= "LDO"#num,				\
+	.id			= num,					\
+	.of_match		= of_match_ptr("LDO"#num),		\
+	.regulators_node	= of_match_ptr("regulators"),		\
+	.ops			= &max77658_LDO_ops,			\
+	.type			= REGULATOR_VOLTAGE,			\
+	.owner			= THIS_MODULE,				\
+	.linear_ranges		= volts,				\
+	.n_linear_ranges	= MAX77658_LDO_VOLT_N_RANGE,		\
+	.vsel_reg		= vsel_r,				\
+	.vsel_mask		= vsel_m,				\
+	.enable_reg		= enable_r,				\
+	.enable_mask		= enable_m,				\
+	.enable_val		= 0x06,					\
+	.disable_val		= 0x04,					\
+}
+
+static const struct regulator_desc max77643_ldo_desc[] = {
+	REGULATOR_DESC_LDO(0, MAX77658_LDO_volts, MAX77654_REG_CNFG_LDO0_A,
+			   MAX77658_BITS_CONFIG_LDOX_A_TV_LDO,
+			   MAX77654_REG_CNFG_LDO0_B,
+			   MAX77658_BITS_CONFIG_LDOX_B_EN_LDO),
+};
+
+static const struct regulator_desc max77654_ldo_desc[] = {
+	REGULATOR_DESC_LDO(0, MAX77654_LDO_volts, MAX77654_REG_CNFG_LDO0_A,
+			   MAX77658_BITS_CONFIG_LDOX_A_TV_LDO,
+			   MAX77654_REG_CNFG_LDO0_B,
+			   MAX77658_BITS_CONFIG_LDOX_B_EN_LDO),
+	REGULATOR_DESC_LDO(1, MAX77654_LDO_volts, MAX77654_REG_CNFG_LDO1_A,
+			   MAX77658_BITS_CONFIG_LDOX_A_TV_LDO,
+			   MAX77654_REG_CNFG_LDO1_B,
+			   MAX77658_BITS_CONFIG_LDOX_B_EN_LDO),
+};
+
+static const struct regulator_desc max77658_ldo_desc[] = {
+	REGULATOR_DESC_LDO(0, MAX77658_LDO_volts, MAX77658_REG_CNFG_LDO0_A,
+			   MAX77658_BITS_CONFIG_LDOX_A_TV_LDO,
+			   MAX77658_REG_CNFG_LDO0_B,
+			   MAX77658_BITS_CONFIG_LDOX_B_EN_LDO),
+	REGULATOR_DESC_LDO(1, MAX77658_LDO_volts, MAX77658_REG_CNFG_LDO1_A,
+			   MAX77658_BITS_CONFIG_LDOX_A_TV_LDO,
+			   MAX77658_REG_CNFG_LDO1_B,
+			   MAX77658_BITS_CONFIG_LDOX_B_EN_LDO),
+};
+
+static int max77658_regulator_probe(struct platform_device *pdev)
+{
+	struct max77658_dev *max77658 = dev_get_drvdata(pdev->dev.parent);
+	const struct regulator_desc *regulators;
+	struct regulator_config config = {};
+	struct regulator_dev *rdev;
+	int n_regulators = 0;
+	int i;
+
+	switch (max77658->id) {
+	case ID_MAX77643:
+	case ID_MAX77659:
+		regulators = max77643_ldo_desc;
+		n_regulators = ARRAY_SIZE(max77643_ldo_desc);
+		break;
+	case ID_MAX77654:
+		regulators = max77654_ldo_desc;
+		n_regulators = ARRAY_SIZE(max77654_ldo_desc);
+		break;
+	case ID_MAX77658:
+		regulators = max77658_ldo_desc;
+		n_regulators = ARRAY_SIZE(max77658_ldo_desc);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	config.dev = pdev->dev.parent;
+
+	for (i = 0; i < n_regulators; i++) {
+		rdev = devm_regulator_register(&pdev->dev, &regulators[i],
+					       &config);
+		if (IS_ERR(rdev)) {
+			dev_err(&pdev->dev, "Failed to register %s regulator\n",
+				regulators[i].name);
+			return PTR_ERR(rdev);
+		}
+	}
+
+	return 0;
+}
+
+static const struct platform_device_id max77658_regulator_id[] = {
+	{ "max77658-regulator" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, max77658_regulator_id);
+
+static struct platform_driver max77658_regulator_driver = {
+	.driver = {
+		.name = "max77658-regulator",
+	},
+	.probe = max77658_regulator_probe,
+	.id_table = max77658_regulator_id,
+};
+
+module_platform_driver(max77658_regulator_driver);
+
+MODULE_DESCRIPTION("MAX77658 Regulator Driver");
+MODULE_AUTHOR("Nurettin.Bolucu@analog.com, Zeynep.Arslanbenzer@analog.com");
+MODULE_LICENSE("GPL");
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7DB64562A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 10:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiLGJMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 04:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiLGJMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 04:12:14 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33372FC04;
        Wed,  7 Dec 2022 01:12:05 -0800 (PST)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B78URlJ003955;
        Wed, 7 Dec 2022 04:11:42 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3m816bfjyr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Dec 2022 04:11:41 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 2B79BeM2045869
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 7 Dec 2022 04:11:40 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 7 Dec 2022 04:11:39 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 7 Dec 2022 04:11:39 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 7 Dec 2022 04:11:37 -0500
Received: from okan.localdomain ([10.158.19.61])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 2B799G9X029801;
        Wed, 7 Dec 2022 04:11:17 -0500
From:   Okan Sahin <okan.sahin@analog.com>
To:     <outreachy@lists.linux.dev>
CC:     Okan Sahin <okan.sahin@analog.com>, Lee Jones <lee@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Manish Narani <manish.narani@xilinx.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: [PATCH 3/5] staging: drivers: regulator: Add MAX77541 Regulator Support
Date:   Wed, 7 Dec 2022 12:08:42 +0300
Message-ID: <20221207090906.5896-4-okan.sahin@analog.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221207090906.5896-1-okan.sahin@analog.com>
References: <20221207090906.5896-1-okan.sahin@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: _wawgfvLKz0bA9QpYWNq403yJl0YRfVH
X-Proofpoint-ORIG-GUID: _wawgfvLKz0bA9QpYWNq403yJl0YRfVH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_04,2022-12-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212070076
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds regulator driver for both MAX77541 and MAX77540.
The MAX77541 is a high-efficiency step-down converter
with two 3A switching phases for single-cell Li+ battery and 5VDC systems.

The MAX77540 is a high-efficiency step-down converter
with two 3A switching phases.

Signed-off-by: Okan Sahin <okan.sahin@analog.com>
---
 MAINTAINERS                            |   1 +
 drivers/regulator/Kconfig              |   9 ++
 drivers/regulator/Makefile             |   1 +
 drivers/regulator/max77541-regulator.c | 181 +++++++++++++++++++++++++
 4 files changed, 192 insertions(+)
 create mode 100644 drivers/regulator/max77541-regulator.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 22f5a9c490e3..5704ed5afce3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12503,6 +12503,7 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/mfd/adi,max77541.yaml
 F:	drivers/mfd/max77541.c
+F:	drivers/regulator/max77541-regulator.c
 F:	include/linux/mfd/max77541.h
 
 MAXIM MAX77650 PMIC MFD DRIVER
diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 070e4403c6c2..1e416c195af9 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -556,6 +556,15 @@ config REGULATOR_MAX597X
 	  The MAX5970/5978 is a smart switch with no output regulation, but
 	  fault protection and voltage and current monitoring capabilities.
 
+config REGULATOR_MAX77541
+	tristate "Analog Devices MAX77541/77540 Regulator"
+	depends on MFD_MAX77541
+	help
+	  This driver controls a Analog Devices MAX77541/77540 regulators
+	  via I2C bus. Both MAX77540 and MAX77541 are dual-phase
+	  high-efficiency buck converter. Say Y here to
+	  enable the regulator driver.
+
 config REGULATOR_MAX77620
 	tristate "Maxim 77620/MAX20024 voltage regulator"
 	depends on MFD_MAX77620 || COMPILE_TEST
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 5962307e1130..c19efc7cfbef 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -68,6 +68,7 @@ obj-$(CONFIG_REGULATOR_LTC3676) += ltc3676.o
 obj-$(CONFIG_REGULATOR_MAX14577) += max14577-regulator.o
 obj-$(CONFIG_REGULATOR_MAX1586) += max1586.o
 obj-$(CONFIG_REGULATOR_MAX597X) += max597x-regulator.o
+obj-$(CONFIG_REGULATOR_MAX77541) += max77541-regulator.o
 obj-$(CONFIG_REGULATOR_MAX77620) += max77620-regulator.o
 obj-$(CONFIG_REGULATOR_MAX77650) += max77650-regulator.o
 obj-$(CONFIG_REGULATOR_MAX8649)	+= max8649.o
diff --git a/drivers/regulator/max77541-regulator.c b/drivers/regulator/max77541-regulator.c
new file mode 100644
index 000000000000..9204b15f8eed
--- /dev/null
+++ b/drivers/regulator/max77541-regulator.c
@@ -0,0 +1,181 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022 Analog Devices, Inc.
+ * ADI Regulator driver for the MAX77540 and MAX77541
+ *
+ */
+
+#include <linux/i2c.h>
+#include <linux/mfd/max77541.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/of_regulator.h>
+
+static const struct regulator_ops max77541_buck_ops = {
+	.enable			= regulator_enable_regmap,
+	.disable		= regulator_disable_regmap,
+	.is_enabled		= regulator_is_enabled_regmap,
+	.list_voltage		= regulator_list_voltage_pickable_linear_range,
+	.get_voltage_sel	= regulator_get_voltage_sel_pickable_regmap,
+	.set_voltage_sel	= regulator_set_voltage_sel_pickable_regmap,
+};
+
+static const struct linear_range max77540_buck_ranges[] = {
+	/* Ranges when VOLT_SEL bits are 0x00 */
+	REGULATOR_LINEAR_RANGE(500000, 0x00, 0x8B, 5000),
+	REGULATOR_LINEAR_RANGE(1200000, 0x8C, 0xFF, 0),
+	/* Ranges when VOLT_SEL bits are 0x40 */
+	REGULATOR_LINEAR_RANGE(1200000, 0x00, 0x8B, 10000),
+	REGULATOR_LINEAR_RANGE(2400000, 0x8C, 0xFF, 0),
+	/* Ranges when VOLT_SEL bits are  0x80 */
+	REGULATOR_LINEAR_RANGE(2000000, 0x00, 0x9F, 20000),
+	REGULATOR_LINEAR_RANGE(5200000, 0xA0, 0xFF, 0),
+};
+
+static const struct linear_range max77541_buck_ranges[] = {
+	/* Ranges when VOLT_SEL bits are 0x00 */
+	REGULATOR_LINEAR_RANGE(300000, 0x00, 0xB3, 5000),
+	REGULATOR_LINEAR_RANGE(1200000, 0xB4, 0xFF, 0),
+	/* Ranges when VOLT_SEL bits are 0x40 */
+	REGULATOR_LINEAR_RANGE(1200000, 0x00, 0x8B, 10000),
+	REGULATOR_LINEAR_RANGE(2400000, 0x8C, 0xFF, 0),
+	/* Ranges when VOLT_SEL bits are  0x80 */
+	REGULATOR_LINEAR_RANGE(2000000, 0x00, 0x9F, 20000),
+	REGULATOR_LINEAR_RANGE(5200000, 0xA0, 0xFF, 0),
+};
+
+static const unsigned int max77541_buck_volt_range_sel[] = {
+	0x00, 0x00, 0x40, 0x40, 0x80, 0x80
+};
+
+#define MAX77540_BUCK(_id, _ops)					\
+	{	.id = MAX77541_BUCK ## _id,				\
+		.name = "BUCK"#_id,					\
+		.of_match = "BUCK"#_id,					\
+		.regulators_node = "regulators",			\
+		.enable_reg = MAX77541_REG_EN_CTRL,			\
+		.enable_mask = MAX77541_BIT_M ## _id ## _EN,		\
+		.ops = &(_ops),						\
+		.type = REGULATOR_VOLTAGE,				\
+		.linear_ranges = max77540_buck_ranges,			\
+		.n_linear_ranges = ARRAY_SIZE(max77540_buck_ranges),	\
+		.vsel_reg = MAX77541_REG_M ## _id ## _VOUT,		\
+		.vsel_mask = MAX77541_BITS_MX_VOUT,			\
+		.vsel_range_reg = MAX77541_REG_M ## _id ## _CFG1,	\
+		.vsel_range_mask = MAX77541_BITS_MX_CFG1_RNG,		\
+		.linear_range_selectors = max77541_buck_volt_range_sel, \
+		.owner = THIS_MODULE,					\
+	}
+
+#define MAX77541_BUCK(_id, _ops)					\
+	{	.id = MAX77541_BUCK ## _id,				\
+		.name = "BUCK"#_id,					\
+		.of_match = "BUCK"#_id,					\
+		.regulators_node = "regulators",			\
+		.enable_reg = MAX77541_REG_EN_CTRL,			\
+		.enable_mask = MAX77541_BIT_M ## _id ## _EN,		\
+		.ops = &(_ops),						\
+		.type = REGULATOR_VOLTAGE,				\
+		.linear_ranges = max77541_buck_ranges,			\
+		.n_linear_ranges = ARRAY_SIZE(max77541_buck_ranges),	\
+		.vsel_reg = MAX77541_REG_M ## _id ## _VOUT,		\
+		.vsel_mask = MAX77541_BITS_MX_VOUT,			\
+		.vsel_range_reg = MAX77541_REG_M ## _id ## _CFG1,	\
+		.vsel_range_mask = MAX77541_BITS_MX_CFG1_RNG,		\
+		.linear_range_selectors = max77541_buck_volt_range_sel, \
+		.owner = THIS_MODULE,					\
+	}
+
+static const struct regulator_desc max77540_regulators_desc[] = {
+	MAX77540_BUCK(1, max77541_buck_ops),
+	MAX77540_BUCK(2, max77541_buck_ops)
+};
+
+static const struct regulator_desc max77541_regulators_desc[] = {
+	MAX77541_BUCK(1, max77541_buck_ops),
+	MAX77541_BUCK(2, max77541_buck_ops)
+};
+
+struct max77541_regulator_dev {
+	struct device *dev;
+	struct max77541_dev *max77541;
+};
+
+static int max77541_regulator_probe(struct platform_device *pdev)
+{
+	struct max77541_dev *max77541 = dev_get_drvdata(pdev->dev.parent);
+	struct max77541_regulator_dev *regulator;
+	struct regulator_config config = {};
+	struct regulator_dev *rdev;
+	int i;
+
+	regulator = devm_kzalloc(&pdev->dev, sizeof(*regulator), GFP_KERNEL);
+	if (!regulator)
+		return -ENOMEM;
+
+	regulator->dev = &pdev->dev;
+	regulator->max77541 = max77541;
+
+	config.dev = pdev->dev.parent;
+	config.driver_data = regulator;
+	config.regmap = regulator->max77541->regmap;
+
+	for (i = 0; i < MAX77541_MAX_REGULATORS; i++) {
+		switch (regulator->max77541->type) {
+		case MAX77540:
+			rdev = devm_regulator_register(&pdev->dev,
+						       &max77540_regulators_desc[i], &config);
+			if (IS_ERR(rdev))
+				return dev_err_probe(&pdev->dev, PTR_ERR(rdev),
+							"Failed to register regulator\n");
+			break;
+		case MAX77541:
+			rdev = devm_regulator_register(&pdev->dev,
+						       &max77541_regulators_desc[i], &config);
+			if (IS_ERR(rdev))
+				return dev_err_probe(&pdev->dev, PTR_ERR(rdev),
+						"Failed to register regulator\n");
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static const struct platform_device_id max77541_regulator_platform_id[] = {
+	{ "max77540-regulator", MAX77540 },
+	{ "max77541-regulator", MAX77541 },
+	{  /* sentinel */  }
+};
+MODULE_DEVICE_TABLE(platform, max77541_regulator_platform_id);
+
+static const struct of_device_id max77541_regulator_of_id[] = {
+	{
+		.compatible = "adi,max77540-regulator",
+		.data = (void *)MAX77540,
+	},
+	{
+		.compatible = "adi,max77541-regulator",
+		.data = (void *)MAX77541,
+	},
+	{ /* sentinel */  }
+};
+MODULE_DEVICE_TABLE(of, max77541_regulator_of_id);
+
+static struct platform_driver max77541_regulator_driver = {
+	.driver = {
+		.name = "max77541-regulator",
+		.of_match_table = max77541_regulator_of_id,
+	},
+	.probe = max77541_regulator_probe,
+	.id_table = max77541_regulator_platform_id,
+};
+
+module_platform_driver(max77541_regulator_driver);
+
+MODULE_AUTHOR("Okan Sahin <Okan.Sahin@analog.com>");
+MODULE_DESCRIPTION("MAX77540/MAX77541 regulator driver");
+MODULE_LICENSE("GPL");
-- 
2.30.2


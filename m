Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2836ADD77
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 12:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjCGLcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 06:32:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjCGLci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 06:32:38 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2067C2E806;
        Tue,  7 Mar 2023 03:32:00 -0800 (PST)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 327AXCX5022869;
        Tue, 7 Mar 2023 06:31:03 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3p415c8sud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 06:31:03 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 327BV12X031985
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Mar 2023 06:31:01 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 7 Mar 2023
 06:31:00 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 7 Mar 2023 06:30:58 -0500
Received: from okan.localdomain (IST-LT-43126.ad.analog.com [10.25.36.20])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 327BSiLr011140;
        Tue, 7 Mar 2023 06:30:36 -0500
From:   Okan Sahin <okan.sahin@analog.com>
To:     <okan.sahin@analog.com>
CC:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Arnd Bergmann <arnd@arndb.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Haibo Chen <haibo.chen@nxp.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: [PATCH v6 2/5] regulator: max77541: Add ADI MAX77541/MAX77540 Regulator Support
Date:   Tue, 7 Mar 2023 14:28:12 +0300
Message-ID: <20230307112835.81886-3-okan.sahin@analog.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230307112835.81886-1-okan.sahin@analog.com>
References: <20230307112835.81886-1-okan.sahin@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: tG87OlVyv0foYK0NjxzYEyS1ooZz8JNx
X-Proofpoint-ORIG-GUID: tG87OlVyv0foYK0NjxzYEyS1ooZz8JNx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_06,2023-03-07_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 clxscore=1011 suspectscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303070103
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regulator driver for both MAX77541 and MAX77540.
The MAX77541 is a high-efficiency step-down converter
with two 3A switching phases for single-cell Li+ battery
and 5VDC systems.

The MAX77540 is a high-efficiency step-down converter
with two 3A switching phases.

Signed-off-by: Okan Sahin <okan.sahin@analog.com>
---
 drivers/regulator/Kconfig              |   9 ++
 drivers/regulator/Makefile             |   1 +
 drivers/regulator/max77541-regulator.c | 153 +++++++++++++++++++++++++
 3 files changed, 163 insertions(+)
 create mode 100644 drivers/regulator/max77541-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index aae28d0a489c..f0418274c083 100644
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
index ee383d8fc835..1c852f3140a3 100644
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
index 000000000000..f99caf3f3990
--- /dev/null
+++ b/drivers/regulator/max77541-regulator.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022 Analog Devices, Inc.
+ * ADI Regulator driver for the MAX77540 and MAX77541
+ */
+
+#include <linux/mfd/max77541.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
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
+	0x00, 0x00, 0x40, 0x40, 0x80, 0x80,
+};
+
+enum max77541_regulators {
+	MAX77541_BUCK1 = 1,
+	MAX77541_BUCK2,
+};
+
+#define MAX77540_BUCK(_id, _ops)					\
+	{	.id = MAX77541_BUCK ## _id,				\
+		.name = "buck"#_id,					\
+		.of_match = "buck"#_id,					\
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
+		.name = "buck"#_id,					\
+		.of_match = "buck"#_id,					\
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
+	MAX77540_BUCK(2, max77541_buck_ops),
+};
+
+static const struct regulator_desc max77541_regulators_desc[] = {
+	MAX77541_BUCK(1, max77541_buck_ops),
+	MAX77541_BUCK(2, max77541_buck_ops),
+};
+
+static int max77541_regulator_probe(struct platform_device *pdev)
+{
+	struct regulator_config config = {};
+	const struct regulator_desc *desc;
+	struct device *dev = &pdev->dev;
+	struct regulator_dev *rdev;
+	struct max77541 *max77541 = dev_get_drvdata(dev->parent);
+	unsigned int i;
+
+	config.dev = dev->parent;
+
+	switch (max77541->chip->id) {
+	case MAX77540:
+		desc = max77540_regulators_desc;
+		break;
+	case MAX77541:
+		desc = max77541_regulators_desc;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	for (i = 0; i < MAX77541_MAX_REGULATORS; i++) {
+		rdev = devm_regulator_register(dev, &desc[i], &config);
+		if (IS_ERR(rdev))
+			return dev_err_probe(dev, PTR_ERR(rdev),
+					     "Failed to register regulator\n");
+	}
+
+	return 0;
+}
+
+static const struct platform_device_id max77541_regulator_platform_id[] = {
+	{ "max77540-regulator" },
+	{ "max77541-regulator" },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, max77541_regulator_platform_id);
+
+static struct platform_driver max77541_regulator_driver = {
+	.driver = {
+		.name = "max77541-regulator",
+	},
+	.probe = max77541_regulator_probe,
+	.id_table = max77541_regulator_platform_id,
+};
+module_platform_driver(max77541_regulator_driver);
+
+MODULE_AUTHOR("Okan Sahin <Okan.Sahin@analog.com>");
+MODULE_DESCRIPTION("MAX77540/MAX77541 regulator driver");
+MODULE_LICENSE("GPL");
-- 
2.30.2


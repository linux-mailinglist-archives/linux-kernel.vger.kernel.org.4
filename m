Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9A0656587
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 23:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbiLZWlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 17:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbiLZWkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 17:40:36 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F2A5FCA
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 14:39:28 -0800 (PST)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BQIMKKH019565;
        Mon, 26 Dec 2022 17:39:26 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3mny7a203f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Dec 2022 17:39:25 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 2BQMdORb000559
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Dec 2022 17:39:24 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 26 Dec
 2022 17:39:23 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 26 Dec 2022 17:39:23 -0500
Received: from okan.localdomain ([10.158.19.61])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 2BQMcuAc032340;
        Mon, 26 Dec 2022 17:39:15 -0500
From:   Okan Sahin <okan.sahin@analog.com>
To:     <okan.sahin@analog.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/5] drivers: regulator: Add MAX77541 Regulator Support
Date:   Tue, 27 Dec 2022 01:38:37 +0300
Message-ID: <20221226223839.103460-4-okan.sahin@analog.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221226223839.103460-1-okan.sahin@analog.com>
References: <20221226223839.103460-1-okan.sahin@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: r72Y9YLjecm_tPTXW3DV5NqPIyZrzIQ_
X-Proofpoint-GUID: r72Y9YLjecm_tPTXW3DV5NqPIyZrzIQ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-26_18,2022-12-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212260192
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
 MAINTAINERS                            |   1 +
 drivers/regulator/Kconfig              |   9 ++
 drivers/regulator/Makefile             |   1 +
 drivers/regulator/max77541-regulator.c | 161 +++++++++++++++++++++++++
 4 files changed, 172 insertions(+)
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
index 000000000000..c1c5dba50ca2
--- /dev/null
+++ b/drivers/regulator/max77541-regulator.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022 Analog Devices, Inc.
+ * ADI Regulator driver for the MAX77540 and MAX77541
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
+	0x00, 0x00, 0x40, 0x40, 0x80, 0x80,
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
+	struct max77541_dev *max77541 = dev_get_drvdata(pdev->dev.parent);
+	struct regulator_config config = {};
+	const struct regulator_desc *desc;
+	struct device *dev = &pdev->dev;
+	struct regulator_dev *rdev;
+	int i;
+
+	config.dev = pdev->dev.parent;
+
+	if (max77541->id == MAX77540)
+		desc = max77540_regulators_desc;
+	else if (max77541->id == MAX77541)
+		desc = max77541_regulators_desc;
+	else
+		return -EINVAL;
+
+	for (i = 0; i < MAX77541_MAX_REGULATORS; i++) {
+		rdev = devm_regulator_register(dev,
+					       &desc[i], &config);
+		if (IS_ERR(rdev))
+			return dev_err_probe(dev, PTR_ERR(rdev),
+					     "Failed to register regulator\n");
+		break;
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
+module_platform_driver(max77541_regulator_driver);
+
+MODULE_AUTHOR("Okan Sahin <Okan.Sahin@analog.com>");
+MODULE_DESCRIPTION("MAX77540/MAX77541 regulator driver");
+MODULE_LICENSE("GPL");
-- 
2.30.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E41652186
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 14:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbiLTN10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 08:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233776AbiLTN0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 08:26:50 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DD21AA35;
        Tue, 20 Dec 2022 05:26:44 -0800 (PST)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BKCPgi0021847;
        Tue, 20 Dec 2022 08:26:41 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3mk9nd178s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Dec 2022 08:26:41 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 2BKDQdwA044100
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Dec 2022 08:26:39 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 20 Dec 2022 08:26:39 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 20 Dec 2022 08:26:38 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 20 Dec 2022 08:26:38 -0500
Received: from IST-LT-42339.ad.analog.com (IST-LT-42339.ad.analog.com [10.117.192.221])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 2BKDNoP7010583;
        Tue, 20 Dec 2022 08:26:24 -0500
From:   Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <sre@kernel.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <Zeynep.Arslanbenzer@analog.com>, <Nurettin.Bolucu@analog.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH 5/6] drivers: regulator: add MAX77659 regulator support
Date:   Tue, 20 Dec 2022 16:22:49 +0300
Message-ID: <20221220132250.19383-6-Zeynep.Arslanbenzer@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221220132250.19383-1-Zeynep.Arslanbenzer@analog.com>
References: <20221220132250.19383-1-Zeynep.Arslanbenzer@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: BEagy2zEdx_Ai5aai5U6plXMSV2Y5fca
X-Proofpoint-ORIG-GUID: BEagy2zEdx_Ai5aai5U6plXMSV2Y5fca
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-20_05,2022-12-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212200110
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds regulator driver for MAX77659.

Signed-off-by: Nurettin Bolucu <Nurettin.Bolucu@analog.com>
Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
---
 MAINTAINERS                            |  1 +
 drivers/regulator/Kconfig              |  8 +++
 drivers/regulator/Makefile             |  1 +
 drivers/regulator/max77659-regulator.c | 98 ++++++++++++++++++++++++++
 4 files changed, 108 insertions(+)
 create mode 100644 drivers/regulator/max77659-regulator.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5cb8fa452f2d..13c062a8cda2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12649,6 +12649,7 @@ F:	Documentation/devicetree/bindings/mfd/adi,max77659.yaml
 F:	Documentation/devicetree/bindings/power/supply/adi,max77659-charger.yaml
 F:	drivers/mfd/max77659.c
 F:	drivers/power/supply/max77659-charger.c
+F:	drivers/regulator/max77659-regulator.c
 F:	include/linux/mfd/max77659.h
 
 MAXIM MAX77714 PMIC MFD DRIVER
diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 820c9a0788e5..4a9852c7050f 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -573,6 +573,14 @@ config REGULATOR_MAX77650
 	  Semiconductor. This device has a SIMO with three independent
 	  power rails and an LDO.
 
+config REGULATOR_MAX77659
+	tristate "Analog Devices MAX77659 Regulator"
+	depends on MFD_MAX77659
+	help
+	  Regulator driver for MAX77659 PMIC from Analog Devices.
+	  This driver supports an LDO regulator.
+	  Say Y here to enable the regulator driver.
+
 config REGULATOR_MAX8649
 	tristate "Maxim 8649 voltage regulator"
 	depends on I2C
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index b9f5eb35bf5f..a7e91b56fb3f 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -70,6 +70,7 @@ obj-$(CONFIG_REGULATOR_MAX1586) += max1586.o
 obj-$(CONFIG_REGULATOR_MAX597X) += max597x-regulator.o
 obj-$(CONFIG_REGULATOR_MAX77620) += max77620-regulator.o
 obj-$(CONFIG_REGULATOR_MAX77650) += max77650-regulator.o
+obj-$(CONFIG_REGULATOR_MAX77659) += max77659-regulator.o
 obj-$(CONFIG_REGULATOR_MAX8649)	+= max8649.o
 obj-$(CONFIG_REGULATOR_MAX8660) += max8660.o
 obj-$(CONFIG_REGULATOR_MAX8893) += max8893.o
diff --git a/drivers/regulator/max77659-regulator.c b/drivers/regulator/max77659-regulator.c
new file mode 100644
index 000000000000..03a565013851
--- /dev/null
+++ b/drivers/regulator/max77659-regulator.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/mfd/max77659.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/power_supply.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/of_regulator.h>
+
+#define MAX77659_LDO_VOLT_REG_MAX 0x7F
+#define MAX77659_LDO_VOLT_N_RANGE 0x80
+#define MAX77659_LDO_VOLT_STEP 25000
+#define MAX77659_LDO_VOLT_BASE 500000
+
+#define MAX77659_REG_CNFG_LDO0_A 0x38
+#define MAX77659_REG_CNFG_LDO0_B 0x39
+
+#define MAX77659_BITS_CONFIG_LDO0_A_TV_LDO GENMASK(6, 0)
+#define MAX77659_BITS_CONFIG_LDO0_B_EN_LDO GENMASK(2, 0)
+
+/*
+ * 0.500 to 3.675V (25mV step)
+ */
+static const struct linear_range MAX77659_LDO_volts[] = {
+	REGULATOR_LINEAR_RANGE(MAX77659_LDO_VOLT_BASE, 0x00, MAX77659_LDO_VOLT_REG_MAX,
+			       MAX77659_LDO_VOLT_STEP),
+};
+
+static const struct regulator_ops max77659_LDO_ops = {
+	.list_voltage	 = regulator_list_voltage_linear_range,
+	.map_voltage	 = regulator_map_voltage_ascend,
+	.is_enabled	 = regulator_is_enabled_regmap,
+	.enable		 = regulator_enable_regmap,
+	.disable	 = regulator_disable_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+};
+
+static struct regulator_desc max77659_LDO_desc = {
+	.name		 = "LDO",
+	.id		 = 0,
+	.regulators_node = of_match_ptr("regulator"),
+	.ops		 = &max77659_LDO_ops,
+	.type		 = REGULATOR_VOLTAGE,
+	.owner		 = THIS_MODULE,
+	.n_linear_ranges = MAX77659_LDO_VOLT_N_RANGE,
+	.linear_ranges	 = MAX77659_LDO_volts,
+	.vsel_reg	 = MAX77659_REG_CNFG_LDO0_A,
+	.vsel_mask	 = MAX77659_BITS_CONFIG_LDO0_A_TV_LDO,
+	.enable_reg	 = MAX77659_REG_CNFG_LDO0_B,
+	.enable_mask	 = MAX77659_BITS_CONFIG_LDO0_B_EN_LDO,
+	.enable_val	 = 0x06,
+	.disable_val	 = 0x04,
+};
+
+static int max77659_regulator_probe(struct platform_device *pdev)
+{
+	struct regulator_dev *rdev;
+	struct regulator_config config = {};
+
+	config.dev = &pdev->dev;
+
+	rdev = devm_regulator_register(&pdev->dev, &max77659_LDO_desc, &config);
+
+	if (IS_ERR(rdev))
+		return dev_err_probe(&pdev->dev, PTR_ERR(rdev),
+				     "Failed to register regulator %s\n", max77659_LDO_desc.name);
+
+	return 0;
+}
+
+static const struct of_device_id max77659_regulator_of_id[] = {
+	{ .compatible = "adi,max77659-regulator" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, max77659_regulator_of_id);
+
+static const struct platform_device_id max77659_regulator_id[] = {
+	{ MAX77659_REGULATOR_NAME, 0, },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, max77659_regulator_id);
+
+static struct platform_driver max77659_regulator_driver = {
+	.driver = {
+		.name = MAX77659_REGULATOR_NAME,
+		.of_match_table = of_match_ptr(max77659_regulator_of_id),
+	},
+	.probe = max77659_regulator_probe,
+	.id_table = max77659_regulator_id,
+};
+
+module_platform_driver(max77659_regulator_driver);
+
+MODULE_DESCRIPTION("max77659 Regulator Driver");
+MODULE_AUTHOR("Nurettin.Bolucu@analog.com, Zeynep.Arslanbenzer@analog.com");
+MODULE_LICENSE("GPL");
+MODULE_VERSION("1.0");
-- 
2.25.1


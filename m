Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9122B6DF518
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjDLMYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbjDLMYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:24:38 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2125D6A66;
        Wed, 12 Apr 2023 05:24:27 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33C8jYhl002843;
        Wed, 12 Apr 2023 07:16:09 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3pu248y0nk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 07:16:08 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 33CBG7wP001540
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Apr 2023 07:16:07 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 12 Apr 2023 07:16:06 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 12 Apr 2023 07:16:06 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 12 Apr 2023 07:16:06 -0400
Received: from okan.localdomain ([10.158.19.61])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 33CBD6Du007710;
        Wed, 12 Apr 2023 07:15:48 -0400
From:   Okan Sahin <okan.sahin@analog.com>
To:     <okan.sahin@analog.com>
CC:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Caleb Connolly" <caleb.connolly@linaro.org>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: [PATCH v7 5/5] mfd: max77541: Add ADI MAX77541/MAX77540 PMIC Support
Date:   Wed, 12 Apr 2023 14:12:46 +0300
Message-ID: <20230412111256.40013-6-okan.sahin@analog.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230412111256.40013-1-okan.sahin@analog.com>
References: <20230412111256.40013-1-okan.sahin@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 4MQjiVZMutOeJwSP2JGKC-DptJ9BEErn
X-Proofpoint-GUID: 4MQjiVZMutOeJwSP2JGKC-DptJ9BEErn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_03,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0 suspectscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304120099
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MFD driver for MAX77541/MAX77540 to enable its sub
devices.

The MAX77541 is a multi-function devices. It includes
buck converter and ADC.

The MAX77540 is a high-efficiency buck converter
with two 3A switching phases.

They have same regmap except for ADC part of MAX77541.

Signed-off-by: Okan Sahin <okan.sahin@analog.com>
---
 drivers/mfd/Kconfig          |  13 ++
 drivers/mfd/Makefile         |   1 +
 drivers/mfd/max77541.c       | 224 +++++++++++++++++++++++++++++++++++
 include/linux/mfd/max77541.h |  91 ++++++++++++++
 4 files changed, 329 insertions(+)
 create mode 100644 drivers/mfd/max77541.c
 create mode 100644 include/linux/mfd/max77541.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index fcc141e067b9..de89245ce1cb 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -777,6 +777,19 @@ config MFD_MAX14577
 	  additional drivers must be enabled in order to use the functionality
 	  of the device.
 
+config MFD_MAX77541
+	tristate "Analog Devices MAX77541/77540 PMIC Support"
+	depends on I2C=y
+	select MFD_CORE
+	select REGMAP_I2C
+	select REGMAP_IRQ
+	help
+	  Say yes here to add support for Analog Devices MAX77541 and
+	  MAX77540 Power Management ICs. This driver provides
+	  common support for accessing the device; additional drivers
+	  must be enabled in order to use the functionality of the device.
+	  There are regulators and adc.
+
 config MFD_MAX77620
 	bool "Maxim Semiconductor MAX77620 and MAX20024 PMIC Support"
 	depends on I2C=y
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 2f6c89d1e277..1c8540ddead6 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -151,6 +151,7 @@ obj-$(CONFIG_MFD_DA9063)	+= da9063.o
 obj-$(CONFIG_MFD_DA9150)	+= da9150-core.o
 
 obj-$(CONFIG_MFD_MAX14577)	+= max14577.o
+obj-$(CONFIG_MFD_MAX77541)	+= max77541.o
 obj-$(CONFIG_MFD_MAX77620)	+= max77620.o
 obj-$(CONFIG_MFD_MAX77650)	+= max77650.o
 obj-$(CONFIG_MFD_MAX77686)	+= max77686.o
diff --git a/drivers/mfd/max77541.c b/drivers/mfd/max77541.c
new file mode 100644
index 000000000000..4a3bad3493b3
--- /dev/null
+++ b/drivers/mfd/max77541.c
@@ -0,0 +1,224 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022 Analog Devices, Inc.
+ * Driver for the MAX77540 and MAX77541
+ */
+
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/max77541.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+
+static const struct regmap_config max77541_regmap_config = {
+	.reg_bits   = 8,
+	.val_bits   = 8,
+};
+
+static const struct regmap_irq max77541_src_irqs[] = {
+	{ .mask = MAX77541_BIT_INT_SRC_TOPSYS },
+	{ .mask = MAX77541_BIT_INT_SRC_BUCK },
+};
+
+static const struct regmap_irq_chip max77541_src_irq_chip = {
+	.name		= "max77541-src",
+	.status_base	= MAX77541_REG_INT_SRC,
+	.mask_base	= MAX77541_REG_INT_SRC_M,
+	.num_regs	= 1,
+	.irqs		= max77541_src_irqs,
+	.num_irqs       = ARRAY_SIZE(max77541_src_irqs),
+};
+
+static const struct regmap_irq max77541_topsys_irqs[] = {
+	{ .mask = MAX77541_BIT_TOPSYS_INT_TJ_120C },
+	{ .mask = MAX77541_BIT_TOPSYS_INT_TJ_140C },
+	{ .mask = MAX77541_BIT_TOPSYS_INT_TSHDN },
+	{ .mask = MAX77541_BIT_TOPSYS_INT_UVLO },
+	{ .mask = MAX77541_BIT_TOPSYS_INT_ALT_SWO },
+	{ .mask = MAX77541_BIT_TOPSYS_INT_EXT_FREQ_DET },
+};
+
+static const struct regmap_irq_chip max77541_topsys_irq_chip = {
+	.name		= "max77541-topsys",
+	.status_base	= MAX77541_REG_TOPSYS_INT,
+	.mask_base	= MAX77541_REG_TOPSYS_INT_M,
+	.num_regs	= 1,
+	.irqs		= max77541_topsys_irqs,
+	.num_irqs	= ARRAY_SIZE(max77541_topsys_irqs),
+};
+
+static const struct regmap_irq max77541_buck_irqs[] = {
+	{ .mask = MAX77541_BIT_BUCK_INT_M1_POK_FLT },
+	{ .mask = MAX77541_BIT_BUCK_INT_M2_POK_FLT },
+	{ .mask = MAX77541_BIT_BUCK_INT_M1_SCFLT },
+	{ .mask = MAX77541_BIT_BUCK_INT_M2_SCFLT },
+};
+
+static const struct regmap_irq_chip max77541_buck_irq_chip = {
+	.name		= "max77541-buck",
+	.status_base	= MAX77541_REG_BUCK_INT,
+	.mask_base	= MAX77541_REG_BUCK_INT_M,
+	.num_regs	= 1,
+	.irqs		= max77541_buck_irqs,
+	.num_irqs	= ARRAY_SIZE(max77541_buck_irqs),
+};
+
+static const struct regmap_irq max77541_adc_irqs[] = {
+	{ .mask = MAX77541_BIT_ADC_INT_CH1_I },
+	{ .mask = MAX77541_BIT_ADC_INT_CH2_I },
+	{ .mask = MAX77541_BIT_ADC_INT_CH3_I },
+	{ .mask = MAX77541_BIT_ADC_INT_CH6_I },
+};
+
+static const struct regmap_irq_chip max77541_adc_irq_chip = {
+	.name		= "max77541-adc",
+	.status_base	= MAX77541_REG_ADC_INT,
+	.mask_base	= MAX77541_REG_ADC_INT_M,
+	.num_regs	= 1,
+	.irqs		= max77541_adc_irqs,
+	.num_irqs	= ARRAY_SIZE(max77541_adc_irqs),
+};
+
+static const struct mfd_cell max77540_devs[] = {
+	MFD_CELL_OF("max77540-regulator", NULL, NULL, 0, 0, NULL),
+};
+
+static const struct mfd_cell max77541_devs[] = {
+	MFD_CELL_OF("max77541-regulator", NULL, NULL, 0, 0, NULL),
+	MFD_CELL_OF("max77541-adc", NULL, NULL, 0, 0, NULL),
+};
+
+static int max77541_pmic_irq_init(struct device *dev)
+{
+	struct max77541 *max77541 = dev_get_drvdata(dev);
+	int irq = max77541->i2c->irq;
+	int ret;
+
+	ret = devm_regmap_add_irq_chip(dev, max77541->regmap, irq,
+				       IRQF_ONESHOT | IRQF_SHARED, 0,
+				       &max77541_src_irq_chip,
+				       &max77541->irq_data);
+	if (ret)
+		return ret;
+
+	ret = devm_regmap_add_irq_chip(dev, max77541->regmap, irq,
+				       IRQF_ONESHOT | IRQF_SHARED, 0,
+				       &max77541_topsys_irq_chip,
+				       &max77541->irq_topsys);
+	if (ret)
+		return ret;
+
+	ret = devm_regmap_add_irq_chip(dev, max77541->regmap, irq,
+				       IRQF_ONESHOT | IRQF_SHARED, 0,
+				       &max77541_buck_irq_chip,
+				       &max77541->irq_buck);
+	if (ret)
+		return ret;
+
+	if (max77541->id == MAX77541) {
+		ret = devm_regmap_add_irq_chip(dev, max77541->regmap, irq,
+					       IRQF_ONESHOT | IRQF_SHARED, 0,
+					       &max77541_adc_irq_chip,
+					       &max77541->irq_adc);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int max77541_pmic_setup(struct device *dev)
+{
+	struct max77541 *max77541 = dev_get_drvdata(dev);
+	const struct mfd_cell *cells;
+	int n_devs;
+	int ret;
+
+	switch (max77541->id) {
+	case MAX77540:
+		cells =  max77540_devs;
+		n_devs = ARRAY_SIZE(max77540_devs);
+		break;
+	case MAX77541:
+		cells =  max77541_devs;
+		n_devs = ARRAY_SIZE(max77541_devs);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = max77541_pmic_irq_init(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to initialize IRQ\n");
+
+	ret = device_init_wakeup(dev, true);
+	if (ret)
+		return dev_err_probe(dev, ret, "Unable to init wakeup\n");
+
+	return devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
+				    cells, n_devs, NULL, 0, NULL);
+}
+
+static int max77541_probe(struct i2c_client *client)
+{
+	const struct i2c_device_id *id = i2c_client_get_device_id(client);
+	struct device *dev = &client->dev;
+	struct max77541 *max77541;
+
+	max77541 = devm_kzalloc(dev, sizeof(*max77541), GFP_KERNEL);
+	if (!max77541)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, max77541);
+	max77541->i2c = client;
+
+	max77541->id  = (enum max7754x_ids)device_get_match_data(dev);
+	if (!max77541->id)
+		max77541->id  = (enum max7754x_ids)id->driver_data;
+
+	if (!max77541->id)
+		return -EINVAL;
+
+	max77541->regmap = devm_regmap_init_i2c(client,
+						&max77541_regmap_config);
+	if (IS_ERR(max77541->regmap))
+		return dev_err_probe(dev, PTR_ERR(max77541->regmap),
+				     "Failed to allocate register map\n");
+
+	return max77541_pmic_setup(dev);
+}
+
+static const struct of_device_id max77541_of_id[] = {
+	{
+		.compatible = "adi,max77540",
+		.data = (void *)MAX77540,
+	},
+	{
+		.compatible = "adi,max77541",
+		.data = (void *)MAX77541,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max77541_of_id);
+
+static const struct i2c_device_id max77541_id[] = {
+	{ "max77540", MAX77540 },
+	{ "max77541", MAX77541 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, max77541_id);
+
+static struct i2c_driver max77541_driver = {
+	.driver = {
+		.name = "max77541",
+		.of_match_table = max77541_of_id,
+	},
+	.probe_new = max77541_probe,
+	.id_table = max77541_id,
+};
+module_i2c_driver(max77541_driver);
+
+MODULE_DESCRIPTION("MAX7740/MAX7741 Driver");
+MODULE_AUTHOR("Okan Sahin <okan.sahin@analog.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/max77541.h b/include/linux/mfd/max77541.h
new file mode 100644
index 000000000000..fe5c0a3dc637
--- /dev/null
+++ b/include/linux/mfd/max77541.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef __MFD_MAX77541_H
+#define __MFD_MAX77541_H
+
+#include <linux/bits.h>
+#include <linux/types.h>
+
+/* REGISTERS */
+#define MAX77541_REG_INT_SRC                    0x00
+#define MAX77541_REG_INT_SRC_M                  0x01
+
+#define MAX77541_BIT_INT_SRC_TOPSYS             BIT(0)
+#define MAX77541_BIT_INT_SRC_BUCK               BIT(1)
+
+#define MAX77541_REG_TOPSYS_INT                 0x02
+#define MAX77541_REG_TOPSYS_INT_M               0x03
+
+#define MAX77541_BIT_TOPSYS_INT_TJ_120C         BIT(0)
+#define MAX77541_BIT_TOPSYS_INT_TJ_140C         BIT(1)
+#define MAX77541_BIT_TOPSYS_INT_TSHDN           BIT(2)
+#define MAX77541_BIT_TOPSYS_INT_UVLO            BIT(3)
+#define MAX77541_BIT_TOPSYS_INT_ALT_SWO         BIT(4)
+#define MAX77541_BIT_TOPSYS_INT_EXT_FREQ_DET    BIT(5)
+
+/* REGULATORS */
+#define MAX77541_REG_BUCK_INT                   0x20
+#define MAX77541_REG_BUCK_INT_M                 0x21
+
+#define MAX77541_BIT_BUCK_INT_M1_POK_FLT        BIT(0)
+#define MAX77541_BIT_BUCK_INT_M2_POK_FLT        BIT(1)
+#define MAX77541_BIT_BUCK_INT_M1_SCFLT          BIT(4)
+#define MAX77541_BIT_BUCK_INT_M2_SCFLT          BIT(5)
+
+#define MAX77541_REG_EN_CTRL                    0x0B
+
+#define MAX77541_BIT_M1_EN                      BIT(0)
+#define MAX77541_BIT_M2_EN                      BIT(1)
+
+#define MAX77541_REG_M1_VOUT                    0x23
+#define MAX77541_REG_M2_VOUT                    0x33
+
+#define MAX77541_BITS_MX_VOUT                   GENMASK(7, 0)
+
+#define MAX77541_REG_M1_CFG1                    0x25
+#define MAX77541_REG_M2_CFG1                    0x35
+
+#define MAX77541_BITS_MX_CFG1_RNG               GENMASK(7, 6)
+
+/* ADC */
+#define MAX77541_REG_ADC_INT                    0x70
+#define MAX77541_REG_ADC_INT_M                  0x71
+
+#define MAX77541_BIT_ADC_INT_CH1_I              BIT(0)
+#define MAX77541_BIT_ADC_INT_CH2_I              BIT(1)
+#define MAX77541_BIT_ADC_INT_CH3_I              BIT(2)
+#define MAX77541_BIT_ADC_INT_CH6_I              BIT(5)
+
+#define MAX77541_REG_ADC_DATA_CH1               0x72
+#define MAX77541_REG_ADC_DATA_CH2               0x73
+#define MAX77541_REG_ADC_DATA_CH3               0x74
+#define MAX77541_REG_ADC_DATA_CH6               0x77
+
+/* INTERRUPT MASKS*/
+#define MAX77541_REG_INT_SRC_MASK               0x00
+#define MAX77541_REG_TOPSYS_INT_MASK            0x00
+#define MAX77541_REG_BUCK_INT_MASK              0x00
+
+#define MAX77541_MAX_REGULATORS 2
+
+enum max7754x_ids {
+	MAX77540 = 1,
+	MAX77541,
+};
+
+struct regmap;
+struct regmap_irq_chip_data;
+struct i2c_client;
+
+struct max77541 {
+	struct i2c_client *i2c;
+	struct regmap *regmap;
+	enum max7754x_ids id;
+
+	struct regmap_irq_chip_data *irq_data;
+	struct regmap_irq_chip_data *irq_buck;
+	struct regmap_irq_chip_data *irq_topsys;
+	struct regmap_irq_chip_data *irq_adc;
+};
+
+#endif /* __MFD_MAX77541_H */
-- 
2.30.2


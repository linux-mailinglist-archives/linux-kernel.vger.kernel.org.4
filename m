Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE14972DC07
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240979AbjFMIH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234993AbjFMIHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:07:25 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BC4E4E;
        Tue, 13 Jun 2023 01:07:23 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35D6Ge1K013134;
        Tue, 13 Jun 2023 04:07:19 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3r4p34ynr8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 04:07:19 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 35D87IUt053015
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Jun 2023 04:07:18 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 13 Jun
 2023 04:07:17 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 13 Jun 2023 04:07:17 -0400
Received: from okan.localdomain (IST-LT-43126.ad.analog.com [10.25.36.16] (may be forged))
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 35D8678C017091;
        Tue, 13 Jun 2023 04:06:42 -0400
From:   Okan Sahin <okan.sahin@analog.com>
To:     <okan.sahin@analog.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v1 2/2] regulator: max77857: Add ADI MAX77857/MAX77831 Regulator Support
Date:   Tue, 13 Jun 2023 11:05:50 +0300
Message-ID: <20230613080552.4492-3-okan.sahin@analog.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230613080552.4492-1-okan.sahin@analog.com>
References: <20230613080552.4492-1-okan.sahin@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: Bc7GsdujKl-kPU9qYZIkWbTi53RJR1qX
X-Proofpoint-ORIG-GUID: Bc7GsdujKl-kPU9qYZIkWbTi53RJR1qX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_04,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306130070
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regulator driver for both MAX77857 and MAX77831.
The MAX77857 is a high-efficiency, high-performance
buck-boost converter targeted for systems requiring
a wide input voltage range (2.5V to 16V).

The MAX77831 is a high-efficiency, high-performance
buck-boost converter targeted for systems requiring
wide input voltage range (2.5V to 16V).

Signed-off-by: Okan Sahin <okan.sahin@analog.com>
---
 drivers/regulator/Kconfig              |   9 +
 drivers/regulator/Makefile             |   1 +
 drivers/regulator/max77857-regulator.c | 382 +++++++++++++++++++++++++
 3 files changed, 392 insertions(+)
 create mode 100644 drivers/regulator/max77857-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index e5f3613c15fa..68c9ef61ae52 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -573,6 +573,15 @@ config REGULATOR_MAX77650
 	  Semiconductor. This device has a SIMO with three independent
 	  power rails and an LDO.
 
+config REGULATOR_MAX77857
+	tristate "ADI MAX77857/MAX77831 regulator support"
+	depends on I2C
+	help
+	  This driver controls a ADI MAX77857 and MAX77831 regulators.
+	  via I2C bus. MAX77857 and MAX77831 are high efficiency buck-boost
+	  converters with input voltage range (2.5V to 16V). Say Y here to
+	  enable the regulator driver
+
 config REGULATOR_MAX8649
 	tristate "Maxim 8649 voltage regulator"
 	depends on I2C
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 58dfe0147cd4..e7230846b680 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -85,6 +85,7 @@ obj-$(CONFIG_REGULATOR_MAX77686) += max77686-regulator.o
 obj-$(CONFIG_REGULATOR_MAX77693) += max77693-regulator.o
 obj-$(CONFIG_REGULATOR_MAX77802) += max77802-regulator.o
 obj-$(CONFIG_REGULATOR_MAX77826) += max77826-regulator.o
+obj-$(CONFIG_REGULATOR_MAX77857) += max77857-regulator.o
 obj-$(CONFIG_REGULATOR_MC13783) += mc13783-regulator.o
 obj-$(CONFIG_REGULATOR_MC13892) += mc13892-regulator.o
 obj-$(CONFIG_REGULATOR_MC13XXX_CORE) +=  mc13xxx-regulator-core.o
diff --git a/drivers/regulator/max77857-regulator.c b/drivers/regulator/max77857-regulator.c
new file mode 100644
index 000000000000..66b3dc98ff23
--- /dev/null
+++ b/drivers/regulator/max77857-regulator.c
@@ -0,0 +1,382 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/bitfield.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>
+#include <linux/util_macros.h>
+
+#define MAX77857_REG_INT_SRC		0x10
+#define MAX77857_REG_INT_MASK		0x11
+#define MAX77857_REG_CONT1		0x12
+#define MAX77857_REG_CONT2		0x13
+#define MAX77857_REG_CONT3		0x14
+
+#define MAX77857_INT_SRC_OCP		BIT(0)
+#define MAX77857_INT_SRC_THS		BIT(1)
+#define MAX77857_INT_SRC_HARDSHORT	BIT(2)
+#define MAX77857_INT_SRC_OVP		BIT(3)
+#define MAX77857_INT_SRC_POK		BIT(4)
+
+#define MAX77857_ILIM_MASK		GENMASK(2, 0)
+#define MAX77857_CONT1_FREQ		GENMASK(4, 3)
+#define MAX77857_CONT3_FPWM		BIT(5)
+
+enum max77857_id {
+	ID_MAX77831 = 1,
+	ID_MAX77857,
+};
+
+static bool max77857_volatile_reg(struct device *dev, unsigned int reg)
+{
+	enum max77857_id id = (enum max77857_id)dev_get_drvdata(dev);
+
+	switch (id) {
+	case ID_MAX77831:
+	case ID_MAX77857:
+		return reg == MAX77857_REG_INT_SRC;
+	default:
+		return true;
+	}
+}
+
+struct regmap_config max77857_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.cache_type = REGCACHE_RBTREE,
+	.volatile_reg = max77857_volatile_reg,
+};
+
+static int max77857_get_status(struct regulator_dev *rdev)
+{
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(rdev->regmap, MAX77857_REG_INT_SRC, &val);
+	if (ret)
+		return ret;
+
+	if (FIELD_GET(MAX77857_INT_SRC_POK, val))
+		return REGULATOR_STATUS_ON;
+
+	return REGULATOR_STATUS_ERROR;
+}
+
+static unsigned int max77857_get_mode(struct regulator_dev *rdev)
+{
+	enum max77857_id id = (enum max77857_id)rdev_get_drvdata(rdev);
+	unsigned int regval;
+	int ret;
+
+	switch (id) {
+	case ID_MAX77831:
+	case ID_MAX77857:
+		ret = regmap_read(rdev->regmap, MAX77857_REG_CONT3, &regval);
+		if (ret)
+			return ret;
+
+		if (FIELD_GET(MAX77857_CONT3_FPWM, regval))
+			return REGULATOR_MODE_FAST;
+
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return REGULATOR_MODE_NORMAL;
+}
+
+static int max77857_set_mode(struct regulator_dev *rdev, unsigned int mode)
+{
+	enum max77857_id id = (enum max77857_id)rdev_get_drvdata(rdev);
+	unsigned int reg, val;
+
+	switch (id) {
+	case ID_MAX77831:
+	case ID_MAX77857:
+		reg = MAX77857_REG_CONT3;
+		val = MAX77857_CONT3_FPWM;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (mode) {
+	case REGULATOR_MODE_FAST:
+		return regmap_set_bits(rdev->regmap, reg, val);
+	case REGULATOR_MODE_NORMAL:
+		return regmap_clear_bits(rdev->regmap, reg, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int max77857_get_error_flags(struct regulator_dev *rdev,
+				    unsigned int *flags)
+{
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(rdev->regmap, MAX77857_REG_INT_SRC, &val);
+	if (ret)
+		return ret;
+
+	*flags = 0;
+
+	if (FIELD_GET(MAX77857_INT_SRC_OVP, val))
+		*flags |= REGULATOR_ERROR_OVER_VOLTAGE_WARN;
+
+	if (FIELD_GET(MAX77857_INT_SRC_OCP, val) ||
+	    FIELD_GET(MAX77857_INT_SRC_HARDSHORT, val))
+		*flags |= REGULATOR_ERROR_OVER_CURRENT;
+
+	if (FIELD_GET(MAX77857_INT_SRC_THS, val))
+		*flags |= REGULATOR_ERROR_OVER_TEMP;
+
+	if (!FIELD_GET(MAX77857_INT_SRC_POK, val))
+		*flags |= REGULATOR_ERROR_FAIL;
+
+	return 0;
+}
+
+static const struct regulator_ops max77857_regulator_ops = {
+	.list_voltage = regulator_list_voltage_linear_range,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_ramp_delay = regulator_set_ramp_delay_regmap,
+	.get_status = max77857_get_status,
+	.set_mode = max77857_set_mode,
+	.get_mode = max77857_get_mode,
+	.get_error_flags = max77857_get_error_flags,
+};
+
+static struct linear_range max77857_lin_ranges[] = {
+	REGULATOR_LINEAR_RANGE(4485000, 0x3D, 0xCC, 73500)
+};
+
+static const unsigned int max77857_switch_freq[] = {
+	1200000, 1500000, 1800000, 2100000
+};
+
+static const unsigned int max77857_ramp_table[2][4] = {
+	{ 1333, 667, 333, 227 }, /* when switch freq is 1.8MHz or 2.1MHz */
+	{ 1166, 667, 333, 167 }, /* when switch freq is 1.2MHz or 1.5MHz */
+};
+
+static struct regulator_desc max77857_regulator_desc = {
+	.ops = &max77857_regulator_ops,
+	.name = "max77857",
+	.linear_ranges = max77857_lin_ranges,
+	.n_linear_ranges = ARRAY_SIZE(max77857_lin_ranges),
+	.vsel_mask = 0xFF,
+	.vsel_reg = MAX77857_REG_CONT2,
+	.ramp_delay_table = max77857_ramp_table[0],
+	.n_ramp_values = ARRAY_SIZE(max77857_ramp_table[0]),
+	.ramp_reg = MAX77857_REG_CONT3,
+	.ramp_mask = GENMASK(1, 0),
+	.ramp_delay = max77857_ramp_table[0][0],
+	.owner = THIS_MODULE,
+};
+
+static irqreturn_t max77857_irq_handler(int irq, void *data)
+{
+	struct regulator_dev *rdev = data;
+	enum max77857_id id = (enum max77857_id)rdev_get_drvdata(rdev);
+	struct device *dev = &rdev->dev;
+	unsigned long flags = 0;
+	unsigned int status;
+	int ret;
+
+	switch (id) {
+	case ID_MAX77831:
+	case ID_MAX77857:
+		ret = regmap_read(rdev->regmap, MAX77857_REG_INT_SRC, &status);
+		break;
+	default:
+		return IRQ_HANDLED;
+	}
+
+	if (ret) {
+		dev_err(dev, "cannot read status\n");
+		return IRQ_HANDLED;
+	}
+
+	if (FIELD_GET(MAX77857_INT_SRC_OCP, status)) {
+		flags |= REGULATOR_EVENT_OVER_CURRENT;
+		dev_dbg(dev, "regulator has been latched off due to overcurrent\n");
+	}
+
+	if (FIELD_GET(MAX77857_INT_SRC_THS, status)) {
+		flags |= REGULATOR_EVENT_OVER_TEMP;
+		dev_dbg(dev, "regulator has been latched off due to thermal shutdown\n");
+	}
+
+	if (FIELD_GET(MAX77857_INT_SRC_HARDSHORT, status)) {
+		flags |= REGULATOR_EVENT_OVER_CURRENT;
+		dev_dbg(dev, "regulator has been latched off due to output hardshort\n");
+	}
+
+	if (id == ID_MAX77831 || id == ID_MAX77857) {
+		if (FIELD_GET(MAX77857_INT_SRC_OVP, status)) {
+			flags |= REGULATOR_EVENT_OVER_VOLTAGE_WARN;
+			dev_dbg(dev, "output overvoltage detected\n");
+		}
+
+		if (FIELD_GET(MAX77857_INT_SRC_POK, status)) {
+			flags |= REGULATOR_EVENT_ENABLE;
+			dev_dbg(dev, "output power OK\n");
+		} else {
+			flags |= REGULATOR_EVENT_FAIL;
+			dev_err(dev, "regulator failed\n");
+		}
+	} else {
+		if (flags != 0)
+			flags |= REGULATOR_EVENT_FAIL;
+	}
+
+	regulator_notifier_call_chain(rdev, flags, NULL);
+
+	return IRQ_HANDLED;
+}
+
+static void max77857_calc_range(struct device *dev, enum max77857_id id)
+{
+	struct linear_range *range;
+	unsigned long vref_step;
+	u32 rtop = 0;
+	u32 rbot = 0;
+
+	device_property_read_u32(dev, "adi,rtop-ohms", &rtop);
+	device_property_read_u32(dev, "adi,rbot-ohms", &rbot);
+
+	if (!rbot || !rtop)
+		return;
+
+	switch (id) {
+	case ID_MAX77831:
+	case ID_MAX77857:
+		range = max77857_lin_ranges;
+		vref_step = 4900UL;
+		break;
+	}
+
+	range->step = DIV_ROUND_CLOSEST(vref_step * (rbot + rtop), rbot);
+	range->min = range->step * range->min_sel;
+}
+
+static int max77857_probe(struct i2c_client *client)
+{
+	const struct i2c_device_id *i2c_id;
+	struct device *dev = &client->dev;
+	struct regulator_config cfg = {};
+	struct regulator_dev *rdev;
+	struct regmap *regmap;
+	enum max77857_id id;
+	u32 switch_freq = 0;
+	int ret;
+
+	i2c_id = i2c_client_get_device_id(client);
+	if (!i2c_id)
+		return -EINVAL;
+
+	id = i2c_id->driver_data;
+
+	dev_set_drvdata(dev, (void *)id);
+
+	max77857_calc_range(dev, id);
+
+	regmap = devm_regmap_init_i2c(client, &max77857_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "cannot initialize regmap\n");
+
+	device_property_read_u32(dev, "adi,switch-frequency-hz", &switch_freq);
+	if (switch_freq) {
+		switch_freq = find_closest(switch_freq, max77857_switch_freq,
+					   ARRAY_SIZE(max77857_switch_freq));
+
+		if (id == ID_MAX77831 && switch_freq == 3)
+			switch_freq = 2;
+
+		switch (id) {
+		case ID_MAX77831:
+		case ID_MAX77857:
+			ret = regmap_update_bits(regmap, MAX77857_REG_CONT1,
+						 MAX77857_CONT1_FREQ, switch_freq);
+
+			if (switch_freq >= 2)
+				break;
+
+			max77857_regulator_desc.ramp_delay_table = max77857_ramp_table[1];
+			max77857_regulator_desc.ramp_delay = max77857_ramp_table[1][0];
+			break;
+		}
+		if (ret)
+			return ret;
+	}
+
+	cfg.dev = dev;
+	cfg.driver_data = (void *)id;
+	cfg.regmap = regmap;
+	cfg.init_data = of_get_regulator_init_data(dev, dev->of_node,
+						   &max77857_regulator_desc);
+	if (!cfg.init_data)
+		return -ENOMEM;
+
+	rdev = devm_regulator_register(dev, &max77857_regulator_desc, &cfg);
+	if (IS_ERR(rdev))
+		return dev_err_probe(dev, PTR_ERR(rdev),
+				     "cannot register regulator\n");
+
+	if (client->irq) {
+		ret = devm_request_threaded_irq(dev, client->irq, NULL,
+						max77857_irq_handler,
+						IRQF_ONESHOT,
+						client->name, rdev);
+		if (ret)
+			return dev_err_probe(dev, ret, "cannot request irq\n");
+
+		/* enable interrupts */
+		switch (id) {
+		case ID_MAX77831:
+		case ID_MAX77857:
+			ret = regmap_write(regmap, MAX77857_REG_INT_MASK, 0x00);
+			break;
+		}
+
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+const struct i2c_device_id max77857_id[] = {
+	{ "max77831", ID_MAX77831 },
+	{ "max77857", ID_MAX77857 },
+	{}
+};
+
+static const struct of_device_id max77857_of_id[] = {
+	{ .compatible = "adi,max77831", .data = (void *)ID_MAX77831 },
+	{ .compatible = "adi,max77857", .data = (void *)ID_MAX77857 },
+	{ }
+};
+
+struct i2c_driver max77857_driver = {
+	.driver = {
+		.name = "max77857",
+		.of_match_table = max77857_of_id,
+	},
+	.id_table = max77857_id,
+	.probe_new = max77857_probe,
+};
+module_i2c_driver(max77857_driver);
+
+MODULE_DESCRIPTION("Analog Devices MAX77857 Buck-Boost Converter Driver");
+MODULE_AUTHOR("Ibrahim Tilki <Ibrahim.Tilki@analog.com>");
+MODULE_AUTHOR("Okan Sahin <Okan.Sahin@analog.com>");
+MODULE_LICENSE("GPL");
-- 
2.30.2


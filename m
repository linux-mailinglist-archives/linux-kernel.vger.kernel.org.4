Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273626D9DC9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 18:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239906AbjDFQp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 12:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239737AbjDFQpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 12:45:52 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F5AAD02;
        Thu,  6 Apr 2023 09:45:44 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336EKWDW013087;
        Thu, 6 Apr 2023 12:45:14 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3psa9f7gy4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 12:45:14 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 336GjDhI027438
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 6 Apr 2023 12:45:13 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 6 Apr 2023 12:45:12 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 6 Apr 2023 12:45:11 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 6 Apr 2023 12:45:11 -0400
Received: from daniel-Precision-5530.ad.analog.com ([10.48.65.214])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 336Gi7JW002852;
        Thu, 6 Apr 2023 12:45:05 -0400
From:   Daniel Matyas <daniel.matyas@analog.com>
CC:     Daniel Matyas <daniel.matyas@analog.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>, "Marek Vasut" <marex@denx.de>,
        Vincent Tremblay <vincent@vtremblay.dev>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Greg.Schwendimann@infineon.com" <Greg.Schwendimann@infineon.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] hwmon: max31827: add MAX31827 driver
Date:   Thu, 6 Apr 2023 19:43:27 +0300
Message-ID: <20230406164331.6557-3-daniel.matyas@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230406164331.6557-2-daniel.matyas@analog.com>
References: <20230406164331.6557-1-daniel.matyas@analog.com>
 <20230406164331.6557-2-daniel.matyas@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: e1trHiiGEVHuXRCxUGcQ8Kl1UdfOciZS
X-Proofpoint-ORIG-GUID: e1trHiiGEVHuXRCxUGcQ8Kl1UdfOciZS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_10,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0
 mlxscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304060149
X-Spam-Status: No, score=-0.7 required=5.0 tests=RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAX31827 is a low-power temperature switch with I2C interface.

The device is a ±1°C accuracy from -40°C to +125°C
(12 bits) local temperature switch and sensor with I2C/SM-
Bus interface. The combination of small 6-bump wafer-lev-
el package (WLP) and high accuracy makes this temper-
ature sensor/switch ideal for a wide range of applications.

Signed-off-by: Daniel Matyas <daniel.matyas@analog.com>
---
 MAINTAINERS              |   1 +
 drivers/hwmon/Kconfig    |  11 ++
 drivers/hwmon/Makefile   |   1 +
 drivers/hwmon/max31827.c | 240 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 253 insertions(+)
 create mode 100644 drivers/hwmon/max31827.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 549cea6bc340..63c17195a99b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12541,6 +12541,7 @@ L:	linux-hwmon@vger.kernel.org
 S:	Supported
 W:	http://ez.analog.com/community/linux-device-drivers
 F:	Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
+F:	drivers/hwmon/max31827.c
 
 MAX6650 HARDWARE MONITOR AND FAN CONTROLLER DRIVER
 L:	linux-hwmon@vger.kernel.org
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 5b3b76477b0e..80c44a787d42 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -2401,4 +2401,15 @@ config SENSORS_ASUS_EC
 
 endif # ACPI
 
+config MAX31827
+	tristate "MAX31827 low-power temperature switch"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  If you say yes here you get support for MAX31827
+	  low-power temperature switch and sensor connected with I2C.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called max31827.
+
 endif # HWMON
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 88712b5031c8..d00f0a1e73f6 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -224,3 +224,4 @@ obj-$(CONFIG_PMBUS)		+= pmbus/
 
 ccflags-$(CONFIG_HWMON_DEBUG_CHIP) := -DDEBUG
 
+obj-$(CONFIG_MAX31827) += max31827.o
diff --git a/drivers/hwmon/max31827.c b/drivers/hwmon/max31827.c
new file mode 100644
index 000000000000..1c79bcf12d78
--- /dev/null
+++ b/drivers/hwmon/max31827.c
@@ -0,0 +1,240 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * max31827.c - Support for Maxim Low-Power Switch
+ *
+ * Copyright (c) 2023 Daniel Matyas <daniel.matyas@analog.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/device.h>
+#include <linux/of.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+
+#define MAX31827_T_REG				0x0
+#define MAX31827_CONFIGURATION_REG              0x2
+#define MAX31827_TH_REG                         0x4
+#define MAX31827_TL_REG                         0x6
+#define MAX31827_TH_HYST_REG                    0x8
+#define MAX31827_TL_HYST_REG                    0xA
+
+#define MAX31827_CONFIGURATION_1SHOT_MASK	BIT(0)
+#define MAX31827_CONFIGURATION_CNV_RATE_MASK    GENMASK(3, 1)
+#define MAX31827_CONFIGURATION_RESOL_MASK       GENMASK(7, 6)
+#define MAX31827_CONFIGURATION_U_TEMP_STAT_MASK BIT(14)
+#define MAX31827_CONFIGURATION_O_TEMP_STAT_MASK BIT(15)
+
+#define MAX31827_CNV_SHUTDOWN			0x0
+#define MAX31827_CNV_1_DIV_64_HZ		0x1
+#define MAX31827_CNV_1_DIV_32_HZ		0x2
+#define MAX31827_CNV_1_DIV_16_HZ		0x3
+#define MAX31827_CNV_1_DIV_4_HZ			0x4
+#define MAX31827_CNV_1_HZ			0x5
+#define MAX31827_CNV_4_HZ			0x6
+#define MAX31827_CNV_8_HZ			0x7
+
+#define MAX31827_1SHOT_EN(x)			((x) ? BIT(0) : 0)
+
+struct max31827_state {
+	struct regmap *regmap;
+	struct i2c_client *client;
+};
+
+static const struct regmap_config max31827_regmap = {
+	.reg_bits = 8,
+	.val_bits = 16,
+	.max_register = 0xA,
+};
+
+static umode_t max31827_is_visible(const void *state,
+				   enum hwmon_sensor_types type,
+				   u32 attr, int channel)
+{
+	if (type == hwmon_temp) {
+		switch (attr) {
+		case hwmon_temp_enable:
+		case hwmon_temp_max:
+		case hwmon_temp_min:
+		case hwmon_temp_max_hyst:
+		case hwmon_temp_min_hyst:
+			return 0644;
+		case hwmon_temp_input:
+			return 0444;
+		}
+	}
+
+	return 0;
+}
+
+static int max31827_read(struct device *dev, enum hwmon_sensor_types type,
+			 u32 attr, int channel, long *val)
+{
+	struct max31827_state *st;
+	unsigned int uval;
+	int ret;
+
+	st = dev_get_drvdata(dev);
+	if (IS_ERR(st))
+		return PTR_ERR(st);
+
+	if (type != hwmon_temp)
+		return -EOPNOTSUPP;
+
+	switch (attr) {
+	case hwmon_temp_enable:
+		ret = regmap_read(st->regmap, MAX31827_CONFIGURATION_REG, &uval);
+		uval  = FIELD_GET(MAX31827_CONFIGURATION_1SHOT_MASK, uval);
+		break;
+
+	case hwmon_temp_input:
+		ret = regmap_read(st->regmap, MAX31827_T_REG, &uval);
+		break;
+
+	case hwmon_temp_max:
+		ret = regmap_read(st->regmap, MAX31827_TH_REG, &uval);
+		break;
+
+	case hwmon_temp_max_hyst:
+		ret = regmap_read(st->regmap, MAX31827_TH_HYST_REG, &uval);
+		break;
+	case hwmon_temp_min:
+		ret = regmap_read(st->regmap, MAX31827_TL_REG, &uval);
+		break;
+
+	case hwmon_temp_min_hyst:
+		ret = regmap_read(st->regmap, MAX31827_TL_HYST_REG, &uval);
+		break;
+
+	default:
+		ret = -EOPNOTSUPP;
+	}
+
+	if (ret)
+		return ret;
+
+	*val = uval;
+
+	return 0;
+}
+
+static int max31827_write(struct device *dev, enum hwmon_sensor_types type,
+			  u32 attr, int channel, long val)
+{
+	struct max31827_state *st = dev_get_drvdata(dev);
+
+	if (IS_ERR(st))
+		return PTR_ERR(st);
+
+	switch (attr) {
+	case hwmon_temp_enable:
+		if (val >> 1)
+			return -EOPNOTSUPP;
+
+		return regmap_update_bits(st->regmap, MAX31827_CONFIGURATION_REG,
+					  MAX31827_CONFIGURATION_1SHOT_MASK,
+					  MAX31827_1SHOT_EN(val));
+
+	case hwmon_temp_max:
+		return regmap_write(st->regmap, MAX31827_TH_REG, val);
+
+	case hwmon_temp_max_hyst:
+		return regmap_write(st->regmap, MAX31827_TH_HYST_REG, val);
+
+	case hwmon_temp_min:
+		return regmap_write(st->regmap, MAX31827_TL_REG, val);
+
+	case hwmon_temp_min_hyst:
+		return regmap_write(st->regmap, MAX31827_TL_HYST_REG, val);
+	}
+
+	return -EOPNOTSUPP;
+}
+
+static int max31827_init_client(struct max31827_state *st)
+{
+	return regmap_update_bits(st->regmap, MAX31827_CONFIGURATION_REG,
+				 MAX31827_CONFIGURATION_CNV_RATE_MASK |
+				 MAX31827_CONFIGURATION_1SHOT_MASK,
+				 MAX31827_1SHOT_EN(1));
+}
+
+static const struct hwmon_channel_info *max31827_info[] = {
+	HWMON_CHANNEL_INFO(temp, HWMON_T_ENABLE | HWMON_T_INPUT | HWMON_T_MIN |
+			   HWMON_T_MIN_HYST | HWMON_T_MAX | HWMON_T_MAX_HYST),
+	NULL,
+};
+
+static const struct hwmon_ops max31827_hwmon_ops = {
+	.is_visible = max31827_is_visible,
+	.read = max31827_read,
+	.write = max31827_write,
+};
+
+static const struct hwmon_chip_info max31827_chip_info = {
+	.ops = &max31827_hwmon_ops,
+	.info = max31827_info,
+};
+
+static int max31827_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct device *hwmon_dev;
+	struct max31827_state *st;
+	int ret;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
+		return -EOPNOTSUPP;
+
+	st = devm_kzalloc(dev, sizeof(struct max31827_state), GFP_KERNEL);
+	if (!st)
+		return -ENOMEM;
+
+	st->client = client;
+
+	st->regmap = devm_regmap_init_i2c(client, &max31827_regmap);
+	if (IS_ERR(st->regmap))
+		return dev_err_probe(dev, PTR_ERR(st->regmap),
+				     "Failed to allocate regmap: %ld\n",
+				     PTR_ERR(st->regmap));
+
+	ret = max31827_init_client(st);
+	if (ret)
+		return ret;
+
+	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name, st,
+							 &max31827_chip_info,
+							 NULL);
+
+	return PTR_ERR_OR_ZERO(hwmon_dev);
+}
+
+static const struct i2c_device_id max31827_i2c_ids[] = {
+	{ .name = "max31827" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, max31827_i2c_ids);
+
+static const struct of_device_id max31827_of_match[] = {
+	{ .compatible = "max31827" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max31827_of_match);
+
+static struct i2c_driver max31827_driver = {
+	.class = I2C_CLASS_HWMON,
+	.driver = {
+		.name = "max31827",
+		.of_match_table = max31827_of_match,
+	},
+	.probe_new = max31827_probe,
+	.id_table = max31827_i2c_ids,
+};
+module_i2c_driver(max31827_driver);
+
+MODULE_AUTHOR("Daniel Matyas <daniel.matyas@analog.com>");
+MODULE_DESCRIPTION("Maxim MAX31827 low-power temperature switch driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1


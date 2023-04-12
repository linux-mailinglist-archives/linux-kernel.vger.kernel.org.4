Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7506DFA55
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjDLPfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjDLPft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:35:49 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A057693;
        Wed, 12 Apr 2023 08:35:21 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33CE9VZX002836;
        Wed, 12 Apr 2023 11:34:38 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3pu2490er7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 11:34:37 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 33CFYZtj017858
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Apr 2023 11:34:35 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 12 Apr 2023 11:34:34 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 12 Apr 2023 11:34:34 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 12 Apr 2023 11:34:34 -0400
Received: from daniel-Precision-5530.ad.analog.com ([10.48.65.214])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 33CFXucx019897;
        Wed, 12 Apr 2023 11:34:29 -0400
From:   Daniel Matyas <daniel.matyas@analog.com>
CC:     Daniel Matyas <daniel.matyas@analog.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v2 2/2] [PATCH v1 2/2] hwmon: max31827: add MAX31827 driver
Date:   Wed, 12 Apr 2023 18:33:32 +0300
Message-ID: <20230412153334.181852-3-daniel.matyas@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230412153334.181852-2-daniel.matyas@analog.com>
References: <20230412153334.181852-1-daniel.matyas@analog.com>
 <20230412153334.181852-2-daniel.matyas@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: YT_7f5cJD4V5Eg7ulpdv4Vv2bqWu0FrE
X-Proofpoint-GUID: YT_7f5cJD4V5Eg7ulpdv4Vv2bqWu0FrE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_07,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0 suspectscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304120137
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
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
 Documentation/hwmon/max31827.rst |  88 +++++++++
 MAINTAINERS                      |   2 +
 drivers/hwmon/Kconfig            |  11 ++
 drivers/hwmon/Makefile           |   1 +
 drivers/hwmon/max31827.c         | 324 +++++++++++++++++++++++++++++++
 5 files changed, 426 insertions(+)
 create mode 100644 Documentation/hwmon/max31827.rst
 create mode 100644 drivers/hwmon/max31827.c

diff --git a/Documentation/hwmon/max31827.rst b/Documentation/hwmon/max31827.rst
new file mode 100644
index 000000000000..fe4d5bae8785
--- /dev/null
+++ b/Documentation/hwmon/max31827.rst
@@ -0,0 +1,88 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Kernel driver max31827
+======================
+
+Supported chips:
+
+  * Maxim MAX31827
+
+    Prefix: 'max31827'
+
+    Addresses scanned: I2C 0x40 - 0x5f
+
+    Datasheet: Publicly available at the Analog Devices website
+
+  * Maxim MAX31828
+
+    Prefix: 'max31828'
+
+    Addresses scanned: I2C 0x40 - 0x5f
+
+    Datasheet: Publicly available at the Analog Devices website
+
+  * Maxim MAX31829
+
+    Prefix: 'max31829'
+
+    Addresses scanned: I2C 0x40 - 0x5f
+
+    Datasheet: Publicly available at the Analog Devices website
+
+
+Authors:
+	- Daniel Matyas <daniel.matyas@analog.com>
+
+Description
+-----------
+
+The chips supported by this driver are quite similar. The only difference
+between them is found in the default power-on behaviour of the chips. While the
+MAX31827's fault queue is set to 1, the other two chip's fault queue is set to
+4. Besides this, the MAX31829's alarm active state is high, while the other two
+chip's alarms are active on low. It is important to note that the chips can be
+configured to operate in the same manner with 1 write operation to the
+configuration register. From here on, we will refer to all these chips as
+MAX31827.
+
+MAX31827 implemets a temperature sensor with a 6 WLP packaging scheme. This
+sensor measures the temperature of the chip itself.
+
+MAX31827 has low and over temperature alarms with an effective value and a
+hysteresis value: -40 and -30 degrees for under temperature alarm and +100 and
++90 degrees for over temperature alarm.
+
+The alarm can be configured in comparator (default) and interrupt mode. In
+Comparator mode, the OT/UT status bits have a value of 1 when the temperature
+rises above the TH value or falls below TL, which is also subject to the Fault
+Queue selection. OT status returns to 0 when the temperature drops below the
+TH_HYST value or when shutdown mode is entered. Similarly, UT status returns to
+0 when the temperature rises above TL_HYST value or when shutdown mode is
+entered.
+
+In Interrupt mode exceeding TH also sets OT status to 1, which remains set until
+a read operation is performed on the configuration/status register; at this
+point, it returns to 0. Once OT status is set to 1 from exceeding TH and reset,
+it is set to 1 again only when the temperature drops below TH_HYST. The output
+remains asserted until it is reset by a read. It is set again if the temperature
+rises above TH, and so on. The same logic applies to the operation of the UT
+status bit.
+
+Putting the MAX31827 into shutdown mode also resets the OT/UT status bits. Note
+that if the mode is changed while OT/UT status bits are set, an OT/UT status
+reset may be required before it begins to behave normally. To prevent this,
+it is recommended to perform a read of the configuration/status register to
+clear the status bits before changing the operating mode.
+
+The conversions can be manuel with the one-shot functionality and automatic with
+a set frequency. When powered on, the chip measures temperatures with 1 conv/s.
+The conversion time varies depending on the resolution. The conversion time
+doubles with every bit of increased resolution. For 10 bit resolution
+35ms are needed, while for 12 bit resolution (default) 140ms.
+
+
+Notes
+-----
+
+Currently fault queue, alarm polarity and resolution cannot be modified.
+PEC is not implemented either.
diff --git a/MAINTAINERS b/MAINTAINERS
index 8af1296ff1a0..cfb15f3f4606 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12541,6 +12541,8 @@ L:	linux-hwmon@vger.kernel.org
 S:	Supported
 W:	http://ez.analog.com/community/linux-device-drivers
 F:	Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
+F:	Documentation/hwmon/max31827.rst
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
index 000000000000..8eb708adac49
--- /dev/null
+++ b/drivers/hwmon/max31827.c
@@ -0,0 +1,324 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * max31827.c - Support for Maxim Low-Power Switch
+ *
+ * Copyright (c) 2023 Daniel Matyas <daniel.matyas@analog.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/hwmon.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+
+#define MAX31827_T_REG 0x0
+#define MAX31827_CONFIGURATION_REG 0x2
+#define MAX31827_TH_REG 0x4
+#define MAX31827_TL_REG 0x6
+#define MAX31827_TH_HYST_REG 0x8
+#define MAX31827_TL_HYST_REG 0xA
+
+#define MAX31827_CONFIGURATION_1SHOT_MASK BIT(0)
+#define MAX31827_CONFIGURATION_CNV_RATE_MASK GENMASK(3, 1)
+#define MAX31827_CONFIGURATION_U_TEMP_STAT_MASK BIT(14)
+#define MAX31827_CONFIGURATION_O_TEMP_STAT_MASK BIT(15)
+
+#define MAX31827_12_BIT_CNV_TIME 140
+
+#define MAX31827_DEVICE_ENABLE(x) ((x) ? 0xA : 0x0)
+
+enum chips { max31827, max31828, max31829 };
+
+struct max31827_state {
+	struct regmap *regmap;
+	bool enable;
+};
+
+static const struct regmap_config max31827_regmap = {
+	.reg_bits = 8,
+	.val_bits = 16,
+	.max_register = 0xA,
+};
+
+static int write_alarm_val(struct max31827_state *st, unsigned int reg,
+			   unsigned int val)
+{
+	unsigned int cfg;
+	unsigned int tmp;
+	int ret;
+
+	if (!st->enable)
+		return regmap_write(st->regmap, reg, val);
+
+	ret = regmap_read(st->regmap, MAX31827_CONFIGURATION_REG, &cfg);
+	if (ret)
+		return ret;
+
+	tmp = cfg & ~(MAX31827_CONFIGURATION_1SHOT_MASK |
+		      MAX31827_CONFIGURATION_CNV_RATE_MASK);
+	ret = regmap_write(st->regmap, MAX31827_CONFIGURATION_REG, tmp);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, reg, val);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, MAX31827_CONFIGURATION_REG, cfg);
+
+	return ret;
+}
+
+static umode_t max31827_is_visible(const void *state,
+				   enum hwmon_sensor_types type, u32 attr,
+				   int channel)
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
+		case hwmon_temp_min_alarm:
+		case hwmon_temp_max_alarm:
+			return 0444;
+		}
+	} else if (type == hwmon_chip) {
+		if (attr == hwmon_chip_update_interval)
+			return 0644;
+	}
+
+	return 0;
+}
+
+static int max31827_read(struct device *dev, enum hwmon_sensor_types type,
+			 u32 attr, int channel, long *val)
+{
+	struct max31827_state *st = dev_get_drvdata(dev);
+	unsigned int uval;
+	int ret;
+
+	switch (type) {
+	case hwmon_temp:
+		switch (attr) {
+		case hwmon_temp_enable:
+			ret = regmap_read(st->regmap,
+					  MAX31827_CONFIGURATION_REG, &uval);
+			uval = FIELD_GET(MAX31827_CONFIGURATION_1SHOT_MASK |
+					 MAX31827_CONFIGURATION_CNV_RATE_MASK,
+					 uval);
+			if (uval)
+				uval = 1;
+			break;
+		case hwmon_temp_input:
+			if (!st->enable) {
+				ret = regmap_update_bits(st->regmap,
+							 MAX31827_CONFIGURATION_REG,
+							 MAX31827_CONFIGURATION_1SHOT_MASK,
+							 1);
+				if (ret)
+					return ret;
+
+				msleep(MAX31827_12_BIT_CNV_TIME);
+			}
+			ret = regmap_read(st->regmap, MAX31827_T_REG, &uval);
+
+			break;
+		case hwmon_temp_max:
+			ret = regmap_read(st->regmap, MAX31827_TH_REG, &uval);
+			break;
+		case hwmon_temp_max_hyst:
+			ret = regmap_read(st->regmap, MAX31827_TH_HYST_REG,
+					  &uval);
+			break;
+		case hwmon_temp_max_alarm:
+			ret = regmap_read(st->regmap,
+					  MAX31827_CONFIGURATION_REG, &uval);
+			uval = FIELD_GET(MAX31827_CONFIGURATION_O_TEMP_STAT_MASK,
+					 uval);
+			break;
+		case hwmon_temp_min:
+			ret = regmap_read(st->regmap, MAX31827_TL_REG, &uval);
+			break;
+		case hwmon_temp_min_hyst:
+			ret = regmap_read(st->regmap, MAX31827_TL_HYST_REG,
+					  &uval);
+			break;
+		case hwmon_temp_min_alarm:
+			ret = regmap_read(st->regmap,
+					  MAX31827_CONFIGURATION_REG, &uval);
+			uval = FIELD_GET(MAX31827_CONFIGURATION_U_TEMP_STAT_MASK,
+					 uval);
+			break;
+		default:
+			ret = -EOPNOTSUPP;
+		}
+		break;
+
+	case hwmon_chip:
+		if (attr == hwmon_chip_update_interval) {
+			ret = regmap_read(st->regmap,
+					  MAX31827_CONFIGURATION_REG, &uval);
+			uval = FIELD_GET(MAX31827_CONFIGURATION_CNV_RATE_MASK,
+					 uval);
+		}
+		break;
+
+	default:
+		ret = -EOPNOTSUPP;
+	}
+
+	if (ret)
+		return ret;
+
+	*val = (short)uval;
+
+	return 0;
+}
+
+static int max31827_write(struct device *dev, enum hwmon_sensor_types type,
+			  u32 attr, int channel, long val)
+{
+	struct max31827_state *st = dev_get_drvdata(dev);
+
+	switch (type) {
+	case hwmon_temp:
+		switch (attr) {
+		case hwmon_temp_enable:
+			if (val >> 1)
+				return -EOPNOTSUPP;
+
+			st->enable = val;
+
+			return regmap_update_bits(st->regmap,
+						  MAX31827_CONFIGURATION_REG,
+						  MAX31827_CONFIGURATION_1SHOT_MASK |
+						  MAX31827_CONFIGURATION_CNV_RATE_MASK,
+						  MAX31827_DEVICE_ENABLE(val));
+
+		case hwmon_temp_max:
+			return write_alarm_val(st, MAX31827_TH_REG, val);
+
+		case hwmon_temp_max_hyst:
+			return write_alarm_val(st, MAX31827_TH_HYST_REG, val);
+
+		case hwmon_temp_min:
+			return write_alarm_val(st, MAX31827_TL_REG, val);
+
+		case hwmon_temp_min_hyst:
+			return write_alarm_val(st, MAX31827_TL_HYST_REG, val);
+
+		default:
+			return -EOPNOTSUPP;
+		}
+
+	case hwmon_chip:
+		if (attr == hwmon_chip_update_interval) {
+			val = FIELD_PREP(MAX31827_CONFIGURATION_CNV_RATE_MASK,
+					 val);
+			return regmap_update_bits(st->regmap,
+						  MAX31827_CONFIGURATION_REG,
+						  MAX31827_CONFIGURATION_CNV_RATE_MASK,
+						  val);
+		}
+		break;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return -EOPNOTSUPP;
+}
+
+static int max31827_init_client(struct max31827_state *st)
+{
+	st->enable = true;
+
+	return regmap_update_bits(st->regmap, MAX31827_CONFIGURATION_REG,
+				  MAX31827_CONFIGURATION_1SHOT_MASK |
+				  MAX31827_CONFIGURATION_CNV_RATE_MASK,
+				  MAX31827_DEVICE_ENABLE(1));
+}
+
+static const struct hwmon_channel_info *max31827_info[] = {
+	HWMON_CHANNEL_INFO(temp, HWMON_T_ENABLE | HWMON_T_INPUT | HWMON_T_MIN |
+			   HWMON_T_MIN_HYST | HWMON_T_MIN_ALARM | HWMON_T_MAX |
+			   HWMON_T_MAX_HYST | HWMON_T_MAX_ALARM),
+	HWMON_CHANNEL_INFO(chip, HWMON_C_UPDATE_INTERVAL),
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
+	int err;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
+		return -EOPNOTSUPP;
+
+	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
+	if (!st)
+		return -ENOMEM;
+
+	st->regmap = devm_regmap_init_i2c(client, &max31827_regmap);
+	if (IS_ERR(st->regmap))
+		return dev_err_probe(dev, PTR_ERR(st->regmap),
+				     "Failed to allocate regmap.\n");
+
+	err = max31827_init_client(st);
+	if (err)
+		return err;
+
+	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name, st,
+							 &max31827_chip_info,
+							 NULL);
+
+	return PTR_ERR_OR_ZERO(hwmon_dev);
+}
+
+static const struct i2c_device_id max31827_i2c_ids[] = {
+	{ "max31827", max31827 },
+	{ "max31828", max31828 },
+	{ "max31829", max31829 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, max31827_i2c_ids);
+
+static const struct of_device_id max31827_of_match[] = {
+	{ .compatible = "adi,max31827" },
+	{ .compatible = "adi,max31828" },
+	{ .compatible = "adi,max31829" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max31827_of_match);
+
+static struct i2c_driver max31827_driver = {
+	.class = I2C_CLASS_HWMON,
+	.driver = {
+		.name = "adi,max31827",
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


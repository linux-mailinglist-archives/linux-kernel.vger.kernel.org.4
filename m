Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807A264CB9A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 14:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238465AbiLNNuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 08:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238245AbiLNNuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 08:50:44 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850551161;
        Wed, 14 Dec 2022 05:50:42 -0800 (PST)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BEB86Kd014276;
        Wed, 14 Dec 2022 08:50:18 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3mf6rntkbw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 08:50:18 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 2BEDoG1e026646
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 14 Dec 2022 08:50:16 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 14 Dec 2022 08:50:16 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 14 Dec 2022 08:50:15 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 14 Dec 2022 08:50:15 -0500
Received: from IST-LT-40003.ad.analog.com (IST-LT-40003.ad.analog.com [10.25.36.26])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 2BEDnw0K019580;
        Wed, 14 Dec 2022 08:50:01 -0500
From:   Sinan Divarci <Sinan.Divarci@analog.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Sinan Divarci <Sinan.Divarci@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>
Subject: [PATCH 1/3] drivers: hwmon: Add max31732 quad remote temperature sensor driver
Date:   Wed, 14 Dec 2022 16:49:37 +0300
Message-ID: <20221214134939.12491-1-Sinan.Divarci@analog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 4uLjlStnpN2VvDZhmMkHdi9YuB4_u_WS
X-Proofpoint-GUID: 4uLjlStnpN2VvDZhmMkHdi9YuB4_u_WS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-14_06,2022-12-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 clxscore=1011 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212140109
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MAX31732 is a multi-channel temperature sensor that monitors its own
temperature and the temperatures of up to four external diodeconnected
transistors.

The MAX31732 offers two open-drain, active-low alarm outputs, ALARM1
and ALARM2. When the measured temperature of a channel crosses the
respective primary over/under temperature threshold levels ALARM1
asserts low and a status bit is set in the corresponding thermal status
registers. When the measured temperature of a channel crosses the
secondary over/under temperature threshold levels, ALARM2 asserts low
and a status bit is set in the corresponding thermal status registers.

Signed-off-by: Sinan Divarci <Sinan.Divarci@analog.com>
Reviewed-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
---
 drivers/hwmon/Kconfig    |  11 +
 drivers/hwmon/Makefile   |   1 +
 drivers/hwmon/max31732.c | 620 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 632 insertions(+)
 create mode 100644 drivers/hwmon/max31732.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 3176c33af..f498f3867 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1076,6 +1076,17 @@ config SENSORS_MAX31730
 	  This driver can also be built as a module. If so, the module
 	  will be called max31730.
 
+config SENSORS_MAX31732
+	tristate "MAX31732 temperature sensor"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Support for the Analog Devices MAX31732 4-Channel Remote
+	  Temperature Sensor.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called max31732.
+
 config SENSORS_MAX31760
 	tristate "MAX31760 fan speed controller"
 	depends on I2C
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index e2e4e87b2..6b2871cc5 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -140,6 +140,7 @@ obj-$(CONFIG_SENSORS_MAX1668)	+= max1668.o
 obj-$(CONFIG_SENSORS_MAX197)	+= max197.o
 obj-$(CONFIG_SENSORS_MAX31722)	+= max31722.o
 obj-$(CONFIG_SENSORS_MAX31730)	+= max31730.o
+obj-$(CONFIG_SENSORS_MAX31732)	+= max31732.o
 obj-$(CONFIG_SENSORS_MAX31760)  += max31760.o
 obj-$(CONFIG_SENSORS_MAX6620)	+= max6620.o
 obj-$(CONFIG_SENSORS_MAX6621)	+= max6621.o
diff --git a/drivers/hwmon/max31732.c b/drivers/hwmon/max31732.c
new file mode 100644
index 000000000..cf075c990
--- /dev/null
+++ b/drivers/hwmon/max31732.c
@@ -0,0 +1,620 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Driver for MAX31732 4-Channel Remote Temperature Sensor
+ */
+
+#include <linux/bitfield.h>
+#include <linux/i2c.h>
+#include <linux/hwmon.h>
+#include <linux/regmap.h>
+
+/* common definitions*/
+#define MAX3173X_STOP			BIT(7)
+#define MAX3173X_ALARM_MODE		BIT(4)
+#define MAX3173X_ALARM_FAULT_QUEUE_MASK	GENMASK(3, 2)
+#define MAX3173X_EXTRANGE		BIT(1)
+#define MAX3173X_TEMP_OFFSET_BASELINE	0x77
+#define MAX3173X_TEMP_MIN		(-128000)
+#define MAX3173X_TEMP_MAX		127937
+#define MAX3173X_OFFSET_MIN		(-14875)
+#define MAX3173X_OFFSET_MAX		17000
+#define MAX3173X_OFFSET_ZERO		14875
+#define MAX31732_SECOND_TEMP_MIN	(-128000)
+#define MAX31732_SECOND_TEMP_MAX	127000
+#define MAX31732_CUSTOM_OFFSET_RES	125
+#define MAX31732_ALL_CHANNEL_MASK	0x1F
+#define MAX31732_ALARM_INT_MODE		0
+#define MAX31732_ALARM_COMP_MODE	1
+#define MAX31732_ALARM_FAULT_QUE	1
+#define MAX31732_ALARM_FAULT_QUE_MAX	3
+
+/* The MAX31732 registers */
+#define MAX31732_REG_TEMP_R		0x02
+#define MAX31732_REG_TEMP_L		0x0A
+#define MAX31732_REG_PRIM_HIGH_STATUS	0x0C
+#define MAX31732_REG_PRIM_LOW_STATUS	0x0D
+#define MAX31732_REG_CHANNEL_ENABLE	0x0E
+#define MAX31732_REG_CONF1		0x0F
+#define MAX31732_REG_CONF2		0x10
+#define MAX31732_REG_TEMP_OFFSET	0x16
+#define MAX31732_REG_OFFSET_ENABLE	0x17
+#define MAX31732_REG_ALARM1_MASK	0x1B
+#define MAX31732_REG_ALARM2_MASK	0x1C
+#define MAX31732_REG_PRIM_HIGH_TEMP_R	0x1D
+#define MAX31732_REG_PRIM_HIGH_TEMP_L	0x25
+#define MAX31732_REG_PRIM_LOW_TEMP	0x27
+#define MAX31732_REG_SECOND_HIGH_TEMP_R	0x29
+#define MAX31732_REG_SECOND_HIGH_TEMP_L	0x2D
+#define MAX31732_REG_SECOND_LOW_TEMP	0x2E
+#define MAX31732_REG_SECOND_HIGH_STATUS	0x42
+#define MAX31732_REG_SECOND_LOW_STATUS	0x43
+#define MAX31732_REG_TEMP_FAULT		0x44
+
+enum max31732_temp_type {
+	MAX31732_TEMP,
+	MAX31732_PRIM_HIGH,
+	MAX31732_SECOND_HIGH
+};
+
+struct max31732_data {
+	struct i2c_client	*client;
+	struct device		*hwmon_dev;
+	struct regmap		*regmap;
+	s32			irqs[2];
+};
+
+static u32 max31732_get_temp_reg(enum max31732_temp_type temp_type, u32 channel)
+{
+	switch (temp_type) {
+	case MAX31732_PRIM_HIGH:
+		if (channel == 0)
+			return MAX31732_REG_PRIM_HIGH_TEMP_L;
+		else
+			return (MAX31732_REG_PRIM_HIGH_TEMP_R + (channel - 1) * 2);
+		break;
+	case MAX31732_SECOND_HIGH:
+		if (channel == 0)
+			return MAX31732_REG_SECOND_HIGH_TEMP_L;
+		else
+			return (MAX31732_REG_SECOND_HIGH_TEMP_R + (channel - 1));
+		break;
+	case MAX31732_TEMP:
+	default:
+		if (channel == 0)
+			return MAX31732_REG_TEMP_L;
+		else
+			return (MAX31732_REG_TEMP_R + (channel - 1) * 2);
+		break;
+	}
+}
+
+static bool max31732_volatile_reg(struct device *dev, u32 reg)
+{
+	if (reg >= MAX31732_REG_TEMP_R && reg <= MAX31732_REG_PRIM_LOW_STATUS)
+		return true;
+
+	if (reg == MAX31732_REG_SECOND_HIGH_STATUS || reg == MAX31732_REG_SECOND_LOW_STATUS)
+		return true;
+
+	if (reg == MAX31732_REG_TEMP_FAULT)
+		return true;
+
+	return false;
+}
+
+static const struct regmap_config regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.cache_type = REGCACHE_RBTREE,
+	.volatile_reg = max31732_volatile_reg,
+};
+
+static inline long max31732_reg_to_mc(s16 temp)
+{
+	return DIV_ROUND_CLOSEST((temp / 16) * 1000, 16);
+}
+
+static int max31732_read(struct device *dev, enum hwmon_sensor_types type, u32 attr, s32 channel,
+			 long *val)
+{
+	struct max31732_data *data = dev_get_drvdata(dev);
+	s32 ret;
+	u32 reg_val, reg_addr;
+	s16 temp_reg_val;
+	u8 regs[2];
+
+	if (type != hwmon_temp)
+		return -EINVAL;
+
+	switch (attr) {
+	case hwmon_temp_input:
+		ret = regmap_test_bits(data->regmap, MAX31732_REG_CHANNEL_ENABLE, BIT(channel));
+		if (ret < 0)
+			return ret;
+
+		if (!ret)
+			return -ENODATA;
+
+		reg_addr = max31732_get_temp_reg(MAX31732_TEMP, channel);
+		break;
+	case hwmon_temp_max:
+		reg_addr = max31732_get_temp_reg(MAX31732_PRIM_HIGH, channel);
+		break;
+	case hwmon_temp_min:
+		reg_addr = MAX31732_REG_PRIM_LOW_TEMP;
+		break;
+	case hwmon_temp_lcrit:
+		ret = regmap_read(data->regmap, MAX31732_REG_SECOND_LOW_TEMP, &reg_val);
+		if (ret)
+			return ret;
+
+		*val = reg_val * 1000;
+		return 0;
+	case hwmon_temp_crit:
+		reg_addr = max31732_get_temp_reg(MAX31732_SECOND_HIGH, channel);
+		ret = regmap_read(data->regmap, reg_addr, &reg_val);
+		if (ret)
+			return ret;
+
+		*val = reg_val * 1000;
+		return 0;
+	case hwmon_temp_enable:
+		ret = regmap_test_bits(data->regmap, MAX31732_REG_CHANNEL_ENABLE, BIT(channel));
+		if (ret < 0)
+			return ret;
+
+		*val = ret;
+		return 0;
+	case hwmon_temp_offset:
+		if (channel == 0)
+			return -EINVAL;
+
+		ret = regmap_test_bits(data->regmap, MAX31732_REG_OFFSET_ENABLE, BIT(channel));
+		if (ret < 0)
+			return ret;
+
+		if (!ret)
+			return 0;
+
+		ret = regmap_read(data->regmap, MAX31732_REG_TEMP_OFFSET, &reg_val);
+		if (ret)
+			return ret;
+
+		*val = (reg_val - MAX3173X_TEMP_OFFSET_BASELINE) * MAX31732_CUSTOM_OFFSET_RES;
+		return 0;
+	case hwmon_temp_fault:
+		ret = regmap_test_bits(data->regmap, MAX31732_REG_TEMP_FAULT, BIT(channel));
+		if (ret < 0)
+			return ret;
+
+		*val = ret;
+		return 0;
+	case hwmon_temp_lcrit_alarm:
+		ret = regmap_test_bits(data->regmap, MAX31732_REG_SECOND_LOW_STATUS, BIT(channel));
+		if (ret < 0)
+			return ret;
+
+		*val = ret;
+		return 0;
+	case hwmon_temp_min_alarm:
+		ret = regmap_test_bits(data->regmap, MAX31732_REG_PRIM_LOW_STATUS, BIT(channel));
+		if (ret < 0)
+			return ret;
+
+		*val = ret;
+		return 0;
+	case hwmon_temp_max_alarm:
+		ret = regmap_test_bits(data->regmap, MAX31732_REG_PRIM_HIGH_STATUS, BIT(channel));
+		if (ret < 0)
+			return ret;
+
+		*val = ret;
+		return 0;
+	case hwmon_temp_crit_alarm:
+		ret = regmap_test_bits(data->regmap, MAX31732_REG_SECOND_HIGH_STATUS, BIT(channel));
+		if (ret < 0)
+			return ret;
+
+		*val = ret;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+
+	ret = regmap_bulk_read(data->regmap, reg_addr, &regs, 2);
+	if (ret < 0)
+		return ret;
+
+	temp_reg_val = regs[1] | regs[0] << 8;
+	*val = max31732_reg_to_mc(temp_reg_val);
+	return 0;
+}
+
+static int max31732_write(struct device *dev, enum hwmon_sensor_types type, u32 attr, s32 channel,
+			  long val)
+{
+	struct max31732_data *data = dev_get_drvdata(dev);
+	s32 reg_addr, ret;
+	u16 temp_reg_val;
+
+	if (type != hwmon_temp)
+		return -EINVAL;
+
+	switch (attr) {
+	case hwmon_temp_max:
+		reg_addr = max31732_get_temp_reg(MAX31732_PRIM_HIGH, channel);
+		break;
+	case hwmon_temp_min:
+		reg_addr = MAX31732_REG_PRIM_LOW_TEMP;
+		break;
+	case hwmon_temp_enable:
+		if (val == 0) {
+			return regmap_clear_bits(data->regmap, MAX31732_REG_CHANNEL_ENABLE,
+						 BIT(channel));
+		} else if (val == 1) {
+			return regmap_set_bits(data->regmap, MAX31732_REG_CHANNEL_ENABLE,
+					       BIT(channel));
+		} else {
+			return -EINVAL;
+		}
+	case hwmon_temp_offset:
+		val = clamp_val(val, MAX3173X_OFFSET_MIN, MAX3173X_OFFSET_MAX) +
+				MAX3173X_OFFSET_ZERO;
+		val = DIV_ROUND_CLOSEST(val, 125);
+
+		if (val == MAX3173X_TEMP_OFFSET_BASELINE) {
+			ret = regmap_clear_bits(data->regmap, MAX31732_REG_OFFSET_ENABLE,
+						BIT(channel));
+		} else {
+			ret = regmap_set_bits(data->regmap, MAX31732_REG_OFFSET_ENABLE,
+					      BIT(channel));
+		}
+		if (ret)
+			return ret;
+
+		return regmap_write(data->regmap, MAX31732_REG_TEMP_OFFSET, val);
+	case hwmon_temp_crit:
+		val = clamp_val(val, MAX31732_SECOND_TEMP_MIN, MAX31732_SECOND_TEMP_MAX);
+		val = DIV_ROUND_CLOSEST(val, 1000);
+		reg_addr = max31732_get_temp_reg(MAX31732_SECOND_HIGH, channel);
+		return regmap_write(data->regmap, reg_addr, val);
+	case hwmon_temp_lcrit:
+		val = clamp_val(val, MAX31732_SECOND_TEMP_MIN, MAX31732_SECOND_TEMP_MAX);
+		val = DIV_ROUND_CLOSEST(val, 1000);
+		return regmap_write(data->regmap, MAX31732_REG_SECOND_LOW_TEMP, val);
+	default:
+		return -EINVAL;
+	}
+
+	val = clamp_val(val, MAX3173X_TEMP_MIN, MAX3173X_TEMP_MAX);
+	val = DIV_ROUND_CLOSEST(val << 4, 1000) << 4;
+
+	temp_reg_val = (u16)val;
+	temp_reg_val = swab16(temp_reg_val);
+
+	return regmap_bulk_write(data->regmap, reg_addr, &temp_reg_val, sizeof(temp_reg_val));
+}
+
+static umode_t max31732_is_visible(const void *data, enum hwmon_sensor_types type, u32 attr,
+				   s32 channel)
+{
+	switch (type) {
+	case hwmon_temp:
+		switch (attr) {
+		case hwmon_temp_input:
+		case hwmon_temp_lcrit_alarm:
+		case hwmon_temp_min_alarm:
+		case hwmon_temp_max_alarm:
+		case hwmon_temp_crit_alarm:
+		case hwmon_temp_fault:
+			return 0444;
+		case hwmon_temp_min:
+		case hwmon_temp_lcrit:
+			return channel ? 0444 : 0644;
+		case hwmon_temp_offset:
+		case hwmon_temp_enable:
+		case hwmon_temp_max:
+		case hwmon_temp_crit:
+			return 0644;
+		}
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+static irqreturn_t max31732_irq_handler(s32 irq, void *data)
+{
+	struct device *dev = data;
+	struct max31732_data *drvdata = dev_get_drvdata(dev);
+	s32 ret;
+	u32 reg_val;
+	bool reported = false;
+
+	ret = regmap_read(drvdata->regmap, MAX31732_REG_PRIM_HIGH_STATUS, &reg_val);
+	if (ret)
+		return ret;
+
+	if (reg_val != 0) {
+		dev_crit(dev, "Primary Overtemperature Alarm, R4:%d R3:%d R2:%d R1:%d L:%d.\n",
+			 !!(reg_val & BIT(4)), !!(reg_val & BIT(3)), !!(reg_val & BIT(2)),
+			 !!(reg_val & BIT(1)), !!(reg_val & BIT(0)));
+		hwmon_notify_event(drvdata->hwmon_dev, hwmon_temp, hwmon_temp_max_alarm, 0);
+		reported = true;
+	}
+
+	ret = regmap_read(drvdata->regmap, MAX31732_REG_PRIM_LOW_STATUS, &reg_val);
+	if (ret)
+		return ret;
+
+	if (reg_val != 0) {
+		dev_crit(dev, "Primary Undertemperature Alarm, R4:%d R3:%d R2:%d R1:%d L:%d.\n",
+			 !!(reg_val & BIT(4)), !!(reg_val & BIT(3)), !!(reg_val & BIT(2)),
+			 !!(reg_val & BIT(1)), !!(reg_val & BIT(0)));
+		hwmon_notify_event(drvdata->hwmon_dev, hwmon_temp, hwmon_temp_min_alarm, 0);
+		reported = true;
+	}
+
+	ret = regmap_read(drvdata->regmap, MAX31732_REG_SECOND_HIGH_STATUS, &reg_val);
+	if (ret)
+		return ret;
+
+	if (reg_val != 0) {
+		dev_crit(dev, "Secondary Overtemperature Alarm, R4:%d R3:%d R2:%d R1:%d L:%d.\n",
+			 !!(reg_val & BIT(4)), !!(reg_val & BIT(3)), !!(reg_val & BIT(2)),
+			 !!(reg_val & BIT(1)), !!(reg_val & BIT(0)));
+		hwmon_notify_event(drvdata->hwmon_dev, hwmon_temp, hwmon_temp_crit_alarm, 0);
+		reported = true;
+	}
+
+	ret = regmap_read(drvdata->regmap, MAX31732_REG_SECOND_LOW_STATUS, &reg_val);
+	if (ret)
+		return ret;
+
+	if (reg_val != 0) {
+		dev_crit(dev, "Secondary Undertemperature Alarm, R4:%d R3:%d R2:%d R1:%d L:%d.\n",
+			 !!(reg_val & BIT(4)), !!(reg_val & BIT(3)), !!(reg_val & BIT(2)),
+			 !!(reg_val & BIT(1)), !!(reg_val & BIT(0)));
+		hwmon_notify_event(drvdata->hwmon_dev, hwmon_temp, hwmon_temp_lcrit_alarm, 0);
+		reported = true;
+	}
+
+	if (!reported) {
+		if (irq == drvdata->irqs[0])
+			dev_err(dev, "ALARM1 interrupt received but status registers not set.\n");
+		else if (irq == drvdata->irqs[1])
+			dev_err(dev, "ALARM2 interrupt received but status registers not set.\n");
+		else
+			dev_err(dev, "Undefined interrupt source.\n");
+	}
+
+	return IRQ_HANDLED;
+}
+
+static const struct hwmon_channel_info *max31732_info[] = {
+	HWMON_CHANNEL_INFO(chip,
+			   HWMON_C_REGISTER_TZ),
+	HWMON_CHANNEL_INFO(temp,
+			   HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX | HWMON_T_LCRIT |
+			   HWMON_T_CRIT |
+			   HWMON_T_ENABLE |
+			   HWMON_T_MIN_ALARM | HWMON_T_MAX_ALARM | HWMON_T_CRIT_ALARM |
+			   HWMON_T_LCRIT_ALARM,
+			   HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX | HWMON_T_LCRIT |
+			   HWMON_T_CRIT |
+			   HWMON_T_OFFSET | HWMON_T_ENABLE |
+			   HWMON_T_MIN_ALARM | HWMON_T_MAX_ALARM | HWMON_T_CRIT_ALARM |
+			   HWMON_T_LCRIT_ALARM |
+			   HWMON_T_FAULT,
+			   HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX | HWMON_T_LCRIT |
+			   HWMON_T_CRIT |
+			   HWMON_T_OFFSET | HWMON_T_ENABLE |
+			   HWMON_T_MIN_ALARM | HWMON_T_MAX_ALARM | HWMON_T_CRIT_ALARM |
+			   HWMON_T_LCRIT_ALARM |
+			   HWMON_T_FAULT,
+			   HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX | HWMON_T_LCRIT |
+			   HWMON_T_CRIT |
+			   HWMON_T_OFFSET | HWMON_T_ENABLE |
+			   HWMON_T_MIN_ALARM | HWMON_T_MAX_ALARM | HWMON_T_CRIT_ALARM |
+			   HWMON_T_LCRIT_ALARM |
+			   HWMON_T_FAULT,
+			   HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX | HWMON_T_LCRIT |
+			   HWMON_T_CRIT |
+			   HWMON_T_OFFSET | HWMON_T_ENABLE |
+			   HWMON_T_MIN_ALARM | HWMON_T_MAX_ALARM | HWMON_T_CRIT_ALARM |
+			   HWMON_T_LCRIT_ALARM |
+			   HWMON_T_FAULT
+			   ),
+	NULL
+};
+
+static const struct hwmon_ops max31732_hwmon_ops = {
+	.is_visible = max31732_is_visible,
+	.read = max31732_read,
+	.write = max31732_write,
+};
+
+static const struct hwmon_chip_info max31732_chip_info = {
+	.ops = &max31732_hwmon_ops,
+	.info = max31732_info,
+};
+
+static int max31732_parse_alarms(struct device *dev, struct max31732_data *data)
+{
+	s32 ret;
+	u32 alarm_que;
+
+	if (fwnode_property_read_bool(dev_fwnode(dev), "adi,alarm1-interrupt-mode"))
+		ret = regmap_clear_bits(data->regmap, MAX31732_REG_CONF1, MAX3173X_ALARM_MODE);
+	else
+		ret = regmap_set_bits(data->regmap, MAX31732_REG_CONF1, MAX3173X_ALARM_MODE);
+
+	if (ret)
+		return ret;
+
+	if (fwnode_property_read_bool(dev_fwnode(dev), "adi,alarm2-interrupt-mode"))
+		ret = regmap_clear_bits(data->regmap, MAX31732_REG_CONF2, MAX3173X_ALARM_MODE);
+	else
+		ret = regmap_set_bits(data->regmap, MAX31732_REG_CONF2, MAX3173X_ALARM_MODE);
+
+	if (ret)
+		return ret;
+
+	alarm_que = MAX31732_ALARM_FAULT_QUE;
+	fwnode_property_read_u32(dev_fwnode(dev), "adi,alarm1-fault-queue", &alarm_que);
+
+	if ((alarm_que / 2) <= MAX31732_ALARM_FAULT_QUE_MAX) {
+		ret = regmap_write_bits(data->regmap, MAX31732_REG_CONF1,
+					MAX3173X_ALARM_FAULT_QUEUE_MASK,
+					FIELD_PREP(MAX3173X_ALARM_FAULT_QUEUE_MASK,
+						   (alarm_que / 2)));
+		if (ret)
+			return ret;
+	} else {
+		return dev_err_probe(dev, -EINVAL, "Invalid adi,alarm1-fault-queue.\n");
+	}
+
+	alarm_que = MAX31732_ALARM_FAULT_QUE;
+	fwnode_property_read_u32(dev_fwnode(dev), "adi,alarm2-fault-queue", &alarm_que);
+
+	if ((alarm_que / 2) <= MAX31732_ALARM_FAULT_QUE_MAX) {
+		ret = regmap_write_bits(data->regmap, MAX31732_REG_CONF2,
+					MAX3173X_ALARM_FAULT_QUEUE_MASK,
+					FIELD_PREP(MAX3173X_ALARM_FAULT_QUEUE_MASK,
+						   (alarm_que / 2)));
+	} else {
+		return dev_err_probe(dev, -EINVAL, "Invalid adi,alarm2-fault-queue.\n");
+	}
+
+	return ret;
+}
+
+static int max31732_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct max31732_data *data;
+	s32 ret;
+	u32 reg_val;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->client = client;
+
+	data->regmap = devm_regmap_init_i2c(client, &regmap_config);
+	if (IS_ERR(data->regmap))
+		return dev_err_probe(dev, PTR_ERR(data->regmap), "regmap init failed\n");
+
+	ret = regmap_read(data->regmap, MAX31732_REG_CHANNEL_ENABLE, &reg_val);
+	if (ret)
+		return ret;
+
+	if (reg_val == 0)
+		ret = regmap_set_bits(data->regmap, MAX31732_REG_CONF1, MAX3173X_STOP);
+	else
+		ret = regmap_clear_bits(data->regmap, MAX31732_REG_CONF1, MAX3173X_STOP);
+
+	if (ret)
+		return ret;
+
+	ret = regmap_clear_bits(data->regmap, MAX31732_REG_CONF1, MAX3173X_EXTRANGE);
+	if (ret)
+		return ret;
+
+	ret = max31732_parse_alarms(dev, data);
+	if (ret)
+		return ret;
+
+	dev_set_drvdata(dev, data);
+
+	data->irqs[0] = fwnode_irq_get_byname(dev_fwnode(dev), "ALARM1");
+	if (data->irqs[0] > 0) {
+		ret = devm_request_threaded_irq(dev, data->irqs[0], NULL, max31732_irq_handler,
+						IRQF_ONESHOT, client->name, dev);
+		if (ret)
+			return dev_err_probe(dev, ret, "cannot request irq\n");
+
+		ret = regmap_set_bits(data->regmap, MAX31732_REG_ALARM1_MASK,
+				      MAX31732_ALL_CHANNEL_MASK);
+		if (ret)
+			return ret;
+	} else {
+		ret = regmap_clear_bits(data->regmap, MAX31732_REG_ALARM1_MASK,
+					MAX31732_ALL_CHANNEL_MASK);
+		if (ret)
+			return ret;
+	}
+
+	data->irqs[1] = fwnode_irq_get_byname(dev_fwnode(dev), "ALARM2");
+	if (data->irqs[1] > 0) {
+		ret = devm_request_threaded_irq(dev, data->irqs[1], NULL, max31732_irq_handler,
+						IRQF_ONESHOT, client->name, dev);
+		if (ret)
+			return dev_err_probe(dev, ret, "cannot request irq\n");
+
+		ret = regmap_set_bits(data->regmap, MAX31732_REG_ALARM2_MASK,
+				      MAX31732_ALL_CHANNEL_MASK);
+		if (ret)
+			return ret;
+	} else {
+		ret = regmap_clear_bits(data->regmap, MAX31732_REG_ALARM2_MASK,
+					MAX31732_ALL_CHANNEL_MASK);
+		if (ret)
+			return ret;
+	}
+
+	data->hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name, data,
+							       &max31732_chip_info, NULL);
+
+	return PTR_ERR_OR_ZERO(data->hwmon_dev);
+}
+
+static const struct i2c_device_id max31732_ids[] = {
+	{ "max31732" },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(i2c, max31732_ids);
+
+static const struct of_device_id __maybe_unused max31732_of_match[] = {
+	{ .compatible = "adi,max31732", },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(of, max31732_of_match);
+
+static int __maybe_unused max31732_suspend(struct device *dev)
+{
+	struct max31732_data *data = dev_get_drvdata(dev);
+
+	return regmap_set_bits(data->regmap, MAX31732_REG_CONF1, MAX3173X_STOP);
+}
+
+static int __maybe_unused max31732_resume(struct device *dev)
+{
+	struct max31732_data *data = dev_get_drvdata(dev);
+
+	return regmap_clear_bits(data->regmap, MAX31732_REG_CONF1, MAX3173X_STOP);
+}
+
+static SIMPLE_DEV_PM_OPS(max31732_pm_ops, max31732_suspend, max31732_resume);
+
+static struct i2c_driver max31732_driver = {
+	.class		= I2C_CLASS_HWMON,
+	.driver = {
+		.name	= "max31732-driver",
+		.of_match_table = of_match_ptr(max31732_of_match),
+		.pm	= &max31732_pm_ops,
+	},
+	.probe_new	= max31732_probe,
+	.id_table	= max31732_ids,
+};
+
+module_i2c_driver(max31732_driver);
+
+MODULE_AUTHOR("Sinan Divarci <sinan.divarci@analog.com>");
+MODULE_DESCRIPTION("MAX31732 driver");
+MODULE_LICENSE("GPL");
+MODULE_VERSION("1.0");

base-commit: e2ca6ba6ba0152361aa4fcbf6067db71b2c7a770
-- 
2.25.1


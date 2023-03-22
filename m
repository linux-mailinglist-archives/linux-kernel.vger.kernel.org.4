Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286E56C4282
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 06:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjCVF7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 01:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjCVF6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 01:58:55 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE7917CC5;
        Tue, 21 Mar 2023 22:58:32 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32M0sI6x006655;
        Wed, 22 Mar 2023 01:58:27 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3pekwxv66u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 01:58:26 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 32M5wPFJ012708
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Mar 2023 01:58:25 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 22 Mar
 2023 01:58:24 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 22 Mar 2023 01:58:24 -0400
Received: from IST-LT-42339.ad.analog.com (IST-LT-42339.ad.analog.com [10.117.192.221] (may be forged))
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 32M5ueXL016875;
        Wed, 22 Mar 2023 01:58:13 -0400
From:   Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <sre@kernel.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <Zeynep.Arslanbenzer@analog.com>, <Nurettin.Bolucu@analog.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH v2 6/8] power: supply: max77658: Add ADI MAX77658 Battery Support
Date:   Wed, 22 Mar 2023 08:56:26 +0300
Message-ID: <20230322055628.4441-7-Zeynep.Arslanbenzer@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230322055628.4441-1-Zeynep.Arslanbenzer@analog.com>
References: <20230322055628.4441-1-Zeynep.Arslanbenzer@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: UEGHPYF8nkeiP_AW6smvuxCC4iwsHFIl
X-Proofpoint-GUID: UEGHPYF8nkeiP_AW6smvuxCC4iwsHFIl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_11,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 adultscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303220042
X-Spam-Status: No, score=-0.7 required=5.0 tests=RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Battery driver for ADI MAX77658.

The MAX77658 is an ultra-low power fuel gauge which implements the Maxim ModelGauge m5 EZ algorithm.

Signed-off-by: Nurettin Bolucu <Nurettin.Bolucu@analog.com>
Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
---
 drivers/power/supply/Kconfig            |   7 +
 drivers/power/supply/Makefile           |   1 +
 drivers/power/supply/max77658-battery.c | 646 ++++++++++++++++++++++++
 3 files changed, 654 insertions(+)
 create mode 100644 drivers/power/supply/max77658-battery.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 5787a4e90c98..0e6855501070 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -572,6 +572,13 @@ config CHARGER_MAX77658
 	  Say Y to enable support for the battery charger control of
 	  MAX77654/MAX77658/MAX77659 PMIC.
 
+config BATTERY_MAX77658
+	tristate "Analog Devices MAX77658 battery driver"
+	depends on MFD_MAX77658
+	help
+	  Say Y to enable support for the battery control of
+	  MAX77658 PMIC.
+
 config CHARGER_MAX77693
 	tristate "Maxim MAX77693 battery charger driver"
 	depends on MFD_MAX77693
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index af4bd6e5969f..e5a425d333a7 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -77,6 +77,7 @@ obj-$(CONFIG_CHARGER_MAX14577)	+= max14577_charger.o
 obj-$(CONFIG_CHARGER_DETECTOR_MAX14656)	+= max14656_charger_detector.o
 obj-$(CONFIG_CHARGER_MAX77650)	+= max77650-charger.o
 obj-$(CONFIG_CHARGER_MAX77658)	+= max77658-charger.o
+obj-$(CONFIG_BATTERY_MAX77658)	+= max77658-battery.o
 obj-$(CONFIG_CHARGER_MAX77693)	+= max77693_charger.o
 obj-$(CONFIG_CHARGER_MAX77976)	+= max77976_charger.o
 obj-$(CONFIG_CHARGER_MAX8997)	+= max8997_charger.o
diff --git a/drivers/power/supply/max77658-battery.c b/drivers/power/supply/max77658-battery.c
new file mode 100644
index 000000000000..23af6c97f734
--- /dev/null
+++ b/drivers/power/supply/max77658-battery.c
@@ -0,0 +1,646 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 Analog Devices, Inc.
+ * ADI battery driver for the MAX77658
+ */
+
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/mfd/max77658.h>
+#include <linux/module.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/power_supply.h>
+#include <linux/regmap.h>
+
+#define MAX77658_IALRTTH_RESOLUTION	8567
+#define MAX77658_CURRENT_RESOLUTION	33487
+#define MAX77658_VOLTAGE_RESOLUTION	78125
+#define MAX77658_FG_DELAY		1000
+#define MAX77658_BATTERY_FULL		100
+#define MAX77658_BATTERY_LOW		40
+#define MAX77658_BATTERY_CRITICAL	10
+#define MAX77658_MAXMINVOLT_STEP	20000
+#define MAX77658_VALRTTH_STEP		20000
+#define MAX77658_VEMPTY_VE_STEP		10000
+#define MAX77658_POWER_STEP		17100
+
+#define MAX77658_REG_STATUS	0x00
+#define MAX77658_REG_VALRTTH	0x01
+#define MAX77658_REG_TALRTTH	0x02
+#define MAX77658_REG_SALRTTH	0x03
+#define MAX77658_REG_CONFIG	0x1D
+#define MAX77658_REG_DEVNAME	0x21
+#define MAX77658_REG_VEMPTY	0x3A
+#define MAX77658_REG_AVGPOWER	0xB3
+#define MAX77658_REG_IALRTTH	0xB4
+#define MAX77658_REG_CONFIG2	0xBB
+#define MAX77658_REG_TEMP	0x08
+#define MAX77658_REG_VCELL	0x09
+#define MAX77658_REG_CURRENT	0x0A
+#define MAX77658_REG_AVGCURRENT	0x0B
+#define MAX77658_REG_AVGVCELL	0x19
+#define MAX77658_REG_MAXMINTEMP	0x1A
+#define MAX77658_REG_MAXMINVOLT	0x1B
+#define MAX77658_REG_MAXMINCURR	0x1C
+#define MAX77658_REG_REPSOC	0x06
+#define MAX77658_REG_TTE	0x11
+#define MAX77658_REG_TTF	0x20
+
+#define MAX77658_BIT_STATUS_BR		BIT(15)
+#define MAX77658_BIT_STATUS_SMX		BIT(14)
+#define MAX77658_BIT_STATUS_TMX		BIT(13)
+#define MAX77658_BIT_STATUS_VMX		BIT(12)
+#define MAX77658_BIT_STATUS_BI		BIT(11)
+#define MAX77658_BIT_STATUS_SMN		BIT(10)
+#define MAX77658_BIT_STATUS_TMN		BIT(9)
+#define MAX77658_BIT_STATUS_VMN		BIT(8)
+#define MAX77658_BIT_STATUS_POR		BIT(2)
+#define	MAX77658_BIT_CONFIG_AEN		BIT(2)
+#define MAX77658_BIT_SALRTTH_SMIN	GENMASK(7, 0)
+#define MAX77658_BIT_SALRTTH_SMAX	GENMASK(15, 8)
+#define MAX77658_BIT_TALRTTH_TMIN	GENMASK(7, 0)
+#define MAX77658_BIT_TALRTTH_TMAX	GENMASK(15, 8)
+#define MAX77658_BIT_IALRTTH_IMIN	GENMASK(7, 0)
+#define MAX77658_BIT_IALRTTH_IMAX	GENMASK(15, 8)
+#define MAX77658_BIT_MAXMINTEMP_MIN	GENMASK(7, 0)
+#define MAX77658_BIT_MAXMINTEMP_MAX	GENMASK(15, 8)
+#define MAX77658_BIT_MAXMINVOLT_MIN	GENMASK(7, 0)
+#define MAX77658_BIT_MAXMINVOLT_MAX	GENMASK(15, 8)
+#define MAX77658_BIT_VEMPTY_VE		GENMASK(15, 7)
+
+struct max77658_fg {
+	struct device *dev;
+	struct max77658_dev *max77658;
+	struct regmap *regmap;
+
+	struct delayed_work work;
+	struct power_supply *battery;
+	struct power_supply_desc psy_batt_d;
+
+	int vcell;
+	int soc;
+	int health;
+	int capacity_level;
+
+	int lasttime_vcell;
+	int lasttime_soc;
+
+	int volt_min_uv;
+	int volt_max_uv;
+	int temp_alert_min;
+	int temp_alert_max;
+	int soc_max;
+	int soc_min;
+	int curr_max_ma;
+	int curr_min_ma;
+};
+
+static int max77658_fg_get_soc(struct max77658_fg *max77658_fg)
+{
+	unsigned int soc;
+	int ret;
+
+	ret = regmap_read(max77658_fg->regmap, MAX77658_REG_REPSOC, &soc);
+	if (ret < 0) {
+		dev_dbg(max77658_fg->dev, "Error in reading register REPSOC\n");
+		return ret;
+	}
+
+	max77658_fg->soc = (u16)(soc >> 8);
+
+	if (max77658_fg->soc > MAX77658_BATTERY_FULL) {
+		max77658_fg->soc = MAX77658_BATTERY_FULL;
+		max77658_fg->capacity_level = POWER_SUPPLY_CAPACITY_LEVEL_FULL;
+		max77658_fg->health = POWER_SUPPLY_HEALTH_GOOD;
+	} else if (max77658_fg->soc < MAX77658_BATTERY_CRITICAL) {
+		max77658_fg->health = POWER_SUPPLY_HEALTH_DEAD;
+		max77658_fg->capacity_level =
+					POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;
+	} else if (max77658_fg->soc < MAX77658_BATTERY_LOW) {
+		max77658_fg->health = POWER_SUPPLY_HEALTH_DEAD;
+		max77658_fg->capacity_level = POWER_SUPPLY_CAPACITY_LEVEL_LOW;
+	} else {
+		max77658_fg->health = POWER_SUPPLY_HEALTH_GOOD;
+		max77658_fg->capacity_level =
+					POWER_SUPPLY_CAPACITY_LEVEL_NORMAL;
+	}
+
+	return 0;
+}
+
+static void max77658_stop_work(void *data)
+{
+	struct max77658_fg *max77658_fg = data;
+
+	cancel_delayed_work_sync(&max77658_fg->work);
+}
+
+static u16 max77658_raw_voltage_to_uv(unsigned int val)
+{
+	return (u16)val * MAX77658_VOLTAGE_RESOLUTION;
+}
+
+static void max77658_fg_work(struct work_struct *work)
+{
+	struct max77658_fg *max77658_fg;
+	unsigned int val;
+	int ret;
+
+	max77658_fg = container_of(work, struct max77658_fg, work.work);
+
+	ret = regmap_read(max77658_fg->regmap, MAX77658_REG_VCELL, &val);
+	if (ret < 0)
+		dev_err(max77658_fg->dev, "Error in reading register\n");
+	else
+		max77658_fg->vcell = max77658_raw_voltage_to_uv(val);
+
+	ret = max77658_fg_get_soc(max77658_fg);
+	if (ret < 0)
+		goto out;
+
+	if (max77658_fg->vcell != max77658_fg->lasttime_vcell ||
+	    max77658_fg->soc != max77658_fg->lasttime_soc) {
+		max77658_fg->lasttime_vcell = max77658_fg->vcell;
+		max77658_fg->lasttime_soc = max77658_fg->soc;
+
+		power_supply_changed(max77658_fg->battery);
+	}
+
+out:
+	schedule_delayed_work(&max77658_fg->work, MAX77658_FG_DELAY);
+}
+
+static enum power_supply_property max77658_fg_battery_props[] = {
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_VOLTAGE_AVG,
+	POWER_SUPPLY_PROP_VOLTAGE_MAX,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
+	POWER_SUPPLY_PROP_CAPACITY_ALERT_MIN,
+	POWER_SUPPLY_PROP_CAPACITY_ALERT_MAX,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_TEMP_ALERT_MIN,
+	POWER_SUPPLY_PROP_TEMP_ALERT_MAX,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CURRENT_MAX,
+	POWER_SUPPLY_PROP_CURRENT_AVG,
+	POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG,
+	POWER_SUPPLY_PROP_TIME_TO_FULL_AVG,
+	POWER_SUPPLY_PROP_TEMP_MAX,
+	POWER_SUPPLY_PROP_TEMP_MIN,
+	POWER_SUPPLY_PROP_POWER_AVG
+};
+
+static int max77658_property_is_writeable(struct power_supply *psy,
+					  enum power_supply_property psp)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
+	case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
+	case POWER_SUPPLY_PROP_CAPACITY_ALERT_MIN:
+	case POWER_SUPPLY_PROP_CAPACITY_ALERT_MAX:
+	case POWER_SUPPLY_PROP_TEMP_MAX:
+	case POWER_SUPPLY_PROP_TEMP_MIN:
+		return 1;
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
+static u16 max77658_raw_current_to_ua(unsigned int val)
+{
+	return sign_extend32(val, 15) * MAX77658_CURRENT_RESOLUTION / 1000000;
+}
+
+static int max77658_fg_get_property(struct power_supply *psy,
+				    enum power_supply_property psp,
+				    union power_supply_propval *val)
+{
+	struct max77658_fg *max77658_fg = power_supply_get_drvdata(psy);
+	unsigned int reg_val;
+	u8 field_val;
+	int ret = 0;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CAPACITY:
+		val->intval = max77658_fg->soc;
+		break;
+	case POWER_SUPPLY_PROP_HEALTH:
+		val->intval = max77658_fg->health;
+		break;
+	case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
+		val->intval = max77658_fg->capacity_level;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		val->intval = max77658_fg->vcell;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_AVG:
+		ret = regmap_read(max77658_fg->regmap, MAX77658_REG_AVGVCELL,
+				  &reg_val);
+		if (ret)
+			return ret;
+
+		val->intval = max77658_raw_voltage_to_uv(reg_val);
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
+		ret = regmap_read(max77658_fg->regmap, MAX77658_REG_MAXMINVOLT,
+				  &reg_val);
+		if (ret)
+			return ret;
+
+		val->intval = FIELD_GET(MAX77658_BIT_MAXMINVOLT_MAX, reg_val)
+			      * MAX77658_MAXMINVOLT_STEP;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
+		ret = regmap_read(max77658_fg->regmap, MAX77658_REG_MAXMINVOLT,
+				  &reg_val);
+		if (ret)
+			return ret;
+
+		val->intval = FIELD_GET(MAX77658_BIT_MAXMINVOLT_MIN, reg_val)
+			      * MAX77658_MAXMINVOLT_STEP;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
+		ret = regmap_read(max77658_fg->regmap, MAX77658_REG_VEMPTY,
+				  &reg_val);
+		if (ret)
+			return ret;
+
+		val->intval = FIELD_GET(MAX77658_BIT_VEMPTY_VE, reg_val)
+					* MAX77658_VEMPTY_VE_STEP;
+		break;
+	case POWER_SUPPLY_PROP_CAPACITY_ALERT_MIN:
+		ret = regmap_read(max77658_fg->regmap, MAX77658_REG_SALRTTH,
+				  &reg_val);
+		if (ret)
+			return ret;
+
+		val->intval = FIELD_GET(MAX77658_BIT_SALRTTH_SMIN, reg_val);
+		break;
+	case POWER_SUPPLY_PROP_CAPACITY_ALERT_MAX:
+		ret = regmap_read(max77658_fg->regmap, MAX77658_REG_SALRTTH,
+				  &reg_val);
+		if (ret)
+			return ret;
+
+		val->intval = FIELD_GET(MAX77658_BIT_SALRTTH_SMAX, reg_val);
+		break;
+	case POWER_SUPPLY_PROP_TEMP:
+		ret = regmap_read(max77658_fg->regmap, MAX77658_REG_TEMP,
+				  &reg_val);
+		if (ret)
+			return ret;
+
+		val->intval = sign_extend32(reg_val, 15);
+		val->intval = val->intval >> 8;
+		break;
+	case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
+		ret = regmap_read(max77658_fg->regmap, MAX77658_REG_TALRTTH,
+				  &reg_val);
+		if (ret)
+			return ret;
+
+		val->intval = sign_extend32(reg_val & 0xff, 7);
+		break;
+	case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
+		ret = regmap_read(max77658_fg->regmap, MAX77658_REG_TALRTTH,
+				  &reg_val);
+		if (ret)
+			return ret;
+
+		val->intval = sign_extend32(reg_val >> 8, 7);
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		ret = regmap_read(max77658_fg->regmap, MAX77658_REG_CURRENT,
+				  &reg_val);
+		if (ret)
+			return ret;
+
+		val->intval = max77658_raw_current_to_ua(reg_val);
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_AVG:
+		ret = regmap_read(max77658_fg->regmap, MAX77658_REG_AVGCURRENT,
+				  &reg_val);
+		if (ret)
+			return ret;
+
+		val->intval = max77658_raw_current_to_ua(reg_val);
+		break;
+	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG:
+		ret = regmap_read(max77658_fg->regmap, MAX77658_REG_TTE,
+				  &reg_val);
+		if (ret)
+			return ret;
+
+		val->intval = (reg_val * 45) >> 3;
+		break;
+	case POWER_SUPPLY_PROP_TIME_TO_FULL_AVG:
+		ret = regmap_read(max77658_fg->regmap, MAX77658_REG_TTF,
+				  &reg_val);
+		if (ret)
+			return ret;
+
+		val->intval = (reg_val * 45) >> 3;
+		break;
+	case POWER_SUPPLY_PROP_TEMP_MIN:
+		ret = regmap_read(max77658_fg->regmap, MAX77658_REG_MAXMINTEMP,
+				  &reg_val);
+		if (ret)
+			return ret;
+
+		field_val = FIELD_GET(MAX77658_BIT_MAXMINTEMP_MIN, reg_val);
+		val->intval = sign_extend32(field_val, 7);
+		break;
+	case POWER_SUPPLY_PROP_TEMP_MAX:
+		ret = regmap_read(max77658_fg->regmap, MAX77658_REG_MAXMINTEMP,
+				  &reg_val);
+		if (ret)
+			return ret;
+
+		field_val = FIELD_GET(MAX77658_BIT_MAXMINTEMP_MAX, reg_val);
+		val->intval = sign_extend32(field_val, 7);
+
+		break;
+	case POWER_SUPPLY_PROP_POWER_AVG:
+		ret = regmap_read(max77658_fg->regmap, MAX77658_REG_AVGPOWER,
+				  &reg_val);
+		if (ret)
+			return ret;
+
+		val->intval = reg_val * MAX77658_POWER_STEP;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_MAX:
+		ret = regmap_read(max77658_fg->regmap, MAX77658_REG_MAXMINCURR,
+				  &reg_val);
+		if (ret)
+			return ret;
+
+		val->intval = FIELD_GET(MAX77658_BIT_MAXMINTEMP_MAX, reg_val)
+			      * MAX77658_IALRTTH_RESOLUTION;
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int max77658_fg_set_property(struct power_supply *psy,
+				    enum power_supply_property psp,
+				    const union power_supply_propval *val)
+{
+	struct max77658_fg *max77658_fg = power_supply_get_drvdata(psy);
+	int ret = 0;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
+		ret = regmap_update_bits(max77658_fg->regmap,
+					 MAX77658_REG_TALRTTH,
+					 MAX77658_BIT_TALRTTH_TMIN,
+					 val->intval);
+		break;
+	case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
+		ret = regmap_update_bits(max77658_fg->regmap,
+					 MAX77658_REG_TALRTTH,
+					 MAX77658_BIT_TALRTTH_TMAX,
+					 val->intval);
+		break;
+	case POWER_SUPPLY_PROP_CAPACITY_ALERT_MIN:
+		ret = regmap_update_bits(max77658_fg->regmap,
+					 MAX77658_REG_SALRTTH,
+					 MAX77658_BIT_SALRTTH_SMIN,
+					 val->intval);
+		break;
+	case POWER_SUPPLY_PROP_CAPACITY_ALERT_MAX:
+		ret = regmap_update_bits(max77658_fg->regmap,
+					 MAX77658_REG_SALRTTH,
+					 MAX77658_BIT_SALRTTH_SMAX,
+					 val->intval);
+		break;
+	case POWER_SUPPLY_PROP_TEMP_MIN:
+		ret = regmap_update_bits(max77658_fg->regmap,
+					 MAX77658_REG_MAXMINTEMP,
+					 MAX77658_BIT_MAXMINTEMP_MIN,
+					 val->intval);
+		break;
+	case POWER_SUPPLY_PROP_TEMP_MAX:
+		ret = regmap_update_bits(max77658_fg->regmap,
+					 MAX77658_REG_MAXMINTEMP,
+					 MAX77658_BIT_MAXMINTEMP_MAX,
+					 val->intval);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int max77658_set_alert_thresholds(struct max77658_fg *max77658_fg)
+{
+	unsigned int val;
+	int ret;
+
+	val = (max77658_fg->volt_min_uv / MAX77658_VALRTTH_STEP);
+	val |= ((max77658_fg->volt_max_uv / MAX77658_VALRTTH_STEP) << 8);
+	ret = regmap_write(max77658_fg->regmap, MAX77658_REG_VALRTTH, val);
+	if (ret)
+		return dev_err_probe(max77658_fg->dev, ret,
+				     "Error in writing register VALRTTH\n");
+
+	val = FIELD_PREP(MAX77658_BIT_TALRTTH_TMAX, max77658_fg->temp_alert_max)
+	   | FIELD_PREP(MAX77658_BIT_TALRTTH_TMIN, max77658_fg->temp_alert_min);
+	ret = regmap_write(max77658_fg->regmap, MAX77658_REG_TALRTTH, val);
+	if (ret)
+		return dev_err_probe(max77658_fg->dev, ret,
+				     "Error in writing register TALRTTH\n");
+
+	val = FIELD_PREP(MAX77658_BIT_SALRTTH_SMAX, max77658_fg->soc_max) |
+		  FIELD_PREP(MAX77658_BIT_SALRTTH_SMIN, max77658_fg->soc_min);
+	ret = regmap_write(max77658_fg->regmap, MAX77658_REG_SALRTTH, val);
+	if (ret)
+		return dev_err_probe(max77658_fg->dev, ret,
+				     "Error in writing register SALRTTH\n");
+
+	val = FIELD_PREP(MAX77658_BIT_IALRTTH_IMAX,
+			 max77658_fg->curr_max_ma / MAX77658_IALRTTH_RESOLUTION)
+	      | FIELD_PREP(MAX77658_BIT_IALRTTH_IMIN,
+	      (max77658_fg->curr_min_ma / MAX77658_IALRTTH_RESOLUTION));
+
+	return regmap_write(max77658_fg->regmap, MAX77658_REG_IALRTTH, val);
+}
+
+static int max77658_fg_initialize(struct max77658_fg *max77658_fg)
+{
+	unsigned int reg;
+	int ret;
+
+	ret = max77658_set_alert_thresholds(max77658_fg);
+	if (ret)
+		return dev_err_probe(max77658_fg->dev, ret,
+				     "Error in setting alert thresholds\n");
+
+	ret = regmap_read(max77658_fg->regmap, MAX77658_REG_STATUS, &reg);
+	if (ret)
+		return dev_err_probe(max77658_fg->dev, ret,
+				     "Error in reading register STATUS\n");
+
+	ret = regmap_write(max77658_fg->regmap, MAX77658_REG_STATUS,
+			   reg & ~MAX77658_BIT_STATUS_POR);
+	if (ret)
+		return dev_err_probe(max77658_fg->dev, ret,
+				     "Error in writing register STATUS\n");
+
+	schedule_delayed_work(&max77658_fg->work, MAX77658_FG_DELAY);
+	return 0;
+}
+
+static void max77658_fg_parse_dt(struct max77658_fg *max77658_fg)
+{
+	struct device *dev = max77658_fg->dev;
+	int ret;
+
+	ret = device_property_read_u32(dev, "adi,valrt-min-microvolt",
+				       &max77658_fg->volt_min_uv);
+	if (ret) {
+		dev_dbg(dev,
+			"Could not read adi,valrt-min-microvolt DT property\n");
+		max77658_fg->volt_min_uv = 0;
+	}
+
+	ret = device_property_read_u32(dev, "adi,valrt-max-microvolt",
+				       &max77658_fg->volt_max_uv);
+	if (ret) {
+		dev_dbg(dev,
+			"Could not read adi,valrt-max-microvolt DT property\n");
+		max77658_fg->volt_max_uv = 5100000;
+	}
+
+	ret = device_property_read_u32(dev, "adi,salrt-min-percent",
+				       &max77658_fg->soc_min);
+	if (ret) {
+		dev_dbg(dev,
+			"Could not read adi,salrt-min-percent DT property\n");
+		max77658_fg->soc_min = 0;
+	}
+
+	ret = device_property_read_u32(dev, "adi,salrt-max-percent",
+				       &max77658_fg->soc_max);
+	if (ret) {
+		dev_dbg(dev,
+			"Could not read adi,salrt-max-percent DT property\n");
+		max77658_fg->soc_max = 255;
+	}
+
+	ret = device_property_read_u32(dev, "adi,ialrt-min-microamp",
+				       &max77658_fg->curr_min_ma);
+	if (ret) {
+		dev_dbg(dev,
+			"Could not read adi,ialrt-min-microamp DT property\n");
+		max77658_fg->curr_min_ma = MAX77658_IALRTTH_RESOLUTION * (-128);
+	}
+
+	ret = device_property_read_u32(dev, "adi,ialrt-max-microamp",
+				       &max77658_fg->curr_max_ma);
+	if (ret) {
+		dev_dbg(dev,
+			"Could not read adi,ialrt-max-microamp DT property\n");
+		max77658_fg->curr_max_ma = MAX77658_IALRTTH_RESOLUTION * 127;
+	}
+}
+
+static int max77658_fg_probe(struct platform_device *pdev)
+{
+	struct max77658_dev *max77658 = dev_get_drvdata(pdev->dev.parent);
+	struct power_supply_battery_info *info;
+	struct power_supply_config fg_cfg = {};
+	struct device *dev = &pdev->dev;
+	struct max77658_fg *fg;
+	int ret = 0;
+
+	fg = devm_kzalloc(&pdev->dev, sizeof(*fg), GFP_KERNEL);
+	if (!fg)
+		return -ENOMEM;
+
+	fg->dev = &pdev->dev;
+	fg->regmap = max77658->regmap_fg;
+
+	fg->psy_batt_d.name = "max77658-battery";
+	fg->psy_batt_d.type = POWER_SUPPLY_TYPE_BATTERY;
+	fg->psy_batt_d.get_property = max77658_fg_get_property;
+	fg->psy_batt_d.set_property = max77658_fg_set_property;
+	fg->psy_batt_d.properties = max77658_fg_battery_props;
+	fg->psy_batt_d.property_is_writeable = max77658_property_is_writeable;
+	fg->psy_batt_d.num_properties = ARRAY_SIZE(max77658_fg_battery_props);
+	fg_cfg.drv_data = fg;
+
+	INIT_DELAYED_WORK(&fg->work, max77658_fg_work);
+	ret = devm_add_action(&pdev->dev, max77658_stop_work, fg);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Error in setting delayed work\n");
+
+	fg->battery = devm_power_supply_register(dev, &fg->psy_batt_d,
+						 &fg_cfg);
+	if (IS_ERR(fg->battery))
+		return dev_err_probe(&pdev->dev, PTR_ERR(fg->battery),
+				     "Failed to register battery\n");
+
+	fg->battery->of_node = of_get_child_by_name(dev->parent->of_node,
+						    "fuel-gauge");
+
+	if (!fg->battery->of_node)
+		dev_err(dev,
+			"of_get_child_by_name\n");
+
+	ret = power_supply_get_battery_info(fg->battery, &info);
+	if (ret) {
+		dev_err(fg->dev, "Unable to get battery info\n");
+		fg->temp_alert_min = info->temp_alert_min;
+		fg->temp_alert_max = info->temp_alert_max;
+	} else {
+		fg->temp_alert_min = -128;
+		fg->temp_alert_max = 127;
+	}
+
+	max77658_fg_parse_dt(fg);
+
+	ret =  max77658_fg_initialize(fg);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Error in initializing fuel gauge\n");
+	return 0;
+}
+
+static const struct of_device_id max77658_battery_of_id[] = {
+	{ .compatible = "adi,max77658-battery" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, max77658_battery_of_id);
+
+static const struct platform_device_id max77658_fg_id[] = {
+	{ "max77658-battery", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(platform, max77658_fg_id);
+
+static struct platform_driver max77658_fg_driver = {
+	.driver = {
+		.name = "max77658-battery",
+		.of_match_table = max77658_battery_of_id,
+	},
+	.probe = max77658_fg_probe,
+	.id_table = max77658_fg_id,
+};
+
+module_platform_driver(max77658_fg_driver);
+
+MODULE_DESCRIPTION("MAX77658 Fuel Gauge Driver");
+MODULE_AUTHOR("Nurettin.Bolucu@analog.com, Zeynep.Arslanbenzer@analog.com");
+MODULE_LICENSE("GPL");
-- 
2.25.1


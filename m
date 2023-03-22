Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5A16C427B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 06:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjCVF6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 01:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjCVF6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 01:58:22 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19611117B;
        Tue, 21 Mar 2023 22:58:13 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32M0rsUP006592;
        Wed, 22 Mar 2023 01:58:09 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3pekwxv65w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 01:58:09 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 32M5w7Tk053842
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Mar 2023 01:58:07 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 22 Mar 2023 01:58:07 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 22 Mar 2023 01:58:06 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 22 Mar 2023 01:58:06 -0400
Received: from IST-LT-42339.ad.analog.com (IST-LT-42339.ad.analog.com [10.117.192.221] (may be forged))
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 32M5ueXJ016875;
        Wed, 22 Mar 2023 01:57:51 -0400
From:   Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <sre@kernel.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <Zeynep.Arslanbenzer@analog.com>, <Nurettin.Bolucu@analog.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH v2 4/8] power: supply: max77658: Add ADI MAX77654/58/59 Charger Support
Date:   Wed, 22 Mar 2023 08:56:24 +0300
Message-ID: <20230322055628.4441-5-Zeynep.Arslanbenzer@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230322055628.4441-1-Zeynep.Arslanbenzer@analog.com>
References: <20230322055628.4441-1-Zeynep.Arslanbenzer@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: oiD3M_klrLM7SBPWFJ3GOatyzer1iUtZ
X-Proofpoint-GUID: oiD3M_klrLM7SBPWFJ3GOatyzer1iUtZ
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

Charger driver for ADI MAX77654/MAX77658/MAX77659.

The MAX77654/MAX77658/MAX77659 charger is Smart Power Selector Li+/Li-Poly Charger.

Signed-off-by: Nurettin Bolucu <Nurettin.Bolucu@analog.com>
Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
---
 drivers/power/supply/Kconfig            |   7 +
 drivers/power/supply/Makefile           |   1 +
 drivers/power/supply/max77658-charger.c | 745 ++++++++++++++++++++++++
 3 files changed, 753 insertions(+)
 create mode 100644 drivers/power/supply/max77658-charger.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 0bbfe6a7ce4d..5787a4e90c98 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -565,6 +565,13 @@ config CHARGER_MAX77650
 	  Say Y to enable support for the battery charger control of MAX77650
 	  PMICs.
 
+config CHARGER_MAX77658
+	tristate "Analog Devices MAX77654/MAX77658/MAX77659 battery charger driver"
+	depends on MFD_MAX77658
+	help
+	  Say Y to enable support for the battery charger control of
+	  MAX77654/MAX77658/MAX77659 PMIC.
+
 config CHARGER_MAX77693
 	tristate "Maxim MAX77693 battery charger driver"
 	depends on MFD_MAX77693
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 0ee8653e882e..af4bd6e5969f 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -76,6 +76,7 @@ obj-$(CONFIG_CHARGER_LTC4162L)	+= ltc4162-l-charger.o
 obj-$(CONFIG_CHARGER_MAX14577)	+= max14577_charger.o
 obj-$(CONFIG_CHARGER_DETECTOR_MAX14656)	+= max14656_charger_detector.o
 obj-$(CONFIG_CHARGER_MAX77650)	+= max77650-charger.o
+obj-$(CONFIG_CHARGER_MAX77658)	+= max77658-charger.o
 obj-$(CONFIG_CHARGER_MAX77693)	+= max77693_charger.o
 obj-$(CONFIG_CHARGER_MAX77976)	+= max77976_charger.o
 obj-$(CONFIG_CHARGER_MAX8997)	+= max8997_charger.o
diff --git a/drivers/power/supply/max77658-charger.c b/drivers/power/supply/max77658-charger.c
new file mode 100644
index 000000000000..0d42d50ebf40
--- /dev/null
+++ b/drivers/power/supply/max77658-charger.c
@@ -0,0 +1,745 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 Analog Devices, Inc.
+ * ADI charger driver for the MAX77654/MAX77658/MAX77659
+ */
+
+#include <linux/bitfield.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/max77658.h>
+#include <linux/module.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/power_supply.h>
+#include <linux/regmap.h>
+
+#define MAX77659_CHG_IRQ_MAX			5
+
+#define MAX77658_CHARGER_CURRENT_MAX		300000
+#define MAX77658_CHARGER_CURRENT_MIN		7500
+#define MAX77658_CHARGER_CURRENT_STEP		7500
+#define MAX77658_CNFG_B_ICHGIN_LIM_MAX		475000
+#define MAX77658_CNFG_B_ICHGIN_LIM_MIN		95000
+#define MAX77658_CNFG_B_ICHGIN_LIM_STEP		95000
+#define MAX77658_CNFG_B_ICHGIN_LIM_REG_MAX	4
+#define MAX77658_CHARGER_TOPOFF_TIMER_STEP	5
+
+#define MAX77658_REG_STAT_CHG_A	0x02
+#define MAX77658_REG_STAT_CHG_B	0x03
+#define MAX77658_REG_CNFG_CHG_A	0x20
+#define MAX77658_REG_CNFG_CHG_B	0x21
+#define MAX77658_REG_CNFG_CHG_C	0x22
+#define MAX77658_REG_CNFG_CHG_D	0x23
+#define MAX77658_REG_CNFG_CHG_E	0x24
+#define MAX77658_REG_CNFG_CHG_F	0x25
+#define MAX77658_REG_CNFG_CHG_G	0x26
+#define MAX77658_REG_CNFG_CHG_H	0x27
+#define MAX77658_REG_CNFG_CHG_I	0x28
+
+#define MAX77658_BIT_STAT_A_THM_DTLS		GENMASK(2, 0)
+#define MAX77658_BIT_STAT_A_TJ_REG_STAT		BIT(3)
+#define MAX77658_BIT_STAT_A_VSYSY_MIN_STAT	BIT(4)
+#define MAX77658_BIT_STAT_A_ICHGIN_LIM_STAT	BIT(5)
+#define MAX77658_BIT_STAT_A_VCHGIN_MIN_STAT	BIT(6)
+#define MAX77658_BIT_STAT_B_CHG			BIT(1)
+#define MAX77658_BIT_STAT_B_CHGIN_DTSL		GENMASK(3, 2)
+#define MAX77658_BIT_STAT_B_CHG_DTLS		GENMASK(7, 4)
+#define MAX77658_BIT_CNFG_B_CHG_EN		BIT(0)
+#define MAX77658_BIT_CNFG_B_ICHGIN_LIM		GENMASK(4, 2)
+#define MAX77658_BIT_CNFG_C_TOPOFFTIMER		GENMASK(2, 0)
+#define MAX77658_BIT_CNFG_E_TFASTCHG		GENMASK(1, 0)
+#define MAX77658_BIT_CNFG_E_CC			GENMASK(7, 2)
+#define MAX77658_BIT_CNFG_G_CHG_CV		GENMASK(7, 2)
+
+enum {
+	MAX77658_CHG_DTLS_OFF,
+	MAX77658_CHG_DTLS_PREQUAL,
+	MAX77658_CHG_DTLS_FASTCHARGE_CC,
+	MAX77658_CHG_DTLS_JEITA_FASTCHARGE_CC,
+	MAX77658_CHG_DTLS_FASTCHARGE_CV,
+	MAX77658_CHG_DTLS_JEITA_FASTCHARGE_CV,
+	MAX77658_CHG_DTLS_TOPOFF,
+	MAX77658_CHG_DTLS_JEITA_TOPOFF,
+	MAX77658_CHG_DTLS_DONE,
+	MAX77658_CHG_DTLS_JEITA_DONE,
+	MAX77658_CHG_DTLS_OFF_TIMER_FAULT,
+	MAX77658_CHG_DTLS_OFF_CHARGE_TIMER_FAULT,
+	MAX77658_CHG_DTLS_OFF_BATTERY_TEMP_FAULT,
+	MAX77658_CHG_DTLS_RESERVED_13,
+};
+
+enum {
+	MAX77658_CHG_IRQ_THM_I,
+	MAX77658_CHG_IRQ_CHG_I,
+	MAX77658_CHG_IRQ_CHGIN_I,
+	MAX77658_CHG_IRQ_TJ_REG_I,
+	MAX77658_CHG_IRQ_SYS_CTRL_I,
+	MAX77658_CHG_IRQ_CHGIN_CTRL_I,
+	MAX77658_CHG_IRQ_SYS_CNFG_I,
+	MAX77658_CHG_IRQ_MAX,
+};
+
+struct max77658_charger {
+	struct device *dev;
+	struct max77658_dev *max77658;
+	struct regmap *regmap;
+
+	struct power_supply *psy_chg;
+	struct power_supply_desc psy_chg_d;
+
+	int irq;
+	int irq_arr[MAX77658_CHG_IRQ_MAX];
+	int irq_mask;
+
+	struct delayed_work irq_work;
+
+	int present;
+	int health;
+	int status;
+	int charge_type;
+
+	unsigned int fast_charge_current_ua;
+	unsigned int fast_charge_timer_hr;
+	unsigned int input_current_limit_ua;
+	unsigned int topoff_timer_min;
+};
+
+static int max77658_set_input_current_limit(struct max77658_charger *charger,
+					    int input_current)
+{
+	u8 reg_data = 0;
+
+	input_current = clamp_val(input_current, MAX77658_CNFG_B_ICHGIN_LIM_MIN,
+				  MAX77658_CNFG_B_ICHGIN_LIM_MAX);
+	if (charger->max77658->chip->id == ID_MAX77658) {
+		reg_data = MAX77658_CNFG_B_ICHGIN_LIM_REG_MAX + 1
+			   - DIV_ROUND_UP(input_current,
+					  MAX77658_CNFG_B_ICHGIN_LIM_STEP);
+	} else {
+		reg_data = DIV_ROUND_UP(input_current,
+					MAX77658_CNFG_B_ICHGIN_LIM_STEP) - 1;
+	}
+
+	reg_data = FIELD_PREP(MAX77658_BIT_CNFG_B_ICHGIN_LIM, reg_data);
+	return regmap_update_bits(charger->regmap, MAX77658_REG_CNFG_CHG_B,
+				  MAX77658_BIT_CNFG_B_ICHGIN_LIM, reg_data);
+}
+
+static int max77658_get_input_current_limit(struct max77658_charger *charger,
+					    int *get_current)
+{
+	unsigned int reg_data = 0;
+	int ret;
+
+	ret = regmap_read(charger->regmap, MAX77658_REG_CNFG_CHG_B, &reg_data);
+	if (ret)
+		return ret;
+
+	reg_data = FIELD_GET(MAX77658_BIT_CNFG_B_ICHGIN_LIM, reg_data);
+
+	if (charger->max77658->chip->id == ID_MAX77658) {
+		*get_current = (MAX77658_CNFG_B_ICHGIN_LIM_REG_MAX + 1
+				- reg_data) * MAX77658_CNFG_B_ICHGIN_LIM_STEP;
+	} else {
+		*get_current = (reg_data + 1) * MAX77658_CNFG_B_ICHGIN_LIM_STEP;
+	}
+
+	return 0;
+}
+
+static int max77658_set_charge_current(struct max77658_charger *charger,
+				       int fast_charge_current_ua)
+{
+	unsigned int reg_data;
+
+	fast_charge_current_ua = clamp_val(fast_charge_current_ua,
+					   MAX77658_CHARGER_CURRENT_MIN,
+					   MAX77658_CHARGER_CURRENT_MAX);
+	reg_data = fast_charge_current_ua / MAX77658_CHARGER_CURRENT_STEP - 1;
+	reg_data = FIELD_PREP(MAX77658_BIT_CNFG_E_CC, reg_data);
+
+	return regmap_update_bits(charger->regmap, MAX77658_REG_CNFG_CHG_E,
+				  MAX77658_BIT_CNFG_E_CC, reg_data);
+}
+
+static int max77658_get_charge_current(struct max77658_charger *charger,
+				       int *get_current)
+{
+	unsigned int reg_data, current_val;
+	int ret;
+
+	ret = regmap_read(charger->regmap, MAX77658_REG_CNFG_CHG_E, &reg_data);
+	if (ret)
+		return ret;
+
+	reg_data = FIELD_GET(MAX77658_BIT_CNFG_E_CC, reg_data);
+	current_val = (reg_data + 1) * MAX77658_CHARGER_CURRENT_STEP;
+
+	*get_current = clamp_val(current_val, MAX77658_CHARGER_CURRENT_MIN,
+				 MAX77658_CHARGER_CURRENT_MAX);
+
+	return 0;
+}
+
+static int max77658_set_topoff_timer(struct max77658_charger *charger,
+				     int termination_time_min)
+{
+	unsigned int reg_data;
+
+	termination_time_min = clamp_val(termination_time_min, 0,
+					 MAX77658_BIT_CNFG_C_TOPOFFTIMER
+					 * MAX77658_CHARGER_TOPOFF_TIMER_STEP);
+	reg_data = FIELD_PREP(MAX77658_BIT_CNFG_C_TOPOFFTIMER,
+			      termination_time_min
+			      / MAX77658_CHARGER_TOPOFF_TIMER_STEP);
+
+	return regmap_update_bits(charger->regmap, MAX77658_REG_CNFG_CHG_C,
+				  MAX77658_BIT_CNFG_C_TOPOFFTIMER, reg_data);
+}
+
+static int max77658_charger_initialize(struct max77658_charger *charger)
+{
+	unsigned int val;
+	int ret;
+
+	ret = max77658_set_charge_current(charger,
+					  charger->fast_charge_current_ua);
+	if (ret)
+		return dev_err_probe(charger->dev, ret,
+				     "Error in writing register CNFG_CHG_C\n");
+
+	if (charger->fast_charge_timer_hr == 0 ||
+	    charger->fast_charge_timer_hr > 7)
+		val = 0x00;
+	else if (charger->fast_charge_timer_hr < 3)
+		val = 0x01;
+	else
+		val = DIV_ROUND_UP(charger->fast_charge_timer_hr - 1, 2);
+
+	ret = regmap_update_bits(charger->regmap, MAX77658_REG_CNFG_CHG_E,
+				 MAX77658_BIT_CNFG_E_TFASTCHG, val);
+	if (ret)
+		return dev_err_probe(charger->dev, ret,
+				     "Error in writing register CNFG_CHG_E\n");
+
+	ret = max77658_set_input_current_limit(charger,
+					       charger->input_current_limit_ua);
+	if (ret)
+		return dev_err_probe(charger->dev, ret,
+				     "Error in writing register CNFG_CHG_B\n");
+
+	return max77658_set_topoff_timer(charger, charger->topoff_timer_min);
+}
+
+static void max77658_charger_parse_dt(struct max77658_charger *charger)
+{
+	int ret;
+
+	ret = device_property_read_u32(charger->dev, "adi,fast-charge-timer",
+				       &charger->fast_charge_timer_hr);
+	if (ret) {
+		dev_dbg(charger->dev,
+			"Could not read fast-charge-timer DT property\n");
+		charger->fast_charge_timer_hr = 5;
+	}
+
+	ret = device_property_read_u32(charger->dev, "adi,topoff-timer",
+				       &charger->topoff_timer_min);
+	if (ret) {
+		dev_dbg(charger->dev,
+			"Could not read topoff-timer DT property\n");
+		charger->topoff_timer_min = 30;
+	}
+
+	ret = device_property_read_u32(charger->dev,
+				       "adi,input-current-limit-microamp",
+		&charger->input_current_limit_ua);
+	if (ret) {
+		dev_dbg(charger->dev,
+			"Could not read input-current-limit DT property\n");
+		charger->input_current_limit_ua = 475000;
+	}
+}
+
+struct max77658_charger_status_map {
+	int health;
+	int status;
+	int charge_type;
+};
+
+#define STATUS_MAP(_MAX77658_CHG_DTLS, _health, _status, _charge_type) \
+	[MAX77658_CHG_DTLS_##_MAX77658_CHG_DTLS] = {\
+		.health = POWER_SUPPLY_HEALTH_##_health,\
+		.status = POWER_SUPPLY_STATUS_##_status,\
+		.charge_type = POWER_SUPPLY_CHARGE_TYPE_##_charge_type,\
+	}
+
+static struct max77658_charger_status_map max77658_charger_status_map[] = {
+	/* chg_details_xx, health, status, charge_type */
+	STATUS_MAP(OFF, UNKNOWN, NOT_CHARGING, NONE),
+	STATUS_MAP(PREQUAL, GOOD, CHARGING, TRICKLE),
+	STATUS_MAP(FASTCHARGE_CC, GOOD, CHARGING, FAST),
+	STATUS_MAP(JEITA_FASTCHARGE_CC, GOOD, CHARGING, FAST),
+	STATUS_MAP(FASTCHARGE_CV, GOOD, CHARGING, FAST),
+	STATUS_MAP(JEITA_FASTCHARGE_CV, GOOD, CHARGING, FAST),
+	STATUS_MAP(TOPOFF, GOOD, CHARGING, FAST),
+	STATUS_MAP(JEITA_TOPOFF, GOOD, CHARGING, FAST),
+	STATUS_MAP(DONE, GOOD, FULL, NONE),
+	STATUS_MAP(JEITA_DONE, GOOD, FULL, NONE),
+	STATUS_MAP(OFF_TIMER_FAULT, SAFETY_TIMER_EXPIRE, NOT_CHARGING, NONE),
+	STATUS_MAP(OFF_CHARGE_TIMER_FAULT, UNKNOWN, NOT_CHARGING, NONE),
+	STATUS_MAP(OFF_BATTERY_TEMP_FAULT, HOT, NOT_CHARGING, NONE),
+};
+
+static int max77658_charger_update(struct max77658_charger *charger)
+{
+	unsigned int stat_chg_b, chg_dtls;
+	int ret;
+
+	ret = regmap_read(charger->regmap, MAX77658_REG_STAT_CHG_B,
+			  &stat_chg_b);
+	if (ret) {
+		charger->health = POWER_SUPPLY_HEALTH_UNKNOWN;
+		charger->status = POWER_SUPPLY_STATUS_UNKNOWN;
+		charger->charge_type = POWER_SUPPLY_CHARGE_TYPE_UNKNOWN;
+		return ret;
+	}
+
+	charger->present = stat_chg_b & MAX77658_BIT_STAT_B_CHG;
+	if (!charger->present) {
+		charger->health = POWER_SUPPLY_HEALTH_UNKNOWN;
+		charger->status = POWER_SUPPLY_STATUS_DISCHARGING;
+		charger->charge_type = POWER_SUPPLY_CHARGE_TYPE_UNKNOWN;
+		return 0;
+	}
+
+	chg_dtls = FIELD_GET(MAX77658_BIT_STAT_B_CHG_DTLS, stat_chg_b);
+
+	charger->health = max77658_charger_status_map[chg_dtls].health;
+	charger->status = max77658_charger_status_map[chg_dtls].status;
+	charger->charge_type =
+			max77658_charger_status_map[chg_dtls].charge_type;
+
+	return 0;
+}
+
+static enum power_supply_property max77658_charger_props[] = {
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_CHARGE_TYPE,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CURRENT_MAX
+};
+
+static enum power_supply_property max77659_charger_props[] = {
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_CHARGE_TYPE,
+	POWER_SUPPLY_PROP_CURRENT_NOW
+};
+
+static int max77658_property_is_writeable(struct power_supply *psy,
+					  enum power_supply_property psp)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+	case POWER_SUPPLY_PROP_CURRENT_MAX:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
+static int max77659_property_is_writeable(struct power_supply *psy,
+					  enum power_supply_property psp)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
+static int max77658_charger_get_property(struct power_supply *psy,
+					 enum power_supply_property psp,
+					 union power_supply_propval *val)
+{
+	struct max77658_charger *charger = power_supply_get_drvdata(psy);
+	int ret;
+
+	ret = max77658_charger_update(charger);
+	if (ret)
+		return ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval = charger->present;
+		break;
+	case POWER_SUPPLY_PROP_HEALTH:
+		val->intval = charger->health;
+		break;
+	case POWER_SUPPLY_PROP_STATUS:
+		val->intval = charger->status;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+		val->intval = charger->charge_type;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		ret = max77658_get_charge_current(charger, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_MAX:
+		if (charger->max77658->chip->id != ID_MAX77659) {
+			ret = max77658_get_input_current_limit(charger,
+							       &val->intval);
+		} else {
+			ret = -EINVAL;
+		}
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int max77658_charger_set_property(struct power_supply *psy,
+					 enum power_supply_property psp,
+					 const union power_supply_propval *val)
+{
+	struct max77658_charger *charger = power_supply_get_drvdata(psy);
+	int ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+		ret = regmap_update_bits(charger->regmap,
+					 MAX77658_REG_CNFG_CHG_B,
+					 MAX77658_BIT_CNFG_B_CHG_EN,
+					 !!val->intval);
+		if (ret)
+			return ret;
+
+		ret =
+		max77658_set_charge_current(charger,
+					    charger->fast_charge_current_ua);
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		/* val->intval - uA */
+		ret = max77658_set_charge_current(charger, val->intval);
+		if (ret)
+			return ret;
+
+		charger->fast_charge_current_ua = val->intval;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_MAX:
+		if (charger->max77658->chip->id == ID_MAX77659) {
+			ret = -EINVAL;
+			break;
+		}
+		ret = max77658_set_input_current_limit(charger, val->intval);
+		if (ret)
+			return ret;
+
+		charger->input_current_limit_ua = val->intval;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static void max77658_charger_irq_handler(struct max77658_charger *charger,
+					 int irq)
+{
+	int chg_present, vchgin, ichgin;
+	unsigned int val, stat_chg_b;
+	int ret;
+
+	switch (irq) {
+	case MAX77658_CHG_IRQ_THM_I:
+		ret = regmap_read(charger->regmap, MAX77658_REG_STAT_CHG_A,
+				  &val);
+		if (ret) {
+			dev_err(charger->dev, "Failed to read STAT_CHG_A\n");
+			return;
+		}
+
+		val = FIELD_GET(MAX77658_BIT_STAT_A_THM_DTLS, val);
+		dev_dbg(charger->dev, "CHG_INT_THM: thm_dtls = %02Xh\n", val);
+		break;
+
+	case MAX77658_CHG_IRQ_CHG_I:
+		ret = regmap_read(charger->regmap, MAX77658_REG_STAT_CHG_B,
+				  &val);
+		if (ret) {
+			dev_err(charger->dev, "Failed to read STAT_CHG_B\n");
+			return;
+		}
+
+		val = FIELD_GET(MAX77658_BIT_STAT_B_CHG_DTLS, val);
+		dev_dbg(charger->dev,
+			"CHG_INT_CHG: MAX77658_CHG_DTLS = %02Xh\n", val);
+		break;
+
+	case MAX77658_CHG_IRQ_CHGIN_I:
+		ret = regmap_read(charger->regmap,
+				  MAX77658_REG_STAT_CHG_B, &val);
+		if (ret) {
+			dev_err(charger->dev, "Failed to read STAT_CHG_B\n");
+			return;
+		}
+
+		val = FIELD_GET(MAX77658_BIT_STAT_B_CHG_DTLS, val);
+		dev_dbg(charger->dev,
+			"CHG_INT_CHG: MAX77658_CHG_DTLS = %02Xh\n", val);
+
+		ret = regmap_read(charger->regmap, MAX77658_REG_STAT_CHG_B,
+				  &stat_chg_b);
+		if (ret) {
+			dev_err(charger->dev, "Failed to read STAT_CHG_B\n");
+			return;
+		}
+
+		chg_present = stat_chg_b & MAX77658_BIT_STAT_B_CHG;
+
+		regmap_update_bits(charger->regmap, MAX77658_REG_CNFG_CHG_B,
+				   MAX77658_BIT_CNFG_B_CHG_EN, !!chg_present);
+		if (chg_present)
+			break;
+
+		max77658_set_charge_current(charger,
+					    charger->fast_charge_current_ua);
+		break;
+
+	case MAX77658_CHG_IRQ_TJ_REG_I:
+		ret = regmap_read(charger->regmap, MAX77658_REG_STAT_CHG_A,
+				  &val);
+		if (ret) {
+			dev_err(charger->dev, "Failed to read STAT_CHG_A\n");
+			return;
+		}
+
+		val = FIELD_GET(MAX77658_BIT_STAT_A_TJ_REG_STAT, val);
+		dev_dbg(charger->dev,
+			"CHG_INT_TJ_REG: tj_reg_stat = %02Xh\n", val);
+		dev_dbg(charger->dev,
+			"CHG_INT_TJ_REG: Die temperature %s Tj-reg\n",
+			 val ? "has exceeded" : "has not exceeded");
+		break;
+
+	case MAX77658_CHG_IRQ_SYS_CTRL_I:
+		ret = regmap_read(charger->regmap, MAX77658_REG_STAT_CHG_A,
+				  &val);
+		if (ret) {
+			dev_err(charger->dev, "Failed to read STAT_CHG_A\n");
+			return;
+		}
+
+		val = FIELD_GET(MAX77658_BIT_STAT_A_VSYSY_MIN_STAT, val);
+		dev_dbg(charger->dev,
+			"CHG_INT_SYS_CTRL: The minimum system voltage regulation loop %s\n",
+			 val ? "has engaged" : "has not engaged");
+		break;
+
+	case MAX77658_CHG_IRQ_CHGIN_CTRL_I:
+		ret = regmap_read(charger->regmap, MAX77658_REG_STAT_CHG_A,
+				  &val);
+		if (ret) {
+			dev_dbg(charger->dev, "Failed to read STAT_CHG_A\n");
+			return;
+		}
+
+		vchgin = FIELD_GET(MAX77658_BIT_STAT_A_VCHGIN_MIN_STAT, val);
+		dev_dbg(charger->dev, "CHG_INT_CHGIN: VCHGIN_MIN_STAT %s\n",
+			vchgin ? "has changed" : "has not changed");
+
+		ichgin = FIELD_GET(MAX77658_BIT_STAT_A_ICHGIN_LIM_STAT, val);
+		dev_dbg(charger->dev, "CHG_INT_CHGIN: ICHGIN_LIM_STAT %s\n",
+			ichgin ? "has changed" : "has not changed");
+		break;
+
+	case MAX77658_CHG_IRQ_SYS_CNFG_I:
+		ret = regmap_read(charger->regmap, MAX77658_REG_CNFG_CHG_G,
+				  &val);
+		if (ret) {
+			dev_dbg(charger->dev, "Failed to read CNFG_CHG_G\n");
+			return;
+		}
+
+		val = FIELD_GET(MAX77658_BIT_CNFG_G_CHG_CV, val);
+		dev_dbg(charger->dev, "CHG_INT_SYS_CNFG: CHG_VC = %02Xh\n",
+			val);
+		break;
+
+	default:
+		break;
+	}
+
+	power_supply_changed(charger->psy_chg);
+}
+
+static irqreturn_t max77658_charger_isr(int irq, void *data)
+{
+	struct max77658_charger *charger = data;
+
+	charger->irq = irq;
+	max77658_charger_update(charger);
+	max77658_charger_irq_handler(charger,
+				     charger->irq - charger->irq_arr[0]);
+
+	return IRQ_HANDLED;
+}
+
+static const char * const max77658_irq_descs[] = {
+	"charger-thm",
+	"charger-chg",
+	"charger-chgin",
+	"charger-tj-reg",
+	"charger-sys-ctrl",
+	"charger-chgin-ctrl",
+	"charger-sys-cnfg",
+};
+
+static int max77658_charger_probe(struct platform_device *pdev)
+{
+	struct max77658_dev *max77658 = dev_get_drvdata(pdev->dev.parent);
+	struct power_supply_config charger_cfg = {};
+	struct power_supply_battery_info *info;
+	struct max77658_charger *charger;
+	struct device *dev = &pdev->dev;
+	int i, n_irq, ret;
+
+	charger = devm_kzalloc(dev, sizeof(*charger), GFP_KERNEL);
+	if (!charger)
+		return -ENOMEM;
+
+	charger->dev = dev;
+	charger->max77658 = max77658;
+	charger->regmap = dev_get_regmap(charger->dev->parent, NULL);
+
+	charger->psy_chg_d.get_property	= max77658_charger_get_property;
+	charger->psy_chg_d.set_property	= max77658_charger_set_property;
+	charger->psy_chg_d.type = POWER_SUPPLY_TYPE_USB;
+	charger_cfg.of_node = dev->of_node;
+	charger_cfg.drv_data = charger;
+
+	switch (max77658->chip->id) {
+	case ID_MAX77654:
+		charger->psy_chg_d.properties = max77658_charger_props;
+		charger->psy_chg_d.num_properties =
+					ARRAY_SIZE(max77658_charger_props);
+		charger->psy_chg_d.name = "max77654-charger";
+		charger->psy_chg_d.property_is_writeable =
+				max77658_property_is_writeable;
+		n_irq = MAX77658_CHG_IRQ_MAX;
+		break;
+	case ID_MAX77658:
+		charger->psy_chg_d.properties = max77658_charger_props;
+		charger->psy_chg_d.num_properties =
+					ARRAY_SIZE(max77658_charger_props);
+		charger->psy_chg_d.name = "max77658-charger";
+		charger->psy_chg_d.property_is_writeable =
+				max77658_property_is_writeable;
+		n_irq = MAX77658_CHG_IRQ_MAX;
+		break;
+	case ID_MAX77659:
+		charger->psy_chg_d.properties = max77659_charger_props;
+		charger->psy_chg_d.num_properties =
+					ARRAY_SIZE(max77659_charger_props);
+		charger->psy_chg_d.name = "max77659-charger";
+		charger->psy_chg_d.property_is_writeable =
+				max77659_property_is_writeable;
+		n_irq = MAX77659_CHG_IRQ_MAX;
+		break;
+	default:
+		break;
+	}
+
+	charger->psy_chg = devm_power_supply_register(dev, &charger->psy_chg_d,
+						      &charger_cfg);
+	if (IS_ERR(charger->psy_chg))
+		return dev_err_probe(dev, PTR_ERR(charger->psy_chg),
+				     "Failed to register power supply\n");
+
+	charger->psy_chg->of_node = of_get_child_by_name(dev->parent->of_node,
+							 "charger");
+
+	if (!charger->psy_chg->of_node)
+		dev_err(charger->dev,
+			"of_get_child_by_name\n");
+
+	ret = power_supply_get_battery_info(charger->psy_chg, &info);
+	if (ret) {
+		dev_err(charger->dev, "Unable to get charger info\n");
+		charger->fast_charge_current_ua = 15000;
+	} else {
+		charger->fast_charge_current_ua =
+			info->constant_charge_current_max_ua;
+	}
+
+	max77658_charger_parse_dt(charger);
+
+	ret = max77658_charger_initialize(charger);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to initialize charger\n");
+
+	for (i = 0; i < n_irq; i++) {
+		charger->irq_arr[i] =
+				regmap_irq_get_virq(max77658->irqc_chg, i);
+
+		if (charger->irq_arr[i] < 0)
+			return dev_err_probe(dev, -EINVAL,
+					     "Invalid IRQ for MAX77658_CHG_IRQ %d\n",
+					     i);
+
+		ret = devm_request_threaded_irq(dev, charger->irq_arr[i],
+						NULL, max77658_charger_isr,
+						IRQF_TRIGGER_FALLING,
+						max77658_irq_descs[i], charger);
+		if (ret)
+			return dev_err_probe(dev, ret,
+						 "Failed to request irq: %d\n",
+						 charger->irq_arr[i]);
+	}
+
+	return 0;
+}
+
+static const struct of_device_id max77658_charger_of_id[] = {
+	{ .compatible = "adi,max77654-charger" },
+	{ .compatible = "adi,max77658-charger" },
+	{ .compatible = "adi,max77659-charger" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, max77658_charger_of_id);
+
+static const struct platform_device_id max77658_charger_id[] = {
+	{ "max77654-charger" },
+	{ "max77658-charger" },
+	{ "max77659-charger" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, max77658_charger_id);
+
+static struct platform_driver max77658_charger_driver = {
+	.driver = {
+		.name = "max77658-charger",
+		.of_match_table = max77658_charger_of_id,
+	},
+	.probe = max77658_charger_probe,
+	.id_table = max77658_charger_id,
+};
+
+module_platform_driver(max77658_charger_driver);
+
+MODULE_DESCRIPTION("MAX77658 Charger Driver");
+MODULE_AUTHOR("Nurettin.Bolucu@analog.com, Zeynep.Arslanbenzer@analog.com");
+MODULE_LICENSE("GPL");
-- 
2.25.1


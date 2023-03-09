Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2FA6B3163
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 23:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjCIWvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 17:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjCIWuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 17:50:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B42F7EDF;
        Thu,  9 Mar 2023 14:50:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D504761D1B;
        Thu,  9 Mar 2023 22:50:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08484C433A0;
        Thu,  9 Mar 2023 22:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678402246;
        bh=SSBVCBpnRcjlaOW5Jpyryn0OebgyhMRXGKYdYC08d4g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ggD2TpUNdKuqny1/UKbyn+8N0vRnG+9UDxQHS8Ikarfk/iN06DFQx/jDhdaKAgQ81
         UBIHMhfhW9HGWAZuepg+zsNxjOkjQ/3p4cDiaO9AUZGHIeOkRCFy3qTZuETy0epfvJ
         gLFhKxhXCtsI44Z3nabAVUZ28b66nqO55CtuSjp6wbZ9A7bRemlKn6utU7XtnilKpO
         /sfhL91OLUUPchdaXkS7zeeqKclNtfcLahOJgUir3S2/MkW1h23saBw2D+HYG83eFy
         k3R+SKNPzKJFgt+cNH2aeuwGROJiAe37hBNKdtD/Mlmei/raN9KEOUv+tQQo3dcDpC
         ufadyE/JK5jmg==
Received: by mercury (Postfix, from userid 1000)
        id 61E1310608B3; Thu,  9 Mar 2023 23:50:43 +0100 (CET)
From:   Sebastian Reichel <sre@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCHv1 02/11] power: supply: core: auto-exposure of simple-battery data
Date:   Thu,  9 Mar 2023 23:50:32 +0100
Message-Id: <20230309225041.477440-3-sre@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230309225041.477440-1-sre@kernel.org>
References: <20230309225041.477440-1-sre@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for automatically exposing data from the
simple-battery firmware node with a single configuration
option in the power-supply device.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/power/supply/power_supply_core.c  | 153 +++++++++++++++++++---
 drivers/power/supply/power_supply_sysfs.c |  16 +++
 include/linux/power_supply.h              |  31 +++++
 3 files changed, 181 insertions(+), 19 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index f3d7c1da299f..c3684ec46b3f 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -388,7 +388,7 @@ static int __power_supply_get_supplier_property(struct device *dev, void *_data)
 	struct psy_get_supplier_prop_data *data = _data;
 
 	if (__power_supply_is_supplied_by(epsy, data->psy))
-		if (!epsy->desc->get_property(epsy, data->psp, data->val))
+		if (!power_supply_get_property(epsy, data->psp, data->val))
 			return 1; /* Success */
 
 	return 0; /* Continue iterating */
@@ -832,6 +832,111 @@ void power_supply_put_battery_info(struct power_supply *psy,
 }
 EXPORT_SYMBOL_GPL(power_supply_put_battery_info);
 
+bool power_supply_battery_info_has_prop(struct power_supply_battery_info *info,
+				        enum power_supply_property psp)
+{
+	if (!info)
+		return false;
+
+	switch (psp) {
+		case POWER_SUPPLY_PROP_TECHNOLOGY:
+			return info->technology != POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
+		case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
+			return info->energy_full_design_uwh >= 0;
+		case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
+			return info->charge_full_design_uah >= 0;
+		case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
+			return info->voltage_min_design_uv >= 0;
+		case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
+			return info->voltage_max_design_uv >= 0;
+		case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
+			return info->precharge_current_ua >= 0;
+		case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
+			return info->charge_term_current_ua >= 0;
+		case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
+			return info->constant_charge_current_max_ua >= 0;
+		case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
+			return info->constant_charge_voltage_max_uv >= 0;
+		case POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MIN:
+			return info->temp_ambient_alert_min > INT_MIN;
+		case POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MAX:
+			return info->temp_ambient_alert_max < INT_MAX;
+		case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
+			return info->temp_alert_min > INT_MIN;
+		case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
+			return info->temp_alert_max < INT_MAX;
+		case POWER_SUPPLY_PROP_TEMP_MIN:
+			return info->temp_min > INT_MIN;
+		case POWER_SUPPLY_PROP_TEMP_MAX:
+			return info->temp_max < INT_MAX;
+		default:
+			return false;
+	}
+}
+EXPORT_SYMBOL_GPL(power_supply_battery_info_has_prop);
+
+int power_supply_battery_info_get_prop(struct power_supply_battery_info *info,
+				       enum power_supply_property psp,
+				       union power_supply_propval *val)
+{
+	if (!info)
+		return -EINVAL;
+
+	if (!power_supply_battery_info_has_prop(info, psp))
+		return -EINVAL;
+
+	switch (psp) {
+		case POWER_SUPPLY_PROP_TECHNOLOGY:
+			val->intval = info->technology;
+			return 0;
+		case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
+			val->intval = info->energy_full_design_uwh;
+			return 0;
+		case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
+			val->intval = info->charge_full_design_uah;
+			return 0;
+		case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
+			val->intval = info->voltage_min_design_uv;
+			return 0;
+		case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
+			val->intval = info->voltage_max_design_uv;
+			return 0;
+		case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
+			val->intval = info->precharge_current_ua;
+			return 0;
+		case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
+			val->intval = info->charge_term_current_ua;
+			return 0;
+		case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
+			val->intval = info->constant_charge_current_max_ua;
+			return 0;
+		case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
+			val->intval = info->constant_charge_voltage_max_uv;
+			return 0;
+		case POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MIN:
+			val->intval = info->temp_ambient_alert_min;
+			return 0;
+		case POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MAX:
+			val->intval = info->temp_ambient_alert_max;
+			return 0;
+		case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
+			val->intval = info->temp_alert_min;
+			return 0;
+		case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
+			val->intval = info->temp_alert_max;
+			return 0;
+		case POWER_SUPPLY_PROP_TEMP_MIN:
+			val->intval = info->temp_min;
+			return 0;
+		case POWER_SUPPLY_PROP_TEMP_MAX:
+			val->intval = info->temp_max;
+			return 0;
+		default:
+			return -EINVAL;
+	}
+}
+EXPORT_SYMBOL_GPL(power_supply_battery_info_get_prop);
+
 /**
  * power_supply_temp2resist_simple() - find the battery internal resistance
  * percent from temperature
@@ -1046,6 +1151,22 @@ bool power_supply_battery_bti_in_range(struct power_supply_battery_info *info,
 }
 EXPORT_SYMBOL_GPL(power_supply_battery_bti_in_range);
 
+static bool psy_has_property(const struct power_supply_desc *psy_desc,
+			     enum power_supply_property psp)
+{
+	bool found = false;
+	int i;
+
+	for (i = 0; i < psy_desc->num_properties; i++) {
+		if (psy_desc->properties[i] == psp) {
+			found = true;
+			break;
+		}
+	}
+
+	return found;
+}
+
 int power_supply_get_property(struct power_supply *psy,
 			    enum power_supply_property psp,
 			    union power_supply_propval *val)
@@ -1056,9 +1177,13 @@ int power_supply_get_property(struct power_supply *psy,
 		return -ENODEV;
 	}
 
-	return psy->desc->get_property(psy, psp, val);
+	if (psy_has_property(psy->desc, psp))
+		return psy->desc->get_property(psy, psp, val);
+	else if(psy->desc->expose_battery_info)
+		return power_supply_battery_info_get_prop(psy->battery_info, psp, val);
+	else
+		return -EINVAL;
 }
-EXPORT_SYMBOL_GPL(power_supply_get_property);
 
 int power_supply_set_property(struct power_supply *psy,
 			    enum power_supply_property psp,
@@ -1117,22 +1242,6 @@ void power_supply_unreg_notifier(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(power_supply_unreg_notifier);
 
-static bool psy_has_property(const struct power_supply_desc *psy_desc,
-			     enum power_supply_property psp)
-{
-	bool found = false;
-	int i;
-
-	for (i = 0; i < psy_desc->num_properties; i++) {
-		if (psy_desc->properties[i] == psp) {
-			found = true;
-			break;
-		}
-	}
-
-	return found;
-}
-
 #ifdef CONFIG_THERMAL
 static int power_supply_read_temp(struct thermal_zone_device *tzd,
 		int *temp)
@@ -1255,6 +1364,12 @@ __power_supply_register(struct device *parent,
 		goto check_supplies_failed;
 	}
 
+	if (psy->desc->expose_battery_info) {
+		rc = power_supply_get_battery_info(psy, &psy->battery_info);
+		if (rc)
+			goto check_supplies_failed;
+	}
+
 	spin_lock_init(&psy->changed_lock);
 	rc = device_add(dev);
 	if (rc)
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index c228205e0953..8822a17f9589 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -380,6 +380,11 @@ static umode_t power_supply_attr_is_visible(struct kobject *kobj,
 		}
 	}
 
+	if (psy->desc->expose_battery_info) {
+		if (power_supply_battery_info_has_prop(psy->battery_info, attrno))
+			return mode;
+	}
+
 	return 0;
 }
 
@@ -488,6 +493,17 @@ int power_supply_uevent(const struct device *dev, struct kobj_uevent_env *env)
 			goto out;
 	}
 
+	if (psy->desc->expose_battery_info) {
+		for (j = 0; j < ARRAY_SIZE(power_supply_battery_info_properties); j++) {
+			if (!power_supply_battery_info_has_prop(psy->battery_info, power_supply_battery_info_properties[j]))
+				continue;
+			ret = add_prop_uevent(dev, env, power_supply_battery_info_properties[j],
+				      prop_buf);
+			if (ret)
+				goto out;
+		}
+	}
+
 out:
 	free_page((unsigned long)prop_buf);
 
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index aa2c4a7c4826..de0ea8320f3d 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -275,6 +275,13 @@ struct power_supply_desc {
 	 * sensors or other supplies.
 	 */
 	bool no_thermal;
+	/*
+	 * Set if constant battery information from firmware should be
+	 * exposed automatically. No driver specific code is required
+	 * in that case. If the driver also handles a property provided
+	 * by constant firmware data, the driver's handler is preferred.
+	 */
+	bool expose_battery_info;
 	/* For APM emulation, think legacy userspace. */
 	int use_for_apm;
 };
@@ -301,6 +308,7 @@ struct power_supply {
 	bool initialized;
 	bool removing;
 	atomic_t use_cnt;
+	struct power_supply_battery_info *battery_info;
 #ifdef CONFIG_THERMAL
 	struct thermal_zone_device *tzd;
 	struct thermal_cooling_device *tcd;
@@ -766,6 +774,24 @@ struct power_supply_battery_info {
 	int bti_resistance_tolerance;
 };
 
+static const enum power_supply_property power_supply_battery_info_properties[] = {
+	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
+	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
+	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
+	POWER_SUPPLY_PROP_PRECHARGE_CURRENT,
+	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
+	POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MIN,
+	POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MAX,
+	POWER_SUPPLY_PROP_TEMP_ALERT_MIN,
+	POWER_SUPPLY_PROP_TEMP_ALERT_MAX,
+	POWER_SUPPLY_PROP_TEMP_MIN,
+	POWER_SUPPLY_PROP_TEMP_MAX,
+};
+
 extern struct atomic_notifier_head power_supply_notifier;
 extern int power_supply_reg_notifier(struct notifier_block *nb);
 extern void power_supply_unreg_notifier(struct notifier_block *nb);
@@ -795,6 +821,11 @@ extern int power_supply_get_battery_info(struct power_supply *psy,
 					 struct power_supply_battery_info **info_out);
 extern void power_supply_put_battery_info(struct power_supply *psy,
 					  struct power_supply_battery_info *info);
+extern bool power_supply_battery_info_has_prop(struct power_supply_battery_info *info,
+					       enum power_supply_property psp);
+extern int power_supply_battery_info_get_prop(struct power_supply_battery_info *info,
+					      enum power_supply_property psp,
+					      union power_supply_propval *val);
 extern int power_supply_ocv2cap_simple(struct power_supply_battery_ocv_table *table,
 				       int table_len, int ocv);
 extern struct power_supply_battery_ocv_table *
-- 
2.39.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C519D6BF580
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 23:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjCQW5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 18:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjCQW5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 18:57:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488F62BF1A;
        Fri, 17 Mar 2023 15:57:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99C9E60C22;
        Fri, 17 Mar 2023 22:57:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5CFCC4339B;
        Fri, 17 Mar 2023 22:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679093831;
        bh=6ZDPGK5ClEjNmh+zvDkD8+i5hUX7iKdXMWrXPyXHhho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u4yVcRp/5e/pe24Ef20vucldureaG75QpXphEzfC2tNhYMliRyjcxhteqxjVQt/iM
         5gMAb9nqNmTcH2Y4Muf1AZ1rhTQzelyAzQDXEH25dPcc/mPxrH6kWzMr4wvZKR5BZy
         da1Mldirr+ViGbuF498mgnPIBux0rXArgAf3pDIjl0jDbTcKAyYkKnNoBVsSrzM0EW
         51jrQem1pmVckgwYSLeWX2sFLGxEyMuPNhMdciHH+/EzvG9mTQ5qRfyuSVkjeivmD7
         cvKHEgfjY3H/F0ML2LchdXqdSif+Tl5yLA6GGu2JETa91/rjQsAYSQOnjsvPrQQJI1
         ddVXOPy9YCFBA==
Received: by mercury (Postfix, from userid 1000)
        id 86A8410620FF; Fri, 17 Mar 2023 23:57:08 +0100 (CET)
From:   Sebastian Reichel <sre@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCHv3 02/14] power: supply: core: auto-exposure of simple-battery data
Date:   Fri, 17 Mar 2023 23:56:55 +0100
Message-Id: <20230317225707.1552512-3-sre@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317225707.1552512-1-sre@kernel.org>
References: <20230317225707.1552512-1-sre@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Automatically expose data from the simple-battery firmware
node for all battery drivers.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/power/supply/power_supply_core.c  | 179 +++++++++++++++++++---
 drivers/power/supply/power_supply_sysfs.c |  23 ++-
 include/linux/power_supply.h              |   8 +
 3 files changed, 191 insertions(+), 19 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index f3d7c1da299f..ab65cbaa55f6 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -388,7 +388,7 @@ static int __power_supply_get_supplier_property(struct device *dev, void *_data)
 	struct psy_get_supplier_prop_data *data = _data;
 
 	if (__power_supply_is_supplied_by(epsy, data->psy))
-		if (!epsy->desc->get_property(epsy, data->psp, data->val))
+		if (!power_supply_get_property(epsy, data->psp, data->val))
 			return 1; /* Success */
 
 	return 0; /* Continue iterating */
@@ -832,6 +832,133 @@ void power_supply_put_battery_info(struct power_supply *psy,
 }
 EXPORT_SYMBOL_GPL(power_supply_put_battery_info);
 
+const enum power_supply_property power_supply_battery_info_properties[] = {
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
+EXPORT_SYMBOL_GPL(power_supply_battery_info_properties);
+
+const size_t power_supply_battery_info_properties_size = ARRAY_SIZE(power_supply_battery_info_properties);
+EXPORT_SYMBOL_GPL(power_supply_battery_info_properties_size);
+
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
@@ -1046,6 +1173,22 @@ bool power_supply_battery_bti_in_range(struct power_supply_battery_info *info,
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
@@ -1056,7 +1199,12 @@ int power_supply_get_property(struct power_supply *psy,
 		return -ENODEV;
 	}
 
-	return psy->desc->get_property(psy, psp, val);
+	if (psy_has_property(psy->desc, psp))
+		return psy->desc->get_property(psy, psp, val);
+	else if (power_supply_battery_info_has_prop(psy->battery_info, psp))
+		return power_supply_battery_info_get_prop(psy->battery_info, psp, val);
+	else
+		return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(power_supply_get_property);
 
@@ -1117,22 +1265,6 @@ void power_supply_unreg_notifier(struct notifier_block *nb)
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
@@ -1255,6 +1387,17 @@ __power_supply_register(struct device *parent,
 		goto check_supplies_failed;
 	}
 
+	/*
+	 * Expose constant battery info, if it is available. While there are
+	 * some chargers accessing constant battery data, we only want to
+	 * expose battery data to userspace for battery devices.
+	 */
+	if (desc->type == POWER_SUPPLY_TYPE_BATTERY) {
+		rc = power_supply_get_battery_info(psy, &psy->battery_info);
+		if (rc && rc != -ENODEV)
+			goto check_supplies_failed;
+	}
+
 	spin_lock_init(&psy->changed_lock);
 	rc = device_add(dev);
 	if (rc)
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index c228205e0953..ba3b125cd66e 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -221,9 +221,10 @@ static struct power_supply_attr power_supply_attrs[] = {
 	POWER_SUPPLY_ATTR(MANUFACTURER),
 	POWER_SUPPLY_ATTR(SERIAL_NUMBER),
 };
+#define POWER_SUPPLY_ATTR_CNT ARRAY_SIZE(power_supply_attrs)
 
 static struct attribute *
-__power_supply_attrs[ARRAY_SIZE(power_supply_attrs) + 1];
+__power_supply_attrs[POWER_SUPPLY_ATTR_CNT + 1];
 
 static struct power_supply_attr *to_ps_attr(struct device_attribute *attr)
 {
@@ -380,6 +381,9 @@ static umode_t power_supply_attr_is_visible(struct kobject *kobj,
 		}
 	}
 
+	if (power_supply_battery_info_has_prop(psy->battery_info, attrno))
+		return mode;
+
 	return 0;
 }
 
@@ -461,6 +465,10 @@ static int add_prop_uevent(const struct device *dev, struct kobj_uevent_env *env
 int power_supply_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
 	const struct power_supply *psy = dev_get_drvdata(dev);
+	const enum power_supply_property *battery_props =
+		power_supply_battery_info_properties;
+	unsigned long psy_drv_properties[POWER_SUPPLY_ATTR_CNT /
+					 sizeof(unsigned long) + 1] = {0};
 	int ret = 0, j;
 	char *prop_buf;
 
@@ -482,12 +490,25 @@ int power_supply_uevent(const struct device *dev, struct kobj_uevent_env *env)
 		goto out;
 
 	for (j = 0; j < psy->desc->num_properties; j++) {
+		set_bit(psy->desc->properties[j], psy_drv_properties);
 		ret = add_prop_uevent(dev, env, psy->desc->properties[j],
 				      prop_buf);
 		if (ret)
 			goto out;
 	}
 
+	for (j = 0; j < power_supply_battery_info_properties_size; j++) {
+		if (test_bit(battery_props[j], psy_drv_properties))
+			continue;
+		if (!power_supply_battery_info_has_prop(psy->battery_info,
+				battery_props[j]))
+			continue;
+		ret = add_prop_uevent(dev, env, battery_props[j],
+			      prop_buf);
+		if (ret)
+			goto out;
+	}
+
 out:
 	free_page((unsigned long)prop_buf);
 
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index aa2c4a7c4826..a427f13c757f 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -301,6 +301,7 @@ struct power_supply {
 	bool initialized;
 	bool removing;
 	atomic_t use_cnt;
+	struct power_supply_battery_info *battery_info;
 #ifdef CONFIG_THERMAL
 	struct thermal_zone_device *tzd;
 	struct thermal_cooling_device *tcd;
@@ -791,10 +792,17 @@ devm_power_supply_get_by_phandle(struct device *dev, const char *property)
 { return NULL; }
 #endif /* CONFIG_OF */
 
+extern const enum power_supply_property power_supply_battery_info_properties[];
+extern const size_t power_supply_battery_info_properties_size;
 extern int power_supply_get_battery_info(struct power_supply *psy,
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


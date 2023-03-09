Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C326B316E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 23:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjCIWvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 17:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjCIWuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 17:50:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1A1F9EDD;
        Thu,  9 Mar 2023 14:50:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 366FC61D26;
        Thu,  9 Mar 2023 22:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ADE2C433EF;
        Thu,  9 Mar 2023 22:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678402248;
        bh=/6k04eEl52blbA5RWXlAMS3FZFJp/si00AtoB5jWUi0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eoBnYatnn5omFjQzLW9OGHv8JuoYUBtbp/nksrFQM4h/ClufLKJcrRvbBFqOcnOP8
         22fgDOC6LVSyyihld9PCVelLNjaZoIA8eTO8z9+2nGovJFZeOjc6AYMtd1HEs66GdH
         COUruQqMVqCsIJAN/azo8ssJia6QfTY7BYaWBq58gajB6gEevzCt7CLJhuJSDDo+fP
         YuiWc3f6uhJ4Nw+HU358IfqsM/cNzYQqR1gsv0splCHYqXNuf/d9EziGEY/iH14Wt7
         kx0sBzftwmPwdgn4DvN6sz+jd7J0lgAmNPW1cQelZk/d9gsMcInxe95jeIeFRSmQbP
         n6bNyT9WVwHsQ==
Received: by mercury (Postfix, from userid 1000)
        id 678F71060FAB; Thu,  9 Mar 2023 23:50:43 +0100 (CET)
From:   Sebastian Reichel <sre@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCHv1 08/11] power: supply: generic-adc-battery: use simple-battery API
Date:   Thu,  9 Mar 2023 23:50:38 +0100
Message-Id: <20230309225041.477440-9-sre@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230309225041.477440-1-sre@kernel.org>
References: <20230309225041.477440-1-sre@kernel.org>
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

Use standard simple-battery API for constant battery
information like min and max voltage. This simplifies
the driver a lot and brings automatic support for DT.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/power/supply/generic-adc-battery.c | 65 ++--------------------
 include/linux/power/generic-adc-battery.h  | 18 ------
 2 files changed, 5 insertions(+), 78 deletions(-)
 delete mode 100644 include/linux/power/generic-adc-battery.h

diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
index 771e5cfc49c3..fc6fcfda1ef2 100644
--- a/drivers/power/supply/generic-adc-battery.c
+++ b/drivers/power/supply/generic-adc-battery.c
@@ -22,7 +22,6 @@
 #include <linux/slab.h>
 #include <linux/iio/consumer.h>
 #include <linux/iio/types.h>
-#include <linux/power/generic-adc-battery.h>
 #include <linux/devm-helpers.h>
 
 #define JITTER_DEFAULT 10 /* hope 10ms is enough */
@@ -48,9 +47,7 @@ struct gab {
 	struct power_supply		*psy;
 	struct power_supply_desc	psy_desc;
 	struct iio_channel	*channel[GAB_MAX_CHAN_TYPE];
-	struct gab_platform_data	*pdata;
 	struct delayed_work bat_work;
-	int	level;
 	int	status;
 	bool cable_plugged;
 	struct gpio_desc *charge_finished;
@@ -70,14 +67,6 @@ static void gab_ext_power_changed(struct power_supply *psy)
 
 static const enum power_supply_property gab_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
-	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
-	POWER_SUPPLY_PROP_CHARGE_EMPTY_DESIGN,
-	POWER_SUPPLY_PROP_VOLTAGE_NOW,
-	POWER_SUPPLY_PROP_CURRENT_NOW,
-	POWER_SUPPLY_PROP_TECHNOLOGY,
-	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
-	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
-	POWER_SUPPLY_PROP_MODEL_NAME,
 };
 
 /*
@@ -97,17 +86,6 @@ static bool gab_charge_finished(struct gab *adc_bat)
 	return gpiod_get_value(adc_bat->charge_finished);
 }
 
-static int gab_get_status(struct gab *adc_bat)
-{
-	struct gab_platform_data *pdata = adc_bat->pdata;
-	struct power_supply_info *bat_info;
-
-	bat_info = &pdata->battery_info;
-	if (adc_bat->level == bat_info->charge_full_design)
-		return POWER_SUPPLY_STATUS_FULL;
-	return adc_bat->status;
-}
-
 static enum gab_chan_type gab_prop_to_chan(enum power_supply_property psp)
 {
 	switch (psp) {
@@ -144,27 +122,12 @@ static int read_channel(struct gab *adc_bat, enum power_supply_property psp,
 static int gab_get_property(struct power_supply *psy,
 		enum power_supply_property psp, union power_supply_propval *val)
 {
-	struct gab *adc_bat;
-	struct gab_platform_data *pdata;
-	struct power_supply_info *bat_info;
-	int result = 0;
-	int ret = 0;
-
-	adc_bat = to_generic_bat(psy);
-	if (!adc_bat) {
-		dev_err(&psy->dev, "no battery infos ?!\n");
-		return -EINVAL;
-	}
-	pdata = adc_bat->pdata;
-	bat_info = &pdata->battery_info;
+	struct gab *adc_bat = to_generic_bat(psy);
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
-		val->intval = gab_get_status(adc_bat);
-		break;
-	case POWER_SUPPLY_PROP_CHARGE_EMPTY_DESIGN:
-		val->intval = 0;
-		break;
+		val->intval = adc_bat->status;
+		return 0;
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 	case POWER_SUPPLY_PROP_POWER_NOW:
@@ -173,26 +136,9 @@ static int gab_get_property(struct power_supply *psy,
 			goto err;
 		val->intval = result;
 		break;
-	case POWER_SUPPLY_PROP_TECHNOLOGY:
-		val->intval = bat_info->technology;
-		break;
-	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
-		val->intval = bat_info->voltage_min_design;
-		break;
-	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
-		val->intval = bat_info->voltage_max_design;
-		break;
-	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
-		val->intval = bat_info->charge_full_design;
-		break;
-	case POWER_SUPPLY_PROP_MODEL_NAME:
-		val->strval = bat_info->name;
-		break;
 	default:
 		return -EINVAL;
 	}
-err:
-	return ret;
 }
 
 static void gab_work(struct work_struct *work)
@@ -235,7 +181,6 @@ static int gab_probe(struct platform_device *pdev)
 	struct gab *adc_bat;
 	struct power_supply_desc *psy_desc;
 	struct power_supply_config psy_cfg = {};
-	struct gab_platform_data *pdata = pdev->dev.platform_data;
 	enum power_supply_property *properties;
 	int ret = 0;
 	int chan;
@@ -248,7 +193,7 @@ static int gab_probe(struct platform_device *pdev)
 
 	psy_cfg.drv_data = adc_bat;
 	psy_desc = &adc_bat->psy_desc;
-	psy_desc->name = pdata->battery_info.name;
+	psy_desc->name = dev_name(&pdev->dev);
 
 	/* bootup default values for the battery */
 	adc_bat->cable_plugged = false;
@@ -256,7 +201,6 @@ static int gab_probe(struct platform_device *pdev)
 	psy_desc->type = POWER_SUPPLY_TYPE_BATTERY;
 	psy_desc->get_property = gab_get_property;
 	psy_desc->external_power_changed = gab_ext_power_changed;
-	adc_bat->pdata = pdata;
 
 	/*
 	 * copying the static properties and allocating extra memory for holding
@@ -309,6 +253,7 @@ static int gab_probe(struct platform_device *pdev)
 	 */
 	psy_desc->properties = properties;
 	psy_desc->num_properties = index;
+	psy_desc->expose_battery_info = true;
 
 	adc_bat->psy = devm_power_supply_register(&pdev->dev, psy_desc, &psy_cfg);
 	if (IS_ERR(adc_bat->psy))
diff --git a/include/linux/power/generic-adc-battery.h b/include/linux/power/generic-adc-battery.h
deleted file mode 100644
index 54434e4304d3..000000000000
--- a/include/linux/power/generic-adc-battery.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2012, Anish Kumar <anish198519851985@gmail.com>
- */
-
-#ifndef GENERIC_ADC_BATTERY_H
-#define GENERIC_ADC_BATTERY_H
-
-/**
- * struct gab_platform_data - platform_data for generic adc iio battery driver.
- * @battery_info:         recommended structure to specify static power supply
- *			   parameters
- */
-struct gab_platform_data {
-	struct power_supply_info battery_info;
-};
-
-#endif /* GENERIC_ADC_BATTERY_H */
-- 
2.39.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4C06BF590
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 23:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjCQW5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 18:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjCQW5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 18:57:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743FA2D158;
        Fri, 17 Mar 2023 15:57:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F350B60C38;
        Fri, 17 Mar 2023 22:57:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED3FC4339C;
        Fri, 17 Mar 2023 22:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679093833;
        bh=OTuZm/GSsFUFrelKr/sk2skAkKM6ag5nmS5giLi2c9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YPYLqLMijOhiurrgGWASebHjcp9iaJ7EvsWklEv/t7ir52Q6J74y8s8v2VOtQFA+J
         qLrevzJYD2ZzYmC0A2JYc2F76tSCUHjpejoJ0cZExuZA2JlL9lyJYQgLRHfq/WeR8I
         CCbBI8HAWjoDHXVDb0iH5DqgzDnaymk013o5WfKwHyQXX2GjXYpqwJkF7o6Q4ieAln
         du7NsWNodZIBeZhcrSoS6+Rc45s2e8zXS4c3TRHpTqpwVUdzMpX+Nrnxjn98OADDv4
         rygqvbE8PEOEO/atIaSj3r/wyiLyy5Z4mKLMv2LI9fCreQpi5jq/Ae7abze1gNapYN
         xCZCA+7GrgE+Q==
Received: by mercury (Postfix, from userid 1000)
        id 936A2106210C; Fri, 17 Mar 2023 23:57:08 +0100 (CET)
From:   Sebastian Reichel <sre@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCHv3 08/14] power: supply: generic-adc-battery: use simple-battery API
Date:   Fri, 17 Mar 2023 23:57:01 +0100
Message-Id: <20230317225707.1552512-9-sre@kernel.org>
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

Constant battery data is available through power-supply's simple-battery
API. This works automatically, so the manual handling can be removed
without loosing any feature :)

Note, that the POWER_SUPPLY_STATUS_FULL check for the level variable can
be dropped, since the variable is never written. It can be re-introduced
properly once the driver gets functionality to calculate the current
charge level. Apart from that the check must be done fuzzy anyways,
since charge estimation usually is not precise enough to always return
exactly the full charge capacity for a full battery.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/power/supply/generic-adc-battery.c | 64 ++--------------------
 include/linux/power/generic-adc-battery.h  | 18 ------
 2 files changed, 4 insertions(+), 78 deletions(-)
 delete mode 100644 include/linux/power/generic-adc-battery.h

diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
index 771e5cfc49c3..d4f63d945b2c 100644
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


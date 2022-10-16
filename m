Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A7D600469
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 01:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiJPXnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 19:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiJPXnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 19:43:19 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E340F399CD;
        Sun, 16 Oct 2022 16:42:36 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id y10so7616867wma.0;
        Sun, 16 Oct 2022 16:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7GeqA6RimLfLm9Mc18q8mMiWhfUsPblKqcrMhkZEToU=;
        b=LPqoEX9APVxjLOUyQH+1IzLg92/TOVSLvZn+fPPTowM2hxzd75s6hE6i6eX+5aP+Qw
         AR/6W8TnL0y9Tg4cqkAy9lbEW1v1NaQkEJhm+ICwGdpKY4ETyVJtuJLxJPC92IBCUCr4
         /C67vziOG8rBUo1xPTFP2Yc4HlEy9RIVQqp9HrGOs/uZK++ecmdLPtM+7X9BFyQTDjD9
         SnkJ4O+FP5Lb5c07XdWTgAsdREFkqwoBdcssT0MvTURTxpaqO3rVNLWDdAWutyumQWgn
         EucpPcfgIxbgVvU4eiLYP/sxXNiV/caucPXfNUkS3qby/T02htXiwKhYEkAFMoM+A/9V
         cb6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7GeqA6RimLfLm9Mc18q8mMiWhfUsPblKqcrMhkZEToU=;
        b=MA66+ysGyAuC4s399kYI5JYRof4EnLJZtoayRahUvvY/SKLWQTy16nrz5cWsMa2ddX
         8E2N5wQXrxuv/bYqz6d+2CJw0lr8ere2fVLNbURZlA6jRbOZdgDkOgdCwcMuTUJNcjT3
         WaDFdFl++bmdJqHRIhb5Er+jIk3qO7zM8HFRaB8fuTeDuyPhW8rXLVKvCgUkCEqgtHmw
         KrwtPF82tDpR0ft0XY9ZQBz1H/GsPlljTL5xGXltkTtuCJ7OyZwXF3A4jOpy7VxrbIuS
         Uat3IKTzpGry79DPIJhxJvU2jG7MZ1WFm/bxZwUqdydYBixB53D1i+nLs5/2/20t4ajF
         6blQ==
X-Gm-Message-State: ACrzQf2DN5nw0dkEI4MA+N4MrTnz06YpZcbj7F3GBSkol459LSvgJqwR
        9c6XDukzvohAPKm/9EdwGxI=
X-Google-Smtp-Source: AMsMyM7OzezZkfSVx0BmqVE2Xlsd36XVkmtVLM4u3fU8/A29efl49HSOCeA7D9eONFNlaUQPaUPRVg==
X-Received: by 2002:a05:600c:4e01:b0:3c6:eba6:75a3 with SMTP id b1-20020a05600c4e0100b003c6eba675a3mr8367606wmq.4.1665963754081;
        Sun, 16 Oct 2022 16:42:34 -0700 (PDT)
Received: from localhost (188.31.4.189.threembb.co.uk. [188.31.4.189])
        by smtp.gmail.com with ESMTPSA id f8-20020a05600c4e8800b003b4cba4ef71sm15400056wmq.41.2022.10.16.16.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 16:42:33 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lee.jones@linaro.org, sre@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     lars@metafoo.de, andy.shevchenko@gmail.com,
        linus.walleij@linaro.org, brgl@bgdev.pl, michael@walle.cc,
        samuel@sholland.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v6 13/13] power: axp20x_battery: Add support for AXP192
Date:   Mon, 17 Oct 2022 00:43:35 +0100
Message-Id: <20221016234335.904212-14-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20221016234335.904212-1-aidanmacdonald.0x0@gmail.com>
References: <20221016234335.904212-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AXP192 has a battery charger similar to other X-Powers PMICs,
but unlike the other supported devices, it does not have a fuel
gauge and can't report battery capacity directly.

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/power/supply/axp20x_battery.c | 49 +++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
index 574c1d001556..1e84d26ce8e3 100644
--- a/drivers/power/supply/axp20x_battery.c
+++ b/drivers/power/supply/axp20x_battery.c
@@ -544,6 +544,19 @@ static int axp20x_battery_set_prop(struct power_supply *psy,
 	}
 }
 
+static enum power_supply_property axp192_battery_props[] = {
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
+};
+
 static enum power_supply_property axp20x_battery_props[] = {
 	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_ONLINE,
@@ -568,6 +581,16 @@ static int axp20x_battery_prop_writeable(struct power_supply *psy,
 	       psp == POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX;
 }
 
+static const struct power_supply_desc axp192_batt_ps_desc = {
+	.name = "axp192-battery",
+	.type = POWER_SUPPLY_TYPE_BATTERY,
+	.properties = axp192_battery_props,
+	.num_properties = ARRAY_SIZE(axp192_battery_props),
+	.property_is_writeable = axp20x_battery_prop_writeable,
+	.get_property = axp20x_battery_get_prop,
+	.set_property = axp20x_battery_set_prop,
+};
+
 static const struct power_supply_desc axp20x_batt_ps_desc = {
 	.name = "axp20x-battery",
 	.type = POWER_SUPPLY_TYPE_BATTERY,
@@ -578,6 +601,19 @@ static const struct power_supply_desc axp20x_batt_ps_desc = {
 	.set_property = axp20x_battery_set_prop,
 };
 
+static const int axp192_ccc_table[AXP20X_CHRG_CTRL1_TGT_CURR+1] = {
+	100000,  190000,  280000,  360000,
+	450000,  550000,  630000,  700000,
+	780000,  880000,  960000,  1000000,
+	1080000, 1160000, 1240000, 1320000,
+};
+
+static const struct axp_data axp192_data = {
+	.ccc_table = axp192_ccc_table,
+	.get_max_voltage = axp20x_battery_get_max_voltage,
+	.set_max_voltage = axp20x_battery_set_max_voltage,
+};
+
 static const struct axp_data axp209_data = {
 	.ccc_scale = 100000,
 	.ccc_offset = 300000,
@@ -606,6 +642,9 @@ static const struct axp_data axp813_data = {
 
 static const struct of_device_id axp20x_battery_ps_id[] = {
 	{
+		.compatible = "x-powers,axp192-battery-power-supply",
+		.data = (void *)&axp192_data,
+	}, {
 		.compatible = "x-powers,axp209-battery-power-supply",
 		.data = (void *)&axp209_data,
 	}, {
@@ -623,6 +662,7 @@ static int axp20x_power_probe(struct platform_device *pdev)
 	struct axp20x_batt_ps *axp20x_batt;
 	struct power_supply_config psy_cfg = {};
 	struct power_supply_battery_info *info;
+	const struct power_supply_desc *ps_desc;
 	struct device *dev = &pdev->dev;
 
 	if (!of_device_is_available(pdev->dev.of_node))
@@ -666,9 +706,12 @@ static int axp20x_power_probe(struct platform_device *pdev)
 
 	axp20x_batt->data = (struct axp_data *)of_device_get_match_data(dev);
 
-	axp20x_batt->batt = devm_power_supply_register(&pdev->dev,
-						       &axp20x_batt_ps_desc,
-						       &psy_cfg);
+	if (!axp20x_batt->data->has_fg)
+		ps_desc = &axp192_batt_ps_desc;
+	else
+		ps_desc = &axp20x_batt_ps_desc;
+
+	axp20x_batt->batt = devm_power_supply_register(&pdev->dev, ps_desc, &psy_cfg);
 	if (IS_ERR(axp20x_batt->batt)) {
 		dev_err(&pdev->dev, "failed to register power supply: %ld\n",
 			PTR_ERR(axp20x_batt->batt));
-- 
2.38.0


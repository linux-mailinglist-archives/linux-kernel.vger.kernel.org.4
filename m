Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE204600458
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 01:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiJPXnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 19:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiJPXmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 19:42:49 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3578437408;
        Sun, 16 Oct 2022 16:42:31 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id bv10so16003709wrb.4;
        Sun, 16 Oct 2022 16:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVoR5fEFXEn1wnD9ecqINhC8kaMx1xCBXArxnuhKVxg=;
        b=UNtTf7WnJQh34O+QV5PpTFm3pED1tEo6mzd6miSNBXIOHTX33IV/OLXxM9xkrd8iAz
         RUudZmC6YntaJTSlzrrIAGik5/Fjvh4OVtDlL6uOFPPwM/8gns7u9TptmmjjHHP31jR+
         VrOthy3lcVP1rWfvI5WSeykNAytE26qOPipZ53ccpCsO/zz9WIZXNdbKLZGq+XTyAWAo
         xRed8fZm7vKMTIKUGs7CuPztLfS1jU6QZhH5czgs3JVrNIvGrYgA/6OLReoT3+6Z9Ysn
         kDmmPJO8AEhHM+x+eZgkHdVtGY6bJ4pW5KGI8GtY5pYtOazHDDGl7ZjcaDtngQKQvE1p
         qv0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVoR5fEFXEn1wnD9ecqINhC8kaMx1xCBXArxnuhKVxg=;
        b=g4n+s20HF0oGTBXqUYwYKkcm9H6EFpdDRmyC+vK33TupmD25iBbMxmZVQnhYkW/Rys
         n/Z7tJunLO7AMe9YY1CsjMMRaeSyByYM2/xCmXm13wXKMShxXFDAuE3CgLLxHqrsDt7u
         huYFxhPRqjbYNSNh1ig+CZNPAS6mmWVaMLC3Pratj647vRV/+zV2tZdvhNwN1uc40hUd
         s0MCzWFgs2kgfqIdL3QsphSP/yUVVUp68Y96YxnhYFWT+EZmPvBBE0A0SzZ6wNZFg/t+
         g0/mHAnmAUSl8202m+srcTF7FLAQGB+z7tNQ6q+2ijJh4fdD3kwk3MCI3uFEeio216Kn
         grog==
X-Gm-Message-State: ACrzQf0uFsObi+9Yh2WamAIVq7kKgZGXoduMhzteCdWVlckULIyFOvki
        18vynNIao2K2br5eS9yKFts=
X-Google-Smtp-Source: AMsMyM499yzAKHSUJyKxSvlsexJxJg4em6fAXtN1S3z4sdl2Yd4fL98krA1llKGGRjFY2k3mx2l4Rw==
X-Received: by 2002:adf:e491:0:b0:22e:4483:a8b5 with SMTP id i17-20020adfe491000000b0022e4483a8b5mr4775629wrm.497.1665963749559;
        Sun, 16 Oct 2022 16:42:29 -0700 (PDT)
Received: from localhost (188.31.4.189.threembb.co.uk. [188.31.4.189])
        by smtp.gmail.com with ESMTPSA id z6-20020a1cf406000000b003c6deb5c1edsm8496773wma.45.2022.10.16.16.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 16:42:29 -0700 (PDT)
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
Subject: [PATCH v6 10/13] power: supply: axp20x_usb_power: Add support for AXP192
Date:   Mon, 17 Oct 2022 00:43:32 +0100
Message-Id: <20221016234335.904212-11-aidanmacdonald.0x0@gmail.com>
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

The AXP192's USB power supply is similar to the AXP202 but it has
different USB current limits and a different offset for the VBUS
status register.

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/power/supply/axp20x_usb_power.c | 84 +++++++++++++++++++++----
 1 file changed, 73 insertions(+), 11 deletions(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index a1e6d1d44808..f83e2ed6d507 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -48,6 +48,9 @@
 #define AXP813_VBUS_CLIMIT_2000mA	2
 #define AXP813_VBUS_CLIMIT_2500mA	3
 
+#define AXP192_VBUS_CLIMIT_EN		BIT(1)
+#define AXP192_VBUS_CLIMIT_100mA	BIT(0)
+
 #define AXP20X_ADC_EN1_VBUS_CURR	BIT(2)
 #define AXP20X_ADC_EN1_VBUS_VOLT	BIT(3)
 
@@ -121,6 +124,25 @@ static void axp20x_usb_power_poll_vbus(struct work_struct *work)
 		mod_delayed_work(system_power_efficient_wq, &power->vbus_detect, DEBOUNCE_TIME);
 }
 
+static int axp192_get_current_max(struct axp20x_usb_power *power, int *val)
+{
+	unsigned int v;
+	int ret;
+
+	ret = regmap_read(power->regmap, AXP20X_VBUS_IPSOUT_MGMT, &v);
+	if (ret)
+		return ret;
+
+	if (!(v & AXP192_VBUS_CLIMIT_EN))
+		*val = -1;
+	else if (v & AXP192_VBUS_CLIMIT_100mA)
+		*val = 100000;
+	else
+		*val = 500000;
+
+	return 0;
+}
+
 static int axp20x_get_current_max(struct axp20x_usb_power *power, int *val)
 {
 	unsigned int v;
@@ -179,7 +201,7 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
 	enum power_supply_property psp, union power_supply_propval *val)
 {
 	struct axp20x_usb_power *power = power_supply_get_drvdata(psy);
-	unsigned int input, v;
+	unsigned int input, v, reg;
 	int ret;
 
 	switch (psp) {
@@ -215,6 +237,8 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_CURRENT_MAX:
 		if (power->axp20x_id == AXP813_ID)
 			return axp813_get_current_max(power, &val->intval);
+		else if (power->axp20x_id == AXP192_ID)
+			return axp192_get_current_max(power, &val->intval);
 		return axp20x_get_current_max(power, &val->intval);
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 		if (IS_ENABLED(CONFIG_AXP20X_ADC)) {
@@ -256,16 +280,19 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
 
 		val->intval = POWER_SUPPLY_HEALTH_GOOD;
 
-		if (power->axp20x_id == AXP202_ID) {
-			ret = regmap_read(power->regmap,
-					  AXP20X_USB_OTG_STATUS, &v);
-			if (ret)
-				return ret;
+		if (power->axp20x_id == AXP192_ID)
+			reg = AXP192_USB_OTG_STATUS;
+		else if (power->axp20x_id == AXP202_ID)
+			reg = AXP20X_USB_OTG_STATUS;
+		else
+			break; /* Other chips lack the OTG status register */
 
-			if (!(v & AXP20X_USB_STATUS_VBUS_VALID))
-				val->intval =
-					POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
-		}
+		ret = regmap_read(power->regmap, reg, &v);
+		if (ret)
+			return ret;
+
+		if (!(v & AXP20X_USB_STATUS_VBUS_VALID))
+			val->intval = POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
 		break;
 	case POWER_SUPPLY_PROP_PRESENT:
 		val->intval = !!(input & AXP20X_PWR_STATUS_VBUS_PRESENT);
@@ -316,6 +343,28 @@ static int axp20x_usb_power_set_voltage_min(struct axp20x_usb_power *power,
 	return -EINVAL;
 }
 
+static int axp192_usb_power_set_current_max(struct axp20x_usb_power *power,
+					    int intval)
+{
+	const unsigned int mask = AXP192_VBUS_CLIMIT_EN |
+				  AXP192_VBUS_CLIMIT_100mA;
+	unsigned int val;
+
+	switch (intval) {
+	case 100000:
+		val = AXP192_VBUS_CLIMIT_EN | AXP192_VBUS_CLIMIT_100mA;
+		break;
+	case 500000:
+		val = AXP192_VBUS_CLIMIT_EN;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return regmap_update_bits(power->regmap,
+				  AXP20X_VBUS_IPSOUT_MGMT, mask, val);
+}
+
 static int axp813_usb_power_set_current_max(struct axp20x_usb_power *power,
 					    int intval)
 {
@@ -383,6 +432,9 @@ static int axp20x_usb_power_set_property(struct power_supply *psy,
 		if (power->axp20x_id == AXP813_ID)
 			return axp813_usb_power_set_current_max(power,
 								val->intval);
+		else if (power->axp20x_id == AXP192_ID)
+			return axp192_usb_power_set_current_max(power,
+								val->intval);
 		return axp20x_usb_power_set_current_max(power, val->intval);
 
 	default:
@@ -468,6 +520,13 @@ struct axp_data {
 	enum axp20x_variants		axp20x_id;
 };
 
+static const struct axp_data axp192_data = {
+	.power_desc	= &axp20x_usb_power_desc,
+	.irq_names	= axp20x_irq_names,
+	.num_irq_names	= ARRAY_SIZE(axp20x_irq_names),
+	.axp20x_id	= AXP192_ID,
+};
+
 static const struct axp_data axp202_data = {
 	.power_desc	= &axp20x_usb_power_desc,
 	.irq_names	= axp20x_irq_names,
@@ -600,7 +659,7 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	if (power->axp20x_id == AXP202_ID) {
+	if (power->axp20x_id == AXP192_ID || power->axp20x_id == AXP202_ID) {
 		/* Enable vbus valid checking */
 		ret = regmap_update_bits(power->regmap, AXP20X_VBUS_MON,
 					 AXP20X_VBUS_MON_VBUS_VALID,
@@ -659,6 +718,9 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 
 static const struct of_device_id axp20x_usb_power_match[] = {
 	{
+		.compatible = "x-powers,axp192-usb-power-supply",
+		.data = &axp192_data,
+	}, {
 		.compatible = "x-powers,axp202-usb-power-supply",
 		.data = &axp202_data,
 	}, {
-- 
2.38.0


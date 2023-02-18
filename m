Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A448169BBEE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 21:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjBRUt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 15:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjBRUt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 15:49:56 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A21914203;
        Sat, 18 Feb 2023 12:49:54 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id m22-20020a7bcb96000000b003e21e018039so354329wmi.3;
        Sat, 18 Feb 2023 12:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1tUd+v3AgC5rEmN1z0CLTt+c2Ip3+6zTXGdLmF/kHw=;
        b=dwFJETju9IHoSilXKf3xnJT/UUz3P9fv5rW0+7nBP2vUVJQuRUftowkg9NmmD+SI1r
         5pB71mFrHJXvMJ1mu+hBpOCfD9fm3Cx3dGnCITkme4JNune8R5SjcTMpkDVd5D3o8OHC
         pgNDJW83J++B4EAtP01s7VgieslJsE3vDh1/nJWixcdbv9sDFK6+DG9IURsShtC7XDbZ
         lT3QX4+gZTAWoirEmjMVqAE/DX/7RuZrtKKT2rmSGO1LF0hU5P80nZDAVvGhxdsgFmD/
         hy+XNCxJ0H5mvFswoOeKTds+8vtdfN/PXT2NSPJdKI+gIp5XMbfxYKnOg60LsUcLdIec
         Yg4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R1tUd+v3AgC5rEmN1z0CLTt+c2Ip3+6zTXGdLmF/kHw=;
        b=Yqm7eWCcYeBoiOwEQgROe4H2K1G2FAWXq9f7c6PnRrOCLYVRNkg1N6urVC3PbefUie
         kqXoFt1Sljc8KEFGBSfEspnkiDK9hUGFYComgrHj4APCnEwmcCvVzSFKCjm6TO6ASDt4
         6xPbblq8cPAXk49MISUzaGdY+m9g3X8hFdR2GhUdFN3xGD9Q3cyx8qrmcgq2LKRieppe
         iQDVUX/hvyvCEp5+9dMyA3cJEDhm6PwgiRO/chhRmppIe2r7++Ir+1swBCYtm8S5X34+
         P1asw2kjqC/Sfr4wZ13/InteH0xaPQtZCdaQ5ChzwFzcu80rDmeOdmaVmsikRi9s9km7
         jqHw==
X-Gm-Message-State: AO0yUKWsps3GANxuE3ngRafzbURj8HaEDF2rYCcFG9jPdeLN76lCYEUW
        nt00xNdNgyuC2nXyVeZQgRA=
X-Google-Smtp-Source: AK7set+AIt6KJNo+pOLuBkEdpngdT57pvmpEsaqeTZBQ2H0ByfoxYfvM+yhJ5H5x3T+pz1murZ06lA==
X-Received: by 2002:a05:600c:2b46:b0:3e0:1ab:cf2a with SMTP id e6-20020a05600c2b4600b003e001abcf2amr3529420wmf.39.1676753392757;
        Sat, 18 Feb 2023 12:49:52 -0800 (PST)
Received: from localhost (94.197.47.81.threembb.co.uk. [94.197.47.81])
        by smtp.gmail.com with ESMTPSA id ip24-20020a05600ca69800b003e223fe0a3asm5676563wmb.27.2023.02.18.12.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 12:49:52 -0800 (PST)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     sre@kernel.org, wens@csie.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/5] power: supply: axp20x_usb_power: Simplify USB current limit handling
Date:   Sat, 18 Feb 2023 20:49:42 +0000
Message-Id: <20230218204946.106316-2-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20230218204946.106316-1-aidanmacdonald.0x0@gmail.com>
References: <20230218204946.106316-1-aidanmacdonald.0x0@gmail.com>
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

Handle the USB current limit with a lookup table and regmap field,
which minimizes code duplication. Invalid or unlimited values are
denoted by -1 entries, and can't be selected from userspace.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/power/supply/axp20x_usb_power.c | 172 ++++++++----------------
 1 file changed, 57 insertions(+), 115 deletions(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index a1e6d1d44808..67998fba702a 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -37,16 +37,6 @@
 #define AXP20X_VBUS_VHOLD_uV(b)		(4000000 + (((b) >> 3) & 7) * 100000)
 #define AXP20X_VBUS_VHOLD_MASK		GENMASK(5, 3)
 #define AXP20X_VBUS_VHOLD_OFFSET	3
-#define AXP20X_VBUS_CLIMIT_MASK		3
-#define AXP20X_VBUS_CLIMIT_900mA	0
-#define AXP20X_VBUS_CLIMIT_500mA	1
-#define AXP20X_VBUS_CLIMIT_100mA	2
-#define AXP20X_VBUS_CLIMIT_NONE		3
-
-#define AXP813_VBUS_CLIMIT_900mA	0
-#define AXP813_VBUS_CLIMIT_1500mA	1
-#define AXP813_VBUS_CLIMIT_2000mA	2
-#define AXP813_VBUS_CLIMIT_2500mA	3
 
 #define AXP20X_ADC_EN1_VBUS_CURR	BIT(2)
 #define AXP20X_ADC_EN1_VBUS_VOLT	BIT(3)
@@ -61,10 +51,21 @@
  */
 #define DEBOUNCE_TIME			msecs_to_jiffies(50)
 
+struct axp_data {
+	const struct power_supply_desc	*power_desc;
+	const char * const		*irq_names;
+	unsigned int			num_irq_names;
+	enum axp20x_variants		axp20x_id;
+	const int			*curr_lim_table;
+	struct reg_field		curr_lim_fld;
+};
+
 struct axp20x_usb_power {
 	struct regmap *regmap;
+	struct regmap_field *curr_lim_fld;
 	struct power_supply *supply;
 	enum axp20x_variants axp20x_id;
+	const struct axp_data *axp_data;
 	struct iio_channel *vbus_v;
 	struct iio_channel *vbus_i;
 	struct delayed_work vbus_detect;
@@ -121,60 +122,6 @@ static void axp20x_usb_power_poll_vbus(struct work_struct *work)
 		mod_delayed_work(system_power_efficient_wq, &power->vbus_detect, DEBOUNCE_TIME);
 }
 
-static int axp20x_get_current_max(struct axp20x_usb_power *power, int *val)
-{
-	unsigned int v;
-	int ret = regmap_read(power->regmap, AXP20X_VBUS_IPSOUT_MGMT, &v);
-
-	if (ret)
-		return ret;
-
-	switch (v & AXP20X_VBUS_CLIMIT_MASK) {
-	case AXP20X_VBUS_CLIMIT_100mA:
-		if (power->axp20x_id == AXP221_ID)
-			*val = -1; /* No 100mA limit */
-		else
-			*val = 100000;
-		break;
-	case AXP20X_VBUS_CLIMIT_500mA:
-		*val = 500000;
-		break;
-	case AXP20X_VBUS_CLIMIT_900mA:
-		*val = 900000;
-		break;
-	case AXP20X_VBUS_CLIMIT_NONE:
-		*val = -1;
-		break;
-	}
-
-	return 0;
-}
-
-static int axp813_get_current_max(struct axp20x_usb_power *power, int *val)
-{
-	unsigned int v;
-	int ret = regmap_read(power->regmap, AXP20X_VBUS_IPSOUT_MGMT, &v);
-
-	if (ret)
-		return ret;
-
-	switch (v & AXP20X_VBUS_CLIMIT_MASK) {
-	case AXP813_VBUS_CLIMIT_900mA:
-		*val = 900000;
-		break;
-	case AXP813_VBUS_CLIMIT_1500mA:
-		*val = 1500000;
-		break;
-	case AXP813_VBUS_CLIMIT_2000mA:
-		*val = 2000000;
-		break;
-	case AXP813_VBUS_CLIMIT_2500mA:
-		*val = 2500000;
-		break;
-	}
-	return 0;
-}
-
 static int axp20x_usb_power_get_property(struct power_supply *psy,
 	enum power_supply_property psp, union power_supply_propval *val)
 {
@@ -213,9 +160,12 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
 		val->intval = ret * 1700; /* 1 step = 1.7 mV */
 		return 0;
 	case POWER_SUPPLY_PROP_CURRENT_MAX:
-		if (power->axp20x_id == AXP813_ID)
-			return axp813_get_current_max(power, &val->intval);
-		return axp20x_get_current_max(power, &val->intval);
+		ret = regmap_field_read(power->curr_lim_fld, &v);
+		if (ret)
+			return ret;
+
+		val->intval = power->axp_data->curr_lim_table[v];
+		return 0;
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 		if (IS_ENABLED(CONFIG_AXP20X_ADC)) {
 			ret = iio_read_channel_processed(power->vbus_i,
@@ -316,50 +266,17 @@ static int axp20x_usb_power_set_voltage_min(struct axp20x_usb_power *power,
 	return -EINVAL;
 }
 
-static int axp813_usb_power_set_current_max(struct axp20x_usb_power *power,
-					    int intval)
+static int axp20x_usb_power_set_current_max(struct axp20x_usb_power *power, int intval)
 {
-	int val;
+	const unsigned int max = GENMASK(power->axp_data->curr_lim_fld.msb,
+					 power->axp_data->curr_lim_fld.lsb);
 
-	switch (intval) {
-	case 900000:
-		return regmap_update_bits(power->regmap,
-					  AXP20X_VBUS_IPSOUT_MGMT,
-					  AXP20X_VBUS_CLIMIT_MASK,
-					  AXP813_VBUS_CLIMIT_900mA);
-	case 1500000:
-	case 2000000:
-	case 2500000:
-		val = (intval - 1000000) / 500000;
-		return regmap_update_bits(power->regmap,
-					  AXP20X_VBUS_IPSOUT_MGMT,
-					  AXP20X_VBUS_CLIMIT_MASK, val);
-	default:
+	if (intval == -1)
 		return -EINVAL;
-	}
 
-	return -EINVAL;
-}
-
-static int axp20x_usb_power_set_current_max(struct axp20x_usb_power *power,
-					    int intval)
-{
-	int val;
-
-	switch (intval) {
-	case 100000:
-		if (power->axp20x_id == AXP221_ID)
-			return -EINVAL;
-		fallthrough;
-	case 500000:
-	case 900000:
-		val = (900000 - intval) / 400000;
-		return regmap_update_bits(power->regmap,
-					  AXP20X_VBUS_IPSOUT_MGMT,
-					  AXP20X_VBUS_CLIMIT_MASK, val);
-	default:
-		return -EINVAL;
-	}
+	for (unsigned int i = 0; i <= max; ++i)
+		if (power->axp_data->curr_lim_table[i] == intval)
+			return regmap_field_write(power->curr_lim_fld, i);
 
 	return -EINVAL;
 }
@@ -380,9 +297,6 @@ static int axp20x_usb_power_set_property(struct power_supply *psy,
 		return axp20x_usb_power_set_voltage_min(power, val->intval);
 
 	case POWER_SUPPLY_PROP_CURRENT_MAX:
-		if (power->axp20x_id == AXP813_ID)
-			return axp813_usb_power_set_current_max(power,
-								val->intval);
 		return axp20x_usb_power_set_current_max(power, val->intval);
 
 	default:
@@ -461,11 +375,25 @@ static const char * const axp22x_irq_names[] = {
 	"VBUS_REMOVAL",
 };
 
-struct axp_data {
-	const struct power_supply_desc	*power_desc;
-	const char * const		*irq_names;
-	unsigned int			num_irq_names;
-	enum axp20x_variants		axp20x_id;
+static int axp20x_usb_curr_lim_table[] = {
+	900000,
+	500000,
+	100000,
+	-1,
+};
+
+static int axp221_usb_curr_lim_table[] = {
+	900000,
+	500000,
+	-1,
+	-1,
+};
+
+static int axp813_usb_curr_lim_table[] = {
+	900000,
+	1500000,
+	2000000,
+	2500000,
 };
 
 static const struct axp_data axp202_data = {
@@ -473,6 +401,8 @@ static const struct axp_data axp202_data = {
 	.irq_names	= axp20x_irq_names,
 	.num_irq_names	= ARRAY_SIZE(axp20x_irq_names),
 	.axp20x_id	= AXP202_ID,
+	.curr_lim_table = axp20x_usb_curr_lim_table,
+	.curr_lim_fld   = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 0, 1),
 };
 
 static const struct axp_data axp221_data = {
@@ -480,6 +410,8 @@ static const struct axp_data axp221_data = {
 	.irq_names	= axp22x_irq_names,
 	.num_irq_names	= ARRAY_SIZE(axp22x_irq_names),
 	.axp20x_id	= AXP221_ID,
+	.curr_lim_table = axp221_usb_curr_lim_table,
+	.curr_lim_fld   = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 0, 1),
 };
 
 static const struct axp_data axp223_data = {
@@ -487,6 +419,8 @@ static const struct axp_data axp223_data = {
 	.irq_names	= axp22x_irq_names,
 	.num_irq_names	= ARRAY_SIZE(axp22x_irq_names),
 	.axp20x_id	= AXP223_ID,
+	.curr_lim_table = axp20x_usb_curr_lim_table,
+	.curr_lim_fld   = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 0, 1),
 };
 
 static const struct axp_data axp813_data = {
@@ -494,6 +428,8 @@ static const struct axp_data axp813_data = {
 	.irq_names	= axp22x_irq_names,
 	.num_irq_names	= ARRAY_SIZE(axp22x_irq_names),
 	.axp20x_id	= AXP813_ID,
+	.curr_lim_table = axp813_usb_curr_lim_table,
+	.curr_lim_fld   = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 0, 1),
 };
 
 #ifdef CONFIG_PM_SLEEP
@@ -592,9 +528,15 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, power);
 
 	power->axp20x_id = axp_data->axp20x_id;
+	power->axp_data = axp_data;
 	power->regmap = axp20x->regmap;
 	power->num_irqs = axp_data->num_irq_names;
 
+	power->curr_lim_fld = devm_regmap_field_alloc(&pdev->dev, power->regmap,
+						      axp_data->curr_lim_fld);
+	if (IS_ERR(power->curr_lim_fld))
+		return PTR_ERR(power->curr_lim_fld);
+
 	ret = devm_delayed_work_autocancel(&pdev->dev, &power->vbus_detect,
 					   axp20x_usb_power_poll_vbus);
 	if (ret)
-- 
2.39.2


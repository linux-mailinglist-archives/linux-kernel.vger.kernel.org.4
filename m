Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC5C6FDD23
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 13:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237035AbjEJLvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 07:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236908AbjEJLvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 07:51:48 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67448E4C;
        Wed, 10 May 2023 04:51:46 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3062c1e7df8so4717928f8f.1;
        Wed, 10 May 2023 04:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683719504; x=1686311504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1tUd+v3AgC5rEmN1z0CLTt+c2Ip3+6zTXGdLmF/kHw=;
        b=JpqHeVrC++Xx5E+Ovc/2JHadctgwmHSwEYUFZPa4BxcBU3AZLwyKDvpAyi+tZufJDZ
         puSqH/FhXNNIhip6S9r2NenanPUblCK1slrRNpcvwTZJiya8LpOFJOWKPqdBrRBlfxsz
         JMA4RyR66eXbH+aGx6JrFkBXxLQ9zcXaaa8XdvJluCgXzlrwx+xBO2PmGI2mk/PDAa4C
         CLMbryoPD9tirahrGtDHqYAnmf1K5BjpaUK37oikVIaDCuRcPrwFXDOUONZm4ezkSOIl
         njR82dnr0P2HLNhJba5l4g5/Rs7hs+8+ih1gpBLrEkC2gNYrA+P1Cywobg/tzEOOGm9J
         NGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683719504; x=1686311504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R1tUd+v3AgC5rEmN1z0CLTt+c2Ip3+6zTXGdLmF/kHw=;
        b=fejrCrvGLCH6ZviUBpYLXsJAnPS7hw4FNqv2HbDvR9UBiLDXrJnkJVnj0jUTxoFsKh
         Bu9cUWfIz5KypBW8U01EBnd54mz/sp38T7wZdKoBzSwfiaFhf/mxi75GLE4g7azPkDPE
         s6MpOACtsiz8NhAbAxzWiSqpDE+VX/SN8Y5OcCiqCigYjL9BYqBQCV0RWk3zaqhbE+I0
         lRnWX5/GCkasm8jKGfXEo9KkSQetWCwMdrUVhJFrX7MdwLM/5j9+aEEk0d4EyEhkkhyl
         M+NXFkR1T2vGtMnfutUGHRuV86W+okCW77IwJD9ja+guiGAPYxQXLlokmRTBiOLF9WBf
         rRbg==
X-Gm-Message-State: AC+VfDw7sAJw1alOl4bBzhkLwL1Be2GMuRQ1pop6meNxJII5XG/2E/Rd
        99IyBZrXKrS5fQZsZ50iusXQjs/Fl6w=
X-Google-Smtp-Source: ACHHUZ616B7yPyOliO4sSIfRzM2YiTxoM23m1CeFBl9V6oMc9Y+zA8XPI3dwItEIlZblXE2KhO/+zA==
X-Received: by 2002:a5d:428f:0:b0:2f7:e3aa:677a with SMTP id k15-20020a5d428f000000b002f7e3aa677amr12137132wrq.46.1683719504349;
        Wed, 10 May 2023 04:51:44 -0700 (PDT)
Received: from localhost ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id p8-20020a056000018800b002f28de9f73bsm17395302wrx.55.2023.05.10.04.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 04:51:43 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     sre@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        wens@csie.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/7] power: supply: axp20x_usb_power: Simplify USB current limit handling
Date:   Wed, 10 May 2023 12:50:40 +0100
Message-Id: <20230510115046.963432-2-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20230510115046.963432-1-aidanmacdonald.0x0@gmail.com>
References: <20230510115046.963432-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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


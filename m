Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5F36FDD2A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 13:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236787AbjEJLv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 07:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236935AbjEJLvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 07:51:48 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059D11725;
        Wed, 10 May 2023 04:51:47 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f42d937d2eso9930785e9.2;
        Wed, 10 May 2023 04:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683719505; x=1686311505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pN2mbhhRwU/XXivi0isPSjAJELATakPrcNi/RQdW9Lg=;
        b=UavLsZCmhV/UqjGQKMpLAepZc1rNomzLV6CrY6y8QkMjTWPgIrRON+cNcQtfAZ31z2
         Ol4UyEKsZUmRxh/1R+4qU92z2Mo79oZGgLJoYKza+PWqq8AUFajSRY66Bmf6lZS8R/2l
         aUjvUaiZjeAWp7SiDACTwPTg/MLSR/TyzMPjC55KK6eKFHQM/Mza+tjsvbZ/JovWn/UH
         smXfzHB0BYWvX3qUAeob7LTxPuc3AaBfuNBgPJ16BuwyTDH3nxoWGTNxOO9DwZOX+vCO
         31gXXFAUh5X73LOsLcFe9oqsL1m+BPWgai2GkDJhO+fHuUsUSJ8oS/oCL8aD9lcVwUhR
         g+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683719505; x=1686311505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pN2mbhhRwU/XXivi0isPSjAJELATakPrcNi/RQdW9Lg=;
        b=PYwuV8a2lc/waXl/U2TbFOZ0V6kBaZ/RDuLlYgFypxneZgbYiZxQBvVtaVoWnbL+5I
         anfEEuDsOosaMOsFyVQOMbyKPutvBy6LEsKRd7OkwiEdNCq1XIJuf1LInmZQRAONgq0f
         DagJtRvyz48k6VCuaIrfE5o3IJCAl06ZMQxFB4387kIrzaFHYQO13Z61Gm1TAZhz1N/9
         o9ex7J8iW5Pd/Pd1xLftJMX8fpxziMosaZB1tmIlFMvWRx1ruJi1w9H0UcaJDeb7AtfN
         e3X+ObRRJNgNovTU4HNMItY/HgmcRAWA9AKNUBe5NH3qHAdvJPzWlef3befnut0aPYYP
         A8Sw==
X-Gm-Message-State: AC+VfDznXGhDIPxyQDUmF1QzZFaYFYwBhDJc2C0KMM1/V/INMDQ96Yjn
        jbuMZJncFLr9m9ZvZEEcV9w=
X-Google-Smtp-Source: ACHHUZ5niuw3oceMYqnvTSOw3iuU0t2n7iE9CRPOg6Qv31XA9gdKiEZTy0Ntjwu3IpSxxV8MXTIi4w==
X-Received: by 2002:adf:ee49:0:b0:306:2701:5346 with SMTP id w9-20020adfee49000000b0030627015346mr13146778wro.39.1683719505398;
        Wed, 10 May 2023 04:51:45 -0700 (PDT)
Received: from localhost ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id r15-20020a5d694f000000b00306415ac69asm17124236wrw.15.2023.05.10.04.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 04:51:45 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     sre@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        wens@csie.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/7] power: supply: axp20x_usb_power: Use regmap fields for VBUS monitor feature
Date:   Wed, 10 May 2023 12:50:41 +0100
Message-Id: <20230510115046.963432-3-aidanmacdonald.0x0@gmail.com>
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

Use regmap fields to describe the VBUS valid bit and VBUS monitor
enable bit. This allows the driver to easily support other chips,
eg. the AXP192, that have the VBUS valid bit in a different register.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/power/supply/axp20x_usb_power.c | 57 +++++++++++++++++++------
 1 file changed, 45 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 67998fba702a..b2049b7d95fe 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -41,8 +41,6 @@
 #define AXP20X_ADC_EN1_VBUS_CURR	BIT(2)
 #define AXP20X_ADC_EN1_VBUS_VOLT	BIT(3)
 
-#define AXP20X_VBUS_MON_VBUS_VALID	BIT(3)
-
 #define AXP813_BC_EN		BIT(0)
 
 /*
@@ -58,11 +56,15 @@ struct axp_data {
 	enum axp20x_variants		axp20x_id;
 	const int			*curr_lim_table;
 	struct reg_field		curr_lim_fld;
+	struct reg_field		vbus_valid_bit;
+	struct reg_field		vbus_mon_bit;
 };
 
 struct axp20x_usb_power {
 	struct regmap *regmap;
 	struct regmap_field *curr_lim_fld;
+	struct regmap_field *vbus_valid_bit;
+	struct regmap_field *vbus_mon_bit;
 	struct power_supply *supply;
 	enum axp20x_variants axp20x_id;
 	const struct axp_data *axp_data;
@@ -206,16 +208,15 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
 
 		val->intval = POWER_SUPPLY_HEALTH_GOOD;
 
-		if (power->axp20x_id == AXP202_ID) {
-			ret = regmap_read(power->regmap,
-					  AXP20X_USB_OTG_STATUS, &v);
+		if (power->vbus_valid_bit) {
+			ret = regmap_field_read(power->vbus_valid_bit, &v);
 			if (ret)
 				return ret;
 
-			if (!(v & AXP20X_USB_STATUS_VBUS_VALID))
-				val->intval =
-					POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
+			if (v == 0)
+				val->intval = POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
 		}
+
 		break;
 	case POWER_SUPPLY_PROP_PRESENT:
 		val->intval = !!(input & AXP20X_PWR_STATUS_VBUS_PRESENT);
@@ -403,6 +404,8 @@ static const struct axp_data axp202_data = {
 	.axp20x_id	= AXP202_ID,
 	.curr_lim_table = axp20x_usb_curr_lim_table,
 	.curr_lim_fld   = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 0, 1),
+	.vbus_valid_bit = REG_FIELD(AXP20X_USB_OTG_STATUS, 2, 2),
+	.vbus_mon_bit   = REG_FIELD(AXP20X_VBUS_MON, 3, 3),
 };
 
 static const struct axp_data axp221_data = {
@@ -501,6 +504,26 @@ static int configure_adc_registers(struct axp20x_usb_power *power)
 				  AXP20X_ADC_EN1_VBUS_VOLT);
 }
 
+static int axp20x_regmap_field_alloc_optional(struct device *dev,
+					      struct regmap *regmap,
+					      struct reg_field fdesc,
+					      struct regmap_field **fieldp)
+{
+	struct regmap_field *field;
+
+	if (fdesc.reg == 0) {
+		*fieldp = NULL;
+		return 0;
+	}
+
+	field = devm_regmap_field_alloc(dev, regmap, fdesc);
+	if (IS_ERR(field))
+		return PTR_ERR(field);
+
+	*fieldp = field;
+	return 0;
+}
+
 static int axp20x_usb_power_probe(struct platform_device *pdev)
 {
 	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
@@ -537,16 +560,26 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 	if (IS_ERR(power->curr_lim_fld))
 		return PTR_ERR(power->curr_lim_fld);
 
+	ret = axp20x_regmap_field_alloc_optional(&pdev->dev, power->regmap,
+						 axp_data->vbus_valid_bit,
+						 &power->vbus_valid_bit);
+	if (ret)
+		return ret;
+
+	ret = axp20x_regmap_field_alloc_optional(&pdev->dev, power->regmap,
+						 axp_data->vbus_mon_bit,
+						 &power->vbus_mon_bit);
+	if (ret)
+		return ret;
+
 	ret = devm_delayed_work_autocancel(&pdev->dev, &power->vbus_detect,
 					   axp20x_usb_power_poll_vbus);
 	if (ret)
 		return ret;
 
-	if (power->axp20x_id == AXP202_ID) {
+	if (power->vbus_mon_bit) {
 		/* Enable vbus valid checking */
-		ret = regmap_update_bits(power->regmap, AXP20X_VBUS_MON,
-					 AXP20X_VBUS_MON_VBUS_VALID,
-					 AXP20X_VBUS_MON_VBUS_VALID);
+		ret = regmap_field_write(power->vbus_mon_bit, 1);
 		if (ret)
 			return ret;
 
-- 
2.39.2


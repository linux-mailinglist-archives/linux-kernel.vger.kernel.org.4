Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FE369BBF3
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 21:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjBRUuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 15:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjBRUt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 15:49:59 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6854F14200;
        Sat, 18 Feb 2023 12:49:55 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id k3-20020a05600c1c8300b003e1f5f2a29cso1065282wms.4;
        Sat, 18 Feb 2023 12:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pN2mbhhRwU/XXivi0isPSjAJELATakPrcNi/RQdW9Lg=;
        b=MmvtPHyQ6AUYjlWORkjFWTlD0S09Nfwj6e8TcyHkeP0sUNuDu2PZGMWhwB/bybPQbq
         /41IR7w5+SmBZuI/3odnfLsJZixszvPyKzSzLNblsLp5TB6+x5PYqzeh+L1T6irGJPkR
         rKBEWrQGlDdg5R0zavsG4voCO7uJfbb5FMqzIZOS3MZ2eSNtbNdkeSXPjAh8Rbh/Q/XL
         pMEOqxfho/eG4+qB5yGMrbQHrCKFFr4TLrmJ6LcuZuVODhQydOQJIYED/IzrFRPI3Hse
         6B4bu78NBDvCIcodcqFm69XFCTS/vzXhZw6nX19UaAfs4I99F6yVxYfXgJA2x6HllsLZ
         hb6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pN2mbhhRwU/XXivi0isPSjAJELATakPrcNi/RQdW9Lg=;
        b=sNxz4AgaKD0J7TwXrF6c56r4ZXsP4QtiZSJDeEHIMU0mLubsHrv6jUnlV9kME54fGZ
         YZRAAHClDnRtO49yDgaOIS+RQ7vgT1YkAXksH6TkP/Tqsb1Zfa7KE2Fai7OzeIYVP1PH
         H1p9dc2rqHsnBeRtSqP+X7jZkr84z08SeDoEa1EZ+LsBb5fWYGWGftfBQjAE2EBGmAr7
         uMG0Q5LLLyXyv0EAJdd+eGGj7nz97qvsGXnGb6VFN64SUKJcJyEGsn4dOlG2nvXe+rs4
         At0Yc57qPT4/JhABQ6TNS07QevwS9UhjAi37kxd8YUBacVIxJ3LPe5cPap0380ZvpKKm
         rmCQ==
X-Gm-Message-State: AO0yUKWwWVwnpmZSiarf4r2kWUL2fIJ6y9L+Jeo4RSDW0C51zkxT9lG8
        3y3qkcfadG/Kh/NbJY94/Cw=
X-Google-Smtp-Source: AK7set/cDhFYn3Ldi3u0ekRdMRy2n0lT9BF1caXQUvyxDUsFwnkY0QuAXh8NlSLxvMOhaRVRBPvbbQ==
X-Received: by 2002:a05:600c:2b45:b0:3df:85d2:c768 with SMTP id e5-20020a05600c2b4500b003df85d2c768mr3952547wmf.26.1676753393905;
        Sat, 18 Feb 2023 12:49:53 -0800 (PST)
Received: from localhost (94.197.47.81.threembb.co.uk. [94.197.47.81])
        by smtp.gmail.com with ESMTPSA id 9-20020a05600c22c900b003e224ff61a8sm5617947wmg.43.2023.02.18.12.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 12:49:53 -0800 (PST)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     sre@kernel.org, wens@csie.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/5] power: supply: axp20x_usb_power: Use regmap fields for VBUS monitor feature
Date:   Sat, 18 Feb 2023 20:49:43 +0000
Message-Id: <20230218204946.106316-3-aidanmacdonald.0x0@gmail.com>
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


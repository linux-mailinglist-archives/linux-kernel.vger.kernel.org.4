Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E33B69BBF5
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 21:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjBRUuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 15:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjBRUuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 15:50:01 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23A614203;
        Sat, 18 Feb 2023 12:49:57 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id 2so1119918wrz.9;
        Sat, 18 Feb 2023 12:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+e0WO9314+22bYk2/c0IG6PriU+XsPi5/aWiGwjMuE=;
        b=f/q2/34THR9pa5fDB9GLXMRJsOU1d0u+06pzMTnvLm0bY8B20k0aeobEJs8G+JD5Dz
         YFRqqSV3tfv7kae+1eDRvZUCuUpjtqoslWqLR+srWXn3RGXvgpIv5qBwSXbxVxvI0AON
         0P/j48nqCviABLqLz875C8znhcnqzywiwSi3tXTyK6SF+epyZCMJACIyWxLpjo/LaSlC
         kTJwHns4Gz9DMVRPmRFpoqnyiTtKPARFjmfba1ekkg4ME0KZ8zkjgaSn5dcoY8d3VVpR
         9yKCzFHc2+g/SGQqm8KF+QlRf+PJPSr5OHItbslscFEwf9Kn+sqENBAqi2+nZDIFz15c
         BWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r+e0WO9314+22bYk2/c0IG6PriU+XsPi5/aWiGwjMuE=;
        b=edxBbMFm7IV1yTDyrEUQvhSz0+GFkZNatnkcfor6LII5OVER28g3dR2PFOXNOPNQ1w
         4fRu3mcR8LWMnqP6bKt19KiSlTxdctchAH5tdZ15EZBSI2YtTGAf2w/ty451VSP1hMTG
         m1QVIFSXsZRvA83suna4ffCuAipZC/VYraKGzTSXeulDnZLzBV00TVm/9yJtio8DSFmr
         NXasTwmY3iteXYT5+RtiC5xQ5nAEm2x96TU/PJrGllEShNNh62KS1qslppdb2F91dH+H
         QfBvVgqdOR5SGPMIlTGSQ4kA/wlMOqD+j97kF4X15fbRjYnfSvrebHV2QVvCn6USum57
         LUEA==
X-Gm-Message-State: AO0yUKWjeG6G66QM7ymXyB5fgy7ybIS8v1sLKN6uivmcRGeJkYosUkUU
        a3zwgdYxRuLyb7iux6RSwziGvPcJLQ0=
X-Google-Smtp-Source: AK7set/eyQGENHOJzGaq7pr/BSJsfv75n2FujnAvn9JaepKYwNOkwAJqtTHMO7pJ4h4+a+WTKRjVwA==
X-Received: by 2002:a5d:4ecd:0:b0:2c5:4fde:7716 with SMTP id s13-20020a5d4ecd000000b002c54fde7716mr2512784wrv.24.1676753396153;
        Sat, 18 Feb 2023 12:49:56 -0800 (PST)
Received: from localhost (94.197.47.81.threembb.co.uk. [94.197.47.81])
        by smtp.gmail.com with ESMTPSA id b5-20020adfee85000000b002c559626a50sm772305wro.13.2023.02.18.12.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 12:49:55 -0800 (PST)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     sre@kernel.org, wens@csie.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/5] power: supply: axp20x_usb_power: Use regmap field for VBUS disabling
Date:   Sat, 18 Feb 2023 20:49:45 +0000
Message-Id: <20230218204946.106316-5-aidanmacdonald.0x0@gmail.com>
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

The POWER_SUPPLY_PROP_ONLINE property allows controlling the VBUS
enable state on supported PMICs. Switch to regmap fields to reduce
dependence on variant IDs.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/power/supply/axp20x_usb_power.c | 29 +++++++++++--------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 20a76c19cfad..89f076615d2e 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -31,9 +31,6 @@
 
 #define AXP20X_USB_STATUS_VBUS_VALID	BIT(2)
 
-#define AXP20X_VBUS_PATH_SEL		BIT(7)
-#define AXP20X_VBUS_PATH_SEL_OFFSET	7
-
 #define AXP20X_VBUS_VHOLD_uV(b)		(4000000 + (((b) >> 3) & 7) * 100000)
 #define AXP20X_VBUS_VHOLD_MASK		GENMASK(5, 3)
 #define AXP20X_VBUS_VHOLD_OFFSET	3
@@ -57,6 +54,7 @@ struct axp_data {
 	struct reg_field		vbus_valid_bit;
 	struct reg_field		vbus_mon_bit;
 	struct reg_field		usb_bc_en_bit;
+	struct reg_field		vbus_disable_bit;
 };
 
 struct axp20x_usb_power {
@@ -65,6 +63,7 @@ struct axp20x_usb_power {
 	struct regmap_field *vbus_valid_bit;
 	struct regmap_field *vbus_mon_bit;
 	struct regmap_field *usb_bc_en_bit;
+	struct regmap_field *vbus_disable_bit;
 	struct power_supply *supply;
 	enum axp20x_variants axp20x_id;
 	const struct axp_data *axp_data;
@@ -231,16 +230,6 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
 	return 0;
 }
 
-static int axp813_usb_power_set_online(struct axp20x_usb_power *power,
-				       int intval)
-{
-	int val = !intval << AXP20X_VBUS_PATH_SEL_OFFSET;
-
-	return regmap_update_bits(power->regmap,
-				  AXP20X_VBUS_IPSOUT_MGMT,
-				  AXP20X_VBUS_PATH_SEL, val);
-}
-
 static int axp20x_usb_power_set_voltage_min(struct axp20x_usb_power *power,
 					    int intval)
 {
@@ -290,9 +279,10 @@ static int axp20x_usb_power_set_property(struct power_supply *psy,
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_ONLINE:
-		if (power->axp20x_id != AXP813_ID)
+		if (!power->vbus_disable_bit)
 			return -EINVAL;
-		return axp813_usb_power_set_online(power, val->intval);
+
+		return regmap_field_write(power->vbus_disable_bit, !val->intval);
 
 	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
 		return axp20x_usb_power_set_voltage_min(power, val->intval);
@@ -320,7 +310,7 @@ static int axp20x_usb_power_prop_writeable(struct power_supply *psy,
 	 * the VBUS input offline.
 	 */
 	if (psp == POWER_SUPPLY_PROP_ONLINE)
-		return power->axp20x_id == AXP813_ID;
+		return power->vbus_disable_bit != NULL;
 
 	return psp == POWER_SUPPLY_PROP_VOLTAGE_MIN ||
 	       psp == POWER_SUPPLY_PROP_CURRENT_MAX;
@@ -434,6 +424,7 @@ static const struct axp_data axp813_data = {
 	.curr_lim_table = axp813_usb_curr_lim_table,
 	.curr_lim_fld   = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 0, 1),
 	.usb_bc_en_bit	= REG_FIELD(AXP288_BC_GLOBAL, 0, 0),
+	.vbus_disable_bit = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 7, 7),
 };
 
 #ifdef CONFIG_PM_SLEEP
@@ -579,6 +570,12 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = axp20x_regmap_field_alloc_optional(&pdev->dev, power->regmap,
+						 axp_data->vbus_disable_bit,
+						 &power->vbus_disable_bit);
+	if (ret)
+		return ret;
+
 	ret = devm_delayed_work_autocancel(&pdev->dev, &power->vbus_detect,
 					   axp20x_usb_power_poll_vbus);
 	if (ret)
-- 
2.39.2


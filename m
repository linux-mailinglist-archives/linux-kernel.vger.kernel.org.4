Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC236FDD2E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 13:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236856AbjEJLwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 07:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237021AbjEJLvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 07:51:50 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5A435A3;
        Wed, 10 May 2023 04:51:49 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-2f27a9c7970so6730361f8f.2;
        Wed, 10 May 2023 04:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683719507; x=1686311507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+e0WO9314+22bYk2/c0IG6PriU+XsPi5/aWiGwjMuE=;
        b=Q/E/T1aHHQGd8tG4pCXUPk93NhLvFH0M+pemyAz0J37e8tRIPpFC1XoJprjPtlpkXx
         VxZudODg3w+OZnbq2u2Of/01KfEKLKU4S74UnmRlcUs1iwoyp9bZHa2xXoaewgkF3K8C
         UFFitLWAWJK3BHODRC8x4qlXLNsHW/l9T3PiWqHBkS2yHAPXzjlLgOincgaq9x9YyHni
         jQzdkT9iTlaqlJ16zFl5/VQqJRRybTyE5kmsJracyG7MCl2P2Yw8lZvD+wSU2jzl+M2U
         PtSZ6xX+JCzRsl5+gZQqO+iG1ekHSS1GsM/iaJKHx28obrCPfUdo1rcyz6X+Y4yRK4Yk
         GR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683719507; x=1686311507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r+e0WO9314+22bYk2/c0IG6PriU+XsPi5/aWiGwjMuE=;
        b=BpU1LAVJ8Npw00rMXXB6T41jM0mg+wlbe93CkHa79lPXi/H/3GfL9lX7hAi49FlhEb
         n1wDtUIilS0R1bf+dcLtAxZ0uTLCf3TDsE9NllRpqEQS3Cus/y8I0623X7uI5Xl51wtz
         NrtQ0P7YZ6YUrKyDyXKG2siY6NztNbFPK2DdpVYLwREk27jjyL3W3u5Jk5t1CH/+WCwU
         dgie97n2rlYHYg0HUPI4u2YCHVQTqnefO0ECnri6Dkp2BtsYJbijwJB1GSSXbsIHuJZv
         Qm5dNL/ztqZ1KTH3b727MiDdlVyqT7OQxMXxfqHgu4HsHtI3QL2SNScozNKlVRqUPeSp
         bQNQ==
X-Gm-Message-State: AC+VfDx+y30mbFbUp0bcB+WiATkXNb42ZCmEAjzD1G1G5ejwCghbDOEa
        PYx4uHpyIxCsqTCixOJ9yCEtD++30r4=
X-Google-Smtp-Source: ACHHUZ76W1o5twe5boP7VQFqcPUI3XuQokY+zIZjQqirKHxWQkYMhOO3YpVV+xMQhQBXNIN+otcDUg==
X-Received: by 2002:a5d:6d4d:0:b0:306:2927:b581 with SMTP id k13-20020a5d6d4d000000b003062927b581mr11419223wri.46.1683719507494;
        Wed, 10 May 2023 04:51:47 -0700 (PDT)
Received: from localhost ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id z8-20020adfec88000000b003062675d4c9sm17094885wrn.39.2023.05.10.04.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 04:51:47 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     sre@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        wens@csie.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/7] power: supply: axp20x_usb_power: Use regmap field for VBUS disabling
Date:   Wed, 10 May 2023 12:50:43 +0100
Message-Id: <20230510115046.963432-5-aidanmacdonald.0x0@gmail.com>
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


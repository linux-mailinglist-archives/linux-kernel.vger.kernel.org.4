Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07E8600461
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 01:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiJPXnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 19:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiJPXmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 19:42:53 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C433038449;
        Sun, 16 Oct 2022 16:42:33 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id a3so16087493wrt.0;
        Sun, 16 Oct 2022 16:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6706nU4p7iq9wHYgQ+Dtrw1GcYB0dWgaEHmzw7yDg1c=;
        b=BIf82YTB4Ss8IOrnHMsPmUp39Hbw1ZkvXkZZqkYigh/f8Z86X/tFzm3d36uZAF73dJ
         mzP5U81Wsd8+exjUfqOOIOlnfrQ6NmXCyIquJxrek088/Ew1BjqTvArGxJDojFn000wc
         B6ENJBF3txgbnvW6kRDf64IEWklPP0nNN6PWBuKSfnvHEyCtTXi3eX7VS2AAcmBluoHD
         qXAIa4EBMfQEdjzeVHKi3I4Y25nrDQn/gktdFoEpJaLnJ37+NkHZDvuJX9e6zo9UaMON
         GaJNC2xFNJpGUie7SJqB/TaXoa1oUjfh2R7/DB3bO6zRTcWy8Ie66CEQtug7PMU8BXCc
         1z7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6706nU4p7iq9wHYgQ+Dtrw1GcYB0dWgaEHmzw7yDg1c=;
        b=vndZJbExV49fuAz52WjcHYXZNRSzdhYlp4FQ9t9sxaEHMZEaq+tRLo/fAdYNnsDoYc
         8979z6TR4XYQ5lzSr19r1uJD+zbRkZ/EHHtXSnUAkCGjxKbcVi59oomtXAMl+aQ6usIM
         HdmbYf+zDctnxB4v0CnFmG9U11OM6FXGuhy1L/KW0tCl50cIDTlw56DQyhrhFJKhB/J+
         mc4hefbVfujACIXHPTVgL7V/Gli/o0x2QEp+WD+3vcWxNCUKlKqEbaOkQILvOL3m78JK
         ejvbV80n7TCzQqm+MjGzEo1kU1ButyDDyU5vZzI1UV+fKqCVgLzPATLaJ9pw4He8WBYj
         kR8A==
X-Gm-Message-State: ACrzQf1FvLJTmieX6cWjLm/WYPhmtv7ZTHzwVBafuEsQD8eXRydjVmkO
        5EBFahX58RWq6eKuE+Zf9/yjqACsR81f8g==
X-Google-Smtp-Source: AMsMyM7pSfzTlPlJAN6WJH+4EJnWcQEWpkM78YOXMTtPT/y3Wnwljc/8t5bWUF7R4cn/QFQpOueXug==
X-Received: by 2002:a5d:5612:0:b0:22e:35b7:5654 with SMTP id l18-20020a5d5612000000b0022e35b75654mr4718820wrv.651.1665963751137;
        Sun, 16 Oct 2022 16:42:31 -0700 (PDT)
Received: from localhost (188.31.4.189.threembb.co.uk. [188.31.4.189])
        by smtp.gmail.com with ESMTPSA id q13-20020a05600c46cd00b003c6f426467fsm3332702wmo.40.2022.10.16.16.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 16:42:30 -0700 (PDT)
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
Subject: [PATCH v6 11/13] power: axp20x_battery: Add constant charge current table
Date:   Mon, 17 Oct 2022 00:43:33 +0100
Message-Id: <20221016234335.904212-12-aidanmacdonald.0x0@gmail.com>
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

Add a table-based lookup method for constant charge current,
which is necessary when the setting cannot be represented as
a linear range.

This also replaces the hard-coded 300 mA default ccc setting
if the DT-specified value is unsupported; the minimum value
for the device is now set exactly instead of relying on the
value being rounded down to a supported value.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/power/supply/axp20x_battery.c | 59 +++++++++++++++++++++------
 1 file changed, 47 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
index 9106077c0dbb..401779d84d2b 100644
--- a/drivers/power/supply/axp20x_battery.c
+++ b/drivers/power/supply/axp20x_battery.c
@@ -61,6 +61,14 @@ struct axp20x_batt_ps;
 struct axp_data {
 	int	ccc_scale;
 	int	ccc_offset;
+	/*
+	 * Lookup table for constant charge current, if provided this is used
+	 * instead of ccc_scale/ccc_offset.
+	 *
+	 * The table is indexed by the field AXP20X_CHRG_CTRL1_TGT_CURR so it
+	 * must have AXP20X_CHRG_CTRL1_TGT_CURR+1 elements.
+	 */
+	const int *ccc_table;
 	bool	has_fg_valid;
 	int	(*get_max_voltage)(struct axp20x_batt_ps *batt, int *val);
 	int	(*set_max_voltage)(struct axp20x_batt_ps *batt, int val);
@@ -176,7 +184,10 @@ static int axp20x_get_constant_charge_current(struct axp20x_batt_ps *axp,
 
 	*val &= AXP20X_CHRG_CTRL1_TGT_CURR;
 
-	*val = *val * axp->data->ccc_scale + axp->data->ccc_offset;
+	if (axp->data->ccc_table)
+		*val = axp->data->ccc_table[*val];
+	else
+		*val = *val * axp->data->ccc_scale + axp->data->ccc_offset;
 
 	return 0;
 }
@@ -389,16 +400,35 @@ static int axp20x_battery_set_max_voltage(struct axp20x_batt_ps *axp20x_batt,
 				  AXP20X_CHRG_CTRL1_TGT_VOLT, val);
 }
 
+static int axp20x_get_constant_charge_current_sel(struct axp20x_batt_ps *axp_batt,
+						  int charge_current)
+{
+	int i;
+
+	if (axp_batt->data->ccc_table) {
+		for (i = AXP20X_CHRG_CTRL1_TGT_CURR; i >= 0; i--) {
+			if (axp_batt->data->ccc_table[i] <= charge_current)
+				return i;
+		}
+
+		return -EINVAL;
+	}
+
+	i = (charge_current - axp_batt->data->ccc_offset) / axp_batt->data->ccc_scale;
+	if (i > AXP20X_CHRG_CTRL1_TGT_CURR || i < 0)
+		return -EINVAL;
+
+	return i;
+}
+
 static int axp20x_set_constant_charge_current(struct axp20x_batt_ps *axp_batt,
 					      int charge_current)
 {
 	if (charge_current > axp_batt->max_ccc)
 		return -EINVAL;
 
-	charge_current = (charge_current - axp_batt->data->ccc_offset) /
-		axp_batt->data->ccc_scale;
-
-	if (charge_current > AXP20X_CHRG_CTRL1_TGT_CURR || charge_current < 0)
+	charge_current = axp20x_get_constant_charge_current_sel(axp_batt, charge_current);
+	if (charge_current < 0)
 		return -EINVAL;
 
 	return regmap_update_bits(axp_batt->regmap, AXP20X_CHRG_CTRL1,
@@ -410,14 +440,14 @@ static int axp20x_set_max_constant_charge_current(struct axp20x_batt_ps *axp,
 {
 	bool lower_max = false;
 
-	charge_current = (charge_current - axp->data->ccc_offset) /
-		axp->data->ccc_scale;
-
-	if (charge_current > AXP20X_CHRG_CTRL1_TGT_CURR || charge_current < 0)
+	charge_current = axp20x_get_constant_charge_current_sel(axp, charge_current);
+	if (charge_current < 0)
 		return -EINVAL;
 
-	charge_current = charge_current * axp->data->ccc_scale +
-		axp->data->ccc_offset;
+	if (axp->data->ccc_table)
+		charge_current = axp->data->ccc_table[charge_current];
+	else
+		charge_current = charge_current * axp->data->ccc_scale + axp->data->ccc_offset;
 
 	if (charge_current > axp->max_ccc)
 		dev_warn(axp->dev,
@@ -629,7 +659,12 @@ static int axp20x_power_probe(struct platform_device *pdev)
 								   ccc)) {
 			dev_err(&pdev->dev,
 				"couldn't set constant charge current from DT: fallback to minimum value\n");
-			ccc = 300000;
+
+			if (axp20x_batt->data->ccc_table)
+				ccc = axp20x_batt->data->ccc_table[0];
+			else
+				ccc = axp20x_batt->data->ccc_offset;
+
 			axp20x_batt->max_ccc = ccc;
 			axp20x_set_constant_charge_current(axp20x_batt, ccc);
 		}
-- 
2.38.0


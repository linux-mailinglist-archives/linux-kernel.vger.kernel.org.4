Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E9070ADC4
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 13:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbjEULr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 07:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjEULqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 07:46:05 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8701FE4C
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 04:40:10 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-96f588bc322so427155766b.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 04:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684669209; x=1687261209;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ThlmQ9/C96MUGf03mOZmnjGDzq2pSyB3lE6yZuqFXk=;
        b=mZSyIYlSDtq9bVp4uuDbfCau4SL2O4+64oCK9s8g4xJgf5j0VNFSOGdVnRKiv8CtlR
         rNKwn+rvqfyvk42vMdulo9QZj2pHBGJugRGvvZZbQEie0D7T2rPl20agG0r9Ee7eriS2
         guK21giyZqb5DF+YLvBD0i3/0VGkLrSkWk2gi3jegRrHAHgOmC2mFMJMzKaTGYge+pan
         2eHZqL6UI6qZF01VlrorpANvtIhO1IukJDO3JlOsEowgXHX0HIVzvhWfN4lrQDqJ4r20
         ldd9+fgCuETHcsfn4DfUypJFCql48GU2QQcpHh9Sz9PN3wuTBW1+i88MNFiW+iHR2rNs
         ndBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684669209; x=1687261209;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ThlmQ9/C96MUGf03mOZmnjGDzq2pSyB3lE6yZuqFXk=;
        b=BaWbXtNaQhjnF2uzoy5fUSexwN++0F7+vcRQt8gKnGuZL3+0eWPas1WgLjdXW5vyhd
         ASa6/uuO1SUYYEUUoXBjiOUpdfr29IoYdLXDmXKbmpqD2grExaQ1aS5Au30Xzfwx3UFt
         G5MwRErUxlDbeffizEDgyrbvtwcbS0y4ZcHozrUwA/7vDjXvFJaQ2j92Cw5wjv8olZpv
         rmjY8wztgQo5oPLe4+22PPAVFi7E7mYWkIqSjfXJlAoKedtI7nY1ZEf662hNKgRFlLhB
         wY04+jfMDCh1gSWm7xebqnFkZyDD+oEo/MZN1guHGqPj4FB/u3tsR0EoDG8N5yWHifWI
         dTbA==
X-Gm-Message-State: AC+VfDy47YHKWNE7l0X6uyArSR1vLwEGQM8/nvx8+93mzciQrg36lLkY
        yiuii0hC+o4wQUcYz9JIjbo=
X-Google-Smtp-Source: ACHHUZ5ymiSN62eLBPeoGF0OZ/XsbI5fcCnWvKSe1Xvdcvc9J9TIJvaBoyk1z1MwEMwlFYszLPNbhQ==
X-Received: by 2002:a17:906:ee82:b0:966:37b2:734a with SMTP id wt2-20020a170906ee8200b0096637b2734amr6921951ejb.22.1684669208869;
        Sun, 21 May 2023 04:40:08 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id h25-20020a1709070b1900b0096f7996d59csm1833911ejl.184.2023.05.21.04.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 04:40:08 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Sun, 21 May 2023 13:39:54 +0200
Subject: [PATCH RFC v3 5/5] regulator: bd718x7: let the core handle the
 monitors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230419-dynamic-vmon-v3-5-4179b586d8a1@skidata.com>
References: <20230419-dynamic-vmon-v3-0-4179b586d8a1@skidata.com>
In-Reply-To: <20230419-dynamic-vmon-v3-0-4179b586d8a1@skidata.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     support.opensource@diasemi.com,
        DLG-Adam.Ward.opensource@dm.renesas.com,
        linux-kernel@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Benjamin Bara <benjamin.bara@skidata.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Bara <benjamin.bara@skidata.com>

The monitors of the bd718x7 must be disabled while the respective
regulator is switching to a higher voltage. Use the new property
'.mon_disable_reg_set_higher' to activate the handling in the core.

.mon_disable_reg_set_higher requires get_active_protections() to find
out if a regulator is monitored without the device-tree knowing it.
Otherwise, this might lead to a failure as the core might not be aware
that a regulator is monitored and therefore would not disable it.
Therefore, implement it.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 drivers/regulator/bd718x7-regulator.c | 206 +++++++++++-----------------------
 1 file changed, 66 insertions(+), 140 deletions(-)

diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd718x7-regulator.c
index b0b9938c20a1..897388d68949 100644
--- a/drivers/regulator/bd718x7-regulator.c
+++ b/drivers/regulator/bd718x7-regulator.c
@@ -56,7 +56,7 @@
 
 #define BD718XX_OPS(name, _list_voltage, _map_voltage, _set_voltage_sel, \
 		   _get_voltage_sel, _set_voltage_time_sel, _set_ramp_delay, \
-		   _set_uvp, _set_ovp)				\
+		   _set_uvp, _set_ovp, _get_prot)		\
 static const struct regulator_ops name = {			\
 	.enable = regulator_enable_regmap,			\
 	.disable = regulator_disable_regmap,			\
@@ -69,6 +69,7 @@ static const struct regulator_ops name = {			\
 	.set_ramp_delay = (_set_ramp_delay),			\
 	.set_under_voltage_protection = (_set_uvp),		\
 	.set_over_voltage_protection = (_set_ovp),		\
+	.get_active_protections = (_get_prot),			\
 };								\
 								\
 static const struct regulator_ops BD718XX_HWOPNAME(name) = {	\
@@ -81,6 +82,7 @@ static const struct regulator_ops BD718XX_HWOPNAME(name) = {	\
 	.set_ramp_delay = (_set_ramp_delay),			\
 	.set_under_voltage_protection = (_set_uvp),		\
 	.set_over_voltage_protection = (_set_ovp),		\
+	.get_active_protections = (_get_prot),			\
 }								\
 
 /*
@@ -126,128 +128,6 @@ static int bd71837_get_buck34_enable_hwctrl(struct regulator_dev *rdev)
 	return !!(BD718XX_BUCK_RUN_ON & val);
 }
 
-static void voltage_change_done(struct regulator_dev *rdev, unsigned int sel,
-				unsigned int *mask)
-{
-	int ret;
-
-	if (*mask) {
-		/*
-		 * Let's allow scheduling as we use I2C anyways. We just need to
-		 * guarantee minimum of 1ms sleep - it shouldn't matter if we
-		 * exceed it due to the scheduling.
-		 */
-		msleep(1);
-
-		ret = regmap_clear_bits(rdev->regmap, BD718XX_REG_MVRFLTMASK2,
-					 *mask);
-		if (ret)
-			dev_err(&rdev->dev,
-				"Failed to re-enable voltage monitoring (%d)\n",
-				ret);
-	}
-}
-
-static int voltage_change_prepare(struct regulator_dev *rdev, unsigned int sel,
-				  unsigned int *mask)
-{
-	int ret;
-
-	*mask = 0;
-	if (rdev->desc->ops->is_enabled(rdev)) {
-		int now, new;
-
-		now = rdev->desc->ops->get_voltage_sel(rdev);
-		if (now < 0)
-			return now;
-
-		now = rdev->desc->ops->list_voltage(rdev, now);
-		if (now < 0)
-			return now;
-
-		new = rdev->desc->ops->list_voltage(rdev, sel);
-		if (new < 0)
-			return new;
-
-		/*
-		 * If we increase LDO voltage when LDO is enabled we need to
-		 * disable the power-good detection until voltage has reached
-		 * the new level. According to HW colleagues the maximum time
-		 * it takes is 1000us. I assume that on systems with light load
-		 * this might be less - and we could probably use DT to give
-		 * system specific delay value if performance matters.
-		 *
-		 * Well, knowing we use I2C here and can add scheduling delays
-		 * I don't think it is worth the hassle and I just add fixed
-		 * 1ms sleep here (and allow scheduling). If this turns out to
-		 * be a problem we can change it to delay and make the delay
-		 * time configurable.
-		 */
-		if (new > now) {
-			int tmp;
-			int prot_bit;
-			int ldo_offset = rdev->desc->id - BD718XX_LDO1;
-
-			prot_bit = BD718XX_LDO1_VRMON80 << ldo_offset;
-			ret = regmap_read(rdev->regmap, BD718XX_REG_MVRFLTMASK2,
-					  &tmp);
-			if (ret) {
-				dev_err(&rdev->dev,
-					"Failed to read voltage monitoring state\n");
-				return ret;
-			}
-
-			if (!(tmp & prot_bit)) {
-				/* We disable protection if it was enabled... */
-				ret = regmap_set_bits(rdev->regmap,
-						      BD718XX_REG_MVRFLTMASK2,
-						      prot_bit);
-				/* ...and we also want to re-enable it */
-				*mask = prot_bit;
-			}
-			if (ret) {
-				dev_err(&rdev->dev,
-					"Failed to stop voltage monitoring\n");
-				return ret;
-			}
-		}
-	}
-
-	return 0;
-}
-
-static int bd718xx_set_voltage_sel_restricted(struct regulator_dev *rdev,
-						    unsigned int sel)
-{
-	int ret;
-	int mask;
-
-	ret = voltage_change_prepare(rdev, sel, &mask);
-	if (ret)
-		return ret;
-
-	ret = regulator_set_voltage_sel_regmap(rdev, sel);
-	voltage_change_done(rdev, sel, &mask);
-
-	return ret;
-}
-
-static int bd718xx_set_voltage_sel_pickable_restricted(
-		struct regulator_dev *rdev, unsigned int sel)
-{
-	int ret;
-	int mask;
-
-	ret = voltage_change_prepare(rdev, sel, &mask);
-	if (ret)
-		return ret;
-
-	ret = regulator_set_voltage_sel_pickable_regmap(rdev, sel);
-	voltage_change_done(rdev, sel, &mask);
-
-	return ret;
-}
-
 static int bd71837_set_voltage_sel_pickable_restricted(
 		struct regulator_dev *rdev, unsigned int sel)
 {
@@ -457,6 +337,21 @@ static int bd718x7_xvp_sanity_check(struct regulator_dev *rdev, int lim_uV,
 	return 0;
 }
 
+static int bd717x7_get_ldo_prot(struct regulator_dev *rdev, unsigned int *val)
+{
+	int ldo_offset = rdev->desc->id - BD718XX_LDO1;
+	int prot_bit = BD718XX_LDO1_VRMON80 << ldo_offset;
+	int ret;
+
+	ret = regmap_test_bits(rdev->regmap, BD718XX_REG_MVRFLTMASK2, prot_bit);
+	if (ret < 0)
+		return ret;
+	if (ret)
+		*val |= REGULATOR_MONITOR_UNDER_VOLTAGE;
+
+	return 0;
+}
+
 static int bd718x7_set_ldo_uvp(struct regulator_dev *rdev, int lim_uV,
 			       int severity, bool enable)
 {
@@ -519,6 +414,31 @@ static int bd718x7_get_buck_uvp_info(int id, int *reg, int *bit)
 	return 0;
 }
 
+static int bd717x7_get_buck_prot(struct regulator_dev *rdev, unsigned int *val)
+{
+	int ret, reg, bit;
+
+	ret = bd718x7_get_buck_uvp_info(rdev->desc->id, &reg, &bit);
+	if (ret)
+		return ret;
+	ret = regmap_test_bits(rdev->regmap, reg, bit);
+	if (ret < 0)
+		return ret;
+	if (ret)
+		*val |= REGULATOR_MONITOR_UNDER_VOLTAGE;
+
+	ret = bd718x7_get_buck_ovp_info(rdev->desc->id, &reg, &bit);
+	if (ret)
+		return ret;
+	ret = regmap_test_bits(rdev->regmap, reg, bit);
+	if (ret < 0)
+		return ret;
+	if (ret)
+		*val |= REGULATOR_MONITOR_OVER_VOLTAGE;
+
+	return 0;
+}
+
 static int bd718x7_set_buck_uvp(struct regulator_dev *rdev, int lim_uV,
 				int severity, bool enable)
 {
@@ -564,15 +484,15 @@ static int bd718x7_set_buck_ovp(struct regulator_dev *rdev, int lim_uV,
  */
 BD718XX_OPS(bd718xx_pickable_range_ldo_ops,
 	    regulator_list_voltage_pickable_linear_range, NULL,
-	    bd718xx_set_voltage_sel_pickable_restricted,
+	    regulator_set_voltage_sel_pickable_regmap,
 	    regulator_get_voltage_sel_pickable_regmap, NULL, NULL,
-	    bd718x7_set_ldo_uvp, NULL);
+	    bd718x7_set_ldo_uvp, NULL, bd717x7_get_ldo_prot);
 
 /* BD71847 and BD71850 LDO 5 is by default OFF at RUN state */
 static const struct regulator_ops bd718xx_ldo5_ops_hwstate = {
 	.is_enabled = never_enabled_by_hwstate,
 	.list_voltage = regulator_list_voltage_pickable_linear_range,
-	.set_voltage_sel = bd718xx_set_voltage_sel_pickable_restricted,
+	.set_voltage_sel = regulator_set_voltage_sel_pickable_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_pickable_regmap,
 	.set_under_voltage_protection = bd718x7_set_ldo_uvp,
 };
@@ -582,27 +502,27 @@ BD718XX_OPS(bd718xx_pickable_range_buck_ops,
 	    regulator_set_voltage_sel_pickable_regmap,
 	    regulator_get_voltage_sel_pickable_regmap,
 	    regulator_set_voltage_time_sel, NULL, bd718x7_set_buck_uvp,
-	    bd718x7_set_buck_ovp);
+	    bd718x7_set_buck_ovp, bd717x7_get_buck_prot);
 
 BD718XX_OPS(bd718xx_ldo_regulator_ops, regulator_list_voltage_linear_range,
-	    NULL, bd718xx_set_voltage_sel_restricted,
+	    NULL, regulator_set_voltage_sel_regmap,
 	    regulator_get_voltage_sel_regmap, NULL, NULL, bd718x7_set_ldo_uvp,
-	    NULL);
+	    NULL, bd717x7_get_ldo_prot);
 
 BD718XX_OPS(bd718xx_ldo_regulator_nolinear_ops, regulator_list_voltage_table,
-	    NULL, bd718xx_set_voltage_sel_restricted,
+	    NULL, regulator_set_voltage_sel_regmap,
 	    regulator_get_voltage_sel_regmap, NULL, NULL, bd718x7_set_ldo_uvp,
-	    NULL);
+	    NULL, bd717x7_get_ldo_prot);
 
 BD718XX_OPS(bd718xx_buck_regulator_ops, regulator_list_voltage_linear_range,
 	    NULL, regulator_set_voltage_sel_regmap,
 	    regulator_get_voltage_sel_regmap, regulator_set_voltage_time_sel,
-	    NULL, bd718x7_set_buck_uvp, bd718x7_set_buck_ovp);
+	    NULL, bd718x7_set_buck_uvp, bd718x7_set_buck_ovp, bd717x7_get_buck_prot);
 
 BD718XX_OPS(bd718xx_buck_regulator_nolinear_ops, regulator_list_voltage_table,
 	    regulator_map_voltage_ascend, regulator_set_voltage_sel_regmap,
 	    regulator_get_voltage_sel_regmap, regulator_set_voltage_time_sel,
-	    NULL, bd718x7_set_buck_uvp, bd718x7_set_buck_ovp);
+	    NULL, bd718x7_set_buck_uvp, bd718x7_set_buck_ovp, bd717x7_get_buck_prot);
 
 /*
  * OPS for BD71837
@@ -611,34 +531,34 @@ BD718XX_OPS(bd71837_pickable_range_ldo_ops,
 	    regulator_list_voltage_pickable_linear_range, NULL,
 	    bd71837_set_voltage_sel_pickable_restricted,
 	    regulator_get_voltage_sel_pickable_regmap, NULL, NULL,
-	    bd718x7_set_ldo_uvp, NULL);
+	    bd718x7_set_ldo_uvp, NULL, bd717x7_get_ldo_prot);
 
 BD718XX_OPS(bd71837_pickable_range_buck_ops,
 	    regulator_list_voltage_pickable_linear_range, NULL,
 	    bd71837_set_voltage_sel_pickable_restricted,
 	    regulator_get_voltage_sel_pickable_regmap,
 	    regulator_set_voltage_time_sel, NULL, bd718x7_set_buck_uvp,
-	    bd718x7_set_buck_ovp);
+	    bd718x7_set_buck_ovp, bd717x7_get_buck_prot);
 
 BD718XX_OPS(bd71837_ldo_regulator_ops, regulator_list_voltage_linear_range,
 	    NULL, rohm_regulator_set_voltage_sel_restricted,
 	    regulator_get_voltage_sel_regmap, NULL, NULL, bd718x7_set_ldo_uvp,
-	    NULL);
+	    NULL, bd717x7_get_ldo_prot);
 
 BD718XX_OPS(bd71837_ldo_regulator_nolinear_ops, regulator_list_voltage_table,
 	    NULL, rohm_regulator_set_voltage_sel_restricted,
 	    regulator_get_voltage_sel_regmap, NULL, NULL, bd718x7_set_ldo_uvp,
-	    NULL);
+	    NULL, bd717x7_get_ldo_prot);
 
 BD718XX_OPS(bd71837_buck_regulator_ops, regulator_list_voltage_linear_range,
 	    NULL, rohm_regulator_set_voltage_sel_restricted,
 	    regulator_get_voltage_sel_regmap, regulator_set_voltage_time_sel,
-	    NULL, bd718x7_set_buck_uvp, bd718x7_set_buck_ovp);
+	    NULL, bd718x7_set_buck_uvp, bd718x7_set_buck_ovp, bd717x7_get_buck_prot);
 
 BD718XX_OPS(bd71837_buck_regulator_nolinear_ops, regulator_list_voltage_table,
 	    regulator_map_voltage_ascend, rohm_regulator_set_voltage_sel_restricted,
 	    regulator_get_voltage_sel_regmap, regulator_set_voltage_time_sel,
-	    NULL, bd718x7_set_buck_uvp, bd718x7_set_buck_ovp);
+	    NULL, bd718x7_set_buck_uvp, bd718x7_set_buck_ovp, bd717x7_get_buck_prot);
 /*
  * BD71837 bucks 3 and 4 support defining their enable/disable state also
  * when buck enable state is under HW state machine control. In that case the
@@ -662,7 +582,7 @@ BD718XX_OPS(bd718xx_dvs_buck_regulator_ops, regulator_list_voltage_linear_range,
 	    NULL, regulator_set_voltage_sel_regmap,
 	    regulator_get_voltage_sel_regmap, regulator_set_voltage_time_sel,
 	    regulator_set_ramp_delay_regmap, bd718x7_set_buck_uvp,
-	    bd718x7_set_buck_ovp);
+	    bd718x7_set_buck_ovp, bd717x7_get_buck_prot);
 
 
 
@@ -1772,6 +1692,12 @@ static int bd718xx_probe(struct platform_device *pdev)
 		else
 			desc->ops = swops[i];
 
+		/*
+		 * bd718x7 requires to disable a regulator's monitors while it
+		 * changes to a higher value.
+		 */
+		desc->mon_disable_reg_set_higher = 1;
+
 		rdev = devm_regulator_register(&pdev->dev, desc, &config);
 		if (IS_ERR(rdev))
 			return dev_err_probe(&pdev->dev, PTR_ERR(rdev),

-- 
2.34.1


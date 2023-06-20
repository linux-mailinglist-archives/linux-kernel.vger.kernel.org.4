Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390C1737599
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 22:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjFTUDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 16:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjFTUDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 16:03:39 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926AA10F0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 13:03:37 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-986d871a9beso666484466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 13:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687291416; x=1689883416;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pWvUB1XeUSFbOw9iH7XJZnU3aK4Y3VR9DMKZWeotTDY=;
        b=ayQ31QczW0g6Lq6i9ZJtw3LRZ6KLyK4/ZzfgMpgohPs40OQNe3HdC92u6ktY0Q+LAL
         hBmffXH8VzFi5hwnqVeYYr+KJyLKiJabxDOrWOO4RcJMQp9MjN0IdEWULQB12PbHFylX
         0kTaD9wG++mA43Mk98zJ/8J7ekVFRbfWACp5X5kICz+IJvYDzFiJZb5vxcE57BitnyXz
         K1Du/QjOD2pW64+Dgib4JX3nWcOB6F6QKxe1uXOfR9totB3i55CeUeyG6swf3t44jiYX
         FyH9Fo8tsRyhsAAGIEE2rQHXDTwgvfKXkmr/B7sC1QrWvDy5HnIUURx2x9qhf/HHsQje
         1QSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687291416; x=1689883416;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pWvUB1XeUSFbOw9iH7XJZnU3aK4Y3VR9DMKZWeotTDY=;
        b=K1qzjvzl3AezYCbXQwxFLggGMoayzH5CewJxS/mSBg+H9VBG0qp1hYApodjVGvf6Mb
         cIeI7/xWcDX5jyyrln8jeADq75RBX2VVniy3I48YTSu1aOjcnSGEyGlF7bkSVR8MB9m0
         5mz+E9fi6i2gZPzXu1hqTW8Ioqvo9bv7zCYEWA3FVKA6Eh76QHEKaI6bXJ6pUhrXqyXh
         E1B7hFUTm3vC/CfaRxlyEkt2Gf5xZv64gRb8mm3uZ/kyOg0K4/aNt8ouv7Zgv17x4LOK
         uQOgyvZQ4SYKRVmDyhEoDFoXctxbARudklL1CFPFKAekzno1wgAJQNqIUWa4cQ7ktSDr
         T0uA==
X-Gm-Message-State: AC+VfDxpWCEEZGYSxIZXLJ2KuU5ozd0oDLuXVmWAAjui53tnazw+KtMH
        oAS7po4DSp7cEdxyX2deKbQ=
X-Google-Smtp-Source: ACHHUZ5uEgYuFOd4F9lgEw6hWzA1f1XjTIEpLQc9yVH037uDzZk8UBT2bq+vcBaPewoyaABu2V619A==
X-Received: by 2002:a17:906:db0d:b0:977:abac:9635 with SMTP id xj13-20020a170906db0d00b00977abac9635mr11491421ejb.20.1687291415948;
        Tue, 20 Jun 2023 13:03:35 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id u21-20020a17090617d500b00977e0bcff1esm1947064eje.10.2023.06.20.13.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 13:03:35 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Tue, 20 Jun 2023 22:02:57 +0200
Subject: [PATCH RFC v4 04/13] regulator: bd718x7: implement
 get_active_protections()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230419-dynamic-vmon-v4-4-4d3734e62ada@skidata.com>
References: <20230419-dynamic-vmon-v4-0-4d3734e62ada@skidata.com>
In-Reply-To: <20230419-dynamic-vmon-v4-0-4d3734e62ada@skidata.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     support.opensource@diasemi.com,
        DLG-Adam.Ward.opensource@dm.renesas.com,
        Martin Fuzzey <martin.fuzzey@flowbird.group>,
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

This is required as the mon_disable_reg_set_higher workaround property
requires the ops to find out if it the monitor is set without the
device-tree being aware of it.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 drivers/regulator/bd718x7-regulator.c | 74 ++++++++++++++++++++++++++++-------
 1 file changed, 60 insertions(+), 14 deletions(-)

diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd718x7-regulator.c
index b0b9938c20a1..fbf609d219fc 100644
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
@@ -457,6 +459,23 @@ static int bd718x7_xvp_sanity_check(struct regulator_dev *rdev, int lim_uV,
 	return 0;
 }
 
+static int bd717x7_get_ldo_prot(struct regulator_dev *rdev, unsigned int *state)
+{
+	int ldo_offset = rdev->desc->id - BD718XX_LDO1;
+	int prot_bit = BD718XX_LDO1_VRMON80 << ldo_offset;
+	int ret;
+
+	ret = regmap_test_bits(rdev->regmap, BD718XX_REG_MVRFLTMASK2, prot_bit);
+	if (ret < 0)
+		return ret;
+
+	*state = REGULATOR_MONITOR_NONE;
+	if (ret)
+		*state = REGULATOR_MONITOR_UNDER_VOLTAGE;
+
+	return 0;
+}
+
 static int bd718x7_set_ldo_uvp(struct regulator_dev *rdev, int lim_uV,
 			       int severity, bool enable)
 {
@@ -519,6 +538,33 @@ static int bd718x7_get_buck_uvp_info(int id, int *reg, int *bit)
 	return 0;
 }
 
+static int bd717x7_get_buck_prot(struct regulator_dev *rdev, unsigned int *state)
+{
+	int ret, reg, bit;
+
+	ret = bd718x7_get_buck_uvp_info(rdev->desc->id, &reg, &bit);
+	if (ret)
+		return ret;
+	ret = regmap_test_bits(rdev->regmap, reg, bit);
+	if (ret < 0)
+		return ret;
+
+	*state = REGULATOR_MONITOR_NONE;
+	if (ret)
+		*state = REGULATOR_MONITOR_UNDER_VOLTAGE;
+
+	ret = bd718x7_get_buck_ovp_info(rdev->desc->id, &reg, &bit);
+	if (ret)
+		return ret;
+	ret = regmap_test_bits(rdev->regmap, reg, bit);
+	if (ret < 0)
+		return ret;
+	if (ret)
+		*state |= REGULATOR_MONITOR_OVER_VOLTAGE;
+
+	return 0;
+}
+
 static int bd718x7_set_buck_uvp(struct regulator_dev *rdev, int lim_uV,
 				int severity, bool enable)
 {
@@ -566,7 +612,7 @@ BD718XX_OPS(bd718xx_pickable_range_ldo_ops,
 	    regulator_list_voltage_pickable_linear_range, NULL,
 	    bd718xx_set_voltage_sel_pickable_restricted,
 	    regulator_get_voltage_sel_pickable_regmap, NULL, NULL,
-	    bd718x7_set_ldo_uvp, NULL);
+	    bd718x7_set_ldo_uvp, NULL, bd717x7_get_ldo_prot);
 
 /* BD71847 and BD71850 LDO 5 is by default OFF at RUN state */
 static const struct regulator_ops bd718xx_ldo5_ops_hwstate = {
@@ -582,27 +628,27 @@ BD718XX_OPS(bd718xx_pickable_range_buck_ops,
 	    regulator_set_voltage_sel_pickable_regmap,
 	    regulator_get_voltage_sel_pickable_regmap,
 	    regulator_set_voltage_time_sel, NULL, bd718x7_set_buck_uvp,
-	    bd718x7_set_buck_ovp);
+	    bd718x7_set_buck_ovp, bd717x7_get_buck_prot);
 
 BD718XX_OPS(bd718xx_ldo_regulator_ops, regulator_list_voltage_linear_range,
 	    NULL, bd718xx_set_voltage_sel_restricted,
 	    regulator_get_voltage_sel_regmap, NULL, NULL, bd718x7_set_ldo_uvp,
-	    NULL);
+	    NULL, bd717x7_get_ldo_prot);
 
 BD718XX_OPS(bd718xx_ldo_regulator_nolinear_ops, regulator_list_voltage_table,
 	    NULL, bd718xx_set_voltage_sel_restricted,
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
@@ -611,34 +657,34 @@ BD718XX_OPS(bd71837_pickable_range_ldo_ops,
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
@@ -662,7 +708,7 @@ BD718XX_OPS(bd718xx_dvs_buck_regulator_ops, regulator_list_voltage_linear_range,
 	    NULL, regulator_set_voltage_sel_regmap,
 	    regulator_get_voltage_sel_regmap, regulator_set_voltage_time_sel,
 	    regulator_set_ramp_delay_regmap, bd718x7_set_buck_uvp,
-	    bd718x7_set_buck_ovp);
+	    bd718x7_set_buck_ovp, bd717x7_get_buck_prot);
 
 
 

-- 
2.34.1


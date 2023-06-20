Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B2973759B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 22:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjFTUE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 16:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjFTUDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 16:03:51 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D43198D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 13:03:45 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51a4088c4ebso4989442a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 13:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687291424; x=1689883424;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BQq2EI+ihZlqaxk7IrwVNFA0MwmNy58J0VwFGEoGeNE=;
        b=K+T1H1faLVz700R5vRfbWeOgw0OrDQIbk/RneTGqceF/79oUhiRyTDJJv9TZRzGQx6
         Z23lRcrVUvxn0fwM8vxx3gt14jD4VJ9BU8Gch+mkyxzl5Pc3krW2i4SZ6YjJ3tncGf7E
         FsVkeNEbGiltGCh9x6hRKhJkZAOG4+jR3P2uQkbprmZQC1jzIJ//wOeQsJuQeyLbNEu7
         FkZsRNnLQw/pUuiQ1ktkjA0HXs7HNqmu7YPCrLRXPrIEfzd6DUqo12kF/blHSbvmTPFs
         caIwyi0fGuZBlrJlkj2zAJL5JF0ny07pVOL4S8PiLHtXAs9d/wYmuo/sLbEooTcLh3Ob
         utkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687291424; x=1689883424;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BQq2EI+ihZlqaxk7IrwVNFA0MwmNy58J0VwFGEoGeNE=;
        b=F+Z2fitSBdge6pp3QsAQtFtkHlrHXklMtKFoWig43v8gOj0U16dh4kW57z0H1A0Dyl
         cuzYyHQfZnIUXfj4DJz/fAYTIvBhL0JkZpSyxC0G20Y703Nf6Gb3X6ZeIgo8XdiezpZ+
         X0MF/qV4lxnPN6wHpB8iMZiPp7W57dwtZ6dCIkOQD66Qxrc5A1SRXu50CJ4Px25J/W2c
         kroJq1Dyqrq8KmDcybt2ueBOoZ1seNufMY1SV4qQbYHoEl/bS5OannGfVnd4fY7VjXHG
         GMvrLPcXmuHixdNfOLBNExJt2yNBka/z0VHHBp+idtbAfMJoHWPI+gCu5E4MnX/gikHp
         sddA==
X-Gm-Message-State: AC+VfDyeEIARzOcVEZ8bSxWpozqZt44rUmEg7fOTVyevZyaxsbysRRam
        DgzD8jUV9m0yJ7OzgGBdjRI=
X-Google-Smtp-Source: ACHHUZ7xii13Y1FDVmoLAPw0ZttIxWX4nTn0VmK7H6RI0EbsgMNqkZp80ZcD6i1eF+OE/w7OfXvLqQ==
X-Received: by 2002:a17:907:320a:b0:965:d18b:f03a with SMTP id xg10-20020a170907320a00b00965d18bf03amr12155993ejb.58.1687291423903;
        Tue, 20 Jun 2023 13:03:43 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id u21-20020a17090617d500b00977e0bcff1esm1947064eje.10.2023.06.20.13.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 13:03:43 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Tue, 20 Jun 2023 22:03:06 +0200
Subject: [PATCH RFC v4 13/13] regulator: bd718x7: let the core handle the
 monitors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230419-dynamic-vmon-v4-13-4d3734e62ada@skidata.com>
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

The monitors of the bd718x7 must be disabled while the respective
regulator is switching to a higher voltage. Use the new property
'.mon_disable_reg_set_higher' to activate the handling in the core.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 drivers/regulator/bd718x7-regulator.c | 136 +++-------------------------------
 1 file changed, 10 insertions(+), 126 deletions(-)

diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd718x7-regulator.c
index fbf609d219fc..251d098d088c 100644
--- a/drivers/regulator/bd718x7-regulator.c
+++ b/drivers/regulator/bd718x7-regulator.c
@@ -128,128 +128,6 @@ static int bd71837_get_buck34_enable_hwctrl(struct regulator_dev *rdev)
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
@@ -610,7 +488,7 @@ static int bd718x7_set_buck_ovp(struct regulator_dev *rdev, int lim_uV,
  */
 BD718XX_OPS(bd718xx_pickable_range_ldo_ops,
 	    regulator_list_voltage_pickable_linear_range, NULL,
-	    bd718xx_set_voltage_sel_pickable_restricted,
+	    regulator_set_voltage_sel_pickable_regmap,
 	    regulator_get_voltage_sel_pickable_regmap, NULL, NULL,
 	    bd718x7_set_ldo_uvp, NULL, bd717x7_get_ldo_prot);
 
@@ -618,7 +496,7 @@ BD718XX_OPS(bd718xx_pickable_range_ldo_ops,
 static const struct regulator_ops bd718xx_ldo5_ops_hwstate = {
 	.is_enabled = never_enabled_by_hwstate,
 	.list_voltage = regulator_list_voltage_pickable_linear_range,
-	.set_voltage_sel = bd718xx_set_voltage_sel_pickable_restricted,
+	.set_voltage_sel = regulator_set_voltage_sel_pickable_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_pickable_regmap,
 	.set_under_voltage_protection = bd718x7_set_ldo_uvp,
 };
@@ -631,12 +509,12 @@ BD718XX_OPS(bd718xx_pickable_range_buck_ops,
 	    bd718x7_set_buck_ovp, bd717x7_get_buck_prot);
 
 BD718XX_OPS(bd718xx_ldo_regulator_ops, regulator_list_voltage_linear_range,
-	    NULL, bd718xx_set_voltage_sel_restricted,
+	    NULL, regulator_set_voltage_sel_regmap,
 	    regulator_get_voltage_sel_regmap, NULL, NULL, bd718x7_set_ldo_uvp,
 	    NULL, bd717x7_get_ldo_prot);
 
 BD718XX_OPS(bd718xx_ldo_regulator_nolinear_ops, regulator_list_voltage_table,
-	    NULL, bd718xx_set_voltage_sel_restricted,
+	    NULL, regulator_set_voltage_sel_regmap,
 	    regulator_get_voltage_sel_regmap, NULL, NULL, bd718x7_set_ldo_uvp,
 	    NULL, bd717x7_get_ldo_prot);
 
@@ -1818,6 +1696,12 @@ static int bd718xx_probe(struct platform_device *pdev)
 		else
 			desc->ops = swops[i];
 
+		/*
+		 * bd718x7 requires to disable a regulator's over voltage
+		 * protection while it changes to a higher value.
+		 */
+		desc->mon_disable_reg_set_higher = REGULATOR_MONITOR_OVER_VOLTAGE;
+
 		rdev = devm_regulator_register(&pdev->dev, desc, &config);
 		if (IS_ERR(rdev))
 			return dev_err_probe(&pdev->dev, PTR_ERR(rdev),

-- 
2.34.1


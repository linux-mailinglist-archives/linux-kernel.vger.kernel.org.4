Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DC26D73BE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 07:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236770AbjDEF34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 01:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236783AbjDEF3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 01:29:44 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955633C0A;
        Tue,  4 Apr 2023 22:29:42 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id jl13so25442174qvb.10;
        Tue, 04 Apr 2023 22:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680672581;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o3j0ICdxrgqagqpxM5hIynvfE81ol0hE9ZLLVnUG70o=;
        b=UhBh8bYVurmNcHtWm4aPnF0qF7672uaGDtnamCJM64N7ZRPQ83q7VeRkUzKYu3f+jX
         M/xFhz07w9flF2m/f1VPNK4ST2CgDXnMbvUpLswylaVcX8ZElqtdd0Zw4T3t+2OfJk+A
         IpO7HvMv5Mp6lzEpnnBf87QF2XMmeCCknHZrJ6rJOG63vgzj214g57d8xUdSEzxKe62+
         uOXdmZ/tlt/fOybmqvcl+GhDZiGj443vQF/kcX1wkSAWDK0ExWsSeKf5ySiXlsPhFyr6
         OVXy88c8ND14iqHNxrkc5Y1/3leZkPqlvhPeCb3JyaeFWAQZnRckwQ13rFGzOQWKpZsn
         m13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680672581;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o3j0ICdxrgqagqpxM5hIynvfE81ol0hE9ZLLVnUG70o=;
        b=FFx0lzreLt1HE8wKWMzUR2QRDzUIngJ0yqOkh63PmDx6vwmoBAZxWIj1QkHJJosyx7
         nmXlk5JiBLFk0Rqei1wDY81KT7O/oNN2mKtqsyM4llQYS8woyvKMsQmNNUAkJSHeNs/i
         4wl/i74HqUF9gS1mBO64IU3HYpMSBUyROAPlhyKo/ZCwOEGxeP9gXEyWAxCJYTtrRkqV
         HbL2ZgAhstxex8BXfsWgfGbp1paEQuQ6A9oxBmtp41pqhAxjlKYSc10jef78srd92uqV
         GIkxuFUj88Rr5ITZJcXQVfwTzpnYOjSW724IT29slCi3aGkFFUIOZQKfO0Yr1xEkC79w
         HxNg==
X-Gm-Message-State: AAQBX9f8W0NLUwYoYEVOm7fI/YhumHroMZTet/c0NzHtMeZlgWzbP/RV
        H4M3a/H1qcpTOc4kHxSDltY=
X-Google-Smtp-Source: AKy350Zku7tzQWnNY/rr3sXkRRM+tzPU3bWban/VrvIkgUk9e/1N5z+GdvCYttNV6RiWIBo9iDIK5A==
X-Received: by 2002:a05:6214:21ee:b0:5c3:2dfc:af5d with SMTP id p14-20020a05621421ee00b005c32dfcaf5dmr6807507qvj.43.1680672581713;
        Tue, 04 Apr 2023 22:29:41 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id f12-20020ad4558c000000b005e16003edc9sm3881454qvx.104.2023.04.04.22.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 22:29:41 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Wed, 05 Apr 2023 07:29:08 +0200
Subject: [PATCH v2 2/3] regulator: da9063: implement basic XVP setter
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230403-da9063-disable-unused-v2-2-2f1bd2a2434a@skidata.com>
References: <20230403-da9063-disable-unused-v2-0-2f1bd2a2434a@skidata.com>
In-Reply-To: <20230403-da9063-disable-unused-v2-0-2f1bd2a2434a@skidata.com>
To:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>
Cc:     DLG-Adam.Thomson.Opensource@dm.renesas.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Benjamin Bara <benjamin.bara@skidata.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Bara <benjamin.bara@skidata.com>

Allow to en- and disable voltage monitoring from the device tree.
Consider that the da9063 only monitors UV *and* OV together, so both
must be en- or disabled.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 drivers/regulator/da9063-regulator.c | 100 +++++++++++++++++++++++++----------
 1 file changed, 72 insertions(+), 28 deletions(-)

diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index 1c720fc595b3..000fa0daef18 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -207,6 +207,24 @@ static const unsigned int da9063_bmem_bio_merged_limits[] = {
 	4600000, 4800000, 5000000, 5200000, 5400000, 5600000, 5800000, 6000000
 };
 
+static int da9063_set_xvp(struct regulator_dev *rdev, int lim_uV, int severity, bool enable)
+{
+	struct da9063_regulator *regl = rdev_get_drvdata(rdev);
+	struct device *dev = regl->hw->dev;
+
+	dev_dbg(dev, "%s: lim: %d, sev: %d, en: %d\n", regl->desc.name, lim_uV, severity, enable);
+
+	/*
+	 * only support enable and disable.
+	 * the da9063 offers a GPIO (GP_FB2) which is unasserted if an XV happens.
+	 * therefore ignore severity here, as there might be handlers in hardware.
+	 */
+	if (lim_uV)
+		return -EINVAL;
+
+	return regmap_field_write(regl->vmon, enable ? 1 : 0);
+}
+
 static int da9063_buck_set_mode(struct regulator_dev *rdev, unsigned int mode)
 {
 	struct da9063_regulator *regl = rdev_get_drvdata(rdev);
@@ -545,37 +563,41 @@ static int da9063_buck_get_current_limit(struct regulator_dev *rdev)
 }
 
 static const struct regulator_ops da9063_buck_ops = {
-	.enable			= regulator_enable_regmap,
-	.disable		= regulator_disable_regmap,
-	.is_enabled		= regulator_is_enabled_regmap,
-	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
-	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
-	.list_voltage		= regulator_list_voltage_linear,
-	.set_current_limit	= da9063_buck_set_current_limit,
-	.get_current_limit	= da9063_buck_get_current_limit,
-	.set_mode		= da9063_buck_set_mode,
-	.get_mode		= da9063_buck_get_mode,
-	.get_status		= da9063_buck_get_status,
-	.set_suspend_voltage	= da9063_set_suspend_voltage,
-	.set_suspend_enable	= da9063_suspend_enable,
-	.set_suspend_disable	= da9063_suspend_disable,
-	.set_suspend_mode	= da9063_buck_set_suspend_mode,
+	.enable				= regulator_enable_regmap,
+	.disable			= regulator_disable_regmap,
+	.is_enabled			= regulator_is_enabled_regmap,
+	.get_voltage_sel		= regulator_get_voltage_sel_regmap,
+	.set_voltage_sel		= regulator_set_voltage_sel_regmap,
+	.list_voltage			= regulator_list_voltage_linear,
+	.set_current_limit		= da9063_buck_set_current_limit,
+	.get_current_limit		= da9063_buck_get_current_limit,
+	.set_mode			= da9063_buck_set_mode,
+	.get_mode			= da9063_buck_get_mode,
+	.get_status			= da9063_buck_get_status,
+	.set_suspend_voltage		= da9063_set_suspend_voltage,
+	.set_suspend_enable		= da9063_suspend_enable,
+	.set_suspend_disable		= da9063_suspend_disable,
+	.set_suspend_mode		= da9063_buck_set_suspend_mode,
+	.set_over_voltage_protection	= da9063_set_xvp,
+	.set_under_voltage_protection	= da9063_set_xvp,
 };
 
 static const struct regulator_ops da9063_ldo_ops = {
-	.enable			= regulator_enable_regmap,
-	.disable		= regulator_disable_regmap,
-	.is_enabled		= regulator_is_enabled_regmap,
-	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
-	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
-	.list_voltage		= regulator_list_voltage_linear,
-	.set_mode		= da9063_ldo_set_mode,
-	.get_mode		= da9063_ldo_get_mode,
-	.get_status		= da9063_ldo_get_status,
-	.set_suspend_voltage	= da9063_set_suspend_voltage,
-	.set_suspend_enable	= da9063_suspend_enable,
-	.set_suspend_disable	= da9063_suspend_disable,
-	.set_suspend_mode	= da9063_ldo_set_suspend_mode,
+	.enable				= regulator_enable_regmap,
+	.disable			= regulator_disable_regmap,
+	.is_enabled			= regulator_is_enabled_regmap,
+	.get_voltage_sel		= regulator_get_voltage_sel_regmap,
+	.set_voltage_sel		= regulator_set_voltage_sel_regmap,
+	.list_voltage			= regulator_list_voltage_linear,
+	.set_mode			= da9063_ldo_set_mode,
+	.get_mode			= da9063_ldo_get_mode,
+	.get_status			= da9063_ldo_get_status,
+	.set_suspend_voltage		= da9063_set_suspend_voltage,
+	.set_suspend_enable		= da9063_suspend_enable,
+	.set_suspend_disable		= da9063_suspend_disable,
+	.set_suspend_mode		= da9063_ldo_set_suspend_mode,
+	.set_over_voltage_protection	= da9063_set_xvp,
+	.set_under_voltage_protection	= da9063_set_xvp,
 };
 
 /* Info of regulators for DA9063 */
@@ -749,6 +771,23 @@ static const struct regulator_init_data *da9063_get_regulator_initdata(
 	return NULL;
 }
 
+static int da9063_check_xvp_constraints(struct regulator_config *config)
+{
+	struct da9063_regulator *regl = config->driver_data;
+	const struct regulation_constraints *constr = &config->init_data->constraints;
+	const struct notification_limit *uv_l = &constr->under_voltage_limits;
+	const struct notification_limit *ov_l = &constr->over_voltage_limits;
+
+	/* make sure that both UV/OV protections are either enabled or disabled */
+	if (uv_l->prot != ov_l->prot || uv_l->err != ov_l->err || uv_l->warn != ov_l->warn) {
+		dev_err(config->dev, "%s: regulator-uv-X-microvolt != regulator-ov-X-microvolt\n",
+			regl->desc.name);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static struct of_regulator_match da9063_matches[] = {
 	[DA9063_ID_BCORE1]           = { .name = "bcore1"           },
 	[DA9063_ID_BCORE2]           = { .name = "bcore2"           },
@@ -970,6 +1009,11 @@ static int da9063_regulator_probe(struct platform_device *pdev)
 		if (da9063_reg_matches)
 			config.of_node = da9063_reg_matches[id].of_node;
 		config.regmap = da9063->regmap;
+
+		ret = da9063_check_xvp_constraints(&config);
+		if (ret)
+			return ret;
+
 		regl->rdev = devm_regulator_register(&pdev->dev, &regl->desc,
 						     &config);
 		if (IS_ERR(regl->rdev)) {

-- 
2.34.1


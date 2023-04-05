Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4286D84B4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 19:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbjDERPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 13:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbjDERPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 13:15:08 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BED5B81;
        Wed,  5 Apr 2023 10:15:06 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id ev7so7622773qvb.5;
        Wed, 05 Apr 2023 10:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680714906;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t1MNaffuvyVWLXyLQ6lRNzfTJfcAUGjlFHNhQFdXp8E=;
        b=necvQ0RUkjIYKGcUKjnlMsbAs/R7KTYbS1sbZjsMBWTmc3Cdfs9FdRAJJSpnS0SR1Q
         uXlN/daZrSLE77aAF9x4bRtegwHo7n0Gs5fzxuXzk6Gs7cn8SNLI4z6HLXXaGGgCXL+S
         n8gyLeyOqitneWHgm7Qlk7GnGcEJnL2JpcJAHqkHu0kbrM6D/mGGgnfF3Zj89t0BWw0S
         KCs172JHRuSg5zv68dt9Yo1a8ZqK4SdLH3HAy6wGej64TIzWZw9JeV5KH+rJ92QbKLWB
         E+1ixS8JWRtJpIPK+tJ1TdJECMXpq6UYYmKIidPzD4yNWM56UFwuB6LLRLreWAgdlh7r
         EW4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680714906;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t1MNaffuvyVWLXyLQ6lRNzfTJfcAUGjlFHNhQFdXp8E=;
        b=OmvncK3lbHAycK1xQyi169byNWie7zXa4sH2iA2PQFPLuh2ZZ04rksqiVmqEtdFSvL
         A8Cfg4MuNCOCsYbmwsfXuF2WhRJuKXDYOwzxp2uw2AIpuC4r18bp0vJKPn/rjBbqT4S4
         gqcQBw78J4J0bznt2bwuBKQAHzH373CB0XWEGSS6EZYo7ePI5c5RPUQm2cqBYwZ0pXGP
         yEZEKxaOZ0s74S+vTmljNm8Vq8aIBnnpr3UA+UhzrirxRW7Rgs+YlapspTaE9szhqCOO
         s6okKm3+U/nLcZgFk/hoNLcmile+Ua4qYBtCp+Vd0Pj/q16xzOuCuqOUvV4Lci83EsCm
         zwjw==
X-Gm-Message-State: AAQBX9fwgt0tTWfbOj1J1LhuuRjf2I2hcOok737fSMQmTylfZZYVv4Jz
        J/xB0ahvhzPWXlmYzqGF0WQ=
X-Google-Smtp-Source: AKy350YlHpc02j134uiYYqVZUGxmMtILdAdYv/lYdSIAkwIo9ggXiUZm2l2czpnCD8hN/0JpkZd/rA==
X-Received: by 2002:a05:6214:2401:b0:5db:4e49:b2bd with SMTP id fv1-20020a056214240100b005db4e49b2bdmr6544289qvb.18.1680714905746;
        Wed, 05 Apr 2023 10:15:05 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id ct9-20020a056214178900b005dd8b934571sm4403209qvb.9.2023.04.05.10.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 10:15:05 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Wed, 05 Apr 2023 19:14:35 +0200
Subject: [PATCH v3 2/3] regulator: da9063: implement setter for voltage
 monitoring
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230403-da9063-disable-unused-v3-2-cc4dc698864c@skidata.com>
References: <20230403-da9063-disable-unused-v3-0-cc4dc698864c@skidata.com>
In-Reply-To: <20230403-da9063-disable-unused-v3-0-cc4dc698864c@skidata.com>
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
Consider that the da9063 only monitors under- *and* over-voltage
together, so both must be set to the same severity and value.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 drivers/regulator/da9063-regulator.c | 118 ++++++++++++++++++++++++++---------
 1 file changed, 90 insertions(+), 28 deletions(-)

diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index 1c720fc595b3..6f1d77e486fc 100644
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
@@ -749,6 +771,41 @@ static const struct regulator_init_data *da9063_get_regulator_initdata(
 	return NULL;
 }
 
+static int da9063_check_xvp_constraints(struct regulator_config *config)
+{
+	struct da9063_regulator *regl = config->driver_data;
+	const struct regulation_constraints *constr = &config->init_data->constraints;
+	const struct notification_limit *uv_l = &constr->under_voltage_limits;
+	const struct notification_limit *ov_l = &constr->over_voltage_limits;
+
+	/* make sure that only one severity is used to clarify if unchanged, enabled or disabled */
+	if ((!!uv_l->prot + !!uv_l->err + !!uv_l->warn) > 1) {
+		dev_err(config->dev, "%s: at most one voltage monitoring severity allowed!\n",
+			regl->desc.name);
+		return -EINVAL;
+	}
+
+	/* make sure that UV and OV monitoring is set to the same severity and value */
+	if (uv_l->prot != ov_l->prot) {
+		dev_err(config->dev,
+			"%s: protection-microvolt: value must be equal for uv and ov!\n",
+			regl->desc.name);
+		return -EINVAL;
+	}
+	if (uv_l->err != ov_l->err) {
+		dev_err(config->dev, "%s: error-microvolt: value must be equal for uv and ov!\n",
+			regl->desc.name);
+		return -EINVAL;
+	}
+	if (uv_l->warn != ov_l->warn) {
+		dev_err(config->dev, "%s: warn-microvolt: value must be equal for uv and ov!\n",
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
@@ -970,6 +1027,11 @@ static int da9063_regulator_probe(struct platform_device *pdev)
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


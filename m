Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FEB742E87
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 22:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbjF2UgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 16:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjF2Ufy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 16:35:54 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCBA30C4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 13:35:53 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b6985de215so18601541fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 13:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688070951; x=1690662951;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=78qKnLJsNPm4roROV2WGW5c+8kMl5RLkTh9XlFlH21k=;
        b=JXSKL36QI/i4HBF+i46JoZgRfI6BsQeag+0MxuQJ7IIqIOtcWKatyxQ4Jj03Bh6JDj
         CFDq0PbbadZJ6VTfwShXyPKuV/mOtR+P61gCj2Y3dmxlpq/T0ZtS9dZ+tu4kliUuIMNY
         VEdBKGZOGTN8FjyLpIzOWNRuSf+eUgZtpw4CXf00DaiOX8Ch758ReQ2IqfunN0LP1apz
         Vi8tuy5dTiyAnZTXPMCwtDLGMDws+Zk79RQAVCjmxQHWdlj7A9hsD6sifKYPo0ia6tiq
         qD6ENKAYCuCc8bgQtCuFD7mEoa0jZn5xbciCyQx2okYJUqtvMzkkWCnofg4JilZvaS/q
         30fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688070951; x=1690662951;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=78qKnLJsNPm4roROV2WGW5c+8kMl5RLkTh9XlFlH21k=;
        b=ChKoAeBxXQtpkt+jjfAw7bK1EYI+h9SOHqXQa2yKP55GtwuvhgxRdB469yAXUn6Zky
         U4MIjpW/xEacr2IZNczdc+0e1lXe0BTpHp73H4U05KpYUPYKnzCSadwy1X0z/i6ipG5G
         Z7KfmLn0s/fnULNjRU4ILEW6uWGxluR1nE8hKMhukhbXicask+mZC/d6wzJ5TQaXc1sL
         +TZ3Zz3cdDTiEKFLXGDTeNTEW1NWBC7eU5rZyrKAqXdiIdEEBig5yuUsEfik44ndnxur
         Dwof3WJ8x2i/muwEj3LFL1khURwwr+KUBv1L34YKu7R2dQL2PBIIl6ARM2lBFkroB/GP
         TsNw==
X-Gm-Message-State: ABy/qLal6yGub9xnPZ4aHh5wTZ8EDKuX7YqTFiad52emOShFe0bmcm6e
        wqtwfidY7DxV08JzWROZyR39PA==
X-Google-Smtp-Source: APBJJlFM0juoyUzQ5L/49Qy4p2wR8zFOgm+SGptzGSK2OKhFo8X4aBmwIeRWSeWC4e3CUD6dZ/P+lA==
X-Received: by 2002:a2e:8215:0:b0:2b6:cf64:7a8e with SMTP id w21-20020a2e8215000000b002b6cf647a8emr290113ljg.19.1688070951582;
        Thu, 29 Jun 2023 13:35:51 -0700 (PDT)
Received: from [192.168.1.101] (abyk82.neoplus.adsl.tpnet.pl. [83.9.30.82])
        by smtp.gmail.com with ESMTPSA id k3-20020a2e2403000000b002b6b849c894sm1136008ljk.111.2023.06.29.13.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 13:35:51 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 29 Jun 2023 22:35:42 +0200
Subject: [PATCH v2 2/4] regulator: Introduce Qualcomm REFGEN regulator
 driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230628-topic-refgen-v2-2-6136487c78c5@linaro.org>
References: <20230628-topic-refgen-v2-0-6136487c78c5@linaro.org>
In-Reply-To: <20230628-topic-refgen-v2-0-6136487c78c5@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1688070946; l=6725;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=9J+G1r4h/EMnhrwYXmB1C+J6Eslvg/Etw+wK9dwKeMQ=;
 b=luzseCDHJnUJW71XyhNDp+tGF6TUrtrtFpoYlc1+41Xmjwzz5MqqByqSYOl3JomQKIzXtbwdX
 zx2dIqR9O67A+s8fIQJRINb+zToRC5+wE+DXPPHQkcNqlXA+MOAP900
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modern Qualcomm SoCs have a REFGEN (reference voltage generator)
regulator, providing reference voltage to on-chip IP, like PHYs.

Add a driver to support toggling that regulator.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/regulator/Kconfig                 |  10 ++
 drivers/regulator/Makefile                |   1 +
 drivers/regulator/qcom-refgen-regulator.c | 154 ++++++++++++++++++++++++++++++
 3 files changed, 165 insertions(+)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 2c2405024ace..ea5549d62825 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -978,6 +978,16 @@ config REGULATOR_PWM
 	  This driver supports PWM controlled voltage regulators. PWM
 	  duty cycle can increase or decrease the voltage.
 
+config REGULATOR_QCOM_REFGEN
+	tristate "Qualcomm REFGEN regulator driver"
+	depends on REGMAP
+	help
+	  This driver supports the MMIO-mapped reference voltage regulator,
+	  used internally by some PHYs on many Qualcomm SoCs.
+
+	  Say M here if you want to include support for this regulator as
+	  a module. The module will be named "qcom-refgen-regulator".
+
 config REGULATOR_QCOM_RPM
 	tristate "Qualcomm RPM regulator driver"
 	depends on MFD_QCOM_RPM
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index ebfa75379c20..a044ad20e202 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -107,6 +107,7 @@ obj-$(CONFIG_REGULATOR_MT6380)	+= mt6380-regulator.o
 obj-$(CONFIG_REGULATOR_MT6397)	+= mt6397-regulator.o
 obj-$(CONFIG_REGULATOR_MTK_DVFSRC) += mtk-dvfsrc-regulator.o
 obj-$(CONFIG_REGULATOR_QCOM_LABIBB) += qcom-labibb-regulator.o
+obj-$(CONFIG_REGULATOR_QCOM_REFGEN) += qcom-refgen-regulator.o
 obj-$(CONFIG_REGULATOR_QCOM_RPM) += qcom_rpm-regulator.o
 obj-$(CONFIG_REGULATOR_QCOM_RPMH) += qcom-rpmh-regulator.o
 obj-$(CONFIG_REGULATOR_QCOM_SMD_RPM) += qcom_smd-regulator.o
diff --git a/drivers/regulator/qcom-refgen-regulator.c b/drivers/regulator/qcom-refgen-regulator.c
new file mode 100644
index 000000000000..4c442fa3f552
--- /dev/null
+++ b/drivers/regulator/qcom-refgen-regulator.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) 2017, 2019-2020, The Linux Foundation. All rights reserved.
+// Copyright (c) 2023, Linaro Limited
+
+#include <linux/bitfield.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>
+
+#define REFGEN_REG_BIAS_EN		0x08
+#define REFGEN_BIAS_EN_MASK		GENMASK(2, 0)
+ #define REFGEN_BIAS_EN_ENABLE		0x7
+ #define REFGEN_BIAS_EN_DISABLE		0x6
+
+#define REFGEN_REG_BG_CTRL		0x14
+#define REFGEN_BG_CTRL_MASK		GENMASK(2, 1)
+ #define REFGEN_BG_CTRL_ENABLE		0x3
+ #define REFGEN_BG_CTRL_DISABLE		0x2
+
+#define REFGEN_REG_PWRDWN_CTRL5		0x80
+#define REFGEN_PWRDWN_CTRL5_MASK	BIT(0)
+ #define REFGEN_PWRDWN_CTRL5_ENABLE	0x1
+
+static int qcom_sdm845_refgen_enable(struct regulator_dev *rdev)
+{
+	regmap_update_bits(rdev->regmap, REFGEN_REG_BG_CTRL, REFGEN_BG_CTRL_MASK,
+			   FIELD_PREP(REFGEN_BG_CTRL_MASK, REFGEN_BG_CTRL_ENABLE));
+
+	regmap_write(rdev->regmap, REFGEN_REG_BIAS_EN,
+		     FIELD_PREP(REFGEN_BIAS_EN_MASK, REFGEN_BIAS_EN_ENABLE));
+
+	return 0;
+}
+
+static int qcom_sdm845_refgen_disable(struct regulator_dev *rdev)
+{
+	regmap_write(rdev->regmap, REFGEN_REG_BIAS_EN,
+		     FIELD_PREP(REFGEN_BIAS_EN_MASK, REFGEN_BIAS_EN_DISABLE));
+
+	regmap_update_bits(rdev->regmap, REFGEN_REG_BG_CTRL, REFGEN_BG_CTRL_MASK,
+			   FIELD_PREP(REFGEN_BG_CTRL_MASK, REFGEN_BG_CTRL_DISABLE));
+
+	return 0;
+}
+
+static int qcom_sdm845_refgen_is_enabled(struct regulator_dev *rdev)
+{
+	u32 val;
+
+	regmap_read(rdev->regmap, REFGEN_REG_BG_CTRL, &val);
+	if (FIELD_GET(REFGEN_BG_CTRL_MASK, val) != REFGEN_BG_CTRL_ENABLE)
+		return 0;
+
+	regmap_read(rdev->regmap, REFGEN_REG_BIAS_EN, &val);
+	if (FIELD_GET(REFGEN_BIAS_EN_MASK, val) != REFGEN_BIAS_EN_ENABLE)
+		return 0;
+
+	return 1;
+}
+
+static struct regulator_desc sdm845_refgen_desc = {
+	.enable_time = 5,
+	.name = "refgen",
+	.owner = THIS_MODULE,
+	.type = REGULATOR_VOLTAGE,
+	.ops = &(struct regulator_ops) {
+		.enable		= qcom_sdm845_refgen_enable,
+		.disable	= qcom_sdm845_refgen_disable,
+		.is_enabled	= qcom_sdm845_refgen_is_enabled,
+	},
+};
+
+static struct regulator_desc sm8250_refgen_desc = {
+	.enable_reg = REFGEN_REG_PWRDWN_CTRL5,
+	.enable_mask = REFGEN_PWRDWN_CTRL5_MASK,
+	.enable_val = REFGEN_PWRDWN_CTRL5_ENABLE,
+	.disable_val = 0,
+	.enable_time = 5,
+	.name = "refgen",
+	.owner = THIS_MODULE,
+	.type = REGULATOR_VOLTAGE,
+	.ops = &(struct regulator_ops) {
+		.enable		= regulator_enable_regmap,
+		.disable	= regulator_disable_regmap,
+		.is_enabled	= regulator_is_enabled_regmap,
+	},
+};
+
+static const struct regmap_config qcom_refgen_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.fast_io = true,
+};
+
+static int qcom_refgen_probe(struct platform_device *pdev)
+{
+	struct regulator_init_data *init_data;
+	struct regulator_config config = {};
+	const struct regulator_desc *rdesc;
+	struct device *dev = &pdev->dev;
+	struct regulator_dev *rdev;
+	struct regmap *regmap;
+	void __iomem *base;
+
+	rdesc = of_device_get_match_data(dev);
+	if (!rdesc)
+		return -ENODATA;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	regmap = devm_regmap_init_mmio(dev, base, &qcom_refgen_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	init_data = of_get_regulator_init_data(dev, dev->of_node, rdesc);
+	if (!init_data)
+		return -ENOMEM;
+
+	config.dev = dev;
+	config.init_data = init_data;
+	config.of_node = dev->of_node;
+	config.regmap = regmap;
+
+	rdev = devm_regulator_register(dev, rdesc, &config);
+	if (IS_ERR(rdev))
+		return PTR_ERR(rdev);
+
+	return 0;
+}
+
+static const struct of_device_id qcom_refgen_match_table[] = {
+	{ .compatible = "qcom,sdm845-refgen-regulator", .data = &sdm845_refgen_desc },
+	{ .compatible = "qcom,sm8250-refgen-regulator", .data = &sm8250_refgen_desc },
+	{ }
+};
+
+static struct platform_driver qcom_refgen_driver = {
+	.probe = qcom_refgen_probe,
+	.driver = {
+		.name = "qcom-refgen-regulator",
+		.of_match_table = qcom_refgen_match_table,
+	},
+};
+module_platform_driver(qcom_refgen_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Qualcomm REFGEN regulator driver");

-- 
2.41.0


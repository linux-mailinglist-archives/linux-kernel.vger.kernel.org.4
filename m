Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39FB671E81
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 14:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjARNwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 08:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjARNvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:51:52 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40B62BF09
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 05:23:04 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id qx13so24813642ejb.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 05:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BMW+GSgIGk9zwaJfSGSRXu37YBef4YGDH39JKBNKrJA=;
        b=BR9/wQvQyD873TEdwHBWb/d7e84iUtIhWTXO+AcfqUfNDq+xcdNnenQQBwaJQmBYJ5
         9IdK2KAnUxTgSFPOdNxjmcz4MjqfRfbjTGwbJxdq3moVaZtUC3oSJJy2W7pSVX7WnciB
         SeAXUl8uWqO8OjUHgrvI0Wm1P/xSMpcnXDWr0VxEdazP3CZtjLfI+Ja5zTYvvOVlVYPD
         rIMEp+TyOsWoYzqare5tOL1vfrSiIkJx493DdsRzXmGUAaR69su2G5e4LMhY6GQ1BHVa
         ZpUr+VHsg7Crhxr1+FhOKoHNy2s8pc734ctfXIMBdj8b1f3sw2fMekloz3QOPXDKRlgn
         6P6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BMW+GSgIGk9zwaJfSGSRXu37YBef4YGDH39JKBNKrJA=;
        b=2VNwVRt0o88/KiRH9o6oEMunMtcWUzFo11Q6MOrH5yoenChmUm75DlMTFW7ogSx5Q6
         OsGreuOuxfSHcCVFmzzcpDEVnFZVYw5aDvZP4sBzpCNK186er/FxkdvpRm+EOD7OGNio
         K99J5AOTMfvkiut/s7wnGm4FMPp2P+PmA4ZCK3iTxNSO4iXZIY4efGds1DXxD73p2o0Q
         R1nwC5wrMfkoFysanY+sz+dZEOmb4toNbCcwboo1LUP25rYH3A0ChEZEe2Z9/MeS+ubA
         /VqIm543ynbVZa80xnaiE9AckGGl230c3RP1RjZVW5n3QD8i2B8o7SEmcC6nbHuj0lDe
         VAUA==
X-Gm-Message-State: AFqh2koVSTeOtEZq8SFnPwV1fcvQcZk+pkW/n718n8ZkVtxdCADdWXw3
        9g2e3GItfrYkt8/nYcz0TtbKZA==
X-Google-Smtp-Source: AMrXdXtfGBqlMl3u8iNOzJDJiTWqQYdjjM5w8+BpTV8ufP8g9OPTLEAwBq9M/5+/li4UavLk4CSi/w==
X-Received: by 2002:a17:906:4b4c:b0:871:e336:cd2a with SMTP id j12-20020a1709064b4c00b00871e336cd2amr6750774ejv.47.1674048184304;
        Wed, 18 Jan 2023 05:23:04 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id u2-20020a1709061da200b0083f91a32131sm14633831ejh.0.2023.01.18.05.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 05:23:04 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 7/7] clk: qcom: add the driver for the MSM8996 APCS clocks
Date:   Wed, 18 Jan 2023 15:22:54 +0200
Message-Id: <20230118132254.2356209-8-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230118132254.2356209-1-dmitry.baryshkov@linaro.org>
References: <20230118132254.2356209-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a simple driver handling the APCS clocks on MSM8996. For now it
supports just a single aux clock, linking GPLL0 to CPU and CBF clocks.

Note, there is little sense in registering sys_apcs_aux as a child of
gpll0. The PLL is always-on. And listing the gpll0 as a property of the
apcs would delay its probing until the GCC has been probed (while we
would like for the apcs to be probed as early as possible).

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/clk/qcom/Makefile       |  2 +-
 drivers/clk/qcom/apcs-msm8996.c | 76 +++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/qcom/apcs-msm8996.c

diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 6c589f671003..98523c48c541 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -52,7 +52,7 @@ obj-$(CONFIG_MSM_MMCC_8998) += mmcc-msm8998.o
 obj-$(CONFIG_QCOM_A53PLL) += a53-pll.o
 obj-$(CONFIG_QCOM_A7PLL) += a7-pll.o
 obj-$(CONFIG_QCOM_CLK_APCS_MSM8916) += apcs-msm8916.o
-obj-$(CONFIG_QCOM_CLK_APCC_MSM8996) += clk-cpu-8996.o
+obj-$(CONFIG_QCOM_CLK_APCC_MSM8996) += apcs-msm8996.o clk-cpu-8996.o
 obj-$(CONFIG_QCOM_CLK_APCS_SDX55) += apcs-sdx55.o
 obj-$(CONFIG_QCOM_CLK_RPM) += clk-rpm.o
 obj-$(CONFIG_QCOM_CLK_RPMH) += clk-rpmh.o
diff --git a/drivers/clk/qcom/apcs-msm8996.c b/drivers/clk/qcom/apcs-msm8996.c
new file mode 100644
index 000000000000..7e46ea8ed444
--- /dev/null
+++ b/drivers/clk/qcom/apcs-msm8996.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Qualcomm APCS clock controller driver
+ *
+ * Copyright (c) 2022, Linaro Limited
+ * Author: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
+ */
+
+#include <linux/bits.h>
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define APCS_AUX_OFFSET	0x50
+
+#define APCS_AUX_DIV_MASK GENMASK(17, 16)
+#define APCS_AUX_DIV_2 0x1
+
+static int qcom_apcs_msm8996_clk_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device *parent = dev->parent;
+	struct regmap *regmap;
+	struct clk_hw *hw;
+	unsigned int val;
+	int ret = -ENODEV;
+
+	regmap = dev_get_regmap(parent, NULL);
+	if (!regmap) {
+		dev_err(dev, "failed to get regmap: %d\n", ret);
+		return ret;
+	}
+
+	regmap_read(regmap, APCS_AUX_OFFSET, &val);
+	regmap_update_bits(regmap, APCS_AUX_OFFSET, APCS_AUX_DIV_MASK,
+			   FIELD_PREP(APCS_AUX_DIV_MASK, APCS_AUX_DIV_2));
+
+	/* Hardware mandated delay */
+	udelay(5);
+
+	/*
+	 * Register the clock as fixed rate instead of being a child of gpll0
+	 * to let the driver register probe as early as possible.
+	 */
+	hw = devm_clk_hw_register_fixed_rate(dev, "sys_apcs_aux", NULL, 0, 300000000);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, hw);
+}
+
+static struct platform_driver qcom_apcs_msm8996_clk_driver = {
+	.probe = qcom_apcs_msm8996_clk_probe,
+	.driver = {
+		.name = "qcom-apcs-msm8996-clk",
+	},
+};
+
+/* Register early enough to fix the clock to be used for other cores */
+static int __init qcom_apcs_msm8996_clk_init(void)
+{
+	return platform_driver_register(&qcom_apcs_msm8996_clk_driver);
+}
+postcore_initcall(qcom_apcs_msm8996_clk_init);
+
+static void __exit qcom_apcs_msm8996_clk_exit(void)
+{
+	platform_driver_unregister(&qcom_apcs_msm8996_clk_driver);
+}
+module_exit(qcom_apcs_msm8996_clk_exit);
+
+MODULE_AUTHOR("Dmitry Baryshkov <dmitry.baryshkov@linaro.org>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Qualcomm MSM8996 APCS clock driver");
-- 
2.39.0


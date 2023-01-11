Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C69666361
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 20:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234950AbjAKTP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 14:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238603AbjAKTPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 14:15:07 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B01F3E0CE
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:14:59 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id y18so13503113ljk.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/UXtctDmgy3FdaxNyTJINCTK6qOQw5kYpO166rCggWQ=;
        b=qym5ytsZN3GQaBori/kOTx2Aep16/qNYc2VJvNqD8DFQ9VjVpng6JnQxWBpQm7DSh/
         v0iXSSbNM5PMxGMoWAFJVILD/V+E8mOSrHeBW/SXXV9ztayAlnlvlq+DHqogQbhmBjef
         16wTpZOxKLnCegLhMEWh2L7Wb77NUteeeeDYcMSVPvlrrAeW4SE9SKDcMPmabe+Gy9XB
         k91n7kOT8N38u4/6vSfPE+xCIPeW+t3Jj9DDYDfGE0hgvvoZsov0ZaJ8lr/yx5m1ZiAd
         iJiYRmmbYECRPJXMHN09rSYdaL4XyqYZsCUq8aMzuT1xh5ukpJ3N1eSTT5J7S62xYY97
         Df4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/UXtctDmgy3FdaxNyTJINCTK6qOQw5kYpO166rCggWQ=;
        b=KGAfmyGMoFXhJKGF48YrLtUlHPy1K0JwvjvebQfNP1nfstJ4didFIIMBZWUrhFSDGJ
         zrg8S2/BfWbhn9XoZeg8Lr2ZS4TqPeTQrBXAPpb9C/EqtfZXEJm9iRKeynCTDJU7VVpc
         AuBuUQHbYkiIbLhYPCc1vbLkSUXq+EfBcNAXTTmbz/TFZMYIr5375DfMTCjTRr1FDH4r
         cIYxQFHylMBbQByDKdTKTYCZK1q91bGkp9LTfTK7Mu2w9TPvjgYchNf2Z7gqIMDUDw6H
         9uw4dSJCdBnKz2Mk2cJuW7wcxe14JPhIN2KWh5+ruUXM89RnQeECGqy6eQWze+/cTBAa
         D+8Q==
X-Gm-Message-State: AFqh2kr8TgPHwe4PSNDPnOF9u/24lJVkhM1VqwTShTQzE1zMKRCdBwgS
        X1CGaYD0nQ8qOuiOgO+CUAx9ug==
X-Google-Smtp-Source: AMrXdXu1EYK0JDO4UII/7zB1knsDVnmMAe5zoz1LVmjb+jur+ozkviixsD6HgC14w38fwIUFCL8InQ==
X-Received: by 2002:a2e:a5ca:0:b0:27f:d652:f38c with SMTP id n10-20020a2ea5ca000000b0027fd652f38cmr13729215ljp.19.1673464497640;
        Wed, 11 Jan 2023 11:14:57 -0800 (PST)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id r7-20020a2e8e27000000b00289873cce0bsm76343ljk.14.2023.01.11.11.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 11:14:57 -0800 (PST)
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
Subject: [PATCH 4/4] clk: qcom: add the driver for the MSM8996 APCS clocks
Date:   Wed, 11 Jan 2023 22:14:53 +0300
Message-Id: <20230111191453.2509468-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230111191453.2509468-1-dmitry.baryshkov@linaro.org>
References: <20230111191453.2509468-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 drivers/clk/qcom/apcs-msm8996.c | 77 +++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/qcom/apcs-msm8996.c

diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index f18c446a97ea..ca2f586edb3e 100644
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
index 000000000000..2e9959974ed9
--- /dev/null
+++ b/drivers/clk/qcom/apcs-msm8996.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Qualcomm APCS clock controller driver
+ *
+ * Copyright (c) 2022, Linaro Limited
+ * Author: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
+ */
+
+#include <linux/bits.h>
+#include <linux/clk.h>
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
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Qualcomm MSM8996 APCS clock driver");
-- 
2.30.2


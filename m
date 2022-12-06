Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4FE16443B1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 13:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234923AbiLFM51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 07:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234917AbiLFM5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 07:57:14 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFD72A426
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 04:56:49 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id v8so20154677edi.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 04:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=soA8N1Ws7r8ib/8pXw2ez+/oRcp2B0qvESayRn9yAKc=;
        b=cG04pUL3QoIFxU5vLZiAQM94+wAA/Jv2u6PMf8qPBVQAeV9HK9qU8XEOTi6m+rBupN
         x3WL4XaFaW2dNNi+RXQxxeT5SY/Z7AHRVwNHB3X9kE1r4S5JuUyM0TJYreUihpLoFksV
         GZY5SqQlWZMv3VcuQ4cnyKi3B8xUhwMU68iZgkuyWcgdtAoUlU1XTLgJleYWYNRzdv2K
         iCm9Xy/ojidKdxrnTOEKZ3VY7LhYFtLugMdOE2AbWUA6r40eXIhyIgp2GZWM0UJQ4WM9
         EU8cmMBDqCKcOIT6ScbrscC+9zRZ0tXbDC3l6Rx0M31wOXlRgIog7VC75lj3VDGbuLKi
         Hy/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=soA8N1Ws7r8ib/8pXw2ez+/oRcp2B0qvESayRn9yAKc=;
        b=NEy4HRL1Qjusv+ID4OQzeNY01974SXa0UQWGqM46zcXU4j3icNKcMW+9DD55oGticQ
         Fu/5mN83woHLIAqr08Ff8kEFE28qsue68OzFOPxknzVp9edviXnn1U9cnMnm3gj/OGJU
         gwwMHuZwg2sZPwJXeBdxG1EpgjJ7eVnJ4pAqlqSkSabjUY8LPvgCfiTQs3vHyR+QCdEu
         z/cFCi0okcNELL4vUmOUxZmQ/I97Fkp+/p76ZcTDWMYTdE8Ff7O2sUZpfMKSufWa3rDz
         9wMSlLg0W7vVM1WTU1705mj9l89FFczFjgWffgIB+z1uSdDlVnySzOkW1CwkmEsEHsLL
         P7Ug==
X-Gm-Message-State: ANoB5pmYEwlhbxBJwiuoJl4eXz98Qxn8mvISQpUKrD5Tpps8WRYKqPpS
        SaXlvAqaDC+qMGwkc71PPNxTnA==
X-Google-Smtp-Source: AA0mqf4Q3eo3D+HmEZLHquQ1Sx3ZizlBeyanK+lzKmAEOlk3lovQARecqqMUCvUURWlCEPvw8xHgvg==
X-Received: by 2002:aa7:cf82:0:b0:46b:34b:5804 with SMTP id z2-20020aa7cf82000000b0046b034b5804mr37017489edx.240.1670331407368;
        Tue, 06 Dec 2022 04:56:47 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id v15-20020aa7cd4f000000b0046150ee13besm932991edw.65.2022.12.06.04.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 04:56:46 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v5 5/5] clk: qcom: Add TCSR clock driver for SM8550
Date:   Tue,  6 Dec 2022 14:56:35 +0200
Message-Id: <20221206125635.952114-6-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221206125635.952114-1-abel.vesa@linaro.org>
References: <20221206125635.952114-1-abel.vesa@linaro.org>
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

The TCSR clock controller found on SM8550 provides refclks
for PCIE, USB and UFS. Add clock driver for it.

This patch is based on initial code downstream.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/Kconfig         |   7 ++
 drivers/clk/qcom/Makefile        |   1 +
 drivers/clk/qcom/tcsrcc-sm8550.c | 192 +++++++++++++++++++++++++++++++
 3 files changed, 200 insertions(+)
 create mode 100644 drivers/clk/qcom/tcsrcc-sm8550.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 70d43f0a8919..b9f5505d68f0 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -797,6 +797,13 @@ config SM_GPUCC_8350
 	  Say Y if you want to support graphics controller devices and
 	  functionality such as 3D graphics.
 
+config SM_TCSRCC_8550
+	tristate "SM8550 TCSR Clock Controller"
+	select QCOM_GDSC
+	help
+	  Support for the TCSR clock controller on SM8550 devices.
+	  Say Y if you want to use peripheral devices such as SD/UFS.
+
 config SM_VIDEOCC_8150
 	tristate "SM8150 Video Clock Controller"
 	select SM_GCC_8150
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index f18c446a97ea..f5ce429c724c 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -112,6 +112,7 @@ obj-$(CONFIG_SM_GPUCC_6350) += gpucc-sm6350.o
 obj-$(CONFIG_SM_GPUCC_8150) += gpucc-sm8150.o
 obj-$(CONFIG_SM_GPUCC_8250) += gpucc-sm8250.o
 obj-$(CONFIG_SM_GPUCC_8350) += gpucc-sm8350.o
+obj-$(CONFIG_SM_TCSRCC_8550) += tcsrcc-sm8550.o
 obj-$(CONFIG_SM_VIDEOCC_8150) += videocc-sm8150.o
 obj-$(CONFIG_SM_VIDEOCC_8250) += videocc-sm8250.o
 obj-$(CONFIG_SPMI_PMIC_CLKDIV) += clk-spmi-pmic-div.o
diff --git a/drivers/clk/qcom/tcsrcc-sm8550.c b/drivers/clk/qcom/tcsrcc-sm8550.c
new file mode 100644
index 000000000000..2c67ee71c196
--- /dev/null
+++ b/drivers/clk/qcom/tcsrcc-sm8550.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2022, Linaro Limited
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+
+#include <dt-bindings/clock/qcom,sm8550-tcsr.h>
+
+#include "clk-alpha-pll.h"
+#include "clk-branch.h"
+#include "clk-pll.h"
+#include "clk-rcg.h"
+#include "clk-regmap.h"
+#include "clk-regmap-divider.h"
+#include "clk-regmap-mux.h"
+#include "common.h"
+#include "reset.h"
+
+enum {
+	DT_BI_TCXO_PAD,
+};
+
+static struct clk_branch tcsr_pcie_0_clkref_en = {
+	.halt_reg = 0x15100,
+	.halt_check = BRANCH_HALT_SKIP,
+	.clkr = {
+		.enable_reg = 0x15100,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "tcsr_pcie_0_clkref_en",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO_PAD,
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch tcsr_pcie_1_clkref_en = {
+	.halt_reg = 0x15114,
+	.halt_check = BRANCH_HALT_SKIP,
+	.clkr = {
+		.enable_reg = 0x15114,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "tcsr_pcie_1_clkref_en",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO_PAD,
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch tcsr_ufs_clkref_en = {
+	.halt_reg = 0x15110,
+	.halt_check = BRANCH_HALT_SKIP,
+	.clkr = {
+		.enable_reg = 0x15110,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "tcsr_ufs_clkref_en",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO_PAD,
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch tcsr_ufs_pad_clkref_en = {
+	.halt_reg = 0x15104,
+	.halt_check = BRANCH_HALT_SKIP,
+	.clkr = {
+		.enable_reg = 0x15104,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "tcsr_ufs_pad_clkref_en",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO_PAD,
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch tcsr_usb2_clkref_en = {
+	.halt_reg = 0x15118,
+	.halt_check = BRANCH_HALT_SKIP,
+	.clkr = {
+		.enable_reg = 0x15118,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "tcsr_usb2_clkref_en",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO_PAD,
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch tcsr_usb3_clkref_en = {
+	.halt_reg = 0x15108,
+	.halt_check = BRANCH_HALT_SKIP,
+	.clkr = {
+		.enable_reg = 0x15108,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "tcsr_usb3_clkref_en",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO_PAD,
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_regmap *tcsr_cc_sm8550_clocks[] = {
+	[TCSR_PCIE_0_CLKREF_EN] = &tcsr_pcie_0_clkref_en.clkr,
+	[TCSR_PCIE_1_CLKREF_EN] = &tcsr_pcie_1_clkref_en.clkr,
+	[TCSR_UFS_CLKREF_EN] = &tcsr_ufs_clkref_en.clkr,
+	[TCSR_UFS_PAD_CLKREF_EN] = &tcsr_ufs_pad_clkref_en.clkr,
+	[TCSR_USB2_CLKREF_EN] = &tcsr_usb2_clkref_en.clkr,
+	[TCSR_USB3_CLKREF_EN] = &tcsr_usb3_clkref_en.clkr,
+};
+
+static const struct regmap_config tcsr_cc_sm8550_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x2f000,
+	.fast_io = true,
+};
+
+static const struct qcom_cc_desc tcsr_cc_sm8550_desc = {
+	.config = &tcsr_cc_sm8550_regmap_config,
+	.clks = tcsr_cc_sm8550_clocks,
+	.num_clks = ARRAY_SIZE(tcsr_cc_sm8550_clocks),
+};
+
+static const struct of_device_id tcsr_cc_sm8550_match_table[] = {
+	{ .compatible = "qcom,sm8550-tcsr" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, tcsr_cc_sm8550_match_table);
+
+static int tcsr_cc_sm8550_probe(struct platform_device *pdev)
+{
+	struct regmap *regmap;
+
+	regmap = qcom_cc_map(pdev, &tcsr_cc_sm8550_desc);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return qcom_cc_really_probe(pdev, &tcsr_cc_sm8550_desc, regmap);
+}
+
+static struct platform_driver tcsr_cc_sm8550_driver = {
+	.probe = tcsr_cc_sm8550_probe,
+	.driver = {
+		.name = "tcsr_cc-sm8550",
+		.of_match_table = tcsr_cc_sm8550_match_table,
+	},
+};
+
+static int __init tcsr_cc_sm8550_init(void)
+{
+	return platform_driver_register(&tcsr_cc_sm8550_driver);
+}
+subsys_initcall(tcsr_cc_sm8550_init);
+
+static void __exit tcsr_cc_sm8550_exit(void)
+{
+	platform_driver_unregister(&tcsr_cc_sm8550_driver);
+}
+module_exit(tcsr_cc_sm8550_exit);
+
+MODULE_DESCRIPTION("QTI TCSRCC SM8550 Driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA8067D95D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 00:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbjAZXEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 18:04:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbjAZXEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 18:04:04 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1CE6A706
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 15:03:53 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id j1so1197415iob.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 15:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N26PEPApLYbpGz0qyKTlI8x1Z7NNwGnlm+O7zvpxGcs=;
        b=jV3sjLex1kbpEc3GWpAMPWdMaIdlA7yEzjz4a9asfMWv3NL6RKXXBEo8SN5LWeZsEM
         l+EGsnMNpnsEr5cSbQP+9OF/fca+U1XIRgOzcbCOgJ5X4KjGcYhDqN/0Kt3jy1MrhyrL
         QjPtf/Th8PXUZYciux58kxjxfeQSwRbC9U7qlEDB74v2vzn8/dBoCf0TyNIdOdLZlsju
         9SrpKufFhkPMMLIgEV6z8UuzuqFWdcdiLxIigki7UJuDgC2YcpGcvWNjx5EEQVIyVeXl
         HAfYSGb6APRJ85OgAxoEFdjjVRuPrQnQk8uU+5CU5cFUiv/EeLQgsgUqZeprRQYsUC1j
         Hj1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N26PEPApLYbpGz0qyKTlI8x1Z7NNwGnlm+O7zvpxGcs=;
        b=XBn5BztdJHS6vHUKv26F6o5SB06MC11e8zVewoTKasFWRXlKelUy3/zlokKWbd5TI0
         CcQE0S4v1emOavmBQQ/mWA6+dg41MQF4myIxqBZYHW4Ii66hslRylkDc1JRBEJ9WVPin
         w/6Fq0vSo0Kn8t0Ftf6DIbe8K1h3mfcs6/QhPO6IeYfQP6UNKjuSlHhYUHWkZnCQYJGP
         s8iafSv6C3HZ063yWL0/yF5CpJ6szy1kSNK3exCFzBMuAGHDHP1hkilMPLN2RZsWw2mR
         xsshR8D8HdbQzFkcqF6zvrSG2fv5Hv7E64l859o600xEVo08SDijxsZ3IL7Op9x0gyvy
         q1HA==
X-Gm-Message-State: AFqh2kpPZVm91oQnu7x9j5Oxu9hvhH8ePlpUIlylJBqaNXzE3gR+ks3E
        BjzNQGSx+oEzUVjW1UMFS5pzgA==
X-Google-Smtp-Source: AMrXdXtIdkarRoDNgD4GrQZClYf/mKVXlQGJSrx6jyDSeVaoioXe8qOIGzVme9t4KANLslPXpjHEFw==
X-Received: by 2002:a6b:dd11:0:b0:704:67aa:57b0 with SMTP id f17-20020a6bdd11000000b0070467aa57b0mr26056011ioc.2.1674774232392;
        Thu, 26 Jan 2023 15:03:52 -0800 (PST)
Received: from eriador.lumag.spb.ru ([194.204.33.9])
        by smtp.gmail.com with ESMTPSA id l4-20020a6bd104000000b006f8b7d869a0sm670924iob.1.2023.01.26.15.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 15:03:52 -0800 (PST)
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
Subject: [PATCH v5 7/7] clk: qcom: add the driver for the MSM8996 APCS clocks
Date:   Fri, 27 Jan 2023 01:03:19 +0200
Message-Id: <20230126230319.3977109-8-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230126230319.3977109-1-dmitry.baryshkov@linaro.org>
References: <20230126230319.3977109-1-dmitry.baryshkov@linaro.org>
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
 drivers/clk/qcom/apcs-msm8996.c | 88 +++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/qcom/apcs-msm8996.c

diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 3194465dd02c..a8ed1f38b2f7 100644
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
index 000000000000..48d22572b6ae
--- /dev/null
+++ b/drivers/clk/qcom/apcs-msm8996.c
@@ -0,0 +1,88 @@
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
+	/*
+	 * This clock is used during CPU cluster setup while setting up CPU PLLs.
+	 * Add hardware mandated delay to make sure that the sys_apcs_aux clock
+	 * is stable (after setting the divider) before continuing
+	 * bootstrapping to keep CPUs from ending up in a weird state.
+	 */
+	udelay(5);
+
+	/*
+	 * As this clocks is a parent of the CPU cluster clocks and is actually
+	 * used as a parent during CPU clocks setup, we want for it to gegister
+	 * as early as possible, without letting fw_devlink to delay probing of
+	 * either of the drivers.
+	 *
+	 * The sys_apcs_aux is a child (divider) of gpll0, but we register it
+	 * as a fixed rate clock instead to ease bootstrapping procedure. By
+	 * doing this we make sure that CPU cluster clocks are able to be setup
+	 * early during the boot process (as it is recommended by Qualcomm).
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


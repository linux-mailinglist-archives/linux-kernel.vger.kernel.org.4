Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C338707FDE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 13:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbjERLkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 07:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjERLkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 07:40:42 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A336D1FFC
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 04:40:18 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f435658d23so18698245e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 04:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684409995; x=1687001995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPXk1G4TeGhvqAZ70qQMmoWif1eMKz4WBDv+NwIbmwQ=;
        b=in1UNHtJKNyK1lqHVENrTvEHMHutaKeL1hNmN5eeaWx+S+jN0wOoNfFX5rFzG6J/t+
         UJMbenHmIzMWZq2rrLh4Gp0fKjKwdQDgDm8ctMC9tYvXTYIsb5SvM2Yv7fHCs7vX6oej
         Veh1wDApeZMAo9YuyD5HReehBnLA7y9fs0Z9/SXR+whmh7r21Tms5SyP58zv9wN0Mmob
         8bYx1QeHsBmVOeDXV7XOwBzWEmHmPKo4UHICraXH0qY92GqsDFcGwqY6iqr4QQTPQ9v5
         wPUf2C+O1wjSEhv2+UE82pXBkNP89M4B01ehegK77r9HpCMjqTx3KJz/MwJ9mUsr3c+p
         zVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684409995; x=1687001995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPXk1G4TeGhvqAZ70qQMmoWif1eMKz4WBDv+NwIbmwQ=;
        b=AdGqSYiS20VB+FFEXVRNJSdJWuzIrVdYOCow4H3mRUuexbgq0ZnhmQ67jmfQ9PIE8X
         4Q4akBj5Bwshg5dwW3L3G81NRSZ3A1hXk+MbOgV1VMvzY7Uf1eQSXPj4LBrArgwQQwLh
         l3izLGTXiOVa9QmCSavPoyHfMnOQk1PsxPxi5QEVRU+udJd9TQ9cONlXmpns/9EiE7QG
         mFVza7P7jQlzddhrj59Mgkm6W+YlwHAZH1a4z5xEIavrM5A7BoiXoV2KYvN6oUjnksQw
         XR7DG88Mxsrzt/4t7Vx7NnZmvL6UZ+YHRcghCyUFyg+UW98GKgXjvOUPTBv4TV1HKr/c
         jq+Q==
X-Gm-Message-State: AC+VfDxL5GMHSNQiCSWUbx/lLfeLPsla97irwQ5FAT33CfhFid1CY/a9
        IZHqPU/+c1oJm7y2pMnCF4kaZw==
X-Google-Smtp-Source: ACHHUZ6o9HZsu2rFZ7hMK2R3yEs2nvra64q0mfIeGYWwM0nsfu7X8YVEXZ+sH87T82mfyq16wffaHA==
X-Received: by 2002:a5d:5947:0:b0:306:2de6:6f9b with SMTP id e7-20020a5d5947000000b003062de66f9bmr1209915wri.58.1684409995598;
        Thu, 18 May 2023 04:39:55 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id f14-20020a5d568e000000b003047d5b8817sm1897135wrv.80.2023.05.18.04.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 04:39:55 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     johan+linaro@kernel.org, agross@kernel.org,
        konrad.dybcio@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/5] clk: qcom: Add lpass clock controller driver for SC8280XP
Date:   Thu, 18 May 2023 12:37:58 +0100
Message-Id: <20230518113800.339158-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230518113800.339158-1-srinivas.kandagatla@linaro.org>
References: <20230518113800.339158-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the lpass clock controller found on SC8280XP based devices.
This would allow lpass peripheral loader drivers to control the clocks and
bring the subsystems out of reset.

Currently this patch only supports resets as the Q6DSP is in control of
LPASS IP which manages most of the clocks via Q6PRM service on GPR rpmsg
channel.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/clk/qcom/Kconfig            |  8 ++++
 drivers/clk/qcom/Makefile           |  1 +
 drivers/clk/qcom/lpasscc-sc8280xp.c | 71 +++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+)
 create mode 100644 drivers/clk/qcom/lpasscc-sc8280xp.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 12be3e2371b3..8188f4dedf40 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -514,6 +514,14 @@ config SC_GPUCC_8280XP
 	  Say Y if you want to support graphics controller devices and
 	  functionality such as 3D graphics.
 
+config SC_LPASSCC_8280XP
+	tristate "SC8280 Low Power Audio Subsystem (LPASS) Clock Controller"
+	select SC_GCC_8280XP
+	help
+	  Support for the LPASS clock controller on SC8280XP devices.
+	  Say Y if you want to use the LPASS branch clocks of the LPASS clock
+	  controller to reset the LPASS subsystem.
+
 config SC_LPASSCC_7280
 	tristate "SC7280 Low Power Audio Subsystem (LPASS) Clock Controller"
 	select SC_GCC_7280
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 9ff4c373ad95..dce2dd639524 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -71,6 +71,7 @@ obj-$(CONFIG_SC_CAMCC_7280) += camcc-sc7280.o
 obj-$(CONFIG_SC_DISPCC_7180) += dispcc-sc7180.o
 obj-$(CONFIG_SC_DISPCC_7280) += dispcc-sc7280.o
 obj-$(CONFIG_SC_DISPCC_8280XP) += dispcc-sc8280xp.o
+obj-$(CONFIG_SC_LPASSCC_8280XP) += lpasscc-sc8280xp.o
 obj-$(CONFIG_SA_GCC_8775P) += gcc-sa8775p.o
 obj-$(CONFIG_SA_GPUCC_8775P) += gpucc-sa8775p.o
 obj-$(CONFIG_SC_GCC_7180) += gcc-sc7180.o
diff --git a/drivers/clk/qcom/lpasscc-sc8280xp.c b/drivers/clk/qcom/lpasscc-sc8280xp.c
new file mode 100644
index 000000000000..118320f8ee40
--- /dev/null
+++ b/drivers/clk/qcom/lpasscc-sc8280xp.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022, Linaro Limited
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+#include <dt-bindings/clock/qcom,lpasscc-sc8280xp.h>
+#include "common.h"
+#include "reset.h"
+
+static const struct qcom_reset_map lpass_tcsr_sc8280xp_resets[] = {
+	[LPASS_AUDIO_SWR_TX_CGCR] = { 0xc010, 1 },
+};
+
+static struct regmap_config lpass_tcsr_sc8280xp_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.name = "lpass-tcsr",
+	.max_register = 0x12000,
+};
+
+static const struct qcom_cc_desc lpass_tcsr_reset_sc8280xp_desc = {
+	.config = &lpass_tcsr_sc8280xp_regmap_config,
+	.resets = lpass_tcsr_sc8280xp_resets,
+	.num_resets = ARRAY_SIZE(lpass_tcsr_sc8280xp_resets),
+};
+
+static const struct of_device_id lpasscc_sc8280xp_match_table[] = {
+	{
+		.compatible = "qcom,sc8280xp-lpasscc",
+		.data = &lpass_tcsr_reset_sc8280xp_desc,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, lpasscc_sc8280xp_match_table);
+
+static int lpasscc_sc8280xp_probe(struct platform_device *pdev)
+{
+	const struct qcom_cc_desc *desc = of_device_get_match_data(&pdev->dev);
+
+	return qcom_cc_probe_by_index(pdev, 0, desc);
+}
+
+static struct platform_driver lpasscc_sc8280xp_driver = {
+	.probe = lpasscc_sc8280xp_probe,
+	.driver = {
+		.name = "lpasscc-sc8280xp",
+		.of_match_table = lpasscc_sc8280xp_match_table,
+	},
+};
+
+static int __init lpasscc_sc8280xp_init(void)
+{
+	return platform_driver_register(&lpasscc_sc8280xp_driver);
+}
+subsys_initcall(lpasscc_sc8280xp_init);
+
+static void __exit lpasscc_sc8280xp_exit(void)
+{
+	platform_driver_unregister(&lpasscc_sc8280xp_driver);
+}
+module_exit(lpasscc_sc8280xp_exit);
+
+MODULE_DESCRIPTION("QTI LPASSCC SC8280XP Driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1


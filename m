Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E82573CADA
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 14:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbjFXMXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 08:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbjFXMXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 08:23:51 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1F6E41
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 05:23:50 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f96d680399so2020412e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 05:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687609428; x=1690201428;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4mlusQIqHLc3L1kKJFIe3oY0E4pRPb3J1UORktAQD1k=;
        b=OZGC+9QI1M3ODN9W7x37gwtYeEEBZK1C4ZBcjZxWEjq+3+Csf55wDuNCEuAoUCMFA2
         z7pg9Wg6+Xhr3fK5LtK/iPlPJq7TfMZC0OwOL+Z0ChzK13P/ldd6DrUokIboyx9QYnOO
         08vGi/1T5NHk6NcnPBMUIzmbYsI5BpWi0cEIAhmTY8cLJbnQ6OjihjmIudftwqRiaGM5
         xpN8EmGucaHcmnPQ6Ja5JNX30N1+W3xf0PriZf8eclootT9EEBYTwQvSAfMnsR7Bu00s
         VZYgwiIoCCJJbDuxHTARjplZEDBG0AQcwxjbcO8h42KRvK6nYwYXOotf0mgMWuh3TFxQ
         k1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687609428; x=1690201428;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4mlusQIqHLc3L1kKJFIe3oY0E4pRPb3J1UORktAQD1k=;
        b=P2ppbsmpEGvMr1E5KrosTxUAfNwkdviy4l8WULd3QeOrkl4a2vNAik/C3IvwSDei3n
         FXzpyQWBJL/h6G+EQOi4T1ihhQXM+FtElvbMqFpvt3zsbNgOeD9Y5G8fB3uPrzATG1cZ
         OVpFvBS6xYArfQhdGDvzodwy5kHqg/AR/thdoN+9Za/4RjbutWnCq73tAmHOy+sZ83mq
         qMXCO8A7zdGoR3rA/3sJ0QQHYWqmTRudmO/UnoJv90EoBDW2r4wAOaCEnMryGKqXjW9K
         nqSbk/8mbkSOdq0Me+xQKlZtB4GLqHvRiXtdO5+WHaneOXHmbkFHEn0bSovtaA4buOVG
         c/NQ==
X-Gm-Message-State: AC+VfDzb0CsP2As3i2NnebO5tUdQorTaC1M2lXdzeuWkfkZBDN40M+sQ
        XaDwE54PvyQ0BHyscRbrdDTnJQ==
X-Google-Smtp-Source: ACHHUZ5wvzrIOG2lC6PssO6R/HYy7Ys+3tceM2SMKPFaFQEPBrqqNy/ZeOtox/aofROgKnSiCgG8Qg==
X-Received: by 2002:a05:6512:31c8:b0:4f9:5d34:44b1 with SMTP id j8-20020a05651231c800b004f95d3444b1mr8229225lfe.2.1687609428226;
        Sat, 24 Jun 2023 05:23:48 -0700 (PDT)
Received: from [192.168.1.101] (abyk197.neoplus.adsl.tpnet.pl. [83.9.30.197])
        by smtp.gmail.com with ESMTPSA id s13-20020a19ad4d000000b004f00189e1dcsm260200lfd.117.2023.06.24.05.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 05:23:47 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 24 Jun 2023 14:23:45 +0200
Subject: [PATCH v2 1/3] firmware: qcom_scm: Always try to consume all three
 clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230623-topic-scm_cleanup-v2-1-9db8c583138d@linaro.org>
References: <20230623-topic-scm_cleanup-v2-0-9db8c583138d@linaro.org>
In-Reply-To: <20230623-topic-scm_cleanup-v2-0-9db8c583138d@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687609426; l=5055;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=c6mXCk54PRq5wka3veC3/OftoitCZW2RQQCuecVwHSI=;
 b=CohtLcSjA2HX4NMnCMM24PR0MDttb7QJBE91IfGXR0mpfZQ66Toy6jR1mwMo2hrzJi23GRBNq
 5PuMfr8LJhmDSUG+OpbyI+R7P41eN91mImDT+XPkMy9LQ+wIKsWP3Ge
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code for handling more than 1 clock is a bit messy and requires
one to add new, SoC-specific compatibles if one wants to attach a clock.

Switch devm_clk_get to devm_clk_get_optional to prevent throwing it
from throwing errors when the clock is absent and defer checking the
clock requirements to dt schema.

This lets us get rid of compatibles that aren't necessary for backwards
compatibility *and* will hopefully prevent the addition of meaningless
new compatibles.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/firmware/qcom_scm.c | 73 ++++++++-------------------------------------
 1 file changed, 13 insertions(+), 60 deletions(-)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index fde33acd46b7..237d05d6208b 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -26,10 +26,6 @@
 static bool download_mode = IS_ENABLED(CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT);
 module_param(download_mode, bool, 0);
 
-#define SCM_HAS_CORE_CLK	BIT(0)
-#define SCM_HAS_IFACE_CLK	BIT(1)
-#define SCM_HAS_BUS_CLK		BIT(2)
-
 struct qcom_scm {
 	struct device *dev;
 	struct clk *core_clk;
@@ -1405,7 +1401,6 @@ static irqreturn_t qcom_scm_irq_handler(int irq, void *data)
 static int qcom_scm_probe(struct platform_device *pdev)
 {
 	struct qcom_scm *scm;
-	unsigned long clks;
 	int irq, ret;
 
 	scm = devm_kzalloc(&pdev->dev, sizeof(*scm), GFP_KERNEL);
@@ -1418,50 +1413,27 @@ static int qcom_scm_probe(struct platform_device *pdev)
 
 	mutex_init(&scm->scm_bw_lock);
 
-	clks = (unsigned long)of_device_get_match_data(&pdev->dev);
-
 	scm->path = devm_of_icc_get(&pdev->dev, NULL);
 	if (IS_ERR(scm->path))
 		return dev_err_probe(&pdev->dev, PTR_ERR(scm->path),
 				     "failed to acquire interconnect path\n");
 
-	scm->core_clk = devm_clk_get(&pdev->dev, "core");
+	scm->core_clk = devm_clk_get_optional(&pdev->dev, "core");
 	if (IS_ERR(scm->core_clk)) {
 		if (PTR_ERR(scm->core_clk) == -EPROBE_DEFER)
 			return PTR_ERR(scm->core_clk);
-
-		if (clks & SCM_HAS_CORE_CLK) {
-			dev_err(&pdev->dev, "failed to acquire core clk\n");
-			return PTR_ERR(scm->core_clk);
-		}
-
-		scm->core_clk = NULL;
 	}
 
-	scm->iface_clk = devm_clk_get(&pdev->dev, "iface");
+	scm->iface_clk = devm_clk_get_optional(&pdev->dev, "iface");
 	if (IS_ERR(scm->iface_clk)) {
 		if (PTR_ERR(scm->iface_clk) == -EPROBE_DEFER)
 			return PTR_ERR(scm->iface_clk);
-
-		if (clks & SCM_HAS_IFACE_CLK) {
-			dev_err(&pdev->dev, "failed to acquire iface clk\n");
-			return PTR_ERR(scm->iface_clk);
-		}
-
-		scm->iface_clk = NULL;
 	}
 
-	scm->bus_clk = devm_clk_get(&pdev->dev, "bus");
+	scm->bus_clk = devm_clk_get_optional(&pdev->dev, "bus");
 	if (IS_ERR(scm->bus_clk)) {
 		if (PTR_ERR(scm->bus_clk) == -EPROBE_DEFER)
 			return PTR_ERR(scm->bus_clk);
-
-		if (clks & SCM_HAS_BUS_CLK) {
-			dev_err(&pdev->dev, "failed to acquire bus clk\n");
-			return PTR_ERR(scm->bus_clk);
-		}
-
-		scm->bus_clk = NULL;
 	}
 
 	scm->reset.ops = &qcom_scm_pas_reset_ops;
@@ -1512,38 +1484,19 @@ static void qcom_scm_shutdown(struct platform_device *pdev)
 }
 
 static const struct of_device_id qcom_scm_dt_match[] = {
-	{ .compatible = "qcom,scm-apq8064",
-	  /* FIXME: This should have .data = (void *) SCM_HAS_CORE_CLK */
-	},
-	{ .compatible = "qcom,scm-apq8084", .data = (void *)(SCM_HAS_CORE_CLK |
-							     SCM_HAS_IFACE_CLK |
-							     SCM_HAS_BUS_CLK)
-	},
+	{ .compatible = "qcom,scm-apq8064" },
+	{ .compatible = "qcom,scm-apq8084" },
 	{ .compatible = "qcom,scm-ipq4019" },
-	{ .compatible = "qcom,scm-mdm9607", .data = (void *)(SCM_HAS_CORE_CLK |
-							     SCM_HAS_IFACE_CLK |
-							     SCM_HAS_BUS_CLK) },
-	{ .compatible = "qcom,scm-msm8660", .data = (void *) SCM_HAS_CORE_CLK },
-	{ .compatible = "qcom,scm-msm8960", .data = (void *) SCM_HAS_CORE_CLK },
-	{ .compatible = "qcom,scm-msm8916", .data = (void *)(SCM_HAS_CORE_CLK |
-							     SCM_HAS_IFACE_CLK |
-							     SCM_HAS_BUS_CLK)
-	},
-	{ .compatible = "qcom,scm-msm8953", .data = (void *)(SCM_HAS_CORE_CLK |
-							     SCM_HAS_IFACE_CLK |
-							     SCM_HAS_BUS_CLK)
-	},
-	{ .compatible = "qcom,scm-msm8974", .data = (void *)(SCM_HAS_CORE_CLK |
-							     SCM_HAS_IFACE_CLK |
-							     SCM_HAS_BUS_CLK)
-	},
-	{ .compatible = "qcom,scm-msm8976", .data = (void *)(SCM_HAS_CORE_CLK |
-							     SCM_HAS_IFACE_CLK |
-							     SCM_HAS_BUS_CLK)
-	},
+	{ .compatible = "qcom,scm-mdm9607" },
+	{ .compatible = "qcom,scm-msm8660" },
+	{ .compatible = "qcom,scm-msm8960" },
+	{ .compatible = "qcom,scm-msm8916" },
+	{ .compatible = "qcom,scm-msm8953" },
+	{ .compatible = "qcom,scm-msm8974" },
+	{ .compatible = "qcom,scm-msm8976" },
 	{ .compatible = "qcom,scm-msm8994" },
 	{ .compatible = "qcom,scm-msm8996" },
-	{ .compatible = "qcom,scm-sm6375", .data = (void *)SCM_HAS_CORE_CLK },
+	{ .compatible = "qcom,scm-sm6375" },
 	{ .compatible = "qcom,scm" },
 	{}
 };

-- 
2.41.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7544873C356
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 23:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbjFWVvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 17:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbjFWVtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 17:49:47 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE342701
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 14:49:45 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b46f1256bbso27374691fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 14:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687556984; x=1690148984;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RT+DMw9+JmEB+4blOGBEOQCCmDaLSKVa4tRJvUDZHYw=;
        b=lecwxWvFh2wABTwinbKbk2vXyK+vMqENR4o606JLOknjCo4R7wcHxvGUjmLWqT/pNp
         6aZ/g+tzl+sRjGqw8AJ/A+09KAlA5CnoqeCh6VSOLFloP8o+/miSQhzVG8mrbivrSyA8
         v0co5soOG49maSVuTMUkmwygSjbEDxl5Pe6JOQ5rKCiuNbboHHr4WiosZR73j+mXerQ4
         D2BpLV1F6VNgc9eFxX4qs3UNBNPHaeOikR2B6jinv5Gwd0qurQJxmR+8vZEb+ebWM3K1
         Zfw0LWBTNz5/ftSOHjrsWj8IzgdaiP6tqig9fgTtYqd2IoytDc2lNQGGfiVH+sKcU+oj
         UNwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687556984; x=1690148984;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RT+DMw9+JmEB+4blOGBEOQCCmDaLSKVa4tRJvUDZHYw=;
        b=EKG9Wzg4IomayfB8OBNNkFmgcDm2ZcpkCYqh1qydo9QY9Uw7bYExpif1UK641DN0wZ
         W318IfSXsIlQ9cvEiEgR5C7tHAnBF20olFppOvAGlRDPJDXhmGyETUUxS1l41snas1BV
         +yPDl4NaUAmwiz2LfPraCzivMUzwVAlgkClAwMhGdeULXHDoYCx1ijpbDtYHbQSGqXnp
         1l7p2a4Jt3JNh3mMGo8OR0asUArgGG4XtGcBO+ydJA13uIm4gwSS+gf73zYHHm0xT5Jw
         YS5X3BsgvkeaJHBUH23mC4idCkZzuY84Kl5V8G0Q21FNiKoAQoZ5tbXWRcPzCRRzi2PY
         MxIg==
X-Gm-Message-State: AC+VfDzdDYXMR2D/P8jEILSsEZ2NUeBeSVGh4HTOnaukI3JogJLN09Du
        lLfH2Uc+PArI3RN0sUKdcQy1ww==
X-Google-Smtp-Source: ACHHUZ4Qsgh5BpEcXr0ex6p/I1xXp8oHnlGAZZ0gCcG1oLYqyghfqdPIB9b1i6aAsUWJGzKfw1KOiA==
X-Received: by 2002:a2e:9d48:0:b0:2b4:50b8:5d3b with SMTP id y8-20020a2e9d48000000b002b450b85d3bmr7576901ljj.0.1687556983889;
        Fri, 23 Jun 2023 14:49:43 -0700 (PDT)
Received: from [192.168.1.101] (abyk30.neoplus.adsl.tpnet.pl. [83.9.30.30])
        by smtp.gmail.com with ESMTPSA id x20-20020a2e9c94000000b002b48437dcaasm1840919lji.103.2023.06.23.14.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 14:49:43 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 23 Jun 2023 23:49:42 +0200
Subject: [PATCH 1/3] firmware: qcom_scm: Always try to consume all three
 clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230623-topic-scm_cleanup-v1-1-383089eae98d@linaro.org>
References: <20230623-topic-scm_cleanup-v1-0-383089eae98d@linaro.org>
In-Reply-To: <20230623-topic-scm_cleanup-v1-0-383089eae98d@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687556981; l=4598;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=20MGaxR8SA/gitewjqJ05iW6t2qyGVNzk/M4vihgecc=;
 b=U+OJNRvlUVPfRdWvMndA3yI0+ew1J+eFh+Hvmxc5NRWEkkc7Hsdgqx5xIwmZmGGqlQmYtXvJ7
 vCWfFMjPASBBOXevpw72vOUYRfsus9HEu+cBPvcoYYJFozf8XrBn6Ry
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/firmware/qcom_scm.c | 70 +++++++++------------------------------------
 1 file changed, 13 insertions(+), 57 deletions(-)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index fde33acd46b7..dfa298347041 100644
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
@@ -1425,43 +1421,22 @@ static int qcom_scm_probe(struct platform_device *pdev)
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
@@ -1512,38 +1487,19 @@ static void qcom_scm_shutdown(struct platform_device *pdev)
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


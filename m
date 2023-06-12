Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD27372CE6A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 20:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237711AbjFLSbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 14:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237683AbjFLSYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:24:48 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B923E0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:24:46 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f61d79b0f2so5747333e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686594285; x=1689186285;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eCy7STwPQguvSNXF/hCQ4j5BFOyuDUsQ8E/cZCUelP4=;
        b=G4oYaGxAqeEmVL2CCO3hv38YyrJcIKojCs3Vh+ankfaH8waqiFXAOtsKk9Qn1QXPSk
         pxBr/2G4q3Wt5UMBSzkCRTagGyg/FSofzHYJP85wasMmMZsz1Vs7Vm2nnaCBjhOsbv5A
         LIoPw8uOw/AX1VxQ5wtdFQuSIgJ5dscLsWy9kzdqTWAhAGCUSSU1AKmi0ddB+t0wdk8m
         us4OEwBeD2ze2FHX1zB8S4VeNJ7WDvpMuRlMis9P5DQ4JRJxuxqCj71ZPNnSNiiSuYmA
         D2yBfXyLM+YAipdUeixMYONA2f0IzYRqNjQ6c9XUPGo21YXtLAY+3oX5vVLI+QAKDGh2
         uZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686594285; x=1689186285;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eCy7STwPQguvSNXF/hCQ4j5BFOyuDUsQ8E/cZCUelP4=;
        b=C4wVhWuIdee6jFc+ojv65OQaFYK4OMJjMyEB51cdO2InKDLZfxNao9P5l1Us3Skbnt
         O1LfikCDQcfl1MP31amqTQVO8uQKOaEx150NLg7B9AJEMBkH+uzgSA3ziDKZtSN2ZjhR
         YEtYDGXYgfreocEr/f44pzbLfndq9+eC11WHGh8NDJqxJkyxicDwQQb31yDd543tX/y4
         Zh87jB6Mj34MEtyR9/w88t0FQXGeizFe1tHR8+6FWHm+XI2cxvRDLLQS2ItEFwcl2S58
         QA/44Ws3yUr21SsghyJ3QhZV++kAZOrWS6I1ve++wenMNSmoSAO3eT7w/OsPWEBSwEOS
         avLA==
X-Gm-Message-State: AC+VfDziSiQ9CQBNM5q9pN/iqxCsbJxhf4CivHpsdUcJnDkAeWKCOOX1
        F4ceYxnu+iMVJxkL5wJvmp3mFA==
X-Google-Smtp-Source: ACHHUZ58CWP0TUQtOmIAKW02HnTkreLK4yWE3dA8m7XEttkU90zKpYDVPxFVEoeQ7TGKUloBU5imOg==
X-Received: by 2002:ac2:51bc:0:b0:4f6:1805:6095 with SMTP id f28-20020ac251bc000000b004f618056095mr5139755lfk.8.1686594284758;
        Mon, 12 Jun 2023 11:24:44 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id v24-20020ac25938000000b004f64073a252sm1502035lfi.96.2023.06.12.11.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 11:24:44 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 12 Jun 2023 20:24:22 +0200
Subject: [PATCH v3 05/23] soc: qcom: smd-rpm: Move icc_smd_rpm registration
 to clk-smd-rpm
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v3-5-5fb7d39b874f@linaro.org>
References: <20230526-topic-smd_icc-v3-0-5fb7d39b874f@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v3-0-5fb7d39b874f@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686594276; l=3906;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=5jxwMVCy7bliJJPeYw9tcAw9XDgLw6G87CnBeb6K5TA=;
 b=pTSpv7jAl37WWUaTl+0qjbAvU7VYkk18U8q9fyvaSeD8hy51vvTFBgtDYt9kqtn4DFF6U90x4
 absnOHbqtZ5A2xhhozHZkx9gFRleVQTmtNpXvRSeL5A+xhmew+0lJgn
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephan Gerhold <stephan@gerhold.net>

icc_smd_rpm will do bus clock votes itself rather than taking the
unnecessary detour through the clock subsystem. However, it can only
do that after the clocks have been handed off and scaling has been
enabled in the RPM in clk-smd-rpm.

Move the icc_smd_rpm registration from smd-rpm.c to clk-smd-rpm.c
to avoid any possible races. icc_smd_rpm gets the driver data from
the smd-rpm device, so still register the platform device on the
smd-rpm parent device.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
[Konrad: remove unrelated cleanups]
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/clk-smd-rpm.c | 21 +++++++++++++++++++++
 drivers/soc/qcom/smd-rpm.c     | 17 +----------------
 2 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index 937cb1515968..6e7f0438e8b8 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -1289,12 +1289,20 @@ static struct clk_hw *qcom_smdrpm_clk_hw_get(struct of_phandle_args *clkspec,
 	return desc->clks[idx] ? &desc->clks[idx]->hw : ERR_PTR(-ENOENT);
 }
 
+static void rpm_smd_unregister_icc(void *data)
+{
+	struct platform_device *icc_pdev = data;
+
+	platform_device_unregister(icc_pdev);
+}
+
 static int rpm_smd_clk_probe(struct platform_device *pdev)
 {
 	int ret;
 	size_t num_clks, i;
 	struct clk_smd_rpm **rpm_smd_clks;
 	const struct rpm_smd_clk_desc *desc;
+	struct platform_device *icc_pdev;
 
 	rpmcc_smd_rpm = dev_get_drvdata(pdev->dev.parent);
 	if (!rpmcc_smd_rpm) {
@@ -1344,6 +1352,19 @@ static int rpm_smd_clk_probe(struct platform_device *pdev)
 	if (ret)
 		goto err;
 
+	icc_pdev = platform_device_register_data(pdev->dev.parent,
+						 "icc_smd_rpm", -1, NULL, 0);
+	if (IS_ERR(icc_pdev)) {
+		dev_err(&pdev->dev, "Failed to register icc_smd_rpm device: %pE\n",
+			icc_pdev);
+		/* No need to unregister clocks because of this */
+	} else {
+		ret = devm_add_action_or_reset(&pdev->dev, rpm_smd_unregister_icc,
+					       icc_pdev);
+		if (ret)
+			goto err;
+	}
+
 	return 0;
 err:
 	dev_err(&pdev->dev, "Error registering SMD clock driver (%d)\n", ret);
diff --git a/drivers/soc/qcom/smd-rpm.c b/drivers/soc/qcom/smd-rpm.c
index 0c1aa809cc4e..577f1f25ab10 100644
--- a/drivers/soc/qcom/smd-rpm.c
+++ b/drivers/soc/qcom/smd-rpm.c
@@ -19,7 +19,6 @@
 /**
  * struct qcom_smd_rpm - state of the rpm device driver
  * @rpm_channel:	reference to the smd channel
- * @icc:		interconnect proxy device
  * @dev:		rpm device
  * @ack:		completion for acks
  * @lock:		mutual exclusion around the send/complete pair
@@ -27,7 +26,6 @@
  */
 struct qcom_smd_rpm {
 	struct rpmsg_endpoint *rpm_channel;
-	struct platform_device *icc;
 	struct device *dev;
 
 	struct completion ack;
@@ -197,7 +195,6 @@ static int qcom_smd_rpm_callback(struct rpmsg_device *rpdev,
 static int qcom_smd_rpm_probe(struct rpmsg_device *rpdev)
 {
 	struct qcom_smd_rpm *rpm;
-	int ret;
 
 	rpm = devm_kzalloc(&rpdev->dev, sizeof(*rpm), GFP_KERNEL);
 	if (!rpm)
@@ -210,23 +207,11 @@ static int qcom_smd_rpm_probe(struct rpmsg_device *rpdev)
 	rpm->rpm_channel = rpdev->ept;
 	dev_set_drvdata(&rpdev->dev, rpm);
 
-	rpm->icc = platform_device_register_data(&rpdev->dev, "icc_smd_rpm", -1,
-						 NULL, 0);
-	if (IS_ERR(rpm->icc))
-		return PTR_ERR(rpm->icc);
-
-	ret = of_platform_populate(rpdev->dev.of_node, NULL, NULL, &rpdev->dev);
-	if (ret)
-		platform_device_unregister(rpm->icc);
-
-	return ret;
+	return of_platform_populate(rpdev->dev.of_node, NULL, NULL, &rpdev->dev);
 }
 
 static void qcom_smd_rpm_remove(struct rpmsg_device *rpdev)
 {
-	struct qcom_smd_rpm *rpm = dev_get_drvdata(&rpdev->dev);
-
-	platform_device_unregister(rpm->icc);
 	of_platform_depopulate(&rpdev->dev);
 }
 

-- 
2.41.0


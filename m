Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDB27357BB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjFSNFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbjFSNEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:04:43 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1C2E59
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:04:40 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f849605df4so4367791e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687179879; x=1689771879;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lt52lJ7IAYpZyo39NdZRaisuqAyx1l+kNW12PnaKg2U=;
        b=En8CD9GycLtvxH32rxGxhOx6JtPF0kR4LHyKrVZI/GRbsCIkBKqKN9Mc8mZYPHjMAp
         fSDmglMsvfHKYYk1b51azMAoQcKDOsSMbIjpxxhAJHDtLiLYwLGOLXvGR4B9nYQvdkHi
         wnaRhYrnhlKCch2mqgZcpAeDoXFhnhBh+mERnCETXntvTwWonUs4J2feyMiw3VGsssrK
         Py6d6h2A/RkK8t9P2Q5XWAUyYoZiUR6yxk18STPS8NLKaJFI7pOMvjrxt9C4u0oAEcBW
         sohsl3HE0HZkS37ODr5uKDC8BceNIKgrSB6O/fr+xXaHg0vNAtp+prCBSYIhpv9yQ0EZ
         V8qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687179879; x=1689771879;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lt52lJ7IAYpZyo39NdZRaisuqAyx1l+kNW12PnaKg2U=;
        b=l+uNSyMt9+HU2NRFkB+1zqJRZ62LoSd9Gr/Vb9URgPVVQQt5r3SSER/DbcVup3s2dA
         6hAYw4qFZbLp/aqQyitY6rHDpc5qCiPBV44jFaR+n7tFdWxtblA9bp4vN82+MfAf+DBK
         f+Ao3yiaqa6T+T/PtE0Mupk/MwzAzjYuIgVKmBtZrFK5m2zjqenrXQ5NIyMk6qosdXud
         jnfiU9Zj1dCDvF4NPZrse2jy5plKnwQB/Gg+42NnfkzH+OBjI+XX4xdUgVZgBmzD7NWP
         OAyIxDnYJpYMmomgvz1865X5/py2IO+hmJjEhDozQckZqtlhcEHMwdCrwy5T2tzB4EFK
         k/fA==
X-Gm-Message-State: AC+VfDy5RifPR395j5UevSqxke9RWif6hHwCghBkuAeEWLbIPDShC+++
        mKgK4jZ3xd6WmT14theuHvhGGQ==
X-Google-Smtp-Source: ACHHUZ51TEDzN6yCmxxPwI1+NeqGa9PN8ju/nXn4QZ3QwYpvV1UUTJca8d/MRUqmBdLrGj8I/6D29Q==
X-Received: by 2002:a19:6755:0:b0:4f8:57b8:8efe with SMTP id e21-20020a196755000000b004f857b88efemr5404132lfj.55.1687179879186;
        Mon, 19 Jun 2023 06:04:39 -0700 (PDT)
Received: from [192.168.1.101] (abyl242.neoplus.adsl.tpnet.pl. [83.9.31.242])
        by smtp.gmail.com with ESMTPSA id q28-20020ac25a1c000000b004f643664882sm4256489lfn.147.2023.06.19.06.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 06:04:38 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 19 Jun 2023 15:04:30 +0200
Subject: [PATCH v7 05/22] soc: qcom: smd-rpm: Move icc_smd_rpm registration
 to clk-smd-rpm
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v7-5-09c78c175546@linaro.org>
References: <20230526-topic-smd_icc-v7-0-09c78c175546@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v7-0-09c78c175546@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687179869; l=3949;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=jmhJvBjqUtAAd9ogN4BP2RfilLnjEO+h94MD5RIqO5E=;
 b=GZ5OvjOCyuxPEZy7+JAQptl2oVa+AeGimAatKHAGwSsOkUIfNL2iJ4ZcZ7pjhzkUy9dtJkJeY
 P6f2plH8r2PC/tT/bh36bUnRKU+mON4nLcRU3wsB2VK5eH/EuA7Tp9U
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
Acked-by: Stephen Boyd <sboyd@kernel.org>
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


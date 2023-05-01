Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916826F3164
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 15:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbjEANEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 09:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbjEANEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 09:04:09 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDF41B3
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 06:04:05 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f00d3f98deso22429557e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 06:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682946244; x=1685538244;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M3oovMXPBuInPxEGdlhc2Eac37pu+y5c8Kx0C4orDfE=;
        b=WKqLumo0wWBiCoZABjqUU0K90Znnd4EerhbnQGv99yUL+W7LFnzF1ty0Qmdy5K1S/1
         ZYEcsWb8a90qr+FDNz9VilLcoMAZbCHH6VknycKfzcb9YKnJ3aASCaFn0EZtJS4y7Tek
         7MsxPYDtSN/PhFPMPTMnnZQY76gQ+18X4lxDLlxWYpLYZquriHTtJk9rw9YcFEWcQQEM
         /gmsdG7rUu+se0Oq1yxQ63P024Evj6zjh9gvI5QHMQa58Btw1pg1xvuB6zqqHASu0ji+
         genukR1v+V6mdlW0t7azZ9+L5FUun/OkpSEF2zdzfTSSwaFcQ7wEaFXo8Ts4K34ts5Td
         Xcrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682946244; x=1685538244;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M3oovMXPBuInPxEGdlhc2Eac37pu+y5c8Kx0C4orDfE=;
        b=ZEKFDzH4AqQeeuI9NU3oCKuVf31Vs7go5Ei4LMIaznpYwR7NGD2434VtrKVQNAda6T
         hm/4nrCoGskCMQGV0wN5mXyb4tICzZA7qACyKqRH20niM/pxJlnYUvR5YhSldtI4hoHf
         LP2+rsxczfzuab6jYn57MGOw5oiAO2aPw9xS4I5sW3tx0G6JHbc3mgbiVPH6QAxnjECE
         nwPE7otzCLGLXwooMVlkdS9ozg+7YuMBEnPqKDm49Vb5r3PttzSgmY+RTR3jZAWsr/4O
         Q8QWK5cp5F/14aBDaTllP+h8k+Br3qS9BV3Aend/ka0bOb5mUhsbbR3UWZ0nMnILJULc
         ztjw==
X-Gm-Message-State: AC+VfDyt9LVquU558GVSclse3lotiw4Skbszv6CuR4UAufGlBtd7InrG
        JHgLkvie5qytxmbfO328kAmcxMIqinDJ49ClIyw=
X-Google-Smtp-Source: ACHHUZ7ZTtFGVyO2sO47NDEfwj6op+CutBcoz+ssyKc1TW1Vp6jY63nbmeuoB7jVyLRKZB48EDv8lg==
X-Received: by 2002:ac2:4e69:0:b0:4e8:487a:7c2e with SMTP id y9-20020ac24e69000000b004e8487a7c2emr3887479lfs.14.1682946243692;
        Mon, 01 May 2023 06:04:03 -0700 (PDT)
Received: from localhost.localdomain (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id c15-20020ac244af000000b004d5a6dcb94fsm4725732lfm.33.2023.05.01.06.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 06:04:03 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, sboyd@kernel.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: qcom: smd-rpm: Keep one rpm handle for all clocks
Date:   Mon,  1 May 2023 15:04:00 +0200
Message-Id: <20230501130400.107771-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.40.1
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

For no apparent reason (as there's just one RPM per SoC), all clocks
currently store a copy of a pointer to smd_rpm. Introduce a single,
global one to save up on space in each clk definition.

bloat-o-meter reports:

Total: Before=41887, After=40843, chg -2.49%

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/clk-smd-rpm.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index 887b945a6fb7..7797499faf31 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -156,6 +156,8 @@
 
 #define to_clk_smd_rpm(_hw) container_of(_hw, struct clk_smd_rpm, hw)
 
+static struct qcom_smd_rpm *rpmcc_smd_rpm;
+
 struct clk_smd_rpm {
 	const int rpm_res_type;
 	const int rpm_key;
@@ -166,7 +168,6 @@ struct clk_smd_rpm {
 	struct clk_smd_rpm *peer;
 	struct clk_hw hw;
 	unsigned long rate;
-	struct qcom_smd_rpm *rpm;
 };
 
 struct clk_smd_rpm_req {
@@ -191,12 +192,12 @@ static int clk_smd_rpm_handoff(struct clk_smd_rpm *r)
 		.value = cpu_to_le32(r->branch ? 1 : INT_MAX),
 	};
 
-	ret = qcom_rpm_smd_write(r->rpm, QCOM_SMD_RPM_ACTIVE_STATE,
+	ret = qcom_rpm_smd_write(rpmcc_smd_rpm, QCOM_SMD_RPM_ACTIVE_STATE,
 				 r->rpm_res_type, r->rpm_clk_id, &req,
 				 sizeof(req));
 	if (ret)
 		return ret;
-	ret = qcom_rpm_smd_write(r->rpm, QCOM_SMD_RPM_SLEEP_STATE,
+	ret = qcom_rpm_smd_write(rpmcc_smd_rpm, QCOM_SMD_RPM_SLEEP_STATE,
 				 r->rpm_res_type, r->rpm_clk_id, &req,
 				 sizeof(req));
 	if (ret)
@@ -214,7 +215,7 @@ static int clk_smd_rpm_set_rate_active(struct clk_smd_rpm *r,
 		.value = cpu_to_le32(DIV_ROUND_UP(rate, 1000)), /* to kHz */
 	};
 
-	return qcom_rpm_smd_write(r->rpm, QCOM_SMD_RPM_ACTIVE_STATE,
+	return qcom_rpm_smd_write(rpmcc_smd_rpm, QCOM_SMD_RPM_ACTIVE_STATE,
 				  r->rpm_res_type, r->rpm_clk_id, &req,
 				  sizeof(req));
 }
@@ -228,7 +229,7 @@ static int clk_smd_rpm_set_rate_sleep(struct clk_smd_rpm *r,
 		.value = cpu_to_le32(DIV_ROUND_UP(rate, 1000)), /* to kHz */
 	};
 
-	return qcom_rpm_smd_write(r->rpm, QCOM_SMD_RPM_SLEEP_STATE,
+	return qcom_rpm_smd_write(rpmcc_smd_rpm, QCOM_SMD_RPM_SLEEP_STATE,
 				  r->rpm_res_type, r->rpm_clk_id, &req,
 				  sizeof(req));
 }
@@ -395,7 +396,7 @@ static unsigned long clk_smd_rpm_recalc_rate(struct clk_hw *hw,
 	return r->rate;
 }
 
-static int clk_smd_rpm_enable_scaling(struct qcom_smd_rpm *rpm)
+static int clk_smd_rpm_enable_scaling(void)
 {
 	int ret;
 	struct clk_smd_rpm_req req = {
@@ -404,7 +405,7 @@ static int clk_smd_rpm_enable_scaling(struct qcom_smd_rpm *rpm)
 		.value = cpu_to_le32(1),
 	};
 
-	ret = qcom_rpm_smd_write(rpm, QCOM_SMD_RPM_SLEEP_STATE,
+	ret = qcom_rpm_smd_write(rpmcc_smd_rpm, QCOM_SMD_RPM_SLEEP_STATE,
 				 QCOM_SMD_RPM_MISC_CLK,
 				 QCOM_RPM_SCALING_ENABLE_ID, &req, sizeof(req));
 	if (ret) {
@@ -412,7 +413,7 @@ static int clk_smd_rpm_enable_scaling(struct qcom_smd_rpm *rpm)
 		return ret;
 	}
 
-	ret = qcom_rpm_smd_write(rpm, QCOM_SMD_RPM_ACTIVE_STATE,
+	ret = qcom_rpm_smd_write(rpmcc_smd_rpm, QCOM_SMD_RPM_ACTIVE_STATE,
 				 QCOM_SMD_RPM_MISC_CLK,
 				 QCOM_RPM_SCALING_ENABLE_ID, &req, sizeof(req));
 	if (ret) {
@@ -1301,12 +1302,11 @@ static int rpm_smd_clk_probe(struct platform_device *pdev)
 {
 	int ret;
 	size_t num_clks, i;
-	struct qcom_smd_rpm *rpm;
 	struct clk_smd_rpm **rpm_smd_clks;
 	const struct rpm_smd_clk_desc *desc;
 
-	rpm = dev_get_drvdata(pdev->dev.parent);
-	if (!rpm) {
+	rpmcc_smd_rpm = dev_get_drvdata(pdev->dev.parent);
+	if (!rpmcc_smd_rpm) {
 		dev_err(&pdev->dev, "Unable to retrieve handle to RPM\n");
 		return -ENODEV;
 	}
@@ -1322,14 +1322,12 @@ static int rpm_smd_clk_probe(struct platform_device *pdev)
 		if (!rpm_smd_clks[i])
 			continue;
 
-		rpm_smd_clks[i]->rpm = rpm;
-
 		ret = clk_smd_rpm_handoff(rpm_smd_clks[i]);
 		if (ret)
 			goto err;
 	}
 
-	ret = clk_smd_rpm_enable_scaling(rpm);
+	ret = clk_smd_rpm_enable_scaling();
 	if (ret)
 		goto err;
 
-- 
2.40.1


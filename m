Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF3372E545
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 16:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242764AbjFMOEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 10:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242742AbjFMODn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 10:03:43 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFCB1FCA
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 07:03:30 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b1a46ad09fso68708221fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 07:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686665010; x=1689257010;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M/J5ZhP262QYGYmarLd4yzENGlRt7ikJiCOlHTeoidM=;
        b=HBZr1xEVtVCKzGgx7VoWYpP27lnRRF4Cm2c2qa9Bdrbj3TJHPjm1RFQvkif9nScF0j
         QqjSsPpQC1Ugig5HySeVDyIs6VdE5jS+bOFM8yTWC81lkpcDYbJ1LvtPwApBLAbHBR5i
         FS/q7GfeO7TSLbQ+bEFXn5kXg9GO9mXWHy7qeOsHbZYXomfXsChC9wYwyJDgLiY6mY98
         rwYSgB0NTwMCALLMsEFGqo5tYvKNvhf2hNxcnQpLFEueLaSk40QBqRt1xHYhSOL+kzNC
         HudYABbibLwRIoSjLux23DPaf1CJor7Fdiwn1slSEl+wYlKXBV2GBSl3TNU3ITp3kYvy
         Vkyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686665010; x=1689257010;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M/J5ZhP262QYGYmarLd4yzENGlRt7ikJiCOlHTeoidM=;
        b=hpcefn+c3GlA//gSxNu7PX+xokdyU7L/wXI71IaDnkPgPDwRMufhk2GHU6+K4hz3Ij
         LzhYJfRsEga1WRd9nwbnWKbPq92r4tDKzu7ytnAplxud/FGH3yJtFub4+/De4Glx4fEa
         H9Ubm4rXYClQUocyAhedVsKE9qxUfbbgIUcugmdsrJcjZl8hJ9v5t/JPQ/Vp1rE2IPjg
         a9HSRG6YkV9Lx52pau0Gousq+erYDqm0D1F9/q3Kk2xEUeLkMdN8W04Mz4ZNInrO8Ioz
         AH+YAGTzIsUpbOMTlndGjs1lqeBRV2FfFYXx3ZhLgay5LxE4dzbJ9N/8zE6XI9bC9v71
         qiqg==
X-Gm-Message-State: AC+VfDyjgFc6+MJ/k6u86dMZYUJhD7Tl/zppN1P36wltUoFOykyoSSO3
        ZYDQr25+jyzAIubXUKEfB764zw==
X-Google-Smtp-Source: ACHHUZ7qOiKHWmJiQwiSRhLbGz1oVxQPzRwh2a8x0cf1b4a2c54nRYDxFLeR1UizZ2xNUT+Qcy6vug==
X-Received: by 2002:a2e:8695:0:b0:2b1:b11f:1f2c with SMTP id l21-20020a2e8695000000b002b1b11f1f2cmr4403917lji.25.1686665009921;
        Tue, 13 Jun 2023 07:03:29 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id a18-20020a05651c011200b002b32af2e9c6sm901490ljb.116.2023.06.13.07.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 07:03:29 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 13 Jun 2023 16:03:11 +0200
Subject: [PATCH v4 11/22] interconnect: qcom: sdm660: Hook up RPM bus clk
 definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v4-11-5ba82b6fbba2@linaro.org>
References: <20230526-topic-smd_icc-v4-0-5ba82b6fbba2@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v4-0-5ba82b6fbba2@linaro.org>
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
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686664985; l=1986;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Krc2Kcr5fnOQoU3m0Y+nr01slcqtM3Q1E0UfX4Ye6Q4=;
 b=h/vFjS2RkjwGjbyfVZTY5NBsEUcOtRgs5tixL3/9Bz1YX2e0yb+7tBtjv7HueiK0GqqXu4dQW
 Y8Dxxr9eEDMA8xyaLNxjXceeJX4jAph17npNbVr9rNG/bGcsFp9uuYR
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

Assign the necessary definitions to migrate to the new bus clock
handling mechanism.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/sdm660.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/interconnect/qcom/sdm660.c b/drivers/interconnect/qcom/sdm660.c
index 003fc7d110a7..5743ed680e8e 100644
--- a/drivers/interconnect/qcom/sdm660.c
+++ b/drivers/interconnect/qcom/sdm660.c
@@ -1511,6 +1511,7 @@ static const struct qcom_icc_desc sdm660_a2noc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = sdm660_a2noc_nodes,
 	.num_nodes = ARRAY_SIZE(sdm660_a2noc_nodes),
+	.bus_clk_desc = &aggre2_clk,
 	.intf_clocks = a2noc_intf_clocks,
 	.num_intf_clocks = ARRAY_SIZE(a2noc_intf_clocks),
 	.regmap_cfg = &sdm660_a2noc_regmap_config,
@@ -1539,6 +1540,7 @@ static const struct qcom_icc_desc sdm660_bimc = {
 	.type = QCOM_ICC_BIMC,
 	.nodes = sdm660_bimc_nodes,
 	.num_nodes = ARRAY_SIZE(sdm660_bimc_nodes),
+	.bus_clk_desc = &bimc_clk,
 	.regmap_cfg = &sdm660_bimc_regmap_config,
 };
 
@@ -1593,6 +1595,7 @@ static const struct qcom_icc_desc sdm660_cnoc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = sdm660_cnoc_nodes,
 	.num_nodes = ARRAY_SIZE(sdm660_cnoc_nodes),
+	.bus_clk_desc = &bus_2_clk,
 	.regmap_cfg = &sdm660_cnoc_regmap_config,
 };
 
@@ -1655,6 +1658,7 @@ static const struct qcom_icc_desc sdm660_mnoc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = sdm660_mnoc_nodes,
 	.num_nodes = ARRAY_SIZE(sdm660_mnoc_nodes),
+	.bus_clk_desc = &mmaxi_0_clk,
 	.intf_clocks = mm_intf_clocks,
 	.num_intf_clocks = ARRAY_SIZE(mm_intf_clocks),
 	.regmap_cfg = &sdm660_mnoc_regmap_config,
@@ -1692,6 +1696,7 @@ static const struct qcom_icc_desc sdm660_snoc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = sdm660_snoc_nodes,
 	.num_nodes = ARRAY_SIZE(sdm660_snoc_nodes),
+	.bus_clk_desc = &bus_1_clk,
 	.regmap_cfg = &sdm660_snoc_regmap_config,
 };
 

-- 
2.41.0


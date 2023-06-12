Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694F672CE09
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 20:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237879AbjFLSZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 14:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237855AbjFLSY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:24:57 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF66E7B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:24:56 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f624daccd1so5290685e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686594294; x=1689186294;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M/J5ZhP262QYGYmarLd4yzENGlRt7ikJiCOlHTeoidM=;
        b=IoVMD+TiuZhJrqc7PYQ7KI1ovsCwOXa745dfeJW1GQPxD82LaWmBb1suS9dFnCtpMJ
         4su7szZfcCP4vHzdF3b8+yTY91TtMjZBnWtx9BrHgZwXOqXAAzNGKyK7SKc9OolIZnLA
         GB3e+IR2/8FV7tQAwGKbj64cq9JT+vCj9wAhEKQ8mDIy05wtpMOqzDsCCyYyzdE2sNog
         xXdrjaLwcBjB4i+t3Zoc9XJwsh9vsJHTsNwGhH/QjrW4MGtNxqyP6xciAJ8TRweF3m9V
         d5/lghZHvzyHhs3o/FPKYSGYQbgBqR4pEeagMvkTeGJNuOiLp0UiN/Yc4vJ63Ark4YoM
         F1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686594294; x=1689186294;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M/J5ZhP262QYGYmarLd4yzENGlRt7ikJiCOlHTeoidM=;
        b=AqhtK6IBIyn4ICWX4WDZAwwRdMHD2ZGNVlTrDpRId82ak384Kt3yEg9StDUpZ4FReQ
         MzMDiE12R5KLZQCU4n7IQRfzpwpEO0o/WK1C/nbV0dWaGdq0zhpdwDPWpF+kV4bXoBpO
         2LHQJMXT6oe7ukNIKWOEnHhB2i+nei+TZ5WP0qSpEHeflPPJbXH7KsfkBjQYrkZSpf79
         39SfoJv6Thewxby7leIY764E0hXAiz3KE8DWZkVkkIrQPvdKbFHXoq2MotjAYGHllxXh
         N5ibN1f8k2R3d80zcbYe+P8+BrQX6vkio5s3nkXTaObav2fYC7M+EUT8Bxw9bEbPyxMs
         riog==
X-Gm-Message-State: AC+VfDwor/XVwmOxGBvJTLkAzMvlMjkzRTEeU7zUftTq8MSi19OX5mkJ
        IgcmzjE4iN6qi+epnxYBrMYyTQ==
X-Google-Smtp-Source: ACHHUZ7cwaR5Q6auBM4qJKXBqv9ZIk8twc79awvU5CzzmPOkzljIla4zqkCq1XApGHnZzJCr69oKEA==
X-Received: by 2002:a05:6512:32ad:b0:4f4:b3a6:4140 with SMTP id q13-20020a05651232ad00b004f4b3a64140mr3521735lfe.42.1686594294494;
        Mon, 12 Jun 2023 11:24:54 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id v24-20020ac25938000000b004f64073a252sm1502035lfi.96.2023.06.12.11.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 11:24:54 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 12 Jun 2023 20:24:29 +0200
Subject: [PATCH v3 12/23] interconnect: qcom: sdm660: Hook up RPM bus clk
 definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v3-12-5fb7d39b874f@linaro.org>
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
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686594276; l=1986;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Krc2Kcr5fnOQoU3m0Y+nr01slcqtM3Q1E0UfX4Ye6Q4=;
 b=2b/6IkjpCVKop7AxhdWXBvUWfBCet//VkgmSPfHfy9/tAb7joqNwWZfuErOaQBTMCHZ4ldl5y
 8uuZqPW3SYkARThKexAzyqY3OElO4UfWWvZPrJo9AsdqEXfpaRasoAi
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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


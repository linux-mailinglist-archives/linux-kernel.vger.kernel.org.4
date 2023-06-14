Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BB972FA8E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 12:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243543AbjFNKXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 06:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243658AbjFNKWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 06:22:51 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C831FEB
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 03:22:34 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b1bb2fc9c6so7186831fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 03:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686738152; x=1689330152;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M/J5ZhP262QYGYmarLd4yzENGlRt7ikJiCOlHTeoidM=;
        b=v2MHZSAmdCY1jxaU76t23pZlTIN3OZBsLFqngY17L2Te5kGRho8H1FPfO0rJN+FiWE
         nJNrL2IZmbppldKWzIAzT4x3hAXvgwA9gPr9HgUjTor1MWD7dSGpP+ppC7wFBLAKNhT4
         BQBKlQHqxcHJ0n/mifs6nRWNoPhHc31l4Ci2joXzgVTm2T6Qwb7IRgGHVesfxcLt5sOc
         xwESNYNDO9FAxO4Jo/fSlBn/hpgGlBtRL3ChzAXIGcDUTuxIcH7QmFYmBx4kjXQ7tG8Y
         zC9XlpamHjYn6G9OVjeqhM9Td4fqyJ+Vq+UY5ZO1fpLPX3kLEbsaTdSL1MQlqBmLV+x7
         uWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686738152; x=1689330152;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M/J5ZhP262QYGYmarLd4yzENGlRt7ikJiCOlHTeoidM=;
        b=BWIVVBra6GDzmY3unyFHBvRqChuqcczUaFnbdM7hZvykOCHBC6a447/hkQyYBcmuPq
         /Mb1pM9lXZs1iPmCtL0dDzW3lX1a6FpcR6fxXEuqb8CuagleFv6MO9pwW1IBkf5Ba2Q5
         xKon9MvQ8WxjGlWM8y26O6hzIK/DaVBGmzFPeONG4VLhgJ14Oa00nvLqXxiEogcvuIqU
         jeuZ4ubH0e5sOG6hzXgfAJB8t/TsLckkH045D+cGTwW5ArEMI/HLEUSBkaHn9DD1lkGR
         vYU7+JMHVMAhIPQ4SkyouMYzKEXKSfDKjDJgrUg3sa8uUmakRwZryeEHqweOtLMFiMlt
         on8w==
X-Gm-Message-State: AC+VfDz+gFIMFGo6RkSlz1K5jJkt4JeoPwFWQUGJ0O6IJ+3vClajO17d
        JT+7XV1ZagS9Zd9tNKD7Oiy64A==
X-Google-Smtp-Source: ACHHUZ6F+ohHaPW12tUuIzzR84Of9eLKOH3oT26IFWPvIO6KfLP2tdAdMjOOinm8ksCe376+XsfXzA==
X-Received: by 2002:a2e:9ace:0:b0:2b3:4d6c:4611 with SMTP id p14-20020a2e9ace000000b002b34d6c4611mr432171ljj.28.1686738152504;
        Wed, 14 Jun 2023 03:22:32 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id m2-20020a2eb6c2000000b002b20d8f270asm2520057ljo.74.2023.06.14.03.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 03:22:32 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 14 Jun 2023 12:22:22 +0200
Subject: [PATCH v5 11/22] interconnect: qcom: sdm660: Hook up RPM bus clk
 definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v5-11-eeaa09d0082e@linaro.org>
References: <20230526-topic-smd_icc-v5-0-eeaa09d0082e@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v5-0-eeaa09d0082e@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686738135; l=1986;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Krc2Kcr5fnOQoU3m0Y+nr01slcqtM3Q1E0UfX4Ye6Q4=;
 b=gcRKAZ00Zx2FfDG+RB6VUff6nvFk6ciWAcAiVrgABBxapivdGn/I2ZkplprvoI5SUdYJ9kVlU
 p+2fKMn2d1oA7rOKBpW6m5m3/Vw2il+Q7+/vVtBz9XmzrMLWeDpcxr4
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D757357F2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjFSNF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjFSNFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:05:12 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE89173F
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:04:55 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f87592eccfso608223e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687179893; x=1689771893;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xSfPNWyiQLrjAB0czC11oTpbsDGKiNFbaeuQIkEjCow=;
        b=HDVwBSk7HrLHJ5K7tyDrDuTO+kUpTslhW5lYMSdVM7/VOuKdzyAbHnNpbKCbsW8uGf
         AvOagpjkcpgIPRsDE0/7Y6MG7nL213Nzii1NmS/sw3jv/oN/1DvH7fn1BR4yJao/e47k
         y5KDt3vWad5q1P8miedwoIQU1ngYlUqxpHmYe1fD1os3Hv3dTb5IgvYkhmkCbbitUsxc
         mrdSrUGU0dIVYDYn9MKtLRkwGp+9i0RVZqnkC3Kiqt56ChZkA9N9uc+fccd7+zcrHy7I
         O4WDEjaNrqJQeCgTUaIBFJ0lBjsnh0AU0HlscYSY+Qz5LPgrze5nRbRAqn2kY6JBmIfN
         rTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687179893; x=1689771893;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xSfPNWyiQLrjAB0czC11oTpbsDGKiNFbaeuQIkEjCow=;
        b=YPHGj0S2ddHKhmn4LKitGoQMtJZqECSbhUwvjdvgktQpVK4MKsTjrfDqYpaZvBV4tG
         aB8ZdKQt1Xk3AEk6LaZNGzFn74sxvnMAXsLgGGPgM7NbfVBUqog1/GU7jy1xUXGbT/Bx
         IHrh4GpsB2/2TG+8gaaMIrpEVLyzCY0d6eZnSu2iuQ7QlzjxWyUrFZhtIY2kbQYho4Aa
         8Jr+q6brFunbjPixpNoMHNDEavymRjqScmlqb4MfxhqAseQY+AHcXTC02Thl3u4zn58t
         xjwekjc/wyxw4cPXutDoZd5wXP9J1bNxQeCRPfnYwZfcv0dPjroLE8hvGAp2TSDPourm
         cI9g==
X-Gm-Message-State: AC+VfDzqQlpgcXE5eoRU6vrulTo2PysrwuSsSDCqT8YTUKqp8TtWOs7N
        ztijGHDGv3udzeKS+aUA97W/lQxpT729t1QTyP4=
X-Google-Smtp-Source: ACHHUZ6vL89fKhJ04n4DkanqPRCvzcoXUpa7IF/29Z3VYQAw5c3dxtfwI84FGh3YNTZTUV113hhjBA==
X-Received: by 2002:a05:6512:54a:b0:4f8:5854:6e70 with SMTP id h10-20020a056512054a00b004f858546e70mr5904546lfl.12.1687179893662;
        Mon, 19 Jun 2023 06:04:53 -0700 (PDT)
Received: from [192.168.1.101] (abyl242.neoplus.adsl.tpnet.pl. [83.9.31.242])
        by smtp.gmail.com with ESMTPSA id q28-20020ac25a1c000000b004f643664882sm4256489lfn.147.2023.06.19.06.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 06:04:53 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 19 Jun 2023 15:04:39 +0200
Subject: [PATCH v7 14/22] interconnect: qcom: msm8939: Hook up RPM bus clk
 definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v7-14-09c78c175546@linaro.org>
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
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687179869; l=1734;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=ptXNaQOaty1z4TDLkDcxe3GA9UIR7yqJkXzhnEP9xnw=;
 b=xJoUi9iZAiWf0BlgNdPAG1AD7RqfP/mBHzbO6u8mBRMrI+B283wQO3RuKOoiAJIF86J01hrOw
 9y5ULpZQ+u5BR8qOPdSvnYwVRHhjq6Umg/g2TphDEMjtwrwuJfCMHYT
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

Assign the necessary definitions to migrate to the new bus clock
handling mechanism.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/msm8939.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/interconnect/qcom/msm8939.c b/drivers/interconnect/qcom/msm8939.c
index b1005dee4e38..6732eeeb8158 100644
--- a/drivers/interconnect/qcom/msm8939.c
+++ b/drivers/interconnect/qcom/msm8939.c
@@ -1283,6 +1283,7 @@ static const struct qcom_icc_desc msm8939_snoc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = msm8939_snoc_nodes,
 	.num_nodes = ARRAY_SIZE(msm8939_snoc_nodes),
+	.bus_clk_desc = &bus_1_clk,
 	.regmap_cfg = &msm8939_snoc_regmap_config,
 	.qos_offset = 0x7000,
 };
@@ -1303,6 +1304,7 @@ static const struct qcom_icc_desc msm8939_snoc_mm = {
 	.type = QCOM_ICC_NOC,
 	.nodes = msm8939_snoc_mm_nodes,
 	.num_nodes = ARRAY_SIZE(msm8939_snoc_mm_nodes),
+	.bus_clk_desc = &bus_2_clk,
 	.regmap_cfg = &msm8939_snoc_regmap_config,
 	.qos_offset = 0x7000,
 };
@@ -1331,6 +1333,7 @@ static const struct qcom_icc_desc msm8939_bimc = {
 	.type = QCOM_ICC_BIMC,
 	.nodes = msm8939_bimc_nodes,
 	.num_nodes = ARRAY_SIZE(msm8939_bimc_nodes),
+	.bus_clk_desc = &bimc_clk,
 	.regmap_cfg = &msm8939_bimc_regmap_config,
 	.qos_offset = 0x8000,
 };
@@ -1402,6 +1405,7 @@ static const struct qcom_icc_desc msm8939_pcnoc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = msm8939_pcnoc_nodes,
 	.num_nodes = ARRAY_SIZE(msm8939_pcnoc_nodes),
+	.bus_clk_desc = &bus_0_clk,
 	.regmap_cfg = &msm8939_pcnoc_regmap_config,
 	.qos_offset = 0x7000,
 };

-- 
2.41.0


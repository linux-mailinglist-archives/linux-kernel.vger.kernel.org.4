Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E7A7357D6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjFSNFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbjFSNFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:05:01 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033EB170C
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:04:50 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f875b267d9so568955e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687179889; x=1689771889;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gMhyB/RpDb2yjDqD1QrZgIdZflFbKzp97wvcFuesnD0=;
        b=I6KMlKvdAQLVXKpeVpkOo/ucqQ2ipiNDmmBa9w5pAZZLskEY7zCfqdXSlVtKDUWP+3
         0SJ9eyY4oPuhn9VU3tTodcH/6cr/xvSfI4ZtUiG+NENFQunqL4Mo+4B5Ajw66Jjp9X74
         WaLFRn9BOjAcW47DGgDuoWafde3tSVY8jOdpMwwzaxKzdxJ595S270V9nnrciNGFfHsc
         CaxwJivcZIvfKv/MgnIVAadyPF54NK/zYnCXc8NcgEndWQ61UrGvHBmL9j9FqULzU+hT
         bpuGpR72QCavyMg/kQzfgYCFqr+T6ZdH6GGi25u4UGo70R4mwiViupBjmLXHABWpOMLb
         kPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687179889; x=1689771889;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gMhyB/RpDb2yjDqD1QrZgIdZflFbKzp97wvcFuesnD0=;
        b=fWw6dy2fBizDzK6bcnQPTaGaofoe8noEtsDGXJpY+0y3UrsMK+IMkBsqZSIxx/vS2d
         kcy4wAn/vYeBCKOiHdX6u3SlFsh/SjYaF3Qdj4Q05N6He1j0c9Eo//mMVAKoZUxcBQRj
         mOPoGhUZ2wwH/jDALvjxobsUyaobIvWSmQ5E9vsL+LxKqAYHDzuAd2Kbad2ZNMIRyBiH
         YqQLD2AiDE9XGuQxvSj1ChnKKhxuKaoK92S7js/zUYrzoBvED+7pBa00uQWTpXw3RfrS
         cJjykuf557j6Ukzza9bXf2e/zvQVzO/Bvbas5SnNjMSJ47nLMKj/iHPZNfcgOVkxMOmL
         yJYQ==
X-Gm-Message-State: AC+VfDzNOhowfjisj0qxUQBdL2NUb+idiPzKuiaDOm+Jg67v5fEJ3/Ty
        UJS51HAHtyaSRun/ux7dFeQBqg==
X-Google-Smtp-Source: ACHHUZ70gdluqdTH+bZPnT7f46B1U7qqY+ZNp36+/HvcKrLiGXF1+ZrMJzKvpRd/cGa+gUZoEMcf8w==
X-Received: by 2002:a19:7b05:0:b0:4f6:d9e:7c3b with SMTP id w5-20020a197b05000000b004f60d9e7c3bmr5368612lfc.44.1687179888721;
        Mon, 19 Jun 2023 06:04:48 -0700 (PDT)
Received: from [192.168.1.101] (abyl242.neoplus.adsl.tpnet.pl. [83.9.31.242])
        by smtp.gmail.com with ESMTPSA id q28-20020ac25a1c000000b004f643664882sm4256489lfn.147.2023.06.19.06.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 06:04:48 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 19 Jun 2023 15:04:36 +0200
Subject: [PATCH v7 11/22] interconnect: qcom: sdm660: Hook up RPM bus clk
 definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v7-11-09c78c175546@linaro.org>
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
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687179869; l=1986;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=xMlMRTkT4oZ3O3DhlrRW9yoPIGqYk7SOo/vjpjmWPac=;
 b=NX6gNFdaQVWI5b1jE6gxKuqQ0P6sZ2KPzy+HJcQoturYWlvUIcUjBHdq1szjcjq/j9ua5Ztm7
 iWLr6Z/6fXrAPqZ7uitgjKnDwhV68UOd3B6/XRdzX3ULNTuulEx8QlE
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
index e7bd86808f13..ad5d52af7eab 100644
--- a/drivers/interconnect/qcom/sdm660.c
+++ b/drivers/interconnect/qcom/sdm660.c
@@ -1510,6 +1510,7 @@ static const struct qcom_icc_desc sdm660_a2noc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = sdm660_a2noc_nodes,
 	.num_nodes = ARRAY_SIZE(sdm660_a2noc_nodes),
+	.bus_clk_desc = &aggre2_clk,
 	.intf_clocks = a2noc_intf_clocks,
 	.num_intf_clocks = ARRAY_SIZE(a2noc_intf_clocks),
 	.regmap_cfg = &sdm660_a2noc_regmap_config,
@@ -1538,6 +1539,7 @@ static const struct qcom_icc_desc sdm660_bimc = {
 	.type = QCOM_ICC_BIMC,
 	.nodes = sdm660_bimc_nodes,
 	.num_nodes = ARRAY_SIZE(sdm660_bimc_nodes),
+	.bus_clk_desc = &bimc_clk,
 	.regmap_cfg = &sdm660_bimc_regmap_config,
 };
 
@@ -1592,6 +1594,7 @@ static const struct qcom_icc_desc sdm660_cnoc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = sdm660_cnoc_nodes,
 	.num_nodes = ARRAY_SIZE(sdm660_cnoc_nodes),
+	.bus_clk_desc = &bus_2_clk,
 	.regmap_cfg = &sdm660_cnoc_regmap_config,
 };
 
@@ -1654,6 +1657,7 @@ static const struct qcom_icc_desc sdm660_mnoc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = sdm660_mnoc_nodes,
 	.num_nodes = ARRAY_SIZE(sdm660_mnoc_nodes),
+	.bus_clk_desc = &mmaxi_0_clk,
 	.intf_clocks = mm_intf_clocks,
 	.num_intf_clocks = ARRAY_SIZE(mm_intf_clocks),
 	.regmap_cfg = &sdm660_mnoc_regmap_config,
@@ -1691,6 +1695,7 @@ static const struct qcom_icc_desc sdm660_snoc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = sdm660_snoc_nodes,
 	.num_nodes = ARRAY_SIZE(sdm660_snoc_nodes),
+	.bus_clk_desc = &bus_1_clk,
 	.regmap_cfg = &sdm660_snoc_regmap_config,
 };
 

-- 
2.41.0


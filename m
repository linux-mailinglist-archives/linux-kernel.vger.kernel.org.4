Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8DA715B91
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbjE3KVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjE3KUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:20:35 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3201E18F
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:20:21 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f3edc05aa5so4646071e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685442019; x=1688034019;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H7DWmLCdGqEf/q+BMZEZlk7majE2RGgcVcA51zytv0E=;
        b=jnzwK7Y9luGgg7vOaaVdy4c3PCxiP6bYBsrRVl2fvvziExdnJ6kEZAPM8wj7EdH/Lq
         JkyHwVafSkeMm2L6vzGcj9BPvCqx3CWyzrslSQPp4wv2GWzIJVUbyyOFO5cD9O/Fju9y
         uUGfGPNhZKYypMDkZ+7FD16reAQtR7q3SWzv464Xa45HA3CCpySn743iZkUfmLq9So2d
         WIs6GsN5bgLsyFiGcQMN9CeY5PGd5q0VhCv0ClVllNa2/V3VN/yTigAUiJoe+B03hs8D
         NWzLxn+KpzSYYbrwohD6hV+MJU545KrhhAVAEmYR0jIuLFHptO/wunAJvSf4nSeB6qBQ
         hbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685442019; x=1688034019;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H7DWmLCdGqEf/q+BMZEZlk7majE2RGgcVcA51zytv0E=;
        b=gomTQhrLbMnGt9oarQFvXPqv7ijOGgOhkjgMaKXusILTcr66tle48Ilin62gjU3kL4
         dEsClFvZq4/ywoSgNsW3UwOPCQPGGegsAh3UOru5SRhSadUZH7uE2IzoLliUDM3wvxPE
         vQwV7Ln9wErooV1aBnv6DR9Now/ZiKlii4WPiO6UiMdWIqBE/DVhGi+bGhgrp8yKQSTc
         YvTM/HxsOMpEcxPf8qRhakG7oXkdsZNv90rnH3dDKYwQTMSzzFoCxKdHQIg7Tuk+upMa
         PEMYWW2v0ZA/wh1rwmV6OHzxKcb39hyP2ZLCVOAx4TLihcwf47nRywYA09FWJF3CeUBo
         Mnjw==
X-Gm-Message-State: AC+VfDx77lLVCGTOGnAPWFE5w8VTfDsFR6rmh1v9Txyv0l31+62EghCX
        WmqnWAZbMHo2iHmjmt2rUr3GyQ==
X-Google-Smtp-Source: ACHHUZ5Q2oRW7zjh2J9Bk7Y8CRhlFRKmiHWvNNxhyh3VI2PaSYq306zJic61KK3Z7BTCHj5rft4JVA==
X-Received: by 2002:a19:f014:0:b0:4f3:b0e1:feba with SMTP id p20-20020a19f014000000b004f3b0e1febamr478349lfc.16.1685442019523;
        Tue, 30 May 2023 03:20:19 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id c25-20020ac24159000000b004cc8196a308sm290902lfi.98.2023.05.30.03.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 03:20:19 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 30 May 2023 12:20:11 +0200
Subject: [PATCH 12/20] interconnect: qcom: msm8996: Hook up RPM bus clk
 definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v1-12-1bf8e6663c4e@linaro.org>
References: <20230526-topic-smd_icc-v1-0-1bf8e6663c4e@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v1-0-1bf8e6663c4e@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, Evan Green <evgreen@chromium.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685442001; l=2380;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=TaIfixyKBYRQeIS1br7snYRsSDaKvcJKwpT4t95RY0U=;
 b=Rp0EzNYLsPzprtxcz/msPWgT1ZpddZfE7cxNvahSENIVKvfmALP/647gy7kwrymjPUBCd2MKl
 IxspyATxmaiAM8z1kD/CEss/jjjEEkxKnAij68goIANCW1WNJsjNUTi
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

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/msm8996.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/interconnect/qcom/msm8996.c b/drivers/interconnect/qcom/msm8996.c
index 1f7e88a37acd..a596f4035d2e 100644
--- a/drivers/interconnect/qcom/msm8996.c
+++ b/drivers/interconnect/qcom/msm8996.c
@@ -1840,6 +1840,7 @@ static const struct qcom_icc_desc msm8996_a1noc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = a1noc_nodes,
 	.num_nodes = ARRAY_SIZE(a1noc_nodes),
+	.bus_clk_desc = &aggre1_branch_clk,
 	.regmap_cfg = &msm8996_a1noc_regmap_config
 };
 
@@ -1861,6 +1862,7 @@ static const struct qcom_icc_desc msm8996_a2noc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = a2noc_nodes,
 	.num_nodes = ARRAY_SIZE(a2noc_nodes),
+	.bus_clk_desc = &aggre2_branch_clk,
 	.intf_clocks = a2noc_intf_clocks,
 	.num_intf_clocks = ARRAY_SIZE(a2noc_intf_clocks),
 	.regmap_cfg = &msm8996_a2noc_regmap_config
@@ -1889,6 +1891,7 @@ static const struct qcom_icc_desc msm8996_bimc = {
 	.type = QCOM_ICC_BIMC,
 	.nodes = bimc_nodes,
 	.num_nodes = ARRAY_SIZE(bimc_nodes),
+	.bus_clk_desc = &bimc_clk,
 	.regmap_cfg = &msm8996_bimc_regmap_config
 };
 
@@ -1947,6 +1950,7 @@ static const struct qcom_icc_desc msm8996_cnoc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = cnoc_nodes,
 	.num_nodes = ARRAY_SIZE(cnoc_nodes),
+	.bus_clk_desc = &bus_2_clk,
 	.regmap_cfg = &msm8996_cnoc_regmap_config
 };
 
@@ -2000,6 +2004,7 @@ static const struct qcom_icc_desc msm8996_mnoc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = mnoc_nodes,
 	.num_nodes = ARRAY_SIZE(mnoc_nodes),
+	.bus_clk_desc = &mmaxi_0_clk,
 	.intf_clocks = mm_intf_clocks,
 	.num_intf_clocks = ARRAY_SIZE(mm_intf_clocks),
 	.regmap_cfg = &msm8996_mnoc_regmap_config
@@ -2038,6 +2043,7 @@ static const struct qcom_icc_desc msm8996_pnoc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = pnoc_nodes,
 	.num_nodes = ARRAY_SIZE(pnoc_nodes),
+	.bus_clk_desc = &bus_0_clk,
 	.regmap_cfg = &msm8996_pnoc_regmap_config
 };
 
@@ -2082,6 +2088,7 @@ static const struct qcom_icc_desc msm8996_snoc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = snoc_nodes,
 	.num_nodes = ARRAY_SIZE(snoc_nodes),
+	.bus_clk_desc = &bus_1_clk,
 	.regmap_cfg = &msm8996_snoc_regmap_config
 };
 

-- 
2.40.1


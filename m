Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE18715B86
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjE3KVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbjE3KUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:20:34 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1703318D
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:20:19 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f3ba703b67so4597181e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685442018; x=1688034018;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+B8gq4FhTGSZrB+kw6Qd/r8F/i9IYutgD+JnX420HFQ=;
        b=eL1UTD0UpVt90ToQw4QyFFC5lY/mzC9cNc/pOokWhSFw+7sYmrmeDGZXak7ccr6Wo9
         6XC+xL6Z/04f7J8XSb6U63bTpC4GjiUPDtXx3Tnx0NNh0ZeTTjNl6oATNlvb7DYlWmMH
         NXW1d6jD6EJhvxt+7oi6BzQz/Tiq3yoCf/JdrHBFtCGSf0XJlfK0HhDsLJACFO62R1hR
         FFc9v0da7fhXHXnPSRF/sdHpzzF+wRpnYrzlYmOZMIRE8BrEoQgWw+foy86ZAvP5PlTL
         ieLYILf+EWB4nMBXogHxgRi95HbdqlszkmQkfiO87Smt4kZPYsFgHhRjgEOSHgK4UohT
         3MRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685442018; x=1688034018;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+B8gq4FhTGSZrB+kw6Qd/r8F/i9IYutgD+JnX420HFQ=;
        b=KDC4xg5HNjrUTJYTycS5yS3kxli79fz+KLzj8Acmb7M6vBHsm+SFIlHzRUOBhat8tr
         uzRtN7IguBhvwS0tcwV3SGALch7VcMItZnjeYJ3i18mO/sZ4Ot0p0zAQVPjRou2V4ovG
         L1HwOFn3gQXONfTV9sfY6A/qKExSf6/wG52bLv9sZ9eJPECDmSL0V8QVgTbj1NZAWQUi
         3+NIkjx5UexLyBq9um8OfPN75SuLLQ45nh9gX7ROiCsxZ+Dx+RR/dxMknmR62nz1hcRl
         dHysOZ77k+/CIOfFCF+KMotJY87PnZqaZM/5gD4ofYJFJ2TWhk+At5q09Im0el/VXBzj
         qV2A==
X-Gm-Message-State: AC+VfDxVOmVdFCEgszK2ID1B7ccA95IKb9F+5ZVJ2QoT2Aa10NIjfrbq
        l0uvjEsJ/vOlNnR7NPTzXomZ4g==
X-Google-Smtp-Source: ACHHUZ5p6wqaKnA+jgzgFUP9x/NY5u2XoA0x5nT1uozvgd1eHbwh4GMtXB31WDcHH83gd03XEsKqLg==
X-Received: by 2002:a19:ae09:0:b0:4f3:a820:dd98 with SMTP id f9-20020a19ae09000000b004f3a820dd98mr511394lfc.7.1685442018322;
        Tue, 30 May 2023 03:20:18 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id c25-20020ac24159000000b004cc8196a308sm290902lfi.98.2023.05.30.03.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 03:20:18 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 30 May 2023 12:20:10 +0200
Subject: [PATCH 11/20] interconnect: qcom: sdm660: Hook up RPM bus clk
 definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v1-11-1bf8e6663c4e@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685442001; l=1925;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=l3PUrbf2IpVVC4OrI1ps60fu75U4WFEl/eEO2eEzYSo=;
 b=tgIYZox4aB/s0xN4595qERFWi7YVOY0SBoSCRi7Qh7LlAjb6hkXyMYfdynSCD1IJ43FelINFx
 20L+j26Kje1CB6XP8U7/y+Ie+5zY7ZqBRQXiN18pP4413H1NL7rORBl
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
2.40.1


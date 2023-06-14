Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF7972FC8D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244083AbjFNLf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244050AbjFNLfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:35:52 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248231BF3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 04:35:51 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f63006b4e3so8396200e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 04:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686742549; x=1689334549;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GgG/M1SdADb+CjPujPqNKA6Um2dIkmunogTu3ghoPwU=;
        b=JPQOJ7GBzRg4+++Tk8jOeJWHuz89DMz5L2yRUw7DboCRZNnZAyh5VyDNqZrhdBUcHa
         eZJB+ZsUw9/I+JF0ipDZvEF8HDngp76ZiXOJ/VhekYngSPgLWuCp+IebZEJOOMbTGNDe
         kGFuJB8DjVPD3op5/kSvFi/dVcclVtT9NSGjESElDd/J3BExyM4XWemCtoTUFUPcnMyI
         lcK0KSufCoH5qGhnKvMEHPji1VIV8hV3a6DnMz2bY1pZG3scaLYqDGkY6QDz1HFjXUHm
         NnVZPAXVv2u0SOjL7D9OG1YPwT1JC59C/s6dyH0eQeUZgGibA1/7BO/sWH6ZK4gun3M0
         1mRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686742549; x=1689334549;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GgG/M1SdADb+CjPujPqNKA6Um2dIkmunogTu3ghoPwU=;
        b=TuZgP9pKMGu8X2jpmCdZMv/jRsUZn5FZkUhtDoqEmHZ2q2bS3Zp+YQDaILuKTdsAO/
         urDryWiuEY1ud2THSgiRYsWE3kc6Y7WwOIX25HygcCodvkGorylmWPnhsLMJdxFCbEp4
         d3yXKnfBKLGM/BnlAz9YqfE9vjjSTP3sxjDmM5OzBB59qoJRrmMR8nqMZn19S7E4lOaT
         qDq+jne1wwVEN2hKKZO+QlQPHQzwDLDp3UfLxzcWrFxCnEZ6k+sIyQNDfbz1Qu3AV4vQ
         GAu870tHc2F+uBdEjUi4AUsqWgaxupEXrp4yGnnj5dlwzWkrnObZGiI/smMvsClIBcMj
         bx9Q==
X-Gm-Message-State: AC+VfDyI2Z1O9CZprg4wWmoLGDz3U7jjma0/du9QvVM8pieYdcGwqATp
        BAJ9jed06dKlIpyZZ+1ofi45xg==
X-Google-Smtp-Source: ACHHUZ4oQaFWwTY451PXFB29BsRrMgGvYB+CIFZrHN9pYl1l7/9xk3nBom7r1SWohRqLqAGvBWx1aw==
X-Received: by 2002:ac2:5592:0:b0:4f6:1722:d737 with SMTP id v18-20020ac25592000000b004f61722d737mr8441604lfg.9.1686742549348;
        Wed, 14 Jun 2023 04:35:49 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id x1-20020ac25dc1000000b004f64b8eee61sm2088406lfq.97.2023.06.14.04.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 04:35:49 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 14 Jun 2023 13:35:32 +0200
Subject: [PATCH v2 1/7] clk: qcom: gpucc-sm6350: Introduce index-based clk
 lookup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230315-topic-lagoon_gpu-v2-1-afcdfb18bb13@linaro.org>
References: <20230315-topic-lagoon_gpu-v2-0-afcdfb18bb13@linaro.org>
In-Reply-To: <20230315-topic-lagoon_gpu-v2-0-afcdfb18bb13@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686742545; l=2501;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=TaMoHmTX5YmIOUIdAoElMKm2cSA2iQeh1gPxDTztMHU=;
 b=SuDstwjNjC4hB4jFdESHz9+jus8boaBzbYU+NNQHiLZongyDXxnapKuBEHAt5EBMcs95Y2i/H
 TdQqQNj02JUCwkN8winp20RjQqBJuUrth0siHnCXo/wmoKj7gHVe7RQ
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

Add the nowadays-prefered and marginally faster way of looking up parent
clocks in the device tree. It also allows for clock-names-independent
operation, so long as the order (which is enforced by schema) is kept.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/gpucc-sm6350.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/qcom/gpucc-sm6350.c b/drivers/clk/qcom/gpucc-sm6350.c
index ef15185a99c3..a9887d1f0ed7 100644
--- a/drivers/clk/qcom/gpucc-sm6350.c
+++ b/drivers/clk/qcom/gpucc-sm6350.c
@@ -24,6 +24,12 @@
 #define CX_GMU_CBCR_WAKE_MASK		0xF
 #define CX_GMU_CBCR_WAKE_SHIFT		8
 
+enum {
+	DT_BI_TCXO,
+	DT_GPLL0_OUT_MAIN,
+	DT_GPLL0_OUT_MAIN_DIV,
+};
+
 enum {
 	P_BI_TCXO,
 	P_GPLL0_OUT_MAIN,
@@ -61,6 +67,7 @@ static struct clk_alpha_pll gpu_cc_pll0 = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gpu_cc_pll0",
 			.parent_data =  &(const struct clk_parent_data){
+				.index = DT_BI_TCXO,
 				.fw_name = "bi_tcxo",
 			},
 			.num_parents = 1,
@@ -104,6 +111,7 @@ static struct clk_alpha_pll gpu_cc_pll1 = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gpu_cc_pll1",
 			.parent_data =  &(const struct clk_parent_data){
+				.index = DT_BI_TCXO,
 				.fw_name = "bi_tcxo",
 			},
 			.num_parents = 1,
@@ -121,11 +129,11 @@ static const struct parent_map gpu_cc_parent_map_0[] = {
 };
 
 static const struct clk_parent_data gpu_cc_parent_data_0[] = {
-	{ .fw_name = "bi_tcxo" },
+	{ .index = DT_BI_TCXO, .fw_name = "bi_tcxo" },
 	{ .hw = &gpu_cc_pll0.clkr.hw },
 	{ .hw = &gpu_cc_pll1.clkr.hw },
-	{ .fw_name = "gcc_gpu_gpll0_clk" },
-	{ .fw_name = "gcc_gpu_gpll0_div_clk" },
+	{ .index = DT_GPLL0_OUT_MAIN, .fw_name = "gcc_gpu_gpll0_clk" },
+	{ .index = DT_GPLL0_OUT_MAIN_DIV, .fw_name = "gcc_gpu_gpll0_div_clk" },
 };
 
 static const struct parent_map gpu_cc_parent_map_1[] = {
@@ -138,12 +146,12 @@ static const struct parent_map gpu_cc_parent_map_1[] = {
 };
 
 static const struct clk_parent_data gpu_cc_parent_data_1[] = {
-	{ .fw_name = "bi_tcxo" },
+	{ .index = DT_BI_TCXO, .fw_name = "bi_tcxo" },
 	{ .hw = &crc_div.hw },
 	{ .hw = &gpu_cc_pll0.clkr.hw },
 	{ .hw = &gpu_cc_pll1.clkr.hw },
 	{ .hw = &gpu_cc_pll1.clkr.hw },
-	{ .fw_name = "gcc_gpu_gpll0_clk" },
+	{ .index = DT_GPLL0_OUT_MAIN, .fw_name = "gcc_gpu_gpll0_clk" },
 };
 
 static const struct freq_tbl ftbl_gpu_cc_gmu_clk_src[] = {

-- 
2.41.0


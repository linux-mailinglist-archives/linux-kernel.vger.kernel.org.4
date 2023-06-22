Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE61773A04B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 13:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjFVL6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 07:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjFVL6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 07:58:01 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDB6199D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 04:57:55 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f8777caaa1so5228230e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 04:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687435074; x=1690027074;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XYM9GLuG18nnF6nHkBdPR8db3X7aGOtPbmA0W8Oaw2Q=;
        b=tWkFXXf+LTDED7jkEwbL2slXesxdxMJvvZvoJYzrsrSSw1F7bGh/adUXo7/Tj5cwbM
         f4NLqqdbnanr3aBp1sHLkxnoIFFz29Uf/yBk1Q9sglNtkGpOdlgmlwkSUSXTix3LowPu
         8cEswdLY/S2812g1LAhAB0oAy2qR4R8uqCTv2FrVMUTA6E91JQ4gYOyGZQMKtsRcP03K
         ZCv2VdEoW8sZGFs4NGVa9itbBfNpvDfZ9L8VhQ0LmLE8gYHCe/vJH9tPll5HmUwrTjdS
         qJzIfIHo2py+RKodM4bh8Mwc/OBW/DZ0aTTp3xqnerKrIDi5rIlkKizVkAy/vUgvzMjO
         L2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687435074; x=1690027074;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XYM9GLuG18nnF6nHkBdPR8db3X7aGOtPbmA0W8Oaw2Q=;
        b=XnCMqzGWsyKoQKpXePuVJAO9035201F+KLfJeReoOffCSHYPzcytx7cKRX8myBnFHB
         OTtI8T7lbq6/4pB21H43IcXgKv8Ef653La2ojQoEDXZtnu9zNBexv+n3AoUAaRgE+BGd
         2YZArcWPoOI46eyLPGxtfXRGG9s6FrFGbz+g826khgjfu7W61zoFaKjtXfPw3nc+/kvz
         YWN8nd+qDt+W3NUdDqUENtIkUb2z/IN7vvcy7wpC8mq8bp9GZ2AnyZPq9zbRZzDaOsbG
         vL7UeqyreRnJ8ua3utXy8V2/17rJvT1oiZ6y1XoIULwySq0sTWUmQnshBZWLXUxet2vK
         Vv0w==
X-Gm-Message-State: AC+VfDyfkDOtOVqQnzzV+c9nWjAblFIOVsyCsj68x3ThnyaM0YXGbUtH
        5sLseAj8ukODoLd3wZaBwhgzrg==
X-Google-Smtp-Source: ACHHUZ4qVrHL+YSwHiVrb+HnqDjSHNEWp2KJiGGHV/+lMxTrvL0l+xnqGmwgn2g9qXb9i4+Nj7dL8A==
X-Received: by 2002:ac2:5f96:0:b0:4f8:7895:a1a7 with SMTP id r22-20020ac25f96000000b004f87895a1a7mr6210191lfe.6.1687435073738;
        Thu, 22 Jun 2023 04:57:53 -0700 (PDT)
Received: from [192.168.1.101] (abyl165.neoplus.adsl.tpnet.pl. [83.9.31.165])
        by smtp.gmail.com with ESMTPSA id eq21-20020a056512489500b004f4c3feb9fbsm1099235lfb.61.2023.06.22.04.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 04:57:53 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 22 Jun 2023 13:57:44 +0200
Subject: [PATCH 4/9] clk: qcom: mmcc-msm8998: Properly consume GPLL0 inputs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230622-topic-8998clk-v1-4-5b7a0d6e98b1@linaro.org>
References: <20230622-topic-8998clk-v1-0-5b7a0d6e98b1@linaro.org>
In-Reply-To: <20230622-topic-8998clk-v1-0-5b7a0d6e98b1@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Taniya Das <tdas@codeaurora.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687435067; l=4835;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=9epwHHXm7694llyzrYE8Ibwsw00gm3N8GTw3CFx13Eo=;
 b=/5bBV3ls3t77na3yYjGyjhu7xsiRfwCJvHKl+HBCsTzQcNyR12Mt3ea+q2bU6DG2PMtnqK14Z
 EGgxaYz0RrTADqd7ZPNET+VKfwNmfpSsUKCz3+6lnIZzOVkj+iv2gCY
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

Up until now, the GPLL0_DIV MMSS input has been modeled as a fixed
child of MMSS_GPLL0_DIV that's always-on. Properly representing the
former in the GCC driver makes us unable to keep doing so.

Consume MSS_GPLL0_DIV through fw_name ("gpll0_div") as well as add a
fixed .name link to keep backwards compatibility.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/mmcc-msm8998.c | 35 ++++++++---------------------------
 1 file changed, 8 insertions(+), 27 deletions(-)

diff --git a/drivers/clk/qcom/mmcc-msm8998.c b/drivers/clk/qcom/mmcc-msm8998.c
index 4490594bde69..040c495e91e4 100644
--- a/drivers/clk/qcom/mmcc-msm8998.c
+++ b/drivers/clk/qcom/mmcc-msm8998.c
@@ -46,19 +46,6 @@ enum {
 	P_DPLINK,
 };
 
-static struct clk_fixed_factor gpll0_div = {
-	.mult = 1,
-	.div = 2,
-	.hw.init = &(struct clk_init_data){
-		.name = "mmss_gpll0_div",
-		.parent_data = &(const struct clk_parent_data){
-			.fw_name = "gpll0"
-		},
-		.num_parents = 1,
-		.ops = &clk_fixed_factor_ops,
-	},
-};
-
 static const struct clk_div_table post_div_table_fabia_even[] = {
 	{ 0x0, 1 },
 	{ 0x1, 2 },
@@ -354,7 +341,7 @@ static const struct parent_map mmss_xo_gpll0_gpll0_div_map[] = {
 static const struct clk_parent_data mmss_xo_gpll0_gpll0_div[] = {
 	{ .fw_name = "xo" },
 	{ .fw_name = "gpll0" },
-	{ .hw = &gpll0_div.hw },
+	{ .fw_name = "gpll0_div", .name = "gcc_mmss_gpll0_div_clk" },
 };
 
 static const struct parent_map mmss_xo_mmpll0_gpll0_gpll0_div_map[] = {
@@ -368,7 +355,7 @@ static const struct clk_parent_data mmss_xo_mmpll0_gpll0_gpll0_div[] = {
 	{ .fw_name = "xo" },
 	{ .hw = &mmpll0_out_even.clkr.hw },
 	{ .fw_name = "gpll0" },
-	{ .hw = &gpll0_div.hw },
+	{ .fw_name = "gpll0_div", .name = "gcc_mmss_gpll0_div_clk" },
 };
 
 static const struct parent_map mmss_xo_mmpll0_mmpll1_gpll0_gpll0_div_map[] = {
@@ -384,7 +371,7 @@ static const struct clk_parent_data mmss_xo_mmpll0_mmpll1_gpll0_gpll0_div[] = {
 	{ .hw = &mmpll0_out_even.clkr.hw },
 	{ .hw = &mmpll1_out_even.clkr.hw },
 	{ .fw_name = "gpll0" },
-	{ .hw = &gpll0_div.hw },
+	{ .fw_name = "gpll0_div", .name = "gcc_mmss_gpll0_div_clk" },
 };
 
 static const struct parent_map mmss_xo_mmpll0_mmpll5_gpll0_gpll0_div_map[] = {
@@ -400,7 +387,7 @@ static const struct clk_parent_data mmss_xo_mmpll0_mmpll5_gpll0_gpll0_div[] = {
 	{ .hw = &mmpll0_out_even.clkr.hw },
 	{ .hw = &mmpll5_out_even.clkr.hw },
 	{ .fw_name = "gpll0" },
-	{ .hw = &gpll0_div.hw },
+	{ .fw_name = "gpll0_div", .name = "gcc_mmss_gpll0_div_clk" },
 };
 
 static const struct parent_map mmss_xo_mmpll0_mmpll3_mmpll6_gpll0_gpll0_div_map[] = {
@@ -418,7 +405,7 @@ static const struct clk_parent_data mmss_xo_mmpll0_mmpll3_mmpll6_gpll0_gpll0_div
 	{ .hw = &mmpll3_out_even.clkr.hw },
 	{ .hw = &mmpll6_out_even.clkr.hw },
 	{ .fw_name = "gpll0" },
-	{ .hw = &gpll0_div.hw },
+	{ .fw_name = "gpll0_div", .name = "gcc_mmss_gpll0_div_clk" },
 };
 
 static const struct parent_map mmss_xo_mmpll4_mmpll7_mmpll10_gpll0_gpll0_div_map[] = {
@@ -436,7 +423,7 @@ static const struct clk_parent_data mmss_xo_mmpll4_mmpll7_mmpll10_gpll0_gpll0_di
 	{ .hw = &mmpll7_out_even.clkr.hw },
 	{ .hw = &mmpll10_out_even.clkr.hw },
 	{ .fw_name = "gpll0" },
-	{ .hw = &gpll0_div.hw },
+	{ .fw_name = "gpll0_div", .name = "gcc_mmss_gpll0_div_clk" },
 };
 
 static const struct parent_map mmss_xo_mmpll0_mmpll7_mmpll10_gpll0_gpll0_div_map[] = {
@@ -454,7 +441,7 @@ static const struct clk_parent_data mmss_xo_mmpll0_mmpll7_mmpll10_gpll0_gpll0_di
 	{ .hw = &mmpll7_out_even.clkr.hw },
 	{ .hw = &mmpll10_out_even.clkr.hw },
 	{ .fw_name = "gpll0" },
-	{ .hw = &gpll0_div.hw },
+	{ .fw_name = "gpll0_div", .name = "gcc_mmss_gpll0_div_clk" },
 };
 
 static const struct parent_map mmss_xo_mmpll0_mmpll4_mmpll7_mmpll10_gpll0_gpll0_div_map[] = {
@@ -474,7 +461,7 @@ static const struct clk_parent_data mmss_xo_mmpll0_mmpll4_mmpll7_mmpll10_gpll0_g
 	{ .hw = &mmpll7_out_even.clkr.hw },
 	{ .hw = &mmpll10_out_even.clkr.hw },
 	{ .fw_name = "gpll0" },
-	{ .hw = &gpll0_div.hw },
+	{ .fw_name = "gpll0_div", .name = "gcc_mmss_gpll0_div_clk" },
 };
 
 static struct clk_rcg2 byte0_clk_src = {
@@ -2544,10 +2531,6 @@ static struct clk_branch vmem_ahb_clk = {
 	},
 };
 
-static struct clk_hw *mmcc_msm8998_hws[] = {
-	&gpll0_div.hw,
-};
-
 static struct gdsc video_top_gdsc = {
 	.gdscr = 0x1024,
 	.pd = {
@@ -2855,8 +2838,6 @@ static const struct qcom_cc_desc mmcc_msm8998_desc = {
 	.num_resets = ARRAY_SIZE(mmcc_msm8998_resets),
 	.gdscs = mmcc_msm8998_gdscs,
 	.num_gdscs = ARRAY_SIZE(mmcc_msm8998_gdscs),
-	.clk_hws = mmcc_msm8998_hws,
-	.num_clk_hws = ARRAY_SIZE(mmcc_msm8998_hws),
 };
 
 static const struct of_device_id mmcc_msm8998_match_table[] = {

-- 
2.41.0


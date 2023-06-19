Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7490A7357ED
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjFSNGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbjFSNF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:05:26 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C789910D2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:05:01 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so4333121e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687179900; x=1689771900;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lfJKGnuOmlMd8nsLHbg4fU9ovSja2YyL1M9ahTPqCp0=;
        b=IZBi124PIVIfHnzh0rNaRcHP6ToI4QGvZ6qDYMKqGKdjHJgZKfWelVZBp8xyflOXfD
         GfdqXvikuE1GTgw+BDQmV7xFxNYarMb8PDde6mfEfnhU04VKUJbB9x6eXedL092dvIdZ
         c6EZJ1ob37m8jyTtl5+RadMRlczMCMH83SL2q8Wrsi5RVdOGa/a0Ow9H8hS+J27KqzcF
         O6/GwKVe13ToLK4GsXKQ0pTVziRvZopJwR50EMLyi1q7EA2tEGSL5DVJB89xANXr8Gtt
         cL6FotmchHle+WOYZHrPiE2MTPdXC9YS008OGZGVSKnbfcMQJ2k1wJBORyKhF79iafkn
         vetg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687179900; x=1689771900;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lfJKGnuOmlMd8nsLHbg4fU9ovSja2YyL1M9ahTPqCp0=;
        b=FEq8XCdsVDGUKnVnuRljvluZPzBhRp3X+SUasHUT532Gx1kCx7mPOF7O9K5jdph5FK
         SYABGabIXZvsTIbfJPpWd585ny6BrlRr1aGQBcrYXocmn9/ZarGOOVQKUdha3XJm9JiU
         09QgeEFONnjnNa97F7uruCRBRc4kLM0SX+iD82BKLhdYCkuDqzxWkrC9IyvEBzJ7XFO1
         k/1fyPt6G0qJavVk2Uw6YyTkwcd7vb+rhfvlgcaODNreQrdZkGdGxn7PsehKM4RDKy8J
         Ds3fkMY/Ha1cy5yQpbVGfn/2Etbwd0NNE/lcF0X0EUY8yEqHlmNQigT/k4Wmm4E5x4lY
         ekCg==
X-Gm-Message-State: AC+VfDzotDS7goVI/9KcDU2jdslFnUmUpH+BK2zwkihIp81GqmDyabzS
        WTgOkaURfTQ/Gocbaf2i6cIYMg==
X-Google-Smtp-Source: ACHHUZ4SACDkYri9horrlWeZFk7pmH5AgJw5E6Ub0FmZfGTQVaKzpqbKxRWTu/HC89timIDCDXYmgg==
X-Received: by 2002:a19:660a:0:b0:4f6:424c:4fa8 with SMTP id a10-20020a19660a000000b004f6424c4fa8mr4991745lfc.17.1687179899946;
        Mon, 19 Jun 2023 06:04:59 -0700 (PDT)
Received: from [192.168.1.101] (abyl242.neoplus.adsl.tpnet.pl. [83.9.31.242])
        by smtp.gmail.com with ESMTPSA id q28-20020ac25a1c000000b004f643664882sm4256489lfn.147.2023.06.19.06.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 06:04:59 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 19 Jun 2023 15:04:43 +0200
Subject: [PATCH v7 18/22] clk: qcom: smd-rpm: Separate out interconnect bus
 clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v7-18-09c78c175546@linaro.org>
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
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687179869; l=26951;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=QfXDDCARUYGUJI39cMR1Lpo9tUgDEQKBBzAowlx0GRo=;
 b=OkyE1Tj5K35AA1iGBKH6ae7SitVIJmHWDtcCK9VqoU0cbbF9KYeC9c2SNQraEgL/vI1YrMcdB
 G3iW3nw2L0MBpdsNrWqUnAH9U/xhhBWYsoffWiTum3BuHLNuPjMt6C4
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

The interconnect bus clocks are now handled within the ICC framework.
They still however need to get a kickstart *before* we call
clk_smd_rpm_enable_scaling(), or RPM will assume that they should all
be running at 0 kHz and the system will inevitably die.

Separate them out to ensure such a kickstart can still take place.

As a happy accident, the file got smaller:

Total: Before=41951, After=41555, chg -0.94%

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/clk-smd-rpm.c | 280 +++++++++++++++++------------------------
 1 file changed, 116 insertions(+), 164 deletions(-)

diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index 6e7f0438e8b8..997c2b89a5d1 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -167,12 +167,20 @@ struct clk_smd_rpm {
 struct rpm_smd_clk_desc {
 	struct clk_smd_rpm **clks;
 	size_t num_clks;
+
+	/*
+	 * Interconnect clocks are managed by the icc framework, this driver
+	 * only kickstarts them so that they don't get gated between
+	 * clk_smd_rpm_enable_scaling() and interconnect driver initialization.
+	 */
+	const struct clk_smd_rpm ** const icc_clks;
+	size_t num_icc_clks;
 	bool scaling_before_handover;
 };
 
 static DEFINE_MUTEX(rpm_smd_clk_lock);
 
-static int clk_smd_rpm_handoff(struct clk_smd_rpm *r)
+static int clk_smd_rpm_handoff(const struct clk_smd_rpm *r)
 {
 	int ret;
 	struct clk_smd_rpm_req req = {
@@ -498,13 +506,69 @@ DEFINE_CLK_SMD_RPM_XO_BUFFER(div_clk1, 11, 19200000);
 DEFINE_CLK_SMD_RPM_XO_BUFFER(div_clk2, 12, 19200000);
 DEFINE_CLK_SMD_RPM_XO_BUFFER(div_clk3, 13, 19200000);
 
+static const struct clk_smd_rpm *bimc_pcnoc_icc_clks[] = {
+	&clk_smd_rpm_bimc_clk,
+	&clk_smd_rpm_bus_0_pcnoc_clk,
+};
+
+static const struct clk_smd_rpm *bimc_pcnoc_snoc_icc_clks[] = {
+	&clk_smd_rpm_bimc_clk,
+	&clk_smd_rpm_bus_0_pcnoc_clk,
+	&clk_smd_rpm_bus_1_snoc_clk,
+};
+
+static const struct clk_smd_rpm *bimc_pcnoc_snoc_smmnoc_icc_clks[] = {
+	&clk_smd_rpm_bimc_clk,
+	&clk_smd_rpm_bus_0_pcnoc_clk,
+	&clk_smd_rpm_bus_1_snoc_clk,
+	&clk_smd_rpm_bus_2_sysmmnoc_clk,
+};
+
+static const struct clk_smd_rpm *bimc_pcnoc_snoc_cnoc_ocmem_icc_clks[] = {
+	&clk_smd_rpm_bimc_clk,
+	&clk_smd_rpm_bus_0_pcnoc_clk,
+	&clk_smd_rpm_bus_1_snoc_clk,
+	&clk_smd_rpm_bus_2_cnoc_clk,
+	&clk_smd_rpm_ocmemgx_clk,
+};
+
+static const struct clk_smd_rpm *msm8996_icc_clks[] = {
+	&clk_smd_rpm_bimc_clk,
+	&clk_smd_rpm_branch_aggre1_noc_clk,
+	&clk_smd_rpm_branch_aggre2_noc_clk,
+	&clk_smd_rpm_bus_0_pcnoc_clk,
+	&clk_smd_rpm_bus_1_snoc_clk,
+	&clk_smd_rpm_bus_2_cnoc_clk,
+	&clk_smd_rpm_mmssnoc_axi_rpm_clk,
+};
+
+static const struct clk_smd_rpm *msm8998_icc_clks[] = {
+	&clk_smd_rpm_aggre1_noc_clk,
+	&clk_smd_rpm_aggre2_noc_clk,
+	&clk_smd_rpm_bimc_clk,
+	&clk_smd_rpm_bus_1_snoc_clk,
+	&clk_smd_rpm_bus_2_cnoc_clk,
+	&clk_smd_rpm_mmssnoc_axi_rpm_clk,
+};
+
+static const struct clk_smd_rpm *sdm660_icc_clks[] = {
+	&clk_smd_rpm_aggre2_noc_clk,
+	&clk_smd_rpm_bimc_clk,
+	&clk_smd_rpm_bus_1_snoc_clk,
+	&clk_smd_rpm_bus_2_cnoc_clk,
+	&clk_smd_rpm_mmssnoc_axi_rpm_clk,
+};
+
+static const struct clk_smd_rpm *sm_qnoc_icc_clks[] = {
+	&clk_smd_rpm_bimc_clk,
+	&clk_smd_rpm_bus_1_cnoc_clk,
+	&clk_smd_rpm_mmnrt_clk,
+	&clk_smd_rpm_mmrt_clk,
+	&clk_smd_rpm_qup_clk,
+	&clk_smd_rpm_bus_2_snoc_clk,
+};
+
 static struct clk_smd_rpm *msm8909_clks[] = {
-	[RPM_SMD_PCNOC_CLK]		= &clk_smd_rpm_bus_0_pcnoc_clk,
-	[RPM_SMD_PCNOC_A_CLK]		= &clk_smd_rpm_bus_0_pcnoc_a_clk,
-	[RPM_SMD_SNOC_CLK]		= &clk_smd_rpm_bus_1_snoc_clk,
-	[RPM_SMD_SNOC_A_CLK]		= &clk_smd_rpm_bus_1_snoc_a_clk,
-	[RPM_SMD_BIMC_CLK]		= &clk_smd_rpm_bimc_clk,
-	[RPM_SMD_BIMC_A_CLK]		= &clk_smd_rpm_bimc_a_clk,
 	[RPM_SMD_QPIC_CLK]		= &clk_smd_rpm_qpic_clk,
 	[RPM_SMD_QPIC_CLK_A]		= &clk_smd_rpm_qpic_a_clk,
 	[RPM_SMD_QDSS_CLK]		= &clk_smd_rpm_qdss_clk,
@@ -530,15 +594,11 @@ static struct clk_smd_rpm *msm8909_clks[] = {
 static const struct rpm_smd_clk_desc rpm_clk_msm8909 = {
 	.clks = msm8909_clks,
 	.num_clks = ARRAY_SIZE(msm8909_clks),
+	.icc_clks = bimc_pcnoc_snoc_icc_clks,
+	.num_icc_clks = ARRAY_SIZE(bimc_pcnoc_snoc_icc_clks),
 };
 
 static struct clk_smd_rpm *msm8916_clks[] = {
-	[RPM_SMD_PCNOC_CLK]		= &clk_smd_rpm_bus_0_pcnoc_clk,
-	[RPM_SMD_PCNOC_A_CLK]		= &clk_smd_rpm_bus_0_pcnoc_a_clk,
-	[RPM_SMD_SNOC_CLK]		= &clk_smd_rpm_bus_1_snoc_clk,
-	[RPM_SMD_SNOC_A_CLK]		= &clk_smd_rpm_bus_1_snoc_a_clk,
-	[RPM_SMD_BIMC_CLK]		= &clk_smd_rpm_bimc_clk,
-	[RPM_SMD_BIMC_A_CLK]		= &clk_smd_rpm_bimc_a_clk,
 	[RPM_SMD_QDSS_CLK]		= &clk_smd_rpm_qdss_clk,
 	[RPM_SMD_QDSS_A_CLK]		= &clk_smd_rpm_qdss_a_clk,
 	[RPM_SMD_BB_CLK1]		= &clk_smd_rpm_bb_clk1,
@@ -562,21 +622,15 @@ static struct clk_smd_rpm *msm8916_clks[] = {
 static const struct rpm_smd_clk_desc rpm_clk_msm8916 = {
 	.clks = msm8916_clks,
 	.num_clks = ARRAY_SIZE(msm8916_clks),
+	.icc_clks = bimc_pcnoc_snoc_icc_clks,
+	.num_icc_clks = ARRAY_SIZE(bimc_pcnoc_snoc_icc_clks),
 };
 
 static struct clk_smd_rpm *msm8917_clks[] = {
 	[RPM_SMD_XO_CLK_SRC]		= &clk_smd_rpm_branch_bi_tcxo,
 	[RPM_SMD_XO_A_CLK_SRC]		= &clk_smd_rpm_branch_bi_tcxo_a,
-	[RPM_SMD_PNOC_CLK]		= &clk_smd_rpm_bus_0_pcnoc_clk,
-	[RPM_SMD_PNOC_A_CLK]		= &clk_smd_rpm_bus_0_pcnoc_a_clk,
-	[RPM_SMD_SNOC_CLK]		= &clk_smd_rpm_bus_1_snoc_clk,
-	[RPM_SMD_SNOC_A_CLK]		= &clk_smd_rpm_bus_1_snoc_a_clk,
-	[RPM_SMD_BIMC_CLK]		= &clk_smd_rpm_bimc_clk,
-	[RPM_SMD_BIMC_A_CLK]		= &clk_smd_rpm_bimc_a_clk,
 	[RPM_SMD_BIMC_GPU_CLK]		= &clk_smd_rpm_bimc_gpu_clk,
 	[RPM_SMD_BIMC_GPU_A_CLK]	= &clk_smd_rpm_bimc_gpu_a_clk,
-	[RPM_SMD_SYSMMNOC_CLK]		= &clk_smd_rpm_bus_2_sysmmnoc_clk,
-	[RPM_SMD_SYSMMNOC_A_CLK]	= &clk_smd_rpm_bus_2_sysmmnoc_a_clk,
 	[RPM_SMD_QDSS_CLK]		= &clk_smd_rpm_qdss_clk,
 	[RPM_SMD_QDSS_A_CLK]		= &clk_smd_rpm_qdss_a_clk,
 	[RPM_SMD_BB_CLK1]		= &clk_smd_rpm_bb_clk1,
@@ -596,19 +650,13 @@ static struct clk_smd_rpm *msm8917_clks[] = {
 static const struct rpm_smd_clk_desc rpm_clk_msm8917 = {
 	.clks = msm8917_clks,
 	.num_clks = ARRAY_SIZE(msm8917_clks),
+	.icc_clks = bimc_pcnoc_snoc_smmnoc_icc_clks,
+	.num_icc_clks = ARRAY_SIZE(bimc_pcnoc_snoc_smmnoc_icc_clks),
 };
 
 static struct clk_smd_rpm *msm8936_clks[] = {
 	[RPM_SMD_XO_CLK_SRC]		= &clk_smd_rpm_branch_bi_tcxo,
 	[RPM_SMD_XO_A_CLK_SRC]		= &clk_smd_rpm_branch_bi_tcxo_a,
-	[RPM_SMD_PCNOC_CLK]		= &clk_smd_rpm_bus_0_pcnoc_clk,
-	[RPM_SMD_PCNOC_A_CLK]		= &clk_smd_rpm_bus_0_pcnoc_a_clk,
-	[RPM_SMD_SNOC_CLK]		= &clk_smd_rpm_bus_1_snoc_clk,
-	[RPM_SMD_SNOC_A_CLK]		= &clk_smd_rpm_bus_1_snoc_a_clk,
-	[RPM_SMD_BIMC_CLK]		= &clk_smd_rpm_bimc_clk,
-	[RPM_SMD_BIMC_A_CLK]		= &clk_smd_rpm_bimc_a_clk,
-	[RPM_SMD_SYSMMNOC_CLK]		= &clk_smd_rpm_bus_2_sysmmnoc_clk,
-	[RPM_SMD_SYSMMNOC_A_CLK]	= &clk_smd_rpm_bus_2_sysmmnoc_a_clk,
 	[RPM_SMD_QDSS_CLK]		= &clk_smd_rpm_qdss_clk,
 	[RPM_SMD_QDSS_A_CLK]		= &clk_smd_rpm_qdss_a_clk,
 	[RPM_SMD_BB_CLK1]		= &clk_smd_rpm_bb_clk1,
@@ -632,25 +680,17 @@ static struct clk_smd_rpm *msm8936_clks[] = {
 static const struct rpm_smd_clk_desc rpm_clk_msm8936 = {
 		.clks = msm8936_clks,
 		.num_clks = ARRAY_SIZE(msm8936_clks),
+		.icc_clks = bimc_pcnoc_snoc_smmnoc_icc_clks,
+		.num_icc_clks = ARRAY_SIZE(bimc_pcnoc_snoc_smmnoc_icc_clks),
 };
 
 static struct clk_smd_rpm *msm8974_clks[] = {
 	[RPM_SMD_XO_CLK_SRC]		= &clk_smd_rpm_branch_bi_tcxo,
 	[RPM_SMD_XO_A_CLK_SRC]		= &clk_smd_rpm_branch_bi_tcxo_a,
-	[RPM_SMD_PNOC_CLK]		= &clk_smd_rpm_bus_0_pcnoc_clk,
-	[RPM_SMD_PNOC_A_CLK]		= &clk_smd_rpm_bus_0_pcnoc_a_clk,
-	[RPM_SMD_SNOC_CLK]		= &clk_smd_rpm_bus_1_snoc_clk,
-	[RPM_SMD_SNOC_A_CLK]		= &clk_smd_rpm_bus_1_snoc_a_clk,
-	[RPM_SMD_CNOC_CLK]		= &clk_smd_rpm_bus_2_cnoc_clk,
-	[RPM_SMD_CNOC_A_CLK]		= &clk_smd_rpm_bus_2_cnoc_a_clk,
 	[RPM_SMD_MMSSNOC_AHB_CLK]	= &clk_smd_rpm_bus_3_mmssnoc_ahb_clk,
 	[RPM_SMD_MMSSNOC_AHB_A_CLK]	= &clk_smd_rpm_bus_3_mmssnoc_ahb_a_clk,
-	[RPM_SMD_BIMC_CLK]		= &clk_smd_rpm_bimc_clk,
 	[RPM_SMD_GFX3D_CLK_SRC]		= &clk_smd_rpm_gfx3d_clk_src,
 	[RPM_SMD_GFX3D_A_CLK_SRC]	= &clk_smd_rpm_gfx3d_a_clk_src,
-	[RPM_SMD_BIMC_A_CLK]		= &clk_smd_rpm_bimc_a_clk,
-	[RPM_SMD_OCMEMGX_CLK]		= &clk_smd_rpm_ocmemgx_clk,
-	[RPM_SMD_OCMEMGX_A_CLK]		= &clk_smd_rpm_ocmemgx_a_clk,
 	[RPM_SMD_QDSS_CLK]		= &clk_smd_rpm_qdss_clk,
 	[RPM_SMD_QDSS_A_CLK]		= &clk_smd_rpm_qdss_a_clk,
 	[RPM_SMD_CXO_D0]		= &clk_smd_rpm_cxo_d0,
@@ -684,20 +724,14 @@ static struct clk_smd_rpm *msm8974_clks[] = {
 static const struct rpm_smd_clk_desc rpm_clk_msm8974 = {
 	.clks = msm8974_clks,
 	.num_clks = ARRAY_SIZE(msm8974_clks),
+	.icc_clks = bimc_pcnoc_snoc_cnoc_ocmem_icc_clks,
+	.num_icc_clks = ARRAY_SIZE(bimc_pcnoc_snoc_cnoc_ocmem_icc_clks),
 	.scaling_before_handover = true,
 };
 
 static struct clk_smd_rpm *msm8976_clks[] = {
 	[RPM_SMD_XO_CLK_SRC] = &clk_smd_rpm_branch_bi_tcxo,
 	[RPM_SMD_XO_A_CLK_SRC] = &clk_smd_rpm_branch_bi_tcxo_a,
-	[RPM_SMD_PCNOC_CLK] = &clk_smd_rpm_bus_0_pcnoc_clk,
-	[RPM_SMD_PCNOC_A_CLK] = &clk_smd_rpm_bus_0_pcnoc_a_clk,
-	[RPM_SMD_SNOC_CLK] = &clk_smd_rpm_bus_1_snoc_clk,
-	[RPM_SMD_SNOC_A_CLK] = &clk_smd_rpm_bus_1_snoc_a_clk,
-	[RPM_SMD_BIMC_CLK] = &clk_smd_rpm_bimc_clk,
-	[RPM_SMD_BIMC_A_CLK] = &clk_smd_rpm_bimc_a_clk,
-	[RPM_SMD_SYSMMNOC_CLK]	= &clk_smd_rpm_bus_2_sysmmnoc_clk,
-	[RPM_SMD_SYSMMNOC_A_CLK] = &clk_smd_rpm_bus_2_sysmmnoc_a_clk,
 	[RPM_SMD_QDSS_CLK] = &clk_smd_rpm_qdss_clk,
 	[RPM_SMD_QDSS_A_CLK] = &clk_smd_rpm_qdss_a_clk,
 	[RPM_SMD_BB_CLK1] = &clk_smd_rpm_bb_clk1,
@@ -718,24 +752,15 @@ static struct clk_smd_rpm *msm8976_clks[] = {
 
 static const struct rpm_smd_clk_desc rpm_clk_msm8976 = {
 	.clks = msm8976_clks,
-	.num_clks = ARRAY_SIZE(msm8976_clks),
+	.icc_clks = bimc_pcnoc_snoc_smmnoc_icc_clks,
+	.num_icc_clks = ARRAY_SIZE(bimc_pcnoc_snoc_smmnoc_icc_clks),
 };
 
 static struct clk_smd_rpm *msm8992_clks[] = {
 	[RPM_SMD_XO_CLK_SRC] = &clk_smd_rpm_branch_bi_tcxo,
 	[RPM_SMD_XO_A_CLK_SRC] = &clk_smd_rpm_branch_bi_tcxo_a,
-	[RPM_SMD_PNOC_CLK] = &clk_smd_rpm_bus_0_pcnoc_clk,
-	[RPM_SMD_PNOC_A_CLK] = &clk_smd_rpm_bus_0_pcnoc_a_clk,
-	[RPM_SMD_OCMEMGX_CLK] = &clk_smd_rpm_ocmemgx_clk,
-	[RPM_SMD_OCMEMGX_A_CLK] = &clk_smd_rpm_ocmemgx_a_clk,
-	[RPM_SMD_BIMC_CLK] = &clk_smd_rpm_bimc_clk,
-	[RPM_SMD_BIMC_A_CLK] = &clk_smd_rpm_bimc_a_clk,
-	[RPM_SMD_CNOC_CLK] = &clk_smd_rpm_bus_2_cnoc_clk,
-	[RPM_SMD_CNOC_A_CLK] = &clk_smd_rpm_bus_2_cnoc_a_clk,
 	[RPM_SMD_GFX3D_CLK_SRC] = &clk_smd_rpm_gfx3d_clk_src,
 	[RPM_SMD_GFX3D_A_CLK_SRC] = &clk_smd_rpm_gfx3d_a_clk_src,
-	[RPM_SMD_SNOC_CLK] = &clk_smd_rpm_bus_1_snoc_clk,
-	[RPM_SMD_SNOC_A_CLK] = &clk_smd_rpm_bus_1_snoc_a_clk,
 	[RPM_SMD_BB_CLK1] = &clk_smd_rpm_bb_clk1,
 	[RPM_SMD_BB_CLK1_A] = &clk_smd_rpm_bb_clk1_a,
 	[RPM_SMD_BB_CLK1_PIN] = &clk_smd_rpm_bb_clk1_pin,
@@ -777,23 +802,15 @@ static struct clk_smd_rpm *msm8992_clks[] = {
 static const struct rpm_smd_clk_desc rpm_clk_msm8992 = {
 	.clks = msm8992_clks,
 	.num_clks = ARRAY_SIZE(msm8992_clks),
+	.icc_clks = bimc_pcnoc_snoc_cnoc_ocmem_icc_clks,
+	.num_icc_clks = ARRAY_SIZE(bimc_pcnoc_snoc_cnoc_ocmem_icc_clks),
 };
 
 static struct clk_smd_rpm *msm8994_clks[] = {
 	[RPM_SMD_XO_CLK_SRC] = &clk_smd_rpm_branch_bi_tcxo,
 	[RPM_SMD_XO_A_CLK_SRC] = &clk_smd_rpm_branch_bi_tcxo_a,
-	[RPM_SMD_PNOC_CLK] = &clk_smd_rpm_bus_0_pcnoc_clk,
-	[RPM_SMD_PNOC_A_CLK] = &clk_smd_rpm_bus_0_pcnoc_a_clk,
-	[RPM_SMD_OCMEMGX_CLK] = &clk_smd_rpm_ocmemgx_clk,
-	[RPM_SMD_OCMEMGX_A_CLK] = &clk_smd_rpm_ocmemgx_a_clk,
-	[RPM_SMD_BIMC_CLK] = &clk_smd_rpm_bimc_clk,
-	[RPM_SMD_BIMC_A_CLK] = &clk_smd_rpm_bimc_a_clk,
-	[RPM_SMD_CNOC_CLK] = &clk_smd_rpm_bus_2_cnoc_clk,
-	[RPM_SMD_CNOC_A_CLK] = &clk_smd_rpm_bus_2_cnoc_a_clk,
 	[RPM_SMD_GFX3D_CLK_SRC] = &clk_smd_rpm_gfx3d_clk_src,
 	[RPM_SMD_GFX3D_A_CLK_SRC] = &clk_smd_rpm_gfx3d_a_clk_src,
-	[RPM_SMD_SNOC_CLK] = &clk_smd_rpm_bus_1_snoc_clk,
-	[RPM_SMD_SNOC_A_CLK] = &clk_smd_rpm_bus_1_snoc_a_clk,
 	[RPM_SMD_BB_CLK1] = &clk_smd_rpm_bb_clk1,
 	[RPM_SMD_BB_CLK1_A] = &clk_smd_rpm_bb_clk1_a,
 	[RPM_SMD_BB_CLK1_PIN] = &clk_smd_rpm_bb_clk1_pin,
@@ -837,29 +854,17 @@ static struct clk_smd_rpm *msm8994_clks[] = {
 static const struct rpm_smd_clk_desc rpm_clk_msm8994 = {
 	.clks = msm8994_clks,
 	.num_clks = ARRAY_SIZE(msm8994_clks),
+	.icc_clks = bimc_pcnoc_snoc_cnoc_ocmem_icc_clks,
+	.num_icc_clks = ARRAY_SIZE(bimc_pcnoc_snoc_cnoc_ocmem_icc_clks),
 };
 
 static struct clk_smd_rpm *msm8996_clks[] = {
 	[RPM_SMD_XO_CLK_SRC] = &clk_smd_rpm_branch_bi_tcxo,
 	[RPM_SMD_XO_A_CLK_SRC] = &clk_smd_rpm_branch_bi_tcxo_a,
-	[RPM_SMD_PCNOC_CLK] = &clk_smd_rpm_bus_0_pcnoc_clk,
-	[RPM_SMD_PCNOC_A_CLK] = &clk_smd_rpm_bus_0_pcnoc_a_clk,
-	[RPM_SMD_SNOC_CLK] = &clk_smd_rpm_bus_1_snoc_clk,
-	[RPM_SMD_SNOC_A_CLK] = &clk_smd_rpm_bus_1_snoc_a_clk,
-	[RPM_SMD_CNOC_CLK] = &clk_smd_rpm_bus_2_cnoc_clk,
-	[RPM_SMD_CNOC_A_CLK] = &clk_smd_rpm_bus_2_cnoc_a_clk,
-	[RPM_SMD_BIMC_CLK] = &clk_smd_rpm_bimc_clk,
-	[RPM_SMD_BIMC_A_CLK] = &clk_smd_rpm_bimc_a_clk,
-	[RPM_SMD_MMAXI_CLK] = &clk_smd_rpm_mmssnoc_axi_rpm_clk,
-	[RPM_SMD_MMAXI_A_CLK] = &clk_smd_rpm_mmssnoc_axi_rpm_a_clk,
 	[RPM_SMD_IPA_CLK] = &clk_smd_rpm_ipa_clk,
 	[RPM_SMD_IPA_A_CLK] = &clk_smd_rpm_ipa_a_clk,
 	[RPM_SMD_CE1_CLK] = &clk_smd_rpm_ce1_clk,
 	[RPM_SMD_CE1_A_CLK] = &clk_smd_rpm_ce1_a_clk,
-	[RPM_SMD_AGGR1_NOC_CLK] = &clk_smd_rpm_branch_aggre1_noc_clk,
-	[RPM_SMD_AGGR1_NOC_A_CLK] = &clk_smd_rpm_branch_aggre1_noc_a_clk,
-	[RPM_SMD_AGGR2_NOC_CLK] = &clk_smd_rpm_branch_aggre2_noc_clk,
-	[RPM_SMD_AGGR2_NOC_A_CLK] = &clk_smd_rpm_branch_aggre2_noc_a_clk,
 	[RPM_SMD_QDSS_CLK] = &clk_smd_rpm_qdss_clk,
 	[RPM_SMD_QDSS_A_CLK] = &clk_smd_rpm_qdss_a_clk,
 	[RPM_SMD_BB_CLK1] = &clk_smd_rpm_bb_clk1,
@@ -891,6 +896,8 @@ static struct clk_smd_rpm *msm8996_clks[] = {
 static const struct rpm_smd_clk_desc rpm_clk_msm8996 = {
 	.clks = msm8996_clks,
 	.num_clks = ARRAY_SIZE(msm8996_clks),
+	.icc_clks = msm8996_icc_clks,
+	.num_icc_clks = ARRAY_SIZE(msm8996_icc_clks),
 };
 
 static struct clk_smd_rpm *qcs404_clks[] = {
@@ -919,19 +926,15 @@ static struct clk_smd_rpm *qcs404_clks[] = {
 static const struct rpm_smd_clk_desc rpm_clk_qcs404 = {
 	.clks = qcs404_clks,
 	.num_clks = ARRAY_SIZE(qcs404_clks),
+	.icc_clks = bimc_pcnoc_snoc_icc_clks,
+	.num_icc_clks = ARRAY_SIZE(bimc_pcnoc_snoc_icc_clks),
 };
 
 static struct clk_smd_rpm *msm8998_clks[] = {
 	[RPM_SMD_XO_CLK_SRC] = &clk_smd_rpm_branch_bi_tcxo,
 	[RPM_SMD_XO_A_CLK_SRC] = &clk_smd_rpm_branch_bi_tcxo_a,
-	[RPM_SMD_BIMC_CLK] = &clk_smd_rpm_bimc_clk,
-	[RPM_SMD_BIMC_A_CLK] = &clk_smd_rpm_bimc_a_clk,
 	[RPM_SMD_PCNOC_CLK] = &clk_smd_rpm_bus_0_pcnoc_clk,
 	[RPM_SMD_PCNOC_A_CLK] = &clk_smd_rpm_bus_0_pcnoc_a_clk,
-	[RPM_SMD_SNOC_CLK] = &clk_smd_rpm_bus_1_snoc_clk,
-	[RPM_SMD_SNOC_A_CLK] = &clk_smd_rpm_bus_1_snoc_a_clk,
-	[RPM_SMD_CNOC_CLK] = &clk_smd_rpm_bus_2_cnoc_clk,
-	[RPM_SMD_CNOC_A_CLK] = &clk_smd_rpm_bus_2_cnoc_a_clk,
 	[RPM_SMD_CE1_CLK] = &clk_smd_rpm_ce1_clk,
 	[RPM_SMD_CE1_A_CLK] = &clk_smd_rpm_ce1_a_clk,
 	[RPM_SMD_DIV_CLK1] = &clk_smd_rpm_div_clk1,
@@ -954,12 +957,6 @@ static struct clk_smd_rpm *msm8998_clks[] = {
 	[RPM_SMD_LN_BB_CLK2_A_PIN] = &clk_smd_rpm_ln_bb_clk2_a_pin,
 	[RPM_SMD_LN_BB_CLK3_PIN] = &clk_smd_rpm_ln_bb_clk3_pin,
 	[RPM_SMD_LN_BB_CLK3_A_PIN] = &clk_smd_rpm_ln_bb_clk3_a_pin,
-	[RPM_SMD_MMAXI_CLK] = &clk_smd_rpm_mmssnoc_axi_rpm_clk,
-	[RPM_SMD_MMAXI_A_CLK] = &clk_smd_rpm_mmssnoc_axi_rpm_a_clk,
-	[RPM_SMD_AGGR1_NOC_CLK] = &clk_smd_rpm_aggre1_noc_clk,
-	[RPM_SMD_AGGR1_NOC_A_CLK] = &clk_smd_rpm_aggre1_noc_a_clk,
-	[RPM_SMD_AGGR2_NOC_CLK] = &clk_smd_rpm_aggre2_noc_clk,
-	[RPM_SMD_AGGR2_NOC_A_CLK] = &clk_smd_rpm_aggre2_noc_a_clk,
 	[RPM_SMD_QDSS_CLK] = &clk_smd_rpm_qdss_clk,
 	[RPM_SMD_QDSS_A_CLK] = &clk_smd_rpm_qdss_a_clk,
 	[RPM_SMD_RF_CLK1] = &clk_smd_rpm_rf_clk1,
@@ -979,27 +976,19 @@ static struct clk_smd_rpm *msm8998_clks[] = {
 static const struct rpm_smd_clk_desc rpm_clk_msm8998 = {
 	.clks = msm8998_clks,
 	.num_clks = ARRAY_SIZE(msm8998_clks),
+	.icc_clks = msm8998_icc_clks,
+	.num_icc_clks = ARRAY_SIZE(msm8998_icc_clks),
 };
 
 static struct clk_smd_rpm *sdm660_clks[] = {
 	[RPM_SMD_XO_CLK_SRC] = &clk_smd_rpm_branch_bi_tcxo,
 	[RPM_SMD_XO_A_CLK_SRC] = &clk_smd_rpm_branch_bi_tcxo_a,
-	[RPM_SMD_SNOC_CLK] = &clk_smd_rpm_bus_1_snoc_clk,
-	[RPM_SMD_SNOC_A_CLK] = &clk_smd_rpm_bus_1_snoc_a_clk,
-	[RPM_SMD_CNOC_CLK] = &clk_smd_rpm_bus_2_cnoc_clk,
-	[RPM_SMD_CNOC_A_CLK] = &clk_smd_rpm_bus_2_cnoc_a_clk,
 	[RPM_SMD_CNOC_PERIPH_CLK] = &clk_smd_rpm_bus_0_pcnoc_clk,
 	[RPM_SMD_CNOC_PERIPH_A_CLK] = &clk_smd_rpm_bus_0_pcnoc_a_clk,
-	[RPM_SMD_BIMC_CLK] = &clk_smd_rpm_bimc_clk,
-	[RPM_SMD_BIMC_A_CLK] = &clk_smd_rpm_bimc_a_clk,
-	[RPM_SMD_MMSSNOC_AXI_CLK] = &clk_smd_rpm_mmssnoc_axi_rpm_clk,
-	[RPM_SMD_MMSSNOC_AXI_CLK_A] = &clk_smd_rpm_mmssnoc_axi_rpm_a_clk,
 	[RPM_SMD_IPA_CLK] = &clk_smd_rpm_ipa_clk,
 	[RPM_SMD_IPA_A_CLK] = &clk_smd_rpm_ipa_a_clk,
 	[RPM_SMD_CE1_CLK] = &clk_smd_rpm_ce1_clk,
 	[RPM_SMD_CE1_A_CLK] = &clk_smd_rpm_ce1_a_clk,
-	[RPM_SMD_AGGR2_NOC_CLK] = &clk_smd_rpm_aggre2_noc_clk,
-	[RPM_SMD_AGGR2_NOC_A_CLK] = &clk_smd_rpm_aggre2_noc_a_clk,
 	[RPM_SMD_QDSS_CLK] = &clk_smd_rpm_qdss_clk,
 	[RPM_SMD_QDSS_A_CLK] = &clk_smd_rpm_qdss_a_clk,
 	[RPM_SMD_RF_CLK1] = &clk_smd_rpm_rf_clk1,
@@ -1025,15 +1014,13 @@ static struct clk_smd_rpm *sdm660_clks[] = {
 static const struct rpm_smd_clk_desc rpm_clk_sdm660 = {
 	.clks = sdm660_clks,
 	.num_clks = ARRAY_SIZE(sdm660_clks),
+	.icc_clks = sdm660_icc_clks,
+	.num_icc_clks = ARRAY_SIZE(sdm660_icc_clks),
 };
 
 static struct clk_smd_rpm *mdm9607_clks[] = {
 	[RPM_SMD_XO_CLK_SRC]		= &clk_smd_rpm_branch_bi_tcxo,
 	[RPM_SMD_XO_A_CLK_SRC]		= &clk_smd_rpm_branch_bi_tcxo_a,
-	[RPM_SMD_PCNOC_CLK]		= &clk_smd_rpm_bus_0_pcnoc_clk,
-	[RPM_SMD_PCNOC_A_CLK]		= &clk_smd_rpm_bus_0_pcnoc_a_clk,
-	[RPM_SMD_BIMC_CLK]		= &clk_smd_rpm_bimc_clk,
-	[RPM_SMD_BIMC_A_CLK]		= &clk_smd_rpm_bimc_a_clk,
 	[RPM_SMD_QPIC_CLK]		= &clk_smd_rpm_qpic_clk,
 	[RPM_SMD_QPIC_CLK_A]		= &clk_smd_rpm_qpic_a_clk,
 	[RPM_SMD_QDSS_CLK]		= &clk_smd_rpm_qdss_clk,
@@ -1047,21 +1034,15 @@ static struct clk_smd_rpm *mdm9607_clks[] = {
 static const struct rpm_smd_clk_desc rpm_clk_mdm9607 = {
 	.clks = mdm9607_clks,
 	.num_clks = ARRAY_SIZE(mdm9607_clks),
+	.icc_clks = bimc_pcnoc_icc_clks,
+	.num_icc_clks = ARRAY_SIZE(bimc_pcnoc_icc_clks),
 };
 
 static struct clk_smd_rpm *msm8953_clks[] = {
 	[RPM_SMD_XO_CLK_SRC]		= &clk_smd_rpm_branch_bi_tcxo,
 	[RPM_SMD_XO_A_CLK_SRC]		= &clk_smd_rpm_branch_bi_tcxo_a,
-	[RPM_SMD_PCNOC_CLK]		= &clk_smd_rpm_bus_0_pcnoc_clk,
-	[RPM_SMD_PCNOC_A_CLK]		= &clk_smd_rpm_bus_0_pcnoc_a_clk,
-	[RPM_SMD_SNOC_CLK]		= &clk_smd_rpm_bus_1_snoc_clk,
-	[RPM_SMD_SNOC_A_CLK]		= &clk_smd_rpm_bus_1_snoc_a_clk,
-	[RPM_SMD_BIMC_CLK]		= &clk_smd_rpm_bimc_clk,
-	[RPM_SMD_BIMC_A_CLK]		= &clk_smd_rpm_bimc_a_clk,
 	[RPM_SMD_IPA_CLK]		= &clk_smd_rpm_ipa_clk,
 	[RPM_SMD_IPA_A_CLK]		= &clk_smd_rpm_ipa_a_clk,
-	[RPM_SMD_SYSMMNOC_CLK]		= &clk_smd_rpm_bus_2_sysmmnoc_clk,
-	[RPM_SMD_SYSMMNOC_A_CLK]	= &clk_smd_rpm_bus_2_sysmmnoc_a_clk,
 	[RPM_SMD_QDSS_CLK]		= &clk_smd_rpm_qdss_clk,
 	[RPM_SMD_QDSS_A_CLK]		= &clk_smd_rpm_qdss_a_clk,
 	[RPM_SMD_BB_CLK1]		= &clk_smd_rpm_bb_clk1,
@@ -1083,23 +1064,19 @@ static struct clk_smd_rpm *msm8953_clks[] = {
 static const struct rpm_smd_clk_desc rpm_clk_msm8953 = {
 	.clks = msm8953_clks,
 	.num_clks = ARRAY_SIZE(msm8953_clks),
+	.icc_clks = bimc_pcnoc_snoc_smmnoc_icc_clks,
+	.num_icc_clks = ARRAY_SIZE(bimc_pcnoc_snoc_smmnoc_icc_clks),
 };
 
 static struct clk_smd_rpm *sm6125_clks[] = {
 	[RPM_SMD_XO_CLK_SRC] = &clk_smd_rpm_branch_bi_tcxo,
 	[RPM_SMD_XO_A_CLK_SRC] = &clk_smd_rpm_branch_bi_tcxo_a,
-	[RPM_SMD_SNOC_CLK] = &clk_smd_rpm_bus_2_snoc_clk,
-	[RPM_SMD_SNOC_A_CLK] = &clk_smd_rpm_bus_2_snoc_a_clk,
-	[RPM_SMD_BIMC_CLK] = &clk_smd_rpm_bimc_clk,
-	[RPM_SMD_BIMC_A_CLK] = &clk_smd_rpm_bimc_a_clk,
 	[RPM_SMD_QDSS_CLK] = &clk_smd_rpm_branch_qdss_clk,
 	[RPM_SMD_QDSS_A_CLK] = &clk_smd_rpm_branch_qdss_a_clk,
 	[RPM_SMD_RF_CLK1] = &clk_smd_rpm_rf_clk1,
 	[RPM_SMD_RF_CLK1_A] = &clk_smd_rpm_rf_clk1_a,
 	[RPM_SMD_RF_CLK2] = &clk_smd_rpm_rf_clk2,
 	[RPM_SMD_RF_CLK2_A] = &clk_smd_rpm_rf_clk2_a,
-	[RPM_SMD_CNOC_CLK] = &clk_smd_rpm_bus_1_cnoc_clk,
-	[RPM_SMD_CNOC_A_CLK] = &clk_smd_rpm_bus_1_cnoc_a_clk,
 	[RPM_SMD_IPA_CLK] = &clk_smd_rpm_ipa_clk,
 	[RPM_SMD_IPA_A_CLK] = &clk_smd_rpm_ipa_a_clk,
 	[RPM_SMD_CE1_CLK] = &clk_smd_rpm_ce1_clk,
@@ -1110,12 +1087,6 @@ static struct clk_smd_rpm *sm6125_clks[] = {
 	[RPM_SMD_LN_BB_CLK2_A] = &clk_smd_rpm_ln_bb_clk2_a,
 	[RPM_SMD_LN_BB_CLK3] = &clk_smd_rpm_ln_bb_clk3,
 	[RPM_SMD_LN_BB_CLK3_A] = &clk_smd_rpm_ln_bb_clk3_a,
-	[RPM_SMD_QUP_CLK] = &clk_smd_rpm_qup_clk,
-	[RPM_SMD_QUP_A_CLK] = &clk_smd_rpm_qup_a_clk,
-	[RPM_SMD_MMRT_CLK] = &clk_smd_rpm_mmrt_clk,
-	[RPM_SMD_MMRT_A_CLK] = &clk_smd_rpm_mmrt_a_clk,
-	[RPM_SMD_MMNRT_CLK] = &clk_smd_rpm_mmnrt_clk,
-	[RPM_SMD_MMNRT_A_CLK] = &clk_smd_rpm_mmnrt_a_clk,
 	[RPM_SMD_SNOC_PERIPH_CLK] = &clk_smd_rpm_bus_0_snoc_periph_clk,
 	[RPM_SMD_SNOC_PERIPH_A_CLK] = &clk_smd_rpm_bus_0_snoc_periph_a_clk,
 	[RPM_SMD_SNOC_LPASS_CLK] = &clk_smd_rpm_bus_5_snoc_lpass_clk,
@@ -1125,34 +1096,24 @@ static struct clk_smd_rpm *sm6125_clks[] = {
 static const struct rpm_smd_clk_desc rpm_clk_sm6125 = {
 	.clks = sm6125_clks,
 	.num_clks = ARRAY_SIZE(sm6125_clks),
+	.icc_clks = sm_qnoc_icc_clks,
+	.num_icc_clks = ARRAY_SIZE(sm_qnoc_icc_clks)
 };
 
 /* SM6115 */
 static struct clk_smd_rpm *sm6115_clks[] = {
 	[RPM_SMD_XO_CLK_SRC] = &clk_smd_rpm_branch_bi_tcxo,
 	[RPM_SMD_XO_A_CLK_SRC] = &clk_smd_rpm_branch_bi_tcxo_a,
-	[RPM_SMD_SNOC_CLK] = &clk_smd_rpm_bus_2_snoc_clk,
-	[RPM_SMD_SNOC_A_CLK] = &clk_smd_rpm_bus_2_snoc_a_clk,
-	[RPM_SMD_BIMC_CLK] = &clk_smd_rpm_bimc_clk,
-	[RPM_SMD_BIMC_A_CLK] = &clk_smd_rpm_bimc_a_clk,
 	[RPM_SMD_QDSS_CLK] = &clk_smd_rpm_branch_qdss_clk,
 	[RPM_SMD_QDSS_A_CLK] = &clk_smd_rpm_branch_qdss_a_clk,
 	[RPM_SMD_RF_CLK1] = &clk_smd_rpm_rf_clk1,
 	[RPM_SMD_RF_CLK1_A] = &clk_smd_rpm_rf_clk1_a,
 	[RPM_SMD_RF_CLK2] = &clk_smd_rpm_rf_clk2,
 	[RPM_SMD_RF_CLK2_A] = &clk_smd_rpm_rf_clk2_a,
-	[RPM_SMD_CNOC_CLK] = &clk_smd_rpm_bus_1_cnoc_clk,
-	[RPM_SMD_CNOC_A_CLK] = &clk_smd_rpm_bus_1_cnoc_a_clk,
 	[RPM_SMD_IPA_CLK] = &clk_smd_rpm_ipa_clk,
 	[RPM_SMD_IPA_A_CLK] = &clk_smd_rpm_ipa_a_clk,
 	[RPM_SMD_CE1_CLK] = &clk_smd_rpm_ce1_clk,
 	[RPM_SMD_CE1_A_CLK] = &clk_smd_rpm_ce1_a_clk,
-	[RPM_SMD_QUP_CLK] = &clk_smd_rpm_qup_clk,
-	[RPM_SMD_QUP_A_CLK] = &clk_smd_rpm_qup_a_clk,
-	[RPM_SMD_MMRT_CLK] = &clk_smd_rpm_mmrt_clk,
-	[RPM_SMD_MMRT_A_CLK] = &clk_smd_rpm_mmrt_a_clk,
-	[RPM_SMD_MMNRT_CLK] = &clk_smd_rpm_mmnrt_clk,
-	[RPM_SMD_MMNRT_A_CLK] = &clk_smd_rpm_mmnrt_a_clk,
 	[RPM_SMD_SNOC_PERIPH_CLK] = &clk_smd_rpm_bus_0_snoc_periph_clk,
 	[RPM_SMD_SNOC_PERIPH_A_CLK] = &clk_smd_rpm_bus_0_snoc_periph_a_clk,
 	[RPM_SMD_SNOC_LPASS_CLK] = &clk_smd_rpm_bus_5_snoc_lpass_clk,
@@ -1166,27 +1127,17 @@ static struct clk_smd_rpm *sm6115_clks[] = {
 static const struct rpm_smd_clk_desc rpm_clk_sm6115 = {
 	.clks = sm6115_clks,
 	.num_clks = ARRAY_SIZE(sm6115_clks),
+	.icc_clks = sm_qnoc_icc_clks,
+	.num_icc_clks = ARRAY_SIZE(sm_qnoc_icc_clks)
 };
 
 static struct clk_smd_rpm *sm6375_clks[] = {
 	[RPM_SMD_XO_CLK_SRC] = &clk_smd_rpm_branch_bi_tcxo,
 	[RPM_SMD_XO_A_CLK_SRC] = &clk_smd_rpm_branch_bi_tcxo_a,
-	[RPM_SMD_SNOC_CLK] = &clk_smd_rpm_bus_2_snoc_clk,
-	[RPM_SMD_SNOC_A_CLK] = &clk_smd_rpm_bus_2_snoc_a_clk,
-	[RPM_SMD_BIMC_CLK] = &clk_smd_rpm_bimc_clk,
-	[RPM_SMD_BIMC_A_CLK] = &clk_smd_rpm_bimc_a_clk,
 	[RPM_SMD_QDSS_CLK] = &clk_smd_rpm_branch_qdss_clk,
 	[RPM_SMD_QDSS_A_CLK] = &clk_smd_rpm_branch_qdss_a_clk,
-	[RPM_SMD_CNOC_CLK] = &clk_smd_rpm_bus_1_cnoc_clk,
-	[RPM_SMD_CNOC_A_CLK] = &clk_smd_rpm_bus_1_cnoc_a_clk,
 	[RPM_SMD_IPA_CLK] = &clk_smd_rpm_ipa_clk,
 	[RPM_SMD_IPA_A_CLK] = &clk_smd_rpm_ipa_a_clk,
-	[RPM_SMD_QUP_CLK] = &clk_smd_rpm_qup_clk,
-	[RPM_SMD_QUP_A_CLK] = &clk_smd_rpm_qup_a_clk,
-	[RPM_SMD_MMRT_CLK] = &clk_smd_rpm_mmrt_clk,
-	[RPM_SMD_MMRT_A_CLK] = &clk_smd_rpm_mmrt_a_clk,
-	[RPM_SMD_MMNRT_CLK] = &clk_smd_rpm_mmnrt_clk,
-	[RPM_SMD_MMNRT_A_CLK] = &clk_smd_rpm_mmnrt_a_clk,
 	[RPM_SMD_SNOC_PERIPH_CLK] = &clk_smd_rpm_bus_0_snoc_periph_clk,
 	[RPM_SMD_SNOC_PERIPH_A_CLK] = &clk_smd_rpm_bus_0_snoc_periph_a_clk,
 	[RPM_SMD_SNOC_LPASS_CLK] = &clk_smd_rpm_bus_5_snoc_lpass_clk,
@@ -1203,31 +1154,21 @@ static struct clk_smd_rpm *sm6375_clks[] = {
 static const struct rpm_smd_clk_desc rpm_clk_sm6375 = {
 	.clks = sm6375_clks,
 	.num_clks = ARRAY_SIZE(sm6375_clks),
+	.icc_clks = sm_qnoc_icc_clks,
+	.num_icc_clks = ARRAY_SIZE(sm_qnoc_icc_clks)
 };
 
 static struct clk_smd_rpm *qcm2290_clks[] = {
 	[RPM_SMD_XO_CLK_SRC] = &clk_smd_rpm_branch_bi_tcxo,
 	[RPM_SMD_XO_A_CLK_SRC] = &clk_smd_rpm_branch_bi_tcxo_a,
-	[RPM_SMD_SNOC_CLK] = &clk_smd_rpm_bus_2_snoc_clk,
-	[RPM_SMD_SNOC_A_CLK] = &clk_smd_rpm_bus_2_snoc_a_clk,
-	[RPM_SMD_BIMC_CLK] = &clk_smd_rpm_bimc_clk,
-	[RPM_SMD_BIMC_A_CLK] = &clk_smd_rpm_bimc_a_clk,
 	[RPM_SMD_QDSS_CLK] = &clk_smd_rpm_branch_qdss_clk,
 	[RPM_SMD_QDSS_A_CLK] = &clk_smd_rpm_branch_qdss_a_clk,
 	[RPM_SMD_LN_BB_CLK2] = &clk_smd_rpm_ln_bb_clk2,
 	[RPM_SMD_LN_BB_CLK2_A] = &clk_smd_rpm_ln_bb_clk2_a,
 	[RPM_SMD_RF_CLK3] = &clk_smd_rpm_38m4_rf_clk3,
 	[RPM_SMD_RF_CLK3_A] = &clk_smd_rpm_38m4_rf_clk3_a,
-	[RPM_SMD_CNOC_CLK] = &clk_smd_rpm_bus_1_cnoc_clk,
-	[RPM_SMD_CNOC_A_CLK] = &clk_smd_rpm_bus_1_cnoc_a_clk,
 	[RPM_SMD_IPA_CLK] = &clk_smd_rpm_ipa_clk,
 	[RPM_SMD_IPA_A_CLK] = &clk_smd_rpm_ipa_a_clk,
-	[RPM_SMD_QUP_CLK] = &clk_smd_rpm_qup_clk,
-	[RPM_SMD_QUP_A_CLK] = &clk_smd_rpm_qup_a_clk,
-	[RPM_SMD_MMRT_CLK] = &clk_smd_rpm_mmrt_clk,
-	[RPM_SMD_MMRT_A_CLK] = &clk_smd_rpm_mmrt_a_clk,
-	[RPM_SMD_MMNRT_CLK] = &clk_smd_rpm_mmnrt_clk,
-	[RPM_SMD_MMNRT_A_CLK] = &clk_smd_rpm_mmnrt_a_clk,
 	[RPM_SMD_SNOC_PERIPH_CLK] = &clk_smd_rpm_bus_0_snoc_periph_clk,
 	[RPM_SMD_SNOC_PERIPH_A_CLK] = &clk_smd_rpm_bus_0_snoc_periph_a_clk,
 	[RPM_SMD_SNOC_LPASS_CLK] = &clk_smd_rpm_bus_5_snoc_lpass_clk,
@@ -1249,6 +1190,8 @@ static struct clk_smd_rpm *qcm2290_clks[] = {
 static const struct rpm_smd_clk_desc rpm_clk_qcm2290 = {
 	.clks = qcm2290_clks,
 	.num_clks = ARRAY_SIZE(qcm2290_clks),
+	.icc_clks = sm_qnoc_icc_clks,
+	.num_icc_clks = ARRAY_SIZE(sm_qnoc_icc_clks)
 };
 
 static const struct of_device_id rpm_smd_clk_match_table[] = {
@@ -1332,6 +1275,15 @@ static int rpm_smd_clk_probe(struct platform_device *pdev)
 			goto err;
 	}
 
+	for (i = 0; i < desc->num_icc_clks; i++) {
+		if (!desc->icc_clks[i])
+			continue;
+
+		ret = clk_smd_rpm_handoff(desc->icc_clks[i]);
+		if (ret)
+			goto err;
+	}
+
 	if (!desc->scaling_before_handover) {
 		ret = clk_smd_rpm_enable_scaling();
 		if (ret)

-- 
2.41.0


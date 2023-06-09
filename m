Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E2672A496
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 22:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbjFIUUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 16:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbjFIUUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 16:20:04 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D63448E
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 13:19:40 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f62d93f38aso2809453e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 13:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686341978; x=1688933978;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V0P43FwyR0o/2PWnT5Mlya33wlLUHMbI8BwlA6DLTT0=;
        b=urFGFFFOc+iA/KgcUWZ567Q1o66WUi+J3qAqA5JBpyyxyLG8oz0g//ft8S75xGnqus
         EJxrk8dBPV07iJjTXMAYG4eydsGdNhQ4y4jQ5gjV9YTeqqcEY/Mq48yADSb8ICnkHc9w
         KQu6D2hGlA2nuFML42Q4wzGlNovvrUXkuXg/IYQoHv6jX67g05w7BQTUwUBxMsDQsBkx
         YvEpS5z3Jyr1Cip/FG/gRlHGHa7rfml/x3hPNRF3fBYTE/eiof3hbd62oq6R2+6GGqwc
         8OZNv0dyBCL19K/3nhPEUQ2g6oH6rHwyc4dT3zjxO6cpcJJK9MRpEOGwXZ10Zlmb83/I
         KaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686341978; x=1688933978;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V0P43FwyR0o/2PWnT5Mlya33wlLUHMbI8BwlA6DLTT0=;
        b=TY1gxhbCqrUa2O6He5finzMujgQP8p6jnS169UyJCdwzW1NS8muZryzqibKBcXAvlG
         Kgl/+7lN+aRJE+VLfITGv9EmVgsmGFNTL3QrJR6e0WhU8r7LtTMqXq9JVf1cEVJvbjRD
         6I+sPaZtF1GoW6aY2lGQIhrzVMx6Zgn19RNYqSq3ljlUJKSl3c1HLw8Bjrb8CR3UkKKP
         wA+Nvei+CzzI8pqh9qIeGGCHLe5ps5lEUU4dzAP6Lq0BEBm2eFtNG2Jym5CS54+f1Rh1
         5so63SVdoHsmZ90o3azG3r8+Y25hBKvqYapjBrgSs2OOKxpVMxlBwbrKN6+77CsYrhLq
         Yasg==
X-Gm-Message-State: AC+VfDxIOHAH9Z3rZXfolYsaSAV+tLFH5Ss9gadqnngXZPoOXOkyCeux
        vWT5X6Kq+k4EIhxQ9gD8PCs0pw==
X-Google-Smtp-Source: ACHHUZ5DrUU35tPKQuuKtHlSMVVyTF1ys+rPEaXEQRPHlqSQwLOggFSrigG6PLmfXmRqIxexX0J9VA==
X-Received: by 2002:ac2:505b:0:b0:4f6:19cc:36e0 with SMTP id a27-20020ac2505b000000b004f619cc36e0mr1635230lfm.39.1686341978524;
        Fri, 09 Jun 2023 13:19:38 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id b18-20020ac25632000000b004f628eb7884sm641349lff.232.2023.06.09.13.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 13:19:38 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 09 Jun 2023 22:19:23 +0200
Subject: [PATCH v2 18/22] clk: qcom: smd-rpm: Separate out interconnect bus
 clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v2-18-e5934b07d813@linaro.org>
References: <20230526-topic-smd_icc-v2-0-e5934b07d813@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v2-0-e5934b07d813@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686341953; l=26677;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=PYV9NPiLaxXrK8A3mWbRdzkavjHebPcaZ0bfC9RHuZA=;
 b=oZan9LkY1hPZFqFkrAVnPS4KQ8Bd/d60qUNJdGo3NZIj2siY/1ZKWV23le3y/VpNCI4DZ5Cdv
 3tOcLUih2zIDIZ/Ep6e/9G2kUfR2JL1B8M6DXjAx6lnlsPhGll64YTc
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

The interconnect bus clocks are now handled within the ICC framework.
They still however need to get a kickstart *before* we call
clk_smd_rpm_enable_scaling(), or RPM will assume that they should all
be running at 0 kHz and the system will inevitably die.

Separate them out to ensure such a kickstart can still take place.

As a happy accident, the file got smaller:

Total: Before=41951, After=41555, chg -0.94%

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/clk-smd-rpm.c | 278 +++++++++++++++++------------------------
 1 file changed, 115 insertions(+), 163 deletions(-)

diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index 482fe30ee6f0..f8f5977408e0 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -168,6 +168,14 @@ struct clk_smd_rpm {
 struct rpm_smd_clk_desc {
 	struct clk_smd_rpm **clks;
 	size_t num_clks;
+
+	/*
+	 * Interconnect clocks are managed by the icc framework, this driver
+	 * only kickstarts them so that they don't get gated between
+	 * clk_smd_rpm_enable_scaling() and interconnect driver initialization.
+	 */
+	struct clk_smd_rpm **icc_clks;
+	size_t num_icc_clks;
 	bool scaling_before_handover;
 };
 
@@ -507,13 +515,69 @@ DEFINE_CLK_SMD_RPM_XO_BUFFER(div_clk1, 11, 19200000);
 DEFINE_CLK_SMD_RPM_XO_BUFFER(div_clk2, 12, 19200000);
 DEFINE_CLK_SMD_RPM_XO_BUFFER(div_clk3, 13, 19200000);
 
+static struct clk_smd_rpm *bimc_pcnoc_icc_clks[] = {
+	&clk_smd_rpm_bimc_clk,
+	&clk_smd_rpm_bus_0_pcnoc_clk,
+};
+
+static struct clk_smd_rpm *bimc_pcnoc_snoc_icc_clks[] = {
+	&clk_smd_rpm_bimc_clk,
+	&clk_smd_rpm_bus_0_pcnoc_clk,
+	&clk_smd_rpm_bus_1_snoc_clk,
+};
+
+static struct clk_smd_rpm *bimc_pcnoc_snoc_smmnoc_icc_clks[] = {
+	&clk_smd_rpm_bimc_clk,
+	&clk_smd_rpm_bus_0_pcnoc_clk,
+	&clk_smd_rpm_bus_1_snoc_clk,
+	&clk_smd_rpm_bus_2_sysmmnoc_clk,
+};
+
+static struct clk_smd_rpm *bimc_pcnoc_snoc_cnoc_ocmem_icc_clks[] = {
+	&clk_smd_rpm_bimc_clk,
+	&clk_smd_rpm_bus_0_pcnoc_clk,
+	&clk_smd_rpm_bus_1_snoc_clk,
+	&clk_smd_rpm_bus_2_cnoc_clk,
+	&clk_smd_rpm_ocmemgx_clk,
+};
+
+static struct clk_smd_rpm *msm8996_icc_clks[] = {
+	&clk_smd_rpm_bimc_clk,
+	&clk_smd_rpm_branch_aggre1_noc_clk,
+	&clk_smd_rpm_branch_aggre2_noc_clk,
+	&clk_smd_rpm_bus_0_pcnoc_clk,
+	&clk_smd_rpm_bus_1_snoc_clk,
+	&clk_smd_rpm_bus_2_cnoc_clk,
+	&clk_smd_rpm_mmssnoc_axi_rpm_clk,
+};
+
+static struct clk_smd_rpm *msm8998_icc_clks[] = {
+	&clk_smd_rpm_aggre1_noc_clk,
+	&clk_smd_rpm_aggre2_noc_clk,
+	&clk_smd_rpm_bimc_clk,
+	&clk_smd_rpm_bus_1_snoc_clk,
+	&clk_smd_rpm_bus_2_cnoc_clk,
+	&clk_smd_rpm_mmssnoc_axi_rpm_clk,
+};
+
+static struct clk_smd_rpm *sdm660_icc_clks[] = {
+	&clk_smd_rpm_aggre2_noc_clk,
+	&clk_smd_rpm_bimc_clk,
+	&clk_smd_rpm_bus_1_snoc_clk,
+	&clk_smd_rpm_bus_2_cnoc_clk,
+	&clk_smd_rpm_mmssnoc_axi_rpm_clk,
+};
+
+static struct clk_smd_rpm *sm_qnoc_icc_clks[] = {
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
@@ -539,15 +603,11 @@ static struct clk_smd_rpm *msm8909_clks[] = {
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
@@ -571,21 +631,15 @@ static struct clk_smd_rpm *msm8916_clks[] = {
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
@@ -605,19 +659,13 @@ static struct clk_smd_rpm *msm8917_clks[] = {
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
@@ -641,25 +689,17 @@ static struct clk_smd_rpm *msm8936_clks[] = {
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
@@ -693,20 +733,14 @@ static struct clk_smd_rpm *msm8974_clks[] = {
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
@@ -727,24 +761,15 @@ static struct clk_smd_rpm *msm8976_clks[] = {
 
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
@@ -786,23 +811,15 @@ static struct clk_smd_rpm *msm8992_clks[] = {
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
@@ -846,29 +863,17 @@ static struct clk_smd_rpm *msm8994_clks[] = {
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
@@ -900,6 +905,8 @@ static struct clk_smd_rpm *msm8996_clks[] = {
 static const struct rpm_smd_clk_desc rpm_clk_msm8996 = {
 	.clks = msm8996_clks,
 	.num_clks = ARRAY_SIZE(msm8996_clks),
+	.icc_clks = msm8996_icc_clks,
+	.num_icc_clks = ARRAY_SIZE(msm8996_icc_clks),
 };
 
 static struct clk_smd_rpm *qcs404_clks[] = {
@@ -928,19 +935,15 @@ static struct clk_smd_rpm *qcs404_clks[] = {
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
@@ -963,12 +966,6 @@ static struct clk_smd_rpm *msm8998_clks[] = {
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
@@ -988,27 +985,19 @@ static struct clk_smd_rpm *msm8998_clks[] = {
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
@@ -1034,15 +1023,13 @@ static struct clk_smd_rpm *sdm660_clks[] = {
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
@@ -1056,21 +1043,15 @@ static struct clk_smd_rpm *mdm9607_clks[] = {
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
@@ -1092,23 +1073,19 @@ static struct clk_smd_rpm *msm8953_clks[] = {
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
@@ -1119,12 +1096,6 @@ static struct clk_smd_rpm *sm6125_clks[] = {
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
@@ -1134,34 +1105,24 @@ static struct clk_smd_rpm *sm6125_clks[] = {
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
@@ -1175,27 +1136,17 @@ static struct clk_smd_rpm *sm6115_clks[] = {
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
@@ -1212,31 +1163,21 @@ static struct clk_smd_rpm *sm6375_clks[] = {
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
@@ -1258,6 +1199,8 @@ static struct clk_smd_rpm *qcm2290_clks[] = {
 static const struct rpm_smd_clk_desc rpm_clk_qcm2290 = {
 	.clks = qcm2290_clks,
 	.num_clks = ARRAY_SIZE(qcm2290_clks),
+	.icc_clks = sm_qnoc_icc_clks,
+	.num_icc_clks = ARRAY_SIZE(sm_qnoc_icc_clks)
 };
 
 static const struct of_device_id rpm_smd_clk_match_table[] = {
@@ -1333,6 +1276,15 @@ static int rpm_smd_clk_probe(struct platform_device *pdev)
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


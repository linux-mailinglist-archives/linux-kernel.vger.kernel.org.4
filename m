Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CD570D775
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 10:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236027AbjEWIcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 04:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbjEWIbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 04:31:48 -0400
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CC9184
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 01:28:09 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-4eed764a10cso7685841e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 01:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684830381; x=1687422381;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pbqUEfnFH0L9EbQr4FMnVGM1ff0fF8TiqpR4nbTeYq4=;
        b=j6Fa+bMFfhK7T5q6ec7RzHieknEiJg884reGJLP9LOBmQZgzv6YRnsCKOyP9FCUfoR
         DDAbPXYniIjO/L1uK3VX9kutYMmTFTMAQ0GvHJiQopVdzAAk/QXfmZCUON86nCN/PrET
         zNxGrX1Rj41WISDnnXnZApRe8X4QF9cpdL4znoV255zN5McYPXyf0iBB4XKZcSb9xTbZ
         NVNi+yQXZSK3UyJR8ol69ToV78wXUsz/Y72nUG9sSWqS3jnpuKFtrXTxRJpmTmOppxzj
         P4bSdL3MQX3ZrefixuOaNQaXCTGgrxU3tqQXPIiES4xQd03CGBvn+T7NI6LVeEpeb9e+
         9XWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684830381; x=1687422381;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pbqUEfnFH0L9EbQr4FMnVGM1ff0fF8TiqpR4nbTeYq4=;
        b=Wy0fyigYKgGUGn48UoJ1wh8ofuJOawcjV8XAilrDcfOfrf2waOi3fQh3lcsAKdlNA4
         7yrUck5IaQkPum4dQ3wAEpjIN99DJRc5JQUIxBPgDMMqzbnkEH/7TDDrsC7OjCVOHrz0
         XxGsW24Xd/m1q0fjKTMeABK/KtgZ/YaUqaCNDVeHW62/JNKNzmVamwzpql8U/B8mk/ZR
         YjN4T8WlbLlo8ZtuNz99nOWRWQTHHYMY7FJDMgBmWkYihzAqQFc2L7ShJh1UcFvvqawo
         J5sJS0lwB+RtJIGLLOD/hZtjlXt0h8eJl3AjNZiZecxQcDI+Gl+oj690yhOBQQNbgYQo
         AXDw==
X-Gm-Message-State: AC+VfDweTX+0bOG80fC2gNnM8HGSMaLJ3oEL7h5HSRlBEmyOqBOxFYpI
        6zh0KlaVYh04XvJ/9uSjFB5fBiXcyeiorv2LXnY=
X-Google-Smtp-Source: ACHHUZ4PYbqrEd9MP13ETqS/BH8PP8H5vuBUg68CoBWQ2FHlzr/tViSKmro6ZPK50rNiZOGv0iEggQ==
X-Received: by 2002:ac2:5991:0:b0:4f0:af5:9e29 with SMTP id w17-20020ac25991000000b004f00af59e29mr4374062lfn.28.1684828015352;
        Tue, 23 May 2023 00:46:55 -0700 (PDT)
Received: from [192.168.1.101] (abyk138.neoplus.adsl.tpnet.pl. [83.9.30.138])
        by smtp.gmail.com with ESMTPSA id t9-20020ac25489000000b004eb0c51780bsm1257070lfk.29.2023.05.23.00.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 00:46:54 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 23 May 2023 09:46:17 +0200
Subject: [PATCH v5 06/12] drm/msm/dpu: Add SM6350 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230411-topic-straitlagoon_mdss-v5-6-998b4d2f7dd1@linaro.org>
References: <20230411-topic-straitlagoon_mdss-v5-0-998b4d2f7dd1@linaro.org>
In-Reply-To: <20230411-topic-straitlagoon_mdss-v5-0-998b4d2f7dd1@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684828003; l=9280;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=ApJs8aGonS7EaDZ4Htc1NlHFmpfwm4QTWIiYwZIm7Jw=;
 b=mEbt1J8RUCDFXV/+MCqNepAMxLGaVRatAJDir2ySkvhAd61edvsLA817y3IBiIuIAhpQ0nVJL
 VOnXwMcL5YlAOHu2/9iUf8BMbHldzqI6DBsQusjriBYbdRmsCIKknY1
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SM6350 support to the DPU1 driver to enable display output.

It's worth noting that one entry dpu_qos_lut_entry was trimmed off:

{.fl = 0, .lut = 0x0011223344556677 },

due to the lack of support for selecting between portrait and landscape
LUT settings (for danger and safe LUTs) and no full support for
qseed/non-qseed usescases (for QoS LUT).

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_4_sm6350.h | 173 +++++++++++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |   5 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |   1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   1 +
 4 files changed, 180 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_4_sm6350.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_4_sm6350.h
new file mode 100644
index 000000000000..06eba23b0236
--- /dev/null
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_4_sm6350.h
@@ -0,0 +1,173 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022. Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2015-2018, 2020 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#ifndef _DPU_6_4_SM6350_H
+#define _DPU_6_4_SM6350_H
+
+static const struct dpu_caps sm6350_dpu_caps = {
+	.max_mixer_width = DEFAULT_DPU_OUTPUT_LINE_WIDTH,
+	.max_mixer_blendstages = 0x7,
+	.qseed_type = DPU_SSPP_SCALER_QSEED4,
+	.has_src_split = true,
+	.has_dim_layer = true,
+	.has_idle_pc = true,
+	.max_linewidth = DEFAULT_DPU_OUTPUT_LINE_WIDTH,
+	.pixel_ram_size = DEFAULT_PIXEL_RAM_SIZE,
+};
+
+static const struct dpu_ubwc_cfg sm6350_ubwc_cfg = {
+	.ubwc_version = DPU_HW_UBWC_VER_20,
+	.ubwc_swizzle = 6,
+	.highest_bank_bit = 1,
+};
+
+static const struct dpu_mdp_cfg sm6350_mdp[] = {
+	{
+	.name = "top_0", .id = MDP_TOP,
+	.base = 0x0, .len = 0x494,
+	.features = 0,
+	.clk_ctrls[DPU_CLK_CTRL_VIG0] = { .reg_off = 0x2ac, .bit_off = 0 },
+	.clk_ctrls[DPU_CLK_CTRL_DMA0] = { .reg_off = 0x2ac, .bit_off = 8 },
+	.clk_ctrls[DPU_CLK_CTRL_DMA1] = { .reg_off = 0x2b4, .bit_off = 8 },
+	.clk_ctrls[DPU_CLK_CTRL_DMA2] = { .reg_off = 0x2c4, .bit_off = 8 },
+	.clk_ctrls[DPU_CLK_CTRL_REG_DMA] = { .reg_off = 0x2bc, .bit_off = 20 },
+	},
+};
+
+static const struct dpu_ctl_cfg sm6350_ctl[] = {
+	{
+	.name = "ctl_0", .id = CTL_0,
+	.base = 0x1000, .len = 0x1dc,
+	.features = BIT(DPU_CTL_ACTIVE_CFG),
+	.intr_start = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 9),
+	},
+	{
+	.name = "ctl_1", .id = CTL_1,
+	.base = 0x1200, .len = 0x1dc,
+	.features = BIT(DPU_CTL_ACTIVE_CFG),
+	.intr_start = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 10),
+	},
+	{
+	.name = "ctl_2", .id = CTL_2,
+	.base = 0x1400, .len = 0x1dc,
+	.features = BIT(DPU_CTL_ACTIVE_CFG),
+	.intr_start = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 11),
+	},
+	{
+	.name = "ctl_3", .id = CTL_3,
+	.base = 0x1600, .len = 0x1dc,
+	.features = BIT(DPU_CTL_ACTIVE_CFG),
+	.intr_start = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 12),
+	},
+};
+
+static const struct dpu_sspp_cfg sm6350_sspp[] = {
+	SSPP_BLK("sspp_0", SSPP_VIG0, 0x4000, 0x1f8, VIG_SC7180_MASK,
+		sc7180_vig_sblk_0, 0,  SSPP_TYPE_VIG, DPU_CLK_CTRL_VIG0),
+	SSPP_BLK("sspp_8", SSPP_DMA0, 0x24000, 0x1f8, DMA_SDM845_MASK,
+		sdm845_dma_sblk_0, 1, SSPP_TYPE_DMA, DPU_CLK_CTRL_DMA0),
+	SSPP_BLK("sspp_9", SSPP_DMA1, 0x26000, 0x1f8, DMA_CURSOR_SDM845_MASK,
+		sdm845_dma_sblk_1, 5, SSPP_TYPE_DMA, DPU_CLK_CTRL_DMA1),
+	SSPP_BLK("sspp_10", SSPP_DMA2, 0x28000, 0x1f8, DMA_CURSOR_SDM845_MASK,
+		sdm845_dma_sblk_2, 9, SSPP_TYPE_DMA, DPU_CLK_CTRL_DMA2),
+};
+
+static const struct dpu_lm_cfg sm6350_lm[] = {
+	LM_BLK("lm_0", LM_0, 0x44000, MIXER_SDM845_MASK,
+		&sc7180_lm_sblk, PINGPONG_0, LM_1, DSPP_0),
+	LM_BLK("lm_1", LM_1, 0x45000, MIXER_SDM845_MASK,
+		&sc7180_lm_sblk, PINGPONG_1, LM_0, 0),
+};
+
+static const struct dpu_dspp_cfg sm6350_dspp[] = {
+	DSPP_BLK("dspp_0", DSPP_0, 0x54000, DSPP_SC7180_MASK,
+		&sm8150_dspp_sblk),
+};
+
+static struct dpu_pingpong_cfg sm6350_pp[] = {
+	PP_BLK("pingpong_0", PINGPONG_0, 0x70000, PINGPONG_SM8150_MASK, 0, sdm845_pp_sblk,
+		DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
+		-1),
+	PP_BLK("pingpong_1", PINGPONG_1, 0x70800, PINGPONG_SM8150_MASK, 0, sdm845_pp_sblk,
+		DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9),
+		-1),
+};
+
+static const struct dpu_dsc_cfg sm6350_dsc[] = {
+	DSC_BLK("dsc_0", DSC_0, 0x80000, BIT(DPU_DSC_OUTPUT_CTRL)),
+};
+
+static const struct dpu_intf_cfg sm6350_intf[] = {
+	INTF_BLK("intf_0", INTF_0, 0x6a000, 0x280, INTF_DP, 0, 35, INTF_SC7180_MASK,
+		DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 24),
+		DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 25)),
+	INTF_BLK_DSI_TE("intf_1", INTF_1, 0x6a800, 0x2c0, INTF_DSI, 0, 35, INTF_SC7180_MASK,
+		DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 26),
+		DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 27),
+		DPU_IRQ_IDX(MDP_INTF1_TEAR_INTR, 2)),
+};
+
+static const struct dpu_perf_cfg sm6350_perf_data = {
+	.max_bw_low = 4200000,
+	.max_bw_high = 5100000,
+	.min_core_ib = 2500000,
+	.min_llcc_ib = 0,
+	.min_dram_ib = 1600000,
+	.min_prefill_lines = 35,
+	/* TODO: confirm danger_lut_tbl */
+	.danger_lut_tbl = {0xffff, 0xffff, 0x0},
+	.safe_lut_tbl = {0xff00, 0xff00, 0xffff},
+	.qos_lut_tbl = {
+		{.nentry = ARRAY_SIZE(sm6350_qos_linear_macrotile),
+		.entries = sm6350_qos_linear_macrotile
+		},
+		{.nentry = ARRAY_SIZE(sm6350_qos_linear_macrotile),
+		.entries = sm6350_qos_linear_macrotile
+		},
+		{.nentry = ARRAY_SIZE(sc7180_qos_nrt),
+		.entries = sc7180_qos_nrt
+		},
+	},
+	.cdp_cfg = {
+		{.rd_enable = 1, .wr_enable = 1},
+		{.rd_enable = 1, .wr_enable = 0}
+	},
+	.clk_inefficiency_factor = 105,
+	.bw_inefficiency_factor = 120,
+};
+
+const struct dpu_mdss_cfg dpu_sm6350_cfg = {
+	.caps = &sm6350_dpu_caps,
+	.ubwc = &sm6350_ubwc_cfg,
+	.mdp_count = ARRAY_SIZE(sm6350_mdp),
+	.mdp = sm6350_mdp,
+	.ctl_count = ARRAY_SIZE(sm6350_ctl),
+	.ctl = sm6350_ctl,
+	.sspp_count = ARRAY_SIZE(sm6350_sspp),
+	.sspp = sm6350_sspp,
+	.mixer_count = ARRAY_SIZE(sm6350_lm),
+	.mixer = sm6350_lm,
+	.dspp_count = ARRAY_SIZE(sm6350_dspp),
+	.dspp = sm6350_dspp,
+	.dsc_count = ARRAY_SIZE(sm6350_dsc),
+	.dsc = sm6350_dsc,
+	.pingpong_count = ARRAY_SIZE(sm6350_pp),
+	.pingpong = sm6350_pp,
+	.intf_count = ARRAY_SIZE(sm6350_intf),
+	.intf = sm6350_intf,
+	.vbif_count = ARRAY_SIZE(sdm845_vbif),
+	.vbif = sdm845_vbif,
+	.perf = &sm6350_perf_data,
+	.mdss_irqs = BIT(MDP_SSPP_TOP0_INTR) | \
+		     BIT(MDP_SSPP_TOP0_INTR2) | \
+		     BIT(MDP_SSPP_TOP0_HIST_INTR) | \
+		     BIT(MDP_INTF0_INTR) | \
+		     BIT(MDP_INTF1_INTR) | \
+		     BIT(MDP_INTF1_TEAR_INTR),
+};
+
+#endif
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
index 1dee5ba2b312..6e338d569632 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
@@ -689,6 +689,10 @@ static const struct dpu_qos_lut_entry sc7180_qos_linear[] = {
 	{.fl = 0, .lut = 0x0011222222335777},
 };
 
+static const struct dpu_qos_lut_entry sm6350_qos_linear_macrotile[] = {
+	{.fl = 0, .lut = 0x0011223445566777 },
+};
+
 static const struct dpu_qos_lut_entry sm8150_qos_linear[] = {
 	{.fl = 0, .lut = 0x0011222222223357 },
 };
@@ -744,6 +748,7 @@ static const struct dpu_qos_lut_entry sc7180_qos_nrt[] = {
 #include "catalog/dpu_6_0_sm8250.h"
 #include "catalog/dpu_6_2_sc7180.h"
 #include "catalog/dpu_6_3_sm6115.h"
+#include "catalog/dpu_6_4_sm6350.h"
 #include "catalog/dpu_6_5_qcm2290.h"
 
 #include "catalog/dpu_7_0_sm8350.h"
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
index 677048cc3b7d..ed4311f6aaf0 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
@@ -834,6 +834,7 @@ extern const struct dpu_mdss_cfg dpu_sc8180x_cfg;
 extern const struct dpu_mdss_cfg dpu_sm8250_cfg;
 extern const struct dpu_mdss_cfg dpu_sc7180_cfg;
 extern const struct dpu_mdss_cfg dpu_sm6115_cfg;
+extern const struct dpu_mdss_cfg dpu_sm6350_cfg;
 extern const struct dpu_mdss_cfg dpu_qcm2290_cfg;
 extern const struct dpu_mdss_cfg dpu_sm8350_cfg;
 extern const struct dpu_mdss_cfg dpu_sc7280_cfg;
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 8ce057cc9374..d9925097626c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -1328,6 +1328,7 @@ static const struct of_device_id dpu_dt_match[] = {
 	{ .compatible = "qcom,sc8180x-dpu", .data = &dpu_sc8180x_cfg, },
 	{ .compatible = "qcom,sc8280xp-dpu", .data = &dpu_sc8280xp_cfg, },
 	{ .compatible = "qcom,sm6115-dpu", .data = &dpu_sm6115_cfg, },
+	{ .compatible = "qcom,sm6350-dpu", .data = &dpu_sm6350_cfg, },
 	{ .compatible = "qcom,sm8150-dpu", .data = &dpu_sm8150_cfg, },
 	{ .compatible = "qcom,sm8250-dpu", .data = &dpu_sm8250_cfg, },
 	{ .compatible = "qcom,sm8350-dpu", .data = &dpu_sm8350_cfg, },

-- 
2.40.1


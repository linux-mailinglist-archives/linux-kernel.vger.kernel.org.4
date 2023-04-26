Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D7C6EFD83
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 00:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240067AbjDZWiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 18:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238345AbjDZWhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 18:37:32 -0400
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [IPv6:2001:4b7a:2000:18::163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E463C2F;
        Wed, 26 Apr 2023 15:37:30 -0700 (PDT)
Received: from Marijn-Arch-PC.localdomain (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 4FD0D2022A;
        Thu, 27 Apr 2023 00:37:28 +0200 (CEST)
From:   Marijn Suijten <marijn.suijten@somainline.org>
Date:   Thu, 27 Apr 2023 00:37:29 +0200
Subject: [PATCH v4 15/22] drm/msm/dpu: Disable MDP vsync source selection
 on DPU 5.0.0 and above
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230411-dpu-intf-te-v4-15-27ce1a5ab5c6@somainline.org>
References: <20230411-dpu-intf-te-v4-0-27ce1a5ab5c6@somainline.org>
In-Reply-To: <20230411-dpu-intf-te-v4-0-27ce1a5ab5c6@somainline.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Adam Skladowski <a39.skl@gmail.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Robert Foss <rfoss@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since hardware revision 5.0.0 the TE configuration moved out of the
PINGPONG block into the INTF block, including vsync source selection
that was previously part of MDP top.  Writing to the MDP_VSYNC_SEL
register has no effect anymore and is omitted downstream via the
DPU/SDE_MDP_VSYNC_SEL feature flag.  This flag is only added to INTF
blocks used by hardware prior to 5.0.0.

The code that writes to these registers in the INTF block will follow in
subsequent patches.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h    |  2 +-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h |  2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |  3 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c         | 50 +++++++++++++++-------
 4 files changed, 40 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
index b7845591c384b..6906f8046b9e0 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
@@ -30,7 +30,7 @@ static const struct dpu_mdp_cfg msm8998_mdp[] = {
 	{
 	.name = "top_0", .id = MDP_TOP,
 	.base = 0x0, .len = 0x458,
-	.features = 0,
+	.features = BIT(DPU_MDP_VSYNC_SEL),
 	.clk_ctrls[DPU_CLK_CTRL_VIG0] = { .reg_off = 0x2ac, .bit_off = 0 },
 	.clk_ctrls[DPU_CLK_CTRL_VIG1] = { .reg_off = 0x2b4, .bit_off = 0 },
 	.clk_ctrls[DPU_CLK_CTRL_VIG2] = { .reg_off = 0x2bc, .bit_off = 0 },
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h
index 5b9b3b99f1b5f..14ce397800d5b 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h
@@ -30,7 +30,7 @@ static const struct dpu_mdp_cfg sdm845_mdp[] = {
 	{
 	.name = "top_0", .id = MDP_TOP,
 	.base = 0x0, .len = 0x45c,
-	.features = BIT(DPU_MDP_AUDIO_SELECT),
+	.features = BIT(DPU_MDP_AUDIO_SELECT) | BIT(DPU_MDP_VSYNC_SEL),
 	.clk_ctrls[DPU_CLK_CTRL_VIG0] = { .reg_off = 0x2ac, .bit_off = 0 },
 	.clk_ctrls[DPU_CLK_CTRL_VIG1] = { .reg_off = 0x2b4, .bit_off = 0 },
 	.clk_ctrls[DPU_CLK_CTRL_VIG2] = { .reg_off = 0x2bc, .bit_off = 0 },
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
index 71584cd56fd75..599e177b89dd2 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
@@ -48,6 +48,8 @@ enum {
  * @DPU_MDP_UBWC_1_5,      Universal Bandwidth compression version 1.5
  * @DPU_MDP_PERIPH_0_REMOVED Indicates that access to periph top0 block results
  *			   in a failure
+ * @DPU_MDP_VSYNC_SEL      Enables vsync source selection via MDP_VSYNC_SEL register
+ *                         (moved into INTF block since DPU 5.0.0)
  * @DPU_MDP_MAX            Maximum value
 
  */
@@ -59,6 +61,7 @@ enum {
 	DPU_MDP_UBWC_1_5,
 	DPU_MDP_AUDIO_SELECT,
 	DPU_MDP_PERIPH_0_REMOVED,
+	DPU_MDP_VSYNC_SEL,
 	DPU_MDP_MAX
 };
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c
index 2bb02e17ee52c..963bdb5e02521 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c
@@ -130,24 +130,12 @@ static void dpu_hw_setup_vsync_source(struct dpu_hw_mdp *mdp,
 		struct dpu_vsync_source_cfg *cfg)
 {
 	struct dpu_hw_blk_reg_map *c;
-	u32 reg, wd_load_value, wd_ctl, wd_ctl2, i;
-	static const u32 pp_offset[PINGPONG_MAX] = {0xC, 0x8, 0x4, 0x13, 0x18};
+	u32 reg, wd_load_value, wd_ctl, wd_ctl2;
 
-	if (!mdp || !cfg || (cfg->pp_count > ARRAY_SIZE(cfg->ppnumber)))
+	if (!mdp || !cfg)
 		return;
 
 	c = &mdp->hw;
-	reg = DPU_REG_READ(c, MDP_VSYNC_SEL);
-	for (i = 0; i < cfg->pp_count; i++) {
-		int pp_idx = cfg->ppnumber[i] - PINGPONG_0;
-
-		if (pp_idx >= ARRAY_SIZE(pp_offset))
-			continue;
-
-		reg &= ~(0xf << pp_offset[pp_idx]);
-		reg |= (cfg->vsync_source & 0xf) << pp_offset[pp_idx];
-	}
-	DPU_REG_WRITE(c, MDP_VSYNC_SEL, reg);
 
 	if (cfg->vsync_source >= DPU_VSYNC_SOURCE_WD_TIMER_4 &&
 			cfg->vsync_source <= DPU_VSYNC_SOURCE_WD_TIMER_0) {
@@ -194,6 +182,33 @@ static void dpu_hw_setup_vsync_source(struct dpu_hw_mdp *mdp,
 	}
 }
 
+static void dpu_hw_setup_vsync_source_and_vsync_sel(struct dpu_hw_mdp *mdp,
+		struct dpu_vsync_source_cfg *cfg)
+{
+	struct dpu_hw_blk_reg_map *c;
+	u32 reg, i;
+	static const u32 pp_offset[PINGPONG_MAX] = {0xC, 0x8, 0x4, 0x13, 0x18};
+
+	if (!mdp || !cfg || (cfg->pp_count > ARRAY_SIZE(cfg->ppnumber)))
+		return;
+
+	c = &mdp->hw;
+
+	reg = DPU_REG_READ(c, MDP_VSYNC_SEL);
+	for (i = 0; i < cfg->pp_count; i++) {
+		int pp_idx = cfg->ppnumber[i] - PINGPONG_0;
+
+		if (pp_idx >= ARRAY_SIZE(pp_offset))
+			continue;
+
+		reg &= ~(0xf << pp_offset[pp_idx]);
+		reg |= (cfg->vsync_source & 0xf) << pp_offset[pp_idx];
+	}
+	DPU_REG_WRITE(c, MDP_VSYNC_SEL, reg);
+
+	dpu_hw_setup_vsync_source(mdp, cfg);
+}
+
 static void dpu_hw_get_safe_status(struct dpu_hw_mdp *mdp,
 		struct dpu_danger_safe_status *status)
 {
@@ -241,7 +256,12 @@ static void _setup_mdp_ops(struct dpu_hw_mdp_ops *ops,
 	ops->setup_split_pipe = dpu_hw_setup_split_pipe;
 	ops->setup_clk_force_ctrl = dpu_hw_setup_clk_force_ctrl;
 	ops->get_danger_status = dpu_hw_get_danger_status;
-	ops->setup_vsync_source = dpu_hw_setup_vsync_source;
+
+	if (cap & BIT(DPU_MDP_VSYNC_SEL))
+		ops->setup_vsync_source = dpu_hw_setup_vsync_source_and_vsync_sel;
+	else
+		ops->setup_vsync_source = dpu_hw_setup_vsync_source;
+
 	ops->get_safe_status = dpu_hw_get_safe_status;
 
 	if (cap & BIT(DPU_MDP_AUDIO_SELECT))

-- 
2.40.1


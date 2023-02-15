Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A180698883
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 00:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjBOXCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 18:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjBOXCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 18:02:36 -0500
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [5.144.164.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818A538EB7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 15:02:32 -0800 (PST)
Received: from Marijn-Arch-PC.localdomain (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 29EE420206;
        Thu, 16 Feb 2023 00:02:30 +0100 (CET)
From:   Marijn Suijten <marijn.suijten@somainline.org>
Date:   Thu, 16 Feb 2023 00:02:23 +0100
Subject: [PATCH 1/3] drm/msm/dpu: Read previously-uninitialized SSPP scaler
 version from hw
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230215-sspp-scaler-version-v1-1-416b1500b85b@somainline.org>
References: <20230215-sspp-scaler-version-v1-0-416b1500b85b@somainline.org>
In-Reply-To: <20230215-sspp-scaler-version-v1-0-416b1500b85b@somainline.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Archit Taneja <architt@codeaurora.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        Sravanthi Kollukuduru <skolluku@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        phone-devel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DPU's catalog never assigned dpu_scaler_blk::version leading to
initialization code in dpu_hw_setup_scaler3 to wander the wrong
codepaths.  Instead of hardcoding the correct QSEED algorithm version,
read it back from a hardware register.

Note that this register is only available starting with QSEED3, where
0x1002 corresponds to QSEED3, 0x2004 to QSEED3LITE and 0x3000 to QSEED4.

Fixes: 25fdd5933e4c ("drm/msm: Add SDM845 DPU support")
Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h | 2 --
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c    | 8 +++++++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h    | 3 +++
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
index ddab9caebb18..96ce1766f4a1 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
@@ -324,11 +324,9 @@ struct dpu_src_blk {
 /**
  * struct dpu_scaler_blk: Scaler information
  * @info:   HW register and features supported by this sub-blk
- * @version: qseed block revision
  */
 struct dpu_scaler_blk {
 	DPU_HW_SUBBLK_INFO;
-	u32 version;
 };
 
 struct dpu_csc_blk {
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
index 4246ab0b3bee..d4e181e1378c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
@@ -430,7 +430,7 @@ static void _dpu_hw_sspp_setup_scaler3(struct dpu_hw_pipe *ctx,
 		return;
 
 	dpu_hw_setup_scaler3(&ctx->hw, scaler3_cfg, idx,
-			ctx->cap->sblk->scaler_blk.version,
+			ctx->version,
 			sspp->layout.format);
 }
 
@@ -807,6 +807,12 @@ struct dpu_hw_pipe *dpu_hw_sspp_init(enum dpu_sspp idx,
 	hw_pipe->mdp = &catalog->mdp[0];
 	hw_pipe->idx = idx;
 	hw_pipe->cap = cfg;
+
+	if (test_bit(DPU_SSPP_SCALER_QSEED3, &cfg->features) ||
+			test_bit(DPU_SSPP_SCALER_QSEED3LITE, &cfg->features) ||
+			test_bit(DPU_SSPP_SCALER_QSEED4, &cfg->features))
+		hw_pipe->version = _dpu_hw_sspp_get_scaler3_ver(hw_pipe);
+
 	_setup_layer_ops(hw_pipe, hw_pipe->cap->features);
 
 	return hw_pipe;
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h
index 0c95b7e64f6c..eeaf16c6af15 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h
@@ -352,6 +352,7 @@ struct dpu_hw_sspp_ops {
  * @hw: block hardware details
  * @catalog: back pointer to catalog
  * @mdp: pointer to associated mdp portion of the catalog
+ * @version: qseed block revision
  * @idx: pipe index
  * @cap: pointer to layer_cfg
  * @ops: pointer to operations possible for this pipe
@@ -362,6 +363,8 @@ struct dpu_hw_pipe {
 	const struct dpu_mdss_cfg *catalog;
 	const struct dpu_mdp_cfg *mdp;
 
+	u32 version;
+
 	/* Pipe */
 	enum dpu_sspp idx;
 	const struct dpu_sspp_cfg *cap;

-- 
2.39.2


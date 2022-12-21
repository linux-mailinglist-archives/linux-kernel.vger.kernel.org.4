Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAAD6539C2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 00:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235196AbiLUXUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 18:20:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235058AbiLUXUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 18:20:34 -0500
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [5.144.164.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13B126AD4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 15:20:16 -0800 (PST)
Received: from localhost.localdomain (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 6E193202F1;
        Thu, 22 Dec 2022 00:20:14 +0100 (CET)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Jani Nikula <jani.nikula@intel.com>,
        sunliming <sunliming@kylinos.cn>,
        Sam Ravnborg <sam@ravnborg.org>,
        Haowen Bai <baihaowen@meizu.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/8] drm/msm/dpu: Implement DSC binding to PP block for CTL V1
Date:   Thu, 22 Dec 2022 00:19:42 +0100
Message-Id: <20221221231943.1961117-8-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221221231943.1961117-1-marijn.suijten@somainline.org>
References: <20221221231943.1961117-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All V1 CTL blocks (active CTLs) explicitly bind the pixel output from a
DSC block to a PINGPONG block by setting the PINGPONG index in a DSC
hardware register.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c   |  3 +++
 .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h    |  9 +++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c    | 27 +++++++++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h    |  4 +++
 4 files changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index a158cd502d38..19fb20a6ed72 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -1829,6 +1829,9 @@ static void dpu_encoder_dsc_pipe_cfg(struct dpu_hw_dsc *hw_dsc,
 	if (hw_pp->ops.setup_dsc)
 		hw_pp->ops.setup_dsc(hw_pp);
 
+	if (hw_dsc->ops.dsc_bind_pingpong_blk)
+		hw_dsc->ops.dsc_bind_pingpong_blk(hw_dsc, true, hw_pp->idx);
+
 	if (hw_pp->ops.enable_dsc)
 		hw_pp->ops.enable_dsc(hw_pp);
 }
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
index c160dae95a69..96f849907aa2 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
@@ -268,6 +268,15 @@ enum {
 	DPU_VBIF_MAX
 };
 
+/**
+ * DSC features
+ * @DPU_DSC_OUTPUT_CTRL       Configure which PINGPONG block gets
+ *                            the pixel output from this DSC.
+ */
+enum {
+	DPU_DSC_OUTPUT_CTRL = 0x1,
+};
+
 /**
  * MACRO DPU_HW_BLK_INFO - information of HW blocks inside DPU
  * @name:              string name for debug purposes
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c
index 3662df698dae..619926da1441 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c
@@ -29,6 +29,8 @@
 #define DSC_RANGE_MAX_QP                0x0B0
 #define DSC_RANGE_BPG_OFFSET            0x0EC
 
+#define DSC_CTL(m) (0x1800 - 0x3FC * (m - DSC_0))
+
 static void dpu_hw_dsc_disable(struct dpu_hw_dsc *dsc)
 {
 	struct dpu_hw_blk_reg_map *c = &dsc->hw;
@@ -150,6 +152,29 @@ static void dpu_hw_dsc_config_thresh(struct dpu_hw_dsc *hw_dsc,
 	}
 }
 
+static void dpu_hw_dsc_bind_pingpong_blk(
+		struct dpu_hw_dsc *hw_dsc,
+		bool enable,
+		const enum dpu_pingpong pp)
+{
+	struct dpu_hw_blk_reg_map *c = &hw_dsc->hw;
+	int mux_cfg = 0xF;
+	u32 dsc_ctl_offset;
+
+	dsc_ctl_offset = DSC_CTL(hw_dsc->idx);
+
+	if (enable)
+		mux_cfg = (pp - PINGPONG_0) & 0x7;
+
+	DRM_DEBUG_KMS("%s dsc:%d %s pp:%d\n",
+			enable ? "Binding" : "Unbinding",
+			hw_dsc->idx - DSC_0,
+			enable ? "to" : "from",
+			pp - PINGPONG_0);
+
+	DPU_REG_WRITE(c, dsc_ctl_offset, mux_cfg);
+}
+
 static struct dpu_dsc_cfg *_dsc_offset(enum dpu_dsc dsc,
 				       const struct dpu_mdss_cfg *m,
 				       void __iomem *addr,
@@ -174,6 +199,8 @@ static void _setup_dsc_ops(struct dpu_hw_dsc_ops *ops,
 	ops->dsc_disable = dpu_hw_dsc_disable;
 	ops->dsc_config = dpu_hw_dsc_config;
 	ops->dsc_config_thresh = dpu_hw_dsc_config_thresh;
+	if (cap & BIT(DPU_DSC_OUTPUT_CTRL))
+		ops->dsc_bind_pingpong_blk = dpu_hw_dsc_bind_pingpong_blk;
 };
 
 struct dpu_hw_dsc *dpu_hw_dsc_init(enum dpu_dsc idx, void __iomem *addr,
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h
index c0b77fe1a696..ae9b5db53d7f 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h
@@ -42,6 +42,10 @@ struct dpu_hw_dsc_ops {
 	 */
 	void (*dsc_config_thresh)(struct dpu_hw_dsc *hw_dsc,
 				  struct drm_dsc_config *dsc);
+
+	void (*dsc_bind_pingpong_blk)(struct dpu_hw_dsc *hw_dsc,
+				  bool enable,
+				  enum dpu_pingpong pp);
 };
 
 struct dpu_hw_dsc {
-- 
2.39.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F4865A739
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 22:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235815AbiLaVus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 16:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235659AbiLaVuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 16:50:39 -0500
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [5.144.164.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBFB64C7
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 13:50:37 -0800 (PST)
Received: from localhost.localdomain (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id ADC463ED63;
        Sat, 31 Dec 2022 22:50:35 +0100 (CET)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Adam Skladowski <a39.skl@gmail.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/7] drm/msm/dpu: Move dpu_hw_{tear_check,pp_vsync_info} to dpu_hw_mdss.h
Date:   Sat, 31 Dec 2022 22:50:03 +0100
Message-Id: <20221231215006.211860-5-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221231215006.211860-1-marijn.suijten@somainline.org>
References: <20221231215006.211860-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konrad Dybcio <konrad.dybcio@somainline.org>

Now that newer SoCs since DPU 5.0.0 manage tearcheck in the INTF instead
of PINGPONG block, move the struct definition to a common file. Also,
bring in documentation from msm-4.19 techpack while at it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
[Marijn: Also move dpu_hw_pp_vsync_info]
Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h   | 46 +++++++++++++++++++
 .../gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h   | 22 ---------
 2 files changed, 46 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
index d3b0ed0a9c6c..64b2bf219a34 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
@@ -456,4 +456,50 @@ struct dpu_mdss_color {
 #define DPU_DBG_MASK_DSPP     (1 << 10)
 #define DPU_DBG_MASK_DSC      (1 << 11)
 
+/**
+ * struct dpu_hw_tear_check - Struct contains parameters to configure
+ * tear-effect module. This structure is used to configure tear-check
+ * logic present either in ping-pong or in interface module.
+ * @vsync_count:        Ratio of MDP VSYNC clk freq(Hz) to refresh rate divided
+ *                      by no of lines
+ * @sync_cfg_height:    Total vertical lines (display height - 1)
+ * @vsync_init_val:     Init value to which the read pointer gets loaded at
+ *                      vsync edge
+ * @sync_threshold_start:    Read pointer threshold start ROI for write operation
+ * @sync_threshold_continue: The minimum number of lines the write pointer
+ *                           needs to be above the read pointer
+ * @start_pos:          The position from which the start_threshold value is added
+ * @rd_ptr_irq:         The read pointer line at which interrupt has to be generated
+ * @hw_vsync_mode:      Sync with external frame sync input
+ */
+struct dpu_hw_tear_check {
+	/*
+	 * This is ratio of MDP VSYNC clk freq(Hz) to
+	 * refresh rate divided by no of lines
+	 */
+	u32 vsync_count;
+	u32 sync_cfg_height;
+	u32 vsync_init_val;
+	u32 sync_threshold_start;
+	u32 sync_threshold_continue;
+	u32 start_pos;
+	u32 rd_ptr_irq;
+	u8 hw_vsync_mode;
+};
+
+/**
+ * struct dpu_hw_pp_vsync_info - Struct contains parameters to configure
+ * read and write pointers for command mode panels
+ * @rd_ptr_init_val:    Value of rd pointer at vsync edge
+ * @rd_ptr_frame_count: Num frames sent since enabling interface
+ * @rd_ptr_line_count:  Current line on panel (rd ptr)
+ * @wr_ptr_line_count:  Current line within pp fifo (wr ptr)
+ */
+struct dpu_hw_pp_vsync_info {
+	u32 rd_ptr_init_val;
+	u32 rd_ptr_frame_count;
+	u32 rd_ptr_line_count;
+	u32 wr_ptr_line_count;
+};
+
 #endif  /* _DPU_HW_MDSS_H */
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h
index c00223441d99..5aa7b5647e38 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h
@@ -13,28 +13,6 @@
 
 struct dpu_hw_pingpong;
 
-struct dpu_hw_tear_check {
-	/*
-	 * This is ratio of MDP VSYNC clk freq(Hz) to
-	 * refresh rate divided by no of lines
-	 */
-	u32 vsync_count;
-	u32 sync_cfg_height;
-	u32 vsync_init_val;
-	u32 sync_threshold_start;
-	u32 sync_threshold_continue;
-	u32 start_pos;
-	u32 rd_ptr_irq;
-	u8 hw_vsync_mode;
-};
-
-struct dpu_hw_pp_vsync_info {
-	u32 rd_ptr_init_val;	/* value of rd pointer at vsync edge */
-	u32 rd_ptr_frame_count;	/* num frames sent since enabling interface */
-	u32 rd_ptr_line_count;	/* current line on panel (rd ptr) */
-	u32 wr_ptr_line_count;	/* current line within pp fifo (wr ptr) */
-};
-
 /**
  * struct dpu_hw_dither_cfg - dither feature structure
  * @flags: for customizing operations
-- 
2.39.0


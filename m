Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299686EEACB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 01:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236502AbjDYXHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 19:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236348AbjDYXGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 19:06:20 -0400
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [IPv6:2001:4b7a:2000:18::165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D0DB467
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 16:06:15 -0700 (PDT)
Received: from Marijn-Arch-PC.localdomain (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 550E91F9F7;
        Wed, 26 Apr 2023 01:06:13 +0200 (CEST)
From:   Marijn Suijten <marijn.suijten@somainline.org>
Date:   Wed, 26 Apr 2023 01:06:06 +0200
Subject: [PATCH v3 15/21] drm/msm/dpu: Move
 dpu_hw_{tear_check,pp_vsync_info} to dpu_hw_mdss.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230411-dpu-intf-te-v3-15-693b17fe6500@somainline.org>
References: <20230411-dpu-intf-te-v3-0-693b17fe6500@somainline.org>
In-Reply-To: <20230411-dpu-intf-te-v3-0-693b17fe6500@somainline.org>
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
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
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
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h     | 46 +++++++++++++++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h | 22 ------------
 2 files changed, 46 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
index 2d9192a6ce006..6ed12fd0505b3 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
@@ -463,4 +463,50 @@ struct dpu_mdss_color {
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
index 851b013c4c4b6..78db18dbda2b1 100644
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
2.40.1


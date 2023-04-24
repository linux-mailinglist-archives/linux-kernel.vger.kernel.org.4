Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258DB6E51BE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 22:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjDQUWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 16:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjDQUV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 16:21:58 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [5.144.164.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A519E4EF4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 13:21:52 -0700 (PDT)
Received: from Marijn-Arch-PC.localdomain (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id B35243F908;
        Mon, 17 Apr 2023 22:21:49 +0200 (CEST)
From:   Marijn Suijten <marijn.suijten@somainline.org>
Date:   Mon, 17 Apr 2023 22:21:47 +0200
Subject: [PATCH v2 08/17] drm/msm/dpu: Drop unused poll_timeout_wr_ptr
 PINGPONG callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230411-dpu-intf-te-v2-8-ef76c877eb97@somainline.org>
References: <20230411-dpu-intf-te-v2-0-ef76c877eb97@somainline.org>
In-Reply-To: <20230411-dpu-intf-te-v2-0-ef76c877eb97@somainline.org>
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
        Rajesh Yadav <ryadav@codeaurora.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Archit Taneja <architt@codeaurora.org>,
        Sravanthi Kollukuduru <skolluku@codeaurora.org>,
        Marijn Suijten <marijn.suijten@somainline.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This callback was migrated from downstream when DPU1 was first
introduced to mainline, but never used by any component.  Drop it to
save some lines and unnecessary confusion.

Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c | 18 ------------------
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h |  6 ------
 2 files changed, 24 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
index 0fcad9760b6f..b18efd640abd 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
@@ -144,23 +144,6 @@ static bool dpu_hw_pp_get_autorefresh_config(struct dpu_hw_pingpong *pp,
 	return !!((val & BIT(31)) >> 31);
 }
 
-static int dpu_hw_pp_poll_timeout_wr_ptr(struct dpu_hw_pingpong *pp,
-		u32 timeout_us)
-{
-	struct dpu_hw_blk_reg_map *c;
-	u32 val;
-	int rc;
-
-	if (!pp)
-		return -EINVAL;
-
-	c = &pp->hw;
-	rc = readl_poll_timeout(c->blk_addr + PP_LINE_COUNT,
-			val, (val & 0xffff) >= 1, 10, timeout_us);
-
-	return rc;
-}
-
 static int dpu_hw_pp_enable_te(struct dpu_hw_pingpong *pp, bool enable)
 {
 	struct dpu_hw_blk_reg_map *c;
@@ -280,7 +263,6 @@ static void _setup_pingpong_ops(struct dpu_hw_pingpong *c,
 	c->ops.get_vsync_info = dpu_hw_pp_get_vsync_info;
 	c->ops.setup_autorefresh = dpu_hw_pp_setup_autorefresh_config;
 	c->ops.get_autorefresh = dpu_hw_pp_get_autorefresh_config;
-	c->ops.poll_timeout_wr_ptr = dpu_hw_pp_poll_timeout_wr_ptr;
 	c->ops.get_line_count = dpu_hw_pp_get_line_count;
 	c->ops.setup_dsc = dpu_hw_pp_setup_dsc;
 	c->ops.enable_dsc = dpu_hw_pp_dsc_enable;
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h
index c00223441d99..cf94b4ab603b 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h
@@ -107,12 +107,6 @@ struct dpu_hw_pingpong_ops {
 	bool (*get_autorefresh)(struct dpu_hw_pingpong *pp,
 				u32 *frame_count);
 
-	/**
-	 * poll until write pointer transmission starts
-	 * @Return: 0 on success, -ETIMEDOUT on timeout
-	 */
-	int (*poll_timeout_wr_ptr)(struct dpu_hw_pingpong *pp, u32 timeout_us);
-
 	/**
 	 * Obtain current vertical line counter
 	 */

-- 
2.40.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453CB6539B9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 00:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235200AbiLUXUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 18:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235044AbiLUXUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 18:20:17 -0500
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [5.144.164.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B7424F10;
        Wed, 21 Dec 2022 15:20:09 -0800 (PST)
Received: from localhost.localdomain (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id A87B3203D9;
        Thu, 22 Dec 2022 00:20:06 +0100 (CET)
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
Subject: [PATCH v2 6/8] drm/msm/dpu: Remove num_enc from topology struct in favour of num_dsc
Date:   Thu, 22 Dec 2022 00:19:41 +0100
Message-Id: <20221221231943.1961117-7-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221221231943.1961117-1-marijn.suijten@somainline.org>
References: <20221221231943.1961117-1-marijn.suijten@somainline.org>
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

Downstream calls this num_enc yet the DSC patches introduced a new
num_dsc struct member, leaving num_enc effectively unused.

Fixes: 7e9cc175b159 ("drm/msm/disp/dpu1: Add support for DSC in topology")
Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 9 ++++-----
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c      | 4 ++--
 drivers/gpu/drm/msm/msm_drv.h               | 2 --
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 9c6817b5a194..a158cd502d38 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -579,19 +579,18 @@ static struct msm_display_topology dpu_encoder_get_topology(
 			topology.num_dspp = topology.num_lm;
 	}
 
-	topology.num_enc = 0;
 	topology.num_intf = intf_count;
 
 	if (dpu_enc->dsc) {
-		/* In case of Display Stream Compression (DSC), we would use
-		 * 2 encoders, 2 layer mixers and 1 interface
+		/*
+		 * In case of Display Stream Compression (DSC), we would use
+		 * 2 DSC encoders, 2 layer mixers and 1 interface
 		 * this is power optimal and can drive up to (including) 4k
 		 * screens
 		 */
-		topology.num_enc = 2;
 		topology.num_dsc = 2;
-		topology.num_intf = 1;
 		topology.num_lm = 2;
+		topology.num_intf = 1;
 	}
 
 	return topology;
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
index dcbf03d2940a..5e7aa0f3a31c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
@@ -548,8 +548,8 @@ static int _dpu_rm_populate_requirements(
 {
 	reqs->topology = req_topology;
 
-	DRM_DEBUG_KMS("num_lm: %d num_enc: %d num_intf: %d\n",
-		      reqs->topology.num_lm, reqs->topology.num_enc,
+	DRM_DEBUG_KMS("num_lm: %d num_dsc: %d num_intf: %d\n",
+		      reqs->topology.num_lm, reqs->topology.num_dsc,
 		      reqs->topology.num_intf);
 
 	return 0;
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index d4e0ef608950..74626a271f46 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -82,14 +82,12 @@ enum msm_event_wait {
 /**
  * struct msm_display_topology - defines a display topology pipeline
  * @num_lm:       number of layer mixers used
- * @num_enc:      number of compression encoder blocks used
  * @num_intf:     number of interfaces the panel is mounted on
  * @num_dspp:     number of dspp blocks used
  * @num_dsc:      number of Display Stream Compression (DSC) blocks used
  */
 struct msm_display_topology {
 	u32 num_lm;
-	u32 num_enc;
 	u32 num_intf;
 	u32 num_dspp;
 	u32 num_dsc;
-- 
2.39.0


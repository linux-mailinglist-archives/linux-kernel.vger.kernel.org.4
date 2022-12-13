Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1A764C073
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 00:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237023AbiLMXWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 18:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236999AbiLMXWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 18:22:30 -0500
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [IPv6:2001:4b7a:2000:18::162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAD326ACB;
        Tue, 13 Dec 2022 15:22:29 -0800 (PST)
Received: from localhost.localdomain (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 7A476200D5;
        Wed, 14 Dec 2022 00:22:26 +0100 (CET)
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
Subject: [RFC PATCH 2/6] drm/msm/dpu1: Add DSC config for sm8150 and sm8250
Date:   Wed, 14 Dec 2022 00:22:03 +0100
Message-Id: <20221213232207.113607-3-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221213232207.113607-1-marijn.suijten@somainline.org>
References: <20221213232207.113607-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These blocks on CTL V1 support setting a PINGPONG idx to send pixel
output to.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    | 23 ++++++++++++++-----
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
index 318f0b4dbf6e..114ad8ca4554 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
@@ -1566,18 +1566,25 @@ static const struct dpu_merge_3d_cfg sm8150_merge_3d[] = {
 /*************************************************************
  * DSC sub blocks config
  *************************************************************/
-#define DSC_BLK(_name, _id, _base) \
+#define DSC_BLK(_name, _id, _base, _features) \
 	{\
 	.name = _name, .id = _id, \
 	.base = _base, .len = 0x140, \
-	.features = 0, \
+	.features = _features, \
 	}
 
 static struct dpu_dsc_cfg sdm845_dsc[] = {
-	DSC_BLK("dsc_0", DSC_0, 0x80000),
-	DSC_BLK("dsc_1", DSC_1, 0x80400),
-	DSC_BLK("dsc_2", DSC_2, 0x80800),
-	DSC_BLK("dsc_3", DSC_3, 0x80c00),
+	DSC_BLK("dsc_0", DSC_0, 0x80000, 0),
+	DSC_BLK("dsc_1", DSC_1, 0x80400, 0),
+	DSC_BLK("dsc_2", DSC_2, 0x80800, 0),
+	DSC_BLK("dsc_3", DSC_3, 0x80c00, 0),
+};
+
+static struct dpu_dsc_cfg sm8150_dsc[] = {
+	DSC_BLK("dsc_0", DSC_0, 0x80000, BIT(DPU_DSC_OUTPUT_CTRL)),
+	DSC_BLK("dsc_1", DSC_1, 0x80400, BIT(DPU_DSC_OUTPUT_CTRL)),
+	DSC_BLK("dsc_2", DSC_2, 0x80800, BIT(DPU_DSC_OUTPUT_CTRL)),
+	DSC_BLK("dsc_3", DSC_3, 0x80c00, BIT(DPU_DSC_OUTPUT_CTRL)),
 };
 
 /*************************************************************
@@ -2474,6 +2481,8 @@ static const struct dpu_mdss_cfg sm8150_dpu_cfg = {
 	.mixer = sm8150_lm,
 	.dspp_count = ARRAY_SIZE(sm8150_dspp),
 	.dspp = sm8150_dspp,
+	.dsc_count = ARRAY_SIZE(sm8150_dsc),
+	.dsc = sm8150_dsc,
 	.pingpong_count = ARRAY_SIZE(sm8150_pp),
 	.pingpong = sm8150_pp,
 	.merge_3d_count = ARRAY_SIZE(sm8150_merge_3d),
@@ -2524,6 +2533,8 @@ static const struct dpu_mdss_cfg sm8250_dpu_cfg = {
 	.mixer = sm8150_lm,
 	.dspp_count = ARRAY_SIZE(sm8150_dspp),
 	.dspp = sm8150_dspp,
+	.dsc_count = ARRAY_SIZE(sm8150_dsc),
+	.dsc = sm8150_dsc,
 	.pingpong_count = ARRAY_SIZE(sm8150_pp),
 	.pingpong = sm8150_pp,
 	.merge_3d_count = ARRAY_SIZE(sm8150_merge_3d),
-- 
2.38.1


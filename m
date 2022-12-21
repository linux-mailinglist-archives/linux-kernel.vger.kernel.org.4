Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B1F6539C6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 00:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235250AbiLUXVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 18:21:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235214AbiLUXUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 18:20:36 -0500
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [5.144.164.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9E224F2B;
        Wed, 21 Dec 2022 15:20:18 -0800 (PST)
Received: from localhost.localdomain (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 91F522044B;
        Thu, 22 Dec 2022 00:20:16 +0100 (CET)
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
Subject: [PATCH v2 8/8] drm/msm/dpu: Add DSC configuration for SM8150 and SM8250
Date:   Thu, 22 Dec 2022 00:19:43 +0100
Message-Id: <20221221231943.1961117-9-marijn.suijten@somainline.org>
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

These DSC blocks on CTL V1 need to set its corresponding PINGPONG block
index in a hardware register to configure where to send pixel output to,
via the newly-added DPU_DSC_OUTPUT_CTRL feature flag.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
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
2.39.0


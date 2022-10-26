Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F8D60E74E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 20:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbiJZS24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 14:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234401AbiJZS2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 14:28:38 -0400
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [IPv6:2001:4b7a:2000:18::167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475FEDEF3C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 11:28:37 -0700 (PDT)
Received: from localhost.localdomain (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 3A52E3F412;
        Wed, 26 Oct 2022 20:28:35 +0200 (CEST)
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
        Douglas Anderson <dianders@chromium.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/10] drm/msm/dsi: Remove useless math in DSC calculations
Date:   Wed, 26 Oct 2022 20:28:15 +0200
Message-Id: <20221026182824.876933-2-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221026182824.876933-1-marijn.suijten@somainline.org>
References: <20221026182824.876933-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multiplying a value by 2 and adding 1 to it always results in a value
that is uneven, and that 1 gets truncated immediately when performing
integer division by 2 again.  There is no "rounding" possible here.

After that target_bpp_x16 is used to store a multiplication of
bits_per_pixel by 16 which is only ever read to immediately be divided
by 16 again, and is elided in much the same way.

Fixes: b9080324d6ca ("drm/msm/dsi: add support for dsc data")
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index e82eef031ed4..d645fcbb0683 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -1784,7 +1784,6 @@ static int dsi_populate_dsc_params(struct drm_dsc_config *dsc)
 	int hrd_delay;
 	int pre_num_extra_mux_bits, num_extra_mux_bits;
 	int slice_bits;
-	int target_bpp_x16;
 	int data;
 	int final_value, final_scale;
 	int i;
@@ -1864,14 +1863,7 @@ static int dsi_populate_dsc_params(struct drm_dsc_config *dsc)
 	data = 2048 * (dsc->rc_model_size - dsc->initial_offset + num_extra_mux_bits);
 	dsc->slice_bpg_offset = DIV_ROUND_UP(data, groups_total);
 
-	/* bpp * 16 + 0.5 */
-	data = dsc->bits_per_pixel * 16;
-	data *= 2;
-	data++;
-	data /= 2;
-	target_bpp_x16 = data;
-
-	data = (dsc->initial_xmit_delay * target_bpp_x16) / 16;
+	data = dsc->initial_xmit_delay * dsc->bits_per_pixel;
 	final_value =  dsc->rc_model_size - data + num_extra_mux_bits;
 	dsc->final_offset = final_value;
 
-- 
2.38.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6A060E761
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 20:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234484AbiJZS3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 14:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234342AbiJZS2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 14:28:45 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [IPv6:2001:4b7a:2000:18::166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243A8D25A7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 11:28:44 -0700 (PDT)
Received: from localhost.localdomain (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 12ABB3F757;
        Wed, 26 Oct 2022 20:28:42 +0200 (CEST)
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
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Marek Vasut <marex@denx.de>
Subject: [PATCH v4 05/10] drm/msm/dsi: Appropriately set dsc->mux_word_size based on bpc
Date:   Wed, 26 Oct 2022 20:28:19 +0200
Message-Id: <20221026182824.876933-6-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221026182824.876933-1-marijn.suijten@somainline.org>
References: <20221026182824.876933-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This field is currently unread but will come into effect when duplicated
code below is migrated to call drm_dsc_compute_rc_parameters(), which
uses the bpc-dependent value of the local variable mux_words_size in
much the same way.

The hardcoded constant seems to be a remnant from the `/* bpc 8 */`
comment right above, indicating that this group of field assignments is
applicable to bpc = 8 exclusively and should probably bail out on
different bpc values, until constants for other bpc values are added (or
the current ones are confirmed to be correct across multiple bpc's).

Fixes: b9080324d6ca ("drm/msm/dsi: add support for dsc data")
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 70b93e4b62a7..a1c387e9b7f4 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -1808,6 +1808,7 @@ static int dsi_populate_dsc_params(struct drm_dsc_config *dsc)
 	if (dsc->bits_per_component == 12)
 		mux_words_size = 64;
 
+	dsc->mux_word_size = mux_words_size;
 	dsc->initial_xmit_delay = 512;
 	dsc->initial_scale_value = 32;
 	dsc->first_line_bpg_offset = 12;
@@ -1818,7 +1819,6 @@ static int dsi_populate_dsc_params(struct drm_dsc_config *dsc)
 	dsc->flatness_max_qp = 12;
 	dsc->rc_quant_incr_limit0 = 11;
 	dsc->rc_quant_incr_limit1 = 11;
-	dsc->mux_word_size = DSC_MUX_WORD_SIZE_8_10_BPC;
 
 	/* FIXME: need to call drm_dsc_compute_rc_parameters() so that rest of
 	 * params are calculated
-- 
2.38.1


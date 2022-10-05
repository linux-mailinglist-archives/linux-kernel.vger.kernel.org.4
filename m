Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876B45F59C0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 20:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbiJESSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 14:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbiJESR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 14:17:28 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [IPv6:2001:4b7a:2000:18::166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168417FE5D
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 11:17:26 -0700 (PDT)
Received: from localhost.localdomain (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 9BF103EF3C;
        Wed,  5 Oct 2022 20:17:24 +0200 (CEST)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Douglas Anderson <dianders@chromium.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>
Subject: [PATCH v2 7/7] drm/msm/dsi: Prevent signed BPG offsets from bleeding into adjacent bits
Date:   Wed,  5 Oct 2022 20:16:57 +0200
Message-Id: <20221005181657.784375-8-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221005181657.784375-1-marijn.suijten@somainline.org>
References: <20221005181657.784375-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bpg_offset array contains negative BPG offsets which fill the full 8
bits of a char thanks to two's complement: this however results in those
bits bleeding into the next field when the value is packed into DSC PPS
by the drm_dsc_helper function, which only expects range_bpg_offset to
contain 6-bit wide values.  As a consequence random slices appear
corrupted on-screen (tested on a Sony Tama Akatsuki device with sdm845).

Use AND operators to limit these two's complement values to 6 bits,
similar to the AMD and i915 drivers.

Fixes: b9080324d6ca ("drm/msm/dsi: add support for dsc data")
Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 4717d49d76be..b3cff3d3aa85 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -1806,7 +1806,11 @@ static int dsi_populate_dsc_params(struct msm_dsi_host *msm_host, struct drm_dsc
 	for (i = 0; i < DSC_NUM_BUF_RANGES; i++) {
 		dsc->rc_range_params[i].range_min_qp = min_qp[i];
 		dsc->rc_range_params[i].range_max_qp = max_qp[i];
-		dsc->rc_range_params[i].range_bpg_offset = bpg_offset[i];
+		/*
+		 * Range BPG Offset contains two's-complement signed values that fill
+		 * 8 bits, yet the registers and DCS PPS field are only 6 bits wide.
+		 */
+		dsc->rc_range_params[i].range_bpg_offset = bpg_offset[i] & DSC_RANGE_BPG_OFFSET_MASK;
 	}
 
 	dsc->initial_offset = 6144; /* Not bpp 12 */
-- 
2.38.0


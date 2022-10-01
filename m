Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891885F1EE0
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 21:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiJATId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 15:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJATIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 15:08:25 -0400
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [IPv6:2001:4b7a:2000:18::163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43543BE25;
        Sat,  1 Oct 2022 12:08:24 -0700 (PDT)
Received: from localhost.localdomain (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id A50B320372;
        Sat,  1 Oct 2022 21:08:21 +0200 (CEST)
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
        David Airlie <airlied@linux.ie>,
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
        Marek Vasut <marex@denx.de>
Subject: [PATCH 2/5] drm/msm/dsi: Remove repeated calculation of slice_per_intf
Date:   Sat,  1 Oct 2022 21:08:04 +0200
Message-Id: <20221001190807.358691-3-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221001190807.358691-1-marijn.suijten@somainline.org>
References: <20221001190807.358691-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

slice_per_intf is already computed for intf_width, which holds the same
value as hdisplay.

Fixes: 08802f515c3c ("drm/msm/dsi: Add support for DSC configuration")
Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index e05bae647431..cb6f2fa11f58 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -842,7 +842,7 @@ static void dsi_ctrl_config(struct msm_dsi_host *msm_host, bool enable,
 static void dsi_update_dsc_timing(struct msm_dsi_host *msm_host, bool is_cmd_mode, u32 hdisplay)
 {
 	struct drm_dsc_config *dsc = msm_host->dsc;
-	u32 reg, intf_width, reg_ctrl, reg_ctrl2;
+	u32 reg, reg_ctrl, reg_ctrl2;
 	u32 slice_per_intf, total_bytes_per_intf;
 	u32 pkt_per_line;
 	u32 bytes_in_slice;
@@ -851,8 +851,7 @@ static void dsi_update_dsc_timing(struct msm_dsi_host *msm_host, bool is_cmd_mod
 	/* first calculate dsc parameters and then program
 	 * compress mode registers
 	 */
-	intf_width = hdisplay;
-	slice_per_intf = DIV_ROUND_UP(intf_width, dsc->slice_width);
+	slice_per_intf = DIV_ROUND_UP(hdisplay, dsc->slice_width);
 
 	/* If slice_per_pkt is greater than slice_per_intf
 	 * then default to 1. This can happen during partial
@@ -861,7 +860,6 @@ static void dsi_update_dsc_timing(struct msm_dsi_host *msm_host, bool is_cmd_mod
 	if (slice_per_intf > dsc->slice_count)
 		dsc->slice_count = 1;
 
-	slice_per_intf = DIV_ROUND_UP(hdisplay, dsc->slice_width);
 	bytes_in_slice = DIV_ROUND_UP(dsc->slice_width * dsc->bits_per_pixel, 8);
 
 	dsc->slice_chunk_size = bytes_in_slice;
-- 
2.37.3


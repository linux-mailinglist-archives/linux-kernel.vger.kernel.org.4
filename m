Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8833D6E5491
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 00:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjDQWIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 18:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjDQWIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 18:08:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113BA35A0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 15:08:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FF4562227
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 22:08:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 797A3C433EF;
        Mon, 17 Apr 2023 22:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681769324;
        bh=3mAYSO1Xzj3GFR1DXJ9WPdepWdVO++0QoAFLkNEoni4=;
        h=From:To:Cc:Subject:Date:From;
        b=N1EN8WNKF55QyT3laJHT+/Kw4zQ5N7uX8g3DlwvYfQ7/0cfZ46K8XsvVNQ8L5fY60
         MUSR3CaVwtZ0l2PB+CkQK/VWLRD9s8NVzwnFmjKupNxzrgPrSPfzYBtxFH6n3ban7q
         9EEV54zWOyKKJeDUKFmPWQT5aqhdnecN3N0YR4ulCRr6pTTorsak/Ea78Rta8x48aA
         r2dxHnNJ0kUgYmJlv3OaBnSyBQzDdHfmoZn2aZsdCr8TD3is/1tTAXeXeREEWib8xB
         WHcSRhg94qymuET4cwJUkpxX9eJlsIS7fkRuuJkIy8IAv+iTFwgs2vprortCh+OVGq
         u55syr2dqTaIA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
        Wayne Lin <Wayne.Lin@amd.com>, hersen wu <hersenxs.wu@amd.com>,
        Fangzhi Zuo <Jerry.Zuo@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>,
        Aurabindo Pillai <Aurabindo.Pillai@amd.com>,
        Alan Liu <HaoPing.Liu@amd.com>,
        Wenjing Liu <wenjing.liu@amd.com>, Jun Lei <Jun.Lei@amd.com>,
        Alex Hung <alex.hung@amd.com>,
        Mario Kleiner <mario.kleiner.de@gmail.com>,
        Aric Cyr <Aric.Cyr@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Alvin Lee <Alvin.Lee2@amd.com>,
        Jasdeep Dhillon <jdhillon@amd.com>,
        Roman Li <roman.li@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] drm/amd/display: fix is_timing_changed() prototype
Date:   Tue, 18 Apr 2023 00:07:18 +0200
Message-Id: <20230417220827.3481168-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Three functions in the amdgpu display driver cause -Wmissing-prototype
warnings:

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:1858:6: error: no previous prototype for 'is_timing_changed' [-Werror=missing-prototypes]

is_timing_changed() is actually meant to be a global symbol, but needs
a proper name and prototype.

Fixes: 17ce8a6907f7 ("drm/amd/display: Add dsc pre-validation in atomic check")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 5 ++---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c           | 6 +++---
 drivers/gpu/drm/amd/display/dc/dc.h                         | 3 +++
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 994ba426ca66..442511061178 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -45,8 +45,7 @@
 #endif
 
 #include "dc/dcn20/dcn20_resource.h"
-bool is_timing_changed(struct dc_stream_state *cur_stream,
-		       struct dc_stream_state *new_stream);
+
 #define PEAK_FACTOR_X1000 1006
 
 static ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
@@ -1417,7 +1416,7 @@ int pre_validate_dsc(struct drm_atomic_state *state,
 		struct dc_stream_state *stream = dm_state->context->streams[i];
 
 		if (local_dc_state->streams[i] &&
-		    is_timing_changed(stream, local_dc_state->streams[i])) {
+		    dc_is_timing_changed(stream, local_dc_state->streams[i])) {
 			DRM_INFO_ONCE("crtc[%d] needs mode_changed\n", i);
 		} else {
 			int ind = find_crtc_index_in_state_by_stream(state, stream);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 85d54bfb595c..344533623cb9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1855,7 +1855,7 @@ bool dc_add_all_planes_for_stream(
 	return add_all_planes_for_stream(dc, stream, &set, 1, context);
 }
 
-bool is_timing_changed(struct dc_stream_state *cur_stream,
+bool dc_is_timing_changed(struct dc_stream_state *cur_stream,
 		       struct dc_stream_state *new_stream)
 {
 	if (cur_stream == NULL)
@@ -1880,7 +1880,7 @@ static bool are_stream_backends_same(
 	if (stream_a == NULL || stream_b == NULL)
 		return false;
 
-	if (is_timing_changed(stream_a, stream_b))
+	if (dc_is_timing_changed(stream_a, stream_b))
 		return false;
 
 	if (stream_a->signal != stream_b->signal)
@@ -3505,7 +3505,7 @@ bool pipe_need_reprogram(
 	if (pipe_ctx_old->stream_res.stream_enc != pipe_ctx->stream_res.stream_enc)
 		return true;
 
-	if (is_timing_changed(pipe_ctx_old->stream, pipe_ctx->stream))
+	if (dc_is_timing_changed(pipe_ctx_old->stream, pipe_ctx->stream))
 		return true;
 
 	if (pipe_ctx_old->stream->dpms_off != pipe_ctx->stream->dpms_off)
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 23ee63b98dcd..e7ab6cb3769b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2225,4 +2225,7 @@ void dc_process_dmub_dpia_hpd_int_enable(const struct dc *dc,
 /* Disable acc mode Interfaces */
 void dc_disable_accelerated_mode(struct dc *dc);
 
+bool dc_is_timing_changed(struct dc_stream_state *cur_stream,
+		       struct dc_stream_state *new_stream);
+
 #endif /* DC_INTERFACE_H_ */
-- 
2.39.2


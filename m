Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3F46628ED
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 15:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbjAIOpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 09:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234723AbjAIOpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 09:45:06 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B5B3591C
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 06:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=cKIgQ2NkBMGH8emqa7YtqDB/L0xQKuwdjNrEqIF3P4M=; b=KydMXJYozSRjwD7sxmrNzx74C+
        RMz3tPCTbB6hNYG1aEeMkMGEAJLl8mjAsTqD/ewUWWEN1piHTlumNaX3yKfqdSRmJgnbXep+7GcEL
        75jfb/AilU3RnAbKzZNU/oMuaA5lrQmfhR5SInbLz9PhFdwzo5Tsj0kf2kNFDReaIdOAb1/3yk7oo
        2Gt3+ixBw9Ju92ttxATxODpwBvQel9wTng+5qq37UpRnFrf7MfzCtJ2VHmlSBl9yGR5I9eksK+H76
        o0V9quBXJG6DFp1WArCbriL876r71WmZHe8iLga0rc/QGK1OZjV6zTznB8ffpyc7YQA8yaDIrV28M
        hU+Er4dQ==;
Received: from [41.74.137.107] (helo=killbill.home)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1pEtNs-003TyM-8H; Mon, 09 Jan 2023 15:44:20 +0100
From:   Melissa Wen <mwen@igalia.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch
Cc:     Joshua Ashton <joshua@froggi.es>, alex.hung@amd.com,
        nicholas.kazlauskas@amd.com, sungjoon.kim@amd.com,
        seanpaul@chromium.org, bhawanpreet.lakha@amd.com,
        Shashank Sharma <shashank.sharma@amd.com>,
        ville.syrjala@linux.intel.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, kernel-dev@igalia.com,
        laurent.pinchart+renesas@ideasonboard.com,
        Melissa Wen <mwen@igalia.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 12/18] drm/amd/display: acquire/release 3D LUT resources for ctx on DCN301
Date:   Mon,  9 Jan 2023 13:38:40 -0100
Message-Id: <20230109143846.1966301-13-mwen@igalia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230109143846.1966301-1-mwen@igalia.com>
References: <20230109143846.1966301-1-mwen@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acquire and release 3D LUT and shaper LUT every time we create/remove a
new ctx and add/remove stream to/from it. 3D LUT acquire/release can
fail and therefore we should check its availability during atomic check
considering the new context created not the current one.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../amd/display/dc/dcn301/dcn301_resource.c   | 47 ++++++++++++++++++-
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index ee62ae3eb98f..5bae0972bd5e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -1260,6 +1260,49 @@ static struct display_stream_compressor *dcn301_dsc_create(
 	return &dsc->base;
 }
 
+static enum dc_status
+dcn301_add_stream_to_ctx(struct dc *dc,
+			 struct dc_state *new_ctx,
+			 struct dc_stream_state *dc_stream)
+{
+	enum dc_status result = DC_ERROR_UNEXPECTED;
+	struct dc_3dlut *lut3d_func_new = NULL;
+	struct dc_transfer_func *func_shaper_new = NULL;
+
+	result = dcn20_add_stream_to_ctx(dc, new_ctx, dc_stream);
+	if (result != DC_OK)
+		return result;
+
+	if (!dc_acquire_release_mpc_3dlut_for_ctx(dc, true, new_ctx, dc_stream,
+						  &lut3d_func_new, &func_shaper_new))
+		return DC_ERROR_UNEXPECTED;
+
+	dc_stream->lut3d_func = lut3d_func_new;
+	dc_stream->func_shaper = func_shaper_new;
+
+	return DC_OK;
+}
+
+static enum dc_status
+dcn301_remove_stream_from_ctx(struct dc *dc,
+			      struct dc_state *new_ctx,
+			      struct dc_stream_state *dc_stream)
+{
+	struct dc_3dlut *lut3d_func;
+	struct dc_transfer_func *func_shaper;
+
+	lut3d_func = (struct dc_3dlut *)dc_stream->lut3d_func;
+	func_shaper = (struct dc_transfer_func *)dc_stream->func_shaper;
+
+	if (!dc_acquire_release_mpc_3dlut_for_ctx(dc, false, new_ctx, dc_stream,
+						  &lut3d_func, &func_shaper))
+		return DC_ERROR_UNEXPECTED;
+
+	dc_stream->lut3d_func = lut3d_func;
+	dc_stream->func_shaper = func_shaper;
+
+	return dcn20_remove_stream_from_ctx(dc, new_ctx, dc_stream);
+}
 
 static void dcn301_destroy_resource_pool(struct resource_pool **pool)
 {
@@ -1406,9 +1449,9 @@ static struct resource_funcs dcn301_res_pool_funcs = {
 	.update_soc_for_wm_a = dcn30_update_soc_for_wm_a,
 	.populate_dml_pipes = dcn30_populate_dml_pipes_from_context,
 	.acquire_idle_pipe_for_layer = dcn20_acquire_idle_pipe_for_layer,
-	.add_stream_to_ctx = dcn30_add_stream_to_ctx,
+	.add_stream_to_ctx = dcn301_add_stream_to_ctx,
 	.add_dsc_to_stream_resource = dcn20_add_dsc_to_stream_resource,
-	.remove_stream_from_ctx = dcn20_remove_stream_from_ctx,
+	.remove_stream_from_ctx = dcn301_remove_stream_from_ctx,
 	.populate_dml_writeback_from_context = dcn30_populate_dml_writeback_from_context,
 	.set_mcif_arb_params = dcn30_set_mcif_arb_params,
 	.find_first_free_match_stream_enc_for_link = dcn10_find_first_free_match_stream_enc_for_link,
-- 
2.35.1


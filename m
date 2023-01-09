Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02EC6628EB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 15:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbjAIOpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 09:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234441AbjAIOol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 09:44:41 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F025934D53
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 06:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=JvdJXnslHHYsgYx1+6dyB2NO+WCy/ybpW/Ce1OI2Y1Y=; b=oFeG4//hpK2jBA7q7YDjh9O3MP
        MrTl+XG5rT7dFkVcuflFVAxGYcHkBStWwZEn1I+g1hKW44inrZscTIF89dliIBAmFAp9Yht9FBzCZ
        yK0OGg9D8EjtcmRb9ofCB3z12mqk7T8cVO645dW7vr8E886R+/0VMdLhkJ5S94PrlFBXVwTkBiX46
        +FjtlTsZze7KVLJivFkCIIzlqKFebegFw6to/HBPRPCFveVo1kTYCqXTDjyWFZ0yeD8m/h22MWLvq
        If3wd1EvsviA/NSTlQhIkXMQXfoKVzQ+BqM/+nYHaaqXPUX6snH1qwqjaOF55XJbpJYqQxwTkbG68
        Ka8ZgSmg==;
Received: from [41.74.137.107] (helo=killbill.home)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1pEtNp-003TyM-JJ; Mon, 09 Jan 2023 15:44:17 +0100
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
Subject: [RFC PATCH v2 11/18] drm/amd/display: handle MPC 3D LUT resources for a given context
Date:   Mon,  9 Jan 2023 13:38:39 -0100
Message-Id: <20230109143846.1966301-12-mwen@igalia.com>
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

In the original dc_acquire_release_mpc_3dlut(), only current ctx is
considered, which doesn't fit the steps for atomic checking new ctx.
Therefore, create a function to handle 3D LUT resource for a given
context, so that we can check resources availability in atomic_check
time and handle failures properly.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 39 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h      |  8 +++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 88f1130c3b83..76270d21286a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2085,6 +2085,45 @@ bool dc_acquire_release_mpc_3dlut(
 	return ret;
 }
 
+bool
+dc_acquire_release_mpc_3dlut_for_ctx(struct dc *dc,
+				     bool acquire,
+				     struct dc_state *state,
+				     struct dc_stream_state *stream,
+				     struct dc_3dlut **lut,
+				     struct dc_transfer_func **shaper)
+{
+	int pipe_idx;
+	bool ret = false;
+	bool found_pipe_idx = false;
+	const struct resource_pool *pool = dc->res_pool;
+	struct resource_context *res_ctx = &state->res_ctx;
+	int mpcc_id = 0;
+
+	if (pool && res_ctx) {
+		if (acquire) {
+			/*find pipe idx for the given stream*/
+			for (pipe_idx = 0; pipe_idx < pool->pipe_count; pipe_idx++) {
+				if (res_ctx->pipe_ctx[pipe_idx].stream == stream) {
+					found_pipe_idx = true;
+					mpcc_id = res_ctx->pipe_ctx[pipe_idx].plane_res.hubp->inst;
+					break;
+				}
+			}
+		} else
+			found_pipe_idx = true;/*for release pipe_idx is not required*/
+
+		if (found_pipe_idx) {
+			if (acquire && pool->funcs->acquire_post_bldn_3dlut)
+				ret = pool->funcs->acquire_post_bldn_3dlut(res_ctx, pool, mpcc_id, lut, shaper);
+			else if (!acquire && pool->funcs->release_post_bldn_3dlut)
+				ret = pool->funcs->release_post_bldn_3dlut(res_ctx, pool, lut, shaper);
+		}
+	}
+	return ret;
+}
+
+
 static bool is_flip_pending_in_pipes(struct dc *dc, struct dc_state *context)
 {
 	int i;
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 72963617553e..a5abf7f308c3 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1345,6 +1345,14 @@ bool dc_acquire_release_mpc_3dlut(
 		struct dc_3dlut **lut,
 		struct dc_transfer_func **shaper);
 
+bool
+dc_acquire_release_mpc_3dlut_for_ctx(struct dc *dc,
+				     bool acquire,
+				     struct dc_state *state,
+				     struct dc_stream_state *stream,
+				     struct dc_3dlut **lut,
+				     struct dc_transfer_func **shaper);
+
 void dc_resource_state_copy_construct(
 		const struct dc_state *src_ctx,
 		struct dc_state *dst_ctx);
-- 
2.35.1


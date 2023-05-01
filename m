Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03226F2C11
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 04:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbjEAC5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 22:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjEAC5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 22:57:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B5510DE;
        Sun, 30 Apr 2023 19:56:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 903F2615AE;
        Mon,  1 May 2023 02:56:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0BEC433D2;
        Mon,  1 May 2023 02:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682909817;
        bh=PkJh6BI0+P94sYXLPrdkSPF+aCfPj0KAfcLUL7Hrr8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qeuZY6+118vRmGaHNsrXBmBHuRwpcIZuVWRXqPBiIvpg5ln3tNH9xeRNfNAAspBNE
         GlbVvV0S2kbEJ6+e6Adteoxrs1zhzHjSNmXKh2qaTW5+Eqt6NXRMiaLNk1nps/aJxy
         AN/VmQjU1+4OXxaBv7Piygn8Y2WsIBUumA2Xu/Ie8WdXRxwDVuD2tuiHDU5OwW9dyR
         Fel39e83C6n7dHO9hEnwE8TvJQVZ0HoTbEoc7OMxB6yA02gA7xE/V2XdtokzMkTFTo
         htTIvApLtGvinTgw8gzqGD47vwFpzwL83RENOx4g09DxmS2WDIg0i9tfapVTNBgiPQ
         rvMbPKpjdKQ1Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Samson Tam <samson.tam@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, harry.wentland@amd.com,
        sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, Jun.Lei@amd.com, wenjing.liu@amd.com,
        Dillon.Varone@amd.com, HaoPing.Liu@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.3 04/44] drm/amd/display: enable DPG when disabling plane for phantom pipe
Date:   Sun, 30 Apr 2023 22:55:52 -0400
Message-Id: <20230501025632.3253067-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501025632.3253067-1-sashal@kernel.org>
References: <20230501025632.3253067-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Samson Tam <samson.tam@amd.com>

[ Upstream commit f3f8f16b10f8258f1836e1110099097490a1d6c1 ]

[Why]
In disable_dangling_plane, for phantom pipes, we enable OTG so
disable programming gets the double buffer update.  But this
causes an underflow to occur.

[How]
Enable DPG prior to enabling OTG.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Samson Tam <samson.tam@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 47 +++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 1c218c5266509..510661d303e8a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -74,6 +74,8 @@
 
 #include "dc_trace.h"
 
+#include "hw_sequencer_private.h"
+
 #include "dce/dmub_outbox.h"
 
 #define CTX \
@@ -1057,6 +1059,44 @@ static void apply_ctx_interdependent_lock(struct dc *dc, struct dc_state *contex
 	}
 }
 
+static void phantom_pipe_blank(
+		struct dc *dc,
+		struct timing_generator *tg,
+		int width,
+		int height)
+{
+	struct dce_hwseq *hws = dc->hwseq;
+	enum dc_color_space color_space;
+	struct tg_color black_color = {0};
+	struct output_pixel_processor *opp = NULL;
+	uint32_t num_opps, opp_id_src0, opp_id_src1;
+	uint32_t otg_active_width, otg_active_height;
+
+	/* program opp dpg blank color */
+	color_space = COLOR_SPACE_SRGB;
+	color_space_to_black_color(dc, color_space, &black_color);
+
+	otg_active_width = width;
+	otg_active_height = height;
+
+	/* get the OPTC source */
+	tg->funcs->get_optc_source(tg, &num_opps, &opp_id_src0, &opp_id_src1);
+	ASSERT(opp_id_src0 < dc->res_pool->res_cap->num_opp);
+	opp = dc->res_pool->opps[opp_id_src0];
+
+	opp->funcs->opp_set_disp_pattern_generator(
+			opp,
+			CONTROLLER_DP_TEST_PATTERN_SOLID_COLOR,
+			CONTROLLER_DP_COLOR_SPACE_UDEFINED,
+			COLOR_DEPTH_UNDEFINED,
+			&black_color,
+			otg_active_width,
+			otg_active_height,
+			0);
+
+	hws->funcs.wait_for_blank_complete(opp);
+}
+
 static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
 {
 	int i, j;
@@ -1115,8 +1155,13 @@ static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
 			 * again for different use.
 			 */
 			if (old_stream->mall_stream_config.type == SUBVP_PHANTOM) {
-				if (tg->funcs->enable_crtc)
+				if (tg->funcs->enable_crtc) {
+					int main_pipe_width, main_pipe_height;
+					main_pipe_width = old_stream->mall_stream_config.paired_stream->dst.width;
+					main_pipe_height = old_stream->mall_stream_config.paired_stream->dst.height;
+					phantom_pipe_blank(dc, tg, main_pipe_width, main_pipe_height);
 					tg->funcs->enable_crtc(tg);
+				}
 			}
 			dc_rem_all_planes_for_stream(dc, old_stream, dangling_context);
 			disable_all_writeback_pipes_for_stream(dc, old_stream, dangling_context);
-- 
2.39.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980376FFA47
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 21:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239233AbjEKTib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 15:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239179AbjEKTi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 15:38:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179B28A53;
        Thu, 11 May 2023 12:38:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DA0F65112;
        Thu, 11 May 2023 19:38:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A82C433EF;
        Thu, 11 May 2023 19:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683833902;
        bh=9X0hUWrkO4/lNnx3WVZf8iL+U1M/n1u33m0Qtf5NXBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UWQpNpcGCBuZFkAzBJcM1sCoKrSaIQe48PhgFR7ofYLdsaS8NFV/zBrWT7Wr1An9t
         9sAEuj3q24V07Bqzbo78Ff2KS5gWJropuSMdh/Adkx0PdA+t6DfNEhkwgUomJycCXN
         PDNXb0hBy/h40Lx7NBWkf8eLykIjydGkyPFLh4LduPVnbx/JdR7Q6qjMpNIZ9do4Gj
         7RhisnMIfmI8oXsJ1J2UwsLAzChSL6OHzEkkCLsMkvZqjNqA5caGF2K/q4iC6grRXF
         9eR/YyYEKTuUDQgeWuYhBHX+twOmkcQd6z9zVEukTnRv03WPPILdcyfJ4bDGFOh3fV
         tbKxp7bDUrRHQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wesley Chalmers <Wesley.Chalmers@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, harry.wentland@amd.com,
        sunpeng.li@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
        airlied@gmail.com, daniel@ffwll.ch, Alvin.Lee2@amd.com,
        Jun.Lei@amd.com, qingqing.zhuo@amd.com, wenjing.liu@amd.com,
        Dillon.Varone@amd.com, aurabindo.pillai@amd.com,
        jiapeng.chong@linux.alibaba.com, Aric.Cyr@amd.com, mwen@igalia.com,
        felipe.clark@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.3 04/11] drm/amd/display: Do not set drr on pipe commit
Date:   Thu, 11 May 2023 15:37:47 -0400
Message-Id: <20230511193757.623114-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230511193757.623114-1-sashal@kernel.org>
References: <20230511193757.623114-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[ Upstream commit 474f01015ffdb74e01c2eb3584a2822c64e7b2be ]

[WHY]
Writing to DRR registers such as OTG_V_TOTAL_MIN on the same frame as a
pipe commit can cause underflow.

[HOW]
Move DMUB p-state delegate into optimze_bandwidth; enabling FAMS sets
optimized_required.

This change expects that Freesync requests are blocked when
optimized_required is true.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 6 ++++++
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index b83873a3a534a..7f2e9a300fed9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -2092,6 +2092,12 @@ void dcn20_optimize_bandwidth(
 	if (hubbub->funcs->program_compbuf_size)
 		hubbub->funcs->program_compbuf_size(hubbub, context->bw_ctx.bw.dcn.compbuf_size_kb, true);
 
+	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching) {
+		dc_dmub_srv_p_state_delegate(dc,
+			true, context);
+		context->bw_ctx.bw.dcn.clk.p_state_change_support = true;
+	}
+
 	dc->clk_mgr->funcs->update_clocks(
 			dc->clk_mgr,
 			context,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index df787fcf8e86e..7f4fe6f8f0214 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -992,11 +992,18 @@ void dcn30_set_disp_pattern_generator(const struct dc *dc,
 void dcn30_prepare_bandwidth(struct dc *dc,
  	struct dc_state *context)
 {
+	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching) {
+		dc->optimized_required = true;
+		context->bw_ctx.bw.dcn.clk.p_state_change_support = false;
+	}
+
 	if (dc->clk_mgr->dc_mode_softmax_enabled)
 		if (dc->clk_mgr->clks.dramclk_khz <= dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000 &&
 				context->bw_ctx.bw.dcn.clk.dramclk_khz > dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000)
 			dc->clk_mgr->funcs->set_max_memclk(dc->clk_mgr, dc->clk_mgr->bw_params->clk_table.entries[dc->clk_mgr->bw_params->clk_table.num_entries - 1].memclk_mhz);
 
 	dcn20_prepare_bandwidth(dc, context);
+
+	dc_dmub_srv_p_state_delegate(dc, false, context);
 }
 
-- 
2.39.2


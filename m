Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8206F2D71
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 05:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbjEADMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 23:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbjEADKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 23:10:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF1B26B5;
        Sun, 30 Apr 2023 20:04:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EF78616DB;
        Mon,  1 May 2023 03:03:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59B7C433EF;
        Mon,  1 May 2023 03:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682910218;
        bh=u4uXahRZ1oEWMPtWpsDRehFwjvVF4mBJHFq7K0vkIXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZJftMhwSWL8oxoD7BReBKCdoK12XWoXSKIjhPSjhwTXJt55c7o7yMpu8lPZP0SMHU
         eV/N4Z68E5JtJxCF3Zqtml/KCuJLqv5uNjen1l/HLBgFMRD99iVJqY0zWcN5L4dG8S
         1kJFfyNjxObbkJxip79tRs/+IdWCw2kiy3WYuoWIVvA76wG1+uyhMEWRCsbr+QajAr
         oGq437aripHHompW+97H2s2/u4fUGfbMV9plEbusf7fS6UFAs+cq1VNwrUjDds9OI8
         2U9yWw5LTJ6FUFYk/P0qwiGXGgx+4FRpeMRtXd4Cl7TJzdpO65ItKeOi4qPK2XmUOx
         /e2OZsRBUdbWA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ayush Gupta <ayugupta@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>,
        Martin Leung <Martin.Leung@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, harry.wentland@amd.com,
        sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, Jun.Lei@amd.com, wenjing.liu@amd.com,
        Wesley.Chalmers@amd.com, aric.cyr@amd.com, mwen@igalia.com,
        felipe.clark@amd.com, sungjoon.kim@amd.com,
        aurabindo.pillai@amd.com, Charlene.Liu@amd.com,
        Jimmy.Kizito@amd.com, duncan.ma@amd.com, Brian.Chang@amd.com,
        Dillon.Varone@amd.com, Syed.Hassan@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 19/33] drm/amd/display: fixed dcn30+ underflow issue
Date:   Sun, 30 Apr 2023 23:02:13 -0400
Message-Id: <20230501030227.3254266-19-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501030227.3254266-1-sashal@kernel.org>
References: <20230501030227.3254266-1-sashal@kernel.org>
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

From: Ayush Gupta <ayugupta@amd.com>

[ Upstream commit 37403ced9f2873fab7f39ab4ac963bbb33fb0bc0 ]

[Why]
Observing underflow on dcn30+ system config at 4k144hz

[How]
We set the UCLK hardmax on AC/DC switch if softmax is enabled
and also on boot. While booting up the UCLK Hardmax is set
to softmax before the init sequence and the init sequence
resets the hardmax to UCLK max which enables P-state switching.
Just added a conditional check to avoid setting hardmax on init.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Ayush Gupta <ayugupta@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c | 3 ++-
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index c20e9f76f0213..a1b312483d7f1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -629,7 +629,8 @@ void dcn30_init_hw(struct dc *dc)
 	if (dc->clk_mgr->funcs->notify_wm_ranges)
 		dc->clk_mgr->funcs->notify_wm_ranges(dc->clk_mgr);
 
-	if (dc->clk_mgr->funcs->set_hard_max_memclk)
+	//if softmax is enabled then hardmax will be set by a different call
+	if (dc->clk_mgr->funcs->set_hard_max_memclk && !dc->clk_mgr->dc_mode_softmax_enabled)
 		dc->clk_mgr->funcs->set_hard_max_memclk(dc->clk_mgr);
 
 	if (dc->res_pool->hubbub->funcs->force_pstate_change_control)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
index bdf101547484a..d4ee533deff32 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
@@ -284,7 +284,7 @@ void dcn31_init_hw(struct dc *dc)
 	if (dc->clk_mgr->funcs->notify_wm_ranges)
 		dc->clk_mgr->funcs->notify_wm_ranges(dc->clk_mgr);
 
-	if (dc->clk_mgr->funcs->set_hard_max_memclk)
+	if (dc->clk_mgr->funcs->set_hard_max_memclk && !dc->clk_mgr->dc_mode_softmax_enabled)
 		dc->clk_mgr->funcs->set_hard_max_memclk(dc->clk_mgr);
 
 	if (dc->res_pool->hubbub->funcs->force_pstate_change_control)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 1a85509c12f23..a32e21ada8555 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -970,7 +970,7 @@ void dcn32_init_hw(struct dc *dc)
 	if (dc->clk_mgr->funcs->notify_wm_ranges)
 		dc->clk_mgr->funcs->notify_wm_ranges(dc->clk_mgr);
 
-	if (dc->clk_mgr->funcs->set_hard_max_memclk)
+	if (dc->clk_mgr->funcs->set_hard_max_memclk && !dc->clk_mgr->dc_mode_softmax_enabled)
 		dc->clk_mgr->funcs->set_hard_max_memclk(dc->clk_mgr);
 
 	if (dc->res_pool->hubbub->funcs->force_pstate_change_control)
-- 
2.39.2


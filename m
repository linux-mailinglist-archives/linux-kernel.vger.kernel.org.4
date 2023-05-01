Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63CE6F2C61
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 04:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbjEAC7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 22:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbjEAC7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 22:59:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED4E1997;
        Sun, 30 Apr 2023 19:58:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F1D860FE6;
        Mon,  1 May 2023 02:58:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25548C4339B;
        Mon,  1 May 2023 02:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682909904;
        bh=RR0RaiAa39AnLe3EdRJLf/R7mtHLliY0qBdaq/mN1Pk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hOV5bId3oz8LNVmvfo1ESDzr+n0fcaf9oBUrsP6/vaR14eZ/LddmplLz4EcVXJEqr
         9SX7I2U3xD75CP2FYHTdcGTVOUJI4KlSXzYsqna4ZBNfqxS8OT+TLWg5e8irSUYzrE
         XQylvDy1PBcAU6fAnOcPtbBQjkmGQm/yQ+v30KeIQqyJKFp5Ka3G/QZv3a1g2427Aa
         HmnduMPIbIGmOHLn0ap1tKxtAYKdWPM1dX61HzGcAiReFuwXKHYBss6t2kmsI7PYPq
         WcDyLY3L8P2n72qi3OKUbYjypd5DmtKaeG417vHbnHnPkiG5u3xcXU9nXUqJWaMrVu
         rtuZNhk74NcbQ==
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
        daniel@ffwll.ch, Jun.Lei@amd.com, Wesley.Chalmers@amd.com,
        wenjing.liu@amd.com, aric.cyr@amd.com, mwen@igalia.com,
        felipe.clark@amd.com, sungjoon.kim@amd.com,
        aurabindo.pillai@amd.com, Charlene.Liu@amd.com, duncan.ma@amd.com,
        Brian.Chang@amd.com, Dillon.Varone@amd.com, Syed.Hassan@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.3 24/44] drm/amd/display: fixed dcn30+ underflow issue
Date:   Sun, 30 Apr 2023 22:56:12 -0400
Message-Id: <20230501025632.3253067-24-sashal@kernel.org>
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
index df787fcf8e86e..0e730445459c7 100644
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
index d13e46eeee3c0..6d3f2335b9f1e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
@@ -285,7 +285,7 @@ void dcn31_init_hw(struct dc *dc)
 	if (dc->clk_mgr->funcs->notify_wm_ranges)
 		dc->clk_mgr->funcs->notify_wm_ranges(dc->clk_mgr);
 
-	if (dc->clk_mgr->funcs->set_hard_max_memclk)
+	if (dc->clk_mgr->funcs->set_hard_max_memclk && !dc->clk_mgr->dc_mode_softmax_enabled)
 		dc->clk_mgr->funcs->set_hard_max_memclk(dc->clk_mgr);
 
 	if (dc->res_pool->hubbub->funcs->force_pstate_change_control)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 9d14045cccd63..ae96157e98ecb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -895,7 +895,7 @@ void dcn32_init_hw(struct dc *dc)
 	if (dc->clk_mgr->funcs->notify_wm_ranges)
 		dc->clk_mgr->funcs->notify_wm_ranges(dc->clk_mgr);
 
-	if (dc->clk_mgr->funcs->set_hard_max_memclk)
+	if (dc->clk_mgr->funcs->set_hard_max_memclk && !dc->clk_mgr->dc_mode_softmax_enabled)
 		dc->clk_mgr->funcs->set_hard_max_memclk(dc->clk_mgr);
 
 	if (dc->res_pool->hubbub->funcs->force_pstate_change_control)
-- 
2.39.2


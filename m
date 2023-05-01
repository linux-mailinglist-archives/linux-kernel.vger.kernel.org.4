Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083A06F2C2F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 04:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbjEAC6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 22:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjEAC6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 22:58:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F8610CA;
        Sun, 30 Apr 2023 19:57:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0870C61628;
        Mon,  1 May 2023 02:57:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724ABC4339C;
        Mon,  1 May 2023 02:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682909862;
        bh=4pPVHYEAZWbJahev3Eq2w8HYt0C6JYYI7TKXF+3xQwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iJuZ0u81UhrNYjgvANP/1LL3OHYYqW8G8NhOr5HuZv568cch0PYQIPM6PE1AueMvq
         8QRMoxroxKpTc72thIhlJ9om+xax7tgncGFkB/AFZQjcFUsh3s6jis2KpWLhrvm37F
         UiO3F2rSxKsS56d14kd+eGcfQZku8QlB0VYgGiTWiPwIquGYxjTYH1m5YedmruktA8
         2Px6rijahOutt5JF640Mm1oOZqs/kHUfiY/UxsIoqlZOsZtXzLiWM179QKxGMGBTdZ
         hGzY0y/r/yZ2aNgI9w5stBpVrGBdWEuiiTMS57qRbl8mzICeLurcU1hvCS4JzUMRc/
         MKO+z/M4ewfYw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Samson Tam <Samson.Tam@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, harry.wentland@amd.com,
        sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, Jun.Lei@amd.com, Dillon.Varone@amd.com,
        Syed.Hassan@amd.com, Ethan.Wellenreiter@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.3 12/44] drm/amd/display: reallocate DET for dual displays with high pixel rate ratio
Date:   Sun, 30 Apr 2023 22:56:00 -0400
Message-Id: <20230501025632.3253067-12-sashal@kernel.org>
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

From: Samson Tam <Samson.Tam@amd.com>

[ Upstream commit 5f3401eeb064fab5ce50728cce46532cce7a85c5 ]

[Why]
For dual displays where pixel rate is much higher on one display,
we may get underflow when DET is evenly allocated.

[How]
Allocate less DET segments for the lower pixel rate display and
more DET segments for the higher pixel rate display

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../display/dc/dcn32/dcn32_resource_helpers.c | 43 ++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index 3a2d7bcc4b6d6..8310bcf651728 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -261,6 +261,8 @@ bool dcn32_is_psr_capable(struct pipe_ctx *pipe)
 	return psr_capable;
 }
 
+#define DCN3_2_NEW_DET_OVERRIDE_MIN_MULTIPLIER 7
+
 /**
  * *******************************************************************************************
  * dcn32_determine_det_override: Determine DET allocation for each pipe
@@ -272,7 +274,6 @@ bool dcn32_is_psr_capable(struct pipe_ctx *pipe)
  * If there is a plane that's driven by more than 1 pipe (i.e. pipe split), then the
  * number of DET for that given plane will be split among the pipes driving that plane.
  *
- *
  * High level algorithm:
  * 1. Split total DET among number of streams
  * 2. For each stream, split DET among the planes
@@ -280,6 +281,18 @@ bool dcn32_is_psr_capable(struct pipe_ctx *pipe)
  *    among those pipes.
  * 4. Assign the DET override to the DML pipes.
  *
+ * Special cases:
+ *
+ * For two displays that have a large difference in pixel rate, we may experience
+ *  underflow on the larger display when we divide the DET equally. For this, we
+ *  will implement a modified algorithm to assign more DET to larger display.
+ *
+ * 1. Calculate difference in pixel rates ( multiplier ) between two displays
+ * 2. If the multiplier exceeds DCN3_2_NEW_DET_OVERRIDE_MIN_MULTIPLIER, then
+ *    implement the modified DET override algorithm.
+ * 3. Assign smaller DET size for lower pixel display and higher DET size for
+ *    higher pixel display
+ *
  * @param [in]: dc: Current DC state
  * @param [in]: context: New DC state to be programmed
  * @param [in]: pipes: Array of DML pipes
@@ -299,18 +312,46 @@ void dcn32_determine_det_override(struct dc *dc,
 	struct dc_plane_state *current_plane = NULL;
 	uint8_t stream_count = 0;
 
+	int phy_pix_clk_mult, lower_mode_stream_index;
+	int phy_pix_clk[MAX_PIPES] = {0};
+	bool use_new_det_override_algorithm = false;
+
 	for (i = 0; i < context->stream_count; i++) {
 		/* Don't count SubVP streams for DET allocation */
 		if (context->streams[i]->mall_stream_config.type != SUBVP_PHANTOM) {
+			phy_pix_clk[i] = context->streams[i]->phy_pix_clk;
 			stream_count++;
 		}
 	}
 
+	/* Check for special case with two displays, one with much higher pixel rate */
+	if (stream_count == 2) {
+		ASSERT(!phy_pix_clk[0] || !phy_pix_clk[1]);
+		if (phy_pix_clk[0] < phy_pix_clk[1]) {
+			lower_mode_stream_index = 0;
+			phy_pix_clk_mult = phy_pix_clk[1] / phy_pix_clk[0];
+		} else {
+			lower_mode_stream_index = 1;
+			phy_pix_clk_mult = phy_pix_clk[0] / phy_pix_clk[1];
+		}
+
+		if (phy_pix_clk_mult >= DCN3_2_NEW_DET_OVERRIDE_MIN_MULTIPLIER)
+			use_new_det_override_algorithm = true;
+	}
+
 	if (stream_count > 0) {
 		stream_segments = 18 / stream_count;
 		for (i = 0; i < context->stream_count; i++) {
 			if (context->streams[i]->mall_stream_config.type == SUBVP_PHANTOM)
 				continue;
+
+			if (use_new_det_override_algorithm) {
+				if (i == lower_mode_stream_index)
+					stream_segments = 4;
+				else
+					stream_segments = 14;
+			}
+
 			if (context->stream_status[i].plane_count > 0)
 				plane_segments = stream_segments / context->stream_status[i].plane_count;
 			else
-- 
2.39.2


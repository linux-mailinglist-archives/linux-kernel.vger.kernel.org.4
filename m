Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C4F66AE2A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 22:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjANVV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 16:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjANVVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 16:21:48 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B6F59C3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 13:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1673731300; bh=EkdauZCzQ1cK93hqglTGGg1XeEnBheNqHiWtPXNdtH8=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=XhaDOnDIboT6HCOBi1Ymfsr1Y6Thl/XtXDfsJo0awOhjDpzE0YGLvpx7PZv9j6ILh
         F7ssoq7ABRMbWJVVbK+jNVcpD92miRRgcBenViQa/EDXB0PMgu5ElN5Liur2opihuC
         /l8bLK4o8/Qadrmo97MrkgVISH/z0KdN0C8yDL+E=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sat, 14 Jan 2023 22:21:40 +0100 (CET)
X-EA-Auth: wo+VQO9ffl4BHSNsx5JlMnia2RZdbHBhkeMPohaTckEHMhLVrBSduq54Ewvo2nRbQ50i0bdeCxQfsQUaF/76y+PJLAqy/qhx
Date:   Sun, 15 Jan 2023 02:51:35 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: [PATCH 4/4] drm/amd/display: dcn32: Use min()/max() helper macros
Message-ID: <85526bdbb34b6f9bff0118170578cea29755354d.1673730293.git.drv@mailo.com>
References: <cover.1673730293.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1673730293.git.drv@mailo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the standard min() / max() helper macros instead of direct variable
comparison using if/else blocks or ternary operator. Change identified
using minmax.cocci Coccinelle semantic patch.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index f94abd124021..80820f012891 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -908,7 +908,7 @@ static bool subvp_drr_schedulable(struct dc *dc, struct dc_state *context, struc
 	stretched_drr_us = drr_frame_us + mall_region_us + SUBVP_DRR_MARGIN_US;
 	drr_stretched_vblank_us = (drr_timing->v_total - drr_timing->v_addressable) * drr_timing->h_total /
 			(double)(drr_timing->pix_clk_100hz * 100) * 1000000 + (stretched_drr_us - drr_frame_us);
-	max_vblank_mallregion = drr_stretched_vblank_us > mall_region_us ? drr_stretched_vblank_us : mall_region_us;
+	max_vblank_mallregion = max(drr_stretched_vblank_us, mall_region_us);
 
 	/* We consider SubVP + DRR schedulable if the stretched frame duration of the DRR display (i.e. the
 	 * highest refresh rate + margin that can support UCLK P-State switch) passes the static analysis
@@ -999,7 +999,7 @@ static bool subvp_vblank_schedulable(struct dc *dc, struct dc_state *context)
 				(double)(vblank_timing->pix_clk_100hz * 100) * 1000000;
 		subvp_active_us = main_timing->v_addressable * main_timing->h_total /
 				(double)(main_timing->pix_clk_100hz * 100) * 1000000;
-		max_vblank_mallregion = vblank_blank_us > mall_region_us ? vblank_blank_us : mall_region_us;
+		max_vblank_mallregion = max(vblank_blank_us, mall_region_us);
 
 		// Schedulable if VACTIVE region of the SubVP pipe can fit the MALL prefetch, VBLANK frame time,
 		// and the max of (VBLANK blanking time, MALL region)
-- 
2.34.1




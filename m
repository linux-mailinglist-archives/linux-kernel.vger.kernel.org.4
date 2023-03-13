Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E2C6B6CED
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 01:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjCMA4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 20:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjCMA4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 20:56:13 -0400
X-Greylist: delayed 394 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 12 Mar 2023 17:56:10 PDT
Received: from out-32.mta1.migadu.com (out-32.mta1.migadu.com [95.215.58.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEAD1EBF2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 17:56:10 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bcheng.me; s=key1;
        t=1678668571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/Bkqs2R+3MEoIRL8QEDpEtBOS+h+4C4T2XbVTnOUNIg=;
        b=bxr9QXNhiSQos5uqKZu0GBVkMhrXbMkeSYPTWHLSDYX64KIRQoLKNv5Ut6uyzjKbGPKAWT
        X7zZNhER8iYEkHYzuph7+7ASoIJE2FxML52sj2C8lII5zDS0CN0Sh4b0bujUdVkIGFBw/L
        fmu5he+ud07XsUw6ZkQQLCsef8WWcdG/j1MHLslkeLn180cCHrnf1ZurtOA9hOKoosdmYo
        5MMg8yZdSNELkc+m/28uUYvz6fgxCeStHUfyTsiTFD0Wsc7RW/vl657oAgNcWPNiaatVNY
        LGTbsXLXOXjOg16gO+2dUFcCIFyD9DfFLd5gyeAEg8p/h/rj+4Z216MsT0h3dA==
From:   Benjamin Cheng <ben@bcheng.me>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc:     Benjamin Cheng <ben@bcheng.me>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: Write to correct dirty_rect
Date:   Sun, 12 Mar 2023 20:47:39 -0400
Message-Id: <20230313004739.3110719-1-ben@bcheng.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When FB_DAMAGE_CLIPS are provided in a non-MPO scenario, the loop does
not use the counter i. This causes the fill_dc_dity_rect() to always
fill dirty_rects[0], causing graphical artifacts when a damage clip
aware DRM client sends more than 1 damage clip.

Instead, use the flip_addrs->dirty_rect_count which is incremented by
fill_dc_dirty_rect() on a successful fill.

Fixes: 30ebe41582d1 ("drm/amd/display: add FB_DAMAGE_CLIPS support")
Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2453
Signed-off-by: Benjamin Cheng <ben@bcheng.me>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8af58bba503f..a89ec2cc4ffc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5130,9 +5130,9 @@ static void fill_dc_dirty_rects(struct drm_plane *plane,
 
 		for (; flip_addrs->dirty_rect_count < num_clips; clips++)
 			fill_dc_dirty_rect(new_plane_state->plane,
-					   &dirty_rects[i], clips->x1,
-					   clips->y1, clips->x2 - clips->x1,
-					   clips->y2 - clips->y1,
+					   &dirty_rects[flip_addrs->dirty_rect_count],
+					   clips->x1, clips->y1,
+					   clips->x2 - clips->x1, clips->y2 - clips->y1,
 					   &flip_addrs->dirty_rect_count,
 					   false);
 		return;
-- 
2.39.2


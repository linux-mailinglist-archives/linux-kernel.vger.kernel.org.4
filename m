Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C085B7589
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 17:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236683AbiIMPsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 11:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236675AbiIMPrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 11:47:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 09AFE70E40
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 07:50:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14C5C106F;
        Tue, 13 Sep 2022 07:43:25 -0700 (PDT)
Received: from 000377403353.arm.com (000377403353.arm.com [10.2.13.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE8A43F73B;
        Tue, 13 Sep 2022 07:43:16 -0700 (PDT)
From:   Brian Starkey <brian.starkey@arm.com>
To:     ville.syrjala@linux.intel.com, butterflyhuangxx@gmail.com
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        ben.davis@arm.com, Liviu.Dudau@arm.com, jonas@kwiboo.se,
        George Kennedy <george.kennedy@oracle.com>
Subject: [PATCH] drm/fourcc: Fix vsub/hsub for Q410 and Q401
Date:   Tue, 13 Sep 2022 15:43:06 +0100
Message-Id: <20220913144306.17279-1-brian.starkey@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YyA9Y+Cs8ZCYHXAT@intel.com>
References: <YyA9Y+Cs8ZCYHXAT@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These formats are not subsampled, but that means hsub and vsub should be
1, not 0.

Fixes: 94b292b27734 ("drm: drm_fourcc: add NV15, Q410, Q401 YUV formats")
Reported-by: George Kennedy <george.kennedy@oracle.com>
Reported-by: butt3rflyh4ck <butterflyhuangxx@gmail.com>
Signed-off-by: Brian Starkey <brian.starkey@arm.com>
---
 drivers/gpu/drm/drm_fourcc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Sorry, I lost track of this - I thought it got fixed after the previous
thread[1].

-Brian

[1] https://lore.kernel.org/all/26fdb955-10c8-a5d6-07b6-85a4374e7754@oracle.com/

diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index 07741b678798..6768b7d18b6f 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -263,12 +263,12 @@ const struct drm_format_info *__drm_format_info(u32 format)
 		  .vsub = 2, .is_yuv = true },
 		{ .format = DRM_FORMAT_Q410,		.depth = 0,
 		  .num_planes = 3, .char_per_block = { 2, 2, 2 },
-		  .block_w = { 1, 1, 1 }, .block_h = { 1, 1, 1 }, .hsub = 0,
-		  .vsub = 0, .is_yuv = true },
+		  .block_w = { 1, 1, 1 }, .block_h = { 1, 1, 1 }, .hsub = 1,
+		  .vsub = 1, .is_yuv = true },
 		{ .format = DRM_FORMAT_Q401,		.depth = 0,
 		  .num_planes = 3, .char_per_block = { 2, 2, 2 },
-		  .block_w = { 1, 1, 1 }, .block_h = { 1, 1, 1 }, .hsub = 0,
-		  .vsub = 0, .is_yuv = true },
+		  .block_w = { 1, 1, 1 }, .block_h = { 1, 1, 1 }, .hsub = 1,
+		  .vsub = 1, .is_yuv = true },
 		{ .format = DRM_FORMAT_P030,            .depth = 0,  .num_planes = 2,
 		  .char_per_block = { 4, 8, 0 }, .block_w = { 3, 3, 0 }, .block_h = { 1, 1, 0 },
 		  .hsub = 2, .vsub = 2, .is_yuv = true},
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF1D70FFAE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 23:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233629AbjEXVKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 17:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjEXVKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 17:10:51 -0400
X-Greylist: delayed 601 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 24 May 2023 14:10:49 PDT
Received: from luna.linkmauve.fr (82-65-109-163.subs.proxad.net [82.65.109.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01089C1;
        Wed, 24 May 2023 14:10:48 -0700 (PDT)
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
        id 4C4E87AF8BC; Wed, 24 May 2023 22:54:53 +0200 (CEST)
From:   Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Azkali Manad <a.ffcc7@gmail.com>
Cc:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Subject: [PATCH] drm/tegra: dc: cap non-cursor plane zpos to 254
Date:   Wed, 24 May 2023 22:54:46 +0200
Message-Id: <20230524205446.1778614-1-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RCVD_IN_SORBS_DUL,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since cursor plane has the immutable zpos 255, other planes can’t take
its place so we can cap them to 254 instead.

Thanks emersion!

Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
---
 drivers/gpu/drm/tegra/dc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index 6e78416e64b0..e9a416fb4db7 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -838,7 +838,7 @@ static struct drm_plane *tegra_primary_plane_create(struct drm_device *drm,
 	}
 
 	drm_plane_helper_add(&plane->base, &tegra_plane_helper_funcs);
-	drm_plane_create_zpos_property(&plane->base, plane->index, 0, 255);
+	drm_plane_create_zpos_property(&plane->base, plane->index, 0, 254);
 
 	err = drm_plane_create_rotation_property(&plane->base,
 						 DRM_MODE_ROTATE_0,
@@ -1292,7 +1292,7 @@ static struct drm_plane *tegra_dc_overlay_plane_create(struct drm_device *drm,
 	}
 
 	drm_plane_helper_add(&plane->base, &tegra_plane_helper_funcs);
-	drm_plane_create_zpos_property(&plane->base, plane->index, 0, 255);
+	drm_plane_create_zpos_property(&plane->base, plane->index, 0, 254);
 
 	err = drm_plane_create_rotation_property(&plane->base,
 						 DRM_MODE_ROTATE_0,
-- 
2.40.1


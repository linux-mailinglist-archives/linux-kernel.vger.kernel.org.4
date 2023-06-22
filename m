Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82DB739D1B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 11:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjFVJax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 05:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbjFVJ3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 05:29:46 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D544234
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 02:22:46 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:991a:a831:ea4b:6058])
        by xavier.telenet-ops.be with bizsmtp
        id C9Nj2A0091yfRTD019NjEL; Thu, 22 Jun 2023 11:22:43 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qCGWX-000BwK-Ob;
        Thu, 22 Jun 2023 11:22:43 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qCGWZ-003Vwt-Bd;
        Thu, 22 Jun 2023 11:22:43 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 17/39] drm: renesas: shmobile: Use drmm_universal_plane_alloc()
Date:   Thu, 22 Jun 2023 11:21:29 +0200
Message-Id: <9af0b0e18c6f3ce3348cc728f177bf466e30e66a.1687423204.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1687423204.git.geert+renesas@glider.be>
References: <cover.1687423204.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the comments for drm_universal_plane_init(), the plane
structure should not be allocated with devm_kzalloc().

Fix lifetime issues by using drmm_universal_plane_alloc() instead.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Plane (and connector) structures are still allocated with devm_kzalloc()
in several other drivers...
---
 .../drm/renesas/shmobile/shmob_drm_plane.c    | 24 ++++++-------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c
index 0b2ab153e9ae76df..1fb68b5fe915b8dc 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c
@@ -176,16 +176,9 @@ static int shmob_drm_plane_disable(struct drm_plane *plane,
 	return 0;
 }
 
-static void shmob_drm_plane_destroy(struct drm_plane *plane)
-{
-	drm_plane_force_disable(plane);
-	drm_plane_cleanup(plane);
-}
-
 static const struct drm_plane_funcs shmob_drm_plane_funcs = {
 	.update_plane = shmob_drm_plane_update,
 	.disable_plane = shmob_drm_plane_disable,
-	.destroy = shmob_drm_plane_destroy,
 };
 
 static const uint32_t formats[] = {
@@ -204,19 +197,16 @@ static const uint32_t formats[] = {
 int shmob_drm_plane_create(struct shmob_drm_device *sdev, unsigned int index)
 {
 	struct shmob_drm_plane *splane;
-	int ret;
 
-	splane = devm_kzalloc(sdev->dev, sizeof(*splane), GFP_KERNEL);
-	if (splane == NULL)
-		return -ENOMEM;
+	splane = drmm_universal_plane_alloc(sdev->ddev, struct shmob_drm_plane,
+					    plane, 1, &shmob_drm_plane_funcs,
+					    formats, ARRAY_SIZE(formats), NULL,
+					    DRM_PLANE_TYPE_OVERLAY, NULL);
+	if (IS_ERR(splane))
+		return PTR_ERR(splane);
 
 	splane->index = index;
 	splane->alpha = 255;
 
-	ret = drm_universal_plane_init(sdev->ddev, &splane->plane, 1,
-				       &shmob_drm_plane_funcs,
-				       formats, ARRAY_SIZE(formats), NULL,
-				       DRM_PLANE_TYPE_OVERLAY, NULL);
-
-	return ret;
+	return 0;
 }
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCAD70E095
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237196AbjEWPdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236110AbjEWPdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:33:13 -0400
X-Greylist: delayed 1650 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 23 May 2023 08:32:46 PDT
Received: from weierstrass.telenet-ops.be (weierstrass.telenet-ops.be [195.130.137.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB870E43
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 08:32:46 -0700 (PDT)
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by weierstrass.telenet-ops.be (Postfix) with ESMTPS id 4QQdc902Sjz4x1lW
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 17:32:41 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:b0ac:7afd:272:4cff])
        by xavier.telenet-ops.be with bizsmtp
        id 0FXf2A00f0Jkz7G01FXfas; Tue, 23 May 2023 17:31:40 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1q1Tyu-002t3e-Jd;
        Tue, 23 May 2023 17:31:39 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1q1Tz9-00Ckax-1x;
        Tue, 23 May 2023 17:31:39 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 3/5] drm: shmobile: Switch to drm_crtc_init_with_planes()
Date:   Tue, 23 May 2023 17:31:35 +0200
Message-Id: <2098de3d33bc479a8569da7dcbafdb685ff0a13a.1684854992.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1684854992.git.geert+renesas@glider.be>
References: <cover.1684854992.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SH-Mobile DRM driver uses the legacy drm_crtc_init(), which
advertizes only the formats in safe_modeset_formats[] (XR24 and AR24) as
being supported.

Switch to drm_crtc_init_with_planes(), and advertize all supported
(A)RGB modes, so we can use RGB565 as the default mode for the console.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v3:
  - No changes,

v2:
  - Add Reviewed-by.
---
 drivers/gpu/drm/shmobile/shmob_drm_crtc.c | 30 +++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/shmobile/shmob_drm_crtc.c b/drivers/gpu/drm/shmobile/shmob_drm_crtc.c
index 08dc1428aa16caf0..11dd2bc803e7cb62 100644
--- a/drivers/gpu/drm/shmobile/shmob_drm_crtc.c
+++ b/drivers/gpu/drm/shmobile/shmob_drm_crtc.c
@@ -18,6 +18,7 @@
 #include <drm/drm_gem_dma_helper.h>
 #include <drm/drm_modeset_helper.h>
 #include <drm/drm_modeset_helper_vtables.h>
+#include <drm/drm_plane_helper.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_simple_kms_helper.h>
 #include <drm/drm_vblank.h>
@@ -478,16 +479,41 @@ static const struct drm_crtc_funcs crtc_funcs = {
 	.disable_vblank = shmob_drm_disable_vblank,
 };
 
+static const uint32_t modeset_formats[] = {
+	DRM_FORMAT_RGB565,
+	DRM_FORMAT_RGB888,
+	DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_XRGB8888,
+};
+
+static const struct drm_plane_funcs primary_plane_funcs = {
+	DRM_PLANE_NON_ATOMIC_FUNCS,
+};
+
 int shmob_drm_crtc_create(struct shmob_drm_device *sdev)
 {
 	struct drm_crtc *crtc = &sdev->crtc.crtc;
+	struct drm_plane *primary;
 	int ret;
 
 	sdev->crtc.dpms = DRM_MODE_DPMS_OFF;
 
-	ret = drm_crtc_init(sdev->ddev, crtc, &crtc_funcs);
-	if (ret < 0)
+	primary = __drm_universal_plane_alloc(sdev->ddev, sizeof(*primary), 0,
+					      0, &primary_plane_funcs,
+					      modeset_formats,
+					      ARRAY_SIZE(modeset_formats),
+					      NULL, DRM_PLANE_TYPE_PRIMARY,
+					      NULL);
+	if (IS_ERR(primary))
+		return PTR_ERR(primary);
+
+	ret = drm_crtc_init_with_planes(sdev->ddev, crtc, primary, NULL,
+					&crtc_funcs, NULL);
+	if (ret < 0) {
+		drm_plane_cleanup(primary);
+		kfree(primary);
 		return ret;
+	}
 
 	drm_crtc_helper_add(crtc, &crtc_helper_funcs);
 
-- 
2.34.1


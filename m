Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8886739D33
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 11:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjFVJcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 05:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjFVJ36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 05:29:58 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02984EDA
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 02:22:48 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:991a:a831:ea4b:6058])
        by xavier.telenet-ops.be with bizsmtp
        id C9Nk2A0021yfRTD019NkEr; Thu, 22 Jun 2023 11:22:44 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qCGWY-000Bxi-A0;
        Thu, 22 Jun 2023 11:22:43 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qCGWZ-003VyL-SY;
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
Subject: [PATCH 35/39] drm: renesas: shmobile: Atomic conversion part 2
Date:   Thu, 22 Jun 2023 11:21:47 +0200
Message-Id: <9e78fa9a5da1ba163cf3a6c71f73a77ef8abed40.1687423204.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1687423204.git.geert+renesas@glider.be>
References: <cover.1687423204.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement atomic mode setting for the CRTC, using the existing dpms
callback.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This works, but I had expected that crtc_helper_funcs.atomic_check
should point to drm_crtc_helper_atomic_check() instead, as the primary
plane cannot be disabled.  However in doing so, when
drm_atomic_helper_check_crtc_primary_plane() fails:

    [drm:drm_atomic_helper_check_crtc_primary_plane] [CRTC:41:crtc-0] primary plane missing

the display fails to restore after running "modetest -s", until I run
modetest without -s.

Letting shmob_drm_plane_atomic_check() return -EINVAL if
!new_plane_state->crtc && is_primary would fix that, but causes an ugly
warning:

    WARNING: CPU: 0 PID: 21 at drivers/gpu/drm/drm_framebuffer.c:1130 drm_framebuffer_remove+0x374/0x4b0
    atomic remove_fb failed with -22
---
 .../gpu/drm/renesas/shmobile/shmob_drm_crtc.c | 41 +++++++------------
 1 file changed, 15 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
index ea19e802792e24a4..cf7152d64424e720 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
@@ -11,6 +11,7 @@
 #include <linux/media-bus-format.h>
 #include <linux/pm_runtime.h>
 
+#include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_atomic_state_helper.h>
 #include <drm/drm_atomic_uapi.h>
@@ -371,27 +372,6 @@ static void shmob_drm_crtc_dpms(struct drm_crtc *crtc, int mode)
 	scrtc->dpms = mode;
 }
 
-static void shmob_drm_crtc_mode_prepare(struct drm_crtc *crtc)
-{
-	shmob_drm_crtc_dpms(crtc, DRM_MODE_DPMS_OFF);
-}
-
-static void shmob_drm_crtc_mode_commit(struct drm_crtc *crtc)
-{
-	shmob_drm_crtc_dpms(crtc, DRM_MODE_DPMS_ON);
-}
-
-static int shmob_drm_crtc_atomic_check(struct drm_crtc *crtc,
-				       struct drm_atomic_state *state)
-{
-	return 0;
-}
-
-static void shmob_drm_crtc_atomic_begin(struct drm_crtc *crtc,
-					struct drm_atomic_state *state)
-{
-}
-
 static void shmob_drm_crtc_atomic_flush(struct drm_crtc *crtc,
 					struct drm_atomic_state *state)
 {
@@ -408,13 +388,22 @@ static void shmob_drm_crtc_atomic_flush(struct drm_crtc *crtc,
 	}
 }
 
+static void shmob_drm_crtc_atomic_enable(struct drm_crtc *crtc,
+					 struct drm_atomic_state *state)
+{
+	shmob_drm_crtc_dpms(crtc, DRM_MODE_DPMS_ON);
+}
+
+static void shmob_drm_crtc_atomic_disable(struct drm_crtc *crtc,
+					  struct drm_atomic_state *state)
+{
+	shmob_drm_crtc_dpms(crtc, DRM_MODE_DPMS_OFF);
+}
+
 static const struct drm_crtc_helper_funcs crtc_helper_funcs = {
-	.dpms = shmob_drm_crtc_dpms,
-	.prepare = shmob_drm_crtc_mode_prepare,
-	.commit = shmob_drm_crtc_mode_commit,
-	.atomic_check = shmob_drm_crtc_atomic_check,
-	.atomic_begin = shmob_drm_crtc_atomic_begin,
 	.atomic_flush = shmob_drm_crtc_atomic_flush,
+	.atomic_enable = shmob_drm_crtc_atomic_enable,
+	.atomic_disable = shmob_drm_crtc_atomic_disable,
 };
 
 static int shmob_drm_crtc_page_flip(struct drm_crtc *crtc,
-- 
2.34.1


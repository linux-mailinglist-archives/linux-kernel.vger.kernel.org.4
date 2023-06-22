Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B2C739D45
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 11:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjFVJcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 05:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjFVJaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 05:30:01 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C154EDB
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 02:22:48 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:991a:a831:ea4b:6058])
        by michel.telenet-ops.be with bizsmtp
        id C9Nk2A00Q1yfRTD069NkE2; Thu, 22 Jun 2023 11:22:44 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qCGWY-000Bxr-C9;
        Thu, 22 Jun 2023 11:22:44 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qCGWZ-003VyW-Uu;
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
Subject: [PATCH 37/39] drm: renesas: shmobile: Remove internal CRTC state tracking
Date:   Thu, 22 Jun 2023 11:21:49 +0200
Message-Id: <7a758de388d2f904ac94eb256d815bb6b7bc6663.1687423204.git.geert+renesas@glider.be>
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

Now the suspend/resume methods no longer need to look at internal driver
state, the dpms and started fields in the shmob_drm_crtc structure can
be removed, as well as the shmob_drm_crtc_dpms() wrapper.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../gpu/drm/renesas/shmobile/shmob_drm_crtc.c | 35 ++++---------------
 .../gpu/drm/renesas/shmobile/shmob_drm_crtc.h |  3 --
 2 files changed, 6 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
index b11bb666de3bac46..f2332bb0fbbd51a1 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
@@ -196,9 +196,6 @@ static void shmob_drm_crtc_start(struct shmob_drm_crtc *scrtc)
 	u32 value;
 	int ret;
 
-	if (scrtc->started)
-		return;
-
 	ret = pm_runtime_resume_and_get(dev);
 	if (ret)
 		return;
@@ -252,8 +249,6 @@ static void shmob_drm_crtc_start(struct shmob_drm_crtc *scrtc)
 
 	/* Turn vertical blank interrupt reporting back on. */
 	drm_crtc_vblank_on(crtc);
-
-	scrtc->started = true;
 }
 
 /* -----------------------------------------------------------------------------
@@ -314,9 +309,6 @@ static void shmob_drm_crtc_stop(struct shmob_drm_crtc *scrtc)
 	struct drm_crtc *crtc = &scrtc->base;
 	struct shmob_drm_device *sdev = to_shmob_device(crtc->dev);
 
-	if (!scrtc->started)
-		return;
-
 	/*
 	 * Disable vertical blank interrupt reporting.  We first need to wait
 	 * for page flip completion before stopping the CRTC as userspace
@@ -335,8 +327,6 @@ static void shmob_drm_crtc_stop(struct shmob_drm_crtc *scrtc)
 	shmob_drm_clk_off(sdev);
 
 	pm_runtime_put(sdev->dev);
-
-	scrtc->started = false;
 }
 
 static inline struct shmob_drm_crtc *to_shmob_crtc(struct drm_crtc *crtc)
@@ -344,21 +334,6 @@ static inline struct shmob_drm_crtc *to_shmob_crtc(struct drm_crtc *crtc)
 	return container_of(crtc, struct shmob_drm_crtc, base);
 }
 
-static void shmob_drm_crtc_dpms(struct drm_crtc *crtc, int mode)
-{
-	struct shmob_drm_crtc *scrtc = to_shmob_crtc(crtc);
-
-	if (scrtc->dpms == mode)
-		return;
-
-	if (mode == DRM_MODE_DPMS_ON)
-		shmob_drm_crtc_start(scrtc);
-	else
-		shmob_drm_crtc_stop(scrtc);
-
-	scrtc->dpms = mode;
-}
-
 static void shmob_drm_crtc_atomic_flush(struct drm_crtc *crtc,
 					struct drm_atomic_state *state)
 {
@@ -378,13 +353,17 @@ static void shmob_drm_crtc_atomic_flush(struct drm_crtc *crtc,
 static void shmob_drm_crtc_atomic_enable(struct drm_crtc *crtc,
 					 struct drm_atomic_state *state)
 {
-	shmob_drm_crtc_dpms(crtc, DRM_MODE_DPMS_ON);
+	struct shmob_drm_crtc *scrtc = to_shmob_crtc(crtc);
+
+	shmob_drm_crtc_start(scrtc);
 }
 
 static void shmob_drm_crtc_atomic_disable(struct drm_crtc *crtc,
 					  struct drm_atomic_state *state)
 {
-	shmob_drm_crtc_dpms(crtc, DRM_MODE_DPMS_OFF);
+	struct shmob_drm_crtc *scrtc = to_shmob_crtc(crtc);
+
+	shmob_drm_crtc_stop(scrtc);
 }
 
 static const struct drm_crtc_helper_funcs crtc_helper_funcs = {
@@ -476,8 +455,6 @@ int shmob_drm_crtc_create(struct shmob_drm_device *sdev)
 
 	init_waitqueue_head(&sdev->crtc.flip_wait);
 
-	sdev->crtc.dpms = DRM_MODE_DPMS_OFF;
-
 	primary = shmob_drm_plane_create(sdev, 0);
 	if (IS_ERR(primary))
 		return PTR_ERR(primary);
diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.h b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.h
index 37380c815f1f5a08..89a0746f9a35807d 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.h
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.h
@@ -27,9 +27,6 @@ struct shmob_drm_crtc {
 
 	struct drm_pending_vblank_event *event;
 	wait_queue_head_t flip_wait;
-	int dpms;
-
-	bool started;
 };
 
 struct shmob_drm_connector {
-- 
2.34.1


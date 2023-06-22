Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3AF739D2B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 11:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjFVJcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 05:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjFVJaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 05:30:05 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44BB4EE4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 02:22:50 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:991a:a831:ea4b:6058])
        by albert.telenet-ops.be with bizsmtp
        id C9Nk2A00C1yfRTD069Nkkb; Thu, 22 Jun 2023 11:22:44 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qCGWY-000Bxn-BN;
        Thu, 22 Jun 2023 11:22:44 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qCGWZ-003VyR-U1;
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
Subject: [PATCH 36/39] drm: renesas: shmobile: Use suspend/resume helpers
Date:   Thu, 22 Jun 2023 11:21:48 +0200
Message-Id: <dfc123f733f907c70b4365676c2211bdeca44ad2.1687423204.git.geert+renesas@glider.be>
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

Replace the custom suspend/resume handling by calls into
drm_mode_config_helper_{suspend,resume}().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c | 13 -------------
 drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.h |  2 --
 drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c  | 13 +++----------
 3 files changed, 3 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
index cf7152d64424e720..b11bb666de3bac46 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
@@ -339,19 +339,6 @@ static void shmob_drm_crtc_stop(struct shmob_drm_crtc *scrtc)
 	scrtc->started = false;
 }
 
-void shmob_drm_crtc_suspend(struct shmob_drm_crtc *scrtc)
-{
-	shmob_drm_crtc_stop(scrtc);
-}
-
-void shmob_drm_crtc_resume(struct shmob_drm_crtc *scrtc)
-{
-	if (scrtc->dpms != DRM_MODE_DPMS_ON)
-		return;
-
-	shmob_drm_crtc_start(scrtc);
-}
-
 static inline struct shmob_drm_crtc *to_shmob_crtc(struct drm_crtc *crtc)
 {
 	return container_of(crtc, struct shmob_drm_crtc, base);
diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.h b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.h
index fe41e42d6cc55275..37380c815f1f5a08 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.h
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.h
@@ -40,8 +40,6 @@ struct shmob_drm_connector {
 
 int shmob_drm_crtc_create(struct shmob_drm_device *sdev);
 void shmob_drm_crtc_finish_page_flip(struct shmob_drm_crtc *scrtc);
-void shmob_drm_crtc_suspend(struct shmob_drm_crtc *scrtc);
-void shmob_drm_crtc_resume(struct shmob_drm_crtc *scrtc);
 
 int shmob_drm_encoder_create(struct shmob_drm_device *sdev);
 int shmob_drm_connector_create(struct shmob_drm_device *sdev,
diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
index 9107f84224602683..c43f408d6b1fcc5b 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
@@ -20,6 +20,7 @@
 #include <drm/drm_drv.h>
 #include <drm/drm_fbdev_generic.h>
 #include <drm/drm_gem_dma_helper.h>
+#include <drm/drm_modeset_helper.h>
 #include <drm/drm_module.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_vblank.h>
@@ -115,22 +116,14 @@ static int shmob_drm_pm_suspend(struct device *dev)
 {
 	struct shmob_drm_device *sdev = dev_get_drvdata(dev);
 
-	drm_kms_helper_poll_disable(&sdev->ddev);
-	shmob_drm_crtc_suspend(&sdev->crtc);
-
-	return 0;
+	return drm_mode_config_helper_suspend(&sdev->ddev);
 }
 
 static int shmob_drm_pm_resume(struct device *dev)
 {
 	struct shmob_drm_device *sdev = dev_get_drvdata(dev);
 
-	drm_modeset_lock_all(&sdev->ddev);
-	shmob_drm_crtc_resume(&sdev->crtc);
-	drm_modeset_unlock_all(&sdev->ddev);
-
-	drm_kms_helper_poll_enable(&sdev->ddev);
-	return 0;
+	return drm_mode_config_helper_resume(&sdev->ddev);
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(shmob_drm_pm_ops,
-- 
2.34.1


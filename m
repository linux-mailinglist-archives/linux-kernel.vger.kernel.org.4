Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06BA0739D2E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 11:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjFVJbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 05:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbjFVJ3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 05:29:54 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102684EC7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 02:22:47 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:991a:a831:ea4b:6058])
        by xavier.telenet-ops.be with bizsmtp
        id C9Nj2A0121yfRTD019NjEk; Thu, 22 Jun 2023 11:22:44 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qCGWY-000BxI-5P;
        Thu, 22 Jun 2023 11:22:43 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qCGWZ-003Vy1-Nu;
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
Subject: [PATCH 31/39] drm: renesas: shmobile: Turn vblank on/off when enabling/disabling CRTC
Date:   Thu, 22 Jun 2023 11:21:43 +0200
Message-Id: <c299dd21b17c43b56d4bc8bc0b2cad8d3edda397.1687423204.git.geert+renesas@glider.be>
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

The DRM core vblank handling mechanism requires drivers to forcefully
turn vblank reporting off when disabling the CRTC, and to restore the
vblank reporting status when enabling the CRTC.
Implement this using the drm_crtc_vblank_{on,off}() helpers.

Note that drm_crtc_vblank_off() must be called at startup to synchronize
the state of the vblank core code with the hardware, which is initially
disabled.  This is performed at CRTC creation time, requiring vertical
blank initialization to be moved before creating CRTCs.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c | 10 +++++++++-
 drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c  | 12 ++++++------
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
index d2a0ac5f9368c11c..b184019d8b1ed89c 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
@@ -267,6 +267,9 @@ static void shmob_drm_crtc_start(struct shmob_drm_crtc *scrtc)
 
 	shmob_drm_crtc_start_stop(scrtc, true);
 
+	/* Turn vertical blank interrupt reporting back on. */
+	drm_crtc_vblank_on(crtc);
+
 	scrtc->started = true;
 }
 
@@ -332,10 +335,12 @@ static void shmob_drm_crtc_stop(struct shmob_drm_crtc *scrtc)
 		return;
 
 	/*
-	 * Wait for page flip completion before stopping the CRTC as userspace
+	 * Disable vertical blank interrupt reporting.  We first need to wait
+	 * for page flip completion before stopping the CRTC as userspace
 	 * expects page flips to eventually complete.
 	 */
 	shmob_drm_crtc_wait_page_flip(scrtc);
+	drm_crtc_vblank_off(crtc);
 
 	/* Stop the LCDC. */
 	shmob_drm_crtc_start_stop(scrtc, false);
@@ -571,6 +576,9 @@ int shmob_drm_crtc_create(struct shmob_drm_device *sdev)
 
 	drm_crtc_helper_add(crtc, &crtc_helper_funcs);
 
+	/* Start with vertical blank interrupt reporting disabled. */
+	drm_crtc_vblank_off(crtc);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
index 6eaf2c5a104f451a..a29c0c1093725b6e 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
@@ -189,17 +189,17 @@ static int shmob_drm_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	ret = shmob_drm_modeset_init(sdev);
-	if (ret < 0)
-		return dev_err_probe(&pdev->dev, ret,
-				     "failed to initialize mode setting\n");
-
 	ret = drm_vblank_init(ddev, 1);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to initialize vblank\n");
-		goto err_modeset_cleanup;
+		return ret;
 	}
 
+	ret = shmob_drm_modeset_init(sdev);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to initialize mode setting\n");
+
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0)
 		goto err_modeset_cleanup;
-- 
2.34.1


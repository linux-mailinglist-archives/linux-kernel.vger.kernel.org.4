Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4794B739D21
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 11:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjFVJbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 05:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbjFVJ3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 05:29:49 -0400
Received: from gauss.telenet-ops.be (gauss.telenet-ops.be [195.130.132.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFB94C39
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 02:22:46 -0700 (PDT)
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by gauss.telenet-ops.be (Postfix) with ESMTPS id 4QmvzT0070z4x4Cm
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 11:22:44 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:991a:a831:ea4b:6058])
        by baptiste.telenet-ops.be with bizsmtp
        id C9Nj2A0091yfRTD019NjqG; Thu, 22 Jun 2023 11:22:44 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qCGWX-000Bwb-SW;
        Thu, 22 Jun 2023 11:22:43 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qCGWZ-003VxD-Ew;
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
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 21/39] drm: renesas: shmobile: Use struct videomode in platform data
Date:   Thu, 22 Jun 2023 11:21:33 +0200
Message-Id: <d8d4d80699e8a7da1cb7f31b29d64a6f2c05dee5.1687423204.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1687423204.git.geert+renesas@glider.be>
References: <cover.1687423204.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace the drm_mode_modeinfo field with videomode that includes more
signal polarity flags.  This simplifies driver handling of panel modes
and prepares for DT support.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
[geert: Simplify]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Changes compared to Laurent's original:
  - Rebase,
  - Fix build,
  - Remove unneeded {width,height}_mm intermediaries from
    shmob_drm_connector,
  - Replace embedded videomode by a const pointer to pdata.
---
 .../gpu/drm/renesas/shmobile/shmob_drm_crtc.c | 35 ++++++++-----------
 .../gpu/drm/renesas/shmobile/shmob_drm_crtc.h |  3 ++
 include/linux/platform_data/shmob_drm.h       | 11 ++----
 3 files changed, 19 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
index 291b3a5014c24f08..5328910ebe09c832 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
@@ -23,6 +23,8 @@
 #include <drm/drm_simple_kms_helper.h>
 #include <drm/drm_vblank.h>
 
+#include <video/videomode.h>
+
 #include "shmob_drm_crtc.h"
 #include "shmob_drm_drv.h"
 #include "shmob_drm_kms.h"
@@ -64,18 +66,16 @@ static void shmob_drm_crtc_setup_geometry(struct shmob_drm_crtc *scrtc)
 {
 	struct drm_crtc *crtc = &scrtc->crtc;
 	struct shmob_drm_device *sdev = to_shmob_device(crtc->dev);
-	const struct shmob_drm_interface_data *idata = &sdev->pdata->iface;
+	enum display_flags dpy_flags = sdev->connector.mode->flags;
 	const struct drm_display_mode *mode = &crtc->mode;
 	u32 value;
 
 	value = sdev->ldmt1r
 	      | ((mode->flags & DRM_MODE_FLAG_PVSYNC) ? 0 : LDMT1R_VPOL)
 	      | ((mode->flags & DRM_MODE_FLAG_PHSYNC) ? 0 : LDMT1R_HPOL)
-	      | ((idata->flags & SHMOB_DRM_IFACE_FL_DWPOL) ? LDMT1R_DWPOL : 0)
-	      | ((idata->flags & SHMOB_DRM_IFACE_FL_DIPOL) ? LDMT1R_DIPOL : 0)
-	      | ((idata->flags & SHMOB_DRM_IFACE_FL_DAPOL) ? LDMT1R_DAPOL : 0)
-	      | ((idata->flags & SHMOB_DRM_IFACE_FL_HSCNT) ? LDMT1R_HSCNT : 0)
-	      | ((idata->flags & SHMOB_DRM_IFACE_FL_DWCNT) ? LDMT1R_DWCNT : 0);
+	      | ((dpy_flags & DISPLAY_FLAGS_PIXDATA_POSEDGE) ? LDMT1R_DWPOL : 0)
+	      | ((dpy_flags & DISPLAY_FLAGS_DE_LOW) ? LDMT1R_DIPOL : 0);
+
 	lcdc_write(sdev, LDMT1R, value);
 
 	value = ((mode->hdisplay / 8) << 16)			/* HDCN */
@@ -581,7 +581,7 @@ static inline struct shmob_drm_connector *to_shmob_connector(struct drm_connecto
 
 static int shmob_drm_connector_get_modes(struct drm_connector *connector)
 {
-	struct shmob_drm_device *sdev = to_shmob_device(connector->dev);
+	struct shmob_drm_connector *scon = to_shmob_connector(connector);
 	struct drm_display_mode *mode;
 
 	mode = drm_mode_create(connector->dev);
@@ -589,18 +589,9 @@ static int shmob_drm_connector_get_modes(struct drm_connector *connector)
 		return 0;
 
 	mode->type = DRM_MODE_TYPE_PREFERRED | DRM_MODE_TYPE_DRIVER;
-	mode->clock = sdev->pdata->panel.mode.clock;
-	mode->hdisplay = sdev->pdata->panel.mode.hdisplay;
-	mode->hsync_start = sdev->pdata->panel.mode.hsync_start;
-	mode->hsync_end = sdev->pdata->panel.mode.hsync_end;
-	mode->htotal = sdev->pdata->panel.mode.htotal;
-	mode->vdisplay = sdev->pdata->panel.mode.vdisplay;
-	mode->vsync_start = sdev->pdata->panel.mode.vsync_start;
-	mode->vsync_end = sdev->pdata->panel.mode.vsync_end;
-	mode->vtotal = sdev->pdata->panel.mode.vtotal;
-	mode->flags = sdev->pdata->panel.mode.flags;
-
-	drm_mode_set_name(mode);
+
+	drm_display_mode_from_videomode(scon->mode, mode);
+
 	drm_mode_probed_add(connector, mode);
 
 	return 1;
@@ -634,10 +625,12 @@ static const struct drm_connector_funcs connector_funcs = {
 int shmob_drm_connector_create(struct shmob_drm_device *sdev,
 			       struct drm_encoder *encoder)
 {
-	struct drm_connector *connector = &sdev->connector.connector;
+	struct shmob_drm_connector *scon = &sdev->connector;
+	struct drm_connector *connector = &scon->connector;
 	int ret;
 
-	sdev->connector.encoder = encoder;
+	scon->encoder = encoder;
+	scon->mode = &sdev->pdata->panel.mode;
 
 	connector->display_info.width_mm = sdev->pdata->panel.width_mm;
 	connector->display_info.height_mm = sdev->pdata->panel.height_mm;
diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.h b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.h
index bce6926269453b77..f507eaf912e16a22 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.h
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.h
@@ -14,6 +14,8 @@
 #include <drm/drm_connector.h>
 #include <drm/drm_encoder.h>
 
+#include <video/videomode.h>
+
 struct drm_pending_vblank_event;
 struct shmob_drm_device;
 struct shmob_drm_format_info;
@@ -33,6 +35,7 @@ struct shmob_drm_crtc {
 struct shmob_drm_connector {
 	struct drm_connector connector;
 	struct drm_encoder *encoder;
+	const struct videomode *mode;
 };
 
 int shmob_drm_crtc_create(struct shmob_drm_device *sdev);
diff --git a/include/linux/platform_data/shmob_drm.h b/include/linux/platform_data/shmob_drm.h
index b728e24222d99158..f3cb19ff9f818aca 100644
--- a/include/linux/platform_data/shmob_drm.h
+++ b/include/linux/platform_data/shmob_drm.h
@@ -10,7 +10,7 @@
 #ifndef __SHMOB_DRM_H__
 #define __SHMOB_DRM_H__
 
-#include <drm/drm_mode.h>
+#include <video/videomode.h>
 
 enum shmob_drm_clk_source {
 	SHMOB_DRM_CLK_BUS,
@@ -32,19 +32,12 @@ enum shmob_drm_interface {
 struct shmob_drm_panel_data {
 	unsigned int width_mm;		/* Panel width in mm */
 	unsigned int height_mm;		/* Panel height in mm */
-	struct drm_mode_modeinfo mode;
+	struct videomode mode;
 };
 
-#define SHMOB_DRM_IFACE_FL_DWPOL (1 << 0) /* Rising edge dot clock data latch */
-#define SHMOB_DRM_IFACE_FL_DIPOL (1 << 1) /* Active low display enable */
-#define SHMOB_DRM_IFACE_FL_DAPOL (1 << 2) /* Active low display data */
-#define SHMOB_DRM_IFACE_FL_HSCNT (1 << 3) /* Disable HSYNC during VBLANK */
-#define SHMOB_DRM_IFACE_FL_DWCNT (1 << 4) /* Disable dotclock during blanking */
-
 struct shmob_drm_interface_data {
 	enum shmob_drm_interface interface;
 	unsigned int clk_div;
-	unsigned int flags;
 };
 
 struct shmob_drm_platform_data {
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CA0739D42
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 11:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbjFVJc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 05:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjFVJaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 05:30:24 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491BF1735
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 02:22:54 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:991a:a831:ea4b:6058])
        by andre.telenet-ops.be with bizsmtp
        id C9Nj2A00X1yfRTD019NjNo; Thu, 22 Jun 2023 11:22:44 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qCGWX-000Bw9-MD;
        Thu, 22 Jun 2023 11:22:43 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qCGWZ-003Vwf-97;
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
Subject: [PATCH 14/39] drm: renesas: shmobile: Remove support for SYS panels
Date:   Thu, 22 Jun 2023 11:21:26 +0200
Message-Id: <125fa4482d5020e3b5a2dbaa39fd772a28eda291.1687423204.git.geert+renesas@glider.be>
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

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

SYS panels are not used, and have no defined DT bindings.  Remove their
support to avoid impeding DT support.  It can always be added back
later.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Changes compared to Laurent's original:
  - Remove "/* TODO: Setup SYS panel */" comment.
---
 .../gpu/drm/renesas/shmobile/shmob_drm_crtc.c | 20 ---------------
 .../gpu/drm/renesas/shmobile/shmob_drm_drv.c  | 11 --------
 include/linux/platform_data/shmob_drm.h       | 25 -------------------
 3 files changed, 56 deletions(-)

diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
index 0eeb1410b662d74b..bcdebbc9f8a7e299 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
@@ -78,24 +78,6 @@ static void shmob_drm_crtc_setup_geometry(struct shmob_drm_crtc *scrtc)
 	      | ((idata->flags & SHMOB_DRM_IFACE_FL_DWCNT) ? LDMT1R_DWCNT : 0);
 	lcdc_write(sdev, LDMT1R, value);
 
-	if (idata->interface >= SHMOB_DRM_IFACE_SYS8A &&
-	    idata->interface <= SHMOB_DRM_IFACE_SYS24) {
-		/* Setup SYS bus. */
-		value = (idata->sys.cs_setup << LDMT2R_CSUP_SHIFT)
-		      | (idata->sys.vsync_active_high ? LDMT2R_RSV : 0)
-		      | (idata->sys.vsync_dir_input ? LDMT2R_VSEL : 0)
-		      | (idata->sys.write_setup << LDMT2R_WCSC_SHIFT)
-		      | (idata->sys.write_cycle << LDMT2R_WCEC_SHIFT)
-		      | (idata->sys.write_strobe << LDMT2R_WCLW_SHIFT);
-		lcdc_write(sdev, LDMT2R, value);
-
-		value = (idata->sys.read_latch << LDMT3R_RDLC_SHIFT)
-		      | (idata->sys.read_setup << LDMT3R_RCSC_SHIFT)
-		      | (idata->sys.read_cycle << LDMT3R_RCEC_SHIFT)
-		      | (idata->sys.read_strobe << LDMT3R_RCLW_SHIFT);
-		lcdc_write(sdev, LDMT3R, value);
-	}
-
 	value = ((mode->hdisplay / 8) << 16)			/* HDCN */
 	      | (mode->htotal / 8);				/* HTCN */
 	lcdc_write(sdev, LDHCNR, value);
@@ -210,8 +192,6 @@ static void shmob_drm_crtc_start(struct shmob_drm_crtc *scrtc)
 	lcdc_write(sdev, LDDCKSTPR, 0);
 	lcdc_wait_bit(sdev, LDDCKSTPR, ~0, 0);
 
-	/* TODO: Setup SYS panel */
-
 	/* Setup geometry, format, frame buffer memory and operation mode. */
 	shmob_drm_crtc_setup_geometry(scrtc);
 
diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
index 007ba97cc7733c82..9aa9800899976a23 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
@@ -43,17 +43,6 @@ static int shmob_drm_init_interface(struct shmob_drm_device *sdev)
 		[SHMOB_DRM_IFACE_RGB18] = LDMT1R_MIFTYP_RGB18,
 		[SHMOB_DRM_IFACE_RGB24] = LDMT1R_MIFTYP_RGB24,
 		[SHMOB_DRM_IFACE_YUV422] = LDMT1R_MIFTYP_YCBCR,
-		[SHMOB_DRM_IFACE_SYS8A] = LDMT1R_IFM | LDMT1R_MIFTYP_SYS8A,
-		[SHMOB_DRM_IFACE_SYS8B] = LDMT1R_IFM | LDMT1R_MIFTYP_SYS8B,
-		[SHMOB_DRM_IFACE_SYS8C] = LDMT1R_IFM | LDMT1R_MIFTYP_SYS8C,
-		[SHMOB_DRM_IFACE_SYS8D] = LDMT1R_IFM | LDMT1R_MIFTYP_SYS8D,
-		[SHMOB_DRM_IFACE_SYS9] = LDMT1R_IFM | LDMT1R_MIFTYP_SYS9,
-		[SHMOB_DRM_IFACE_SYS12] = LDMT1R_IFM | LDMT1R_MIFTYP_SYS12,
-		[SHMOB_DRM_IFACE_SYS16A] = LDMT1R_IFM | LDMT1R_MIFTYP_SYS16A,
-		[SHMOB_DRM_IFACE_SYS16B] = LDMT1R_IFM | LDMT1R_MIFTYP_SYS16B,
-		[SHMOB_DRM_IFACE_SYS16C] = LDMT1R_IFM | LDMT1R_MIFTYP_SYS16C,
-		[SHMOB_DRM_IFACE_SYS18] = LDMT1R_IFM | LDMT1R_MIFTYP_SYS18,
-		[SHMOB_DRM_IFACE_SYS24] = LDMT1R_IFM | LDMT1R_MIFTYP_SYS24,
 	};
 
 	if (sdev->pdata->iface.interface >= ARRAY_SIZE(ldmt1r)) {
diff --git a/include/linux/platform_data/shmob_drm.h b/include/linux/platform_data/shmob_drm.h
index b6b5b6607fb5e52c..b728e24222d99158 100644
--- a/include/linux/platform_data/shmob_drm.h
+++ b/include/linux/platform_data/shmob_drm.h
@@ -27,17 +27,6 @@ enum shmob_drm_interface {
 	SHMOB_DRM_IFACE_RGB18,		/* 18bpp */
 	SHMOB_DRM_IFACE_RGB24,		/* 24bpp */
 	SHMOB_DRM_IFACE_YUV422,		/* 16bpp */
-	SHMOB_DRM_IFACE_SYS8A,		/* 24bpp, 8:8:8 */
-	SHMOB_DRM_IFACE_SYS8B,		/* 18bpp, 8:8:2 */
-	SHMOB_DRM_IFACE_SYS8C,		/* 18bpp, 2:8:8 */
-	SHMOB_DRM_IFACE_SYS8D,		/* 16bpp, 8:8 */
-	SHMOB_DRM_IFACE_SYS9,		/* 18bpp, 9:9 */
-	SHMOB_DRM_IFACE_SYS12,		/* 24bpp, 12:12 */
-	SHMOB_DRM_IFACE_SYS16A,		/* 16bpp */
-	SHMOB_DRM_IFACE_SYS16B,		/* 18bpp, 16:2 */
-	SHMOB_DRM_IFACE_SYS16C,		/* 18bpp, 2:16 */
-	SHMOB_DRM_IFACE_SYS18,		/* 18bpp */
-	SHMOB_DRM_IFACE_SYS24,		/* 24bpp */
 };
 
 struct shmob_drm_panel_data {
@@ -46,19 +35,6 @@ struct shmob_drm_panel_data {
 	struct drm_mode_modeinfo mode;
 };
 
-struct shmob_drm_sys_interface_data {
-	unsigned int read_latch:6;
-	unsigned int read_setup:8;
-	unsigned int read_cycle:8;
-	unsigned int read_strobe:8;
-	unsigned int write_setup:8;
-	unsigned int write_cycle:8;
-	unsigned int write_strobe:8;
-	unsigned int cs_setup:3;
-	unsigned int vsync_active_high:1;
-	unsigned int vsync_dir_input:1;
-};
-
 #define SHMOB_DRM_IFACE_FL_DWPOL (1 << 0) /* Rising edge dot clock data latch */
 #define SHMOB_DRM_IFACE_FL_DIPOL (1 << 1) /* Active low display enable */
 #define SHMOB_DRM_IFACE_FL_DAPOL (1 << 2) /* Active low display data */
@@ -67,7 +43,6 @@ struct shmob_drm_sys_interface_data {
 
 struct shmob_drm_interface_data {
 	enum shmob_drm_interface interface;
-	struct shmob_drm_sys_interface_data sys;
 	unsigned int clk_div;
 	unsigned int flags;
 };
-- 
2.34.1


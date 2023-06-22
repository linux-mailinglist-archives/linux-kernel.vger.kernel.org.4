Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04428739D04
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 11:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjFVJa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 05:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbjFVJ3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 05:29:42 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F84421D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 02:22:45 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:991a:a831:ea4b:6058])
        by michel.telenet-ops.be with bizsmtp
        id C9Nj2A0081yfRTD069NjCv; Thu, 22 Jun 2023 11:22:43 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qCGWX-000Bvt-IY;
        Thu, 22 Jun 2023 11:22:43 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qCGWZ-003VwK-4t;
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
Subject: [PATCH 10/39] drm: renesas: shmobile: Improve shmob_drm_format_info table
Date:   Thu, 22 Jun 2023 11:21:22 +0200
Message-Id: <a61c89c6e1514ab915ce0842470582e121612688.1687423204.git.geert+renesas@glider.be>
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

Improve the table containing hardware information related to the
supported plane formats:
  1. Move (part of) the overlay format register settings from multiple
     switch() statements spread across the code into the table, like is
     already done for the primary plane register settings,
  2. Remove the .yuv field, as that information can easily be extracted
     from the register settings using a new helper macro,
  3. Shrink and move the .bpp field to reduce table size.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../gpu/drm/renesas/shmobile/shmob_drm_crtc.c | 29 ++--------
 .../gpu/drm/renesas/shmobile/shmob_drm_kms.c  | 42 ++++++++++----
 .../gpu/drm/renesas/shmobile/shmob_drm_kms.h  |  9 ++-
 .../drm/renesas/shmobile/shmob_drm_plane.c    | 56 ++-----------------
 4 files changed, 47 insertions(+), 89 deletions(-)

diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
index cd492806105e5b5d..9bfdfa7c6e2b1001 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
@@ -221,31 +221,12 @@ static void shmob_drm_crtc_start(struct shmob_drm_crtc *scrtc)
 	lcdc_write(sdev, LDDFR, format->lddfr | LDDFR_CF1);
 	lcdc_write(sdev, LDMLSR, scrtc->line_size);
 	lcdc_write(sdev, LDSA1R, scrtc->dma[0]);
-	if (format->yuv)
+	if (shmob_drm_format_is_yuv(format))
 		lcdc_write(sdev, LDSA2R, scrtc->dma[1]);
 	lcdc_write(sdev, LDSM1R, 0);
 
 	/* Word and long word swap. */
-	switch (format->fourcc) {
-	case DRM_FORMAT_RGB565:
-	case DRM_FORMAT_NV21:
-	case DRM_FORMAT_NV61:
-	case DRM_FORMAT_NV42:
-		value = LDDDSR_LS | LDDDSR_WS;
-		break;
-	case DRM_FORMAT_RGB888:
-	case DRM_FORMAT_NV12:
-	case DRM_FORMAT_NV16:
-	case DRM_FORMAT_NV24:
-		value = LDDDSR_LS | LDDDSR_WS | LDDDSR_BS;
-		break;
-	case DRM_FORMAT_ARGB8888:
-	case DRM_FORMAT_XRGB8888:
-	default:
-		value = LDDDSR_LS;
-		break;
-	}
-	lcdc_write(sdev, LDDDSR, value);
+	lcdc_write(sdev, LDDDSR, format->ldddsr);
 
 	/* Setup planes. */
 	drm_for_each_legacy_plane(plane, dev) {
@@ -304,12 +285,12 @@ static void shmob_drm_crtc_compute_base(struct shmob_drm_crtc *scrtc,
 	struct drm_gem_dma_object *gem;
 	unsigned int bpp;
 
-	bpp = scrtc->format->yuv ? 8 : scrtc->format->bpp;
+	bpp = shmob_drm_format_is_yuv(scrtc->format) ? 8 : scrtc->format->bpp;
 	gem = drm_fb_dma_get_gem_obj(fb, 0);
 	scrtc->dma[0] = gem->dma_addr + fb->offsets[0]
 		      + y * fb->pitches[0] + x * bpp / 8;
 
-	if (scrtc->format->yuv) {
+	if (shmob_drm_format_is_yuv(scrtc->format)) {
 		bpp = scrtc->format->bpp - 8;
 		gem = drm_fb_dma_get_gem_obj(fb, 1);
 		scrtc->dma[1] = gem->dma_addr + fb->offsets[1]
@@ -326,7 +307,7 @@ static void shmob_drm_crtc_update_base(struct shmob_drm_crtc *scrtc)
 	shmob_drm_crtc_compute_base(scrtc, crtc->x, crtc->y);
 
 	lcdc_write_mirror(sdev, LDSA1R, scrtc->dma[0]);
-	if (scrtc->format->yuv)
+	if (shmob_drm_format_is_yuv(scrtc->format))
 		lcdc_write_mirror(sdev, LDSA2R, scrtc->dma[1]);
 
 	lcdc_write(sdev, LDRCNTR, lcdc_read(sdev, LDRCNTR) ^ LDRCNTR_MRS);
diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_kms.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_kms.c
index 99381cc0abf3ae1f..8fd360149743f8e2 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_kms.c
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_kms.c
@@ -27,53 +27,73 @@ static const struct shmob_drm_format_info shmob_drm_format_infos[] = {
 	{
 		.fourcc = DRM_FORMAT_RGB565,
 		.bpp = 16,
-		.yuv = false,
 		.lddfr = LDDFR_PKF_RGB16,
+		.ldddsr = LDDDSR_LS | LDDDSR_WS,
+		.ldbbsifr = LDBBSIFR_AL_1 | LDBBSIFR_SWPL | LDBBSIFR_SWPW |
+			    LDBBSIFR_RY | LDBBSIFR_RPKF_RGB16,
 	}, {
 		.fourcc = DRM_FORMAT_RGB888,
 		.bpp = 24,
-		.yuv = false,
 		.lddfr = LDDFR_PKF_RGB24,
+		.ldddsr = LDDDSR_LS | LDDDSR_WS | LDDDSR_BS,
+		.ldbbsifr = LDBBSIFR_AL_1 | LDBBSIFR_SWPL | LDBBSIFR_SWPW |
+			    LDBBSIFR_SWPB | LDBBSIFR_RY | LDBBSIFR_RPKF_RGB24,
 	}, {
 		.fourcc = DRM_FORMAT_ARGB8888,
 		.bpp = 32,
-		.yuv = false,
 		.lddfr = LDDFR_PKF_ARGB32,
+		.ldddsr = LDDDSR_LS,
+		.ldbbsifr = LDBBSIFR_AL_PK | LDBBSIFR_SWPL | LDBBSIFR_RY |
+			    LDBBSIFR_RPKF_ARGB32,
 	}, {
 		.fourcc = DRM_FORMAT_XRGB8888,
 		.bpp = 32,
-		.yuv = false,
 		.lddfr = LDDFR_PKF_ARGB32,
+		.ldddsr = LDDDSR_LS,
+		.ldbbsifr = LDBBSIFR_AL_1 | LDBBSIFR_SWPL | LDBBSIFR_RY |
+			    LDBBSIFR_RPKF_ARGB32,
 	}, {
 		.fourcc = DRM_FORMAT_NV12,
 		.bpp = 12,
-		.yuv = true,
 		.lddfr = LDDFR_CC | LDDFR_YF_420,
+		.ldddsr = LDDDSR_LS | LDDDSR_WS | LDDDSR_BS,
+		.ldbbsifr = LDBBSIFR_AL_1 | LDBBSIFR_SWPL | LDBBSIFR_SWPW |
+			    LDBBSIFR_SWPB | LDBBSIFR_CHRR_420,
 	}, {
 		.fourcc = DRM_FORMAT_NV21,
 		.bpp = 12,
-		.yuv = true,
 		.lddfr = LDDFR_CC | LDDFR_YF_420,
+		.ldddsr = LDDDSR_LS | LDDDSR_WS,
+		.ldbbsifr = LDBBSIFR_AL_1 | LDBBSIFR_SWPL | LDBBSIFR_SWPW |
+			    LDBBSIFR_CHRR_420,
 	}, {
 		.fourcc = DRM_FORMAT_NV16,
 		.bpp = 16,
-		.yuv = true,
 		.lddfr = LDDFR_CC | LDDFR_YF_422,
+		.ldddsr = LDDDSR_LS | LDDDSR_WS | LDDDSR_BS,
+		.ldbbsifr = LDBBSIFR_AL_1 | LDBBSIFR_SWPL | LDBBSIFR_SWPW |
+			    LDBBSIFR_SWPB | LDBBSIFR_CHRR_422,
 	}, {
 		.fourcc = DRM_FORMAT_NV61,
 		.bpp = 16,
-		.yuv = true,
 		.lddfr = LDDFR_CC | LDDFR_YF_422,
+		.ldddsr = LDDDSR_LS | LDDDSR_WS,
+		.ldbbsifr = LDBBSIFR_AL_1 | LDBBSIFR_SWPL | LDBBSIFR_SWPW |
+			    LDBBSIFR_CHRR_422,
 	}, {
 		.fourcc = DRM_FORMAT_NV24,
 		.bpp = 24,
-		.yuv = true,
 		.lddfr = LDDFR_CC | LDDFR_YF_444,
+		.ldddsr = LDDDSR_LS | LDDDSR_WS | LDDDSR_BS,
+		.ldbbsifr = LDBBSIFR_AL_1 | LDBBSIFR_SWPL | LDBBSIFR_SWPW |
+			    LDBBSIFR_SWPB | LDBBSIFR_CHRR_444,
 	}, {
 		.fourcc = DRM_FORMAT_NV42,
 		.bpp = 24,
-		.yuv = true,
 		.lddfr = LDDFR_CC | LDDFR_YF_444,
+		.ldddsr = LDDDSR_LS | LDDDSR_WS,
+		.ldbbsifr = LDBBSIFR_AL_1 | LDBBSIFR_SWPL | LDBBSIFR_SWPW |
+			    LDBBSIFR_CHRR_444,
 	},
 };
 
@@ -112,7 +132,7 @@ shmob_drm_fb_create(struct drm_device *dev, struct drm_file *file_priv,
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (format->yuv) {
+	if (shmob_drm_format_is_yuv(format)) {
 		unsigned int chroma_cpp = format->bpp == 24 ? 2 : 1;
 
 		if (mode_cmd->pitches[1] != mode_cmd->pitches[0] * chroma_cpp) {
diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_kms.h b/drivers/gpu/drm/renesas/shmobile/shmob_drm_kms.h
index 0347b1fd2338a84d..590162c3db20209d 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_kms.h
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_kms.h
@@ -17,11 +17,14 @@ struct shmob_drm_device;
 
 struct shmob_drm_format_info {
 	u32 fourcc;
-	unsigned int bpp;
-	bool yuv;
-	u32 lddfr;
+	u32 lddfr;	/* LCD Data Format Register */
+	u16 ldbbsifr;	/* CHn Source Image Format Register low bits */
+	u8 ldddsr;	/* LCDC Input Image Data Swap Register low bits */
+	u8 bpp;
 };
 
+#define shmob_drm_format_is_yuv(format)	((format)->lddfr & LDDFR_CC)
+
 const struct shmob_drm_format_info *shmob_drm_format_info(u32 fourcc);
 
 int shmob_drm_modeset_init(struct shmob_drm_device *sdev);
diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c
index 36fedb2b74c8b7a2..0b2ab153e9ae76df 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c
@@ -43,12 +43,12 @@ static void shmob_drm_plane_compute_base(struct shmob_drm_plane *splane,
 	struct drm_gem_dma_object *gem;
 	unsigned int bpp;
 
-	bpp = splane->format->yuv ? 8 : splane->format->bpp;
+	bpp = shmob_drm_format_is_yuv(splane->format) ? 8 : splane->format->bpp;
 	gem = drm_fb_dma_get_gem_obj(fb, 0);
 	splane->dma[0] = gem->dma_addr + fb->offsets[0]
 		       + y * fb->pitches[0] + x * bpp / 8;
 
-	if (splane->format->yuv) {
+	if (shmob_drm_format_is_yuv(splane->format)) {
 		bpp = splane->format->bpp - 8;
 		gem = drm_fb_dma_get_gem_obj(fb, 1);
 		splane->dma[1] = gem->dma_addr + fb->offsets[1]
@@ -64,54 +64,8 @@ static void __shmob_drm_plane_setup(struct shmob_drm_plane *splane,
 	u32 format;
 
 	/* TODO: Support ROP3 mode */
-	format = LDBBSIFR_EN | (splane->alpha << LDBBSIFR_LAY_SHIFT);
-
-	switch (splane->format->fourcc) {
-	case DRM_FORMAT_RGB565:
-	case DRM_FORMAT_NV21:
-	case DRM_FORMAT_NV61:
-	case DRM_FORMAT_NV42:
-		format |= LDBBSIFR_SWPL | LDBBSIFR_SWPW;
-		break;
-	case DRM_FORMAT_RGB888:
-	case DRM_FORMAT_NV12:
-	case DRM_FORMAT_NV16:
-	case DRM_FORMAT_NV24:
-		format |= LDBBSIFR_SWPL | LDBBSIFR_SWPW | LDBBSIFR_SWPB;
-		break;
-	case DRM_FORMAT_ARGB8888:
-	case DRM_FORMAT_XRGB8888:
-	default:
-		format |= LDBBSIFR_SWPL;
-		break;
-	}
-
-	switch (splane->format->fourcc) {
-	case DRM_FORMAT_RGB565:
-		format |= LDBBSIFR_AL_1 | LDBBSIFR_RY | LDBBSIFR_RPKF_RGB16;
-		break;
-	case DRM_FORMAT_RGB888:
-		format |= LDBBSIFR_AL_1 | LDBBSIFR_RY | LDBBSIFR_RPKF_RGB24;
-		break;
-	case DRM_FORMAT_ARGB8888:
-		format |= LDBBSIFR_AL_PK | LDBBSIFR_RY | LDBBSIFR_RPKF_ARGB32;
-		break;
-	case DRM_FORMAT_XRGB8888:
-		format |= LDBBSIFR_AL_1 | LDBBSIFR_RY | LDBBSIFR_RPKF_ARGB32;
-		break;
-	case DRM_FORMAT_NV12:
-	case DRM_FORMAT_NV21:
-		format |= LDBBSIFR_AL_1 | LDBBSIFR_CHRR_420;
-		break;
-	case DRM_FORMAT_NV16:
-	case DRM_FORMAT_NV61:
-		format |= LDBBSIFR_AL_1 | LDBBSIFR_CHRR_422;
-		break;
-	case DRM_FORMAT_NV24:
-	case DRM_FORMAT_NV42:
-		format |= LDBBSIFR_AL_1 | LDBBSIFR_CHRR_444;
-		break;
-	}
+	format = LDBBSIFR_EN | (splane->alpha << LDBBSIFR_LAY_SHIFT) |
+		 splane->format->ldbbsifr;
 
 #define plane_reg_dump(sdev, splane, reg) \
 	dev_dbg(sdev->ddev->dev, "%s(%u): %s 0x%08x 0x%08x\n", __func__, \
@@ -144,7 +98,7 @@ static void __shmob_drm_plane_setup(struct shmob_drm_plane *splane,
 	shmob_drm_plane_compute_base(splane, fb, splane->src_x, splane->src_y);
 
 	lcdc_write(sdev, LDBnBSAYR(splane->index), splane->dma[0]);
-	if (splane->format->yuv)
+	if (shmob_drm_format_is_yuv(splane->format))
 		lcdc_write(sdev, LDBnBSACR(splane->index), splane->dma[1]);
 
 	lcdc_write(sdev, LDBCR,
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED65470E084
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237146AbjEWPbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237530AbjEWPbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:31:43 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C61132
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 08:31:42 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:b0ac:7afd:272:4cff])
        by albert.telenet-ops.be with bizsmtp
        id 0FXf2A0050Jkz7G06FXfJX; Tue, 23 May 2023 17:31:40 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1q1Tyu-002t3Z-Ii;
        Tue, 23 May 2023 17:31:39 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1q1Tz9-00Ckas-0y;
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
Subject: [PATCH v3 2/5] drm: shmobile: Add support for DRM_FORMAT_XRGB8888
Date:   Tue, 23 May 2023 17:31:34 +0200
Message-Id: <888cde6d1f70f1610931c4a89801060bb6765ff2.1684854992.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1684854992.git.geert+renesas@glider.be>
References: <cover.1684854992.git.geert+renesas@glider.be>
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

DRM_FORMAT_XRGB8888 aka XR24 is the modus francus of DRM, and should be
supported by all drivers.

The handling for DRM_FORMAT_XRGB8888 is similar to DRM_FORMAT_ARGB8888,
just ignore the alpha channel.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v3:
  - No changes,

v2:
  - Add Reviewed-by.
---
 drivers/gpu/drm/shmobile/shmob_drm_crtc.c  | 1 +
 drivers/gpu/drm/shmobile/shmob_drm_kms.c   | 5 +++++
 drivers/gpu/drm/shmobile/shmob_drm_plane.c | 5 +++++
 3 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/shmobile/shmob_drm_crtc.c b/drivers/gpu/drm/shmobile/shmob_drm_crtc.c
index 713a7612244c647a..08dc1428aa16caf0 100644
--- a/drivers/gpu/drm/shmobile/shmob_drm_crtc.c
+++ b/drivers/gpu/drm/shmobile/shmob_drm_crtc.c
@@ -232,6 +232,7 @@ static void shmob_drm_crtc_start(struct shmob_drm_crtc *scrtc)
 		value = LDDDSR_LS | LDDDSR_WS | LDDDSR_BS;
 		break;
 	case DRM_FORMAT_ARGB8888:
+	case DRM_FORMAT_XRGB8888:
 	default:
 		value = LDDDSR_LS;
 		break;
diff --git a/drivers/gpu/drm/shmobile/shmob_drm_kms.c b/drivers/gpu/drm/shmobile/shmob_drm_kms.c
index 3c5fe3bc183c7c13..99381cc0abf3ae1f 100644
--- a/drivers/gpu/drm/shmobile/shmob_drm_kms.c
+++ b/drivers/gpu/drm/shmobile/shmob_drm_kms.c
@@ -39,6 +39,11 @@ static const struct shmob_drm_format_info shmob_drm_format_infos[] = {
 		.bpp = 32,
 		.yuv = false,
 		.lddfr = LDDFR_PKF_ARGB32,
+	}, {
+		.fourcc = DRM_FORMAT_XRGB8888,
+		.bpp = 32,
+		.yuv = false,
+		.lddfr = LDDFR_PKF_ARGB32,
 	}, {
 		.fourcc = DRM_FORMAT_NV12,
 		.bpp = 12,
diff --git a/drivers/gpu/drm/shmobile/shmob_drm_plane.c b/drivers/gpu/drm/shmobile/shmob_drm_plane.c
index 604ae23825daaafd..850986cee848226a 100644
--- a/drivers/gpu/drm/shmobile/shmob_drm_plane.c
+++ b/drivers/gpu/drm/shmobile/shmob_drm_plane.c
@@ -80,6 +80,7 @@ static void __shmob_drm_plane_setup(struct shmob_drm_plane *splane,
 		format |= LDBBSIFR_SWPL | LDBBSIFR_SWPW | LDBBSIFR_SWPB;
 		break;
 	case DRM_FORMAT_ARGB8888:
+	case DRM_FORMAT_XRGB8888:
 	default:
 		format |= LDBBSIFR_SWPL;
 		break;
@@ -95,6 +96,9 @@ static void __shmob_drm_plane_setup(struct shmob_drm_plane *splane,
 	case DRM_FORMAT_ARGB8888:
 		format |= LDBBSIFR_AL_PK | LDBBSIFR_RY | LDDFR_PKF_ARGB32;
 		break;
+	case DRM_FORMAT_XRGB8888:
+		format |= LDBBSIFR_AL_1 | LDBBSIFR_RY | LDDFR_PKF_ARGB32;
+		break;
 	case DRM_FORMAT_NV12:
 	case DRM_FORMAT_NV21:
 		format |= LDBBSIFR_AL_1 | LDBBSIFR_CHRR_420;
@@ -231,6 +235,7 @@ static const uint32_t formats[] = {
 	DRM_FORMAT_RGB565,
 	DRM_FORMAT_RGB888,
 	DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_XRGB8888,
 	DRM_FORMAT_NV12,
 	DRM_FORMAT_NV21,
 	DRM_FORMAT_NV16,
-- 
2.34.1


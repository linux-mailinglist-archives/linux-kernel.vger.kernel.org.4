Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20966734909
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 00:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjFRWBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 18:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjFRWBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 18:01:30 -0400
Received: from s.wrqvwxzv.outbound-mail.sendgrid.net (s.wrqvwxzv.outbound-mail.sendgrid.net [149.72.154.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511D6CF
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 15:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=from:subject:in-reply-to:references:mime-version:to:cc:
        content-transfer-encoding:content-type:cc:content-type:from:subject:to;
        s=s1; bh=ugWfous5KsbcnnKbZj0TMZzPMGxV9++0NJ/5fHcgZlw=;
        b=Bus/m02lgHoVmOQfb3ta1Mg4+K+KnkB4ANdYrDkH/LUmynFCP80kvzDr9FoX3SeXYWfy
        7TFXRVfHOF+eYMUWN7T2ZfWOvIADWZsl80HWnsU2sTZLCOoHSJC/TkVMdEqUAqeaR58jrn
        8KvM/Hz1ELOv7OPlnlvF6w420Bpg4gf7jJQ/Rf2QHvv1EwhR4Kp/jMqKlv9vNU9cjVMNsE
        h+z7JKnqDfuElzjiiLjEhVzJkULhgYidYUwy1xUNdGHns1ZzAchbRj6qUkKku7OM7niTB8
        eQd4YYukNWkvt7nLF1cHcG3K6nOCinD/PjAjPFAhIkjcWIPL//sDNsnpRhSiVgeg==
Received: by filterdrecv-77869f68cc-5ckz9 with SMTP id filterdrecv-77869f68cc-5ckz9-1-648F7EB7-59
        2023-06-18 22:01:28.035090334 +0000 UTC m=+3363922.884745269
Received: from bionic.localdomain (unknown)
        by geopod-ismtpd-5 (SG)
        with ESMTP
        id 8EjW6wG7SjG_CQ6pCJHWwQ
        Sun, 18 Jun 2023 22:01:27.844 +0000 (UTC)
From:   Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v4 2/2] drm/rockchip: vop: Add NV15, NV20 and NV30 support
Date:   Sun, 18 Jun 2023 22:01:28 +0000 (UTC)
Message-Id: <20230618220122.3911297-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230618220122.3911297-1-jonas@kwiboo.se>
References: <20230618220122.3911297-1-jonas@kwiboo.se>
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0hwRsjo=2F7Hz=2F5HZJ0Z?=
 =?us-ascii?Q?8p1fE7ovghHY39JWHFK35Sgbv5fWzDGYLaq+o16?=
 =?us-ascii?Q?yKmb4D4=2FgOy9m8sLkWYhyCh5h893NgP0ZrvJvAK?=
 =?us-ascii?Q?85OKR85LnBq2BNYR5DbmnZxGbtFkyi6=2FpTTeccc?=
 =?us-ascii?Q?1KqBLlXiCfdmZ0XqpcF9IXzZCW2P8m0qvUO=2Fda?=
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sandy Huang <hjc@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jonas Karlman <jonas@kwiboo.se>
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for displaying 10-bit 4:2:0 and 4:2:2 formats produced by
the Rockchip Video Decoder on RK322X, RK3288, RK3328 and RK3399.
Also add support for 10-bit 4:4:4 format while at it.

V4: Rework RK3328/RK3399 win0/1 data to not affect RK3368
V2: Added NV30 support

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Sandy Huang <hjc@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 29 +++++++++-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h |  1 +
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 63 +++++++++++++++++----
 3 files changed, 81 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index a530ecc4d207..fa0405ad0acf 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -273,6 +273,18 @@ static bool has_uv_swapped(uint32_t format)
 	}
 }
 
+static bool is_fmt_10(uint32_t format)
+{
+	switch (format) {
+	case DRM_FORMAT_NV15:
+	case DRM_FORMAT_NV20:
+	case DRM_FORMAT_NV30:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static enum vop_data_format vop_convert_format(uint32_t format)
 {
 	switch (format) {
@@ -288,12 +300,15 @@ static enum vop_data_format vop_convert_format(uint32_t format)
 	case DRM_FORMAT_BGR565:
 		return VOP_FMT_RGB565;
 	case DRM_FORMAT_NV12:
+	case DRM_FORMAT_NV15:
 	case DRM_FORMAT_NV21:
 		return VOP_FMT_YUV420SP;
 	case DRM_FORMAT_NV16:
+	case DRM_FORMAT_NV20:
 	case DRM_FORMAT_NV61:
 		return VOP_FMT_YUV422SP;
 	case DRM_FORMAT_NV24:
+	case DRM_FORMAT_NV30:
 	case DRM_FORMAT_NV42:
 		return VOP_FMT_YUV444SP;
 	default:
@@ -944,7 +959,12 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 	dsp_sty = dest->y1 + crtc->mode.vtotal - crtc->mode.vsync_start;
 	dsp_st = dsp_sty << 16 | (dsp_stx & 0xffff);
 
-	offset = (src->x1 >> 16) * fb->format->cpp[0];
+	if (fb->format->block_w[0])
+		offset = (src->x1 >> 16) * fb->format->char_per_block[0] /
+			 fb->format->block_w[0];
+	else
+		offset = (src->x1 >> 16) * fb->format->cpp[0];
+
 	offset += (src->y1 >> 16) * fb->pitches[0];
 	dma_addr = rk_obj->dma_addr + offset + fb->offsets[0];
 
@@ -970,6 +990,7 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 	}
 
 	VOP_WIN_SET(vop, win, format, format);
+	VOP_WIN_SET(vop, win, fmt_10, is_fmt_10(fb->format->format));
 	VOP_WIN_SET(vop, win, yrgb_vir, DIV_ROUND_UP(fb->pitches[0], 4));
 	VOP_WIN_SET(vop, win, yrgb_mst, dma_addr);
 	VOP_WIN_YUV2YUV_SET(vop, win_yuv2yuv, y2r_en, is_yuv);
@@ -986,7 +1007,11 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 		uv_obj = fb->obj[1];
 		rk_uv_obj = to_rockchip_obj(uv_obj);
 
-		offset = (src->x1 >> 16) * bpp / hsub;
+		if (fb->format->block_w[1])
+			offset = (src->x1 >> 16) * bpp /
+				 fb->format->block_w[1] / hsub;
+		else
+			offset = (src->x1 >> 16) * bpp / hsub;
 		offset += (src->y1 >> 16) * fb->pitches[1] / vsub;
 
 		dma_addr = rk_uv_obj->dma_addr + offset + fb->offsets[1];
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
index 5f56e0597df8..4b2daefeb8c1 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
@@ -186,6 +186,7 @@ struct vop_win_phy {
 	struct vop_reg enable;
 	struct vop_reg gate;
 	struct vop_reg format;
+	struct vop_reg fmt_10;
 	struct vop_reg rb_swap;
 	struct vop_reg uv_swap;
 	struct vop_reg act_info;
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index 20ac7811c5eb..4f1134010498 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -53,6 +53,23 @@ static const uint32_t formats_win_full[] = {
 	DRM_FORMAT_NV42,
 };
 
+static const uint32_t formats_win_full_10[] = {
+	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_XBGR8888,
+	DRM_FORMAT_ABGR8888,
+	DRM_FORMAT_RGB888,
+	DRM_FORMAT_BGR888,
+	DRM_FORMAT_RGB565,
+	DRM_FORMAT_BGR565,
+	DRM_FORMAT_NV12,
+	DRM_FORMAT_NV16,
+	DRM_FORMAT_NV24,
+	DRM_FORMAT_NV15,
+	DRM_FORMAT_NV20,
+	DRM_FORMAT_NV30,
+};
+
 static const uint64_t format_modifiers_win_full[] = {
 	DRM_FORMAT_MOD_LINEAR,
 	DRM_FORMAT_MOD_INVALID,
@@ -627,11 +644,12 @@ static const struct vop_scl_regs rk3288_win_full_scl = {
 
 static const struct vop_win_phy rk3288_win01_data = {
 	.scl = &rk3288_win_full_scl,
-	.data_formats = formats_win_full,
-	.nformats = ARRAY_SIZE(formats_win_full),
+	.data_formats = formats_win_full_10,
+	.nformats = ARRAY_SIZE(formats_win_full_10),
 	.format_modifiers = format_modifiers_win_full,
 	.enable = VOP_REG(RK3288_WIN0_CTRL0, 0x1, 0),
 	.format = VOP_REG(RK3288_WIN0_CTRL0, 0x7, 1),
+	.fmt_10 = VOP_REG(RK3288_WIN0_CTRL0, 0x1, 4),
 	.rb_swap = VOP_REG(RK3288_WIN0_CTRL0, 0x1, 12),
 	.uv_swap = VOP_REG(RK3288_WIN0_CTRL0, 0x1, 15),
 	.act_info = VOP_REG(RK3288_WIN0_ACT_INFO, 0x1fff1fff, 0),
@@ -936,13 +954,38 @@ static const struct vop_win_yuv2yuv_data rk3399_vop_big_win_yuv2yuv_data[] = {
 
 };
 
-static const struct vop_win_phy rk3399_win01_data = {
+static const struct vop_win_phy rk3399_win0_data = {
 	.scl = &rk3288_win_full_scl,
-	.data_formats = formats_win_full,
-	.nformats = ARRAY_SIZE(formats_win_full),
+	.data_formats = formats_win_full_10,
+	.nformats = ARRAY_SIZE(formats_win_full_10),
 	.format_modifiers = format_modifiers_win_full_afbc,
 	.enable = VOP_REG(RK3288_WIN0_CTRL0, 0x1, 0),
 	.format = VOP_REG(RK3288_WIN0_CTRL0, 0x7, 1),
+	.fmt_10 = VOP_REG(RK3288_WIN0_CTRL0, 0x1, 4),
+	.rb_swap = VOP_REG(RK3288_WIN0_CTRL0, 0x1, 12),
+	.uv_swap = VOP_REG(RK3288_WIN0_CTRL0, 0x1, 15),
+	.x_mir_en = VOP_REG(RK3288_WIN0_CTRL0, 0x1, 21),
+	.y_mir_en = VOP_REG(RK3288_WIN0_CTRL0, 0x1, 22),
+	.act_info = VOP_REG(RK3288_WIN0_ACT_INFO, 0x1fff1fff, 0),
+	.dsp_info = VOP_REG(RK3288_WIN0_DSP_INFO, 0x0fff0fff, 0),
+	.dsp_st = VOP_REG(RK3288_WIN0_DSP_ST, 0x1fff1fff, 0),
+	.yrgb_mst = VOP_REG(RK3288_WIN0_YRGB_MST, 0xffffffff, 0),
+	.uv_mst = VOP_REG(RK3288_WIN0_CBR_MST, 0xffffffff, 0),
+	.yrgb_vir = VOP_REG(RK3288_WIN0_VIR, 0x3fff, 0),
+	.uv_vir = VOP_REG(RK3288_WIN0_VIR, 0x3fff, 16),
+	.src_alpha_ctl = VOP_REG(RK3288_WIN0_SRC_ALPHA_CTRL, 0xff, 0),
+	.dst_alpha_ctl = VOP_REG(RK3288_WIN0_DST_ALPHA_CTRL, 0xff, 0),
+	.channel = VOP_REG(RK3288_WIN0_CTRL2, 0xff, 0),
+};
+
+static const struct vop_win_phy rk3399_win1_data = {
+	.scl = &rk3288_win_full_scl,
+	.data_formats = formats_win_full_10,
+	.nformats = ARRAY_SIZE(formats_win_full_10),
+	.format_modifiers = format_modifiers_win_full,
+	.enable = VOP_REG(RK3288_WIN0_CTRL0, 0x1, 0),
+	.format = VOP_REG(RK3288_WIN0_CTRL0, 0x7, 1),
+	.fmt_10 = VOP_REG(RK3288_WIN0_CTRL0, 0x1, 4),
 	.rb_swap = VOP_REG(RK3288_WIN0_CTRL0, 0x1, 12),
 	.uv_swap = VOP_REG(RK3288_WIN0_CTRL0, 0x1, 15),
 	.x_mir_en = VOP_REG(RK3288_WIN0_CTRL0, 0x1, 21),
@@ -965,9 +1008,9 @@ static const struct vop_win_phy rk3399_win01_data = {
  * AFBC on the primary plane.
  */
 static const struct vop_win_data rk3399_vop_win_data[] = {
-	{ .base = 0x00, .phy = &rk3399_win01_data,
+	{ .base = 0x00, .phy = &rk3399_win0_data,
 	  .type = DRM_PLANE_TYPE_PRIMARY },
-	{ .base = 0x40, .phy = &rk3368_win01_data,
+	{ .base = 0x40, .phy = &rk3399_win1_data,
 	  .type = DRM_PLANE_TYPE_OVERLAY },
 	{ .base = 0x00, .phy = &rk3368_win23_data,
 	  .type = DRM_PLANE_TYPE_OVERLAY },
@@ -1099,11 +1142,11 @@ static const struct vop_intr rk3328_vop_intr = {
 };
 
 static const struct vop_win_data rk3328_vop_win_data[] = {
-	{ .base = 0xd0, .phy = &rk3368_win01_data,
+	{ .base = 0xd0, .phy = &rk3399_win1_data,
 	  .type = DRM_PLANE_TYPE_PRIMARY },
-	{ .base = 0x1d0, .phy = &rk3368_win01_data,
+	{ .base = 0x1d0, .phy = &rk3399_win1_data,
 	  .type = DRM_PLANE_TYPE_OVERLAY },
-	{ .base = 0x2d0, .phy = &rk3368_win01_data,
+	{ .base = 0x2d0, .phy = &rk3399_win1_data,
 	  .type = DRM_PLANE_TYPE_CURSOR },
 };
 
-- 
2.40.1


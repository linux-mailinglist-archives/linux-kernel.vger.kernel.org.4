Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17AC86DD9E2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 13:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjDKLoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 07:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjDKLoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 07:44:17 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8FA9840F9;
        Tue, 11 Apr 2023 04:43:50 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.98,336,1673881200"; 
   d="scan'208";a="155597382"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 11 Apr 2023 20:43:48 +0900
Received: from localhost.localdomain (unknown [10.226.93.123])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 81244400195D;
        Tue, 11 Apr 2023 20:43:43 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v7 13/17] drm: rcar-du: Add rcar_du_lib_fb_create()
Date:   Tue, 11 Apr 2023 12:42:31 +0100
Message-Id: <20230411114235.366042-14-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230411114235.366042-1-biju.das.jz@bp.renesas.com>
References: <20230411114235.366042-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the common code from rcar_du_fb_create->rcar_du_lib_fb_create,
so that rzg2l_du_fb_create() can reuse the common code.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v6->v7:
 * Rebased to drm-tip.
v1->v6:
 * Rebased on drm-misc-next and DU-next.
v1:
 * Created the lib suggested by Laurent.
Ref:
 https://patchwork.kernel.org/project/linux-renesas-soc/patch/20220316131100.30685-6-biju.das.jz@bp.renesas.com/
---
 drivers/gpu/drm/rcar-du/rcar_du_kms.c     | 64 +--------------------
 drivers/gpu/drm/rcar-du/rcar_du_kms_lib.c | 69 +++++++++++++++++++++++
 drivers/gpu/drm/rcar-du/rcar_du_kms_lib.h |  4 ++
 3 files changed, 74 insertions(+), 63 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index ae969f640bb6..74845d8bad9d 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -38,69 +38,7 @@ static struct drm_framebuffer *
 rcar_du_fb_create(struct drm_device *dev, struct drm_file *file_priv,
 		  const struct drm_mode_fb_cmd2 *mode_cmd)
 {
-	struct rcar_du_device *rcdu = to_rcar_du_device(dev);
-	const struct rcar_du_format_info *format;
-	unsigned int chroma_pitch;
-	unsigned int max_pitch;
-	unsigned int align;
-	unsigned int i;
-
-	format = rcar_du_format_info(mode_cmd->pixel_format);
-	if (format == NULL) {
-		dev_dbg(dev->dev, "unsupported pixel format %p4cc\n",
-			&mode_cmd->pixel_format);
-		return ERR_PTR(-EINVAL);
-	}
-
-	if (rcdu->info->gen < 3) {
-		/*
-		 * On Gen2 the DU limits the pitch to 4095 pixels and requires
-		 * buffers to be aligned to a 16 pixels boundary (or 128 bytes
-		 * on some platforms).
-		 */
-		unsigned int bpp = format->planes == 1 ? format->bpp / 8 : 1;
-
-		max_pitch = 4095 * bpp;
-
-		if (rcar_du_needs(rcdu, RCAR_DU_QUIRK_ALIGN_128B))
-			align = 128;
-		else
-			align = 16 * bpp;
-	} else {
-		/*
-		 * On Gen3 the memory interface is handled by the VSP that
-		 * limits the pitch to 65535 bytes and has no alignment
-		 * constraint.
-		 */
-		max_pitch = 65535;
-		align = 1;
-	}
-
-	if (mode_cmd->pitches[0] & (align - 1) ||
-	    mode_cmd->pitches[0] > max_pitch) {
-		dev_dbg(dev->dev, "invalid pitch value %u\n",
-			mode_cmd->pitches[0]);
-		return ERR_PTR(-EINVAL);
-	}
-
-	/*
-	 * Calculate the chroma plane(s) pitch using the horizontal subsampling
-	 * factor. For semi-planar formats, the U and V planes are combined, the
-	 * pitch must thus be doubled.
-	 */
-	chroma_pitch = mode_cmd->pitches[0] / format->hsub;
-	if (format->planes == 2)
-		chroma_pitch *= 2;
-
-	for (i = 1; i < format->planes; ++i) {
-		if (mode_cmd->pitches[i] != chroma_pitch) {
-			dev_dbg(dev->dev,
-				"luma and chroma pitches are not compatible\n");
-			return ERR_PTR(-EINVAL);
-		}
-	}
-
-	return drm_gem_fb_create(dev, file_priv, mode_cmd);
+	return rcar_du_lib_fb_create(dev, file_priv, mode_cmd);
 }
 
 /* -----------------------------------------------------------------------------
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms_lib.c b/drivers/gpu/drm/rcar-du/rcar_du_kms_lib.c
index 37809d06df89..f092d8e4aa16 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms_lib.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms_lib.c
@@ -407,3 +407,72 @@ int rcar_du_dumb_create(struct drm_file *file, struct drm_device *dev,
 
 	return drm_gem_dma_dumb_create_internal(file, dev, args);
 }
+
+struct drm_framebuffer *
+rcar_du_lib_fb_create(struct drm_device *dev, struct drm_file *file_priv,
+		      const struct drm_mode_fb_cmd2 *mode_cmd)
+{
+	struct rcar_du_device *rcdu = to_rcar_du_device(dev);
+	const struct rcar_du_format_info *format;
+	unsigned int chroma_pitch;
+	unsigned int max_pitch;
+	unsigned int align;
+	unsigned int i;
+
+	format = rcar_du_format_info(mode_cmd->pixel_format);
+	if (format == NULL) {
+		dev_dbg(dev->dev, "unsupported pixel format %p4cc\n",
+			&mode_cmd->pixel_format);
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (rcdu->info->gen < 3) {
+		/*
+		 * On Gen2 the DU limits the pitch to 4095 pixels and requires
+		 * buffers to be aligned to a 16 pixels boundary (or 128 bytes
+		 * on some platforms).
+		 */
+		unsigned int bpp = format->planes == 1 ? format->bpp / 8 : 1;
+
+		max_pitch = 4095 * bpp;
+
+		if (rcar_du_needs(rcdu, RCAR_DU_QUIRK_ALIGN_128B))
+			align = 128;
+		else
+			align = 16 * bpp;
+	} else {
+		/*
+		 * On Gen3 the memory interface is handled by the VSP that
+		 * limits the pitch to 65535 bytes and has no alignment
+		 * constraint.
+		 */
+		max_pitch = 65535;
+		align = 1;
+	}
+
+	if (mode_cmd->pitches[0] & (align - 1) ||
+	    mode_cmd->pitches[0] > max_pitch) {
+		dev_dbg(dev->dev, "invalid pitch value %u\n",
+			mode_cmd->pitches[0]);
+		return ERR_PTR(-EINVAL);
+	}
+
+	/*
+	 * Calculate the chroma plane(s) pitch using the horizontal subsampling
+	 * factor. For semi-planar formats, the U and V planes are combined, the
+	 * pitch must thus be doubled.
+	 */
+	chroma_pitch = mode_cmd->pitches[0] / format->hsub;
+	if (format->planes == 2)
+		chroma_pitch *= 2;
+
+	for (i = 1; i < format->planes; ++i) {
+		if (mode_cmd->pitches[i] != chroma_pitch) {
+			dev_dbg(dev->dev,
+				"luma and chroma pitches are not compatible\n");
+			return ERR_PTR(-EINVAL);
+		}
+	}
+
+	return drm_gem_fb_create(dev, file_priv, mode_cmd);
+}
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms_lib.h b/drivers/gpu/drm/rcar-du/rcar_du_kms_lib.h
index 2556966024f8..f264e0415d53 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms_lib.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms_lib.h
@@ -38,4 +38,8 @@ struct drm_gem_object *rcar_du_gem_prime_import_sg_table(struct drm_device *dev,
 				struct dma_buf_attachment *attach,
 				struct sg_table *sgt);
 
+struct drm_framebuffer *
+rcar_du_lib_fb_create(struct drm_device *dev, struct drm_file *file_priv,
+		      const struct drm_mode_fb_cmd2 *mode_cmd);
+
 #endif /* __RCAR_DU_KMS_LIB_H__ */
-- 
2.25.1


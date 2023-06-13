Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E801272DA6C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 09:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240483AbjFMHHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 03:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240398AbjFMHGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 03:06:55 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2819C1FFB;
        Tue, 13 Jun 2023 00:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686639975; x=1718175975;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EXoJDlE0rvVHtvzhro8MbvcrVWmqxytqo57znv5RaEU=;
  b=qm0p7qM1AFJ+i55uLCzWk8mXVzZU7fvQDv6x7flTJK/BEeBKW+lTf3Dr
   kX6rLuRK/VLKDTNXrQDms3JxFjIW6c+AdemsBlSZ4x0kZptL+m73L5zu+
   QvkEv7VrQoC/+K7i50EGN2xZ8Ly8lUaw2TB2gpMJXy2S6/kl9D35trdT5
   CtbJaJsv2ONyEaXLgeYcMnzndXqdctMA38W4uihQhbaSywwNJlBlQlpa0
   M0B4wB8KCu2Ho/bPu5gK54Aal6IGCRYIkiP/9hh+V8RpbHu7c6KSDTvRK
   eKLUENrl9xVwX+qX7B272uAkizKSGbeVRFd7z010zXtmD9MEnbQkzmAUz
   A==;
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="229806880"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jun 2023 00:06:03 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 13 Jun 2023 00:05:56 -0700
Received: from che-lt-i67131.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Tue, 13 Jun 2023 00:05:47 -0700
From:   Manikandan Muralidharan <manikandan.m@microchip.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <sam@ravnborg.org>,
        <bbrezillon@kernel.org>, <airlied@gmail.com>, <daniel@ffwll.ch>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
CC:     <Hari.PrasathGE@microchip.com>,
        <Balamanikandan.Gunasundar@microchip.com>,
        <Durai.ManickamKR@microchip.com>, <Nayabbasha.Sayed@microchip.com>,
        <Dharma.B@microchip.com>, <Varshini.Rajendran@microchip.com>,
        <Balakrishnan.S@microchip.com>,
        Manikandan <manikandan.m@microchip.com>,
        Durai Manickam KR <durai.manickamkr@microchip.com>
Subject: [PATCH 6/9] drm: atmel_hlcdc: Add support for XLCDC in atmel LCD driver
Date:   Tue, 13 Jun 2023 12:34:23 +0530
Message-ID: <20230613070426.467389-7-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230613070426.467389-1-manikandan.m@microchip.com>
References: <20230613070426.467389-1-manikandan.m@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- XLCDC in SAM9X7 has different sets of registers and additional
configuration bits when compared to previous HLCDC IP. Read/write
operation on the controller registers is now separated using the
XLCDC status flag.
	- HEO scaling, window resampling, Alpha blending, YUV-to-RGB
conversion in XLCDC is derived and handled using additional
configuration bits and registers.
	- Writing one to the Enable fields of each layer in LCD_ATTRE
is required to reflect the values set in Configuration, FBA, Enable
registers of each layer

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
[Hari.PrasathGE@microchip.com: update the attribute field for each layer]
Signed-off-by: Hari Prasath Gujulan Elango <Hari.PrasathGE@microchip.com>
[durai.manickamkr@microchip.com: implement status flag to seprate register update]
Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
---
 .../gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c    |  28 +-
 .../gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c   | 297 ++++++++++++++----
 2 files changed, 256 insertions(+), 69 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
index 58184cd6ab0b..7c9cf7c0c75d 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -139,10 +139,10 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
 	state = drm_crtc_state_to_atmel_hlcdc_crtc_state(c->state);
 	cfg = state->output_mode << 8;
 
-	if (adj->flags & DRM_MODE_FLAG_NVSYNC)
+	if (!crtc->dc->is_xlcdc && (adj->flags & DRM_MODE_FLAG_NVSYNC))
 		cfg |= ATMEL_HLCDC_VSPOL;
 
-	if (adj->flags & DRM_MODE_FLAG_NHSYNC)
+	if (!crtc->dc->is_xlcdc && (adj->flags & DRM_MODE_FLAG_NHSYNC))
 		cfg |= ATMEL_HLCDC_HSPOL;
 
 	regmap_update_bits(regmap, ATMEL_HLCDC_CFG(5),
@@ -177,6 +177,18 @@ static void atmel_hlcdc_crtc_atomic_disable(struct drm_crtc *c,
 
 	pm_runtime_get_sync(dev->dev);
 
+	if (crtc->dc->is_xlcdc) {
+		regmap_write(regmap, ATMEL_HLCDC_DIS, ATMEL_XLCDC_CM);
+		while (!regmap_read(regmap, ATMEL_HLCDC_SR, &status) &&
+		       (status & ATMEL_XLCDC_CM))
+			cpu_relax();
+
+		regmap_write(regmap, ATMEL_HLCDC_DIS, ATMEL_XLCDC_SD);
+		while (!regmap_read(regmap, ATMEL_HLCDC_SR, &status) &&
+		       !(status & ATMEL_XLCDC_SD))
+			cpu_relax();
+	}
+
 	regmap_write(regmap, ATMEL_HLCDC_DIS, ATMEL_HLCDC_DISP);
 	while (!regmap_read(regmap, ATMEL_HLCDC_SR, &status) &&
 	       (status & ATMEL_HLCDC_DISP))
@@ -231,6 +243,18 @@ static void atmel_hlcdc_crtc_atomic_enable(struct drm_crtc *c,
 	       !(status & ATMEL_HLCDC_DISP))
 		cpu_relax();
 
+	if (crtc->dc->is_xlcdc) {
+		regmap_write(regmap, ATMEL_HLCDC_EN, ATMEL_XLCDC_CM);
+		while (!regmap_read(regmap, ATMEL_HLCDC_SR, &status) &&
+		       !(status & ATMEL_XLCDC_CM))
+			cpu_relax();
+
+		regmap_write(regmap, ATMEL_HLCDC_EN, ATMEL_XLCDC_SD);
+		while (!regmap_read(regmap, ATMEL_HLCDC_SR, &status) &&
+		       (status & ATMEL_XLCDC_SD))
+			cpu_relax();
+	}
+
 	pm_runtime_put_sync(dev->dev);
 
 }
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
index daa508504f47..fe33476818c4 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
@@ -330,11 +330,59 @@ static void atmel_hlcdc_plane_setup_scaler(struct atmel_hlcdc_plane *plane,
 								     yfactor));
 }
 
+static void atmel_xlcdc_plane_setup_scaler(struct atmel_hlcdc_plane *plane,
+					   struct atmel_hlcdc_plane_state *state)
+{
+	const struct atmel_hlcdc_layer_desc *desc = plane->layer.desc;
+	u32 xfactor, yfactor;
+
+	if (!desc->layout.scaler_config)
+		return;
+
+	if (state->crtc_w == state->src_w && state->crtc_h == state->src_h) {
+		atmel_hlcdc_layer_write_cfg(&plane->layer,
+					    desc->layout.scaler_config, 0);
+		return;
+	}
+
+	/* xfactor = round[(2^20 * XMEMSIZE)/XSIZE)] */
+	xfactor = (1048576 * state->src_w) / state->crtc_w;
+
+	/* yfactor = round[(2^20 * YMEMSIZE)/YSIZE)] */
+	yfactor = (1048576 * state->src_h) / state->crtc_h;
+
+	atmel_hlcdc_layer_write_cfg(&plane->layer, desc->layout.scaler_config,
+				    ATMEL_XLCDC_LAYER_VSCALER_LUMA_ENABLE |
+				    ATMEL_XLCDC_LAYER_VSCALER_CHROMA_ENABLE |
+				    ATMEL_XLCDC_LAYER_HSCALER_LUMA_ENABLE |
+				    ATMEL_XLCDC_LAYER_HSCALER_CHROMA_ENABLE);
+
+	atmel_hlcdc_layer_write_cfg(&plane->layer, desc->layout.scaler_config + 1,
+				    yfactor);
+	atmel_hlcdc_layer_write_cfg(&plane->layer, desc->layout.scaler_config + 3,
+				    xfactor);
+
+	/* As per YCbCr window resampling configuration */
+	if (state->base.fb->format->format == DRM_FORMAT_YUV420) {
+		atmel_hlcdc_layer_write_cfg(&plane->layer, desc->layout.scaler_config + 2,
+					    yfactor / 2);
+		atmel_hlcdc_layer_write_cfg(&plane->layer, desc->layout.scaler_config + 4,
+					    xfactor / 2);
+	} else {
+		/* As per ARGB window resampling configuration */
+		atmel_hlcdc_layer_write_cfg(&plane->layer, desc->layout.scaler_config + 2,
+					    yfactor);
+		atmel_hlcdc_layer_write_cfg(&plane->layer, desc->layout.scaler_config + 4,
+					    xfactor);
+	}
+}
+
 static void
 atmel_hlcdc_plane_update_pos_and_size(struct atmel_hlcdc_plane *plane,
 				      struct atmel_hlcdc_plane_state *state)
 {
 	const struct atmel_hlcdc_layer_desc *desc = plane->layer.desc;
+	struct atmel_hlcdc_dc *dc = plane->base.dev->dev_private;
 
 	if (desc->layout.size)
 		atmel_hlcdc_layer_write_cfg(&plane->layer, desc->layout.size,
@@ -352,7 +400,10 @@ atmel_hlcdc_plane_update_pos_and_size(struct atmel_hlcdc_plane *plane,
 					ATMEL_HLCDC_LAYER_POS(state->crtc_x,
 							      state->crtc_y));
 
-	atmel_hlcdc_plane_setup_scaler(plane, state);
+	if (!(dc->is_xlcdc))
+		atmel_hlcdc_plane_setup_scaler(plane, state);
+	else
+		atmel_xlcdc_plane_setup_scaler(plane, state);
 }
 
 static void
@@ -362,33 +413,58 @@ atmel_hlcdc_plane_update_general_settings(struct atmel_hlcdc_plane *plane,
 	unsigned int cfg = ATMEL_HLCDC_LAYER_DMA_BLEN_INCR16 | state->ahb_id;
 	const struct atmel_hlcdc_layer_desc *desc = plane->layer.desc;
 	const struct drm_format_info *format = state->base.fb->format;
-
+	struct atmel_hlcdc_dc *dc = plane->base.dev->dev_private;
 	/*
 	 * Rotation optimization is not working on RGB888 (rotation is still
 	 * working but without any optimization).
 	 */
-	if (format->format == DRM_FORMAT_RGB888)
+	if ((!(dc->is_xlcdc)) && format->format == DRM_FORMAT_RGB888)
 		cfg |= ATMEL_HLCDC_LAYER_DMA_ROTDIS;
 
-	atmel_hlcdc_layer_write_cfg(&plane->layer, ATMEL_HLCDC_LAYER_DMA_CFG,
-				    cfg);
+	if (!(dc->is_xlcdc)) {
+		atmel_hlcdc_layer_write_cfg(&plane->layer, ATMEL_HLCDC_LAYER_DMA_CFG,
+					    cfg);
 
-	cfg = ATMEL_HLCDC_LAYER_DMA | ATMEL_HLCDC_LAYER_REP;
+		cfg = ATMEL_HLCDC_LAYER_DMA | ATMEL_HLCDC_LAYER_REP;
+	} else {
+		atmel_hlcdc_layer_write_cfg(&plane->layer, ATMEL_XLCDC_LAYER_DMA_CFG,
+					    cfg);
+
+		cfg = ATMEL_XLCDC_LAYER_DMA | ATMEL_XLCDC_LAYER_REP;
+	}
 
 	if (plane->base.type != DRM_PLANE_TYPE_PRIMARY) {
-		cfg |= ATMEL_HLCDC_LAYER_OVR | ATMEL_HLCDC_LAYER_ITER2BL |
-		       ATMEL_HLCDC_LAYER_ITER;
+		if (!(dc->is_xlcdc)) {
+			cfg |= ATMEL_HLCDC_LAYER_OVR | ATMEL_HLCDC_LAYER_ITER2BL |
+			       ATMEL_HLCDC_LAYER_ITER;
+
+			if (format->has_alpha)
+				cfg |= ATMEL_HLCDC_LAYER_LAEN;
+			else
+				cfg |= ATMEL_HLCDC_LAYER_GAEN |
+				       ATMEL_HLCDC_LAYER_GA(state->base.alpha);
+		} else {
+			/*
+			 * Alpha Blending bits specific to SAM9X7 SoC
+			 */
+			cfg |= ATMEL_XLCDC_LAYER_SFACTC_A0_MULT_AS |
+			       ATMEL_XLCDC_LAYER_SFACTA_ONE |
+			       ATMEL_XLCDC_LAYER_DFACTC_M_A0_MULT_AS |
+			       ATMEL_XLCDC_LAYER_DFACTA_ONE;
+			if (format->has_alpha)
+				cfg |= ATMEL_XLCDC_LAYER_A0(0xff);
+			else
+				cfg |= ATMEL_XLCDC_LAYER_A0(state->base.alpha);
+		}
+	}
 
-		if (format->has_alpha)
-			cfg |= ATMEL_HLCDC_LAYER_LAEN;
+	if (state->disc_h && state->disc_w) {
+		if (!(dc->is_xlcdc))
+			cfg |= ATMEL_HLCDC_LAYER_DISCEN;
 		else
-			cfg |= ATMEL_HLCDC_LAYER_GAEN |
-			       ATMEL_HLCDC_LAYER_GA(state->base.alpha);
+			cfg |= ATMEL_XLCDC_LAYER_DISCEN;
 	}
 
-	if (state->disc_h && state->disc_w)
-		cfg |= ATMEL_HLCDC_LAYER_DISCEN;
-
 	atmel_hlcdc_layer_write_cfg(&plane->layer, desc->layout.general_config,
 				    cfg);
 }
@@ -441,33 +517,42 @@ static void atmel_hlcdc_plane_update_buffers(struct atmel_hlcdc_plane *plane,
 					struct atmel_hlcdc_plane_state *state)
 {
 	const struct atmel_hlcdc_layer_desc *desc = plane->layer.desc;
+	struct atmel_hlcdc_dc *dc = plane->base.dev->dev_private;
 	struct drm_framebuffer *fb = state->base.fb;
 	u32 sr;
 	int i;
 
-	sr = atmel_hlcdc_layer_read_reg(&plane->layer, ATMEL_HLCDC_LAYER_CHSR);
+	if (!(dc->is_xlcdc))
+		sr = atmel_hlcdc_layer_read_reg(&plane->layer, ATMEL_HLCDC_LAYER_CHSR);
+	else
+		sr = atmel_hlcdc_layer_read_reg(&plane->layer, ATMEL_XLCDC_LAYER_ENR);
 
 	for (i = 0; i < state->nplanes; i++) {
 		struct drm_gem_dma_object *gem = drm_fb_dma_get_gem_obj(fb, i);
 
 		state->dscrs[i]->addr = gem->dma_addr + state->offsets[i];
 
-		atmel_hlcdc_layer_write_reg(&plane->layer,
-					    ATMEL_HLCDC_LAYER_PLANE_HEAD(i),
-					    state->dscrs[i]->self);
-
-		if (!(sr & ATMEL_HLCDC_LAYER_EN)) {
-			atmel_hlcdc_layer_write_reg(&plane->layer,
-					ATMEL_HLCDC_LAYER_PLANE_ADDR(i),
-					state->dscrs[i]->addr);
+		if (!(dc->is_xlcdc)) {
 			atmel_hlcdc_layer_write_reg(&plane->layer,
-					ATMEL_HLCDC_LAYER_PLANE_CTRL(i),
-					state->dscrs[i]->ctrl);
+						    ATMEL_HLCDC_LAYER_PLANE_HEAD(i),
+						    state->dscrs[i]->self);
+
+			if (!(sr & ATMEL_HLCDC_LAYER_EN)) {
+				atmel_hlcdc_layer_write_reg(&plane->layer,
+							    ATMEL_HLCDC_LAYER_PLANE_ADDR(i),
+							    state->dscrs[i]->addr);
+				atmel_hlcdc_layer_write_reg(&plane->layer,
+							    ATMEL_HLCDC_LAYER_PLANE_CTRL(i),
+							    state->dscrs[i]->ctrl);
+				atmel_hlcdc_layer_write_reg(&plane->layer,
+							    ATMEL_HLCDC_LAYER_PLANE_NEXT(i),
+							    state->dscrs[i]->self);
+			}
+		} else {
 			atmel_hlcdc_layer_write_reg(&plane->layer,
-					ATMEL_HLCDC_LAYER_PLANE_NEXT(i),
-					state->dscrs[i]->self);
+						    ATMEL_XLCDC_LAYER_PLANE_ADDR(i),
+						    state->dscrs[i]->addr);
 		}
-
 		if (desc->layout.xstride[i])
 			atmel_hlcdc_layer_write_cfg(&plane->layer,
 						    desc->layout.xstride[i],
@@ -716,19 +801,31 @@ static void atmel_hlcdc_plane_atomic_disable(struct drm_plane *p,
 					     struct drm_atomic_state *state)
 {
 	struct atmel_hlcdc_plane *plane = drm_plane_to_atmel_hlcdc_plane(p);
-
+	struct atmel_hlcdc_dc *dc = plane->base.dev->dev_private;
 	/* Disable interrupts */
-	atmel_hlcdc_layer_write_reg(&plane->layer, ATMEL_HLCDC_LAYER_IDR,
-				    0xffffffff);
+	if (!(dc->is_xlcdc))
+		atmel_hlcdc_layer_write_reg(&plane->layer, ATMEL_HLCDC_LAYER_IDR,
+					    0xffffffff);
+	else
+		atmel_hlcdc_layer_write_reg(&plane->layer, ATMEL_XLCDC_LAYER_IDR,
+					    0xffffffff);
 
 	/* Disable the layer */
-	atmel_hlcdc_layer_write_reg(&plane->layer, ATMEL_HLCDC_LAYER_CHDR,
-				    ATMEL_HLCDC_LAYER_RST |
-				    ATMEL_HLCDC_LAYER_A2Q |
-				    ATMEL_HLCDC_LAYER_UPDATE);
+	if (!(dc->is_xlcdc))
+		atmel_hlcdc_layer_write_reg(&plane->layer,
+					    ATMEL_HLCDC_LAYER_CHDR,
+					    ATMEL_HLCDC_LAYER_RST |
+					    ATMEL_HLCDC_LAYER_A2Q |
+					    ATMEL_HLCDC_LAYER_UPDATE);
+	else
+		atmel_hlcdc_layer_write_reg(&plane->layer,
+					    ATMEL_XLCDC_LAYER_ENR, 0);
 
 	/* Clear all pending interrupts */
-	atmel_hlcdc_layer_read_reg(&plane->layer, ATMEL_HLCDC_LAYER_ISR);
+	if (!(dc->is_xlcdc))
+		atmel_hlcdc_layer_read_reg(&plane->layer, ATMEL_HLCDC_LAYER_ISR);
+	else
+		atmel_hlcdc_layer_read_reg(&plane->layer, ATMEL_XLCDC_LAYER_ISR);
 }
 
 static void atmel_hlcdc_plane_atomic_update(struct drm_plane *p,
@@ -739,6 +836,7 @@ static void atmel_hlcdc_plane_atomic_update(struct drm_plane *p,
 	struct atmel_hlcdc_plane *plane = drm_plane_to_atmel_hlcdc_plane(p);
 	struct atmel_hlcdc_plane_state *hstate =
 			drm_plane_state_to_atmel_hlcdc_plane_state(new_s);
+	struct atmel_hlcdc_dc *dc = p->dev->dev_private;
 	u32 sr;
 
 	if (!new_s->crtc || !new_s->fb)
@@ -756,23 +854,46 @@ static void atmel_hlcdc_plane_atomic_update(struct drm_plane *p,
 	atmel_hlcdc_plane_update_buffers(plane, hstate);
 	atmel_hlcdc_plane_update_disc_area(plane, hstate);
 
-	/* Enable the overrun interrupts. */
-	atmel_hlcdc_layer_write_reg(&plane->layer, ATMEL_HLCDC_LAYER_IER,
-				    ATMEL_HLCDC_LAYER_OVR_IRQ(0) |
-				    ATMEL_HLCDC_LAYER_OVR_IRQ(1) |
-				    ATMEL_HLCDC_LAYER_OVR_IRQ(2));
-
-	/* Apply the new config at the next SOF event. */
-	sr = atmel_hlcdc_layer_read_reg(&plane->layer, ATMEL_HLCDC_LAYER_CHSR);
-	atmel_hlcdc_layer_write_reg(&plane->layer, ATMEL_HLCDC_LAYER_CHER,
-			ATMEL_HLCDC_LAYER_UPDATE |
-			(sr & ATMEL_HLCDC_LAYER_EN ?
-			 ATMEL_HLCDC_LAYER_A2Q : ATMEL_HLCDC_LAYER_EN));
+	if (!(dc->is_xlcdc)) {
+		/* Enable the overrun interrupts. */
+		atmel_hlcdc_layer_write_reg(&plane->layer, ATMEL_HLCDC_LAYER_IER,
+					    ATMEL_HLCDC_LAYER_OVR_IRQ(0) |
+					    ATMEL_HLCDC_LAYER_OVR_IRQ(1) |
+					    ATMEL_HLCDC_LAYER_OVR_IRQ(2));
+
+		/* Apply the new config at the next SOF event. */
+		sr = atmel_hlcdc_layer_read_reg(&plane->layer, ATMEL_HLCDC_LAYER_CHSR);
+		atmel_hlcdc_layer_write_reg(&plane->layer, ATMEL_HLCDC_LAYER_CHER,
+					    ATMEL_HLCDC_LAYER_UPDATE |
+					    (sr & ATMEL_HLCDC_LAYER_EN ?
+					    ATMEL_HLCDC_LAYER_A2Q : ATMEL_HLCDC_LAYER_EN));
+	} else {
+		/* Enable the overrun interrupts. */
+		atmel_hlcdc_layer_write_reg(&plane->layer, ATMEL_XLCDC_LAYER_IER,
+					    ATMEL_XLCDC_LAYER_OVR_IRQ(0) |
+					    ATMEL_XLCDC_LAYER_OVR_IRQ(1) |
+					    ATMEL_XLCDC_LAYER_OVR_IRQ(2));
+
+		atmel_hlcdc_layer_write_reg(&plane->layer, ATMEL_XLCDC_LAYER_ENR,
+					    ATMEL_XLCDC_LAYER_EN);
+	}
+
+	/*
+	 * Updating XLCDC_xxxCFGx, XLCDC_xxxFBA and XLCDC_xxxEN,
+	 * (where xxx indicates each layer) requires writing one to the
+	 * Update Attribute field for each layer in LCDC_ATTRE register for SAM9X7.
+	 */
+	if (dc->is_xlcdc) {
+		regmap_write(dc->hlcdc->regmap, ATMEL_XLCDC_ATTRE, ATMEL_XLCDC_BASE_UPDATE |
+			     ATMEL_XLCDC_OVR1_UPDATE | ATMEL_XLCDC_OVR3_UPDATE |
+			     ATMEL_XLCDC_HEO_UPDATE);
+	}
 }
 
 static int atmel_hlcdc_plane_init_properties(struct atmel_hlcdc_plane *plane)
 {
 	const struct atmel_hlcdc_layer_desc *desc = plane->layer.desc;
+	struct atmel_hlcdc_dc *dc = plane->base.dev->dev_private;
 
 	if (desc->type == ATMEL_HLCDC_OVERLAY_LAYER ||
 	    desc->type == ATMEL_HLCDC_CURSOR_LAYER) {
@@ -796,20 +917,50 @@ static int atmel_hlcdc_plane_init_properties(struct atmel_hlcdc_plane *plane)
 			return ret;
 	}
 
-	if (desc->layout.csc) {
+	if (!(dc->is_xlcdc)) {
+		if (desc->layout.csc) {
+			/*
+			 * TODO: decare a "yuv-to-rgb-conv-factors" property to let
+			 * userspace modify these factors (using a BLOB property ?).
+			 */
+			atmel_hlcdc_layer_write_cfg(&plane->layer,
+						    desc->layout.csc,
+						    0x4c900091);
+			atmel_hlcdc_layer_write_cfg(&plane->layer,
+						    desc->layout.csc + 1,
+						    0x7a5f5090);
+			atmel_hlcdc_layer_write_cfg(&plane->layer,
+						    desc->layout.csc + 2,
+						    0x40040890);
+		}
+	} else {
 		/*
-		 * TODO: decare a "yuv-to-rgb-conv-factors" property to let
-		 * userspace modify these factors (using a BLOB property ?).
+		 * yuv-to-rgb-conv-factors are now defined from LCDC_HEOCFG16 to
+		 * LCDC_HEOCFG21 registers in SAM9X7.
 		 */
-		atmel_hlcdc_layer_write_cfg(&plane->layer,
-					    desc->layout.csc,
-					    0x4c900091);
-		atmel_hlcdc_layer_write_cfg(&plane->layer,
-					    desc->layout.csc + 1,
-					    0x7a5f5090);
-		atmel_hlcdc_layer_write_cfg(&plane->layer,
-					    desc->layout.csc + 2,
-					    0x40040890);
+		if (desc->layout.csc) {
+			atmel_hlcdc_layer_write_cfg(&plane->layer,
+						    desc->layout.csc,
+						    0x00000488);
+			atmel_hlcdc_layer_write_cfg(&plane->layer,
+						    desc->layout.csc + 1,
+						    0x00000648);
+			atmel_hlcdc_layer_write_cfg(&plane->layer,
+						    desc->layout.csc + 2,
+						    0x1EA00480);
+			atmel_hlcdc_layer_write_cfg(&plane->layer,
+						    desc->layout.csc + 3,
+						    0x00001D28);
+			atmel_hlcdc_layer_write_cfg(&plane->layer,
+						    desc->layout.csc + 4,
+						    0x08100480);
+			atmel_hlcdc_layer_write_cfg(&plane->layer,
+						    desc->layout.csc + 5,
+						    0x00000000);
+			atmel_hlcdc_layer_write_cfg(&plane->layer,
+						    desc->layout.csc + 6,
+						    0x00000007);
+		}
 	}
 
 	return 0;
@@ -819,19 +970,31 @@ void atmel_hlcdc_plane_irq(struct atmel_hlcdc_plane *plane)
 {
 	const struct atmel_hlcdc_layer_desc *desc = plane->layer.desc;
 	u32 isr;
+	struct atmel_hlcdc_dc *dc = plane->base.dev->dev_private;
 
-	isr = atmel_hlcdc_layer_read_reg(&plane->layer, ATMEL_HLCDC_LAYER_ISR);
+	if (!(dc->is_xlcdc))
+		isr = atmel_hlcdc_layer_read_reg(&plane->layer, ATMEL_HLCDC_LAYER_ISR);
+	else
+		isr = atmel_hlcdc_layer_read_reg(&plane->layer, ATMEL_XLCDC_LAYER_ISR);
 
 	/*
 	 * There's not much we can do in case of overrun except informing
 	 * the user. However, we are in interrupt context here, hence the
 	 * use of dev_dbg().
 	 */
-	if (isr &
-	    (ATMEL_HLCDC_LAYER_OVR_IRQ(0) | ATMEL_HLCDC_LAYER_OVR_IRQ(1) |
-	     ATMEL_HLCDC_LAYER_OVR_IRQ(2)))
-		dev_dbg(plane->base.dev->dev, "overrun on plane %s\n",
-			desc->name);
+	if (!(dc->is_xlcdc)) {
+		if (isr &
+		    (ATMEL_HLCDC_LAYER_OVR_IRQ(0) | ATMEL_HLCDC_LAYER_OVR_IRQ(1) |
+		     ATMEL_HLCDC_LAYER_OVR_IRQ(2)))
+			dev_dbg(plane->base.dev->dev, "overrun on plane %s\n",
+				desc->name);
+	} else {
+		if (isr &
+		    (ATMEL_XLCDC_LAYER_OVR_IRQ(0) | ATMEL_XLCDC_LAYER_OVR_IRQ(1) |
+		     ATMEL_XLCDC_LAYER_OVR_IRQ(2)))
+			dev_dbg(plane->base.dev->dev, "overrun on plane %s\n",
+				desc->name);
+	}
 }
 
 static const struct drm_plane_helper_funcs atmel_hlcdc_layer_plane_helper_funcs = {
-- 
2.25.1


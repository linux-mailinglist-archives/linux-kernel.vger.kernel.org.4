Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C3774FD3B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 04:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjGLCm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 22:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGLCmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 22:42:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CFB1991;
        Tue, 11 Jul 2023 19:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689129720; x=1720665720;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pHxkiGzF9VPXSQvgp2n2DJMy1QJNtdMeN99YBfrrG0w=;
  b=cMPCnMlYNgQs+rG5P5kFuBJr2A34u2MlYsQtDQMEim8PgePldiT05Bwb
   aGu/YJbnzbUBw/v0dCQQHhLQn03px1l96e73xExtRuj5KnOjdjriN9fND
   fvdGjbK7xPCHbYyBYxgSrzmEtMlqi6UB3qKw24LooHnBygiV11hRFgpJW
   2KlBe5ldbGV+QME7K79QXjsslZGQxE5owgoSsgO/ppC2nnSRpv/OfJY+H
   i+PciPvnNGyUrTyLOj/UB6WD7W3rwypFEjfKlZGGhwNsKXlqprd852Iql
   G5qWQhAJHKSHkaIEVQv8YOD5QFPVmVa/vnnWAR14yJs8tvFrFLeln0u2W
   w==;
X-IronPort-AV: E=Sophos;i="6.01,198,1684825200"; 
   d="scan'208";a="219936201"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jul 2023 19:41:53 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 11 Jul 2023 19:41:45 -0700
Received: from che-lt-i67131.amer.actel.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Tue, 11 Jul 2023 19:41:36 -0700
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
        Manikandan Muralidharan <manikandan.m@microchip.com>,
        Durai Manickam KR <durai.manickamkr@microchip.com>
Subject: [PATCH v2 7/9] drm: atmel-hlcdc: add DPI mode support for XLCDC
Date:   Wed, 12 Jul 2023 08:10:15 +0530
Message-ID: <20230712024017.218921-8-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230712024017.218921-1-manikandan.m@microchip.com>
References: <20230712024017.218921-1-manikandan.m@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Display Pixel Interface (DPI) Compatible Mode
support in atmel-hlcdc driver for XLCDC IP along with legacy
pixel mapping.DPI mode BIT is configured in LCDC_CFG5 register.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
[durai.manickamkr@microchip.com: update DPI mode bit using is_xlcdc flag]
Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
---
 .../gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c    | 22 ++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
index 27f86cea8bff..c0a1d2d31ed2 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -30,10 +30,12 @@
  *
  * @base: base CRTC state
  * @output_mode: RGBXXX output mode
+ * @dpi: output DPI mode
  */
 struct atmel_hlcdc_crtc_state {
 	struct drm_crtc_state base;
 	unsigned int output_mode;
+	bool dpi;
 };
 
 static inline struct atmel_hlcdc_crtc_state *
@@ -138,6 +140,8 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
 
 	state = drm_crtc_state_to_atmel_hlcdc_crtc_state(c->state);
 	cfg = state->output_mode << 8;
+	if (crtc->dc->desc->is_xlcdc)
+		cfg |= state->dpi << 11;
 
 	if (!crtc->dc->desc->is_xlcdc && (adj->flags & DRM_MODE_FLAG_NVSYNC))
 		cfg |= ATMEL_HLCDC_VSPOL;
@@ -150,7 +154,9 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
 			   ATMEL_HLCDC_VSPDLYS | ATMEL_HLCDC_VSPDLYE |
 			   ATMEL_HLCDC_DISPPOL | ATMEL_HLCDC_DISPDLY |
 			   ATMEL_HLCDC_VSPSU | ATMEL_HLCDC_VSPHO |
-			   ATMEL_HLCDC_GUARDTIME_MASK | ATMEL_HLCDC_MODE_MASK,
+			   ATMEL_HLCDC_GUARDTIME_MASK |
+			   (crtc->dc->desc->is_xlcdc ? ATMEL_XLCDC_MODE_MASK |
+			   ATMEL_XLCDC_DPI : ATMEL_HLCDC_MODE_MASK),
 			   cfg);
 
 	clk_disable_unprepare(crtc->dc->hlcdc->sys_clk);
@@ -348,7 +354,15 @@ static int atmel_hlcdc_crtc_select_output_mode(struct drm_crtc_state *state)
 
 	hstate = drm_crtc_state_to_atmel_hlcdc_crtc_state(state);
 	hstate->output_mode = fls(output_fmts) - 1;
-
+	if (crtc->dc->desc->is_xlcdc) {
+		/* check if MIPI DPI bit needs to be set */
+		if (fls(output_fmts) > 3) {
+			hstate->output_mode -= 4;
+			hstate->dpi = true;
+		} else {
+			hstate->dpi = false;
+		}
+	}
 	return 0;
 }
 
@@ -452,7 +466,7 @@ static struct drm_crtc_state *
 atmel_hlcdc_crtc_duplicate_state(struct drm_crtc *crtc)
 {
 	struct atmel_hlcdc_crtc_state *state, *cur;
-
+	struct atmel_hlcdc_crtc *c = drm_crtc_to_atmel_hlcdc_crtc(crtc);
 	if (WARN_ON(!crtc->state))
 		return NULL;
 
@@ -463,6 +477,8 @@ atmel_hlcdc_crtc_duplicate_state(struct drm_crtc *crtc)
 
 	cur = drm_crtc_state_to_atmel_hlcdc_crtc_state(crtc->state);
 	state->output_mode = cur->output_mode;
+	if (c->dc->desc->is_xlcdc)
+		state->dpi = cur->dpi;
 
 	return &state->base;
 }
-- 
2.25.1


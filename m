Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5480972DA70
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 09:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240345AbjFMHHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 03:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240522AbjFMHHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 03:07:03 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5A6199C;
        Tue, 13 Jun 2023 00:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686639986; x=1718175986;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f2qQAm0UZf7UtrFx6oR5NwKNYKB3AFkXaIrdgsAp/kA=;
  b=njZ3YTL86B9lkaZeb41rqtSBaa8yEUXBE4JJklV3ww/slAbSyRrr0UYA
   xJZXtB0Eu5dgI0pUMiUPc92b4kywhgU+WOmH4YZx08iDVQBjjnaHntLIM
   f32WGluIYXGtMuqd0MoGVASEQvbruU1O3kF174QGfxkpe7bcqHUkYCJPE
   hMGvpDTBogpRXh8FEbyXC6lVminhbYG1GVGgzCP73s7siY7ELWWM8mprC
   ESatUnLrGIYyP8hU/JhiBbfMsFWkl5MiiPACozCSRu7xH+wZ9UIpqOLf9
   El5eUUc/1yiGPu2ua6IskpxcZcZEvDRWlc4ReH23PyOw9692PiJdnFyRW
   w==;
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="217554200"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jun 2023 00:06:24 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 13 Jun 2023 00:06:23 -0700
Received: from che-lt-i67131.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Tue, 13 Jun 2023 00:06:15 -0700
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
Subject: [PATCH 9/9] drm: atmel-hlcdc: add support for DSI output formats
Date:   Tue, 13 Jun 2023 12:34:26 +0530
Message-ID: <20230613070426.467389-10-manikandan.m@microchip.com>
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

Add support for the following DPI mode if the encoder type
is DSI as per the XLCDC IP datasheet:
- 16BPPCFG1
- 16BPPCFG2
- 16BPPCFG3
- 18BPPCFG1
- 18BPPCFG2
- 24BPP

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
[durai.manickamkr@microchip.com: update output format using is_xlcdc flag]
Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
---
 .../gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c    | 117 +++++++++++++-----
 1 file changed, 86 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
index abdece982507..dc8361ebf05b 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -265,11 +265,18 @@ static void atmel_hlcdc_crtc_atomic_enable(struct drm_crtc *c,
 
 }
 
-#define ATMEL_HLCDC_RGB444_OUTPUT	BIT(0)
-#define ATMEL_HLCDC_RGB565_OUTPUT	BIT(1)
-#define ATMEL_HLCDC_RGB666_OUTPUT	BIT(2)
-#define ATMEL_HLCDC_RGB888_OUTPUT	BIT(3)
-#define ATMEL_HLCDC_OUTPUT_MODE_MASK	GENMASK(3, 0)
+#define ATMEL_HLCDC_RGB444_OUTPUT		BIT(0)
+#define ATMEL_HLCDC_RGB565_OUTPUT		BIT(1)
+#define ATMEL_HLCDC_RGB666_OUTPUT		BIT(2)
+#define ATMEL_HLCDC_RGB888_OUTPUT		BIT(3)
+#define ATMEL_HLCDC_DPI_RGB565C1_OUTPUT		BIT(4)
+#define ATMEL_HLCDC_DPI_RGB565C2_OUTPUT		BIT(5)
+#define ATMEL_HLCDC_DPI_RGB565C3_OUTPUT		BIT(6)
+#define ATMEL_HLCDC_DPI_RGB666C1_OUTPUT		BIT(7)
+#define ATMEL_HLCDC_DPI_RGB666C2_OUTPUT		BIT(8)
+#define ATMEL_HLCDC_DPI_RGB888_OUTPUT		BIT(9)
+#define ATMEL_HLCDC_OUTPUT_MODE_MASK		GENMASK(3, 0)
+#define ATMEL_XLCDC_OUTPUT_MODE_MASK		GENMASK(9, 0)
 
 static int atmel_hlcdc_connector_output_mode(struct drm_connector_state *state)
 {
@@ -283,37 +290,83 @@ static int atmel_hlcdc_connector_output_mode(struct drm_connector_state *state)
 	if (!encoder)
 		encoder = connector->encoder;
 
-	switch (atmel_hlcdc_encoder_get_bus_fmt(encoder)) {
-	case 0:
-		break;
-	case MEDIA_BUS_FMT_RGB444_1X12:
-		return ATMEL_HLCDC_RGB444_OUTPUT;
-	case MEDIA_BUS_FMT_RGB565_1X16:
-		return ATMEL_HLCDC_RGB565_OUTPUT;
-	case MEDIA_BUS_FMT_RGB666_1X18:
-		return ATMEL_HLCDC_RGB666_OUTPUT;
-	case MEDIA_BUS_FMT_RGB888_1X24:
-		return ATMEL_HLCDC_RGB888_OUTPUT;
-	default:
-		return -EINVAL;
-	}
-
-	for (j = 0; j < info->num_bus_formats; j++) {
-		switch (info->bus_formats[j]) {
-		case MEDIA_BUS_FMT_RGB444_1X12:
-			supported_fmts |= ATMEL_HLCDC_RGB444_OUTPUT;
+	if (encoder->encoder_type == DRM_MODE_ENCODER_DSI) {
+		/*
+		 * atmel-hlcdc to support DSI formats with DSI video pipeline
+		 * when DRM_MODE_ENCODER_DSI type is set by
+		 * connector driver component.
+		 */
+		switch (atmel_hlcdc_encoder_get_bus_fmt(encoder)) {
+		case 0:
 			break;
 		case MEDIA_BUS_FMT_RGB565_1X16:
-			supported_fmts |= ATMEL_HLCDC_RGB565_OUTPUT;
-			break;
+			return ATMEL_HLCDC_DPI_RGB565C1_OUTPUT;
 		case MEDIA_BUS_FMT_RGB666_1X18:
-			supported_fmts |= ATMEL_HLCDC_RGB666_OUTPUT;
-			break;
+			return ATMEL_HLCDC_DPI_RGB666C1_OUTPUT;
+		case MEDIA_BUS_FMT_RGB666_1X24_CPADHI:
+			return ATMEL_HLCDC_DPI_RGB666C2_OUTPUT;
 		case MEDIA_BUS_FMT_RGB888_1X24:
-			supported_fmts |= ATMEL_HLCDC_RGB888_OUTPUT;
-			break;
+			return ATMEL_HLCDC_DPI_RGB888_OUTPUT;
 		default:
+			return -EINVAL;
+		}
+
+		for (j = 0; j < info->num_bus_formats; j++) {
+			switch (info->bus_formats[j]) {
+			case MEDIA_BUS_FMT_RGB565_1X16:
+				supported_fmts |=
+					ATMEL_HLCDC_DPI_RGB565C1_OUTPUT;
+				break;
+			case MEDIA_BUS_FMT_RGB666_1X18:
+				supported_fmts |=
+					ATMEL_HLCDC_DPI_RGB666C1_OUTPUT;
+				break;
+			case MEDIA_BUS_FMT_RGB666_1X24_CPADHI:
+				supported_fmts |=
+					ATMEL_HLCDC_DPI_RGB666C2_OUTPUT;
+				break;
+			case MEDIA_BUS_FMT_RGB888_1X24:
+				supported_fmts |=
+					ATMEL_HLCDC_DPI_RGB888_OUTPUT;
+				break;
+			default:
+				break;
+			}
+		}
+
+	} else {
+		switch (atmel_hlcdc_encoder_get_bus_fmt(encoder)) {
+		case 0:
 			break;
+		case MEDIA_BUS_FMT_RGB444_1X12:
+			return ATMEL_HLCDC_RGB444_OUTPUT;
+		case MEDIA_BUS_FMT_RGB565_1X16:
+			return ATMEL_HLCDC_RGB565_OUTPUT;
+		case MEDIA_BUS_FMT_RGB666_1X18:
+			return ATMEL_HLCDC_RGB666_OUTPUT;
+		case MEDIA_BUS_FMT_RGB888_1X24:
+			return ATMEL_HLCDC_RGB888_OUTPUT;
+		default:
+			return -EINVAL;
+		}
+
+		for (j = 0; j < info->num_bus_formats; j++) {
+			switch (info->bus_formats[j]) {
+			case MEDIA_BUS_FMT_RGB444_1X12:
+				supported_fmts |= ATMEL_HLCDC_RGB444_OUTPUT;
+				break;
+			case MEDIA_BUS_FMT_RGB565_1X16:
+				supported_fmts |= ATMEL_HLCDC_RGB565_OUTPUT;
+				break;
+			case MEDIA_BUS_FMT_RGB666_1X18:
+				supported_fmts |= ATMEL_HLCDC_RGB666_OUTPUT;
+				break;
+			case MEDIA_BUS_FMT_RGB888_1X24:
+				supported_fmts |= ATMEL_HLCDC_RGB888_OUTPUT;
+				break;
+			default:
+				break;
+			}
 		}
 	}
 
@@ -322,7 +375,7 @@ static int atmel_hlcdc_connector_output_mode(struct drm_connector_state *state)
 
 static int atmel_hlcdc_crtc_select_output_mode(struct drm_crtc_state *state)
 {
-	unsigned int output_fmts = ATMEL_HLCDC_OUTPUT_MODE_MASK;
+	unsigned int output_fmts;
 	struct atmel_hlcdc_crtc_state *hstate;
 	struct drm_connector_state *cstate;
 	struct drm_connector *connector;
@@ -330,6 +383,8 @@ static int atmel_hlcdc_crtc_select_output_mode(struct drm_crtc_state *state)
 	int i;
 
 	crtc = drm_crtc_to_atmel_hlcdc_crtc(state->crtc);
+	output_fmts = crtc->dc->is_xlcdc ? ATMEL_XLCDC_OUTPUT_MODE_MASK :
+		      ATMEL_HLCDC_OUTPUT_MODE_MASK;
 
 	for_each_new_connector_in_state(state->state, connector, cstate, i) {
 		unsigned int supported_fmts = 0;
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3690D72DA6E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 09:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240436AbjFMHH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 03:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240424AbjFMHG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 03:06:58 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B081985;
        Tue, 13 Jun 2023 00:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686639979; x=1718175979;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NtZ1w67xZL59awaoTi+PT78oJSyEe138AbnOfIJ/pYE=;
  b=vdUibDuRWk/PHROamlm0fMa5/mERNIgi3kwTbT47CimZDXEGHH6MQOZh
   pDKMNbdoazSZ+HFCZVtkqm3wqYecOCRehK+Ulx8HwGmkJp4/QLtu52J9R
   VuLHD72HUiGMB0J8i3kXohiHJyBUiDwwMMRDxZ/xBFXo9y3y+peSM2xpt
   BS1TfkznVw2hraTLqnobqGH1kBWopNC53UzXp78vVqmlI7HjAnHqfB0E5
   efATYzI730SZXOD9DqOicXxTS+mDr1H5jwrKUcbtz0QkqBpOIiMjWmPmZ
   PqL7dmdb2Yfmug573YJOZ76Im2e+LkyCjJHtZKQUQkE6FBslSzIuezsJv
   g==;
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="229806934"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jun 2023 00:06:16 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 13 Jun 2023 00:06:14 -0700
Received: from che-lt-i67131.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Tue, 13 Jun 2023 00:06:06 -0700
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
        Manikandan <manikandan.m@microchip.com>
Subject: [PATCH 8/9] drm: atmel-hlcdc: add vertical and horizontal scaling support for XLCDC
Date:   Tue, 13 Jun 2023 12:34:25 +0530
Message-ID: <20230613070426.467389-9-manikandan.m@microchip.com>
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

update the LCDC_HEOCFG30 and LCDC_HEOCFG31 registers of XLCDC IP which
supports vertical and horizontal scaling with Bilinear and Bicubic
co-efficients taps for Chroma and Luma componenets of the Pixel.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c   |  2 ++
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h   |  4 ++++
 .../gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c    | 18 ++++++++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
index fbbd2592efc7..8fcaa4023155 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
@@ -536,6 +536,8 @@ static const struct atmel_hlcdc_layer_desc atmel_xlcdc_sam9x7_layers[] = {
 			.general_config = 12,
 			.csc = 16,
 			.scaler_config = 23,
+			.vxs_config = 30,
+			.hxs_config = 31,
 		},
 		.clut_offset = 0x1300,
 	},
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
index 804e4d476f2b..9aedfd0f6039 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
@@ -264,6 +264,8 @@
  * @disc_pos: discard area position register
  * @disc_size: discard area size register
  * @csc: color space conversion register
+ * @vxs_config: vertical scalar filter taps control register
+ * @hxs_config: horizontal scalar filter taps control register
  */
 struct atmel_hlcdc_layer_cfg_layout {
 	int xstride[ATMEL_HLCDC_LAYER_MAX_PLANES];
@@ -283,6 +285,8 @@ struct atmel_hlcdc_layer_cfg_layout {
 	int disc_pos;
 	int disc_size;
 	int csc;
+	int vxs_config;
+	int hxs_config;
 };
 
 /**
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
index fe33476818c4..613382baa553 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
@@ -961,6 +961,24 @@ static int atmel_hlcdc_plane_init_properties(struct atmel_hlcdc_plane *plane)
 						    desc->layout.csc + 6,
 						    0x00000007);
 		}
+		if (desc->layout.vxs_config && desc->layout.hxs_config) {
+			/*
+			 * Updating vxs.config and hxs.config fixes the
+			 * Green Color Issue in SAM9X7 EGT Video Player App
+			 */
+			atmel_hlcdc_layer_write_cfg(&plane->layer,
+						    desc->layout.vxs_config,
+						    ATMEL_XLCDC_LAYER_VXSYCFG_ONE |
+						    ATMEL_XLCDC_LAYER_VXSYTAP2_ENABLE |
+						    ATMEL_XLCDC_LAYER_VXSCCFG_ONE |
+						    ATMEL_XLCDC_LAYER_VXSCTAP2_ENABLE);
+			atmel_hlcdc_layer_write_cfg(&plane->layer,
+						    desc->layout.hxs_config,
+						    ATMEL_XLCDC_LAYER_HXSYCFG_ONE |
+						    ATMEL_XLCDC_LAYER_HXSYTAP2_ENABLE |
+						    ATMEL_XLCDC_LAYER_HXSCCFG_ONE |
+						    ATMEL_XLCDC_LAYER_HXSCTAP2_ENABLE);
+		}
 	}
 
 	return 0;
-- 
2.25.1


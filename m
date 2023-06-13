Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7A172DA65
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 09:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240446AbjFMHGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 03:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238110AbjFMHFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 03:05:50 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6779410F7;
        Tue, 13 Jun 2023 00:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686639949; x=1718175949;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z7sh0i6Gl2/LRPzmrS845oLG7MhlbMwUzMTImsVh/hI=;
  b=pOOOyITOP1Wtaat6scwATLEe7NwZIWFjfRwM+MMUnoi98/veJMevFg0i
   WaKV0DdwgAgcGCBZlffYU5sDjVv90sgqGko4dg9qabGstxz50kJbq7STy
   Esb81TBwEbC9eczpBgjsPH09j0T+iWoBtVFhsMHNWYqU/TdFYtwSRib5h
   5ltAcalXNbmvUPQyConoo+Su56AtIe4L/1Xm8km2BoFAwhN9NdjENJ5EP
   X8672+7mRpWTjz51xIK0s/p5PW9zveM+kDZ8nc11uLcOZ3zqNuh6pW7Iy
   TWWXwpiX7g1OJo6U91twwsBY+pgmUNjfRYatcdkDKCKrPrd6pXZLp7sRJ
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="229806838"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jun 2023 00:05:47 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 13 Jun 2023 00:05:46 -0700
Received: from che-lt-i67131.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Tue, 13 Jun 2023 00:05:38 -0700
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
Subject: [PATCH 5/9] drm: atmel-hlcdc: add compatible string check for XLCDC and HLCDC
Date:   Tue, 13 Jun 2023 12:34:22 +0530
Message-ID: <20230613070426.467389-6-manikandan.m@microchip.com>
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

From: Durai Manickam KR <durai.manickamkr@microchip.com>

Add compatible string check to differentiate XLCDC and HLCDC code
within the atmel-hlcdc driver files.

Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 7 +++++++
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
index d7ad828e9e8c..fbbd2592efc7 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
@@ -761,6 +761,13 @@ static int atmel_hlcdc_dc_load(struct drm_device *dev)
 	if (!dc)
 		return -ENOMEM;
 
+	/* SAM9X7 supports XLCDC */
+	if (!strcmp(match->compatible, "microchip,sam9x7-xlcdc"))
+		dc->is_xlcdc = true;
+	else
+		/* Other SoC's that supports HLCDC IP */
+		dc->is_xlcdc = false;
+
 	dc->desc = match->data;
 	dc->hlcdc = dev_get_drvdata(dev->dev->parent);
 	dev->dev_private = dc;
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
index aed1742b3665..804e4d476f2b 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
@@ -451,6 +451,7 @@ struct atmel_hlcdc_dc {
 		u32 imr;
 		struct drm_atomic_state *state;
 	} suspend;
+	bool is_xlcdc;
 };
 
 extern struct atmel_hlcdc_formats atmel_hlcdc_plane_rgb_formats;
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E99F632F58
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 22:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbiKUVui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 16:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbiKUVuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 16:50:07 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B33DB85E;
        Mon, 21 Nov 2022 13:50:06 -0800 (PST)
Received: from umang.jainideasonboard.com (unknown [103.86.18.138])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DA9C2E61;
        Mon, 21 Nov 2022 22:50:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1669067405;
        bh=oSxZ1uW81ySYSzLce6c6BF+DwUMI/z4Wsarl5TIz+i4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vPgU8M8OY314oDDivcL/h5E3oyv9hwoE+J369HMhl64dvtSEOSu7TQe9PMwGYQdJD
         KyqknS4lEzzjGIsiqRIGphc96v9sSwDArbblLReH36A4eZ3r62iggVgQqmunm3Ugki
         Dk2jHJO4saPsIDHP8IBFwZAnnCsBsS0a2idofNAQ=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     linux-media@vger.kernel.org, kernel-list@raspberrypi.com,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Naushir Patuck <naush@raspberrypi.com>,
        David Plowman <david.plowman@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH 11/14] WIP: vc04_services: bcm2835-isp: Permit all sRGB colour spaces on ISP outputs
Date:   Tue, 22 Nov 2022 03:17:19 +0530
Message-Id: <20221121214722.22563-12-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221121214722.22563-1-umang.jain@ideasonboard.com>
References: <20221121214722.22563-1-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Plowman <david.plowman@raspberrypi.com>

bcm2835-isp outputs actually support all colour spaces that are
fundamentally sRGB underneath, regardless of whether an RGB or YUV output
format is actually requested.

Signed-off-by: David Plowman <david.plowman@raspberrypi.com>
Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../bcm2835-isp/bcm2835-isp-fmts.h            | 45 ++++++++++---------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-isp/bcm2835-isp-fmts.h b/drivers/staging/vc04_services/bcm2835-isp/bcm2835-isp-fmts.h
index a545dbf2b5dd..5ab232ff9bd9 100644
--- a/drivers/staging/vc04_services/bcm2835-isp/bcm2835-isp-fmts.h
+++ b/drivers/staging/vc04_services/bcm2835-isp/bcm2835-isp-fmts.h
@@ -34,14 +34,19 @@ struct bcm2835_isp_fmt {
 #define V4L2_COLORSPACE_MASK_RAW V4L2_COLORSPACE_MASK(V4L2_COLORSPACE_RAW)
 
 /*
- * The colour spaces we support for YUV outputs. SRGB features here because,
- * once you assign the default transfer func and so on, it and JPEG effectively
- * mean the same.
+ * All three colour spaces JPEG, SMPTE170M and REC709 are fundamentally sRGB
+ * underneath (as near as makes no difference to us), just with different YCbCr
+ * encodings. Therefore the ISP can generate sRGB on its main output and any of
+ * the others on its low resolution output. Applications should, when using both
+ * outputs, program the colour spaces on them to be the same, matching whatever
+ * is requested for the low resolution output, even if the main output is
+ * producing an RGB format. In turn this requires us to allow all these colour
+ * spaces for every YUV/RGB output format.
  */
-#define V4L2_COLORSPACE_MASK_YUV (V4L2_COLORSPACE_MASK_JPEG | \
-				  V4L2_COLORSPACE_MASK_SRGB | \
-				  V4L2_COLORSPACE_MASK_SMPTE170M | \
-				  V4L2_COLORSPACE_MASK_REC709)
+#define V4L2_COLORSPACE_MASK_ALL_SRGB (V4L2_COLORSPACE_MASK_JPEG |	\
+				       V4L2_COLORSPACE_MASK_SRGB |	\
+				       V4L2_COLORSPACE_MASK_SMPTE170M |	\
+				       V4L2_COLORSPACE_MASK_REC709)
 
 static const struct bcm2835_isp_fmt supported_formats[] = {
 	{
@@ -51,7 +56,7 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 64,
 		.mmal_fmt	    = MMAL_ENCODING_I420,
 		.size_multiplier_x2 = 3,
-		.colorspace_mask    = V4L2_COLORSPACE_MASK_YUV,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_ALL_SRGB,
 		.colorspace_default = V4L2_COLORSPACE_JPEG,
 		.step_size	    = 2,
 	}, {
@@ -60,7 +65,7 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 64,
 		.mmal_fmt	    = MMAL_ENCODING_YV12,
 		.size_multiplier_x2 = 3,
-		.colorspace_mask    = V4L2_COLORSPACE_MASK_YUV,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_ALL_SRGB,
 		.colorspace_default = V4L2_COLORSPACE_SMPTE170M,
 		.step_size	    = 2,
 	}, {
@@ -69,7 +74,7 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_NV12,
 		.size_multiplier_x2 = 3,
-		.colorspace_mask    = V4L2_COLORSPACE_MASK_YUV,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_ALL_SRGB,
 		.colorspace_default = V4L2_COLORSPACE_SMPTE170M,
 		.step_size	    = 2,
 	}, {
@@ -78,7 +83,7 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_NV21,
 		.size_multiplier_x2 = 3,
-		.colorspace_mask    = V4L2_COLORSPACE_MASK_YUV,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_ALL_SRGB,
 		.colorspace_default = V4L2_COLORSPACE_SMPTE170M,
 		.step_size	    = 2,
 	}, {
@@ -87,7 +92,7 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 64,
 		.mmal_fmt	    = MMAL_ENCODING_YUYV,
 		.size_multiplier_x2 = 2,
-		.colorspace_mask    = V4L2_COLORSPACE_MASK_YUV,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_ALL_SRGB,
 		.colorspace_default = V4L2_COLORSPACE_SMPTE170M,
 		.step_size	    = 2,
 	}, {
@@ -96,7 +101,7 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 64,
 		.mmal_fmt	    = MMAL_ENCODING_UYVY,
 		.size_multiplier_x2 = 2,
-		.colorspace_mask    = V4L2_COLORSPACE_MASK_YUV,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_ALL_SRGB,
 		.colorspace_default = V4L2_COLORSPACE_SMPTE170M,
 		.step_size	    = 2,
 	}, {
@@ -105,7 +110,7 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 64,
 		.mmal_fmt	    = MMAL_ENCODING_YVYU,
 		.size_multiplier_x2 = 2,
-		.colorspace_mask    = V4L2_COLORSPACE_MASK_YUV,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_ALL_SRGB,
 		.colorspace_default = V4L2_COLORSPACE_SMPTE170M,
 		.step_size	    = 2,
 	}, {
@@ -114,7 +119,7 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 64,
 		.mmal_fmt	    = MMAL_ENCODING_VYUY,
 		.size_multiplier_x2 = 2,
-		.colorspace_mask    = V4L2_COLORSPACE_MASK_YUV,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_ALL_SRGB,
 		.colorspace_default = V4L2_COLORSPACE_SMPTE170M,
 		.step_size	    = 2,
 	}, {
@@ -124,7 +129,7 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_RGB24,
 		.size_multiplier_x2 = 2,
-		.colorspace_mask    = V4L2_COLORSPACE_MASK_SRGB,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_ALL_SRGB,
 		.colorspace_default = V4L2_COLORSPACE_SRGB,
 		.step_size	    = 1,
 	}, {
@@ -133,7 +138,7 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_RGB16,
 		.size_multiplier_x2 = 2,
-		.colorspace_mask    = V4L2_COLORSPACE_MASK_SRGB,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_ALL_SRGB,
 		.colorspace_default = V4L2_COLORSPACE_SRGB,
 		.step_size	    = 1,
 	}, {
@@ -142,7 +147,7 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_BGR24,
 		.size_multiplier_x2 = 2,
-		.colorspace_mask    = V4L2_COLORSPACE_MASK_SRGB,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_ALL_SRGB,
 		.colorspace_default = V4L2_COLORSPACE_SRGB,
 		.step_size	    = 1,
 	}, {
@@ -151,7 +156,7 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 64,
 		.mmal_fmt	    = MMAL_ENCODING_BGRA,
 		.size_multiplier_x2 = 2,
-		.colorspace_mask    = V4L2_COLORSPACE_MASK_SRGB,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_ALL_SRGB,
 		.colorspace_default = V4L2_COLORSPACE_SRGB,
 		.step_size	    = 1,
 	}, {
@@ -160,7 +165,7 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 64,
 		.mmal_fmt	    = MMAL_ENCODING_RGBA,
 		.size_multiplier_x2 = 2,
-		.colorspace_mask    = V4L2_COLORSPACE_MASK_SRGB,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_ALL_SRGB,
 		.colorspace_default = V4L2_COLORSPACE_SRGB,
 		.step_size	    = 1,
 	}, {
-- 
2.37.3


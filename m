Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC8E6C80DB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 16:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbjCXPNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 11:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbjCXPNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 11:13:09 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BC81ABCF;
        Fri, 24 Mar 2023 08:12:49 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5BE5EE000A;
        Fri, 24 Mar 2023 15:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1679670768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qIH2xOa232Fh48wwCufBRlgNNrR+ve7uu9Q9Dipak/I=;
        b=RxOthW9u+Vl0zGq8JoSMX6HQFR1X25CEf9s1nVTPrvCV2/e5Gw8o030kbApFZKm31/MCoS
        6GBEYnTar7QpOCpMMqcqv6EWrnfpEi3+X7lD528EH7XtAf91Xti+Bp0422oYW6A6I3HQM+
        1t8DUnc7vY2+/bZZyDs66DALDYGPlzXP9JOdZkZeQmVar/TOe7ieR12QXiTQLeEHJdbnJ5
        31IdRnNUA232yEWtpEgxGIpO3tstJvL3bBfT8YUvfcNEOufYhufkvKJafYHdSxl522Rp70
        Cud4OLUX9hwKkPZs7L7XOfCm3VKiZ4f8TZnz8FL7z70JeNzn6quDGAvSxFQebg==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Adam Pigg <adam@piggz.co.uk>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 5/9] media: sun6i-csi: capture: Rework and separate format validation
Date:   Fri, 24 Mar 2023 16:12:24 +0100
Message-Id: <20230324151228.2778112-6-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230324151228.2778112-1-paul.kocialkowski@bootlin.com>
References: <20230324151228.2778112-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a new sun6i_csi_capture_format_check helper to indicate
whether a set of pixel format and mbus code are compatible.
Most of the logic is taken from sun6i_csi_capture_link_validate,
with extra checks added along the way.

Note that v4l2_format_info is now used for all pixel formats
since they should all be listed in the helper at this point.

The motivation behind this change is to pave the way for supporting
the mc-style enum_fmt.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 .../sunxi/sun6i-csi/sun6i_csi_capture.c       | 95 ++++++++++---------
 1 file changed, 49 insertions(+), 46 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
index cf6aadbc130b..6ce7f1d3ed57 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
@@ -327,6 +327,52 @@ static bool sun6i_csi_capture_format_match(u32 pixelformat, u32 mbus_code)
 	return false;
 }
 
+static bool sun6i_csi_capture_format_check(u32 pixelformat, u32 mbus_code)
+{
+	const struct sun6i_csi_capture_format *capture_format;
+	const struct sun6i_csi_bridge_format *bridge_format;
+	const struct v4l2_format_info *format_info;
+
+	format_info = v4l2_format_info(pixelformat);
+	if (WARN_ON(!format_info))
+		return false;
+
+	capture_format = sun6i_csi_capture_format_find(pixelformat);
+	if (WARN_ON(!capture_format))
+		return false;
+
+	bridge_format = sun6i_csi_bridge_format_find(mbus_code);
+	if (WARN_ON(!bridge_format))
+		return false;
+
+	/* Raw input is required for non-YUV formats. */
+	if (bridge_format->input_format != SUN6I_CSI_INPUT_FMT_RAW &&
+	    (format_info->pixel_enc == V4L2_PIXEL_ENC_BAYER ||
+	     format_info->pixel_enc == V4L2_PIXEL_ENC_RGB ||
+	     format_info->pixel_enc == V4L2_PIXEL_ENC_COMPRESSED))
+		return false;
+
+	if (format_info->pixel_enc == V4L2_PIXEL_ENC_YUV) {
+		/* YUV input is required for YUV pixels. */
+		if (bridge_format->input_format != SUN6I_CSI_INPUT_FMT_YUV420 &&
+		    bridge_format->input_format != SUN6I_CSI_INPUT_FMT_YUV422)
+			return false;
+
+		/* YUV420 input can't produce (upsampled) YUV422 output. */
+		if (bridge_format->input_format == SUN6I_CSI_INPUT_FMT_YUV420 &&
+		    format_info->vdiv == 1)
+			return false;
+	}
+
+	/* Raw input requires a 1:1 match between input and output. */
+	if ((bridge_format->input_format == SUN6I_CSI_INPUT_FMT_RAW ||
+	     capture_format->input_format_raw) &&
+	    !sun6i_csi_capture_format_match(pixelformat, mbus_code))
+			return false;
+
+	return true;
+}
+
 /* Capture */
 
 static void
@@ -890,28 +936,16 @@ static int sun6i_csi_capture_link_validate(struct media_link *link)
 		media_entity_to_video_device(link->sink->entity);
 	struct sun6i_csi_device *csi_dev = video_get_drvdata(video_dev);
 	struct v4l2_device *v4l2_dev = csi_dev->v4l2_dev;
-	const struct sun6i_csi_capture_format *capture_format;
-	const struct sun6i_csi_bridge_format *bridge_format;
 	unsigned int capture_width, capture_height;
 	unsigned int bridge_width, bridge_height;
-	const struct v4l2_format_info *format_info;
 	u32 pixelformat, capture_field;
 	u32 mbus_code, bridge_field;
-	bool match;
 
 	sun6i_csi_capture_dimensions(csi_dev, &capture_width, &capture_height);
-
 	sun6i_csi_capture_format(csi_dev, &pixelformat, &capture_field);
-	capture_format = sun6i_csi_capture_format_find(pixelformat);
-	if (WARN_ON(!capture_format))
-		return -EINVAL;
 
 	sun6i_csi_bridge_dimensions(csi_dev, &bridge_width, &bridge_height);
-
 	sun6i_csi_bridge_format(csi_dev, &mbus_code, &bridge_field);
-	bridge_format = sun6i_csi_bridge_format_find(mbus_code);
-	if (WARN_ON(!bridge_format))
-		return -EINVAL;
 
 	/* No cropping/scaling is supported. */
 	if (capture_width != bridge_width || capture_height != bridge_height) {
@@ -922,43 +956,12 @@ static int sun6i_csi_capture_link_validate(struct media_link *link)
 		return -EINVAL;
 	}
 
-	format_info = v4l2_format_info(pixelformat);
-	/* Some formats are not listed. */
-	if (!format_info)
-		return 0;
-
-	if (format_info->pixel_enc == V4L2_PIXEL_ENC_BAYER &&
-	    bridge_format->input_format != SUN6I_CSI_INPUT_FMT_RAW)
-		goto invalid;
-
-	if (format_info->pixel_enc == V4L2_PIXEL_ENC_RGB &&
-	    bridge_format->input_format != SUN6I_CSI_INPUT_FMT_RAW)
-		goto invalid;
-
-	if (format_info->pixel_enc == V4L2_PIXEL_ENC_YUV) {
-		if (bridge_format->input_format != SUN6I_CSI_INPUT_FMT_YUV420 &&
-		    bridge_format->input_format != SUN6I_CSI_INPUT_FMT_YUV422)
-			goto invalid;
-
-		/* YUV420 input can't produce YUV422 output. */
-		if (bridge_format->input_format == SUN6I_CSI_INPUT_FMT_YUV420 &&
-		    format_info->vdiv == 1)
-			goto invalid;
-	}
-
-	/* With raw input mode, we need a 1:1 match between input and output. */
-	if (bridge_format->input_format == SUN6I_CSI_INPUT_FMT_RAW ||
-	    capture_format->input_format_raw) {
-		match = sun6i_csi_capture_format_match(pixelformat, mbus_code);
-		if (!match)
-			goto invalid;
+	if (!sun6i_csi_capture_format_check(pixelformat, mbus_code)) {
+		v4l2_err(v4l2_dev, "invalid input/output format combination\n");
+		return -EINVAL;
 	}
 
 	return 0;
-
-invalid:
-	v4l2_err(v4l2_dev, "invalid input/output format combination\n");
-	return -EINVAL;
 }
 
 static const struct media_entity_operations sun6i_csi_capture_media_ops = {
-- 
2.39.2


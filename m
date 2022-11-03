Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B438F6184B1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 17:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbiKCQdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 12:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbiKCQcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 12:32:08 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3A5BD5;
        Thu,  3 Nov 2022 09:32:06 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B1E79240009;
        Thu,  3 Nov 2022 16:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667493125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MUvp2LuOY3r52n5qy09+HncB5/IlXf9GebzCmprIOIs=;
        b=g6EB49SdiZJ4sCE9UpAZKg7hjcucNA4Cc5hOEyR4Hy99350iS46SGcJzcxRXagkc5FmYim
        sOMazCE0m9hiPKXQqSpd/cc4KuMMl4L5mJs1BNBQWzcIlzGb1ITsxMkh1nkFvc4/AfMwhI
        ootjfmiUihbb2GGp3idR2b6orPOmUl7AovcDFrwxRDYwvM3lmLkGTZwlGsrNpZg/4bz5fq
        K1L9v6NfW1wlM/ZsLzfCxI5VIwRkXUD/JVIilMGPv+8S4xStM100gQvHQHNBuC16Sbk327
        SGA/UlSH/t3fgn58BbRMr3T7o0Sh0KWbc1cGmPPh+Li8iFUQytNzGmDe2B4Glw==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Cc:     Yong Deng <yong.deng@magewell.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v7 18/28] media: sun6i-csi: Introduce format match structure, list and helper
Date:   Thu,  3 Nov 2022 17:31:03 +0100
Message-Id: <20221103163113.245462-19-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221103163113.245462-1-paul.kocialkowski@bootlin.com>
References: <20221103163113.245462-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a list of mbus/pixel format combinations that need an exact
match between the two sides. This is the case when using raw input
configuration. The list will be used to replace the
sun6i_csi_is_format_supported combinatory helper.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../sunxi/sun6i-csi/sun6i_csi_capture.c       | 117 ++++++++++++++++++
 .../sunxi/sun6i-csi/sun6i_csi_capture.h       |   5 +
 2 files changed, 122 insertions(+)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
index 99b821d79357..7958419d3c6e 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
@@ -227,6 +227,123 @@ struct sun6i_csi_capture_format *sun6i_csi_capture_format_find(u32 pixelformat)
 	return NULL;
 }
 
+/* RAW formats need an exact match between pixel and mbus formats. */
+static const
+struct sun6i_csi_capture_format_match sun6i_csi_capture_format_matches[] = {
+	/* YUV420 */
+	{
+		.pixelformat	= V4L2_PIX_FMT_YUYV,
+		.mbus_code	= MEDIA_BUS_FMT_YUYV8_2X8,
+	},
+	{
+		.pixelformat	= V4L2_PIX_FMT_YUYV,
+		.mbus_code	= MEDIA_BUS_FMT_YUYV8_1X16,
+	},
+	{
+		.pixelformat	= V4L2_PIX_FMT_YVYU,
+		.mbus_code	= MEDIA_BUS_FMT_YVYU8_2X8,
+	},
+	{
+		.pixelformat	= V4L2_PIX_FMT_YVYU,
+		.mbus_code	= MEDIA_BUS_FMT_YVYU8_1X16,
+	},
+	{
+		.pixelformat	= V4L2_PIX_FMT_UYVY,
+		.mbus_code	= MEDIA_BUS_FMT_UYVY8_2X8,
+	},
+	{
+		.pixelformat	= V4L2_PIX_FMT_UYVY,
+		.mbus_code	= MEDIA_BUS_FMT_UYVY8_1X16,
+	},
+	{
+		.pixelformat	= V4L2_PIX_FMT_VYUY,
+		.mbus_code	= MEDIA_BUS_FMT_VYUY8_2X8,
+	},
+	{
+		.pixelformat	= V4L2_PIX_FMT_VYUY,
+		.mbus_code	= MEDIA_BUS_FMT_VYUY8_1X16,
+	},
+	/* RGB */
+	{
+		.pixelformat	= V4L2_PIX_FMT_RGB565,
+		.mbus_code	= MEDIA_BUS_FMT_RGB565_2X8_LE,
+	},
+	{
+		.pixelformat	= V4L2_PIX_FMT_RGB565X,
+		.mbus_code	= MEDIA_BUS_FMT_RGB565_2X8_BE,
+	},
+	/* Bayer */
+	{
+		.pixelformat	= V4L2_PIX_FMT_SBGGR8,
+		.mbus_code	= MEDIA_BUS_FMT_SBGGR8_1X8,
+	},
+	{
+		.pixelformat	= V4L2_PIX_FMT_SGBRG8,
+		.mbus_code	= MEDIA_BUS_FMT_SGBRG8_1X8,
+	},
+	{
+		.pixelformat	= V4L2_PIX_FMT_SGRBG8,
+		.mbus_code	= MEDIA_BUS_FMT_SGRBG8_1X8,
+	},
+	{
+		.pixelformat	= V4L2_PIX_FMT_SRGGB8,
+		.mbus_code	= MEDIA_BUS_FMT_SRGGB8_1X8,
+	},
+	{
+		.pixelformat	= V4L2_PIX_FMT_SBGGR10,
+		.mbus_code	= MEDIA_BUS_FMT_SBGGR10_1X10,
+	},
+	{
+		.pixelformat	= V4L2_PIX_FMT_SGBRG10,
+		.mbus_code	= MEDIA_BUS_FMT_SGBRG10_1X10,
+	},
+	{
+		.pixelformat	= V4L2_PIX_FMT_SGRBG10,
+		.mbus_code	= MEDIA_BUS_FMT_SGRBG10_1X10,
+	},
+	{
+		.pixelformat	= V4L2_PIX_FMT_SRGGB10,
+		.mbus_code	= MEDIA_BUS_FMT_SRGGB10_1X10,
+	},
+	{
+		.pixelformat	= V4L2_PIX_FMT_SBGGR12,
+		.mbus_code	= MEDIA_BUS_FMT_SBGGR12_1X12,
+	},
+	{
+		.pixelformat	= V4L2_PIX_FMT_SGBRG12,
+		.mbus_code	= MEDIA_BUS_FMT_SGBRG12_1X12,
+	},
+	{
+		.pixelformat	= V4L2_PIX_FMT_SGRBG12,
+		.mbus_code	= MEDIA_BUS_FMT_SGRBG12_1X12,
+	},
+	{
+		.pixelformat	= V4L2_PIX_FMT_SRGGB12,
+		.mbus_code	= MEDIA_BUS_FMT_SRGGB12_1X12,
+	},
+	/* Compressed */
+	{
+		.pixelformat	= V4L2_PIX_FMT_JPEG,
+		.mbus_code	= MEDIA_BUS_FMT_JPEG_1X8,
+	},
+};
+
+static bool sun6i_csi_capture_format_match(u32 pixelformat, u32 mbus_code)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(sun6i_csi_capture_format_matches); i++) {
+		const struct sun6i_csi_capture_format_match *match =
+			&sun6i_csi_capture_format_matches[i];
+
+		if (match->pixelformat == pixelformat &&
+		    match->mbus_code == mbus_code)
+			return true;
+	}
+
+	return false;
+}
+
 /* Capture */
 
 static void sun6i_csi_capture_irq_enable(struct sun6i_csi_device *csi_dev)
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
index 4b1ff19edc2f..2605b16f091c 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
@@ -27,6 +27,11 @@ struct sun6i_csi_capture_format {
 	u32	hsize_len_factor;
 };
 
+struct sun6i_csi_capture_format_match {
+	u32	pixelformat;
+	u32	mbus_code;
+};
+
 #undef current
 struct sun6i_csi_capture_state {
 	struct list_head		queue;
-- 
2.38.1


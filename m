Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9607D62EFD2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 09:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241576AbiKRIna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 03:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241527AbiKRInW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 03:43:22 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7938E090
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:43:12 -0800 (PST)
Received: from ideasonboard.com (unknown [103.251.226.79])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B6719AF4;
        Fri, 18 Nov 2022 09:43:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1668760991;
        bh=lVDUJHWVeAyJX4GtZijiGPXUXmMu80hKu+K2BJug9Dg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d79mtO2JYKFu4+5g6P1Cw8PN1KSFyN4AbS1LHvzLnDZ8Ezir5nK8rUbbqXC+2W7X5
         kMrseAbR8vQfD+9vD8WgOA0IL1lXxXBBBLInwGgYHkmBoDA3AS5hdaSZ/dsDazoVqJ
         GEGbT7zSTiWMhAEO4gLVAx5lY7aEJtKU0R2PDd08=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>, Dan Carpenter <error27@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     kieran.bingham@ideasonboard.com,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v2 3/3] vc04_services: bcm2835-camera: Use bool values for mmal_fmt.remove_padding
Date:   Fri, 18 Nov 2022 14:12:44 +0530
Message-Id: <20221118084244.199909-4-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118084244.199909-1-umang.jain@ideasonboard.com>
References: <20221118084244.199909-1-umang.jain@ideasonboard.com>
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

mmal_fmt.remove_padding is defined as a boolean type hence, use boolean
values for it instead of 0/1 integers. This enhances code readability.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../bcm2835-camera/bcm2835-camera.c           | 30 +++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index fd456d1f7061..797ebe2a973a 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -87,21 +87,21 @@ static struct mmal_fmt formats[] = {
 		.depth = 12,
 		.mmal_component = COMP_CAMERA,
 		.ybbp = 1,
-		.remove_padding = 1,
+		.remove_padding = true,
 	}, {
 		.fourcc = V4L2_PIX_FMT_YUYV,
 		.mmal = MMAL_ENCODING_YUYV,
 		.depth = 16,
 		.mmal_component = COMP_CAMERA,
 		.ybbp = 2,
-		.remove_padding = 0,
+		.remove_padding = false,
 	}, {
 		.fourcc = V4L2_PIX_FMT_RGB24,
 		.mmal = MMAL_ENCODING_RGB24,
 		.depth = 24,
 		.mmal_component = COMP_CAMERA,
 		.ybbp = 3,
-		.remove_padding = 0,
+		.remove_padding = false,
 	}, {
 		.fourcc = V4L2_PIX_FMT_JPEG,
 		.flags = V4L2_FMT_FLAG_COMPRESSED,
@@ -109,7 +109,7 @@ static struct mmal_fmt formats[] = {
 		.depth = 8,
 		.mmal_component = COMP_IMAGE_ENCODE,
 		.ybbp = 0,
-		.remove_padding = 0,
+		.remove_padding = false,
 	}, {
 		.fourcc = V4L2_PIX_FMT_H264,
 		.flags = V4L2_FMT_FLAG_COMPRESSED,
@@ -117,7 +117,7 @@ static struct mmal_fmt formats[] = {
 		.depth = 8,
 		.mmal_component = COMP_VIDEO_ENCODE,
 		.ybbp = 0,
-		.remove_padding = 0,
+		.remove_padding = false,
 	}, {
 		.fourcc = V4L2_PIX_FMT_MJPEG,
 		.flags = V4L2_FMT_FLAG_COMPRESSED,
@@ -125,63 +125,63 @@ static struct mmal_fmt formats[] = {
 		.depth = 8,
 		.mmal_component = COMP_VIDEO_ENCODE,
 		.ybbp = 0,
-		.remove_padding = 0,
+		.remove_padding = false,
 	}, {
 		.fourcc = V4L2_PIX_FMT_YVYU,
 		.mmal = MMAL_ENCODING_YVYU,
 		.depth = 16,
 		.mmal_component = COMP_CAMERA,
 		.ybbp = 2,
-		.remove_padding = 0,
+		.remove_padding = false,
 	}, {
 		.fourcc = V4L2_PIX_FMT_VYUY,
 		.mmal = MMAL_ENCODING_VYUY,
 		.depth = 16,
 		.mmal_component = COMP_CAMERA,
 		.ybbp = 2,
-		.remove_padding = 0,
+		.remove_padding = false,
 	}, {
 		.fourcc = V4L2_PIX_FMT_UYVY,
 		.mmal = MMAL_ENCODING_UYVY,
 		.depth = 16,
 		.mmal_component = COMP_CAMERA,
 		.ybbp = 2,
-		.remove_padding = 0,
+		.remove_padding = false,
 	}, {
 		.fourcc = V4L2_PIX_FMT_NV12,
 		.mmal = MMAL_ENCODING_NV12,
 		.depth = 12,
 		.mmal_component = COMP_CAMERA,
 		.ybbp = 1,
-		.remove_padding = 1,
+		.remove_padding = true,
 	}, {
 		.fourcc = V4L2_PIX_FMT_BGR24,
 		.mmal = MMAL_ENCODING_BGR24,
 		.depth = 24,
 		.mmal_component = COMP_CAMERA,
 		.ybbp = 3,
-		.remove_padding = 0,
+		.remove_padding = false,
 	}, {
 		.fourcc = V4L2_PIX_FMT_YVU420,
 		.mmal = MMAL_ENCODING_YV12,
 		.depth = 12,
 		.mmal_component = COMP_CAMERA,
 		.ybbp = 1,
-		.remove_padding = 1,
+		.remove_padding = true,
 	}, {
 		.fourcc = V4L2_PIX_FMT_NV21,
 		.mmal = MMAL_ENCODING_NV21,
 		.depth = 12,
 		.mmal_component = COMP_CAMERA,
 		.ybbp = 1,
-		.remove_padding = 1,
+		.remove_padding = true,
 	}, {
 		.fourcc = V4L2_PIX_FMT_BGR32,
 		.mmal = MMAL_ENCODING_BGRA,
 		.depth = 32,
 		.mmal_component = COMP_CAMERA,
 		.ybbp = 4,
-		.remove_padding = 0,
+		.remove_padding = false,
 	},
 };
 
@@ -1147,7 +1147,7 @@ static int mmal_setup_components(struct bcm2835_mmal_dev *dev,
 	struct vchiq_mmal_port *port = NULL, *camera_port = NULL;
 	struct vchiq_mmal_component *encode_component = NULL;
 	struct mmal_fmt *mfmt = get_format(f);
-	u32 remove_padding;
+	bool remove_padding;
 
 	if (!mfmt)
 		return -EINVAL;
-- 
2.38.1


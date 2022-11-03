Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC096184AD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 17:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbiKCQdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 12:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbiKCQb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 12:31:56 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED6A1C42E;
        Thu,  3 Nov 2022 09:31:54 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D5C91240007;
        Thu,  3 Nov 2022 16:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667493113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tvIBQaf0i8C2sYcFYmnaAWDNZzcIJ0jh5H+nn0t0JKU=;
        b=eOZv65XIZ5YYb0XPujVS3OiC9OTmarlqyKQ65D9oBJ0llHjmRXhJe+Ecx51HLLATAgs4oi
        5PLmLqfo0u5l7fmTto4jlZW9yZvblbVDEWTKKoQmdEh7ifJaJmmDAltlaiGZWRyiU7oHFG
        iOc0RBR9Xor6/mbt7AzY9fPGYr+JPRqYPLt22B8iK4t47OLYNTfrb1aiT8rSOQzGbdZfZi
        Wnxu2eGALfLI/31qoghNGdT0NeQwdzuMg5/g0mBE4twGCWxfQvFZKKT2Hdhw+cE4DwqGoM
        CqkJdqGF7CE00R87hCda24qc2/15cPMZkJVf4sa4dWf5A47icmaeK7mmzmQLtQ==
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
Subject: [PATCH v7 13/28] media: sun6i-csi: Get mbus code from bridge instead of storing it
Date:   Thu,  3 Nov 2022 17:30:58 +0100
Message-Id: <20221103163113.245462-14-paul.kocialkowski@bootlin.com>
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

Another instance of removing a duplicated variable and using common
helpers instead.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../sunxi/sun6i-csi/sun6i_csi_capture.c        | 18 +++++-------------
 .../sunxi/sun6i-csi/sun6i_csi_capture.h        |  1 -
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
index 45b2f4480127..3577a3d747c1 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
@@ -17,6 +17,7 @@
 #include <media/videobuf2-v4l2.h>
 
 #include "sun6i_csi.h"
+#include "sun6i_csi_bridge.h"
 #include "sun6i_csi_capture.h"
 #include "sun6i_csi_reg.h"
 
@@ -455,20 +456,20 @@ sun6i_csi_capture_configure_interface(struct sun6i_csi_device *csi_dev)
 
 static void sun6i_csi_capture_configure_format(struct sun6i_csi_device *csi_dev)
 {
-	struct sun6i_csi_capture *capture = &csi_dev->capture;
-	u32 pixelformat, field;
+	u32 mbus_code, pixelformat, field;
 	u32 cfg = 0;
 	u32 val;
 
 	sun6i_csi_capture_format(csi_dev, &pixelformat, &field);
+	sun6i_csi_bridge_format(csi_dev, &mbus_code, NULL);
 
-	val = get_csi_input_format(csi_dev, capture->mbus_code, pixelformat);
+	val = get_csi_input_format(csi_dev, mbus_code, pixelformat);
 	cfg |= SUN6I_CSI_CH_CFG_INPUT_FMT(val);
 
 	val = get_csi_output_format(csi_dev, pixelformat, field);
 	cfg |= SUN6I_CSI_CH_CFG_OUTPUT_FMT(val);
 
-	val = get_csi_input_seq(csi_dev, capture->mbus_code, pixelformat);
+	val = get_csi_input_seq(csi_dev, mbus_code, pixelformat);
 	cfg |= SUN6I_CSI_CH_CFG_INPUT_YUV_SEQ(val);
 
 	if (field == V4L2_FIELD_TOP)
@@ -739,11 +740,6 @@ static int sun6i_csi_capture_start_streaming(struct vb2_queue *queue,
 	if (ret < 0)
 		goto error_state;
 
-	if (capture->mbus_code == 0) {
-		ret = -EINVAL;
-		goto error_media_pipeline;
-	}
-
 	subdev = sun6i_csi_capture_remote_subdev(capture, NULL);
 	if (!subdev) {
 		ret = -EINVAL;
@@ -1072,8 +1068,6 @@ static int sun6i_csi_capture_link_validate(struct media_link *link)
 	struct v4l2_subdev_format source_fmt;
 	int ret;
 
-	capture->mbus_code = 0;
-
 	if (!media_pad_remote_pad_first(link->sink->entity->pads)) {
 		dev_info(csi_dev->dev, "capture node %s pad not connected\n",
 			 vdev->name);
@@ -1105,8 +1099,6 @@ static int sun6i_csi_capture_link_validate(struct media_link *link)
 		return -EPIPE;
 	}
 
-	capture->mbus_code = source_fmt.format.code;
-
 	return 0;
 }
 
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
index 02bdf45f7ca5..3b9759e1563d 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
@@ -39,7 +39,6 @@ struct sun6i_csi_capture {
 	struct media_pad		pad;
 
 	struct v4l2_format		format;
-	u32				mbus_code;
 };
 
 void sun6i_csi_capture_dimensions(struct sun6i_csi_device *csi_dev,
-- 
2.38.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE0461848F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 17:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbiKCQc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 12:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbiKCQbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 12:31:47 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355B81B9F6;
        Thu,  3 Nov 2022 09:31:42 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7484724000D;
        Thu,  3 Nov 2022 16:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667493100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LQyqzHTL++RGaItex4uVeobLkyhPnz1r6d4Sw3VlG+M=;
        b=DsYbmGVweA6LYsiGLeYmO6Ay8b/UN101pqYX+kYOePUlCxVPrWI7nf+U0xMfUgOaLFhTHX
        9pahhTpkylnSsvnWjePrKlw/kkG+1/A/YWagiZueTQT+5nmZY3OQLV7+/Yy44beuxmOYmW
        U0pnp0Hx2H9MgOl6DkjDhG7J7/ND3/rV+bAMvcTqVGA3+6B6Xp1h98mCo8aLrDdaLAKFMR
        MiuyFtzDmnriRjoAY0PYKHwIaoAiw5XUECmxgF+fFWfNWlYHjBA/EsYLOQzA8Z3cr9MXKC
        DZqrzqwYxpGu0w0R8HqRE9YWAfPY+Q9GqV1DkuYw49KM7Hy5THMUUMCkZJQz2g==
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
Subject: [PATCH v7 06/28] media: sun6i-csi: Implement address configuration without indirection
Date:   Thu,  3 Nov 2022 17:30:51 +0100
Message-Id: <20221103163113.245462-7-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221103163113.245462-1-paul.kocialkowski@bootlin.com>
References: <20221103163113.245462-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of calculating the planar_offset at one point and using it
later in a dedicated function, reimplement address configuration
with v4l2 format info in the buffer_configure function.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 27 ----------------
 .../platform/sunxi/sun6i-csi/sun6i_csi.h      | 10 ------
 .../sunxi/sun6i-csi/sun6i_csi_capture.c       | 32 ++++++++++++++++++-
 3 files changed, 31 insertions(+), 38 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index 79d4b00d1fcd..5e03069bd4c3 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -463,7 +463,6 @@ static void sun6i_csi_set_window(struct sun6i_csi_device *csi_dev)
 	struct sun6i_csi_config *config = &csi_dev->config;
 	u32 bytesperline_y;
 	u32 bytesperline_c;
-	int *planar_offset = csi_dev->planar_offset;
 	u32 width = config->width;
 	u32 height = config->height;
 	u32 hor_len = width;
@@ -488,7 +487,6 @@ static void sun6i_csi_set_window(struct sun6i_csi_device *csi_dev)
 		     SUN6I_CSI_CH_VSIZE_LEN(height) |
 		     SUN6I_CSI_CH_VSIZE_START(0));
 
-	planar_offset[0] = 0;
 	switch (config->pixelformat) {
 	case V4L2_PIX_FMT_NV12_16L16:
 	case V4L2_PIX_FMT_NV12:
@@ -497,23 +495,15 @@ static void sun6i_csi_set_window(struct sun6i_csi_device *csi_dev)
 	case V4L2_PIX_FMT_NV61:
 		bytesperline_y = width;
 		bytesperline_c = width;
-		planar_offset[1] = bytesperline_y * height;
-		planar_offset[2] = -1;
 		break;
 	case V4L2_PIX_FMT_YUV420:
 	case V4L2_PIX_FMT_YVU420:
 		bytesperline_y = width;
 		bytesperline_c = width / 2;
-		planar_offset[1] = bytesperline_y * height;
-		planar_offset[2] = planar_offset[1] +
-				bytesperline_c * height / 2;
 		break;
 	case V4L2_PIX_FMT_YUV422P:
 		bytesperline_y = width;
 		bytesperline_c = width / 2;
-		planar_offset[1] = bytesperline_y * height;
-		planar_offset[2] = planar_offset[1] +
-				bytesperline_c * height;
 		break;
 	default: /* raw */
 		dev_dbg(csi_dev->dev,
@@ -522,8 +512,6 @@ static void sun6i_csi_set_window(struct sun6i_csi_device *csi_dev)
 		bytesperline_y = (sun6i_csi_get_bpp(config->pixelformat) *
 				  config->width) / 8;
 		bytesperline_c = 0;
-		planar_offset[1] = -1;
-		planar_offset[2] = -1;
 		break;
 	}
 
@@ -547,21 +535,6 @@ int sun6i_csi_update_config(struct sun6i_csi_device *csi_dev,
 	return 0;
 }
 
-void sun6i_csi_update_buf_addr(struct sun6i_csi_device *csi_dev,
-			       dma_addr_t addr)
-{
-	regmap_write(csi_dev->regmap, SUN6I_CSI_CH_FIFO0_ADDR_REG,
-		     SUN6I_CSI_ADDR_VALUE(addr + csi_dev->planar_offset[0]));
-	if (csi_dev->planar_offset[1] != -1)
-		regmap_write(csi_dev->regmap, SUN6I_CSI_CH_FIFO1_ADDR_REG,
-			     SUN6I_CSI_ADDR_VALUE(addr +
-						  csi_dev->planar_offset[1]));
-	if (csi_dev->planar_offset[2] != -1)
-		regmap_write(csi_dev->regmap, SUN6I_CSI_CH_FIFO2_ADDR_REG,
-			     SUN6I_CSI_ADDR_VALUE(addr +
-						  csi_dev->planar_offset[2]));
-}
-
 void sun6i_csi_set_stream(struct sun6i_csi_device *csi_dev, bool enable)
 {
 	struct regmap *regmap = csi_dev->regmap;
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
index 6c0110e4b3ab..75867cde7985 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
@@ -60,8 +60,6 @@ struct sun6i_csi_device {
 	struct clk			*clock_mod;
 	struct clk			*clock_ram;
 	struct reset_control		*reset;
-
-	int				planar_offset[3];
 };
 
 struct sun6i_csi_variant {
@@ -98,14 +96,6 @@ int sun6i_csi_set_power(struct sun6i_csi_device *csi_dev, bool enable);
 int sun6i_csi_update_config(struct sun6i_csi_device *csi_dev,
 			    struct sun6i_csi_config *config);
 
-/**
- * sun6i_csi_update_buf_addr() - update the csi frame buffer address
- * @csi_dev:	pointer to the csi device
- * @addr:	frame buffer's physical address
- */
-void sun6i_csi_update_buf_addr(struct sun6i_csi_device *csi_dev,
-			       dma_addr_t addr);
-
 /**
  * sun6i_csi_set_stream() - start/stop csi streaming
  * @csi_dev:	pointer to the csi device
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
index a3c3bbf6a506..cb23dcdf250f 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/of.h>
+#include <linux/regmap.h>
 
 #include <media/v4l2-device.h>
 #include <media/v4l2-event.h>
@@ -16,6 +17,7 @@
 
 #include "sun6i_csi.h"
 #include "sun6i_csi_capture.h"
+#include "sun6i_csi_reg.h"
 
 /* This is got from BSP sources. */
 #define MIN_WIDTH	(32)
@@ -109,13 +111,41 @@ static void
 sun6i_csi_capture_buffer_configure(struct sun6i_csi_device *csi_dev,
 				   struct sun6i_csi_buffer *csi_buffer)
 {
+	struct regmap *regmap = csi_dev->regmap;
+	const struct v4l2_format_info *info;
 	struct vb2_buffer *vb2_buffer;
+	unsigned int width, height;
 	dma_addr_t address;
+	u32 pixelformat;
 
 	vb2_buffer = &csi_buffer->v4l2_buffer.vb2_buf;
 	address = vb2_dma_contig_plane_dma_addr(vb2_buffer, 0);
 
-	sun6i_csi_update_buf_addr(csi_dev, address);
+	regmap_write(regmap, SUN6I_CSI_CH_FIFO0_ADDR_REG,
+		     SUN6I_CSI_ADDR_VALUE(address));
+
+	sun6i_csi_capture_dimensions(csi_dev, &width, &height);
+	sun6i_csi_capture_format(csi_dev, &pixelformat, NULL);
+
+	info = v4l2_format_info(pixelformat);
+	/* Unsupported formats are single-plane, so we can stop here. */
+	if (!info)
+		return;
+
+	if (info->comp_planes > 1) {
+		address += info->bpp[0] * width * height;
+
+		regmap_write(regmap, SUN6I_CSI_CH_FIFO1_ADDR_REG,
+			     SUN6I_CSI_ADDR_VALUE(address));
+	}
+
+	if (info->comp_planes > 2) {
+		address += info->bpp[1] * DIV_ROUND_UP(width, info->hdiv) *
+			   DIV_ROUND_UP(height, info->vdiv);
+
+		regmap_write(regmap, SUN6I_CSI_CH_FIFO2_ADDR_REG,
+			     SUN6I_CSI_ADDR_VALUE(address));
+	}
 }
 
 static void sun6i_csi_capture_configure(struct sun6i_csi_device *csi_dev)
-- 
2.38.1


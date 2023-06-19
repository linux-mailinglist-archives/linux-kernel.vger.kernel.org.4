Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E321B735600
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 13:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjFSLk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 07:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjFSLkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 07:40:23 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5202116;
        Mon, 19 Jun 2023 04:40:22 -0700 (PDT)
Received: from desky.lan (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 804AA547;
        Mon, 19 Jun 2023 13:39:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1687174787;
        bh=90PzYNLWixBUyL3/eSoLzMJaEMkB7Asvs7U2pXzyuG4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=phYHN58NjLoPC7rE3G6gJEGQ+sU6Wa43jPuNqLWTryrFoUChmnBdgD5tzzeqBJB7s
         NiwS68bgvwDG512H7SWZt73m5c6hyOcjccm0UBOaZTyCEUlhRV9d+TChi383BHH+5V
         H9M7PhnUSd6VLxQ22lDgISLEqAmIPgqZC+i4BaiY=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Jai Luthra <j-luthra@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>
Cc:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v4 1/4] media: ti: cal: Clean up mbus formats uses
Date:   Mon, 19 Jun 2023 14:40:04 +0300
Message-Id: <20230619114007.297393-2-tomi.valkeinen@ideasonboard.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230619114007.297393-1-tomi.valkeinen@ideasonboard.com>
References: <20230619114007.297393-1-tomi.valkeinen@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the CAL drivers uses of mbus formats:

- Switch all YUV formats from 2X8 formats to 1X16, as those are what
  should be used for CSI-2 bus.

- Drop 24 and 32 bit formats, as the driver doesn't support them (see
  cal_ctx_pix_proc_config()).

- Switch RGB565_2X8_LE to RGB565_1X16 (for the same reason as for the
  YUV formats) and drop RGB565_2X8_BE as it cannot be supported with
  CSI-2.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
---
 drivers/media/platform/ti/cal/cal-camerarx.c |  2 +-
 drivers/media/platform/ti/cal/cal-video.c    |  2 +-
 drivers/media/platform/ti/cal/cal.c          | 36 ++++----------------
 3 files changed, 8 insertions(+), 32 deletions(-)

diff --git a/drivers/media/platform/ti/cal/cal-camerarx.c b/drivers/media/platform/ti/cal/cal-camerarx.c
index 16ae52879a79..267089b0fea0 100644
--- a/drivers/media/platform/ti/cal/cal-camerarx.c
+++ b/drivers/media/platform/ti/cal/cal-camerarx.c
@@ -817,7 +817,7 @@ static int cal_camerarx_sd_init_cfg(struct v4l2_subdev *sd,
 		.format = {
 			.width = 640,
 			.height = 480,
-			.code = MEDIA_BUS_FMT_UYVY8_2X8,
+			.code = MEDIA_BUS_FMT_UYVY8_1X16,
 			.field = V4L2_FIELD_NONE,
 			.colorspace = V4L2_COLORSPACE_SRGB,
 			.ycbcr_enc = V4L2_YCBCR_ENC_601,
diff --git a/drivers/media/platform/ti/cal/cal-video.c b/drivers/media/platform/ti/cal/cal-video.c
index ca906a9e4222..ed92e23d4b16 100644
--- a/drivers/media/platform/ti/cal/cal-video.c
+++ b/drivers/media/platform/ti/cal/cal-video.c
@@ -894,7 +894,7 @@ static int cal_ctx_v4l2_init_mc_format(struct cal_ctx *ctx)
 	const struct cal_format_info *fmtinfo;
 	struct v4l2_pix_format *pix_fmt = &ctx->v_fmt.fmt.pix;
 
-	fmtinfo = cal_format_by_code(MEDIA_BUS_FMT_UYVY8_2X8);
+	fmtinfo = cal_format_by_code(MEDIA_BUS_FMT_UYVY8_1X16);
 	if (!fmtinfo)
 		return -EINVAL;
 
diff --git a/drivers/media/platform/ti/cal/cal.c b/drivers/media/platform/ti/cal/cal.c
index 9c5105223d6b..18d86f6ae809 100644
--- a/drivers/media/platform/ti/cal/cal.c
+++ b/drivers/media/platform/ti/cal/cal.c
@@ -61,48 +61,24 @@ MODULE_PARM_DESC(mc_api, "activates the MC API");
 const struct cal_format_info cal_formats[] = {
 	{
 		.fourcc		= V4L2_PIX_FMT_YUYV,
-		.code		= MEDIA_BUS_FMT_YUYV8_2X8,
+		.code		= MEDIA_BUS_FMT_YUYV8_1X16,
 		.bpp		= 16,
 	}, {
 		.fourcc		= V4L2_PIX_FMT_UYVY,
-		.code		= MEDIA_BUS_FMT_UYVY8_2X8,
+		.code		= MEDIA_BUS_FMT_UYVY8_1X16,
 		.bpp		= 16,
 	}, {
 		.fourcc		= V4L2_PIX_FMT_YVYU,
-		.code		= MEDIA_BUS_FMT_YVYU8_2X8,
+		.code		= MEDIA_BUS_FMT_YVYU8_1X16,
 		.bpp		= 16,
 	}, {
 		.fourcc		= V4L2_PIX_FMT_VYUY,
-		.code		= MEDIA_BUS_FMT_VYUY8_2X8,
+		.code		= MEDIA_BUS_FMT_VYUY8_1X16,
 		.bpp		= 16,
 	}, {
-		.fourcc		= V4L2_PIX_FMT_RGB565, /* gggbbbbb rrrrrggg */
-		.code		= MEDIA_BUS_FMT_RGB565_2X8_LE,
+		.fourcc		= V4L2_PIX_FMT_RGB565,
+		.code		= MEDIA_BUS_FMT_RGB565_1X16,
 		.bpp		= 16,
-	}, {
-		.fourcc		= V4L2_PIX_FMT_RGB565X, /* rrrrrggg gggbbbbb */
-		.code		= MEDIA_BUS_FMT_RGB565_2X8_BE,
-		.bpp		= 16,
-	}, {
-		.fourcc		= V4L2_PIX_FMT_RGB555, /* gggbbbbb arrrrrgg */
-		.code		= MEDIA_BUS_FMT_RGB555_2X8_PADHI_LE,
-		.bpp		= 16,
-	}, {
-		.fourcc		= V4L2_PIX_FMT_RGB555X, /* arrrrrgg gggbbbbb */
-		.code		= MEDIA_BUS_FMT_RGB555_2X8_PADHI_BE,
-		.bpp		= 16,
-	}, {
-		.fourcc		= V4L2_PIX_FMT_RGB24, /* rgb */
-		.code		= MEDIA_BUS_FMT_RGB888_2X12_LE,
-		.bpp		= 24,
-	}, {
-		.fourcc		= V4L2_PIX_FMT_BGR24, /* bgr */
-		.code		= MEDIA_BUS_FMT_RGB888_2X12_BE,
-		.bpp		= 24,
-	}, {
-		.fourcc		= V4L2_PIX_FMT_RGB32, /* argb */
-		.code		= MEDIA_BUS_FMT_ARGB8888_1X32,
-		.bpp		= 32,
 	}, {
 		.fourcc		= V4L2_PIX_FMT_SBGGR8,
 		.code		= MEDIA_BUS_FMT_SBGGR8_1X8,
-- 
2.34.1


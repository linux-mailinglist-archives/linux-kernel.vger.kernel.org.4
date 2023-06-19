Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0836735603
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 13:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbjFSLki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 07:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjFSLk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 07:40:28 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FBBDA;
        Mon, 19 Jun 2023 04:40:26 -0700 (PDT)
Received: from desky.lan (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 397ACDDA;
        Mon, 19 Jun 2023 13:39:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1687174789;
        bh=VHa8FwqxJxMZyb+g6bE2eDnxQBC76J4AUz2E56TPpMs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ETqf6uvDjZCyXdCbWuTiix5zPg7gjF/7rIpzwc+DA3ekf2HKKw2E0cIn/ys/fHjc0
         7TaBatKXk94z3KV2K7Gc8PEefSZROJ8j74/BCHcoQu6sPULW46IARxH8KWBjuQ/Flx
         u/Dw7/3uO4Z5XrvAkNP6i+QcBw+qR5vSPJobRyME=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Jai Luthra <j-luthra@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>
Cc:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v4 4/4] media: ti: cal: Implement get_frame_desc for camera-rx
Date:   Mon, 19 Jun 2023 14:40:07 +0300
Message-Id: <20230619114007.297393-5-tomi.valkeinen@ideasonboard.com>
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

CAL uses get_frame_desc to get the VC and DT for the incoming CSI-2
stream, but does it in a bit hacky way. Clean this up by implementing
.get_frame_desc to camera-rx, and calling that from cal.c.

No functional change intended.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
---
 drivers/media/platform/ti/cal/cal-camerarx.c | 62 +++++++++++---------
 drivers/media/platform/ti/cal/cal.c          | 30 ++++------
 drivers/media/platform/ti/cal/cal.h          |  2 -
 3 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/drivers/media/platform/ti/cal/cal-camerarx.c b/drivers/media/platform/ti/cal/cal-camerarx.c
index bc09c3f1446d..1a4273bbe752 100644
--- a/drivers/media/platform/ti/cal/cal-camerarx.c
+++ b/drivers/media/platform/ti/cal/cal-camerarx.c
@@ -589,33 +589,6 @@ static int cal_camerarx_parse_dt(struct cal_camerarx *phy)
 	return ret;
 }
 
-int cal_camerarx_get_remote_frame_desc(struct cal_camerarx *phy,
-				       struct v4l2_mbus_frame_desc *desc)
-{
-	struct media_pad *pad;
-	int ret;
-
-	if (!phy->source)
-		return -EPIPE;
-
-	pad = media_pad_remote_pad_first(&phy->pads[CAL_CAMERARX_PAD_SINK]);
-	if (!pad)
-		return -EPIPE;
-
-	ret = v4l2_subdev_call(phy->source, pad, get_frame_desc, pad->index,
-			       desc);
-	if (ret)
-		return ret;
-
-	if (desc->type != V4L2_MBUS_FRAME_DESC_TYPE_CSI2) {
-		dev_err(phy->cal->dev,
-			"Frame descriptor does not describe CSI-2 link");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 /* ------------------------------------------------------------------
  *	V4L2 Subdev Operations
  * ------------------------------------------------------------------
@@ -772,6 +745,40 @@ static int cal_camerarx_sd_init_cfg(struct v4l2_subdev *sd,
 	return cal_camerarx_sd_set_fmt(sd, state, &format);
 }
 
+static int cal_camerarx_get_frame_desc(struct v4l2_subdev *sd, unsigned int pad,
+				       struct v4l2_mbus_frame_desc *fd)
+{
+	struct cal_camerarx *phy = to_cal_camerarx(sd);
+	struct v4l2_mbus_frame_desc remote_desc;
+	const struct media_pad *remote_pad;
+	int ret;
+
+	remote_pad = media_pad_remote_pad_first(&phy->pads[CAL_CAMERARX_PAD_SINK]);
+	if (!remote_pad)
+		return -EPIPE;
+
+	ret = v4l2_subdev_call(phy->source, pad, get_frame_desc,
+			       remote_pad->index, &remote_desc);
+	if (ret)
+		return ret;
+
+	if (remote_desc.type != V4L2_MBUS_FRAME_DESC_TYPE_CSI2) {
+		cal_err(phy->cal,
+			"Frame descriptor does not describe CSI-2 link");
+		return -EINVAL;
+	}
+
+	if (remote_desc.num_entries > 1)
+		cal_err(phy->cal,
+			"Multiple streams not supported in remote frame descriptor, using the first one\n");
+
+	fd->type = V4L2_MBUS_FRAME_DESC_TYPE_CSI2;
+	fd->num_entries = 1;
+	fd->entry[0] = remote_desc.entry[0];
+
+	return 0;
+}
+
 static const struct v4l2_subdev_video_ops cal_camerarx_video_ops = {
 	.s_stream = cal_camerarx_sd_s_stream,
 };
@@ -782,6 +789,7 @@ static const struct v4l2_subdev_pad_ops cal_camerarx_pad_ops = {
 	.enum_frame_size = cal_camerarx_sd_enum_frame_size,
 	.get_fmt = v4l2_subdev_get_fmt,
 	.set_fmt = cal_camerarx_sd_set_fmt,
+	.get_frame_desc = cal_camerarx_get_frame_desc,
 };
 
 static const struct v4l2_subdev_ops cal_camerarx_subdev_ops = {
diff --git a/drivers/media/platform/ti/cal/cal.c b/drivers/media/platform/ti/cal/cal.c
index 18d86f6ae809..3c74e461fc50 100644
--- a/drivers/media/platform/ti/cal/cal.c
+++ b/drivers/media/platform/ti/cal/cal.c
@@ -446,30 +446,24 @@ static bool cal_ctx_wr_dma_stopped(struct cal_ctx *ctx)
 }
 
 static int
-cal_get_remote_frame_desc_entry(struct cal_camerarx *phy,
+cal_get_remote_frame_desc_entry(struct cal_ctx *ctx,
 				struct v4l2_mbus_frame_desc_entry *entry)
 {
 	struct v4l2_mbus_frame_desc fd;
+	struct media_pad *phy_source_pad;
 	int ret;
 
-	ret = cal_camerarx_get_remote_frame_desc(phy, &fd);
-	if (ret) {
-		if (ret != -ENOIOCTLCMD)
-			dev_err(phy->cal->dev,
-				"Failed to get remote frame desc: %d\n", ret);
-		return ret;
-	}
-
-	if (fd.num_entries == 0) {
-		dev_err(phy->cal->dev,
-			"No streams found in the remote frame descriptor\n");
-
+	phy_source_pad = media_pad_remote_pad_first(&ctx->pad);
+	if (!phy_source_pad)
 		return -ENODEV;
-	}
 
-	if (fd.num_entries > 1)
-		dev_dbg(phy->cal->dev,
-			"Multiple streams not supported in remote frame descriptor, using the first one\n");
+	ret = v4l2_subdev_call(&ctx->phy->subdev, pad, get_frame_desc,
+			       phy_source_pad->index, &fd);
+	if (ret)
+		return ret;
+
+	if (fd.num_entries != 1)
+		return -EINVAL;
 
 	*entry = fd.entry[0];
 
@@ -481,7 +475,7 @@ int cal_ctx_prepare(struct cal_ctx *ctx)
 	struct v4l2_mbus_frame_desc_entry entry;
 	int ret;
 
-	ret = cal_get_remote_frame_desc_entry(ctx->phy, &entry);
+	ret = cal_get_remote_frame_desc_entry(ctx, &entry);
 
 	if (ret == -ENOIOCTLCMD) {
 		ctx->vc = 0;
diff --git a/drivers/media/platform/ti/cal/cal.h b/drivers/media/platform/ti/cal/cal.h
index 55d4736fed18..0856297adc0b 100644
--- a/drivers/media/platform/ti/cal/cal.h
+++ b/drivers/media/platform/ti/cal/cal.h
@@ -319,8 +319,6 @@ const struct cal_format_info *cal_format_by_code(u32 code);
 
 void cal_quickdump_regs(struct cal_dev *cal);
 
-int cal_camerarx_get_remote_frame_desc(struct cal_camerarx *phy,
-				       struct v4l2_mbus_frame_desc *desc);
 void cal_camerarx_disable(struct cal_camerarx *phy);
 void cal_camerarx_i913_errata(struct cal_camerarx *phy);
 struct cal_camerarx *cal_camerarx_create(struct cal_dev *cal,
-- 
2.34.1


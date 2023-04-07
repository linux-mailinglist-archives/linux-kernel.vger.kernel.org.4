Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9876DAE14
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 15:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240929AbjDGNmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 09:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240922AbjDGNmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 09:42:06 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC438C65A;
        Fri,  7 Apr 2023 06:40:41 -0700 (PDT)
Received: from booty.fritz.box (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 462AC1BF20D;
        Fri,  7 Apr 2023 13:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1680874819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FqAWN2Nlle26MSVVPjAiKTTHeBnplKoRiSeKdtD/hco=;
        b=mG1q1tA+Nx5IjFsKnEam3LouLtf6axsehW8ANI4+qTzS3lLquPlmLACRgTgyFjXhUd1nwx
        31gDyaUGD+wlANeQbN7Wkq0HOa5RFsJd8v62SlYylCok7fOAa2WEaglrGWSQxg/TndaFho
        1H+m+LOvx4iF6ttrS+xa7cdBntgD5A7ejKeNEXIvMuGHBZKXRSs2XA719Xmv3bx7AJ/iZd
        EE8tZy4keNz7gu6UcNBU2yG6Y3+S1rziTvt16bdCqouGzEx7FbW8PMIWS0yBnw2x3Bqg3x
        wT2bQmGwYFVKTHAlSjwUL5vXqg9vO9Cx5aP3Fj9/BJZOZpTn3m/gDcUX9WeOuQ==
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     linux-tegra@vger.kernel.org
Cc:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Richard Leitner <richard.leitner@skidata.com>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v5 12/20] staging: media: tegra-video: move tegra_channel_fmt_align to a per-soc op
Date:   Fri,  7 Apr 2023 15:38:44 +0200
Message-Id: <20230407133852.2850145-13-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230407133852.2850145-1-luca.ceresoli@bootlin.com>
References: <20230407133852.2850145-1-luca.ceresoli@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tegra_channel_fmt_align() takes care of the size constraints, alignment and
rounding requirements of the Tegra210 VI peripheral. Tegra20 has different
constraints.

In preparation for adding Tegra20 support, move this function to a new op
in the soc-specific `struct tegra_vi_ops` .

Also move to tegra210.c the T210-specific defines used in the moved code.

No functional changes.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Reviewed-by: Dmitry Osipenko <digetx@gmail.com>

---

No changes in v5

Changed in v4:
 - Added review tags

No changes in v3
No changes in v2
---
 drivers/staging/media/tegra-video/tegra210.c | 36 ++++++++++++++++++
 drivers/staging/media/tegra-video/vi.c       | 40 +++-----------------
 drivers/staging/media/tegra-video/vi.h       |  9 ++---
 3 files changed, 44 insertions(+), 41 deletions(-)

diff --git a/drivers/staging/media/tegra-video/tegra210.c b/drivers/staging/media/tegra-video/tegra210.c
index d58370a84737..d19ff6b49ae8 100644
--- a/drivers/staging/media/tegra-video/tegra210.c
+++ b/drivers/staging/media/tegra-video/tegra210.c
@@ -17,6 +17,13 @@
 #include "csi.h"
 #include "vi.h"
 
+#define TEGRA210_MIN_WIDTH	32U
+#define TEGRA210_MAX_WIDTH	32768U
+#define TEGRA210_MIN_HEIGHT	32U
+#define TEGRA210_MAX_HEIGHT	32768U
+
+#define SURFACE_ALIGN_BYTES	64
+
 #define TEGRA_VI_SYNCPT_WAIT_TIMEOUT			msecs_to_jiffies(200)
 
 /* Tegra210 VI registers */
@@ -172,6 +179,34 @@ static u32 vi_csi_read(struct tegra_vi_channel *chan, u8 portno,
 /*
  * Tegra210 VI channel capture operations
  */
+static void tegra210_fmt_align(struct v4l2_pix_format *pix, unsigned int bpp)
+{
+	unsigned int min_bpl;
+	unsigned int max_bpl;
+	unsigned int bpl;
+
+	/*
+	 * The transfer alignment requirements are expressed in bytes.
+	 * Clamp the requested width and height to the limits.
+	 */
+	pix->width = clamp(pix->width, TEGRA210_MIN_WIDTH, TEGRA210_MAX_WIDTH);
+	pix->height = clamp(pix->height, TEGRA210_MIN_HEIGHT, TEGRA210_MAX_HEIGHT);
+
+	/* Clamp the requested bytes per line value. If the maximum bytes per
+	 * line value is zero, the module doesn't support user configurable
+	 * line sizes. Override the requested value with the minimum in that
+	 * case.
+	 */
+	min_bpl = pix->width * bpp;
+	max_bpl = rounddown(TEGRA210_MAX_WIDTH, SURFACE_ALIGN_BYTES);
+	bpl = roundup(pix->bytesperline, SURFACE_ALIGN_BYTES);
+
+	pix->bytesperline = clamp(bpl, min_bpl, max_bpl);
+	pix->sizeimage = pix->bytesperline * pix->height;
+	if (pix->pixelformat == V4L2_PIX_FMT_NV16)
+		pix->sizeimage *= 2;
+}
+
 static int tegra_channel_capture_setup(struct tegra_vi_channel *chan,
 				       u8 portno)
 {
@@ -718,6 +753,7 @@ static const struct tegra_video_format tegra210_video_formats[] = {
 
 /* Tegra210 VI operations */
 static const struct tegra_vi_ops tegra210_vi_ops = {
+	.vi_fmt_align = tegra210_fmt_align,
 	.vi_start_streaming = tegra210_vi_start_streaming,
 	.vi_stop_streaming = tegra210_vi_stop_streaming,
 };
diff --git a/drivers/staging/media/tegra-video/vi.c b/drivers/staging/media/tegra-video/vi.c
index db98d06351b4..35d7cda1373f 100644
--- a/drivers/staging/media/tegra-video/vi.c
+++ b/drivers/staging/media/tegra-video/vi.c
@@ -473,36 +473,6 @@ static int tegra_channel_get_format(struct file *file, void *fh,
 	return 0;
 }
 
-static void tegra_channel_fmt_align(struct tegra_vi_channel *chan,
-				    struct v4l2_pix_format *pix,
-				    unsigned int bpp)
-{
-	unsigned int min_bpl;
-	unsigned int max_bpl;
-	unsigned int bpl;
-
-	/*
-	 * The transfer alignment requirements are expressed in bytes.
-	 * Clamp the requested width and height to the limits.
-	 */
-	pix->width = clamp(pix->width, TEGRA_MIN_WIDTH, TEGRA_MAX_WIDTH);
-	pix->height = clamp(pix->height, TEGRA_MIN_HEIGHT, TEGRA_MAX_HEIGHT);
-
-	/* Clamp the requested bytes per line value. If the maximum bytes per
-	 * line value is zero, the module doesn't support user configurable
-	 * line sizes. Override the requested value with the minimum in that
-	 * case.
-	 */
-	min_bpl = pix->width * bpp;
-	max_bpl = rounddown(TEGRA_MAX_WIDTH, SURFACE_ALIGN_BYTES);
-	bpl = roundup(pix->bytesperline, SURFACE_ALIGN_BYTES);
-
-	pix->bytesperline = clamp(bpl, min_bpl, max_bpl);
-	pix->sizeimage = pix->bytesperline * pix->height;
-	if (pix->pixelformat == V4L2_PIX_FMT_NV16)
-		pix->sizeimage *= 2;
-}
-
 static int __tegra_channel_try_format(struct tegra_vi_channel *chan,
 				      struct v4l2_pix_format *pix)
 {
@@ -578,7 +548,7 @@ static int __tegra_channel_try_format(struct tegra_vi_channel *chan,
 		return ret;
 
 	v4l2_fill_pix_format(pix, &fmt.format);
-	tegra_channel_fmt_align(chan, pix, fmtinfo->bpp);
+	chan->vi->ops->vi_fmt_align(pix, fmtinfo->bpp);
 
 	__v4l2_subdev_state_free(sd_state);
 
@@ -630,7 +600,7 @@ static int tegra_channel_set_format(struct file *file, void *fh,
 		return ret;
 
 	v4l2_fill_pix_format(pix, &fmt.format);
-	tegra_channel_fmt_align(chan, pix, fmtinfo->bpp);
+	chan->vi->ops->vi_fmt_align(pix, fmtinfo->bpp);
 
 	chan->format = *pix;
 	chan->fmtinfo = fmtinfo;
@@ -666,7 +636,7 @@ static int tegra_channel_set_subdev_active_fmt(struct tegra_vi_channel *chan)
 	chan->format.bytesperline = chan->format.width * chan->fmtinfo->bpp;
 	chan->format.sizeimage = chan->format.bytesperline *
 				 chan->format.height;
-	tegra_channel_fmt_align(chan, &chan->format, chan->fmtinfo->bpp);
+	chan->vi->ops->vi_fmt_align(&chan->format, chan->fmtinfo->bpp);
 	tegra_channel_update_gangports(chan);
 
 	return 0;
@@ -835,7 +805,7 @@ static int tegra_channel_s_dv_timings(struct file *file, void *fh,
 	chan->format.height = bt->height;
 	chan->format.bytesperline = bt->width * chan->fmtinfo->bpp;
 	chan->format.sizeimage = chan->format.bytesperline * bt->height;
-	tegra_channel_fmt_align(chan, &chan->format, chan->fmtinfo->bpp);
+	chan->vi->ops->vi_fmt_align(&chan->format, chan->fmtinfo->bpp);
 	tegra_channel_update_gangports(chan);
 
 	return 0;
@@ -1238,7 +1208,7 @@ static int tegra_channel_init(struct tegra_vi_channel *chan)
 	chan->format.height = TEGRA_DEF_HEIGHT;
 	chan->format.bytesperline = TEGRA_DEF_WIDTH * chan->fmtinfo->bpp;
 	chan->format.sizeimage = chan->format.bytesperline * TEGRA_DEF_HEIGHT;
-	tegra_channel_fmt_align(chan, &chan->format, chan->fmtinfo->bpp);
+	vi->ops->vi_fmt_align(&chan->format, chan->fmtinfo->bpp);
 
 	ret = tegra_channel_host1x_syncpt_init(chan);
 	if (ret)
diff --git a/drivers/staging/media/tegra-video/vi.h b/drivers/staging/media/tegra-video/vi.h
index 9959cbe02ca0..213955c7545d 100644
--- a/drivers/staging/media/tegra-video/vi.h
+++ b/drivers/staging/media/tegra-video/vi.h
@@ -25,17 +25,11 @@
 
 #define V4L2_CID_TEGRA_SYNCPT_TIMEOUT_RETRY	(V4L2_CTRL_CLASS_CAMERA | 0x1001)
 
-#define TEGRA_MIN_WIDTH		32U
-#define TEGRA_MAX_WIDTH		32768U
-#define TEGRA_MIN_HEIGHT	32U
-#define TEGRA_MAX_HEIGHT	32768U
-
 #define TEGRA_DEF_WIDTH		1920
 #define TEGRA_DEF_HEIGHT	1080
 #define TEGRA_IMAGE_FORMAT_DEF	32
 
 #define MAX_FORMAT_NUM		64
-#define SURFACE_ALIGN_BYTES	64
 
 enum tegra_vi_pg_mode {
 	TEGRA_VI_PG_DISABLED = 0,
@@ -45,6 +39,8 @@ enum tegra_vi_pg_mode {
 
 /**
  * struct tegra_vi_ops - Tegra VI operations
+ * @vi_fmt_align: modify `pix` to fit the hardware alignment
+ *		requirements and fill image geometry
  * @vi_start_streaming: starts media pipeline, subdevice streaming, sets up
  *		VI for capture and runs capture start and capture finish
  *		kthreads for capturing frames to buffer and returns them back.
@@ -52,6 +48,7 @@ enum tegra_vi_pg_mode {
  *		back any queued buffers.
  */
 struct tegra_vi_ops {
+	void (*vi_fmt_align)(struct v4l2_pix_format *pix, unsigned int bpp);
 	int (*vi_start_streaming)(struct vb2_queue *vq, u32 count);
 	void (*vi_stop_streaming)(struct vb2_queue *vq);
 };
-- 
2.34.1


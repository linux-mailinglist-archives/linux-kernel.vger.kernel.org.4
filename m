Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F8363BAE1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 08:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiK2Hpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 02:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiK2Hpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 02:45:42 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5421451319
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 23:45:40 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 136so12284053pga.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 23:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6AvpIZTqiur3BoD1YJfby7KUAIdfNk2cHvPsInLKb+g=;
        b=JMkGSxHRtoRtKjGpxjUX7oinIZswEX8az53lQlCt4iIybURsC0sauHQDpc35jkLO/l
         K23+45mO1ILHr8sE7rM3RJOBYYMKFRCM9ouKZDTziVxrBIflRdtl2y01Fm4Hey3wSo5w
         tP5LyXFIWs7cKksDWYNAYHZe6OotAjVLhAXmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6AvpIZTqiur3BoD1YJfby7KUAIdfNk2cHvPsInLKb+g=;
        b=brx7wssYp8XkRLlEHFZGtEz0eP46hxYX9ioTMmkiD3A28pwfZgILKm6rA+3Rq6p+bz
         n00DD4CI7K1HtCeuU1uV0g70yr/Uw8CXh87mNnWJlFLhEVQ/V0dX1wncfP93GJWfY5XU
         ioPX+rIOwwlPYId06IUj0s9hOMVlR12W7rrVWIQYJxLmLXpmzXzA2EASsS1iglFJ42g9
         gfYjQRpLf/Pk78XQ36nWwmimmPjmSziYVUyfrjO/Y/O4wY3fAlZEFM0xZB7mKugUqVLu
         svo21celq8xYRnanP3+A6YFuunSyMgOZtQGwy/qsQuOCdRZtdKSjhGpmRp8hxnttuN0y
         XyUA==
X-Gm-Message-State: ANoB5pnFOAL7xSIfRyku0ufgZDV9KYAKCIqgKsxSaBYAZeTm+GJ5nmpG
        ovwO5SuoV+yFvZkHNCYDtaoRB+xcOdxfxw==
X-Google-Smtp-Source: AA0mqf5rirbrnmO/SuPR/rsPwZcevrAXoRNfEwUiu5SFp26/NN71Tb+xm6lMvilwPUy9vzA5CQw8Hw==
X-Received: by 2002:a63:e607:0:b0:477:e302:ee5d with SMTP id g7-20020a63e607000000b00477e302ee5dmr17312204pgh.335.1669707939728;
        Mon, 28 Nov 2022 23:45:39 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:ac4a:f96:259:b58a])
        by smtp.gmail.com with ESMTPSA id y75-20020a62644e000000b0056ee49d6e95sm9235176pfb.86.2022.11.28.23.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 23:45:39 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, linux-media@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
Subject: [PATCH] media: cedrus: Convert to MPLANE uAPI
Date:   Tue, 29 Nov 2022 15:45:30 +0800
Message-Id: <20221129074530.640251-1-wenst@chromium.org>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The majority of the V4L2 stateless video decoder drivers use the MPLANE
interface.

On the userspace side, Gstreamer supports non-MPLANE and MPLANE
interfaces. Chromium only supports the MPLANE interface, and is not yet
usable with standard desktop Linux. FFmpeg support for either has not
landed.

A fallback route using libv4l is also available. The library translates
MPLANE interface ioctl calls to non-MPLANE ones, provided that the pixel
format used is single plane.

Convert the Cedrus driver to the MPLANE interface, while keeping the
supported formats single plane. Besides backward compatibility through
the plugin, the hardware requires that different planes not be located
too far apart in memory. Keeping the single plane pixel format makes
this easy to enforce.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---

This has been tested with Fluster. The score remained the same with or
without the patch. This also helps with getting VP8 decoding working
with Chromium's in-tree test program "video_decode_accelerator_tests",
though Chromium requires other changes regarding buffer allocation and
management.

---
 drivers/staging/media/sunxi/cedrus/cedrus.c   |   2 +-
 drivers/staging/media/sunxi/cedrus/cedrus.h   |  10 +-
 .../staging/media/sunxi/cedrus/cedrus_h264.c  |   4 +-
 .../staging/media/sunxi/cedrus/cedrus_h265.c  |   8 +-
 .../staging/media/sunxi/cedrus/cedrus_hw.c    |   2 +-
 .../staging/media/sunxi/cedrus/cedrus_hw.h    |   2 +-
 .../staging/media/sunxi/cedrus/cedrus_mpeg2.c |   2 +-
 .../staging/media/sunxi/cedrus/cedrus_video.c | 113 +++++++++---------
 .../staging/media/sunxi/cedrus/cedrus_video.h |   2 +-
 9 files changed, 73 insertions(+), 72 deletions(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/staging/media/sunxi/cedrus/cedrus.c
index a43d5ff66716..a2a4f08d9ba3 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
@@ -437,7 +437,7 @@ static const struct video_device cedrus_video_device = {
 	.ioctl_ops	= &cedrus_ioctl_ops,
 	.minor		= -1,
 	.release	= video_device_release_empty,
-	.device_caps	= V4L2_CAP_VIDEO_M2M | V4L2_CAP_STREAMING,
+	.device_caps	= V4L2_CAP_VIDEO_M2M_MPLANE | V4L2_CAP_STREAMING,
 };
 
 static const struct v4l2_m2m_ops cedrus_m2m_ops = {
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.h b/drivers/staging/media/sunxi/cedrus/cedrus.h
index 522c184e2afc..7a7a6a2c1dcf 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.h
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.h
@@ -116,8 +116,8 @@ struct cedrus_ctx {
 	struct v4l2_fh			fh;
 	struct cedrus_dev		*dev;
 
-	struct v4l2_pix_format		src_fmt;
-	struct v4l2_pix_format		dst_fmt;
+	struct v4l2_pix_format_mplane	src_fmt;
+	struct v4l2_pix_format_mplane	dst_fmt;
 	struct cedrus_dec_ops		*current_codec;
 	unsigned int			bit_depth;
 
@@ -164,7 +164,7 @@ struct cedrus_dec_ops {
 	void (*stop)(struct cedrus_ctx *ctx);
 	void (*trigger)(struct cedrus_ctx *ctx);
 	unsigned int (*extra_cap_size)(struct cedrus_ctx *ctx,
-				       struct v4l2_pix_format *pix_fmt);
+				       struct v4l2_pix_format_mplane *pix_fmt_mp);
 };
 
 struct cedrus_variant {
@@ -221,12 +221,12 @@ static inline u32 cedrus_wait_for(struct cedrus_dev *dev, u32 reg, u32 flag)
 }
 
 static inline dma_addr_t cedrus_buf_addr(struct vb2_buffer *buf,
-					 struct v4l2_pix_format *pix_fmt,
+					 struct v4l2_pix_format_mplane *pix_fmt,
 					 unsigned int plane)
 {
 	dma_addr_t addr = vb2_dma_contig_plane_dma_addr(buf, 0);
 
-	return addr + (pix_fmt ? (dma_addr_t)pix_fmt->bytesperline *
+	return addr + (pix_fmt ? (dma_addr_t)pix_fmt->plane_fmt[0].bytesperline *
 	       pix_fmt->height * plane : 0);
 }
 
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
index dfb401df138a..fa86928df77a 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
@@ -97,7 +97,7 @@ static int cedrus_write_frame_list(struct cedrus_ctx *ctx,
 	int output = -1;
 	unsigned int i;
 
-	cap_q = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE);
+	cap_q = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE);
 
 	memset(pic_list, 0, sizeof(pic_list));
 
@@ -198,7 +198,7 @@ static void _cedrus_write_ref_list(struct cedrus_ctx *ctx,
 	unsigned int i;
 	size_t size;
 
-	cap_q = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE);
+	cap_q = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE);
 
 	memset(sram_array, 0, sizeof(sram_array));
 
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
index fc9297232456..e5256f6f34fc 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
@@ -150,7 +150,7 @@ static void cedrus_h265_frame_info_write_dpb(struct cedrus_ctx *ctx,
 					     u8 num_active_dpb_entries)
 {
 	struct vb2_queue *vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx,
-					       V4L2_BUF_TYPE_VIDEO_CAPTURE);
+					       V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE);
 	unsigned int i;
 
 	for (i = 0; i < num_active_dpb_entries; i++) {
@@ -818,7 +818,7 @@ static int cedrus_h265_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 	if (ctx->bit_depth > 8) {
 		unsigned int stride = ALIGN(ctx->dst_fmt.width / 4, 32);
 
-		reg = ctx->dst_fmt.sizeimage -
+		reg = ctx->dst_fmt.plane_fmt[0].sizeimage -
 		      cedrus_h265_2bit_size(ctx->dst_fmt.width,
 					    ctx->dst_fmt.height);
 		cedrus_write(dev, VE_DEC_H265_OFFSET_ADDR_FIRST_OUT, reg);
@@ -900,10 +900,10 @@ static void cedrus_h265_trigger(struct cedrus_ctx *ctx)
 }
 
 static unsigned int cedrus_h265_extra_cap_size(struct cedrus_ctx *ctx,
-					       struct v4l2_pix_format *pix_fmt)
+					       struct v4l2_pix_format_mplane *pix_fmt_mp)
 {
 	if (ctx->bit_depth > 8)
-		return cedrus_h265_2bit_size(pix_fmt->width, pix_fmt->height);
+		return cedrus_h265_2bit_size(pix_fmt_mp->width, pix_fmt_mp->height);
 
 	return 0;
 }
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
index fa86a658fdc6..a251d953959e 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
@@ -77,7 +77,7 @@ void cedrus_engine_disable(struct cedrus_dev *dev)
 }
 
 void cedrus_dst_format_set(struct cedrus_dev *dev,
-			   struct v4l2_pix_format *fmt)
+			   struct v4l2_pix_format_mplane *fmt)
 {
 	unsigned int width = fmt->width;
 	unsigned int height = fmt->height;
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_hw.h b/drivers/staging/media/sunxi/cedrus/cedrus_hw.h
index 6f1e701b1ea8..c4acb8f1bd2d 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_hw.h
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_hw.h
@@ -20,7 +20,7 @@ int cedrus_engine_enable(struct cedrus_ctx *ctx);
 void cedrus_engine_disable(struct cedrus_dev *dev);
 
 void cedrus_dst_format_set(struct cedrus_dev *dev,
-			   struct v4l2_pix_format *fmt);
+			   struct v4l2_pix_format_mplane *fmt_mp);
 
 int cedrus_hw_suspend(struct device *device);
 int cedrus_hw_resume(struct device *device);
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c b/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
index 10e98f08aafc..b409247f4a1f 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
@@ -119,7 +119,7 @@ static int cedrus_mpeg2_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 	cedrus_write(dev, VE_DEC_MPEG_PICBOUNDSIZE, reg);
 
 	/* Forward and backward prediction reference buffers. */
-	vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE);
+	vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE);
 
 	cedrus_write_ref_buf_addr(ctx, vq, pic->forward_ref_ts,
 				  VE_DEC_MPEG_FWD_REF_LUMA_ADDR,
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_video.c b/drivers/staging/media/sunxi/cedrus/cedrus_video.c
index b00feaf4072c..b931f76f0077 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_video.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_video.c
@@ -100,20 +100,21 @@ static struct cedrus_format *cedrus_find_format(struct cedrus_ctx *ctx,
 	return &cedrus_formats[i];
 }
 
-void cedrus_prepare_format(struct v4l2_pix_format *pix_fmt)
+void cedrus_prepare_format(struct v4l2_pix_format_mplane *pix_fmt_mp)
 {
-	unsigned int width = pix_fmt->width;
-	unsigned int height = pix_fmt->height;
-	unsigned int sizeimage = pix_fmt->sizeimage;
-	unsigned int bytesperline = pix_fmt->bytesperline;
+	unsigned int width = pix_fmt_mp->width;
+	unsigned int height = pix_fmt_mp->height;
+	unsigned int sizeimage = pix_fmt_mp->plane_fmt[0].sizeimage;
+	unsigned int bytesperline = pix_fmt_mp->plane_fmt[0].bytesperline;
 
-	pix_fmt->field = V4L2_FIELD_NONE;
+	pix_fmt_mp->field = V4L2_FIELD_NONE;
+	pix_fmt_mp->num_planes = 1;
 
 	/* Limit to hardware min/max. */
 	width = clamp(width, CEDRUS_MIN_WIDTH, CEDRUS_MAX_WIDTH);
 	height = clamp(height, CEDRUS_MIN_HEIGHT, CEDRUS_MAX_HEIGHT);
 
-	switch (pix_fmt->pixelformat) {
+	switch (pix_fmt_mp->pixelformat) {
 	case V4L2_PIX_FMT_MPEG2_SLICE:
 	case V4L2_PIX_FMT_H264_SLICE:
 	case V4L2_PIX_FMT_HEVC_SLICE:
@@ -155,11 +156,11 @@ void cedrus_prepare_format(struct v4l2_pix_format *pix_fmt)
 		break;
 	}
 
-	pix_fmt->width = width;
-	pix_fmt->height = height;
+	pix_fmt_mp->width = width;
+	pix_fmt_mp->height = height;
 
-	pix_fmt->bytesperline = bytesperline;
-	pix_fmt->sizeimage = sizeimage;
+	pix_fmt_mp->plane_fmt[0].bytesperline = bytesperline;
+	pix_fmt_mp->plane_fmt[0].sizeimage = sizeimage;
 }
 
 static int cedrus_querycap(struct file *file, void *priv,
@@ -222,7 +223,7 @@ static int cedrus_g_fmt_vid_cap(struct file *file, void *priv,
 {
 	struct cedrus_ctx *ctx = cedrus_file2ctx(file);
 
-	f->fmt.pix = ctx->dst_fmt;
+	f->fmt.pix_mp = ctx->dst_fmt;
 	return 0;
 }
 
@@ -231,28 +232,28 @@ static int cedrus_g_fmt_vid_out(struct file *file, void *priv,
 {
 	struct cedrus_ctx *ctx = cedrus_file2ctx(file);
 
-	f->fmt.pix = ctx->src_fmt;
+	f->fmt.pix_mp = ctx->src_fmt;
 	return 0;
 }
 
 static int cedrus_try_fmt_vid_cap_p(struct cedrus_ctx *ctx,
-				    struct v4l2_pix_format *pix_fmt)
+				    struct v4l2_pix_format_mplane *pix_fmt_mp)
 {
 	struct cedrus_format *fmt =
-		cedrus_find_format(ctx, pix_fmt->pixelformat,
+		cedrus_find_format(ctx, pix_fmt_mp->pixelformat,
 				   CEDRUS_DECODE_DST);
 
 	if (!fmt)
 		return -EINVAL;
 
-	pix_fmt->pixelformat = fmt->pixelformat;
-	pix_fmt->width = ctx->src_fmt.width;
-	pix_fmt->height = ctx->src_fmt.height;
-	cedrus_prepare_format(pix_fmt);
+	pix_fmt_mp->pixelformat = fmt->pixelformat;
+	pix_fmt_mp->width = ctx->src_fmt.width;
+	pix_fmt_mp->height = ctx->src_fmt.height;
+	cedrus_prepare_format(pix_fmt_mp);
 
 	if (ctx->current_codec->extra_cap_size)
-		pix_fmt->sizeimage +=
-			ctx->current_codec->extra_cap_size(ctx, pix_fmt);
+		pix_fmt_mp->plane_fmt[0].sizeimage +=
+			ctx->current_codec->extra_cap_size(ctx, pix_fmt_mp);
 
 	return 0;
 }
@@ -260,21 +261,21 @@ static int cedrus_try_fmt_vid_cap_p(struct cedrus_ctx *ctx,
 static int cedrus_try_fmt_vid_cap(struct file *file, void *priv,
 				  struct v4l2_format *f)
 {
-	return cedrus_try_fmt_vid_cap_p(cedrus_file2ctx(file), &f->fmt.pix);
+	return cedrus_try_fmt_vid_cap_p(cedrus_file2ctx(file), &f->fmt.pix_mp);
 }
 
 static int cedrus_try_fmt_vid_out_p(struct cedrus_ctx *ctx,
-				    struct v4l2_pix_format *pix_fmt)
+				    struct v4l2_pix_format_mplane *pix_fmt_mp)
 {
 	struct cedrus_format *fmt =
-		cedrus_find_format(ctx, pix_fmt->pixelformat,
+		cedrus_find_format(ctx, pix_fmt_mp->pixelformat,
 				   CEDRUS_DECODE_SRC);
 
 	if (!fmt)
 		return -EINVAL;
 
-	pix_fmt->pixelformat = fmt->pixelformat;
-	cedrus_prepare_format(pix_fmt);
+	pix_fmt_mp->pixelformat = fmt->pixelformat;
+	cedrus_prepare_format(pix_fmt_mp);
 
 	return 0;
 }
@@ -282,7 +283,7 @@ static int cedrus_try_fmt_vid_out_p(struct cedrus_ctx *ctx,
 static int cedrus_try_fmt_vid_out(struct file *file, void *priv,
 				  struct v4l2_format *f)
 {
-	return cedrus_try_fmt_vid_out_p(cedrus_file2ctx(file), &f->fmt.pix);
+	return cedrus_try_fmt_vid_out_p(cedrus_file2ctx(file), &f->fmt.pix_mp);
 }
 
 static int cedrus_s_fmt_vid_cap(struct file *file, void *priv,
@@ -300,7 +301,7 @@ static int cedrus_s_fmt_vid_cap(struct file *file, void *priv,
 	if (ret)
 		return ret;
 
-	ctx->dst_fmt = f->fmt.pix;
+	ctx->dst_fmt = f->fmt.pix_mp;
 
 	return 0;
 }
@@ -312,16 +313,16 @@ void cedrus_reset_cap_format(struct cedrus_ctx *ctx)
 }
 
 static int cedrus_s_fmt_vid_out_p(struct cedrus_ctx *ctx,
-				  struct v4l2_pix_format *pix_fmt)
+				  struct v4l2_pix_format_mplane *pix_fmt_mp)
 {
 	struct vb2_queue *vq;
 	int ret;
 
-	ret = cedrus_try_fmt_vid_out_p(ctx, pix_fmt);
+	ret = cedrus_try_fmt_vid_out_p(ctx, pix_fmt_mp);
 	if (ret)
 		return ret;
 
-	ctx->src_fmt = *pix_fmt;
+	ctx->src_fmt = *pix_fmt_mp;
 
 	vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, V4L2_BUF_TYPE_VIDEO_OUTPUT);
 
@@ -353,10 +354,10 @@ static int cedrus_s_fmt_vid_out_p(struct cedrus_ctx *ctx,
 	}
 
 	/* Propagate format information to capture. */
-	ctx->dst_fmt.colorspace = pix_fmt->colorspace;
-	ctx->dst_fmt.xfer_func = pix_fmt->xfer_func;
-	ctx->dst_fmt.ycbcr_enc = pix_fmt->ycbcr_enc;
-	ctx->dst_fmt.quantization = pix_fmt->quantization;
+	ctx->dst_fmt.colorspace = pix_fmt_mp->colorspace;
+	ctx->dst_fmt.xfer_func = pix_fmt_mp->xfer_func;
+	ctx->dst_fmt.ycbcr_enc = pix_fmt_mp->ycbcr_enc;
+	ctx->dst_fmt.quantization = pix_fmt_mp->quantization;
 	cedrus_reset_cap_format(ctx);
 
 	return 0;
@@ -382,7 +383,7 @@ static int cedrus_s_fmt_vid_out(struct file *file, void *priv,
 	 * as the pixelformat remains. Can't be done if streaming.
 	 */
 	if (vb2_is_streaming(vq) || (vb2_is_busy(vq) &&
-	    f->fmt.pix.pixelformat != ctx->src_fmt.pixelformat))
+	    f->fmt.pix_mp.pixelformat != ctx->src_fmt.pixelformat))
 		return -EBUSY;
 	/*
 	 * Since format change on the OUTPUT queue will reset
@@ -390,25 +391,25 @@ static int cedrus_s_fmt_vid_out(struct file *file, void *priv,
 	 * when the CAPTURE queue has buffers allocated.
 	 */
 	peer_vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx,
-				  V4L2_BUF_TYPE_VIDEO_CAPTURE);
+				  V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE);
 	if (vb2_is_busy(peer_vq))
 		return -EBUSY;
 
-	return cedrus_s_fmt_vid_out_p(cedrus_file2ctx(file), &f->fmt.pix);
+	return cedrus_s_fmt_vid_out_p(cedrus_file2ctx(file), &f->fmt.pix_mp);
 }
 
 const struct v4l2_ioctl_ops cedrus_ioctl_ops = {
 	.vidioc_querycap		= cedrus_querycap,
 
 	.vidioc_enum_fmt_vid_cap	= cedrus_enum_fmt_vid_cap,
-	.vidioc_g_fmt_vid_cap		= cedrus_g_fmt_vid_cap,
-	.vidioc_try_fmt_vid_cap		= cedrus_try_fmt_vid_cap,
-	.vidioc_s_fmt_vid_cap		= cedrus_s_fmt_vid_cap,
+	.vidioc_g_fmt_vid_cap_mplane	= cedrus_g_fmt_vid_cap,
+	.vidioc_try_fmt_vid_cap_mplane	= cedrus_try_fmt_vid_cap,
+	.vidioc_s_fmt_vid_cap_mplane	= cedrus_s_fmt_vid_cap,
 
 	.vidioc_enum_fmt_vid_out	= cedrus_enum_fmt_vid_out,
-	.vidioc_g_fmt_vid_out		= cedrus_g_fmt_vid_out,
-	.vidioc_try_fmt_vid_out		= cedrus_try_fmt_vid_out,
-	.vidioc_s_fmt_vid_out		= cedrus_s_fmt_vid_out,
+	.vidioc_g_fmt_vid_out_mplane	= cedrus_g_fmt_vid_out,
+	.vidioc_try_fmt_vid_out_mplane	= cedrus_try_fmt_vid_out,
+	.vidioc_s_fmt_vid_out_mplane	= cedrus_s_fmt_vid_out,
 
 	.vidioc_reqbufs			= v4l2_m2m_ioctl_reqbufs,
 	.vidioc_querybuf		= v4l2_m2m_ioctl_querybuf,
@@ -433,18 +434,18 @@ static int cedrus_queue_setup(struct vb2_queue *vq, unsigned int *nbufs,
 			      struct device *alloc_devs[])
 {
 	struct cedrus_ctx *ctx = vb2_get_drv_priv(vq);
-	struct v4l2_pix_format *pix_fmt;
+	struct v4l2_pix_format_mplane *pix_fmt_mp;
 
 	if (V4L2_TYPE_IS_OUTPUT(vq->type))
-		pix_fmt = &ctx->src_fmt;
+		pix_fmt_mp = &ctx->src_fmt;
 	else
-		pix_fmt = &ctx->dst_fmt;
+		pix_fmt_mp = &ctx->dst_fmt;
 
 	if (*nplanes) {
-		if (sizes[0] < pix_fmt->sizeimage)
+		if (sizes[0] < pix_fmt_mp->plane_fmt[0].sizeimage)
 			return -EINVAL;
 	} else {
-		sizes[0] = pix_fmt->sizeimage;
+		sizes[0] = pix_fmt_mp->plane_fmt[0].sizeimage;
 		*nplanes = 1;
 	}
 
@@ -483,14 +484,14 @@ static int cedrus_buf_prepare(struct vb2_buffer *vb)
 {
 	struct vb2_queue *vq = vb->vb2_queue;
 	struct cedrus_ctx *ctx = vb2_get_drv_priv(vq);
-	struct v4l2_pix_format *pix_fmt;
+	struct v4l2_pix_format_mplane *pix_fmt_mp;
 
 	if (V4L2_TYPE_IS_OUTPUT(vq->type))
-		pix_fmt = &ctx->src_fmt;
+		pix_fmt_mp = &ctx->src_fmt;
 	else
-		pix_fmt = &ctx->dst_fmt;
+		pix_fmt_mp = &ctx->dst_fmt;
 
-	if (vb2_plane_size(vb, 0) < pix_fmt->sizeimage)
+	if (vb2_plane_size(vb, 0) < pix_fmt_mp->plane_fmt[0].sizeimage)
 		return -EINVAL;
 
 	/*
@@ -499,7 +500,7 @@ static int cedrus_buf_prepare(struct vb2_buffer *vb)
 	 * it to buffer length).
 	 */
 	if (V4L2_TYPE_IS_CAPTURE(vq->type))
-		vb2_set_plane_payload(vb, 0, pix_fmt->sizeimage);
+		vb2_set_plane_payload(vb, 0, pix_fmt_mp->plane_fmt[0].sizeimage);
 
 	return 0;
 }
@@ -580,7 +581,7 @@ int cedrus_queue_init(void *priv, struct vb2_queue *src_vq,
 	struct cedrus_ctx *ctx = priv;
 	int ret;
 
-	src_vq->type = V4L2_BUF_TYPE_VIDEO_OUTPUT;
+	src_vq->type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE;
 	src_vq->io_modes = VB2_MMAP | VB2_DMABUF;
 	src_vq->drv_priv = ctx;
 	src_vq->buf_struct_size = sizeof(struct cedrus_buffer);
@@ -596,7 +597,7 @@ int cedrus_queue_init(void *priv, struct vb2_queue *src_vq,
 	if (ret)
 		return ret;
 
-	dst_vq->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
+	dst_vq->type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
 	dst_vq->io_modes = VB2_MMAP | VB2_DMABUF;
 	dst_vq->drv_priv = ctx;
 	dst_vq->buf_struct_size = sizeof(struct cedrus_buffer);
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_video.h b/drivers/staging/media/sunxi/cedrus/cedrus_video.h
index 8e1afc16a6a1..9e8a6dfad8df 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_video.h
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_video.h
@@ -26,7 +26,7 @@ extern const struct v4l2_ioctl_ops cedrus_ioctl_ops;
 
 int cedrus_queue_init(void *priv, struct vb2_queue *src_vq,
 		      struct vb2_queue *dst_vq);
-void cedrus_prepare_format(struct v4l2_pix_format *pix_fmt);
+void cedrus_prepare_format(struct v4l2_pix_format_mplane *pix_fmt_mp);
 void cedrus_reset_cap_format(struct cedrus_ctx *ctx);
 void cedrus_reset_out_format(struct cedrus_ctx *ctx);
 
-- 
2.38.1.584.g0f3c55d4c2-goog


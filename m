Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA2D68B4F0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 05:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjBFEfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 23:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjBFEfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 23:35:30 -0500
Received: from kozue.soulik.info (kozue.soulik.info [IPv6:2001:19f0:7000:8404:5054:ff:fe75:428f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8E81B566;
        Sun,  5 Feb 2023 20:35:05 -0800 (PST)
Received: from misaki.sumomo.pri (unknown [192.168.0.134])
        by kozue.soulik.info (Postfix) with ESMTPA id 155A2101CD2;
        Mon,  6 Feb 2023 13:34:58 +0900 (JST)
From:   ayaka <ayaka@soulik.info>
To:     linux-media@vger.kernel.org
Cc:     randy.li@synaptics.com, Brian.Starkey@arm.com,
        boris.brezillon@collabora.com, frkoenig@chromium.org,
        hans.verkuil@cisco.com, hiroh@chromium.org, hverkuil@xs4all.nl,
        kernel@collabora.com, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org, mchehab@kernel.org,
        narmstrong@baylibre.com, nicolas@ndufresne.ca, sakari.ailus@iki.fi,
        stanimir.varbanov@linaro.org, tfiga@chromium.org,
        Helen Koike <helen.koike@collabora.com>,
        Randy Li <ayaka@soulik.info>
Subject: [PATCH v7 9/9] media: vimc: Convert to v4l2_ext_pix_format
Date:   Mon,  6 Feb 2023 12:33:08 +0800
Message-Id: <20230206043308.28365-10-ayaka@soulik.info>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230206043308.28365-1-ayaka@soulik.info>
References: <20230206043308.28365-1-ayaka@soulik.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Helen Koike <helen.koike@collabora.com>

Simplify Multi/Single planer API handling by converting to v4l2_ext_pix_format.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Helen Koike <helen.koike@collabora.com>
Signed-off-by: Randy Li <ayaka@soulik.info>
---
Changes in v7:
- Refresh and rebase

Changes in v6:
- Update with new format and buffer structs

Changes in v4:
- Update with new format and buffer structs
- Rebased on top of media/master (post 5.8-rc1)

Changes in v3:
- Rebased on top of media/master (post 5.4-rc1)

Changes in v2:
- New patch
---
 .../media/test-drivers/vimc/vimc-capture.c    | 115 ++++++++++--------
 drivers/media/test-drivers/vimc/vimc-common.c |   6 +-
 drivers/media/test-drivers/vimc/vimc-common.h |   2 +-
 3 files changed, 68 insertions(+), 55 deletions(-)

diff --git a/drivers/media/test-drivers/vimc/vimc-capture.c b/drivers/media/test-drivers/vimc/vimc-capture.c
index 246d90d1f5ae..5429398bea8d 100644
--- a/drivers/media/test-drivers/vimc/vimc-capture.c
+++ b/drivers/media/test-drivers/vimc/vimc-capture.c
@@ -16,7 +16,7 @@
 struct vimc_capture_device {
 	struct vimc_ent_device ved;
 	struct video_device vdev;
-	struct v4l2_pix_format format;
+	struct v4l2_ext_pix_format format;
 	struct vb2_queue queue;
 	struct list_head buf_list;
 	/*
@@ -33,7 +33,8 @@ struct vimc_capture_device {
 	struct media_pad pad;
 };
 
-static const struct v4l2_pix_format fmt_default = {
+static const struct v4l2_ext_pix_format fmt_default = {
+	.type = V4L2_BUF_TYPE_VIDEO_CAPTURE,
 	.width = 640,
 	.height = 480,
 	.pixelformat = V4L2_PIX_FMT_RGB24,
@@ -53,7 +54,7 @@ struct vimc_capture_buffer {
 };
 
 static int vimc_capture_querycap(struct file *file, void *priv,
-			     struct v4l2_capability *cap)
+				 struct v4l2_capability *cap)
 {
 	strscpy(cap->driver, VIMC_PDEV_NAME, sizeof(cap->driver));
 	strscpy(cap->card, KBUILD_MODNAME, sizeof(cap->card));
@@ -64,28 +65,28 @@ static int vimc_capture_querycap(struct file *file, void *priv,
 }
 
 static void vimc_capture_get_format(struct vimc_ent_device *ved,
-				struct v4l2_pix_format *fmt)
+				    struct v4l2_ext_pix_format *fmt)
 {
-	struct vimc_capture_device *vcapture = container_of(ved, struct vimc_capture_device,
-						    ved);
+	struct vimc_capture_device *vcapture =
+	    container_of(ved, struct vimc_capture_device,
+			 ved);
 
 	*fmt = vcapture->format;
 }
 
 static int vimc_capture_g_fmt_vid_cap(struct file *file, void *priv,
-				  struct v4l2_format *f)
+				      struct v4l2_ext_pix_format *f)
 {
 	struct vimc_capture_device *vcapture = video_drvdata(file);
 
-	f->fmt.pix = vcapture->format;
+	*f = vcapture->format;
 
 	return 0;
 }
 
 static int vimc_capture_try_fmt_vid_cap(struct file *file, void *priv,
-				    struct v4l2_format *f)
+					struct v4l2_ext_pix_format *format)
 {
-	struct v4l2_pix_format *format = &f->fmt.pix;
 	const struct vimc_pix_map *vpix;
 
 	format->width = clamp_t(u32, format->width, VIMC_FRAME_MIN_WIDTH,
@@ -100,8 +101,10 @@ static int vimc_capture_try_fmt_vid_cap(struct file *file, void *priv,
 		vpix = vimc_pix_map_by_pixelformat(format->pixelformat);
 	}
 	/* TODO: Add support for custom bytesperline values */
-	format->bytesperline = format->width * vpix->bpp;
-	format->sizeimage = format->bytesperline * format->height;
+	memset(format->plane_fmt, 0, sizeof(format->plane_fmt));
+	format->plane_fmt[0].bytesperline = format->width * vpix->bpp;
+	format->plane_fmt[0].sizeimage = format->plane_fmt[0].bytesperline *
+	    format->height;
 
 	if (format->field == V4L2_FIELD_ANY)
 		format->field = fmt_default.field;
@@ -115,7 +118,7 @@ static int vimc_capture_try_fmt_vid_cap(struct file *file, void *priv,
 }
 
 static int vimc_capture_s_fmt_vid_cap(struct file *file, void *priv,
-				  struct v4l2_format *f)
+				      struct v4l2_ext_pix_format *f)
 {
 	struct vimc_capture_device *vcapture = video_drvdata(file);
 	int ret;
@@ -137,18 +140,16 @@ static int vimc_capture_s_fmt_vid_cap(struct file *file, void *priv,
 		vcapture->format.quantization, vcapture->format.xfer_func,
 		vcapture->format.ycbcr_enc,
 		/* new */
-		f->fmt.pix.width, f->fmt.pix.height,
-		f->fmt.pix.pixelformat,	f->fmt.pix.colorspace,
-		f->fmt.pix.quantization, f->fmt.pix.xfer_func,
-		f->fmt.pix.ycbcr_enc);
+		f->width, f->height, f->pixelformat, f->colorspace,
+		f->quantization, f->xfer_func, f->ycbcr_enc);
 
-	vcapture->format = f->fmt.pix;
+	vcapture->format = *f;
 
 	return 0;
 }
 
 static int vimc_capture_enum_fmt_vid_cap(struct file *file, void *priv,
-				     struct v4l2_fmtdesc *f)
+					 struct v4l2_fmtdesc *f)
 {
 	const struct vimc_pix_map *vpix;
 
@@ -170,7 +171,7 @@ static int vimc_capture_enum_fmt_vid_cap(struct file *file, void *priv,
 }
 
 static int vimc_capture_enum_framesizes(struct file *file, void *fh,
-				    struct v4l2_frmsizeenum *fsize)
+					struct v4l2_frmsizeenum *fsize)
 {
 	const struct vimc_pix_map *vpix;
 
@@ -206,9 +207,9 @@ static const struct v4l2_file_operations vimc_capture_fops = {
 static const struct v4l2_ioctl_ops vimc_capture_ioctl_ops = {
 	.vidioc_querycap = vimc_capture_querycap,
 
-	.vidioc_g_fmt_vid_cap = vimc_capture_g_fmt_vid_cap,
-	.vidioc_s_fmt_vid_cap = vimc_capture_s_fmt_vid_cap,
-	.vidioc_try_fmt_vid_cap = vimc_capture_try_fmt_vid_cap,
+	.vidioc_g_ext_pix_fmt_vid_cap = vimc_capture_g_fmt_vid_cap,
+	.vidioc_s_ext_pix_fmt_vid_cap = vimc_capture_s_fmt_vid_cap,
+	.vidioc_try_ext_pix_fmt_vid_cap = vimc_capture_try_fmt_vid_cap,
 	.vidioc_enum_fmt_vid_cap = vimc_capture_enum_fmt_vid_cap,
 	.vidioc_enum_framesizes = vimc_capture_enum_framesizes,
 
@@ -225,8 +226,9 @@ static const struct v4l2_ioctl_ops vimc_capture_ioctl_ops = {
 	.vidioc_streamoff = vb2_ioctl_streamoff,
 };
 
-static void vimc_capture_return_all_buffers(struct vimc_capture_device *vcapture,
-					enum vb2_buffer_state state)
+static void vimc_capture_return_all_buffers(struct vimc_capture_device
+					    *vcapture,
+					    enum vb2_buffer_state state)
 {
 	struct vimc_capture_buffer *vbuf, *node;
 
@@ -240,7 +242,8 @@ static void vimc_capture_return_all_buffers(struct vimc_capture_device *vcapture
 	spin_unlock(&vcapture->qlock);
 }
 
-static int vimc_capture_start_streaming(struct vb2_queue *vq, unsigned int count)
+static int vimc_capture_start_streaming(struct vb2_queue *vq,
+					unsigned int count)
 {
 	struct vimc_capture_device *vcapture = vb2_get_drv_priv(vq);
 	int ret;
@@ -248,7 +251,9 @@ static int vimc_capture_start_streaming(struct vb2_queue *vq, unsigned int count
 	vcapture->sequence = 0;
 
 	/* Start the media pipeline */
-	ret = video_device_pipeline_start(&vcapture->vdev, &vcapture->stream.pipe);
+	ret =
+	    video_device_pipeline_start(&vcapture->vdev,
+					&vcapture->stream.pipe);
 	if (ret) {
 		vimc_capture_return_all_buffers(vcapture, VB2_BUF_STATE_QUEUED);
 		return ret;
@@ -283,27 +288,31 @@ static void vimc_capture_stop_streaming(struct vb2_queue *vq)
 
 static void vimc_capture_buf_queue(struct vb2_buffer *vb2_buf)
 {
-	struct vimc_capture_device *vcapture = vb2_get_drv_priv(vb2_buf->vb2_queue);
+	struct vimc_capture_device *vcapture =
+	    vb2_get_drv_priv(vb2_buf->vb2_queue);
 	struct vimc_capture_buffer *buf = container_of(vb2_buf,
-						   struct vimc_capture_buffer,
-						   vb2.vb2_buf);
+						       struct
+						       vimc_capture_buffer,
+						       vb2.vb2_buf);
 
 	spin_lock(&vcapture->qlock);
 	list_add_tail(&buf->list, &vcapture->buf_list);
 	spin_unlock(&vcapture->qlock);
 }
 
-static int vimc_capture_queue_setup(struct vb2_queue *vq, unsigned int *nbuffers,
-				unsigned int *nplanes, unsigned int sizes[],
-				struct device *alloc_devs[])
+static int vimc_capture_queue_setup(struct vb2_queue *vq,
+				    unsigned int *nbuffers,
+				    unsigned int *nplanes, unsigned int sizes[],
+				    struct device *alloc_devs[])
 {
 	struct vimc_capture_device *vcapture = vb2_get_drv_priv(vq);
 
 	if (*nplanes)
-		return sizes[0] < vcapture->format.sizeimage ? -EINVAL : 0;
+		return sizes[0] <
+		    vcapture->format.plane_fmt[0].sizeimage ? -EINVAL : 0;
 	/* We don't support multiplanes for now */
 	*nplanes = 1;
-	sizes[0] = vcapture->format.sizeimage;
+	sizes[0] = vcapture->format.plane_fmt[0].sizeimage;
 
 	return 0;
 }
@@ -311,7 +320,7 @@ static int vimc_capture_queue_setup(struct vb2_queue *vq, unsigned int *nbuffers
 static int vimc_capture_buffer_prepare(struct vb2_buffer *vb)
 {
 	struct vimc_capture_device *vcapture = vb2_get_drv_priv(vb->vb2_queue);
-	unsigned long size = vcapture->format.sizeimage;
+	unsigned long size = vcapture->format.plane_fmt[0].sizeimage;
 
 	if (vb2_plane_size(vb, 0) < size) {
 		dev_err(vcapture->ved.dev, "%s: buffer too small (%lu < %lu)\n",
@@ -342,7 +351,7 @@ static const struct media_entity_operations vimc_capture_mops = {
 static void vimc_capture_release(struct vimc_ent_device *ved)
 {
 	struct vimc_capture_device *vcapture =
-		container_of(ved, struct vimc_capture_device, ved);
+	    container_of(ved, struct vimc_capture_device, ved);
 
 	media_entity_cleanup(vcapture->ved.ent);
 	kfree(vcapture);
@@ -351,16 +360,17 @@ static void vimc_capture_release(struct vimc_ent_device *ved)
 static void vimc_capture_unregister(struct vimc_ent_device *ved)
 {
 	struct vimc_capture_device *vcapture =
-		container_of(ved, struct vimc_capture_device, ved);
+	    container_of(ved, struct vimc_capture_device, ved);
 
 	vb2_video_unregister_device(&vcapture->vdev);
 }
 
 static void *vimc_capture_process_frame(struct vimc_ent_device *ved,
-				    const void *frame)
+					const void *frame)
 {
-	struct vimc_capture_device *vcapture = container_of(ved, struct vimc_capture_device,
-						    ved);
+	struct vimc_capture_device *vcapture =
+	    container_of(ved, struct vimc_capture_device,
+			 ved);
 	struct vimc_capture_buffer *vimc_buf;
 	void *vbuf;
 
@@ -386,11 +396,11 @@ static void *vimc_capture_process_frame(struct vimc_ent_device *ved,
 
 	vbuf = vb2_plane_vaddr(&vimc_buf->vb2.vb2_buf, 0);
 
-	memcpy(vbuf, frame, vcapture->format.sizeimage);
+	memcpy(vbuf, frame, vcapture->format.plane_fmt[0].sizeimage);
 
 	/* Set it as ready */
 	vb2_set_plane_payload(&vimc_buf->vb2.vb2_buf, 0,
-			      vcapture->format.sizeimage);
+			      vcapture->format.plane_fmt[0].sizeimage);
 	vb2_set_pixelformat(&vimc_buf->vb2.vb2_buf,
 			    vcapture->format.pixelformat);
 	vb2_buffer_done(&vimc_buf->vb2.vb2_buf, VB2_BUF_STATE_DONE);
@@ -398,7 +408,7 @@ static void *vimc_capture_process_frame(struct vimc_ent_device *ved,
 }
 
 static struct vimc_ent_device *vimc_capture_add(struct vimc_device *vimc,
-					    const char *vcfg_name)
+						const char *vcfg_name)
 {
 	struct v4l2_device *v4l2_dev = &vimc->v4l2_dev;
 	const struct vimc_pix_map *vpix;
@@ -416,8 +426,7 @@ static struct vimc_ent_device *vimc_capture_add(struct vimc_device *vimc,
 	vcapture->vdev.entity.name = vcfg_name;
 	vcapture->vdev.entity.function = MEDIA_ENT_F_IO_V4L;
 	vcapture->pad.flags = MEDIA_PAD_FL_SINK;
-	ret = media_entity_pads_init(&vcapture->vdev.entity,
-				     1, &vcapture->pad);
+	ret = media_entity_pads_init(&vcapture->vdev.entity, 1, &vcapture->pad);
 	if (ret)
 		goto err_free_vcapture;
 
@@ -434,7 +443,7 @@ static struct vimc_ent_device *vimc_capture_add(struct vimc_device *vimc,
 	q->buf_struct_size = sizeof(struct vimc_capture_buffer);
 	q->ops = &vimc_capture_qops;
 	q->mem_ops = vimc_allocator == VIMC_ALLOCATOR_DMA_CONTIG
-		   ? &vb2_dma_contig_memops : &vb2_vmalloc_memops;
+	    ? &vb2_dma_contig_memops : &vb2_vmalloc_memops;
 	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
 	q->min_buffers_needed = 2;
 	q->lock = &vcapture->lock;
@@ -454,9 +463,13 @@ static struct vimc_ent_device *vimc_capture_add(struct vimc_device *vimc,
 	/* Set default frame format */
 	vcapture->format = fmt_default;
 	vpix = vimc_pix_map_by_pixelformat(vcapture->format.pixelformat);
-	vcapture->format.bytesperline = vcapture->format.width * vpix->bpp;
-	vcapture->format.sizeimage = vcapture->format.bytesperline *
-				 vcapture->format.height;
+	memset(vcapture->format.plane_fmt, 0,
+	       sizeof(vcapture->format.plane_fmt));
+	vcapture->format.plane_fmt[0].bytesperline =
+	    vcapture->format.width * vpix->bpp;
+	vcapture->format.plane_fmt[0].sizeimage =
+	    vcapture->format.plane_fmt[0].bytesperline *
+	    vcapture->format.height;
 
 	/* Fill the vimc_ent_device struct */
 	vcapture->ved.ent = &vcapture->vdev.entity;
@@ -467,7 +480,7 @@ static struct vimc_ent_device *vimc_capture_add(struct vimc_device *vimc,
 	/* Initialize the video_device struct */
 	vdev = &vcapture->vdev;
 	vdev->device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_STREAMING
-			  | V4L2_CAP_IO_MC;
+	    | V4L2_CAP_IO_MC;
 	vdev->entity.ops = &vimc_capture_mops;
 	vdev->release = video_device_release_empty;
 	vdev->fops = &vimc_capture_fops;
diff --git a/drivers/media/test-drivers/vimc/vimc-common.c b/drivers/media/test-drivers/vimc/vimc-common.c
index 7b27153c0728..8bbf80f2acb9 100644
--- a/drivers/media/test-drivers/vimc/vimc-common.c
+++ b/drivers/media/test-drivers/vimc/vimc-common.c
@@ -236,7 +236,7 @@ const struct vimc_pix_map *vimc_pix_map_by_pixelformat(u32 pixelformat)
 }
 
 static int vimc_get_pix_format(struct media_pad *pad,
-			       struct v4l2_pix_format *fmt)
+			       struct v4l2_ext_pix_format *fmt)
 {
 	if (is_media_entity_v4l2_subdev(pad->entity)) {
 		struct v4l2_subdev *sd =
@@ -252,7 +252,7 @@ static int vimc_get_pix_format(struct media_pad *pad,
 		if (ret)
 			return ret;
 
-		v4l2_fill_pix_format(fmt, &sd_fmt.format);
+		v4l2_fill_ext_pix_format_from_mbus(fmt, &sd_fmt.format);
 		pix_map = vimc_pix_map_by_code(sd_fmt.format.code);
 		fmt->pixelformat = pix_map->pixelformat;
 	} else if (is_media_entity_v4l2_video_device(pad->entity)) {
@@ -274,7 +274,7 @@ static int vimc_get_pix_format(struct media_pad *pad,
 
 int vimc_vdev_link_validate(struct media_link *link)
 {
-	struct v4l2_pix_format source_fmt, sink_fmt;
+	struct v4l2_ext_pix_format source_fmt, sink_fmt;
 	int ret;
 
 	ret = vimc_get_pix_format(link->source, &source_fmt);
diff --git a/drivers/media/test-drivers/vimc/vimc-common.h b/drivers/media/test-drivers/vimc/vimc-common.h
index 7641a101a728..f29429df10dd 100644
--- a/drivers/media/test-drivers/vimc/vimc-common.h
+++ b/drivers/media/test-drivers/vimc/vimc-common.h
@@ -111,7 +111,7 @@ struct vimc_ent_device {
 	void * (*process_frame)(struct vimc_ent_device *ved,
 				const void *frame);
 	void (*vdev_get_format)(struct vimc_ent_device *ved,
-			      struct v4l2_pix_format *fmt);
+				struct v4l2_ext_pix_format *fmt);
 };
 
 /**
-- 
2.17.1


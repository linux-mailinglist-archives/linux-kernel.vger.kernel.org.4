Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E75662F4CB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 13:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241312AbiKRMb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 07:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241645AbiKRMbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 07:31:47 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41385C3C;
        Fri, 18 Nov 2022 04:31:42 -0800 (PST)
Received: from localhost (89-26-75-29.goll.dyn.salzburg-online.at [89.26.75.29])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A08356602AB2;
        Fri, 18 Nov 2022 12:31:40 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668774701;
        bh=Pax55x9tLoyREMXNbrKw03DdkCdupX5Q1Mxqi9fmmXA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m6nY808TO0OO6XdQIgPjTdUOQMvbMJ34jTMikJQY7fAQ5VGvgzQ1LrhuMen323Z4q
         AHXb3+bH13atcP9K4bCVlJZLDEVOrzoP944NHfAvVU15m4XcIv8ygcmSSPOVsOyvoE
         jVHTvz5oXXXqU2tL/4bSlu10kfN0jbQi+feMdxxBLbkrPNEnSDc8Z3DTzZ0wql++so
         Jm+1ixiBWME2chI3WAAWqbZQXzmlnW+r04zUxaZJM0MFKiPo6sqLsboy3oikMGEuOB
         zmsiS9yyFM+CZA41M03A6PuTW83MKj64YXEZ8CtkFcWM3hyYxV4toVz6naplLd80XO
         0Tp2h8B1+/LVA==
Date:   Fri, 18 Nov 2022 13:31:37 +0100
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     hverkuil@xs4all.nl
Cc:     kernel@collabora.com, nas.chung@chipsnmedia.com,
        linux-media@vger.kernel.org, ezequiel@vanguardiasur.com.ar,
        linux-kernel@vger.kernel.org, nicolas.dufresne@collabora.com,
        p.zabel@pengutronix.de, dafna@fastmail.com
Subject: Re: [PATCH v10 4/7] media: chips-media: wave5: Add the v4l2 layer
Message-ID: <20221118123137.dsjnb6ccuivrgiyx@basti-XPS-13-9310>
References: <20221022000506.221933-1-sebastian.fricke@collabora.com>
 <20221022000506.221933-5-sebastian.fricke@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20221022000506.221933-5-sebastian.fricke@collabora.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Hans,

I have a question below about the best way forward with an issue found
in the STREAMON routine. (@wave5_vpu_dec_start_streaming_open &
@wave5_vpu_dec_start_streaming_seek)

On 22.10.2022 02:05, Sebastian Fricke wrote:
>From: Nas Chung <nas.chung@chipsnmedia.com>
>
>Add the decoder and encoder implementing the v4l2
>API. This patch also adds the Makefile and the VIDEO_WAVE_VPU config
>
>Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
>Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
>Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
>Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
>---
> drivers/media/platform/chips-media/Kconfig    |    1 +
> drivers/media/platform/chips-media/Makefile   |    1 +
> .../media/platform/chips-media/wave5/Kconfig  |   12 +
> .../media/platform/chips-media/wave5/Makefile |   10 +
> .../platform/chips-media/wave5/wave5-helper.c |  175 ++
> .../platform/chips-media/wave5/wave5-helper.h |   28 +
> .../chips-media/wave5/wave5-vpu-dec.c         | 1399 ++++++++++++++++
> .../chips-media/wave5/wave5-vpu-enc.c         | 1454 +++++++++++++++++
> .../platform/chips-media/wave5/wave5-vpu.c    |  362 ++++
> .../platform/chips-media/wave5/wave5-vpu.h    |   72 +
> 10 files changed, 3514 insertions(+)
> create mode 100644 drivers/media/platform/chips-media/wave5/Kconfig
> create mode 100644 drivers/media/platform/chips-media/wave5/Makefile
> create mode 100644 drivers/media/platform/chips-media/wave5/wave5-helper.c
> create mode 100644 drivers/media/platform/chips-media/wave5/wave5-helper.h
> create mode 100644 drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> create mode 100644 drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> create mode 100644 drivers/media/platform/chips-media/wave5/wave5-vpu.c
> create mode 100644 drivers/media/platform/chips-media/wave5/wave5-vpu.h
>
>diff --git a/drivers/media/platform/chips-media/Kconfig b/drivers/media/platform/chips-media/Kconfig
>index f87a0d693df7..ad350eb6b1fc 100644
>--- a/drivers/media/platform/chips-media/Kconfig
>+++ b/drivers/media/platform/chips-media/Kconfig
>@@ -3,3 +3,4 @@
> comment "Chips&Media media platform drivers"
>
> source "drivers/media/platform/chips-media/coda/Kconfig"
>+source "drivers/media/platform/chips-media/wave5/Kconfig"
>diff --git a/drivers/media/platform/chips-media/Makefile b/drivers/media/platform/chips-media/Makefile
>index 5ee693f651c1..6b5d99de8b54 100644
>--- a/drivers/media/platform/chips-media/Makefile
>+++ b/drivers/media/platform/chips-media/Makefile
>@@ -1,3 +1,4 @@
> # SPDX-License-Identifier: GPL-2.0-only
>
> obj-y += coda/
>+obj-y += wave5/
>diff --git a/drivers/media/platform/chips-media/wave5/Kconfig b/drivers/media/platform/chips-media/wave5/Kconfig
>new file mode 100644
>index 000000000000..a3b949356cd5
>--- /dev/null
>+++ b/drivers/media/platform/chips-media/wave5/Kconfig
>@@ -0,0 +1,12 @@
>+# SPDX-License-Identifier: GPL-2.0
>+config VIDEO_WAVE_VPU
>+	tristate "Chips&Media Wave Codec Driver"
>+	depends on VIDEO_DEV
>+	select VIDEOBUF2_DMA_CONTIG
>+	select VIDEOBUF2_VMALLOC
>+	select V4L2_MEM2MEM_DEV
>+	help
>+	  Chips&Media stateful encoder and decoder driver.
>+	  The driver supports HEVC and H264 formats.
>+	  To compile this driver as modules, choose M here: the
>+	  modules will be called wave5.
>diff --git a/drivers/media/platform/chips-media/wave5/Makefile b/drivers/media/platform/chips-media/wave5/Makefile
>new file mode 100644
>index 000000000000..3d738a03bd8e
>--- /dev/null
>+++ b/drivers/media/platform/chips-media/wave5/Makefile
>@@ -0,0 +1,10 @@
>+# SPDX-License-Identifier: GPL-2.0
>+
>+obj-$(CONFIG_VIDEO_WAVE_VPU) += wave5.o
>+wave5-objs +=  	wave5-hw.o \
>+		wave5-vpuapi.o \
>+		wave5-vdi.o \
>+		wave5-vpu-dec.o \
>+		wave5-vpu.o \
>+		wave5-vpu-enc.o \
>+		wave5-helper.o
>diff --git a/drivers/media/platform/chips-media/wave5/wave5-helper.c b/drivers/media/platform/chips-media/wave5/wave5-helper.c
>new file mode 100644
>index 000000000000..5e463bd4757f
>--- /dev/null
>+++ b/drivers/media/platform/chips-media/wave5/wave5-helper.c
>@@ -0,0 +1,175 @@
>+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
>+/*
>+ * Wave5 series multi-standard codec IP - decoder interface
>+ *
>+ * Copyright (C) 2021 CHIPS&MEDIA INC
>+ */
>+
>+#include "wave5-helper.h"
>+
>+void wave5_cleanup_instance(struct vpu_instance *inst)
>+{
>+	int i;
>+
>+	for (i = 0; i < inst->dst_buf_count; i++)
>+		wave5_vdi_free_dma_memory(inst->dev, &inst->frame_vbuf[i]);
>+
>+	wave5_vdi_free_dma_memory(inst->dev, &inst->bitstream_vbuf);
>+	v4l2_ctrl_handler_free(&inst->v4l2_ctrl_hdl);
>+	if (inst->v4l2_m2m_dev != NULL)
>+		v4l2_m2m_release(inst->v4l2_m2m_dev);
>+	if (inst->v4l2_fh.vdev != NULL) {
>+		v4l2_fh_del(&inst->v4l2_fh);
>+		v4l2_fh_exit(&inst->v4l2_fh);
>+	}
>+	list_del_init(&inst->list);
>+	kfifo_free(&inst->irq_status);
>+	ida_free(&inst->dev->inst_ida, inst->id);
>+	kfree(inst);
>+}
>+
>+int wave5_vpu_release_device(struct file *filp,
>+			     int (*close_func)(struct vpu_instance *inst, u32 *fail_res),
>+			     char *name)
>+{
>+	struct vpu_instance *inst = wave5_to_vpu_inst(filp->private_data);
>+
>+	v4l2_m2m_ctx_release(inst->v4l2_fh.m2m_ctx);
>+	if (inst->state != VPU_INST_STATE_NONE) {
>+		u32 fail_res;
>+		int retry_count = 10;
>+		int ret;
>+
>+		do {
>+			fail_res = 0;
>+			ret = close_func(inst, &fail_res);
>+			if (ret && ret != -EIO)
>+				break;
>+			if (fail_res != WAVE5_SYSERR_VPU_STILL_RUNNING)
>+				break;
>+			if (!wave5_vpu_wait_interrupt(inst, VPU_DEC_TIMEOUT))
>+				break;
>+		} while (--retry_count);
>+
>+		if (fail_res == WAVE5_SYSERR_VPU_STILL_RUNNING) {
>+			dev_err(inst->dev->dev, "%s close failed, device is still running\n",
>+				 name);
>+			return -EBUSY;
>+		}
>+		if (ret && ret != -EIO) {
>+			dev_err(inst->dev->dev, "%s close, fail: %d\n", name, ret);
>+			return ret;
>+		}
>+	}
>+
>+	wave5_cleanup_instance(inst);
>+
>+	return 0;
>+}
>+
>+int wave5_vpu_queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_vq,
>+			 const struct vb2_ops *ops)
>+{
>+	struct vpu_instance *inst = priv;
>+	int ret;
>+
>+	src_vq->type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE;
>+	src_vq->io_modes = VB2_MMAP | VB2_DMABUF;
>+	src_vq->mem_ops = &vb2_dma_contig_memops;
>+	src_vq->ops = ops;
>+	src_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
>+	src_vq->buf_struct_size = sizeof(struct vpu_buffer);
>+	src_vq->drv_priv = inst;
>+	src_vq->lock = &inst->dev->dev_lock;
>+	src_vq->dev = inst->dev->v4l2_dev.dev;
>+	ret = vb2_queue_init(src_vq);
>+	if (ret)
>+		return ret;
>+
>+	dst_vq->type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
>+	dst_vq->io_modes = VB2_MMAP | VB2_DMABUF;
>+	dst_vq->mem_ops = &vb2_dma_contig_memops;
>+	dst_vq->ops = ops;
>+	dst_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
>+	dst_vq->buf_struct_size = sizeof(struct vpu_buffer);
>+	dst_vq->drv_priv = inst;
>+	dst_vq->lock = &inst->dev->dev_lock;
>+	dst_vq->dev = inst->dev->v4l2_dev.dev;
>+	ret = vb2_queue_init(dst_vq);
>+	if (ret)
>+		return ret;
>+
>+	return 0;
>+}
>+
>+int wave5_vpu_subscribe_event(struct v4l2_fh *fh, const struct v4l2_event_subscription *sub)
>+{
>+	struct vpu_instance *inst = wave5_to_vpu_inst(fh);
>+	bool is_decoder = inst->type == VPU_INST_TYPE_DEC;
>+
>+	dev_dbg(inst->dev->dev, "%s: [%s] type: %d id: %d | flags: %d\n", __func__,
>+		is_decoder ? "decoder" : "encoder", sub->type, sub->id, sub->flags);
>+
>+	switch (sub->type) {
>+	case V4L2_EVENT_EOS:
>+		return v4l2_event_subscribe(fh, sub, 0, NULL);
>+	case V4L2_EVENT_SOURCE_CHANGE:
>+		if (is_decoder)
>+			return v4l2_src_change_event_subscribe(fh, sub);
>+		return -EINVAL;
>+	case V4L2_EVENT_CTRL:
>+		return v4l2_ctrl_subscribe_event(fh, sub);
>+	default:
>+		return -EINVAL;
>+	}
>+}
>+
>+int wave5_vpu_g_fmt_out(struct file *file, void *fh, struct v4l2_format *f)
>+{
>+	struct vpu_instance *inst = wave5_to_vpu_inst(fh);
>+	int i;
>+
>+	f->fmt.pix_mp.width = inst->src_fmt.width;
>+	f->fmt.pix_mp.height = inst->src_fmt.height;
>+	f->fmt.pix_mp.pixelformat = inst->src_fmt.pixelformat;
>+	f->fmt.pix_mp.field = inst->src_fmt.field;
>+	f->fmt.pix_mp.flags = inst->src_fmt.flags;
>+	f->fmt.pix_mp.num_planes = inst->src_fmt.num_planes;
>+	for (i = 0; i < f->fmt.pix_mp.num_planes; i++) {
>+		f->fmt.pix_mp.plane_fmt[i].bytesperline = inst->src_fmt.plane_fmt[i].bytesperline;
>+		f->fmt.pix_mp.plane_fmt[i].sizeimage = inst->src_fmt.plane_fmt[i].sizeimage;
>+	}
>+
>+	f->fmt.pix_mp.colorspace = inst->colorspace;
>+	f->fmt.pix_mp.ycbcr_enc = inst->ycbcr_enc;
>+	f->fmt.pix_mp.hsv_enc = inst->hsv_enc;
>+	f->fmt.pix_mp.quantization = inst->quantization;
>+	f->fmt.pix_mp.xfer_func = inst->xfer_func;
>+
>+	return 0;
>+}
>+
>+const struct vpu_format *wave5_find_vpu_fmt(unsigned int v4l2_pix_fmt,
>+					    const struct vpu_format fmt_list[MAX_FMTS])
>+{
>+	unsigned int index;
>+
>+	for (index = 0; index < MAX_FMTS; index++) {
>+		if (fmt_list[index].v4l2_pix_fmt == v4l2_pix_fmt)
>+			return &fmt_list[index];
>+	}
>+
>+	return NULL;
>+}
>+
>+const struct vpu_format *wave5_find_vpu_fmt_by_idx(unsigned int idx,
>+						   const struct vpu_format fmt_list[MAX_FMTS])
>+{
>+	if (idx >= MAX_FMTS)
>+		return NULL;
>+
>+	if (!fmt_list[idx].v4l2_pix_fmt)
>+		return NULL;
>+
>+	return &fmt_list[idx];
>+}
>diff --git a/drivers/media/platform/chips-media/wave5/wave5-helper.h b/drivers/media/platform/chips-media/wave5/wave5-helper.h
>new file mode 100644
>index 000000000000..d586d624275e
>--- /dev/null
>+++ b/drivers/media/platform/chips-media/wave5/wave5-helper.h
>@@ -0,0 +1,28 @@
>+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
>+/*
>+ * Wave5 series multi-standard codec IP - basic types
>+ *
>+ * Copyright (C) 2021 CHIPS&MEDIA INC
>+ */
>+
>+#ifndef __WAVE_HELPER_H__
>+#define __WAVE_HELPER_H__
>+
>+#include "wave5-vpu.h"
>+
>+#define FMT_TYPES	2
>+#define MAX_FMTS	6
>+
>+void wave5_cleanup_instance(struct vpu_instance *inst);
>+int wave5_vpu_release_device(struct file *filp,
>+			     int (*close_func)(struct vpu_instance *inst, u32 *fail_res),
>+			     char *name);
>+int wave5_vpu_queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_vq,
>+			 const struct vb2_ops *ops);
>+int wave5_vpu_subscribe_event(struct v4l2_fh *fh, const struct v4l2_event_subscription *sub);
>+int wave5_vpu_g_fmt_out(struct file *file, void *fh, struct v4l2_format *f);
>+const struct vpu_format *wave5_find_vpu_fmt(unsigned int v4l2_pix_fmt,
>+					    const struct vpu_format fmt_list[MAX_FMTS]);
>+const struct vpu_format *wave5_find_vpu_fmt_by_idx(unsigned int idx,
>+						   const struct vpu_format fmt_list[MAX_FMTS]);
>+#endif
>diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
>new file mode 100644
>index 000000000000..4c433f3e604b
>--- /dev/null
>+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
>@@ -0,0 +1,1399 @@
>+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
>+/*
>+ * Wave5 series multi-standard codec IP - decoder interface
>+ *
>+ * Copyright (C) 2021 CHIPS&MEDIA INC
>+ */
>+
>+#include "wave5-helper.h"
>+
>+#define VPU_DEC_DEV_NAME "C&M Wave5 VPU decoder"
>+#define VPU_DEC_DRV_NAME "wave5-dec"
>+#define V4L2_CID_VPU_THUMBNAIL_MODE (V4L2_CID_USER_BASE + 0x1001)
>+
>+static const struct vpu_format dec_fmt_list[FMT_TYPES][MAX_FMTS] = {
>+	[VPU_FMT_TYPE_CODEC] = {
>+		{
>+			.v4l2_pix_fmt = V4L2_PIX_FMT_HEVC,
>+			.max_width = 8192,
>+			.min_width = 8,
>+			.max_height = 4320,
>+			.min_height = 8,
>+		},
>+		{
>+			.v4l2_pix_fmt = V4L2_PIX_FMT_H264,
>+			.max_width = 8192,
>+			.min_width = 32,
>+			.max_height = 4320,
>+			.min_height = 32,
>+		},
>+	},
>+	[VPU_FMT_TYPE_RAW] = {
>+		{
>+			.v4l2_pix_fmt = V4L2_PIX_FMT_YUV420,
>+			.max_width = 8192,
>+			.min_width = 8,
>+			.max_height = 4320,
>+			.min_height = 8,
>+		},
>+		{
>+			.v4l2_pix_fmt = V4L2_PIX_FMT_NV12,
>+			.max_width = 8192,
>+			.min_width = 8,
>+			.max_height = 4320,
>+			.min_height = 8,
>+		},
>+		{
>+			.v4l2_pix_fmt = V4L2_PIX_FMT_NV21,
>+			.max_width = 8192,
>+			.min_width = 8,
>+			.max_height = 4320,
>+			.min_height = 8,
>+		},
>+		{
>+			.v4l2_pix_fmt = V4L2_PIX_FMT_YUV420M,
>+			.max_width = 8192,
>+			.min_width = 8,
>+			.max_height = 4320,
>+			.min_height = 8,
>+		},
>+		{
>+			.v4l2_pix_fmt = V4L2_PIX_FMT_NV12M,
>+			.max_width = 8192,
>+			.min_width = 8,
>+			.max_height = 4320,
>+			.min_height = 8,
>+		},
>+		{
>+			.v4l2_pix_fmt = V4L2_PIX_FMT_NV21M,
>+			.max_width = 8192,
>+			.min_width = 8,
>+			.max_height = 4320,
>+			.min_height = 8,
>+		},
>+	}
>+};
>+
>+static enum wave_std wave5_to_vpu_codstd(unsigned int v4l2_pix_fmt)
>+{
>+	switch (v4l2_pix_fmt) {
>+	case V4L2_PIX_FMT_H264:
>+		return W_AVC_DEC;
>+	case V4L2_PIX_FMT_HEVC:
>+		return W_HEVC_DEC;
>+	default:
>+		return STD_UNKNOWN;
>+	}
>+}
>+
>+static void wave5_handle_bitstream_buffer(struct vpu_instance *inst)
>+{
>+	struct v4l2_m2m_buffer *buf, *n;
>+	int ret;
>+
>+	v4l2_m2m_for_each_src_buf_safe(inst->v4l2_fh.m2m_ctx, buf, n) {
>+		struct vb2_v4l2_buffer *vbuf = &buf->vb;
>+		struct vpu_buffer *vpu_buf = wave5_to_vpu_buf(vbuf);
>+		size_t src_size = vb2_get_plane_payload(&vbuf->vb2_buf, 0);
>+		void *src_buf = vb2_plane_vaddr(&vbuf->vb2_buf, 0);
>+		dma_addr_t rd_ptr = 0;
>+		dma_addr_t wr_ptr = 0;
>+		size_t remain_size = 0;
>+		size_t offset;
>+
>+		if (vpu_buf->consumed) {
>+			dev_dbg(inst->dev->dev, "already consumed src buf (%d)\n",
>+				vbuf->vb2_buf.index);
>+			continue;
>+		}
>+
>+		if (!src_buf) {
>+			dev_warn(inst->dev->dev,
>+				 "Acquiring kernel pointer to src buf (%d), fail\n",
>+				 vbuf->vb2_buf.index);
>+			continue;
>+		}
>+
>+		ret = wave5_vpu_dec_get_bitstream_buffer(inst, &rd_ptr, &wr_ptr, &remain_size);
>+		if (ret) {
>+			dev_err(inst->dev->dev, "Getting the bitstream buffer, fail: %d\n",
>+				ret);
>+			return;
>+		}
>+
>+		if (remain_size < src_size) {
>+			dev_warn(inst->dev->dev,
>+				 "remaining size: %ld < source size: %ld for src buf (%d)\n",
>+				 remain_size, src_size, vbuf->vb2_buf.index);
>+			continue;
>+		}
>+
>+		offset = wr_ptr - inst->bitstream_vbuf.daddr;
>+		if (wr_ptr + src_size > inst->bitstream_vbuf.daddr + inst->bitstream_vbuf.size) {
>+			size_t size;
>+
>+			size = inst->bitstream_vbuf.daddr + inst->bitstream_vbuf.size - wr_ptr;
>+			ret = wave5_vdi_write_memory(inst->dev, &inst->bitstream_vbuf, offset,
>+						     (u8 *)src_buf, size, VDI_128BIT_LITTLE_ENDIAN);
>+			if (ret < 0) {
>+				dev_warn(inst->dev->dev,
>+					 "1/2: write src buf (%d) into bitstream buf, fail: %d\n",
>+					 vbuf->vb2_buf.index, ret);
>+				continue;
>+			}
>+			ret = wave5_vdi_write_memory(inst->dev, &inst->bitstream_vbuf, 0,
>+						     (u8 *)src_buf + size, src_size - size,
>+						     VDI_128BIT_LITTLE_ENDIAN);
>+			if (ret < 0) {
>+				dev_warn(inst->dev->dev,
>+					 "2/2: write src buf (%d) into bitstream buf, fail: %d\n",
>+					 vbuf->vb2_buf.index, ret);
>+				continue;
>+			}
>+		} else {
>+			ret = wave5_vdi_write_memory(inst->dev, &inst->bitstream_vbuf, offset,
>+						     (u8 *)src_buf, src_size,
>+						     VDI_128BIT_LITTLE_ENDIAN);
>+			if (ret < 0) {
>+				dev_warn(inst->dev->dev,
>+					 "Write src buf (%d) into bitstream buf, fail: %d",
>+					 vbuf->vb2_buf.index, ret);
>+				continue;
>+			}
>+		}
>+
>+		ret = wave5_vpu_dec_update_bitstream_buffer(inst, src_size);
>+		if (ret) {
>+			dev_dbg(inst->dev->dev,
>+				"vpu_dec_update_bitstream_buffer fail: %d for src buf (%d)\n",
>+				ret, vbuf->vb2_buf.index);
>+			continue;
>+		}
>+
>+		vpu_buf->consumed = true;
>+	}
>+}
>+
>+static void wave5_handle_src_buffer(struct vpu_instance *inst)
>+{
>+	struct vb2_v4l2_buffer *src_buf;
>+
>+	src_buf = v4l2_m2m_next_src_buf(inst->v4l2_fh.m2m_ctx);
>+	if (src_buf) {
>+		struct vpu_buffer *vpu_buf = wave5_to_vpu_buf(src_buf);
>+
>+		if (vpu_buf->consumed) {
>+			dev_dbg(inst->dev->dev, "%s: already consumed buffer\n", __func__);
>+			src_buf = v4l2_m2m_src_buf_remove(inst->v4l2_fh.m2m_ctx);
>+			inst->timestamp = src_buf->vb2_buf.timestamp;
>+			v4l2_m2m_buf_done(src_buf, VB2_BUF_STATE_DONE);
>+		}
>+	}
>+}
>+
>+static void wave5_update_pix_fmt(struct v4l2_pix_format_mplane *pix_mp, unsigned int width,
>+				 unsigned int height)
>+{
>+	switch (pix_mp->pixelformat) {
>+	case V4L2_PIX_FMT_YUV420:
>+	case V4L2_PIX_FMT_NV12:
>+	case V4L2_PIX_FMT_NV21:
>+		pix_mp->width = round_up(width, 32);
>+		pix_mp->height = height;
>+		pix_mp->plane_fmt[0].bytesperline = round_up(width, 32);
>+		pix_mp->plane_fmt[0].sizeimage = width * height * 3 / 2;
>+		break;
>+	case V4L2_PIX_FMT_YUV420M:
>+		pix_mp->width = round_up(width, 32);
>+		pix_mp->height = height;
>+		pix_mp->plane_fmt[0].bytesperline = round_up(width, 32);
>+		pix_mp->plane_fmt[0].sizeimage = width * height;
>+		pix_mp->plane_fmt[1].bytesperline = round_up(width, 32) / 2;
>+		pix_mp->plane_fmt[1].sizeimage = width * height / 4;
>+		pix_mp->plane_fmt[2].bytesperline = round_up(width, 32) / 2;
>+		pix_mp->plane_fmt[2].sizeimage = width * height / 4;
>+		break;
>+	case V4L2_PIX_FMT_NV12M:
>+	case V4L2_PIX_FMT_NV21M:
>+		pix_mp->width = round_up(width, 32);
>+		pix_mp->height = height;
>+		pix_mp->plane_fmt[0].bytesperline = round_up(width, 32);
>+		pix_mp->plane_fmt[0].sizeimage = width * height;
>+		pix_mp->plane_fmt[1].bytesperline = round_up(width, 32);
>+		pix_mp->plane_fmt[1].sizeimage = width * height / 2;
>+		break;
>+	default:
>+		pix_mp->width = width;
>+		pix_mp->height = height;
>+		pix_mp->plane_fmt[0].bytesperline = 0;
>+		pix_mp->plane_fmt[0].sizeimage = width * height;
>+		break;
>+	}
>+}
>+
>+static void wave5_vpu_dec_start_decode(struct vpu_instance *inst)
>+{
>+	struct dec_param pic_param;
>+	int ret;
>+	u32 fail_res = 0;
>+
>+	memset(&pic_param, 0, sizeof(struct dec_param));
>+
>+	if (inst->state == VPU_INST_STATE_INIT_SEQ) {
>+		u32 non_linear_num = inst->dst_buf_count;
>+		u32 linear_num = inst->dst_buf_count;
>+		u32 stride = inst->dst_fmt.width;
>+
>+		ret = wave5_vpu_dec_register_frame_buffer_ex(inst, non_linear_num, linear_num,
>+							     stride, inst->dst_fmt.height,
>+							     COMPRESSED_FRAME_MAP);
>+		if (ret)
>+			dev_dbg(inst->dev->dev, "%s: vpu_dec_register_frame_buffer_ex fail: %d",
>+				__func__, ret);
>+	}
>+
>+	ret = wave5_vpu_dec_start_one_frame(inst, &pic_param, &fail_res);
>+	if (ret && fail_res != WAVE5_SYSERR_QUEUEING_FAIL) {
>+		struct vb2_v4l2_buffer *src_buf;
>+
>+		src_buf = v4l2_m2m_src_buf_remove(inst->v4l2_fh.m2m_ctx);
>+		inst->state = VPU_INST_STATE_STOP;
>+		v4l2_m2m_buf_done(src_buf, VB2_BUF_STATE_ERROR);
>+	}
>+}
>+
>+static void wave5_vpu_dec_stop_decode(struct vpu_instance *inst)
>+{
>+	unsigned int i;
>+	int ret;
>+
>+	inst->state = VPU_INST_STATE_STOP;
>+
>+	ret = wave5_vpu_dec_update_bitstream_buffer(inst, 0);
>+	if (ret) {
>+		dev_warn(inst->dev->dev,
>+			 "Setting EOS for the bitstream, fail: %d\n", ret);
>+	}
>+
>+	for (i = 0; i < inst->dst_buf_count; i++) {
>+		ret = wave5_vpu_dec_clr_disp_flag(inst, i);
>+		if (ret) {
>+			dev_dbg(inst->dev->dev,
>+				"%s: Clearing the display flag of buffer index: %d, fail: %d\n",
>+				__func__, i, ret);
>+		}
>+	}
>+
>+	v4l2_m2m_job_finish(inst->v4l2_m2m_dev, inst->v4l2_fh.m2m_ctx);
>+}
>+
>+static void wave5_vpu_dec_finish_decode(struct vpu_instance *inst)
>+{
>+	struct dec_output_info dec_output_info;
>+	int ret;
>+	u32 irq_status;
>+
>+	if (kfifo_out(&inst->irq_status, &irq_status, sizeof(int)))
>+		wave5_vpu_clear_interrupt_ex(inst, irq_status);
>+
>+	ret = wave5_vpu_dec_get_output_info(inst, &dec_output_info);
>+	if (ret) {
>+		v4l2_m2m_job_finish(inst->v4l2_m2m_dev, inst->v4l2_fh.m2m_ctx);
>+		return;
>+	}
>+	if (dec_output_info.index_frame_decoded == DECODED_IDX_FLAG_NO_FB &&
>+	    dec_output_info.index_frame_display == DISPLAY_IDX_FLAG_NO_FB) {
>+		dev_dbg(inst->dev->dev, "%s: no more frame buffer\n", __func__);
>+	} else {
>+		wave5_handle_src_buffer(inst);
>+
>+		if (dec_output_info.index_frame_display >= 0) {
>+			struct vb2_v4l2_buffer *dst_buf =
>+				v4l2_m2m_dst_buf_remove_by_idx(inst->v4l2_fh.m2m_ctx,
>+							       dec_output_info.index_frame_display);
>+			int stride = dec_output_info.disp_frame.stride;
>+			int height = dec_output_info.disp_pic_height;
>+
>+			if (inst->dst_fmt.num_planes == 1) {
>+				vb2_set_plane_payload(&dst_buf->vb2_buf, 0,
>+						      (stride * height * 3 / 2));
>+			} else if (inst->dst_fmt.num_planes == 2) {
>+				vb2_set_plane_payload(&dst_buf->vb2_buf, 0,
>+						      (stride * height));
>+				vb2_set_plane_payload(&dst_buf->vb2_buf, 1,
>+						      ((stride / 2) * height));
>+			} else if (inst->dst_fmt.num_planes == 3) {
>+				vb2_set_plane_payload(&dst_buf->vb2_buf, 0,
>+						      (stride * height));
>+				vb2_set_plane_payload(&dst_buf->vb2_buf, 1,
>+						      ((stride / 2) * (height / 2)));
>+				vb2_set_plane_payload(&dst_buf->vb2_buf, 2,
>+						      ((stride / 2) * (height / 2)));
>+			}
>+
>+			dst_buf->vb2_buf.timestamp = inst->timestamp;
>+			dst_buf->field = V4L2_FIELD_NONE;
>+			v4l2_m2m_buf_done(dst_buf, VB2_BUF_STATE_DONE);
>+
>+			dev_dbg(inst->dev->dev, "%s: frame_cycle %8d\n",
>+				__func__, dec_output_info.frame_cycle);
>+		} else if (dec_output_info.index_frame_display == DISPLAY_IDX_FLAG_SEQ_END &&
>+			   !inst->eos) {
>+			static const struct v4l2_event vpu_event_eos = {
>+				.type = V4L2_EVENT_EOS
>+			};
>+			struct vb2_v4l2_buffer *dst_buf =
>+				v4l2_m2m_dst_buf_remove(inst->v4l2_fh.m2m_ctx);
>+
>+			if (!dst_buf)
>+				return;
>+
>+			if (inst->dst_fmt.num_planes == 1) {
>+				vb2_set_plane_payload(&dst_buf->vb2_buf, 0,
>+						      vb2_plane_size(&dst_buf->vb2_buf, 0));
>+			} else if (inst->dst_fmt.num_planes == 2) {
>+				vb2_set_plane_payload(&dst_buf->vb2_buf, 0,
>+						      vb2_plane_size(&dst_buf->vb2_buf, 0));
>+				vb2_set_plane_payload(&dst_buf->vb2_buf, 1,
>+						      vb2_plane_size(&dst_buf->vb2_buf, 1));
>+			} else if (inst->dst_fmt.num_planes == 3) {
>+				vb2_set_plane_payload(&dst_buf->vb2_buf, 0,
>+						      vb2_plane_size(&dst_buf->vb2_buf, 0));
>+				vb2_set_plane_payload(&dst_buf->vb2_buf, 1,
>+						      vb2_plane_size(&dst_buf->vb2_buf, 1));
>+				vb2_set_plane_payload(&dst_buf->vb2_buf, 2,
>+						      vb2_plane_size(&dst_buf->vb2_buf, 2));
>+			}
>+
>+			dst_buf->vb2_buf.timestamp = inst->timestamp;
>+			dst_buf->flags |= V4L2_BUF_FLAG_LAST;
>+			dst_buf->field = V4L2_FIELD_NONE;
>+			v4l2_m2m_buf_done(dst_buf, VB2_BUF_STATE_DONE);
>+
>+			inst->eos = TRUE;
>+			v4l2_event_queue_fh(&inst->v4l2_fh, &vpu_event_eos);
>+
>+			v4l2_m2m_job_finish(inst->v4l2_m2m_dev, inst->v4l2_fh.m2m_ctx);
>+		}
>+	}
>+}
>+
>+static int wave5_vpu_dec_querycap(struct file *file, void *fh, struct v4l2_capability *cap)
>+{
>+	strscpy(cap->driver, VPU_DEC_DRV_NAME, sizeof(cap->driver));
>+	strscpy(cap->card, VPU_DEC_DRV_NAME, sizeof(cap->card));
>+	strscpy(cap->bus_info, "platform:" VPU_DEC_DRV_NAME, sizeof(cap->bus_info));
>+
>+	return 0;
>+}
>+
>+static int wave5_vpu_dec_enum_framesizes(struct file *f, void *fh, struct v4l2_frmsizeenum *fsize)
>+{
>+	const struct vpu_format *vpu_fmt;
>+
>+	if (fsize->index)
>+		return -EINVAL;
>+
>+	vpu_fmt = wave5_find_vpu_fmt(fsize->pixel_format, dec_fmt_list[VPU_FMT_TYPE_CODEC]);
>+	if (!vpu_fmt) {
>+		vpu_fmt = wave5_find_vpu_fmt(fsize->pixel_format, dec_fmt_list[VPU_FMT_TYPE_RAW]);
>+		if (!vpu_fmt)
>+			return -EINVAL;
>+	}
>+
>+	fsize->type = V4L2_FRMSIZE_TYPE_CONTINUOUS;
>+	fsize->stepwise.min_width = vpu_fmt->min_width;
>+	fsize->stepwise.max_width = vpu_fmt->max_width;
>+	fsize->stepwise.step_width = 1;
>+	fsize->stepwise.min_height = vpu_fmt->min_height;
>+	fsize->stepwise.max_height = vpu_fmt->max_height;
>+	fsize->stepwise.step_height = 1;
>+
>+	return 0;
>+}
>+
>+static int wave5_vpu_dec_enum_fmt_cap(struct file *file, void *fh, struct v4l2_fmtdesc *f)
>+{
>+	const struct vpu_format *vpu_fmt;
>+
>+	vpu_fmt = wave5_find_vpu_fmt_by_idx(f->index, dec_fmt_list[VPU_FMT_TYPE_RAW]);
>+	if (!vpu_fmt)
>+		return -EINVAL;
>+
>+	f->pixelformat = vpu_fmt->v4l2_pix_fmt;
>+	f->flags = 0;
>+
>+	return 0;
>+}
>+
>+static int wave5_vpu_dec_try_fmt_cap(struct file *file, void *fh, struct v4l2_format *f)
>+{
>+	struct vpu_instance *inst = wave5_to_vpu_inst(fh);
>+	const struct vpu_format *vpu_fmt;
>+
>+	dev_dbg(inst->dev->dev,
>+		"%s: fourcc: %d width: %d height: %d nm planes: %d colorspace: %d field: %d\n",
>+		__func__, f->fmt.pix_mp.pixelformat, f->fmt.pix_mp.width, f->fmt.pix_mp.height,
>+		f->fmt.pix_mp.num_planes, f->fmt.pix_mp.colorspace, f->fmt.pix_mp.field);
>+
>+	if (f->type != V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
>+		return -EINVAL;
>+
>+	vpu_fmt = wave5_find_vpu_fmt(f->fmt.pix_mp.pixelformat, dec_fmt_list[VPU_FMT_TYPE_RAW]);
>+	if (!vpu_fmt) {
>+		f->fmt.pix_mp.pixelformat = inst->dst_fmt.pixelformat;
>+		f->fmt.pix_mp.num_planes = inst->dst_fmt.num_planes;
>+		wave5_update_pix_fmt(&f->fmt.pix_mp, inst->dst_fmt.width, inst->dst_fmt.height);
>+	} else {
>+		int width = clamp(f->fmt.pix_mp.width, vpu_fmt->min_width, vpu_fmt->max_width);
>+		int height = clamp(f->fmt.pix_mp.height, vpu_fmt->min_height, vpu_fmt->max_height);
>+		const struct v4l2_format_info *info = v4l2_format_info(vpu_fmt->v4l2_pix_fmt);
>+
>+		f->fmt.pix_mp.pixelformat = vpu_fmt->v4l2_pix_fmt;
>+		f->fmt.pix_mp.num_planes = info->mem_planes;
>+		wave5_update_pix_fmt(&f->fmt.pix_mp, width, height);
>+	}
>+
>+	f->fmt.pix_mp.flags = 0;
>+	f->fmt.pix_mp.field = V4L2_FIELD_NONE;
>+	f->fmt.pix_mp.colorspace = inst->colorspace;
>+	f->fmt.pix_mp.ycbcr_enc = inst->ycbcr_enc;
>+	f->fmt.pix_mp.hsv_enc = inst->hsv_enc;
>+	f->fmt.pix_mp.quantization = inst->quantization;
>+	f->fmt.pix_mp.xfer_func = inst->xfer_func;
>+	memset(&f->fmt.pix_mp.reserved, 0, sizeof(f->fmt.pix_mp.reserved));
>+
>+	return 0;
>+}
>+
>+static int wave5_vpu_dec_s_fmt_cap(struct file *file, void *fh, struct v4l2_format *f)
>+{
>+	struct vpu_instance *inst = wave5_to_vpu_inst(fh);
>+	int i, ret;
>+
>+	dev_dbg(inst->dev->dev,
>+		"%s: fourcc: %d width: %d height: %d num_planes: %d colorspace: %d field: %d\n",
>+		__func__, f->fmt.pix_mp.pixelformat, f->fmt.pix_mp.width, f->fmt.pix_mp.height,
>+		f->fmt.pix_mp.num_planes, f->fmt.pix_mp.colorspace, f->fmt.pix_mp.field);
>+
>+	ret = wave5_vpu_dec_try_fmt_cap(file, fh, f);
>+	if (ret)
>+		return ret;
>+
>+	inst->dst_fmt.width = f->fmt.pix_mp.width;
>+	inst->dst_fmt.height = f->fmt.pix_mp.height;
>+	inst->dst_fmt.pixelformat = f->fmt.pix_mp.pixelformat;
>+	inst->dst_fmt.field = f->fmt.pix_mp.field;
>+	inst->dst_fmt.flags = f->fmt.pix_mp.flags;
>+	inst->dst_fmt.num_planes = f->fmt.pix_mp.num_planes;
>+	for (i = 0; i < inst->dst_fmt.num_planes; i++) {
>+		inst->dst_fmt.plane_fmt[i].bytesperline = f->fmt.pix_mp.plane_fmt[i].bytesperline;
>+		inst->dst_fmt.plane_fmt[i].sizeimage = f->fmt.pix_mp.plane_fmt[i].sizeimage;
>+	}
>+
>+	if (inst->dst_fmt.pixelformat == V4L2_PIX_FMT_NV12 ||
>+	    inst->dst_fmt.pixelformat == V4L2_PIX_FMT_NV12M) {
>+		inst->cbcr_interleave = true;
>+		inst->nv21 = false;
>+	} else if (inst->dst_fmt.pixelformat == V4L2_PIX_FMT_NV21 ||
>+		   inst->dst_fmt.pixelformat == V4L2_PIX_FMT_NV21M) {
>+		inst->cbcr_interleave = true;
>+		inst->nv21 = true;
>+	} else {
>+		inst->cbcr_interleave = false;
>+		inst->nv21 = false;
>+	}
>+
>+	return 0;
>+}
>+
>+static int wave5_vpu_dec_g_fmt_cap(struct file *file, void *fh, struct v4l2_format *f)
>+{
>+	struct vpu_instance *inst = wave5_to_vpu_inst(fh);
>+	int i;
>+
>+	f->fmt.pix_mp.width = inst->dst_fmt.width;
>+	f->fmt.pix_mp.height = inst->dst_fmt.height;
>+	f->fmt.pix_mp.pixelformat = inst->dst_fmt.pixelformat;
>+	f->fmt.pix_mp.field = inst->dst_fmt.field;
>+	f->fmt.pix_mp.flags = inst->dst_fmt.flags;
>+	f->fmt.pix_mp.num_planes = inst->dst_fmt.num_planes;
>+	for (i = 0; i < f->fmt.pix_mp.num_planes; i++) {
>+		f->fmt.pix_mp.plane_fmt[i].bytesperline = inst->dst_fmt.plane_fmt[i].bytesperline;
>+		f->fmt.pix_mp.plane_fmt[i].sizeimage = inst->dst_fmt.plane_fmt[i].sizeimage;
>+	}
>+
>+	f->fmt.pix_mp.colorspace = inst->colorspace;
>+	f->fmt.pix_mp.ycbcr_enc = inst->ycbcr_enc;
>+	f->fmt.pix_mp.hsv_enc = inst->hsv_enc;
>+	f->fmt.pix_mp.quantization = inst->quantization;
>+	f->fmt.pix_mp.xfer_func = inst->xfer_func;
>+
>+	return 0;
>+}
>+
>+static int wave5_vpu_dec_enum_fmt_out(struct file *file, void *fh, struct v4l2_fmtdesc *f)
>+{
>+	struct vpu_instance *inst = wave5_to_vpu_inst(fh);
>+	const struct vpu_format *vpu_fmt;
>+
>+	dev_dbg(inst->dev->dev, "%s: index: %d\n", __func__, f->index);
>+
>+	vpu_fmt = wave5_find_vpu_fmt_by_idx(f->index, dec_fmt_list[VPU_FMT_TYPE_CODEC]);
>+	if (!vpu_fmt)
>+		return -EINVAL;
>+
>+	f->pixelformat = vpu_fmt->v4l2_pix_fmt;
>+	f->flags = 0;
>+
>+	return 0;
>+}
>+
>+static int wave5_vpu_dec_try_fmt_out(struct file *file, void *fh, struct v4l2_format *f)
>+{
>+	struct vpu_instance *inst = wave5_to_vpu_inst(fh);
>+	const struct vpu_format *vpu_fmt;
>+
>+	dev_dbg(inst->dev->dev,
>+		"%s: fourcc: %d width: %d height: %d num_planes: %d colorspace: %d field: %d\n",
>+		__func__, f->fmt.pix_mp.pixelformat, f->fmt.pix_mp.width, f->fmt.pix_mp.height,
>+		f->fmt.pix_mp.num_planes, f->fmt.pix_mp.colorspace, f->fmt.pix_mp.field);
>+
>+	if (f->type != V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
>+		return -EINVAL;
>+
>+	vpu_fmt = wave5_find_vpu_fmt(f->fmt.pix_mp.pixelformat, dec_fmt_list[VPU_FMT_TYPE_CODEC]);
>+	if (!vpu_fmt) {
>+		f->fmt.pix_mp.pixelformat = inst->src_fmt.pixelformat;
>+		f->fmt.pix_mp.num_planes = inst->src_fmt.num_planes;
>+		wave5_update_pix_fmt(&f->fmt.pix_mp, inst->src_fmt.width, inst->src_fmt.height);
>+	} else {
>+		int width = clamp(f->fmt.pix_mp.width, vpu_fmt->min_width, vpu_fmt->max_width);
>+		int height = clamp(f->fmt.pix_mp.height, vpu_fmt->min_height, vpu_fmt->max_height);
>+
>+		f->fmt.pix_mp.pixelformat = vpu_fmt->v4l2_pix_fmt;
>+		f->fmt.pix_mp.num_planes = 1;
>+		wave5_update_pix_fmt(&f->fmt.pix_mp, width, height);
>+	}
>+
>+	f->fmt.pix_mp.flags = 0;
>+	f->fmt.pix_mp.field = V4L2_FIELD_NONE;
>+	memset(&f->fmt.pix_mp.reserved, 0, sizeof(f->fmt.pix_mp.reserved));
>+
>+	return 0;
>+}
>+
>+static int wave5_vpu_dec_s_fmt_out(struct file *file, void *fh, struct v4l2_format *f)
>+{
>+	struct vpu_instance *inst = wave5_to_vpu_inst(fh);
>+	int i, ret;
>+
>+	dev_dbg(inst->dev->dev,
>+		"%s: fourcc: %d width: %d height: %d num_planes: %d field: %d\n",
>+		__func__, f->fmt.pix_mp.pixelformat, f->fmt.pix_mp.width, f->fmt.pix_mp.height,
>+		f->fmt.pix_mp.num_planes, f->fmt.pix_mp.field);
>+
>+	ret = wave5_vpu_dec_try_fmt_out(file, fh, f);
>+	if (ret)
>+		return ret;
>+
>+	inst->src_fmt.width = f->fmt.pix_mp.width;
>+	inst->src_fmt.height = f->fmt.pix_mp.height;
>+	inst->src_fmt.pixelformat = f->fmt.pix_mp.pixelformat;
>+	inst->src_fmt.field = f->fmt.pix_mp.field;
>+	inst->src_fmt.flags = f->fmt.pix_mp.flags;
>+	inst->src_fmt.num_planes = f->fmt.pix_mp.num_planes;
>+	for (i = 0; i < inst->src_fmt.num_planes; i++) {
>+		inst->src_fmt.plane_fmt[i].bytesperline = f->fmt.pix_mp.plane_fmt[i].bytesperline;
>+		inst->src_fmt.plane_fmt[i].sizeimage = f->fmt.pix_mp.plane_fmt[i].sizeimage;
>+	}
>+
>+	inst->colorspace = f->fmt.pix_mp.colorspace;
>+	inst->ycbcr_enc = f->fmt.pix_mp.ycbcr_enc;
>+	inst->hsv_enc = f->fmt.pix_mp.hsv_enc;
>+	inst->quantization = f->fmt.pix_mp.quantization;
>+	inst->xfer_func = f->fmt.pix_mp.xfer_func;
>+
>+	wave5_update_pix_fmt(&inst->dst_fmt, f->fmt.pix_mp.width, f->fmt.pix_mp.height);
>+
>+	return 0;
>+}
>+
>+static int wave5_vpu_dec_g_selection(struct file *file, void *fh, struct v4l2_selection *s)
>+{
>+	struct vpu_instance *inst = wave5_to_vpu_inst(fh);
>+
>+	dev_dbg(inst->dev->dev, "%s: type: %d | target: %d\n", __func__, s->type, s->target);
>+
>+	if (s->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
>+		return -EINVAL;
>+	switch (s->target) {
>+	case V4L2_SEL_TGT_COMPOSE_BOUNDS:
>+	case V4L2_SEL_TGT_COMPOSE_PADDED:
>+		s->r.left = 0;
>+		s->r.top = 0;
>+		s->r.width = inst->dst_fmt.width;
>+		s->r.height = inst->dst_fmt.height;
>+		break;
>+	case V4L2_SEL_TGT_COMPOSE:
>+	case V4L2_SEL_TGT_COMPOSE_DEFAULT:
>+		s->r.left = 0;
>+		s->r.top = 0;
>+		s->r.width = inst->src_fmt.width;
>+		s->r.height = inst->src_fmt.height;
>+		break;
>+	default:
>+		return -EINVAL;
>+	}
>+
>+	return 0;
>+}
>+
>+static int wave5_vpu_dec_s_selection(struct file *file, void *fh, struct v4l2_selection *s)
>+{
>+	struct vpu_instance *inst = wave5_to_vpu_inst(fh);
>+
>+	if (s->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
>+		return -EINVAL;
>+
>+	if (s->target != V4L2_SEL_TGT_COMPOSE)
>+		return -EINVAL;
>+
>+	dev_dbg(inst->dev->dev, "V4L2_SEL_TGT_COMPOSE w: %d h: %d\n",
>+		s->r.width, s->r.height);
>+
>+	s->r.left = 0;
>+	s->r.top = 0;
>+	s->r.width = inst->dst_fmt.width;
>+	s->r.height = inst->dst_fmt.height;
>+
>+	return 0;
>+}
>+
>+static int wave5_vpu_dec_decoder_cmd(struct file *file, void *fh, struct v4l2_decoder_cmd *dc)
>+{
>+	struct vpu_instance *inst = wave5_to_vpu_inst(fh);
>+	int ret;
>+
>+	dev_dbg(inst->dev->dev, "decoder command: %d\n", dc->cmd);
>+
>+	ret = v4l2_m2m_ioctl_try_decoder_cmd(file, fh, dc);
>+	if (ret)
>+		return ret;
>+
>+	if (!wave5_vpu_both_queues_are_streaming(inst))
>+		return 0;
>+
>+	switch (dc->cmd) {
>+	case V4L2_DEC_CMD_STOP:
>+		inst->state = VPU_INST_STATE_STOP;
>+
>+		ret = wave5_vpu_dec_update_bitstream_buffer(inst, 0);
>+		if (ret) {
>+			dev_err(inst->dev->dev,
>+				"Setting EOS for the bitstream, fail: %d\n", ret);
>+			return ret;
>+		}
>+		break;
>+	case V4L2_DEC_CMD_START:
>+		break;
>+	default:
>+		return -EINVAL;
>+	}
>+
>+	return 0;
>+}
>+
>+static const struct v4l2_ioctl_ops wave5_vpu_dec_ioctl_ops = {
>+	.vidioc_querycap = wave5_vpu_dec_querycap,
>+	.vidioc_enum_framesizes = wave5_vpu_dec_enum_framesizes,
>+
>+	.vidioc_enum_fmt_vid_cap	= wave5_vpu_dec_enum_fmt_cap,
>+	.vidioc_s_fmt_vid_cap_mplane = wave5_vpu_dec_s_fmt_cap,
>+	.vidioc_g_fmt_vid_cap_mplane = wave5_vpu_dec_g_fmt_cap,
>+	.vidioc_try_fmt_vid_cap_mplane = wave5_vpu_dec_try_fmt_cap,
>+
>+	.vidioc_enum_fmt_vid_out	= wave5_vpu_dec_enum_fmt_out,
>+	.vidioc_s_fmt_vid_out_mplane = wave5_vpu_dec_s_fmt_out,
>+	.vidioc_g_fmt_vid_out_mplane = wave5_vpu_g_fmt_out,
>+	.vidioc_try_fmt_vid_out_mplane = wave5_vpu_dec_try_fmt_out,
>+
>+	.vidioc_g_selection = wave5_vpu_dec_g_selection,
>+	.vidioc_s_selection = wave5_vpu_dec_s_selection,
>+
>+	.vidioc_reqbufs = v4l2_m2m_ioctl_reqbufs,
>+	.vidioc_querybuf = v4l2_m2m_ioctl_querybuf,
>+	.vidioc_create_bufs = v4l2_m2m_ioctl_create_bufs,
>+	.vidioc_prepare_buf = v4l2_m2m_ioctl_prepare_buf,
>+	.vidioc_qbuf = v4l2_m2m_ioctl_qbuf,
>+	.vidioc_expbuf = v4l2_m2m_ioctl_expbuf,
>+	.vidioc_dqbuf = v4l2_m2m_ioctl_dqbuf,
>+	.vidioc_streamon = v4l2_m2m_ioctl_streamon,
>+	.vidioc_streamoff = v4l2_m2m_ioctl_streamoff,
>+
>+	.vidioc_try_decoder_cmd = v4l2_m2m_ioctl_try_decoder_cmd,
>+	.vidioc_decoder_cmd = wave5_vpu_dec_decoder_cmd,
>+
>+	.vidioc_subscribe_event = wave5_vpu_subscribe_event,
>+	.vidioc_unsubscribe_event = v4l2_event_unsubscribe,
>+};
>+
>+static int wave5_vpu_dec_s_ctrl(struct v4l2_ctrl *ctrl)
>+{
>+	struct vpu_instance *inst = wave5_ctrl_to_vpu_inst(ctrl);
>+
>+	dev_dbg(inst->dev->dev, "%s: name: %s | value: %d\n",
>+		__func__, ctrl->name, ctrl->val);
>+
>+	switch (ctrl->id) {
>+	case V4L2_CID_VPU_THUMBNAIL_MODE:
>+		inst->thumbnail_mode = ctrl->val;
>+		break;
>+	case V4L2_CID_MIN_BUFFERS_FOR_CAPTURE:
>+		break;
>+	default:
>+		return -EINVAL;
>+	}
>+
>+	return 0;
>+}
>+
>+static const struct v4l2_ctrl_ops wave5_vpu_dec_ctrl_ops = {
>+	.s_ctrl = wave5_vpu_dec_s_ctrl,
>+};
>+
>+static const struct v4l2_ctrl_config wave5_vpu_thumbnail_mode = {
>+	.ops = &wave5_vpu_dec_ctrl_ops,
>+	.id = V4L2_CID_VPU_THUMBNAIL_MODE,
>+	.name = "thumbnail mode",
>+	.type = V4L2_CTRL_TYPE_BOOLEAN,
>+	.def = 0,
>+	.min = 0,
>+	.max = 1,
>+	.step = 1,
>+	.flags = V4L2_CTRL_FLAG_WRITE_ONLY,
>+};
>+
>+static void wave5_set_default_dec_openparam(struct dec_open_param *open_param)
>+{
>+	open_param->bitstream_mode = BS_MODE_INTERRUPT;
>+	open_param->stream_endian = VPU_STREAM_ENDIAN;
>+	open_param->frame_endian = VPU_FRAME_ENDIAN;
>+}
>+
>+static int wave5_vpu_dec_queue_setup(struct vb2_queue *q, unsigned int *num_buffers,
>+				     unsigned int *num_planes, unsigned int sizes[],
>+				     struct device *alloc_devs[])
>+{
>+	struct vpu_instance *inst = vb2_get_drv_priv(q);
>+	struct v4l2_pix_format_mplane inst_format =
>+		(q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) ? inst->src_fmt : inst->dst_fmt;
>+	unsigned int i;
>+	int ret;
>+
>+	dev_dbg(inst->dev->dev, "%s: num_buffers: %d | num_planes: %d | type: %d\n", __func__,
>+		*num_buffers, *num_planes, q->type);
>+
>+	if (*num_planes) {
>+		if (inst_format.num_planes != *num_planes)
>+			return -EINVAL;
>+
>+		for (i = 0; i < *num_planes; i++) {
>+			if (sizes[i] < inst_format.plane_fmt[i].sizeimage)
>+				return -EINVAL;
>+		}
>+	} else {
>+		*num_planes = inst_format.num_planes;
>+
>+		if (*num_planes == 1) {
>+			sizes[0] = inst_format.width * inst_format.height * 3 / 2;
>+			if (q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
>+				sizes[0] = inst_format.plane_fmt[0].sizeimage;
>+			dev_dbg(inst->dev->dev, "%s: size[0]: %d\n", __func__, sizes[0]);
>+		} else if (*num_planes == 2) {
>+			sizes[0] = inst_format.width * inst_format.height;
>+			sizes[1] = inst_format.width * inst_format.height / 2;
>+			dev_dbg(inst->dev->dev, "%s: size[0]: %d | size[1]: %d\n",
>+				__func__, sizes[0], sizes[1]);
>+		} else if (*num_planes == 3) {
>+			sizes[0] = inst_format.width * inst_format.height;
>+			sizes[1] = inst_format.width * inst_format.height / 4;
>+			sizes[2] = inst_format.width * inst_format.height / 4;
>+			dev_dbg(inst->dev->dev, "%s: size[0]: %d | size[1]: %d | size[2]: %d\n",
>+				__func__, sizes[0], sizes[1], sizes[2]);
>+		}
>+	}
>+
>+	if (inst->state == VPU_INST_STATE_NONE && q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
>+		struct dec_open_param open_param;
>+
>+		memset(&open_param, 0, sizeof(struct dec_open_param));
>+		wave5_set_default_dec_openparam(&open_param);
>+
>+		inst->bitstream_vbuf.size = ALIGN(inst->src_fmt.plane_fmt[0].sizeimage, 1024) * 4;
>+		ret = wave5_vdi_allocate_dma_memory(inst->dev, &inst->bitstream_vbuf);
>+		if (ret) {
>+			dev_dbg(inst->dev->dev, "%s: alloc bitstream of size %zu fail: %d\n",
>+				__func__, inst->bitstream_vbuf.size, ret);
>+			return ret;
>+		}
>+
>+		inst->std = wave5_to_vpu_codstd(inst->src_fmt.pixelformat);
>+		if (inst->std == STD_UNKNOWN) {
>+			dev_warn(inst->dev->dev, "unsupported pixelformat: %.4s\n",
>+				 (char *)&inst->src_fmt.pixelformat);
>+			ret = -EINVAL;
>+			goto free_bitstream_vbuf;
>+		}
>+		open_param.bitstream_buffer = inst->bitstream_vbuf.daddr;
>+		open_param.bitstream_buffer_size = inst->bitstream_vbuf.size;
>+
>+		ret = wave5_vpu_dec_open(inst, &open_param);
>+		if (ret) {
>+			dev_dbg(inst->dev->dev, "%s: wave5_vpu_dec_open, fail: %d\n",
>+				__func__, ret);
>+			goto free_bitstream_vbuf;
>+		}
>+
>+		inst->state = VPU_INST_STATE_OPEN;
>+
>+		if (inst->thumbnail_mode)
>+			wave5_vpu_dec_give_command(inst, ENABLE_DEC_THUMBNAIL_MODE, NULL);
>+
>+	} else if (inst->state == VPU_INST_STATE_INIT_SEQ &&
>+		   q->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
>+		u32 non_linear_num;
>+		u32 fb_stride, fb_height;
>+		u32 luma_size, chroma_size;
>+
>+		if (*num_buffers > inst->min_dst_buf_count &&
>+		    *num_buffers < WAVE5_MAX_FBS)
>+			inst->dst_buf_count = *num_buffers;
>+
>+		*num_buffers = inst->dst_buf_count;
>+		non_linear_num = inst->dst_buf_count;
>+
>+		for (i = 0; i < non_linear_num; i++) {
>+			struct frame_buffer *frame = &inst->frame_buf[i];
>+			struct vpu_buf *vframe = &inst->frame_vbuf[i];
>+
>+			fb_stride = inst->dst_fmt.width;
>+			fb_height = ALIGN(inst->dst_fmt.height, 32);
>+			luma_size = fb_stride * fb_height;
>+			chroma_size = ALIGN(fb_stride / 2, 16) * fb_height;
>+
>+			vframe->size = luma_size + chroma_size;
>+			ret = wave5_vdi_allocate_dma_memory(inst->dev, vframe);
>+			if (ret) {
>+				dev_dbg(inst->dev->dev,
>+					"%s: Allocating FBC buf of size %zu, fail: %d\n",
>+					__func__, vframe->size, ret);
>+				return ret;
>+			}
>+
>+			frame->buf_y = vframe->daddr;
>+			frame->buf_cb = vframe->daddr + luma_size;
>+			frame->buf_cr = (dma_addr_t)-1;
>+			frame->size = vframe->size;
>+			frame->width = inst->src_fmt.width;
>+			frame->stride = fb_stride;
>+			frame->map_type = COMPRESSED_FRAME_MAP;
>+			frame->update_fb_info = true;
>+		}
>+	} else if (inst->state == VPU_INST_STATE_STOP &&
>+		   q->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
>+		*num_buffers = 0;
>+	}
>+
>+	return 0;
>+
>+free_bitstream_vbuf:
>+	wave5_vdi_free_dma_memory(inst->dev, &inst->bitstream_vbuf);
>+	return ret;
>+}
>+
>+static void wave5_vpu_dec_start_streaming_open(struct vpu_instance *inst)
>+{
>+	struct dec_initial_info initial_info;
>+	int ret;
>+
>+	memset(&initial_info, 0, sizeof(struct dec_initial_info));
>+
>+	ret = wave5_vpu_dec_issue_seq_init(inst);
>+	if (ret)
>+		dev_dbg(inst->dev->dev, "%s: wave5_vpu_dec_issue_seq_init, fail: %d\n",
>+			__func__, ret);
>+
>+	if (wave5_vpu_wait_interrupt(inst, VPU_DEC_TIMEOUT) < 0)
>+		dev_dbg(inst->dev->dev, "%s: failed to call vpu_wait_interrupt()\n", __func__);

We found that this step, goes against the specification:
https://www.kernel.org/doc/html/latest/userspace-api/media/v4l/dev-decoder.html#initialization

As the specification doesn't demand queued source buffers before a call
to STREAMON.
This part is executed after a call to `wave5_handle_bitstream_buffer`
(write bitstream data from queued source buffers into the ring/line
buffer of the hardware) @`wave5_vpu_dec_start_streaming`.
Here we wait for an interrupt expected from the hardware after we
initialized the decoding sequence, which requires a queued source
buffer to work.

One idea would be instead of waiting for the interrupt, to place all of
the code below into a separate function which is called on an event,
which can be triggered by the interrupt. When we have no source buffer
queued so far, then we would simply return from this function without
any further delay. And when we a have a queued buffer the interrupt will
fire and trigger any further actions.

Does that sound good to you? Would you like another approach?

Greetings,
Sebastian

>+
>+	ret = wave5_vpu_dec_complete_seq_init(inst, &initial_info);
>+	if (ret) {
>+		dev_dbg(inst->dev->dev, "%s: vpu_dec_complete_seq_init, fail: %d, reason: %d\n",
>+			__func__, ret, initial_info.seq_init_err_reason);
>+	} else {
>+		static const struct v4l2_event vpu_event_src_ch = {
>+			.type = V4L2_EVENT_SOURCE_CHANGE,
>+			.u.src_change.changes = V4L2_EVENT_SRC_CH_RESOLUTION,
>+		};
>+		struct v4l2_ctrl *ctrl;
>+
>+		dev_dbg(inst->dev->dev, "%s: width: %d height: %d profile: %d | minbuffer: %u\n",
>+			__func__, initial_info.pic_width, initial_info.pic_height,
>+			initial_info.profile, initial_info.min_frame_buffer_count);
>+
>+		inst->state = VPU_INST_STATE_INIT_SEQ;
>+		inst->min_dst_buf_count = initial_info.min_frame_buffer_count + 1;
>+		inst->dst_buf_count = inst->min_dst_buf_count;
>+
>+		ctrl = v4l2_ctrl_find(&inst->v4l2_ctrl_hdl,
>+				      V4L2_CID_MIN_BUFFERS_FOR_CAPTURE);
>+		if (ctrl)
>+			v4l2_ctrl_s_ctrl(ctrl, inst->min_dst_buf_count);
>+
>+		if (initial_info.pic_width != inst->src_fmt.width ||
>+		    initial_info.pic_height != inst->src_fmt.height) {
>+			wave5_update_pix_fmt(&inst->src_fmt, initial_info.pic_width,
>+					     initial_info.pic_height);
>+			wave5_update_pix_fmt(&inst->dst_fmt, initial_info.pic_width,
>+					     initial_info.pic_height);
>+		}
>+		v4l2_event_queue_fh(&inst->v4l2_fh, &vpu_event_src_ch);
>+
>+		wave5_handle_src_buffer(inst);
>+	}
>+}
>+
>+static void wave5_vpu_dec_start_streaming_seek(struct vpu_instance *inst)
>+{
>+	struct dec_initial_info initial_info;
>+	struct dec_param pic_param;
>+	struct dec_output_info dec_output_info;
>+	int ret;
>+	u32 fail_res = 0;
>+
>+	memset(&pic_param, 0, sizeof(struct dec_param));
>+
>+	ret = wave5_vpu_dec_start_one_frame(inst, &pic_param, &fail_res);
>+	if (ret && fail_res != WAVE5_SYSERR_QUEUEING_FAIL) {
>+		struct vb2_v4l2_buffer *src_buf;
>+
>+		src_buf = v4l2_m2m_src_buf_remove(inst->v4l2_fh.m2m_ctx);
>+		inst->state = VPU_INST_STATE_STOP;
>+		v4l2_m2m_buf_done(src_buf, VB2_BUF_STATE_ERROR);
>+		dev_dbg(inst->dev->dev, "%s: wave5_vpu_dec_start_one_frame\n", __func__);
>+		return;
>+	}
>+
>+	if (wave5_vpu_wait_interrupt(inst, VPU_DEC_TIMEOUT) < 0)
>+		dev_dbg(inst->dev->dev, "%s: failed to call vpu_wait_interrupt()\n", __func__);
>+
>+	ret = wave5_vpu_dec_get_output_info(inst, &dec_output_info);
>+	if (ret) {
>+		dev_dbg(inst->dev->dev, "%s: wave5_vpu_dec_get_output_info, fail: %d\n",
>+			__func__, ret);
>+		return;
>+	}
>+
>+	if (dec_output_info.sequence_changed) {
>+		static const struct v4l2_event vpu_event_src_ch = {
>+			.type = V4L2_EVENT_SOURCE_CHANGE,
>+			.u.src_change.changes = V4L2_EVENT_SRC_CH_RESOLUTION,
>+		};
>+		struct v4l2_ctrl *ctrl;
>+
>+		wave5_vpu_dec_give_command(inst, DEC_RESET_FRAMEBUF_INFO, NULL);
>+		wave5_vpu_dec_give_command(inst, DEC_GET_SEQ_INFO, &initial_info);
>+
>+		dev_dbg(inst->dev->dev, "%s: width: %d height: %d profile: %d | minbuffer: %u\n",
>+			__func__, initial_info.pic_width, initial_info.pic_height,
>+			initial_info.profile, initial_info.min_frame_buffer_count);
>+
>+		inst->min_dst_buf_count = initial_info.min_frame_buffer_count + 1;
>+		inst->dst_buf_count = inst->min_dst_buf_count;
>+
>+		ctrl = v4l2_ctrl_find(&inst->v4l2_ctrl_hdl,
>+				      V4L2_CID_MIN_BUFFERS_FOR_CAPTURE);
>+		if (ctrl)
>+			v4l2_ctrl_s_ctrl(ctrl, inst->min_dst_buf_count);
>+
>+		if (initial_info.pic_width != inst->src_fmt.width ||
>+		    initial_info.pic_height != inst->src_fmt.height) {
>+			wave5_update_pix_fmt(&inst->src_fmt, initial_info.pic_width,
>+					     initial_info.pic_height);
>+			wave5_update_pix_fmt(&inst->dst_fmt, initial_info.pic_width,
>+					     initial_info.pic_height);
>+		}
>+		v4l2_event_queue_fh(&inst->v4l2_fh, &vpu_event_src_ch);
>+
>+		wave5_handle_src_buffer(inst);
>+	}
>+}
>+
>+static void wave5_vpu_dec_buf_queue_src(struct vb2_buffer *vb)
>+{
>+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
>+	struct vpu_instance *inst = vb2_get_drv_priv(vb->vb2_queue);
>+	struct vpu_buffer *vpu_buf = wave5_to_vpu_buf(vbuf);
>+
>+	vpu_buf->consumed = false;
>+	vbuf->sequence = inst->queued_src_buf_num++;
>+
>+	if (inst->state == VPU_INST_STATE_PIC_RUN) {
>+		wave5_handle_bitstream_buffer(inst);
>+		inst->ops->start_process(inst);
>+	}
>+}
>+
>+static void wave5_vpu_dec_buf_queue_dst(struct vb2_buffer *vb)
>+{
>+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
>+	struct vpu_instance *inst = vb2_get_drv_priv(vb->vb2_queue);
>+	int ret;
>+
>+	vbuf->sequence = inst->queued_dst_buf_num++;
>+	ret = wave5_vpu_dec_clr_disp_flag(inst, vb->index);
>+	if (ret) {
>+		dev_dbg(inst->dev->dev,
>+			"%s: Clearing the display flag of buffer index: %d, fail: %d\n",
>+			__func__, vb->index, ret);
>+	}
>+
>+	if (inst->state == VPU_INST_STATE_INIT_SEQ) {
>+		dma_addr_t buf_addr_y = 0, buf_addr_cb = 0, buf_addr_cr = 0;
>+		u32 buf_size = 0;
>+		u32 non_linear_num = inst->dst_buf_count;
>+		u32 fb_stride = inst->dst_fmt.width;
>+		u32 luma_size = fb_stride * inst->dst_fmt.height;
>+		u32 chroma_size = (fb_stride / 2) * (inst->dst_fmt.height / 2);
>+
>+		if (inst->dst_fmt.num_planes == 1) {
>+			buf_size = vb2_plane_size(&vbuf->vb2_buf, 0);
>+			buf_addr_y = vb2_dma_contig_plane_dma_addr(&vbuf->vb2_buf, 0);
>+			buf_addr_cb = buf_addr_y + luma_size;
>+			buf_addr_cr = buf_addr_cb + chroma_size;
>+		} else if (inst->dst_fmt.num_planes == 2) {
>+			buf_size = vb2_plane_size(&vbuf->vb2_buf, 0) +
>+				vb2_plane_size(&vbuf->vb2_buf, 1);
>+			buf_addr_y = vb2_dma_contig_plane_dma_addr(&vbuf->vb2_buf, 0);
>+			buf_addr_cb = vb2_dma_contig_plane_dma_addr(&vbuf->vb2_buf, 1);
>+			buf_addr_cr = buf_addr_cb + chroma_size;
>+		} else if (inst->dst_fmt.num_planes == 3) {
>+			buf_size = vb2_plane_size(&vbuf->vb2_buf, 0) +
>+				vb2_plane_size(&vbuf->vb2_buf, 1) +
>+				vb2_plane_size(&vbuf->vb2_buf, 2);
>+			buf_addr_y = vb2_dma_contig_plane_dma_addr(&vbuf->vb2_buf, 0);
>+			buf_addr_cb = vb2_dma_contig_plane_dma_addr(&vbuf->vb2_buf, 1);
>+			buf_addr_cr = vb2_dma_contig_plane_dma_addr(&vbuf->vb2_buf, 2);
>+		}
>+		inst->frame_buf[vb->index + non_linear_num].buf_y = buf_addr_y;
>+		inst->frame_buf[vb->index + non_linear_num].buf_cb = buf_addr_cb;
>+		inst->frame_buf[vb->index + non_linear_num].buf_cr = buf_addr_cr;
>+		inst->frame_buf[vb->index + non_linear_num].size = buf_size;
>+		inst->frame_buf[vb->index + non_linear_num].width = inst->src_fmt.width;
>+		inst->frame_buf[vb->index + non_linear_num].stride = fb_stride;
>+		inst->frame_buf[vb->index + non_linear_num].map_type = LINEAR_FRAME_MAP;
>+		inst->frame_buf[vb->index + non_linear_num].update_fb_info = true;
>+	}
>+
>+	if (!vb2_is_streaming(vb->vb2_queue))
>+		return;
>+
>+	if (inst->state == VPU_INST_STATE_STOP && inst->eos == FALSE)
>+		inst->ops->start_process(inst);
>+}
>+
>+static void wave5_vpu_dec_buf_queue(struct vb2_buffer *vb)
>+{
>+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
>+	struct vpu_instance *inst = vb2_get_drv_priv(vb->vb2_queue);
>+
>+	dev_dbg(inst->dev->dev, "%s: type: %4d index: %4d size: ([0]=%4ld, [1]=%4ld, [2]=%4ld)\n",
>+		__func__, vb->type, vb->index, vb2_plane_size(&vbuf->vb2_buf, 0),
>+		vb2_plane_size(&vbuf->vb2_buf, 1), vb2_plane_size(&vbuf->vb2_buf, 2));
>+
>+	v4l2_m2m_buf_queue(inst->v4l2_fh.m2m_ctx, vbuf);
>+
>+	if (vb->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
>+		wave5_vpu_dec_buf_queue_src(vb);
>+	else if (vb->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
>+		wave5_vpu_dec_buf_queue_dst(vb);
>+}
>+
>+static int wave5_vpu_dec_start_streaming(struct vb2_queue *q, unsigned int count)
>+{
>+	struct vpu_instance *inst = vb2_get_drv_priv(q);
>+
>+	dev_dbg(inst->dev->dev, "%s: type: %d\n", __func__, q->type);
>+
>+	if (q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
>+		wave5_handle_bitstream_buffer(inst);
>+		if (inst->state == VPU_INST_STATE_OPEN)
>+			wave5_vpu_dec_start_streaming_open(inst);
>+		else if (inst->state == VPU_INST_STATE_INIT_SEQ)
>+			wave5_vpu_dec_start_streaming_seek(inst);
>+	}
>+
>+	return 0;
>+}
>+
>+static void wave5_vpu_dec_stop_streaming(struct vb2_queue *q)
>+{
>+	struct vpu_instance *inst = vb2_get_drv_priv(q);
>+	struct vb2_v4l2_buffer *buf;
>+	bool check_cmd = TRUE;
>+
>+	dev_dbg(inst->dev->dev, "%s: type: %d\n", __func__, q->type);
>+
>+	while (check_cmd) {
>+		struct queue_status_info q_status;
>+		struct dec_output_info dec_output_info;
>+		int ret;
>+
>+		wave5_vpu_dec_give_command(inst, DEC_GET_QUEUE_STATUS, &q_status);
>+
>+		if (q_status.instance_queue_count + q_status.report_queue_count == 0)
>+			break;
>+
>+		if (wave5_vpu_wait_interrupt(inst, VPU_DEC_TIMEOUT) < 0)
>+			break;
>+
>+		ret = wave5_vpu_dec_get_output_info(inst, &dec_output_info);
>+	}
>+
>+	if (q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
>+		while ((buf = v4l2_m2m_src_buf_remove(inst->v4l2_fh.m2m_ctx))) {
>+			dev_dbg(inst->dev->dev, "%s: (Multiplanar) buf type %4d | index %4d\n",
>+				__func__, buf->vb2_buf.type, buf->vb2_buf.index);
>+			v4l2_m2m_buf_done(buf, VB2_BUF_STATE_ERROR);
>+		}
>+		inst->queued_src_buf_num = 0;
>+	} else {
>+		int i, ret;
>+		dma_addr_t rd_ptr, wr_ptr;
>+
>+		while ((buf = v4l2_m2m_dst_buf_remove(inst->v4l2_fh.m2m_ctx))) {
>+			u32 plane;
>+
>+			dev_dbg(inst->dev->dev, "%s: buf type %4d | index %4d\n",
>+				__func__, buf->vb2_buf.type, buf->vb2_buf.index);
>+
>+			for (plane = 0; plane < inst->dst_fmt.num_planes; plane++)
>+				vb2_set_plane_payload(&buf->vb2_buf, plane, 0);
>+
>+			v4l2_m2m_buf_done(buf, VB2_BUF_STATE_ERROR);
>+		}
>+
>+		for (i = 0; i < inst->dst_buf_count; i++) {
>+			ret = wave5_vpu_dec_set_disp_flag(inst, i);
>+			if (ret) {
>+				dev_dbg(inst->dev->dev,
>+					"%s: Setting display flag of buf index: %d, fail: %d\n",
>+					__func__, i, ret);
>+			}
>+		}
>+
>+		ret = wave5_vpu_dec_get_bitstream_buffer(inst, &rd_ptr, &wr_ptr, NULL);
>+		if (ret) {
>+			dev_err(inst->dev->dev,
>+				"Getting bitstream buf, fail: %d\n", ret);
>+			return;
>+		}
>+		ret = wave5_vpu_dec_set_rd_ptr(inst, wr_ptr, TRUE);
>+		if (ret) {
>+			dev_err(inst->dev->dev,
>+				"Setting read pointer for the decoder, fail: %d\n", ret);
>+			return;
>+		}
>+		if (inst->eos) {
>+			inst->eos = FALSE;
>+			inst->state = VPU_INST_STATE_INIT_SEQ;
>+		}
>+		inst->queued_dst_buf_num = 0;
>+	}
>+}
>+
>+static const struct vb2_ops wave5_vpu_dec_vb2_ops = {
>+	.queue_setup = wave5_vpu_dec_queue_setup,
>+	.wait_prepare = vb2_ops_wait_prepare,
>+	.wait_finish = vb2_ops_wait_finish,
>+	.buf_queue = wave5_vpu_dec_buf_queue,
>+	.start_streaming = wave5_vpu_dec_start_streaming,
>+	.stop_streaming = wave5_vpu_dec_stop_streaming,
>+};
>+
>+static void wave5_set_default_format(struct v4l2_pix_format_mplane *src_fmt,
>+				     struct v4l2_pix_format_mplane *dst_fmt)
>+{
>+	unsigned int dst_pix_fmt = dec_fmt_list[VPU_FMT_TYPE_RAW][0].v4l2_pix_fmt;
>+	const struct v4l2_format_info *dst_fmt_info = v4l2_format_info(dst_pix_fmt);
>+
>+	src_fmt->pixelformat = dec_fmt_list[VPU_FMT_TYPE_CODEC][0].v4l2_pix_fmt;
>+	src_fmt->field = V4L2_FIELD_NONE;
>+	src_fmt->flags = 0;
>+	src_fmt->num_planes = 1;
>+	wave5_update_pix_fmt(src_fmt, 720, 480);
>+
>+	dst_fmt->pixelformat = dst_pix_fmt;
>+	dst_fmt->field = V4L2_FIELD_NONE;
>+	dst_fmt->flags = 0;
>+	dst_fmt->num_planes = dst_fmt_info->mem_planes;
>+	wave5_update_pix_fmt(dst_fmt, 736, 480);
>+}
>+
>+static int wave5_vpu_dec_queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_vq)
>+{
>+	return wave5_vpu_queue_init(priv, src_vq, dst_vq, &wave5_vpu_dec_vb2_ops);
>+}
>+
>+static const struct vpu_instance_ops wave5_vpu_dec_inst_ops = {
>+	.start_process = wave5_vpu_dec_start_decode,
>+	.stop_process = wave5_vpu_dec_stop_decode,
>+	.finish_process = wave5_vpu_dec_finish_decode,
>+};
>+
>+static void wave5_vpu_dec_device_run(void *priv)
>+{
>+	struct vpu_instance *inst = priv;
>+
>+	inst->ops->start_process(inst);
>+
>+	inst->state = VPU_INST_STATE_PIC_RUN;
>+}
>+
>+static void wave5_vpu_dec_job_abort(void *priv)
>+{
>+	struct vpu_instance *inst = priv;
>+
>+	inst->ops->stop_process(inst);
>+}
>+
>+static const struct v4l2_m2m_ops wave5_vpu_dec_m2m_ops = {
>+	.device_run = wave5_vpu_dec_device_run,
>+	.job_abort = wave5_vpu_dec_job_abort,
>+};
>+
>+static int wave5_vpu_open_dec(struct file *filp)
>+{
>+	struct video_device *vdev = video_devdata(filp);
>+	struct vpu_device *dev = video_drvdata(filp);
>+	struct vpu_instance *inst = NULL;
>+	int ret = 0;
>+
>+	inst = kzalloc(sizeof(*inst), GFP_KERNEL);
>+	if (!inst)
>+		return -ENOMEM;
>+
>+	inst->dev = dev;
>+	inst->type = VPU_INST_TYPE_DEC;
>+	inst->ops = &wave5_vpu_dec_inst_ops;
>+
>+	v4l2_fh_init(&inst->v4l2_fh, vdev);
>+	filp->private_data = &inst->v4l2_fh;
>+	v4l2_fh_add(&inst->v4l2_fh);
>+
>+	INIT_LIST_HEAD(&inst->list);
>+	list_add_tail(&inst->list, &dev->instances);
>+
>+	inst->v4l2_m2m_dev = v4l2_m2m_init(&wave5_vpu_dec_m2m_ops);
>+	if (IS_ERR(inst->v4l2_m2m_dev)) {
>+		ret = PTR_ERR(inst->v4l2_m2m_dev);
>+		dev_err(inst->dev->dev, "v4l2_m2m_init, fail: %d\n", ret);
>+		goto cleanup_inst;
>+	}
>+
>+	inst->v4l2_fh.m2m_ctx =
>+		v4l2_m2m_ctx_init(inst->v4l2_m2m_dev, inst, wave5_vpu_dec_queue_init);
>+	if (IS_ERR(inst->v4l2_fh.m2m_ctx)) {
>+		ret = PTR_ERR(inst->v4l2_fh.m2m_ctx);
>+		goto cleanup_inst;
>+	}
>+
>+	v4l2_ctrl_handler_init(&inst->v4l2_ctrl_hdl, 10);
>+	v4l2_ctrl_new_custom(&inst->v4l2_ctrl_hdl, &wave5_vpu_thumbnail_mode, NULL);
>+	v4l2_ctrl_new_std(&inst->v4l2_ctrl_hdl, &wave5_vpu_dec_ctrl_ops,
>+			  V4L2_CID_MIN_BUFFERS_FOR_CAPTURE, 1, 32, 1, 1);
>+
>+	if (inst->v4l2_ctrl_hdl.error) {
>+		ret = -ENODEV;
>+		goto cleanup_inst;
>+	}
>+
>+	inst->v4l2_fh.ctrl_handler = &inst->v4l2_ctrl_hdl;
>+	v4l2_ctrl_handler_setup(&inst->v4l2_ctrl_hdl);
>+
>+	wave5_set_default_format(&inst->src_fmt, &inst->dst_fmt);
>+	inst->colorspace = V4L2_COLORSPACE_REC709;
>+	inst->ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
>+	inst->hsv_enc = 0;
>+	inst->quantization = V4L2_QUANTIZATION_DEFAULT;
>+	inst->xfer_func = V4L2_XFER_FUNC_DEFAULT;
>+
>+	init_completion(&inst->irq_done);
>+	ret = kfifo_alloc(&inst->irq_status, 16 * sizeof(int), GFP_KERNEL);
>+	if (ret) {
>+		dev_err(inst->dev->dev, "failed to allocate fifo\n");
>+		goto cleanup_inst;
>+	}
>+
>+	inst->id = ida_alloc(&inst->dev->inst_ida, GFP_KERNEL);
>+	if (inst->id < 0) {
>+		dev_warn(inst->dev->dev, "Allocating instance ID, fail: %d\n", inst->id);
>+		ret = inst->id;
>+		goto cleanup_inst;
>+	}
>+
>+	return 0;
>+
>+cleanup_inst:
>+	wave5_cleanup_instance(inst);
>+	return ret;
>+}
>+
>+static int wave5_vpu_dec_release(struct file *filp)
>+{
>+	return wave5_vpu_release_device(filp, wave5_vpu_dec_close, "decoder");
>+}
>+
>+static const struct v4l2_file_operations wave5_vpu_dec_fops = {
>+	.owner = THIS_MODULE,
>+	.open = wave5_vpu_open_dec,
>+	.release = wave5_vpu_dec_release,
>+	.unlocked_ioctl = video_ioctl2,
>+	.poll = v4l2_m2m_fop_poll,
>+	.mmap = v4l2_m2m_fop_mmap,
>+};
>+
>+int wave5_vpu_dec_register_device(struct vpu_device *dev)
>+{
>+	struct video_device *vdev_dec;
>+	int ret;
>+
>+	vdev_dec = devm_kzalloc(dev->v4l2_dev.dev, sizeof(*vdev_dec), GFP_KERNEL);
>+	if (!vdev_dec)
>+		return -ENOMEM;
>+
>+	dev->video_dev_dec = vdev_dec;
>+
>+	strscpy(vdev_dec->name, VPU_DEC_DEV_NAME, sizeof(vdev_dec->name));
>+	vdev_dec->fops = &wave5_vpu_dec_fops;
>+	vdev_dec->ioctl_ops = &wave5_vpu_dec_ioctl_ops;
>+	vdev_dec->release = video_device_release_empty;
>+	vdev_dec->v4l2_dev = &dev->v4l2_dev;
>+	vdev_dec->vfl_dir = VFL_DIR_M2M;
>+	vdev_dec->device_caps = V4L2_CAP_VIDEO_M2M_MPLANE | V4L2_CAP_STREAMING;
>+	vdev_dec->lock = &dev->dev_lock;
>+
>+	ret = video_register_device(vdev_dec, VFL_TYPE_VIDEO, -1);
>+	if (ret)
>+		return ret;
>+
>+	video_set_drvdata(vdev_dec, dev);
>+
>+	return 0;
>+}
>+
>+void wave5_vpu_dec_unregister_device(struct vpu_device *dev)
>+{
>+	video_unregister_device(dev->video_dev_dec);
>+}
>diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
>new file mode 100644
>index 000000000000..233c714bff49
>--- /dev/null
>+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
>@@ -0,0 +1,1454 @@
>+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
>+/*
>+ * Wave5 series multi-standard codec IP - encoder interface
>+ *
>+ * Copyright (C) 2021 CHIPS&MEDIA INC
>+ */
>+
>+#include "wave5-helper.h"
>+
>+#define VPU_ENC_DEV_NAME "C&M Wave5 VPU encoder"
>+#define VPU_ENC_DRV_NAME "wave5-enc"
>+
>+static const struct vpu_format enc_fmt_list[FMT_TYPES][MAX_FMTS] = {
>+	[VPU_FMT_TYPE_CODEC] = {
>+		{
>+			.v4l2_pix_fmt = V4L2_PIX_FMT_HEVC,
>+			.max_width = W5_MAX_ENC_PIC_WIDTH,
>+			.min_width = W5_MIN_ENC_PIC_WIDTH,
>+			.max_height = W5_MAX_ENC_PIC_HEIGHT,
>+			.min_height = W5_MIN_ENC_PIC_HEIGHT,
>+		},
>+		{
>+			.v4l2_pix_fmt = V4L2_PIX_FMT_H264,
>+			.max_width = W5_MAX_ENC_PIC_WIDTH,
>+			.min_width = W5_MIN_ENC_PIC_WIDTH,
>+			.max_height = W5_MAX_ENC_PIC_HEIGHT,
>+			.min_height = W5_MIN_ENC_PIC_HEIGHT,
>+		},
>+	},
>+	[VPU_FMT_TYPE_RAW] = {
>+		{
>+			.v4l2_pix_fmt = V4L2_PIX_FMT_YUV420,
>+			.max_width = W5_MAX_ENC_PIC_WIDTH,
>+			.min_width = W5_MIN_ENC_PIC_WIDTH,
>+			.max_height = W5_MAX_ENC_PIC_HEIGHT,
>+			.min_height = W5_MIN_ENC_PIC_HEIGHT,
>+		},
>+		{
>+			.v4l2_pix_fmt = V4L2_PIX_FMT_NV12,
>+			.max_width = W5_MAX_ENC_PIC_WIDTH,
>+			.min_width = W5_MIN_ENC_PIC_WIDTH,
>+			.max_height = W5_MAX_ENC_PIC_HEIGHT,
>+			.min_height = W5_MIN_ENC_PIC_HEIGHT,
>+		},
>+		{
>+			.v4l2_pix_fmt = V4L2_PIX_FMT_NV21,
>+			.max_width = W5_MAX_ENC_PIC_WIDTH,
>+			.min_width = W5_MIN_ENC_PIC_WIDTH,
>+			.max_height = W5_MAX_ENC_PIC_HEIGHT,
>+			.min_height = W5_MIN_ENC_PIC_HEIGHT,
>+		},
>+		{
>+			.v4l2_pix_fmt = V4L2_PIX_FMT_YUV420M,
>+			.max_width = W5_MAX_ENC_PIC_WIDTH,
>+			.min_width = W5_MIN_ENC_PIC_WIDTH,
>+			.max_height = W5_MAX_ENC_PIC_HEIGHT,
>+			.min_height = W5_MIN_ENC_PIC_HEIGHT,
>+		},
>+		{
>+			.v4l2_pix_fmt = V4L2_PIX_FMT_NV12M,
>+			.max_width = W5_MAX_ENC_PIC_WIDTH,
>+			.min_width = W5_MIN_ENC_PIC_WIDTH,
>+			.max_height = W5_MAX_ENC_PIC_HEIGHT,
>+			.min_height = W5_MIN_ENC_PIC_HEIGHT,
>+		},
>+		{
>+			.v4l2_pix_fmt = V4L2_PIX_FMT_NV21M,
>+			.max_width = W5_MAX_ENC_PIC_WIDTH,
>+			.min_width = W5_MIN_ENC_PIC_WIDTH,
>+			.max_height = W5_MAX_ENC_PIC_HEIGHT,
>+			.min_height = W5_MIN_ENC_PIC_HEIGHT,
>+		},
>+	}
>+};
>+
>+static enum wave_std wave5_to_vpu_wavestd(unsigned int v4l2_pix_fmt)
>+{
>+	switch (v4l2_pix_fmt) {
>+	case V4L2_PIX_FMT_H264:
>+		return W_AVC_ENC;
>+	case V4L2_PIX_FMT_HEVC:
>+		return W_HEVC_ENC;
>+	default:
>+		return STD_UNKNOWN;
>+	}
>+}
>+
>+static struct vb2_v4l2_buffer *wave5_get_valid_src_buf(struct vpu_instance *inst)
>+{
>+	struct v4l2_m2m_buffer *v4l2_m2m_buf;
>+
>+	v4l2_m2m_for_each_src_buf(inst->v4l2_fh.m2m_ctx, v4l2_m2m_buf) {
>+		struct vb2_v4l2_buffer *vb2_v4l2_buf;
>+		struct vpu_buffer *vpu_buf = NULL;
>+
>+		vb2_v4l2_buf = &v4l2_m2m_buf->vb;
>+		vpu_buf = wave5_to_vpu_buf(vb2_v4l2_buf);
>+
>+		if (!vpu_buf->consumed) {
>+			dev_dbg(inst->dev->dev, "%s: src buf (index: %d) has not been consumed\n",
>+				__func__, vb2_v4l2_buf->vb2_buf.index);
>+			return vb2_v4l2_buf;
>+		}
>+	}
>+
>+	return NULL;
>+}
>+
>+static struct vb2_v4l2_buffer *wave5_get_valid_dst_buf(struct vpu_instance *inst)
>+{
>+	struct v4l2_m2m_buffer *v4l2_m2m_buf;
>+
>+	v4l2_m2m_for_each_dst_buf(inst->v4l2_fh.m2m_ctx, v4l2_m2m_buf) {
>+		struct vb2_v4l2_buffer *vb2_v4l2_buf;
>+		struct vpu_buffer *vpu_buf = NULL;
>+
>+		vb2_v4l2_buf = &v4l2_m2m_buf->vb;
>+		vpu_buf = wave5_to_vpu_buf(vb2_v4l2_buf);
>+
>+		if (!vpu_buf->consumed) {
>+			dev_dbg(inst->dev->dev, "%s: dst buf (index: %d) has not been consumed\n",
>+				__func__, vb2_v4l2_buf->vb2_buf.index);
>+			return vb2_v4l2_buf;
>+		}
>+	}
>+
>+	return NULL;
>+}
>+
>+static void wave5_update_pix_fmt(struct v4l2_pix_format_mplane *pix_mp, unsigned int width,
>+				 unsigned int height)
>+{
>+	switch (pix_mp->pixelformat) {
>+	case V4L2_PIX_FMT_YUV420:
>+	case V4L2_PIX_FMT_NV12:
>+	case V4L2_PIX_FMT_NV21:
>+		pix_mp->width = width;
>+		pix_mp->height = height;
>+		pix_mp->plane_fmt[0].bytesperline = round_up(width, 32);
>+		pix_mp->plane_fmt[0].sizeimage = round_up(width, 32) * height * 3 / 2;
>+		break;
>+	case V4L2_PIX_FMT_YUV420M:
>+		pix_mp->width = width;
>+		pix_mp->height = height;
>+		pix_mp->plane_fmt[0].bytesperline = round_up(width, 32);
>+		pix_mp->plane_fmt[0].sizeimage = round_up(width, 32) * height;
>+		pix_mp->plane_fmt[1].bytesperline = round_up(width, 32) / 2;
>+		pix_mp->plane_fmt[1].sizeimage = round_up(width, 32) * height / 4;
>+		pix_mp->plane_fmt[2].bytesperline = round_up(width, 32) / 2;
>+		pix_mp->plane_fmt[2].sizeimage = round_up(width, 32) * height / 4;
>+		break;
>+	case V4L2_PIX_FMT_NV12M:
>+	case V4L2_PIX_FMT_NV21M:
>+		pix_mp->width = width;
>+		pix_mp->height = height;
>+		pix_mp->plane_fmt[0].bytesperline = round_up(width, 32);
>+		pix_mp->plane_fmt[0].sizeimage = round_up(width, 32) * height;
>+		pix_mp->plane_fmt[1].bytesperline = round_up(width, 32);
>+		pix_mp->plane_fmt[1].sizeimage = round_up(width, 32) * height / 2;
>+		break;
>+	default:
>+		pix_mp->width = width;
>+		pix_mp->height = height;
>+		pix_mp->plane_fmt[0].bytesperline = 0;
>+		pix_mp->plane_fmt[0].sizeimage = width * height;
>+		break;
>+	}
>+}
>+
>+static void wave5_vpu_enc_start_encode(struct vpu_instance *inst)
>+{
>+	u32 max_cmd_q = 0;
>+
>+	max_cmd_q = (inst->src_buf_count < COMMAND_QUEUE_DEPTH) ?
>+		inst->src_buf_count : COMMAND_QUEUE_DEPTH;
>+
>+	if (inst->state == VPU_INST_STATE_STOP)
>+		max_cmd_q = 1;
>+
>+	while (max_cmd_q) {
>+		struct vb2_v4l2_buffer *src_buf;
>+		struct vb2_v4l2_buffer *dst_buf;
>+		struct vpu_buffer *src_vbuf;
>+		struct vpu_buffer *dst_vbuf;
>+		struct frame_buffer frame_buf;
>+		struct enc_param pic_param;
>+		u32 stride = ALIGN(inst->dst_fmt.width, 32);
>+		u32 luma_size = (stride * inst->dst_fmt.height);
>+		u32 chroma_size = ((stride / 2) * (inst->dst_fmt.height / 2));
>+		u32 fail_res;
>+		int ret;
>+
>+		memset(&pic_param, 0, sizeof(struct enc_param));
>+		memset(&frame_buf, 0, sizeof(struct frame_buffer));
>+
>+		src_buf = wave5_get_valid_src_buf(inst);
>+		dst_buf = wave5_get_valid_dst_buf(inst);
>+
>+		if (!dst_buf) {
>+			dev_dbg(inst->dev->dev, "%s: No valid dst buf\n", __func__);
>+			break;
>+		}
>+
>+		dst_vbuf = wave5_to_vpu_buf(dst_buf);
>+		pic_param.pic_stream_buffer_addr =
>+			vb2_dma_contig_plane_dma_addr(&dst_buf->vb2_buf, 0);
>+		pic_param.pic_stream_buffer_size =
>+			vb2_plane_size(&dst_buf->vb2_buf, 0);
>+
>+		if (!src_buf) {
>+			dev_dbg(inst->dev->dev, "%s: No valid src buf\n", __func__);
>+			if (inst->state == VPU_INST_STATE_STOP)
>+				pic_param.src_end_flag = true;
>+			else
>+				break;
>+		} else {
>+			src_vbuf = wave5_to_vpu_buf(src_buf);
>+			if (inst->src_fmt.num_planes == 1) {
>+				frame_buf.buf_y =
>+					vb2_dma_contig_plane_dma_addr(&src_buf->vb2_buf, 0);
>+				frame_buf.buf_cb = frame_buf.buf_y + luma_size;
>+				frame_buf.buf_cr = frame_buf.buf_cb + chroma_size;
>+			} else if (inst->src_fmt.num_planes == 2) {
>+				frame_buf.buf_y =
>+					vb2_dma_contig_plane_dma_addr(&src_buf->vb2_buf, 0);
>+				frame_buf.buf_cb =
>+					vb2_dma_contig_plane_dma_addr(&src_buf->vb2_buf, 1);
>+				frame_buf.buf_cr = frame_buf.buf_cb + chroma_size;
>+			} else if (inst->src_fmt.num_planes == 3) {
>+				frame_buf.buf_y =
>+					vb2_dma_contig_plane_dma_addr(&src_buf->vb2_buf, 0);
>+				frame_buf.buf_cb =
>+					vb2_dma_contig_plane_dma_addr(&src_buf->vb2_buf, 1);
>+				frame_buf.buf_cr =
>+					vb2_dma_contig_plane_dma_addr(&src_buf->vb2_buf, 2);
>+			}
>+			frame_buf.stride = stride;
>+			pic_param.src_idx = src_buf->vb2_buf.index;
>+		}
>+
>+		pic_param.source_frame = &frame_buf;
>+		pic_param.code_option.implicit_header_encode = 1;
>+		ret = wave5_vpu_enc_start_one_frame(inst, &pic_param, &fail_res);
>+		if (ret) {
>+			if (fail_res == WAVE5_SYSERR_QUEUEING_FAIL)
>+				break;
>+
>+			dev_dbg(inst->dev->dev, "%s: wave5_vpu_enc_start_one_frame fail: %d\n",
>+				__func__, ret);
>+			src_buf = v4l2_m2m_src_buf_remove(inst->v4l2_fh.m2m_ctx);
>+			if (!src_buf) {
>+				dev_err(inst->dev->dev,
>+					"Removing src buf failed, the queue is empty\n");
>+				continue;
>+			}
>+			dst_buf = v4l2_m2m_dst_buf_remove(inst->v4l2_fh.m2m_ctx);
>+			if (!dst_buf) {
>+				dev_err(inst->dev->dev,
>+					"Removing dst buf failed, the queue is empty\n");
>+				continue;
>+			}
>+			inst->state = VPU_INST_STATE_STOP;
>+			v4l2_m2m_buf_done(src_buf, VB2_BUF_STATE_ERROR);
>+			v4l2_m2m_buf_done(dst_buf, VB2_BUF_STATE_ERROR);
>+		} else {
>+			dev_dbg(inst->dev->dev, "%s: wave5_vpu_enc_start_one_frame success\n",
>+				__func__);
>+			if (src_buf)
>+				src_vbuf->consumed = true;
>+			if (dst_buf)
>+				dst_vbuf->consumed = true;
>+		}
>+
>+		max_cmd_q--;
>+	}
>+}
>+
>+static void wave5_vpu_enc_stop_encode(struct vpu_instance *inst)
>+{
>+	inst->state = VPU_INST_STATE_STOP;
>+
>+	v4l2_m2m_job_finish(inst->v4l2_m2m_dev, inst->v4l2_fh.m2m_ctx);
>+}
>+
>+static void wave5_vpu_enc_finish_encode(struct vpu_instance *inst)
>+{
>+	int ret;
>+	struct enc_output_info enc_output_info;
>+	u32 irq_status;
>+	struct vb2_v4l2_buffer *dst_buf = NULL;
>+	struct v4l2_m2m_buffer *v4l2_m2m_buf = NULL;
>+
>+	if (kfifo_out(&inst->irq_status, &irq_status, sizeof(int)))
>+		wave5_vpu_clear_interrupt_ex(inst, irq_status);
>+
>+	ret = wave5_vpu_enc_get_output_info(inst, &enc_output_info);
>+	if (ret) {
>+		dev_dbg(inst->dev->dev,
>+			"%s: vpu_enc_get_output_info fail: %d  reason: %d | info: %d\n",
>+			__func__, ret, enc_output_info.error_reason, enc_output_info.warn_info);
>+		return;
>+	}
>+
>+	v4l2_m2m_for_each_dst_buf(inst->v4l2_fh.m2m_ctx, v4l2_m2m_buf) {
>+		dst_buf = &v4l2_m2m_buf->vb;
>+		if (enc_output_info.bitstream_buffer ==
>+			vb2_dma_contig_plane_dma_addr(&dst_buf->vb2_buf, 0))
>+			break;
>+	}
>+
>+	if (enc_output_info.enc_src_idx >= 0) {
>+		struct vb2_v4l2_buffer *src_buf =
>+			v4l2_m2m_src_buf_remove_by_idx(inst->v4l2_fh.m2m_ctx,
>+						       enc_output_info.enc_src_idx);
>+
>+		inst->timestamp = src_buf->vb2_buf.timestamp;
>+		v4l2_m2m_buf_done(src_buf, VB2_BUF_STATE_DONE);
>+	}
>+
>+	if (enc_output_info.recon_frame_index == RECON_IDX_FLAG_ENC_END) {
>+		static const struct v4l2_event vpu_event_eos = {
>+			.type = V4L2_EVENT_EOS
>+		};
>+
>+		vb2_set_plane_payload(&dst_buf->vb2_buf, 0, 0);
>+		dst_buf->vb2_buf.timestamp = inst->timestamp;
>+		dst_buf->field = V4L2_FIELD_NONE;
>+		dst_buf->flags |= V4L2_BUF_FLAG_LAST;
>+		v4l2_m2m_dst_buf_remove_by_buf(inst->v4l2_fh.m2m_ctx, dst_buf);
>+		v4l2_m2m_buf_done(dst_buf, VB2_BUF_STATE_DONE);
>+
>+		inst->state = VPU_INST_STATE_PIC_RUN;
>+		v4l2_event_queue_fh(&inst->v4l2_fh, &vpu_event_eos);
>+
>+		v4l2_m2m_job_finish(inst->v4l2_m2m_dev, inst->v4l2_fh.m2m_ctx);
>+	} else {
>+		vb2_set_plane_payload(&dst_buf->vb2_buf, 0, enc_output_info.bitstream_size);
>+
>+		dst_buf->vb2_buf.timestamp = inst->timestamp;
>+		dst_buf->field = V4L2_FIELD_NONE;
>+		if (enc_output_info.pic_type == PIC_TYPE_I) {
>+			if (enc_output_info.enc_vcl_nut == 19 ||
>+			    enc_output_info.enc_vcl_nut == 20)
>+				dst_buf->flags |= V4L2_BUF_FLAG_KEYFRAME;
>+			else
>+				dst_buf->flags |= V4L2_BUF_FLAG_PFRAME;
>+		} else if (enc_output_info.pic_type == PIC_TYPE_P) {
>+			dst_buf->flags |= V4L2_BUF_FLAG_PFRAME;
>+		} else if (enc_output_info.pic_type == PIC_TYPE_B) {
>+			dst_buf->flags |= V4L2_BUF_FLAG_BFRAME;
>+		}
>+
>+		v4l2_m2m_dst_buf_remove_by_buf(inst->v4l2_fh.m2m_ctx, dst_buf);
>+		v4l2_m2m_buf_done(dst_buf, VB2_BUF_STATE_DONE);
>+
>+		dev_dbg(inst->dev->dev, "%s: frame_cycle %8d\n",
>+			__func__, enc_output_info.frame_cycle);
>+	}
>+}
>+
>+static int wave5_vpu_enc_querycap(struct file *file, void *fh, struct v4l2_capability *cap)
>+{
>+	strscpy(cap->driver, VPU_ENC_DRV_NAME, sizeof(cap->driver));
>+	strscpy(cap->card, VPU_ENC_DRV_NAME, sizeof(cap->card));
>+	strscpy(cap->bus_info, "platform:" VPU_ENC_DRV_NAME, sizeof(cap->bus_info));
>+
>+	return 0;
>+}
>+
>+static int wave5_vpu_enc_enum_framesizes(struct file *f, void *fh, struct v4l2_frmsizeenum *fsize)
>+{
>+	const struct vpu_format *vpu_fmt;
>+
>+	if (fsize->index)
>+		return -EINVAL;
>+
>+	vpu_fmt = wave5_find_vpu_fmt(fsize->pixel_format, enc_fmt_list[VPU_FMT_TYPE_CODEC]);
>+	if (!vpu_fmt) {
>+		vpu_fmt = wave5_find_vpu_fmt(fsize->pixel_format, enc_fmt_list[VPU_FMT_TYPE_RAW]);
>+		if (!vpu_fmt)
>+			return -EINVAL;
>+	}
>+
>+	fsize->type = V4L2_FRMSIZE_TYPE_CONTINUOUS;
>+	fsize->stepwise.min_width = vpu_fmt->min_width;
>+	fsize->stepwise.max_width = vpu_fmt->max_width;
>+	fsize->stepwise.step_width = 1;
>+	fsize->stepwise.min_height = vpu_fmt->min_height;
>+	fsize->stepwise.max_height = vpu_fmt->max_height;
>+	fsize->stepwise.step_height = 1;
>+
>+	return 0;
>+}
>+
>+static int wave5_vpu_enc_enum_fmt_cap(struct file *file, void *fh, struct v4l2_fmtdesc *f)
>+{
>+	struct vpu_instance *inst = wave5_to_vpu_inst(fh);
>+	const struct vpu_format *vpu_fmt;
>+
>+	dev_dbg(inst->dev->dev, "%s: index: %d\n", __func__, f->index);
>+
>+	vpu_fmt = wave5_find_vpu_fmt_by_idx(f->index, enc_fmt_list[VPU_FMT_TYPE_CODEC]);
>+	if (!vpu_fmt)
>+		return -EINVAL;
>+
>+	f->pixelformat = vpu_fmt->v4l2_pix_fmt;
>+	f->flags = 0;
>+
>+	return 0;
>+}
>+
>+static int wave5_vpu_enc_try_fmt_cap(struct file *file, void *fh, struct v4l2_format *f)
>+{
>+	struct vpu_instance *inst = wave5_to_vpu_inst(fh);
>+	const struct vpu_format *vpu_fmt;
>+
>+	dev_dbg(inst->dev->dev, "%s: fourcc: %d width: %d height: %d num_planes: %d field: %d\n",
>+		__func__, f->fmt.pix_mp.pixelformat, f->fmt.pix_mp.width, f->fmt.pix_mp.height,
>+		f->fmt.pix_mp.num_planes, f->fmt.pix_mp.field);
>+
>+	if (f->type != V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
>+		return -EINVAL;
>+
>+	vpu_fmt = wave5_find_vpu_fmt(f->fmt.pix_mp.pixelformat, enc_fmt_list[VPU_FMT_TYPE_CODEC]);
>+	if (!vpu_fmt) {
>+		f->fmt.pix_mp.pixelformat = inst->dst_fmt.pixelformat;
>+		f->fmt.pix_mp.num_planes = inst->dst_fmt.num_planes;
>+		wave5_update_pix_fmt(&f->fmt.pix_mp, inst->dst_fmt.width, inst->dst_fmt.height);
>+	} else {
>+		int width = clamp(f->fmt.pix_mp.width, vpu_fmt->min_width, vpu_fmt->max_width);
>+		int height = clamp(f->fmt.pix_mp.height, vpu_fmt->min_height, vpu_fmt->max_height);
>+
>+		f->fmt.pix_mp.pixelformat = vpu_fmt->v4l2_pix_fmt;
>+		f->fmt.pix_mp.num_planes = 1;
>+		wave5_update_pix_fmt(&f->fmt.pix_mp, width, height);
>+	}
>+
>+	f->fmt.pix_mp.flags = 0;
>+	f->fmt.pix_mp.field = V4L2_FIELD_NONE;
>+	f->fmt.pix_mp.colorspace = inst->colorspace;
>+	f->fmt.pix_mp.ycbcr_enc = inst->ycbcr_enc;
>+	f->fmt.pix_mp.hsv_enc = inst->hsv_enc;
>+	f->fmt.pix_mp.quantization = inst->quantization;
>+	f->fmt.pix_mp.xfer_func = inst->xfer_func;
>+	memset(&f->fmt.pix_mp.reserved, 0, sizeof(f->fmt.pix_mp.reserved));
>+
>+	return 0;
>+}
>+
>+static int wave5_vpu_enc_s_fmt_cap(struct file *file, void *fh, struct v4l2_format *f)
>+{
>+	struct vpu_instance *inst = wave5_to_vpu_inst(fh);
>+	int i, ret;
>+
>+	dev_dbg(inst->dev->dev, "%s: fourcc: %d width: %d height: %d num_planes: %d field: %d\n",
>+		__func__, f->fmt.pix_mp.pixelformat, f->fmt.pix_mp.width, f->fmt.pix_mp.height,
>+		f->fmt.pix_mp.num_planes, f->fmt.pix_mp.field);
>+
>+	ret = wave5_vpu_enc_try_fmt_cap(file, fh, f);
>+	if (ret)
>+		return ret;
>+
>+	inst->dst_fmt.width = f->fmt.pix_mp.width;
>+	inst->dst_fmt.height = f->fmt.pix_mp.height;
>+	inst->dst_fmt.pixelformat = f->fmt.pix_mp.pixelformat;
>+	inst->dst_fmt.field = f->fmt.pix_mp.field;
>+	inst->dst_fmt.flags = f->fmt.pix_mp.flags;
>+	inst->dst_fmt.num_planes = f->fmt.pix_mp.num_planes;
>+	for (i = 0; i < inst->dst_fmt.num_planes; i++) {
>+		inst->dst_fmt.plane_fmt[i].bytesperline = f->fmt.pix_mp.plane_fmt[i].bytesperline;
>+		inst->dst_fmt.plane_fmt[i].sizeimage = f->fmt.pix_mp.plane_fmt[i].sizeimage;
>+	}
>+
>+	return 0;
>+}
>+
>+static int wave5_vpu_enc_g_fmt_cap(struct file *file, void *fh, struct v4l2_format *f)
>+{
>+	struct vpu_instance *inst = wave5_to_vpu_inst(fh);
>+	int i;
>+
>+	f->fmt.pix_mp.width = inst->dst_fmt.width;
>+	f->fmt.pix_mp.height = inst->dst_fmt.height;
>+	f->fmt.pix_mp.pixelformat = inst->dst_fmt.pixelformat;
>+	f->fmt.pix_mp.field = inst->dst_fmt.field;
>+	f->fmt.pix_mp.flags = inst->dst_fmt.flags;
>+	f->fmt.pix_mp.num_planes = inst->dst_fmt.num_planes;
>+	for (i = 0; i < f->fmt.pix_mp.num_planes; i++) {
>+		f->fmt.pix_mp.plane_fmt[i].bytesperline = inst->dst_fmt.plane_fmt[i].bytesperline;
>+		f->fmt.pix_mp.plane_fmt[i].sizeimage = inst->dst_fmt.plane_fmt[i].sizeimage;
>+	}
>+
>+	f->fmt.pix_mp.colorspace = inst->colorspace;
>+	f->fmt.pix_mp.ycbcr_enc = inst->ycbcr_enc;
>+	f->fmt.pix_mp.hsv_enc = inst->hsv_enc;
>+	f->fmt.pix_mp.quantization = inst->quantization;
>+	f->fmt.pix_mp.xfer_func = inst->xfer_func;
>+
>+	return 0;
>+}
>+
>+static int wave5_vpu_enc_enum_fmt_out(struct file *file, void *fh, struct v4l2_fmtdesc *f)
>+{
>+	struct vpu_instance *inst = wave5_to_vpu_inst(fh);
>+	const struct vpu_format *vpu_fmt;
>+
>+	dev_dbg(inst->dev->dev, "%s: index: %d\n", __func__, f->index);
>+
>+	vpu_fmt = wave5_find_vpu_fmt_by_idx(f->index, enc_fmt_list[VPU_FMT_TYPE_RAW]);
>+	if (!vpu_fmt)
>+		return -EINVAL;
>+
>+	f->pixelformat = vpu_fmt->v4l2_pix_fmt;
>+	f->flags = 0;
>+
>+	return 0;
>+}
>+
>+static int wave5_vpu_enc_try_fmt_out(struct file *file, void *fh, struct v4l2_format *f)
>+{
>+	struct vpu_instance *inst = wave5_to_vpu_inst(fh);
>+	const struct vpu_format *vpu_fmt;
>+
>+	dev_dbg(inst->dev->dev, "%s: fourcc: %d width: %d height: %d num_planes: %d field: %d\n",
>+		__func__, f->fmt.pix_mp.pixelformat, f->fmt.pix_mp.width, f->fmt.pix_mp.height,
>+		f->fmt.pix_mp.num_planes, f->fmt.pix_mp.field);
>+
>+	if (f->type != V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
>+		return -EINVAL;
>+
>+	vpu_fmt = wave5_find_vpu_fmt(f->fmt.pix_mp.pixelformat, enc_fmt_list[VPU_FMT_TYPE_RAW]);
>+	if (!vpu_fmt) {
>+		f->fmt.pix_mp.pixelformat = inst->src_fmt.pixelformat;
>+		f->fmt.pix_mp.num_planes = inst->src_fmt.num_planes;
>+		wave5_update_pix_fmt(&f->fmt.pix_mp, inst->src_fmt.width, inst->src_fmt.height);
>+	} else {
>+		int width = clamp(f->fmt.pix_mp.width, vpu_fmt->min_width, vpu_fmt->max_width);
>+		int height = clamp(f->fmt.pix_mp.height, vpu_fmt->min_height, vpu_fmt->max_height);
>+		const struct v4l2_format_info *info = v4l2_format_info(vpu_fmt->v4l2_pix_fmt);
>+
>+		f->fmt.pix_mp.pixelformat = vpu_fmt->v4l2_pix_fmt;
>+		f->fmt.pix_mp.num_planes = info->mem_planes;
>+		wave5_update_pix_fmt(&f->fmt.pix_mp, width, height);
>+	}
>+
>+	f->fmt.pix_mp.flags = 0;
>+	f->fmt.pix_mp.field = V4L2_FIELD_NONE;
>+	memset(&f->fmt.pix_mp.reserved, 0, sizeof(f->fmt.pix_mp.reserved));
>+
>+	return 0;
>+}
>+
>+static int wave5_vpu_enc_s_fmt_out(struct file *file, void *fh, struct v4l2_format *f)
>+{
>+	struct vpu_instance *inst = wave5_to_vpu_inst(fh);
>+	int i, ret;
>+
>+	dev_dbg(inst->dev->dev, "%s: fourcc: %d width: %d height: %d num_planes: %d field: %d\n",
>+		__func__, f->fmt.pix_mp.pixelformat, f->fmt.pix_mp.width, f->fmt.pix_mp.height,
>+		f->fmt.pix_mp.num_planes, f->fmt.pix_mp.field);
>+
>+	ret = wave5_vpu_enc_try_fmt_out(file, fh, f);
>+	if (ret)
>+		return ret;
>+
>+	inst->src_fmt.width = f->fmt.pix_mp.width;
>+	inst->src_fmt.height = f->fmt.pix_mp.height;
>+	inst->src_fmt.pixelformat = f->fmt.pix_mp.pixelformat;
>+	inst->src_fmt.field = f->fmt.pix_mp.field;
>+	inst->src_fmt.flags = f->fmt.pix_mp.flags;
>+	inst->src_fmt.num_planes = f->fmt.pix_mp.num_planes;
>+	for (i = 0; i < inst->src_fmt.num_planes; i++) {
>+		inst->src_fmt.plane_fmt[i].bytesperline = f->fmt.pix_mp.plane_fmt[i].bytesperline;
>+		inst->src_fmt.plane_fmt[i].sizeimage = f->fmt.pix_mp.plane_fmt[i].sizeimage;
>+	}
>+
>+	if (inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV12 ||
>+	    inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV12M) {
>+		inst->cbcr_interleave = true;
>+		inst->nv21 = false;
>+	} else if (inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV21 ||
>+		   inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV21M) {
>+		inst->cbcr_interleave = true;
>+		inst->nv21 = true;
>+	} else {
>+		inst->cbcr_interleave = false;
>+		inst->nv21 = false;
>+	}
>+
>+	inst->colorspace = f->fmt.pix_mp.colorspace;
>+	inst->ycbcr_enc = f->fmt.pix_mp.ycbcr_enc;
>+	inst->hsv_enc = f->fmt.pix_mp.hsv_enc;
>+	inst->quantization = f->fmt.pix_mp.quantization;
>+	inst->xfer_func = f->fmt.pix_mp.xfer_func;
>+
>+	wave5_update_pix_fmt(&inst->dst_fmt, f->fmt.pix_mp.width, f->fmt.pix_mp.height);
>+
>+	return 0;
>+}
>+
>+static int wave5_vpu_enc_g_selection(struct file *file, void *fh, struct v4l2_selection *s)
>+{
>+	struct vpu_instance *inst = wave5_to_vpu_inst(fh);
>+
>+	dev_dbg(inst->dev->dev, "%s: type: %d | target: %d\n", __func__, s->type, s->target);
>+
>+	if (s->type == V4L2_BUF_TYPE_VIDEO_OUTPUT) {
>+		switch (s->target) {
>+		case V4L2_SEL_TGT_CROP_DEFAULT:
>+		case V4L2_SEL_TGT_CROP_BOUNDS:
>+			s->r.left = 0;
>+			s->r.top = 0;
>+			s->r.width = inst->dst_fmt.width;
>+			s->r.height = inst->dst_fmt.height;
>+			break;
>+		case V4L2_SEL_TGT_CROP:
>+			s->r.left = 0;
>+			s->r.top = 0;
>+			s->r.width = inst->dst_fmt.width;
>+			s->r.height = inst->dst_fmt.height;
>+			dev_dbg(inst->dev->dev, "%s: V4L2_SEL_TGT_CROP width: %d | height: %d\n",
>+				__func__, s->r.width, s->r.height);
>+			break;
>+		default:
>+			return -EINVAL;
>+		}
>+	} else {
>+		return -EINVAL;
>+	}
>+
>+	return 0;
>+}
>+
>+static int wave5_vpu_enc_s_selection(struct file *file, void *fh, struct v4l2_selection *s)
>+{
>+	struct vpu_instance *inst = wave5_to_vpu_inst(fh);
>+
>+	if (s->type != V4L2_BUF_TYPE_VIDEO_OUTPUT)
>+		return -EINVAL;
>+
>+	if (s->target != V4L2_SEL_TGT_CROP)
>+		return -EINVAL;
>+
>+	dev_dbg(inst->dev->dev, "%s: V4L2_SEL_TGT_CROP width: %d | height: %d\n",
>+		__func__, s->r.width, s->r.height);
>+
>+	s->r.left = 0;
>+	s->r.top = 0;
>+	s->r.width = inst->src_fmt.width;
>+	s->r.height = inst->src_fmt.height;
>+
>+	return 0;
>+}
>+
>+static int wave5_vpu_enc_encoder_cmd(struct file *file, void *fh, struct v4l2_encoder_cmd *ec)
>+{
>+	struct vpu_instance *inst = wave5_to_vpu_inst(fh);
>+	int ret;
>+
>+	ret = v4l2_m2m_ioctl_try_encoder_cmd(file, fh, ec);
>+	if (ret)
>+		return ret;
>+
>+	if (!wave5_vpu_both_queues_are_streaming(inst))
>+		return 0;
>+
>+	switch (ec->cmd) {
>+	case V4L2_ENC_CMD_STOP:
>+		inst->state = VPU_INST_STATE_STOP;
>+		inst->ops->start_process(inst);
>+		break;
>+	case V4L2_ENC_CMD_START:
>+		break;
>+	default:
>+		return -EINVAL;
>+	}
>+
>+	return 0;
>+}
>+
>+static int wave5_vpu_enc_g_parm(struct file *file, void *fh, struct v4l2_streamparm *a)
>+{
>+	struct vpu_instance *inst = wave5_to_vpu_inst(fh);
>+
>+	dev_dbg(inst->dev->dev, "%s: type: %d\n", __func__, a->type);
>+
>+	if (a->type != V4L2_BUF_TYPE_VIDEO_OUTPUT && a->type != V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
>+		return -EINVAL;
>+
>+	a->parm.output.capability = V4L2_CAP_TIMEPERFRAME;
>+	a->parm.output.timeperframe.numerator = 1;
>+	a->parm.output.timeperframe.denominator = inst->frame_rate;
>+
>+	dev_dbg(inst->dev->dev, "%s: numerator: %d | denominator: %d\n",
>+		__func__, a->parm.output.timeperframe.numerator,
>+		a->parm.output.timeperframe.denominator);
>+
>+	return 0;
>+}
>+
>+static int wave5_vpu_enc_s_parm(struct file *file, void *fh, struct v4l2_streamparm *a)
>+{
>+	struct vpu_instance *inst = wave5_to_vpu_inst(fh);
>+
>+	dev_dbg(inst->dev->dev, "%s: type: %d\n", __func__, a->type);
>+
>+	if (a->type != V4L2_BUF_TYPE_VIDEO_OUTPUT && a->type != V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
>+		return -EINVAL;
>+
>+	a->parm.output.capability = V4L2_CAP_TIMEPERFRAME;
>+	if (a->parm.output.timeperframe.denominator && a->parm.output.timeperframe.numerator) {
>+		inst->frame_rate = a->parm.output.timeperframe.denominator /
>+				   a->parm.output.timeperframe.numerator;
>+	} else {
>+		a->parm.output.timeperframe.numerator = 1;
>+		a->parm.output.timeperframe.denominator = inst->frame_rate;
>+	}
>+
>+	dev_dbg(inst->dev->dev, "%s: numerator: %d | denominator: %d\n",
>+		__func__, a->parm.output.timeperframe.numerator,
>+		a->parm.output.timeperframe.denominator);
>+
>+	return 0;
>+}
>+
>+static const struct v4l2_ioctl_ops wave5_vpu_enc_ioctl_ops = {
>+	.vidioc_querycap = wave5_vpu_enc_querycap,
>+	.vidioc_enum_framesizes = wave5_vpu_enc_enum_framesizes,
>+
>+	.vidioc_enum_fmt_vid_cap	= wave5_vpu_enc_enum_fmt_cap,
>+	.vidioc_s_fmt_vid_cap_mplane = wave5_vpu_enc_s_fmt_cap,
>+	.vidioc_g_fmt_vid_cap_mplane = wave5_vpu_enc_g_fmt_cap,
>+	.vidioc_try_fmt_vid_cap_mplane = wave5_vpu_enc_try_fmt_cap,
>+
>+	.vidioc_enum_fmt_vid_out	= wave5_vpu_enc_enum_fmt_out,
>+	.vidioc_s_fmt_vid_out_mplane = wave5_vpu_enc_s_fmt_out,
>+	.vidioc_g_fmt_vid_out_mplane = wave5_vpu_g_fmt_out,
>+	.vidioc_try_fmt_vid_out_mplane = wave5_vpu_enc_try_fmt_out,
>+
>+	.vidioc_g_selection = wave5_vpu_enc_g_selection,
>+	.vidioc_s_selection = wave5_vpu_enc_s_selection,
>+
>+	.vidioc_g_parm = wave5_vpu_enc_g_parm,
>+	.vidioc_s_parm = wave5_vpu_enc_s_parm,
>+
>+	.vidioc_reqbufs = v4l2_m2m_ioctl_reqbufs,
>+	.vidioc_querybuf = v4l2_m2m_ioctl_querybuf,
>+	.vidioc_create_bufs = v4l2_m2m_ioctl_create_bufs,
>+	.vidioc_prepare_buf = v4l2_m2m_ioctl_prepare_buf,
>+	.vidioc_qbuf = v4l2_m2m_ioctl_qbuf,
>+	.vidioc_expbuf = v4l2_m2m_ioctl_expbuf,
>+	.vidioc_dqbuf = v4l2_m2m_ioctl_dqbuf,
>+	.vidioc_streamon = v4l2_m2m_ioctl_streamon,
>+	.vidioc_streamoff = v4l2_m2m_ioctl_streamoff,
>+
>+	.vidioc_try_encoder_cmd = v4l2_m2m_ioctl_try_encoder_cmd,
>+	.vidioc_encoder_cmd = wave5_vpu_enc_encoder_cmd,
>+
>+	.vidioc_subscribe_event = wave5_vpu_subscribe_event,
>+	.vidioc_unsubscribe_event = v4l2_event_unsubscribe,
>+};
>+
>+static int wave5_vpu_enc_s_ctrl(struct v4l2_ctrl *ctrl)
>+{
>+	struct vpu_instance *inst = wave5_ctrl_to_vpu_inst(ctrl);
>+
>+	dev_dbg(inst->dev->dev, "%s: name: %s | value: %d\n", __func__, ctrl->name, ctrl->val);
>+
>+	switch (ctrl->id) {
>+	case V4L2_CID_HFLIP:
>+		inst->mirror_direction |= (ctrl->val << 1);
>+		break;
>+	case V4L2_CID_VFLIP:
>+		inst->mirror_direction |= ctrl->val;
>+		break;
>+	case V4L2_CID_ROTATE:
>+		inst->rot_angle = ctrl->val;
>+		break;
>+	case V4L2_CID_MPEG_VIDEO_VBV_SIZE:
>+		inst->vbv_buf_size = ctrl->val;
>+		break;
>+	case V4L2_CID_MPEG_VIDEO_HEVC_PROFILE:
>+		switch (ctrl->val) {
>+		case V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN:
>+			inst->profile = HEVC_PROFILE_MAIN;
>+			inst->bit_depth = 8;
>+			break;
>+		case V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_STILL_PICTURE:
>+			inst->profile = HEVC_PROFILE_STILLPICTURE;
>+			inst->bit_depth = 8;
>+			break;
>+		case V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_10:
>+			inst->profile = HEVC_PROFILE_MAIN10;
>+			inst->bit_depth = 10;
>+			break;
>+		default:
>+			return -EINVAL;
>+		}
>+		break;
>+	case V4L2_CID_MPEG_VIDEO_HEVC_LEVEL:
>+		switch (ctrl->val) {
>+		case V4L2_MPEG_VIDEO_HEVC_LEVEL_1:
>+			inst->level = 10 * 3;
>+			break;
>+		case V4L2_MPEG_VIDEO_HEVC_LEVEL_2:
>+			inst->level = 20 * 3;
>+			break;
>+		case V4L2_MPEG_VIDEO_HEVC_LEVEL_2_1:
>+			inst->level = 21 * 3;
>+			break;
>+		case V4L2_MPEG_VIDEO_HEVC_LEVEL_3:
>+			inst->level = 30 * 3;
>+			break;
>+		case V4L2_MPEG_VIDEO_HEVC_LEVEL_3_1:
>+			inst->level = 31 * 3;
>+			break;
>+		case V4L2_MPEG_VIDEO_HEVC_LEVEL_4:
>+			inst->level = 40 * 3;
>+			break;
>+		case V4L2_MPEG_VIDEO_HEVC_LEVEL_4_1:
>+			inst->level = 41 * 3;
>+			break;
>+		case V4L2_MPEG_VIDEO_HEVC_LEVEL_5:
>+			inst->level = 50 * 3;
>+			break;
>+		case V4L2_MPEG_VIDEO_HEVC_LEVEL_5_1:
>+			inst->level = 51 * 3;
>+			break;
>+		case V4L2_MPEG_VIDEO_HEVC_LEVEL_5_2:
>+			inst->level = 52 * 3;
>+			break;
>+		default:
>+			return -EINVAL;
>+		}
>+		break;
>+	case V4L2_CID_MPEG_VIDEO_HEVC_MIN_QP:
>+		inst->min_qp_i = ctrl->val;
>+		inst->min_qp_p = ctrl->val;
>+		inst->min_qp_b = ctrl->val;
>+		break;
>+	case V4L2_CID_MPEG_VIDEO_HEVC_MAX_QP:
>+		inst->max_qp_i = ctrl->val;
>+		inst->max_qp_p = ctrl->val;
>+		inst->max_qp_b = ctrl->val;
>+		break;
>+	case V4L2_CID_MPEG_VIDEO_H264_PROFILE:
>+		switch (ctrl->val) {
>+		case V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE:
>+		case V4L2_MPEG_VIDEO_H264_PROFILE_CONSTRAINED_BASELINE:
>+			inst->profile = H264_PROFILE_BP;
>+			inst->bit_depth = 8;
>+			break;
>+		case V4L2_MPEG_VIDEO_H264_PROFILE_MAIN:
>+			inst->profile = H264_PROFILE_MP;
>+			inst->bit_depth = 8;
>+			break;
>+		case V4L2_MPEG_VIDEO_H264_PROFILE_EXTENDED:
>+			inst->profile = H264_PROFILE_EXTENDED;
>+			inst->bit_depth = 8;
>+			break;
>+		case V4L2_MPEG_VIDEO_H264_PROFILE_HIGH:
>+			inst->profile = H264_PROFILE_HP;
>+			inst->bit_depth = 8;
>+			break;
>+		case V4L2_MPEG_VIDEO_H264_PROFILE_HIGH_10:
>+			inst->profile = H264_PROFILE_HIGH10;
>+			inst->bit_depth = 10;
>+			break;
>+		case V4L2_MPEG_VIDEO_H264_PROFILE_HIGH_422:
>+			inst->profile = H264_PROFILE_HIGH422;
>+			inst->bit_depth = 10;
>+			break;
>+		case V4L2_MPEG_VIDEO_H264_PROFILE_HIGH_444_PREDICTIVE:
>+			inst->profile = H264_PROFILE_HIGH444;
>+			inst->bit_depth = 10;
>+			break;
>+		default:
>+			return -EINVAL;
>+		}
>+		break;
>+	case V4L2_CID_MPEG_VIDEO_H264_LEVEL:
>+		switch (ctrl->val) {
>+		case V4L2_MPEG_VIDEO_H264_LEVEL_1_0:
>+			inst->level = 10;
>+			break;
>+		case V4L2_MPEG_VIDEO_H264_LEVEL_1B:
>+			inst->level = 9;
>+			break;
>+		case V4L2_MPEG_VIDEO_H264_LEVEL_1_1:
>+			inst->level = 11;
>+			break;
>+		case V4L2_MPEG_VIDEO_H264_LEVEL_1_2:
>+			inst->level = 12;
>+			break;
>+		case V4L2_MPEG_VIDEO_H264_LEVEL_1_3:
>+			inst->level = 13;
>+			break;
>+		case V4L2_MPEG_VIDEO_H264_LEVEL_2_0:
>+			inst->level = 20;
>+			break;
>+		case V4L2_MPEG_VIDEO_H264_LEVEL_2_1:
>+			inst->level = 21;
>+			break;
>+		case V4L2_MPEG_VIDEO_H264_LEVEL_2_2:
>+			inst->level = 22;
>+			break;
>+		case V4L2_MPEG_VIDEO_H264_LEVEL_3_0:
>+			inst->level = 30;
>+			break;
>+		case V4L2_MPEG_VIDEO_H264_LEVEL_3_1:
>+			inst->level = 31;
>+			break;
>+		case V4L2_MPEG_VIDEO_H264_LEVEL_3_2:
>+			inst->level = 32;
>+			break;
>+		case V4L2_MPEG_VIDEO_H264_LEVEL_4_0:
>+			inst->level = 40;
>+			break;
>+		case V4L2_MPEG_VIDEO_H264_LEVEL_4_1:
>+			inst->level = 41;
>+			break;
>+		case V4L2_MPEG_VIDEO_H264_LEVEL_4_2:
>+			inst->level = 42;
>+			break;
>+		case V4L2_MPEG_VIDEO_H264_LEVEL_5_0:
>+			inst->level = 50;
>+			break;
>+		case V4L2_MPEG_VIDEO_H264_LEVEL_5_1:
>+			inst->level = 51;
>+			break;
>+		default:
>+			return -EINVAL;
>+		}
>+		break;
>+	case V4L2_CID_MPEG_VIDEO_H264_MIN_QP:
>+		inst->min_qp_i = ctrl->val;
>+		inst->min_qp_p = ctrl->val;
>+		inst->min_qp_b = ctrl->val;
>+		break;
>+	case V4L2_CID_MPEG_VIDEO_H264_MAX_QP:
>+		inst->max_qp_i = ctrl->val;
>+		inst->max_qp_p = ctrl->val;
>+		inst->max_qp_b = ctrl->val;
>+		break;
>+	case V4L2_CID_MIN_BUFFERS_FOR_OUTPUT:
>+		break;
>+	default:
>+		return -EINVAL;
>+	}
>+
>+	return 0;
>+}
>+
>+static const struct v4l2_ctrl_ops wave5_vpu_enc_ctrl_ops = {
>+	.s_ctrl = wave5_vpu_enc_s_ctrl,
>+};
>+
>+static void wave5_set_default_enc_openparam(struct enc_open_param *open_param)
>+{
>+	unsigned int i;
>+
>+	open_param->stream_endian = VPU_STREAM_ENDIAN;
>+	open_param->source_endian = VPU_SOURCE_ENDIAN;
>+	open_param->line_buf_int_en = true;
>+
>+	open_param->wave_param.gop_preset_idx = PRESET_IDX_IPP_SINGLE;
>+	open_param->wave_param.decoding_refresh_type = DEC_REFRESH_TYPE_NON_IRAP;
>+	open_param->wave_param.intra_qp = 30;
>+	open_param->wave_param.tmvp_enable = 1;
>+	open_param->wave_param.max_num_merge = 2;
>+	open_param->wave_param.lf_cross_slice_boundary_enable = 1;
>+	open_param->wave_param.skip_intra_trans = 1;
>+	open_param->wave_param.sao_enable = 1;
>+	open_param->wave_param.transform8x8_enable = 1;
>+	open_param->wave_param.intra_nx_n_enable = 1;
>+	for (i = 0; i < MAX_GOP_NUM; i++)
>+		open_param->wave_param.fixed_bit_ratio[i] = 1;
>+	open_param->wave_param.cu_level_rc_enable = 1;
>+	open_param->wave_param.hvs_qp_enable = 1;
>+	open_param->wave_param.hvs_qp_scale = 2;
>+	open_param->wave_param.hvs_max_delta_qp = 10;
>+	open_param->wave_param.gop_param.custom_gop_size = 1;
>+	open_param->wave_param.initial_rc_qp = -1;
>+	open_param->wave_param.nr_intra_weight_y = 7;
>+	open_param->wave_param.nr_intra_weight_cb = 7;
>+	open_param->wave_param.nr_intra_weight_cr = 7;
>+	open_param->wave_param.nr_inter_weight_y = 4;
>+	open_param->wave_param.nr_inter_weight_cb = 4;
>+	open_param->wave_param.nr_inter_weight_cr = 4;
>+	open_param->wave_param.strong_intra_smooth_enable = 1;
>+	open_param->wave_param.bg_thr_diff = 8;
>+	open_param->wave_param.bg_thr_mean_diff = 1;
>+	open_param->wave_param.bg_lambda_qp = 32;
>+	open_param->wave_param.bg_delta_qp = 3;
>+	open_param->wave_param.rdo_skip = 1;
>+	open_param->wave_param.intra_mb_refresh_arg = 1;
>+	open_param->wave_param.entropy_coding_mode = 1;
>+	open_param->wave_param.rc_weight_param = 16;
>+	open_param->wave_param.rc_weight_buf = 128;
>+	open_param->wave_param.lambda_scaling_enable = 1;
>+}
>+
>+static int wave5_vpu_enc_queue_setup(struct vb2_queue *q, unsigned int *num_buffers,
>+				     unsigned int *num_planes, unsigned int sizes[],
>+				     struct device *alloc_devs[])
>+{
>+	struct vpu_instance *inst = vb2_get_drv_priv(q);
>+	struct v4l2_pix_format_mplane inst_format =
>+		(q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) ? inst->src_fmt : inst->dst_fmt;
>+	unsigned int i;
>+	int ret;
>+
>+	dev_dbg(inst->dev->dev, "%s: num_buffers: %d | num_planes: %d | type: %d\n", __func__,
>+		*num_buffers, *num_planes, q->type);
>+
>+	if (*num_planes) {
>+		if (inst_format.num_planes != *num_planes)
>+			return -EINVAL;
>+
>+		for (i = 0; i < *num_planes; i++) {
>+			if (sizes[i] < inst_format.plane_fmt[i].sizeimage)
>+				return -EINVAL;
>+		}
>+	} else {
>+		*num_planes = inst_format.num_planes;
>+		for (i = 0; i < *num_planes; i++) {
>+			sizes[i] = inst_format.plane_fmt[i].sizeimage;
>+			dev_dbg(inst->dev->dev, "%s: size[%d]: %d\n", __func__, i, sizes[i]);
>+		}
>+	}
>+
>+	dev_dbg(inst->dev->dev, "%s: size: %d\n", __func__, sizes[0]);
>+
>+	if (inst->state == VPU_INST_STATE_NONE && q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
>+		unsigned int non_linear_num = 0;
>+		u32 fb_stride = 0;
>+		u32 fb_height = 0;
>+		struct enc_open_param open_param;
>+		struct enc_initial_info initial_info;
>+		struct v4l2_ctrl *ctrl;
>+
>+		memset(&open_param, 0, sizeof(struct enc_open_param));
>+		wave5_set_default_enc_openparam(&open_param);
>+
>+		inst->std = wave5_to_vpu_wavestd(inst->dst_fmt.pixelformat);
>+		if (inst->std == STD_UNKNOWN) {
>+			dev_warn(inst->dev->dev, "unsupported pixelformat: %.4s\n",
>+				 (char *)&inst->dst_fmt.pixelformat);
>+			return -EINVAL;
>+		}
>+		open_param.pic_width = inst->dst_fmt.width;
>+		open_param.pic_height = inst->dst_fmt.height;
>+		open_param.frame_rate_info = inst->frame_rate;
>+		open_param.vbv_buffer_size = inst->vbv_buf_size;
>+		open_param.wave_param.profile = inst->profile;
>+		open_param.wave_param.level = inst->level;
>+		open_param.wave_param.internal_bit_depth = inst->bit_depth;
>+		open_param.wave_param.min_qp_i = inst->min_qp_i;
>+		open_param.wave_param.max_qp_i = inst->max_qp_i;
>+		open_param.wave_param.min_qp_p = inst->min_qp_p;
>+		open_param.wave_param.max_qp_p = inst->max_qp_p;
>+		open_param.wave_param.min_qp_b = inst->min_qp_b;
>+		open_param.wave_param.max_qp_b = inst->max_qp_b;
>+
>+		ret = wave5_vpu_enc_open(inst, &open_param);
>+		if (ret) {
>+			dev_dbg(inst->dev->dev, "%s: wave5_vpu_enc_open, fail: %d\n",
>+				__func__, ret);
>+			return ret;
>+		}
>+
>+		inst->state = VPU_INST_STATE_OPEN;
>+
>+		if (inst->mirror_direction) {
>+			wave5_vpu_enc_give_command(inst, ENABLE_MIRRORING, NULL);
>+			wave5_vpu_enc_give_command(inst, SET_MIRROR_DIRECTION,
>+						   &inst->mirror_direction);
>+		}
>+		if (inst->rot_angle) {
>+			wave5_vpu_enc_give_command(inst, ENABLE_ROTATION, NULL);
>+			wave5_vpu_enc_give_command(inst, SET_ROTATION_ANGLE, &inst->rot_angle);
>+		}
>+
>+		ret = wave5_vpu_enc_issue_seq_init(inst);
>+		if (ret) {
>+			dev_dbg(inst->dev->dev, "%s: wave5_vpu_enc_issue_seq_init, fail: %d\n",
>+				__func__, ret);
>+			return ret;
>+		}
>+
>+		if (wave5_vpu_wait_interrupt(inst, VPU_ENC_TIMEOUT) < 0) {
>+			dev_dbg(inst->dev->dev, "%s: wave5_vpu_wait_interrupt failed\n", __func__);
>+			return -EINVAL;
>+		}
>+
>+		ret = wave5_vpu_enc_complete_seq_init(inst, &initial_info);
>+		if (ret)
>+			return ret;
>+
>+		dev_dbg(inst->dev->dev, "%s: min_frame_buffer: %d | min_source_buffer: %d\n",
>+			__func__, initial_info.min_frame_buffer_count,
>+			initial_info.min_src_frame_count);
>+		inst->state = VPU_INST_STATE_INIT_SEQ;
>+		inst->min_src_buf_count = initial_info.min_src_frame_count +
>+					  COMMAND_QUEUE_DEPTH;
>+
>+		ctrl = v4l2_ctrl_find(&inst->v4l2_ctrl_hdl,
>+				      V4L2_CID_MIN_BUFFERS_FOR_OUTPUT);
>+		if (ctrl)
>+			v4l2_ctrl_s_ctrl(ctrl, inst->min_src_buf_count);
>+
>+		inst->min_dst_buf_count = initial_info.min_frame_buffer_count;
>+		inst->src_buf_count = inst->min_src_buf_count;
>+
>+		if (*num_buffers > inst->src_buf_count)
>+			inst->src_buf_count = *num_buffers;
>+
>+		*num_buffers = inst->src_buf_count;
>+		non_linear_num = inst->min_dst_buf_count;
>+
>+		fb_stride = ALIGN(inst->dst_fmt.width, 32);
>+		fb_height = ALIGN(inst->dst_fmt.height, 32);
>+
>+		for (i = 0; i < non_linear_num; i++) {
>+			u32 luma_size = fb_stride * fb_height;
>+			u32 chroma_size = ALIGN(fb_stride / 2, 16) * fb_height;
>+
>+			inst->frame_vbuf[i].size = luma_size + chroma_size;
>+			ret = wave5_vdi_allocate_dma_memory(inst->dev, &inst->frame_vbuf[i]);
>+			if (ret < 0) {
>+				dev_dbg(inst->dev->dev, "%s: failed to allocate FBC buffer %zu\n",
>+					__func__, inst->frame_vbuf[i].size);
>+				goto free_buffers;
>+			}
>+
>+			inst->frame_buf[i].buf_y = inst->frame_vbuf[i].daddr;
>+			inst->frame_buf[i].buf_cb = (dma_addr_t)-1;
>+			inst->frame_buf[i].buf_cr = (dma_addr_t)-1;
>+			inst->frame_buf[i].update_fb_info = true;
>+			inst->frame_buf[i].size = inst->frame_vbuf[i].size;
>+		}
>+
>+		ret = wave5_vpu_enc_register_frame_buffer(inst, non_linear_num, fb_stride,
>+							  fb_height, COMPRESSED_FRAME_MAP);
>+		if (ret) {
>+			dev_dbg(inst->dev->dev,
>+				"%s: wave5_vpu_enc_register_frame_buffer, fail: %d\n",
>+				__func__, ret);
>+			goto free_buffers;
>+		}
>+
>+		inst->state = VPU_INST_STATE_PIC_RUN;
>+	}
>+
>+	if (inst->state == VPU_INST_STATE_INIT_SEQ &&
>+	    q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
>+		*num_buffers = inst->src_buf_count;
>+		dev_dbg(inst->dev->dev, "%s: src buf num: %d", __func__, *num_buffers);
>+	}
>+
>+	return 0;
>+
>+free_buffers:
>+	for (i = 0; i < inst->min_dst_buf_count; i++)
>+		wave5_vdi_free_dma_memory(inst->dev, &inst->frame_vbuf[i]);
>+	return ret;
>+}
>+
>+static void wave5_vpu_enc_buf_queue(struct vb2_buffer *vb)
>+{
>+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
>+	struct vpu_instance *inst = vb2_get_drv_priv(vb->vb2_queue);
>+	struct vpu_buffer *vpu_buf = wave5_to_vpu_buf(vbuf);
>+
>+	dev_dbg(inst->dev->dev, "%s: type: %4d index: %4d size: ([0]=%4ld, [1]=%4ld, [2]=%4ld)\n",
>+		__func__, vb->type, vb->index, vb2_plane_size(&vbuf->vb2_buf, 0),
>+		vb2_plane_size(&vbuf->vb2_buf, 1), vb2_plane_size(&vbuf->vb2_buf, 2));
>+
>+	if (vb->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
>+		vbuf->sequence = inst->queued_src_buf_num++;
>+	else
>+		vbuf->sequence = inst->queued_dst_buf_num++;
>+
>+	vpu_buf->consumed = FALSE;
>+	v4l2_m2m_buf_queue(inst->v4l2_fh.m2m_ctx, vbuf);
>+
>+	if (vb2_start_streaming_called(vb->vb2_queue))
>+		inst->ops->start_process(inst);
>+}
>+
>+static void wave5_vpu_enc_stop_streaming(struct vb2_queue *q)
>+{
>+	struct vpu_instance *inst = vb2_get_drv_priv(q);
>+	struct vb2_v4l2_buffer *buf;
>+	bool check_cmd = true;
>+
>+	dev_dbg(inst->dev->dev, "%s: type: %d\n", __func__, q->type);
>+
>+	if (wave5_vpu_both_queues_are_streaming(inst))
>+		inst->state = VPU_INST_STATE_STOP;
>+
>+	while (check_cmd) {
>+		struct queue_status_info q_status;
>+		struct enc_output_info enc_output_info;
>+		int ret;
>+
>+		wave5_vpu_enc_give_command(inst, ENC_GET_QUEUE_STATUS, &q_status);
>+
>+		if (q_status.instance_queue_count + q_status.report_queue_count == 0)
>+			break;
>+
>+		if (wave5_vpu_wait_interrupt(inst, VPU_ENC_TIMEOUT) < 0)
>+			break;
>+
>+		ret = wave5_vpu_enc_get_output_info(inst, &enc_output_info);
>+	}
>+
>+	if (q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
>+		while ((buf = v4l2_m2m_src_buf_remove(inst->v4l2_fh.m2m_ctx))) {
>+			dev_dbg(inst->dev->dev, "%s: buf type %4d | index %4d\n",
>+				__func__, buf->vb2_buf.type, buf->vb2_buf.index);
>+			v4l2_m2m_buf_done(buf, VB2_BUF_STATE_ERROR);
>+		}
>+	} else {
>+		while ((buf = v4l2_m2m_dst_buf_remove(inst->v4l2_fh.m2m_ctx))) {
>+			dev_dbg(inst->dev->dev, "%s: buf type %4d | index %4d\n",
>+				__func__, buf->vb2_buf.type, buf->vb2_buf.index);
>+			vb2_set_plane_payload(&buf->vb2_buf, 0, 0);
>+			v4l2_m2m_buf_done(buf, VB2_BUF_STATE_ERROR);
>+		}
>+	}
>+}
>+
>+static const struct vb2_ops wave5_vpu_enc_vb2_ops = {
>+	.queue_setup = wave5_vpu_enc_queue_setup,
>+	.wait_prepare = vb2_ops_wait_prepare,
>+	.wait_finish = vb2_ops_wait_finish,
>+	.buf_queue = wave5_vpu_enc_buf_queue,
>+	.stop_streaming = wave5_vpu_enc_stop_streaming,
>+};
>+
>+static void wave5_set_default_format(struct v4l2_pix_format_mplane *src_fmt,
>+				     struct v4l2_pix_format_mplane *dst_fmt)
>+{
>+	unsigned int src_pix_fmt = enc_fmt_list[VPU_FMT_TYPE_RAW][0].v4l2_pix_fmt;
>+	const struct v4l2_format_info *src_fmt_info = v4l2_format_info(src_pix_fmt);
>+
>+	src_fmt->pixelformat = src_pix_fmt;
>+	src_fmt->field = V4L2_FIELD_NONE;
>+	src_fmt->flags = 0;
>+	src_fmt->num_planes = src_fmt_info->mem_planes;
>+	wave5_update_pix_fmt(src_fmt, 416, 240);
>+
>+	dst_fmt->pixelformat = enc_fmt_list[VPU_FMT_TYPE_CODEC][0].v4l2_pix_fmt;
>+	dst_fmt->field = V4L2_FIELD_NONE;
>+	dst_fmt->flags = 0;
>+	dst_fmt->num_planes = 1;
>+	wave5_update_pix_fmt(dst_fmt, 416, 240);
>+}
>+
>+static int wave5_vpu_enc_queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_vq)
>+{
>+	return wave5_vpu_queue_init(priv, src_vq, dst_vq, &wave5_vpu_enc_vb2_ops);
>+}
>+
>+static const struct vpu_instance_ops wave5_vpu_enc_inst_ops = {
>+	.start_process = wave5_vpu_enc_start_encode,
>+	.stop_process = wave5_vpu_enc_stop_encode,
>+	.finish_process = wave5_vpu_enc_finish_encode,
>+};
>+
>+static void wave5_vpu_enc_device_run(void *priv)
>+{
>+	struct vpu_instance *inst = priv;
>+
>+	inst->ops->start_process(inst);
>+}
>+
>+static int wave5_vpu_enc_job_ready(void *priv)
>+{
>+	struct vpu_instance *inst = priv;
>+
>+	if (inst->state == VPU_INST_STATE_STOP)
>+		return 0;
>+
>+	return 1;
>+}
>+
>+static void wave5_vpu_enc_job_abort(void *priv)
>+{
>+	struct vpu_instance *inst = priv;
>+
>+	inst->ops->stop_process(inst);
>+}
>+
>+static const struct v4l2_m2m_ops wave5_vpu_enc_m2m_ops = {
>+	.device_run = wave5_vpu_enc_device_run,
>+	.job_ready = wave5_vpu_enc_job_ready,
>+	.job_abort = wave5_vpu_enc_job_abort,
>+};
>+
>+static int wave5_vpu_open_enc(struct file *filp)
>+{
>+	struct video_device *vdev = video_devdata(filp);
>+	struct vpu_device *dev = video_drvdata(filp);
>+	struct vpu_instance *inst = NULL;
>+	struct v4l2_ctrl_handler *v4l2_ctrl_hdl;
>+	int ret = 0;
>+
>+	inst = kzalloc(sizeof(*inst), GFP_KERNEL);
>+	if (!inst)
>+		return -ENOMEM;
>+	v4l2_ctrl_hdl = &inst->v4l2_ctrl_hdl;
>+
>+	inst->dev = dev;
>+	inst->type = VPU_INST_TYPE_ENC;
>+	inst->ops = &wave5_vpu_enc_inst_ops;
>+
>+	v4l2_fh_init(&inst->v4l2_fh, vdev);
>+	filp->private_data = &inst->v4l2_fh;
>+	v4l2_fh_add(&inst->v4l2_fh);
>+
>+	INIT_LIST_HEAD(&inst->list);
>+	list_add_tail(&inst->list, &dev->instances);
>+
>+	inst->v4l2_m2m_dev = v4l2_m2m_init(&wave5_vpu_enc_m2m_ops);
>+	if (IS_ERR(inst->v4l2_m2m_dev)) {
>+		ret = PTR_ERR(inst->v4l2_m2m_dev);
>+		dev_err(inst->dev->dev, "v4l2_m2m_init, fail: %d\n", ret);
>+		goto cleanup_inst;
>+	}
>+
>+	inst->v4l2_fh.m2m_ctx =
>+		v4l2_m2m_ctx_init(inst->v4l2_m2m_dev, inst, wave5_vpu_enc_queue_init);
>+	if (IS_ERR(inst->v4l2_fh.m2m_ctx)) {
>+		ret = PTR_ERR(inst->v4l2_fh.m2m_ctx);
>+		goto cleanup_inst;
>+	}
>+
>+	v4l2_ctrl_handler_init(v4l2_ctrl_hdl, 30);
>+	v4l2_ctrl_new_std_menu(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
>+			       V4L2_CID_MPEG_VIDEO_HEVC_PROFILE,
>+			       V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_10, 0,
>+			       V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN);
>+	v4l2_ctrl_new_std_menu(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
>+			       V4L2_CID_MPEG_VIDEO_HEVC_LEVEL, V4L2_MPEG_VIDEO_HEVC_LEVEL_5_1, 0,
>+			       V4L2_MPEG_VIDEO_HEVC_LEVEL_1);
>+	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops, V4L2_CID_MPEG_VIDEO_HEVC_MIN_QP,
>+			  0, 63, 1, 8);
>+	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops, V4L2_CID_MPEG_VIDEO_HEVC_MAX_QP,
>+			  0, 63, 1, 51);
>+	v4l2_ctrl_new_std_menu(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
>+			       V4L2_CID_MPEG_VIDEO_H264_PROFILE,
>+			       V4L2_MPEG_VIDEO_H264_PROFILE_HIGH_444_PREDICTIVE, 0,
>+			       V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE);
>+	v4l2_ctrl_new_std_menu(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
>+			       V4L2_CID_MPEG_VIDEO_H264_LEVEL, V4L2_MPEG_VIDEO_H264_LEVEL_5_1, 0,
>+			       V4L2_MPEG_VIDEO_H264_LEVEL_1_0);
>+	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops, V4L2_CID_MPEG_VIDEO_H264_MIN_QP,
>+			  0, 63, 1, 8);
>+	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops, V4L2_CID_MPEG_VIDEO_H264_MAX_QP,
>+			  0, 63, 1, 51);
>+	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops, V4L2_CID_HFLIP, 0, 1, 1, 0);
>+	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops, V4L2_CID_VFLIP, 0, 1, 1, 0);
>+	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops, V4L2_CID_ROTATE, 0, 270, 90, 0);
>+	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops, V4L2_CID_MPEG_VIDEO_VBV_SIZE, 10,
>+			  3000, 1, 3000);
>+	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
>+			  V4L2_CID_MIN_BUFFERS_FOR_OUTPUT, 1, 32, 1, 1);
>+
>+	if (v4l2_ctrl_hdl->error) {
>+		ret = -ENODEV;
>+		goto cleanup_inst;
>+	}
>+
>+	inst->v4l2_fh.ctrl_handler = v4l2_ctrl_hdl;
>+	v4l2_ctrl_handler_setup(v4l2_ctrl_hdl);
>+
>+	wave5_set_default_format(&inst->src_fmt, &inst->dst_fmt);
>+	inst->colorspace = V4L2_COLORSPACE_REC709;
>+	inst->ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
>+	inst->hsv_enc = 0;
>+	inst->quantization = V4L2_QUANTIZATION_DEFAULT;
>+	inst->xfer_func = V4L2_XFER_FUNC_DEFAULT;
>+	inst->frame_rate = 30;
>+
>+	init_completion(&inst->irq_done);
>+	ret = kfifo_alloc(&inst->irq_status, 16 * sizeof(int), GFP_KERNEL);
>+	if (ret) {
>+		dev_err(inst->dev->dev, "unable to allocate fifo\n");
>+		goto cleanup_inst;
>+	}
>+
>+	inst->id = ida_alloc(&inst->dev->inst_ida, GFP_KERNEL);
>+	if (inst->id < 0) {
>+		dev_warn(inst->dev->dev, "unable to allocate instance ID: %d\n", inst->id);
>+		ret = inst->id;
>+		goto cleanup_inst;
>+	}
>+
>+	return 0;
>+
>+cleanup_inst:
>+	wave5_cleanup_instance(inst);
>+	return ret;
>+}
>+
>+static int wave5_vpu_enc_release(struct file *filp)
>+{
>+	return wave5_vpu_release_device(filp, wave5_vpu_enc_close, "encoder");
>+}
>+
>+static const struct v4l2_file_operations wave5_vpu_enc_fops = {
>+	.owner = THIS_MODULE,
>+	.open = wave5_vpu_open_enc,
>+	.release = wave5_vpu_enc_release,
>+	.unlocked_ioctl = video_ioctl2,
>+	.poll = v4l2_m2m_fop_poll,
>+	.mmap = v4l2_m2m_fop_mmap,
>+};
>+
>+int wave5_vpu_enc_register_device(struct vpu_device *dev)
>+{
>+	struct video_device *vdev_enc;
>+	int ret;
>+
>+	vdev_enc = devm_kzalloc(dev->v4l2_dev.dev, sizeof(*vdev_enc), GFP_KERNEL);
>+	if (!vdev_enc)
>+		return -ENOMEM;
>+
>+	dev->video_dev_enc = vdev_enc;
>+
>+	strscpy(vdev_enc->name, VPU_ENC_DEV_NAME, sizeof(vdev_enc->name));
>+	vdev_enc->fops = &wave5_vpu_enc_fops;
>+	vdev_enc->ioctl_ops = &wave5_vpu_enc_ioctl_ops;
>+	vdev_enc->release = video_device_release_empty;
>+	vdev_enc->v4l2_dev = &dev->v4l2_dev;
>+	vdev_enc->vfl_dir = VFL_DIR_M2M;
>+	vdev_enc->device_caps = V4L2_CAP_VIDEO_M2M_MPLANE | V4L2_CAP_STREAMING;
>+	vdev_enc->lock = &dev->dev_lock;
>+
>+	ret = video_register_device(vdev_enc, VFL_TYPE_VIDEO, -1);
>+	if (ret)
>+		return ret;
>+
>+	video_set_drvdata(vdev_enc, dev);
>+
>+	return 0;
>+}
>+
>+void wave5_vpu_enc_unregister_device(struct vpu_device *dev)
>+{
>+	video_unregister_device(dev->video_dev_enc);
>+}
>diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
>new file mode 100644
>index 000000000000..885cc76f9d32
>--- /dev/null
>+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
>@@ -0,0 +1,362 @@
>+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
>+/*
>+ * Wave5 series multi-standard codec IP - platform driver
>+ *
>+ * Copyright (C) 2021 CHIPS&MEDIA INC
>+ */
>+#include <linux/kernel.h>
>+#include <linux/module.h>
>+#include <linux/platform_device.h>
>+#include <linux/clk.h>
>+#include <linux/of_address.h>
>+#include <linux/firmware.h>
>+#include <linux/interrupt.h>
>+#include "wave5-vpu.h"
>+#include "wave5-regdefine.h"
>+#include "wave5-vpuconfig.h"
>+#include "wave5.h"
>+
>+#define VPU_PLATFORM_DEVICE_NAME "vdec"
>+#define VPU_CLK_NAME "vcodec"
>+
>+#define WAVE5_IS_ENC BIT(0)
>+#define WAVE5_IS_DEC BIT(1)
>+
>+struct wave5_match_data {
>+	int flags;
>+	const char *fw_name;
>+};
>+
>+int wave5_vpu_wait_interrupt(struct vpu_instance *inst, unsigned int timeout)
>+{
>+	int ret;
>+
>+	ret = wait_for_completion_timeout(&inst->irq_done,
>+					  msecs_to_jiffies(timeout));
>+	if (!ret)
>+		return -ETIMEDOUT;
>+
>+	reinit_completion(&inst->irq_done);
>+
>+	return 0;
>+}
>+
>+static void wave5_vpu_get_interrupt_for_inst(struct vpu_instance *inst, u32 status)
>+{
>+	struct vpu_device *dev = inst->dev;
>+	u32 seq_done;
>+	u32 cmd_done;
>+	int val;
>+
>+	seq_done = wave5_vdi_readl(dev, W5_RET_SEQ_DONE_INSTANCE_INFO);
>+	cmd_done = wave5_vdi_readl(dev, W5_RET_QUEUE_CMD_DONE_INST);
>+
>+	if (status & BIT(INT_WAVE5_INIT_SEQ)) {
>+		if (seq_done & BIT(inst->id)) {
>+			seq_done &= ~BIT(inst->id);
>+			wave5_vdi_write_register(dev, W5_RET_SEQ_DONE_INSTANCE_INFO, seq_done);
>+			val = BIT(INT_WAVE5_INIT_SEQ);
>+			kfifo_in(&inst->irq_status, &val, sizeof(int));
>+		}
>+	}
>+	if (status & BIT(INT_WAVE5_ENC_SET_PARAM)) {
>+		if (seq_done & BIT(inst->id)) {
>+			seq_done &= ~BIT(inst->id);
>+			wave5_vdi_write_register(dev, W5_RET_SEQ_DONE_INSTANCE_INFO, seq_done);
>+			val = BIT(INT_WAVE5_ENC_SET_PARAM);
>+			kfifo_in(&inst->irq_status, &val, sizeof(int));
>+		}
>+	}
>+	if (status & BIT(INT_WAVE5_DEC_PIC) ||
>+	    status & BIT(INT_WAVE5_ENC_PIC)) {
>+		if (cmd_done & BIT(inst->id)) {
>+			cmd_done &= ~BIT(inst->id);
>+			wave5_vdi_write_register(dev, W5_RET_QUEUE_CMD_DONE_INST, cmd_done);
>+			val = BIT(INT_WAVE5_DEC_PIC);
>+			kfifo_in(&inst->irq_status, &val, sizeof(int));
>+		}
>+	}
>+}
>+
>+static irqreturn_t wave5_vpu_irq(int irq, void *dev_id)
>+{
>+	struct vpu_device *dev = dev_id;
>+
>+	if (wave5_vdi_readl(dev, W5_VPU_VPU_INT_STS)) {
>+		struct vpu_instance *inst;
>+		u32 irq_status = wave5_vdi_readl(dev, W5_VPU_VINT_REASON);
>+
>+		list_for_each_entry(inst, &dev->instances, list) {
>+			wave5_vpu_get_interrupt_for_inst(inst, irq_status);
>+		}
>+
>+		wave5_vdi_write_register(dev, W5_VPU_VINT_REASON_CLR, irq_status);
>+		wave5_vdi_write_register(dev, W5_VPU_VINT_CLEAR, 0x1);
>+
>+		return IRQ_WAKE_THREAD;
>+	}
>+
>+	return IRQ_HANDLED;
>+}
>+
>+static irqreturn_t wave5_vpu_irq_thread(int irq, void *dev_id)
>+{
>+	struct vpu_device *dev = dev_id;
>+	struct vpu_instance *inst;
>+	int irq_status, ret;
>+	u32 val;
>+
>+	list_for_each_entry(inst, &dev->instances, list) {
>+		while (kfifo_len(&inst->irq_status)) {
>+			struct vpu_instance *curr;
>+
>+			curr = v4l2_m2m_get_curr_priv(inst->v4l2_m2m_dev);
>+			if (curr) {
>+				inst->ops->finish_process(inst);
>+			} else {
>+				ret = kfifo_out(&inst->irq_status, &irq_status, sizeof(int));
>+				if (!ret)
>+					break;
>+
>+				val = wave5_vdi_readl(dev, W5_VPU_VINT_REASON_USR);
>+				val &= ~irq_status;
>+				wave5_vdi_write_register(dev, W5_VPU_VINT_REASON_USR, val);
>+				complete(&inst->irq_done);
>+			}
>+		}
>+	}
>+
>+	return IRQ_HANDLED;
>+}
>+
>+static int wave5_vpu_load_firmware(struct device *dev, const char *fw_name)
>+{
>+	const struct firmware *fw;
>+	int ret;
>+	u32 revision;
>+	unsigned int product_id;
>+
>+	ret = request_firmware(&fw, fw_name, dev);
>+	if (ret) {
>+		dev_err(dev, "request_firmware, fail: %d\n", ret);
>+		return ret;
>+	}
>+
>+	ret = wave5_vpu_init_with_bitcode(dev, (u8 *)fw->data, fw->size);
>+	if (ret) {
>+		dev_err(dev, "vpu_init_with_bitcode, fail: %d\n", ret);
>+		goto release_fw;
>+	}
>+	release_firmware(fw);
>+
>+	ret = wave5_vpu_get_version_info(dev, &revision, &product_id);
>+	if (ret) {
>+		dev_err(dev, "vpu_get_version_info fail: %d\n", ret);
>+		goto err_without_release;
>+	}
>+
>+	dev_dbg(dev, "%s: enum product_id: %08x, fw revision: %d\n",
>+		__func__, product_id, revision);
>+
>+	return 0;
>+
>+release_fw:
>+	release_firmware(fw);
>+err_without_release:
>+	return ret;
>+}
>+
>+static int wave5_vpu_probe(struct platform_device *pdev)
>+{
>+	int ret;
>+	struct vpu_device *dev;
>+	struct device_node *np;
>+	const struct wave5_match_data *match_data;
>+	struct resource sram;
>+
>+	match_data = device_get_match_data(&pdev->dev);
>+	if (!match_data) {
>+		dev_err(&pdev->dev, "missing device match data\n");
>+		return -EINVAL;
>+	}
>+
>+	/* physical addresses limited to 32 bits */
>+	dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
>+	dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
>+
>+	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
>+	if (!dev)
>+		return -ENOMEM;
>+
>+	dev->vdb_register = devm_platform_ioremap_resource(pdev, 0);
>+	if (IS_ERR(dev->vdb_register))
>+		return PTR_ERR(dev->vdb_register);
>+	ida_init(&dev->inst_ida);
>+
>+	mutex_init(&dev->dev_lock);
>+	mutex_init(&dev->hw_lock);
>+	dev_set_drvdata(&pdev->dev, dev);
>+	dev->dev = &pdev->dev;
>+
>+	ret = devm_clk_bulk_get_all(&pdev->dev, &dev->clks);
>+
>+	/* continue without clock, assume externally managed */
>+	if (ret < 0) {
>+		dev_warn(&pdev->dev, "Getting clocks, fail: %d\n", ret);
>+		ret = 0;
>+	}
>+	dev->num_clks = ret;
>+
>+	ret = clk_bulk_prepare_enable(dev->num_clks, dev->clks);
>+	if (ret) {
>+		dev_err(&pdev->dev, "Enabling clocks, fail: %d\n", ret);
>+		return ret;
>+	}
>+
>+	np = of_parse_phandle(pdev->dev.of_node, "sram", 0);
>+	if (!np) {
>+		dev_warn(&pdev->dev, "sram node not found\n");
>+	} else {
>+		ret = of_address_to_resource(np, 0, &sram);
>+		if (ret) {
>+			dev_err(&pdev->dev, "sram resource not available\n");
>+			goto err_put_node;
>+		}
>+		dev->sram_buf.daddr = sram.start;
>+		dev->sram_buf.size = resource_size(&sram);
>+		dev_dbg(&pdev->dev, "%s: sram daddr: %pad, size: 0x%lx\n",
>+			__func__, &dev->sram_buf.daddr, dev->sram_buf.size);
>+	}
>+
>+	dev->product_code = wave5_vdi_readl(dev, VPU_PRODUCT_CODE_REGISTER);
>+	ret = wave5_vdi_init(&pdev->dev);
>+	if (ret < 0) {
>+		dev_err(&pdev->dev, "wave5_vdi_init, fail: %d\n", ret);
>+		goto err_clk_dis;
>+	}
>+	dev->product = wave5_vpu_get_product_id(dev);
>+
>+	INIT_LIST_HEAD(&dev->instances);
>+	ret = v4l2_device_register(&pdev->dev, &dev->v4l2_dev);
>+	if (ret) {
>+		dev_err(&pdev->dev, "v4l2_device_register, fail: %d\n", ret);
>+		goto err_vdi_release;
>+	}
>+
>+	if (match_data->flags & WAVE5_IS_DEC) {
>+		ret = wave5_vpu_dec_register_device(dev);
>+		if (ret) {
>+			dev_err(&pdev->dev, "wave5_vpu_dec_register_device, fail: %d\n", ret);
>+			goto err_v4l2_unregister;
>+		}
>+	}
>+	if (match_data->flags & WAVE5_IS_ENC) {
>+		ret = wave5_vpu_enc_register_device(dev);
>+		if (ret) {
>+			dev_err(&pdev->dev, "wave5_vpu_enc_register_device, fail: %d\n", ret);
>+			goto err_dec_unreg;
>+		}
>+	}
>+
>+	dev->irq = platform_get_irq(pdev, 0);
>+	if (dev->irq < 0) {
>+		dev_err(&pdev->dev, "failed to get irq resource\n");
>+		ret = -ENXIO;
>+		goto err_enc_unreg;
>+	}
>+
>+	ret = devm_request_threaded_irq(&pdev->dev, dev->irq, wave5_vpu_irq,
>+					wave5_vpu_irq_thread, 0, "vpu_irq", dev);
>+	if (ret) {
>+		dev_err(&pdev->dev, "Register interrupt handler, fail: %d\n", ret);
>+		goto err_enc_unreg;
>+	}
>+
>+	ret = wave5_vpu_load_firmware(&pdev->dev, match_data->fw_name);
>+	if (ret) {
>+		dev_err(&pdev->dev, "wave5_vpu_load_firmware, fail: %d\n", ret);
>+		goto err_enc_unreg;
>+	}
>+
>+	dev_dbg(&pdev->dev, "Added wave5 driver with caps: %s %s and product code: 0x%x\n",
>+		(match_data->flags & WAVE5_IS_ENC) ? "'ENCODE'" : "",
>+		(match_data->flags & WAVE5_IS_DEC) ? "'DECODE'" : "",
>+		dev->product_code);
>+	return 0;
>+
>+err_enc_unreg:
>+	if (match_data->flags & WAVE5_IS_ENC)
>+		wave5_vpu_enc_unregister_device(dev);
>+err_dec_unreg:
>+	if (match_data->flags & WAVE5_IS_DEC)
>+		wave5_vpu_dec_unregister_device(dev);
>+err_v4l2_unregister:
>+	v4l2_device_unregister(&dev->v4l2_dev);
>+err_vdi_release:
>+	wave5_vdi_release(&pdev->dev);
>+err_clk_dis:
>+	clk_bulk_disable_unprepare(dev->num_clks, dev->clks);
>+err_put_node:
>+	of_node_put(np);
>+
>+	return ret;
>+}
>+
>+static int wave5_vpu_remove(struct platform_device *pdev)
>+{
>+	struct vpu_device *dev = dev_get_drvdata(&pdev->dev);
>+
>+	clk_bulk_disable_unprepare(dev->num_clks, dev->clks);
>+	wave5_vpu_enc_unregister_device(dev);
>+	wave5_vpu_dec_unregister_device(dev);
>+	v4l2_device_unregister(&dev->v4l2_dev);
>+	wave5_vdi_release(&pdev->dev);
>+	ida_destroy(&dev->inst_ida);
>+
>+	return 0;
>+}
>+
>+static const struct wave5_match_data wave511_data = {
>+	.flags = WAVE5_IS_DEC,
>+	.fw_name = "wave511_dec_fw.bin",
>+};
>+
>+static const struct wave5_match_data wave521_data = {
>+	.flags = WAVE5_IS_ENC,
>+	.fw_name = "wave521_enc_fw.bin",
>+};
>+
>+static const struct wave5_match_data wave521c_data = {
>+	.flags = WAVE5_IS_ENC | WAVE5_IS_DEC,
>+	.fw_name = "wave521c_codec_fw.bin",
>+};
>+
>+static const struct wave5_match_data default_match_data = {
>+	.flags = WAVE5_IS_ENC | WAVE5_IS_DEC,
>+	.fw_name = "chagall.bin",
>+};
>+
>+static const struct of_device_id wave5_dt_ids[] = {
>+	{ .compatible = "cnm,cm511-vpu", .data = &wave511_data },
>+	{ .compatible = "cnm,cm517-vpu", .data = &default_match_data },
>+	{ .compatible = "cnm,cm521-vpu", .data = &wave521_data },
>+	{ .compatible = "cnm,cm521c-vpu", .data = &wave521c_data },
>+	{ .compatible = "cnm,cm521c-dual-vpu", .data = &wave521c_data },
>+	{ .compatible = "cnm,cm521e1-vpu", .data = &default_match_data },
>+	{ .compatible = "cnm,cm537-vpu", .data = &default_match_data },
>+	{ /* sentinel */ }
>+};
>+MODULE_DEVICE_TABLE(of, wave5_dt_ids);
>+
>+static struct platform_driver wave5_vpu_driver = {
>+	.driver = {
>+		.name = VPU_PLATFORM_DEVICE_NAME,
>+		.of_match_table = of_match_ptr(wave5_dt_ids),
>+		},
>+	.probe = wave5_vpu_probe,
>+	.remove = wave5_vpu_remove,
>+};
>+
>+module_platform_driver(wave5_vpu_driver);
>+MODULE_DESCRIPTION("chips&media VPU V4L2 driver");
>+MODULE_LICENSE("Dual BSD/GPL");
>diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.h b/drivers/media/platform/chips-media/wave5/wave5-vpu.h
>new file mode 100644
>index 000000000000..7156d8c3fee4
>--- /dev/null
>+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.h
>@@ -0,0 +1,72 @@
>+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
>+/*
>+ * Wave5 series multi-standard codec IP - basic types
>+ *
>+ * Copyright (C) 2021 CHIPS&MEDIA INC
>+ */
>+#ifndef __VPU_DRV_H__
>+#define __VPU_DRV_H__
>+
>+#include <media/v4l2-ctrls.h>
>+#include <media/v4l2-ioctl.h>
>+#include <media/v4l2-event.h>
>+#include <media/v4l2-fh.h>
>+#include <media/videobuf2-v4l2.h>
>+#include <media/videobuf2-dma-contig.h>
>+#include <media/videobuf2-vmalloc.h>
>+#include "wave5-vpuconfig.h"
>+#include "wave5-vpuapi.h"
>+
>+#define VPU_BUF_SYNC_TO_DEVICE 0
>+#define VPU_BUF_SYNC_FROM_DEVICE 1
>+
>+struct vpu_buffer {
>+	struct v4l2_m2m_buffer v4l2_m2m_buf;
>+	bool                   consumed;
>+};
>+
>+enum vpu_fmt_type {
>+	VPU_FMT_TYPE_CODEC = 0,
>+	VPU_FMT_TYPE_RAW   = 1
>+};
>+
>+struct vpu_format {
>+	unsigned int v4l2_pix_fmt;
>+	unsigned int max_width;
>+	unsigned int min_width;
>+	unsigned int max_height;
>+	unsigned int min_height;
>+};
>+
>+static inline struct vpu_instance *wave5_to_vpu_inst(struct v4l2_fh *vfh)
>+{
>+	return container_of(vfh, struct vpu_instance, v4l2_fh);
>+}
>+
>+static inline struct vpu_instance *wave5_ctrl_to_vpu_inst(struct v4l2_ctrl *vctrl)
>+{
>+	return container_of(vctrl->handler, struct vpu_instance, v4l2_ctrl_hdl);
>+}
>+
>+static inline struct vpu_buffer *wave5_to_vpu_buf(struct vb2_v4l2_buffer *vbuf)
>+{
>+	return container_of(vbuf, struct vpu_buffer, v4l2_m2m_buf.vb);
>+}
>+
>+int wave5_vpu_wait_interrupt(struct vpu_instance *inst, unsigned int timeout);
>+
>+int  wave5_vpu_dec_register_device(struct vpu_device *dev);
>+void wave5_vpu_dec_unregister_device(struct vpu_device *dev);
>+int  wave5_vpu_enc_register_device(struct vpu_device *dev);
>+void wave5_vpu_enc_unregister_device(struct vpu_device *dev);
>+static inline bool wave5_vpu_both_queues_are_streaming(struct vpu_instance *inst)
>+{
>+	struct vb2_queue *vq_cap =
>+		v4l2_m2m_get_vq(inst->v4l2_fh.m2m_ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE);
>+	struct vb2_queue *vq_out =
>+		v4l2_m2m_get_vq(inst->v4l2_fh.m2m_ctx, V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE);
>+
>+	return vb2_is_streaming(vq_cap) && vb2_is_streaming(vq_out);
>+}
>+
>+#endif
>-- 
>2.25.1
>

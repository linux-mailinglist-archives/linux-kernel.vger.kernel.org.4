Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA8C6C2EE1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 11:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjCUK3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 06:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjCUK3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 06:29:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514FB8A5E;
        Tue, 21 Mar 2023 03:29:10 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:f5ef:1040:e3c1:3d00])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 314C066030DD;
        Tue, 21 Mar 2023 10:29:08 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679394548;
        bh=wbGG8suku31xPcZWDsbA5SZrBouN3rB+2nVL/+CyKqs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DrHE1wbssG2eS7zZ9pBxpMxNDPYr9M+4841okggsOIUh50L8ZmhbPkHHCcteYB5sV
         5xOHPpVjH6D4HFHqCH1T0x2JeRY61MBf6I93fCcIBY9a/YSA8IJxeDVKhhG5RMeH1V
         jc+5nwzOmpPtQZYSmlO2rCX3X8Ad8lC/EplCSzEMGldn71C3KIxMoKn9bh4sPLVy5U
         2j8jTOJMU6PQajXqsnemx8kFmPXn0xdcj8m0FJKhON1h30Wu9zAhty5vnxyi1v8txo
         eIVRKM3ABoQPJzP64PdUFDXcVsKNSRW25h2f1Q0tqJblKLwWR0GAWT6GSt4I8R1LPw
         RdS8rfpP0cecw==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     tfiga@chromium.org, m.szyprowski@samsung.com, mchehab@kernel.org,
        ming.qian@nxp.com, shijie.qin@nxp.com, eagle.zhou@nxp.com,
        bin.liu@mediatek.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, tiffany.lin@mediatek.com,
        andrew-ct.chen@mediatek.com, yunfei.dong@mediatek.com,
        stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        daniel.almeida@collabora.com, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, jernel@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v2 1/8] media: videobuf2: Access vb2_queue bufs array through helper functions
Date:   Tue, 21 Mar 2023 11:28:48 +0100
Message-Id: <20230321102855.346732-2-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230321102855.346732-1-benjamin.gaignard@collabora.com>
References: <20230321102855.346732-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first step before changing how vb2 buffers are stored into queue
is to avoid direct access to bufs arrays.

This patch adds 2 helpers functions to add and remove vb2 buffers
from a queue. With these 2 and vb2_get_buffer(), bufs field of
struct vb2_queue becomes like a private member of the structure.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 .../media/common/videobuf2/videobuf2-core.c   | 84 +++++++++++--------
 .../media/common/videobuf2/videobuf2-v4l2.c   | 17 ++--
 drivers/media/platform/amphion/vpu_dbg.c      |  4 +-
 .../platform/mediatek/jpeg/mtk_jpeg_core.c    |  2 +-
 .../vcodec/vdec/vdec_vp9_req_lat_if.c         |  2 +-
 drivers/media/test-drivers/visl/visl-dec.c    | 16 ++--
 .../staging/media/atomisp/pci/atomisp_ioctl.c |  2 +-
 include/media/videobuf2-core.h                | 26 ++++++
 8 files changed, 101 insertions(+), 52 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index cf6727d9c81f..79e90e338846 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -359,7 +359,7 @@ static void __setup_offsets(struct vb2_buffer *vb)
 	unsigned long off = 0;
 
 	if (vb->index) {
-		struct vb2_buffer *prev = q->bufs[vb->index - 1];
+		struct vb2_buffer *prev = vb2_get_buffer(q, vb->index - 1);
 		struct vb2_plane *p = &prev->planes[prev->num_planes - 1];
 
 		off = PAGE_ALIGN(p->m.offset + p->length);
@@ -437,7 +437,11 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
 		}
 		call_void_bufop(q, init_buffer, vb);
 
-		q->bufs[vb->index] = vb;
+		if (!vb2_queue_add_buffer(q, vb)) {
+			dprintk(q, 1, "failed adding buffer %d to queue\n", buffer);
+			kfree(vb);
+			break;
+		}
 
 		/* Allocate video buffer memory for the MMAP type */
 		if (memory == VB2_MEMORY_MMAP) {
@@ -445,7 +449,7 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
 			if (ret) {
 				dprintk(q, 1, "failed allocating memory for buffer %d\n",
 					buffer);
-				q->bufs[vb->index] = NULL;
+				vb2_queue_remove_buffer(q, vb);
 				kfree(vb);
 				break;
 			}
@@ -460,7 +464,7 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
 				dprintk(q, 1, "buffer %d %p initialization failed\n",
 					buffer, vb);
 				__vb2_buf_mem_free(vb);
-				q->bufs[vb->index] = NULL;
+				vb2_queue_remove_buffer(q, vb);
 				kfree(vb);
 				break;
 			}
@@ -483,7 +487,7 @@ static void __vb2_free_mem(struct vb2_queue *q, unsigned int buffers)
 
 	for (buffer = q->num_buffers - buffers; buffer < q->num_buffers;
 	     ++buffer) {
-		vb = q->bufs[buffer];
+		vb = vb2_get_buffer(q, buffer);
 		if (!vb)
 			continue;
 
@@ -511,7 +515,7 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
 	/* Call driver-provided cleanup function for each buffer, if provided */
 	for (buffer = q->num_buffers - buffers; buffer < q->num_buffers;
 	     ++buffer) {
-		struct vb2_buffer *vb = q->bufs[buffer];
+		struct vb2_buffer *vb = vb2_get_buffer(q, buffer);
 
 		if (vb && vb->planes[0].mem_priv)
 			call_void_vb_qop(vb, buf_cleanup, vb);
@@ -551,7 +555,7 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
 		q->cnt_unprepare_streaming = 0;
 	}
 	for (buffer = 0; buffer < q->num_buffers; ++buffer) {
-		struct vb2_buffer *vb = q->bufs[buffer];
+		struct vb2_buffer *vb = vb2_get_buffer(q, buffer);
 		bool unbalanced = vb->cnt_mem_alloc != vb->cnt_mem_put ||
 				  vb->cnt_mem_prepare != vb->cnt_mem_finish ||
 				  vb->cnt_mem_get_userptr != vb->cnt_mem_put_userptr ||
@@ -591,8 +595,10 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
 	/* Free vb2 buffers */
 	for (buffer = q->num_buffers - buffers; buffer < q->num_buffers;
 	     ++buffer) {
-		kfree(q->bufs[buffer]);
-		q->bufs[buffer] = NULL;
+		struct vb2_buffer *vb = vb2_get_buffer(q, buffer);
+
+		vb2_queue_remove_buffer(q, vb);
+		kfree(vb);
 	}
 
 	q->num_buffers -= buffers;
@@ -628,7 +634,7 @@ static bool __buffers_in_use(struct vb2_queue *q)
 {
 	unsigned int buffer;
 	for (buffer = 0; buffer < q->num_buffers; ++buffer) {
-		if (vb2_buffer_in_use(q, q->bufs[buffer]))
+		if (vb2_buffer_in_use(q, vb2_get_buffer(q, buffer)))
 			return true;
 	}
 	return false;
@@ -636,7 +642,7 @@ static bool __buffers_in_use(struct vb2_queue *q)
 
 void vb2_core_querybuf(struct vb2_queue *q, unsigned int index, void *pb)
 {
-	call_void_bufop(q, fill_user_buffer, q->bufs[index], pb);
+	call_void_bufop(q, fill_user_buffer, vb2_get_buffer(q, index), pb);
 }
 EXPORT_SYMBOL_GPL(vb2_core_querybuf);
 
@@ -1547,7 +1553,7 @@ int vb2_core_prepare_buf(struct vb2_queue *q, unsigned int index, void *pb)
 	struct vb2_buffer *vb;
 	int ret;
 
-	vb = q->bufs[index];
+	vb = vb2_get_buffer(q, index);
 	if (vb->state != VB2_BUF_STATE_DEQUEUED) {
 		dprintk(q, 1, "invalid buffer state %s\n",
 			vb2_state_name(vb->state));
@@ -1618,7 +1624,7 @@ static int vb2_start_streaming(struct vb2_queue *q)
 		 * correctly return them to vb2.
 		 */
 		for (i = 0; i < q->num_buffers; ++i) {
-			vb = q->bufs[i];
+			vb = vb2_get_buffer(q, i);
 			if (vb->state == VB2_BUF_STATE_ACTIVE)
 				vb2_buffer_done(vb, VB2_BUF_STATE_QUEUED);
 		}
@@ -1646,7 +1652,7 @@ int vb2_core_qbuf(struct vb2_queue *q, unsigned int index, void *pb,
 		return -EIO;
 	}
 
-	vb = q->bufs[index];
+	vb = vb2_get_buffer(q, index);
 
 	if (!req && vb->state != VB2_BUF_STATE_IN_REQUEST &&
 	    q->requires_requests) {
@@ -2022,12 +2028,15 @@ static void __vb2_queue_cancel(struct vb2_queue *q)
 	 * to vb2 in stop_streaming().
 	 */
 	if (WARN_ON(atomic_read(&q->owned_by_drv_count))) {
-		for (i = 0; i < q->num_buffers; ++i)
-			if (q->bufs[i]->state == VB2_BUF_STATE_ACTIVE) {
+		for (i = 0; i < q->num_buffers; ++i) {
+			struct vb2_buffer *vb = vb2_get_buffer(q, i);
+
+			if (vb->state == VB2_BUF_STATE_ACTIVE) {
 				pr_warn("driver bug: stop_streaming operation is leaving buf %p in active state\n",
-					q->bufs[i]);
-				vb2_buffer_done(q->bufs[i], VB2_BUF_STATE_ERROR);
+					vb);
+				vb2_buffer_done(vb, VB2_BUF_STATE_ERROR);
 			}
+		}
 		/* Must be zero now */
 		WARN_ON(atomic_read(&q->owned_by_drv_count));
 	}
@@ -2061,7 +2070,7 @@ static void __vb2_queue_cancel(struct vb2_queue *q)
 	 * be changed, so we can't move the buf_finish() to __vb2_dqbuf().
 	 */
 	for (i = 0; i < q->num_buffers; ++i) {
-		struct vb2_buffer *vb = q->bufs[i];
+		struct vb2_buffer *vb = vb2_get_buffer(q, i);
 		struct media_request *req = vb->req_obj.req;
 
 		/*
@@ -2215,7 +2224,7 @@ static int __find_plane_by_offset(struct vb2_queue *q, unsigned long off,
 	 * return its buffer and plane numbers.
 	 */
 	for (buffer = 0; buffer < q->num_buffers; ++buffer) {
-		vb = q->bufs[buffer];
+		vb = vb2_get_buffer(q, buffer);
 
 		for (plane = 0; plane < vb->num_planes; ++plane) {
 			if (vb->planes[plane].m.offset == off) {
@@ -2262,7 +2271,7 @@ int vb2_core_expbuf(struct vb2_queue *q, int *fd, unsigned int type,
 		return -EINVAL;
 	}
 
-	vb = q->bufs[index];
+	vb = vb2_get_buffer(q, index);
 
 	if (plane >= vb->num_planes) {
 		dprintk(q, 1, "buffer plane out of range\n");
@@ -2339,7 +2348,7 @@ int vb2_mmap(struct vb2_queue *q, struct vm_area_struct *vma)
 	if (ret)
 		goto unlock;
 
-	vb = q->bufs[buffer];
+	vb = vb2_get_buffer(q, buffer);
 
 	/*
 	 * MMAP requires page_aligned buffers.
@@ -2396,7 +2405,7 @@ unsigned long vb2_get_unmapped_area(struct vb2_queue *q,
 	if (ret)
 		goto unlock;
 
-	vb = q->bufs[buffer];
+	vb = vb2_get_buffer(q, buffer);
 
 	vaddr = vb2_plane_vaddr(vb, plane);
 	mutex_unlock(&q->mmap_lock);
@@ -2625,6 +2634,7 @@ struct vb2_fileio_data {
 static int __vb2_init_fileio(struct vb2_queue *q, int read)
 {
 	struct vb2_fileio_data *fileio;
+	struct vb2_buffer *vb;
 	int i, ret;
 	unsigned int count = 0;
 
@@ -2679,7 +2689,13 @@ static int __vb2_init_fileio(struct vb2_queue *q, int read)
 	 * Check if plane_count is correct
 	 * (multiplane buffers are not supported).
 	 */
-	if (q->bufs[0]->num_planes != 1) {
+	vb = vb2_get_buffer(q, 0);
+	if (!vb) {
+		ret = -EBUSY;
+		goto err_reqbufs;
+	}
+
+	if (vb->num_planes != 1) {
 		ret = -EBUSY;
 		goto err_reqbufs;
 	}
@@ -2688,12 +2704,14 @@ static int __vb2_init_fileio(struct vb2_queue *q, int read)
 	 * Get kernel address of each buffer.
 	 */
 	for (i = 0; i < q->num_buffers; i++) {
-		fileio->bufs[i].vaddr = vb2_plane_vaddr(q->bufs[i], 0);
+		vb = vb2_get_buffer(q, i);
+
+		fileio->bufs[i].vaddr = vb2_plane_vaddr(vb, 0);
 		if (fileio->bufs[i].vaddr == NULL) {
 			ret = -EINVAL;
 			goto err_reqbufs;
 		}
-		fileio->bufs[i].size = vb2_plane_size(q->bufs[i], 0);
+		fileio->bufs[i].size = vb2_plane_size(vb, 0);
 	}
 
 	/*
@@ -2821,15 +2839,15 @@ static size_t __vb2_perform_fileio(struct vb2_queue *q, char __user *data, size_
 
 		fileio->cur_index = index;
 		buf = &fileio->bufs[index];
-		b = q->bufs[index];
+		b = vb2_get_buffer(q, index);
 
 		/*
 		 * Get number of bytes filled by the driver
 		 */
 		buf->pos = 0;
 		buf->queued = 0;
-		buf->size = read ? vb2_get_plane_payload(q->bufs[index], 0)
-				 : vb2_plane_size(q->bufs[index], 0);
+		buf->size = read ? vb2_get_plane_payload(b, 0)
+				 : vb2_plane_size(b, 0);
 		/* Compensate for data_offset on read in the multiplanar case. */
 		if (is_multiplanar && read &&
 				b->planes[0].data_offset < buf->size) {
@@ -2872,7 +2890,7 @@ static size_t __vb2_perform_fileio(struct vb2_queue *q, char __user *data, size_
 	 * Queue next buffer if required.
 	 */
 	if (buf->pos == buf->size || (!read && fileio->write_immediately)) {
-		struct vb2_buffer *b = q->bufs[index];
+		struct vb2_buffer *b = vb2_get_buffer(q, index);
 
 		/*
 		 * Check if this is the last buffer to read.
@@ -2899,7 +2917,7 @@ static size_t __vb2_perform_fileio(struct vb2_queue *q, char __user *data, size_
 		 */
 		buf->pos = 0;
 		buf->queued = 1;
-		buf->size = vb2_plane_size(q->bufs[index], 0);
+		buf->size = vb2_plane_size(vb2_get_buffer(q, index), 0);
 		fileio->q_count += 1;
 		/*
 		 * If we are queuing up buffers for the first time, then
@@ -2970,7 +2988,7 @@ static int vb2_thread(void *data)
 		 * Call vb2_dqbuf to get buffer back.
 		 */
 		if (prequeue) {
-			vb = q->bufs[index++];
+			vb = vb2_get_buffer(q, index++);
 			prequeue--;
 		} else {
 			call_void_qop(q, wait_finish, q);
@@ -2979,7 +2997,7 @@ static int vb2_thread(void *data)
 			call_void_qop(q, wait_prepare, q);
 			dprintk(q, 5, "file io: vb2_dqbuf result: %d\n", ret);
 			if (!ret)
-				vb = q->bufs[index];
+				vb = vb2_get_buffer(q, index);
 		}
 		if (ret || threadio->stop)
 			break;
diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
index 1f5d235a8441..01b2bb957239 100644
--- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
+++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
@@ -383,7 +383,7 @@ static int vb2_queue_or_prepare_buf(struct vb2_queue *q, struct media_device *md
 		return -EINVAL;
 	}
 
-	if (q->bufs[b->index] == NULL) {
+	if (!vb2_get_buffer(q, b->index)) {
 		/* Should never happen */
 		dprintk(q, 1, "%s: buffer is NULL\n", opname);
 		return -EINVAL;
@@ -394,7 +394,7 @@ static int vb2_queue_or_prepare_buf(struct vb2_queue *q, struct media_device *md
 		return -EINVAL;
 	}
 
-	vb = q->bufs[b->index];
+	vb = vb2_get_buffer(q, b->index);
 	vbuf = to_vb2_v4l2_buffer(vb);
 	ret = __verify_planes_array(vb, b);
 	if (ret)
@@ -628,11 +628,14 @@ static const struct vb2_buf_ops v4l2_buf_ops = {
 struct vb2_buffer *vb2_find_buffer(struct vb2_queue *q, u64 timestamp)
 {
 	unsigned int i;
+	struct vb2_buffer *vb2;
 
-	for (i = 0; i < q->num_buffers; i++)
-		if (q->bufs[i]->copied_timestamp &&
-		    q->bufs[i]->timestamp == timestamp)
-			return vb2_get_buffer(q, i);
+	for (i = 0; i < q->num_buffers; i++) {
+		vb2 = vb2_get_buffer(q, i);
+		if (vb2->copied_timestamp &&
+		    vb2->timestamp == timestamp)
+			return vb2;
+	}
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(vb2_find_buffer);
@@ -664,7 +667,7 @@ int vb2_querybuf(struct vb2_queue *q, struct v4l2_buffer *b)
 		dprintk(q, 1, "buffer index out of range\n");
 		return -EINVAL;
 	}
-	vb = q->bufs[b->index];
+	vb = vb2_get_buffer(q, b->index);
 	ret = __verify_planes_array(vb, b);
 	if (!ret)
 		vb2_core_querybuf(q, b->index, b);
diff --git a/drivers/media/platform/amphion/vpu_dbg.c b/drivers/media/platform/amphion/vpu_dbg.c
index 44b830ae01d8..8a423c1f6b55 100644
--- a/drivers/media/platform/amphion/vpu_dbg.c
+++ b/drivers/media/platform/amphion/vpu_dbg.c
@@ -133,7 +133,7 @@ static int vpu_dbg_instance(struct seq_file *s, void *data)
 
 	vq = v4l2_m2m_get_src_vq(inst->fh.m2m_ctx);
 	for (i = 0; i < vq->num_buffers; i++) {
-		struct vb2_buffer *vb = vq->bufs[i];
+		struct vb2_buffer *vb = vb2_get_buffer(vq, i);
 		struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
 
 		if (vb->state == VB2_BUF_STATE_DEQUEUED)
@@ -148,7 +148,7 @@ static int vpu_dbg_instance(struct seq_file *s, void *data)
 
 	vq = v4l2_m2m_get_dst_vq(inst->fh.m2m_ctx);
 	for (i = 0; i < vq->num_buffers; i++) {
-		struct vb2_buffer *vb = vq->bufs[i];
+		struct vb2_buffer *vb = vb2_get_buffer(vq, i);
 		struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
 
 		if (vb->state == VB2_BUF_STATE_DEQUEUED)
diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
index 969516a940ba..0be07f691d9a 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
@@ -603,7 +603,7 @@ static int mtk_jpeg_qbuf(struct file *file, void *priv, struct v4l2_buffer *buf)
 		return -EINVAL;
 	}
 
-	vb = vq->bufs[buf->index];
+	vb = vb2_get_buffer(vq, buf->index);
 	jpeg_src_buf = mtk_jpeg_vb2_to_srcbuf(vb);
 	jpeg_src_buf->bs_size = buf->m.planes[0].bytesused;
 
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
index cbb6728b8a40..f5958b6d834a 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
@@ -1701,7 +1701,7 @@ static int vdec_vp9_slice_setup_core_buffer(struct vdec_vp9_slice_instance *inst
 
 	/* update internal buffer's width/height */
 	for (i = 0; i < vq->num_buffers; i++) {
-		if (vb == vq->bufs[i]) {
+		if (vb == vb2_get_buffer(vq, i)) {
 			instance->dpb[i].width = w;
 			instance->dpb[i].height = h;
 			break;
diff --git a/drivers/media/test-drivers/visl/visl-dec.c b/drivers/media/test-drivers/visl/visl-dec.c
index 318d675e5668..328016b456ba 100644
--- a/drivers/media/test-drivers/visl/visl-dec.c
+++ b/drivers/media/test-drivers/visl/visl-dec.c
@@ -290,13 +290,14 @@ static void visl_tpg_fill(struct visl_ctx *ctx, struct visl_run *run)
 	for (i = 0; i < out_q->num_buffers; i++) {
 		char entry[] = "index: %u, state: %s, request_fd: %d, ";
 		u32 old_len = len;
-		char *q_status = visl_get_vb2_state(out_q->bufs[i]->state);
+		struct vb2_buffer *vb2 = vb2_get_buffer(out_q, i);
+		char *q_status = visl_get_vb2_state(vb2->state);
 
 		len += scnprintf(&buf[len], TPG_STR_BUF_SZ - len,
 				 entry, i, q_status,
-				 to_vb2_v4l2_buffer(out_q->bufs[i])->request_fd);
+				 to_vb2_v4l2_buffer(vb2)->request_fd);
 
-		len += visl_fill_bytesused(to_vb2_v4l2_buffer(out_q->bufs[i]),
+		len += visl_fill_bytesused(to_vb2_v4l2_buffer(vb2),
 					   &buf[len],
 					   TPG_STR_BUF_SZ - len);
 
@@ -342,13 +343,14 @@ static void visl_tpg_fill(struct visl_ctx *ctx, struct visl_run *run)
 	len = 0;
 	for (i = 0; i < cap_q->num_buffers; i++) {
 		u32 old_len = len;
-		char *q_status = visl_get_vb2_state(cap_q->bufs[i]->state);
+		struct vb2_buffer *vb2 = vb2_get_buffer(cap_q, i);
+		char *q_status = visl_get_vb2_state(vb2->state);
 
 		len += scnprintf(&buf[len], TPG_STR_BUF_SZ - len,
 				 "index: %u, status: %s, timestamp: %llu, is_held: %d",
-				 cap_q->bufs[i]->index, q_status,
-				 cap_q->bufs[i]->timestamp,
-				 to_vb2_v4l2_buffer(cap_q->bufs[i])->is_held);
+				 vb2->index, q_status,
+				 vb2->timestamp,
+				 to_vb2_v4l2_buffer(vb2)->is_held);
 
 		tpg_gen_text(&ctx->tpg, basep, line++ * line_height, 16, &buf[old_len]);
 		frame_dprintk(ctx->dev, run->dst->sequence, "%s", &buf[old_len]);
diff --git a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c b/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
index d1314bdbf7d5..c7778860f3d4 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
@@ -1095,7 +1095,7 @@ static int atomisp_dqbuf_wrapper(struct file *file, void *fh, struct v4l2_buffer
 	if (ret)
 		return ret;
 
-	vb = pipe->vb_queue.bufs[buf->index];
+	vb = vb2_get_buffer(pipe->vb_queue, buf->index);
 	frame = vb_to_frame(vb);
 
 	buf->reserved = asd->frame_status[buf->index];
diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
index 4b6a9d2ea372..5b1e3d801546 100644
--- a/include/media/videobuf2-core.h
+++ b/include/media/videobuf2-core.h
@@ -1244,6 +1244,32 @@ static inline struct vb2_buffer *vb2_get_buffer(struct vb2_queue *q,
 	return NULL;
 }
 
+/**
+ * vb2_queue_add_buffer() - add a buffer to a queue
+ * @q:	pointer to &struct vb2_queue with videobuf2 queue.
+ * @vb:	pointer to &struct vb2_buffer to be added to the queue.
+ */
+static inline bool vb2_queue_add_buffer(struct vb2_queue *q, struct vb2_buffer *vb)
+{
+	if (vb->index < VB2_MAX_FRAME) {
+		q->bufs[vb->index] = vb;
+		return true;
+	}
+
+	return false;
+}
+
+/**
+ * vb2_queue_remove_buffer() - remove a buffer from a queue
+ * @q:	pointer to &struct vb2_queue with videobuf2 queue.
+ * @vb:	pointer to &struct vb2_buffer to be removed from the queue.
+ */
+static inline void vb2_queue_remove_buffer(struct vb2_queue *q, struct vb2_buffer *vb)
+{
+	if (vb->index < VB2_MAX_FRAME)
+		q->bufs[vb->index] = NULL;
+}
+
 /*
  * The following functions are not part of the vb2 core API, but are useful
  * functions for videobuf2-*.
-- 
2.34.1


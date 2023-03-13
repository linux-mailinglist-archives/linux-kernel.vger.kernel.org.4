Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4C46B79C7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 15:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjCMOAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 10:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjCMN7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:59:51 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4294E6F607;
        Mon, 13 Mar 2023 06:59:28 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:7a7b:d0cc:67e9:4297])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5D5CE66030C0;
        Mon, 13 Mar 2023 13:59:26 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678715967;
        bh=n8cd6a2Nzlrp0LhIUmAbPhk3AaD6uOUzcXdTUoEPFoI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hQA9+Y0Q7jQEFOF6N106zJxZ7ElPQ5jSqBF2FraL9yIdBvCl5ioYf6L4eIVz0k6Mb
         GULf+Dy9D36r7WA1lwfyNJtwPdGcsIE/ymYgD58rc9TWwwQv7r3gr2y7NnRUw10BaC
         /94NI79rkreKD0ayKtAnuAw0KaHM6x5MmDf5gE0xVW0x2Rc2JSVoC3ypQJ8lZE+VtQ
         MwhECKHjyTgTF/QHixfEX7NTNGLSXcpBRqglldpIlfaJPS7stvWauByREi/Qjw/5Og
         VvIVGZ75IE+rm+KVTpnypcfvcN+mkl73CkPTZHy0BYzeZ2HNBXMpjpwxsLaxo4MIcu
         9+CcUP4aCGGrg==
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
        laurent.pinchart@ideasonboard.com, jerbel@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [RFC 3/4] media: videobuf2: Use bitmap to manage vb2 index
Date:   Mon, 13 Mar 2023 14:59:15 +0100
Message-Id: <20230313135916.862852-4-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230313135916.862852-1-benjamin.gaignard@collabora.com>
References: <20230313135916.862852-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using a bitmap to get vb2 index will allow to avoid holes
in the indexes when introducing DELETE_BUF ioctl.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 .../media/common/videobuf2/videobuf2-core.c   | 22 ++++++++++++++++++-
 include/media/videobuf2-core.h                |  6 +++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 96597d339a07..3554811ec06a 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -397,6 +397,22 @@ static void init_buffer_cache_hints(struct vb2_queue *q, struct vb2_buffer *vb)
 		vb->skip_cache_sync_on_finish = 1;
 }
 
+/*
+ * __vb2_get_index() - find a free index in the queue for vb2 buffer.
+ *
+ * Returns an index for vb2 buffer.
+ */
+static int __vb2_get_index(struct vb2_queue *q)
+{
+	unsigned long index;
+
+	index = bitmap_find_next_zero_area(q->bmap, q->idx_max, 0, 1, 0);
+	if (index > q->idx_max)
+		dprintk(q, 1, "no index available for buffer\n");
+
+	return index;
+}
+
 /*
  * __vb2_queue_alloc() - allocate vb2 buffer structures and (for MMAP type)
  * video buffer memory for all buffers/planes on the queue and initializes the
@@ -423,7 +439,7 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
 		vb->state = VB2_BUF_STATE_DEQUEUED;
 		vb->vb2_queue = q;
 		vb->num_planes = num_planes;
-		vb->index = q->num_buffers + buffer;
+		vb->index = __vb2_get_index(q);
 		vb->type = q->type;
 		vb->memory = memory;
 		init_buffer_cache_hints(q, vb);
@@ -2438,6 +2454,9 @@ int vb2_core_queue_init(struct vb2_queue *q)
 	mutex_init(&q->mmap_lock);
 	init_waitqueue_head(&q->done_wq);
 
+	q->idx_max = ALIGN(256, BITS_PER_LONG);
+	q->bmap = bitmap_zalloc(q->idx_max, GFP_KERNEL);
+
 	q->memory = VB2_MEMORY_UNKNOWN;
 
 	if (q->buf_struct_size == 0)
@@ -2465,6 +2484,7 @@ void vb2_core_queue_release(struct vb2_queue *q)
 	mutex_lock(&q->mmap_lock);
 	__vb2_queue_free(q, q->num_buffers);
 	mutex_unlock(&q->mmap_lock);
+	bitmap_free(q->bmap);
 }
 EXPORT_SYMBOL_GPL(vb2_core_queue_release);
 
diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
index 47f1f35eb9cb..4fddc6ae9f20 100644
--- a/include/media/videobuf2-core.h
+++ b/include/media/videobuf2-core.h
@@ -561,6 +561,8 @@ struct vb2_buf_ops {
  * @dma_dir:	DMA mapping direction.
  * @allocated_bufs: list of buffer allocated for the queue.
  * @num_buffers: number of allocated/used buffers
+ * @bmap: Bitmap of buffers index
+ * @idx_max: number of bits in bmap
  * @queued_list: list of buffers currently queued from userspace
  * @queued_count: number of buffers queued and ready for streaming.
  * @owned_by_drv_count: number of buffers owned by the driver
@@ -624,6 +626,8 @@ struct vb2_queue {
 	enum dma_data_direction		dma_dir;
 	struct list_head		allocated_bufs;
 	unsigned int			num_buffers;
+	unsigned long			*bmap;
+	int				idx_max;
 
 	struct list_head		queued_list;
 	unsigned int			queued_count;
@@ -1259,6 +1263,7 @@ static inline struct vb2_buffer *vb2_get_buffer(struct vb2_queue *q,
 static inline void vb2_set_buffer(struct vb2_queue *q, struct vb2_buffer *vb)
 {
 	list_add_tail(&vb->allocated_entry, &q->allocated_bufs);
+	__set_bit(vb->index, q->bmap);
 }
 
 /**
@@ -1268,6 +1273,7 @@ static inline void vb2_set_buffer(struct vb2_queue *q, struct vb2_buffer *vb)
  */
 static inline void vb2_del_buffer(struct vb2_queue *q, struct vb2_buffer *vb)
 {
+	__clear_bit(vb->index, q->bmap);
 	list_del(&vb->allocated_entry);
 }
 
-- 
2.34.1


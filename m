Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC226B79C0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 15:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjCMOAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 10:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjCMN7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:59:51 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEDA42BE3;
        Mon, 13 Mar 2023 06:59:27 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:7a7b:d0cc:67e9:4297])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9B626660309C;
        Mon, 13 Mar 2023 13:59:25 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678715966;
        bh=fqWhcs4/GgMdLp8whmAet1ILuF0Z1TgMuHnhZmsdzWU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B/nUDWbvXGP1nhnuaY+/zpVS6ko+1IReLDTzh5bY6HAcciS+Cu82iJBYTKbLCCIJY
         Hl1gU1LyLOMdzaoIrAk1TuOZ2jmuuUgDqhQUeC4HjjujeJEWK3GRMM6zmsK7N3H0+u
         DAY0qmXucvqPN0G0PDuRJ8iVmx4nvAiprZgDVG8BPEzmgE1VetFkbzjnFMOh50G1Vf
         9mLFlURp50N6ZN/OompkgTF13b87ywg+2kEt1dTRrWuGvi5hOUrhFoq8KccgnUzr6O
         OnmnuA9VSsG2ERu0Lgft+2gFEKy7IcTqRwTPgm9HiwL0omwDjsfkx30ySiNGGyEk5d
         kowrlfWWytOuQ==
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
Subject: [RFC 2/4] media: videobuf2: Replace bufs array by a list
Date:   Mon, 13 Mar 2023 14:59:14 +0100
Message-Id: <20230313135916.862852-3-benjamin.gaignard@collabora.com>
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

Replacing bufs array by a list allows to remove the 32 buffers
limit per queue.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 .../media/common/videobuf2/videobuf2-core.c   | 14 ++------------
 include/media/videobuf2-core.h                | 19 +++++++++++++------
 2 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index b51152ace763..96597d339a07 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -412,10 +412,6 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
 	struct vb2_buffer *vb;
 	int ret;
 
-	/* Ensure that q->num_buffers+num_buffers is below VB2_MAX_FRAME */
-	num_buffers = min_t(unsigned int, num_buffers,
-			    VB2_MAX_FRAME - q->num_buffers);
-
 	for (buffer = 0; buffer < num_buffers; ++buffer) {
 		/* Allocate vb2 buffer structures */
 		vb = kzalloc(q->buf_struct_size, GFP_KERNEL);
@@ -797,9 +793,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 	/*
 	 * Make sure the requested values and current defaults are sane.
 	 */
-	WARN_ON(q->min_buffers_needed > VB2_MAX_FRAME);
 	num_buffers = max_t(unsigned int, *count, q->min_buffers_needed);
-	num_buffers = min_t(unsigned int, num_buffers, VB2_MAX_FRAME);
 	memset(q->alloc_devs, 0, sizeof(q->alloc_devs));
 	/*
 	 * Set this now to ensure that drivers see the correct q->memory value
@@ -915,11 +909,6 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
 	bool no_previous_buffers = !q->num_buffers;
 	int ret;
 
-	if (q->num_buffers == VB2_MAX_FRAME) {
-		dprintk(q, 1, "maximum number of buffers already allocated\n");
-		return -ENOBUFS;
-	}
-
 	if (no_previous_buffers) {
 		if (q->waiting_in_dqbuf && *count) {
 			dprintk(q, 1, "another dup()ped fd is waiting for a buffer\n");
@@ -944,7 +933,7 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
 			return -EINVAL;
 	}
 
-	num_buffers = min(*count, VB2_MAX_FRAME - q->num_buffers);
+	num_buffers = *count;
 
 	if (requested_planes && requested_sizes) {
 		num_planes = requested_planes;
@@ -2444,6 +2433,7 @@ int vb2_core_queue_init(struct vb2_queue *q)
 
 	INIT_LIST_HEAD(&q->queued_list);
 	INIT_LIST_HEAD(&q->done_list);
+	INIT_LIST_HEAD(&q->allocated_bufs);
 	spin_lock_init(&q->done_lock);
 	mutex_init(&q->mmap_lock);
 	init_waitqueue_head(&q->done_wq);
diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
index d18c57e7aef0..47f1f35eb9cb 100644
--- a/include/media/videobuf2-core.h
+++ b/include/media/videobuf2-core.h
@@ -276,6 +276,8 @@ struct vb2_buffer {
 	 * done_entry:		entry on the list that stores all buffers ready
 	 *			to be dequeued to userspace
 	 * vb2_plane:		per-plane information; do not change
+	 * allocated_entry:	entry on the list that stores all buffers allocated
+	 *			for the queue.
 	 */
 	enum vb2_buffer_state	state;
 	unsigned int		synced:1;
@@ -287,6 +289,7 @@ struct vb2_buffer {
 	struct vb2_plane	planes[VB2_MAX_PLANES];
 	struct list_head	queued_entry;
 	struct list_head	done_entry;
+	struct list_head	allocated_entry;
 #ifdef CONFIG_VIDEO_ADV_DEBUG
 	/*
 	 * Counters for how often these buffer-related ops are
@@ -556,7 +559,7 @@ struct vb2_buf_ops {
  * @mmap_lock:	private mutex used when buffers are allocated/freed/mmapped
  * @memory:	current memory type used
  * @dma_dir:	DMA mapping direction.
- * @bufs:	videobuf2 buffer structures
+ * @allocated_bufs: list of buffer allocated for the queue.
  * @num_buffers: number of allocated/used buffers
  * @queued_list: list of buffers currently queued from userspace
  * @queued_count: number of buffers queued and ready for streaming.
@@ -619,7 +622,7 @@ struct vb2_queue {
 	struct mutex			mmap_lock;
 	unsigned int			memory;
 	enum dma_data_direction		dma_dir;
-	struct vb2_buffer		*bufs[VB2_MAX_FRAME];
+	struct list_head		allocated_bufs;
 	unsigned int			num_buffers;
 
 	struct list_head		queued_list;
@@ -1239,8 +1242,12 @@ static inline void vb2_clear_last_buffer_dequeued(struct vb2_queue *q)
 static inline struct vb2_buffer *vb2_get_buffer(struct vb2_queue *q,
 						unsigned int index)
 {
-	if (index < q->num_buffers)
-		return q->bufs[index];
+	struct vb2_buffer *vb;
+
+	list_for_each_entry(vb, &q->allocated_bufs, allocated_entry)
+		if (vb->index == index)
+			return vb;
+
 	return NULL;
 }
 
@@ -1251,7 +1258,7 @@ static inline struct vb2_buffer *vb2_get_buffer(struct vb2_queue *q,
  */
 static inline void vb2_set_buffer(struct vb2_queue *q, struct vb2_buffer *vb)
 {
-	q->bufs[vb->index] = vb;
+	list_add_tail(&vb->allocated_entry, &q->allocated_bufs);
 }
 
 /**
@@ -1261,7 +1268,7 @@ static inline void vb2_set_buffer(struct vb2_queue *q, struct vb2_buffer *vb)
  */
 static inline void vb2_del_buffer(struct vb2_queue *q, struct vb2_buffer *vb)
 {
-	q->bufs[vb->index] = NULL;
+	list_del(&vb->allocated_entry);
 }
 
 /*
-- 
2.34.1


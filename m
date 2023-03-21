Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610926C2EDE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 11:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjCUK3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 06:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjCUK3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 06:29:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9A84ED4;
        Tue, 21 Mar 2023 03:29:11 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:f5ef:1040:e3c1:3d00])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E461D66030E0;
        Tue, 21 Mar 2023 10:29:08 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679394549;
        bh=eIuM4kCS5F3a2Rxq9DyQKfGuVUFqbcr15Idj0US/azY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PD/X8nh1b3Ue2u3mok3/JTtJB5D1X+UkYlY960HEl60ISY44M1fcbYXIh7110eTlu
         Q6f0LZAFFB2owr71LFgQJf8KrJy012xlc0eWRbKm1DjFPC5L3ZILSBpAa0xQ/2QELf
         ZdHxG6lxzY6hxz4wrIMgR7dgDcre2uZrBuNhj4wqarkOtgI6hmej4U1QxkcDf9ToMg
         lP3Z1r/NZVhVTVN0PswPmrW3isg4sJo4j8nrr7rR88BDkxxfbHhlNq6Q//2MRC0HFa
         +nQOz3PBXiUkIkUenY4Q7qILJNZ8t79swB76ULnsqKNAT7UeQL7fCKTf8ac7/rTC82
         jw0QHHQ1/7Y9w==
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
Subject: [PATCH v2 2/8] media: videobuf2: Make bufs array dynamic allocated
Date:   Tue, 21 Mar 2023 11:28:49 +0100
Message-Id: <20230321102855.346732-3-benjamin.gaignard@collabora.com>
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

Instead of a static array change bufs to a dynamically allocated array.
This will allow to store more video buffer if needed.
Protect the array with a spinlock.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 .../media/common/videobuf2/videobuf2-core.c   |  8 +++
 include/media/videobuf2-core.h                | 49 ++++++++++++++++---
 2 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 79e90e338846..ae9d72f4d181 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -2452,6 +2452,13 @@ int vb2_core_queue_init(struct vb2_queue *q)
 	mutex_init(&q->mmap_lock);
 	init_waitqueue_head(&q->done_wq);
 
+	q->max_num_bufs = 32;
+	q->bufs = kmalloc_array(q->max_num_bufs, sizeof(*q->bufs), GFP_KERNEL | __GFP_ZERO);
+	if (!q->bufs)
+		return -ENOMEM;
+
+	spin_lock_init(&q->bufs_lock);
+
 	q->memory = VB2_MEMORY_UNKNOWN;
 
 	if (q->buf_struct_size == 0)
@@ -2479,6 +2486,7 @@ void vb2_core_queue_release(struct vb2_queue *q)
 	mutex_lock(&q->mmap_lock);
 	__vb2_queue_free(q, q->num_buffers);
 	mutex_unlock(&q->mmap_lock);
+	kfree(q->bufs);
 }
 EXPORT_SYMBOL_GPL(vb2_core_queue_release);
 
diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
index 5b1e3d801546..397dbf6e61e1 100644
--- a/include/media/videobuf2-core.h
+++ b/include/media/videobuf2-core.h
@@ -558,6 +558,8 @@ struct vb2_buf_ops {
  * @dma_dir:	DMA mapping direction.
  * @bufs:	videobuf2 buffer structures
  * @num_buffers: number of allocated/used buffers
+ * @bufs_lock: lock to protect bufs access
+ * @max_num_bufs: max number of buffers storable in bufs
  * @queued_list: list of buffers currently queued from userspace
  * @queued_count: number of buffers queued and ready for streaming.
  * @owned_by_drv_count: number of buffers owned by the driver
@@ -619,8 +621,10 @@ struct vb2_queue {
 	struct mutex			mmap_lock;
 	unsigned int			memory;
 	enum dma_data_direction		dma_dir;
-	struct vb2_buffer		*bufs[VB2_MAX_FRAME];
+	struct vb2_buffer		**bufs;
 	unsigned int			num_buffers;
+	spinlock_t			bufs_lock;
+	size_t				max_num_bufs;
 
 	struct list_head		queued_list;
 	unsigned int			queued_count;
@@ -1239,9 +1243,16 @@ static inline void vb2_clear_last_buffer_dequeued(struct vb2_queue *q)
 static inline struct vb2_buffer *vb2_get_buffer(struct vb2_queue *q,
 						unsigned int index)
 {
-	if (index < q->num_buffers)
-		return q->bufs[index];
-	return NULL;
+	struct vb2_buffer *vb = NULL;
+
+	spin_lock(&q->bufs_lock);
+
+	if (index < q->max_num_bufs)
+		vb = q->bufs[index];
+
+	spin_unlock(&q->bufs_lock);
+
+	return vb;
 }
 
 /**
@@ -1251,12 +1262,30 @@ static inline struct vb2_buffer *vb2_get_buffer(struct vb2_queue *q,
  */
 static inline bool vb2_queue_add_buffer(struct vb2_queue *q, struct vb2_buffer *vb)
 {
-	if (vb->index < VB2_MAX_FRAME) {
+	bool ret = false;
+
+	spin_lock(&q->bufs_lock);
+
+	if (vb->index >= q->max_num_bufs) {
+		struct vb2_buffer **tmp;
+
+		tmp = krealloc_array(q->bufs, q->max_num_bufs * 2, sizeof(*q->bufs), GFP_KERNEL);
+		if (!tmp)
+			goto realloc_failed;
+
+		q->max_num_bufs *= 2;
+		q->bufs = tmp;
+	}
+
+	if (vb->index < q->max_num_bufs) {
 		q->bufs[vb->index] = vb;
-		return true;
+		ret = true;
 	}
 
-	return false;
+realloc_failed:
+	spin_unlock(&q->bufs_lock);
+
+	return ret;
 }
 
 /**
@@ -1266,8 +1295,12 @@ static inline bool vb2_queue_add_buffer(struct vb2_queue *q, struct vb2_buffer *
  */
 static inline void vb2_queue_remove_buffer(struct vb2_queue *q, struct vb2_buffer *vb)
 {
-	if (vb->index < VB2_MAX_FRAME)
+	spin_lock(&q->bufs_lock);
+
+	if (vb->index < q->max_num_bufs)
 		q->bufs[vb->index] = NULL;
+
+	spin_unlock(&q->bufs_lock);
 }
 
 /*
-- 
2.34.1


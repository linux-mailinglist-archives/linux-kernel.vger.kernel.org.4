Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48E073A19F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 15:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbjFVNOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 09:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjFVNOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 09:14:01 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C761BD3;
        Thu, 22 Jun 2023 06:13:59 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:7d72:676c:e745:a6ef])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4FB41660711E;
        Thu, 22 Jun 2023 14:13:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687439638;
        bh=t8kITWrGl0OsCDx7lvzHoBExx5sUqFU5dAXRs/EKO4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cvR797bhp0zTiCSdScfhlbTHiIQr+utHyzNqQOongrdtKYpDwzUY0dWzKZPiFEqnU
         Vp+M7Y2JVVVAbeAA1bPTwIAWMVRo1zoQ0Jo632vU3uYP8DwzoI6ae2TvgAxP4N7hGb
         tC991tunarQYTHZ42wBjAFs76L3DMPSL4Z3l/u4D5NyNX/M1MdoAi2HKtFFo5zj5dv
         LCHML8nEK+y2kfaAqa+i4SV7jLe/BQQRK0t1vmXPQVo/UKPWsX035tkjUJO/rrc/Np
         rcZUErqSo9hyzmJXEaydmOtL+Wr2cCXILV8i/zNvZ5ymW326nqxtRdxJawJSvSIt07
         4SjxbEmqKZYvw==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     mchehab@kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com,
        ming.qian@nxp.com, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v3 02/11] media: videobuf2: Use Xarray instead of static buffers array
Date:   Thu, 22 Jun 2023 15:13:40 +0200
Message-Id: <20230622131349.144160-3-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230622131349.144160-1-benjamin.gaignard@collabora.com>
References: <20230622131349.144160-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of a static array change bufs to a dynamically allocated array.
This will allow to store more video buffers if needed.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 .../media/common/videobuf2/videobuf2-core.c   | 38 +++++++++++--------
 include/media/videobuf2-core.h                |  6 +--
 2 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 42fd3984c2bc..f1ff7af34a9f 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -409,18 +409,24 @@ static void init_buffer_cache_hints(struct vb2_queue *q, struct vb2_buffer *vb)
  * vb2_queue_add_buffer() - add a buffer to a queue
  * @q:	pointer to &struct vb2_queue with videobuf2 queue.
  * @vb:	pointer to &struct vb2_buffer to be added to the queue.
- * @index: index where add vb2_buffer in the queue
  */
-static bool vb2_queue_add_buffer(struct vb2_queue *q, struct vb2_buffer *vb, int index)
+static bool vb2_queue_add_buffer(struct vb2_queue *q, struct vb2_buffer *vb)
 {
-	if (index < VB2_MAX_FRAME && !q->bufs[index]) {
-		q->bufs[index] = vb;
-		vb->index = index;
-		vb->vb2_queue = q;
-		return true;
-	}
+	struct xa_limit range = {
+		.max = UINT_MAX,
+		.min = q->num_buffers,
+	};
+	u32 index;
+	int ret;
 
-	return false;
+	ret = xa_alloc(&q->bufs, &index, vb, range, GFP_KERNEL);
+	if (ret)
+		return false;
+
+	vb->index = index;
+	vb->vb2_queue = q;
+
+	return true;
 }
 
 /**
@@ -430,10 +436,8 @@ static bool vb2_queue_add_buffer(struct vb2_queue *q, struct vb2_buffer *vb, int
  */
 static void vb2_queue_remove_buffer(struct vb2_queue *q, struct vb2_buffer *vb)
 {
-	if (vb->index < VB2_MAX_FRAME) {
-		q->bufs[vb->index] = NULL;
-		vb->vb2_queue = NULL;
-	}
+	xa_erase(&q->bufs, vb->index);
+	vb->vb2_queue = NULL;
 }
 
 /*
@@ -474,7 +478,7 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
 		}
 		call_void_bufop(q, init_buffer, vb);
 
-		if (!vb2_queue_add_buffer(q, vb, q->num_buffers + buffer)) {
+		if (!vb2_queue_add_buffer(q, vb)) {
 			dprintk(q, 1, "failed adding buffer %d to queue\n", buffer);
 			kfree(vb);
 			break;
@@ -930,7 +934,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 	}
 
 	mutex_lock(&q->mmap_lock);
-	q->num_buffers = allocated_buffers;
+	q->num_buffers += allocated_buffers;
 
 	if (ret < 0) {
 		/*
@@ -2547,6 +2551,9 @@ int vb2_core_queue_init(struct vb2_queue *q)
 	mutex_init(&q->mmap_lock);
 	init_waitqueue_head(&q->done_wq);
 
+	xa_init_flags(&q->bufs, XA_FLAGS_ALLOC);
+	q->num_buffers = 0;
+
 	q->memory = VB2_MEMORY_UNKNOWN;
 
 	if (q->buf_struct_size == 0)
@@ -2574,6 +2581,7 @@ void vb2_core_queue_release(struct vb2_queue *q)
 	mutex_lock(&q->mmap_lock);
 	__vb2_queue_free(q, q->num_buffers);
 	mutex_unlock(&q->mmap_lock);
+	xa_destroy(&q->bufs);
 }
 EXPORT_SYMBOL_GPL(vb2_core_queue_release);
 
diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
index 4b6a9d2ea372..77921cf894ef 100644
--- a/include/media/videobuf2-core.h
+++ b/include/media/videobuf2-core.h
@@ -619,7 +619,7 @@ struct vb2_queue {
 	struct mutex			mmap_lock;
 	unsigned int			memory;
 	enum dma_data_direction		dma_dir;
-	struct vb2_buffer		*bufs[VB2_MAX_FRAME];
+	struct xarray			bufs;
 	unsigned int			num_buffers;
 
 	struct list_head		queued_list;
@@ -1239,9 +1239,7 @@ static inline void vb2_clear_last_buffer_dequeued(struct vb2_queue *q)
 static inline struct vb2_buffer *vb2_get_buffer(struct vb2_queue *q,
 						unsigned int index)
 {
-	if (index < q->num_buffers)
-		return q->bufs[index];
-	return NULL;
+	return xa_load(&q->bufs, index);
 }
 
 /*
-- 
2.39.2


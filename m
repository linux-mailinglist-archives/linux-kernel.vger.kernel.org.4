Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273B4705D8B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 04:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbjEQC4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 22:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjEQC4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 22:56:40 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D69C4693
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 19:56:36 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-643465067d1so160352b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 19:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684292196; x=1686884196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pn0rRQ1069cUodSkZQHKME3f6SP/5afyyYH+UGLiwYQ=;
        b=ixVTfJBjbor26hA10t+oPhph99RESRkCoahgZNt719uzttyDI8zNP3yXbY+0X40NIK
         ZvNKLcuGRKwWvJxuvVokUCfWg67IjXTna8zT7/BF131XbTStn6t8BFac03sbfzHh0GFi
         pr95sZktHdFwdaCa8x/DVCeKMaUt0zV7xPY1v9SXC9wKPqF7805W45tKIyWLtqvWluIU
         1nKK9DRBB7z+NYw0oSVl0mNn72oHN1so2xqnxaD2m8jBNa9cXW6Cxi5lkwOR+ZYoHS2A
         lJJbGzS3aKOJn8376sKJq2NX7JW0+QZv+Y4naPoto/9fsPxDR1VU1SP+uPGTp7aa1YrF
         ptFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684292196; x=1686884196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pn0rRQ1069cUodSkZQHKME3f6SP/5afyyYH+UGLiwYQ=;
        b=MPfIlMyZtoQQnE7kIUP3OARYra7WbefJGczcBRP4e/BsVo8QpH/lFGUZHJK9uRSssb
         AXzfOQ5kMhPQEU1XhgwxuZqIzZiRRdEAGvc92WLJTVwweMll95dOBJvhn9H/3MRUDYlz
         8/uuKvxUuB9ybQMwPO3/JCpmzBZo14/pmK+Ivos5pZ+fnRRbvJly7Ykuwh0tC/ZJ76Ml
         ZVA8zoZNLb8SL4UqZAOg/N+cFHWWtnkBREijg/lv7d4/qYVNTXI/idWBtG+h0d4TcJME
         /+8EcvZiPqPg6qQp4yilIEZXtd85jk4NiCb+5Ok+W+yadDFQZaBoFLQsIG+LXGZ0u7PD
         ErVg==
X-Gm-Message-State: AC+VfDxwfv5QR7JEUD4USmeH//i1GoA2b2EGhha8FEkLhoH7IbkYp4Ki
        CWKDn7+nrHG78X/F4hIGSBjPUw==
X-Google-Smtp-Source: ACHHUZ6rSaxABjF+imWw0FZRaAG647H5AKzXTfoBPonQWP5gnNVwpGiVRODTq3wsxorVLv5JRPS16g==
X-Received: by 2002:a05:6a00:a81:b0:62d:8376:3712 with SMTP id b1-20020a056a000a8100b0062d83763712mr53684870pfl.28.1684292195441;
        Tue, 16 May 2023 19:56:35 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id b19-20020aa78713000000b00643355ff6a6sm14527971pfo.99.2023.05.16.19.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 19:56:34 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     stefanha@redhat.com, mst@redhat.com, jasowang@redhat.com
Cc:     xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v2 1/2] virtio: abstract virtqueue related methods
Date:   Wed, 17 May 2023 10:54:23 +0800
Message-Id: <20230517025424.601141-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230517025424.601141-1-pizhenwei@bytedance.com>
References: <20230517025424.601141-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is already a virtqueue abstract structure in virtio subsystem
(see struct virtqueue in include/linux/virtio.h), however the vring
based virtqueue is used only in the past years, the virtqueue related
methods mix much with vring(just look like the codes, virtqueue_xxx
functions are implemented in virtio_ring.c).

Abstract virtqueue related methods(see struct virtqueue_ops), and
separate virtqueue_xxx symbols from vring. This allows a non-vring
based transport in the future. See changes in virtio.h.

All the vring based virtqueue methods could be abstratct in theory,
MST suggested that add/get bufs and kick functions are quite perfmance
sensitive, so export these functions from virtio_ring.ko, drivers
still call them in a fast path.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/virtio/virtio_ring.c | 285 +++++-----------------
 include/linux/virtio.h       | 441 +++++++++++++++++++++++++++++++----
 include/linux/virtio_ring.h  |  26 +++
 3 files changed, 483 insertions(+), 269 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index c5310eaf8b46..82c26f50d941 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -226,6 +226,7 @@ static struct virtqueue *__vring_new_virtqueue(unsigned int index,
 					       struct device *dma_dev);
 static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int num);
 static void vring_free(struct virtqueue *_vq);
+static void vring_virtqueue_set_ops(struct virtqueue *vq);
 
 /*
  * Helpers.
@@ -2036,6 +2037,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	if (!vq)
 		goto err_vq;
 
+	vring_virtqueue_set_ops(&vq->vq);
 	vq->vq.callback = callback;
 	vq->vq.vdev = vdev;
 	vq->vq.name = name;
@@ -2117,14 +2119,14 @@ static int virtqueue_resize_packed(struct virtqueue *_vq, u32 num)
  * Generic functions and exported symbols.
  */
 
-static inline int virtqueue_add(struct virtqueue *_vq,
-				struct scatterlist *sgs[],
-				unsigned int total_sg,
-				unsigned int out_sgs,
-				unsigned int in_sgs,
-				void *data,
-				void *ctx,
-				gfp_t gfp)
+int vring_virtqueue_add_sgs(struct virtqueue *_vq,
+			    struct scatterlist *sgs[],
+			    unsigned int total_sg,
+			    unsigned int out_sgs,
+			    unsigned int in_sgs,
+			    void *data,
+			    void *ctx,
+			    gfp_t gfp)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
@@ -2133,112 +2135,10 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 				 virtqueue_add_split(_vq, sgs, total_sg,
 					out_sgs, in_sgs, data, ctx, gfp);
 }
+EXPORT_SYMBOL_GPL(vring_virtqueue_add_sgs);
 
 /**
- * virtqueue_add_sgs - expose buffers to other end
- * @_vq: the struct virtqueue we're talking about.
- * @sgs: array of terminated scatterlists.
- * @out_sgs: the number of scatterlists readable by other side
- * @in_sgs: the number of scatterlists which are writable (after readable ones)
- * @data: the token identifying the buffer.
- * @gfp: how to do memory allocations (if necessary).
- *
- * Caller must ensure we don't call this with other virtqueue operations
- * at the same time (except where noted).
- *
- * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
- */
-int virtqueue_add_sgs(struct virtqueue *_vq,
-		      struct scatterlist *sgs[],
-		      unsigned int out_sgs,
-		      unsigned int in_sgs,
-		      void *data,
-		      gfp_t gfp)
-{
-	unsigned int i, total_sg = 0;
-
-	/* Count them first. */
-	for (i = 0; i < out_sgs + in_sgs; i++) {
-		struct scatterlist *sg;
-
-		for (sg = sgs[i]; sg; sg = sg_next(sg))
-			total_sg++;
-	}
-	return virtqueue_add(_vq, sgs, total_sg, out_sgs, in_sgs,
-			     data, NULL, gfp);
-}
-EXPORT_SYMBOL_GPL(virtqueue_add_sgs);
-
-/**
- * virtqueue_add_outbuf - expose output buffers to other end
- * @vq: the struct virtqueue we're talking about.
- * @sg: scatterlist (must be well-formed and terminated!)
- * @num: the number of entries in @sg readable by other side
- * @data: the token identifying the buffer.
- * @gfp: how to do memory allocations (if necessary).
- *
- * Caller must ensure we don't call this with other virtqueue operations
- * at the same time (except where noted).
- *
- * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
- */
-int virtqueue_add_outbuf(struct virtqueue *vq,
-			 struct scatterlist *sg, unsigned int num,
-			 void *data,
-			 gfp_t gfp)
-{
-	return virtqueue_add(vq, &sg, num, 1, 0, data, NULL, gfp);
-}
-EXPORT_SYMBOL_GPL(virtqueue_add_outbuf);
-
-/**
- * virtqueue_add_inbuf - expose input buffers to other end
- * @vq: the struct virtqueue we're talking about.
- * @sg: scatterlist (must be well-formed and terminated!)
- * @num: the number of entries in @sg writable by other side
- * @data: the token identifying the buffer.
- * @gfp: how to do memory allocations (if necessary).
- *
- * Caller must ensure we don't call this with other virtqueue operations
- * at the same time (except where noted).
- *
- * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
- */
-int virtqueue_add_inbuf(struct virtqueue *vq,
-			struct scatterlist *sg, unsigned int num,
-			void *data,
-			gfp_t gfp)
-{
-	return virtqueue_add(vq, &sg, num, 0, 1, data, NULL, gfp);
-}
-EXPORT_SYMBOL_GPL(virtqueue_add_inbuf);
-
-/**
- * virtqueue_add_inbuf_ctx - expose input buffers to other end
- * @vq: the struct virtqueue we're talking about.
- * @sg: scatterlist (must be well-formed and terminated!)
- * @num: the number of entries in @sg writable by other side
- * @data: the token identifying the buffer.
- * @ctx: extra context for the token
- * @gfp: how to do memory allocations (if necessary).
- *
- * Caller must ensure we don't call this with other virtqueue operations
- * at the same time (except where noted).
- *
- * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
- */
-int virtqueue_add_inbuf_ctx(struct virtqueue *vq,
-			struct scatterlist *sg, unsigned int num,
-			void *data,
-			void *ctx,
-			gfp_t gfp)
-{
-	return virtqueue_add(vq, &sg, num, 0, 1, data, ctx, gfp);
-}
-EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_ctx);
-
-/**
- * virtqueue_kick_prepare - first half of split virtqueue_kick call.
+ * vring_virtqueue_kick_prepare - first half of split virtqueue_kick call.
  * @_vq: the struct virtqueue
  *
  * Instead of virtqueue_kick(), you can do:
@@ -2248,24 +2148,24 @@ EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_ctx);
  * This is sometimes useful because the virtqueue_kick_prepare() needs
  * to be serialized, but the actual virtqueue_notify() call does not.
  */
-bool virtqueue_kick_prepare(struct virtqueue *_vq)
+bool vring_virtqueue_kick_prepare(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
 	return vq->packed_ring ? virtqueue_kick_prepare_packed(_vq) :
 				 virtqueue_kick_prepare_split(_vq);
 }
-EXPORT_SYMBOL_GPL(virtqueue_kick_prepare);
+EXPORT_SYMBOL_GPL(vring_virtqueue_kick_prepare);
 
 /**
- * virtqueue_notify - second half of split virtqueue_kick call.
+ * vring_virtqueue_notify - second half of split virtqueue_kick call.
  * @_vq: the struct virtqueue
  *
  * This does not need to be serialized.
  *
  * Returns false if host notify failed or queue is broken, otherwise true.
  */
-bool virtqueue_notify(struct virtqueue *_vq)
+bool vring_virtqueue_notify(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
@@ -2279,30 +2179,10 @@ bool virtqueue_notify(struct virtqueue *_vq)
 	}
 	return true;
 }
-EXPORT_SYMBOL_GPL(virtqueue_notify);
+EXPORT_SYMBOL_GPL(vring_virtqueue_notify);
 
 /**
- * virtqueue_kick - update after add_buf
- * @vq: the struct virtqueue
- *
- * After one or more virtqueue_add_* calls, invoke this to kick
- * the other side.
- *
- * Caller must ensure we don't call this with other virtqueue
- * operations at the same time (except where noted).
- *
- * Returns false if kick failed, otherwise true.
- */
-bool virtqueue_kick(struct virtqueue *vq)
-{
-	if (virtqueue_kick_prepare(vq))
-		return virtqueue_notify(vq);
-	return true;
-}
-EXPORT_SYMBOL_GPL(virtqueue_kick);
-
-/**
- * virtqueue_get_buf_ctx - get the next used buffer
+ * vring_virtqueue_get_buf_ctx - get the next used buffer
  * @_vq: the struct virtqueue we're talking about.
  * @len: the length written into the buffer
  * @ctx: extra context for the token
@@ -2318,23 +2198,17 @@ EXPORT_SYMBOL_GPL(virtqueue_kick);
  * Returns NULL if there are no used buffers, or the "data" token
  * handed to virtqueue_add_*().
  */
-void *virtqueue_get_buf_ctx(struct virtqueue *_vq, unsigned int *len,
-			    void **ctx)
+void *vring_virtqueue_get_buf_ctx(struct virtqueue *_vq, unsigned int *len, void **ctx)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
 	return vq->packed_ring ? virtqueue_get_buf_ctx_packed(_vq, len, ctx) :
 				 virtqueue_get_buf_ctx_split(_vq, len, ctx);
 }
-EXPORT_SYMBOL_GPL(virtqueue_get_buf_ctx);
+EXPORT_SYMBOL_GPL(vring_virtqueue_get_buf_ctx);
 
-void *virtqueue_get_buf(struct virtqueue *_vq, unsigned int *len)
-{
-	return virtqueue_get_buf_ctx(_vq, len, NULL);
-}
-EXPORT_SYMBOL_GPL(virtqueue_get_buf);
 /**
- * virtqueue_disable_cb - disable callbacks
+ * vring_virtqueue_disable_cb - disable callbacks
  * @_vq: the struct virtqueue we're talking about.
  *
  * Note that this is not necessarily synchronous, hence unreliable and only
@@ -2342,7 +2216,7 @@ EXPORT_SYMBOL_GPL(virtqueue_get_buf);
  *
  * Unlike other operations, this need not be serialized.
  */
-void virtqueue_disable_cb(struct virtqueue *_vq)
+void vring_virtqueue_disable_cb(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
@@ -2351,10 +2225,10 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
 	else
 		virtqueue_disable_cb_split(_vq);
 }
-EXPORT_SYMBOL_GPL(virtqueue_disable_cb);
+EXPORT_SYMBOL_GPL(vring_virtqueue_disable_cb);
 
 /**
- * virtqueue_enable_cb_prepare - restart callbacks after disable_cb
+ * vring_virtqueue_enable_cb_prepare - restart callbacks after disable_cb
  * @_vq: the struct virtqueue we're talking about.
  *
  * This re-enables callbacks; it returns current queue state
@@ -2365,7 +2239,7 @@ EXPORT_SYMBOL_GPL(virtqueue_disable_cb);
  * Caller must ensure we don't call this with other virtqueue
  * operations at the same time (except where noted).
  */
-unsigned int virtqueue_enable_cb_prepare(struct virtqueue *_vq)
+unsigned int vring_virtqueue_enable_cb_prepare(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
@@ -2375,18 +2249,18 @@ unsigned int virtqueue_enable_cb_prepare(struct virtqueue *_vq)
 	return vq->packed_ring ? virtqueue_enable_cb_prepare_packed(_vq) :
 				 virtqueue_enable_cb_prepare_split(_vq);
 }
-EXPORT_SYMBOL_GPL(virtqueue_enable_cb_prepare);
+EXPORT_SYMBOL_GPL(vring_virtqueue_enable_cb_prepare);
 
 /**
- * virtqueue_poll - query pending used buffers
+ * vring_virtqueue_poll - query pending used buffers
  * @_vq: the struct virtqueue we're talking about.
- * @last_used_idx: virtqueue state (from call to virtqueue_enable_cb_prepare).
+ * @last_used_idx: virtqueue state (from call to vring_virtqueue_enable_cb_prepare).
  *
  * Returns "true" if there are pending used buffers in the queue.
  *
  * This does not need to be serialized.
  */
-bool virtqueue_poll(struct virtqueue *_vq, unsigned int last_used_idx)
+bool vring_virtqueue_poll(struct virtqueue *_vq, unsigned int last_used_idx)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
@@ -2397,29 +2271,10 @@ bool virtqueue_poll(struct virtqueue *_vq, unsigned int last_used_idx)
 	return vq->packed_ring ? virtqueue_poll_packed(_vq, last_used_idx) :
 				 virtqueue_poll_split(_vq, last_used_idx);
 }
-EXPORT_SYMBOL_GPL(virtqueue_poll);
-
-/**
- * virtqueue_enable_cb - restart callbacks after disable_cb.
- * @_vq: the struct virtqueue we're talking about.
- *
- * This re-enables callbacks; it returns "false" if there are pending
- * buffers in the queue, to detect a possible race between the driver
- * checking for more work, and enabling callbacks.
- *
- * Caller must ensure we don't call this with other virtqueue
- * operations at the same time (except where noted).
- */
-bool virtqueue_enable_cb(struct virtqueue *_vq)
-{
-	unsigned int last_used_idx = virtqueue_enable_cb_prepare(_vq);
-
-	return !virtqueue_poll(_vq, last_used_idx);
-}
-EXPORT_SYMBOL_GPL(virtqueue_enable_cb);
+EXPORT_SYMBOL_GPL(vring_virtqueue_poll);
 
 /**
- * virtqueue_enable_cb_delayed - restart callbacks after disable_cb.
+ * vring_virtqueue_enable_cb_delayed - restart callbacks after disable_cb.
  * @_vq: the struct virtqueue we're talking about.
  *
  * This re-enables callbacks but hints to the other side to delay
@@ -2431,7 +2286,7 @@ EXPORT_SYMBOL_GPL(virtqueue_enable_cb);
  * Caller must ensure we don't call this with other virtqueue
  * operations at the same time (except where noted).
  */
-bool virtqueue_enable_cb_delayed(struct virtqueue *_vq)
+bool vring_virtqueue_enable_cb_delayed(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
@@ -2441,7 +2296,7 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *_vq)
 	return vq->packed_ring ? virtqueue_enable_cb_delayed_packed(_vq) :
 				 virtqueue_enable_cb_delayed_split(_vq);
 }
-EXPORT_SYMBOL_GPL(virtqueue_enable_cb_delayed);
+EXPORT_SYMBOL_GPL(vring_virtqueue_enable_cb_delayed);
 
 /**
  * virtqueue_detach_unused_buf - detach first unused buffer
@@ -2451,14 +2306,13 @@ EXPORT_SYMBOL_GPL(virtqueue_enable_cb_delayed);
  * This is not valid on an active queue; it is useful for device
  * shutdown or the reset queue.
  */
-void *virtqueue_detach_unused_buf(struct virtqueue *_vq)
+static void *vring_virtqueue_detach_unused_buf(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
 	return vq->packed_ring ? virtqueue_detach_unused_buf_packed(_vq) :
 				 virtqueue_detach_unused_buf_split(_vq);
 }
-EXPORT_SYMBOL_GPL(virtqueue_detach_unused_buf);
 
 static inline bool more_used(const struct vring_virtqueue *vq)
 {
@@ -2525,6 +2379,7 @@ static struct virtqueue *__vring_new_virtqueue(unsigned int index,
 	if (!vq)
 		return NULL;
 
+	vring_virtqueue_set_ops(&vq->vq);
 	vq->packed_ring = false;
 	vq->vq.callback = callback;
 	vq->vq.vdev = vdev;
@@ -2639,8 +2494,8 @@ EXPORT_SYMBOL_GPL(vring_create_virtqueue_dma);
  * -EPERM: Operation not permitted
  *
  */
-int virtqueue_resize(struct virtqueue *_vq, u32 num,
-		     void (*recycle)(struct virtqueue *vq, void *buf))
+static int vring_virtqueue_resize(struct virtqueue *_vq, u32 num,
+				  void (*recycle)(struct virtqueue *vq, void *buf))
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	struct virtio_device *vdev = vq->vq.vdev;
@@ -2682,7 +2537,6 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
 
 	return err;
 }
-EXPORT_SYMBOL_GPL(virtqueue_resize);
 
 /* Only available for split ring */
 struct virtqueue *vring_new_virtqueue(unsigned int index,
@@ -2815,14 +2669,13 @@ EXPORT_SYMBOL_GPL(vring_transport_features);
  * Returns the size of the vring.  This is mainly used for boasting to
  * userspace.  Unlike other operations, this need not be serialized.
  */
-unsigned int virtqueue_get_vring_size(const struct virtqueue *_vq)
+static unsigned int vring_virtqueue_get_vring_size(const struct virtqueue *_vq)
 {
 
 	const struct vring_virtqueue *vq = to_vvq(_vq);
 
 	return vq->packed_ring ? vq->packed.vring.num : vq->split.vring.num;
 }
-EXPORT_SYMBOL_GPL(virtqueue_get_vring_size);
 
 /*
  * This function should only be called by the core, not directly by the driver.
@@ -2831,7 +2684,7 @@ void __virtqueue_break(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
-	/* Pairs with READ_ONCE() in virtqueue_is_broken(). */
+	/* Pairs with READ_ONCE() in vring_virtqueue_is_broken(). */
 	WRITE_ONCE(vq->broken, true);
 }
 EXPORT_SYMBOL_GPL(__virtqueue_break);
@@ -2843,59 +2696,18 @@ void __virtqueue_unbreak(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
-	/* Pairs with READ_ONCE() in virtqueue_is_broken(). */
+	/* Pairs with READ_ONCE() in vring_virtqueue_is_broken(). */
 	WRITE_ONCE(vq->broken, false);
 }
 EXPORT_SYMBOL_GPL(__virtqueue_unbreak);
 
-bool virtqueue_is_broken(const struct virtqueue *_vq)
+bool vring_virtqueue_is_broken(const struct virtqueue *_vq)
 {
 	const struct vring_virtqueue *vq = to_vvq(_vq);
 
 	return READ_ONCE(vq->broken);
 }
-EXPORT_SYMBOL_GPL(virtqueue_is_broken);
-
-/*
- * This should prevent the device from being used, allowing drivers to
- * recover.  You may need to grab appropriate locks to flush.
- */
-void virtio_break_device(struct virtio_device *dev)
-{
-	struct virtqueue *_vq;
-
-	spin_lock(&dev->vqs_list_lock);
-	list_for_each_entry(_vq, &dev->vqs, list) {
-		struct vring_virtqueue *vq = to_vvq(_vq);
-
-		/* Pairs with READ_ONCE() in virtqueue_is_broken(). */
-		WRITE_ONCE(vq->broken, true);
-	}
-	spin_unlock(&dev->vqs_list_lock);
-}
-EXPORT_SYMBOL_GPL(virtio_break_device);
-
-/*
- * This should allow the device to be used by the driver. You may
- * need to grab appropriate locks to flush the write to
- * vq->broken. This should only be used in some specific case e.g
- * (probing and restoring). This function should only be called by the
- * core, not directly by the driver.
- */
-void __virtio_unbreak_device(struct virtio_device *dev)
-{
-	struct virtqueue *_vq;
-
-	spin_lock(&dev->vqs_list_lock);
-	list_for_each_entry(_vq, &dev->vqs, list) {
-		struct vring_virtqueue *vq = to_vvq(_vq);
-
-		/* Pairs with READ_ONCE() in virtqueue_is_broken(). */
-		WRITE_ONCE(vq->broken, false);
-	}
-	spin_unlock(&dev->vqs_list_lock);
-}
-EXPORT_SYMBOL_GPL(__virtio_unbreak_device);
+EXPORT_SYMBOL_GPL(vring_virtqueue_is_broken);
 
 dma_addr_t virtqueue_get_desc_addr(const struct virtqueue *_vq)
 {
@@ -2946,3 +2758,16 @@ const struct vring *virtqueue_get_vring(const struct virtqueue *vq)
 EXPORT_SYMBOL_GPL(virtqueue_get_vring);
 
 MODULE_LICENSE("GPL");
+
+static void vring_virtqueue_set_ops(struct virtqueue *vq)
+{
+	/* In theory, add/get bufs and kick functions also could be overwritten,
+	 * these functions are quite perfmance sensitive, so call them directly.
+	 */
+	vq->abstract = false;
+	vq->detach_unused_buf = vring_virtqueue_detach_unused_buf;
+	vq->get_vring_size = vring_virtqueue_get_vring_size;
+	vq->resize = vring_virtqueue_resize;
+	vq->__break = __virtqueue_break;
+	vq->__unbreak = __virtqueue_unbreak;
+}
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index b93238db94e3..203f0397dc58 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -9,6 +9,7 @@
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
 #include <linux/gfp.h>
+#include <linux/virtio_ring.h>
 
 /**
  * struct virtqueue - a queue to register buffers for sending or receiving.
@@ -35,67 +36,399 @@ struct virtqueue {
 	unsigned int num_free;
 	unsigned int num_max;
 	bool reset;
+	bool abstract;
 	void *priv;
+
+	/* abstract operations */
+	int (*add_sgs)(struct virtqueue *vq, struct scatterlist *sgs[],
+		       unsigned int total_sg,
+		       unsigned int out_sgs, unsigned int in_sgs,
+		       void *data, void *ctx, gfp_t gfp);
+	bool (*kick_prepare)(struct virtqueue *vq);
+	bool (*notify)(struct virtqueue *vq);
+	unsigned int (*enable_cb_prepare)(struct virtqueue *vq);
+	bool (*enable_cb_delayed)(struct virtqueue *vq);
+	void (*disable_cb)(struct virtqueue *vq);
+	bool (*poll)(struct virtqueue *vq, unsigned int idx);
+	void *(*get_buf_ctx)(struct virtqueue *vq, unsigned int *len, void **ctx);
+	void *(*detach_unused_buf)(struct virtqueue *vq);
+	unsigned int (*get_vring_size)(const struct virtqueue *vq);
+	int (*resize)(struct virtqueue *vq, u32 num,
+		      void (*recycle)(struct virtqueue *vq, void *buf));
+	void (*__break)(struct virtqueue *vq);
+	void (*__unbreak)(struct virtqueue *vq);
+	bool (*is_broken)(const struct virtqueue *vq);
 };
 
-int virtqueue_add_outbuf(struct virtqueue *vq,
-			 struct scatterlist sg[], unsigned int num,
-			 void *data,
-			 gfp_t gfp);
+/**
+ * virtqueue_add_sgs - expose buffers to other end
+ * @vq: the struct virtqueue we're talking about.
+ * @sgs: array of terminated scatterlists.
+ * @out_sgs: the number of scatterlists readable by other side
+ * @in_sgs: the number of scatterlists which are writable (after readable ones)
+ * @data: the token identifying the buffer.
+ * @gfp: how to do memory allocations (if necessary).
+ *
+ * Caller must ensure we don't call this with other virtqueue operations
+ * at the same time (except where noted).
+ *
+ * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
+ */
+static inline int virtqueue_add_sgs(struct virtqueue *vq,
+				    struct scatterlist *sgs[],
+				    unsigned int out_sgs,
+				    unsigned int in_sgs,
+				    void *data, gfp_t gfp)
+{
+	unsigned int i, total_sg = 0;
+
+	/* Count them first. */
+	for (i = 0; i < out_sgs + in_sgs; i++) {
+		struct scatterlist *sg;
+
+		for (sg = sgs[i]; sg; sg = sg_next(sg))
+			total_sg++;
+	}
+
+	if (likely(!vq->abstract))
+		return vring_virtqueue_add_sgs(vq, sgs, total_sg, out_sgs, in_sgs, data, NULL, gfp);
+
+	return vq->add_sgs(vq, sgs, total_sg, out_sgs, in_sgs, data, NULL, gfp);
+}
+
+/**
+ * virtqueue_add_outbuf - expose output buffers to other end
+ * @vq: the struct virtqueue we're talking about.
+ * @sg: scatterlist (must be well-formed and terminated!)
+ * @num: the number of entries in @sg readable by other side
+ * @data: the token identifying the buffer.
+ * @gfp: how to do memory allocations (if necessary).
+ *
+ * Caller must ensure we don't call this with other virtqueue operations
+ * at the same time (except where noted).
+ *
+ * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
+ */
+static inline int virtqueue_add_outbuf(struct virtqueue *vq,
+				       struct scatterlist *sg,
+				       unsigned int num,
+				       void *data,
+				       gfp_t gfp)
+{
+	if (likely(!vq->abstract))
+		return vring_virtqueue_add_sgs(vq, &sg, num, 1, 0, data, NULL, gfp);
+
+	return vq->add_sgs(vq, &sg, num, 1, 0, data, NULL, gfp);
+}
 
-int virtqueue_add_inbuf(struct virtqueue *vq,
-			struct scatterlist sg[], unsigned int num,
-			void *data,
-			gfp_t gfp);
+/**
+ * virtqueue_add_inbuf - expose input buffers to other end
+ * @vq: the struct virtqueue we're talking about.
+ * @sg: scatterlist (must be well-formed and terminated!)
+ * @num: the number of entries in @sg writable by other side
+ * @data: the token identifying the buffer.
+ * @gfp: how to do memory allocations (if necessary).
+ *
+ * Caller must ensure we don't call this with other virtqueue operations
+ * at the same time (except where noted).
+ *
+ * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
+ */
+static inline int virtqueue_add_inbuf(struct virtqueue *vq,
+				      struct scatterlist *sg,
+				      unsigned int num,
+				      void *data,
+				      gfp_t gfp)
+{
+	if (likely(!vq->abstract))
+		return vring_virtqueue_add_sgs(vq, &sg, num, 0, 1, data, NULL, gfp);
 
-int virtqueue_add_inbuf_ctx(struct virtqueue *vq,
-			    struct scatterlist sg[], unsigned int num,
-			    void *data,
-			    void *ctx,
-			    gfp_t gfp);
+	return vq->add_sgs(vq, &sg, num, 0, 1, data, NULL, gfp);
+}
 
-int virtqueue_add_sgs(struct virtqueue *vq,
-		      struct scatterlist *sgs[],
-		      unsigned int out_sgs,
-		      unsigned int in_sgs,
-		      void *data,
-		      gfp_t gfp);
+/**
+ * virtqueue_add_inbuf_ctx - expose input buffers to other end
+ * @vq: the struct virtqueue we're talking about.
+ * @sg: scatterlist (must be well-formed and terminated!)
+ * @num: the number of entries in @sg writable by other side
+ * @data: the token identifying the buffer.
+ * @ctx: extra context for the token
+ * @gfp: how to do memory allocations (if necessary).
+ *
+ * Caller must ensure we don't call this with other virtqueue operations
+ * at the same time (except where noted).
+ *
+ * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
+ */
+static inline int virtqueue_add_inbuf_ctx(struct virtqueue *vq,
+					  struct scatterlist *sg,
+					  unsigned int num,
+					  void *data,
+					  void *ctx,
+					  gfp_t gfp)
+{
+	if (likely(!vq->abstract))
+		return vring_virtqueue_add_sgs(vq, &sg, num, 0, 1, data, ctx, gfp);
 
-bool virtqueue_kick(struct virtqueue *vq);
+	return vq->add_sgs(vq, &sg, num, 0, 1, data, ctx, gfp);
+}
 
-bool virtqueue_kick_prepare(struct virtqueue *vq);
+/**
+ * virtqueue_kick_prepare - first half of split virtqueue_kick call.
+ * @vq: the struct virtqueue
+ *
+ * Instead of virtqueue_kick(), you can do:
+ *	if (virtqueue_kick_prepare(vq))
+ *		virtqueue_notify(vq);
+ *
+ * This is sometimes useful because the virtqueue_kick_prepare() needs
+ * to be serialized, but the actual virtqueue_notify() call does not.
+ */
+static inline bool virtqueue_kick_prepare(struct virtqueue *vq)
+{
+	if (likely(!vq->abstract))
+		return vring_virtqueue_kick_prepare(vq);
 
-bool virtqueue_notify(struct virtqueue *vq);
+	return vq->kick_prepare(vq);
+}
 
-void *virtqueue_get_buf(struct virtqueue *vq, unsigned int *len);
+/**
+ * virtqueue_notify - second half of split virtqueue_kick call.
+ * @vq: the struct virtqueue
+ *
+ * This does not need to be serialized.
+ *
+ * Returns false if host notify failed or queue is broken, otherwise true.
+ */
+static inline bool virtqueue_notify(struct virtqueue *vq)
+{
+	if (likely(!vq->abstract))
+		return vring_virtqueue_notify(vq);
 
-void *virtqueue_get_buf_ctx(struct virtqueue *vq, unsigned int *len,
-			    void **ctx);
+	return vq->notify(vq);
+}
 
-void virtqueue_disable_cb(struct virtqueue *vq);
+/**
+ * virtqueue_kick - update after add_buf
+ * @vq: the struct virtqueue
+ *
+ * After one or more virtqueue_add_* calls, invoke this to kick
+ * the other side.
+ *
+ * Caller must ensure we don't call this with other virtqueue
+ * operations at the same time (except where noted).
+ *
+ * Returns false if kick failed, otherwise true.
+ */
+static inline bool virtqueue_kick(struct virtqueue *vq)
+{
+	if (virtqueue_kick_prepare(vq))
+		return virtqueue_notify(vq);
 
-bool virtqueue_enable_cb(struct virtqueue *vq);
+	return true;
+}
 
-unsigned virtqueue_enable_cb_prepare(struct virtqueue *vq);
+/**
+ * virtqueue_enable_cb_prepare - restart callbacks after disable_cb
+ * @vq: the struct virtqueue we're talking about.
+ *
+ * This re-enables callbacks; it returns current queue state
+ * in an opaque unsigned value. This value should be later tested by
+ * virtqueue_poll, to detect a possible race between the driver checking for
+ * more work, and enabling callbacks.
+ *
+ * Caller must ensure we don't call this with other virtqueue
+ * operations at the same time (except where noted).
+ */
+static inline unsigned int virtqueue_enable_cb_prepare(struct virtqueue *vq)
+{
+	if (likely(!vq->abstract))
+		return vring_virtqueue_enable_cb_prepare(vq);
 
-bool virtqueue_poll(struct virtqueue *vq, unsigned);
+	return vq->enable_cb_prepare(vq);
+}
 
-bool virtqueue_enable_cb_delayed(struct virtqueue *vq);
+/**
+ * virtqueue_poll - query pending used buffers
+ * @vq: the struct virtqueue we're talking about.
+ * @last_used_idx: virtqueue state (from call to virtqueue_enable_cb_prepare).
+ *
+ * Returns "true" if there are pending used buffers in the queue.
+ *
+ * This does not need to be serialized.
+ */
+static inline bool virtqueue_poll(struct virtqueue *vq, unsigned int idx)
+{
+	if (likely(!vq->abstract))
+		return vring_virtqueue_poll(vq, idx);
 
-void *virtqueue_detach_unused_buf(struct virtqueue *vq);
+	return vq->poll(vq, idx);
+}
 
-unsigned int virtqueue_get_vring_size(const struct virtqueue *vq);
+/**
+ * virtqueue_enable_cb - restart callbacks after disable_cb.
+ * @vq: the struct virtqueue we're talking about.
+ *
+ * This re-enables callbacks; it returns "false" if there are pending
+ * buffers in the queue, to detect a possible race between the driver
+ * checking for more work, and enabling callbacks.
+ *
+ * Caller must ensure we don't call this with other virtqueue
+ * operations at the same time (except where noted).
+ */
+static inline bool virtqueue_enable_cb(struct virtqueue *vq)
+{
+	unsigned int opaque = virtqueue_enable_cb_prepare(vq);
 
-bool virtqueue_is_broken(const struct virtqueue *vq);
+	return !virtqueue_poll(vq, opaque);
+}
+
+/**
+ * virtqueue_enable_cb_delayed - restart callbacks after disable_cb.
+ * @vq: the struct virtqueue we're talking about.
+ *
+ * This re-enables callbacks but hints to the other side to delay
+ * interrupts until most of the available buffers have been processed;
+ * it returns "false" if there are many pending buffers in the queue,
+ * to detect a possible race between the driver checking for more work,
+ * and enabling callbacks.
+ *
+ * Caller must ensure we don't call this with other virtqueue
+ * operations at the same time (except where noted).
+ */
+static inline bool virtqueue_enable_cb_delayed(struct virtqueue *vq)
+{
+	if (likely(!vq->abstract))
+		return vring_virtqueue_enable_cb_delayed(vq);
+
+	return vq->enable_cb_delayed(vq);
+}
+
+/**
+ * virtqueue_disable_cb - disable callbacks
+ * @vq: the struct virtqueue we're talking about.
+ *
+ * Note that this is not necessarily synchronous, hence unreliable and only
+ * useful as an optimization.
+ *
+ * Unlike other operations, this need not be serialized.
+ */
+static inline void virtqueue_disable_cb(struct virtqueue *vq)
+{
+	if (likely(!vq->abstract)) {
+		vring_virtqueue_disable_cb(vq);
+		return;
+	}
+
+	vq->disable_cb(vq);
+}
+
+/**
+ * virtqueue_get_buf_ctx - get the next used buffer
+ * @vq: the struct virtqueue we're talking about.
+ * @len: the length written into the buffer
+ * @ctx: extra context for the token
+ *
+ * If the device wrote data into the buffer, @len will be set to the
+ * amount written.  This means you don't need to clear the buffer
+ * beforehand to ensure there's no data leakage in the case of short
+ * writes.
+ *
+ * Caller must ensure we don't call this with other virtqueue
+ * operations at the same time (except where noted).
+ *
+ * Returns NULL if there are no used buffers, or the "data" token
+ * handed to virtqueue_add_*().
+ */
+static inline void *virtqueue_get_buf_ctx(struct virtqueue *vq,
+					  unsigned int *len,
+					  void **ctx)
+{
+	if (likely(!vq->abstract))
+		return vring_virtqueue_get_buf_ctx(vq, len, ctx);
+
+	return vq->get_buf_ctx(vq, len, ctx);
+}
+
+static inline void *virtqueue_get_buf(struct virtqueue *vq, unsigned int *len)
+{
+	if (likely(!vq->abstract))
+		return vring_virtqueue_get_buf_ctx(vq, len, NULL);
+
+	return vq->get_buf_ctx(vq, len, NULL);
+}
+
+/**
+ * virtqueue_detach_unused_buf - detach first unused buffer
+ * @vq: the struct virtqueue we're talking about.
+ *
+ * Returns NULL or the "data" token handed to virtqueue_add_*().
+ * This is not valid on an active queue; it is useful for device
+ * shutdown or the reset queue.
+ */
+static inline void *virtqueue_detach_unused_buf(struct virtqueue *vq)
+{
+	return vq->detach_unused_buf(vq);
+}
+
+/**
+ * virtqueue_get_vring_size - return the size of the virtqueue's vring
+ * @vq: the struct virtqueue containing the vring of interest.
+ *
+ * Returns the size of the vring.  This is mainly used for boasting to
+ * userspace.  Unlike other operations, this need not be serialized.
+ */
+static inline unsigned int virtqueue_get_vring_size(const struct virtqueue *vq)
+{
+	return vq->get_vring_size(vq);
+}
+
+/**
+ * virtqueue_resize - resize the vring of vq
+ * @vq: the struct virtqueue we're talking about.
+ * @num: new ring num
+ * @recycle: callback for recycle the useless buffer
+ *
+ * When it is really necessary to create a new vring, it will set the current vq
+ * into the reset state. Then call the passed callback to recycle the buffer
+ * that is no longer used. Only after the new vring is successfully created, the
+ * old vring will be released.
+ *
+ * Caller must ensure we don't call this with other virtqueue operations
+ * at the same time (except where noted).
+ *
+ * Returns zero or a negative error.
+ * 0: success.
+ * -ENOMEM: Failed to allocate a new ring, fall back to the original ring size.
+ *  vq can still work normally
+ * -EBUSY: Failed to sync with device, vq may not work properly
+ * -ENOENT: Transport or device not supported
+ * -E2BIG/-EINVAL: num error
+ * -EPERM: Operation not permitted
+ *
+ */
+static inline int virtqueue_resize(struct virtqueue *vq, u32 num,
+				   void (*recycle)(struct virtqueue *vq, void *buf))
+{
+	if (vq->resize)
+		return vq->resize(vq, num, recycle);
+
+	return -ENOENT;
+}
+
+static inline bool virtqueue_is_broken(const struct virtqueue *vq)
+{
+	if (likely(!vq->abstract))
+		return vring_virtqueue_is_broken(vq);
+
+	return vq->is_broken(vq);
+}
 
 const struct vring *virtqueue_get_vring(const struct virtqueue *vq);
 dma_addr_t virtqueue_get_desc_addr(const struct virtqueue *vq);
 dma_addr_t virtqueue_get_avail_addr(const struct virtqueue *vq);
 dma_addr_t virtqueue_get_used_addr(const struct virtqueue *vq);
 
-int virtqueue_resize(struct virtqueue *vq, u32 num,
-		     void (*recycle)(struct virtqueue *vq, void *buf));
-
 /**
  * struct virtio_device - representation of a device using virtio
  * @index: unique position on the virtio bus
@@ -134,9 +467,6 @@ int register_virtio_device(struct virtio_device *dev);
 void unregister_virtio_device(struct virtio_device *dev);
 bool is_virtio_device(struct device *dev);
 
-void virtio_break_device(struct virtio_device *dev);
-void __virtio_unbreak_device(struct virtio_device *dev);
-
 void __virtqueue_break(struct virtqueue *_vq);
 void __virtqueue_unbreak(struct virtqueue *_vq);
 
@@ -149,6 +479,39 @@ void virtio_reset_device(struct virtio_device *dev);
 
 size_t virtio_max_dma_size(const struct virtio_device *vdev);
 
+/*
+ * This should prevent the device from being used, allowing drivers to
+ * recover.  You may need to grab appropriate locks to flush.
+ */
+static inline void virtio_break_device(struct virtio_device *dev)
+{
+	struct virtqueue *vq;
+
+	spin_lock(&dev->vqs_list_lock);
+	list_for_each_entry(vq, &dev->vqs, list) {
+		vq->__break(vq);
+	}
+	spin_unlock(&dev->vqs_list_lock);
+}
+
+/*
+ * This should allow the device to be used by the driver. You may
+ * need to grab appropriate locks to flush the write to
+ * vq->broken. This should only be used in some specific case e.g
+ * (probing and restoring). This function should only be called by the
+ * core, not directly by the driver.
+ */
+static inline void __virtio_unbreak_device(struct virtio_device *dev)
+{
+	struct virtqueue *vq;
+
+	spin_lock(&dev->vqs_list_lock);
+	list_for_each_entry(vq, &dev->vqs, list) {
+		vq->__unbreak(vq);
+	}
+	spin_unlock(&dev->vqs_list_lock);
+}
+
 #define virtio_device_for_each_vq(vdev, vq) \
 	list_for_each_entry(vq, &vdev->vqs, list)
 
diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index 9b33df741b63..3cfbc98ab3c6 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -4,6 +4,7 @@
 
 #include <asm/barrier.h>
 #include <linux/irqreturn.h>
+#include <linux/scatterlist.h>
 #include <uapi/linux/virtio_ring.h>
 
 /*
@@ -108,6 +109,31 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
 				      void (*callback)(struct virtqueue *vq),
 				      const char *name);
 
+int vring_virtqueue_add_sgs(struct virtqueue *_vq,
+			    struct scatterlist *sgs[],
+			    unsigned int total_sg,
+			    unsigned int out_sgs,
+			    unsigned int in_sgs,
+			    void *data,
+			    void *ctx,
+			    gfp_t gfp);
+
+bool vring_virtqueue_kick_prepare(struct virtqueue *vq);
+
+bool vring_virtqueue_notify(struct virtqueue *vq);
+
+void *vring_virtqueue_get_buf_ctx(struct virtqueue *vq, unsigned int *len, void **ctx);
+
+void vring_virtqueue_disable_cb(struct virtqueue *vq);
+
+unsigned vring_virtqueue_enable_cb_prepare(struct virtqueue *vq);
+
+bool vring_virtqueue_poll(struct virtqueue *vq, unsigned);
+
+bool vring_virtqueue_enable_cb_delayed(struct virtqueue *vq);
+
+bool vring_virtqueue_is_broken(const struct virtqueue *vq);
+
 /*
  * Destroys a virtqueue.  If created with vring_create_virtqueue, this
  * also frees the ring.
-- 
2.20.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C632F705D8F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 04:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbjEQC5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 22:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjEQC5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 22:57:02 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4B84215
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 19:56:38 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64384c6797eso152652b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 19:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684292198; x=1686884198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNR0ELjA7D2S00xqqzGzOkpPvuTb1rz+KyHRpi9sdyI=;
        b=kuDjzxnjwcWsTkQeL4gr80ola2quVtUXgXvVWK1R6gypwIEeSUikVA0NXEtXPX9qUd
         tTQxouwC5LX8aGG4gLnn/y8s2qLQQjU8NF8QIpGQW/dnnpfqwAFZvQ8/K09kY1KXqJf5
         5jHls3NIPyuHifDxdQ8QKKVfGW9s/QeUO6WeRXc7ImbgyNG5wZfJojjIp/+Fqd4AZIot
         MtKmYufs6ep9fWbN+b8XtYr6Q9ChaSauAPZYlag9XKyxGnTygpeYG+QyZw1fcXirLO+S
         cVU96gsSIoeWifvnnTTQnjv1ZeOKQl4C6Va9oyu9yPDupfH0aiPimb3U43xnbT0+n1qB
         j7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684292198; x=1686884198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YNR0ELjA7D2S00xqqzGzOkpPvuTb1rz+KyHRpi9sdyI=;
        b=FGpriGcgJGlgufh+8doNrvRHKndHKsBSESrS3KricF5L8rMeFGcaspy9zGhO6Qx1wN
         9nwM+rljxOZmts4gxNprWfdoxneg8SYyYQgzuWOoFmpGZOuYxW/p5Py4/Si7Q4IKXYX9
         ZAO3haOVr75pZwxSxp/9vrIoc2FkQXkVZMvbG/qPQb4945QfctyKO4XCuco+RzUvHK/4
         nq7YuMBVLPsJURtu0qGGh6YgQK2NR5FfaTwRizrXI+qna+5hJWwQfZ+B+h0cgEDGKph3
         wcBQXK/vlHUW2R2Za/xAe0wjcF+bdrTF/G6abyOZ1Ex3NfEta6poKkbBOnL6f8FFRgqW
         8p7w==
X-Gm-Message-State: AC+VfDwsWgDJ1uPxOotdJlzR6TvWPnIpQGS3Z0Fcw11qVXFYOb2TOIHP
        Yh/KjWusjqlbwaeYbVv4ngpmgA==
X-Google-Smtp-Source: ACHHUZ7xXvQYNGELgpFriUG501xpoJ1MGa2FRvJ6ssAeMoOSnFzD6KYjhwLdtSnghhae8a/3ud57sA==
X-Received: by 2002:a05:6a00:2da8:b0:64c:aa98:a69f with SMTP id fb40-20020a056a002da800b0064caa98a69fmr11453469pfb.1.1684292198325;
        Tue, 16 May 2023 19:56:38 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id b19-20020aa78713000000b00643355ff6a6sm14527971pfo.99.2023.05.16.19.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 19:56:37 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     stefanha@redhat.com, mst@redhat.com, jasowang@redhat.com
Cc:     xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v2 2/2] tools/virtio: implement virtqueue in test
Date:   Wed, 17 May 2023 10:54:24 +0800
Message-Id: <20230517025424.601141-3-pizhenwei@bytedance.com>
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

virtqueue related functions has been abstract since commit
("virtio: abstract virtqueue related methods"), add compatible for
abstract API.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 tools/virtio/linux/virtio.h | 355 ++++++++++++++++++++++++++++++++----
 1 file changed, 324 insertions(+), 31 deletions(-)

diff --git a/tools/virtio/linux/virtio.h b/tools/virtio/linux/virtio.h
index 5d3440f474dd..3531dba53584 100644
--- a/tools/virtio/linux/virtio.h
+++ b/tools/virtio/linux/virtio.h
@@ -4,6 +4,7 @@
 #include <linux/scatterlist.h>
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
+#include <linux/virtio_ring.h>
 
 struct device {
 	void *parent;
@@ -27,46 +28,338 @@ struct virtqueue {
 	unsigned int num_max;
 	void *priv;
 	bool reset;
+	bool abstract;
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
 
-/* Interfaces exported by virtio_ring. */
-int virtqueue_add_sgs(struct virtqueue *vq,
-		      struct scatterlist *sgs[],
-		      unsigned int out_sgs,
-		      unsigned int in_sgs,
-		      void *data,
-		      gfp_t gfp);
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
 
-int virtqueue_add_outbuf(struct virtqueue *vq,
-			 struct scatterlist sg[], unsigned int num,
-			 void *data,
-			 gfp_t gfp);
+	/* Count them first. */
+	for (i = 0; i < out_sgs + in_sgs; i++) {
+		struct scatterlist *sg;
 
-int virtqueue_add_inbuf(struct virtqueue *vq,
-			struct scatterlist sg[], unsigned int num,
-			void *data,
-			gfp_t gfp);
+		for (sg = sgs[i]; sg; sg = sg_next(sg))
+			total_sg++;
+	}
 
-bool virtqueue_kick(struct virtqueue *vq);
+	if (likely(!vq->abstract))
+		return vring_virtqueue_add_sgs(vq, sgs, total_sg, out_sgs, in_sgs, data, NULL, gfp);
 
-void *virtqueue_get_buf(struct virtqueue *vq, unsigned int *len);
+	return vq->add_sgs(vq, sgs, total_sg, out_sgs, in_sgs, data, NULL, gfp);
+}
 
-void virtqueue_disable_cb(struct virtqueue *vq);
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
 
-bool virtqueue_enable_cb(struct virtqueue *vq);
-bool virtqueue_enable_cb_delayed(struct virtqueue *vq);
+	return vq->add_sgs(vq, &sg, num, 1, 0, data, NULL, gfp);
+}
 
-void *virtqueue_detach_unused_buf(struct virtqueue *vq);
-struct virtqueue *vring_new_virtqueue(unsigned int index,
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
 				      unsigned int num,
-				      unsigned int vring_align,
-				      struct virtio_device *vdev,
-				      bool weak_barriers,
-				      bool ctx,
-				      void *pages,
-				      bool (*notify)(struct virtqueue *vq),
-				      void (*callback)(struct virtqueue *vq),
-				      const char *name);
-void vring_del_virtqueue(struct virtqueue *vq);
+				      void *data,
+				      gfp_t gfp)
+{
+	if (likely(!vq->abstract))
+		return vring_virtqueue_add_sgs(vq, &sg, num, 0, 1, data, NULL, gfp);
+
+	return vq->add_sgs(vq, &sg, num, 0, 1, data, NULL, gfp);
+}
+
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
+
+	return vq->add_sgs(vq, &sg, num, 0, 1, data, ctx, gfp);
+}
+
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
+
+	return vq->kick_prepare(vq);
+}
+
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
+
+	return vq->notify(vq);
+}
+
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
+
+	return true;
+}
+
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
+
+	return vq->enable_cb_prepare(vq);
+}
+
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
+
+	return vq->poll(vq, idx);
+}
+
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
+
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
 
 #endif
-- 
2.20.1


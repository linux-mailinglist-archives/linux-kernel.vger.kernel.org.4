Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C8365604B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 07:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiLZGQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 01:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiLZGQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 01:16:38 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9873CC9
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 22:16:37 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id m7-20020a17090a730700b00225ebb9cd01so2106398pjk.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 22:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rlDQxTiak8ItkWBX2P6l1BnlqCgl6LW2qsUPfIl+irU=;
        b=SmhU2jX9y+DBI3b4BiH3jIGcNGzuAQHWaTMEEQhxBLyvjXEXaDuVdgbSa7zd0gUmS6
         +5wFQIypmMbBuuG3H3xvUhEfvCZclw2K8oY/ZJl7KayHV/524/3dt/gatpeog7YQaDjr
         thyYUe9upjy72VyxLA+CYxz9m771Zs4xTg8vc3ZSFKq7IeLf0+9tOroEnN6rp7+b5Iq+
         2OcDGBbrXtR5kF0z2NbQP4qk77QbEycVhHCU5KrhIajqguRUd9XdYZ23y36Yi8AH5Sp2
         QN8twawmqAhBLjnmZ1UWeBw/UCkEYpfE+jB3UAdmE/uRQ2BCaZ4LPQiGaGO9Pfvxphtx
         dtMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rlDQxTiak8ItkWBX2P6l1BnlqCgl6LW2qsUPfIl+irU=;
        b=ylc2yWYC9QwnTYnQBpC8Q/cwRWbWUqJ1tJdES5a+WMzbkoNSYvVK8So8o/DScbXZix
         bGPwbAVZRuWYC5P4xlPdiAQC3/fS00vlbWECgd0LD1TDut7sgzsj1+Cnd8yzrnPRh/hQ
         Z1J6lVXFZJA+zsZmteH4V7TlW8oeUfBU89UjLOTtuwkL7HD3c1P/NsAVODSOJ4Fk7G87
         N9aqSvr1jpXs2BBrEkYDciOkiKl1BF+JVeKBwoFlIDRstWuzIVetLc0nlpIw78pVGnXf
         TEFoQ4MbXZS6VLZSxHePfPZ5SM0fMvtCIqHHw+BpcwUOG1OXornk/UlXr4aPdv+nrUQN
         qOBw==
X-Gm-Message-State: AFqh2kqjuI0vZqAJ1IIj0yPpb0BFo2Ot2DsV0aeEOXg8Jxhq7jVYfuSR
        YAQggigNDgRn0MrgJ374D3Y=
X-Google-Smtp-Source: AMrXdXv/s4gSZl9ItUkF8X/pWFQdy/90Njq2968ELafkCE87E3cpibA+cWiVL7t7XzsBsyMj5+23+Q==
X-Received: by 2002:a17:90a:5e4b:b0:21c:f927:f573 with SMTP id u11-20020a17090a5e4b00b0021cf927f573mr19550963pji.41.1672035397300;
        Sun, 25 Dec 2022 22:16:37 -0800 (PST)
Received: from localhost.localdomain ([107.150.17.4])
        by smtp.googlemail.com with ESMTPSA id om7-20020a17090b3a8700b001fde655225fsm13321766pjb.2.2022.12.25.22.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 22:16:35 -0800 (PST)
From:   Liang Chen <liangchen.linux@gmail.com>
To:     virtualization@lists.linux-foundation.org
Cc:     mst@redhat.com, jasowang@redhat.com, linux-kernel@vger.kernel.org,
        Liang Chen <liangchen.linux@gmail.com>
Subject: [PATCH] virtio_ring: share __vring_new_virtqueue with packed ring
Date:   Mon, 26 Dec 2022 14:16:19 +0800
Message-Id: <20221226061619.1161646-1-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Packed ring allocation and initialization was explicitly done in
vring_create_virtqueue_packed, which resulted in much of the logic
implemented in __vring_new_virtqueue to be duplicated there. With some
adjustment to __vring_new_virtqueue, it can now be used for packed ring
creation as well.

Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
---
 drivers/virtio/virtio_ring.c | 83 +++++++++++-------------------------
 1 file changed, 25 insertions(+), 58 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 2e7689bb933b..991af334ac6a 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -213,7 +213,7 @@ struct vring_virtqueue {
 };
 
 static struct virtqueue *__vring_new_virtqueue(unsigned int index,
-					       struct vring_virtqueue_split *vring_split,
+					       void *vring,
 					       struct virtio_device *vdev,
 					       bool weak_barriers,
 					       bool context,
@@ -1990,57 +1990,20 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	const char *name)
 {
 	struct vring_virtqueue_packed vring_packed = {};
-	struct vring_virtqueue *vq;
-	int err;
+	struct virtqueue *vq;
 
 	if (vring_alloc_queue_packed(&vring_packed, vdev, num))
 		goto err_ring;
 
-	vq = kmalloc(sizeof(*vq), GFP_KERNEL);
-	if (!vq)
-		goto err_vq;
-
-	vq->vq.callback = callback;
-	vq->vq.vdev = vdev;
-	vq->vq.name = name;
-	vq->vq.index = index;
-	vq->vq.reset = false;
-	vq->we_own_ring = true;
-	vq->notify = notify;
-	vq->weak_barriers = weak_barriers;
-#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
-	vq->broken = true;
-#else
-	vq->broken = false;
-#endif
-	vq->packed_ring = true;
-	vq->use_dma_api = vring_use_dma_api(vdev);
-
-	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
-		!context;
-	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
-
-	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
-		vq->weak_barriers = false;
-
-	err = vring_alloc_state_extra_packed(&vring_packed);
-	if (err)
-		goto err_state_extra;
-
-	virtqueue_vring_init_packed(&vring_packed, !!callback);
-
-	virtqueue_init(vq, num);
-	virtqueue_vring_attach_packed(vq, &vring_packed);
+	vq = __vring_new_virtqueue(index, &vring_packed, vdev, weak_barriers,
+				   context, notify, callback, name);
+	if (!vq) {
+		vring_free_packed(&vring_packed, vdev);
+		return NULL;
+	}
 
-	spin_lock(&vdev->vqs_list_lock);
-	list_add_tail(&vq->vq.list, &vdev->vqs);
-	spin_unlock(&vdev->vqs_list_lock);
-	return &vq->vq;
+	return vq;
 
-err_state_extra:
-	kfree(vq);
-err_vq:
-	vring_free_packed(&vring_packed, vdev);
 err_ring:
 	return NULL;
 }
@@ -2473,9 +2436,8 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
 }
 EXPORT_SYMBOL_GPL(vring_interrupt);
 
-/* Only available for split ring */
 static struct virtqueue *__vring_new_virtqueue(unsigned int index,
-					       struct vring_virtqueue_split *vring_split,
+					       void *vring,
 					       struct virtio_device *vdev,
 					       bool weak_barriers,
 					       bool context,
@@ -2486,20 +2448,17 @@ static struct virtqueue *__vring_new_virtqueue(unsigned int index,
 	struct vring_virtqueue *vq;
 	int err;
 
-	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
-		return NULL;
-
 	vq = kmalloc(sizeof(*vq), GFP_KERNEL);
 	if (!vq)
 		return NULL;
 
-	vq->packed_ring = false;
+	vq->packed_ring = virtio_has_feature(vdev, VIRTIO_F_RING_PACKED);
 	vq->vq.callback = callback;
 	vq->vq.vdev = vdev;
 	vq->vq.name = name;
 	vq->vq.index = index;
 	vq->vq.reset = false;
-	vq->we_own_ring = false;
+	vq->we_own_ring = vq->packed_ring;
 	vq->notify = notify;
 	vq->weak_barriers = weak_barriers;
 #ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
@@ -2516,16 +2475,24 @@ static struct virtqueue *__vring_new_virtqueue(unsigned int index,
 	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
 		vq->weak_barriers = false;
 
-	err = vring_alloc_state_extra_split(vring_split);
+	if (vq->packed_ring)
+		err = vring_alloc_state_extra_packed(vring);
+	else
+		err = vring_alloc_state_extra_split(vring);
 	if (err) {
 		kfree(vq);
 		return NULL;
 	}
 
-	virtqueue_vring_init_split(vring_split, vq);
-
-	virtqueue_init(vq, vring_split->vring.num);
-	virtqueue_vring_attach_split(vq, vring_split);
+	if (vq->packed_ring) {
+		virtqueue_vring_init_packed(vring, !!callback);
+		virtqueue_init(vq, ((struct vring_virtqueue_packed *)vring)->vring.num);
+		virtqueue_vring_attach_packed(vq, vring);
+	} else {
+		virtqueue_vring_init_split(vring, vq);
+		virtqueue_init(vq, ((struct vring_virtqueue_split *)vring)->vring.num);
+		virtqueue_vring_attach_split(vq, vring);
+	}
 
 	spin_lock(&vdev->vqs_list_lock);
 	list_add_tail(&vq->vq.list, &vdev->vqs);
-- 
2.32.0


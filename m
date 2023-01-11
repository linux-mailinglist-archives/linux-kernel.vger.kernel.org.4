Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D59665497
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 07:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235865AbjAKG3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 01:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjAKG3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 01:29:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A090631B
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 22:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673418502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=31eAQVuxvKJ8oea0yMESB6UqnKPLIwxKUoDiqCgsUL4=;
        b=MLwXPEixsPbwoyZiEqEqKoxdgkm0a/O3Eyi3c5OOae3Ml+w+aIJ19kBbbDpkbzegTmpha4
        Ver8BNAjkMSYzpYGNum7ZlVHN8PIGr5Kqw1WujU/AFHYeDW+1BOJtYvUleq76EragylXXM
        5OigcYl8ERJyjuA9Uta93WEMUQLdoto=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-330-M1UY9U5-N5O5VSVS2DHcFg-1; Wed, 11 Jan 2023 01:28:19 -0500
X-MC-Unique: M1UY9U5-N5O5VSVS2DHcFg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B52D11C0878E;
        Wed, 11 Jan 2023 06:28:18 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-175.pek2.redhat.com [10.72.13.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B69C24078903;
        Wed, 11 Jan 2023 06:28:15 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     elic@nvidia.com, gdawar@amd.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, tanuj.kamde@amd.com
Subject: [PATCH 1/5] virtio_ring: per virtqueue dma device
Date:   Wed, 11 Jan 2023 14:28:05 +0800
Message-Id: <20230111062809.25020-2-jasowang@redhat.com>
In-Reply-To: <20230111062809.25020-1-jasowang@redhat.com>
References: <20230111062809.25020-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a per virtqueue dma device. This will be used
for virtio devices whose virtqueue are backed by different underlayer
devices.

One example is the vDPA that where the control virtqueue could be
implemented through software mediation.

Some of the work are actually done before since the helper like
vring_dma_device(). This work left are:

- Let vring_dma_device() return the per virtqueue dma device instead
  of the vdev's parent.
- Allow passing a dma_device when creating the virtqueue through a new
  helper, old vring creation helper will keep using vdev's parent.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 133 ++++++++++++++++++++++++-----------
 include/linux/virtio_ring.h  |  16 +++++
 2 files changed, 109 insertions(+), 40 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 723c4e29e1d3..41144b5246a8 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -202,6 +202,9 @@ struct vring_virtqueue {
 	/* DMA, allocation, and size information */
 	bool we_own_ring;
 
+	/* Device used for doing DMA */
+	struct device *dma_dev;
+
 #ifdef DEBUG
 	/* They're supposed to lock for us. */
 	unsigned int in_use;
@@ -219,7 +222,8 @@ static struct virtqueue *__vring_new_virtqueue(unsigned int index,
 					       bool context,
 					       bool (*notify)(struct virtqueue *),
 					       void (*callback)(struct virtqueue *),
-					       const char *name);
+					       const char *name,
+					       struct device *dma_dev);
 static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int num);
 static void vring_free(struct virtqueue *_vq);
 
@@ -297,10 +301,11 @@ size_t virtio_max_dma_size(struct virtio_device *vdev)
 EXPORT_SYMBOL_GPL(virtio_max_dma_size);
 
 static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
-			      dma_addr_t *dma_handle, gfp_t flag)
+			       dma_addr_t *dma_handle, gfp_t flag,
+			       struct device *dma_dev)
 {
 	if (vring_use_dma_api(vdev)) {
-		return dma_alloc_coherent(vdev->dev.parent, size,
+		return dma_alloc_coherent(dma_dev, size,
 					  dma_handle, flag);
 	} else {
 		void *queue = alloc_pages_exact(PAGE_ALIGN(size), flag);
@@ -330,10 +335,11 @@ static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
 }
 
 static void vring_free_queue(struct virtio_device *vdev, size_t size,
-			     void *queue, dma_addr_t dma_handle)
+			     void *queue, dma_addr_t dma_handle,
+			     struct device *dma_dev)
 {
 	if (vring_use_dma_api(vdev))
-		dma_free_coherent(vdev->dev.parent, size, queue, dma_handle);
+		dma_free_coherent(dma_dev, size, queue, dma_handle);
 	else
 		free_pages_exact(queue, PAGE_ALIGN(size));
 }
@@ -341,11 +347,11 @@ static void vring_free_queue(struct virtio_device *vdev, size_t size,
 /*
  * The DMA ops on various arches are rather gnarly right now, and
  * making all of the arch DMA ops work on the vring device itself
- * is a mess.  For now, we use the parent device for DMA ops.
+ * is a mess.
  */
 static inline struct device *vring_dma_dev(const struct vring_virtqueue *vq)
 {
-	return vq->vq.vdev->dev.parent;
+	return vq->dma_dev;
 }
 
 /* Map one sg entry. */
@@ -1032,11 +1038,12 @@ static int vring_alloc_state_extra_split(struct vring_virtqueue_split *vring_spl
 }
 
 static void vring_free_split(struct vring_virtqueue_split *vring_split,
-			     struct virtio_device *vdev)
+			     struct virtio_device *vdev, struct device *dma_dev)
 {
 	vring_free_queue(vdev, vring_split->queue_size_in_bytes,
 			 vring_split->vring.desc,
-			 vring_split->queue_dma_addr);
+			 vring_split->queue_dma_addr,
+			 dma_dev);
 
 	kfree(vring_split->desc_state);
 	kfree(vring_split->desc_extra);
@@ -1046,7 +1053,8 @@ static int vring_alloc_queue_split(struct vring_virtqueue_split *vring_split,
 				   struct virtio_device *vdev,
 				   u32 num,
 				   unsigned int vring_align,
-				   bool may_reduce_num)
+				   bool may_reduce_num,
+				   struct device *dma_dev)
 {
 	void *queue = NULL;
 	dma_addr_t dma_addr;
@@ -1061,7 +1069,8 @@ static int vring_alloc_queue_split(struct vring_virtqueue_split *vring_split,
 	for (; num && vring_size(num, vring_align) > PAGE_SIZE; num /= 2) {
 		queue = vring_alloc_queue(vdev, vring_size(num, vring_align),
 					  &dma_addr,
-					  GFP_KERNEL | __GFP_NOWARN | __GFP_ZERO);
+					  GFP_KERNEL | __GFP_NOWARN | __GFP_ZERO,
+					  dma_dev);
 		if (queue)
 			break;
 		if (!may_reduce_num)
@@ -1074,7 +1083,8 @@ static int vring_alloc_queue_split(struct vring_virtqueue_split *vring_split,
 	if (!queue) {
 		/* Try to get a single page. You are my only hope! */
 		queue = vring_alloc_queue(vdev, vring_size(num, vring_align),
-					  &dma_addr, GFP_KERNEL | __GFP_ZERO);
+					  &dma_addr, GFP_KERNEL | __GFP_ZERO,
+					  dma_dev);
 	}
 	if (!queue)
 		return -ENOMEM;
@@ -1100,21 +1110,22 @@ static struct virtqueue *vring_create_virtqueue_split(
 	bool context,
 	bool (*notify)(struct virtqueue *),
 	void (*callback)(struct virtqueue *),
-	const char *name)
+	const char *name,
+	struct device *dma_dev)
 {
 	struct vring_virtqueue_split vring_split = {};
 	struct virtqueue *vq;
 	int err;
 
 	err = vring_alloc_queue_split(&vring_split, vdev, num, vring_align,
-				      may_reduce_num);
+				      may_reduce_num, dma_dev);
 	if (err)
 		return NULL;
 
 	vq = __vring_new_virtqueue(index, &vring_split, vdev, weak_barriers,
-				   context, notify, callback, name);
+				   context, notify, callback, name, dma_dev);
 	if (!vq) {
-		vring_free_split(&vring_split, vdev);
+		vring_free_split(&vring_split, vdev, dma_dev);
 		return NULL;
 	}
 
@@ -1132,7 +1143,8 @@ static int virtqueue_resize_split(struct virtqueue *_vq, u32 num)
 
 	err = vring_alloc_queue_split(&vring_split, vdev, num,
 				      vq->split.vring_align,
-				      vq->split.may_reduce_num);
+				      vq->split.may_reduce_num,
+				      vring_dma_dev(vq));
 	if (err)
 		goto err;
 
@@ -1150,7 +1162,7 @@ static int virtqueue_resize_split(struct virtqueue *_vq, u32 num)
 	return 0;
 
 err_state_extra:
-	vring_free_split(&vring_split, vdev);
+	vring_free_split(&vring_split, vdev, vring_dma_dev(vq));
 err:
 	virtqueue_reinit_split(vq);
 	return -ENOMEM;
@@ -1841,22 +1853,26 @@ static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int num)
 }
 
 static void vring_free_packed(struct vring_virtqueue_packed *vring_packed,
-			      struct virtio_device *vdev)
+			      struct virtio_device *vdev,
+			      struct device *dma_dev)
 {
 	if (vring_packed->vring.desc)
 		vring_free_queue(vdev, vring_packed->ring_size_in_bytes,
 				 vring_packed->vring.desc,
-				 vring_packed->ring_dma_addr);
+				 vring_packed->ring_dma_addr,
+				 dma_dev);
 
 	if (vring_packed->vring.driver)
 		vring_free_queue(vdev, vring_packed->event_size_in_bytes,
 				 vring_packed->vring.driver,
-				 vring_packed->driver_event_dma_addr);
+				 vring_packed->driver_event_dma_addr,
+				 dma_dev);
 
 	if (vring_packed->vring.device)
 		vring_free_queue(vdev, vring_packed->event_size_in_bytes,
 				 vring_packed->vring.device,
-				 vring_packed->device_event_dma_addr);
+				 vring_packed->device_event_dma_addr,
+				 dma_dev);
 
 	kfree(vring_packed->desc_state);
 	kfree(vring_packed->desc_extra);
@@ -1864,7 +1880,7 @@ static void vring_free_packed(struct vring_virtqueue_packed *vring_packed,
 
 static int vring_alloc_queue_packed(struct vring_virtqueue_packed *vring_packed,
 				    struct virtio_device *vdev,
-				    u32 num)
+				    u32 num, struct device *dma_dev)
 {
 	struct vring_packed_desc *ring;
 	struct vring_packed_desc_event *driver, *device;
@@ -1875,7 +1891,8 @@ static int vring_alloc_queue_packed(struct vring_virtqueue_packed *vring_packed,
 
 	ring = vring_alloc_queue(vdev, ring_size_in_bytes,
 				 &ring_dma_addr,
-				 GFP_KERNEL | __GFP_NOWARN | __GFP_ZERO);
+				 GFP_KERNEL | __GFP_NOWARN | __GFP_ZERO,
+				 dma_dev);
 	if (!ring)
 		goto err;
 
@@ -1887,7 +1904,8 @@ static int vring_alloc_queue_packed(struct vring_virtqueue_packed *vring_packed,
 
 	driver = vring_alloc_queue(vdev, event_size_in_bytes,
 				   &driver_event_dma_addr,
-				   GFP_KERNEL | __GFP_NOWARN | __GFP_ZERO);
+				   GFP_KERNEL | __GFP_NOWARN | __GFP_ZERO,
+				   dma_dev);
 	if (!driver)
 		goto err;
 
@@ -1897,7 +1915,8 @@ static int vring_alloc_queue_packed(struct vring_virtqueue_packed *vring_packed,
 
 	device = vring_alloc_queue(vdev, event_size_in_bytes,
 				   &device_event_dma_addr,
-				   GFP_KERNEL | __GFP_NOWARN | __GFP_ZERO);
+				   GFP_KERNEL | __GFP_NOWARN | __GFP_ZERO,
+				   dma_dev);
 	if (!device)
 		goto err;
 
@@ -1909,7 +1928,7 @@ static int vring_alloc_queue_packed(struct vring_virtqueue_packed *vring_packed,
 	return 0;
 
 err:
-	vring_free_packed(vring_packed, vdev);
+	vring_free_packed(vring_packed, vdev, dma_dev);
 	return -ENOMEM;
 }
 
@@ -1987,13 +2006,14 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	bool context,
 	bool (*notify)(struct virtqueue *),
 	void (*callback)(struct virtqueue *),
-	const char *name)
+	const char *name,
+	struct device *dma_dev)
 {
 	struct vring_virtqueue_packed vring_packed = {};
 	struct vring_virtqueue *vq;
 	int err;
 
-	if (vring_alloc_queue_packed(&vring_packed, vdev, num))
+	if (vring_alloc_queue_packed(&vring_packed, vdev, num, dma_dev))
 		goto err_ring;
 
 	vq = kmalloc(sizeof(*vq), GFP_KERNEL);
@@ -2014,6 +2034,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	vq->broken = false;
 #endif
 	vq->packed_ring = true;
+	vq->dma_dev = dma_dev;
 	vq->use_dma_api = vring_use_dma_api(vdev);
 
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
@@ -2040,7 +2061,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
 err_state_extra:
 	kfree(vq);
 err_vq:
-	vring_free_packed(&vring_packed, vdev);
+	vring_free_packed(&vring_packed, vdev, dma_dev);
 err_ring:
 	return NULL;
 }
@@ -2052,7 +2073,7 @@ static int virtqueue_resize_packed(struct virtqueue *_vq, u32 num)
 	struct virtio_device *vdev = _vq->vdev;
 	int err;
 
-	if (vring_alloc_queue_packed(&vring_packed, vdev, num))
+	if (vring_alloc_queue_packed(&vring_packed, vdev, num, vring_dma_dev(vq)))
 		goto err_ring;
 
 	err = vring_alloc_state_extra_packed(&vring_packed);
@@ -2069,7 +2090,7 @@ static int virtqueue_resize_packed(struct virtqueue *_vq, u32 num)
 	return 0;
 
 err_state_extra:
-	vring_free_packed(&vring_packed, vdev);
+	vring_free_packed(&vring_packed, vdev, vring_dma_dev(vq));
 err_ring:
 	virtqueue_reinit_packed(vq);
 	return -ENOMEM;
@@ -2481,7 +2502,8 @@ static struct virtqueue *__vring_new_virtqueue(unsigned int index,
 					       bool context,
 					       bool (*notify)(struct virtqueue *),
 					       void (*callback)(struct virtqueue *),
-					       const char *name)
+					       const char *name,
+					       struct device *dma_dev)
 {
 	struct vring_virtqueue *vq;
 	int err;
@@ -2507,6 +2529,7 @@ static struct virtqueue *__vring_new_virtqueue(unsigned int index,
 #else
 	vq->broken = false;
 #endif
+	vq->dma_dev = dma_dev;
 	vq->use_dma_api = vring_use_dma_api(vdev);
 
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
@@ -2549,14 +2572,39 @@ struct virtqueue *vring_create_virtqueue(
 	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
 		return vring_create_virtqueue_packed(index, num, vring_align,
 				vdev, weak_barriers, may_reduce_num,
-				context, notify, callback, name);
+				context, notify, callback, name, vdev->dev.parent);
 
 	return vring_create_virtqueue_split(index, num, vring_align,
 			vdev, weak_barriers, may_reduce_num,
-			context, notify, callback, name);
+			context, notify, callback, name, vdev->dev.parent);
 }
 EXPORT_SYMBOL_GPL(vring_create_virtqueue);
 
+struct virtqueue *vring_create_virtqueue_dma(
+	unsigned int index,
+	unsigned int num,
+	unsigned int vring_align,
+	struct virtio_device *vdev,
+	bool weak_barriers,
+	bool may_reduce_num,
+	bool context,
+	bool (*notify)(struct virtqueue *),
+	void (*callback)(struct virtqueue *),
+	const char *name,
+	struct device *dma_dev)
+{
+
+	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
+		return vring_create_virtqueue_packed(index, num, vring_align,
+				vdev, weak_barriers, may_reduce_num,
+				context, notify, callback, name, dma_dev);
+
+	return vring_create_virtqueue_split(index, num, vring_align,
+			vdev, weak_barriers, may_reduce_num,
+			context, notify, callback, name, dma_dev);
+}
+EXPORT_SYMBOL_GPL(vring_create_virtqueue_dma);
+
 /**
  * virtqueue_resize - resize the vring of vq
  * @_vq: the struct virtqueue we're talking about.
@@ -2645,7 +2693,8 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
 
 	vring_init(&vring_split.vring, num, pages, vring_align);
 	return __vring_new_virtqueue(index, &vring_split, vdev, weak_barriers,
-				     context, notify, callback, name);
+				     context, notify, callback, name,
+				     vdev->dev.parent);
 }
 EXPORT_SYMBOL_GPL(vring_new_virtqueue);
 
@@ -2658,17 +2707,20 @@ static void vring_free(struct virtqueue *_vq)
 			vring_free_queue(vq->vq.vdev,
 					 vq->packed.ring_size_in_bytes,
 					 vq->packed.vring.desc,
-					 vq->packed.ring_dma_addr);
+					 vq->packed.ring_dma_addr,
+					 vring_dma_dev(vq));
 
 			vring_free_queue(vq->vq.vdev,
 					 vq->packed.event_size_in_bytes,
 					 vq->packed.vring.driver,
-					 vq->packed.driver_event_dma_addr);
+					 vq->packed.driver_event_dma_addr,
+					 vring_dma_dev(vq));
 
 			vring_free_queue(vq->vq.vdev,
 					 vq->packed.event_size_in_bytes,
 					 vq->packed.vring.device,
-					 vq->packed.device_event_dma_addr);
+					 vq->packed.device_event_dma_addr,
+					 vring_dma_dev(vq));
 
 			kfree(vq->packed.desc_state);
 			kfree(vq->packed.desc_extra);
@@ -2676,7 +2728,8 @@ static void vring_free(struct virtqueue *_vq)
 			vring_free_queue(vq->vq.vdev,
 					 vq->split.queue_size_in_bytes,
 					 vq->split.vring.desc,
-					 vq->split.queue_dma_addr);
+					 vq->split.queue_dma_addr,
+					 vring_dma_dev(vq));
 		}
 	}
 	if (!vq->packed_ring) {
diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index 8b8af1a38991..8b95b69ef694 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -76,6 +76,22 @@ struct virtqueue *vring_create_virtqueue(unsigned int index,
 					 void (*callback)(struct virtqueue *vq),
 					 const char *name);
 
+/*
+ * Creates a virtqueue and allocates the descriptor ring with per
+ * virtqueue DMA device.
+ */
+struct virtqueue *vring_create_virtqueue_dma(unsigned int index,
+					     unsigned int num,
+					     unsigned int vring_align,
+					     struct virtio_device *vdev,
+					     bool weak_barriers,
+					     bool may_reduce_num,
+					     bool ctx,
+					     bool (*notify)(struct virtqueue *vq),
+					     void (*callback)(struct virtqueue *vq),
+					     const char *name,
+					     struct device *dma_dev);
+
 /*
  * Creates a virtqueue with a standard layout but a caller-allocated
  * ring.
-- 
2.25.1


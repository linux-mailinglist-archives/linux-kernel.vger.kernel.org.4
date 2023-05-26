Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE400712001
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 08:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242213AbjEZGbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 02:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236693AbjEZGbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 02:31:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B403613D
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 23:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685082649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=EK+N0y/1dvECEUhDxhcais8MqSvPEEely1X6QH3wgtQ=;
        b=VinLVZmTnmi3+izXjUgCMVkXhdEwZ4nrQVtRq0meu+bN4teD6Cgvmczuq4fqkJ77a1nwAB
        b+p/a2j5G+WY93p+4glGS/KXUR8usU7+uUtSJupKClbezMGTf679Ow3jpAWNVL/IGn+YqE
        /+CM0fYaIzp7VsMvd7QkLh44h4R0iF0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-569-3AQUEFLvM7Gx97Hqrv2koQ-1; Fri, 26 May 2023 02:30:46 -0400
X-MC-Unique: 3AQUEFLvM7Gx97Hqrv2koQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 19BA280120A;
        Fri, 26 May 2023 06:30:46 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-104.pek2.redhat.com [10.72.13.104])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9415B2166B2B;
        Fri, 26 May 2023 06:30:43 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] virtio_ring: validate used buffer length
Date:   Fri, 26 May 2023 14:30:41 +0800
Message-Id: <20230526063041.18359-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch validate the used buffer length provided by the device
before trying to use it. This is done by remembering the in buffer
length in a dedicated array during virtqueue_add(), then we can fail
the virtqueue_get_buf() when we find the device is trying to give us a
used buffer length which is greater than we stored before.

This validation is disable by default via module parameter to unbreak
some existing devices since some legacy devices are known to report
buggy used length.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
Changes since V4:
- drop the flat for driver to suppress the check
- validation is disabled by default
- don't do validation for legacy device
- rebase and support virtqueue resize
---
 drivers/virtio/virtio_ring.c | 75 ++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 143f380baa1c..5b151605aaf8 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -15,6 +15,9 @@
 #include <linux/spinlock.h>
 #include <xen/xen.h>
 
+static bool force_used_validation = false;
+module_param(force_used_validation, bool, 0444);
+
 #ifdef DEBUG
 /* For development, we want to crash whenever the ring is screwed. */
 #define BAD_RING(_vq, fmt, args...)				\
@@ -105,6 +108,9 @@ struct vring_virtqueue_split {
 	struct vring_desc_state_split *desc_state;
 	struct vring_desc_extra *desc_extra;
 
+	/* Maximum in buffer length, NULL means no used validation */
+	u32 *buflen;
+
 	/* DMA address and size information */
 	dma_addr_t queue_dma_addr;
 	size_t queue_size_in_bytes;
@@ -145,6 +151,9 @@ struct vring_virtqueue_packed {
 	struct vring_desc_state_packed *desc_state;
 	struct vring_desc_extra *desc_extra;
 
+	/* Maximum in buffer length, NULL means no used validation */
+	u32 *buflen;
+
 	/* DMA address and size information */
 	dma_addr_t ring_dma_addr;
 	dma_addr_t driver_event_dma_addr;
@@ -552,6 +561,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	unsigned int i, n, avail, descs_used, prev, err_idx;
 	int head;
 	bool indirect;
+	u32 buflen = 0;
 
 	START_USE(vq);
 
@@ -635,6 +645,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 						     VRING_DESC_F_NEXT |
 						     VRING_DESC_F_WRITE,
 						     indirect);
+			buflen += sg->length;
 		}
 	}
 	/* Last one doesn't continue. */
@@ -675,6 +686,10 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	else
 		vq->split.desc_state[head].indir_desc = ctx;
 
+	/* Store in buffer length if necessary */
+	if (vq->split.buflen)
+		vq->split.buflen[head] = buflen;
+
 	/* Put entry in available array (but don't update avail->idx until they
 	 * do sync). */
 	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
@@ -861,6 +876,11 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
 		BAD_RING(vq, "id %u is not a head!\n", i);
 		return NULL;
 	}
+	if (vq->split.buflen && unlikely(*len > vq->split.buflen[i])) {
+		BAD_RING(vq, "used len %d is larger than max in buffer len %u\n",
+			*len, vq->split.buflen[i]);
+		return NULL;
+	}
 
 	/* detach_buf_split clears data, so grab it now. */
 	ret = vq->split.desc_state[i].data;
@@ -1085,10 +1105,25 @@ static void vring_free_split(struct vring_virtqueue_split *vring_split,
 			 vring_split->queue_dma_addr,
 			 dma_dev);
 
+	kfree(vring_split->buflen);
 	kfree(vring_split->desc_state);
 	kfree(vring_split->desc_extra);
 }
 
+static bool vring_needs_used_validation(const struct virtio_device *vdev)
+{
+	/*
+	 * Several legacy devices are known to produce buggy used
+	 * length. In order to let driver work, we won't validate used
+	 * buffer length in this case.
+	 */
+	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
+		return false;
+	if (force_used_validation)
+		return true;
+	return false;
+}
+
 static int vring_alloc_queue_split(struct vring_virtqueue_split *vring_split,
 				   struct virtio_device *vdev,
 				   u32 num,
@@ -1137,7 +1172,19 @@ static int vring_alloc_queue_split(struct vring_virtqueue_split *vring_split,
 	vring_split->vring_align = vring_align;
 	vring_split->may_reduce_num = may_reduce_num;
 
+	if (vring_needs_used_validation(vdev)) {
+		vring_split->buflen =
+			kmalloc_array(num, sizeof(*vring_split->buflen),
+				      GFP_KERNEL);
+		if (!vring_split->buflen)
+			goto err_buflen;
+	}
+
 	return 0;
+
+err_buflen:
+	vring_free_split(vring_split, vdev, dma_dev);
+	return -ENOMEM;
 }
 
 static struct virtqueue *vring_create_virtqueue_split(
@@ -1297,6 +1344,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	unsigned int i, n, err_idx;
 	u16 head, id;
 	dma_addr_t addr;
+	u32 buflen = 0;
 
 	head = vq->packed.next_avail_idx;
 	desc = alloc_indirect_packed(total_sg, gfp);
@@ -1325,6 +1373,8 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 			desc[i].addr = cpu_to_le64(addr);
 			desc[i].len = cpu_to_le32(sg->length);
 			i++;
+			if (n >= out_sgs)
+				buflen += sg->length;
 		}
 	}
 
@@ -1379,6 +1429,10 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	vq->packed.desc_state[id].last = id;
 	vq->packed.desc_state[id].premapped = premapped;
 
+	/* Store in buffer length if necessary */
+	if (vq->packed.buflen)
+		vq->packed.buflen[id] = buflen;
+
 	vq->num_added += 1;
 
 	pr_debug("Added buffer head %i to %p\n", head, vq);
@@ -1416,6 +1470,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	__le16 head_flags, flags;
 	u16 head, id, prev, curr, avail_used_flags;
 	int err;
+	u32 buflen = 0;
 
 	START_USE(vq);
 
@@ -1498,6 +1553,8 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 					1 << VRING_PACKED_DESC_F_AVAIL |
 					1 << VRING_PACKED_DESC_F_USED;
 			}
+			if (n >= out_sgs)
+				buflen += sg->length;
 		}
 	}
 
@@ -1518,6 +1575,10 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	vq->packed.desc_state[id].last = prev;
 	vq->packed.desc_state[id].premapped = premapped;
 
+	/* Store in buffer length if necessary */
+	if (vq->packed.buflen)
+		vq->packed.buflen[id] = buflen;
+
 	/*
 	 * A driver MUST NOT make the first descriptor in the list
 	 * available before all subsequent descriptors comprising
@@ -1718,6 +1779,11 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
 		BAD_RING(vq, "id %u is not a head!\n", id);
 		return NULL;
 	}
+	if (vq->packed.buflen && unlikely(*len > vq->packed.buflen[id])) {
+		BAD_RING(vq, "used len %d is larger than max in buffer len %u\n",
+			*len, vq->packed.buflen[id]);
+		return NULL;
+	}
 
 	/* detach_buf_packed clears data, so grab it now. */
 	ret = vq->packed.desc_state[id].data;
@@ -1937,6 +2003,7 @@ static void vring_free_packed(struct vring_virtqueue_packed *vring_packed,
 				 vring_packed->device_event_dma_addr,
 				 dma_dev);
 
+	kfree(vring_packed->buflen);
 	kfree(vring_packed->desc_state);
 	kfree(vring_packed->desc_extra);
 }
@@ -1988,6 +2055,14 @@ static int vring_alloc_queue_packed(struct vring_virtqueue_packed *vring_packed,
 
 	vring_packed->vring.num = num;
 
+	if (vring_needs_used_validation(vdev)) {
+		vring_packed->buflen =
+			kmalloc_array(num, sizeof(*vring_packed->buflen),
+				      GFP_KERNEL);
+		if (!vring_packed->buflen)
+			goto err;
+	}
+
 	return 0;
 
 err:
-- 
2.25.1


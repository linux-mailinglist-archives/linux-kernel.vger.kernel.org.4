Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0256C114F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 12:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjCTL4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 07:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjCTL4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 07:56:47 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C3B241D3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 04:56:44 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id k37so1600737lfv.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 04:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112; t=1679313402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5WnSpd3VjsTbvqmg4BcKQ/9NURcg/rAIqLX+pwVi5FI=;
        b=sMX/yAzahLvSZ2O7ssNj+wjXOD9WO5l+DuNliL+EhQAmP/YIvRNGdWdqJCMItb1vss
         bpJIcpXCLdLd2ZIWKfrjXOL3YTdQHD4NM2+HqMuxrtyGXlmxMe9SUq+dXNteUJ31B0xs
         k9kSqnmV9MGJMKjP1bMZQL+X6F7m6FpFZYVR6UTGmsmZsNZACubjWQiDA63pMwJHe2XN
         7JBO9a8Jv1UerSYBCS5/Tuto6hlpIqs9bj5iRMDDIGT9aMGQvCFMrHuEtHtFnXT2Jmux
         KnTdaOOMJ6gq5WcUCm3/9+vYtOiJwBni1V0YNy14IPXYpfX+5KREWyXtAQQw8nvvpy6k
         0ySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679313402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5WnSpd3VjsTbvqmg4BcKQ/9NURcg/rAIqLX+pwVi5FI=;
        b=zUeQsBhiRvhJzkv9Wjrb3EVS4Or1oFHDfdO+7JCoItFjRGizl/tlquniUjlIkMqL1S
         0Oi63x8Jq2f0N9zNpNDF9ig9k4axRKcSiKCOyR600mVlvJwzqU85bRS/BhVsvzbys0hL
         cqamp3aanq3eX1Q/WXXNfazMwXfvg+ZXfB5ZN1f3B5rNdExDkkkDnlZmSaiUml6lJVWG
         50DYhhywQwreoHUOAJlmGpWcmX9zzJ88HHmKU3VOJcLY0eX8RvkrdJTStW/2NHFt2yRh
         mLS+x32aAG9Qd5hQgW2Nem7mGl2tU+eDHY3wqIoVg8CzJx/RG4Bf+gAlV4k8cjp9TFKp
         Y4Vg==
X-Gm-Message-State: AO0yUKWLQ6bwYL3Ax55Fwj892lbgBP//DRKWdbGiRtAWnktnN4bYCOKo
        wSj67lHj7nx7y/z5g7QvQyyWIXR5TaPovpEu/n4z2g==
X-Google-Smtp-Source: AK7set+uol6QXCpUJGg+606D4BmiExi6ejKvFgAF2wx4JM478RT93ChjtVBqpMxFAYSup+7ZQnS9pQ==
X-Received: by 2002:a05:6512:92e:b0:4dd:b766:37ae with SMTP id f14-20020a056512092e00b004ddb76637aemr5689585lft.13.1679313401967;
        Mon, 20 Mar 2023 04:56:41 -0700 (PDT)
Received: from vp-pc.. (109-252-122-203.nat.spd-mgts.ru. [109.252.122.203])
        by smtp.gmail.com with ESMTPSA id y26-20020a05651c021a00b0029571d505a1sm1720217ljn.80.2023.03.20.04.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 04:56:41 -0700 (PDT)
From:   Viktor Prutyanov <viktor@daynix.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, yan@daynix.com, viktor@daynix.com
Subject: [PATCH] virtio: add VIRTIO_F_NOTIFICATION_DATA feature support
Date:   Mon, 20 Mar 2023 14:54:51 +0300
Message-Id: <20230320115451.1232171-1-viktor@daynix.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to VirtIO spec v1.2, VIRTIO_F_NOTIFICATION_DATA feature
indicates that the driver passes extra data along with the queue
notifications.

In a split queue case, the extra data is 16-bit available index. In a
packed queue case, the extra data is 1-bit wrap counter and 15-bit
available index.

Add support for this feature for both MMIO and PCI.

Signed-off-by: Viktor Prutyanov <viktor@daynix.com>
---
 drivers/virtio/virtio_mmio.c       | 15 ++++++++++++++-
 drivers/virtio/virtio_pci_common.c | 10 ++++++++++
 drivers/virtio/virtio_pci_common.h |  4 ++++
 drivers/virtio/virtio_pci_legacy.c |  2 +-
 drivers/virtio/virtio_pci_modern.c |  2 +-
 drivers/virtio/virtio_ring.c       | 17 +++++++++++++++++
 include/linux/virtio_ring.h        |  2 ++
 include/uapi/linux/virtio_config.h |  6 ++++++
 8 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 3ff746e3f24a..05da5ad7fc93 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -285,6 +285,19 @@ static bool vm_notify(struct virtqueue *vq)
 	return true;
 }
 
+static bool vm_notify_with_data(struct virtqueue *vq)
+{
+	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vq->vdev);
+	__le32 data = vring_fill_notification_data(vq);
+
+	writel(data, vm_dev->base + VIRTIO_MMIO_QUEUE_NOTIFY);
+
+	return true;
+}
+
+#define VM_NOTIFY(vdev) (__virtio_test_bit((vdev), VIRTIO_F_NOTIFICATION_DATA) \
+	? vm_notify_with_data : vm_notify)
+
 /* Notify all virtqueues on an interrupt. */
 static irqreturn_t vm_interrupt(int irq, void *opaque)
 {
@@ -397,7 +410,7 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned int in
 
 	/* Create the vring */
 	vq = vring_create_virtqueue(index, num, VIRTIO_MMIO_VRING_ALIGN, vdev,
-				 true, true, ctx, vm_notify, callback, name);
+			true, true, ctx, VM_NOTIFY(vdev), callback, name);
 	if (!vq) {
 		err = -ENOMEM;
 		goto error_new_virtqueue;
diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index a6c86f916dbd..bf7daad9ce65 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -43,6 +43,16 @@ bool vp_notify(struct virtqueue *vq)
 	/* we write the queue's selector into the notification register to
 	 * signal the other end */
 	iowrite16(vq->index, (void __iomem *)vq->priv);
+
+	return true;
+}
+
+bool vp_notify_with_data(struct virtqueue *vq)
+{
+	__le32 data = vring_fill_notification_data(vq);
+
+	iowrite32(data, (void __iomem *)vq->priv);
+
 	return true;
 }
 
diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index 23112d84218f..9a7212dcbb32 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -105,6 +105,7 @@ static struct virtio_pci_device *to_vp_device(struct virtio_device *vdev)
 void vp_synchronize_vectors(struct virtio_device *vdev);
 /* the notify function used when creating a virt queue */
 bool vp_notify(struct virtqueue *vq);
+bool vp_notify_with_data(struct virtqueue *vq);
 /* the config->del_vqs() implementation */
 void vp_del_vqs(struct virtio_device *vdev);
 /* the config->find_vqs() implementation */
@@ -114,6 +115,9 @@ int vp_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 		struct irq_affinity *desc);
 const char *vp_bus_name(struct virtio_device *vdev);
 
+#define VP_NOTIFY(vdev) (__virtio_test_bit((vdev), VIRTIO_F_NOTIFICATION_DATA) \
+	? vp_notify : vp_notify_with_data)
+
 /* Setup the affinity for a virtqueue:
  * - force the affinity for per vq vector
  * - OR over all affinities for shared MSI
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index 2257f1b3d8ae..b98e994cae48 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -131,7 +131,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	vq = vring_create_virtqueue(index, num,
 				    VIRTIO_PCI_VRING_ALIGN, &vp_dev->vdev,
 				    true, false, ctx,
-				    vp_notify, callback, name);
+				    VP_NOTIFY(&vp_dev->vdev), callback, name);
 	if (!vq)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 9e496e288cfa..7fcd8af5af7e 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -321,7 +321,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	vq = vring_create_virtqueue(index, num,
 				    SMP_CACHE_BYTES, &vp_dev->vdev,
 				    true, true, ctx,
-				    vp_notify, callback, name);
+				    VP_NOTIFY(&vp_dev->vdev), callback, name);
 	if (!vq)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 41144b5246a8..8de0800efee7 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2752,6 +2752,21 @@ void vring_del_virtqueue(struct virtqueue *_vq)
 }
 EXPORT_SYMBOL_GPL(vring_del_virtqueue);
 
+__le32 vring_fill_notification_data(struct virtqueue *_vq)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+	u16 next;
+
+	if (vq->packed_ring)
+		next = (vq->packed.next_avail_idx & ~(1 << 15)) |
+			((u16)vq->packed.avail_wrap_counter << 15);
+	else
+		next = virtio16_to_cpu(_vq->vdev, vq->split.vring.avail->idx);
+
+	return cpu_to_le32(((u32)next << 16) | _vq->index);
+}
+EXPORT_SYMBOL_GPL(vring_fill_notification_data);
+
 /* Manipulates transport-specific feature bits. */
 void vring_transport_features(struct virtio_device *vdev)
 {
@@ -2771,6 +2786,8 @@ void vring_transport_features(struct virtio_device *vdev)
 			break;
 		case VIRTIO_F_ORDER_PLATFORM:
 			break;
+		case VIRTIO_F_NOTIFICATION_DATA:
+			break;
 		default:
 			/* We don't understand this bit. */
 			__virtio_clear_bit(vdev, i);
diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index 8b95b69ef694..3222324fb244 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -117,4 +117,6 @@ void vring_del_virtqueue(struct virtqueue *vq);
 void vring_transport_features(struct virtio_device *vdev);
 
 irqreturn_t vring_interrupt(int irq, void *_vq);
+
+__le32 vring_fill_notification_data(struct virtqueue *_vq);
 #endif /* _LINUX_VIRTIO_RING_H */
diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
index 3c05162bc988..2c712c654165 100644
--- a/include/uapi/linux/virtio_config.h
+++ b/include/uapi/linux/virtio_config.h
@@ -99,6 +99,12 @@
  */
 #define VIRTIO_F_SR_IOV			37
 
+/*
+ * This feature indicates that the driver passes extra data (besides
+ * identifying the virtqueue) in its device notifications.
+ */
+#define VIRTIO_F_NOTIFICATION_DATA	38
+
 /*
  * This feature indicates that the driver can reset a queue individually.
  */
-- 
2.35.1


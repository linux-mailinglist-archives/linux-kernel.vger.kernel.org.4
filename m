Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCDA06C3634
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbjCUPtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbjCUPtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:49:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A059B515E1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679413696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/o0veKHzKEYhUDBvRKAwkdEIIqv4zRPguQPr09zvNuk=;
        b=FB5wBBc5wXL9DINANjaTS8Dsa1++EEmgBfuOnJ1EdYBlsTEyPUvXDR04DZV5DjBBKLRA19
        6suowvFzA3w8o/qe5NtW5llzbiY47iody07g5LNClHi6BKXSXhYEpzZG44dAswcjKKdA1q
        /ihx3z5IV1giGAqJRxaHc4iH7ZwXTJU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-xRRmjqSUOzu6JeKKoryNsA-1; Tue, 21 Mar 2023 11:48:12 -0400
X-MC-Unique: xRRmjqSUOzu6JeKKoryNsA-1
Received: by mail-wr1-f70.google.com with SMTP id o5-20020adf8b85000000b002d58b4b7698so791722wra.19
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:48:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679413691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/o0veKHzKEYhUDBvRKAwkdEIIqv4zRPguQPr09zvNuk=;
        b=pHBVhSKHJVd/QM9WTFSo9mAa1VrMtKnfxK2xl9DJBKQXi8i12aGpAP9Gy3L/x0+JzC
         L6poA2q4aDhWjlyBsHJOFtHnNFVCkz6z7QLkNBxfPp5NHWt1LV8dNYuYbXyKpQhmq9XK
         D1weU5nNpreoo9KouyLidaUpQVTKvtpVMiAPsGP7i8Mijz4vtf5gypcMsPZRFGgEz32W
         iJWD5h9YvOPf070VHhXh/qDKm37RT6EX8/ogKVCWcu775oTbCMfBImn7riqXx/WEX3v0
         XULZEysarwIopRO2dTGrAtiX+gelGbNAaeZeCES/gBujyhg4J9gH0KvZNfDoqdrByZHO
         +XhA==
X-Gm-Message-State: AO0yUKUyE8cHEdwexCPsM2f9KPRz45vySyqTZkNsWmbJ6AUgNUZMAP90
        b5/mflbCWeEQqr5L9O+2O/sUVfO10vqY6FmFoXW/RucfOP3rYiMmnudXtIh7lkZ1oaL1wOQlXEG
        fV1aZDG8k99uyNHqQaCIA2AU7
X-Received: by 2002:a05:600c:220f:b0:3ed:9a09:183 with SMTP id z15-20020a05600c220f00b003ed9a090183mr2740473wml.2.1679413691499;
        Tue, 21 Mar 2023 08:48:11 -0700 (PDT)
X-Google-Smtp-Source: AK7set8YqhxDQpfS5NR1dT1A4CL5lP3K67FStlVUCkHzTbHZ4OmA894kPfK+s68ggo7GZKyrCyBFCQ==
X-Received: by 2002:a05:600c:220f:b0:3ed:9a09:183 with SMTP id z15-20020a05600c220f00b003ed9a090183mr2740463wml.2.1679413691320;
        Tue, 21 Mar 2023 08:48:11 -0700 (PDT)
Received: from step1.redhat.com (host-82-57-51-170.retail.telecomitalia.it. [82.57.51.170])
        by smtp.gmail.com with ESMTPSA id z15-20020a5d44cf000000b002ce9f0e4a8fsm11692694wrr.84.2023.03.21.08.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 08:48:10 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        stefanha@redhat.com, linux-kernel@vger.kernel.org,
        eperezma@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
        Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>,
        netdev@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v3 7/8] vdpa_sim: replace the spinlock with a mutex to protect the state
Date:   Tue, 21 Mar 2023 16:48:03 +0100
Message-Id: <20230321154804.184577-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230321154804.184577-1-sgarzare@redhat.com>
References: <20230321154228.182769-1-sgarzare@redhat.com>
 <20230321154804.184577-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The spinlock we use to protect the state of the simulator is sometimes
held for a long time (for example, when devices handle requests).

This also prevents us from calling functions that might sleep (such as
kthread_flush_work() in the next patch), and thus having to release
and retake the lock.

For these reasons, let's replace the spinlock with a mutex that gives
us more flexibility.

Suggested-by: Jason Wang <jasowang@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.h     |  4 ++--
 drivers/vdpa/vdpa_sim/vdpa_sim.c     | 34 ++++++++++++++--------------
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  4 ++--
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  4 ++--
 4 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
index ce83f9130a5d..4774292fba8c 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
@@ -60,8 +60,8 @@ struct vdpasim {
 	struct kthread_worker *worker;
 	struct kthread_work work;
 	struct vdpasim_dev_attr dev_attr;
-	/* spinlock to synchronize virtqueue state */
-	spinlock_t lock;
+	/* mutex to synchronize virtqueue state */
+	struct mutex mutex;
 	/* virtio config according to device type */
 	void *config;
 	struct vhost_iotlb *iommu;
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 1cfa56c52e5a..ab4cfb82c237 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -178,7 +178,7 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
 	if (IS_ERR(vdpasim->worker))
 		goto err_iommu;
 
-	spin_lock_init(&vdpasim->lock);
+	mutex_init(&vdpasim->mutex);
 	spin_lock_init(&vdpasim->iommu_lock);
 
 	dev->dma_mask = &dev->coherent_dma_mask;
@@ -286,13 +286,13 @@ static void vdpasim_set_vq_ready(struct vdpa_device *vdpa, u16 idx, bool ready)
 	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
 	bool old_ready;
 
-	spin_lock(&vdpasim->lock);
+	mutex_lock(&vdpasim->mutex);
 	old_ready = vq->ready;
 	vq->ready = ready;
 	if (vq->ready && !old_ready) {
 		vdpasim_queue_ready(vdpasim, idx);
 	}
-	spin_unlock(&vdpasim->lock);
+	mutex_unlock(&vdpasim->mutex);
 }
 
 static bool vdpasim_get_vq_ready(struct vdpa_device *vdpa, u16 idx)
@@ -310,9 +310,9 @@ static int vdpasim_set_vq_state(struct vdpa_device *vdpa, u16 idx,
 	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
 	struct vringh *vrh = &vq->vring;
 
-	spin_lock(&vdpasim->lock);
+	mutex_lock(&vdpasim->mutex);
 	vrh->last_avail_idx = state->split.avail_index;
-	spin_unlock(&vdpasim->lock);
+	mutex_unlock(&vdpasim->mutex);
 
 	return 0;
 }
@@ -409,9 +409,9 @@ static u8 vdpasim_get_status(struct vdpa_device *vdpa)
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 	u8 status;
 
-	spin_lock(&vdpasim->lock);
+	mutex_lock(&vdpasim->mutex);
 	status = vdpasim->status;
-	spin_unlock(&vdpasim->lock);
+	mutex_unlock(&vdpasim->mutex);
 
 	return status;
 }
@@ -420,19 +420,19 @@ static void vdpasim_set_status(struct vdpa_device *vdpa, u8 status)
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 
-	spin_lock(&vdpasim->lock);
+	mutex_lock(&vdpasim->mutex);
 	vdpasim->status = status;
-	spin_unlock(&vdpasim->lock);
+	mutex_unlock(&vdpasim->mutex);
 }
 
 static int vdpasim_reset(struct vdpa_device *vdpa)
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 
-	spin_lock(&vdpasim->lock);
+	mutex_lock(&vdpasim->mutex);
 	vdpasim->status = 0;
 	vdpasim_do_reset(vdpasim);
-	spin_unlock(&vdpasim->lock);
+	mutex_unlock(&vdpasim->mutex);
 
 	return 0;
 }
@@ -441,9 +441,9 @@ static int vdpasim_suspend(struct vdpa_device *vdpa)
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 
-	spin_lock(&vdpasim->lock);
+	mutex_lock(&vdpasim->mutex);
 	vdpasim->running = false;
-	spin_unlock(&vdpasim->lock);
+	mutex_unlock(&vdpasim->mutex);
 
 	return 0;
 }
@@ -453,7 +453,7 @@ static int vdpasim_resume(struct vdpa_device *vdpa)
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 	int i;
 
-	spin_lock(&vdpasim->lock);
+	mutex_lock(&vdpasim->mutex);
 	vdpasim->running = true;
 
 	if (vdpasim->pending_kick) {
@@ -464,7 +464,7 @@ static int vdpasim_resume(struct vdpa_device *vdpa)
 		vdpasim->pending_kick = false;
 	}
 
-	spin_unlock(&vdpasim->lock);
+	mutex_unlock(&vdpasim->mutex);
 
 	return 0;
 }
@@ -536,14 +536,14 @@ static int vdpasim_set_group_asid(struct vdpa_device *vdpa, unsigned int group,
 
 	iommu = &vdpasim->iommu[asid];
 
-	spin_lock(&vdpasim->lock);
+	mutex_lock(&vdpasim->mutex);
 
 	for (i = 0; i < vdpasim->dev_attr.nvqs; i++)
 		if (vdpasim_get_vq_group(vdpa, i) == group)
 			vringh_set_iotlb(&vdpasim->vqs[i].vring, iommu,
 					 &vdpasim->iommu_lock);
 
-	spin_unlock(&vdpasim->lock);
+	mutex_unlock(&vdpasim->mutex);
 
 	return 0;
 }
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index eb4897c8541e..568119e1553f 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -290,7 +290,7 @@ static void vdpasim_blk_work(struct vdpasim *vdpasim)
 	bool reschedule = false;
 	int i;
 
-	spin_lock(&vdpasim->lock);
+	mutex_lock(&vdpasim->mutex);
 
 	if (!(vdpasim->status & VIRTIO_CONFIG_S_DRIVER_OK))
 		goto out;
@@ -321,7 +321,7 @@ static void vdpasim_blk_work(struct vdpasim *vdpasim)
 		}
 	}
 out:
-	spin_unlock(&vdpasim->lock);
+	mutex_unlock(&vdpasim->mutex);
 
 	if (reschedule)
 		vdpasim_schedule_work(vdpasim);
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index e61a9ecbfafe..7ab434592bfe 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
@@ -201,7 +201,7 @@ static void vdpasim_net_work(struct vdpasim *vdpasim)
 	u64 rx_drops = 0, rx_overruns = 0, rx_errors = 0, tx_errors = 0;
 	int err;
 
-	spin_lock(&vdpasim->lock);
+	mutex_lock(&vdpasim->mutex);
 
 	if (!vdpasim->running)
 		goto out;
@@ -264,7 +264,7 @@ static void vdpasim_net_work(struct vdpasim *vdpasim)
 	}
 
 out:
-	spin_unlock(&vdpasim->lock);
+	mutex_unlock(&vdpasim->mutex);
 
 	u64_stats_update_begin(&net->tx_stats.syncp);
 	net->tx_stats.pkts += tx_pkts;
-- 
2.39.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033E6682FEB
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 15:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbjAaO5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 09:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbjAaO5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 09:57:24 -0500
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B645086E;
        Tue, 31 Jan 2023 06:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazon201209;
  t=1675177028; x=1706713028;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hTGzKjKLR+1i+6AZV7bbmkFd0Y5JGLoViaPoINjCG8c=;
  b=X5pwSKjTFjrtNJuMaYW+D6Kxog4xce/gXrUWevPNMWeCE0maOi9u+zbE
   fJU19gSRCV36/gWCBdBJBXnE4nmvQ5TjHTcQin2YGHOeT1h+RGTexPYZ/
   BoWETJzH3iOtXfc/E7S52baaQwV289tZbarakTeWozL/PSuena8ei/4IO
   o=;
X-IronPort-AV: E=Sophos;i="5.97,261,1669075200"; 
   d="scan'208";a="288177045"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-26a610d2.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 14:57:04 +0000
Received: from EX13D41EUB003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2b-m6i4x-26a610d2.us-west-2.amazon.com (Postfix) with ESMTPS id 98B6441F61;
        Tue, 31 Jan 2023 14:57:01 +0000 (UTC)
Received: from EX19D037EUB003.ant.amazon.com (10.252.61.119) by
 EX13D41EUB003.ant.amazon.com (10.43.166.252) with Microsoft SMTP Server (TLS)
 id 15.0.1497.45; Tue, 31 Jan 2023 14:57:00 +0000
Received: from f4d4887fdcfb.ant.amazon.com (10.43.161.198) by
 EX19D037EUB003.ant.amazon.com (10.252.61.119) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.24; Tue, 31 Jan 2023 14:56:55 +0000
From:   Babis Chalios <bchalios@amazon.es>
To:     Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Jason Wang" <jasowang@redhat.com>,
        Babis Chalios <bchalios@amazon.es>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
CC:     <sgarzare@redhat.com>, <amit@kernel.org>, <graf@amazon.de>,
        <Jason@zx2c4.com>, <xmarcalx@amazon.co.uk>
Subject: [PATCH v2 1/2] virtio-rng: implement entropy leak feature
Date:   Tue, 31 Jan 2023 15:55:42 +0100
Message-ID: <20230131145543.86369-2-bchalios@amazon.es>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230131145543.86369-1-bchalios@amazon.es>
References: <20230131145543.86369-1-bchalios@amazon.es>
MIME-Version: 1.0
X-Originating-IP: [10.43.161.198]
X-ClientProxiedBy: EX13D39UWB001.ant.amazon.com (10.43.161.5) To
 EX19D037EUB003.ant.amazon.com (10.252.61.119)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the virtio-rng feature that allows a guest driver to request
from the device to perform certain operations in the event of an
"entropy leak", such as when taking a VM snapshot or restoring a VM from
a snapshot. The guest can request one of two operations: (i) fill a
buffer with random bytes, or (ii) perform a memory copy between two
bytes.

The feature is similar to Microsoft's Virtual Machine Generation ID and
it can be used to (1) avoid the race-condition that exists in our
current VMGENID implementation, between the time vcpus are resumed and
the ACPI notification is being handled and (2) provide mechanisms for
notifying user-space about snapshot-related events.

This commit implements the protocol between guest and device.
Additionally, it makes sure there is always a request for random bytes
in the event of entropy leak in-flight. Once such an event is observed,
the driver feeds these bytes to as entropy using
`add_device_randomness`.

Keep in mind that this commit does not solve the race-condition issue,
it adds fresh entropy whenever the driver handles the used buffer from
the fill-on-leak request. In order to close the race window, we need to
expose some API so that other kernel subsystems can request directly
notifications from the device.

Signed-off-by: Babis Chalios <bchalios@amazon.es>
---
 drivers/char/hw_random/virtio-rng.c | 200 +++++++++++++++++++++++++++-
 include/uapi/linux/virtio_rng.h     |   3 +
 2 files changed, 196 insertions(+), 7 deletions(-)

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index a6f3a8a2aca6..154f68a1e326 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -4,12 +4,12 @@
  *  Copyright (C) 2007, 2008 Rusty Russell IBM Corporation
  */
 
-#include <linux/err.h>
 #include <linux/hw_random.h>
 #include <linux/scatterlist.h>
 #include <linux/spinlock.h>
 #include <linux/virtio.h>
 #include <linux/virtio_rng.h>
+#include <linux/random.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 
@@ -18,6 +18,12 @@ static DEFINE_IDA(rng_index_ida);
 struct virtrng_info {
 	struct hwrng hwrng;
 	struct virtqueue *vq;
+	/* Leak queues */
+	bool has_leakqs;
+	struct virtqueue *leakq[2];
+	spinlock_t lock;
+	int active_leakq;
+
 	char name[25];
 	int index;
 	bool hwrng_register_done;
@@ -29,27 +35,159 @@ struct virtrng_info {
 	/* minimal size returned by rng_buffer_size() */
 #if SMP_CACHE_BYTES < 32
 	u8 data[32];
+	u8 leak_data[32];
 #else
 	u8 data[SMP_CACHE_BYTES];
+	u8 leak_data[SMP_CACHE_BYTES];
 #endif
 };
 
+/* Swaps the queues and returns the new active leak queue. */
+static struct virtqueue *swap_leakqs(struct virtrng_info *vi)
+{
+	vi->active_leakq = 1 - vi->active_leakq;
+	return vi->leakq[vi->active_leakq];
+}
+
+static struct virtqueue *get_active_leakq(struct virtrng_info *vi)
+{
+	return vi->leakq[vi->active_leakq];
+}
+
+static int add_fill_on_leak_request(struct virtrng_info *vi, struct virtqueue *vq, void *data, size_t len)
+{
+	struct scatterlist sg;
+	int ret;
+
+	sg_init_one(&sg, data, len);
+	ret = virtqueue_add_inbuf(vq, &sg, 1, data, GFP_KERNEL);
+	if (ret)
+		goto err;
+
+err:
+	return ret;
+}
+
+static int virtrng_fill_on_leak(struct virtrng_info *vi, void *data, size_t len)
+{
+	struct virtqueue *vq;
+	unsigned long flags;
+	int ret;
+
+	if (!vi->has_leakqs)
+		return -EOPNOTSUPP;
+
+	spin_lock_irqsave(&vi->lock, flags);
+
+	vq = get_active_leakq(vi);
+	ret = add_fill_on_leak_request(vi, vq, data, len);
+	if (ret)
+		virtqueue_kick(vq);
+
+	spin_unlock_irqrestore(&vi->lock, flags);
+
+	return ret;
+}
+
+static int add_copy_on_leak_request(struct virtrng_info *vi, struct virtqueue *vq,
+		void *to, void *from, size_t len)
+{
+	int ret;
+	struct scatterlist out, in, *sgs[2];
+
+	sg_init_one(&out, from, len);
+	sgs[0] = &out;
+	sg_init_one(&in, to, len);
+	sgs[1] = &in;
+
+	ret = virtqueue_add_sgs(vq, sgs, 1, 1, to, GFP_KERNEL);
+	if (ret)
+		goto err;
+
+err:
+	return ret;
+}
+
+static int virtrng_copy_on_leak(struct virtrng_info *vi, void *to, void *from, size_t len)
+{
+	struct virtqueue *vq;
+	unsigned long flags;
+	int ret;
+
+	if (!vi->has_leakqs)
+		return -EOPNOTSUPP;
+
+	spin_lock_irqsave(&vi->lock, flags);
+
+	vq = get_active_leakq(vi);
+	ret = add_copy_on_leak_request(vi, vq, to, from, len);
+	if (ret)
+		virtqueue_kick(vq);
+
+	spin_unlock_irqrestore(&vi->lock, flags);
+
+	return ret;
+}
+
+static void entropy_leak_detected(struct virtqueue *vq)
+{
+	struct virtrng_info *vi = vq->vdev->priv;
+	struct virtqueue *activeq;
+	unsigned int len;
+	unsigned long flags;
+	void *buffer;
+	bool kick_activeq = false;
+
+	spin_lock_irqsave(&vi->lock, flags);
+
+	activeq = get_active_leakq(vi);
+	/* Drain all the used buffers from the queue */
+	while ((buffer = virtqueue_get_buf(vq, &len)) != NULL) {
+		if (vq == activeq) {
+			pr_debug("%s: entropy leak detected!", vi->name);
+			activeq = swap_leakqs(vi);
+		}
+
+		if (buffer == vi->leak_data) {
+			add_device_randomness(vi->leak_data, sizeof(vi->leak_data));
+
+			/* Ensure we always have a pending request for random bytes on entropy
+			 * leak. Do it here, after we have swapped leak queues, so it gets handled
+			 * with the next entropy leak event.
+			 */
+			add_fill_on_leak_request(vi, activeq, vi->leak_data, sizeof(vi->leak_data));
+			kick_activeq = true;
+		}
+	}
+
+	if (kick_activeq)
+		virtqueue_kick(activeq);
+
+	spin_unlock_irqrestore(&vi->lock, flags);
+}
+
 static void random_recv_done(struct virtqueue *vq)
 {
 	struct virtrng_info *vi = vq->vdev->priv;
+	unsigned long flags;
 
+	spin_lock_irqsave(&vi->lock, flags);
 	/* We can get spurious callbacks, e.g. shared IRQs + virtio_pci. */
 	if (!virtqueue_get_buf(vi->vq, &vi->data_avail))
-		return;
+		goto unlock;
 
 	vi->data_idx = 0;
 
 	complete(&vi->have_data);
+
+unlock:
+	spin_unlock_irqrestore(&vi->lock, flags);
 }
 
 static void request_entropy(struct virtrng_info *vi)
 {
 	struct scatterlist sg;
+	unsigned long flags;
 
 	reinit_completion(&vi->have_data);
 	vi->data_avail = 0;
@@ -57,10 +195,12 @@ static void request_entropy(struct virtrng_info *vi)
 
 	sg_init_one(&sg, vi->data, sizeof(vi->data));
 
+	spin_lock_irqsave(&vi->lock, flags);
 	/* There should always be room for one buffer. */
 	virtqueue_add_inbuf(vi->vq, &sg, 1, vi->data, GFP_KERNEL);
 
 	virtqueue_kick(vi->vq);
+	spin_unlock_irqrestore(&vi->lock, flags);
 }
 
 static unsigned int copy_data(struct virtrng_info *vi, void *buf,
@@ -126,6 +266,40 @@ static void virtio_cleanup(struct hwrng *rng)
 	complete(&vi->have_data);
 }
 
+static int init_virtqueues(struct virtrng_info *vi, struct virtio_device *vdev)
+{
+	int ret = -ENOMEM, total_vqs = 1;
+	struct virtqueue *vqs[3];
+	const char *names[3];
+	vq_callback_t *callbacks[3];
+
+	if (vi->has_leakqs)
+		total_vqs = 3;
+
+	callbacks[0] = random_recv_done;
+	names[0] = "input";
+	if (vi->has_leakqs) {
+		callbacks[1] = entropy_leak_detected;
+		names[1] = "leakq.1";
+		callbacks[2] = entropy_leak_detected;
+		names[2] = "leakq.2";
+	}
+
+	ret = virtio_find_vqs(vdev, total_vqs, vqs, callbacks, names, NULL);
+	if (ret)
+		goto err;
+
+	vi->vq = vqs[0];
+
+	if (vi->has_leakqs) {
+		vi->leakq[0] = vqs[1];
+		vi->leakq[1] = vqs[2];
+	}
+
+err:
+	return ret;
+}
+
 static int probe_common(struct virtio_device *vdev)
 {
 	int err, index;
@@ -152,18 +326,24 @@ static int probe_common(struct virtio_device *vdev)
 	};
 	vdev->priv = vi;
 
-	/* We expect a single virtqueue. */
-	vi->vq = virtio_find_single_vq(vdev, random_recv_done, "input");
-	if (IS_ERR(vi->vq)) {
-		err = PTR_ERR(vi->vq);
-		goto err_find;
+	vi->has_leakqs = virtio_has_feature(vdev, VIRTIO_RNG_F_LEAK);
+	if (vi->has_leakqs) {
+		spin_lock_init(&vi->lock);
+		vi->active_leakq = 0;
 	}
 
+	err = init_virtqueues(vi, vdev);
+	if (err)
+		goto err_find;
+
 	virtio_device_ready(vdev);
 
 	/* we always have a pending entropy request */
 	request_entropy(vi);
 
+	/* we always have a fill_on_leak request pending */
+	virtrng_fill_on_leak(vi, vi->leak_data, sizeof(vi->leak_data));
+
 	return 0;
 
 err_find:
@@ -246,7 +426,13 @@ static const struct virtio_device_id id_table[] = {
 	{ 0 },
 };
 
+static unsigned int features[] = {
+	VIRTIO_RNG_F_LEAK,
+};
+
 static struct virtio_driver virtio_rng_driver = {
+	.feature_table = features,
+	.feature_table_size = ARRAY_SIZE(features),
 	.driver.name =	KBUILD_MODNAME,
 	.driver.owner =	THIS_MODULE,
 	.id_table =	id_table,
diff --git a/include/uapi/linux/virtio_rng.h b/include/uapi/linux/virtio_rng.h
index c4d5de896f0c..d9774951547e 100644
--- a/include/uapi/linux/virtio_rng.h
+++ b/include/uapi/linux/virtio_rng.h
@@ -5,4 +5,7 @@
 #include <linux/virtio_ids.h>
 #include <linux/virtio_config.h>
 
+/* The feature bitmap for virtio entropy device */
+#define VIRTIO_RNG_F_LEAK 0
+
 #endif /* _LINUX_VIRTIO_RNG_H */
-- 
2.38.1

Amazon Spain Services sociedad limitada unipersonal, Calle Ramirez de Prado 5, 28045 Madrid. Registro Mercantil de Madrid . Tomo 22458 . Folio 102 . Hoja M-401234 . CIF B84570936


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3127F674131
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 19:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjASSp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 13:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjASSpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 13:45:18 -0500
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E62082994;
        Thu, 19 Jan 2023 10:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazon201209;
  t=1674153888; x=1705689888;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1hfgqrI1cwBxqGmSLjtFhNFPgeRgLX5XfsCMyd/feZ0=;
  b=aw6sN72iKeuEDPxUxrviOTtBejrORKL6gLklKecm57wysPDM3QRHGDdW
   H7V0Ooqb+0wS1vbWY7e9DEbBwacRPKyskYXN+StFOrpcMD/jPvoRaMh/q
   6IPzZhdANs0w6fs00VTd2+gkbPMDxkyqfMPMU9d/d8UPQqHKhglVmgsKl
   4=;
X-IronPort-AV: E=Sophos;i="5.97,229,1669075200"; 
   d="scan'208";a="290163781"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-8c5b1df3.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 18:44:41 +0000
Received: from EX13D50EUB003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2c-m6i4x-8c5b1df3.us-west-2.amazon.com (Postfix) with ESMTPS id 655D941BBE;
        Thu, 19 Jan 2023 18:44:38 +0000 (UTC)
Received: from EX19D037EUB003.ant.amazon.com (10.252.61.119) by
 EX13D50EUB003.ant.amazon.com (10.43.166.146) with Microsoft SMTP Server (TLS)
 id 15.0.1497.45; Thu, 19 Jan 2023 18:44:35 +0000
Received: from f4d4887fdcfb.ant.amazon.com (10.43.162.56) by
 EX19D037EUB003.ant.amazon.com (10.252.61.119) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.7; Thu, 19 Jan 2023 18:44:30 +0000
From:   Babis Chalios <bchalios@amazon.es>
To:     Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Jason Wang" <jasowang@redhat.com>,
        Babis Chalios <bchalios@amazon.es>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
CC:     <amit@kernel.org>, <graf@amazon.de>, <Jason@zx2c4.com>,
        <xmarcalx@amazon.co.uk>
Subject: [PATCH 2/2] virtio-rng: add sysfs entries for leak detection
Date:   Thu, 19 Jan 2023 19:43:48 +0100
Message-ID: <20230119184349.74072-3-bchalios@amazon.es>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230119184349.74072-1-bchalios@amazon.es>
References: <20230119184349.74072-1-bchalios@amazon.es>
MIME-Version: 1.0
X-Originating-IP: [10.43.162.56]
X-ClientProxiedBy: EX13D44UWC002.ant.amazon.com (10.43.162.169) To
 EX19D037EUB003.ant.amazon.com (10.252.61.119)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the copy-on-leak functionality of the virtio rng driver to
expose a mechanism to user space for detecting entropy leak events, such
as taking a VM snapshot or restoring from one.

The driver setups a single page of memory where it stores in the first
word a counter and queues a copy-on-leak command for increasing the
counter every time an entropy leak occurs. It exposes the value of the
counter in a binary sysfs file per device. The file can be mmap'ed and
read and every time a change on the counter is observed, `sysfs_notify`
is used to notify processes that are polling it.

The mechanism is implemented based on the idea of a VM generation
counter that had been before proposed as an extension to the VM
Generation ID device, where mmap and poll interfaces can be used on the
file containing the counter and changes in its value signal snapshot
events.

It is worth noting that using mmap is entirely race-free, since changes
in the counter are observable by user-space as soon as vcpus are
resumed. Instead, using poll is not race-free. There is a race-window
between the moment the vcpus are resumed and the used-buffers are
handled by the virtio-rng driver.

Signed-off-by: Babis Chalios <bchalios@amazon.es>
---
 drivers/char/hw_random/virtio-rng.c | 166 +++++++++++++++++++++++++++-
 1 file changed, 163 insertions(+), 3 deletions(-)

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index 389a091a8801..003320f6c574 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -5,6 +5,9 @@
  */
 
 #include "asm-generic/errno.h"
+#include "linux/gfp.h"
+#include "linux/minmax.h"
+#include "linux/sysfs.h"
 #include <linux/err.h>
 #include <linux/hw_random.h>
 #include <linux/scatterlist.h>
@@ -17,6 +20,10 @@
 
 static DEFINE_IDA(rng_index_ida);
 
+#ifdef CONFIG_SYSFS
+static struct kobject *virtio_rng_kobj;
+#endif
+
 struct virtrng_info {
 	struct hwrng hwrng;
 	struct virtqueue *vq;
@@ -25,6 +32,12 @@ struct virtrng_info {
 	struct virtqueue *leakq[2];
 	spinlock_t lock;
 	int active_leakq;
+#ifdef CONFIG_SYSFS
+	struct kobject *kobj;
+	struct bin_attribute vm_gen_counter_attr;
+	unsigned long map_buffer;
+	unsigned long next_vm_gen_counter;
+#endif
 
 	char name[25];
 	int index;
@@ -44,6 +57,40 @@ struct virtrng_info {
 #endif
 };
 
+#ifdef CONFIG_SYSFS
+ssize_t virtrng_sysfs_read(struct file *filep, struct kobject *kobj,
+		struct bin_attribute *attr, char *buf, loff_t pos, size_t len)
+{
+	struct virtrng_info *vi = attr->private;
+	unsigned long gen_counter = *(unsigned long *)vi->map_buffer;
+
+	if (!len)
+		return 0;
+
+	len = min(len, sizeof(gen_counter));
+	memcpy(buf, &gen_counter, len);
+
+	return len;
+}
+
+int virtrng_sysfs_mmap(struct file *filep, struct kobject *kobj,
+		struct bin_attribute *attr, struct vm_area_struct *vma)
+{
+	struct virtrng_info *vi = attr->private;
+
+	if (vma->vm_pgoff || vma_pages(vma) > 1)
+		return -EINVAL;
+
+	if (vma->vm_flags & VM_WRITE)
+		return -EPERM;
+
+	vma->vm_flags |= VM_DONTEXPAND;
+	vma->vm_flags &= ~VM_MAYWRITE;
+
+	return vm_insert_page(vma, vma->vm_start, virt_to_page(vi->map_buffer));
+}
+#endif
+
 /* Swaps the queues and returns the new active leak queue. */
 static struct virtqueue *swap_leakqs(struct virtrng_info *vi)
 {
@@ -83,7 +130,7 @@ int virtrng_fill_on_leak(struct virtrng_info *vi, void *data, size_t len)
 
 	vq = get_active_leakq(vi);
 	ret = add_fill_on_leak_request(vi, vq, data, len);
-	if (ret)
+	if (!ret)
 		virtqueue_kick(vq);
 
 	spin_unlock_irqrestore(&vi->lock, flags);
@@ -123,7 +170,7 @@ int virtrng_copy_on_leak(struct virtrng_info *vi, void *to, void *from, size_t l
 
 	vq = get_active_leakq(vi);
 	ret = add_copy_on_leak_request(vi, vq, to, from, len);
-	if (ret)
+	if (!ret)
 		virtqueue_kick(vq);
 
 	spin_unlock_irqrestore(&vi->lock, flags);
@@ -139,6 +186,9 @@ static void entropy_leak_detected(struct virtqueue *vq)
 	unsigned long flags;
 	void *buffer;
 	bool kick_activeq = false;
+#ifdef CONFIG_SYSFS
+	bool notify_sysfs = false;
+#endif
 
 	spin_lock_irqsave(&vi->lock, flags);
 
@@ -160,12 +210,34 @@ static void entropy_leak_detected(struct virtqueue *vq)
 			add_fill_on_leak_request(vi, activeq, vi->leak_data, sizeof(vi->leak_data));
 			kick_activeq = true;
 		}
+
+#ifdef CONFIG_SYSFS
+		if (buffer == (void *)vi->map_buffer) {
+			notify_sysfs = true;
+
+			/* Add a request to bump the generation counter on the next leak event.
+			 * We have already swapped leak queues, so this will get properly handled
+			 * with the next entropy leak event.
+			 */
+			vi->next_vm_gen_counter++;
+			add_copy_on_leak_request(vi, activeq, (void *)vi->map_buffer,
+					&vi->next_vm_gen_counter, sizeof(unsigned long));
+
+			kick_activeq = true;
+		}
+#endif
 	}
 
 	if (kick_activeq)
 		virtqueue_kick(activeq);
 
 	spin_unlock_irqrestore(&vi->lock, flags);
+
+#ifdef CONFIG_SYSFS
+	/* Notify anyone polling on the sysfs file */
+	if (notify_sysfs)
+		sysfs_notify(vi->kobj, NULL, "vm_gen_counter");
+#endif
 }
 
 static void random_recv_done(struct virtqueue *vq)
@@ -302,6 +374,59 @@ static int init_virtqueues(struct virtrng_info *vi, struct virtio_device *vdev)
 	return ret;
 }
 
+#ifdef CONFIG_SYSFS
+static int setup_sysfs(struct virtrng_info *vi)
+{
+	int err;
+
+	vi->next_vm_gen_counter = 1;
+
+	/* We have one binary file per device under /sys/virtio-rng/<device>/vm_gen_counter */
+	vi->vm_gen_counter_attr.attr.name = "vm_gen_counter";
+	vi->vm_gen_counter_attr.attr.mode = 0444;
+	vi->vm_gen_counter_attr.read = virtrng_sysfs_read;
+	vi->vm_gen_counter_attr.mmap = virtrng_sysfs_mmap;
+	vi->vm_gen_counter_attr.private = vi;
+
+	vi->map_buffer = get_zeroed_page(GFP_KERNEL);
+	if (!vi->map_buffer)
+		return -ENOMEM;
+
+	err = -ENOMEM;
+	vi->kobj = kobject_create_and_add(vi->name, virtio_rng_kobj);
+	if (!vi->kobj)
+		goto err_page;
+
+	err = sysfs_create_bin_file(vi->kobj, &vi->vm_gen_counter_attr);
+	if (err)
+		goto err_kobj;
+
+	return 0;
+
+err_kobj:
+	kobject_put(vi->kobj);
+err_page:
+	free_pages(vi->map_buffer, 0);
+	return err;
+}
+
+static void cleanup_sysfs(struct virtrng_info *vi)
+{
+	sysfs_remove_bin_file(vi->kobj, &vi->vm_gen_counter_attr);
+	kobject_put(vi->kobj);
+	free_pages(vi->map_buffer, 0);
+}
+#else
+static int setup_sysfs(struct virtrng_info *vi)
+{
+	return 0;
+}
+
+static void cleanup_sysfs(struct virtrng_info *vi)
+{
+}
+#endif
+
 static int probe_common(struct virtio_device *vdev)
 {
 	int err, index;
@@ -332,11 +457,15 @@ static int probe_common(struct virtio_device *vdev)
 	if (vi->has_leakqs) {
 		spin_lock_init(&vi->lock);
 		vi->active_leakq = 0;
+
+		err = setup_sysfs(vi);
+		if (err)
+			goto err_find;
 	}
 
 	err = init_virtqueues(vi, vdev);
 	if (err)
-		goto err_find;
+		goto err_sysfs;
 
 	virtio_device_ready(vdev);
 
@@ -346,8 +475,18 @@ static int probe_common(struct virtio_device *vdev)
 	/* we always have a fill_on_leak request pending */
 	virtrng_fill_on_leak(vi, vi->leak_data, sizeof(vi->leak_data));
 
+#ifdef CONFIG_SYSFS
+	/* also a copy_on_leak request for the generation counter when we have sysfs
+	 * support.
+	 */
+	virtrng_copy_on_leak(vi, (void *)vi->map_buffer, &vi->next_vm_gen_counter,
+			sizeof(unsigned long));
+#endif
+
 	return 0;
 
+err_sysfs:
+	cleanup_sysfs(vi);
 err_find:
 	ida_simple_remove(&rng_index_ida, index);
 err_ida:
@@ -365,6 +504,8 @@ static void remove_common(struct virtio_device *vdev)
 	complete(&vi->have_data);
 	if (vi->hwrng_register_done)
 		hwrng_unregister(&vi->hwrng);
+	if (vi->has_leakqs)
+		cleanup_sysfs(vi);
 	virtio_reset_device(vdev);
 	vdev->config->del_vqs(vdev);
 	ida_simple_remove(&rng_index_ida, vi->index);
@@ -447,6 +588,25 @@ static struct virtio_driver virtio_rng_driver = {
 #endif
 };
 
+#ifdef CONFIG_SYSFS
+static int __init virtio_rng_init(void)
+{
+	virtio_rng_kobj = kobject_create_and_add("virtio-rng", NULL);
+	if (!virtio_rng_kobj)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void __exit virtio_rng_fini(void)
+{
+	kobject_put(virtio_rng_kobj);
+}
+
+module_init(virtio_rng_init);
+module_exit(virtio_rng_fini);
+#endif
+
 module_virtio_driver(virtio_rng_driver);
 MODULE_DEVICE_TABLE(virtio, id_table);
 MODULE_DESCRIPTION("Virtio random number driver");
-- 
2.38.1

Amazon Spain Services sociedad limitada unipersonal, Calle Ramirez de Prado 5, 28045 Madrid. Registro Mercantil de Madrid . Tomo 22458 . Folio 102 . Hoja M-401234 . CIF B84570936


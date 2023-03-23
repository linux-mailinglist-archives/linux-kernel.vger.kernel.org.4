Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9011E6C5EF2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 06:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjCWFda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 01:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjCWFcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 01:32:51 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7171C227A4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 22:31:33 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id p13-20020a17090a284d00b0023d2e945aebso2822642pjf.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 22:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1679549488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1c2pCL4c/YcHpCNIUgvAUe+YLzVLpglkTSZZiab5oRI=;
        b=Q3RqfJ+fcU+ntq9/ObJf7xvYpbcxtcltDKNe8/H69IU2YAkp154MvVHSCXJMtUYMCZ
         HvMdaHNzflIYHBTCnuJA86HxfxLRMk2/8Hy9skLVYtCqc4UCIAUrj0mLHalDgSEHiR8q
         3SrXNONsGlA/nBVo1C15XDcWDWbcV16j8vLjspSuMg8X5g5URanMng0Fa6MnhSPBS5Id
         zemDBNkQAsrFscuIO+ng5Dx0El08TQcTiwgalcg788LCQcrTzoNrOZTEQxrAPivHMktY
         uIQcFiz/YGG7r5j9dAliyTZQt0FvrWr+6dXeyh7oa9eVgg2TadiTLTQwQbEqt3P18UAh
         7tUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679549488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1c2pCL4c/YcHpCNIUgvAUe+YLzVLpglkTSZZiab5oRI=;
        b=1iHKVmVLgt3cVaxgsh/Rifk/qOOo+GT7QITsbtee2p0JJBBv4/82VI9bUrcMy/DJ3k
         Q72CADDh1S4yq0TKZQDGIaw5z0lXV2PBUboQ6qWSwTAUeT5lONGBSCxqyaLeIs5cjNEd
         lpSJZKwcXDxuiezM2Zb7PCnPwaggM2dFgqBMy2FPVgySXGDlUzrqs6K4IbrnhqDkLNdw
         oL1BVVOACebNEsRtFLWk8CbSN+ZKedmnAEERDacUzxvAEOa8Wm3y9bPvytwxfpXw9iEv
         bkefSn1vp7Au4QUzAPnJJYsaEkl724HS6WqbkHdf5A5T0+paQS2PHxglenYYIdHMlo4S
         x34w==
X-Gm-Message-State: AO0yUKWuLgw/5X1v0QNy2ZPb5/J7sLy0LhvHqRMfRCmfDyamJ8+18xsh
        MY46yPgLrQr0YDH7PvjvRpiNid8l9DMoyidHuA==
X-Google-Smtp-Source: AK7set+sscXy+qvAp2F9h8r8pUnQjeqJQgUBrOMPEuXtNXOYtiSGW2Uf7duNx52YNIhkjwCY6w0V9w==
X-Received: by 2002:a17:902:e1d3:b0:1a1:a722:104f with SMTP id t19-20020a170902e1d300b001a1a722104fmr3741627pla.24.1679549488596;
        Wed, 22 Mar 2023 22:31:28 -0700 (PDT)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id g11-20020a170902934b00b00199203a4fa3sm11395057plp.203.2023.03.22.22.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 22:31:28 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, tglx@linutronix.de, hch@lst.de
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 05/11] vduse: Support set_vq_affinity callback
Date:   Thu, 23 Mar 2023 13:30:37 +0800
Message-Id: <20230323053043.35-6-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230323053043.35-1-xieyongji@bytedance.com>
References: <20230323053043.35-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since virtio-vdpa bus driver already support interrupt
affinity spreading mechanism, let's implement the
set_vq_affinity callback to bring it to vduse device.
After we get the virtqueue's affinity, we can spread
IRQs between CPUs in the affinity mask, in a round-robin
manner, to run the irq callback.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 61 ++++++++++++++++++++++++++----
 1 file changed, 54 insertions(+), 7 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 98359d87a06f..45aa8703c4b5 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -41,6 +41,8 @@
 #define VDUSE_IOVA_SIZE (128 * 1024 * 1024)
 #define VDUSE_MSG_DEFAULT_TIMEOUT 30
 
+#define IRQ_UNBOUND -1
+
 struct vduse_virtqueue {
 	u16 index;
 	u16 num_max;
@@ -57,6 +59,8 @@ struct vduse_virtqueue {
 	struct vdpa_callback cb;
 	struct work_struct inject;
 	struct work_struct kick;
+	int irq_effective_cpu;
+	struct cpumask irq_affinity;
 };
 
 struct vduse_dev;
@@ -128,6 +132,7 @@ static struct class *vduse_class;
 static struct cdev vduse_ctrl_cdev;
 static struct cdev vduse_cdev;
 static struct workqueue_struct *vduse_irq_wq;
+static struct workqueue_struct *vduse_irq_bound_wq;
 
 static u32 allowed_device_id[] = {
 	VIRTIO_ID_BLOCK,
@@ -708,6 +713,15 @@ static u32 vduse_vdpa_get_generation(struct vdpa_device *vdpa)
 	return dev->generation;
 }
 
+static int vduse_vdpa_set_vq_affinity(struct vdpa_device *vdpa, u16 idx,
+				      const struct cpumask *cpu_mask)
+{
+	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
+
+	cpumask_copy(&dev->vqs[idx]->irq_affinity, cpu_mask);
+	return 0;
+}
+
 static int vduse_vdpa_set_map(struct vdpa_device *vdpa,
 				unsigned int asid,
 				struct vhost_iotlb *iotlb)
@@ -758,6 +772,7 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
 	.get_config		= vduse_vdpa_get_config,
 	.set_config		= vduse_vdpa_set_config,
 	.get_generation		= vduse_vdpa_get_generation,
+	.set_vq_affinity	= vduse_vdpa_set_vq_affinity,
 	.reset			= vduse_vdpa_reset,
 	.set_map		= vduse_vdpa_set_map,
 	.free			= vduse_vdpa_free,
@@ -917,7 +932,8 @@ static void vduse_vq_irq_inject(struct work_struct *work)
 }
 
 static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
-				    struct work_struct *irq_work)
+				    struct work_struct *irq_work,
+				    int irq_effective_cpu)
 {
 	int ret = -EINVAL;
 
@@ -926,7 +942,11 @@ static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
 		goto unlock;
 
 	ret = 0;
-	queue_work(vduse_irq_wq, irq_work);
+	if (irq_effective_cpu == IRQ_UNBOUND)
+		queue_work(vduse_irq_wq, irq_work);
+	else
+		queue_work_on(irq_effective_cpu,
+			      vduse_irq_bound_wq, irq_work);
 unlock:
 	up_read(&dev->rwsem);
 
@@ -1029,6 +1049,22 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev,
 	return ret;
 }
 
+static void vduse_vq_update_effective_cpu(struct vduse_virtqueue *vq)
+{
+	int curr_cpu = vq->irq_effective_cpu;
+
+	while (true) {
+		curr_cpu = cpumask_next(curr_cpu, &vq->irq_affinity);
+		if (cpu_online(curr_cpu))
+			break;
+
+		if (curr_cpu >= nr_cpu_ids)
+			curr_cpu = IRQ_UNBOUND;
+	}
+
+	vq->irq_effective_cpu = curr_cpu;
+}
+
 static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 			    unsigned long arg)
 {
@@ -1111,7 +1147,7 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 		break;
 	}
 	case VDUSE_DEV_INJECT_CONFIG_IRQ:
-		ret = vduse_dev_queue_irq_work(dev, &dev->inject);
+		ret = vduse_dev_queue_irq_work(dev, &dev->inject, IRQ_UNBOUND);
 		break;
 	case VDUSE_VQ_SETUP: {
 		struct vduse_vq_config config;
@@ -1198,7 +1234,10 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 			break;
 
 		index = array_index_nospec(index, dev->vq_num);
-		ret = vduse_dev_queue_irq_work(dev, &dev->vqs[index]->inject);
+
+		vduse_vq_update_effective_cpu(dev->vqs[index]);
+		ret = vduse_dev_queue_irq_work(dev, &dev->vqs[index]->inject,
+					dev->vqs[index]->irq_effective_cpu);
 		break;
 	}
 	case VDUSE_IOTLB_REG_UMEM: {
@@ -1367,10 +1406,12 @@ static int vduse_dev_init_vqs(struct vduse_dev *dev, u32 vq_align, u32 vq_num)
 			goto err;
 
 		dev->vqs[i]->index = i;
+		dev->vqs[i]->irq_effective_cpu = IRQ_UNBOUND;
 		INIT_WORK(&dev->vqs[i]->inject, vduse_vq_irq_inject);
 		INIT_WORK(&dev->vqs[i]->kick, vduse_vq_kick_work);
 		spin_lock_init(&dev->vqs[i]->kick_lock);
 		spin_lock_init(&dev->vqs[i]->irq_lock);
+		cpumask_setall(&dev->vqs[i]->irq_affinity);
 	}
 
 	return 0;
@@ -1858,12 +1899,15 @@ static int vduse_init(void)
 	if (ret)
 		goto err_cdev;
 
+	ret = -ENOMEM;
 	vduse_irq_wq = alloc_workqueue("vduse-irq",
 				WQ_HIGHPRI | WQ_SYSFS | WQ_UNBOUND, 0);
-	if (!vduse_irq_wq) {
-		ret = -ENOMEM;
+	if (!vduse_irq_wq)
 		goto err_wq;
-	}
+
+	vduse_irq_bound_wq = alloc_workqueue("vduse-irq-bound", WQ_HIGHPRI, 0);
+	if (!vduse_irq_bound_wq)
+		goto err_bound_wq;
 
 	ret = vduse_domain_init();
 	if (ret)
@@ -1877,6 +1921,8 @@ static int vduse_init(void)
 err_mgmtdev:
 	vduse_domain_exit();
 err_domain:
+	destroy_workqueue(vduse_irq_bound_wq);
+err_bound_wq:
 	destroy_workqueue(vduse_irq_wq);
 err_wq:
 	cdev_del(&vduse_cdev);
@@ -1896,6 +1942,7 @@ static void vduse_exit(void)
 {
 	vduse_mgmtdev_exit();
 	vduse_domain_exit();
+	destroy_workqueue(vduse_irq_bound_wq);
 	destroy_workqueue(vduse_irq_wq);
 	cdev_del(&vduse_cdev);
 	device_destroy(vduse_class, vduse_major);
-- 
2.20.1


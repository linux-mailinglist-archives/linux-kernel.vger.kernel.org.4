Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3BF6A5607
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 10:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjB1Jmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 04:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjB1Jmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 04:42:31 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DDC2D159
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 01:42:27 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id i10so9754952plr.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 01:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2hJ42EGznmmKdit+DkkUJ/Qt7N29KFOU8Z1Bu00RmiQ=;
        b=aNO16KpcRslYIothZ5ipnOru7C83teAcH/Izpsl5+VmpmgqL6Aro+jC4UBMPVIl8gg
         H8VOlspRP99FW5HRqlnu2KR/cRKQ2bu6V9NWQrUPmHDHf4W+swM9rDCCBxq4a6yfVp7y
         gexE/286EPl6w8XSysh5hwFI6x/ddWDN6UEUg1LgAOqMAnbo6JuUJr4lTgNy89NaxFt+
         JbD0sjqk6DOAMecWDqpqK8fGL27nbwpF4vHpArxc1h5oQ36e8sizg9Ik+FHzmCzW7h7Y
         CCnAm4KnbAosnfpz0YrdB5vc8o1i4M8D/tCbvxQZIjcqNL6gJ5tkuw9lGquVDDtjzYwT
         +tOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2hJ42EGznmmKdit+DkkUJ/Qt7N29KFOU8Z1Bu00RmiQ=;
        b=GHhZ8y6P7wbqpyxNHSfnoA5gOk/N3GmjqwcaTEhbbuGZv4jYn4Q3XsE7wgDq0nwirY
         WOR8fziVyLjYiO/nDGhj7I+aYvj4lQ5utivrYTSLoMdFyF4tA+zsSgxGWjbrtIDrJyLO
         l1vpgTq6TGnJqlIojJ4LIc05t5NSnXrUkr2pquSi1Ngfo/c+MIyp7UMNjkcCLlVESDuM
         h+TKdfZvDHS9PSfoIjGx1qfi3NdtGWzwCWtIUXabGtEx4D/MkNP233g4/9k0grrHfgwh
         7t928kepQi9xnp5d7jz3Fr4MgfhXXAIioEhLEYSRQA+LYQuA5f3aoxQt5nm9tiWv6v6i
         rfOw==
X-Gm-Message-State: AO0yUKVOZryQlUSq9OrdS9w9ZAluoXDPVlRqetwuBOY3vKWRI+K20Vst
        ajeTwyE3z1R5ipytboAzPtlj
X-Google-Smtp-Source: AK7set+TPNFC/xncKPCXhfN++ABlTZBeiZtGV3YKs6GK4wnSj6THLwqFKjksu7//B6tGl/kOzqVSJA==
X-Received: by 2002:a17:903:2290:b0:19b:33c0:4097 with SMTP id b16-20020a170903229000b0019b33c04097mr2524721plh.27.1677577346715;
        Tue, 28 Feb 2023 01:42:26 -0800 (PST)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id jj13-20020a170903048d00b001967692d6f5sm6054858plb.227.2023.02.28.01.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 01:42:26 -0800 (PST)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, tglx@linutronix.de, hch@lst.de
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/11] vduse: Support automatic irq callback affinity
Date:   Tue, 28 Feb 2023 17:41:04 +0800
Message-Id: <20230228094110.37-6-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230228094110.37-1-xieyongji@bytedance.com>
References: <20230228094110.37-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This brings current interrupt affinity spreading mechanism
to vduse device. We will make use of group_cpus_evenly()
to create an irq callback affinity mask for each virtqueue of
vduse device. Then we will spread IRQs between CPUs in the affinity
mask, in a round-robin manner, to run the irq callback.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 130 +++++++++++++++++++++++++++--
 1 file changed, 123 insertions(+), 7 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 98359d87a06f..bde28a8692d5 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -23,6 +23,8 @@
 #include <linux/nospec.h>
 #include <linux/vmalloc.h>
 #include <linux/sched/mm.h>
+#include <linux/interrupt.h>
+#include <linux/group_cpus.h>
 #include <uapi/linux/vduse.h>
 #include <uapi/linux/vdpa.h>
 #include <uapi/linux/virtio_config.h>
@@ -41,6 +43,8 @@
 #define VDUSE_IOVA_SIZE (128 * 1024 * 1024)
 #define VDUSE_MSG_DEFAULT_TIMEOUT 30
 
+#define IRQ_UNBOUND -1
+
 struct vduse_virtqueue {
 	u16 index;
 	u16 num_max;
@@ -57,6 +61,8 @@ struct vduse_virtqueue {
 	struct vdpa_callback cb;
 	struct work_struct inject;
 	struct work_struct kick;
+	int irq_effective_cpu;
+	struct cpumask irq_affinity;
 };
 
 struct vduse_dev;
@@ -128,6 +134,7 @@ static struct class *vduse_class;
 static struct cdev vduse_ctrl_cdev;
 static struct cdev vduse_cdev;
 static struct workqueue_struct *vduse_irq_wq;
+static struct workqueue_struct *vduse_irq_bound_wq;
 
 static u32 allowed_device_id[] = {
 	VIRTIO_ID_BLOCK,
@@ -708,6 +715,82 @@ static u32 vduse_vdpa_get_generation(struct vdpa_device *vdpa)
 	return dev->generation;
 }
 
+static void default_calc_sets(struct irq_affinity *affd, unsigned int affvecs)
+{
+	affd->nr_sets = 1;
+	affd->set_size[0] = affvecs;
+}
+
+struct cpumask *
+create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
+{
+	unsigned int affvecs = 0, curvec, usedvecs, i;
+	struct cpumask *masks = NULL;
+
+	if (nvecs > affd->pre_vectors + affd->post_vectors)
+		affvecs = nvecs - affd->pre_vectors - affd->post_vectors;
+
+	if (!affd->calc_sets)
+		affd->calc_sets = default_calc_sets;
+
+	affd->calc_sets(affd, affvecs);
+
+	if (!affvecs)
+		return NULL;
+
+	masks = kcalloc(nvecs, sizeof(*masks), GFP_KERNEL);
+	if (!masks)
+		return NULL;
+
+	/* Fill out vectors at the beginning that don't need affinity */
+	for (curvec = 0; curvec < affd->pre_vectors; curvec++)
+		cpumask_setall(&masks[curvec]);
+
+	for (i = 0, usedvecs = 0; i < affd->nr_sets; i++) {
+		unsigned int this_vecs = affd->set_size[i];
+		int j;
+		struct cpumask *result = group_cpus_evenly(this_vecs);
+
+		if (!result) {
+			kfree(masks);
+			return NULL;
+		}
+
+		for (j = 0; j < this_vecs; j++)
+			cpumask_copy(&masks[curvec + j], &result[j]);
+		kfree(result);
+
+		curvec += this_vecs;
+		usedvecs += this_vecs;
+	}
+
+	/* Fill out vectors at the end that don't need affinity */
+	if (usedvecs >= affvecs)
+		curvec = affd->pre_vectors + affvecs;
+	else
+		curvec = affd->pre_vectors + usedvecs;
+	for (; curvec < nvecs; curvec++)
+		cpumask_setall(&masks[curvec]);
+
+	return masks;
+}
+
+static void vduse_vdpa_set_irq_affinity(struct vdpa_device *vdpa,
+					struct irq_affinity *desc)
+{
+	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
+	struct cpumask *masks;
+	int i;
+
+	masks = create_affinity_masks(dev->vq_num, desc);
+	if (!masks)
+		return;
+
+	for (i = 0; i < dev->vq_num; i++)
+		cpumask_copy(&dev->vqs[i]->irq_affinity, &masks[i]);
+	kfree(masks);
+}
+
 static int vduse_vdpa_set_map(struct vdpa_device *vdpa,
 				unsigned int asid,
 				struct vhost_iotlb *iotlb)
@@ -758,6 +841,7 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
 	.get_config		= vduse_vdpa_get_config,
 	.set_config		= vduse_vdpa_set_config,
 	.get_generation		= vduse_vdpa_get_generation,
+	.set_irq_affinity	= vduse_vdpa_set_irq_affinity,
 	.reset			= vduse_vdpa_reset,
 	.set_map		= vduse_vdpa_set_map,
 	.free			= vduse_vdpa_free,
@@ -917,7 +1001,8 @@ static void vduse_vq_irq_inject(struct work_struct *work)
 }
 
 static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
-				    struct work_struct *irq_work)
+				    struct work_struct *irq_work,
+				    int irq_effective_cpu)
 {
 	int ret = -EINVAL;
 
@@ -926,7 +1011,11 @@ static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
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
 
@@ -1029,6 +1118,22 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev,
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
+			curr_cpu = -1;
+	}
+
+	vq->irq_effective_cpu = curr_cpu;
+}
+
 static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 			    unsigned long arg)
 {
@@ -1111,7 +1216,7 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 		break;
 	}
 	case VDUSE_DEV_INJECT_CONFIG_IRQ:
-		ret = vduse_dev_queue_irq_work(dev, &dev->inject);
+		ret = vduse_dev_queue_irq_work(dev, &dev->inject, IRQ_UNBOUND);
 		break;
 	case VDUSE_VQ_SETUP: {
 		struct vduse_vq_config config;
@@ -1198,7 +1303,10 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
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
@@ -1367,10 +1475,12 @@ static int vduse_dev_init_vqs(struct vduse_dev *dev, u32 vq_align, u32 vq_num)
 			goto err;
 
 		dev->vqs[i]->index = i;
+		dev->vqs[i]->irq_effective_cpu = -1;
 		INIT_WORK(&dev->vqs[i]->inject, vduse_vq_irq_inject);
 		INIT_WORK(&dev->vqs[i]->kick, vduse_vq_kick_work);
 		spin_lock_init(&dev->vqs[i]->kick_lock);
 		spin_lock_init(&dev->vqs[i]->irq_lock);
+		cpumask_setall(&dev->vqs[i]->irq_affinity);
 	}
 
 	return 0;
@@ -1858,12 +1968,15 @@ static int vduse_init(void)
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
@@ -1877,6 +1990,8 @@ static int vduse_init(void)
 err_mgmtdev:
 	vduse_domain_exit();
 err_domain:
+	destroy_workqueue(vduse_irq_bound_wq);
+err_bound_wq:
 	destroy_workqueue(vduse_irq_wq);
 err_wq:
 	cdev_del(&vduse_cdev);
@@ -1896,6 +2011,7 @@ static void vduse_exit(void)
 {
 	vduse_mgmtdev_exit();
 	vduse_domain_exit();
+	destroy_workqueue(vduse_irq_bound_wq);
 	destroy_workqueue(vduse_irq_wq);
 	cdev_del(&vduse_cdev);
 	device_destroy(vduse_class, vduse_major);
-- 
2.20.1


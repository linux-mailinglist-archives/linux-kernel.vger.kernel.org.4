Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47FB6424EB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 09:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbiLEIo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 03:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbiLEIoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 03:44:11 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659FA175B3
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 00:44:05 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id a9so10158805pld.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 00:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bMI6P3PULWBT8ZMjEJBlSCpH/XnH6SZ3xtd3V98uLe4=;
        b=PPBgn2nThXaQAvz3fJ6q3csueQxhiYeje3jEXwaxqVnaknt6zCgZsErXIvEMRYKanQ
         x2gZz91yCUrYuqBzpf27PxAEVTWxXPGgYN77eFYRbG6DwZ34/MJeV8unqJUrwoS3o1+s
         4soXq5JRiCZIL3pVAZSD/zfqeufNVWl5Ve7ibwZEK0Z2ERQSRHuFFNvbv7iMIvxoWcVp
         L2ydVpVvlgcfLrmZNsFCCimFzfwfKEK/N4/DYTngfW+/v0SEOhdMEZ4zK5Kw//EHRe9g
         scwtq3lOwg9TFfPMGyAU3NSnHfpmm1agd3XE7XpCDsuEJJD4AnOQmpPV7eibHvAVP9U+
         DdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bMI6P3PULWBT8ZMjEJBlSCpH/XnH6SZ3xtd3V98uLe4=;
        b=Jsudo6q0ujhbcVeB36oxe+v4wvPxDyg+b89ubAvkYsX5CwMFk5gUbJpgrO0k/S0i41
         8yiE4igtImfVdI7MepY2LAxbv9KdNvnhOfGSE3QPP/sUjIWVkllC+NxikQ7bR+J5nmHs
         RF1bNBCBkobyYYuhUn5EuVNK1l+2/hFgep7pF8HDXESHwxLL4xY5R3O7IqTR8ckl6s0l
         ohc1qaClPpQnye50uS4YB/S31Mdpxubf87JhUgSUrifpXS1CsC0Nyxi5DSKlaT1mNvGB
         BMnu2lhpZu/9z0W07v2212W4b5cX0U4nZkRLijzExd8RGWUzBT8Y9DibIkLPWuOZCFTM
         R4DA==
X-Gm-Message-State: ANoB5pmxZ7KfuiEygESW2wr7y7ZU4oaSQ+MeEjVX+8vKLJA+XDLCvTHa
        I3K22EYBVMz4joXxMsfXfNLq
X-Google-Smtp-Source: AA0mqf5x/eCiCcyqqTloehSQAGYDmB97NbwuBN0MdVA64TquKhXGFIiLQA/tKvp8HCYU8qFhwpwowA==
X-Received: by 2002:a17:902:f651:b0:188:50c2:89fb with SMTP id m17-20020a170902f65100b0018850c289fbmr47422798plg.130.1670229845294;
        Mon, 05 Dec 2022 00:44:05 -0800 (PST)
Received: from localhost ([101.229.232.206])
        by smtp.gmail.com with ESMTPSA id p29-20020a635b1d000000b004785d99321asm7887460pgb.86.2022.12.05.00.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 00:44:04 -0800 (PST)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, tglx@linutronix.de, hch@lst.de
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/11] vduse: Introduce bound workqueue for irq injection
Date:   Mon,  5 Dec 2022 16:41:21 +0800
Message-Id: <20221205084127.535-6-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221205084127.535-1-xieyongji@bytedance.com>
References: <20221205084127.535-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces a bound workqueue to support running
irq callback in a specified cpu.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 37809bfcb7ef..d126f3e32a20 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -57,6 +57,7 @@ struct vduse_virtqueue {
 	struct vdpa_callback cb;
 	struct work_struct inject;
 	struct work_struct kick;
+	int irq_effective_cpu;
 };
 
 struct vduse_dev;
@@ -128,6 +129,7 @@ static struct class *vduse_class;
 static struct cdev vduse_ctrl_cdev;
 static struct cdev vduse_cdev;
 static struct workqueue_struct *vduse_irq_wq;
+static struct workqueue_struct *vduse_irq_bound_wq;
 
 static u32 allowed_device_id[] = {
 	VIRTIO_ID_BLOCK,
@@ -917,7 +919,8 @@ static void vduse_vq_irq_inject(struct work_struct *work)
 }
 
 static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
-				    struct work_struct *irq_work)
+				    struct work_struct *irq_work,
+				    int irq_effective_cpu)
 {
 	int ret = -EINVAL;
 
@@ -926,7 +929,11 @@ static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
 		goto unlock;
 
 	ret = 0;
-	queue_work(vduse_irq_wq, irq_work);
+	if (irq_effective_cpu == -1)
+		queue_work(vduse_irq_wq, irq_work);
+	else
+		queue_work_on(irq_effective_cpu,
+			      vduse_irq_bound_wq, irq_work);
 unlock:
 	up_read(&dev->rwsem);
 
@@ -1111,7 +1118,7 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 		break;
 	}
 	case VDUSE_DEV_INJECT_CONFIG_IRQ:
-		ret = vduse_dev_queue_irq_work(dev, &dev->inject);
+		ret = vduse_dev_queue_irq_work(dev, &dev->inject, -1);
 		break;
 	case VDUSE_VQ_SETUP: {
 		struct vduse_vq_config config;
@@ -1198,7 +1205,8 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 			break;
 
 		index = array_index_nospec(index, dev->vq_num);
-		ret = vduse_dev_queue_irq_work(dev, &dev->vqs[index]->inject);
+		ret = vduse_dev_queue_irq_work(dev, &dev->vqs[index]->inject,
+					dev->vqs[index]->irq_effective_cpu);
 		break;
 	}
 	case VDUSE_IOTLB_REG_UMEM: {
@@ -1367,6 +1375,7 @@ static int vduse_dev_init_vqs(struct vduse_dev *dev, u32 vq_align, u32 vq_num)
 			goto err;
 
 		dev->vqs[i]->index = i;
+		dev->vqs[i]->irq_effective_cpu = -1;
 		INIT_WORK(&dev->vqs[i]->inject, vduse_vq_irq_inject);
 		INIT_WORK(&dev->vqs[i]->kick, vduse_vq_kick_work);
 		spin_lock_init(&dev->vqs[i]->kick_lock);
@@ -1855,12 +1864,15 @@ static int vduse_init(void)
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
@@ -1874,6 +1886,8 @@ static int vduse_init(void)
 err_mgmtdev:
 	vduse_domain_exit();
 err_domain:
+	destroy_workqueue(vduse_irq_bound_wq);
+err_bound_wq:
 	destroy_workqueue(vduse_irq_wq);
 err_wq:
 	cdev_del(&vduse_cdev);
@@ -1893,6 +1907,7 @@ static void vduse_exit(void)
 {
 	vduse_mgmtdev_exit();
 	vduse_domain_exit();
+	destroy_workqueue(vduse_irq_bound_wq);
 	destroy_workqueue(vduse_irq_wq);
 	cdev_del(&vduse_cdev);
 	device_destroy(vduse_class, vduse_major);
-- 
2.20.1


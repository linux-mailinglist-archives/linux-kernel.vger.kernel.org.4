Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE52642549
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 10:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbiLEJB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 04:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbiLEJAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 04:00:43 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DC26426
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 00:59:07 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id q71so9913539pgq.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 00:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SbUN/Ko04SNzoBySAaB7G+D6Ee//XjJqOiItc7bmihU=;
        b=PU3O4v2cQ68yHc6IM8LwdPnVejbvUKQh3EhLMNBFT8BoTrTB5xYC+K7usjaOi6IIdq
         kmHAB+GDafvHchHAP4Ll8tOEvxqZZCHIYOhdV++DIFj6gF8yGCo9eCANPrCu7cTFYT0h
         3iZwyjWwGa/33rxA8gEJ49Lg4x96x9AYDrV6cQZKtqnyt5cIfpb2xEqbMa+yuW3ivl2f
         QIrVUZFVkD1qRuf015T6SANDjzE+2+A/QHP3EandFeQUgJjmog8pa3PukdCxfo0zNOjp
         a/5Ua7zJ5uijTSW5rsIx58IxSFQ0/s0Oq2Ou6Qaz5bozmliCAqic7EUZvJV5JY6XjM0B
         atew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SbUN/Ko04SNzoBySAaB7G+D6Ee//XjJqOiItc7bmihU=;
        b=GHkYA+CbVXUE4yKpT1S+KQM0w7uT4DuFtXoZyT3AVfihg2plcnBUSJPsN9aAQJkz1v
         QAM/Iq6T1mqR8ipS6vbD+n/Cw2LN5KgaIsR8DDNX9ifziqhRcs2T9tYwS/U4va0jkF/J
         hK6DlGVogBG0/14mtHUBemVSQ5vR3f77rdzuDWl2sgfsQEhWzzkCdpIGuCVA1qiR2KkP
         Ge5GLzx/jZHfH+aTp6+tHYruku2/boe0iyUQ+YBiLPEkkyLHesICZuFqPMYNBaudwSrn
         NfaR/5wpkMteSdXuS4khxZ/Pd9J1dz50q8+vKcFnh4gy/JxTaqn9xmdc4fNaf8wBa3oi
         LT+w==
X-Gm-Message-State: ANoB5pn1G+NTtjyIxr1aeDnvr9WCO4ihacpDdOxL5nKDXvhD0IEo/Dwx
        an0YLg30Ij6Zruy6xZWoMTAh
X-Google-Smtp-Source: AA0mqf5hFnkUXVo+vdM3VDHzLmg2q/5j919gGR+C3XPOU6JNyY49X3EjjiYNkf/Kzh+HWxwioaFCjQ==
X-Received: by 2002:a63:545d:0:b0:476:d44d:358 with SMTP id e29-20020a63545d000000b00476d44d0358mr72628703pgm.521.1670230746520;
        Mon, 05 Dec 2022 00:59:06 -0800 (PST)
Received: from localhost ([101.229.232.206])
        by smtp.gmail.com with ESMTPSA id e4-20020a056a0000c400b0057709fce782sm910735pfj.54.2022.12.05.00.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 00:59:06 -0800 (PST)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, tglx@linutronix.de, hch@lst.de
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/11] vduse: Support automatic irq callback affinity
Date:   Mon,  5 Dec 2022 16:58:41 +0800
Message-Id: <20221205085846.741-1-xieyongji@bytedance.com>
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

This brings current interrupt affinity spreading mechanism
to vduse device. We will make use of irq_create_affinity_masks()
to create an irq callback affinity mask for each virtqueue of
vduse device. Then we will choose the CPU which has the lowest
number of interrupt allocated in the affinity mask to run the
irq callback.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 50 ++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index d126f3e32a20..90c2896039d9 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -23,6 +23,7 @@
 #include <linux/nospec.h>
 #include <linux/vmalloc.h>
 #include <linux/sched/mm.h>
+#include <linux/interrupt.h>
 #include <uapi/linux/vduse.h>
 #include <uapi/linux/vdpa.h>
 #include <uapi/linux/virtio_config.h>
@@ -58,6 +59,8 @@ struct vduse_virtqueue {
 	struct work_struct inject;
 	struct work_struct kick;
 	int irq_effective_cpu;
+	struct cpumask irq_affinity;
+	spinlock_t irq_affinity_lock;
 };
 
 struct vduse_dev;
@@ -123,6 +126,7 @@ struct vduse_control {
 
 static DEFINE_MUTEX(vduse_lock);
 static DEFINE_IDR(vduse_idr);
+static DEFINE_PER_CPU(unsigned long, vduse_allocated_irq);
 
 static dev_t vduse_major;
 static struct class *vduse_class;
@@ -710,6 +714,49 @@ static u32 vduse_vdpa_get_generation(struct vdpa_device *vdpa)
 	return dev->generation;
 }
 
+static void vduse_vq_update_effective_cpu(struct vduse_virtqueue *vq)
+{
+	unsigned int cpu, best_cpu;
+	unsigned long allocated, allocated_min = UINT_MAX;
+
+	spin_lock(&vq->irq_affinity_lock);
+
+	best_cpu = vq->irq_effective_cpu;
+	if (best_cpu != -1)
+		per_cpu(vduse_allocated_irq, best_cpu) -= 1;
+
+	for_each_cpu(cpu, &vq->irq_affinity) {
+		allocated = per_cpu(vduse_allocated_irq, cpu);
+		if (!cpu_online(cpu) || allocated >= allocated_min)
+			continue;
+
+		best_cpu = cpu;
+		allocated_min = allocated;
+	}
+	vq->irq_effective_cpu = best_cpu;
+	per_cpu(vduse_allocated_irq, best_cpu) += 1;
+
+	spin_unlock(&vq->irq_affinity_lock);
+}
+
+static void vduse_vdpa_set_irq_affinity(struct vdpa_device *vdpa,
+					struct irq_affinity *desc)
+{
+	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
+	struct irq_affinity_desc *affd = NULL;
+	int i;
+
+	affd = irq_create_affinity_masks(dev->vq_num, desc);
+	if (!affd)
+		return;
+
+	for (i = 0; i < dev->vq_num; i++) {
+		cpumask_copy(&dev->vqs[i]->irq_affinity, &affd[i].mask);
+		vduse_vq_update_effective_cpu(dev->vqs[i]);
+	}
+	kfree(affd);
+}
+
 static int vduse_vdpa_set_map(struct vdpa_device *vdpa,
 				unsigned int asid,
 				struct vhost_iotlb *iotlb)
@@ -760,6 +807,7 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
 	.get_config		= vduse_vdpa_get_config,
 	.set_config		= vduse_vdpa_set_config,
 	.get_generation		= vduse_vdpa_get_generation,
+	.set_irq_affinity	= vduse_vdpa_set_irq_affinity,
 	.reset			= vduse_vdpa_reset,
 	.set_map		= vduse_vdpa_set_map,
 	.free			= vduse_vdpa_free,
@@ -1380,6 +1428,8 @@ static int vduse_dev_init_vqs(struct vduse_dev *dev, u32 vq_align, u32 vq_num)
 		INIT_WORK(&dev->vqs[i]->kick, vduse_vq_kick_work);
 		spin_lock_init(&dev->vqs[i]->kick_lock);
 		spin_lock_init(&dev->vqs[i]->irq_lock);
+		spin_lock_init(&dev->vqs[i]->irq_affinity_lock);
+		cpumask_setall(&dev->vqs[i]->irq_affinity);
 	}
 
 	return 0;
-- 
2.20.1


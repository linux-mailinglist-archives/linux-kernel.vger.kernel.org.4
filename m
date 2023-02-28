Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD73E6A5611
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 10:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjB1Jnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 04:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjB1JnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 04:43:13 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA41B2CFC0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 01:42:41 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id y15-20020a17090aa40f00b00237ad8ee3a0so8976656pjp.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 01:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ly2xpCqkDa3VUqVVIz1pS+ZMFDIGwE7D0BD8n/b68po=;
        b=XN3F1rzbLnKWrDsYwKtpbWWtg91kAAGOspI+8XNv22TRjz680IynDquIOKQyxB7Hi+
         O3EEWcSJN7wC82vL6JNMzDjk9K6lDOoXR0kbhg3xfXi4ibUOxSKFBdMYjIgh7rUGyi1A
         TmHiiYrtINUv5fJtPVdXIEa08w0Fgh1Dzsnp5mXRsFFnorRPUtJ5DYUiaHxQfYZsN4Gx
         Q/8WXAllv/BftZL36sTc8LtzSyVLuOtwJlt/5c/y5knAK/+jFOqu8IRfds+VHbeEbAJr
         cGSlOZ1Kazfx60IIMbddIVvwn7G+swqkJMn3TJo4m3lkwaR6FRb1HISRau7Z/CxEhOB6
         Gi0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ly2xpCqkDa3VUqVVIz1pS+ZMFDIGwE7D0BD8n/b68po=;
        b=Lq5vTtE83D/cMUSGSKtunGjeCIo+qVAGwLDEVt5aNihRGl5NyEUIN0629ewmZAFZ6x
         DPwVhkup+rf+CxWofY7UHuRYET3yD7cOOVJrwOPR0m5X7PtLXCdBt/gTZzUJLc86cotl
         mpDrNlLJxMgu9w2mJQcT4ImNTrLMMsCTdnE5spfkNgghZTd1bGMc3WKUq5THXTy4LpLy
         We97et1P0Iy6Xl15Qof9Q36bVzRs8R0w0EoXjEv+L3qLNjBxS7M+drZ3CrwcTqO3weua
         NT1hf5QIXZy2V8Atc7QiYAWpZENQ9ynz1N+Im6mjsKc83O/k6Ggwe8kPm7xvjP1579QT
         Lq2g==
X-Gm-Message-State: AO0yUKWJ1Kl+3CxSmXTWBlai2TCwnFEK2HRwpLoyIJZlJrKYLbMnK6P+
        in23zpARjcbIJGD1SKVaksw8Ol0Bm0MnFMQ=
X-Google-Smtp-Source: AK7set9ZncnIuyhPuckSPhZTvvuTfcJ63cX5OC6JvKKkEaxvOek2mn1zFkW2AAsa6GC9xz4FKGaBTg==
X-Received: by 2002:a17:902:d483:b0:19c:1904:4490 with SMTP id c3-20020a170902d48300b0019c19044490mr2622502plg.63.1677577361211;
        Tue, 28 Feb 2023 01:42:41 -0800 (PST)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id x18-20020a170902ea9200b00198fde9178csm6085550plb.197.2023.02.28.01.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 01:42:40 -0800 (PST)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, tglx@linutronix.de, hch@lst.de
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/11] vduse: Signal interrupt's eventfd directly in vhost-vdpa case
Date:   Tue, 28 Feb 2023 17:41:08 +0800
Message-Id: <20230228094110.37-10-xieyongji@bytedance.com>
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

Now the vdpa callback will associate an eventfd in
vhost-vdpa case. For performance reasons, VDUSE can
signal it directly during irq injection.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 869cc7860d82..56f3c2480c2a 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -461,6 +461,7 @@ static void vduse_dev_reset(struct vduse_dev *dev)
 		spin_lock(&vq->irq_lock);
 		vq->cb.callback = NULL;
 		vq->cb.private = NULL;
+		vq->cb.irq_ctx = NULL;
 		spin_unlock(&vq->irq_lock);
 		flush_work(&vq->inject);
 		flush_work(&vq->kick);
@@ -526,6 +527,7 @@ static void vduse_vdpa_set_vq_cb(struct vdpa_device *vdpa, u16 idx,
 	spin_lock(&vq->irq_lock);
 	vq->cb.callback = cb->callback;
 	vq->cb.private = cb->private;
+	vq->cb.irq_ctx = cb->irq_ctx;
 	spin_unlock(&vq->irq_lock);
 }
 
@@ -1020,6 +1022,20 @@ static void vduse_vq_irq_inject(struct work_struct *work)
 	spin_unlock_irq(&vq->irq_lock);
 }
 
+static bool vduse_vq_signal_irqfd(struct vduse_virtqueue *vq)
+{
+	bool signal = false;
+
+	spin_lock_irq(&vq->irq_lock);
+	if (vq->ready && vq->cb.irq_ctx) {
+		eventfd_signal(vq->cb.irq_ctx, 1);
+		signal = true;
+	}
+	spin_unlock_irq(&vq->irq_lock);
+
+	return signal;
+}
+
 static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
 				    struct work_struct *irq_work,
 				    int irq_effective_cpu)
@@ -1322,11 +1338,14 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 		if (index >= dev->vq_num)
 			break;
 
+		ret = 0;
 		index = array_index_nospec(index, dev->vq_num);
-
-		vduse_vq_update_effective_cpu(dev->vqs[index]);
-		ret = vduse_dev_queue_irq_work(dev, &dev->vqs[index]->inject,
-					dev->vqs[index]->irq_effective_cpu);
+		if (!vduse_vq_signal_irqfd(dev->vqs[index])) {
+			vduse_vq_update_effective_cpu(dev->vqs[index]);
+			ret = vduse_dev_queue_irq_work(dev,
+						&dev->vqs[index]->inject,
+						dev->vqs[index]->irq_effective_cpu);
+		}
 		break;
 	}
 	case VDUSE_IOTLB_REG_UMEM: {
-- 
2.20.1


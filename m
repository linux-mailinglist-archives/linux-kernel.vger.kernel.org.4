Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109576C5EF0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 06:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjCWFdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 01:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjCWFcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 01:32:36 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D503331BFF
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 22:31:43 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id q102so6022693pjq.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 22:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1679549501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3L8PmXiSvjLVceUhGVSQ/YpVSqRUm7l08t6hYdW7rQ=;
        b=ZcREzIu7n87MPds+0JEnBXyCnfjLevqaZTyGPMTWqzFXLsm9zhW/EGCBw9+75/b7uA
         dDwbU0gBfmuhRD/k48xb1fwWQd7/nBUoyYOHx0NhuBkIjegKc/UfcOdUDMyVUUejofDm
         N0muRXClPNJdvCQPhQYzbD75+0Sv8I2m8KzPFX0A6gVyDxkr1Cdl8W42Is3gUmgasZST
         nwXCw9TipfhS0fU09I3ioxtyd67i8pbD1e9ijFQ0P2NtOlYXrufpCROOS16eT2fa/XYQ
         W9B/lzynns5i8E/1983hOL2a1CT8jKJPwyXiNw9cNi1natn8lwssfDXpXpXJtHCd3E68
         89xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679549501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z3L8PmXiSvjLVceUhGVSQ/YpVSqRUm7l08t6hYdW7rQ=;
        b=3tzMZ3pug3ILlRovAi0qrefsmpCxFb6FZr+90gyolg95OSbsroyfFkcR16nTULFSd8
         ymsHaiD0kxcCKHK9bvAbVZbJIjjyVjstVJWcpUV+ilocrfI3aOed23jb7gx/YLwbaxLN
         jSZZgQfCUGfoVNeFhEILDw1w51vqA+u4iBfaQc9geHKXk3YDSd19teDLQx9Tyiw91BrA
         dU5JFbcbZGKcm3TEmKnQm7pWt9uHHCx852mQfab0n3/J3XtK6LNTPTtTm7O9YgB6nX1k
         bnNVFW4Zm4Jo4wUNKiTjRt09P2aXnK3GB1UcJp1EpjV1lrAp2SbXF+o3HC7mjNUF6jj7
         FZZQ==
X-Gm-Message-State: AO0yUKUGVHYx0C1oceAS9EySSTGPgdfrdM6EO9nbQzc/HtigMgJcpBVs
        tQ575emDZphJgM8XBoJ2jEdt
X-Google-Smtp-Source: AK7set9j0u8vFU3yXople0gqTw5etOUHxcdupDqHdy2cWkGsMZLgrBTd0eeRlM7gq5+XrC1sCxtD4w==
X-Received: by 2002:a17:902:6944:b0:1a1:b3bb:cd5b with SMTP id k4-20020a170902694400b001a1b3bbcd5bmr4657750plt.62.1679549501430;
        Wed, 22 Mar 2023 22:31:41 -0700 (PDT)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902854900b0019c90f8c831sm11419677plo.242.2023.03.22.22.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 22:31:41 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, tglx@linutronix.de, hch@lst.de
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 09/11] vduse: Signal vq trigger eventfd directly if possible
Date:   Thu, 23 Mar 2023 13:30:41 +0800
Message-Id: <20230323053043.35-10-xieyongji@bytedance.com>
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

Now the vdpa callback will associate an trigger
eventfd in some cases. For performance reasons,
VDUSE can signal it directly during irq injection.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 77da3685568a..8c06f6ab960b 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -459,6 +459,7 @@ static void vduse_dev_reset(struct vduse_dev *dev)
 		spin_lock(&vq->irq_lock);
 		vq->cb.callback = NULL;
 		vq->cb.private = NULL;
+		vq->cb.trigger = NULL;
 		spin_unlock(&vq->irq_lock);
 		flush_work(&vq->inject);
 		flush_work(&vq->kick);
@@ -524,6 +525,7 @@ static void vduse_vdpa_set_vq_cb(struct vdpa_device *vdpa, u16 idx,
 	spin_lock(&vq->irq_lock);
 	vq->cb.callback = cb->callback;
 	vq->cb.private = cb->private;
+	vq->cb.trigger = cb->trigger;
 	spin_unlock(&vq->irq_lock);
 }
 
@@ -941,6 +943,23 @@ static void vduse_vq_irq_inject(struct work_struct *work)
 	spin_unlock_irq(&vq->irq_lock);
 }
 
+static bool vduse_vq_signal_irqfd(struct vduse_virtqueue *vq)
+{
+	bool signal = false;
+
+	if (!vq->cb.trigger)
+		return false;
+
+	spin_lock_irq(&vq->irq_lock);
+	if (vq->ready && vq->cb.trigger) {
+		eventfd_signal(vq->cb.trigger, 1);
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
@@ -1243,11 +1262,14 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
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


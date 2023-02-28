Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743E06A5610
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 10:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjB1JnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 04:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjB1JnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 04:43:07 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BE62BF3F
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 01:42:38 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id u3-20020a17090a450300b00239db6d7d47so1896806pjg.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 01:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fwy2X+T9chZ+5E4FxXuZFD79e/GDnXtVfCKv0Zjao+M=;
        b=jPaZx6FGDOnufngtQJs1CiF5uSwt3y/7YA6kvxHdmJgkmE/5wMiCxi0w8w5IPdsqju
         Dr5Gyw2DOq1Ju5u/eEX3lfLM8AmYZeLkCmsh/CLI+NgOMtrJtTvfKACUtsRf7Twr+N8n
         DZTBXIRcVgseIXNnmxfknJ5hBHTvrugOkiG5yeHDY54a4u3cNLSR8P3m/WoB2NYLb28z
         jJkvMTTI8x3YIKBFw822javuDEecXShcaINxzGoNWsJ77Cjyhxlu40U0a8g9UfNk9Fc9
         X8vNY2K3GL2Yr/JR9HDBRcMwuV7zzSoPMFiNy5bB5bnbjjUSgymJ9xYMKuqrRwGk0dFX
         SwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fwy2X+T9chZ+5E4FxXuZFD79e/GDnXtVfCKv0Zjao+M=;
        b=UcSFOeTYDbWuBnAzK5MKoYfQ+1WJDIjd8ywqHMRZDeGQl2cpbD604HkzydyLArnst+
         6ym4pE/8hz+gib+vKfCNbcj7+xI4OnHqzCJvFaYsEHWER5kfq6ON5O9JERNKHB/6m+0E
         5ctJT4dIqw9DWNtU3+JIYrXmz19fyefXUrpKl9HB4V7LA+rZs9rxGNbsGmzri0hH5gHG
         kEe4XjeuLXnsXdkpXmPj1zj6KHSxRBwHQfFyRTkYMFvsIKxndx5qnN1DNEuw2vddO4ei
         X2DRrz6FIW3xhmUHf7zvPZWfFd7t7eVbTzWjG0pB9bgGz7maXiAXxxl1BMfC2wsIP7j4
         1cPw==
X-Gm-Message-State: AO0yUKXfq3zRiS5lVWASxXBC2ER1H3Ljsg1697S22KgXvRr0K5sxY4HI
        GzhxxXcdUMR1l7bVVMVwd0Tn
X-Google-Smtp-Source: AK7set8ktea2NbLFir6Qw+4FmjTJlMfZQqklYWaMW6TN5etaTWF3fxk2zflJeZCnsfJ2hNn0wPQHKQ==
X-Received: by 2002:a17:902:e543:b0:19d:62b:f040 with SMTP id n3-20020a170902e54300b0019d062bf040mr2660180plf.37.1677577357568;
        Tue, 28 Feb 2023 01:42:37 -0800 (PST)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id a23-20020a170902b59700b001993a1fce7bsm6042978pls.196.2023.02.28.01.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 01:42:37 -0800 (PST)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, tglx@linutronix.de, hch@lst.de
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/11] vdpa: Add eventfd for the vdpa callback
Date:   Tue, 28 Feb 2023 17:41:07 +0800
Message-Id: <20230228094110.37-9-xieyongji@bytedance.com>
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

Add eventfd for the vdpa callback so that user
can signal it directly instead of running the
callback. It will be used for vhost-vdpa case.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/vhost/vdpa.c         | 2 ++
 drivers/virtio/virtio_vdpa.c | 1 +
 include/linux/vdpa.h         | 3 +++
 3 files changed, 6 insertions(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index dc12dbd5b43b..ae89c0ccc2bb 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -599,9 +599,11 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 		if (vq->call_ctx.ctx) {
 			cb.callback = vhost_vdpa_virtqueue_cb;
 			cb.private = vq;
+			cb.irq_ctx = vq->call_ctx.ctx;
 		} else {
 			cb.callback = NULL;
 			cb.private = NULL;
+			cb.irq_ctx = NULL;
 		}
 		ops->set_vq_cb(vdpa, idx, &cb);
 		vhost_vdpa_setup_vq_irq(v, idx);
diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index 9eee8afabda8..a5cecafbc2d1 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -195,6 +195,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 	/* Setup virtqueue callback */
 	cb.callback = callback ? virtio_vdpa_virtqueue_cb : NULL;
 	cb.private = info;
+	cb.irq_ctx = NULL;
 	ops->set_vq_cb(vdpa, index, &cb);
 	ops->set_vq_num(vdpa, index, virtqueue_get_vring_size(vq));
 
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 10bd22387276..94a7ec49583a 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -13,10 +13,13 @@
  * struct vdpa_calllback - vDPA callback definition.
  * @callback: interrupt callback function
  * @private: the data passed to the callback function
+ * @irq_ctx: the eventfd for the callback, user can signal
+ *           it directly instead of running the callback
  */
 struct vdpa_callback {
 	irqreturn_t (*callback)(void *data);
 	void *private;
+	struct eventfd_ctx *irq_ctx;
 };
 
 /**
-- 
2.20.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5576C5EF3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 06:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjCWFdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 01:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjCWFcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 01:32:55 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBD43252C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 22:31:39 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id a16so16172495pjs.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 22:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1679549498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MgyyzGdPYlLmRb+LUWqhPpBI8LjddO/ZyliZeTEMlT4=;
        b=R51Z7g8eJ5Fc1tp1TH+HFYbvpmoLVJ5oZcRDp7my9huauSYN/wOxi6RF7q1p1s/LGq
         oIQMTHofE0VcWFzMzZy5jAEg1fmofuXjG79p+0c4WbJyo3A9hlrurDSvx+TlsgOgU7RL
         nC/Uvxq7f9IoFYsm5pnJw1mSjtc7yZtQYftbbcDcAV3UZ+0Z0A+8vl3Eztx9yaywJUO/
         QlCwGZezutqsBHkrLch0kUUl1x24GgMRfO+EFelgH8pJAQazBzdK/dkTZMf03juzVRVJ
         FamN5U2qDZQJf/IoRKFAwQ9wPpXDdid9G0pOwqrvkkKuBNpTv8bNJD+QTNCljiE+PovE
         mHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679549498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MgyyzGdPYlLmRb+LUWqhPpBI8LjddO/ZyliZeTEMlT4=;
        b=I4iynMXjauq8uo47i2QtSAKfS/OuzHP2l46PjGrTxLYG2nZCTlKk7GfuHnbUmHhC58
         Lzy3ho+O9UkUnEFSM1+oTkJk8Fi7/jsgkVEzoai6Iq3eYrt9+BzZrjPZruV0mmNXTIl8
         pD+GOYib3YrYUUHiSFAJt2lW6oRLI/zhWi2hmfNaK0RtE6H4R/xHIujthHrfTqv78cqt
         707PTurnQXezFiFxf314S+VzQ09EjWXkyuf2BoQGJN3xL1ECkaeRKVZBhKjSYLYjVkLr
         ZUxArAK0nZYoh9TNdBTCdqxZOwup1D2bkvf9d87AKK/BXa6PxzqBBJgBOj2hZUKpEHFd
         hPtQ==
X-Gm-Message-State: AAQBX9ekgRZE5CXTvzAb8ECMjIvFoWvDsLbyJ2ZPMm0UYsV7KDIcwgTO
        AYGANbDo7sIZQnBNmu4soyBX
X-Google-Smtp-Source: AKy350YH4px/fpfENAFTMoaGx+h1YxxTfp/WcYOoA1qdOpbddjBgxe6xmwp46FWXLt4f59PccvHRQQ==
X-Received: by 2002:a17:90a:1608:b0:240:1e0b:a7b7 with SMTP id n8-20020a17090a160800b002401e0ba7b7mr1863560pja.39.1679549498150;
        Wed, 22 Mar 2023 22:31:38 -0700 (PDT)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id d9-20020a17090a6a4900b0023c8a23005asm432283pjm.49.2023.03.22.22.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 22:31:37 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, tglx@linutronix.de, hch@lst.de
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 08/11] vdpa: Add eventfd for the vdpa callback
Date:   Thu, 23 Mar 2023 13:30:40 +0800
Message-Id: <20230323053043.35-9-xieyongji@bytedance.com>
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

Add eventfd for the vdpa callback so that user
can signal it directly instead of triggering the
callback. It will be used for vhost-vdpa case.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/vhost/vdpa.c         | 2 ++
 drivers/virtio/virtio_vdpa.c | 1 +
 include/linux/vdpa.h         | 6 ++++++
 3 files changed, 9 insertions(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 7be9d9d8f01c..9cd878e25cff 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -599,9 +599,11 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 		if (vq->call_ctx.ctx) {
 			cb.callback = vhost_vdpa_virtqueue_cb;
 			cb.private = vq;
+			cb.trigger = vq->call_ctx.ctx;
 		} else {
 			cb.callback = NULL;
 			cb.private = NULL;
+			cb.trigger = NULL;
 		}
 		ops->set_vq_cb(vdpa, idx, &cb);
 		vhost_vdpa_setup_vq_irq(v, idx);
diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index f3826f42b704..2a095f37f26b 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -196,6 +196,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 	/* Setup virtqueue callback */
 	cb.callback = callback ? virtio_vdpa_virtqueue_cb : NULL;
 	cb.private = info;
+	cb.trigger = NULL;
 	ops->set_vq_cb(vdpa, index, &cb);
 	ops->set_vq_num(vdpa, index, virtqueue_get_vring_size(vq));
 
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index e52c9a37999c..0372b2e3d38a 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -13,10 +13,16 @@
  * struct vdpa_calllback - vDPA callback definition.
  * @callback: interrupt callback function
  * @private: the data passed to the callback function
+ * @trigger: the eventfd for the callback (Optional).
+ *           When it is set, the vDPA driver must guarantee that
+ *           signaling it is functional equivalent to triggering
+ *           the callback. Then vDPA parent can signal it directly
+ *           instead of triggering the callback.
  */
 struct vdpa_callback {
 	irqreturn_t (*callback)(void *data);
 	void *private;
+	struct eventfd_ctx *trigger;
 };
 
 /**
-- 
2.20.1


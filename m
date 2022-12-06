Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CC4643FF7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 10:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbiLFJja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 04:39:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234957AbiLFJjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 04:39:25 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634B81D0CB
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 01:39:23 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id y25so550314lfa.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 01:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yFc2eJVqHcILb5tFkpDwv7IVs2FB1/IIl0iM/zEMppo=;
        b=pU4OP9p9F+OHG7qupD3P8uyksEhCnxPlXzc2xK1doegNJ/HRKlLlnQz6iIXjYKT0dW
         /7EX+tBt5pmh0aLUN/sLscnaWI4BQiiXQe7C/2OYJvHo7PctX3NwA8qCyr6zGgZSpw3/
         08LgNHUYNf1Rw8FWSyLMxhE1DyuFeSa/qGkdo12eNy14sWI8L6ioBmkd3GDYXG7Gp00o
         6uaFWBH3A2O5i2bToT8JYL4Psexk0zxJEy9LVXQkTOgG+al8y5lG36DEvpaHvYQNt62t
         pL+K4fJTsDnxZLqgB6PAadHkTyLUmRswaTofJ7fGfJQMuv8+RhG6uNoDw0BxVzpS3UBd
         eqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yFc2eJVqHcILb5tFkpDwv7IVs2FB1/IIl0iM/zEMppo=;
        b=lZRpIxYKrfPf/EL18MakoLoEgI4LsDGnBJolZ6M2qmnl8QbuqpDgpMXHY0XexSn5xU
         2FCAHEpjUPP3U6OAKKLQ/RQ2KF2RL1q2UgoqJpTiglvkjGE/V4Z23fNUdueSNJzUpVb6
         P2AJJ4FKW/BcSog7S5e6r+nK9Ty17CEVpRKzDBZIwYZbT+UQQYOpwQzBKPGEeXmy+ee2
         SSpyEqT42lrE2gMiyRN8CrI1beL4ij7RjNYCXRVklwwX8VYzjmo6hgrHdlQ8x7TAvMql
         KCt4xilj1sdA6uG2jm99GKbbbN4MpcClAIGPXpsOOyEdwsokUGwwj2HmvIJc1btZfyY0
         472A==
X-Gm-Message-State: ANoB5pnSqr4lRQ5QwW/u4n6qOGgKRmfCfeZvYk20yHr8L0RXAdwWcK5x
        OpjFFo1gld3t/+itHQpnFs5hmQ==
X-Google-Smtp-Source: AA0mqf4F1Jkzi6oqTTO2ABvBXReofhL02v26NcvCZ7zcYjeujELxBTeV3pbRcgbj/6z09CIpfYanDA==
X-Received: by 2002:ac2:545b:0:b0:4af:ad16:8a08 with SMTP id d27-20020ac2545b000000b004afad168a08mr24831100lfn.664.1670319561529;
        Tue, 06 Dec 2022 01:39:21 -0800 (PST)
Received: from localhost.localdomain ([91.216.213.152])
        by smtp.gmail.com with ESMTPSA id k26-20020ac2457a000000b0049462af8614sm2415833lfm.145.2022.12.06.01.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 01:39:21 -0800 (PST)
From:   Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rpmsg: char: Use preallocated SKBs.
Date:   Tue,  6 Dec 2022 10:38:41 +0100
Message-Id: <20221206093840.32181-1-piotr.wojtaszczyk@timesys.com>
X-Mailer: git-send-email 2.38.1
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

On a message reception copy the message to a SKB taken from preallocated
pool instead of allocating a new SKB each time.
During high rpmsg traffic this reduces consumed CPU time noticeably.

Signed-off-by: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
---
 drivers/rpmsg/rpmsg_char.c       | 46 +++++++++++++++++++++++++++++---
 drivers/rpmsg/rpmsg_internal.h   | 21 +++++++++++++++
 drivers/rpmsg/virtio_rpmsg_bus.c | 21 ---------------
 3 files changed, 64 insertions(+), 24 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
index 3e0b8f3496ed..51b1b077687e 100644
--- a/drivers/rpmsg/rpmsg_char.c
+++ b/drivers/rpmsg/rpmsg_char.c
@@ -66,10 +66,37 @@ struct rpmsg_eptdev {
 
 	spinlock_t queue_lock;
 	struct sk_buff_head queue;
+	struct sk_buff_head skb_pool;
 	wait_queue_head_t readq;
 
 };
 
+static inline
+struct sk_buff *rpmsg_eptdev_get_skb(struct rpmsg_eptdev *eptdev)
+{
+	struct sk_buff *skb;
+
+	skb = skb_dequeue(&eptdev->skb_pool);
+	if (!skb)
+		skb = alloc_skb(MAX_RPMSG_BUF_SIZE, GFP_ATOMIC);
+	return skb;
+}
+
+static inline
+void rpmsg_eptdev_put_skb(struct rpmsg_eptdev *eptdev, struct sk_buff *skb)
+{
+	/* Recycle the skb */
+	skb->tail = 0;
+	skb->len = 0;
+	skb_queue_head(&eptdev->skb_pool, skb);
+}
+
+static void rpmsg_eptdev_free_all_skb(struct rpmsg_eptdev *eptdev)
+{
+	skb_queue_purge(&eptdev->queue);
+	skb_queue_purge(&eptdev->skb_pool);
+}
+
 int rpmsg_chrdev_eptdev_destroy(struct device *dev, void *data)
 {
 	struct rpmsg_eptdev *eptdev = dev_to_eptdev(dev);
@@ -99,7 +126,7 @@ static int rpmsg_ept_cb(struct rpmsg_device *rpdev, void *buf, int len,
 	struct rpmsg_eptdev *eptdev = priv;
 	struct sk_buff *skb;
 
-	skb = alloc_skb(len, GFP_ATOMIC);
+	skb = rpmsg_eptdev_get_skb(eptdev);
 	if (!skb)
 		return -ENOMEM;
 
@@ -121,6 +148,18 @@ static int rpmsg_eptdev_open(struct inode *inode, struct file *filp)
 	struct rpmsg_endpoint *ept;
 	struct rpmsg_device *rpdev = eptdev->rpdev;
 	struct device *dev = &eptdev->dev;
+	struct sk_buff *skb;
+	int i;
+
+	/* Preallocate 8 SKBs */
+	for (i = 0; i < 8; i++) {
+		skb = rpmsg_eptdev_get_skb(eptdev);
+		if (!skb) {
+			rpmsg_eptdev_free_all_skb(eptdev);
+			return -ENOMEM;
+		}
+		rpmsg_eptdev_put_skb(eptdev, skb);
+	}
 
 	mutex_lock(&eptdev->ept_lock);
 	if (eptdev->ept) {
@@ -168,7 +207,7 @@ static int rpmsg_eptdev_release(struct inode *inode, struct file *filp)
 	mutex_unlock(&eptdev->ept_lock);
 
 	/* Discard all SKBs */
-	skb_queue_purge(&eptdev->queue);
+	rpmsg_eptdev_free_all_skb(eptdev);
 
 	put_device(dev);
 
@@ -217,7 +256,7 @@ static ssize_t rpmsg_eptdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	if (copy_to_iter(skb->data, use, to) != use)
 		use = -EFAULT;
 
-	kfree_skb(skb);
+	rpmsg_eptdev_put_skb(eptdev, skb);
 
 	return use;
 }
@@ -370,6 +409,7 @@ static struct rpmsg_eptdev *rpmsg_chrdev_eptdev_alloc(struct rpmsg_device *rpdev
 	mutex_init(&eptdev->ept_lock);
 	spin_lock_init(&eptdev->queue_lock);
 	skb_queue_head_init(&eptdev->queue);
+	skb_queue_head_init(&eptdev->skb_pool);
 	init_waitqueue_head(&eptdev->readq);
 
 	device_initialize(dev);
diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
index 39b646d0d40d..b30bfe01db69 100644
--- a/drivers/rpmsg/rpmsg_internal.h
+++ b/drivers/rpmsg/rpmsg_internal.h
@@ -15,6 +15,27 @@
 #include <linux/rpmsg.h>
 #include <linux/poll.h>
 
+/*
+ * We're allocating buffers of 512 bytes each for communications. The
+ * number of buffers will be computed from the number of buffers supported
+ * by the vring, upto a maximum of 512 buffers (256 in each direction).
+ *
+ * Each buffer will have 16 bytes for the msg header and 496 bytes for
+ * the payload.
+ *
+ * This will utilize a maximum total space of 256KB for the buffers.
+ *
+ * We might also want to add support for user-provided buffers in time.
+ * This will allow bigger buffer size flexibility, and can also be used
+ * to achieve zero-copy messaging.
+ *
+ * Note that these numbers are purely a decision of this driver - we
+ * can change this without changing anything in the firmware of the remote
+ * processor.
+ */
+#define MAX_RPMSG_NUM_BUFS	(512)
+#define MAX_RPMSG_BUF_SIZE	(512)
+
 #define to_rpmsg_device(d) container_of(d, struct rpmsg_device, dev)
 #define to_rpmsg_driver(d) container_of(d, struct rpmsg_driver, drv)
 
diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 905ac7910c98..5369669d3327 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -109,27 +109,6 @@ struct virtio_rpmsg_channel {
 #define to_virtio_rpmsg_channel(_rpdev) \
 	container_of(_rpdev, struct virtio_rpmsg_channel, rpdev)
 
-/*
- * We're allocating buffers of 512 bytes each for communications. The
- * number of buffers will be computed from the number of buffers supported
- * by the vring, upto a maximum of 512 buffers (256 in each direction).
- *
- * Each buffer will have 16 bytes for the msg header and 496 bytes for
- * the payload.
- *
- * This will utilize a maximum total space of 256KB for the buffers.
- *
- * We might also want to add support for user-provided buffers in time.
- * This will allow bigger buffer size flexibility, and can also be used
- * to achieve zero-copy messaging.
- *
- * Note that these numbers are purely a decision of this driver - we
- * can change this without changing anything in the firmware of the remote
- * processor.
- */
-#define MAX_RPMSG_NUM_BUFS	(512)
-#define MAX_RPMSG_BUF_SIZE	(512)
-
 /*
  * Local addresses are dynamically allocated on-demand.
  * We do not dynamically assign addresses from the low 1024 range,
-- 
2.38.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B29C643F0A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 09:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbiLFIun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 03:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234272AbiLFIud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 03:50:33 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753E218E2E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 00:50:31 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id cf42so16814973lfb.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 00:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EbhyIR5iqOHGIwbpWPeuDBH9qoKo5A/INqe+aQ5y4vo=;
        b=5NGK/yeiJ0K6G5YOutDLflZmhU/ZvdLbI7KsGD9KQwuSRwHBlgc+hcoXLdfLslQKlk
         XZB92ji5j+hXYfzjV6yveuKkMB4XAjNHN2RMBYfwWabNR+hF/m7AMrrmEl1o2rye5BjM
         Lo3NU8DaFvgzgdxqZv9grCTWun77NuIXzQEfUf0QXBxhKVmPKb2n9IXqMYvT1lYmamN+
         agy9TU4oHjQO7asyx0Mup87TOAPgVMK6BoNEUngrcaHmQTCv4j0k6uQXDGqF86D9kKh7
         Hp31MKtOLgf1Vsu/cCJgfZ8oA3C2t8BjMaLTfo5X1Sw4JdqR6o1Oyz7jwpeVO0wciaum
         hBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EbhyIR5iqOHGIwbpWPeuDBH9qoKo5A/INqe+aQ5y4vo=;
        b=jgFyU26bO98FdAUr4X5BwWXm6h67t7xsyO55qLpc7IOzlaG+De5FtDp7KLhAmaKQVM
         DxY119pFpW15p7VyrCxEbpxgPtjA1C4YwXpQY/ZNcgRGG1O0uaoBf6CMJaJJKdmaW2XK
         0TpPaBaAv0r1pDaClA+wqEv87f4mzupr+uVrl1FjdCWEEcaxoMK23UWejKkI2n9wAWzH
         37bds84z1Rg6V/LBrZM8V012KBZvo/kUG08uUJf/dkBO6ashtWUXTzt3DVWuqbuXivfx
         oalhz3pqIWNi8fM2ZH9nG0uN1AYwqzvChMUOXrvRQ6h5XGpEXRNm7AA3aRdtHoNuis3O
         0UpA==
X-Gm-Message-State: ANoB5plCAiUoqQGhL4qGN3beCjUXmwQaMbOkV4SoSSXBereYCScD9Amf
        qMhHXIhWIk8jH8+iSvd9bNQbeg==
X-Google-Smtp-Source: AA0mqf4wpY92b8b9H+cbs8Ud1iTWWobIal0QmagWuTV4S8YirCzVn85vCbJNiW4nOtDloiErrWqmzA==
X-Received: by 2002:a05:6512:10c3:b0:4b5:853b:73d with SMTP id k3-20020a05651210c300b004b5853b073dmr628184lfg.672.1670316629673;
        Tue, 06 Dec 2022 00:50:29 -0800 (PST)
Received: from localhost.localdomain ([91.216.213.152])
        by smtp.gmail.com with ESMTPSA id f28-20020a05651c03dc00b0027730261350sm1578489ljp.131.2022.12.06.00.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 00:50:29 -0800 (PST)
From:   Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rpmsg: char: Use preallocated SKBs.
Date:   Tue,  6 Dec 2022 09:50:07 +0100
Message-Id: <20221206085008.25388-1-piotr.wojtaszczyk@timesys.com>
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
 drivers/rpmsg/rpmsg_char.c       | 58 ++++++++++++++++++++++++++++----
 drivers/rpmsg/rpmsg_internal.h   | 21 ++++++++++++
 drivers/rpmsg/virtio_rpmsg_bus.c | 21 ------------
 3 files changed, 72 insertions(+), 28 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
index ac50ed757765..76546ba72cdc 100644
--- a/drivers/rpmsg/rpmsg_char.c
+++ b/drivers/rpmsg/rpmsg_char.c
@@ -75,9 +75,44 @@ struct rpmsg_eptdev {
 
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
+	struct sk_buff *skb;
+
+	while (!skb_queue_empty(&eptdev->queue)) {
+		skb = skb_dequeue(&eptdev->queue);
+		kfree_skb(skb);
+	}
+	while (!skb_queue_empty(&eptdev->skb_pool)) {
+		skb = skb_dequeue(&eptdev->skb_pool);
+		kfree_skb(skb);
+	}
+}
+
 static int rpmsg_eptdev_destroy(struct device *dev, void *data)
 {
 	struct rpmsg_eptdev *eptdev = dev_to_eptdev(dev);
@@ -104,7 +139,7 @@ static int rpmsg_ept_cb(struct rpmsg_device *rpdev, void *buf, int len,
 	struct rpmsg_eptdev *eptdev = priv;
 	struct sk_buff *skb;
 
-	skb = alloc_skb(len, GFP_ATOMIC);
+	skb = rpmsg_eptdev_get_skb(eptdev);
 	if (!skb)
 		return -ENOMEM;
 
@@ -126,6 +161,18 @@ static int rpmsg_eptdev_open(struct inode *inode, struct file *filp)
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
 
 	get_device(dev);
 
@@ -146,7 +193,6 @@ static int rpmsg_eptdev_release(struct inode *inode, struct file *filp)
 {
 	struct rpmsg_eptdev *eptdev = cdev_to_eptdev(inode->i_cdev);
 	struct device *dev = &eptdev->dev;
-	struct sk_buff *skb;
 
 	/* Close the endpoint, if it's not already destroyed by the parent */
 	mutex_lock(&eptdev->ept_lock);
@@ -157,10 +203,7 @@ static int rpmsg_eptdev_release(struct inode *inode, struct file *filp)
 	mutex_unlock(&eptdev->ept_lock);
 
 	/* Discard all SKBs */
-	while (!skb_queue_empty(&eptdev->queue)) {
-		skb = skb_dequeue(&eptdev->queue);
-		kfree_skb(skb);
-	}
+	rpmsg_eptdev_free_all_skb(eptdev);
 
 	put_device(dev);
 
@@ -209,7 +252,7 @@ static ssize_t rpmsg_eptdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	if (copy_to_iter(skb->data, use, to) != use)
 		use = -EFAULT;
 
-	kfree_skb(skb);
+	rpmsg_eptdev_put_skb(eptdev, skb);
 
 	return use;
 }
@@ -358,6 +401,7 @@ static int rpmsg_eptdev_create(struct rpmsg_ctrldev *ctrldev,
 	mutex_init(&eptdev->ept_lock);
 	spin_lock_init(&eptdev->queue_lock);
 	skb_queue_head_init(&eptdev->queue);
+	skb_queue_head_init(&eptdev->skb_pool);
 	init_waitqueue_head(&eptdev->readq);
 
 	device_initialize(dev);
diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
index 3fc83cd50e98..5acaa54a277a 100644
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
index 3d9e442883e1..6552928a440d 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -133,27 +133,6 @@ struct virtio_rpmsg_channel {
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


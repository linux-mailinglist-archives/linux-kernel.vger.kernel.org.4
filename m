Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45D56A5612
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 10:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbjB1Jnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 04:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbjB1Jn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 04:43:26 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B192DE6C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 01:42:48 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so13019588pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 01:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r5CfE7ygRl6QRb/Gj2o2fNw8BK8ceWBf4KOBuolXf2U=;
        b=gDiWqIT5V8RTGrcADustI0XUwWLOvjOln/IxsavTPX63G5oaPqruNbvgGr1Fzkf+QY
         cfB9dXM2m0LYm7FkTRgnK6wclpwo2qN9xTbsfOHEGvdHLOVp5/vvfSPcvd44OsOkWWxD
         VijXLwBgikzfncnFgaNd1fWcTqPEhpe/IjGvXYFrbr6J/utz5mW3oKaVk//p9hHPbMyV
         qwoSJ7htVj2F8TnWk7wm8knwdwKVUCzTks1WVjwPqqQGi7YbxwGuIxKOnNlimUE+Uf/m
         6FEbUkvHhUVQern56WSQ8hKfTDNPK25iAD6cbWdOKDi/Q2DUc+W0lvEnlQe0GLujrriO
         8zCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r5CfE7ygRl6QRb/Gj2o2fNw8BK8ceWBf4KOBuolXf2U=;
        b=oxv/ZbZrdc6DWkVjliI/5Me0AYCZVFm/tqEQf5JwLUrDlsZClzWt5zT2aG8igf5+3W
         F1rzhf46sPxOSl1FutDJ2S3U/XaInzfoO6Taa65O6fCtceP1JiZM1krw9PGZz1K+gM/R
         mvN2wbH8Kz83+3ws7FooTBksoMNdJ7X9KMaA1wNHESlG9wh3Amf7aNzA9lVkVSD/85r/
         aBZA4780y/CPJd/LY/KBoOiQWztgMfBYxTTYYchERy//ZiNXNY2B7yHMpqts4uPyo+I+
         sdaf6mmlw1XUWMLuKEfgXr2ipZoA51UwoOjCo5vR+Iv4VqMXGgDvbC2ra+vE2syeO7TL
         x7UA==
X-Gm-Message-State: AO0yUKVMfNNFzhMhXKJ9vc6VYZpDGLYjyc7QA3GOC4wBAgcUUHaQ6zlP
        YLZtGNxsnuKhWSb3IrvUNo6U
X-Google-Smtp-Source: AK7set8IYgfcowU9TcF8iddoj24XB5SMXaL5najujz2hKD0+S8OtnwUSu3cKGpZZxMCLcCInfwAZ4A==
X-Received: by 2002:a17:902:7e86:b0:19a:973b:b615 with SMTP id z6-20020a1709027e8600b0019a973bb615mr1735905pla.36.1677577368460;
        Tue, 28 Feb 2023 01:42:48 -0800 (PST)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id s6-20020a17090302c600b00196519d8647sm6178324plk.4.2023.02.28.01.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 01:42:48 -0800 (PST)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, tglx@linutronix.de, hch@lst.de
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/11] vduse: Support specifying bounce buffer size via sysfs
Date:   Tue, 28 Feb 2023 17:41:10 +0800
Message-Id: <20230228094110.37-12-xieyongji@bytedance.com>
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

As discussed in [1], this adds sysfs interface to support
specifying bounce buffer size in virtio-vdpa case. It would
be a performance tuning parameter for high throughput workloads.

[1] https://lore.kernel.org/netdev/e8f25a35-9d45-69f9-795d-bdbbb90337a3@redhat.com/

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 45 +++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 1702565efc82..a0f796d20027 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -39,8 +39,11 @@
 #define DRV_LICENSE  "GPL v2"
 
 #define VDUSE_DEV_MAX (1U << MINORBITS)
+#define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
+#define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
 #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
-#define VDUSE_IOVA_SIZE (128 * 1024 * 1024)
+/* 128 MB reserved for virtqueue creation */
+#define VDUSE_IOVA_SIZE (VDUSE_MAX_BOUNCE_SIZE + 128 * 1024 * 1024)
 #define VDUSE_MSG_DEFAULT_TIMEOUT 30
 
 #define IRQ_UNBOUND -1
@@ -1791,8 +1794,48 @@ static ssize_t msg_timeout_store(struct device *device,
 
 static DEVICE_ATTR_RW(msg_timeout);
 
+static ssize_t bounce_size_show(struct device *device,
+				struct device_attribute *attr, char *buf)
+{
+	struct vduse_dev *dev = dev_get_drvdata(device);
+
+	return sysfs_emit(buf, "%u\n", dev->bounce_size);
+}
+
+static ssize_t bounce_size_store(struct device *device,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	struct vduse_dev *dev = dev_get_drvdata(device);
+	unsigned int bounce_size;
+	int ret;
+
+	ret = -EPERM;
+	mutex_lock(&dev->domain_lock);
+	if (dev->domain)
+		goto unlock;
+
+	ret = kstrtouint(buf, 10, &bounce_size);
+	if (ret < 0)
+		goto unlock;
+
+	ret = -EINVAL;
+	if (bounce_size > VDUSE_MAX_BOUNCE_SIZE ||
+	    bounce_size < VDUSE_MIN_BOUNCE_SIZE)
+		goto unlock;
+
+	dev->bounce_size = bounce_size & PAGE_MASK;
+	ret = count;
+unlock:
+	mutex_unlock(&dev->domain_lock);
+	return ret;
+}
+
+static DEVICE_ATTR_RW(bounce_size);
+
 static struct attribute *vduse_dev_attrs[] = {
 	&dev_attr_msg_timeout.attr,
+	&dev_attr_bounce_size.attr,
 	NULL
 };
 
-- 
2.20.1


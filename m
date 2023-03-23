Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477476C5EF6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 06:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjCWFdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 01:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjCWFdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 01:33:15 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D4421A37
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 22:31:50 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so885571pjt.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 22:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1679549508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7Y4Ia2snWtMWEm2g6DOKe7n5pYzTJA+X6topb6lq9g=;
        b=jLB0M001ArNDXvBdu4Kkz2tvdm0SNwF9y87GgxRVEWG9OfmGbGvycogmZUQ0FSM20K
         XMkCUgjgk7ACFbdaAwoQc0cNGY1c/fK6F58j4XoVaSZCIieE8PLt5w6Hy/qXaCsFpIVw
         peyrCRoYs23OcPOCATbMoxIJUjya3ZGeVTTYS1kQ/x7/A6LXlhbz4LCZ3EdISXDWgj1W
         TiZHNGQoMhosOP9VO4LyWP4H6J+aMQhwOR8MenYmNS0WN21IjVTDyyWxrxH5fB7EXLZl
         ltZC03ojIDGTIJZ1hmMaMUXPyDTbGFapwpSUnEm9FEfQ4ER94vL/o2tBAZ3A4bBosFOa
         ut2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679549508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i7Y4Ia2snWtMWEm2g6DOKe7n5pYzTJA+X6topb6lq9g=;
        b=f6np4QJPIPjJZYISkhdAbyMH0i7IJcq/me97cvO94Z/0r1nHzKypwLpdcJOCOsE22V
         wGxbIwvicfyOoTcdjI6o9mmd36cIDBsftnZXJz0d8lr4saqoohIcmOTs3b/I+lmrjEjZ
         d+et8YXPzhvCxVoY3tv5oM+zGe2zUeDy50xDIQuecTwM0KnyeFZzYQHRMqWq12oYBMpS
         3Y1hIPcMvl7lNodDY8AEp1oulHxXhOSfz/mMzZHAXZGhGStUvlFPRJSfFZ92FwkPUPV0
         1QFvlhXUB3DHEa98Dlvhkh86aIuNTN/Ac8a1vSBO4Bft5h1xaoh+4cnKAOZD+8mqn61w
         PzDQ==
X-Gm-Message-State: AO0yUKU+zAdf/3lXSl9ofAsh3L9JDluoe5egjIWAPgQzLRfNDaQ4+/47
        ZA9y+VTpnNb02T4RxjY/OgE4
X-Google-Smtp-Source: AK7set9/51yM0aVxaZNQN2rRArqiR/Db6qvrFi53YMqjH7lV4qYdK1osZ1GlEo/ayC85k6PO91hrkg==
X-Received: by 2002:a17:90b:1b45:b0:23f:7770:9e75 with SMTP id nv5-20020a17090b1b4500b0023f77709e75mr6342770pjb.47.1679549508205;
        Wed, 22 Mar 2023 22:31:48 -0700 (PDT)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id j12-20020a17090aeb0c00b00230b8431323sm455495pjz.30.2023.03.22.22.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 22:31:47 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, tglx@linutronix.de, hch@lst.de
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/11] vduse: Support specifying bounce buffer size via sysfs
Date:   Thu, 23 Mar 2023 13:30:43 +0800
Message-Id: <20230323053043.35-12-xieyongji@bytedance.com>
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
index ccca84d51a28..34eebdf030af 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -37,8 +37,11 @@
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
@@ -1715,8 +1718,48 @@ static ssize_t msg_timeout_store(struct device *device,
 
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


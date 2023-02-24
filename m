Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74226A22DA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 21:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjBXUCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 15:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjBXUCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 15:02:18 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F0D49897;
        Fri, 24 Feb 2023 12:02:14 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id oe18-20020a17090b395200b00236a0d55d3aso367787pjb.3;
        Fri, 24 Feb 2023 12:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNxsKWr79zliY+Ix7FyHLBv/jvOdd98Ee5355EN3fy4=;
        b=gGd/uI85KYb04kvLuHo/U3vaGipkTP5Igtz7pghi6jAK2g2U3dCXuKlGd/Iewg7ebE
         8b5UL3qPRD8NXeEGMWi5T8o6CaW4PrY+L8CBgtKtYKtNSFa7E/dTy8gptZtOTXcnfred
         Vs5ChmXWcudB31hSkJ9XkeCjl7OvVJZjx5tMdRuHfy2q7v6w+fPNqMokClrujolSostP
         R7c6SuzBK3n3His6ZLP4x/bKzIRKYiJYmVtnL4K89HXwVK5SyXG8aG03G19cUgY4cMdw
         ytDMHCZx7Jam7Yj0GXrWeXWnHgT6++I/IXq9UaRIsxON+f0JsS8sjNmeH7hT9aFJEuQU
         gunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LNxsKWr79zliY+Ix7FyHLBv/jvOdd98Ee5355EN3fy4=;
        b=dJjEYFrM4kFg27wG74ReiuMZXQ/Hz9+hu6/r9YzLkARrE93ZkSnVDODj3U3GuC3gth
         C2q/XeQHyRFi3qmBsezl7d/yCxYvr0WgCb3rJ/JD1t1kQ7/snzK4R9KR+K3W67EKN8/E
         BGZfkCQCXET8EgQe7l/RqfVANioaUby7VkayNcc5aXAh16VEFGteLme2Oi3aM8LPOCCd
         hqoXAmibjzEXbL/egji2EbaNJr4l1XNJGUYt4aQKrTUQSpnRfvU1nPOUBahQP7dVKlEl
         xYQqPhc/6P5Y26yDDYbhCeexFFMW715Pyhc9eBz9GqCytEMDI3TWElAD9mjv6Jf5mFvL
         FpuQ==
X-Gm-Message-State: AO0yUKVMuA9yiOJkTasZJmWBlynkTCcW1MG87YkI1RqtQQoOa9pnP6mQ
        VRUA2ImljpSQZenOBtQHfEkDlGP8VJk=
X-Google-Smtp-Source: AK7set9u7iOupozobrefY1qWVGyPheAVFnYo0Goj6WKGv/KyjEb+VLtJhr+AEqB/SwoWb8A6eNbSNg==
X-Received: by 2002:a17:903:6ce:b0:19c:d4d9:bd with SMTP id kj14-20020a17090306ce00b0019cd4d900bdmr2632453plb.36.1677268933227;
        Fri, 24 Feb 2023 12:02:13 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id p23-20020a170902a41700b0018099c9618esm10978537plq.231.2023.02.24.12.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 12:02:12 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Simon Ser <contact@emersion.fr>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Rob Clark <robdclark@chromium.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        linux-media@vger.kernel.org (open list:SYNC FILE FRAMEWORK),
        linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING
        FRAMEWORK), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 07/15] dma-buf/sw_sync: Add fence deadline support
Date:   Fri, 24 Feb 2023 12:01:35 -0800
Message-Id: <20230224200155.2510320-8-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230224200155.2510320-1-robdclark@gmail.com>
References: <20230224200155.2510320-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

This consists of simply storing the most recent deadline, and adding an
ioctl to retrieve the deadline.  This can be used in conjunction with
the SET_DEADLINE ioctl on a fence fd for testing.  Ie. create various
sw_sync fences, merge them into a fence-array, set deadline on the
fence-array and confirm that it is propagated properly to each fence.

v2: Switch UABI to express deadline as u64
v3: More verbose UAPI docs, show how to convert from timespec

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/dma-buf/sw_sync.c      | 58 ++++++++++++++++++++++++++++++++++
 drivers/dma-buf/sync_debug.h   |  2 ++
 include/uapi/linux/sync_file.h |  6 +++-
 3 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/drivers/dma-buf/sw_sync.c b/drivers/dma-buf/sw_sync.c
index 348b3a9170fa..3e2315ee955b 100644
--- a/drivers/dma-buf/sw_sync.c
+++ b/drivers/dma-buf/sw_sync.c
@@ -52,12 +52,28 @@ struct sw_sync_create_fence_data {
 	__s32	fence; /* fd of new fence */
 };
 
+/**
+ * struct sw_sync_get_deadline - get the deadline hint of a sw_sync fence
+ * @deadline_ns: absolute time of the deadline
+ * @pad:	must be zero
+ * @fence_fd:	the sw_sync fence fd (in)
+ *
+ * The timebase for the deadline is CLOCK_MONOTONIC (same as vblank)
+ */
+struct sw_sync_get_deadline {
+	__u64	deadline_ns;
+	__u32	pad;
+	__s32	fence_fd;
+};
+
 #define SW_SYNC_IOC_MAGIC	'W'
 
 #define SW_SYNC_IOC_CREATE_FENCE	_IOWR(SW_SYNC_IOC_MAGIC, 0,\
 		struct sw_sync_create_fence_data)
 
 #define SW_SYNC_IOC_INC			_IOW(SW_SYNC_IOC_MAGIC, 1, __u32)
+#define SW_SYNC_GET_DEADLINE		_IOWR(SW_SYNC_IOC_MAGIC, 2, \
+		struct sw_sync_get_deadline)
 
 static const struct dma_fence_ops timeline_fence_ops;
 
@@ -171,6 +187,13 @@ static void timeline_fence_timeline_value_str(struct dma_fence *fence,
 	snprintf(str, size, "%d", parent->value);
 }
 
+static void timeline_fence_set_deadline(struct dma_fence *fence, ktime_t deadline)
+{
+	struct sync_pt *pt = dma_fence_to_sync_pt(fence);
+
+	pt->deadline = deadline;
+}
+
 static const struct dma_fence_ops timeline_fence_ops = {
 	.get_driver_name = timeline_fence_get_driver_name,
 	.get_timeline_name = timeline_fence_get_timeline_name,
@@ -179,6 +202,7 @@ static const struct dma_fence_ops timeline_fence_ops = {
 	.release = timeline_fence_release,
 	.fence_value_str = timeline_fence_value_str,
 	.timeline_value_str = timeline_fence_timeline_value_str,
+	.set_deadline = timeline_fence_set_deadline,
 };
 
 /**
@@ -387,6 +411,37 @@ static long sw_sync_ioctl_inc(struct sync_timeline *obj, unsigned long arg)
 	return 0;
 }
 
+static int sw_sync_ioctl_get_deadline(struct sync_timeline *obj, unsigned long arg)
+{
+	struct sw_sync_get_deadline data;
+	struct dma_fence *fence;
+	struct sync_pt *pt;
+
+	if (copy_from_user(&data, (void __user *)arg, sizeof(data)))
+		return -EFAULT;
+
+	if (data.deadline_ns || data.pad)
+		return -EINVAL;
+
+	fence = sync_file_get_fence(data.fence_fd);
+	if (!fence)
+		return -EINVAL;
+
+	pt = dma_fence_to_sync_pt(fence);
+	if (!pt)
+		return -EINVAL;
+
+
+	data.deadline_ns = ktime_to_ns(pt->deadline);
+
+	dma_fence_put(fence);
+
+	if (copy_to_user((void __user *)arg, &data, sizeof(data)))
+		return -EFAULT;
+
+	return 0;
+}
+
 static long sw_sync_ioctl(struct file *file, unsigned int cmd,
 			  unsigned long arg)
 {
@@ -399,6 +454,9 @@ static long sw_sync_ioctl(struct file *file, unsigned int cmd,
 	case SW_SYNC_IOC_INC:
 		return sw_sync_ioctl_inc(obj, arg);
 
+	case SW_SYNC_GET_DEADLINE:
+		return sw_sync_ioctl_get_deadline(obj, arg);
+
 	default:
 		return -ENOTTY;
 	}
diff --git a/drivers/dma-buf/sync_debug.h b/drivers/dma-buf/sync_debug.h
index 6176e52ba2d7..2e0146d0bdbb 100644
--- a/drivers/dma-buf/sync_debug.h
+++ b/drivers/dma-buf/sync_debug.h
@@ -55,11 +55,13 @@ static inline struct sync_timeline *dma_fence_parent(struct dma_fence *fence)
  * @base: base fence object
  * @link: link on the sync timeline's list
  * @node: node in the sync timeline's tree
+ * @deadline: the most recently set fence deadline
  */
 struct sync_pt {
 	struct dma_fence base;
 	struct list_head link;
 	struct rb_node node;
+	ktime_t deadline;
 };
 
 extern const struct file_operations sw_sync_debugfs_fops;
diff --git a/include/uapi/linux/sync_file.h b/include/uapi/linux/sync_file.h
index 49325cf6749b..dc6645b2598b 100644
--- a/include/uapi/linux/sync_file.h
+++ b/include/uapi/linux/sync_file.h
@@ -72,7 +72,11 @@ struct sync_file_info {
  * @deadline_ns: absolute time of the deadline
  * @pad:	must be zero
  *
- * The timebase for the deadline is CLOCK_MONOTONIC (same as vblank)
+ * The timebase for the deadline is CLOCK_MONOTONIC (same as vblank).  For
+ * example:
+ *
+ *     clock_gettime(CLOCK_MONOTONIC, &t);
+ *     deadline_ns = (t.tv_sec * 1000000000L) + t.tv_nsec + duration_ns
  */
 struct sync_set_deadline {
 	__u64	deadline_ns;
-- 
2.39.1


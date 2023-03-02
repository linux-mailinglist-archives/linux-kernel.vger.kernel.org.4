Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071FE6A8D92
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 00:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjCBXyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 18:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjCBXy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 18:54:28 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BFE59E6C;
        Thu,  2 Mar 2023 15:54:15 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id x34so856324pjj.0;
        Thu, 02 Mar 2023 15:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677801254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2i/fpR85GsnM4yvTxGbXQcoI9FVWW3WSsWX/ebUCbg=;
        b=hX79zaQYLdhushZgE5GCBxVIrRIwBhDh2nqI3ggE9QSTHH+J0nrl6T0PoY35zccMuU
         hX+S20CpnmXXkzxXBbr7hc6/gTjn+vyZ+US8C3t5+zbp8bnR0ZgPHDc6L9du1r84B9i2
         otn4tpdcPX80hGvzjIvI44OxqY82h339d1laK4TddPx4/I7/sThvNig/a9zt5buqR/HH
         bkO8gbLcpv6IyT0TzIlzv8dhyZjemYmM94M8clpJ5RV50JadB2hTsNTp+hi7K7l4LmLM
         k+hNhZX5NxLNHrds97TF7dB+WmMipcnXEgjXAq6Ud/pQG7eenE921A4/tzEOSPsOvVNC
         mh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677801254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A2i/fpR85GsnM4yvTxGbXQcoI9FVWW3WSsWX/ebUCbg=;
        b=uYlvfK+1AzWkJWvq52RFb5OQwzhqbPR5bm2EvPEZ4i+tn7U9tEULp8R4wqttM3ymul
         oG/map+xBPXKd1+5KTqYdploDUcRcgIHA3yZxoqeaaVVSyFltAUn2NqO7BLYJ9i9cr+C
         jWwqAxE6FSUTgAcykW6nDytrLnvfeV2ek0wdYlFGwClmLCimOkMaBylyA/3obxDmjKDr
         FaPJCLvtl9MtrZgS9Y9rknRR3k1yYTCd4BNnEJhx5C6Gu8lVvlZ8KIc59IOZqUtWcC4r
         u4KLcUekAQiindG7oppEq41yIq5zPYmQiZNT0sIhDd1OL3izLLvahhshg0kM/m++Twre
         BRow==
X-Gm-Message-State: AO0yUKVU4+wsXSXq82C6NU9/gU7R3WKEmnRjhQ/KoEgyweuNY1RcVh6w
        gMQ85E5F0Bd/u/+cblstdQk=
X-Google-Smtp-Source: AK7set8OtMhbZ6+gJB+18MZDCQ80d9oazy7eSm2vCZwccHjkNGvq9087B6+X0msRRrBWT5EwKDdDIA==
X-Received: by 2002:a17:902:c94b:b0:19a:c65d:f93 with SMTP id i11-20020a170902c94b00b0019ac65d0f93mr19253pla.53.1677801254310;
        Thu, 02 Mar 2023 15:54:14 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id b2-20020a170903228200b001964c8164aasm216400plh.129.2023.03.02.15.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 15:54:13 -0800 (PST)
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
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        linux-media@vger.kernel.org (open list:SYNC FILE FRAMEWORK),
        linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING
        FRAMEWORK), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v9 07/15] dma-buf/sw_sync: Add fence deadline support
Date:   Thu,  2 Mar 2023 15:53:29 -0800
Message-Id: <20230302235356.3148279-8-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230302235356.3148279-1-robdclark@gmail.com>
References: <20230302235356.3148279-1-robdclark@gmail.com>
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
v4: Better comments, track the soonest deadline, as a normal fence
    implementation would, return an error if no deadline set.

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Christian König <christian.koenig@amd.com>
Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
---
 drivers/dma-buf/sw_sync.c    | 81 ++++++++++++++++++++++++++++++++++++
 drivers/dma-buf/sync_debug.h |  2 +
 2 files changed, 83 insertions(+)

diff --git a/drivers/dma-buf/sw_sync.c b/drivers/dma-buf/sw_sync.c
index 348b3a9170fa..f53071bca3af 100644
--- a/drivers/dma-buf/sw_sync.c
+++ b/drivers/dma-buf/sw_sync.c
@@ -52,12 +52,33 @@ struct sw_sync_create_fence_data {
 	__s32	fence; /* fd of new fence */
 };
 
+/**
+ * struct sw_sync_get_deadline - get the deadline hint of a sw_sync fence
+ * @deadline_ns: absolute time of the deadline
+ * @pad:	must be zero
+ * @fence_fd:	the sw_sync fence fd (in)
+ *
+ * Return the earliest deadline set on the fence.  The timebase for the
+ * deadline is CLOCK_MONOTONIC (same as vblank).  If there is no deadline
+ * set on the fence, this ioctl will return -ENOENT.
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
+
+
+#define SW_SYNC_HAS_DEADLINE_BIT	DMA_FENCE_FLAG_USER_BITS
 
 static const struct dma_fence_ops timeline_fence_ops;
 
@@ -171,6 +192,22 @@ static void timeline_fence_timeline_value_str(struct dma_fence *fence,
 	snprintf(str, size, "%d", parent->value);
 }
 
+static void timeline_fence_set_deadline(struct dma_fence *fence, ktime_t deadline)
+{
+	struct sync_pt *pt = dma_fence_to_sync_pt(fence);
+	unsigned long flags;
+
+	spin_lock_irqsave(fence->lock, flags);
+	if (test_bit(SW_SYNC_HAS_DEADLINE_BIT, &fence->flags)) {
+		if (ktime_before(deadline, pt->deadline))
+			pt->deadline = deadline;
+	} else {
+		pt->deadline = deadline;
+		set_bit(SW_SYNC_HAS_DEADLINE_BIT, &fence->flags);
+	}
+	spin_unlock_irqrestore(fence->lock, flags);
+}
+
 static const struct dma_fence_ops timeline_fence_ops = {
 	.get_driver_name = timeline_fence_get_driver_name,
 	.get_timeline_name = timeline_fence_get_timeline_name,
@@ -179,6 +216,7 @@ static const struct dma_fence_ops timeline_fence_ops = {
 	.release = timeline_fence_release,
 	.fence_value_str = timeline_fence_value_str,
 	.timeline_value_str = timeline_fence_timeline_value_str,
+	.set_deadline = timeline_fence_set_deadline,
 };
 
 /**
@@ -387,6 +425,46 @@ static long sw_sync_ioctl_inc(struct sync_timeline *obj, unsigned long arg)
 	return 0;
 }
 
+static int sw_sync_ioctl_get_deadline(struct sync_timeline *obj, unsigned long arg)
+{
+	struct sw_sync_get_deadline data;
+	struct dma_fence *fence;
+	struct sync_pt *pt;
+	int ret = 0;
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
+	spin_lock(fence->lock);
+	if (test_bit(SW_SYNC_HAS_DEADLINE_BIT, &fence->flags)) {
+		data.deadline_ns = ktime_to_ns(pt->deadline);
+	} else {
+		ret = -ENOENT;
+	}
+	spin_unlock(fence->lock);
+
+	dma_fence_put(fence);
+
+	if (ret)
+		return ret;
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
@@ -399,6 +477,9 @@ static long sw_sync_ioctl(struct file *file, unsigned int cmd,
 	case SW_SYNC_IOC_INC:
 		return sw_sync_ioctl_inc(obj, arg);
 
+	case SW_SYNC_GET_DEADLINE:
+		return sw_sync_ioctl_get_deadline(obj, arg);
+
 	default:
 		return -ENOTTY;
 	}
diff --git a/drivers/dma-buf/sync_debug.h b/drivers/dma-buf/sync_debug.h
index 6176e52ba2d7..a1bdd62efccd 100644
--- a/drivers/dma-buf/sync_debug.h
+++ b/drivers/dma-buf/sync_debug.h
@@ -55,11 +55,13 @@ static inline struct sync_timeline *dma_fence_parent(struct dma_fence *fence)
  * @base: base fence object
  * @link: link on the sync timeline's list
  * @node: node in the sync timeline's tree
+ * @deadline: the earliest fence deadline hint
  */
 struct sync_pt {
 	struct dma_fence base;
 	struct list_head link;
 	struct rb_node node;
+	ktime_t deadline;
 };
 
 extern const struct file_operations sw_sync_debugfs_fops;
-- 
2.39.1


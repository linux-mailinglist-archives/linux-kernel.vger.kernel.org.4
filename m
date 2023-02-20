Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1BD69D4E3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 21:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbjBTUTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 15:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbjBTUTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 15:19:36 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7431A12BFD;
        Mon, 20 Feb 2023 12:19:29 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id cb13so1138649pfb.5;
        Mon, 20 Feb 2023 12:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XiQQqcTshEbLjD8Mc0BqkK6iz8Zi/TK1jh3DESgjpc4=;
        b=EWlHLC4MR7yCgiQ7t5NjL4rflY/lHTNWITQmEgqG+vD5GKWdxIXDX3riU3EFvd3BNb
         U06DJbgiE2zvlQKapngeJ+aCSWD2L3tVDQFEvzuGKAyiS+R53gZhemupMklmpwEiliXf
         K79CAkJxyrcP1HFGivhBxUGLufbemHG0Rv6fJR9huvHeIIM1ILxSQdGZ47psp/nQm3OS
         RqvRx8Ab3h32aghQWBUmQq9X+DnutjaNE23HkxiQ39VswqnZ2ykZDKEOtU6Y5+0FOsuF
         x5ah3Uq115bwRKiSBH1iovTN55fLzqQzVRM/EpfOZNdLnmFQQsRkfu/SaQN70OKC2eWa
         VeMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XiQQqcTshEbLjD8Mc0BqkK6iz8Zi/TK1jh3DESgjpc4=;
        b=DsM2SCI/BSs0ApLKZo1l6J3WQu5dKkYGwkPvkhbchrPGOaO+2hRe1AeJBDe1DNvpIR
         Ahxvof9+SgLIqa1QxkkUqx7ryKTLWSfyEWdNeuQuuHdWcmg/qtUnblfk9XgPU2s0k7bk
         eor7jI2dZPKFXcoB62bpYbeKMo9Q35z1UqLRfTcjkoLpBXNmfLW5firxlX7WOb++6QwW
         7mfJgpL3wVChu9XZJnVUrXTT05MOdkc8zqXTozmv2Ug5ng5CpdxYm9sBP6J/IqTFEtgr
         Oc3srWESjbVVotK3c9U/ATszFRQyAK5rmLW94J9pduyXIo1NcGELoF5RIKDvRWHrDGRR
         ZrgQ==
X-Gm-Message-State: AO0yUKVuhVh8/YxVETIGa7q/ZmZgjzqNAc1qj6xXfPcCZZh9OFcoRWgI
        AqptJEOV6d1cEKRDXgsskns=
X-Google-Smtp-Source: AK7set8DBuY7ObnW5AgZYvamzQMZH1dc5w9PJC9F+zllVkpDOVshjNN4rL/mls3MjSK/WrgINVYhKg==
X-Received: by 2002:a05:6a00:1786:b0:5a9:d0e6:6a85 with SMTP id s6-20020a056a00178600b005a9d0e66a85mr2614276pfg.7.1676924368772;
        Mon, 20 Feb 2023 12:19:28 -0800 (PST)
Received: from localhost (c-73-67-135-195.hsd1.or.comcast.net. [73.67.135.195])
        by smtp.gmail.com with ESMTPSA id 4-20020aa79244000000b005a8851e0cddsm1688110pfp.188.2023.02.20.12.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 12:19:28 -0800 (PST)
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
        Rob Clark <robdclark@chromium.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        linux-media@vger.kernel.org (open list:SYNC FILE FRAMEWORK),
        linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING
        FRAMEWORK), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 07/14] dma-buf/sw_sync: Add fence deadline support
Date:   Mon, 20 Feb 2023 12:18:54 -0800
Message-Id: <20230220201916.1822214-8-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230220201916.1822214-1-robdclark@gmail.com>
References: <20230220201916.1822214-1-robdclark@gmail.com>
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

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/dma-buf/sw_sync.c    | 58 ++++++++++++++++++++++++++++++++++++
 drivers/dma-buf/sync_debug.h |  2 ++
 2 files changed, 60 insertions(+)

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
-- 
2.39.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255216A22E6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 21:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjBXUCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 15:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjBXUCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 15:02:30 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB247231CC
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 12:02:17 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id s5so699026plg.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 12:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cu6g0TfYrSTdJ3EF+CxBkdeZg6jPtGlNDSXHqXU9Yls=;
        b=jfnQ+wryJ6UoNNuaq/9qkc0J8szxJRWw9lWYlKQ8DTWOHXIAwadH8xFVxxtjKxUHjY
         nMUs4qLwvfv4I8nMLmOkEMid9S0dEWyjboz4lb/cVxfDcqCDAOVQUwn8tMkAniSYPRfU
         BD49SPoSbWnIh4aTFM+XTFkQYvfv2wOqtChvUvwisS58dujjvF0c50ljZsBdcG823BO8
         JyblYFovjGA0VHua88LzLpG/zvAPptD9Loll7A/3AINtigGEO6m2sWzVtm2EiFnD9FQu
         9P6EGcxr7K36hPdPYpi7DQygfYtUBaxrtEarerUlR9wRvTYk5mjHz9hWbU7eBz4T18tu
         V+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cu6g0TfYrSTdJ3EF+CxBkdeZg6jPtGlNDSXHqXU9Yls=;
        b=oMqcVCyqKxe1i83vFCFmVUvsuMSSHozafBFwy6R8wdQytV27+65WO6lZW3tXkYLRYy
         P2w8VTFU+1ReRVyyyt7Tkj7+HUEfegBv6ZBCnUaZY6yw9VCGEIkIO4OOsliZgoJcuJBf
         U7QTOissiVpojW0G1ESFU0aXnxXYwWXPiJrjsxSvczEBG8QjonnCULx0F9d1zwF3hKYj
         /zAe9LGVEic3AUIATMVKdGIYmpg2n5AAtMaEgzln3AfrkYAiI4+KK83SSCdOwUoO1AVX
         VPnJZMwvih0A05MBp/Xx9i1qjAB272IM/57MpQOKO2te+780YjdQtbBDKJoaYGJiCEif
         QOrg==
X-Gm-Message-State: AO0yUKV316cOgV4KeoZHi09LYDzNKVrnZ4IijzW9WORtKOcQXMjfMBFb
        Y91+gqJ1ixnDu+4Vg+CX2aE=
X-Google-Smtp-Source: AK7set+B1+Bpdtg70NjBLfeEZ2V9uMYfMxGNTrK85IHDNP/pRl6/na7XHjjxNk74ePQ7AfHzpg+KZg==
X-Received: by 2002:a17:903:707:b0:19c:b7a9:d4a4 with SMTP id kk7-20020a170903070700b0019cb7a9d4a4mr7061707plb.37.1677268937246;
        Fri, 24 Feb 2023 12:02:17 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id h22-20020a633856000000b005030136314dsm2102806pgn.71.2023.02.24.12.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 12:02:16 -0800 (PST)
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
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 09/15] drm/syncobj: Add deadline support for syncobj waits
Date:   Fri, 24 Feb 2023 12:01:37 -0800
Message-Id: <20230224200155.2510320-10-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230224200155.2510320-1-robdclark@gmail.com>
References: <20230224200155.2510320-1-robdclark@gmail.com>
MIME-Version: 1.0
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

Add a new flag to let userspace provide a deadline as a hint for syncobj
and timeline waits.  This gives a hint to the driver signaling the
backing fences about how soon userspace needs it to compete work, so it
can addjust GPU frequency accordingly.  An immediate deadline can be
given to provide something equivalent to i915 "wait boost".

v2: Use absolute u64 ns value for deadline hint, drop cap and driver
    feature flag in favor of allowing count_handles==0 as a way for
    userspace to probe kernel for support of new flag
v3: More verbose comments about UAPI

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/drm_syncobj.c | 64 ++++++++++++++++++++++++++++-------
 include/uapi/drm/drm.h        | 17 ++++++++++
 2 files changed, 68 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index 0c2be8360525..a85e9464f07b 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -126,6 +126,11 @@
  * synchronize between the two.
  * This requirement is inherited from the Vulkan fence API.
  *
+ * If &DRM_SYNCOBJ_WAIT_FLAGS_WAIT_DEADLINE is set, the ioctl will also set
+ * a fence deadline hint on the backing fences before waiting, to provide the
+ * fence signaler with an appropriate sense of urgency.  The deadline is
+ * specified as an absolute &CLOCK_MONOTONIC value in units of ns.
+ *
  * Similarly, &DRM_IOCTL_SYNCOBJ_TIMELINE_WAIT takes an array of syncobj
  * handles as well as an array of u64 points and does a host-side wait on all
  * of syncobj fences at the given points simultaneously.
@@ -973,7 +978,8 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
 						  uint32_t count,
 						  uint32_t flags,
 						  signed long timeout,
-						  uint32_t *idx)
+						  uint32_t *idx,
+						  ktime_t *deadline)
 {
 	struct syncobj_wait_entry *entries;
 	struct dma_fence *fence;
@@ -1053,6 +1059,15 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
 			drm_syncobj_fence_add_wait(syncobjs[i], &entries[i]);
 	}
 
+	if (deadline) {
+		for (i = 0; i < count; ++i) {
+			fence = entries[i].fence;
+			if (!fence)
+				continue;
+			dma_fence_set_deadline(fence, *deadline);
+		}
+	}
+
 	do {
 		set_current_state(TASK_INTERRUPTIBLE);
 
@@ -1151,7 +1166,8 @@ static int drm_syncobj_array_wait(struct drm_device *dev,
 				  struct drm_file *file_private,
 				  struct drm_syncobj_wait *wait,
 				  struct drm_syncobj_timeline_wait *timeline_wait,
-				  struct drm_syncobj **syncobjs, bool timeline)
+				  struct drm_syncobj **syncobjs, bool timeline,
+				  ktime_t *deadline)
 {
 	signed long timeout = 0;
 	uint32_t first = ~0;
@@ -1162,7 +1178,8 @@ static int drm_syncobj_array_wait(struct drm_device *dev,
 							 NULL,
 							 wait->count_handles,
 							 wait->flags,
-							 timeout, &first);
+							 timeout, &first,
+							 deadline);
 		if (timeout < 0)
 			return timeout;
 		wait->first_signaled = first;
@@ -1172,7 +1189,8 @@ static int drm_syncobj_array_wait(struct drm_device *dev,
 							 u64_to_user_ptr(timeline_wait->points),
 							 timeline_wait->count_handles,
 							 timeline_wait->flags,
-							 timeout, &first);
+							 timeout, &first,
+							 deadline);
 		if (timeout < 0)
 			return timeout;
 		timeline_wait->first_signaled = first;
@@ -1243,17 +1261,22 @@ drm_syncobj_wait_ioctl(struct drm_device *dev, void *data,
 {
 	struct drm_syncobj_wait *args = data;
 	struct drm_syncobj **syncobjs;
+	unsigned possible_flags;
+	ktime_t t, *tp = NULL;
 	int ret = 0;
 
 	if (!drm_core_check_feature(dev, DRIVER_SYNCOBJ))
 		return -EOPNOTSUPP;
 
-	if (args->flags & ~(DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL |
-			    DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT))
+	possible_flags = DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL |
+			 DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT |
+			 DRM_SYNCOBJ_WAIT_FLAGS_WAIT_DEADLINE;
+
+	if (args->flags & ~possible_flags)
 		return -EINVAL;
 
 	if (args->count_handles == 0)
-		return -EINVAL;
+		return 0;
 
 	ret = drm_syncobj_array_find(file_private,
 				     u64_to_user_ptr(args->handles),
@@ -1262,8 +1285,13 @@ drm_syncobj_wait_ioctl(struct drm_device *dev, void *data,
 	if (ret < 0)
 		return ret;
 
+	if (args->flags & DRM_SYNCOBJ_WAIT_FLAGS_WAIT_DEADLINE) {
+		t = ns_to_ktime(args->deadline_ns);
+		tp = &t;
+	}
+
 	ret = drm_syncobj_array_wait(dev, file_private,
-				     args, NULL, syncobjs, false);
+				     args, NULL, syncobjs, false, tp);
 
 	drm_syncobj_array_free(syncobjs, args->count_handles);
 
@@ -1276,18 +1304,23 @@ drm_syncobj_timeline_wait_ioctl(struct drm_device *dev, void *data,
 {
 	struct drm_syncobj_timeline_wait *args = data;
 	struct drm_syncobj **syncobjs;
+	unsigned possible_flags;
+	ktime_t t, *tp = NULL;
 	int ret = 0;
 
 	if (!drm_core_check_feature(dev, DRIVER_SYNCOBJ_TIMELINE))
 		return -EOPNOTSUPP;
 
-	if (args->flags & ~(DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL |
-			    DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT |
-			    DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE))
+	possible_flags = DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL |
+			 DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT |
+			 DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE |
+			 DRM_SYNCOBJ_WAIT_FLAGS_WAIT_DEADLINE;
+
+	if (args->flags & ~possible_flags)
 		return -EINVAL;
 
 	if (args->count_handles == 0)
-		return -EINVAL;
+		return -0;
 
 	ret = drm_syncobj_array_find(file_private,
 				     u64_to_user_ptr(args->handles),
@@ -1296,8 +1329,13 @@ drm_syncobj_timeline_wait_ioctl(struct drm_device *dev, void *data,
 	if (ret < 0)
 		return ret;
 
+	if (args->flags & DRM_SYNCOBJ_WAIT_FLAGS_WAIT_DEADLINE) {
+		t = ns_to_ktime(args->deadline_ns);
+		tp = &t;
+	}
+
 	ret = drm_syncobj_array_wait(dev, file_private,
-				     NULL, args, syncobjs, true);
+				     NULL, args, syncobjs, true, tp);
 
 	drm_syncobj_array_free(syncobjs, args->count_handles);
 
diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
index 642808520d92..bff0509ac8b6 100644
--- a/include/uapi/drm/drm.h
+++ b/include/uapi/drm/drm.h
@@ -887,6 +887,7 @@ struct drm_syncobj_transfer {
 #define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL (1 << 0)
 #define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT (1 << 1)
 #define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE (1 << 2) /* wait for time point to become available */
+#define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_DEADLINE (1 << 3) /* set fence deadline based to deadline_ns */
 struct drm_syncobj_wait {
 	__u64 handles;
 	/* absolute timeout */
@@ -895,6 +896,14 @@ struct drm_syncobj_wait {
 	__u32 flags;
 	__u32 first_signaled; /* only valid when not waiting all */
 	__u32 pad;
+	/**
+	 * @deadline_ns - fence deadline hint
+	 *
+	 * Deadline hint, in absolute CLOCK_MONOTONIC, to set on backing
+	 * fence(s) if the DRM_SYNCOBJ_WAIT_FLAGS_WAIT_DEADLINE flag is
+	 * set.
+	 */
+	__u64 deadline_ns;
 };
 
 struct drm_syncobj_timeline_wait {
@@ -907,6 +916,14 @@ struct drm_syncobj_timeline_wait {
 	__u32 flags;
 	__u32 first_signaled; /* only valid when not waiting all */
 	__u32 pad;
+	/**
+	 * @deadline_ns - fence deadline hint
+	 *
+	 * Deadline hint, in absolute CLOCK_MONOTONIC, to set on backing
+	 * fence(s) if the DRM_SYNCOBJ_WAIT_FLAGS_WAIT_DEADLINE flag is
+	 * set.
+	 */
+	__u64 deadline_ns;
 };
 
 
-- 
2.39.1


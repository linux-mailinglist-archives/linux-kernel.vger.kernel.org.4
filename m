Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7962E6A4B2F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 20:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjB0Tgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 14:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjB0TgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 14:36:24 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A334927D60;
        Mon, 27 Feb 2023 11:36:08 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id n5so4236222pfv.11;
        Mon, 27 Feb 2023 11:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fry4TP6AIquyUeVXSm7W0PXZtEhE3hkfU2dLB2bew7U=;
        b=YckQb7/ERtb485oiiR6WPL+6RddWfkDYo9adIuUBDZG+V34YcDMDFi2A2n4Rih9bPm
         uRKS7/5WAI1W6Kzd2eJWWrVhZLgPBEHGQ37hSV4bq0fXn96o8Vr2vOi+tszJMRbaZrJ7
         IAhLQrCgVzI14Yl1f4mXWvUEmfAH8amJpmFMNfSeneN+OtmsIWV6H/Z+REvFYEOi6g64
         CoxOdoal9+2e7tfpU6n+9X5R6dy6wl58IZrYILqPoVQOK/kJmyYgGgHMADcEhuWik7p3
         9V4Qu2ExAF8MOo1qT02OGLjvKZ+xBCAkflZYRUoEy3m/yxNZpYs6EEjOLjxBDLb2iWx3
         x9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fry4TP6AIquyUeVXSm7W0PXZtEhE3hkfU2dLB2bew7U=;
        b=cPecgE3mItNLTnkVrEvUQ3gh2HWlTnZP8W3WaefPObaW/gkrcY8mlDtFhF+FjXMK25
         dRmFuU6eN5+LtPZPiyTqKGfYhYpO+lTts7+7HHuq7TERxg2yt9MUOl9WxJ1mPy0Emj8n
         xTENPw/a1l42ZfMmGOsllFh+Gu4HqqbSeLWa0o0kAxMO99RkrzscZRlKOWQqS5LkltLE
         GC10XqGbfkxDxDefrgviuLEHTpKNP+Z/dlmVgI4MXUbXgvcC+FL8nVEK9y/NvhnS3Meh
         qelxxtl7lVp0rW6+lermmT6WuhFi7zU1vqTWsp241oNZI9XV8OYEj0lAoDvzr64LfOsX
         7FCg==
X-Gm-Message-State: AO0yUKVF5kJsjHGJqqQl/Oeu/moDdyrT6gZOJKoQQWA5La4wcxmnv+b7
        2kjMMQKZ8qGqp/n5ERx+UfPEuvOGvY0=
X-Google-Smtp-Source: AK7set/GOe1T5Y++9WHJ9mnW2g2Aoty2s3b64lXsfNyfr7xjRMyn9hnvgDDoTyxMGQxRgkQw5aT/uQ==
X-Received: by 2002:aa7:940b:0:b0:5a9:b910:6d98 with SMTP id x11-20020aa7940b000000b005a9b9106d98mr101195pfo.13.1677526568014;
        Mon, 27 Feb 2023 11:36:08 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id x42-20020a056a000bea00b005df065ebd5esm4547737pfu.209.2023.02.27.11.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 11:36:07 -0800 (PST)
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
        Rob Clark <robdclark@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-media@vger.kernel.org (open list:DMA BUFFER SHARING FRAMEWORK),
        linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING
        FRAMEWORK)
Subject: [PATCH v7 08/15] drm/scheduler: Add fence deadline support
Date:   Mon, 27 Feb 2023 11:35:14 -0800
Message-Id: <20230227193535.2822389-9-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230227193535.2822389-1-robdclark@gmail.com>
References: <20230227193535.2822389-1-robdclark@gmail.com>
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

As the finished fence is the one that is exposed to userspace, and
therefore the one that other operations, like atomic update, would
block on, we need to propagate the deadline from from the finished
fence to the actual hw fence.

v2: Split into drm_sched_fence_set_parent() (ckoenig)
v3: Ensure a thread calling drm_sched_fence_set_deadline_finished() sees
    fence->parent set before drm_sched_fence_set_parent() does this
    test_bit(DMA_FENCE_FLAG_HAS_DEADLINE_BIT).

Signed-off-by: Rob Clark <robdclark@chromium.org>
Acked-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/scheduler/sched_fence.c | 46 +++++++++++++++++++++++++
 drivers/gpu/drm/scheduler/sched_main.c  |  2 +-
 include/drm/gpu_scheduler.h             | 17 +++++++++
 3 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/scheduler/sched_fence.c b/drivers/gpu/drm/scheduler/sched_fence.c
index 7fd869520ef2..fe9c6468e440 100644
--- a/drivers/gpu/drm/scheduler/sched_fence.c
+++ b/drivers/gpu/drm/scheduler/sched_fence.c
@@ -123,6 +123,37 @@ static void drm_sched_fence_release_finished(struct dma_fence *f)
 	dma_fence_put(&fence->scheduled);
 }
 
+static void drm_sched_fence_set_deadline_finished(struct dma_fence *f,
+						  ktime_t deadline)
+{
+	struct drm_sched_fence *fence = to_drm_sched_fence(f);
+	struct dma_fence *parent;
+	unsigned long flags;
+
+	spin_lock_irqsave(&fence->lock, flags);
+
+	/* If we already have an earlier deadline, keep it: */
+	if (test_bit(DRM_SCHED_FENCE_FLAG_HAS_DEADLINE_BIT, &f->flags) &&
+	    ktime_before(fence->deadline, deadline)) {
+		spin_unlock_irqrestore(&fence->lock, flags);
+		return;
+	}
+
+	fence->deadline = deadline;
+	set_bit(DRM_SCHED_FENCE_FLAG_HAS_DEADLINE_BIT, &f->flags);
+
+	spin_unlock_irqrestore(&fence->lock, flags);
+
+	/*
+	 * smp_load_aquire() to ensure that if we are racing another
+	 * thread calling drm_sched_fence_set_parent(), that we see
+	 * the parent set before it calls test_bit(HAS_DEADLINE_BIT)
+	 */
+	parent = smp_load_acquire(&fence->parent);
+	if (parent)
+		dma_fence_set_deadline(parent, deadline);
+}
+
 static const struct dma_fence_ops drm_sched_fence_ops_scheduled = {
 	.get_driver_name = drm_sched_fence_get_driver_name,
 	.get_timeline_name = drm_sched_fence_get_timeline_name,
@@ -133,6 +164,7 @@ static const struct dma_fence_ops drm_sched_fence_ops_finished = {
 	.get_driver_name = drm_sched_fence_get_driver_name,
 	.get_timeline_name = drm_sched_fence_get_timeline_name,
 	.release = drm_sched_fence_release_finished,
+	.set_deadline = drm_sched_fence_set_deadline_finished,
 };
 
 struct drm_sched_fence *to_drm_sched_fence(struct dma_fence *f)
@@ -147,6 +179,20 @@ struct drm_sched_fence *to_drm_sched_fence(struct dma_fence *f)
 }
 EXPORT_SYMBOL(to_drm_sched_fence);
 
+void drm_sched_fence_set_parent(struct drm_sched_fence *s_fence,
+				struct dma_fence *fence)
+{
+	/*
+	 * smp_store_release() to ensure another thread racing us
+	 * in drm_sched_fence_set_deadline_finished() sees the
+	 * fence's parent set before test_bit()
+	 */
+	smp_store_release(&s_fence->parent, dma_fence_get(fence));
+	if (test_bit(DRM_SCHED_FENCE_FLAG_HAS_DEADLINE_BIT,
+		     &s_fence->finished.flags))
+		dma_fence_set_deadline(fence, s_fence->deadline);
+}
+
 struct drm_sched_fence *drm_sched_fence_alloc(struct drm_sched_entity *entity,
 					      void *owner)
 {
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 4e6ad6e122bc..007f98c48f8d 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -1019,7 +1019,7 @@ static int drm_sched_main(void *param)
 		drm_sched_fence_scheduled(s_fence);
 
 		if (!IS_ERR_OR_NULL(fence)) {
-			s_fence->parent = dma_fence_get(fence);
+			drm_sched_fence_set_parent(s_fence, fence);
 			/* Drop for original kref_init of the fence */
 			dma_fence_put(fence);
 
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 9db9e5e504ee..99584e457153 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -41,6 +41,15 @@
  */
 #define DRM_SCHED_FENCE_DONT_PIPELINE	DMA_FENCE_FLAG_USER_BITS
 
+/**
+ * DRM_SCHED_FENCE_FLAG_HAS_DEADLINE_BIT - A fence deadline hint has been set
+ *
+ * Because we could have a deadline hint can be set before the backing hw
+ * fence is created, we need to keep track of whether a deadline has already
+ * been set.
+ */
+#define DRM_SCHED_FENCE_FLAG_HAS_DEADLINE_BIT	(DMA_FENCE_FLAG_USER_BITS + 1)
+
 enum dma_resv_usage;
 struct dma_resv;
 struct drm_gem_object;
@@ -280,6 +289,12 @@ struct drm_sched_fence {
          */
 	struct dma_fence		finished;
 
+	/**
+	 * @deadline: deadline set on &drm_sched_fence.finished which
+	 * potentially needs to be propagated to &drm_sched_fence.parent
+	 */
+	ktime_t				deadline;
+
         /**
          * @parent: the fence returned by &drm_sched_backend_ops.run_job
          * when scheduling the job on hardware. We signal the
@@ -568,6 +583,8 @@ void drm_sched_entity_set_priority(struct drm_sched_entity *entity,
 				   enum drm_sched_priority priority);
 bool drm_sched_entity_is_ready(struct drm_sched_entity *entity);
 
+void drm_sched_fence_set_parent(struct drm_sched_fence *s_fence,
+				struct dma_fence *fence);
 struct drm_sched_fence *drm_sched_fence_alloc(
 	struct drm_sched_entity *s_entity, void *owner);
 void drm_sched_fence_init(struct drm_sched_fence *fence,
-- 
2.39.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E984869BC4F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 22:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjBRVQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 16:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjBRVQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 16:16:08 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CC413DC2;
        Sat, 18 Feb 2023 13:15:59 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id nv10-20020a17090b1b4a00b00233ba727724so1197569pjb.1;
        Sat, 18 Feb 2023 13:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VdB6EdjwMQL5Ibg3VUOmJdReWQo7i7tr5bIvZ40Y+70=;
        b=pDA9FLO9fgkMVEoWNcr9GB82wPyuwd6l2FqLVItakUuB+XiNMjIds3HFZkW2geSsF5
         JniRckmdMx4FBrTxXEMzuuu0JRfMaQGjWaV5CR0PgBkbcewgNkSzjkPQn4db0AKxiVBV
         2OgVLUMSDHOwXovpeU+Y+dP7pSsTdfSjbA7OpGooBtFsSm07TdnYKXnfj6okBFn0kjkm
         rwMNzyzGBe/E9RxTygAHj0qiclCrl9jRN4c0Sk2WZTTIFah2yv9oAE5xkAPLpjVluse8
         kWLSzCd+d8X33I0KRZYt1rV0mB2ftjO6edVT9oDPgGezTsOvgS9EJWuT4ADkBpZfiLqk
         5daA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VdB6EdjwMQL5Ibg3VUOmJdReWQo7i7tr5bIvZ40Y+70=;
        b=C3ZUHKRcaSNzliGwJwgGFXxXxzp1JPIkxx371a3hYQeW5FILFCj0GeYVoUPXVkbynv
         viSJN2AVtqbJYbL5pdcbJplTWeCvVhKX1jgvi2hfuX+G4S8kEFqTv8cWw38ZLQAPRvYf
         FujFSKJqkyKmKqsGtDh0IWBw6JQy/PcEwAIwAyXLMZlwPcVTTL7OPG4BYzUQ7Ngn6lo8
         QLGh+x3Q48i3A2rGJztM7JHkFa5AvzCHH7N03srYpU21H9cgmHidMwZvqtWOya+8z98s
         rk3wvIIc5QYDVz1ZSjwrOz8HnZCCbFP3W5qhihSqwL1yLIWtRfvAHR3BdSe/tx3fvRme
         ffow==
X-Gm-Message-State: AO0yUKWwqrnK6r/408a3dgElX0Qph/sRnZv+RgdaCBkdhYixAFw9oF33
        IFPmRsvplxZdBoVTQt2yDjE=
X-Google-Smtp-Source: AK7set/isq+fQ8sHwasEnl9uLEI6PlAThVYe7S8EE+VDv5IdGpz8tgeAC/idcodqkaUTeNRTzHseWw==
X-Received: by 2002:a17:902:d48a:b0:19a:b6bf:1e16 with SMTP id c10-20020a170902d48a00b0019ab6bf1e16mr817197plg.51.1676754959377;
        Sat, 18 Feb 2023 13:15:59 -0800 (PST)
Received: from localhost (c-73-67-135-195.hsd1.or.comcast.net. [73.67.135.195])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c20600b00194d14d8e54sm5050777pll.96.2023.02.18.13.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 13:15:59 -0800 (PST)
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
        Rob Clark <robdclark@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Luben Tuikov <luben.tuikov@amd.com>,
        David Airlie <airlied@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-media@vger.kernel.org (open list:DMA BUFFER SHARING FRAMEWORK),
        linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING
        FRAMEWORK)
Subject: [PATCH v4 08/14] drm/scheduler: Add fence deadline support
Date:   Sat, 18 Feb 2023 13:15:51 -0800
Message-Id: <20230218211608.1630586-9-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230218211608.1630586-1-robdclark@gmail.com>
References: <20230218211608.1630586-1-robdclark@gmail.com>
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
---
 drivers/gpu/drm/scheduler/sched_fence.c | 46 +++++++++++++++++++++++++
 drivers/gpu/drm/scheduler/sched_main.c  |  2 +-
 include/drm/gpu_scheduler.h             |  8 +++++
 3 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/scheduler/sched_fence.c b/drivers/gpu/drm/scheduler/sched_fence.c
index 7fd869520ef2..43e2d4f5fe3b 100644
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
+	if (test_bit(DMA_FENCE_FLAG_HAS_DEADLINE_BIT, &f->flags) &&
+	    ktime_before(fence->deadline, deadline)) {
+		spin_unlock_irqrestore(&fence->lock, flags);
+		return;
+	}
+
+	fence->deadline = deadline;
+	set_bit(DMA_FENCE_FLAG_HAS_DEADLINE_BIT, &f->flags);
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
+	if (test_bit(DMA_FENCE_FLAG_HAS_DEADLINE_BIT,
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
index 9db9e5e504ee..8b31a954a44d 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -280,6 +280,12 @@ struct drm_sched_fence {
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
@@ -568,6 +574,8 @@ void drm_sched_entity_set_priority(struct drm_sched_entity *entity,
 				   enum drm_sched_priority priority);
 bool drm_sched_entity_is_ready(struct drm_sched_entity *entity);
 
+void drm_sched_fence_set_parent(struct drm_sched_fence *s_fence,
+				struct dma_fence *fence);
 struct drm_sched_fence *drm_sched_fence_alloc(
 	struct drm_sched_entity *s_entity, void *owner);
 void drm_sched_fence_init(struct drm_sched_fence *fence,
-- 
2.39.1


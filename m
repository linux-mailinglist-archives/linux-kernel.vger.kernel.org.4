Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4AD66C598C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 23:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjCVWoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 18:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCVWoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 18:44:17 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC306E90;
        Wed, 22 Mar 2023 15:44:16 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id c18so20628594ple.11;
        Wed, 22 Mar 2023 15:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679525056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u7IFLnv2wp+6+M4RDOrDXlUdlj/4yQHYPm5exES9iSg=;
        b=d0r7ofq5hY83b1KFqtk/khmAPHfvgWyeyA3MONIOqMO+HDlgKrSCSYHRBu9oUUxNh0
         j4EqAQFrGaB9BN7ZmZnfRLFB26ZpAiJMEJnoQxyJHli0iP9bAT/iH7DVxyRFGD+bJPKJ
         SLBipXnpy6bZPQzbq/pKSi5ySkL0ewxUDi0/JHUXGcSOfS9ASAUCHoG5N3dKZR5lmYBn
         8pDDQWpd8Og5i0XCV/oMlJ/mbTeh2P7zzsGjJeagqUcCa97pbKfSObAs2UtIl33p5/EE
         GHfsN5IyZuIzig3G4q4KZLyOfHa48jwasgb2TM9tordUu7H8Qafj78GDSaI4JfkXej/f
         28qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679525056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u7IFLnv2wp+6+M4RDOrDXlUdlj/4yQHYPm5exES9iSg=;
        b=kK4TUdQBl/KLtXYadX8Eh56a2lJAtrdzCrzDDqr4Ikaq5f/ENVRNSzzG4BFuFNoMqW
         Ya5k0AmLPeunMhob1TBFYQ4d3pwobKsKE7WXv+yp81P33+B+dciykovKCSjEGvHKHnm/
         BcmRD3uarGx6sC4gs5SOFWDejFGDOgMYZm6KnLix7Zb+2WtUOOVX5/41Olk6zXUMxW3V
         UN9vm9Xb59R3D5mpoHe6hXh3tQOk/XbnvPH/A4uCQ1yS1qb8UIt20zVjBQCMNwdrxB6f
         lKsGV4rR+WMgntpRGT9xjJYG4aMORXYEzMbbLv+LWPMlH5b4u+C68p3JuwXn5/0CVRZl
         z5ZA==
X-Gm-Message-State: AO0yUKUJg3uZCv6A5iZgrzJcKBpkNxcTr8J+51LPssJzzV3GcCawWJKg
        nR1a3mGgdoR/CktVzIoOGoI=
X-Google-Smtp-Source: AK7set/xDVFAvIS+FUJS6LFPnzBnvslEhWBhH930+MmTO6iZlkSX7t7YHlarHpTIx2aAUAoJOtOaRQ==
X-Received: by 2002:a17:90b:3803:b0:234:a9df:db96 with SMTP id mq3-20020a17090b380300b00234a9dfdb96mr5338431pjb.33.1679525056271;
        Wed, 22 Mar 2023 15:44:16 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id p5-20020a1709026b8500b001a1aeb3a7a9sm9798689plk.137.2023.03.22.15.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 15:44:15 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>,
        Luben Tuikov <luben.tuikov@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-media@vger.kernel.org (open list:DMA BUFFER SHARING FRAMEWORK),
        linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING
        FRAMEWORK)
Subject: [RFC] drm/scheduler: Unwrap job dependencies
Date:   Wed, 22 Mar 2023 15:44:03 -0700
Message-Id: <20230322224403.35742-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Container fences have burner contexts, which makes the trick to store at
most one fence per context somewhat useless if we don't unwrap array or
chain fences.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
tbh, I'm not sure why we weren't doing this already, unless there is
something I'm overlooking

 drivers/gpu/drm/scheduler/sched_main.c | 43 +++++++++++++++++---------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index c2ee44d6224b..f59e5335afbb 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -41,20 +41,21 @@
  * 4. Entities themselves maintain a queue of jobs that will be scheduled on
  *    the hardware.
  *
  * The jobs in a entity are always scheduled in the order that they were pushed.
  */
 
 #include <linux/kthread.h>
 #include <linux/wait.h>
 #include <linux/sched.h>
 #include <linux/completion.h>
+#include <linux/dma-fence-unwrap.h>
 #include <linux/dma-resv.h>
 #include <uapi/linux/sched/types.h>
 
 #include <drm/drm_print.h>
 #include <drm/drm_gem.h>
 #include <drm/gpu_scheduler.h>
 #include <drm/spsc_queue.h>
 
 #define CREATE_TRACE_POINTS
 #include "gpu_scheduler_trace.h"
@@ -665,41 +666,27 @@ void drm_sched_job_arm(struct drm_sched_job *job)
 	sched = entity->rq->sched;
 
 	job->sched = sched;
 	job->s_priority = entity->rq - sched->sched_rq;
 	job->id = atomic64_inc_return(&sched->job_id_count);
 
 	drm_sched_fence_init(job->s_fence, job->entity);
 }
 EXPORT_SYMBOL(drm_sched_job_arm);
 
-/**
- * drm_sched_job_add_dependency - adds the fence as a job dependency
- * @job: scheduler job to add the dependencies to
- * @fence: the dma_fence to add to the list of dependencies.
- *
- * Note that @fence is consumed in both the success and error cases.
- *
- * Returns:
- * 0 on success, or an error on failing to expand the array.
- */
-int drm_sched_job_add_dependency(struct drm_sched_job *job,
-				 struct dma_fence *fence)
+static int _add_dependency(struct drm_sched_job *job, struct dma_fence *fence)
 {
 	struct dma_fence *entry;
 	unsigned long index;
 	u32 id = 0;
 	int ret;
 
-	if (!fence)
-		return 0;
-
 	/* Deduplicate if we already depend on a fence from the same context.
 	 * This lets the size of the array of deps scale with the number of
 	 * engines involved, rather than the number of BOs.
 	 */
 	xa_for_each(&job->dependencies, index, entry) {
 		if (entry->context != fence->context)
 			continue;
 
 		if (dma_fence_is_later(fence, entry)) {
 			dma_fence_put(entry);
@@ -709,20 +696,46 @@ int drm_sched_job_add_dependency(struct drm_sched_job *job,
 		}
 		return 0;
 	}
 
 	ret = xa_alloc(&job->dependencies, &id, fence, xa_limit_32b, GFP_KERNEL);
 	if (ret != 0)
 		dma_fence_put(fence);
 
 	return ret;
 }
+
+/**
+ * drm_sched_job_add_dependency - adds the fence as a job dependency
+ * @job: scheduler job to add the dependencies to
+ * @fence: the dma_fence to add to the list of dependencies.
+ *
+ * Note that @fence is consumed in both the success and error cases.
+ *
+ * Returns:
+ * 0 on success, or an error on failing to expand the array.
+ */
+int drm_sched_job_add_dependency(struct drm_sched_job *job,
+				 struct dma_fence *fence)
+{
+	struct dma_fence_unwrap iter;
+	struct dma_fence *f;
+	int ret = 0;
+
+	dma_fence_unwrap_for_each (f, &iter, fence) {
+		ret = _add_dependency(job, f);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
 EXPORT_SYMBOL(drm_sched_job_add_dependency);
 
 /**
  * drm_sched_job_add_resv_dependencies - add all fences from the resv to the job
  * @job: scheduler job to add the dependencies to
  * @resv: the dma_resv object to get the fences from
  * @usage: the dma_resv_usage to use to filter the fences
  *
  * This adds all fences matching the given usage from @resv to @job.
  * Must be called with the @resv lock held.
-- 
2.39.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D276C1537
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjCTOot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbjCTOok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:44:40 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B2DCA1A;
        Mon, 20 Mar 2023 07:44:38 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id u5so12652623plq.7;
        Mon, 20 Mar 2023 07:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679323478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xALpMXlLTSMvOfS7mQNvHfzG9+8QM3cmx9b7Fz6Q2XU=;
        b=cxu8fcc47sheJUocs3NFK/ej2kra9Ypkl7pCx1H1P5vOekErq1/GNU3/ZBsh7fug/U
         LK5SzMY1CdLJhSlItGMRB+oN2kKcpG9ZezdZTN4n8Us/IaCGxAzVEcp9zoIzcbsHXM8l
         Qze0Vuq2K4bx7XB8PZONqv84P/6H9hG3kl7ovKb5I6Z0JnHdaUA2grKNAlEuYnpDmN+B
         Y9CLZCVJ6ye3i6QM7sDrald94pji9aWZ+2cy0EOHNDHwDIaL6b6wQ2WpqdFMnc1TBHeR
         qnuRIQoDVOVCXCBRpQ2sohXgh4ltYqi2IkT24bat3p9pR9f1dZscLLR8ov0SK99wX8qm
         HqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679323478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xALpMXlLTSMvOfS7mQNvHfzG9+8QM3cmx9b7Fz6Q2XU=;
        b=sNva6z4hfKo7CcVhs4Ogj8oEn1utR9+RmVVISSiwsyw6v8wHdyiFLjzmje9aCvHVR9
         uEV3FvdYvpKRZuRr/mp/1Z5cNl8HjsFq2HGIePxF7F9uzPQ3e9G/ZYw4dEuWl3dEMQOD
         5MpUHWolH/sXuD93CU3A9OpC7CnIP7DEIV2JCKuc1+9QMcjNY0qDECxDgB0pPyLr91/K
         ij1+jFWMKoBLpxxcdNOars3/oEq7C3X/PItbVNpo5LC8eVcaudvtDXn7irWgNoJZEnSz
         U955qNJb/CoLE+zh9GpeIhx/FTcY7MqmK0z4vm6/GNlUwn3Ddoca0ksgRpFCkxDtX4N4
         Lq3Q==
X-Gm-Message-State: AO0yUKVVxLXhK86X99fHkVGr1nayN+mhDOhSUbIfKmEAmvpW+4cDfrQ7
        EEJrWS0jgyqLESi+D+1VEa0=
X-Google-Smtp-Source: AK7set/Og7pcuw4IzsENyS7Re6THWUo/30QuP9+MbL2JloNr5T9/L0e5eyWIxk080vd7BjvX4FSQ2A==
X-Received: by 2002:a05:6a20:7b05:b0:da:39a5:6e66 with SMTP id s5-20020a056a207b0500b000da39a56e66mr920491pzh.18.1679323478303;
        Mon, 20 Mar 2023 07:44:38 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id r13-20020a63e50d000000b004fb26a80875sm6389111pgh.22.2023.03.20.07.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 07:44:37 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 04/23] drm/msm: Decouple vma tracking from obj lock
Date:   Mon, 20 Mar 2023 07:43:26 -0700
Message-Id: <20230320144356.803762-5-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230320144356.803762-1-robdclark@gmail.com>
References: <20230320144356.803762-1-robdclark@gmail.com>
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

We need to use the inuse count to track that a BO is pinned until
we have the hw_fence.  But we want to remove the obj lock from the
job_run() path as this could deadlock against reclaim/shrinker
(because it is blocking the hw_fence from eventually being signaled).
So split that tracking out into a per-vma lock with narrower scope.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gem.h        |  1 +
 drivers/gpu/drm/msm/msm_gem_vma.c    | 44 ++++++++++++++++++++++++----
 drivers/gpu/drm/msm/msm_ringbuffer.c |  2 +-
 3 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index d3219c523034..1929f09c5b0d 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -59,6 +59,7 @@ struct msm_fence_context;
 
 struct msm_gem_vma {
 	struct drm_mm_node node;
+	spinlock_t lock;
 	uint64_t iova;
 	struct msm_gem_address_space *aspace;
 	struct list_head list;    /* node in msm_gem_object::vmas */
diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index 2827679dc39a..98287ed99960 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -40,19 +40,28 @@ msm_gem_address_space_get(struct msm_gem_address_space *aspace)
 
 bool msm_gem_vma_inuse(struct msm_gem_vma *vma)
 {
+	bool ret = true;
+
+	spin_lock(&vma->lock);
+
 	if (vma->inuse > 0)
-		return true;
+		goto out;
 
 	while (vma->fence_mask) {
 		unsigned idx = ffs(vma->fence_mask) - 1;
 
 		if (!msm_fence_completed(vma->fctx[idx], vma->fence[idx]))
-			return true;
+			goto out;
 
 		vma->fence_mask &= ~BIT(idx);
 	}
 
-	return false;
+	ret = false;
+
+out:
+	spin_unlock(&vma->lock);
+
+	return ret;
 }
 
 /* Actually unmap memory for the vma */
@@ -73,8 +82,7 @@ void msm_gem_vma_purge(struct msm_gem_vma *vma)
 	vma->mapped = false;
 }
 
-/* Remove reference counts for the mapping */
-void msm_gem_vma_unpin(struct msm_gem_vma *vma)
+static void vma_unpin_locked(struct msm_gem_vma *vma)
 {
 	if (GEM_WARN_ON(!vma->inuse))
 		return;
@@ -82,13 +90,23 @@ void msm_gem_vma_unpin(struct msm_gem_vma *vma)
 		vma->inuse--;
 }
 
+/* Remove reference counts for the mapping */
+void msm_gem_vma_unpin(struct msm_gem_vma *vma)
+{
+	spin_lock(&vma->lock);
+	vma_unpin_locked(vma);
+	spin_unlock(&vma->lock);
+}
+
 /* Replace pin reference with fence: */
 void msm_gem_vma_unpin_fenced(struct msm_gem_vma *vma, struct msm_fence_context *fctx)
 {
+	spin_lock(&vma->lock);
 	vma->fctx[fctx->index] = fctx;
 	vma->fence[fctx->index] = fctx->last_fence;
 	vma->fence_mask |= BIT(fctx->index);
-	msm_gem_vma_unpin(vma);
+	vma_unpin_locked(vma);
+	spin_unlock(&vma->lock);
 }
 
 /* Map and pin vma: */
@@ -103,7 +121,9 @@ msm_gem_vma_map(struct msm_gem_vma *vma, int prot,
 		return -EINVAL;
 
 	/* Increase the usage counter */
+	spin_lock(&vma->lock);
 	vma->inuse++;
+	spin_unlock(&vma->lock);
 
 	if (vma->mapped)
 		return 0;
@@ -113,11 +133,22 @@ msm_gem_vma_map(struct msm_gem_vma *vma, int prot,
 	if (!aspace)
 		return 0;
 
+	/*
+	 * NOTE: iommu/io-pgtable can allocate pages, so we cannot hold
+	 * a lock across map/unmap which is also used in the job_run()
+	 * path, as this can cause deadlock in job_run() vs shrinker/
+	 * reclaim.
+	 *
+	 * Revisit this if we can come up with a scheme to pre-alloc pages
+	 * for the pgtable in map/unmap ops.
+	 */
 	ret = aspace->mmu->funcs->map(aspace->mmu, vma->iova, sgt, size, prot);
 
 	if (ret) {
 		vma->mapped = false;
+		spin_lock(&vma->lock);
 		vma->inuse--;
+		spin_unlock(&vma->lock);
 	}
 
 	return ret;
@@ -148,6 +179,7 @@ struct msm_gem_vma *msm_gem_vma_new(struct msm_gem_address_space *aspace)
 	if (!vma)
 		return NULL;
 
+	spin_lock_init(&vma->lock);
 	vma->aspace = aspace;
 
 	return vma;
diff --git a/drivers/gpu/drm/msm/msm_ringbuffer.c b/drivers/gpu/drm/msm/msm_ringbuffer.c
index 44a22b283730..31b4fbf96c36 100644
--- a/drivers/gpu/drm/msm/msm_ringbuffer.c
+++ b/drivers/gpu/drm/msm/msm_ringbuffer.c
@@ -23,8 +23,8 @@ static struct dma_fence *msm_job_run(struct drm_sched_job *job)
 	for (i = 0; i < submit->nr_bos; i++) {
 		struct drm_gem_object *obj = &submit->bos[i].obj->base;
 
-		msm_gem_lock(obj);
 		msm_gem_vma_unpin_fenced(submit->bos[i].vma, fctx);
+		msm_gem_lock(obj);
 		msm_gem_unpin_locked(obj);
 		msm_gem_unlock(obj);
 		submit->bos[i].flags &= ~(BO_VMA_PINNED | BO_OBJ_PINNED);
-- 
2.39.2


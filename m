Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCE76C1535
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjCTOoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbjCTOoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:44:39 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F17C163;
        Mon, 20 Mar 2023 07:44:36 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so16743826pjt.2;
        Mon, 20 Mar 2023 07:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679323476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hf3gRKGEzXkyWVAG2dEyFqi1/XxKRGGVjOETTiZLoYA=;
        b=i7p9jOLfKKDLeTfpyYWy7C7cs5eDcLLglS6iEXPl+/oEKtAHSdTCq+sXrgoFVTgnBh
         yO/LJxxjlc4i4j4Gpfo7b5bV6E8IV+ozXRsE2nuOP72UKaer0gQmS0XjbLEukYy9sedX
         SaYoXVQRm1mKpUEp+Rp+oOHqLAUTRvy75LyJpqxPjX1E4yGI659Z5jbdr1AhUqIg8ZGY
         9m8+Ebx7hi28bYL7sY3q3N76MYvrrm0wctvT0G6ckOGnllmePPey2ZsBmbAkDYhbm9B/
         0R/LZDOxfzN895K5eve2Y/x4ONk1eKB6TlASR1TM531IYadPx91JYD3h7Mz0jK6kyCNF
         uJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679323476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hf3gRKGEzXkyWVAG2dEyFqi1/XxKRGGVjOETTiZLoYA=;
        b=f/JdjNE1ctlCbvLQioRQbFu/nNu/wWiElDyhapm8cx7GPnM3RI+XSnHUKmqqc4GKeR
         AVEPXnTTijMq44fTsqHsYpHbzD/srl2lEy7dtj9evrTa8kgb78UGodH8GnTO0frwxZrH
         QXtYAOQQRoESdv8j6pk4Ma5ZJDk4J4T9Dcs4/vgfBL55hIZ52meadJ2Ox0k/vEv9a1gg
         S4nMGoeb/ZLJ7yJyYNgb+1hBPVjb4CSEAgW2gOsdIwTB83Rq5aZVTYfI2vjm3ZoZYBK+
         d03NmL3V1Lxvj5dqI54b6tx39dlj7ZPRHYRuxQtvux1mvim0q4LZbXizKMKoA8U11c0X
         vaeA==
X-Gm-Message-State: AO0yUKWIciUSPSRCaSjdwW05XOsozs99Ro0U3khcrL2FIcIs/8iDgpoi
        3c0XoP/7fNeGgVAuOlnjA9M=
X-Google-Smtp-Source: AK7set98LfakjnQuCwWj87usLvTm+iSmEV2T6zF1D7b1lOmHRdqRxvvEGo8C9by30PXh5dsVOb6A1Q==
X-Received: by 2002:a17:903:28c3:b0:19e:ecaf:c4b4 with SMTP id kv3-20020a17090328c300b0019eecafc4b4mr14765234plb.4.1679323476396;
        Mon, 20 Mar 2023 07:44:36 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id n20-20020a170902d0d400b0019c901b35ecsm6822551pln.106.2023.03.20.07.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 07:44:36 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 03/23] drm/msm/gem: Tidy up VMA API
Date:   Mon, 20 Mar 2023 07:43:25 -0700
Message-Id: <20230320144356.803762-4-robdclark@gmail.com>
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

Stop open coding VMA construction, which will be needed in the next
commit.  And since the VMA already has a ptr to the adress space, stop
passing that around everywhere.  (Also, an aspace always has an mmu so
we can drop a couple pointless NULL checks.)

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gem.c        | 18 +++++-----
 drivers/gpu/drm/msm/msm_gem.h        | 18 ++++------
 drivers/gpu/drm/msm/msm_gem_submit.c |  2 +-
 drivers/gpu/drm/msm/msm_gem_vma.c    | 51 ++++++++++++++++++----------
 drivers/gpu/drm/msm/msm_ringbuffer.c |  2 +-
 5 files changed, 51 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 1dee0d18abbb..6734aecf0703 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -309,12 +309,10 @@ static struct msm_gem_vma *add_vma(struct drm_gem_object *obj,
 
 	msm_gem_assert_locked(obj);
 
-	vma = kzalloc(sizeof(*vma), GFP_KERNEL);
+	vma = msm_gem_vma_new(aspace);
 	if (!vma)
 		return ERR_PTR(-ENOMEM);
 
-	vma->aspace = aspace;
-
 	list_add_tail(&vma->list, &msm_obj->vmas);
 
 	return vma;
@@ -361,9 +359,9 @@ put_iova_spaces(struct drm_gem_object *obj, bool close)
 
 	list_for_each_entry(vma, &msm_obj->vmas, list) {
 		if (vma->aspace) {
-			msm_gem_purge_vma(vma->aspace, vma);
+			msm_gem_vma_purge(vma);
 			if (close)
-				msm_gem_close_vma(vma->aspace, vma);
+				msm_gem_vma_close(vma);
 		}
 	}
 }
@@ -399,7 +397,7 @@ static struct msm_gem_vma *get_vma_locked(struct drm_gem_object *obj,
 		if (IS_ERR(vma))
 			return vma;
 
-		ret = msm_gem_init_vma(aspace, vma, obj->size,
+		ret = msm_gem_vma_init(vma, obj->size,
 			range_start, range_end);
 		if (ret) {
 			del_vma(vma);
@@ -437,7 +435,7 @@ int msm_gem_pin_vma_locked(struct drm_gem_object *obj, struct msm_gem_vma *vma)
 	if (IS_ERR(pages))
 		return PTR_ERR(pages);
 
-	ret = msm_gem_map_vma(vma->aspace, vma, prot, msm_obj->sgt, obj->size);
+	ret = msm_gem_vma_map(vma, prot, msm_obj->sgt, obj->size);
 	if (ret)
 		msm_gem_unpin_locked(obj);
 
@@ -539,8 +537,8 @@ static int clear_iova(struct drm_gem_object *obj,
 	if (msm_gem_vma_inuse(vma))
 		return -EBUSY;
 
-	msm_gem_purge_vma(vma->aspace, vma);
-	msm_gem_close_vma(vma->aspace, vma);
+	msm_gem_vma_purge(vma);
+	msm_gem_vma_close(vma);
 	del_vma(vma);
 
 	return 0;
@@ -589,7 +587,7 @@ void msm_gem_unpin_iova(struct drm_gem_object *obj,
 	msm_gem_lock(obj);
 	vma = lookup_vma(obj, aspace);
 	if (!GEM_WARN_ON(!vma)) {
-		msm_gem_unpin_vma(vma);
+		msm_gem_vma_unpin(vma);
 		msm_gem_unpin_locked(obj);
 	}
 	msm_gem_unlock(obj);
diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index c4844cf3a585..d3219c523034 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -69,19 +69,15 @@ struct msm_gem_vma {
 	struct msm_fence_context *fctx[MSM_GPU_MAX_RINGS];
 };
 
-int msm_gem_init_vma(struct msm_gem_address_space *aspace,
-		struct msm_gem_vma *vma, int size,
+struct msm_gem_vma *msm_gem_vma_new(struct msm_gem_address_space *aspace);
+int msm_gem_vma_init(struct msm_gem_vma *vma, int size,
 		u64 range_start, u64 range_end);
 bool msm_gem_vma_inuse(struct msm_gem_vma *vma);
-void msm_gem_purge_vma(struct msm_gem_address_space *aspace,
-		struct msm_gem_vma *vma);
-void msm_gem_unpin_vma(struct msm_gem_vma *vma);
-void msm_gem_unpin_vma_fenced(struct msm_gem_vma *vma, struct msm_fence_context *fctx);
-int msm_gem_map_vma(struct msm_gem_address_space *aspace,
-		struct msm_gem_vma *vma, int prot,
-		struct sg_table *sgt, int size);
-void msm_gem_close_vma(struct msm_gem_address_space *aspace,
-		struct msm_gem_vma *vma);
+void msm_gem_vma_purge(struct msm_gem_vma *vma);
+void msm_gem_vma_unpin(struct msm_gem_vma *vma);
+void msm_gem_vma_unpin_fenced(struct msm_gem_vma *vma, struct msm_fence_context *fctx);
+int msm_gem_vma_map(struct msm_gem_vma *vma, int prot, struct sg_table *sgt, int size);
+void msm_gem_vma_close(struct msm_gem_vma *vma);
 
 struct msm_gem_object {
 	struct drm_gem_object base;
diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index 2570c018b0cb..1d8e7c2a8024 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -249,7 +249,7 @@ static void submit_cleanup_bo(struct msm_gem_submit *submit, int i,
 	submit->bos[i].flags &= ~cleanup_flags;
 
 	if (flags & BO_VMA_PINNED)
-		msm_gem_unpin_vma(submit->bos[i].vma);
+		msm_gem_vma_unpin(submit->bos[i].vma);
 
 	if (flags & BO_OBJ_PINNED)
 		msm_gem_unpin_locked(obj);
diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index c471aebcdbab..2827679dc39a 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -56,9 +56,9 @@ bool msm_gem_vma_inuse(struct msm_gem_vma *vma)
 }
 
 /* Actually unmap memory for the vma */
-void msm_gem_purge_vma(struct msm_gem_address_space *aspace,
-		struct msm_gem_vma *vma)
+void msm_gem_vma_purge(struct msm_gem_vma *vma)
 {
+	struct msm_gem_address_space *aspace = vma->aspace;
 	unsigned size = vma->node.size;
 
 	/* Print a message if we try to purge a vma in use */
@@ -68,14 +68,13 @@ void msm_gem_purge_vma(struct msm_gem_address_space *aspace,
 	if (!vma->mapped)
 		return;
 
-	if (aspace->mmu)
-		aspace->mmu->funcs->unmap(aspace->mmu, vma->iova, size);
+	aspace->mmu->funcs->unmap(aspace->mmu, vma->iova, size);
 
 	vma->mapped = false;
 }
 
 /* Remove reference counts for the mapping */
-void msm_gem_unpin_vma(struct msm_gem_vma *vma)
+void msm_gem_vma_unpin(struct msm_gem_vma *vma)
 {
 	if (GEM_WARN_ON(!vma->inuse))
 		return;
@@ -84,21 +83,21 @@ void msm_gem_unpin_vma(struct msm_gem_vma *vma)
 }
 
 /* Replace pin reference with fence: */
-void msm_gem_unpin_vma_fenced(struct msm_gem_vma *vma, struct msm_fence_context *fctx)
+void msm_gem_vma_unpin_fenced(struct msm_gem_vma *vma, struct msm_fence_context *fctx)
 {
 	vma->fctx[fctx->index] = fctx;
 	vma->fence[fctx->index] = fctx->last_fence;
 	vma->fence_mask |= BIT(fctx->index);
-	msm_gem_unpin_vma(vma);
+	msm_gem_vma_unpin(vma);
 }
 
 /* Map and pin vma: */
 int
-msm_gem_map_vma(struct msm_gem_address_space *aspace,
-		struct msm_gem_vma *vma, int prot,
+msm_gem_vma_map(struct msm_gem_vma *vma, int prot,
 		struct sg_table *sgt, int size)
 {
-	int ret = 0;
+	struct msm_gem_address_space *aspace = vma->aspace;
+	int ret;
 
 	if (GEM_WARN_ON(!vma->iova))
 		return -EINVAL;
@@ -111,9 +110,10 @@ msm_gem_map_vma(struct msm_gem_address_space *aspace,
 
 	vma->mapped = true;
 
-	if (aspace && aspace->mmu)
-		ret = aspace->mmu->funcs->map(aspace->mmu, vma->iova, sgt,
-				size, prot);
+	if (!aspace)
+		return 0;
+
+	ret = aspace->mmu->funcs->map(aspace->mmu, vma->iova, sgt, size, prot);
 
 	if (ret) {
 		vma->mapped = false;
@@ -124,9 +124,10 @@ msm_gem_map_vma(struct msm_gem_address_space *aspace,
 }
 
 /* Close an iova.  Warn if it is still in use */
-void msm_gem_close_vma(struct msm_gem_address_space *aspace,
-		struct msm_gem_vma *vma)
+void msm_gem_vma_close(struct msm_gem_vma *vma)
 {
+	struct msm_gem_address_space *aspace = vma->aspace;
+
 	GEM_WARN_ON(msm_gem_vma_inuse(vma) || vma->mapped);
 
 	spin_lock(&aspace->lock);
@@ -139,13 +140,29 @@ void msm_gem_close_vma(struct msm_gem_address_space *aspace,
 	msm_gem_address_space_put(aspace);
 }
 
+struct msm_gem_vma *msm_gem_vma_new(struct msm_gem_address_space *aspace)
+{
+	struct msm_gem_vma *vma;
+
+	vma = kzalloc(sizeof(*vma), GFP_KERNEL);
+	if (!vma)
+		return NULL;
+
+	vma->aspace = aspace;
+
+	return vma;
+}
+
 /* Initialize a new vma and allocate an iova for it */
-int msm_gem_init_vma(struct msm_gem_address_space *aspace,
-		struct msm_gem_vma *vma, int size,
+int msm_gem_vma_init(struct msm_gem_vma *vma, int size,
 		u64 range_start, u64 range_end)
 {
+	struct msm_gem_address_space *aspace = vma->aspace;
 	int ret;
 
+	if (GEM_WARN_ON(!aspace))
+		return -EINVAL;
+
 	if (GEM_WARN_ON(vma->iova))
 		return -EBUSY;
 
diff --git a/drivers/gpu/drm/msm/msm_ringbuffer.c b/drivers/gpu/drm/msm/msm_ringbuffer.c
index a80447c8764e..44a22b283730 100644
--- a/drivers/gpu/drm/msm/msm_ringbuffer.c
+++ b/drivers/gpu/drm/msm/msm_ringbuffer.c
@@ -24,7 +24,7 @@ static struct dma_fence *msm_job_run(struct drm_sched_job *job)
 		struct drm_gem_object *obj = &submit->bos[i].obj->base;
 
 		msm_gem_lock(obj);
-		msm_gem_unpin_vma_fenced(submit->bos[i].vma, fctx);
+		msm_gem_vma_unpin_fenced(submit->bos[i].vma, fctx);
 		msm_gem_unpin_locked(obj);
 		msm_gem_unlock(obj);
 		submit->bos[i].flags &= ~(BO_VMA_PINNED | BO_OBJ_PINNED);
-- 
2.39.2


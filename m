Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9C66C1554
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjCTOpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbjCTOpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:45:02 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F5910265;
        Mon, 20 Mar 2023 07:44:46 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso12639449pjb.2;
        Mon, 20 Mar 2023 07:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679323485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvDnw/hu64TENUPK8m8D4yt/NQNmhsgmGrwCJ9nCNhY=;
        b=jlcDy40aN1C5W1PLwaX4PT68HHflsCb69nfPT5Mi2J1S7Qq1tRG0GAOAQHkiHtdcCy
         iNug8vLQ8xaQ3qf7jD3h5se9ru7MEdY5XzpzPfu30BNzsr+kCLJIMC2qgCWksB3TfULr
         C0HH4ohgE/qt4zDYn/gl50baSa9FCCVioEa/RKjXuglOUQAHyvveIbecf1DyIvWWBr7h
         rb38OKulT20czvObsf/dBJ6ULSgo5Y2RK4REckQlYRFciYHUUMWxI+eEX05p21E9RW/b
         y9sbREQwwWG0DhPeFmwNvi4ujTSVJ2KOn64Q4QXMFkj3NwOJf/Oa0w//tMSz/dwdwEFh
         Lviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679323485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yvDnw/hu64TENUPK8m8D4yt/NQNmhsgmGrwCJ9nCNhY=;
        b=gJqSAAcs3NtT7gSuVFrgFpgbOC5PIew/iYfvrpyw9Dlnb+ZzZGGJrvIK9tBVe+24BL
         79whdlZZqvahoQ0oZrmgZYqshJvdu9A05QTAoUoUBEi0QA4RaXPSNO7qqjlHkvDdZq38
         W+a/V+4VimFBFYZx52/NanLt0sHtOcC/ySlPJzaXzXXjLStmAk7ZFXzBNML6SpVgytsj
         t77E198epkXsSZYKwTHV6K1tu8UX3fZiYaajFUVaOcV6vNZJbqvCMQk2RJZg1y/9ak/0
         WAzhVMEvH+tWk8hKV31SzbZy08q8nC5WciZkyiu73S2C0gOhzWy6mbre6Ib7cGfrOT6I
         czzg==
X-Gm-Message-State: AO0yUKW1BUXBbS4H7wQkUiDy0a8m2Y3fPVThmaPHJ+PAV8eObZ761kaP
        uANymiRN9i4tGb7FwqAwUHk=
X-Google-Smtp-Source: AK7set+ey4SfRsKMXYlfJLMQ2jDvdVx2AebAv6ewBzlhcdkWDA/UUjxaowJxpOGwVjOUPrOQI3xzKw==
X-Received: by 2002:a05:6a20:1b05:b0:da:5e10:799b with SMTP id ch5-20020a056a201b0500b000da5e10799bmr103078pzb.10.1679323485207;
        Mon, 20 Mar 2023 07:44:45 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id k23-20020aa790d7000000b006247123adf1sm6626822pfk.143.2023.03.20.07.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 07:44:44 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 08/23] drm/msm/gem: Protect pin_count/madv by LRU lock
Date:   Mon, 20 Mar 2023 07:43:30 -0700
Message-Id: <20230320144356.803762-9-robdclark@gmail.com>
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

Since the LRU lock is already acquired when moving an obj between LRUs,
we can use it to protect pin_count and madv, without any significant
change in locking (ie. it just expands the scope of the lock by a hand-
ful of instructions).  This prepares the way to decrement the pin_count
in the job_run() path without needing to hold the obj lock, to avoid a
potential deadlock (or rather stall) caused by the fence-signaling path
(job_run()) blocking on shrinker/reclaim.  (Only a stall because the
wait for fence signaling wait_for_idle() is not infinite.)

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gem.c | 48 ++++++++++++++++++++++++++---------
 drivers/gpu/drm/msm/msm_gem.h |  9 ++++++-
 2 files changed, 44 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index c97dddf3e2f2..d0ac3e704b66 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -61,7 +61,7 @@ static void sync_for_cpu(struct msm_gem_object *msm_obj)
 	dma_unmap_sgtable(dev, msm_obj->sgt, DMA_BIDIRECTIONAL, 0);
 }
 
-static void update_lru(struct drm_gem_object *obj)
+static void update_lru_locked(struct drm_gem_object *obj)
 {
 	struct msm_drm_private *priv = obj->dev->dev_private;
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
@@ -71,18 +71,27 @@ static void update_lru(struct drm_gem_object *obj)
 	if (!msm_obj->pages) {
 		GEM_WARN_ON(msm_obj->pin_count);
 
-		drm_gem_lru_move_tail(&priv->lru.unbacked, obj);
+		drm_gem_lru_move_tail_locked(&priv->lru.unbacked, obj);
 	} else if (msm_obj->pin_count) {
-		drm_gem_lru_move_tail(&priv->lru.pinned, obj);
+		drm_gem_lru_move_tail_locked(&priv->lru.pinned, obj);
 	} else if (msm_obj->madv == MSM_MADV_WILLNEED) {
-		drm_gem_lru_move_tail(&priv->lru.willneed, obj);
+		drm_gem_lru_move_tail_locked(&priv->lru.willneed, obj);
 	} else {
 		GEM_WARN_ON(msm_obj->madv != MSM_MADV_DONTNEED);
 
-		drm_gem_lru_move_tail(&priv->lru.dontneed, obj);
+		drm_gem_lru_move_tail_locked(&priv->lru.dontneed, obj);
 	}
 }
 
+static void update_lru(struct drm_gem_object *obj)
+{
+	struct msm_drm_private *priv = obj->dev->dev_private;
+
+	mutex_lock(&priv->lru.lock);
+	update_lru_locked(obj);
+	mutex_unlock(&priv->lru.lock);
+}
+
 /* allocate pages from VRAM carveout, used when no IOMMU: */
 static struct page **get_pages_vram(struct drm_gem_object *obj, int npages)
 {
@@ -200,6 +209,7 @@ static void put_pages(struct drm_gem_object *obj)
 
 static struct page **msm_gem_pin_pages_locked(struct drm_gem_object *obj)
 {
+	struct msm_drm_private *priv = obj->dev->dev_private;
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
 	struct page **p;
 
@@ -210,10 +220,13 @@ static struct page **msm_gem_pin_pages_locked(struct drm_gem_object *obj)
 	}
 
 	p = get_pages(obj);
-	if (!IS_ERR(p)) {
-		to_msm_bo(obj)->pin_count++;
-		update_lru(obj);
-	}
+	if (IS_ERR(p))
+		return p;
+
+	mutex_lock(&priv->lru.lock);
+	msm_obj->pin_count++;
+	update_lru_locked(obj);
+	mutex_unlock(&priv->lru.lock);
 
 	return p;
 }
@@ -464,14 +477,16 @@ int msm_gem_pin_vma_locked(struct drm_gem_object *obj, struct msm_gem_vma *vma)
 
 void msm_gem_unpin_locked(struct drm_gem_object *obj)
 {
+	struct msm_drm_private *priv = obj->dev->dev_private;
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
 
 	msm_gem_assert_locked(obj);
 
+	mutex_lock(&priv->lru.lock);
 	msm_obj->pin_count--;
 	GEM_WARN_ON(msm_obj->pin_count < 0);
-
-	update_lru(obj);
+	update_lru_locked(obj);
+	mutex_unlock(&priv->lru.lock);
 }
 
 struct msm_gem_vma *msm_gem_get_vma_locked(struct drm_gem_object *obj,
@@ -739,10 +754,13 @@ void msm_gem_put_vaddr(struct drm_gem_object *obj)
  */
 int msm_gem_madvise(struct drm_gem_object *obj, unsigned madv)
 {
+	struct msm_drm_private *priv = obj->dev->dev_private;
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
 
 	msm_gem_lock(obj);
 
+	mutex_lock(&priv->lru.lock);
+
 	if (msm_obj->madv != __MSM_MADV_PURGED)
 		msm_obj->madv = madv;
 
@@ -751,7 +769,9 @@ int msm_gem_madvise(struct drm_gem_object *obj, unsigned madv)
 	/* If the obj is inactive, we might need to move it
 	 * between inactive lists
 	 */
-	update_lru(obj);
+	update_lru_locked(obj);
+
+	mutex_unlock(&priv->lru.lock);
 
 	msm_gem_unlock(obj);
 
@@ -761,6 +781,7 @@ int msm_gem_madvise(struct drm_gem_object *obj, unsigned madv)
 void msm_gem_purge(struct drm_gem_object *obj)
 {
 	struct drm_device *dev = obj->dev;
+	struct msm_drm_private *priv = obj->dev->dev_private;
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
 
 	msm_gem_assert_locked(obj);
@@ -777,7 +798,10 @@ void msm_gem_purge(struct drm_gem_object *obj)
 
 	put_iova_vmas(obj);
 
+	mutex_lock(&priv->lru.lock);
+	/* A one-way transition: */
 	msm_obj->madv = __MSM_MADV_PURGED;
+	mutex_unlock(&priv->lru.lock);
 
 	drm_gem_free_mmap_offset(obj);
 
diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index 1929f09c5b0d..0057e8e8fa13 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -86,7 +86,9 @@ struct msm_gem_object {
 	uint32_t flags;
 
 	/**
-	 * Advice: are the backing pages purgeable?
+	 * madv: are the backing pages purgeable?
+	 *
+	 * Protected by obj lock and LRU lock
 	 */
 	uint8_t madv;
 
@@ -114,6 +116,11 @@ struct msm_gem_object {
 
 	char name[32]; /* Identifier to print for the debugfs files */
 
+	/**
+	 * pin_count: Number of times the pages are pinned
+	 *
+	 * Protected by LRU lock.
+	 */
 	int pin_count;
 };
 #define to_msm_bo(x) container_of(x, struct msm_gem_object, base)
-- 
2.39.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67AA56C1555
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjCTOpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbjCTOpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:45:06 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50481AD2A;
        Mon, 20 Mar 2023 07:44:50 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id j13so12352669pjd.1;
        Mon, 20 Mar 2023 07:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679323489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y74KF7H2nPAn1GkAkMf3ALBkHME3mvlc137TFEwpI5M=;
        b=KDNXAyKxSPxmqCM1goz2ei4OMneXayGq4rDfE6Qgq1VIyE6guRUWAO1mZzPWwgIP26
         JYt+JAaoGORRqU5CpZfLxhpnaTqa15rJPVrROZd2PP5/Wrv+L91VA5PRNhE4DIVA3ZzB
         OFZzSBuKsPmYl+P7Ixx+dBJft1d8cUSoVWPBMVB/TZ2/y4+0WwyogGQnGsgpycK2T+HC
         4AeAWwpByzuLtol49nW1nmtPSxhPBjJAzk4GYtsHsq6Xqba8j2nOOgS7lDgcUfg6PO4d
         9Babeqe7rFqMFE/ieZ97Gbuj0CUvKp6/l1e4DET+Plb6nHmPrw2kqMuYyB3AqKl+6N11
         miDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679323489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y74KF7H2nPAn1GkAkMf3ALBkHME3mvlc137TFEwpI5M=;
        b=sq3IHapkhrPVovMiDukpUvwyomSC4duPHeo1n081YL97mpu5si+sNgRcOsTrIvOIST
         PZrdqBCbqiCmZT0NoUMqcB98RBKGNpfuLZSrXE/gBXR8wmqHMAhZVaXju+F06UC4ffZR
         FhQ+0nevaXMSLWxlEqnOjCuf4PwHNFLxbDPN7YFVidxHo3FXXKZza6vJ2CSUyzIYFPN7
         sIarBEzLAzgILIqQI2vyHTuts8omwayEPQtr+3kFWLSqEX25kIPbNfKPbviCAvog4B85
         CRV0SklwNateH/CFda7Zu+4NUSnyynA9toohccnDq0655HqDOnFPPQmQ25IGczhpuHX5
         +LTw==
X-Gm-Message-State: AO0yUKVZ8VwqgciSVukiAqf9K4f+mVoPYiIicJ7D05IbWQazxWrdkV9Q
        ySBaTfiAh0UK1QN7ttr93A8=
X-Google-Smtp-Source: AK7set9ZUleUp5mEZ/nimYP6FtanqkhrK9z8SGzJ4pCwCjW9CpDQ3yDpgBO1I4IgNMmovbqGg0F/ng==
X-Received: by 2002:a17:902:c40c:b0:19a:a815:2868 with SMTP id k12-20020a170902c40c00b0019aa8152868mr21846958plk.44.1679323488934;
        Mon, 20 Mar 2023 07:44:48 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id j3-20020a170902c3c300b001a072be70desm6828123plj.41.2023.03.20.07.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 07:44:48 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 10/23] drm/msm: Switch idr_lock to spinlock
Date:   Mon, 20 Mar 2023 07:43:32 -0700
Message-Id: <20230320144356.803762-11-robdclark@gmail.com>
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

Needed to idr_preload() which returns with preemption disabled.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_drv.c         |  6 ++----
 drivers/gpu/drm/msm/msm_gem_submit.c  | 10 +++++-----
 drivers/gpu/drm/msm/msm_gpu.h         |  2 +-
 drivers/gpu/drm/msm/msm_submitqueue.c |  2 +-
 4 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index aca48c868c14..ce1a77b607d1 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -918,13 +918,11 @@ static int wait_fence(struct msm_gpu_submitqueue *queue, uint32_t fence_id,
 	 * retired, so if the fence is not found it means there is nothing
 	 * to wait for
 	 */
-	ret = mutex_lock_interruptible(&queue->idr_lock);
-	if (ret)
-		return ret;
+	spin_lock(&queue->idr_lock);
 	fence = idr_find(&queue->fence_idr, fence_id);
 	if (fence)
 		fence = dma_fence_get_rcu(fence);
-	mutex_unlock(&queue->idr_lock);
+	spin_unlock(&queue->idr_lock);
 
 	if (!fence)
 		return 0;
diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index 1d8e7c2a8024..b9d81e5acb42 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -79,9 +79,9 @@ void __msm_gem_submit_destroy(struct kref *kref)
 	unsigned i;
 
 	if (submit->fence_id) {
-		mutex_lock(&submit->queue->idr_lock);
+		spin_lock(&submit->queue->idr_lock);
 		idr_remove(&submit->queue->fence_idr, submit->fence_id);
-		mutex_unlock(&submit->queue->idr_lock);
+		spin_unlock(&submit->queue->idr_lock);
 	}
 
 	dma_fence_put(submit->user_fence);
@@ -882,7 +882,7 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 
 	submit->nr_cmds = i;
 
-	mutex_lock(&queue->idr_lock);
+	spin_lock(&queue->idr_lock);
 
 	/*
 	 * If using userspace provided seqno fence, validate that the id
@@ -892,7 +892,7 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 	 */
 	if ((args->flags & MSM_SUBMIT_FENCE_SN_IN) &&
 			idr_find(&queue->fence_idr, args->fence)) {
-		mutex_unlock(&queue->idr_lock);
+		spin_unlock(&queue->idr_lock);
 		ret = -EINVAL;
 		goto out;
 	}
@@ -926,7 +926,7 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 						    INT_MAX, GFP_KERNEL);
 	}
 
-	mutex_unlock(&queue->idr_lock);
+	spin_unlock(&queue->idr_lock);
 
 	if (submit->fence_id < 0) {
 		ret = submit->fence_id;
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index fc1c0d8611a8..5929ecaa1fcd 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -499,7 +499,7 @@ struct msm_gpu_submitqueue {
 	struct msm_file_private *ctx;
 	struct list_head node;
 	struct idr fence_idr;
-	struct mutex idr_lock;
+	struct spinlock idr_lock;
 	struct mutex lock;
 	struct kref ref;
 	struct drm_sched_entity *entity;
diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/msm/msm_submitqueue.c
index c6929e205b51..0e803125a325 100644
--- a/drivers/gpu/drm/msm/msm_submitqueue.c
+++ b/drivers/gpu/drm/msm/msm_submitqueue.c
@@ -200,7 +200,7 @@ int msm_submitqueue_create(struct drm_device *drm, struct msm_file_private *ctx,
 		*id = queue->id;
 
 	idr_init(&queue->fence_idr);
-	mutex_init(&queue->idr_lock);
+	spin_lock_init(&queue->idr_lock);
 	mutex_init(&queue->lock);
 
 	list_add_tail(&queue->node, &ctx->submitqueues);
-- 
2.39.2


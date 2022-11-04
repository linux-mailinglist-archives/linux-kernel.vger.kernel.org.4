Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B32619C26
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 16:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbiKDPwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 11:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiKDPwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 11:52:11 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1602D763;
        Fri,  4 Nov 2022 08:52:08 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso8634165pjc.0;
        Fri, 04 Nov 2022 08:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h91PY4kE003Fzt7Dp6s2LtF8+Ku5gtgrJGFgjbiXW0Y=;
        b=fZfNmpLbARw2htsWecPLMgqjYPXVCha4yMS8ZDbD2ibFKN0J+n0z1donudEwT68czq
         a0Napturob7ia7xuzL1aB8P2BRUnsbBoS56zzlP4bsMwS3v0iD1ekMG6/YiSja5OdMBh
         ZCp/Zuw4eFXMl/9YJFXMK7h0CS5Ws0Jx7n+Kbc3sXjDM8Lu7Vg6FRDU0RqK/bDLQCZOi
         obao476g+hOwqCoByP4oL/i2QR58pWgfSbrhdrn5d0YF+Ifeqb2RFpTqn99sjrMwzQva
         xg2F99kYPErdBIQAkV2v+HdMxcyQ923U6Dvjb8E1W3FPlEvL4id57fFAJYKXEcJuUpNa
         SVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h91PY4kE003Fzt7Dp6s2LtF8+Ku5gtgrJGFgjbiXW0Y=;
        b=APKqNQhpKUOKfUM8/zdN47R2aw14vYM5q8mB3whvG+pSU4WRuvUIIxuRUMOPROMEKy
         x++KxBksvIgom0S1oEaAyHj9DiPxvAFfXVLV3Yu3v/l6zU01jSaDgrudwFuTZ5IoDzpa
         dyG10K6sP6qZkANyju8JKNro6sLJzf+x2GXxcLUc++pt+ufDeKTiddLXZIE7pO8n0eTa
         S3Tr76Osb0D0B8iCOdY0Pl2cswceI6CunW+3bkSa6VzDSnl6S+QYweV5DwelaP36BuTI
         zhO6dsW+kcnIlX98IPm5zbaKZt63QXaIjcEv53rRgLoMbTnsRg+5w5n/eR+qBALvHKSM
         zeEg==
X-Gm-Message-State: ACrzQf00ahYgFFyhSBcvXlRY5IEead6rMo0kGvOrQyRz1L1zHnItLBsE
        U6NI8r9E1G2kaFtK5ddA2s0=
X-Google-Smtp-Source: AMsMyM6zNFvjaDiCUgUsJtKWxaFpLMuqPLYgtr1mX1+M2ATzrBZKD/U5nCh1sXRpFzk8ueJiv0U/Yg==
X-Received: by 2002:a17:90b:152:b0:213:dfd6:3e5e with SMTP id em18-20020a17090b015200b00213dfd63e5emr27484666pjb.229.1667577127429;
        Fri, 04 Nov 2022 08:52:07 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id j4-20020a17090ac48400b002130c269b6fsm1868454pjt.1.2022.11.04.08.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 08:52:07 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC] drm/msm: Boost on waits
Date:   Fri,  4 Nov 2022 08:52:29 -0700
Message-Id: <20221104155229.528193-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.38.1
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

Minimize interactive latency by boosting frequency when userspace is
waiting on the GPU to finish.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
I did contemplate also boosting on dma_fence_wait(), but (a) that would
require some extra plumbing thru gpu-sched, (b) that only captures a
sub-set of wait-on-dma-fence patterns, and (c) waiting on a dma-fence
doesn't always imply urgency (for ex, virglrenderer poll()ing on a dma-
fence to know when to send a fence irq to VM guest).  But the driver
WAIT_FENCE and CPU_PREP ioctls map to things like glFinish() where it
is pretty clear that there is something wishing the GPU would finish
sooner.

 drivers/gpu/drm/msm/msm_drv.c         | 7 +++++--
 drivers/gpu/drm/msm/msm_gem.c         | 6 ++++++
 drivers/gpu/drm/msm/msm_gpu_devfreq.c | 2 +-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index c3b77b44b2aa..017a512982a2 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -894,7 +894,7 @@ static int msm_ioctl_gem_info(struct drm_device *dev, void *data,
 }
 
 static int wait_fence(struct msm_gpu_submitqueue *queue, uint32_t fence_id,
-		      ktime_t timeout)
+		      ktime_t timeout, struct msm_gpu *gpu)
 {
 	struct dma_fence *fence;
 	int ret;
@@ -924,6 +924,9 @@ static int wait_fence(struct msm_gpu_submitqueue *queue, uint32_t fence_id,
 	if (!fence)
 		return 0;
 
+	if (!dma_fence_is_signaled(fence))
+		msm_devfreq_boost(gpu, 2);
+
 	ret = dma_fence_wait_timeout(fence, true, timeout_to_jiffies(&timeout));
 	if (ret == 0) {
 		ret = -ETIMEDOUT;
@@ -956,7 +959,7 @@ static int msm_ioctl_wait_fence(struct drm_device *dev, void *data,
 	if (!queue)
 		return -ENOENT;
 
-	ret = wait_fence(queue, args->fence, to_ktime(args->timeout));
+	ret = wait_fence(queue, args->fence, to_ktime(args->timeout), priv->gpu);
 
 	msm_submitqueue_put(queue);
 
diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 1dee0d18abbb..fbda0e3a94f8 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -846,6 +846,12 @@ int msm_gem_cpu_prep(struct drm_gem_object *obj, uint32_t op, ktime_t *timeout)
 		op & MSM_PREP_NOSYNC ? 0 : timeout_to_jiffies(timeout);
 	long ret;
 
+	if (!dma_resv_test_signaled(obj->resv, dma_resv_usage_rw(write))) {
+		struct msm_drm_private *priv = obj->dev->dev_private;
+
+		msm_devfreq_boost(priv->gpu, 2);
+	}
+
 	ret = dma_resv_wait_timeout(obj->resv, dma_resv_usage_rw(write),
 				    true,  remain);
 	if (ret == 0)
diff --git a/drivers/gpu/drm/msm/msm_gpu_devfreq.c b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
index 85c443a37e4e..025940eb08d1 100644
--- a/drivers/gpu/drm/msm/msm_gpu_devfreq.c
+++ b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
@@ -305,7 +305,7 @@ void msm_devfreq_boost(struct msm_gpu *gpu, unsigned factor)
 	struct msm_gpu_devfreq *df = &gpu->devfreq;
 	uint64_t freq;
 
-	if (!has_devfreq(gpu))
+	if (!gpu || !has_devfreq(gpu))
 		return;
 
 	freq = get_freq(gpu);
-- 
2.38.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504966A4B3A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 20:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjB0ThL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 14:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjB0Tg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 14:36:57 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0ADE27491;
        Mon, 27 Feb 2023 11:36:26 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 132so4216780pgh.13;
        Mon, 27 Feb 2023 11:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0EqwRq/t+KHhVrbIAD1sooBDZlG3nzxQWus7/my7j0s=;
        b=Ohm4qX62pfkC+TDoeherf/ovCUKtkTB2NZ8qoFno7AE7iz7x93T1tO2cavSDKilBF0
         P0slS20KbsYARBD5IjBmANiqIJ3AyKXZT+Q7cZJoDsZ6OEsXG3RrETjKlmqAiPtZTFjo
         agIj+GvVUL7OsIuSHmZqAbFKzV8t3znXW7U3r+zsT9yNAahPSJMtNB/TYFM+3zh8Nno2
         l6SVLWzMdf28OvHabaZJR9Ivdy+UiyHAJsxSCC7isQLSREoaoQZwsgQ2o9AdKwFLQ5ht
         93RvRe7g653mTS6f8DroKAD2WBBpsMrCtZtc19cHQ0J83PJq9+xnbGjCMx+tvAIrtXHn
         dQIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0EqwRq/t+KHhVrbIAD1sooBDZlG3nzxQWus7/my7j0s=;
        b=ZJAMNNkA/ZZqTy9Q7XD6Md4qzuX6Wu44wEfc0O7M9PPV7LO8W85DkQOItfCxyrdD3a
         Iq8urjZo2ZedJmvyzZaljfEJGrwpGo1GzKjwwauMIj7rLPbHK0SHUzNNunzuLPC5zSwx
         6rCNxpCizpZ/QGYDrpjSA6xqETS3wkV7Nw8OyrG4SXHgga6Redg1Y7q6L4+1ZYJUCQw+
         3GQazqUPlfDQd1nK5ENel9raMXEVAQpVC90UmgHPp7WKfv2aSrZEE6jlnZKbphZrvHsZ
         knaV7/sGAMiGFojAOSrXdp0RzbtNVUHjr0+sZVhu8O2/5m8ANWaCwCQG44hrp+KFppdP
         JQxA==
X-Gm-Message-State: AO0yUKUhQ7O73NAmpv0JyskDjZpTjqWF8+dMi2FE9iI/JFFRbQ8je8+N
        pT8jwDBjphzeE7YfiQlz9CY=
X-Google-Smtp-Source: AK7set+Z3e0HCE2sXZ1gBKrBC7BjtQGSWU0HhVWsEWkUBQh5IUxsN0dhLIoPQxz1zlv9Gl0dttteoA==
X-Received: by 2002:aa7:9e8a:0:b0:5db:ba34:36eb with SMTP id p10-20020aa79e8a000000b005dbba3436ebmr84421pfq.16.1677526582823;
        Mon, 27 Feb 2023 11:36:22 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id bm17-20020a056a00321100b005aa80fe8be7sm4540082pfb.67.2023.02.27.11.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 11:36:22 -0800 (PST)
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
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 13/15] drm/msm: Add wait-boost support
Date:   Mon, 27 Feb 2023 11:35:19 -0800
Message-Id: <20230227193535.2822389-14-robdclark@gmail.com>
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

From: Rob Clark <robdclark@chromium.org>

Add a way for various userspace waits to signal urgency.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_drv.c | 12 ++++++++----
 drivers/gpu/drm/msm/msm_gem.c |  5 +++++
 include/uapi/drm/msm_drm.h    | 14 ++++++++++++--
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index aca48c868c14..f6764a86b2da 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -46,6 +46,7 @@
  * - 1.8.0 - Add MSM_BO_CACHED_COHERENT for supported GPUs (a6xx)
  * - 1.9.0 - Add MSM_SUBMIT_FENCE_SN_IN
  * - 1.10.0 - Add MSM_SUBMIT_BO_NO_IMPLICIT
+ * - 1.11.0 - Add wait boost (MSM_WAIT_FENCE_BOOST, MSM_PREP_BOOST)
  */
 #define MSM_VERSION_MAJOR	1
 #define MSM_VERSION_MINOR	10
@@ -899,7 +900,7 @@ static int msm_ioctl_gem_info(struct drm_device *dev, void *data,
 }
 
 static int wait_fence(struct msm_gpu_submitqueue *queue, uint32_t fence_id,
-		      ktime_t timeout)
+		      ktime_t timeout, uint32_t flags)
 {
 	struct dma_fence *fence;
 	int ret;
@@ -929,6 +930,9 @@ static int wait_fence(struct msm_gpu_submitqueue *queue, uint32_t fence_id,
 	if (!fence)
 		return 0;
 
+	if (flags & MSM_WAIT_FENCE_BOOST)
+		dma_fence_set_deadline(fence, ktime_get());
+
 	ret = dma_fence_wait_timeout(fence, true, timeout_to_jiffies(&timeout));
 	if (ret == 0) {
 		ret = -ETIMEDOUT;
@@ -949,8 +953,8 @@ static int msm_ioctl_wait_fence(struct drm_device *dev, void *data,
 	struct msm_gpu_submitqueue *queue;
 	int ret;
 
-	if (args->pad) {
-		DRM_ERROR("invalid pad: %08x\n", args->pad);
+	if (args->flags & ~MSM_WAIT_FENCE_FLAGS) {
+		DRM_ERROR("invalid flags: %08x\n", args->flags);
 		return -EINVAL;
 	}
 
@@ -961,7 +965,7 @@ static int msm_ioctl_wait_fence(struct drm_device *dev, void *data,
 	if (!queue)
 		return -ENOENT;
 
-	ret = wait_fence(queue, args->fence, to_ktime(args->timeout));
+	ret = wait_fence(queue, args->fence, to_ktime(args->timeout), args->flags);
 
 	msm_submitqueue_put(queue);
 
diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 1dee0d18abbb..dd4a0d773f6e 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -846,6 +846,11 @@ int msm_gem_cpu_prep(struct drm_gem_object *obj, uint32_t op, ktime_t *timeout)
 		op & MSM_PREP_NOSYNC ? 0 : timeout_to_jiffies(timeout);
 	long ret;
 
+	if (op & MSM_PREP_BOOST) {
+		dma_resv_set_deadline(obj->resv, dma_resv_usage_rw(write),
+				      ktime_get());
+	}
+
 	ret = dma_resv_wait_timeout(obj->resv, dma_resv_usage_rw(write),
 				    true,  remain);
 	if (ret == 0)
diff --git a/include/uapi/drm/msm_drm.h b/include/uapi/drm/msm_drm.h
index 329100016e7c..dbf0d6f43fa9 100644
--- a/include/uapi/drm/msm_drm.h
+++ b/include/uapi/drm/msm_drm.h
@@ -151,8 +151,13 @@ struct drm_msm_gem_info {
 #define MSM_PREP_READ        0x01
 #define MSM_PREP_WRITE       0x02
 #define MSM_PREP_NOSYNC      0x04
+#define MSM_PREP_BOOST       0x08
 
-#define MSM_PREP_FLAGS       (MSM_PREP_READ | MSM_PREP_WRITE | MSM_PREP_NOSYNC)
+#define MSM_PREP_FLAGS       (MSM_PREP_READ | \
+			      MSM_PREP_WRITE | \
+			      MSM_PREP_NOSYNC | \
+			      MSM_PREP_BOOST | \
+			      0)
 
 struct drm_msm_gem_cpu_prep {
 	__u32 handle;         /* in */
@@ -286,6 +291,11 @@ struct drm_msm_gem_submit {
 
 };
 
+#define MSM_WAIT_FENCE_BOOST	0x00000001
+#define MSM_WAIT_FENCE_FLAGS	( \
+		MSM_WAIT_FENCE_BOOST | \
+		0)
+
 /* The normal way to synchronize with the GPU is just to CPU_PREP on
  * a buffer if you need to access it from the CPU (other cmdstream
  * submission from same or other contexts, PAGE_FLIP ioctl, etc, all
@@ -295,7 +305,7 @@ struct drm_msm_gem_submit {
  */
 struct drm_msm_wait_fence {
 	__u32 fence;          /* in */
-	__u32 pad;
+	__u32 flags;          /* in, bitmask of MSM_WAIT_FENCE_x */
 	struct drm_msm_timespec timeout;   /* in */
 	__u32 queueid;         /* in, submitqueue id */
 };
-- 
2.39.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12A469BC6F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 22:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjBRVRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 16:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjBRVRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 16:17:00 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8983A1716D;
        Sat, 18 Feb 2023 13:16:07 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id e6so1636858plt.4;
        Sat, 18 Feb 2023 13:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4+9NlCagZCbGKQxxC4BQ8mfRmR2+fBQqYmsfk1PWhY=;
        b=UGehYwiIzvpjIvIuTR12x7VpOApVAdubpqJ/+APQRJatYantmnw+npsBYDe0ySf47E
         NjuCruQg92GdH3G8ci+baO0qGGjDlJgLu6hWNcXMOSPFMcCdb78ZxrBkmbLGTM12ni/i
         p8rphRLznoOmXZFZjOhGbs6hW8TAY9bdSzN34GET88uytGMOxnZM39cPBSuhlzVmoktS
         aemNOpgyeXczW44GNA/gYZDDwnox/LfSAxFf/r96vbI6Z2g1h3up4V2pU0KhMXDgqSDy
         QxQM45+gLve3IXw8NPw6me/yH36sAMmXN+EK4axfpoW0FGGQevKtnKZbtqvA5iQlQbvI
         CQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4+9NlCagZCbGKQxxC4BQ8mfRmR2+fBQqYmsfk1PWhY=;
        b=K9FeLMZpycyhNTzvyrQKO3wnCmeRCozinyK7wgtSE+C59aQOIX7+3JZ5DAP21kTtA4
         WAsnOkKzud8jQjTL++IfEatHhdNVgck/IS5InL3KKDUD4OZQmYUm+bUWONnohFu6+Mbk
         Vp2DoQRc5Hbg2XEG5KPQWBWTcjwhIgKjYTdl5rSoYSVUUeDBgWgvFxQMYu8TZm+p8JR3
         G6xsPzdJQA4Ww/ldb4Gq/rBxwW8XCZfGFbB7d1fWAZesGYI2annAPYP05PK+KCGEFMOY
         ujaYMToOnF6VSkxcAG5OIsQ+qsm46WifLqxtvZH05NgVHINQnszlj6l0AkAQY+A3CeRt
         D5RA==
X-Gm-Message-State: AO0yUKUFH8pvnp5PYzbU22uy67EjOIijNafAnop7vkhnMuc28TxQezWu
        YUo0k3M9W/OpK1FyKzpqXUTJ+A8U0xM=
X-Google-Smtp-Source: AK7set/yhbGfC6qosgthQrA4ygnrRGZ8eZLvcs3DQErkjfYGSHtyHxHittapdV6RomTmsZaDYUEMbw==
X-Received: by 2002:a17:903:28c5:b0:19a:abb0:1e with SMTP id kv5-20020a17090328c500b0019aabb0001emr3051010plb.38.1676754966467;
        Sat, 18 Feb 2023 13:16:06 -0800 (PST)
Received: from localhost (c-73-67-135-195.hsd1.or.comcast.net. [73.67.135.195])
        by smtp.gmail.com with ESMTPSA id l11-20020a170902d34b00b0019ac69a6348sm5092542plk.133.2023.02.18.13.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 13:16:06 -0800 (PST)
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
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 13/14] drm/msm: Add wait-boost support
Date:   Sat, 18 Feb 2023 13:15:56 -0800
Message-Id: <20230218211608.1630586-14-robdclark@gmail.com>
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

From: Rob Clark <robdclark@chromium.org>

Add a way for various userspace waits to signal urgency.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_drv.c | 12 ++++++++----
 drivers/gpu/drm/msm/msm_gem.c |  5 +++++
 include/uapi/drm/msm_drm.h    | 14 ++++++++++++--
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index be2a68f8e78d..b5af81a536f7 100644
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


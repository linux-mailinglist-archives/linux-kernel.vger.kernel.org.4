Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3434D6B6B48
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 21:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjCLUm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 16:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjCLUmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 16:42:42 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B253B20D;
        Sun, 12 Mar 2023 13:42:35 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id h8so10821527plf.10;
        Sun, 12 Mar 2023 13:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678653755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kr8/B6ZuKF5w1o2Xbtc5QxJNFXAuL1a2D00htOsDOJ0=;
        b=i6L90ta3FW+HD5hKwf50gFT6MudXIKIxU4z+zs+w0wqd+NNB7XbeRnGj3kQ+EUkJV1
         5kIRjQqyYaDEOYfHWpjlUxIZ0tUB+EyfXAO4mA9lvr/tb/p9RCL5nqMf8ZQdGnZ1gA6D
         Epw9OS3zhuhb2uIAKPhLvEJww2J55PqsV0RYqXovjsQQm3uqbV+7UctYf7VSvaZXSLVl
         YvS8lWAqfL2CbmcqFQOz7WpJGKM4M8G3TET7PxxWDYz7FGqEQz4iyGjCQYz8gcO5kq5M
         pfmCeDJBhAWzo1/jSMNdAQgQyQfvgJq9BXMyspV7n7+iug/HQFP+gsB7v5cjh/lRD/xw
         1B0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678653755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kr8/B6ZuKF5w1o2Xbtc5QxJNFXAuL1a2D00htOsDOJ0=;
        b=NntQx4teN0vWdRETamHW8tW+g9DYvXDNE3EDpFZbxeCeXEWrl+V/w3OXh1C5gFaSVZ
         NdlTiPZw1skv31OzfhFaHOQa/UhaHbKzsFlPOUr+s1XCV70Ea1MyPYRwryYtkRtk+qmv
         /6EqzZXVTMX4IDT27vvYDcmPuYz/k1HBntNMh6F6SyKIZsmyns7VQHzoYw4kOmNJf222
         JuLW7JAdlvBFcIeG9xOyp8/h4IfckrGgnOuFW1+wQni/NA5oIi9Q6zq2zVypCCDGUh9g
         vX1MadyUoVMQfe+3ow08z9OAIxC8bugF5Mp+mfiOyqeZFxr/YzNRIgpqYf5tHN4gfU4a
         Scmg==
X-Gm-Message-State: AO0yUKUYfDAeZUBlZITjSPdsn6qyJjAzu1pvYaHatiruCEfpZ2n6Pw4q
        ENdVnbxQ9RpYvBFiR7m53q4=
X-Google-Smtp-Source: AK7set94mZD1V4cF+2prjJ26GvpuG4rOoe7mSGLRKUTe4xzzOviPtI56XjULkjxk94uDt1ptZAT7gw==
X-Received: by 2002:a05:6a20:8e0a:b0:c7:6a98:5bd8 with SMTP id y10-20020a056a208e0a00b000c76a985bd8mr16993612pzj.0.1678653754940;
        Sun, 12 Mar 2023 13:42:34 -0700 (PDT)
Received: from localhost ([2601:1c0:5080:d9fa:9b45:95de:f47d:f85e])
        by smtp.gmail.com with ESMTPSA id m26-20020a056a00165a00b006247123adf1sm592767pfc.143.2023.03.12.13.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 13:42:34 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Chia-I Wu <olvaffe@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        freedreno@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 04/13] drm/msm/gpu: Move BO allocation out of hw_init
Date:   Sun, 12 Mar 2023 13:41:32 -0700
Message-Id: <20230312204150.1353517-5-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230312204150.1353517-1-robdclark@gmail.com>
References: <20230312204150.1353517-1-robdclark@gmail.com>
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

These allocations are only done the first (successful) time through
hw_init() so they won't actually happen in the job_run() path.  But
lockdep doesn't know this.  So dis-entangle them from the hw_init()
path.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c      | 48 +++++++++++-----------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c      | 46 ++++++++++-----------
 drivers/gpu/drm/msm/adreno/adreno_device.c |  6 +++
 drivers/gpu/drm/msm/msm_gpu.h              |  6 +++
 4 files changed, 57 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index 660ba0db8900..f8e278d46dcf 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -567,7 +567,7 @@ static void a5xx_ucode_check_version(struct a5xx_gpu *a5xx_gpu,
 	msm_gem_put_vaddr(obj);
 }
 
-static int a5xx_ucode_init(struct msm_gpu *gpu)
+static int a5xx_ucode_load(struct msm_gpu *gpu)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a5xx_gpu *a5xx_gpu = to_a5xx_gpu(adreno_gpu);
@@ -605,9 +605,24 @@ static int a5xx_ucode_init(struct msm_gpu *gpu)
 		a5xx_ucode_check_version(a5xx_gpu, a5xx_gpu->pfp_bo);
 	}
 
-	gpu_write64(gpu, REG_A5XX_CP_ME_INSTR_BASE_LO, a5xx_gpu->pm4_iova);
+	if (a5xx_gpu->has_whereami) {
+		if (!a5xx_gpu->shadow_bo) {
+			a5xx_gpu->shadow = msm_gem_kernel_new(gpu->dev,
+				sizeof(u32) * gpu->nr_rings,
+				MSM_BO_WC | MSM_BO_MAP_PRIV,
+				gpu->aspace, &a5xx_gpu->shadow_bo,
+				&a5xx_gpu->shadow_iova);
 
-	gpu_write64(gpu, REG_A5XX_CP_PFP_INSTR_BASE_LO, a5xx_gpu->pfp_iova);
+			if (IS_ERR(a5xx_gpu->shadow))
+				return PTR_ERR(a5xx_gpu->shadow);
+
+			msm_gem_object_set_name(a5xx_gpu->shadow_bo, "shadow");
+		}
+	} else if (gpu->nr_rings > 1) {
+		/* Disable preemption if WHERE_AM_I isn't available */
+		a5xx_preempt_fini(gpu);
+		gpu->nr_rings = 1;
+	}
 
 	return 0;
 }
@@ -900,9 +915,8 @@ static int a5xx_hw_init(struct msm_gpu *gpu)
 	if (adreno_is_a530(adreno_gpu) || adreno_is_a540(adreno_gpu))
 		a5xx_gpmu_ucode_init(gpu);
 
-	ret = a5xx_ucode_init(gpu);
-	if (ret)
-		return ret;
+	gpu_write64(gpu, REG_A5XX_CP_ME_INSTR_BASE_LO, a5xx_gpu->pm4_iova);
+	gpu_write64(gpu, REG_A5XX_CP_PFP_INSTR_BASE_LO, a5xx_gpu->pfp_iova);
 
 	/* Set the ringbuffer address */
 	gpu_write64(gpu, REG_A5XX_CP_RB_BASE, gpu->rb[0]->iova);
@@ -916,27 +930,10 @@ static int a5xx_hw_init(struct msm_gpu *gpu)
 	gpu_write(gpu, REG_A5XX_CP_RB_CNTL,
 		MSM_GPU_RB_CNTL_DEFAULT | AXXX_CP_RB_CNTL_NO_UPDATE);
 
-	/* Create a privileged buffer for the RPTR shadow */
-	if (a5xx_gpu->has_whereami) {
-		if (!a5xx_gpu->shadow_bo) {
-			a5xx_gpu->shadow = msm_gem_kernel_new(gpu->dev,
-				sizeof(u32) * gpu->nr_rings,
-				MSM_BO_WC | MSM_BO_MAP_PRIV,
-				gpu->aspace, &a5xx_gpu->shadow_bo,
-				&a5xx_gpu->shadow_iova);
-
-			if (IS_ERR(a5xx_gpu->shadow))
-				return PTR_ERR(a5xx_gpu->shadow);
-
-			msm_gem_object_set_name(a5xx_gpu->shadow_bo, "shadow");
-		}
-
+	/* Configure the RPTR shadow if needed: */
+	if (a5xx_gpu->shadow_bo) {
 		gpu_write64(gpu, REG_A5XX_CP_RB_RPTR_ADDR,
 			    shadowptr(a5xx_gpu, gpu->rb[0]));
-	} else if (gpu->nr_rings > 1) {
-		/* Disable preemption if WHERE_AM_I isn't available */
-		a5xx_preempt_fini(gpu);
-		gpu->nr_rings = 1;
 	}
 
 	a5xx_preempt_hw_init(gpu);
@@ -1682,6 +1679,7 @@ static const struct adreno_gpu_funcs funcs = {
 		.get_param = adreno_get_param,
 		.set_param = adreno_set_param,
 		.hw_init = a5xx_hw_init,
+		.ucode_load = a5xx_ucode_load,
 		.pm_suspend = a5xx_pm_suspend,
 		.pm_resume = a5xx_pm_resume,
 		.recover = a5xx_recover,
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index aae60cbd9164..89049094a242 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -917,7 +917,7 @@ static bool a6xx_ucode_check_version(struct a6xx_gpu *a6xx_gpu,
 	return ret;
 }
 
-static int a6xx_ucode_init(struct msm_gpu *gpu)
+static int a6xx_ucode_load(struct msm_gpu *gpu)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
@@ -946,7 +946,23 @@ static int a6xx_ucode_init(struct msm_gpu *gpu)
 		}
 	}
 
-	gpu_write64(gpu, REG_A6XX_CP_SQE_INSTR_BASE, a6xx_gpu->sqe_iova);
+	/*
+	 * Expanded APRIV and targets that support WHERE_AM_I both need a
+	 * privileged buffer to store the RPTR shadow
+	 */
+	if ((adreno_gpu->base.hw_apriv || a6xx_gpu->has_whereami) &&
+	    !a6xx_gpu->shadow_bo) {
+		a6xx_gpu->shadow = msm_gem_kernel_new(gpu->dev,
+						      sizeof(u32) * gpu->nr_rings,
+						      MSM_BO_WC | MSM_BO_MAP_PRIV,
+						      gpu->aspace, &a6xx_gpu->shadow_bo,
+						      &a6xx_gpu->shadow_iova);
+
+		if (IS_ERR(a6xx_gpu->shadow))
+			return PTR_ERR(a6xx_gpu->shadow);
+
+		msm_gem_object_set_name(a6xx_gpu->shadow_bo, "shadow");
+	}
 
 	return 0;
 }
@@ -1135,9 +1151,7 @@ static int hw_init(struct msm_gpu *gpu)
 	if (ret)
 		goto out;
 
-	ret = a6xx_ucode_init(gpu);
-	if (ret)
-		goto out;
+	gpu_write64(gpu, REG_A6XX_CP_SQE_INSTR_BASE, a6xx_gpu->sqe_iova);
 
 	/* Set the ringbuffer address */
 	gpu_write64(gpu, REG_A6XX_CP_RB_BASE, gpu->rb[0]->iova);
@@ -1152,25 +1166,8 @@ static int hw_init(struct msm_gpu *gpu)
 		gpu_write(gpu, REG_A6XX_CP_RB_CNTL,
 			MSM_GPU_RB_CNTL_DEFAULT | AXXX_CP_RB_CNTL_NO_UPDATE);
 
-	/*
-	 * Expanded APRIV and targets that support WHERE_AM_I both need a
-	 * privileged buffer to store the RPTR shadow
-	 */
-
-	if (adreno_gpu->base.hw_apriv || a6xx_gpu->has_whereami) {
-		if (!a6xx_gpu->shadow_bo) {
-			a6xx_gpu->shadow = msm_gem_kernel_new(gpu->dev,
-				sizeof(u32) * gpu->nr_rings,
-				MSM_BO_WC | MSM_BO_MAP_PRIV,
-				gpu->aspace, &a6xx_gpu->shadow_bo,
-				&a6xx_gpu->shadow_iova);
-
-			if (IS_ERR(a6xx_gpu->shadow))
-				return PTR_ERR(a6xx_gpu->shadow);
-
-			msm_gem_object_set_name(a6xx_gpu->shadow_bo, "shadow");
-		}
-
+	/* Configure the RPTR shadow if needed: */
+	if (a6xx_gpu->shadow_bo) {
 		gpu_write64(gpu, REG_A6XX_CP_RB_RPTR_ADDR_LO,
 			shadowptr(a6xx_gpu, gpu->rb[0]));
 	}
@@ -1952,6 +1949,7 @@ static const struct adreno_gpu_funcs funcs = {
 		.get_param = adreno_get_param,
 		.set_param = adreno_set_param,
 		.hw_init = a6xx_hw_init,
+		.ucode_load = a6xx_ucode_load,
 		.pm_suspend = a6xx_pm_suspend,
 		.pm_resume = a6xx_pm_resume,
 		.recover = a6xx_recover,
diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 36f062c7582f..83d89b8d93e4 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -432,6 +432,12 @@ struct msm_gpu *adreno_load_gpu(struct drm_device *dev)
 	if (ret)
 		return NULL;
 
+	if (gpu->funcs->ucode_load) {
+		ret = gpu->funcs->ucode_load(gpu);
+		if (ret)
+			return NULL;
+	}
+
 	/*
 	 * Now that we have firmware loaded, and are ready to begin
 	 * booting the gpu, go ahead and enable runpm:
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index fc1c0d8611a8..5828b7333d81 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -50,6 +50,12 @@ struct msm_gpu_funcs {
 	int (*set_param)(struct msm_gpu *gpu, struct msm_file_private *ctx,
 			 uint32_t param, uint64_t value, uint32_t len);
 	int (*hw_init)(struct msm_gpu *gpu);
+
+	/**
+	 * @ucode_load: Optional hook to upload fw to GEM objs
+	 */
+	int (*ucode_load)(struct msm_gpu *gpu);
+
 	int (*pm_suspend)(struct msm_gpu *gpu);
 	int (*pm_resume)(struct msm_gpu *gpu);
 	void (*submit)(struct msm_gpu *gpu, struct msm_gem_submit *submit);
-- 
2.39.2


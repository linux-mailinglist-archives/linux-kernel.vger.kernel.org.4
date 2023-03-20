Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E256C155A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjCTOqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbjCTOpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:45:25 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8DDC160;
        Mon, 20 Mar 2023 07:45:00 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id om3-20020a17090b3a8300b0023efab0e3bfso16599694pjb.3;
        Mon, 20 Mar 2023 07:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679323499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZVlbUahPT9dLpoRTmNSYJvHTK7teqvjnC8Je3CP6Kxc=;
        b=NGWAfuutYzG2ND7yw5eCEsdM74IarWmxSaNS/cW9vVQlHnyZladHRE3ga26R0gj21T
         R4KpZPJqtoHD5+agUZmY0uO0nVdb9qpmIeRbmvwC+bKxjqUKinwXE16/Tcvs8DM9fQdr
         Av9B51dpHq/I96SJqFg+P0oUv7Cu1JJs8VyvBJ+/nVeiTjbmanwYjElJ0CsgZ7GiZDHF
         t2RQ231vKONzgMQzTcfdLpaRKaTjk5gbqRklsH7ny/KxYnYU62IyGqnahsqIz3fwFvsb
         nnWx98n11XLoFhaaJo4hqsKhsh2zNGfwa7G2//JgQqUkPYzqGLCqHhAy8fJRbkxs0GsS
         Zj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679323499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZVlbUahPT9dLpoRTmNSYJvHTK7teqvjnC8Je3CP6Kxc=;
        b=QQBk02X45YDYgtRzVOwF0bja2rXkUbs6qpC78GvhYTVflZykF4oe7raXXxOJQAkd6o
         px+KhQPaSS/6sLKxBC+9kfTuJ0917Kosau4gHm39k12LFlSy7BFYzu7YmqG5ilm6gnct
         Qn+DDsQcdPi5BNgIQGOQoFUDVdE211huLb4HDs5+P2a9g/w+Un/LmoIuaOgCVuvfTdcM
         gBAWHafHQOjeU3+8DJV4Dno+2V7MK+iTCxUfNsv11/EcqJMY6ujhW5sPCkVsoc9EwzGC
         3Xxdt9TngeGh6JWDWBeX3XRCstNCcjm97nxcJwXW7bPQ6iasYF5miLHNHnVsNztpsDnU
         QAXQ==
X-Gm-Message-State: AO0yUKUG3NLXw/qy5XTr8iLNaRPxv5KAnSvnKAjjrK23LYYgu5a7AGTr
        MaFqxunAhVXZv3ouW3BoN6E=
X-Google-Smtp-Source: AK7set+nq/17+WMSgvQ9N76UARnEk4i1nIlQZyx1JbgYmEs1u1mjNQQXgECoC/jbIp+HuK50N9Mzaw==
X-Received: by 2002:a17:90b:1c8d:b0:233:f98a:8513 with SMTP id oo13-20020a17090b1c8d00b00233f98a8513mr19657496pjb.8.1679323499152;
        Mon, 20 Mar 2023 07:44:59 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id mv10-20020a17090b198a00b0023efa52d2b6sm6246591pjb.34.2023.03.20.07.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 07:44:58 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 13/23] drm/msm/gpu: Move BO allocation out of hw_init
Date:   Mon, 20 Mar 2023 07:43:35 -0700
Message-Id: <20230320144356.803762-14-robdclark@gmail.com>
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
index 5929ecaa1fcd..f84de0e8afac 100644
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


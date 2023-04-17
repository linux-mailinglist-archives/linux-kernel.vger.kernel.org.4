Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477286E5178
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 22:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjDQUMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 16:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjDQUM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 16:12:26 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DD14C3B;
        Mon, 17 Apr 2023 13:12:24 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id hg14-20020a17090b300e00b002471efa7a8fso14182168pjb.0;
        Mon, 17 Apr 2023 13:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681762343; x=1684354343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tG6YslYBKkuazr2dWr4ftni9ZweXIehBqMaA0S88C5g=;
        b=ranf+f0tP4Pb5Lh3n2WP/yUu2QmlnNs1+iNecDfUR5KzPGDF2bZRgZqk1mWXpHnHt5
         LvjFfEz45tozCyPEEtQjKkO8d/GjRWICY4Hv4JwW6qTQHxWO9CZfLaHGX8p2r4CW9gPn
         jMzksiwIj2fJfm/8vwU20S8sWgres5UTA5RA7TWq47jF1gyXHpo9quj4zTNbN3BzCa/u
         opUoVSqp96ZbME/+aQRIHHBrCgoRQ4uAp9Giig/8md+Q4eWVzwdTzUdpfQWjKL0hFWnn
         Vc3VUfTXzlPtTiL1SdnAxgrtE/Cl2UhuPJaDPjJVqT9V/wnujeoXWsWJHFu7pNrDbT3C
         VwNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681762343; x=1684354343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tG6YslYBKkuazr2dWr4ftni9ZweXIehBqMaA0S88C5g=;
        b=Z+yJmrZ3ohZiOcr0CS+qokah6ZIqqtoEKieTVdm0C9mwZGRqgFVp2pt3YE3NKyf8+A
         aWfbh5fAfeUlHaUfe4kgVNjvB1RhLn1o8mvOhfWbE1TxjqMxlLDuk0JIlCJnuHM1AXzE
         re2o/IZxCmByxWlFJWOisuuKDF3vi96wvl+B/+l9wZ/dDrrbE+/Dn161xNUFPrb/y/cG
         wIAGi6xFIVnjLycJszRWCPNmksv/6SGV0JV8ja9YiOi88+AMu1JjCa7WEuSxCYSD/6Go
         ZbuzzbJvrCrse8VsKqy2c4KBh0Gl9Qh0DGo5/pE0w6asc422EMZ+LpZjvuGGOq1eS2VQ
         zoHA==
X-Gm-Message-State: AAQBX9c3RCuUUsSZbA43h4nPFN8PewjoZHdXE/ZGwf5uIihVKUGWbMFR
        oss4zACsgjkAhbP7acZ9+UM=
X-Google-Smtp-Source: AKy350Z897P0ebUOEGMZ5BJSTsfQqtu+SrNiRCFFaWIYGgI+O1qDjfMdnTtEGHt9vqVAg5JBSzDliQ==
X-Received: by 2002:a17:902:82c5:b0:1a1:b11d:6af5 with SMTP id u5-20020a17090282c500b001a1b11d6af5mr76812plz.52.1681762343629;
        Mon, 17 Apr 2023 13:12:23 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id u19-20020a170902a61300b001a20b31a23fsm8094636plq.293.2023.04.17.13.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:12:23 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        freedreno@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [RFC 2/3] drm/msm: Rework get_comm_cmdline() helper
Date:   Mon, 17 Apr 2023 13:12:11 -0700
Message-Id: <20230417201215.448099-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417201215.448099-1-robdclark@gmail.com>
References: <20230417201215.448099-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Make it work in terms of ctx so that it can be re-used for fdinfo.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c |  4 ++--
 drivers/gpu/drm/msm/msm_drv.c           |  2 ++
 drivers/gpu/drm/msm/msm_gpu.c           | 13 ++++++-------
 drivers/gpu/drm/msm/msm_gpu.h           | 12 ++++++++++--
 drivers/gpu/drm/msm/msm_submitqueue.c   |  1 +
 5 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index bb38e728864d..43c4e1fea83f 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -412,7 +412,7 @@ int adreno_set_param(struct msm_gpu *gpu, struct msm_file_private *ctx,
 		/* Ensure string is null terminated: */
 		str[len] = '\0';
 
-		mutex_lock(&gpu->lock);
+		mutex_lock(&ctx->lock);
 
 		if (param == MSM_PARAM_COMM) {
 			paramp = &ctx->comm;
@@ -423,7 +423,7 @@ int adreno_set_param(struct msm_gpu *gpu, struct msm_file_private *ctx,
 		kfree(*paramp);
 		*paramp = str;
 
-		mutex_unlock(&gpu->lock);
+		mutex_unlock(&ctx->lock);
 
 		return 0;
 	}
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 3d73b98d6a9c..ca0e89e46e13 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -581,6 +581,8 @@ static int context_init(struct drm_device *dev, struct drm_file *file)
 	rwlock_init(&ctx->queuelock);
 
 	kref_init(&ctx->ref);
+	ctx->pid = get_pid(task_pid(current));
+	mutex_init(&ctx->lock);
 	msm_submitqueue_init(dev, ctx);
 
 	ctx->aspace = msm_gpu_create_private_address_space(priv->gpu, current);
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index c403912d13ab..f0f4f845c32d 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -327,18 +327,17 @@ find_submit(struct msm_ringbuffer *ring, uint32_t fence)
 
 static void retire_submits(struct msm_gpu *gpu);
 
-static void get_comm_cmdline(struct msm_gem_submit *submit, char **comm, char **cmd)
+static void get_comm_cmdline(struct msm_file_private *ctx, char **comm, char **cmd)
 {
-	struct msm_file_private *ctx = submit->queue->ctx;
 	struct task_struct *task;
 
-	WARN_ON(!mutex_is_locked(&submit->gpu->lock));
-
 	/* Note that kstrdup will return NULL if argument is NULL: */
+	mutex_lock(&ctx->lock);
 	*comm = kstrdup(ctx->comm, GFP_KERNEL);
 	*cmd  = kstrdup(ctx->cmdline, GFP_KERNEL);
+	mutex_unlock(&ctx->lock);
 
-	task = get_pid_task(submit->pid, PIDTYPE_PID);
+	task = get_pid_task(ctx->pid, PIDTYPE_PID);
 	if (!task)
 		return;
 
@@ -372,7 +371,7 @@ static void recover_worker(struct kthread_work *work)
 		if (submit->aspace)
 			submit->aspace->faults++;
 
-		get_comm_cmdline(submit, &comm, &cmd);
+		get_comm_cmdline(submit->queue->ctx, &comm, &cmd);
 
 		if (comm && cmd) {
 			DRM_DEV_ERROR(dev->dev, "%s: offending task: %s (%s)\n",
@@ -460,7 +459,7 @@ static void fault_worker(struct kthread_work *work)
 		goto resume_smmu;
 
 	if (submit) {
-		get_comm_cmdline(submit, &comm, &cmd);
+		get_comm_cmdline(submit->queue->ctx, &comm, &cmd);
 
 		/*
 		 * When we get GPU iova faults, we can get 1000s of them,
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 7a4fa1b8655b..b2023a42116b 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -377,17 +377,25 @@ struct msm_file_private {
 	 */
 	int sysprof;
 
+	/** @pid: Process that opened this file. */
+	struct pid *pid;
+
+	/**
+	 * lock: Protects comm and cmdline
+	 */
+	struct mutex lock;
+
 	/**
 	 * comm: Overridden task comm, see MSM_PARAM_COMM
 	 *
-	 * Accessed under msm_gpu::lock
+	 * Accessed under msm_file_private::lock
 	 */
 	char *comm;
 
 	/**
 	 * cmdline: Overridden task cmdline, see MSM_PARAM_CMDLINE
 	 *
-	 * Accessed under msm_gpu::lock
+	 * Accessed under msm_file_private::lock
 	 */
 	char *cmdline;
 
diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/msm/msm_submitqueue.c
index 0e803125a325..0444ba04fa06 100644
--- a/drivers/gpu/drm/msm/msm_submitqueue.c
+++ b/drivers/gpu/drm/msm/msm_submitqueue.c
@@ -61,6 +61,7 @@ void __msm_file_private_destroy(struct kref *kref)
 	}
 
 	msm_gem_address_space_put(ctx->aspace);
+	put_pid(ctx->pid);
 	kfree(ctx->comm);
 	kfree(ctx->cmdline);
 	kfree(ctx);
-- 
2.39.2


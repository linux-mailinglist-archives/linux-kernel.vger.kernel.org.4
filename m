Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8AB6FCCA6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 19:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjEIRXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 13:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjEIRXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 13:23:21 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010424EC5;
        Tue,  9 May 2023 10:22:57 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6439b410679so3867917b3a.0;
        Tue, 09 May 2023 10:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683652977; x=1686244977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h8H4gLY9QD6JR3rBgoCS4vvXjxVaagMATkBih9kNdRg=;
        b=EMBC+q+FGd7Q3uU5/5oV3B6UZEISuagmTJ9Cx076RXqV8Ik2Zb9HknVj5oCHgmH3Ug
         RFVHxwYh58xvNHtou7+BfSvFF5zxGKfwDARu9iF/4Cd5yr2prKfvY9M0/QdmyCqtYotM
         3+6sXXNvM90RXZ+b2227fnKcHESoJ6NGaKMkEPROokGe8Gx3YIrBCsKUWgBAptXVqE9G
         fC6DUtFjBKNBe7Y1UhZj1+NrmwGoSE0D25r0zsLKAzktvG/P3xNq9gPJiiaQYP/cNKgK
         sv+wVvIzvrBU/0O1jFgrffWR38BDiAR+J1MTKRd5QtP73pVqtfJNT8L+Z42izNjuwM0y
         rpdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683652977; x=1686244977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h8H4gLY9QD6JR3rBgoCS4vvXjxVaagMATkBih9kNdRg=;
        b=TDCUFbpCW1QN87GPX8dTRRUeHn/oVzc1WVXXXhBQ2efgirhwXGnUH8FE1VZtDa9Xq+
         CbywlCIGHq4OW0e9M/SulUDJn2Ru9f4QM3PXF0bAnHiR6S8AkPbrRoYJMh+rW+dVmGSY
         eSZvu/bB99IlbrmRYc2csGzLq74EKfwp1a5+Y0gpgWbNWR/cB5+zGBZfDAEh6T8U5+TG
         bXx3vIrraRhPPtMfceAcm2Wwd7n7j1Sg3I8oskTCUXByv2UR6G+LPUeVDKgJm+a1XdUm
         GNQbGMYufziZ0s2Psd1Wbjy+vKWjC4hJBM54uyE82XHkk6i3nN6r9bjh4uL/YIFJzsQW
         b4yA==
X-Gm-Message-State: AC+VfDySgEyrFMgSz+f9GnTs0KSdvrUWY3ZNllYPscEL5TgWH09bwANV
        6gjwFCKmcY9XKxX2sAYh72I=
X-Google-Smtp-Source: ACHHUZ7n2ye/CuTjs4se99yvH8Xq0S3axmyWPzeGYkUleujVONQhA3IefUZmticF0BdwwXUn6OV+xw==
X-Received: by 2002:a05:6a21:920d:b0:eb:69b3:116c with SMTP id tl13-20020a056a21920d00b000eb69b3116cmr17192888pzb.52.1683652977404;
        Tue, 09 May 2023 10:22:57 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id e5-20020aa78c45000000b00639fc7124c2sm2072001pfd.148.2023.05.09.10.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 10:22:57 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>, pinkperfect2021@gmail.com,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3] drm/msm: Fix submit error-path leaks
Date:   Tue,  9 May 2023 10:22:53 -0700
Message-Id: <20230509172253.383964-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.40.1
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

For errors after msm_submitqueue_get(), we need to drop the submitqueue
reference.  Additionally after get_unused_fd() we need to drop the fd.
The ordering for dropping the queue lock and put_unused_fd() is not
important, so just move this all into out_post_unlock.

v2: Only drop queue ref if submit doesn't take it
v3: Fix unitialized submit ref in error path

Reported-by: pinkperfect2021@gmail.com
Fixes: f0de40a131d9 drm/msm: ("Reorder lock vs submit alloc")
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gem_submit.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index 6c6aefaa72be..c994d4a13580 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -720,21 +720,21 @@ static void msm_process_post_deps(struct msm_submit_post_dep *post_deps,
 		}
 	}
 }
 
 int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 		struct drm_file *file)
 {
 	struct msm_drm_private *priv = dev->dev_private;
 	struct drm_msm_gem_submit *args = data;
 	struct msm_file_private *ctx = file->driver_priv;
-	struct msm_gem_submit *submit;
+	struct msm_gem_submit *submit = NULL;
 	struct msm_gpu *gpu = priv->gpu;
 	struct msm_gpu_submitqueue *queue;
 	struct msm_ringbuffer *ring;
 	struct msm_submit_post_dep *post_deps = NULL;
 	struct drm_syncobj **syncobjs_to_reset = NULL;
 	int out_fence_fd = -1;
 	bool has_ww_ticket = false;
 	unsigned i;
 	int ret;
 
@@ -767,27 +767,29 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 	queue = msm_submitqueue_get(ctx, args->queueid);
 	if (!queue)
 		return -ENOENT;
 
 	ring = gpu->rb[queue->ring_nr];
 
 	if (args->flags & MSM_SUBMIT_FENCE_FD_OUT) {
 		out_fence_fd = get_unused_fd_flags(O_CLOEXEC);
 		if (out_fence_fd < 0) {
 			ret = out_fence_fd;
-			return ret;
+			goto out_post_unlock;
 		}
 	}
 
 	submit = submit_create(dev, gpu, queue, args->nr_bos, args->nr_cmds);
-	if (IS_ERR(submit))
-		return PTR_ERR(submit);
+	if (IS_ERR(submit)) {
+		ret = PTR_ERR(submit);
+		goto out_post_unlock;
+	}
 
 	trace_msm_gpu_submit(pid_nr(submit->pid), ring->id, submit->ident,
 		args->nr_bos, args->nr_cmds);
 
 	ret = mutex_lock_interruptible(&queue->lock);
 	if (ret)
 		goto out_post_unlock;
 
 	if (args->flags & MSM_SUBMIT_SUDO)
 		submit->in_rb = true;
@@ -962,25 +964,33 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 	msm_reset_syncobjs(syncobjs_to_reset, args->nr_in_syncobjs);
 	msm_process_post_deps(post_deps, args->nr_out_syncobjs,
 	                      submit->user_fence);
 
 
 out:
 	submit_cleanup(submit, !!ret);
 	if (has_ww_ticket)
 		ww_acquire_fini(&submit->ticket);
 out_unlock:
-	if (ret && (out_fence_fd >= 0))
-		put_unused_fd(out_fence_fd);
 	mutex_unlock(&queue->lock);
 out_post_unlock:
-	msm_gem_submit_put(submit);
+	if (ret && (out_fence_fd >= 0))
+		put_unused_fd(out_fence_fd);
+	if (submit) {
+		msm_gem_submit_put(submit);
+	} else {
+		/*
+		 * If the submit hasn't yet taken ownership of the queue
+		 * then we need to drop the reference ourself:
+		 */
+		msm_submitqueue_put(queue);
+	}
 	if (!IS_ERR_OR_NULL(post_deps)) {
 		for (i = 0; i < args->nr_out_syncobjs; ++i) {
 			kfree(post_deps[i].chain);
 			drm_syncobj_put(post_deps[i].syncobj);
 		}
 		kfree(post_deps);
 	}
 
 	if (!IS_ERR_OR_NULL(syncobjs_to_reset)) {
 		for (i = 0; i < args->nr_in_syncobjs; ++i) {
-- 
2.40.1


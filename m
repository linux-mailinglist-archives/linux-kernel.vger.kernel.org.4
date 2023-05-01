Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71CC6F3399
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 18:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbjEAQhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 12:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjEAQhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 12:37:48 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D24710EA;
        Mon,  1 May 2023 09:37:47 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1aaf706768cso9382145ad.0;
        Mon, 01 May 2023 09:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682959067; x=1685551067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wrKAgdmLOJyxcGM4fHJIExIcPdILMv9Wxsqdb+XbK0o=;
        b=lajon+PLfTqBK9Rp20x2MnUwb7SWY0dOp+b/oNKOeIzHg6ROUzBVY0YZZnsmn15dPF
         LOLkyaOHxrOCa6QgmaDu5t1d0knJDmZIoB40teLmie4OpAoiYvnarsAt3g/FOD4SsSN1
         fxBQIN1M+sD+wv+R1xW5EqudhJDD+Cn3aiqUcuJJAUSp/lMH9kLFl+foD7GkkeGd26JC
         E9nMaDv1hSgMJbYu7TMFA1Ejiu+YMCb488SrV0Bc/Kfh8iuwJXByW6ZP/cFL4cdVGm1W
         osE3S9EGLrmU7g3l51OMkFpNJhnIMxSvydUixvAHpIG0TjrtoXT/73sQgwMoMA3D+mKF
         X6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682959067; x=1685551067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wrKAgdmLOJyxcGM4fHJIExIcPdILMv9Wxsqdb+XbK0o=;
        b=Ff4bdy8X4OSSEevsaGmOmC+CO/J18smf8Grltq+fZY1W4Nm6/8uzlqCMzx4hihuggP
         Du8O1O7D8XwHalOFoTETAL3pSfL5nyBv8pNeV4y+u0FcAlRAbmpFcniAJudQNlwBOXp3
         65WvhQaUcnz7lmsbAGfFpDHiHutuW8z64KbGUpC2vonIlE7H8FanX0hA+gK4GT/FVLhc
         QW9VfS3MjP4eKrq8igRWDqu5Xf7HGbsTYsZxyebUNnIXRtFB18+UtwxZzOrJXjOcvPvj
         Z4xac/SjclmftBBJjt8iAX4wqIy49EjqtR+DxJ1ed3+KoaFHAqxniYm457bZz6u8EYtw
         p1hw==
X-Gm-Message-State: AC+VfDxnqt/Y+z2T/Ugh5PZO3kwut119fvN9vUplobeMW3kV/OuqscFg
        CQt764y850EWwm1ED9ZEys8=
X-Google-Smtp-Source: ACHHUZ5QP9sT1qh1d4aBp7RgMIgDyOGAk7FUHJNl89muDSUAiUfpQJy+p/f3pRgH/baCQCVFZ1NPDg==
X-Received: by 2002:a17:902:7b94:b0:1a6:7ed8:84f7 with SMTP id w20-20020a1709027b9400b001a67ed884f7mr15518527pll.20.1682959066600;
        Mon, 01 May 2023 09:37:46 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id s2-20020a170902988200b0019a7d58e595sm17988796plp.143.2023.05.01.09.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 09:37:46 -0700 (PDT)
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
Subject: [PATCH] drm/msm: Fix submit error-path leaks
Date:   Mon,  1 May 2023 09:37:35 -0700
Message-Id: <20230501163736.1599381-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.2
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

Reported-by: pinkperfect2021@gmail.com
Fixes: f0de40a131d9 drm/msm: ("Reorder lock vs submit alloc")
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gem_submit.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index 6c6aefaa72be..728983959ed5 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
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
@@ -962,25 +964,27 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
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
+	if (submit)
+		msm_gem_submit_put(submit);
+	msm_submitqueue_put(queue);
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
2.39.2


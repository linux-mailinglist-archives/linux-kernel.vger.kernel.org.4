Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5685E85F4
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 00:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbiIWWlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 18:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiIWWlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 18:41:12 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636CF13C844;
        Fri, 23 Sep 2022 15:41:11 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id v186so1389417pfv.11;
        Fri, 23 Sep 2022 15:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=oOI1w1RpGPXrz/NU70+BlU1qHXDFQzQmtw6vEH42xjs=;
        b=ndQOEMU3yBWN/RaJFUoxcBG8JODdya6truLZHSKj35iTY3iuiFdXa54rNGAcTTNLa1
         44qzi5WwzLqs/tWUW8d1Civy+XnhhcdSz0+M6JoL8QQegwhcT0AKils5mdwdkWb+HgrI
         syeSknpoFpJHmpFR8sGzFgLqvQ62EQQtHVOzLFGIh77aY1WPDrflvQ4BIN3dESJbPXyZ
         YGr4CteT+J+rJPXf0OOS/qWePukr4xrxfZ3WOPxpwDTjDrs7Xt4A4ADI/VKStbZuzagV
         g3hAI/N9vs1GLaCHaJXHzYDEUrtaS+0wuVaMLqap8AIXxVVrmzG0qMWLtOd0Sc4Y5Jld
         u40g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=oOI1w1RpGPXrz/NU70+BlU1qHXDFQzQmtw6vEH42xjs=;
        b=gQeKP3AShgMM3/ZyoPSck+CokGeVv/Jd58b8aACby96T96Aw7Yrc31a5xwdOlXmKMw
         FL/n19z9pVtOwl1NnSGuNru+D6Nf1KP4PSlhWAoPc4xfHwnm9DM35ALbppuE7sAbpDc2
         9SAlVtxXdhYfz+eF0PIg1LkK7/EDjQk+7tF3yzXzhISSqofhIsdKoidUlakjPa6D+tcP
         Owar3W20Qei8bDl1TOzy9xPEFMbqDk9jsKnIY/Msvp9eJZYZB45Fh4SQ0yhX0+Ele3or
         cfnrrC3GwryWhnNfCDOLhC42pA31NJ6Q+rAdod02EdVFq6Ziim/mAjRIphHFA7/R9JJ/
         F1Lw==
X-Gm-Message-State: ACrzQf1VUxfUrKTqnkbx2/NfeR2vNAxi4d4MCl6zlv0bce9Re04KEJe+
        qTOK9599qRaqMJ5Ulpdk1vE=
X-Google-Smtp-Source: AMsMyM7iSk/g+tzazFBHrdHLO7817yrGTQYIUzyZk+Y1xplU0QyZaPrFUlaCUkO/MvnMIQubBg6jxA==
X-Received: by 2002:a63:5144:0:b0:43b:ed4b:224 with SMTP id r4-20020a635144000000b0043bed4b0224mr9610350pgl.594.1663972870693;
        Fri, 23 Sep 2022 15:41:10 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id e6-20020a170902d38600b00173411a4385sm6506514pld.43.2022.09.23.15.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 15:41:09 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm/gem: Unpin objects slightly later
Date:   Fri, 23 Sep 2022 15:40:44 -0700
Message-Id: <20220923224043.2449152-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.37.2
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

The introduction of 025d27239a2f exposes a problem with f371bcc0c2ac, in
that we need to keep the object pinned in the time the submit is queued
up in the gpu scheduler.  Otherwise the shrinker will see it as a thing
that can be evicted if we wait for it to be signaled.  But if the
shrinker path is waiting on it with the obj lock held, the job cannot be
scheduled, as that also requires briefly grabbing the obj lock, leading
to deadlock.  (Not to mention, we don't want the shrinker to evict an
obj queued up in gpu scheduler.)

Fixes: f371bcc0c2ac ("drm/msm/gem: Unpin buffers earlier")
Fixes: 025d27239a2f ("drm/msm/gem: Evict active GEM objects when necessary")
Closes: https://gitlab.freedesktop.org/drm/msm/-/issues/19
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gem_submit.c | 4 ++--
 drivers/gpu/drm/msm/msm_ringbuffer.c | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index 5599d93ec0d2..c670591995e6 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -501,11 +501,11 @@ static int submit_reloc(struct msm_gem_submit *submit, struct msm_gem_object *ob
  */
 static void submit_cleanup(struct msm_gem_submit *submit, bool error)
 {
-	unsigned cleanup_flags = BO_LOCKED | BO_OBJ_PINNED;
+	unsigned cleanup_flags = BO_LOCKED;
 	unsigned i;
 
 	if (error)
-		cleanup_flags |= BO_VMA_PINNED;
+		cleanup_flags |= BO_VMA_PINNED | BO_OBJ_PINNED;
 
 	for (i = 0; i < submit->nr_bos; i++) {
 		struct msm_gem_object *msm_obj = submit->bos[i].obj;
diff --git a/drivers/gpu/drm/msm/msm_ringbuffer.c b/drivers/gpu/drm/msm/msm_ringbuffer.c
index cad4c3525f0b..57a8e9564540 100644
--- a/drivers/gpu/drm/msm/msm_ringbuffer.c
+++ b/drivers/gpu/drm/msm/msm_ringbuffer.c
@@ -25,7 +25,8 @@ static struct dma_fence *msm_job_run(struct drm_sched_job *job)
 
 		msm_gem_lock(obj);
 		msm_gem_unpin_vma_fenced(submit->bos[i].vma, fctx);
-		submit->bos[i].flags &= ~BO_VMA_PINNED;
+		msm_gem_unpin_locked(obj);
+		submit->bos[i].flags &= ~(BO_VMA_PINNED | BO_OBJ_PINNED);
 		msm_gem_unlock(obj);
 	}
 
-- 
2.37.2


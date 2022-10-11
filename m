Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7556B5FADDA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 09:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiJKHzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 03:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiJKHz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 03:55:29 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C63BC81
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 00:55:28 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id f9-20020a25b089000000b006be298e2a8dso12926426ybj.20
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 00:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r9hdE1ma60AvuVxA5HLJSW2/ZKfSQyXvLxIYq7eW4LQ=;
        b=GK1Ld7Snxtw6fTjzpXViebq+kfUfdvfDmnwHCV5VQCaew+nzUmYh31FH71I8LuTTuP
         Ar2ugsAB59c4cj7rlU/8GrExj0cdhTRc31UiXK4i3ARDbvJ2XxaNCJGOTlgjmRo0I5e4
         plBAm5AeIQL/jC5xlZwm/uzXx87VsSj0UdEi73uOcA4UHFI+fcWuz8Dc2/i+UjLruvj2
         c2RWRKjiZEKfCqoUjV34QpqZXerwEJiqbPAGubElw8f7KjQfdR0zx8O2p/dWNsQiVeYY
         vm8M7uapP7F9yZq9w9TcPebfB8LjQ4aXFX2nvuE3XbTDdhA3GttZaGwrfHQR2Wvu3WaU
         dg/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r9hdE1ma60AvuVxA5HLJSW2/ZKfSQyXvLxIYq7eW4LQ=;
        b=0QEBuJBm8QoWRjtrMv3T3kx2EfSN4ztCcLe9/Rf//qqUQHlz3xESo31nidaUY0HxFK
         xy5ax0IixKSYSyAKO/sETdbeP32lw2XQNNEQcpPN/JeBkzKtqodIL5L/ja0iM6QCQt+7
         TjPMo9lVznTm2siP16fQB2IR7HY1+FYXg+ljNCZr35vN73OnhCCucV9hR4foBFRoatRH
         KZn30k06wTW5LLudy/OKNd7HDMrhbQ96LhAlnIclSyMh2QLpew3Hiara4xOD83x2GquG
         /wjz0O0JhVzqJ/EiZsGskXliG8noSJMI/qrJhAusG4O1NDtTEMlFYngqou/wrXwFphFw
         6KYw==
X-Gm-Message-State: ACrzQf1SmHVxqbBo+U9sdWiIGJjF/fG0PSkOoKd6lsl9dHraqgoiOrPD
        1xbf6yF2mbQGj/eBPk3qlhQcAoUc9eTC
X-Google-Smtp-Source: AMsMyM4AquAT123mEtwqvuKxEJ9kf71pBi3ilDdgVY1MCVJH189FexuumcZnRxDHTRKsb2XAtqTTjkL0eCt4
X-Received: from ezekiel.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:108e])
 (user=shraash job=sendgmr) by 2002:a0d:e581:0:b0:356:cd48:a936 with SMTP id
 o123-20020a0de581000000b00356cd48a936mr20553028ywe.397.1665474927474; Tue, 11
 Oct 2022 00:55:27 -0700 (PDT)
Date:   Tue, 11 Oct 2022 13:25:19 +0530
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.rc2.412.g84df46c1b4-goog
Message-ID: <20221011075519.3111928-1-shraash@google.com>
Subject: [PATCH] drm/msm: Remove redundant check for 'submit'
From:   Aashish Sharma <shraash@google.com>
To:     Guenter Roeck <groeck@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Aashish Sharma <shraash@google.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rectify the below smatch warning:
drivers/gpu/drm/msm/msm_gem_submit.c:963 msm_ioctl_gem_submit() warn:
variable dereferenced before check 'submit'

'submit' is normally error pointer or valid, so remove its NULL
initializer as it's confusing and also remove a redundant check for it's
value.

Signed-off-by: Aashish Sharma <shraash@google.com>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/gpu/drm/msm/msm_gem_submit.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index 5599d93ec0d2..74fe1c56cd65 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -706,7 +706,7 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 	struct msm_drm_private *priv = dev->dev_private;
 	struct drm_msm_gem_submit *args = data;
 	struct msm_file_private *ctx = file->driver_priv;
-	struct msm_gem_submit *submit = NULL;
+	struct msm_gem_submit *submit;
 	struct msm_gpu *gpu = priv->gpu;
 	struct msm_gpu_submitqueue *queue;
 	struct msm_ringbuffer *ring;
@@ -946,8 +946,7 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 		put_unused_fd(out_fence_fd);
 	mutex_unlock(&queue->lock);
 out_post_unlock:
-	if (submit)
-		msm_gem_submit_put(submit);
+	msm_gem_submit_put(submit);
 	if (!IS_ERR_OR_NULL(post_deps)) {
 		for (i = 0; i < args->nr_out_syncobjs; ++i) {
 			kfree(post_deps[i].chain);
-- 
2.38.0.rc2.412.g84df46c1b4-goog


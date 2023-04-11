Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678D16DE7A2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 00:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjDKW5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 18:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjDKW5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 18:57:46 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E91146BE;
        Tue, 11 Apr 2023 15:57:45 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id ik20so9280896plb.3;
        Tue, 11 Apr 2023 15:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681253864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wlvnl6FahWn1EEVl5XEqTBS0ldcLDlAbSv9n0bbBLA=;
        b=sSxYCJhTMTGU4c9Pr4qhDhsZfPVfOfKUG4uV1ydWafAmd0E+M5cWAblMYfH4KzE23t
         jKT3tVVNVyzQM6LeWIZGZhukwqNX21TvB7MC+Q1+WJvKoqSHuY2u8Ektt+FuXQgSNSw4
         Qv9v4YAA8Fhpf8drpjvsGwME/RWJx0dQ1oGlztFbkZ39DsDLjz9Ewo4Z9KdGHI6m5wsT
         iuiscFq4uDiVT26V7kpj4jUmbmVrBvevzvprvNog39h8+7bSmYSPApFrLrnW7yvu/54x
         7nEIVcFRP0U45V22III7fp7v7nlXx2a9nEQXgc1Qyyu5I36EDUCCZzMtAOV9eQGfj8fN
         Px1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681253864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0wlvnl6FahWn1EEVl5XEqTBS0ldcLDlAbSv9n0bbBLA=;
        b=0PT3DVBIWh0F1EM8aeOX/OnGFTeb0svs9OIvj0EFaxYlUZvHEy8aG9GTF3XpOQ7Ctu
         0k7mMn6ZyKCrkN5GkUHK+eGZyZKsajttFLVBMpH1GcW1oXwk6Sx03I5pSJeXF4GfJ/yn
         D6EsFPckeMKK1wN21efWm/AxOZztgiaQmFYLbjviKZZmBrCQ1WyblGc12H8ywefZTkiM
         Hy5gxwvQ/jFvMUwOB0hla4DGZ/h5irU7Do3WVQjQo8+B1qGye4X1XDvMP8ihv/zl2tfz
         hKi1RjDpcg6DGXVWlzEyAJSx5bVbGDxhZjAKoOqkWF3NmFICQBy8zEZQmxqF2L4SSfex
         lm9w==
X-Gm-Message-State: AAQBX9chxa89rsjsRrJMvq0WzM1bmleihkj0rQStFemjX3xCs7rdZsZ2
        hmzg4tjFTeLHL0WIt18wLb4=
X-Google-Smtp-Source: AKy350aqH2UsVc7wl7kw/6JAvQjJ+lsRZo3f39HCLfgoMvhVUL96lEwXMeh+l46oB5pYB21Mvicm7w==
X-Received: by 2002:a17:902:d4d1:b0:19b:dbf7:f9ca with SMTP id o17-20020a170902d4d100b0019bdbf7f9camr23621397plg.0.1681253864547;
        Tue, 11 Apr 2023 15:57:44 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id p1-20020a1709028a8100b001a06eb43880sm10213699plo.153.2023.04.11.15.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 15:57:44 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Christopher Healy <healych@amazon.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 2/7] drm/msm: Switch to fdinfo helper
Date:   Tue, 11 Apr 2023 15:56:07 -0700
Message-Id: <20230411225725.2032862-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411225725.2032862-1-robdclark@gmail.com>
References: <20230411225725.2032862-1-robdclark@gmail.com>
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

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_drv.c | 11 +++++------
 drivers/gpu/drm/msm/msm_gpu.c |  2 --
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 5a10d28de9dd..e516a3544505 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -1043,23 +1043,21 @@ static const struct drm_ioctl_desc msm_ioctls[] = {
 	DRM_IOCTL_DEF_DRV(MSM_SUBMITQUEUE_QUERY, msm_ioctl_submitqueue_query, DRM_RENDER_ALLOW),
 };
 
-static void msm_fop_show_fdinfo(struct seq_file *m, struct file *f)
+static void msm_show_fdinfo(struct drm_printer *p, struct drm_file *file)
 {
-	struct drm_file *file = f->private_data;
 	struct drm_device *dev = file->minor->dev;
 	struct msm_drm_private *priv = dev->dev_private;
-	struct drm_printer p = drm_seq_file_printer(m);
 
 	if (!priv->gpu)
 		return;
 
-	msm_gpu_show_fdinfo(priv->gpu, file->driver_priv, &p);
+	msm_gpu_show_fdinfo(priv->gpu, file->driver_priv, p);
 }
 
 static const struct file_operations fops = {
 	.owner = THIS_MODULE,
 	DRM_GEM_FOPS,
-	.show_fdinfo = msm_fop_show_fdinfo,
+	.show_fdinfo = drm_fop_show_fdinfo,
 };
 
 static const struct drm_driver msm_driver = {
@@ -1070,7 +1068,7 @@ static const struct drm_driver msm_driver = {
 				DRIVER_SYNCOBJ_TIMELINE |
 				DRIVER_SYNCOBJ,
 	.open               = msm_open,
-	.postclose           = msm_postclose,
+	.postclose          = msm_postclose,
 	.lastclose          = drm_fb_helper_lastclose,
 	.dumb_create        = msm_gem_dumb_create,
 	.dumb_map_offset    = msm_gem_dumb_map_offset,
@@ -1081,6 +1079,7 @@ static const struct drm_driver msm_driver = {
 #ifdef CONFIG_DEBUG_FS
 	.debugfs_init       = msm_debugfs_init,
 #endif
+	.show_fdinfo        = msm_show_fdinfo,
 	.ioctls             = msm_ioctls,
 	.num_ioctls         = ARRAY_SIZE(msm_ioctls),
 	.fops               = &fops,
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 26ebda40be4f..c403912d13ab 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -151,8 +151,6 @@ int msm_gpu_pm_suspend(struct msm_gpu *gpu)
 void msm_gpu_show_fdinfo(struct msm_gpu *gpu, struct msm_file_private *ctx,
 			 struct drm_printer *p)
 {
-	drm_printf(p, "drm-driver:\t%s\n", gpu->dev->driver->name);
-	drm_printf(p, "drm-client-id:\t%u\n", ctx->seqno);
 	drm_printf(p, "drm-engine-gpu:\t%llu ns\n", ctx->elapsed_ns);
 	drm_printf(p, "drm-cycles-gpu:\t%llu\n", ctx->cycles);
 	drm_printf(p, "drm-maxfreq-gpu:\t%u Hz\n", gpu->fast_rate);
-- 
2.39.2


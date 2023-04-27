Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC0C6F0B9F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 19:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjD0RzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 13:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244559AbjD0Ry1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 13:54:27 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5635FC0;
        Thu, 27 Apr 2023 10:54:14 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1a66888cb89so68369745ad.3;
        Thu, 27 Apr 2023 10:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682618054; x=1685210054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ok26iuO88WTdiTh3yqSvF0njUaJd/G7EVrYrB/tlNM=;
        b=NGkm71aOJ/s2qjTeR/gaLYWgyuhDv8G+me2tBr6PxbRaq548LAyp+ofSB/dnvdlG4R
         I0wgCM/25DaIqgEo3jPIP843OCkPqhy0nXXYCOS+CS1MurrPlIwbHuYOk/q+Z88c+IO0
         P6wg134IWILVVK6Br15IsyK1zVeHw7oqYdaMNk5qyypE++AIRlcPyHqgxZEQi2AqM6ks
         ylyb/vau7BR6OElUXcPm0NUbGJsAOUhzbqc3fv7+Ek4GhRxkujAVLcjGcNgB1cgZVi9g
         CWzq92oioySI+k78Up20FrrLdXQHF1kGfIuEF7/Uo1Vbs43oc8ko4IPQqQhI/FALmL32
         leFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682618054; x=1685210054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ok26iuO88WTdiTh3yqSvF0njUaJd/G7EVrYrB/tlNM=;
        b=MrxZ0u9IOzmG8gvvWYHsK0xJIT1nuG2VANwuUzjGn/v9SRaoErmbrNuGzbWbLjS1Rh
         qJB8FAkpO8swLvsJaduR6xBb+NTjpE32dvc+nnqro07Sl6CyFLbmR40VMJO4zi+dh0ie
         b5P1UQMXGbeXnPpmknocMefJ+mY9ecP88+eXkY0IeL4wsSFDmtIMKVagdtXZcfGmGfD2
         td325jE6Xpbtbx7/63mkJsCgU6ggRIVILF8m0oHGwHtblPq62N4/butlwBk83Wl/aPMB
         kvra4lfmVY0HbD2OVMMWuuiEkrjDEqQDwi4wrlKw6UWdJUJ6DfK7gy1lAE8bYcXoFojs
         z7ng==
X-Gm-Message-State: AC+VfDxLumcfMEnEG/GgMkNeEAe0eKzvhL8qcx4FBXKvosc1fcJnbssy
        CJoArExOjGYWbeaYIbWdUPw=
X-Google-Smtp-Source: ACHHUZ7NYzhki84oqM5sC/T0ASeC0x8KLgCKVbwvSy/vX3s9gdhOdDf04XFw8HA41JD89ghsoCr/qw==
X-Received: by 2002:a17:902:868a:b0:1a6:9f09:866d with SMTP id g10-20020a170902868a00b001a69f09866dmr2347865plo.61.1682618054077;
        Thu, 27 Apr 2023 10:54:14 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id ja14-20020a170902efce00b001a69dfd918dsm4852762plb.187.2023.04.27.10.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 10:54:13 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Christopher Healy <healych@amazon.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Chia-I Wu <olvaffe@gmail.com>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 9/9] drm/msm: Wire up comm/cmdline override for fdinfo
Date:   Thu, 27 Apr 2023 10:53:33 -0700
Message-Id: <20230427175340.1280952-10-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230427175340.1280952-1-robdclark@gmail.com>
References: <20230427175340.1280952-1-robdclark@gmail.com>
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

Also store the override strings in drm_file so that fdinfo can display
them.  We still need to keep our original copy as we could need these
override strings after the device file has been closed and drm_file
freed.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 24 +++++++++++++++++++++++-
 drivers/gpu/drm/msm/msm_drv.c           |  2 ++
 drivers/gpu/drm/msm/msm_gpu.h           | 10 ++++++++++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index bb38e728864d..a20c2622a61f 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -16,6 +16,7 @@
 #include <linux/soc/qcom/mdt_loader.h>
 #include <linux/nvmem-consumer.h>
 #include <soc/qcom/ocmem.h>
+#include <drm/drm_file.h>
 #include "adreno_gpu.h"
 #include "a6xx_gpu.h"
 #include "msm_gem.h"
@@ -398,7 +399,8 @@ int adreno_set_param(struct msm_gpu *gpu, struct msm_file_private *ctx,
 	switch (param) {
 	case MSM_PARAM_COMM:
 	case MSM_PARAM_CMDLINE: {
-		char *str, **paramp;
+		char *str, *str2, **paramp;
+		struct drm_file *file = ctx->file;
 
 		str = kmalloc(len + 1, GFP_KERNEL);
 		if (!str)
@@ -412,6 +414,13 @@ int adreno_set_param(struct msm_gpu *gpu, struct msm_file_private *ctx,
 		/* Ensure string is null terminated: */
 		str[len] = '\0';
 
+		/*
+		 * We need a 2nd copy for drm_file.. this copy can't replace
+		 * our internal copy in the ctx, because we may need it for
+		 * recovery/devcoredump after the file is already closed.
+		 */
+		str2 = kstrdup(str, GFP_KERNEL);
+
 		mutex_lock(&gpu->lock);
 
 		if (param == MSM_PARAM_COMM) {
@@ -425,6 +434,19 @@ int adreno_set_param(struct msm_gpu *gpu, struct msm_file_private *ctx,
 
 		mutex_unlock(&gpu->lock);
 
+		mutex_lock(&file->override_lock);
+
+		if (param == MSM_PARAM_COMM) {
+			paramp = &file->override_comm;
+		} else {
+			paramp = &file->override_cmdline;
+		}
+
+		kfree(*paramp);
+		*paramp = str2;
+
+		mutex_unlock(&file->override_lock);
+
 		return 0;
 	}
 	case MSM_PARAM_SYSPROF:
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 81a1371c0307..3a74b5653e96 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -581,6 +581,7 @@ static int context_init(struct drm_device *dev, struct drm_file *file)
 	rwlock_init(&ctx->queuelock);
 
 	kref_init(&ctx->ref);
+	ctx->file = file;
 	msm_submitqueue_init(dev, ctx);
 
 	ctx->aspace = msm_gpu_create_private_address_space(priv->gpu, current);
@@ -603,6 +604,7 @@ static int msm_open(struct drm_device *dev, struct drm_file *file)
 
 static void context_close(struct msm_file_private *ctx)
 {
+	ctx->file = NULL;
 	msm_submitqueue_close(ctx);
 	msm_file_private_put(ctx);
 }
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 7a4fa1b8655b..671ce89e61b0 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -359,6 +359,16 @@ struct msm_file_private {
 	struct kref ref;
 	int seqno;
 
+	/**
+	 * @file: link back to the associated drm_file
+	 *
+	 * Note that msm_file_private can outlive the drm_file, ie.
+	 * after the drm_file is closed but before jobs submitted have
+	 * been cleaned up.  After the drm_file is closed this will be
+	 * NULL.
+	 */
+	struct drm_file *file;
+
 	/**
 	 * sysprof:
 	 *
-- 
2.39.2


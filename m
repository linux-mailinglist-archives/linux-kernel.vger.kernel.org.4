Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63346F362A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 20:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjEASqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 14:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbjEASpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 14:45:40 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8822D5E;
        Mon,  1 May 2023 11:45:28 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-63b5c830d5eso1970884b3a.2;
        Mon, 01 May 2023 11:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682966728; x=1685558728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ej3O8h3ZWoAQLcK8hFb5Wz4fSCAI1uIdFPtS/Ymi5AQ=;
        b=JfC97d9J/pcL5yhiMnjDyNh4CwgNnz5usEsDqGGVxix+juBHtF7xvL/gwq/cTnbIq+
         QL1g8DGEL7BO3qNCQTgUHgzjNol8Pm4CN5SZpCeCdzCU4bIP1upsUloPENQI95r+3M+q
         vEw4GkunXAKMpq+iI781Qo5SNea6fmQgYx5lWlT1MSHXPw++AOPbxGiI1kylS31CmEPz
         haJ0ZSx4Evqiphrz1VMJBtR4e1Inkb9UHPUnwCmxCyqITmudcW+APDDX59qQp0R3R7Ud
         m+T75jT5Iy7xGr0lRffMTckGgdUb3b4Hn3Rh5R42SZkfW++4bM80lnob3bjEVumZtrCk
         Kthw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682966728; x=1685558728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ej3O8h3ZWoAQLcK8hFb5Wz4fSCAI1uIdFPtS/Ymi5AQ=;
        b=cNdzEeHRp2iZWgt7u/J4oGdR6+BYKk5L3K/4bKkVUbZhf/Yp0RhXDUU3e9DwbLwXz2
         /EZpUiJ4ZhisBK11JxtWm2Kd/3h2bIsRNCY0RRCpp3YDC7JZsHWMMicAGEtLCDhxRD/5
         8N+gn75FcbosCMX1OBJ9T/caMTjgGc+ECl6iDUFPuLPqbScSfsj1WvHfd/fDHDYK+uj5
         NfqJOk9F0GMqaoTweO4CcLjqaaFyGSFDrvTNQ+uumpGuKa/yxseH37u8V2eByEOBAYhJ
         ZV0XfmdzD9Z+Y8iZi4/HJtY3lrlvKoDCyAIZcyiiQcLkbbMKgJnrR9gVHSohR5FMwV05
         dgNw==
X-Gm-Message-State: AC+VfDwawWPLgFbWm8KhGxAqWbWZtf/NtXvTNVQWcKIt/0e21yuaPJTF
        /FX/SIT5PUcDqYmZQM7WyvQ=
X-Google-Smtp-Source: ACHHUZ6xjC+IXT/sFRGOEvj/MjCi4WpmFr5TYXENVRy6LJGbRoVdL674AZUJCcS7wUsvtrDT8RZ94A==
X-Received: by 2002:a17:902:d505:b0:1a9:9c5d:9fac with SMTP id b5-20020a170902d50500b001a99c5d9facmr18578911plg.33.1682966727756;
        Mon, 01 May 2023 11:45:27 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id c24-20020a170902d91800b001ab05828797sm416775plz.179.2023.05.01.11.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 11:45:27 -0700 (PDT)
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
        Elliot Berman <quic_eberman@quicinc.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 9/9] drm/msm: Wire up comm/cmdline override for fdinfo
Date:   Mon,  1 May 2023 11:44:55 -0700
Message-Id: <20230501184502.1620335-10-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501184502.1620335-1-robdclark@gmail.com>
References: <20230501184502.1620335-1-robdclark@gmail.com>
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
@@ -9,20 +9,21 @@
 #include <linux/ascii85.h>
 #include <linux/interconnect.h>
 #include <linux/firmware/qcom/qcom_scm.h>
 #include <linux/kernel.h>
 #include <linux/of_address.h>
 #include <linux/pm_opp.h>
 #include <linux/slab.h>
 #include <linux/soc/qcom/mdt_loader.h>
 #include <linux/nvmem-consumer.h>
 #include <soc/qcom/ocmem.h>
+#include <drm/drm_file.h>
 #include "adreno_gpu.h"
 #include "a6xx_gpu.h"
 #include "msm_gem.h"
 #include "msm_mmu.h"
 
 static u64 address_space_size = 0;
 MODULE_PARM_DESC(address_space_size, "Override for size of processes private GPU address space");
 module_param(address_space_size, ullong, 0600);
 
 static bool zap_available = true;
@@ -391,47 +392,68 @@ int adreno_set_param(struct msm_gpu *gpu, struct msm_file_private *ctx,
 			return -EINVAL;
 		break;
 	default:
 		if (len != 0)
 			return -EINVAL;
 	}
 
 	switch (param) {
 	case MSM_PARAM_COMM:
 	case MSM_PARAM_CMDLINE: {
-		char *str, **paramp;
+		char *str, *str2, **paramp;
+		struct drm_file *file = ctx->file;
 
 		str = kmalloc(len + 1, GFP_KERNEL);
 		if (!str)
 			return -ENOMEM;
 
 		if (copy_from_user(str, u64_to_user_ptr(value), len)) {
 			kfree(str);
 			return -EFAULT;
 		}
 
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
 			paramp = &ctx->comm;
 		} else {
 			paramp = &ctx->cmdline;
 		}
 
 		kfree(*paramp);
 		*paramp = str;
 
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
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
 		return msm_file_private_set_sysprof(ctx, gpu, value);
 	default:
 		DBG("%s: invalid param: %u", gpu->name, param);
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 81a1371c0307..3a74b5653e96 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -574,20 +574,21 @@ static int context_init(struct drm_device *dev, struct drm_file *file)
 	struct msm_file_private *ctx;
 
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
 
 	INIT_LIST_HEAD(&ctx->submitqueues);
 	rwlock_init(&ctx->queuelock);
 
 	kref_init(&ctx->ref);
+	ctx->file = file;
 	msm_submitqueue_init(dev, ctx);
 
 	ctx->aspace = msm_gpu_create_private_address_space(priv->gpu, current);
 	file->driver_priv = ctx;
 
 	ctx->seqno = atomic_inc_return(&ident);
 
 	return 0;
 }
 
@@ -596,20 +597,21 @@ static int msm_open(struct drm_device *dev, struct drm_file *file)
 	/* For now, load gpu on open.. to avoid the requirement of having
 	 * firmware in the initrd.
 	 */
 	load_gpu(dev);
 
 	return context_init(dev, file);
 }
 
 static void context_close(struct msm_file_private *ctx)
 {
+	ctx->file = NULL;
 	msm_submitqueue_close(ctx);
 	msm_file_private_put(ctx);
 }
 
 static void msm_postclose(struct drm_device *dev, struct drm_file *file)
 {
 	struct msm_drm_private *priv = dev->dev_private;
 	struct msm_file_private *ctx = file->driver_priv;
 
 	/*
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 7a4fa1b8655b..671ce89e61b0 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -352,20 +352,30 @@ struct msm_gpu_perfcntr {
  * @seqno:        unique per process seqno
  */
 struct msm_file_private {
 	rwlock_t queuelock;
 	struct list_head submitqueues;
 	int queueid;
 	struct msm_gem_address_space *aspace;
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
 	 * The value of MSM_PARAM_SYSPROF set by userspace.  This is
 	 * intended to be used by system profiling tools like Mesa's
 	 * pps-producer (perfetto), and restricted to CAP_SYS_ADMIN.
 	 *
 	 * Setting a value of 1 will preserve performance counters across
 	 * context switches.  Setting a value of 2 will in addition
 	 * suppress suspend.  (Performance counters lose state across
-- 
2.39.2


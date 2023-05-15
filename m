Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1FB702FE6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 16:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241577AbjEOOcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 10:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241813AbjEOObd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 10:31:33 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555D426B0;
        Mon, 15 May 2023 07:31:08 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1aaf91ae451so120213245ad.1;
        Mon, 15 May 2023 07:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684161067; x=1686753067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqnNhChLNbHWp6ove8p/hsKGE1errQugomyUMPMw9ls=;
        b=fH6QFLL+CYHRn+8pGwUhAoac0FbnvAZdJFesFc5r8vV/i196TOHCIInwyzzyYauNDq
         acsj5AK5T1CZRbpHYwsfuCkTfEN+oIgpxQ8RdewnHOZUIJ+r3yHmsajrya34xy0OX06e
         l+8w4DjDnnOBvWQSgYKhpLRTQYpaEd4eHayyR311Sc9vdPoexzdKBDGWXCtuJN6AlBCQ
         HYGRx4Vjk94ROq8FDS5u5TiFpmmJtI84qYwe/0flN5XGuSKkPFyCXBQYGHQeSkYwRBj6
         xfYGtyRQiZh9Ca/C1AWbjcK4HYqCbmkLZSUXqst/o1nRQJ6ji5MICuEQ0c6x3S3h/eQJ
         5FaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684161067; x=1686753067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qqnNhChLNbHWp6ove8p/hsKGE1errQugomyUMPMw9ls=;
        b=TBZNXhcgLWLHpOz0MsGauoRxu25RSy6oaA4WluyCAtPF/tWuJegLsildGWEowBpyuT
         GqH8SUomurEIdOVLbjKam/DIzvHyHEkhn33ENJnP2RT8uEvZuEDx38AWEn5moHRdZzOb
         rhZjkQlHOkI2yJ/OwzHguDkMsdnkiUFAKoMnEAu8puHg8dzB2oZg8CQreBOEQfAbhtOi
         26m56u5XhHsj9lvr3lbULYjNxwk6q2JT7XIhnKOqmQn+9r5UeAho7duQktqNYSLRdgnM
         ExEkh0ke0YBka9+FX6y/qe4g800PcLQBPeKpEuCoo+VT7MjR/rQCGa5j7sKAqeI1dcpI
         vQvg==
X-Gm-Message-State: AC+VfDw1pDccA007GNJOMWYyIB8Uzzo/pEVGoFpyzN1tkaskBxcoxZzs
        IsXG5/sCbR0agE26cvD3/7k=
X-Google-Smtp-Source: ACHHUZ45CjBOIkWOM6gt+Z5UDMQMYRnAACMza7WWCWB+vaTsz6VCtYycaRj+NUuppqX4mM9Nwmj5jA==
X-Received: by 2002:a17:902:be03:b0:1ab:797:afbe with SMTP id r3-20020a170902be0300b001ab0797afbemr32952864pls.8.1684161066640;
        Mon, 15 May 2023 07:31:06 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id p10-20020a1709026b8a00b001acaf7e22bdsm11708482plk.14.2023.05.15.07.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 07:31:06 -0700 (PDT)
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
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 9/9] drm/msm: Wire up comm/cmdline override for fdinfo
Date:   Mon, 15 May 2023 07:30:16 -0700
Message-Id: <20230515143023.801167-10-robdclark@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515143023.801167-1-robdclark@gmail.com>
References: <20230515143023.801167-1-robdclark@gmail.com>
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
index a403aebe7f5a..6dec1a3534f2 100644
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
2.40.1


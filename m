Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647AC702FDC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 16:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241450AbjEOObY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 10:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241639AbjEOObL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 10:31:11 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2932F2D4F;
        Mon, 15 May 2023 07:31:01 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1ab13da70a3so124326415ad.1;
        Mon, 15 May 2023 07:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684161060; x=1686753060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3L1H5A/AgNdZq2KMqprQZztlGdFsDSiLstadTyfsWps=;
        b=eCRMUe9GcCej4DZn0o5scm14epytTxlq5SKShRg5NCvxZfpyg0sZ9Sl/rB+3TLrnjW
         s7+4/FXsCbKSOTfS9q8e0PGpu6T2VfNwGBkf8dJhzC8RwZZhKAhzywnit04Doft9V0qp
         opsWuRAf6zsqCll2HTwlXoHpthYiZEN7bGnCg2aGMl1kmxVskL+1GnGHsgmbYCHhic0s
         VmNa7CFqFEVuHk0AkesRR1+kmS2hHB04LP1Ky3hw3GlkkgZWFjZvG4syg12T3qZzWNP+
         tBrXZmeupszD9NIkMbZwaRJe7ItV5YqzI/u1qG2P21uLKQ81ZM4OkRwO2qssdCLgl5Jg
         bm7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684161060; x=1686753060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3L1H5A/AgNdZq2KMqprQZztlGdFsDSiLstadTyfsWps=;
        b=l7Os79rfxgFiaIR3Hld2f7YpqD1l8ZrFBFCRaPIkmdqlfU0+nRx2754XeJQRzVzKgz
         LMqPkScAXpY81TbmChNgZUeA5C64tCxRlEgvM2SUdpvesmXJmIGfkMSMbnL1zWAKgcns
         zBR+yaM9/gxJsJbt54dEEJQNG5hoKfDp5Qpv0M47/8bG3syfrjWmA+bUkmvEK9rgsfx2
         HRrixRyiST+Ej4Qo1xy/dq++Ij74h2Crd991hV7TDVS2ASFQLUBZfoO7Tw6/mPpew9fa
         Ms+wT1xAgl3O1NO6hWPRjj47ee0aldMhGcLb0vhWMO2iw5mYDWzWSmQ9OYmyLWUFEl/E
         TUTA==
X-Gm-Message-State: AC+VfDy74Cp6Um5Eo4HCDr+eUr6VNbMW2ip4FOmR83W5veYWPOylk2QR
        QmHOigkOATzWyIpuq5P55P0=
X-Google-Smtp-Source: ACHHUZ6pvVnfptzAGB3VhyoJFkfiSRpU+DqPKt/RNYDksPRe5O/02m95S5dnueIYFETpJ/RpAzfMGw==
X-Received: by 2002:a17:903:185:b0:1a1:e237:5f0 with SMTP id z5-20020a170903018500b001a1e23705f0mr46730970plg.58.1684161060586;
        Mon, 15 May 2023 07:31:00 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id j12-20020a170902c3cc00b0019f3cc463absm13665435plj.0.2023.05.15.07.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 07:31:00 -0700 (PDT)
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
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 6/9] drm/msm: Add memory stats to fdinfo
Date:   Mon, 15 May 2023 07:30:13 -0700
Message-Id: <20230515143023.801167-7-robdclark@gmail.com>
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

Use the new helper to export stats about memory usage.

v2: Drop unintended hunk
v3: Rebase

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
---
 drivers/gpu/drm/msm/msm_drv.c |  2 ++
 drivers/gpu/drm/msm/msm_gem.c | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 467c689a95f2..a403aebe7f5a 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -1045,20 +1045,22 @@ static const struct drm_ioctl_desc msm_ioctls[] = {
 
 static void msm_show_fdinfo(struct drm_printer *p, struct drm_file *file)
 {
 	struct drm_device *dev = file->minor->dev;
 	struct msm_drm_private *priv = dev->dev_private;
 
 	if (!priv->gpu)
 		return;
 
 	msm_gpu_show_fdinfo(priv->gpu, file->driver_priv, p);
+
+	drm_show_memory_stats(p, file);
 }
 
 static const struct file_operations fops = {
 	.owner = THIS_MODULE,
 	DRM_GEM_FOPS,
 	.show_fdinfo = drm_show_fdinfo,
 };
 
 static const struct drm_driver msm_driver = {
 	.driver_features    = DRIVER_GEM |
diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index cd39b9d8abdb..20cfd86d2b32 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -1083,34 +1083,49 @@ int msm_gem_new_handle(struct drm_device *dev, struct drm_file *file,
 		msm_gem_object_set_name(obj, "%s", name);
 
 	ret = drm_gem_handle_create(file, obj, handle);
 
 	/* drop reference from allocate - handle holds it now */
 	drm_gem_object_put(obj);
 
 	return ret;
 }
 
+static enum drm_gem_object_status msm_gem_status(struct drm_gem_object *obj)
+{
+	struct msm_gem_object *msm_obj = to_msm_bo(obj);
+	enum drm_gem_object_status status = 0;
+
+	if (msm_obj->pages)
+		status |= DRM_GEM_OBJECT_RESIDENT;
+
+	if (msm_obj->madv == MSM_MADV_DONTNEED)
+		status |= DRM_GEM_OBJECT_PURGEABLE;
+
+	return status;
+}
+
 static const struct vm_operations_struct vm_ops = {
 	.fault = msm_gem_fault,
 	.open = drm_gem_vm_open,
 	.close = drm_gem_vm_close,
 };
 
 static const struct drm_gem_object_funcs msm_gem_object_funcs = {
 	.free = msm_gem_free_object,
 	.pin = msm_gem_prime_pin,
 	.unpin = msm_gem_prime_unpin,
 	.get_sg_table = msm_gem_prime_get_sg_table,
 	.vmap = msm_gem_prime_vmap,
 	.vunmap = msm_gem_prime_vunmap,
 	.mmap = msm_gem_object_mmap,
+	.status = msm_gem_status,
 	.vm_ops = &vm_ops,
 };
 
 static int msm_gem_new_impl(struct drm_device *dev,
 		uint32_t size, uint32_t flags,
 		struct drm_gem_object **obj)
 {
 	struct msm_drm_private *priv = dev->dev_private;
 	struct msm_gem_object *msm_obj;
 
-- 
2.40.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19996F0B99
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 19:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244476AbjD0Ryc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 13:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244353AbjD0RyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 13:54:23 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79033A8D;
        Thu, 27 Apr 2023 10:54:07 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-517bdc9e81dso5194682a12.1;
        Thu, 27 Apr 2023 10:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682618047; x=1685210047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tk36LHgT7Zd3DnVnkUrHTABb/+wFJaIJC2KssqoMtiA=;
        b=eLrWdp6G4Kchqv4Qdaauo7bSYHMHL3SgbOabiyKhti17zyGH3h7Fn5HV8Rjz/7qIUT
         u7lM4YrdTNZ9IYLVHRBiOuF2MFueaj6VxzcGfAm1y2HXpLywUb0Yr5/HwDnmmnahA8yY
         gkPqgz/HtXC50zqptgdfI/DyIlOj/WpKZssQISqmRNJ3dL8peof2/aLv2sMbKyyrTpiu
         JO3IMj1mhKLtQshAka98lVJX7Od8yfJiwNScAxYZ26Fbs4k8k6mOWaBHNe+P5BqTxET6
         gE40PvRGCjMy/SpZLKboyq710VewPdBfOVhTqamRYrUMYAC6Ni6wHczYFR24EHIFxaXE
         pmxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682618047; x=1685210047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tk36LHgT7Zd3DnVnkUrHTABb/+wFJaIJC2KssqoMtiA=;
        b=FP7BzbowclOj8d8hV2C2/Mb9OV7+9pGLX2EXkD/KGUywHgcD7tnM/J5G+W2yqRucJs
         J3AIpAeIPXlBb7tNv15Ur7Gp5OaPkRmL/WUC5467wdhAM0LLaJB53ZMy/DMDwFuCwFXW
         RqgcA4pjgwBSq2/85oD+DyS8z4VOovEv99VVt/G3GJawkysLef6FdXo7OWJm3DD30MwO
         06awaCzyUqwNTL91K7RuyqhOMT5ABQ6Dip767qJK3SUxwUhsb0QiMog++4eCcqAf3uIm
         gst61E+LCniYAm+vQZOm1JiRgLRcNpBht9Bt6n3df0te1pJtsifMrHg02dfZGsubXxWO
         GoGQ==
X-Gm-Message-State: AC+VfDxvKJ9YOCXrD9XBs19ruN4S8wa1OKBK33FqC/O22ZiHYvSNMra/
        f46nZWXpjhbokPTI0xvCdPo=
X-Google-Smtp-Source: ACHHUZ60SORnik/eSAifUwaYbsYC/Ea5qlWfZS6XAVfSHEgeUf/F/4TBA83gnvjAxC1qtMElfaHudw==
X-Received: by 2002:a17:90b:4f4b:b0:23d:31c3:c98d with SMTP id pj11-20020a17090b4f4b00b0023d31c3c98dmr2686481pjb.15.1682618046972;
        Thu, 27 Apr 2023 10:54:06 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id r78-20020a632b51000000b00520f316ebe3sm11614239pgr.62.2023.04.27.10.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 10:54:06 -0700 (PDT)
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
Subject: [PATCH v2 6/9] drm/msm: Add memory stats to fdinfo
Date:   Thu, 27 Apr 2023 10:53:30 -0700
Message-Id: <20230427175340.1280952-7-robdclark@gmail.com>
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
index 1e941aa77609..81a1371c0307 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -1052,6 +1052,8 @@ static void msm_show_fdinfo(struct drm_printer *p, struct drm_file *file)
 		return;
 
 	msm_gpu_show_fdinfo(priv->gpu, file->driver_priv, p);
+
+	drm_show_memory_stats(p, file);
 }
 
 static const struct file_operations fops = {
diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index cd39b9d8abdb..20cfd86d2b32 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -1090,6 +1090,20 @@ int msm_gem_new_handle(struct drm_device *dev, struct drm_file *file,
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
@@ -1104,6 +1118,7 @@ static const struct drm_gem_object_funcs msm_gem_object_funcs = {
 	.vmap = msm_gem_prime_vmap,
 	.vunmap = msm_gem_prime_vunmap,
 	.mmap = msm_gem_object_mmap,
+	.status = msm_gem_status,
 	.vm_ops = &vm_ops,
 };
 
-- 
2.39.2


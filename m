Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818E770FB3F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 18:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238446AbjEXQB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 12:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238426AbjEXQBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 12:01:18 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AEC13A;
        Wed, 24 May 2023 09:00:44 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-53482b44007so346235a12.2;
        Wed, 24 May 2023 09:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684944037; x=1687536037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jm+2eVuJ9R4bEqEphmNY+ONsUg1tV+e6toSMo5kMY6k=;
        b=q1VpPZyD+nYPnYezdhRT00RybGny9C4lNkC4miOFMe4161KJ43bBPpVu95XgkMlmxL
         mX4VNz2KWsGQyqERKRIyjzfl/4ZaXfv1/GdTv8+Qk8Xa2Ir0qqa6HUJ0uBtP7ymnAlBs
         ioz7ArkMdhtQdnfnGmwU40avtqQzPNgU5GhZMKPlUfPLkY8Wcd9fqL793zMPh9XfceZi
         zPFkwlGVMNCRsRRsWGwK/RIs1QKX/AImVQ85WSwxdwJgG0eyDUTCt2MGkKQhcl8Z7byP
         sKaZmP/NMt7yyRT8guvwS3r7Cig36TA393sasu1tae77JZ6e+RFnrtSh8Dc8b1GRQuG2
         VGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684944037; x=1687536037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jm+2eVuJ9R4bEqEphmNY+ONsUg1tV+e6toSMo5kMY6k=;
        b=kFF/looAYSS8jrgrmSH+HNoYjcbp9GN6MKw6ZhIz+qnIQSekgZcnF1tcoPg7IAUrMc
         8qIpvtkAFgeA5UYlejhZGZ5FBmtOAXeWQ3QtdKhqxe3JA94YLSZFlzYwKmqbuubzBgJw
         LK1/vfEfqtpsQSxm0KN+GA1PzKsPD6uHi3Ify7d69ZcU5QdU7zaImpdRpjywHwlvMr4c
         p4rQEptUIYEvC+Ml05/7nWDsH8mqpq1oAMKoE1DMjSUZE3cDYwAMA0OwZ5/Zh7G2akwo
         Mco6tKymaEUfcPM1e94Szhvtmc04zhUcKt0fJ4EMHUPRanTmOrD4MYwhoAkNgaAjXNi8
         7QIQ==
X-Gm-Message-State: AC+VfDzllAhSVw5W3DbQuwyMcwFJjybK39qAyfAZ3UuHf4hVTTASX17q
        tMkKEsecdk/7GQ8IYhffwYM=
X-Google-Smtp-Source: ACHHUZ5/AKM5rkM7PzF/QTY24ajzauhpViEEpLlFzZy/a838vAMr/lNMwq5NczwDPFVd7bvqBTk5yQ==
X-Received: by 2002:a17:902:a989:b0:1af:e63f:5bb1 with SMTP id bh9-20020a170902a98900b001afe63f5bb1mr1739595plb.7.1684944036844;
        Wed, 24 May 2023 09:00:36 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id x1-20020a170902a38100b001ae6b4b28adsm9041318pla.130.2023.05.24.09.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 09:00:36 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Christopher Healy <healych@amazon.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Rob Clark <robdclark@chromium.org>,
        Dave Airlie <airlied@redhat.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 6/7] drm/msm: Add memory stats to fdinfo
Date:   Wed, 24 May 2023 08:59:36 -0700
Message-Id: <20230524155956.382440-7-robdclark@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230524155956.382440-1-robdclark@gmail.com>
References: <20230524155956.382440-1-robdclark@gmail.com>
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
Acked-by: Dave Airlie <airlied@redhat.com>
---
 drivers/gpu/drm/msm/msm_drv.c |  2 ++
 drivers/gpu/drm/msm/msm_gem.c | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 02fd6093f9b0..58264ff2c4b1 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -1059,20 +1059,22 @@ static const struct drm_ioctl_desc msm_ioctls[] = {
 
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
index db6c4e281d75..c32264234ea1 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -1089,34 +1089,49 @@ int msm_gem_new_handle(struct drm_device *dev, struct drm_file *file,
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


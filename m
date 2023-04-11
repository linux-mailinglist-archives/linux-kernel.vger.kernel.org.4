Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEFE6DE7A5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 00:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjDKW55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 18:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjDKW5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 18:57:52 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE36449C;
        Tue, 11 Apr 2023 15:57:50 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id e18-20020a17090ac21200b00246952d917fso8089888pjt.4;
        Tue, 11 Apr 2023 15:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681253869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IA16a8P3ifQnuFE2cU6SZqzeMpec7rd2aaRk7CHbWjo=;
        b=N1wV9W1CkfJg8ZW8nbO/XbncdQcQ5WGUtAM39mq0MG54NQ569pUJsbxo8xSPP82eit
         Aw1VXkHGLydvIe2j7Xskuta625jMiaCqT3wkVDU9Nklhk1E50eh93rQ4W+epDDOw1hCC
         TDYs1dg+HW2pUlvEQSCcjOSegMnOP82/h46z/2i5x8r+Ia8Gv2Obf5QLbH/v8KXbW3xM
         btyYK0XK+zdVkAi+aleiIramImekj7X87ikeburFiU/L2qvhqMWTQU+KqydDKsnJ3vlv
         kGG+jOK8ZET2J3IVZPTATZNhsfpgnWv0E4G9FBmaV3Gx7ZtDKixAi7Acr5hArBjCpqRQ
         QzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681253869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IA16a8P3ifQnuFE2cU6SZqzeMpec7rd2aaRk7CHbWjo=;
        b=vdJ9DDoNHagJF+Wxjw2uZPYomDhrhISMoEAnxaYUBbJskk7JtZ3Oz8iGrwF69yDa/i
         O/OqUDpcm6+PFsahiPtDIp5MlI6Rhi5gQib74/FB5KY2Kz1m9fUmTcRJbkSPkw0wmkM1
         Q0SdkOampMrMjOgMyIOPMcOJi6srbiQFfeAavqqlt71Fqt8nJ8K4NwtpSXk+R8hH46AI
         oe2FQMoc8fQVADuu0ByqxIDgKVDr9pXpJOaBi1v7u4wYIucwag+Tw4Q5NoGQvvPCBuLa
         12edYC8ZEUvyMNz5T/f5lHPSiSAmcLA2JtaTMPTnXHmxwgegVyIxsYZHUswGlsdutA6p
         QB0Q==
X-Gm-Message-State: AAQBX9cJAopuL0w7uF/XoQ17UcuHC7AjkXDy2h2QJKqIMfjSmwVAxWMM
        Ajh8Nme8xXfGkU/oBjWiF4E=
X-Google-Smtp-Source: AKy350bEeqU5DiwN669zYMn8njQUVxYmCFUZdbZaRVA3pKtDRjjEcnb2lSJmj4IgzOT1GoTtagoJXQ==
X-Received: by 2002:a17:90b:3892:b0:246:c223:14ba with SMTP id mu18-20020a17090b389200b00246c22314bamr8589895pjb.28.1681253869342;
        Tue, 11 Apr 2023 15:57:49 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id jw8-20020a170903278800b001a649347f59sm3626131plb.12.2023.04.11.15.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 15:57:49 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Christopher Healy <healych@amazon.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Guchun Chen <guchun.chen@amd.com>,
        YiPeng Chai <YiPeng.Chai@amd.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <mdaenzer@redhat.com>,
        Shashank Sharma <shashank.sharma@amd.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
        amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 3/7] drm/amdgpu: Switch to fdinfo helper
Date:   Tue, 11 Apr 2023 15:56:08 -0700
Message-Id: <20230411225725.2032862-4-robdclark@gmail.com>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 16 ++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h |  2 +-
 3 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index f5ffca24def4..3611cfd5f076 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2752,7 +2752,7 @@ static const struct file_operations amdgpu_driver_kms_fops = {
 	.compat_ioctl = amdgpu_kms_compat_ioctl,
 #endif
 #ifdef CONFIG_PROC_FS
-	.show_fdinfo = amdgpu_show_fdinfo
+	.show_fdinfo = drm_fop_show_fdinfo,
 #endif
 };
 
@@ -2807,6 +2807,7 @@ static const struct drm_driver amdgpu_kms_driver = {
 	.dumb_map_offset = amdgpu_mode_dumb_mmap,
 	.fops = &amdgpu_driver_kms_fops,
 	.release = &amdgpu_driver_release_kms,
+	.show_fdinfo = amdgpu_show_fdinfo,
 
 	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
 	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
index 99a7855ab1bc..c2fdd5e448d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
@@ -53,9 +53,8 @@ static const char *amdgpu_ip_name[AMDGPU_HW_IP_NUM] = {
 	[AMDGPU_HW_IP_VCN_JPEG]	=	"jpeg",
 };
 
-void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
+void amdgpu_show_fdinfo(struct drm_printer *p, struct drm_file *file)
 {
-	struct drm_file *file = f->private_data;
 	struct amdgpu_device *adev = drm_to_adev(file->minor->dev);
 	struct amdgpu_fpriv *fpriv = file->driver_priv;
 	struct amdgpu_vm *vm = &fpriv->vm;
@@ -86,18 +85,15 @@ void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
 	 * ******************************************************************
 	 */
 
-	seq_printf(m, "pasid:\t%u\n", fpriv->vm.pasid);
-	seq_printf(m, "drm-driver:\t%s\n", file->minor->dev->driver->name);
-	seq_printf(m, "drm-pdev:\t%04x:%02x:%02x.%d\n", domain, bus, dev, fn);
-	seq_printf(m, "drm-client-id:\t%Lu\n", vm->immediate.fence_context);
-	seq_printf(m, "drm-memory-vram:\t%llu KiB\n", vram_mem/1024UL);
-	seq_printf(m, "drm-memory-gtt: \t%llu KiB\n", gtt_mem/1024UL);
-	seq_printf(m, "drm-memory-cpu: \t%llu KiB\n", cpu_mem/1024UL);
+	drm_printf(p, "pasid:\t%u\n", fpriv->vm.pasid);
+	drm_printf(p, "drm-memory-vram:\t%llu KiB\n", vram_mem/1024UL);
+	drm_printf(p, "drm-memory-gtt: \t%llu KiB\n", gtt_mem/1024UL);
+	drm_printf(p, "drm-memory-cpu: \t%llu KiB\n", cpu_mem/1024UL);
 	for (hw_ip = 0; hw_ip < AMDGPU_HW_IP_NUM; ++hw_ip) {
 		if (!usage[hw_ip])
 			continue;
 
-		seq_printf(m, "drm-engine-%s:\t%Ld ns\n", amdgpu_ip_name[hw_ip],
+		drm_printf(p, "drm-engine-%s:\t%Ld ns\n", amdgpu_ip_name[hw_ip],
 			   ktime_to_ns(usage[hw_ip]));
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h
index e86834bfea1d..0398f5a159ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h
@@ -37,6 +37,6 @@
 #include "amdgpu_ids.h"
 
 uint32_t amdgpu_get_ip_count(struct amdgpu_device *adev, int id);
-void amdgpu_show_fdinfo(struct seq_file *m, struct file *f);
+void amdgpu_show_fdinfo(struct drm_printer *p, struct drm_file *file);
 
 #endif
-- 
2.39.2


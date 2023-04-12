Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEC96E020B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 00:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjDLWni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 18:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjDLWne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 18:43:34 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C28E86AA;
        Wed, 12 Apr 2023 15:43:29 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id pm7-20020a17090b3c4700b00246f00dace2so5302615pjb.2;
        Wed, 12 Apr 2023 15:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681339409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+8Kg/kNPwcKOz+4LjRQVlRin3sixAOkoK4oz+w+/O4=;
        b=KEZxSYnDLqbxiIELLgGmH5WMU+InSNSVG5wcXAaTh3Y42Kai/vVgm+obE/d+VM5kMR
         1/vISXdfNhzXOwnUEul+zynTB4OW412EM30TggX3KL2jCuWBfmKEJWRxpoBgniuRRXGE
         +9WhaPFXVY8A/la+25DwEiF/In4QQgD3CTHQ3MEqGuTKbfQYdc3pjJudcDec+VScpF3S
         0f1cLJUa5c+ASLHFcKvB64i9fMZeUM1kkSHtsRcYKnpXIPe2aR8tRxGZurOhUc/NLL5K
         1Q/HhLYVcmGzTjwJHT83E163fhcEodO8ZMjRkTBNPII/BwdYlQgkw9lW8xwybVynAVUm
         5sSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681339409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1+8Kg/kNPwcKOz+4LjRQVlRin3sixAOkoK4oz+w+/O4=;
        b=CtG1a3geP8O51Ta/inKslTUIr4v6ckIW0FsM6LZSDxPWydPFwRkl52wmxsC4CvsG5k
         q5R8oxNiqIb4JjNGCCyHloPmXNHUzgBl2eGF1GkprOBC3WtyfuAMRlNwZeHP77dPxSG5
         0j32A2lt8xlm3LPS1eNmBcj3MMq1KunZdSrlgpgIveRpIVQC4yHld+/XYwJ6gtH9A+6c
         84DvmkEgoECOHn3ewWNukI0WnDdNisKxEy1GCTg//1qsLydvMgqjLatPuGHRFeO+xIub
         uFX9tPkwh80UmVGqFNL5vPEyPz1cLLSoscN9AKCk0QrM4JEzb6oQrWIhEwKJnXpMZDl3
         ONJQ==
X-Gm-Message-State: AAQBX9f0g69O4URMWY4u3tZMcPNXBQSFWou/DVHmB9M9Cla+iEmgWWJb
        eqG3JYtL/Se1DJDWp5ULCxc=
X-Google-Smtp-Source: AKy350ZRPl9FyXpfXCFguaRzrhPjb2d1x6cu8Y5w+Uhz+R0dIoAMVKUGmnGH8T3ZBspUrMjCGQMuGQ==
X-Received: by 2002:a17:90a:9316:b0:246:b617:c730 with SMTP id p22-20020a17090a931600b00246b617c730mr4167515pjo.39.1681339408823;
        Wed, 12 Apr 2023 15:43:28 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id jm10-20020a17090304ca00b001a55c2a42f6sm91859plb.158.2023.04.12.15.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 15:43:28 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Christopher Healy <healych@amazon.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Evan Quan <evan.quan@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        YiPeng Chai <YiPeng.Chai@amd.com>,
        Guchun Chen <guchun.chen@amd.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <mdaenzer@redhat.com>,
        Shashank Sharma <shashank.sharma@amd.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
        amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 3/6] drm/amdgpu: Switch to fdinfo helper
Date:   Wed, 12 Apr 2023 15:42:55 -0700
Message-Id: <20230412224311.23511-4-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230412224311.23511-1-robdclark@gmail.com>
References: <20230412224311.23511-1-robdclark@gmail.com>
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
index f5ffca24def4..6c0e0c614b94 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2752,7 +2752,7 @@ static const struct file_operations amdgpu_driver_kms_fops = {
 	.compat_ioctl = amdgpu_kms_compat_ioctl,
 #endif
 #ifdef CONFIG_PROC_FS
-	.show_fdinfo = amdgpu_show_fdinfo
+	.show_fdinfo = drm_show_fdinfo,
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


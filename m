Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3766EC376
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 03:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjDXBoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 21:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjDXBoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 21:44:18 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD41E10CC
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 18:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=0Sf6LJiinXD0+Z04+CoBCjhP6xRPg9WnwCH4CvJn44g=; b=JIcVwiky7ofsROMjxVeNT+AQEL
        gSU2A0P4XNRrWSyZwXgZi/+FOiKwNjUmXLgtMSC3hz+vOL4g/EYOnY170TdlZqVgSFfImBxA5+sFo
        iPTnAFTQhlifb5rJHjqGpyfhf49jz7pt0yN/UHMkYNQhAgwyslyIB6BdsBlZIenn4GiL/Fv98NYDA
        gDjFSgCcyQTeR6ls08+hXDWYDf3aGeA9zCejqkMaiEnzaEcH089aZc9Mdl5B++z2groTyLjc1dsvd
        uEwnjUDOTomCjEfvzlCCPNtq5LZI0vv+SN0/hE1Ll2yuZ85HzJY2PD2SVyNZWUA3DjgMnj0HnB+It
        xX5CGfEQ==;
Received: from [152.249.146.45] (helo=steammachine.lan)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1pqlFV-00AeE7-4w; Mon, 24 Apr 2023 03:44:13 +0200
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     kernel-dev@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
        =?UTF-8?q?=27Marek=20Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH] drm/amdgpu: Mark contexts guilty for any reset type
Date:   Sun, 23 Apr 2023 22:43:24 -0300
Message-Id: <20230424014324.218531-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a DRM job timeout, the GPU is probably hang and amdgpu have some
ways to deal with that, ranging from soft recoveries to full device
reset. Anyway, when userspace ask the kernel the state of the context
(via AMDGPU_CTX_OP_QUERY_STATE), the kernel reports that the device was
reset, regardless if a full reset happened or not.

However, amdgpu only marks a context guilty in the ASIC reset path. This
makes the userspace report incomplete, given that on soft recovery path
the guilty context is not told that it's the guilty one.

Fix this by marking the context guilty for every type of reset when a
job timeouts.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 8 +++++++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ac78caa7cba8..ea169d1689e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4771,9 +4771,6 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 
 	amdgpu_fence_driver_isr_toggle(adev, false);
 
-	if (job && job->vm)
-		drm_sched_increase_karma(&job->base);
-
 	r = amdgpu_reset_prepare_hwcontext(adev, reset_context);
 	/* If reset handler not implemented, continue; otherwise return */
 	if (r == -ENOSYS)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index c3d9d75143f4..097ed8f06865 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -51,6 +51,13 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	memset(&ti, 0, sizeof(struct amdgpu_task_info));
 	adev->job_hang = true;
 
+	amdgpu_vm_get_task_info(ring->adev, job->pasid, &ti);
+
+	if (job && job->vm) {
+		DRM_INFO("marking %s context as guilty", ti.process_name);
+		drm_sched_increase_karma(&job->base);
+	}
+
 	if (amdgpu_gpu_recovery &&
 	    amdgpu_ring_soft_recovery(ring, job->vmid, s_job->s_fence->parent)) {
 		DRM_ERROR("ring %s timeout, but soft recovered\n",
@@ -58,7 +65,6 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		goto exit;
 	}
 
-	amdgpu_vm_get_task_info(ring->adev, job->pasid, &ti);
 	DRM_ERROR("ring %s timeout, signaled seq=%u, emitted seq=%u\n",
 		  job->base.sched->name, atomic_read(&ring->fence_drv.last_seq),
 		  ring->fence_drv.sync_seq);
-- 
2.40.0


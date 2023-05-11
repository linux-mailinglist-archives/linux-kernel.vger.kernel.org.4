Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59CC6FFA66
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 21:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239299AbjEKTjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 15:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239318AbjEKTjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 15:39:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C9D9EE4;
        Thu, 11 May 2023 12:39:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54B7865110;
        Thu, 11 May 2023 19:39:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62CFEC433D2;
        Thu, 11 May 2023 19:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683833951;
        bh=eNycnredhXAYz/2qt9TjtyKYtBfC/Plb8nrPCgrEJTo=;
        h=From:To:Cc:Subject:Date:From;
        b=HXk1IV5NOoi6bOCz0VFa2qxKeXdJpL3T31zsK9xhBiM2l8gei7KHzZpcHmg06Qazj
         Qkr/HAlxGo69Lv82TgRetke3oaSpSs3R3qZuIiSrCtvW72XxwWY8mFlTSjUh62/dBv
         llHZjFHnJecCuDkkBm+IN0OzfJWqpoDtLINXsINVP4dxOWPQH/C+wvihEJqCWJJaOk
         4DZ7MiG9DY91qF1mDSKiwBUPDF3HbeqYGevNoB2qaatINb9tN+3tGdgP70nDcS682W
         dTmv90Ied7ynD/p7R1aXTOA2oR/MLDcOzAuYOnVjHbeQtf5Plf+oBynreZWjjTXJHt
         txOhk09NWZMMQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chong Li <chongli2@amd.com>, JingWen.Chen2@amd.com,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        Hawking.Zhang@amd.com, mario.limonciello@amd.com,
        lijo.lazar@amd.com, YiPeng.Chai@amd.com, andrey.grodzovsky@amd.com,
        Amaranath.Somalapuram@amd.com, Bokun.Zhang@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.2 01/10] drm/amdgpu: release gpu full access after "amdgpu_device_ip_late_init"
Date:   Thu, 11 May 2023 15:38:39 -0400
Message-Id: <20230511193850.623289-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chong Li <chongli2@amd.com>

[ Upstream commit 38eecbe086a4e52f54b2bbda8feba65d44addbef ]

[WHY]
 Function "amdgpu_irq_update()" called by "amdgpu_device_ip_late_init()" is an atomic context.
 We shouldn't access registers through KIQ since "msleep()" may be called in "amdgpu_kiq_rreg()".

[HOW]
 Move function "amdgpu_virt_release_full_gpu()" after function "amdgpu_device_ip_late_init()",
 to ensure that registers be accessed through RLCG instead of KIQ.

Call Trace:
  <TASK>
  show_stack+0x52/0x69
  dump_stack_lvl+0x49/0x6d
  dump_stack+0x10/0x18
  __schedule_bug.cold+0x4f/0x6b
  __schedule+0x473/0x5d0
  ? __wake_up_klogd.part.0+0x40/0x70
  ? vprintk_emit+0xbe/0x1f0
  schedule+0x68/0x110
  schedule_timeout+0x87/0x160
  ? timer_migration_handler+0xa0/0xa0
  msleep+0x2d/0x50
  amdgpu_kiq_rreg+0x18d/0x1f0 [amdgpu]
  amdgpu_device_rreg.part.0+0x59/0xd0 [amdgpu]
  amdgpu_device_rreg+0x3a/0x50 [amdgpu]
  amdgpu_sriov_rreg+0x3c/0xb0 [amdgpu]
  gfx_v10_0_set_gfx_eop_interrupt_state.constprop.0+0x16c/0x190 [amdgpu]
  gfx_v10_0_set_eop_interrupt_state+0xa5/0xb0 [amdgpu]
  amdgpu_irq_update+0x53/0x80 [amdgpu]
  amdgpu_irq_get+0x7c/0xb0 [amdgpu]
  amdgpu_fence_driver_hw_init+0x58/0x90 [amdgpu]
  amdgpu_device_init.cold+0x16b7/0x2022 [amdgpu]

Signed-off-by: Chong Li <chongli2@amd.com>
Reviewed-by: JingWen.Chen2@amd.com
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 32 ++++++++++++----------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3dac1e139c5f3..2af5f9f62b93b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2522,8 +2522,6 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	amdgpu_fru_get_product_info(adev);
 
 init_failed:
-	if (amdgpu_sriov_vf(adev))
-		amdgpu_virt_release_full_gpu(adev, true);
 
 	return r;
 }
@@ -3847,18 +3845,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	r = amdgpu_device_ip_init(adev);
 	if (r) {
-		/* failed in exclusive mode due to timeout */
-		if (amdgpu_sriov_vf(adev) &&
-		    !amdgpu_sriov_runtime(adev) &&
-		    amdgpu_virt_mmio_blocked(adev) &&
-		    !amdgpu_virt_wait_reset(adev)) {
-			dev_err(adev->dev, "VF exclusive mode timeout\n");
-			/* Don't send request since VF is inactive. */
-			adev->virt.caps &= ~AMDGPU_SRIOV_CAPS_RUNTIME;
-			adev->virt.ops = NULL;
-			r = -EAGAIN;
-			goto release_ras_con;
-		}
 		dev_err(adev->dev, "amdgpu_device_ip_init failed\n");
 		amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_AMDGPU_INIT_FAIL, 0, 0);
 		goto release_ras_con;
@@ -3930,8 +3916,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 				   msecs_to_jiffies(AMDGPU_RESUME_MS));
 	}
 
-	if (amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev)) {
+		amdgpu_virt_release_full_gpu(adev, true);
 		flush_delayed_work(&adev->delayed_init_work);
+	}
 
 	r = sysfs_create_files(&adev->dev->kobj, amdgpu_dev_attributes);
 	if (r)
@@ -3968,6 +3956,20 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	return 0;
 
 release_ras_con:
+	if (amdgpu_sriov_vf(adev))
+		amdgpu_virt_release_full_gpu(adev, true);
+
+	/* failed in exclusive mode due to timeout */
+	if (amdgpu_sriov_vf(adev) &&
+		!amdgpu_sriov_runtime(adev) &&
+		amdgpu_virt_mmio_blocked(adev) &&
+		!amdgpu_virt_wait_reset(adev)) {
+		dev_err(adev->dev, "VF exclusive mode timeout\n");
+		/* Don't send request since VF is inactive. */
+		adev->virt.caps &= ~AMDGPU_SRIOV_CAPS_RUNTIME;
+		adev->virt.ops = NULL;
+		r = -EAGAIN;
+	}
 	amdgpu_release_ras_context(adev);
 
 failed:
-- 
2.39.2


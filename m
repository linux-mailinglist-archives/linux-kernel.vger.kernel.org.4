Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9750B6CD728
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 12:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjC2KAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 06:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbjC2KAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 06:00:48 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8731A3C13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 03:00:46 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 269323F7EC;
        Wed, 29 Mar 2023 10:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1680084045;
        bh=VMzLHhxzhHC4PRmh66lC+fdivOWneh5TdLK3pKLgHuw=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=U47maoOSC0R9+1f324S7g9AXqoEBBe5DM30hBLFLgstnYXuA0PCxRV4f7Q0xji9hB
         SNBLKM9vNscR9YFs2QQlZsqLWbnOltBK/xgZPLYZVAZjvbtw9ZVe299refxOwoED9e
         5KB+Qnj4QWJIjxXRSCm8Myfu28dC7V1GThjgS5ud7xyOZbYQ1sgdZ9UZjx0yx4omrT
         Ym0JORgjADjxPLfnpx2irA1zRSXtclujWx2pOkYMTgLMz/mZ47UjORV+JGYO78Lo0v
         TQMilsci3clidA0S14HDJk3oKdsdlJusRuUEyMvgGx4Hv8Lyu6a6TFLhBcOxe1Xz1s
         H+cFLdJD1Lq0Q==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Likun Gao <Likun.Gao@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Victor Zhao <Victor.Zhao@amd.com>,
        Jack Xiao <Jack.Xiao@amd.com>,
        Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        YiPeng Chai <YiPeng.Chai@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Bokun Zhang <Bokun.Zhang@amd.com>,
        Guchun Chen <guchun.chen@amd.com>,
        Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>,
        Richard Gong <richard.gong@amd.com>,
        Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/amdgpu: Remove ASPM workaround on VI and NV
Date:   Wed, 29 Mar 2023 17:59:30 +0800
Message-Id: <20230329095933.1203559-2-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230329095933.1203559-1-kai.heng.feng@canonical.com>
References: <20230329095933.1203559-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the original issue is resolved by a new fix, the ASPM workaround
can be dropped.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 ---------------
 drivers/gpu/drm/amd/amdgpu/nv.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/vi.c            |  2 +-
 4 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 8cf2cc50b3de..a19a6489b117 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1248,7 +1248,6 @@ void amdgpu_device_pci_config_reset(struct amdgpu_device *adev);
 int amdgpu_device_pci_reset(struct amdgpu_device *adev);
 bool amdgpu_device_need_post(struct amdgpu_device *adev);
 bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev);
-bool amdgpu_device_aspm_support_quirk(void);
 
 void amdgpu_cs_report_moved_bytes(struct amdgpu_device *adev, u64 num_bytes,
 				  u64 num_vis_bytes);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d56b7a2bafa6..0cacace2d6c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -81,10 +81,6 @@
 
 #include <drm/drm_drv.h>
 
-#if IS_ENABLED(CONFIG_X86)
-#include <asm/intel-family.h>
-#endif
-
 MODULE_FIRMWARE("amdgpu/vega10_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/vega12_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/raven_gpu_info.bin");
@@ -1377,17 +1373,6 @@ bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev)
 	return pcie_aspm_enabled(adev->pdev);
 }
 
-bool amdgpu_device_aspm_support_quirk(void)
-{
-#if IS_ENABLED(CONFIG_X86)
-	struct cpuinfo_x86 *c = &cpu_data(0);
-
-	return !(c->x86 == 6 && c->x86_model == INTEL_FAM6_ALDERLAKE);
-#else
-	return true;
-#endif
-}
-
 /* if we get transitioned to only one device, take VGA back */
 /**
  * amdgpu_device_vga_set_decode - enable/disable vga decode
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 47420b403871..15f3c6745ea9 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -522,7 +522,7 @@ static int nv_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk)
 
 static void nv_program_aspm(struct amdgpu_device *adev)
 {
-	if (!amdgpu_device_should_use_aspm(adev) || !amdgpu_device_aspm_support_quirk())
+	if (!amdgpu_device_should_use_aspm(adev))
 		return;
 
 	if (!(adev->flags & AMD_IS_APU) &&
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 531f173ade2d..81dcb1148a60 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1122,7 +1122,7 @@ static void vi_program_aspm(struct amdgpu_device *adev)
 	bool bL1SS = false;
 	bool bClkReqSupport = true;
 
-	if (!amdgpu_device_should_use_aspm(adev) || !amdgpu_device_aspm_support_quirk())
+	if (!amdgpu_device_should_use_aspm(adev))
 		return;
 
 	if (adev->flags & AMD_IS_APU ||
-- 
2.34.1


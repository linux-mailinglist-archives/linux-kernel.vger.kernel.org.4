Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B80F6D5053
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 20:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbjDCS2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 14:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbjDCS2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 14:28:39 -0400
Received: from exchange.fintech.ru (e10edge.fintech.ru [195.54.195.159])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE64210D
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 11:28:36 -0700 (PDT)
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Mon, 3 Apr
 2023 21:28:28 +0300
Received: from localhost (10.0.253.157) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 3 Apr 2023
 21:28:28 +0300
From:   Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To:     Alex Deucher <alexander.deucher@amd.com>
CC:     Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] radeon: avoid double free in ci_dpm_init()
Date:   Mon, 3 Apr 2023 11:28:08 -0700
Message-ID: <20230403182808.8699-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.253.157]
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several calls to ci_dpm_fini() in ci_dpm_init() when there
occur errors in functions like r600_parse_extended_power_table().
This is harmful as it can lead to double free situations: for
instance, r600_parse_extended_power_table() will call for
r600_free_extended_power_table() as will ci_dpm_fini(), both
of which will try to free resources.
Other drivers do not call *_dpm_fini functions from their
respective *_dpm_init calls - neither should cpm_dpm_init().

Fix this by removing extra calls to ci_dpm_fini().

Found by Linux Verification Center (linuxtesting.org) with static
analysis tool SVACE.

Fixes: cc8dbbb4f62a ("drm/radeon: add dpm support for CI dGPUs (v2)")
Cc: stable@vger.kernel.org
Co-developed-by: Natalia Petrova <n.petrova@fintech.ru>
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>

---
 drivers/gpu/drm/radeon/ci_dpm.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/radeon/ci_dpm.c b/drivers/gpu/drm/radeon/ci_dpm.c
index 8ef25ab305ae..7b77d4c93f1d 100644
--- a/drivers/gpu/drm/radeon/ci_dpm.c
+++ b/drivers/gpu/drm/radeon/ci_dpm.c
@@ -5677,28 +5677,20 @@ int ci_dpm_init(struct radeon_device *rdev)
 	pi->pcie_lane_powersaving.min = 16;
 
 	ret = ci_get_vbios_boot_values(rdev, &pi->vbios_boot_state);
-	if (ret) {
-		ci_dpm_fini(rdev);
+	if (ret)
 		return ret;
-	}
 
 	ret = r600_get_platform_caps(rdev);
-	if (ret) {
-		ci_dpm_fini(rdev);
+	if (ret)
 		return ret;
-	}
 
 	ret = r600_parse_extended_power_table(rdev);
-	if (ret) {
-		ci_dpm_fini(rdev);
+	if (ret)
 		return ret;
-	}
 
 	ret = ci_parse_power_table(rdev);
-	if (ret) {
-		ci_dpm_fini(rdev);
+	if (ret)
 		return ret;
-	}
 
 	pi->dll_default_on = false;
 	pi->sram_end = SMC_RAM_END;
@@ -5749,10 +5741,8 @@ int ci_dpm_init(struct radeon_device *rdev)
 		kcalloc(4,
 			sizeof(struct radeon_clock_voltage_dependency_entry),
 			GFP_KERNEL);
-	if (!rdev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries) {
-		ci_dpm_fini(rdev);
+	if (!rdev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries)
 		return -ENOMEM;
-	}
 	rdev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.count = 4;
 	rdev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries[0].clk = 0;
 	rdev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries[0].v = 0;

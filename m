Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745CB70FB42
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 18:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbjEXQCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 12:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238445AbjEXQBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 12:01:20 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEF11BC
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 09:00:49 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d293746e0so1202747b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 09:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684944049; x=1687536049;
        h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GviRYCsAJgxSrmumt4169PkmX4dPudDea6W8dmD723U=;
        b=lpE8Kx4NUAq8Z9W9TSg2HEpcIs0CNnBBuhj82IUGaSXzOQmD8n80CkywNebvpNMc2X
         Rb14/wmXm8zd56O4v2Vpiylv0VDtEjGKp1h0xy3yZ4YDh1XY03wJ0hRwNdk2bbIHvkVU
         ilVFM9rgJLJUCYR5E2DP2uocNo9+Z06v6QO9GLosZ4VpJdANLy+3IQvuDznyB1I4Q5kC
         MYFy5SF31lAo5bapTh48hpL2Slka9NC+Y5keFv1AxN4YRu8IPlR3bj8eDT1Nz9CqJzl2
         fJdrjkU/QoDg2Y45LflQuzEn+z2W2GpkwKnmDkv6fbzmoIA/zI9YPofRLLgwrG7NZAkv
         v/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684944049; x=1687536049;
        h=cc:to:subject:date:from:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GviRYCsAJgxSrmumt4169PkmX4dPudDea6W8dmD723U=;
        b=PgBd98hMyD3+T47od4HCF/cow4zy3EFk36miNqWOk0SFca8reCej3VOBYwxdLvS+g0
         ifpt2qL7lYeSjpQaXF7EiMTaoDgpjC+xUlBhGkSPeHsY4Baxt+VlpS6X3/WIceFDMGFM
         F5j6xKZwZoFHr7fnxJdm0GVdzlY//B0N+A9quYsilWq5EZ/nnpxC9FBVhpyWb+/9pu6b
         RVM5g2plXLzWH+yCI+D+4X7/vjjhZni6ET99pkgt5FJagm1i1GwB+f02lciyPykuZNdM
         uwL9SPQ3j/ab1XPWVHXjfmoHf2ITbaBI/YsNcSrFwXPF0vWIHePrZR8djg1HMtJMx2XL
         nGcw==
X-Gm-Message-State: AC+VfDyNxAZLANd7qbgxtLGMTrQpGNV1GXcZ3WEFMie2fMqiST/BlP2D
        FJ4NNK6ARgxY/8A6BcW2zRY=
X-Google-Smtp-Source: ACHHUZ4lnR4XYjBOhX7mkfdZdj/PZKimmis7fXlEE+5xO78yRUFwYIOCqistwMyKGJKtcO/B7YuAgA==
X-Received: by 2002:a05:6a00:2da8:b0:64f:5406:d59e with SMTP id fb40-20020a056a002da800b0064f5406d59emr3587677pfb.17.1684944049083;
        Wed, 24 May 2023 09:00:49 -0700 (PDT)
Received: from localhost ([123.56.124.140])
        by smtp.gmail.com with ESMTPSA id j4-20020aa79284000000b0064d1349dc31sm7531651pfa.199.2023.05.24.09.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 09:00:48 -0700 (PDT)
Message-ID: <646e34b0.a70a0220.b7bdd.d5a7@mx.google.com>
From:   ghostfly233 <ghostfly23333@gmail.com>
Date:   Wed, 24 May 2023 23:02:15 +0800
Subject: [PATCH v2] drm/amdgpu: Enable VM_CONTEXT1_CNTL after page table addr
 is set.
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com
Cc:     amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        airlied@gmail.com, daniel@ffwll.ch, ghostfly23333@gmail.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In setup_vmid_config functions of all mmhubs, the CONTEXT1_CNTL reg is
enabled before related CONTEXT1_PAGE_TABLE_START_ADDR and
CONTEXT1_PAGE_TABLE_END_ADDR regs are written, which may cause
undefined behavior.

This patch enable CONTEXT1_CNTL after page table addresses are set,
so that it can ensure no undefined behavior will happen.

Signed-off-by: Zibin Liu <ghostfly23333@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c   | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c   | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c   | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c   | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c   | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c    | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c    | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c    | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c    | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c    | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c    | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c  | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c  | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c    | 7 ++++++-
 15 files changed, 62 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index ab2325f6c7ac..8ff4f70c97a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -261,7 +261,7 @@ static void gfxhub_v1_0_setup_vmid_config(struct amdgpu_device *adev)
 
 	for (i = 0; i <= 14; i++) {
 		tmp = RREG32_SOC15_OFFSET(GC, 0, mmVM_CONTEXT1_CNTL, i);
-		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
 		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    num_level);
 		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
@@ -302,6 +302,9 @@ static void gfxhub_v1_0_setup_vmid_config(struct amdgpu_device *adev)
 		WREG32_SOC15_OFFSET(GC, 0, mmVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
+		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		WREG32_SOC15_OFFSET(GC, 0, mmVM_CONTEXT1_CNTL,
+				    i * hub->ctx_distance, tmp);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
index c59c6c85fbff..1c501066926b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -266,7 +266,7 @@ static void gfxhub_v1_2_setup_vmid_config(struct amdgpu_device *adev)
 
 	for (i = 0; i <= 14; i++) {
 		tmp = RREG32_SOC15_OFFSET(GC, 0, regVM_CONTEXT1_CNTL, i);
-		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
 		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    num_level);
 		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
@@ -311,6 +311,9 @@ static void gfxhub_v1_2_setup_vmid_config(struct amdgpu_device *adev)
 				    regVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
+		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		WREG32_SOC15_OFFSET(GC, 0, regVM_CONTEXT1_CNTL,
+				    i * hub->ctx_distance, tmp);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
index 9b3a02527318..ef660f3bca7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
@@ -288,7 +288,7 @@ static void gfxhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
 
 	for (i = 0; i <= 14; i++) {
 		tmp = RREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL, i);
-		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    adev->vm_manager.num_level);
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
@@ -324,6 +324,9 @@ static void gfxhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
 		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
+		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL,
+				    i * hub->ctx_distance, tmp);
 	}
 
 	hub->vm_cntx_cntl = tmp;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
index 4aacbbec31e2..791afc8e9e85 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
@@ -297,7 +297,7 @@ static void gfxhub_v2_1_setup_vmid_config(struct amdgpu_device *adev)
 
 	for (i = 0; i <= 14; i++) {
 		tmp = RREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL, i);
-		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    adev->vm_manager.num_level);
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
@@ -333,6 +333,9 @@ static void gfxhub_v2_1_setup_vmid_config(struct amdgpu_device *adev)
 		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
+		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL,
+				    i * hub->ctx_distance, tmp);
 	}
 
 	hub->vm_cntx_cntl = tmp;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
index 13712640fa46..75d000884d4a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
@@ -296,7 +296,7 @@ static void gfxhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
 
 	for (i = 0; i <= 14; i++) {
 		tmp = RREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_CNTL, i);
-		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    adev->vm_manager.num_level);
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
@@ -332,6 +332,9 @@ static void gfxhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
 		WREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
+		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		WREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_CNTL,
+				    i * hub->ctx_distance, tmp);
 	}
 
 	hub->vm_cntx_cntl = tmp;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
index 6e0bd628c889..31d73e0b5fc9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
@@ -301,7 +301,7 @@ static void gfxhub_v3_0_3_setup_vmid_config(struct amdgpu_device *adev)
 
 	for (i = 0; i <= 14; i++) {
 		tmp = RREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_CNTL, i);
-		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    adev->vm_manager.num_level);
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
@@ -337,6 +337,9 @@ static void gfxhub_v3_0_3_setup_vmid_config(struct amdgpu_device *adev)
 		WREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
+		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		WREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_CNTL,
+				    i * hub->ctx_distance, tmp);
 	}
 
 	hub->vm_cntx_cntl = tmp;
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
index 15e7cbeae75b..8f18d1480104 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -243,7 +243,7 @@ static void mmhub_v1_0_setup_vmid_config(struct amdgpu_device *adev)
 
 	for (i = 0; i <= 14; i++) {
 		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, mmVM_CONTEXT1_CNTL, i);
-		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
 		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    num_level);
 		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
@@ -280,6 +280,9 @@ static void mmhub_v1_0_setup_vmid_config(struct amdgpu_device *adev)
 		WREG32_SOC15_OFFSET(MMHUB, 0, mmVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
+		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		WREG32_SOC15_OFFSET(MMHUB, 0, mmVM_CONTEXT1_CNTL,
+				    i * hub->ctx_distance, tmp);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
index 73afbf2facc9..25ef04683f36 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -275,7 +275,7 @@ static void mmhub_v1_7_setup_vmid_config(struct amdgpu_device *adev)
 
 	for (i = 0; i <= 14; i++) {
 		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_CNTL, i);
-		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
 		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    num_level);
 		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
@@ -314,6 +314,9 @@ static void mmhub_v1_7_setup_vmid_config(struct amdgpu_device *adev)
 		WREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
+		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		WREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_CNTL,
+				    i * hub->ctx_distance, tmp);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index 342d1702104c..36ed09b60a08 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -267,7 +267,7 @@ static void mmhub_v1_8_setup_vmid_config(struct amdgpu_device *adev)
 
 	for (i = 0; i <= 14; i++) {
 		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_CNTL, i);
-		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
 		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    num_level);
 		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
@@ -306,6 +306,9 @@ static void mmhub_v1_8_setup_vmid_config(struct amdgpu_device *adev)
 		WREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
+		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		WREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_CNTL,
+				    i * hub->ctx_distance, tmp);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index 278e32db878d..272eb35c36e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -368,7 +368,7 @@ static void mmhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
 
 	for (i = 0; i <= 14; i++) {
 		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_CNTL, i);
-		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    adev->vm_manager.num_level);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
@@ -405,6 +405,9 @@ static void mmhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
 		WREG32_SOC15_OFFSET_RLC(MMHUB, 0, mmMMVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
+		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		WREG32_SOC15_OFFSET_RLC(MMHUB, 0, mmMMVM_CONTEXT1_CNTL,
+				    i * hub->ctx_distance, tmp);
 	}
 
 	hub->vm_cntx_cntl = tmp;
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
index fcf2813e70db..e1ec0c8aafed 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
@@ -286,7 +286,7 @@ static void mmhub_v2_3_setup_vmid_config(struct amdgpu_device *adev)
 
 	for (i = 0; i <= 14; i++) {
 		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_CNTL, i);
-		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    adev->vm_manager.num_level);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
@@ -323,6 +323,9 @@ static void mmhub_v2_3_setup_vmid_config(struct amdgpu_device *adev)
 		WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
+		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_CNTL,
+				    i * hub->ctx_distance, tmp);
 	}
 
 	hub->vm_cntx_cntl = tmp;
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
index 17a792616979..b883b6b8d50d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
@@ -325,7 +325,7 @@ static void mmhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
 
 	for (i = 0; i <= 14; i++) {
 		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL, i);
-		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    adev->vm_manager.num_level);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
@@ -362,6 +362,9 @@ static void mmhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
 		WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
+		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL,
+				    i * hub->ctx_distance, tmp);
 	}
 
 	hub->vm_cntx_cntl = tmp;
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
index 26509b6b8c24..c34815a14802 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
@@ -312,7 +312,7 @@ static void mmhub_v3_0_1_setup_vmid_config(struct amdgpu_device *adev)
 
 	for (i = 0; i <= 14; i++) {
 		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL, i);
-		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    adev->vm_manager.num_level);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
@@ -349,6 +349,9 @@ static void mmhub_v3_0_1_setup_vmid_config(struct amdgpu_device *adev)
 		WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
+		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL,
+				    i * hub->ctx_distance, tmp);
 	}
 
 	hub->vm_cntx_cntl = tmp;
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
index 26abbc6a47ab..ce3b2f1d9f8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
@@ -317,7 +317,7 @@ static void mmhub_v3_0_2_setup_vmid_config(struct amdgpu_device *adev)
 
 	for (i = 0; i <= 14; i++) {
 		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL, i);
-		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    adev->vm_manager.num_level);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
@@ -354,6 +354,9 @@ static void mmhub_v3_0_2_setup_vmid_config(struct amdgpu_device *adev)
 		WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
+		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL,
+				    i * hub->ctx_distance, tmp);
 	}
 
 	hub->vm_cntx_cntl = tmp;
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
index 72083e96222f..80e29291e6e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
@@ -310,7 +310,7 @@ static void mmhub_v9_4_setup_vmid_config(struct amdgpu_device *adev, int hubid)
 		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, mmVML2VC0_VM_CONTEXT1_CNTL,
 				hubid * MMHUB_INSTANCE_REGISTER_OFFSET + i);
 		tmp = REG_SET_FIELD(tmp, VML2VC0_VM_CONTEXT1_CNTL,
-				    ENABLE_CONTEXT, 1);
+				    ENABLE_CONTEXT, 0);
 		tmp = REG_SET_FIELD(tmp, VML2VC0_VM_CONTEXT1_CNTL,
 				    PAGE_TABLE_DEPTH,
 				    num_level);
@@ -357,6 +357,11 @@ static void mmhub_v9_4_setup_vmid_config(struct amdgpu_device *adev, int hubid)
 				hubid * MMHUB_INSTANCE_REGISTER_OFFSET +
 				i * hub->ctx_addr_distance,
 				upper_32_bits(adev->vm_manager.max_pfn - 1));
+		tmp = REG_SET_FIELD(tmp, VML2VC0_VM_CONTEXT1_CNTL,
+				    ENABLE_CONTEXT, 1);
+		WREG32_SOC15_OFFSET(MMHUB, 0, mmVML2VC0_VM_CONTEXT1_CNTL,
+				    hubid * MMHUB_INSTANCE_REGISTER_OFFSET +
+				    i * hub->ctx_distance, tmp);
 	}
 }
 
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1D071F632
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 00:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjFAWo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 18:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjFAWo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 18:44:26 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CB012C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 15:44:25 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5344d45bfb0so48660a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 15:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685659465; x=1688251465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UxHkwiqKdxLfYQYbwK7RXIfy2i2RSaxPzUwPry0EypI=;
        b=DhuuK1awpWZ+E3TBfFc1XXnS0izUJlS5HCoilkUp8uhyNdrIUsUNnSi5PXFLKLyOQ5
         PBw9sJYYI/79wtGUvklbPmJZdVJai3uH8yxxL7+A4lkSyycuGhXBpnCwUUkt1Gx5vvfn
         EVBzg27fkC5VvfPgzFWqOitlwLyTeuN5YHWqt4eGo2hMIT4kNGnGaeY/hYoj5FKkmUfc
         bXJzmlaBlJ2gpj48botGTNd3HcC9BkPNjYfZPHr6w1+Bd5Wd75YRiWGxlx03+VBtSyj9
         TVYhi5kFi+XO49sR/CmfgTk9QhIMbJovpaBWCJnT8drBA/UTpCSIUxxKt03epkaqIwKK
         oBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685659465; x=1688251465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UxHkwiqKdxLfYQYbwK7RXIfy2i2RSaxPzUwPry0EypI=;
        b=c/ezc7oE6BRnMh3w0Uu3dlAfa9M7+8KLUCMBWTmBrCycdWYSxuVZQxvCAUOlYdg/n1
         QmEE6tl/1GvN5Fh514dABIMx1TrN3Ecv/Cg7Z5jF/7UfPvVQnUTanG4Izdm+a+alyB58
         /+BKwQxwAs8o9E+JneJmYAVvVA097woThremZf+uc2P+rB5PiV6O0IDAF6K9X4BbH6hU
         GN0vwwsM5fKDvOvh5bua5A2UYvAiMxHW60zX4xBIWk1lDVIl3E3/phy5sxYTypLurEqH
         RgyGzYIbA3fHocoeJsy9wRqtmLoRyfzEzGfypTPVEhCIdRnnYlCs0iInWVT18uB5sbXm
         NTPQ==
X-Gm-Message-State: AC+VfDw6OZ62DRecqnOa2fjEeDBFRotmh1UcNtWOcoD5hsWxqdbW3Uh+
        UXPEAUxL3vD72UFvEUd406pWuac8o8D3hA==
X-Google-Smtp-Source: ACHHUZ4rd6kVpQK8pfQmSVfOt8wBFkHWquxBu5ssRKjUzszOFtIfV6X/57VGphUe48U8aNQg5aEIuw==
X-Received: by 2002:a17:902:e852:b0:1b0:3cda:6351 with SMTP id t18-20020a170902e85200b001b03cda6351mr10628056plg.0.1685659464812;
        Thu, 01 Jun 2023 15:44:24 -0700 (PDT)
Received: from olv-ct-22.c.googlers.com.com (217.108.125.34.bc.googleusercontent.com. [34.125.108.217])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c24600b001ac84f5559csm4024979plg.126.2023.06.01.15.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 15:44:24 -0700 (PDT)
From:   Chia-I Wu <olvaffe@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Philip Yang <Philip.Yang@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Mukul Joshi <mukul.joshi@amd.com>,
        Danijel Slivka <danijel.slivka@amd.com>,
        Lang Yu <Lang.Yu@amd.com>,
        =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <marek.olsak@amd.com>,
        Jammy Zhou <Jammy.Zhou@amd.com>, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] amdgpu: validate offset_in_bo of drm_amdgpu_gem_va
Date:   Thu,  1 Jun 2023 15:44:12 -0700
Message-ID: <20230601224419.2392422-1-olvaffe@gmail.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
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

This is motivated by OOB access in amdgpu_vm_update_range when
offset_in_bo+map_size overflows.

v2: keep the validations in amdgpu_vm_bo_map
v3: add the validations to amdgpu_vm_bo_map/amdgpu_vm_bo_replace_map
    rather than to amdgpu_gem_va_ioctl

Fixes: 9f7eb5367d00 ("drm/amdgpu: actually use the VM map parameters")
Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 22f9a65ca0fc7..76d57bc7ac620 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1434,14 +1434,14 @@ int amdgpu_vm_bo_map(struct amdgpu_device *adev,
 	uint64_t eaddr;
 
 	/* validate the parameters */
-	if (saddr & ~PAGE_MASK || offset & ~PAGE_MASK ||
-	    size == 0 || size & ~PAGE_MASK)
+	if (saddr & ~PAGE_MASK || offset & ~PAGE_MASK || size & ~PAGE_MASK)
+		return -EINVAL;
+	if (saddr + size <= saddr || offset + size <= offset)
 		return -EINVAL;
 
 	/* make sure object fit at this offset */
 	eaddr = saddr + size - 1;
-	if (saddr >= eaddr ||
-	    (bo && offset + size > amdgpu_bo_size(bo)) ||
+	if ((bo && offset + size > amdgpu_bo_size(bo)) ||
 	    (eaddr >= adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT))
 		return -EINVAL;
 
@@ -1500,14 +1500,14 @@ int amdgpu_vm_bo_replace_map(struct amdgpu_device *adev,
 	int r;
 
 	/* validate the parameters */
-	if (saddr & ~PAGE_MASK || offset & ~PAGE_MASK ||
-	    size == 0 || size & ~PAGE_MASK)
+	if (saddr & ~PAGE_MASK || offset & ~PAGE_MASK || size & ~PAGE_MASK)
+		return -EINVAL;
+	if (saddr + size <= saddr || offset + size <= offset)
 		return -EINVAL;
 
 	/* make sure object fit at this offset */
 	eaddr = saddr + size - 1;
-	if (saddr >= eaddr ||
-	    (bo && offset + size > amdgpu_bo_size(bo)) ||
+	if ((bo && offset + size > amdgpu_bo_size(bo)) ||
 	    (eaddr >= adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT))
 		return -EINVAL;
 
-- 
2.41.0.rc0.172.g3f132b7071-goog


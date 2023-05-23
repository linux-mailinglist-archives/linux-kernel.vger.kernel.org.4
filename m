Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B91370E94E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 00:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238626AbjEWWxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 18:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238619AbjEWWxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 18:53:51 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B84FC5
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 15:53:48 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-64f48625615so72640b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 15:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684882428; x=1687474428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dzyaEdd/JqPFdlbr4P5lD8SJNFEFOGGYtrKk5EhfcwE=;
        b=cJ9/TcBhxIj9lFFCTweyLaXwUwkDLt4FKgqqFc6IOluWlbYQkLefOCulf0oAMe6LnY
         nIE/jFemSdWsEOihT8TAkYFRcDAA5Z0vjIW0OrZ/lL/YUraMlprdLjoyVFDyxUHA3VmJ
         zFiMFbIOQoiHxy1zrNa5npE/6/2z0vAAHZ5TY4D1qEKrJwOTXswOhZMaOiPDgWOmamG2
         9iZHbcjLwWPtb/2/XR9otOys1/M3+rBhO/wGSpl6mFFY2h7eo5aHJk1hNdh8eOW2j67D
         5uxpKnicGNoLOGqgC32O0oYVBs+Kzn7EeT1Np51YR/liWQKN2nQDUoYD+iUQ42OIFZTT
         /DLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684882428; x=1687474428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dzyaEdd/JqPFdlbr4P5lD8SJNFEFOGGYtrKk5EhfcwE=;
        b=l1j/0f3gsD5DvuqPosMrQeiDsTLOZTO7EVHqpccUonWxNKhLse9FpKPU/nxkfUsDxx
         Om6C/OqO0g3C41fDZHx7wP1l8apH1d1RrcpYb31E7xLjm11hJHO5ms9/jPGN2qG8P+yS
         67+qUnS2Istz9wtx9PutM+Qoq0MEhgO+z02lQrRkUrPXajDudEfAJ01Do3UMYQNsXAgp
         W2JxfLS7GPr0bu8EwIkAQDnooD0V62E0kynJvBorZTayM8lI+5l4C1IdvRQ1x1rxxhF0
         QC4uY6a7jis0temXyxpcKFr2kmzIxHqTqpnNWYOvGAf4pb/Qav3mS3PQuwF7Q1LLLHO9
         vetg==
X-Gm-Message-State: AC+VfDxxV59BptQDanIGeMj8NhMbnk6C0E7iLHHPQGKLwOtpu8OXdqcn
        CLqBMlo2qOguPqwqdDawdHo=
X-Google-Smtp-Source: ACHHUZ728+Nnl4PPO5tB1/wctSVh7SxxOLII12WRy5EBIrkEoseUDiTO3WoKmZyv4E/fCCAY5BBz1Q==
X-Received: by 2002:a05:6a20:3d95:b0:105:66d3:854d with SMTP id s21-20020a056a203d9500b0010566d3854dmr13269686pzi.6.1684882427464;
        Tue, 23 May 2023 15:53:47 -0700 (PDT)
Received: from olv-ct-22.c.googlers.com.com (217.108.125.34.bc.googleusercontent.com. [34.125.108.217])
        by smtp.gmail.com with ESMTPSA id 23-20020aa79157000000b0064d681c753csm1670525pfi.40.2023.05.23.15.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 15:53:47 -0700 (PDT)
From:   Chia-I Wu <olvaffe@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <marek.olsak@amd.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Philip Yang <Philip.Yang@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Mukul Joshi <mukul.joshi@amd.com>,
        Danijel Slivka <danijel.slivka@amd.com>,
        Jammy Zhou <Jammy.Zhou@amd.com>, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] amdgpu: validate drm_amdgpu_gem_va addrs
Date:   Tue, 23 May 2023 15:53:23 -0700
Message-ID: <20230523225336.2642008-1-olvaffe@gmail.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
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

Validate drm_amdgpu_gem_va addrs in amdgpu_gem_va_ioctl.
amdgpu_vm_bo_replace_map no longer needs to validate (and its
validations were insufficient either).  amdgpu_vm_bo_map has internal
users and its validations are kept.

This is motivated by OOB access in amdgpu_vm_update_range when
offset_in_bo+map_size overflows.

Userspace (radeonsi and radv) seems fine as well.

v2: keep the validations in amdgpu_vm_bo_map

Fixes: 9f7eb5367d00 ("drm/amdgpu: actually use the VM map parameters")
Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 15 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  |  8 +-------
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index d8e683688daab..36d5adfdf0f69 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -681,6 +681,21 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 	uint64_t vm_size;
 	int r = 0;
 
+	if (args->va_address & ~PAGE_MASK || args->offset_in_bo & ~PAGE_MASK ||
+	    args->map_size & ~PAGE_MASK) {
+		dev_dbg(dev->dev, "unaligned va_address 0x%LX, offset_in_bo 0x%LX, or map_size 0x%LX\n",
+			args->va_address, args->offset_in_bo, args->map_size);
+		return -EINVAL;
+	}
+
+	if (args->map_size == 0 ||
+	    args->va_address + args->map_size < args->va_address ||
+	    args->offset_in_bo + args->map_size < args->offset_in_bo) {
+		dev_dbg(dev->dev, "invalid map_size 0x%LX (va_address 0x%LX, offset_in_bo 0x%LX)\n",
+			args->map_size, args->va_address, args->offset_in_bo);
+		return -EINVAL;
+	}
+
 	if (args->va_address < AMDGPU_VA_RESERVED_SIZE) {
 		dev_dbg(dev->dev,
 			"va_address 0x%LX is in reserved area 0x%LX\n",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index b9441ab457ea7..6307baaa136cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1501,15 +1501,9 @@ int amdgpu_vm_bo_replace_map(struct amdgpu_device *adev,
 	uint64_t eaddr;
 	int r;
 
-	/* validate the parameters */
-	if (saddr & ~PAGE_MASK || offset & ~PAGE_MASK ||
-	    size == 0 || size & ~PAGE_MASK)
-		return -EINVAL;
-
 	/* make sure object fit at this offset */
 	eaddr = saddr + size - 1;
-	if (saddr >= eaddr ||
-	    (bo && offset + size > amdgpu_bo_size(bo)) ||
+	if ((bo && offset + size > amdgpu_bo_size(bo)) ||
 	    (eaddr >= adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT))
 		return -EINVAL;
 
-- 
2.40.1.698.g37aff9b760-goog


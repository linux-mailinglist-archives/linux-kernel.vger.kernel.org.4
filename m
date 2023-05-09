Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE976FCDD9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 20:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234247AbjEISdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 14:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjEISdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 14:33:43 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AEF5267
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 11:33:37 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1ab125a198dso10324245ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 11:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683657217; x=1686249217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7PfYPe4eLOcjabfDmHF25blL1VDKiKWkJ3EDvbFzf8=;
        b=B/aWq7HklqbnWmlo64FVOeoYFJtFZ3BNUuXlz+ZVxu1CjCkLYMhynntTwXaI0gCLdl
         2Tn5bVpp8/9bephUVUbBOBsSPCJIv0t8XY+KbKV8WX31yuI0ba/0fBj76A2ZgAmmZrgw
         fH1wh3Go9WMx48hs3Icf3difmsKwtw12aWnhid5glDlphnt1K/zDzLs2OM3w2jcrxrmD
         Bz9jlb8w8WgZvMEnUbx0cVK07ybIs3VAeTLQwJdA8BomX6yV90HuQcVGGn4iP3iLa356
         wVLuN3/+ohXnxXLjh1sVL8bJNuhYRLxUWANusMdjX5eCaXS27u74mV9YY44+l+mC8A9X
         34jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683657217; x=1686249217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i7PfYPe4eLOcjabfDmHF25blL1VDKiKWkJ3EDvbFzf8=;
        b=VAgezjkXr3MU69GvD/z/epFJMy510zyo0tQdlRv8i/2N9H5R2ONVhfRGAIPGUC59Kv
         PEfBnWukAvqbyCFHAKVhlmBys7T+hUP+djaWdD7zt6ACbi86tTECFpzeKxzOvFtV/CLX
         u8nMzIRdErcMumna/+Q9uXlTadrlf1eenv+sqyuM9utWRegA0O6aG85m0XWoGagToIzk
         SdFkFRUyrhXaRqXzJfYZGpgr/K8SEtC4v4cihwPN3aRALoy6V5mPd+4YAkRLQgCSKgFS
         GL2n+2/doj1RPJFGqB+0wJqIX6Z0guHUwhzXcrQqSbC20mzvsGujveHt7QSQD+PnDd+g
         feNQ==
X-Gm-Message-State: AC+VfDwHIhMOZ9OXzJhmV9MFO83+q/LxUoXLO8inOV91q0t5kvDPJSKm
        MUKDf00Uct3ovVtfV23aNws=
X-Google-Smtp-Source: ACHHUZ4ZMRUTtN6PGcyLIB307BJIMOx28+ffbqDtxYzDR9taPLU25CQwNbMZuwM0pgv+yb72EPBnmQ==
X-Received: by 2002:a17:902:e74f:b0:19e:94ff:6780 with SMTP id p15-20020a170902e74f00b0019e94ff6780mr18970863plf.6.1683657216944;
        Tue, 09 May 2023 11:33:36 -0700 (PDT)
Received: from olv-ct-22.c.googlers.com.com (217.108.125.34.bc.googleusercontent.com. [34.125.108.217])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902e9cd00b001ab0669d84csm1948277plk.26.2023.05.09.11.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 11:33:36 -0700 (PDT)
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
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Philip Yang <Philip.Yang@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Danijel Slivka <danijel.slivka@amd.com>,
        Mukul Joshi <mukul.joshi@amd.com>,
        Jammy Zhou <Jammy.Zhou@amd.com>, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] amdgpu: validate drm_amdgpu_gem_va against overflows
Date:   Tue,  9 May 2023 11:32:55 -0700
Message-ID: <20230509183301.1745462-2-olvaffe@gmail.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
In-Reply-To: <20230509183301.1745462-1-olvaffe@gmail.com>
References: <20230509183301.1745462-1-olvaffe@gmail.com>
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

The existing validations are incorrect and insufficient.  This is
motivated by OOB access in amdgpu_vm_update_range when
offset_in_bo+map_size overflows.

Fixes: 9f7eb5367d00 ("drm/amdgpu: actually use the VM map parameters")
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 7 +++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 6 ++----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 071f6565cf971..36d5adfdf0f69 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -688,8 +688,11 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 		return -EINVAL;
 	}
 
-	if (args->map_size == 0) {
-		dev_dbg(dev->dev, "invalid map_size 0x%LX\n", args->map_size);
+	if (args->map_size == 0 ||
+	    args->va_address + args->map_size < args->va_address ||
+	    args->offset_in_bo + args->map_size < args->offset_in_bo) {
+		dev_dbg(dev->dev, "invalid map_size 0x%LX (va_address 0x%LX, offset_in_bo 0x%LX)\n",
+			args->map_size, args->va_address, args->offset_in_bo);
 		return -EINVAL;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index fa5819d581655..cd0a0f06e11ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1437,8 +1437,7 @@ int amdgpu_vm_bo_map(struct amdgpu_device *adev,
 
 	/* make sure object fit at this offset */
 	eaddr = saddr + size - 1;
-	if (saddr >= eaddr ||
-	    (bo && offset + size > amdgpu_bo_size(bo)) ||
+	if ((bo && offset + size > amdgpu_bo_size(bo)) ||
 	    (eaddr >= adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT))
 		return -EINVAL;
 
@@ -1498,8 +1497,7 @@ int amdgpu_vm_bo_replace_map(struct amdgpu_device *adev,
 
 	/* make sure object fit at this offset */
 	eaddr = saddr + size - 1;
-	if (saddr >= eaddr ||
-	    (bo && offset + size > amdgpu_bo_size(bo)) ||
+	if ((bo && offset + size > amdgpu_bo_size(bo)) ||
 	    (eaddr >= adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT))
 		return -EINVAL;
 
-- 
2.40.1.521.gf1e218fcd8-goog


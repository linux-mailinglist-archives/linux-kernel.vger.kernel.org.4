Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B6968A13D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 19:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbjBCSKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 13:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbjBCSKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 13:10:06 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3704B772
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 10:10:05 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id bx22so2897158pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 10:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r5+HyZZkLn8+n5fuCOVi9nu571nQyiN1Ygrcau8PLEk=;
        b=a1MkaNEeAtcvEJ9895D61d43lQFcjsudn433Wiie0xMo9FkD3s7FAxClEzLtxy2jOq
         Z3ZcTliDKgaBsSPJhkCdoOfGjSFBXkFipLWtC4n95a5TjJ+jTDwPAUVV2MEVPH/woDDI
         RYtl7ARCWsvfu5iKCiJHitQkpC8cAaD5ThdfO2OmIm8ln20d7im0M+q8dG3cpd/2cRFR
         2VXlDmheoSH5mR6xtbebkXHFnSxoahFh8cQFlVIDV+KPfbMGQVyxGxqVD2qqfmpOpPb0
         YUOg4r/7ANRP1gv4dxky8VRx5ZCKtjpbLoAQvDzDN70sAuHdFp/NTOe7pOodQZHPzhV1
         zA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r5+HyZZkLn8+n5fuCOVi9nu571nQyiN1Ygrcau8PLEk=;
        b=6HD7Q+VUccpGGe6ghamhu/RYSpYCKzY/moo0uViXGVysQX6ZOu9oW8OpRiXPlpMhMY
         +UpVHRYB2s2OBXitvkRakX/LAtw7uaqbe1PqE/ZcLTF9Nq4Kj5+8Y1dH+f10wsuyeGkW
         xZvcPPo+E7jwSKz78DGZxBVCExpchVNIQ6sLzDo9SJoVLFphYsDePBIiRQx9UYbmfBWH
         GJ0cSVB0GkzQPQ9GNeuw5Z0CtN4/hKFMzwh9vJjRXYSHhOV55czvDzq30ZqQiaGITc4h
         nkQ9YO0iB6jaR13izlYK7VUORjLyJRYsNQmALKUKxBgkNa/Ly0kfm4K3cNU03CstKftd
         oq0Q==
X-Gm-Message-State: AO0yUKXSMK4qG24jqIwQi1HOJS6iQaHkWhFoIhM1DE77KEtCLhaPTYiI
        fgwj09MDn2kMxH5fuDg4F3w=
X-Google-Smtp-Source: AK7set9kjKw4bvpRlqxlWp2E23HKmG2lAnWx3morXcsXW2PNBcbS7sHvlkyWfiC9Lmg3tjVjxWhw4A==
X-Received: by 2002:a05:6a20:d38f:b0:bb:b22a:d7ae with SMTP id iq15-20020a056a20d38f00b000bbb22ad7aemr5568838pzb.2.1675447804615;
        Fri, 03 Feb 2023 10:10:04 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id d131-20020a621d89000000b0059393d46228sm2178385pfd.144.2023.02.03.10.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 10:10:03 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Rob Clark <robdclark@chromium.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Philip Yang <Philip.Yang@amd.com>, Qiang Yu <qiang.yu@amd.com>,
        Jammy Zhou <Jammy.Zhou@amd.com>,
        amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/amdgpu: Fix potential race processing vm->freed
Date:   Fri,  3 Feb 2023 10:10:03 -0800
Message-Id: <20230203181005.4129175-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.38.1
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

If userspace calls the AMDGPU_CS ioctl from multiple threads, because
the vm is global to the drm_file, you can end up with multiple threads
racing in amdgpu_vm_clear_freed().  So the freed list should be
protected with the status_lock, similar to other vm lists.

Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 33 ++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index b9441ab457ea..aeed7bc1512f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1240,10 +1240,19 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 	struct amdgpu_bo_va_mapping *mapping;
 	uint64_t init_pte_value = 0;
 	struct dma_fence *f = NULL;
+	struct list_head freed;
 	int r;
 
-	while (!list_empty(&vm->freed)) {
-		mapping = list_first_entry(&vm->freed,
+	/*
+	 * Move the contents of the VM's freed list to a local list
+	 * that we can iterate without racing against other threads:
+	 */
+	spin_lock(&vm->status_lock);
+	list_replace_init(&vm->freed, &freed);
+	spin_unlock(&vm->status_lock);
+
+	while (!list_empty(&freed)) {
+		mapping = list_first_entry(&freed,
 			struct amdgpu_bo_va_mapping, list);
 		list_del(&mapping->list);
 
@@ -1258,6 +1267,15 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 		amdgpu_vm_free_mapping(adev, vm, mapping, f);
 		if (r) {
 			dma_fence_put(f);
+
+			/*
+			 * Move any unprocessed mappings back to the freed
+			 * list:
+			 */
+			spin_lock(&vm->status_lock);
+			list_splice_tail(&freed, &vm->freed);
+			spin_unlock(&vm->status_lock);
+
 			return r;
 		}
 	}
@@ -1583,11 +1601,14 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
 	mapping->bo_va = NULL;
 	trace_amdgpu_vm_bo_unmap(bo_va, mapping);
 
-	if (valid)
+	if (valid) {
+		spin_lock(&vm->status_lock);
 		list_add(&mapping->list, &vm->freed);
-	else
+		spin_unlock(&vm->status_lock);
+	} else {
 		amdgpu_vm_free_mapping(adev, vm, mapping,
 				       bo_va->last_pt_update);
+	}
 
 	return 0;
 }
@@ -1671,7 +1692,9 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
 		    tmp->last = eaddr;
 
 		tmp->bo_va = NULL;
+		spin_lock(&vm->status_lock);
 		list_add(&tmp->list, &vm->freed);
+		spin_unlock(&vm->status_lock);
 		trace_amdgpu_vm_bo_unmap(NULL, tmp);
 	}
 
@@ -1788,7 +1811,9 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
 		amdgpu_vm_it_remove(mapping, &vm->va);
 		mapping->bo_va = NULL;
 		trace_amdgpu_vm_bo_unmap(bo_va, mapping);
+		spin_lock(&vm->status_lock);
 		list_add(&mapping->list, &vm->freed);
+		spin_unlock(&vm->status_lock);
 	}
 	list_for_each_entry_safe(mapping, next, &bo_va->invalids, list) {
 		list_del(&mapping->list);
-- 
2.38.1


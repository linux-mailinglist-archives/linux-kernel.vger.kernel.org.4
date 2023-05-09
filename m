Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6936FCDD7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 20:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbjEISd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 14:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjEISd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 14:33:27 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5612107
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 11:33:25 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-645c4a0079dso569057b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 11:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683657205; x=1686249205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=66XYrn3OxsOriMI735FsztsxhCcCNS7VnQ9CyIcun0k=;
        b=sD2zZgzdekBu3FUs7ZFXAQMXGzFhvP8+sBg6DAO4BZLNDpTCTmYNeGQU+UOojZofXJ
         xqyI9/Y1RjrFijaVMExTnl9BcPCd9enm5IyFR2hefmItlaUL7N2A1TJq3XAdbDK4rqFA
         FssWB9V1vzAKCl31twmjXh6+4OuXkvE6X4zjUTuUbCvOgfTsKWufrA7fMb8xYg551lOp
         C1/hL6gzqedWSlFvzv1KbFpQe9N3ociSmmTzu3Sn88X0/GTTVVTRlfyFF8ozDXL7IN4S
         gqwVCWpyNL7ZFwuIz8lWOgbXqO7RKq0IItC9rQZn1rh2vgcIdkcRfwY3qaG/DaU/vvZT
         S0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683657205; x=1686249205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=66XYrn3OxsOriMI735FsztsxhCcCNS7VnQ9CyIcun0k=;
        b=Q/wTYcWe6ZwBYUr7DfjsPcTPdxw1hOJhGHrXiQPSnPUrmE2+qlx4SsEuN5ABzxcQ6p
         dtFZd+WJ7BfsOh+YwgeEfI4HKGYgot/1n9nkIP1IztccDO+p+J4UMZ6sjc8jAR0p03tk
         V8AugKZMaXjNAJm7MtYCn5VBhPGFMDdHJxJgUrlNBJRuKl+c8kkidAHyLMBHOgdnhdve
         YwVc8iDcQO+GKPwLAYqyY6UflUgv6/GaCT4nG9ATNkuea4uny2n8IL+ksweEzp/d/Ksw
         Cspwgu4seRzJ/Z4O7Si68RwPGasyIn9bNBS8b0GppKAFRzTb3vMo++fQgOj9GhI5ocFQ
         Pmbw==
X-Gm-Message-State: AC+VfDwF5puDuiw8LtktffD1t4C6dmeV6k61U8jyHH2aBYNVkpuNdsEK
        tSkqKFWEi4cA60QMb46LoGI=
X-Google-Smtp-Source: ACHHUZ4rEOCYnDYqNb/IIjjLkiAa8OHVI4MvSoSXzD0ClVpDs5JvDmkrE1YCeIWLD/OeZ7J4npNQ8g==
X-Received: by 2002:a17:903:41ca:b0:1a4:f4e6:b68 with SMTP id u10-20020a17090341ca00b001a4f4e60b68mr19020579ple.3.1683657205076;
        Tue, 09 May 2023 11:33:25 -0700 (PDT)
Received: from olv-ct-22.c.googlers.com.com (217.108.125.34.bc.googleusercontent.com. [34.125.108.217])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902e9cd00b001ab0669d84csm1948277plk.26.2023.05.09.11.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 11:33:24 -0700 (PDT)
From:   Chia-I Wu <olvaffe@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <marek.olsak@amd.com>,
        Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Philip Yang <Philip.Yang@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Danijel Slivka <danijel.slivka@amd.com>,
        Mukul Joshi <mukul.joshi@amd.com>,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] amdgpu: validate drm_amdgpu_gem_va addrs for all ops
Date:   Tue,  9 May 2023 11:32:54 -0700
Message-ID: <20230509183301.1745462-1-olvaffe@gmail.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
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

Extend the address and size validations to AMDGPU_VA_OP_UNMAP and
AMDGPU_VA_OP_CLEAR by moving the validations to amdgpu_gem_va_ioctl.

Internal users of amdgpu_vm_bo_map are no longer validated but they
should be fine.

Userspace (radeonsi and radv) seems fine as well.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 12 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 10 ----------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index d8e683688daab..071f6565cf971 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -681,6 +681,18 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 	uint64_t vm_size;
 	int r = 0;
 
+	if (args->va_address & ~PAGE_MASK || args->offset_in_bo & ~PAGE_MASK ||
+	    args->map_size & ~PAGE_MASK) {
+		dev_dbg(dev->dev, "unaligned va_address 0x%LX, offset_in_bo 0x%LX, or map_size 0x%LX\n",
+			args->va_address, args->offset_in_bo, args->map_size);
+		return -EINVAL;
+	}
+
+	if (args->map_size == 0) {
+		dev_dbg(dev->dev, "invalid map_size 0x%LX\n", args->map_size);
+		return -EINVAL;
+	}
+
 	if (args->va_address < AMDGPU_VA_RESERVED_SIZE) {
 		dev_dbg(dev->dev,
 			"va_address 0x%LX is in reserved area 0x%LX\n",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index b9441ab457ea7..fa5819d581655 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1435,11 +1435,6 @@ int amdgpu_vm_bo_map(struct amdgpu_device *adev,
 	struct amdgpu_vm *vm = bo_va->base.vm;
 	uint64_t eaddr;
 
-	/* validate the parameters */
-	if (saddr & ~PAGE_MASK || offset & ~PAGE_MASK ||
-	    size == 0 || size & ~PAGE_MASK)
-		return -EINVAL;
-
 	/* make sure object fit at this offset */
 	eaddr = saddr + size - 1;
 	if (saddr >= eaddr ||
@@ -1501,11 +1496,6 @@ int amdgpu_vm_bo_replace_map(struct amdgpu_device *adev,
 	uint64_t eaddr;
 	int r;
 
-	/* validate the parameters */
-	if (saddr & ~PAGE_MASK || offset & ~PAGE_MASK ||
-	    size == 0 || size & ~PAGE_MASK)
-		return -EINVAL;
-
 	/* make sure object fit at this offset */
 	eaddr = saddr + size - 1;
 	if (saddr >= eaddr ||
-- 
2.40.1.521.gf1e218fcd8-goog


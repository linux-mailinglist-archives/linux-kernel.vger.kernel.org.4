Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65E670FA0B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 17:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbjEXPZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 11:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbjEXPZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 11:25:14 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F8012B
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:25:13 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64d293746e0so1156232b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684941913; x=1687533913;
        h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=clsLU15GLcIOQSvBcrogvQDw08garrGLWVkzeYz/uDY=;
        b=E+/BC4CAkdnIoLdlv8nl03nfngRBjJKkXSLe7oynmVh8HPexKV+2BCd2QaCVos7wbC
         12O6t0wOZJgY0UF//E14cimf4E5OqwVxwCfN5f8ZR1NyXQ6z8PWz1kbuHDKWa10BjGjm
         /6aZd9a88LF6JitKfy7iNBY8sxPGyLxB3sZp1WTwl/vuaq0JdZNXcmGMzDIbdjCNl027
         Ef3EP4s7hxI3iAEi+urjJHVhpEuhSjwQP5OSYp5KUQ3W26HUSeIXnyRAoAkMHMYyUJqz
         X/TWTtvQVgb3HJPK700F+GJkA2akvz9hp/jMdmPPGosDgQPrTY7TrRmwxdZ/Cw3lYUiv
         p63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684941913; x=1687533913;
        h=cc:to:subject:date:from:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=clsLU15GLcIOQSvBcrogvQDw08garrGLWVkzeYz/uDY=;
        b=XnfBaLJqkuWG+XEanQpS9+Eu2gN1tKZribkXWj85eJq74YOQcMUDuERvCkcBsRVcW6
         4iaD34QmlBMOy1lhOfTGCugZkseBFREjraUmzPpCFZ+Y8ENColoTwBiGrXDbNoR6Ghx4
         lK7Zi+jmzxKomhX7+zrFtt/LM0BVXKQFkTNINhJILt+qZaSGiaBfinCYp1sel7FZj0cc
         L6cYZnRfUgnyL7zJV2ATuow4elysOByqdSFtMjbscStp+9/W+U7WFUucdDtKZU7gmINd
         K+HnlpCtIyPVlU32Nw8alU/nN+80lKRxNd1/K5IVLYhFeK2NY3b5LZAmzv4Ea7GotgdW
         PTFg==
X-Gm-Message-State: AC+VfDw7N8t5Mce9tJ6JOkcrqo9A+86UNICTfzrYqtwpQjFZadCCFxo9
        kUX8O+Y6rCE9qYvZS8lYQm9aI8yWJwhuxefT
X-Google-Smtp-Source: ACHHUZ47CIz21wZp5Ttvdc1bRln55OtCgtRpYza6UsIR7M+htz0bEb2QV7vPpW0lvnftuE8t5GSrVQ==
X-Received: by 2002:a05:6a20:6a0b:b0:10b:189e:c1de with SMTP id p11-20020a056a206a0b00b0010b189ec1demr13884707pzk.10.1684941912945;
        Wed, 24 May 2023 08:25:12 -0700 (PDT)
Received: from localhost ([123.56.124.140])
        by smtp.gmail.com with ESMTPSA id 17-20020a17090a19d100b0024bcad691d4sm1580623pjj.14.2023.05.24.08.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 08:25:12 -0700 (PDT)
Message-ID: <646e2c58.170a0220.4f979.2ba7@mx.google.com>
From:   ghostfly233 <ghostfly23333@gmail.com>
Date:   Wed, 24 May 2023 23:02:15 +0800
Subject: [PATCH] drm/amdgpu: Enable GCVM_CONTEXT1_CNTL after page table addr
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

In gfxhub_v2_1_setup_vmid_config(), the GCVM_CONTEXT1_CNTL reg is
enabled before related GCVM_CONTEXT1_PAGE_TABLE_START_ADDR and
GCVM_CONTEXT1_PAGE_TABLE_END_ADDR regs are written, which may
cause undefined behavior.

This patch enable GCVM_CONNTEXT1_CNTL after page table addresses are set,
so that it can ensure no undefined behavior will happen.

Signed-off-by: Zibin Liu <ghostfly23333@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

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
-- 
2.34.1


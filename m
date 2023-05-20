Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAFFB70A992
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 20:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjETSAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 14:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjETSAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 14:00:39 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678A9FE
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 11:00:38 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1ae58e4b295so27964695ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 11:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684605638; x=1687197638;
        h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/w9xABIfUj6Dl4/qFa1pCSYIiL8B2Gh1Bv0+XJyaLg=;
        b=N8L1hdpmePzAhgQ+Ob47tLL3IRB6FCvBr4dMK8UEnsLU68O9eBsSuE2TGy/L4NdMse
         U65SMoxO73eAC1b4bEdEjjbP/2bc7Jh8rYkj8RVVA7o+FBboO4xeGFtSDCI/zgZv3YfH
         Hy7w6tUr3Z3efFxaoWi/tubjqPhO4hv/6uObSjPuFtOlnirpLc6rtthxmpruvOHG/oiS
         dEWDvUc28sEMf5eT/Wb3XniNldGaYAMEfZlt6qPsH/4kC6Gdgv4NG9bgbzrD0DVza+4K
         d/cQylSZ41Kdeg+H5lfbp+0IOLZTYn8oCbIrSMlSf9BeHr21ZlghjzPH6PWKBKzcp3iM
         Z6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684605638; x=1687197638;
        h=cc:to:subject:date:from:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/w9xABIfUj6Dl4/qFa1pCSYIiL8B2Gh1Bv0+XJyaLg=;
        b=Q/hwE/DQJ5p0YS+upKEIIIzFxD5b1TiBTA1KKHOCX+K+ZXWQRzjSBYY8JvSCMRMEG3
         ikiNrY6a8K90ZLJPCpAmS3DhdXNHgTFfQRa7bkO1k1mLrfU3gEr84XTAAH95m5uE0LEL
         7Dp4pAmKLRO/xIsBclKAkMQIyXFaHU/m3j6N0sVobiXhTTeHRh192OAltVcqjOJ5CpjA
         em9cS9ZtU2ST2pBazIm2ENPlVQreMFgaLM8WfjHEp6qF7e8DF+QTZKt77v4p6TYXIy6j
         /s2QBufJKRe++xbLLRp8jX0dWhJFmd6LIzGwOIi3K5R62qTRZ1K7/ztZVQKjdWhYueva
         JW9w==
X-Gm-Message-State: AC+VfDxbrkWEZzp2okw4hElZC2y4/ECNu5oz0uJxxhvMCUL3+++8hnL3
        /QOUthywO+6nopYQIHxrkJY=
X-Google-Smtp-Source: ACHHUZ7VX15xvIk9IjlTdopKTebyozL9mjDmdwEDVDwn8YHkJZYF/JOTz2sNj9RspZm/0KavfCxOAQ==
X-Received: by 2002:a17:902:c407:b0:1ac:451d:34b with SMTP id k7-20020a170902c40700b001ac451d034bmr8470317plk.9.1684605637889;
        Sat, 20 May 2023 11:00:37 -0700 (PDT)
Received: from localhost ([123.56.124.140])
        by smtp.gmail.com with ESMTPSA id bj6-20020a170902850600b001a183ade911sm1800688plb.56.2023.05.20.11.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 11:00:37 -0700 (PDT)
Message-ID: <64690ac5.170a0220.92bb3.2e7a@mx.google.com>
From:   ghostfly233 <ghostfly23333@gmail.com>
Date:   Sat, 20 May 2023 19:59:40 +0800
Subject: [PATCH] drm/amdgpu: Rearrange WREG32 operations in gfxhub_v2_1.c
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com
Cc:     amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        airlied@gmail.com, daniel@ffwll.ch, ghostfly23333@gmail.com
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In gfxhub_v2_1_setup_vmid_config(), the GCVM_CONTEXT1_CNTL reg is
written before related GCVM_CONTEXT1_PAGE_TABLE_START_ADDR and
GCVM_CONTEXT1_PAGE_TABLE_END_ADDR regs are written, which may
cause undefined behavior.

This patch rearranges WREG32 operations in gfxhub_v2_1_setup_vmid_config(),
so that it can ensure the addresses are initialized before CNTL is enabled
and reduce the risk of encountering undefined behavior.

Signed-off-by: Zibin Liu <ghostfly23333@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
index 4aacbbec31e2..6d094e7315eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
@@ -321,8 +321,6 @@ static void gfxhub_v2_1_setup_vmid_config(struct amdgpu_device *adev)
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
 				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
 				    !adev->gmc.noretry);
-		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL,
-				    i * hub->ctx_distance, tmp);
 		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
 				    i * hub->ctx_addr_distance, 0);
 		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_START_ADDR_HI32,
@@ -333,6 +331,8 @@ static void gfxhub_v2_1_setup_vmid_config(struct amdgpu_device *adev)
 		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
+		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL,
+				    i * hub->ctx_distance, tmp);
 	}
 
 	hub->vm_cntx_cntl = tmp;
-- 
2.34.1


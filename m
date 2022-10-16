Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC0D60027F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 19:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiJPRmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 13:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiJPRmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 13:42:06 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D3531FAD
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:42:05 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bv10so15102673wrb.4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eBoyZFJd/AMWfSTDdNDFLh542tiq7KT1lMhtwEfLBl4=;
        b=cyxXVAEqs04ujc9hmfAVf30HVL/pCnILfipPspTFlkQBjzFFQhNOx+3Hsnzv8IBT5Q
         mKEvizN9ZqA35pVXIw+GnMESFPCSiwgqiFLfLgeFQnvtyFNuAjpc5GCL4mrlNm6layTT
         tfKBWW0JurCzaM0BbS5VuSKwloE83tjuPMpK4CwXtoV1MMeTgVT1ms7B1Pvn5ROcOGB2
         SkafGbGxB2jHqrTZaiTeYenHuoz4h7csoYTfWJxsVMuLmwu3efBD4YWun6Q0xYkebQe2
         ZGrPENmNa2okAP3iFZNF+4OO8IfxofZNsEwgG4ir3pkbao1kcw9L0KinBv55MTRKeKK+
         /hUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eBoyZFJd/AMWfSTDdNDFLh542tiq7KT1lMhtwEfLBl4=;
        b=uGbQvETC+WMsE+d+t/Pm/zTv694fmzEx44BJ49hAIrsEubHdZ7N/AHR2vjesOsE5Uq
         kCSM6dNOaRdlc9R4YmclO4j/IDd11YtaKaTldoEl4VWGEVezEskJqyCQKnLeSb9PyNDF
         6X1KcEFXmiOZ7sdbgXvnF0duGEAuPRrpmRRp+gi402wMROLNAMPiJm0jwn2r/LfkUdWQ
         CdCbZ4NsBO87Omypt+NYXnLiVnU78c+jfQzzsyU4CZuzmFzLfGZpTYGF/KMS1s/ZrmeL
         XsIJ09e9SfG0Rwag1qLmKToQ214eK2nrVQYnGCSmhbp4zcbdqITYWw7uwHSV5+vm8pC2
         91Uw==
X-Gm-Message-State: ACrzQf0y36uDeLc60x+mjaQ+CSiu0SR4gEzeQPlDCM+j7pcuA+eIXcHF
        v05YFe01v18YdrZVPErmQek=
X-Google-Smtp-Source: AMsMyM6FtrFrf3Ic4dkdXt5cwMkRyUmfIFJPYxWdF1OUS04XhPgPbujAr60TrkylIRaojiJMB3TjZw==
X-Received: by 2002:a05:6000:1689:b0:22e:2c03:36e7 with SMTP id y9-20020a056000168900b0022e2c0336e7mr4464896wrd.252.1665942124233;
        Sun, 16 Oct 2022 10:42:04 -0700 (PDT)
Received: from localhost.localdomain (host-95-250-231-122.retail.telecomitalia.it. [95.250.231.122])
        by smtp.gmail.com with ESMTPSA id p14-20020a05600c468e00b003c6f3e5ba42sm2820940wmo.46.2022.10.16.10.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 10:42:03 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [RESEND PATCH] drm/amd/amdgpu: Replace kmap() with kmap_local_page()
Date:   Sun, 16 Oct 2022 19:41:58 +0200
Message-Id: <20221016174158.16638-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

kmap() is being deprecated in favor of kmap_local_page().

There are two main problems with kmap(): (1) It comes with an overhead as
mapping space is restricted and protected by a global lock for
synchronization and (2) it also requires global TLB invalidation when the
kmap’s pool wraps and it might block when the mapping space is fully
utilized until a slot becomes available.

With kmap_local_page() the mappings are per thread, CPU local, can take
page faults, and can be called from any context (including interrupts).
It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
the tasks can be preempted and, when they are scheduled to run again, the
kernel virtual addresses are restored and are still valid.

Since its use in amdgpu/amdgpu_ttm.c is safe, it should be preferred.

Therefore, replace kmap() with kmap_local_page() in amdgpu/amdgpu_ttm.c.

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

I'm resending because I suspect that this patch might have been lost. In
the meantime I added an "Acked-by" tag from Christian K.. Obviviously,
there are no further changes in the code.

 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 3b4c19412625..c11657b5915f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2301,9 +2301,9 @@ static ssize_t amdgpu_iomem_read(struct file *f, char __user *buf,
 		if (p->mapping != adev->mman.bdev.dev_mapping)
 			return -EPERM;
 
-		ptr = kmap(p);
+		ptr = kmap_local_page(p);
 		r = copy_to_user(buf, ptr + off, bytes);
-		kunmap(p);
+		kunmap_local(ptr);
 		if (r)
 			return -EFAULT;
 
@@ -2352,9 +2352,9 @@ static ssize_t amdgpu_iomem_write(struct file *f, const char __user *buf,
 		if (p->mapping != adev->mman.bdev.dev_mapping)
 			return -EPERM;
 
-		ptr = kmap(p);
+		ptr = kmap_local_page(p);
 		r = copy_from_user(ptr + off, buf, bytes);
-		kunmap(p);
+		kunmap_local(ptr);
 		if (r)
 			return -EFAULT;
 
-- 
2.37.1


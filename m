Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0378360206F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 03:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiJRB2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 21:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiJRB2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 21:28:05 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBAE85586
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 18:28:02 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id j188so14094182oih.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 18:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ilkmjMRXsx5bN+cKLCPs5nKC2+ATqDeP4QnxRLsugMY=;
        b=ZzjlLZ4Wx4yqm5zbY/vF/fUjc8wYRue8JEToCLc7+q9CnNI4Ar2AkEJTT4HLh5dNmO
         CWnN6eKNOFibZWC0diT/gstz/2zarzciwMhRp1t1ewMlVYYA1EpWBBaK01JnhJ9hYzSA
         DBD3wzUx4+rIC98poEzR8BQTscvrSybtaxL27f+XOPEPryo6RevogBRh3nNt7EuFoIas
         LYeIAgLijpKEH8j0wyQgsIeHe3X6y5/aFVcGYA7Pm8uy8OJ15VEG/t6VeSgEAYmySHm1
         b9y35LIzAitN3379gakovwvJTyNILG1MwYgD05ZSKxdVZGfjOVk0oLznGWMJkKt3sptN
         J1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ilkmjMRXsx5bN+cKLCPs5nKC2+ATqDeP4QnxRLsugMY=;
        b=KlLVfxQAhR+vo+HjOpkO7nF2OsTXqVwfgmEZR+8wRL5076K4MA92BXCFxhemrCIKn2
         WcxTBhvMIiCieDLg4y6mKLDYe0Ub8Kkr1jRv9xhAk3gwPV/AWTzLLKk8N5wBHWnDm+f+
         by1U+XU52GaSp7BBEg7dxch5m7Wg1r+YRns4crWT7q2khj5pD4O1G8PM1GGxg93jGoem
         fB/VDrgU7UwkpHVySOr9QvfwW31/zTwSLDsPKrMODJiyRNXV/01yyakUX5Iig+BU+SUg
         BwwR1uQCyQzbWq3R5jFsP60axPD2pvAr9Gt4DEntnHwSBRJ0/2poBTvZe8doXCcjb0ip
         54vA==
X-Gm-Message-State: ACrzQf1tiXVQxvO4c+T9ellCUJFihgZLpPjgK7yW+C89EKOqmz18AQTd
        mWoVVvVNm9Oqi0YK8OS0WjU=
X-Google-Smtp-Source: AMsMyM41az2Sl9WsDrici9XR23w8mdjfxyfa/Rp7Rod/2DwGKLBHzGwsPH3B5yuRtEt5m1Wlqxd6ag==
X-Received: by 2002:a05:6808:11cb:b0:353:f841:e390 with SMTP id p11-20020a05680811cb00b00353f841e390mr318449oiv.149.1666056481769;
        Mon, 17 Oct 2022 18:28:01 -0700 (PDT)
Received: from macondo.. ([2804:431:e7cc:1855:b6d2:d55:b2d8:b57d])
        by smtp.gmail.com with ESMTPSA id cj7-20020a056830640700b006619533d1ddsm5329572otb.76.2022.10.17.18.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 18:28:01 -0700 (PDT)
From:   Rafael Mendonca <rafaelmendsr@gmail.com>
To:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ramesh Errabolu <Ramesh.Errabolu@amd.com>,
        Oak Zeng <Oak.Zeng@amd.com>
Cc:     Rafael Mendonca <rafaelmendsr@gmail.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdkfd: Fix memory leak in kfd_mem_dmamap_userptr()
Date:   Mon, 17 Oct 2022 22:27:50 -0300
Message-Id: <20221018012751.887460-1-rafaelmendsr@gmail.com>
X-Mailer: git-send-email 2.34.1
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

If the number of pages from the userptr BO differs from the SG BO then the
allocated memory for the SG table doesn't get freed before returning
-EINVAL, which may lead to a memory leak in some error paths. Fix this by
checking the number of pages before allocating memory for the SG table.

Fixes: 264fb4d332f5 ("drm/amdgpu: Add multi-GPU DMA mapping helpers")
Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 978d3970b5cc..84f44f7e4111 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -510,13 +510,13 @@ kfd_mem_dmamap_userptr(struct kgd_mem *mem,
 	struct ttm_tt *ttm = bo->tbo.ttm;
 	int ret;
 
+	if (WARN_ON(ttm->num_pages != src_ttm->num_pages))
+		return -EINVAL;
+
 	ttm->sg = kmalloc(sizeof(*ttm->sg), GFP_KERNEL);
 	if (unlikely(!ttm->sg))
 		return -ENOMEM;
 
-	if (WARN_ON(ttm->num_pages != src_ttm->num_pages))
-		return -EINVAL;
-
 	/* Same sequence as in amdgpu_ttm_tt_pin_userptr */
 	ret = sg_alloc_table_from_pages(ttm->sg, src_ttm->pages,
 					ttm->num_pages, 0,
-- 
2.34.1


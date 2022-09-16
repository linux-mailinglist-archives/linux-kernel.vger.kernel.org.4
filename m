Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAFF5BB080
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 17:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiIPPqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 11:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiIPPq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 11:46:26 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C430EB02BC
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 08:46:25 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id c24so163786plo.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 08:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=G2HnexRcqtcbOBLQqu2d6rHkLU0457VcAac9EnkFuRg=;
        b=M6rOlqdPkmjiZfbtH4Gd3UfdvQxEoOOzexAHRinwE0agzpX/+31EOl53gQpONkQJFH
         x7jlkmB8Ju/ZKykxHn2AlgBAWt4vDwEY4tQyFwyf7QDYxA0fYkOhIj635hfiu98COud6
         63OM19tktlympYJuOgw4x+1h/bOhFlBLrsuGaF8D0rY6n1FlvYjhEpf2qTPaT7ibG12R
         3toPY4CHO9xsw8F00OrviyYEZ5lFF7DtJ16vV/lgFSKRZvdEQ0rf4BNxKZXea5vtL9lg
         SHt+MvscnWEcbguxdVrXdwCtaNSECnSs/+aeqmZzoZIPS/LJeqnNUuQCtYUi0dG7xhVq
         j1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=G2HnexRcqtcbOBLQqu2d6rHkLU0457VcAac9EnkFuRg=;
        b=w7sbTQDkbG7Lmnw/xxnvTr/VltADleyXyr3dXJmu11yQgZ0WhUb4GKY0Ob6ZAQkpoK
         p/+IlbxG/d49wEozd+AmWtcIaqsR+trohpB6vxUzZWf6/0ih+k8hrVyd7RtRCFhkkLhO
         HSD3adulM6GVXtCbJxIRNqduIJ1vaYvpcEYigCVSHaIulhUlZEmOFxGwPYroq0p/zWoX
         D1PbixDH4cLuzt99hqytyeO4IWqFORPlihohMkTnlhL9uZOYbYlU8XmuNqttfNYF5jYA
         rVY0SGqgMvED1O4cWMovpO35yK1/m53kwNf3T1zBR2/4xsLylcGhsEAj+aLeGndKL9F4
         Zfcg==
X-Gm-Message-State: ACrzQf3Vx5Un2j73Cg6ux+Mj92WOJrYDWuzPPynnsTh4nxlOgRKAJSVr
        rxrrS8zPoF9cWBOFlkPPh1/AHmpK36UGaw==
X-Google-Smtp-Source: AMsMyM74WBhD3XUDAHvFj//42Gz2/RsZagmBAM3VJg/YiTr8YOUTcYGdSFEE0oFwZtVxS1iY4yrBIw==
X-Received: by 2002:a17:903:120e:b0:178:8650:274 with SMTP id l14-20020a170903120e00b0017886500274mr446319plh.55.1663343185296;
        Fri, 16 Sep 2022 08:46:25 -0700 (PDT)
Received: from localhost.localdomain ([137.220.236.138])
        by smtp.gmail.com with ESMTPSA id p17-20020aa79e91000000b0053639773ad8sm14724489pfq.119.2022.09.16.08.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 08:46:24 -0700 (PDT)
From:   "brookxu.cn" <brookxu.cn@gmail.com>
To:     robin.murphy@arm.com, joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/iova: using separate rcache for SAC and DAC
Date:   Fri, 16 Sep 2022 23:46:13 +0800
Message-Id: <20220916154613.104965-1-brookxu.cn@gmail.com>
X-Mailer: git-send-email 2.31.1
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

From: Chunguang Xu <chunguang.xu@shopee.com>

While iommu_dma_forcedac disable, for PCI device kernel
try SAC first, if failed then try DAC. Since now rcache
does not distinguish SAC and DAC, if all PFNs contained
in cpu loaded cache is larger than SAC max PFN, but the
SAC address space is sufficient, as cpu loaded cached is
not empty, kernel will iova_alloc () to alloc IOVA. For
PCI device, kernel alloc SAC most, loaded cache may
invalid for SAC alloc for a long time, kernel will enter
alloc_iova() slow path frequencely, as result performance
is degrade. To circumvent this problem, SAC and DAC maybe
better to use separate caches.

Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>
---
 drivers/iommu/iova.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 47d1983dfa2a..d5775719a143 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -16,6 +16,7 @@
 #define IOVA_ANCHOR	~0UL
 
 #define IOVA_RANGE_CACHE_MAX_SIZE 6	/* log of max cached IOVA range size (in pages) */
+#define IOVA_RANGE_CACHE_ARRAY_SIZE (2 * IOVA_RANGE_CACHE_MAX_SIZE)
 
 static bool iova_rcache_insert(struct iova_domain *iovad,
 			       unsigned long pfn,
@@ -723,13 +724,13 @@ int iova_domain_init_rcaches(struct iova_domain *iovad)
 	unsigned int cpu;
 	int i, ret;
 
-	iovad->rcaches = kcalloc(IOVA_RANGE_CACHE_MAX_SIZE,
+	iovad->rcaches = kcalloc(IOVA_RANGE_CACHE_ARRAY_SIZE,
 				 sizeof(struct iova_rcache),
 				 GFP_KERNEL);
 	if (!iovad->rcaches)
 		return -ENOMEM;
 
-	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
+	for (i = 0; i < IOVA_RANGE_CACHE_ARRAY_SIZE; ++i) {
 		struct iova_cpu_rcache *cpu_rcache;
 		struct iova_rcache *rcache;
 
@@ -825,11 +826,15 @@ static bool iova_rcache_insert(struct iova_domain *iovad, unsigned long pfn,
 			       unsigned long size)
 {
 	unsigned int log_size = order_base_2(size);
+	unsigned int index;
 
 	if (log_size >= IOVA_RANGE_CACHE_MAX_SIZE)
 		return false;
 
-	return __iova_rcache_insert(iovad, &iovad->rcaches[log_size], pfn);
+	if (pfn > DMA_BIT_MASK(32))
+		index = log_size + IOVA_RANGE_CACHE_MAX_SIZE;
+
+	return __iova_rcache_insert(iovad, &iovad->rcaches[index], pfn);
 }
 
 /*
@@ -881,11 +886,20 @@ static unsigned long iova_rcache_get(struct iova_domain *iovad,
 				     unsigned long limit_pfn)
 {
 	unsigned int log_size = order_base_2(size);
+	unsigned long iova_pfn;
+	unsigned int index;
 
 	if (log_size >= IOVA_RANGE_CACHE_MAX_SIZE || !iovad->rcaches)
 		return 0;
 
-	return __iova_rcache_get(&iovad->rcaches[log_size], limit_pfn - size);
+	iova_pfn = __iova_rcache_get(&iovad->rcaches[log_size], limit_pfn - size);
+
+	if (!iova_pfn && limit_pfn > DMA_BIT_MASK(32)) {
+		index = log_size + IOVA_RANGE_CACHE_MAX_SIZE;
+		iova_pfn = __iova_rcache_get(&iovad->rcaches[index], limit_pfn - size);
+	}
+
+	return iova_pfn
 }
 
 /*
@@ -898,7 +912,7 @@ static void free_iova_rcaches(struct iova_domain *iovad)
 	unsigned int cpu;
 	int i, j;
 
-	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
+	for (i = 0; i < IOVA_RANGE_CACHE_ARRAY_SIZE; ++i) {
 		rcache = &iovad->rcaches[i];
 		if (!rcache->cpu_rcaches)
 			break;
@@ -926,7 +940,7 @@ static void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad)
 	unsigned long flags;
 	int i;
 
-	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
+	for (i = 0; i < IOVA_RANGE_CACHE_ARRAY_SIZE; ++i) {
 		rcache = &iovad->rcaches[i];
 		cpu_rcache = per_cpu_ptr(rcache->cpu_rcaches, cpu);
 		spin_lock_irqsave(&cpu_rcache->lock, flags);
@@ -945,7 +959,7 @@ static void free_global_cached_iovas(struct iova_domain *iovad)
 	unsigned long flags;
 	int i, j;
 
-	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
+	for (i = 0; i < IOVA_RANGE_CACHE_ARRAY_SIZE; ++i) {
 		rcache = &iovad->rcaches[i];
 		spin_lock_irqsave(&rcache->lock, flags);
 		for (j = 0; j < rcache->depot_size; ++j) {
-- 
2.31.1


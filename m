Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E118653AAC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 03:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbiLVCgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 21:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235046AbiLVCfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 21:35:39 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B6D26AC6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 18:35:16 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id pa16-20020a17090b265000b0020a71040b4cso300727pjb.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 18:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b9yKHiaQzq9mZ3IJWGzrPWbD3+83EkY9xWMVBG05dNQ=;
        b=XlyER0aXwnjO8q6dTDihNfSIfjWn8dSVJ8IiBcSHE7yuANREvStJV3g9XDl8A/5Vwr
         OaNHoUYM9Z3wM78fZ/XqZqc2ZUebk2Up0L9xXgXL4U3gFGGz6w6NBfJtgfGPwYUC+B8s
         lG8Y2mimnBPeTLnpwg2Gmem25P6HBJfKl/2T+uaujz8TJVx2GozbpVFZB4OD+HpbyDdX
         FHdfVOyX6+BPp8Ht/TdNLUscgGNFc8b5S04IVXGZFWLXt3JasjvhdrpNTDIHgFTTxdhl
         C2eu1PX9i9Z3SW518upry6mS+ShsSl8pxZNEoSPq4X6DQp773Xn1V/u5SNKVXrbP8X0c
         vtUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b9yKHiaQzq9mZ3IJWGzrPWbD3+83EkY9xWMVBG05dNQ=;
        b=x9xuSQJNwgHBxcU5HYm2Dy5FNIj96/5HorcahakgG3P9Ku2yRVrqXRMBE5cFuwD7tN
         vvBnWRbdpWOjoyCXYwl/wWpdAKR3loYWE0L8OydOrCl3gZw7rvdxANftHOU4tm/s3CM/
         xfWqYJmpBBJ9q2PlABo4NZElzgzYHzOC4sXMVxapHDQSVR1T2Sr2D6sEgR4o/TM6ivtX
         mxGwfA4Rt3tWhmcFJ7uvNd0Nbg3ZdIu1OOJii0o/H6++Z3B+4Dh5/HUTllFjCa0So4R5
         2JjHzGjMR0CyT3cApAjCOdPOrBx5jLo6vIN2ItEf8xNAxREP/GzQOD77PrPXSFz7N4Yq
         xfFQ==
X-Gm-Message-State: AFqh2kqjAGj+Z8tqtrPg/0TeX8sz8HZxGk4Jl6PmRUF7G/wTr7EePQ95
        6vQwNnF30BcwPCYhB1cg+WOhxEvCn6XP
X-Google-Smtp-Source: AMrXdXuzNj9EuXh7z055yKJ7hUYnL0IVln/7MJaAb+bM/jJJ7BibhMJSEr7enuNFlr9FF9cWepYFeciD79VX
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a17:90b:701:b0:219:1d0a:34a6 with SMTP id
 s1-20020a17090b070100b002191d0a34a6mr128835pjz.1.1671676515179; Wed, 21 Dec
 2022 18:35:15 -0800 (PST)
Date:   Wed, 21 Dec 2022 18:34:57 -0800
In-Reply-To: <20221222023457.1764-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20221222023457.1764-1-vipinsh@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221222023457.1764-10-vipinsh@google.com>
Subject: [Patch v3 9/9] KVM: x86/mmu: Reduce default cache size in KVM from 40
 to PT64_ROOT_MAX_LEVEL
From:   Vipin Sharma <vipinsh@google.com>
To:     seanjc@google.com, pbonzini@redhat.com, bgardon@google.com,
        dmatlack@google.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE is set to 40 without any specific
reason. Reduce default size to PT64_ROOT_MAX_LEVEL, which is currently
5.

Change mmu_pte_list_desc_cache size to what is needed as it is more than
5 but way less than 40.

Tested by running dirty_log_perf_test on both tdp and shadow MMU with 48
vcpu and 2GB/vcpu size on a 2 NUMA node machine. No impact on
performance noticed.

Ran perf on dirty_log_perf_test and found kvm_mmu_get_free_page() calls
reduced by ~3300 which is near to 48 (vcpus) * 2 (nodes) * 35 (cache
size).

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 arch/x86/include/asm/kvm_types.h | 2 +-
 arch/x86/kvm/mmu/mmu.c           | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/kvm_types.h b/arch/x86/include/asm/kvm_types.h
index 08f1b57d3b62..752dab218a62 100644
--- a/arch/x86/include/asm/kvm_types.h
+++ b/arch/x86/include/asm/kvm_types.h
@@ -2,6 +2,6 @@
 #ifndef _ASM_X86_KVM_TYPES_H
 #define _ASM_X86_KVM_TYPES_H
 
-#define KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE 40
+#define KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE PT64_ROOT_MAX_LEVEL
 
 #endif /* _ASM_X86_KVM_TYPES_H */
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 7454bfc49a51..f89d933ff380 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -677,11 +677,12 @@ static int mmu_topup_sp_memory_cache(struct kvm_mmu_memory_cache *cache,
 
 static int mmu_topup_memory_caches(struct kvm_vcpu *vcpu, bool maybe_indirect)
 {
-	int r, nid;
+	int r, nid, desc_capacity;
 
 	/* 1 rmap, 1 parent PTE per level, and the prefetched rmaps. */
-	r = kvm_mmu_topup_memory_cache(&vcpu->arch.mmu_pte_list_desc_cache,
-				       1 + PT64_ROOT_MAX_LEVEL + PTE_PREFETCH_NUM);
+	desc_capacity = 1 + PT64_ROOT_MAX_LEVEL + PTE_PREFETCH_NUM;
+	r = __kvm_mmu_topup_memory_cache(&vcpu->arch.mmu_pte_list_desc_cache,
+					 desc_capacity, desc_capacity);
 	if (r)
 		return r;
 
-- 
2.39.0.314.g84b9a713c41-goog


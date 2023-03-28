Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4B76CBBA1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbjC1J6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbjC1J6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:58:46 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AC461A9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:58:43 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id kc4so11110273plb.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1679997523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUuhgY917ceHjuJWRr2UIN+zKxCzAXrecq/+Z8gmroA=;
        b=RU+saPvgKQNlmWTq+bdeYrfwyFkXqc8uO9OS/o1Zx1EI0DNYBWRSf0QGSblvehP0sW
         RM+07ZqnzFzu4DjBduQxRxeI/bnGLwWGrG69+xCnQrjxWyHaTi5IbLa4s50piAEl1g8Z
         FlyBovcoVrO8jQLazmCKoXrZOtd8V+0q/bPp446qMiJO2zBeSdxk4Cj7Dpz9gEJmYkFC
         45eHsrxKLK73f5ZeYjUihiNtWuQZSNL7GMdA5wqC0iRWUxlzED66XOPpFiqLt0C/pO7D
         XgLxesijy3b0waONiSKt0aj5vxTHkOjCcUzKulf750LwwtxWInWbOsnCElj5hV/LB0dL
         z6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679997523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hUuhgY917ceHjuJWRr2UIN+zKxCzAXrecq/+Z8gmroA=;
        b=nk8CI6TsRnXQ2yhBVff5JT7d/YjL6QVUaeZpLKmzAKU5Ul2CvudZFRdQC+KxQpPypw
         Bzd5758TMHp5Xr02ZrbxA9SJQiB1Sxh1hCtDythKxjnsrYd6wL2nCU/HMCupHZejmUIL
         pAxl3BHyiKlYBAIMe683+v10gILonJrMEqmAMbM6H36/2GeXaZ6CRQifeSv6mQahEPI6
         0FB7RNp3RbxD2QomZv/eO+IMSl5gzbpIDQWg5j+kaXv8LY3QMCGnfwyBeu99gNxYO3gQ
         k4lSm2Nb1rivgAzCxYIqTfxYWWug/+B13ABuQICi9Rj2bFLz3TMa/t2y3QQAwzYYz6PQ
         IYxA==
X-Gm-Message-State: AO0yUKXCJazAJJBXLRtPjGKndN7gDbfdEEk6oYc6oJp9l045RwoVGIAt
        sDW/ALK5ZQ5/GGsMPKZguuItEg==
X-Google-Smtp-Source: AK7set8K3WCn7qGv5XrCwVU77b7YcNrErbvROMxOijirnK/PKs0Os7YyvQj1wcB+W7SDvFzggqBDvg==
X-Received: by 2002:a05:6a20:c119:b0:d4:77a6:156f with SMTP id bh25-20020a056a20c11900b000d477a6156fmr12759375pzb.53.1679997522898;
        Tue, 28 Mar 2023 02:58:42 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id m26-20020aa78a1a000000b005a8a5be96b2sm17207556pfa.104.2023.03.28.02.58.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Mar 2023 02:58:42 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     glider@google.com, elver@google.com, dvyukov@google.com,
        akpm@linux-foundation.org, jannh@google.com, sjpark@amazon.de,
        muchun.song@linux.dev
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 3/6] mm: kfence: make kfence_protect_page() void
Date:   Tue, 28 Mar 2023 17:58:04 +0800
Message-Id: <20230328095807.7014-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230328095807.7014-1-songmuchun@bytedance.com>
References: <20230328095807.7014-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arch_kfence_init_pool() make sure kfence pool is mapped with base page
size (e.g. 4KB), so the following PTE lookup in kfence_protect_page() will
always succeed. Then there is no way to stop kfence_protect_page() always
returning true, so make it void to simplify the code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/arm/include/asm/kfence.h     |   4 +-
 arch/arm64/include/asm/kfence.h   |   4 +-
 arch/parisc/include/asm/kfence.h  |   7 +-
 arch/powerpc/include/asm/kfence.h |   8 +--
 arch/riscv/include/asm/kfence.h   |   4 +-
 arch/s390/include/asm/kfence.h    |   3 +-
 arch/x86/include/asm/kfence.h     |   9 +--
 mm/kfence/core.c                  | 142 +++++++++++++++++---------------------
 8 files changed, 73 insertions(+), 108 deletions(-)

diff --git a/arch/arm/include/asm/kfence.h b/arch/arm/include/asm/kfence.h
index 7980d0f2271f..c30a5f8125e8 100644
--- a/arch/arm/include/asm/kfence.h
+++ b/arch/arm/include/asm/kfence.h
@@ -43,11 +43,9 @@ static inline bool arch_kfence_init_pool(void)
 	return true;
 }
 
-static inline bool kfence_protect_page(unsigned long addr, bool protect)
+static inline void kfence_protect_page(unsigned long addr, bool protect)
 {
 	set_memory_valid(addr, 1, !protect);
-
-	return true;
 }
 
 #endif /* __ASM_ARM_KFENCE_H */
diff --git a/arch/arm64/include/asm/kfence.h b/arch/arm64/include/asm/kfence.h
index a81937fae9f6..7717c6d98b6f 100644
--- a/arch/arm64/include/asm/kfence.h
+++ b/arch/arm64/include/asm/kfence.h
@@ -12,11 +12,9 @@
 
 static inline bool arch_kfence_init_pool(void) { return true; }
 
-static inline bool kfence_protect_page(unsigned long addr, bool protect)
+static inline void kfence_protect_page(unsigned long addr, bool protect)
 {
 	set_memory_valid(addr, 1, !protect);
-
-	return true;
 }
 
 #ifdef CONFIG_KFENCE
diff --git a/arch/parisc/include/asm/kfence.h b/arch/parisc/include/asm/kfence.h
index 6259e5ac1fea..290792009315 100644
--- a/arch/parisc/include/asm/kfence.h
+++ b/arch/parisc/include/asm/kfence.h
@@ -19,13 +19,10 @@ static inline bool arch_kfence_init_pool(void)
 }
 
 /* Protect the given page and flush TLB. */
-static inline bool kfence_protect_page(unsigned long addr, bool protect)
+static inline void kfence_protect_page(unsigned long addr, bool protect)
 {
 	pte_t *pte = virt_to_kpte(addr);
 
-	if (WARN_ON(!pte))
-		return false;
-
 	/*
 	 * We need to avoid IPIs, as we may get KFENCE allocations or faults
 	 * with interrupts disabled.
@@ -37,8 +34,6 @@ static inline bool kfence_protect_page(unsigned long addr, bool protect)
 		set_pte(pte, __pte(pte_val(*pte) | _PAGE_PRESENT));
 
 	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
-
-	return true;
 }
 
 #endif /* _ASM_PARISC_KFENCE_H */
diff --git a/arch/powerpc/include/asm/kfence.h b/arch/powerpc/include/asm/kfence.h
index 6fd2b4d486c5..9d8502a7d0a4 100644
--- a/arch/powerpc/include/asm/kfence.h
+++ b/arch/powerpc/include/asm/kfence.h
@@ -21,16 +21,14 @@ static inline bool arch_kfence_init_pool(void)
 }
 
 #ifdef CONFIG_PPC64
-static inline bool kfence_protect_page(unsigned long addr, bool protect)
+static inline void kfence_protect_page(unsigned long addr, bool protect)
 {
 	struct page *page = virt_to_page(addr);
 
 	__kernel_map_pages(page, 1, !protect);
-
-	return true;
 }
 #else
-static inline bool kfence_protect_page(unsigned long addr, bool protect)
+static inline void kfence_protect_page(unsigned long addr, bool protect)
 {
 	pte_t *kpte = virt_to_kpte(addr);
 
@@ -40,8 +38,6 @@ static inline bool kfence_protect_page(unsigned long addr, bool protect)
 	} else {
 		pte_update(&init_mm, addr, kpte, 0, _PAGE_PRESENT, 0);
 	}
-
-	return true;
 }
 #endif
 
diff --git a/arch/riscv/include/asm/kfence.h b/arch/riscv/include/asm/kfence.h
index d887a54042aa..1299f47170b5 100644
--- a/arch/riscv/include/asm/kfence.h
+++ b/arch/riscv/include/asm/kfence.h
@@ -46,7 +46,7 @@ static inline bool arch_kfence_init_pool(void)
 	return true;
 }
 
-static inline bool kfence_protect_page(unsigned long addr, bool protect)
+static inline void kfence_protect_page(unsigned long addr, bool protect)
 {
 	pte_t *pte = virt_to_kpte(addr);
 
@@ -56,8 +56,6 @@ static inline bool kfence_protect_page(unsigned long addr, bool protect)
 		set_pte(pte, __pte(pte_val(*pte) | _PAGE_PRESENT));
 
 	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
-
-	return true;
 }
 
 #endif /* _ASM_RISCV_KFENCE_H */
diff --git a/arch/s390/include/asm/kfence.h b/arch/s390/include/asm/kfence.h
index d55ba878378b..6d7b3632d79c 100644
--- a/arch/s390/include/asm/kfence.h
+++ b/arch/s390/include/asm/kfence.h
@@ -33,10 +33,9 @@ static __always_inline void kfence_split_mapping(void)
 #endif
 }
 
-static inline bool kfence_protect_page(unsigned long addr, bool protect)
+static inline void kfence_protect_page(unsigned long addr, bool protect)
 {
 	__kernel_map_pages(virt_to_page(addr), 1, !protect);
-	return true;
 }
 
 #endif /* _ASM_S390_KFENCE_H */
diff --git a/arch/x86/include/asm/kfence.h b/arch/x86/include/asm/kfence.h
index ff5c7134a37a..6ffd4a078a71 100644
--- a/arch/x86/include/asm/kfence.h
+++ b/arch/x86/include/asm/kfence.h
@@ -38,13 +38,9 @@ static inline bool arch_kfence_init_pool(void)
 }
 
 /* Protect the given page and flush TLB. */
-static inline bool kfence_protect_page(unsigned long addr, bool protect)
+static inline void kfence_protect_page(unsigned long addr, bool protect)
 {
-	unsigned int level;
-	pte_t *pte = lookup_address(addr, &level);
-
-	if (WARN_ON(!pte || level != PG_LEVEL_4K))
-		return false;
+	pte_t *pte = virt_to_kpte(addr);
 
 	/*
 	 * We need to avoid IPIs, as we may get KFENCE allocations or faults
@@ -65,7 +61,6 @@ static inline bool kfence_protect_page(unsigned long addr, bool protect)
 	preempt_disable();
 	flush_tlb_one_kernel(addr);
 	preempt_enable();
-	return true;
 }
 
 #endif /* !MODULE */
diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 6781af1dfa66..5726bf2ae13c 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -229,14 +229,14 @@ static bool alloc_covered_contains(u32 alloc_stack_hash)
 	return true;
 }
 
-static bool kfence_protect(unsigned long addr)
+static inline void kfence_protect(unsigned long addr)
 {
-	return !KFENCE_WARN_ON(!kfence_protect_page(ALIGN_DOWN(addr, PAGE_SIZE), true));
+	kfence_protect_page(ALIGN_DOWN(addr, PAGE_SIZE), true);
 }
 
-static bool kfence_unprotect(unsigned long addr)
+static inline void kfence_unprotect(unsigned long addr)
 {
-	return !KFENCE_WARN_ON(!kfence_protect_page(ALIGN_DOWN(addr, PAGE_SIZE), false));
+	kfence_protect_page(ALIGN_DOWN(addr, PAGE_SIZE), false);
 }
 
 static inline unsigned long metadata_to_pageaddr(const struct kfence_metadata *meta)
@@ -531,30 +531,19 @@ static void rcu_guarded_free(struct rcu_head *h)
 	kfence_guarded_free((void *)meta->addr, meta, false);
 }
 
-/*
- * Initialization of the KFENCE pool after its allocation.
- * Returns 0 on success; otherwise returns the address up to
- * which partial initialization succeeded.
- */
-static unsigned long kfence_init_pool(void)
+static void kfence_init_pool(void)
 {
 	unsigned long addr = (unsigned long)__kfence_pool;
 	int i;
 
-	if (!arch_kfence_init_pool())
-		return addr;
 	/*
 	 * Protect the first 2 pages. The first page is mostly unnecessary, and
 	 * merely serves as an extended guard page. However, adding one
 	 * additional page in the beginning gives us an even number of pages,
 	 * which simplifies the mapping of address to metadata index.
 	 */
-	for (i = 0; i < 2; i++) {
-		if (unlikely(!kfence_protect(addr)))
-			return addr;
-
-		addr += PAGE_SIZE;
-	}
+	for (i = 0; i < 2; i++, addr += PAGE_SIZE)
+		kfence_protect(addr);
 
 	for (i = 0; i < CONFIG_KFENCE_NUM_OBJECTS; i++, addr += 2 * PAGE_SIZE) {
 		struct kfence_metadata *meta = &kfence_metadata[i];
@@ -568,38 +557,33 @@ static unsigned long kfence_init_pool(void)
 		list_add_tail(&meta->list, &kfence_freelist);
 
 		/* Protect the right redzone. */
-		if (unlikely(!kfence_protect(addr + PAGE_SIZE)))
-			return addr;
+		kfence_protect(addr + PAGE_SIZE);
 
 		__folio_set_slab(slab_folio(slab));
 #ifdef CONFIG_MEMCG
 		slab->memcg_data = (unsigned long)&meta->objcg | MEMCG_DATA_OBJCGS;
 #endif
 	}
-
-	return 0;
 }
 
 static bool __init kfence_init_pool_early(void)
 {
-	unsigned long addr;
-
 	if (!__kfence_pool)
 		return false;
 
-	addr = kfence_init_pool();
-
-	if (!addr) {
-		/*
-		 * The pool is live and will never be deallocated from this point on.
-		 * Ignore the pool object from the kmemleak phys object tree, as it would
-		 * otherwise overlap with allocations returned by kfence_alloc(), which
-		 * are registered with kmemleak through the slab post-alloc hook.
-		 */
-		kmemleak_ignore_phys(__pa(__kfence_pool));
-		return true;
-	}
+	if (!arch_kfence_init_pool())
+		goto free;
 
+	kfence_init_pool();
+	/*
+	 * The pool is live and will never be deallocated from this point on.
+	 * Ignore the pool object from the kmemleak phys object tree, as it would
+	 * otherwise overlap with allocations returned by kfence_alloc(), which
+	 * are registered with kmemleak through the slab post-alloc hook.
+	 */
+	kmemleak_ignore_phys(__pa(__kfence_pool));
+	return true;
+free:
 	/*
 	 * Only release unprotected pages, and do not try to go back and change
 	 * page attributes due to risk of failing to do so as well. If changing
@@ -607,27 +591,7 @@ static bool __init kfence_init_pool_early(void)
 	 * fails for the first page, and therefore expect addr==__kfence_pool in
 	 * most failure cases.
 	 */
-	memblock_free_late(__pa(addr), KFENCE_POOL_SIZE - (addr - (unsigned long)__kfence_pool));
-	__kfence_pool = NULL;
-	return false;
-}
-
-static bool kfence_init_pool_late(void)
-{
-	unsigned long addr, free_size;
-
-	addr = kfence_init_pool();
-
-	if (!addr)
-		return true;
-
-	/* Same as above. */
-	free_size = KFENCE_POOL_SIZE - (addr - (unsigned long)__kfence_pool);
-#ifdef CONFIG_CONTIG_ALLOC
-	free_contig_range(page_to_pfn(virt_to_page((void *)addr)), free_size / PAGE_SIZE);
-#else
-	free_pages_exact((void *)addr, free_size);
-#endif
+	memblock_free_late(__pa(__kfence_pool), KFENCE_POOL_SIZE);
 	__kfence_pool = NULL;
 	return false;
 }
@@ -830,30 +794,50 @@ void __init kfence_init(void)
 	kfence_init_enable();
 }
 
-static int kfence_init_late(void)
-{
-	const unsigned long nr_pages = KFENCE_POOL_SIZE / PAGE_SIZE;
 #ifdef CONFIG_CONTIG_ALLOC
-	struct page *pages;
+static inline void *kfence_pool_alloc(void)
+{
+	struct page *page = alloc_contig_pages(KFENCE_POOL_SIZE / PAGE_SIZE,
+					       GFP_KERNEL, first_online_node, NULL);
 
-	pages = alloc_contig_pages(nr_pages, GFP_KERNEL, first_online_node, NULL);
-	if (!pages)
-		return -ENOMEM;
-	__kfence_pool = page_to_virt(pages);
+	return page ? page_to_virt(page) : NULL;
+}
+
+static inline void kfence_pool_free(const void *ptr)
+{
+	free_contig_range(page_to_pfn(virt_to_page(ptr)), KFENCE_POOL_SIZE / PAGE_SIZE);
+}
 #else
+static inline void *kfence_pool_alloc(void)
+{
 	BUILD_BUG_ON_MSG(get_order(KFENCE_POOL_SIZE) > MAX_ORDER,
 			 "CONFIG_KFENCE_NUM_OBJECTS is too large for buddy allocator");
 
-	__kfence_pool = alloc_pages_exact(KFENCE_POOL_SIZE, GFP_KERNEL);
+	return alloc_pages_exact(KFENCE_POOL_SIZE, GFP_KERNEL);
+}
+
+static inline void kfence_pool_free(const void *ptr)
+{
+	free_pages_exact(virt_to_page(ptr), KFENCE_POOL_SIZE);
+}
+#endif
+
+static int kfence_init_late(void)
+{
+	if (__kfence_pool)
+		return 0;
+
+	__kfence_pool = kfence_pool_alloc();
 	if (!__kfence_pool)
 		return -ENOMEM;
-#endif
 
-	if (!kfence_init_pool_late()) {
-		pr_err("%s failed\n", __func__);
+	if (!arch_kfence_init_pool()) {
+		kfence_pool_free(__kfence_pool);
+		__kfence_pool = NULL;
 		return -EBUSY;
 	}
 
+	kfence_init_pool();
 	kfence_init_enable();
 	kfence_debugfs_init();
 
@@ -862,8 +846,8 @@ static int kfence_init_late(void)
 
 static int kfence_enable_late(void)
 {
-	if (!__kfence_pool)
-		return kfence_init_late();
+	if (kfence_init_late())
+		return -ENOMEM;
 
 	WRITE_ONCE(kfence_enabled, true);
 	queue_delayed_work(system_unbound_wq, &kfence_timer, 0);
@@ -1054,8 +1038,9 @@ bool kfence_handle_page_fault(unsigned long addr, bool is_write, struct pt_regs
 	if (!is_kfence_address((void *)addr))
 		return false;
 
-	if (!READ_ONCE(kfence_enabled)) /* If disabled at runtime ... */
-		return kfence_unprotect(addr); /* ... unprotect and proceed. */
+	/* If disabled at runtime ... unprotect and proceed. */
+	if (!READ_ONCE(kfence_enabled))
+		goto out;
 
 	atomic_long_inc(&counters[KFENCE_COUNTER_BUGS]);
 
@@ -1079,7 +1064,7 @@ bool kfence_handle_page_fault(unsigned long addr, bool is_write, struct pt_regs
 		}
 
 		if (!to_report)
-			goto out;
+			goto report;
 
 		raw_spin_lock_irqsave(&to_report->lock, flags);
 		to_report->unprotected_page = addr;
@@ -1093,7 +1078,7 @@ bool kfence_handle_page_fault(unsigned long addr, bool is_write, struct pt_regs
 	} else {
 		to_report = addr_to_metadata(addr);
 		if (!to_report)
-			goto out;
+			goto report;
 
 		raw_spin_lock_irqsave(&to_report->lock, flags);
 		error_type = KFENCE_ERROR_UAF;
@@ -1105,7 +1090,7 @@ bool kfence_handle_page_fault(unsigned long addr, bool is_write, struct pt_regs
 		 */
 	}
 
-out:
+report:
 	if (to_report) {
 		kfence_report_error(addr, is_write, regs, to_report, error_type);
 		raw_spin_unlock_irqrestore(&to_report->lock, flags);
@@ -1113,6 +1098,7 @@ bool kfence_handle_page_fault(unsigned long addr, bool is_write, struct pt_regs
 		/* This may be a UAF or OOB access, but we can't be sure. */
 		kfence_report_error(addr, is_write, regs, NULL, KFENCE_ERROR_INVALID);
 	}
-
-	return kfence_unprotect(addr); /* Unprotect and let access proceed. */
+out:
+	kfence_unprotect(addr);
+	return true;
 }
-- 
2.11.0


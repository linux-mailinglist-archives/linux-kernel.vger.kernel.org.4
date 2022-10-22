Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE36F608CF1
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 13:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiJVLtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 07:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiJVLst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 07:48:49 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317C52505C3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 04:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=kfJUOBrrmjy4JsdmvOUplpu2MGBZGnH8F3TsabZggcA=; b=TZtejNuXM7kl3MOXWKy8aaU/tk
        e118lDcxQsCXKrtcjfNaX3hhzfxtkXwSWz763aZgaWRoymxnOariKlXTCOTFQ1zOXOH9zc1OTUFRv
        8azjLpfaOOQEKL6SRwBny2sFE0p0l69+LTKxpFmQ79VJ+ySU5VFdBl2ClPmUNW6KfJP7IiEb2xjC9
        tsNtJRffbNAX/xOBgv9twdHzjXxpXTWw7dPoKQlb47QCW08TuhULthxwrfwPLHr8YayH5Eek3Idiz
        D6G/kMsRd5f8hFWCtPSwW5VwwMGGMZa4EtEoRiAGDeP8Ppb2+SjV6sDe0sQYqyLmn55ceyQHrM481
        m9ajaoKQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1omCzM-005XdT-Vx; Sat, 22 Oct 2022 11:48:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C85DC3030FD;
        Sat, 22 Oct 2022 13:48:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4299A28B8E512; Sat, 22 Oct 2022 13:48:26 +0200 (CEST)
Message-ID: <20221022114425.168036718@infradead.org>
User-Agent: quilt/0.66
Date:   Sat, 22 Oct 2022 13:14:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, willy@infradead.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        linux-mm@kvack.org, aarcange@redhat.com,
        kirill.shutemov@linux.intel.com, jroedel@suse.de, ubizjak@gmail.com
Subject: [PATCH 11/13] x86_64: Remove pointless set_64bit() usage
References: <20221022111403.531902164@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of set_64bit() in X86_64 only code is pretty pointless, seeing
how it's a direct assignment. Remove all this nonsense.

Additionally, since x86_64 unconditionally has HAVE_CMPXCHG_DOUBLE,
there is no point in even having that fallback.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/um/include/asm/pgtable-3level.h |    8 --------
 arch/x86/include/asm/cmpxchg_64.h    |    5 -----
 drivers/iommu/intel/irq_remapping.c  |   10 ++--------
 3 files changed, 2 insertions(+), 21 deletions(-)

--- a/arch/um/include/asm/pgtable-3level.h
+++ b/arch/um/include/asm/pgtable-3level.h
@@ -58,11 +58,7 @@
 #define pud_populate(mm, pud, pmd) \
 	set_pud(pud, __pud(_PAGE_TABLE + __pa(pmd)))
 
-#ifdef CONFIG_64BIT
-#define set_pud(pudptr, pudval) set_64bit((u64 *) (pudptr), pud_val(pudval))
-#else
 #define set_pud(pudptr, pudval) (*(pudptr) = (pudval))
-#endif
 
 static inline int pgd_newpage(pgd_t pgd)
 {
@@ -71,11 +67,7 @@ static inline int pgd_newpage(pgd_t pgd)
 
 static inline void pgd_mkuptodate(pgd_t pgd) { pgd_val(pgd) &= ~_PAGE_NEWPAGE; }
 
-#ifdef CONFIG_64BIT
-#define set_pmd(pmdptr, pmdval) set_64bit((u64 *) (pmdptr), pmd_val(pmdval))
-#else
 #define set_pmd(pmdptr, pmdval) (*(pmdptr) = (pmdval))
-#endif
 
 static inline void pud_clear (pud_t *pud)
 {
--- a/arch/x86/include/asm/cmpxchg_64.h
+++ b/arch/x86/include/asm/cmpxchg_64.h
@@ -2,11 +2,6 @@
 #ifndef _ASM_X86_CMPXCHG_64_H
 #define _ASM_X86_CMPXCHG_64_H
 
-static inline void set_64bit(volatile u64 *ptr, u64 val)
-{
-	*ptr = val;
-}
-
 #define arch_cmpxchg64(ptr, o, n)					\
 ({									\
 	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -173,7 +173,6 @@ static int modify_irte(struct irq_2_iomm
 	index = irq_iommu->irte_index + irq_iommu->sub_handle;
 	irte = &iommu->ir_table->base[index];
 
-#if defined(CONFIG_HAVE_CMPXCHG_DOUBLE)
 	if ((irte->pst == 1) || (irte_modified->pst == 1)) {
 		bool ret;
 
@@ -187,11 +186,6 @@ static int modify_irte(struct irq_2_iomm
 		 * same as the old value.
 		 */
 		WARN_ON(!ret);
-	} else
-#endif
-	{
-		set_64bit(&irte->low, irte_modified->low);
-		set_64bit(&irte->high, irte_modified->high);
 	}
 	__iommu_flush_cache(iommu, irte, sizeof(*irte));
 
@@ -249,8 +243,8 @@ static int clear_entries(struct irq_2_io
 	end = start + (1 << irq_iommu->irte_mask);
 
 	for (entry = start; entry < end; entry++) {
-		set_64bit(&entry->low, 0);
-		set_64bit(&entry->high, 0);
+		WRITE_ONCE(entry->low, 0);
+		WRITE_ONCE(entry->high, 0);
 	}
 	bitmap_release_region(iommu->ir_table->bitmap, index,
 			      irq_iommu->irte_mask);



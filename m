Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D28D60CFF1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 17:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbiJYPGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 11:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbiJYPGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 11:06:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DAFEB768
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 08:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JDilAaozZKIgmxdv/oT+QpYX5Lf5JoOi9VO8xMjYzh8=; b=YhgNTh4YMUjFkKGmj9iNcPbD5A
        BLzNbM+tIqfLEInP+JnyKelfzwXZp89E2a3y9eUWrMnynjBoVwHuG1zGbDkQUF1cm8vTw0ZQFnqOb
        Y1wJoYApFznAKovjMzMCxjGDhT7/iEax7IW0i02/Du+HJy0DIPJZRNYggA4X6YdHY57k9yzouhZVa
        w6aLbR7qj9AXQY3rvlYNYl/cqFFa8myt7lkOqgMYW1ffdV6Qgy9R0LZYZVKYkO4tbSBuzpDV7/Tbs
        rRqicIaMhZHkRjrkbys8Nntn5zSZp9BG1y7jEZfzKEt3gKTNn/rHUc7wikL82/hLHmDAsNPfwjWCZ
        vQv9CWpg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onLVR-00GLh1-6X; Tue, 25 Oct 2022 15:06:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CC53F3000DD;
        Tue, 25 Oct 2022 17:06:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B6D552C44FFD4; Tue, 25 Oct 2022 17:06:10 +0200 (CEST)
Date:   Tue, 25 Oct 2022 17:06:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jann Horn <jannh@google.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, x86@kernel.org,
        willy@infradead.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, aarcange@redhat.com,
        kirill.shutemov@linux.intel.com, jroedel@suse.de, ubizjak@gmail.com
Subject: Re: [PATCH 01/13] mm: Update ptep_get_lockless()s comment
Message-ID: <Y1f7YvKuwOl1XEwU@hirez.programming.kicks-ass.net>
References: <20221022111403.531902164@infradead.org>
 <20221022114424.515572025@infradead.org>
 <2c800ed1-d17a-def4-39e1-09281ee78d05@nvidia.com>
 <Y1ZGNwUEdm15W6Xz@hirez.programming.kicks-ass.net>
 <CAG48ez3fG=WnvbiE5mJaD66_gJj_hohnV8CqBG9eNdjd7pJW3A@mail.gmail.com>
 <Y1fsYwshJ93FT21r@hirez.programming.kicks-ass.net>
 <CAG48ez3VE+3dVdUMK+Pg_942gR+h_TCcSaFxGwCbNfh3W+mfOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez3VE+3dVdUMK+Pg_942gR+h_TCcSaFxGwCbNfh3W+mfOA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 04:18:20PM +0200, Jann Horn wrote:
> On Tue, Oct 25, 2022 at 4:02 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > On Mon, Oct 24, 2022 at 09:58:07PM +0200, Jann Horn wrote:
> >
> > > Unless I'm completely misunderstanding what's going on here, the whole
> > > "remove_table" thing only happens when you "remove a table", meaning
> > > you free an entire *pagetable*. Just zapping PTEs doesn't trigger that
> > > logic.
> >
> > Aah; yes true. OTOH even it that were not so, I think it would still be
> > broken because the current code relies on the TLB flush to have
> > completed, whereas the RCU scheme is effectively async and can be
> > considered pending until the callback runs.
> >
> > Hurmph... easiest fix is probably to dis-allow kvm_flush_tlb_multi()
> > for i386-pae builds.
> >
> > Something like so... nobody in his right mind should care about i386-pae
> > virt performance much.
> 
> I think Xen and HyperV have similar codepaths.
> hyperv_flush_tlb_multi() looks like it uses remote flush hypercalls,
> xen_flush_tlb_multi() too.

Sure (not updated).

> On top of that, I think that theoretically, Linux doesn't even ensure
> that you have a TLB flush in between tearing down one PTE and
> installing another PTE (see
> https://lore.kernel.org/all/CAG48ez1Oz4tT-N2Y=Zs6jumu=zOp7SQRZ=V2c+b5bT9P4retJA@mail.gmail.com/),
> but I haven't tested that, and if it is true, I'm also not entirely
> sure if it's correct (in the sense that it only creates incoherent-TLB
> states when userspace is doing something stupid like racing
> MADV_DONTNEED and page faults on the same region).
> 
> I think the more clearly correct fix would be to get rid of the split
> loads and use CMPXCHG16B instead (probably destroying the performance
> of GUP-fast completely), but that's complicated because some of the
> architectures that use the split loads path don't have cmpxchg_double
> (or at least don't have it wired up).

cmpxchg8b; but no, I think we want to fix MADV_DONTNEED, incoherent TLB
states are a pain nobody needs.

Something like so should force TLB flushes before dropping pte_lock (not
looked at the various pmd level things yet).

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 95fb85bea111..cbfb84e88251 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -473,6 +473,12 @@ static DEFINE_PER_CPU(cpumask_var_t, __pv_cpu_mask);
 
 static bool pv_tlb_flush_supported(void)
 {
+	/*
+	 * i386-PAE split loads are incompatible with optimized TLB flushes.
+	 */
+	if (IS_ENABLED(CONFIG_GUP_GET_PTE_LOW_HIGH))
+		return false;
+
 	return (kvm_para_has_feature(KVM_FEATURE_PV_TLB_FLUSH) &&
 		!kvm_para_has_hint(KVM_HINTS_REALTIME) &&
 		kvm_para_has_feature(KVM_FEATURE_STEAL_TIME) &&
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8bbcccbc5565..397bc04e2d82 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3474,5 +3474,6 @@ madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
  * default, the flag is not set.
  */
 #define  ZAP_FLAG_DROP_MARKER        ((__force zap_flags_t) BIT(0))
+#define  ZAP_FLAG_FORCE_FLUSH	     ((__force zap_flags_t) BIT(1))
 
 #endif /* _LINUX_MM_H */
diff --git a/mm/memory.c b/mm/memory.c
index f88c351aecd4..9bb63b3fbee1 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1440,6 +1440,11 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			tlb_remove_tlb_entry(tlb, pte, addr);
 			zap_install_uffd_wp_if_needed(vma, addr, pte, details,
 						      ptent);
+
+			if (!force_flush && !tlb->fullmm && details &&
+			    details->zap_flags & ZAP_FLAG_FORCE_FLUSH)
+				force_flush = 1;
+
 			if (unlikely(!page))
 				continue;
 
@@ -1749,6 +1754,9 @@ void zap_page_range(struct vm_area_struct *vma, unsigned long start,
 	struct maple_tree *mt = &vma->vm_mm->mm_mt;
 	unsigned long end = start + size;
 	struct mmu_notifier_range range;
+	struct zap_details details = {
+		.zap_flags = ZAP_FLAG_FORCE_FLUSH,
+	};
 	struct mmu_gather tlb;
 	MA_STATE(mas, mt, vma->vm_end, vma->vm_end);
 
@@ -1759,7 +1767,7 @@ void zap_page_range(struct vm_area_struct *vma, unsigned long start,
 	update_hiwater_rss(vma->vm_mm);
 	mmu_notifier_invalidate_range_start(&range);
 	do {
-		unmap_single_vma(&tlb, vma, start, range.end, NULL);
+		unmap_single_vma(&tlb, vma, start, range.end, &details);
 	} while ((vma = mas_find(&mas, end - 1)) != NULL);
 	mmu_notifier_invalidate_range_end(&range);
 	tlb_finish_mmu(&tlb);
@@ -1806,7 +1814,7 @@ void zap_vma_ptes(struct vm_area_struct *vma, unsigned long address,
 		unsigned long size)
 {
 	if (!range_in_vma(vma, address, address + size) ||
-	    		!(vma->vm_flags & VM_PFNMAP))
+	    !(vma->vm_flags & VM_PFNMAP))
 		return;
 
 	zap_page_range_single(vma, address, size, NULL);

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA15663C665
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 18:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236601AbiK2R2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 12:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236039AbiK2R2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 12:28:31 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E8B20997
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 09:28:30 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id k5so13314614pjo.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 09:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g2E35MNWhv4hkIS7ruRSwavDjl3qrMIOAdW5eyhnw/I=;
        b=VG6Q1cZogZ/9UOk0sk8cHDBEfy5vvZQzoZg/MhKGsVou0WPl0mVZH7DRQHLufJRekX
         Sc7esgCGECWLHSwhh8aAoxAk2qsF7oZYQ1BsNmLq1iFKKHeHg9ML0F9AmQ2XZjXAhQRP
         7B3+joF51UoeFMehfycp3R9RfXalu/F+zULqnM53Kgs9i0Swt6yQKFJ5owNSXJzRytJX
         +Sqvl37BAM3V1x8yDUI7xBXsTrtzwR+Nr9zK7fUOyZps59CS3Gn2UvwUpIuJXjb9OzUQ
         FkUzkFZjh0tI2863TyKInx7u2qoZ6rOkD2zAz9/RzRbChlKjGollNEitwaNzvBXoXJQs
         xzwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g2E35MNWhv4hkIS7ruRSwavDjl3qrMIOAdW5eyhnw/I=;
        b=S2AlJ+YIBqk3rDD8KXFbrh0V5PXchg17Rhg9PgOM3vwl+ebnOSXoXcO7jbzq7MxKmp
         80Awe3XZfols2W2f6WbfWJHfFV/gL1UEejflsXtGwpDN0a2/20F87MsAVCmim+2h+I6t
         uFUhH46TB9dig2P1XqlfdRJk0Ghps67jnQrWhYdf4jblCxI/tzWGrqDIPRNqPhPlJocU
         VW+oCsPwJ67/u5GQj7RbEC+33x+rqgLBdaj2SE5yzJIS2kd31/3hRbtJi7/etoqrlwP6
         skK93q1FUg4AuGyvraavuIoj9K8VJV2NdJKMIc/xnlJUThfo+lItdeJL2CXLRrJ4XANR
         lIUA==
X-Gm-Message-State: ANoB5plBemSz0a0LbsVBwhVO3abzHHy+CaflwrR67omyVPfgJPR+/LJk
        pokr65Kp7zyCF7G2DKmlW16Qxa0cpUrJ2OArqKc=
X-Google-Smtp-Source: AA0mqf4cQq2zji17sy+4TVONSD2Cx9kjm909gbuasJ96rIBWORjeBQ+7Pie2WBTviqMtPqv0gGf4rr8L5YY50FnCjuQ=
X-Received: by 2002:a17:90a:4302:b0:20a:e469:dc7d with SMTP id
 q2-20020a17090a430200b0020ae469dc7dmr58650887pjg.97.1669742909696; Tue, 29
 Nov 2022 09:28:29 -0800 (PST)
MIME-Version: 1.0
References: <20221129154730.2274278-1-jannh@google.com> <20221129154730.2274278-2-jannh@google.com>
In-Reply-To: <20221129154730.2274278-2-jannh@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 29 Nov 2022 09:28:18 -0800
Message-ID: <CAHbLzkoEv8Q741V0kGeUWupt0bSWXg4fAHQfpuvjbHmf-1X5mA@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] mm/khugepaged: Fix GUP-fast interaction by sending IPI
To:     Jann Horn <jannh@google.com>
Cc:     security@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 7:47 AM Jann Horn <jannh@google.com> wrote:
>
> The khugepaged paths that remove page tables have to be careful to
> synchronize against the lockless_pages_from_mm() path, which traverses
> page tables while only being protected by disabled IRQs.
> lockless_pages_from_mm() must not:
>
>  1. interpret the contents of freed memory as page tables (and once a
>     page table has been deposited, it can be freed)
>  2. interpret the contents of deposited page tables as PTEs, since some
>     architectures will store non-PTE data inside deposited page tables
>     (see radix__pgtable_trans_huge_deposit())
>  3. create new page references from PTEs after the containing page
>     table has been detached and:
>     3a. __collapse_huge_page_isolate() has checked the page refcount
>     3b. the page table has been reused at another virtual address and
>         populated with new PTEs
>
> ("new page references" here refer to stable references returned to the
> caller; speculative references that are dropped on an error path are
> fine)
>
> commit 70cbc3cc78a99 ("mm: gup: fix the fast GUP race against THP
> collapse") addressed issue 3 by making the lockless_pages_from_mm()
> fastpath recheck the pmd_t to ensure that the page table was not
> removed by khugepaged in between (under the assumption that the page
> table is not repeatedly moving back and forth between two addresses,
> with one PTE repeatedly being populated with the same value).
>
> But to address issues 1 and 2, we need to send IPIs before
> freeing/reusing page tables. By doing that, issue 3 is also
> automatically addressed, so the fix from commit 70cbc3cc78a99 ("mm: gup:
> fix the fast GUP race against THP collapse") becomes redundant.
>
> We can ensure that the necessary IPI is sent by calling
> tlb_remove_table_sync_one() because, as noted in mm/gup.c, under
> configurations that define CONFIG_HAVE_FAST_GUP, there are two possible
> cases:
>
>  1. CONFIG_MMU_GATHER_RCU_TABLE_FREE is set, causing
>     tlb_remove_table_sync_one() to send an IPI to synchronize with
>     lockless_pages_from_mm().
>  2. CONFIG_MMU_GATHER_RCU_TABLE_FREE is unset, indicating that all
>     TLB flushes are already guaranteed to send IPIs.
>     tlb_remove_table_sync_one() will do nothing, but we've already
>     run pmdp_collapse_flush(), which did a TLB flush, which must have
>     involved IPIs.
>
> Cc: stable@kernel.org
> Fixes: ba76149f47d8 ("thp: khugepaged")
> Reviewed-by: Yang Shi <shy828301@gmail.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>
> Notes:
>     v4:
>      - added ack from David Hildenbrand
>      - made commit message more verbose
>     v5:
>      - added reviewed-by from Yang Shi
>      - rewrote commit message based on feedback from Yang Shi

Thanks, Jann. Looks good to me.

>
>  include/asm-generic/tlb.h | 4 ++++
>  mm/khugepaged.c           | 2 ++
>  mm/mmu_gather.c           | 4 +---
>  3 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> index 492dce43236ea..cab7cfebf40bd 100644
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -222,12 +222,16 @@ extern void tlb_remove_table(struct mmu_gather *tlb, void *table);
>  #define tlb_needs_table_invalidate() (true)
>  #endif
>
> +void tlb_remove_table_sync_one(void);
> +
>  #else
>
>  #ifdef tlb_needs_table_invalidate
>  #error tlb_needs_table_invalidate() requires MMU_GATHER_RCU_TABLE_FREE
>  #endif
>
> +static inline void tlb_remove_table_sync_one(void) { }
> +
>  #endif /* CONFIG_MMU_GATHER_RCU_TABLE_FREE */
>
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 674b111a24fa7..c3d3ce596bff7 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1057,6 +1057,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>         _pmd = pmdp_collapse_flush(vma, address, pmd);
>         spin_unlock(pmd_ptl);
>         mmu_notifier_invalidate_range_end(&range);
> +       tlb_remove_table_sync_one();
>
>         spin_lock(pte_ptl);
>         result =  __collapse_huge_page_isolate(vma, address, pte, cc,
> @@ -1415,6 +1416,7 @@ static void collapse_and_free_pmd(struct mm_struct *mm, struct vm_area_struct *v
>                 lockdep_assert_held_write(&vma->anon_vma->root->rwsem);
>
>         pmd = pmdp_collapse_flush(vma, addr, pmdp);
> +       tlb_remove_table_sync_one();
>         mm_dec_nr_ptes(mm);
>         page_table_check_pte_clear_range(mm, addr, pmd);
>         pte_free(mm, pmd_pgtable(pmd));
> diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
> index add4244e5790d..3a2c3f8cad2fe 100644
> --- a/mm/mmu_gather.c
> +++ b/mm/mmu_gather.c
> @@ -153,7 +153,7 @@ static void tlb_remove_table_smp_sync(void *arg)
>         /* Simply deliver the interrupt */
>  }
>
> -static void tlb_remove_table_sync_one(void)
> +void tlb_remove_table_sync_one(void)
>  {
>         /*
>          * This isn't an RCU grace period and hence the page-tables cannot be
> @@ -177,8 +177,6 @@ static void tlb_remove_table_free(struct mmu_table_batch *batch)
>
>  #else /* !CONFIG_MMU_GATHER_RCU_TABLE_FREE */
>
> -static void tlb_remove_table_sync_one(void) { }
> -
>  static void tlb_remove_table_free(struct mmu_table_batch *batch)
>  {
>         __tlb_remove_table_free(batch);
> --
> 2.38.1.584.g0f3c55d4c2-goog
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EACD963B293
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 20:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbiK1Ty6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 14:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbiK1Tyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 14:54:55 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4396B2AE06
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 11:54:51 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id jn7so11221377plb.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 11:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yufTTXr46fRXR6nxP30ZjlEiGclwfZrdGjcG5UsmqVQ=;
        b=NJcA1FMwOGnUdayh3+ySuYcR7/d2ThDh307D6M38g3ioFjyfXy4nQGJ2jZ/CCuNY2r
         Cv0ZtXSKh9gutzlxIkD+qbBuyeQ6AFzWynMcpctRKpDAT56XveLPWMIJKLs3ZZ1lpBAr
         ndmb3j/9FTfWVw5wDDoWGdZFttSX1EGAZuBypB3ao3EU2jcSPhOX90OBDQtnT6zj30Qx
         sSaHl1uK0V2ltp3bHc+Ve/g70CADvwAVswIw6Fw3XaN1FSOxQRc6mnq7psAM+1MUoZEP
         LwNWpt4gfZcRtC3jdIZ7B6xBbKSbLY9xye2yfGTKPa8VOqHxVdXKcUnP7FS9pzDhEJzy
         wJ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yufTTXr46fRXR6nxP30ZjlEiGclwfZrdGjcG5UsmqVQ=;
        b=gph697YRbD92QjY57rJeXsUCww9CW1sCDYP3tju/mkCZG+odMMYUXOHUTJms6r4P+F
         i9vw88oR+fLF260JevhsdVs8ByjoYtqP+LgO8gLWInkZOXs+f/u+eXjQp+9IrzUk2jEm
         zp1TNsE1GW189y74dBzvZYwFIVDhkb324s/PkwM1riqZntQUkfkZOEHr9/9vCHpB9W2Z
         CR4iCpjqzJ6CAP3il0cMsH5bttApkGk+LUpzEXKsNlpxpU9AdVuvgVOoAUpsyJOoPPXY
         QIPpIOj+2XMov/zlK7U8HcUaiB5s1UOZHT0m2Bj+7SQs6lt3FmWF5yUnLEI3gsX2/ERz
         t+ZQ==
X-Gm-Message-State: ANoB5pkriJtj4DgyzBQfya8iVhUb6UeFvAva3ieTYLW4qftplHXMCNOF
        bTv3+pT1rJCyPsPEvLGvhgml3S5LqxzNrLv+BCs=
X-Google-Smtp-Source: AA0mqf4mrQuHhOBtp23UdUQ6mo09vCj2BRnPlD0JgJTQDBG5tIyKUpqU2oGxiYMA8QnYiguma45brnar5WxhKo6XtoU=
X-Received: by 2002:a17:90a:d38a:b0:218:a7e6:60df with SMTP id
 q10-20020a17090ad38a00b00218a7e660dfmr42400418pju.38.1669665290769; Mon, 28
 Nov 2022 11:54:50 -0800 (PST)
MIME-Version: 1.0
References: <20221128180252.1684965-1-jannh@google.com> <20221128180252.1684965-2-jannh@google.com>
In-Reply-To: <20221128180252.1684965-2-jannh@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 28 Nov 2022 11:54:39 -0800
Message-ID: <CAHbLzkp7+ZrXkoYcVtqrd2mQN3FZ4Y6tyeZCd31Oubz=+esaJQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] mm/khugepaged: Fix GUP-fast interaction by sending IPI
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

On Mon, Nov 28, 2022 at 10:03 AM Jann Horn <jannh@google.com> wrote:
>
> Since commit 70cbc3cc78a99 ("mm: gup: fix the fast GUP race against THP
> collapse"), the lockless_pages_from_mm() fastpath rechecks the pmd_t to
> ensure that the page table was not removed by khugepaged in between.
>
> However, lockless_pages_from_mm() still requires that the page table is not
> concurrently freed or reused to store non-PTE data. Otherwise, problems
> can occur because:
>
>  - deposited page tables can be freed when a THP page somewhere in the
>    mm is removed
>  - some architectures store non-PTE information inside deposited page
>    tables (see radix__pgtable_trans_huge_deposit())
>
> Additionally, lockless_pages_from_mm() is also somewhat brittle with
> regards to page tables being repeatedly moved back and forth, but
> that shouldn't be an issue in practice.
>
> Fix it by sending IPIs (if the architecture uses
> semi-RCU-style page table freeing) before freeing/reusing page tables.
>
> As noted in mm/gup.c, on configs that define CONFIG_HAVE_FAST_GUP,
> there are two possible cases:
>
>  1. CONFIG_MMU_GATHER_RCU_TABLE_FREE is set, causing
>     tlb_remove_table_sync_one() to send an IPI to synchronize with
>     lockless_pages_from_mm().
>  2. CONFIG_MMU_GATHER_RCU_TABLE_FREE is unset, indicating that all
>     TLB flushes are already guaranteed to send IPIs.
>     tlb_remove_table_sync_one() will do nothing, but we've already
>     run pmdp_collapse_flush(), which did a TLB flush, which must have
>     involved IPIs.

I'm trying to catch up with the discussion after the holiday break. I
understand you switched from always allocating a new page table page
(we decided before) to sending IPIs to serialize against fast-GUP,
this is fine to me.

So the code now looks like:
    pmdp_collapse_flush()
    sending IPI

But the missing part is how we reached "TLB flushes are already
guaranteed to send IPIs" when CONFIG_MMU_GATHER_RCU_TABLE_FREE is
unset? ARM64 doesn't do it IIRC. Or did I miss something?

>
> Cc: stable@kernel.org
> Fixes: ba76149f47d8 ("thp: khugepaged")
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> v4:
>  - added ack from David Hildenbrand
>  - made commit message more verbose
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

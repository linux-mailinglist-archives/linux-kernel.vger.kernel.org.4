Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C5264DFF8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 18:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiLORtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 12:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiLORtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 12:49:35 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54952EF5E
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 09:49:33 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id p13-20020a05600c468d00b003cf8859ed1bso2468027wmo.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 09:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4t9Tzq74bYVIUlDfXnIUmMQZCR5YgsKnTgTgvcZxKJ0=;
        b=CLC8gV+dn9/wCyv9fQSj7V3QOvmBnE79Y6rBaMxai6/zGZeghJyibuqhRRaYFkpEcB
         Z6gCDtGoVxAA7Aic6LW3TKTgdiUarOZ994Do16CLg6HPQuinds33E7jeeuQldMhH7NHs
         8+DWfik6s0RL+u2A+6bkfPO1QOjdBV+qYrAErJI8744wuJUrBEGf0xgbYGYO8x7k2uOj
         /NaAVm1Jia/YoMuq6nPuGb4YL7/Xmz4lznkc9YVy+bW0R1t+U5XoOF/05bzOgp+MUfcd
         RGC9HSu/0+a58wKxw0TF6Hklfnam1m2yq7iGpvNfEXj9DElbqZKHrZci4rp/F81VcS/M
         GVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4t9Tzq74bYVIUlDfXnIUmMQZCR5YgsKnTgTgvcZxKJ0=;
        b=UdOkaYHw5rdm3B3K7ykbPcazMyWfTcmHIHsZftQ3Jr3ziZWgTSbZ95OG9NmsI0dNZK
         +adRp4De5tnkAajvREFd7bQhl/sQ99JDqGzzXiYln7+gRwDkssTY0gue9YgUnu7+KeDK
         /nsxn47CnbYm6qkDICrXwAFOrnTIn2g2olqCw5Tn+NMR9bVB8DYHyyA0t7ZTXV5LkoSv
         oIsW+ABT43EpDbQpmg0wa74piiqrLbPVhNFA91SnqpiZbZkdu99QeFCcZYYHYL4j60UO
         ZjRa0FYid+gK6rqRPAgapIMrsbgB2NFqjgLUQSe1VMmDYH/QIdON51KBOyOFGO2R0Hdj
         0mKg==
X-Gm-Message-State: ANoB5plUQbNZGGttvHQFNRgASI0Dae3hmDpPANehF54qtdcl8pAp+OmE
        o17e0CGuUSAhf4/Qipho+EuvfWDWLLSvNFENd86gbA==
X-Google-Smtp-Source: AA0mqf4L0wi3CY4jIWRCwhgFqlDeo7t0sGIZE5s/XpPIdq1ja9D6Z89iI1BrxqCd7Tq+cgL+VwWKgRQu5U/mFjedsZ0=
X-Received: by 2002:a05:600c:2186:b0:3cf:f2aa:3dc2 with SMTP id
 e6-20020a05600c218600b003cff2aa3dc2mr428622wme.175.1671126572372; Thu, 15 Dec
 2022 09:49:32 -0800 (PST)
MIME-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com> <20221021163703.3218176-25-jthoughton@google.com>
In-Reply-To: <20221021163703.3218176-25-jthoughton@google.com>
From:   James Houghton <jthoughton@google.com>
Date:   Thu, 15 Dec 2022 12:49:18 -0500
Message-ID: <CADrL8HU=39e8ZJkmnXNKrMM=f-v1T+SF1yykC9KzwAi6T+MA4w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 24/47] hugetlb: update page_vma_mapped to do
 high-granularity walks
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 12:37 PM James Houghton <jthoughton@google.com> wrote:
>
> This updates the HugeTLB logic to look a lot more like the PTE-mapped
> THP logic. When a user calls us in a loop, we will update pvmw->address
> to walk to each page table entry that could possibly map the hugepage
> containing pvmw->pfn.
>
> This makes use of the new pte_order so callers know what size PTE
> they're getting.
>
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>  include/linux/rmap.h |  4 +++
>  mm/page_vma_mapped.c | 59 ++++++++++++++++++++++++++++++++++++--------
>  mm/rmap.c            | 48 +++++++++++++++++++++--------------
>  3 files changed, 83 insertions(+), 28 deletions(-)
>
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index e0557ede2951..d7d2d9f65a01 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -13,6 +13,7 @@
>  #include <linux/highmem.h>
>  #include <linux/pagemap.h>
>  #include <linux/memremap.h>
> +#include <linux/hugetlb.h>
>
>  /*
>   * The anon_vma heads a list of private "related" vmas, to scan if
> @@ -409,6 +410,9 @@ static inline void page_vma_mapped_walk_done(struct page_vma_mapped_walk *pvmw)
>                 pte_unmap(pvmw->pte);
>         if (pvmw->ptl)
>                 spin_unlock(pvmw->ptl);
> +       if (pvmw->pte && is_vm_hugetlb_page(pvmw->vma) &&
> +                       hugetlb_hgm_enabled(pvmw->vma))
> +               hugetlb_vma_unlock_read(pvmw->vma);
>  }
>
>  bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw);
> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> index 395ca4e21c56..1994b3f9a4c2 100644
> --- a/mm/page_vma_mapped.c
> +++ b/mm/page_vma_mapped.c
> @@ -133,7 +133,8 @@ static void step_forward(struct page_vma_mapped_walk *pvmw, unsigned long size)
>   *
>   * Returns true if the page is mapped in the vma. @pvmw->pmd and @pvmw->pte point
>   * to relevant page table entries. @pvmw->ptl is locked. @pvmw->address is
> - * adjusted if needed (for PTE-mapped THPs).
> + * adjusted if needed (for PTE-mapped THPs and high-granularity--mapped HugeTLB
> + * pages).
>   *
>   * If @pvmw->pmd is set but @pvmw->pte is not, you have found PMD-mapped page
>   * (usually THP). For PTE-mapped THP, you should run page_vma_mapped_walk() in
> @@ -166,19 +167,57 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>         if (unlikely(is_vm_hugetlb_page(vma))) {
>                 struct hstate *hstate = hstate_vma(vma);
>                 unsigned long size = huge_page_size(hstate);
> -               /* The only possible mapping was handled on last iteration */
> -               if (pvmw->pte)
> -                       return not_found(pvmw);
> +               struct hugetlb_pte hpte;
> +               pte_t *pte;
> +               pte_t pteval;
> +
> +               end = (pvmw->address & huge_page_mask(hstate)) +
> +                       huge_page_size(hstate);
>
>                 /* when pud is not present, pte will be NULL */
> -               pvmw->pte = huge_pte_offset(mm, pvmw->address, size);
> -               if (!pvmw->pte)
> +               pte = huge_pte_offset(mm, pvmw->address, size);
> +               if (!pte)
>                         return false;
>
> -               pvmw->pte_order = huge_page_order(hstate);
> -               pvmw->ptl = huge_pte_lock(hstate, mm, pvmw->pte);
> -               if (!check_pte(pvmw))
> -                       return not_found(pvmw);
> +               do {
> +                       hugetlb_pte_populate(&hpte, pte, huge_page_shift(hstate),
> +                                       hpage_size_to_level(size));
> +
> +                       /*
> +                        * Do a high granularity page table walk. The vma lock
> +                        * is grabbed to prevent the page table from being
> +                        * collapsed mid-walk. It is dropped in
> +                        * page_vma_mapped_walk_done().
> +                        */
> +                       if (pvmw->pte) {
> +                               if (pvmw->ptl)
> +                                       spin_unlock(pvmw->ptl);
> +                               pvmw->ptl = NULL;
> +                               pvmw->address += PAGE_SIZE << pvmw->pte_order;
> +                               if (pvmw->address >= end)
> +                                       return not_found(pvmw);
> +                       } else if (hugetlb_hgm_enabled(vma))
> +                               /* Only grab the lock once. */
> +                               hugetlb_vma_lock_read(vma);

I realize that I can't do this -- we're already holding the
i_mmap_rwsem, and we have to take the VMA lock first. It seems like
we're always holding it for writing in this case, so if I make
hugetlb_collapse taking the i_mmap_rwsem for reading, this will be
safe.

Peter, you looked at this recently [1] -- do you know if we're always
holding i_mmap_rwsem *for writing* here?

[1] https://lore.kernel.org/linux-mm/20221209170100.973970-10-peterx@redhat.com/

Thanks!

- James

> +
> +retry_walk:
> +                       hugetlb_hgm_walk(mm, vma, &hpte, pvmw->address,
> +                                       PAGE_SIZE, /*stop_at_none=*/true);
> +
> +                       pvmw->pte = hpte.ptep;
> +                       pvmw->pte_order = hpte.shift - PAGE_SHIFT;
> +                       pvmw->ptl = hugetlb_pte_lock(mm, &hpte);
> +                       pteval = huge_ptep_get(hpte.ptep);
> +                       if (pte_present(pteval) && !hugetlb_pte_present_leaf(
> +                                               &hpte, pteval)) {
> +                               /*
> +                                * Someone split from under us, so keep
> +                                * walking.
> +                                */
> +                               spin_unlock(pvmw->ptl);
> +                               goto retry_walk;
> +                       }
> +               } while (!check_pte(pvmw));
>                 return true;
>         }
>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 527463c1e936..a8359584467e 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1552,17 +1552,23 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>                         flush_cache_range(vma, range.start, range.end);
>
>                         /*
> -                        * To call huge_pmd_unshare, i_mmap_rwsem must be
> -                        * held in write mode.  Caller needs to explicitly
> -                        * do this outside rmap routines.
> -                        *
> -                        * We also must hold hugetlb vma_lock in write mode.
> -                        * Lock order dictates acquiring vma_lock BEFORE
> -                        * i_mmap_rwsem.  We can only try lock here and fail
> -                        * if unsuccessful.
> +                        * If HGM is enabled, we have already grabbed the VMA
> +                        * lock for reading, and we cannot safely release it.
> +                        * Because HGM-enabled VMAs have already unshared all
> +                        * PMDs, we can safely ignore PMD unsharing here.
>                          */
> -                       if (!anon) {
> +                       if (!anon && !hugetlb_hgm_enabled(vma)) {
>                                 VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
> +                               /*
> +                                * To call huge_pmd_unshare, i_mmap_rwsem must
> +                                * be held in write mode.  Caller needs to
> +                                * explicitly do this outside rmap routines.
> +                                *
> +                                * We also must hold hugetlb vma_lock in write
> +                                * mode. Lock order dictates acquiring vma_lock
> +                                * BEFORE i_mmap_rwsem.  We can only try lock
> +                                * here and fail if unsuccessful.
> +                                */
>                                 if (!hugetlb_vma_trylock_write(vma)) {
>                                         page_vma_mapped_walk_done(&pvmw);
>                                         ret = false;
> @@ -1946,17 +1952,23 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>                         flush_cache_range(vma, range.start, range.end);
>
>                         /*
> -                        * To call huge_pmd_unshare, i_mmap_rwsem must be
> -                        * held in write mode.  Caller needs to explicitly
> -                        * do this outside rmap routines.
> -                        *
> -                        * We also must hold hugetlb vma_lock in write mode.
> -                        * Lock order dictates acquiring vma_lock BEFORE
> -                        * i_mmap_rwsem.  We can only try lock here and
> -                        * fail if unsuccessful.
> +                        * If HGM is enabled, we have already grabbed the VMA
> +                        * lock for reading, and we cannot safely release it.
> +                        * Because HGM-enabled VMAs have already unshared all
> +                        * PMDs, we can safely ignore PMD unsharing here.
>                          */
> -                       if (!anon) {
> +                       if (!anon && !hugetlb_hgm_enabled(vma)) {
>                                 VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
> +                               /*
> +                                * To call huge_pmd_unshare, i_mmap_rwsem must
> +                                * be held in write mode.  Caller needs to
> +                                * explicitly do this outside rmap routines.
> +                                *
> +                                * We also must hold hugetlb vma_lock in write
> +                                * mode. Lock order dictates acquiring vma_lock
> +                                * BEFORE i_mmap_rwsem.  We can only try lock
> +                                * here and fail if unsuccessful.
> +                                */
>                                 if (!hugetlb_vma_trylock_write(vma)) {
>                                         page_vma_mapped_walk_done(&pvmw);
>                                         ret = false;
> --
> 2.38.0.135.g90850a2211-goog
>

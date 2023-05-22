Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCB070CFA5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 02:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235138AbjEWAmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 20:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234698AbjEWABk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 20:01:40 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66ED4213D
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 16:54:48 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-25355609a04so5131722a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 16:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684799688; x=1687391688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aP0oHuaIAb62A8T6EuB6LZ5TbwxhHkitQNBCiJMWqlw=;
        b=J0eBETZ9YkSQUvLhUZdyXYahQ/8qPHtDPjVfbF7S/xelNIPdZvVc/cw22GmDLYoMei
         SEFgl15nQkOdOc0pnRMau3kE/QFUFYvsi1FtTuNyYjiI53w5MDbQxAvgQPVYmcK+7Ujx
         /VnNzYMFzTRoXH3GVbRzmu3NIYvDibsHpuzz/VKdcy28392cvPf5UvECpG4PjBwTni12
         CTfrE3m7rAoER+PT7J17TsthUfeJRB6rsVDV35Vb9E8eklj7a7m3oEp90NR3hqPJLwHz
         DfxahenJ5pzoGzaU+1Ku9TO9YUP9mP8LNTo1482+LpNWR43YGfi+d5Y/njUwhn3hoBt7
         2zoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684799688; x=1687391688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aP0oHuaIAb62A8T6EuB6LZ5TbwxhHkitQNBCiJMWqlw=;
        b=GQkxfQkovoc1CP9Br932ZpYxtLIVERC54ROr4wHTr0XmROE0FUBszPLwh7kvsP5GoM
         UxOwwkLm6iFvblN2G5xMO1d/f7c+8YrEFjAGHHEla7kUk9bRM4QXhpDeqRoIk0768oEJ
         BlIoH1qEigxnIHwDO2en4h47AUgDekF0/36gmK/FOrKez3H6UB21YuBUYEC8lvJ7sbKz
         9zzMdG3o2jOz/QWW23+MsssbwpR1ONK5+SbIChPffVNvZVT802wsf/haoKUZ9rKOOi4i
         AJyWLpAusjq1R3mo/GqUhwudCgmo+jH5jCJjTsNIzRVGxGT9Ku13sKt4e+E8f5ivSO1q
         P5og==
X-Gm-Message-State: AC+VfDzLJe0ml4CQYDxCht2VX9p+DZ/qpD175VD4F3s6+G/0a4rr7Dko
        McDEJgChVRHNv9czYg56sbBTopO3jreO07btT28=
X-Google-Smtp-Source: ACHHUZ6eXDxMJihK0tAM9nn8PJq4e3PzSs7ktzDlX2kCaiEQIfDo3LqT7JLv7Xg6MOaC8h9VqRytAS6GKa/pYZGuJrY=
X-Received: by 2002:a17:90b:33ca:b0:253:48c2:9d45 with SMTP id
 lk10-20020a17090b33ca00b0025348c29d45mr11247328pjb.41.1684799687733; Mon, 22
 May 2023 16:54:47 -0700 (PDT)
MIME-Version: 1.0
References: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com> <aef43be2-f877-b0f8-b41c-37f847d3a7b4@google.com>
In-Reply-To: <aef43be2-f877-b0f8-b41c-37f847d3a7b4@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 22 May 2023 16:54:36 -0700
Message-ID: <CAHbLzkrf-Ft6geL0XKwGCY+Btn3cW=FMRjujQ48VJEnCfVki9g@mail.gmail.com>
Subject: Re: [PATCH 27/31] mm/khugepaged: allow pte_offset_map[_lock]() to fail
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2023 at 10:24=E2=80=AFPM Hugh Dickins <hughd@google.com> wr=
ote:
>
> __collapse_huge_page_swapin(): don't drop the map after every pte, it
> only has to be dropped by do_swap_page(); give up if pte_offset_map()
> fails; trace_mm_collapse_huge_page_swapin() at the end, with result;
> fix comment on returned result; fix vmf.pgoff, though it's not used.
>
> collapse_huge_page(): use pte_offset_map_lock() on the _pmd returned
> from clearing; allow failure, but it should be impossible there.
> hpage_collapse_scan_pmd() and collapse_pte_mapped_thp() allow for
> pte_offset_map_lock() failure.
>
> Signed-off-by: Hugh Dickins <hughd@google.com>

Reviewed-by: Yang Shi <shy828301@gmail.com>

A nit below:

> ---
>  mm/khugepaged.c | 72 +++++++++++++++++++++++++++++++++----------------
>  1 file changed, 49 insertions(+), 23 deletions(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 732f9ac393fc..49cfa7cdfe93 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -993,9 +993,8 @@ static int check_pmd_still_valid(struct mm_struct *mm=
,
>   * Only done if hpage_collapse_scan_pmd believes it is worthwhile.
>   *
>   * Called and returns without pte mapped or spinlocks held.
> - * Note that if false is returned, mmap_lock will be released.
> + * Returns result: if not SCAN_SUCCEED, mmap_lock has been released.
>   */
> -
>  static int __collapse_huge_page_swapin(struct mm_struct *mm,
>                                        struct vm_area_struct *vma,
>                                        unsigned long haddr, pmd_t *pmd,
> @@ -1004,23 +1003,35 @@ static int __collapse_huge_page_swapin(struct mm_=
struct *mm,
>         int swapped_in =3D 0;
>         vm_fault_t ret =3D 0;
>         unsigned long address, end =3D haddr + (HPAGE_PMD_NR * PAGE_SIZE)=
;
> +       int result;
> +       pte_t *pte =3D NULL;
>
>         for (address =3D haddr; address < end; address +=3D PAGE_SIZE) {
>                 struct vm_fault vmf =3D {
>                         .vma =3D vma,
>                         .address =3D address,
> -                       .pgoff =3D linear_page_index(vma, haddr),
> +                       .pgoff =3D linear_page_index(vma, address),
>                         .flags =3D FAULT_FLAG_ALLOW_RETRY,
>                         .pmd =3D pmd,
>                 };
>
> -               vmf.pte =3D pte_offset_map(pmd, address);
> -               vmf.orig_pte =3D *vmf.pte;
> -               if (!is_swap_pte(vmf.orig_pte)) {
> -                       pte_unmap(vmf.pte);
> -                       continue;
> +               if (!pte++) {
> +                       pte =3D pte_offset_map(pmd, address);
> +                       if (!pte) {
> +                               mmap_read_unlock(mm);
> +                               result =3D SCAN_PMD_NULL;
> +                               goto out;
> +                       }
>                 }
> +
> +               vmf.orig_pte =3D *pte;
> +               if (!is_swap_pte(vmf.orig_pte))
> +                       continue;
> +
> +               vmf.pte =3D pte;
>                 ret =3D do_swap_page(&vmf);
> +               /* Which unmaps pte (after perhaps re-checking the entry)=
 */
> +               pte =3D NULL;
>
>                 /*
>                  * do_swap_page returns VM_FAULT_RETRY with released mmap=
_lock.
> @@ -1029,24 +1040,29 @@ static int __collapse_huge_page_swapin(struct mm_=
struct *mm,
>                  * resulting in later failure.
>                  */
>                 if (ret & VM_FAULT_RETRY) {
> -                       trace_mm_collapse_huge_page_swapin(mm, swapped_in=
, referenced, 0);
>                         /* Likely, but not guaranteed, that page lock fai=
led */
> -                       return SCAN_PAGE_LOCK;
> +                       result =3D SCAN_PAGE_LOCK;

With per-VMA lock, this may not be true anymore, at least not true
until per-VMA lock supports swap fault. It may be better to have a
more general failure code, for example, SCAN_FAIL. But anyway you
don't have to change it in your patch, I can send a follow-up patch
once this series is landed on mm-unstable.

> +                       goto out;
>                 }
>                 if (ret & VM_FAULT_ERROR) {
>                         mmap_read_unlock(mm);
> -                       trace_mm_collapse_huge_page_swapin(mm, swapped_in=
, referenced, 0);
> -                       return SCAN_FAIL;
> +                       result =3D SCAN_FAIL;
> +                       goto out;
>                 }
>                 swapped_in++;
>         }
>
> +       if (pte)
> +               pte_unmap(pte);
> +
>         /* Drain LRU add pagevec to remove extra pin on the swapped in pa=
ges */
>         if (swapped_in)
>                 lru_add_drain();
>
> -       trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, 1)=
;
> -       return SCAN_SUCCEED;
> +       result =3D SCAN_SUCCEED;
> +out:
> +       trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, re=
sult);
> +       return result;
>  }
>
>  static int alloc_charge_hpage(struct page **hpage, struct mm_struct *mm,
> @@ -1146,9 +1162,6 @@ static int collapse_huge_page(struct mm_struct *mm,=
 unsigned long address,
>                                 address + HPAGE_PMD_SIZE);
>         mmu_notifier_invalidate_range_start(&range);
>
> -       pte =3D pte_offset_map(pmd, address);
> -       pte_ptl =3D pte_lockptr(mm, pmd);
> -
>         pmd_ptl =3D pmd_lock(mm, pmd); /* probably unnecessary */
>         /*
>          * This removes any huge TLB entry from the CPU so we won't allow
> @@ -1163,13 +1176,18 @@ static int collapse_huge_page(struct mm_struct *m=
m, unsigned long address,
>         mmu_notifier_invalidate_range_end(&range);
>         tlb_remove_table_sync_one();
>
> -       spin_lock(pte_ptl);
> -       result =3D  __collapse_huge_page_isolate(vma, address, pte, cc,
> -                                              &compound_pagelist);
> -       spin_unlock(pte_ptl);
> +       pte =3D pte_offset_map_lock(mm, &_pmd, address, &pte_ptl);
> +       if (pte) {
> +               result =3D __collapse_huge_page_isolate(vma, address, pte=
, cc,
> +                                                     &compound_pagelist)=
;
> +               spin_unlock(pte_ptl);
> +       } else {
> +               result =3D SCAN_PMD_NULL;
> +       }
>
>         if (unlikely(result !=3D SCAN_SUCCEED)) {
> -               pte_unmap(pte);
> +               if (pte)
> +                       pte_unmap(pte);
>                 spin_lock(pmd_ptl);
>                 BUG_ON(!pmd_none(*pmd));
>                 /*
> @@ -1253,6 +1271,11 @@ static int hpage_collapse_scan_pmd(struct mm_struc=
t *mm,
>         memset(cc->node_load, 0, sizeof(cc->node_load));
>         nodes_clear(cc->alloc_nmask);
>         pte =3D pte_offset_map_lock(mm, pmd, address, &ptl);
> +       if (!pte) {
> +               result =3D SCAN_PMD_NULL;
> +               goto out;
> +       }
> +
>         for (_address =3D address, _pte =3D pte; _pte < pte + HPAGE_PMD_N=
R;
>              _pte++, _address +=3D PAGE_SIZE) {
>                 pte_t pteval =3D *_pte;
> @@ -1622,8 +1645,10 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, =
unsigned long addr,
>          * lockless_pages_from_mm() and the hardware page walker can acce=
ss page
>          * tables while all the high-level locks are held in write mode.
>          */
> -       start_pte =3D pte_offset_map_lock(mm, pmd, haddr, &ptl);
>         result =3D SCAN_FAIL;
> +       start_pte =3D pte_offset_map_lock(mm, pmd, haddr, &ptl);
> +       if (!start_pte)
> +               goto drop_immap;
>
>         /* step 1: check all mapped PTEs are to the right huge page */
>         for (i =3D 0, addr =3D haddr, pte =3D start_pte;
> @@ -1697,6 +1722,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, u=
nsigned long addr,
>
>  abort:
>         pte_unmap_unlock(start_pte, ptl);
> +drop_immap:
>         i_mmap_unlock_write(vma->vm_file->f_mapping);
>         goto drop_hpage;
>  }
> --
> 2.35.3
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871DB6A208D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 18:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjBXRjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 12:39:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBXRjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 12:39:51 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252DD69AEB
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 09:39:49 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id x14so405550vso.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 09:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6DdWHSOmYYOCQYfqMBfKIAUiuglDSU9RZ6zPwv3mrqc=;
        b=Bv9KmUj4zAo7qpGqUTRlYxKWyXHSeWI4OmO/fKFGDFOhVixN3T3NF6lUNLmPO0FB+0
         qHcfNJUUnXp8WcwlrZMzU4aN2H9q3pLbRq/40fW+6QueKuTLTbj2SQJD8XhCelF3b2px
         Ka312bOyvQ7BLn0OKgJt/wPLJLQr34olnBUXPG8E1jypWAmckmF0ZjobqWcCiV+ijaaQ
         rWdA/zYJ3FSq1Mtp1pI2e/LGs/PiP5saQWrQmz5IEqxLU8o/EW7U+N7fjs9X0FeClSq9
         N56g3C+VaIxRFWDIC3bkcRmha3yD7HQrvXEyZDCmrquvP3GyHiGmnTOG85MOJC+TGyz+
         AuCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6DdWHSOmYYOCQYfqMBfKIAUiuglDSU9RZ6zPwv3mrqc=;
        b=zhkqdgRVn/w4hq3GWLwQP1+hhDU0GFUwIfqk+Xse5KJZGpppGeX9/CYQg3ysHx5rTd
         ZK5mZ6JAs7Z3Jri2I/WYcollOQBQKHDdk2nF44M6L+347rxmVCnP6DsPPlR5rwZFXozW
         RaiMVjsVUXPGsf4Ob5+5nTzRBOTu+U6ufJYFt8g5e2FZyn+tWZI1dM3WFeys3vv2pHcD
         mNSAndGZMMvf1necCmfpGP8tdO5ETLLjQOzmkc3CJNoBZN7FWuJbpxDxAUiQkidnw2qT
         PMidtMr/Bzxe3gJ/T1PfK5bNu4bZ+QEXSYWdWnqN0z8BZDaoLd7WTM/B4fCzzb81AI04
         ipfw==
X-Gm-Message-State: AO0yUKVkibC266FDL4Bpnhw72njMaOSjDSRhrfAxXB2I0SLc6xVtdDGp
        0Wyl7M0PrWkwHgaNWXz+ouD9dv7qwkossVwpy8Qg+w==
X-Google-Smtp-Source: AK7set8Ez6tAnhLpKJqCuX0swOAkF2AM6EIVjyQFN8bUxHfUwqydYX4+dgySrbuEybGI2ANYD+262Abc3a5MnOlkwy0=
X-Received: by 2002:a1f:5fc1:0:b0:412:611a:dce5 with SMTP id
 t184-20020a1f5fc1000000b00412611adce5mr2945608vkb.0.1677260388122; Fri, 24
 Feb 2023 09:39:48 -0800 (PST)
MIME-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com> <20230218002819.1486479-23-jthoughton@google.com>
In-Reply-To: <20230218002819.1486479-23-jthoughton@google.com>
From:   James Houghton <jthoughton@google.com>
Date:   Fri, 24 Feb 2023 09:39:12 -0800
Message-ID: <CADrL8HUu6Qncz8GkPCbeR1YbFhQwCpXm9xkB7GoigNE3HOQY7w@mail.gmail.com>
Subject: Re: [PATCH v2 22/46] hugetlb: add HGM support to copy_hugetlb_page_range
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
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
        Frank van der Linden <fvdl@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
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

On Fri, Feb 17, 2023 at 4:29 PM James Houghton <jthoughton@google.com> wrote:
>
> This allows fork() to work with high-granularity mappings. The page
> table structure is copied such that partially mapped regions will remain
> partially mapped in the same way for the new process.
>
> A page's reference count is incremented for *each* portion of it that
> is mapped in the page table. For example, if you have a PMD-mapped 1G
> page, the reference count will be incremented by 512.
>
> mapcount is handled similar to THPs: if you're completely mapping a
> hugepage, then the compound_mapcount is incremented. If you're mapping a
> part of it, the subpages that are getting mapped will have their
> mapcounts incremented.
>
> Signed-off-by: James Houghton <jthoughton@google.com>
>
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 1a1a71868dfd..2fe1eb6897d4 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -162,6 +162,8 @@ void hugepage_put_subpool(struct hugepage_subpool *spool);
>
>  void hugetlb_remove_rmap(struct page *subpage, unsigned long shift,
>                          struct hstate *h, struct vm_area_struct *vma);
> +void hugetlb_add_file_rmap(struct page *subpage, unsigned long shift,
> +                          struct hstate *h, struct vm_area_struct *vma);
>
>  void hugetlb_dup_vma_private(struct vm_area_struct *vma);
>  void clear_vma_resv_huge_pages(struct vm_area_struct *vma);
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 693332b7e186..210c6f2b16a5 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -141,6 +141,37 @@ void hugetlb_remove_rmap(struct page *subpage, unsigned long shift,
>                         page_remove_rmap(subpage, vma, false);
>         }
>  }
> +/*
> + * hugetlb_add_file_rmap() - increment the mapcounts for file-backed hugetlb
> + * pages appropriately.
> + *
> + * For pages that are being mapped with their hstate-level PTE (e.g., a 1G page
> + * being mapped with a 1G PUD), then we increment the compound_mapcount for the
> + * head page.
> + *
> + * For pages that are being mapped with high-granularity, we increment the
> + * mapcounts for the individual subpages that are getting mapped.
> + */
> +void hugetlb_add_file_rmap(struct page *subpage, unsigned long shift,
> +                          struct hstate *h, struct vm_area_struct *vma)
> +{
> +       struct page *hpage = compound_head(subpage);
> +
> +       if (shift == huge_page_shift(h)) {
> +               VM_BUG_ON_PAGE(subpage != hpage, subpage);
> +               page_add_file_rmap(hpage, vma, true);
> +       } else {
> +               unsigned long nr_subpages = 1UL << (shift - PAGE_SHIFT);
> +               struct page *final_page = &subpage[nr_subpages];
> +
> +               VM_BUG_ON_PAGE(HPageVmemmapOptimized(hpage), hpage);
> +               /*
> +                * Increment the mapcount on each page that is getting mapped.
> +                */
> +               for (; subpage < final_page; ++subpage)
> +                       page_add_file_rmap(subpage, vma, false);
> +       }
> +}
>
>  static inline bool subpool_is_free(struct hugepage_subpool *spool)
>  {
> @@ -5210,7 +5241,8 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>                             struct vm_area_struct *src_vma)
>  {
>         pte_t *src_pte, *dst_pte, entry;
> -       struct page *ptepage;
> +       struct hugetlb_pte src_hpte, dst_hpte;
> +       struct page *ptepage, *hpage;
>         unsigned long addr;
>         bool cow = is_cow_mapping(src_vma->vm_flags);
>         struct hstate *h = hstate_vma(src_vma);
> @@ -5238,18 +5270,24 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>         }
>
>         last_addr_mask = hugetlb_mask_last_page(h);
> -       for (addr = src_vma->vm_start; addr < src_vma->vm_end; addr += sz) {
> +       addr = src_vma->vm_start;
> +       while (addr < src_vma->vm_end) {
>                 spinlock_t *src_ptl, *dst_ptl;
> -               src_pte = hugetlb_walk(src_vma, addr, sz);
> -               if (!src_pte) {
> -                       addr |= last_addr_mask;
> +               unsigned long hpte_sz;
> +
> +               if (hugetlb_full_walk(&src_hpte, src_vma, addr)) {
> +                       addr = (addr | last_addr_mask) + sz;
>                         continue;
>                 }
> -               dst_pte = huge_pte_alloc(dst, dst_vma, addr, sz);
> -               if (!dst_pte) {
> -                       ret = -ENOMEM;
> +               ret = hugetlb_full_walk_alloc(&dst_hpte, dst_vma, addr,
> +                               hugetlb_pte_size(&src_hpte));
> +               if (ret)
>                         break;
> -               }
> +
> +               src_pte = src_hpte.ptep;
> +               dst_pte = dst_hpte.ptep;
> +
> +               hpte_sz = hugetlb_pte_size(&src_hpte);
>
>                 /*
>                  * If the pagetables are shared don't copy or take references.
> @@ -5259,13 +5297,14 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>                  * another vma. So page_count of ptep page is checked instead
>                  * to reliably determine whether pte is shared.
>                  */
> -               if (page_count(virt_to_page(dst_pte)) > 1) {
> -                       addr |= last_addr_mask;
> +               if (hugetlb_pte_size(&dst_hpte) == sz &&
> +                   page_count(virt_to_page(dst_pte)) > 1) {
> +                       addr = (addr | last_addr_mask) + sz;
>                         continue;
>                 }
>
> -               dst_ptl = huge_pte_lock(h, dst, dst_pte);
> -               src_ptl = huge_pte_lockptr(huge_page_shift(h), src, src_pte);
> +               dst_ptl = hugetlb_pte_lock(&dst_hpte);
> +               src_ptl = hugetlb_pte_lockptr(&src_hpte);
>                 spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
>                 entry = huge_ptep_get(src_pte);
>  again:
> @@ -5309,10 +5348,15 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>                          */
>                         if (userfaultfd_wp(dst_vma))
>                                 set_huge_pte_at(dst, addr, dst_pte, entry);
> +               } else if (!hugetlb_pte_present_leaf(&src_hpte, entry)) {
> +                       /* Retry the walk. */
> +                       spin_unlock(src_ptl);
> +                       spin_unlock(dst_ptl);
> +                       continue;
>                 } else {
> -                       entry = huge_ptep_get(src_pte);
>                         ptepage = pte_page(entry);
> -                       get_page(ptepage);
> +                       hpage = compound_head(ptepage);
> +                       get_page(hpage);
>
>                         /*
>                          * Failing to duplicate the anon rmap is a rare case
> @@ -5324,13 +5368,34 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>                          * need to be without the pgtable locks since we could
>                          * sleep during the process.
>                          */
> -                       if (!PageAnon(ptepage)) {
> -                               page_add_file_rmap(ptepage, src_vma, true);
> -                       } else if (page_try_dup_anon_rmap(ptepage, true,
> +                       if (!PageAnon(hpage)) {
> +                               hugetlb_add_file_rmap(ptepage,
> +                                               src_hpte.shift, h, src_vma);
> +                       }
> +                       /*
> +                        * It is currently impossible to get anonymous HugeTLB
> +                        * high-granularity mappings, so we use 'hpage' here.
> +                        *
> +                        * This will need to be changed when HGM support for
> +                        * anon mappings is added.
> +                        */
> +                       else if (page_try_dup_anon_rmap(hpage, true,
>                                                           src_vma)) {
>                                 pte_t src_pte_old = entry;
>                                 struct folio *new_folio;
>
> +                               /*
> +                                * If we are mapped at high granularity, we
> +                                * may end up allocating lots and lots of
> +                                * hugepages when we only need one. Bail out
> +                                * now.
> +                                */
> +                               if (hugetlb_pte_size(&src_hpte) != sz) {
> +                                       put_page(hpage);
> +                                       ret = -EINVAL;
> +                                       break;
> +                               }
> +

Although this block never executes, it should come after the following
spin_unlocks().

>                                 spin_unlock(src_ptl);
>                                 spin_unlock(dst_ptl);
>                                 /* Do not use reserve as it's private owned */
> @@ -5342,7 +5407,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>                                 }
>                                 copy_user_huge_page(&new_folio->page, ptepage, addr, dst_vma,
>                                                     npages);
> -                               put_page(ptepage);
> +                               put_page(hpage);
>
>                                 /* Install the new hugetlb folio if src pte stable */
>                                 dst_ptl = huge_pte_lock(h, dst, dst_pte);
> @@ -5360,6 +5425,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>                                 hugetlb_install_folio(dst_vma, dst_pte, addr, new_folio);
>                                 spin_unlock(src_ptl);
>                                 spin_unlock(dst_ptl);
> +                               addr += hugetlb_pte_size(&src_hpte);
>                                 continue;
>                         }
>
> @@ -5376,10 +5442,13 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>                         }
>
>                         set_huge_pte_at(dst, addr, dst_pte, entry);
> -                       hugetlb_count_add(npages, dst);
> +                       hugetlb_count_add(
> +                                       hugetlb_pte_size(&dst_hpte) / PAGE_SIZE,
> +                                       dst);
>                 }
>                 spin_unlock(src_ptl);
>                 spin_unlock(dst_ptl);
> +               addr += hugetlb_pte_size(&src_hpte);
>         }
>
>         if (cow) {
> --
> 2.39.2.637.g21b0678d19-goog
>

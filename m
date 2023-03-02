Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97526A78B0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 02:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjCBBGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 20:06:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjCBBGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 20:06:46 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1B857084
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 17:06:42 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id p6so15100094plf.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 17:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677719201;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6Vbzoq2NlMLkBrslsnpa6lh2qb/J3cb6PIPBnoSfW5w=;
        b=laS5U7G3pGMkBjI9h/8DOtdSsC8szhiGeHlQXy6sWG656OW9YREHeDX/WuxWmYoeCV
         Tcl750rZg0ZlnHj4/l2H1N6XBYVvli26Ju0k7cq25ty/1zxIsYf+Q0qBC22bDEDkUjrY
         Aq/WdnWVz1DqM/TuoYTwgf6ki/aUX0aD1aaA8Ih0hrnQYgzImXnOW4+x1htuowWGwGwp
         n2/QOmmSOppQYSzHM6OvHjUWJxRLt5tfUqWfOz1VEWQ6cJuxDZOAumf31OBq70LPsn/5
         eVVqzgEQo9YQCwSE+KdJlnTjhjcTm6YoZE89wDPFEuH5l0GTZgfJrwNPALbZRcvOxKwF
         4niA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677719201;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Vbzoq2NlMLkBrslsnpa6lh2qb/J3cb6PIPBnoSfW5w=;
        b=xrph5zfR83SIbJx0A4xo32AQyHPWKON9swzuDXyLd0Sy/UuNYkZxkzs784tC1U0BnB
         TphTyTPS/eCX0T+4tw5Gg6jzm1OOzubc3iI99p2s1yEvqqCHAoAZacHgoE/A1PAQumw8
         4+s55o7JgGWyVJbmpOsWCWMb8pBZeSecViEhUukL/doJgYsSU6ZKiqOtfvLvTi0HXHu5
         7Q/e3t5lcR6ZY7ttX2HySTAXkdUrTzdAfswA2iBSQltivGsPw+ZtbtVev5CUCuq/+DvF
         EJQUe1zwKlW7ytWee9zAj/dRGpnaqGtsW0rVsTWvIhf9EneXBx7gtfb4CiVVldO83xOT
         eh4A==
X-Gm-Message-State: AO0yUKWToV+sC8y+ZosKkFyzYIp3sZsWT0m9ZK3/Qown8HSA3yVupxyj
        1BytJEDhaYqB6UTW197ipqFHX9PmIQv2amuSuSb7YQ==
X-Google-Smtp-Source: AK7set/jlQy1Wj3oVccWFveT80DVVkTwvB870oteENYmAj5myMuk1sFqnUtC5hw6LuD+tKHgd2+SRc8vZmhldCDgDps=
X-Received: by 2002:a17:90a:a117:b0:230:76b2:ae13 with SMTP id
 s23-20020a17090aa11700b0023076b2ae13mr3370623pjp.1.1677719201095; Wed, 01 Mar
 2023 17:06:41 -0800 (PST)
MIME-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com> <20230218002819.1486479-6-jthoughton@google.com>
In-Reply-To: <20230218002819.1486479-6-jthoughton@google.com>
From:   Jiaqi Yan <jiaqiyan@google.com>
Date:   Wed, 1 Mar 2023 17:06:30 -0800
Message-ID: <CACw3F538H+bYcvSY-qG4-gmrgGPRBgTScDzrX9suLyp_q+v_bQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/46] rmap: hugetlb: switch from page_dup_file_rmap to page_add_file_rmap
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
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
        Frank van der Linden <fvdl@google.com>, linux-mm@kvack.org,
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

On Fri, Feb 17, 2023 at 4:28 PM James Houghton <jthoughton@google.com> wrote:
>
> This only applies to file-backed HugeTLB, and it should be a no-op until
> high-granularity mapping is possible. Also update page_remove_rmap to
> support the eventual case where !compound && folio_test_hugetlb().
>
> HugeTLB doesn't use LRU or mlock, so we avoid those bits. This also
> means we don't need to use subpage_mapcount; if we did, it would
> overflow with only a few mappings.
>
> There is still one caller of page_dup_file_rmap left: copy_present_pte,
> and it is always called with compound=false in this case.
>
> Signed-off-by: James Houghton <jthoughton@google.com>
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 08004371cfed..6c008c9de80e 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5077,7 +5077,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>                          * sleep during the process.
>                          */
>                         if (!PageAnon(ptepage)) {
> -                               page_dup_file_rmap(ptepage, true);
> +                               page_add_file_rmap(ptepage, src_vma, true);
>                         } else if (page_try_dup_anon_rmap(ptepage, true,
>                                                           src_vma)) {
>                                 pte_t src_pte_old = entry;
> @@ -5910,7 +5910,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>         if (anon_rmap)
>                 hugepage_add_new_anon_rmap(folio, vma, haddr);
>         else
> -               page_dup_file_rmap(&folio->page, true);
> +               page_add_file_rmap(&folio->page, vma, true);
>         new_pte = make_huge_pte(vma, &folio->page, ((vma->vm_flags & VM_WRITE)
>                                 && (vma->vm_flags & VM_SHARED)));
>         /*
> @@ -6301,7 +6301,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>                 goto out_release_unlock;
>
>         if (folio_in_pagecache)
> -               page_dup_file_rmap(&folio->page, true);
> +               page_add_file_rmap(&folio->page, dst_vma, true);
>         else
>                 hugepage_add_new_anon_rmap(folio, dst_vma, dst_addr);
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index d3964c414010..b0f87f19b536 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -254,7 +254,7 @@ static bool remove_migration_pte(struct folio *folio,
>                                 hugepage_add_anon_rmap(new, vma, pvmw.address,
>                                                        rmap_flags);
>                         else
> -                               page_dup_file_rmap(new, true);
> +                               page_add_file_rmap(new, vma, true);
>                         set_huge_pte_at(vma->vm_mm, pvmw.address, pvmw.pte, pte);
>                 } else
>  #endif
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 15ae24585fc4..c010d0af3a82 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c

Given you are making hugetlb's ref/mapcount mechanism to be consistent
with THP, I think the special folio_test_hugetlb checks you added in
this commit will break page_mapped() and folio_mapped() if page/folio
is HGMed. With these checks, folio->_nr_pages_mapped are not properly
increased/decreased.

> @@ -1318,21 +1318,21 @@ void page_add_file_rmap(struct page *page, struct vm_area_struct *vma,
>         int nr = 0, nr_pmdmapped = 0;
>         bool first;
>
> -       VM_BUG_ON_PAGE(compound && !PageTransHuge(page), page);
> +       VM_BUG_ON_PAGE(compound && !PageTransHuge(page)
> +                               && !folio_test_hugetlb(folio), page);
>
>         /* Is page being mapped by PTE? Is this its first map to be added? */
>         if (likely(!compound)) {
>                 first = atomic_inc_and_test(&page->_mapcount);
>                 nr = first;
> -               if (first && folio_test_large(folio)) {
> +               if (first && folio_test_large(folio)
> +                         && !folio_test_hugetlb(folio)) {

So we should still increment _nr_pages_mapped for hugetlb case here,
and decrement in the corresponding place in page_remove_rmap.

>                         nr = atomic_inc_return_relaxed(mapped);
>                         nr = (nr < COMPOUND_MAPPED);
>                 }
> -       } else if (folio_test_pmd_mappable(folio)) {
> -               /* That test is redundant: it's for safety or to optimize out */
> -
> +       } else {
>                 first = atomic_inc_and_test(&folio->_entire_mapcount);
> -               if (first) {
> +               if (first && !folio_test_hugetlb(folio)) {

Same here: we should still increase _nr_pages_mapped by
COMPOUND_MAPPED and decrease by COMPOUND_MAPPED in the corresponding
place in page_remove_rmap.

>                         nr = atomic_add_return_relaxed(COMPOUND_MAPPED, mapped);
>                         if (likely(nr < COMPOUND_MAPPED + COMPOUND_MAPPED)) {
>                                 nr_pmdmapped = folio_nr_pages(folio);
> @@ -1347,6 +1347,9 @@ void page_add_file_rmap(struct page *page, struct vm_area_struct *vma,
>                 }
>         }
>
> +       if (folio_test_hugetlb(folio))
> +               return;
> +
>         if (nr_pmdmapped)
>                 __lruvec_stat_mod_folio(folio, folio_test_swapbacked(folio) ?
>                         NR_SHMEM_PMDMAPPED : NR_FILE_PMDMAPPED, nr_pmdmapped);
> @@ -1376,8 +1379,7 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
>         VM_BUG_ON_PAGE(compound && !PageHead(page), page);
>
>         /* Hugetlb pages are not counted in NR_*MAPPED */
> -       if (unlikely(folio_test_hugetlb(folio))) {
> -               /* hugetlb pages are always mapped with pmds */
> +       if (unlikely(folio_test_hugetlb(folio)) && compound) {
>                 atomic_dec(&folio->_entire_mapcount);
>                 return;
>         }

This entire if-block should be removed after you remove the
!folio_test_hugetlb checks in page_add_file_rmap.

> @@ -1386,15 +1388,14 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
>         if (likely(!compound)) {
>                 last = atomic_add_negative(-1, &page->_mapcount);
>                 nr = last;
> -               if (last && folio_test_large(folio)) {
> +               if (last && folio_test_large(folio)
> +                        && !folio_test_hugetlb(folio)) {

ditto.

>                         nr = atomic_dec_return_relaxed(mapped);
>                         nr = (nr < COMPOUND_MAPPED);
>                 }
> -       } else if (folio_test_pmd_mappable(folio)) {
> -               /* That test is redundant: it's for safety or to optimize out */
> -
> +       } else {
>                 last = atomic_add_negative(-1, &folio->_entire_mapcount);
> -               if (last) {
> +               if (last && !folio_test_hugetlb(folio)) {

ditto.

>                         nr = atomic_sub_return_relaxed(COMPOUND_MAPPED, mapped);
>                         if (likely(nr < COMPOUND_MAPPED)) {
>                                 nr_pmdmapped = folio_nr_pages(folio);
> @@ -1409,6 +1410,9 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
>                 }
>         }
>
> +       if (folio_test_hugetlb(folio))
> +               return;
> +
>         if (nr_pmdmapped) {
>                 if (folio_test_anon(folio))
>                         idx = NR_ANON_THPS;
> --
> 2.39.2.637.g21b0678d19-goog
>

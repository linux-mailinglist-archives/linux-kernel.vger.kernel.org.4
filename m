Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6822E6465E1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 01:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiLHAbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 19:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiLHAbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 19:31:02 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37763291
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 16:31:01 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id 124so87608vsv.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 16:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p5WBdkEpJV/XTKI6wZIwF6RcwfBMMFBqR4HpwYj1Iik=;
        b=ApIcYbSmekD23uWx5dA+Kl8FYlXaFPXjaNGrYJBcdv58Kv2UWbXVCFH8WTmJLFCwIh
         mvwYSPh2TEYnrQoNMG6iVnSQuqmhtnkXGPSb/YN5kw6dNFt4kujnjZ/tog57LgAc6g0I
         Ji1ptK6Kc2BbWhRofFpEMWvrN04PSEQliJ60/MDQbeVjugGJXTXf+ZuPRcLZ8gp2pHtr
         B514nqs2+t+c/tZAK8WpiXRZc6MZ+y2+Rnd2PnwEmmpIy3h+KI/SngXjgW+qMf+np/Ma
         l2uePVBq5EynPhxXEtii2rD7yIGe3WVPBESFgAWYsvfpT2M3AiqwK5sCXv+3f6dabEKF
         bhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p5WBdkEpJV/XTKI6wZIwF6RcwfBMMFBqR4HpwYj1Iik=;
        b=QlMcRTGEMfbXeyZ1oOF9GNardasiFiYlNxDvec4gqOXprox4BlL+ENNnhZpzl0nl+P
         eYKQ8qNzZN7I0PX8J+zLLs1Z95Pm/giIjJA7+4yvy+7Wwn18EpCB7sIHXee52ZCCwu3l
         wUIOQKl8hCWJDnzcW/pr5gQexUemYK2nUOJE7Kx04IoxslS8IxlGQNtXYz4ONdi8qUI8
         2RZykhsYKLgUrUzTKjIHs4uKwYzuo2rJO47RWTeY5wJceh0as8X0tuU0Al5+nM2p85B9
         JbGbTXcgeGrMXr0jZS7jiz+zwdEjIY4sDSbXqWj6HVwgd72l2u3LbwElJ4dabrR+NMVv
         4RMg==
X-Gm-Message-State: ANoB5plUyWUmVhlYQSmY4o6VcDOF499NifY+pyekZaE/k6N7PyuT/f8f
        DnTUOVPp7AgZlgW065Anr4ZjilWlmyrTxaCkN44mBQ==
X-Google-Smtp-Source: AA0mqf6Fc8JDX0zOyaZo1dEdUVkKWxDXZVSQbIRgemJLXPJi9Hi9MqDONzRdv750MdoUxYtULUkl4OtDxojo2LoiLE4=
X-Received: by 2002:a05:6102:cd1:b0:3aa:1bff:a8a5 with SMTP id
 g17-20020a0561020cd100b003aa1bffa8a5mr52169243vst.67.1670459460180; Wed, 07
 Dec 2022 16:31:00 -0800 (PST)
MIME-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com> <20221021163703.3218176-10-jthoughton@google.com>
In-Reply-To: <20221021163703.3218176-10-jthoughton@google.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 7 Dec 2022 16:30:48 -0800
Message-ID: <CAHS8izMYp_Km_R1p7ruE8CyrYt8A=oA6DmKc+pei_Uw9JO+uXQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 09/47] hugetlb: make huge_pte_lockptr take an
 explicit shift argument.
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
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

On Fri, Oct 21, 2022 at 9:37 AM James Houghton <jthoughton@google.com> wrote:
>
> This is needed to handle PTL locking with high-granularity mapping. We
> won't always be using the PMD-level PTL even if we're using the 2M
> hugepage hstate. It's possible that we're dealing with 4K PTEs, in which
> case, we need to lock the PTL for the 4K PTE.
>
> Signed-off-by: James Houghton <jthoughton@google.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

> ---
>  arch/powerpc/mm/pgtable.c | 3 ++-
>  include/linux/hugetlb.h   | 9 ++++-----
>  mm/hugetlb.c              | 7 ++++---
>  mm/migrate.c              | 3 ++-
>  4 files changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
> index cb2dcdb18f8e..035a0df47af0 100644
> --- a/arch/powerpc/mm/pgtable.c
> +++ b/arch/powerpc/mm/pgtable.c
> @@ -261,7 +261,8 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>
>                 psize = hstate_get_psize(h);
>  #ifdef CONFIG_DEBUG_VM
> -               assert_spin_locked(huge_pte_lockptr(h, vma->vm_mm, ptep));
> +               assert_spin_locked(huge_pte_lockptr(huge_page_shift(h),
> +                                                   vma->vm_mm, ptep));
>  #endif
>
>  #else
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 6e0c36b08a0c..db3ed6095b1c 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -934,12 +934,11 @@ static inline gfp_t htlb_modify_alloc_mask(struct hstate *h, gfp_t gfp_mask)
>         return modified_mask;
>  }
>
> -static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
> +static inline spinlock_t *huge_pte_lockptr(unsigned int shift,
>                                            struct mm_struct *mm, pte_t *pte)
>  {
> -       if (huge_page_size(h) == PMD_SIZE)
> +       if (shift == PMD_SHIFT)
>                 return pmd_lockptr(mm, (pmd_t *) pte);
> -       VM_BUG_ON(huge_page_size(h) == PAGE_SIZE);
>         return &mm->page_table_lock;
>  }
>
> @@ -1144,7 +1143,7 @@ static inline gfp_t htlb_modify_alloc_mask(struct hstate *h, gfp_t gfp_mask)
>         return 0;
>  }
>
> -static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
> +static inline spinlock_t *huge_pte_lockptr(unsigned int shift,
>                                            struct mm_struct *mm, pte_t *pte)
>  {
>         return &mm->page_table_lock;
> @@ -1206,7 +1205,7 @@ static inline spinlock_t *huge_pte_lock(struct hstate *h,
>  {
>         spinlock_t *ptl;
>
> -       ptl = huge_pte_lockptr(h, mm, pte);
> +       ptl = huge_pte_lockptr(huge_page_shift(h), mm, pte);
>         spin_lock(ptl);
>         return ptl;
>  }
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index a18143add956..ef7662bd0068 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4847,7 +4847,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>                 }
>
>                 dst_ptl = huge_pte_lock(h, dst, dst_pte);
> -               src_ptl = huge_pte_lockptr(h, src, src_pte);
> +               src_ptl = huge_pte_lockptr(huge_page_shift(h), src, src_pte);
>                 spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
>                 entry = huge_ptep_get(src_pte);
>  again:
> @@ -4925,7 +4925,8 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>
>                                 /* Install the new huge page if src pte stable */
>                                 dst_ptl = huge_pte_lock(h, dst, dst_pte);
> -                               src_ptl = huge_pte_lockptr(h, src, src_pte);
> +                               src_ptl = huge_pte_lockptr(huge_page_shift(h),
> +                                                          src, src_pte);
>                                 spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
>                                 entry = huge_ptep_get(src_pte);
>                                 if (!pte_same(src_pte_old, entry)) {
> @@ -4979,7 +4980,7 @@ static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
>         pte_t pte;
>
>         dst_ptl = huge_pte_lock(h, mm, dst_pte);
> -       src_ptl = huge_pte_lockptr(h, mm, src_pte);
> +       src_ptl = huge_pte_lockptr(huge_page_shift(h), mm, src_pte);
>
>         /*
>          * We don't have to worry about the ordering of src and dst ptlocks
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 1457cdbb7828..a0105fa6e3b2 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -334,7 +334,8 @@ void __migration_entry_wait_huge(pte_t *ptep, spinlock_t *ptl)
>
>  void migration_entry_wait_huge(struct vm_area_struct *vma, pte_t *pte)
>  {
> -       spinlock_t *ptl = huge_pte_lockptr(hstate_vma(vma), vma->vm_mm, pte);
> +       spinlock_t *ptl = huge_pte_lockptr(huge_page_shift(hstate_vma(vma)),
> +                                          vma->vm_mm, pte);
>
>         __migration_entry_wait_huge(pte, ptl);
>  }
> --
> 2.38.0.135.g90850a2211-goog
>

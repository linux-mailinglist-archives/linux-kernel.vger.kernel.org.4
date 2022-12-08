Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05FB6465D1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 01:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiLHA00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 19:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiLHA0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 19:26:24 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8AB88B48
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 16:26:24 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id k185so87907vsc.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 16:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1cPWCJxHb7vXKDYo5Yh/DR7B6idG0GH1JIk/Nqz7sNQ=;
        b=pZQ5HzoMeGMTOGt+Q81R3YL1/Dm9TZHe/hV+mWOpfWUPGZLePMLnCO/WQ/15IQnW3x
         p9bSTvCf5xBpB+fSsZmdLugO7hnMu49EgoiLQCFUExyRqTcynXe2xfk77THNqMzjQt+0
         d7Ffe6s7CSXwOOMOK+QO1wwZYejVWI5fQoJl4vg3k9964lppO7b69M1ijH8F6SRjkeCG
         iPymoh8L9InJSm4guLBZYeG3SzZV7DrjSwVRr6vAG+mnmU3fI/kEZzOjCVDsxwbEfac9
         zc3Lba60Ny4ieIXWXeMQHP5VFIL/Z957QXxcQDKBL5iD75wmyPZ7BFyYsxJ5EF7hQgjq
         EZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1cPWCJxHb7vXKDYo5Yh/DR7B6idG0GH1JIk/Nqz7sNQ=;
        b=pdk891zPS+A/pvq3qDG7jO59wnlPcxrTF7LnwW5PZ0XSXVynAmTlsirVMbDbvLNrtC
         77Mkr02aq7cA4wF4HK69f2h/AqJUmtiQsJ+qOTmkNfxzwLbJJxbkPN5mDsI0BJQJGU+z
         x6SxE3eEnW50K5FJbY/2PuZaYFRF23Vld9+VJWSbcVxFISMmSlEAYJMOuvr6v/0V9nCP
         a4L4uKRbPt4ZQkGJDgGNVMwg1WQVZ3XaOfZkWazl5deTlbA9EAfBlmxf79it2apt/8fs
         DxKBlWoJNhR+4xfQHd7YEzHBWrMs5su/s8XQQUkjtwxDL2c7O5EDruG7WENJkrsxhwlm
         85eA==
X-Gm-Message-State: ANoB5pn84WfrxSSzPtYWIyFgcgf9Sk6Dg5QQhHx/HX1Fmic+zoQQpNi9
        Sv/l35QcQWV5otJf/peP3gcWsik5gsmSch0xCugkvA==
X-Google-Smtp-Source: AA0mqf4bXatNHXXC5HX/WLbX3cAjd6Tl/5qwSO3/XkoJmGNgN3JsW4uenQ7PnP8DzHu1GDyu2RgRCQnpYY+RJ47oGXg=
X-Received: by 2002:a67:ea04:0:b0:3a7:d7bc:c2e9 with SMTP id
 g4-20020a67ea04000000b003a7d7bcc2e9mr42542350vso.61.1670459183014; Wed, 07
 Dec 2022 16:26:23 -0800 (PST)
MIME-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com> <20221021163703.3218176-9-jthoughton@google.com>
In-Reply-To: <20221021163703.3218176-9-jthoughton@google.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 7 Dec 2022 16:26:11 -0800
Message-ID: <CAHS8izOkzpRY+Q1dVxFp1Yu67O4S-CXMe2rg8sYCC+izyhSj3g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 08/47] hugetlb: add HGM enablement functions
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
> Currently it is possible for all shared VMAs to use HGM, but it must be
> enabled first. This is because with HGM, we lose PMD sharing, and page
> table walks require additional synchronization (we need to take the VMA
> lock).
>
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>  include/linux/hugetlb.h | 22 +++++++++++++
>  mm/hugetlb.c            | 69 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 91 insertions(+)
>
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 534958499ac4..6e0c36b08a0c 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -123,6 +123,9 @@ struct hugetlb_vma_lock {
>
>  struct hugetlb_shared_vma_data {
>         struct hugetlb_vma_lock vma_lock;
> +#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
> +       bool hgm_enabled;
> +#endif
>  };
>
>  extern struct resv_map *resv_map_alloc(void);
> @@ -1179,6 +1182,25 @@ static inline void hugetlb_unregister_node(struct node *node)
>  }
>  #endif /* CONFIG_HUGETLB_PAGE */
>
> +#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
> +bool hugetlb_hgm_enabled(struct vm_area_struct *vma);
> +bool hugetlb_hgm_eligible(struct vm_area_struct *vma);
> +int enable_hugetlb_hgm(struct vm_area_struct *vma);
> +#else
> +static inline bool hugetlb_hgm_enabled(struct vm_area_struct *vma)
> +{
> +       return false;
> +}
> +static inline bool hugetlb_hgm_eligible(struct vm_area_struct *vma)
> +{
> +       return false;
> +}
> +static inline int enable_hugetlb_hgm(struct vm_area_struct *vma)
> +{
> +       return -EINVAL;
> +}
> +#endif
> +
>  static inline spinlock_t *huge_pte_lock(struct hstate *h,
>                                         struct mm_struct *mm, pte_t *pte)
>  {
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 5ae8bc8c928e..a18143add956 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6840,6 +6840,10 @@ static bool pmd_sharing_possible(struct vm_area_struct *vma)
>  #ifdef CONFIG_USERFAULTFD
>         if (uffd_disable_huge_pmd_share(vma))
>                 return false;
> +#endif
> +#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
> +       if (hugetlb_hgm_enabled(vma))
> +               return false;
>  #endif
>         /*
>          * Only shared VMAs can share PMDs.
> @@ -7033,6 +7037,9 @@ static int hugetlb_vma_data_alloc(struct vm_area_struct *vma)
>         kref_init(&data->vma_lock.refs);
>         init_rwsem(&data->vma_lock.rw_sema);
>         data->vma_lock.vma = vma;
> +#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
> +       data->hgm_enabled = false;
> +#endif
>         vma->vm_private_data = data;
>         return 0;
>  }
> @@ -7290,6 +7297,68 @@ __weak unsigned long hugetlb_mask_last_page(struct hstate *h)
>
>  #endif /* CONFIG_ARCH_WANT_GENERAL_HUGETLB */
>
> +#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
> +bool hugetlb_hgm_eligible(struct vm_area_struct *vma)
> +{
> +       /*
> +        * All shared VMAs may have HGM.
> +        *
> +        * HGM requires using the VMA lock, which only exists for shared VMAs.
> +        * To make HGM work for private VMAs, we would need to use another
> +        * scheme to prevent collapsing/splitting from invalidating other
> +        * threads' page table walks.
> +        */
> +       return vma && (vma->vm_flags & VM_MAYSHARE);
> +}
> +bool hugetlb_hgm_enabled(struct vm_area_struct *vma)
> +{
> +       struct hugetlb_shared_vma_data *data = vma->vm_private_data;
> +
> +       if (!vma || !(vma->vm_flags & VM_MAYSHARE))
> +               return false;
> +
> +       return data && data->hgm_enabled;

Don't you need to lock data->vma_lock before you access data? Or did I
misunderstand the locking? Or are you assuming this is safe before
hgm_enabled can't be disabled?
> +}
> +
> +/*
> + * Enable high-granularity mapping (HGM) for this VMA. Once enabled, HGM
> + * cannot be turned off.
> + *
> + * PMDs cannot be shared in HGM VMAs.
> + */
> +int enable_hugetlb_hgm(struct vm_area_struct *vma)
> +{
> +       int ret;
> +       struct hugetlb_shared_vma_data *data;
> +
> +       if (!hugetlb_hgm_eligible(vma))
> +               return -EINVAL;
> +
> +       if (hugetlb_hgm_enabled(vma))
> +               return 0;
> +
> +       /*
> +        * We must hold the mmap lock for writing so that callers can rely on
> +        * hugetlb_hgm_enabled returning a consistent result while holding
> +        * the mmap lock for reading.
> +        */
> +       mmap_assert_write_locked(vma->vm_mm);
> +
> +       /* HugeTLB HGM requires the VMA lock to synchronize collapsing. */
> +       ret = hugetlb_vma_data_alloc(vma);

Confused we need to vma_data_alloc() here. Shouldn't this be done by
hugetlb_vm_op_open()?

> +       if (ret)
> +               return ret;
> +
> +       data = vma->vm_private_data;
> +       BUG_ON(!data);
> +       data->hgm_enabled = true;
> +
> +       /* We don't support PMD sharing with HGM. */
> +       hugetlb_unshare_all_pmds(vma);
> +       return 0;
> +}
> +#endif /* CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING */
> +
>  /*
>   * These functions are overwritable if your architecture needs its own
>   * behavior.
> --
> 2.38.0.135.g90850a2211-goog
>

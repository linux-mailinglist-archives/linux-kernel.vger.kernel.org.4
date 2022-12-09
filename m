Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2106485B8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiLIPlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiLIPlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:41:40 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6061B1A817
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 07:41:38 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so117160wmb.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 07:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zLl4Tz9dOxODdkz805/Ivhudgy+WqekBga7RITekvs0=;
        b=feC9CFwS0Yiuqn3p/A3RGjuWnRA9669IU/0/uzpCLL70yZ9pTra2n57v6GDb73pzdM
         bKtVnBSeXqDuwkhZayfoVJO5HfHoqpUJd9jmYhO8knmEccpqfYzVuceNJu6P8OwkCJcq
         P/rjNhPDzp2RoH56JsWnRjSSanSqDLHaogGwa5CKxAmuSbYIClvX9YtBhTkI55fxayAx
         fDPXz4s6sBKRQw0HYvm+X19SZWRRprgNwgOxsMR2eViYi6Ibsd9f7GGVP8XHisZgj5WP
         pwNkWRat8aoDtNtnM9p1LCmn+pejNEKlJoW9o5DQ7gB9oLBeMmIVHMOYgi4laYZvv/Ph
         XtQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zLl4Tz9dOxODdkz805/Ivhudgy+WqekBga7RITekvs0=;
        b=vupf8KD840yQFfEv0iC0NGljx7s1LGn8z78TOPFBKD56X6gSqFFc9inLAeELlPG853
         xWJ5fridM+/1VjsgFZShackHheKnFfRTeHlfZdCVp4SALGzELW/HpDFpYFTexawqcN3Y
         hPEW6/T5kfX/eE9jf0heEkr04R/dUlTEorChiP/ZrEZVmwIkKhWVPrCZPU2fpF13JLIf
         FP2usoeO5jLGTB6/KW08N2b25wF3WmAhyhsoOCwMgy5Dlq+QYUc+Azekrd/VAkaaspvW
         su2Wakj0YmZYgn6Kr05JPppfnWnl7iUH8GbO3a63EnMRJq822YNWNN/3bP4OSkhurrL0
         B96g==
X-Gm-Message-State: ANoB5pk0vYFexeYmdJcZPmoVBgZYP8jYCtC7bdlc4PN1H+maWN3DQEmZ
        JYYzH7ZNu8/A1HHY+O6OokntYcL8scZCOGAA3XsI3A==
X-Google-Smtp-Source: AA0mqf5ghm4O86DURsnNnI21lgPhQIY7jhcggNQ9RFoccdgwQ2nVJocTrTVPIRbJWii1x6VANb8KhVvy1gEc3URiSoo=
X-Received: by 2002:a05:600c:5124:b0:3cf:878c:6555 with SMTP id
 o36-20020a05600c512400b003cf878c6555mr58256487wms.38.1670600496778; Fri, 09
 Dec 2022 07:41:36 -0800 (PST)
MIME-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-9-jthoughton@google.com> <CAHS8izOkzpRY+Q1dVxFp1Yu67O4S-CXMe2rg8sYCC+izyhSj3g@mail.gmail.com>
In-Reply-To: <CAHS8izOkzpRY+Q1dVxFp1Yu67O4S-CXMe2rg8sYCC+izyhSj3g@mail.gmail.com>
From:   James Houghton <jthoughton@google.com>
Date:   Fri, 9 Dec 2022 10:41:24 -0500
Message-ID: <CADrL8HXDZyaWD9_9zO9r0ExH4uUrH7mazQBa5bXgEdXQ9a5pZA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 08/47] hugetlb: add HGM enablement functions
To:     Mina Almasry <almasrymina@google.com>
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

On Wed, Dec 7, 2022 at 7:26 PM Mina Almasry <almasrymina@google.com> wrote:
>
> On Fri, Oct 21, 2022 at 9:37 AM James Houghton <jthoughton@google.com> wrote:
> >
> > Currently it is possible for all shared VMAs to use HGM, but it must be
> > enabled first. This is because with HGM, we lose PMD sharing, and page
> > table walks require additional synchronization (we need to take the VMA
> > lock).
> >
> > Signed-off-by: James Houghton <jthoughton@google.com>
> > ---
> >  include/linux/hugetlb.h | 22 +++++++++++++
> >  mm/hugetlb.c            | 69 +++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 91 insertions(+)
> >
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index 534958499ac4..6e0c36b08a0c 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -123,6 +123,9 @@ struct hugetlb_vma_lock {
> >
> >  struct hugetlb_shared_vma_data {
> >         struct hugetlb_vma_lock vma_lock;
> > +#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
> > +       bool hgm_enabled;
> > +#endif
> >  };
> >
> >  extern struct resv_map *resv_map_alloc(void);
> > @@ -1179,6 +1182,25 @@ static inline void hugetlb_unregister_node(struct node *node)
> >  }
> >  #endif /* CONFIG_HUGETLB_PAGE */
> >
> > +#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
> > +bool hugetlb_hgm_enabled(struct vm_area_struct *vma);
> > +bool hugetlb_hgm_eligible(struct vm_area_struct *vma);
> > +int enable_hugetlb_hgm(struct vm_area_struct *vma);
> > +#else
> > +static inline bool hugetlb_hgm_enabled(struct vm_area_struct *vma)
> > +{
> > +       return false;
> > +}
> > +static inline bool hugetlb_hgm_eligible(struct vm_area_struct *vma)
> > +{
> > +       return false;
> > +}
> > +static inline int enable_hugetlb_hgm(struct vm_area_struct *vma)
> > +{
> > +       return -EINVAL;
> > +}
> > +#endif
> > +
> >  static inline spinlock_t *huge_pte_lock(struct hstate *h,
> >                                         struct mm_struct *mm, pte_t *pte)
> >  {
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 5ae8bc8c928e..a18143add956 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -6840,6 +6840,10 @@ static bool pmd_sharing_possible(struct vm_area_struct *vma)
> >  #ifdef CONFIG_USERFAULTFD
> >         if (uffd_disable_huge_pmd_share(vma))
> >                 return false;
> > +#endif
> > +#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
> > +       if (hugetlb_hgm_enabled(vma))
> > +               return false;
> >  #endif
> >         /*
> >          * Only shared VMAs can share PMDs.
> > @@ -7033,6 +7037,9 @@ static int hugetlb_vma_data_alloc(struct vm_area_struct *vma)
> >         kref_init(&data->vma_lock.refs);
> >         init_rwsem(&data->vma_lock.rw_sema);
> >         data->vma_lock.vma = vma;
> > +#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
> > +       data->hgm_enabled = false;
> > +#endif
> >         vma->vm_private_data = data;
> >         return 0;
> >  }
> > @@ -7290,6 +7297,68 @@ __weak unsigned long hugetlb_mask_last_page(struct hstate *h)
> >
> >  #endif /* CONFIG_ARCH_WANT_GENERAL_HUGETLB */
> >
> > +#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
> > +bool hugetlb_hgm_eligible(struct vm_area_struct *vma)
> > +{
> > +       /*
> > +        * All shared VMAs may have HGM.
> > +        *
> > +        * HGM requires using the VMA lock, which only exists for shared VMAs.
> > +        * To make HGM work for private VMAs, we would need to use another
> > +        * scheme to prevent collapsing/splitting from invalidating other
> > +        * threads' page table walks.
> > +        */
> > +       return vma && (vma->vm_flags & VM_MAYSHARE);
> > +}
> > +bool hugetlb_hgm_enabled(struct vm_area_struct *vma)
> > +{
> > +       struct hugetlb_shared_vma_data *data = vma->vm_private_data;
> > +
> > +       if (!vma || !(vma->vm_flags & VM_MAYSHARE))
> > +               return false;
> > +
> > +       return data && data->hgm_enabled;
>
> Don't you need to lock data->vma_lock before you access data? Or did I
> misunderstand the locking? Or are you assuming this is safe before
> hgm_enabled can't be disabled?

This should be protected by the mmap_lock (we must be holding it for
at least reading here). `data` and `data->hgm_enabled` are only
changed when holding the mmap_lock for writing.

> > +}
> > +
> > +/*
> > + * Enable high-granularity mapping (HGM) for this VMA. Once enabled, HGM
> > + * cannot be turned off.
> > + *
> > + * PMDs cannot be shared in HGM VMAs.
> > + */
> > +int enable_hugetlb_hgm(struct vm_area_struct *vma)
> > +{
> > +       int ret;
> > +       struct hugetlb_shared_vma_data *data;
> > +
> > +       if (!hugetlb_hgm_eligible(vma))
> > +               return -EINVAL;
> > +
> > +       if (hugetlb_hgm_enabled(vma))
> > +               return 0;
> > +
> > +       /*
> > +        * We must hold the mmap lock for writing so that callers can rely on
> > +        * hugetlb_hgm_enabled returning a consistent result while holding
> > +        * the mmap lock for reading.
> > +        */
> > +       mmap_assert_write_locked(vma->vm_mm);
> > +
> > +       /* HugeTLB HGM requires the VMA lock to synchronize collapsing. */
> > +       ret = hugetlb_vma_data_alloc(vma);
>
> Confused we need to vma_data_alloc() here. Shouldn't this be done by
> hugetlb_vm_op_open()?

hugetlb_vma_data_alloc() can fail. In hugetlb_vm_op_open()/other
places, it is allowed to fail, and so we call it again here and check
that it succeeded so that we can rely on the VMA lock.

I think I need to be a little bit more careful with how I handle VMA
splitting, though. It's possible for `data` not to be allocated after
we split, but for some things to be mapped at high-granularity. The
easiest solution here would be to disallow splitting when HGM is
enabled; not sure what the best solution is though.

Thanks for the review, Mina!

>
> > +       if (ret)
> > +               return ret;
> > +
> > +       data = vma->vm_private_data;
> > +       BUG_ON(!data);
> > +       data->hgm_enabled = true;
> > +
> > +       /* We don't support PMD sharing with HGM. */
> > +       hugetlb_unshare_all_pmds(vma);
> > +       return 0;
> > +}
> > +#endif /* CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING */
> > +
> >  /*
> >   * These functions are overwritable if your architecture needs its own
> >   * behavior.
> > --
> > 2.38.0.135.g90850a2211-goog
> >

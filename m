Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD6B64B8F3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 16:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236400AbiLMPur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 10:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236250AbiLMPuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 10:50:25 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86C520350
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 07:49:46 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso8216444wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 07:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o9kFpXuzONo5WfFJhHdY1vfPliyKhz64NkftA0VbzIU=;
        b=PksSkxrWN4UAEULYAAd4Zdi5WDuvmW2CIu0Uq7fTv8r8dLTdXGB2dpeJDur837ytD5
         bdA1bPhwc+Ka2ENRK7qxYEZxonj45dm2Owngi6/PvWal7q9iPap1vJFMQxP23qZzykwt
         lStBthwsEQv1HJ/AgzwcsIbJr8c6neYNVdQVOH8T4qYodlfxFImqSeAbvRv1fkc9HVBN
         g23N+ABaz/XlKbGy1m8xypLen0jQC12qZ4VebPUh/JouQLT65UhBKAXiZGb+ETVxLgwg
         O5Eq1pcPrHHjwy4vdWS6y3PHQueRvDbWaLermcY8OML7LWTwORlL8Sr4H5GJUY98l50z
         +doA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o9kFpXuzONo5WfFJhHdY1vfPliyKhz64NkftA0VbzIU=;
        b=OqEO++Q/tIrGIe8QX5Z6KsX10HKG7H8RJ3hHLZAu9y/p2/KPeBbvYQi5akW2KZkvdk
         PfGfJmh75xfX4F+iIimSdFrjP5xCFuKqytLk7n64vmVpssaVmhmDRa/lK4uS4xxUPDts
         7vcoXNnEG5AYv2fhR4R5elNdveOL5RgCnqrabVsdWjZVoocMdcqIN4Ft8Rel87VPvUbA
         nmboBGUzZ109X4tmIteQs+cKoEoSxZi/kpCkrR7L1ryp7N6HQPmE/WK7DBA0hyE8yuO3
         urdRgFP8zO3G+BsTHoVWoy/u+kePaDWHK4w4wNVA+P2VQwhsD+sTq7lzF4gaZOJTVg+K
         AqCQ==
X-Gm-Message-State: ANoB5plLGxqaVWUjLC+4rT0y9JEuPxOfyLSGaUs/MjJAEJ20IdDJlr1R
        w/KrRjuiiKt7P6HZlx58cgOm6Aq1PUlNYArKR8qTqA==
X-Google-Smtp-Source: AA0mqf6ppNThFTBNn9ZHIYELungBtIrwRugkAdT0qFrgmhCzdoYC1C6GNtA/Ji1tuNONGI8QnOL0Dv3H2cHQVn+JPyg=
X-Received: by 2002:a05:600c:3d1b:b0:3cf:f2aa:3dc2 with SMTP id
 bh27-20020a05600c3d1b00b003cff2aa3dc2mr199655wmb.175.1670946585123; Tue, 13
 Dec 2022 07:49:45 -0800 (PST)
MIME-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-9-jthoughton@google.com> <Y5fDwH6XiM808oUM@monkey>
In-Reply-To: <Y5fDwH6XiM808oUM@monkey>
From:   James Houghton <jthoughton@google.com>
Date:   Tue, 13 Dec 2022 10:49:32 -0500
Message-ID: <CADrL8HU9sQuh_W3Qx4dvGV44VLYNbt300cpWLU--BqLo3Xxgpw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 08/47] hugetlb: add HGM enablement functions
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
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

On Mon, Dec 12, 2022 at 7:14 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 10/21/22 16:36, James Houghton wrote:
> > Currently it is possible for all shared VMAs to use HGM, but it must be
> > enabled first. This is because with HGM, we lose PMD sharing, and page
> > table walks require additional synchronization (we need to take the VMA
> > lock).
>
> Not sure yet, but I expect Peter's series will help with locking for
> hugetlb specific page table walks.

It should make things a little bit cleaner in this series; I'll rebase
HGM on top of those patches this week (and hopefully get a v1 out
soon).

I don't think it's possible to implement MADV_COLLAPSE with RCU alone
(as implemented in Peter's series anyway); we still need the VMA lock.

>
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
> >       struct hugetlb_vma_lock vma_lock;
> > +#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
> > +     bool hgm_enabled;
> > +#endif
> >  };
> >
> >  extern struct resv_map *resv_map_alloc(void);
> > @@ -1179,6 +1182,25 @@ static inline void hugetlb_unregister_node(struct node *node)
> >  }
> >  #endif       /* CONFIG_HUGETLB_PAGE */
> >
> > +#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
> > +bool hugetlb_hgm_enabled(struct vm_area_struct *vma);
> > +bool hugetlb_hgm_eligible(struct vm_area_struct *vma);
> > +int enable_hugetlb_hgm(struct vm_area_struct *vma);
> > +#else
> > +static inline bool hugetlb_hgm_enabled(struct vm_area_struct *vma)
> > +{
> > +     return false;
> > +}
> > +static inline bool hugetlb_hgm_eligible(struct vm_area_struct *vma)
> > +{
> > +     return false;
> > +}
> > +static inline int enable_hugetlb_hgm(struct vm_area_struct *vma)
> > +{
> > +     return -EINVAL;
> > +}
> > +#endif
> > +
> >  static inline spinlock_t *huge_pte_lock(struct hstate *h,
> >                                       struct mm_struct *mm, pte_t *pte)
> >  {
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 5ae8bc8c928e..a18143add956 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -6840,6 +6840,10 @@ static bool pmd_sharing_possible(struct vm_area_struct *vma)
> >  #ifdef CONFIG_USERFAULTFD
> >       if (uffd_disable_huge_pmd_share(vma))
> >               return false;
> > +#endif
> > +#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
> > +     if (hugetlb_hgm_enabled(vma))
> > +             return false;
> >  #endif
> >       /*
> >        * Only shared VMAs can share PMDs.
> > @@ -7033,6 +7037,9 @@ static int hugetlb_vma_data_alloc(struct vm_area_struct *vma)
> >       kref_init(&data->vma_lock.refs);
> >       init_rwsem(&data->vma_lock.rw_sema);
> >       data->vma_lock.vma = vma;
> > +#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
> > +     data->hgm_enabled = false;
> > +#endif
> >       vma->vm_private_data = data;
> >       return 0;
> >  }
> > @@ -7290,6 +7297,68 @@ __weak unsigned long hugetlb_mask_last_page(struct hstate *h)
> >
> >  #endif /* CONFIG_ARCH_WANT_GENERAL_HUGETLB */
> >
> > +#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
> > +bool hugetlb_hgm_eligible(struct vm_area_struct *vma)
> > +{
> > +     /*
> > +      * All shared VMAs may have HGM.
> > +      *
> > +      * HGM requires using the VMA lock, which only exists for shared VMAs.
> > +      * To make HGM work for private VMAs, we would need to use another
> > +      * scheme to prevent collapsing/splitting from invalidating other
> > +      * threads' page table walks.
> > +      */
> > +     return vma && (vma->vm_flags & VM_MAYSHARE);
>
> I am not yet 100% convinced you can/will take care of all possible code
> paths where hugetlb_vma_data allocation may fail.  If not, then you
> should be checking vm_private_data here as well.

I think the check here makes sense -- if a VMA is shared, then it is
eligible for HGM, but we might fail to enable it because we can't
allocate the VMA lock. I'll reword the comment to clearly say this.

There is the problem of splitting, though: if we have high-granularity
mapped PTEs in a VMA and that VMA gets split, we need to remember that
the VMA had HGM enabled even if allocating the VMA lock fails,
otherwise things get out of sync. How does PMD sharing handle the
splitting case?

An easy way HGM could handle this is by disallowing splitting, but I
think we can do better. If we fail to allocate the VMA lock, then we
can no longer MADV_COLLAPSE safely, but everything else can proceed as
normal, and so some "hugetlb_hgm_enabled" checks can be
removed/changed. This should make things easier for when we have to
handle (some bits of) HGM for private mappings, too. I'll make some
improvements here for v1.

>
> > +}
> > +bool hugetlb_hgm_enabled(struct vm_area_struct *vma)
> > +{
> > +     struct hugetlb_shared_vma_data *data = vma->vm_private_data;
> > +
> > +     if (!vma || !(vma->vm_flags & VM_MAYSHARE))
> > +             return false;
> > +
> > +     return data && data->hgm_enabled;
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
> > +     int ret;
> > +     struct hugetlb_shared_vma_data *data;
> > +
> > +     if (!hugetlb_hgm_eligible(vma))
> > +             return -EINVAL;
> > +
> > +     if (hugetlb_hgm_enabled(vma))
> > +             return 0;
> > +
> > +     /*
> > +      * We must hold the mmap lock for writing so that callers can rely on
> > +      * hugetlb_hgm_enabled returning a consistent result while holding
> > +      * the mmap lock for reading.
> > +      */
> > +     mmap_assert_write_locked(vma->vm_mm);
> > +
> > +     /* HugeTLB HGM requires the VMA lock to synchronize collapsing. */
> > +     ret = hugetlb_vma_data_alloc(vma);
> > +     if (ret)
> > +             return ret;
> > +
> > +     data = vma->vm_private_data;
> > +     BUG_ON(!data);
>
> Would rather have hugetlb_hgm_eligible check for vm_private_data as
> suggested above instead of the BUG here.

I don't think we'd ever actually BUG() here. Please correct me if I'm
wrong, but if we are eligible for HGM, then hugetlb_vma_data_alloc()
will only succeed if we actually allocated the VMA data/lock, so
vma->vm_private_data should never be NULL (with the BUG_ON to inform
the reader). Maybe I should just drop the BUG()?

>
> --
> Mike Kravetz
>
> > +     data->hgm_enabled = true;
> > +
> > +     /* We don't support PMD sharing with HGM. */
> > +     hugetlb_unshare_all_pmds(vma);
> > +     return 0;
> > +}
> > +#endif /* CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING */
> > +
> >  /*
> >   * These functions are overwritable if your architecture needs its own
> >   * behavior.
> > --
> > 2.38.0.135.g90850a2211-goog
> >

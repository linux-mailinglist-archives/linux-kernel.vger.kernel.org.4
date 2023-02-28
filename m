Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BFE6A639C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 00:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjB1XEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 18:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjB1XEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 18:04:37 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAAE46A9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 15:04:23 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id v27so17440043vsa.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 15:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677625462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I22jj9M7JKSMnh5Uygji2ZJ3hvS0Z/zUVKIDtQjwQoo=;
        b=ptvLM6/gty88qvWxfKuckHwbPfQe4c1gZYiMuxRSo7mrVWUxQFyd8d8vEElNG/xHcO
         fJ/N7dJWi/4fKTA0t3D65ZOw7mzdffVvXS9x7Li65q1yonOlhBYhpJB/Y4SV133+H7m3
         JErDfYKGOpVSiN1jgYyBkIlHbLzDVm8qc8Z/DiRpx+ktFw6FS6Bnqmy6DchXkw56tX/r
         YeN+ZSnrU+qbSuOLdCjHNntbnT8n6iaw+78+4sKvIHBIuQ0on2Wq7z20vDlpx4ccAldm
         G57Nz9BZfMdc2ymGPEJ/gFL3Dm2QBCAlz5mjL0PnLsBYcrUU2vSqT3TE1KltPzk6bvz+
         UkJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677625462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I22jj9M7JKSMnh5Uygji2ZJ3hvS0Z/zUVKIDtQjwQoo=;
        b=UWVBPvpsP5aD2SCNuVuue+sUs+C31s6vvir0FVRAMwfzjZxxvyr3IQ9TDRzngXv2Sp
         sCYz255JmfApGTCqRc1zXJ5P3ikRVfU11eA+vnbwLglQ+RJpaYdT1HpnE5Ri2Sg6+Zuh
         znHEnhJkoWGEi7KEGTffQTTiU35kZnbqlkx/yScJnQXdkM4OgGGgV/sGHnDFyh1Oqavi
         LGoSpcf3tUo++NGaFQSkcK12mGGnv44CF7rT5XkeqIEunNvyAph4URLXX6DX3BmGlHQr
         TIkylYbGlQwLL02q4BEV38Tb/VNod+Mwexqx5Q2xE4ldJf9tKakfbrsF6OAkPHddBe1v
         47mg==
X-Gm-Message-State: AO0yUKUWgGBEUekU9bW0fYPf7CBm7GFbKngEQCHovM1hu6/mvPK1SkG7
        noGSwAIjfNo/g9EMaCQYnHhKqbt130T6x4W4B2xd+g==
X-Google-Smtp-Source: AK7set/Sfu0kk4d2y0AXNwgdbpiGYJCOs56IsuIwNbRSMGAWhk9YTTGyr8nNaXRFFsuabYk9h3eXP8ligWkb3O5O6YE=
X-Received: by 2002:a67:a641:0:b0:411:c62b:6bf0 with SMTP id
 r1-20020a67a641000000b00411c62b6bf0mr3242141vsh.3.1677625462255; Tue, 28 Feb
 2023 15:04:22 -0800 (PST)
MIME-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
 <20230218002819.1486479-14-jthoughton@google.com> <Y/58zLSFe/ygT9X/@monkey>
In-Reply-To: <Y/58zLSFe/ygT9X/@monkey>
From:   James Houghton <jthoughton@google.com>
Date:   Tue, 28 Feb 2023 15:03:46 -0800
Message-ID: <CADrL8HX4TFkah2yYbmqZRJx4pOBgXktZfMbrqMfdMkdD6LOdyA@mail.gmail.com>
Subject: Re: [PATCH v2 13/46] hugetlb: add hugetlb_hgm_walk and hugetlb_walk_step
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
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
        Frank van der Linden <fvdl@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Feb 28, 2023 at 2:15=E2=80=AFPM Mike Kravetz <mike.kravetz@oracle.c=
om> wrote:
>
> On 02/18/23 00:27, James Houghton wrote:
> > hugetlb_hgm_walk implements high-granularity page table walks for
> > HugeTLB. It is safe to call on non-HGM enabled VMAs; it will return
> > immediately.
> >
> > hugetlb_walk_step implements how we step forwards in the walk. For
> > architectures that don't use GENERAL_HUGETLB, they will need to provide
> > their own implementation.
> >
> > The broader API that should be used is
> > hugetlb_full_walk[,alloc|,continue].
>
> I guess 'full' in the name implies walking to the PTE (PAGE_SIZE) level.
> It could just be me and my over-familiarity with the existing hugetlb
> walking code, but that was not obvious.

Yeah "full" means it walks all the way down to the leaf. "alloc" means
it may allocate if required to reach some target PTE size (target_sz).

I'll try to be clearer in the comments for hugetlb_full_walk and
hugetlb_full_walk_alloc.

>
> Again, perhaps it is just how familiar I am with the existing code, but
> I found the routines difficult to follow.  Nothing looks obviously wrong.
>
> Just a couple comments.questions below.
>
> >
> > Signed-off-by: James Houghton <jthoughton@google.com>
> >
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index 9d839519c875..726d581158b1 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -223,6 +223,14 @@ u32 hugetlb_fault_mutex_hash(struct address_space =
*mapping, pgoff_t idx);
> >  pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma=
,
> >                     unsigned long addr, pud_t *pud);
> >
> > +int hugetlb_full_walk(struct hugetlb_pte *hpte, struct vm_area_struct =
*vma,
> > +                   unsigned long addr);
> > +void hugetlb_full_walk_continue(struct hugetlb_pte *hpte,
> > +                             struct vm_area_struct *vma, unsigned long=
 addr);
> > +int hugetlb_full_walk_alloc(struct hugetlb_pte *hpte,
> > +                         struct vm_area_struct *vma, unsigned long add=
r,
> > +                         unsigned long target_sz);
> > +
> >  struct address_space *hugetlb_page_mapping_lock_write(struct page *hpa=
ge);
> >
> >  extern int sysctl_hugetlb_shm_group;
> > @@ -272,6 +280,8 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct =
vm_area_struct *vma,
> >  pte_t *huge_pte_offset(struct mm_struct *mm,
> >                      unsigned long addr, unsigned long sz);
> >  unsigned long hugetlb_mask_last_page(struct hstate *h);
> > +int hugetlb_walk_step(struct mm_struct *mm, struct hugetlb_pte *hpte,
> > +                   unsigned long addr, unsigned long sz);
> >  int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
> >                               unsigned long addr, pte_t *ptep);
> >  void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
> > @@ -1054,6 +1064,8 @@ void hugetlb_register_node(struct node *node);
> >  void hugetlb_unregister_node(struct node *node);
> >  #endif
> >
> > +enum hugetlb_level hpage_size_to_level(unsigned long sz);
> > +
> >  #else        /* CONFIG_HUGETLB_PAGE */
> >  struct hstate {};
> >
> > @@ -1246,6 +1258,11 @@ static inline void hugetlb_register_node(struct =
node *node)
> >  static inline void hugetlb_unregister_node(struct node *node)
> >  {
> >  }
> > +
> > +static inline enum hugetlb_level hpage_size_to_level(unsigned long sz)
> > +{
> > +     return HUGETLB_LEVEL_PTE;
> > +}
> >  #endif       /* CONFIG_HUGETLB_PAGE */
> >
> >  #ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index bb424cdf79e4..810c05feb41f 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -97,6 +97,29 @@ static void __hugetlb_vma_unlock_write_free(struct v=
m_area_struct *vma);
> >  static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
> >               unsigned long start, unsigned long end);
> >
> > +/*
> > + * hpage_size_to_level() - convert @sz to the corresponding page table=
 level
> > + *
> > + * @sz must be less than or equal to a valid hugepage size.
> > + */
> > +enum hugetlb_level hpage_size_to_level(unsigned long sz)
> > +{
> > +     /*
> > +      * We order the conditionals from smallest to largest to pick the
> > +      * smallest level when multiple levels have the same size (i.e.,
> > +      * when levels are folded).
> > +      */
> > +     if (sz < PMD_SIZE)
> > +             return HUGETLB_LEVEL_PTE;
> > +     if (sz < PUD_SIZE)
> > +             return HUGETLB_LEVEL_PMD;
> > +     if (sz < P4D_SIZE)
> > +             return HUGETLB_LEVEL_PUD;
> > +     if (sz < PGDIR_SIZE)
> > +             return HUGETLB_LEVEL_P4D;
> > +     return HUGETLB_LEVEL_PGD;
> > +}
> > +
> >  static inline bool subpool_is_free(struct hugepage_subpool *spool)
> >  {
> >       if (spool->count)
> > @@ -7315,6 +7338,154 @@ bool want_pmd_share(struct vm_area_struct *vma,=
 unsigned long addr)
> >  }
> >  #endif /* CONFIG_ARCH_WANT_HUGE_PMD_SHARE */
> >
> > +/* __hugetlb_hgm_walk - walks a high-granularity HugeTLB page table to=
 resolve
> > + * the page table entry for @addr. We might allocate new PTEs.
> > + *
> > + * @hpte must always be pointing at an hstate-level PTE or deeper.
> > + *
> > + * This function will never walk further if it encounters a PTE of a s=
ize
> > + * less than or equal to @sz.
> > + *
> > + * @alloc determines what we do when we encounter an empty PTE. If fal=
se,
> > + * we stop walking. If true and @sz is less than the current PTE's siz=
e,
> > + * we make that PTE point to the next level down, going until @sz is t=
he same
> > + * as our current PTE.
> > + *
> > + * If @alloc is false and @sz is PAGE_SIZE, this function will always
> > + * succeed, but that does not guarantee that hugetlb_pte_size(hpte) is=
 @sz.
> > + *
> > + * Return:
> > + *   -ENOMEM if we couldn't allocate new PTEs.
> > + *   -EEXIST if the caller wanted to walk further than a migration PTE=
,
> > + *           poison PTE, or a PTE marker. The caller needs to manually=
 deal
> > + *           with this scenario.
> > + *   -EINVAL if called with invalid arguments (@sz invalid, @hpte not
> > + *           initialized).
> > + *   0 otherwise.
> > + *
> > + *   Even if this function fails, @hpte is guaranteed to always remain
> > + *   valid.
> > + */
> > +static int __hugetlb_hgm_walk(struct mm_struct *mm, struct vm_area_str=
uct *vma,
> > +                           struct hugetlb_pte *hpte, unsigned long add=
r,
> > +                           unsigned long sz, bool alloc)
> > +{
> > +     int ret =3D 0;
> > +     pte_t pte;
> > +
> > +     if (WARN_ON_ONCE(sz < PAGE_SIZE))
> > +             return -EINVAL;
> > +
> > +     if (WARN_ON_ONCE(!hpte->ptep))
> > +             return -EINVAL;
> > +
> > +     while (hugetlb_pte_size(hpte) > sz && !ret) {
> > +             pte =3D huge_ptep_get(hpte->ptep);
> > +             if (!pte_present(pte)) {
> > +                     if (!alloc)
> > +                             return 0;
> > +                     if (unlikely(!huge_pte_none(pte)))
> > +                             return -EEXIST;
> > +             } else if (hugetlb_pte_present_leaf(hpte, pte))
> > +                     return 0;
> > +             ret =3D hugetlb_walk_step(mm, hpte, addr, sz);
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> > +/*
> > + * hugetlb_hgm_walk - Has the same behavior as __hugetlb_hgm_walk but =
will
> > + * initialize @hpte with hstate-level PTE pointer @ptep.
> > + */
> > +static int hugetlb_hgm_walk(struct hugetlb_pte *hpte,
> > +                         pte_t *ptep,
> > +                         struct vm_area_struct *vma,
> > +                         unsigned long addr,
> > +                         unsigned long target_sz,
> > +                         bool alloc)
> > +{
> > +     struct hstate *h =3D hstate_vma(vma);
> > +
> > +     hugetlb_pte_init(vma->vm_mm, hpte, ptep, huge_page_shift(h),
> > +                      hpage_size_to_level(huge_page_size(h)));
> > +     return __hugetlb_hgm_walk(vma->vm_mm, vma, hpte, addr, target_sz,
> > +                               alloc);
> > +}
> > +
> > +/*
> > + * hugetlb_full_walk_continue - continue a high-granularity page-table=
 walk.
> > + *
> > + * If a user has a valid @hpte but knows that @hpte is not a leaf, the=
y can
> > + * attempt to continue walking by calling this function.
> > + *
> > + * This function will never fail, but @hpte might not change.
> > + *
> > + * If @hpte hasn't been initialized, then this function's behavior is
> > + * undefined.
> > + */
> > +void hugetlb_full_walk_continue(struct hugetlb_pte *hpte,
> > +                             struct vm_area_struct *vma,
> > +                             unsigned long addr)
> > +{
> > +     /* __hugetlb_hgm_walk will never fail with these arguments. */
> > +     WARN_ON_ONCE(__hugetlb_hgm_walk(vma->vm_mm, vma, hpte, addr,
> > +                                     PAGE_SIZE, false));
> > +}
> > +
> > +/*
> > + * hugetlb_full_walk - do a high-granularity page-table walk; never al=
locate.
> > + *
> > + * This function can only fail if we find that the hstate-level PTE is=
 not
> > + * allocated. Callers can take advantage of this fact to skip address =
regions
> > + * that cannot be mapped in that case.
> > + *
> > + * If this function succeeds, @hpte is guaranteed to be valid.
> > + */
> > +int hugetlb_full_walk(struct hugetlb_pte *hpte,
> > +                   struct vm_area_struct *vma,
> > +                   unsigned long addr)
> > +{
> > +     struct hstate *h =3D hstate_vma(vma);
> > +     unsigned long sz =3D huge_page_size(h);
> > +     /*
> > +      * We must mask the address appropriately so that we pick up the =
first
> > +      * PTE in a contiguous group.
> > +      */
> > +     pte_t *ptep =3D hugetlb_walk(vma, addr & huge_page_mask(h), sz);
> > +
> > +     if (!ptep)
> > +             return -ENOMEM;
>
> -ENOMEM does not seem appropriate, but I can not think of something
> better.  -ENOENT perhaps?

The callers only ever check if hugetlb_full_walk() is 0 or not, so
returning 1 here could be a fine solution too. What do you think?

>
> > +
> > +     /* hugetlb_hgm_walk will never fail with these arguments. */
> > +     WARN_ON_ONCE(hugetlb_hgm_walk(hpte, ptep, vma, addr, PAGE_SIZE, f=
alse));
> > +     return 0;
> > +}
> > +
> > +/*
> > + * hugetlb_full_walk_alloc - do a high-granularity walk, potentially a=
llocate
> > + *   new PTEs.
> > + */
> > +int hugetlb_full_walk_alloc(struct hugetlb_pte *hpte,
> > +                                struct vm_area_struct *vma,
> > +                                unsigned long addr,
> > +                                unsigned long target_sz)
> > +{
> > +     struct hstate *h =3D hstate_vma(vma);
> > +     unsigned long sz =3D huge_page_size(h);
> > +     /*
> > +      * We must mask the address appropriately so that we pick up the =
first
> > +      * PTE in a contiguous group.
> > +      */
> > +     pte_t *ptep =3D huge_pte_alloc(vma->vm_mm, vma, addr & huge_page_=
mask(h),
> > +                                  sz);
> > +
> > +     if (!ptep)
> > +             return -ENOMEM;
> > +
> > +     return hugetlb_hgm_walk(hpte, ptep, vma, addr, target_sz, true);
> > +}
> > +
> >  #ifdef CONFIG_ARCH_WANT_GENERAL_HUGETLB
> >  pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma=
,
> >                       unsigned long addr, unsigned long sz)
> > @@ -7382,6 +7553,48 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
> >       return (pte_t *)pmd;
> >  }
> >
> > +/*
> > + * hugetlb_walk_step() - Walk the page table one step to resolve the p=
age
> > + * (hugepage or subpage) entry at address @addr.
> > + *
> > + * @sz always points at the final target PTE size (e.g. PAGE_SIZE for =
the
> > + * lowest level PTE).
> > + *
> > + * @hpte will always remain valid, even if this function fails.
> > + *
> > + * Architectures that implement this function must ensure that if @hpt=
e does
> > + * not change levels, then its PTL must also stay the same.
> > + */
> > +int hugetlb_walk_step(struct mm_struct *mm, struct hugetlb_pte *hpte,
> > +                   unsigned long addr, unsigned long sz)
> > +{
> > +     pte_t *ptep;
> > +     spinlock_t *ptl;
> > +
> > +     switch (hpte->level) {
> > +     case HUGETLB_LEVEL_PUD:
> > +             ptep =3D (pte_t *)hugetlb_alloc_pmd(mm, hpte, addr);
> > +             if (IS_ERR(ptep))
> > +                     return PTR_ERR(ptep);
> > +             hugetlb_pte_init(mm, hpte, ptep, PMD_SHIFT,
> > +                              HUGETLB_LEVEL_PMD);
> > +             break;
> > +     case HUGETLB_LEVEL_PMD:
> > +             ptep =3D hugetlb_alloc_pte(mm, hpte, addr);
> > +             if (IS_ERR(ptep))
> > +                     return PTR_ERR(ptep);
> > +             ptl =3D pte_lockptr(mm, (pmd_t *)hpte->ptep);
>
> Is that right?  hpte->ptep is the PMD level entry.  It seems
> pte_lockptr() -> ptlock_ptr(pmd_page(*pmd)) -> return page->ptl
> But, I would think we want the page mm->page_table_lock for newly
> allocated PTE.

If we used mm->page_table_lock for 4K PTEs, that would be a
performance nightmare (right?). The PTL we set here will be used for
page faults, UFFDIO_CONTINUEs, etc.

This code should be right. It's doing:
(1) Overwrite our leaf-level PMD with a non-leaf PMD (returning the 4K
PTE we should populate the hpte with).
(2) Find the PTL for the non-leaf PMD (the same way that generic mm does).
(3) Update hpte to point to the PTE we are supposed to use.

It's really important that (2) happens after (1), otherwise pmd_page()
won't be pointing to a page table page (and will change shortly), so
ptlock_ptr() won't give us what we want.

This is probably worth a comment; I'll write something like this here.

Thanks Mike. Hopefully the rest of the series isn't too confusing.

- James

>
> --
> Mike Kravetz
>
> > +             __hugetlb_pte_init(hpte, ptep, PAGE_SHIFT,
> > +                                HUGETLB_LEVEL_PTE, ptl);
> > +             break;
> > +     default:
> > +             WARN_ONCE(1, "%s: got invalid level: %d (shift: %d)\n",
> > +                             __func__, hpte->level, hpte->shift);
> > +             return -EINVAL;
> > +     }
> > +     return 0;
> > +}
> > +
> >  /*
> >   * Return a mask that can be used to update an address to the last hug=
e
> >   * page in a page table page mapping size.  Used to skip non-present
> > --
> > 2.39.2.637.g21b0678d19-goog
> >

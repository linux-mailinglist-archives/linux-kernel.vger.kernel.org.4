Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30CD96AFB5D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 01:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjCHAik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 19:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjCHAiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 19:38:20 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B047305F7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 16:38:00 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id s1so14000542vsk.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 16:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678235848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HrJguA7nWzVBA3E1N//Y+8ZkAi0kj8Hhxx5ESwehlHk=;
        b=ltrNKvga/FciNkt8pnc5XRcNWEdwZgzoW9hK8ViSk9TbX9mh6mHAEvpjdlMw/XaVN7
         VpxXh3OU3cwNzcdzQOPDuX3k78ZkxU7cQIXd8Y7C41kw6lebENu2Ud293gjBckcEstEh
         52aaJzsA5Uf6rtKQax5WF8ntRBomyhlnYpw5tn9cezqnnMHaV3TdKoUiiOaTZzFoQ200
         qT2v3cS8B7LVftxEmbM5qaK382B7tB1TTEOPGeztDZej1FkhWiLerIq6RhXvd5dU0KmI
         EFTqtX1qvkG8D+aoJ2iwIzqm81QKMqBApwCd0Z2jaceLyv2tjPYheGQvPT0XSkF5LKZb
         0kDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678235848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HrJguA7nWzVBA3E1N//Y+8ZkAi0kj8Hhxx5ESwehlHk=;
        b=psF0vBRv3erd6ctwqz71dxptYwoDYc6cdeXfyL7tTXKWXBDoZkJzKR4n3U9O1uQj71
         W8+Q2lKXs89i/k8pELKesRqLUl/ZRA3LNkBxj99Z+F0fpPumGopW2oc54wtO1Eqlm4Tk
         RwPkAD5M60JeCJGJhPqhZ3dbg41fg1vduYUDEjRQaFbmd638E58v8XUO+8P0F6Gb4hPE
         CQx2FIy5KeUHcECJ62DhynWZdxlaBFoRc0eBDAtlyAKeq6aSqhgdYCzi9VwwluBorg0x
         9tvcvZI2/iFH4Pd3WH2uB4W5OdHShQxBy6DOBjxYoWYcpI1gUTleZRcpuck1cVh4TGcy
         /3ug==
X-Gm-Message-State: AO0yUKUSW6zrfeufZxqt0SxJYltfml6N6xSmzUUPPHdE6I0Wa0vaaA+q
        jmBov12NvkSzHLxAsN1m7yRHlNG/gf0EDZ5WIhgGRw==
X-Google-Smtp-Source: AK7set9asn869gPJ+4RN7FAKnvLYMXIAou/RevB42k8mUIYjX1srLeKeYof/1UjEHj1xPg2CBsXFnpn2mXYH5Q38dxU=
X-Received: by 2002:a67:f254:0:b0:402:9b84:1be5 with SMTP id
 y20-20020a67f254000000b004029b841be5mr10830369vsm.7.1678235848046; Tue, 07
 Mar 2023 16:37:28 -0800 (PST)
MIME-Version: 1.0
References: <20230306230004.1387007-1-jthoughton@google.com>
 <20230306230004.1387007-2-jthoughton@google.com> <20230307215420.GA59222@monkey>
In-Reply-To: <20230307215420.GA59222@monkey>
From:   James Houghton <jthoughton@google.com>
Date:   Tue, 7 Mar 2023 16:36:51 -0800
Message-ID: <CADrL8HVa3vzmrfFJD5hx_GuXVnsWhSo9hzJFb4TTzzjMhWG+sQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: rmap: make hugetlb pages participate in _nr_pages_mapped
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
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

On Tue, Mar 7, 2023 at 1:54=E2=80=AFPM Mike Kravetz <mike.kravetz@oracle.co=
m> wrote:
>
> On 03/06/23 23:00, James Houghton wrote:
> > For compound mappings (compound=3Dtrue), _nr_pages_mapped will now be
> > incremented by COMPOUND_MAPPED when the first compound mapping is
> > created.
>
> This sentence makes it sound like incrementing by COMPOUND_MAPPED for
> compound pages is introduced by this patch.  Rather, it is just for
> hugetlb (now always) compound mappings.   Perhaps change that to read:
> For hugetlb mappings ...

Yes this is kind of confusing. I'll fix it like you suggest.

>
> > For small mappings, _nr_pages_mapped is incremented by 1 when the
> > particular small page is mapped for the first time. This is incompatibl=
e
> > with HPageVmemmapOptimize()ed folios, as most of the tail page structs
> > will be mapped read-only.
> >
> > Currently HugeTLB always passes compound=3Dtrue, but in the future,
> > HugeTLB pages may be mapped with small mappings.
> >
> > To implement this change:
> >  1. Replace most of HugeTLB's calls to page_dup_file_rmap() with
> >     page_add_file_rmap(). The call in copy_hugetlb_page_range() is kept=
.
> >  2. Update page_add_file_rmap() and page_remove_rmap() to support
> >     HugeTLB folios.
> >  3. Update hugepage_add_anon_rmap() and hugepage_add_new_anon_rmap() to
> >     also increment _nr_pages_mapped properly.
> >
> > With these changes, folio_large_is_mapped() no longer needs to check
> > _entire_mapcount.
> >
> > HugeTLB doesn't use LRU or mlock, so page_add_file_rmap() and
> > page_remove_rmap() excludes those pieces. It is also important that
> > the folio_test_pmd_mappable() check is removed (or changed), as it's
> > possible to have a HugeTLB page whose order is not >=3D HPAGE_PMD_ORDER=
,
> > like arm64's CONT_PTE_SIZE HugeTLB pages.
> >
> > This patch limits HugeTLB pages to 16G in size. That limit can be
> > increased if COMPOUND_MAPPED is raised.
> >
> > Signed-off-by: James Houghton <jthoughton@google.com>
> >
>
> Thanks!
>
> This is a step in the direction of having hugetlb use the same mapcount
> scheme as elsewhere.  As you mention, with this in place future mapcount
> changes should mostly 'just work' for hugetlb.
>
> Because of this,
> Acked-by: Mike Kravetz <mike.kravetz@oracle.com>

Thanks!

>
> I have a few nits below, and I'm sure others will chime in later.
>
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index ba901c416785..4a975429b91a 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -1316,19 +1316,21 @@ void page_add_file_rmap(struct page *page, stru=
ct vm_area_struct *vma,
> >       int nr =3D 0, nr_pmdmapped =3D 0;
> >       bool first;
> >
> > -     VM_BUG_ON_PAGE(compound && !PageTransHuge(page), page);
> > +     VM_BUG_ON_PAGE(compound && !PageTransHuge(page)
> > +                             && !folio_test_hugetlb(folio), page);
> >
> >       /* Is page being mapped by PTE? Is this its first map to be added=
? */
> >       if (likely(!compound)) {
> > +             if (unlikely(folio_test_hugetlb(folio)))
> > +                     VM_BUG_ON_PAGE(HPageVmemmapOptimized(&folio->page=
),
> > +                                    page);
> >               first =3D atomic_inc_and_test(&page->_mapcount);
> >               nr =3D first;
> >               if (first && folio_test_large(folio)) {
> >                       nr =3D atomic_inc_return_relaxed(mapped);
> >                       nr =3D (nr < COMPOUND_MAPPED);
> >               }
> > -     } else if (folio_test_pmd_mappable(folio)) {
> > -             /* That test is redundant: it's for safety or to optimize=
 out */
>
> I 'think' removing this check is OK.  It would seem that the caller
> knows if the folio is mappable.  If we want a similar test, we might be
> able to use something like:
>
>         arch_hugetlb_valid_size(folio_size(folio))
>

Ack. I think leaving the check(s) removed is fine.

> > -
> > +     } else {
> >               first =3D atomic_inc_and_test(&folio->_entire_mapcount);
> >               if (first) {
> >                       nr =3D atomic_add_return_relaxed(COMPOUND_MAPPED,=
 mapped);
> > @@ -1345,6 +1347,9 @@ void page_add_file_rmap(struct page *page, struct=
 vm_area_struct *vma,
> >               }
> >       }
> >
> > +     if (folio_test_hugetlb(folio))
> > +             return;
>
> IMO, a comment saying hugetlb is special and does not participate in lru
> would be appropriate here.

Will do.

>
> > +
> >       if (nr_pmdmapped)
> >               __lruvec_stat_mod_folio(folio, folio_test_swapbacked(foli=
o) ?
> >                       NR_SHMEM_PMDMAPPED : NR_FILE_PMDMAPPED, nr_pmdmap=
ped);
> > @@ -1373,24 +1378,18 @@ void page_remove_rmap(struct page *page, struct=
 vm_area_struct *vma,
> >
> >       VM_BUG_ON_PAGE(compound && !PageHead(page), page);
> >
> > -     /* Hugetlb pages are not counted in NR_*MAPPED */
> > -     if (unlikely(folio_test_hugetlb(folio))) {
> > -             /* hugetlb pages are always mapped with pmds */
> > -             atomic_dec(&folio->_entire_mapcount);
> > -             return;
> > -     }
> > -
> >       /* Is page being unmapped by PTE? Is this its last map to be remo=
ved? */
> >       if (likely(!compound)) {
> > +             if (unlikely(folio_test_hugetlb(folio)))
> > +                     VM_BUG_ON_PAGE(HPageVmemmapOptimized(&folio->page=
),
> > +                                    page);
> >               last =3D atomic_add_negative(-1, &page->_mapcount);
> >               nr =3D last;
> >               if (last && folio_test_large(folio)) {
> >                       nr =3D atomic_dec_return_relaxed(mapped);
> >                       nr =3D (nr < COMPOUND_MAPPED);
> >               }
> > -     } else if (folio_test_pmd_mappable(folio)) {
> > -             /* That test is redundant: it's for safety or to optimize=
 out */
> > -
> > +     } else {
> >               last =3D atomic_add_negative(-1, &folio->_entire_mapcount=
);
> >               if (last) {
> >                       nr =3D atomic_sub_return_relaxed(COMPOUND_MAPPED,=
 mapped);
> > @@ -1407,6 +1406,9 @@ void page_remove_rmap(struct page *page, struct v=
m_area_struct *vma,
> >               }
> >       }
> >
> > +     if (folio_test_hugetlb(folio))
> > +             return;
>
> Same as above in page_add_file_rmap.
>
> > +
> >       if (nr_pmdmapped) {
> >               if (folio_test_anon(folio))
> >                       idx =3D NR_ANON_THPS;
> > @@ -2541,9 +2543,11 @@ void hugepage_add_anon_rmap(struct page *page, s=
truct vm_area_struct *vma,
> >       first =3D atomic_inc_and_test(&folio->_entire_mapcount);
> >       VM_BUG_ON_PAGE(!first && (flags & RMAP_EXCLUSIVE), page);
> >       VM_BUG_ON_PAGE(!first && PageAnonExclusive(page), page);
> > -     if (first)
> > +     if (first) {
> > +             atomic_add(COMPOUND_MAPPED, &folio->_nr_pages_mapped);
> >               __page_set_anon_rmap(folio, page, vma, address,
> >                                    !!(flags & RMAP_EXCLUSIVE));
> > +     }
> >  }
> >
> >  void hugepage_add_new_anon_rmap(struct folio *folio,
> > @@ -2552,6 +2556,7 @@ void hugepage_add_new_anon_rmap(struct folio *fol=
io,
> >       BUG_ON(address < vma->vm_start || address >=3D vma->vm_end);
> >       /* increment count (starts at -1) */
> >       atomic_set(&folio->_entire_mapcount, 0);
> > +     atomic_set(&folio->_nr_pages_mapped, COMPOUND_MAPPED);
> >       folio_clear_hugetlb_restore_reserve(folio);
> >       __page_set_anon_rmap(folio, &folio->page, vma, address, 1);
> >  }
>
> Should we look at perhaps modifying page_add_anon_rmap and
> folio_add_new_anon_rmap as well?

I think I can merge hugepage_add_anon_rmap with page_add_anon_rmap and
hugepage_add_new_anon_rmap with folio_add_new_anon_rmap. With them
merged, it's pretty easy to see what HugeTLB does differently from
generic mm, which is nice. :)

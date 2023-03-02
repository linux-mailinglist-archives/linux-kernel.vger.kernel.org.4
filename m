Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DE56A871B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 17:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjCBQo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 11:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjCBQoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 11:44:25 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDFA193FE
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 08:44:22 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id h11-20020a17090a2ecb00b00237c740335cso3352927pjs.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 08:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677775462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OtSkf5MF6MTtXsT3MyqpoFulHtBnaDyIDTTRZHqKdEg=;
        b=KBUkvr0lv2QIcfQoGK5aXZ68kvtapM/5pdg6W6hfZtq1qVK0uIyjG4G+RAgzhPAUa5
         TDhBHqANpfx2JgL6HRbRxs0I3hwvcXFMFyWfKx2HfwoMxL00Lce6i/9ZsN34atzLzmB1
         niso2B3+0s8j9WjXBM4mqbYj+xu4opyY9DSTb1Ddsn5/vjarGuKErH7tCRto61/RpMou
         QANRqrn1v6fdkQ0z896flZP9jXX3/ZRHUneW3u/w+1mwrUerPwfwiu9GiheOtTltivKS
         tsmSpjgP5lj0wikw19CqLLFyswc/YO/hHxChGQPFlzSvi9INJk4Ynu5keVVMYwPh34h0
         jbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677775462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OtSkf5MF6MTtXsT3MyqpoFulHtBnaDyIDTTRZHqKdEg=;
        b=djrN/Ok1umMIpbkGpUAXNQ9As7bzMGaHcjJkYYQLQhhtTxlq++4D6iIDusU1AZA2lz
         78B4zlQnHEUdsS7wuAQ/58mTVULeVc5uhyqabrNM7KK9F1k97EFL9J09mPwfjXVietKr
         CNv7TIYuujbm2cIO+b9IeoSjv4ur5ic4SgrGLsWYtiz/QN55bRzxDZp1MTqEt6GvyUhi
         +iw8gi1cg0IuNv6uV1aRY3LtSCwqChxJ01WEylkEbgy1xzMcR8YPHkBrN8XgZ9R15H61
         fzG+OXXLInc7w+oUac21Y2eMxdGKUKprhxEA9RoQp1ZUMraL2K2QVgzYm0yU7peQcEZX
         usMg==
X-Gm-Message-State: AO0yUKVW1P7p+X7o6cX5wzrhAforFrYCRJokip7TedOvrhGCHt/lYBIP
        A0uDPcEALiFFRvDLHIMzG1vgoh3900VIQeBa3SHUSg==
X-Google-Smtp-Source: AK7set+hvx7Wgjhea8R3CjbZJvcN48WjNh85ZCPVU1R1z18VqHVsjHrZVzO1z2+9J+5A1QcZSY228YzFS8mkyWMbIZ4=
X-Received: by 2002:a17:903:2591:b0:19a:8bc7:d814 with SMTP id
 jb17-20020a170903259100b0019a8bc7d814mr4028466plb.13.1677775461664; Thu, 02
 Mar 2023 08:44:21 -0800 (PST)
MIME-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
 <20230218002819.1486479-6-jthoughton@google.com> <CACw3F538H+bYcvSY-qG4-gmrgGPRBgTScDzrX9suLyp_q+v_bQ@mail.gmail.com>
 <CADrL8HVMp9kA=c904pUCqa-J_1vY4UPtsL9up+ZVVDp4TZbG2w@mail.gmail.com>
In-Reply-To: <CADrL8HVMp9kA=c904pUCqa-J_1vY4UPtsL9up+ZVVDp4TZbG2w@mail.gmail.com>
From:   James Houghton <jthoughton@google.com>
Date:   Thu, 2 Mar 2023 08:43:43 -0800
Message-ID: <CADrL8HWPJuFixYzh97nT_8XO2kaS6i+wY+T58HL3GTmq9u=yTw@mail.gmail.com>
Subject: Re: [PATCH v2 05/46] rmap: hugetlb: switch from page_dup_file_rmap to page_add_file_rmap
To:     Jiaqi Yan <jiaqiyan@google.com>
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

On Thu, Mar 2, 2023 at 7:44=E2=80=AFAM James Houghton <jthoughton@google.co=
m> wrote:
>
> On Wed, Mar 1, 2023 at 5:06=E2=80=AFPM Jiaqi Yan <jiaqiyan@google.com> wr=
ote:
> >
> > On Fri, Feb 17, 2023 at 4:28 PM James Houghton <jthoughton@google.com> =
wrote:
> > >
> > > This only applies to file-backed HugeTLB, and it should be a no-op un=
til
> > > high-granularity mapping is possible. Also update page_remove_rmap to
> > > support the eventual case where !compound && folio_test_hugetlb().
> > >
> > > HugeTLB doesn't use LRU or mlock, so we avoid those bits. This also
> > > means we don't need to use subpage_mapcount; if we did, it would
> > > overflow with only a few mappings.
>
> This is wrong; I guess I misunderstood the code when I wrote this
> commit. subpages_mapcount (now called _nr_pages_mapped) won't overflow
> (unless HugeTLB pages could be greater than 16G). It is indeed a bug
> not to update _nr_pages_mapped the same way THPs do.
>
> >
> > >
> > > There is still one caller of page_dup_file_rmap left: copy_present_pt=
e,
> > > and it is always called with compound=3Dfalse in this case.
> > >
> > > Signed-off-by: James Houghton <jthoughton@google.com>
> > >
> > > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > > index 08004371cfed..6c008c9de80e 100644
> > > --- a/mm/hugetlb.c
> > > +++ b/mm/hugetlb.c
> > > @@ -5077,7 +5077,7 @@ int copy_hugetlb_page_range(struct mm_struct *d=
st, struct mm_struct *src,
> > >                          * sleep during the process.
> > >                          */
> > >                         if (!PageAnon(ptepage)) {
> > > -                               page_dup_file_rmap(ptepage, true);
> > > +                               page_add_file_rmap(ptepage, src_vma, =
true);
> > >                         } else if (page_try_dup_anon_rmap(ptepage, tr=
ue,
> > >                                                           src_vma)) {
> > >                                 pte_t src_pte_old =3D entry;
> > > @@ -5910,7 +5910,7 @@ static vm_fault_t hugetlb_no_page(struct mm_str=
uct *mm,
> > >         if (anon_rmap)
> > >                 hugepage_add_new_anon_rmap(folio, vma, haddr);
> > >         else
> > > -               page_dup_file_rmap(&folio->page, true);
> > > +               page_add_file_rmap(&folio->page, vma, true);
> > >         new_pte =3D make_huge_pte(vma, &folio->page, ((vma->vm_flags =
& VM_WRITE)
> > >                                 && (vma->vm_flags & VM_SHARED)));
> > >         /*
> > > @@ -6301,7 +6301,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *=
dst_mm,
> > >                 goto out_release_unlock;
> > >
> > >         if (folio_in_pagecache)
> > > -               page_dup_file_rmap(&folio->page, true);
> > > +               page_add_file_rmap(&folio->page, dst_vma, true);
> > >         else
> > >                 hugepage_add_new_anon_rmap(folio, dst_vma, dst_addr);
> > >
> > > diff --git a/mm/migrate.c b/mm/migrate.c
> > > index d3964c414010..b0f87f19b536 100644
> > > --- a/mm/migrate.c
> > > +++ b/mm/migrate.c
> > > @@ -254,7 +254,7 @@ static bool remove_migration_pte(struct folio *fo=
lio,
> > >                                 hugepage_add_anon_rmap(new, vma, pvmw=
.address,
> > >                                                        rmap_flags);
> > >                         else
> > > -                               page_dup_file_rmap(new, true);
> > > +                               page_add_file_rmap(new, vma, true);
> > >                         set_huge_pte_at(vma->vm_mm, pvmw.address, pvm=
w.pte, pte);
> > >                 } else
> > >  #endif
> > > diff --git a/mm/rmap.c b/mm/rmap.c
> > > index 15ae24585fc4..c010d0af3a82 100644
> > > --- a/mm/rmap.c
> > > +++ b/mm/rmap.c
> >
> > Given you are making hugetlb's ref/mapcount mechanism to be consistent
> > with THP, I think the special folio_test_hugetlb checks you added in
> > this commit will break page_mapped() and folio_mapped() if page/folio
> > is HGMed. With these checks, folio->_nr_pages_mapped are not properly
> > increased/decreased.
>
> Thank you, Jiaqi! I didn't realize I broke
> folio_mapped()/page_mapped(). The end result is that page_mapped() may
> report that an HGMed page isn't mapped when it is. Not good!
>
> >
> > > @@ -1318,21 +1318,21 @@ void page_add_file_rmap(struct page *page, st=
ruct vm_area_struct *vma,
> > >         int nr =3D 0, nr_pmdmapped =3D 0;
> > >         bool first;
> > >
> > > -       VM_BUG_ON_PAGE(compound && !PageTransHuge(page), page);
> > > +       VM_BUG_ON_PAGE(compound && !PageTransHuge(page)
> > > +                               && !folio_test_hugetlb(folio), page);
> > >
> > >         /* Is page being mapped by PTE? Is this its first map to be a=
dded? */
> > >         if (likely(!compound)) {
> > >                 first =3D atomic_inc_and_test(&page->_mapcount);
> > >                 nr =3D first;
> > > -               if (first && folio_test_large(folio)) {
> > > +               if (first && folio_test_large(folio)
> > > +                         && !folio_test_hugetlb(folio)) {
> >
> > So we should still increment _nr_pages_mapped for hugetlb case here,
> > and decrement in the corresponding place in page_remove_rmap.
> >
> > >                         nr =3D atomic_inc_return_relaxed(mapped);
> > >                         nr =3D (nr < COMPOUND_MAPPED);
> > >                 }
> > > -       } else if (folio_test_pmd_mappable(folio)) {
> > > -               /* That test is redundant: it's for safety or to opti=
mize out */
> > > -
> > > +       } else {
> > >                 first =3D atomic_inc_and_test(&folio->_entire_mapcoun=
t);
> > > -               if (first) {
> > > +               if (first && !folio_test_hugetlb(folio)) {
> >
> > Same here: we should still increase _nr_pages_mapped by
> > COMPOUND_MAPPED and decrease by COMPOUND_MAPPED in the corresponding
> > place in page_remove_rmap.
> >
> > >                         nr =3D atomic_add_return_relaxed(COMPOUND_MAP=
PED, mapped);
> > >                         if (likely(nr < COMPOUND_MAPPED + COMPOUND_MA=
PPED)) {
> > >                                 nr_pmdmapped =3D folio_nr_pages(folio=
);
> > > @@ -1347,6 +1347,9 @@ void page_add_file_rmap(struct page *page, stru=
ct vm_area_struct *vma,
> > >                 }
> > >         }
> > >
> > > +       if (folio_test_hugetlb(folio))
> > > +               return;
> > > +
> > >         if (nr_pmdmapped)
> > >                 __lruvec_stat_mod_folio(folio, folio_test_swapbacked(=
folio) ?
> > >                         NR_SHMEM_PMDMAPPED : NR_FILE_PMDMAPPED, nr_pm=
dmapped);
> > > @@ -1376,8 +1379,7 @@ void page_remove_rmap(struct page *page, struct=
 vm_area_struct *vma,
> > >         VM_BUG_ON_PAGE(compound && !PageHead(page), page);
> > >
> > >         /* Hugetlb pages are not counted in NR_*MAPPED */
> > > -       if (unlikely(folio_test_hugetlb(folio))) {
> > > -               /* hugetlb pages are always mapped with pmds */
> > > +       if (unlikely(folio_test_hugetlb(folio)) && compound) {
> > >                 atomic_dec(&folio->_entire_mapcount);
> > >                 return;
> > >         }
> >
> > This entire if-block should be removed after you remove the
> > !folio_test_hugetlb checks in page_add_file_rmap.
>
> This is the not-so-obvious change that is needed. Thank you!
>
> >
> > > @@ -1386,15 +1388,14 @@ void page_remove_rmap(struct page *page, stru=
ct vm_area_struct *vma,
> > >         if (likely(!compound)) {
> > >                 last =3D atomic_add_negative(-1, &page->_mapcount);
> > >                 nr =3D last;
> > > -               if (last && folio_test_large(folio)) {
> > > +               if (last && folio_test_large(folio)
> > > +                        && !folio_test_hugetlb(folio)) {
> >
> > ditto.
> >
> > >                         nr =3D atomic_dec_return_relaxed(mapped);
> > >                         nr =3D (nr < COMPOUND_MAPPED);
> > >                 }
> > > -       } else if (folio_test_pmd_mappable(folio)) {
> > > -               /* That test is redundant: it's for safety or to opti=
mize out */
> > > -
> > > +       } else {
> > >                 last =3D atomic_add_negative(-1, &folio->_entire_mapc=
ount);
> > > -               if (last) {
> > > +               if (last && !folio_test_hugetlb(folio)) {
> >
> > ditto.
>
> I agree with all of your suggestions. Testing with the hugetlb-hgm
> selftest, nothing seems to break. :)
>
> Given that this is at least the third or fourth major bug in this
> version of the series, I'll go ahead and send a v3 sooner rather than
> later.

This solution limits the size of a HugeTLB page to 16G. I'm not sure
if there are any architectures that support HugeTLB pages larger than
16G (it looks like powerpc supports 16G). If they do, I think we can
just increase the value of COMPOUND_MAPPED. If that's not possible, we
would need another solution than participating in _nr_pages_mapped
like THPs.

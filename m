Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB9A73BCD0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 18:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbjFWQkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 12:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbjFWQkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 12:40:25 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37EF2947
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 09:40:21 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-bcde2b13fe2so733040276.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 09:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687538420; x=1690130420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+FHKatDr+jcK/HOnfDqSrTTHFQBX6gH0Sv7rCX0RAY=;
        b=EFg8gBkNyJlmaty1/F7vR0BphOYFHVAHqn29CIOA8mKhx1JrPSNG2DZmqgMIyXW29f
         0fXFp14H3OzjlonRHmhpjBbAucTQLTHLsKtHeE8z3tMBXmYQWr8tyTOt9Cj067THeTOR
         69AJ2UEEwAlFMwuukQuOwBzHmcO7i1UpRU27ALNynDpmcRjtDTY0HfQRSI3DFje9Jneq
         7kcQPvqgHXnyveGgAD5JKRmSbr28px23mu5j4zuU5sqviPDbz27eDU3ch/HQCjwzh2PF
         2v809M4wfHjLt6xaOL5T4przAb84wqz/0iGSFHt0PFiaL+Ur8LW3LCza9215Z1hJUNId
         NlOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687538420; x=1690130420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+FHKatDr+jcK/HOnfDqSrTTHFQBX6gH0Sv7rCX0RAY=;
        b=F1geNBgdxaoDL+PerChs1imJ6S6oKZCY04rfK/xXQQEe34z6ufpBrDMrdVX/f0W/kA
         AFs4QkvNQGGqnOqZim4ekGoIpXVDIpmzkLHNSg7fzEGIKjUs3/md1ls3jSP2PV8JQsmm
         Rgu9sLFfFNyGHeWuICCcbdesAhiLYCnftTF9oVuwtFnW5odavAlO5cuRQ6ztD8vg4uoo
         43HgoeLgBVK2olprpUAthWmBq3SYnastHhQYVHyS0wfBXiy5h3TFtkGuFYo7nmMIdVzm
         IbyZHcO9+zAtIgOJ+agmtTiJYuWmXzjEHbYovBcSJvAzJ2L+TP+Oy6K9Jdg/cL45La5i
         fukA==
X-Gm-Message-State: AC+VfDxK4EP1CIkDPkHPHVVLgvNB9K90dPtlYFMlLGe9/z1PjgQYdK9H
        o1iJ8lslxLYfr2NFlUjfz5d8oR4qYRiZuOHvnuYR4w==
X-Google-Smtp-Source: ACHHUZ66r30aoY0eazG6VEUjfL6NJpertwiFiURv84M2h66MkG9qph5y9X2D93N9wpbkLdmARmgq8Erq3tac+WRYca4=
X-Received: by 2002:a25:2d02:0:b0:bcc:a4a6:bf34 with SMTP id
 t2-20020a252d02000000b00bcca4a6bf34mr17333351ybt.37.1687538420562; Fri, 23
 Jun 2023 09:40:20 -0700 (PDT)
MIME-Version: 1.0
References: <CACw3F52k=fhYpLpvDoVPcmKnOALLkPsGk08PdS_H0+miSYvhEQ@mail.gmail.com>
 <20230612041901.GA3083591@ik1-406-35019.vs.sakura.ne.jp> <CACw3F51o1ZFSYZa+XLnk4Wwjy2w_q=Kn+aOQs0=qpfG-ZYDFKg@mail.gmail.com>
 <20230616233447.GB7371@monkey> <CACw3F52iG5bqQbvZ9QkkRkVfy+NbSOu9hnkVOt5khukNNG73OQ@mail.gmail.com>
 <20230617225927.GA3540@monkey> <20230619082330.GA1612447@ik1-406-35019.vs.sakura.ne.jp>
 <20230620180533.GA3567@monkey> <20230620223909.GB3567@monkey>
 <CACw3F53iPiLrJt4pyaX2aaZ5BVg9tj8x_k6-v7=9Xn1nrh=UCw@mail.gmail.com> <20230623041924.GA44732@monkey>
In-Reply-To: <20230623041924.GA44732@monkey>
From:   Jiaqi Yan <jiaqiyan@google.com>
Date:   Fri, 23 Jun 2023 09:40:09 -0700
Message-ID: <CACw3F501ON2pK+k9g5yC4ShtLbYQXQUVbNcpJeW7UVDUUsaUUQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] mm/hwpoison: find subpage in hugetlb HWPOISON list
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "shy828301@gmail.com" <shy828301@gmail.com>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "duenwen@google.com" <duenwen@google.com>,
        "axelrasmussen@google.com" <axelrasmussen@google.com>,
        "jthoughton@google.com" <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 9:19=E2=80=AFPM Mike Kravetz <mike.kravetz@oracle.c=
om> wrote:
>
> On 06/22/23 17:45, Jiaqi Yan wrote:
> > On Tue, Jun 20, 2023 at 3:39=E2=80=AFPM Mike Kravetz <mike.kravetz@orac=
le.com> wrote:
> > >
> > > On 06/20/23 11:05, Mike Kravetz wrote:
> > > > On 06/19/23 17:23, Naoya Horiguchi wrote:
> > > > >
> > > > > Considering this issue as one specific to memory error handling, =
checking
> > > > > HPG_vmemmap_optimized in __get_huge_page_for_hwpoison() might be =
helpful to
> > > > > detect the race.  Then, an idea like the below diff (not tested) =
can make
> > > > > try_memory_failure_hugetlb() retry (with retaking hugetlb_lock) t=
o wait
> > > > > for complete the allocation of vmemmap pages.
> > > > >
> > > > > @@ -1938,8 +1938,11 @@ int __get_huge_page_for_hwpoison(unsigned =
long pfn, int flags,
> > > > >         int ret =3D 2;    /* fallback to normal page handling */
> > > > >         bool count_increased =3D false;
> > > > >
> > > > > -       if (!folio_test_hugetlb(folio))
> > > > > +       if (!folio_test_hugetlb(folio)) {
> > > > > +               if (folio_test_hugetlb_vmemmap_optimized(folio))
> > > > > +                       ret =3D -EBUSY;
> > > >
> > > > The hugetlb specific page flags (HPG_vmemmap_optimized here) reside=
 in
> > > > the folio->private field.
> > > >
> > > > In the case where the folio is a non-hugetlb folio, the folio->priv=
ate field
> > > > could be any arbitrary value.  As such, the test for vmemmap_optimi=
zed may
> > > > return a false positive.  We could end up retrying for an arbitrari=
ly
> > > > long time.
> > > >
> > > > I am looking at how to restructure the code which removes and frees
> > > > hugetlb pages so that folio_test_hugetlb() would remain true until
> > > > vmemmap pages are allocated.  The easiest way to do this would intr=
oduce
> > > > another hugetlb lock/unlock cycle in the page freeing path.  This w=
ould
> > > > undo some of the speedups in the series:
> > > > https://lore.kernel.org/all/20210409205254.242291-4-mike.kravetz@or=
acle.com/T/#m34321fbcbdf8bb35dfe083b05d445e90ecc1efab
> > > >
> > >
> > > Perhaps something like this?  Minimal testing.
> >
> > Thanks for putting up a fix, Mike!
> >
> > >
> > > From e709fb4da0b6249973f9bf0540c9da0e4c585fe2 Mon Sep 17 00:00:00 200=
1
> > > From: Mike Kravetz <mike.kravetz@oracle.com>
> > > Date: Tue, 20 Jun 2023 14:48:39 -0700
> > > Subject: [PATCH] hugetlb: Do not clear hugetlb dtor until allocating =
vmemmap
> > >
> > > Freeing a hugetlb page and releasing base pages back to the underlyin=
g
> > > allocator such as buddy or cma is performed in two steps:
> > > - remove_hugetlb_folio() is called to remove the folio from hugetlb
> > >   lists, get a ref on the page and remove hugetlb destructor.  This
> > >   all must be done under the hugetlb lock.  After this call, the page
> > >   can be treated as a normal compound page or a collection of base
> > >   size pages.
> > > - update_and_free_hugetlb_folio() is called to allocate vmemmap if
> > >   needed and the free routine of the underlying allocator is called
> > >   on the resulting page.  We can not hold the hugetlb lock here.
> > >
> > > One issue with this scheme is that a memory error could occur between
> > > these two steps.  In this case, the memory error handling code treats
> > > the old hugetlb page as a normal compound page or collection of base
> > > pages.  It will then try to SetPageHWPoison(page) on the page with an
> > > error.  If the page with error is a tail page without vmemmap, a writ=
e
> > > error will occur when trying to set the flag.
> > >
> > > Address this issue by modifying remove_hugetlb_folio() and
> > > update_and_free_hugetlb_folio() such that the hugetlb destructor is n=
ot
> > > cleared until after allocating vmemmap.  Since clearing the destructo=
r
> > > required holding the hugetlb lock, the clearing is done in
> > > remove_hugetlb_folio() if the vmemmap is present.  This saves a
> > > lock/unlock cycle.  Otherwise, destructor is cleared in
> > > update_and_free_hugetlb_folio() after allocating vmemmap.
> > >
> > > Note that this will leave hugetlb pages in a state where they are mar=
ked
> > > free (by hugetlb specific page flag) and have a ref count.  This is n=
ot
> > > a normal state.  The only code that would notice is the memory error
> > > code, and it is set up to retry in such a case.
> > >
> > > A subsequent patch will create a routine to do bulk processing of
> > > vmemmap allocation.  This will eliminate a lock/unlock cycle for each
> > > hugetlb page in the case where we are freeing a bunch of pages.
> > >
> > > Fixes: ???
> > > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> > > ---
> > >  mm/hugetlb.c | 75 +++++++++++++++++++++++++++++++++++---------------=
--
> > >  1 file changed, 51 insertions(+), 24 deletions(-)
> > >
> > > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > > index d76574425da3..f7f64470aee0 100644
> > > --- a/mm/hugetlb.c
> > > +++ b/mm/hugetlb.c
> > > @@ -1579,9 +1579,37 @@ static inline void destroy_compound_gigantic_f=
olio(struct folio *folio,
> > >                                                 unsigned int order) {=
 }
> > >  #endif
> > >
> > > +static inline void __clear_hugetlb_destructor(struct hstate *h,
> > > +                                               struct folio *folio)
> > > +{
> > > +       lockdep_assert_held(&hugetlb_lock);
> > > +
> > > +       /*
> > > +        * Very subtle
> > > +        *
> > > +        * For non-gigantic pages set the destructor to the normal co=
mpound
> > > +        * page dtor.  This is needed in case someone takes an additi=
onal
> > > +        * temporary ref to the page, and freeing is delayed until th=
ey drop
> > > +        * their reference.
> > > +        *
> > > +        * For gigantic pages set the destructor to the null dtor.  T=
his
> > > +        * destructor will never be called.  Before freeing the gigan=
tic
> > > +        * page destroy_compound_gigantic_folio will turn the folio i=
nto a
> > > +        * simple group of pages.  After this the destructor does not
> > > +        * apply.
> > > +        *
> > > +        */
> > > +       if (hstate_is_gigantic(h))
> > > +               folio_set_compound_dtor(folio, NULL_COMPOUND_DTOR);
> > > +       else
> > > +               folio_set_compound_dtor(folio, COMPOUND_PAGE_DTOR);
> > > +}
> > > +
> > >  /*
> > > - * Remove hugetlb folio from lists, and update dtor so that the foli=
o appears
> > > - * as just a compound page.
> > > + * Remove hugetlb folio from lists.
> > > + * If vmemmap exists for the folio, update dtor so that the folio ap=
pears
> > > + * as just a compound page.  Otherwise, wait until after allocating =
vmemmap
> > > + * to update dtor.
> > >   *
> > >   * A reference is held on the folio, except in the case of demote.
> > >   *
> > > @@ -1612,31 +1640,19 @@ static void __remove_hugetlb_folio(struct hst=
ate *h, struct folio *folio,
> > >         }
> > >
> > >         /*
> > > -        * Very subtle
> > > -        *
> > > -        * For non-gigantic pages set the destructor to the normal co=
mpound
> > > -        * page dtor.  This is needed in case someone takes an additi=
onal
> > > -        * temporary ref to the page, and freeing is delayed until th=
ey drop
> > > -        * their reference.
> > > -        *
> > > -        * For gigantic pages set the destructor to the null dtor.  T=
his
> > > -        * destructor will never be called.  Before freeing the gigan=
tic
> > > -        * page destroy_compound_gigantic_folio will turn the folio i=
nto a
> > > -        * simple group of pages.  After this the destructor does not
> > > -        * apply.
> > > -        *
> > > -        * This handles the case where more than one ref is held when=
 and
> > > -        * after update_and_free_hugetlb_folio is called.
> > > -        *
> > > -        * In the case of demote we do not ref count the page as it w=
ill soon
> > > -        * be turned into a page of smaller size.
> > > +        * We can only clear the hugetlb destructor after allocating =
vmemmap
> > > +        * pages.  Otherwise, someone (memory error handling) may try=
 to write
> > > +        * to tail struct pages.
> > > +        */
> > > +       if (!folio_test_hugetlb_vmemmap_optimized(folio))
> > > +               __clear_hugetlb_destructor(h, folio);
> > > +
> > > +        /*
> > > +         * In the case of demote we do not ref count the page as it =
will soon
> > > +         * be turned into a page of smaller size.
> > >          */
> > >         if (!demote)
> > >                 folio_ref_unfreeze(folio, 1);
> > > -       if (hstate_is_gigantic(h))
> > > -               folio_set_compound_dtor(folio, NULL_COMPOUND_DTOR);
> > > -       else
> > > -               folio_set_compound_dtor(folio, COMPOUND_PAGE_DTOR);
> > >
> > >         h->nr_huge_pages--;
> > >         h->nr_huge_pages_node[nid]--;
> > > @@ -1705,6 +1721,7 @@ static void __update_and_free_hugetlb_folio(str=
uct hstate *h,
> > >  {
> > >         int i;
> > >         struct page *subpage;
> > > +       bool clear_dtor =3D folio_test_hugetlb_vmemmap_optimized(foli=
o);
> >
> > Can this test on vmemmap_optimized still tell us if we should
> > __clear_hugetlb_destructor? From my reading:
> > 1. If a hugetlb folio is still vmemmap optimized in
> > __remove_hugetlb_folio, __remove_hugetlb_folio won't
> > __clear_hugetlb_destructor.
> > 2. Then hugetlb_vmemmap_restore in dissolve_free_huge_page will clear
> > HPG_vmemmap_optimized if it succeeds.
> > 3. Now when dissolve_free_huge_page gets into
> > __update_and_free_hugetlb_folio, we will see clear_dtor to be false
> > and __clear_hugetlb_destructor won't be called.
>
> Good catch!  That is indeed a problem with this patch.

Glad that I could help.

>
> >
> > Or maybe I misunderstood, and what you really want to do is never
> > __clear_hugetlb_destructor so that folio_test_hugetlb is always true?
>
> No, that was a bug with this patch.
>
> We could ALWAYS wait until __update_and_free_hugetlb_folio to clear the
> hugetlb destructor.  However, we have to take hugetlb lock to clear it.
> If the page does not have vmemmap optimized, the we can clear the
> destructor earlier in __remove_hugetlb_folio and avoid the lock/unlock
> cycle.  In the past, we have had complaints about the time required to
> allocate and free a large quantity of hugetlb pages.  Most of that time
> is spent in the low level allocators.  However, I do not want to add
> something like an extra lock/unlock cycle unless absolutely necessary.
>
> I'll try to think of a cleaner and more fool proof way to address this.
>
> IIUC, this is an existing issue.  Your patch series does not depend
> this being fixed.

Thanks Mike, I was about to send out V2 today.

> --
> Mike Kravetz
>
> >
> > >
> > >         if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported=
())
> > >                 return;
> > > @@ -1735,6 +1752,16 @@ static void __update_and_free_hugetlb_folio(st=
ruct hstate *h,
> > >         if (unlikely(folio_test_hwpoison(folio)))
> > >                 folio_clear_hugetlb_hwpoison(folio);
> > >
> > > +       /*
> > > +        * If vmemmap pages were allocated above, then we need to cle=
ar the
> > > +        * hugetlb destructor under the hugetlb lock.
> > > +        */
> > > +       if (clear_dtor) {
> > > +               spin_lock_irq(&hugetlb_lock);
> > > +               __clear_hugetlb_destructor(h, folio);
> > > +               spin_unlock_irq(&hugetlb_lock);
> > > +       }
> > > +
> > >         for (i =3D 0; i < pages_per_huge_page(h); i++) {
> > >                 subpage =3D folio_page(folio, i);
> > >                 subpage->flags &=3D ~(1 << PG_locked | 1 << PG_error =
|
> > > --
> > > 2.41.0
> > >

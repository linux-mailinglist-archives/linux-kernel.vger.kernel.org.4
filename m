Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660A0705C81
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 03:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjEQBhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 21:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjEQBhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 21:37:35 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD333C06
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 18:37:34 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-33164ec77ccso57265ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 18:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684287454; x=1686879454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLugHt0XGPwYTpMjCAQObsffP9JpeGqJnJJt+CEzfkw=;
        b=bVTAd5SO8NoTEqY8WvVpici8dg2AJF+dp7I0LnvvkPfdcwDNGaZNyd9AJHKI6atf4y
         I9ui03BXIdH2uqHnitcgCBq151W6TYHraYtG2uM/cA42aUOG7SDWjT46iPhVHOLfQhpd
         cLb4pgJrYFz7Z5x95Vtw17j5uuh9OE9rEnwI+PUr5ySb9Ls5pnIYhqFZhb0HxHid9mhm
         +U6Es6zGE5ho/3P3faKVgUhZ6BhfRl6P4WvBQIV5PP0GUfkZwrDFuiCs1HQrGfB+L9bl
         pxBmE0eDGdapX3w/SzQd370Pn2582BdELI3PnyXY8L5KR22eCiB0cF07R8UJxHQgFxV7
         6erg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684287454; x=1686879454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLugHt0XGPwYTpMjCAQObsffP9JpeGqJnJJt+CEzfkw=;
        b=PHkB/Rb2hpGaix1x7x+gy8tgyNrVM43ukB+riNPMPaXiGkHRQR3bKMKJxvmia0AkkS
         2FNSDXtybevJLdhPU7NA1sULVnEQS4h6RKO+un91JTGIwBkNMVBQ8KWkhqHQiyvxGGHV
         LCZSzkAkyEDVxM0A9az/zVp1d+C5zpKEAhDbxaPlwJR9iXL0akZAR5lTrqqndm9jRsqc
         BZWlwhHaPwnml6HFRsEUYivQD2ZeXeUqUNCCu2pereUoTjEln1tDy7kuCFD+398xCqMF
         4cvRAX+kmaDkn8XnAw34593T6nyp+B7cyMra2MTmOGqIIGvZjKpkqqqeNsEaY0Z4ohjw
         e3bA==
X-Gm-Message-State: AC+VfDyRkXDM6BMMqO9sqQPpFoddDmZlEf97CnEvKlmu7vmN1ZjjkVst
        rUXZbsZfvpIwH1cYyC/Ux9xXZ6C7UeJDGaOr66JTtJp0AiWA/feuYoh6/jYm
X-Google-Smtp-Source: ACHHUZ6dZfD1Ix5kE87yhR1ityHzz0e/73f67Hdq1xOZtlUzUQebA+DIVW/8Pry1HP7JugJAoQpPKt/YljP3mLUFfFU=
X-Received: by 2002:a05:6e02:1a4a:b0:331:948c:86f3 with SMTP id
 u10-20020a056e021a4a00b00331948c86f3mr64152ilv.19.1684287453632; Tue, 16 May
 2023 18:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230512235755.1589034-1-pcc@google.com> <20230512235755.1589034-2-pcc@google.com>
 <7471013e-4afb-e445-5985-2441155fc82c@redhat.com> <ZGJtJobLrBg3PtHm@arm.com> <91246137-a3d2-689f-8ff6-eccc0e61c8fe@redhat.com>
In-Reply-To: <91246137-a3d2-689f-8ff6-eccc0e61c8fe@redhat.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Tue, 16 May 2023 18:37:22 -0700
Message-ID: <CAMn1gO4cbEmpDzkdN10DyaGe=2Wg4Y19-v8gHRqgQoD4Bxd+cw@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: Move arch_do_swap_page() call to before swap_free()
To:     David Hildenbrand <david@redhat.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        =?UTF-8?B?UXVuLXdlaSBMaW4gKOael+e+pOW0tCk=?= 
        <Qun-wei.Lin@mediatek.com>, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "surenb@google.com" <surenb@google.com>,
        =?UTF-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?= 
        <chinwen.chang@mediatek.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        =?UTF-8?B?S3Vhbi1ZaW5nIExlZSAo5p2O5Yag56mOKQ==?= 
        <Kuan-Ying.Lee@mediatek.com>,
        =?UTF-8?B?Q2FzcGVyIExpICjmnY7kuK3mpq4p?= <casper.li@mediatek.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        vincenzo.frascino@arm.com,
        Alexandru Elisei <alexandru.elisei@arm.com>, will@kernel.org,
        eugenis@google.com, Steven Price <steven.price@arm.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 5:31=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 15.05.23 19:34, Catalin Marinas wrote:
> > On Sat, May 13, 2023 at 05:29:53AM +0200, David Hildenbrand wrote:
> >> On 13.05.23 01:57, Peter Collingbourne wrote:
> >>> diff --git a/mm/memory.c b/mm/memory.c
> >>> index 01a23ad48a04..83268d287ff1 100644
> >>> --- a/mm/memory.c
> >>> +++ b/mm/memory.c
> >>> @@ -3914,19 +3914,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >>>             }
> >>>     }
> >>> -   /*
> >>> -    * Remove the swap entry and conditionally try to free up the swa=
pcache.
> >>> -    * We're already holding a reference on the page but haven't mapp=
ed it
> >>> -    * yet.
> >>> -    */
> >>> -   swap_free(entry);
> >>> -   if (should_try_to_free_swap(folio, vma, vmf->flags))
> >>> -           folio_free_swap(folio);
> >>> -
> >>> -   inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
> >>> -   dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
> >>>     pte =3D mk_pte(page, vma->vm_page_prot);
> >>> -
> >>>     /*
> >>>      * Same logic as in do_wp_page(); however, optimize for pages tha=
t are
> >>>      * certainly not shared either because we just allocated them wit=
hout
> >>> @@ -3946,8 +3934,21 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >>>             pte =3D pte_mksoft_dirty(pte);
> >>>     if (pte_swp_uffd_wp(vmf->orig_pte))
> >>>             pte =3D pte_mkuffd_wp(pte);
> >>> +   arch_do_swap_page(vma->vm_mm, vma, vmf->address, pte, vmf->orig_p=
te);
> >>>     vmf->orig_pte =3D pte;
> >>> +   /*
> >>> +    * Remove the swap entry and conditionally try to free up the swa=
pcache.
> >>> +    * We're already holding a reference on the page but haven't mapp=
ed it
> >>> +    * yet.
> >>> +    */
> >>> +   swap_free(entry);
> >>> +   if (should_try_to_free_swap(folio, vma, vmf->flags))
> >>> +           folio_free_swap(folio);
> >>> +
> >>> +   inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
> >>> +   dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
> >>> +
> >>>     /* ksm created a completely new copy */
> >>>     if (unlikely(folio !=3D swapcache && swapcache)) {
> >>>             page_add_new_anon_rmap(page, vma, vmf->address);
> >>> @@ -3959,7 +3960,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >>>     VM_BUG_ON(!folio_test_anon(folio) ||
> >>>                     (pte_write(pte) && !PageAnonExclusive(page)));
> >>>     set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
> >>> -   arch_do_swap_page(vma->vm_mm, vma, vmf->address, pte, vmf->orig_p=
te);
> >>>     folio_unlock(folio);
> >>>     if (folio !=3D swapcache && swapcache) {
> >>
> >>
> >> You are moving the folio_free_swap() call after the folio_ref_count(fo=
lio)
> >> =3D=3D 1 check, which means that such (previously) swapped pages that =
are
> >> exclusive cannot be detected as exclusive.
> >>
> >> There must be a better way to handle MTE here.
> >>
> >> Where are the tags stored, how is the location identified, and when ar=
e they
> >> effectively restored right now?
> >
> > I haven't gone through Peter's patches yet but a pretty good descriptio=
n
> > of the problem is here:
> > https://lore.kernel.org/all/5050805753ac469e8d727c797c2218a9d780d434.ca=
mel@mediatek.com/.
> > I couldn't reproduce it with my swap setup but both Qun-wei and Peter
> > triggered it.
> >
> > When a tagged page is swapped out, the arm64 code stores the metadata
> > (tags) in a local xarray indexed by the swap pte. When restoring from
> > swap, the arm64 set_pte_at() checks this xarray using the old swap pte
> > and spills the tags onto the new page. Apparently something changed in
> > the kernel recently that causes swap_range_free() to be called before
> > set_pte_at(). The arm64 arch_swap_invalidate_page() frees the metadata
> > from the xarray and the subsequent set_pte_at() won't find it.
> >
> > If we have the page, the metadata can be restored before set_pte_at()
> > and I guess that's what Peter is trying to do (again, I haven't looked
> > at the details yet; leaving it for tomorrow).
>
> Thanks for the details! I was missing that we also have a hook in
> swap_range_free().
>
> >
> > Is there any other way of handling this? E.g. not release the metadata
> > in arch_swap_invalidate_page() but later in set_pte_at() once it was
> > restored. But then we may leak this metadata if there's no set_pte_at()
> > (the process mapping the swap entry died).
>
> That was my immediate thought: do we really have to hook into
> swap_range_free() at all?

As I alluded to in another reply, without the hook in
swap_range_free() I think we would either end up with a race or an
effective memory leak in the arch code that maintains the metadata for
swapped out pages, as there would be no way for the arch-specific code
to know when it is safe to free it after swapin.

> And I also wondered why we have to do this
> from set_pte_at() and not do this explicitly (maybe that's the other
> arch_* callback on the swapin path).

I don't think it's necessary, as the set_pte_at() call sites for
swapped in pages are known. I'd much rather do this via an explicit
hook at those call sites, as the existing approach of implicit
restoring seems too subtle and easy to be overlooked when refactoring,
as we have seen with this bug. In the end we only have 3 call sites
for the hook and hopefully the comments that I'm adding are sufficient
to ensure that any new swapin code should end up with a call to the
hook in the right place.

Peter

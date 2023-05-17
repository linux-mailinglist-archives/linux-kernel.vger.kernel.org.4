Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14523705CB5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 03:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbjEQB5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 21:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjEQB5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 21:57:40 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FF23AB5
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 18:57:38 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1aaf702c3ccso36965ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 18:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684288658; x=1686880658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m17guDOQ12FqooxLGjI6njqGM315YV7VFvugPBs5F1U=;
        b=G2g3cTJEzvXtAGyeMhLS3Tp9CGxqFe6bTGp67/QaCOul7DNRgJGVysoeOKGC6MU8Nb
         hcrR9i5M+H1GAD6TiKPgXwlBK2V4d6vyMIHTJ0OLyBi1jK65vk+LYjCEeImS/ubCtS8I
         Xk6hgCWAsni/4am19MdEQGg1M/jj6BqX/ao6Sjgx/2/jffC2BBbPodTR+rwFNr1yLpr9
         gzee4ygUv8v7j5MaMN3CO+z3tx3czXQR8M7yLggRMS8L15H8eOJefxg3AxRD9XVtqRew
         uzL7IMLaRr+A2T694VFyzbxIx/Bzg3Z8L9Ex5UWi+KcvOKpiPj0GhcXopupfoJUwKyLG
         J0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684288658; x=1686880658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m17guDOQ12FqooxLGjI6njqGM315YV7VFvugPBs5F1U=;
        b=a4g2ZQK/eDN1jse17GOaXytiA3SbtXWq5/yu+PQR+MyOSP72cMBu/fVfDpVQs4iZnQ
         AN+mlut33MHKEzBr/BThhNvB8XnS9kDphpdfvPYTa+8UMSwEqq+j8m4lIAiiLd3PNgq6
         WMr+l3rKT1flEbkovzEPJwthMUNRQ6l1hf9NXHP8zVVl9l2nD661WvVy7nRVxcesxJUP
         lMhTHp/EK4qzmn1sLGnTbGy5dcIZXTds1sN1yjOTlc154PGKMp/L9DCFyNvs1q8mJW8H
         1O3s77560ZchPWKaR14RwozrNUdacBi95cFVFu1fgA1PY0sXHvxiFX6jD13l2tXbTJMt
         3mRg==
X-Gm-Message-State: AC+VfDwTkFUUA2TqYWC/exSkyQii/L8EJKCDs1gBKFXWL1Ac6mk387Ue
        oKwdfAUBItqV6LxytOoDsouKmnUo//j8IPHh012BPg==
X-Google-Smtp-Source: ACHHUZ5TQRoxJBA+VrCOoj6SjVxOZ9tveqCruPZC8f50f90jN5fWSAtn66U8gRT/dRMCPRrIuOzIJoSdzUpr6zs+1O0=
X-Received: by 2002:a17:902:ea09:b0:1ae:513a:944d with SMTP id
 s9-20020a170902ea0900b001ae513a944dmr71548plg.8.1684288657779; Tue, 16 May
 2023 18:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230512235755.1589034-1-pcc@google.com> <20230512235755.1589034-2-pcc@google.com>
 <7471013e-4afb-e445-5985-2441155fc82c@redhat.com> <ZGJtJobLrBg3PtHm@arm.com>
 <ZGLC0T32sgVkG5kX@google.com> <851940cd-64f1-9e59-3de9-b50701a99281@redhat.com>
In-Reply-To: <851940cd-64f1-9e59-3de9-b50701a99281@redhat.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Tue, 16 May 2023 18:57:26 -0700
Message-ID: <CAMn1gO79e+v3ceNY0YfwrYTvU1monKWmTedXsYjtucmM7s=MVA@mail.gmail.com>
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 5:35=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 16.05.23 01:40, Peter Collingbourne wrote:
> > On Mon, May 15, 2023 at 06:34:30PM +0100, Catalin Marinas wrote:
> >> On Sat, May 13, 2023 at 05:29:53AM +0200, David Hildenbrand wrote:
> >>> On 13.05.23 01:57, Peter Collingbourne wrote:
> >>>> diff --git a/mm/memory.c b/mm/memory.c
> >>>> index 01a23ad48a04..83268d287ff1 100644
> >>>> --- a/mm/memory.c
> >>>> +++ b/mm/memory.c
> >>>> @@ -3914,19 +3914,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >>>>                    }
> >>>>            }
> >>>> -  /*
> >>>> -   * Remove the swap entry and conditionally try to free up the swa=
pcache.
> >>>> -   * We're already holding a reference on the page but haven't mapp=
ed it
> >>>> -   * yet.
> >>>> -   */
> >>>> -  swap_free(entry);
> >>>> -  if (should_try_to_free_swap(folio, vma, vmf->flags))
> >>>> -          folio_free_swap(folio);
> >>>> -
> >>>> -  inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
> >>>> -  dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
> >>>>            pte =3D mk_pte(page, vma->vm_page_prot);
> >>>> -
> >>>>            /*
> >>>>             * Same logic as in do_wp_page(); however, optimize for p=
ages that are
> >>>>             * certainly not shared either because we just allocated =
them without
> >>>> @@ -3946,8 +3934,21 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >>>>                    pte =3D pte_mksoft_dirty(pte);
> >>>>            if (pte_swp_uffd_wp(vmf->orig_pte))
> >>>>                    pte =3D pte_mkuffd_wp(pte);
> >>>> +  arch_do_swap_page(vma->vm_mm, vma, vmf->address, pte, vmf->orig_p=
te);
> >>>>            vmf->orig_pte =3D pte;
> >>>> +  /*
> >>>> +   * Remove the swap entry and conditionally try to free up the swa=
pcache.
> >>>> +   * We're already holding a reference on the page but haven't mapp=
ed it
> >>>> +   * yet.
> >>>> +   */
> >>>> +  swap_free(entry);
> >>>> +  if (should_try_to_free_swap(folio, vma, vmf->flags))
> >>>> +          folio_free_swap(folio);
> >>>> +
> >>>> +  inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
> >>>> +  dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
> >>>> +
> >>>>            /* ksm created a completely new copy */
> >>>>            if (unlikely(folio !=3D swapcache && swapcache)) {
> >>>>                    page_add_new_anon_rmap(page, vma, vmf->address);
> >>>> @@ -3959,7 +3960,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >>>>            VM_BUG_ON(!folio_test_anon(folio) ||
> >>>>                            (pte_write(pte) && !PageAnonExclusive(pag=
e)));
> >>>>            set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
> >>>> -  arch_do_swap_page(vma->vm_mm, vma, vmf->address, pte, vmf->orig_p=
te);
> >>>>            folio_unlock(folio);
> >>>>            if (folio !=3D swapcache && swapcache) {
> >>>
> >>>
> >>> You are moving the folio_free_swap() call after the folio_ref_count(f=
olio)
> >>> =3D=3D 1 check, which means that such (previously) swapped pages that=
 are
> >>> exclusive cannot be detected as exclusive.
> >>>
> >>> There must be a better way to handle MTE here.
> >>>
> >>> Where are the tags stored, how is the location identified, and when a=
re they
> >>> effectively restored right now?
> >>
> >> I haven't gone through Peter's patches yet but a pretty good descripti=
on
> >> of the problem is here:
> >> https://lore.kernel.org/all/5050805753ac469e8d727c797c2218a9d780d434.c=
amel@mediatek.com/.
> >> I couldn't reproduce it with my swap setup but both Qun-wei and Peter
> >> triggered it.
> >
> > In order to reproduce this bug it is necessary for the swap slot cache
> > to be disabled, which is unlikely to occur during normal operation. I
> > was only able to reproduce the bug by disabling it forcefully with the
> > following patch:
> >
> > diff --git a/mm/swap_slots.c b/mm/swap_slots.c
> > index 0bec1f705f8e0..25afba16980c7 100644
> > --- a/mm/swap_slots.c
> > +++ b/mm/swap_slots.c
> > @@ -79,7 +79,7 @@ void disable_swap_slots_cache_lock(void)
> >
> >   static void __reenable_swap_slots_cache(void)
> >   {
> > -     swap_slot_cache_enabled =3D has_usable_swap();
> > +     swap_slot_cache_enabled =3D false;
> >   }
> >
> >   void reenable_swap_slots_cache_unlock(void)
> >
> > With that I can trigger the bug on an MTE-utilizing process by running
> > a program that enumerates the process's private anonymous mappings and
> > calls process_madvise(MADV_PAGEOUT) on all of them.
> >
> >> When a tagged page is swapped out, the arm64 code stores the metadata
> >> (tags) in a local xarray indexed by the swap pte. When restoring from
> >> swap, the arm64 set_pte_at() checks this xarray using the old swap pte
> >> and spills the tags onto the new page. Apparently something changed in
> >> the kernel recently that causes swap_range_free() to be called before
> >> set_pte_at(). The arm64 arch_swap_invalidate_page() frees the metadata
> >> from the xarray and the subsequent set_pte_at() won't find it.
> >>
> >> If we have the page, the metadata can be restored before set_pte_at()
> >> and I guess that's what Peter is trying to do (again, I haven't looked
> >> at the details yet; leaving it for tomorrow).
> >>
> >> Is there any other way of handling this? E.g. not release the metadata
> >> in arch_swap_invalidate_page() but later in set_pte_at() once it was
> >> restored. But then we may leak this metadata if there's no set_pte_at(=
)
> >> (the process mapping the swap entry died).
> >
> > Another problem that I can see with this approach is that it does not
> > respect reference counts for swap entries, and it's unclear whether tha=
t
> > can be done in a non-racy fashion.
> >
> > Another approach that I considered was to move the hook to swap_readpag=
e()
> > as in the patch below (sorry, it only applies to an older version
> > of Android's android14-6.1 branch and not mainline, but you get the
> > idea). But during a stress test (running the aforementioned program tha=
t
> > calls process_madvise(MADV_PAGEOUT) in a loop during an Android "monkey=
"
> > test) I discovered the following racy use-after-free that can occur whe=
n
> > two tasks T1 and T2 concurrently restore the same page:
> >
> > T1:                  | T2:
> > arch_swap_readpage() |
> >                       | arch_swap_readpage() -> mte_restore_tags() -> x=
e_load()
> > swap_free()          |
> >                       | arch_swap_readpage() -> mte_restore_tags() -> m=
te_restore_page_tags()
> >
> > We can avoid it by taking the swap_info_struct::lock spinlock in
> > mte_restore_tags(), but it seems like it would lead to lock contention.
> >
>
> Would the idea be to fail swap_readpage() on the one that comes last,
> simply retrying to lookup the page?

The idea would be that T2's arch_swap_readpage() could potentially not
find tags if it ran after swap_free(), so T2 would produce a page
without restored tags. But that wouldn't matter, because T1 reaching
swap_free() means that T2 will follow the goto at [1] after waiting
for T1 to unlock at [2], and T2's page will be discarded.

> This might be a naive question, but how does MTE play along with shared
> anonymous pages?

It should work fine. shmem_writepage() calls swap_writepage() which
calls arch_prepare_to_swap() to write the tags. And
shmem_swapin_folio() has a call to arch_swap_restore() to restore
them.

Peter

[1] https://github.com/torvalds/linux/blob/f1fcbaa18b28dec10281551dfe6ed3a3=
ed80e3d6/mm/memory.c#L3881
[2] https://github.com/torvalds/linux/blob/f1fcbaa18b28dec10281551dfe6ed3a3=
ed80e3d6/mm/memory.c#L4006

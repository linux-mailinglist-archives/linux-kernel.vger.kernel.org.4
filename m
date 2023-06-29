Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8001D742B05
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 19:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbjF2RFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 13:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF2RFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 13:05:41 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585403586;
        Thu, 29 Jun 2023 10:05:39 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-666e6541c98so861713b3a.2;
        Thu, 29 Jun 2023 10:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688058339; x=1690650339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZS1h+GLsux7NMVsZtF2S2RchX2UslLK1KYof85n+JhM=;
        b=bG0qwUOqWDPE+kRS2qLCQY6nlFST2gYe0VXrsvsG+6YmDFnsDxlbpYErzclQdtyfpx
         AcYxR1lGeJu17F6rGiZeJ03nN3yxh/NsKmMd9D3LNsiQLyn+5o8a4y188zAE7KtNbEqu
         xYxodMxtyPBMUQemobiJdnEnpDR3a7aEx639VY4SkntkNJG4Vx6JKsf3BuR4lIo0VkRU
         i5aJ7zIuzoct9EIb+tLnJXdE2Ys4/UfTfPvjimgM1Jt4QeHNX6OCjfa9Qh2Jbl3joIT5
         WAw1bVfqpzf2WHwIO7tQFsgG3Euir3haadRHKKaEQGf/xpPYVRsRyuMx3Wg9rAr+rW4v
         Fz/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688058339; x=1690650339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZS1h+GLsux7NMVsZtF2S2RchX2UslLK1KYof85n+JhM=;
        b=FaB9APSFZIsRz48F6g+OpOMlD5Qv2/uV2tdwlmJ8VAE5QrO3xEffVh67Jjqv6MeTNr
         P7LmGxEzGIdopno1AfLKQ/Y9+13bWtpad7OlFWK5m6m5+ufawQIM7hJjxa2d1FIQhnJp
         FUGLuWgFNyv1TEFMJAKhIu5HA56R506qq7QgUj2UTvcmvSqI+XiPugmkutew5Bs+z0LK
         KyisxmLfqshp+MUPhNysGtWs42vqcvewe349IjU/FEhCao8UCrm0fhp0OUcYiVcCBclT
         KesN25ESztfbtuCGJD7uLVXM/+fGJgtB6c9EEH9dhEacQNMqP0lGMwa0x6jixMAZsagO
         PqVQ==
X-Gm-Message-State: ABy/qLbDHLYrbiTuo6nAUU3cqQhVa1w2weDxOjj0Uhpb0eRQfLiprY4R
        +5t9lh+YC66xLgZJmhHD+bgqRsEga4Qc47E63NE=
X-Google-Smtp-Source: APBJJlF50Q1V5JoExNYTh3LhEFoqNDfSFaN+MYQk8OvzMfcUOza8XaCmFa7u3rQ9C1bNO0iXnHoWCKksQ0Rv4uCfRx4=
X-Received: by 2002:a05:6a00:801:b0:682:4edf:b9c7 with SMTP id
 m1-20020a056a00080100b006824edfb9c7mr646421pfk.2.1688058338518; Thu, 29 Jun
 2023 10:05:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230626171430.3167004-1-ryan.roberts@arm.com>
 <20230626171430.3167004-11-ryan.roberts@arm.com> <CAHbLzkoZf=5PLrC0HNT4Owy=xM4HfA9HDjdCHC+h5RYXUwp0gw@mail.gmail.com>
 <bfd1de51-d445-5861-f69f-13d740651f8e@arm.com>
In-Reply-To: <bfd1de51-d445-5861-f69f-13d740651f8e@arm.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 29 Jun 2023 10:05:26 -0700
Message-ID: <CAHbLzkqKSoncVUqj7vY-Yt6H5=x-uLfDNJhRSRssGK5sKu5Ckg@mail.gmail.com>
Subject: Re: [PATCH v1 10/10] mm: Allocate large folios for anonymous memory
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 4:30=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 29/06/2023 03:13, Yang Shi wrote:
> > On Mon, Jun 26, 2023 at 10:15=E2=80=AFAM Ryan Roberts <ryan.roberts@arm=
.com> wrote:
> >>
> >> With all of the enabler patches in place, modify the anonymous memory
> >> write allocation path so that it opportunistically attempts to allocat=
e
> >> a large folio up to `max_anon_folio_order()` size (This value is
> >> ultimately configured by the architecture). This reduces the number of
> >> page faults, reduces the size of (e.g. LRU) lists, and generally
> >> improves performance by batching what were per-page operations into
> >> per-(large)-folio operations.
> >>
> >> If CONFIG_LARGE_ANON_FOLIO is not enabled (the default) then
> >> `max_anon_folio_order()` always returns 0, meaning we get the existing
> >> allocation behaviour.
> >>
> >> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >> ---
> >>  mm/memory.c | 159 +++++++++++++++++++++++++++++++++++++++++++++++----=
-
> >>  1 file changed, 144 insertions(+), 15 deletions(-)
> >>
> >> diff --git a/mm/memory.c b/mm/memory.c
> >> index a8f7e2b28d7a..d23c44cc5092 100644
> >> --- a/mm/memory.c
> >> +++ b/mm/memory.c
> >> @@ -3161,6 +3161,90 @@ static inline int max_anon_folio_order(struct v=
m_area_struct *vma)
> >>                 return CONFIG_LARGE_ANON_FOLIO_NOTHP_ORDER_MAX;
> >>  }
> >>
> >> +/*
> >> + * Returns index of first pte that is not none, or nr if all are none=
.
> >> + */
> >> +static inline int check_ptes_none(pte_t *pte, int nr)
> >> +{
> >> +       int i;
> >> +
> >> +       for (i =3D 0; i < nr; i++) {
> >> +               if (!pte_none(ptep_get(pte++)))
> >> +                       return i;
> >> +       }
> >> +
> >> +       return nr;
> >> +}
> >> +
> >> +static int calc_anon_folio_order_alloc(struct vm_fault *vmf, int orde=
r)
> >> +{
> >> +       /*
> >> +        * The aim here is to determine what size of folio we should a=
llocate
> >> +        * for this fault. Factors include:
> >> +        * - Order must not be higher than `order` upon entry
> >> +        * - Folio must be naturally aligned within VA space
> >> +        * - Folio must not breach boundaries of vma
> >> +        * - Folio must be fully contained inside one pmd entry
> >> +        * - Folio must not overlap any non-none ptes
> >> +        *
> >> +        * Additionally, we do not allow order-1 since this breaks ass=
umptions
> >> +        * elsewhere in the mm; THP pages must be at least order-2 (si=
nce they
> >> +        * store state up to the 3rd struct page subpage), and these p=
ages must
> >> +        * be THP in order to correctly use pre-existing THP infrastru=
cture such
> >> +        * as folio_split().
> >> +        *
> >> +        * As a consequence of relying on the THP infrastructure, if t=
he system
> >> +        * does not support THP, we always fallback to order-0.
> >> +        *
> >> +        * Note that the caller may or may not choose to lock the pte.=
 If
> >> +        * unlocked, the calculation should be considered an estimate =
that will
> >> +        * need to be validated under the lock.
> >> +        */
> >> +
> >> +       struct vm_area_struct *vma =3D vmf->vma;
> >> +       int nr;
> >> +       unsigned long addr;
> >> +       pte_t *pte;
> >> +       pte_t *first_set =3D NULL;
> >> +       int ret;
> >> +
> >> +       if (has_transparent_hugepage()) {
> >> +               order =3D min(order, PMD_SHIFT - PAGE_SHIFT);
> >> +
> >> +               for (; order > 1; order--) {
> >> +                       nr =3D 1 << order;
> >> +                       addr =3D ALIGN_DOWN(vmf->address, nr << PAGE_S=
HIFT);
> >> +                       pte =3D vmf->pte - ((vmf->address - addr) >> P=
AGE_SHIFT);
> >> +
> >> +                       /* Check vma bounds. */
> >> +                       if (addr < vma->vm_start ||
> >> +                           addr + (nr << PAGE_SHIFT) > vma->vm_end)
> >> +                               continue;
> >> +
> >> +                       /* Ptes covered by order already known to be n=
one. */
> >> +                       if (pte + nr <=3D first_set)
> >> +                               break;
> >> +
> >> +                       /* Already found set pte in range covered by o=
rder. */
> >> +                       if (pte <=3D first_set)
> >> +                               continue;
> >> +
> >> +                       /* Need to check if all the ptes are none. */
> >> +                       ret =3D check_ptes_none(pte, nr);
> >> +                       if (ret =3D=3D nr)
> >> +                               break;
> >> +
> >> +                       first_set =3D pte + ret;
> >> +               }
> >> +
> >> +               if (order =3D=3D 1)
> >> +                       order =3D 0;
> >> +       } else
> >> +               order =3D 0;
> >> +
> >> +       return order;
> >> +}
> >> +
> >>  /*
> >>   * Handle write page faults for pages that can be reused in the curre=
nt vma
> >>   *
> >> @@ -4201,6 +4285,9 @@ static vm_fault_t do_anonymous_page(struct vm_fa=
ult *vmf)
> >>         struct folio *folio;
> >>         vm_fault_t ret =3D 0;
> >>         pte_t entry;
> >> +       unsigned long addr;
> >> +       int order =3D uffd_wp ? 0 : max_anon_folio_order(vma);
> >> +       int pgcount =3D BIT(order);
> >>
> >>         /* File mapping without ->vm_ops ? */
> >>         if (vma->vm_flags & VM_SHARED)
> >> @@ -4242,24 +4329,44 @@ static vm_fault_t do_anonymous_page(struct vm_=
fault *vmf)
> >>                         pte_unmap_unlock(vmf->pte, vmf->ptl);
> >>                         return handle_userfault(vmf, VM_UFFD_MISSING);
> >>                 }
> >> -               goto setpte;
> >> +               if (uffd_wp)
> >> +                       entry =3D pte_mkuffd_wp(entry);
> >> +               set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
> >> +
> >> +               /* No need to invalidate - it was non-present before *=
/
> >> +               update_mmu_cache(vma, vmf->address, vmf->pte);
> >> +               goto unlock;
> >>         }
> >>
> >> -       /* Allocate our own private page. */
> >> +retry:
> >> +       /*
> >> +        * Estimate the folio order to allocate. We are not under the =
ptl here
> >> +        * so this estiamte needs to be re-checked later once we have =
the lock.
> >> +        */
> >> +       vmf->pte =3D pte_offset_map(vmf->pmd, vmf->address);
> >> +       order =3D calc_anon_folio_order_alloc(vmf, order);
> >> +       pte_unmap(vmf->pte);
> >> +
> >> +       /* Allocate our own private folio. */
> >>         if (unlikely(anon_vma_prepare(vma)))
> >>                 goto oom;
> >> -       folio =3D vma_alloc_zeroed_movable_folio(vma, vmf->address, 0,=
 0);
> >> +       folio =3D try_vma_alloc_movable_folio(vma, vmf->address, order=
, true);
> >>         if (!folio)
> >>                 goto oom;
> >>
> >> +       /* We may have been granted less than we asked for. */
> >> +       order =3D folio_order(folio);
> >> +       pgcount =3D BIT(order);
> >> +       addr =3D ALIGN_DOWN(vmf->address, pgcount << PAGE_SHIFT);
> >> +
> >>         if (mem_cgroup_charge(folio, vma->vm_mm, GFP_KERNEL))
> >>                 goto oom_free_page;
> >>         folio_throttle_swaprate(folio, GFP_KERNEL);
> >>
> >>         /*
> >>          * The memory barrier inside __folio_mark_uptodate makes sure =
that
> >> -        * preceding stores to the page contents become visible before
> >> -        * the set_pte_at() write.
> >> +        * preceding stores to the folio contents become visible befor=
e
> >> +        * the set_ptes() write.
> >>          */
> >>         __folio_mark_uptodate(folio);
> >>
> >> @@ -4268,11 +4375,31 @@ static vm_fault_t do_anonymous_page(struct vm_=
fault *vmf)
> >>         if (vma->vm_flags & VM_WRITE)
> >>                 entry =3D pte_mkwrite(pte_mkdirty(entry));
> >>
> >> -       vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->ad=
dress,
> >> -                       &vmf->ptl);
> >> -       if (vmf_pte_changed(vmf)) {
> >> -               update_mmu_tlb(vma, vmf->address, vmf->pte);
> >> -               goto release;
> >> +       vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf->pmd, addr, &=
vmf->ptl);
> >> +
> >> +       /*
> >> +        * Ensure our estimate above is still correct; we could have r=
aced with
> >> +        * another thread to service a fault in the region.
> >> +        */
> >> +       if (order =3D=3D 0) {
> >> +               if (vmf_pte_changed(vmf)) {
> >> +                       update_mmu_tlb(vma, vmf->address, vmf->pte);
> >> +                       goto release;
> >> +               }
> >> +       } else if (check_ptes_none(vmf->pte, pgcount) !=3D pgcount) {
> >> +               pte_t *pte =3D vmf->pte + ((vmf->address - addr) >> PA=
GE_SHIFT);
> >> +
> >> +               /* If faulting pte was allocated by another, exit earl=
y. */
> >> +               if (!pte_none(ptep_get(pte))) {
> >> +                       update_mmu_tlb(vma, vmf->address, pte);
> >> +                       goto release;
> >> +               }
> >> +
> >> +               /* Else try again, with a lower order. */
> >> +               pte_unmap_unlock(vmf->pte, vmf->ptl);
> >> +               folio_put(folio);
> >> +               order--;
> >> +               goto retry;
> >
> > I'm not sure whether this extra fallback logic is worth it or not. Do
> > you have any benchmark data or is it just an arbitrary design choice?
> > If it is just an arbitrary design choice, I'd like to go with the
> > simplest way by just exiting page fault handler, just like the
> > order-0, IMHO.
>
> Yes, its an arbitrary design choice. Based on Yu Zhao's feedback, I'm alr=
eady
> reworking this so that we only try the preferred order and order-0, so no=
 longer
> iterating through intermediate orders.
>
> I think what you are suggesting is that if attempting to allocate the pre=
ferred
> order and we find there was a race meaning that the folio now is overlapp=
ing
> populated ptes (but the faulting pte is still empty), just exit and rely =
on the
> page fault being re-triggered, rather than immediately falling back to or=
der-0?

The faulting PTE might be filled too. Yes, just exit and rely on the
CPU re-trigger page fault.

>
> The reason I didn't do that was I wasn't sure if the return path might ha=
ve
> assumptions that the faulting pte is now valid if no error was returned? =
I guess
> another option is to return VM_FAULT_RETRY but then it seemed cleaner to =
do the
> retry directly here. What do you suggest?

IIRC as long as the page fault handler doesn't return any error, it is
safe to rely on CPU re-trigger page fault if PTE is not installed.

VM_FAULT_RETRY means the page fault handler released mmap_lock (or
per-VMA lock with per-VMA lock enabled) due to waiting for page lock.
TBH I really don't want to make that semantic more complicated and
overloaded. And I don't see any fundamental difference between
vmf_pte_changed() for order-0 folio and overlapping PTEs installed for
large folio. So I'd like to follow the same behavior.

>
> Thanks,
> Ryan
>
>
>
> >
> >>         }
> >>
> >>         ret =3D check_stable_address_space(vma->vm_mm);
> >> @@ -4286,16 +4413,18 @@ static vm_fault_t do_anonymous_page(struct vm_=
fault *vmf)
> >>                 return handle_userfault(vmf, VM_UFFD_MISSING);
> >>         }
> >>
> >> -       inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
> >> -       folio_add_new_anon_rmap(folio, vma, vmf->address);
> >> +       folio_ref_add(folio, pgcount - 1);
> >> +
> >> +       add_mm_counter(vma->vm_mm, MM_ANONPAGES, pgcount);
> >> +       folio_add_new_anon_rmap_range(folio, &folio->page, pgcount, vm=
a, addr);
> >>         folio_add_lru_vma(folio, vma);
> >> -setpte:
> >> +
> >>         if (uffd_wp)
> >>                 entry =3D pte_mkuffd_wp(entry);
> >> -       set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
> >> +       set_ptes(vma->vm_mm, addr, vmf->pte, entry, pgcount);
> >>
> >>         /* No need to invalidate - it was non-present before */
> >> -       update_mmu_cache(vma, vmf->address, vmf->pte);
> >> +       update_mmu_cache_range(vma, addr, vmf->pte, pgcount);
> >>  unlock:
> >>         pte_unmap_unlock(vmf->pte, vmf->ptl);
> >>         return ret;
> >> --
> >> 2.25.1
> >>
> >>
>

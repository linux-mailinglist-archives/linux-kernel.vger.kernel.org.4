Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1897565F5CE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 22:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235860AbjAEVar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 16:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235876AbjAEVaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 16:30:25 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D7A671AC
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 13:30:20 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id gh17so93116327ejb.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 13:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FRP/mX962STUK321mpeU50nn6oPw08vUlbjW7zSBJUo=;
        b=H8+sEkzDmA7mHmQvUl3Hf0o0FAopE7JrCKUhAI7mmyVqUTUV3yh4eWYHNLrMLVIJ01
         s2veyj/WiqI/rAbBfKFD41jlEVPXQC19DmJq095jltPT6bz1GV7BqKmUIay4r3IfPD+1
         ElaFz+Mwb7xSwXikGQyq8R53kcKQfQSKwDlUoO73PGDRIy5vi+AVhVKQ09ww16OMG41D
         odffVnwpqhwcZhL0W9nxRNWOocPmJBYp8Z+r3gJ2+43aXNYUrInC+s7QMU8riXVC+YWN
         RONnR+cFa/4V+7C4p7vRQobTfggZSkgJYBWMJHqtujm+4eiQ3amYnFtuWqDN2fFHJ2N7
         CXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FRP/mX962STUK321mpeU50nn6oPw08vUlbjW7zSBJUo=;
        b=lHr6gs1eqAsBw7J5Me5qSGlYk+PtIPNiMcR6Z1dqqYyAMfLoLNHPzqRSOwKF01k5nQ
         DYIp7Sds4eGo9fo0BoVjBC/mi4asXalAQGkgaEXYuqHfOXJHeeg09xUZEeMoRiCETPnd
         tJS+WHoA+Cmdov3vi7kiryS3zv/VUeKP87uFtLoPrkSzstnSRKS4PDMFDdBHTueQ6xDh
         qJlHNojYhjAEW05q+1GtaI2yGEsD5d5TK49dXdpG8p8rbfErg6cMgTs6VV8So55r3Ubd
         4PqN5imOsP9E0FLLhzcBDWHtK8sYdAjnO/D/TR4ADBG1jnH4yZEC3flN1ELIOO3Td3qW
         JkuA==
X-Gm-Message-State: AFqh2kpa4WyD+Jm42XzZg79APtufR7MHQAW/2QxgFe7Eie1YbafUpkX6
        nVj0KEkEbVhmxSyka4Sny6+BFUfw0tEXeniQCTzGgQ==
X-Google-Smtp-Source: AMrXdXs0t11iLYiYEHSCL6QU9tLJ3ykx0zU9z0O6SERSQWARYTBayiBvmx61EHHb7VREcTWjhSDMGBT0hP3G/FEWrrY=
X-Received: by 2002:a17:906:4e98:b0:82d:e2a6:b04 with SMTP id
 v24-20020a1709064e9800b0082de2a60b04mr6597531eju.748.1672954219280; Thu, 05
 Jan 2023 13:30:19 -0800 (PST)
MIME-Version: 1.0
References: <b740c9fb-edba-92ba-59fb-7a5592e5dfc@google.com>
 <dc9f7bb0-77d4-8b0e-c6b6-ece3f77ed326@redhat.com> <32be06f-f64-6632-4c36-bed7c0695a3b@google.com>
 <7ff97950-b524-db06-9ad6-e98b80dcfefa@redhat.com> <CAHbLzkqjooxnAwqK7vZoJpP2bSUTCUgv3UtWsZgo444jpGSfoA@mail.gmail.com>
 <86d5f618-800d-9672-56c4-9309ef222a39@redhat.com>
In-Reply-To: <86d5f618-800d-9672-56c4-9309ef222a39@redhat.com>
From:   "Zach O'Keefe" <zokeefe@google.com>
Date:   Thu, 5 Jan 2023 13:29:42 -0800
Message-ID: <CAAa6QmSByYrWkp+8K0NK+pocKT0CVj83RaVUB1VqMPvuPHnpNQ@mail.gmail.com>
Subject: Re: [PATCH] mm/khugepaged: fix collapse_pte_mapped_thp() to allow anon_vma
To:     David Hildenbrand <david@redhat.com>
Cc:     Yang Shi <shy828301@gmail.com>, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
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

On Thu, Jan 5, 2023 at 2:44 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 05.01.23 01:03, Yang Shi wrote:
> > On Wed, Jan 4, 2023 at 1:20 AM David Hildenbrand <david@redhat.com> wrote:
> >>
> >>>> Or am I wrong?
> >>>>
> >>>>> Is anon_vma lock required?  Almost not: if any page other than expected
> >>>>> subpage of the non-anon huge page is found in the page table, collapse is
> >>>>> aborted without making any change.  However, it is possible that an anon
> >>>>> page was CoWed from this extent in another mm or vma, in which case a
> >>>>> concurrent lookup might look here: so keep it away while clearing pmd
> >>>>> (but perhaps we shall go back to using pmd_lock() there in future).
> >>>>>
> >>>>> Note that collapse_pte_mapped_thp() is exceptional in freeing a page table
> >>>>> without having cleared its ptes: I'm uneasy about that, and had thought
> >>>>> pte_clear()ing appropriate; but exclusive i_mmap lock does fix the problem,
> >>>>> and we would have to move the mmu_notification if clearing those ptes.
> >>>>>
> >>>>> Fixes: 8d3c106e19e8 ("mm/khugepaged: take the right locks for page table
> >>>>> retraction")
> >>>>> Signed-off-by: Hugh Dickins <hughd@google.com>
> >>>>> Cc: Jann Horn <jannh@google.com>
> >>>>> Cc: Yang Shi <shy828301@gmail.com>
> >>>>> Cc: David Hildenbrand <david@redhat.com>
> >>>>> Cc: Zach O'Keefe <zokeefe@google.com>
> >>>>> Cc: Song Liu <songliubraving@fb.com>
> >>>>> Cc: <stable@vger.kernel.org>    [5.4+]
> >>>>> ---
> >>>>> What this fixes is not a dangerous instability!  But I suggest Cc stable
> >>>>> because uprobes "healing" has regressed in that way, so this should follow
> >>>>> 8d3c106e19e8 into those stable releases where it was backported (and may
> >>>>> want adjustment there - I'll supply backports as needed).
> >>>>
> >>>> If it's really something that doesn't matter in practice (e.g., -1%
> >>>> performance while debugging :) ), I guess no CC is needed. If there are real
> >>>> production workloads that suffer, I guess ccing stable is fine.
> >>>
> >>> It's about recovering performance *after* debugging.  It is not something
> >>> that is of any value to me personally, nor (so far as I know) to anyone
> >>> whom I work with.  But it is something which Song Liu went to the trouble
> >>> to make possible in his "THP aware uprobe" series three years ago, and it
> >>> is something which Jann unintentionally regressed in his recent commit:
> >>> so I thought it proper to reinstate where regressed.
> >>
> >> Right, although I wonder if that original series fixed a real
> >> performance issue or was more a "this makes sense, let's just optimize
> >> this corner case by some serious complexity". I hope it's not the latter :)
> >>
> >>>
> >>> (What I do have more of an investment in, is for MADV_COLLAPSE to be able
> >>> to collapse some extents in a large vma where some other extent got CoWed,
> >>> so giving the whole vma an anon_vma.  But that's not an issue for -stable,
> >>> and I cannot tell you offhand whether undoing this anon_vma exclusion is
> >>> enough to enable that or not - I suspect not, I suspect a result code or
> >>> switch statement needs to be adjusted too.)
> >>
> >> Yeah, having a single COWed page in a large MAP_PRIVATE file/shmem
> >> mapping would disable collapse, so it's the right thing to do.
> >>
> >> Thinking about it some more, and the effective code change, stable
> >> doesn't sound wrong.
> >>
> >>>>
> >>>>
> >>>> Side note: set_huge_pmd() wins the award of "ugliest mm function of early
> >>>> 2023". I was briefly concerned how do_set_pmd() decides whether the PMD can be
> >>>> writable or not. Turns out it's communicated via vm_fault->flags. Just
> >>>> horrible.

My first Linux award! :) At least it's not "worst mm security issue of
early 2023". I'll take it!

> >>>
> >>> I firmly disagree - it's from 2022! and much too small to be ugliest;
> >>> but I haven't thought about the aspect that is bothering you there.
> >>
> >> The ugliest I stumbled over in early 2023 -- until January 2nd :D
> >>
> >>>
> >>> What's bothered me most about it, is the way its name, and the naming of
> >>> the do_set_pmd() it interfaces with, give no hint that they are entirely
> >>> about file (or shmem) vmas, and would not work right on anon vmas
> >>> (I forget whether it's just a matter of which stats updated, or more).
> >>
> >> Yes. I dug very deep into in-place collapse yesterday because I was
> >> briefly concerned about anon THP, and it took me longer to understand
> >> that whole machinery than it should (and that anon THP never ever
> >> collapse in-place).
> >>
> >> Some of that khugepaged stuff needs some *serious* cleanups and
> >> refactoring. do_set_pmd() is not an exception.
> >>
> >>
> >> Some more examples:
> >>
> >> if (IS_ENABLED(CONFIG_SHMEM) && vma->vm_file) {
> >>          ...
> >>          hpage_collapse_scan_file()
> >> } else {
> >>          hpage_collapse_scan_pmd()
> >>          ...
> >> }
> >>
> >>
> >> 1) hpage_collapse_scan_pmd() is only for anon memory. Totally obvious
> >>      from the name. But why are we potentially calling it for VMAs that
> >>      are not applicable? For maximum David confusion?
> >
> > IIRC the VMAs are checked before, what do you mean about "not
> > applicable"? But anyway khugepaged/MADV_COLLAPSE does release and
>
> I assume when CONFIG_SHMEM=n with ordinary file-thp we'll end up calling it.
>
> > reacquire mmap_lock multiple times, so there are multiple places to
> > check VMAs validity.
> >
>
> hpage_collapse_scan_pmd() should be renamed to something like
> hpage_collapse_scan_an/on() and the duplicate code in
> khugepaged_scan_mm_slot() and madvise_collapse() should be factored out
> into something like:
>
> hpage_collapse_scan(vma, addr, cc)
> {
>         if (vma->vm_file) {
>                 ...
>                 hpage_collapse_scan_file()
>                 ...
>         } else if (vma_is_anonymous(vma)) {
>                 hpage_collapse_scan_anon()
>         } else {
>                 WARN_ON_ONCE();
>         }
> }
>
> Any CONFIG_SHMEM etc. optimizations to compile that code out should go
> into hpage_collapse_scan_file() IMHO. ... also properly checking for
> ordinary file THP support.
>
> ... and we'd really decide on a terminology "transhuge", "hugepage",
> "hpage", it's a mess. hpage might be easiest, or simply "thp". We just
> need a way to distinguish all that stuff from hugetlb.
>
> >>
> >> 2) "IS_ENABLED(CONFIG_SHMEM) && vma->vm_file" is also supposed to cover
> >>      ordinary file-thp. Totally obvious from the IS_ENABLED(CONFIG_SHMEM)
> >>      ... I probably spent 30minutes understanding what's happening here.
> >>      Just misleading and wrong without CONFIG_SHMEM.
> >>
> >>
> >> ... and what's easier to get than this magic set of boolean flags:
> >>
> >>          hugepage_vma_check(vma, vma->vm_flags, false, false, true)
> >
> > This is not perfect. I was thinking about changing them to one flag,
> > just like TTU_ flags used by try_to_unmap(). That may make things
> > cleaner.
> >
>
> We should provide similar flags to hugepage_vma_revalidate() and just
> replace the "cc" parameter by a way to indicate is_khugepaged. Passing
> in cc is just overkill.
>
> We'd name the functions thp_vma_validate() and thp_vma_revalidate() or
> sth. like that.
>
> >>
> >> ... and obviously
> >>          hugepage_vma_revalidate()
> >> is supposed to be a follow up to a previous
> >>          hugepage_vma_check()
> >> and totally different from
> >>          transhuge_vma_suitable()
> >>
> >> Hard to make it even less consistent.
> >
> > This was after my cleanup, it was much messier before. And I did add
> > comments to make them more understandable, but anyway better naming is
> > definitely welcome.
>
> Yeah, I appreciate any previous and any future cleanups in that area.

Likewise. I think there's definitely some work that can be done
(though things are actually much better now than they were before
Yang's last cleanup series). One of the issues is that anon and
file/shmem pathways are largely independent here, with very little
overlap, and if you just look at some function in isolation (e.g.
hugepage_vma_revalidate()) it's not clear this is a anon/file-only
function. Renaming with consistent prefixes would help -- among other
things.

> For example: why even *care* about the complexity of installing a PMD in
> collapse_pte_mapped_thp() using set_huge_pmd() just for MADV_COLLAPSE?
>
> Sure, we avoid a single page fault afterwards, but is this *really*
> worth the extra code here? I mean, after we installed the PMD, the page
> could just get reclaimed either way, so there is no guarantee that we
> have a PMD mapped once we return to user space IIUC.

A valid question. The first reason is just semantic symmetry for
MADV_COLLAPSE called on anon vs file/shmem memory. It would be nice to
say that "on success, the memory range provided will be backed by
PMD-mapped hugepages", rather than special-casing file/shmem.

The second reason has a more practical use case. In userfaultfd-based
live migration (using  UFFDIO_REGISTER_MODE_MINOR) pages are migrated
at 4KiB granularity, and it may take a long (O(many minutes)) for the
transfer of all pages to complete. To avoid severe performance
degradation on the target guest, the vmm wants to MADV_COLLAPSE
hugepage-sized regions as they fill up. Since the guest memory is
still uffd-registered, requiring refault post-MADV_COLLAPSE won't
work, since the uffd machinery will intercept the fault, and no PMD
will be mapped. As such, either uffd needs to be taught to install PMD
mappings, or the PMD mapping already must be in-place.

Thanks,
Zach

>
> Anyhow, don't want to hijack this thread. I was just forced to
> understand  that code and a lot jumped at me :)
>
> --
> Thanks,
>
> David / dhildenb
>

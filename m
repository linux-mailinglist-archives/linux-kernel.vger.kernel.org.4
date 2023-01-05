Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08AB65E140
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234653AbjAEAEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjAEAEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:04:09 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A0324F
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 16:04:08 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id e10so9534569pgc.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 16:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xzo023694+wb/S1CfmbkiM0eJ0PtYfUNQ8L6gvd/+XM=;
        b=ECoVNHQ9tvZ7sQeorEUOdiMYYtFLu8QWelJgUOnooA60Qz4p6taWU3HrqcLqbREAIF
         STueb232p1T0VLqbkEo3/Fex4BkmArq2ZJ0cBvvOTv5UI+WFMlB8LRcp5SMQ0D5Q+xsC
         jOdVGno5+5VkcPZuqos5V6+6m6UPKF0XksPm8enhwHqVKbhdBGxIcP8LbHK3T05MwIMt
         DxCa3rqeU4IX8M4XjfFFzAT+BdP8wp7j7/M06rsaGtA+7Iaajh8FQMUHq+5x7XdL+P2a
         JWkz8CAJHrWfSGEGNKP5EndFfFGtAuSZS2Wdgas9oor+4kv7dORz3AE2T6UYvzF8n5fA
         hDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xzo023694+wb/S1CfmbkiM0eJ0PtYfUNQ8L6gvd/+XM=;
        b=SKOcb/Cmt/hhWQ10nIAy1Lv5DDOwDOfSW+fmgP2wX79TXnequQK3PK+i55jzAoQo6P
         +PihZkEwro3EjpcIgY/IOFnPRwQlTdeDDMHAelGhsfPWXtwEB3/sonT9qsiQOzil9Kqk
         WvuvIBZI8zKbzsvyoYwXFtsN0QAhYcRU9YzsRxYOaFqgUp7/QT10q0DhYLlUPzLVu1uQ
         fsrQZX19I7uKySBwsO0oLrN7eFQk609/ZO60pCaDzL49qZNRbtQC8G7lnr4d0Sv8EnKB
         gGMU78AGE7DSMCyOp4OhSzXq3/X4NaTPu90vIwRqQTPqk+2gpo4CXmrchzEJC4Xi4jxB
         jjPA==
X-Gm-Message-State: AFqh2kpe+6llOD4J0Kr5j8k3PL4phTbvOB37Da4LtI8shdEbdfa82god
        /VlRFkhElRZ8W1b723X8AItT/mA0uIacQprlOeRfUcS9
X-Google-Smtp-Source: AMrXdXtecdu7jIJp6vSbE9eunxWy6lBtBRMT1gi8Fv4EOrmHa1+mhG4L333Bxqqs5kiqTqJOgzHbNdxMhvEuz+TFG98=
X-Received: by 2002:a63:1944:0:b0:492:50ad:d177 with SMTP id
 4-20020a631944000000b0049250add177mr3722190pgz.310.1672877048085; Wed, 04 Jan
 2023 16:04:08 -0800 (PST)
MIME-Version: 1.0
References: <b740c9fb-edba-92ba-59fb-7a5592e5dfc@google.com>
 <dc9f7bb0-77d4-8b0e-c6b6-ece3f77ed326@redhat.com> <32be06f-f64-6632-4c36-bed7c0695a3b@google.com>
 <7ff97950-b524-db06-9ad6-e98b80dcfefa@redhat.com>
In-Reply-To: <7ff97950-b524-db06-9ad6-e98b80dcfefa@redhat.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 4 Jan 2023 16:03:56 -0800
Message-ID: <CAHbLzkqjooxnAwqK7vZoJpP2bSUTCUgv3UtWsZgo444jpGSfoA@mail.gmail.com>
Subject: Re: [PATCH] mm/khugepaged: fix collapse_pte_mapped_thp() to allow anon_vma
To:     David Hildenbrand <david@redhat.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 4, 2023 at 1:20 AM David Hildenbrand <david@redhat.com> wrote:
>
> >> Or am I wrong?
> >>
> >>> Is anon_vma lock required?  Almost not: if any page other than expected
> >>> subpage of the non-anon huge page is found in the page table, collapse is
> >>> aborted without making any change.  However, it is possible that an anon
> >>> page was CoWed from this extent in another mm or vma, in which case a
> >>> concurrent lookup might look here: so keep it away while clearing pmd
> >>> (but perhaps we shall go back to using pmd_lock() there in future).
> >>>
> >>> Note that collapse_pte_mapped_thp() is exceptional in freeing a page table
> >>> without having cleared its ptes: I'm uneasy about that, and had thought
> >>> pte_clear()ing appropriate; but exclusive i_mmap lock does fix the problem,
> >>> and we would have to move the mmu_notification if clearing those ptes.
> >>>
> >>> Fixes: 8d3c106e19e8 ("mm/khugepaged: take the right locks for page table
> >>> retraction")
> >>> Signed-off-by: Hugh Dickins <hughd@google.com>
> >>> Cc: Jann Horn <jannh@google.com>
> >>> Cc: Yang Shi <shy828301@gmail.com>
> >>> Cc: David Hildenbrand <david@redhat.com>
> >>> Cc: Zach O'Keefe <zokeefe@google.com>
> >>> Cc: Song Liu <songliubraving@fb.com>
> >>> Cc: <stable@vger.kernel.org>    [5.4+]
> >>> ---
> >>> What this fixes is not a dangerous instability!  But I suggest Cc stable
> >>> because uprobes "healing" has regressed in that way, so this should follow
> >>> 8d3c106e19e8 into those stable releases where it was backported (and may
> >>> want adjustment there - I'll supply backports as needed).
> >>
> >> If it's really something that doesn't matter in practice (e.g., -1%
> >> performance while debugging :) ), I guess no CC is needed. If there are real
> >> production workloads that suffer, I guess ccing stable is fine.
> >
> > It's about recovering performance *after* debugging.  It is not something
> > that is of any value to me personally, nor (so far as I know) to anyone
> > whom I work with.  But it is something which Song Liu went to the trouble
> > to make possible in his "THP aware uprobe" series three years ago, and it
> > is something which Jann unintentionally regressed in his recent commit:
> > so I thought it proper to reinstate where regressed.
>
> Right, although I wonder if that original series fixed a real
> performance issue or was more a "this makes sense, let's just optimize
> this corner case by some serious complexity". I hope it's not the latter :)
>
> >
> > (What I do have more of an investment in, is for MADV_COLLAPSE to be able
> > to collapse some extents in a large vma where some other extent got CoWed,
> > so giving the whole vma an anon_vma.  But that's not an issue for -stable,
> > and I cannot tell you offhand whether undoing this anon_vma exclusion is
> > enough to enable that or not - I suspect not, I suspect a result code or
> > switch statement needs to be adjusted too.)
>
> Yeah, having a single COWed page in a large MAP_PRIVATE file/shmem
> mapping would disable collapse, so it's the right thing to do.
>
> Thinking about it some more, and the effective code change, stable
> doesn't sound wrong.
>
> >>
> >>
> >> Side note: set_huge_pmd() wins the award of "ugliest mm function of early
> >> 2023". I was briefly concerned how do_set_pmd() decides whether the PMD can be
> >> writable or not. Turns out it's communicated via vm_fault->flags. Just
> >> horrible.
> >
> > I firmly disagree - it's from 2022! and much too small to be ugliest;
> > but I haven't thought about the aspect that is bothering you there.
>
> The ugliest I stumbled over in early 2023 -- until January 2nd :D
>
> >
> > What's bothered me most about it, is the way its name, and the naming of
> > the do_set_pmd() it interfaces with, give no hint that they are entirely
> > about file (or shmem) vmas, and would not work right on anon vmas
> > (I forget whether it's just a matter of which stats updated, or more).
>
> Yes. I dug very deep into in-place collapse yesterday because I was
> briefly concerned about anon THP, and it took me longer to understand
> that whole machinery than it should (and that anon THP never ever
> collapse in-place).
>
> Some of that khugepaged stuff needs some *serious* cleanups and
> refactoring. do_set_pmd() is not an exception.
>
>
> Some more examples:
>
> if (IS_ENABLED(CONFIG_SHMEM) && vma->vm_file) {
>         ...
>         hpage_collapse_scan_file()
> } else {
>         hpage_collapse_scan_pmd()
>         ...
> }
>
>
> 1) hpage_collapse_scan_pmd() is only for anon memory. Totally obvious
>     from the name. But why are we potentially calling it for VMAs that
>     are not applicable? For maximum David confusion?

IIRC the VMAs are checked before, what do you mean about "not
applicable"? But anyway khugepaged/MADV_COLLAPSE does release and
reacquire mmap_lock multiple times, so there are multiple places to
check VMAs validity.

>
> 2) "IS_ENABLED(CONFIG_SHMEM) && vma->vm_file" is also supposed to cover
>     ordinary file-thp. Totally obvious from the IS_ENABLED(CONFIG_SHMEM)
>     ... I probably spent 30minutes understanding what's happening here.
>     Just misleading and wrong without CONFIG_SHMEM.
>
>
> ... and what's easier to get than this magic set of boolean flags:
>
>         hugepage_vma_check(vma, vma->vm_flags, false, false, true)

This is not perfect. I was thinking about changing them to one flag,
just like TTU_ flags used by try_to_unmap(). That may make things
cleaner.

>
> ... and obviously
>         hugepage_vma_revalidate()
> is supposed to be a follow up to a previous
>         hugepage_vma_check()
> and totally different from
>         transhuge_vma_suitable()
>
> Hard to make it even less consistent.

This was after my cleanup, it was much messier before. And I did add
comments to make them more understandable, but anyway better naming is
definitely welcome.

>
> Also, it's very clear from the code that SCAN_PTE_MAPPED_HUGEPAGE only
> applies to file-thp, right? No.
>
> --
> Thanks,
>
> David / dhildenb
>

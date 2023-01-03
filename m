Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B26E65C843
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 21:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238757AbjACUlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 15:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238837AbjACUlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 15:41:32 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C238F14D10
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 12:41:04 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id q10so22204494qvt.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 12:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=N0SQYHeEbnE9z4Qjm2C7vh/kCROxi2guPCmpYkchnHY=;
        b=Ydt5SNFEjKlAC0TY0teiqV18lbgicsulT9jqucck86pLsLHJ7x6EMNy08kfv1ueZYH
         9NVYxW0ADVye0azxdLDjWeyIEsNuXX4c8FflSPLY5K58mmuYnPupJT5f6NeGukAey6c+
         RJ5k7aly5L6VwVCKjEYHDUGCJYwJvfLZYbvxDO9vhfE2vzQU7dJikknj5+pKeuDUA1jP
         VAvT1P8mDwk2GD/xBP6XeJSIwtV++WrhLqoK25YJsMPDjwivIuSTtWtGZgrD8cNq7bkV
         E0rA9X7Z/CnQJuT17SoczLLC0wAQxGJZrh78EBt2Tqr9thwQXz/pwghfg1Ijekx6egcl
         qQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N0SQYHeEbnE9z4Qjm2C7vh/kCROxi2guPCmpYkchnHY=;
        b=BDuK8hhT0dX9YWeVEhNKz53gAgK3cfV9KpCNoCQLbkFij2I825gJJtnIIUQQBmTYXt
         rXFsXn6WRQkh6fZTAYbWk//1+9NhI0sbwIvpnwBaO6JNoqY9cxr8YRhvtXnLIp7+mz6m
         N+uZXrruLfULfFk9GQ3OHCBGdwDiGIPV97jixuiVV92DmmwMJUGQFX649BoOruhbIneS
         LgvGCqQhpt8/0L/QrILJ6pRxv7HHu+hudBz7tnfiEicnKJufHumkOw+UZYTVn3fIkIEv
         /qJ3q944xZNvkKwARn05eZACGhMUuDVEBsTWkW/bwXrSpTjhXl8oKl1BhX/dCx065zST
         zO+Q==
X-Gm-Message-State: AFqh2koWWEpoZnICICuwC8DHY7QhxNfB35D/rQGicCHckv40Xy9U4o3+
        uSAl1B8MCZVMPr6Zf8nntUoGu7+Sdn1sAaGv
X-Google-Smtp-Source: AMrXdXvt2F1RytVLctXfREjFUMsxuc+TDxv7E9uU7y4X6xZs/JRcJyyex0g0Xd5QWKJR4BBDRfZHhg==
X-Received: by 2002:a0c:f783:0:b0:4c7:53b0:2a3c with SMTP id s3-20020a0cf783000000b004c753b02a3cmr63107090qvn.11.1672778463796;
        Tue, 03 Jan 2023 12:41:03 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id v2-20020a05620a440200b006fed2788751sm23239857qkp.76.2023.01.03.12.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 12:41:03 -0800 (PST)
Date:   Tue, 3 Jan 2023 12:40:53 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     David Hildenbrand <david@redhat.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>, Yang Shi <shy828301@gmail.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm/khugepaged: fix collapse_pte_mapped_thp() to allow
 anon_vma
In-Reply-To: <dc9f7bb0-77d4-8b0e-c6b6-ece3f77ed326@redhat.com>
Message-ID: <32be06f-f64-6632-4c36-bed7c0695a3b@google.com>
References: <b740c9fb-edba-92ba-59fb-7a5592e5dfc@google.com> <dc9f7bb0-77d4-8b0e-c6b6-ece3f77ed326@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Mon, 2 Jan 2023, David Hildenbrand wrote:
> On 22.12.22 21:41, Hugh Dickins wrote:
> > uprobe_write_opcode() uses collapse_pte_mapped_thp() to restore huge pmd,
> > when removing a breakpoint from hugepage text: vma->anon_vma is always
> > set in that case, so undo the prohibition.  And MADV_COLLAPSE ought to be
> > able to collapse some page tables in a vma which happens to have anon_vma
> > set from CoWing elsewhere.
> > 
> 
> Just so I get this correctly: the degradation is that we won't re-collapse a
> THP after removing a breakpoint. Certainly "sub-optimal", but I guess nothing
> that particularly matters in practice.

Yes, it is not a correctness issue: see what I wrote "below the dashes":

What this fixes is not a dangerous instability!  But I suggest Cc stable
because uprobes "healing" has regressed in that way, so this should follow
8d3c106e19e8 into those stable releases where it was backported (and may
want adjustment there - I'll supply backports as needed).

Which Andrew moved "above the dashes": I expect he shares, or thinks
others may share, your scepticism about it - and deserve explanation.

> 
> Or am I wrong?
> 
> > Is anon_vma lock required?  Almost not: if any page other than expected
> > subpage of the non-anon huge page is found in the page table, collapse is
> > aborted without making any change.  However, it is possible that an anon
> > page was CoWed from this extent in another mm or vma, in which case a
> > concurrent lookup might look here: so keep it away while clearing pmd
> > (but perhaps we shall go back to using pmd_lock() there in future).
> > 
> > Note that collapse_pte_mapped_thp() is exceptional in freeing a page table
> > without having cleared its ptes: I'm uneasy about that, and had thought
> > pte_clear()ing appropriate; but exclusive i_mmap lock does fix the problem,
> > and we would have to move the mmu_notification if clearing those ptes.
> > 
> > Fixes: 8d3c106e19e8 ("mm/khugepaged: take the right locks for page table
> > retraction")
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > Cc: Jann Horn <jannh@google.com>
> > Cc: Yang Shi <shy828301@gmail.com>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Zach O'Keefe <zokeefe@google.com>
> > Cc: Song Liu <songliubraving@fb.com>
> > Cc: <stable@vger.kernel.org>    [5.4+]
> > ---
> > What this fixes is not a dangerous instability!  But I suggest Cc stable
> > because uprobes "healing" has regressed in that way, so this should follow
> > 8d3c106e19e8 into those stable releases where it was backported (and may
> > want adjustment there - I'll supply backports as needed).
> 
> If it's really something that doesn't matter in practice (e.g., -1%
> performance while debugging :) ), I guess no CC is needed. If there are real
> production workloads that suffer, I guess ccing stable is fine.

It's about recovering performance *after* debugging.  It is not something
that is of any value to me personally, nor (so far as I know) to anyone
whom I work with.  But it is something which Song Liu went to the trouble
to make possible in his "THP aware uprobe" series three years ago, and it
is something which Jann unintentionally regressed in his recent commit:
so I thought it proper to reinstate where regressed.

(What I do have more of an investment in, is for MADV_COLLAPSE to be able
to collapse some extents in a large vma where some other extent got CoWed,
so giving the whole vma an anon_vma.  But that's not an issue for -stable,
and I cannot tell you offhand whether undoing this anon_vma exclusion is
enough to enable that or not - I suspect not, I suspect a result code or
switch statement needs to be adjusted too.)

> 
> > 
> >   mm/khugepaged.c | 14 ++++++--------
> >   1 file changed, 6 insertions(+), 8 deletions(-)
> > 
> > --- 6.2-rc/mm/khugepaged.c
> > +++ linux/mm/khugepaged.c
> > @@ -1460,14 +1460,6 @@ int collapse_pte_mapped_thp(struct mm_struct *mm,
> > unsigned long addr,
> >    if (!hugepage_vma_check(vma, vma->vm_flags, false, false, false))
> >     return SCAN_VMA_CHECK;
> >   -	/*
> > -	 * Symmetry with retract_page_tables(): Exclude MAP_PRIVATE mappings
> > -	 * that got written to. Without this, we'd have to also lock the
> > -	 * anon_vma if one exists.
> > -	 */
> > -	if (vma->anon_vma)
> > -		return SCAN_VMA_CHECK;
> > -
> >    /* Keep pmd pgtable for uffd-wp; see comment in retract_page_tables() */
> >    if (userfaultfd_wp(vma))
> >   		return SCAN_PTE_UFFD_WP;
> > @@ -1567,8 +1559,14 @@ int collapse_pte_mapped_thp(struct mm_struct *mm,
> > unsigned long addr,
> >    }
> >   
> >   	/* step 4: remove pte entries */
> > +	/* we make no change to anon, but protect concurrent anon page lookup
> > */
> > +	if (vma->anon_vma)
> > +		anon_vma_lock_write(vma->anon_vma);
> > +
> >    collapse_and_free_pmd(mm, vma, haddr, pmd);
> >   +	if (vma->anon_vma)
> > +		anon_vma_unlock_write(vma->anon_vma);
> >    i_mmap_unlock_write(vma->vm_file->f_mapping);
> >   
> >   maybe_install_pmd:
> > 
> 
> That code is 99% black magic to me, but staring at the original fix and at
> collapse_and_free_pmd() makes me assume that grabbing that lock most certainly
> won't hurt and should be the right thing to do
> 
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks!

> 
> 
> Side note: set_huge_pmd() wins the award of "ugliest mm function of early
> 2023". I was briefly concerned how do_set_pmd() decides whether the PMD can be
> writable or not. Turns out it's communicated via vm_fault->flags. Just
> horrible.

I firmly disagree - it's from 2022! and much too small to be ugliest;
but I haven't thought about the aspect that is bothering you there.

What's bothered me most about it, is the way its name, and the naming of
the do_set_pmd() it interfaces with, give no hint that they are entirely
about file (or shmem) vmas, and would not work right on anon vmas
(I forget whether it's just a matter of which stats updated, or more).

Hugh

> 
> -- 
> Thanks,
> 
> David / dhildenb

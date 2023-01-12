Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D5E667E40
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 19:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240515AbjALSjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 13:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239975AbjALSjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 13:39:24 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D89EE
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 10:13:05 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so24451511pjj.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 10:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JBDVrMoISlo1HEfdwCQV/IaZzgua+JrO2ZykJTOMdcM=;
        b=eJUyHk+83XxjV3sOkg318zGPf2cHgnhvXDXP6uu1NUcVnLbonMbbTFux3aPhF4JN0M
         DhEPlQnU/GzsoeA6YBSL6h7r7nUZseta/WGmtjlJmLSrfjzAJosYoCGBPmI1KT/iDKOe
         h7k9nLnSu0kG53HcAzJD9RrmsYIT4TrGpFPrQ/CuyWv3SPFMZGPgS4J8J5U97dNeH8z8
         90abuKc8MIJepsSlCPrjJkzVyQLwrTZZ/gnw14V05/98BC8TM5w41PS+ZoCKsGrHKB6L
         /NFx7dVPRzYUqiKDNLA+1LPtc3+7eS9nqDaDHMk9g41T01j+iFR0qL76/3rgIwqaMA48
         DefA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JBDVrMoISlo1HEfdwCQV/IaZzgua+JrO2ZykJTOMdcM=;
        b=AmsOmb4ONjZYt6pB4ewKPj50549KFSQcLOyEfUmFM0EYRqZ8IRaMAP/+vyuuhqBtcX
         98xBVfUgCE2ri5qFMXm7d9tIN3Ga5Dcq3FRFkD6YzNMp8u4Eej/L4YJfDphWH1un2O9e
         P0gwszbpAyCe/5nMPJ2QS5GQB1gOHIJLmXYyMVGkQrfGH6L4o+peksaiCs3v6+knO/15
         p2fksqEdAMgO0got7TxFH9n5mXtY/fKH4P2WU99KK1JiEQVxxxOGecTW3DgDuXfEABBm
         8mYlEK6PxOtcRRbBveYy5y5xebaa9UIivuTlIV2hWQsew6rYmsj3eU+6ULLNAWX9o/iP
         vopA==
X-Gm-Message-State: AFqh2kqHrXlH1a9ZvD+H/vCyT2aCE1SEnMIW7sTU1PA/hQ+3glLAaoJq
        lmaC7O25STuL2+IzDUGCsC1+iRWb8PugYPDO27+aXcuV
X-Google-Smtp-Source: AMrXdXtyygixd47OWmdTEy9qvnkH7mUhjQ25yIu3OL+enGZHEBQF1F2wV/fy7F2ALnWpqKSGRgnFS+XBitLg1Voku8I=
X-Received: by 2002:a17:902:8e85:b0:192:ba7a:2be4 with SMTP id
 bg5-20020a1709028e8500b00192ba7a2be4mr4267212plb.27.1673547184675; Thu, 12
 Jan 2023 10:13:04 -0800 (PST)
MIME-Version: 1.0
References: <20230111133351.807024-1-jannh@google.com> <20230112085649.gvriasb2t5xwmxkm@box.shutemov.name>
In-Reply-To: <20230112085649.gvriasb2t5xwmxkm@box.shutemov.name>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 12 Jan 2023 10:12:53 -0800
Message-ID: <CAHbLzkpAVTys9dBSodHBB3ovKhwP8imUsyXy=aPqY5SyXCT7ww@mail.gmail.com>
Subject: Re: [PATCH] mm/khugepaged: Fix ->anon_vma race
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Zach O'Keefe" <zokeefe@google.com>, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>
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

On Thu, Jan 12, 2023 at 12:56 AM Kirill A. Shutemov
<kirill@shutemov.name> wrote:
>
> On Wed, Jan 11, 2023 at 02:33:51PM +0100, Jann Horn wrote:
> > If an ->anon_vma is attached to the VMA, collapse_and_free_pmd() requires
> > it to be locked. retract_page_tables() bails out if an ->anon_vma is
> > attached, but does this check before holding the mmap lock (as the comment
> > above the check explains).
> >
> > If we racily merge an existing ->anon_vma (shared with a child process)
> > from a neighboring VMA, subsequent rmap traversals on pages belonging to
> > the child will be able to see the page tables that we are concurrently
> > removing while assuming that nothing else can access them.
> >
> > Repeat the ->anon_vma check once we hold the mmap lock to ensure that there
> > really is no concurrent page table access.
> >
> > Reported-by: Zach O'Keefe <zokeefe@google.com>
> > Fixes: f3f0e1d2150b ("khugepaged: add support of collapse for tmpfs/shmem pages")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> > zokeefe@ pointed out to me that the current code (after my last round of patches)
> > can hit a lockdep assert by racing, and after staring at it a bit I've
> > convinced myself that this is a real, preexisting bug.
> > (I haven't written a reproducer for it though. One way to hit it might be
> > something along the lines of:
> >
> >  - set up a process A with a private-file-mapping VMA V1
> >  - let A fork() to create process B, thereby copying V1 in A to V1' in B
> >  - let B extend the end of V1'
> >  - let B put some anon pages into the extended part of V1'
>
> At this point V1' gets it's own ->anon_vma, not connected to V1, right?

This is what I got confused too.

>
> >  - let A map a new private-file-mapping VMA V2 directly behind V1, without
> >    an anon_vma
> > [race begins here]
> >   - in A's thread 1: begin retract_page_tables() on V2, run through first
> >     ->anon_vma check
> >   - in A's thread 2: run __anon_vma_prepare() on V2 and ensure that it
> >     merges the anon_vma of V1 (which implies V1 and V2 must be mapping the
> >     same file at compatible offsets)
> >   - in B: trigger rmap traversal on anon page in V1'
>
> I don't follow the race. rmap on V1' will not reach V1.
>
> >  mm/khugepaged.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 5cb401aa2b9d..0bfed37f3a3b 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -1644,7 +1644,7 @@ static int retract_page_tables(struct address_space *mapping, pgoff_t pgoff,
> >                * has higher cost too. It would also probably require locking
> >                * the anon_vma.
> >                */
> > -             if (vma->anon_vma) {
> > +             if (READ_ONCE(vma->anon_vma)) {
> >                       result = SCAN_PAGE_ANON;
> >                       goto next;
> >               }
>
> This makes perfect sense. At least for readability. But I think
> false-negative should not lead to bad results.
>
> > @@ -1672,6 +1672,18 @@ static int retract_page_tables(struct address_space *mapping, pgoff_t pgoff,
> >               result = SCAN_PTE_MAPPED_HUGEPAGE;
> >               if ((cc->is_khugepaged || is_target) &&
> >                   mmap_write_trylock(mm)) {
> > +                     /*
> > +                      * Re-check whether we have an ->anon_vma, because
> > +                      * collapse_and_free_pmd() requires that either no
> > +                      * ->anon_vma exists or the anon_vma is locked.
> > +                      * We already checked ->anon_vma above, but that check
> > +                      * is racy because ->anon_vma can be populated under the
> > +                      * mmap lock in read mode.
> > +                      */
> > +                     if (vma->anon_vma) {
> > +                             result = SCAN_PAGE_ANON;
> > +                             goto unlock_next;
> > +                     }
>
> This is totally wrong direction. Or I don't understand the race.
>
> At this point we already paid nearly all price of of pagetable retraction.
> I don't see any correctness reason to stop here, except for the assert.

Isn't it possible that collapse_and_free_pmd() clear the pmd which may
point to a PTE which maps the COW'ed anon page if this race happens?

>
> I think lockdep assert in collapse_and_free_pmd() is wrong and has to be
> dropped.
>
> >                       /*
> >                        * When a vma is registered with uffd-wp, we can't
> >                        * recycle the pmd pgtable because there can be pte
> >
> > base-commit: 7dd4b804e08041ff56c88bdd8da742d14b17ed25
> > --
> > 2.39.0.314.g84b9a713c41-goog
> >
>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov

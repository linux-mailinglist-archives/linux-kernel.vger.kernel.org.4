Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307DD623AF7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 05:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbiKJEWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 23:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiKJEWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 23:22:01 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3F8387
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 20:22:00 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id s20so506819qkg.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 20:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dw4PvJQ0nnQZ0sPvnanty+O2S4vrCySs6pr2aFsEiws=;
        b=Z0WA3kdaG66SvW8vg0E0kbVzqkavm5Z7a1u5aRKq1X6PP7B6FKUHvV+Uyoo5hNMdcg
         0dejfLhNL9Zw04MbNm+d63QWE/Itv7biJpfIOYTjSRPvANZ2P38N9Xo+dpW6yvR56pQ2
         qbdkrkNW2rGdCo/Jf7+s6Xigx5gQR4JGV+cLvIQohJQMBiwstZYNP54AN2JGlBwSDuMV
         c5qIwRt+ktD454bGGmsl+H1MfLXgvjRJ1UIBLZnkJ3GwkDJISyuVCyFwSWaO74Ph9PaB
         fe7bk66blDdMqGndeRsdHg43/xmBPObvoF30a01EjAyET0rWYVsYZEFaA9BDqMI+xylE
         3yyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dw4PvJQ0nnQZ0sPvnanty+O2S4vrCySs6pr2aFsEiws=;
        b=x/0umXz1JAlbsm7BSkY/kuwkM08mjWo+6OxS/EetlpdFONqQyT2cdl3CR77pTzndW6
         nvi1xhgEOAvR6r6d6z7+cqrDID4RQ7XXgcBGNe3WOMfxpdE59Cfb7KKm+YE/CuWNAVTH
         /R7Z7Yf9g8UXwBntWpZbIL8oVAGwFNufcxsfSY7KIq3OAnFevpX9IaZsy0Rue/RXldFn
         wvLUHctI5Ih4uPXWbS3ZBAim1JAqdQG9BSxrVF6k6bYbCHp/QgBVMatPfqRIPlW5QiDd
         rp6Aarsz5CxSYZRC6rBRso2YVQCHsEv89o2q83QtGT3/sr2wxe8ShfzY6PHiv0bjM9mp
         GS3A==
X-Gm-Message-State: ACrzQf1lxui2x742seaWtAesw9Lrg76F0wANA/DqucPW3JS7qcaLISlO
        tOTz4HyYIGf4qvZDHlpWQ1paWA==
X-Google-Smtp-Source: AMsMyM53the+sbsBlXfSSM3iKKoY7x3ANWSoF6cB5EwqMVi04mTjjsbyFSxuq1NSfAixi4ZlhCi3eQ==
X-Received: by 2002:a05:620a:12ca:b0:6fa:24c3:bb17 with SMTP id e10-20020a05620a12ca00b006fa24c3bb17mr41701717qkl.393.1668054119474;
        Wed, 09 Nov 2022 20:21:59 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id cq10-20020a05622a424a00b00397e97baa96sm10886502qtb.0.2022.11.09.20.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 20:21:59 -0800 (PST)
Date:   Wed, 9 Nov 2022 20:21:47 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, Peter Xu <peterx@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Mina Almasry <almasrymina@google.com>,
        James Houghton <jthoughton@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 4/3] mm,thp,rmap: handle the normal !PageCompound case
 first
In-Reply-To: <CAHk-=wiJfLx9dVJcQOhQsAseoPmLhpVvHgf4GYu6frfhmBAuMg@mail.gmail.com>
Message-ID: <22eebc5b-6fcb-5561-634-f984f82f533@google.com>
References: <5f52de70-975-e94f-f141-543765736181@google.com> <fca2f694-2098-b0ef-d4e-f1d8b94d318c@google.com> <CAHk-=wiJfLx9dVJcQOhQsAseoPmLhpVvHgf4GYu6frfhmBAuMg@mail.gmail.com>
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

On Wed, 9 Nov 2022, Linus Torvalds wrote:
> On Wed, Nov 9, 2022 at 6:18 PM Hugh Dickins <hughd@google.com> wrote:
> >
> > Commit ("mm,thp,rmap: lock_compound_mapcounts() on THP mapcounts")
> > propagated the "if (compound) {lock} else if (PageCompound) {lock} else
> > {atomic}" pattern throughout; but Linus hated the way that gives primacy
> > to the uncommon case: switch to "if (!PageCompound) {atomic} else if
> > (compound) {lock} else {lock}" throughout.
> 
> Side note, that 'compound' naming is also on my list of "I'm _really_
> not a fan".
> 
> We actually have a completely different meaning for PageCompound()
> than the meaning of 'compound' in the rmap functions, and those
> functions literally mix those meanings if  not on the same line, then
> at least right next to each other.
> 
> What 'rmap' actually means with 'compound' in the add/remove functions
> is basically 'not PAGE_SIZE' as far as I can tell.
> 
> So if I get the energy to do the rmap counts,

See other mail, I got some zest to try your idea on the counts.

> I will *also* be renaming that horrible thing completely.

But I don't suppose I'll spend time on that part, I don't really
see the problem.  "compound" might be better named, say, "large_rmap"
(I'd have said "pmd_mapped" or "pmd_rmap", but you raise the spectre
of hugetlb below, and powerpc as usual does hugetlb very differently),
but compound seems okay to me, and consistent with usage elsewhere.

> 
> In fact, I'd be inclined to just pass in the actual page size
> (possibly a page shift order), which some of the functions want
> anyway, and which would be a lot clearer than the horrid "compound"
> name.

But yes, I think that would be an improvement; yet you might find a
reason why so often we don't do that - there's often an awkward
BUILD_BUG when you build without CONFIG_TRANSPARENT_HUGEPAGE=y.
And much as I've often wanted to remove it, it does give some
assurance that we're not bloating THP-disabled configs.  Maybe the
steady growth of compound_nr() usage gets around that better now
(or will you be renaming that too ?-)

> 
> One reason I find the "compound" name so horrifying is that it is used
> very much for HUGETLB pages, which I don't think end up ever being
> marked as PageCompund(), and which are - for various historical

hugetlb pages are always PageCompound.  Shoot me if they're not.

> reasons - doubly confusing because they use a "pte_t" to describe
> themselves, even when they are actually using a "pmd_t" or a "pud_t"
> to actually map the page.

Yes, I wish we would undo that hugetlb deception: it would probably
be much more (un)doable, were it not for powerpc (and ia64 iirc).

> 
> So a HUGETLB entry really is (for historical reasons) designed to look
> like a single last-level pte_t entry, but from an rmap perspective it
> is explicitly *not* made to look like that at all, completely
> violating the HUGETLB design.
> 
> So the rmap code has several really REALLY confusing cases:
> 
>  - the common one: just a page mapped at a *real* pte_t level.
> 
>    To make that more confusing, it can actually be a single-page
> _part_ of a compound page in the PageCompound() sense, but the rmap
> 'compound' argument will *not* be set, because from a *mmap*
> standpoint it's mapped as a single page.

Yes.  Most pages are unambiguous, but when a PageHead page arrives
at page_add/remove_rmap(), we have to do different things, according
to whether it's mapped with a large or a small entry.

But I'm going away at this point, you write much faster than I can
read and understand and respond.  I'm responding in part to "fix"
my stupid typo on Johannes's address.

Hugh

> 
>    This is generally recognized by the rmap code by 'compound' being zero.
> 
>  - a HUGETLB mapping, which uses '->pte' in the page walking (please
> kill me now) and is *not* using a PageCompund() page, but 'compound'
> is still set, because from a *mapping* standpoint it's not a final
> pte_t entry (buit from a MM design standpoint it _was_ supposed to be
> designed like a single page).
> 
>    This is randomly recognized by looking at the vma flags (using
> "is_vm_hugetlb_page(vma)") or just inherent in the code itself (ie the
> 'hugetlb()' functions are only called by code that has tested this
> situation one way or another)
> 
>    To make things more confusing, some places use PageHeadHuge()
> instead (but the folio version of said test is called
> "folio_test_hugetlb()", just so that nobody could possibly ever accuse
> the HUGETLB code to have consistency).
> 
>     You'd think that PageHeadHuge() is one of the functions that
> checks the page flag bits. You'd be wrong. It's very very special.
> 
>  - an *actual* PageCompound() page, mapped as such as a THP page (ie
> mapped by a pmd, not a pte).
> 
>    This may be the same page size as a HUGETLB mapping (and often is),
> but it's a completely different case in every single way.
> 
>    But like the HUGETLB case, the 'compound' argument will be set, and
> now it's actually a compound page (but hey, so could the single page
> mapping case be too).
> 
>    Unlike the HUGETLB case, the page walker does not use ->pte for
> this, and some of the walkers will very much use that, ie
> folio_referenced_one() will do
> 
>                 if (pvmw.pte) {
> 
>    to distinguish the "natively mapped PageCompound()" case (no pte)
> from the "map a single page" or from the HUGETLB case (yes pte).
> 
> There may be more cases than those three, and I may have confused
> myself and gotten some of the details wrong, but I did want to write
> the above diatribe out to
> 
>  (a) see if somebody corrects me for any of the cases I enumerated
> 
>  (b) see if somebody can point to yet another odd case
> 
>  (c) see if somebody has suggestions for better and more obvious names
> for that 'compound' argument in the rmap code
> 
> I do wish the HUGETLB case didn't use 'pte' for its notion of how
> HUGETLB entries are mapped, but that's literally how HUGETLB is
> designed: it started life as a larger last-level pte.
> 
> It just means that it ends up being very confusing when from a page
> table walk perspective, you're walking a pud or a pmd entry, and then
> you see a 'pte_t' instead.
> 
> An example of that confusion is visible in try_to_unmap_one(), which
> can be called with a HUGEPTE page (well, folio), and that does
> 
>         while (page_vma_mapped_walk(&pvmw)) {
> 
> to find the rmap entries, but it can't do that
> 
>                 if (pvmw.pte) {
> 
> test to see what mapping it's walking (since both regular pages and
> HUGETLB pages use that), so then it just keeps testing what kind of
> page that was passed in.
> 
> Which really smells very odd to me, but apparently it works,
> presumably because unlike THP there can be no splitting.  But it's a
> case where the whole "was it a regular page or a HUGETLB page" is
> really really confusing/
> 
> And mm/hugetlb.c (and places like mm/pagewalk.c too) has a fair number
> of random casts as a result of this "it's not really a pte_t, but it's
> designed to look like one" thing.
> 
> This all really is understandable from a historical context, and from
> HUGETLB really being just kind of designed to be a bigger page (not a
> collection of small pages that can be mapped as a bigger entity), but
> it really does mean that 'rmap' calling those HUGETLB pages 'compound'
> is conceptually very very wrong.
> 
> Oh well. That whole HUGETLB model isn't getting fixed, but I think the
> naming confusion about 'compound' *can* be fixed fairly easily, and we
> could try to at least avoid having 'compound' and 'PageCompound()'
> mean totally different things in the same function.
> 
> I'm not going to do any of this cleanup now, but I wanted to at least
> voice my concerns. Maybe I'll get around to actually trying to clarify
> the code later.
> 
> Because this was all stuff that was *very* confusing when I did the
> rmap simplification in that (now completely rewritten to explicitly
> _not_ touch rmap at all) original version of the delayed rmap patch
> series.
> 
>                  Linus

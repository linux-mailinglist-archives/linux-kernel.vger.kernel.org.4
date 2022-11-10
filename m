Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9D6623A70
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 04:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbiKJDaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 22:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbiKJDaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 22:30:20 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24BC28737
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 19:30:18 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id j1-20020a4ad181000000b0049e6e8c13b4so104141oor.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 19:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bWZz52dVumfaYad7E+XSHRTGcmuqcru/wb7z9nclkNk=;
        b=C23yth4pnIogWnEBBs6iEXgO2JA/Ddn634YKahJiGxXjlGqwcWB+Z4vNMktgXO8jAc
         LXwdabCRxq1rxrGtBTXEhFD7rZSa5Al4wQBpypOnIpbE/7IbdAmIyqKzm1rbCjlyY7tn
         e6SNrBMjutv8GvhSGPa3ubb9Bo3gdcs1CygWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bWZz52dVumfaYad7E+XSHRTGcmuqcru/wb7z9nclkNk=;
        b=SDDdA3M0q93487pfdLbrrd+3cTXzOSJ7YcTuiY6ijBOEF7YZEsTvPZ+upayNPRM8B8
         eISGKA3PLa0/OMR0s5couKEa4Kxo9pHk6w1dZO98Q4/6HjIaXutTpLS6d2mXQPNqON4I
         gSS17ABSaYjkI044E/8+W4kZm28zrM08SokMG4RhS7irCYLJwxdyxTIIR0VpisMxJPTF
         6bCcZ7EdB/ka/7zjQSWDqlBNB92wZ49dSG3wZivmwOuzrdQClxe0pQfy7YsCrTPQNeU3
         CobryBdCQ01h2FRcsgp5CbQsJSrbGZwRIEGNv/JRrBuAzWFwFIEJ6fK6yCA2SEyCq5BW
         sohQ==
X-Gm-Message-State: ACrzQf3lgogKc7o+S0wmp5p+QG3E0FnAhOqE0ww8Px2yMlPxQHb6DG3V
        yQz8h3YXDFeiPkNWYUFfpYTv2K3jgo8/LA==
X-Google-Smtp-Source: AMsMyM4gZ2LuOpalJfUtwkDUhTh5kMDpNAS1RfVg7lHowDypTNyNXcCAYLCgICcYZFr8IvbipJZFbQ==
X-Received: by 2002:a05:6820:61f:b0:49e:1acc:6f0 with SMTP id e31-20020a056820061f00b0049e1acc06f0mr15563748oow.95.1668051017730;
        Wed, 09 Nov 2022 19:30:17 -0800 (PST)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com. [209.85.210.46])
        by smtp.gmail.com with ESMTPSA id u8-20020a9d4d88000000b0066871c3adb3sm6008987otk.28.2022.11.09.19.30.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 19:30:17 -0800 (PST)
Received: by mail-ot1-f46.google.com with SMTP id cb2-20020a056830618200b00661b6e5dcd8so479848otb.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 19:30:17 -0800 (PST)
X-Received: by 2002:a81:8241:0:b0:370:5fad:47f0 with SMTP id
 s62-20020a818241000000b003705fad47f0mr52859595ywf.441.1668050604805; Wed, 09
 Nov 2022 19:23:24 -0800 (PST)
MIME-Version: 1.0
References: <5f52de70-975-e94f-f141-543765736181@google.com> <fca2f694-2098-b0ef-d4e-f1d8b94d318c@google.com>
In-Reply-To: <fca2f694-2098-b0ef-d4e-f1d8b94d318c@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Nov 2022 19:23:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiJfLx9dVJcQOhQsAseoPmLhpVvHgf4GYu6frfhmBAuMg@mail.gmail.com>
Message-ID: <CAHk-=wiJfLx9dVJcQOhQsAseoPmLhpVvHgf4GYu6frfhmBAuMg@mail.gmail.com>
Subject: Re: [PATCH 4/3] mm,thp,rmap: handle the normal !PageCompound case first
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxcg.org>,
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
        "Zach O'Keefe" <zokeefe@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 9, 2022 at 6:18 PM Hugh Dickins <hughd@google.com> wrote:
>
> Commit ("mm,thp,rmap: lock_compound_mapcounts() on THP mapcounts")
> propagated the "if (compound) {lock} else if (PageCompound) {lock} else
> {atomic}" pattern throughout; but Linus hated the way that gives primacy
> to the uncommon case: switch to "if (!PageCompound) {atomic} else if
> (compound) {lock} else {lock}" throughout.

Side note, that 'compound' naming is also on my list of "I'm _really_
not a fan".

We actually have a completely different meaning for PageCompound()
than the meaning of 'compound' in the rmap functions, and those
functions literally mix those meanings if  not on the same line, then
at least right next to each other.

What 'rmap' actually means with 'compound' in the add/remove functions
is basically 'not PAGE_SIZE' as far as I can tell.

So if I get the energy to do the rmap counts, I will *also* be
renaming that horrible thing completely.

In fact, I'd be inclined to just pass in the actual page size
(possibly a page shift order), which some of the functions want
anyway, and which would be a lot clearer than the horrid "compound"
name.

One reason I find the "compound" name so horrifying is that it is used
very much for HUGETLB pages, which I don't think end up ever being
marked as PageCompund(), and which are - for various historical
reasons - doubly confusing because they use a "pte_t" to describe
themselves, even when they are actually using a "pmd_t" or a "pud_t"
to actually map the page.

So a HUGETLB entry really is (for historical reasons) designed to look
like a single last-level pte_t entry, but from an rmap perspective it
is explicitly *not* made to look like that at all, completely
violating the HUGETLB design.

So the rmap code has several really REALLY confusing cases:

 - the common one: just a page mapped at a *real* pte_t level.

   To make that more confusing, it can actually be a single-page
_part_ of a compound page in the PageCompound() sense, but the rmap
'compound' argument will *not* be set, because from a *mmap*
standpoint it's mapped as a single page.

   This is generally recognized by the rmap code by 'compound' being zero.

 - a HUGETLB mapping, which uses '->pte' in the page walking (please
kill me now) and is *not* using a PageCompund() page, but 'compound'
is still set, because from a *mapping* standpoint it's not a final
pte_t entry (buit from a MM design standpoint it _was_ supposed to be
designed like a single page).

   This is randomly recognized by looking at the vma flags (using
"is_vm_hugetlb_page(vma)") or just inherent in the code itself (ie the
'hugetlb()' functions are only called by code that has tested this
situation one way or another)

   To make things more confusing, some places use PageHeadHuge()
instead (but the folio version of said test is called
"folio_test_hugetlb()", just so that nobody could possibly ever accuse
the HUGETLB code to have consistency).

    You'd think that PageHeadHuge() is one of the functions that
checks the page flag bits. You'd be wrong. It's very very special.

 - an *actual* PageCompound() page, mapped as such as a THP page (ie
mapped by a pmd, not a pte).

   This may be the same page size as a HUGETLB mapping (and often is),
but it's a completely different case in every single way.

   But like the HUGETLB case, the 'compound' argument will be set, and
now it's actually a compound page (but hey, so could the single page
mapping case be too).

   Unlike the HUGETLB case, the page walker does not use ->pte for
this, and some of the walkers will very much use that, ie
folio_referenced_one() will do

                if (pvmw.pte) {

   to distinguish the "natively mapped PageCompound()" case (no pte)
from the "map a single page" or from the HUGETLB case (yes pte).

There may be more cases than those three, and I may have confused
myself and gotten some of the details wrong, but I did want to write
the above diatribe out to

 (a) see if somebody corrects me for any of the cases I enumerated

 (b) see if somebody can point to yet another odd case

 (c) see if somebody has suggestions for better and more obvious names
for that 'compound' argument in the rmap code

I do wish the HUGETLB case didn't use 'pte' for its notion of how
HUGETLB entries are mapped, but that's literally how HUGETLB is
designed: it started life as a larger last-level pte.

It just means that it ends up being very confusing when from a page
table walk perspective, you're walking a pud or a pmd entry, and then
you see a 'pte_t' instead.

An example of that confusion is visible in try_to_unmap_one(), which
can be called with a HUGEPTE page (well, folio), and that does

        while (page_vma_mapped_walk(&pvmw)) {

to find the rmap entries, but it can't do that

                if (pvmw.pte) {

test to see what mapping it's walking (since both regular pages and
HUGETLB pages use that), so then it just keeps testing what kind of
page that was passed in.

Which really smells very odd to me, but apparently it works,
presumably because unlike THP there can be no splitting.  But it's a
case where the whole "was it a regular page or a HUGETLB page" is
really really confusing/

And mm/hugetlb.c (and places like mm/pagewalk.c too) has a fair number
of random casts as a result of this "it's not really a pte_t, but it's
designed to look like one" thing.

This all really is understandable from a historical context, and from
HUGETLB really being just kind of designed to be a bigger page (not a
collection of small pages that can be mapped as a bigger entity), but
it really does mean that 'rmap' calling those HUGETLB pages 'compound'
is conceptually very very wrong.

Oh well. That whole HUGETLB model isn't getting fixed, but I think the
naming confusion about 'compound' *can* be fixed fairly easily, and we
could try to at least avoid having 'compound' and 'PageCompound()'
mean totally different things in the same function.

I'm not going to do any of this cleanup now, but I wanted to at least
voice my concerns. Maybe I'll get around to actually trying to clarify
the code later.

Because this was all stuff that was *very* confusing when I did the
rmap simplification in that (now completely rewritten to explicitly
_not_ touch rmap at all) original version of the delayed rmap patch
series.

                 Linus

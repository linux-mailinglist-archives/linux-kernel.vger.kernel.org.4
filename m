Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE55A624713
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbiKJQcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbiKJQcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:32:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83163FBA3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 08:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NPEF063H+Y7JeJNfnAB1kp+fd1pLsT9ML+6VjdUPh7o=; b=mx+EY9COzoDzeuy2+0heRU2yNe
        yzX/vmiC19SUiPXxXDe3Mld28kvj/feSddm0YDw9iYaoR6cFptf4oO6yG82v/riN6Wpid4/0SRwQl
        zoOCHLqUuayVhzSFL6UbBwFSp6aZgG6Tb1dHoy0X72Ced80huuiy8/kMhkeaeH5LT47Jc4CoDZB1T
        mA+DweHo/jN0Rlhgnyde/Z0ueQJn3iMdcvqFEG2W66SIEdiQxy2oinLi/WkRa3UmvD8cFjFfFsRPH
        tp+x9oFo59yFei677vlB7qS8S/c2iCw3nDiN9eDPQftxhpdbchYaCJjS8hwCKiFm3t6iqIpCkjLS1
        W2XpdHBQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1otASt-00CD9f-Ff; Thu, 10 Nov 2022 16:31:43 +0000
Date:   Thu, 10 Nov 2022 16:31:43 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxcg.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
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
Message-ID: <Y20nbz4ypWhwF38L@casper.infradead.org>
References: <5f52de70-975-e94f-f141-543765736181@google.com>
 <fca2f694-2098-b0ef-d4e-f1d8b94d318c@google.com>
 <CAHk-=wiJfLx9dVJcQOhQsAseoPmLhpVvHgf4GYu6frfhmBAuMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiJfLx9dVJcQOhQsAseoPmLhpVvHgf4GYu6frfhmBAuMg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 07:23:08PM -0800, Linus Torvalds wrote:
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

Ah.  I've been trying to understand what that 'compound' really means,
and what the difference is to 'PageCompound()' and why we need both.
Thanks!

> One reason I find the "compound" name so horrifying is that it is used
> very much for HUGETLB pages, which I don't think end up ever being
> marked as PageCompund(), and which are - for various historical
> reasons - doubly confusing because they use a "pte_t" to describe
> themselves, even when they are actually using a "pmd_t" or a "pud_t"
> to actually map the page.

HugeTLB pages _are_ marked as Compound.  There's some fairly horrific
code to manually make them compound when they have to be allocated
piecemeal (because they're 1GB and too large for the page allocator).

>    To make things more confusing, some places use PageHeadHuge()
> instead (but the folio version of said test is called
> "folio_test_hugetlb()", just so that nobody could possibly ever accuse
> the HUGETLB code to have consistency).

That one's my fault, but it's a reaction to all the times that I and
others have got confused between PageHuge and PageTransHuge.  I suppose
we could do a big sed s/PageHuge/PageHugeTLB/, but I'm hopeful the
entire hugetlb codebase is either converted to folios or unified with
THP handling.

> I do wish the HUGETLB case didn't use 'pte' for its notion of how
> HUGETLB entries are mapped, but that's literally how HUGETLB is
> designed: it started life as a larger last-level pte.
> 
> It just means that it ends up being very confusing when from a page
> table walk perspective, you're walking a pud or a pmd entry, and then
> you see a 'pte_t' instead.

Yes, one of the long-term things I want to try is making the hugetlb
code use the pmd/pud types like the THP code does.

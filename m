Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C0B637119
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 04:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiKXDdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 22:33:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiKXDde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 22:33:34 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71309C607F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 19:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SiYzGWsRarEdt81Og2LTbZsHP1GWYUw0h1JMLzGK6gc=; b=rWgR4hAalUnGhNvEqX826xzxNB
        K4oSWO0gcBRj+m4eI4DUB8xXzQmbQbVC1L4TCRMe9n+8t8EqVLyXLrMdFcnRb7yUmv4c4gPYKFlhY
        VoO1DFAyA5IhXAc7Yln76y40O3ok5lfnVACt4nq6k+BJ08meFBD9tZyo9vptBQFqYmDAt6suEdqmj
        ri8conSsbCyAf9i0HtJhTB5Fx/iC59MDaKsyxbij1y6G5BNhwFv74bjhcFyPffZvAAi5gMbN52XRy
        ELp3UPyvx4jLBihtwHYg/ci9KOIIoAchx7k1knEUucZS+RTd/Jj3o20u09jIW/+gudAskJVN9jBpz
        D4h0odvg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oy2zT-008LGP-Sl; Thu, 24 Nov 2022 03:33:31 +0000
Date:   Thu, 24 Nov 2022 03:33:31 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>, Gavin Shan <gshan@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, william.kucharski@oracle.com,
        ziy@nvidia.com, kirill.shutemov@linux.intel.com,
        zhenyzha@redhat.com, shan.gavin@gmail.com, riel@surriel.com
Subject: Re: [PATCH] mm: migrate: Fix THP's mapcount on isolation
Message-ID: <Y37mC1+LQscJaOk4@casper.infradead.org>
References: <20221123005752.161003-1-gshan@redhat.com>
 <e8a64b11-98f9-b571-dce9-a60df98e3e5@google.com>
 <c61612f7-b861-39cf-3e73-dbe4d134eec0@redhat.com>
 <871qptrvsw.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871qptrvsw.fsf@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 12:06:56PM +1100, Alistair Popple wrote:
> 
> David Hildenbrand <david@redhat.com> writes:
> 
> > On 23.11.22 06:14, Hugh Dickins wrote:
> >> On Wed, 23 Nov 2022, Gavin Shan wrote:
> >> 
> >>> The issue is reported when removing memory through virtio_mem device.
> >>> The transparent huge page, experienced copy-on-write fault, is wrongly
> >>> regarded as pinned. The transparent huge page is escaped from being
> >>> isolated in isolate_migratepages_block(). The transparent huge page
> >>> can't be migrated and the corresponding memory block can't be put
> >>> into offline state.
> >>>
> >>> Fix it by replacing page_mapcount() with total_mapcount(). With this,
> >>> the transparent huge page can be isolated and migrated, and the memory
> >>> block can be put into offline state.
> >>>
> >>> Fixes: 3917c80280c9 ("thp: change CoW semantics for anon-THP")
> >>> Cc: stable@vger.kernel.org   # v5.8+
> >>> Reported-by: Zhenyu Zhang <zhenyzha@redhat.com>
> >>> Suggested-by: David Hildenbrand <david@redhat.com>
> >>> Signed-off-by: Gavin Shan <gshan@redhat.com>
> >> Interesting, good catch, looked right to me: except for the Fixes
> >> line
> >> and mention of v5.8.  That CoW change may have added a case which easily
> >> demonstrates the problem, but it would have been the wrong test on a THP
> >> for long before then - but only in v5.7 were compound pages allowed
> >> through at all to reach that test, so I think it should be
> >> Fixes: 1da2f328fa64 ("mm,thp,compaction,cma: allow THP migration for
> >> CMA allocations")
> >> Cc: stable@vger.kernel.org   # v5.7+
> >> Oh, no, stop: this is not so easy, even in the latest tree.
> >> Because at the time of that "admittedly racy check", we have no hold
> >> at all on the page in question: and if it's PageLRU or PageCompound
> >> at one instant, it may be different the next instant.  Which leaves it
> >> vulnerable to whatever BUG_ON()s there may be in the total_mapcount()
> >> path - needs research.  *Perhaps* there are no more BUG_ON()s in the
> >> total_mapcount() path than in the existing page_mapcount() path.
> >> I suspect that for this to be safe (before your patch and more so
> >> after),
> >> it will be necessary to shift the "admittedly racy check" down after the
> >> get_page_unless_zero() (and check the sequence of operations when a
> >> compound page is initialized).
> >
> > Grabbing a reference first sounds like the right approach to me.
> 
> I think you're right. Without a page reference I don't think it is even
> safe to look at struct page, at least not without synchronisation
> against memory hot unplug which could remove the struct page. From a
> quick glance I didn't see anything here that obviously did that though.

Memory hotplug is the offending party here.  It has to make sure that
everything else is definitely quiescent before removing the struct pages.
Otherwise you can't even try_get a refcount.

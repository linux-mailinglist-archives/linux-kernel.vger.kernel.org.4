Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F98F600B20
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiJQJlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiJQJlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:41:37 -0400
Received: from outbound-smtp07.blacknight.com (outbound-smtp07.blacknight.com [46.22.139.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061EB6425
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 02:41:35 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp07.blacknight.com (Postfix) with ESMTPS id 61C421C41A7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 10:41:34 +0100 (IST)
Received: (qmail 4063 invoked from network); 17 Oct 2022 09:41:34 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 17 Oct 2022 09:41:34 -0000
Date:   Mon, 17 Oct 2022 10:41:32 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Yang Shi <shy828301@gmail.com>
Cc:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mm: mempool: introduce page bulk allocator
Message-ID: <20221017094132.vnanndrwa2yn7qcw@techsingularity.net>
References: <20221005180341.1738796-1-shy828301@gmail.com>
 <20221005180341.1738796-3-shy828301@gmail.com>
 <20221013123830.opbulq4qad56kuev@techsingularity.net>
 <CAHbLzkpc+CAfsYe6gXjh=-3MxMH_aWhPMYhic7ddFZgWttOhng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAHbLzkpc+CAfsYe6gXjh=-3MxMH_aWhPMYhic7ddFZgWttOhng@mail.gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 01:16:31PM -0700, Yang Shi wrote:
> On Thu, Oct 13, 2022 at 5:38 AM Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > On Wed, Oct 05, 2022 at 11:03:39AM -0700, Yang Shi wrote:
> > > Since v5.13 the page bulk allocator was introduced to allocate order-0
> > > pages in bulk.  There are a few mempool allocator callers which does
> > > order-0 page allocation in a loop, for example, dm-crypt, f2fs compress,
> > > etc.  A mempool page bulk allocator seems useful.  So introduce the
> > > mempool page bulk allocator.
> > >
> > > It introduces the below APIs:
> > >   - mempool_init_pages_bulk()
> > >   - mempool_create_pages_bulk()
> > > They initialize the mempool for page bulk allocator.  The pool is filled
> > > by alloc_page() in a loop.
> > >
> > >   - mempool_alloc_pages_bulk_list()
> > >   - mempool_alloc_pages_bulk_array()
> > > They do bulk allocation from mempool.
> > > They do the below conceptually:
> > >   1. Call bulk page allocator
> > >   2. If the allocation is fulfilled then return otherwise try to
> > >      allocate the remaining pages from the mempool
> > >   3. If it is fulfilled then return otherwise retry from #1 with sleepable
> > >      gfp
> > >   4. If it is still failed, sleep for a while to wait for the mempool is
> > >      refilled, then retry from #1
> > > The populated pages will stay on the list or array until the callers
> > > consume them or free them.
> > > Since mempool allocator is guaranteed to success in the sleepable context,
> > > so the two APIs return true for success or false for fail.  It is the
> > > caller's responsibility to handle failure case (partial allocation), just
> > > like the page bulk allocator.
> > >
> > > The mempool typically is an object agnostic allocator, but bulk allocation
> > > is only supported by pages, so the mempool bulk allocator is for page
> > > allocation only as well.
> > >
> > > Signed-off-by: Yang Shi <shy828301@gmail.com>
> >
> > Overall, I think it's an ok approach and certainly a good use case for
> > the bulk allocator.
> >
> > The main concern that I have is that the dm-crypt use case doesn't really
> > want to use lists as such and it's just a means for collecting pages to pass
> > to bio_add_page(). bio_add_page() is working with arrays but you cannot
> > use that array directly as any change to how that array is populated will
> > then explode. Unfortunately, what you have is adding pages to a list to
> > take them off the list and put them in an array and that is inefficient.
> 
> Yeah, I didn't think of a better way to pass the pages to dm-crypt.
> 
> >
> > How about this
> >
> > 1. Add a callback to __alloc_pages_bulk() that takes a page as a
> >    parameter like bulk_add_page() or whatever.
> >
> > 2. For page_list == NULL && page_array == NULL, the callback is used
> >
> > 3. Add alloc_pages_bulk_cb() that passes in the name of a callback
> >    function
> >
> > 4. In the dm-crypt case, use the callback to pass the page to bio_add_page
> >    for the new page allocated.
> 
> Thank you so much for the suggestion. But I have a hard time
> understanding how these work together. Do you mean call bio_add_page()
> in the callback? But bio_add_page() needs other parameters. Or I
> misunderstood you?
> 

I expected dm-crypt to define the callback. Using bio_add_page
directly would not work as the bulk allocator has no idea what to pass
bio_add_page. dm-crypt would likely need to create both a callback and an
opaque data structure passed as (void *) to track "clone" and "len"

-- 
Mel Gorman
SUSE Labs

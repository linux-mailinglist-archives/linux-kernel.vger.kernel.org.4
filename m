Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CD15FD946
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 14:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiJMMih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 08:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiJMMig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 08:38:36 -0400
Received: from outbound-smtp60.blacknight.com (outbound-smtp60.blacknight.com [46.22.136.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F34C11D997
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 05:38:33 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp60.blacknight.com (Postfix) with ESMTPS id 1112BFAE1A
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 13:38:32 +0100 (IST)
Received: (qmail 16548 invoked from network); 13 Oct 2022 12:38:31 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 13 Oct 2022 12:38:31 -0000
Date:   Thu, 13 Oct 2022 13:38:30 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Yang Shi <shy828301@gmail.com>
Cc:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mm: mempool: introduce page bulk allocator
Message-ID: <20221013123830.opbulq4qad56kuev@techsingularity.net>
References: <20221005180341.1738796-1-shy828301@gmail.com>
 <20221005180341.1738796-3-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20221005180341.1738796-3-shy828301@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2022 at 11:03:39AM -0700, Yang Shi wrote:
> Since v5.13 the page bulk allocator was introduced to allocate order-0
> pages in bulk.  There are a few mempool allocator callers which does
> order-0 page allocation in a loop, for example, dm-crypt, f2fs compress,
> etc.  A mempool page bulk allocator seems useful.  So introduce the
> mempool page bulk allocator.
> 
> It introduces the below APIs:
>   - mempool_init_pages_bulk()
>   - mempool_create_pages_bulk()
> They initialize the mempool for page bulk allocator.  The pool is filled
> by alloc_page() in a loop.
> 
>   - mempool_alloc_pages_bulk_list()
>   - mempool_alloc_pages_bulk_array()
> They do bulk allocation from mempool.
> They do the below conceptually:
>   1. Call bulk page allocator
>   2. If the allocation is fulfilled then return otherwise try to
>      allocate the remaining pages from the mempool
>   3. If it is fulfilled then return otherwise retry from #1 with sleepable
>      gfp
>   4. If it is still failed, sleep for a while to wait for the mempool is
>      refilled, then retry from #1
> The populated pages will stay on the list or array until the callers
> consume them or free them.
> Since mempool allocator is guaranteed to success in the sleepable context,
> so the two APIs return true for success or false for fail.  It is the
> caller's responsibility to handle failure case (partial allocation), just
> like the page bulk allocator.
> 
> The mempool typically is an object agnostic allocator, but bulk allocation
> is only supported by pages, so the mempool bulk allocator is for page
> allocation only as well.
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Overall, I think it's an ok approach and certainly a good use case for
the bulk allocator.

The main concern that I have is that the dm-crypt use case doesn't really
want to use lists as such and it's just a means for collecting pages to pass
to bio_add_page(). bio_add_page() is working with arrays but you cannot
use that array directly as any change to how that array is populated will
then explode. Unfortunately, what you have is adding pages to a list to
take them off the list and put them in an array and that is inefficient.

How about this

1. Add a callback to __alloc_pages_bulk() that takes a page as a
   parameter like bulk_add_page() or whatever.

2. For page_list == NULL && page_array == NULL, the callback is used

3. Add alloc_pages_bulk_cb() that passes in the name of a callback
   function

4. In the dm-crypt case, use the callback to pass the page to bio_add_page
   for the new page allocated.

It's not free because there will be an additional function call for every
page bulk allocated but I suspect that's cheaper than adding a pile of
pages to a list just to take them off again. It also avoids adding a user
for the bulk allocator list interface that does not even want a list.

It might mean that there is additional cleanup work for __alloc_pages_bulk
to abstract away whether a list, array or cb is used but nothing
impossible.

-- 
Mel Gorman
SUSE Labs

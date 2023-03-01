Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B086A6AC0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 11:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjCAKZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 05:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjCAKZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 05:25:01 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F1558302BE
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 02:24:55 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F004E2F4;
        Wed,  1 Mar 2023 02:25:38 -0800 (PST)
Received: from [10.57.79.100] (unknown [10.57.79.100])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 42AAC3FB90;
        Wed,  1 Mar 2023 02:24:55 -0800 (PST)
Message-ID: <a7cd938e-a86f-e3af-f56c-433c92ac69c2@arm.com>
Date:   Wed, 1 Mar 2023 10:24:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: What size anonymous folios should we allocate?
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org
References: <Y/U8bQd15aUO97vS@casper.infradead.org>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <Y/U8bQd15aUO97vS@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to throw in my 2p here. Although quick disclaimer first; I'm new to mm
so I'm sure I'll say a bunch of dumb stuff - please go easy ;-)

In the few workloads that I'm focused on, I can see a disparity in performance
between a kernel configured for 4K vs 16K pages. My goal is to release the extra
performance we see in the 16K variant into the 4K variant.

My results show that a ~half of the uplift is down to SW efficiency savings in
the kernel; 4x fewer data aborts (vast majority for anon memory) and less effort
spent in mm-heavy syscalls (as expected). And the other ~half is down to HW; the
TLB has less pressure, which causes everything to speed up a bit. But this "bit"
is important, given most of the time is spent in user space, which only benefits
from the HW part. See [1] for more details.

Newer Arm CPUs have a uarch feature called Hardware Page Aggregation (HPA). This
allows the TLB to aggregate 2-8 physically- and virtually- contiguous pages into
a single TLB entry to reduce pressure. (Note this is separate from the contig
bit and is invisible from a SW programming perspective).

So my hope is that I can get the equivalent SW efficiencies with a 4K base page
size and large anonymous folios, and also benefit from a lot of the HW
performance due to it all naturally fitting HPA's requirements.


On 21/02/2023 21:49, Matthew Wilcox wrote:
> In a sense this question is premature, because we don't have any code
> in place to handle folios which are any size but PMD_SIZE or PAGE_SIZE,
> but let's pretend that code already exists and is just waiting for us
> to answer this policy question.
> 
> I'd like to reject three ideas up front: 1. a CONFIG option, 2. a boot
> option and 3. a sysfs tunable.  It is foolish to expect the distro
> packager or the sysadmin to be able to make such a decision.  The
> correct decision will depend upon the instantaneous workload of the
> entire machine and we'll want different answers for different VMAs.
> 
> I'm open to applications having some kind of madvise() call they can
> use to specify hints, but I would prefer to handle memory efficiently
> for applications which do not.

Firmly agree.

> 
> For pagecache memory, we use the per-fd readahead code; if readahead has
> been successful in the past we bump up the folio size until it reaches
> its maximum.  There is no equivalent for anonymous memory.
> 
> I'm working my way towards a solution that looks a little like this:
> 
> A. We modify khugepaged to quadruple the folio size each time it scans.
>    At the moment, it always attempts to promote straight from order 0
>    to PMD size.  Instead, if it finds four adjacent order-0 folios,
>    it will allocate an order-2 folio to replace them.  Next time it
>    scans, it finds four order-2 folios and replaces them with a single
>    order-4 folio.  And so on, up to PMD order.


From the SW efficiencies perspective, what is the point of doing a replacement
after you have allocated all the order-0 folios? Surely that just adds more
overhead? I think the aim has to be to try to allocate the correct order up
front to cut down the allocation cost; one order-2 allocation is ~4x less
expensive than 4x order-0, right?

I wonder if it is preferable to optimistically allocate a mid-order folio to
begin with, then later choose to split or merge from there? Perhaps these folios
could initially go on a separate list to make them faster to split and reclaim
the unused portions when under memory pressure? (My data/workloads suggest 16K
allocations are knee, and making them bigger than that doesn't proportionally
improve performance).

> 
> B. A further modification is that it will require three of the four
>    folios being combined to be on the active list.  If two (or more)
>    of the four folios are inactive, we should leave them alone; either
>    they will remain inactive and eventually be evicted, or they will be
>    activated and eligible for merging in a future pass of khugepaged.
> 
> C. We add a new wrinkle to the LRU handling code.  When our scan of the
>    active list examines a folio, we look to see how many of the PTEs
>    mapping the folio have been accessed.  If it is fewer than half, and
>    those half are all in either the first or last half of the folio, we
>    split it.  The active half stays on the active list and the inactive
>    half is moved to the inactive list.
> 
> I feel that these three changes should allow us to iterate towards a
> solution for any given VMA that is close to optimal, and adapts to a
> changing workload with no intervention from a sysadmin, or even hint
> from a program.
> 
> There are three different circumstances where we currently allocate
> anonymous memory.  The first is for mmap(MAP_ANONYMOUS), the second is
> COW on a file-backed MAP_PRIVATE and the third is COW of a post-fork
> anonymous mapping.
> 
> For the first option, the only hint we have is the size of the VMA.
> I'm tempted to suggest our initial guess at the right size folio to
> allocate should be scaled to that, although I don't have a clear idea
> about what the scale factor should be.

Ahh - perhaps I misunderstood what you were saying above. My experience has been
that order-2 seems to be the knee in terms of performance gain, so perhaps one
approach would be to start with order-2 allocations, then adjust based on the
observed page fault pattern within the VMA? i.e. if you're getting mostly
in-order faults, increase the VMA's scaling factor, and if its mostly random,
decrease. (just a suggestion based on intuition, so feel free to shoot it down).

> 
> For the second case, I want to strongly suggest that the size of the
> folio allocated by the page cache should be of no concern.  It is largely
> irrelevant to the application's usage pattern what size the page cache
> has chosen to cache the file.  I might start out very conservatively
> here with an order-0 allocation.
> 
> For the third case, in contrast, the parent had already established
> an appropriate size folio to use for this VMA before calling fork().
> Whether it is the parent or the child causing the COW, it should probably
> inherit that choice and we should default to the same size folio that
> was already found.
> 
> 
> I don't stay current with the research literature, so if someone wants
> to point me to a well-studied algorithm and let me know that I can stop
> thinking about this, that'd be great.  And if anyone wants to start
> working on implementing this, that'd also be great.
> 
> P.S. I didn't want to interrupt the flow of the above description to
> note that allocation of any high-order folio can and will fail, so
> there will definitely be fallback points to order-0 folios, which will
> be no different from today.  Except that maybe we'll be able to iterate
> towards the correct folio size in the new khugepaged.
> 
> P.P.S. I still consider myself a bit of a novice in the handling of
> anonymous memory, so don't be shy to let me know what I got wrong.
> 
> 

Thanks,
Ryan

[1] https://lore.kernel.org/linux-mm/4c991dcb-c5bb-86bb-5a29-05df24429607@arm.com/


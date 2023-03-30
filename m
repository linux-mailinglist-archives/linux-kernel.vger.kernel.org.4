Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23ED96CFA98
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 07:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjC3FOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 01:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjC3FOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 01:14:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7789E4EE4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 22:14:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00559B825AB
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 05:14:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA7B8C433EF;
        Thu, 30 Mar 2023 05:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680153243;
        bh=xnr6GkmuPQBX2CfvXMCyH+BeYqP+rDi3Om9oGJN4E6A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X88rXo6Kn8GpVuEer6q4mKi/UOgR67iY+NFv1SZi5qFZWw7tm4rKjjCD3qFqOfVEv
         dgh8qWCazrmlWeonzBeCFQM8+78c14GqdgqjunzRW16W8K5eSzv4jBGIzlhRFQ7Tn1
         d8xTBBlpLwnx9CdUdUWKn/A8t0lpa3ntUQ4UsrBnbPVcwUj3eSsp0wb2hnh+vt0T6W
         wNhqd8+vy/y1+qnPrTtt4TPaJktJMrUWX8GPdrgY0oSXj7JivlPtngaQ8e5/9I3kUU
         gI8oOaOKNf/eUFLC36X9ZSKWUeNGxPdNtcDc4JY/BWVb0CU5suOOK4ecX9DyK2uGNv
         +VX3GpcPXiPpQ==
Date:   Thu, 30 Mar 2023 08:13:48 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Song Liu <song@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [RFC PATCH 1/5] mm: intorduce __GFP_UNMAPPED and unmapped_alloc()
Message-ID: <ZCUajG1uTniQcmlN@kernel.org>
References: <20230308094106.227365-2-rppt@kernel.org>
 <ZB1hS9lBabp1K7XN@dhcp22.suse.cz>
 <ZB6W1C88TU6CcjJH@kernel.org>
 <ZCGdf95RvXB1RivU@dhcp22.suse.cz>
 <ZCKIX3de5AZfGggK@kernel.org>
 <ZCKZuXxq38obmYpn@dhcp22.suse.cz>
 <ZCMDmHSqOeCj1EIo@kernel.org>
 <ZCMGwWmF9MGObSlt@dhcp22.suse.cz>
 <ZCPoglyi7fDkXKmB@kernel.org>
 <ZCPzI3ns2PusACi6@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCPzI3ns2PusACi6@dhcp22.suse.cz>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 10:13:23AM +0200, Michal Hocko wrote:
> On Wed 29-03-23 10:28:02, Mike Rapoport wrote:
> > On Tue, Mar 28, 2023 at 05:24:49PM +0200, Michal Hocko wrote:
> > > On Tue 28-03-23 18:11:20, Mike Rapoport wrote:
> > > > On Tue, Mar 28, 2023 at 09:39:37AM +0200, Michal Hocko wrote:
> > > [...]
> > > > > OK, so you want to reduce that direct map fragmentation?
> > > > 
> > > > Yes.
> > > > 
> > > > > Is that a real problem?
> > > > 
> > > > A while ago Intel folks published report [1] that showed better performance
> > > > with large pages in the direct map for majority of benchmarks.
> > > > 
> > > > > My impression is that modules are mostly static thing. BPF
> > > > > might be a different thing though. I have a recollection that BPF guys
> > > > > were dealing with direct map fragmention as well.
> > > > 
> > > > Modules are indeed static, but module_alloc() used by anything that
> > > > allocates code pages, e.g. kprobes, ftrace and BPF. Besides, Thomas
> > > > mentioned that having code in 2M pages reduces iTLB pressure [2], but
> > > > that's not only about avoiding the splits in the direct map but also about
> > > > using large mappings in the modules address space.
> > > > 
> > > > BPF guys suggested an allocator for executable memory [3] mainly because
> > > > they've seen performance improvement of 0.6% - 0.9% in their setups [4].
> > > 
> > > These are fair arguments and it would have been better to have them in
> > > the RFC. Also it is not really clear to me what is the actual benefit of
> > > the unmapping for those usecases. I do get they want to benefit from
> > > caching on the same permission setup but do they need unmapping as well?
> > 
> > The pages allocated with module_alloc() get different permissions depending
> > on whether they belong to text, rodata, data etc. The permissions are
> > updated in both vmalloc address space and in the direct map. The updates to
> > the direct map cause splits of the large pages.
> 
> That much is clear (wouldn't hurt to mention that in the changelog
> though).
> 
> > If we cache large pages as
> > unmapped we take out the entire 2M page from the direct map and then
> > if/when it becomes free it can be returned to the direct map as a 2M page.
> > 
> > Generally, the unmapped allocations are intended for use-cases that anyway
> > map the memory elsewhere than direct map and need to modify direct mappings
> > of the memory, be it modules_alloc(), secretmem, PKS page tables or maybe
> > even some of the encrypted VM memory.
> 
> I believe we are still not on the same page here. I do understand that
> you want to re-use the caching capability of the unmapped_pages_alloc
> for modules allocations as well. My question is whether module_alloc
> really benefits from the fact that the memory is unmapped?
> 
> I guess you want to say that it does because it wouldn't have to change
> the permission for the direct map but I do not see that anywhere in the
> patch...

This happens automagically outside the patch :)

Currently, to change memory permissions modules code calls set_memory APIs
and passes vmalloced address to them. set_memory functions lookup the
direct map alias and update the permissions there as well.
If the memory allocated with module_alloc() is unmapped in the direct map,
there won't be an alias for set_memory APIs to update.

> Also consinder the slow path where module_alloc needs to
> allocate a fresh (huge)page and unmap it. Does the overhead of the
> unmapping suits needs of all module_alloc users? Module loader is likely
> not interesting as it tends to be rather static but what about BPF
> programs?

The overhead of unmapping pages in the direct map on allocation path will
be offset by reduced overhead of updating permissions in the direct map
after the allocation. Both are using the same APIs and if today the
permission update causes a split of a large page, unmapping of a large page
won't.

Of course in a loaded system unmapped_alloc() won't be able to always
allocated large pages to replenish the cache, but still there will be fewer
updates to the direct map.
 
> -- 
> Michal Hocko
> SUSE Labs

-- 
Sincerely yours,
Mike.

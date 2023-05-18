Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84E77084D0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 17:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjERPYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 11:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjERPYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 11:24:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62753101
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 08:24:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 005E864EA5
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 15:24:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF07C433D2;
        Thu, 18 May 2023 15:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684423447;
        bh=v0SsDVfwkV9F6cxXOgPEbvOl1RmonlIJbYhnuXEl1t4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tSVHCkg86b6yBZJJYTUOCAE5f2zPx5c14xAicJ/kF5k6PA4nSBYPTLLGb4rlRv9o8
         t1yQlIcUuyvubfsdZk4mcd+H03qgoA0199bZa32B10WwcHDTC0KFoISWSPIFvNL7h9
         TzjImPeHW5MvjHwUDlbmrvTb2B63ovLtX8p0BTWH6O2l5jC+h4opN2VLiW9L2r7+Je
         j9puf1abi/v4B9Bb/ZH5jCl0BC2xHxas0s0j8JfnMeRa5DV9/HVa10RGJFsZ2x71qw
         SY0BlDQw6HAkbT0pN3qs+smtWxUX/DUOPVWwbqr6VjEQ7UKn81TP4gOln7szjgcJSn
         bdCN43XBP+5ng==
Date:   Thu, 18 May 2023 18:23:54 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Song Liu <song@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [RFC PATCH 1/5] mm: intorduce __GFP_UNMAPPED and unmapped_alloc()
Message-ID: <20230518152354.GD4967@kernel.org>
References: <20230308094106.227365-1-rppt@kernel.org>
 <20230308094106.227365-2-rppt@kernel.org>
 <ZGWdHC3Jo7tFUC59@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGWdHC3Jo7tFUC59@moria.home.lan>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 11:35:56PM -0400, Kent Overstreet wrote:
> On Wed, Mar 08, 2023 at 11:41:02AM +0200, Mike Rapoport wrote:
> > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> > 
> > When set_memory or set_direct_map APIs used to change attribute or
> > permissions for chunks of several pages, the large PMD that maps these
> > pages in the direct map must be split. Fragmenting the direct map in such
> > manner causes TLB pressure and, eventually, performance degradation.
> > 
> > To avoid excessive direct map fragmentation, add ability to allocate
> > "unmapped" pages with __GFP_UNMAPPED flag that will cause removal of the
> > allocated pages from the direct map and use a cache of the unmapped pages.
> > 
> > This cache is replenished with higher order pages with preference for
> > PMD_SIZE pages when possible so that there will be fewer splits of large
> > pages in the direct map.
> > 
> > The cache is implemented as a buddy allocator, so it can serve high order
> > allocations of unmapped pages.
> 
> So I'm late to this discussion, I stumbled in because of my own run in
> with executable memory allocation.
> 
> I understand that post LSF this patchset seems to not be going anywhere,
> but OTOH there's also been a desire for better executable memory
> allocation; as noted by tglx and elsewhere, there _is_ a definite
> performance impact on page size with kernel text - I've seen numbers in
> the multiple single digit percentage range in the past.
> 
> This patchset does seem to me to be roughly the right approach for that,
> and coupled with the slab allocator for sub-page sized allocations it
> seems there's the potential for getting a nice interface that spans the
> full range of allocation sizes, from small bpf/trampoline allocations up
> to modules.
> 
> Is this patchset worth reviving/continuing with? Was it really just the
> needed module refactoring that was the blocker?

As I see it, this patchset only one building block out of three? four?
If we are to repurpose it for code allocations it should be something like

1) allocate 2M page to fill the cache
2) remove this page from the direct map
3) map the 2M page ROX in module address space (usually some part of
   vmalloc address space)
4) allocate a smaller chunk of that page to the actual caller (bpf,
   modules, whatever)

Right now (3) and (4) won't work for modules because they mix code and data
in a single allocation.

So module refactoring is a blocker and another blocker is to teach vmalloc
to map the areas for the executable memory with 2M pages and probably
something else.

I remember there was an attempt to add VM_ALLOW_HUGE_VMAP to
x86::module_alloc(), but it caused problems and was reverted. Sorry, I
could not find the lore link.

There was a related discussion here:

https://lore.kernel.org/all/14D6DBA0-0572-44FB-A566-464B1FF541E0@fb.com/

-- 
Sincerely yours,
Mike.

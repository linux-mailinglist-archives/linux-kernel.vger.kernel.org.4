Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A211066144E
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 10:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjAHJa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 04:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjAHJay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 04:30:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2342F263B
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 01:30:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64DFE60C3D
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 09:30:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F24C433EF;
        Sun,  8 Jan 2023 09:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673170251;
        bh=kOhhVFFhBDGqUh/brGt5JGVkand7yI9Pjr/HEe7Ulxk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IjJc/c5QE4w+O313L9gvAEilkwzuGR/fSlK3BYDNEfErYiMj/NtW3FY+cdzFkw6Tg
         MS7k2+l+NpX3KRqD25fLUNAmaUrEpiiEFt2KrW6G6I/Y7xR4CNC/T1U+x6bLoemMbm
         ihpgySs8fLdY0dB7VgLOk2AuqQHowoOCh7ogBL0rdNGscutqrzJeULgKjU09XpuJTI
         cbmLSUQTCBqjzgg+3pwggUWwx0BbKiiMnk3BRLh1NaBcMOISfuun6PwLqoubUx0HQJ
         80gKJzjLAADutN5LLyyZCxyQ25xo19wAx9zC7D3IPCBXoQbs5KOgLBhC4G9ZPxHIVC
         z99fZB9Gp70fg==
Date:   Sun, 8 Jan 2023 11:30:37 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, NeilBrown <neilb@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/6] mm: discard __GFP_ATOMIC
Message-ID: <Y7qNPfvlTZKBXIEe@kernel.org>
References: <20221129151701.23261-1-mgorman@techsingularity.net>
 <20221129151701.23261-7-mgorman@techsingularity.net>
 <Y7bVeE1gtSmS25td@kernel.org>
 <20230106093524.ck5otyaopd724een@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106093524.ck5otyaopd724een@techsingularity.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 09:35:24AM +0000, Mel Gorman wrote:
> On Thu, Jan 05, 2023 at 03:49:44PM +0200, Mike Rapoport wrote:
> > Hi Mel,
> > 
> > On Tue, Nov 29, 2022 at 03:17:01PM +0000, Mel Gorman wrote:
> > > From: NeilBrown <neilb@suse.de>
> > > 
> > > __GFP_ATOMIC serves little purpose.  Its main effect is to set
> > > ALLOC_HARDER which adds a few little boosts to increase the chance of an
> > > allocation succeeding, one of which is to lower the water-mark at which it
> > > will succeed.
> > > 
> > > It is *always* paired with __GFP_HIGH which sets ALLOC_HIGH which also
> > > adjusts this watermark.  It is probable that other users of __GFP_HIGH
> > > should benefit from the other little bonuses that __GFP_ATOMIC gets.
> > > 
> > > __GFP_ATOMIC also gives a warning if used with __GFP_DIRECT_RECLAIM.
> > > There is little point to this.  We already get a might_sleep() warning if
> > > __GFP_DIRECT_RECLAIM is set.
> > > 
> > > __GFP_ATOMIC allows the "watermark_boost" to be side-stepped.  It is
> > > probable that testing ALLOC_HARDER is a better fit here.
> > > 
> > > __GFP_ATOMIC is used by tegra-smmu.c to check if the allocation might
> > > sleep.  This should test __GFP_DIRECT_RECLAIM instead.
> > > 
> > > This patch:
> > >  - removes __GFP_ATOMIC
> > >  - allows __GFP_HIGH allocations to ignore watermark boosting as well
> > >    as GFP_ATOMIC requests.
> > >  - makes other adjustments as suggested by the above.
> > > 
> > > The net result is not change to GFP_ATOMIC allocations.  Other
> > > allocations that use __GFP_HIGH will benefit from a few different extra
> > > privileges.  This affects:
> > >   xen, dm, md, ntfs3
> > >   the vermillion frame buffer
> > >   hibernation
> > >   ksm
> > >   swap
> > > all of which likely produce more benefit than cost if these selected
> > > allocation are more likely to succeed quickly.
> > > 
> > > [mgorman: Minor adjustments to rework on top of a series]
> > > Link: https://lkml.kernel.org/r/163712397076.13692.4727608274002939094@noble.neil.brown.name
> > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> > > ---
> > >  Documentation/mm/balance.rst   |  2 +-
> > 
> > Documentation/core-api/memory-allocation.rst needs an update as well, and
> > there are other mentions of GFP_ATOMIC in Documentation/
> > 
> 
> What part do you think needs updating in that file?
>
> There are two references to GFP_ATOMIC in that file, one about accessing
> reserves and another about non-sleeping allocations and the accuracy
> does not change after the series.

You are right, I got confused.

> If anything, this statement should change because it invites GFP_ATOMIC
> abuse for spurious reasons
> 
>   * If you think that accessing memory reserves is justified and the kernel
>     will be stressed unless allocation succeeds, you may use ``GFP_ATOMIC``.

Care to send a patch? ;-)
 
> There are other references to GFP_ATOMIC in Documentation/ that are are a
> little inaccurate but not in a way that is harmful and is not changed by
> the series. For example;
> 
> 	GFP_ATOMIC requests are kernel internal allocations that must
> 	be satisfied, immediately.  The kernel may drop some request,
> 	in rare cases even panic, if a GFP_ATOMIC alloc fails.
> 
> This is a stronger statement than GFP_ATOMIC deserves but it's close enough
> in the given context.
> 
> -- 
> Mel Gorman
> SUSE Labs
> 

-- 
Sincerely yours,
Mike.

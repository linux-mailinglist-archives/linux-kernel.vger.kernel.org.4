Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF319600542
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 04:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbiJQCir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 22:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbiJQCia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 22:38:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74F145F49
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 19:38:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44F6860F00
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 02:38:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B85C433C1;
        Mon, 17 Oct 2022 02:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1665974308;
        bh=m863YB6o4rswhZYdI5CDz0jbWRvS7MOt8KB2hFC4S3M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ylz297VEVHewx6YBQIegnEyi0kHKHm9Tnbe3TPLJcYCPGyNF/cPkAi6Qh5W/kXtaU
         sthS7gz4wpyfPyJi1TDyta+xd6DYFC5+OGbzrl52bElFQ3SUAcrFphkc2R6GPEYat3
         DKyXGzk3D0UHL2N/8FcgMV4dkOxODDBA4R0aWomQ=
Date:   Sun, 16 Oct 2022 19:38:27 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Michal Hocko <mhocko@suse.com>, NeilBrown <neilb@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] MM: discard __GFP_ATOMIC
Message-Id: <20221016193827.37c8c2165b22ae4401c269b4@linux-foundation.org>
In-Reply-To: <20220907094724.5lanecgcjg75vxv3@techsingularity.net>
References: <163712397076.13692.4727608274002939094@noble.neil.brown.name>
        <YZvItUOgTgD11etC@dhcp22.suse.cz>
        <163764199967.7248.2528204111227925210@noble.neil.brown.name>
        <YZzvcjRYTL+XEHHz@dhcp22.suse.cz>
        <20220430113028.9daeebeedf679aa384da5945@linux-foundation.org>
        <Yxb4TQ0WDa85uurY@dhcp22.suse.cz>
        <20220907094724.5lanecgcjg75vxv3@techsingularity.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Sep 2022 10:47:24 +0100 Mel Gorman <mgorman@techsingularity.net> wrote:

> On Tue, Sep 06, 2022 at 09:35:41AM +0200, Michal Hocko wrote:
> > > From: "NeilBrown" <neilb@suse.de>
> > > Subject: mm: discard __GFP_ATOMIC
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
> > >  - causes __GFP_HIGH to set ALLOC_HARDER unless __GFP_NOMEMALLOC is set
> > >    (as well as ALLOC_HIGH).
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
> > 
> > This is a good summary of the current usage and existing issues. It also
> > shows that the naming is tricky and allows people to make wrong calls
> > (tegra-smmu.c). I also thing that it is wrong to couple memory reserves
> > access to the reclaim constrains/expectations of the caller.
> > 
> 
> I think it's worth trying to get rid of __GFP_ATOMIC although this patch
> needs to be rebased. Without rebasing it, I suspect there is a corner case
> for reserving high order atomic blocks. A high-order atomic allocation
> might get confused with a __GFP_HIGH high-order allocation that can sleep.
> It would not be completely irrational to have such a caller if it was in a
> path that can tolerate a stall but stalling might have visible consequences.
> I'm also worried that the patch might allow __GFP_HIGH to ignore cpusets
> which is probably not intended by direct users like ksm.

Unclear what you mean by "rebased".  You're saying the patch might have
issues - doesn't that mean it needs to be "fixed"?

Anyway, I've been maintaining this change for nearly a year - if
nothing happens soon I guess I'll drop it so it doesn't get in people's
way.


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813AE666EA4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237148AbjALJty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240070AbjALJtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:49:14 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D911BD45
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 01:45:11 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 619273ED65;
        Thu, 12 Jan 2023 09:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673516710; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KNiMMQNVa5sMzIVJxz1JeBcyurPbf7owbHpmHsMMjls=;
        b=M/ll2JxbXKarOND/NWDMQnnEv4wMiNFhx+H1RxnuakOBXNgAZXW67kEbJuMOZPUwqg850S
        bkyJR/TXsfKRzS3dLAqzrsft5vi7oY2acCNtbR599ljSeoEC0oZiCemGMA7B16OZRfQaO+
        qQPxgWpvKe1Q5+fnR6DtkjLk9TVkCVo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F0CD013585;
        Thu, 12 Jan 2023 09:45:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id W2ZzK6XWv2NDHAAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 12 Jan 2023 09:45:09 +0000
Date:   Thu, 12 Jan 2023 10:45:07 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        NeilBrown <neilb@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/7] mm/page_alloc: Give GFP_ATOMIC and non-blocking
 allocations access to reserves
Message-ID: <Y7/Wo+09moX5OMrH@dhcp22.suse.cz>
References: <20230109151631.24923-1-mgorman@techsingularity.net>
 <20230109151631.24923-7-mgorman@techsingularity.net>
 <Y77cikPSHepZ/GQj@dhcp22.suse.cz>
 <20230111170552.5b7z5hetc2lcdwmb@techsingularity.net>
 <Y7/AmgN1Wz73lyVz@dhcp22.suse.cz>
 <20230112092452.rtvo6tkp4rpmxm7v@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112092452.rtvo6tkp4rpmxm7v@techsingularity.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 12-01-23 09:24:52, Mel Gorman wrote:
> On Thu, Jan 12, 2023 at 09:11:06AM +0100, Michal Hocko wrote:
> > On Wed 11-01-23 17:05:52, Mel Gorman wrote:
> > > On Wed, Jan 11, 2023 at 04:58:02PM +0100, Michal Hocko wrote:
> > > > On Mon 09-01-23 15:16:30, Mel Gorman wrote:
> > > > > Explicit GFP_ATOMIC allocations get flagged ALLOC_HARDER which is a bit
> > > > > vague. In preparation for removing __GFP_ATOMIC, give GFP_ATOMIC and
> > > > > other non-blocking allocation requests equal access to reserve.  Rename
> > > > > ALLOC_HARDER to ALLOC_NON_BLOCK to make it more clear what the flag
> > > > > means.
> > > > 
> > > > GFP_NOWAIT can be also used for opportunistic allocations which can and
> > > > should fail quickly if the memory is tight and more elaborate path
> > > > should be taken (e.g. try higher order allocation first but fall back to
> > > > smaller request if the memory is fragmented). Do we really want to give
> > > > those access to memory reserves as well?
> > > 
> > > Good question. Without __GFP_ATOMIC, GFP_NOWAIT only differs from GFP_ATOMIC
> > > by __GFP_HIGH but that is not enough to distinguish between a caller that
> > > cannot sleep versus one that is speculatively attempting an allocation but
> > > has other options. That changelog is misleading, it's not equal access
> > > as GFP_NOWAIT ends up with 25% of the reserves which is less than what
> > > GFP_ATOMIC gets.
> > > 
> > > Because it becomes impossible to distinguish between non-blocking and
> > > atomic without __GFP_ATOMIC, there is some justification for allowing
> > > access to reserves for GFP_NOWAIT. bio for example attempts an allocation
> > > (clears __GFP_DIRECT_RECLAIM) before falling back to mempool but delays
> > > in IO can also lead to further allocation pressure. mmu gather failing
> > > GFP_WAIT slows the rate memory can be freed. NFS failing GFP_NOWAIT will
> > > have to retry IOs multiple times. The examples were picked at random but
> > > the point is that there are cases where failing GFP_NOWAIT can degrade
> > > the system, particularly delay the cleaning of pages before reclaim.
> > 
> > Fair points.
> > 
> > > A lot of the truly speculative users appear to use GFP_NOWAIT | __GFP_NOWARN
> > > so one compromise would be to avoid using reserves if __GFP_NOWARN is
> > > also specified.
> > > 
> > > Something like this as a separate patch?
> > 
> > I cannot say I would be happy about adding more side effects to
> > __GFP_NOWARN. You are right that it should be used for those optimistic
> > allocation requests but historically all many of these subtle side effects
> > have kicked back at some point.
> 
> True.
> 
> > Wouldn't it make sense to explicitly
> > mark those places which really benefit from reserves instead?
> 
> That would be __GFP_HIGH and would require context from every caller on
> whether they need reserves or not and to determine what the consequences
> are if there is a stall. Is there immediate local fallout or wider fallout
> such as a variable delay before pages can be cleaned?

Yes, and I will not hide I do not mind putting the burden on caller to
justify adding requirement and eat from otherwise shared pool which
memory reserves are.

> > This is
> > more work but it should pay off long term. Your examples above would use
> > GFP_ATOMIC instead of GFP_NOWAIT.
> > 
> 
> Yes, although it would confuse the meaning of GFP_ATOMIC as a result.
> It's described as "%GFP_ATOMIC users can not sleep and need the allocation to
> succeed" and something like the bio callsite does not *need* the allocation
> to succeed. It can fallback to the mempool and performance simply degrades
> temporarily. No doubt there are a few abuses of GFP_ATOMIC just to get
> non-blocking behaviour already.

I am afraid GFP_ATOMIC will eventually require a closer look. Many
users are simply confused by the name and use it from the spin lock
context. Others use it from IRQ context because that is the right thing
to do (TM).

> > The semantic would be easier to explain as well. GFP_ATOMIC - non
> > sleeping allocations which are important so they have access to memory
> > reserves. GFP_NOWAIT - non sleeping allocations.
> > 
> 
> People's definition of "important" will vary wildly. The following would
> avoid reserve access for GFP_NOWAIT for now. It would need to be folded
> into this patch and a new changelog

OK, so that effectively means that __GFP_HIGH modifier will give more
reserves to non-sleepable allocations than sleepable. That is a better
semantic than other special casing because when the two allocations are
competing then the priority non-sleepable should win because it simply
cannot reclaim. That hierarchy makes sense to me. Thanks for bearing
with me here. Changing gfp flags semantic is a PITA. I wish would could
design the whole thing from scratch (and screw it in yet another way).

I will ack the patch once you post the full version of it.
-- 
Michal Hocko
SUSE Labs

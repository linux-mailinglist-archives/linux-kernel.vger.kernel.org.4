Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18923622DC7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 15:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbiKIO0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 09:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiKIO02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 09:26:28 -0500
Received: from outbound-smtp23.blacknight.com (outbound-smtp23.blacknight.com [81.17.249.191])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C151C24097
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 06:24:48 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp23.blacknight.com (Postfix) with ESMTPS id 2272ABECF8
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 14:24:47 +0000 (GMT)
Received: (qmail 3366 invoked from network); 9 Nov 2022 14:24:46 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 9 Nov 2022 14:24:46 -0000
Date:   Wed, 9 Nov 2022 14:24:44 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH v2] mm/page_alloc: Leave IRQs enabled for per-cpu page
 allocations
Message-ID: <20221109142444.iml2maqdqxpl2vdw@techsingularity.net>
References: <20221104142259.5hohev5hzvwanbi2@techsingularity.net>
 <97b7ae87-797c-4ebb-d2d3-9415975188@google.com>
 <20221107111649.rzfgqk3ebvicsuyw@techsingularity.net>
 <486a93d7-4140-60c9-1aa8-8dafc8c66210@google.com>
 <20221108135703.cthdmjl2lfpnairr@techsingularity.net>
 <dc5548f6-00-8027-bf79-397d552ec338@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <dc5548f6-00-8027-bf79-397d552ec338@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 07:47:12AM -0800, Hugh Dickins wrote:
> On Tue, 8 Nov 2022, Mel Gorman wrote:
> > On Tue, Nov 08, 2022 at 01:40:48AM -0800, Hugh Dickins wrote:
> > > On Mon, 7 Nov 2022, Mel Gorman wrote:
> > > > On Sun, Nov 06, 2022 at 08:42:32AM -0800, Hugh Dickins wrote:
> > > > > On Fri, 4 Nov 2022, Mel Gorman wrote:
> > > > > What I'm really trying to do is fix
> > > > > the bug in Linus's rmap/TLB series, and its interaction with my
> > > > > rmap series, and report back on his series (asking for temporary
> > > > > drop), before next-20221107 goes down in flames.
> > > > > 
> > > > > I'd advocate for dropping this patch of yours too; but if it's giving
> > > > > nobody else any trouble, I can easily continue to patch it out.
> > > > > 
> > > > 
> > > > Given that you tested the patch against v6.1-rc3, it's clear that the
> > > > patch on its own causes problems. Having a reproduction case will help
> > > > me figure out why.
> > > 
> > > Sorry for appearing to ignore your requests all day, Mel, but I just
> > > had slightly more confidence in debugging it here, than in conveying
> > > all the details of my load (some other time), and my config, and
> > > actually enabling you to reproduce it.  Had to focus.
> > > 
> > 
> > Ok, understood. If you ever get the chance to give me even a rough
> > description, I'd appreciate it but I understand that it's a distraction
> > at the moment. Thanks for taking the time to debug this in your test
> > environment.
> 
> I have sent it out two or three times before (I prefer privately, so my
> limited shell scripting skills are not on public view!): later in the day
> I'll look out the last time I sent it, and just forward that to you.

Thanks.

> No doubt I'll have tweaked it here and there in my own usage since then,
> but that will be good enough to show what I try for.
> 

It should be. I'll know it's at least partially successful if the v2
crashes in the same way you reported.

> Wonderful if it could get into something like mmtests, but I should
> warn that attempts to incorporate it into other frameworks have not
> been successful in the past. 

I'm stubborn enough to try. Even if the end result is ugly, it will still
not be the first ugly hack in mmtests that still had a useful purpose.

> Maybe it just needs too much handholding:
> getting the balance right, so that it's stressing without quite OOMing,
> is difficult in any new environment.  Perhaps it should restart after
> OOM, I just never tried to go that way.
> 

As dmesg is always captured after a test, I can set it to detect either
an outright failure or an OOM kill in the dmesg and flag the results as
invalid. Even if this is less than perfect, I can add notes in the config
file on the hazards. If nothing else, it should note that even if it passes,
it's not a guarantee that everything is ok.

> > I've made this a standalone patch which is at the end of the mail. I can
> > change the Reported-by to a Signed-off-by if you agree. While it doesn't
> > fix anything today, it may still be worth documenting in git history why
> > that list_del exists.
> 
> Yes, worth separating out to its own git commit.  Just continue with what
> you already have, Reported-by me, Signed-off-by you, thanks for asking.
> 

Will do.

> > 
> > > Here's a few things to fold into your patch: I've moved your
> > > list_del() up to cover both cases, that's the important fix;
> > > but prior to finding that, I did notice a "locked_zone = NULL"
> > > needed, and was very disappointed when that didn't fix the issues;
> > 
> > This is a real fix but it also should happen to work properly which is
> > less than ideal because it's fragile.
> 
> I thought that if the next page's zone matched the stale locked_zone,
> then it would head into free_unref_page_commit() with NULL pcp, and
> oops there?  But I've certainly never seen that happen (despite first
> assuming it was responsible for my crashes), so maybe I read it wrong.
> 

It's possible that would happen, just very unlikely. Reclaim would generally
pass in pages from the same zone but something like release_pages could
hit it. Triggering a NULL reference would require that the list being
freed consists of pages belonging to two zones interleaved which requires a
fairly specific allocation pattern and then the free to be interrupted by an
allocation request from IRQ context at just the right time. MPOL_INTERLEAVE
might make the necessary allocation pattern easier to hit I suppose. Either
way, the fix is definitely needed even if I think the bug would be hard
to hit in practice.

-- 
Mel Gorman
SUSE Labs

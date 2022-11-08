Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFBA562141B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 14:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234850AbiKHN5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 08:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234840AbiKHN5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 08:57:10 -0500
Received: from outbound-smtp06.blacknight.com (outbound-smtp06.blacknight.com [81.17.249.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4124666C87
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 05:57:08 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp06.blacknight.com (Postfix) with ESMTPS id CE0CCC2AE4
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 13:57:06 +0000 (GMT)
Received: (qmail 24642 invoked from network); 8 Nov 2022 13:57:06 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 8 Nov 2022 13:57:06 -0000
Date:   Tue, 8 Nov 2022 13:57:03 +0000
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
Message-ID: <20221108135703.cthdmjl2lfpnairr@techsingularity.net>
References: <20221104142259.5hohev5hzvwanbi2@techsingularity.net>
 <97b7ae87-797c-4ebb-d2d3-9415975188@google.com>
 <20221107111649.rzfgqk3ebvicsuyw@techsingularity.net>
 <486a93d7-4140-60c9-1aa8-8dafc8c66210@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <486a93d7-4140-60c9-1aa8-8dafc8c66210@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 01:40:48AM -0800, Hugh Dickins wrote:
> On Mon, 7 Nov 2022, Mel Gorman wrote:
> > On Sun, Nov 06, 2022 at 08:42:32AM -0800, Hugh Dickins wrote:
> > > On Fri, 4 Nov 2022, Mel Gorman wrote:
> > > What I'm really trying to do is fix
> > > the bug in Linus's rmap/TLB series, and its interaction with my
> > > rmap series, and report back on his series (asking for temporary
> > > drop), before next-20221107 goes down in flames.
> > > 
> > > I'd advocate for dropping this patch of yours too; but if it's giving
> > > nobody else any trouble, I can easily continue to patch it out.
> > > 
> > 
> > Given that you tested the patch against v6.1-rc3, it's clear that the
> > patch on its own causes problems. Having a reproduction case will help
> > me figure out why.
> 
> Sorry for appearing to ignore your requests all day, Mel, but I just
> had slightly more confidence in debugging it here, than in conveying
> all the details of my load (some other time), and my config, and
> actually enabling you to reproduce it.  Had to focus.
> 

Ok, understood. If you ever get the chance to give me even a rough
description, I'd appreciate it but I understand that it's a distraction
at the moment. Thanks for taking the time to debug this in your test
environment.

> Got it at last: free_unref_page_list() has been surviving on the
> "next" in its list_for_each_entry_safe() for years(?), without doing
> a proper list_del() in that block: only with your list_del() before
> free_one_page() did it start to go so very wrong.  (Or was there any
> way in which it might already have been wrong, and needs backport?)
> 

I think it happened to work by coincidence since forever because it was
always adding to the same list. Even though the temporary list was
thrashed, it is always either ignored or reinitialised.

I've made this a standalone patch which is at the end of the mail. I can
change the Reported-by to a Signed-off-by if you agree. While it doesn't
fix anything today, it may still be worth documenting in git history why
that list_del exists.

> Here's a few things to fold into your patch: I've moved your
> list_del() up to cover both cases, that's the important fix;
> but prior to finding that, I did notice a "locked_zone = NULL"
> needed, and was very disappointed when that didn't fix the issues;

This is a real fix but it also should happen to work properly which is
less than ideal because it's fragile.

> zone instead of page_zone(page), batch_count = 0, lock hold times
> were just improvements I noticed along the way.
> 

The first is a small optimisation, the second addresses a corner case where
the lock may be released/reacquired too soon after switching from one zone to
another and the comment fix is valid. I've simply folded these in directly.

The standalone patch is below, I'm rerunning tests before posting a
short v3 series.

Thanks!

--8<--
mm/page_alloc: Always remove pages from temporary list

free_unref_page_list() has neglected to remove pages properly from the list
of pages to free since forever. It works by coincidence because list_add
happened to do the right thing adding the pages to just the PCP lists.
However, a later patch added pages to either the PCP list or the zone list
but only properly deleted the page from the list in one path leading to
list corruption and a subsequent failure. As a preparation patch, always
delete the pages from one list properly before adding to another.  On its
own, this fixes nothing although it adds a fractional amount of overhead
but is critical to the next patch.

Reported-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/page_alloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 218b28ee49ed..1ec54173b8d4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3546,6 +3546,8 @@ void free_unref_page_list(struct list_head *list)
 	list_for_each_entry_safe(page, next, list, lru) {
 		struct zone *zone = page_zone(page);
 
+		list_del(&page->lru);
+
 		/* Different zone, different pcp lock. */
 		if (zone != locked_zone) {
 			if (pcp)

-- 
Mel Gorman
SUSE Labs

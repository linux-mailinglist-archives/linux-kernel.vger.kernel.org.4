Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26B2620C7F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 10:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbiKHJlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 04:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbiKHJlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 04:41:06 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B6232048
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 01:41:01 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id x13so9884611qvn.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 01:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=06saDDydwz8unKSIFpQsb4FEsWN246BAnZfaE3y0tqg=;
        b=N+PxBuSKeKQ9yJR3cOSBBM8A3aYFU4ONq6BbkMh4DkgVezmXJJKaFa9OcnG65xy99x
         jwWmPPSYffHNTdZWY4YLq6Od3lcv3lkfOaDTNMuWIYsbQGWh5xAwg0QzqGZn1ioZFn+Y
         /Zc7Ub4Oa15VS0kyyATdUGRsC12r4L104z3llfRWjkfw/5qylm0aeakvvBQQ1IuoPzkJ
         cnwUHp3hemwT7C6knL6+23Tn3isjKu6zf2Oifcoe/RneXrPwm0tSX1wr4p//j0GwsujM
         cgdoT4RnUHu3ZRdrEDHg3eJAeGUnHE66tIlYyWZMjMRWsyCpV73EZCDOxvsdwC0SdlHf
         V2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=06saDDydwz8unKSIFpQsb4FEsWN246BAnZfaE3y0tqg=;
        b=yPvANyGW2rWJM5lFXi3ORqkp3ac/tZNkzNgnbslHI2oAsStqrDtmoHeeubYHeCv/J0
         uReGVwMM1Q4Nz+YSk1tD97pRv8Y67OREk+x3uw3WULCoYwYY9kyBqaRSj4wfIzFDovVB
         0QLeXbtKJasqWEl9aLYXwne2A0c5FIWSJF77aLS1Q3pDKIN0D+jKTNeRFViZk1m2TjZS
         V2rBGojwaExy9E4sfgT0LyEYst6RugA87UCSOk8NdXIziVeBVWDQ2KP/yJkKXjj50z6c
         ApnvgtF9Ex6J7PeDI5pY/5buflVuAEoOXABy5L/+lsWzoPvX3xE+bsSKfq5NDye+BpJU
         fcnA==
X-Gm-Message-State: ACrzQf0DRg+gxYRIiDX4iNdOBDPD/1TC1tyM/21z4hobDS1tTQss0sne
        BKHBeOzOZo6lAJ1YlwVPUyDYhQ==
X-Google-Smtp-Source: AMsMyM4znueRCQJfDqMb84ah94aDdcgGIknHyT2Bdjzubp286wfZuWZNjt+FdbBdereRbpKI79ilCA==
X-Received: by 2002:a05:6214:19cb:b0:4bb:6a28:83bc with SMTP id j11-20020a05621419cb00b004bb6a2883bcmr49493452qvc.102.1667900460408;
        Tue, 08 Nov 2022 01:41:00 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id ay14-20020a05620a178e00b006bb366779a4sm8982965qkb.6.2022.11.08.01.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 01:40:59 -0800 (PST)
Date:   Tue, 8 Nov 2022 01:40:48 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Mel Gorman <mgorman@techsingularity.net>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH v2] mm/page_alloc: Leave IRQs enabled for per-cpu page
 allocations
In-Reply-To: <20221107111649.rzfgqk3ebvicsuyw@techsingularity.net>
Message-ID: <486a93d7-4140-60c9-1aa8-8dafc8c66210@google.com>
References: <20221104142259.5hohev5hzvwanbi2@techsingularity.net> <97b7ae87-797c-4ebb-d2d3-9415975188@google.com> <20221107111649.rzfgqk3ebvicsuyw@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Nov 2022, Mel Gorman wrote:
> On Sun, Nov 06, 2022 at 08:42:32AM -0800, Hugh Dickins wrote:
> > On Fri, 4 Nov 2022, Mel Gorman wrote:
> > 
> > > Changelog since v1
> > >  o Use trylock in free_unref_page_list due to IO completion from softirq
> > >    context
> > > 
> > > The pcp_spin_lock_irqsave protecting the PCP lists is IRQ-safe as a task
> > > allocating from the PCP must not re-enter the allocator from IRQ context.
> > > In each instance where IRQ-reentrancy is possible, the lock is acquired using
> > > pcp_spin_trylock_irqsave() even though IRQs are disabled and re-entrancy
> > > is impossible.
> > > 
> > > Demote the lock to pcp_spin_lock avoids an IRQ disable/enable in the common
> > > case at the cost of some IRQ allocations taking a slower path. If the PCP
> > > lists need to be refilled, the zone lock still needs to disable IRQs but
> > > that will only happen on PCP refill and drain. If an IRQ is raised when
> > > a PCP allocation is in progress, the trylock will fail and fallback to
> > > using the buddy lists directly. Note that this may not be a universal win
> > > if an interrupt-intensive workload also allocates heavily from interrupt
> > > context and contends heavily on the zone->lock as a result.
> > > 
> > > [yuzhao@google.com: Reported lockdep issue on IO completion from softirq]
> > > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> > 
> > Hi Mel, I think you Cc'ed me for the purpose of giving this patch a
> > run, and reporting if it's not good.  That is the case, I'm afraid.
> > 
> 
> Thanks for testing and yes, you were cc'd in the hope you'd run it through a
> stress test of some sort. A lot of the test I run are performance orientated
> and relatively few target functional issues.
> 
> > I first tried it on a v6.1-rc3, and very soon crashed under load with
> > something about PageBuddy in the output.  When I reverted, no problem;
> > I thought maybe it's dependent on other commits in akpm's tree.
> > 
> 
> Can you tell me what sort of load it's under? I would like to add something
> similar to the general battery of tests I run all patches affecting the
> page allocator through. Even if this is just a crude shell script, it would
> be enough for me to work with and incorporate into mmtests. If it's there
> and I find mm-unstable has its own problems, bisection can brute force
> the problem.
> 
> > Later I tried on current mm-unstable: which is living up to the name
> > in other ways, but when other issues patched, it soon crashed under
> > load, GPF probably for non-canonical address 0xdead0000000000f8
> > in compact_zone < compact_zone_order < try_to_compact_pages <
> > .... < shmem_alloc_hugefolio < ...
> > 
> 
> 0xdead000* looks like ILLEGAL_POINTER_VALUE which is used as a poison
> value so a full list of debugging options you apply for the stress test
> would also be useful.
> 
> > I do try to exercise compaction as hard as I can, even to the point
> > of having a hack in what used to be called shmem_getpage_gfp(),
> > reverting to the stronger attempt to get huge pages, before Rik
> > weakened the effect of huge=always with vma_thp_gfp_mask() in 5.12:
> > so shmem is probably applying stronger flags for compaction than it
> > would in your tree - I'm using
> > GFP_TRANSHUGE_LIGHT | __GFP_RECLAIM | __GFP_NORETRY there.
> > 
> > Sorry for not giving you more info, I'm rather hoping that compaction
> > is relevant, and will give you a clue (maybe that capture code, which
> > surprised us once before??). 
> 
> While capture is a possibility, it's a bad fit for this patch because
> pages are captured under task context.
> 
> > What I'm really trying to do is fix
> > the bug in Linus's rmap/TLB series, and its interaction with my
> > rmap series, and report back on his series (asking for temporary
> > drop), before next-20221107 goes down in flames.
> > 
> > I'd advocate for dropping this patch of yours too; but if it's giving
> > nobody else any trouble, I can easily continue to patch it out.
> > 
> 
> Given that you tested the patch against v6.1-rc3, it's clear that the
> patch on its own causes problems. Having a reproduction case will help
> me figure out why.

Sorry for appearing to ignore your requests all day, Mel, but I just
had slightly more confidence in debugging it here, than in conveying
all the details of my load (some other time), and my config, and
actually enabling you to reproduce it.  Had to focus.

Got it at last: free_unref_page_list() has been surviving on the
"next" in its list_for_each_entry_safe() for years(?), without doing
a proper list_del() in that block: only with your list_del() before
free_one_page() did it start to go so very wrong.  (Or was there any
way in which it might already have been wrong, and needs backport?)

Here's a few things to fold into your patch: I've moved your
list_del() up to cover both cases, that's the important fix;
but prior to finding that, I did notice a "locked_zone = NULL"
needed, and was very disappointed when that didn't fix the issues;
zone instead of page_zone(page), batch_count = 0, lock hold times
were just improvements I noticed along the way.

Now running fine, and can be reinstated in akpm's tree.

Hugh

--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3515,6 +3515,8 @@ void free_unref_page_list(struct list_he
 	list_for_each_entry_safe(page, next, list, lru) {
 		struct zone *zone = page_zone(page);
 
+		list_del(&page->lru);
+
 		/* Different zone, different pcp lock. */
 		if (zone != locked_zone) {
 			if (pcp) {
@@ -3530,13 +3532,13 @@ void free_unref_page_list(struct list_he
 			pcp = pcp_spin_trylock(zone->per_cpu_pageset);
 			if (!pcp) {
 				pcp_trylock_finish(UP_flags);
-				list_del(&page->lru);
-				free_one_page(page_zone(page), page,
-					      page_to_pfn(page), 0, migratetype,
-					      FPI_NONE);
+				free_one_page(zone, page, page_to_pfn(page),
+					      0, migratetype, FPI_NONE);
+				locked_zone = NULL;
 				continue;
 			}
 			locked_zone = zone;
+			batch_count = 0;
 		}
 
 		/*
@@ -3551,7 +3553,7 @@ void free_unref_page_list(struct list_he
 		free_unref_page_commit(zone, pcp, page, migratetype, 0);
 
 		/*
-		 * Guard against excessive IRQ disabled times when freeing
+		 * Guard against excessive lock hold times when freeing
 		 * a large list of pages. Lock will be reacquired if
 		 * necessary on the next iteration.
 		 */

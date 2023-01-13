Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18EA66952E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 12:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241318AbjAMLOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 06:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbjAMLMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:12:43 -0500
Received: from outbound-smtp28.blacknight.com (outbound-smtp28.blacknight.com [81.17.249.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B9CD10B
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 03:09:57 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp28.blacknight.com (Postfix) with ESMTPS id F1C0E46013
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:09:55 +0000 (GMT)
Received: (qmail 25896 invoked from network); 13 Jan 2023 11:09:54 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 13 Jan 2023 11:09:54 -0000
Date:   Fri, 13 Jan 2023 11:09:52 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Michal Hocko <mhocko@suse.com>, Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        NeilBrown <neilb@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/7] mm/page_alloc: Treat RT tasks similar to __GFP_HIGH
Message-ID: <20230113110952.co52bcxjeptiqsxo@techsingularity.net>
References: <20230109151631.24923-1-mgorman@techsingularity.net>
 <20230109151631.24923-3-mgorman@techsingularity.net>
 <Y77VYdboKBUsILhD@dhcp22.suse.cz>
 <20230112093623.sl4jpqf6f2ng43w2@techsingularity.net>
 <4c169ca43a7b49f1bf61c01181ed585e@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <4c169ca43a7b49f1bf61c01181ed585e@AcuMS.aculab.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 09:04:50AM +0000, David Laight wrote:
> From: Mel Gorman
> > Sent: 12 January 2023 09:36
> ...
> > Hard realtime tasks should be locking down resources in advance. Even a
> > soft-realtime task like audio or video live decoding which cannot jitter
> > should be allocating both memory and any disk space required up-front
> > before the recording starts instead of relying on reserves. At best,
> > reserve access will only delay the problem by a very short interval.
> 
> Or, at least, ensuring the system isn't memory limited.
> 

Added to changelog.

> The biggest effect on RT task latency/jitter (on a normal kernel)
> is hardware interrupt and softint code 'stealing' the cpu.
> The main 'culprit' being ethernet receive.
>  
> Unfortunately if you are doing RTP audio (UDP data) you absolutely
> need the ethernet receive to run. When the softint code decides
> to drop back to a normal priority kernel worker thread packets
> get lost.
> 

Yes, although this is a fundamental problem for background networking
processing in general IIUC that is independent of mm/. ksoftirqd may be
getting stalled behind a higher priority, a realtime task, a task that has
built a credit due to sleep time under GENTLE_FAIR_SLEEPERS relative to
ksoftirqd etc. As a normal low-priority CPU hog may be at the same priority
as ksoftirqd, it can use enough of the scheduler slice for the runqueue to
cause an indirect priority inversion if a high priority task is sleeping
waiting on network traffic it needs ASAP that's stalled on ksoftirqd. I
didn't check for other examples but the only one I'm aware of that boosts
ksoftirq priority is during rcutorture (see rcutorture_booster_init). A
quick glance doesn't show any possibility of boosting ksoftirqd priority
temporarily if dealing with NET_TX_SOFTIRQ although it might be an
interesting idea if it was demonstrated with a realistic (or at least
semi-realistic) test case that priority inversion can occur due to background
RX processing. It's not even PREEMPT_RT-specific, I suspect it's a general
problem. I don't think this series makes a difference because if any of
the critical tasks are depending on the memory reserves, they're already
in serious trouble.

> (I've been running 10000 RTP streams - with 10k receive UDP sockets.)
> 

min_reserve access isn't going to fix any stalls with that volume of
streams :D

> So I doubt avoiding sleeps in kmalloc() is going to make a
> significant difference.
> 

Agreed.

-- 
Mel Gorman
SUSE Labs

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A68066DD5C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 13:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236428AbjAQMSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 07:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237016AbjAQMSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 07:18:45 -0500
Received: from outbound-smtp62.blacknight.com (outbound-smtp62.blacknight.com [46.22.136.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D935035252
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 04:18:42 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp62.blacknight.com (Postfix) with ESMTPS id 60408FA77C
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 12:18:41 +0000 (GMT)
Received: (qmail 26768 invoked from network); 17 Jan 2023 12:18:41 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 17 Jan 2023 12:18:41 -0000
Date:   Tue, 17 Jan 2023 12:18:39 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux-RT <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] locking/rwbase: Prevent indefinite writer starvation
Message-ID: <20230117121839.vnubhcrlms7pt2ab@techsingularity.net>
References: <20230117083817.togfwc5cy4g67e5r@techsingularity.net>
 <20230117105031.2512-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230117105031.2512-1-hdanton@sina.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 06:50:31PM +0800, Hillf Danton wrote:
> On Tue, 17 Jan 2023 08:38:17 +0000 Mel Gorman <mgorman@techsingularity.net>
> > +/*
> > + * Allow reader bias with a pending writer for a minimum of 4ms or 1 tick.
> > + * The granularity is not exact as the lowest bit in rwbase_rt->waiter_blocked
> > + * is used to detect recent rt/dl tasks taking a read lock.
> > + */
> > +#define RW_CONTENTION_THRESHOLD (HZ/250+1)
> > +
> > +static void __sched update_dlrt_reader(struct rwbase_rt *rwb)
> > +{
> > +	/* No update required if dl/rt tasks already identified. */
> > +	if (rwb->waiter_blocked & 1)
> > +		return;
> > +
> > +	/*
> > +	 * Record a dl/rt task acquiring the lock for read. This may result
> > +	 * in indefinite writer starvation but dl/rt tasks should avoid such
> > +	 * behaviour.
> > +	 */
> > +	if (dl_task(current) || rt_task(current)) {
> > +		struct rt_mutex_base *rtm = &rwb->rtmutex;
> > +		unsigned long flags;
> > +
> > +		raw_spin_lock_irqsave(&rtm->wait_lock, flags);
> > +		rwb->waiter_blocked |= 1;
> > +		raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
> > +	}
> > +}
> > +
> > +/* rtmutex->wait_lock must be held. */
> > +static void __sched set_writer_blocked(struct rwbase_rt *rwb)
> > +{
> > +	/*
> > +	 * Lowest bit preserved to identify recent rt/dl tasks acquiring
> > +	 * the lock for read so guarantee at least one tick delay.
> > +	 */
> > +	rwb->waiter_blocked |= (jiffies + 2) & ~1UL;
> > +}
> > +
> > +static bool __sched rwbase_allow_reader_bias(struct rwbase_rt *rwb)
> > +{
> > +	/*
> > +	 * Allow reader bias if a dl or rt task took the lock for read
> > +	 * since the last write unlock. Such tasks should be designed
> > +	 * to avoid heavy writer contention or indefinite starvation.
> > +	 */
> > +	if (rwb->waiter_blocked & 1)
> > +		return true;
> 
> This true opens a window for two tons of readers, no?

I don't understand the question or what you mean by two tons of readers.
In case you mean that the threshold is not precise, it's noted earlier
in a comment.

 * The granularity is not exact as the lowest bit in rwbase_rt->waiter_blocked
 * is used to detect recent rt/dl tasks taking a read lock.

> > +
> > +	/*
> > +	 * Allow reader bias unless a writer has been blocked for more
> > +	 * than RW_CONTENTION_THRESHOLD jiffies.
> > +	 */
> > +	return jiffies - rwb->waiter_blocked < RW_CONTENTION_THRESHOLD;
> 
> Why pure 4ms deadline fails to work without taking care of dlrt tasks?
> 

I don't understand the question. For DL/RT tasks taking the lock for read,
indefinite writer starvation is still possible. It is assumed DL/RT tasks
take care to avoid the scenario. For other tasks, 4 ms is an arbitrary
cutoff so forward progress is made.

> Given it would take 88 seconds to complete the test, is it going to
> take 100 seconds or more for the 4ms deadline?

It took 88 seconds to complete the test. Without the patch, the test
never finishes and is eventually killed after a timeout and marked as
failure. Actual time to completion will vary depending on the machine,
number of CPUs and speed of storage. The point isn't how fast the test
completes, the point is that the test completes successfully.

-- 
Mel Gorman
SUSE Labs

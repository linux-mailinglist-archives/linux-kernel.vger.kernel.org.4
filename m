Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7865360627D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 16:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiJTOJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 10:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiJTOJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 10:09:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1942E9D1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 07:09:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A6DA61BA0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 14:09:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC4CCC433D6;
        Thu, 20 Oct 2022 14:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666274984;
        bh=ie8ThKpb7OccKgb820HYRLL0NJoZTeJEmDK35eXIOi8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=n/qu2T/WnQwomlvuYf68S7jRvBjC+sisc4osFo/Plgnlqt1gqRrWSbF1Z6j/jdS2N
         f2AoNI72/3E1CdaMm65cM51819gN4AZm3eOBAzjaZdomJKRgW9YX28+3yd/b1f/teO
         IJPreX2djaCwNTgTkQaZ1witl3iom2TxRmjmBxja3W4cXtMo+9QpUhcolbdZBl/kXj
         QA2LhS3FToKe45xrGRbS7hIE2qeUjecl1Gm+5SGS1K/K7YHFstQBJf7qp6drsYTCzX
         5ivVlu3NIStfL6ZFmus8RbjgOQTZJNGuKgAX+Lex3CYwIRdeWrisrrjGiU69NWr7qK
         RS63xo0hxD7ww==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3D7355C0130; Thu, 20 Oct 2022 07:09:44 -0700 (PDT)
Date:   Thu, 20 Oct 2022 07:09:44 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     linux-kernel@vger.kernel.org, clm@meta.com, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org, longman@redhat.com
Subject: Re: [PATCH clocksource] Reject bogus watchdog clocksource
 measurements
Message-ID: <20221020140944.GK5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221019230904.GA2502730@paulmck-ThinkPad-P17-Gen-1>
 <Y1ECHVUHilqgKD9o@feng-clx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1ECHVUHilqgKD9o@feng-clx>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 04:09:01PM +0800, Feng Tang wrote:
> On Wed, Oct 19, 2022 at 04:09:04PM -0700, Paul E. McKenney wrote:
> > One remaining clocksource-skew issue involves extreme CPU overcommit,
> > which can cause the clocksource watchdog measurements to be delayed by
> > tens of seconds.  This in turn means that a clock-skew criterion that
> > is appropriate for a 500-millisecond interval will instead give lots of
> > false positives.
> 
> I remembered I saw logs that the watchdog were delayed to dozens of
> or hundreds of seconds. 
> 
> Thanks for the fix which makes sense to me! with some nits below.
> 
> > Therefore, check for the watchdog clocksource reporting much larger or
> > much less than the time specified by WATCHDOG_INTERVAL.  In these cases,
> > print a pr_warn() warning and refrain from marking the clocksource under
> > test as being unstable.
> > 
> > Reported-by: Chris Mason <clm@meta.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: John Stultz <jstultz@google.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Cc: Feng Tang <feng.tang@intel.com>
> > Cc: Waiman Long <longman@redhat.com>
> > 
> > diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> > index 8058bec87acee..dcaf38c062161 100644
> > --- a/kernel/time/clocksource.c
> > +++ b/kernel/time/clocksource.c
> > @@ -386,7 +386,7 @@ EXPORT_SYMBOL_GPL(clocksource_verify_percpu);
> >  
> >  static void clocksource_watchdog(struct timer_list *unused)
> >  {
> > -	u64 csnow, wdnow, cslast, wdlast, delta;
> > +	u64 csnow, wdnow, cslast, wdlast, delta, wdi;
> >  	int next_cpu, reset_pending;
> >  	int64_t wd_nsec, cs_nsec;
> >  	struct clocksource *cs;
> > @@ -440,6 +440,17 @@ static void clocksource_watchdog(struct timer_list *unused)
> >  		if (atomic_read(&watchdog_reset_pending))
> >  			continue;
> >  
> > +		/* Check for bogus measurements. */
> > +		wdi = jiffies_to_nsecs(WATCHDOG_INTERVAL);
> > +		if (wd_nsec < (wdi >> 2)) {
> > +			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced only %lld ns during %d-jiffy time interval, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
> > +			continue;
> > +		}
> 
> If this happens (500ms timer happens only after less than 125ms),
> there is some severe problem with timer/interrupt system. 

Should I add ", suspect timer/interrupt bug" just after "jiffy time
interval"?  Or would a comment before that pr_warn() work better for you?

> > +		if (wd_nsec > (wdi << 2)) {
> > +			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced an excessive %lld ns during %d-jiffy time interval, probable CPU overutilization, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
> > +			continue;
> > +		}
> 
> I agree with Waiman that some rate limiting may be needed. As there
> were reports of hundreds of seconds of delay, 2 seconds delay could
> easily happen if a system is too busy or misbehave to trigger this
> problem.

Good points, thank you both!

Left to myself, I would use a capped power-of-two backoff that was reset
any time that the interval was within bounds.  Maybe a cap of 10 minutes?

Or is there a better way to do this?

							Thanx, Paul

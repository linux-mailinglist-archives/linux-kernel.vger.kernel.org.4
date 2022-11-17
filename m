Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417D762E957
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 00:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbiKQXJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 18:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbiKQXJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 18:09:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002AE17883
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 15:09:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD1FC62287
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 23:09:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17991C433C1;
        Thu, 17 Nov 2022 23:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668726551;
        bh=g0zpo9exVHth25SN+KL2DhLZ19n8A0mXKbjb3bJKbr0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=f8yhfkcjJhmrs0BovDFW0U+aZ7YVzH/fkZcjSSPWXmAxlYLYIhQ3oaTOHwpXofxG2
         2BPaKbakeo5qncj8A8yJl4gwMDojPKa+z2GQFf5SqIkSHdKZW4HLkpNc/SLl8C0nFc
         Dl8gdXPec8UoLBafZbknsc+hyny7XjLMr1aXoFxbaRIdrQ8yE7EaP+xxAmvmHtNU4B
         z4v1+j+PkQbK5F4cFMAy4kJgKF7eA1sAeze57m4gW83kucLjLXor7dYuPtHtD65sOq
         UUuYMaCqqwSoa7rNSMRoKvxcWjiE5ksvUZMxTFwkSt0sZheqXce6om8uSnJ5FtLqAb
         r5MlUDzKX8BXw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A1EBC5C05C5; Thu, 17 Nov 2022 15:09:10 -0800 (PST)
Date:   Thu, 17 Nov 2022 15:09:10 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@meta.com, neeraju@codeaurora.org,
        ak@linux.intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        Chris Mason <clm@meta.com>, John Stultz <jstultz@google.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH clocksource 1/3] clocksource: Reject bogus watchdog
 clocksource measurements
Message-ID: <20221117230910.GI4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221114232807.GA834337@paulmck-ThinkPad-P17-Gen-1>
 <20221114232827.835599-1-paulmck@kernel.org>
 <87mt8pkzw1.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mt8pkzw1.ffs@tglx>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 10:57:34PM +0100, Thomas Gleixner wrote:
> Paul!
> 
> On Mon, Nov 14 2022 at 15:28, Paul E. McKenney wrote:
> >  
> > +		/* Check for bogus measurements. */
> > +		wdi = jiffies_to_nsecs(WATCHDOG_INTERVAL);
> > +		if (wd_nsec < (wdi >> 2)) {
> > +			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced only %lld ns during %d-jiffy time interval, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
> > +			continue;
> > +		}
> > +		if (wd_nsec > (wdi << 2)) {
> > +			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced an excessive %lld ns during %d-jiffy time interval, probable CPU overutilization, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
> > +			continue;
> > +		}
> 
> This is really getting ridiculous.

I have absolutely no argument with this statement, and going back a
long time.  ;-)

But the set of systems that caused me to send this turned out to have
real divergence between HPET and TSC, and 40 milliseconds per second of
divergence at that.  So not only do you hate this series, but it is also
the case that this series doesn't help with the problem at hand.

I will therefore set this series aside.

And I sure hope that it is the TSC and not HPET that is correct on those
systems, because they have constant_tsc, nonstop_tsc, and tsc_adjust
all set in their lscpu output.  :-/

And yes, I backported Feng Tang's "b50db7095fe0 ("x86/tsc: Disable
clocksource watchdog for TSC on qualified platorms") commit for them.
Worked like a charm, so thank you, Feng Tang!

But as long as I started responding, I might as well continue.  ;-)

> The clocksource watchdog is supposed to run periodically with period =
> WATCHDOG_INTERVAL.
> 
> That periodic schedule depends on the clocksource which is monitored. If
> the clocksource runs fast the period is shortened and if it runs slow is
> prolonged.
> 
> Now you add checks:
> 
>  1) If the period observed by the watchdog clocksource is less than 1/4
>     of the expected period, everything is fine.

s/less than/more than/, then agreed, give or take that a console message
is printed.  Also, the third patch adds a check of the clocksource under
check, so that if either the watchdog clocksource or the clocksource
under test says that the period observed is less than 1/4 fo the expected
period, we print the message but don't turn off the clocksource under
test.

>  2) If the period observed by the watchdog clocksource is greater than 4
>     times the expected period, everything is fine.

s/greater than/less than/, then agreed, again give or take the console
message and the subsequent check of both clocksources.

> IOW, you are preventing detection of one class of problems which caused
> us to implement the watchdog clocksource in the first place.

The problem is still memorialized via those console-log message.

> You are preventing it by making the watchdog decision circular dependent
> on the clocksource it is supposed to watch. IOW, you put a fox in charge
> of the henhouse. That's a really brilliant plan.
> 
> But what's worse is the constant stream of heuristics which make the
> clocksource watchdog "work" under workloads which are simply impossible
> to be handled by its current implementation.
> 
> If I look at the full set of them by now, I'm pretty sure that a real
> TSC fail would not be noticed anymore because there are more exceptions
> and excuses why a particular measurement it bogus or invalid or
> whatever.

It really did spot the 40ms/s divergence between HPET and TSC.

> I didn't do a full analysis yet, but I have a hard time to convince
> myself that - assumed we add this gem - the watchdog will be anything
> else than a useless waste of CPU cycles as there is always one of the
> heuristics declaring that everything is fine along with incomprehensible
> messages in dmesg which will create more confusion to most people than
> being helpful.

The messages certainly could be improved.  I freely confess to having
focused solely on eliminating false positives.

And to good effect.  The overwhelming bulk of our fleet seems to have
good timers.  The issues are concentrated in systems with dying CPUs and
in a few of the quite-new systems.  Had this happened ten years ago,
we would both be engaged in activities that are far more productive.
Or, failing that, far more fun.

> This is hunting us for 20+ years now and why do we still need this? I'm
> pretty sure that farcebook does not run their server farms on 20 years
> old silicon.

The 40ms/s divergence between TSC and HPET was observed on hardware that
is quite recent.  Again, I sure hope that it is HPET that is unreliable
rather than TSC, but either way, we have a very modern piece of hardware
with at least one very iffy clocksource.  Needless to say, this does not
build confidence.  Yes, it might be a firmware or some sort of calibration
problem, but this system is definitely well beyond the simulation and
FPGA stage.

> That means even the largest customers have not been able to convince the
> CPU manufactures to fix this idiocy by now, right? Either that or they
> did not even try because it's simpler to "fix" it in software.

Worse yet, the manufacturers that did fix it were not helped by having
reliable per-CPU clocks.  The response was of the form "Nice, but given
that it does not work on x86, we won't be relying on it."

Can't win for losing.  ;-)

> That's the only two explanations I have for the constant stream of
> voodoo logic. Both are just a proof for my claim that this industry just
> "works" by chance.

I am sure that you meant to say "just additional proof", but yes.  :-/

My concern is that the next vendor will make all the same mistakes all
over again.  It would be better for the kernel (or something equally
ubiquitous) to yell at them right away rather than for hapless users to
have to figure it out.

> Can we stop this pretty please and either come up with something
> fundamentally different or just admit defeat and remove the whole thing?

I am not at all married to the current code, but I really would like
offending system manufacturers to get their hands slapped during hardware
bringup rather than such bugs being inflicted on their unwary users.

Do you have any thoughts on what you would want a fundamentally different
approach to look like?

Yes, I do hear the "null approach" as your current preferred option.  ;-)

But having just met up with a system with seriously divergent clocks,
I am a bit shy of that approach.

							Thanx, Paul

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8175BE06C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbiITIkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbiITIkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:40:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C52786B66D;
        Tue, 20 Sep 2022 01:39:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F334EED1;
        Tue, 20 Sep 2022 01:39:19 -0700 (PDT)
Received: from e126311.manchester.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 67B3A3F73B;
        Tue, 20 Sep 2022 01:39:11 -0700 (PDT)
Date:   Tue, 20 Sep 2022 09:39:00 +0100
From:   Kajetan Puchalski <kajetan.puchalski@arm.com>
To:     Doug Smythies <dsmythies@telus.net>
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, lukasz.luba@arm.com,
        Dietmar.Eggemann@arm.com, kajetan.puchalski@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] cpuidle: teo: Introduce optional util-awareness
Message-ID: <Yyl8EdKfvSRULQnc@e126311.manchester.arm.com>
References: <20220915164411.2496380-1-kajetan.puchalski@arm.com>
 <CAAYoRsXwPmKHJ8m2aex0ddpf+=dr8ceXDSJM9kX=v5JdeRfgiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAYoRsXwPmKHJ8m2aex0ddpf+=dr8ceXDSJM9kX=v5JdeRfgiA@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, thanks for taking a look!

> > This proposed optional extension to TEO would specifically tune it for minimising too deep
> > sleeps and minimising latency to achieve better performance. To this end, before selecting the next
> > idle state it uses the avg_util signal of a CPU's runqueue in order to determine to what extent the
> > CPU is being utilized. This util value is then compared to a threshold defined as a percentage of
> > the cpu's capacity (capacity >> 6 ie. ~1.5% in the current implementation).
> 
> That seems quite a bit too low to me. However on my processor the
> energy cost of using
> idle state 0 verses anything deeper is very high, so I do not have a
> good way to test.

I suppose it does look low but as I said, at least from my own testing
higher thresholds result in completely nullifying the potential benefits
from using this. It could be because with a low-enough threshold like
this we are able to catch the average util as it starts to rise and then
we're already in the 'low-latency mode' by the time it gets higer as
opposed to correcting after the fact. We could also always make it into
some kind of tunable if need be, I was testing it with a dedicated sysctl
and it worked all right.

> 
> Processor: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz
> On an idle system :
> with only Idle state 0 enabled, processor package power is ~46 watts.
> with only idle state 1 enabled, processor package power is ~2.6 watts
> with all idle states enabled,  processor package power is ~1.4 watts
> 

Ah I see, yeah this definitely won't work on systems with idle power
usage like above. It was designed for Arm devices like the Pixel 6 where
C0 is so power efficient that running with only C0 enabled can sometimes
actually use *less* power than running with all idle states enabled.
This was for non-intensive workloads like PCMark Web Browsing where
there were enough too deep sleeps in C1 to offset the entire power
saving. The entire idea we're relying upon here is C0 being very good to
begin with but wanting to still use *some* C1 in order to avoid bumping
into thermal issues.

> > If the util is above the
> > threshold, the governor directly selects the shallowest available idle state. If the util is below
> > the threshold, the governor defaults to the TEO metrics mechanism to try to select the deepest
> > available idle state based on the closest timer event and its own past correctness.
> >
> > Effectively this functions like a governor that on the fly disables deeper idle states when there
> > are things happening on the cpu and then immediately reenables them as soon as the cpu isn't
> > being utilized anymore.
> >
> > Initially I am sending this as a patch for TEO to visualize the proposed mechanism and simplify
> > the review process. An alternative way of implementing it while not interfering
> > with existing TEO code would be to fork TEO into a separate but mostly identical for the time being
> > governor (working name 'idleutil') and then implement util-awareness there, so that the two
> > approaches can coexist and both be available at runtime instead of relying on a compile-time option.
> > I am happy to send a patchset doing that if you think it's a cleaner approach than doing it this way.
> 
> I would prefer the two to coexist for testing, as it makes it easier
> to manually compare some
> areas of focus.

That would be my preference as well, it just seems like a cleaner
approach despite having to copy over some code to begin with. I'm just
waiting for Rafael to express a view one way or the other :)

> > At the very least this approach seems promising so I wanted to discuss it in RFC form first.
> > Thank you for taking your time to read this!
> 
> There might be a way forward for my type of processor if the algorithm
> were to just reduce the idle
> depth by 1 instead of all the way to idle state 0. Not sure. It seems
> to bypass all that the teo
> governor is attempting to achieve.

Oh interesting, that could definitely be worth a try. As I said, this
was designed for Arm CPUs and all of the targeted ones only have 2 idle
states, C0 and C1. Thus reducing by 1 and going all the way to 0 are the
same thing for our use case. You're right that this is potentially
pretty excessive on Intel CPUs where you could be going from state 8/9 to
0. It would result in some wasted cycles on Arm but I imagine there should
be some way forward where we could accommodate the two.

> For a single periodic workflow at any work sleep frequency (well, I
> test 5 hertz to 411 hertz) and very
> light workload: Processor package powers for 73 hertz work/sleep frequency:
> 
> teo: ~1.5 watts
> menu: ~1.5 watts
> util: ~19 watts
> 
> For 12 periodic workflow threads at 73 hertz work/sleep frequency
> (well, I test 5 hertz to 411 hertz) and very
> workload: Processor package powers:
> 
> teo: ~2.8watts
> menu: ~2.8 watts
> util: ~49 watts
> 
> My test computer is a server, with no gui. I started a desktop linux
> VM guest that isn't doing much:
> 
> teo: ~1.8 watts
> menu: ~1.8 watts
> util: ~7.8 watts

Ouch that's definitely not great, really good to know what this looks
like on Intel CPUs though. Thanks a lot for taking your time to test
this out!

> >
> > --
> > Kajetan
> >
> > [1] https://github.com/mrkajetanp/lisa-notebooks/blob/a2361a5b647629bfbfc676b942c8e6498fb9bd03/idle_util_aware.pdf
> >
> >
> > Kajetan Puchalski (1):
> >   cpuidle: teo: Introduce optional util-awareness
> >
> >  drivers/cpuidle/Kconfig         | 12 +++++
> >  drivers/cpuidle/governors/teo.c | 86 +++++++++++++++++++++++++++++++++
> >  2 files changed, 98 insertions(+)
> >
> > --
> > 2.37.1
> >

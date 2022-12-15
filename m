Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E356364D320
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 00:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiLNXQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 18:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiLNXQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 18:16:00 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B5722CE00;
        Wed, 14 Dec 2022 15:15:59 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73176FEC;
        Wed, 14 Dec 2022 15:16:39 -0800 (PST)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.1.196.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 70D7B3F5A1;
        Wed, 14 Dec 2022 15:15:58 -0800 (PST)
Date:   Wed, 14 Dec 2022 23:15:56 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [PATCH v2 02/22] sched: Add interfaces for IPC classes
Message-ID: <Y5pZGu0NnXsOyfUv@arm.com>
References: <20221128132100.30253-1-ricardo.neri-calderon@linux.intel.com>
 <20221128132100.30253-3-ricardo.neri-calderon@linux.intel.com>
 <Y5Gf9wGB5nFa4EDv@arm.com>
 <20221214003128.GA30234@ranerica-svr.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214003128.GA30234@ranerica-svr.sc.intel.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday 13 Dec 2022 at 16:31:28 (-0800), Ricardo Neri wrote:
> On Thu, Dec 08, 2022 at 08:48:46AM +0000, Ionela Voinescu wrote:
> > Hi,
> > 
> > On Monday 28 Nov 2022 at 05:20:40 (-0800), Ricardo Neri wrote:
> > [..]
> > > +#ifndef arch_has_ipc_classes
> > > +/**
> > > + * arch_has_ipc_classes() - Check whether hardware supports IPC classes of tasks
> > > + *
> > > + * Returns: true of IPC classes of tasks are supported.
> > > + */
> > > +static __always_inline
> > > +bool arch_has_ipc_classes(void)
> > > +{
> > > +	return false;
> > > +}
> > > +#endif
> > > +
> > > +#ifndef arch_update_ipcc
> > > +/**
> > > + * arch_update_ipcc() - Update the IPC class of the current task
> > > + * @curr:		The current task
> > > + *
> > > + * Request that the IPC classification of @curr is updated.
> > > + *
> > > + * Returns: none
> > > + */
> > > +static __always_inline
> > > +void arch_update_ipcc(struct task_struct *curr)
> > > +{
> > > +}
> > > +#endif
> > > +
> > > +#ifndef arch_get_ipcc_score
> > > +/**
> > > + * arch_get_ipcc_score() - Get the IPC score of a class of task
> > > + * @ipcc:	The IPC class
> > > + * @cpu:	A CPU number
> > > + *
> > > + * Returns the performance score of an IPC class when running on @cpu.
> > > + * Error when either @class or @cpu are invalid.
> > > + */
> > > +static __always_inline
> > > +int arch_get_ipcc_score(unsigned short ipcc, int cpu)
> > > +{
> > > +	return 1;
> > > +}
> > > +#endif
> 
> Thank you very much for your feedback Ionela!
> 
> > 
> > The interface looks mostly alright but this arch_get_ipcc_score() leaves
> > unclear what are the characteristics of the returned value.
> 
> Fair point. I mean for the return value to be defined by architectures;
> but yes, architectures need to know how to implement this function.
> 
> > 
> > Does it have a meaning as an absolute value or is it a value on an
> > abstract scale? If it should be interpreted as instructions per cycle,
> > if I wanted to have a proper comparison between the ability of two CPUs
> > to handle this class of tasks then I would need to take into consideration
> > the maximum frequency of each CPU.
> 
> Do you mean when calling arch_get_ipcc_score()? If yes, then I agree, IPC
> class may not be the only factor, but the criteria to use the return value
> is up to the caller.
> 

Yes, but if different architectures give different meanings to this score
(scale, relative difference between two values, etc) while the policies
are common (uses of arch_get_ipcc_score() in common scheduler paths)
then the outcome can be vastly different.

If the "criteria to use the returned value is up to the caller", then
the caller of arch_get_ipcc_score() should always be architecture
specific code, which currently is not (see 09/22).

> In asym_packing it is assumed that higher-priority CPUs are preferred.
> When balancing load, IPC class scores are used to select between otherwise
> identical runqueues. This should also be the case for migrate_misfit: we
> know already that the tasks being considered do not fit on their current
> CPU.
> 
> We would need to think what to do with other type of balancing, if at all.
> 
> That said, arch_get_ipcc_score() should only return a metric of the
> instructions-per-*cycle*, independent of frequency, no?
> 

Yes, performance on an abstract scale is preferred here. We would not
want to have to scale the score by frequency :). It was just an example
showing that the description of arch_get_ipcc_score() should be clarified.
Another possible clarification: is it expected that the scores scale
linearly with performance (does double the score mean double the
performance?).

> > If it's a performance value on an
> > abstract scale (more likely), similar cu capacity, then it might be good
> > to better define this abstract scale. That would help with the default
> > implementation where possibly the best choice for a return value would
> > be the maximum value on the scale, suggesting equal/maximum performance
> > for different CPUs handling the class of tasks.
> 
> I guess something like:
> 
> #define SCHED_IPCC_DEFAULT_SCALE 1024
> 
> ?
> 
> I think I am fine with this value being the default. I also think that it
> is up to architectures to whether scale all IPC class scores from the
> best-performing class on the best-performing CPU. Doing so would introduce
> overhead, especially if hardware updates the IPC class scores multiple
> times during runtime.
>

Yes, it's a very good point. Initially I thought that one would need to
rescale the values anyway for them to make sense relative to each other,
but I now realise that would not be needed.

Therefore, you are right, to avoid this extra work it's best to leave
the range of possible score values up to the implementer and not force
something like [0 - 1024].

But again, this raises the point that if one architecture decides to
return its scores on a scale [0 - 1024] and possibly use these scores to
scale utilization/alter capacity for example, this cannot be generic
policy as not all architectures are guaranteed to use this scale for its
scores.

So leaving the score unrestricted makes it more difficult to have
generic policies across architectures that use them.

> > 
> > I suppose you avoided returning 0 for the default implementation as you
> > intend that to mean the inability of the CPU to handle that class of
> > tasks? It would be good to document this.
> 
> I meant this to be minimum possible IPC class score for any CPU: any
> CPU should be able handle any IPC class. If not implemented, all CPUs
> handle all IPC classes equally.
> 

Ah, I see. In this case you might as well return 0 in the default
implementation of arch_get_ipcc_score(). I know it does not matter much
what gets returned there, but returning a meaningless "1" is strange to
me :).

Thanks,
Ionela.

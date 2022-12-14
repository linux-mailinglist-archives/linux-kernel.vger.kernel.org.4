Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBEED64C124
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 01:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiLNA0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 19:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237373AbiLNA0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 19:26:00 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4CAE00F;
        Tue, 13 Dec 2022 16:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670977558; x=1702513558;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y/CWTf/tiZ/87YkVzxQVW+7eJHln4ot7xL8BjDoqv28=;
  b=krpHZXFCeL+b/pZvcv6AROwf/fBSmk9G7gXgnaISwCRA1j6wT/rB1oNL
   d9wLv13c2IW0h3RL2ZhR4JB8mYnH3aa8jRe37M+EpjrdgGHxVFIoRzrOd
   xRFcJ2xw9VccDFbInToN2tBdM1Ynn6tawuYn0Mc+0c9eijp4Zn7gz7nDs
   uakpXN9IrsaQnWC1CUuCZrCPrrJ/jrj6Ox2zZD2BqHIN45Fs1k+TLJSEq
   nM3M8sUc99AUsNkmFKudPoWUNdS2BLse2t3nw+32DrMyRozsbPytk2JzK
   OFAO1DJbuWNfPH+CPqA/ZIGGcH3I6EYmOCLoUw0iUXRBe/xbjEkxZA2q9
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="297957329"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="297957329"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 16:25:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="894089798"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="894089798"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga006.fm.intel.com with ESMTP; 13 Dec 2022 16:23:17 -0800
Date:   Tue, 13 Dec 2022 16:31:28 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
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
Message-ID: <20221214003128.GA30234@ranerica-svr.sc.intel.com>
References: <20221128132100.30253-1-ricardo.neri-calderon@linux.intel.com>
 <20221128132100.30253-3-ricardo.neri-calderon@linux.intel.com>
 <Y5Gf9wGB5nFa4EDv@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5Gf9wGB5nFa4EDv@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 08:48:46AM +0000, Ionela Voinescu wrote:
> Hi,
> 
> On Monday 28 Nov 2022 at 05:20:40 (-0800), Ricardo Neri wrote:
> [..]
> > +#ifndef arch_has_ipc_classes
> > +/**
> > + * arch_has_ipc_classes() - Check whether hardware supports IPC classes of tasks
> > + *
> > + * Returns: true of IPC classes of tasks are supported.
> > + */
> > +static __always_inline
> > +bool arch_has_ipc_classes(void)
> > +{
> > +	return false;
> > +}
> > +#endif
> > +
> > +#ifndef arch_update_ipcc
> > +/**
> > + * arch_update_ipcc() - Update the IPC class of the current task
> > + * @curr:		The current task
> > + *
> > + * Request that the IPC classification of @curr is updated.
> > + *
> > + * Returns: none
> > + */
> > +static __always_inline
> > +void arch_update_ipcc(struct task_struct *curr)
> > +{
> > +}
> > +#endif
> > +
> > +#ifndef arch_get_ipcc_score
> > +/**
> > + * arch_get_ipcc_score() - Get the IPC score of a class of task
> > + * @ipcc:	The IPC class
> > + * @cpu:	A CPU number
> > + *
> > + * Returns the performance score of an IPC class when running on @cpu.
> > + * Error when either @class or @cpu are invalid.
> > + */
> > +static __always_inline
> > +int arch_get_ipcc_score(unsigned short ipcc, int cpu)
> > +{
> > +	return 1;
> > +}
> > +#endif

Thank you very much for your feedback Ionela!

> 
> The interface looks mostly alright but this arch_get_ipcc_score() leaves
> unclear what are the characteristics of the returned value.

Fair point. I mean for the return value to be defined by architectures;
but yes, architectures need to know how to implement this function.

> 
> Does it have a meaning as an absolute value or is it a value on an
> abstract scale? If it should be interpreted as instructions per cycle,
> if I wanted to have a proper comparison between the ability of two CPUs
> to handle this class of tasks then I would need to take into consideration
> the maximum frequency of each CPU.

Do you mean when calling arch_get_ipcc_score()? If yes, then I agree, IPC
class may not be the only factor, but the criteria to use the return value
is up to the caller.

In asym_packing it is assumed that higher-priority CPUs are preferred.
When balancing load, IPC class scores are used to select between otherwise
identical runqueues. This should also be the case for migrate_misfit: we
know already that the tasks being considered do not fit on their current
CPU.

We would need to think what to do with other type of balancing, if at all.

That said, arch_get_ipcc_score() should only return a metric of the
instructions-per-*cycle*, independent of frequency, no?

> If it's a performance value on an
> abstract scale (more likely), similar cu capacity, then it might be good
> to better define this abstract scale. That would help with the default
> implementation where possibly the best choice for a return value would
> be the maximum value on the scale, suggesting equal/maximum performance
> for different CPUs handling the class of tasks.

I guess something like:

#define SCHED_IPCC_DEFAULT_SCALE 1024

?

I think I am fine with this value being the default. I also think that it
is up to architectures to whether scale all IPC class scores from the
best-performing class on the best-performing CPU. Doing so would introduce
overhead, especially if hardware updates the IPC class scores multiple
times during runtime.

> 
> I suppose you avoided returning 0 for the default implementation as you
> intend that to mean the inability of the CPU to handle that class of
> tasks? It would be good to document this.

I meant this to be minimum possible IPC class score for any CPU: any
CPU should be able handle any IPC class. If not implemented, all CPUs
handle all IPC classes equally.

> 
> > +#else /* CONFIG_IPC_CLASSES */
> > +
> > +#define arch_get_ipcc_score(ipcc, cpu) (-EINVAL)
> > +#define arch_update_ipcc(curr)
> > +
> > +static inline bool sched_ipcc_enabled(void) { return false; }
> > +
> > +#endif /* CONFIG_IPC_CLASSES */
> > +
> >  #ifndef arch_scale_freq_capacity
> >  /**
> >   * arch_scale_freq_capacity - get the frequency scale factor of a given CPU.
> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > index 8154ef590b9f..eb1654b64df7 100644
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
> > @@ -669,6 +669,9 @@ DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
> >  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
> >  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
> >  DEFINE_STATIC_KEY_FALSE(sched_asym_cpucapacity);
> > +#ifdef CONFIG_IPC_CLASSES
> > +DEFINE_STATIC_KEY_FALSE(sched_ipcc);
> > +#endif
> >  
> >  static void update_top_cache_domain(int cpu)
> >  {
> > @@ -2388,6 +2391,11 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
> >  	if (has_asym)
> >  		static_branch_inc_cpuslocked(&sched_asym_cpucapacity);
> >  
> > +#ifdef CONFIG_IPC_CLASSES
> > +	if (arch_has_ipc_classes())
> > +		static_branch_enable_cpuslocked(&sched_ipcc);
> > +#endif
> 
> Wouldn't this be better placed directly in sched_init_smp()?
> It's not gated by and it does not need any sched domains information.

Very true. I will take your suggestion.

> 
> Hope it helps,

It does help significantly. Thanks again for your feedback.

Thanks and BR,
Ricardo

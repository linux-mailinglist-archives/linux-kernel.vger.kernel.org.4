Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBC264F377
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 22:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiLPVsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 16:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiLPVsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 16:48:03 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72BAE92;
        Fri, 16 Dec 2022 13:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671227281; x=1702763281;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ksNfalkQyDabn07PqqHgYcoufSAawYeGA5A7ZSrxgho=;
  b=HxCbEzjKVfSaQlz/f4batEHPfOGctkFev27k3L1Nb4peCUrxcnoUyN+6
   ufdMZZP2++MAIFaKUEIo9CB65B879E9Atm8I5GoUGSE1vDcW5GA8zRN4n
   /+8ky/swRg6P9i1t04ClcQ6m//xYRxS8zPfdF6+cm+wYHTsfrbECROfq4
   FKGcRlBhunRSVniTDhSnoDt9DGpsTKR/V0hqXGMY1YLjpmd1Uf1HA1BxS
   razUCqYhF8L5k6nLRLIMIBRzZtiylhHgP2hXV0MKuGeWOv66jNiAiffy7
   WRuWmFdzvGd/wPtqhCH99qZx6y3Ju9qV9aPSO/nJeAF+Q93KFSGjH/Gde
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="317755503"
X-IronPort-AV: E=Sophos;i="5.96,251,1665471600"; 
   d="scan'208";a="317755503"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 13:48:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="718509508"
X-IronPort-AV: E=Sophos;i="5.96,251,1665471600"; 
   d="scan'208";a="718509508"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga004.fm.intel.com with ESMTP; 16 Dec 2022 13:48:01 -0800
Date:   Fri, 16 Dec 2022 13:56:19 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Tim C . Chen" <tim.c.chen@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [PATCH v2 02/22] sched: Add interfaces for IPC classes
Message-ID: <20221216215619.GA23285@ranerica-svr.sc.intel.com>
References: <20221128132100.30253-1-ricardo.neri-calderon@linux.intel.com>
 <20221128132100.30253-3-ricardo.neri-calderon@linux.intel.com>
 <b343821d-78b8-0c46-bf03-bfd645d99a2e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b343821d-78b8-0c46-bf03-bfd645d99a2e@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 07:36:44AM +0000, Lukasz Luba wrote:
> Hi Richardo,
> 
> I have some generic comment for the design of those interfaces.
> 
> On 11/28/22 13:20, Ricardo Neri wrote:
> > Add the interfaces that architectures shall implement to convey the data
> > to support IPC classes.
> > 
> > arch_update_ipcc() updates the IPC classification of the current task as
> > given by hardware.
> > 
> > arch_get_ipcc_score() provides a performance score for a given IPC class
> > when placed on a specific CPU. Higher scores indicate higher performance.
> > 
> > The number of classes and the score of each class of task are determined
> > by hardware.
> > 
> > Cc: Ben Segall <bsegall@google.com>
> > Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: Mel Gorman <mgorman@suse.de>
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Tim C. Chen <tim.c.chen@intel.com>
> > Cc: Valentin Schneider <vschneid@redhat.com>
> > Cc: x86@kernel.org
> > Cc: linux-pm@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > ---
> > Changes since v1:
> >   * Shortened the names of the IPCC interfaces (PeterZ):
> >     sched_task_classes_enabled >> sched_ipcc_enabled
> >     arch_has_task_classes >> arch_has_ipc_classes
> >     arch_update_task_class >> arch_update_ipcc
> >     arch_get_task_class_score >> arch_get_ipcc_score
> >   * Removed smt_siblings_idle argument from arch_update_ipcc(). (PeterZ)
> > ---
> >   kernel/sched/sched.h    | 60 +++++++++++++++++++++++++++++++++++++++++
> >   kernel/sched/topology.c |  8 ++++++
> >   2 files changed, 68 insertions(+)
> > 
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index b1d338a740e5..75e22baa2622 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -2531,6 +2531,66 @@ void arch_scale_freq_tick(void)
> >   }
> >   #endif
> > +#ifdef CONFIG_IPC_CLASSES
> > +DECLARE_STATIC_KEY_FALSE(sched_ipcc);
> > +
> > +static inline bool sched_ipcc_enabled(void)
> > +{
> > +	return static_branch_unlikely(&sched_ipcc);
> > +}
> > +
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
> 
> Those interfaces are quite simple, probably work really OK with
> your HW/FW. If any other architecture is going to re-use them
> in future, we might face some issue. Let me explain why.
> 
> These kernel functions are start to be used very early in boot.
> Your HW/FW is probably instantly ready to work from the very
> beginning during boot. What is some other HW needs some
> preparation code, like setup communication channel to FW or enable
> needed clocks/events/etc.
> 
> What I would like to see is a similar mechanism to the one in schedutil.
> Schedutil governor has to wait till cpufreq initialize the cpu freq
> driver and policy objects (which sometimes takes ~2-3 sec). After that
> cpufreq fwk starts the governor which populates this hook [1].
> It's based on RCU mechanism with function pointer that can be then
> called from the task scheduler when everything is ready to work.
> 
> If we (Arm) is going to use your proposed interfaces, we might need
> different mechanisms because the platform likely would be ready after
> our SCMI FW channels and cpufreq are setup.
> 
> Would it be possible to address such need now or I would have to
> change that interface code later?

Thank you very much for your feeback, Lukas!

I took a look a cpufreq implementation you refer. I can certainly try to
accommodate your requirements. Before jumping into it, I have a few
questions.

I see that cpufreq_update_util() only does something when the per-CPU
pointers cpufreq_update_util_data become non-NULL. I use static key for the
same purpose. Is this not usable for you?

Indeed, arch_has_ipc_classes() implies that has to return true very early
after boot if called, as per Ionela's suggestion from sched_init_smp(). I
can convert this interface to an arch_enable_ipc_classes() that drivers or
preparation code can call when ready. Would this be acceptable?

Do think that a hook per CPU would be needed? If unsure, perhaps this can
be left for future work.

Thanks and BR,
Ricardo
>
> [1]
> https://elixir.bootlin.com/linux/latest/source/kernel/sched/cpufreq.c#L29
> 

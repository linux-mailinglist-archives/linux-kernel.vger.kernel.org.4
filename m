Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7FD6950C9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjBMThx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjBMThu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:37:50 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CBD2722
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676317069; x=1707853069;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4yuMrxSozOviRS8funTjR25MXp+HMcPbifIVi7/PCyI=;
  b=ibeme3fS4jK8lIrVMnFG4i2pLfjbpUJR0+Hh8wxZabLvmifI8qtRcYyQ
   KeX9Wp4cH+LiUk53+ZxO3FuF/dnCnLI/7DXDjsWSA9fr0c/TDtbFAMLaP
   oSf47mlcaC5csuHXxhxJpR6G98xsTg44fFvCHZ1dFjTsgTfHlXRdXe8Dv
   oGDXYXmw2fQvBGdfmWrGyxETGQSnfcGXlveEiKMDkXsrl8jDCzWxX0ArK
   pSBue0IaOkRfOMxfPcR8QxBknKaR0yGf3vBMLct/uWKj7JZ8bYSaPY74X
   wMTmk/9oRNU5CfJYrYtmVajw/8C61yKvQQMJWtmS4AEbSTdKtYe2XnW53
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="319005700"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="319005700"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 11:37:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="732608348"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="732608348"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga008.fm.intel.com with ESMTP; 13 Feb 2023 11:37:48 -0800
Date:   Mon, 13 Feb 2023 11:47:40 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [PATCH v3 07/10] sched/fair: Do not even the number of busy CPUs
 via asym_packing
Message-ID: <20230213194740.GA6164@ranerica-svr.sc.intel.com>
References: <20230207045838.11243-1-ricardo.neri-calderon@linux.intel.com>
 <20230207045838.11243-8-ricardo.neri-calderon@linux.intel.com>
 <f8a75f47-0f7e-14cc-adf4-2854e235b26e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8a75f47-0f7e-14cc-adf4-2854e235b26e@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 01:44:20PM +0100, Dietmar Eggemann wrote:
> On 07/02/2023 05:58, Ricardo Neri wrote:
> 
> [...]
> 
> > @@ -9269,33 +9264,11 @@ static bool asym_smt_can_pull_tasks(int dst_cpu, struct sd_lb_stats *sds,
> >  				    struct sched_group *sg)
> >  {
> >  #ifdef CONFIG_SCHED_SMT
> > -	bool local_is_smt;
> >  	int sg_busy_cpus;
> >  
> > -	local_is_smt = sds->local->flags & SD_SHARE_CPUCAPACITY;
> >  	sg_busy_cpus = sgs->group_weight - sgs->idle_cpus;
> >  
> > -	if (!local_is_smt) {
> > -		/*
> > -		 * If we are here, @dst_cpu is idle and does not have SMT
> > -		 * siblings. Pull tasks if candidate group has two or more
> > -		 * busy CPUs.
> > -		 */
> > -		if (sg_busy_cpus >= 2) /* implies sg_is_smt */
> > -			return true;
> > -
> > -		/*
> > -		 * @dst_cpu does not have SMT siblings. @sg may have SMT
> > -		 * siblings and only one is busy. In such case, @dst_cpu
> > -		 * can help if it has higher priority and is idle (i.e.,
> > -		 * it has no running tasks).
> > -		 */
> > -		return sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu);
> > -	}
> > -
> >  	/*
> > -	 * @dst_cpu has SMT siblings and are also idle.
> > -	 *
> >  	 * If the difference in the number of busy CPUs is two or more, let
> >  	 * find_busiest_group() take care of it. We only care if @sg has
> >  	 * exactly one busy CPU. This covers SMT and non-SMT sched groups.
> 
> Can't this be made lighter by removing asym_smt_can_pull_tasks() and
> putting the logic to exclude the call to sched_asym_prefer() into
> sched_asym() directly?

Yes, you are right. asym_smt_can_pull_tasks() was simplified significantly.
I'll take your suggestion.

> Not sure if we need the CONFIG_SCHED_SMT since it's all guarded by
> `flags & SD_SHARE_CPUCAPACITY` already, which is only set under.
> CONFIG_SCHED_SMT.

Yes, asym_smt_can_pull_tasks() now cares for a very specific case, which
only happens with CONFIG_SCHED_SMT. I'll remove the !CONFIG_SCHED_SMT part.
> 
> static inline bool
> sched_asym(struct lb_env *env, struct sd_lb_stats *sds,
>            struct sg_lb_stats *sgs, struct sched_group *group)
> {
>         bool local_is_smt = sds->local->flags & SD_SHARE_CPUCAPACITY;
> 
>         if (local_is_smt && !is_core_idle(env->dst_cpu))
>                 return false;
> 
>         if ((local_is_smt || group->flags & SD_SHARE_CPUCAPACITY)) {
>                 int sg_busy_cpus = sgs->group_weight - sgs->idle_cpus;
> 
>                 if (sg_busy_cpus != 1)
>                         return false;
>         }
> 
>         return sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu);

I'll take your suggestion. Thanks!

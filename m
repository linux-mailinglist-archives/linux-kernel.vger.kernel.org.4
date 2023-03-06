Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55AEF6AC06F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 14:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjCFNKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 08:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjCFNKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 08:10:51 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3103D2C650
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 05:10:39 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C90EE12FC;
        Mon,  6 Mar 2023 05:11:22 -0800 (PST)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.1.196.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0DE5A3F885;
        Mon,  6 Mar 2023 05:10:38 -0800 (PST)
Date:   Mon, 6 Mar 2023 13:10:37 +0000
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
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [PATCH v3 08/10] sched/topology: Remove SHARED_CHILD from
 ASYM_PACKING
Message-ID: <ZAXmTT0bG4qf+HKN@arm.com>
References: <20230207045838.11243-1-ricardo.neri-calderon@linux.intel.com>
 <20230207045838.11243-9-ricardo.neri-calderon@linux.intel.com>
 <ZAHaMKH7C0sVIjXX@arm.com>
 <20230305190811.GA4352@ranerica-svr.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230305190811.GA4352@ranerica-svr.sc.intel.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

On Sunday 05 Mar 2023 at 11:08:11 (-0800), Ricardo Neri wrote:
> On Fri, Mar 03, 2023 at 11:29:52AM +0000, Ionela Voinescu wrote:
> > Hi Ricardo,
> 
> Hi Ionela!
> 
> > 
> > On Monday 06 Feb 2023 at 20:58:36 (-0800), Ricardo Neri wrote:
> > > Only x86 and Power7 use ASYM_PACKING. They use it differently.
> > > 
> > > Power7 has cores of equal priority, but the SMT siblings of a core have
> > > different priorities. Parent scheduling domains do not need (nor have) the
> > > ASYM_PACKING flag. SHARED_CHILD is not needed. Using SHARED_PARENT would
> > > cause the topology debug code to complain.
> > > 
> > > X86 has cores of different priority, but all the SMT siblings of the core
> > > have equal priority. It needs ASYM_PACKING at the MC level, but not at the
> > > SMT level (it also needs it at upper levels if they have scheduling groups
> > > of different priority). Removing ASYM_PACKING from the SMT domain causes
> > > the topology debug code to complain.
> > > 
> > > Remove SHARED_CHILD for now. We still need a topology check that satisfies
> > > both architectures.
> > > 
> > > Cc: Ben Segall <bsegall@google.com>
> > > Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> > > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > > Cc: Len Brown <len.brown@intel.com>
> > > Cc: Mel Gorman <mgorman@suse.de>
> > > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > Cc: Tim C. Chen <tim.c.chen@intel.com>
> > > Cc: Valentin Schneider <vschneid@redhat.com>
> > > Cc: x86@kernel.org
> > > Cc: linux-kernel@vger.kernel.org
> > > Suggested-by: Valentin Schneider <vschneid@redhat.com>
> > > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > > ---
> > > Changes since v2:
> > >  * Introduced this patch.
> > > 
> > > Changes since v1:
> > >  * N/A
> > > ---
> > >  include/linux/sched/sd_flags.h | 5 +----
> > >  1 file changed, 1 insertion(+), 4 deletions(-)
> > > 
> > > diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
> > > index 57bde66d95f7..800238854ba5 100644
> > > --- a/include/linux/sched/sd_flags.h
> > > +++ b/include/linux/sched/sd_flags.h
> > > @@ -132,12 +132,9 @@ SD_FLAG(SD_SERIALIZE, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
> > >  /*
> > >   * Place busy tasks earlier in the domain
> > >   *
> > > - * SHARED_CHILD: Usually set on the SMT level. Technically could be set further
> > > - *               up, but currently assumed to be set from the base domain
> > > - *               upwards (see update_top_cache_domain()).
> > >   * NEEDS_GROUPS: Load balancing flag.
> > >   */
> > > -SD_FLAG(SD_ASYM_PACKING, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
> > > +SD_FLAG(SD_ASYM_PACKING,  SDF_NEEDS_GROUPS)
> > 
> > While this silences the warning one would have gotten when removing
> > SD_ASYM_PACKING from SMT level, it will still result in sd_asym_packing
> > being NULL for these systems, which breaks nohz balance. That is because
> > highest_flag_domain() still stops searching at the first level without
> > the flag set, in this case SMT, even if levels above have the flag set.
> 
> You are absolutely right! This how this whole discussion started. It
> slipped my mind.
> 
> > 
> > Maybe highest_flag_domain() should be changed to take into account the
> > metadata flags?
> 
> What about the patch below? Search will stop if the flag has
> SDF_SHARED_CHILD as it does today. Otherwise it will search all the
> domains.
> 
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1773,6 +1773,12 @@ queue_balance_callback(struct rq *rq,
>  	for (__sd = rcu_dereference_check_sched_domain(cpu_rq(cpu)->sd); \
>  			__sd; __sd = __sd->parent)
>  
> +#define SD_FLAG(name, mflags) (name * !!((mflags) & SDF_SHARED_CHILD)) |
> +static const unsigned int SD_SHARED_CHILD_MASK =
> +#include <linux/sched/sd_flags.h>
> +0;
> +#undef SD_FLAG
> +
>  /**
>   * highest_flag_domain - Return highest sched_domain containing flag.
>   * @cpu:	The CPU whose highest level of sched domain is to
> @@ -1781,15 +1787,19 @@ queue_balance_callback(struct rq *rq,
>   *		for the given CPU.
>   *
>   * Returns the highest sched_domain of a CPU which contains the given flag.
> - */
> +*/
  ^^^
  likely an unintended change
>  static inline struct sched_domain *highest_flag_domain(int cpu, int flag)
>  {
>  	struct sched_domain *sd, *hsd = NULL;
>  
>  	for_each_domain(cpu, sd) {
> -		if (!(sd->flags & flag))
> +		if (sd->flags & flag) {
> +			hsd = sd;
> +			continue;
> +		}
> +

There might be room for a comment here:
                /*
		 * If the flag is not set and is known to be shared with lower
		 * domains, stop the search, as it won't be found further up.
		 */
> +		if (flag & SD_SHARED_CHILD_MASK)
>  			break;
> -		hsd = sd;
>  	}
>  
>  	return hsd;

It looks nice and sane to me - I've not compiled or tested it :).

Thanks,
Ionela.

> 
> > 
> > Thanks,
> > Ionela.
> > 
> > >  
> > >  /*
> > >   * Prefer to place tasks in a sibling domain
> > > -- 
> > > 2.25.1
> > > 
> > > 

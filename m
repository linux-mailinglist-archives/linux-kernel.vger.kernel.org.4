Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6056E6ACC04
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 19:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjCFSIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 13:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbjCFSIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 13:08:32 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FBD4EE7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 10:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678126078; x=1709662078;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lqKN6PeUXaaQFo9qkkt8utGGixrotBUL+bwOQcjrpIk=;
  b=kDIinGcqtySa7bF7MGJSbcGjwdhmPxW5LJCO/frpawyInZh4tiQFQ0sm
   m2sQ6AcwBZ+I2GvAzEh4sJQ5Z7/YAH+zkZKP4B3Uedqt8cihEdovzFJIR
   XWm6w1ZPu0ZJMdo1lCTea45OOwMkJIKN9lKp22d5ni1+8iepcoVDzYNWE
   TcIkI0YId0nDtNdN2yI7d8XqhUJ8PBNodPssxcEovqHIsOr4A9Ujh8em+
   tVgwRKlmU3pODNUBd0/Kkzjxpp3wheLRlifbVvjFIxQd2lJ4oRd4PQ/wy
   y46srq/p9VKkkDUbBYdPxo7BICrx/fN2bEdNveZXdikbA9kLQdaqPICiM
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="398215126"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="398215126"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 10:07:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="745163433"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="745163433"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga004.fm.intel.com with ESMTP; 06 Mar 2023 10:07:21 -0800
Date:   Mon, 6 Mar 2023 10:17:23 -0800
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
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [PATCH v3 08/10] sched/topology: Remove SHARED_CHILD from
 ASYM_PACKING
Message-ID: <20230306181723.GA3153@ranerica-svr.sc.intel.com>
References: <20230207045838.11243-1-ricardo.neri-calderon@linux.intel.com>
 <20230207045838.11243-9-ricardo.neri-calderon@linux.intel.com>
 <ZAHaMKH7C0sVIjXX@arm.com>
 <20230305190811.GA4352@ranerica-svr.sc.intel.com>
 <ZAXmTT0bG4qf+HKN@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAXmTT0bG4qf+HKN@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 01:10:37PM +0000, Ionela Voinescu wrote:
> Hey,
> 
> On Sunday 05 Mar 2023 at 11:08:11 (-0800), Ricardo Neri wrote:
> > On Fri, Mar 03, 2023 at 11:29:52AM +0000, Ionela Voinescu wrote:
> > > Hi Ricardo,
> > 
> > Hi Ionela!
> > 
> > > 
> > > On Monday 06 Feb 2023 at 20:58:36 (-0800), Ricardo Neri wrote:
> > > > Only x86 and Power7 use ASYM_PACKING. They use it differently.
> > > > 
> > > > Power7 has cores of equal priority, but the SMT siblings of a core have
> > > > different priorities. Parent scheduling domains do not need (nor have) the
> > > > ASYM_PACKING flag. SHARED_CHILD is not needed. Using SHARED_PARENT would
> > > > cause the topology debug code to complain.
> > > > 
> > > > X86 has cores of different priority, but all the SMT siblings of the core
> > > > have equal priority. It needs ASYM_PACKING at the MC level, but not at the
> > > > SMT level (it also needs it at upper levels if they have scheduling groups
> > > > of different priority). Removing ASYM_PACKING from the SMT domain causes
> > > > the topology debug code to complain.
> > > > 
> > > > Remove SHARED_CHILD for now. We still need a topology check that satisfies
> > > > both architectures.
> > > > 
> > > > Cc: Ben Segall <bsegall@google.com>
> > > > Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> > > > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > > > Cc: Len Brown <len.brown@intel.com>
> > > > Cc: Mel Gorman <mgorman@suse.de>
> > > > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > > Cc: Tim C. Chen <tim.c.chen@intel.com>
> > > > Cc: Valentin Schneider <vschneid@redhat.com>
> > > > Cc: x86@kernel.org
> > > > Cc: linux-kernel@vger.kernel.org
> > > > Suggested-by: Valentin Schneider <vschneid@redhat.com>
> > > > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > > > ---
> > > > Changes since v2:
> > > >  * Introduced this patch.
> > > > 
> > > > Changes since v1:
> > > >  * N/A
> > > > ---
> > > >  include/linux/sched/sd_flags.h | 5 +----
> > > >  1 file changed, 1 insertion(+), 4 deletions(-)
> > > > 
> > > > diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
> > > > index 57bde66d95f7..800238854ba5 100644
> > > > --- a/include/linux/sched/sd_flags.h
> > > > +++ b/include/linux/sched/sd_flags.h
> > > > @@ -132,12 +132,9 @@ SD_FLAG(SD_SERIALIZE, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
> > > >  /*
> > > >   * Place busy tasks earlier in the domain
> > > >   *
> > > > - * SHARED_CHILD: Usually set on the SMT level. Technically could be set further
> > > > - *               up, but currently assumed to be set from the base domain
> > > > - *               upwards (see update_top_cache_domain()).
> > > >   * NEEDS_GROUPS: Load balancing flag.
> > > >   */
> > > > -SD_FLAG(SD_ASYM_PACKING, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
> > > > +SD_FLAG(SD_ASYM_PACKING,  SDF_NEEDS_GROUPS)
> > > 
> > > While this silences the warning one would have gotten when removing
> > > SD_ASYM_PACKING from SMT level, it will still result in sd_asym_packing
> > > being NULL for these systems, which breaks nohz balance. That is because
> > > highest_flag_domain() still stops searching at the first level without
> > > the flag set, in this case SMT, even if levels above have the flag set.
> > 
> > You are absolutely right! This how this whole discussion started. It
> > slipped my mind.
> > 
> > > 
> > > Maybe highest_flag_domain() should be changed to take into account the
> > > metadata flags?
> > 
> > What about the patch below? Search will stop if the flag has
> > SDF_SHARED_CHILD as it does today. Otherwise it will search all the
> > domains.
> > 
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -1773,6 +1773,12 @@ queue_balance_callback(struct rq *rq,
> >  	for (__sd = rcu_dereference_check_sched_domain(cpu_rq(cpu)->sd); \
> >  			__sd; __sd = __sd->parent)
> >  
> > +#define SD_FLAG(name, mflags) (name * !!((mflags) & SDF_SHARED_CHILD)) |
> > +static const unsigned int SD_SHARED_CHILD_MASK =
> > +#include <linux/sched/sd_flags.h>
> > +0;
> > +#undef SD_FLAG
> > +
> >  /**
> >   * highest_flag_domain - Return highest sched_domain containing flag.
> >   * @cpu:	The CPU whose highest level of sched domain is to
> > @@ -1781,15 +1787,19 @@ queue_balance_callback(struct rq *rq,
> >   *		for the given CPU.
> >   *
> >   * Returns the highest sched_domain of a CPU which contains the given flag.
> > - */
> > +*/
>   ^^^
>   likely an unintended change

Yes! I will remove it in the patch I post.

> >  static inline struct sched_domain *highest_flag_domain(int cpu, int flag)
> >  {
> >  	struct sched_domain *sd, *hsd = NULL;
> >  
> >  	for_each_domain(cpu, sd) {
> > -		if (!(sd->flags & flag))
> > +		if (sd->flags & flag) {
> > +			hsd = sd;
> > +			continue;
> > +		}
> > +
> 
> There might be room for a comment here:
>                 /*
> 		 * If the flag is not set and is known to be shared with lower
> 		 * domains, stop the search, as it won't be found further up.
> 		 */

Sure, I can and a comment to this effect.

> > +		if (flag & SD_SHARED_CHILD_MASK)
> >  			break;
> > -		hsd = sd;
> >  	}
> >  
> >  	return hsd;
> 
> It looks nice and sane to me - I've not compiled or tested it :).

Thank you very much for your feedback!

BR,
Ricardo

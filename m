Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0229F66A268
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 19:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjAMSxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 13:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjAMSxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 13:53:15 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996B554DB3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 10:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673635994; x=1705171994;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0xpPinmeYWs8sDGyA5KvGkl2jL8c8TvIU6/ghrxUM/I=;
  b=D1mqTO3GxqMiDKEO0Fe8f83O9o4KojJCzLu4RrY15PZ0tmLgDq1Zp6ys
   rrQsJRyOQOhEQutXdDH68zOqO00N9u7V2dCZVJGciKUK1qYGy+XI35E5I
   kus94fUfh99zNiP4Gg7ao8HSxDV13OV0Nc4EigUxGxGfesVcCfQbDWews
   OAHNJvUg4F7JL9ZShSi3kInI1ruf9j9l82PQQQ4ibcB0eAHniTr11Ezq1
   8nHgKvoysjSBJei1RueyT9QXnGj7UztPPL0/rL31W0faAgrNxJKp+Q8Ns
   lQtUphnohohHm8m9te31kaUZhXDclCgBFxP5YXGPah77/2+aBoqH31qMX
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="311921576"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="311921576"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 10:53:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="766117853"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="766117853"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga002.fm.intel.com with ESMTP; 13 Jan 2023 10:53:12 -0800
Date:   Fri, 13 Jan 2023 11:02:26 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Valentin Schneider <vschneid@redhat.com>
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
        Tim Chen <tim.c.chen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [PATCH v2 1/7] sched/fair: Generalize asym_packing logic for SMT
 local sched group
Message-ID: <20230113190226.GA1379@ranerica-svr.sc.intel.com>
References: <20221122203532.15013-1-ricardo.neri-calderon@linux.intel.com>
 <20221122203532.15013-2-ricardo.neri-calderon@linux.intel.com>
 <xhsmhv8m3e5sx.mognet@vschneid.remote.csb>
 <20221229040003.GA11497@ranerica-svr.sc.intel.com>
 <xhsmhsfghcb20.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhsfghcb20.mognet@vschneid.remote.csb>
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

On Wed, Jan 11, 2023 at 04:04:23PM +0000, Valentin Schneider wrote:
> On 28/12/22 20:00, Ricardo Neri wrote:
> > On Thu, Dec 22, 2022 at 04:55:58PM +0000, Valentin Schneider wrote:
> >> Some of this is new to me - I had missed the original series introducing
> >> this. However ISTM that this is conflating two concepts: SMT occupancy
> >> balancing, and asym packing.
> >> 
> >> Take the !local_is_smt :: sg_busy_cpus >= 2 :: return true; path. It does
> >> not involve asym packing priorities at all. This can end up in an
> >> ASYM_PACKING load balance,
> >
> > Yes, this the desired result: an idle low-priority CPU should help a high-
> > priority core with more than one busy SMT sibling. But yes, it does not
> > relate to priorities and can be implemented differently.
> >
> >> which per calculate_imbalance() tries to move
> >> *all* tasks to the higher priority CPU - in the case of SMT balancing,
> >> we don't want to totally empty the core, just its siblings.
> >
> > But it will not empty the core, only one of its SMT siblings. A single
> > sibling will be selected in find_busiest_queue(). The other siblings will
> > be unaffected.
> >
> 
> Right
> 
> >> 
> >> Is there an ITMT/big.LITTLE (or however x86 calls it) case that invalidates
> >> the above?
> >
> > Please see below.
> >
> >> 
> >> Say, what's not sufficient with the below? AFAICT the only thing that isn't
> >> covered is the sg_busy_cpus >= 2 thing, but IMO that's SMT balancing, not
> >> asym packing - if the current calculate_imbalance() doesn't do it, it
> >> should be fixed to do it.
> >
> > Agreed.
> >
> >>Looking at the
> >> 
> >>   local->group_type == group_has_spare
> >> 
> >> case, it looks like it should DTRT.
> >
> > I had tried (and failed) to have find_busiest_group() handle the
> > !local_is_smt :: sg_busy_cpus >= 2 case. Now I think I made it work.
> >
> > When the busiest group is not overloaded, find_busiest_group() and
> > local->group = group_has_spare during an idle load balance events the
> > number of *idle* CPUs. However, this does not work if the local and busiest
> > groups have different weights. In SMT2, for instance, if busiest has 2 busy
> > CPUs (i.e., 0 idle CPUs) and the destination CPU is idle, the difference in
> > the number of idle CPUs is 1. find_busiest_group() will incorrectly goto
> > out_balanced.
> >
> > This issue very visible in Intel hybrid processors because the big cores
> > have SMT but the small cores do not. It can, however, be reproduced in non-
> > hybrid processors by offlining the SMT siblings of some cores.
> >
> 
> I think I follow. If we're comparing two groups each spanning an SMT2 core,
> then
> 
>   busiest->group_weight > 1 && local->idle_cpus <= (busiest->idle_cpus + 1)
> 
> is false if local is fully idle and busiest fully busy, but if local
> becomes a non-SMT core, then that's true and we goto out_balanced.

Exactly right.

> 
> 
> With that said, shouldn't SD_PREFER_SIBLING help here? cf.
> 
> 	if (sds.prefer_sibling && local->group_type == group_has_spare &&
> 	    busiest->sum_nr_running > local->sum_nr_running + 1)

It does not help because sds.prefer_sibling is false: an non-SMT core is
looking into offloading a fully_busy SMT core at the "MC" domain.
sds.prefer_sibling is set in update_sd_lb_stats() if the sched domain's child
has the SD_PREFER_SIBLING flag. Since the destination CPU is the non-SMT
core, there is no child.

> 
> It should be set on any topology level below the NUMA ones, we do remove it
> on SD_ASYM_CPUCAPACITY levels because this used to interfere with misfit
> balancing (it would override the group_type), things are a bit different
> since Vincent's rewrite of load_balance() but I think we still want it off
> there.

I see in find_busiest_group() that group_misfit_task is evaluated before
sds.prefer_sibling.

> I would expect it to be set in your system, though whether this is
> playing nice with the asymmetry is another matter :-)

I recall a few instances of SD_PREFER_SIBLING causing trouble me, but I
need to investigate more.

Thanks and BR,
Ricardo

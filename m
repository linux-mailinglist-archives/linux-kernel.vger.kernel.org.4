Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235B46550A9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 14:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236221AbiLWNDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 08:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235617AbiLWNDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 08:03:14 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275AD11C2B
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 05:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671800593; x=1703336593;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O6Wh20C5t6jZyBUrm+gsAKdKoNwqaHG/tB1n0ehrdaM=;
  b=Ekrp1AN6t6Z0M28ksq5TqwmJdNMDdVYrrB9CHmOEDVPGGcJnfH2kno3I
   pxRBODbL0RYqHVaNlAjN/WhtLl9hzWax/QZaoP/3gh5pNQV90m7Gi/zUh
   +UwDyE4MyTkgIbEr4P0eZqAYt3tm3wp+qlCLIu/0c0y/26fcgy1MGD4Cg
   5Rkb7QlF60u4VP8IWdG3kLC7DG6fcrKZ/Sb0T6V7OBa0Vgfr1L3cI82nf
   v0B5DbCmBq8gvMpkhNZ3syy/XVwOsgy8C6Hh6NYoJb+Q5ScfUvSIGy2Re
   wSk3MEVE0y/gVW4P5EYvrnkyHUvqrEZ5N2dvEO9+bW/dDy+WiGGw78yau
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="308042652"
X-IronPort-AV: E=Sophos;i="5.96,268,1665471600"; 
   d="scan'208";a="308042652"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2022 05:03:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="682724008"
X-IronPort-AV: E=Sophos;i="5.96,268,1665471600"; 
   d="scan'208";a="682724008"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga008.jf.intel.com with ESMTP; 23 Dec 2022 05:03:11 -0800
Date:   Fri, 23 Dec 2022 05:11:38 -0800
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
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [PATCH v2 1/7] sched/fair: Generalize asym_packing logic for SMT
 local sched group
Message-ID: <20221223131138.GA5856@ranerica-svr.sc.intel.com>
References: <20221122203532.15013-1-ricardo.neri-calderon@linux.intel.com>
 <20221122203532.15013-2-ricardo.neri-calderon@linux.intel.com>
 <76e23104-a8c0-a5fc-b8c6-27de79df2372@arm.com>
 <20221212175345.GA27353@ranerica-svr.sc.intel.com>
 <4f9aecf7-062e-8e85-1d3e-c010a85a010a@arm.com>
 <20221222043249.GA407@ranerica-svr.sc.intel.com>
 <2bff7fe9-c003-8757-1dbc-2b0f977d4e27@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bff7fe9-c003-8757-1dbc-2b0f977d4e27@arm.com>
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

On Thu, Dec 22, 2022 at 12:12:00PM +0100, Dietmar Eggemann wrote:
> On 22/12/2022 05:32, Ricardo Neri wrote:
> > On Wed, Dec 21, 2022 at 02:03:15PM +0100, Dietmar Eggemann wrote:
> >> On 12/12/2022 18:53, Ricardo Neri wrote:
> >>> On Tue, Dec 06, 2022 at 06:22:41PM +0100, Dietmar Eggemann wrote:
> >>>> On 22/11/2022 21:35, Ricardo Neri wrote:
> >>
> >> [...]
> >>
> >>>> I'm not sure why you change asym_smt_can_pull_tasks() together with
> >>>> removing SD_ASYM_PACKING from SMT level (patch 5/7)?
> >>>
> >>> In x86 we have SD_ASYM_PACKING at the MC, CLS* and, before my patches, SMT
> >>> sched domains.
> >>>
> >>>>
> >>>> update_sg_lb_stats()
> >>>>
> >>>>   ... && env->sd->flags & SD_ASYM_PACKING && .. && sched_asym()
> >>>>                                                    ^^^^^^^^^^^^
> >>>>     sched_asym()
> >>>>
> >>>>       if ((sds->local->flags & SD_SHARE_CPUCAPACITY) ||
> >>>>           (group->flags & SD_SHARE_CPUCAPACITY))
> >>>>         return asym_smt_can_pull_tasks()
> >>>>                ^^^^^^^^^^^^^^^^^^^^^^^^^
> >>>>
> >>>> So x86 won't have a sched domain with SD_SHARE_CPUCAPACITY and
> >>>> SD_ASYM_PACKING anymore. So sched_asym() would call sched_asym_prefer()
> >>>> directly on MC. What do I miss here?
> >>>
> >>> asym_smt_can_pull_tasks() is used above the SMT level *and* when either the
> >>> local or sg sched groups are composed of CPUs that are SMT siblings.
> >>
> >> OK.
> >>
> >>> In fact, asym_smt_can_pull_tasks() can only be called above the SMT level.
> >>> This is because the flags of a sched_group in a sched_domain are equal to
> >>> the flags of the child sched_domain. Since SMT is the lowest sched_domain,
> >>> its groups' flags are 0.
> >>
> >> I see. I forgot about `[PATCH v5 0/6] sched/fair: Fix load balancing of
> >> SMT siblings with ASYM_PACKING` from Sept 21 (specifically [PATCH v5
> >> 2/6] sched/topology: Introduce sched_group::flags).
> >>
> >>> sched_asym() calls sched_asym_prefer() directly if balancing at the
> >>> SMT level and, at higher domains, if the child domain is not SMT.
> >>
> >> OK.
> >>
> >>> This meets the requirement of Power7, where SMT siblings have different
> >>> priorities; and of x86, where physical cores have different priorities.
> >>>
> >>> Thanks and BR,
> >>> Ricardo
> >>>
> >>> * The target of these patches is Intel hybrid processors, on which cluster
> >>>   scheduling is disabled - cabdc3a8475b ("sched,x86: Don't use cluster
> >>>   topology for x86 hybrid CPUs"). Also, I have not observed topologies in
> >>>   which CPUs of the same cluster have different priorities.
> >>
> >> OK.
> >>
> >> IMHO, the function header of asym_smt_can_pull_tasks() (3rd and 4th
> >> paragraph ...  `If both @dst_cpu and @sg have SMT siblings` and
> > 
> > Agreed. I changed the behavior of the function. I will update the
> > description.
> > 
> >> `If @sg does not have SMT siblings` still reflect the old code layout.
> > 
> > But this behavior did not change. The check covers both SMT and non-SMT
> > cases:
> 
> The condition to call sched_asym_prefer() seems to have changed slightly
> though (including the explanation that busy_cpus_delta >= 2 handling
> should be done by fbg().:
> 
> sds->local_stat.sum_nr_running (A)
> busy_cpus_delta = sg_busy_cpus - local_busy_cpus (B)
> sg_busy_cpus = sgs->group_weight - sgs->idle_cpus (C)
> 
> From ((smt && B == 1) || (!smt && !A)) to (C == 1 && !A)

I agree that ((smt && B == 1) did change and I will update the comment.

My point is that (!smt && !A) is equivalent to (C == 1 && !A) if @sg has
only one CPU and is busy. The fourth paragraph still stands.

> 
> > 
> > 	 /*
> > 	  * non-SMT @sg can only have 1 busy CPU. We only care SMT @sg
> > 	  * has exactly one busy sibling
> > 	  */
> > 	if (sg_busy_cpus == 1 && 
> > 	    /* local group is fully idle, SMT and non-SMT. */
> > 	    !sds->local_stat.sum_nr_running)
> > 
> > Perhaps I can collapse the two paragraphs into one.
> 
> Sounds good to me.

Will do.

Thanks and BR,
Ricardo

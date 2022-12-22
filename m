Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57575653B3A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 05:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235013AbiLVEZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 23:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235052AbiLVEYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 23:24:42 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CAD301
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 20:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671683063; x=1703219063;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HnDBj9b52Isv8IdDq2/GPSkms++Bl2EgoooKIBlX2O8=;
  b=RvMKh/Lfd8cNT+vQv5VKaPt+csltIBkXjQdcoDwPey/GhG8uy8ypcDLx
   066iqg3iNgjcKjzQKL4NIVB/JbgCF0mFcDynqcKb8SMtRvhz+kdUOkqCf
   Q9ucIlR9dBaxIi5hRATxQduYPippfqQoxopIiVfxmHMRsM/s/6wEtgF/L
   PEhPnmwqsI6hQuJ8hxdkpsH3exyX0hKnu7d+7KdhXOVIz0Z9kNyNjPPAZ
   yUboWp7bs7QqDzeO+dML4BU/Gwkf1HhEzksNuBpQVIFv2VV/Gaj6NJ0BH
   G1A295oW/dRC/LC8E4jYd7SdaTwNAS9lkcGehPg6n6WlWdbH5ZgCwgyNW
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="318734699"
X-IronPort-AV: E=Sophos;i="5.96,264,1665471600"; 
   d="scan'208";a="318734699"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 20:24:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="740410285"
X-IronPort-AV: E=Sophos;i="5.96,264,1665471600"; 
   d="scan'208";a="740410285"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Dec 2022 20:24:22 -0800
Date:   Wed, 21 Dec 2022 20:32:49 -0800
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
Message-ID: <20221222043249.GA407@ranerica-svr.sc.intel.com>
References: <20221122203532.15013-1-ricardo.neri-calderon@linux.intel.com>
 <20221122203532.15013-2-ricardo.neri-calderon@linux.intel.com>
 <76e23104-a8c0-a5fc-b8c6-27de79df2372@arm.com>
 <20221212175345.GA27353@ranerica-svr.sc.intel.com>
 <4f9aecf7-062e-8e85-1d3e-c010a85a010a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f9aecf7-062e-8e85-1d3e-c010a85a010a@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 02:03:15PM +0100, Dietmar Eggemann wrote:
> On 12/12/2022 18:53, Ricardo Neri wrote:
> > On Tue, Dec 06, 2022 at 06:22:41PM +0100, Dietmar Eggemann wrote:
> >> On 22/11/2022 21:35, Ricardo Neri wrote:
> 
> [...]
> 
> >> I'm not sure why you change asym_smt_can_pull_tasks() together with
> >> removing SD_ASYM_PACKING from SMT level (patch 5/7)?
> > 
> > In x86 we have SD_ASYM_PACKING at the MC, CLS* and, before my patches, SMT
> > sched domains.
> > 
> >>
> >> update_sg_lb_stats()
> >>
> >>   ... && env->sd->flags & SD_ASYM_PACKING && .. && sched_asym()
> >>                                                    ^^^^^^^^^^^^
> >>     sched_asym()
> >>
> >>       if ((sds->local->flags & SD_SHARE_CPUCAPACITY) ||
> >>           (group->flags & SD_SHARE_CPUCAPACITY))
> >>         return asym_smt_can_pull_tasks()
> >>                ^^^^^^^^^^^^^^^^^^^^^^^^^
> >>
> >> So x86 won't have a sched domain with SD_SHARE_CPUCAPACITY and
> >> SD_ASYM_PACKING anymore. So sched_asym() would call sched_asym_prefer()
> >> directly on MC. What do I miss here?
> > 
> > asym_smt_can_pull_tasks() is used above the SMT level *and* when either the
> > local or sg sched groups are composed of CPUs that are SMT siblings.
> 
> OK.
> 
> > In fact, asym_smt_can_pull_tasks() can only be called above the SMT level.
> > This is because the flags of a sched_group in a sched_domain are equal to
> > the flags of the child sched_domain. Since SMT is the lowest sched_domain,
> > its groups' flags are 0.
> 
> I see. I forgot about `[PATCH v5 0/6] sched/fair: Fix load balancing of
> SMT siblings with ASYM_PACKING` from Sept 21 (specifically [PATCH v5
> 2/6] sched/topology: Introduce sched_group::flags).
> 
> > sched_asym() calls sched_asym_prefer() directly if balancing at the
> > SMT level and, at higher domains, if the child domain is not SMT.
> 
> OK.
> 
> > This meets the requirement of Power7, where SMT siblings have different
> > priorities; and of x86, where physical cores have different priorities.
> > 
> > Thanks and BR,
> > Ricardo
> > 
> > * The target of these patches is Intel hybrid processors, on which cluster
> >   scheduling is disabled - cabdc3a8475b ("sched,x86: Don't use cluster
> >   topology for x86 hybrid CPUs"). Also, I have not observed topologies in
> >   which CPUs of the same cluster have different priorities.
> 
> OK.
> 
> IMHO, the function header of asym_smt_can_pull_tasks() (3rd and 4th
> paragraph ...  `If both @dst_cpu and @sg have SMT siblings` and

Agreed. I changed the behavior of the function. I will update the
description.

>`If @sg does not have SMT siblings` still reflect the old code layout.

But this behavior did not change. The check covers both SMT and non-SMT
cases:

	 /*
	  * non-SMT @sg can only have 1 busy CPU. We only care SMT @sg
	  * has exactly one busy sibling
	  */
	if (sg_busy_cpus == 1 && 
	    /* local group is fully idle, SMT and non-SMT. */
	    !sds->local_stat.sum_nr_running)

Perhaps I can collapse the two paragraphs into one.

Thanks and BR,
Ricardo

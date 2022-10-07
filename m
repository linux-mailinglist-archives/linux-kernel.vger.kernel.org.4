Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697FD5F8137
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 01:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiJGXal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 19:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiJGXa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 19:30:29 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0582D3740D
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 16:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665185428; x=1696721428;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PNssUzBwhqhEAhtMVzvvKKGAbRzvhWqeld2MLSjq8Fc=;
  b=Jeu8UaeTsi3/Lhs2BHu/zaGhmC/ljUanGThhr6BRhCujDHcCr4YLoQjX
   EwWg625tRFb1ShLF/+D/hQJcRqBZWx1Fxr7mMAVBRG2sgGGeo2DebcW2t
   OxLg/pit7grf94dxX5s8EPOzvaCdzya7Jw5BUBDA15OWa2TlJiYuy+Ja3
   N1zDyvGmIfKzeNvzCjbr+CXxT0WB92G+uXLWJHertGmCGq7eOJtN3IPNu
   RceJl11Kpuee+sIZ6WDXN2Unl6cuHzJqIzn5B0vcnvdg/PaqzGOY+eUOt
   z3kiDZPQ13xzHWWIUDKpqTCygFpa/oXrrSC07g8+hPErMx3l5Rn+UMRWz
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="302584626"
X-IronPort-AV: E=Sophos;i="5.95,168,1661842800"; 
   d="scan'208";a="302584626"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2022 16:30:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="603053334"
X-IronPort-AV: E=Sophos;i="5.95,168,1661842800"; 
   d="scan'208";a="603053334"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga006.jf.intel.com with ESMTP; 07 Oct 2022 16:30:27 -0700
Date:   Fri, 7 Oct 2022 16:36:58 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
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
Subject: Re: [RFC PATCH 10/23] sched/fair: Use classes of tasks when
 selecting a busiest runqueue
Message-ID: <20221007233658.GA6555@ranerica-svr.sc.intel.com>
References: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
 <20220909231205.14009-11-ricardo.neri-calderon@linux.intel.com>
 <YzLdxS3dXCHq+bLa@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzLdxS3dXCHq+bLa@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 01:25:57PM +0200, Peter Zijlstra wrote:
> On Fri, Sep 09, 2022 at 04:11:52PM -0700, Ricardo Neri wrote:
> 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 7368a0b453ee..085b1f75d90b 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -10009,6 +10009,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
> >  	int i;
> >  
> >  	for_each_cpu_and(i, sched_group_span(group), env->cpus) {
> > +		int busiest_class_delta_score = INT_MIN;
> 
> You sure you want to break ties toward a negative IPC 'improvement' ?

Yes. We may have a negative IPC class delta if the destination CPU has
lower prioriy than the CPUs in the busiest group. This may occur when
the busiest group is a core with more than one busy SMT sibling.

> 
> >  		unsigned long capacity, load, util;
> >  		unsigned int nr_running;
> >  		enum fbq_type rt;
> > @@ -10118,6 +10119,20 @@ static struct rq *find_busiest_queue(struct lb_env *env,
> >  			if (busiest_nr < nr_running) {
> >  				busiest_nr = nr_running;
> >  				busiest = rq;
> > +			} else if (sched_task_classes_enabled() &&
> > +				   busiest_nr == nr_running) {
> > +				int curr_class_delta_score;
> > +
> > +				curr_class_delta_score = arch_get_task_class_score(rq->curr->class,
> > +										   env->dst_cpu) -
> > +							 arch_get_task_class_score(rq->curr->class,
> > +										   cpu_of(rq));
> 
> *sigh*, you really couldn't find a more ugly layout if you tried.
> 
> Perhaps use less than novella length identifiers?

Sure, I will revisit the naming of the identifiers.

Thanks and BR,
Ricardo

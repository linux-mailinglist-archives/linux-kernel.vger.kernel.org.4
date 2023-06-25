Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57AD273D39D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 22:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjFYUUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 16:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjFYUUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 16:20:50 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2161B1;
        Sun, 25 Jun 2023 13:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687724449; x=1719260449;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GiM0x6n+PqQfGg3R0eLSBMyCIkszbQdYpYQsIp4mBnw=;
  b=aOujkTv6IYpi6Sj6/U0eJax/JRwIhUZ0M1MAQYUJIu2m+FZ3VZGNgdHv
   vH06KlZ3ZmchhVUffL3uCdmUzDJ2/T18bjkG+mqhyqLfaPCfs9Cv3BMaa
   6Ik3ikXJFnzrDaUlVGZBKCt9aSdMwAs1pD4COE10mbo+OBUBKh2QrHALY
   +rRqfyF4EaMMir5LazMh3L60JRxb64Cse4i+ezpMm4R3orvZeHtwAmAh2
   vtAUpsw6/BeApz+NL5a6TGqChVayp/BHj77aCyISm8aDDS+90b4WC7abc
   Sf/npAjO48hfBmwCk16qaDeQqcE2/PWGRU/Cj6lldhB4SQw5D5wxh1m9/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="345867306"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="345867306"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2023 13:20:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="962543776"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="962543776"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga006.fm.intel.com with ESMTP; 25 Jun 2023 13:20:32 -0700
Date:   Sun, 25 Jun 2023 13:23:18 -0700
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
        Valentin Schneider <vschneid@redhat.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Zhao Liu <zhao1.liu@intel.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>, x86@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Tim C . Chen" <tim.c.chen@intel.com>,
        Zhao Liu <zhao1.liu@linux.intel.com>
Subject: Re: [PATCH v4 18/24] sched/task_struct: Add helpers for IPC
 classification
Message-ID: <20230625202318.GB3902@ranerica-svr.sc.intel.com>
References: <20230613042422.5344-1-ricardo.neri-calderon@linux.intel.com>
 <20230613042422.5344-19-ricardo.neri-calderon@linux.intel.com>
 <ZJQgf1PtrHWLA9q1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJQgf1PtrHWLA9q1@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 11:20:47AM +0100, Ionela Voinescu wrote:
> Hi,
> 
> On Monday 12 Jun 2023 at 21:24:16 (-0700), Ricardo Neri wrote:
> > The raw classification that hardware provides for a task may not
> > be directly usable by the scheduler: the classification may change too
> > frequently or architecture-specific implementations may need to consider
> > additional factors. For instance, some processors with Intel Thread
> > Director need to consider the state of the SMT siblings of a core.
> > 
> > Provide per-task helper variables that architectures can use to
> > postprocess the classification that hardware provides.
> > 
> > Cc: Ben Segall <bsegall@google.com>
> > Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Cc: Ionela Voinescu <ionela.voinescu@arm.com>
> > Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: Lukasz Luba <lukasz.luba@arm.com>
> > Cc: Mel Gorman <mgorman@suse.de>
> > Cc: Perry Yuan <Perry.Yuan@amd.com>
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Tim C. Chen <tim.c.chen@intel.com>
> > Cc: Valentin Schneider <vschneid@redhat.com>
> > Cc: Zhao Liu <zhao1.liu@linux.intel.com>
> > Cc: x86@kernel.org
> > Cc: linux-pm@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > ---
> > Changes since v3:
> >  * None
> > 
> > Changes since v2:
> >  * None
> > 
> > Changes since v1:
> >  * Used bit-fields to fit all the IPC class data in 4 bytes. (PeterZ)
> >  * Shortened names of the helpers.
> >  * Renamed helpers with the ipcc_ prefix.
> >  * Reworded commit message for clarity
> > ---
> >  include/linux/sched.h | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 0e1c38ad09c2..719147460ca8 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -1541,7 +1541,17 @@ struct task_struct {
> >  	 * A hardware-defined classification of task that reflects but is
> >  	 * not identical to the number of instructions per cycle.
> >  	 */
> > -	unsigned short			ipcc;
> > +	unsigned int			ipcc : 9;
> > +	/*
> > +	 * A candidate classification that arch-specific implementations
> > +	 * qualify for correctness.
> > +	 */
> > +	unsigned int			ipcc_tmp : 9;
> > +	/*
> > +	 * Counter to filter out transient candidate classifications
> > +	 * of a task.
> > +	 */
> > +	unsigned int			ipcc_cntr : 14;
> >  #endif
> >  
> 
> Why does this need to be split in task_struct? Isn't this architecture
> specific? IMO the scheduler should never make use of class information
> itself. It only receives the value though the call of an arch function
> and passes it as an argument to an arch function to get a performance
> score. So the way one interprets the class value (splits it in relevant
> and helper bits) should be defined and considered in the architecture
> specific code.

This is an excellent observation. The scheduler is unconcerned with what
the classes mean. I'll remove these auxiliary members.

This also removes 2 patches from the series.

Thanks and BR,
Ricardo

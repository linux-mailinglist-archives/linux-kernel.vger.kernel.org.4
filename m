Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6BD85F6DCE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 21:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbiJFTDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 15:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbiJFTCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 15:02:31 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDA11144F4
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 12:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665082897; x=1696618897;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eloqXl/5HqSaNDYR4ND9CwZjrnE5ddVstvROr2A2S6o=;
  b=XZ/fMCUlzGTLW9fb68jHq7fZN8SoGhfS/56wMU1R0lnhD3bzLLgXoXPY
   cruAGh1K+y/lfItSl8s7ozb7F1FxkF4pzql1miGEcio7kHyy7XvS0x+p7
   bN5mJa/VuggfFLg+FGF3FkKoWtgKYSs6XQuNbbnkTY2AWP1Ys/r8qFgd6
   Bw90bzOT2yyzwpOiysiIm7A9fFgH+WfzGM1s4KNgPQ6qF/C37oLL6QYuF
   ZX+NgwMi3JAcGV8TXOMKxeyx1BwWA2ihuVUla0YHvoblTcaY/lU01lL49
   emwagnmKizr1mRNzrG5a+5Lwo3xcpuTA/Ak6BJx72sU+ApOKp7gV/QgaD
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="389833373"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="389833373"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 12:01:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="800005354"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="800005354"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga005.jf.intel.com with ESMTP; 06 Oct 2022 12:01:29 -0700
Date:   Thu, 6 Oct 2022 12:07:58 -0700
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
Subject: Re: [RFC PATCH 09/23] sched/fair: Use task-class performance score
 to pick the busiest group
Message-ID: <20221006190758.GA1624@ranerica-svr.sc.intel.com>
References: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
 <20220909231205.14009-10-ricardo.neri-calderon@linux.intel.com>
 <YzLYDPU+upHeUG65@hirez.programming.kicks-ass.net>
 <20221005233841.GA29251@ranerica-svr.sc.intel.com>
 <Yz6T4OslXxKdAlM/@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yz6T4OslXxKdAlM/@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 10:37:52AM +0200, Peter Zijlstra wrote:
> On Wed, Oct 05, 2022 at 04:38:41PM -0700, Ricardo Neri wrote:
> > On Tue, Sep 27, 2022 at 01:01:32PM +0200, Peter Zijlstra wrote:
> > > On Fri, Sep 09, 2022 at 04:11:51PM -0700, Ricardo Neri wrote:
> 
> > > > @@ -9049,6 +9111,12 @@ static bool update_sd_pick_busiest(struct lb_env *env,
> > > >  		/* Prefer to move from lowest priority CPU's work */
> > > >  		if (sched_asym_prefer(sg->asym_prefer_cpu, sds->busiest->asym_prefer_cpu))
> > > >  			return false;
> > > > +
> > > > +		/* @sg and @sds::busiest have the same priority. */
> > > > +		if (sched_asym_class_pick(sds->busiest, sg, &sds->busiest_stat, sgs))
> > > > +			return false;
> > > > +
> > > > +		/* @sg has lower priority than @sds::busiest. */
> > > >  		break;
> > > >  
> > > >  	case group_misfit_task:
> > > 
> > > So why does only this one instance of asym_prefer() require tie
> > > breaking?
> > 
> > This is the only place in which two sched groups with running tasks and of
> > equal priority are compared.
> > 
> > In all other places sched_asym_prefer() is used to compare the destination
> > CPU with others. Since asym_packing is done only when the destination CPU is
> > idle, there is no need to break this tie.

> 
> That would make for a fine comment, no? Because as presented one is left
> wondering, why if asym_prefer() needs tie breaking, only this one site
> needs it.

Sure.  I will add this comment.

> 
> > > And while looking through this, I must ask about the comment that goes
> > > with sched_set_itmt_core_prio() vs the sg->asym_prefer_cpu assignment in
> > > init_sched_groups_capacity(), what-up ?!
> > 
> > Are you referring to this comment?
> > 
> > 	"No need to rebuild sched domain after updating
> > 	 the CPU priorities. The sched domains have no
> > 	 dependency on CPU priorities"
> > 
> > If yes, then it looks wrong to me. Sched domains are rebuilt after updating
> > priorities.

I can included in the series a patch removing this comment.

Thanks and BR,
Ricardo

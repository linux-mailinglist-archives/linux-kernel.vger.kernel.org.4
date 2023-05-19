Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A324C708C8B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 01:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjERX6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 19:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjERX6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 19:58:31 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470A4EA
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 16:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684454310; x=1715990310;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j8yGiICk61w++obRlnYB3sOYUpEpXHCdxLIrJ8Rqerk=;
  b=DvwOh1iwqylvWUQ7bQYJSGZNEf6HKuRZv9FYT86O9IYTGvhXzmqCPSns
   nzPgMHsfQzdI+7/pKDoLig9Tx6vMP5m8OxoiIZ5m43PpgDJVKh9nRveDC
   MX7ZXBvRUMcxgyMnVUjzo3xO7WWKwYDr+FFGgPqeRDmGUCsdpXdfD4I5T
   +0D1HnPbDvNmR5Bk52uRKmEEew2XGhAr7wj9YSFIqTdIfIJ/TChNHP36E
   ZCqhXKxxU34H/PQcArd2spRgT+TFu23z27oKJ+2PsTxbBtqUyPPMz7C6m
   p2b0p6DVdImLKA6lmGZX41+H5SWiSUpabme6Wsn8BCu1g7oXpil10CjHg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="438580081"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="438580081"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 16:58:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="705367859"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="705367859"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga007.fm.intel.com with ESMTP; 18 May 2023 16:58:29 -0700
Date:   Thu, 18 May 2023 17:01:26 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Cc:     Ricardo Neri <ricardo.neri@intel.com>,
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
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Tim C . Chen" <tim.c.chen@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 05/12] sched/fair: Keep a fully_busy SMT sched group
 as busiest
Message-ID: <20230519000126.GA24449@ranerica-svr.sc.intel.com>
References: <20230406203148.19182-1-ricardo.neri-calderon@linux.intel.com>
 <20230406203148.19182-6-ricardo.neri-calderon@linux.intel.com>
 <431faa39-4f5c-0087-7ce5-16796ca1a9e1@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <431faa39-4f5c-0087-7ce5-16796ca1a9e1@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 13, 2023 at 12:11:45AM +0530, Shrikanth Hegde wrote:
> 
> 
> On 4/7/23 2:01 AM, Ricardo Neri wrote:
> > When comparing two fully_busy scheduling groups, keep the current busiest
> > group if it represents an SMT core. Tasks in such scheduling group share
> > CPU resources and need more help than tasks in a non-SMT fully_busy group.
> >
> > Cc: Ben Segall <bsegall@google.com>
> > Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Cc: Ionela Voinescu <ionela.voinescu@arm.com>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: Mel Gorman <mgorman@suse.de>
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Tim C. Chen <tim.c.chen@intel.com>
> > Cc: Valentin Schneider <vschneid@redhat.com>
> > Cc: x86@kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Tested-by: Zhang Rui <rui.zhang@intel.com>
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > ---
> > Changes since v3:
> >  * None
> >
> > Changes since v2:
> >  * Introduced this patch.
> >
> > Changes since v1:
> >  * N/A
> > ---
> >  kernel/sched/fair.c | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index b151e93ec316..ea23a5163bfa 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -9566,10 +9566,22 @@ static bool update_sd_pick_busiest(struct lb_env *env,
> >  		 * contention when accessing shared HW resources.
> >  		 *
> >  		 * XXX for now avg_load is not computed and always 0 so we
> > -		 * select the 1st one.
> > +		 * select the 1st one, except if @sg is composed of SMT
> > +		 * siblings.
> >  		 */
> > -		if (sgs->avg_load <= busiest->avg_load)
> > +
> > +		if (sgs->avg_load < busiest->avg_load)
> >  			return false;
> > +
> > +		if (sgs->avg_load == busiest->avg_load) {
> > +			/*
> > +			 * SMT sched groups need more help than non-SMT groups.
> > +			 * If @sg happens to also be SMT, either choice is good.
> > +			 */
> > +			if (sds->busiest->flags & SD_SHARE_CPUCAPACITY)
> > +				return false;
> > +		}
> > +
> >  		break;
> 

Thank you very much for your review!

> IIUC,
> 
> Earlier, we used to go to out_balanced if sgs->avg_load <= busiest->avg_load.
> Now we go only if it is less.

In this particular case we are comparing to fully_busy groups. Both
sgs->avg_load and busiest->avg_load are equal to zero 0.

> lets say sgs->avg_load == busiest->avg_load,
> then we will return true in MC,DIE domain. This might end up traversing
> multiple such group's and pick the last one as the busiest instead of
> first.

Yes, that is correct. But we traverse all sched groups from
update_sd_lb_stats() anyway. We are here because both sgs and busiest are
of type fully_busy and we need to break a tie. Previously we always kept
on selecting sgs as busiest.

> I guess eventually any load balance if exists will be fixed.  But
> this might cause slight overhead. would it?
> 
> 
> 
> nit: There is typo in [2/12]  if the whole core is repeated.
> +	 * CPUs. When done between cores, do it only if the whole core if the
> +	 * whole core is idle.
> 
> Mentioning in this reply instead, to avoid sending another mail reply for this.

Ah! I read my patches dozens of times and I still missed this. Thank you
for noting. I will post a trivial patch to fix it.

Thanks and BR,
Ricardo

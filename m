Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC10466B676
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 04:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbjAPD41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 22:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjAPD4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 22:56:19 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F85B8684
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 19:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673841378; x=1705377378;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J5gd0BGy5x+M+oYun7etY+8DqXdk9Gy9OGjM/ozXPsc=;
  b=ln55PM7QMj0mbfpun8okFSx2DOQDg6U1Z4ltKG+Lq/RZQD49dHZcRtFG
   Ub62sk6E35JrYTi2nhJ58loPpW+Ntkms/Kgsvuz6ntx0oDX5+35QBEmvx
   A++L6MkQsppW03snVv3U6LanscQwYepbG/+B9f9I85pYjUIpQ/hrQcM7P
   vzBanSkhBW6T0BFIHx/HAeQCeXAogI1wJ+DKVrHNUuypN8QacXFnQDSqx
   rPDKyeRu4MtQcxQNnJ8qgYapwDOwUzpds79/mKCmnhoi7zUz7/5HBekXc
   MKyALFpXe850GXWSAXcckFbjPmloqCK0bKh7cn0Gc/1W7THX/Jj2vhaNE
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="312230460"
X-IronPort-AV: E=Sophos;i="5.97,219,1669104000"; 
   d="scan'208";a="312230460"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2023 19:56:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="747565220"
X-IronPort-AV: E=Sophos;i="5.97,219,1669104000"; 
   d="scan'208";a="747565220"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Jan 2023 19:56:17 -0800
Date:   Sun, 15 Jan 2023 20:05:29 -0800
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
Message-ID: <20230116040529.GA16654@ranerica-svr.sc.intel.com>
References: <20221122203532.15013-1-ricardo.neri-calderon@linux.intel.com>
 <20221122203532.15013-2-ricardo.neri-calderon@linux.intel.com>
 <xhsmhv8m3e5sx.mognet@vschneid.remote.csb>
 <20221229040003.GA11497@ranerica-svr.sc.intel.com>
 <xhsmhsfghcb20.mognet@vschneid.remote.csb>
 <20230113190226.GA1379@ranerica-svr.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113190226.GA1379@ranerica-svr.sc.intel.com>
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

On Fri, Jan 13, 2023 at 11:02:26AM -0800, Ricardo Neri wrote:
> On Wed, Jan 11, 2023 at 04:04:23PM +0000, Valentin Schneider wrote:
> > On 28/12/22 20:00, Ricardo Neri wrote:
> > > On Thu, Dec 22, 2022 at 04:55:58PM +0000, Valentin Schneider wrote:
> > >> Some of this is new to me - I had missed the original series introducing
> > >> this. However ISTM that this is conflating two concepts: SMT occupancy
> > >> balancing, and asym packing.
> > >> 
> > >> Take the !local_is_smt :: sg_busy_cpus >= 2 :: return true; path. It does
> > >> not involve asym packing priorities at all. This can end up in an
> > >> ASYM_PACKING load balance,
> > >
> > > Yes, this the desired result: an idle low-priority CPU should help a high-
> > > priority core with more than one busy SMT sibling. But yes, it does not
> > > relate to priorities and can be implemented differently.
> > >
> > >> which per calculate_imbalance() tries to move
> > >> *all* tasks to the higher priority CPU - in the case of SMT balancing,
> > >> we don't want to totally empty the core, just its siblings.
> > >
> > > But it will not empty the core, only one of its SMT siblings. A single
> > > sibling will be selected in find_busiest_queue(). The other siblings will
> > > be unaffected.
> > >
> > 
> > Right
> > 
> > >> 
> > >> Is there an ITMT/big.LITTLE (or however x86 calls it) case that invalidates
> > >> the above?
> > >
> > > Please see below.
> > >
> > >> 
> > >> Say, what's not sufficient with the below? AFAICT the only thing that isn't
> > >> covered is the sg_busy_cpus >= 2 thing, but IMO that's SMT balancing, not
> > >> asym packing - if the current calculate_imbalance() doesn't do it, it
> > >> should be fixed to do it.
> > >
> > > Agreed.
> > >
> > >>Looking at the
> > >> 
> > >>   local->group_type == group_has_spare
> > >> 
> > >> case, it looks like it should DTRT.
> > >
> > > I had tried (and failed) to have find_busiest_group() handle the
> > > !local_is_smt :: sg_busy_cpus >= 2 case. Now I think I made it work.
> > >
> > > When the busiest group is not overloaded, find_busiest_group() and
> > > local->group = group_has_spare during an idle load balance events the
> > > number of *idle* CPUs. However, this does not work if the local and busiest
> > > groups have different weights. In SMT2, for instance, if busiest has 2 busy
> > > CPUs (i.e., 0 idle CPUs) and the destination CPU is idle, the difference in
> > > the number of idle CPUs is 1. find_busiest_group() will incorrectly goto
> > > out_balanced.
> > >
> > > This issue very visible in Intel hybrid processors because the big cores
> > > have SMT but the small cores do not. It can, however, be reproduced in non-
> > > hybrid processors by offlining the SMT siblings of some cores.
> > >
> > 
> > I think I follow. If we're comparing two groups each spanning an SMT2 core,
> > then
> > 
> >   busiest->group_weight > 1 && local->idle_cpus <= (busiest->idle_cpus + 1)
> > 
> > is false if local is fully idle and busiest fully busy, but if local
> > becomes a non-SMT core, then that's true and we goto out_balanced.
> 
> Exactly right.
> 
> > 
> > 
> > With that said, shouldn't SD_PREFER_SIBLING help here? cf.
> > 
> > 	if (sds.prefer_sibling && local->group_type == group_has_spare &&
> > 	    busiest->sum_nr_running > local->sum_nr_running + 1)
> 
> It does not help because sds.prefer_sibling is false: an non-SMT core is
> looking into offloading a fully_busy SMT core at the "MC" domain.
> sds.prefer_sibling is set in update_sd_lb_stats() if the sched domain's child
> has the SD_PREFER_SIBLING flag. Since the destination CPU is the non-SMT
> core, there is no child.
> 
> > 
> > It should be set on any topology level below the NUMA ones, we do remove it
> > on SD_ASYM_CPUCAPACITY levels because this used to interfere with misfit
> > balancing (it would override the group_type), things are a bit different
> > since Vincent's rewrite of load_balance() but I think we still want it off
> > there.

Your comment got me thinking. Whose child sched domain wants prefer_sibling?
It sounds to me that is busiest's. I could not think of any reason of *having*
to use the flags of the local group.

We can use the flags of the sched group (as per 16d364ba6ef2 ("sched/topology:
Introduce sched_group::flags"), these are the flags of the child domain).

The patch below works for me and I don't have to even the number of busy CPUs.
It should not interfere with misfit balancing either:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a2c70e1087d0..737bb3c8bfae 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9752,8 +9752,12 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 		sg = sg->next;
 	} while (sg != env->sd->groups);
 
-	/* Tag domain that child domain prefers tasks go to siblings first */
-	sds->prefer_sibling = child && child->flags & SD_PREFER_SIBLING;
+	/*
+	 * Tag domain that child domain prefers tasks go to siblings first.
+	 * A sched group has the flags of the child domain, if any.
+	 */
+	if (sds->busiest)
+		sds->prefer_sibling = sds->busiest->flags & SD_PREFER_SIBLING;
 
 
 	if (env->sd->flags & SD_NUMA)

Thanks and BR,
Ricardo

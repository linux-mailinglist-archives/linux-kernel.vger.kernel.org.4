Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2516F3BE1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 03:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbjEBBlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 21:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjEBBlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 21:41:02 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F3B1709
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 18:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682991661; x=1714527661;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O3uvJGvYvytJ1668t350qJBiHN3+RlZ//QGXC5ogJ+E=;
  b=XZ9XTCzQSIbmlDliKaVgQO/3UC5IqCfb1P1Jg5WQJwVDOVJCJdS9p6zC
   +auSf6qyqEDMFv5r4Oqtc8kZT+I/iOA4CfVDjGRt0lfmcaUp1tLFtqOsn
   ld7gtUb8OMFz4OFS4O4w/iKQICiO+xMj6wCwIXVbnXAGSKWZItKcDKKV5
   gBsYoTnW+raM5OaLjLelc2vrXX225Hq3SC6AcFKGHtO327bqyrMt04/cv
   Er0w3Qnn8LYx0xmQFcKMmG103ELAZfpoehI7uHxxubaO2fNO+F6gzJLSh
   DiXNvvgQD/ijimk0lroey9HvAC1lXEkrkF/Vozs9HmZ9Ry2qZKBOpjHBB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="337404400"
X-IronPort-AV: E=Sophos;i="5.99,242,1677571200"; 
   d="scan'208";a="337404400"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2023 18:39:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="690107092"
X-IronPort-AV: E=Sophos;i="5.99,242,1677571200"; 
   d="scan'208";a="690107092"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga007.jf.intel.com with ESMTP; 01 May 2023 18:39:53 -0700
Date:   Mon, 1 May 2023 18:42:55 -0700
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
        Valentin Schneider <vschneid@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        naveen.n.rao@linux.vnet.ibm.com
Subject: Re: [PATCH v4 00/12] sched: Avoid unnecessary migrations within SMT
 domains
Message-ID: <20230502014254.GA1219@ranerica-svr.sc.intel.com>
References: <20230406203148.19182-1-ricardo.neri-calderon@linux.intel.com>
 <20230429153219.GC1495785@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230429153219.GC1495785@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 29, 2023 at 05:32:19PM +0200, Peter Zijlstra wrote:
> On Thu, Apr 06, 2023 at 01:31:36PM -0700, Ricardo Neri wrote:
> > Hi,
> > 
> > This is v4 of this series. Previous versions can be found here [1], [2],
> > and here [3]. To avoid duplication, I do not include the cover letter of
> > the original submission. You can read it in [1].
> > 
> > This patchset applies cleanly on today's master branch of the tip tree.
> > 
> > Changes since v3:
> > 
> > Nobody liked the proposed changes to the setting of prefer_sibling.
> > Instead, I tweaked the solution that Dietmar proposed. Now the busiest
> > group, not the local group, determines the setting of prefer_sibling.
> > 
> > Vincent suggested improvements to the logic to decide whether to follow
> > asym_packing priorities. Peter suggested to wrap that in a helper function.
> > I added sched_use_asym_prio().
> > 
> > Ionela found that removing SD_ASYM_PACKING from the SMT domain in x86
> > rendered sd_asym_packing NULL in SMT cores. Now highest_flag_domain()
> > does not assume that all child domains have the requested flag.
> > 
> > Tim found that asym_active_balance() needs to also check for the idle
> > states of the SMT siblings of lb_env::dst_cpu. I added such check.
> > 
> > I wrongly assumed that asym_packing could only be used when the busiest
> > group had exactly one busy CPU. This broke asym_packing balancing at the
> > DIE domain. I limited this check to balances between cores at the MC
> > level.
> > 
> > As per suggestion from Dietmar, I removed sched_asym_smt_can_pull_tasks()
> > and placed its logic in sched_asym(). Also, sched_asym() uses
> > sched_smt_active() to skip checks when not needed.
> > 
> > I also added a patch from Chen Yu to enable asym_packing balancing in
> > Meteor Lake, which has CPUs of different maximum frequency in more than
> > one die.
> 
> Is the actual topology of Meteor Lake already public? This patch made me
> wonder if we need SCHED_CLUSTER topology in the hybrid_topology thing,

Indeed, Meteor Lake will need SCHED_CLUSTER as does Alder Lake. This is in
addition to multi-die support.


> but I can't remember (one of the raisins why the endless calls are such
> a frigging waste of time) and I can't seem to find the answer using
> Google either.
> 
> > Hopefully, these patches are in sufficiently good shape to be merged?
> 
> Changelogs are very sparse towards the end and I had to reverse engineer
> some of it which is a shame. But yeah, on a first reading the code looks
> mostly ok. Specifically 8-10 had me WTF a bit and only at 11 did it
> start to make a little sense. Mostly they utterly fail to answer the
> very fundament "why did you do this" question.

I am sorry changelogs are not sufficiently clear. I thought stating the
overall goal in the cover letter was enough. In the future, would you
prefer that I repeat the cover letter instead of referring to it? Should
individual changelogs state the overall goal?

> 
> Also, you seem to have forgotten to Cc our friends from IBM such that
> they might verify you didn't break their Power7 stuff -- or do you have
> a Power7 yourself to verify and forgot to mention that?

I do not have a Power7 system. I did emulate it on an x86 system by
setting all cores with identical sg->asym_prefer_cpu. Within, cores, SMT
siblings had asymmetric priorities. It was only SMT2, though.

> 
> > Chen Yu (1):
> >   x86/sched: Add the SD_ASYM_PACKING flag to the die domain of hybrid
> >     processors
> > 
> > Ricardo Neri (11):
> >   sched/fair: Move is_core_idle() out of CONFIG_NUMA
> >   sched/fair: Only do asym_packing load balancing from fully idle SMT
> >     cores
> >   sched/fair: Simplify asym_packing logic for SMT cores
> >   sched/fair: Let low-priority cores help high-priority busy SMT cores
> >   sched/fair: Keep a fully_busy SMT sched group as busiest
> >   sched/fair: Use the busiest group to set prefer_sibling
> >   sched/fair: Do not even the number of busy CPUs via asym_packing
> >   sched/topology: Check SDF_SHARED_CHILD in highest_flag_domain()
> >   sched/topology: Remove SHARED_CHILD from ASYM_PACKING
> >   x86/sched: Remove SD_ASYM_PACKING from the SMT domain flags
> >   x86/sched/itmt: Give all SMT siblings of a core the same priority
> > 
> >  arch/x86/kernel/itmt.c         |  23 +---
> >  arch/x86/kernel/smpboot.c      |   4 +-
> >  include/linux/sched/sd_flags.h |   5 +-
> >  kernel/sched/fair.c            | 216 +++++++++++++++++----------------
> >  kernel/sched/sched.h           |  22 +++-
> >  5 files changed, 138 insertions(+), 132 deletions(-)
> 
> I'm going to start to queue this and hopefully push out post -rc1 if
> nobody objects.

Thanks! Will it be content for v6.4 or v6.5?

BR,
Ricardo

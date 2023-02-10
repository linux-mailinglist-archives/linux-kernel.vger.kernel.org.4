Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A27692541
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 19:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbjBJSWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 13:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbjBJSWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 13:22:12 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B66B61D15
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 10:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676053331; x=1707589331;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JnABS4bzuUOo3oZdGDN/S3N14HFWtHaPR9HjHLG9mC4=;
  b=RNF29cgDewxOJb5l9emiaB4BUlTbrWNfgzhWaC1JnG1k+3vbK9cHBOwk
   t2m0cfgvFrwDFRUXAOlJgm+b/5TIqIki98Mg5dpwXEEttqHIQw0+pQqH7
   v2VOD+WsJYwAdYMUjal+Ulmn3D0Mz/Bts2Ue7PbAumKQnn6gtjkS/z2PB
   ekPiAsU9Fh1njZOszOJoSiPtJvWJSw4kThyVeJ/jP21jBhorQMDYGKPVL
   I9/F16q7P6T3QgmC/mM1JNc4o6xpSO5d8CvbwS7kMdEPP9WLdwvt4H1Sn
   dXrQFyu237eDgsmQjPP24Z2NmB8TcFc3cIobWmDOEGfQZC3jFOQrTAvUi
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="392895704"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="392895704"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 10:22:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="810906179"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="810906179"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga001.fm.intel.com with ESMTP; 10 Feb 2023 10:22:09 -0800
Date:   Fri, 10 Feb 2023 10:31:55 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [PATCH v3 06/10] sched/fair: Use the prefer_sibling flag of the
 current sched domain
Message-ID: <20230210183155.GA11997@ranerica-svr.sc.intel.com>
References: <20230207045838.11243-1-ricardo.neri-calderon@linux.intel.com>
 <20230207045838.11243-7-ricardo.neri-calderon@linux.intel.com>
 <Y+YXrk5NRuWaSOGR@hirez.programming.kicks-ass.net>
 <xhsmhmt5lr2nz.mognet@vschneid.remote.csb>
 <Y+Z2b/OtZDk9cT53@hirez.programming.kicks-ass.net>
 <xhsmhk00pqwap.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhk00pqwap.mognet@vschneid.remote.csb>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 05:12:30PM +0000, Valentin Schneider wrote:
> On 10/02/23 17:53, Peter Zijlstra wrote:
> > On Fri, Feb 10, 2023 at 02:54:56PM +0000, Valentin Schneider wrote:
> >
> >> So something like have SD_PREFER_SIBLING affect the SD it's on (and not
> >> its parent), but remove it from the lowest non-degenerated topology level?
> >
> > So I was rather confused about the whole moving it between levels things
> > this morning -- conceptually, prefer siblings says you want to try
> > sibling domains before filling up your current domain. Now, balancing
> > between siblings happens one level up, hence looking at child->flags
> > makes perfect sense.
> >
> > But looking at the current domain and still calling it prefer sibling
> > makes absolutely no sense what so ever.
> >
> 
> True :-)
> 
> > In that confusion I think I also got the polarity wrong, I thought you
> > wanted to kill prefer_sibling for the assymetric SMT cases, instead you
> > want to force enable it as long as there is one SMT child around.

Exactly.

> >
> > Whichever way around it we do it, I'm thinking perhaps some renaming
> > might be in order to clarify things.
> >
> > How about adding a flag SD_SPREAD_TASKS, which is the effective toggle
> > of the behaviour, but have it be set by children with SD_PREFER_SIBLING
> > or something.
> >
> 
> Or entirely bin SD_PREFER_SIBLING and stick with SD_SPREAD_TASKS, but yeah
> something along those lines.

I sense a consesus towards SD_SPREAD_TASKS.

> 
> > OTOH, there's also
> >
> >   if (busiest->group_weight == 1 || sds->prefer_sibling) {
> >
> > which explicitly also takes the group-of-one (the !child case) into
> > account, but that's not consistently done.
> >
> >       sds->prefer_sibling = !child || child->flags & SD_PREFER_SIBLING;

This would need a special provision for SD_ASYM_CPUCAPACITY.

> >
> > seems an interesting option,
> 
> > except perhaps ASYM_CPUCAPACITY -- I
> > forget, can CPUs of different capacity be in the same leaf domain? With
> > big.LITTLE I think not, they had their own cache domains and so you get
> > at least MC domains per capacity, but DynamiQ might have totally wrecked
> > that party.
> 
> Yeah, newer systems can have different capacities in one MC domain, cf:
> 
>   b7a331615d25 ("sched/fair: Add asymmetric CPU capacity wakeup scan")
> 
> >
> >> (+ add it to the first NUMA level to keep things as they are, even if TBF I
> >> find relying on it for NUMA balancing a bit odd).
> >
> > Arguably it ought to perhaps be one of those node_reclaim_distance
> > things. The thing is that NUMA-1 is often fairly quick, esp. these days
> > where it's basically on die numa.

To conserve the current behavior the NUMA level would need to have
SD_SPREAD_TASKS. It will be cleared along with SD_BALANCE_{EXEC, FORK} and
SD_WAKE_AFFINE if the numa distance is larger than node_reclaim_distance,
yes?

Thanks and BR,
Ricardo

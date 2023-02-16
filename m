Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8CD698B8E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 06:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjBPFLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 00:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBPFLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 00:11:16 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D94C3CE2F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676524275; x=1708060275;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lNpZwY5k1fsJ7ohV4PumgaRLkPrWvdHzqXcI/gOW7Fk=;
  b=Wv+jm4ij8xPW+E8v7hTGAyqJW65/+pK7u7o8vr43lX95WxV9xM3jj0RT
   92Iuffc/UR6Hn0Gu3uoqU4xNBfaaS8NvwSgqpI4L7/Z+V7ONOlY9RXosN
   F9ua8RVxDLgUcFl4pi+B/LEeF1xbeASkIMmqLghMiVw7PsXbFEtQM7rgR
   AiSXo9Xt61FOPNUUTc5nmD+Z6uZA78e2kUW/rRSk2O+0EAtvpulv5Bf1V
   jfdTK7EOc4cVYYO+6NThqhF1IoBdTRVDiP6awyPkwYGI9wOWyltW/xlbZ
   WDGlHiY37C+CLhRBeoopmnQoC6jE+5wAtagSD5G7XGKy+es7FznP3RjEV
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="315301315"
X-IronPort-AV: E=Sophos;i="5.97,301,1669104000"; 
   d="scan'208";a="315301315"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 21:11:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="619870333"
X-IronPort-AV: E=Sophos;i="5.97,301,1669104000"; 
   d="scan'208";a="619870333"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga003.jf.intel.com with ESMTP; 15 Feb 2023 21:11:09 -0800
Date:   Wed, 15 Feb 2023 21:21:05 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Valentin Schneider <vschneid@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [PATCH v3 06/10] sched/fair: Use the prefer_sibling flag of the
 current sched domain
Message-ID: <20230216052105.GA20785@ranerica-svr.sc.intel.com>
References: <20230207045838.11243-1-ricardo.neri-calderon@linux.intel.com>
 <20230207045838.11243-7-ricardo.neri-calderon@linux.intel.com>
 <Y+YXrk5NRuWaSOGR@hirez.programming.kicks-ass.net>
 <xhsmhmt5lr2nz.mognet@vschneid.remote.csb>
 <Y+Z2b/OtZDk9cT53@hirez.programming.kicks-ass.net>
 <xhsmhk00pqwap.mognet@vschneid.remote.csb>
 <20230210183155.GA11997@ranerica-svr.sc.intel.com>
 <8300f288-7157-5e2d-3bb3-badcffd15d34@arm.com>
 <20230214064328.GA11859@ranerica-svr.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214064328.GA11859@ranerica-svr.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 10:43:28PM -0800, Ricardo Neri wrote:
> On Mon, Feb 13, 2023 at 01:17:09PM +0100, Dietmar Eggemann wrote:
> > On 10/02/2023 19:31, Ricardo Neri wrote:
> > > On Fri, Feb 10, 2023 at 05:12:30PM +0000, Valentin Schneider wrote:
> > >> On 10/02/23 17:53, Peter Zijlstra wrote:
> > >>> On Fri, Feb 10, 2023 at 02:54:56PM +0000, Valentin Schneider wrote:
> > >>>
> > >>>> So something like have SD_PREFER_SIBLING affect the SD it's on (and not
> > >>>> its parent), but remove it from the lowest non-degenerated topology level?
> > >>>
> > >>> So I was rather confused about the whole moving it between levels things
> > >>> this morning -- conceptually, prefer siblings says you want to try
> > >>> sibling domains before filling up your current domain. Now, balancing
> > >>> between siblings happens one level up, hence looking at child->flags
> > >>> makes perfect sense.
> > >>>
> > >>> But looking at the current domain and still calling it prefer sibling
> > >>> makes absolutely no sense what so ever.
> > >>>
> > >>
> > >> True :-)
> > >>
> > >>> In that confusion I think I also got the polarity wrong, I thought you
> > >>> wanted to kill prefer_sibling for the assymetric SMT cases, instead you
> > >>> want to force enable it as long as there is one SMT child around.
> > > 
> > > Exactly.
> > > 
> > >>>
> > >>> Whichever way around it we do it, I'm thinking perhaps some renaming
> > >>> might be in order to clarify things.
> > >>>
> > >>> How about adding a flag SD_SPREAD_TASKS, which is the effective toggle
> > >>> of the behaviour, but have it be set by children with SD_PREFER_SIBLING
> > >>> or something.
> > >>>
> > >>
> > >> Or entirely bin SD_PREFER_SIBLING and stick with SD_SPREAD_TASKS, but yeah
> > >> something along those lines.
> > > 
> > > I sense a consesus towards SD_SPREAD_TASKS.
> > 
> > Can you not detect the E-core dst_cpu case on MC with:
> > 
> > +       if (child)
> > +               sds->prefer_sibling = child->flags & SD_PREFER_SIBLING;
> > +       else if (sds->busiest)
> > +               sds->prefer_sibling = sds->busiest->group_weight > 1;
> 
> Whose child wants the prefer_sibling setting? In update_sd_lb_stats(), it
> is set based on the flags of the destination CPU's sched domain. But when
> used in find_busiest_group() tasks are spread from the busiest group's
> child domain.
> 
> Your proposed code, also needs a check for SD_PREFER_SIBLING, no?

I tweaked the solution that Dietmar proposed:

-	sds->prefer_sibling = child && child->flags & SD_PREFER_SIBLING;
+	if (sds->busiest)
+		sds->prefer_sibling = sds->busiest->flags & SD_PREFER_SIBLING;

This comes from the observation that the prefer_sibling setting acts on
busiest group. It then depends on whether the busiest group, not the local
group, has child sched sched domains. Today it works because in most cases
both the local and the busiest groups have child domains with the SD_
PREFER_SIBLING flag.

This would also satisfy sched domains with the SD_ASYM_CPUCAPACITY flag as
prefer_sibling would not be set in that case.

It would also conserve the current behavior at the NUMA level. We would
not need to implement SD_SPREAD_TASKS.

This would both fix the SMT vs non-SMT bug and be less invasive.

Thoughts?

Thanks and BR,
Ricardo

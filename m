Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9526A1C09
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 13:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjBXMTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 07:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjBXMTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 07:19:03 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B2963A11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 04:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677241138; x=1708777138;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8d8p7PuMREJ+HiAtxqekG9lFLSEEVPGv9lxV26sp4wc=;
  b=Fivt4T6dML+HYVV9f0YvKV3tVwU0ojadTT74YQ9VoFV+SRFolZ8PVWIp
   O3fOM7tXYmgs/C9DpgGlzkz1Rwwmuih1YROAiGVfi/2dYojgJpHU7wMY4
   Teyy08VA93Ji7Djgbjnra/7mqLIzfMIACSPu+dtTgiegrYjQENTEvlE1q
   XG5joSf7eTGmV/cYWYIFhni8ZcRQEezzuWs+EHhxFoztQlMFwRKOqdAYi
   DTF6Ku17il3J7aAkCf31nQvHhomOpvtXdpMRca15OkNqfPyN2e67JYYmv
   E0o0iAA2HsdtDCQ6d0xzsd1MO3dXwK36sf1guVcpShUgb5xc0dzQEdSiZ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="360966410"
X-IronPort-AV: E=Sophos;i="5.97,324,1669104000"; 
   d="scan'208";a="360966410"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 04:18:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="736782075"
X-IronPort-AV: E=Sophos;i="5.97,324,1669104000"; 
   d="scan'208";a="736782075"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga008.fm.intel.com with ESMTP; 24 Feb 2023 04:18:58 -0800
Date:   Fri, 24 Feb 2023 04:29:00 -0800
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
Message-ID: <20230224122900.GA12626@ranerica-svr.sc.intel.com>
References: <20230207045838.11243-7-ricardo.neri-calderon@linux.intel.com>
 <Y+YXrk5NRuWaSOGR@hirez.programming.kicks-ass.net>
 <xhsmhmt5lr2nz.mognet@vschneid.remote.csb>
 <Y+Z2b/OtZDk9cT53@hirez.programming.kicks-ass.net>
 <xhsmhk00pqwap.mognet@vschneid.remote.csb>
 <20230210183155.GA11997@ranerica-svr.sc.intel.com>
 <8300f288-7157-5e2d-3bb3-badcffd15d34@arm.com>
 <20230214064328.GA11859@ranerica-svr.sc.intel.com>
 <20230216052105.GA20785@ranerica-svr.sc.intel.com>
 <183aec1b-5626-e972-bbed-aca038280828@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <183aec1b-5626-e972-bbed-aca038280828@arm.com>
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

On Thu, Feb 23, 2023 at 11:09:55AM +0100, Dietmar Eggemann wrote:
> On 16/02/2023 06:21, Ricardo Neri wrote:
> > On Mon, Feb 13, 2023 at 10:43:28PM -0800, Ricardo Neri wrote:
> >> On Mon, Feb 13, 2023 at 01:17:09PM +0100, Dietmar Eggemann wrote:
> >>> On 10/02/2023 19:31, Ricardo Neri wrote:
> >>>> On Fri, Feb 10, 2023 at 05:12:30PM +0000, Valentin Schneider wrote:
> >>>>> On 10/02/23 17:53, Peter Zijlstra wrote:
> >>>>>> On Fri, Feb 10, 2023 at 02:54:56PM +0000, Valentin Schneider wrote:
> 
> [...]
> 
> >>> Can you not detect the E-core dst_cpu case on MC with:
> >>>
> >>> +       if (child)
> >>> +               sds->prefer_sibling = child->flags & SD_PREFER_SIBLING;
> >>> +       else if (sds->busiest)
> >>> +               sds->prefer_sibling = sds->busiest->group_weight > 1;
> >>
> >> Whose child wants the prefer_sibling setting? In update_sd_lb_stats(), it
> >> is set based on the flags of the destination CPU's sched domain. But when
> >> used in find_busiest_group() tasks are spread from the busiest group's
> >> child domain.
> >>
> >> Your proposed code, also needs a check for SD_PREFER_SIBLING, no?
> > 
> > I tweaked the solution that Dietmar proposed:
> > 
> > -	sds->prefer_sibling = child && child->flags & SD_PREFER_SIBLING;
> > +	if (sds->busiest)
> > +		sds->prefer_sibling = sds->busiest->flags & SD_PREFER_SIBLING;
> 
> Maybe:
> 
> sds->prefer_sibling = !!(sds->busiest->flags & SD_PREFER_SIBLING);
> 
> 1 vs 2048 ?

Sure, I can do this.
> 
> > This comes from the observation that the prefer_sibling setting acts on
> > busiest group. It then depends on whether the busiest group, not the local
> > group, has child sched sched domains. Today it works because in most cases
> > both the local and the busiest groups have child domains with the SD_
> > PREFER_SIBLING flag.
> > 
> > This would also satisfy sched domains with the SD_ASYM_CPUCAPACITY flag as
> > prefer_sibling would not be set in that case.
> > 
> > It would also conserve the current behavior at the NUMA level. We would
> > not need to implement SD_SPREAD_TASKS.
> > 
> > This would both fix the SMT vs non-SMT bug and be less invasive.
> 
> Yeah, much better! I always forget that we have those flags on SGs now
> as well. Luckily, we just need to check busiest sg to cover all cases.

Right. I can add a comment to clarify from where the flags come.


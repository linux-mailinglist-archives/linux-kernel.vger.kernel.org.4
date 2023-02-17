Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C6569A36A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 02:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjBQBcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 20:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBQBcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 20:32:00 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7765958285
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 17:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676597513; x=1708133513;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Pxboqbk3Zp/gidLmdCei4kYyZJi4o5g3C0h+ol5+2i4=;
  b=jJaNFaBLbCGGRMEExSelb3M4CRMlb1OjSDqh0MUer3BNax2f3G17tHk+
   4bkgSUn+WKmMmrrFT+/kLhVUyQa+V76seobdrZ+mSuN3i4UXPZCZ0WrPE
   BRWUOE+gpcP47n/8zn7KcFxIgDnKY6tjnTdfvkO04buCoqsIUjU8z8rfl
   hHLDQjxxuwW462jiVHzx9iaNa11T+KQDbKD40C7GCckLv99fAJPYWa/Z8
   YY+Na+X6ViIr8A/dyFYX14Cf1wrpZVIdtqYPZ/2vuYmq/5jkyZYltqmYr
   2XVXGKFaL8MxK8vzZbfFNG0dHtgsQCsxGOg+1x73hbLNbpwFek7QEyLTP
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="311518188"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="311518188"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 17:31:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="647927379"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="647927379"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga006.jf.intel.com with ESMTP; 16 Feb 2023 17:31:52 -0800
Date:   Thu, 16 Feb 2023 17:41:48 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
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
Message-ID: <20230217014148.GA1662@ranerica-svr.sc.intel.com>
References: <20230207045838.11243-7-ricardo.neri-calderon@linux.intel.com>
 <Y+YXrk5NRuWaSOGR@hirez.programming.kicks-ass.net>
 <xhsmhmt5lr2nz.mognet@vschneid.remote.csb>
 <Y+Z2b/OtZDk9cT53@hirez.programming.kicks-ass.net>
 <xhsmhk00pqwap.mognet@vschneid.remote.csb>
 <20230210183155.GA11997@ranerica-svr.sc.intel.com>
 <8300f288-7157-5e2d-3bb3-badcffd15d34@arm.com>
 <20230214064328.GA11859@ranerica-svr.sc.intel.com>
 <20230216052105.GA20785@ranerica-svr.sc.intel.com>
 <Y+4eqmq22fDuFZAJ@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+4eqmq22fDuFZAJ@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 01:16:42PM +0100, Peter Zijlstra wrote:
> On Wed, Feb 15, 2023 at 09:21:05PM -0800, Ricardo Neri wrote:
> 
> > I tweaked the solution that Dietmar proposed:
> > 
> > -	sds->prefer_sibling = child && child->flags & SD_PREFER_SIBLING;
> > +	if (sds->busiest)
> > +		sds->prefer_sibling = sds->busiest->flags & SD_PREFER_SIBLING;
> > 
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
> > 
> > Thoughts?
> 
> That does look nice. Be sure to put in a nice comment too.

Will do!

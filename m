Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A294B695935
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 07:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjBNGdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 01:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjBNGdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 01:33:38 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C7D46A2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 22:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676356415; x=1707892415;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Oq31jUnisAa7v8rq3U4KjSaAnVwZc1DoTUEp9Tphk90=;
  b=bYD0GBGDDVOc9NDvS+F8tQe3n0uP0whRWD44WTN6Ma7pa0Ia5ZHKnZxu
   bVyBPZZ3zUOXzp5bpCQQk+ulZcGc0SDz6kepdsbWqLDdLh/P47mGkUOsC
   BAzR+eKSQb8KfIf/uNVOrdq1zh6xOPCJnWV7xYbtGXteBVtgGANbK1wPi
   sFywwqJPOZUNUPfAKKhfKVy8yM1VQ5oB27qc+l1qMUNC2cCdwpzr/Fotf
   lQ/eewvajr2CuHYQ8SnOhaiX4G5uNXA6mCVmrUtNqSpZ82Cr6ZUbD9ZBc
   KxdJM1Y/mKXAcr+ZEpXCgySj9khB8OG6ceIAuWbhB7lzUXGZG7yPw4++J
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="314734776"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="314734776"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 22:33:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="662448368"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="662448368"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga007.jf.intel.com with ESMTP; 13 Feb 2023 22:33:34 -0800
Date:   Mon, 13 Feb 2023 22:43:28 -0800
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
Message-ID: <20230214064328.GA11859@ranerica-svr.sc.intel.com>
References: <20230207045838.11243-1-ricardo.neri-calderon@linux.intel.com>
 <20230207045838.11243-7-ricardo.neri-calderon@linux.intel.com>
 <Y+YXrk5NRuWaSOGR@hirez.programming.kicks-ass.net>
 <xhsmhmt5lr2nz.mognet@vschneid.remote.csb>
 <Y+Z2b/OtZDk9cT53@hirez.programming.kicks-ass.net>
 <xhsmhk00pqwap.mognet@vschneid.remote.csb>
 <20230210183155.GA11997@ranerica-svr.sc.intel.com>
 <8300f288-7157-5e2d-3bb3-badcffd15d34@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8300f288-7157-5e2d-3bb3-badcffd15d34@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 01:17:09PM +0100, Dietmar Eggemann wrote:
> On 10/02/2023 19:31, Ricardo Neri wrote:
> > On Fri, Feb 10, 2023 at 05:12:30PM +0000, Valentin Schneider wrote:
> >> On 10/02/23 17:53, Peter Zijlstra wrote:
> >>> On Fri, Feb 10, 2023 at 02:54:56PM +0000, Valentin Schneider wrote:
> >>>
> >>>> So something like have SD_PREFER_SIBLING affect the SD it's on (and not
> >>>> its parent), but remove it from the lowest non-degenerated topology level?
> >>>
> >>> So I was rather confused about the whole moving it between levels things
> >>> this morning -- conceptually, prefer siblings says you want to try
> >>> sibling domains before filling up your current domain. Now, balancing
> >>> between siblings happens one level up, hence looking at child->flags
> >>> makes perfect sense.
> >>>
> >>> But looking at the current domain and still calling it prefer sibling
> >>> makes absolutely no sense what so ever.
> >>>
> >>
> >> True :-)
> >>
> >>> In that confusion I think I also got the polarity wrong, I thought you
> >>> wanted to kill prefer_sibling for the assymetric SMT cases, instead you
> >>> want to force enable it as long as there is one SMT child around.
> > 
> > Exactly.
> > 
> >>>
> >>> Whichever way around it we do it, I'm thinking perhaps some renaming
> >>> might be in order to clarify things.
> >>>
> >>> How about adding a flag SD_SPREAD_TASKS, which is the effective toggle
> >>> of the behaviour, but have it be set by children with SD_PREFER_SIBLING
> >>> or something.
> >>>
> >>
> >> Or entirely bin SD_PREFER_SIBLING and stick with SD_SPREAD_TASKS, but yeah
> >> something along those lines.
> > 
> > I sense a consesus towards SD_SPREAD_TASKS.
> 
> Can you not detect the E-core dst_cpu case on MC with:
> 
> +       if (child)
> +               sds->prefer_sibling = child->flags & SD_PREFER_SIBLING;
> +       else if (sds->busiest)
> +               sds->prefer_sibling = sds->busiest->group_weight > 1;

Whose child wants the prefer_sibling setting? In update_sd_lb_stats(), it
is set based on the flags of the destination CPU's sched domain. But when
used in find_busiest_group() tasks are spread from the busiest group's
child domain.

Your proposed code, also needs a check for SD_PREFER_SIBLING, no?

Thanks and BR,
Ricardo

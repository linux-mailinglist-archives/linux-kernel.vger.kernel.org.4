Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07394691F5C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 13:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjBJM4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 07:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbjBJM4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 07:56:13 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3946BD17
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 04:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676033772; x=1707569772;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y8zxgGCwhMDmV7vaqtoKzlagEvVdPgNTwWyjOM6v9qo=;
  b=UyoQIRsWYM/b2Rxjuw33GNcKJPzsz4X4npvmRVgvAGMHDjAq1VXNbYJe
   5YM8ytKZh5Puma/UY/fohfn1+Zpd/2rNjiSke5FvnzfaUo13quPE3c8hj
   Nac51WlTXhIVQV/AhxeiEVooorVyeQn2UPkoW3y93um9zi9FS2crn7RW5
   EvfAEgdWP2UX8wOrPzmut78mxm/cpmU8+jH8HHmOnQ3tuq3NTuUZbXAPx
   mIKxaz36Glz+n16G+Pl08PrfqgfIlDGtfGnGOHd97V6ClBU4V/AkmuHQ2
   3mobb+AxhRywyK19DIWyT/3kNkef1yHLTyPUVK79plsFFj2u5ZfcU15G6
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="329043683"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="329043683"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 04:56:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="776913014"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="776913014"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga002.fm.intel.com with ESMTP; 10 Feb 2023 04:56:11 -0800
Date:   Fri, 10 Feb 2023 05:05:56 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
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
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [PATCH v3 04/10] sched/fair: Let low-priority cores help
 high-priority busy SMT cores
Message-ID: <20230210130556.GA8447@ranerica-svr.sc.intel.com>
References: <20230207045838.11243-1-ricardo.neri-calderon@linux.intel.com>
 <20230207045838.11243-5-ricardo.neri-calderon@linux.intel.com>
 <CAKfTPtB_YR8e6fcx3Un0vTeJR4EJS9sOXG=wLb8rZeM5Ub4yyA@mail.gmail.com>
 <Y+TexehP3140vxBu@hirez.programming.kicks-ass.net>
 <20230210004333.GA6166@ranerica-svr.sc.intel.com>
 <Y+YDKpHLDkYOTVWL@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+YDKpHLDkYOTVWL@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 09:41:14AM +0100, Peter Zijlstra wrote:
> On Thu, Feb 09, 2023 at 04:43:33PM -0800, Ricardo Neri wrote:
> > On Thu, Feb 09, 2023 at 12:53:41PM +0100, Peter Zijlstra wrote:
> > > On Wed, Feb 08, 2023 at 08:56:32AM +0100, Vincent Guittot wrote:
> > > 
> > > > > +                       if (env->sd->flags & SD_SHARE_CPUCAPACITY ||
> > > > > +                           (!(env->sd->flags & SD_SHARE_CPUCAPACITY) && is_core_idle(i)))
> > > > 
> > > > This 2nd if could be merged with the upper one
> > > 
> > > Wasn't this exact same condition used in the previous patch as well?
> > > Does it wants to be a helper perhaps?
> > 
> > Patch 3 focuses on the destination CPU: make sure that it and its SMT
> > siblings are idle before attempting to do asym_packing balance.
> > 
> > This patch focuses on the busiest group: if the busiest group is an SMT
> > core with more than one busy sibling, help it even if it has higher
> > priority.
> 
> Yeah, so? If its a recurring expression a helper never hurts.

Ah! I get your point now. You meant a helper function. Thank you for the
clarification.

Sure! I can add this helper function.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B645660550E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 03:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbiJTBdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 21:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiJTBdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 21:33:40 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8FE1CCCF6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 18:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666229595; x=1697765595;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3TWfkFijWobPTbBAEdvWB/0FOf/yukufQ16pggx26G0=;
  b=bmZ7RQn8HtsMUIBBhzU/i+2zNH+6VJhWzKSLQK8EfD9WmvojyTHCBrX0
   hSUf7xVXb/Do/UEJeFnVy1jtmhQVEXCQex3scKnuEYkZob9egpseiyo0q
   UW6w+CSoeU/5yaODljzRxTq4XbQ1OBvD/EGcZdwNibeqesWIhKjqL0HXe
   r9YWitEXPy2YNJYEF8Hka5ArW4Vij8/Q4FPzQGAT3Kx9gg4a7kNR/NO5I
   Jb+//tPYDqaTGoYErWUbmYSZh+FE2dnW7EMn635w1lCYAhER7c1TrTQRv
   xplIDH4DKP7PQCH1szi+bl/lFD2Ao4xjsjLlB37zPcFjFyUJ3i/9q/F27
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="333140384"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="333140384"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 18:31:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="662748151"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="662748151"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga001.jf.intel.com with ESMTP; 19 Oct 2022 18:31:30 -0700
Date:   Wed, 19 Oct 2022 18:38:20 -0700
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
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] sched/fair: Avoid unnecessary migrations within SMT
 domains
Message-ID: <20221020013820.GB20255@ranerica-svr.sc.intel.com>
References: <20220825225529.26465-1-ricardo.neri-calderon@linux.intel.com>
 <20221018023527.GB23064@ranerica-svr.sc.intel.com>
 <Y050e5XQkaUrwr5j@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y050e5XQkaUrwr5j@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 11:40:11AM +0200, Peter Zijlstra wrote:
> On Mon, Oct 17, 2022 at 07:35:27PM -0700, Ricardo Neri wrote:
> > On Thu, Aug 25, 2022 at 03:55:25PM -0700, Ricardo Neri wrote:
> > > Intel processors that support Intel Turbo Boost Max 3.0 use asym_packing
> > > to assign higher priorities to CPUs with higher maximum frequencies. It
> > > artificially assigns, however, a lower priority to the higher-numbered
> > > SMT siblings to ensure that they are used last.
> > > 
> > > This results in unnecessary task migrations within the SMT domains.
> > > 
> > > On processors with a mixture of higher-frequency SMT cores and lower-
> > > frequency non-SMT cores (such as Intel hybrid processors), a lower-
> > > priority CPU pulls tasks from the higher-priority cores if more than one
> > > SMT sibling is busy.
> > > 
> > > Do not use different priorities for each SMT sibling. Instead, tweak the
> > > asym_packing load balancer to recognize SMT cores with more than one
> > > busy sibling and let lower-priority CPUs pull tasks.
> > > 
> > > Removing these artificial priorities avoids superfluous migrations and
> > > lets lower-priority cores inspect all SMT siblings for the busiest queue.
> > 
> > Hello. I'd like to know if there are any comments on these patches. This
> > patchset is a requisite for the IPC classes of tasks patchset [1].

Thank you very much for your feedback Peter!

> 
> Urgh.. so I'm not liking this, afaict you're sprinkling SMT2
> assumptions.

I was careful to not introduce this assumption. I always look for one or
more busy SMT siblings. The goal of the series use the same priority for
all SMT siblings when possible (in x86 but not in Power7) so that lower-
priority sched groups can pull tasks from either siblings when needed (as
in [1]).

> 
> Why can't we make arch_asym_cpu_priority() depend on CPU state? Doesn't
> it then magically work?

That is an interesting idea. I will experiment with it.

Thanks and BR,
Ricardo

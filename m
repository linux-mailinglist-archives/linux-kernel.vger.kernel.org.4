Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1310E64A992
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 22:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbiLLVeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 16:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbiLLVeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 16:34:00 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C063B63EA;
        Mon, 12 Dec 2022 13:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670880839; x=1702416839;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6g+nJ9xvo8cwu5PEAdWzY2kdOBYFu9N983QpNMGg6Cc=;
  b=ImX9lxUrf8h/2o7KZdbZKEdBlzJ6ddA/i76WlgI3iqwlQSHxzYde6Pnz
   lbsfE0fcsJF2C6nb/U1zXotAYos5/4GLwBMFbuwXQT/1H3dtBW4vAPrjN
   g2SG8kBlxAtWNPwbO+pPwJuRI7po0OJRcPJu3R0OaBK/RpOqQAfkIVU3B
   4mRdkisEDGtuSlKoPOymQYO/p/7OZ6iRWx5xC4AuoPXntbrUvJfKOIqNT
   jkmRvVqDtC9DJc90cB1qs41UiOzM3dKrgI1jIVa2HxvFXCTPg+Xphm+Pa
   MlYOn9ZR+w2ONNrbw1kQ/MUH42Cc9VKJL/SGDPPt2+YRVDm6nauIYCXTe
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="319111292"
X-IronPort-AV: E=Sophos;i="5.96,239,1665471600"; 
   d="scan'208";a="319111292"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 13:33:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="626049352"
X-IronPort-AV: E=Sophos;i="5.96,239,1665471600"; 
   d="scan'208";a="626049352"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga006.jf.intel.com with ESMTP; 12 Dec 2022 13:33:48 -0800
Date:   Mon, 12 Dec 2022 13:41:52 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
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
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [PATCH v2 06/22] sched/fair: Collect load-balancing stats for
 IPC classes
Message-ID: <20221212214152.GF27353@ranerica-svr.sc.intel.com>
References: <20221128132100.30253-1-ricardo.neri-calderon@linux.intel.com>
 <20221128132100.30253-7-ricardo.neri-calderon@linux.intel.com>
 <71a0f27d-68e0-f118-c117-bae48f5f1996@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71a0f27d-68e0-f118-c117-bae48f5f1996@arm.com>
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

On Wed, Dec 07, 2022 at 06:00:32PM +0100, Dietmar Eggemann wrote:
> On 28/11/2022 14:20, Ricardo Neri wrote:
> 
> [...]
> 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 224107278471..3a1d6c50a19b 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -9100,6 +9100,57 @@ group_type group_classify(unsigned int imbalance_pct,
> >  	return group_has_spare;
> >  }
> >  
> > +struct sg_lb_ipcc_stats {
> > +	int min_score;	/* Min(score(rq->curr->ipcc)) */
> > +	int min_ipcc;	/* Min(rq->curr->ipcc) */
> > +	long sum_score; /* Sum(score(rq->curr->ipcc)) */
> > +};
> 
> Wouldn't it be cleaner to put `min_score`, `min_ipcc` and `sum_score`
> into `struct sg_lb_stats` next to `ipcc_score_{after, before}` under the
> same #ifdef CONFIG_IPC_CLASSES?

Yes, that is a good observation. I initially wanted to hide these
intermediate and only expose the end result ipcc_score_{after, before} to
struct sg_lb_stats. I agree, it would look cleaner as you suggest.
> 
> Looks like those IPCC stats would only be needed in the specific
> condition under which update_sg_lb_stats_scores() is called?

True.

> 
> > +#ifdef CONFIG_IPC_CLASSES
> > +static void init_rq_ipcc_stats(struct sg_lb_ipcc_stats *sgcs)
> > +{
> > +	*sgcs = (struct sg_lb_ipcc_stats) {
> > +		.min_score = INT_MAX,
> > +	};
> > +}
> > +
> > +/** Called only if cpu_of(@rq) is not idle and has tasks running. */
> > +static void update_sg_lb_ipcc_stats(struct sg_lb_ipcc_stats *sgcs,
> > +				    struct rq *rq)
> > +{
> > +	struct task_struct *curr;
> > +	unsigned short ipcc;
> > +	int score;
> > +
> > +	if (!sched_ipcc_enabled())
> > +		return;
> > +
> > +	curr = rcu_dereference(rq->curr);
> > +	if (!curr || (curr->flags & PF_EXITING) || is_idle_task(curr))
> 
> So the Idle task is excluded but RT, DL, (Stopper) tasks are not. Looks
> weird if non-CFS tasks could influence CFS load-balancing.
> AFAICS, RT and DL tasks could have p->ipcc != IPC_CLASS_UNCLASSIFIED?

Agreed. Perhaps I can also check for !(task_is_realtime()), which see
seems to cover all these cases.
> 
> [...]

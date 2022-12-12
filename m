Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1267264A627
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 18:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbiLLRrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 12:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbiLLRqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 12:46:54 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E3B13E99
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 09:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670867211; x=1702403211;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jsHCgo5maHdrr1Hcr1Uc9KRbzNQJfxFdzh098B2U1Oc=;
  b=WE6luEiz44xF55XjJaIaHdXuoSLFfXkS6LoY0iWDv9y6uGd4eTy0kOCl
   c0W6dbAYq4EZy+ZMGjoXGcLXQAuD1yogczY1vgDQ6n15c5laCiAnGb7aM
   F7BtTRWa0FfLReQVmTb8i3/rCZ1Q2Hs7yk9MdYPEDFpH8xxQqvW7X90JU
   zPXgYklVwcFT5Vcn+rnEvQSewnEMW27oDxOHpah+zK9ZRkRzSHHs0BR5h
   aPilhnEo0ShLOMcKJ2LhWlu9zxIumdeVBs+Jbhq8oBOLgZtjvnZ1OFyD3
   4vipmLs5zM49rFJtE+Xrlv3j8vBk3rE7XexX87PdFKtCWMpIGq+jKCp8l
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="317948249"
X-IronPort-AV: E=Sophos;i="5.96,239,1665471600"; 
   d="scan'208";a="317948249"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 09:46:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="822569464"
X-IronPort-AV: E=Sophos;i="5.96,239,1665471600"; 
   d="scan'208";a="822569464"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga005.jf.intel.com with ESMTP; 12 Dec 2022 09:46:50 -0800
Date:   Mon, 12 Dec 2022 09:54:58 -0800
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
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [PATCH v2 4/7] sched/fair: Introduce sched_smt_siblings_idle()
Message-ID: <20221212175458.GC27353@ranerica-svr.sc.intel.com>
References: <20221122203532.15013-1-ricardo.neri-calderon@linux.intel.com>
 <20221122203532.15013-5-ricardo.neri-calderon@linux.intel.com>
 <75ba5884-63c0-5180-00b8-e9764306a83e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75ba5884-63c0-5180-00b8-e9764306a83e@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 07:03:37PM +0100, Dietmar Eggemann wrote:
> On 22/11/2022 21:35, Ricardo Neri wrote:
> > Architectures that implement arch_asym_cpu_priority() may need to know the
> > idle state of the SMT siblings of a CPU. The scheduler has this information
> > and functionality. Expose it.
> > 
> > Move the existing functionality outside of the NUMA code.
> 
> [...]
> 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 0e4251f83807..9517c48df50e 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -1052,6 +1052,28 @@ update_stats_curr_start(struct cfs_rq *cfs_rq, struct sched_entity *se)
> >   * Scheduling class queueing methods:
> >   */
> >  
> > +static inline bool is_core_idle(int cpu)
> > +{
> > +#ifdef CONFIG_SCHED_SMT
> > +	int sibling;
> > +
> > +	for_each_cpu(sibling, cpu_smt_mask(cpu)) {
> > +		if (cpu == sibling)
> > +			continue;
> > +
> > +		if (!idle_cpu(sibling))
> > +			return false;
> > +	}
> > +#endif
> > +
> > +	return true;
> > +}
> > +
> > +bool sched_smt_siblings_idle(int cpu)
> > +{
> > +	return is_core_idle(cpu);
> > +}
> 
> Nitpick: Can we not just have one exported function for both use-cases:
> NUMA and x86 ITMT?

By adding a new function I intend to preserve the inlinig of is_core_idle()
in update_numa_stats() (via numa_idle_core(), which is also inline). Do you
think there is no value?

A downside of having the new function is that now the code is duplicated
in update_numa_stats() and sched_smt_siblings_idle().

I can take your suggestion if losing the inline is OK.

Thanks and BR,
Ricardo

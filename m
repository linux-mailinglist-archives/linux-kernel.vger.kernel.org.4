Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA6664A623
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 18:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbiLLRqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 12:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiLLRq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 12:46:29 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5312E13E8B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 09:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670867188; x=1702403188;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=afIynkK3XdPDB68PgKvZAMCEcWEAEYRGQhKxXaE9LO4=;
  b=EMN7Nqe/JolV1HsB/qFt+K/XQ04H579hiOpxurAlTQ3fwgCcrinKidrA
   RpWUNd5NyxTcyWulnSa5NWOKCsoWx3MHpusAGi4voirAcbcVstKv20C1e
   0XXtFe7j9uUiiEwL8cuZI34eCDjuhJn1fUj7mNfncMHiaEA8WnRWAsmgT
   fmT2sHPeIvXr/eC0Ody12vdJ4px8OkhsU9mFwGIqzTwH6zMOnepTcqERQ
   kDXgyWwa9lWS2sy94+4rPxgJvc6eENoYBkyoxHJiZcvpxoCr5OFil88Gh
   46ubUd/5oHjYqcO12NCU1nezSyZ3p+Z2hOO8HowyCTQ4G/2zjhjNR3byt
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="305559526"
X-IronPort-AV: E=Sophos;i="5.96,239,1665471600"; 
   d="scan'208";a="305559526"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 09:46:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="650417773"
X-IronPort-AV: E=Sophos;i="5.96,239,1665471600"; 
   d="scan'208";a="650417773"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga007.fm.intel.com with ESMTP; 12 Dec 2022 09:46:26 -0800
Date:   Mon, 12 Dec 2022 09:54:33 -0800
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
Subject: Re: [PATCH v2 3/7] sched: Teach arch_asym_cpu_priority() the idle
 state of SMT siblings
Message-ID: <20221212175433.GB27353@ranerica-svr.sc.intel.com>
References: <20221122203532.15013-1-ricardo.neri-calderon@linux.intel.com>
 <20221122203532.15013-4-ricardo.neri-calderon@linux.intel.com>
 <e7d6c19b-593d-acfd-35af-73b1840be276@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7d6c19b-593d-acfd-35af-73b1840be276@arm.com>
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

On Tue, Dec 06, 2022 at 06:54:39PM +0100, Dietmar Eggemann wrote:
> On 22/11/2022 21:35, Ricardo Neri wrote:
> > Some processors (e.g., Intel processors with ITMT) use asym_packing to
> > balance load between physical cores with SMT. In such case, a core with all
> > its SMT siblings idle is more desirable than another with one or more busy
> > siblings.
> > 
> > Other processors (e.g, Power7 with SMT8) use asym_packing to balance load
> > among SMT siblings of different priority, regardless of their idle state.
> > 
> > Add a new parameter, check_smt, that architectures can use as needed.
> 
> [...]
> 
> > Changes since v1:
> >  * Introduced this patch.
> 
> [...]
> 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index d18947a9c03e..0e4251f83807 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -142,8 +142,11 @@ __setup("sched_thermal_decay_shift=", setup_sched_thermal_decay_shift);
> >  #ifdef CONFIG_SMP
> >  /*
> >   * For asym packing, by default the lower numbered CPU has higher priority.
> > + *
> > + * When doing ASYM_PACKING at the "MC" or higher domains, architectures may
> 
> There is this new CLUSTER level between SMT and MC.

This is a good catch! I will update the comment to say "domains above SMT".

> 
> > + * want to check the idle state of the SMT siblngs of @cpu.
> 
> s/siblngs/siblings
> 
> The scheduler calls sched_asym_prefer(..., true) from
> find_busiest_queue(), asym_active_balance() and nohz_balancer_kick()

In these places we are comparing two specific CPUs, of which the idle
state of its siblings impact their throughput and, in consequence, the
decision of attempt to balance load.  

In the places were sched_asym_prefer(...., false) is called we compare the
destination CPU with a CPU that bears the priority of a sched group,
regardless of the idle state of its siblings.

> even from SMT layer on !x86.

This is true, but the default arch_asym_cpu_priority ignores check_smt.

>  So I guess a `bool check_smt` wouldn't be
> sufficient to distinguish whether sched_smt_siblings_idle() should be
> called or not.

But it is the caller who determines whether the idle state of the SMT
siblings of @cpu may be relevant.

> To me this comment is a little bit misleading. Not an
> issue currently since there is only the x86 overwrite right now.

If my justification make sense to you, I can expand the comment to state
that the caller decides whether check_smt is needed but arch-specific
implementations are free to ignore it.

Thanks and BR,
Ricardo

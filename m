Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008C2653B68
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 05:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbiLVEqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 23:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiLVEqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 23:46:40 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A3062EA
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 20:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671684399; x=1703220399;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+Sdn0/flHJQMRLMPm4Hekc1SiqfDCg8oNHJReYgmd08=;
  b=Cs4sQAY0oOd4H1McFvHcl7EnpBokCAoKiyDNuimr3TeGgGxBsAJcvn9L
   9fPifzWphGlvsfvR8i8IJAzgog51K8wdrb4UofEHnFzAj8YtjN8jSqnbf
   /BQHbMfzIWP3h4kHYCp6k0KXj7JrddzcsHfYp6SC+UAwqacDtgLQXY2fQ
   F76pXzcjlttjpowB7w30/qotA0qCtPpnfcjgkoXE4oidqz9xX8Fjb/Pg9
   d//DtYtwHqamD2w3dlkkUuV2Mxj/Nysg3Qtz40PrlRXrLUl6T3kMxZq6x
   zB5XXAMh05v4hJAPQ6viXwneexfuyBcFFzs9KIMWAG+1F97u7MD+r4NyA
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="299714757"
X-IronPort-AV: E=Sophos;i="5.96,264,1665471600"; 
   d="scan'208";a="299714757"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 20:46:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="645074112"
X-IronPort-AV: E=Sophos;i="5.96,264,1665471600"; 
   d="scan'208";a="645074112"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga007.jf.intel.com with ESMTP; 21 Dec 2022 20:46:38 -0800
Date:   Wed, 21 Dec 2022 20:55:05 -0800
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
Message-ID: <20221222045505.GB407@ranerica-svr.sc.intel.com>
References: <20221122203532.15013-1-ricardo.neri-calderon@linux.intel.com>
 <20221122203532.15013-4-ricardo.neri-calderon@linux.intel.com>
 <e7d6c19b-593d-acfd-35af-73b1840be276@arm.com>
 <20221212175433.GB27353@ranerica-svr.sc.intel.com>
 <72ed59b5-c7e1-c425-d1b6-e8d703d11d7a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72ed59b5-c7e1-c425-d1b6-e8d703d11d7a@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 06:12:52PM +0100, Dietmar Eggemann wrote:
> On 12/12/2022 18:54, Ricardo Neri wrote:
> > On Tue, Dec 06, 2022 at 06:54:39PM +0100, Dietmar Eggemann wrote:
> >> On 22/11/2022 21:35, Ricardo Neri wrote:
> 
> [...]
> 
> >>> + * want to check the idle state of the SMT siblngs of @cpu.
> >>
> >> s/siblngs/siblings
> >>
> >> The scheduler calls sched_asym_prefer(..., true) from
> >> find_busiest_queue(), asym_active_balance() and nohz_balancer_kick()
> > 
> > In these places we are comparing two specific CPUs, of which the idle
> > state of its siblings impact their throughput and, in consequence, the
> > decision of attempt to balance load.  
> > 
> > In the places were sched_asym_prefer(...., false) is called we compare the
> > destination CPU with a CPU that bears the priority of a sched group,
> > regardless of the idle state of its siblings.
> 
> OK.
> 
> >> even from SMT layer on !x86.
> > 
> > This is true, but the default arch_asym_cpu_priority ignores check_smt.
> 
> True.
> 
> >>  So I guess a `bool check_smt` wouldn't be
> >> sufficient to distinguish whether sched_smt_siblings_idle() should be
> >> called or not.
> > 
> > But it is the caller who determines whether the idle state of the SMT
> > siblings of @cpu may be relevant.
> 
> I assume caller being the task scheduler here.

Yes.

> Callers with `check_smt=true` can be called from any SD level with
> SD_ASYM_PACKING.

This is true.

> 
> Imagine an arch w/ SD_ASYM_PACKING on SMT & MC overwriting
> arch_asym_cpu_priority(). `bool check_smt` wouldn't be sufficient to
> know whether a call to something like sched_smt_siblings_idle()
> (is_core_idle()) which iterates over cpu_smt_mask(cpu) would make sense.

Agreed. I was hoping I could get away with this. x86 would not have the
the SD_ASYM_PACKING flag at the SMT level and Power7 would ignore
`check_smt`. :)

Callers of sched_asym_prefer() could use the flags of the sched domain to
check if we are at the SMT level.

I rescanned the code again and it looks like the needed sched domain flags
are available in all the places sched_asym_prefer() is called. The only
exception is asym_smt_can_pull_tasks(), but we already know that we don't
need such check. (We are looking for the sched group priority, regardless
of the idle state of the SMT siblings).

> 
> >> To me this comment is a little bit misleading. Not an
> >> issue currently since there is only the x86 overwrite right now.
> > 
> > If my justification make sense to you, I can expand the comment to state
> > that the caller decides whether check_smt is needed but arch-specific
> > implementations are free to ignore it.
> 
> Not a big issue but to me if the task scheduler asks for `bool
> check_smt` then archs would have to check to guarantee common behaviour.
> And the meaning of `bool check_smt` on SMT is unclear to me.
> Since only x86 would use this so far it can be adapted later for others
> if needed.

What is proposed in my previous paragraph should solve this, IMO.

Thanks and BR,
Ricardo

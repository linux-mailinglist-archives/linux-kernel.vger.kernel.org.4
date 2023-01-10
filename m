Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B9B663764
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 03:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjAJCdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 21:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjAJCdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 21:33:39 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1D318394;
        Mon,  9 Jan 2023 18:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673318018; x=1704854018;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ndVCMs9uzNJVNnhJNVDY7OYi3hWBTn11Vz73KoiJinM=;
  b=U7dyfeAoE0zuqCduOKRFH1pNySB+lxxex/Bb9hBAltBafcRAvMXErg/i
   Dx0KBfIz0dgDLXUpUFFZ4rErr6hCS4akvzvkstswkoRcvl9Mumbor1PlM
   SpZfhLcurc8cCuymwAhWBmUZpjSAKsSpVwbiaHfpYdIHQAJxCqPZCzbu0
   ENp3rBXabx0J1q6FxBvZrB6DYSxOv7JVleWTOVVXiZqlv/BXZT/e0Nq/h
   gif9tItuUHS6/XnnEr7he66fH/hE/EEz+V6mebC5ae5fLHH9dFpd9INga
   1I7YR00pmmcs552uQoCFzEx060kWU8tod1FvJTmhVWvtB5JMw3DGCkWrX
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="409289612"
X-IronPort-AV: E=Sophos;i="5.96,313,1665471600"; 
   d="scan'208";a="409289612"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 18:33:38 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="658819714"
X-IronPort-AV: E=Sophos;i="5.96,313,1665471600"; 
   d="scan'208";a="658819714"
Received: from avaratha-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.209.69.31])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 18:33:38 -0800
Message-ID: <cc9bd410208fb05fcfa32345a609fb1c6cde35d0.camel@linux.intel.com>
Subject: Re: [RFC/RFT PATCH 1/2] sched/core: Check and schedule ksoftirq
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, len.brown@intel.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Mon, 09 Jan 2023 18:33:37 -0800
In-Reply-To: <Y6ImigCet+RXzds/@hirez.programming.kicks-ass.net>
References: <20221215184300.1592872-1-srinivas.pandruvada@linux.intel.com>
         <20221215184300.1592872-2-srinivas.pandruvada@linux.intel.com>
         <Y5xURk3CkzhIjmmq@hirez.programming.kicks-ass.net>
         <20221216220748.GA1967978@lothringen>
         <Y6BMAp6A731F8ZL4@hirez.programming.kicks-ass.net>
         <5ae0d53990c29aa25648cbf32ef3b16e9bec911c.camel@linux.intel.com>
         <Y6IgPVacKInH9tgv@hirez.programming.kicks-ass.net>
         <Y6ImigCet+RXzds/@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-12-20 at 22:18 +0100, Peter Zijlstra wrote:
> On Tue, Dec 20, 2022 at 09:51:09PM +0100, Peter Zijlstra wrote:
> > On Mon, Dec 19, 2022 at 02:54:55PM -0800, srinivas pandruvada
> > wrote:
> > 
> > > But after ksoftirqd_run_end(), which will renable local irq, this
> > > may
> > > further cause more soft irq pending. Here RCU soft irq entry
> > > continues
> > 
> > Right you are.. what about if we spell the idle.c thing like so
> > instead?
> > 
> > Then we repeat the softirq thing every time we drop out of the idle
> > loop
> > for a reschedule.
> 
> Uff, that obviously can't work because we already have preemption
> disabled here, this needs a bit more work. I think it's possible to
> re-arrange things a bit.
Didn't work.
Also when __do_softirq returns, softirq can be pending again.  I think
if local_softirq_pending(), we can break do_idle() loop.

Thanks,
Srinivas

> 
> I'll try and have a look tomorrow, but the kids have their xmas play
> at
> school so who knows what I'll get done.
> 
> > diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> > index f26ab2675f7d..6dce49813bcc 100644
> > --- a/kernel/sched/idle.c
> > +++ b/kernel/sched/idle.c
> > @@ -381,8 +381,13 @@ void play_idle_precise(u64 duration_ns, u64
> > latency_ns)
> >         hrtimer_start(&it.timer, ns_to_ktime(duration_ns),
> >                       HRTIMER_MODE_REL_PINNED_HARD);
> >  
> > -       while (!READ_ONCE(it.done))
> > +       while (!READ_ONCE(it.done)) {
> > +               rt_mutex_lock(&per_cpu(ksoftirq_lock, cpu));
> > +               __run_ksoftirqd(smp_processor_id());
> > +               rt_mutex_unlock(&per_cpu(ksoftirq_lock, cpu));
> > +
> >                 do_idle();
> > +       }
> >  
> >         cpuidle_use_deepest_state(0);
> >         current->flags &= ~PF_IDLE;


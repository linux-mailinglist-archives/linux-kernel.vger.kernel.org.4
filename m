Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22A360DA0A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 05:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbiJZDw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 23:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbiJZDwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 23:52:25 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C391359E86
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 20:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666756344; x=1698292344;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nlzDIMezcJmRfF6eV+9iAENW+mhx38Z712QC31mTIvw=;
  b=lFYENdeX/hh9hjo5UMZ5JDjYVK/luZEGKt9Mn7x6sswUTEBJqTkujmkq
   wzrCzB8ollG2xMN1UWKWPR5/cj1SWUz9/QGK2LzMXfhcROstugs6LhW+U
   0kdbxJz+RAzAImcMWOkyPBad/FtzkvET6hBpM1ZBeeHFd+41CMNT7z9aN
   IbemNumPPMI93KiwosfFh4L24FIW94WD2baV0CGdHUWRr7+5bT1JOXrYU
   YTQ3A/wkkIifDtdR+5RekFwX7jLdUBLI7zN/MHi7TJxTqQuQOIdBIPQ4G
   sUKO7iZ5lYimu+WSydgG16ogNvKsSQN61o6+Y2Ueghx7NwDDXgqbWw6vK
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="287569940"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="287569940"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 20:52:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="609809771"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="609809771"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga006.jf.intel.com with ESMTP; 25 Oct 2022 20:52:23 -0700
Date:   Tue, 25 Oct 2022 20:59:27 -0700
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
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [RFC PATCH 12/23] thermal: intel: hfi: Convert table_lock to use
 flags-handling variants
Message-ID: <20221026035927.GC21523@ranerica-svr.sc.intel.com>
References: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
 <20220909231205.14009-13-ricardo.neri-calderon@linux.intel.com>
 <YzLfr49woc1PMOxO@hirez.programming.kicks-ass.net>
 <YzLgVckjbAAfC7jg@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzLgVckjbAAfC7jg@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 01:36:53PM +0200, Peter Zijlstra wrote:
> On Tue, Sep 27, 2022 at 01:34:07PM +0200, Peter Zijlstra wrote:
> > On Fri, Sep 09, 2022 at 04:11:54PM -0700, Ricardo Neri wrote:
> > 
> > > --- a/drivers/thermal/intel/intel_hfi.c
> > > +++ b/drivers/thermal/intel/intel_hfi.c
> > > @@ -175,9 +175,10 @@ static struct workqueue_struct *hfi_updates_wq;
> > >  static void get_hfi_caps(struct hfi_instance *hfi_instance,
> > >  			 struct thermal_genl_cpu_caps *cpu_caps)
> > >  {
> > > +	unsigned long flags;
> > >  	int cpu, i = 0;
> > >  
> > > -	raw_spin_lock_irq(&hfi_instance->table_lock);
> > > +	raw_spin_lock_irqsave(&hfi_instance->table_lock, flags);
> > >  	for_each_cpu(cpu, hfi_instance->cpus) {
> > >  		struct hfi_cpu_data *caps;
> > >  		s16 index;
> > 
> > ^^^^ Anti-pattern alert!
> > 
> > Now your IRQ latency depends on nr_cpus -- which is a fair fail. The
> > existing code is already pretty crap in that it has the preemption
> > latency depend on nr_cpus.
> > 
> > While I'm here looking at the HFI stuff, did they fix that HFI interrupt
> > broadcast mess already? Sending an interrupt to *all* CPUs is quite
> > insane.
> 
> Anyway; given the existence of this here loop; why not have something
> like:
> 
> DEFINE_PER_CPU(int, hfi_ipc_class);
> 
> 	class = // extract from HFI mess
> 	WRITE_ONCE(per_cpu(hfi_ipc_class, cpu), class);
> 
> And then have the tick use this_cpu_read(hfi_ipc_class)? No extra
> locking required.

Thanks Peter. I think this is a good solution. I will implement it.

BR,
Ricardo

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45276659395
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 01:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbiL3AIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 19:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiL3AIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 19:08:45 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162DB12AEB
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 16:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672358925; x=1703894925;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TLSD84xLrq3E7FpU/gYbFvY8XOJNRklPCdivllK4z7A=;
  b=Tm6lw3IilztQOKgrQ5nmbw5b3w06tejyjCsjwPhHPGqGXl35sI6cwpXg
   OPU3o5CHeCIndq04TmzyYk08Gt1iq82Se+1BTaDInECwNmX6bRHK+LsSD
   /3sxV31MlKfd5j+KJI4AyrAHhwew7LXTDfouufMlYkVb/oAVV/TXr2yWs
   eFwiYyiWdp8alg03vYgLU35vLWew+ty3+/ZTqk0jhz5kXi9i2dv33WGLv
   1k+FRf8WSQLMBYUgs5Ia0qn9NQOv/nefUuAAvZfGrGuIBmxZP7s5namEx
   WB/H55l1bpjGgcYEDy2AnK6XGnGPJIqYsbXgEgt1ZlSgnBbta7nLrLRLK
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="348343669"
X-IronPort-AV: E=Sophos;i="5.96,285,1665471600"; 
   d="scan'208";a="348343669"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 16:08:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="631389850"
X-IronPort-AV: E=Sophos;i="5.96,285,1665471600"; 
   d="scan'208";a="631389850"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga006.jf.intel.com with ESMTP; 29 Dec 2022 16:08:43 -0800
Date:   Thu, 29 Dec 2022 16:17:23 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Valentin Schneider <vschneid@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
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
        Tim Chen <tim.c.chen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [PATCH v2 4/7] sched/fair: Introduce sched_smt_siblings_idle()
Message-ID: <20221230001723.GA15109@ranerica-svr.sc.intel.com>
References: <20221122203532.15013-1-ricardo.neri-calderon@linux.intel.com>
 <20221122203532.15013-5-ricardo.neri-calderon@linux.intel.com>
 <xhsmhsfh7e5s9.mognet@vschneid.remote.csb>
 <20221224052850.GA8245@ranerica-svr.sc.intel.com>
 <Y6xg8Ir9hQ+H/+uX@chenyu5-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6xg8Ir9hQ+H/+uX@chenyu5-mobl1>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 11:29:52PM +0800, Chen Yu wrote:
> On 2022-12-23 at 21:28:50 -0800, Ricardo Neri wrote:
> > On Thu, Dec 22, 2022 at 04:56:22PM +0000, Valentin Schneider wrote:
> > > On 22/11/22 12:35, Ricardo Neri wrote:
> > > > Architectures that implement arch_asym_cpu_priority() may need to know the
> > > > idle state of the SMT siblings of a CPU. The scheduler has this information
> > > > and functionality. Expose it.
> > > >
> > > > Move the existing functionality outside of the NUMA code.
> > > >
> > > 
> > > test_idle_cores() does something similar without an iteration, did you
> > > consider using that instead?
> > 
> > IIUC, test_idle_cores() returns true if there is at least one idle core in
> > the package. In my case, I need to know the idle state of only the SMT
> > siblings of a specific CPU. Am I missing something?
> >
> I guess a similar one is select_idle_core(), but it also consider the CPU with
> SCHED_IDLE task as idle. Is CPU with SCHED_IDLE task a candidate in your
> scenario?

However, we are not looking for an idle CPU. We want to know the idle state of
the siblings of a CPU. I see that select_idle_core() uses available_idle_cpu(),
which in turn uses idle_cpu(). is_core_idle() also uses it.

As per 943d355d7fee ("sched/core: Distinguish between idle_cpu() calls based on
desired effect, introduce available_idle_cpu()") the load balancer can just
call idle_cpu().

Thanks and BR,
Ricardo

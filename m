Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776845EB377
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 23:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiIZVrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 17:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiIZVr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 17:47:28 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFFBA61EF
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 14:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664228846; x=1695764846;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5KrsFws6/eg5uAv6hHy56hUAKlUZzPPOyHoOX3dB1cw=;
  b=P9myxfqs0k0P+0Dh6hLSgsbm+2UciaIlxi5uyV+mhrleKs2BucHVnRTm
   qh+/IU7rHKt3UDL+BGNOxGpGMHgcZc9aQqE+HQZXVjrAUwhAtTbKA2hNu
   08EOj/VPAv/HAAjnM1cTJoUa1kzpbo2+A809xC/d4tFVNcCqObfYcMz3q
   CGNFbpn3TlpE/oLd/H7RtP3Gu/qDK7TQEUjbX9ejm703h+/VIQbd8r1C7
   X7QxxYjfNoDc0mqDchcw4OQCKiPnDMAv2DTEQwy4+jQsBcEuSnlT753pc
   Gtqr8zDAxpJWQWwpxZR2DwDkCSS7yyUKwl2fp1mgdF9Z9nNcuA87nJ1N4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="299870844"
X-IronPort-AV: E=Sophos;i="5.93,347,1654585200"; 
   d="scan'208";a="299870844"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 14:47:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="616569817"
X-IronPort-AV: E=Sophos;i="5.93,347,1654585200"; 
   d="scan'208";a="616569817"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga007.jf.intel.com with ESMTP; 26 Sep 2022 14:47:24 -0700
Date:   Mon, 26 Sep 2022 14:53:38 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
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
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [RFC PATCH 03/23] sched/core: Initialize the class of a new task
Message-ID: <20220926215338.GA5529@ranerica-svr.sc.intel.com>
References: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
 <20220909231205.14009-4-ricardo.neri-calderon@linux.intel.com>
 <YzG92YDyBK/0W+5u@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzG92YDyBK/0W+5u@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 02:57:29PM +0000, Joel Fernandes wrote:
> Hi Ricardo,
> 
> On Fri, Sep 09, 2022 at 04:11:45PM -0700, Ricardo Neri wrote:
> > New tasks shall start life as unclassified. They will be classified by
> > hardware when they run.
> > 
> > Cc: Ben Segall <bsegall@google.com>
> > Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: Mel Gorman <mgorman@suse.de>
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Tim C. Chen <tim.c.chen@intel.com>
> > Cc: Valentin Schneider <vschneid@redhat.com>
> > Cc: x86@kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > ---
> >  kernel/sched/core.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index ee28253c9ac0..db548c1a25ef 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -4336,6 +4336,9 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
> >  	p->se.prev_sum_exec_runtime	= 0;
> >  	p->se.nr_migrations		= 0;
> >  	p->se.vruntime			= 0;
> > +#ifdef CONFIG_SCHED_TASK_CLASSES
> > +	p->class			= TASK_CLASS_UNCLASSIFIED;
> > +#endif
> 
> I find the term 'class' very broad and unclear what kind of class (without
> further reading). So I am worried about how this generic term usage plays
> with Linux source code in the long-term (like what if someone else comes up
> with a usage of term 'class' that is unrelated to IPC.)

Thank you very much for your review Joel! Yes, class seems too generic. It is
meant to read, for instance, task_struct::class or p->class, or rq->current->
class. This should imply that we are referring to the class of a task. But yes,
I agree that it is too generic.

> 
> To that end, I was wondering if it could be renamed to p->ipc_class, and
> CONFIG_SCHED_TASK_IPC_CLASSES, or something.

This is a good suggestion. I will take it, unless others disagree.

BR,
Ricardo

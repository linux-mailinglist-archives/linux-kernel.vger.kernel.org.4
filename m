Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B905BAF74
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 16:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbiIPOfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 10:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiIPOfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 10:35:20 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCBD3AE69
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 07:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663338919; x=1694874919;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DU0ASoiYHnD2XYvJnAjTDIYjyHka9r6t0mFD1c/2KII=;
  b=dUQ188Wx6IDpm6doIr+pVwVzkwqbYFilgSJeMdEMJ1njl5C9bEPdoijz
   VD3BYb6oNiD3RjSjcCZ59vnQ8nkjZIj+PEoYhDM743XExIDPlTyUycA0Q
   3wQH1aC0sbbqErhuojPfBTlxQKZD5UY1bPIOuks6erdVBES07fgjLPSlK
   s9n8+I/uKlEPKsQd7ZSi+40kXAL1VbjDF+od2BcJ3t6KBn1Wy3oxgFcFS
   ga1tcxtscS3VHmH4hmRdeSqlCFdvcNIs9hj8XWO3xyBJISCqVkbsgWfF3
   t4Rk9ENfD5oZ0hPRavM/WZt5hfkvtdOqFHBMOlzzs7Pq98bHC/vAIL3t1
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="297726935"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="297726935"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 07:35:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="793115937"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga005.jf.intel.com with ESMTP; 16 Sep 2022 07:35:18 -0700
Date:   Fri, 16 Sep 2022 07:41:13 -0700
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
Subject: Re: [RFC PATCH 01/23] sched/task_struct: Introduce classes of tasks
Message-ID: <20220916144112.GA29395@ranerica-svr.sc.intel.com>
References: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
 <20220909231205.14009-2-ricardo.neri-calderon@linux.intel.com>
 <YyHbOqoH+V6FUY68@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyHbOqoH+V6FUY68@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 03:46:34PM +0200, Peter Zijlstra wrote:
> On Fri, Sep 09, 2022 at 04:11:43PM -0700, Ricardo Neri wrote:
> 
> >  include/linux/sched.h | 7 +++++++
> >  init/Kconfig          | 9 +++++++++
> >  2 files changed, 16 insertions(+)
> > 
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index e7b2f8a5c711..acc33dbaa47c 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -117,6 +117,8 @@ struct task_group;
> >  					 __TASK_TRACED | EXIT_DEAD | EXIT_ZOMBIE | \
> >  					 TASK_PARKED)
> >  
> > +#define TASK_CLASS_UNCLASSIFIED		-1
> 
> > +#ifdef CONFIG_SCHED_TASK_CLASSES
> > +	/* Class of task that the scheduler uses for task placement decisions */
> > +	short				class;
> > +#endif

Thanks for your feedback Peter!
> 
> You're missing a hunk for init/init_task.c for this non-zero init value.

Ah, yes. I'll add it.
> 
> Does we really have to use a signed type and non-zero init value?

At least on Intel processors, class 0 is a valid class. The scheduler needs to
have a notion of unclassified tasks and decide how to handle them, IMO.

Intel processors currently support 8-bit, unsigned classes. I doubt other
architectures will ever support more than 256 classes. Short can handle all the
possible classification values and also the unclassified case.

On the other hand, class 0 could be the default classification unless hardware
classifies differently. 0 would be special and need to be documented clearly.
This would work for Intel processors.

Thanks and BR,
Ricardo 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC8A63175A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 00:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiKTXfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 18:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiKTXfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 18:35:50 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EDB2870B
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 15:35:46 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so7615699wma.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 15:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Iuzx2Yj9BTVMbKCUWOJh6Sm9EMLl+t5LIqj46fDmcTs=;
        b=ni6wGTrz4Gr4HPb044i1emFNaAgSyKqBHE554eA8hVZu0kbHRRqzR4r6KNoKuB/sTg
         RBK3nE03uDe1ignrhry6gB5AnPU0alkHugHzTCCRJsZAYSgyhETPqTFULZt+s/2KV/iI
         7twkkLsYcTvCPrFrx0Rbs3xWTTrP5ok47NuoD+btEC8/BT//SQXT/BTsrDaNM9xgvhi9
         ILG2nfeASyG3Thd2t4EfrWLdrQFHBGvzKmDVhi1VEUrSyioIjvWNrcvGZRSgT0M5M8hH
         R91cmsp0IF44d10EKJDmO1Mg3nyBIe77D4t9sWHFYNvDOGyzHruzNLQ93vrnoLg9dyBX
         LeYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iuzx2Yj9BTVMbKCUWOJh6Sm9EMLl+t5LIqj46fDmcTs=;
        b=6PK9w30LEztmGX0RUFTqjoctJJUa/8GiOOHiTuBl0Z4ucneiy9dOrZH8Cptci/SjPj
         xVqSvLbBLLbKoPZJU/0LynCDaFn++XTt2Bc5en2FvIoRuG+U6sZpX66CeZKEGDkV782o
         XbxSfxQ4D9F4LZgDRC/DXZ/J2m+t8tktJonbQ4hzk2otkV6ifePj56lJsJj1BIltx7Xi
         c3ZW9L7aM/2zVpO+piqLHQSlIb6HRPnr1vNkwY2IFSzqlkjxb9ZHrTy87o2SkHIHlGqB
         VlkByrrf2f/TL1paJjruezvZSLNcdmM0bl3NAVpq2ssEowXN6AJr40XaRIPkfPXQbR3T
         SX+Q==
X-Gm-Message-State: ANoB5pmr/21uTlTmkdX89s/VphZY49LnNGKfVf47+ee+YjO+DPtnYHJQ
        okWulmyGieQlRTVCafNmg1fxXw==
X-Google-Smtp-Source: AA0mqf4vohM+8neL2KxqtPdegKCfGeaX/+wJ4+Oj772c++qkNldbpQMk0JpgjJ1YtFxnpyxkU0rALg==
X-Received: by 2002:a05:600c:1da2:b0:3cf:147d:ad9a with SMTP id p34-20020a05600c1da200b003cf147dad9amr10471997wms.33.1668987345411;
        Sun, 20 Nov 2022 15:35:45 -0800 (PST)
Received: from airbuntu (host86-130-134-87.range86-130.btcentralplus.com. [86.130.134.87])
        by smtp.gmail.com with ESMTPSA id bg28-20020a05600c3c9c00b003cfaae07f68sm18031771wmb.17.2022.11.20.15.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 15:35:44 -0800 (PST)
Date:   Sun, 20 Nov 2022 23:35:43 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Xuewen Yan <xuewen.yan@unisoc.com>, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, ke.wang@unisoc.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/rt: Use cpu_active_mask to prevent
 rto_push_irq_work's dead loop
Message-ID: <20221120233543.yerjypgym7laxe42@airbuntu>
References: <20221114120453.3233-1-xuewen.yan@unisoc.com>
 <20221117170028.04fd7013@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221117170028.04fd7013@gandalf.local.home>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17/22 17:00, Steven Rostedt wrote:
> On Mon, 14 Nov 2022 20:04:53 +0800
> Xuewen Yan <xuewen.yan@unisoc.com> wrote:
> 
> > +++ b/kernel/sched/rt.c
> > @@ -2219,6 +2219,7 @@ static int rto_next_cpu(struct root_domain *rd)
> >  {
> >  	int next;
> >  	int cpu;
> > +	struct cpumask tmp_cpumask;
> 
> If you have a machine with thousands of CPUs, this will likely kill the
> stack.
> 
> >  
> >  	/*
> >  	 * When starting the IPI RT pushing, the rto_cpu is set to -1,
> > @@ -2238,6 +2239,11 @@ static int rto_next_cpu(struct root_domain *rd)
> >  		/* When rto_cpu is -1 this acts like cpumask_first() */
> >  		cpu = cpumask_next(rd->rto_cpu, rd->rto_mask);
> >  
> > +		cpumask_and(&tmp_cpumask, rd->rto_mask, cpu_active_mask);
> > +		if (rd->rto_cpu == -1 && cpumask_weight(&tmp_cpumask) == 1 &&
> > +		    cpumask_test_cpu(smp_processor_id(), &tmp_cpumask))
> > +			break;
> > +
> 
> Kill the above.
> 
> >  		rd->rto_cpu = cpu;
> >  
> >  		if (cpu < nr_cpu_ids) {
> 
> Why not just add here:
> 
> 			if (!cpumask_test_cpu(cpu, cpu_active_mask))
> 				continue;
> 			return cpu;
> 		}
> 
> ?

Or this?


	diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
	index ed2a47e4ddae..5073e06e34c3 100644
	--- a/kernel/sched/rt.c
	+++ b/kernel/sched/rt.c
	@@ -2236,7 +2236,7 @@ static int rto_next_cpu(struct root_domain *rd)
		for (;;) {

			/* When rto_cpu is -1 this acts like cpumask_first() */
	-               cpu = cpumask_next(rd->rto_cpu, rd->rto_mask);
	+               cpu = cpumask_next_and(rd->rto_cpu, rd->rto_mask, cpu_active_mask);

			rd->rto_cpu = cpu;


I think we might be circumventing the root cause though. It looks like that
there are only 2 cpus online in the system and one of them going offline (cpu1)
while the other is being overloaded (cpu0), ending in ping-ponging the tasks?

If that's the case, it seems to me the rto state needs to be cleared for cpu0
and stop attempting to push tasks. Which I'd assume it usually happens but
there's a race that prevents it from realizing this.

Maybe something like this would be better? Assuming I understood the problem
correctly of course.


	diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
	index ed2a47e4ddae..d80072cc2596 100644
	--- a/kernel/sched/rt.c
	+++ b/kernel/sched/rt.c
	@@ -334,6 +334,10 @@ static inline void rt_set_overload(struct rq *rq)
		if (!rq->online)
			return;

	+       /* Overload is meaningless if we shrank to become a UP system */
	+       if (cpumask_weight(cpu_online_mask) == 1)
	+               return;
	+
		cpumask_set_cpu(rq->cpu, rq->rd->rto_mask);
		/*
		 * Make sure the mask is visible before we set

This could be working around the problem too, not sure. But the bug IMHO is
that if we shrink to a UP system, the whole push-pull mechanism should retire
temporarily. Which I assume this usually happens, but there's a race somewhere.


Thanks

--
Qais Yousef

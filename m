Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFEAF73F9B9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 12:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjF0KMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 06:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbjF0KLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 06:11:37 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D714AC9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 03:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4zqNnV0CnsHhr55I3vwqjRbQalEDsGW/EKXeK+n995M=; b=d3LfQiugbqmzx8tRj/MqnprqiY
        CtmJtlHIYPjvPL03cg26fQq6KMctnn4cWPxE8M5pSIKauVRCqdY6J2ca7Ll7R/y+YYGCl78OIqZM7
        tgSbot++XFu2Dm5DZkXSXmPw7Z3kp1FUdVI3APcs2hwIhD3ZAz3yPc8HKclx41jOf0/26ZK8FrSyw
        Yma1VMRQLWzSZO4i23TGAH/QlqsYQT5JH4NumfAxHVfYrqyp7tkImws/4icIXGv7bWL7L+GiEWXRq
        aEX8YvMHFLWQWMrAxOD8Z+0XAGhOwTiYzkiG5uFbu1e3qL26Dx0Cc0T9CbnowySEios30HoShs3BP
        6157kKIQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qE5ex-004ds7-2s;
        Tue, 27 Jun 2023 10:10:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5815F3002C5;
        Tue, 27 Jun 2023 12:10:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F2A582435114E; Tue, 27 Jun 2023 12:10:53 +0200 (CEST)
Date:   Tue, 27 Jun 2023 12:10:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Chen Yu <yu.c.chen@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Deng Pan <pan.deng@intel.com>, tim.c.chen@intel.com,
        linux-kernel@vger.kernel.org, tianyou.li@intel.com,
        yu.ma@intel.com, lipeng.zhu@intel.com,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH v2] sched/task_group: Re-layout structure to reduce false
 sharing
Message-ID: <20230627101053.GX4253@hirez.programming.kicks-ass.net>
References: <20230621081425.420607-1-pan.deng@intel.com>
 <20230626054756.GA435374@ziqianlu-dell>
 <ZJlDsbyNmcKtweg4@chenyu5-mobl2.ccr.corp.intel.com>
 <20230626125335.GA508448@ziqianlu-dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626125335.GA508448@ziqianlu-dell>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 08:53:35PM +0800, Aaron Lu wrote:
> On Mon, Jun 26, 2023 at 03:52:17PM +0800, Chen Yu wrote:
> > Besides the cache line alignment, if the task is not a rt one,
> > why do we have to touch that, I wonder if the following change can avoid that:
> > 
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index ec7b3e0a2b20..067f1310bad2 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -1958,8 +1958,10 @@ static inline void set_task_rq(struct task_struct *p, unsigned int cpu)
> >  #endif
> >  
> >  #ifdef CONFIG_RT_GROUP_SCHED
> > -	p->rt.rt_rq  = tg->rt_rq[cpu];
> > -	p->rt.parent = tg->rt_se[cpu];
> > +	if (p->sched_class = &rt_sched_class) {
>                            ==  :-)
> 
> > +		p->rt.rt_rq  = tg->rt_rq[cpu];
> > +		p->rt.parent = tg->rt_se[cpu];
> > +	}
> >  #endif
> >  }
> 
> If a task starts life as a SCHED_NORMAL one and then after some time
> it's changed to a RT one, then during its next ttwu(), if it didn't
> migrate, then set_task_rq() will not be called and p->rt.rt_rq will
> keep as NULL which will cause problem when this task gets enqueued as
> a rt one.
> 
> The follow diff seems to cure this issue:
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index c7db597e8175..8c57148e668c 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7801,6 +7801,20 @@ static int __sched_setscheduler(struct task_struct *p,
>  	}
>  	__setscheduler_uclamp(p, attr);
>  
> +#ifdef CONFIG_RT_GROUP_SCHED
> +	/*
> +	 * Make sure when this task becomes a rt one,
> +	 * its rt fields have valid value.
> +	 */
> +	if (rt_prio(newprio)) {
> +		struct task_group *tg = task_group(p);
> +		int cpu = cpu_of(rq);
> +
> +		p->rt.rt_rq = tg->rt_rq[cpu];
> +		p->rt.parent = tg->rt_se[cpu];
> +	}
> +#endif
> +
>  	if (queued) {
>  		/*
>  		 * We enqueue to tail when the priority of a task is
> 
> But I'm not sure if it's worth the trouble.

Not sufficient, you can become RT through PI and not pass
__sched_setscheduler().

The common code-path in this case would be check_class_changed(), that's
called for oth PI and __sched_setscheduler().

Anyway, not against this per-se, but RT_GROUP_SCHED is utter shite and
nobody should be using it. Also, if there's no measurable performance
gain (as stated elsewhere IIRC) we shouldn't be adding complexity.

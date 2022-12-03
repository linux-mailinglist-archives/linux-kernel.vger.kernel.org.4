Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5434641751
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 15:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiLCOdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 09:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiLCOdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 09:33:03 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A738B10FFF
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 06:33:02 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 125-20020a1c0283000000b003d076ee89d6so5895303wmc.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Dec 2022 06:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jyHvkJIrHNyIKK8KkVrfOpnKlwZiwMCNcylZ1hXv/4c=;
        b=581N1yW5jPhSeCKf5ft6PHNvd/9oycsPlFV3kbhzpUc3xGbwhk27ni53n1PeIMb8Fq
         yLoMEadjEDI4xd+0BmJoReLgBTTADQsy7OnZcM9WL0HTFzV1K+JWUdgxTD+ifLEDxf4p
         upv26iXPqqpu+T1nUQWFnmiWknSW7wccYgmCd8IPpD3n01GTVRq/3JXziGzHUyqQBg56
         P6UnjczLwwP8uIHN0B1JIzZm5sIZMODR4Ve7eGr07wK3tFnjHjwpUAaLTlL6Zm+l0mKb
         czdXKjIJoqXnvqh7FigE9AUkPL+yzbZfEDoUxPA+U0Q0dtc6QNd7fXOUHe9HSNGzgMqD
         to2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyHvkJIrHNyIKK8KkVrfOpnKlwZiwMCNcylZ1hXv/4c=;
        b=N0Vptl4FQuHpTPfxwR3DyjMPYpc+ByqPWTntfLd5//XqMNm60+d187qu/sAE/+MQos
         +WUgKgV1OoEEeGoLwMEnO/IsgOee/Ztmsf6dgPbb8NdNlGUDaZlpgapVmOfelw3QRkvX
         DV4iyKp3X69sd/XazJZvYhjkCln5kWQryGRx2vaCo58T9VMlIc2W01DNZdWyZJ46Id3p
         /StKB0sIUwK2KZ/okZIExUFZ3fQW2WAwvvs7rCi7cBhtBn+vMbZQIMsUG+8ESabmOX9A
         b5LEaqWyETBEVfVVWmWzaSzJuS+/o4OrFxKPgYShjUSYI1E8pf6+EFtCbWbCAiWhEVQd
         rNCw==
X-Gm-Message-State: ANoB5pl0oYahpvzRYBTsRiKHy40/viOYcGib6jiqa/osKbSy+6rxbL7+
        H/4RNfkBLJJKa+Vt3vXhn1EjtA==
X-Google-Smtp-Source: AA0mqf7w6oEMJiTukQoAQ437ohXrD1CQPl+p50aYmo5ktEXCF6F7ttim9y6fuE5cVe1iuiknznyntA==
X-Received: by 2002:a1c:7208:0:b0:3cf:6198:dd2f with SMTP id n8-20020a1c7208000000b003cf6198dd2fmr46347865wmc.119.1670077981253;
        Sat, 03 Dec 2022 06:33:01 -0800 (PST)
Received: from airbuntu (host86-130-134-87.range86-130.btcentralplus.com. [86.130.134.87])
        by smtp.gmail.com with ESMTPSA id w6-20020a5d6806000000b0022e36c1113fsm9260419wru.13.2022.12.03.06.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 06:33:00 -0800 (PST)
Date:   Sat, 3 Dec 2022 14:32:59 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>
Subject: Re: [PATCH 2/3] sched/fair: Fixes for capacity inversion detection
Message-ID: <20221203143259.jzyootwv7yjrny3a@airbuntu>
References: <20221127141742.1644023-1-qyousef@layalina.io>
 <20221127141742.1644023-3-qyousef@layalina.io>
 <f06321f0-def6-6f9d-b72f-f700e7e9a60a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f06321f0-def6-6f9d-b72f-f700e7e9a60a@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/22 23:39, Dietmar Eggemann wrote:
> On 27/11/2022 15:17, Qais Yousef wrote:
> > Traversing the Perf Domains requires rcu_read_lock() to be held and is
> > conditional on sched_energy_enabled(). rcu_read_lock() is held while in
> > load_balance(), add an assert to ensure this is always the case.
> > 
> > Also skip capacity inversion detection for our own pd; which was an
> > error.
> > 
> > Fixes: 44c7b80bffc3 ("sched/fair: Detect capacity inversion")
> > Reported-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> > ---
> >  kernel/sched/fair.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 89dadaafc1ec..7c0dd57e562a 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -8856,16 +8856,22 @@ static void update_cpu_capacity(struct sched_domain *sd, int cpu)
> >  	 *   * Thermal pressure will impact all cpus in this perf domain
> >  	 *     equally.
> >  	 */
> > -	if (static_branch_unlikely(&sched_asym_cpucapacity)) {
> > +	if (sched_energy_enabled()) {
> >  		unsigned long inv_cap = capacity_orig - thermal_load_avg(rq);
> >  		struct perf_domain *pd = rcu_dereference(rq->rd->pd);
> >  
> >  		rq->cpu_capacity_inverted = 0;
> >  
> > +		SCHED_WARN_ON(!rcu_read_lock_held());
> 
> This will trigger in CPU hotplug via build_sched_domains() ->
> update_group_capacity() -> update_cpu_capacity() on an EAS system.

Aargh

> 
> > +
> >  		for (; pd; pd = pd->next) {
> >  			struct cpumask *pd_span = perf_domain_span(pd);
> >  			unsigned long pd_cap_orig, pd_cap;
> >  
> > +			/* We can't be inverted against our own pd */
> > +			if (cpumask_test_cpu(cpu_of(rq), pd_span))
> > +				continue;
> > +
> 
> This should fix the issue with `cpu` function parameter in its own PD.

Thanks for confirming!

> 
> >  			cpu = cpumask_any(pd_span);
> >  			pd_cap_orig = arch_scale_cpu_capacity(cpu);
> >  
> 
> I still don't get the benefit of the CPU capacity inversion patches in
> tip/sched/core which should be fixed by this patch:
> 
> aa69c36f31aa - sched/fair: Consider capacity inversion in
>                util_fits_cpu()
> 44c7b80bffc3 - sched/fair: Detect capacity inversion
> 
> I have to ask again. Why should we use thermal_load_avg() instead of

Is this directed to me?

> arch_scale_thermal_pressure() for a CPUx in `CPU capacity inversion
> state` (i.e. w/ higher `CPU capacity orig` but lower `CPU capacity` than
> CPUy?

If yes, I did answer that here

	https://lore.kernel.org/lkml/20221120213013.t67xisvqxmftri52@airbuntu/


Thanks a lot Dietmar!

--
Qais Yousef

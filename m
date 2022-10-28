Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C8A611D6A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 00:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiJ1WfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 18:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJ1WfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 18:35:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F5D69F7A;
        Fri, 28 Oct 2022 15:35:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48D77B828F8;
        Fri, 28 Oct 2022 22:35:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD613C433D6;
        Fri, 28 Oct 2022 22:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666996514;
        bh=7fjuvPKA0vAPJznN/TY2LeFqZmEvMZgy+SDt0KY2T3U=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=oVs1kltzrwaGTEYxOAy2+1kuEIEyiI9FxqV4MBIEMPxv6chtgE9LNv+IYmqrXB+0y
         Rpp9/GDJ42cB8LB2ucM6jGyN3MJB+kewAzGzJ9ynWrqN9NwXF6wL4EwsnFGeU1HCOS
         gdIKVi5ynZrZf7MHh81rSF02pVVtGgkPwNV/Uayqvbxzzc4CKVLBu0SSodsF2uiR8J
         562ckUIVJziQ1A3p6vjOjZwUNraCz+BJpBxghnqAM8IuvZ54PEaVjOrP+yb1dFw684
         VVTz/O2ju8GfEgJhUyFqSZ8Cc/0K9JYD9ck5/Waegpyo6HRQSSgdZbpxKbNOu5zk4A
         0k6Ch8Ue/PxnA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 79C765C1040; Fri, 28 Oct 2022 15:35:14 -0700 (PDT)
Date:   Fri, 28 Oct 2022 15:35:14 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     "Elliott, Robert (Servers)" <elliott@hpe.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] sched: Add helper kstat_cpu_softirqs_sum()
Message-ID: <20221028223514.GV5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221022124525.2080-1-thunder.leizhen@huawei.com>
 <20221022124525.2080-2-thunder.leizhen@huawei.com>
 <MW5PR84MB18423C3F30D3F789EB48D0A5AB339@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
 <e15cd40f-6613-ba44-cc54-0d00f3c7eab1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e15cd40f-6613-ba44-cc54-0d00f3c7eab1@huawei.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 10:38:15AM +0800, Leizhen (ThunderTown) wrote:
> 
> 
> On 2022/10/28 3:04, Elliott, Robert (Servers) wrote:
> > 
> >> Similar to kstat_cpu_irqs_sum(), it counts the sum of all software
> >> interrupts on a specified CPU.
> >>
> >> diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
> >> @@ -67,6 +67,17 @@ static inline unsigned int kstat_softirqs_cpu(unsigned int irq, int cpu)
> >>         return kstat_cpu(cpu).softirqs[irq];
> >>  }
> >>
> >> +static inline unsigned int kstat_cpu_softirqs_sum(int cpu)
> >> +{
> >> +	int i;
> >> +	unsigned int sum = 0;
> >> +
> >> +	for (i = 0; i < NR_SOFTIRQS; i++)
> >> +		sum += kstat_softirqs_cpu(i, cpu);
> >> +
> >> +	return sum;
> >> +}
> > 
> > In the function upon which this is based:
> > 
> > struct kernel_stat {
> >         unsigned long irqs_sum;
> >         unsigned int softirqs[NR_SOFTIRQS];
> > };
> > 
> > static inline unsigned int kstat_cpu_irqs_sum(unsigned int cpu)
> > {
> >         return kstat_cpu(cpu).irqs_sum;
> > }
> > 
> > kstat_cpu_irqs_sum returns an unsigned long as an unsigned int, which
> > could cause large values to be truncated. Should that return
> > unsigned long? The only existing caller is fs/proc/stat.c which
> 
> This should be a mistake on:
> commit f2c66cd8eeddedb4 ("/proc/stat: scalability of irq num per cpu")
> 
> I'll correct it to "unsigned long" in the next version. Thanks.
> 
> > puts it into a u64:
> >         u64 sum = 0;
> >         ...
> >         sum             += kstat_cpu_irqs_sum(i);
> > 
> > The softirqs field is an unsigned int, so the new function doesn't have
> > this inconsistency.
> 
> OK.
> 
> To be honest, I did the math. CONFIG_HZ=250
> 2^32 / 250 / 3600 / 24 / 365 = 0.545 < 1 year

For this to be a problem, our RCU CPU stall warning would have to be
for a months-long grace period, even on systems with HZ=1000.  In almost
all cases, the system would have OOMed long before then.

> So, in theory, for those 32-bit processors, we should use "unsigned long long".
> Of course, from a programming point of view, 64-bit consists of two 32-bits,
> and there is an atomicity problem. I think that's probably why members of
> struct kernel_stat don't use u64.
> 
> However, it seems that the type of member softirqs can currently be changed to
> unsigned long. So, at least on a 64-bit processor, it won't have a count
> overflow problem.

An unsigned long should suffice.  ;-)

							Thanx, Paul

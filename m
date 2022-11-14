Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC817627EAD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 13:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237419AbiKNMu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 07:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237407AbiKNMuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 07:50:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD862AF2;
        Mon, 14 Nov 2022 04:50:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9837E6117E;
        Mon, 14 Nov 2022 12:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F538C433D7;
        Mon, 14 Nov 2022 12:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668430222;
        bh=mzUhndOilHXKgwGBKxmnQpDLo2xVSLr5dI+cIidrbJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g03K4Mz2+5xD/gNjcYXSIqRYIT2ys/DD2xwmGqfqTBaAy+5W7AIISHK+Le4LikLYd
         CE3BN6TwI9qj+LNLUg5yn/ccgZ2aAd/5fE9i1TYfXhZTjG0ilhn+zy5GM3Uk8hqCKT
         zNx3yv/zNmGW8IyeHXVD7mcOaKCI3e4NyUdaJ4adT4bOrjGWSXil1QLO704/KBotCY
         s1LCYXdbyOZo9LwKjMWrynpTpX0pCpab1WcLQ5BrTpn5NJF8FNxdYlVzzgDur8tNeL
         dRjUQ1CogD+SMKj976mOY2Rii6aCLZW3RxtIczdpvb4wQHVkD0S7D2h0GHNQHwHrF7
         owEhw2EqJl6EQ==
Date:   Mon, 14 Nov 2022 13:50:18 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Elliott <elliott@hpe.com>
Subject: Re: [PATCH v7 2/6] sched: Add helper kstat_cpu_softirqs_sum()
Message-ID: <20221114125018.GF590078@lothringen>
References: <20221111130709.247-1-thunder.leizhen@huawei.com>
 <20221111130709.247-3-thunder.leizhen@huawei.com>
 <20221114114252.GA590078@lothringen>
 <568f1341-401d-7de4-0dfd-79b8121ef413@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <568f1341-401d-7de4-0dfd-79b8121ef413@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 08:45:26PM +0800, Leizhen (ThunderTown) wrote:
> 
> 
> On 2022/11/14 19:42, Frederic Weisbecker wrote:
> > On Fri, Nov 11, 2022 at 09:07:05PM +0800, Zhen Lei wrote:
> >> Similar to kstat_cpu_irqs_sum(), it counts the sum of all software
> >> interrupts on a specified CPU.
> >>
> >> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >> ---
> >>  include/linux/kernel_stat.h | 11 +++++++++++
> >>  1 file changed, 11 insertions(+)
> >>
> >> diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
> >> index 90e2fdc17d79ff8..898076e173a928a 100644
> >> --- a/include/linux/kernel_stat.h
> >> +++ b/include/linux/kernel_stat.h
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
> > 
> > This should return a u64 or at least an unsigned long so that high
> > numbers of CPUs don't overflow easily.
> 
> OK! Then I'll adjust the following types by the way.
> 
> struct kernel_stat {
>         unsigned long irqs_sum;
>         unsigned int softirqs[NR_SOFTIRQS];
> };
> 
> static inline unsigned int kstat_softirqs_cpu(unsigned int irq, int cpu)

And I also misread kstat_softirqs_cpu() content, my bad. Although at some point
the sum of all softirqs within a single CPU might overflow in an int so I guess
that still applies...

Thanks.


> 
> 
> 
> 
> > 
> > Thanks.
> > 
> >> +
> >> +	return sum;
> >> +}
> >> +
> >>  /*
> >>   * Number of interrupts per specific IRQ source, since bootup
> >>   */
> >> -- 
> >> 2.25.1
> >>
> > .
> > 
> 
> -- 
> Regards,
>   Zhen Lei

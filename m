Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31DF622F7A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 16:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiKIP4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 10:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbiKIP4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 10:56:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1841918374;
        Wed,  9 Nov 2022 07:56:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5AF17B81F2A;
        Wed,  9 Nov 2022 15:56:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF7A9C433D6;
        Wed,  9 Nov 2022 15:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668009403;
        bh=Eem6KsBQlG6910BgkY+LYsgfspL+ZzI/7YJPT1RLl2o=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=QdwYKXbuUv2qL5BRiW5NffLid7q24O7JgGI+eVXrEUvJQflhkv/QEDhRcX5qcreUi
         i3KS8R/Hn/QyRyXkMznpbBnb6+R4oa05fln9vRHyoSmvxZoF4JoAFdV+LgCfNglXQb
         8iLzsFaNVwIUQRxILbb17e+LamVwjGsbtcpfCGqlzjIT7SZQ32h/6eYmvRIZM2KqoN
         hbrtOgkDWj/veXxF2o3oVqFTcqKh4aDBbCg6LpL2Kf9bOUjz0U1owbu1CUoJ18LOPf
         J3sUN/HSVpg63DdxmQhFu16ONUZjPpjAQK+D123SZP+3H2BELyF7MMeuVG3NpjXqcz
         /yQZeQ3rVPlYQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 705465C097E; Wed,  9 Nov 2022 07:56:40 -0800 (PST)
Date:   Wed, 9 Nov 2022 07:56:40 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Elliott <elliott@hpe.com>
Subject: Re: [PATCH] rcu: Illustrate the stall information of
 CONFIG_RCU_CPU_STALL_CPUTIME=y
Message-ID: <20221109155640.GC725751@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221107152935.167-1-thunder.leizhen@huawei.com>
 <20221108204640.GJ3907045@paulmck-ThinkPad-P17-Gen-1>
 <61c45ec1-69ec-0e65-6a48-1329e66ec30f@huawei.com>
 <31c1dfb1-623f-4a9e-7f2c-48b83dd4490d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31c1dfb1-623f-4a9e-7f2c-48b83dd4490d@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 04:46:01PM +0800, Leizhen (ThunderTown) wrote:
> 
> 
> On 2022/11/9 10:09, Leizhen (ThunderTown) wrote:
> > 
> > 
> > On 2022/11/9 4:46, Paul E. McKenney wrote:
> >> On Mon, Nov 07, 2022 at 11:29:35PM +0800, Zhen Lei wrote:
> >>> Describes how to quickly determine the RCU stall fault type based on the
> >>> extra output information during CONFIG_RCU_CPU_STALL_CPUTIME=y.
> >>>
> >>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >>
> >> Hearing no objections, I queued the following for further review.
> >>
> >> This commit might of course need to change based on your ongoing
> >> discussion with Robert.  I that case, please feel free to send me a
> >> replacment patch or to send me an incremental patch that I can fold into
> >> this patch.  Either way works.
> > 
> > I'll issue incremental patches on the basis of your adjustment! This will
> > make it clearer and save your time in reviewing.
> 
> I found that Patch 4/4 had one line of description that needed to be changed,
> so I had to switch to method 1.

Sounds good!  I will drop what I have (five patches) and take the next
series with Frederic's feedback addressed.

							Thanx, Paul

> > Thanks for your help. I really admire your verbal skills. Your improved
> > description is much better than mine.
> > 
> >>
> >> 							Thanx, Paul
> >>
> >> ------------------------------------------------------------------------
> >>
> >> commit b05c2a06ff8a1267b7e8dc812e3944119535d6b6
> >> Author: Zhen Lei <thunder.leizhen@huawei.com>
> >> Date:   Mon Nov 7 23:29:35 2022 +0800
> >>
> >>     doc: Document CONFIG_RCU_CPU_STALL_CPUTIME=y stall information
> >>     
> >>     This commit doucments how to quickly determine the bug causing a given
> >>     RCU CPU stall fault warning based on the output information provided
> >>     by CONFIG_RCU_CPU_STALL_CPUTIME=y.
> >>     
> >>     [ paulmck: Apply wordsmithing. ]
> >>     
> >>     Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >>
> >> diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.rst
> >> index dfa4db8c0931e..bd8cf6c640984 100644
> >> --- a/Documentation/RCU/stallwarn.rst
> >> +++ b/Documentation/RCU/stallwarn.rst
> >> @@ -390,3 +390,82 @@ for example, "P3421".
> >>  
> >>  It is entirely possible to see stall warnings from normal and from
> >>  expedited grace periods at about the same time during the same run.
> >> +
> >> +RCU_CPU_STALL_CPUTIME
> >> +=====================
> >> +
> >> +In kernels built with CONFIG_RCU_CPU_STALL_CPUTIME=y or booted with
> >> +rcupdate.rcu_cpu_stall_cputime=1, the following additional information
> >> +is supplied with each RCU CPU stall warning::
> >> +
> >> +rcu:          hardirqs   softirqs   csw/system
> >> +rcu:  number:      624         45            0
> >> +rcu: cputime:       69          1         2425   ==> 2500(ms)
> >> +
> >> +These statistics are collected during the second half of the rcu stall
> >> +timeout. The values in row "number:" are the number of hard interrupts,
> >> +number of soft interrupts, and number of context switches on the stalled
> >> +CPU. The first three values in row "cputime:" indicate the CPU time in
> >> +milliseconds consumed by hard interrupts, soft interrupts, and tasks
> >> +on the stalled CPU.  The last number is the measurement interval, again
> >> +in milliseconds.  Because user-mode tasks normally do not cause RCU CPU
> >> +stalls, these tasks are typically kernel tasks, which is why only the
> >> +system CPU time are considered.
> >> +
> >> +The following describes four typical scenarios:
> >> +
> >> +1. A CPU looping with interrupts disabled.::
> >> +
> >> +   rcu:          hardirqs   softirqs   csw/system
> >> +   rcu:  number:        0          0            0
> >> +   rcu: cputime:        0          0            0   ==> 2500(ms)
> >> +
> >> +   Because interrupts have been disabled throughout the measurement
> >> +   interval, there are no interrupts and no context switches.
> >> +   Furthermore, because CPU time consumption was measured using interrupt
> >> +   handlers, the system CPU consumption is misleadingly measured as zero.
> >> +   This scenario will normally also have "(0 ticks this GP)" printed on
> >> +   this CPU's summary line.
> >> +
> >> +2. A CPU looping with bottom halves disabled.
> >> +
> >> +   This is similar to the previous example, but with non-zero number of
> >> +   and CPU time consumed by hard interrupts, along with non-zero CPU
> >> +   time consumed by in-kernel execution.::
> >> +
> >> +   rcu:          hardirqs   softirqs   csw/system
> >> +   rcu:  number:      624          0            0
> >> +   rcu: cputime:       49          0         2446   ==> 2500(ms)
> >> +
> >> +   The fact that there are zero softirqs gives a hint that these were
> >> +   disabled, perhaps via local_bh_disable().  It is of course possible
> >> +   that there were no softirqs, perhaps because all events that would
> >> +   result in softirq execution are confined to other CPUs.  In this case,
> >> +   the diagnosis should continue as shown in the next example.
> >> +
> >> +3. A CPU looping with preemption disabled.
> >> +
> >> +   Here, only the number of context switches is zero.::
> >> +
> >> +   rcu:          hardirqs   softirqs   csw/system
> >> +   rcu:  number:      624         45            0
> >> +   rcu: cputime:       69          1         2425   ==> 2500(ms)
> >> +
> >> +   This situation hints that the stalled CPU was looping with preemption
> >> +   disabled.
> >> +
> >> +4. No looping, but massive hard and soft interrupts.::
> >> +
> >> +   rcu:          hardirqs   softirqs   csw/system
> >> +   rcu:  number:       xx         xx            0
> >> +   rcu: cputime:       xx         xx            0   ==> 2500(ms)
> >> +
> >> +   Here, the number and CPU time of hard interrupts are all non-zero,
> >> +   but the number of context switches and the in-kernel CPU time consumed
> >> +   are zero. The number and cputime of soft interrupts will usually be
> >> +   non-zero, but could be zero, for example, if the CPU was spinning
> >> +   within a single hard interrupt handler.
> >> +
> >> +   If this type of RCU CPU stall warning can be reproduced, you can
> >> +   narrow it down by looking at /proc/interrupts or by writing code to
> >> +   trace each interrupt, for example, by referring to show_interrupts().
> >> .
> >>
> > 
> 
> -- 
> Regards,
>   Zhen Lei

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C225E606BFA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 01:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiJTXOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 19:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiJTXN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 19:13:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977A122E0FC;
        Thu, 20 Oct 2022 16:13:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2DEFEB828B5;
        Thu, 20 Oct 2022 23:13:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5426C433B5;
        Thu, 20 Oct 2022 23:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666307633;
        bh=axu5Xp7Ry043Wqw4vY+2kZM7lnVF71Cg1L+qE8Jwhco=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=gV4ctlBkZHzMAjmaEvkaPMiVjmCr/ljvNWEAQYhdl/8q2fo3al5fBGohGCT+8b4Yd
         eyNqwlDzejTU/EcgrAO1JP4sLAoBj15wjinwjGbbr/mS2Ic3BGBuQ4Z9eZ0n5sZP2m
         ZiHQvhex2Pwzpk76Sad2/SdBUJQsAirKxCfEZiYfv8BPpaZ3vleJ1qiROXEAATN7X5
         4HhWO904l3VblMb513WeVExeNrm1VW+Sj5Hjm9Q/fsrU8SWgnpdk6wovsBoTdfErH6
         JNSd6OFaBwoRTTxxvu0KoJHKWSXx0j1ssn5z1X+MCJp0quR3AyRWIn63Z19MwB+W8f
         NSioxMBgG9PqQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6D7875C1109; Thu, 20 Oct 2022 16:13:53 -0700 (PDT)
Date:   Thu, 20 Oct 2022 16:13:53 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] rcu: Add RCU stall diagnosis information
Message-ID: <20221020231353.GC5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221017100108.2063-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017100108.2063-1-thunder.leizhen@huawei.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 06:01:05PM +0800, Zhen Lei wrote:
> In some extreme cases, such as the I/O pressure test, the CPU usage may
> be 100%, causing RCU stall. In this case, the printed information about
> current is not useful. Displays the number and usage of hard interrupts,
> soft interrupts, and context switches that are generated within half of
> the CPU stall timeout, can help us make a general judgment. In other
> cases, we can preliminarily determine whether an infinite loop occurs
> when local_irq, local_bh or preempt is disabled.
> 
> Zhen Lei (3):
>   sched: Add helper kstat_cpu_softirqs_sum()
>   sched: Add helper nr_context_switches_cpu()
>   rcu: Add RCU stall diagnosis information

Interesting approach, thank you!

I have pulled this in for testing and review, having rescued it from my
spam folder.

Some questions that might come up include:  (1) Can the addition of
things like cond_resched() make RCU happier with the I/O pressure test?
(2) Should there be a way to turn this off for environments with slow
consoles?  (3) If this information shows heavy CPU usage, what debug
and fix approach should be used?

For an example of #1, if a CPU is flooded with softirq activity, one
might hope that the call to rcu_softirq_qs() would prevent the RCU CPU
stall warning, at least for kernels built with CONFIG_PREEMPT_RT=n.
Similarly, if there are huge numbers of context switches, one might hope
that the rcu_note_context_switch() would report a quiescent state sooner
rather than later.

Thoughts?

							Thanx, Paul

>  include/linux/kernel_stat.h | 12 +++++++++++
>  kernel/rcu/tree.h           | 11 ++++++++++
>  kernel/rcu/tree_stall.h     | 40 +++++++++++++++++++++++++++++++++++++
>  kernel/sched/core.c         |  5 +++++
>  4 files changed, 68 insertions(+)
> 
> -- 
> 2.25.1
> 

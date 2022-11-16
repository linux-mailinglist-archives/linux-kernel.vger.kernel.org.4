Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A113362CE17
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 23:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiKPWzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 17:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbiKPWzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 17:55:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F97654DA;
        Wed, 16 Nov 2022 14:55:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA4A86202C;
        Wed, 16 Nov 2022 22:55:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5BADC433D6;
        Wed, 16 Nov 2022 22:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668639311;
        bh=0/yD0VfcEuBfc1ridSbAWgEzJGmmLBk0Iteufn7sLRU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KPxmw3O3sBjrlKYyQJgN9ROMY/TvQM9nXThvFK5oULbNTjolpWRJG/3HllWkjjQ5h
         E55dNuKD4Pxp7KPOS1YyLs/kt25rHLMkeUpLYLLr4MZF6NJXhWgS9xqZyvI0D4YTF/
         KUuecgseklfP/LPUnszPgtgYeswuBGbJuWr7NRG4ZkZQt35vbCi91gk9yXZFffcoty
         6Jg161MHKsyaG1bkC7lmWwdthGQd5NTgg2xN86DvNwi8u5jzqLobG0waLtvpevY2wl
         eEJ4WlmMeH6f98F6aEfD3zmiLdtkWpqDEHmLUiP/37dw5ePy1ztAkEc0W2L5tK6iAc
         wbdWSEUxKJyKw==
Date:   Wed, 16 Nov 2022 23:55:07 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Elliott <elliott@hpe.com>
Subject: Re: [PATCH v7 5/6] doc: Document CONFIG_RCU_CPU_STALL_CPUTIME=y
 stall information
Message-ID: <20221116225507.GA839220@lothringen>
References: <20221111130709.247-1-thunder.leizhen@huawei.com>
 <20221111130709.247-6-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111130709.247-6-thunder.leizhen@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 09:07:08PM +0800, Zhen Lei wrote:
> +1. A CPU looping with interrupts disabled.::
> +
> +   rcu:          hardirqs   softirqs   csw/system
> +   rcu:  number:        0          0            0
> +65;6003;1c   rcu: cputime:        0          0            0   ==> 2500(ms)
> +
> +   Because interrupts have been disabled throughout the measurement
> +   interval, there are no interrupts and no context switches.
> +   Furthermore, because CPU time consumption was measured using interrupt
> +   handlers, the system CPU consumption is misleadingly measured as zero.
> +   This scenario will normally also have "(0 ticks this GP)" printed on
> +   this CPU's summary line.
> +
> +2. A CPU looping with bottom halves disabled.
> +
> +   This is similar to the previous example, but with non-zero number of
> +   and CPU time consumed by hard interrupts, along with non-zero CPU
> +   time consumed by in-kernel execution.::
> +
> +   rcu:          hardirqs   softirqs   csw/system
> +   rcu:  number:      624          0            0
> +   rcu: cputime:       49          0         2446   ==> 2500(ms)
> +
> +   The fact that there are zero softirqs gives a hint that these were
> +   disabled, perhaps via local_bh_disable().  It is of course possible
> +   that there were no softirqs, perhaps because all events that would
> +   result in softirq execution are confined to other CPUs.  In this case,
> +   the diagnosis should continue as shown in the next example.
> +
> +3. A CPU looping with preemption disabled.
> +
> +   Here, only the number of context switches is zero.::
> +
> +   rcu:          hardirqs   softirqs   csw/system
> +   rcu:  number:      624         45            0
> +   rcu: cputime:       69          1         2425   ==> 2500(ms)
> +
> +   This situation hints that the stalled CPU was looping with preemption
> +   disabled.
> +
> +4. No looping, but massive hard and soft interrupts.::
> +
> +   rcu:          hardirqs   softirqs   csw/system
> +   rcu:  number:       xx         xx            0
> +   rcu: cputime:       xx         xx            0   ==> 2500(ms)
> +
> +   Here, the number and CPU time of hard interrupts are all non-zero,
> +   but the number of context switches and the in-kernel CPU time consumed
> +   are zero. The number and cputime of soft interrupts will usually be
> +   non-zero, but could be zero, for example, if the CPU was spinning
> +   within a single hard interrupt handler.
> +
> +   If this type of RCU CPU stall warning can be reproduced, you can
> +   narrow it down by looking at /proc/interrupts or by writing code to
> +   trace each interrupt, for example, by referring to show_interrupts().

One last question I have. Usually all these informations can be deduced by
just looking at the stacktrace that comes along an RCU stall report. So on
which kind of situation the stacktrace is not enough?

Thanks.

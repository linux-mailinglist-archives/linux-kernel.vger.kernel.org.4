Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6607F622EC5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 16:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbiKIPIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 10:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbiKIPIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 10:08:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813341580A;
        Wed,  9 Nov 2022 07:08:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3447AB81EFA;
        Wed,  9 Nov 2022 15:08:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF51C433C1;
        Wed,  9 Nov 2022 15:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668006517;
        bh=Jsr3DsMwhf+FxswR+i7lkZdk5XOHeN6cztkZIb5MJ6s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N6M2hTB2v1pjfLAyr4r3OHaYtvsDL6xwY7xpbuOZxM2AtXrNub80Gt4/2ehrCFSW4
         86++sMI6ppFIk5aEMjheGBzkdfqovvlVu+uVhDbR0i5OLrydwcUAjwWoRtfMqrg2EW
         1XQFv0MnrTA2KmtiFbGriEveMuN24F96LJn+gO6ZFDbdL0PI7tag+BgfNO1wByHMnR
         Ihg597wHW1Jf9aTuGS0pJ7ivMj+oz+D5lYQhc36E78AQkuu1A79bDfISl/TnWJ1IC0
         iuQU4w/NN5EDY5FkUytW5ujJrCWgfadaJKBoMX8gbPoVZiipRL7M0CjlkU/8QHdhGc
         mx7mApUyjHE8Q==
Date:   Wed, 9 Nov 2022 16:08:34 +0100
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
Subject: Re: [PATCH v6 2/2] doc: Document CONFIG_RCU_CPU_STALL_CPUTIME=y
 stall information
Message-ID: <20221109150834.GA127536@lothringen>
References: <20221109093739.187-1-thunder.leizhen@huawei.com>
 <20221109093739.187-3-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109093739.187-3-thunder.leizhen@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 05:37:38PM +0800, Zhen Lei wrote:
> This commit doucments how to quickly determine the bug causing a given
> RCU CPU stall fault warning based on the output information provided
> by CONFIG_RCU_CPU_STALL_CPUTIME=y.
> 
> [ paulmck: Apply wordsmithing. ]
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  Documentation/RCU/stallwarn.rst | 88 +++++++++++++++++++++++++++++++++
>  1 file changed, 88 insertions(+)
> 
> diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.rst
> index dfa4db8c0931eaf..5e24e849290a286 100644
> --- a/Documentation/RCU/stallwarn.rst
> +++ b/Documentation/RCU/stallwarn.rst
> @@ -390,3 +390,91 @@ for example, "P3421".
>  
>  It is entirely possible to see stall warnings from normal and from
>  expedited grace periods at about the same time during the same run.
> +
> +RCU_CPU_STALL_CPUTIME
> +=====================
> +
> +In kernels built with CONFIG_RCU_CPU_STALL_CPUTIME=y or booted with
> +rcupdate.rcu_cpu_stall_cputime=1, the following additional information
> +is supplied with each RCU CPU stall warning::
> +
> +rcu:          hardirqs   softirqs   csw/system
> +rcu:  number:      624         45            0
> +rcu: cputime:       69          1         2425   ==> 2500(ms)
> +
> +These statistics are collected during the sampling period. The values
> +in row "number:" are the number of hard interrupts, number of soft
> +interrupts, and number of context switches on the stalled CPU. The
> +first three values in row "cputime:" indicate the CPU time in
> +milliseconds consumed by hard interrupts, soft interrupts, and tasks
> +on the stalled CPU.

Is that since the boot or since the last snapshot?

> The last number is the measurement interval, again
> +in milliseconds.  Because user-mode tasks normally do not cause RCU CPU
> +stalls, these tasks are typically kernel tasks, which is why only the
> +system CPU time are considered.
> +
> +The sampling period is shown as follows:
> +|<------------first timeout---------->|<-----second timeout----->|
> +|<--half timeout-->|<--half timeout-->|                          |
> +|                  |<--first period-->|                          |
> +|                  |<-----------second sampling period---------->|
> +|                  |                  |                          |
> +|          sampling time point    1st-stall                  2nd-stall
> +
> +
> +The following describes four typical scenarios:
> +
> +1. A CPU looping with interrupts disabled.::
> +
> +   rcu:          hardirqs   softirqs   csw/system
> +   rcu:  number:        0          0            0
> +   rcu: cputime:        0          0            0   ==> 2500(ms)
> +
> +   Because interrupts have been disabled throughout the measurement
> +   interval, there are no interrupts and no context switches.
> +   Furthermore, because CPU time consumption was measured using interrupt
> +   handlers, the system CPU consumption is misleadingly measured as zero.
> +   This scenario will normally also have "(0 ticks this GP)" printed on
> +   this CPU's summary line.

Right, unless you're running with CONFIG_NO_HZ_FULL=y and the target CPU
is nohz_full=, in that case you should see a delta in stime because the
cputime is measured with the CPU clock.

Thanks.

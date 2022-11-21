Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B62632D81
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 20:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiKUT5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 14:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbiKUT5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 14:57:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028C5C657C;
        Mon, 21 Nov 2022 11:57:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D270B81601;
        Mon, 21 Nov 2022 19:57:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2069BC433C1;
        Mon, 21 Nov 2022 19:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669060624;
        bh=YPwgtKNdOylEcCHyoy7Ll8ot+K2wIWy3WC83g9m+Z8k=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=A6n5/ekzVsVnII7l9A/wif06CcDNEFeWKzvHddNpuJA5b19z77u4cbpKXbXSB39ik
         2vbgg8ra00DPk3ELH0LAOsCRtng6pKWyElvSuQPM7dye91Uq3EAlKtUfFASmlrDbf2
         37fHml196vg1zd0eINFB/4PWo9watU2sWD3wivq95IUhZOy80eUkG+/DEnGA1ijuNG
         hOFyTHIgBDSNSskArWkuJX2kjD7Q6A3zvwKaPVt/mi5WsdbPuEqAGZkuVAynG3sy4O
         WT+8CF59sTyPCVlvwLBzENZlAsN/FOn5elb4cfhemClTItmbkjrtpWtxD+aFwBE/SD
         k7rWFIVRjsJNA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BDBE65C09CB; Mon, 21 Nov 2022 11:57:03 -0800 (PST)
Date:   Mon, 21 Nov 2022 11:57:03 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Fix kernel stack overflow caused by kprobe on
 rcu_irq_enter_check_tick()
Message-ID: <20221121195703.GO4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221119040049.795065-1-zhengyejian1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221119040049.795065-1-zhengyejian1@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 19, 2022 at 12:00:49PM +0800, Zheng Yejian wrote:
> Register kprobe on __rcu_irq_enter_check_tick() can cause kernel stack
> overflow [1]. This issue is first found in v5.10 and can be reproduced
> by enabling CONFIG_NO_HZ_FULL and doing like:
>   # cd /sys/kernel/debug/tracing/
>   # echo 'p:mp1 __rcu_irq_enter_check_tick' >> kprobe_events
>   # echo 1 > events/kprobes/enable
> 
> So __rcu_irq_enter_check_tick() should not be kprobed, mark it as noinstr.

Good catch!

I am inclined to queue this, but noticed that one of its callers need
it to be noinstr but that the others do not.

Need noinstr:

o	enter_from_kernel_mode() -> __enter_from_kernel_mode() ->
	rcu_irq_enter_check_tick() -> __rcu_irq_enter_check_tick()

Doesn't need noinstr:

o	ct_nmi_enter() -> rcu_irq_enter_check_tick() ->
	__rcu_irq_enter_check_tick(), courtesy of the call to
	instrumentation_begin() in ct_nmi_enter() that precedes the call
	to rcu_irq_enter_check_tick().

o	irqentry_enter() -> rcu_irq_enter_check_tick() ->
	__rcu_irq_enter_check_tick(), courtesy of the call to
	instrumentation_begin() in irqentry_enter() that precedes the
	call to rcu_irq_enter_check_tick().

Is tagging __rcu_irq_enter_check_tick() with noinstr as
proposed in this patch the right thing to do, or should there
be calls to instrumentation_begin() and instrumentation_end() in
enter_from_kernel_mode()?  Or something else entirely?

Thoughts?

							Thanx, Paul

> [1]
> Insufficient stack space to handle exception!
> Insufficient stack space to handle exception!
> [...]
> Kernel panic - not syncing: kernel stack overflow
> CPU: 3 PID: 34 Comm: migration/3 Not tainted
> 6.1.0-rc5-00884-g84368d882b96 #2
> Hardware name: linux,dummy-virt (DT)
> Stopper: multi_cpu_stop+0x0/0x228 <- __stop_cpus.constprop.0+0xa4/0x100
> Call trace:
>  dump_backtrace+0xf8/0x108
>  show_stack+0x20/0x48
>  dump_stack_lvl+0x68/0x84
>  dump_stack+0x1c/0x38
>  panic+0x214/0x404
>  add_taint+0x0/0xf0
>  panic_bad_stack+0x144/0x160
>  handle_bad_stack+0x38/0x58
>  __bad_stack+0x78/0x7c
>  el1h_64_sync_handler+0x4/0xe8
>  __rcu_irq_enter_check_tick+0x0/0x1b8
>  arm64_enter_el1_dbg.isra.0+0x14/0x20
>  el1_dbg+0x2c/0x90
>  el1h_64_sync_handler+0xcc/0xe8
>  el1h_64_sync+0x64/0x68
>  __rcu_irq_enter_check_tick+0x0/0x1b8
>  arm64_enter_el1_dbg.isra.0+0x14/0x20
>  el1_dbg+0x2c/0x90
>  el1h_64_sync_handler+0xcc/0xe8
>  el1h_64_sync+0x64/0x68
>  __rcu_irq_enter_check_tick+0x0/0x1b8
>  arm64_enter_el1_dbg.isra.0+0x14/0x20
>  el1_dbg+0x2c/0x90
>  el1h_64_sync_handler+0xcc/0xe8
>  el1h_64_sync+0x64/0x68
>  __rcu_irq_enter_check_tick+0x0/0x1b8
>  arm64_enter_el1_dbg.isra.0+0x14/0x20
>  el1_dbg+0x2c/0x90
>  el1h_64_sync_handler+0xcc/0xe8
>  el1h_64_sync+0x64/0x68
>  __rcu_irq_enter_check_tick+0x0/0x1b8
>  arm64_enter_el1_dbg.isra.0+0x14/0x20
>  el1_dbg+0x2c/0x90
>  el1h_64_sync_handler+0xcc/0xe8
>  el1h_64_sync+0x64/0x68
>  __rcu_irq_enter_check_tick+0x0/0x1b8
>  [...]
> 
> Cc: stable@vger.kernel.org
> Fixes: aaf2bc50df1f ("rcu: Abstract out rcu_irq_enter_check_tick() from rcu_nmi_enter()")
> Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
> ---
>  kernel/rcu/tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 93416afebd59..68230f02cfb7 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -631,7 +631,7 @@ void rcu_irq_exit_check_preempt(void)
>   * controlled environments, this function allows RCU to get what it
>   * needs without creating otherwise useless interruptions.
>   */
> -void __rcu_irq_enter_check_tick(void)
> +noinstr void __rcu_irq_enter_check_tick(void)
>  {
>  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
>  
> -- 
> 2.25.1
> 

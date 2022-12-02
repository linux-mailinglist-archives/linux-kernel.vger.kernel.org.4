Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D227C640E63
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 20:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234746AbiLBTY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 14:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234047AbiLBTY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 14:24:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29ABF2A730;
        Fri,  2 Dec 2022 11:24:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC51E6204D;
        Fri,  2 Dec 2022 19:24:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B02C433C1;
        Fri,  2 Dec 2022 19:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670009095;
        bh=bjTdZPAtlTkaX0T64lsIZRWaS/V3AxWexLfL9z9v4oc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=mSYyHJ9lUgm/Z8QeH85k1MMYTZZeT48WhLgl3O1LXrmzcGNXSwakzpzTYhaAy2yOu
         be7FicPOMJAkQyhheDfBpg98GCPQyIUtaCwgP97aOFQx/VqfhrD2TkH6tJDxXlxVZ2
         fNpoy5CPMNIOz9MP/vPzTa4qthqgaNjNGjRH9K9JOL+EMmxB3IoTKH+PyNMVhod6e1
         djh7Pe6AtdpFqBVCZw63HgPOgQx4g0eF6509WVemxlqZE75sYQZAe5RP+Egj+Is4Do
         9pGsAgxW62ZktvM3rjulA3r4kZyfsucUsRoqY51hYJelEcGUyt2qgF2dI6QDRIecQg
         JA+CJA/Row0Cg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B29B45C095D; Fri,  2 Dec 2022 11:24:54 -0800 (PST)
Date:   Fri, 2 Dec 2022 11:24:54 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Fix kernel stack overflow caused by kprobe on
 rcu_irq_enter_check_tick()
Message-ID: <20221202192454.GX4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221119040049.795065-1-zhengyejian1@huawei.com>
 <20221121195703.GO4001@paulmck-ThinkPad-P17-Gen-1>
 <dda2427b-053a-e4b4-0d71-afb10b7c635d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dda2427b-053a-e4b4-0d71-afb10b7c635d@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 05:54:48PM +0800, Zheng Yejian wrote:
> 
> 
> On 2022/11/22 03:57, Paul E. McKenney wrote:
> > On Sat, Nov 19, 2022 at 12:00:49PM +0800, Zheng Yejian wrote:
> > > Register kprobe on __rcu_irq_enter_check_tick() can cause kernel stack
> > > overflow [1]. This issue is first found in v5.10 and can be reproduced
> > > by enabling CONFIG_NO_HZ_FULL and doing like:
> > >    # cd /sys/kernel/debug/tracing/
> > >    # echo 'p:mp1 __rcu_irq_enter_check_tick' >> kprobe_events
> > >    # echo 1 > events/kprobes/enable
> > > 
> > > So __rcu_irq_enter_check_tick() should not be kprobed, mark it as noinstr.
> > 
> > Good catch!
> > 
> > I am inclined to queue this, but noticed that one of its callers need
> > it to be noinstr but that the others do not.
> > 
> > Need noinstr:
> > 
> > o	enter_from_kernel_mode() -> __enter_from_kernel_mode() ->
> > 	rcu_irq_enter_check_tick() -> __rcu_irq_enter_check_tick()
> > 
> > Doesn't need noinstr:
> > 
> > o	ct_nmi_enter() -> rcu_irq_enter_check_tick() ->
> > 	__rcu_irq_enter_check_tick(), courtesy of the call to
> > 	instrumentation_begin() in ct_nmi_enter() that precedes the call
> > 	to rcu_irq_enter_check_tick().
> > 
> > o	irqentry_enter() -> rcu_irq_enter_check_tick() ->
> > 	__rcu_irq_enter_check_tick(), courtesy of the call to
> > 	instrumentation_begin() in irqentry_enter() that precedes the
> > 	call to rcu_irq_enter_check_tick().
> > 
> > Is tagging __rcu_irq_enter_check_tick() with noinstr as
> > proposed in this patch the right thing to do, or should there
> > be calls to instrumentation_begin() and instrumentation_end() in
> > enter_from_kernel_mode()?  Or something else entirely?
> 
> I have tried the calls to instrumentation_{begin,end}() in
> enter_from_kernel_mode(), see [1]. But this problem can still be
> reproduced, maybe more complete calltrace info [2] is needed for
> analyzing.
> 
> Did I add the instrumentation_{begin,end}() in wrong place or is there other
> caller need noinstr?

It looks OK to me, but that isn't saying much.

So I must defer to people knowing more about noinstr than do I.

							Thanx, Paul

> [1]
> diff --git a/arch/arm64/kernel/entry-common.c
> b/arch/arm64/kernel/entry-common.c
> index 27369fa1c032..deed5a0941d3 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -49,7 +49,9 @@ static __always_inline void
> __enter_from_kernel_mode(struct pt_regs *regs)
>         }
> 
>         lockdep_hardirqs_off(CALLER_ADDR0);
> +       instrumentation_begin();
>         rcu_irq_enter_check_tick();
> +       instrumentation_end();
>         trace_hardirqs_off_finish();
>  }
> 
> 
> [2]
> [   48.921197] Call trace:
> [   48.921241]  dump_backtrace+0xf8/0x108
> [   48.921358]  show_stack+0x20/0x48
> [   48.921418]  dump_stack_lvl+0x68/0x84
> [   48.921477]  dump_stack+0x1c/0x38
> [   48.921530]  panic+0x214/0x404
> [   48.921598]  add_taint+0x0/0xf0
> [   48.921657]  panic_bad_stack+0x144/0x160
> [   48.921715]  handle_bad_stack+0x38/0x58
> [   48.921774]  __bad_stack+0x78/0x7c
> [   48.921825]  __rcu_irq_enter_check_tick+0x0/0x1b8
> [   48.921886]  arm64_enter_el1_dbg.isra.0+0x14/0x20
> [   48.921949]  el1_dbg+0x2c/0x90
> [   48.922001]  el1h_64_sync_handler+0xcc/0xe8
> [   48.922061]  el1h_64_sync+0x64/0x68
> [   48.922112]  __rcu_irq_enter_check_tick+0x0/0x1b8
> [...]
> [   48.938382]  __rcu_irq_enter_check_tick+0x0/0x1b8
> [   48.938441]  arm64_enter_el1_dbg.isra.0+0x14/0x20
> [   48.938500]  el1_dbg+0x2c/0x90
> [   48.938549]  el1h_64_sync_handler+0xcc/0xe8
> [   48.938607]  el1h_64_sync+0x64/0x68
> [   48.938656]  __rcu_irq_enter_check_tick+0x0/0x1b8
> [   48.938715]  arm64_enter_el1_dbg.isra.0+0x14/0x20
> [   48.938778]  el1_dbg+0x2c/0x90
> [   48.938829]  el1h_64_sync_handler+0xcc/0xe8
> [   48.938887]  el1h_64_sync+0x64/0x68
> [   48.938936]  __rcu_irq_enter_check_tick+0x0/0x1b8
> [   48.938995]  arm64_enter_el1_dbg.isra.0+0x14/0x20
> [   48.939054]  el1_dbg+0x2c/0x90
> [   48.939105]  el1h_64_sync_handler+0xcc/0xe8
> [   48.939164]  el1h_64_sync+0x64/0x68
> [   48.939215]  __rcu_irq_enter_check_tick+0x0/0x1b8
> [   48.939274]  el1_interrupt+0x28/0x60
> [   48.939327]  el1h_64_irq_handler+0x18/0x28
> [   48.939385]  el1h_64_irq+0x64/0x68
> [   48.939434]  __asan_load8+0x54/0xa8
> [   48.939500]  __ftrace_set_clr_event_nolock+0x6c/0x198
> [   48.939563]  __ftrace_set_clr_event+0x58/0x80
> [   48.939618]  system_enable_write+0x144/0x178
> [   48.939673]  vfs_write+0x174/0x738
> [   48.939734]  ksys_write+0xd0/0x188
> [   48.939791]  __arm64_sys_write+0x4c/0x60
> [   48.939851]  invoke_syscall+0x64/0x180
> [   48.939921]  el0_svc_common.constprop.0+0x84/0x160
> [   48.939996]  do_el0_svc+0x48/0xf8
> [   48.940062]  el0_svc+0x34/0xd0
> [   48.940114]  el0t_64_sync_handler+0xb8/0xc0
> [   48.940173]  el0t_64_sync+0x18c/0x190
> [   48.940872] SMP: stopping secondary CPUs
> [   48.942844] Kernel Offset: 0x2d9499c00000 from 0xffff800008000000
> [   48.942938] PHYS_OFFSET: 0xffffaa9840000000
> [   48.942999] CPU features: 0x00000,00d00080,0000421b
> [   48.943387] Memory Limit: none
> 
> 
> > 
> > Thoughts?
> 
> Sorry, I have no more idea :-(
> 
> > 
> > 							Thanx, Paul
> > 
> > > [1]
> > > Insufficient stack space to handle exception!
> > > Insufficient stack space to handle exception!
> > > [...]
> > > Kernel panic - not syncing: kernel stack overflow
> > > CPU: 3 PID: 34 Comm: migration/3 Not tainted
> > > 6.1.0-rc5-00884-g84368d882b96 #2
> > > Hardware name: linux,dummy-virt (DT)
> > > Stopper: multi_cpu_stop+0x0/0x228 <- __stop_cpus.constprop.0+0xa4/0x100
> > > Call trace:
> > >   dump_backtrace+0xf8/0x108
> > >   show_stack+0x20/0x48
> > >   dump_stack_lvl+0x68/0x84
> > >   dump_stack+0x1c/0x38
> > >   panic+0x214/0x404
> > >   add_taint+0x0/0xf0
> > >   panic_bad_stack+0x144/0x160
> > >   handle_bad_stack+0x38/0x58
> > >   __bad_stack+0x78/0x7c
> > >   el1h_64_sync_handler+0x4/0xe8
> > >   __rcu_irq_enter_check_tick+0x0/0x1b8
> > >   arm64_enter_el1_dbg.isra.0+0x14/0x20
> > >   el1_dbg+0x2c/0x90
> > >   el1h_64_sync_handler+0xcc/0xe8
> > >   el1h_64_sync+0x64/0x68
> > >   __rcu_irq_enter_check_tick+0x0/0x1b8
> > >   arm64_enter_el1_dbg.isra.0+0x14/0x20
> > >   el1_dbg+0x2c/0x90
> > >   el1h_64_sync_handler+0xcc/0xe8
> > >   el1h_64_sync+0x64/0x68
> > >   __rcu_irq_enter_check_tick+0x0/0x1b8
> > >   arm64_enter_el1_dbg.isra.0+0x14/0x20
> > >   el1_dbg+0x2c/0x90
> > >   el1h_64_sync_handler+0xcc/0xe8
> > >   el1h_64_sync+0x64/0x68
> > >   __rcu_irq_enter_check_tick+0x0/0x1b8
> > >   arm64_enter_el1_dbg.isra.0+0x14/0x20
> > >   el1_dbg+0x2c/0x90
> > >   el1h_64_sync_handler+0xcc/0xe8
> > >   el1h_64_sync+0x64/0x68
> > >   __rcu_irq_enter_check_tick+0x0/0x1b8
> > >   arm64_enter_el1_dbg.isra.0+0x14/0x20
> > >   el1_dbg+0x2c/0x90
> > >   el1h_64_sync_handler+0xcc/0xe8
> > >   el1h_64_sync+0x64/0x68
> > >   __rcu_irq_enter_check_tick+0x0/0x1b8
> > >   [...]
> > > 
> > > Cc: stable@vger.kernel.org
> > > Fixes: aaf2bc50df1f ("rcu: Abstract out rcu_irq_enter_check_tick() from rcu_nmi_enter()")
> > > Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
> > > ---
> > >   kernel/rcu/tree.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 93416afebd59..68230f02cfb7 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -631,7 +631,7 @@ void rcu_irq_exit_check_preempt(void)
> > >    * controlled environments, this function allows RCU to get what it
> > >    * needs without creating otherwise useless interruptions.
> > >    */
> > > -void __rcu_irq_enter_check_tick(void)
> > > +noinstr void __rcu_irq_enter_check_tick(void)
> > >   {
> > >   	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> > > -- 
> > > 2.25.1
> > > 
> --
> Best regards,
> Zheng Yejian

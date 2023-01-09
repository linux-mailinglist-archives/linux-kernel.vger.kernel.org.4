Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8896D6630EC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237632AbjAIUEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237756AbjAIUEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:04:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B88613E22;
        Mon,  9 Jan 2023 12:04:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1899061359;
        Mon,  9 Jan 2023 20:04:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E8BC433D2;
        Mon,  9 Jan 2023 20:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673294677;
        bh=NhhGZTo9dDr67tTpFj/IeLzcZvoYZIl4+EODLR8/pDk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Wur6NKd2JWKzugPuwsQwWLUD+1aCoOqch4iHbCFDkgfDfT2DjKMdl0cZ1Ql+02+D1
         gXYn+gPnOL49iCfZh4VZ/2A07N23kmw9//zIBNTUZcuXbvgbJqQ20HlkxBMrnXTl+o
         ueGphep+Y96FzA8cX0jXw3WFClPFae3petm1N+PatOQJUFKDYHiaQcZ8BeDe7g9bqw
         Gik61f8YGvJxS1FKhtJQYZeIL8CJserQo1ZgYnLuh05gIJEoXVP4JicGwd4MhgUGPd
         y4aqL4NTxCHwCmFS2r424QdV57SptT9nnXBNOgNe6KRBSbQi+C75FSyEUXkzOaKuKy
         N4S9JxUe6pPdg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D13825C05C8; Mon,  9 Jan 2023 12:04:36 -0800 (PST)
Date:   Mon, 9 Jan 2023 12:04:36 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     frederic@kernel.org, jiangshanlai@gmail.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
        mhiramat@kernel.org, peterz@infradead.org,
        quic_neeraju@quicinc.com, rcu@vger.kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v2] rcu: Avoid stack overflow due to
 __rcu_irq_enter_check_tick() being kprobe-ed
Message-ID: <20230109200436.GY4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230106035423.3376283-1-zhengyejian1@huawei.com>
 <20230106070934.3434031-1-zhengyejian1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106070934.3434031-1-zhengyejian1@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 03:09:34PM +0800, Zheng Yejian wrote:
> Register kprobe on __rcu_irq_enter_check_tick() can cause kernel stack
> overflow [1]. This issue can be reproduced by enabling CONFIG_NO_HZ_FULL
> and boot kernel with argument "nohz_full=" then execute like:
>   # cd /sys/kernel/tracing/
>   # echo 'p:mp1 __rcu_irq_enter_check_tick' >> kprobe_events
>   # echo 1 > events/kprobes/enable
> 
> It seems __rcu_irq_enter_check_tick() should not be kprobe-ed, so add
> it into kprobe blacklist with NOKPROBE_SYMBOL(). This may have less impact
> than tagging as 'noinstr' which was discussed but not concluded in
> Link: https://lore.kernel.org/all/20221119040049.795065-1-zhengyejian1@huawei.com/

Queued for testing and further review, thank you!

Could you please check the wordsmithed version below?

							Thanx, Paul

------------------------------------------------------------------------

commit 5ceaf736da841c4bdb03049c7d6e0c0c41253161
Author: Zheng Yejian <zhengyejian1@huawei.com>
Date:   Fri Jan 6 15:09:34 2023 +0800

    rcu: Avoid stack overflow due to __rcu_irq_enter_check_tick() being kprobe-ed
    
    Registering a kprobe on __rcu_irq_enter_check_tick() can cause kernel
    stack overflow as shown below. This issue can be reproduced by enabling
    CONFIG_NO_HZ_FULL and booting the kernel with argument "nohz_full=",
    and then giving the following commands at the shell prompt:
    
      # cd /sys/kernel/tracing/
      # echo 'p:mp1 __rcu_irq_enter_check_tick' >> kprobe_events
      # echo 1 > events/kprobes/enable
    
    This commit therefore adds __rcu_irq_enter_check_tick() to the kprobes
    blacklist using NOKPROBE_SYMBOL().
    
    Insufficient stack space to handle exception!
    ESR: 0x00000000f2000004 -- BRK (AArch64)
    FAR: 0x0000ffffccf3e510
    Task stack:     [0xffff80000ad30000..0xffff80000ad38000]
    IRQ stack:      [0xffff800008050000..0xffff800008058000]
    Overflow stack: [0xffff089c36f9f310..0xffff089c36fa0310]
    CPU: 5 PID: 190 Comm: bash Not tainted 6.2.0-rc2-00320-g1f5abbd77e2c #19
    Hardware name: linux,dummy-virt (DT)
    pstate: 400003c5 (nZcv DAIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
    pc : __rcu_irq_enter_check_tick+0x0/0x1b8
    lr : ct_nmi_enter+0x11c/0x138
    sp : ffff80000ad30080
    x29: ffff80000ad30080 x28: ffff089c82e20000 x27: 0000000000000000
    x26: 0000000000000000 x25: ffff089c02a8d100 x24: 0000000000000000
    x23: 00000000400003c5 x22: 0000ffffccf3e510 x21: ffff089c36fae148
    x20: ffff80000ad30120 x19: ffffa8da8fcce148 x18: 0000000000000000
    x17: 0000000000000000 x16: 0000000000000000 x15: ffffa8da8e44ea6c
    x14: ffffa8da8e44e968 x13: ffffa8da8e03136c x12: 1fffe113804d6809
    x11: ffff6113804d6809 x10: 0000000000000a60 x9 : dfff800000000000
    x8 : ffff089c026b404f x7 : 00009eec7fb297f7 x6 : 0000000000000001
    x5 : ffff80000ad30120 x4 : dfff800000000000 x3 : ffffa8da8e3016f4
    x2 : 0000000000000003 x1 : 0000000000000000 x0 : 0000000000000000
    Kernel panic - not syncing: kernel stack overflow
    CPU: 5 PID: 190 Comm: bash Not tainted 6.2.0-rc2-00320-g1f5abbd77e2c #19
    Hardware name: linux,dummy-virt (DT)
    Call trace:
     dump_backtrace+0xf8/0x108
     show_stack+0x20/0x30
     dump_stack_lvl+0x68/0x84
     dump_stack+0x1c/0x38
     panic+0x214/0x404
     add_taint+0x0/0xf8
     panic_bad_stack+0x144/0x160
     handle_bad_stack+0x38/0x58
     __bad_stack+0x78/0x7c
     __rcu_irq_enter_check_tick+0x0/0x1b8
     arm64_enter_el1_dbg.isra.0+0x14/0x20
     el1_dbg+0x2c/0x90
     el1h_64_sync_handler+0xcc/0xe8
     el1h_64_sync+0x64/0x68
     __rcu_irq_enter_check_tick+0x0/0x1b8
     arm64_enter_el1_dbg.isra.0+0x14/0x20
     el1_dbg+0x2c/0x90
     el1h_64_sync_handler+0xcc/0xe8
     el1h_64_sync+0x64/0x68
     __rcu_irq_enter_check_tick+0x0/0x1b8
     arm64_enter_el1_dbg.isra.0+0x14/0x20
     el1_dbg+0x2c/0x90
     el1h_64_sync_handler+0xcc/0xe8
     el1h_64_sync+0x64/0x68
     __rcu_irq_enter_check_tick+0x0/0x1b8
     [...]
     el1_dbg+0x2c/0x90
     el1h_64_sync_handler+0xcc/0xe8
     el1h_64_sync+0x64/0x68
     __rcu_irq_enter_check_tick+0x0/0x1b8
     arm64_enter_el1_dbg.isra.0+0x14/0x20
     el1_dbg+0x2c/0x90
     el1h_64_sync_handler+0xcc/0xe8
     el1h_64_sync+0x64/0x68
     __rcu_irq_enter_check_tick+0x0/0x1b8
     arm64_enter_el1_dbg.isra.0+0x14/0x20
     el1_dbg+0x2c/0x90
     el1h_64_sync_handler+0xcc/0xe8
     el1h_64_sync+0x64/0x68
     __rcu_irq_enter_check_tick+0x0/0x1b8
     el1_interrupt+0x28/0x60
     el1h_64_irq_handler+0x18/0x28
     el1h_64_irq+0x64/0x68
     __ftrace_set_clr_event_nolock+0x98/0x198
     __ftrace_set_clr_event+0x58/0x80
     system_enable_write+0x144/0x178
     vfs_write+0x174/0x738
     ksys_write+0xd0/0x188
     __arm64_sys_write+0x4c/0x60
     invoke_syscall+0x64/0x180
     el0_svc_common.constprop.0+0x84/0x160
     do_el0_svc+0x48/0xe8
     el0_svc+0x34/0xd0
     el0t_64_sync_handler+0xb8/0xc0
     el0t_64_sync+0x190/0x194
    SMP: stopping secondary CPUs
    Kernel Offset: 0x28da86000000 from 0xffff800008000000
    PHYS_OFFSET: 0xfffff76600000000
    CPU features: 0x00000,01a00100,0000421b
    Memory Limit: none
    
    Link: https://lore.kernel.org/all/20221119040049.795065-1-zhengyejian1@huawei.com/
    Fixes: aaf2bc50df1f ("rcu: Abstract out rcu_irq_enter_check_tick() from rcu_nmi_enter()")
    Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
    Cc: stable@vger.kernel.org
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a6181b76fd5ab..63545d79da51c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -640,6 +640,7 @@ void __rcu_irq_enter_check_tick(void)
 	}
 	raw_spin_unlock_rcu_node(rdp->mynode);
 }
+NOKPROBE_SYMBOL(__rcu_irq_enter_check_tick);
 #endif /* CONFIG_NO_HZ_FULL */
 
 /*

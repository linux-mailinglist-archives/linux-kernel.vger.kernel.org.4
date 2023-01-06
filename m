Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C5C65FA7F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 04:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjAFDxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 22:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjAFDxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 22:53:01 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C8F4BD6E;
        Thu,  5 Jan 2023 19:52:59 -0800 (PST)
Received: from dggpeml100012.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Np8XK3HmYz16LyF;
        Fri,  6 Jan 2023 11:51:29 +0800 (CST)
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 6 Jan 2023 11:52:57 +0800
From:   Zheng Yejian <zhengyejian1@huawei.com>
To:     <frederic@kernel.org>, <paulmck@kernel.org>
CC:     <jiangshanlai@gmail.com>, <joel@joelfernandes.org>,
        <josh@joshtriplett.org>, <linux-kernel@vger.kernel.org>,
        <mathieu.desnoyers@efficios.com>, <mhiramat@kernel.org>,
        <quic_neeraju@quicinc.com>, <rcu@vger.kernel.org>,
        <rostedt@goodmis.org>, <peterz@infradead.org>,
        <zhengyejian1@huawei.com>
Subject: [PATCH] rcu: Avoid kernel stack overflow due to rcu_irq_enter_check_tick() being kprobe-ed
Date:   Fri, 6 Jan 2023 11:54:23 +0800
Message-ID: <20230106035423.3376283-1-zhengyejian1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.61]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register kprobe on __rcu_irq_enter_check_tick() can cause kernel stack
overflow [1]. This issue can be reproduced by enabling CONFIG_NO_HZ_FULL
and boot kernel with argument "nohz_full=" then execute like:
  # cd /sys/kernel/tracing/
  # echo 'p:mp1 __rcu_irq_enter_check_tick' >> kprobe_events
  # echo 1 > events/kprobes/enable

It seems __rcu_irq_enter_check_tick() should not be kprobe-ed, so add
it into kprobe blacklist with NOKPROBE_SYMBOL(). This may have less impact
than tagging as 'noinstr' which was discussed but not concluded in
Link: https://lore.kernel.org/all/20221119040049.795065-1-zhengyejian1@huawei.com/

[1]
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

Cc: stable@vger.kernel.org
Fixes: aaf2bc50df1f ("rcu: Abstract out rcu_irq_enter_check_tick() from rcu_nmi_enter()")
Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
---
 kernel/rcu/tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index cf34a961821a..41606d3ed083 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -659,6 +659,7 @@ void __rcu_irq_enter_check_tick(void)
 	}
 	raw_spin_unlock_rcu_node(rdp->mynode);
 }
+NOKPROBE_SYMBOL(__rcu_irq_enter_check_tick);
 #endif /* CONFIG_NO_HZ_FULL */
 
 /*
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BDB747E43
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 09:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbjGEHbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 03:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjGEHbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 03:31:49 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9683E4F;
        Wed,  5 Jul 2023 00:31:47 -0700 (PDT)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Qwrtv20hqzqTV9;
        Wed,  5 Jul 2023 15:31:19 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 15:31:44 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, <rcu@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 0/2] rcu: Don't dump the stalled CPU on where RCU GP kthread last ran twice
Date:   Wed, 5 Jul 2023 15:30:18 +0800
Message-ID: <20230705073020.2030-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stacks of all stalled CPUs will be dumped. If the CPU on where RCU GP
kthread last ran is stalled, its stack does not need to be dumped again.

For example: Please search "Sending NMI from CPU 1 to CPUs 0"
rcu: INFO: rcu_sched self-detected stall on CPU
rcu:    1-...!: (999 ticks this GP) idle=a1e4/1/0x40000002 softirq=116/116 fqs=0
rcu:    (t=1000 jiffies g=-875 q=18 ncpus=4)
rcu: rcu_sched kthread timer wakeup didn't happen for 999 jiffies! g-875 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
rcu:    Possible timer handling issue on cpu=0 timer-softirq=449
rcu: rcu_sched kthread starved for 1000 jiffies! g-875 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=0
rcu:    Unless rcu_sched kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_sched       state:I stack:0     pid:12    ppid:2      flags:0x00000000
 __schedule from schedule+0x50/0xa4
 schedule from schedule_timeout+0x1f8/0x328
 schedule_timeout from rcu_gp_fqs_loop+0x330/0x464
 rcu_gp_fqs_loop from rcu_gp_kthread+0xb0/0x200
 rcu_gp_kthread from kthread+0xe8/0x104
 kthread from ret_from_fork+0x14/0x2c
Exception stack(0xc0855fb0 to 0xc0855ff8)
5fa0:                                     00000000 00000000 00000000 00000000
5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
rcu: Stack dump where RCU GP kthread last ran:
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.4.0-rc1+ #2
Hardware name: ARM-Versatile Express
PC is at ktime_get+0x4c/0xe8
LR is at ktime_get+0x4c/0xe8
pc : [<801a61a4>]    lr : [<801a61a4>]    psr: 60000113
sp : 80d01e48  ip : 00000002  fp : 0000001a
r10: 5befcd40  r9 : 431bde82  r8 : d7b634db
r7 : 00001bb0  r6 : 9ad70c88  r5 : 00000002  r4 : 80db0f40
r3 : ffffffff  r2 : f8a7b162  r1 : 00000000  r0 : 07584e9d
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 6000406a  DAC: 00000051
 ktime_get from tst_softirq+0x30/0xfc
 tst_softirq from __do_softirq+0x128/0x334
 __do_softirq from irq_exit+0x108/0x12c
 irq_exit from __irq_svc+0x88/0xb0
Exception stack(0x80d01f18 to 0x80d01f60)
1f00:                                                       00490d54 00000001
1f20: 80d07fc0 00000000 80d9d260 80d04cd0 00000001 80d04d18 80c5ec18 00000000
1f40: 80d9bc35 80d07fc0 80d9cc80 80d01f68 808d6a6c 808d79f8 60000013 ffffffff
 __irq_svc from default_idle_call+0x4c/0xb4
 default_idle_call from do_idle+0x1a8/0x288
 do_idle from cpu_startup_entry+0x18/0x1c
 cpu_startup_entry from rest_init+0xb4/0xb8
 rest_init from arch_post_acpi_subsys_init+0x0/0x8
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.4.0-rc1+ #2
Hardware name: ARM-Versatile Express
PC is at ktime_get+0x4c/0xe8
LR is at ktime_get+0x4c/0xe8
pc : [<801a61a4>]    lr : [<801a61a4>]    psr: 60000113
sp : 80d01e48  ip : 00000002  fp : 0000001a
r10: 5befcd40  r9 : 431bde82  r8 : d7b634db
r7 : 00001bb2  r6 : 9ad70c88  r5 : 00000002  r4 : 80db0f40
r3 : ffffffff  r2 : f8a78d88  r1 : 00000000  r0 : 07587277
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 6000406a  DAC: 00000051
 ktime_get from tst_softirq+0x30/0xfc
 tst_softirq from __do_softirq+0x128/0x334
 __do_softirq from irq_exit+0x108/0x12c
 irq_exit from __irq_svc+0x88/0xb0
Exception stack(0x80d01f18 to 0x80d01f60)
1f00:                                                       00490d54 00000001
1f20: 80d07fc0 00000000 80d9d260 80d04cd0 00000001 80d04d18 80c5ec18 00000000
1f40: 80d9bc35 80d07fc0 80d9cc80 80d01f68 808d6a6c 808d79f8 60000013 ffffffff
 __irq_svc from default_idle_call+0x4c/0xb4
 default_idle_call from do_idle+0x1a8/0x288
 do_idle from cpu_startup_entry+0x18/0x1c
 cpu_startup_entry from rest_init+0xb4/0xb8
 rest_init from arch_post_acpi_subsys_init+0x0/0x8
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.4.0-rc1+ #2
Hardware name: ARM-Versatile Express
PC is at default_idle_call+0x4c/0xb4
LR is at ct_kernel_enter.constprop.5+0x44/0x11c
pc : [<808d79f8>]    lr : [<808d6a6c>]    psr: 60000013
sp : c085df98  ip : 80d9cc80  fp : 81126e80
r10: 80d9bc35  r9 : 00000000  r8 : 80c5ec18
r7 : 80d04d18  r6 : 00000002  r5 : 80d04cd0  r4 : 80d9d260
r3 : 00000000  r2 : 81126e80  r1 : 00000001  r0 : 0050a1e4
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 6802806a  DAC: 00000051
 default_idle_call from do_idle+0x1a8/0x288
 do_idle from cpu_startup_entry+0x18/0x1c
 cpu_startup_entry from secondary_start_kernel+0x14c/0x150
 secondary_start_kernel from 0x60101660
Sending NMI from CPU 1 to CPUs 3:
NMI backtrace for cpu 3 skipped: idling at default_idle_call+0x4c/0xb4


Zhen Lei (2):
  rcu: Delete a redundant check in rcu_check_gp_kthread_starvation()
  rcu: Don't dump the stalled CPU on where RCU GP kthread last ran twice

 kernel/rcu/tree_stall.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

-- 
2.25.1


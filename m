Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8098A6B6FC6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 07:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjCMG6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 02:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjCMG6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 02:58:35 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13D627D50
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 23:58:28 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PZnTv0GLCzSkd4;
        Mon, 13 Mar 2023 14:55:15 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 14:58:26 +0800
From:   Yicong Yang <yangyicong@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <linux-kernel@vger.kernel.org>
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <linuxarm@huawei.com>,
        <prime.zeng@huawei.com>, <wangjie125@huawei.com>,
        <yangyicong@hisilicon.com>
Subject: [PATCH] sched/fair: Don't balance migration disabled tasks
Date:   Mon, 13 Mar 2023 14:57:59 +0800
Message-ID: <20230313065759.39698-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yicong Yang <yangyicong@hisilicon.com>

On load balance we didn't check whether the candidate task is migration
disabled or not, this may hit the WARN_ON in set_task_cpu() since the
migration disabled tasks are expected to run on their current CPU.
We've run into this case several times on our server:

 ------------[ cut here ]------------
 WARNING: CPU: 7 PID: 0 at kernel/sched/core.c:3115 set_task_cpu+0x188/0x240
 Modules linked in: hclgevf xt_CHECKSUM ipt_REJECT nf_reject_ipv4 <...snip>
 CPU: 7 PID: 0 Comm: swapper/7 Kdump: loaded Tainted: G           O       6.1.0-rc4+ #1
 Hardware name: Huawei TaiShan 2280 V2/BC82AMDC, BIOS 2280-V2 CS V5.B221.01 12/09/2021
 pstate: 604000c9 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : set_task_cpu+0x188/0x240
 lr : load_balance+0x5d0/0xc60
 sp : ffff80000803bc70
 x29: ffff80000803bc70 x28: ffff004089e190e8 x27: ffff004089e19040
 x26: ffff007effcabc38 x25: 0000000000000000 x24: 0000000000000001
 x23: ffff80000803be84 x22: 000000000000000c x21: ffffb093e79e2a78
 x20: 000000000000000c x19: ffff004089e19040 x18: 0000000000000000
 x17: 0000000000001fad x16: 0000000000000030 x15: 0000000000000000
 x14: 0000000000000003 x13: 0000000000000000 x12: 0000000000000000
 x11: 0000000000000001 x10: 0000000000000400 x9 : ffffb093e4cee530
 x8 : 00000000fffffffe x7 : 0000000000ce168a x6 : 000000000000013e
 x5 : 00000000ffffffe1 x4 : 0000000000000001 x3 : 0000000000000b2a
 x2 : 0000000000000b2a x1 : ffffb093e6d6c510 x0 : 0000000000000001
 Call trace:
  set_task_cpu+0x188/0x240
  load_balance+0x5d0/0xc60
  rebalance_domains+0x26c/0x380
  _nohz_idle_balance.isra.0+0x1e0/0x370
  run_rebalance_domains+0x6c/0x80
  __do_softirq+0x128/0x3d8
  ____do_softirq+0x18/0x24
  call_on_irq_stack+0x2c/0x38
  do_softirq_own_stack+0x24/0x3c
  __irq_exit_rcu+0xcc/0xf4
  irq_exit_rcu+0x18/0x24
  el1_interrupt+0x4c/0xe4
  el1h_64_irq_handler+0x18/0x2c
  el1h_64_irq+0x74/0x78
  arch_cpu_idle+0x18/0x4c
  default_idle_call+0x58/0x194
  do_idle+0x244/0x2b0
  cpu_startup_entry+0x30/0x3c
  secondary_start_kernel+0x14c/0x190
  __secondary_switched+0xb0/0xb4
 ---[ end trace 0000000000000000 ]---

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 kernel/sched/fair.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7a1b1f855b96..8fe767362d22 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8433,6 +8433,10 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	if (kthread_is_per_cpu(p))
 		return 0;
 
+	/* Migration disabled tasks need to be kept on their running CPU. */
+	if (is_migration_disabled(p))
+		return 0;
+
 	if (!cpumask_test_cpu(env->dst_cpu, p->cpus_ptr)) {
 		int cpu;
 
-- 
2.24.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987E9722F97
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235081AbjFETRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235452AbjFETQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:16:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D7C10A;
        Mon,  5 Jun 2023 12:16:23 -0700 (PDT)
Date:   Mon, 05 Jun 2023 19:16:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685992582;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/dp1jLmsaN1DY1rvwMzQoKHr01XU+rlLrdjw7ZKItgw=;
        b=BOC/uDUP3MNvvEz0Sl9zKSUioAT0ODK7mrPEh0q2Y3KTC42rwYRu0Onj5ubXEd65+d2F/d
        rpzP4RtzfNl1yY8lDt+L0/YcW7pjkFsaRuJY1TGP6gePoKOLbAhytMp35NP8+5YhJJPCbB
        /+rhjfrS4Z/2i83NxOxDsn5ecjw8tlXUUvnjB5flBg1b/LATLSHf6CaZ67hHzIz34H3IVk
        nEKxTY5xEUUVrigdTx89cDUQd8QecFU90pGbXbaWyUVeqGaRdUor2sChBfXChVPGJKttYY
        qwXMjzagxNoTF6tZJJ0tvZYMMYrvQkMuM26Rh7BFpSVE2PEl14JJ9g7uIjrVag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685992582;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/dp1jLmsaN1DY1rvwMzQoKHr01XU+rlLrdjw7ZKItgw=;
        b=OuqBxhkebCvk1yZWb2hw+adWolmUE7pwbvBrXXQtGNRqVTmPpncF5QZRYGXnUrVpEhdEge
        doxE0rZx7wk39ZBA==
From:   "tip-bot2 for Yicong Yang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Don't balance task to its current running CPU
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230530082507.10444-1-yangyicong@huawei.com>
References: <20230530082507.10444-1-yangyicong@huawei.com>
MIME-Version: 1.0
Message-ID: <168599258148.404.1918167188216154536.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     0dd37d6dd33a9c23351e6115ae8cdac7863bc7de
Gitweb:        https://git.kernel.org/tip/0dd37d6dd33a9c23351e6115ae8cdac7863bc7de
Author:        Yicong Yang <yangyicong@hisilicon.com>
AuthorDate:    Tue, 30 May 2023 16:25:07 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jun 2023 21:08:24 +02:00

sched/fair: Don't balance task to its current running CPU

We've run into the case that the balancer tries to balance a migration
disabled task and trigger the warning in set_task_cpu() like below:

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

Further investigation shows that the warning is superfluous, the migration
disabled task is just going to be migrated to its current running CPU.
This is because that on load balance if the dst_cpu is not allowed by the
task, we'll re-select a new_dst_cpu as a candidate. If no task can be
balanced to dst_cpu we'll try to balance the task to the new_dst_cpu
instead. In this case when the migration disabled task is not on CPU it
only allows to run on its current CPU, load balance will select its
current CPU as new_dst_cpu and later triggers the warning above.

The new_dst_cpu is chosen from the env->dst_grpmask. Currently it
contains CPUs in sched_group_span() and if we have overlapped groups it's
possible to run into this case. This patch makes env->dst_grpmask of
group_balance_mask() which exclude any CPUs from the busiest group and
solve the issue. For balancing in a domain with no overlapped groups
the behaviour keeps same as before.

Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20230530082507.10444-1-yangyicong@huawei.com
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 48b6f0c..df0ff90 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10742,7 +10742,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 		.sd		= sd,
 		.dst_cpu	= this_cpu,
 		.dst_rq		= this_rq,
-		.dst_grpmask    = sched_group_span(sd->groups),
+		.dst_grpmask    = group_balance_mask(sd->groups),
 		.idle		= idle,
 		.loop_break	= SCHED_NR_MIGRATE_BREAK,
 		.cpus		= cpus,

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4BE65E1A1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240158AbjAEAeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240105AbjAEAdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:33:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932E04FCFD;
        Wed,  4 Jan 2023 16:29:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F161EB81986;
        Thu,  5 Jan 2023 00:28:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 904A6C433F0;
        Thu,  5 Jan 2023 00:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672878534;
        bh=EfKn+za+RXFVdYIpJD0qzO7znXyLggs4dJNn7aK9fX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OZSmUHccYCPEKD2FHtjVEeA75dMfZs1Zbbz7DiSO3bnPcpyRfC5FORTrKOEDiTRLl
         qTpEdhzzF62tSs+juHxYSvS4fWYwGHXgg/R6x3s+2O+4Gg8NxSTSvx0NSe9QHaSlyK
         V4TJA6soPOxMSv5VJCZn9oKUWXdG/JUiDsnh13tF9yjQw5X4aa0UioMytBmfnAYjM0
         Tzg2ERedJnv4Lntewy8A1A491qJzVg9jLpabBWyj7mrOJ8JOAX/4zCgNsR50Uva8KC
         L5Yxrez+fGuaAKiy5R3CMihjwJkCxgmzDW/fAVLWPxt/DYHW5b2qhTTeETQHrAMt8x
         dUM10eSeaj4Uw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 46D775C086D; Wed,  4 Jan 2023 16:28:54 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, Pingfan Liu <kernelfans@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH rcu 2/9] srcu: Delegate work to the boot cpu if using SRCU_SIZE_SMALL
Date:   Wed,  4 Jan 2023 16:28:46 -0800
Message-Id: <20230105002853.1769401-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105002845.GA1769240@paulmck-ThinkPad-P17-Gen-1>
References: <20230105002845.GA1769240@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pingfan Liu <kernelfans@gmail.com>

Commit 994f706872e6 ("srcu: Make Tree SRCU able to operate without
snp_node array") assumes that cpu 0 is always online.  However, there
really are situations when some other CPU is the boot CPU, for example,
when booting a kdump kernel with the maxcpus=1 boot parameter.

On PowerPC, the kdump kernel can hang as follows:
...
[    1.740036] systemd[1]: Hostname set to <xyz.com>
[  243.686240] INFO: task systemd:1 blocked for more than 122 seconds.
[  243.686264]       Not tainted 6.1.0-rc1 #1
[  243.686272] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  243.686281] task:systemd         state:D stack:0     pid:1     ppid:0      flags:0x00042000
[  243.686296] Call Trace:
[  243.686301] [c000000016657640] [c000000016657670] 0xc000000016657670 (unreliable)
[  243.686317] [c000000016657830] [c00000001001dec0] __switch_to+0x130/0x220
[  243.686333] [c000000016657890] [c000000010f607b8] __schedule+0x1f8/0x580
[  243.686347] [c000000016657940] [c000000010f60bb4] schedule+0x74/0x140
[  243.686361] [c0000000166579b0] [c000000010f699b8] schedule_timeout+0x168/0x1c0
[  243.686374] [c000000016657a80] [c000000010f61de8] __wait_for_common+0x148/0x360
[  243.686387] [c000000016657b20] [c000000010176bb0] __flush_work.isra.0+0x1c0/0x3d0
[  243.686401] [c000000016657bb0] [c0000000105f2768] fsnotify_wait_marks_destroyed+0x28/0x40
[  243.686415] [c000000016657bd0] [c0000000105f21b8] fsnotify_destroy_group+0x68/0x160
[  243.686428] [c000000016657c40] [c0000000105f6500] inotify_release+0x30/0xa0
[  243.686440] [c000000016657cb0] [c0000000105751a8] __fput+0xc8/0x350
[  243.686452] [c000000016657d00] [c00000001017d524] task_work_run+0xe4/0x170
[  243.686464] [c000000016657d50] [c000000010020e94] do_notify_resume+0x134/0x140
[  243.686478] [c000000016657d80] [c00000001002eb18] interrupt_exit_user_prepare_main+0x198/0x270
[  243.686493] [c000000016657de0] [c00000001002ec60] syscall_exit_prepare+0x70/0x180
[  243.686505] [c000000016657e10] [c00000001000bf7c] system_call_vectored_common+0xfc/0x280
[  243.686520] --- interrupt: 3000 at 0x7fffa47d5ba4
[  243.686528] NIP:  00007fffa47d5ba4 LR: 0000000000000000 CTR: 0000000000000000
[  243.686538] REGS: c000000016657e80 TRAP: 3000   Not tainted  (6.1.0-rc1)
[  243.686548] MSR:  800000000000d033 <SF,EE,PR,ME,IR,DR,RI,LE>  CR: 42044440  XER: 00000000
[  243.686572] IRQMASK: 0
[  243.686572] GPR00: 0000000000000006 00007ffffa606710 00007fffa48e7200 0000000000000000
[  243.686572] GPR04: 0000000000000002 000000000000000a 0000000000000000 0000000000000001
[  243.686572] GPR08: 000001000c172dd0 0000000000000000 0000000000000000 0000000000000000
[  243.686572] GPR12: 0000000000000000 00007fffa4ff4bc0 0000000000000000 0000000000000000
[  243.686572] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[  243.686572] GPR20: 0000000132dfdc50 000000000000000e 0000000000189375 0000000000000000
[  243.686572] GPR24: 00007ffffa606ae0 0000000000000005 000001000c185490 000001000c172570
[  243.686572] GPR28: 000001000c172990 000001000c184850 000001000c172e00 00007fffa4fedd98
[  243.686683] NIP [00007fffa47d5ba4] 0x7fffa47d5ba4
[  243.686691] LR [0000000000000000] 0x0
[  243.686698] --- interrupt: 3000
[  243.686708] INFO: task kworker/u16:1:24 blocked for more than 122 seconds.
[  243.686717]       Not tainted 6.1.0-rc1 #1
[  243.686724] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  243.686733] task:kworker/u16:1   state:D stack:0     pid:24    ppid:2      flags:0x00000800
[  243.686747] Workqueue: events_unbound fsnotify_mark_destroy_workfn
[  243.686758] Call Trace:
[  243.686762] [c0000000166736e0] [c00000004fd91000] 0xc00000004fd91000 (unreliable)
[  243.686775] [c0000000166738d0] [c00000001001dec0] __switch_to+0x130/0x220
[  243.686788] [c000000016673930] [c000000010f607b8] __schedule+0x1f8/0x580
[  243.686801] [c0000000166739e0] [c000000010f60bb4] schedule+0x74/0x140
[  243.686814] [c000000016673a50] [c000000010f699b8] schedule_timeout+0x168/0x1c0
[  243.686827] [c000000016673b20] [c000000010f61de8] __wait_for_common+0x148/0x360
[  243.686840] [c000000016673bc0] [c000000010210840] __synchronize_srcu.part.0+0xa0/0xe0
[  243.686855] [c000000016673c30] [c0000000105f2c64] fsnotify_mark_destroy_workfn+0xc4/0x1a0
[  243.686868] [c000000016673ca0] [c000000010174ea8] process_one_work+0x2a8/0x570
[  243.686882] [c000000016673d40] [c000000010175208] worker_thread+0x98/0x5e0
[  243.686895] [c000000016673dc0] [c0000000101828d4] kthread+0x124/0x130
[  243.686908] [c000000016673e10] [c00000001000cd40] ret_from_kernel_thread+0x5c/0x64
[  366.566274] INFO: task systemd:1 blocked for more than 245 seconds.
[  366.566298]       Not tainted 6.1.0-rc1 #1
[  366.566305] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  366.566314] task:systemd         state:D stack:0     pid:1     ppid:0      flags:0x00042000
[  366.566329] Call Trace:
...

The above splat occurs because PowerPC really does use maxcpus=1
instead of nr_cpus=1 in the kernel command line.  Consequently, the
(quite possibly non-zero) kdump CPU is the only online CPU in the kdump
kernel.  SRCU unconditionally queues a sdp->work on cpu 0, for which no
worker thread has been created, so sdp->work will be never executed and
__synchronize_srcu() will never be completed.

This commit therefore replaces CPU ID 0 with get_boot_cpu_id() in key
places in Tree SRCU.  Since the CPU indicated by get_boot_cpu_id()
is guaranteed to be online, this avoids the above splat.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: rcu@vger.kernel.org
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index ca4b5dcec675b..16953784a0bdf 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -726,7 +726,7 @@ static void srcu_gp_start(struct srcu_struct *ssp)
 	int state;
 
 	if (smp_load_acquire(&ssp->srcu_size_state) < SRCU_SIZE_WAIT_BARRIER)
-		sdp = per_cpu_ptr(ssp->sda, 0);
+		sdp = per_cpu_ptr(ssp->sda, get_boot_cpu_id());
 	else
 		sdp = this_cpu_ptr(ssp->sda);
 	lockdep_assert_held(&ACCESS_PRIVATE(ssp, lock));
@@ -837,7 +837,8 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 	/* Initiate callback invocation as needed. */
 	ss_state = smp_load_acquire(&ssp->srcu_size_state);
 	if (ss_state < SRCU_SIZE_WAIT_BARRIER) {
-		srcu_schedule_cbs_sdp(per_cpu_ptr(ssp->sda, 0), cbdelay);
+		srcu_schedule_cbs_sdp(per_cpu_ptr(ssp->sda, get_boot_cpu_id()),
+					cbdelay);
 	} else {
 		idx = rcu_seq_ctr(gpseq) % ARRAY_SIZE(snp->srcu_have_cbs);
 		srcu_for_each_node_breadth_first(ssp, snp) {
@@ -1161,7 +1162,7 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
 	idx = __srcu_read_lock_nmisafe(ssp);
 	ss_state = smp_load_acquire(&ssp->srcu_size_state);
 	if (ss_state < SRCU_SIZE_WAIT_CALL)
-		sdp = per_cpu_ptr(ssp->sda, 0);
+		sdp = per_cpu_ptr(ssp->sda, get_boot_cpu_id());
 	else
 		sdp = raw_cpu_ptr(ssp->sda);
 	spin_lock_irqsave_sdp_contention(sdp, &flags);
@@ -1497,7 +1498,7 @@ void srcu_barrier(struct srcu_struct *ssp)
 
 	idx = __srcu_read_lock_nmisafe(ssp);
 	if (smp_load_acquire(&ssp->srcu_size_state) < SRCU_SIZE_WAIT_BARRIER)
-		srcu_barrier_one_cpu(ssp, per_cpu_ptr(ssp->sda, 0));
+		srcu_barrier_one_cpu(ssp, per_cpu_ptr(ssp->sda,	get_boot_cpu_id()));
 	else
 		for_each_possible_cpu(cpu)
 			srcu_barrier_one_cpu(ssp, per_cpu_ptr(ssp->sda, cpu));
-- 
2.31.1.189.g2e36527f23


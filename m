Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301C96CB741
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 08:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjC1GgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 02:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjC1GgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 02:36:19 -0400
Received: from out28-76.mail.aliyun.com (out28-76.mail.aliyun.com [115.124.28.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E349612E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 23:36:17 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1147712|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.150056-0.238842-0.611101;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047201;MF=victor@allwinnertech.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.S0fYFjk_1679985371;
Received: from SunxiBot.allwinnertech.com(mailfrom:victor@allwinnertech.com fp:SMTPD_---.S0fYFjk_1679985371)
          by smtp.aliyun-inc.com;
          Tue, 28 Mar 2023 14:36:12 +0800
From:   Victor Hassan <victor@allwinnertech.com>
To:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        jindong.yue@nxp.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] tick/broadcast: Do not set oneshot_mask except was_periodic was true
Date:   Tue, 28 Mar 2023 14:36:29 +0800
Message-Id: <20230328063629.108510-1-victor@allwinnertech.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a broadcast timer is registered after the system switched to oneshot
mode, a hang_task err could occur like that:

INFO: task kworker/u15:0:7 blocked for more than 120 seconds.
      Tainted: G            E     5.15.41-android13-8-00002-xxx #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u16:0   state:D stack: 9808 pid:  7 ppid: 2 flags:0x00000008
Workqueue: events_unbound deferred_probe_work_func.cfi_jt
Call trace:
 __switch_to+0y240/0x490
 __schedule+0x620/0xafc
 schedule+0x110/0x204
 schedule_hrtimeout_range_clock+0x9c/0x118
 usleep_range_state+0x150/0x1ac
 _regulator_do_enable+0x528/0x878
 set_machine_constraints+0x6a0/0xf2c
 regulator_register+0x3ac/0x7ac
 devm_regulator_register+0xbc/0x120
 pmu_ext_regulator_probe+0xb0/0x1b4 [pmu_ext_regulator]
 platform_probe+0x70/0x194
 really_proe+0x320/0x68c
 __driver_probe_device+0x204/0x260
 driver_probe_device+0x48/0x1e0

When the new broadcast timer was registered after the system switched
to oneshot mode, the broadcast timer was not used as periodic. If the
oneshot mask was set incorrectly, all cores which did not enter cpu_idle
state can't enter cpu_idle normally, causing the hrtimer mechanism to
break.

This patch fixes the issue by moving the update action about oneshot
mask to a more strict conditions. The tick_broadcast_setup_oneshot would
be called in two typical condition, and they all will work.

1. tick_handle_periodic -> tick_broadcast_setup_oneshot

The origin broadcast was periodic, so it can set the oneshot_mask bits
for those waiting for periodic broadcast and program the broadcast timer
to fire.

2. tick_install_broadcast_device -> tick_broadcast_setup_oneshot

The origin broadcast was oneshot, so the cores which enter the cpu_idle
already used the oneshot_mask bits. It is unnecessary to update the
oneshot_mask.

Fixes: 9c336c9935cf ("tick/broadcast: Allow late registered device to enter oneshot mode")

Signed-off-by: Victor Hassan <victor@allwinnertech.com>
---
 kernel/time/tick-broadcast.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index 93bf2b4e47e5..fdbbba487978 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -1041,12 +1041,13 @@ static void tick_broadcast_setup_oneshot(struct clock_event_device *bc)
 		 */
 		cpumask_copy(tmpmask, tick_broadcast_mask);
 		cpumask_clear_cpu(cpu, tmpmask);
-		cpumask_or(tick_broadcast_oneshot_mask,
-			   tick_broadcast_oneshot_mask, tmpmask);
 
 		if (was_periodic && !cpumask_empty(tmpmask)) {
 			ktime_t nextevt = tick_get_next_period();
 
+			cpumask_or(tick_broadcast_oneshot_mask,
+				   tick_broadcast_oneshot_mask, tmpmask);
+
 			clockevents_switch_state(bc, CLOCK_EVT_STATE_ONESHOT);
 			tick_broadcast_init_next_event(tmpmask, nextevt);
 			tick_broadcast_set_event(bc, cpu, nextevt);
-- 
2.29.0


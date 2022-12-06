Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBA1643D69
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 08:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbiLFHGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 02:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiLFHGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 02:06:05 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E955962C0
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 23:06:01 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id b11so13579392pjp.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 23:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kkh8W0LCJzav4cQwsrSwQrEDd3HGb9h8U80aOd4/ghs=;
        b=YZWFR/6Apr2IjpOOPNxVeSxca/he4WUP7cfSVCoWZB6HY/dMMDJFmCJ4O+55bDASCM
         pUP/9l1rTd45xmBI/1Dyp6xuzPOXVpmJQHE9YITPnxeJdoNR0/LHX74czNzsnzIVCf+o
         rm46F0KXeMuOTecH4Glq9t2dcpyhmnSZNTH0d2UYq9rgdT4MT3rbJJ14VLl94EY0TgG3
         c6L8lDDEL2EDhsefmlXnOUDDdFqjCmaWndBiaEgQz3CB0XJ4a2bXeoC/wXtWw9KzuKuQ
         RX9wsdIwFFv+0arLCEdRAOCgGwYzpyWHpYv7jsQ1FLxJBh9nrbk7YG/rNEzeCJuIxPi/
         MS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kkh8W0LCJzav4cQwsrSwQrEDd3HGb9h8U80aOd4/ghs=;
        b=Vjcd26yYvWdL4PRUFbDJ6rO/KVW7rf5kaF3GP6gQ79IB9gZBf6tMo29KPDE1HveUza
         M91VZnb9GZi1LT4Y2xmGqUpyRn3Ucayz3h11KBtM0NgDhWtKzd0ZQRiJwKE/v1z7aiD6
         MnV0wJSTSS3I91EV+3hpnB0VCbHJ4MroDVW7489hLHMqFhZBZHfHdsxmVVJKpm0SLluB
         pqlAoPc6rb7Ja2/mMHc73x1mohxZmz+cKIXfuMkyd64eFsWfSID6tupoMXpCXnl3uTr7
         rAluzC8V9+9MlH1bY/dNqQae50LOPd77HhWvyBcLiC7WDT7r6PWlRHTSp0qzvRuRfqcD
         nC/g==
X-Gm-Message-State: ANoB5plwi9b9/lk1yz4yGSAy3wxbuYzhh/lQq8/Tf/A8Q29D4g8gqNel
        M51lwoR512G5VxVpOGF9GDexJw==
X-Google-Smtp-Source: AA0mqf5ScjEgh4w8T5bv2it/L7Wu70kdC07QUsu+XjdEvEyCYm4boaPjzpjlR41FqNIjFeCYzul54g==
X-Received: by 2002:a17:90b:2801:b0:200:2069:7702 with SMTP id qb1-20020a17090b280100b0020020697702mr11231578pjb.239.1670310361410;
        Mon, 05 Dec 2022 23:06:01 -0800 (PST)
Received: from C02G87K0MD6R.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id w64-20020a17090a6bc600b00219025945dcsm12091771pjj.19.2022.12.05.23.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 23:06:00 -0800 (PST)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH] sched/core: Avoid WARN_DOUBLE_CLOCK warning when CONFIG_SCHED_CORE
Date:   Tue,  6 Dec 2022 15:05:50 +0800
Message-Id: <20221206070550.31763-1-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we need to call update_rq_clock() to update the rq clock of
other CPUs on the same core, before that we need to clear RQCF_UPDATED
of rq->clock_update_flags to avoid the WARN_DOUBLE_CLOCK warning.
Because at this time the rq->clock_update_flags of other CPUs
may be RQCF_UPDATED.

Some call trace reports:
Call Trace 1:
<TASK>
__schedule+0x61c/0x11d0
schedule+0x5d/0xd0
worker_thread+0xb5/0x380
? preempt_count_add+0x56/0xa0
? rescuer_thread+0x310/0x310
kthread+0xe6/0x110
? kthread_complete_and_exit+0x20/0x20
ret_from_fork+0x1f/0x30
</TASK>

Call Trace 2:
<TASK>
__schedule+0x91d/0x11d0
schedule+0x5d/0xd0
exit_to_user_mode_prepare+0xe5/0x1e0
syscall_exit_to_user_mode+0x17/0x30
do_syscall_64+0x40/0x90
entry_SYSCALL_64_after_hwframe+0x63/0xcd

Call Trace 3:
<IRQ>
__sched_core_tick+0x27/0x40
scheduler_tick+0x1be/0x270
? tick_sched_handle.isra.18+0x60/0x60
update_process_times+0x6a/0x90
tick_sched_handle.isra.18+0x1f/0x60
tick_sched_timer+0x47/0x80
__hrtimer_run_queues+0x10a/0x280
hrtimer_interrupt+0x10b/0x240
__sysvec_apic_timer_interrupt+0x70/0x160
sysvec_apic_timer_interrupt+0x9a/0xd0
</IRQ>
<TASK>
asm_sysvec_apic_timer_interrupt+0x16/0x20

Steps to reproduce:
1. Enable CONFIG_SCHED_DEBUG and CONFIG_SCHED_CORE when compiling
   the kernel
2. echo 1 > /sys/kernel/debug/clear_warn_once
   echo "WARN_DOUBLE_CLOCK" > /sys/kernel/debug/sched/features
3. Run the linux/tools/testing/selftests/sched/cs_prctl_test test

Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
---
 kernel/sched/core.c       |  5 ++++-
 kernel/sched/core_sched.c |  4 +++-
 kernel/sched/sched.h      | 10 +++++++++-
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index daff72f00385..fcf5e4faec34 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5951,6 +5951,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	rq->core->core_cookie = 0UL;
 	if (rq->core->core_forceidle_count) {
 		if (!core_clock_updated) {
+			rq_clock_clear_update(rq->core);
 			update_rq_clock(rq->core);
 			core_clock_updated = true;
 		}
@@ -6007,8 +6008,10 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 		 * pick_next_task(). If the current cpu is not the core,
 		 * the core may also have been updated above.
 		 */
-		if (i != cpu && (rq_i != rq->core || !core_clock_updated))
+		if (i != cpu && (rq_i != rq->core || !core_clock_updated)) {
+			rq_clock_clear_update(rq_i);
 			update_rq_clock(rq_i);
+		}
 
 		p = rq_i->core_pick = pick_task(rq_i);
 		if (!max || prio_less(max, p, fi_before))
diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
index a57fd8f27498..70a6f36fd830 100644
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -291,8 +291,10 @@ void __sched_core_tick(struct rq *rq)
 	if (!rq->core->core_forceidle_count)
 		return;
 
-	if (rq != rq->core)
+	if (rq != rq->core) {
+		rq_clock_clear_update(rq->core);
 		update_rq_clock(rq->core);
+	}
 
 	__sched_core_account_forceidle(rq);
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a4a20046e586..1a2c40c413c2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2544,8 +2544,16 @@ static inline void double_rq_clock_clear_update(struct rq *rq1, struct rq *rq2)
 	rq2->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
 #endif
 }
-#else
+
+#ifdef CONFIG_SCHED_CORE
+static inline void rq_clock_clear_update(struct rq *rq)
+{
+	rq->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
+}
+#endif
+#else /* CONFIG_SCHED_DEBUG */
 static inline void double_rq_clock_clear_update(struct rq *rq1, struct rq *rq2) {}
+static inline void rq_clock_clear_update(struct rq *rq) {}
 #endif
 
 #ifdef CONFIG_SMP
-- 
2.37.0


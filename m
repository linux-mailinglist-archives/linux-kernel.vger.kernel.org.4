Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2052E65074B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 06:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbiLSFVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 00:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiLSFVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 00:21:37 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A78464FA;
        Sun, 18 Dec 2022 21:21:36 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so7813236pjm.2;
        Sun, 18 Dec 2022 21:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MfcIFH1EjeaqbztfzVmIUnFBfRPMwRKagqxEakbRJHA=;
        b=i3RJws78NlNdIrLRZNOXMPxzgPKPJG3Blo+YyTg92u/RJELU7YIo1ozuVUQRLygFgQ
         KBY2rfczVNrgoQv1kFCWF8APMqRU9U66eg1NzWg4c+IRi7mzqemeLC3qNEbkwESnlMBg
         cIuA7jvM/MUHpHzso0reW33SGjLuTk7PWW5ikyfCwfybZ1jv/S5klqLx5vqK+mH/8IYK
         JcK90FLB/GbGSOPmLlggwssktH/utPKE3uKq1JA51q2oGuOes4IRuQYYcx7ODlOEt6Ja
         gxuIIsgpMqIr6ZuaDM3xzMxyKkWFh5timza24Itwr+vg6eA80+uV5aXRIYKC0t4lPLxU
         QYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MfcIFH1EjeaqbztfzVmIUnFBfRPMwRKagqxEakbRJHA=;
        b=HTkXmCukFErStrIe3GBlpSbLSbrytv/p1bzR/dH576oso0fppE4mIjlH+LimaRKMg8
         dr/BDGWAvz9oVflfBuT27t4XhluUxwUGtmhmtAgiLIDmxMEWHh1+wBp0qtqcp2bhIeg5
         eW8pl7419VewCUKO+DDLV+kcBOBGYa/75TMBZmqzheCV1PDA9K2yNZREkafbKCS1A4OS
         sjEe7Am0Mq8Zk1kpk/XSMS2BW5MN0wMvrDNZ2mn6cMZ790eHhjTnUf88TYGOI3t7MKYq
         MkEsA1rKm/s170gl+FiIkbqCCdK5OCPi4ynSE6FeN89HaQQoSTdu1hFOM5EfryLiuBDn
         Ph4A==
X-Gm-Message-State: AFqh2kr1TnYxl2IjOyrcoPaH8TZK12HIX+vjzbwj7E1yZGcSunuMiQSi
        ok8E/RWUxCprT2zB0B/WweI=
X-Google-Smtp-Source: AMrXdXsrJavRXBeUTn4Bj0zEFw/GiE5d2ss9AUzvoSx2aV4+011W7W0I8E+prOBF5yXlyDJU3TJVcg==
X-Received: by 2002:a17:902:f78d:b0:191:1f16:efa3 with SMTP id q13-20020a170902f78d00b001911f16efa3mr3067458pln.65.1671427296013;
        Sun, 18 Dec 2022 21:21:36 -0800 (PST)
Received: from localhost.localdomain ([114.254.2.194])
        by smtp.gmail.com with ESMTPSA id b13-20020a170902d50d00b00174f61a7d09sm5951447plg.247.2022.12.18.21.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 21:21:35 -0800 (PST)
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
To:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        paulmck@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH linux-next] mark access to tick_do_timer_cpu with READ_ONCE/WRITE_ONCE
Date:   Mon, 19 Dec 2022 13:21:28 +0800
Message-Id: <20221219052128.18190-1-zhouzhouyi@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mark access to tick_do_timer_cpu with READ_ONCE/WRITE_ONCE to fix concurrency bug
reported by KCSAN.

Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
---
During the rcutorture test on linux-next,
./tools/testing/selftests/rcutorture/bin/torture.sh --do-kcsan  --kcsan-kmake-arg "CC=clang-12"
following KCSAN BUG is reported:
[   35.397089] BUG: KCSAN: data-race in tick_nohz_idle_stop_tick / tick_nohz_next_event^M
[   35.400593] ^M
[   35.401377] write to 0xffffffffb64b1270 of 4 bytes by task 0 on cpu 3:^M
[   35.405325]  tick_nohz_idle_stop_tick+0x14c/0x3e0^M
[   35.407162]  do_idle+0xf3/0x2a0^M
[   35.408016]  cpu_startup_entry+0x15/0x20^M
[   35.409084]  start_secondary+0x8f/0x90^M
[   35.410207]  secondary_startup_64_no_verify+0xe1/0xeb^M
[   35.411607] ^M
[   35.412042] no locks held by swapper/3/0.^M
[   35.413172] irq event stamp: 53048^M
[   35.414175] hardirqs last  enabled at (53047): [<ffffffffb41f8404>] tick_nohz_idle_enter+0x104/0x140^M
[   35.416681] hardirqs last disabled at (53048): [<ffffffffb41229f1>] do_idle+0x91/0x2a0^M
[   35.418988] softirqs last  enabled at (53038): [<ffffffffb40bf21e>] __irq_exit_rcu+0x6e/0xc0^M
[   35.421347] softirqs last disabled at (53029): [<ffffffffb40bf21e>] __irq_exit_rcu+0x6e/0xc0^M
[   35.423685] ^M
[   35.424119] read to 0xffffffffb64b1270 of 4 bytes by task 0 on cpu 0:^M
[   35.425870]  tick_nohz_next_event+0x233/0x2b0^M
[   35.427119]  tick_nohz_idle_stop_tick+0x8f/0x3e0^M
[   35.428386]  do_idle+0xf3/0x2a0^M
[   35.429265]  cpu_startup_entry+0x15/0x20^M
[   35.430429]  rest_init+0x20c/0x210^M
[   35.431382]  arch_call_rest_init+0xe/0x10^M
[   35.432508]  start_kernel+0x544/0x600^M
[   35.433519]  secondary_startup_64_no_verify+0xe1/0xeb^M

fix above bug by marking access to tick_do_timer_cpu with READ_ONCE/WRITE_ONCE

Thanks
Zhouyi
--
 kernel/time/tick-common.c | 16 ++++++++--------
 kernel/time/tick-sched.c  | 28 +++++++++++++++-------------
 2 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 46789356f856..a7753465a0be 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -84,7 +84,7 @@ int tick_is_oneshot_available(void)
  */
 static void tick_periodic(int cpu)
 {
-	if (tick_do_timer_cpu == cpu) {
+	if (READ_ONCE(tick_do_timer_cpu) == cpu) {
 		raw_spin_lock(&jiffies_lock);
 		write_seqcount_begin(&jiffies_seq);
 
@@ -184,9 +184,9 @@ static void giveup_do_timer(void *info)
 {
 	int cpu = *(unsigned int *)info;
 
-	WARN_ON(tick_do_timer_cpu != smp_processor_id());
+	WARN_ON(READ_ONCE(tick_do_timer_cpu) != smp_processor_id());
 
-	tick_do_timer_cpu = cpu;
+	WRITE_ONCE(tick_do_timer_cpu, cpu);
 }
 
 static void tick_take_do_timer_from_boot(void)
@@ -217,8 +217,8 @@ static void tick_setup_device(struct tick_device *td,
 		 * If no cpu took the do_timer update, assign it to
 		 * this cpu:
 		 */
-		if (tick_do_timer_cpu == TICK_DO_TIMER_BOOT) {
-			tick_do_timer_cpu = cpu;
+		if (READ_ONCE(tick_do_timer_cpu) == TICK_DO_TIMER_BOOT) {
+			WRITE_ONCE(tick_do_timer_cpu, cpu);
 
 			tick_next_period = ktime_get();
 #ifdef CONFIG_NO_HZ_FULL
@@ -235,7 +235,7 @@ static void tick_setup_device(struct tick_device *td,
 						!tick_nohz_full_cpu(cpu)) {
 			tick_take_do_timer_from_boot();
 			tick_do_timer_boot_cpu = -1;
-			WARN_ON(tick_do_timer_cpu != cpu);
+			WARN_ON(READ_ONCE(tick_do_timer_cpu) != cpu);
 #endif
 		}
 
@@ -407,8 +407,8 @@ EXPORT_SYMBOL_GPL(tick_broadcast_oneshot_control);
  */
 void tick_handover_do_timer(void)
 {
-	if (tick_do_timer_cpu == smp_processor_id())
-		tick_do_timer_cpu = cpumask_first(cpu_online_mask);
+	if (READ_ONCE(tick_do_timer_cpu) == smp_processor_id())
+		WRITE_ONCE(tick_do_timer_cpu, cpumask_first(cpu_online_mask));
 }
 
 /*
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index b0e3c9205946..2dac94b3187f 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -186,16 +186,16 @@ static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
 	 * If nohz_full is enabled, this should not happen because the
 	 * tick_do_timer_cpu never relinquishes.
 	 */
-	if (unlikely(tick_do_timer_cpu == TICK_DO_TIMER_NONE)) {
+	if (unlikely(READ_ONCE(tick_do_timer_cpu) == TICK_DO_TIMER_NONE)) {
 #ifdef CONFIG_NO_HZ_FULL
 		WARN_ON_ONCE(tick_nohz_full_running);
 #endif
-		tick_do_timer_cpu = cpu;
+		WRITE_ONCE(tick_do_timer_cpu, cpu);
 	}
 #endif
 
 	/* Check, if the jiffies need an update */
-	if (tick_do_timer_cpu == cpu)
+	if (READ_ONCE(tick_do_timer_cpu) == cpu)
 		tick_do_update_jiffies64(now);
 
 	/*
@@ -534,7 +534,7 @@ static int tick_nohz_cpu_down(unsigned int cpu)
 	 * timers, workqueues, timekeeping, ...) on behalf of full dynticks
 	 * CPUs. It must remain online when nohz full is enabled.
 	 */
-	if (tick_nohz_full_running && tick_do_timer_cpu == cpu)
+	if (tick_nohz_full_running && READ_ONCE(tick_do_timer_cpu) == cpu)
 		return -EBUSY;
 	return 0;
 }
@@ -849,8 +849,9 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
 	 * Otherwise we can sleep as long as we want.
 	 */
 	delta = timekeeping_max_deferment();
-	if (cpu != tick_do_timer_cpu &&
-	    (tick_do_timer_cpu != TICK_DO_TIMER_NONE || !ts->do_timer_last))
+	if (cpu != READ_ONCE(tick_do_timer_cpu) &&
+	    (READ_ONCE(tick_do_timer_cpu) != TICK_DO_TIMER_NONE
+	     || !ts->do_timer_last))
 		delta = KTIME_MAX;
 
 	/* Calculate the next expiry time */
@@ -883,10 +884,10 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 	 * do_timer() never invoked. Keep track of the fact that it
 	 * was the one which had the do_timer() duty last.
 	 */
-	if (cpu == tick_do_timer_cpu) {
-		tick_do_timer_cpu = TICK_DO_TIMER_NONE;
+	if (cpu == READ_ONCE(tick_do_timer_cpu)) {
+		WRITE_ONCE(tick_do_timer_cpu, TICK_DO_TIMER_NONE);
 		ts->do_timer_last = 1;
-	} else if (tick_do_timer_cpu != TICK_DO_TIMER_NONE) {
+	} else if (READ_ONCE(tick_do_timer_cpu) != TICK_DO_TIMER_NONE) {
 		ts->do_timer_last = 0;
 	}
 
@@ -1049,8 +1050,8 @@ static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
 	 * invoked.
 	 */
 	if (unlikely(!cpu_online(cpu))) {
-		if (cpu == tick_do_timer_cpu)
-			tick_do_timer_cpu = TICK_DO_TIMER_NONE;
+		if (cpu == READ_ONCE(tick_do_timer_cpu))
+			WRITE_ONCE(tick_do_timer_cpu, TICK_DO_TIMER_NONE);
 		/*
 		 * Make sure the CPU doesn't get fooled by obsolete tick
 		 * deadline if it comes back online later.
@@ -1073,11 +1074,12 @@ static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
 		 * Keep the tick alive to guarantee timekeeping progression
 		 * if there are full dynticks CPUs around
 		 */
-		if (tick_do_timer_cpu == cpu)
+		if (READ_ONCE(tick_do_timer_cpu) == cpu)
 			return false;
 
 		/* Should not happen for nohz-full */
-		if (WARN_ON_ONCE(tick_do_timer_cpu == TICK_DO_TIMER_NONE))
+		if (WARN_ON_ONCE(READ_ONCE(tick_do_timer_cpu)
+				 == TICK_DO_TIMER_NONE))
 			return false;
 	}
 
-- 
2.34.1


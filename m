Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287A969CB33
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 13:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbjBTMln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 07:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjBTMlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 07:41:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A75A1BAF2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 04:41:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB729B80D1C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 12:41:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 376E7C4339B;
        Mon, 20 Feb 2023 12:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676896897;
        bh=Wb9KGoUJrtYdsW1KimAYFV3mTn319Lm7pLZhdSM/tgo=;
        h=From:To:Cc:Subject:Date:From;
        b=hrTt/1t4sMwQI+hYc45JtZ7AWOsbW8/BuhiM42YYdiwgt+vf76AiLzkjdlrxbGjyD
         ZvvP/eDR4tJepTLJOGHPjUHxgubfkEFyMPO6/OuVVkWied9YZTb6a2sI18IcSKrMv4
         R/EOMQ+r6CgpLlvNnJmYFzqkzlsivhQoXByDWp/HP93g+sUOSsVYH8uPBY7mrN/Q+e
         fV0G3GccDp3AKROf7ctNhG4K5tnpGLZE8lZKI+PGBYghPWsmtyJR06BbcvAPfVTUvj
         K4R/tG93LdBex+ZXdV4uu/7/K1uETWFDZvlDI0AydWarKPO70ZLHbdJ8oXORdeqx1b
         VX2aY1KdwwpXA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Wei Li <liwei391@huawei.com>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Yu Liao <liaoyu15@huawei.com>, Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 0/7] timers/nohz: Fixes and cleanups v2
Date:   Mon, 20 Feb 2023 13:41:22 +0100
Message-Id: <20230220124129.519477-1-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Try to (partially) fix the issue reported in https://lore.kernel.org/lkml/20230128020051.2328465-1-liaoyu15@huawei.com/

Changes since v1:

* Fix compute_delta left unused (thanks Hillf)
* Pass directly struct tick_sched to get_cpu_sleep_time_us()
* Add Peterz ack
* Remove selftests with wrong assertions

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	timers/core

HEAD: 0b86fc6ed10742ec8e54cd4d495c1ce9d4c1b4e0

Thanks,
	Frederic
---

Frederic Weisbecker (7):
      timers/nohz: Restructure and reshuffle struct tick_sched
      timers/nohz: Only ever update sleeptime from idle exit
      timers/nohz: Protect idle/iowait sleep time under seqcount
      timers/nohz: Add a comment about broken iowait counter update race
      timers/nohz: Remove middle-function __tick_nohz_idle_stop_tick()
      MAINTAINERS: Remove stale email address
      selftests/proc: Remove idle time monotonicity assertions


 MAINTAINERS                                    |   2 +-
 kernel/time/tick-sched.c                       | 135 ++++++++++++-------------
 kernel/time/tick-sched.h                       |  67 +++++++-----
 tools/testing/selftests/proc/.gitignore        |   2 -
 tools/testing/selftests/proc/Makefile          |   2 -
 tools/testing/selftests/proc/proc-uptime-001.c |  45 ---------
 tools/testing/selftests/proc/proc-uptime-002.c |  79 ---------------
 tools/testing/selftests/proc/proc-uptime.h     |  60 -----------
 8 files changed, 106 insertions(+), 286 deletions(-)
 ---
 git range-diff since v1
 
 1:  899f01a80e5b ! 1:  0e7aede86812 timers/nohz: Restructure and reshuffle struct tick_sched
    @@ Commit message
         @last_jiffies and @idle_expires.
     
         Reported-by: Thomas Gleixner <tglx@linutronix.de>
    +    Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
         Cc: Hillf Danton <hdanton@sina.com>
         Cc: Yu Liao <liaoyu15@huawei.com>
         Cc: Ingo Molnar <mingo@kernel.org>
         Cc: Wei Li <liwei391@huawei.com>
         Cc: Alexey Dobriyan <adobriyan@gmail.com>
         Cc: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
    -    Cc: Peter Zijlstra <peterz@infradead.org>
         Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
     
      ## kernel/time/tick-sched.h ##
2:  4ea8a8e98eb0 ! 2:  8e8a18cee3d5 timers/nohz: Only ever update sleeptime from idle exit
    @@ Commit message
         reader VS writer races to handle. A subsequent patch will fix one.
     
         Reported-by: Yu Liao <liaoyu15@huawei.com>
    +    Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
         Cc: Hillf Danton <hdanton@sina.com>
         Cc: Yu Liao <liaoyu15@huawei.com>
         Cc: Ingo Molnar <mingo@kernel.org>
    @@ Commit message
         Cc: Wei Li <liwei391@huawei.com>
         Cc: Alexey Dobriyan <adobriyan@gmail.com>
         Cc: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
    -    Cc: Peter Zijlstra <peterz@infradead.org>
         Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
     
      ## kernel/time/tick-sched.c ##
    @@ kernel/time/tick-sched.c: static void tick_nohz_start_idle(struct tick_sched *ts
      	sched_clock_idle_sleep_event();
      }
      
    -+static u64 get_cpu_sleep_time_us(int cpu, ktime_t *sleeptime,
    ++static u64 get_cpu_sleep_time_us(struct tick_sched *ts, ktime_t *sleeptime,
     +				 bool compute_delta, u64 *last_update_time)
     +{
    -+	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
     +	ktime_t now, idle;
     +
     +	if (!tick_nohz_active)
    @@ kernel/time/tick-sched.c: static void tick_nohz_start_idle(struct tick_sched *ts
     +	if (last_update_time)
     +		*last_update_time = ktime_to_us(now);
     +
    -+	if (ts->idle_active && !nr_iowait_cpu(cpu)) {
    ++	if (ts->idle_active && compute_delta) {
     +		ktime_t delta = ktime_sub(now, ts->idle_entrytime);
     +
     +		idle = ktime_add(*sleeptime, delta);
    @@ kernel/time/tick-sched.c: static void tick_nohz_start_idle(struct tick_sched *ts
     -
     -	return ktime_to_us(idle);
      
    -+	return get_cpu_sleep_time_us(cpu, &ts->idle_sleeptime,
    ++	return get_cpu_sleep_time_us(ts, &ts->idle_sleeptime,
     +				     !nr_iowait_cpu(cpu), last_update_time);
      }
      EXPORT_SYMBOL_GPL(get_cpu_idle_time_us);
    @@ kernel/time/tick-sched.c: EXPORT_SYMBOL_GPL(get_cpu_idle_time_us);
     -	}
      
     -	return ktime_to_us(iowait);
    -+	return get_cpu_sleep_time_us(cpu, &ts->iowait_sleeptime,
    ++	return get_cpu_sleep_time_us(ts, &ts->iowait_sleeptime,
     +				     nr_iowait_cpu(cpu), last_update_time);
      }
      EXPORT_SYMBOL_GPL(get_cpu_iowait_time_us);
3:  131b09a345c6 ! 3:  61b56e1d6c33 timers/nohz: Protect idle/iowait sleep time under seqcount
    @@ Commit message
         can hardly be fixed.
     
         Reported-by: Yu Liao <liaoyu15@huawei.com>
    +    Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
         Cc: Hillf Danton <hdanton@sina.com>
         Cc: Yu Liao <liaoyu15@huawei.com>
         Cc: Ingo Molnar <mingo@kernel.org>
    @@ Commit message
         Cc: Wei Li <liwei391@huawei.com>
         Cc: Alexey Dobriyan <adobriyan@gmail.com>
         Cc: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
    -    Cc: Peter Zijlstra <peterz@infradead.org>
         Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
     
      ## kernel/time/tick-sched.c ##
    @@ kernel/time/tick-sched.c: static void tick_nohz_stop_idle(struct tick_sched *ts,
      	sched_clock_idle_sleep_event();
      }
      
    -@@ kernel/time/tick-sched.c: static u64 get_cpu_sleep_time_us(int cpu, ktime_t *sleeptime,
    +@@ kernel/time/tick-sched.c: static u64 get_cpu_sleep_time_us(struct tick_sched *ts, ktime_t *sleeptime,
    + 				 bool compute_delta, u64 *last_update_time)
      {
    - 	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
      	ktime_t now, idle;
     +	unsigned int seq;
      
      	if (!tick_nohz_active)
      		return -1;
    -@@ kernel/time/tick-sched.c: static u64 get_cpu_sleep_time_us(int cpu, ktime_t *sleeptime,
    +@@ kernel/time/tick-sched.c: static u64 get_cpu_sleep_time_us(struct tick_sched *ts, ktime_t *sleeptime,
      	if (last_update_time)
      		*last_update_time = ktime_to_us(now);
      
    --	if (ts->idle_active && !nr_iowait_cpu(cpu)) {
    +-	if (ts->idle_active && compute_delta) {
     -		ktime_t delta = ktime_sub(now, ts->idle_entrytime);
     +	do {
     +		seq = read_seqcount_begin(&ts->idle_sleeptime_seq);
    @@ kernel/time/tick-sched.c: static u64 get_cpu_sleep_time_us(int cpu, ktime_t *sle
     -	} else {
     -		idle = *sleeptime;
     -	}
    -+		if (ts->idle_active && !nr_iowait_cpu(cpu)) {
    ++		if (ts->idle_active && compute_delta) {
     +			ktime_t delta = ktime_sub(now, ts->idle_entrytime);
     +
     +			idle = ktime_add(*sleeptime, delta);
4:  4ff478886c2c ! 4:  9147cd64f3ba timers/nohz: Add a comment about broken iowait counter update race
    @@ Commit message
         This is unfortunately hardly fixable. Just add a comment about that
         condition.
     
    +    Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
         Cc: Hillf Danton <hdanton@sina.com>
         Cc: Yu Liao <liaoyu15@huawei.com>
         Cc: Ingo Molnar <mingo@kernel.org>
    @@ Commit message
         Cc: Wei Li <liwei391@huawei.com>
         Cc: Alexey Dobriyan <adobriyan@gmail.com>
         Cc: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
    -    Cc: Peter Zijlstra <peterz@infradead.org>
         Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
     
      ## kernel/time/tick-sched.c ##
    -@@ kernel/time/tick-sched.c: static u64 get_cpu_sleep_time_us(int cpu, ktime_t *sleeptime,
    +@@ kernel/time/tick-sched.c: static u64 get_cpu_sleep_time_us(struct tick_sched *ts, ktime_t *sleeptime,
       * counters if NULL.
       *
       * Return the cumulative idle time (since boot) for a given
5:  6eb31238e057 ! 5:  4863214a905f timers/nohz: Remove middle-function __tick_nohz_idle_stop_tick()
    @@ Commit message
         tick_nohz_idle_stop_tick() and its implementation. Remove that
         unnecessary step.
     
    +    Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
         Cc: Hillf Danton <hdanton@sina.com>
         Cc: Yu Liao <liaoyu15@huawei.com>
         Cc: Ingo Molnar <mingo@kernel.org>
    @@ Commit message
         Cc: Wei Li <liwei391@huawei.com>
         Cc: Alexey Dobriyan <adobriyan@gmail.com>
         Cc: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
    -    Cc: Peter Zijlstra <peterz@infradead.org>
         Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
     
      ## kernel/time/tick-sched.c ##
6:  d1dc3edc39a7 ! 6:  170828be3e96 MAINTAINERS: Remove stale email address
    @@ Metadata
      ## Commit message ##
         MAINTAINERS: Remove stale email address
     
    +    Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
         Cc: Hillf Danton <hdanton@sina.com>
         Cc: Yu Liao <liaoyu15@huawei.com>
         Cc: Ingo Molnar <mingo@kernel.org>
    @@ Commit message
         Cc: Wei Li <liwei391@huawei.com>
         Cc: Alexey Dobriyan <adobriyan@gmail.com>
         Cc: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
    -    Cc: Peter Zijlstra <peterz@infradead.org>
         Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
     
      ## MAINTAINERS ##
-:  ------------ > 7:  0b86fc6ed107 selftests/proc: Remove idle time monotonicity assertions

 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F3C5EC207
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 14:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbiI0MD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 08:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiI0MDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 08:03:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409BF1591F7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 05:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664280231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tnmnMKPLJ9M7ArK6N7TZfsCFYTNBhcqgG2VAVnAgyTU=;
        b=RA3Lz2yQSqwgF+FAr5WrlbdpiMReJX5oihTB5ovPb5Ap7g5NIX7xwqQ0dwlP6cBVjsojzx
        UgNSAadVHMndNU+A7x8SFuktVrRtlMOsQGmvbSRWAeA9xgTwDNjr/OIXwUc0imyIrTyFuC
        CleEdfucSyiGVf2C3m+Z3hI5D2LVvMA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-622-1dxgAYS7PoyYPeJMGKXWeQ-1; Tue, 27 Sep 2022 08:03:50 -0400
X-MC-Unique: 1dxgAYS7PoyYPeJMGKXWeQ-1
Received: by mail-wm1-f70.google.com with SMTP id f25-20020a7bc8d9000000b003b4768dcd9cso2661731wml.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 05:03:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=tnmnMKPLJ9M7ArK6N7TZfsCFYTNBhcqgG2VAVnAgyTU=;
        b=x/MrpS2vPci6EEFKr0om4K9SYP8YzDpt+kVa3QXy4glIQGKIPM5sIXJyQxT1X4408i
         5Qd+0l/B4QPkWNEUybr6zZHk7dc7uD9xO0a8WryYY6UwIZVyQVpla9axs2UBMLEFVOp5
         t0cwltz7+ayEEwUkGwps0D+ddQ4COB72Xa2eo72yqFbOU//+botiv0RvYDuhcHMlJrr+
         fm5KuT0YlbkXntN6slWgB1iymt5OXT1Jv3noUpnlHObYtzrXysxuFCTML1EMUvolY7q+
         oys6ZK20ER7C4tbj5XVzTGIiX3iqVNRjR+IjcIQv2YcZc3waScFRV7TqdhG0nFlnbGvh
         NNDg==
X-Gm-Message-State: ACrzQf3DB/4YmD3m7Dy+LP6bV5Zz2qvwcijDyvmop1/2HiQAHxyaXhH4
        AocvYtAa3TlbVuzlCJnSidb2mtWrCLc2SU/42Y4Hdol1BicQ9ttA7ddY5sR3iYoIIicNB5oG0sH
        +GyLMyA6vhmdb2dF+XIaQBd76tjPNj5iXy/WGWgvj600lOdmIV/l+a4taTUPDuU+PGS6Dp9nYsc
        IB
X-Received: by 2002:a5d:47aa:0:b0:226:dbf6:680c with SMTP id 10-20020a5d47aa000000b00226dbf6680cmr16813100wrb.581.1664280228644;
        Tue, 27 Sep 2022 05:03:48 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5FPnDvaQBFbXSSTEPY0PCH0xFt/Lc5I741kex7+xENFNyNdYER5Dead5mgWAkeYwmfu2+CWw==
X-Received: by 2002:a5d:47aa:0:b0:226:dbf6:680c with SMTP id 10-20020a5d47aa000000b00226dbf6680cmr16813051wrb.581.1664280228209;
        Tue, 27 Sep 2022 05:03:48 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id o24-20020a05600c379800b003b483000583sm1457186wmr.48.2022.09.27.05.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 05:03:47 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH] nohz_full: Fix TICK_DO_TIMER_NONE vs nohz_full warning
Date:   Tue, 27 Sep 2022 13:03:22 +0100
Message-Id: <20220927120322.1912245-1-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Booting a system with an invalid nohz_full cmdline mask (in my case
nr_cpus=X on the cmdline makes the nohz_full CPUs out of range) triggers:

[    1.209455] WARNING: CPU: 1 PID: 1 at kernel/time/tick-sched.c:191 tick_sched_do_timer+0x90/0xa0
[    1.209455] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.19.0-00675-g7e9518baed4c #39
[    1.209455] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[    1.209455] RIP: 0010:tick_sched_do_timer+0x90/0xa0
[    1.209455] Call Trace:
[    1.209455]  <IRQ>
[    1.209455]  tick_sched_timer+0x2e/0x80
[    1.209455]  __hrtimer_run_queues+0xfc/0x2a0
[    1.209455]  hrtimer_interrupt+0x105/0x240
[    1.209455]  __sysvec_apic_timer_interrupt+0x7a/0x160
[    1.209455]  sysvec_apic_timer_interrupt+0x85/0xb0
[    1.209455]  </IRQ>

This is because nothing checks the actual contents of the mask in
housekeeping_setup(), so in those scenarios we do end up invoking
tick_nohz_full_setup() and thus setting tick_nohz_full_running to true.

However, later on in tick_nohz_init(), this ends up being a no-op:

  for_each_cpu(cpu, tick_nohz_full_mask)
	  ct_cpu_track_user(cpu);

This in turn means we end up with
  tick_nohz_full_running == true
  context_tracking_enabled() == false
IOW
  tick_nohz_full_enabled() == false

Thus, __tick_nohz_idle_stop_tick() can legitimately stop the tick during
idle for the tick_do_timer_cpu, and sets tick_do_timer_cpu to
TICK_DO_TIMER_NONE. This triggers the warning when later on the tick fires
and tick_sched_do_timer() detects the tick_do_timer_cpu was relinquished.

Check the contents of the non_housekeeping_mask after it is
parsed (rcu_init_nohz() does a similar check). For good measure, also
update the check in tick_sched_do_timer() to use tick_nohz_full_enabled().

Fixes: 08ae95f4fd3b ("nohz_full: Allow the boot CPU to be nohz_full")
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/sched/isolation.c | 3 ++-
 kernel/time/tick-sched.c | 4 +---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 373d42c707bc..774cd187a1f7 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -120,7 +120,8 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
 	}
 
 	alloc_bootmem_cpumask_var(&non_housekeeping_mask);
-	if (cpulist_parse(str, non_housekeeping_mask) < 0) {
+	if (cpulist_parse(str, non_housekeeping_mask) < 0 ||
+	    !cpumask_subset(non_housekeeping_mask, cpu_possible_mask)) {
 		pr_warn("Housekeeping: nohz_full= or isolcpus= incorrect CPU range\n");
 		goto free_non_housekeeping_mask;
 	}
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index b0e3c9205946..dae01a6577ab 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -187,9 +187,7 @@ static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
 	 * tick_do_timer_cpu never relinquishes.
 	 */
 	if (unlikely(tick_do_timer_cpu == TICK_DO_TIMER_NONE)) {
-#ifdef CONFIG_NO_HZ_FULL
-		WARN_ON_ONCE(tick_nohz_full_running);
-#endif
+		WARN_ON_ONCE(tick_nohz_full_enabled());
 		tick_do_timer_cpu = cpu;
 	}
 #endif
-- 
2.31.1


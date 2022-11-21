Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0038C63190D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 04:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiKUDvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 22:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiKUDvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 22:51:50 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57521EEF0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 19:51:49 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id 130so10190317pfu.8
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 19:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GxntLd/ct95PDR+cb+voA3PVWvgQd225Bxlaz4kUMug=;
        b=G3+BJ6h3S2AwsBJvMKzpLcRAMmfnvNbqghjwS3l9dKG7H2nqHRd+WuWvUxxO4V9t7o
         pSkW2ykPq5piIQ6mXp6Jk628w6L1iflshHCNR7Rk9ja3KpcvZVkXod+WBOpoTGddqns4
         aYz9RO+oEVhTlg7TbVQ8KS/5s4DKt7L+GUMxrPRsn1rvd97A1Ir+OszygWwOKvVmmvOZ
         7jSHc4PX2jnGsX6hOL9G/KVsr7G28ajHEBhISEL00cgRSDqdHgSBEAtjOsK4TanESi0F
         +W65wypspVWFZHnYM5w2Scbxv2l99dKfkH7N6xwNvQeI6JXAOlKDnMaR3tDTRQ6UiFlD
         qBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GxntLd/ct95PDR+cb+voA3PVWvgQd225Bxlaz4kUMug=;
        b=RcabOpsUUrQQH9VqXRUeOy0/e9OEnlHTl9uB05izlRu4H1DIijpgUdTsBbPKIANMub
         NiluQT6NHejmWkYQNxgvrvEY4zZ73gPOOeuTizeqiyM4qxdn9fA3hAq68s51gR6ITS1S
         p9BJAGi+M44qVChJDG1RWCQnhnu22dsLB5xDXcwggOgIFGKO7eTyEJJMWpbOaMQ+QZI7
         xQCvb5tTa04SnQcZbfmsNJhyWu7C6vt5tKZqcRMmATriIPTeQlzTZ3vIUM84zdn47pGv
         z75m1BWkyG5EjDM2IzEKeQE3RkNf/T1mdj4/Ui6P8XwvCBD/jjpgT7wl2Rng8Czhl4Y9
         NadA==
X-Gm-Message-State: ANoB5pkxKu3wKt51CKHhc/6TtTf91L15b99Amx+qT6HkTDuEdPwdDuAb
        PPF6+5Xs4nVU9unuguTGJmoFGUI1v3LOjA==
X-Google-Smtp-Source: AA0mqf6GmmnIaAXxRDWdzo2mwsMABgOBqxpoLd1EYj+5NiHrODlNUWz1ysL61n9/fPCAgD3u6ATjwg==
X-Received: by 2002:a63:d241:0:b0:439:8688:a98d with SMTP id t1-20020a63d241000000b004398688a98dmr5641021pgi.424.1669002709390;
        Sun, 20 Nov 2022 19:51:49 -0800 (PST)
Received: from localhost.localdomain ([194.5.48.82])
        by smtp.gmail.com with ESMTPSA id o14-20020a170902d4ce00b00186acb14c4asm8476124plg.67.2022.11.20.19.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 19:51:49 -0800 (PST)
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
To:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        dave@stgolabs.net, paulmck@kernel.org, josh@joshtriplett.org,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH linux-next][RFC]torture: avoid offline tick_do_timer_cpu
Date:   Mon, 21 Nov 2022 11:51:40 +0800
Message-Id: <20221121035140.118651-1-zhouzhouyi@gmail.com>
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

During CPU-hotplug torture (CONFIG_NO_HZ_FULL=y), if we try to
offline tick_do_timer_cpu, the operation will fail because in
function tick_nohz_cpu_down:
```
if (tick_nohz_full_running && tick_do_timer_cpu == cpu)
      return -EBUSY;
```
Above bug was first discovered in torture tests performed in PPC VM
of Open Source Lab of Oregon State University, and reproducable in RISC-V
and X86-64 (with additional kernel commandline cpu0_hotplug).

In this patch, we avoid offline tick_do_timer_cpu by distribute
the offlining cpu among remaining cpus.

Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
---
 include/linux/tick.h        |  1 +
 kernel/time/tick-common.c   |  1 +
 kernel/time/tick-internal.h |  1 -
 kernel/torture.c            | 10 ++++++++++
 4 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index bfd571f18cfd..23cc0b205853 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -14,6 +14,7 @@
 #include <linux/rcupdate.h>
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
+extern int tick_do_timer_cpu __read_mostly;
 extern void __init tick_init(void);
 /* Should be core only, but ARM BL switcher requires it */
 extern void tick_suspend_local(void);
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 46789356f856..87b9b9afa320 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -48,6 +48,7 @@ ktime_t tick_next_period;
  *    procedure also covers cpu hotplug.
  */
 int tick_do_timer_cpu __read_mostly = TICK_DO_TIMER_BOOT;
+EXPORT_SYMBOL_GPL(tick_do_timer_cpu);
 #ifdef CONFIG_NO_HZ_FULL
 /*
  * tick_do_timer_boot_cpu indicates the boot CPU temporarily owns
diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 649f2b48e8f0..8953dca10fdd 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -15,7 +15,6 @@
 
 DECLARE_PER_CPU(struct tick_device, tick_cpu_device);
 extern ktime_t tick_next_period;
-extern int tick_do_timer_cpu __read_mostly;
 
 extern void tick_setup_periodic(struct clock_event_device *dev, int broadcast);
 extern void tick_handle_periodic(struct clock_event_device *dev);
diff --git a/kernel/torture.c b/kernel/torture.c
index 789aeb0e1159..bccbdd33dda2 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -33,6 +33,7 @@
 #include <linux/delay.h>
 #include <linux/stat.h>
 #include <linux/slab.h>
+#include <linux/tick.h>
 #include <linux/trace_clock.h>
 #include <linux/ktime.h>
 #include <asm/byteorder.h>
@@ -358,7 +359,16 @@ torture_onoff(void *arg)
 			schedule_timeout_interruptible(HZ / 10);
 			continue;
 		}
+#ifdef CONFIG_NO_HZ_FULL
+		/* do not offline tick do timer cpu */
+		if (tick_nohz_full_running) {
+			cpu = (torture_random(&rand) >> 4) % maxcpu;
+			if (cpu >= tick_do_timer_cpu)
+				cpu = (cpu + 1) % (maxcpu + 1);
+		} else
+#else
 		cpu = (torture_random(&rand) >> 4) % (maxcpu + 1);
+#endif
 		if (!torture_offline(cpu,
 				     &n_offline_attempts, &n_offline_successes,
 				     &sum_offline, &min_offline, &max_offline))
-- 
2.34.1


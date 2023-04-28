Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4031B6F213A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 01:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347020AbjD1Xlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 19:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjD1Xlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 19:41:35 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CF42117
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 16:41:33 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-51f597c975fso354604a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 16:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682725293; x=1685317293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F4IaEZAn0erKlCoc/+m0804h5LEf1atEabZRRmBATW8=;
        b=GFIechCWG62dEHL1MDlZ/dNAt3MXU08YNMd+Y+Go9TY+HNr+oQi8bJcipDv+10Cr+4
         LNWrMHasifR8YJDttO9dk6vfJgEK5aLBbwBILeZ1Cbjfg07kDx//m6cATF92QZe/voad
         gX+4H/ftrDsgSd3y8FbYQYFYmKiOmJ7tR08hY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682725293; x=1685317293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F4IaEZAn0erKlCoc/+m0804h5LEf1atEabZRRmBATW8=;
        b=mEjy3p0C6U23LtpwFDsqwBoqGxNjpDgL35QYvQaRO3vPKWytlCtqC0OPWV82WeMoJ7
         qNYFyGAt4VfcqRz57i6ytqjimc/HNqK8r95F4Ct39Pm3ozpRG7imhVhwPAzPjT35mrDx
         MqG0ujzkGr8MufJm7T8Zr8b3Fjo57M+Zq5lK8xlFQfxGqL8padErrdjoVa7g+wjHb8Ds
         e3tr9hyp3mRyHQwtOjWxWA7uyu5XKQ+kl8xdgnZCyRtheyirhuuqw1hLA2XyDx5DNGr+
         rgDdJpXvyR3BI2iTSXot2X7pCTN4riPpuPM/x5REjLcIDEdArcKgY6Hmfeom9ZlEOr62
         2t7Q==
X-Gm-Message-State: AC+VfDzAO4mv0rnOuCRZ8giOyFpVEWwni/Db3Ph4zKVZRZnDuJK8NgwR
        BZmYOdy5Wk2dY/wkiI+Fwc+LGQ==
X-Google-Smtp-Source: ACHHUZ4XaDATDBbc72CbeURC/bS7OZ7bIqOJEO/Xzjd9QvrVifMUd1+yi66Fk+zihbbenWXpjlaK9Q==
X-Received: by 2002:a17:902:ec83:b0:1a6:9f9b:1327 with SMTP id x3-20020a170902ec8300b001a69f9b1327mr8415733plg.45.1682725293084;
        Fri, 28 Apr 2023 16:41:33 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:64:29eb:3b29:6ff1])
        by smtp.gmail.com with ESMTPSA id jl16-20020a170903135000b001a216d44440sm13739145plb.200.2023.04.28.16.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 16:41:32 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Stephane Eranian <eranian@google.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-perf-users@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net, ito-yuichi@fujitsu.com,
        ravi.v.shankar@intel.com, Masayoshi Mizuma <msys.mizuma@gmail.com>,
        ricardo.neri@intel.com, Ian Rogers <irogers@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Colin Cross <ccross@android.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        David Gow <davidgow@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ingo Molnar <mingo@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sami Tolvanen <samitolvanen@google.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v2] hardlockup: detect hard lockups using secondary (buddy) CPUs
Date:   Fri, 28 Apr 2023 16:37:07 -0700
Message-ID: <20230428163507.v2.1.I6bf789d21d0c3d75d382e7e51a804a7a51315f2c@changeid>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Cross <ccross@android.com>

Implement a hardlockup detector that doesn't doesn't need any extra
arch-specific support code to detect lockups. Instead of using
something arch-specific we will use the buddy system, where each CPU
watches out for another one. Specifically, each CPU will use its
softlockup hrtimer to check that the next CPU is processing hrtimer
interrupts by verifying that a counter is increasing.

NOTE: unlike the other hard lockup detectors, the buddy one can't
easily show what's happening on the CPU that locked up just by doing a
simple backtrace. It relies on some other mechanism in the system to
get information about the locked up CPUs. This could be support for
NMI backtraces like [1], it could be a mechanism for printing the PC
of locked CPUs at panic time like [2] / [3], or it could be something
else. Even though that means we still rely on arch-specific code, this
arch-specific code seems to often be implemented even on architectures
that don't have a hardlockup detector.

This style of hardlockup detector originated in some downstream
Android trees and has been rebased on / carried in ChromeOS trees for
quite a long time for use on arm and arm64 boards. Historically on
these boards we've leveraged mechanism [2] / [3] to get information
about hung CPUs, but we could move to [1].

Although the original motivation for the buddy system was for use on
systems without an arch-specific hardlockup detector, it can still be
useful to use even on systems that _do_ have an arch-specific
hardlockup detector. On x86, for instance, there is a 24-part patch
series [4] in progress switching the arch-specific hard lockup
detector from a scarce perf counter to a less-scarce hardware
resource. Potentially the buddy system could be a simpler alternative
to free up the perf counter but still get hard lockup detection.

Overall, pros (+) and cons (-) of the buddy system compared to an
arch-specific hardlockup detector:
+ Usable on systems that don't have an arch-specific hardlockup
  detector, like arm32 and arm64 (though it's being worked on for
  arm64 [5]).
+ May free up scarce hardware resources.
+ If a CPU totally goes out to lunch (can't process NMIs) the buddy
  system could still detect the problem (though it would be unlikely
  to be able to get a stack trace).
- If all CPUs are hard locked up at the same time the buddy system
  can't detect it.
- If we don't have SMP we can't use the buddy system.
- The buddy system needs an arch-specific mechanism (possibly NMI
  backtrace) to get info about the locked up CPU.

[1] https://lore.kernel.org/r/20230419225604.21204-1-dianders@chromium.org
[2] https://issuetracker.google.com/172213129
[3] https://docs.kernel.org/trace/coresight/coresight-cpu-debug.html
[4] https://lore.kernel.org/lkml/20230301234753.28582-1-ricardo.neri-calderon@linux.intel.com/
[5] https://lore.kernel.org/linux-arm-kernel/20220903093415.15850-1-lecopzer.chen@mediatek.com/

Signed-off-by: Colin Cross <ccross@android.com>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Tzung-Bi Shih <tzungbi@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
This patch has been rebased in ChromeOS kernel trees many times, and
each time someone had to do work on it they added their
Signed-off-by. I've included those here. I've also left the author as
Colin Cross since the core code is still his.

I'll also note that the CC list is pretty giant, but that's what
get_maintainers came up with (plus a few other folks I thought would
be interested). As far as I can tell, there's no true MAINTAINER
listed for the existing watchdog code. Assuming people don't hate
this, maybe it would go through Andrew Morton's tree?

Changes in v2:
- cpu => CPU.
- Reworked description and Kconfig based on v1 discussion.
- No code changes

 include/linux/nmi.h         |  18 ++++-
 kernel/Makefile             |   1 +
 kernel/watchdog.c           |  24 ++++--
 kernel/watchdog_buddy_cpu.c | 141 ++++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug           |  23 +++++-
 5 files changed, 196 insertions(+), 11 deletions(-)
 create mode 100644 kernel/watchdog_buddy_cpu.c

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 048c0b9aa623..35f6c5c2378b 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -45,6 +45,8 @@ extern void touch_softlockup_watchdog(void);
 extern void touch_softlockup_watchdog_sync(void);
 extern void touch_all_softlockup_watchdogs(void);
 extern unsigned int  softlockup_panic;
+DECLARE_PER_CPU(unsigned long, hrtimer_interrupts);
+DECLARE_PER_CPU(unsigned long, hrtimer_interrupts_saved);
 
 extern int lockup_detector_online_cpu(unsigned int cpu);
 extern int lockup_detector_offline_cpu(unsigned int cpu);
@@ -81,14 +83,14 @@ static inline void reset_hung_task_detector(void) { }
 #define NMI_WATCHDOG_ENABLED      (1 << NMI_WATCHDOG_ENABLED_BIT)
 #define SOFT_WATCHDOG_ENABLED     (1 << SOFT_WATCHDOG_ENABLED_BIT)
 
-#if defined(CONFIG_HARDLOCKUP_DETECTOR)
+#if defined(CONFIG_HARDLOCKUP_DETECTOR_CORE)
 extern void hardlockup_detector_disable(void);
 extern unsigned int hardlockup_panic;
 #else
 static inline void hardlockup_detector_disable(void) {}
 #endif
 
-#if defined(CONFIG_HAVE_NMI_WATCHDOG) || defined(CONFIG_HARDLOCKUP_DETECTOR)
+#if defined(CONFIG_HAVE_NMI_WATCHDOG) || defined(CONFIG_HARDLOCKUP_DETECTOR_CORE)
 # define NMI_WATCHDOG_SYSCTL_PERM	0644
 #else
 # define NMI_WATCHDOG_SYSCTL_PERM	0444
@@ -124,6 +126,14 @@ void watchdog_nmi_disable(unsigned int cpu);
 
 void lockup_detector_reconfigure(void);
 
+#ifdef CONFIG_HARDLOCKUP_DETECTOR_BUDDY_CPU
+void buddy_cpu_touch_watchdog(void);
+void watchdog_check_hardlockup(void);
+#else
+static inline void buddy_cpu_touch_watchdog(void) {}
+static inline void watchdog_check_hardlockup(void) {}
+#endif
+
 /**
  * touch_nmi_watchdog - restart NMI watchdog timeout.
  *
@@ -134,6 +144,7 @@ void lockup_detector_reconfigure(void);
 static inline void touch_nmi_watchdog(void)
 {
 	arch_touch_nmi_watchdog();
+	buddy_cpu_touch_watchdog();
 	touch_softlockup_watchdog();
 }
 
@@ -196,8 +207,7 @@ static inline bool trigger_single_cpu_backtrace(int cpu)
 u64 hw_nmi_get_sample_period(int watchdog_thresh);
 #endif
 
-#if defined(CONFIG_HARDLOCKUP_CHECK_TIMESTAMP) && \
-    defined(CONFIG_HARDLOCKUP_DETECTOR)
+#if defined(CONFIG_HARDLOCKUP_CHECK_TIMESTAMP) && defined(CONFIG_HARDLOCKUP_DETECTOR_PERF)
 void watchdog_update_hrtimer_threshold(u64 period);
 #else
 static inline void watchdog_update_hrtimer_threshold(u64 period) { }
diff --git a/kernel/Makefile b/kernel/Makefile
index 10ef068f598d..a2054f16f9f4 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -91,6 +91,7 @@ obj-$(CONFIG_FAIL_FUNCTION) += fail_function.o
 obj-$(CONFIG_KGDB) += debug/
 obj-$(CONFIG_DETECT_HUNG_TASK) += hung_task.o
 obj-$(CONFIG_LOCKUP_DETECTOR) += watchdog.o
+obj-$(CONFIG_HARDLOCKUP_DETECTOR_BUDDY_CPU) += watchdog_buddy_cpu.o
 obj-$(CONFIG_HARDLOCKUP_DETECTOR_PERF) += watchdog_hld.o
 obj-$(CONFIG_SECCOMP) += seccomp.o
 obj-$(CONFIG_RELAY) += relay.o
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 8e61f21e7e33..1199043689ae 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -29,7 +29,7 @@
 
 static DEFINE_MUTEX(watchdog_mutex);
 
-#if defined(CONFIG_HARDLOCKUP_DETECTOR) || defined(CONFIG_HAVE_NMI_WATCHDOG)
+#if defined(CONFIG_HARDLOCKUP_DETECTOR_CORE) || defined(CONFIG_HAVE_NMI_WATCHDOG)
 # define WATCHDOG_DEFAULT	(SOFT_WATCHDOG_ENABLED | NMI_WATCHDOG_ENABLED)
 # define NMI_WATCHDOG_DEFAULT	1
 #else
@@ -47,7 +47,7 @@ static int __read_mostly nmi_watchdog_available;
 struct cpumask watchdog_cpumask __read_mostly;
 unsigned long *watchdog_cpumask_bits = cpumask_bits(&watchdog_cpumask);
 
-#ifdef CONFIG_HARDLOCKUP_DETECTOR
+#ifdef CONFIG_HARDLOCKUP_DETECTOR_CORE
 
 # ifdef CONFIG_SMP
 int __read_mostly sysctl_hardlockup_all_cpu_backtrace;
@@ -85,7 +85,9 @@ static int __init hardlockup_panic_setup(char *str)
 }
 __setup("nmi_watchdog=", hardlockup_panic_setup);
 
-#endif /* CONFIG_HARDLOCKUP_DETECTOR */
+#endif /* CONFIG_HARDLOCKUP_DETECTOR_CORE */
+
+#ifdef CONFIG_HARDLOCKUP_DETECTOR
 
 /*
  * These functions can be overridden if an architecture implements its
@@ -106,6 +108,13 @@ void __weak watchdog_nmi_disable(unsigned int cpu)
 	hardlockup_detector_perf_disable();
 }
 
+#else
+
+int __weak watchdog_nmi_enable(unsigned int cpu) { return 0; }
+void __weak watchdog_nmi_disable(unsigned int cpu) { return; }
+
+#endif /* CONFIG_HARDLOCKUP_DETECTOR */
+
 /* Return 0, if a NMI watchdog is available. Error code otherwise */
 int __weak __init watchdog_nmi_probe(void)
 {
@@ -179,8 +188,8 @@ static DEFINE_PER_CPU(unsigned long, watchdog_touch_ts);
 static DEFINE_PER_CPU(unsigned long, watchdog_report_ts);
 static DEFINE_PER_CPU(struct hrtimer, watchdog_hrtimer);
 static DEFINE_PER_CPU(bool, softlockup_touch_sync);
-static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts);
-static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts_saved);
+DEFINE_PER_CPU(unsigned long, hrtimer_interrupts);
+DEFINE_PER_CPU(unsigned long, hrtimer_interrupts_saved);
 static unsigned long soft_lockup_nmi_warn;
 
 static int __init nowatchdog_setup(char *str)
@@ -364,6 +373,9 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 	/* kick the hardlockup detector */
 	watchdog_interrupt_count();
 
+	/* test for hardlockups */
+	watchdog_check_hardlockup();
+
 	/* kick the softlockup detector */
 	if (completion_done(this_cpu_ptr(&softlockup_completion))) {
 		reinit_completion(this_cpu_ptr(&softlockup_completion));
@@ -820,7 +832,7 @@ static struct ctl_table watchdog_sysctls[] = {
 	},
 #endif /* CONFIG_SMP */
 #endif
-#ifdef CONFIG_HARDLOCKUP_DETECTOR
+#ifdef CONFIG_HARDLOCKUP_DETECTOR_CORE
 	{
 		.procname	= "hardlockup_panic",
 		.data		= &hardlockup_panic,
diff --git a/kernel/watchdog_buddy_cpu.c b/kernel/watchdog_buddy_cpu.c
new file mode 100644
index 000000000000..db813b00e6ef
--- /dev/null
+++ b/kernel/watchdog_buddy_cpu.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/cpu.h>
+#include <linux/cpumask.h>
+#include <linux/kernel.h>
+#include <linux/nmi.h>
+#include <linux/percpu-defs.h>
+
+static DEFINE_PER_CPU(bool, watchdog_touch);
+static DEFINE_PER_CPU(bool, hard_watchdog_warn);
+static cpumask_t __read_mostly watchdog_cpus;
+
+static unsigned long hardlockup_allcpu_dumped;
+
+int __init watchdog_nmi_probe(void)
+{
+	return 0;
+}
+
+notrace void buddy_cpu_touch_watchdog(void)
+{
+	/*
+	 * Using __raw here because some code paths have
+	 * preemption enabled.  If preemption is enabled
+	 * then interrupts should be enabled too, in which
+	 * case we shouldn't have to worry about the watchdog
+	 * going off.
+	 */
+	raw_cpu_write(watchdog_touch, true);
+}
+EXPORT_SYMBOL_GPL(buddy_cpu_touch_watchdog);
+
+static unsigned int watchdog_next_cpu(unsigned int cpu)
+{
+	cpumask_t cpus = watchdog_cpus;
+	unsigned int next_cpu;
+
+	next_cpu = cpumask_next(cpu, &cpus);
+	if (next_cpu >= nr_cpu_ids)
+		next_cpu = cpumask_first(&cpus);
+
+	if (next_cpu == cpu)
+		return nr_cpu_ids;
+
+	return next_cpu;
+}
+
+int watchdog_nmi_enable(unsigned int cpu)
+{
+	/*
+	 * The new cpu will be marked online before the first hrtimer interrupt
+	 * runs on it.  If another cpu tests for a hardlockup on the new cpu
+	 * before it has run its first hrtimer, it will get a false positive.
+	 * Touch the watchdog on the new cpu to delay the first check for at
+	 * least 3 sampling periods to guarantee one hrtimer has run on the new
+	 * cpu.
+	 */
+	per_cpu(watchdog_touch, cpu) = true;
+	/* Match with smp_rmb() in watchdog_check_hardlockup() */
+	smp_wmb();
+	cpumask_set_cpu(cpu, &watchdog_cpus);
+	return 0;
+}
+
+void watchdog_nmi_disable(unsigned int cpu)
+{
+	unsigned int next_cpu = watchdog_next_cpu(cpu);
+
+	/*
+	 * Offlining this cpu will cause the cpu before this one to start
+	 * checking the one after this one.  If this cpu just finished checking
+	 * the next cpu and updating hrtimer_interrupts_saved, and then the
+	 * previous cpu checks it within one sample period, it will trigger a
+	 * false positive.  Touch the watchdog on the next cpu to prevent it.
+	 */
+	if (next_cpu < nr_cpu_ids)
+		per_cpu(watchdog_touch, next_cpu) = true;
+	/* Match with smp_rmb() in watchdog_check_hardlockup() */
+	smp_wmb();
+	cpumask_clear_cpu(cpu, &watchdog_cpus);
+}
+
+static int is_hardlockup_buddy_cpu(unsigned int cpu)
+{
+	unsigned long hrint = per_cpu(hrtimer_interrupts, cpu);
+
+	if (per_cpu(hrtimer_interrupts_saved, cpu) == hrint)
+		return 1;
+
+	per_cpu(hrtimer_interrupts_saved, cpu) = hrint;
+	return 0;
+}
+
+void watchdog_check_hardlockup(void)
+{
+	unsigned int next_cpu;
+
+	/*
+	 * Test for hardlockups every 3 samples.  The sample period is
+	 *  watchdog_thresh * 2 / 5, so 3 samples gets us back to slightly over
+	 *  watchdog_thresh (over by 20%).
+	 */
+	if (__this_cpu_read(hrtimer_interrupts) % 3 != 0)
+		return;
+
+	/* check for a hardlockup on the next cpu */
+	next_cpu = watchdog_next_cpu(smp_processor_id());
+	if (next_cpu >= nr_cpu_ids)
+		return;
+
+	/* Match with smp_wmb() in watchdog_nmi_enable() / watchdog_nmi_disable() */
+	smp_rmb();
+
+	if (per_cpu(watchdog_touch, next_cpu) == true) {
+		per_cpu(watchdog_touch, next_cpu) = false;
+		return;
+	}
+
+	if (is_hardlockup_buddy_cpu(next_cpu)) {
+		/* only warn once */
+		if (per_cpu(hard_watchdog_warn, next_cpu) == true)
+			return;
+
+		/*
+		 * Perform all-CPU dump only once to avoid multiple hardlockups
+		 * generating interleaving traces
+		 */
+		if (sysctl_hardlockup_all_cpu_backtrace &&
+				!test_and_set_bit(0, &hardlockup_allcpu_dumped))
+			trigger_allbutself_cpu_backtrace();
+
+		if (hardlockup_panic)
+			panic("Watchdog detected hard LOCKUP on cpu %u", next_cpu);
+		else
+			WARN(1, "Watchdog detected hard LOCKUP on cpu %u", next_cpu);
+
+		per_cpu(hard_watchdog_warn, next_cpu) = true;
+	} else {
+		per_cpu(hard_watchdog_warn, next_cpu) = false;
+	}
+}
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 39d1d93164bd..511eb14660b1 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1036,6 +1036,9 @@ config HARDLOCKUP_DETECTOR_PERF
 config HARDLOCKUP_CHECK_TIMESTAMP
 	bool
 
+config HARDLOCKUP_DETECTOR_CORE
+	bool
+
 #
 # arch/ can define HAVE_HARDLOCKUP_DETECTOR_ARCH to provide their own hard
 # lockup detector rather than the perf based detector.
@@ -1045,6 +1048,7 @@ config HARDLOCKUP_DETECTOR
 	depends on DEBUG_KERNEL && !S390
 	depends on HAVE_HARDLOCKUP_DETECTOR_PERF || HAVE_HARDLOCKUP_DETECTOR_ARCH
 	select LOCKUP_DETECTOR
+	select HARDLOCKUP_DETECTOR_CORE
 	select HARDLOCKUP_DETECTOR_PERF if HAVE_HARDLOCKUP_DETECTOR_PERF
 	help
 	  Say Y here to enable the kernel to act as a watchdog to detect
@@ -1055,9 +1059,26 @@ config HARDLOCKUP_DETECTOR
 	  chance to run.  The current stack trace is displayed upon detection
 	  and the system will stay locked up.
 
+config HARDLOCKUP_DETECTOR_BUDDY_CPU
+	bool "Buddy CPU hardlockup detector"
+	depends on DEBUG_KERNEL && SMP
+	depends on !HARDLOCKUP_DETECTOR && !HAVE_NMI_WATCHDOG
+	depends on !S390
+	select HARDLOCKUP_DETECTOR_CORE
+	select SOFTLOCKUP_DETECTOR
+	help
+	  Say Y here to enable a hardlockup detector where CPUs check
+	  each other for lockup. Each cpu uses its softlockup hrtimer
+	  to check that the next cpu is processing hrtimer interrupts by
+	  verifying that a counter is increasing.
+
+	  This hardlockup detector is useful on systems that don't have
+	  an arch-specific hardlockup detector or if resources needed
+	  for the hardlockup detector are better used for other things.
+
 config BOOTPARAM_HARDLOCKUP_PANIC
 	bool "Panic (Reboot) On Hard Lockups"
-	depends on HARDLOCKUP_DETECTOR
+	depends on HARDLOCKUP_DETECTOR_CORE
 	help
 	  Say Y here to enable the kernel to panic on "hard lockups",
 	  which are bugs that cause the kernel to loop in kernel
-- 
2.40.1.495.gc816e09b53d-goog


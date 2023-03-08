Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601076B16C0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 00:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjCHXoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 18:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjCHXoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 18:44:16 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538CA4ECD7
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 15:44:15 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id i11-20020a256d0b000000b0086349255277so367644ybc.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 15:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678319054;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n/mHoc7rdIVyP6SjCmnYWEVxWbxTFdBfjkO7Cphs/Y8=;
        b=U9XnRqyIcHZlgCMCmZUJIJU8Q70ekr4po6OM/aPP3aeCrG+YISFSfLv1p37UNwI0A/
         B/ofizuQZd3kpZF/QLKqDuglyC51omgoE8OfPKAs6krpdtjBDoh0FNcjFeiW1Pe8g5og
         ONp+bh9wLPjBuHo2ZRAD4xB4c6uPKS70hO9vL6/UuGZa7r+zuG33OAsfbwzY4kURUpB4
         OQvjWS4D2tTGBLBIGb54D9G4HaMrEGiLgP0R27Dr4s3zQW4l2sCAYxjYH7pYSwRU4KIu
         VA9KA0ynJld0GSEsIbHXI8RZ6b7/gIVXUBKPeexMX5jBFrM3QDfNXEiCC5Kb4YruKtMa
         AWyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678319054;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n/mHoc7rdIVyP6SjCmnYWEVxWbxTFdBfjkO7Cphs/Y8=;
        b=opCESO9bsX/h0I4XCK9K21EQQrd/z8twBOxnRJYp5uROV5CVbJFa78B/A8Okz6DHkM
         W9R4x28bLcbE+wv6ggHLOeuRTBUVVjgtmNXiLDhzMKA2Y1MRdKrnLpJTUpCvpVLZZ463
         hoo34o7TMiZG/Ghhb9gmwBRhagoExapztIw0RKDLhq9fo87t6aj6UEPJ3uSv1y5G8n1q
         mTuDEKslLC+QfBODXZFIiGeCeBkgg7hAT61JoVcGMT3kzyq9MUbvlkJ1BnJ7pDwYk1JU
         eT/6FAbyGkeEzTpI8eSaUrAh373MAhQzYCl+/ziIcUEfH2TR8994ToKTSkMfzHBIA/+O
         Btcw==
X-Gm-Message-State: AO0yUKWEbma5nlfYpBm+BRWtarUY7MTRDgxn2QUuoCdzGC/3BtrzJRDU
        T/AZEtJWw/cwKxFRi1vZaefcjkqxhGhearEHtAv1pwojmcdFC4di1I1dBmV3tpi4vsccXKF7DbZ
        0XwcbDwpfhrQI/oZPTfyUWZCADpvf1Yv427zCzIzQ2CjY112x8XKmZG1Qji3wRzmjWAQRLoQt
X-Google-Smtp-Source: AK7set+qoo1ALH5zT6QU3ECaPEPkv+g0PtJaB7BfZs45Fgt2iNLKfP9LW7+25WR8MrWxbdy7YtFBDKRQjyR5
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2d4:203:a52:ab08:2101:5a8a])
 (user=eranian job=sendgmr) by 2002:a05:6902:84:b0:b23:d22:4f45 with SMTP id
 h4-20020a056902008400b00b230d224f45mr1ybs.454.1678319054116; Wed, 08 Mar 2023
 15:44:14 -0800 (PST)
Date:   Wed,  8 Mar 2023 15:43:32 -0800
Message-Id: <20230308234332.3355689-1-eranian@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Subject: [PATCH V2] x86/resctrl: robustify __resctrl_sched_in
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        tony.luck@intel.com, reinette.chatre@intel.com,
        fenghua.yu@intel.com, peternewman@google.com,
        ndesaulniers@google.com, morbo@google.com, jakub@redhat.com,
        james.morse@arm.com, babu.moger@amd.com, ananth.narayan@amd.com,
        vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling the kernel with clang, there is a problem with the code
in __rescrtl_sched_in() because of the way the inline function is optimized
when called from __switch_to(). The effect of the problem is that the
bandwidth restriction driven by the CLOSID is not enforced. The problem is
easy to reproduce on Intel or AMD x86 systems:

1. If resctrl filesystem is not mounted:
  $ mount -t resctrl none /sys/fs/resctrl

2. Create resctrl group:
  $ mkdir /sys/fs/resctrl/test

3. move shell into resctrl group
  $ echo $$ > /sys/fs/resctrl/test/tasks

4. Run bandwidth consuming test in background on CPU0
  $ taskset -c 0 triad &

5. Monitor bandwidth consumption
   Using perf to measure bandwidth on your processor

6. Restrict bandwidth
  - Intel: $ echo MB:0=10 > /sys/fs/resctrl/test/schemata
  - AMD: $ echo MB:0=240 > /sys/fs/resctrl/tests/schemata

 7. Monitor bandwidth again

At 7, you will see that the restriction is not enforced.

The problem is located in the __resctrl_sched_in() routine which rewrites
the active closid via the PQR_ASSOC register. Because this is an expensive
operation, the kernel only does it when the context switch involves tasks
with different CLOSIDs. And to check that, it needs to access the task being
scheduled in. And for that it is using the current task pointer to access
the task's closid field using current->closid. current is actually a macro
that reads the per-cpu variable pcpu_hot.current_task.

After an investigation by compiler experts, the problem has been tracked down
to the usage of the get_current() macro in the __resctrl_sched_in() code and
in particular the per-cpu macro:

static __always_inline struct task_struct *get_current(void)
{
        return this_cpu_read_stable(pcpu_hot.current_task);
}

And as per percpu.h:

/*
 * this_cpu_read() makes gcc load the percpu variable every time it is
 * accessed while this_cpu_read_stable() allows the value to be cached.
 * this_cpu_read_stable() is more efficient and can be used if its value
 * is guaranteed to be valid across cpus.  The current users include
 * get_current() and get_thread_info() both of which are actually
 * per-thread variables implemented as per-cpu variables and thus
 * stable for the duration of the respective task.
 */

The _stable version of the macro allows the value to be cached, i.e.,
not forcing a reload.

However in the __switch_to() routine, the current pointer is changed.  If the
compiler optimizes away the reload, then the resctrl_sched_in will look
at the previous task instead of the new current task. This explains why we
are not seeing the bandwidth limit enforced on the benchmark.

Note that the problem was detected when compiling the kernel with clang (v14)
but it could also happen with gcc.

To fix the problem, there are a few solutions.

In V1, we modified the resctrl_sched_in() function to use the this_cpu_read()
form of the macro. Given this is specific to the __switch_to routine, we do
not change get_current() but instead invoke the lower level macro directly
from __resched_sched_in(). This has no impact on any other calls of
get_current().

In V2, after further discussions with kernel maintainers and LLVM developers,
the conclusion that it was the problem is caused by the compiler but that the
function is not written in a proper manner and that the compiler is just
exposing the problem. So it is best to change the __resctrl_sched_in()
function to:
  (1) be a proper static inline function
  (2) pass the task pointer of the task scheduled in instead of retrieving
      it from the current pointer. It makes more sense and follows other
      sched_in type functions. If you are scheduling something in, then you
      need to name what it is, you should not rely on the current pointer.
      This solution was proposed by Linus.

Patch was tested on AMD Zen3 + MBA and I verified that the bandwidth limit
was now enforced.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Tested-by: Stephane Eranian <eranian@google.com>
Tested-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/include/asm/resctrl.h         | 12 ++++++------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  4 ++--
 arch/x86/kernel/process_32.c           |  2 +-
 arch/x86/kernel/process_64.c           |  2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index 52788f79786f..255a78d9d906 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -49,7 +49,7 @@ DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
  *   simple as possible.
  * Must be called with preemption disabled.
  */
-static void __resctrl_sched_in(void)
+static inline void __resctrl_sched_in(struct task_struct *tsk)
 {
 	struct resctrl_pqr_state *state = this_cpu_ptr(&pqr_state);
 	u32 closid = state->default_closid;
@@ -61,13 +61,13 @@ static void __resctrl_sched_in(void)
 	 * Else use the closid/rmid assigned to this cpu.
 	 */
 	if (static_branch_likely(&rdt_alloc_enable_key)) {
-		tmp = READ_ONCE(current->closid);
+		tmp = READ_ONCE(tsk->closid);
 		if (tmp)
 			closid = tmp;
 	}
 
 	if (static_branch_likely(&rdt_mon_enable_key)) {
-		tmp = READ_ONCE(current->rmid);
+		tmp = READ_ONCE(tsk->rmid);
 		if (tmp)
 			rmid = tmp;
 	}
@@ -88,17 +88,17 @@ static inline unsigned int resctrl_arch_round_mon_val(unsigned int val)
 	return val * scale;
 }
 
-static inline void resctrl_sched_in(void)
+static inline void resctrl_sched_in(struct task_struct *tsk)
 {
 	if (static_branch_likely(&rdt_enable_key))
-		__resctrl_sched_in();
+		__resctrl_sched_in(tsk);
 }
 
 void resctrl_cpu_detect(struct cpuinfo_x86 *c);
 
 #else
 
-static inline void resctrl_sched_in(void) {}
+static inline void resctrl_sched_in(struct task_struct *tsk) {}
 static inline void resctrl_cpu_detect(struct cpuinfo_x86 *c) {}
 
 #endif /* CONFIG_X86_CPU_RESCTRL */
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index e2c1599d1b37..884b6e9a7e31 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -314,7 +314,7 @@ static void update_cpu_closid_rmid(void *info)
 	 * executing task might have its own closid selected. Just reuse
 	 * the context switch code.
 	 */
-	resctrl_sched_in();
+	resctrl_sched_in(current);
 }
 
 /*
@@ -530,7 +530,7 @@ static void _update_task_closid_rmid(void *task)
 	 * Otherwise, the MSR is updated when the task is scheduled in.
 	 */
 	if (task == current)
-		resctrl_sched_in();
+		resctrl_sched_in(task);
 }
 
 static void update_task_closid_rmid(struct task_struct *t)
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 470c128759ea..708c87b88cc1 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -212,7 +212,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	switch_fpu_finish();
 
 	/* Load the Intel cache allocation PQR MSR. */
-	resctrl_sched_in();
+	resctrl_sched_in(next_p);
 
 	return prev_p;
 }
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 4e34b3b68ebd..bb65a68b4b49 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -656,7 +656,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	}
 
 	/* Load the Intel cache allocation PQR MSR. */
-	resctrl_sched_in();
+	resctrl_sched_in(next_p);
 
 	return prev_p;
 }
-- 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A9D6AA56B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 00:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbjCCXLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 18:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbjCCXLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 18:11:41 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C70E16895
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 15:11:40 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id k6-20020a25e806000000b00a623fca0d0aso3944417ybd.16
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 15:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GL6P2oIT0AWRlhZruSuJU3WcvX0uIxqCri4d5fB1+Yo=;
        b=FQxTgSJ2csXwM5K13nCRvAZaEYdTUR7SaVLsaFIwHFMhwqtxEgxMonljRlIgNIdv1H
         l8ZucZGohbGbWXJ8Wqp8lYyJsvSeB/mxyHpfxXTjMSqh3Ed5o4eCdnI6L4UDy5b4ffmY
         YrNXKC00V9+dXppZ2h8hEKSZpw3eK559lyENZwpulQXagJcSU4Hui/rojVWvKDYpwnz2
         C56VA6Kp+L21ESzvLPgo1r1RLUPO2Z2hgZMZbB5BBMOxiGXO7B0pxZc6OHJOuOUovvNB
         Qux97JRzRja0SBXaDJ+wR4qb0hSV94EHO8bL7vJB6mkn4VKr/WC4Or9aY8ys0a4bZADY
         PBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GL6P2oIT0AWRlhZruSuJU3WcvX0uIxqCri4d5fB1+Yo=;
        b=UtPd4uXkivID7GQRkYqLLUNKcYGRpLyyxV/Uy/Wg4EULsqLPysOSKikcGbt847A+uo
         sPQJ2/Fz7v4bBtZTHNASpShtRIcMqsykT+rW/pAxw3AzC7QxhdvZeduGgmG2dufDM2A4
         dwkarCxac1kVIKo6X6ZDZlPtVwNbtYob2xpTO/VExAvfTBIdyknIgysK/7M8AURN3Bqn
         UlU9wZ/wFPpP6Eb67husgyM8tznvTsJ1HAxIOehXMcqF20/Si2ha57s5zIISjbQPAfyj
         26wc8qBjDiLrs6Wnyv1/0Tl8ud/lNfrZVH+QRM94UjjCi/u7WyTEL/bV/PKubSgXXqUY
         KfTw==
X-Gm-Message-State: AO0yUKUippePDG+lEq+lhLQZQ3PMXknUb8WFqw69wlIzvt9hZgFGNKGz
        6n6ePqdWzAprppHDIhpWGRJwMdfizcrLl3vSh/F5K+TWWSWX1bdCGj5V+egy8v5IFXlYkquNGGm
        +5mrDZh+nqnIyVV5ZsWk2W4ou0JnHmse2f01qMfu7sXAxNx5JLU+MO5dnWyrL76u9DKl4lAZW
X-Google-Smtp-Source: AK7set9PMfE6vzaKghu90ZMO0HZ9Rl3BFgB1MY6stuKpYUUn8PSbE1ZVQyFT/Y95uatULEVwViJn1P3ns22k
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2d4:203:64c3:9353:a1a7:cada])
 (user=eranian job=sendgmr) by 2002:a5b:611:0:b0:997:c919:4484 with SMTP id
 d17-20020a5b0611000000b00997c9194484mr1643609ybq.6.1677885098864; Fri, 03 Mar
 2023 15:11:38 -0800 (PST)
Date:   Fri,  3 Mar 2023 15:11:33 -0800
Message-Id: <20230303231133.1486085-1-eranian@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Subject: [PATCH] x86/resctrl: avoid compiler optimization in __resctrl_sched_in
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, tony.luck@intel.com,
        reinette.chatre@intel.com, fenghua.yu@intel.com,
        peternewman@google.com, bp@suse.de, james.morse@arm.com,
        babu.moger@amd.com, ananth.narayan@amd.com, vschneid@redhat.com
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

When compiling the kernel with clang, we have a problem with the code
in __rescrtl_sched_in() because of the way theinline is optimized when called
from __switch_to(). The effect of the problem is that the bandwidth
restriction driven by the CLOSId is not enforced. The problem is easy to
reproduce on Intel or AMD x86 systems:

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
with different CLOSID. And to check that, it needs to access the current
task's closid field using current->closid. current is actually a macro
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

The _stable version of the macro allows the value to be cached, meaning it
does not force a reload.

However in the __switch_to() routine, the current point is changed.  If the
compiler optimizes away the reload, then the resctrl_sched_in will look
at the previous task instead of the new current task. This explains why we
were not seeing the limit enforced on the benchmark.

To fix the problem, the resctrl_sched_in() function must use the
this_cpu_read() form of the macro. Given this is specific to the __switch_to
routine, we do not change get_current() but instead invoke the lower level
macro directly from __resched_sched_in(). This has no impact on any other
calls of get_current().

Note that the problem was detected when compiling the kernel with clang (v14)
but it could also happen with gcc.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/x86/include/asm/resctrl.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index 52788f79786fa..f791606a8cb15 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -54,6 +54,7 @@ static void __resctrl_sched_in(void)
 	struct resctrl_pqr_state *state = this_cpu_ptr(&pqr_state);
 	u32 closid = state->default_closid;
 	u32 rmid = state->default_rmid;
+	struct task_struct *cur;
 	u32 tmp;
 
 	/*
@@ -61,13 +62,15 @@ static void __resctrl_sched_in(void)
 	 * Else use the closid/rmid assigned to this cpu.
 	 */
 	if (static_branch_likely(&rdt_alloc_enable_key)) {
-		tmp = READ_ONCE(current->closid);
+		cur = this_cpu_read(pcpu_hot.current_task);
+		tmp = READ_ONCE(cur->closid);
 		if (tmp)
 			closid = tmp;
 	}
 
 	if (static_branch_likely(&rdt_mon_enable_key)) {
-		tmp = READ_ONCE(current->rmid);
+		cur = this_cpu_read(pcpu_hot.current_task);
+		tmp = READ_ONCE(cur->rmid);
 		if (tmp)
 			rmid = tmp;
 	}
-- 
2.40.0.rc0.216.gc4246ad0f0-goog


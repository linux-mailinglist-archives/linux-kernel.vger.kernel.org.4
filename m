Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCA76E2856
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 18:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjDNQa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 12:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjDNQau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 12:30:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07C85581
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 09:30:48 -0700 (PDT)
Message-ID: <20230414162841.292513270@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681489847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Liy0JL0O99yuZfbRpqXKPbI/GHoH9SgVRO31sSZwo7E=;
        b=ijF0ruw1cRMf22DDY8lmd1RpMdgKqhhAKkwlN0FRiBkbd5rpJLGGXc6GIVBW2BbRxz+vrs
        bZINbc9E23N9wlLYUwjvi3tmXJ1x+IPt4Ms2sgxXE5oSFZGuZ9xJXM6yqt56hOoy5h+e8r
        IXQV2yLLh0BEcBOUq7fAsL3h3mRk5+BoQvLVLP9DC9TWBqDDBUtrbtyJOHtpVA8WVv2maC
        I/49Pc6G6I0AGxUSCTvpI+8aUkJHJtFsa0vzxnk8LF60uJJ14iOfxeeQi9R4xPF0/f3xQh
        qKas2Szjgx59CicyyVV4R+ZlbG1G+0ip+HLYkw+WSJZgNrbys3cRgU0nx79kYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681489847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Liy0JL0O99yuZfbRpqXKPbI/GHoH9SgVRO31sSZwo7E=;
        b=88gs/L+WXECo4w3u1kbaszJZORO8dhFU42usZ2pHN0I3SSSJ1k5U4lRitxe8qPvcWmWzCC
        0yekjG5CpzkPrmCw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Dave Chinner <dchinner@redhat.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ye Bin <yebin10@huawei.com>, linux-mm@kvack.org
Subject: [patch 3/3] cpu/hotplug: Get rid of cpu_dying_mask
References: <20230414162755.281993820@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 14 Apr 2023 18:30:46 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpu_dying_mask is not only undocumented but also to some extent a
misnomer. It's purpose is to capture the last direction of a cpu_up() or
cpu_down() operation taking eventual rollback operations into account.  The
name and the lack of documentation lured already someone to use it in the
wrong way.

The initial user is the scheduler code which needs to keep the decision
correct whether to schedule tasks on a CPU, which is between the
CPUHP_ONLINE and the CPUHP_ACTIVE state and has the balance_push() hook
installed.

cpu_dying mask is not really useful for general consumption. The
cpu_dying_mask bits are sticky even after cpu_up() or cpu_down()
completes. 

It might be argued, that the cpu_dying_mask bit could be cleared when
cpu_down() completes, but that's not possible under all circumstances.

Especially not with partial hotplug operations. In that case the bit must
be sticky in order to keep the initial user, i.e. the scheduler correct.

Replace the cpumask completely by:

  - recording the direction internally in the CPU hotplug core state

  - exposing that state via a documented function to the scheduler

After that cpu_dying_mask is not longer in use and removed before the next
user trips over it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/cpumask.h |   21 ---------------------
 kernel/cpu.c            |   43 +++++++++++++++++++++++++++++++++++++------
 kernel/sched/core.c     |    4 ++--
 kernel/smpboot.h        |    2 ++
 4 files changed, 41 insertions(+), 29 deletions(-)
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -126,12 +126,10 @@ extern struct cpumask __cpu_possible_mas
 extern struct cpumask __cpu_online_mask;
 extern struct cpumask __cpu_present_mask;
 extern struct cpumask __cpu_active_mask;
-extern struct cpumask __cpu_dying_mask;
 #define cpu_possible_mask ((const struct cpumask *)&__cpu_possible_mask)
 #define cpu_online_mask   ((const struct cpumask *)&__cpu_online_mask)
 #define cpu_present_mask  ((const struct cpumask *)&__cpu_present_mask)
 #define cpu_active_mask   ((const struct cpumask *)&__cpu_active_mask)
-#define cpu_dying_mask    ((const struct cpumask *)&__cpu_dying_mask)
 
 extern atomic_t __num_online_cpus;
 
@@ -1015,15 +1013,6 @@ set_cpu_active(unsigned int cpu, bool ac
 		cpumask_clear_cpu(cpu, &__cpu_active_mask);
 }
 
-static inline void
-set_cpu_dying(unsigned int cpu, bool dying)
-{
-	if (dying)
-		cpumask_set_cpu(cpu, &__cpu_dying_mask);
-	else
-		cpumask_clear_cpu(cpu, &__cpu_dying_mask);
-}
-
 /**
  * to_cpumask - convert an NR_CPUS bitmap to a struct cpumask *
  * @bitmap: the bitmap
@@ -1097,11 +1086,6 @@ static inline bool cpu_active(unsigned i
 	return cpumask_test_cpu(cpu, cpu_active_mask);
 }
 
-static inline bool cpu_dying(unsigned int cpu)
-{
-	return cpumask_test_cpu(cpu, cpu_dying_mask);
-}
-
 #else
 
 #define num_online_cpus()	1U
@@ -1129,11 +1113,6 @@ static inline bool cpu_active(unsigned i
 	return cpu == 0;
 }
 
-static inline bool cpu_dying(unsigned int cpu)
-{
-	return false;
-}
-
 #endif /* NR_CPUS > 1 */
 
 #define cpu_is_offline(cpu)	unlikely(!cpu_online(cpu))
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -53,6 +53,9 @@
  * @rollback:	Perform a rollback
  * @single:	Single callback invocation
  * @bringup:	Single callback bringup or teardown selector
+ * @goes_down:	Indicator for direction of cpu_up()/cpu_down() operations
+ *		including eventual rollbacks. Not affected by state or
+ *		instance add/remove operations. See cpuhp_cpu_goes_down().
  * @cpu:	CPU number
  * @node:	Remote CPU node; for multi-instance, do a
  *		single entry callback for install/remove
@@ -72,6 +75,7 @@ struct cpuhp_cpu_state {
 	bool			rollback;
 	bool			single;
 	bool			bringup;
+	bool			goes_down;
 	struct hlist_node	*node;
 	struct hlist_node	*last;
 	enum cpuhp_state	cb_state;
@@ -295,6 +299,37 @@ void cpu_maps_update_done(void)
 	mutex_unlock(&cpu_add_remove_lock);
 }
 
+/**
+ * cpuhp_cpu_goes_down - Query the current/last CPU hotplug direction of a CPU
+ * @cpu:	The CPU to query
+ *
+ * The direction indicator is modified by the hotplug core on
+ * cpu_up()/cpu_down() operations including eventual rollback operations.
+ * The indicator is not affected by state or instance install/remove
+ * operations.
+ *
+ * The indicator is sticky after the hotplug operation completes, whether
+ * the operation was a full up/down or just a partial bringup/teardown.
+ *
+ *				goes_down
+ *   cpu_up(target) enter	-> False
+ *	rollback on fail	-> True
+ *   cpu_up(target) exit	Last state
+ *
+ *   cpu_down(target) enter	-> True
+ *	rollback on fail	-> False
+ *   cpu_down(target) exit	Last state
+ *
+ * The return value is a racy snapshot and not protected against concurrent
+ * CPU hotplug operations which modify the indicator.
+ *
+ * Returns: True if cached direction is down, false otherwise
+ */
+bool cpuhp_cpu_goes_down(unsigned int cpu)
+{
+	return data_race(per_cpu(cpuhp_state.goes_down, cpu));
+}
+
 /*
  * If set, cpu_up and cpu_down will return -EBUSY and do nothing.
  * Should always be manipulated under cpu_add_remove_lock
@@ -486,8 +521,7 @@ cpuhp_set_state(int cpu, struct cpuhp_cp
 	st->target = target;
 	st->single = false;
 	st->bringup = bringup;
-	if (cpu_dying(cpu) != !bringup)
-		set_cpu_dying(cpu, !bringup);
+	st->goes_down = !bringup;
 
 	return prev_state;
 }
@@ -521,8 +555,7 @@ cpuhp_reset_state(int cpu, struct cpuhp_
 	}
 
 	st->bringup = bringup;
-	if (cpu_dying(cpu) != !bringup)
-		set_cpu_dying(cpu, !bringup);
+	st->goes_down = !bringup;
 }
 
 /* Regular hotplug invocation of the AP hotplug thread */
@@ -2644,8 +2677,6 @@ EXPORT_SYMBOL(__cpu_present_mask);
 
 struct cpumask __cpu_active_mask __read_mostly;
 
-struct cpumask __cpu_dying_mask __read_mostly;
-
 atomic_t __num_online_cpus __read_mostly;
 EXPORT_SYMBOL(__num_online_cpus);
 
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2297,7 +2297,7 @@ static inline bool is_cpu_allowed(struct
 		return cpu_online(cpu);
 
 	/* Regular kernel threads don't get to stay during offline. */
-	if (cpu_dying(cpu))
+	if (cpuhp_cpu_goes_down(cpu))
 		return false;
 
 	/* But are allowed during online. */
@@ -9344,7 +9344,7 @@ static void balance_push(struct rq *rq)
 	 * Only active while going offline and when invoked on the outgoing
 	 * CPU.
 	 */
-	if (!cpu_dying(rq->cpu) || rq != this_rq())
+	if (!cpuhp_cpu_goes_down(rq->cpu) || rq != this_rq())
 		return;
 
 	/*
--- a/kernel/smpboot.h
+++ b/kernel/smpboot.h
@@ -20,4 +20,6 @@ int smpboot_unpark_threads(unsigned int
 
 void __init cpuhp_threads_init(void);
 
+bool cpuhp_cpu_goes_down(unsigned int cpu);
+
 #endif


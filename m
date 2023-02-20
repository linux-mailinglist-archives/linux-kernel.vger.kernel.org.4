Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4746269D752
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 00:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbjBTXw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 18:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbjBTXwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 18:52:22 -0500
Received: from out-13.mta1.migadu.com (out-13.mta1.migadu.com [95.215.58.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D821EFF9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 15:52:03 -0800 (PST)
Date:   Mon, 20 Feb 2023 18:51:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676937121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8QOQrdYzVjFtqc7eVd7UNgEve/PmAyEghqF2+QGwS10=;
        b=frWXmUO5HfvBGawZnq4dAlCrMjvRtoMdWABWKiBYO+Uc1zK7pMSafswAJ4wcrcAXhCQEXU
        ECiTUxLwm02UDj2hSiCTDtuzORIzW//GtW6BWN2PSqwFBb21JuOH4NR/fVgkXnT5jxMQzB
        U9Ptj/iD9e6752eOPyJhHzBbuh14SpY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        stern@rowland.harvard.edu
Subject: Re: [PATCH 1/2] lockdep: lock_set_lock_cmp_fn()
Message-ID: <Y/QHn+PecW2n2K5O@moria.home.lan>
References: <20230218032117.2372071-1-kent.overstreet@linux.dev>
 <20230218032117.2372071-2-kent.overstreet@linux.dev>
 <Y/ONLYqVrWPFyboF@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/ONLYqVrWPFyboF@hirez.programming.kicks-ass.net>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 04:09:33PM +0100, Peter Zijlstra wrote:
> which is much simpler to work with. Can we improve on this? Give the
> cmp_fn an additinoal optional argument of a string pointer or so to fill
> out with actual details to be printed?

Here you go, example bcache output:

Patch is not as pretty as I'd like because not every path that prints a
lock has held_lock available - but the ones we care about in this
scenario do.

============================================
WARNING: possible recursive locking detected
6.2.0-rc8-00003-g7d81e591ca6a-dirty #15 Not tainted
--------------------------------------------
kworker/14:3/938 is trying to acquire lock:
ffff8880143218c8 (&b->lock l=0 0:2803368){++++}-{3:3}, at: bch_btree_node_get.part.0+0x81/0x2b0

but task is already holding lock:
ffff8880143de8c8 (&b->lock l=1 1048575:9223372036854775807){++++}-{3:3}, at: __bch_btree_map_nodes+0xea/0x1e0
and the lock comparison function returns 1:

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&b->lock l=1 1048575:9223372036854775807);
  lock(&b->lock l=0 0:2803368);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

3 locks held by kworker/14:3/938:
 #0: ffff888005ea9d38 ((wq_completion)bcache){+.+.}-{0:0}, at: process_one_work+0x1ec/0x530
 #1: ffff8880098c3e70 ((work_completion)(&cl->work)#3){+.+.}-{0:0}, at: process_one_work+0x1ec/0x530
 #2: ffff8880143de8c8 (&b->lock l=1 1048575:9223372036854775807){++++}-{3:3}, at: __bch_btree_map_nodes+0xea/0x1e0

-- >8 --
Subject: [PATCH] lockdep: lock_set_print_fn()

This implements a new interface to lockedp, lock_set_print_fn(), for
printing additional information about a lock.

This is intended to be useful with the previous lock_set_cmp_fn(); when
defininig an ordering for locks of a given type, we'll want to print out
information about that lock that's relevant for the ordering we defined.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
---
 include/linux/lockdep.h       |  3 ++
 include/linux/lockdep_types.h |  2 +
 kernel/locking/lockdep.c      | 81 ++++++++++++++++++++++-------------
 3 files changed, 57 insertions(+), 29 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 98e0338a74..66d8a5a24e 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -664,10 +664,13 @@ lockdep_rcu_suspicious(const char *file, const int line, const char *s)
 
 #ifdef CONFIG_PROVE_LOCKING
 void lockdep_set_lock_cmp_fn(struct lockdep_map *lock, lock_cmp_fn fn);
+void lockdep_set_lock_print_fn(struct lockdep_map *lock, lock_print_fn fn);
 
 #define lock_set_cmp_fn(lock, fn)	lockdep_set_lock_cmp_fn(&(lock)->dep_map, fn)
+#define lock_set_print_fn(lock, fn)	lockdep_set_lock_print_fn(&(lock)->dep_map, fn)
 #else
 #define lock_set_cmp_fn(lock, fn)	do {} while (0)
+#define lock_set_print_fn(lock, fn)	do {} while (0)
 #endif
 
 #endif /* __LINUX_LOCKDEP_H */
diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
index 813467dccb..8bf79c4e48 100644
--- a/include/linux/lockdep_types.h
+++ b/include/linux/lockdep_types.h
@@ -87,6 +87,7 @@ struct lock_trace;
 struct lockdep_map;
 typedef int (*lock_cmp_fn)(const struct lockdep_map *a,
 			   const struct lockdep_map *b);
+typedef void (*lock_print_fn)(const struct lockdep_map *map);
 
 /*
  * The lock-class itself. The order of the structure members matters.
@@ -114,6 +115,7 @@ struct lock_class {
 
 	const struct lockdep_subclass_key *key;
 	lock_cmp_fn			cmp_fn;
+	lock_print_fn			print_fn;
 
 	unsigned int			subclass;
 	unsigned int			dep_gen_id;
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index b9e759743e..edecd0301b 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -708,7 +708,7 @@ void get_usage_chars(struct lock_class *class, char usage[LOCK_USAGE_CHARS])
 	usage[i] = '\0';
 }
 
-static void __print_lock_name(struct lock_class *class)
+static void __print_lock_name(struct held_lock *hlock, struct lock_class *class)
 {
 	char str[KSYM_NAME_LEN];
 	const char *name;
@@ -723,17 +723,19 @@ static void __print_lock_name(struct lock_class *class)
 			printk(KERN_CONT "#%d", class->name_version);
 		if (class->subclass)
 			printk(KERN_CONT "/%d", class->subclass);
+		if (hlock && class->print_fn)
+			class->print_fn(hlock->instance);
 	}
 }
 
-static void print_lock_name(struct lock_class *class)
+static void print_lock_name(struct held_lock *hlock, struct lock_class *class)
 {
 	char usage[LOCK_USAGE_CHARS];
 
 	get_usage_chars(class, usage);
 
 	printk(KERN_CONT " (");
-	__print_lock_name(class);
+	__print_lock_name(hlock, class);
 	printk(KERN_CONT "){%s}-{%d:%d}", usage,
 			class->wait_type_outer ?: class->wait_type_inner,
 			class->wait_type_inner);
@@ -771,7 +773,7 @@ static void print_lock(struct held_lock *hlock)
 	}
 
 	printk(KERN_CONT "%px", hlock->instance);
-	print_lock_name(lock);
+	print_lock_name(hlock, lock);
 	printk(KERN_CONT ", at: %pS\n", (void *)hlock->acquire_ip);
 }
 
@@ -1867,7 +1869,7 @@ print_circular_bug_entry(struct lock_list *target, int depth)
 	if (debug_locks_silent)
 		return;
 	printk("\n-> #%u", depth);
-	print_lock_name(target->class);
+	print_lock_name(NULL, target->class);
 	printk(KERN_CONT ":\n");
 	print_lock_trace(target->trace, 6);
 }
@@ -1896,11 +1898,11 @@ print_circular_lock_scenario(struct held_lock *src,
 	 */
 	if (parent != source) {
 		printk("Chain exists of:\n  ");
-		__print_lock_name(source);
+		__print_lock_name(src, source);
 		printk(KERN_CONT " --> ");
-		__print_lock_name(parent);
+		__print_lock_name(NULL, parent);
 		printk(KERN_CONT " --> ");
-		__print_lock_name(target);
+		__print_lock_name(tgt, target);
 		printk(KERN_CONT "\n\n");
 	}
 
@@ -1908,16 +1910,16 @@ print_circular_lock_scenario(struct held_lock *src,
 	printk("       CPU0                    CPU1\n");
 	printk("       ----                    ----\n");
 	printk("  lock(");
-	__print_lock_name(target);
+	__print_lock_name(tgt, target);
 	printk(KERN_CONT ");\n");
 	printk("                               lock(");
-	__print_lock_name(parent);
+	__print_lock_name(NULL, parent);
 	printk(KERN_CONT ");\n");
 	printk("                               lock(");
-	__print_lock_name(target);
+	__print_lock_name(tgt, target);
 	printk(KERN_CONT ");\n");
 	printk("  lock(");
-	__print_lock_name(source);
+	__print_lock_name(src, source);
 	printk(KERN_CONT ");\n");
 	printk("\n *** DEADLOCK ***\n\n");
 }
@@ -2335,7 +2337,7 @@ static void print_lock_class_header(struct lock_class *class, int depth)
 	int bit;
 
 	printk("%*s->", depth, "");
-	print_lock_name(class);
+	print_lock_name(NULL, class);
 #ifdef CONFIG_DEBUG_LOCKDEP
 	printk(KERN_CONT " ops: %lu", debug_class_ops_read(class));
 #endif
@@ -2517,11 +2519,11 @@ print_irq_lock_scenario(struct lock_list *safe_entry,
 	 */
 	if (middle_class != unsafe_class) {
 		printk("Chain exists of:\n  ");
-		__print_lock_name(safe_class);
+		__print_lock_name(NULL, safe_class);
 		printk(KERN_CONT " --> ");
-		__print_lock_name(middle_class);
+		__print_lock_name(NULL, middle_class);
 		printk(KERN_CONT " --> ");
-		__print_lock_name(unsafe_class);
+		__print_lock_name(NULL, unsafe_class);
 		printk(KERN_CONT "\n\n");
 	}
 
@@ -2529,18 +2531,18 @@ print_irq_lock_scenario(struct lock_list *safe_entry,
 	printk("       CPU0                    CPU1\n");
 	printk("       ----                    ----\n");
 	printk("  lock(");
-	__print_lock_name(unsafe_class);
+	__print_lock_name(NULL, unsafe_class);
 	printk(KERN_CONT ");\n");
 	printk("                               local_irq_disable();\n");
 	printk("                               lock(");
-	__print_lock_name(safe_class);
+	__print_lock_name(NULL, safe_class);
 	printk(KERN_CONT ");\n");
 	printk("                               lock(");
-	__print_lock_name(middle_class);
+	__print_lock_name(NULL, middle_class);
 	printk(KERN_CONT ");\n");
 	printk("  <Interrupt>\n");
 	printk("    lock(");
-	__print_lock_name(safe_class);
+	__print_lock_name(NULL, safe_class);
 	printk(KERN_CONT ");\n");
 	printk("\n *** DEADLOCK ***\n\n");
 }
@@ -2577,20 +2579,20 @@ print_bad_irq_dependency(struct task_struct *curr,
 	pr_warn("\nand this task is already holding:\n");
 	print_lock(prev);
 	pr_warn("which would create a new lock dependency:\n");
-	print_lock_name(hlock_class(prev));
+	print_lock_name(prev, hlock_class(prev));
 	pr_cont(" ->");
-	print_lock_name(hlock_class(next));
+	print_lock_name(next, hlock_class(next));
 	pr_cont("\n");
 
 	pr_warn("\nbut this new dependency connects a %s-irq-safe lock:\n",
 		irqclass);
-	print_lock_name(backwards_entry->class);
+	print_lock_name(NULL, backwards_entry->class);
 	pr_warn("\n... which became %s-irq-safe at:\n", irqclass);
 
 	print_lock_trace(backwards_entry->class->usage_traces[bit1], 1);
 
 	pr_warn("\nto a %s-irq-unsafe lock:\n", irqclass);
-	print_lock_name(forwards_entry->class);
+	print_lock_name(NULL, forwards_entry->class);
 	pr_warn("\n... which became %s-irq-unsafe at:\n", irqclass);
 	pr_warn("...");
 
@@ -2960,10 +2962,10 @@ print_deadlock_scenario(struct held_lock *nxt, struct held_lock *prv)
 	printk("       CPU0\n");
 	printk("       ----\n");
 	printk("  lock(");
-	__print_lock_name(prev);
+	__print_lock_name(prv, prev);
 	printk(KERN_CONT ");\n");
 	printk("  lock(");
-	__print_lock_name(next);
+	__print_lock_name(nxt, next);
 	printk(KERN_CONT ");\n");
 	printk("\n *** DEADLOCK ***\n\n");
 	printk(" May be due to missing lock nesting notation\n\n");
@@ -3943,11 +3945,11 @@ static void print_usage_bug_scenario(struct held_lock *lock)
 	printk("       CPU0\n");
 	printk("       ----\n");
 	printk("  lock(");
-	__print_lock_name(class);
+	__print_lock_name(lock, class);
 	printk(KERN_CONT ");\n");
 	printk("  <Interrupt>\n");
 	printk("    lock(");
-	__print_lock_name(class);
+	__print_lock_name(lock, class);
 	printk(KERN_CONT ");\n");
 	printk("\n *** DEADLOCK ***\n\n");
 }
@@ -4033,7 +4035,7 @@ print_irq_inversion_bug(struct task_struct *curr,
 		pr_warn("but this lock took another, %s-unsafe lock in the past:\n", irqclass);
 	else
 		pr_warn("but this lock was taken by another, %s-safe lock in the past:\n", irqclass);
-	print_lock_name(other->class);
+	print_lock_name(NULL, other->class);
 	pr_warn("\n\nand interrupts could create inverse lock ordering between them.\n\n");
 
 	pr_warn("\nother info that might help us debug this:\n");
@@ -6645,4 +6647,25 @@ void lockdep_set_lock_cmp_fn(struct lockdep_map *lock, lock_cmp_fn fn)
 	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(lockdep_set_lock_cmp_fn);
+
+void lockdep_set_lock_print_fn(struct lockdep_map *lock, lock_print_fn fn)
+{
+	struct lock_class *class = lock->class_cache[0];
+	unsigned long flags;
+
+	raw_local_irq_save(flags);
+	lockdep_recursion_inc();
+
+	if (!class)
+		class = register_lock_class(lock, 0, 0);
+
+	WARN_ON(class && class->print_fn && class->print_fn != fn);
+
+	if (class)
+		class->print_fn = fn;
+
+	lockdep_recursion_finish();
+	raw_local_irq_restore(flags);
+}
+EXPORT_SYMBOL_GPL(lockdep_set_lock_print_fn);
 #endif
-- 
2.39.2


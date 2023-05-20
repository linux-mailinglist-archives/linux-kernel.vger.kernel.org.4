Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996AB70A74C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 12:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjETKtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 06:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjETKtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 06:49:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227B7E58;
        Sat, 20 May 2023 03:49:08 -0700 (PDT)
Date:   Sat, 20 May 2023 10:49:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684579746;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1/9zl06jXnRv4WDqX67AZnJzzgZhrqNYjGH53lKPrWk=;
        b=CjALqgx0QIk2kv4xUQzEX26vRzruqeIBry/0BpE9VceEgHqBPZS7JJeAg38KwCPe3mWkJE
        mZ+6wnPaJWEivJYgTouElezHHI3lmSN2rkmD0O/XfZP2jldwGw+9oAzqBdmDkP7EejQK0D
        n/NqO4t3oDx9LUWzV0Dira1AnJ6c1N1O56y7b5x5T0zBnnjZr0yeB18AcpyABeU4INehgj
        WNJ9teg280ETI4hS0nQThbU6iJQG87ueAGhE7r1V3PT6O62F0lP9VBDbfw3k1wDrNQ3UwU
        fbwxDSW11KUHuRXSoWNi3c2AuvzhOHCA6ZkeggsIdxGztpyXW6jM2cvFzcGyCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684579746;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1/9zl06jXnRv4WDqX67AZnJzzgZhrqNYjGH53lKPrWk=;
        b=wiCccgBc33U8usUH4DcBh8ZvzW2kBAgRtbOzW9CQ7zc+MYKZnP5kE0yTNLZt+UtHhsqUE7
        vjwdupDN71vl3IAg==
From:   "tip-bot2 for Kent Overstreet" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep: Add lock_set_cmp_fn() annotation
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230509195847.1745548-1-kent.overstreet@linux.dev>
References: <20230509195847.1745548-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Message-ID: <168457974623.404.2660925434350085745.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     eb1cfd09f788e39948a82be8063e54e40dd018d9
Gitweb:        https://git.kernel.org/tip/eb1cfd09f788e39948a82be8063e54e40dd018d9
Author:        Kent Overstreet <kent.overstreet@linux.dev>
AuthorDate:    Tue, 09 May 2023 15:58:46 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 19 May 2023 12:35:10 +02:00

lockdep: Add lock_set_cmp_fn() annotation

This implements a new interface to lockdep, lock_set_cmp_fn(), for
defining a custom ordering when taking multiple locks of the same
class.

This is an alternative to subclasses, but can not fully replace them
since subclasses allow lock hierarchies with other clasees
inter-twined, while this relies on pure class nesting.

Specifically, if A is our nesting class then:

  A/0 <- B <- A/1

Would be a valid lock order with subclasses (each subclass really is a
full class from the validation PoV) but not with this annotation,
which requires all nesting to be consecutive.

Example output:

| ============================================
| WARNING: possible recursive locking detected
| 6.2.0-rc8-00003-g7d81e591ca6a-dirty #15 Not tainted
| --------------------------------------------
| kworker/14:3/938 is trying to acquire lock:
| ffff8880143218c8 (&b->lock l=0 0:2803368){++++}-{3:3}, at: bch_btree_node_get.part.0+0x81/0x2b0
|
| but task is already holding lock:
| ffff8880143de8c8 (&b->lock l=1 1048575:9223372036854775807){++++}-{3:3}, at: __bch_btree_map_nodes+0xea/0x1e0
| and the lock comparison function returns 1:
|
| other info that might help us debug this:
|  Possible unsafe locking scenario:
|
|        CPU0
|        ----
|   lock(&b->lock l=1 1048575:9223372036854775807);
|   lock(&b->lock l=0 0:2803368);
|
|  *** DEADLOCK ***
|
|  May be due to missing lock nesting notation
|
| 3 locks held by kworker/14:3/938:
|  #0: ffff888005ea9d38 ((wq_completion)bcache){+.+.}-{0:0}, at: process_one_work+0x1ec/0x530
|  #1: ffff8880098c3e70 ((work_completion)(&cl->work)#3){+.+.}-{0:0}, at: process_one_work+0x1ec/0x530
|  #2: ffff8880143de8c8 (&b->lock l=1 1048575:9223372036854775807){++++}-{3:3}, at: __bch_btree_map_nodes+0xea/0x1e0

[peterz: extended changelog]
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230509195847.1745548-1-kent.overstreet@linux.dev
---
 include/linux/lockdep.h       |   8 ++-
 include/linux/lockdep_types.h |   8 ++-
 kernel/locking/lockdep.c      | 118 ++++++++++++++++++++++++---------
 3 files changed, 103 insertions(+), 31 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index b32256e..3bac150 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -434,6 +434,14 @@ extern int lockdep_is_held(const void *);
 
 #endif /* !LOCKDEP */
 
+#ifdef CONFIG_PROVE_LOCKING
+void lockdep_set_lock_cmp_fn(struct lockdep_map *, lock_cmp_fn, lock_print_fn);
+
+#define lock_set_cmp_fn(lock, ...)	lockdep_set_lock_cmp_fn(&(lock)->dep_map, __VA_ARGS__)
+#else
+#define lock_set_cmp_fn(lock, ...)	do { } while (0)
+#endif
+
 enum xhlock_context_t {
 	XHLOCK_HARD,
 	XHLOCK_SOFT,
diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
index d224308..8bf79c4 100644
--- a/include/linux/lockdep_types.h
+++ b/include/linux/lockdep_types.h
@@ -84,6 +84,11 @@ struct lock_trace;
 
 #define LOCKSTAT_POINTS		4
 
+struct lockdep_map;
+typedef int (*lock_cmp_fn)(const struct lockdep_map *a,
+			   const struct lockdep_map *b);
+typedef void (*lock_print_fn)(const struct lockdep_map *map);
+
 /*
  * The lock-class itself. The order of the structure members matters.
  * reinit_class() zeroes the key member and all subsequent members.
@@ -109,6 +114,9 @@ struct lock_class {
 	struct list_head		locks_after, locks_before;
 
 	const struct lockdep_subclass_key *key;
+	lock_cmp_fn			cmp_fn;
+	lock_print_fn			print_fn;
+
 	unsigned int			subclass;
 	unsigned int			dep_gen_id;
 
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index dcd1d5b..3e8950f 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -709,7 +709,7 @@ void get_usage_chars(struct lock_class *class, char usage[LOCK_USAGE_CHARS])
 	usage[i] = '\0';
 }
 
-static void __print_lock_name(struct lock_class *class)
+static void __print_lock_name(struct held_lock *hlock, struct lock_class *class)
 {
 	char str[KSYM_NAME_LEN];
 	const char *name;
@@ -724,17 +724,19 @@ static void __print_lock_name(struct lock_class *class)
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
@@ -772,7 +774,7 @@ static void print_lock(struct held_lock *hlock)
 	}
 
 	printk(KERN_CONT "%px", hlock->instance);
-	print_lock_name(lock);
+	print_lock_name(hlock, lock);
 	printk(KERN_CONT ", at: %pS\n", (void *)hlock->acquire_ip);
 }
 
@@ -1868,7 +1870,7 @@ print_circular_bug_entry(struct lock_list *target, int depth)
 	if (debug_locks_silent)
 		return;
 	printk("\n-> #%u", depth);
-	print_lock_name(target->class);
+	print_lock_name(NULL, target->class);
 	printk(KERN_CONT ":\n");
 	print_lock_trace(target->trace, 6);
 }
@@ -1899,11 +1901,11 @@ print_circular_lock_scenario(struct held_lock *src,
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
 
@@ -1914,13 +1916,13 @@ print_circular_lock_scenario(struct held_lock *src,
 		printk("  rlock(");
 	else
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
 	if (src_read != 0)
 		printk("  rlock(");
@@ -1928,7 +1930,7 @@ print_circular_lock_scenario(struct held_lock *src,
 		printk("  sync(");
 	else
 		printk("  lock(");
-	__print_lock_name(source);
+	__print_lock_name(src, source);
 	printk(KERN_CONT ");\n");
 	printk("\n *** DEADLOCK ***\n\n");
 }
@@ -2154,6 +2156,8 @@ check_path(struct held_lock *target, struct lock_list *src_entry,
 	return ret;
 }
 
+static void print_deadlock_bug(struct task_struct *, struct held_lock *, struct held_lock *);
+
 /*
  * Prove that the dependency graph starting at <src> can not
  * lead to <target>. If it can, there is a circle when adding
@@ -2185,7 +2189,10 @@ check_noncircular(struct held_lock *src, struct held_lock *target,
 			*trace = save_trace();
 		}
 
-		print_circular_bug(&src_entry, target_entry, src, target);
+		if (src->class_idx == target->class_idx)
+			print_deadlock_bug(current, src, target);
+		else
+			print_circular_bug(&src_entry, target_entry, src, target);
 	}
 
 	return ret;
@@ -2341,7 +2348,7 @@ static void print_lock_class_header(struct lock_class *class, int depth)
 	int bit;
 
 	printk("%*s->", depth, "");
-	print_lock_name(class);
+	print_lock_name(NULL, class);
 #ifdef CONFIG_DEBUG_LOCKDEP
 	printk(KERN_CONT " ops: %lu", debug_class_ops_read(class));
 #endif
@@ -2523,11 +2530,11 @@ print_irq_lock_scenario(struct lock_list *safe_entry,
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
 
@@ -2535,18 +2542,18 @@ print_irq_lock_scenario(struct lock_list *safe_entry,
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
@@ -2583,20 +2590,20 @@ print_bad_irq_dependency(struct task_struct *curr,
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
 
@@ -2966,10 +2973,10 @@ print_deadlock_scenario(struct held_lock *nxt, struct held_lock *prv)
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
@@ -2979,6 +2986,8 @@ static void
 print_deadlock_bug(struct task_struct *curr, struct held_lock *prev,
 		   struct held_lock *next)
 {
+	struct lock_class *class = hlock_class(prev);
+
 	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
 		return;
 
@@ -2993,6 +3002,11 @@ print_deadlock_bug(struct task_struct *curr, struct held_lock *prev,
 	pr_warn("\nbut task is already holding lock:\n");
 	print_lock(prev);
 
+	if (class->cmp_fn) {
+		pr_warn("and the lock comparison function returns %i:\n",
+			class->cmp_fn(prev->instance, next->instance));
+	}
+
 	pr_warn("\nother info that might help us debug this:\n");
 	print_deadlock_scenario(next, prev);
 	lockdep_print_held_locks(curr);
@@ -3014,6 +3028,7 @@ print_deadlock_bug(struct task_struct *curr, struct held_lock *prev,
 static int
 check_deadlock(struct task_struct *curr, struct held_lock *next)
 {
+	struct lock_class *class;
 	struct held_lock *prev;
 	struct held_lock *nest = NULL;
 	int i;
@@ -3034,6 +3049,12 @@ check_deadlock(struct task_struct *curr, struct held_lock *next)
 		if ((next->read == 2) && prev->read)
 			continue;
 
+		class = hlock_class(prev);
+
+		if (class->cmp_fn &&
+		    class->cmp_fn(prev->instance, next->instance) < 0)
+			continue;
+
 		/*
 		 * We're holding the nest_lock, which serializes this lock's
 		 * nesting behaviour.
@@ -3095,6 +3116,14 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 		return 2;
 	}
 
+	if (prev->class_idx == next->class_idx) {
+		struct lock_class *class = hlock_class(prev);
+
+		if (class->cmp_fn &&
+		    class->cmp_fn(prev->instance, next->instance) < 0)
+			return 2;
+	}
+
 	/*
 	 * Prove that the new <prev> -> <next> dependency would not
 	 * create a circular dependency in the graph. (We do this by
@@ -3571,7 +3600,7 @@ static void print_chain_keys_chain(struct lock_chain *chain)
 		hlock_id = chain_hlocks[chain->base + i];
 		chain_key = print_chain_key_iteration(hlock_id, chain_key);
 
-		print_lock_name(lock_classes + chain_hlock_class_idx(hlock_id));
+		print_lock_name(NULL, lock_classes + chain_hlock_class_idx(hlock_id));
 		printk("\n");
 	}
 }
@@ -3928,11 +3957,11 @@ static void print_usage_bug_scenario(struct held_lock *lock)
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
@@ -4018,7 +4047,7 @@ print_irq_inversion_bug(struct task_struct *curr,
 		pr_warn("but this lock took another, %s-unsafe lock in the past:\n", irqclass);
 	else
 		pr_warn("but this lock was taken by another, %s-safe lock in the past:\n", irqclass);
-	print_lock_name(other->class);
+	print_lock_name(NULL, other->class);
 	pr_warn("\n\nand interrupts could create inverse lock ordering between them.\n\n");
 
 	pr_warn("\nother info that might help us debug this:\n");
@@ -4882,6 +4911,33 @@ EXPORT_SYMBOL_GPL(lockdep_init_map_type);
 struct lock_class_key __lockdep_no_validate__;
 EXPORT_SYMBOL_GPL(__lockdep_no_validate__);
 
+#ifdef CONFIG_PROVE_LOCKING
+void lockdep_set_lock_cmp_fn(struct lockdep_map *lock, lock_cmp_fn cmp_fn,
+			     lock_print_fn print_fn)
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
+	if (class) {
+		WARN_ON(class->cmp_fn	&& class->cmp_fn != cmp_fn);
+		WARN_ON(class->print_fn && class->print_fn != print_fn);
+
+		class->cmp_fn	= cmp_fn;
+		class->print_fn = print_fn;
+	}
+
+	lockdep_recursion_finish();
+	raw_local_irq_restore(flags);
+}
+EXPORT_SYMBOL_GPL(lockdep_set_lock_cmp_fn);
+#endif
+
 static void
 print_lock_nested_lock_not_held(struct task_struct *curr,
 				struct held_lock *hlock)

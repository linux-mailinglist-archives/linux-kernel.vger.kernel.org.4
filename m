Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712116FCEEB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 21:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbjEIT7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 15:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjEIT67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 15:58:59 -0400
Received: from out-19.mta1.migadu.com (out-19.mta1.migadu.com [IPv6:2001:41d0:203:375::13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46253AA4
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 12:58:56 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683662335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sSkbXnNB+KLMFip+MRddc9Zf354Mwj7RA2ivSk+3EvU=;
        b=Z7muKt/dB0MJ53Gr9wUe0zqOP/zcnOIDTikac+qCInhumWEkiADRBGfSiddq5f9JIIxeYZ
        DFlJZJ/yNPHJ/9Fg5UvQ75Oub8xJdWf7RsDFq52FaEvXub2AZ3TUuEyU2BEkIOHeV44jEd
        87Zx44jviJWIz0lnqpcIhsn4If6lupM=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-kernel@vger.kernel.org, peterz@infradead.org
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH 1/2] lockdep: lock_set_cmp_fn()
Date:   Tue,  9 May 2023 15:58:46 -0400
Message-Id: <20230509195847.1745548-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This implements a new interface to lockedp, lock_set_cmp_fn(), for
defining an ordering when taking multiple locks of the same type.

This provides a more rigorous mechanism than the subclass mechanism -
it's hoped that this might be able to replace subclasses.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Peter Zijlstra <peterz@infradead.org> (maintainer:LOCKING PRIMITIVES)
Cc: Ingo Molnar <mingo@redhat.com> (maintainer:LOCKING PRIMITIVES)
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/lockdep.h       |   8 +++
 include/linux/lockdep_types.h |   8 +++
 kernel/locking/lockdep.c      | 115 +++++++++++++++++++++++++---------
 3 files changed, 101 insertions(+), 30 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 1023f349af..2b4497ee3d 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -379,6 +379,14 @@ static inline void lockdep_set_selftest_task(struct task_struct *task)
 		do { (void)(key); } while (0)
 #define lockdep_set_subclass(lock, sub)		do { } while (0)
 
+#ifdef CONFIG_PROVE_LOCKING
+void lockdep_set_lock_cmp_fn(struct lockdep_map *, lock_cmp_fn, lock_print_fn);
+
+#define lock_set_cmp_fn(lock, ...)	lockdep_set_lock_cmp_fn(&(lock)->dep_map, __VA_ARGS__)
+#else
+#define lock_set_cmp_fn(lock, ...)	do {} while (0)
+#endif
+
 #define lockdep_set_novalidate_class(lock) do { } while (0)
 
 /*
diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
index d22430840b..8bf79c4e48 100644
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
index 50d4863974..7b8c16cbef 100644
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
@@ -1897,11 +1899,11 @@ print_circular_lock_scenario(struct held_lock *src,
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
 
@@ -1909,16 +1911,16 @@ print_circular_lock_scenario(struct held_lock *src,
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
@@ -2144,6 +2146,8 @@ check_path(struct held_lock *target, struct lock_list *src_entry,
 	return ret;
 }
 
+static void print_deadlock_bug(struct task_struct *, struct held_lock *, struct held_lock *);
+
 /*
  * Prove that the dependency graph starting at <src> can not
  * lead to <target>. If it can, there is a circle when adding
@@ -2175,7 +2179,10 @@ check_noncircular(struct held_lock *src, struct held_lock *target,
 			*trace = save_trace();
 		}
 
-		print_circular_bug(&src_entry, target_entry, src, target);
+		if (src->class_idx == target->class_idx)
+			print_deadlock_bug(current, src, target);
+		else
+			print_circular_bug(&src_entry, target_entry, src, target);
 	}
 
 	return ret;
@@ -2331,7 +2338,7 @@ static void print_lock_class_header(struct lock_class *class, int depth)
 	int bit;
 
 	printk("%*s->", depth, "");
-	print_lock_name(class);
+	print_lock_name(NULL, class);
 #ifdef CONFIG_DEBUG_LOCKDEP
 	printk(KERN_CONT " ops: %lu", debug_class_ops_read(class));
 #endif
@@ -2513,11 +2520,11 @@ print_irq_lock_scenario(struct lock_list *safe_entry,
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
 
@@ -2525,18 +2532,18 @@ print_irq_lock_scenario(struct lock_list *safe_entry,
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
@@ -2573,20 +2580,20 @@ print_bad_irq_dependency(struct task_struct *curr,
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
 
@@ -2956,10 +2963,10 @@ print_deadlock_scenario(struct held_lock *nxt, struct held_lock *prv)
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
@@ -2969,6 +2976,8 @@ static void
 print_deadlock_bug(struct task_struct *curr, struct held_lock *prev,
 		   struct held_lock *next)
 {
+	struct lock_class *class = hlock_class(prev);
+
 	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
 		return;
 
@@ -2983,6 +2992,10 @@ print_deadlock_bug(struct task_struct *curr, struct held_lock *prev,
 	pr_warn("\nbut task is already holding lock:\n");
 	print_lock(prev);
 
+	if (class->cmp_fn)
+		pr_warn("and the lock comparison function returns %i:\n",
+			class->cmp_fn(prev->instance, next->instance));
+
 	pr_warn("\nother info that might help us debug this:\n");
 	print_deadlock_scenario(next, prev);
 	lockdep_print_held_locks(curr);
@@ -3004,6 +3017,7 @@ print_deadlock_bug(struct task_struct *curr, struct held_lock *prev,
 static int
 check_deadlock(struct task_struct *curr, struct held_lock *next)
 {
+	struct lock_class *class;
 	struct held_lock *prev;
 	struct held_lock *nest = NULL;
 	int i;
@@ -3024,6 +3038,12 @@ check_deadlock(struct task_struct *curr, struct held_lock *next)
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
@@ -3085,6 +3105,14 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
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
@@ -3918,11 +3946,11 @@ static void print_usage_bug_scenario(struct held_lock *lock)
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
@@ -4008,7 +4036,7 @@ print_irq_inversion_bug(struct task_struct *curr,
 		pr_warn("but this lock took another, %s-unsafe lock in the past:\n", irqclass);
 	else
 		pr_warn("but this lock was taken by another, %s-safe lock in the past:\n", irqclass);
-	print_lock_name(other->class);
+	print_lock_name(NULL, other->class);
 	pr_warn("\n\nand interrupts could create inverse lock ordering between them.\n\n");
 
 	pr_warn("\nother info that might help us debug this:\n");
@@ -4866,6 +4894,33 @@ EXPORT_SYMBOL_GPL(lockdep_init_map_type);
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
-- 
2.40.1


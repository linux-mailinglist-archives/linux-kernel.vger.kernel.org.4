Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D08F69B7E0
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 04:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjBRDVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 22:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjBRDV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 22:21:27 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77020298DF
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 19:21:26 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676690484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nBur8B6otvzIqKxJYbq/xB/Q4zP258Cl956+FrUe1wU=;
        b=Np2HLeTMum9s5kMIsaCytzZWnWXa354agyuuYq8HOcOwssHYq7ffmeFlmIXe7LG28pLgt/
        1i7wr2fu7Ld0TYVzK2x4jgZnsn2zp7wnRRQ/AIfy2g+8vs6pWmmcPbME+vC9RdqcNwPvOc
        s558Eon3K5GJnE7ECq763US17ICbEwA=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-kernel@vger.kernel.org, peterz@infradead.org
Cc:     Kent Overstreet <kent.overstreet@linux.dev>, mingo@redhat.com,
        stern@rowland.harvard.edu
Subject: [PATCH 1/2] lockdep: lock_set_lock_cmp_fn()
Date:   Fri, 17 Feb 2023 22:21:16 -0500
Message-Id: <20230218032117.2372071-2-kent.overstreet@linux.dev>
In-Reply-To: <20230218032117.2372071-1-kent.overstreet@linux.dev>
References: <20230218032117.2372071-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
---
 include/linux/lockdep.h       |  8 ++++++
 include/linux/lockdep_types.h |  6 +++++
 kernel/locking/lockdep.c      | 51 ++++++++++++++++++++++++++++++++++-
 3 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 1f1099dac3..a4673a6f7a 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -662,4 +662,12 @@ lockdep_rcu_suspicious(const char *file, const int line, const char *s)
 }
 #endif
 
+#ifdef CONFIG_PROVE_LOCKING
+void lockdep_set_lock_cmp_fn(struct lockdep_map *lock, lock_cmp_fn fn);
+
+#define lock_set_lock_cmp_fn(lock, fn)		lockdep_set_lock_cmp_fn(&(lock)->dep_map, fn)
+#else
+#define lock_set_lock_cmp_fn(lock, fn)		do {} while (0)
+#endif
+
 #endif /* __LINUX_LOCKDEP_H */
diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
index d22430840b..813467dccb 100644
--- a/include/linux/lockdep_types.h
+++ b/include/linux/lockdep_types.h
@@ -84,6 +84,10 @@ struct lock_trace;
 
 #define LOCKSTAT_POINTS		4
 
+struct lockdep_map;
+typedef int (*lock_cmp_fn)(const struct lockdep_map *a,
+			   const struct lockdep_map *b);
+
 /*
  * The lock-class itself. The order of the structure members matters.
  * reinit_class() zeroes the key member and all subsequent members.
@@ -109,6 +113,8 @@ struct lock_class {
 	struct list_head		locks_after, locks_before;
 
 	const struct lockdep_subclass_key *key;
+	lock_cmp_fn			cmp_fn;
+
 	unsigned int			subclass;
 	unsigned int			dep_gen_id;
 
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index e3375bc40d..b9e759743e 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2143,6 +2143,8 @@ check_path(struct held_lock *target, struct lock_list *src_entry,
 	return ret;
 }
 
+static void print_deadlock_bug(struct task_struct *, struct held_lock *, struct held_lock *);
+
 /*
  * Prove that the dependency graph starting at <src> can not
  * lead to <target>. If it can, there is a circle when adding
@@ -2174,7 +2176,10 @@ check_noncircular(struct held_lock *src, struct held_lock *target,
 			*trace = save_trace();
 		}
 
-		print_circular_bug(&src_entry, target_entry, src, target);
+		if (src->class_idx == target->class_idx)
+			print_deadlock_bug(current, src, target);
+		else
+			print_circular_bug(&src_entry, target_entry, src, target);
 	}
 
 	return ret;
@@ -2968,6 +2973,8 @@ static void
 print_deadlock_bug(struct task_struct *curr, struct held_lock *prev,
 		   struct held_lock *next)
 {
+	struct lock_class *class = hlock_class(prev);
+
 	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
 		return;
 
@@ -2982,6 +2989,10 @@ print_deadlock_bug(struct task_struct *curr, struct held_lock *prev,
 	pr_warn("\nbut task is already holding lock:\n");
 	print_lock(prev);
 
+	if (class->cmp_fn)
+		pr_warn("and the lock comparison function returns %i:\n",
+			class->cmp_fn(prev->instance, next->instance));
+
 	pr_warn("\nother info that might help us debug this:\n");
 	print_deadlock_scenario(next, prev);
 	lockdep_print_held_locks(curr);
@@ -3003,6 +3014,7 @@ print_deadlock_bug(struct task_struct *curr, struct held_lock *prev,
 static int
 check_deadlock(struct task_struct *curr, struct held_lock *next)
 {
+	struct lock_class *class;
 	struct held_lock *prev;
 	struct held_lock *nest = NULL;
 	int i;
@@ -3023,6 +3035,12 @@ check_deadlock(struct task_struct *curr, struct held_lock *next)
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
@@ -3084,6 +3102,14 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
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
@@ -6597,3 +6623,26 @@ void lockdep_rcu_suspicious(const char *file, const int line, const char *s)
 	dump_stack();
 }
 EXPORT_SYMBOL_GPL(lockdep_rcu_suspicious);
+
+#ifdef CONFIG_PROVE_LOCKING
+void lockdep_set_lock_cmp_fn(struct lockdep_map *lock, lock_cmp_fn fn)
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
+	WARN_ON(class && class->cmp_fn && class->cmp_fn != fn);
+
+	if (class)
+		class->cmp_fn = fn;
+
+	lockdep_recursion_finish();
+	raw_local_irq_restore(flags);
+}
+EXPORT_SYMBOL_GPL(lockdep_set_lock_cmp_fn);
+#endif
-- 
2.39.2


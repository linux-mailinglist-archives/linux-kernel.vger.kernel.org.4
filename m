Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E672370C411
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 19:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjEVRNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 13:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjEVRNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 13:13:36 -0400
Received: from out-28.mta1.migadu.com (out-28.mta1.migadu.com [IPv6:2001:41d0:203:375::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0CCB3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 10:13:31 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684775609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hrzI0JB6QMeA3II3WCjtzpfvkcWEK0Gq5209JkkQYOU=;
        b=j6fwAHoXarcFUuAWDHA9zZ4XC1y8dX+nNOnkwIHd4ER4dta9ex444DxKeM7Kn6mKG+F0op
        SNu49PwjAm9Zec2iEvQ4DvQ+DEIJBtfkVztS3dmyqyg8UbAa8AxNKUl+Oe4IaT/zr/NCJX
        c4/7VN0badoKLAkYzICtiY9dU0e7V50=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Brian Foster <bfoster@redhat.com>,
        Dave Chinner <dchinner@redhat.com>
Subject: [PATCH v2] locking: SIX locks (shared/intent/exclusive)
Date:   Mon, 22 May 2023 13:13:14 -0400
Message-Id: <20230522171314.1953699-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New lock for bcachefs, like read/write locks but with a third state,
intent.

Intent locks conflict with each other, but not with read locks; taking a
write lock requires first holding an intent lock.

------------------

The previously posted version was not up to date with the version in the
bcachefs tree at time of posting and was only the first patch in the
series - whoops. The changelog below will note what changes should have
been included with previous posting and what is new work since previous
posting - that starts at "six_lock_readers_add()", and "kill
six_lock_pcpu_(alloc|free)".

The previously mentioned percpu-reader mode lost wakeup _may_ be
resolved - I've had this patch series running in my CI all weekend with
an extra patch to enable percpu readear mode for all locks, and I
haven't seen it; no tests have been timing out. However, it was always
very specific about under what conditions it would trigger and was very
sporadic, so I'm not making any definitive claims yet.

Full version history at:
https://evilpiepirate.org/git/bcachefs.git/log/?h=six_locks

Changes since last version

 - Improve six_lock_count - now includes write count, also correctly
   counts intent_lock_recurse

 - Delete six_lock_pcpu_free_rcu()
   completely broken interface, it's not possible to safely add/remove
   rcu readers to a lock that's in use

 - Simplify wait lists

   This switches to a single list of waiters, instead of separate lists
   for read and intent, and switches write locks to also use the wait
   lists instead of being handled differently.

   Also, removal from the wait list is now done by the process waiting
   on the lock, not the process doing the wakeup. This is needed for the
   new deadlock cycle detector - we need tasks to stay on the waitlist
   until they've successfully acquired the lock.

 - six_lock_waiter()

   This allows passing in the wait list entry, which makes it possible
   for an upper layer to implement cycle detection for deadlock
   avoidance.

 - Add start_time to six_lock_waiter

   This adds a timestamp to six_lock_waiter, and also guarantees that
   timestamps on any given waitlist are monotonically increasing: this
   allows the graph traversal algorithm to use the timestamp as a loop
   cursor.

 - Enable lockdep

   Previously, bcachefs was using lockdep_novalidate_class because it
   wasn't possible for lockdep to check the ordering of its btree node six
   locks w.r.t. each other. However, with the either the
   lockdep_set_no_check_recursion() patch or nest_lock we can now enable
   lockdep checking.

 - Fix a lost wakeup

   There was a lost wakeup between a read unlock in percpu mode and a
   write lock. The unlock path unlocks, then executes a barrier, then
   checks for waiters; correspondingly, the lock side should set the wait
   bit and execute a barrier, then attempt to take the lock.

 - Wakeup now takes lock on behalf of waiter

   This brings back an important optimization to avoid touching the
   wait lists an extra time, while preserving the property that a thread
   is on a lock waitlist iff it is waiting - it is never removed from
   the waitlist until it has the lock. This guarantee is needed for the
   cycle detector in bcachefs.

 - Expose tracepoint IP

   This adds _ip variations of the various lock functions that allow an
   IP to be passed in, which is used by lockstat.

 - Improved optimistic spinning

   This adds a threshold for the maximum spin time, similar to the
   rwsem code, and a flag to the lock itself indicating when we've spun
   too long so other threads also refrain from spinning.

 - Lock contended tracepoints

   This adds calls to trace_contention_begin() and
   trace_contention_end().

 - Simplify six_lock_counts()

   replace open coding with call to pcpu_read_count()

NEW WORK SINCE LAST POSTING STARTS HERE:
----------------------------------------

 - six_lock_readers_add()

   This moves a helper out of the bcachefs code that shouldn't have been
   there, since it touches six lock internals.

 - Kill six_lock_pcpu_(alloc|free)

   six_lock_pcpu_alloc() is an unsafe interface: it's not safe to
   allocate or free the percpu reader count on an existing lock that's
   in use, the only safe time to allocate percpu readers is when the
   lock is first being initialized.

   This patch adds a flags parameter to six_lock_init(), and instead of
   six_lock_pcpu_free() we now expose six_lock_exit(), which does the
   same thing but is less likely to be misused.

 - Centralize setting of waiting bit

   Originally, the waiting bit was always set by trylock() on failure:
   however, it's now set by __six_lock_type_slowpath(), with wait_lock
   held - which is the more correct place to do it.

   That made setting the waiting bit in trylock redundant, so this patch
   deletes that.

 - Simplify dispatch

   Originally, we used inlining/flattening to cause the compiler to
   generate different versions of lock/trylock/relock/unlock for each
   lock type - read, intent, and write. This made the individual
   functions smaller and let the compiler eliminate table lookups:
   however, as the code has gotten more complicated these optimizations
   have gotten less worthwhile, and all the tricky inlining and
   dispatching made the code less readable.

   Text size: 11015 bytes -> 7467 bytes, and benchmarks show no loss of
   performance.

 - Kill six_lock_state union

   As suggested by Linus, this drops the six_lock_state union in favor
   of raw bitmasks.

   On the one hand, bitfields give more type-level structure to the
   code.  However, a significant amount of the code was working with
   six_lock_state as a u64/atomic64_t, and the conversions from the
   bitfields to the u64 were deemed a bit too out-there.

   More significantly, because bitfield order is poorly defined (#ifdef
   __LITTLE_ENDIAN_BITFIELD can be used, but is gross), incrementing the
   sequence number would overflow into the rest of the bitfield if the
   compiler didn't put the sequence number at the high end of the word.

   The new code is a bit saner when we're on an architecture without
   real atomic64_t support - all accesses to lock->state now go through
   atomic64_*() operations.

   On architectures with real atomic64_t support, we additionally use
   atomic bit ops for setting/clearing individual bits.

   Text size: 7467 bytes -> 4649 bytes - compilers still suck at
   bitfields.

 - Documentation, renaming

   - Expanded and revamped overview documentation in six.h, giving an
     overview of all features
   - docbook-comments for all external interfaces
   - Rename some functions for simplicity, i.e.
     six_lock_ip_type() -> six_lock_ip()

 - Improve spurious wakeup handling in pcpu reader mode

   Minor refactoring for consistency, significantly expand code comments

 - Split out seq, use atomic_t and kill dependency on atomic64_t

   The lock sequence number doesn't actually need to be part of the main
   lock state if we stop using it to track whether a write lock is held.

   We already have a bit in the rest of the lock state for "trying to
   acquire a write lock", so that writers are unfairly preferred over
   readers. This changes the meaning of that bit to "write lock being
   acquired or held", and incrementing the sequence number is now a
   separate, non atomic operation that happens just prior to a write
   unlock.

   This actually simplifies the implementation of relock(); it's now
   just "check sequence number; trylock(), recheck sequence number".

   And since the "write lock held" state now works like a counter not a
   sequence number - like read and intent - this gets us some other
   small cleanups/simplifications.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Brian Foster <bfoster@redhat.com>
Cc: Dave Chinner <dchinner@redhat.com>
---
 include/linux/six.h     | 388 +++++++++++++++++
 kernel/Kconfig.locks    |   3 +
 kernel/locking/Makefile |   1 +
 kernel/locking/six.c    | 929 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 1321 insertions(+)
 create mode 100644 include/linux/six.h
 create mode 100644 kernel/locking/six.c

diff --git a/include/linux/six.h b/include/linux/six.h
new file mode 100644
index 0000000000..394da423c2
--- /dev/null
+++ b/include/linux/six.h
@@ -0,0 +1,388 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LINUX_SIX_H
+#define _LINUX_SIX_H
+
+/**
+ * DOC: SIX locks overview
+ *
+ * Shared/intent/exclusive locks: sleepable read/write locks, like rw semaphores
+ * but with an additional state: read/shared, intent, exclusive/write
+ *
+ * The purpose of the intent state is to allow for greater concurrency on tree
+ * structures without deadlocking. In general, a read can't be upgraded to a
+ * write lock without deadlocking, so an operation that updates multiple nodes
+ * will have to take write locks for the full duration of the operation.
+ *
+ * But by adding an intent state, which is exclusive with other intent locks but
+ * not with readers, we can take intent locks at thte start of the operation,
+ * and then take write locks only for the actual update to each individual
+ * nodes, without deadlocking.
+ *
+ * Example usage:
+ *   six_lock_read(&foo->lock);
+ *   six_unlock_read(&foo->lock);
+ *
+ * An intent lock must be held before taking a write lock:
+ *   six_lock_intent(&foo->lock);
+ *   six_lock_write(&foo->lock);
+ *   six_unlock_write(&foo->lock);
+ *   six_unlock_intent(&foo->lock);
+ *
+ * Other operations:
+ *   six_trylock_read()
+ *   six_trylock_intent()
+ *   six_trylock_write()
+ *
+ *   six_lock_downgrade()	convert from intent to read
+ *   six_lock_tryupgrade()	attempt to convert from read to intent, may fail
+ *
+ * There are also interfaces that take the lock type as an enum:
+ *
+ *   six_lock_type(&foo->lock, SIX_LOCK_read);
+ *   six_trylock_convert(&foo->lock, SIX_LOCK_read, SIX_LOCK_intent)
+ *   six_lock_type(&foo->lock, SIX_LOCK_write);
+ *   six_unlock_type(&foo->lock, SIX_LOCK_write);
+ *   six_unlock_type(&foo->lock, SIX_LOCK_intent);
+ *
+ * Lock sequence numbers - unlock(), relock():
+ *
+ *   Locks embed sequences numbers, which are incremented on write lock/unlock.
+ *   This allows locks to be dropped and the retaken iff the state they protect
+ *   hasn't changed; this makes it much easier to avoid holding locks while e.g.
+ *   doing IO or allocating memory.
+ *
+ *   Example usage:
+ *     six_lock_read(&foo->lock);
+ *     u32 seq = six_lock_seq(&foo->lock);
+ *     six_unlock_read(&foo->lock);
+ *
+ *     some_operation_that_may_block();
+ *
+ *     if (six_relock_read(&foo->lock, seq)) { ... }
+ *
+ *   If the relock operation succeeds, it is as if the lock was never unlocked.
+ *
+ * Reentrancy:
+ *
+ *   Six locks are not by themselves reentrent, but have counters for both the
+ *   read and intent states that can be used to provide reentrency by an upper
+ *   layer that tracks held locks. If a lock is known to already be held in the
+ *   read or intent state, six_lock_increment() can be used to bump the "lock
+ *   held in this state" counter, increasing the number of unlock calls that
+ *   will be required to fully unlock it.
+ *
+ *   Example usage:
+ *     six_lock_read(&foo->lock);
+ *     six_lock_increment(&foo->lock, SIX_LOCK_read);
+ *     six_unlock_read(&foo->lock);
+ *     six_unlock_read(&foo->lock);
+ *   foo->lock is now fully unlocked.
+ *
+ *   Since the intent state supercedes read, it's legal to increment the read
+ *   counter when holding an intent lock, but not the reverse.
+ *
+ *   A lock may only be held once for write: six_lock_increment(.., SIX_LOCK_write)
+ *   is not legal.
+ *
+ * should_sleep_fn:
+ *
+ *   There is a six_lock() variant that takes a function pointer that is called
+ *   immediately prior to schedule() when blocking, and may return an error to
+ *   abort.
+ *
+ *   One possible use for this feature is when objects being locked are part of
+ *   a cache and may reused, and lock ordering is based on a property of the
+ *   object that will change when the object is reused - i.e. logical key order.
+ *
+ *   If looking up an object in the cache may race with object reuse, and lock
+ *   ordering is required to prevent deadlock, object reuse may change the
+ *   correct lock order for that object and cause a deadlock. should_sleep_fn
+ *   can be used to check if the object is still the object we want and avoid
+ *   this deadlock.
+ *
+ * Wait list entry interface:
+ *
+ *   There is a six_lock() variant, six_lock_waiter(), that takes a pointer to a
+ *   wait list entry. By embedding six_lock_waiter into another object, and by
+ *   traversing lock waitlists, it is then possible for an upper layer to
+ *   implement full cycle detection for deadlock avoidance.
+ *
+ *   should_sleep_fn should be used for invoking the cycle detector, walking the
+ *   graph of held locks to check for a deadlock. The upper layer must track
+ *   held locks for each thread, and each thread's held locks must be reachable
+ *   from its six_lock_waiter object.
+ *
+ *   six_lock_waiter() will add the wait object to the waitlist re-trying taking
+ *   the lock, and before calling should_sleep_fn, and the wait object will not
+ *   be removed from the waitlist until either the lock has been successfully
+ *   acquired, or we aborted because should_sleep_fn returned an error.
+ *
+ *   Also, six_lock_waiter contains a timestamp, and waiters on a waitlist will
+ *   have timestamps in strictly ascending order - this is so the timestamp can
+ *   be used as a cursor for lock graph traverse.
+ */
+
+#include <linux/lockdep.h>
+#include <linux/osq_lock.h>
+#include <linux/sched.h>
+#include <linux/types.h>
+
+enum six_lock_type {
+	SIX_LOCK_read,
+	SIX_LOCK_intent,
+	SIX_LOCK_write,
+};
+
+struct six_lock {
+	atomic_t		state;
+	u32			seq;
+	unsigned		intent_lock_recurse;
+	struct task_struct	*owner;
+	unsigned __percpu	*readers;
+	struct optimistic_spin_queue osq;
+	raw_spinlock_t		wait_lock;
+	struct list_head	wait_list;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map	dep_map;
+#endif
+};
+
+struct six_lock_waiter {
+	struct list_head	list;
+	struct task_struct	*task;
+	enum six_lock_type	lock_want;
+	bool			lock_acquired;
+	u64			start_time;
+};
+
+typedef int (*six_lock_should_sleep_fn)(struct six_lock *lock, void *);
+
+void six_lock_exit(struct six_lock *lock);
+
+enum six_lock_init_flags {
+	SIX_LOCK_INIT_PCPU	= 1U << 0,
+};
+
+void __six_lock_init(struct six_lock *lock, const char *name,
+		     struct lock_class_key *key, enum six_lock_init_flags flags);
+
+/**
+ * six_lock_init - initialize a six lock
+ * @lock:	lock to initialize
+ * @flags:	optional flags, i.e. SIX_LOCK_INIT_PCPU
+ */
+#define six_lock_init(lock, flags)					\
+do {									\
+	static struct lock_class_key __key;				\
+									\
+	__six_lock_init((lock), #lock, &__key, flags);			\
+} while (0)
+
+/**
+ * six_lock_seq - obtain current lock sequence number
+ * @lock:	six_lock to obtain sequence number for
+ *
+ * @lock should be held for read or intent, and not write
+ *
+ * By saving the lock sequence number, we can unlock @lock and then (typically
+ * after some blocking operation) attempt to relock it: the relock will succeed
+ * if the sequence number hasn't changed, meaning no write locks have been taken
+ * and state corresponding to what @lock protects is still valid.
+ */
+static inline u32 six_lock_seq(const struct six_lock *lock)
+{
+	return lock->seq;
+}
+
+bool six_trylock_ip(struct six_lock *lock, enum six_lock_type type, unsigned long ip);
+
+/**
+ * six_trylock_type - attempt to take a six lock without blocking
+ * @lock:	lock to take
+ * @type:	SIX_LOCK_read, SIX_LOCK_intent, or SIX_LOCK_write
+ *
+ * Return: true on success, false on failure.
+ */
+static inline bool six_trylock_type(struct six_lock *lock, enum six_lock_type type)
+{
+	return six_trylock_ip(lock, type, _THIS_IP_);
+}
+
+int six_lock_ip_waiter(struct six_lock *lock, enum six_lock_type type,
+		       struct six_lock_waiter *wait,
+		       six_lock_should_sleep_fn should_sleep_fn, void *p,
+		       unsigned long ip);
+
+/**
+ * six_lock_waiter - take a lock, with full waitlist interface
+ * @lock:	lock to take
+ * @type:	SIX_LOCK_read, SIX_LOCK_intent, or SIX_LOCK_write
+ * @wait:	pointer to wait object, which will be added to lock's waitlist
+ * @should_sleep_fn: callback run after adding to waitlist, immediately prior
+ *		to scheduling
+ * @p:		passed through to @should_sleep_fn
+ *
+ * This is a convenience wrapper around six_lock_ip_waiter(), see that function
+ * for full documentation.
+ *
+ * Return: 0 on success, or the return code from @should_sleep_fn on failure.
+ */
+static inline int six_lock_waiter(struct six_lock *lock, enum six_lock_type type,
+				  struct six_lock_waiter *wait,
+				  six_lock_should_sleep_fn should_sleep_fn, void *p)
+{
+	return six_lock_ip_waiter(lock, type, wait, should_sleep_fn, p, _THIS_IP_);
+}
+
+/**
+ * six_lock_ip - take a six lock lock
+ * @lock:	lock to take
+ * @type:	SIX_LOCK_read, SIX_LOCK_intent, or SIX_LOCK_write
+ * @should_sleep_fn: callback run after adding to waitlist, immediately prior
+ *		to scheduling
+ * @p:		passed through to @should_sleep_fn
+ * @ip:		ip parameter for lockdep/lockstat, i.e. _THIS_IP_
+ *
+ * Return: 0 on success, or the return code from @should_sleep_fn on failure.
+ */
+static inline int six_lock_ip(struct six_lock *lock, enum six_lock_type type,
+			      six_lock_should_sleep_fn should_sleep_fn, void *p,
+			      unsigned long ip)
+{
+	struct six_lock_waiter wait;
+
+	return six_lock_ip_waiter(lock, type, &wait, should_sleep_fn, p, ip);
+}
+
+/**
+ * six_lock_type - take a six lock lock
+ * @lock:	lock to take
+ * @type:	SIX_LOCK_read, SIX_LOCK_intent, or SIX_LOCK_write
+ * @should_sleep_fn: callback run after adding to waitlist, immediately prior
+ *		to scheduling
+ * @p:		passed through to @should_sleep_fn
+ *
+ * Return: 0 on success, or the return code from @should_sleep_fn on failure.
+ */
+static inline int six_lock_type(struct six_lock *lock, enum six_lock_type type,
+				six_lock_should_sleep_fn should_sleep_fn, void *p)
+{
+	struct six_lock_waiter wait;
+
+	return six_lock_ip_waiter(lock, type, &wait, should_sleep_fn, p, _THIS_IP_);
+}
+
+bool six_relock_ip(struct six_lock *lock, enum six_lock_type type,
+		   unsigned seq, unsigned long ip);
+
+/**
+ * six_relock_type - attempt to re-take a lock that was held previously
+ * @lock:	lock to take
+ * @type:	SIX_LOCK_read, SIX_LOCK_intent, or SIX_LOCK_write
+ * @seq:	lock sequence number obtained from six_lock_seq() while lock was
+ *		held previously
+ *
+ * Return: true on success, false on failure.
+ */
+static inline bool six_relock_type(struct six_lock *lock, enum six_lock_type type,
+				   unsigned seq)
+{
+	return six_relock_ip(lock, type, seq, _THIS_IP_);
+}
+
+void six_unlock_ip(struct six_lock *lock, enum six_lock_type type, unsigned long ip);
+
+/**
+ * six_unlock_type - drop a six lock
+ * @lock:	lock to unlock
+ * @type:	SIX_LOCK_read, SIX_LOCK_intent, or SIX_LOCK_write
+ *
+ * When a lock is held multiple times (because six_lock_incement()) was used),
+ * this decrements the 'lock held' counter by one.
+ *
+ * For example:
+ * six_lock_read(&foo->lock);				read count 1
+ * six_lock_increment(&foo->lock, SIX_LOCK_read);	read count 2
+ * six_lock_unlock(&foo->lock, SIX_LOCK_read);		read count 1
+ * six_lock_unlock(&foo->lock, SIX_LOCK_read);		read count 0
+ */
+static inline void six_unlock_type(struct six_lock *lock, enum six_lock_type type)
+{
+	six_unlock_ip(lock, type, _THIS_IP_);
+}
+
+#define __SIX_LOCK(type)						\
+static inline bool six_trylock_ip_##type(struct six_lock *lock, unsigned long ip)\
+{									\
+	return six_trylock_ip(lock, SIX_LOCK_##type, ip);		\
+}									\
+									\
+static inline bool six_trylock_##type(struct six_lock *lock)		\
+{									\
+	return six_trylock_ip(lock, SIX_LOCK_##type, _THIS_IP_);	\
+}									\
+									\
+static inline int six_lock_ip_waiter_##type(struct six_lock *lock,	\
+			   struct six_lock_waiter *wait,		\
+			   six_lock_should_sleep_fn should_sleep_fn, void *p,\
+			   unsigned long ip)				\
+{									\
+	return six_lock_ip_waiter(lock, SIX_LOCK_##type, wait, should_sleep_fn, p, ip);\
+}									\
+									\
+static inline int six_lock_ip_##type(struct six_lock *lock,		\
+		    six_lock_should_sleep_fn should_sleep_fn, void *p,	\
+		    unsigned long ip)					\
+{									\
+	return six_lock_ip(lock, SIX_LOCK_##type, should_sleep_fn, p, ip);\
+}									\
+									\
+static inline bool six_relock_ip_##type(struct six_lock *lock, u32 seq, unsigned long ip)\
+{									\
+	return six_relock_ip(lock, SIX_LOCK_##type, seq, ip);		\
+}									\
+									\
+static inline bool six_relock_##type(struct six_lock *lock, u32 seq)	\
+{									\
+	return six_relock_ip(lock, SIX_LOCK_##type, seq, _THIS_IP_);	\
+}									\
+									\
+static inline int six_lock_##type(struct six_lock *lock,		\
+				  six_lock_should_sleep_fn fn, void *p)\
+{									\
+	return six_lock_ip_##type(lock, fn, p, _THIS_IP_);		\
+}									\
+									\
+static inline void six_unlock_ip_##type(struct six_lock *lock, unsigned long ip)	\
+{									\
+	six_unlock_ip(lock, SIX_LOCK_##type, ip);			\
+}									\
+									\
+static inline void six_unlock_##type(struct six_lock *lock)		\
+{									\
+	six_unlock_ip(lock, SIX_LOCK_##type, _THIS_IP_);		\
+}
+
+__SIX_LOCK(read)
+__SIX_LOCK(intent)
+__SIX_LOCK(write)
+#undef __SIX_LOCK
+
+void six_lock_downgrade(struct six_lock *);
+bool six_lock_tryupgrade(struct six_lock *);
+bool six_trylock_convert(struct six_lock *, enum six_lock_type,
+			 enum six_lock_type);
+
+void six_lock_increment(struct six_lock *, enum six_lock_type);
+
+void six_lock_wakeup_all(struct six_lock *);
+
+struct six_lock_count {
+	unsigned n[3];
+};
+
+struct six_lock_count six_lock_counts(struct six_lock *);
+void six_lock_readers_add(struct six_lock *, int);
+
+#endif /* _LINUX_SIX_H */
diff --git a/kernel/Kconfig.locks b/kernel/Kconfig.locks
index 4198f0273e..b2abd9a5d9 100644
--- a/kernel/Kconfig.locks
+++ b/kernel/Kconfig.locks
@@ -259,3 +259,6 @@ config ARCH_HAS_MMIOWB
 config MMIOWB
 	def_bool y if ARCH_HAS_MMIOWB
 	depends on SMP
+
+config SIXLOCKS
+	bool
diff --git a/kernel/locking/Makefile b/kernel/locking/Makefile
index 0db4093d17..a095dbbf01 100644
--- a/kernel/locking/Makefile
+++ b/kernel/locking/Makefile
@@ -32,3 +32,4 @@ obj-$(CONFIG_QUEUED_RWLOCKS) += qrwlock.o
 obj-$(CONFIG_LOCK_TORTURE_TEST) += locktorture.o
 obj-$(CONFIG_WW_MUTEX_SELFTEST) += test-ww_mutex.o
 obj-$(CONFIG_LOCK_EVENT_COUNTS) += lock_events.o
+obj-$(CONFIG_SIXLOCKS) += six.o
diff --git a/kernel/locking/six.c b/kernel/locking/six.c
new file mode 100644
index 0000000000..2cedff9c75
--- /dev/null
+++ b/kernel/locking/six.c
@@ -0,0 +1,929 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/export.h>
+#include <linux/log2.h>
+#include <linux/percpu.h>
+#include <linux/preempt.h>
+#include <linux/rcupdate.h>
+#include <linux/sched.h>
+#include <linux/sched/clock.h>
+#include <linux/sched/rt.h>
+#include <linux/six.h>
+#include <linux/slab.h>
+
+#include <trace/events/lock.h>
+
+#ifdef DEBUG
+#define EBUG_ON(cond)			BUG_ON(cond)
+#else
+#define EBUG_ON(cond)			do {} while (0)
+#endif
+
+#define six_acquire(l, t, r, ip)	lock_acquire(l, 0, t, r, 1, NULL, ip)
+#define six_release(l, ip)		lock_release(l, ip)
+
+static void do_six_unlock_type(struct six_lock *lock, enum six_lock_type type);
+
+/*
+ * bits 0-26		reader count
+ * bits 26-27		write_locking (a thread is trying to get a write lock,
+ *			but does not have one yet)
+ * bits 27-28		held for intent
+ * bits 28-29		nospin - optimistic spinning has timed out
+ * bits 29-30		has read waiters
+ * bits 30-31		has intent waiters
+ * bits 31-32		has write waiters
+ */
+
+#define SIX_LOCK_HELD_read_OFFSET	0
+#define SIX_LOCK_HELD_read		~(~0U << 26)
+#define SIX_LOCK_HELD_intent		(1U << 26)
+#define SIX_LOCK_HELD_write		(1U << 27)
+#define SIX_LOCK_WAITING_read		(1U << (28 + SIX_LOCK_read))
+#define SIX_LOCK_WAITING_intent		(1U << (28 + SIX_LOCK_intent))
+#define SIX_LOCK_WAITING_write		(1U << (28 + SIX_LOCK_write))
+#define SIX_LOCK_NOSPIN			(1U << 31)
+
+struct six_lock_vals {
+	/* Value we add to the lock in order to take the lock: */
+	u32			lock_val;
+
+	/* If the lock has this value (used as a mask), taking the lock fails: */
+	u32			lock_fail;
+
+	/* Mask that indicates lock is held for this type: */
+	u32			held_mask;
+
+	/* Waitlist we wakeup when releasing the lock: */
+	enum six_lock_type	unlock_wakeup;
+};
+
+#define LOCK_VALS {							\
+	[SIX_LOCK_read] = {						\
+		.lock_val	= 1U << SIX_LOCK_HELD_read_OFFSET,	\
+		.lock_fail	= SIX_LOCK_HELD_write,			\
+		.held_mask	= SIX_LOCK_HELD_read,			\
+		.unlock_wakeup	= SIX_LOCK_write,			\
+	},								\
+	[SIX_LOCK_intent] = {						\
+		.lock_val	= SIX_LOCK_HELD_intent,			\
+		.lock_fail	= SIX_LOCK_HELD_intent,			\
+		.held_mask	= SIX_LOCK_HELD_intent,			\
+		.unlock_wakeup	= SIX_LOCK_intent,			\
+	},								\
+	[SIX_LOCK_write] = {						\
+		.lock_val	= SIX_LOCK_HELD_write,			\
+		.lock_fail	= SIX_LOCK_HELD_read,			\
+		.held_mask	= SIX_LOCK_HELD_write,			\
+		.unlock_wakeup	= SIX_LOCK_read,			\
+	},								\
+}
+
+/*
+ * Returns the index of the first set bit, treating @mask as an array of ulongs:
+ * that is, a bit index that can be passed to test_bit()/set_bit().
+ *
+ * Assumes the set bit we want is in the low 4 bytes:
+ */
+static inline unsigned u32_mask_to_ulong_bitnr(u32 mask)
+{
+	union ulong_u32 {
+		u32	v32;
+		ulong	vlong;
+	} v = { .v32 = mask };
+
+	return ilog2(v.vlong);
+}
+
+static inline void six_set_bitmask(struct six_lock *lock, u32 mask)
+{
+	unsigned bitnr = u32_mask_to_ulong_bitnr(mask);
+
+	if (!test_bit(bitnr, (unsigned long *) &lock->state))
+		set_bit(bitnr, (unsigned long *) &lock->state);
+}
+
+static inline void six_clear_bitmask(struct six_lock *lock, u32 mask)
+{
+	unsigned bitnr = u32_mask_to_ulong_bitnr(mask);
+
+	if (test_bit(bitnr, (unsigned long *) &lock->state))
+		clear_bit(bitnr, (unsigned long *) &lock->state);
+}
+
+static inline void six_set_owner(struct six_lock *lock, enum six_lock_type type,
+				 u32 old, struct task_struct *owner)
+{
+	if (type != SIX_LOCK_intent)
+		return;
+
+	if (!(old & SIX_LOCK_HELD_intent)) {
+		EBUG_ON(lock->owner);
+		lock->owner = owner;
+	} else {
+		EBUG_ON(lock->owner != current);
+	}
+}
+
+static inline unsigned pcpu_read_count(struct six_lock *lock)
+{
+	unsigned read_count = 0;
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		read_count += *per_cpu_ptr(lock->readers, cpu);
+	return read_count;
+}
+
+/*
+ * __do_six_trylock() - main trylock routine
+ *
+ * Returns 1 on success, 0 on failure
+ *
+ * In percpu reader mode, a failed trylock may cause a spurious trylock failure
+ * for anoter thread taking the competing lock type, and we may havve to do a
+ * wakeup: when a wakeup is required, we return -1 - wakeup_type.
+ */
+static int __do_six_trylock(struct six_lock *lock, enum six_lock_type type,
+			    struct task_struct *task, bool try)
+{
+	const struct six_lock_vals l[] = LOCK_VALS;
+	int ret;
+	u32 old, new, v;
+
+	EBUG_ON(type == SIX_LOCK_write && lock->owner != task);
+	EBUG_ON(type == SIX_LOCK_write &&
+		(try != !(atomic_read(&lock->state) & SIX_LOCK_HELD_write)));
+
+	/*
+	 * Percpu reader mode:
+	 *
+	 * The basic idea behind this algorithm is that you can implement a lock
+	 * between two threads without any atomics, just memory barriers:
+	 *
+	 * For two threads you'll need two variables, one variable for "thread a
+	 * has the lock" and another for "thread b has the lock".
+	 *
+	 * To take the lock, a thread sets its variable indicating that it holds
+	 * the lock, then issues a full memory barrier, then reads from the
+	 * other thread's variable to check if the other thread thinks it has
+	 * the lock. If we raced, we backoff and retry/sleep.
+	 *
+	 * Failure to take the lock may cause a spurious trylock failure in
+	 * another thread, because we temporarily set the lock to indicate that
+	 * we held it. This would be a problem for a thread in six_lock(), when
+	 * they are calling trylock after adding themself to the waitlist and
+	 * prior to sleeping.
+	 *
+	 * Therefore, if we fail to get the lock, and there were waiters of the
+	 * type we conflict with, we will have to issue a wakeup.
+	 *
+	 * Since we may be called under wait_lock (and by the wakeup code
+	 * itself), we return that the wakeup has to be done instead of doing it
+	 * here.
+	 */
+	if (type == SIX_LOCK_read && lock->readers) {
+		preempt_disable();
+		this_cpu_inc(*lock->readers); /* signal that we own lock */
+
+		smp_mb();
+
+		old = atomic_read(&lock->state);
+		ret = !(old & l[type].lock_fail);
+
+		this_cpu_sub(*lock->readers, !ret);
+		preempt_enable();
+
+		if (!ret && (old & SIX_LOCK_WAITING_write))
+			ret = -1 - SIX_LOCK_write;
+	} else if (type == SIX_LOCK_write && lock->readers) {
+		if (try) {
+			atomic_add(SIX_LOCK_HELD_write, &lock->state);
+			smp_mb__after_atomic();
+		}
+
+		ret = !pcpu_read_count(lock);
+
+		if (try && !ret) {
+			old = atomic_sub_return(SIX_LOCK_HELD_write, &lock->state);
+			if (old & SIX_LOCK_WAITING_read)
+				ret = -1 - SIX_LOCK_read;
+		}
+	} else {
+		v = atomic_read(&lock->state);
+		do {
+			new = old = v;
+
+			ret = !(old & l[type].lock_fail);
+
+			if (!ret || (type == SIX_LOCK_write && !try)) {
+				smp_mb();
+				break;
+			}
+
+			new += l[type].lock_val;
+		} while ((v = atomic_cmpxchg_acquire(&lock->state, old, new)) != old);
+
+		EBUG_ON(ret && !(atomic_read(&lock->state) & l[type].held_mask));
+	}
+
+	if (ret > 0)
+		six_set_owner(lock, type, old, task);
+
+	EBUG_ON(type == SIX_LOCK_write && try && ret <= 0 &&
+		(atomic_read(&lock->state) & SIX_LOCK_HELD_write));
+
+	return ret;
+}
+
+static void __six_lock_wakeup(struct six_lock *lock, enum six_lock_type lock_type)
+{
+	struct six_lock_waiter *w, *next;
+	struct task_struct *task;
+	bool saw_one;
+	int ret;
+again:
+	ret = 0;
+	saw_one = false;
+	raw_spin_lock(&lock->wait_lock);
+
+	list_for_each_entry_safe(w, next, &lock->wait_list, list) {
+		if (w->lock_want != lock_type)
+			continue;
+
+		if (saw_one && lock_type != SIX_LOCK_read)
+			goto unlock;
+		saw_one = true;
+
+		ret = __do_six_trylock(lock, lock_type, w->task, false);
+		if (ret <= 0)
+			goto unlock;
+
+		__list_del(w->list.prev, w->list.next);
+		task = w->task;
+		/*
+		 * Do no writes to @w besides setting lock_acquired - otherwise
+		 * we would need a memory barrier:
+		 */
+		barrier();
+		w->lock_acquired = true;
+		wake_up_process(task);
+	}
+
+	six_clear_bitmask(lock, SIX_LOCK_WAITING_read << lock_type);
+unlock:
+	raw_spin_unlock(&lock->wait_lock);
+
+	if (ret < 0) {
+		lock_type = -ret - 1;
+		goto again;
+	}
+}
+
+__always_inline
+static void six_lock_wakeup(struct six_lock *lock, u32 state,
+			    enum six_lock_type lock_type)
+{
+	if (lock_type == SIX_LOCK_write && (state & SIX_LOCK_HELD_read))
+		return;
+
+	if (!(state & (SIX_LOCK_WAITING_read << lock_type)))
+		return;
+
+	__six_lock_wakeup(lock, lock_type);
+}
+
+__always_inline
+static bool do_six_trylock(struct six_lock *lock, enum six_lock_type type, bool try)
+{
+	int ret;
+
+	ret = __do_six_trylock(lock, type, current, try);
+	if (ret < 0)
+		__six_lock_wakeup(lock, -ret - 1);
+
+	return ret > 0;
+}
+
+/**
+ * six_trylock_ip - attempt to take a six lock without blocking
+ * @lock:	lock to take
+ * @type:	SIX_LOCK_read, SIX_LOCK_intent, or SIX_LOCK_write
+ * @ip:		ip parameter for lockdep/lockstat, i.e. _THIS_IP_
+ *
+ * Return: true on success, false on failure.
+ */
+bool six_trylock_ip(struct six_lock *lock, enum six_lock_type type, unsigned long ip)
+{
+	if (!do_six_trylock(lock, type, true))
+		return false;
+
+	if (type != SIX_LOCK_write)
+		six_acquire(&lock->dep_map, 1, type == SIX_LOCK_read, ip);
+	return true;
+}
+EXPORT_SYMBOL_GPL(six_trylock_ip);
+
+/**
+ * six_relock_ip - attempt to re-take a lock that was held previously
+ * @lock:	lock to take
+ * @type:	SIX_LOCK_read, SIX_LOCK_intent, or SIX_LOCK_write
+ * @seq:	lock sequence number obtained from six_lock_seq() while lock was
+ *		held previously
+ * @ip:		ip parameter for lockdep/lockstat, i.e. _THIS_IP_
+ *
+ * Return: true on success, false on failure.
+ */
+bool six_relock_ip(struct six_lock *lock, enum six_lock_type type,
+		   unsigned seq, unsigned long ip)
+{
+	if (lock->seq != seq || !six_trylock_ip(lock, type, ip))
+		return false;
+
+	if (lock->seq != seq) {
+		six_unlock_ip(lock, type, ip);
+		return false;
+	}
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(six_relock_ip);
+
+#ifdef CONFIG_LOCK_SPIN_ON_OWNER
+
+static inline bool six_can_spin_on_owner(struct six_lock *lock)
+{
+	struct task_struct *owner;
+	bool ret;
+
+	if (need_resched())
+		return false;
+
+	rcu_read_lock();
+	owner = READ_ONCE(lock->owner);
+	ret = !owner || owner_on_cpu(owner);
+	rcu_read_unlock();
+
+	return ret;
+}
+
+static inline bool six_spin_on_owner(struct six_lock *lock,
+				     struct task_struct *owner,
+				     u64 end_time)
+{
+	bool ret = true;
+	unsigned loop = 0;
+
+	rcu_read_lock();
+	while (lock->owner == owner) {
+		/*
+		 * Ensure we emit the owner->on_cpu, dereference _after_
+		 * checking lock->owner still matches owner. If that fails,
+		 * owner might point to freed memory. If it still matches,
+		 * the rcu_read_lock() ensures the memory stays valid.
+		 */
+		barrier();
+
+		if (!owner_on_cpu(owner) || need_resched()) {
+			ret = false;
+			break;
+		}
+
+		if (!(++loop & 0xf) && (time_after64(sched_clock(), end_time))) {
+			six_set_bitmask(lock, SIX_LOCK_NOSPIN);
+			ret = false;
+			break;
+		}
+
+		cpu_relax();
+	}
+	rcu_read_unlock();
+
+	return ret;
+}
+
+static inline bool six_optimistic_spin(struct six_lock *lock, enum six_lock_type type)
+{
+	struct task_struct *task = current;
+	u64 end_time;
+
+	if (type == SIX_LOCK_write)
+		return false;
+
+	preempt_disable();
+	if (!six_can_spin_on_owner(lock))
+		goto fail;
+
+	if (!osq_lock(&lock->osq))
+		goto fail;
+
+	end_time = sched_clock() + 10 * NSEC_PER_USEC;
+
+	while (1) {
+		struct task_struct *owner;
+
+		/*
+		 * If there's an owner, wait for it to either
+		 * release the lock or go to sleep.
+		 */
+		owner = READ_ONCE(lock->owner);
+		if (owner && !six_spin_on_owner(lock, owner, end_time))
+			break;
+
+		if (do_six_trylock(lock, type, false)) {
+			osq_unlock(&lock->osq);
+			preempt_enable();
+			return true;
+		}
+
+		/*
+		 * When there's no owner, we might have preempted between the
+		 * owner acquiring the lock and setting the owner field. If
+		 * we're an RT task that will live-lock because we won't let
+		 * the owner complete.
+		 */
+		if (!owner && (need_resched() || rt_task(task)))
+			break;
+
+		/*
+		 * The cpu_relax() call is a compiler barrier which forces
+		 * everything in this loop to be re-loaded. We don't need
+		 * memory barriers as we'll eventually observe the right
+		 * values at the cost of a few extra spins.
+		 */
+		cpu_relax();
+	}
+
+	osq_unlock(&lock->osq);
+fail:
+	preempt_enable();
+
+	/*
+	 * If we fell out of the spin path because of need_resched(),
+	 * reschedule now, before we try-lock again. This avoids getting
+	 * scheduled out right after we obtained the lock.
+	 */
+	if (need_resched())
+		schedule();
+
+	return false;
+}
+
+#else /* CONFIG_LOCK_SPIN_ON_OWNER */
+
+static inline bool six_optimistic_spin(struct six_lock *lock, enum six_lock_type type)
+{
+	return false;
+}
+
+#endif
+
+noinline
+static int six_lock_slowpath(struct six_lock *lock, enum six_lock_type type,
+			     struct six_lock_waiter *wait,
+			     six_lock_should_sleep_fn should_sleep_fn, void *p,
+			     unsigned long ip)
+{
+	u32 old;
+	int ret = 0;
+
+	if (type == SIX_LOCK_write) {
+		EBUG_ON(atomic_read(&lock->state) & SIX_LOCK_HELD_write);
+		atomic_add(SIX_LOCK_HELD_write, &lock->state);
+		smp_mb__after_atomic();
+	}
+
+	trace_contention_begin(lock, 0);
+	lock_contended(&lock->dep_map, ip);
+
+	if (six_optimistic_spin(lock, type))
+		goto out;
+
+	wait->task		= current;
+	wait->lock_want		= type;
+	wait->lock_acquired	= false;
+
+	raw_spin_lock(&lock->wait_lock);
+	six_set_bitmask(lock, SIX_LOCK_WAITING_read << type);
+	/*
+	 * Retry taking the lock after taking waitlist lock, in case we raced
+	 * with an unlock:
+	 */
+	ret = __do_six_trylock(lock, type, current, false);
+	if (ret <= 0) {
+		wait->start_time = local_clock();
+
+		if (!list_empty(&lock->wait_list)) {
+			struct six_lock_waiter *last =
+				list_last_entry(&lock->wait_list,
+					struct six_lock_waiter, list);
+
+			if (time_before_eq64(wait->start_time, last->start_time))
+				wait->start_time = last->start_time + 1;
+		}
+
+		list_add_tail(&wait->list, &lock->wait_list);
+	}
+	raw_spin_unlock(&lock->wait_lock);
+
+	if (unlikely(ret > 0)) {
+		ret = 0;
+		goto out;
+	}
+
+	if (unlikely(ret < 0)) {
+		__six_lock_wakeup(lock, -ret - 1);
+		ret = 0;
+	}
+
+	while (1) {
+		set_current_state(TASK_UNINTERRUPTIBLE);
+
+		if (wait->lock_acquired)
+			break;
+
+		ret = should_sleep_fn ? should_sleep_fn(lock, p) : 0;
+		if (unlikely(ret)) {
+			raw_spin_lock(&lock->wait_lock);
+			if (!wait->lock_acquired)
+				list_del(&wait->list);
+			raw_spin_unlock(&lock->wait_lock);
+
+			if (unlikely(wait->lock_acquired))
+				do_six_unlock_type(lock, type);
+			break;
+		}
+
+		schedule();
+	}
+
+	__set_current_state(TASK_RUNNING);
+out:
+	if (ret && type == SIX_LOCK_write) {
+		six_clear_bitmask(lock, SIX_LOCK_HELD_write);
+		six_lock_wakeup(lock, old, SIX_LOCK_read);
+	}
+	trace_contention_end(lock, 0);
+
+	return ret;
+}
+
+/**
+ * six_lock_ip_waiter - take a lock, with full waitlist interface
+ * @lock:	lock to take
+ * @type:	SIX_LOCK_read, SIX_LOCK_intent, or SIX_LOCK_write
+ * @wait:	pointer to wait object, which will be added to lock's waitlist
+ * @should_sleep_fn: callback run after adding to waitlist, immediately prior
+ *		to scheduling
+ * @p:		passed through to @should_sleep_fn
+ * @ip:		ip parameter for lockdep/lockstat, i.e. _THIS_IP_
+ *
+ * This is the most general six_lock() variant, with parameters to support full
+ * cycle detection for deadlock avoidance.
+ *
+ * The code calling this function must implement tracking of held locks, and the
+ * @wait object should be embedded into the struct that tracks held locks -
+ * which must also be accessible in a thread-safe way.
+ *
+ * @should_sleep_fn should invoke the cycle detector; it should walk each
+ * lock's waiters, and for each waiter recursively walk their held locks.
+ *
+ * When this function must block, @wait will be added to @lock's waitlist before
+ * calling trylock, and before calling @should_sleep_fn, and @wait will not be
+ * removed from the lock waitlist until the lock has been successfully acquired,
+ * or we abort.
+ *
+ * @wait.start_time will be monotonically increasing for any given waitlist, and
+ * thus may be used as a loop cursor.
+ *
+ * Return: 0 on success, or the return code from @should_sleep_fn on failure.
+ */
+int six_lock_ip_waiter(struct six_lock *lock, enum six_lock_type type,
+		       struct six_lock_waiter *wait,
+		       six_lock_should_sleep_fn should_sleep_fn, void *p,
+		       unsigned long ip)
+{
+	int ret;
+
+	wait->start_time = 0;
+
+	if (type != SIX_LOCK_write)
+		six_acquire(&lock->dep_map, 0, type == SIX_LOCK_read, ip);
+
+	ret = do_six_trylock(lock, type, true) ? 0
+		: six_lock_slowpath(lock, type, wait, should_sleep_fn, p, ip);
+
+	if (ret && type != SIX_LOCK_write)
+		six_release(&lock->dep_map, ip);
+	if (!ret)
+		lock_acquired(&lock->dep_map, ip);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(six_lock_ip_waiter);
+
+__always_inline
+static void do_six_unlock_type(struct six_lock *lock, enum six_lock_type type)
+{
+	const struct six_lock_vals l[] = LOCK_VALS;
+	u32 state;
+
+	if (type == SIX_LOCK_intent)
+		lock->owner = NULL;
+
+	if (type == SIX_LOCK_read &&
+	    lock->readers) {
+		smp_mb(); /* unlock barrier */
+		this_cpu_dec(*lock->readers);
+		smp_mb(); /* between unlocking and checking for waiters */
+		state = atomic_read(&lock->state);
+	} else {
+		u32 v = l[type].lock_val;
+
+		if (type != SIX_LOCK_read)
+			v += atomic_read(&lock->state) & SIX_LOCK_NOSPIN;
+
+		EBUG_ON(!(atomic_read(&lock->state) & l[type].held_mask));
+		state = atomic_sub_return_release(v, &lock->state);
+	}
+
+	six_lock_wakeup(lock, state, l[type].unlock_wakeup);
+}
+
+/**
+ * six_unlock_ip - drop a six lock
+ * @lock:	lock to unlock
+ * @type:	SIX_LOCK_read, SIX_LOCK_intent, or SIX_LOCK_write
+ * @ip:		ip parameter for lockdep/lockstat, i.e. _THIS_IP_
+ *
+ * When a lock is held multiple times (because six_lock_incement()) was used),
+ * this decrements the 'lock held' counter by one.
+ *
+ * For example:
+ * six_lock_read(&foo->lock);				read count 1
+ * six_lock_increment(&foo->lock, SIX_LOCK_read);	read count 2
+ * six_lock_unlock(&foo->lock, SIX_LOCK_read);		read count 1
+ * six_lock_unlock(&foo->lock, SIX_LOCK_read);		read count 0
+ */
+void six_unlock_ip(struct six_lock *lock, enum six_lock_type type, unsigned long ip)
+{
+	EBUG_ON(type == SIX_LOCK_write &&
+		!(atomic_read(&lock->state) & SIX_LOCK_HELD_intent));
+	EBUG_ON((type == SIX_LOCK_write ||
+		 type == SIX_LOCK_intent) &&
+		lock->owner != current);
+
+	if (type != SIX_LOCK_write)
+		six_release(&lock->dep_map, ip);
+
+	if (type == SIX_LOCK_intent &&
+	    lock->intent_lock_recurse) {
+		--lock->intent_lock_recurse;
+		return;
+	}
+
+	lock->seq += type == SIX_LOCK_write;
+
+	do_six_unlock_type(lock, type);
+}
+EXPORT_SYMBOL_GPL(six_unlock_ip);
+
+/**
+ * six_lock_downgrade - convert an intent lock to a read lock
+ * @lock:	lock to dowgrade
+ *
+ * @lock will have read count incremented and intent count decremented
+ */
+void six_lock_downgrade(struct six_lock *lock)
+{
+	six_lock_increment(lock, SIX_LOCK_read);
+	six_unlock_intent(lock);
+}
+EXPORT_SYMBOL_GPL(six_lock_downgrade);
+
+/**
+ * six_lock_tryupgrade - attempt to convert read lock to an intent lock
+ * @lock:	lock to upgrade
+ *
+ * On success, @lock will have intent count incremented and read count
+ * decremented
+ *
+ * Return: true on success, false on failure
+ */
+bool six_lock_tryupgrade(struct six_lock *lock)
+{
+	const struct six_lock_vals l[] = LOCK_VALS;
+	u32 old, new, v = atomic_read(&lock->state);
+
+	do {
+		new = old = v;
+
+		if (new & SIX_LOCK_HELD_intent)
+			return false;
+
+		if (!lock->readers) {
+			EBUG_ON(!(new & SIX_LOCK_HELD_read));
+			new -= l[SIX_LOCK_read].lock_val;
+		}
+
+		new |= SIX_LOCK_HELD_intent;
+	} while ((v = atomic_cmpxchg_acquire(&lock->state, old, new)) != old);
+
+	if (lock->readers)
+		this_cpu_dec(*lock->readers);
+
+	six_set_owner(lock, SIX_LOCK_intent, old, current);
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(six_lock_tryupgrade);
+
+/**
+ * six_trylock_convert - attempt to convert a held lock from one type to another
+ * @lock:	lock to upgrade
+ * @from:	SIX_LOCK_read or SIX_LOCK_intent
+ * @to:		SIX_LOCK_read or SIX_LOCK_intent
+ *
+ * On success, @lock will have intent count incremented and read count
+ * decremented
+ *
+ * Return: true on success, false on failure
+ */
+bool six_trylock_convert(struct six_lock *lock,
+			 enum six_lock_type from,
+			 enum six_lock_type to)
+{
+	EBUG_ON(to == SIX_LOCK_write || from == SIX_LOCK_write);
+
+	if (to == from)
+		return true;
+
+	if (to == SIX_LOCK_read) {
+		six_lock_downgrade(lock);
+		return true;
+	} else {
+		return six_lock_tryupgrade(lock);
+	}
+}
+EXPORT_SYMBOL_GPL(six_trylock_convert);
+
+/**
+ * six_lock_increment - increase held lock count on a lock that is already held
+ * @lock:	lock to increment
+ * @type:	SIX_LOCK_read or SIX_LOCK_intent
+ *
+ * @lock must already be held, with a lock type that is greater than or equal to
+ * @type
+ *
+ * A corresponding six_unlock_type() call will be required for @lock to be fully
+ * unlocked.
+ */
+void six_lock_increment(struct six_lock *lock, enum six_lock_type type)
+{
+	const struct six_lock_vals l[] = LOCK_VALS;
+
+	six_acquire(&lock->dep_map, 0, type == SIX_LOCK_read, _RET_IP_);
+
+	/* XXX: assert already locked, and that we don't overflow: */
+
+	switch (type) {
+	case SIX_LOCK_read:
+		if (lock->readers) {
+			this_cpu_inc(*lock->readers);
+		} else {
+			EBUG_ON(!(atomic_read(&lock->state) &
+				  (SIX_LOCK_HELD_read|
+				   SIX_LOCK_HELD_intent)));
+			atomic_add(l[type].lock_val, &lock->state);
+		}
+		break;
+	case SIX_LOCK_intent:
+		EBUG_ON(!(atomic_read(&lock->state) & SIX_LOCK_HELD_intent));
+		lock->intent_lock_recurse++;
+		break;
+	case SIX_LOCK_write:
+		BUG();
+		break;
+	}
+}
+EXPORT_SYMBOL_GPL(six_lock_increment);
+
+/**
+ * six_lock_wakeup_all - wake up all waiters on @lock
+ * @lock:	lock to wake up waiters for
+ *
+ * Wakeing up waiters will cause them to re-run should_sleep_fn, which may then
+ * abort the lock operation.
+ *
+ * This function is never needed in a bug-free program; it's only useful in
+ * debug code, e.g. to determine if a cycle detector is at fault.
+ */
+void six_lock_wakeup_all(struct six_lock *lock)
+{
+	u32 state = atomic_read(&lock->state);
+	struct six_lock_waiter *w;
+
+	six_lock_wakeup(lock, state, SIX_LOCK_read);
+	six_lock_wakeup(lock, state, SIX_LOCK_intent);
+	six_lock_wakeup(lock, state, SIX_LOCK_write);
+
+	raw_spin_lock(&lock->wait_lock);
+	list_for_each_entry(w, &lock->wait_list, list)
+		wake_up_process(w->task);
+	raw_spin_unlock(&lock->wait_lock);
+}
+EXPORT_SYMBOL_GPL(six_lock_wakeup_all);
+
+/**
+ * six_lock_counts - return held lock counts, for each lock type
+ * @lock:	lock to return counters for
+ *
+ * Return: the number of times a lock is held for read, intent and write.
+ */
+struct six_lock_count six_lock_counts(struct six_lock *lock)
+{
+	struct six_lock_count ret;
+
+	ret.n[SIX_LOCK_read]	= !lock->readers
+		? atomic_read(&lock->state) & SIX_LOCK_HELD_read
+		: pcpu_read_count(lock);
+	ret.n[SIX_LOCK_intent]	= !!(atomic_read(&lock->state) & SIX_LOCK_HELD_intent) +
+		lock->intent_lock_recurse;
+	ret.n[SIX_LOCK_write]	= !!(atomic_read(&lock->state) & SIX_LOCK_HELD_write);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(six_lock_counts);
+
+/**
+ * six_lock_readers_add - directly manipulate reader count of a lock
+ * @lock:	lock to add/subtract readers for
+ * @nr:		reader count to add/subtract
+ *
+ * When an upper layer is implementing lock reentrency, we may have both read
+ * and intent locks on the same lock.
+ *
+ * When we need to take a write lock, the read locks will cause self-deadlock,
+ * because six locks themselves do not track which read locks are held by the
+ * current thread and which are held by a different thread - it does no
+ * per-thread tracking of held locks.
+ *
+ * The upper layer that is tracking held locks may however, if trylock() has
+ * failed, count up its own read locks, subtract them, take the write lock, and
+ * then re-add them.
+ *
+ * As in any other situation when taking a write lock, @lock must be held for
+ * intent one (or more) times, so @lock will never be left unlocked.
+ */
+void six_lock_readers_add(struct six_lock *lock, int nr)
+{
+	if (lock->readers) {
+		this_cpu_add(*lock->readers, nr);
+	} else {
+		EBUG_ON((int) (atomic_read(&lock->state) & SIX_LOCK_HELD_read) + nr < 0);
+		/* reader count starts at bit 0 */
+		atomic_add(nr, &lock->state);
+	}
+}
+EXPORT_SYMBOL_GPL(six_lock_readers_add);
+
+/**
+ * six_lock_exit - release resources held by a lock prior to freeing
+ * @lock:	lock to exit
+ *
+ * When a lock was initialized in percpu mode (SIX_OLCK_INIT_PCPU), this is
+ * required to free the percpu read counts.
+ */
+void six_lock_exit(struct six_lock *lock)
+{
+	WARN_ON(lock->readers && pcpu_read_count(lock));
+	WARN_ON(atomic_read(&lock->state) & SIX_LOCK_HELD_read);
+
+	free_percpu(lock->readers);
+	lock->readers = NULL;
+}
+EXPORT_SYMBOL_GPL(six_lock_exit);
+
+void __six_lock_init(struct six_lock *lock, const char *name,
+		     struct lock_class_key *key, enum six_lock_init_flags flags)
+{
+	atomic_set(&lock->state, 0);
+	raw_spin_lock_init(&lock->wait_lock);
+	INIT_LIST_HEAD(&lock->wait_list);
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	debug_check_no_locks_freed((void *) lock, sizeof(*lock));
+	lockdep_init_map(&lock->dep_map, name, key, 0);
+#endif
+
+	if (flags & SIX_LOCK_INIT_PCPU) {
+		/*
+		 * We don't return an error here on memory allocation failure
+		 * since percpu is an optimization, and locks will work with the
+		 * same semantics in non-percpu mode: callers can check for
+		 * failure if they wish by checking lock->readers, but generally
+		 * will not want to treat it as an error.
+		 */
+		lock->readers = alloc_percpu(unsigned);
+	}
+}
+EXPORT_SYMBOL_GPL(__six_lock_init);
-- 
2.40.1


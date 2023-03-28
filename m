Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B12E6CCE40
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 01:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjC1Xwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 19:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjC1Xw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 19:52:29 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5402F2D55;
        Tue, 28 Mar 2023 16:52:26 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id 88F6E20FDAAD;
        Tue, 28 Mar 2023 16:52:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 88F6E20FDAAD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1680047545;
        bh=R9INv6oij2jvfqxRYN7sTvDkp32JqHmiAHAQNiuLI7o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sVdP9l1biReoiPhgTNLfb2M8N0EPi4eKoILkeMvx1st/ATCkMW2Tel3jidMugNYOw
         2MliuwIYexwc+uv0piwdKaKVMaNRJW8v56QiNQYHoXKhqo4wRiykXf78J+b9Y+k77/
         rZcPrkp66VFEqpJ4JgQULrfbcQZzjrmzBngpRfWw=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, dcook@linux.microsoft.com,
        alanau@linux.microsoft.com, brauner@kernel.org,
        akpm@linux-foundation.org, ebiederm@xmission.com,
        keescook@chromium.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH v10 03/12] tracing/user_events: Use remote writes for event enablement
Date:   Tue, 28 Mar 2023 16:52:10 -0700
Message-Id: <20230328235219.203-4-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230328235219.203-1-beaub@linux.microsoft.com>
References: <20230328235219.203-1-beaub@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of the discussions for user_events aligned with user space
tracers, it was determined that user programs should register a aligned
value to set or clear a bit when an event becomes enabled. Currently a
shared page is being used that requires mmap(). Remove the shared page
implementation and move to a user registered address implementation.

In this new model during the event registration from user programs 3 new
values are specified. The first is the address to update when the event
is either enabled or disabled. The second is the bit to set/clear to
reflect the event being enabled. The third is the size of the value at
the specified address.

This allows for a local 32/64-bit value in user programs to support
both kernel and user tracers. As an example, setting bit 31 for kernel
tracers when the event becomes enabled allows for user tracers to use
the other bits for ref counts or other flags. The kernel side updates
the bit atomically, user programs need to also update these values
atomically.

User provided addresses must be aligned on a natural boundary, this
allows for single page checking and prevents odd behaviors such as a
enable value straddling 2 pages instead of a single page. Currently
page faults are only logged, future patches will handle these.

Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 include/linux/user_events.h      |  53 ++-
 include/uapi/linux/user_events.h |  15 +-
 kernel/trace/Kconfig             |   5 +-
 kernel/trace/trace_events_user.c | 586 ++++++++++++++++++++++++-------
 4 files changed, 517 insertions(+), 142 deletions(-)

diff --git a/include/linux/user_events.h b/include/linux/user_events.h
index 3d747c45d2fa..0120b3dd5b03 100644
--- a/include/linux/user_events.h
+++ b/include/linux/user_events.h
@@ -9,13 +9,63 @@
 #ifndef _LINUX_USER_EVENTS_H
 #define _LINUX_USER_EVENTS_H
 
+#include <linux/list.h>
+#include <linux/refcount.h>
+#include <linux/mm_types.h>
+#include <linux/workqueue.h>
 #include <uapi/linux/user_events.h>
 
 #ifdef CONFIG_USER_EVENTS
 struct user_event_mm {
+	struct list_head link;
+	struct list_head enablers;
+	struct mm_struct *mm;
+	struct user_event_mm *next;
+	refcount_t refcnt;
+	refcount_t tasks;
+	struct rcu_work put_rwork;
 };
-#endif
 
+extern void user_event_mm_dup(struct task_struct *t,
+			      struct user_event_mm *old_mm);
+
+extern void user_event_mm_remove(struct task_struct *t);
+
+static inline void user_events_fork(struct task_struct *t,
+				    unsigned long clone_flags)
+{
+	struct user_event_mm *old_mm;
+
+	if (!t || !current->user_event_mm)
+		return;
+
+	old_mm = current->user_event_mm;
+
+	if (clone_flags & CLONE_VM) {
+		t->user_event_mm = old_mm;
+		refcount_inc(&old_mm->tasks);
+		return;
+	}
+
+	user_event_mm_dup(t, old_mm);
+}
+
+static inline void user_events_execve(struct task_struct *t)
+{
+	if (!t || !t->user_event_mm)
+		return;
+
+	user_event_mm_remove(t);
+}
+
+static inline void user_events_exit(struct task_struct *t)
+{
+	if (!t || !t->user_event_mm)
+		return;
+
+	user_event_mm_remove(t);
+}
+#else
 static inline void user_events_fork(struct task_struct *t,
 				    unsigned long clone_flags)
 {
@@ -28,5 +78,6 @@ static inline void user_events_execve(struct task_struct *t)
 static inline void user_events_exit(struct task_struct *t)
 {
 }
+#endif /* CONFIG_USER_EVENTS */
 
 #endif /* _LINUX_USER_EVENTS_H */
diff --git a/include/uapi/linux/user_events.h b/include/uapi/linux/user_events.h
index 03f92366068d..22521bc622db 100644
--- a/include/uapi/linux/user_events.h
+++ b/include/uapi/linux/user_events.h
@@ -27,12 +27,21 @@ struct user_reg {
 	/* Input: Size of the user_reg structure being used */
 	__u32 size;
 
+	/* Input: Bit in enable address to use */
+	__u8 enable_bit;
+
+	/* Input: Enable size in bytes at address */
+	__u8 enable_size;
+
+	/* Input: Flags for future use, set to 0 */
+	__u16 flags;
+
+	/* Input: Address to update when enabled */
+	__u64 enable_addr;
+
 	/* Input: Pointer to string with event name, description and flags */
 	__u64 name_args;
 
-	/* Output: Bitwise index of the event within the status page */
-	__u32 status_bit;
-
 	/* Output: Index of the event to use when writing data */
 	__u32 write_index;
 } __attribute__((__packed__));
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index d7043043f59c..b61a1bfbfc22 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -791,9 +791,10 @@ config USER_EVENTS
 	  can be used like an existing kernel trace event.  User trace
 	  events are generated by writing to a tracefs file.  User
 	  processes can determine if their tracing events should be
-	  generated by memory mapping a tracefs file and checking for
-	  an associated byte being non-zero.
+	  generated by registering a value and bit with the kernel
+	  that reflects when it is enabled or not.
 
+	  See Documentation/trace/user_events.rst.
 	  If in doubt, say N.
 
 config HIST_TRIGGERS
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 070551480747..553a82ee7aeb 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -19,6 +19,7 @@
 #include <linux/tracefs.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
+#include <linux/highmem.h>
 #include <linux/user_events.h>
 #include "trace.h"
 #include "trace_dynevent.h"
@@ -29,34 +30,11 @@
 #define FIELD_DEPTH_NAME 1
 #define FIELD_DEPTH_SIZE 2
 
-/*
- * Limits how many trace_event calls user processes can create:
- * Must be a power of two of PAGE_SIZE.
- */
-#define MAX_PAGE_ORDER 0
-#define MAX_PAGES (1 << MAX_PAGE_ORDER)
-#define MAX_BYTES (MAX_PAGES * PAGE_SIZE)
-#define MAX_EVENTS (MAX_BYTES * 8)
-
 /* Limit how long of an event name plus args within the subsystem. */
 #define MAX_EVENT_DESC 512
 #define EVENT_NAME(user_event) ((user_event)->tracepoint.name)
 #define MAX_FIELD_ARRAY_SIZE 1024
 
-/*
- * The MAP_STATUS_* macros are used for taking a index and determining the
- * appropriate byte and the bit in the byte to set/reset for an event.
- *
- * The lower 3 bits of the index decide which bit to set.
- * The remaining upper bits of the index decide which byte to use for the bit.
- *
- * This is used when an event has a probe attached/removed to reflect live
- * status of the event wanting tracing or not to user-programs via shared
- * memory maps.
- */
-#define MAP_STATUS_BYTE(index) ((index) >> 3)
-#define MAP_STATUS_MASK(index) BIT((index) & 7)
-
 /*
  * Internal bits (kernel side only) to keep track of connected probes:
  * These are used when status is requested in text form about an event. These
@@ -70,20 +48,14 @@
 #define EVENT_STATUS_OTHER BIT(7)
 
 /*
- * Stores the pages, tables, and locks for a group of events.
- * Each logical grouping of events has its own group, with a
- * matching page for status checks within user programs. This
- * allows for isolation of events to user programs by various
- * means.
+ * Stores the system name, tables, and locks for a group of events. This
+ * allows isolation for events by various means.
  */
 struct user_event_group {
-	struct page *pages;
-	char *register_page_data;
 	char *system_name;
 	struct hlist_node node;
 	struct mutex reg_mutex;
 	DECLARE_HASHTABLE(register_table, 8);
-	DECLARE_BITMAP(page_bitmap, MAX_EVENTS);
 };
 
 /* Group for init_user_ns mapping, top-most group */
@@ -106,12 +78,34 @@ struct user_event {
 	struct list_head fields;
 	struct list_head validators;
 	refcount_t refcnt;
-	int index;
-	int flags;
 	int min_size;
 	char status;
 };
 
+/*
+ * Stores per-mm/event properties that enable an address to be
+ * updated properly for each task. As tasks are forked, we use
+ * these to track enablement sites that are tied to an event.
+ */
+struct user_event_enabler {
+	struct list_head link;
+	struct user_event *event;
+	unsigned long addr;
+
+	/* Track enable bit, flags, etc. Aligned for bitops. */
+	unsigned int values;
+};
+
+/* Bits 0-5 are for the bit to update upon enable/disable (0-63 allowed) */
+#define ENABLE_VAL_BIT_MASK 0x3F
+
+/* Only duplicate the bit value */
+#define ENABLE_VAL_DUP_MASK ENABLE_VAL_BIT_MASK
+
+/* Global list of memory descriptors using user_events */
+static LIST_HEAD(user_event_mms);
+static DEFINE_SPINLOCK(user_event_mms_lock);
+
 /*
  * Stores per-file events references, as users register events
  * within a file this structure is modified and freed via RCU.
@@ -145,33 +139,17 @@ static int user_event_parse(struct user_event_group *group, char *name,
 			    char *args, char *flags,
 			    struct user_event **newuser);
 
+static struct user_event_mm *user_event_mm_get(struct user_event_mm *mm);
+static struct user_event_mm *user_event_mm_get_all(struct user_event *user);
+static void user_event_mm_put(struct user_event_mm *mm);
+
 static u32 user_event_key(char *name)
 {
 	return jhash(name, strlen(name), 0);
 }
 
-static void set_page_reservations(char *pages, bool set)
-{
-	int page;
-
-	for (page = 0; page < MAX_PAGES; ++page) {
-		void *addr = pages + (PAGE_SIZE * page);
-
-		if (set)
-			SetPageReserved(virt_to_page(addr));
-		else
-			ClearPageReserved(virt_to_page(addr));
-	}
-}
-
 static void user_event_group_destroy(struct user_event_group *group)
 {
-	if (group->register_page_data)
-		set_page_reservations(group->register_page_data, false);
-
-	if (group->pages)
-		__free_pages(group->pages, MAX_PAGE_ORDER);
-
 	kfree(group->system_name);
 	kfree(group);
 }
@@ -242,19 +220,6 @@ static struct user_event_group
 	if (!group->system_name)
 		goto error;
 
-	group->pages = alloc_pages(GFP_KERNEL | __GFP_ZERO, MAX_PAGE_ORDER);
-
-	if (!group->pages)
-		goto error;
-
-	group->register_page_data = page_address(group->pages);
-
-	set_page_reservations(group->register_page_data, true);
-
-	/* Zero all bits beside 0 (which is reserved for failures) */
-	bitmap_zero(group->page_bitmap, MAX_EVENTS);
-	set_bit(0, group->page_bitmap);
-
 	mutex_init(&group->reg_mutex);
 	hash_init(group->register_table);
 
@@ -266,20 +231,367 @@ static struct user_event_group
 	return NULL;
 };
 
-static __always_inline
-void user_event_register_set(struct user_event *user)
+static void user_event_enabler_destroy(struct user_event_enabler *enabler)
+{
+	list_del_rcu(&enabler->link);
+
+	/* No longer tracking the event via the enabler */
+	refcount_dec(&enabler->event->refcnt);
+
+	kfree(enabler);
+}
+
+static int user_event_mm_fault_in(struct user_event_mm *mm, unsigned long uaddr)
+{
+	bool unlocked;
+	int ret;
+
+	mmap_read_lock(mm->mm);
+
+	/* Ensure MM has tasks, cannot use after exit_mm() */
+	if (refcount_read(&mm->tasks) == 0) {
+		ret = -ENOENT;
+		goto out;
+	}
+
+	ret = fixup_user_fault(mm->mm, uaddr, FAULT_FLAG_WRITE | FAULT_FLAG_REMOTE,
+			       &unlocked);
+out:
+	mmap_read_unlock(mm->mm);
+
+	return ret;
+}
+
+static int user_event_enabler_write(struct user_event_mm *mm,
+				    struct user_event_enabler *enabler)
+{
+	unsigned long uaddr = enabler->addr;
+	unsigned long *ptr;
+	struct page *page;
+	void *kaddr;
+	int ret;
+
+	lockdep_assert_held(&event_mutex);
+	mmap_assert_locked(mm->mm);
+
+	/* Ensure MM has tasks, cannot use after exit_mm() */
+	if (refcount_read(&mm->tasks) == 0)
+		return -ENOENT;
+
+	ret = pin_user_pages_remote(mm->mm, uaddr, 1, FOLL_WRITE | FOLL_NOFAULT,
+				    &page, NULL, NULL);
+
+	if (ret <= 0) {
+		pr_warn("user_events: Enable write failed\n");
+		return -EFAULT;
+	}
+
+	kaddr = kmap_local_page(page);
+	ptr = kaddr + (uaddr & ~PAGE_MASK);
+
+	/* Update bit atomically, user tracers must be atomic as well */
+	if (enabler->event && enabler->event->status)
+		set_bit(enabler->values & ENABLE_VAL_BIT_MASK, ptr);
+	else
+		clear_bit(enabler->values & ENABLE_VAL_BIT_MASK, ptr);
+
+	kunmap_local(kaddr);
+	unpin_user_pages_dirty_lock(&page, 1, true);
+
+	return 0;
+}
+
+static void user_event_enabler_update(struct user_event *user)
+{
+	struct user_event_enabler *enabler;
+	struct user_event_mm *mm = user_event_mm_get_all(user);
+	struct user_event_mm *next;
+
+	while (mm) {
+		next = mm->next;
+		mmap_read_lock(mm->mm);
+		rcu_read_lock();
+
+		list_for_each_entry_rcu(enabler, &mm->enablers, link)
+			if (enabler->event == user)
+				user_event_enabler_write(mm, enabler);
+
+		rcu_read_unlock();
+		mmap_read_unlock(mm->mm);
+		user_event_mm_put(mm);
+		mm = next;
+	}
+}
+
+static bool user_event_enabler_dup(struct user_event_enabler *orig,
+				   struct user_event_mm *mm)
+{
+	struct user_event_enabler *enabler;
+
+	enabler = kzalloc(sizeof(*enabler), GFP_NOWAIT);
+
+	if (!enabler)
+		return false;
+
+	enabler->event = orig->event;
+	enabler->addr = orig->addr;
+
+	/* Only dup part of value (ignore future flags, etc) */
+	enabler->values = orig->values & ENABLE_VAL_DUP_MASK;
+
+	refcount_inc(&enabler->event->refcnt);
+	list_add_rcu(&enabler->link, &mm->enablers);
+
+	return true;
+}
+
+static struct user_event_mm *user_event_mm_get(struct user_event_mm *mm)
+{
+	refcount_inc(&mm->refcnt);
+
+	return mm;
+}
+
+static struct user_event_mm *user_event_mm_get_all(struct user_event *user)
+{
+	struct user_event_mm *found = NULL;
+	struct user_event_enabler *enabler;
+	struct user_event_mm *mm;
+
+	/*
+	 * We do not want to block fork/exec while enablements are being
+	 * updated, so we use RCU to walk the current tasks that have used
+	 * user_events ABI for 1 or more events. Each enabler found in each
+	 * task that matches the event being updated has a write to reflect
+	 * the kernel state back into the process. Waits/faults must not occur
+	 * during this. So we scan the list under RCU for all the mm that have
+	 * the event within it. This is needed because mm_read_lock() can wait.
+	 * Each user mm returned has a ref inc to handle remove RCU races.
+	 */
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(mm, &user_event_mms, link)
+		list_for_each_entry_rcu(enabler, &mm->enablers, link)
+			if (enabler->event == user) {
+				mm->next = found;
+				found = user_event_mm_get(mm);
+				break;
+			}
+
+	rcu_read_unlock();
+
+	return found;
+}
+
+static struct user_event_mm *user_event_mm_create(struct task_struct *t)
+{
+	struct user_event_mm *user_mm;
+	unsigned long flags;
+
+	user_mm = kzalloc(sizeof(*user_mm), GFP_KERNEL);
+
+	if (!user_mm)
+		return NULL;
+
+	user_mm->mm = t->mm;
+	INIT_LIST_HEAD(&user_mm->enablers);
+	refcount_set(&user_mm->refcnt, 1);
+	refcount_set(&user_mm->tasks, 1);
+
+	spin_lock_irqsave(&user_event_mms_lock, flags);
+	list_add_rcu(&user_mm->link, &user_event_mms);
+	spin_unlock_irqrestore(&user_event_mms_lock, flags);
+
+	t->user_event_mm = user_mm;
+
+	/*
+	 * The lifetime of the memory descriptor can slightly outlast
+	 * the task lifetime if a ref to the user_event_mm is taken
+	 * between list_del_rcu() and call_rcu(). Therefore we need
+	 * to take a reference to it to ensure it can live this long
+	 * under this corner case. This can also occur in clones that
+	 * outlast the parent.
+	 */
+	mmgrab(user_mm->mm);
+
+	return user_mm;
+}
+
+static struct user_event_mm *current_user_event_mm(void)
+{
+	struct user_event_mm *user_mm = current->user_event_mm;
+
+	if (user_mm)
+		goto inc;
+
+	user_mm = user_event_mm_create(current);
+
+	if (!user_mm)
+		goto error;
+inc:
+	refcount_inc(&user_mm->refcnt);
+error:
+	return user_mm;
+}
+
+static void user_event_mm_destroy(struct user_event_mm *mm)
+{
+	struct user_event_enabler *enabler, *next;
+
+	list_for_each_entry_safe(enabler, next, &mm->enablers, link)
+		user_event_enabler_destroy(enabler);
+
+	mmdrop(mm->mm);
+	kfree(mm);
+}
+
+static void user_event_mm_put(struct user_event_mm *mm)
+{
+	if (mm && refcount_dec_and_test(&mm->refcnt))
+		user_event_mm_destroy(mm);
+}
+
+static void delayed_user_event_mm_put(struct work_struct *work)
+{
+	struct user_event_mm *mm;
+
+	mm = container_of(to_rcu_work(work), struct user_event_mm, put_rwork);
+	user_event_mm_put(mm);
+}
+
+void user_event_mm_remove(struct task_struct *t)
 {
-	int i = user->index;
+	struct user_event_mm *mm;
+	unsigned long flags;
+
+	might_sleep();
+
+	mm = t->user_event_mm;
+	t->user_event_mm = NULL;
+
+	/* Clone will increment the tasks, only remove if last clone */
+	if (!refcount_dec_and_test(&mm->tasks))
+		return;
+
+	/* Remove the mm from the list, so it can no longer be enabled */
+	spin_lock_irqsave(&user_event_mms_lock, flags);
+	list_del_rcu(&mm->link);
+	spin_unlock_irqrestore(&user_event_mms_lock, flags);
+
+	/*
+	 * We need to wait for currently occurring writes to stop within
+	 * the mm. This is required since exit_mm() snaps the current rss
+	 * stats and clears them. On the final mmdrop(), check_mm() will
+	 * report a bug if these increment.
+	 *
+	 * All writes/pins are done under mmap_read lock, take the write
+	 * lock to ensure in-progress faults have completed. Faults that
+	 * are pending but yet to run will check the task count and skip
+	 * the fault since the mm is going away.
+	 */
+	mmap_write_lock(mm->mm);
+	mmap_write_unlock(mm->mm);
 
-	user->group->register_page_data[MAP_STATUS_BYTE(i)] |= MAP_STATUS_MASK(i);
+	/*
+	 * Put for mm must be done after RCU delay to handle new refs in
+	 * between the list_del_rcu() and now. This ensures any get refs
+	 * during rcu_read_lock() are accounted for during list removal.
+	 *
+	 * CPU A			|	CPU B
+	 * ---------------------------------------------------------------
+	 * user_event_mm_remove()	|	rcu_read_lock();
+	 * list_del_rcu()		|	list_for_each_entry_rcu();
+	 * call_rcu()			|	refcount_inc();
+	 * .				|	rcu_read_unlock();
+	 * schedule_work()		|	.
+	 * user_event_mm_put()		|	.
+	 *
+	 * mmdrop() cannot be called in the softirq context of call_rcu()
+	 * so we use a work queue after call_rcu() to run within.
+	 */
+	INIT_RCU_WORK(&mm->put_rwork, delayed_user_event_mm_put);
+	queue_rcu_work(system_wq, &mm->put_rwork);
 }
 
-static __always_inline
-void user_event_register_clear(struct user_event *user)
+void user_event_mm_dup(struct task_struct *t, struct user_event_mm *old_mm)
 {
-	int i = user->index;
+	struct user_event_mm *mm = user_event_mm_create(t);
+	struct user_event_enabler *enabler;
 
-	user->group->register_page_data[MAP_STATUS_BYTE(i)] &= ~MAP_STATUS_MASK(i);
+	if (!mm)
+		return;
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(enabler, &old_mm->enablers, link)
+		if (!user_event_enabler_dup(enabler, mm))
+			goto error;
+
+	rcu_read_unlock();
+
+	return;
+error:
+	rcu_read_unlock();
+	user_event_mm_remove(t);
+}
+
+static struct user_event_enabler
+*user_event_enabler_create(struct user_reg *reg, struct user_event *user,
+			   int *write_result)
+{
+	struct user_event_enabler *enabler;
+	struct user_event_mm *user_mm;
+	unsigned long uaddr = (unsigned long)reg->enable_addr;
+
+	user_mm = current_user_event_mm();
+
+	if (!user_mm)
+		return NULL;
+
+	enabler = kzalloc(sizeof(*enabler), GFP_KERNEL);
+
+	if (!enabler)
+		goto out;
+
+	enabler->event = user;
+	enabler->addr = uaddr;
+	enabler->values = reg->enable_bit;
+retry:
+	/* Prevents state changes from racing with new enablers */
+	mutex_lock(&event_mutex);
+
+	/* Attempt to reflect the current state within the process */
+	mmap_read_lock(user_mm->mm);
+	*write_result = user_event_enabler_write(user_mm, enabler);
+	mmap_read_unlock(user_mm->mm);
+
+	/*
+	 * If the write works, then we will track the enabler. A ref to the
+	 * underlying user_event is held by the enabler to prevent it going
+	 * away while the enabler is still in use by a process. The ref is
+	 * removed when the enabler is destroyed. This means a event cannot
+	 * be forcefully deleted from the system until all tasks using it
+	 * exit or run exec(), which includes forks and clones.
+	 */
+	if (!*write_result) {
+		refcount_inc(&enabler->event->refcnt);
+		list_add_rcu(&enabler->link, &user_mm->enablers);
+	}
+
+	mutex_unlock(&event_mutex);
+
+	if (*write_result) {
+		/* Attempt to fault-in and retry if it worked */
+		if (!user_event_mm_fault_in(user_mm, uaddr))
+			goto retry;
+
+		kfree(enabler);
+		enabler = NULL;
+	}
+out:
+	user_event_mm_put(user_mm);
+
+	return enabler;
 }
 
 static __always_inline __must_check
@@ -824,9 +1136,6 @@ static int destroy_user_event(struct user_event *user)
 		return ret;
 
 	dyn_event_remove(&user->devent);
-
-	user_event_register_clear(user);
-	clear_bit(user->index, user->group->page_bitmap);
 	hash_del(&user->node);
 
 	user_event_destroy_validators(user);
@@ -972,9 +1281,9 @@ static void user_event_perf(struct user_event *user, struct iov_iter *i,
 #endif
 
 /*
- * Update the register page that is shared between user processes.
+ * Update the enabled bit among all user processes.
  */
-static void update_reg_page_for(struct user_event *user)
+static void update_enable_bit_for(struct user_event *user)
 {
 	struct tracepoint *tp = &user->tracepoint;
 	char status = 0;
@@ -1005,12 +1314,9 @@ static void update_reg_page_for(struct user_event *user)
 		rcu_read_unlock_sched();
 	}
 
-	if (status)
-		user_event_register_set(user);
-	else
-		user_event_register_clear(user);
-
 	user->status = status;
+
+	user_event_enabler_update(user);
 }
 
 /*
@@ -1067,10 +1373,10 @@ static int user_event_reg(struct trace_event_call *call,
 	return ret;
 inc:
 	refcount_inc(&user->refcnt);
-	update_reg_page_for(user);
+	update_enable_bit_for(user);
 	return 0;
 dec:
-	update_reg_page_for(user);
+	update_enable_bit_for(user);
 	refcount_dec(&user->refcnt);
 	return 0;
 }
@@ -1266,7 +1572,6 @@ static int user_event_parse(struct user_event_group *group, char *name,
 			    struct user_event **newuser)
 {
 	int ret;
-	int index;
 	u32 key;
 	struct user_event *user;
 
@@ -1285,11 +1590,6 @@ static int user_event_parse(struct user_event_group *group, char *name,
 		return 0;
 	}
 
-	index = find_first_zero_bit(group->page_bitmap, MAX_EVENTS);
-
-	if (index == MAX_EVENTS)
-		return -EMFILE;
-
 	user = kzalloc(sizeof(*user), GFP_KERNEL);
 
 	if (!user)
@@ -1335,14 +1635,11 @@ static int user_event_parse(struct user_event_group *group, char *name,
 	if (ret)
 		goto put_user_lock;
 
-	user->index = index;
-
 	/* Ensure we track self ref and caller ref (2) */
 	refcount_set(&user->refcnt, 2);
 
 	dyn_event_init(&user->devent, &user_event_dops);
 	dyn_event_add(&user->devent, &user->call);
-	set_bit(user->index, group->page_bitmap);
 	hash_add(group->register_table, &user->node, key);
 
 	mutex_unlock(&event_mutex);
@@ -1559,6 +1856,37 @@ static long user_reg_get(struct user_reg __user *ureg, struct user_reg *kreg)
 	if (ret)
 		return ret;
 
+	/* Ensure no flags, since we don't support any yet */
+	if (kreg->flags != 0)
+		return -EINVAL;
+
+	/* Ensure supported size */
+	switch (kreg->enable_size) {
+	case 4:
+		/* 32-bit */
+		break;
+#if BITS_PER_LONG >= 64
+	case 8:
+		/* 64-bit */
+		break;
+#endif
+	default:
+		return -EINVAL;
+	}
+
+	/* Ensure natural alignment */
+	if (kreg->enable_addr % kreg->enable_size)
+		return -EINVAL;
+
+	/* Ensure bit range for size */
+	if (kreg->enable_bit > (kreg->enable_size * BITS_PER_BYTE) - 1)
+		return -EINVAL;
+
+	/* Ensure accessible */
+	if (!access_ok((const void __user *)(uintptr_t)kreg->enable_addr,
+		       kreg->enable_size))
+		return -EFAULT;
+
 	kreg->size = size;
 
 	return 0;
@@ -1573,8 +1901,10 @@ static long user_events_ioctl_reg(struct user_event_file_info *info,
 	struct user_reg __user *ureg = (struct user_reg __user *)uarg;
 	struct user_reg reg;
 	struct user_event *user;
+	struct user_event_enabler *enabler;
 	char *name;
 	long ret;
+	int write_result;
 
 	ret = user_reg_get(ureg, &reg);
 
@@ -1605,8 +1935,28 @@ static long user_events_ioctl_reg(struct user_event_file_info *info,
 	if (ret < 0)
 		return ret;
 
+	/*
+	 * user_events_ref_add succeeded:
+	 * At this point we have a user_event, it's lifetime is bound by the
+	 * reference count, not this file. If anything fails, the user_event
+	 * still has a reference until the file is released. During release
+	 * any remaining references (from user_events_ref_add) are decremented.
+	 *
+	 * Attempt to create an enabler, which too has a lifetime tied in the
+	 * same way for the event. Once the task that caused the enabler to be
+	 * created exits or issues exec() then the enablers it has created
+	 * will be destroyed and the ref to the event will be decremented.
+	 */
+	enabler = user_event_enabler_create(&reg, user, &write_result);
+
+	if (!enabler)
+		return -ENOMEM;
+
+	/* Write failed/faulted, give error back to caller */
+	if (write_result)
+		return write_result;
+
 	put_user((u32)ret, &ureg->write_index);
-	put_user(user->index, &ureg->status_bit);
 
 	return 0;
 }
@@ -1720,38 +2070,6 @@ static const struct file_operations user_data_fops = {
 	.release = user_events_release,
 };
 
-static struct user_event_group *user_status_group(struct file *file)
-{
-	struct seq_file *m = file->private_data;
-
-	if (!m)
-		return NULL;
-
-	return m->private;
-}
-
-/*
- * Maps the shared page into the user process for checking if event is enabled.
- */
-static int user_status_mmap(struct file *file, struct vm_area_struct *vma)
-{
-	char *pages;
-	struct user_event_group *group = user_status_group(file);
-	unsigned long size = vma->vm_end - vma->vm_start;
-
-	if (size != MAX_BYTES)
-		return -EINVAL;
-
-	if (!group)
-		return -EINVAL;
-
-	pages = group->register_page_data;
-
-	return remap_pfn_range(vma, vma->vm_start,
-			       virt_to_phys(pages) >> PAGE_SHIFT,
-			       size, vm_get_page_prot(VM_READ));
-}
-
 static void *user_seq_start(struct seq_file *m, loff_t *pos)
 {
 	if (*pos)
@@ -1775,7 +2093,7 @@ static int user_seq_show(struct seq_file *m, void *p)
 	struct user_event_group *group = m->private;
 	struct user_event *user;
 	char status;
-	int i, active = 0, busy = 0, flags;
+	int i, active = 0, busy = 0;
 
 	if (!group)
 		return -EINVAL;
@@ -1784,11 +2102,10 @@ static int user_seq_show(struct seq_file *m, void *p)
 
 	hash_for_each(group->register_table, i, user, node) {
 		status = user->status;
-		flags = user->flags;
 
-		seq_printf(m, "%d:%s", user->index, EVENT_NAME(user));
+		seq_printf(m, "%s", EVENT_NAME(user));
 
-		if (flags != 0 || status != 0)
+		if (status != 0)
 			seq_puts(m, " #");
 
 		if (status != 0) {
@@ -1811,7 +2128,6 @@ static int user_seq_show(struct seq_file *m, void *p)
 	seq_puts(m, "\n");
 	seq_printf(m, "Active: %d\n", active);
 	seq_printf(m, "Busy: %d\n", busy);
-	seq_printf(m, "Max: %ld\n", MAX_EVENTS);
 
 	return 0;
 }
@@ -1847,7 +2163,6 @@ static int user_status_open(struct inode *node, struct file *file)
 
 static const struct file_operations user_status_fops = {
 	.open = user_status_open,
-	.mmap = user_status_mmap,
 	.read = seq_read,
 	.llseek  = seq_lseek,
 	.release = seq_release,
@@ -1868,8 +2183,7 @@ static int create_user_tracefs(void)
 		goto err;
 	}
 
-	/* mmap with MAP_SHARED requires writable fd */
-	emmap = tracefs_create_file("user_events_status", TRACE_MODE_WRITE,
+	emmap = tracefs_create_file("user_events_status", TRACE_MODE_READ,
 				    NULL, NULL, &user_status_fops);
 
 	if (!emmap) {
-- 
2.25.1


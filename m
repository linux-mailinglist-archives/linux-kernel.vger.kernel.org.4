Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7B06105DD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 00:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235729AbiJ0WkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 18:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234719AbiJ0WkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 18:40:17 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA52D5B103;
        Thu, 27 Oct 2022 15:40:15 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.50.127])
        by linux.microsoft.com (Postfix) with ESMTPSA id BE08A210DD4A;
        Thu, 27 Oct 2022 15:40:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BE08A210DD4A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1666910415;
        bh=Pvg3jfqri4oHWaX2IAEqNttrvSN2N/JuDOseA8Oi8kg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jk4camFMgLiqahlAxNuBzpllGd4CPtWN/MyjDBbih0QVj3edSDpbhAvXp8zb0neZA
         5n+OlNOSEwUcGxYceu7Y6uwiCbxT8kMweSFO+/W/KhvbMe0B3hljwjgrh3wyvIjjXH
         4/nCt2pvvmNEN1DzcTo88z4VW/kLl6zPd9t3DjiE=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, dcook@linux.microsoft.com,
        alanau@linux.microsoft.com
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] tracing/user_events: Use remote writes for event enablement
Date:   Thu, 27 Oct 2022 15:40:10 -0700
Message-Id: <20221027224011.2075-2-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221027224011.2075-1-beaub@linux.microsoft.com>
References: <20221027224011.2075-1-beaub@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of the discussions for user_events aligned with user space
tracers, it was determined that user programs should register a 32-bit
value to set or clear a bit when an event becomes enabled. Currently a
shared page is being used that requires mmap(). Remove the shared page
implementation and move to a user registered address implementation.

In this new model during the event registration from user programs 2 new
values are specified. The first is the address to update when the event
is either enabled or disabled. The second is the bit to set/clear to
reflect the event being enabled. This allows for a local 32-bit value in
user programs to support both kernel and user tracers. As an example,
setting bit 31 for kernel tracers when the event becomes enabled allows
for user tracers to use the other bits for ref counts or other flags.
The kernel side updates the bit atomically, user programs need to also
update these values atomically.

User provided addresses must be aligned on a 32-bit boundary, this
allows for single page checking and prevents odd behaviors such as a
32-bit value straddling 2 pages instead of a single page. Currently
page faults are only logged, future patches will handle these.

NOTE:
User programs that wish to have the enable bit shared across forks
either need to use a MAP_SHARED allocated address or register a new
address and file descriptor. If MAP_SHARED cannot be used or new
registrations cannot be done, then it's allowable to use MAP_PRIVATE
as long as the forked children never update the page themselves. Once
the page has been updated, the page from the parent will be copied over
to the child. This new copy-on-write page will not receive updates from
the kernel until another registration has been performed with this new
address.

Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 include/linux/user_events.h      |  10 +-
 kernel/trace/trace_events_user.c | 279 ++++++++++++++++---------------
 2 files changed, 153 insertions(+), 136 deletions(-)

diff --git a/include/linux/user_events.h b/include/linux/user_events.h
index 592a3fbed98e..4c3bd16395a9 100644
--- a/include/linux/user_events.h
+++ b/include/linux/user_events.h
@@ -33,12 +33,16 @@ struct user_reg {
 	/* Input: Size of the user_reg structure being used */
 	__u32 size;
 
+	/* Input: Flags/common settings */
+	__u32 enable_bit : 5, /* Bit in enable address to use (0-31) */
+	      __reserved : 27;
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
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index ae78c2d53c8a..633f24c2a1ac 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -19,6 +19,9 @@
 #include <linux/tracefs.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
+#include <linux/sched/mm.h>
+#include <linux/mmap_lock.h>
+#include <linux/highmem.h>
 /* Reminder to move to uapi when everything works */
 #ifdef CONFIG_COMPILE_TEST
 #include <linux/user_events.h>
@@ -34,34 +37,11 @@
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
@@ -75,25 +55,37 @@
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
 static struct user_event_group *init_group;
 
+/*
+ * Describes where to change a bit when an event becomes
+ * enabled/disabled. These are chained together to enable
+ * many processes being notified when an event changes. These
+ * have a lifetime tied to the data files that are used to
+ * register them. When these go away the ref count to the mm_struct
+ * is decremented to ensure mm_struct lifetime last as long as
+ * required for the enable bit set/clear.
+ */
+struct user_event_enabler {
+	struct list_head link;
+	struct mm_struct *mm;
+	struct file *file;
+	unsigned long enable_addr;
+	unsigned int enable_bit: 5,
+		     __reserved: 27;
+};
+
 /*
  * Stores per-event properties, as users register events
  * within a file a user_event might be created if it does not
@@ -110,8 +102,8 @@ struct user_event {
 	struct hlist_node node;
 	struct list_head fields;
 	struct list_head validators;
+	struct list_head enablers;
 	refcount_t refcnt;
-	int index;
 	int flags;
 	int min_size;
 	char status;
@@ -155,28 +147,8 @@ static u32 user_event_key(char *name)
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
@@ -247,19 +219,6 @@ static struct user_event_group
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
 
@@ -271,20 +230,107 @@ static struct user_event_group
 	return NULL;
 };
 
-static __always_inline
-void user_event_register_set(struct user_event *user)
+static void user_event_enabler_destroy(struct user_event_enabler *enabler)
 {
-	int i = user->index;
+	mmdrop(enabler->mm);
+	kfree(enabler);
+}
+
+static void user_event_enabler_remove(struct file *file,
+				      struct user_event *user)
+{
+	struct user_event_enabler *enabler, *next;
+	struct list_head *head = &user->enablers;
+
+	/* Prevent racing with status changes and new events */
+	mutex_lock(&event_mutex);
+
+	list_for_each_entry_safe(enabler, next, head, link) {
+		if (enabler->file != file)
+			continue;
+
+		list_del(&enabler->link);
+		user_event_enabler_destroy(enabler);
+	}
+
+	mutex_unlock(&event_mutex);
+}
+
+static void user_event_enabler_write(struct user_event_enabler *enabler,
+				     struct user_event *user)
+{
+	struct mm_struct *mm = enabler->mm;
+	unsigned long uaddr = enabler->enable_addr;
+	unsigned long *ptr;
+	struct page *page;
+	void *kaddr;
+	int ret;
+
+	mmap_read_lock(mm);
+
+	ret = pin_user_pages_remote(mm, uaddr, 1, FOLL_WRITE | FOLL_NOFAULT,
+				    &page, NULL, NULL);
+
+	mmap_read_unlock(mm);
+
+	if (ret <= 0) {
+		pr_warn("user_events: Enable write failed\n");
+		return;
+	}
+
+	kaddr = kmap_local_page(page);
+	ptr = kaddr + (uaddr & ~PAGE_MASK);
+
+	if (user->status)
+		set_bit(enabler->enable_bit, ptr);
+	else
+		clear_bit(enabler->enable_bit, ptr);
 
-	user->group->register_page_data[MAP_STATUS_BYTE(i)] |= MAP_STATUS_MASK(i);
+	kunmap_local(kaddr);
+	unpin_user_pages_dirty_lock(&page, 1, true);
 }
 
-static __always_inline
-void user_event_register_clear(struct user_event *user)
+static void user_event_enabler_update(struct user_event *user)
 {
-	int i = user->index;
+	struct list_head *head = &user->enablers;
+	struct user_event_enabler *enabler;
 
-	user->group->register_page_data[MAP_STATUS_BYTE(i)] &= ~MAP_STATUS_MASK(i);
+	list_for_each_entry(enabler, head, link)
+		user_event_enabler_write(enabler, user);
+}
+
+static struct user_event_enabler
+*user_event_enabler_create(struct file *file, struct user_reg *reg,
+			   struct user_event *user)
+{
+	struct user_event_enabler *enabler;
+
+	enabler = kzalloc(sizeof(*enabler), GFP_KERNEL);
+
+	if (!enabler)
+		return NULL;
+
+	/*
+	 * This is grabbed for accounting purposes. This is to ensure if a
+	 * process exits before the file is released a valid memory descriptor
+	 * will exist for the enabler.
+	 */
+	mmgrab(current->mm);
+
+	enabler->mm = current->mm;
+	enabler->file = file;
+	enabler->enable_addr = (unsigned long)reg->enable_addr;
+	enabler->enable_bit = reg->enable_bit;
+
+	/* Prevents state changes from racing with new enablers */
+	mutex_lock(&event_mutex);
+
+	list_add(&enabler->link, &user->enablers);
+	user_event_enabler_write(enabler, user);
+
+	mutex_unlock(&event_mutex);
+
+	return enabler;
 }
 
 static __always_inline __must_check
@@ -829,9 +875,6 @@ static int destroy_user_event(struct user_event *user)
 		return ret;
 
 	dyn_event_remove(&user->devent);
-
-	user_event_register_clear(user);
-	clear_bit(user->index, user->group->page_bitmap);
 	hash_del(&user->node);
 
 	user_event_destroy_validators(user);
@@ -977,9 +1020,9 @@ static void user_event_perf(struct user_event *user, struct iov_iter *i,
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
@@ -1010,12 +1053,9 @@ static void update_reg_page_for(struct user_event *user)
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
@@ -1072,10 +1112,10 @@ static int user_event_reg(struct trace_event_call *call,
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
@@ -1269,7 +1309,6 @@ static int user_event_parse(struct user_event_group *group, char *name,
 			    struct user_event **newuser)
 {
 	int ret;
-	int index;
 	u32 key;
 	struct user_event *user;
 
@@ -1288,11 +1327,6 @@ static int user_event_parse(struct user_event_group *group, char *name,
 		return 0;
 	}
 
-	index = find_first_zero_bit(group->page_bitmap, MAX_EVENTS);
-
-	if (index == MAX_EVENTS)
-		return -EMFILE;
-
 	user = kzalloc(sizeof(*user), GFP_KERNEL);
 
 	if (!user)
@@ -1301,6 +1335,7 @@ static int user_event_parse(struct user_event_group *group, char *name,
 	INIT_LIST_HEAD(&user->class.fields);
 	INIT_LIST_HEAD(&user->fields);
 	INIT_LIST_HEAD(&user->validators);
+	INIT_LIST_HEAD(&user->enablers);
 
 	user->group = group;
 	user->tracepoint.name = name;
@@ -1338,14 +1373,11 @@ static int user_event_parse(struct user_event_group *group, char *name,
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
@@ -1561,6 +1593,14 @@ static long user_reg_get(struct user_reg __user *ureg, struct user_reg *kreg)
 	if (ret)
 		return ret;
 
+	/* Ensure natural alignment and sanity check on max bit */
+	if (kreg->enable_addr % sizeof(__u32) || kreg->enable_bit > 31)
+		return -EINVAL;
+
+	/* Ensure accessible */
+	if (!access_ok((const void __user *)kreg->enable_addr, sizeof(__u32)))
+		return -EFAULT;
+
 	kreg->size = size;
 
 	return 0;
@@ -1570,11 +1610,12 @@ static long user_reg_get(struct user_reg __user *ureg, struct user_reg *kreg)
  * Registers a user_event on behalf of a user process.
  */
 static long user_events_ioctl_reg(struct user_event_file_info *info,
-				  unsigned long uarg)
+				  struct file *file, unsigned long uarg)
 {
 	struct user_reg __user *ureg = (struct user_reg __user *)uarg;
 	struct user_reg reg;
 	struct user_event *user;
+	struct user_event_enabler *enabler;
 	char *name;
 	long ret;
 
@@ -1607,8 +1648,12 @@ static long user_events_ioctl_reg(struct user_event_file_info *info,
 	if (ret < 0)
 		return ret;
 
+	enabler = user_event_enabler_create(file, &reg, user);
+
+	if (!enabler)
+		return -ENOMEM;
+
 	put_user((u32)ret, &ureg->write_index);
-	put_user(user->index, &ureg->status_bit);
 
 	return 0;
 }
@@ -1651,7 +1696,7 @@ static long user_events_ioctl(struct file *file, unsigned int cmd,
 	switch (cmd) {
 	case DIAG_IOCSREG:
 		mutex_lock(&group->reg_mutex);
-		ret = user_events_ioctl_reg(info, uarg);
+		ret = user_events_ioctl_reg(info, file, uarg);
 		mutex_unlock(&group->reg_mutex);
 		break;
 
@@ -1700,8 +1745,10 @@ static int user_events_release(struct inode *node, struct file *file)
 	for (i = 0; i < refs->count; ++i) {
 		user = refs->events[i];
 
-		if (user)
+		if (user) {
+			user_event_enabler_remove(file, user);
 			refcount_dec(&user->refcnt);
+		}
 	}
 out:
 	file->private_data = NULL;
@@ -1722,38 +1769,6 @@ static const struct file_operations user_data_fops = {
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
@@ -1788,7 +1803,7 @@ static int user_seq_show(struct seq_file *m, void *p)
 		status = user->status;
 		flags = user->flags;
 
-		seq_printf(m, "%d:%s", user->index, EVENT_NAME(user));
+		seq_printf(m, "%s", EVENT_NAME(user));
 
 		if (flags != 0 || status != 0)
 			seq_puts(m, " #");
@@ -1813,7 +1828,6 @@ static int user_seq_show(struct seq_file *m, void *p)
 	seq_puts(m, "\n");
 	seq_printf(m, "Active: %d\n", active);
 	seq_printf(m, "Busy: %d\n", busy);
-	seq_printf(m, "Max: %ld\n", MAX_EVENTS);
 
 	return 0;
 }
@@ -1849,7 +1863,6 @@ static int user_status_open(struct inode *node, struct file *file)
 
 static const struct file_operations user_status_fops = {
 	.open = user_status_open,
-	.mmap = user_status_mmap,
 	.read = seq_read,
 	.llseek  = seq_lseek,
 	.release = seq_release,
-- 
2.25.1


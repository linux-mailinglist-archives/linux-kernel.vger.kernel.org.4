Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769CF5F16F1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 02:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbiJAAK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 20:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbiJAAKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 20:10:24 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76A795814E;
        Fri, 30 Sep 2022 17:10:21 -0700 (PDT)
Received: from localhost.localdomain (unknown [76.135.50.127])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1558620E0A56;
        Fri, 30 Sep 2022 17:10:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1558620E0A56
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1664583021;
        bh=eDp+/6nhU9aqrvfj7D8qww9fVnDm311AkoZsTuiqNkk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VqIhHsTK/wCqR2MUPQP0mKA1LtAHLEXkK+rsd/wFore7wSEOMG5+wg7lQ0M+oE7sb
         9XRdz2qzBf/gMZfnMDjROUvVfGbzKymOaSqdzAFFHefwY55kSG5Ifd8jOMoNizPTzJ
         fBn+wSnlx4Sp45/AvQ2vPRyg+nIj7wqzqDPZgEMQ=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, brauner@kernel.org,
        stefanb@linux.ibm.com
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] tracing/user_events: Move pages/locks into groups to prepare for namespaces
Date:   Fri, 30 Sep 2022 17:10:16 -0700
Message-Id: <20221001001016.2832-2-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221001001016.2832-1-beaub@linux.microsoft.com>
References: <20221001001016.2832-1-beaub@linux.microsoft.com>
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

In order to enable namespaces or any sort of isolation within
user_events the register lock and pages need to be broken up into
groups. Each event and file now has a group pointer which stores the
actual pages to map, lookup data and synchronization objects.

This only enables a single group that maps to init_user_ns, as IMA
namespace has done. This enables user_events to start the work of
supporting namespaces by walking the namespaces up to the init_user_ns.
Future patches will address other user namespaces and will align to the
approaches the IMA namespace uses.

Link: https://lore.kernel.org/linux-kernel/20220915193221.1728029-15-stefanb@linux.ibm.com/#t

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 kernel/trace/trace_events_user.c | 346 ++++++++++++++++++++++++-------
 1 file changed, 274 insertions(+), 72 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 2c0a6ec75548..ae78c2d53c8a 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -74,11 +74,25 @@
 #define EVENT_STATUS_PERF BIT(1)
 #define EVENT_STATUS_OTHER BIT(7)
 
-static char *register_page_data;
+/*
+ * Stores the pages, tables, and locks for a group of events.
+ * Each logical grouping of events has its own group, with a
+ * matching page for status checks within user programs. This
+ * allows for isolation of events to user programs by various
+ * means.
+ */
+struct user_event_group {
+	struct page *pages;
+	char *register_page_data;
+	char *system_name;
+	struct hlist_node node;
+	struct mutex reg_mutex;
+	DECLARE_HASHTABLE(register_table, 8);
+	DECLARE_BITMAP(page_bitmap, MAX_EVENTS);
+};
 
-static DEFINE_MUTEX(reg_mutex);
-static DEFINE_HASHTABLE(register_table, 8);
-static DECLARE_BITMAP(page_bitmap, MAX_EVENTS);
+/* Group for init_user_ns mapping, top-most group */
+static struct user_event_group *init_group;
 
 /*
  * Stores per-event properties, as users register events
@@ -88,6 +102,7 @@ static DECLARE_BITMAP(page_bitmap, MAX_EVENTS);
  * refcnt reaches one.
  */
 struct user_event {
+	struct user_event_group *group;
 	struct tracepoint tracepoint;
 	struct trace_event_call call;
 	struct trace_event_class class;
@@ -114,6 +129,11 @@ struct user_event_refs {
 	struct user_event *events[];
 };
 
+struct user_event_file_info {
+	struct user_event_group *group;
+	struct user_event_refs *refs;
+};
+
 #define VALIDATOR_ENSURE_NULL (1 << 0)
 #define VALIDATOR_REL (1 << 1)
 
@@ -126,7 +146,8 @@ struct user_event_validator {
 typedef void (*user_event_func_t) (struct user_event *user, struct iov_iter *i,
 				   void *tpdata, bool *faulted);
 
-static int user_event_parse(char *name, char *args, char *flags,
+static int user_event_parse(struct user_event_group *group, char *name,
+			    char *args, char *flags,
 			    struct user_event **newuser);
 
 static u32 user_event_key(char *name)
@@ -134,12 +155,128 @@ static u32 user_event_key(char *name)
 	return jhash(name, strlen(name), 0);
 }
 
+static void set_page_reservations(char *pages, bool set)
+{
+	int page;
+
+	for (page = 0; page < MAX_PAGES; ++page) {
+		void *addr = pages + (PAGE_SIZE * page);
+
+		if (set)
+			SetPageReserved(virt_to_page(addr));
+		else
+			ClearPageReserved(virt_to_page(addr));
+	}
+}
+
+static void user_event_group_destroy(struct user_event_group *group)
+{
+	if (group->register_page_data)
+		set_page_reservations(group->register_page_data, false);
+
+	if (group->pages)
+		__free_pages(group->pages, MAX_PAGE_ORDER);
+
+	kfree(group->system_name);
+	kfree(group);
+}
+
+static char *user_event_group_system_name(struct user_namespace *user_ns)
+{
+	char *system_name;
+	int len = sizeof(USER_EVENTS_SYSTEM) + 1;
+
+	if (user_ns != &init_user_ns) {
+		/*
+		 * Unexpected at this point:
+		 * We only currently support init_user_ns.
+		 * When we enable more, this will trigger a failure so log.
+		 */
+		pr_warn("user_events: Namespace other than init_user_ns!\n");
+		return NULL;
+	}
+
+	system_name = kmalloc(len, GFP_KERNEL);
+
+	if (!system_name)
+		return NULL;
+
+	snprintf(system_name, len, "%s", USER_EVENTS_SYSTEM);
+
+	return system_name;
+}
+
+static inline struct user_event_group
+*user_event_group_from_user_ns(struct user_namespace *user_ns)
+{
+	if (user_ns == &init_user_ns)
+		return init_group;
+
+	return NULL;
+}
+
+static struct user_event_group *current_user_event_group(void)
+{
+	struct user_namespace *user_ns = current_user_ns();
+	struct user_event_group *group = NULL;
+
+	while (user_ns) {
+		group = user_event_group_from_user_ns(user_ns);
+
+		if (group)
+			break;
+
+		user_ns = user_ns->parent;
+	}
+
+	return group;
+}
+
+static struct user_event_group
+*user_event_group_create(struct user_namespace *user_ns)
+{
+	struct user_event_group *group;
+
+	group = kzalloc(sizeof(*group), GFP_KERNEL);
+
+	if (!group)
+		return NULL;
+
+	group->system_name = user_event_group_system_name(user_ns);
+
+	if (!group->system_name)
+		goto error;
+
+	group->pages = alloc_pages(GFP_KERNEL | __GFP_ZERO, MAX_PAGE_ORDER);
+
+	if (!group->pages)
+		goto error;
+
+	group->register_page_data = page_address(group->pages);
+
+	set_page_reservations(group->register_page_data, true);
+
+	/* Zero all bits beside 0 (which is reserved for failures) */
+	bitmap_zero(group->page_bitmap, MAX_EVENTS);
+	set_bit(0, group->page_bitmap);
+
+	mutex_init(&group->reg_mutex);
+	hash_init(group->register_table);
+
+	return group;
+error:
+	if (group)
+		user_event_group_destroy(group);
+
+	return NULL;
+};
+
 static __always_inline
 void user_event_register_set(struct user_event *user)
 {
 	int i = user->index;
 
-	register_page_data[MAP_STATUS_BYTE(i)] |= MAP_STATUS_MASK(i);
+	user->group->register_page_data[MAP_STATUS_BYTE(i)] |= MAP_STATUS_MASK(i);
 }
 
 static __always_inline
@@ -147,7 +284,7 @@ void user_event_register_clear(struct user_event *user)
 {
 	int i = user->index;
 
-	register_page_data[MAP_STATUS_BYTE(i)] &= ~MAP_STATUS_MASK(i);
+	user->group->register_page_data[MAP_STATUS_BYTE(i)] &= ~MAP_STATUS_MASK(i);
 }
 
 static __always_inline __must_check
@@ -191,7 +328,8 @@ static struct list_head *user_event_get_fields(struct trace_event_call *call)
  *
  * Upon success user_event has its ref count increased by 1.
  */
-static int user_event_parse_cmd(char *raw_command, struct user_event **newuser)
+static int user_event_parse_cmd(struct user_event_group *group,
+				char *raw_command, struct user_event **newuser)
 {
 	char *name = raw_command;
 	char *args = strpbrk(name, " ");
@@ -205,7 +343,7 @@ static int user_event_parse_cmd(char *raw_command, struct user_event **newuser)
 	if (flags)
 		*flags++ = '\0';
 
-	return user_event_parse(name, args, flags, newuser);
+	return user_event_parse(group, name, args, flags, newuser);
 }
 
 static int user_field_array_size(const char *type)
@@ -693,7 +831,7 @@ static int destroy_user_event(struct user_event *user)
 	dyn_event_remove(&user->devent);
 
 	user_event_register_clear(user);
-	clear_bit(user->index, page_bitmap);
+	clear_bit(user->index, user->group->page_bitmap);
 	hash_del(&user->node);
 
 	user_event_destroy_validators(user);
@@ -704,14 +842,15 @@ static int destroy_user_event(struct user_event *user)
 	return ret;
 }
 
-static struct user_event *find_user_event(char *name, u32 *outkey)
+static struct user_event *find_user_event(struct user_event_group *group,
+					  char *name, u32 *outkey)
 {
 	struct user_event *user;
 	u32 key = user_event_key(name);
 
 	*outkey = key;
 
-	hash_for_each_possible(register_table, user, node, key)
+	hash_for_each_possible(group->register_table, user, node, key)
 		if (!strcmp(EVENT_NAME(user), name)) {
 			refcount_inc(&user->refcnt);
 			return user;
@@ -943,6 +1082,7 @@ static int user_event_reg(struct trace_event_call *call,
 
 static int user_event_create(const char *raw_command)
 {
+	struct user_event_group *group;
 	struct user_event *user;
 	char *name;
 	int ret;
@@ -958,14 +1098,19 @@ static int user_event_create(const char *raw_command)
 	if (!name)
 		return -ENOMEM;
 
-	mutex_lock(&reg_mutex);
+	group = current_user_event_group();
+
+	if (!group)
+		return -ENOENT;
+
+	mutex_lock(&group->reg_mutex);
 
-	ret = user_event_parse_cmd(name, &user);
+	ret = user_event_parse_cmd(group, name, &user);
 
 	if (!ret)
 		refcount_dec(&user->refcnt);
 
-	mutex_unlock(&reg_mutex);
+	mutex_unlock(&group->reg_mutex);
 
 	if (ret)
 		kfree(name);
@@ -1119,7 +1264,8 @@ static int user_event_trace_register(struct user_event *user)
  * The name buffer lifetime is owned by this method for success cases only.
  * Upon success the returned user_event has its ref count increased by 1.
  */
-static int user_event_parse(char *name, char *args, char *flags,
+static int user_event_parse(struct user_event_group *group, char *name,
+			    char *args, char *flags,
 			    struct user_event **newuser)
 {
 	int ret;
@@ -1129,7 +1275,7 @@ static int user_event_parse(char *name, char *args, char *flags,
 
 	/* Prevent dyn_event from racing */
 	mutex_lock(&event_mutex);
-	user = find_user_event(name, &key);
+	user = find_user_event(group, name, &key);
 	mutex_unlock(&event_mutex);
 
 	if (user) {
@@ -1142,7 +1288,7 @@ static int user_event_parse(char *name, char *args, char *flags,
 		return 0;
 	}
 
-	index = find_first_zero_bit(page_bitmap, MAX_EVENTS);
+	index = find_first_zero_bit(group->page_bitmap, MAX_EVENTS);
 
 	if (index == MAX_EVENTS)
 		return -EMFILE;
@@ -1156,6 +1302,7 @@ static int user_event_parse(char *name, char *args, char *flags,
 	INIT_LIST_HEAD(&user->fields);
 	INIT_LIST_HEAD(&user->validators);
 
+	user->group = group;
 	user->tracepoint.name = name;
 
 	ret = user_event_parse_fields(user, args);
@@ -1174,8 +1321,8 @@ static int user_event_parse(char *name, char *args, char *flags,
 	user->call.flags = TRACE_EVENT_FL_TRACEPOINT;
 	user->call.tp = &user->tracepoint;
 	user->call.event.funcs = &user_event_funcs;
+	user->class.system = group->system_name;
 
-	user->class.system = USER_EVENTS_SYSTEM;
 	user->class.fields_array = user_event_fields_array;
 	user->class.get_fields = user_event_get_fields;
 	user->class.reg = user_event_reg;
@@ -1198,8 +1345,8 @@ static int user_event_parse(char *name, char *args, char *flags,
 
 	dyn_event_init(&user->devent, &user_event_dops);
 	dyn_event_add(&user->devent, &user->call);
-	set_bit(user->index, page_bitmap);
-	hash_add(register_table, &user->node, key);
+	set_bit(user->index, group->page_bitmap);
+	hash_add(group->register_table, &user->node, key);
 
 	mutex_unlock(&event_mutex);
 
@@ -1217,10 +1364,10 @@ static int user_event_parse(char *name, char *args, char *flags,
 /*
  * Deletes a previously created event if it is no longer being used.
  */
-static int delete_user_event(char *name)
+static int delete_user_event(struct user_event_group *group, char *name)
 {
 	u32 key;
-	struct user_event *user = find_user_event(name, &key);
+	struct user_event *user = find_user_event(group, name, &key);
 
 	if (!user)
 		return -ENOENT;
@@ -1238,6 +1385,7 @@ static int delete_user_event(char *name)
  */
 static ssize_t user_events_write_core(struct file *file, struct iov_iter *i)
 {
+	struct user_event_file_info *info = file->private_data;
 	struct user_event_refs *refs;
 	struct user_event *user = NULL;
 	struct tracepoint *tp;
@@ -1249,7 +1397,7 @@ static ssize_t user_events_write_core(struct file *file, struct iov_iter *i)
 
 	rcu_read_lock_sched();
 
-	refs = rcu_dereference_sched(file->private_data);
+	refs = rcu_dereference_sched(info->refs);
 
 	/*
 	 * The refs->events array is protected by RCU, and new items may be
@@ -1307,6 +1455,28 @@ static ssize_t user_events_write_core(struct file *file, struct iov_iter *i)
 	return ret;
 }
 
+static int user_events_open(struct inode *node, struct file *file)
+{
+	struct user_event_group *group;
+	struct user_event_file_info *info;
+
+	group = current_user_event_group();
+
+	if (!group)
+		return -ENOENT;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+
+	if (!info)
+		return -ENOMEM;
+
+	info->group = group;
+
+	file->private_data = info;
+
+	return 0;
+}
+
 static ssize_t user_events_write(struct file *file, const char __user *ubuf,
 				 size_t count, loff_t *ppos)
 {
@@ -1328,13 +1498,15 @@ static ssize_t user_events_write_iter(struct kiocb *kp, struct iov_iter *i)
 	return user_events_write_core(kp->ki_filp, i);
 }
 
-static int user_events_ref_add(struct file *file, struct user_event *user)
+static int user_events_ref_add(struct user_event_file_info *info,
+			       struct user_event *user)
 {
+	struct user_event_group *group = info->group;
 	struct user_event_refs *refs, *new_refs;
 	int i, size, count = 0;
 
-	refs = rcu_dereference_protected(file->private_data,
-					 lockdep_is_held(&reg_mutex));
+	refs = rcu_dereference_protected(info->refs,
+					 lockdep_is_held(&group->reg_mutex));
 
 	if (refs) {
 		count = refs->count;
@@ -1360,7 +1532,7 @@ static int user_events_ref_add(struct file *file, struct user_event *user)
 
 	refcount_inc(&user->refcnt);
 
-	rcu_assign_pointer(file->private_data, new_refs);
+	rcu_assign_pointer(info->refs, new_refs);
 
 	if (refs)
 		kfree_rcu(refs, rcu);
@@ -1397,7 +1569,8 @@ static long user_reg_get(struct user_reg __user *ureg, struct user_reg *kreg)
 /*
  * Registers a user_event on behalf of a user process.
  */
-static long user_events_ioctl_reg(struct file *file, unsigned long uarg)
+static long user_events_ioctl_reg(struct user_event_file_info *info,
+				  unsigned long uarg)
 {
 	struct user_reg __user *ureg = (struct user_reg __user *)uarg;
 	struct user_reg reg;
@@ -1418,14 +1591,14 @@ static long user_events_ioctl_reg(struct file *file, unsigned long uarg)
 		return ret;
 	}
 
-	ret = user_event_parse_cmd(name, &user);
+	ret = user_event_parse_cmd(info->group, name, &user);
 
 	if (ret) {
 		kfree(name);
 		return ret;
 	}
 
-	ret = user_events_ref_add(file, user);
+	ret = user_events_ref_add(info, user);
 
 	/* No longer need parse ref, ref_add either worked or not */
 	refcount_dec(&user->refcnt);
@@ -1443,7 +1616,8 @@ static long user_events_ioctl_reg(struct file *file, unsigned long uarg)
 /*
  * Deletes a user_event on behalf of a user process.
  */
-static long user_events_ioctl_del(struct file *file, unsigned long uarg)
+static long user_events_ioctl_del(struct user_event_file_info *info,
+				  unsigned long uarg)
 {
 	void __user *ubuf = (void __user *)uarg;
 	char *name;
@@ -1456,7 +1630,7 @@ static long user_events_ioctl_del(struct file *file, unsigned long uarg)
 
 	/* event_mutex prevents dyn_event from racing */
 	mutex_lock(&event_mutex);
-	ret = delete_user_event(name);
+	ret = delete_user_event(info->group, name);
 	mutex_unlock(&event_mutex);
 
 	kfree(name);
@@ -1470,19 +1644,21 @@ static long user_events_ioctl_del(struct file *file, unsigned long uarg)
 static long user_events_ioctl(struct file *file, unsigned int cmd,
 			      unsigned long uarg)
 {
+	struct user_event_file_info *info = file->private_data;
+	struct user_event_group *group = info->group;
 	long ret = -ENOTTY;
 
 	switch (cmd) {
 	case DIAG_IOCSREG:
-		mutex_lock(&reg_mutex);
-		ret = user_events_ioctl_reg(file, uarg);
-		mutex_unlock(&reg_mutex);
+		mutex_lock(&group->reg_mutex);
+		ret = user_events_ioctl_reg(info, uarg);
+		mutex_unlock(&group->reg_mutex);
 		break;
 
 	case DIAG_IOCSDEL:
-		mutex_lock(&reg_mutex);
-		ret = user_events_ioctl_del(file, uarg);
-		mutex_unlock(&reg_mutex);
+		mutex_lock(&group->reg_mutex);
+		ret = user_events_ioctl_del(info, uarg);
+		mutex_unlock(&group->reg_mutex);
 		break;
 	}
 
@@ -1494,17 +1670,24 @@ static long user_events_ioctl(struct file *file, unsigned int cmd,
  */
 static int user_events_release(struct inode *node, struct file *file)
 {
+	struct user_event_file_info *info = file->private_data;
+	struct user_event_group *group;
 	struct user_event_refs *refs;
 	struct user_event *user;
 	int i;
 
+	if (!info)
+		return -EINVAL;
+
+	group = info->group;
+
 	/*
 	 * Ensure refs cannot change under any situation by taking the
 	 * register mutex during the final freeing of the references.
 	 */
-	mutex_lock(&reg_mutex);
+	mutex_lock(&group->reg_mutex);
 
-	refs = file->private_data;
+	refs = info->refs;
 
 	if (!refs)
 		goto out;
@@ -1523,32 +1706,51 @@ static int user_events_release(struct inode *node, struct file *file)
 out:
 	file->private_data = NULL;
 
-	mutex_unlock(&reg_mutex);
+	mutex_unlock(&group->reg_mutex);
 
 	kfree(refs);
+	kfree(info);
 
 	return 0;
 }
 
 static const struct file_operations user_data_fops = {
+	.open = user_events_open,
 	.write = user_events_write,
 	.write_iter = user_events_write_iter,
 	.unlocked_ioctl	= user_events_ioctl,
 	.release = user_events_release,
 };
 
+static struct user_event_group *user_status_group(struct file *file)
+{
+	struct seq_file *m = file->private_data;
+
+	if (!m)
+		return NULL;
+
+	return m->private;
+}
+
 /*
  * Maps the shared page into the user process for checking if event is enabled.
  */
 static int user_status_mmap(struct file *file, struct vm_area_struct *vma)
 {
+	char *pages;
+	struct user_event_group *group = user_status_group(file);
 	unsigned long size = vma->vm_end - vma->vm_start;
 
 	if (size != MAX_BYTES)
 		return -EINVAL;
 
+	if (!group)
+		return -EINVAL;
+
+	pages = group->register_page_data;
+
 	return remap_pfn_range(vma, vma->vm_start,
-			       virt_to_phys(register_page_data) >> PAGE_SHIFT,
+			       virt_to_phys(pages) >> PAGE_SHIFT,
 			       size, vm_get_page_prot(VM_READ));
 }
 
@@ -1572,13 +1774,17 @@ static void user_seq_stop(struct seq_file *m, void *p)
 
 static int user_seq_show(struct seq_file *m, void *p)
 {
+	struct user_event_group *group = m->private;
 	struct user_event *user;
 	char status;
 	int i, active = 0, busy = 0, flags;
 
-	mutex_lock(&reg_mutex);
+	if (!group)
+		return -EINVAL;
+
+	mutex_lock(&group->reg_mutex);
 
-	hash_for_each(register_table, i, user, node) {
+	hash_for_each(group->register_table, i, user, node) {
 		status = user->status;
 		flags = user->flags;
 
@@ -1602,7 +1808,7 @@ static int user_seq_show(struct seq_file *m, void *p)
 		active++;
 	}
 
-	mutex_unlock(&reg_mutex);
+	mutex_unlock(&group->reg_mutex);
 
 	seq_puts(m, "\n");
 	seq_printf(m, "Active: %d\n", active);
@@ -1621,7 +1827,24 @@ static const struct seq_operations user_seq_ops = {
 
 static int user_status_open(struct inode *node, struct file *file)
 {
-	return seq_open(file, &user_seq_ops);
+	struct user_event_group *group;
+	int ret;
+
+	group = current_user_event_group();
+
+	if (!group)
+		return -ENOENT;
+
+	ret = seq_open(file, &user_seq_ops);
+
+	if (!ret) {
+		/* Chain group to seq_file */
+		struct seq_file *m = file->private_data;
+
+		m->private = group;
+	}
+
+	return ret;
 }
 
 static const struct file_operations user_status_fops = {
@@ -1662,42 +1885,21 @@ static int create_user_tracefs(void)
 	return -ENODEV;
 }
 
-static void set_page_reservations(bool set)
-{
-	int page;
-
-	for (page = 0; page < MAX_PAGES; ++page) {
-		void *addr = register_page_data + (PAGE_SIZE * page);
-
-		if (set)
-			SetPageReserved(virt_to_page(addr));
-		else
-			ClearPageReserved(virt_to_page(addr));
-	}
-}
-
 static int __init trace_events_user_init(void)
 {
-	struct page *pages;
 	int ret;
 
-	/* Zero all bits beside 0 (which is reserved for failures) */
-	bitmap_zero(page_bitmap, MAX_EVENTS);
-	set_bit(0, page_bitmap);
+	init_group = user_event_group_create(&init_user_ns);
 
-	pages = alloc_pages(GFP_KERNEL | __GFP_ZERO, MAX_PAGE_ORDER);
-	if (!pages)
+	if (!init_group)
 		return -ENOMEM;
-	register_page_data = page_address(pages);
-
-	set_page_reservations(true);
 
 	ret = create_user_tracefs();
 
 	if (ret) {
 		pr_warn("user_events could not register with tracefs\n");
-		set_page_reservations(false);
-		__free_pages(pages, MAX_PAGE_ORDER);
+		user_event_group_destroy(init_group);
+		init_group = NULL;
 		return ret;
 	}
 
-- 
2.25.1


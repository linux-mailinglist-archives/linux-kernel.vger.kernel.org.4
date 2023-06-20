Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82889736D7D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 15:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbjFTNhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 09:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbjFTNhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:37:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD551B6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 06:37:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1B6B61236
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 13:37:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B076C433C0;
        Tue, 20 Jun 2023 13:37:17 +0000 (UTC)
Date:   Tue, 20 Jun 2023 09:37:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        sunliming <sunliming@kylinos.cn>
Subject: [ GIT PULL ] tracing: Updates for 6.4
Message-ID: <20230620093714.7d683259@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Tracing fixes for 6.4:

 - Fix MAINTAINERS file to point to proper mailing list for rtla and rv
    The mailing list pointed to linux-trace-devel instead of
    linux-trace-kernel. The former is for the tracing libraries
    and the latter is for anything in the Linux kernel tree.
    The wrong mailing list was used because linux-trace-kernel did not
    exist when rtla and rv were created.

 - User events:
   . Fix matching of dynamic events to their user events
     When user writes to dynamic_events file, a lookup of the
     registered dynamic events are made, but there were some cases
     that a match could be incorrectly made.

   . Add auto cleanup of user events
     Have the user events automatically get removed when the last
     reference (file descriptor) is closed. This was asked for to
     prevent leaks of user events hanging around needing admins
     to clean them up.

   . Add persistent logic (but not let user space use it yet)
     In some cases, having a persistent user event (one that does not
     get cleaned up automatically) is useful. But there's still
     debates about how to expose this to user space. The infrastructure
     is added, but the API is not.

   . Update the selftests
     Update the user event selftests to reflect the above changes.


Please pull the latest trace-v6.4-rc6 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.4-rc6

Tag SHA1: 988f3e958db1ca366d0132c8264c9c1cf063f3e8
Head SHA1: 0113d4615dbf053ae9a7a1e0acbc6652713af01f


Beau Belgrave (7):
      tracing/user_events: Remove user_ns walk for groups
      tracing/user_events: Store register flags on events
      tracing/user_events: Track refcount consistently via put/get
      tracing/user_events: Add auto cleanup and future persist flag
      selftests/user_events: Ensure auto cleanup works as expected
      selftests/user_events: Adapt dyn_test to non-persist events
      tracing/user_events: Document auto-cleanup and remove dyn_event refs

Steven Rostedt (Google) (1):
      tracing/rv/rtla: Update MAINTAINERS file to point to proper mailing list

sunliming (7):
      tracing/user_events: Prevent same name but different args event
      tracing/user_events: Handle matching arguments that is null from dyn_events
      tracing: Modify print_fields() for fields output order
      tracing/user_events: Fix the incorrect trace record for empty arguments events
      selftests/user_events: Add ftrace self-test for empty arguments events
      selftests/user_events: Clear the events after perf self-test
      selftests/user_events: Add perf self-test for empty arguments events

----
 Documentation/trace/user_events.rst               |   7 +-
 MAINTAINERS                                       |   4 +-
 kernel/trace/trace_events_user.c                  | 290 +++++++++++++++-------
 kernel/trace/trace_output.c                       |   2 +-
 tools/testing/selftests/user_events/dyn_test.c    | 177 ++++++++++---
 tools/testing/selftests/user_events/ftrace_test.c |  88 ++++++-
 tools/testing/selftests/user_events/perf_test.c   |  82 ++++++
 7 files changed, 508 insertions(+), 142 deletions(-)
---------------------------
diff --git a/Documentation/trace/user_events.rst b/Documentation/trace/user_events.rst
index f79987e16cf4..e7b07313550a 100644
--- a/Documentation/trace/user_events.rst
+++ b/Documentation/trace/user_events.rst
@@ -14,10 +14,6 @@ Programs can view status of the events via
 /sys/kernel/tracing/user_events_status and can both register and write
 data out via /sys/kernel/tracing/user_events_data.
 
-Programs can also use /sys/kernel/tracing/dynamic_events to register and
-delete user based events via the u: prefix. The format of the command to
-dynamic_events is the same as the ioctl with the u: prefix applied.
-
 Typically programs will register a set of events that they wish to expose to
 tools that can read trace_events (such as ftrace and perf). The registration
 process tells the kernel which address and bit to reflect if any tool has
@@ -144,6 +140,9 @@ its name. Delete will only succeed if there are no references left to the
 event (in both user and kernel space). User programs should use a separate file
 to request deletes than the one used for registration due to this.
 
+**NOTE:** By default events will auto-delete when there are no references left
+to the event. Flags in the future may change this logic.
+
 Unregistering
 -------------
 If after registering an event it is no longer wanted to be updated then it can
diff --git a/MAINTAINERS b/MAINTAINERS
index 27ef11624748..725d35b5d328 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17806,7 +17806,7 @@ F:	tools/testing/selftests/rtc/
 Real-time Linux Analysis (RTLA) tools
 M:	Daniel Bristot de Oliveira <bristot@kernel.org>
 M:	Steven Rostedt <rostedt@goodmis.org>
-L:	linux-trace-devel@vger.kernel.org
+L:	linux-trace-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/tools/rtla/
 F:	tools/tracing/rtla/
@@ -18368,7 +18368,7 @@ F:	drivers/infiniband/ulp/rtrs/
 RUNTIME VERIFICATION (RV)
 M:	Daniel Bristot de Oliveira <bristot@kernel.org>
 M:	Steven Rostedt <rostedt@goodmis.org>
-L:	linux-trace-devel@vger.kernel.org
+L:	linux-trace-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/trace/rv/
 F:	include/linux/rv.h
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index dbb14705d0d3..8df0550415e7 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -49,6 +49,18 @@
 #define EVENT_STATUS_PERF BIT(1)
 #define EVENT_STATUS_OTHER BIT(7)
 
+/*
+ * User register flags are not allowed yet, keep them here until we are
+ * ready to expose them out to the user ABI.
+ */
+enum user_reg_flag {
+	/* Event will not delete upon last reference closing */
+	USER_EVENT_REG_PERSIST		= 1U << 0,
+
+	/* This value or above is currently non-ABI */
+	USER_EVENT_REG_MAX		= 1U << 1,
+};
+
 /*
  * Stores the system name, tables, and locks for a group of events. This
  * allows isolation for events by various means.
@@ -85,8 +97,10 @@ struct user_event {
 	struct hlist_node		node;
 	struct list_head		fields;
 	struct list_head		validators;
+	struct work_struct		put_work;
 	refcount_t			refcnt;
 	int				min_size;
+	int				reg_flags;
 	char				status;
 };
 
@@ -165,76 +179,151 @@ typedef void (*user_event_func_t) (struct user_event *user, struct iov_iter *i,
 
 static int user_event_parse(struct user_event_group *group, char *name,
 			    char *args, char *flags,
-			    struct user_event **newuser);
+			    struct user_event **newuser, int reg_flags);
 
 static struct user_event_mm *user_event_mm_get(struct user_event_mm *mm);
 static struct user_event_mm *user_event_mm_get_all(struct user_event *user);
 static void user_event_mm_put(struct user_event_mm *mm);
+static int destroy_user_event(struct user_event *user);
 
 static u32 user_event_key(char *name)
 {
 	return jhash(name, strlen(name), 0);
 }
 
-static void user_event_group_destroy(struct user_event_group *group)
+static struct user_event *user_event_get(struct user_event *user)
 {
-	kfree(group->system_name);
-	kfree(group);
+	refcount_inc(&user->refcnt);
+
+	return user;
 }
 
-static char *user_event_group_system_name(struct user_namespace *user_ns)
+static void delayed_destroy_user_event(struct work_struct *work)
 {
-	char *system_name;
-	int len = sizeof(USER_EVENTS_SYSTEM) + 1;
+	struct user_event *user = container_of(
+		work, struct user_event, put_work);
 
-	if (user_ns != &init_user_ns) {
+	mutex_lock(&event_mutex);
+
+	if (!refcount_dec_and_test(&user->refcnt))
+		goto out;
+
+	if (destroy_user_event(user)) {
 		/*
-		 * Unexpected at this point:
-		 * We only currently support init_user_ns.
-		 * When we enable more, this will trigger a failure so log.
+		 * The only reason this would fail here is if we cannot
+		 * update the visibility of the event. In this case the
+		 * event stays in the hashtable, waiting for someone to
+		 * attempt to delete it later.
 		 */
-		pr_warn("user_events: Namespace other than init_user_ns!\n");
-		return NULL;
+		pr_warn("user_events: Unable to delete event\n");
+		refcount_set(&user->refcnt, 1);
 	}
+out:
+	mutex_unlock(&event_mutex);
+}
 
-	system_name = kmalloc(len, GFP_KERNEL);
+static void user_event_put(struct user_event *user, bool locked)
+{
+	bool delete;
 
-	if (!system_name)
-		return NULL;
+	if (unlikely(!user))
+		return;
 
-	snprintf(system_name, len, "%s", USER_EVENTS_SYSTEM);
+	/*
+	 * When the event is not enabled for auto-delete there will always
+	 * be at least 1 reference to the event. During the event creation
+	 * we initially set the refcnt to 2 to achieve this. In those cases
+	 * the caller must acquire event_mutex and after decrement check if
+	 * the refcnt is 1, meaning this is the last reference. When auto
+	 * delete is enabled, there will only be 1 ref, IE: refcnt will be
+	 * only set to 1 during creation to allow the below checks to go
+	 * through upon the last put. The last put must always be done with
+	 * the event mutex held.
+	 */
+	if (!locked) {
+		lockdep_assert_not_held(&event_mutex);
+		delete = refcount_dec_and_mutex_lock(&user->refcnt, &event_mutex);
+	} else {
+		lockdep_assert_held(&event_mutex);
+		delete = refcount_dec_and_test(&user->refcnt);
+	}
 
-	return system_name;
+	if (!delete)
+		return;
+
+	/*
+	 * We now have the event_mutex in all cases, which ensures that
+	 * no new references will be taken until event_mutex is released.
+	 * New references come through find_user_event(), which requires
+	 * the event_mutex to be held.
+	 */
+
+	if (user->reg_flags & USER_EVENT_REG_PERSIST) {
+		/* We should not get here when persist flag is set */
+		pr_alert("BUG: Auto-delete engaged on persistent event\n");
+		goto out;
+	}
+
+	/*
+	 * Unfortunately we have to attempt the actual destroy in a work
+	 * queue. This is because not all cases handle a trace_event_call
+	 * being removed within the class->reg() operation for unregister.
+	 */
+	INIT_WORK(&user->put_work, delayed_destroy_user_event);
+
+	/*
+	 * Since the event is still in the hashtable, we have to re-inc
+	 * the ref count to 1. This count will be decremented and checked
+	 * in the work queue to ensure it's still the last ref. This is
+	 * needed because a user-process could register the same event in
+	 * between the time of event_mutex release and the work queue
+	 * running the delayed destroy. If we removed the item now from
+	 * the hashtable, this would result in a timing window where a
+	 * user process would fail a register because the trace_event_call
+	 * register would fail in the tracing layers.
+	 */
+	refcount_set(&user->refcnt, 1);
+
+	if (WARN_ON_ONCE(!schedule_work(&user->put_work))) {
+		/*
+		 * If we fail we must wait for an admin to attempt delete or
+		 * another register/close of the event, whichever is first.
+		 */
+		pr_warn("user_events: Unable to queue delayed destroy\n");
+	}
+out:
+	/* Ensure if we didn't have event_mutex before we unlock it */
+	if (!locked)
+		mutex_unlock(&event_mutex);
 }
 
-static inline struct user_event_group
-*user_event_group_from_user_ns(struct user_namespace *user_ns)
+static void user_event_group_destroy(struct user_event_group *group)
 {
-	if (user_ns == &init_user_ns)
-		return init_group;
-
-	return NULL;
+	kfree(group->system_name);
+	kfree(group);
 }
 
-static struct user_event_group *current_user_event_group(void)
+static char *user_event_group_system_name(void)
 {
-	struct user_namespace *user_ns = current_user_ns();
-	struct user_event_group *group = NULL;
+	char *system_name;
+	int len = sizeof(USER_EVENTS_SYSTEM) + 1;
 
-	while (user_ns) {
-		group = user_event_group_from_user_ns(user_ns);
+	system_name = kmalloc(len, GFP_KERNEL);
 
-		if (group)
-			break;
+	if (!system_name)
+		return NULL;
 
-		user_ns = user_ns->parent;
-	}
+	snprintf(system_name, len, "%s", USER_EVENTS_SYSTEM);
 
-	return group;
+	return system_name;
 }
 
-static struct user_event_group
-*user_event_group_create(struct user_namespace *user_ns)
+static struct user_event_group *current_user_event_group(void)
+{
+	return init_group;
+}
+
+static struct user_event_group *user_event_group_create(void)
 {
 	struct user_event_group *group;
 
@@ -243,7 +332,7 @@ static struct user_event_group
 	if (!group)
 		return NULL;
 
-	group->system_name = user_event_group_system_name(user_ns);
+	group->system_name = user_event_group_system_name();
 
 	if (!group->system_name)
 		goto error;
@@ -259,12 +348,13 @@ static struct user_event_group
 	return NULL;
 };
 
-static void user_event_enabler_destroy(struct user_event_enabler *enabler)
+static void user_event_enabler_destroy(struct user_event_enabler *enabler,
+				       bool locked)
 {
 	list_del_rcu(&enabler->mm_enablers_link);
 
 	/* No longer tracking the event via the enabler */
-	refcount_dec(&enabler->event->refcnt);
+	user_event_put(enabler->event, locked);
 
 	kfree(enabler);
 }
@@ -326,7 +416,7 @@ static void user_event_enabler_fault_fixup(struct work_struct *work)
 
 	/* User asked for enabler to be removed during fault */
 	if (test_bit(ENABLE_VAL_FREEING_BIT, ENABLE_BITOPS(enabler))) {
-		user_event_enabler_destroy(enabler);
+		user_event_enabler_destroy(enabler, true);
 		goto out;
 	}
 
@@ -501,14 +591,12 @@ static bool user_event_enabler_dup(struct user_event_enabler *orig,
 	if (!enabler)
 		return false;
 
-	enabler->event = orig->event;
+	enabler->event = user_event_get(orig->event);
 	enabler->addr = orig->addr;
 
 	/* Only dup part of value (ignore future flags, etc) */
 	enabler->values = orig->values & ENABLE_VAL_DUP_MASK;
 
-	refcount_inc(&enabler->event->refcnt);
-
 	/* Enablers not exposed yet, RCU not required */
 	list_add(&enabler->mm_enablers_link, &mm->enablers);
 
@@ -625,7 +713,7 @@ static void user_event_mm_destroy(struct user_event_mm *mm)
 	struct user_event_enabler *enabler, *next;
 
 	list_for_each_entry_safe(enabler, next, &mm->enablers, mm_enablers_link)
-		user_event_enabler_destroy(enabler);
+		user_event_enabler_destroy(enabler, false);
 
 	mmdrop(mm->mm);
 	kfree(mm);
@@ -780,7 +868,7 @@ static struct user_event_enabler
 	 * exit or run exec(), which includes forks and clones.
 	 */
 	if (!*write_result) {
-		refcount_inc(&enabler->event->refcnt);
+		user_event_get(user);
 		list_add_rcu(&enabler->mm_enablers_link, &user_mm->enablers);
 	}
 
@@ -803,7 +891,12 @@ static struct user_event_enabler
 static __always_inline __must_check
 bool user_event_last_ref(struct user_event *user)
 {
-	return refcount_read(&user->refcnt) == 1;
+	int last = 0;
+
+	if (user->reg_flags & USER_EVENT_REG_PERSIST)
+		last = 1;
+
+	return refcount_read(&user->refcnt) == last;
 }
 
 static __always_inline __must_check
@@ -842,7 +935,8 @@ static struct list_head *user_event_get_fields(struct trace_event_call *call)
  * Upon success user_event has its ref count increased by 1.
  */
 static int user_event_parse_cmd(struct user_event_group *group,
-				char *raw_command, struct user_event **newuser)
+				char *raw_command, struct user_event **newuser,
+				int reg_flags)
 {
 	char *name = raw_command;
 	char *args = strpbrk(name, " ");
@@ -856,7 +950,7 @@ static int user_event_parse_cmd(struct user_event_group *group,
 	if (flags)
 		*flags++ = '\0';
 
-	return user_event_parse(group, name, args, flags, newuser);
+	return user_event_parse(group, name, args, flags, newuser, reg_flags);
 }
 
 static int user_field_array_size(const char *type)
@@ -1367,10 +1461,8 @@ static struct user_event *find_user_event(struct user_event_group *group,
 	*outkey = key;
 
 	hash_for_each_possible(group->register_table, user, node, key)
-		if (!strcmp(EVENT_NAME(user), name)) {
-			refcount_inc(&user->refcnt);
-			return user;
-		}
+		if (!strcmp(EVENT_NAME(user), name))
+			return user_event_get(user);
 
 	return NULL;
 }
@@ -1432,7 +1524,7 @@ static void user_event_ftrace(struct user_event *user, struct iov_iter *i,
 	if (unlikely(!entry))
 		return;
 
-	if (unlikely(!copy_nofault(entry + 1, i->count, i)))
+	if (unlikely(i->count != 0 && !copy_nofault(entry + 1, i->count, i)))
 		goto discard;
 
 	if (!list_empty(&user->validators) &&
@@ -1473,7 +1565,7 @@ static void user_event_perf(struct user_event *user, struct iov_iter *i,
 
 		perf_fetch_caller_regs(regs);
 
-		if (unlikely(!copy_nofault(perf_entry + 1, i->count, i)))
+		if (unlikely(i->count != 0 && !copy_nofault(perf_entry + 1, i->count, i)))
 			goto discard;
 
 		if (!list_empty(&user->validators) &&
@@ -1584,12 +1676,12 @@ static int user_event_reg(struct trace_event_call *call,
 
 	return ret;
 inc:
-	refcount_inc(&user->refcnt);
+	user_event_get(user);
 	update_enable_bit_for(user);
 	return 0;
 dec:
 	update_enable_bit_for(user);
-	refcount_dec(&user->refcnt);
+	user_event_put(user, true);
 	return 0;
 }
 
@@ -1620,10 +1712,11 @@ static int user_event_create(const char *raw_command)
 
 	mutex_lock(&group->reg_mutex);
 
-	ret = user_event_parse_cmd(group, name, &user);
+	/* Dyn events persist, otherwise they would cleanup immediately */
+	ret = user_event_parse_cmd(group, name, &user, USER_EVENT_REG_PERSIST);
 
 	if (!ret)
-		refcount_dec(&user->refcnt);
+		user_event_put(user, false);
 
 	mutex_unlock(&group->reg_mutex);
 
@@ -1745,6 +1838,8 @@ static bool user_event_match(const char *system, const char *event,
 
 	if (match && argc > 0)
 		match = user_fields_match(user, argc, argv);
+	else if (match && argc == 0)
+		match = list_empty(&user->fields);
 
 	return match;
 }
@@ -1781,11 +1876,17 @@ static int user_event_trace_register(struct user_event *user)
  */
 static int user_event_parse(struct user_event_group *group, char *name,
 			    char *args, char *flags,
-			    struct user_event **newuser)
+			    struct user_event **newuser, int reg_flags)
 {
 	int ret;
 	u32 key;
 	struct user_event *user;
+	int argc = 0;
+	char **argv;
+
+	/* User register flags are not ready yet */
+	if (reg_flags != 0 || flags != NULL)
+		return -EINVAL;
 
 	/* Prevent dyn_event from racing */
 	mutex_lock(&event_mutex);
@@ -1793,13 +1894,35 @@ static int user_event_parse(struct user_event_group *group, char *name,
 	mutex_unlock(&event_mutex);
 
 	if (user) {
-		*newuser = user;
-		/*
-		 * Name is allocated by caller, free it since it already exists.
-		 * Caller only worries about failure cases for freeing.
-		 */
-		kfree(name);
+		if (args) {
+			argv = argv_split(GFP_KERNEL, args, &argc);
+			if (!argv) {
+				ret = -ENOMEM;
+				goto error;
+			}
+
+			ret = user_fields_match(user, argc, (const char **)argv);
+			argv_free(argv);
+
+		} else
+			ret = list_empty(&user->fields);
+
+		if (ret) {
+			*newuser = user;
+			/*
+			 * Name is allocated by caller, free it since it already exists.
+			 * Caller only worries about failure cases for freeing.
+			 */
+			kfree(name);
+		} else {
+			ret = -EADDRINUSE;
+			goto error;
+		}
+
 		return 0;
+error:
+		user_event_put(user, false);
+		return ret;
 	}
 
 	user = kzalloc(sizeof(*user), GFP_KERNEL_ACCOUNT);
@@ -1852,8 +1975,15 @@ static int user_event_parse(struct user_event_group *group, char *name,
 	if (ret)
 		goto put_user_lock;
 
-	/* Ensure we track self ref and caller ref (2) */
-	refcount_set(&user->refcnt, 2);
+	user->reg_flags = reg_flags;
+
+	if (user->reg_flags & USER_EVENT_REG_PERSIST) {
+		/* Ensure we track self ref and caller ref (2) */
+		refcount_set(&user->refcnt, 2);
+	} else {
+		/* Ensure we track only caller ref (1) */
+		refcount_set(&user->refcnt, 1);
+	}
 
 	dyn_event_init(&user->devent, &user_event_dops);
 	dyn_event_add(&user->devent, &user->call);
@@ -1885,7 +2015,7 @@ static int delete_user_event(struct user_event_group *group, char *name)
 	if (!user)
 		return -ENOENT;
 
-	refcount_dec(&user->refcnt);
+	user_event_put(user, true);
 
 	if (!user_event_last_ref(user))
 		return -EBUSY;
@@ -2044,9 +2174,7 @@ static int user_events_ref_add(struct user_event_file_info *info,
 	for (i = 0; i < count; ++i)
 		new_refs->events[i] = refs->events[i];
 
-	new_refs->events[i] = user;
-
-	refcount_inc(&user->refcnt);
+	new_refs->events[i] = user_event_get(user);
 
 	rcu_assign_pointer(info->refs, new_refs);
 
@@ -2077,8 +2205,8 @@ static long user_reg_get(struct user_reg __user *ureg, struct user_reg *kreg)
 	if (ret)
 		return ret;
 
-	/* Ensure no flags, since we don't support any yet */
-	if (kreg->flags != 0)
+	/* Ensure only valid flags */
+	if (kreg->flags & ~(USER_EVENT_REG_MAX-1))
 		return -EINVAL;
 
 	/* Ensure supported size */
@@ -2150,7 +2278,7 @@ static long user_events_ioctl_reg(struct user_event_file_info *info,
 		return ret;
 	}
 
-	ret = user_event_parse_cmd(info->group, name, &user);
+	ret = user_event_parse_cmd(info->group, name, &user, reg.flags);
 
 	if (ret) {
 		kfree(name);
@@ -2160,7 +2288,7 @@ static long user_events_ioctl_reg(struct user_event_file_info *info,
 	ret = user_events_ref_add(info, user);
 
 	/* No longer need parse ref, ref_add either worked or not */
-	refcount_dec(&user->refcnt);
+	user_event_put(user, false);
 
 	/* Positive number is index and valid */
 	if (ret < 0)
@@ -2309,7 +2437,7 @@ static long user_events_ioctl_unreg(unsigned long uarg)
 			set_bit(ENABLE_VAL_FREEING_BIT, ENABLE_BITOPS(enabler));
 
 			if (!test_bit(ENABLE_VAL_FAULTING_BIT, ENABLE_BITOPS(enabler)))
-				user_event_enabler_destroy(enabler);
+				user_event_enabler_destroy(enabler, true);
 
 			/* Removed at least one */
 			ret = 0;
@@ -2367,7 +2495,6 @@ static int user_events_release(struct inode *node, struct file *file)
 	struct user_event_file_info *info = file->private_data;
 	struct user_event_group *group;
 	struct user_event_refs *refs;
-	struct user_event *user;
 	int i;
 
 	if (!info)
@@ -2391,12 +2518,9 @@ static int user_events_release(struct inode *node, struct file *file)
 	 * The underlying user_events are ref counted, and cannot be freed.
 	 * After this decrement, the user_events may be freed elsewhere.
 	 */
-	for (i = 0; i < refs->count; ++i) {
-		user = refs->events[i];
+	for (i = 0; i < refs->count; ++i)
+		user_event_put(refs->events[i], false);
 
-		if (user)
-			refcount_dec(&user->refcnt);
-	}
 out:
 	file->private_data = NULL;
 
@@ -2577,7 +2701,7 @@ static int __init trace_events_user_init(void)
 	if (!fault_cache)
 		return -ENOMEM;
 
-	init_group = user_event_group_create(&init_user_ns);
+	init_group = user_event_group_create();
 
 	if (!init_group) {
 		kmem_cache_destroy(fault_cache);
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 15f05faaae44..1e33f367783e 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -847,7 +847,7 @@ static void print_fields(struct trace_iterator *iter, struct trace_event_call *c
 	int ret;
 	void *pos;
 
-	list_for_each_entry(field, head, link) {
+	list_for_each_entry_reverse(field, head, link) {
 		trace_seq_printf(&iter->seq, " %s=", field->name);
 		if (field->offset + field->size > iter->ent_size) {
 			trace_seq_puts(&iter->seq, "<OVERFLOW>");
diff --git a/tools/testing/selftests/user_events/dyn_test.c b/tools/testing/selftests/user_events/dyn_test.c
index 8879a7b04c6a..d6979a48478f 100644
--- a/tools/testing/selftests/user_events/dyn_test.c
+++ b/tools/testing/selftests/user_events/dyn_test.c
@@ -16,42 +16,140 @@
 
 #include "../kselftest_harness.h"
 
-const char *dyn_file = "/sys/kernel/tracing/dynamic_events";
-const char *clear = "!u:__test_event";
+const char *abi_file = "/sys/kernel/tracing/user_events_data";
+const char *enable_file = "/sys/kernel/tracing/events/user_events/__test_event/enable";
 
-static int Append(const char *value)
+static bool wait_for_delete(void)
 {
-	int fd = open(dyn_file, O_RDWR | O_APPEND);
-	int ret = write(fd, value, strlen(value));
+	int i;
+
+	for (i = 0; i < 1000; ++i) {
+		int fd = open(enable_file, O_RDONLY);
+
+		if (fd == -1)
+			return true;
+
+		close(fd);
+		usleep(1000);
+	}
+
+	return false;
+}
+
+static int reg_event(int fd, int *check, int bit, const char *value)
+{
+	struct user_reg reg = {0};
+
+	reg.size = sizeof(reg);
+	reg.name_args = (__u64)value;
+	reg.enable_bit = bit;
+	reg.enable_addr = (__u64)check;
+	reg.enable_size = sizeof(*check);
+
+	if (ioctl(fd, DIAG_IOCSREG, &reg) == -1)
+		return -1;
+
+	return 0;
+}
+
+static int unreg_event(int fd, int *check, int bit)
+{
+	struct user_unreg unreg = {0};
+
+	unreg.size = sizeof(unreg);
+	unreg.disable_bit = bit;
+	unreg.disable_addr = (__u64)check;
+
+	return ioctl(fd, DIAG_IOCSUNREG, &unreg);
+}
+
+static int parse(int *check, const char *value)
+{
+	int fd = open(abi_file, O_RDWR);
+	int ret;
+
+	if (fd == -1)
+		return -1;
+
+	/* Until we have persist flags via dynamic events, use the base name */
+	if (value[0] != 'u' || value[1] != ':') {
+		close(fd);
+		return -1;
+	}
+
+	ret = reg_event(fd, check, 31, value + 2);
+
+	if (ret != -1) {
+		if (unreg_event(fd, check, 31) == -1)
+			printf("WARN: Couldn't unreg event\n");
+	}
 
 	close(fd);
+
 	return ret;
 }
 
-#define CLEAR() \
+static int check_match(int *check, const char *first, const char *second, bool *match)
+{
+	int fd = open(abi_file, O_RDWR);
+	int ret = -1;
+
+	if (fd == -1)
+		return -1;
+
+	if (reg_event(fd, check, 31, first) == -1)
+		goto cleanup;
+
+	if (reg_event(fd, check, 30, second) == -1) {
+		if (errno == EADDRINUSE) {
+			/* Name is in use, with different fields */
+			*match = false;
+			ret = 0;
+		}
+
+		goto cleanup;
+	}
+
+	*match = true;
+	ret = 0;
+cleanup:
+	unreg_event(fd, check, 31);
+	unreg_event(fd, check, 30);
+
+	close(fd);
+
+	wait_for_delete();
+
+	return ret;
+}
+
+#define TEST_MATCH(x, y) \
 do { \
-	int ret = Append(clear); \
-	if (ret == -1) \
-		ASSERT_EQ(ENOENT, errno); \
+	bool match; \
+	ASSERT_NE(-1, check_match(&self->check, x, y, &match)); \
+	ASSERT_EQ(true, match); \
 } while (0)
 
-#define TEST_PARSE(x) \
+#define TEST_NMATCH(x, y) \
 do { \
-	ASSERT_NE(-1, Append(x)); \
-	CLEAR(); \
+	bool match; \
+	ASSERT_NE(-1, check_match(&self->check, x, y, &match)); \
+	ASSERT_EQ(false, match); \
 } while (0)
 
-#define TEST_NPARSE(x) ASSERT_EQ(-1, Append(x))
+#define TEST_PARSE(x) ASSERT_NE(-1, parse(&self->check, x))
+
+#define TEST_NPARSE(x) ASSERT_EQ(-1, parse(&self->check, x))
 
 FIXTURE(user) {
+	int check;
 };
 
 FIXTURE_SETUP(user) {
-	CLEAR();
 }
 
 FIXTURE_TEARDOWN(user) {
-	CLEAR();
+	wait_for_delete();
 }
 
 TEST_F(user, basic_types) {
@@ -95,33 +193,30 @@ TEST_F(user, size_types) {
 	TEST_NPARSE("u:__test_event char a 20");
 }
 
-TEST_F(user, flags) {
-	/* Should work */
-	TEST_PARSE("u:__test_event:BPF_ITER u32 a");
-	/* Forward compat */
-	TEST_PARSE("u:__test_event:BPF_ITER,FLAG_FUTURE u32 a");
-}
-
 TEST_F(user, matching) {
-	/* Register */
-	ASSERT_NE(-1, Append("u:__test_event struct custom a 20"));
-	/* Should not match */
-	TEST_NPARSE("!u:__test_event struct custom b");
-	/* Should match */
-	TEST_PARSE("!u:__test_event struct custom a");
-	/* Multi field reg */
-	ASSERT_NE(-1, Append("u:__test_event u32 a; u32 b"));
-	/* Non matching cases */
-	TEST_NPARSE("!u:__test_event u32 a");
-	TEST_NPARSE("!u:__test_event u32 b");
-	TEST_NPARSE("!u:__test_event u32 a; u32 ");
-	TEST_NPARSE("!u:__test_event u32 a; u32 a");
-	/* Matching case */
-	TEST_PARSE("!u:__test_event u32 a; u32 b");
-	/* Register */
-	ASSERT_NE(-1, Append("u:__test_event u32 a; u32 b"));
-	/* Ensure trailing semi-colon case */
-	TEST_PARSE("!u:__test_event u32 a; u32 b;");
+	/* Single name matches */
+	TEST_MATCH("__test_event u32 a",
+		   "__test_event u32 a");
+
+	/* Multiple names match */
+	TEST_MATCH("__test_event u32 a; u32 b",
+		   "__test_event u32 a; u32 b");
+
+	/* Multiple names match with dangling ; */
+	TEST_MATCH("__test_event u32 a; u32 b",
+		   "__test_event u32 a; u32 b;");
+
+	/* Single name doesn't match */
+	TEST_NMATCH("__test_event u32 a",
+		    "__test_event u32 b");
+
+	/* Multiple names don't match */
+	TEST_NMATCH("__test_event u32 a; u32 b",
+		    "__test_event u32 b; u32 a");
+
+	/* Types don't match */
+	TEST_NMATCH("__test_event u64 a; u64 b",
+		    "__test_event u32 a; u32 b");
 }
 
 int main(int argc, char **argv)
diff --git a/tools/testing/selftests/user_events/ftrace_test.c b/tools/testing/selftests/user_events/ftrace_test.c
index 7c99cef94a65..eb6904d89f14 100644
--- a/tools/testing/selftests/user_events/ftrace_test.c
+++ b/tools/testing/selftests/user_events/ftrace_test.c
@@ -102,30 +102,56 @@ static int get_print_fmt(char *buffer, int len)
 	return -1;
 }
 
+static bool wait_for_delete(void)
+{
+	int i;
+
+	for (i = 0; i < 1000; ++i) {
+		int fd = open(enable_file, O_RDONLY);
+
+		if (fd == -1)
+			return true;
+
+		close(fd);
+		usleep(1000);
+	}
+
+	return false;
+}
+
 static int clear(int *check)
 {
 	struct user_unreg unreg = {0};
+	int fd;
 
 	unreg.size = sizeof(unreg);
 	unreg.disable_bit = 31;
 	unreg.disable_addr = (__u64)check;
 
-	int fd = open(data_file, O_RDWR);
+	fd = open(data_file, O_RDWR);
 
 	if (fd == -1)
 		return -1;
 
 	if (ioctl(fd, DIAG_IOCSUNREG, &unreg) == -1)
 		if (errno != ENOENT)
-			return -1;
-
-	if (ioctl(fd, DIAG_IOCSDEL, "__test_event") == -1)
-		if (errno != ENOENT)
-			return -1;
+			goto fail;
+
+	if (ioctl(fd, DIAG_IOCSDEL, "__test_event") == -1) {
+		if (errno == EBUSY) {
+			if (!wait_for_delete())
+				goto fail;
+		} else if (errno != ENOENT)
+			goto fail;
+	}
 
 	close(fd);
 
 	return 0;
+fail:
+	close(fd);
+
+	return -1;
 }
 
 static int check_print_fmt(const char *event, const char *expected, int *check)
@@ -155,9 +181,8 @@ static int check_print_fmt(const char *event, const char *expected, int *check)
 	/* Register should work */
 	ret = ioctl(fd, DIAG_IOCSREG, &reg);
 
-	close(fd);
-
 	if (ret != 0) {
+		close(fd);
 		printf("Reg failed in fmt\n");
 		return ret;
 	}
@@ -165,6 +190,8 @@ static int check_print_fmt(const char *event, const char *expected, int *check)
 	/* Ensure correct print_fmt */
 	ret = get_print_fmt(print_fmt, sizeof(print_fmt));
 
+	close(fd);
+
 	if (ret != 0)
 		return ret;
 
@@ -228,6 +255,12 @@ TEST_F(user, register_events) {
 	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
 	ASSERT_EQ(0, reg.write_index);
 
+	/* Multiple registers to same name but different args should fail */
+	reg.enable_bit = 29;
+	reg.name_args = (__u64)"__test_event u32 field1;";
+	ASSERT_EQ(-1, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
+	ASSERT_EQ(EADDRINUSE, errno);
+
 	/* Ensure disabled */
 	self->enable_fd = open(enable_file, O_RDWR);
 	ASSERT_NE(-1, self->enable_fd);
@@ -250,10 +283,10 @@ TEST_F(user, register_events) {
 	unreg.disable_bit = 30;
 	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSUNREG, &unreg));
 
-	/* Delete should work only after close and unregister */
+	/* Delete should have been auto-done after close and unregister */
 	close(self->data_fd);
-	self->data_fd = open(data_file, O_RDWR);
-	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSDEL, "__test_event"));
+
+	ASSERT_EQ(true, wait_for_delete());
 }
 
 TEST_F(user, write_events) {
@@ -310,6 +343,39 @@ TEST_F(user, write_events) {
 	ASSERT_EQ(EINVAL, errno);
 }
 
+TEST_F(user, write_empty_events) {
+	struct user_reg reg = {0};
+	struct iovec io[1];
+	int before = 0, after = 0;
+
+	reg.size = sizeof(reg);
+	reg.name_args = (__u64)"__test_event";
+	reg.enable_bit = 31;
+	reg.enable_addr = (__u64)&self->check;
+	reg.enable_size = sizeof(self->check);
+
+	io[0].iov_base = &reg.write_index;
+	io[0].iov_len = sizeof(reg.write_index);
+
+	/* Register should work */
+	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
+	ASSERT_EQ(0, reg.write_index);
+	ASSERT_EQ(0, self->check);
+
+	/* Enable event */
+	self->enable_fd = open(enable_file, O_RDWR);
+	ASSERT_NE(-1, write(self->enable_fd, "1", sizeof("1")))
+
+	/* Event should now be enabled */
+	ASSERT_EQ(1 << reg.enable_bit, self->check);
+
+	/* Write should make it out to ftrace buffers */
+	before = trace_bytes();
+	ASSERT_NE(-1, writev(self->data_fd, (const struct iovec *)io, 1));
+	after = trace_bytes();
+	ASSERT_GT(after, before);
+}
+
 TEST_F(user, write_fault) {
 	struct user_reg reg = {0};
 	struct iovec io[2];
diff --git a/tools/testing/selftests/user_events/perf_test.c b/tools/testing/selftests/user_events/perf_test.c
index a070258d4449..8b09be566fa2 100644
--- a/tools/testing/selftests/user_events/perf_test.c
+++ b/tools/testing/selftests/user_events/perf_test.c
@@ -81,6 +81,32 @@ static int get_offset(void)
 	return offset;
 }
 
+static int clear(int *check)
+{
+	struct user_unreg unreg = {0};
+
+	unreg.size = sizeof(unreg);
+	unreg.disable_bit = 31;
+	unreg.disable_addr = (__u64)check;
+
+	int fd = open(data_file, O_RDWR);
+
+	if (fd == -1)
+		return -1;
+
+	if (ioctl(fd, DIAG_IOCSUNREG, &unreg) == -1)
+		if (errno != ENOENT)
+			return -1;
+
+	if (ioctl(fd, DIAG_IOCSDEL, "__test_event") == -1)
+		if (errno != ENOENT)
+			return -1;
+
+	close(fd);
+
+	return 0;
+}
+
 FIXTURE(user) {
 	int data_fd;
 	int check;
@@ -93,6 +119,9 @@ FIXTURE_SETUP(user) {
 
 FIXTURE_TEARDOWN(user) {
 	close(self->data_fd);
+
+	if (clear(&self->check) != 0)
+		printf("WARNING: Clear didn't work!\n");
 }
 
 TEST_F(user, perf_write) {
@@ -160,6 +189,59 @@ TEST_F(user, perf_write) {
 	ASSERT_EQ(0, self->check);
 }
 
+TEST_F(user, perf_empty_events) {
+	struct perf_event_attr pe = {0};
+	struct user_reg reg = {0};
+	struct perf_event_mmap_page *perf_page;
+	int page_size = sysconf(_SC_PAGESIZE);
+	int id, fd;
+	__u32 *val;
+
+	reg.size = sizeof(reg);
+	reg.name_args = (__u64)"__test_event";
+	reg.enable_bit = 31;
+	reg.enable_addr = (__u64)&self->check;
+	reg.enable_size = sizeof(self->check);
+
+	/* Register should work */
+	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
+	ASSERT_EQ(0, reg.write_index);
+	ASSERT_EQ(0, self->check);
+
+	/* Id should be there */
+	id = get_id();
+	ASSERT_NE(-1, id);
+
+	pe.type = PERF_TYPE_TRACEPOINT;
+	pe.size = sizeof(pe);
+	pe.config = id;
+	pe.sample_type = PERF_SAMPLE_RAW;
+	pe.sample_period = 1;
+	pe.wakeup_events = 1;
+
+	/* Tracepoint attach should work */
+	fd = perf_event_open(&pe, 0, -1, -1, 0);
+	ASSERT_NE(-1, fd);
+
+	perf_page = mmap(NULL, page_size * 2, PROT_READ, MAP_SHARED, fd, 0);
+	ASSERT_NE(MAP_FAILED, perf_page);
+
+	/* Status should be updated */
+	ASSERT_EQ(1 << reg.enable_bit, self->check);
+
+	/* Ensure write shows up at correct offset */
+	ASSERT_NE(-1, write(self->data_fd, &reg.write_index,
+					sizeof(reg.write_index)));
+	val = (void *)(((char *)perf_page) + perf_page->data_offset);
+	ASSERT_EQ(PERF_RECORD_SAMPLE, *val);
+
+	munmap(perf_page, page_size * 2);
+	close(fd);
+
+	/* Status should be updated */
+	ASSERT_EQ(0, self->check);
+}
+
 int main(int argc, char **argv)
 {
 	return test_harness_run(argc, argv);

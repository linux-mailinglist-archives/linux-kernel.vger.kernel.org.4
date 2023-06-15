Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62065731A25
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344307AbjFONgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344199AbjFONfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:35:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F943586
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:35:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE6F463A1F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 13:34:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49212C433C8;
        Thu, 15 Jun 2023 13:34:18 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1q9n7B-000TrS-0v;
        Thu, 15 Jun 2023 09:34:17 -0400
Message-ID: <20230615133417.099572277@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 15 Jun 2023 09:05:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: [for-linus][PATCH 12/15] tracing/user_events: Add auto cleanup and future persist flag
References: <20230615130531.200384328@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Beau Belgrave <beaub@linux.microsoft.com>

Currently user events need to be manually deleted via the delete IOCTL
call or via the dynamic_events file. Most operators and processes wish
to have these events auto cleanup when they are no longer used by
anything to prevent them piling without manual maintenance. However,
some operators may not want this, such as pre-registering events via the
dynamic_events tracefs file.

Update user_event_put() to attempt an auto delete of the event if it's
the last reference. The auto delete must run in a work queue to ensure
proper behavior of class->reg() invocations that don't expect the call
to go away from underneath them during the unregister. Add work_struct
to user_event struct to ensure we can do this reliably.

Add a persist flag, that is not yet exposed, to ensure we can toggle
between auto-cleanup and leaving the events existing in the future. When
a non-zero flag is seen during register, return -EINVAL to ensure ABI
is clear for the user processes while we work out the best approach for
persistent events.

Link: https://lkml.kernel.org/r/20230614163336.5797-4-beaub@linux.microsoft.com
Link: https://lore.kernel.org/linux-trace-kernel/20230518093600.3f119d68@rorschach.local.home/

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_user.c | 139 ++++++++++++++++++++++++++++---
 1 file changed, 126 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index c064458eea5c..8df0550415e7 100644
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
@@ -85,6 +97,7 @@ struct user_event {
 	struct hlist_node		node;
 	struct list_head		fields;
 	struct list_head		validators;
+	struct work_struct		put_work;
 	refcount_t			refcnt;
 	int				min_size;
 	int				reg_flags;
@@ -171,6 +184,7 @@ static int user_event_parse(struct user_event_group *group, char *name,
 static struct user_event_mm *user_event_mm_get(struct user_event_mm *mm);
 static struct user_event_mm *user_event_mm_get_all(struct user_event *user);
 static void user_event_mm_put(struct user_event_mm *mm);
+static int destroy_user_event(struct user_event *user);
 
 static u32 user_event_key(char *name)
 {
@@ -184,19 +198,103 @@ static struct user_event *user_event_get(struct user_event *user)
 	return user;
 }
 
+static void delayed_destroy_user_event(struct work_struct *work)
+{
+	struct user_event *user = container_of(
+		work, struct user_event, put_work);
+
+	mutex_lock(&event_mutex);
+
+	if (!refcount_dec_and_test(&user->refcnt))
+		goto out;
+
+	if (destroy_user_event(user)) {
+		/*
+		 * The only reason this would fail here is if we cannot
+		 * update the visibility of the event. In this case the
+		 * event stays in the hashtable, waiting for someone to
+		 * attempt to delete it later.
+		 */
+		pr_warn("user_events: Unable to delete event\n");
+		refcount_set(&user->refcnt, 1);
+	}
+out:
+	mutex_unlock(&event_mutex);
+}
+
 static void user_event_put(struct user_event *user, bool locked)
 {
-#ifdef CONFIG_LOCKDEP
-	if (locked)
-		lockdep_assert_held(&event_mutex);
-	else
-		lockdep_assert_not_held(&event_mutex);
-#endif
+	bool delete;
 
 	if (unlikely(!user))
 		return;
 
-	refcount_dec(&user->refcnt);
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
+
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
 
 static void user_event_group_destroy(struct user_event_group *group)
@@ -793,7 +891,12 @@ static struct user_event_enabler
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
@@ -1609,7 +1712,8 @@ static int user_event_create(const char *raw_command)
 
 	mutex_lock(&group->reg_mutex);
 
-	ret = user_event_parse_cmd(group, name, &user, 0);
+	/* Dyn events persist, otherwise they would cleanup immediately */
+	ret = user_event_parse_cmd(group, name, &user, USER_EVENT_REG_PERSIST);
 
 	if (!ret)
 		user_event_put(user, false);
@@ -1780,6 +1884,10 @@ static int user_event_parse(struct user_event_group *group, char *name,
 	int argc = 0;
 	char **argv;
 
+	/* User register flags are not ready yet */
+	if (reg_flags != 0 || flags != NULL)
+		return -EINVAL;
+
 	/* Prevent dyn_event from racing */
 	mutex_lock(&event_mutex);
 	user = find_user_event(group, name, &key);
@@ -1869,8 +1977,13 @@ static int user_event_parse(struct user_event_group *group, char *name,
 
 	user->reg_flags = reg_flags;
 
-	/* Ensure we track self ref and caller ref (2) */
-	refcount_set(&user->refcnt, 2);
+	if (user->reg_flags & USER_EVENT_REG_PERSIST) {
+		/* Ensure we track self ref and caller ref (2) */
+		refcount_set(&user->refcnt, 2);
+	} else {
+		/* Ensure we track only caller ref (1) */
+		refcount_set(&user->refcnt, 1);
+	}
 
 	dyn_event_init(&user->devent, &user_event_dops);
 	dyn_event_add(&user->devent, &user->call);
@@ -2092,8 +2205,8 @@ static long user_reg_get(struct user_reg __user *ureg, struct user_reg *kreg)
 	if (ret)
 		return ret;
 
-	/* Ensure no flags, since we don't support any yet */
-	if (kreg->flags != 0)
+	/* Ensure only valid flags */
+	if (kreg->flags & ~(USER_EVENT_REG_MAX-1))
 		return -EINVAL;
 
 	/* Ensure supported size */
-- 
2.39.2

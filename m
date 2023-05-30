Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA49717211
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbjE3Xxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233833AbjE3XxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:53:16 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC607EC;
        Tue, 30 May 2023 16:53:12 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5251520FC471;
        Tue, 30 May 2023 16:53:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5251520FC471
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1685490792;
        bh=o7cuIRxv95pgO2FziqXirK2G8dnOM07dCx9U3XlMIUI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aOTkpJ81RJe4uRRChokSxB4GFanHrLA/nVtkSaf/euHUrjHczbPJAHtpD0Y2YXgE8
         tgogBTtsibNyUFYbqa7FRs07PZQzslyp7Lv77yYmBC61FFxaI5WiXuLVPsb6VEmS52
         6cr87mk5KIx4ZgrC5ACxw7DqBtGRVQj+gDbpYdWg=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        ast@kernel.org, dcook@linux.microsoft.com
Subject: [PATCH 3/5] tracing/user_events: Add flag to auto-delete events
Date:   Tue, 30 May 2023 16:53:02 -0700
Message-Id: <20230530235304.2726-4-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230530235304.2726-1-beaub@linux.microsoft.com>
References: <20230530235304.2726-1-beaub@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently user events need to be manually deleted via the delete IOCTL
call or via the dynamic_events file. Some operators and processes wish
to have these events auto cleanup when they are no longer used by
anything to prevent them piling without manual maintenance.

Add auto delete flag to user facing header and honor it within the
register IOCTL call. Add max flag as well to ensure that only known
flags can be used now and in the future. Update user_event_put() to
attempt an auto delete of the event if it's the last reference. The
auto delete must run in a work queue to ensure proper behavior of
class->reg() invocations that don't expect the call to go away from
underneath them during the unregister. Add work_struct to user_event
struct to ensure we can do this reliably.

Link: https://lore.kernel.org/linux-trace-kernel/20230518093600.3f119d68@rorschach.local.home/

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 include/uapi/linux/user_events.h |  10 ++-
 kernel/trace/trace_events_user.c | 115 +++++++++++++++++++++++++++----
 2 files changed, 112 insertions(+), 13 deletions(-)

diff --git a/include/uapi/linux/user_events.h b/include/uapi/linux/user_events.h
index 2984aae4a2b4..635f45bc6457 100644
--- a/include/uapi/linux/user_events.h
+++ b/include/uapi/linux/user_events.h
@@ -17,6 +17,14 @@
 /* Create dynamic location entry within a 32-bit value */
 #define DYN_LOC(offset, size) ((size) << 16 | (offset))
 
+enum user_reg_flag {
+	/* Event will auto delete upon last reference closing */
+	USER_EVENT_REG_AUTO_DEL		= 1U << 0,
+
+	/* This value or above is currently non-ABI */
+	USER_EVENT_REG_MAX		= 1U << 1,
+};
+
 /*
  * Describes an event registration and stores the results of the registration.
  * This structure is passed to the DIAG_IOCSREG ioctl, callers at a minimum
@@ -33,7 +41,7 @@ struct user_reg {
 	/* Input: Enable size in bytes at address */
 	__u8	enable_size;
 
-	/* Input: Flags for future use, set to 0 */
+	/* Input: Flags can be any of the above user_reg_flag values */
 	__u16	flags;
 
 	/* Input: Address to update when enabled */
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 8f0fb6cb0f33..ddd199f286fe 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -85,6 +85,7 @@ struct user_event {
 	struct hlist_node		node;
 	struct list_head		fields;
 	struct list_head		validators;
+	struct work_struct		put_work;
 	refcount_t			refcnt;
 	int				min_size;
 	int				reg_flags;
@@ -169,6 +170,7 @@ static int user_event_parse(struct user_event_group *group, char *name,
 static struct user_event_mm *user_event_mm_get(struct user_event_mm *mm);
 static struct user_event_mm *user_event_mm_get_all(struct user_event *user);
 static void user_event_mm_put(struct user_event_mm *mm);
+static int destroy_user_event(struct user_event *user);
 
 static u32 user_event_key(char *name)
 {
@@ -182,19 +184,98 @@ static struct user_event *user_event_get(struct user_event *user)
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
+	/* We now have the event_mutex in all cases */
+
+	if (!(user->reg_flags & USER_EVENT_REG_AUTO_DEL)) {
+		/* We should not get here unless the auto-delete flag is set */
+		pr_alert("BUG: Auto-delete engaged without it enabled\n");
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
+	if (!schedule_work(&user->put_work)) {
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
@@ -793,7 +874,12 @@ static struct user_event_enabler
 static __always_inline __must_check
 bool user_event_last_ref(struct user_event *user)
 {
-	return refcount_read(&user->refcnt) == 1;
+	int last = 1;
+
+	if (user->reg_flags & USER_EVENT_REG_AUTO_DEL)
+		last = 0;
+
+	return refcount_read(&user->refcnt) == last;
 }
 
 static __always_inline __must_check
@@ -1843,8 +1929,13 @@ static int user_event_parse(struct user_event_group *group, char *name,
 
 	user->reg_flags = reg_flags;
 
-	/* Ensure we track self ref and caller ref (2) */
-	refcount_set(&user->refcnt, 2);
+	if (user->reg_flags & USER_EVENT_REG_AUTO_DEL) {
+		/* Ensure we track only caller ref (1) */
+		refcount_set(&user->refcnt, 1);
+	} else {
+		/* Ensure we track self ref and caller ref (2) */
+		refcount_set(&user->refcnt, 2);
+	}
 
 	dyn_event_init(&user->devent, &user_event_dops);
 	dyn_event_add(&user->devent, &user->call);
@@ -2066,8 +2157,8 @@ static long user_reg_get(struct user_reg __user *ureg, struct user_reg *kreg)
 	if (ret)
 		return ret;
 
-	/* Ensure no flags, since we don't support any yet */
-	if (kreg->flags != 0)
+	/* Ensure only valid flags */
+	if (kreg->flags & ~(USER_EVENT_REG_MAX-1))
 		return -EINVAL;
 
 	/* Ensure supported size */
-- 
2.25.1


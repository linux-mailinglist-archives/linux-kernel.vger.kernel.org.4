Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DF97304FE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbjFNQdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbjFNQdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:33:42 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 45A31211F;
        Wed, 14 Jun 2023 09:33:41 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id AD68620FEA55;
        Wed, 14 Jun 2023 09:33:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AD68620FEA55
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1686760420;
        bh=yDW7gd/vqliT639AhV7lko9tZLW6od+arg8thacnYrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IYjmNmk9tOooNKGdJGwei+yhSKpVurQIp1EeMOTp4/xHVkAHVqmEb6uZJyY6vQ8kE
         xPa//bjkbEzc0klVFxXOmMBzZOdNDx+06Bf9q3JxDnr2DdisONaIY+HHQwxa3AfBBT
         ptfvne4fImxY1gBgNrlcxowXuBoK1U0DBXfu54Po=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        ast@kernel.org, dcook@linux.microsoft.com
Subject: [PATCH v3 2/6] tracing/user_events: Track refcount consistently via put/get
Date:   Wed, 14 Jun 2023 09:33:32 -0700
Message-Id: <20230614163336.5797-3-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230614163336.5797-1-beaub@linux.microsoft.com>
References: <20230614163336.5797-1-beaub@linux.microsoft.com>
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

Various parts of the code today track user_event's refcnt field directly
via a refcount_add/dec. This makes it hard to modify the behavior of the
last reference decrement in all code paths consistently. For example, in
the future we will auto-delete events upon the last reference going
away. This last reference could happen in many places, but we want it to
be consistently handled.

Add user_event_get() and user_event_put() for the add/dec. Update all
places where direct refcounts are being used to utilize these new
functions. In each location pass if event_mutex is locked or not. This
allows us to drop events automatically in future patches clearly. Ensure
when caller states the lock is held, it really is (or is not) held.

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 kernel/trace/trace_events_user.c | 69 +++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 28 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 629823e21447..c064458eea5c 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -177,6 +177,28 @@ static u32 user_event_key(char *name)
 	return jhash(name, strlen(name), 0);
 }
 
+static struct user_event *user_event_get(struct user_event *user)
+{
+	refcount_inc(&user->refcnt);
+
+	return user;
+}
+
+static void user_event_put(struct user_event *user, bool locked)
+{
+#ifdef CONFIG_LOCKDEP
+	if (locked)
+		lockdep_assert_held(&event_mutex);
+	else
+		lockdep_assert_not_held(&event_mutex);
+#endif
+
+	if (unlikely(!user))
+		return;
+
+	refcount_dec(&user->refcnt);
+}
+
 static void user_event_group_destroy(struct user_event_group *group)
 {
 	kfree(group->system_name);
@@ -228,12 +250,13 @@ static struct user_event_group *user_event_group_create(void)
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
@@ -295,7 +318,7 @@ static void user_event_enabler_fault_fixup(struct work_struct *work)
 
 	/* User asked for enabler to be removed during fault */
 	if (test_bit(ENABLE_VAL_FREEING_BIT, ENABLE_BITOPS(enabler))) {
-		user_event_enabler_destroy(enabler);
+		user_event_enabler_destroy(enabler, true);
 		goto out;
 	}
 
@@ -470,14 +493,12 @@ static bool user_event_enabler_dup(struct user_event_enabler *orig,
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
 
@@ -594,7 +615,7 @@ static void user_event_mm_destroy(struct user_event_mm *mm)
 	struct user_event_enabler *enabler, *next;
 
 	list_for_each_entry_safe(enabler, next, &mm->enablers, mm_enablers_link)
-		user_event_enabler_destroy(enabler);
+		user_event_enabler_destroy(enabler, false);
 
 	mmdrop(mm->mm);
 	kfree(mm);
@@ -749,7 +770,7 @@ static struct user_event_enabler
 	 * exit or run exec(), which includes forks and clones.
 	 */
 	if (!*write_result) {
-		refcount_inc(&enabler->event->refcnt);
+		user_event_get(user);
 		list_add_rcu(&enabler->mm_enablers_link, &user_mm->enablers);
 	}
 
@@ -1337,10 +1358,8 @@ static struct user_event *find_user_event(struct user_event_group *group,
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
@@ -1554,12 +1573,12 @@ static int user_event_reg(struct trace_event_call *call,
 
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
 
@@ -1593,7 +1612,7 @@ static int user_event_create(const char *raw_command)
 	ret = user_event_parse_cmd(group, name, &user, 0);
 
 	if (!ret)
-		refcount_dec(&user->refcnt);
+		user_event_put(user, false);
 
 	mutex_unlock(&group->reg_mutex);
 
@@ -1794,7 +1813,7 @@ static int user_event_parse(struct user_event_group *group, char *name,
 
 		return 0;
 error:
-		refcount_dec(&user->refcnt);
+		user_event_put(user, false);
 		return ret;
 	}
 
@@ -1883,7 +1902,7 @@ static int delete_user_event(struct user_event_group *group, char *name)
 	if (!user)
 		return -ENOENT;
 
-	refcount_dec(&user->refcnt);
+	user_event_put(user, true);
 
 	if (!user_event_last_ref(user))
 		return -EBUSY;
@@ -2042,9 +2061,7 @@ static int user_events_ref_add(struct user_event_file_info *info,
 	for (i = 0; i < count; ++i)
 		new_refs->events[i] = refs->events[i];
 
-	new_refs->events[i] = user;
-
-	refcount_inc(&user->refcnt);
+	new_refs->events[i] = user_event_get(user);
 
 	rcu_assign_pointer(info->refs, new_refs);
 
@@ -2158,7 +2175,7 @@ static long user_events_ioctl_reg(struct user_event_file_info *info,
 	ret = user_events_ref_add(info, user);
 
 	/* No longer need parse ref, ref_add either worked or not */
-	refcount_dec(&user->refcnt);
+	user_event_put(user, false);
 
 	/* Positive number is index and valid */
 	if (ret < 0)
@@ -2307,7 +2324,7 @@ static long user_events_ioctl_unreg(unsigned long uarg)
 			set_bit(ENABLE_VAL_FREEING_BIT, ENABLE_BITOPS(enabler));
 
 			if (!test_bit(ENABLE_VAL_FAULTING_BIT, ENABLE_BITOPS(enabler)))
-				user_event_enabler_destroy(enabler);
+				user_event_enabler_destroy(enabler, true);
 
 			/* Removed at least one */
 			ret = 0;
@@ -2365,7 +2382,6 @@ static int user_events_release(struct inode *node, struct file *file)
 	struct user_event_file_info *info = file->private_data;
 	struct user_event_group *group;
 	struct user_event_refs *refs;
-	struct user_event *user;
 	int i;
 
 	if (!info)
@@ -2389,12 +2405,9 @@ static int user_events_release(struct inode *node, struct file *file)
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
 
-- 
2.25.1


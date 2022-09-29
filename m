Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3B55F0118
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 00:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiI2W4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 18:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiI2Wzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 18:55:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B23CD74D6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 15:55:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FAE9621C2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 22:55:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A399C43142;
        Thu, 29 Sep 2022 22:55:27 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oe2SO-000csD-2u;
        Thu, 29 Sep 2022 18:56:40 -0400
Message-ID: <20220929225640.475558980@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 29 Sep 2022 18:55:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: [for-next][PATCH 13/15] tracing/user_events: Use refcount instead of atomic for ref tracking
References: <20220929225542.784716766@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Beau Belgrave <beaub@linux.microsoft.com>

User processes could open up enough event references to cause rollovers.
These could cause use after free scenarios, which we do not want.
Switching to refcount APIs prevent this, but will leak memory once
saturated.

Once saturated, user processes can still use the events. This prevents
a bad user process from stopping existing telemetry from being emitted.

Link: https://lkml.kernel.org/r/20220728233309.1896-5-beaub@linux.microsoft.com
Link: https://lore.kernel.org/all/2059213643.196683.1648499088753.JavaMail.zimbra@efficios.com/

Reported-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_user.c | 53 +++++++++++++++-----------------
 1 file changed, 24 insertions(+), 29 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index f9bb7d37d76f..2bcae7abfa81 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -14,6 +14,7 @@
 #include <linux/uio.h>
 #include <linux/ioctl.h>
 #include <linux/jhash.h>
+#include <linux/refcount.h>
 #include <linux/trace_events.h>
 #include <linux/tracefs.h>
 #include <linux/types.h>
@@ -57,7 +58,7 @@ static DECLARE_BITMAP(page_bitmap, MAX_EVENTS);
  * within a file a user_event might be created if it does not
  * already exist. These are globally used and their lifetime
  * is tied to the refcnt member. These cannot go away until the
- * refcnt reaches zero.
+ * refcnt reaches one.
  */
 struct user_event {
 	struct tracepoint tracepoint;
@@ -67,7 +68,7 @@ struct user_event {
 	struct hlist_node node;
 	struct list_head fields;
 	struct list_head validators;
-	atomic_t refcnt;
+	refcount_t refcnt;
 	int index;
 	int flags;
 	int min_size;
@@ -105,6 +106,12 @@ static u32 user_event_key(char *name)
 	return jhash(name, strlen(name), 0);
 }
 
+static __always_inline __must_check
+bool user_event_last_ref(struct user_event *user)
+{
+	return refcount_read(&user->refcnt) == 1;
+}
+
 static __always_inline __must_check
 size_t copy_nofault(void *addr, size_t bytes, struct iov_iter *i)
 {
@@ -662,7 +669,7 @@ static struct user_event *find_user_event(char *name, u32 *outkey)
 
 	hash_for_each_possible(register_table, user, node, key)
 		if (!strcmp(EVENT_NAME(user), name)) {
-			atomic_inc(&user->refcnt);
+			refcount_inc(&user->refcnt);
 			return user;
 		}
 
@@ -876,12 +883,12 @@ static int user_event_reg(struct trace_event_call *call,
 
 	return ret;
 inc:
-	atomic_inc(&user->refcnt);
+	refcount_inc(&user->refcnt);
 	update_reg_page_for(user);
 	return 0;
 dec:
 	update_reg_page_for(user);
-	atomic_dec(&user->refcnt);
+	refcount_dec(&user->refcnt);
 	return 0;
 }
 
@@ -907,7 +914,7 @@ static int user_event_create(const char *raw_command)
 	ret = user_event_parse_cmd(name, &user);
 
 	if (!ret)
-		atomic_dec(&user->refcnt);
+		refcount_dec(&user->refcnt);
 
 	mutex_unlock(&reg_mutex);
 
@@ -951,14 +958,14 @@ static bool user_event_is_busy(struct dyn_event *ev)
 {
 	struct user_event *user = container_of(ev, struct user_event, devent);
 
-	return atomic_read(&user->refcnt) != 0;
+	return !user_event_last_ref(user);
 }
 
 static int user_event_free(struct dyn_event *ev)
 {
 	struct user_event *user = container_of(ev, struct user_event, devent);
 
-	if (atomic_read(&user->refcnt) != 0)
+	if (!user_event_last_ref(user))
 		return -EBUSY;
 
 	return destroy_user_event(user);
@@ -1137,8 +1144,8 @@ static int user_event_parse(char *name, char *args, char *flags,
 
 	user->index = index;
 
-	/* Ensure we track ref */
-	atomic_inc(&user->refcnt);
+	/* Ensure we track self ref and caller ref (2) */
+	refcount_set(&user->refcnt, 2);
 
 	dyn_event_init(&user->devent, &user_event_dops);
 	dyn_event_add(&user->devent, &user->call);
@@ -1164,29 +1171,17 @@ static int user_event_parse(char *name, char *args, char *flags,
 static int delete_user_event(char *name)
 {
 	u32 key;
-	int ret;
 	struct user_event *user = find_user_event(name, &key);
 
 	if (!user)
 		return -ENOENT;
 
-	/* Ensure we are the last ref */
-	if (atomic_read(&user->refcnt) != 1) {
-		ret = -EBUSY;
-		goto put_ref;
-	}
-
-	ret = destroy_user_event(user);
+	refcount_dec(&user->refcnt);
 
-	if (ret)
-		goto put_ref;
-
-	return ret;
-put_ref:
-	/* No longer have this ref */
-	atomic_dec(&user->refcnt);
+	if (!user_event_last_ref(user))
+		return -EBUSY;
 
-	return ret;
+	return destroy_user_event(user);
 }
 
 /*
@@ -1314,7 +1309,7 @@ static int user_events_ref_add(struct file *file, struct user_event *user)
 
 	new_refs->events[i] = user;
 
-	atomic_inc(&user->refcnt);
+	refcount_inc(&user->refcnt);
 
 	rcu_assign_pointer(file->private_data, new_refs);
 
@@ -1374,7 +1369,7 @@ static long user_events_ioctl_reg(struct file *file, unsigned long uarg)
 	ret = user_events_ref_add(file, user);
 
 	/* No longer need parse ref, ref_add either worked or not */
-	atomic_dec(&user->refcnt);
+	refcount_dec(&user->refcnt);
 
 	/* Positive number is index and valid */
 	if (ret < 0)
@@ -1464,7 +1459,7 @@ static int user_events_release(struct inode *node, struct file *file)
 		user = refs->events[i];
 
 		if (user)
-			atomic_dec(&user->refcnt);
+			refcount_dec(&user->refcnt);
 	}
 out:
 	file->private_data = NULL;
-- 
2.35.1

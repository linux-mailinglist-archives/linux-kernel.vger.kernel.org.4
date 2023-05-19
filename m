Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C0570A332
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 01:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbjESXIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 19:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjESXI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 19:08:27 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 499541B3;
        Fri, 19 May 2023 16:08:25 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id AC48720FB614;
        Fri, 19 May 2023 16:08:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AC48720FB614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1684537704;
        bh=R9WpmxQFldXYYmhS/GVfkKBD8D/fasffqThY+EQObvc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YHrrSZG4sLrjrhf1tGCCfZggsuLDngkFW6hb54mD9g9x+G1paMrvjGSquAm019F+K
         B9vK+RU4y/bqFjkZr9e5plPWkG0LPYXlkXJaHjt3AMGanGsu2QJq+oJo9nZLDzAGLE
         DoakVU00mWA9A5mZKYyFrEg/+JLWNjHNSkk3xRtM=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, ast@kernel.org
Subject: [PATCH v3 3/4] tracing/user_events: Rename link fields for clarity
Date:   Fri, 19 May 2023 16:07:40 -0700
Message-Id: <20230519230741.669-4-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230519230741.669-1-beaub@linux.microsoft.com>
References: <20230519230741.669-1-beaub@linux.microsoft.com>
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

Currently most list_head fields of various structs within user_events
are simply named link. This causes folks to keep additional context in
their head when working with the code, which can be confusing.

Instead of using link, describe what the actual link is, for example:
list_del_rcu(&mm->link);

Changes into:
list_del_rcu(&mm->mms_link);

The reader now is given a hint the link is to the mms global list
instead of having to remember or spot check within the code.

Link: https://lore.kernel.org/linux-trace-kernel/CAHk-=wicngggxVpbnrYHjRTwGE0WYscPRM+L2HO2BF8ia1EXgQ@mail.gmail.com/

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 include/linux/user_events.h      |  2 +-
 kernel/trace/trace_events_user.c | 40 ++++++++++++++++++--------------
 2 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/include/linux/user_events.h b/include/linux/user_events.h
index 2847f5a18a86..17d452b389de 100644
--- a/include/linux/user_events.h
+++ b/include/linux/user_events.h
@@ -17,7 +17,7 @@
 
 #ifdef CONFIG_USER_EVENTS
 struct user_event_mm {
-	struct list_head	link;
+	struct list_head	mms_link;
 	struct list_head	enablers;
 	struct mm_struct	*mm;
 	struct user_event_mm	*next;
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 2f70dabb0f71..360d0f965cb8 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -96,7 +96,7 @@ struct user_event {
  * these to track enablement sites that are tied to an event.
  */
 struct user_event_enabler {
-	struct list_head	link;
+	struct list_head	mm_enablers_link;
 	struct user_event	*event;
 	unsigned long		addr;
 
@@ -153,7 +153,7 @@ struct user_event_file_info {
 #define VALIDATOR_REL (1 << 1)
 
 struct user_event_validator {
-	struct list_head	link;
+	struct list_head	user_event_link;
 	int			offset;
 	int			flags;
 };
@@ -259,7 +259,7 @@ static struct user_event_group
 
 static void user_event_enabler_destroy(struct user_event_enabler *enabler)
 {
-	list_del_rcu(&enabler->link);
+	list_del_rcu(&enabler->mm_enablers_link);
 
 	/* No longer tracking the event via the enabler */
 	refcount_dec(&enabler->event->refcnt);
@@ -438,7 +438,7 @@ static bool user_event_enabler_exists(struct user_event_mm *mm,
 {
 	struct user_event_enabler *enabler;
 
-	list_for_each_entry(enabler, &mm->enablers, link) {
+	list_for_each_entry(enabler, &mm->enablers, mm_enablers_link) {
 		if (enabler->addr == uaddr &&
 		    (enabler->values & ENABLE_VAL_BIT_MASK) == bit)
 			return true;
@@ -460,7 +460,7 @@ static void user_event_enabler_update(struct user_event *user)
 		next = mm->next;
 		mmap_read_lock(mm->mm);
 
-		list_for_each_entry(enabler, &mm->enablers, link) {
+		list_for_each_entry(enabler, &mm->enablers, mm_enablers_link) {
 			if (enabler->event == user) {
 				attempt = 0;
 				user_event_enabler_write(mm, enabler, true, &attempt);
@@ -496,7 +496,7 @@ static bool user_event_enabler_dup(struct user_event_enabler *orig,
 	refcount_inc(&enabler->event->refcnt);
 
 	/* Enablers not exposed yet, RCU not required */
-	list_add(&enabler->link, &mm->enablers);
+	list_add(&enabler->mm_enablers_link, &mm->enablers);
 
 	return true;
 }
@@ -526,13 +526,15 @@ static struct user_event_mm *user_event_mm_get_all(struct user_event *user)
 	 */
 	rcu_read_lock();
 
-	list_for_each_entry_rcu(mm, &user_event_mms, link)
-		list_for_each_entry_rcu(enabler, &mm->enablers, link)
+	list_for_each_entry_rcu(mm, &user_event_mms, mms_link) {
+		list_for_each_entry_rcu(enabler, &mm->enablers, mm_enablers_link) {
 			if (enabler->event == user) {
 				mm->next = found;
 				found = user_event_mm_get(mm);
 				break;
 			}
+		}
+	}
 
 	rcu_read_unlock();
 
@@ -571,7 +573,7 @@ static void user_event_mm_attach(struct user_event_mm *user_mm, struct task_stru
 	unsigned long flags;
 
 	spin_lock_irqsave(&user_event_mms_lock, flags);
-	list_add_rcu(&user_mm->link, &user_event_mms);
+	list_add_rcu(&user_mm->mms_link, &user_event_mms);
 	spin_unlock_irqrestore(&user_event_mms_lock, flags);
 
 	t->user_event_mm = user_mm;
@@ -600,7 +602,7 @@ static void user_event_mm_destroy(struct user_event_mm *mm)
 {
 	struct user_event_enabler *enabler, *next;
 
-	list_for_each_entry_safe(enabler, next, &mm->enablers, link)
+	list_for_each_entry_safe(enabler, next, &mm->enablers, mm_enablers_link)
 		user_event_enabler_destroy(enabler);
 
 	mmdrop(mm->mm);
@@ -637,7 +639,7 @@ void user_event_mm_remove(struct task_struct *t)
 
 	/* Remove the mm from the list, so it can no longer be enabled */
 	spin_lock_irqsave(&user_event_mms_lock, flags);
-	list_del_rcu(&mm->link);
+	list_del_rcu(&mm->mms_link);
 	spin_unlock_irqrestore(&user_event_mms_lock, flags);
 
 	/*
@@ -685,9 +687,10 @@ void user_event_mm_dup(struct task_struct *t, struct user_event_mm *old_mm)
 
 	rcu_read_lock();
 
-	list_for_each_entry_rcu(enabler, &old_mm->enablers, link)
+	list_for_each_entry_rcu(enabler, &old_mm->enablers, mm_enablers_link) {
 		if (!user_event_enabler_dup(enabler, mm))
 			goto error;
+	}
 
 	rcu_read_unlock();
 
@@ -756,7 +759,7 @@ static struct user_event_enabler
 	 */
 	if (!*write_result) {
 		refcount_inc(&enabler->event->refcnt);
-		list_add_rcu(&enabler->link, &user_mm->enablers);
+		list_add_rcu(&enabler->mm_enablers_link, &user_mm->enablers);
 	}
 
 	mutex_unlock(&event_mutex);
@@ -912,8 +915,8 @@ static void user_event_destroy_validators(struct user_event *user)
 	struct user_event_validator *validator, *next;
 	struct list_head *head = &user->validators;
 
-	list_for_each_entry_safe(validator, next, head, link) {
-		list_del(&validator->link);
+	list_for_each_entry_safe(validator, next, head, user_event_link) {
+		list_del(&validator->user_event_link);
 		kfree(validator);
 	}
 }
@@ -967,7 +970,7 @@ static int user_event_add_field(struct user_event *user, const char *type,
 	validator->offset = offset;
 
 	/* Want sequential access when validating */
-	list_add_tail(&validator->link, &user->validators);
+	list_add_tail(&validator->user_event_link, &user->validators);
 
 add_field:
 	field->type = type;
@@ -1357,7 +1360,7 @@ static int user_event_validate(struct user_event *user, void *data, int len)
 	void *pos, *end = data + len;
 	u32 loc, offset, size;
 
-	list_for_each_entry(validator, head, link) {
+	list_for_each_entry(validator, head, user_event_link) {
 		pos = data + validator->offset;
 
 		/* Already done min_size check, no bounds check here */
@@ -2278,7 +2281,7 @@ static long user_events_ioctl_unreg(unsigned long uarg)
 	 */
 	mutex_lock(&event_mutex);
 
-	list_for_each_entry_safe(enabler, next, &mm->enablers, link)
+	list_for_each_entry_safe(enabler, next, &mm->enablers, mm_enablers_link) {
 		if (enabler->addr == reg.disable_addr &&
 		    (enabler->values & ENABLE_VAL_BIT_MASK) == reg.disable_bit) {
 			set_bit(ENABLE_VAL_FREEING_BIT, ENABLE_BITOPS(enabler));
@@ -2289,6 +2292,7 @@ static long user_events_ioctl_unreg(unsigned long uarg)
 			/* Removed at least one */
 			ret = 0;
 		}
+	}
 
 	mutex_unlock(&event_mutex);
 
-- 
2.25.1


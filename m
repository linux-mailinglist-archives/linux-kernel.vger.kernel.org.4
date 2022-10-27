Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B9D6105DE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 00:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235664AbiJ0Wk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 18:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235629AbiJ0WkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 18:40:17 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB6F65B119;
        Thu, 27 Oct 2022 15:40:15 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.50.127])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1CE2E210DD4C;
        Thu, 27 Oct 2022 15:40:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1CE2E210DD4C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1666910415;
        bh=f2uIrdDboNxBVlV0TX5bvVI0+LO4ZU7b2wcvL6RBD5E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G7Ew7TwvX2FgHZ0Cr/bVEvCqhx7ci+yepweA5NuYFQ/Q2d7v4jBncbB7+DEDxeEmo
         24WdcYJ3+TGe0nOW4rj5zYI1hrlzz2TcTv4E4WCEGgGL6lGmLAqUMixdTuEw7Q+jVs
         V2HBcWOmrn0wdO6dOMY2meYJAeCa+LIuIa9DsjEY=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, dcook@linux.microsoft.com,
        alanau@linux.microsoft.com
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] tracing/user_events: Fixup enable faults asyncly
Date:   Thu, 27 Oct 2022 15:40:11 -0700
Message-Id: <20221027224011.2075-3-beaub@linux.microsoft.com>
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

When events are enabled within the various tracing facilities, such as
ftrace/perf, the event_mutex is held. As events are enabled pages are
accessed. We do not want page faults to occur under this lock. Instead
queue the fault to a workqueue to be handled in a process context safe
way without the lock.

The enable address is disabled while the async fault-in occurs. This
ensures that we don't attempt fault-in more than is necessary. Once the
page has been faulted in, the address write is attempted again. If the
page couldn't fault-in, then we wait until the next time the event is
enabled to prevent any potential infinite loops.

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 kernel/trace/trace_events_user.c | 125 ++++++++++++++++++++++++++++++-
 1 file changed, 121 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 633f24c2a1ac..f1eb8101e053 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -81,11 +81,22 @@ struct user_event_enabler {
 	struct list_head link;
 	struct mm_struct *mm;
 	struct file *file;
+	refcount_t refcnt;
 	unsigned long enable_addr;
 	unsigned int enable_bit: 5,
-		     __reserved: 27;
+		     __reserved: 26,
+		     disabled: 1;
 };
 
+/* Used for asynchronous faulting in of pages */
+struct user_event_enabler_fault {
+	struct work_struct work;
+	struct user_event_enabler *enabler;
+	struct user_event *event;
+};
+
+static struct kmem_cache *fault_cache;
+
 /*
  * Stores per-event properties, as users register events
  * within a file a user_event might be created if it does not
@@ -236,6 +247,19 @@ static void user_event_enabler_destroy(struct user_event_enabler *enabler)
 	kfree(enabler);
 }
 
+static __always_inline struct user_event_enabler
+*user_event_enabler_get(struct user_event_enabler *enabler)
+{
+	refcount_inc(&enabler->refcnt);
+	return enabler;
+}
+
+static void user_event_enabler_put(struct user_event_enabler *enabler)
+{
+	if (refcount_dec_and_test(&enabler->refcnt))
+		user_event_enabler_destroy(enabler);
+}
+
 static void user_event_enabler_remove(struct file *file,
 				      struct user_event *user)
 {
@@ -249,13 +273,93 @@ static void user_event_enabler_remove(struct file *file,
 		if (enabler->file != file)
 			continue;
 
+		enabler->disabled = 0;
 		list_del(&enabler->link);
-		user_event_enabler_destroy(enabler);
+		user_event_enabler_put(enabler);
 	}
 
 	mutex_unlock(&event_mutex);
 }
 
+static void user_event_enabler_write(struct user_event_enabler *enabler,
+				     struct user_event *user);
+
+static void user_event_enabler_fault_fixup(struct work_struct *work)
+{
+	struct user_event_enabler_fault *fault = container_of(
+		work, struct user_event_enabler_fault, work);
+	struct user_event_enabler *enabler = fault->enabler;
+	struct user_event *user = fault->event;
+	struct mm_struct *mm = enabler->mm;
+	unsigned long uaddr = enabler->enable_addr;
+	bool unlocked = false;
+	int ret;
+
+	might_sleep();
+
+	mmap_read_lock(mm);
+
+	ret = fixup_user_fault(mm, uaddr, FAULT_FLAG_WRITE | FAULT_FLAG_REMOTE,
+			       &unlocked);
+
+	mmap_read_unlock(mm);
+
+	if (ret)
+		pr_warn("user_events: Fixup fault failed with %d "
+			"for mm: 0x%pK offset: 0x%llx event: %s\n", ret, mm,
+			(unsigned long long)uaddr, EVENT_NAME(user));
+
+	/* Prevent state changes from racing */
+	mutex_lock(&event_mutex);
+
+	/*
+	 * If we managed to get the page, re-issue the write. We do not
+	 * want to get into a possible infinite loop, which is why we only
+	 * attempt again directly if the page came in. If we couldn't get
+	 * the page here, then we will try again the next time the event is
+	 * enabled/disabled.
+	 */
+	enabler->disabled = 0;
+
+	if (!ret)
+		user_event_enabler_write(enabler, user);
+
+	mutex_unlock(&event_mutex);
+
+	refcount_dec(&user->refcnt);
+	user_event_enabler_put(enabler);
+	kmem_cache_free(fault_cache, fault);
+}
+
+static bool user_event_enabler_queue_fault(struct user_event_enabler *enabler,
+					   struct user_event *user)
+{
+	struct user_event_enabler_fault *fault;
+
+	fault = kmem_cache_zalloc(fault_cache, GFP_NOWAIT | __GFP_NOWARN);
+
+	if (!fault)
+		return false;
+
+	INIT_WORK(&fault->work, user_event_enabler_fault_fixup);
+	fault->enabler = user_event_enabler_get(enabler);
+	fault->event = user;
+
+	refcount_inc(&user->refcnt);
+	enabler->disabled = 1;
+
+	if (!schedule_work(&fault->work)) {
+		enabler->disabled = 0;
+		refcount_dec(&user->refcnt);
+		user_event_enabler_put(enabler);
+		kmem_cache_free(fault_cache, fault);
+
+		return false;
+	}
+
+	return true;
+}
+
 static void user_event_enabler_write(struct user_event_enabler *enabler,
 				     struct user_event *user)
 {
@@ -266,6 +370,11 @@ static void user_event_enabler_write(struct user_event_enabler *enabler,
 	void *kaddr;
 	int ret;
 
+	lockdep_assert_held(&event_mutex);
+
+	if (unlikely(enabler->disabled))
+		return;
+
 	mmap_read_lock(mm);
 
 	ret = pin_user_pages_remote(mm, uaddr, 1, FOLL_WRITE | FOLL_NOFAULT,
@@ -273,8 +382,10 @@ static void user_event_enabler_write(struct user_event_enabler *enabler,
 
 	mmap_read_unlock(mm);
 
-	if (ret <= 0) {
-		pr_warn("user_events: Enable write failed\n");
+	if (unlikely(ret <= 0)) {
+		if (!user_event_enabler_queue_fault(enabler, user))
+			pr_warn("user_events: Unable to queue fault handler\n");
+
 		return;
 	}
 
@@ -321,6 +432,7 @@ static struct user_event_enabler
 	enabler->file = file;
 	enabler->enable_addr = (unsigned long)reg->enable_addr;
 	enabler->enable_bit = reg->enable_bit;
+	refcount_set(&enabler->refcnt, 1);
 
 	/* Prevents state changes from racing with new enablers */
 	mutex_lock(&event_mutex);
@@ -1902,6 +2014,11 @@ static int __init trace_events_user_init(void)
 {
 	int ret;
 
+	fault_cache = KMEM_CACHE(user_event_enabler_fault, 0);
+
+	if (!fault_cache)
+		return -ENOMEM;
+
 	init_group = user_event_group_create(&init_user_ns);
 
 	if (!init_group)
-- 
2.25.1


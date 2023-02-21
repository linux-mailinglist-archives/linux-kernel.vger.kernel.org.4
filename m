Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A6369E946
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 22:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjBUVMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 16:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjBUVLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 16:11:52 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E0EB305C2;
        Tue, 21 Feb 2023 13:11:50 -0800 (PST)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id E3B5A20B9C3D;
        Tue, 21 Feb 2023 13:11:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E3B5A20B9C3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1677013910;
        bh=LAT6es1zlcxHgyXQ+ccAd1DGKcAvO/9IswEU0C+E8Yk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sD/1eaVnzd86RfhuQGs9V1soHDsH7AjM4ll3w5rmohEWwV3OxFGG6XcBwMOm64c7a
         vnPXQliyyk3o1rTE4U2EYLVD5T/2Yany8n6FKAwF6q4dBLODMzeyqKlJKd6ezroU7z
         lPJ2zTjDZZbJ63Li5seDtiZFeFZ3DDyOQdlWCWyw=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, dcook@linux.microsoft.com,
        alanau@linux.microsoft.com, brauner@kernel.org,
        akpm@linux-foundation.org, ebiederm@xmission.com,
        keescook@chromium.org, tglx@linutronix.de
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v8 04/11] tracing/user_events: Fixup enable faults asyncly
Date:   Tue, 21 Feb 2023 13:11:36 -0800
Message-Id: <20230221211143.574-5-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230221211143.574-1-beaub@linux.microsoft.com>
References: <20230221211143.574-1-beaub@linux.microsoft.com>
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

The enable address is marked faulting while the async fault-in occurs.
This ensures that we don't attempt to fault-in more than is necessary.
Once the page has been faulted in, an address write is re-attempted.
If the page couldn't fault-in, then we wait until the next time the
event is enabled to prevent any potential infinite loops.

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 kernel/trace/trace_events_user.c | 120 +++++++++++++++++++++++++++++--
 1 file changed, 114 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 553a82ee7aeb..86bda1660536 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -99,9 +99,23 @@ struct user_event_enabler {
 /* Bits 0-5 are for the bit to update upon enable/disable (0-63 allowed) */
 #define ENABLE_VAL_BIT_MASK 0x3F
 
+/* Bit 6 is for faulting status of enablement */
+#define ENABLE_VAL_FAULTING_BIT 6
+
 /* Only duplicate the bit value */
 #define ENABLE_VAL_DUP_MASK ENABLE_VAL_BIT_MASK
 
+#define ENABLE_BITOPS(e) ((unsigned long *)&(e)->values)
+
+/* Used for asynchronous faulting in of pages */
+struct user_event_enabler_fault {
+	struct work_struct work;
+	struct user_event_mm *mm;
+	struct user_event_enabler *enabler;
+};
+
+static struct kmem_cache *fault_cache;
+
 /* Global list of memory descriptors using user_events */
 static LIST_HEAD(user_event_mms);
 static DEFINE_SPINLOCK(user_event_mms_lock);
@@ -263,7 +277,85 @@ static int user_event_mm_fault_in(struct user_event_mm *mm, unsigned long uaddr)
 }
 
 static int user_event_enabler_write(struct user_event_mm *mm,
-				    struct user_event_enabler *enabler)
+				    struct user_event_enabler *enabler,
+				    bool fixup_fault);
+
+static void user_event_enabler_fault_fixup(struct work_struct *work)
+{
+	struct user_event_enabler_fault *fault = container_of(
+		work, struct user_event_enabler_fault, work);
+	struct user_event_enabler *enabler = fault->enabler;
+	struct user_event_mm *mm = fault->mm;
+	unsigned long uaddr = enabler->addr;
+	int ret;
+
+	ret = user_event_mm_fault_in(mm, uaddr);
+
+	if (ret && ret != -ENOENT) {
+		struct user_event *user = enabler->event;
+
+		pr_warn("user_events: Fault for mm: 0x%pK @ 0x%llx event: %s\n",
+			mm->mm, (unsigned long long)uaddr, EVENT_NAME(user));
+	}
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
+	clear_bit(ENABLE_VAL_FAULTING_BIT, ENABLE_BITOPS(enabler));
+
+	if (!ret) {
+		mmap_read_lock(mm->mm);
+		user_event_enabler_write(mm, enabler, true);
+		mmap_read_unlock(mm->mm);
+	}
+
+	mutex_unlock(&event_mutex);
+
+	/* In all cases we no longer need the mm or fault */
+	user_event_mm_put(mm);
+	kmem_cache_free(fault_cache, fault);
+}
+
+static bool user_event_enabler_queue_fault(struct user_event_mm *mm,
+					   struct user_event_enabler *enabler)
+{
+	struct user_event_enabler_fault *fault;
+
+	fault = kmem_cache_zalloc(fault_cache, GFP_NOWAIT | __GFP_NOWARN);
+
+	if (!fault)
+		return false;
+
+	INIT_WORK(&fault->work, user_event_enabler_fault_fixup);
+	fault->mm = user_event_mm_get(mm);
+	fault->enabler = enabler;
+
+	/* Don't try to queue in again while we have a pending fault */
+	set_bit(ENABLE_VAL_FAULTING_BIT, ENABLE_BITOPS(enabler));
+
+	if (!schedule_work(&fault->work)) {
+		/* Allow another attempt later */
+		clear_bit(ENABLE_VAL_FAULTING_BIT, ENABLE_BITOPS(enabler));
+
+		user_event_mm_put(mm);
+		kmem_cache_free(fault_cache, fault);
+
+		return false;
+	}
+
+	return true;
+}
+
+static int user_event_enabler_write(struct user_event_mm *mm,
+				    struct user_event_enabler *enabler,
+				    bool fixup_fault)
 {
 	unsigned long uaddr = enabler->addr;
 	unsigned long *ptr;
@@ -278,11 +370,19 @@ static int user_event_enabler_write(struct user_event_mm *mm,
 	if (refcount_read(&mm->tasks) == 0)
 		return -ENOENT;
 
+	if (unlikely(test_bit(ENABLE_VAL_FAULTING_BIT, ENABLE_BITOPS(enabler))))
+		return -EBUSY;
+
 	ret = pin_user_pages_remote(mm->mm, uaddr, 1, FOLL_WRITE | FOLL_NOFAULT,
 				    &page, NULL, NULL);
 
-	if (ret <= 0) {
-		pr_warn("user_events: Enable write failed\n");
+	if (unlikely(ret <= 0)) {
+		if (!fixup_fault)
+			return -EFAULT;
+
+		if (!user_event_enabler_queue_fault(mm, enabler))
+			pr_warn("user_events: Unable to queue fault handler\n");
+
 		return -EFAULT;
 	}
 
@@ -314,7 +414,7 @@ static void user_event_enabler_update(struct user_event *user)
 
 		list_for_each_entry_rcu(enabler, &mm->enablers, link)
 			if (enabler->event == user)
-				user_event_enabler_write(mm, enabler);
+				user_event_enabler_write(mm, enabler, true);
 
 		rcu_read_unlock();
 		mmap_read_unlock(mm->mm);
@@ -562,7 +662,7 @@ static struct user_event_enabler
 
 	/* Attempt to reflect the current state within the process */
 	mmap_read_lock(user_mm->mm);
-	*write_result = user_event_enabler_write(user_mm, enabler);
+	*write_result = user_event_enabler_write(user_mm, enabler, false);
 	mmap_read_unlock(user_mm->mm);
 
 	/*
@@ -2201,16 +2301,24 @@ static int __init trace_events_user_init(void)
 {
 	int ret;
 
+	fault_cache = KMEM_CACHE(user_event_enabler_fault, 0);
+
+	if (!fault_cache)
+		return -ENOMEM;
+
 	init_group = user_event_group_create(&init_user_ns);
 
-	if (!init_group)
+	if (!init_group) {
+		kmem_cache_destroy(fault_cache);
 		return -ENOMEM;
+	}
 
 	ret = create_user_tracefs();
 
 	if (ret) {
 		pr_warn("user_events could not register with tracefs\n");
 		user_event_group_destroy(init_group);
+		kmem_cache_destroy(fault_cache);
 		init_group = NULL;
 		return ret;
 	}
-- 
2.25.1


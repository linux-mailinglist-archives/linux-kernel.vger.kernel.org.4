Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFA56EEA6E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 00:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235929AbjDYWv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 18:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236248AbjDYWvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 18:51:19 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A66DA9766;
        Tue, 25 Apr 2023 15:51:17 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1808621C2B33;
        Tue, 25 Apr 2023 15:51:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1808621C2B33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1682463077;
        bh=S6vaCMPQuD92cWCedlBij+dfdn0laVton5ehbi63OWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E76kuiCWVbRZgMz/ZLod85efjDohowBDBRu9u4F+7o00+4HnTGx2qXxJs/U8/eeJ9
         ph3C0ZCPkkhKtMMgCuj5qFPzsVufXE1hC65Be0KG/kPT80hpJ7sNb94xYGgkBm+C0y
         qKLzVBL6g/V1uNE8A8A+Vq8lotDCatbkkg7QXggk=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, dcook@linux.microsoft.com,
        alanau@linux.microsoft.com
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] tracing/user_events: Limit max fault-in attempts
Date:   Tue, 25 Apr 2023 15:51:07 -0700
Message-Id: <20230425225107.8525-5-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230425225107.8525-1-beaub@linux.microsoft.com>
References: <20230425225107.8525-1-beaub@linux.microsoft.com>
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

When event enablement changes, user_events attempts to update a bit in
the user process. If a fault is hit, an attempt to fault-in the page and
the write is retried if the page made it in. While this normally requires
a couple attempts, it is possible a bad user process could attempt to
cause infinite loops.

Ensure fault-in attempts either sync or async are limited to a max of 10
attempts for each update. When the max is hit, return -EFAULT so another
attempt is not made in all cases.

Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 kernel/trace/trace_events_user.c | 49 +++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 4fc099fc7637..cab2c5891758 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -123,6 +123,7 @@ struct user_event_enabler_fault {
 	struct work_struct		work;
 	struct user_event_mm		*mm;
 	struct user_event_enabler	*enabler;
+	int				attempt;
 };
 
 static struct kmem_cache *fault_cache;
@@ -266,11 +267,19 @@ static void user_event_enabler_destroy(struct user_event_enabler *enabler)
 	kfree(enabler);
 }
 
-static int user_event_mm_fault_in(struct user_event_mm *mm, unsigned long uaddr)
+static int user_event_mm_fault_in(struct user_event_mm *mm, unsigned long uaddr,
+				  int attempt)
 {
 	bool unlocked;
 	int ret;
 
+	/*
+	 * Normally this is low, ensure that it cannot be taken advantage of by
+	 * bad user processes to cause excessive looping.
+	 */
+	if (attempt > 10)
+		return -EFAULT;
+
 	mmap_read_lock(mm->mm);
 
 	/* Ensure MM has tasks, cannot use after exit_mm() */
@@ -289,7 +298,7 @@ static int user_event_mm_fault_in(struct user_event_mm *mm, unsigned long uaddr)
 
 static int user_event_enabler_write(struct user_event_mm *mm,
 				    struct user_event_enabler *enabler,
-				    bool fixup_fault);
+				    bool fixup_fault, int *attempt);
 
 static void user_event_enabler_fault_fixup(struct work_struct *work)
 {
@@ -298,9 +307,10 @@ static void user_event_enabler_fault_fixup(struct work_struct *work)
 	struct user_event_enabler *enabler = fault->enabler;
 	struct user_event_mm *mm = fault->mm;
 	unsigned long uaddr = enabler->addr;
+	int attempt = fault->attempt;
 	int ret;
 
-	ret = user_event_mm_fault_in(mm, uaddr);
+	ret = user_event_mm_fault_in(mm, uaddr, attempt);
 
 	if (ret && ret != -ENOENT) {
 		struct user_event *user = enabler->event;
@@ -329,7 +339,7 @@ static void user_event_enabler_fault_fixup(struct work_struct *work)
 
 	if (!ret) {
 		mmap_read_lock(mm->mm);
-		user_event_enabler_write(mm, enabler, true);
+		user_event_enabler_write(mm, enabler, true, &attempt);
 		mmap_read_unlock(mm->mm);
 	}
 out:
@@ -341,7 +351,8 @@ static void user_event_enabler_fault_fixup(struct work_struct *work)
 }
 
 static bool user_event_enabler_queue_fault(struct user_event_mm *mm,
-					   struct user_event_enabler *enabler)
+					   struct user_event_enabler *enabler,
+					   int attempt)
 {
 	struct user_event_enabler_fault *fault;
 
@@ -353,6 +364,7 @@ static bool user_event_enabler_queue_fault(struct user_event_mm *mm,
 	INIT_WORK(&fault->work, user_event_enabler_fault_fixup);
 	fault->mm = user_event_mm_get(mm);
 	fault->enabler = enabler;
+	fault->attempt = attempt;
 
 	/* Don't try to queue in again while we have a pending fault */
 	set_bit(ENABLE_VAL_FAULTING_BIT, ENABLE_BITOPS(enabler));
@@ -372,7 +384,7 @@ static bool user_event_enabler_queue_fault(struct user_event_mm *mm,
 
 static int user_event_enabler_write(struct user_event_mm *mm,
 				    struct user_event_enabler *enabler,
-				    bool fixup_fault)
+				    bool fixup_fault, int *attempt)
 {
 	unsigned long uaddr = enabler->addr;
 	unsigned long *ptr;
@@ -383,6 +395,8 @@ static int user_event_enabler_write(struct user_event_mm *mm,
 	lockdep_assert_held(&event_mutex);
 	mmap_assert_locked(mm->mm);
 
+	*attempt += 1;
+
 	/* Ensure MM has tasks, cannot use after exit_mm() */
 	if (refcount_read(&mm->tasks) == 0)
 		return -ENOENT;
@@ -398,7 +412,7 @@ static int user_event_enabler_write(struct user_event_mm *mm,
 		if (!fixup_fault)
 			return -EFAULT;
 
-		if (!user_event_enabler_queue_fault(mm, enabler))
+		if (!user_event_enabler_queue_fault(mm, enabler, *attempt))
 			pr_warn("user_events: Unable to queue fault handler\n");
 
 		return -EFAULT;
@@ -439,15 +453,19 @@ static void user_event_enabler_update(struct user_event *user)
 	struct user_event_enabler *enabler;
 	struct user_event_mm *mm = user_event_mm_get_all(user);
 	struct user_event_mm *next;
+	int attempt;
 
 	while (mm) {
 		next = mm->next;
 		mmap_read_lock(mm->mm);
 		rcu_read_lock();
 
-		list_for_each_entry_rcu(enabler, &mm->enablers, link)
-			if (enabler->event == user)
-				user_event_enabler_write(mm, enabler, true);
+		list_for_each_entry_rcu(enabler, &mm->enablers, link) {
+			if (enabler->event == user) {
+				attempt = 0;
+				user_event_enabler_write(mm, enabler, true, &attempt);
+			}
+		}
 
 		rcu_read_unlock();
 		mmap_read_unlock(mm->mm);
@@ -695,6 +713,7 @@ static struct user_event_enabler
 	struct user_event_enabler *enabler;
 	struct user_event_mm *user_mm;
 	unsigned long uaddr = (unsigned long)reg->enable_addr;
+	int attempt = 0;
 
 	user_mm = current_user_event_mm();
 
@@ -715,7 +734,8 @@ static struct user_event_enabler
 
 	/* Attempt to reflect the current state within the process */
 	mmap_read_lock(user_mm->mm);
-	*write_result = user_event_enabler_write(user_mm, enabler, false);
+	*write_result = user_event_enabler_write(user_mm, enabler, false,
+						 &attempt);
 	mmap_read_unlock(user_mm->mm);
 
 	/*
@@ -735,7 +755,7 @@ static struct user_event_enabler
 
 	if (*write_result) {
 		/* Attempt to fault-in and retry if it worked */
-		if (!user_event_mm_fault_in(user_mm, uaddr))
+		if (!user_event_mm_fault_in(user_mm, uaddr, attempt))
 			goto retry;
 
 		kfree(enabler);
@@ -2192,6 +2212,7 @@ static int user_event_mm_clear_bit(struct user_event_mm *user_mm,
 {
 	struct user_event_enabler enabler;
 	int result;
+	int attempt = 0;
 
 	memset(&enabler, 0, sizeof(enabler));
 	enabler.addr = uaddr;
@@ -2202,14 +2223,14 @@ static int user_event_mm_clear_bit(struct user_event_mm *user_mm,
 
 	/* Force the bit to be cleared, since no event is attached */
 	mmap_read_lock(user_mm->mm);
-	result = user_event_enabler_write(user_mm, &enabler, false);
+	result = user_event_enabler_write(user_mm, &enabler, false, &attempt);
 	mmap_read_unlock(user_mm->mm);
 
 	mutex_unlock(&event_mutex);
 
 	if (result) {
 		/* Attempt to fault-in and retry if it worked */
-		if (!user_event_mm_fault_in(user_mm, uaddr))
+		if (!user_event_mm_fault_in(user_mm, uaddr, attempt))
 			goto retry;
 	}
 
-- 
2.25.1


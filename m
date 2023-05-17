Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86FA705BDD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 02:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbjEQAOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 20:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjEQAOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 20:14:22 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF436113;
        Tue, 16 May 2023 17:14:20 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5891A20ECCB8;
        Tue, 16 May 2023 17:14:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5891A20ECCB8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1684282460;
        bh=zfvI4rOs9e+SyQp3rkkz6zejPeTjlk9i3u8F4xcNryQ=;
        h=From:To:Cc:Subject:Date:From;
        b=jYk5dM5EQcZmwOn2bDynmUK6hWXrJz28RJ5wvwKBOYwqL8KCj149agPc2PtndjvQD
         KVWTfuf0sJmtKRBMaNYzKCrbgXaJymcwSoJuNtAFoZI5HCTR87S2GhBSLZ8N4ynftP
         4MIct94/P9kMAxA5vLAFX91asFZhBm3AF0n+MBpY=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        ast@kernel.org
Subject: [PATCH v2] tracing/user_events: Use non-RCU context for enabler writes
Date:   Tue, 16 May 2023 17:14:14 -0700
Message-Id: <20230517001414.307-1-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
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

Currently when events are enabled/disabled a top level mm enumeration is
done in a non-RCU context, however, the enablers are still in a
RCU-context. Each enabler is updated via user_event_enabler_write() which
uses pin_user_pages_remote(). This function can reschedule and should not
be used from a RCU-context.

Use the same approach as the top level mm enumeration, which builds a
temporary list of target enablers within a RCU-context then exits. Then
use list from a non-RCU context when calling user_event_enabler_write().

Link: https://lore.kernel.org/all/20230515165707.hv65ekwp2djkjj5i@MacBook-Pro-8.local/
Fixes: 7235759084a4 ("tracing/user_events: Use remote writes for event enablement")
Reported-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
Changes in v2:
  - Remove break satement that prevents more than 1 enabler in MM for same
    event (rare, but possible).

 kernel/trace/trace_events_user.c | 68 +++++++++++++++++++++++++-------
 1 file changed, 54 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index b1ecd7677642..3cd8133d9e42 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -96,12 +96,15 @@ struct user_event {
  * these to track enablement sites that are tied to an event.
  */
 struct user_event_enabler {
-	struct list_head	link;
-	struct user_event	*event;
-	unsigned long		addr;
+	struct list_head		link;
+	struct user_event		*event;
+	unsigned long			addr;
+
+	/* Used to build a list within RCU context for a non-RCU context. */
+	struct user_event_enabler	*next;
 
 	/* Track enable bit, flags, etc. Aligned for bitops. */
-	unsigned int		values;
+	unsigned int			values;
 };
 
 /* Bits 0-5 are for the bit to update upon enable/disable (0-63 allowed) */
@@ -165,6 +168,8 @@ static int user_event_parse(struct user_event_group *group, char *name,
 			    char *args, char *flags,
 			    struct user_event **newuser);
 
+static struct user_event_enabler
+*user_event_enabler_get_all(struct user_event_mm *mm, struct user_event *user);
 static struct user_event_mm *user_event_mm_get(struct user_event_mm *mm);
 static struct user_event_mm *user_event_mm_get_all(struct user_event *user);
 static void user_event_mm_put(struct user_event_mm *mm);
@@ -450,25 +455,28 @@ static bool user_event_enabler_exists(struct user_event_mm *mm,
 
 static void user_event_enabler_update(struct user_event *user)
 {
-	struct user_event_enabler *enabler;
 	struct user_event_mm *mm = user_event_mm_get_all(user);
+	struct user_event_enabler *enabler;
 	struct user_event_mm *next;
 	int attempt;
 
 	while (mm) {
 		next = mm->next;
+		enabler = user_event_enabler_get_all(mm, user);
+
+		if (unlikely(!enabler))
+			goto next_mm;
+
 		mmap_read_lock(mm->mm);
-		rcu_read_lock();
 
-		list_for_each_entry_rcu(enabler, &mm->enablers, link) {
-			if (enabler->event == user) {
-				attempt = 0;
-				user_event_enabler_write(mm, enabler, true, &attempt);
-			}
+		while (enabler) {
+			attempt = 0;
+			user_event_enabler_write(mm, enabler, true, &attempt);
+			enabler = enabler->next;
 		}
 
-		rcu_read_unlock();
 		mmap_read_unlock(mm->mm);
+next_mm:
 		user_event_mm_put(mm);
 		mm = next;
 	}
@@ -500,6 +508,34 @@ static bool user_event_enabler_dup(struct user_event_enabler *orig,
 	return true;
 }
 
+static struct user_event_enabler
+*user_event_enabler_get_all(struct user_event_mm *mm, struct user_event *user)
+{
+	struct user_event_enabler *found = NULL;
+	struct user_event_enabler *enabler;
+
+	lockdep_assert_held(&event_mutex);
+
+	/*
+	 * We need to get enablers from within a RCU context to a non-RCU
+	 * context quickly. We build a single linked list under the RCU
+	 * to enable this. Typically this is required for doing actions
+	 * on enablers that might sleep or schedule.
+	 */
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(enabler, &mm->enablers, link) {
+		if (enabler->event == user) {
+			enabler->next = found;
+			found = enabler;
+		}
+	}
+
+	rcu_read_unlock();
+
+	return found;
+}
+
 static struct user_event_mm *user_event_mm_get(struct user_event_mm *mm)
 {
 	refcount_inc(&mm->refcnt);
@@ -513,6 +549,8 @@ static struct user_event_mm *user_event_mm_get_all(struct user_event *user)
 	struct user_event_enabler *enabler;
 	struct user_event_mm *mm;
 
+	lockdep_assert_held(&event_mutex);
+
 	/*
 	 * We do not want to block fork/exec while enablements are being
 	 * updated, so we use RCU to walk the current tasks that have used
@@ -525,13 +563,15 @@ static struct user_event_mm *user_event_mm_get_all(struct user_event *user)
 	 */
 	rcu_read_lock();
 
-	list_for_each_entry_rcu(mm, &user_event_mms, link)
-		list_for_each_entry_rcu(enabler, &mm->enablers, link)
+	list_for_each_entry_rcu(mm, &user_event_mms, link) {
+		list_for_each_entry_rcu(enabler, &mm->enablers, link) {
 			if (enabler->event == user) {
 				mm->next = found;
 				found = user_event_mm_get(mm);
 				break;
 			}
+		}
+	}
 
 	rcu_read_unlock();
 

base-commit: 3862f86c1529fa0016de6344eb974877b4cd3838
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA00E705B88
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 01:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjEPX66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 19:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjEPX6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 19:58:55 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 39E7361AD;
        Tue, 16 May 2023 16:58:50 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id 19E4820ECCB3;
        Tue, 16 May 2023 16:58:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 19E4820ECCB3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1684281529;
        bh=KgFoQk+gBOrhdcQ1wdSjwMmEkduDiZjL6cKJIOny6aY=;
        h=From:To:Cc:Subject:Date:From;
        b=GtL9MLVit6qxc7g42Vr2dlkBh8yV89gybMB3RGGhqdSqfVM8qfFzqItGNYde2tynr
         CYiObjnosvJguo2HC1EUM75a8YcGQrGD1qpkqPJLoKnEIWkNRgyZJE0ZpITrueFfPw
         T+GHgYv2gwzqqsYcMy00YXYBM1ToJbfQyBbLWpgw=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        ast@kernel.org
Subject: [PATCH] tracing/user_events: Use non-RCU context for enabler writes
Date:   Tue, 16 May 2023 16:58:44 -0700
Message-Id: <20230516235844.9303-1-beaub@linux.microsoft.com>
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
 kernel/trace/trace_events_user.c | 69 +++++++++++++++++++++++++-------
 1 file changed, 55 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index b1ecd7677642..00d956e7e35a 100644
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
@@ -500,6 +508,35 @@ static bool user_event_enabler_dup(struct user_event_enabler *orig,
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
+			break;
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
@@ -513,6 +550,8 @@ static struct user_event_mm *user_event_mm_get_all(struct user_event *user)
 	struct user_event_enabler *enabler;
 	struct user_event_mm *mm;
 
+	lockdep_assert_held(&event_mutex);
+
 	/*
 	 * We do not want to block fork/exec while enablements are being
 	 * updated, so we use RCU to walk the current tasks that have used
@@ -525,13 +564,15 @@ static struct user_event_mm *user_event_mm_get_all(struct user_event *user)
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


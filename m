Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61B070A331
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 01:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbjESXIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 19:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbjESXI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 19:08:26 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 871A11B7;
        Fri, 19 May 2023 16:08:25 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id E5CF920FB618;
        Fri, 19 May 2023 16:08:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E5CF920FB618
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1684537705;
        bh=VuJim+olM4mdhP+9flU3IJ60VgfVV5tOztn8lZStPJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EA90QIJKk7Kzx8LR8kLyEGzeafYINfLECxf+o873foSJutgK6yUMqSqpFLQzJNcrg
         Tz2xfOFTTScDouLpbyQDcjhjegnMdskIsEl00QcJHkv+qfIyHLUKsk8hL3A9VaS2nE
         blpwdRhDpEZI+77H1b2c9W9gqGV/3MS8ziQfOuCw=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, ast@kernel.org
Subject: [PATCH v3 4/4] tracing/user_events: Document user_event_mm one-shot list usage
Date:   Fri, 19 May 2023 16:07:41 -0700
Message-Id: <20230519230741.669-5-beaub@linux.microsoft.com>
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

During 6.4 development it became clear that the one-shot list used by
the user_event_mm's next field was confusing to others. It is not clear
how this list is protected or what the next field usage is for unless
you are familiar with the code.

Add comments into the user_event_mm struct indicating lock requirement
and usage. Also document how and why this approach was used via comments
in both user_event_enabler_update() and user_event_mm_get_all() and the
rules to properly use it.

Link: https://lore.kernel.org/linux-trace-kernel/CAHk-=wicngggxVpbnrYHjRTwGE0WYscPRM+L2HO2BF8ia1EXgQ@mail.gmail.com/

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 include/linux/user_events.h      |  1 +
 kernel/trace/trace_events_user.c | 23 ++++++++++++++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/include/linux/user_events.h b/include/linux/user_events.h
index 17d452b389de..8afa8c3a0973 100644
--- a/include/linux/user_events.h
+++ b/include/linux/user_events.h
@@ -20,6 +20,7 @@ struct user_event_mm {
 	struct list_head	mms_link;
 	struct list_head	enablers;
 	struct mm_struct	*mm;
+	/* Used for one-shot lists, protected by event_mutex */
 	struct user_event_mm	*next;
 	refcount_t		refcnt;
 	refcount_t		tasks;
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 360d0f965cb8..6058ca2de3be 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -450,12 +450,25 @@ static bool user_event_enabler_exists(struct user_event_mm *mm,
 static void user_event_enabler_update(struct user_event *user)
 {
 	struct user_event_enabler *enabler;
-	struct user_event_mm *mm = user_event_mm_get_all(user);
 	struct user_event_mm *next;
+	struct user_event_mm *mm;
 	int attempt;
 
 	lockdep_assert_held(&event_mutex);
 
+	/*
+	 * We need to build a one-shot list of all the mms that have an
+	 * enabler for the user_event passed in. This list is only valid
+	 * while holding the event_mutex. The only reason for this is due
+	 * to the global mm list being RCU protected and we use methods
+	 * which can wait (mmap_read_lock and pin_user_pages_remote).
+	 *
+	 * NOTE: user_event_mm_get_all() increments the ref count of each
+	 * mm that is added to the list to prevent removal timing windows.
+	 * We must always put each mm after they are used, which may wait.
+	 */
+	mm = user_event_mm_get_all(user);
+
 	while (mm) {
 		next = mm->next;
 		mmap_read_lock(mm->mm);
@@ -514,6 +527,14 @@ static struct user_event_mm *user_event_mm_get_all(struct user_event *user)
 	struct user_event_enabler *enabler;
 	struct user_event_mm *mm;
 
+	/*
+	 * We use the mm->next field to build a one-shot list from the global
+	 * RCU protected list. To build this list the event_mutex must be held.
+	 * This lets us build a list without requiring allocs that could fail
+	 * when user based events are most wanted for diagnostics.
+	 */
+	lockdep_assert_held(&event_mutex);
+
 	/*
 	 * We do not want to block fork/exec while enablements are being
 	 * updated, so we use RCU to walk the current tasks that have used
-- 
2.25.1


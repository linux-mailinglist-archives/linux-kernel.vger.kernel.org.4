Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D742770A32F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 01:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjESXIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 19:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjESXIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 19:08:25 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C5940134;
        Fri, 19 May 2023 16:08:24 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id 25C7720FB60F;
        Fri, 19 May 2023 16:08:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 25C7720FB60F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1684537704;
        bh=vRi8je1QLSvf95lXlJL6mnqVr6zv6mpwqsyVZIQVvN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m9vzyWMyaFq5kuhN2BMcgFHXkUYtdUOvsQmo3nKoDhVYZGzpdgt2lo1Jr/QN8n6sD
         1qM2/BZoXIfbh07pgGaHntTuUvtEuu2EKMykUkvvKfpTYaIF1dseEg0yYwQwq+oV/c
         hQYir2gWcj65d/ZPA4hzxBhh5bUz92cXtQmd0c1M=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, ast@kernel.org
Subject: [PATCH v3 1/4] tracing/user_events: Split up mm alloc and attach
Date:   Fri, 19 May 2023 16:07:38 -0700
Message-Id: <20230519230741.669-2-beaub@linux.microsoft.com>
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

From: Linus Torvalds <torvalds@linux-foundation.org>

When a new mm is being created in a fork() path it currently is
allocated and then attached in one go. This leaves the mm exposed out to
the tracing register callbacks while any parent enabler locations are
copied in. This should not happen.

Split up mm alloc and attach as unique operations. When duplicating
enablers, first alloc, then duplicate, and only upon success, attach.
This prevents any timing window outside of the event_reg mutex for
enablement walking. This allows for dropping RCU requirement for
enablement walking in later patches.

Link: https://lore.kernel.org/linux-trace-kernel/CAHk-=whTBvXJuoi_kACo3qi5WZUmRrhyA-_=rRFsycTytmB6qw@mail.gmail.com/

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[ change log written by Beau Belgrave ]
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 kernel/trace/trace_events_user.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index b1ecd7677642..b2aecbfbbd24 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -538,10 +538,9 @@ static struct user_event_mm *user_event_mm_get_all(struct user_event *user)
 	return found;
 }
 
-static struct user_event_mm *user_event_mm_create(struct task_struct *t)
+static struct user_event_mm *user_event_mm_alloc(struct task_struct *t)
 {
 	struct user_event_mm *user_mm;
-	unsigned long flags;
 
 	user_mm = kzalloc(sizeof(*user_mm), GFP_KERNEL_ACCOUNT);
 
@@ -553,12 +552,6 @@ static struct user_event_mm *user_event_mm_create(struct task_struct *t)
 	refcount_set(&user_mm->refcnt, 1);
 	refcount_set(&user_mm->tasks, 1);
 
-	spin_lock_irqsave(&user_event_mms_lock, flags);
-	list_add_rcu(&user_mm->link, &user_event_mms);
-	spin_unlock_irqrestore(&user_event_mms_lock, flags);
-
-	t->user_event_mm = user_mm;
-
 	/*
 	 * The lifetime of the memory descriptor can slightly outlast
 	 * the task lifetime if a ref to the user_event_mm is taken
@@ -572,6 +565,17 @@ static struct user_event_mm *user_event_mm_create(struct task_struct *t)
 	return user_mm;
 }
 
+static void user_event_mm_attach(struct user_event_mm *user_mm, struct task_struct *t)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&user_event_mms_lock, flags);
+	list_add_rcu(&user_mm->link, &user_event_mms);
+	spin_unlock_irqrestore(&user_event_mms_lock, flags);
+
+	t->user_event_mm = user_mm;
+}
+
 static struct user_event_mm *current_user_event_mm(void)
 {
 	struct user_event_mm *user_mm = current->user_event_mm;
@@ -579,10 +583,12 @@ static struct user_event_mm *current_user_event_mm(void)
 	if (user_mm)
 		goto inc;
 
-	user_mm = user_event_mm_create(current);
+	user_mm = user_event_mm_alloc(current);
 
 	if (!user_mm)
 		goto error;
+
+	user_event_mm_attach(user_mm, current);
 inc:
 	refcount_inc(&user_mm->refcnt);
 error:
@@ -670,7 +676,7 @@ void user_event_mm_remove(struct task_struct *t)
 
 void user_event_mm_dup(struct task_struct *t, struct user_event_mm *old_mm)
 {
-	struct user_event_mm *mm = user_event_mm_create(t);
+	struct user_event_mm *mm = user_event_mm_alloc(t);
 	struct user_event_enabler *enabler;
 
 	if (!mm)
@@ -684,10 +690,11 @@ void user_event_mm_dup(struct task_struct *t, struct user_event_mm *old_mm)
 
 	rcu_read_unlock();
 
+	user_event_mm_attach(mm, t);
 	return;
 error:
 	rcu_read_unlock();
-	user_event_mm_remove(t);
+	user_event_mm_destroy(mm);
 }
 
 static bool current_user_event_enabler_exists(unsigned long uaddr,
-- 
2.25.1


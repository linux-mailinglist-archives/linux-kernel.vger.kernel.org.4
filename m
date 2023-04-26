Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451E86EF92A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 19:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbjDZRS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 13:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234754AbjDZRRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 13:17:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22ABF76BC
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 10:17:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2718161B36
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 17:17:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91DF5C433AC;
        Wed, 26 Apr 2023 17:17:51 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1prim6-005Kaz-1z;
        Wed, 26 Apr 2023 13:17:50 -0400
Message-ID: <20230426171750.432594181@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 26 Apr 2023 13:17:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Doug Cook <dcook@linux.microsoft.com>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: [for-next][PATCH 07/11] tracing/user_events: Prevent same address and bit per process
References: <20230426171703.202523909@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Beau Belgrave <beaub@linux.microsoft.com>

User processes register an address and bit pair for events. If the same
address and bit pair are registered multiple times in the same process,
it can cause undefined behavior when events are enabled/disabled.
When more than one are used, the bit could be turned off by another
event being disabled, while the original event is still enabled.

Prevent undefined behavior by checking the current mm to see if any
event has already been registered for the address and bit pair. Return
EADDRINUSE back to the user process if it's already being used.

Update ftrace self-test to ensure this occurs properly.

Link: https://lkml.kernel.org/r/20230425225107.8525-4-beaub@linux.microsoft.com

Suggested-by: Doug Cook <dcook@linux.microsoft.com>
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_user.c              | 41 +++++++++++++++++++
 .../selftests/user_events/ftrace_test.c       |  9 +++-
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 4f9ae63dfc5d..a29cd13caf55 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -419,6 +419,21 @@ static int user_event_enabler_write(struct user_event_mm *mm,
 	return 0;
 }
 
+static bool user_event_enabler_exists(struct user_event_mm *mm,
+				      unsigned long uaddr, unsigned char bit)
+{
+	struct user_event_enabler *enabler;
+	struct user_event_enabler *next;
+
+	list_for_each_entry_safe(enabler, next, &mm->enablers, link) {
+		if (enabler->addr == uaddr &&
+		    (enabler->values & ENABLE_VAL_BIT_MASK) == bit)
+			return true;
+	}
+
+	return false;
+}
+
 static void user_event_enabler_update(struct user_event *user)
 {
 	struct user_event_enabler *enabler;
@@ -657,6 +672,22 @@ void user_event_mm_dup(struct task_struct *t, struct user_event_mm *old_mm)
 	user_event_mm_remove(t);
 }
 
+static bool current_user_event_enabler_exists(unsigned long uaddr,
+					      unsigned char bit)
+{
+	struct user_event_mm *user_mm = current_user_event_mm();
+	bool exists;
+
+	if (!user_mm)
+		return false;
+
+	exists = user_event_enabler_exists(user_mm, uaddr, bit);
+
+	user_event_mm_put(user_mm);
+
+	return exists;
+}
+
 static struct user_event_enabler
 *user_event_enabler_create(struct user_reg *reg, struct user_event *user,
 			   int *write_result)
@@ -2048,6 +2079,16 @@ static long user_events_ioctl_reg(struct user_event_file_info *info,
 	if (ret)
 		return ret;
 
+	/*
+	 * Prevent users from using the same address and bit multiple times
+	 * within the same mm address space. This can cause unexpected behavior
+	 * for user processes that is far easier to debug if this is explictly
+	 * an error upon registering.
+	 */
+	if (current_user_event_enabler_exists((unsigned long)reg.enable_addr,
+					      reg.enable_bit))
+		return -EADDRINUSE;
+
 	name = strndup_user((const char __user *)(uintptr_t)reg.name_args,
 			    MAX_EVENT_DESC);
 
diff --git a/tools/testing/selftests/user_events/ftrace_test.c b/tools/testing/selftests/user_events/ftrace_test.c
index 91272f9d6fce..7c99cef94a65 100644
--- a/tools/testing/selftests/user_events/ftrace_test.c
+++ b/tools/testing/selftests/user_events/ftrace_test.c
@@ -219,7 +219,12 @@ TEST_F(user, register_events) {
 	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
 	ASSERT_EQ(0, reg.write_index);
 
-	/* Multiple registers should result in same index */
+	/* Multiple registers to the same addr + bit should fail */
+	ASSERT_EQ(-1, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
+	ASSERT_EQ(EADDRINUSE, errno);
+
+	/* Multiple registers to same name should result in same index */
+	reg.enable_bit = 30;
 	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
 	ASSERT_EQ(0, reg.write_index);
 
@@ -242,6 +247,8 @@ TEST_F(user, register_events) {
 
 	/* Unregister */
 	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSUNREG, &unreg));
+	unreg.disable_bit = 30;
+	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSUNREG, &unreg));
 
 	/* Delete should work only after close and unregister */
 	close(self->data_fd);
-- 
2.39.2

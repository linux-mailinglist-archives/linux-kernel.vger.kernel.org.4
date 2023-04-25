Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDBF6EEA6F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 00:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236344AbjDYWva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 18:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236215AbjDYWvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 18:51:18 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6FAA19758;
        Tue, 25 Apr 2023 15:51:17 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id D29CA21C2B32;
        Tue, 25 Apr 2023 15:51:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D29CA21C2B32
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1682463077;
        bh=cfB/KvW47aSVwVlWaZPefAAtHKj3axBjgH2UZv+QwIM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wd7KOp+jT9zN6lbyka5Tjfj82jqvL/4t1tWyEBBR3fH7keaG/2ILtv4iPrCwm+KVj
         +L5r1OxVcXZeLFTW1LQlqR1Q5K1ptoOQM1wY2nMcQrFdI1G/ulwjh0ZzaFtbSaVwhh
         JKdXOWhSXtYiVTTnUG0zGl0C4udlBD5KlcwPmiVo=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, dcook@linux.microsoft.com,
        alanau@linux.microsoft.com
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] tracing/user_events: Prevent same address and bit per process
Date:   Tue, 25 Apr 2023 15:51:06 -0700
Message-Id: <20230425225107.8525-4-beaub@linux.microsoft.com>
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

User processes register an address and bit pair for events. If the same
address and bit pair are registered multiple times in the same process,
it can cause undefined behavior when events are enabled/disabled.
When more than one are used, the bit could be turned off by another
event being disabled, while the original event is still enabled.

Prevent undefined behavior by checking the current mm to see if any
event has already been registered for the address and bit pair. Return
EADDRINUSE back to the user process if it's already being used.

Update ftrace self-test to ensure this occurs properly.

Suggested-by: Doug Cook <dcook@linux.microsoft.com>
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 kernel/trace/trace_events_user.c              | 41 +++++++++++++++++++
 .../selftests/user_events/ftrace_test.c       |  9 +++-
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index eb195d697177..4fc099fc7637 100644
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
@@ -2045,6 +2076,16 @@ static long user_events_ioctl_reg(struct user_event_file_info *info,
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
2.25.1


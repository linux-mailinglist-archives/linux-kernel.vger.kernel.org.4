Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104786EF926
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 19:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234856AbjDZRSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 13:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234727AbjDZRRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 13:17:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7034F6A54
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 10:17:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A31286370D
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 17:17:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17ED6C433A4;
        Wed, 26 Apr 2023 17:17:51 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1prim6-005KZr-0g;
        Wed, 26 Apr 2023 13:17:50 -0400
Message-ID: <20230426171750.028699848@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 26 Apr 2023 13:17:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Doug Cook <dcook@linux.microsoft.com>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: [for-next][PATCH 05/11] tracing/user_events: Ensure write index cannot be negative
References: <20230426171703.202523909@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Beau Belgrave <beaub@linux.microsoft.com>

The write index indicates which event the data is for and accesses a
per-file array. The index is passed by user processes during write()
calls as the first 4 bytes. Ensure that it cannot be negative by
returning -EINVAL to prevent out of bounds accesses.

Update ftrace self-test to ensure this occurs properly.

Link: https://lkml.kernel.org/r/20230425225107.8525-2-beaub@linux.microsoft.com

Fixes: 7f5a08c79df3 ("user_events: Add minimal support for trace_event into ftrace")
Reported-by: Doug Cook <dcook@linux.microsoft.com>
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_user.c                  | 3 +++
 tools/testing/selftests/user_events/ftrace_test.c | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index eadb58a3efba..546d47a57520 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1824,6 +1824,9 @@ static ssize_t user_events_write_core(struct file *file, struct iov_iter *i)
 	if (unlikely(copy_from_iter(&idx, sizeof(idx), i) != sizeof(idx)))
 		return -EFAULT;
 
+	if (idx < 0)
+		return -EINVAL;
+
 	rcu_read_lock_sched();
 
 	refs = rcu_dereference_sched(info->refs);
diff --git a/tools/testing/selftests/user_events/ftrace_test.c b/tools/testing/selftests/user_events/ftrace_test.c
index aceafacfb126..91272f9d6fce 100644
--- a/tools/testing/selftests/user_events/ftrace_test.c
+++ b/tools/testing/selftests/user_events/ftrace_test.c
@@ -296,6 +296,11 @@ TEST_F(user, write_events) {
 	ASSERT_NE(-1, writev(self->data_fd, (const struct iovec *)io, 3));
 	after = trace_bytes();
 	ASSERT_GT(after, before);
+
+	/* Negative index should fail with EINVAL */
+	reg.write_index = -1;
+	ASSERT_EQ(-1, writev(self->data_fd, (const struct iovec *)io, 3));
+	ASSERT_EQ(EINVAL, errno);
 }
 
 TEST_F(user, write_fault) {
-- 
2.39.2

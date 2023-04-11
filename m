Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3D26DE648
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 23:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjDKVRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 17:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjDKVRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 17:17:16 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A42EC40E4;
        Tue, 11 Apr 2023 14:17:15 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id 13A5621779A4;
        Tue, 11 Apr 2023 14:17:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 13A5621779A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1681247835;
        bh=9bQADjcnzfitEajWNwld8GIEX6pWZSTccoW5aErnhjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hLTVNCA0O8jYUr2YSxF7S20EZevHhSS/9dTrPFg2hvlFJ6IEAxWhdsbjTUrcmFZi1
         EUgVH9kuhoHibBtrQzPGme+e6qWp3lmCw/a8oYGfoklkDlj7Szay0ZntAjeiFhgL4r
         QeFOE0accT+P5qSlSSj0/HMouLXnC+EqOEoEOlk8=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, dcook@linux.microsoft.com,
        alanau@linux.microsoft.com
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH 1/3] tracing/user_events: Ensure write index cannot be negative
Date:   Tue, 11 Apr 2023 14:17:07 -0700
Message-Id: <20230411211709.15018-2-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230411211709.15018-1-beaub@linux.microsoft.com>
References: <20230411211709.15018-1-beaub@linux.microsoft.com>
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

The write index indicates which event the data is for and accesses a
per-file array. The index is passed by user processes during write()
calls as the first 4 bytes. Ensure that it cannot be negative by
returning -EINVAL to prevent out of bounds accesses.

Update ftrace self-test to ensure this occurs properly.

Fixes: 7f5a08c79df3 ("user_events: Add minimal support for trace_event into ftrace")
Reported-by: Doug Cook <dcook@linux.microsoft.com>
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 kernel/trace/trace_events_user.c                  | 3 +++
 tools/testing/selftests/user_events/ftrace_test.c | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index cc8c6d8b69b5..e7dff24aa724 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1821,6 +1821,9 @@ static ssize_t user_events_write_core(struct file *file, struct iov_iter *i)
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
2.25.1


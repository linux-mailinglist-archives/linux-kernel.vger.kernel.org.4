Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669196DE64B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 23:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjDKVRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 17:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjDKVRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 17:17:16 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F2C704482;
        Tue, 11 Apr 2023 14:17:15 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5513C21779A6;
        Tue, 11 Apr 2023 14:17:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5513C21779A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1681247835;
        bh=hP1cRNuxHkIdEXUzblUPdQ1BwU/USkWFGaUyWmDt9gQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PQSaP+ezQbaPttIFdbKkZXDsVkwbr1h/eoZ3XuTodlKQSfr8PnuS6r5SHvRKlAuuY
         ORC1Lajk4ftnf+hT6PSiuJf1X3Hbfmt4gZ6OENNiZMJu6KapcPqBGUr2lwkAGKDfEJ
         lgpeHtIXivwCHumdkirPPoB8MY8N3hlWLUvAYgqs=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, dcook@linux.microsoft.com,
        alanau@linux.microsoft.com
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH 2/3] tracing/user_events: Ensure bit is cleared on unregister
Date:   Tue, 11 Apr 2023 14:17:08 -0700
Message-Id: <20230411211709.15018-3-beaub@linux.microsoft.com>
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

If an event is enabled and a user process unregisters user_events, the
bit is left set. Fix this by always clearing the bit in the user process
if unregister is successful.

Update abi self-test to ensure this occurs properly.

Suggested-by: Doug Cook <dcook@linux.microsoft.com>
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 kernel/trace/trace_events_user.c              | 34 +++++++++++++++++++
 .../testing/selftests/user_events/abi_test.c  |  9 +++--
 2 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index e7dff24aa724..eb195d697177 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -2146,6 +2146,35 @@ static long user_unreg_get(struct user_unreg __user *ureg,
 	return ret;
 }
 
+static int user_event_mm_clear_bit(struct user_event_mm *user_mm,
+				   unsigned long uaddr, unsigned char bit)
+{
+	struct user_event_enabler enabler;
+	int result;
+
+	memset(&enabler, 0, sizeof(enabler));
+	enabler.addr = uaddr;
+	enabler.values = bit;
+retry:
+	/* Prevents state changes from racing with new enablers */
+	mutex_lock(&event_mutex);
+
+	/* Force the bit to be cleared, since no event is attached */
+	mmap_read_lock(user_mm->mm);
+	result = user_event_enabler_write(user_mm, &enabler, false);
+	mmap_read_unlock(user_mm->mm);
+
+	mutex_unlock(&event_mutex);
+
+	if (result) {
+		/* Attempt to fault-in and retry if it worked */
+		if (!user_event_mm_fault_in(user_mm, uaddr))
+			goto retry;
+	}
+
+	return result;
+}
+
 /*
  * Unregisters an enablement address/bit within a task/user mm.
  */
@@ -2190,6 +2219,11 @@ static long user_events_ioctl_unreg(unsigned long uarg)
 
 	mutex_unlock(&event_mutex);
 
+	/* Ensure bit is now cleared for user, regardless of event status */
+	if (!ret)
+		ret = user_event_mm_clear_bit(mm, reg.disable_addr,
+					      reg.disable_bit);
+
 	return ret;
 }
 
diff --git a/tools/testing/selftests/user_events/abi_test.c b/tools/testing/selftests/user_events/abi_test.c
index e0323d3777a7..5125c42efe65 100644
--- a/tools/testing/selftests/user_events/abi_test.c
+++ b/tools/testing/selftests/user_events/abi_test.c
@@ -109,13 +109,16 @@ TEST_F(user, enablement) {
 	ASSERT_EQ(0, change_event(false));
 	ASSERT_EQ(0, self->check);
 
-	/* Should not change after disable */
+	/* Ensure kernel clears bit after disable */
 	ASSERT_EQ(0, change_event(true));
 	ASSERT_EQ(1, self->check);
 	ASSERT_EQ(0, reg_disable(&self->check, 0));
+	ASSERT_EQ(0, self->check);
+
+	/* Ensure doesn't change after unreg */
+	ASSERT_EQ(0, change_event(true));
+	ASSERT_EQ(0, self->check);
 	ASSERT_EQ(0, change_event(false));
-	ASSERT_EQ(1, self->check);
-	self->check = 0;
 }
 
 TEST_F(user, bit_sizes) {
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737C66EF927
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 19:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234864AbjDZRSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 13:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234751AbjDZRRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 13:17:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AD92701
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 10:17:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAD4E62FEA
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 17:17:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5E9C433D2;
        Wed, 26 Apr 2023 17:17:51 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1prim6-005KaP-1K;
        Wed, 26 Apr 2023 13:17:50 -0400
Message-ID: <20230426171750.231148604@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 26 Apr 2023 13:17:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Doug Cook <dcook@linux.microsoft.com>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: [for-next][PATCH 06/11] tracing/user_events: Ensure bit is cleared on unregister
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

If an event is enabled and a user process unregisters user_events, the
bit is left set. Fix this by always clearing the bit in the user process
if unregister is successful.

Update abi self-test to ensure this occurs properly.

Link: https://lkml.kernel.org/r/20230425225107.8525-3-beaub@linux.microsoft.com

Suggested-by: Doug Cook <dcook@linux.microsoft.com>
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_user.c              | 34 +++++++++++++++++++
 .../testing/selftests/user_events/abi_test.c  |  9 +++--
 2 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 546d47a57520..4f9ae63dfc5d 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -2149,6 +2149,35 @@ static long user_unreg_get(struct user_unreg __user *ureg,
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
@@ -2193,6 +2222,11 @@ static long user_events_ioctl_unreg(unsigned long uarg)
 
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
2.39.2

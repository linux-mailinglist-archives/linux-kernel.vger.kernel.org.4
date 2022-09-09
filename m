Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB46E5B3290
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbiIIJBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbiIIJAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:00:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1368011748A;
        Fri,  9 Sep 2022 02:00:21 -0700 (PDT)
Date:   Fri, 09 Sep 2022 09:00:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662714020;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6lKvVyE2giGiiOLQjfBfJrQmIodk6B3Hw3wAi2hv1os=;
        b=VXXJ9MSisk+N2/v7ZYBcMv7PqU1rSIO7eswT+q2mxCxk51Vxalbc3yPLidV7nfl/CYYyH/
        1PJvIPMcw5yDZC9F9gTK+2Q43y3ekUJlO3vszqUAy8iZ5opoBP2gsTwIQWVN3oCjg8mFjR
        LkBiPp4gR+T3XGoDiU9PCTKj9OomwcLg+4ixvz/ygyk8zgswmD3b2PemSwTb1IIAirHOSK
        u+QWm/Uu3pgx5D6jR2rMnOgXLhpWbthFC3eFQLlVwfge/CTr0JOX1fp6jKnsHXYo5UhFy7
        vYA5mQqcm5p5iL2N496aADlVB3KXn4mCaSH3Pqd9ZxEsZ3+ZXykqwwadN+1XpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662714020;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6lKvVyE2giGiiOLQjfBfJrQmIodk6B3Hw3wAi2hv1os=;
        b=h6YB3c7H214zj4TosldEu2mU4TzykkAA4BcVr9I+0np+Bob4UGNEgluTJOyWKzOiFtyxdE
        dDkJD7B9nOvihXAw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/wait: Add wait_event_state()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220822114648.989212021@infradead.org>
References: <20220822114648.989212021@infradead.org>
MIME-Version: 1.0
Message-ID: <166271401930.401.6700614770872821071.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     3f884a10ab41efe2d495bf8ec8d443d70c500a60
Gitweb:        https://git.kernel.org/tip/3f884a10ab41efe2d495bf8ec8d443d70c500a60
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 22 Aug 2022 13:18:21 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 07 Sep 2022 21:53:49 +02:00

sched/wait: Add wait_event_state()

Allows waiting with a custom @state.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20220822114648.989212021@infradead.org
---
 include/linux/wait.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 58cfbf8..b926eb9 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -932,6 +932,34 @@ extern int do_wait_intr_irq(wait_queue_head_t *, wait_queue_entry_t *);
 	__ret;									\
 })
 
+#define __wait_event_state(wq, condition, state)				\
+	___wait_event(wq, condition, state, 0, 0, schedule())
+
+/**
+ * wait_event_state - sleep until a condition gets true
+ * @wq_head: the waitqueue to wait on
+ * @condition: a C expression for the event to wait for
+ * @state: state to sleep in
+ *
+ * The process is put to sleep (@state) until the @condition evaluates to true
+ * or a signal is received (when allowed by @state).  The @condition is checked
+ * each time the waitqueue @wq_head is woken up.
+ *
+ * wake_up() has to be called after changing any variable that could
+ * change the result of the wait condition.
+ *
+ * The function will return -ERESTARTSYS if it was interrupted by a signal
+ * (when allowed by @state) and 0 if @condition evaluated to true.
+ */
+#define wait_event_state(wq_head, condition, state)				\
+({										\
+	int __ret = 0;								\
+	might_sleep();								\
+	if (!(condition))							\
+		__ret = __wait_event_state(wq_head, condition, state);		\
+	__ret;									\
+})
+
 #define __wait_event_killable_timeout(wq_head, condition, timeout)		\
 	___wait_event(wq_head, ___wait_cond_timeout(condition),			\
 		      TASK_KILLABLE, 0, timeout,				\

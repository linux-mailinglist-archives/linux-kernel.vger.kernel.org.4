Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7278A601164
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiJQOpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbiJQOpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:45:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A67361D9B;
        Mon, 17 Oct 2022 07:45:31 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:45:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666017930;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=uvcx57h5A+S8TkJg1UEv+CS1pKio/Ap2AHm5cKeJlzg=;
        b=aERMe4euaYA7IDmwrfTJ1eWc9v6Gh42OQ1A3YKzo4y+EK9ozWXRFzMKGeQX4EbcDn8Z22D
        WFASv8DTC1S5Y4kHnFFTSA/6mz4I6cGJsV8kf317U/I9zdIcGOpmIqgbJn9IrGBNXk06o6
        mYPZUKdlxyAypmZS2pyOv8dJc9Y3sb7+LD5qOOi75APEfLSijVAsodZMog9l73ss52NsLl
        AggXreJcAUtIuNJiqIe4JFMRi3dHMKwPnV3VqXblTQUnXXP653tZKFF8V+rdM1uG0kPcmu
        oCItzTPeNooxonscBBwJYVeEPFQTiBZTO/PdTYDXw6giLj2BDekAUuYW1dFU4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666017930;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=uvcx57h5A+S8TkJg1UEv+CS1pKio/Ap2AHm5cKeJlzg=;
        b=b579OZE/eaac4fmLlw/tiES8hx0NFrm7mPF4eLDJ3tNbcOibl6Zqz+iz7Fi1caBwmMMuLw
        J3Vas7IDSMRG4bAg==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] selftests/perf_events: Add a SIGTRAP stress test
 with disables
Cc:     Marco Elver <elver@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166601792897.401.15340985095187381369.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     23488ec66867f7e673b694623a951fb583e464a7
Gitweb:        https://git.kernel.org/tip/23488ec66867f7e673b694623a951fb583e464a7
Author:        Marco Elver <elver@google.com>
AuthorDate:    Tue, 11 Oct 2022 14:45:35 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:32:06 +02:00

selftests/perf_events: Add a SIGTRAP stress test with disables

Add a SIGTRAP stress test that exercises repeatedly enabling/disabling
an event while it concurrently keeps firing.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/Y0E3uG7jOywn7vy3@elver.google.com/
---
 tools/testing/selftests/perf_events/sigtrap_threads.c | 35 +++++++++-
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/perf_events/sigtrap_threads.c b/tools/testing/selftests/perf_events/sigtrap_threads.c
index 6d849dc..d1d8483 100644
--- a/tools/testing/selftests/perf_events/sigtrap_threads.c
+++ b/tools/testing/selftests/perf_events/sigtrap_threads.c
@@ -62,6 +62,8 @@ static struct perf_event_attr make_event_attr(bool enabled, volatile void *addr,
 		.remove_on_exec = 1, /* Required by sigtrap. */
 		.sigtrap	= 1, /* Request synchronous SIGTRAP on event. */
 		.sig_data	= TEST_SIG_DATA(addr, id),
+		.exclude_kernel = 1, /* To allow */
+		.exclude_hv     = 1, /* running as !root */
 	};
 	return attr;
 }
@@ -93,9 +95,13 @@ static void *test_thread(void *arg)
 
 	__atomic_fetch_add(&ctx.tids_want_signal, tid, __ATOMIC_RELAXED);
 	iter = ctx.iterate_on; /* read */
-	for (i = 0; i < iter - 1; i++) {
-		__atomic_fetch_add(&ctx.tids_want_signal, tid, __ATOMIC_RELAXED);
-		ctx.iterate_on = iter; /* idempotent write */
+	if (iter >= 0) {
+		for (i = 0; i < iter - 1; i++) {
+			__atomic_fetch_add(&ctx.tids_want_signal, tid, __ATOMIC_RELAXED);
+			ctx.iterate_on = iter; /* idempotent write */
+		}
+	} else {
+		while (ctx.iterate_on);
 	}
 
 	return NULL;
@@ -208,4 +214,27 @@ TEST_F(sigtrap_threads, signal_stress)
 	EXPECT_EQ(ctx.first_siginfo.si_perf_data, TEST_SIG_DATA(&ctx.iterate_on, 0));
 }
 
+TEST_F(sigtrap_threads, signal_stress_with_disable)
+{
+	const int target_count = NUM_THREADS * 3000;
+	int i;
+
+	ctx.iterate_on = -1;
+
+	EXPECT_EQ(ioctl(self->fd, PERF_EVENT_IOC_ENABLE, 0), 0);
+	pthread_barrier_wait(&self->barrier);
+	while (__atomic_load_n(&ctx.signal_count, __ATOMIC_RELAXED) < target_count) {
+		EXPECT_EQ(ioctl(self->fd, PERF_EVENT_IOC_DISABLE, 0), 0);
+		EXPECT_EQ(ioctl(self->fd, PERF_EVENT_IOC_ENABLE, 0), 0);
+	}
+	ctx.iterate_on = 0;
+	for (i = 0; i < NUM_THREADS; i++)
+		ASSERT_EQ(pthread_join(self->threads[i], NULL), 0);
+	EXPECT_EQ(ioctl(self->fd, PERF_EVENT_IOC_DISABLE, 0), 0);
+
+	EXPECT_EQ(ctx.first_siginfo.si_addr, &ctx.iterate_on);
+	EXPECT_EQ(ctx.first_siginfo.si_perf_type, PERF_TYPE_BREAKPOINT);
+	EXPECT_EQ(ctx.first_siginfo.si_perf_data, TEST_SIG_DATA(&ctx.iterate_on, 0));
+}
+
 TEST_HARNESS_MAIN

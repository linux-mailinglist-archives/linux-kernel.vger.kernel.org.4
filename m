Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1A8724658
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238069AbjFFOh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238012AbjFFOhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:37:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B29010F0
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:37:31 -0700 (PDT)
Message-ID: <20230606142031.418148389@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686062250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=BSLAZiaPu4OlRt7MJLr8iteahUnDIy2W/NiT+df9pkg=;
        b=NGSYWuzHITJVHI6VTsAf1RP0yNKLn79a3HYPloWgCUX5l4IL/Y3fEGAy5jJdnxpqLdeDOu
        BJEU49bHoqnbPP7zSmGBLf2qDwc7R8IkUMt++9Nm10DLjKwhwEGOL1s2w62k/FYrneQ8hq
        GLGJH5NU02wxZ5XXnXWHnfIk9i8+nCDuMdTgZ8UbZSmviMi+9BrdNVWYMr1GDvX2oTCiWe
        XiMRa9wCPZg4gkYCfXjL3GGSbpfnIkymBPHGLs01wQLKlnV62KgQk4u62mxfS2WEOSaRvh
        jZaEA4GGm40/gTq3MCj1QDqIHJpmUPBZon847bpwaRNcZwShycOsh8rfoDRhfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686062250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=BSLAZiaPu4OlRt7MJLr8iteahUnDIy2W/NiT+df9pkg=;
        b=SZ+WwAc0hpLj84ylncyoVTYGGxBxKyzgeyk1hVyKYq34jKgtd5/JJtvSKU/azX3SrSJ+3V
        bPmlI+45gUg4iQCg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [patch 07/45] selftests/timers/posix-timers: Validate overrun after unblock
References: <20230606132949.068951363@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  6 Jun 2023 16:37:29 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a timer signal is blocked and later unblocked then one signal should
be delivered with the correct number of overruns since the timer was queued.

Validate that behaviour.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 tools/testing/selftests/timers/posix_timers.c |   63 +++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -578,10 +578,68 @@ static void check_gettime(int which, con
 		ksft_test_result_fail("check_gettime %s\n", name);
 }
 
+static void check_overrun(int which, const char *name)
+{
+	struct timespec start, now;
+	struct tmrsig tsig = { };
+	struct itimerspec its;
+	struct sigaction sa;
+	struct sigevent sev;
+	timer_t timerid;
+	sigset_t set;
+
+	sa.sa_flags = SA_SIGINFO;
+	sa.sa_sigaction = siginfo_handler;
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(SIGUSR1, &sa, NULL))
+		fatal_error(name, "sigaction()");
+
+	/* Block the signal */
+	sigemptyset(&set);
+	sigaddset(&set, SIGUSR1);
+	if (sigprocmask(SIG_BLOCK, &set, NULL))
+		fatal_error(name, "sigprocmask(SIG_BLOCK)");
+
+	memset(&sev, 0, sizeof(sev));
+	sev.sigev_notify = SIGEV_SIGNAL;
+	sev.sigev_signo = SIGUSR1;
+	sev.sigev_value.sival_ptr = &tsig;
+
+	if (timer_create(which, &sev, &timerid))
+		fatal_error(name, "timer_create()");
+
+	/* Start the timer to expire in 100ms and 100ms intervals */
+	its.it_value.tv_sec = 0;
+	its.it_value.tv_nsec = 100000000;
+	its.it_interval.tv_sec = 0;
+	its.it_interval.tv_nsec = 100000000;
+	timer_settime(timerid, 0, &its, NULL);
+
+	if (clock_gettime(which, &start))
+		fatal_error(name, "clock_gettime()");
+
+	do {
+		if (clock_gettime(which, &now))
+			fatal_error(name, "clock_gettime()");
+	} while (calcdiff_ns(now, start) < NSECS_PER_SEC);
+
+	/* Unblock it, which should deliver a signal */
+	if (sigprocmask(SIG_UNBLOCK, &set, NULL))
+		fatal_error(name, "sigprocmask(SIG_UNBLOCK)");
+
+	if (timer_delete(timerid))
+		fatal_error(name, "timer_delete()");
+
+	if (tsig.signals == 1 && tsig.overruns == 9)
+		ksft_test_result_pass("check_overrun %s\n", name);
+	else
+		ksft_test_result_fail("check_overrun %s\n", name);
+}
+
 int main(int argc, char **argv)
 {
 	ksft_print_header();
-	ksft_set_plan(15);
+	ksft_set_plan(18);
 
 	check_itimer(ITIMER_VIRTUAL, "ITIMER_VIRTUAL");
 	check_itimer(ITIMER_PROF, "ITIMER_PROF");
@@ -608,6 +666,9 @@ int main(int argc, char **argv)
 	check_gettime(CLOCK_MONOTONIC, "CLOCK_MONOTONIC");
 	check_gettime(CLOCK_PROCESS_CPUTIME_ID, "CLOCK_PROCESS_CPUTIME_ID");
 	check_gettime(CLOCK_THREAD_CPUTIME_ID, "CLOCK_THREAD_CPUTIME_ID");
+	check_overrun(CLOCK_MONOTONIC, "CLOCK_MONOTONIC");
+	check_overrun(CLOCK_PROCESS_CPUTIME_ID, "CLOCK_PROCESS_CPUTIME_ID");
+	check_overrun(CLOCK_THREAD_CPUTIME_ID, "CLOCK_THREAD_CPUTIME_ID");
 
 	ksft_finished();
 }


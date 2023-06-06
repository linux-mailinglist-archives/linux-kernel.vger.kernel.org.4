Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52D7724657
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238045AbjFFOhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237969AbjFFOhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:37:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113FCE6E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:37:30 -0700 (PDT)
Message-ID: <20230606142031.361364275@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686062248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=vEpeXsIrZe+OvjERrC+2BpJZspHhIovUmZBUn14588o=;
        b=MFxYngCMvgFGbZ+qeTOM2WVe2omVI9vCB0KU5kPN8qjGKnGt0ttOHj9DjYtH8UPEe6vSe/
        SgYgJrhjyWbHDxrwa8vngQ7l/MqwIYGAHyHvS4w1wS4W8A8QYC4L9MlPRHVypqGCfwjp7s
        FAT7Wy+ZQghzVPaNqnZMN43gDUXrDxKtjPbFcebAmmad7ohKC4Jgqo6UV6bmcoAwyHL0AX
        7ExdTVqndCXYfLUHSJlpQ+uHfZY/s9cNtDHkU/mhxpgPzzABT1ACoAdHzWdG7Kzgo5pzvd
        0pPI5wJ01zomBYaoD3u4BxHpsBQAA0CHWvLRb9FmcIKTGWgS6u44Fup8Tcqb4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686062248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=vEpeXsIrZe+OvjERrC+2BpJZspHhIovUmZBUn14588o=;
        b=0KZ505Aw8WKTp7bXANs+TTFcUIQxHVvXogT58oey98b195Yyc7+kJIcfaqn6Aw3wycatnY
        /Df4udSlqHwuMeDw==
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
Subject: [patch 06/45] selftests/timers/posix-timers: Validate timer_gettime()
References: <20230606132949.068951363@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  6 Jun 2023 16:37:28 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

timer_gettime() must return the correct expiry time for interval timers
even when the timer is not armed, which is the case when a signal is
pending but blocked.

Works correctly for regular posix timers, but not for posix CPU timers.

Add a selftest to validate the fixes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 tools/testing/selftests/timers/posix_timers.c |   60 +++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -523,10 +523,65 @@ static void check_sigev_none(int which,
 		ksft_test_result_fail("check_sigev_none %s\n", name);
 }
 
+static void check_gettime(int which, const char *name)
+{
+	struct itimerspec its, prev;
+	struct timespec start, now;
+	struct sigevent sev;
+	timer_t timerid;
+	int wraps = 0;
+	sigset_t set;
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
+	if (timer_gettime(timerid, &prev))
+		fatal_error(name, "timer_gettime()");
+
+	if (clock_gettime(which, &start))
+		fatal_error(name, "clock_gettime()");
+
+	do {
+		if (clock_gettime(which, &now))
+			fatal_error(name, "clock_gettime()");
+		if (timer_gettime(timerid, &its))
+			fatal_error(name, "timer_gettime()");
+		if (its.it_value.tv_nsec > prev.it_value.tv_nsec)
+			wraps++;
+		prev = its;
+
+	} while (calcdiff_ns(now, start) < NSECS_PER_SEC);
+
+	if (timer_delete(timerid))
+		fatal_error(name, "timer_delete()");
+
+	if (wraps > 1)
+		ksft_test_result_pass("check_gettime %s\n", name);
+	else
+		ksft_test_result_fail("check_gettime %s\n", name);
+}
+
 int main(int argc, char **argv)
 {
 	ksft_print_header();
-	ksft_set_plan(12);
+	ksft_set_plan(15);
 
 	check_itimer(ITIMER_VIRTUAL, "ITIMER_VIRTUAL");
 	check_itimer(ITIMER_PROF, "ITIMER_PROF");
@@ -550,6 +605,9 @@ int main(int argc, char **argv)
 	check_delete();
 	check_sigev_none(CLOCK_MONOTONIC, "CLOCK_MONOTONIC");
 	check_sigev_none(CLOCK_PROCESS_CPUTIME_ID, "CLOCK_PROCESS_CPUTIME_ID");
+	check_gettime(CLOCK_MONOTONIC, "CLOCK_MONOTONIC");
+	check_gettime(CLOCK_PROCESS_CPUTIME_ID, "CLOCK_PROCESS_CPUTIME_ID");
+	check_gettime(CLOCK_THREAD_CPUTIME_ID, "CLOCK_THREAD_CPUTIME_ID");
 
 	ksft_finished();
 }


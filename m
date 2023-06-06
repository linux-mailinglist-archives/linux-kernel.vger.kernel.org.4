Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7237724653
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237992AbjFFOhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237716AbjFFOh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:37:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACB210D9
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:37:23 -0700 (PDT)
Message-ID: <20230606142031.130432648@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686062241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=MIIp9euOFQMWAHPLIaiH4BFUPFpK2SH94uXT++JmpqU=;
        b=OhJCSbA791K9lpNAXmM+45wOMTWX9MdTdYKmX1TmFSBi9VUGrV9iTeqZ2IdzbFlKCJ1x1X
        O6dxV1AF4Pw/BS8wgB9/C30jgSrae/3Lf535gEqFmy3PEdUQO7ETmQ5TV/P+mEvTTaFHMe
        vWOb8VDiJjEvZIyNSNIehpnd4xDxsoNvM5fvujIIsEvR8+uZ6r2/OP6Ggyv9JGnXDBHVY1
        rhDlJs8Jsmfmdb627MbKyFqyVhpoZNdI5UAYv6CGEZ1gnt7OOcQppYKOFQ/MfiWK0kX4AV
        Fi5jlCmSTdZLsoVsAuZ3m/eoixDXpJXyxR+aql2CA/QqzB9T7O8343Q95Npl2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686062241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=MIIp9euOFQMWAHPLIaiH4BFUPFpK2SH94uXT++JmpqU=;
        b=VhykV8UV6fU3kmkb4uU6Ex5lS64pWPlCpFWkDAaJWZ/CmJYkJVKdWONv1VtKZME8w+rNcu
        uervyfdtn2KW4DAQ==
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
Subject: [patch 02/45] selftests/timers/posix_timers: Use TAP reporting format
References: <20230606132949.068951363@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  6 Jun 2023 16:37:21 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 tools/testing/selftests/timers/posix_timers.c |  173 +++++++++-----------------
 1 file changed, 65 insertions(+), 108 deletions(-)

--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -10,6 +10,7 @@
 #include <sys/time.h>
 #include <stdio.h>
 #include <signal.h>
+#include <string.h>
 #include <unistd.h>
 #include <time.h>
 #include <pthread.h>
@@ -19,6 +20,20 @@
 #define DELAY 2
 #define USECS_PER_SEC 1000000
 
+static void __fatal_error(const char *test, const char *name, const char *what)
+{
+	char buf[64];
+
+	strerror_r(errno, buf, sizeof(buf));
+
+	if (name && strlen(name))
+		ksft_exit_fail_msg("%s %s %s %s\n", test, name, what, buf);
+	else
+		ksft_exit_fail_msg("%s %s %s\n", test, what, buf);
+}
+
+#define fatal_error(name, what)	__fatal_error(__func__, name, what)
+
 static volatile int done;
 
 /* Busy loop in userspace to elapse ITIMER_VIRTUAL */
@@ -66,15 +81,13 @@ static int check_diff(struct timeval sta
 	diff = end.tv_usec - start.tv_usec;
 	diff += (end.tv_sec - start.tv_sec) * USECS_PER_SEC;
 
-	if (abs(diff - DELAY * USECS_PER_SEC) > USECS_PER_SEC / 2) {
-		printf("Diff too high: %lld..", diff);
+	if (abs(diff - DELAY * USECS_PER_SEC) > USECS_PER_SEC / 2)
 		return -1;
-	}
 
 	return 0;
 }
 
-static int check_itimer(int which)
+static void check_itimer(int which, const char *name)
 {
 	int err;
 	struct timeval start, end;
@@ -82,17 +95,6 @@ static int check_itimer(int which)
 		.it_value.tv_sec = DELAY,
 	};
 
-	printf("Check itimer ");
-
-	if (which == ITIMER_VIRTUAL)
-		printf("virtual... ");
-	else if (which == ITIMER_PROF)
-		printf("prof... ");
-	else if (which == ITIMER_REAL)
-		printf("real... ");
-
-	fflush(stdout);
-
 	done = 0;
 
 	if (which == ITIMER_VIRTUAL)
@@ -103,16 +105,12 @@ static int check_itimer(int which)
 		signal(SIGALRM, sig_handler);
 
 	err = gettimeofday(&start, NULL);
-	if (err < 0) {
-		perror("Can't call gettimeofday()\n");
-		return -1;
-	}
+	if (err < 0)
+		fatal_error(name, "gettimeofday()");
 
 	err = setitimer(which, &val, NULL);
-	if (err < 0) {
-		perror("Can't set timer\n");
-		return -1;
-	}
+	if (err < 0)
+		fatal_error(name, "setitimer()");
 
 	if (which == ITIMER_VIRTUAL)
 		user_loop();
@@ -122,20 +120,16 @@ static int check_itimer(int which)
 		idle_loop();
 
 	err = gettimeofday(&end, NULL);
-	if (err < 0) {
-		perror("Can't call gettimeofday()\n");
-		return -1;
-	}
+	if (err < 0)
+		fatal_error(name, "gettimeofday()");
 
 	if (!check_diff(start, end))
-		printf("[OK]\n");
+		ksft_test_result_pass("check_itimer %s\n", name);
 	else
-		printf("[FAIL]\n");
-
-	return 0;
+		ksft_test_result_fail("check_itimer %s\n", name);
 }
 
-static int check_timer_create(int which)
+static void check_timer_create(int which, const char *name)
 {
 	int err;
 	timer_t id;
@@ -144,48 +138,32 @@ static int check_timer_create(int which)
 		.it_value.tv_sec = DELAY,
 	};
 
-	printf("Check timer_create() ");
-	if (which == CLOCK_THREAD_CPUTIME_ID) {
-		printf("per thread... ");
-	} else if (which == CLOCK_PROCESS_CPUTIME_ID) {
-		printf("per process... ");
-	}
-	fflush(stdout);
-
 	done = 0;
 	err = timer_create(which, NULL, &id);
-	if (err < 0) {
-		perror("Can't create timer\n");
-		return -1;
-	}
-	signal(SIGALRM, sig_handler);
+	if (err < 0)
+		fatal_error(name, "timer_create()");
+
+	if (signal(SIGALRM, sig_handler) == SIG_ERR)
+		fatal_error(name, "signal()");
 
 	err = gettimeofday(&start, NULL);
-	if (err < 0) {
-		perror("Can't call gettimeofday()\n");
-		return -1;
-	}
+	if (err < 0)
+		fatal_error(name, "gettimeofday()");
 
 	err = timer_settime(id, 0, &val, NULL);
-	if (err < 0) {
-		perror("Can't set timer\n");
-		return -1;
-	}
+	if (err < 0)
+		fatal_error(name, "timer_settime()");
 
 	user_loop();
 
 	err = gettimeofday(&end, NULL);
-	if (err < 0) {
-		perror("Can't call gettimeofday()\n");
-		return -1;
-	}
+	if (err < 0)
+		fatal_error(name, "gettimeofday()");
 
 	if (!check_diff(start, end))
-		printf("[OK]\n");
+		ksft_test_result_pass("check_timer_create %s\n", name);
 	else
-		printf("[FAIL]\n");
-
-	return 0;
+		ksft_test_result_fail("check_timer_create %s\n", name);
 }
 
 static int remain;
@@ -208,7 +186,7 @@ static void distribution_handler(int nr)
  * Test that all running threads _eventually_ receive CLOCK_PROCESS_CPUTIME_ID
  * timer signals. This primarily tests that the kernel does not favour any one.
  */
-static int check_timer_distribution(void)
+static void check_timer_distribution(void)
 {
 	const int nthreads = 10;
 	pthread_t threads[nthreads];
@@ -222,28 +200,22 @@ static int check_timer_distribution(void
 	int err, i;
 	timer_t id;
 
-	printf("Check timer_create() per process signal distribution... ");
-	fflush(stdout);
-
 	done = 0;
 	remain = nthreads + 1;  /* worker threads + this thread */
-	signal(SIGALRM, distribution_handler);
+	if (signal(SIGALRM, distribution_handler) == SIG_ERR)
+		fatal_error(NULL, "signal()");
+
 	err = timer_create(CLOCK_PROCESS_CPUTIME_ID, NULL, &id);
-	if (err < 0) {
-		perror("Can't create timer\n");
-		return -1;
-	}
+	if (err < 0)
+		fatal_error(NULL, "timer_create()");
+
 	err = timer_settime(id, 0, &val, NULL);
-	if (err < 0) {
-		perror("Can't set timer\n");
-		return -1;
-	}
+	if (err < 0)
+		fatal_error(NULL, "timer_settime()");
 
 	for (i = 0; i < nthreads; i++) {
-		if (pthread_create(&threads[i], NULL, distribution_thread, NULL)) {
-			perror("Can't create thread\n");
-			return -1;
-		}
+		if (pthread_create(&threads[i], NULL, distribution_thread, NULL))
+			fatal_error(NULL, "pthread_create()");
 	}
 
 	/* Wait for all threads to receive the signal. */
@@ -255,41 +227,29 @@ static int check_timer_distribution(void
 	}
 	done = 1;
 
-	if (timer_delete(id)) {
-		perror("Can't delete timer\n");
-		return -1;
-	}
+	if (timer_delete(id))
+		fatal_error(NULL, "timer_delete()");
 
 	for (i = 0; i < nthreads; i++) {
-		if (pthread_join(threads[i], NULL)) {
-			perror("Can't join thread\n");
-			return -1;
-		}
+		if (pthread_join(threads[i], NULL))
+			fatal_error(NULL, "pthread_join()");
 	}
 
 	if (now - start <= 5)
-		printf("[OK]\n");
+		ksft_test_result_pass("check_signal_distribution\n");
 	else
-		printf("%d [FAIL]\n", got_signal);
-	return 0;
+		ksft_test_result_fail("check_signal_distribution\n");
 }
 
 int main(int argc, char **argv)
 {
-	printf("Testing posix timers. False negative may happen on CPU execution \n");
-	printf("based timers if other threads run on the CPU...\n");
-
-	if (check_itimer(ITIMER_VIRTUAL) < 0)
-		return ksft_exit_fail();
+	ksft_print_header();
+	ksft_set_plan(6);
 
-	if (check_itimer(ITIMER_PROF) < 0)
-		return ksft_exit_fail();
-
-	if (check_itimer(ITIMER_REAL) < 0)
-		return ksft_exit_fail();
-
-	if (check_timer_create(CLOCK_THREAD_CPUTIME_ID) < 0)
-		return ksft_exit_fail();
+	check_itimer(ITIMER_VIRTUAL, "ITIMER_VIRTUAL");
+	check_itimer(ITIMER_PROF, "ITIMER_PROF");
+	check_itimer(ITIMER_REAL, "ITIMER_REAL");
+	check_timer_create(CLOCK_THREAD_CPUTIME_ID, "CLOCK_THREAD_CPUTIME_ID");
 
 	/*
 	 * It's unfortunately hard to reliably test a timer expiration
@@ -300,11 +260,8 @@ int main(int argc, char **argv)
 	 * to ensure true parallelism. So test only one thread until we
 	 * find a better solution.
 	 */
-	if (check_timer_create(CLOCK_PROCESS_CPUTIME_ID) < 0)
-		return ksft_exit_fail();
-
-	if (check_timer_distribution() < 0)
-		return ksft_exit_fail();
+	check_timer_create(CLOCK_PROCESS_CPUTIME_ID, "CLOCK_PROCESS_CPUTIME_ID");
+	check_timer_distribution();
 
-	return ksft_exit_pass();
+	ksft_finished();
 }


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFDB724652
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237986AbjFFOhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236520AbjFFOh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:37:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB7010C3
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:37:21 -0700 (PDT)
Message-ID: <20230606142031.071059989@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686062240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=iBZbrM8aXg0lrMpkqk/B9ueGbYMxSh3wWbEDiu0Wh1o=;
        b=zAvCHooVXCehbvvBRL4bEjYh9UjlT1Dg5/wlaOn2FjT9/Q6BaQ0j7jdRCyE+KtygLsHVZx
        olQCqmJVAu4L20tAv2dh63LCsSboF8YM+3vOsTbdbS+KvI7ZXf83UVCgJuum6THOr4jdjm
        NHbW8bWPt8dzatd4cDAUNw0RYnKZeNEXal/Zmoz0h1fuVzFFiHeaBO6XD/QCIKBI5VrrQl
        0DipQL9zXTv/BCAKUZnQVWrWXJFtGfOWBMqWeR8zSgnF6jQfjTDuyHY+1cGAcJE62SUrj0
        JHE6gdfaFFsLE5cjvBxFkPT7lK1xbaE9MxUp8l5Xqtyp3GzHC3xKpO64kBb10g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686062240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=iBZbrM8aXg0lrMpkqk/B9ueGbYMxSh3wWbEDiu0Wh1o=;
        b=9VqH++YV0s3KDheDw0FwKjW9k1vXOoHmjwK4BwJVHg7Foj9ibE8CzUrGhhrJerU4EL5OZ3
        NqBkukSrCqmHTQBw==
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
Subject: [patch 01/45] selftests/timers/posix_timers: Make signal distribution
 test less fragile
References: <20230606132949.068951363@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  6 Jun 2023 16:37:19 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The signal distribution test has a tendency to hang for a long time as the
signal delivery is not really evenly distributed.

Increasing the timer interval to 10ms makes this less likely. Add a timeout
to catch the case where it hangs and terminate the test gracefully.

While at it get rid of the pointless atomic operation on a the thread local
variable in the signal handler.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 tools/testing/selftests/timers/posix_timers.c |   42 ++++++++++++++++----------
 1 file changed, 27 insertions(+), 15 deletions(-)

--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -188,18 +188,19 @@ static int check_timer_create(int which)
 	return 0;
 }
 
-int remain;
-__thread int got_signal;
+static int remain;
+static __thread int got_signal;
 
 static void *distribution_thread(void *arg)
 {
-	while (__atomic_load_n(&remain, __ATOMIC_RELAXED));
+	while (__atomic_load_n(&remain, __ATOMIC_RELAXED) && !done);
+
 	return NULL;
 }
 
 static void distribution_handler(int nr)
 {
-	if (!__atomic_exchange_n(&got_signal, 1, __ATOMIC_RELAXED))
+	if (++got_signal == 1)
 		__atomic_fetch_sub(&remain, 1, __ATOMIC_RELAXED);
 }
 
@@ -209,20 +210,22 @@ static void distribution_handler(int nr)
  */
 static int check_timer_distribution(void)
 {
-	int err, i;
-	timer_t id;
 	const int nthreads = 10;
 	pthread_t threads[nthreads];
 	struct itimerspec val = {
 		.it_value.tv_sec = 0,
-		.it_value.tv_nsec = 1000 * 1000,
+		.it_value.tv_nsec = 20 * 1000 * 1000,
 		.it_interval.tv_sec = 0,
-		.it_interval.tv_nsec = 1000 * 1000,
+		.it_interval.tv_nsec = 20 * 1000 * 1000,
 	};
+	time_t start, now;
+	int err, i;
+	timer_t id;
 
 	printf("Check timer_create() per process signal distribution... ");
 	fflush(stdout);
 
+	done = 0;
 	remain = nthreads + 1;  /* worker threads + this thread */
 	signal(SIGALRM, distribution_handler);
 	err = timer_create(CLOCK_PROCESS_CPUTIME_ID, NULL, &id);
@@ -244,7 +247,18 @@ static int check_timer_distribution(void
 	}
 
 	/* Wait for all threads to receive the signal. */
-	while (__atomic_load_n(&remain, __ATOMIC_RELAXED));
+	now = start = time(NULL);
+	while (__atomic_load_n(&remain, __ATOMIC_RELAXED)) {
+		now = time(NULL);
+		if (now - start > 5)
+			break;
+	}
+	done = 1;
+
+	if (timer_delete(id)) {
+		perror("Can't delete timer\n");
+		return -1;
+	}
 
 	for (i = 0; i < nthreads; i++) {
 		if (pthread_join(threads[i], NULL)) {
@@ -253,12 +267,10 @@ static int check_timer_distribution(void
 		}
 	}
 
-	if (timer_delete(id)) {
-		perror("Can't delete timer\n");
-		return -1;
-	}
-
-	printf("[OK]\n");
+	if (now - start <= 5)
+		printf("[OK]\n");
+	else
+		printf("%d [FAIL]\n", got_signal);
 	return 0;
 }
 


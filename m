Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD02724656
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238040AbjFFOhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237960AbjFFOhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:37:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8630E10D9
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:37:28 -0700 (PDT)
Message-ID: <20230606142031.303328672@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686062247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=kUcWS9fKA9MhrLnlJFYDQVKQCJlVl0X8B00s0xylFSg=;
        b=mFOehDrpWendqw/cAVSYhGChRkb3iYtPm4Xp7CX2H+d1SxJ9qVRb1vkP+aBwyehWPL44Nc
        4pGtpZuU7woPf1OS7IEHZDzox0gOr3B8BcPEzx5AaJixiefUMsREZviaiDzO1L9TlNYfTm
        3DuOAjwU+CIn9UAno4nNi+5UEgaCZ2lb8c3Axqwe0CGBq5MiR+quuTs7EpBw/JfGcRpLtA
        VYi3dlDyqaK1ouZzY5414NW/cuT9Oz0FZ0smuICrFzunBUPIy7Zr/IfXPu2IIu7Shp9RTK
        23O5GioCN4650KgduvEkZinYfWMfTSjDOf9OFC7wb4tSy5IvlriSp8DzYIjvFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686062247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=kUcWS9fKA9MhrLnlJFYDQVKQCJlVl0X8B00s0xylFSg=;
        b=gjFNHKwfsFOq8w0NS15qbmk1cLOOF5v0OtUF2zBdEg7PyKe02PSpVNHQzFxGWp798k9GVC
        A/7Gz6v1UK1CDcDA==
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
Subject: [patch 05/45] selftests/timers/posix-timers: Validate SIGEV_NONE
References: <20230606132949.068951363@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  6 Jun 2023 16:37:26 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Posix timers with a delivery mode of SIGEV_NONE deliver no signals but the
remaining expiry time must be readable via timer_gettime() for both one
shot and interval timers.

That's implemented correctly for regular posix timers but broken for posix
CPU timers.

Add a self test so the fixes can be verified.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 tools/testing/selftests/timers/posix_timers.c |   55 +++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -11,6 +11,7 @@
 #include <sys/types.h>
 #include <stdio.h>
 #include <signal.h>
+#include <stdint.h>
 #include <string.h>
 #include <unistd.h>
 #include <time.h>
@@ -20,6 +21,7 @@
 
 #define DELAY 2
 #define USECS_PER_SEC 1000000
+#define NSECS_PER_SEC 1000000000
 
 static void __fatal_error(const char *test, const char *name, const char *what)
 {
@@ -472,10 +474,59 @@ static void check_delete(void)
 		ksft_test_result_fail("check_delete\n");
 }
 
+static inline int64_t calcdiff_ns(struct timespec t1, struct timespec t2)
+{
+	int64_t diff;
+
+	diff = NSECS_PER_SEC * (int64_t)((int) t1.tv_sec - (int) t2.tv_sec);
+	diff += ((int) t1.tv_nsec - (int) t2.tv_nsec);
+	return diff;
+}
+
+static void check_sigev_none(int which, const char *name)
+{
+	struct timespec start, now;
+	struct itimerspec its;
+	struct sigevent sev;
+	timer_t timerid;
+
+	memset(&sev, 0, sizeof(sev));
+	sev.sigev_notify = SIGEV_NONE;
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
+	if (timer_gettime(timerid, &its))
+		fatal_error(name, "timer_gettime()");
+
+	if (timer_delete(timerid))
+		fatal_error(name, "timer_delete()");
+
+	if (its.it_value.tv_sec || its.it_value.tv_nsec)
+		ksft_test_result_pass("check_sigev_none %s\n", name);
+	else
+		ksft_test_result_fail("check_sigev_none %s\n", name);
+}
+
 int main(int argc, char **argv)
 {
 	ksft_print_header();
-	ksft_set_plan(10);
+	ksft_set_plan(12);
 
 	check_itimer(ITIMER_VIRTUAL, "ITIMER_VIRTUAL");
 	check_itimer(ITIMER_PROF, "ITIMER_PROF");
@@ -497,6 +548,8 @@ int main(int argc, char **argv)
 	check_sig_ign(1);
 	check_rearm();
 	check_delete();
+	check_sigev_none(CLOCK_MONOTONIC, "CLOCK_MONOTONIC");
+	check_sigev_none(CLOCK_PROCESS_CPUTIME_ID, "CLOCK_PROCESS_CPUTIME_ID");
 
 	ksft_finished();
 }


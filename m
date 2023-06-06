Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F2F724654
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237041AbjFFOhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237902AbjFFOh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:37:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9039E42
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:37:24 -0700 (PDT)
Message-ID: <20230606142031.189748136@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686062243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=yYUjgtlS1VYYLW2ktjjDityNYKx8aW+Dqr0QO8tGRWs=;
        b=dqlh7RYzlcA2jThLOloAPoArtDoxWdPYT7GQmlD3Zr7Iqj9FgxzLWj7BQt+DdU4HZmnHEV
        aeFB9SOdnYOPJm5JyY6uKvthAqUS/aZUNI6bQNbF27xSO4SpFBd/MSvN/EWF4Yx2XIiPTN
        uMMqDJa4CMmySUsPpx9UP/kyHYAsAkYWfME+fkM36x4s336v5ZQZonXRVPjgnNhBq05Vd7
        SngygYdiDVOBhMJC/Q144+gbjs8FsXRDh7DlqhgeCEjbMI5B3EGo2V6MNdSNffMGmbcZgh
        9MvSp7VXqBU76uQtWAteqRi/xhehkMsF2yzwLpHnTbfG/waGatznAK2N5KHGXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686062243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=yYUjgtlS1VYYLW2ktjjDityNYKx8aW+Dqr0QO8tGRWs=;
        b=lREuHplGAsm0oXNanGsGUW9sxxtwmwYdDXj/iv6dfw8WFGJ+gjV/scneX3N4i4Vy4HFCCI
        mbr1yfTldUxzHHBQ==
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
Subject: [patch 03/45] selftests/timers/posix_timers: Add SIG_IGN test
References: <20230606132949.068951363@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  6 Jun 2023 16:37:22 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a test case to validate correct behaviour vs. SIG_IGN.

The posix specification states:

  "Setting a signal action to SIG_IGN for a signal that is pending shall
   cause the pending signal to be discarded, whether or not it is blocked."

The kernel implements this in the signal handling code, but due to the way
how posix timers are handling SIG_IGN for periodic timers, the behaviour
after installing a real handler again is inconsistent and suprising.

The following sequence is expected to deliver a signal:

  install_handler(SIG);
  block_signal(SIG);
  timer_create(...);	 <- Should send SIG
  timer_settime(value=100ms, interval=100ms);
  sleep(1);		 <- Timer expires and queues signal, timer is not rearmed
  			    as that should happen in the signal delivery path
  ignore_signal(SIG);	 <- Discards queued signal
  install_handler(SIG);  <- Restore handler, should rearm but does not
  sleep(1);
  unblock_signal(SIG);	 <- Should deliver one signal with overrun count
  			    set in siginfo

This fails because nothing rearms the timer when the signal handler is
restored. Add a test for this case which fails until the signal and posix
timer code is fixed.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 tools/testing/selftests/timers/posix_timers.c |  128 +++++++++++++++++++++++++-
 1 file changed, 126 insertions(+), 2 deletions(-)

--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -6,8 +6,9 @@
  *
  * Kernel loop code stolen from Steven Rostedt <srostedt@redhat.com>
  */
-
+#define _GNU_SOURCE
 #include <sys/time.h>
+#include <sys/types.h>
 #include <stdio.h>
 #include <signal.h>
 #include <string.h>
@@ -241,10 +242,131 @@ static void check_timer_distribution(voi
 		ksft_test_result_fail("check_signal_distribution\n");
 }
 
+struct tmrsig {
+	int	signals;
+	int	overruns;
+};
+
+static void siginfo_handler(int sig, siginfo_t *si, void *uc)
+{
+	struct tmrsig *tsig = si ? si->si_ptr : NULL;
+
+	if (tsig) {
+		tsig->signals++;
+		tsig->overruns += si->si_overrun;
+	}
+}
+
+static void *ignore_thread(void *arg)
+{
+	unsigned int *tid = arg;
+	sigset_t set;
+
+	sigemptyset(&set);
+	sigaddset(&set, SIGUSR1);
+	if (sigprocmask(SIG_BLOCK, &set, NULL))
+		fatal_error(NULL, "sigprocmask(SIG_BLOCK)");
+
+	*tid = gettid();
+	sleep(100);
+
+	if (sigprocmask(SIG_UNBLOCK, &set, NULL))
+		fatal_error(NULL, "sigprocmask(SIG_UNBLOCK)");
+	return NULL;
+}
+
+static void check_sig_ign(int thread)
+{
+	struct tmrsig tsig = { };
+	struct itimerspec its;
+	unsigned int tid = 0;
+	struct sigaction sa;
+	struct sigevent sev;
+	pthread_t pthread;
+	timer_t timerid;
+	sigset_t set;
+
+	if (thread) {
+		if (pthread_create(&pthread, NULL, ignore_thread, &tid))
+			fatal_error(NULL, "pthread_create()");
+		sleep(1);
+	}
+
+	sa.sa_flags = SA_SIGINFO;
+	sa.sa_sigaction = siginfo_handler;
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(SIGUSR1, &sa, NULL))
+		fatal_error(NULL, "sigaction()");
+
+	/* Block the signal */
+	sigemptyset(&set);
+	sigaddset(&set, SIGUSR1);
+	if (sigprocmask(SIG_BLOCK, &set, NULL))
+		fatal_error(NULL, "sigprocmask(SIG_BLOCK)");
+
+	memset(&sev, 0, sizeof(sev));
+	sev.sigev_notify = SIGEV_SIGNAL;
+	sev.sigev_signo = SIGUSR1;
+	sev.sigev_value.sival_ptr = &tsig;
+	if (thread) {
+		sev.sigev_notify = SIGEV_THREAD_ID;
+		sev._sigev_un._tid = tid;
+	}
+
+	if (timer_create(CLOCK_MONOTONIC, &sev, &timerid))
+		fatal_error(NULL, "timer_create()");
+
+	/* Start the timer to expire in 100ms and 100ms intervals */
+	its.it_value.tv_sec = 0;
+	its.it_value.tv_nsec = 100000000;
+	its.it_interval.tv_sec = 0;
+	its.it_interval.tv_nsec = 100000000;
+	timer_settime(timerid, 0, &its, NULL);
+
+	sleep(1);
+
+	/* Set the signal to be ignored */
+	if (signal(SIGUSR1, SIG_IGN) == SIG_ERR)
+		fatal_error(NULL, "signal(SIG_IGN)");
+
+	sleep(1);
+
+	if (thread) {
+		/* Stop the thread first. No signal should be delivered to it */
+		pthread_cancel(pthread);
+		pthread_join(pthread, NULL);
+	}
+
+	/* Restore the handler */
+	if (sigaction(SIGUSR1, &sa, NULL))
+		fatal_error(NULL, "sigaction()");
+
+	sleep(1);
+
+	/* Unblock it, which should deliver the signal in the ! thread case*/
+	if (sigprocmask(SIG_UNBLOCK, &set, NULL))
+		fatal_error(NULL, "sigprocmask(SIG_UNBLOCK)");
+
+	if (timer_delete(timerid))
+		fatal_error(NULL, "timer_delete()");
+
+	if (!thread) {
+		if (tsig.signals == 1 && tsig.overruns == 29)
+			ksft_test_result_pass("check_sig_ign SIGEV_SIGNAL\n");
+		else
+			ksft_test_result_fail("check_sig_ign SIGEV_SIGNAL\n");
+	} else {
+		if (tsig.signals == 0 && tsig.overruns == 0)
+			ksft_test_result_pass("check_sig_ign SIGEV_THREAD_ID\n");
+		else
+			ksft_test_result_fail("check_sig_ign SIGEV_THREAD_ID\n");
+	}
+}
+
 int main(int argc, char **argv)
 {
 	ksft_print_header();
-	ksft_set_plan(6);
+	ksft_set_plan(8);
 
 	check_itimer(ITIMER_VIRTUAL, "ITIMER_VIRTUAL");
 	check_itimer(ITIMER_PROF, "ITIMER_PROF");
@@ -262,6 +384,8 @@ int main(int argc, char **argv)
 	 */
 	check_timer_create(CLOCK_PROCESS_CPUTIME_ID, "CLOCK_PROCESS_CPUTIME_ID");
 	check_timer_distribution();
+	check_sig_ign(0);
+	check_sig_ign(1);
 
 	ksft_finished();
 }


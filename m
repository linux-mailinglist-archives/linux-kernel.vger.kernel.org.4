Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C250967C92B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 11:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236866AbjAZKv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 05:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235465AbjAZKvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:51:52 -0500
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6295443463
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 02:51:34 -0800 (PST)
Received: by mail-ed1-x549.google.com with SMTP id m7-20020a056402510700b00488d1fcdaebso1171686edd.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 02:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LE++MGJulaPncdwa4NZlZtvl/+tE0GeDEL7On1SZ9ek=;
        b=XcYseLc8Q+bJpIcXanv0Dg7HMXL6mcfHubtZAtMCm+IBrkJETCyxu5rvXlHAs+jMYu
         HL2Rlz+jhomG8fK4IUe5QPkuUg2hphcdMx9h+TUyrriwLERJ2dZJqw9QaqCW9zu6D6tM
         QnfpOkm0JLk7+gEEjrquuc12Jx6wrlH7OcuyfcmtIcoKdPEsYHHUcLjnniUyyNFimwPT
         6SvVWbypCmFIwENit22ZXtANYow5taPZlzf/WfPJb09l+9SHkub9TsoxEV3ztXFL6B+5
         piAWOORjGebIfZUUUSBponbSmwQUmvAIICh6+/kluUzLYH3GT3uI1NQC7lJrTtSRoyu7
         W+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LE++MGJulaPncdwa4NZlZtvl/+tE0GeDEL7On1SZ9ek=;
        b=NXsuVo2iS1UMfKhIflBVuaqCvpV29A3fxX9mjiQRa5Pk/7LhxkcRcMTcUErVK4yM38
         RZp/2WoNwSTaB4cj2GUX49GiMYxWzVlCLPpXXAsKrPi/Nt80HMttqdOo1YwMvHUMSMxG
         2Wyn3ICTccDduMp3hoP+jUKwMN4rDjC6GCWK6jEVOSrIkR/lhOIRqOZglNLFLRUkvxFe
         +0I59JDwCVnc41B+uN0AafFKj8NMJc6qq0J30D8s1egIOcoz/psSnJAqquF6iWYqdOp4
         Xga8pNklLwLzU2z3A8lkbiuR9gzQk2bmwG79f6vx77K1Fs9MKTmxe3aNzmuk+de1NncN
         cG6A==
X-Gm-Message-State: AO0yUKUutrEE+kpqTkQQA3mChZ30bv+McwtGdGDqty333b2KXD7vPCB2
        kg0mtk8ILbyGMPa8mnyBEk/Q1V+WPAd1
X-Google-Smtp-Source: AK7set9hvFR2pk43OgXqsq6mWz6u9b66pObb408gC31NCRBArJKvAD+q8fHSRkAAgmIFcmNOvDpGA0dtJT2w
X-Received: from dvyukov-desk.muc.corp.google.com ([2a00:79e0:9c:201:46c8:d74d:fb5c:1fdd])
 (user=dvyukov job=sendgmr) by 2002:aa7:da99:0:b0:4a0:90bf:f4e0 with SMTP id
 q25-20020aa7da99000000b004a090bff4e0mr1568362eds.83.1674730292536; Thu, 26
 Jan 2023 02:51:32 -0800 (PST)
Date:   Thu, 26 Jan 2023 11:51:28 +0100
In-Reply-To: <20230112112411.813356-1-dvyukov@google.com>
Mime-Version: 1.0
References: <20230112112411.813356-1-dvyukov@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230126105128.2249938-1-dvyukov@google.com>
Subject: [PATCH v3] posix-timers: Prefer delivery of signals to the current thread
From:   Dmitry Vyukov <dvyukov@google.com>
To:     tglx@linutronix.de, oleg@redhat.com
Cc:     linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prefer to deliver signals to the current thread if SIGEV_THREAD_ID
is not set. We used to prefer the main thread, but delivering
to the current thread is both faster, and allows to sample actual thread
activity for CLOCK_PROCESS_CPUTIME_ID timers, and does not change
the semantics (since we queue into shared_pending, all thread may
receive the signal in both cases).

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Suggested-by: Oleg Nesterov <oleg@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Marco Elver <elver@google.com>

---

Changes in v3:
 - switched to the completely different implementation (much simpler)
   based on the Oleg's idea

Changes in RFC v2:
 - added additional Cc as Thomas asked
---
 kernel/signal.c                               | 19 ++++-
 tools/testing/selftests/timers/posix_timers.c | 73 +++++++++++++++++++
 2 files changed, 90 insertions(+), 2 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index ae26da61c4d9f..6ed71701f302c 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1003,8 +1003,7 @@ static void complete_signal(int sig, struct task_struct *p, enum pid_type type)
 	/*
 	 * Now find a thread we can wake up to take the signal off the queue.
 	 *
-	 * If the main thread wants the signal, it gets first crack.
-	 * Probably the least surprising to the average bear.
+	 * Try the suggested task first (may or may not be the main thread).
 	 */
 	if (wants_signal(sig, p))
 		t = p;
@@ -1970,7 +1969,23 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
 
 	ret = -1;
 	rcu_read_lock();
+	/*
+	 * This is called from posix timers. SIGEV_THREAD_ID signals
+	 * (type == PIDTYPE_PID) must be delivered to the user-specified
+	 * thread, so we use that and queue into t->pending.
+	 * Non-SIGEV_THREAD_ID signals must be delivered to "the process",
+	 * so we queue into shared_pending, but prefer to deliver to the
+	 * current thread. We used to prefer the main thread, but delivering
+	 * to the current thread is both faster, and allows user-space to
+	 * sample actual thread activity for CLOCK_PROCESS_CPUTIME_ID timers,
+	 * and does not change the semantics (since we queue into
+	 * shared_pending, all thread may receive the signal in both cases).
+	 * Note: current may be from a completely unrelated process for
+	 * non-cpu-time-based timers, we must be careful to not kick it.
+	 */
 	t = pid_task(pid, type);
+	if (t && type != PIDTYPE_PID && same_thread_group(t, current))
+		t = current;
 	if (!t || !likely(lock_task_sighand(t, &flags)))
 		goto ret;
 
diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/selftests/timers/posix_timers.c
index 0ba500056e635..fd3b933a191fe 100644
--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -188,6 +188,76 @@ static int check_timer_create(int which)
 	return 0;
 }
 
+int remain;
+__thread int got_signal;
+
+static void *distribution_thr(void *arg) {
+	while (__atomic_load_n(&remain, __ATOMIC_RELAXED));
+	return NULL;
+}
+
+static void distribution_handler(int nr)
+{
+	if (!__atomic_exchange_n(&got_signal, 1, __ATOMIC_RELAXED))
+		__atomic_fetch_sub(&remain, 1, __ATOMIC_RELAXED);
+}
+
+/* Test that all running threads receive CLOCK_PROCESS_CPUTIME_ID signals. */
+static int check_timer_distribution(void)
+{
+	int err, i;
+	timer_t id;
+	const int nthreads = 10;
+	pthread_t threads[nthreads];
+	struct itimerspec val = {
+		.it_value.tv_sec = 0,
+		.it_value.tv_nsec = 1000 * 1000,
+		.it_interval.tv_sec = 0,
+		.it_interval.tv_nsec = 1000 * 1000,
+	};
+
+	printf("Check timer_create() per process signal distribution... ");
+	fflush(stdout);
+
+	remain = nthreads + 1;  /* worker threads + this thread */
+	signal(SIGALRM, distribution_handler);
+	err = timer_create(CLOCK_PROCESS_CPUTIME_ID, NULL, &id);
+	if (err < 0) {
+		perror("Can't create timer\n");
+		return -1;
+	}
+	err = timer_settime(id, 0, &val, NULL);
+	if (err < 0) {
+		perror("Can't set timer\n");
+		return -1;
+	}
+
+	for (i = 0; i < nthreads; i++) {
+		if (pthread_create(&threads[i], NULL, distribution_thr, NULL)) {
+			perror("Can't create thread\n");
+			return -1;
+		}
+	}
+
+	/* Wait for all threads to receive the signal. */
+	while (__atomic_load_n(&remain, __ATOMIC_RELAXED));
+
+	for (i = 0; i < nthreads; i++) {
+		if (pthread_join(threads[i], NULL)) {
+			perror("Can't join thread\n");
+			return -1;
+		}
+	}
+
+	if (timer_delete(id)) {
+		perror("Can't delete timer\n");
+		return -1;
+	}
+
+	printf("[OK]\n");
+	return 0;
+}
+
 int main(int argc, char **argv)
 {
 	printf("Testing posix timers. False negative may happen on CPU execution \n");
@@ -217,5 +287,8 @@ int main(int argc, char **argv)
 	if (check_timer_create(CLOCK_PROCESS_CPUTIME_ID) < 0)
 		return ksft_exit_fail();
 
+	if (check_timer_distribution() < 0)
+		return ksft_exit_fail();
+
 	return ksft_exit_pass();
 }

base-commit: 7c46948a6e9cf47ed03b0d489fde894ad46f1437
-- 
2.39.1.456.gfc5497dd1b-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAEE69CF9A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 15:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbjBTOn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 09:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbjBTOn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 09:43:57 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC4617151
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 06:43:53 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id bv22-20020a0560001f1600b002c559840c76so259748wrb.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 06:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E2Gexm08XnOQ3QWenUz4vG1ws2r3ABrVMnKMUGht+2c=;
        b=T3iqTJqFTpZYFsvll84KCL7WEthdehOCv+IcwZRGVv2+KJRrIVrQUQ4uzwfDZMB3LU
         vtkdRMUNV2+DbhLrcixi4D5j8W61hsZBIoVosLkfZzWJckoy4ZZ8pUmE1/IZ011W7G9h
         wU4pXzXrcX2HbtdmZkMjpMXLnhVhjsQxNPjTCgjQU8abE5MfWyh14+B9I0mhGp/0ZWVg
         8Lc7pJYpObKOX5hzTcKUx+hEwrtVD8QJCagybJPwptCh+GmC4qrCca8ZjHZAqSnLTEu9
         P11aCef3RokkUzcUcLgfjBNAOIGHP2+dHBMbQHl6555F5lLjdCLpwUNxwFhPjlUPR/gw
         Bxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E2Gexm08XnOQ3QWenUz4vG1ws2r3ABrVMnKMUGht+2c=;
        b=pCs1aIxVxpqbNzjJAs9Zp1pckNB8DsjmtQiajaLen9taZf8KC2zCq/H43IPxpwghJx
         nFjfWqgTTl/cHEBi/3FRyJ9L+zJXGXT9gXCDXmtSGVkzweZrSKnLFtavOSLmT0my+O7e
         x/jz9FGEBz+RTeoJA27HaMzknUB9ylW7W/Cd+BmlTBkJGBUbbu8Toz2Iag6mFV8RofZp
         stIAdKG7eHT4RHhX05KVePi4Q6vLJ544XRMyyugpCNn2EWg3JuF/QotuS5JM93zGtLZH
         ROUstnc9JOG0U25XAZSzuwOYC3cjceiwPlhZBU2RZ7WYQMjzcs8KnqJTJFBQr0PW6A46
         ChvA==
X-Gm-Message-State: AO0yUKVSFlV7ig0MayCLgbuWtdKqTYjGDUCtAxPnRSAKttmO1dTeMAkM
        3rv7knqOfoxhD4LTSX/a1vA724u91+ub
X-Google-Smtp-Source: AK7set83JQamfSGSMXwVfoKidtfchMorTJIPXV+VSLu9dSUwxWNH5etlnzTEyUudZGPlulbQBzWAkpxeuQLu
X-Received: from dvyukov-desk.muc.corp.google.com ([2a00:79e0:9c:201:db6a:5e90:55fc:1e1b])
 (user=dvyukov job=sendgmr) by 2002:a05:600c:a42:b0:3e2:20c7:a41b with SMTP id
 c2-20020a05600c0a4200b003e220c7a41bmr680791wmq.22.1676904232282; Mon, 20 Feb
 2023 06:43:52 -0800 (PST)
Date:   Mon, 20 Feb 2023 15:43:47 +0100
In-Reply-To: <20230126154118.2393850-1-dvyukov@google.com>
Mime-Version: 1.0
References: <20230126154118.2393850-1-dvyukov@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230220144347.267585-1-dvyukov@google.com>
Subject: [PATCH v5] posix-timers: Prefer delivery of signals to the current thread
From:   Dmitry Vyukov <dvyukov@google.com>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, oleg@redhat.com,
        Dmitry Vyukov <dvyukov@google.com>,
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
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Marco Elver <elver@google.com>

---
Changes in v5:
 - rebased onto v6.2

Changes in v4:
 - restructured checks in send_sigqueue() as suggested

Changes in v3:
 - switched to the completely different implementation (much simpler)
   based on the Oleg's idea

Changes in RFC v2:
 - added additional Cc as Thomas asked
---
 kernel/signal.c                               | 23 +++++-
 tools/testing/selftests/timers/posix_timers.c | 73 +++++++++++++++++++
 2 files changed, 93 insertions(+), 3 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index ae26da61c4d9f..706ad3a21933d 100644
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
@@ -1970,8 +1969,26 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
 
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
-	if (!t || !likely(lock_task_sighand(t, &flags)))
+	if (!t)
+		goto ret;
+	if (type != PIDTYPE_PID && same_thread_group(t, current))
+		t = current;
+	if (!likely(lock_task_sighand(t, &flags)))
 		goto ret;
 
 	ret = 1; /* the signal is ignored */
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

base-commit: c9c3395d5e3dcc6daee66c6908354d47bf98cb0c
-- 
2.39.2.637.g21b0678d19-goog


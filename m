Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C15364F03B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 18:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbiLPRSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 12:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbiLPRSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 12:18:14 -0500
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E86389FB
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 09:18:13 -0800 (PST)
Received: by mail-ej1-x64a.google.com with SMTP id xj11-20020a170906db0b00b0077b6ecb23fcso2252019ejb.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 09:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dzRLghZOASFCJWHj5gtENvJEmLxYgTqYLUuzMhO6yYg=;
        b=NqEhCAuwbwnQE4D8DgjXx6N0iIQHvSsmrAyu1FePW+2jSLWjW6C3cICygy9eRm1uxb
         /J022jNT29ZQebL8NiHod4MHcDBpQ9dcRSSzBrUQpd/J/RLGlXqR6sP/yIXuAV33dsG3
         qnhjfX1Sw2IfW5hP1QMVlEhg7N/f1V+kDma2WTKPgEeTleHQ9dDw3rUYC6yx3XuE8qIs
         dBFnvxAD9/Iu9ZA4ezWAtp7aMx6KrDgbvUC8fkJ0VjBmYqTXOZ9gIzLTEcm+uuj6AVcp
         n0/uh9Kwh9nLHNhp5f/t6AxFzwdYD5PHZZS/fG4acSXFsNf+QbrGrKX1Oo1B3qhGK85I
         igqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dzRLghZOASFCJWHj5gtENvJEmLxYgTqYLUuzMhO6yYg=;
        b=hZf+H3H3GcQC42zK/EU1L122Gtg4zqKJLJ94hH3/U78bR7GwMzxapW+09TqQziduXo
         95aio3OVVayzPuvVolEdKk6X2l8h3jXwhVExgfpCCU0bRS0/pvbta7XaEJ14eLqReCR0
         OjEHi0rIZHV3lWJqo9gTf9lfVI8x1s6XXvVYzVM+z4WlWADXRbllPoIXOVtYGBICe2RU
         HKIHpotKF0uY4nY4IPs7BMyIi0liZe6mzVOWh9caU9QnqLxjnqoCtvU9NRD/9yNnMrsH
         NwrbYQ/9Zmue0i3KWKzf+zrsTQ7Ptu/0NZrpn2wCXKbgooQXlzQ+szEFiCy88qFGeSIp
         e9Mg==
X-Gm-Message-State: ANoB5pkGXq1CYUDedpVQHCGusaJoTvaAE60/KywkBk5Pef6OJdFOy4Tg
        t9oLgl4OZUyRSzn0rATzEBQ7tauEkAhQ
X-Google-Smtp-Source: AA0mqf4KsedZ4fYUi5csgDIepYf3cb9p2oVcrccKNsymSrj3FGpvxAULnrUnfAHBYeL5rbfwKUEtkMOU0WWI
X-Received: from dvyukov-desk.muc.corp.google.com ([2a00:79e0:9c:201:aa0c:a811:b910:ca2d])
 (user=dvyukov job=sendgmr) by 2002:a17:906:2988:b0:7c0:b56a:eadf with SMTP id
 x8-20020a170906298800b007c0b56aeadfmr10003794eje.271.1671211091732; Fri, 16
 Dec 2022 09:18:11 -0800 (PST)
Date:   Fri, 16 Dec 2022 18:18:07 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221216171807.760147-1-dvyukov@google.com>
Subject: [RFC PATCH] posix-timers: Support delivery of signals to the current thread
From:   Dmitry Vyukov <dvyukov@google.com>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
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

Support CLOCK_PROCESS_CPUTIME_ID timers with SIGEV_SIGNAL | SIGEV_THREAD_ID
and sigev_notify_thread_id == 0, which sends the signal to the current
thread that fires the timer. This is useful for relatively uniform sampling
of process execution across all threads with signals.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marco Elver <elver@google.com>

---

We are trying to implement sampling program analysis based on this.
We don't need 100% uniform sampling as a CPU profiler would need,
but we still need the signals to be reasonably distributed across
the process threads.

Thomas, does the idea look sane to you overall?
Are there any existing alternatives to this?

All alternatives we found are complex and/or have high overhead.
E.g. we considered using CLOCK_PROCESS_CPUTIME_ID+SIGEV_SIGNAL timer
plus inherited for all threads perf_event(PERF_COUNT_SW_TASK_CLOCK).
When the timer fires we enable the perf event, and then use the signals
from the perf event, and then disable the perf event.
But this has considerable memory overhead (perf event per thread)
and issues IPIs to all CPUs for perf event enable/disable.

We also considered using CLOCK_PROCESS_CPUTIME_ID+SIGEV_SIGNAL timer
and then manually scan /proc/self/task/ and select some task at random.
But this is also complex and makes it hard to do reasonable sampling
proportional to activity of threads.

All alternatives are based on CLOCK_PROCESS_CPUTIME_ID in some way,
and it seems that just a single CLOCK_PROCESS_CPUTIME_ID timer is enough
if it could deliver signals to active threads (what this patch is doing).
The analysis we are trying to do is intended for production systems
so we are aiming at as low overhead as possible.

If this idea looks sane to you in general, I will add tests and I am open
to suggestions on the user API (should it be a new SIGEV_CURRENT_THREAD?)
and on how to represent this in the struct k_itimer. E.g. we could keep
it_pid=current but add a special flag that says to send the signal to
the current task rather than it_pid. This has an advantage that we can
add the following check to posix_timer_event()
(which would be pretty bad to violate):
WARN_ON(!same_thread_group(pid_task(timr->it_pid, PIDTYPE_PID), current));
---
 kernel/time/posix-timers.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 5dead89308b74..411ba087e0699 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -336,6 +336,7 @@ void posixtimer_rearm(struct kernel_siginfo *info)
 int posix_timer_event(struct k_itimer *timr, int si_private)
 {
 	enum pid_type type;
+	struct pid *pid;
 	int ret;
 	/*
 	 * FIXME: if ->sigq is queued we can race with
@@ -350,8 +351,9 @@ int posix_timer_event(struct k_itimer *timr, int si_private)
 	 */
 	timr->sigq->info.si_sys_private = si_private;
 
+	pid = timr->it_pid ?: task_pid(current);
 	type = !(timr->it_sigev_notify & SIGEV_THREAD_ID) ? PIDTYPE_TGID : PIDTYPE_PID;
-	ret = send_sigqueue(timr->sigq, timr->it_pid, type);
+	ret = send_sigqueue(timr->sigq, pid, type);
 	/* If we failed to send the signal the timer stops. */
 	return ret > 0;
 }
@@ -428,27 +430,31 @@ static enum hrtimer_restart posix_timer_fn(struct hrtimer *timer)
 	return ret;
 }
 
-static struct pid *good_sigevent(sigevent_t * event)
+static struct pid *good_sigevent(sigevent_t *event, clockid_t which_clock)
 {
 	struct pid *pid = task_tgid(current);
 	struct task_struct *rtn;
 
 	switch (event->sigev_notify) {
 	case SIGEV_SIGNAL | SIGEV_THREAD_ID:
+		/* This will use the current task for signals. */
+		if (which_clock == CLOCK_PROCESS_CPUTIME_ID &&
+		    !event->sigev_notify_thread_id)
+			return NULL;
 		pid = find_vpid(event->sigev_notify_thread_id);
 		rtn = pid_task(pid, PIDTYPE_PID);
 		if (!rtn || !same_thread_group(rtn, current))
-			return NULL;
+			return ERR_PTR(-ENOENT);
 		fallthrough;
 	case SIGEV_SIGNAL:
 	case SIGEV_THREAD:
 		if (event->sigev_signo <= 0 || event->sigev_signo > SIGRTMAX)
-			return NULL;
+			return ERR_PTR(-EINVAL);
 		fallthrough;
 	case SIGEV_NONE:
 		return pid;
 	default:
-		return NULL;
+		return ERR_PTR(-EINVAL);
 	}
 }
 
@@ -502,6 +508,7 @@ static int do_timer_create(clockid_t which_clock, struct sigevent *event,
 	struct k_itimer *new_timer;
 	int error, new_timer_id;
 	int it_id_set = IT_ID_NOT_SET;
+	struct pid *pid;
 
 	if (!kc)
 		return -EINVAL;
@@ -527,9 +534,11 @@ static int do_timer_create(clockid_t which_clock, struct sigevent *event,
 
 	if (event) {
 		rcu_read_lock();
-		new_timer->it_pid = get_pid(good_sigevent(event));
+		pid = good_sigevent(event, which_clock);
+		if (!IS_ERR(pid))
+			new_timer->it_pid = get_pid(pid);
 		rcu_read_unlock();
-		if (!new_timer->it_pid) {
+		if (IS_ERR(pid)) {
 			error = -EINVAL;
 			goto out;
 		}

base-commit: 041fae9c105ae342a4245cf1e0dc56a23fbb9d3c
-- 
2.39.0.314.g84b9a713c41-goog


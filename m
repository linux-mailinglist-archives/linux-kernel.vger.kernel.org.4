Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F166D6670FD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 12:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbjALLeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 06:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234004AbjALLdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 06:33:36 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9CC32256
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 03:24:16 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-4bdeb1bbeafso189058077b3.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 03:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UKHwnKRClf54k5h7cNJlfLAn7wPxBIh1uVtn+PO3ZGA=;
        b=I8Dus2hT1HzrOr5aU/mS8oyCZqWtbMC5Vxg2PgTqc8XShSZtwQuxncXvOsmlPGIIdO
         RXtFDO8XQhubiOO+kFAi+ZN8gZIfUw93/BMXv/E9Hs6hyf+23evq0cMgqgyh1dGH2jVl
         gUQUx0WywP6Evt14/TjIlDwRxT1Us5OMptzjox4EU2PMLP9HqNOLrnWa4izKKmHzaBQS
         KvCJl8Fmk7iWUvLjUDUoMP7mhlGnrkMLcB4mQGZr/gSpGOcg75O+MdmtL0hB3hTs4In/
         Ckn/ey2CESSe/jwB25xPatuoZvCjoWucmyauUt/2hNexWLJWWH1A5G226l1XFWIGSgqj
         0IIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UKHwnKRClf54k5h7cNJlfLAn7wPxBIh1uVtn+PO3ZGA=;
        b=gYu0cIK9YvcNAJ/RZPIkNMUtM6MV/kXaeOMYVm8sg6wXHvy02m+7/YRPwjW4GLKxWA
         x37UKnBSUilGAKaZdtuqnxqwp/KeaJ9kMXmCQkQdyk2o8wiGPtDmfPqx6T6GXvRGoL+J
         SRko8kTJW7sqApEYtzmnzjhsjte7kqloIcO1vGzG6diVMTDJo8KEnKb7XT1ufhPQiKmd
         nPb1sPZzOSzXZ4sC+utZAxgfdo7muB2Dmk8YTBZVZe7zBheLddfo5BnGGGqvBODbyFwU
         7AmKNFOo/wbC8tkP4Ifqajope749rAlxwScLkmrFBOoDAFAr5nhe3HyRDWsqJu4ue918
         hI/w==
X-Gm-Message-State: AFqh2kpAt2N3urTe15xwH/oF+KwrZ6vmIoOHnv57ldogzxW/Dzo7ROcC
        zbJ0FdjLAxmid/pxhSmoUQQbnPOVRV0V
X-Google-Smtp-Source: AMrXdXt5QXpz7p9HO2AKsRLq4LGAo1EiQRYSZ0OuANf+0qxnykkeoQqovhVGdYgEXd1uhZBHLE7WzYnyR1/Z
X-Received: from dvyukov-desk.muc.corp.google.com ([2a00:79e0:9c:201:96d9:f808:8860:94b8])
 (user=dvyukov job=sendgmr) by 2002:a25:4d1:0:b0:7bd:891f:a1a4 with SMTP id
 200-20020a2504d1000000b007bd891fa1a4mr1829456ybe.532.1673522655364; Thu, 12
 Jan 2023 03:24:15 -0800 (PST)
Date:   Thu, 12 Jan 2023 12:24:11 +0100
In-Reply-To: <20221216171807.760147-1-dvyukov@google.com>
Mime-Version: 1.0
References: <20221216171807.760147-1-dvyukov@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230112112411.813356-1-dvyukov@google.com>
Subject: [RFC PATCH v2] posix-timers: Support delivery of signals to the
 current thread
From:   Dmitry Vyukov <dvyukov@google.com>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
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

Support CLOCK_PROCESS_CPUTIME_ID timers with SIGEV_SIGNAL | SIGEV_THREAD_ID
and sigev_notify_thread_id == 0, which sends the signal to the current
thread that fires the timer. This is useful for relatively uniform sampling
of process execution across all threads with signals.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
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

Changes in RFC v2:
 - added additional Cc as Thomas asked
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

base-commit: e8f60cd7db24f94f2dbed6bec30dd16a68fc0828
-- 
2.39.0.314.g84b9a713c41-goog


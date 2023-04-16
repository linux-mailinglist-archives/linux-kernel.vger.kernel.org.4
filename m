Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7812C6E358B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 09:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjDPHET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 03:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjDPHEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 03:04:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C9A1FE5;
        Sun, 16 Apr 2023 00:04:10 -0700 (PDT)
Date:   Sun, 16 Apr 2023 07:04:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681628649;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FDrX5X3OePpfMmerIBXTGeWzkwQBD/rUKSU6hHFCNFo=;
        b=ypjsD0hw8XpL4+aOyJqUvWQwtrBnfjZkbJB3F2Z3ADsi0TM4pQVyakuPJ8aPZR6olgzzFt
        s86faWQHGnoSOb5EGMJB2DRiHS8By0jCdcgHc/t9E+fQG53W49xivXENG9xdsL66QGcaka
        7nlKGBu7m2R2YQKilqDsIEb1gL0W/LeLEb1Dq9rsRfYcd9TAoKsYg2HAamBo39NBNwMY/x
        dJbb60ya9iLmgsnEPJwlIV4n+E1v6Y9BW8jdeEafSNZHlMvYR24BvpttfyMcHVtthYouKq
        bQrPiyJSQ0QvQ3uBDVzoXS4Wu/O40mujA7944qOmchSfzqLyO2EdRBHPVXjA7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681628649;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FDrX5X3OePpfMmerIBXTGeWzkwQBD/rUKSU6hHFCNFo=;
        b=IdlXpufRto69GAZhEJU7j+cPyG1lx4SdatKwEUQVn0FUkAAAuod78pDXKmS1LrJ5z8yCUj
        JeljgdIted5pBgBA==
From:   "tip-bot2 for Dmitry Vyukov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Prefer delivery of signals to the
 current thread
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230316123028.2890338-1-elver@google.com>
References: <20230316123028.2890338-1-elver@google.com>
MIME-Version: 1.0
Message-ID: <168162864858.404.11836404676377275448.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     bcb7ee79029dcaeb09668a4d1489de256829a7cc
Gitweb:        https://git.kernel.org/tip/bcb7ee79029dcaeb09668a4d1489de256829a7cc
Author:        Dmitry Vyukov <dvyukov@google.com>
AuthorDate:    Thu, 16 Mar 2023 13:30:27 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 16 Apr 2023 09:00:18 +02:00

posix-timers: Prefer delivery of signals to the current thread

POSIX timers using the CLOCK_PROCESS_CPUTIME_ID clock prefer the main
thread of a thread group for signal delivery. However, this has a
significant downside: it requires waking up a potentially idle thread.

Instead, prefer to deliver signals to the current thread (in the same
thread group) if SIGEV_THREAD_ID is not set by the user. This does not
change guaranteed semantics, since POSIX process CPU time timers have
never guaranteed that signal delivery is to a specific thread (without
SIGEV_THREAD_ID set).

The effect is that queueing the signal no longer wakes up potentially idle
threads, and the kernel is no longer biased towards delivering the timer
signal to any particular thread (which better distributes the timer signals
esp. when multiple timers fire concurrently).

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230316123028.2890338-1-elver@google.com

---
 kernel/signal.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 8cb28f1..8f6330f 100644
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
@@ -1970,8 +1969,24 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
 
 	ret = -1;
 	rcu_read_lock();
+
+	/*
+	 * This function is used by POSIX timers to deliver a timer signal.
+	 * Where type is PIDTYPE_PID (such as for timers with SIGEV_THREAD_ID
+	 * set), the signal must be delivered to the specific thread (queues
+	 * into t->pending).
+	 *
+	 * Where type is not PIDTYPE_PID, signals must be delivered to the
+	 * process. In this case, prefer to deliver to current if it is in
+	 * the same thread group as the target process, which avoids
+	 * unnecessarily waking up a potentially idle task.
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

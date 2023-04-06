Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A9F6DA407
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239851AbjDFUt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239779AbjDFUtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:49:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0334CAF0F
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 13:47:24 -0700 (PDT)
Date:   Thu, 6 Apr 2023 22:47:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680814042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4nfE2RKzKiS1tWZ/hTXfIEE3f8A6Qg1pMEXWmyuRQ0M=;
        b=asdcemsX5gQAeB9ZmYCyRtnrQRO/JHCniKJHJch8lrqeeCCoDHL1pqGgf314kbXED35vmK
        dgMRclkyGfVOr066VOEeMgZlYXfIOaIQ5mdzA/GjutbEYywBo32Z4w3mvlyaOxNxEN/YgK
        RFOW/8oqAWMnIzdQKUZpYaCedm96SJU9QNoLbh73zdppjFwxCiAhh/ullocwUEyauGMqJs
        ORj8MpSTWfmHqPgbAsxvnUDdlp8GNl+HEoSe/XgGKHjlJV9SHLpb4VZT6szkSuBF1wwLmk
        C114EQZ3tRa6ztigZstEcJ44ETmWACN0aJRDPeKQXStTYLteVdkskW+lE5UWog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680814042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4nfE2RKzKiS1tWZ/hTXfIEE3f8A6Qg1pMEXWmyuRQ0M=;
        b=C6OnuerOp+NhYe6FwXhKS+hSfZaUXaOZ3J7i6FpT5gYn12KiqNgYUeg03BeMGZeZZihPYx
        D5BPAbdZxQvXyxBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Ben Segall <bsegall@google.com>,
        Christian Brauner <brauner@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v4] signal: Let tasks cache one sigqueue struct.
Message-ID: <20230406204721.A6lSYL7A@linutronix.de>
References: <20230406194004.KP1K6FwO@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230406194004.KP1K6FwO@linutronix.de>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sigqueue caching originated in the PREEMPT_RT tree. A few of the
applications, that were ported to Linux, were ported from OS-9. Sending
notifications from one task to another via a signal was a common
communication model there and so the applications are heavy signal
users. Removing the allocation reduces the critical path, avoids locks
and so lowers the maximal latency of the task while sending a signal.

After posting the first version a discussion came up whether it wouldn't
make sense to have this caching unconditionally and not restricted to
PREEMPT_RT only.

The sigqueue flagged SIGQUEUE_PREALLOC is used by the POSIX timer code.
It is allocated on initialisation and reused during the lifetime of the
timer. The sigqueue is freed once the timer is deleted. The POSIX timer
sigqueue has its own caching and unique lifetime pattern and therefore
does not fit for the generic caching.

In the common case the signal is dequeued and freed in collect_signal().
At this point, the 'current' task receives the signal and its
sighand_struct::siglock is held.

__sigqueue_alloc() is used to allocate a new sigqueue. The task_struct
passed as argument is the task that will receive the signal. Its
sighand_struct::siglock is acquired (except for SIGQUEUE_PREALLOC
allocation which is ignored). Use a cached sigqueue before allocating a
new one.

As a result of this pattern, the task sending a signal will use the
cache from the task that will receive the signal which in turn caches
the signal.

The numbers of system boot followed by an allmod kernel build:
Out of 333216 allocations, 194876 (~58%) were served from the cache.
=46rom all free invocations, 4212 were in a path were caching is not done
and 329002 sigqueue were cached.

Cache the struct sigqueue in collect_signal() and reuse it for the
allocation. Rely on sighand_struct::siglock locking for cache handling
which is held during allocation and free. The cache is cleaned once
sighand_struct is freed.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v3=E2=80=A6v4: Repost with Brauner and Torvalds on Cc.
v2=E2=80=A6v3: Wrote the patch and its description from scratch without loo=
king
       at the previous version.

 include/linux/sched/signal.h |    2 +
 kernel/fork.c                |   11 +++++++++
 kernel/signal.c              |   48 ++++++++++++++++++++++++++++++++++++++=
+----
 3 files changed, 57 insertions(+), 4 deletions(-)

--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -22,6 +22,7 @@ struct sighand_struct {
 	refcount_t		count;
 	wait_queue_head_t	signalfd_wqh;
 	struct k_sigaction	action[_NSIG];
+	struct sigqueue		*sigqueue_cache;
 };
=20
 /*
@@ -349,6 +350,7 @@ extern int send_sig(int, struct task_str
 extern int zap_other_threads(struct task_struct *p);
 extern struct sigqueue *sigqueue_alloc(void);
 extern void sigqueue_free(struct sigqueue *);
+extern void sigqueue_free_cached_entry(struct sigqueue *q);
 extern int send_sigqueue(struct sigqueue *, struct pid *, enum pid_type);
 extern int do_sigaction(int, struct k_sigaction *, struct k_sigaction *);
=20
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1661,6 +1661,7 @@ static int copy_sighand(unsigned long cl
 	RCU_INIT_POINTER(tsk->sighand, sig);
 	if (!sig)
 		return -ENOMEM;
+	sig->sigqueue_cache =3D NULL;
=20
 	refcount_set(&sig->count, 1);
 	spin_lock_irq(&current->sighand->siglock);
@@ -1677,7 +1678,17 @@ static int copy_sighand(unsigned long cl
 void __cleanup_sighand(struct sighand_struct *sighand)
 {
 	if (refcount_dec_and_test(&sighand->count)) {
+		struct sigqueue *sigqueue =3D NULL;
+
 		signalfd_cleanup(sighand);
+		spin_lock_irq(&sighand->siglock);
+		if (sighand->sigqueue_cache) {
+			sigqueue =3D sighand->sigqueue_cache;
+			sighand->sigqueue_cache =3D NULL;
+		}
+		spin_unlock_irq(&sighand->siglock);
+
+		sigqueue_free_cached_entry(sigqueue);
 		/*
 		 * sighand_cachep is SLAB_TYPESAFE_BY_RCU so we can free it
 		 * without an RCU grace period, see __lock_task_sighand().
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -432,7 +432,18 @@ static struct sigqueue *
 		return NULL;
=20
 	if (override_rlimit || likely(sigpending <=3D task_rlimit(t, RLIMIT_SIGPE=
NDING))) {
-		q =3D kmem_cache_alloc(sigqueue_cachep, gfp_flags);
+
+		if (!sigqueue_flags) {
+			struct sighand_struct *sighand =3D t->sighand;
+
+			lockdep_assert_held(&sighand->siglock);
+			if (sighand->sigqueue_cache) {
+				q =3D sighand->sigqueue_cache;
+				sighand->sigqueue_cache =3D NULL;
+			}
+		}
+		if (!q)
+			q =3D kmem_cache_alloc(sigqueue_cachep, gfp_flags);
 	} else {
 		print_dropped_signal(sig);
 	}
@@ -447,14 +458,43 @@ static struct sigqueue *
 	return q;
 }
=20
-static void __sigqueue_free(struct sigqueue *q)
+static bool sigqueue_cleanup_accounting(struct sigqueue *q)
 {
 	if (q->flags & SIGQUEUE_PREALLOC)
-		return;
+		return false;
 	if (q->ucounts) {
 		dec_rlimit_put_ucounts(q->ucounts, UCOUNT_RLIMIT_SIGPENDING);
 		q->ucounts =3D NULL;
 	}
+	return true;
+}
+
+static void __sigqueue_free(struct sigqueue *q)
+{
+	if (!sigqueue_cleanup_accounting(q))
+		return;
+	kmem_cache_free(sigqueue_cachep, q);
+}
+
+void sigqueue_free_cached_entry(struct sigqueue *q)
+{
+	if (!q)
+		return;
+	kmem_cache_free(sigqueue_cachep, q);
+}
+
+static void sigqueue_cache_or_free(struct sigqueue *q)
+{
+	struct sighand_struct *sighand =3D current->sighand;
+
+	if (!sigqueue_cleanup_accounting(q))
+		return;
+
+	lockdep_assert_held(&sighand->siglock);
+	if (!sighand->sigqueue_cache) {
+		sighand->sigqueue_cache =3D q;
+		return;
+	}
 	kmem_cache_free(sigqueue_cachep, q);
 }
=20
@@ -594,7 +634,7 @@ static void collect_signal(int sig, stru
 			(info->si_code =3D=3D SI_TIMER) &&
 			(info->si_sys_private);
=20
-		__sigqueue_free(first);
+		sigqueue_cache_or_free(first);
 	} else {
 		/*
 		 * Ok, it wasn't in the queue.  This must be


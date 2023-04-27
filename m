Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B331B6F04DF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 13:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243463AbjD0LT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 07:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243561AbjD0LTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 07:19:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A52E5277
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 04:19:46 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682594385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w7SiOThIQ863K6oJvVNAv7De2opm8Uk3DJjr8iS90qc=;
        b=oZYijA09gs1W+HixBhBUTywY91zPkNMZlMSfNHnaMbMWBseV8AYEnY8zYx9B5isQZHVMCX
        wpkZtNYaHOVxJUJv+gSd7PBNmFI0uW3UmwnF1ZQNVLN1D7Cdqtzy9kGlOC88T2wMKycg7D
        +GpP+cfi5IupFM7/tyvniKKryq9KV/+B7ln8iCcSZMM+W4JOa4P9PqDljCFZpoYTwkPLYk
        Rv0dTfXJSG5EcrXcXTpJUowENq6TFP8DN/zpXH3Wz0SUJYCX7oEelnKQQh58fcNMIJvYFV
        4EsLWM8uF6VqbSolkXfIdmakwlFazEBCDC+UX1LNc2POR4Z/m/ge3vFtdSIKag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682594385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w7SiOThIQ863K6oJvVNAv7De2opm8Uk3DJjr8iS90qc=;
        b=YOAwTPHx6SRktxKl/lL048FMWg95bASatMmM3bNYK79/tErexC/Gtrfjto2afxjuVJNGwx
        TnjHTOIEoStIXICQ==
To:     linux-kernel@vger.kernel.org
Cc:     Ben Segall <bsegall@google.com>, Boqun Feng <boqun.feng@gmail.com>,
        Crystal Wood <swood@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        John Stultz <jstultz@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 4/4] locking/rtmutex: Add a lockdep assert to catch potential nested blocking
Date:   Thu, 27 Apr 2023 13:19:37 +0200
Message-Id: <20230427111937.2745231-5-bigeasy@linutronix.de>
In-Reply-To: <20230427111937.2745231-1-bigeasy@linutronix.de>
References: <20230427111937.2745231-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

There used to be a BUG_ON(current->pi_blocked_on) in the lock acquisition
functions, but that vanished in one of the rtmutex overhauls.

Bring it back in form of a lockdep assert to catch code paths which take
rtmutex based locks with current::pi_blocked_on !=3D NULL.

Reported-by: Crystal Wood <swood@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/locking/rtmutex.c     | 2 ++
 kernel/locking/rwbase_rt.c   | 2 ++
 kernel/locking/spinlock_rt.c | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index dd76c1b9b7d21..479a9487edcc2 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1727,6 +1727,8 @@ static int __sched rt_mutex_slowlock(struct rt_mutex_=
base *lock,
 static __always_inline int __rt_mutex_lock(struct rt_mutex_base *lock,
 					   unsigned int state)
 {
+	lockdep_assert(!current->pi_blocked_on);
+
 	if (likely(rt_mutex_try_acquire(lock)))
 		return 0;
=20
diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
index 945d474f5d27f..5be92ca5afabc 100644
--- a/kernel/locking/rwbase_rt.c
+++ b/kernel/locking/rwbase_rt.c
@@ -133,6 +133,8 @@ static __always_inline int rwbase_read_lock(struct rwba=
se_rt *rwb,
 {
 	int ret;
=20
+	lockdep_assert(!current->pi_blocked_on);
+
 	if (rwbase_read_trylock(rwb))
 		return 0;
=20
diff --git a/kernel/locking/spinlock_rt.c b/kernel/locking/spinlock_rt.c
index 62c4a6866087a..9fe282cd145d9 100644
--- a/kernel/locking/spinlock_rt.c
+++ b/kernel/locking/spinlock_rt.c
@@ -37,6 +37,8 @@
=20
 static __always_inline void rtlock_lock(struct rt_mutex_base *rtm)
 {
+	lockdep_assert(!current->pi_blocked_on);
+
 	if (unlikely(!rt_mutex_cmpxchg_acquire(rtm, NULL, current)))
 		rtlock_slowlock(rtm);
 }
--=20
2.40.1


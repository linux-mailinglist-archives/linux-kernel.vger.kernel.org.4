Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33CB63AD1E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 16:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbiK1P6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 10:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbiK1P6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 10:58:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19458BD4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 07:58:34 -0800 (PST)
Date:   Mon, 28 Nov 2022 16:58:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669651111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A66/46AU4UvCnvx7caei9Qq2LugCVmbyBrEUb+7Nb3k=;
        b=1wi0T/h5beasSjiXUvWgR6HtcUuIJjyNPOSpX/jNuLaouoHCQjl3WU/YANj1y5O+MXjLRZ
        N/Uw+lQ5SPNx2gtjwMLU8wd0+9RMsjkIkq4zsXe6QbkQqR2xmq8gj8ofzzreNUIBHeF0QQ
        VC44qSsyDF6P6dKaE0Y4qZhctIgOr7DQhMmUZ4robLOGwj80b6SF+TT4UA1MhfhIvJF6L4
        uMJ/z8xgM+JDdUgYWfvBrY5AGEc1EvoUa4iAqu2lCgJ+LBssq7Cpu12aeabZEWzgk/wtK8
        kYTUgkpDJhL5DQWiMbht4NVEk+ZAU5kc3I5FEpPJwSlYugT3dyzeov2IycYXKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669651111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A66/46AU4UvCnvx7caei9Qq2LugCVmbyBrEUb+7Nb3k=;
        b=sa/BMwcp3ut06BvlmZ/QIhDayHmH7YZS5fUXmbDvHxAQNSlW4asdkc8hHKQNicF0vlLZtL
        L2fg8wLj2Pk4gFBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Will Deacon <will@kernel.org>, Jan Kara <jack@suse.cz>
Cc:     Waiman Long <longman@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: Crash with PREEMPT_RT on aarch64 machine
Message-ID: <Y4Tapja2qq8HiHBZ@linutronix.de>
References: <20221103115444.m2rjglbkubydidts@quack3>
 <Y2U+Je+LICO2HkNY@linutronix.de>
 <20221107135636.biouna36osqc4rik@quack3>
 <Y2kf6tcX47Cl7q0W@linutronix.de>
 <359cc93a-fce0-5af2-0fd5-81999fad186b@redhat.com>
 <20221109125756.GA24388@willie-the-truck>
 <20221109154023.cx2d4y3e7zqnuo35@quack3>
 <20221111142742.rh677sdwu55aeeno@quack3>
 <20221114124147.GA30263@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221114124147.GA30263@willie-the-truck>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

How about this?

- The fast path is easy=E2=80=A6

- The slow path first sets the WAITER bits (mark_rt_mutex_waiters()) so
  I made that one _acquire so that it is visible by the unlocker forcing
  everyone into slow path.

- If the lock is acquired, then the owner is written via
  rt_mutex_set_owner(). This happens under wait_lock so it is
  serialized and so a WRITE_ONCE() is used to write the final owner. I
  replaced it with a cmpxchg_acquire() to have the owner there.
  Not sure if I shouldn't make this as you put it:
|   e.g. by making use of dependency ordering where it already exists.
  The other (locking) CPU needs to see the owner not only the WAITER
  bit. I'm not sure if this could be replaced with smp_store_release().

- After the whole operation completes, fixup_rt_mutex_waiters() cleans
  the WAITER bit and I kept the _acquire semantic here. Now looking at
  it again, I don't think that needs to be done since that shouldn't be
  set here.

- There is rtmutex_spin_on_owner() which (as the name implies) spins on
  the owner as long as it active. It obtains it via READ_ONCE() and I'm
  not sure if any memory barrier is needed. Worst case is that it will
  spin while owner isn't set if it observers a stale value.

- The unlock path first clears the waiter bit if there are no waiters
  recorded (via simple assignments under the wait_lock (every locker
  will fail with the cmpxchg_acquire() and go for the wait_lock)) and
  then finally drop it via rt_mutex_cmpxchg_release(,, NULL).
  Should there be a wait, it will just store the WAITER bit with
  smp_store_release() (setting the owner is NULL but the WAITER bit
  forces everyone into the slow path).

- Added rt_mutex_set_owner_pi() which does simple assignment. This is
  used from the futex code and here everything happens under a lock.

- I added a smp_load_acquire() to rt_mutex_base_is_locked() since I
  *think* want to observe a real waiter and not something stale.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/rtmutex.h      |  2 +-
 kernel/locking/rtmutex.c     | 26 ++++++++++++++++++--------
 kernel/locking/rtmutex_api.c |  4 ++--
 3 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/include/linux/rtmutex.h b/include/linux/rtmutex.h
index 7d049883a08ac..4447e01f723d4 100644
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -41,7 +41,7 @@ struct rt_mutex_base {
  */
 static inline bool rt_mutex_base_is_locked(struct rt_mutex_base *lock)
 {
-	return READ_ONCE(lock->owner) !=3D NULL;
+	return smp_load_acquire(&lock->owner) !=3D NULL;
 }
=20
 extern void rt_mutex_base_init(struct rt_mutex_base *rtb);
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 7779ee8abc2a0..e3cc673e0c988 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -97,7 +97,7 @@ rt_mutex_set_owner(struct rt_mutex_base *lock, struct tas=
k_struct *owner)
 	if (rt_mutex_has_waiters(lock))
 		val |=3D RT_MUTEX_HAS_WAITERS;
=20
-	WRITE_ONCE(lock->owner, (struct task_struct *)val);
+	WARN_ON_ONCE(cmpxchg_acquire(&lock->owner, RT_MUTEX_HAS_WAITERS, val) !=
=3D RT_MUTEX_HAS_WAITERS);
 }
=20
 static __always_inline void clear_rt_mutex_waiters(struct rt_mutex_base *l=
ock)
@@ -106,6 +106,17 @@ static __always_inline void clear_rt_mutex_waiters(str=
uct rt_mutex_base *lock)
 			((unsigned long)lock->owner & ~RT_MUTEX_HAS_WAITERS);
 }
=20
+static __always_inline void
+rt_mutex_set_owner_pi(struct rt_mutex_base *lock, struct task_struct *owne=
r)
+{
+	unsigned long val =3D (unsigned long)owner;
+
+	if (rt_mutex_has_waiters(lock))
+		val |=3D RT_MUTEX_HAS_WAITERS;
+
+	WRITE_ONCE(lock->owner, val);
+}
+
 static __always_inline void fixup_rt_mutex_waiters(struct rt_mutex_base *l=
ock)
 {
 	unsigned long owner, *p =3D (unsigned long *) &lock->owner;
@@ -173,7 +184,7 @@ static __always_inline void fixup_rt_mutex_waiters(stru=
ct rt_mutex_base *lock)
 	 */
 	owner =3D READ_ONCE(*p);
 	if (owner & RT_MUTEX_HAS_WAITERS)
-		WRITE_ONCE(*p, owner & ~RT_MUTEX_HAS_WAITERS);
+		cmpxchg_acquire(p, owner, owner & ~RT_MUTEX_HAS_WAITERS);
 }
=20
 /*
@@ -196,17 +207,16 @@ static __always_inline bool rt_mutex_cmpxchg_release(=
struct rt_mutex_base *lock,
 }
=20
 /*
- * Callers must hold the ->wait_lock -- which is the whole purpose as we f=
orce
- * all future threads that attempt to [Rmw] the lock to the slowpath. As s=
uch
- * relaxed semantics suffice.
+ * Callers hold the ->wait_lock. This needs to be visible to the lockowner,
+ * forcing him into the slow path for the unlock operation.
  */
 static __always_inline void mark_rt_mutex_waiters(struct rt_mutex_base *lo=
ck)
 {
 	unsigned long owner, *p =3D (unsigned long *) &lock->owner;
=20
 	do {
-		owner =3D *p;
-	} while (cmpxchg_relaxed(p, owner,
+		owner =3D READ_ONCE(*p);
+	} while (cmpxchg_acquire(p, owner,
 				 owner | RT_MUTEX_HAS_WAITERS) !=3D owner);
 }
=20
@@ -1218,7 +1228,7 @@ static void __sched mark_wakeup_next_waiter(struct rt=
_wake_q_head *wqh,
 	 * slow path making sure no task of lower priority than
 	 * the top waiter can steal this lock.
 	 */
-	lock->owner =3D (void *) RT_MUTEX_HAS_WAITERS;
+	smp_store_release(&lock->owner, (void *) RT_MUTEX_HAS_WAITERS);
=20
 	/*
 	 * We deboosted before waking the top waiter task such that we don't
diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
index 900220941caac..9acc176f93d38 100644
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -249,7 +249,7 @@ void __sched rt_mutex_init_proxy_locked(struct rt_mutex=
_base *lock,
 	 * recursion. Give the futex/rtmutex wait_lock a separate key.
 	 */
 	lockdep_set_class(&lock->wait_lock, &pi_futex_key);
-	rt_mutex_set_owner(lock, proxy_owner);
+	rt_mutex_set_owner_pi(lock, proxy_owner);
 }
=20
 /**
@@ -267,7 +267,7 @@ void __sched rt_mutex_init_proxy_locked(struct rt_mutex=
_base *lock,
 void __sched rt_mutex_proxy_unlock(struct rt_mutex_base *lock)
 {
 	debug_rt_mutex_proxy_unlock(lock);
-	rt_mutex_set_owner(lock, NULL);
+	rt_mutex_set_owner_pi(lock, NULL);
 }
=20
 /**
--=20
2.38.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B408713889
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 09:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjE1HxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 03:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjE1HxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 03:53:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9F5DC
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 00:52:59 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685260378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=dlHlM8aNFQK1QkzinbrlRhgbqs+nysl6PArvWVL7QTo=;
        b=qzD/x8nd/Ysk0iBuOFiOmksmZEK//dIe+yuU9aokOmhuDDwF53BlFdjGU96BLZjrrkEQKx
        FVIBodb108FGDz+s8GYaujLOgkZac3RTNltUrUlqcWjawYA8xBu+zY8KasVq+cNhGhM22C
        cq+7sIawstwRhQTzHX5dh2LcFvycvbK/cv0iqlBP+P6vQgrutEeSMadjqGiyzcFMHYG+95
        hrj9d9Gg5LdmtKS0nmAM8ZEzncnKRNNtkFVrfAWCrBOVPyHWWva9K5B3Gz8CRhUyseq3ub
        r6Xj/+7vDBB0qULTeqoNxDmd5Mmbb3TeHrkNHfKoIJA5fBGfpLhv5BDivbSUrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685260378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=dlHlM8aNFQK1QkzinbrlRhgbqs+nysl6PArvWVL7QTo=;
        b=b/lgVf0kLNp3ZCg0tfCcclUDkvH6nhXyUrDSJXfKUtCk/3ZCOfswwXE88ZX2eS5rxBIohv
        Hli6BVOq6qKxwtDA==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] core/debugobjects for 6.4-rc4
References: <168526035526.3457722.14103350194452732675.tglx@xen13>
Message-ID: <168526035687.3457722.2945763857032013034.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun, 28 May 2023 09:52:57 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest core/debugobjects branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-debugobject=
s-2023-05-28

up to:  eb799279fb1f: debugobjects: Don't wake up kswapd from fill_pool()


Two fixes for debugobjects:

  - Prevent that the allocation path wakes up kswapd. That's a long
    standing issue due to the GFP_ATOMIC allocation flag. As debug objects
    can be invoked from pretty much any context waking kswapd can end up
    in arbitrary lock chains versus the waitqueue lock.

  - Correct the explicit lockdep wait-type violation in
    debug_object_fill_pool().


Thanks,

	tglx

------------------>
Peter Zijlstra (1):
      debugobjects,locking: Annotate debug_object_fill_pool() wait type viola=
tion

Tetsuo Handa (1):
      debugobjects: Don't wake up kswapd from fill_pool()


 include/linux/lockdep.h       | 14 ++++++++++++++
 include/linux/lockdep_types.h |  1 +
 kernel/locking/lockdep.c      | 28 +++++++++++++++++++++-------
 lib/debugobjects.c            | 17 ++++++++++++++---
 4 files changed, 50 insertions(+), 10 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 1023f349af71..a3329fb49b33 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -339,6 +339,16 @@ extern void lock_unpin_lock(struct lockdep_map *lock, st=
ruct pin_cookie);
 #define lockdep_repin_lock(l,c)	lock_repin_lock(&(l)->dep_map, (c))
 #define lockdep_unpin_lock(l,c)	lock_unpin_lock(&(l)->dep_map, (c))
=20
+/*
+ * Must use lock_map_aquire_try() with override maps to avoid
+ * lockdep thinking they participate in the block chain.
+ */
+#define DEFINE_WAIT_OVERRIDE_MAP(_name, _wait_type)	\
+	struct lockdep_map _name =3D {			\
+		.name =3D #_name "-wait-type-override",	\
+		.wait_type_inner =3D _wait_type,		\
+		.lock_type =3D LD_LOCK_WAIT_OVERRIDE, }
+
 #else /* !CONFIG_LOCKDEP */
=20
 static inline void lockdep_init_task(struct task_struct *task)
@@ -427,6 +437,9 @@ extern int lockdep_is_held(const void *);
 #define lockdep_repin_lock(l, c)		do { (void)(l); (void)(c); } while (0)
 #define lockdep_unpin_lock(l, c)		do { (void)(l); (void)(c); } while (0)
=20
+#define DEFINE_WAIT_OVERRIDE_MAP(_name, _wait_type)	\
+	struct lockdep_map __maybe_unused _name =3D {}
+
 #endif /* !LOCKDEP */
=20
 enum xhlock_context_t {
@@ -551,6 +564,7 @@ do {									\
 #define rwsem_release(l, i)			lock_release(l, i)
=20
 #define lock_map_acquire(l)			lock_acquire_exclusive(l, 0, 0, NULL, _THIS_IP=
_)
+#define lock_map_acquire_try(l)			lock_acquire_exclusive(l, 0, 1, NULL, _THI=
S_IP_)
 #define lock_map_acquire_read(l)		lock_acquire_shared_recursive(l, 0, 0, NUL=
L, _THIS_IP_)
 #define lock_map_acquire_tryread(l)		lock_acquire_shared_recursive(l, 0, 1, =
NULL, _THIS_IP_)
 #define lock_map_release(l)			lock_release(l, _THIS_IP_)
diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
index d22430840b53..59f4fb1626ea 100644
--- a/include/linux/lockdep_types.h
+++ b/include/linux/lockdep_types.h
@@ -33,6 +33,7 @@ enum lockdep_wait_type {
 enum lockdep_lock_type {
 	LD_LOCK_NORMAL =3D 0,	/* normal, catch all */
 	LD_LOCK_PERCPU,		/* percpu */
+	LD_LOCK_WAIT_OVERRIDE,	/* annotation */
 	LD_LOCK_MAX,
 };
=20
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 50d4863974e7..62ef295e07e6 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2253,6 +2253,9 @@ static inline bool usage_match(struct lock_list *entry,=
 void *mask)
=20
 static inline bool usage_skip(struct lock_list *entry, void *mask)
 {
+	if (entry->class->lock_type =3D=3D LD_LOCK_NORMAL)
+		return false;
+
 	/*
 	 * Skip local_lock() for irq inversion detection.
 	 *
@@ -2279,14 +2282,16 @@ static inline bool usage_skip(struct lock_list *entry=
, void *mask)
 	 * As a result, we will skip local_lock(), when we search for irq
 	 * inversion bugs.
 	 */
-	if (entry->class->lock_type =3D=3D LD_LOCK_PERCPU) {
-		if (DEBUG_LOCKS_WARN_ON(entry->class->wait_type_inner < LD_WAIT_CONFIG))
-			return false;
+	if (entry->class->lock_type =3D=3D LD_LOCK_PERCPU &&
+	    DEBUG_LOCKS_WARN_ON(entry->class->wait_type_inner < LD_WAIT_CONFIG))
+		return false;
=20
-		return true;
-	}
+	/*
+	 * Skip WAIT_OVERRIDE for irq inversion detection -- it's not actually
+	 * a lock and only used to override the wait_type.
+	 */
=20
-	return false;
+	return true;
 }
=20
 /*
@@ -4752,7 +4757,8 @@ static int check_wait_context(struct task_struct *curr,=
 struct held_lock *next)
=20
 	for (; depth < curr->lockdep_depth; depth++) {
 		struct held_lock *prev =3D curr->held_locks + depth;
-		u8 prev_inner =3D hlock_class(prev)->wait_type_inner;
+		struct lock_class *class =3D hlock_class(prev);
+		u8 prev_inner =3D class->wait_type_inner;
=20
 		if (prev_inner) {
 			/*
@@ -4762,6 +4768,14 @@ static int check_wait_context(struct task_struct *curr=
, struct held_lock *next)
 			 * Also due to trylocks.
 			 */
 			curr_inner =3D min(curr_inner, prev_inner);
+
+			/*
+			 * Allow override for annotations -- this is typically
+			 * only valid/needed for code that only exists when
+			 * CONFIG_PREEMPT_RT=3Dn.
+			 */
+			if (unlikely(class->lock_type =3D=3D LD_LOCK_WAIT_OVERRIDE))
+				curr_inner =3D prev_inner;
 		}
 	}
=20
diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 003edc5ebd67..984985c39c9b 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -126,7 +126,7 @@ static const char *obj_states[ODEBUG_STATE_MAX] =3D {
=20
 static void fill_pool(void)
 {
-	gfp_t gfp =3D GFP_ATOMIC | __GFP_NORETRY | __GFP_NOWARN;
+	gfp_t gfp =3D __GFP_HIGH | __GFP_NOWARN;
 	struct debug_obj *obj;
 	unsigned long flags;
=20
@@ -591,10 +591,21 @@ static void debug_objects_fill_pool(void)
 {
 	/*
 	 * On RT enabled kernels the pool refill must happen in preemptible
-	 * context:
+	 * context -- for !RT kernels we rely on the fact that spinlock_t and
+	 * raw_spinlock_t are basically the same type and this lock-type
+	 * inversion works just fine.
 	 */
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible())
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible()) {
+		/*
+		 * Annotate away the spinlock_t inside raw_spinlock_t warning
+		 * by temporarily raising the wait-type to WAIT_SLEEP, matching
+		 * the preemptible() condition above.
+		 */
+		static DEFINE_WAIT_OVERRIDE_MAP(fill_pool_map, LD_WAIT_SLEEP);
+		lock_map_acquire_try(&fill_pool_map);
 		fill_pool();
+		lock_map_release(&fill_pool_map);
+	}
 }
=20
 static void


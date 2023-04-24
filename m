Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1CD6ED425
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 20:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbjDXSNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 14:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbjDXSN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 14:13:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3A849FF
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 11:13:25 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682360003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=K9W8NDx80UQqvWkG+atar6d9T4uMp1T5rDH7i9DlOhk=;
        b=qiVeV3A4OAwU/xPLlZC/66pUD4SIx2FYDMlcM0Wp3JwJNCAQwhyHXbTiGD99eO31OzYMGs
        It4ljeSJzIlLsI/kPeh/Nc92uGoOfNj2DT5eCRaKVUFVMljhsEftvikFFeSbkvLNKzx6C8
        9NQoa6gsKqAkrCiZtMQ1sttNosj02nOtmHRVN2iTmiTvpCiHWwFJ5KYnyKk7jXaCm2A9fq
        8Sb82q8xIiW+NEXFy0z80bMZ2p+cmkdGAwJA1mY7eb52gvQNjXmvIm+tGntv1sc7RuTyhg
        UpGZpCoVGaJS5r8cRAv/7MiprEsjn45hgdDJA4kL6oiFYWWJDF1Xy9Ciy2Pf1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682360003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=K9W8NDx80UQqvWkG+atar6d9T4uMp1T5rDH7i9DlOhk=;
        b=+HqOswjYocaiyCLvot1o/An5CP6/O+5EPKlFdWYR6FBzwYTda3FJ78S2aiqLGfarxguh3p
        mu5IuYbdZs8HzLAQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] core/debugobjects for 6.4-rc1
Message-ID: <168235968801.840202.17752066425816055574.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Mon, 24 Apr 2023 20:13:23 +0200 (CEST)
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
s-2023-04-24

up to:  63a759694eed: debugobject: Prevent init race with static objects


A single update to debugobjects:

  Prevent a race vs. statically initialized objects. Such objects are
  usually not initialized via an init() function. They are special cased
  and detected on first use under the assumption that they are already
  correctly initialized via the static initializer.

  This works correctly unless there are two concurrent debug object
  operations on such an object.

  The first one detects that the object is not yet tracked and tries to
  establish a tracking object after dropping the debug objects hash bucket
  lock. The concurrent operation does the same. The one which wins the
  race ends up modifying the state of the object which makes the other one
  fail resulting in a bogus debug objects warning.

  Prevent this by making the detection of a static object and the
  allocation of a tracking object atomic under the hash bucket lock. So the
  first one to acquire the hash bucket lock will succeed and the second one
  will observe the correct tracking state.

  This race existed forever but was only exposed when the timer wheel code
  added a debug_object_assert_init() call outside of the timer base locked
  region. This replaced the previous warning about timer::function being
  NULL which had to be removed when the timer_shutdown() mechanics were
  added.

Thanks,

	tglx

------------------>
Thomas Gleixner (1):
      debugobject: Prevent init race with static objects


 lib/debugobjects.c | 125 ++++++++++++++++++++++++++++-----------------------=
--
 1 file changed, 66 insertions(+), 59 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index df86e649d8be..b796799fadb2 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -216,10 +216,6 @@ static struct debug_obj *__alloc_object(struct hlist_hea=
d *list)
 	return obj;
 }
=20
-/*
- * Allocate a new object. If the pool is empty, switch off the debugger.
- * Must be called with interrupts disabled.
- */
 static struct debug_obj *
 alloc_object(void *addr, struct debug_bucket *b, const struct debug_obj_desc=
r *descr)
 {
@@ -552,11 +548,49 @@ static void debug_object_is_on_stack(void *addr, int on=
stack)
 	WARN_ON(1);
 }
=20
+static struct debug_obj *lookup_object_or_alloc(void *addr, struct debug_buc=
ket *b,
+						const struct debug_obj_descr *descr,
+						bool onstack, bool alloc_ifstatic)
+{
+	struct debug_obj *obj =3D lookup_object(addr, b);
+	enum debug_obj_state state =3D ODEBUG_STATE_NONE;
+
+	if (likely(obj))
+		return obj;
+
+	/*
+	 * debug_object_init() unconditionally allocates untracked
+	 * objects. It does not matter whether it is a static object or
+	 * not.
+	 *
+	 * debug_object_assert_init() and debug_object_activate() allow
+	 * allocation only if the descriptor callback confirms that the
+	 * object is static and considered initialized. For non-static
+	 * objects the allocation needs to be done from the fixup callback.
+	 */
+	if (unlikely(alloc_ifstatic)) {
+		if (!descr->is_static_object || !descr->is_static_object(addr))
+			return ERR_PTR(-ENOENT);
+		/* Statically allocated objects are considered initialized */
+		state =3D ODEBUG_STATE_INIT;
+	}
+
+	obj =3D alloc_object(addr, b, descr);
+	if (likely(obj)) {
+		obj->state =3D state;
+		debug_object_is_on_stack(addr, onstack);
+		return obj;
+	}
+
+	/* Out of memory. Do the cleanup outside of the locked region */
+	debug_objects_enabled =3D 0;
+	return NULL;
+}
+
 static void
 __debug_object_init(void *addr, const struct debug_obj_descr *descr, int ons=
tack)
 {
 	enum debug_obj_state state;
-	bool check_stack =3D false;
 	struct debug_bucket *db;
 	struct debug_obj *obj;
 	unsigned long flags;
@@ -572,16 +606,11 @@ __debug_object_init(void *addr, const struct debug_obj_=
descr *descr, int onstack
=20
 	raw_spin_lock_irqsave(&db->lock, flags);
=20
-	obj =3D lookup_object(addr, db);
-	if (!obj) {
-		obj =3D alloc_object(addr, db, descr);
-		if (!obj) {
-			debug_objects_enabled =3D 0;
-			raw_spin_unlock_irqrestore(&db->lock, flags);
-			debug_objects_oom();
-			return;
-		}
-		check_stack =3D true;
+	obj =3D lookup_object_or_alloc(addr, db, descr, onstack, false);
+	if (unlikely(!obj)) {
+		raw_spin_unlock_irqrestore(&db->lock, flags);
+		debug_objects_oom();
+		return;
 	}
=20
 	switch (obj->state) {
@@ -607,8 +636,6 @@ __debug_object_init(void *addr, const struct debug_obj_de=
scr *descr, int onstack
 	}
=20
 	raw_spin_unlock_irqrestore(&db->lock, flags);
-	if (check_stack)
-		debug_object_is_on_stack(addr, onstack);
 }
=20
 /**
@@ -648,14 +675,12 @@ EXPORT_SYMBOL_GPL(debug_object_init_on_stack);
  */
 int debug_object_activate(void *addr, const struct debug_obj_descr *descr)
 {
+	struct debug_obj o =3D { .object =3D addr, .state =3D ODEBUG_STATE_NOTAVAIL=
ABLE, .descr =3D descr };
 	enum debug_obj_state state;
 	struct debug_bucket *db;
 	struct debug_obj *obj;
 	unsigned long flags;
 	int ret;
-	struct debug_obj o =3D { .object =3D addr,
-			       .state =3D ODEBUG_STATE_NOTAVAILABLE,
-			       .descr =3D descr };
=20
 	if (!debug_objects_enabled)
 		return 0;
@@ -664,8 +689,8 @@ int debug_object_activate(void *addr, const struct debug_=
obj_descr *descr)
=20
 	raw_spin_lock_irqsave(&db->lock, flags);
=20
-	obj =3D lookup_object(addr, db);
-	if (obj) {
+	obj =3D lookup_object_or_alloc(addr, db, descr, false, true);
+	if (likely(!IS_ERR_OR_NULL(obj))) {
 		bool print_object =3D false;
=20
 		switch (obj->state) {
@@ -698,24 +723,16 @@ int debug_object_activate(void *addr, const struct debu=
g_obj_descr *descr)
=20
 	raw_spin_unlock_irqrestore(&db->lock, flags);
=20
-	/*
-	 * We are here when a static object is activated. We
-	 * let the type specific code confirm whether this is
-	 * true or not. if true, we just make sure that the
-	 * static object is tracked in the object tracker. If
-	 * not, this must be a bug, so we try to fix it up.
-	 */
-	if (descr->is_static_object && descr->is_static_object(addr)) {
-		/* track this static object */
-		debug_object_init(addr, descr);
-		debug_object_activate(addr, descr);
-	} else {
-		debug_print_object(&o, "activate");
-		ret =3D debug_object_fixup(descr->fixup_activate, addr,
-					ODEBUG_STATE_NOTAVAILABLE);
-		return ret ? 0 : -EINVAL;
+	/* If NULL the allocation has hit OOM */
+	if (!obj) {
+		debug_objects_oom();
+		return 0;
 	}
-	return 0;
+
+	/* Object is neither static nor tracked. It's not initialized */
+	debug_print_object(&o, "activate");
+	ret =3D debug_object_fixup(descr->fixup_activate, addr, ODEBUG_STATE_NOTAVA=
ILABLE);
+	return ret ? 0 : -EINVAL;
 }
 EXPORT_SYMBOL_GPL(debug_object_activate);
=20
@@ -869,6 +886,7 @@ EXPORT_SYMBOL_GPL(debug_object_free);
  */
 void debug_object_assert_init(void *addr, const struct debug_obj_descr *desc=
r)
 {
+	struct debug_obj o =3D { .object =3D addr, .state =3D ODEBUG_STATE_NOTAVAIL=
ABLE, .descr =3D descr };
 	struct debug_bucket *db;
 	struct debug_obj *obj;
 	unsigned long flags;
@@ -879,31 +897,20 @@ void debug_object_assert_init(void *addr, const struct =
debug_obj_descr *descr)
 	db =3D get_bucket((unsigned long) addr);
=20
 	raw_spin_lock_irqsave(&db->lock, flags);
+	obj =3D lookup_object_or_alloc(addr, db, descr, false, true);
+	raw_spin_unlock_irqrestore(&db->lock, flags);
+	if (likely(!IS_ERR_OR_NULL(obj)))
+		return;
=20
-	obj =3D lookup_object(addr, db);
+	/* If NULL the allocation has hit OOM */
 	if (!obj) {
-		struct debug_obj o =3D { .object =3D addr,
-				       .state =3D ODEBUG_STATE_NOTAVAILABLE,
-				       .descr =3D descr };
-
-		raw_spin_unlock_irqrestore(&db->lock, flags);
-		/*
-		 * Maybe the object is static, and we let the type specific
-		 * code confirm. Track this static object if true, else invoke
-		 * fixup.
-		 */
-		if (descr->is_static_object && descr->is_static_object(addr)) {
-			/* Track this static object */
-			debug_object_init(addr, descr);
-		} else {
-			debug_print_object(&o, "assert_init");
-			debug_object_fixup(descr->fixup_assert_init, addr,
-					   ODEBUG_STATE_NOTAVAILABLE);
-		}
+		debug_objects_oom();
 		return;
 	}
=20
-	raw_spin_unlock_irqrestore(&db->lock, flags);
+	/* Object is neither tracked nor static. It's not initialized. */
+	debug_print_object(&o, "assert_init");
+	debug_object_fixup(descr->fixup_assert_init, addr, ODEBUG_STATE_NOTAVAILABL=
E);
 }
 EXPORT_SYMBOL_GPL(debug_object_assert_init);
=20


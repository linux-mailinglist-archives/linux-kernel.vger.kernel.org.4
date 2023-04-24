Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A316A6E33CC
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 23:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjDOVUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 17:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjDOVUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 17:20:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B68F30D8;
        Sat, 15 Apr 2023 14:20:40 -0700 (PDT)
Date:   Sat, 15 Apr 2023 21:20:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681593639;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ttw0kx2CrcSGe97ojDoEphLovl3xz5yyNWjoNRDmQXA=;
        b=0XxCRvpcLuAy9kEZXinkwHcA0cuAR2eK/Q7FJDveus1EiYcJrQWgwNcLuu3qypo8OfbNiZ
        ii3zHDKLhq/KdtC6UFbLFPzCRcCaEY6g2Lbb55rsm5obFkybWOM/5zbchJCshAUDdEZ7sz
        pnNYhMBTiYEiuV5/XD+zO/fGxmkp2JQKiSYSmRl2uYyxyCJ+RXqfYYVlqZNcVE/5Tb4sik
        CCGkw7HASjPPcm1l3tEEQBqcsTinzIxc/mdydbD+NK2+mSXIGMTUme58Au1psqQPEiU1JS
        AmPPAvx+km/XS3sbFs3RM0blvrXkhI0YCkyfAtWWAtNJgYYaCZzYXczMkmAADQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681593639;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ttw0kx2CrcSGe97ojDoEphLovl3xz5yyNWjoNRDmQXA=;
        b=EBQsU8U2s/gRr+BTWHVFcDOIhSFhxyn85UCJCGBKXat05CtAPd5Ku/3PC7DeIQSlUZI0Q+
        pFDvGsux3FRNhpCQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/debugobjects] debugobject: Prevent init race with static objects
Cc:     syzbot+5093ba19745994288b53@syzkaller.appspotmail.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <swboyd@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230303161906.831686-1-schspa@gmail.com>
References: <20230303161906.831686-1-schspa@gmail.com>
MIME-Version: 1.0
Message-ID: <168159363802.404.11381407627405392907.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/debugobjects branch of tip:

Commit-ID:     63a759694eed61025713b3e14dd827c8548daadc
Gitweb:        https://git.kernel.org/tip/63a759694eed61025713b3e14dd827c8548daadc
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 12 Apr 2023 09:54:39 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 15 Apr 2023 23:13:36 +02:00

debugobject: Prevent init race with static objects

Statically initialized objects are usually not initialized via the init()
function of the subsystem. They are special cased and the subsystem
provides a function to validate whether an object which is not yet tracked
by debugobjects is statically initialized. This means the object is started
to be tracked on first use, e.g. activation.

This works perfectly fine, unless there are two concurrent operations on
that object. Schspa decoded the problem:

T0 	          	    	    T1

debug_object_assert_init(addr)
  lock_hash_bucket()
  obj = lookup_object(addr);
  if (!obj) {
  	unlock_hash_bucket();
	- > preemption
			            lock_subsytem_object(addr);
				      activate_object(addr)
				      lock_hash_bucket();
				      obj = lookup_object(addr);
				      if (!obj) {
				    	unlock_hash_bucket();
					if (is_static_object(addr))
					   init_and_track(addr);
				      lock_hash_bucket();
				      obj = lookup_object(addr);
				      obj->state = ACTIVATED;
				      unlock_hash_bucket();

				    subsys function modifies content of addr,
				    so static object detection does
				    not longer work.

				    unlock_subsytem_object(addr);
				    
        if (is_static_object(addr)) <- Fails

	  debugobject emits a warning and invokes the fixup function which
	  reinitializes the already active object in the worst case.

This race exists forever, but was never observed until mod_timer() got a
debug_object_assert_init() added which is outside of the timer base lock
held section right at the beginning of the function to cover the lockless
early exit points too.

Rework the code so that the lookup, the static object check and the
tracking object association happens atomically under the hash bucket
lock. This prevents the issue completely as all callers are serialized on
the hash bucket lock and therefore cannot observe inconsistent state.

Fixes: 3ac7fe5a4aab ("infrastructure to debug (dynamic) objects")
Reported-by: syzbot+5093ba19745994288b53@syzkaller.appspotmail.com
Debugged-by: Schspa Shi <schspa@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Link: https://syzkaller.appspot.com/bug?id=22c8a5938eab640d1c6bcc0e3dc7be519d878462
Link: https://lore.kernel.org/lkml/20230303161906.831686-1-schspa@gmail.com
Link: https://lore.kernel.org/r/87zg7dzgao.ffs@tglx

---
 lib/debugobjects.c | 125 +++++++++++++++++++++++---------------------
 1 file changed, 66 insertions(+), 59 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index df86e64..b796799 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -216,10 +216,6 @@ static struct debug_obj *__alloc_object(struct hlist_head *list)
 	return obj;
 }
 
-/*
- * Allocate a new object. If the pool is empty, switch off the debugger.
- * Must be called with interrupts disabled.
- */
 static struct debug_obj *
 alloc_object(void *addr, struct debug_bucket *b, const struct debug_obj_descr *descr)
 {
@@ -552,11 +548,49 @@ static void debug_object_is_on_stack(void *addr, int onstack)
 	WARN_ON(1);
 }
 
+static struct debug_obj *lookup_object_or_alloc(void *addr, struct debug_bucket *b,
+						const struct debug_obj_descr *descr,
+						bool onstack, bool alloc_ifstatic)
+{
+	struct debug_obj *obj = lookup_object(addr, b);
+	enum debug_obj_state state = ODEBUG_STATE_NONE;
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
+		state = ODEBUG_STATE_INIT;
+	}
+
+	obj = alloc_object(addr, b, descr);
+	if (likely(obj)) {
+		obj->state = state;
+		debug_object_is_on_stack(addr, onstack);
+		return obj;
+	}
+
+	/* Out of memory. Do the cleanup outside of the locked region */
+	debug_objects_enabled = 0;
+	return NULL;
+}
+
 static void
 __debug_object_init(void *addr, const struct debug_obj_descr *descr, int onstack)
 {
 	enum debug_obj_state state;
-	bool check_stack = false;
 	struct debug_bucket *db;
 	struct debug_obj *obj;
 	unsigned long flags;
@@ -572,16 +606,11 @@ __debug_object_init(void *addr, const struct debug_obj_descr *descr, int onstack
 
 	raw_spin_lock_irqsave(&db->lock, flags);
 
-	obj = lookup_object(addr, db);
-	if (!obj) {
-		obj = alloc_object(addr, db, descr);
-		if (!obj) {
-			debug_objects_enabled = 0;
-			raw_spin_unlock_irqrestore(&db->lock, flags);
-			debug_objects_oom();
-			return;
-		}
-		check_stack = true;
+	obj = lookup_object_or_alloc(addr, db, descr, onstack, false);
+	if (unlikely(!obj)) {
+		raw_spin_unlock_irqrestore(&db->lock, flags);
+		debug_objects_oom();
+		return;
 	}
 
 	switch (obj->state) {
@@ -607,8 +636,6 @@ __debug_object_init(void *addr, const struct debug_obj_descr *descr, int onstack
 	}
 
 	raw_spin_unlock_irqrestore(&db->lock, flags);
-	if (check_stack)
-		debug_object_is_on_stack(addr, onstack);
 }
 
 /**
@@ -648,14 +675,12 @@ EXPORT_SYMBOL_GPL(debug_object_init_on_stack);
  */
 int debug_object_activate(void *addr, const struct debug_obj_descr *descr)
 {
+	struct debug_obj o = { .object = addr, .state = ODEBUG_STATE_NOTAVAILABLE, .descr = descr };
 	enum debug_obj_state state;
 	struct debug_bucket *db;
 	struct debug_obj *obj;
 	unsigned long flags;
 	int ret;
-	struct debug_obj o = { .object = addr,
-			       .state = ODEBUG_STATE_NOTAVAILABLE,
-			       .descr = descr };
 
 	if (!debug_objects_enabled)
 		return 0;
@@ -664,8 +689,8 @@ int debug_object_activate(void *addr, const struct debug_obj_descr *descr)
 
 	raw_spin_lock_irqsave(&db->lock, flags);
 
-	obj = lookup_object(addr, db);
-	if (obj) {
+	obj = lookup_object_or_alloc(addr, db, descr, false, true);
+	if (likely(!IS_ERR_OR_NULL(obj))) {
 		bool print_object = false;
 
 		switch (obj->state) {
@@ -698,24 +723,16 @@ int debug_object_activate(void *addr, const struct debug_obj_descr *descr)
 
 	raw_spin_unlock_irqrestore(&db->lock, flags);
 
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
-		ret = debug_object_fixup(descr->fixup_activate, addr,
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
+	ret = debug_object_fixup(descr->fixup_activate, addr, ODEBUG_STATE_NOTAVAILABLE);
+	return ret ? 0 : -EINVAL;
 }
 EXPORT_SYMBOL_GPL(debug_object_activate);
 
@@ -869,6 +886,7 @@ EXPORT_SYMBOL_GPL(debug_object_free);
  */
 void debug_object_assert_init(void *addr, const struct debug_obj_descr *descr)
 {
+	struct debug_obj o = { .object = addr, .state = ODEBUG_STATE_NOTAVAILABLE, .descr = descr };
 	struct debug_bucket *db;
 	struct debug_obj *obj;
 	unsigned long flags;
@@ -879,31 +897,20 @@ void debug_object_assert_init(void *addr, const struct debug_obj_descr *descr)
 	db = get_bucket((unsigned long) addr);
 
 	raw_spin_lock_irqsave(&db->lock, flags);
+	obj = lookup_object_or_alloc(addr, db, descr, false, true);
+	raw_spin_unlock_irqrestore(&db->lock, flags);
+	if (likely(!IS_ERR_OR_NULL(obj)))
+		return;
 
-	obj = lookup_object(addr, db);
+	/* If NULL the allocation has hit OOM */
 	if (!obj) {
-		struct debug_obj o = { .object = addr,
-				       .state = ODEBUG_STATE_NOTAVAILABLE,
-				       .descr = descr };
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
 
-	raw_spin_unlock_irqrestore(&db->lock, flags);
+	/* Object is neither tracked nor static. It's not initialized. */
+	debug_print_object(&o, "assert_init");
+	debug_object_fixup(descr->fixup_assert_init, addr, ODEBUG_STATE_NOTAVAILABLE);
 }
 EXPORT_SYMBOL_GPL(debug_object_assert_init);
 

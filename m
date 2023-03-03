Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B62A6AA5C7
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 00:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjCCXrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 18:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCCXrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 18:47:13 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1658E16331
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 15:47:11 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677887226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f+PrsXHS0PJfVDOKqHsOimzzjJO2QhjbZhAceIgdF2Y=;
        b=j77vfNzHE0hGIUfmH1imt/4VKJugFGTYeo1n+Z8LjVMB6MCcVU8Lr3n7qCVLy4XJHNuqt5
        DdpYb+ExFPgmga80jLu6hwwSyMeJMzPShwfgKA/JFRi7eF/AL1lwrYr4g+1u5+LVk9RpzH
        HE58FFLF3N5eLGVQ7f2JdeHm+9tBVdiYl/rOaYzZ4b1YusFHO9fAgDhuM893Xio0sv+CbV
        cDZA0MqP8JbbZUPxPZLy/R9QrBufKucWaXadhct5/5vhf02GpMvOCHPV6yYxvf4PTxFVUU
        7lqGBUj8VjtDctUNSXe0FG0xYa7YylzAajjpNKxSKOq06xPtinHvAffTLiiVnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677887226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f+PrsXHS0PJfVDOKqHsOimzzjJO2QhjbZhAceIgdF2Y=;
        b=zGxW2t8Si81JVfKXi7dP25kRB1JRGVx03llHv2Ba9G7DPYeaCFvl1vX/hBKHWi/59SvYnR
        jRs5n6N4WYUCn+BA==
To:     Schspa Shi <schspa@gmail.com>, longman@redhat.com,
        swboyd@chromium.org, linux@roeck-us.net, wuchi.zero@gmail.com
Cc:     linux-kernel@vger.kernel.org, Schspa Shi <schspa@gmail.com>,
        syzbot+5093ba19745994288b53@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] debugobject: fix concurrency issues with
 is_static_object
In-Reply-To: <20230303161906.831686-1-schspa@gmail.com>
References: <20230303161906.831686-1-schspa@gmail.com>
Date:   Sat, 04 Mar 2023 00:47:05 +0100
Message-ID: <87bkl9jt3a.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Sat, Mar 04 2023 at 00:19, Schspa Shi wrote:

> The is_static_object implementation relay on the initial state of the
> object. If multiple places are accessed concurrently, there is a
> probability that the debug object has been registered in the system, which
> will invalidate the judgment of is_static_object.
>
> The following is the scenario where the problem occurs:
>
> T0                                                   T1
> =========================================================================
> mod_timer();
>   debug_object_assert_init
> 	db = get_bucket((unsigned long) addr);
> 	raw_spin_lock_irqsave(&db->lock, flags);
> 	obj = lookup_object(addr, db);
>     if (!obj) {
> 		raw_spin_unlock_irqrestore(&db->lock, flags);
>         << Context switch >>
>                                              mod_timer();
>                                                debug_object_assert_init
>                                                ...
>                                                enqueue_timer();
>         /*
>          * The initial state changed a static timer object, and
>          * is_static_object will return false
>          */
>
>         if (descr->is_static_object &&
> 			descr->is_static_object(addr)) {
>                 debug_object_init();
>             } else {
>                << Hit here for a static object >>
> 			   debug_print_object(&o, "assert_init");
> 			   debug_object_fixup(descr->fixup_assert_init, addr,
> 					   ODEBUG_STATE_NOTAVAILABLE);
>             }
>     }

That analysis is correct.

> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
> index df86e649d8be0..d1be18158a1f7 100644
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -275,6 +275,8 @@ alloc_object(void *addr, struct debug_bucket *b, const struct debug_obj_descr *d
>  		obj->descr  = descr;
>  		obj->state  = ODEBUG_STATE_NONE;
>  		obj->astate = 0;
> +		obj->is_static = descr->is_static_object &&
> +			descr->is_static_object(addr);
>  		hlist_add_head(&obj->node, &b->list);
>  	}
>  	return obj;
> @@ -581,7 +583,16 @@ __debug_object_init(void *addr, const struct debug_obj_descr *descr, int onstack
>  			debug_objects_oom();
>  			return;
>  		}
> +
>  		check_stack = true;
> +	} else {
> +		/*
> +		 * The debug object is inited, and we should check this again
> +		 */
> +		if (obj->is_static) {
> +			raw_spin_unlock_irqrestore(&db->lock, flags);
> +			return;

This is broken. If the object is static and already hashed and in active
state then this returns and fails to detect the re-initialization of an
active object.

> +/*
> + * Check static object.
> + */
> +static bool debug_object_check_static(struct debug_bucket *db, void *addr,
> +			const struct debug_obj_descr *descr)
> +{
> +	struct debug_obj *obj;
> +
> +	/*
> +	 * The is_static_object implementation relay on the initial state of the
> +	 * object. If multiple places are accessed concurrently, there is a
> +	 * probability that the debug object has been registered in the system,
> +	 * which will invalidate the judgment of is_static_object.
> +	 */
> +	lockdep_assert_held(&db->lock);
> +
> +	obj = lookup_object(addr, db);

What does this lookup solve? See below...

> +	if (likely(obj))
> +		return obj->is_static;
> +
> +	return descr->is_static_object && descr->is_static_object(addr);
> +}

> @@ -696,6 +731,7 @@ int debug_object_activate(void *addr, const struct debug_obj_descr *descr)
>  		return ret;
>  	}
>  
> +	is_static = debug_object_check_static(db, addr, descr);

It's already clear that the object is not hashed because activate does:

        lock()
        lookup()
        if (ob) {
           ....
           unlock();
        }

At this point nothing has changed after the lookup because
the hash bucket is still locked.

>  	raw_spin_unlock_irqrestore(&db->lock, flags);
 
>  	/*
> @@ -705,7 +741,7 @@ int debug_object_activate(void *addr, const struct debug_obj_descr *descr)
>  	 * static object is tracked in the object tracker. If
>  	 * not, this must be a bug, so we try to fix it up.
>  	 */
> -	if (descr->is_static_object && descr->is_static_object(addr)) {
> +	if (is_static) {
>  		/* track this static object */
>  		debug_object_init(addr, descr);

This cannot work as the change in debug_object_init() is not correct and
there is no way to make it correct.

> -static __initdata struct self_test obj = { .static_init = 0 };
> +static struct self_test obj __initdata = { .static_init = 0 };
> +static struct self_test sobj __initdata = { .static_init = 1 };

...

> -	obj.static_init = 1;

Plus the s/obj/sobj/ which should be equivalent, unless I'm missing
something here.

But that also changes the actual test:

-	obj.static_init = 1;
-	debug_object_activate(&obj, &descr_type_test);
-	if (check_results(&obj, ODEBUG_STATE_ACTIVE, fixups, warnings))
+	debug_object_init(&sobj, &descr_type_test);
+	debug_object_activate(&sobj, &descr_type_test);
+	if (check_results(&sobj, ODEBUG_STATE_ACTIVE, fixups, warnings))
		goto out;

That's _not_ equivalent.

The original code checks exactly for the case where the object
initialization does not happen before debug_object_activate() is invoked
which is perfectly correct for statically initialized
objects. Initializing the statically allocated object breaks that
test. The changelog is utterly silent about that.

The proper fix for this is obvious from the analysis. The problem
happens because the failed lookup drops the hash bucket lock which opens
the window for the concurrent caller. So why dropping the hash bucket
lock at all?

Uncompiled and untested fix below.

Thanks,

        tglx
---
 lib/debugobjects.c |  127 +++++++++++++++++++++++++++--------------------------
 1 file changed, 67 insertions(+), 60 deletions(-)

--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -216,10 +216,6 @@ static struct debug_obj *__alloc_object(
 	return obj;
 }
 
-/*
- * Allocate a new object. If the pool is empty, switch off the debugger.
- * Must be called with interrupts disabled.
- */
 static struct debug_obj *
 alloc_object(void *addr, struct debug_bucket *b, const struct debug_obj_descr *descr)
 {
@@ -273,7 +269,7 @@ alloc_object(void *addr, struct debug_bu
 	if (obj) {
 		obj->object = addr;
 		obj->descr  = descr;
-		obj->state  = ODEBUG_STATE_NONE;
+		obj->state  = ODEBUG_STATE_INIT;
 		obj->astate = 0;
 		hlist_add_head(&obj->node, &b->list);
 	}
@@ -552,11 +548,49 @@ static void debug_object_is_on_stack(voi
 	WARN_ON(1);
 }
 
+static struct debug_obj *lookup_object_or_alloc(void *addr, struct debug_bucket *b,
+						const struct debug_obj_descr *descr,
+						bool onstack, bool alloc_ifstatic)
+{
+	struct debug_obj *obj = lookup_object(addr, b);
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
+	}
+
+	/*
+	 * On success the returned object is in INIT state as that's the
+	 * correct state for all callers.
+	 */
+	obj = alloc_object(addr, b, descr);
+	if (likely(obj)) {
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
@@ -572,16 +606,11 @@ static void
 
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
@@ -607,8 +636,6 @@ static void
 	}
 
 	raw_spin_unlock_irqrestore(&db->lock, flags);
-	if (check_stack)
-		debug_object_is_on_stack(addr, onstack);
 }
 
 /**
@@ -648,14 +675,12 @@ EXPORT_SYMBOL_GPL(debug_object_init_on_s
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
@@ -664,8 +689,8 @@ int debug_object_activate(void *addr, co
 
 	raw_spin_lock_irqsave(&db->lock, flags);
 
-	obj = lookup_object(addr, db);
-	if (obj) {
+	obj = lookup_object_or_alloc(addr, db, descr, false, true);
+	if (likely(!IS_ERR_OR_NULL(obj))) {
 		bool print_object = false;
 
 		switch (obj->state) {
@@ -698,24 +723,16 @@ int debug_object_activate(void *addr, co
 
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
+	/* If NULL the allocaction has hit OOM */
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
@@ -879,31 +897,20 @@ void debug_object_assert_init(void *addr
 	db = get_bucket((unsigned long) addr);
 
 	raw_spin_lock_irqsave(&db->lock, flags);
+	obj = lookup_object_or_alloc(addr, db, descr, false, true);
+	raw_spin_unlock_irqrestore(&db->lock, flags);
+	if (likely(!IS_ERR_OR_NULL(obj)))
+		return;
 
-	obj = lookup_object(addr, db);
+	/* If NULL the allocaction has hit OOM */
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
 



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1994F725002
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 00:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238678AbjFFWhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 18:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239999AbjFFWhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 18:37:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01E71FDD
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 15:36:03 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686090942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zt0kqscp3g8VO9/il4J06xJrTrfCXuchslOey9lexZk=;
        b=vp9dpQ7rR6TmmUIqw15AI4EY0D/Q2WCqeUi99v8LeIYxj6eceBxNl4nDx9CQL2RptmSJE/
        3r4vyJubo625m06Hd3w4YHeDYX8/oOCZ5WdYB1L9COUn1V1exupXWV3klngBpSmlr+xYKv
        pTVfvIwGTZJ2bcbWMBQIOcnu/ALYuj7NrRfkLxaMYpnyp59MWeKnrnMDZLujL5MA3JBdDn
        6LyuifR5rAkSD5bSFofZahXsLkze2x5+LeWWO0gq2obAkaElJUMOI6Vn7CDBtlJHyqlyHg
        GXG+lgHBXMy1oH2wkUgl6NF6hNRxgfXpIh/eG+jv0hg73+A0gksuiOVh7nluKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686090942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zt0kqscp3g8VO9/il4J06xJrTrfCXuchslOey9lexZk=;
        b=jgdK0R2MYIB1NdkAJdO21+gMIOKePzqXnUCGwxv+WpgT61LH86Utm7BeqMYoTQm7PhT4/u
        r0+X1OWUfhkCCDBQ==
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        syzbot <syzbot+7937ba6a50bdd00fffdf@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
Cc:     linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        wuchi <wuchi.zero@gmail.com>
Subject: Re: [PATCH] debugobjects: turn off debug_objects_enabled from
 debug_objects_oom()
In-Reply-To: <1af29817-4698-c5ac-cf63-0dad289e740f@I-love.SAKURA.ne.jp>
References: <0000000000003a2f8505fcd5f06b@google.com>
 <1af29817-4698-c5ac-cf63-0dad289e740f@I-love.SAKURA.ne.jp>
Date:   Wed, 07 Jun 2023 00:35:41 +0200
Message-ID: <871qiokyma.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tetsuo!

On Mon, May 29 2023 at 23:39, Tetsuo Handa wrote:
> syzbot is reporting false positive ODEBUG message immediately after
> ODEBUG was disabled due to OOM.
>
>   [ 1062.309646][T22911] ODEBUG: Out of memory. ODEBUG disabled
>   [ 1062.886755][ T5171] ------------[ cut here ]------------
>   [ 1062.892770][ T5171] ODEBUG: assert_init not available (active state 0) object: ffffc900056afb20 object type: timer_list hint: process_timeout+0x0/0x40
>
> This race happened because debug_objects_oom() emitted OOM message but did
> not turn off debug_objects_enabled, and debug_print_object() did not check
> debug_objects_enabled when calling WARN().
>
>   CPU 0 [ T5171]                CPU 1 [T22911]
>   --------------                --------------
>   debug_object_assert_init() {
>     if (!debug_objects_enabled)
>       return;
>     db = get_bucket((unsigned long) addr); // Finds a bucket, but...
>                                 debug_objects_oom() {
>                                   pr_warn("Out of memory. ODEBUG disabled\n");
>                                   // all buckets get emptied here, and...
>                                   hlist_move_list(&db->list, &freelist);
>                                 }
>     lookup_object_or_alloc(addr, db, descr, false, true) {
>       lookup_object(addr, b) {
>         return NULL; // this bucket is already empty.
>       }
>       if (!descr->is_static_object || !descr->is_static_object(addr))
>         return ERR_PTR(-ENOENT);
>     }
>     if (!obj) { // obj == ERR_PTR(-ENOENT) because non-static object.
>        debug_objects_oom();
>        return;
>     }
>     debug_print_object(&o, "assert_init") {
>       // False positive due to not checking debug_objects_enabled.
>       WARN(1, KERN_ERR "ODEBUG: %s %s (active state %u) "
>            "object: %p object type: %s hint: %pS\n", ...);
>     }
>   }

The above is undecodable gibberish.

Something like this is completely sufficient:

  CPU 0 [ T5171]			CPU 1 [T22911]
  --------------                	--------------
  debug_object_assert_init() {
    db = get_bucket(addr);
					debug_objects_oom() {
                                  	  pr_warn("Out of memory. ODEBUG disabled\n");
                                  	  // all buckets get emptied here
                                	}
    lookup_object_or_alloc(addr, db, ...)
      // Due to OOM:
      return ERR_PTR(-ENOENT);
    ...

    // Emits assert_init message and warning
    debug_print_object(&o, "assert_init");
  }

And this:

> This race happened because debug_objects_oom() emitted OOM message but did
> not turn off debug_objects_enabled

is completely wrong. Why?

The place where debug_objects_enabled is set to 0 is way before
debug_objects_oom() is invoked. That place _cannot_ invoke
debug_objects_oom() because it holds a hash bucket lock.

There are exactly three places which invoke debug_objects_oom() and for
all three places the pattern is exactly the same:

      lock_bucket();
      obj = lookup_object_or_alloc();
      unlock_bucket();
      if (!obj)
         debug_objects_oom();

The place which clears debug_objects_enabled is unsurprisingly
lookup_object_or_alloc() itself, which _cannot_ invoke
debug_objects_oom() because it is invoked with the hash bucket lock
held. There is even a comment to that effect:

	/* Out of memory. Do the cleanup outside of the locked region */
	debug_objects_enabled = 0;
	return NULL;

So at the point where debug_objects_oom() is invoked
@debug_objects_enabled is already 0.

But you claim that this is required, right?

> @@ -466,6 +466,7 @@ static void debug_objects_oom(void)
>  	unsigned long flags;
>  	int i;
>  
> +	debug_objects_enabled = 0;
>  	pr_warn("Out of memory. ODEBUG disabled\n");

Q: What is setting a variable which is already 0 to 0 solving?
A: Absolutely nothing

Now this:

> @@ -502,10 +503,10 @@ static void debug_print_object(struct de
>  		void *hint = descr->debug_hint ?
>  			descr->debug_hint(obj->object) : NULL;
>  		limit++;
> -		WARN(1, KERN_ERR "ODEBUG: %s %s (active state %u) "
> -				 "object: %p object type: %s hint: %pS\n",
> -			msg, obj_states[obj->state], obj->astate,
> -			obj->object, descr->name, hint);
> +		WARN(debug_objects_enabled, KERN_ERR
> +		     "ODEBUG: %s %s (active state %u) object: %p object type: %s hint: %pS\n",
> +		     msg, obj_states[obj->state], obj->astate,
> +		     obj->object, descr->name, hint);
>  	}

Q: Why is this related to the WARN() itself?
A: It's not related at all

The obvious fix is:

--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -498,6 +498,14 @@ static void debug_print_object(struct de
 	const struct debug_obj_descr *descr = obj->descr;
 	static int limit;
 
+	/*
+	 * OOM handling is asynchronous for performance reasons. So the
+	 * call site might have raced with a concurrent OOM which cleared
+	 * the hash buckets.
+	 */
+	if (!debug_objects_enabled)
+		return;
+
 	if (limit < 5 && descr != descr_test) {
 		void *hint = descr->debug_hint ?
 			descr->debug_hint(obj->object) : NULL;

Along with a understandable changelog, no?

Thanks,

        tglx

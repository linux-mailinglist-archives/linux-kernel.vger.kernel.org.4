Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8202B700707
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 13:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240752AbjELLl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 07:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240347AbjELLlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 07:41:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31AA2D79
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 04:41:49 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683891707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vh4mf+6XvE01/xi5nbRPXfvlLQKyTyG19ry3bWvjBWI=;
        b=21Y1zOgJND/IAJMsVyekH+0yLUl/Yw5GHK6EUfFibovYX0DMfxRqiLfkNljtAUCKC9/dyg
        qpXYJn50RJjwQbkauJh+8ZJQCvpHUzpkmouMNE6+BimYnFxTJMyMFI7qKFshwtQkt95D/v
        RcDK8rM8WvVgbrn3jghG0GlP15q5IDtXE1y3mrkn/vKvNek9xcTzi9B7h6uJjb71MjDGv6
        a/IHQreIPu9UkOdwK3E8o11Y1Rk9GDHRoJS0jdxOUWneHQ+ElKrxZt4FZ2Jh2MHlHcaCI4
        hbCHlT4OTDZIXbY7Exi4O1THDHvcBuHyO9pkx7GUenE7EWWn69sfGnlQ8axfBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683891707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vh4mf+6XvE01/xi5nbRPXfvlLQKyTyG19ry3bWvjBWI=;
        b=ZsQ2Q/1JJ/NdfW/e+kLKlhNOT6RLjW8odnSLbJwOzrJ6juYIlpocvtMy569ZmAA5m0XzOP
        H/+Yt3/N/dsBkaAg==
To:     syzbot <syzbot+3384541342de0ca933f1@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Cc:     Ido Schimmel <idosch@nvidia.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [syzbot] [kernel?] possible deadlock in __hrtimer_run_queues
In-Reply-To: <00000000000026b68305fb78c24d@google.com>
References: <00000000000026b68305fb78c24d@google.com>
Date:   Fri, 12 May 2023 13:41:47 +0200
Message-ID: <871qjldbes.ffs@tglx>
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

On Thu, May 11 2023 at 22:55, syzbot wrote:
> HEAD commit:    1dc3731daf1f Merge tag 'for-6.4-rc1-tag' of git://git.kern..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14ebdafa280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8bc832f563d8bf38
> dashboard link: https://syzkaller.appspot.com/bug?extid=3384541342de0ca933f1
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: i386
>
> Unfortunately, I don't have any reproducer for this issue yet.

No problem. The lockdep splat is enough data.

Fix below.

Thanks,

        tglx

---

Subject: debugobjects: Prevent pool refill deadlock
From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 12 May 2023 12:23:17 +0200

The unconditional pool refill in debug_objects_activate() and
debug_objects_assert_init() can result in a dead lock when invoked from
the hrtimer [soft]interrupt:

Chain exists of:
  &pgdat->kswapd_wait --> &rt_b->rt_runtime_lock --> hrtimer_bases.lock

 Possible unsafe locking scenario:
       CPU0                    CPU1
       ----                    ----
  lock(hrtimer_bases.lock);
			       lock(&rt_b->rt_runtime_lock);
			       lock(hrtimer_bases.lock);
  lock(&pgdat->kswapd_wait);

 *** DEADLOCK ***

This went unnoticed in testing as the test system never tried to wake up
the kswapd_wait queue.

The original behaviour before commit 63a759694eed ("debugobject: Prevent
init race with static objects") was that the pool refill only happened when
the tracking object lookup failed.

Restore this behaviour by trying a lookup first and only if that fails to
invoke pool refill and then do the lookup_or_alloc().

That does not reintroduce the init race problem because lookup_or_alloc()
is still an atomic operation protected by the hash bucket lock and only one
context can do the static object stack and tracking object association and
the other one will observe the tracking object.

Fixes: 0af462f19e63 ("debugobject: Ensure pool refill (again)")
Reported-by: syzbot+3384541342de0ca933f1@syzkaller.appspotmail.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 lib/debugobjects.c |   43 +++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -124,7 +124,7 @@ static const char *obj_states[ODEBUG_STA
 	[ODEBUG_STATE_NOTAVAILABLE]	= "not available",
 };
 
-static void fill_pool(void)
+static void debug_objects_fill_pool(void)
 {
 	gfp_t gfp = GFP_ATOMIC | __GFP_NORETRY | __GFP_NOWARN;
 	struct debug_obj *obj;
@@ -157,6 +157,13 @@ static void fill_pool(void)
 		raw_spin_unlock_irqrestore(&pool_lock, flags);
 	}
 
+	/*
+	 * On RT enabled kernels the pool refill must happen in preemptible
+	 * context:
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !preemptible())
+		return;
+
 	if (unlikely(!obj_cache))
 		return;
 
@@ -587,16 +594,6 @@ static struct debug_obj *lookup_object_o
 	return NULL;
 }
 
-static void debug_objects_fill_pool(void)
-{
-	/*
-	 * On RT enabled kernels the pool refill must happen in preemptible
-	 * context:
-	 */
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible())
-		fill_pool();
-}
-
 static void
 __debug_object_init(void *addr, const struct debug_obj_descr *descr, int onstack)
 {
@@ -690,13 +687,16 @@ int debug_object_activate(void *addr, co
 	if (!debug_objects_enabled)
 		return 0;
 
-	debug_objects_fill_pool();
-
 	db = get_bucket((unsigned long) addr);
-
 	raw_spin_lock_irqsave(&db->lock, flags);
+	obj = lookup_object(addr, db);
+	if (!obj) {
+		raw_spin_unlock_irqrestore(&db->lock, flags);
+		debug_objects_fill_pool();
+		raw_spin_lock_irqsave(&db->lock, flags);
+		obj = lookup_object_or_alloc(addr, db, descr, false, true);
+	}
 
-	obj = lookup_object_or_alloc(addr, db, descr, false, true);
 	if (likely(!IS_ERR_OR_NULL(obj))) {
 		bool print_object = false;
 
@@ -901,13 +901,16 @@ void debug_object_assert_init(void *addr
 	if (!debug_objects_enabled)
 		return;
 
-	debug_objects_fill_pool();
-
 	db = get_bucket((unsigned long) addr);
-
 	raw_spin_lock_irqsave(&db->lock, flags);
-	obj = lookup_object_or_alloc(addr, db, descr, false, true);
-	raw_spin_unlock_irqrestore(&db->lock, flags);
+	obj = lookup_object(addr, db);
+	if (!obj) {
+		raw_spin_unlock_irqrestore(&db->lock, flags);
+		debug_objects_fill_pool();
+		raw_spin_lock_irqsave(&db->lock, flags);
+		obj = lookup_object_or_alloc(addr, db, descr, false, true);
+	}
+
 	if (likely(!IS_ERR_OR_NULL(obj)))
 		return;
 

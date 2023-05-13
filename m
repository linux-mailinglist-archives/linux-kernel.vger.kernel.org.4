Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC69A701987
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 21:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbjEMTeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 15:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233804AbjEMTeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 15:34:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCF43AAE
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 12:34:15 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684006453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FRJAdQfSJl14BbyOaT4G3/hWq1xYQEBEbVi1WZwPfAA=;
        b=oodjUBRYhQ4Sr6ntQ/+hJQNIK5iKStrGgZHemRQ6OtOvoHdaynytszkFYlJK5ylHkLB1OA
        G0aQ+vd25ECoSdGPpgWvoeZcenm3ldvf0jmrieV7xDZ9VPKmCTduaNp/Ctwvo2nIP8EaFX
        7dJw0OwbIgOngH8FOl6PqZdscC5oMj0TKFUYV3MWhj3VgxkvD78L8oPRH9QWQjwQRtq/di
        ax7NaeZkmrpSUMAj8yFHsqcwMm2A/qpHaLkoKd1L64TcoetR09qRaZVOm7hwqaEg3ZEIn+
        5atOHBoQzs9xfNfkk5eto6kcbk8fJ3knJh9ym6vWVSf+/LPQxWB4cw4Gmf+eaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684006453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FRJAdQfSJl14BbyOaT4G3/hWq1xYQEBEbVi1WZwPfAA=;
        b=w/JX4RSWLIufLTIMepaSNIqHYwISqwOp25Qj+HXexDfZ573AzTH9VMmD6u3H0HdU9H9fJs
        VlWnNiDyhhhGzSCA==
To:     Ido Schimmel <idosch@nvidia.com>
Cc:     syzbot <syzbot+3384541342de0ca933f1@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [syzbot] [kernel?] possible deadlock in __hrtimer_run_queues
In-Reply-To: <ZF9aWEeQ5+Xvc+oF@shredder>
References: <00000000000026b68305fb78c24d@google.com> <871qjldbes.ffs@tglx>
 <ZF9aWEeQ5+Xvc+oF@shredder>
Date:   Sat, 13 May 2023 21:34:12 +0200
Message-ID: <87ilcw9gaz.ffs@tglx>
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

Ido!

On Sat, May 13 2023 at 12:37, Ido Schimmel wrote:
> Thomas, I applied the fix on top of net-next (which includes
> 0af462f19e63). I'm getting the splat below during boot and then the
> systems hangs.

Because I'm a moron. I got the same splat while testing, fixed it on the
test machine and then did not sync it back before sending...

Updated fix which also replaces GFP_ATOMIC with __GFP_HIGH to prevent
the allocator to wake up the swap daemons, which causes yet another lock
inversion issue.

Thanks for testing!

        tglx
---
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -124,9 +124,9 @@ static const char *obj_states[ODEBUG_STA
 	[ODEBUG_STATE_NOTAVAILABLE]	= "not available",
 };
 
-static void fill_pool(void)
+static void debug_objects_fill_pool(void)
 {
-	gfp_t gfp = GFP_ATOMIC | __GFP_NORETRY | __GFP_NOWARN;
+	gfp_t gfp = __GFP_HIGH | __GFP_NORETRY | __GFP_NOWARN;
 	struct debug_obj *obj;
 	unsigned long flags;
 
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
 
@@ -901,13 +901,17 @@ void debug_object_assert_init(void *addr
 	if (!debug_objects_enabled)
 		return;
 
-	debug_objects_fill_pool();
-
 	db = get_bucket((unsigned long) addr);
-
 	raw_spin_lock_irqsave(&db->lock, flags);
-	obj = lookup_object_or_alloc(addr, db, descr, false, true);
+	obj = lookup_object(addr, db);
+	if (!obj) {
+		raw_spin_unlock_irqrestore(&db->lock, flags);
+		debug_objects_fill_pool();
+		raw_spin_lock_irqsave(&db->lock, flags);
+		obj = lookup_object_or_alloc(addr, db, descr, false, true);
+	}
 	raw_spin_unlock_irqrestore(&db->lock, flags);
+
 	if (likely(!IS_ERR_OR_NULL(obj)))
 		return;
 

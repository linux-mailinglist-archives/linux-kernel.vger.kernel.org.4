Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D017A6F330D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 17:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbjEAPm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 11:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbjEAPmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 11:42:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694A31721
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 08:42:10 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682955727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U/FJYSgjlm7VHaefogzXEStnuvTl/3xcpot6vka0Nn0=;
        b=Bn+WMABl52/foiExhnB2D/HTFLvYKrLg4LAKIS1O3oIqiPeKTt2I/7N1GjKX0H6fA4evtg
        L4c94kYgC2W9u2fxkLrFW2xbrwT+49eSaf4/SiwelqaC9PweW7viKsenh8/uA7Gq/jrH82
        oODitqD/mVo3dlJBxMiFv8p4kX+VI23DexEEv1O4NbFvzsxsLcT4gmjxdWRAAlhuc2m8xD
        Kx2GDifz/tXcwMTRZ7Bb5ukTsKkvFzWM2tqZvh2mU+l605JB7JzBvRUhqY6hH9Kturhl5d
        22jE30mntIemaI0hdU/i6L2I3K65tN4DjDMt7DqsxxGDmM9Ud/MMBuAZRNVpZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682955727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U/FJYSgjlm7VHaefogzXEStnuvTl/3xcpot6vka0Nn0=;
        b=E+RCS09/5UdCmVzbxszZCBRUuEl7KzUviu3WdGMyzwBZDp5vDZcgpiqX+ppjBl6cmF7n5z
        YxTCidry7ZlIqvAA==
To:     Ido Schimmel <idosch@idosch.org>
Cc:     Schspa Shi <schspa@gmail.com>, longman@redhat.com,
        swboyd@chromium.org, linux@roeck-us.net, wuchi.zero@gmail.com,
        linux-kernel@vger.kernel.org,
        syzbot+5093ba19745994288b53@syzkaller.appspotmail.com,
        danieller@nvidia.com, petrm@nvidia.com
Subject: Re: [PATCH] debugobject: Prevent init race with static objects
In-Reply-To: <ZE/BQ5yUQZUwhlTu@shredder>
References: <20230303161906.831686-1-schspa@gmail.com> <87bkl9jt3a.ffs@tglx>
 <m2ttycd8kx.fsf@gmail.com> <87sfdw8yru.ffs@tglx> <87pm908xvu.ffs@tglx>
 <87zg7dzgao.ffs@tglx> <ZE/BQ5yUQZUwhlTu@shredder>
Date:   Mon, 01 May 2023 17:42:06 +0200
Message-ID: <871qk05a9d.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ido!

On Mon, May 01 2023 at 16:40, Ido Schimmel wrote:
> On Wed, Apr 12, 2023 at 09:54:39AM +0200, Thomas Gleixner wrote:
> With this patch we see the following warning in the kernel log during
> boot:
>
> "ODEBUG: Out of memory. ODEBUG disabled"
...

> The following diff seems to solve the problem for me:
>
> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
> index b796799fadb2..af4bd66c571c 100644
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -21,7 +21,7 @@
>  #define ODEBUG_HASH_BITS       14
>  #define ODEBUG_HASH_SIZE       (1 << ODEBUG_HASH_BITS)
>  
> -#define ODEBUG_POOL_SIZE       1024
> +#define ODEBUG_POOL_SIZE       (16 * 1024)

That's a big hammer :)

> I'm not familiar with the debugobjects code, but maybe it makes sense to
> make "ODEBUG_POOL_SIZE" configurable via Kconfig in a similar fashion to
> "CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE"?

I don't think so.

The change in that patch is neither debug_objects_activate() nor
debug_objecs_assert_init() no longer invoke debug_object_init() which is
now the only place doing pool refills. So depending on the number of
statically allocated objects this might deplete the pool quick enough.

Does the patch below restore the old behaviour?

Thanks,

        tglx
---
diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index b796799fadb2..003edc5ebd67 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -587,6 +587,16 @@ static struct debug_obj *lookup_object_or_alloc(void *addr, struct debug_bucket
 	return NULL;
 }
 
+static void debug_objects_fill_pool(void)
+{
+	/*
+	 * On RT enabled kernels the pool refill must happen in preemptible
+	 * context:
+	 */
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible())
+		fill_pool();
+}
+
 static void
 __debug_object_init(void *addr, const struct debug_obj_descr *descr, int onstack)
 {
@@ -595,12 +605,7 @@ __debug_object_init(void *addr, const struct debug_obj_descr *descr, int onstack
 	struct debug_obj *obj;
 	unsigned long flags;
 
-	/*
-	 * On RT enabled kernels the pool refill must happen in preemptible
-	 * context:
-	 */
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible())
-		fill_pool();
+	debug_objects_fill_pool();
 
 	db = get_bucket((unsigned long) addr);
 
@@ -685,6 +690,8 @@ int debug_object_activate(void *addr, const struct debug_obj_descr *descr)
 	if (!debug_objects_enabled)
 		return 0;
 
+	debug_objects_fill_pool();
+
 	db = get_bucket((unsigned long) addr);
 
 	raw_spin_lock_irqsave(&db->lock, flags);
@@ -894,6 +901,8 @@ void debug_object_assert_init(void *addr, const struct debug_obj_descr *descr)
 	if (!debug_objects_enabled)
 		return;
 
+	debug_objects_fill_pool();
+
 	db = get_bucket((unsigned long) addr);
 
 	raw_spin_lock_irqsave(&db->lock, flags);

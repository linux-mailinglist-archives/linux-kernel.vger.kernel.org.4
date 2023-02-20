Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420E069D05A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 16:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbjBTPLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 10:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjBTPLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 10:11:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45D0768D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 07:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uXlFt2KpyEG9vsA7qmOwPOVxgww5GN30zrP0FA/PiPU=; b=iRuawbNJiQxwFjHaxm7JH0NRGB
        UER1/iOzMTYg0AFwtzFPfd1ZB/0MvJgAXiKqV3048vN4NzcrxnZ5OG1y0ixf3Di6rIQ+GVxUlQlyZ
        rtQr7GZFlAIhPTnnXmm074xk0pHu7X7UkYPZAiCW1Twk350QL4nvJVzZj51ee+c7ia1XzINc5WVQJ
        sk/+T+TohzmHmyAzxMqqEBcmFMGkr6pFkVTZB0VRgrCrgPaum6xdqRABS0RcqIvpq9SyR26/67peV
        Yji2jobc7DwPRNwLgsu3HpEYnLOpx2r4lPlgC28I3zNcXC0oXP82FzlLmN9n8euGqyhsr/4Xey4uw
        dbeE/KJg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pU7nK-00BoYm-9R; Mon, 20 Feb 2023 15:09:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CFBD430015F;
        Mon, 20 Feb 2023 16:09:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9C5122028B119; Mon, 20 Feb 2023 16:09:33 +0100 (CET)
Date:   Mon, 20 Feb 2023 16:09:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        stern@rowland.harvard.edu
Subject: Re: [PATCH 1/2] lockdep: lock_set_lock_cmp_fn()
Message-ID: <Y/ONLYqVrWPFyboF@hirez.programming.kicks-ass.net>
References: <20230218032117.2372071-1-kent.overstreet@linux.dev>
 <20230218032117.2372071-2-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230218032117.2372071-2-kent.overstreet@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 10:21:16PM -0500, Kent Overstreet wrote:

> @@ -2982,6 +2989,10 @@ print_deadlock_bug(struct task_struct *curr, struct held_lock *prev,
>  	pr_warn("\nbut task is already holding lock:\n");
>  	print_lock(prev);
>  
> +	if (class->cmp_fn)
> +		pr_warn("and the lock comparison function returns %i:\n",
> +			class->cmp_fn(prev->instance, next->instance));
> +

Please, use {} for any actual multi-line.

But is this sufficient data to debug a splat? Given an inversion on this
class, we'll get something like:

 A
 A -a
 A -b

vs

 A
 A c

which is I suppose sufficient to say that A messed up, but not much
more. With subclasses we would've gotten

 A/0
 A/1
 A/2

vs

 A/2
 A/0

which is much simpler to work with. Can we improve on this? Give the
cmp_fn an additinoal optional argument of a string pointer or so to fill
out with actual details to be printed?


>  	pr_warn("\nother info that might help us debug this:\n");
>  	print_deadlock_scenario(next, prev);
>  	lockdep_print_held_locks(curr);

> @@ -6597,3 +6623,26 @@ void lockdep_rcu_suspicious(const char *file, const int line, const char *s)
>  	dump_stack();
>  }
>  EXPORT_SYMBOL_GPL(lockdep_rcu_suspicious);
> +
> +#ifdef CONFIG_PROVE_LOCKING

Surely we can find an existing #ifdef block to squirrel this in?

> +void lockdep_set_lock_cmp_fn(struct lockdep_map *lock, lock_cmp_fn fn)
> +{
> +	struct lock_class *class = lock->class_cache[0];
> +	unsigned long flags;
> +
> +	raw_local_irq_save(flags);
> +	lockdep_recursion_inc();
> +
> +	if (!class)
> +		class = register_lock_class(lock, 0, 0);
> +
> +	WARN_ON(class && class->cmp_fn && class->cmp_fn != fn);
> +
> +	if (class)
> +		class->cmp_fn = fn;
> +
> +	lockdep_recursion_finish();
> +	raw_local_irq_restore(flags);
> +}
> +EXPORT_SYMBOL_GPL(lockdep_set_lock_cmp_fn);

However, the bigger question is if this should be part of the
lockdep_init_map_*() family. Perhaps something like below.

With the thinking that the comparator is very much part of the class.

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 1f1099dac3f0..ab50a889991f 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -181,8 +181,18 @@ extern void lockdep_unregister_key(struct lock_class_key *key);
  * to lockdep:
  */
 
-extern void lockdep_init_map_type(struct lockdep_map *lock, const char *name,
-	struct lock_class_key *key, int subclass, u8 inner, u8 outer, u8 lock_type);
+extern void
+lockdep_init_map_cmp(struct lockdep_map *lock, const char *name,
+		     struct lock_class_key *key, int subclass, u8 inner, u8 outer,
+		     u8 lock_type, lock_cmp_fn cmp_fn);
+
+static inline void
+lockdep_init_map_type(struct lockdep_map *lock, const char *name,
+		      struct lock_class_key *key, int subclass, u8 inner, u8 outer,
+		      u8 lock_type)
+{
+	lockdep_init_map_cmp(lock, name, key, subclass, inner, outer, lock_type, NULL);
+}
 
 static inline void
 lockdep_init_map_waits(struct lockdep_map *lock, const char *name,
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index e3375bc40dad..5a6c9512d5b2 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4800,9 +4800,10 @@ static inline int check_wait_context(struct task_struct *curr,
 /*
  * Initialize a lock instance's lock-class mapping info:
  */
-void lockdep_init_map_type(struct lockdep_map *lock, const char *name,
-			    struct lock_class_key *key, int subclass,
-			    u8 inner, u8 outer, u8 lock_type)
+void lockdep_init_map_cmp(struct lockdep_map *lock, const char *name,
+			  struct lock_class_key *key, int subclass,
+			  u8 inner, u8 outer, u8 lock_type,
+			  lock_cmp_fn cmp_fn)
 {
 	int i;
 
@@ -4847,7 +4848,8 @@ void lockdep_init_map_type(struct lockdep_map *lock, const char *name,
 	if (unlikely(!debug_locks))
 		return;
 
-	if (subclass) {
+	if (subclass || cmp_fn) {
+		struct lock_class *class;
 		unsigned long flags;
 
 		if (DEBUG_LOCKS_WARN_ON(!lockdep_enabled()))
@@ -4855,7 +4857,9 @@ void lockdep_init_map_type(struct lockdep_map *lock, const char *name,
 
 		raw_local_irq_save(flags);
 		lockdep_recursion_inc();
-		register_lock_class(lock, subclass, 1);
+		class = register_lock_class(lock, subclass, 1);
+		if (!WARN_ON(!class || (class->cmp_fn && class->cmp_fn != cmp_fn)))
+			class->cmp_fn = cmp_fn;
 		lockdep_recursion_finish();
 		raw_local_irq_restore(flags);
 	}

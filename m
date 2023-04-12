Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABEC6DF615
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjDLMtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjDLMte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:49:34 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047349000;
        Wed, 12 Apr 2023 05:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gHtUC9ZbjIgk4RPtGtrL1TvESI1pfT3DgBqtzWNBp54=; b=pqfu+JncaaA7vblGM3GJBfOy9A
        N7fAck3Zn11IGydLgB79oD3a8b51X6bqgbojBDx2Ln7Hebk/OwuSo8T8TLukC8vMTtXBONbZZG7yO
        NbXdsw2c5u2OGB8x2SqJyee0epR/RmH4vG77Z3rkFR1dZF5UY0eMIIBViyEzGzeTiyUEWxErx8pPw
        l5bL5s1xm27Nx8g9qK5O4U5cUwztL3GbLLJNU10MziHfWZqPWSq7MQkUXVFSwZah+DCKP0ondB4YV
        4AtYm1cB3u8Ion6I4g4QqPTFXevX/joGg6bpF4cW34NQl2SMVDz0AX8YW3a7nHUti9zQgN3s566Uw
        4EVDdCPA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmZsx-00DvZw-2N;
        Wed, 12 Apr 2023 12:47:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 82744300274;
        Wed, 12 Apr 2023 14:47:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 14174235CC4A0; Wed, 12 Apr 2023 14:47:36 +0200 (CEST)
Date:   Wed, 12 Apr 2023 14:47:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        "42.hyeyoo@gmail.com" <42.hyeyoo@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "rientjes@google.com" <rientjes@google.com>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "cl@linux.com" <cl@linux.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zhao Gongyi <zhaogongyi@bytedance.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] mm: slub: annotate kmem_cache_node->list_lock as
 raw_spinlock
Message-ID: <20230412124735.GE628377@hirez.programming.kicks-ass.net>
References: <20230411130854.46795-1-zhengqi.arch@bytedance.com>
 <c6ea3b17-a89c-6f66-5c86-967f1da601b4@suse.cz>
 <ccaf5e8e-3457-a2cf-b6eb-794cbf1b46f5@bytedance.com>
 <f54cfeb9-f1c3-e656-d344-4cbf97a7c28a@suse.cz>
 <932bf921-a076-e166-4f95-1adb24d544cf@bytedance.com>
 <ZDZG6wlWIE4dzd4W@Boquns-Mac-mini.local>
 <PH0PR11MB58805856C1C47D49D1BA8092DA9B9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <e6a21ac6-939c-c686-387b-20f81ba5be53@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6a21ac6-939c-c686-387b-20f81ba5be53@suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 08:50:29AM +0200, Vlastimil Babka wrote:

> > --- a/lib/debugobjects.c
> > +++ b/lib/debugobjects.c
> > @@ -562,10 +562,10 @@ __debug_object_init(void *addr, const struct debug_obj_descr *descr, int onstack
> >         unsigned long flags;
> > 
> >         /*
> > -        * On RT enabled kernels the pool refill must happen in preemptible
> > +        * The pool refill must happen in preemptible
> >          * context:
> >          */
> > -       if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible())
> > +       if (preemptible())
> >                 fill_pool();
> 
> +CC Peterz
> 
> Aha so this is in fact another case where the code is written with
> actual differences between PREEMPT_RT and !PREEMPT_RT in mind, but
> CONFIG_PROVE_RAW_LOCK_NESTING always assumes PREEMPT_RT?

Ooh, tricky, yes. PROVE_RAW_LOCK_NESTING always follows the PREEMP_RT
rules and does not expect trickery like the above.

Something like the completely untested below might be of help..

---
diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
index d22430840b53..f3120d6a7d9e 100644
--- a/include/linux/lockdep_types.h
+++ b/include/linux/lockdep_types.h
@@ -33,6 +33,7 @@ enum lockdep_wait_type {
 enum lockdep_lock_type {
 	LD_LOCK_NORMAL = 0,	/* normal, catch all */
 	LD_LOCK_PERCPU,		/* percpu */
+	LD_LOCK_WAIT,		/* annotation */
 	LD_LOCK_MAX,
 };
 
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 50d4863974e7..a4077f5bb75b 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2279,8 +2279,9 @@ static inline bool usage_skip(struct lock_list *entry, void *mask)
 	 * As a result, we will skip local_lock(), when we search for irq
 	 * inversion bugs.
 	 */
-	if (entry->class->lock_type == LD_LOCK_PERCPU) {
-		if (DEBUG_LOCKS_WARN_ON(entry->class->wait_type_inner < LD_WAIT_CONFIG))
+	if (entry->class->lock_type != LD_LOCK_NORMAL) {
+		if (entry->class->lock_type == LD_LOCK_PERCPU &&
+		    DEBUG_LOCKS_WARN_ON(entry->class->wait_type_inner < LD_WAIT_CONFIG))
 			return false;
 
 		return true;
@@ -4752,7 +4753,8 @@ static int check_wait_context(struct task_struct *curr, struct held_lock *next)
 
 	for (; depth < curr->lockdep_depth; depth++) {
 		struct held_lock *prev = curr->held_locks + depth;
-		u8 prev_inner = hlock_class(prev)->wait_type_inner;
+		struct lock_class *class = hlock_class(prev);
+		u8 prev_inner = class->wait_type_inner;
 
 		if (prev_inner) {
 			/*
@@ -4762,6 +4764,12 @@ static int check_wait_context(struct task_struct *curr, struct held_lock *next)
 			 * Also due to trylocks.
 			 */
 			curr_inner = min(curr_inner, prev_inner);
+
+			/*
+			 * Allow override for annotations.
+			 */
+			if (unlikely(class->lock_type == LD_LOCK_WAIT))
+				curr_inner = prev_inner;
 		}
 	}
 
diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index df86e649d8be..fae71ef72a16 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -565,8 +565,16 @@ __debug_object_init(void *addr, const struct debug_obj_descr *descr, int onstack
 	 * On RT enabled kernels the pool refill must happen in preemptible
 	 * context:
 	 */
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible())
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible()) {
+		static lockdep_map dep_map = {
+			.name = "wait-type-override",
+			.wait_type_inner = LD_WAIT_SLEEP,
+			.lock_type = LD_LOCK_WAIT,
+		};
+		lock_map_acquire(&dep_map);
 		fill_pool();
+		lock_map_release(&dep_map);
+	}
 
 	db = get_bucket((unsigned long) addr);
 

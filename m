Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139CD6DDC63
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 15:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjDKNlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 09:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjDKNk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 09:40:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208F340E8;
        Tue, 11 Apr 2023 06:40:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C92E51FD6A;
        Tue, 11 Apr 2023 13:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681220445; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f1uB+fo2/DXXz4yEHleDteNpsxmFnh6Wnhr6MnpI+74=;
        b=mKo8lsCrRjTiGH+Mk2pMEs6JYT7VbT+E8abeyGcNWdsNF17LfCc2U50uKTtIgmbrHQgAKg
        +eEmI+w2pQ3HBc9WD/HtnlJ6StO/MqOpvC0SIiIBi8T2dpFOJGRRUEG8RetWc/s3/tsBR/
        TLS2ShQs4X5Ae4a8QyfSrNjnFPPB0os=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681220445;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f1uB+fo2/DXXz4yEHleDteNpsxmFnh6Wnhr6MnpI+74=;
        b=gyeCRlppSVCg1p3aVp+8arjv3xN6m9LxWOjoWvKBF7X1oQHimJxgctSHxvqWIODLOYeymA
        w+YskbanEnhLgTDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8D69913519;
        Tue, 11 Apr 2023 13:40:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GuS2IV1jNWQRPgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 11 Apr 2023 13:40:45 +0000
Message-ID: <c6ea3b17-a89c-6f66-5c86-967f1da601b4@suse.cz>
Date:   Tue, 11 Apr 2023 15:40:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] mm: slub: annotate kmem_cache_node->list_lock as
 raw_spinlock
Content-Language: en-US
To:     Qi Zheng <zhengqi.arch@bytedance.com>, 42.hyeyoo@gmail.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        iamjoonsoo.kim@lge.com, rientjes@google.com, penberg@kernel.org,
        cl@linux.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zhao Gongyi <zhaogongyi@bytedance.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
References: <20230411130854.46795-1-zhengqi.arch@bytedance.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230411130854.46795-1-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/23 15:08, Qi Zheng wrote:
> The list_lock can be held in the critical section of
> raw_spinlock, and then lockdep will complain about it
> like below:
> 
>  =============================
>  [ BUG: Invalid wait context ]
>  6.3.0-rc6-next-20230411 #7 Not tainted
>  -----------------------------
>  swapper/0/1 is trying to lock:
>  ffff888100055418 (&n->list_lock){....}-{3:3}, at: ___slab_alloc+0x73d/0x1330
>  other info that might help us debug this:
>  context-{5:5}
>  2 locks held by swapper/0/1:
>   #0: ffffffff824e8160 (rcu_tasks.cbs_gbl_lock){....}-{2:2}, at: cblist_init_generic+0x22/0x2d0
>   #1: ffff888136bede50 (&ACCESS_PRIVATE(rtpcp, lock)){....}-{2:2}, at: cblist_init_generic+0x232/0x2d0
>  stack backtrace:
>  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.3.0-rc6-next-20230411 #7
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0x77/0xc0
>   __lock_acquire+0xa65/0x2950
>   ? arch_stack_walk+0x65/0xf0
>   ? arch_stack_walk+0x65/0xf0
>   ? unwind_next_frame+0x602/0x8d0
>   lock_acquire+0xe0/0x300
>   ? ___slab_alloc+0x73d/0x1330
>   ? find_usage_forwards+0x39/0x50
>   ? check_irq_usage+0x162/0xa70
>   ? __bfs+0x10c/0x2c0
>   _raw_spin_lock_irqsave+0x4f/0x90
>   ? ___slab_alloc+0x73d/0x1330
>   ___slab_alloc+0x73d/0x1330
>   ? fill_pool+0x16b/0x2a0
>   ? look_up_lock_class+0x5d/0x160
>   ? register_lock_class+0x48/0x500
>   ? __lock_acquire+0xabc/0x2950
>   ? fill_pool+0x16b/0x2a0
>   kmem_cache_alloc+0x358/0x3b0
>   ? __lock_acquire+0xabc/0x2950
>   fill_pool+0x16b/0x2a0
>   ? __debug_object_init+0x292/0x560
>   ? lock_acquire+0xe0/0x300
>   ? cblist_init_generic+0x232/0x2d0
>   __debug_object_init+0x2c/0x560
>   cblist_init_generic+0x147/0x2d0
>   rcu_init_tasks_generic+0x15/0x190
>   kernel_init_freeable+0x6e/0x3e0
>   ? rest_init+0x1e0/0x1e0
>   kernel_init+0x1b/0x1d0
>   ? rest_init+0x1e0/0x1e0
>   ret_from_fork+0x1f/0x30
>   </TASK>
> 
> The fill_pool() can only be called in the !PREEMPT_RT kernel
> or in the preemptible context of the PREEMPT_RT kernel, so
> the above warning is not a real issue, but it's better to
> annotate kmem_cache_node->list_lock as raw_spinlock to get
> rid of such issue.

+ CC some RT and RCU people

AFAIK raw_spinlock is not just an annotation, but on RT it changes the
implementation from preemptible mutex to actual spin lock, so it would be
rather unfortunate to do that for a spurious warning. Can it be somehow
fixed in a better way?

> Reported-by: Zhao Gongyi <zhaogongyi@bytedance.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  mm/slab.h |  4 ++--
>  mm/slub.c | 66 +++++++++++++++++++++++++++----------------------------
>  2 files changed, 35 insertions(+), 35 deletions(-)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index f01ac256a8f5..43f3436d13b4 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -723,8 +723,9 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s,
>   * The slab lists for all objects.
>   */
>  struct kmem_cache_node {
> -#ifdef CONFIG_SLAB
>  	raw_spinlock_t list_lock;
> +
> +#ifdef CONFIG_SLAB
>  	struct list_head slabs_partial;	/* partial list first, better asm code */
>  	struct list_head slabs_full;
>  	struct list_head slabs_free;
> @@ -740,7 +741,6 @@ struct kmem_cache_node {
>  #endif
>  
>  #ifdef CONFIG_SLUB
> -	spinlock_t list_lock;
>  	unsigned long nr_partial;
>  	struct list_head partial;
>  #ifdef CONFIG_SLUB_DEBUG
> diff --git a/mm/slub.c b/mm/slub.c
> index c87628cd8a9a..e66a35643624 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1331,7 +1331,7 @@ static void add_full(struct kmem_cache *s,
>  	if (!(s->flags & SLAB_STORE_USER))
>  		return;
>  
> -	lockdep_assert_held(&n->list_lock);
> +	assert_raw_spin_locked(&n->list_lock);
>  	list_add(&slab->slab_list, &n->full);
>  }
>  
> @@ -1340,7 +1340,7 @@ static void remove_full(struct kmem_cache *s, struct kmem_cache_node *n, struct
>  	if (!(s->flags & SLAB_STORE_USER))
>  		return;
>  
> -	lockdep_assert_held(&n->list_lock);
> +	assert_raw_spin_locked(&n->list_lock);
>  	list_del(&slab->slab_list);
>  }
>  
> @@ -2113,14 +2113,14 @@ __add_partial(struct kmem_cache_node *n, struct slab *slab, int tail)
>  static inline void add_partial(struct kmem_cache_node *n,
>  				struct slab *slab, int tail)
>  {
> -	lockdep_assert_held(&n->list_lock);
> +	assert_raw_spin_locked(&n->list_lock);
>  	__add_partial(n, slab, tail);
>  }
>  
>  static inline void remove_partial(struct kmem_cache_node *n,
>  					struct slab *slab)
>  {
> -	lockdep_assert_held(&n->list_lock);
> +	assert_raw_spin_locked(&n->list_lock);
>  	list_del(&slab->slab_list);
>  	n->nr_partial--;
>  }
> @@ -2136,7 +2136,7 @@ static void *alloc_single_from_partial(struct kmem_cache *s,
>  {
>  	void *object;
>  
> -	lockdep_assert_held(&n->list_lock);
> +	assert_raw_spin_locked(&n->list_lock);
>  
>  	object = slab->freelist;
>  	slab->freelist = get_freepointer(s, object);
> @@ -2181,7 +2181,7 @@ static void *alloc_single_from_new_slab(struct kmem_cache *s,
>  		 */
>  		return NULL;
>  
> -	spin_lock_irqsave(&n->list_lock, flags);
> +	raw_spin_lock_irqsave(&n->list_lock, flags);
>  
>  	if (slab->inuse == slab->objects)
>  		add_full(s, n, slab);
> @@ -2189,7 +2189,7 @@ static void *alloc_single_from_new_slab(struct kmem_cache *s,
>  		add_partial(n, slab, DEACTIVATE_TO_HEAD);
>  
>  	inc_slabs_node(s, nid, slab->objects);
> -	spin_unlock_irqrestore(&n->list_lock, flags);
> +	raw_spin_unlock_irqrestore(&n->list_lock, flags);
>  
>  	return object;
>  }
> @@ -2208,7 +2208,7 @@ static inline void *acquire_slab(struct kmem_cache *s,
>  	unsigned long counters;
>  	struct slab new;
>  
> -	lockdep_assert_held(&n->list_lock);
> +	assert_raw_spin_locked(&n->list_lock);
>  
>  	/*
>  	 * Zap the freelist and set the frozen bit.
> @@ -2267,7 +2267,7 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
>  	if (!n || !n->nr_partial)
>  		return NULL;
>  
> -	spin_lock_irqsave(&n->list_lock, flags);
> +	raw_spin_lock_irqsave(&n->list_lock, flags);
>  	list_for_each_entry_safe(slab, slab2, &n->partial, slab_list) {
>  		void *t;
>  
> @@ -2304,7 +2304,7 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
>  #endif
>  
>  	}
> -	spin_unlock_irqrestore(&n->list_lock, flags);
> +	raw_spin_unlock_irqrestore(&n->list_lock, flags);
>  	return object;
>  }
>  
> @@ -2548,7 +2548,7 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
>  		 * Taking the spinlock removes the possibility that
>  		 * acquire_slab() will see a slab that is frozen
>  		 */
> -		spin_lock_irqsave(&n->list_lock, flags);
> +		raw_spin_lock_irqsave(&n->list_lock, flags);
>  	} else {
>  		mode = M_FULL_NOLIST;
>  	}
> @@ -2559,14 +2559,14 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
>  				new.freelist, new.counters,
>  				"unfreezing slab")) {
>  		if (mode == M_PARTIAL)
> -			spin_unlock_irqrestore(&n->list_lock, flags);
> +			raw_spin_unlock_irqrestore(&n->list_lock, flags);
>  		goto redo;
>  	}
>  
>  
>  	if (mode == M_PARTIAL) {
>  		add_partial(n, slab, tail);
> -		spin_unlock_irqrestore(&n->list_lock, flags);
> +		raw_spin_unlock_irqrestore(&n->list_lock, flags);
>  		stat(s, tail);
>  	} else if (mode == M_FREE) {
>  		stat(s, DEACTIVATE_EMPTY);
> @@ -2594,10 +2594,10 @@ static void __unfreeze_partials(struct kmem_cache *s, struct slab *partial_slab)
>  		n2 = get_node(s, slab_nid(slab));
>  		if (n != n2) {
>  			if (n)
> -				spin_unlock_irqrestore(&n->list_lock, flags);
> +				raw_spin_unlock_irqrestore(&n->list_lock, flags);
>  
>  			n = n2;
> -			spin_lock_irqsave(&n->list_lock, flags);
> +			raw_spin_lock_irqsave(&n->list_lock, flags);
>  		}
>  
>  		do {
> @@ -2626,7 +2626,7 @@ static void __unfreeze_partials(struct kmem_cache *s, struct slab *partial_slab)
>  	}
>  
>  	if (n)
> -		spin_unlock_irqrestore(&n->list_lock, flags);
> +		raw_spin_unlock_irqrestore(&n->list_lock, flags);
>  
>  	while (slab_to_discard) {
>  		slab = slab_to_discard;
> @@ -2951,10 +2951,10 @@ static unsigned long count_partial(struct kmem_cache_node *n,
>  	unsigned long x = 0;
>  	struct slab *slab;
>  
> -	spin_lock_irqsave(&n->list_lock, flags);
> +	raw_spin_lock_irqsave(&n->list_lock, flags);
>  	list_for_each_entry(slab, &n->partial, slab_list)
>  		x += get_count(slab);
> -	spin_unlock_irqrestore(&n->list_lock, flags);
> +	raw_spin_unlock_irqrestore(&n->list_lock, flags);
>  	return x;
>  }
>  #endif /* CONFIG_SLUB_DEBUG || SLAB_SUPPORTS_SYSFS */
> @@ -3515,7 +3515,7 @@ static noinline void free_to_partial_list(
>  	if (s->flags & SLAB_STORE_USER)
>  		handle = set_track_prepare();
>  
> -	spin_lock_irqsave(&n->list_lock, flags);
> +	raw_spin_lock_irqsave(&n->list_lock, flags);
>  
>  	if (free_debug_processing(s, slab, head, tail, &cnt, addr, handle)) {
>  		void *prior = slab->freelist;
> @@ -3554,7 +3554,7 @@ static noinline void free_to_partial_list(
>  		dec_slabs_node(s, slab_nid(slab_free), slab_free->objects);
>  	}
>  
> -	spin_unlock_irqrestore(&n->list_lock, flags);
> +	raw_spin_unlock_irqrestore(&n->list_lock, flags);
>  
>  	if (slab_free) {
>  		stat(s, FREE_SLAB);
> @@ -3594,7 +3594,7 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>  
>  	do {
>  		if (unlikely(n)) {
> -			spin_unlock_irqrestore(&n->list_lock, flags);
> +			raw_spin_unlock_irqrestore(&n->list_lock, flags);
>  			n = NULL;
>  		}
>  		prior = slab->freelist;
> @@ -3626,7 +3626,7 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>  				 * Otherwise the list_lock will synchronize with
>  				 * other processors updating the list of slabs.
>  				 */
> -				spin_lock_irqsave(&n->list_lock, flags);
> +				raw_spin_lock_irqsave(&n->list_lock, flags);
>  
>  			}
>  		}
> @@ -3668,7 +3668,7 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>  		add_partial(n, slab, DEACTIVATE_TO_TAIL);
>  		stat(s, FREE_ADD_PARTIAL);
>  	}
> -	spin_unlock_irqrestore(&n->list_lock, flags);
> +	raw_spin_unlock_irqrestore(&n->list_lock, flags);
>  	return;
>  
>  slab_empty:
> @@ -3683,7 +3683,7 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>  		remove_full(s, n, slab);
>  	}
>  
> -	spin_unlock_irqrestore(&n->list_lock, flags);
> +	raw_spin_unlock_irqrestore(&n->list_lock, flags);
>  	stat(s, FREE_SLAB);
>  	discard_slab(s, slab);
>  }
> @@ -4180,7 +4180,7 @@ static void
>  init_kmem_cache_node(struct kmem_cache_node *n)
>  {
>  	n->nr_partial = 0;
> -	spin_lock_init(&n->list_lock);
> +	raw_spin_lock_init(&n->list_lock);
>  	INIT_LIST_HEAD(&n->partial);
>  #ifdef CONFIG_SLUB_DEBUG
>  	atomic_long_set(&n->nr_slabs, 0);
> @@ -4576,7 +4576,7 @@ static void free_partial(struct kmem_cache *s, struct kmem_cache_node *n)
>  	struct slab *slab, *h;
>  
>  	BUG_ON(irqs_disabled());
> -	spin_lock_irq(&n->list_lock);
> +	raw_spin_lock_irq(&n->list_lock);
>  	list_for_each_entry_safe(slab, h, &n->partial, slab_list) {
>  		if (!slab->inuse) {
>  			remove_partial(n, slab);
> @@ -4586,7 +4586,7 @@ static void free_partial(struct kmem_cache *s, struct kmem_cache_node *n)
>  			  "Objects remaining in %s on __kmem_cache_shutdown()");
>  		}
>  	}
> -	spin_unlock_irq(&n->list_lock);
> +	raw_spin_unlock_irq(&n->list_lock);
>  
>  	list_for_each_entry_safe(slab, h, &discard, slab_list)
>  		discard_slab(s, slab);
> @@ -4790,7 +4790,7 @@ static int __kmem_cache_do_shrink(struct kmem_cache *s)
>  		for (i = 0; i < SHRINK_PROMOTE_MAX; i++)
>  			INIT_LIST_HEAD(promote + i);
>  
> -		spin_lock_irqsave(&n->list_lock, flags);
> +		raw_spin_lock_irqsave(&n->list_lock, flags);
>  
>  		/*
>  		 * Build lists of slabs to discard or promote.
> @@ -4822,7 +4822,7 @@ static int __kmem_cache_do_shrink(struct kmem_cache *s)
>  		for (i = SHRINK_PROMOTE_MAX - 1; i >= 0; i--)
>  			list_splice(promote + i, &n->partial);
>  
> -		spin_unlock_irqrestore(&n->list_lock, flags);
> +		raw_spin_unlock_irqrestore(&n->list_lock, flags);
>  
>  		/* Release empty slabs */
>  		list_for_each_entry_safe(slab, t, &discard, slab_list)
> @@ -5147,7 +5147,7 @@ static int validate_slab_node(struct kmem_cache *s,
>  	struct slab *slab;
>  	unsigned long flags;
>  
> -	spin_lock_irqsave(&n->list_lock, flags);
> +	raw_spin_lock_irqsave(&n->list_lock, flags);
>  
>  	list_for_each_entry(slab, &n->partial, slab_list) {
>  		validate_slab(s, slab, obj_map);
> @@ -5173,7 +5173,7 @@ static int validate_slab_node(struct kmem_cache *s,
>  	}
>  
>  out:
> -	spin_unlock_irqrestore(&n->list_lock, flags);
> +	raw_spin_unlock_irqrestore(&n->list_lock, flags);
>  	return count;
>  }
>  
> @@ -6399,12 +6399,12 @@ static int slab_debug_trace_open(struct inode *inode, struct file *filep)
>  		if (!atomic_long_read(&n->nr_slabs))
>  			continue;
>  
> -		spin_lock_irqsave(&n->list_lock, flags);
> +		raw_spin_lock_irqsave(&n->list_lock, flags);
>  		list_for_each_entry(slab, &n->partial, slab_list)
>  			process_slab(t, s, slab, alloc, obj_map);
>  		list_for_each_entry(slab, &n->full, slab_list)
>  			process_slab(t, s, slab, alloc, obj_map);
> -		spin_unlock_irqrestore(&n->list_lock, flags);
> +		raw_spin_unlock_irqrestore(&n->list_lock, flags);
>  	}
>  
>  	/* Sort locations by count */


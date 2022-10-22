Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A097A60846D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 07:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJVFFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 01:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJVFE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 01:04:58 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEA243AEB
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 22:04:55 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id q71so4280646pgq.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 22:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sIO8sh3SCybVwzv3Rc2zbve1XRpQI+8AREdnkwwZpmY=;
        b=gg/qDe5Et7eWr9ahJps1Q1rySb+13JTQCoFlsWZUCgbV1tjio0WOTzpftJZyabxzRs
         KpC1NOXav55O0Jyi4UggBxFyAAsQ5MlgoDGzRlTzpzeDi04SEbWF8I5N97htO7q1ZTwZ
         4BgGKb2FwEN6F6B+hh39Iym1/Rmg4RE39M8PMeia/Us1zwMqZ3AWPD6+22vCzA/GLSCR
         X6sFh3R0Z7UkfBlWtp5FdKR2cI5hP147lN7MI1f+HFWXnSWZaGYov3IeCLIvic0M0Syq
         TE0gUHakC33qeY8xMllS3vhlS5b8gbQ3h1Z2AoKAXpV5Y+wCn/IHtk5JCD5QVFVtM++s
         RJdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sIO8sh3SCybVwzv3Rc2zbve1XRpQI+8AREdnkwwZpmY=;
        b=NqSrwCL0oUFa7Cp+mCsF+MDpV5ZcXhbjT3bxWamfmoiiYAJcfPMF3l0a8QMQMT449P
         A0ogFb/b/j+n/eMQRDz6NZuRY/bXp+06ortRLABzn5qs3huOrIW8YbLdNQEU/l4ataOk
         J7p607yPE+CnPyO5R+pxEqO02Ye4DA0GSNZKRwf8hLNJqaFS6XYP1+km4eG9F+ZFhlle
         rg2UwPusU3UMfO4a73LkJstdzy09DcLr42ER01TI3URIj2KQY9uhsBHYHQssyLsiYecD
         hfj/jHqpkWfdMLvcYgtjVJk6jgdcvIQFC+EFYmBmFL922nrsA8+hCC1o98oiJvOBT8MQ
         0mqw==
X-Gm-Message-State: ACrzQf2LjW4ndBPBllDThd7PR4YYrv1BhwKLcmFQ+XcOpn4ZxRFn+UXi
        VHOSAwJXYdRrwX3UPnZSDCQ=
X-Google-Smtp-Source: AMsMyM6YTBNms3fGHvjxfcRfQUc8Sra9ih1CfaPpWd4X2yoEpY0+Rscj3MxXRGVyeerMlPWiw1Ygxg==
X-Received: by 2002:a05:6a00:804:b0:563:264a:f5e5 with SMTP id m4-20020a056a00080400b00563264af5e5mr22860776pfk.62.1666415094969;
        Fri, 21 Oct 2022 22:04:54 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id g12-20020a65594c000000b0043a1c0a0ab1sm14411363pgu.83.2022.10.21.22.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 22:04:54 -0700 (PDT)
Date:   Sat, 22 Oct 2022 14:04:48 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/slab: Annotate kmem_cache_node->list_lock as raw
Message-ID: <Y1N58AEmb8f49Pe/@hyeyoo>
References: <nycvar.YFH.7.76.2210211643330.29912@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.2210212114480.29912@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.2210212117090.29912@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.2210212117090.29912@cbobk.fhfr.pm>
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 09:18:12PM +0200, Jiri Kosina wrote:
> From: Jiri Kosina <jkosina@suse.cz>
> 
> The list_lock can be taken in hardirq context when do_drain() is being 
> called via IPI on all cores, and therefore lockdep complains about it, 
> because it can't be preempted on PREEMPT_RT.
>
> That's not a real issue, as SLAB can't be built on PREEMPT_RT anyway, but 
> we still want to get rid of the warning on non-PREEMPT_RT builds.
> 
> Annotate it therefore as a raw lock in order to get rid of he lockdep 
> warning below.
> 
> 	 =============================
> 	 [ BUG: Invalid wait context ]
> 	 6.1.0-rc1-00134-ge35184f32151 #4 Not tainted
> 	 -----------------------------
> 	 swapper/3/0 is trying to lock:
> 	 ffff8bc88086dc18 (&parent->list_lock){..-.}-{3:3}, at: do_drain+0x57/0xb0
> 	 other info that might help us debug this:
> 	 context-{2:2}
> 	 no locks held by swapper/3/0.
> 	 stack backtrace:
> 	 CPU: 3 PID: 0 Comm: swapper/3 Not tainted 6.1.0-rc1-00134-ge35184f32151 #4
> 	 Hardware name: LENOVO 20K5S22R00/20K5S22R00, BIOS R0IET38W (1.16 ) 05/31/2017
> 	 Call Trace:
> 	  <IRQ>
> 	  dump_stack_lvl+0x6b/0x9d
> 	  __lock_acquire+0x1519/0x1730
> 	  ? build_sched_domains+0x4bd/0x1590
> 	  ? __lock_acquire+0xad2/0x1730
> 	  lock_acquire+0x294/0x340
> 	  ? do_drain+0x57/0xb0
> 	  ? sched_clock_tick+0x41/0x60
> 	  _raw_spin_lock+0x2c/0x40
> 	  ? do_drain+0x57/0xb0
> 	  do_drain+0x57/0xb0
> 	  __flush_smp_call_function_queue+0x138/0x220
> 	  __sysvec_call_function+0x4f/0x210
> 	  sysvec_call_function+0x4b/0x90
> 	  </IRQ>
> 	  <TASK>
> 	  asm_sysvec_call_function+0x16/0x20
> 	 RIP: 0010:mwait_idle+0x5e/0x80
> 	 Code: 31 d2 65 48 8b 04 25 80 ed 01 00 48 89 d1 0f 01 c8 48 8b 00 a8 08 75 14 66 90 0f 00 2d 0b 78 46 00 31 c0 48 89 c1 fb 0f 01 c9 <eb> 06 fb 0f 1f 44 00 00 65 48 8b 04 25 80 ed 01 00 f0 80 60 02 df
> 	 RSP: 0000:ffffa90940217ee0 EFLAGS: 00000246
> 	 RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> 	 RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff9bb9f93a
> 	 RBP: 0000000000000003 R08: 0000000000000001 R09: 0000000000000001
> 	 R10: ffffa90940217ea8 R11: 0000000000000000 R12: ffffffffffffffff
> 	 R13: 0000000000000000 R14: ffff8bc88127c500 R15: 0000000000000000
> 	  ? default_idle_call+0x1a/0xa0
> 	  default_idle_call+0x4b/0xa0
> 	  do_idle+0x1f1/0x2c0
> 	  ? _raw_spin_unlock_irqrestore+0x56/0x70
> 	  cpu_startup_entry+0x19/0x20
> 	  start_secondary+0x122/0x150
> 	  secondary_startup_64_no_verify+0xce/0xdb
> 	  </TASK>
>

Looks good to me.
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> ---
> 
> v1->v2: fix !SLAB build failures due to list_lock mismatch
> v2->v3: really fix it by sending refreshed version of the patch (facepalm)
> 
>  mm/slab.c | 90 +++++++++++++++++++++++++++----------------------------
>  mm/slab.h |  4 +++
>  2 files changed, 49 insertions(+), 45 deletions(-)
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index 59c8e28f7b6a..d8a287900193 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -234,7 +234,7 @@ static void kmem_cache_node_init(struct kmem_cache_node *parent)
>  	parent->shared = NULL;
>  	parent->alien = NULL;
>  	parent->colour_next = 0;
> -	spin_lock_init(&parent->list_lock);
> +	raw_spin_lock_init(&parent->list_lock);
>  	parent->free_objects = 0;
>  	parent->free_touched = 0;
>  }
> @@ -559,9 +559,9 @@ static noinline void cache_free_pfmemalloc(struct kmem_cache *cachep,
>  	slab_node = slab_nid(slab);
>  	n = get_node(cachep, slab_node);
>  
> -	spin_lock(&n->list_lock);
> +	raw_spin_lock(&n->list_lock);
>  	free_block(cachep, &objp, 1, slab_node, &list);
> -	spin_unlock(&n->list_lock);
> +	raw_spin_unlock(&n->list_lock);
>  
>  	slabs_destroy(cachep, &list);
>  }
> @@ -684,7 +684,7 @@ static void __drain_alien_cache(struct kmem_cache *cachep,
>  	struct kmem_cache_node *n = get_node(cachep, node);
>  
>  	if (ac->avail) {
> -		spin_lock(&n->list_lock);
> +		raw_spin_lock(&n->list_lock);
>  		/*
>  		 * Stuff objects into the remote nodes shared array first.
>  		 * That way we could avoid the overhead of putting the objects
> @@ -695,7 +695,7 @@ static void __drain_alien_cache(struct kmem_cache *cachep,
>  
>  		free_block(cachep, ac->entry, ac->avail, node, list);
>  		ac->avail = 0;
> -		spin_unlock(&n->list_lock);
> +		raw_spin_unlock(&n->list_lock);
>  	}
>  }
>  
> @@ -768,9 +768,9 @@ static int __cache_free_alien(struct kmem_cache *cachep, void *objp,
>  		slabs_destroy(cachep, &list);
>  	} else {
>  		n = get_node(cachep, slab_node);
> -		spin_lock(&n->list_lock);
> +		raw_spin_lock(&n->list_lock);
>  		free_block(cachep, &objp, 1, slab_node, &list);
> -		spin_unlock(&n->list_lock);
> +		raw_spin_unlock(&n->list_lock);
>  		slabs_destroy(cachep, &list);
>  	}
>  	return 1;
> @@ -811,10 +811,10 @@ static int init_cache_node(struct kmem_cache *cachep, int node, gfp_t gfp)
>  	 */
>  	n = get_node(cachep, node);
>  	if (n) {
> -		spin_lock_irq(&n->list_lock);
> +		raw_spin_lock_irq(&n->list_lock);
>  		n->free_limit = (1 + nr_cpus_node(node)) * cachep->batchcount +
>  				cachep->num;
> -		spin_unlock_irq(&n->list_lock);
> +		raw_spin_unlock_irq(&n->list_lock);
>  
>  		return 0;
>  	}
> @@ -893,7 +893,7 @@ static int setup_kmem_cache_node(struct kmem_cache *cachep,
>  		goto fail;
>  
>  	n = get_node(cachep, node);
> -	spin_lock_irq(&n->list_lock);
> +	raw_spin_lock_irq(&n->list_lock);
>  	if (n->shared && force_change) {
>  		free_block(cachep, n->shared->entry,
>  				n->shared->avail, node, &list);
> @@ -911,7 +911,7 @@ static int setup_kmem_cache_node(struct kmem_cache *cachep,
>  		new_alien = NULL;
>  	}
>  
> -	spin_unlock_irq(&n->list_lock);
> +	raw_spin_unlock_irq(&n->list_lock);
>  	slabs_destroy(cachep, &list);
>  
>  	/*
> @@ -950,7 +950,7 @@ static void cpuup_canceled(long cpu)
>  		if (!n)
>  			continue;
>  
> -		spin_lock_irq(&n->list_lock);
> +		raw_spin_lock_irq(&n->list_lock);
>  
>  		/* Free limit for this kmem_cache_node */
>  		n->free_limit -= cachep->batchcount;
> @@ -961,7 +961,7 @@ static void cpuup_canceled(long cpu)
>  		nc->avail = 0;
>  
>  		if (!cpumask_empty(mask)) {
> -			spin_unlock_irq(&n->list_lock);
> +			raw_spin_unlock_irq(&n->list_lock);
>  			goto free_slab;
>  		}
>  
> @@ -975,7 +975,7 @@ static void cpuup_canceled(long cpu)
>  		alien = n->alien;
>  		n->alien = NULL;
>  
> -		spin_unlock_irq(&n->list_lock);
> +		raw_spin_unlock_irq(&n->list_lock);
>  
>  		kfree(shared);
>  		if (alien) {
> @@ -1159,7 +1159,7 @@ static void __init init_list(struct kmem_cache *cachep, struct kmem_cache_node *
>  	/*
>  	 * Do not assume that spinlocks can be initialized via memcpy:
>  	 */
> -	spin_lock_init(&ptr->list_lock);
> +	raw_spin_lock_init(&ptr->list_lock);
>  
>  	MAKE_ALL_LISTS(cachep, ptr, nodeid);
>  	cachep->node[nodeid] = ptr;
> @@ -1330,11 +1330,11 @@ slab_out_of_memory(struct kmem_cache *cachep, gfp_t gfpflags, int nodeid)
>  	for_each_kmem_cache_node(cachep, node, n) {
>  		unsigned long total_slabs, free_slabs, free_objs;
>  
> -		spin_lock_irqsave(&n->list_lock, flags);
> +		raw_spin_lock_irqsave(&n->list_lock, flags);
>  		total_slabs = n->total_slabs;
>  		free_slabs = n->free_slabs;
>  		free_objs = n->free_objects;
> -		spin_unlock_irqrestore(&n->list_lock, flags);
> +		raw_spin_unlock_irqrestore(&n->list_lock, flags);
>  
>  		pr_warn("  node %d: slabs: %ld/%ld, objs: %ld/%ld\n",
>  			node, total_slabs - free_slabs, total_slabs,
> @@ -2096,7 +2096,7 @@ static void check_spinlock_acquired(struct kmem_cache *cachep)
>  {
>  #ifdef CONFIG_SMP
>  	check_irq_off();
> -	assert_spin_locked(&get_node(cachep, numa_mem_id())->list_lock);
> +	assert_raw_spin_locked(&get_node(cachep, numa_mem_id())->list_lock);
>  #endif
>  }
>  
> @@ -2104,7 +2104,7 @@ static void check_spinlock_acquired_node(struct kmem_cache *cachep, int node)
>  {
>  #ifdef CONFIG_SMP
>  	check_irq_off();
> -	assert_spin_locked(&get_node(cachep, node)->list_lock);
> +	assert_raw_spin_locked(&get_node(cachep, node)->list_lock);
>  #endif
>  }
>  
> @@ -2144,9 +2144,9 @@ static void do_drain(void *arg)
>  	check_irq_off();
>  	ac = cpu_cache_get(cachep);
>  	n = get_node(cachep, node);
> -	spin_lock(&n->list_lock);
> +	raw_spin_lock(&n->list_lock);
>  	free_block(cachep, ac->entry, ac->avail, node, &list);
> -	spin_unlock(&n->list_lock);
> +	raw_spin_unlock(&n->list_lock);
>  	ac->avail = 0;
>  	slabs_destroy(cachep, &list);
>  }
> @@ -2164,9 +2164,9 @@ static void drain_cpu_caches(struct kmem_cache *cachep)
>  			drain_alien_cache(cachep, n->alien);
>  
>  	for_each_kmem_cache_node(cachep, node, n) {
> -		spin_lock_irq(&n->list_lock);
> +		raw_spin_lock_irq(&n->list_lock);
>  		drain_array_locked(cachep, n->shared, node, true, &list);
> -		spin_unlock_irq(&n->list_lock);
> +		raw_spin_unlock_irq(&n->list_lock);
>  
>  		slabs_destroy(cachep, &list);
>  	}
> @@ -2188,10 +2188,10 @@ static int drain_freelist(struct kmem_cache *cache,
>  	nr_freed = 0;
>  	while (nr_freed < tofree && !list_empty(&n->slabs_free)) {
>  
> -		spin_lock_irq(&n->list_lock);
> +		raw_spin_lock_irq(&n->list_lock);
>  		p = n->slabs_free.prev;
>  		if (p == &n->slabs_free) {
> -			spin_unlock_irq(&n->list_lock);
> +			raw_spin_unlock_irq(&n->list_lock);
>  			goto out;
>  		}
>  
> @@ -2204,7 +2204,7 @@ static int drain_freelist(struct kmem_cache *cache,
>  		 * to the cache.
>  		 */
>  		n->free_objects -= cache->num;
> -		spin_unlock_irq(&n->list_lock);
> +		raw_spin_unlock_irq(&n->list_lock);
>  		slab_destroy(cache, slab);
>  		nr_freed++;
>  	}
> @@ -2629,7 +2629,7 @@ static void cache_grow_end(struct kmem_cache *cachep, struct slab *slab)
>  	INIT_LIST_HEAD(&slab->slab_list);
>  	n = get_node(cachep, slab_nid(slab));
>  
> -	spin_lock(&n->list_lock);
> +	raw_spin_lock(&n->list_lock);
>  	n->total_slabs++;
>  	if (!slab->active) {
>  		list_add_tail(&slab->slab_list, &n->slabs_free);
> @@ -2639,7 +2639,7 @@ static void cache_grow_end(struct kmem_cache *cachep, struct slab *slab)
>  
>  	STATS_INC_GROWN(cachep);
>  	n->free_objects += cachep->num - slab->active;
> -	spin_unlock(&n->list_lock);
> +	raw_spin_unlock(&n->list_lock);
>  
>  	fixup_objfreelist_debug(cachep, &list);
>  }
> @@ -2805,7 +2805,7 @@ static struct slab *get_first_slab(struct kmem_cache_node *n, bool pfmemalloc)
>  {
>  	struct slab *slab;
>  
> -	assert_spin_locked(&n->list_lock);
> +	assert_raw_spin_locked(&n->list_lock);
>  	slab = list_first_entry_or_null(&n->slabs_partial, struct slab,
>  					slab_list);
>  	if (!slab) {
> @@ -2832,10 +2832,10 @@ static noinline void *cache_alloc_pfmemalloc(struct kmem_cache *cachep,
>  	if (!gfp_pfmemalloc_allowed(flags))
>  		return NULL;
>  
> -	spin_lock(&n->list_lock);
> +	raw_spin_lock(&n->list_lock);
>  	slab = get_first_slab(n, true);
>  	if (!slab) {
> -		spin_unlock(&n->list_lock);
> +		raw_spin_unlock(&n->list_lock);
>  		return NULL;
>  	}
>  
> @@ -2844,7 +2844,7 @@ static noinline void *cache_alloc_pfmemalloc(struct kmem_cache *cachep,
>  
>  	fixup_slab_list(cachep, n, slab, &list);
>  
> -	spin_unlock(&n->list_lock);
> +	raw_spin_unlock(&n->list_lock);
>  	fixup_objfreelist_debug(cachep, &list);
>  
>  	return obj;
> @@ -2903,7 +2903,7 @@ static void *cache_alloc_refill(struct kmem_cache *cachep, gfp_t flags)
>  	if (!n->free_objects && (!shared || !shared->avail))
>  		goto direct_grow;
>  
> -	spin_lock(&n->list_lock);
> +	raw_spin_lock(&n->list_lock);
>  	shared = READ_ONCE(n->shared);
>  
>  	/* See if we can refill from the shared array */
> @@ -2927,7 +2927,7 @@ static void *cache_alloc_refill(struct kmem_cache *cachep, gfp_t flags)
>  must_grow:
>  	n->free_objects -= ac->avail;
>  alloc_done:
> -	spin_unlock(&n->list_lock);
> +	raw_spin_unlock(&n->list_lock);
>  	fixup_objfreelist_debug(cachep, &list);
>  
>  direct_grow:
> @@ -3147,7 +3147,7 @@ static void *____cache_alloc_node(struct kmem_cache *cachep, gfp_t flags,
>  	BUG_ON(!n);
>  
>  	check_irq_off();
> -	spin_lock(&n->list_lock);
> +	raw_spin_lock(&n->list_lock);
>  	slab = get_first_slab(n, false);
>  	if (!slab)
>  		goto must_grow;
> @@ -3165,12 +3165,12 @@ static void *____cache_alloc_node(struct kmem_cache *cachep, gfp_t flags,
>  
>  	fixup_slab_list(cachep, n, slab, &list);
>  
> -	spin_unlock(&n->list_lock);
> +	raw_spin_unlock(&n->list_lock);
>  	fixup_objfreelist_debug(cachep, &list);
>  	return obj;
>  
>  must_grow:
> -	spin_unlock(&n->list_lock);
> +	raw_spin_unlock(&n->list_lock);
>  	slab = cache_grow_begin(cachep, gfp_exact_node(flags), nodeid);
>  	if (slab) {
>  		/* This slab isn't counted yet so don't update free_objects */
> @@ -3325,7 +3325,7 @@ static void cache_flusharray(struct kmem_cache *cachep, struct array_cache *ac)
>  
>  	check_irq_off();
>  	n = get_node(cachep, node);
> -	spin_lock(&n->list_lock);
> +	raw_spin_lock(&n->list_lock);
>  	if (n->shared) {
>  		struct array_cache *shared_array = n->shared;
>  		int max = shared_array->limit - shared_array->avail;
> @@ -3354,7 +3354,7 @@ static void cache_flusharray(struct kmem_cache *cachep, struct array_cache *ac)
>  		STATS_SET_FREEABLE(cachep, i);
>  	}
>  #endif
> -	spin_unlock(&n->list_lock);
> +	raw_spin_unlock(&n->list_lock);
>  	ac->avail -= batchcount;
>  	memmove(ac->entry, &(ac->entry[batchcount]), sizeof(void *)*ac->avail);
>  	slabs_destroy(cachep, &list);
> @@ -3721,9 +3721,9 @@ static int do_tune_cpucache(struct kmem_cache *cachep, int limit,
>  
>  		node = cpu_to_mem(cpu);
>  		n = get_node(cachep, node);
> -		spin_lock_irq(&n->list_lock);
> +		raw_spin_lock_irq(&n->list_lock);
>  		free_block(cachep, ac->entry, ac->avail, node, &list);
> -		spin_unlock_irq(&n->list_lock);
> +		raw_spin_unlock_irq(&n->list_lock);
>  		slabs_destroy(cachep, &list);
>  	}
>  	free_percpu(prev);
> @@ -3815,9 +3815,9 @@ static void drain_array(struct kmem_cache *cachep, struct kmem_cache_node *n,
>  		return;
>  	}
>  
> -	spin_lock_irq(&n->list_lock);
> +	raw_spin_lock_irq(&n->list_lock);
>  	drain_array_locked(cachep, ac, node, false, &list);
> -	spin_unlock_irq(&n->list_lock);
> +	raw_spin_unlock_irq(&n->list_lock);
>  
>  	slabs_destroy(cachep, &list);
>  }
> @@ -3901,7 +3901,7 @@ void get_slabinfo(struct kmem_cache *cachep, struct slabinfo *sinfo)
>  
>  	for_each_kmem_cache_node(cachep, node, n) {
>  		check_irq_on();
> -		spin_lock_irq(&n->list_lock);
> +		raw_spin_lock_irq(&n->list_lock);
>  
>  		total_slabs += n->total_slabs;
>  		free_slabs += n->free_slabs;
> @@ -3910,7 +3910,7 @@ void get_slabinfo(struct kmem_cache *cachep, struct slabinfo *sinfo)
>  		if (n->shared)
>  			shared_avail += n->shared->avail;
>  
> -		spin_unlock_irq(&n->list_lock);
> +		raw_spin_unlock_irq(&n->list_lock);
>  	}
>  	num_objs = total_slabs * cachep->num;
>  	active_slabs = total_slabs - free_slabs;
> diff --git a/mm/slab.h b/mm/slab.h
> index 0202a8c2f0d2..7a705e4228c8 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -750,7 +750,11 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s,
>   * The slab lists for all objects.
>   */
>  struct kmem_cache_node {
> +#ifdef CONFIG_SLAB
> +	raw_spinlock_t list_lock;
> +#else
>  	spinlock_t list_lock;
> +#endif
>  
>  #ifdef CONFIG_SLAB
>  	struct list_head slabs_partial;	/* partial list first, better asm code */
> -- 
> 2.35.3
> 

-- 
Thanks,
Hyeonggon

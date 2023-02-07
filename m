Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94A468DBF8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 15:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjBGOqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 09:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbjBGOpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 09:45:51 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821E45256
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 06:45:45 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3D9EA3F8A8;
        Tue,  7 Feb 2023 14:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675781144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ak0zPlnrhcJqHoBUK8MEzahKJtWUsuuiq7etwv8Xy7U=;
        b=Wg9V7+NKAEdQU7v0+NeTI3v1Cu+GWJ4fXyMdAQACEaLsor4mMhNoP4Gr5HoNBchMywqvXD
        O9KarzgHadHPPOQdq/Lcs4X0wChm6aVLZHKOjmc9t9nDM321c4i2N9iGpv1RuJ8gpCQ/uC
        gT6YHCLXKt2zjsc3oLWF/bucsNcVyAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675781144;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ak0zPlnrhcJqHoBUK8MEzahKJtWUsuuiq7etwv8Xy7U=;
        b=PQGfsGAEYgd7yfR/RmFJiaFsyWnHU06b3o+mvLCldCoGGhGo8AxIPQp4amwb2Cl14RcURJ
        TU8FQQ+GNQ9B13AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E4CA913467;
        Tue,  7 Feb 2023 14:45:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /somNxdk4mMDFwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 07 Feb 2023 14:45:43 +0000
Message-ID: <6c0b681e-97bc-d975-a8b9-500abdaaf0bc@suse.cz>
Date:   Tue, 7 Feb 2023 15:45:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: mm, slab/slub: Ensure kmem_cache_alloc_bulk() is available early
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        kernel test robot <oliver.sang@intel.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mm@kvack.org, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
References: <202302011308.f53123d2-oliver.sang@intel.com>
 <87o7qdzfay.ffs@tglx> <9a682773-df56-f36c-f582-e8eeef55d7f8@suse.cz>
 <875ycdwyx6.ffs@tglx> <871qn1wofe.ffs@tglx>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <871qn1wofe.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/23 15:16, Thomas Gleixner wrote:
> The memory allocators are available during early boot even in the phase
> where interrupts are disabled and scheduling is not yet possible.
> 
> The setup is so that GFP_KERNEL allocations work in this phase without
> causing might_alloc() splats to be emitted because the system state is
> SYSTEM_BOOTING at that point which prevents the warnings to trigger.
> 
> Most allocation/free functions use local_irq_save()/restore() or a lock
> variant of that. But kmem_cache_alloc_bulk() and kmem_cache_free_bulk() use
> local_[lock]_irq_disable()/enable(), which leads to a lockdep warning when
> interrupts are enabled during the early boot phase.
> 
> This went unnoticed so far as there are no early users of these
> interfaces. The upcoming conversion of the interrupt descriptor store from
> radix_tree to maple_tree triggered this warning as maple_tree uses the bulk
> interface.
> 
> Cure this by moving the kmem_cache_alloc/free() bulk variants of SLUB and
> SLAB to local[_lock]_irq_save()/restore().
> 
> There is obviously no reclaim possible and required at this point so there
> is no need to expand this coverage further.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

+Cc rest of slab folks

Thanks, added to slab/for-6.3/fixes

> ---
> Initial version: https://lore.kernel.org/r/87o7qdzfay.ffs@tglx
> Changes: Update SLAB as well and add changelog
> ---
>  mm/slab.c |   18 ++++++++++--------
>  mm/slub.c |    9 +++++----
>  2 files changed, 15 insertions(+), 12 deletions(-)
> 
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -3479,14 +3479,15 @@ cache_alloc_debugcheck_after_bulk(struct
>  int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
>  			  void **p)
>  {
> -	size_t i;
>  	struct obj_cgroup *objcg = NULL;
> +	unsigned long irqflags;
> +	size_t i;
>  
>  	s = slab_pre_alloc_hook(s, NULL, &objcg, size, flags);
>  	if (!s)
>  		return 0;
>  
> -	local_irq_disable();
> +	local_irq_save(irqflags);
>  	for (i = 0; i < size; i++) {
>  		void *objp = kfence_alloc(s, s->object_size, flags) ?:
>  			     __do_cache_alloc(s, flags, NUMA_NO_NODE);
> @@ -3495,7 +3496,7 @@ int kmem_cache_alloc_bulk(struct kmem_ca
>  			goto error;
>  		p[i] = objp;
>  	}
> -	local_irq_enable();
> +	local_irq_restore(irqflags);
>  
>  	cache_alloc_debugcheck_after_bulk(s, flags, size, p, _RET_IP_);
>  
> @@ -3508,7 +3509,7 @@ int kmem_cache_alloc_bulk(struct kmem_ca
>  	/* FIXME: Trace call missing. Christoph would like a bulk variant */
>  	return size;
>  error:
> -	local_irq_enable();
> +	local_irq_restore(irqflags);
>  	cache_alloc_debugcheck_after_bulk(s, flags, i, p, _RET_IP_);
>  	slab_post_alloc_hook(s, objcg, flags, i, p, false, s->object_size);
>  	kmem_cache_free_bulk(s, i, p);
> @@ -3610,8 +3611,9 @@ EXPORT_SYMBOL(kmem_cache_free);
>  
>  void kmem_cache_free_bulk(struct kmem_cache *orig_s, size_t size, void **p)
>  {
> +	unsigned long flags;
>  
> -	local_irq_disable();
> +	local_irq_save(flags);
>  	for (int i = 0; i < size; i++) {
>  		void *objp = p[i];
>  		struct kmem_cache *s;
> @@ -3621,9 +3623,9 @@ void kmem_cache_free_bulk(struct kmem_ca
>  
>  			/* called via kfree_bulk */
>  			if (!folio_test_slab(folio)) {
> -				local_irq_enable();
> +				local_irq_restore(flags);
>  				free_large_kmalloc(folio, objp);
> -				local_irq_disable();
> +				local_irq_save(flags);
>  				continue;
>  			}
>  			s = folio_slab(folio)->slab_cache;
> @@ -3640,7 +3642,7 @@ void kmem_cache_free_bulk(struct kmem_ca
>  
>  		__cache_free(s, objp, _RET_IP_);
>  	}
> -	local_irq_enable();
> +	local_irq_restore(flags);
>  
>  	/* FIXME: add tracing */
>  }
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3913,6 +3913,7 @@ static inline int __kmem_cache_alloc_bul
>  			size_t size, void **p, struct obj_cgroup *objcg)
>  {
>  	struct kmem_cache_cpu *c;
> +	unsigned long irqflags;
>  	int i;
>  
>  	/*
> @@ -3921,7 +3922,7 @@ static inline int __kmem_cache_alloc_bul
>  	 * handlers invoking normal fastpath.
>  	 */
>  	c = slub_get_cpu_ptr(s->cpu_slab);
> -	local_lock_irq(&s->cpu_slab->lock);
> +	local_lock_irqsave(&s->cpu_slab->lock, irqflags);
>  
>  	for (i = 0; i < size; i++) {
>  		void *object = kfence_alloc(s, s->object_size, flags);
> @@ -3942,7 +3943,7 @@ static inline int __kmem_cache_alloc_bul
>  			 */
>  			c->tid = next_tid(c->tid);
>  
> -			local_unlock_irq(&s->cpu_slab->lock);
> +			local_unlock_irqrestore(&s->cpu_slab->lock, irqflags);
>  
>  			/*
>  			 * Invoking slow path likely have side-effect
> @@ -3956,7 +3957,7 @@ static inline int __kmem_cache_alloc_bul
>  			c = this_cpu_ptr(s->cpu_slab);
>  			maybe_wipe_obj_freeptr(s, p[i]);
>  
> -			local_lock_irq(&s->cpu_slab->lock);
> +			local_lock_irqsave(&s->cpu_slab->lock, irqflags);
>  
>  			continue; /* goto for-loop */
>  		}
> @@ -3965,7 +3966,7 @@ static inline int __kmem_cache_alloc_bul
>  		maybe_wipe_obj_freeptr(s, p[i]);
>  	}
>  	c->tid = next_tid(c->tid);
> -	local_unlock_irq(&s->cpu_slab->lock);
> +	local_unlock_irqrestore(&s->cpu_slab->lock, irqflags);
>  	slub_put_cpu_ptr(s->cpu_slab);
>  
>  	return i;


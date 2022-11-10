Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E976E624640
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 16:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbiKJPpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 10:45:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbiKJPpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 10:45:02 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9522CDCF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 07:45:01 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2965F2298A;
        Thu, 10 Nov 2022 15:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668095100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rE+02xU6mztiIRlwXx9oBSZM5mpBJgWeTTExeZCwG8s=;
        b=GxqOHHb/PQKonIObK+ADmxb7IvkwKMn2GQgyzO3SOVEmBbROQ6qoM6NKofAYpHnvkPrdSP
        KUgf5or/HZRIKMPd/Ru/jyx2vQVQnDdKMGnYwgvo858W0qmjQcN8S7cdesyLcbHKvfqQwB
        J+//lhL/SkR2fVt7SniJiltiNpEjhcc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668095100;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rE+02xU6mztiIRlwXx9oBSZM5mpBJgWeTTExeZCwG8s=;
        b=81vH4Gs98j6sGOvgU0b4rRXQi1YzWvNWt7kekC929uP3TqOS7jJYB5uR/zFxEsI5gNszza
        3PxGULq6kctcAQAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EEC6813B58;
        Thu, 10 Nov 2022 15:44:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lyeYOXscbWOqUAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 10 Nov 2022 15:44:59 +0000
Message-ID: <eaf74c95-6641-8785-61f6-c7013c2f55eb@suse.cz>
Date:   Thu, 10 Nov 2022 16:44:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v7 1/3] mm/slub: only zero requested size of buffer for
 kzalloc when debug enabled
Content-Language: en-US
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>
References: <20221021032405.1825078-1-feng.tang@intel.com>
 <20221021032405.1825078-2-feng.tang@intel.com>
 <09074855-f0ee-8e4f-a190-4fad583953c3@suse.cz> <Y2xuAiZD9IEMwkSh@feng-clx>
 <Y2z1M4zc2Re5Fsdl@feng-clx>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Y2z1M4zc2Re5Fsdl@feng-clx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/22 13:57, Feng Tang wrote:
> On Thu, Nov 10, 2022 at 11:20:34AM +0800, Tang, Feng wrote:
>> On Wed, Nov 09, 2022 at 03:28:19PM +0100, Vlastimil Babka wrote:
> [...]
>> > > +	/*
>> > > +	 * For kmalloc object, the allocated memory size(object_size) is likely
>> > > +	 * larger than the requested size(orig_size). If redzone check is
>> > > +	 * enabled for the extra space, don't zero it, as it will be redzoned
>> > > +	 * soon. The redzone operation for this extra space could be seen as a
>> > > +	 * replacement of current poisoning under certain debug option, and
>> > > +	 * won't break other sanity checks.
>> > > +	 */
>> > > +	if (kmem_cache_debug_flags(s, SLAB_STORE_USER) &&
>> > 
>> > Shouldn't we check SLAB_RED_ZONE instead? Otherwise a debugging could be
>> > specified so that SLAB_RED_ZONE is set but SLAB_STORE_USER?
>> 
>> Thanks for the catch!
>> 
>> I will add check for SLAB_RED_ZONE. The SLAB_STORE_USER is for
>> checking whether 'orig_size' field exists. In earlier discussion,
>> we make 'orig_size' depend on STORE_USER, https://lore.kernel.org/lkml/1b0fa66c-f855-1c00-e024-b2b823b18678@suse.cz/ 
> 
> Below is the updated patch, please review, thanks! 

Thanks, grabbing it including Andrey's review, with a small change below:

> - Feng
> 
> -----8>----
> From b2a92f0c2518ef80fcda340f1ad37b418ee32d85 Mon Sep 17 00:00:00 2001
> From: Feng Tang <feng.tang@intel.com>
> Date: Thu, 20 Oct 2022 20:47:31 +0800
> Subject: [PATCH 1/3] mm/slub: only zero requested size of buffer for kzalloc
>  when debug enabled
> 
> kzalloc/kmalloc will round up the request size to a fixed size
> (mostly power of 2), so the allocated memory could be more than
> requested. Currently kzalloc family APIs will zero all the
> allocated memory.
> 
> To detect out-of-bound usage of the extra allocated memory, only
> zero the requested part, so that redzone sanity check could be
> added to the extra space later.
> 
> For kzalloc users who will call ksize() later and utilize this
> extra space, please be aware that the space is not zeroed any
> more when debug is enabled. (Thanks to Kees Cook's effort to
> sanitize all ksize() user cases [1], this won't be a big issue).
> 
> [1]. https://lore.kernel.org/all/20220922031013.2150682-1-keescook@chromium.org/#r
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> Acked-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> ---
>  mm/slab.c |  7 ++++---
>  mm/slab.h | 19 +++++++++++++++++--
>  mm/slub.c | 10 +++++++---
>  3 files changed, 28 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index 4b265174b6d5..1eddec4a50e4 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -3258,7 +3258,8 @@ slab_alloc_node(struct kmem_cache *cachep, struct list_lru *lru, gfp_t flags,
>  	init = slab_want_init_on_alloc(flags, cachep);
>  
>  out:
> -	slab_post_alloc_hook(cachep, objcg, flags, 1, &objp, init);
> +	slab_post_alloc_hook(cachep, objcg, flags, 1, &objp, init,
> +				cachep->object_size);
>  	return objp;
>  }
>  
> @@ -3511,13 +3512,13 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
>  	 * Done outside of the IRQ disabled section.
>  	 */
>  	slab_post_alloc_hook(s, objcg, flags, size, p,
> -				slab_want_init_on_alloc(flags, s));
> +			slab_want_init_on_alloc(flags, s), s->object_size);
>  	/* FIXME: Trace call missing. Christoph would like a bulk variant */
>  	return size;
>  error:
>  	local_irq_enable();
>  	cache_alloc_debugcheck_after_bulk(s, flags, i, p, _RET_IP_);
> -	slab_post_alloc_hook(s, objcg, flags, i, p, false);
> +	slab_post_alloc_hook(s, objcg, flags, i, p, false, s->object_size);
>  	kmem_cache_free_bulk(s, i, p);
>  	return 0;
>  }
> diff --git a/mm/slab.h b/mm/slab.h
> index 8c4aafb00bd6..2551214392c7 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -730,12 +730,27 @@ static inline struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
>  
>  static inline void slab_post_alloc_hook(struct kmem_cache *s,
>  					struct obj_cgroup *objcg, gfp_t flags,
> -					size_t size, void **p, bool init)
> +					size_t size, void **p, bool init,
> +					unsigned int orig_size)
>  {
> +	unsigned int zero_size = s->object_size;
>  	size_t i;
>  
>  	flags &= gfp_allowed_mask;
>  
> +	/*
> +	 * For kmalloc object, the allocated memory size(object_size) is likely
> +	 * larger than the requested size(orig_size). If redzone check is
> +	 * enabled for the extra space, don't zero it, as it will be redzoned
> +	 * soon. The redzone operation for this extra space could be seen as a
> +	 * replacement of current poisoning under certain debug option, and
> +	 * won't break other sanity checks.
> +	 */
> +	if (kmem_cache_debug_flags(s, SLAB_STORE_USER) &&
> +	    (s->flags & SLAB_RED_ZONE) &&

Combined the two above to:

  if (kmem_cache_debug_flags(s, SLAB_STORE_USER | SLAB_RED_ZONE)

> +	    (s->flags & SLAB_KMALLOC))
> +		zero_size = orig_size;
> +
>  	/*
>  	 * As memory initialization might be integrated into KASAN,
>  	 * kasan_slab_alloc and initialization memset must be
> @@ -746,7 +761,7 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s,
>  	for (i = 0; i < size; i++) {
>  		p[i] = kasan_slab_alloc(s, p[i], flags, init);
>  		if (p[i] && init && !kasan_has_integrated_init())
> -			memset(p[i], 0, s->object_size);
> +			memset(p[i], 0, zero_size);
>  		kmemleak_alloc_recursive(p[i], s->object_size, 1,
>  					 s->flags, flags);
>  		kmsan_slab_alloc(s, p[i], flags);
> diff --git a/mm/slub.c b/mm/slub.c
> index 0a14e7bc278c..13490f317f5f 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3387,7 +3387,11 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s, struct list_l
>  	init = slab_want_init_on_alloc(gfpflags, s);
>  
>  out:
> -	slab_post_alloc_hook(s, objcg, gfpflags, 1, &object, init);
> +	/*
> +	 * When init equals 'true', like for kzalloc() family, only
> +	 * @orig_size bytes might be zeroed instead of s->object_size
> +	 */
> +	slab_post_alloc_hook(s, objcg, gfpflags, 1, &object, init, orig_size);
>  
>  	return object;
>  }
> @@ -3844,11 +3848,11 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
>  	 * Done outside of the IRQ disabled fastpath loop.
>  	 */
>  	slab_post_alloc_hook(s, objcg, flags, size, p,
> -				slab_want_init_on_alloc(flags, s));
> +			slab_want_init_on_alloc(flags, s), s->object_size);
>  	return i;
>  error:
>  	slub_put_cpu_ptr(s->cpu_slab);
> -	slab_post_alloc_hook(s, objcg, flags, i, p, false);
> +	slab_post_alloc_hook(s, objcg, flags, i, p, false, s->object_size);
>  	kmem_cache_free_bulk(s, i, p);
>  	return 0;
>  }


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65CC16D3668
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 11:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjDBJJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 05:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjDBJJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 05:09:27 -0400
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0554DC171
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 02:09:20 -0700 (PDT)
X-QQ-mid: bizesmtp74t1680426555tavq7y8x
Received: from [10.7.13.112] ( [113.200.76.118])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 02 Apr 2023 17:09:14 +0800 (CST)
X-QQ-SSF: 01400000002000D0G000B00A0000000
X-QQ-FEAT: LrCnY+iDm+N5JFq4OQa8f024xVVuZWciawDh7GgyI3hl7iVz/jq0+PT6/woAh
        leh99tpIBZgI0Z49xzGQcMmmEsYjllcFx6QrEBrF39PUlQ7smHbmkIkUovxUgkxXE/yC2iq
        OeoqEGpgwhE1QmfdHh0ivWM4CkrawALmLWMJR+D/+dfG/ijjhNDeWN9XtKXGQP5TwvpS3BF
        pCn9KwyfHOHOvPkrJMNq5iDd1/PgQLcmWzhGZ1dGgwpYevGAkFjLTPrwhUNVtPqCCdT99fO
        K4CtzpJp4akE8IotPtFnvei3YUNie3LDqigiRsKnfX1Ci11D78sRH38acR3SoTWi35mywV0
        uGXeZbPBqYltV8lpYNW8HadgA7j7CU7hfZnImOz/pvHGCf5xbS3QaLGsBUM39Y9zGykD8q1
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 1934558415376295422
Subject: Re: [PATCH] mm: remove all the slab allocators
To:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev
References: <20230401094658.11146-1-vbabka@suse.cz>
From:   =?UTF-8?B?6YOt6L6J?= <guohui@uniontech.com>
Message-ID: <D9446192D1350A06+edeebc7d-b55d-571e-ef25-98ecb9d2662b@uniontech.com>
Date:   Sun, 2 Apr 2023 17:09:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20230401094658.11146-1-vbabka@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-0.8 required=5.0 tests=FORGED_MUA_MOZILLA,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/23 5:46 PM, Vlastimil Babka wrote:

> As the SLOB removal is on track and the SLAB removal is planned, I have
> realized - why should we stop there and not remove also SLUB? What's a
> slab allocator good for in 2023? The RAM sizes are getting larger and
> the modules cheaper [1]. The object constructor trick was perhaps
> interesting in 1994, but not with contemporary CPUs. So all the slab
> allocator does today is just adding an unnecessary layer of complexity
> over the page allocator.
>
> Thus, with this patch, all three slab allocators are removed, and only a
> layer that passes everything to the page allocator remains in the slab.h
> and mm/slab_common.c files. This will allow users to gradually
> transition away and use the page allocator directly. To summarize the
> advantages:
>
> - Less code to maintain: over 13k lines are removed by this patch, and
>    more could be removed if I wast^Wspent more time on this, and later as
>    users are transitioned from the legacy layer. This no longer needs a
>    separate subsystem so remove it from MAINTAINERS (I hope I can keep the
>    kernel.org account anyway, though).
>
> - Simplified MEMCG_KMEM accounting: while I was lazy and just marked it
>    BROKEN in this patch, it should be trivial to use the page memcg
>    accounting now that we use the page allocator. The per-object
>    accounting went through several iterations in the past and was always
>    complex and added overhead. Page accounting is much simpler by
>    comparison.
>
> - Simplified KASAN and friends: also was lazy in this patch so they
>    can't be enabled but should be easy to fix up and work just on the
>    page level.
>
> - Simpler debugging: just use debug_pagealloc=on, no need to look up the
>    exact syntax of the absurdly complex slub_debug parameter.
>
> - Speed: didn't measure, but for the page allocator we have pcplists, so
>    it should scale just fine. No need for the crazy SLUB's cmpxchg_double()
>    craziness. Maybe that thing could be now removed too? Yeah I can see
>    just two remaining users.
>
> Any downsides? Let's look at memory usage after virtme boot:
>
> Before (with SLUB):
> Slab:              26304 kB
>
> After:
> Slab:             295592 kB
>
> Well, that's not so bad, see [1].
>
> [1] https://www.theregister.com/2023/03/29/dram_prices_crash/
> ---
>   MAINTAINERS              |   15 -
>   include/linux/slab.h     |  211 +-
>   include/linux/slab_def.h |  124 -
>   include/linux/slub_def.h |  198 --
>   init/Kconfig             |    2 +-
>   mm/Kconfig               |  134 +-
>   mm/Makefile              |   10 -
>   mm/slab.c                | 4046 ------------------------
>   mm/slab.h                |  426 ---
>   mm/slab_common.c         |  876 ++---
>   mm/slob.c                |  757 -----
>   mm/slub.c                | 6506 --------------------------------------
>   12 files changed, 228 insertions(+), 13077 deletions(-)
>   delete mode 100644 include/linux/slab_def.h
>   delete mode 100644 include/linux/slub_def.h
>   delete mode 100644 mm/slab.c
>   delete mode 100644 mm/slob.c
>   delete mode 100644 mm/slub.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1dc8bd26b6cf..40b05ad03cd0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19183,21 +19183,6 @@ F:	drivers/irqchip/irq-sl28cpld.c
>   F:	drivers/pwm/pwm-sl28cpld.c
>   F:	drivers/watchdog/sl28cpld_wdt.c
>   
> -SLAB ALLOCATOR
> -M:	Christoph Lameter <cl@linux.com>
> -M:	Pekka Enberg <penberg@kernel.org>
> -M:	David Rientjes <rientjes@google.com>
> -M:	Joonsoo Kim <iamjoonsoo.kim@lge.com>
> -M:	Andrew Morton <akpm@linux-foundation.org>
> -M:	Vlastimil Babka <vbabka@suse.cz>
> -R:	Roman Gushchin <roman.gushchin@linux.dev>
> -R:	Hyeonggon Yoo <42.hyeyoo@gmail.com>
> -L:	linux-mm@kvack.org
> -S:	Maintained
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git
> -F:	include/linux/sl?b*.h
> -F:	mm/sl?b*
> -
>   SLCAN CAN NETWORK DRIVER
>   M:	Dario Binacchi <dario.binacchi@amarulasolutions.com>
>   L:	linux-can@vger.kernel.org
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 45af70315a94..61602d54b1d0 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -140,13 +140,14 @@
>   
>   /* The following flags affect the page allocator grouping pages by mobility */
>   /* Objects are reclaimable */
> -#ifndef CONFIG_SLUB_TINY
>   #define SLAB_RECLAIM_ACCOUNT	((slab_flags_t __force)0x00020000U)
> -#else
> -#define SLAB_RECLAIM_ACCOUNT	((slab_flags_t __force)0)
> -#endif
>   #define SLAB_TEMPORARY		SLAB_RECLAIM_ACCOUNT	/* Objects are short-lived */
>   
> +#define KMALLOC_NOT_NORMAL_BITS					\
> +	(__GFP_RECLAIMABLE |					\
> +	(IS_ENABLED(CONFIG_ZONE_DMA)   ? __GFP_DMA : 0) |	\
> +	(IS_ENABLED(CONFIG_MEMCG_KMEM) ? __GFP_ACCOUNT : 0))
> +
>   /*
>    * ZERO_SIZE_PTR will be returned for zero sized kmalloc requests.
>    *
> @@ -278,38 +279,11 @@ static inline unsigned int arch_slab_minalign(void)
>    * Kmalloc array related definitions
>    */
>   
> -#ifdef CONFIG_SLAB
> -/*
> - * SLAB and SLUB directly allocates requests fitting in to an order-1 page
> - * (PAGE_SIZE*2).  Larger requests are passed to the page allocator.
> - */
> -#define KMALLOC_SHIFT_HIGH	(PAGE_SHIFT + 1)
> -#define KMALLOC_SHIFT_MAX	(MAX_ORDER + PAGE_SHIFT - 1)
> -#ifndef KMALLOC_SHIFT_LOW
> -#define KMALLOC_SHIFT_LOW	5
> -#endif
> -#endif
> -
> -#ifdef CONFIG_SLUB
> -#define KMALLOC_SHIFT_HIGH	(PAGE_SHIFT + 1)
> -#define KMALLOC_SHIFT_MAX	(MAX_ORDER + PAGE_SHIFT - 1)
> -#ifndef KMALLOC_SHIFT_LOW
> -#define KMALLOC_SHIFT_LOW	3
> -#endif
> -#endif
> -
> -#ifdef CONFIG_SLOB
> -/*
> - * SLOB passes all requests larger than one page to the page allocator.
> - * No kmalloc array is necessary since objects of different sizes can
> - * be allocated from the same page.
> - */
>   #define KMALLOC_SHIFT_HIGH	PAGE_SHIFT
>   #define KMALLOC_SHIFT_MAX	(MAX_ORDER + PAGE_SHIFT - 1)
>   #ifndef KMALLOC_SHIFT_LOW
>   #define KMALLOC_SHIFT_LOW	3
>   #endif
> -#endif
>   
>   /* Maximum allocatable size */
>   #define KMALLOC_MAX_SIZE	(1UL << KMALLOC_SHIFT_MAX)
> @@ -336,130 +310,6 @@ static inline unsigned int arch_slab_minalign(void)
>   #define SLAB_OBJ_MIN_SIZE      (KMALLOC_MIN_SIZE < 16 ? \
>                                  (KMALLOC_MIN_SIZE) : 16)
>   
> -/*
> - * Whenever changing this, take care of that kmalloc_type() and
> - * create_kmalloc_caches() still work as intended.
> - *
> - * KMALLOC_NORMAL can contain only unaccounted objects whereas KMALLOC_CGROUP
> - * is for accounted but unreclaimable and non-dma objects. All the other
> - * kmem caches can have both accounted and unaccounted objects.
> - */
> -enum kmalloc_cache_type {
> -	KMALLOC_NORMAL = 0,
> -#ifndef CONFIG_ZONE_DMA
> -	KMALLOC_DMA = KMALLOC_NORMAL,
> -#endif
> -#ifndef CONFIG_MEMCG_KMEM
> -	KMALLOC_CGROUP = KMALLOC_NORMAL,
> -#endif
> -#ifdef CONFIG_SLUB_TINY
> -	KMALLOC_RECLAIM = KMALLOC_NORMAL,
> -#else
> -	KMALLOC_RECLAIM,
> -#endif
> -#ifdef CONFIG_ZONE_DMA
> -	KMALLOC_DMA,
> -#endif
> -#ifdef CONFIG_MEMCG_KMEM
> -	KMALLOC_CGROUP,
> -#endif
> -	NR_KMALLOC_TYPES
> -};
> -
> -#ifndef CONFIG_SLOB
> -extern struct kmem_cache *
> -kmalloc_caches[NR_KMALLOC_TYPES][KMALLOC_SHIFT_HIGH + 1];
> -
> -/*
> - * Define gfp bits that should not be set for KMALLOC_NORMAL.
> - */
> -#define KMALLOC_NOT_NORMAL_BITS					\
> -	(__GFP_RECLAIMABLE |					\
> -	(IS_ENABLED(CONFIG_ZONE_DMA)   ? __GFP_DMA : 0) |	\
> -	(IS_ENABLED(CONFIG_MEMCG_KMEM) ? __GFP_ACCOUNT : 0))
> -
> -static __always_inline enum kmalloc_cache_type kmalloc_type(gfp_t flags)
> -{
> -	/*
> -	 * The most common case is KMALLOC_NORMAL, so test for it
> -	 * with a single branch for all the relevant flags.
> -	 */
> -	if (likely((flags & KMALLOC_NOT_NORMAL_BITS) == 0))
> -		return KMALLOC_NORMAL;
> -
> -	/*
> -	 * At least one of the flags has to be set. Their priorities in
> -	 * decreasing order are:
> -	 *  1) __GFP_DMA
> -	 *  2) __GFP_RECLAIMABLE
> -	 *  3) __GFP_ACCOUNT
> -	 */
> -	if (IS_ENABLED(CONFIG_ZONE_DMA) && (flags & __GFP_DMA))
> -		return KMALLOC_DMA;
> -	if (!IS_ENABLED(CONFIG_MEMCG_KMEM) || (flags & __GFP_RECLAIMABLE))
> -		return KMALLOC_RECLAIM;
> -	else
> -		return KMALLOC_CGROUP;
> -}
> -
> -/*
> - * Figure out which kmalloc slab an allocation of a certain size
> - * belongs to.
> - * 0 = zero alloc
> - * 1 =  65 .. 96 bytes
> - * 2 = 129 .. 192 bytes
> - * n = 2^(n-1)+1 .. 2^n
> - *
> - * Note: __kmalloc_index() is compile-time optimized, and not runtime optimized;
> - * typical usage is via kmalloc_index() and therefore evaluated at compile-time.
> - * Callers where !size_is_constant should only be test modules, where runtime
> - * overheads of __kmalloc_index() can be tolerated.  Also see kmalloc_slab().
> - */
> -static __always_inline unsigned int __kmalloc_index(size_t size,
> -						    bool size_is_constant)
> -{
> -	if (!size)
> -		return 0;
> -
> -	if (size <= KMALLOC_MIN_SIZE)
> -		return KMALLOC_SHIFT_LOW;
> -
> -	if (KMALLOC_MIN_SIZE <= 32 && size > 64 && size <= 96)
> -		return 1;
> -	if (KMALLOC_MIN_SIZE <= 64 && size > 128 && size <= 192)
> -		return 2;
> -	if (size <=          8) return 3;
> -	if (size <=         16) return 4;
> -	if (size <=         32) return 5;
> -	if (size <=         64) return 6;
> -	if (size <=        128) return 7;
> -	if (size <=        256) return 8;
> -	if (size <=        512) return 9;
> -	if (size <=       1024) return 10;
> -	if (size <=   2 * 1024) return 11;
> -	if (size <=   4 * 1024) return 12;
> -	if (size <=   8 * 1024) return 13;
> -	if (size <=  16 * 1024) return 14;
> -	if (size <=  32 * 1024) return 15;
> -	if (size <=  64 * 1024) return 16;
> -	if (size <= 128 * 1024) return 17;
> -	if (size <= 256 * 1024) return 18;
> -	if (size <= 512 * 1024) return 19;
> -	if (size <= 1024 * 1024) return 20;
> -	if (size <=  2 * 1024 * 1024) return 21;
> -
> -	if (!IS_ENABLED(CONFIG_PROFILE_ALL_BRANCHES) && size_is_constant)
> -		BUILD_BUG_ON_MSG(1, "unexpected size in kmalloc_index()");
> -	else
> -		BUG();
> -
> -	/* Will never be reached. Needed because the compiler may complain */
> -	return -1;
> -}
> -static_assert(PAGE_SHIFT <= 20);
> -#define kmalloc_index(s) __kmalloc_index(s, true)
> -#endif /* !CONFIG_SLOB */
> -
>   void *__kmalloc(size_t size, gfp_t flags) __assume_kmalloc_alignment __alloc_size(1);
>   
>   /**
> @@ -567,57 +417,15 @@ void *kmalloc_large_node(size_t size, gfp_t flags, int node) __assume_page_align
>    *	Try really hard to succeed the allocation but fail
>    *	eventually.
>    */
> -#ifndef CONFIG_SLOB
> -static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
> -{
> -	if (__builtin_constant_p(size) && size) {
> -		unsigned int index;
> -
> -		if (size > KMALLOC_MAX_CACHE_SIZE)
> -			return kmalloc_large(size, flags);
> -
> -		index = kmalloc_index(size);
> -		return kmalloc_trace(
> -				kmalloc_caches[kmalloc_type(flags)][index],
> -				flags, size);
> -	}
> -	return __kmalloc(size, flags);
> -}
> -#else
>   static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
>   {
> -	if (__builtin_constant_p(size) && size > KMALLOC_MAX_CACHE_SIZE)
> -		return kmalloc_large(size, flags);
> -
> -	return __kmalloc(size, flags);
> +	return kmalloc_large(size, flags);
>   }
> -#endif
>   
> -#ifndef CONFIG_SLOB
>   static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t flags, int node)
>   {
> -	if (__builtin_constant_p(size) && size) {
> -		unsigned int index;
> -
> -		if (size > KMALLOC_MAX_CACHE_SIZE)
> -			return kmalloc_large_node(size, flags, node);
> -
> -		index = kmalloc_index(size);
> -		return kmalloc_node_trace(
> -				kmalloc_caches[kmalloc_type(flags)][index],
> -				flags, node, size);
> -	}
> -	return __kmalloc_node(size, flags, node);
> +	return kmalloc_large_node(size, flags, node);
>   }
> -#else
> -static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t flags, int node)
> -{
> -	if (__builtin_constant_p(size) && size > KMALLOC_MAX_CACHE_SIZE)
> -		return kmalloc_large_node(size, flags, node);
> -
> -	return __kmalloc_node(size, flags, node);
> -}
> -#endif
>   
>   /**
>    * kmalloc_array - allocate memory for an array.
> @@ -785,12 +593,7 @@ size_t kmalloc_size_roundup(size_t size);
>   
>   void __init kmem_cache_init_late(void);
>   
> -#if defined(CONFIG_SMP) && defined(CONFIG_SLAB)
> -int slab_prepare_cpu(unsigned int cpu);
> -int slab_dead_cpu(unsigned int cpu);
> -#else
>   #define slab_prepare_cpu	NULL
>   #define slab_dead_cpu		NULL
> -#endif
>   
>   #endif	/* _LINUX_SLAB_H */
> diff --git a/include/linux/slab_def.h b/include/linux/slab_def.h
> deleted file mode 100644
> index a61e7d55d0d3..000000000000
> --- a/include/linux/slab_def.h
> +++ /dev/null
> @@ -1,124 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _LINUX_SLAB_DEF_H
> -#define	_LINUX_SLAB_DEF_H
> -
> -#include <linux/kfence.h>
> -#include <linux/reciprocal_div.h>
> -
> -/*
> - * Definitions unique to the original Linux SLAB allocator.
> - */
> -
> -struct kmem_cache {
> -	struct array_cache __percpu *cpu_cache;
> -
> -/* 1) Cache tunables. Protected by slab_mutex */
> -	unsigned int batchcount;
> -	unsigned int limit;
> -	unsigned int shared;
> -
> -	unsigned int size;
> -	struct reciprocal_value reciprocal_buffer_size;
> -/* 2) touched by every alloc & free from the backend */
> -
> -	slab_flags_t flags;		/* constant flags */
> -	unsigned int num;		/* # of objs per slab */
> -
> -/* 3) cache_grow/shrink */
> -	/* order of pgs per slab (2^n) */
> -	unsigned int gfporder;
> -
> -	/* force GFP flags, e.g. GFP_DMA */
> -	gfp_t allocflags;
> -
> -	size_t colour;			/* cache colouring range */
> -	unsigned int colour_off;	/* colour offset */
> -	unsigned int freelist_size;
> -
> -	/* constructor func */
> -	void (*ctor)(void *obj);
> -
> -/* 4) cache creation/removal */
> -	const char *name;
> -	struct list_head list;
> -	int refcount;
> -	int object_size;
> -	int align;
> -
> -/* 5) statistics */
> -#ifdef CONFIG_DEBUG_SLAB
> -	unsigned long num_active;
> -	unsigned long num_allocations;
> -	unsigned long high_mark;
> -	unsigned long grown;
> -	unsigned long reaped;
> -	unsigned long errors;
> -	unsigned long max_freeable;
> -	unsigned long node_allocs;
> -	unsigned long node_frees;
> -	unsigned long node_overflow;
> -	atomic_t allochit;
> -	atomic_t allocmiss;
> -	atomic_t freehit;
> -	atomic_t freemiss;
> -
> -	/*
> -	 * If debugging is enabled, then the allocator can add additional
> -	 * fields and/or padding to every object. 'size' contains the total
> -	 * object size including these internal fields, while 'obj_offset'
> -	 * and 'object_size' contain the offset to the user object and its
> -	 * size.
> -	 */
> -	int obj_offset;
> -#endif /* CONFIG_DEBUG_SLAB */
> -
> -#ifdef CONFIG_KASAN_GENERIC
> -	struct kasan_cache kasan_info;
> -#endif
> -
> -#ifdef CONFIG_SLAB_FREELIST_RANDOM
> -	unsigned int *random_seq;
> -#endif
> -
> -#ifdef CONFIG_HARDENED_USERCOPY
> -	unsigned int useroffset;	/* Usercopy region offset */
> -	unsigned int usersize;		/* Usercopy region size */
> -#endif
> -
> -	struct kmem_cache_node *node[MAX_NUMNODES];
> -};
> -
> -static inline void *nearest_obj(struct kmem_cache *cache, const struct slab *slab,
> -				void *x)
> -{
> -	void *object = x - (x - slab->s_mem) % cache->size;
> -	void *last_object = slab->s_mem + (cache->num - 1) * cache->size;
> -
> -	if (unlikely(object > last_object))
> -		return last_object;
> -	else
> -		return object;
> -}
> -
> -/*
> - * We want to avoid an expensive divide : (offset / cache->size)
> - *   Using the fact that size is a constant for a particular cache,
> - *   we can replace (offset / cache->size) by
> - *   reciprocal_divide(offset, cache->reciprocal_buffer_size)
> - */
> -static inline unsigned int obj_to_index(const struct kmem_cache *cache,
> -					const struct slab *slab, void *obj)
> -{
> -	u32 offset = (obj - slab->s_mem);
> -	return reciprocal_divide(offset, cache->reciprocal_buffer_size);
> -}
> -
> -static inline int objs_per_slab(const struct kmem_cache *cache,
> -				     const struct slab *slab)
> -{
> -	if (is_kfence_address(slab_address(slab)))
> -		return 1;
> -	return cache->num;
> -}
> -
> -#endif	/* _LINUX_SLAB_DEF_H */
> diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
> deleted file mode 100644
> index f6df03f934e5..000000000000
> --- a/include/linux/slub_def.h
> +++ /dev/null
> @@ -1,198 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _LINUX_SLUB_DEF_H
> -#define _LINUX_SLUB_DEF_H
> -
> -/*
> - * SLUB : A Slab allocator without object queues.
> - *
> - * (C) 2007 SGI, Christoph Lameter
> - */
> -#include <linux/kfence.h>
> -#include <linux/kobject.h>
> -#include <linux/reciprocal_div.h>
> -#include <linux/local_lock.h>
> -
> -enum stat_item {
> -	ALLOC_FASTPATH,		/* Allocation from cpu slab */
> -	ALLOC_SLOWPATH,		/* Allocation by getting a new cpu slab */
> -	FREE_FASTPATH,		/* Free to cpu slab */
> -	FREE_SLOWPATH,		/* Freeing not to cpu slab */
> -	FREE_FROZEN,		/* Freeing to frozen slab */
> -	FREE_ADD_PARTIAL,	/* Freeing moves slab to partial list */
> -	FREE_REMOVE_PARTIAL,	/* Freeing removes last object */
> -	ALLOC_FROM_PARTIAL,	/* Cpu slab acquired from node partial list */
> -	ALLOC_SLAB,		/* Cpu slab acquired from page allocator */
> -	ALLOC_REFILL,		/* Refill cpu slab from slab freelist */
> -	ALLOC_NODE_MISMATCH,	/* Switching cpu slab */
> -	FREE_SLAB,		/* Slab freed to the page allocator */
> -	CPUSLAB_FLUSH,		/* Abandoning of the cpu slab */
> -	DEACTIVATE_FULL,	/* Cpu slab was full when deactivated */
> -	DEACTIVATE_EMPTY,	/* Cpu slab was empty when deactivated */
> -	DEACTIVATE_TO_HEAD,	/* Cpu slab was moved to the head of partials */
> -	DEACTIVATE_TO_TAIL,	/* Cpu slab was moved to the tail of partials */
> -	DEACTIVATE_REMOTE_FREES,/* Slab contained remotely freed objects */
> -	DEACTIVATE_BYPASS,	/* Implicit deactivation */
> -	ORDER_FALLBACK,		/* Number of times fallback was necessary */
> -	CMPXCHG_DOUBLE_CPU_FAIL,/* Failure of this_cpu_cmpxchg_double */
> -	CMPXCHG_DOUBLE_FAIL,	/* Number of times that cmpxchg double did not match */
> -	CPU_PARTIAL_ALLOC,	/* Used cpu partial on alloc */
> -	CPU_PARTIAL_FREE,	/* Refill cpu partial on free */
> -	CPU_PARTIAL_NODE,	/* Refill cpu partial from node partial */
> -	CPU_PARTIAL_DRAIN,	/* Drain cpu partial to node partial */
> -	NR_SLUB_STAT_ITEMS };
> -
> -#ifndef CONFIG_SLUB_TINY
> -/*
> - * When changing the layout, make sure freelist and tid are still compatible
> - * with this_cpu_cmpxchg_double() alignment requirements.
> - */
> -struct kmem_cache_cpu {
> -	void **freelist;	/* Pointer to next available object */
> -	unsigned long tid;	/* Globally unique transaction id */
> -	struct slab *slab;	/* The slab from which we are allocating */
> -#ifdef CONFIG_SLUB_CPU_PARTIAL
> -	struct slab *partial;	/* Partially allocated frozen slabs */
> -#endif
> -	local_lock_t lock;	/* Protects the fields above */
> -#ifdef CONFIG_SLUB_STATS
> -	unsigned stat[NR_SLUB_STAT_ITEMS];
> -#endif
> -};
> -#endif /* CONFIG_SLUB_TINY */
> -
> -#ifdef CONFIG_SLUB_CPU_PARTIAL
> -#define slub_percpu_partial(c)		((c)->partial)
> -
> -#define slub_set_percpu_partial(c, p)		\
> -({						\
> -	slub_percpu_partial(c) = (p)->next;	\
> -})
> -
> -#define slub_percpu_partial_read_once(c)     READ_ONCE(slub_percpu_partial(c))
> -#else
> -#define slub_percpu_partial(c)			NULL
> -
> -#define slub_set_percpu_partial(c, p)
> -
> -#define slub_percpu_partial_read_once(c)	NULL
> -#endif // CONFIG_SLUB_CPU_PARTIAL
> -
> -/*
> - * Word size structure that can be atomically updated or read and that
> - * contains both the order and the number of objects that a slab of the
> - * given order would contain.
> - */
> -struct kmem_cache_order_objects {
> -	unsigned int x;
> -};
> -
> -/*
> - * Slab cache management.
> - */
> -struct kmem_cache {
> -#ifndef CONFIG_SLUB_TINY
> -	struct kmem_cache_cpu __percpu *cpu_slab;
> -#endif
> -	/* Used for retrieving partial slabs, etc. */
> -	slab_flags_t flags;
> -	unsigned long min_partial;
> -	unsigned int size;	/* The size of an object including metadata */
> -	unsigned int object_size;/* The size of an object without metadata */
> -	struct reciprocal_value reciprocal_size;
> -	unsigned int offset;	/* Free pointer offset */
> -#ifdef CONFIG_SLUB_CPU_PARTIAL
> -	/* Number of per cpu partial objects to keep around */
> -	unsigned int cpu_partial;
> -	/* Number of per cpu partial slabs to keep around */
> -	unsigned int cpu_partial_slabs;
> -#endif
> -	struct kmem_cache_order_objects oo;
> -
> -	/* Allocation and freeing of slabs */
> -	struct kmem_cache_order_objects min;
> -	gfp_t allocflags;	/* gfp flags to use on each alloc */
> -	int refcount;		/* Refcount for slab cache destroy */
> -	void (*ctor)(void *);
> -	unsigned int inuse;		/* Offset to metadata */
> -	unsigned int align;		/* Alignment */
> -	unsigned int red_left_pad;	/* Left redzone padding size */
> -	const char *name;	/* Name (only for display!) */
> -	struct list_head list;	/* List of slab caches */
> -#ifdef CONFIG_SYSFS
> -	struct kobject kobj;	/* For sysfs */
> -#endif
> -#ifdef CONFIG_SLAB_FREELIST_HARDENED
> -	unsigned long random;
> -#endif
> -
> -#ifdef CONFIG_NUMA
> -	/*
> -	 * Defragmentation by allocating from a remote node.
> -	 */
> -	unsigned int remote_node_defrag_ratio;
> -#endif
> -
> -#ifdef CONFIG_SLAB_FREELIST_RANDOM
> -	unsigned int *random_seq;
> -#endif
> -
> -#ifdef CONFIG_KASAN_GENERIC
> -	struct kasan_cache kasan_info;
> -#endif
> -
> -#ifdef CONFIG_HARDENED_USERCOPY
> -	unsigned int useroffset;	/* Usercopy region offset */
> -	unsigned int usersize;		/* Usercopy region size */
> -#endif
> -
> -	struct kmem_cache_node *node[MAX_NUMNODES];
> -};
> -
> -#if defined(CONFIG_SYSFS) && !defined(CONFIG_SLUB_TINY)
> -#define SLAB_SUPPORTS_SYSFS
> -void sysfs_slab_unlink(struct kmem_cache *);
> -void sysfs_slab_release(struct kmem_cache *);
> -#else
> -static inline void sysfs_slab_unlink(struct kmem_cache *s)
> -{
> -}
> -static inline void sysfs_slab_release(struct kmem_cache *s)
> -{
> -}
> -#endif
> -
> -void *fixup_red_left(struct kmem_cache *s, void *p);
> -
> -static inline void *nearest_obj(struct kmem_cache *cache, const struct slab *slab,
> -				void *x) {
> -	void *object = x - (x - slab_address(slab)) % cache->size;
> -	void *last_object = slab_address(slab) +
> -		(slab->objects - 1) * cache->size;
> -	void *result = (unlikely(object > last_object)) ? last_object : object;
> -
> -	result = fixup_red_left(cache, result);
> -	return result;
> -}
> -
> -/* Determine object index from a given position */
> -static inline unsigned int __obj_to_index(const struct kmem_cache *cache,
> -					  void *addr, void *obj)
> -{
> -	return reciprocal_divide(kasan_reset_tag(obj) - addr,
> -				 cache->reciprocal_size);
> -}
> -
> -static inline unsigned int obj_to_index(const struct kmem_cache *cache,
> -					const struct slab *slab, void *obj)
> -{
> -	if (is_kfence_address(obj))
> -		return 0;
> -	return __obj_to_index(cache, slab_address(slab), obj);
> -}
> -
> -static inline int objs_per_slab(const struct kmem_cache *cache,
> -				     const struct slab *slab)
> -{
> -	return slab->objects;
> -}
> -#endif /* _LINUX_SLUB_DEF_H */
> diff --git a/init/Kconfig b/init/Kconfig
> index 1fb5f313d18f..45be2eedf75c 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -973,7 +973,7 @@ config MEMCG
>   
>   config MEMCG_KMEM
>   	bool
> -	depends on MEMCG && !SLOB
> +	depends on MEMCG && BROKEN
>   	default y
>   
>   config BLK_CGROUP
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 4751031f3f05..f07e81bca39e 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -210,134 +210,9 @@ config ZSMALLOC_CHAIN_SIZE
>   
>   	  For more information, see zsmalloc documentation.
>   
> -menu "SLAB allocator options"
> -
> -choice
> -	prompt "Choose SLAB allocator"
> -	default SLUB
> -	help
> -	   This option allows to select a slab allocator.
> -
> -config SLAB
> -	bool "SLAB"
> -	depends on !PREEMPT_RT
> -	select HAVE_HARDENED_USERCOPY_ALLOCATOR
> -	help
> -	  The regular slab allocator that is established and known to work
> -	  well in all environments. It organizes cache hot objects in
> -	  per cpu and per node queues.
> -
> -config SLUB
> -	bool "SLUB (Unqueued Allocator)"
> -	select HAVE_HARDENED_USERCOPY_ALLOCATOR
> -	help
> -	   SLUB is a slab allocator that minimizes cache line usage
> -	   instead of managing queues of cached objects (SLAB approach).
> -	   Per cpu caching is realized using slabs of objects instead
> -	   of queues of objects. SLUB can use memory efficiently
> -	   and has enhanced diagnostics. SLUB is the default choice for
> -	   a slab allocator.
> -
> -config SLOB_DEPRECATED
> -	depends on EXPERT
> -	bool "SLOB (Simple Allocator - DEPRECATED)"
> -	depends on !PREEMPT_RT
> -	help
> -	   Deprecated and scheduled for removal in a few cycles. SLUB
> -	   recommended as replacement. CONFIG_SLUB_TINY can be considered
> -	   on systems with 16MB or less RAM.
> -
> -	   If you need SLOB to stay, please contact linux-mm@kvack.org and
> -	   people listed in the SLAB ALLOCATOR section of MAINTAINERS file,
> -	   with your use case.
> -
> -	   SLOB replaces the stock allocator with a drastically simpler
> -	   allocator. SLOB is generally more space efficient but
> -	   does not perform as well on large systems.
> -
> -endchoice
> -
> -config SLOB
> -	bool
> -	default y
> -	depends on SLOB_DEPRECATED
> -
> -config SLUB_TINY
> -	bool "Configure SLUB for minimal memory footprint"
> -	depends on SLUB && EXPERT
> -	select SLAB_MERGE_DEFAULT
> -	help
> -	   Configures the SLUB allocator in a way to achieve minimal memory
> -	   footprint, sacrificing scalability, debugging and other features.
> -	   This is intended only for the smallest system that had used the
> -	   SLOB allocator and is not recommended for systems with more than
> -	   16MB RAM.
> -
> -	   If unsure, say N.
> -
> -config SLAB_MERGE_DEFAULT
> -	bool "Allow slab caches to be merged"
> -	default y
> -	depends on SLAB || SLUB
> -	help
> -	  For reduced kernel memory fragmentation, slab caches can be
> -	  merged when they share the same size and other characteristics.
> -	  This carries a risk of kernel heap overflows being able to
> -	  overwrite objects from merged caches (and more easily control
> -	  cache layout), which makes such heap attacks easier to exploit
> -	  by attackers. By keeping caches unmerged, these kinds of exploits
> -	  can usually only damage objects in the same cache. To disable
> -	  merging at runtime, "slab_nomerge" can be passed on the kernel
> -	  command line.
> -
> -config SLAB_FREELIST_RANDOM
> -	bool "Randomize slab freelist"
> -	depends on SLAB || (SLUB && !SLUB_TINY)
> -	help
> -	  Randomizes the freelist order used on creating new pages. This
> -	  security feature reduces the predictability of the kernel slab
> -	  allocator against heap overflows.
> -
> -config SLAB_FREELIST_HARDENED
> -	bool "Harden slab freelist metadata"
> -	depends on SLAB || (SLUB && !SLUB_TINY)
> -	help
> -	  Many kernel heap attacks try to target slab cache metadata and
> -	  other infrastructure. This options makes minor performance
> -	  sacrifices to harden the kernel slab allocator against common
> -	  freelist exploit methods. Some slab implementations have more
> -	  sanity-checking than others. This option is most effective with
> -	  CONFIG_SLUB.
> -
> -config SLUB_STATS
> -	default n
> -	bool "Enable SLUB performance statistics"
> -	depends on SLUB && SYSFS && !SLUB_TINY
> -	help
> -	  SLUB statistics are useful to debug SLUBs allocation behavior in
> -	  order find ways to optimize the allocator. This should never be
> -	  enabled for production use since keeping statistics slows down
> -	  the allocator by a few percentage points. The slabinfo command
> -	  supports the determination of the most active slabs to figure
> -	  out which slabs are relevant to a particular load.
> -	  Try running: slabinfo -DA
> -
> -config SLUB_CPU_PARTIAL
> -	default y
> -	depends on SLUB && SMP && !SLUB_TINY
> -	bool "SLUB per cpu partial cache"
> -	help
> -	  Per cpu partial caches accelerate objects allocation and freeing
> -	  that is local to a processor at the price of more indeterminism
> -	  in the latency of the free. On overflow these caches will be cleared
> -	  which requires the taking of locks that may cause latency spikes.
> -	  Typically one would choose no for a realtime system.
> -
> -endmenu # SLAB allocator options
> -
>   config SHUFFLE_PAGE_ALLOCATOR
>   	bool "Page allocator randomization"
> -	default SLAB_FREELIST_RANDOM && ACPI_NUMA
> +	default ACPI_NUMA
>   	help
>   	  Randomization of the page allocator improves the average
>   	  utilization of a direct-mapped memory-side-cache. See section
> @@ -345,10 +220,9 @@ config SHUFFLE_PAGE_ALLOCATOR
>   	  6.2a specification for an example of how a platform advertises
>   	  the presence of a memory-side-cache. There are also incidental
>   	  security benefits as it reduces the predictability of page
> -	  allocations to compliment SLAB_FREELIST_RANDOM, but the
> -	  default granularity of shuffling on the "MAX_ORDER - 1" i.e,
> -	  10th order of pages is selected based on cache utilization
> -	  benefits on x86.
> +	  allocations, but the default granularity of shuffling on the
> +	  "MAX_ORDER - 1" i.e, 10th order of pages is selected based on
> +	  cache utilization benefits on x86.
>   
>   	  While the randomization improves cache utilization it may
>   	  negatively impact workloads on platforms without a cache. For
> diff --git a/mm/Makefile b/mm/Makefile
> index 8e105e5b3e29..18b0bb245fc3 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -4,16 +4,12 @@
>   #
>   
>   KASAN_SANITIZE_slab_common.o := n
> -KASAN_SANITIZE_slab.o := n
> -KASAN_SANITIZE_slub.o := n
>   KCSAN_SANITIZE_kmemleak.o := n
>   
>   # These produce frequent data race reports: most of them are due to races on
>   # the same word but accesses to different bits of that word. Re-enable KCSAN
>   # for these when we have more consensus on what to do about them.
>   KCSAN_SANITIZE_slab_common.o := n
> -KCSAN_SANITIZE_slab.o := n
> -KCSAN_SANITIZE_slub.o := n
>   KCSAN_SANITIZE_page_alloc.o := n
>   # But enable explicit instrumentation for memory barriers.
>   KCSAN_INSTRUMENT_BARRIERS := y
> @@ -22,9 +18,6 @@ KCSAN_INSTRUMENT_BARRIERS := y
>   # flaky coverage that is not a function of syscall inputs. E.g. slab is out of
>   # free pages, or a task is migrated between nodes.
>   KCOV_INSTRUMENT_slab_common.o := n
> -KCOV_INSTRUMENT_slob.o := n
> -KCOV_INSTRUMENT_slab.o := n
> -KCOV_INSTRUMENT_slub.o := n
>   KCOV_INSTRUMENT_page_alloc.o := n
>   KCOV_INSTRUMENT_debug-pagealloc.o := n
>   KCOV_INSTRUMENT_kmemleak.o := n
> @@ -81,12 +74,9 @@ obj-$(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP)	+= hugetlb_vmemmap.o
>   obj-$(CONFIG_NUMA) 	+= mempolicy.o
>   obj-$(CONFIG_SPARSEMEM)	+= sparse.o
>   obj-$(CONFIG_SPARSEMEM_VMEMMAP) += sparse-vmemmap.o
> -obj-$(CONFIG_SLOB) += slob.o
>   obj-$(CONFIG_MMU_NOTIFIER) += mmu_notifier.o
>   obj-$(CONFIG_KSM) += ksm.o
>   obj-$(CONFIG_PAGE_POISONING) += page_poison.o
> -obj-$(CONFIG_SLAB) += slab.o
> -obj-$(CONFIG_SLUB) += slub.o
>   obj-$(CONFIG_KASAN)	+= kasan/
>   obj-$(CONFIG_KFENCE) += kfence/
>   obj-$(CONFIG_KMSAN)	+= kmsan/
> diff --git a/mm/slab.c b/mm/slab.c
> deleted file mode 100644
> index edbe722fb906..000000000000
> --- a/mm/slab.c
> +++ /dev/null
> @@ -1,4046 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * linux/mm/slab.c
> - * Written by Mark Hemment, 1996/97.
> - * (markhe@nextd.demon.co.uk)
> - *
> - * kmem_cache_destroy() + some cleanup - 1999 Andrea Arcangeli
> - *
> - * Major cleanup, different bufctl logic, per-cpu arrays
> - *	(c) 2000 Manfred Spraul
> - *
> - * Cleanup, make the head arrays unconditional, preparation for NUMA
> - * 	(c) 2002 Manfred Spraul
> - *
> - * An implementation of the Slab Allocator as described in outline in;
> - *	UNIX Internals: The New Frontiers by Uresh Vahalia
> - *	Pub: Prentice Hall	ISBN 0-13-101908-2
> - * or with a little more detail in;
> - *	The Slab Allocator: An Object-Caching Kernel Memory Allocator
> - *	Jeff Bonwick (Sun Microsystems).
> - *	Presented at: USENIX Summer 1994 Technical Conference
> - *
> - * The memory is organized in caches, one cache for each object type.
> - * (e.g. inode_cache, dentry_cache, buffer_head, vm_area_struct)
> - * Each cache consists out of many slabs (they are small (usually one
> - * page long) and always contiguous), and each slab contains multiple
> - * initialized objects.
> - *
> - * This means, that your constructor is used only for newly allocated
> - * slabs and you must pass objects with the same initializations to
> - * kmem_cache_free.
> - *
> - * Each cache can only support one memory type (GFP_DMA, GFP_HIGHMEM,
> - * normal). If you need a special memory type, then must create a new
> - * cache for that memory type.
> - *
> - * In order to reduce fragmentation, the slabs are sorted in 3 groups:
> - *   full slabs with 0 free objects
> - *   partial slabs
> - *   empty slabs with no allocated objects
> - *
> - * If partial slabs exist, then new allocations come from these slabs,
> - * otherwise from empty slabs or new slabs are allocated.
> - *
> - * kmem_cache_destroy() CAN CRASH if you try to allocate from the cache
> - * during kmem_cache_destroy(). The caller must prevent concurrent allocs.
> - *
> - * Each cache has a short per-cpu head array, most allocs
> - * and frees go into that array, and if that array overflows, then 1/2
> - * of the entries in the array are given back into the global cache.
> - * The head array is strictly LIFO and should improve the cache hit rates.
> - * On SMP, it additionally reduces the spinlock operations.
> - *
> - * The c_cpuarray may not be read with enabled local interrupts -
> - * it's changed with a smp_call_function().
> - *
> - * SMP synchronization:
> - *  constructors and destructors are called without any locking.
> - *  Several members in struct kmem_cache and struct slab never change, they
> - *	are accessed without any locking.
> - *  The per-cpu arrays are never accessed from the wrong cpu, no locking,
> - *  	and local interrupts are disabled so slab code is preempt-safe.
> - *  The non-constant members are protected with a per-cache irq spinlock.
> - *
> - * Many thanks to Mark Hemment, who wrote another per-cpu slab patch
> - * in 2000 - many ideas in the current implementation are derived from
> - * his patch.
> - *
> - * Further notes from the original documentation:
> - *
> - * 11 April '97.  Started multi-threading - markhe
> - *	The global cache-chain is protected by the mutex 'slab_mutex'.
> - *	The sem is only needed when accessing/extending the cache-chain, which
> - *	can never happen inside an interrupt (kmem_cache_create(),
> - *	kmem_cache_shrink() and kmem_cache_reap()).
> - *
> - *	At present, each engine can be growing a cache.  This should be blocked.
> - *
> - * 15 March 2005. NUMA slab allocator.
> - *	Shai Fultheim <shai@scalex86.org>.
> - *	Shobhit Dayal <shobhit@calsoftinc.com>
> - *	Alok N Kataria <alokk@calsoftinc.com>
> - *	Christoph Lameter <christoph@lameter.com>
> - *
> - *	Modified the slab allocator to be node aware on NUMA systems.
> - *	Each node has its own list of partial, free and full slabs.
> - *	All object allocations for a node occur from node specific slab lists.
> - */
> -
> -#include	<linux/slab.h>
> -#include	<linux/mm.h>
> -#include	<linux/poison.h>
> -#include	<linux/swap.h>
> -#include	<linux/cache.h>
> -#include	<linux/interrupt.h>
> -#include	<linux/init.h>
> -#include	<linux/compiler.h>
> -#include	<linux/cpuset.h>
> -#include	<linux/proc_fs.h>
> -#include	<linux/seq_file.h>
> -#include	<linux/notifier.h>
> -#include	<linux/kallsyms.h>
> -#include	<linux/kfence.h>
> -#include	<linux/cpu.h>
> -#include	<linux/sysctl.h>
> -#include	<linux/module.h>
> -#include	<linux/rcupdate.h>
> -#include	<linux/string.h>
> -#include	<linux/uaccess.h>
> -#include	<linux/nodemask.h>
> -#include	<linux/kmemleak.h>
> -#include	<linux/mempolicy.h>
> -#include	<linux/mutex.h>
> -#include	<linux/fault-inject.h>
> -#include	<linux/rtmutex.h>
> -#include	<linux/reciprocal_div.h>
> -#include	<linux/debugobjects.h>
> -#include	<linux/memory.h>
> -#include	<linux/prefetch.h>
> -#include	<linux/sched/task_stack.h>
> -
> -#include	<net/sock.h>
> -
> -#include	<asm/cacheflush.h>
> -#include	<asm/tlbflush.h>
> -#include	<asm/page.h>
> -
> -#include <trace/events/kmem.h>
> -
> -#include	"internal.h"
> -
> -#include	"slab.h"
> -
> -/*
> - * DEBUG	- 1 for kmem_cache_create() to honour; SLAB_RED_ZONE & SLAB_POISON.
> - *		  0 for faster, smaller code (especially in the critical paths).
> - *
> - * STATS	- 1 to collect stats for /proc/slabinfo.
> - *		  0 for faster, smaller code (especially in the critical paths).
> - *
> - * FORCED_DEBUG	- 1 enables SLAB_RED_ZONE and SLAB_POISON (if possible)
> - */
> -
> -#ifdef CONFIG_DEBUG_SLAB
> -#define	DEBUG		1
> -#define	STATS		1
> -#define	FORCED_DEBUG	1
> -#else
> -#define	DEBUG		0
> -#define	STATS		0
> -#define	FORCED_DEBUG	0
> -#endif
> -
> -/* Shouldn't this be in a header file somewhere? */
> -#define	BYTES_PER_WORD		sizeof(void *)
> -#define	REDZONE_ALIGN		max(BYTES_PER_WORD, __alignof__(unsigned long long))
> -
> -#ifndef ARCH_KMALLOC_FLAGS
> -#define ARCH_KMALLOC_FLAGS SLAB_HWCACHE_ALIGN
> -#endif
> -
> -#define FREELIST_BYTE_INDEX (((PAGE_SIZE >> BITS_PER_BYTE) \
> -				<= SLAB_OBJ_MIN_SIZE) ? 1 : 0)
> -
> -#if FREELIST_BYTE_INDEX
> -typedef unsigned char freelist_idx_t;
> -#else
> -typedef unsigned short freelist_idx_t;
> -#endif
> -
> -#define SLAB_OBJ_MAX_NUM ((1 << sizeof(freelist_idx_t) * BITS_PER_BYTE) - 1)
> -
> -/*
> - * struct array_cache
> - *
> - * Purpose:
> - * - LIFO ordering, to hand out cache-warm objects from _alloc
> - * - reduce the number of linked list operations
> - * - reduce spinlock operations
> - *
> - * The limit is stored in the per-cpu structure to reduce the data cache
> - * footprint.
> - *
> - */
> -struct array_cache {
> -	unsigned int avail;
> -	unsigned int limit;
> -	unsigned int batchcount;
> -	unsigned int touched;
> -	void *entry[];	/*
> -			 * Must have this definition in here for the proper
> -			 * alignment of array_cache. Also simplifies accessing
> -			 * the entries.
> -			 */
> -};
> -
> -struct alien_cache {
> -	spinlock_t lock;
> -	struct array_cache ac;
> -};
> -
> -/*
> - * Need this for bootstrapping a per node allocator.
> - */
> -#define NUM_INIT_LISTS (2 * MAX_NUMNODES)
> -static struct kmem_cache_node __initdata init_kmem_cache_node[NUM_INIT_LISTS];
> -#define	CACHE_CACHE 0
> -#define	SIZE_NODE (MAX_NUMNODES)
> -
> -static int drain_freelist(struct kmem_cache *cache,
> -			struct kmem_cache_node *n, int tofree);
> -static void free_block(struct kmem_cache *cachep, void **objpp, int len,
> -			int node, struct list_head *list);
> -static void slabs_destroy(struct kmem_cache *cachep, struct list_head *list);
> -static int enable_cpucache(struct kmem_cache *cachep, gfp_t gfp);
> -static void cache_reap(struct work_struct *unused);
> -
> -static inline void fixup_objfreelist_debug(struct kmem_cache *cachep,
> -						void **list);
> -static inline void fixup_slab_list(struct kmem_cache *cachep,
> -				struct kmem_cache_node *n, struct slab *slab,
> -				void **list);
> -
> -#define INDEX_NODE kmalloc_index(sizeof(struct kmem_cache_node))
> -
> -static void kmem_cache_node_init(struct kmem_cache_node *parent)
> -{
> -	INIT_LIST_HEAD(&parent->slabs_full);
> -	INIT_LIST_HEAD(&parent->slabs_partial);
> -	INIT_LIST_HEAD(&parent->slabs_free);
> -	parent->total_slabs = 0;
> -	parent->free_slabs = 0;
> -	parent->shared = NULL;
> -	parent->alien = NULL;
> -	parent->colour_next = 0;
> -	raw_spin_lock_init(&parent->list_lock);
> -	parent->free_objects = 0;
> -	parent->free_touched = 0;
> -}
> -
> -#define MAKE_LIST(cachep, listp, slab, nodeid)				\
> -	do {								\
> -		INIT_LIST_HEAD(listp);					\
> -		list_splice(&get_node(cachep, nodeid)->slab, listp);	\
> -	} while (0)
> -
> -#define	MAKE_ALL_LISTS(cachep, ptr, nodeid)				\
> -	do {								\
> -	MAKE_LIST((cachep), (&(ptr)->slabs_full), slabs_full, nodeid);	\
> -	MAKE_LIST((cachep), (&(ptr)->slabs_partial), slabs_partial, nodeid); \
> -	MAKE_LIST((cachep), (&(ptr)->slabs_free), slabs_free, nodeid);	\
> -	} while (0)
> -
> -#define CFLGS_OBJFREELIST_SLAB	((slab_flags_t __force)0x40000000U)
> -#define CFLGS_OFF_SLAB		((slab_flags_t __force)0x80000000U)
> -#define	OBJFREELIST_SLAB(x)	((x)->flags & CFLGS_OBJFREELIST_SLAB)
> -#define	OFF_SLAB(x)	((x)->flags & CFLGS_OFF_SLAB)
> -
> -#define BATCHREFILL_LIMIT	16
> -/*
> - * Optimization question: fewer reaps means less probability for unnecessary
> - * cpucache drain/refill cycles.
> - *
> - * OTOH the cpuarrays can contain lots of objects,
> - * which could lock up otherwise freeable slabs.
> - */
> -#define REAPTIMEOUT_AC		(2*HZ)
> -#define REAPTIMEOUT_NODE	(4*HZ)
> -
> -#if STATS
> -#define	STATS_INC_ACTIVE(x)	((x)->num_active++)
> -#define	STATS_DEC_ACTIVE(x)	((x)->num_active--)
> -#define	STATS_INC_ALLOCED(x)	((x)->num_allocations++)
> -#define	STATS_INC_GROWN(x)	((x)->grown++)
> -#define	STATS_ADD_REAPED(x, y)	((x)->reaped += (y))
> -#define	STATS_SET_HIGH(x)						\
> -	do {								\
> -		if ((x)->num_active > (x)->high_mark)			\
> -			(x)->high_mark = (x)->num_active;		\
> -	} while (0)
> -#define	STATS_INC_ERR(x)	((x)->errors++)
> -#define	STATS_INC_NODEALLOCS(x)	((x)->node_allocs++)
> -#define	STATS_INC_NODEFREES(x)	((x)->node_frees++)
> -#define STATS_INC_ACOVERFLOW(x)   ((x)->node_overflow++)
> -#define	STATS_SET_FREEABLE(x, i)					\
> -	do {								\
> -		if ((x)->max_freeable < i)				\
> -			(x)->max_freeable = i;				\
> -	} while (0)
> -#define STATS_INC_ALLOCHIT(x)	atomic_inc(&(x)->allochit)
> -#define STATS_INC_ALLOCMISS(x)	atomic_inc(&(x)->allocmiss)
> -#define STATS_INC_FREEHIT(x)	atomic_inc(&(x)->freehit)
> -#define STATS_INC_FREEMISS(x)	atomic_inc(&(x)->freemiss)
> -#else
> -#define	STATS_INC_ACTIVE(x)	do { } while (0)
> -#define	STATS_DEC_ACTIVE(x)	do { } while (0)
> -#define	STATS_INC_ALLOCED(x)	do { } while (0)
> -#define	STATS_INC_GROWN(x)	do { } while (0)
> -#define	STATS_ADD_REAPED(x, y)	do { (void)(y); } while (0)
> -#define	STATS_SET_HIGH(x)	do { } while (0)
> -#define	STATS_INC_ERR(x)	do { } while (0)
> -#define	STATS_INC_NODEALLOCS(x)	do { } while (0)
> -#define	STATS_INC_NODEFREES(x)	do { } while (0)
> -#define STATS_INC_ACOVERFLOW(x)   do { } while (0)
> -#define	STATS_SET_FREEABLE(x, i) do { } while (0)
> -#define STATS_INC_ALLOCHIT(x)	do { } while (0)
> -#define STATS_INC_ALLOCMISS(x)	do { } while (0)
> -#define STATS_INC_FREEHIT(x)	do { } while (0)
> -#define STATS_INC_FREEMISS(x)	do { } while (0)
> -#endif
> -
> -#if DEBUG
> -
> -/*
> - * memory layout of objects:
> - * 0		: objp
> - * 0 .. cachep->obj_offset - BYTES_PER_WORD - 1: padding. This ensures that
> - * 		the end of an object is aligned with the end of the real
> - * 		allocation. Catches writes behind the end of the allocation.
> - * cachep->obj_offset - BYTES_PER_WORD .. cachep->obj_offset - 1:
> - * 		redzone word.
> - * cachep->obj_offset: The real object.
> - * cachep->size - 2* BYTES_PER_WORD: redzone word [BYTES_PER_WORD long]
> - * cachep->size - 1* BYTES_PER_WORD: last caller address
> - *					[BYTES_PER_WORD long]
> - */
> -static int obj_offset(struct kmem_cache *cachep)
> -{
> -	return cachep->obj_offset;
> -}
> -
> -static unsigned long long *dbg_redzone1(struct kmem_cache *cachep, void *objp)
> -{
> -	BUG_ON(!(cachep->flags & SLAB_RED_ZONE));
> -	return (unsigned long long *) (objp + obj_offset(cachep) -
> -				      sizeof(unsigned long long));
> -}
> -
> -static unsigned long long *dbg_redzone2(struct kmem_cache *cachep, void *objp)
> -{
> -	BUG_ON(!(cachep->flags & SLAB_RED_ZONE));
> -	if (cachep->flags & SLAB_STORE_USER)
> -		return (unsigned long long *)(objp + cachep->size -
> -					      sizeof(unsigned long long) -
> -					      REDZONE_ALIGN);
> -	return (unsigned long long *) (objp + cachep->size -
> -				       sizeof(unsigned long long));
> -}
> -
> -static void **dbg_userword(struct kmem_cache *cachep, void *objp)
> -{
> -	BUG_ON(!(cachep->flags & SLAB_STORE_USER));
> -	return (void **)(objp + cachep->size - BYTES_PER_WORD);
> -}
> -
> -#else
> -
> -#define obj_offset(x)			0
> -#define dbg_redzone1(cachep, objp)	({BUG(); (unsigned long long *)NULL;})
> -#define dbg_redzone2(cachep, objp)	({BUG(); (unsigned long long *)NULL;})
> -#define dbg_userword(cachep, objp)	({BUG(); (void **)NULL;})
> -
> -#endif
> -
> -/*
> - * Do not go above this order unless 0 objects fit into the slab or
> - * overridden on the command line.
> - */
> -#define	SLAB_MAX_ORDER_HI	1
> -#define	SLAB_MAX_ORDER_LO	0
> -static int slab_max_order = SLAB_MAX_ORDER_LO;
> -static bool slab_max_order_set __initdata;
> -
> -static inline void *index_to_obj(struct kmem_cache *cache,
> -				 const struct slab *slab, unsigned int idx)
> -{
> -	return slab->s_mem + cache->size * idx;
> -}
> -
> -#define BOOT_CPUCACHE_ENTRIES	1
> -/* internal cache of cache description objs */
> -static struct kmem_cache kmem_cache_boot = {
> -	.batchcount = 1,
> -	.limit = BOOT_CPUCACHE_ENTRIES,
> -	.shared = 1,
> -	.size = sizeof(struct kmem_cache),
> -	.name = "kmem_cache",
> -};
> -
> -static DEFINE_PER_CPU(struct delayed_work, slab_reap_work);
> -
> -static inline struct array_cache *cpu_cache_get(struct kmem_cache *cachep)
> -{
> -	return this_cpu_ptr(cachep->cpu_cache);
> -}
> -
> -/*
> - * Calculate the number of objects and left-over bytes for a given buffer size.
> - */
> -static unsigned int cache_estimate(unsigned long gfporder, size_t buffer_size,
> -		slab_flags_t flags, size_t *left_over)
> -{
> -	unsigned int num;
> -	size_t slab_size = PAGE_SIZE << gfporder;
> -
> -	/*
> -	 * The slab management structure can be either off the slab or
> -	 * on it. For the latter case, the memory allocated for a
> -	 * slab is used for:
> -	 *
> -	 * - @buffer_size bytes for each object
> -	 * - One freelist_idx_t for each object
> -	 *
> -	 * We don't need to consider alignment of freelist because
> -	 * freelist will be at the end of slab page. The objects will be
> -	 * at the correct alignment.
> -	 *
> -	 * If the slab management structure is off the slab, then the
> -	 * alignment will already be calculated into the size. Because
> -	 * the slabs are all pages aligned, the objects will be at the
> -	 * correct alignment when allocated.
> -	 */
> -	if (flags & (CFLGS_OBJFREELIST_SLAB | CFLGS_OFF_SLAB)) {
> -		num = slab_size / buffer_size;
> -		*left_over = slab_size % buffer_size;
> -	} else {
> -		num = slab_size / (buffer_size + sizeof(freelist_idx_t));
> -		*left_over = slab_size %
> -			(buffer_size + sizeof(freelist_idx_t));
> -	}
> -
> -	return num;
> -}
> -
> -#if DEBUG
> -#define slab_error(cachep, msg) __slab_error(__func__, cachep, msg)
> -
> -static void __slab_error(const char *function, struct kmem_cache *cachep,
> -			char *msg)
> -{
> -	pr_err("slab error in %s(): cache `%s': %s\n",
> -	       function, cachep->name, msg);
> -	dump_stack();
> -	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
> -}
> -#endif
> -
> -/*
> - * By default on NUMA we use alien caches to stage the freeing of
> - * objects allocated from other nodes. This causes massive memory
> - * inefficiencies when using fake NUMA setup to split memory into a
> - * large number of small nodes, so it can be disabled on the command
> - * line
> -  */
> -
> -static int use_alien_caches __read_mostly = 1;
> -static int __init noaliencache_setup(char *s)
> -{
> -	use_alien_caches = 0;
> -	return 1;
> -}
> -__setup("noaliencache", noaliencache_setup);
> -
> -static int __init slab_max_order_setup(char *str)
> -{
> -	get_option(&str, &slab_max_order);
> -	slab_max_order = slab_max_order < 0 ? 0 :
> -				min(slab_max_order, MAX_ORDER - 1);
> -	slab_max_order_set = true;
> -
> -	return 1;
> -}
> -__setup("slab_max_order=", slab_max_order_setup);
> -
> -#ifdef CONFIG_NUMA
> -/*
> - * Special reaping functions for NUMA systems called from cache_reap().
> - * These take care of doing round robin flushing of alien caches (containing
> - * objects freed on different nodes from which they were allocated) and the
> - * flushing of remote pcps by calling drain_node_pages.
> - */
> -static DEFINE_PER_CPU(unsigned long, slab_reap_node);
> -
> -static void init_reap_node(int cpu)
> -{
> -	per_cpu(slab_reap_node, cpu) = next_node_in(cpu_to_mem(cpu),
> -						    node_online_map);
> -}
> -
> -static void next_reap_node(void)
> -{
> -	int node = __this_cpu_read(slab_reap_node);
> -
> -	node = next_node_in(node, node_online_map);
> -	__this_cpu_write(slab_reap_node, node);
> -}
> -
> -#else
> -#define init_reap_node(cpu) do { } while (0)
> -#define next_reap_node(void) do { } while (0)
> -#endif
> -
> -/*
> - * Initiate the reap timer running on the target CPU.  We run at around 1 to 2Hz
> - * via the workqueue/eventd.
> - * Add the CPU number into the expiration time to minimize the possibility of
> - * the CPUs getting into lockstep and contending for the global cache chain
> - * lock.
> - */
> -static void start_cpu_timer(int cpu)
> -{
> -	struct delayed_work *reap_work = &per_cpu(slab_reap_work, cpu);
> -
> -	if (reap_work->work.func == NULL) {
> -		init_reap_node(cpu);
> -		INIT_DEFERRABLE_WORK(reap_work, cache_reap);
> -		schedule_delayed_work_on(cpu, reap_work,
> -					__round_jiffies_relative(HZ, cpu));
> -	}
> -}
> -
> -static void init_arraycache(struct array_cache *ac, int limit, int batch)
> -{
> -	if (ac) {
> -		ac->avail = 0;
> -		ac->limit = limit;
> -		ac->batchcount = batch;
> -		ac->touched = 0;
> -	}
> -}
> -
> -static struct array_cache *alloc_arraycache(int node, int entries,
> -					    int batchcount, gfp_t gfp)
> -{
> -	size_t memsize = sizeof(void *) * entries + sizeof(struct array_cache);
> -	struct array_cache *ac = NULL;
> -
> -	ac = kmalloc_node(memsize, gfp, node);
> -	/*
> -	 * The array_cache structures contain pointers to free object.
> -	 * However, when such objects are allocated or transferred to another
> -	 * cache the pointers are not cleared and they could be counted as
> -	 * valid references during a kmemleak scan. Therefore, kmemleak must
> -	 * not scan such objects.
> -	 */
> -	kmemleak_no_scan(ac);
> -	init_arraycache(ac, entries, batchcount);
> -	return ac;
> -}
> -
> -static noinline void cache_free_pfmemalloc(struct kmem_cache *cachep,
> -					struct slab *slab, void *objp)
> -{
> -	struct kmem_cache_node *n;
> -	int slab_node;
> -	LIST_HEAD(list);
> -
> -	slab_node = slab_nid(slab);
> -	n = get_node(cachep, slab_node);
> -
> -	raw_spin_lock(&n->list_lock);
> -	free_block(cachep, &objp, 1, slab_node, &list);
> -	raw_spin_unlock(&n->list_lock);
> -
> -	slabs_destroy(cachep, &list);
> -}
> -
> -/*
> - * Transfer objects in one arraycache to another.
> - * Locking must be handled by the caller.
> - *
> - * Return the number of entries transferred.
> - */
> -static int transfer_objects(struct array_cache *to,
> -		struct array_cache *from, unsigned int max)
> -{
> -	/* Figure out how many entries to transfer */
> -	int nr = min3(from->avail, max, to->limit - to->avail);
> -
> -	if (!nr)
> -		return 0;
> -
> -	memcpy(to->entry + to->avail, from->entry + from->avail - nr,
> -			sizeof(void *) *nr);
> -
> -	from->avail -= nr;
> -	to->avail += nr;
> -	return nr;
> -}
> -
> -/* &alien->lock must be held by alien callers. */
> -static __always_inline void __free_one(struct array_cache *ac, void *objp)
> -{
> -	/* Avoid trivial double-free. */
> -	if (IS_ENABLED(CONFIG_SLAB_FREELIST_HARDENED) &&
> -	    WARN_ON_ONCE(ac->avail > 0 && ac->entry[ac->avail - 1] == objp))
> -		return;
> -	ac->entry[ac->avail++] = objp;
> -}
> -
> -#ifndef CONFIG_NUMA
> -
> -#define drain_alien_cache(cachep, alien) do { } while (0)
> -#define reap_alien(cachep, n) do { } while (0)
> -
> -static inline struct alien_cache **alloc_alien_cache(int node,
> -						int limit, gfp_t gfp)
> -{
> -	return NULL;
> -}
> -
> -static inline void free_alien_cache(struct alien_cache **ac_ptr)
> -{
> -}
> -
> -static inline int cache_free_alien(struct kmem_cache *cachep, void *objp)
> -{
> -	return 0;
> -}
> -
> -static inline gfp_t gfp_exact_node(gfp_t flags)
> -{
> -	return flags & ~__GFP_NOFAIL;
> -}
> -
> -#else	/* CONFIG_NUMA */
> -
> -static struct alien_cache *__alloc_alien_cache(int node, int entries,
> -						int batch, gfp_t gfp)
> -{
> -	size_t memsize = sizeof(void *) * entries + sizeof(struct alien_cache);
> -	struct alien_cache *alc = NULL;
> -
> -	alc = kmalloc_node(memsize, gfp, node);
> -	if (alc) {
> -		kmemleak_no_scan(alc);
> -		init_arraycache(&alc->ac, entries, batch);
> -		spin_lock_init(&alc->lock);
> -	}
> -	return alc;
> -}
> -
> -static struct alien_cache **alloc_alien_cache(int node, int limit, gfp_t gfp)
> -{
> -	struct alien_cache **alc_ptr;
> -	int i;
> -
> -	if (limit > 1)
> -		limit = 12;
> -	alc_ptr = kcalloc_node(nr_node_ids, sizeof(void *), gfp, node);
> -	if (!alc_ptr)
> -		return NULL;
> -
> -	for_each_node(i) {
> -		if (i == node || !node_online(i))
> -			continue;
> -		alc_ptr[i] = __alloc_alien_cache(node, limit, 0xbaadf00d, gfp);
> -		if (!alc_ptr[i]) {
> -			for (i--; i >= 0; i--)
> -				kfree(alc_ptr[i]);
> -			kfree(alc_ptr);
> -			return NULL;
> -		}
> -	}
> -	return alc_ptr;
> -}
> -
> -static void free_alien_cache(struct alien_cache **alc_ptr)
> -{
> -	int i;
> -
> -	if (!alc_ptr)
> -		return;
> -	for_each_node(i)
> -	    kfree(alc_ptr[i]);
> -	kfree(alc_ptr);
> -}
> -
> -static void __drain_alien_cache(struct kmem_cache *cachep,
> -				struct array_cache *ac, int node,
> -				struct list_head *list)
> -{
> -	struct kmem_cache_node *n = get_node(cachep, node);
> -
> -	if (ac->avail) {
> -		raw_spin_lock(&n->list_lock);
> -		/*
> -		 * Stuff objects into the remote nodes shared array first.
> -		 * That way we could avoid the overhead of putting the objects
> -		 * into the free lists and getting them back later.
> -		 */
> -		if (n->shared)
> -			transfer_objects(n->shared, ac, ac->limit);
> -
> -		free_block(cachep, ac->entry, ac->avail, node, list);
> -		ac->avail = 0;
> -		raw_spin_unlock(&n->list_lock);
> -	}
> -}
> -
> -/*
> - * Called from cache_reap() to regularly drain alien caches round robin.
> - */
> -static void reap_alien(struct kmem_cache *cachep, struct kmem_cache_node *n)
> -{
> -	int node = __this_cpu_read(slab_reap_node);
> -
> -	if (n->alien) {
> -		struct alien_cache *alc = n->alien[node];
> -		struct array_cache *ac;
> -
> -		if (alc) {
> -			ac = &alc->ac;
> -			if (ac->avail && spin_trylock_irq(&alc->lock)) {
> -				LIST_HEAD(list);
> -
> -				__drain_alien_cache(cachep, ac, node, &list);
> -				spin_unlock_irq(&alc->lock);
> -				slabs_destroy(cachep, &list);
> -			}
> -		}
> -	}
> -}
> -
> -static void drain_alien_cache(struct kmem_cache *cachep,
> -				struct alien_cache **alien)
> -{
> -	int i = 0;
> -	struct alien_cache *alc;
> -	struct array_cache *ac;
> -	unsigned long flags;
> -
> -	for_each_online_node(i) {
> -		alc = alien[i];
> -		if (alc) {
> -			LIST_HEAD(list);
> -
> -			ac = &alc->ac;
> -			spin_lock_irqsave(&alc->lock, flags);
> -			__drain_alien_cache(cachep, ac, i, &list);
> -			spin_unlock_irqrestore(&alc->lock, flags);
> -			slabs_destroy(cachep, &list);
> -		}
> -	}
> -}
> -
> -static int __cache_free_alien(struct kmem_cache *cachep, void *objp,
> -				int node, int slab_node)
> -{
> -	struct kmem_cache_node *n;
> -	struct alien_cache *alien = NULL;
> -	struct array_cache *ac;
> -	LIST_HEAD(list);
> -
> -	n = get_node(cachep, node);
> -	STATS_INC_NODEFREES(cachep);
> -	if (n->alien && n->alien[slab_node]) {
> -		alien = n->alien[slab_node];
> -		ac = &alien->ac;
> -		spin_lock(&alien->lock);
> -		if (unlikely(ac->avail == ac->limit)) {
> -			STATS_INC_ACOVERFLOW(cachep);
> -			__drain_alien_cache(cachep, ac, slab_node, &list);
> -		}
> -		__free_one(ac, objp);
> -		spin_unlock(&alien->lock);
> -		slabs_destroy(cachep, &list);
> -	} else {
> -		n = get_node(cachep, slab_node);
> -		raw_spin_lock(&n->list_lock);
> -		free_block(cachep, &objp, 1, slab_node, &list);
> -		raw_spin_unlock(&n->list_lock);
> -		slabs_destroy(cachep, &list);
> -	}
> -	return 1;
> -}
> -
> -static inline int cache_free_alien(struct kmem_cache *cachep, void *objp)
> -{
> -	int slab_node = slab_nid(virt_to_slab(objp));
> -	int node = numa_mem_id();
> -	/*
> -	 * Make sure we are not freeing an object from another node to the array
> -	 * cache on this cpu.
> -	 */
> -	if (likely(node == slab_node))
> -		return 0;
> -
> -	return __cache_free_alien(cachep, objp, node, slab_node);
> -}
> -
> -/*
> - * Construct gfp mask to allocate from a specific node but do not reclaim or
> - * warn about failures.
> - */
> -static inline gfp_t gfp_exact_node(gfp_t flags)
> -{
> -	return (flags | __GFP_THISNODE | __GFP_NOWARN) & ~(__GFP_RECLAIM|__GFP_NOFAIL);
> -}
> -#endif
> -
> -static int init_cache_node(struct kmem_cache *cachep, int node, gfp_t gfp)
> -{
> -	struct kmem_cache_node *n;
> -
> -	/*
> -	 * Set up the kmem_cache_node for cpu before we can
> -	 * begin anything. Make sure some other cpu on this
> -	 * node has not already allocated this
> -	 */
> -	n = get_node(cachep, node);
> -	if (n) {
> -		raw_spin_lock_irq(&n->list_lock);
> -		n->free_limit = (1 + nr_cpus_node(node)) * cachep->batchcount +
> -				cachep->num;
> -		raw_spin_unlock_irq(&n->list_lock);
> -
> -		return 0;
> -	}
> -
> -	n = kmalloc_node(sizeof(struct kmem_cache_node), gfp, node);
> -	if (!n)
> -		return -ENOMEM;
> -
> -	kmem_cache_node_init(n);
> -	n->next_reap = jiffies + REAPTIMEOUT_NODE +
> -		    ((unsigned long)cachep) % REAPTIMEOUT_NODE;
> -
> -	n->free_limit =
> -		(1 + nr_cpus_node(node)) * cachep->batchcount + cachep->num;
> -
> -	/*
> -	 * The kmem_cache_nodes don't come and go as CPUs
> -	 * come and go.  slab_mutex provides sufficient
> -	 * protection here.
> -	 */
> -	cachep->node[node] = n;
> -
> -	return 0;
> -}
> -
> -#if defined(CONFIG_NUMA) || defined(CONFIG_SMP)
> -/*
> - * Allocates and initializes node for a node on each slab cache, used for
> - * either memory or cpu hotplug.  If memory is being hot-added, the kmem_cache_node
> - * will be allocated off-node since memory is not yet online for the new node.
> - * When hotplugging memory or a cpu, existing nodes are not replaced if
> - * already in use.
> - *
> - * Must hold slab_mutex.
> - */
> -static int init_cache_node_node(int node)
> -{
> -	int ret;
> -	struct kmem_cache *cachep;
> -
> -	list_for_each_entry(cachep, &slab_caches, list) {
> -		ret = init_cache_node(cachep, node, GFP_KERNEL);
> -		if (ret)
> -			return ret;
> -	}
> -
> -	return 0;
> -}
> -#endif
> -
> -static int setup_kmem_cache_node(struct kmem_cache *cachep,
> -				int node, gfp_t gfp, bool force_change)
> -{
> -	int ret = -ENOMEM;
> -	struct kmem_cache_node *n;
> -	struct array_cache *old_shared = NULL;
> -	struct array_cache *new_shared = NULL;
> -	struct alien_cache **new_alien = NULL;
> -	LIST_HEAD(list);
> -
> -	if (use_alien_caches) {
> -		new_alien = alloc_alien_cache(node, cachep->limit, gfp);
> -		if (!new_alien)
> -			goto fail;
> -	}
> -
> -	if (cachep->shared) {
> -		new_shared = alloc_arraycache(node,
> -			cachep->shared * cachep->batchcount, 0xbaadf00d, gfp);
> -		if (!new_shared)
> -			goto fail;
> -	}
> -
> -	ret = init_cache_node(cachep, node, gfp);
> -	if (ret)
> -		goto fail;
> -
> -	n = get_node(cachep, node);
> -	raw_spin_lock_irq(&n->list_lock);
> -	if (n->shared && force_change) {
> -		free_block(cachep, n->shared->entry,
> -				n->shared->avail, node, &list);
> -		n->shared->avail = 0;
> -	}
> -
> -	if (!n->shared || force_change) {
> -		old_shared = n->shared;
> -		n->shared = new_shared;
> -		new_shared = NULL;
> -	}
> -
> -	if (!n->alien) {
> -		n->alien = new_alien;
> -		new_alien = NULL;
> -	}
> -
> -	raw_spin_unlock_irq(&n->list_lock);
> -	slabs_destroy(cachep, &list);
> -
> -	/*
> -	 * To protect lockless access to n->shared during irq disabled context.
> -	 * If n->shared isn't NULL in irq disabled context, accessing to it is
> -	 * guaranteed to be valid until irq is re-enabled, because it will be
> -	 * freed after synchronize_rcu().
> -	 */
> -	if (old_shared && force_change)
> -		synchronize_rcu();
> -
> -fail:
> -	kfree(old_shared);
> -	kfree(new_shared);
> -	free_alien_cache(new_alien);
> -
> -	return ret;
> -}
> -
> -#ifdef CONFIG_SMP
> -
> -static void cpuup_canceled(long cpu)
> -{
> -	struct kmem_cache *cachep;
> -	struct kmem_cache_node *n = NULL;
> -	int node = cpu_to_mem(cpu);
> -	const struct cpumask *mask = cpumask_of_node(node);
> -
> -	list_for_each_entry(cachep, &slab_caches, list) {
> -		struct array_cache *nc;
> -		struct array_cache *shared;
> -		struct alien_cache **alien;
> -		LIST_HEAD(list);
> -
> -		n = get_node(cachep, node);
> -		if (!n)
> -			continue;
> -
> -		raw_spin_lock_irq(&n->list_lock);
> -
> -		/* Free limit for this kmem_cache_node */
> -		n->free_limit -= cachep->batchcount;
> -
> -		/* cpu is dead; no one can alloc from it. */
> -		nc = per_cpu_ptr(cachep->cpu_cache, cpu);
> -		free_block(cachep, nc->entry, nc->avail, node, &list);
> -		nc->avail = 0;
> -
> -		if (!cpumask_empty(mask)) {
> -			raw_spin_unlock_irq(&n->list_lock);
> -			goto free_slab;
> -		}
> -
> -		shared = n->shared;
> -		if (shared) {
> -			free_block(cachep, shared->entry,
> -				   shared->avail, node, &list);
> -			n->shared = NULL;
> -		}
> -
> -		alien = n->alien;
> -		n->alien = NULL;
> -
> -		raw_spin_unlock_irq(&n->list_lock);
> -
> -		kfree(shared);
> -		if (alien) {
> -			drain_alien_cache(cachep, alien);
> -			free_alien_cache(alien);
> -		}
> -
> -free_slab:
> -		slabs_destroy(cachep, &list);
> -	}
> -	/*
> -	 * In the previous loop, all the objects were freed to
> -	 * the respective cache's slabs,  now we can go ahead and
> -	 * shrink each nodelist to its limit.
> -	 */
> -	list_for_each_entry(cachep, &slab_caches, list) {
> -		n = get_node(cachep, node);
> -		if (!n)
> -			continue;
> -		drain_freelist(cachep, n, INT_MAX);
> -	}
> -}
> -
> -static int cpuup_prepare(long cpu)
> -{
> -	struct kmem_cache *cachep;
> -	int node = cpu_to_mem(cpu);
> -	int err;
> -
> -	/*
> -	 * We need to do this right in the beginning since
> -	 * alloc_arraycache's are going to use this list.
> -	 * kmalloc_node allows us to add the slab to the right
> -	 * kmem_cache_node and not this cpu's kmem_cache_node
> -	 */
> -	err = init_cache_node_node(node);
> -	if (err < 0)
> -		goto bad;
> -
> -	/*
> -	 * Now we can go ahead with allocating the shared arrays and
> -	 * array caches
> -	 */
> -	list_for_each_entry(cachep, &slab_caches, list) {
> -		err = setup_kmem_cache_node(cachep, node, GFP_KERNEL, false);
> -		if (err)
> -			goto bad;
> -	}
> -
> -	return 0;
> -bad:
> -	cpuup_canceled(cpu);
> -	return -ENOMEM;
> -}
> -
> -int slab_prepare_cpu(unsigned int

The slab allocator is very core and very important to the Linux kernel. 
After the patch is merged into the mainline, it will have a very 
profound impact on the development of the Linux kernel.


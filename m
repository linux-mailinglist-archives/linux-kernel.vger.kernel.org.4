Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8C76D441E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 14:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbjDCMHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 08:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbjDCMHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 08:07:00 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548CAA9;
        Mon,  3 Apr 2023 05:06:58 -0700 (PDT)
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PqqM04rq1zKwTX;
        Mon,  3 Apr 2023 20:04:28 +0800 (CST)
Received: from [10.67.110.48] (10.67.110.48) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 3 Apr
 2023 20:06:55 +0800
Message-ID: <eaefbf3b-1a81-5916-b084-79d33b712223@huawei.com>
Date:   Mon, 3 Apr 2023 20:06:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH RFC] Randomized slab caches for kmalloc()
Content-Language: en-US
From:   Gong Ruiqi <gongruiqi1@huawei.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <kernel-hardening@lists.openwall.com>
References: <20230315095459.186113-1-gongruiqi1@huawei.com>
In-Reply-To: <20230315095459.186113-1-gongruiqi1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.48]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.6 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Friendly ping. Any suggestions are welcome.

Thanks.
Ruiqi

On 2023/03/15 17:54, GONG, Ruiqi wrote:
> When exploiting memory vulnerabilities, "heap spraying" is a common
> technique targeting those related to dynamic memory allocation (i.e. the
> "heap"), and it plays an important role in a successful exploitation.
> Basically, it is to overwrite the memory area of vulnerable object by
> triggering allocation in other subsystems or modules and therefore
> getting a reference to the targeted memory location. It's usable on
> various types of vulnerablity including use after free (UAF), heap out-
> of-bound write and etc.
> 
> There are (at least) two reasons why the heap can be sprayed: 1) generic
> slab caches are shared among different subsystems and modules, and
> 2) dedicated slab caches could be merged with the generic ones.
> Currently these two factors cannot be prevented at a low cost: the first
> one is a widely used memory allocation mechanism, and shutting down slab
> merging completely via `slub_nomerge` would be overkill.
> 
> To efficiently prevent heap spraying, we propose the following approach:
> to create multiple copies of generic slab caches that will never be
> merged, and random one of them will be used at allocation. The random
> selection is based on the location of code that calls `kmalloc()`, which
> means it is static at runtime (rather than dynamically determined at
> each time of allocation, which could be bypassed by repeatedly spraying
> in brute force). In this way, the vulnerable object and memory allocated
> in other subsystems and modules will (most probably) be on different
> slab caches, which prevents the object from being sprayed.
> 
> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
> ---
> 
> v0:
> The current implementation only randomize slab caches for KMALLOC_NORMAL
> allocation. Besides the patch itself, we would also like to know the
> opinion of the community about whether or not it's necessary to extend
> this randomization to all KMALLOC_*, and if so, if implementing a three-
> dimensional `kmalloc_caches` is a better choice.
> 
> 
>  include/linux/percpu.h  | 12 +++++++++---
>  include/linux/slab.h    | 24 +++++++++++++++++++-----
>  mm/Kconfig              | 20 ++++++++++++++++++++
>  mm/kfence/kfence_test.c |  4 ++--
>  mm/slab.c               |  2 +-
>  mm/slab.h               |  3 ++-
>  mm/slab_common.c        | 40 +++++++++++++++++++++++++++++++++++-----
>  7 files changed, 88 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/percpu.h b/include/linux/percpu.h
> index 1338ea2aa720..6cee6425951f 100644
> --- a/include/linux/percpu.h
> +++ b/include/linux/percpu.h
> @@ -34,6 +34,12 @@
>  #define PCPU_BITMAP_BLOCK_BITS		(PCPU_BITMAP_BLOCK_SIZE >>	\
>  					 PCPU_MIN_ALLOC_SHIFT)
>  
> +#ifdef CONFIG_RANDOM_KMALLOC_CACHES
> +#define PERCPU_DYNAMIC_SIZE_SHIFT      13
> +#else
> +#define PERCPU_DYNAMIC_SIZE_SHIFT      10
> +#endif
> +
>  /*
>   * Percpu allocator can serve percpu allocations before slab is
>   * initialized which allows slab to depend on the percpu allocator.
> @@ -41,7 +47,7 @@
>   * for this.  Keep PERCPU_DYNAMIC_RESERVE equal to or larger than
>   * PERCPU_DYNAMIC_EARLY_SIZE.
>   */
> -#define PERCPU_DYNAMIC_EARLY_SIZE	(20 << 10)
> +#define PERCPU_DYNAMIC_EARLY_SIZE	(20 << PERCPU_DYNAMIC_SIZE_SHIFT)
>  
>  /*
>   * PERCPU_DYNAMIC_RESERVE indicates the amount of free area to piggy
> @@ -55,9 +61,9 @@
>   * intelligent way to determine this would be nice.
>   */
>  #if BITS_PER_LONG > 32
> -#define PERCPU_DYNAMIC_RESERVE		(28 << 10)
> +#define PERCPU_DYNAMIC_RESERVE		(28 << PERCPU_DYNAMIC_SIZE_SHIFT)
>  #else
> -#define PERCPU_DYNAMIC_RESERVE		(20 << 10)
> +#define PERCPU_DYNAMIC_RESERVE		(20 << PERCPU_DYNAMIC_SIZE_SHIFT)
>  #endif
>  
>  extern void *pcpu_base_addr;
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 87d687c43d8c..fea7644a1985 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -106,6 +106,12 @@
>  /* Avoid kmemleak tracing */
>  #define SLAB_NOLEAKTRACE	((slab_flags_t __force)0x00800000U)
>  
> +#ifdef CONFIG_RANDOM_KMALLOC_CACHES
> +# define SLAB_RANDOMSLAB	((slab_flags_t __force)0x01000000U)
> +#else
> +# define SLAB_RANDOMSLAB	0
> +#endif
> +
>  /* Fault injection mark */
>  #ifdef CONFIG_FAILSLAB
>  # define SLAB_FAILSLAB		((slab_flags_t __force)0x02000000U)
> @@ -336,6 +342,12 @@ static inline unsigned int arch_slab_minalign(void)
>  #define SLAB_OBJ_MIN_SIZE      (KMALLOC_MIN_SIZE < 16 ? \
>                                 (KMALLOC_MIN_SIZE) : 16)
>  
> +#ifdef CONFIG_RANDOM_KMALLOC_CACHES
> +#define KMALLOC_RANDOM_NR CONFIG_RANDOM_KMALLOC_CACHES_NR
> +#else
> +#define KMALLOC_RANDOM_NR 1
> +#endif
> +
>  /*
>   * Whenever changing this, take care of that kmalloc_type() and
>   * create_kmalloc_caches() still work as intended.
> @@ -345,7 +357,9 @@ static inline unsigned int arch_slab_minalign(void)
>   * kmem caches can have both accounted and unaccounted objects.
>   */
>  enum kmalloc_cache_type {
> -	KMALLOC_NORMAL = 0,
> +	KMALLOC_RANDOM_START = 0,
> +	KMALLOC_RANDOM_END = KMALLOC_RANDOM_START + KMALLOC_RANDOM_NR - 1,
> +	KMALLOC_NORMAL = KMALLOC_RANDOM_END,
>  #ifndef CONFIG_ZONE_DMA
>  	KMALLOC_DMA = KMALLOC_NORMAL,
>  #endif
> @@ -378,14 +392,14 @@ kmalloc_caches[NR_KMALLOC_TYPES][KMALLOC_SHIFT_HIGH + 1];
>  	(IS_ENABLED(CONFIG_ZONE_DMA)   ? __GFP_DMA : 0) |	\
>  	(IS_ENABLED(CONFIG_MEMCG_KMEM) ? __GFP_ACCOUNT : 0))
>  
> -static __always_inline enum kmalloc_cache_type kmalloc_type(gfp_t flags)
> +static __always_inline enum kmalloc_cache_type kmalloc_type(gfp_t flags, unsigned long caller)
>  {
>  	/*
>  	 * The most common case is KMALLOC_NORMAL, so test for it
>  	 * with a single branch for all the relevant flags.
>  	 */
>  	if (likely((flags & KMALLOC_NOT_NORMAL_BITS) == 0))
> -		return KMALLOC_NORMAL;
> +		return KMALLOC_RANDOM_START + caller % KMALLOC_RANDOM_NR;
>  
>  	/*
>  	 * At least one of the flags has to be set. Their priorities in
> @@ -578,7 +592,7 @@ static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
>  
>  		index = kmalloc_index(size);
>  		return kmalloc_trace(
> -				kmalloc_caches[kmalloc_type(flags)][index],
> +				kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
>  				flags, size);
>  	}
>  	return __kmalloc(size, flags);
> @@ -604,7 +618,7 @@ static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t fla
>  
>  		index = kmalloc_index(size);
>  		return kmalloc_node_trace(
> -				kmalloc_caches[kmalloc_type(flags)][index],
> +				kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
>  				flags, node, size);
>  	}
>  	return __kmalloc_node(size, flags, node);
> diff --git a/mm/Kconfig b/mm/Kconfig
> index bc828f640cd9..0b116bd8fdf0 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -333,6 +333,26 @@ config SLUB_CPU_PARTIAL
>  	  which requires the taking of locks that may cause latency spikes.
>  	  Typically one would choose no for a realtime system.
>  
> +config RANDOM_KMALLOC_CACHES
> +	default n
> +	depends on SLUB
> +	bool "Random slab caches for normal kmalloc"
> +	help
> +	  A hardening feature that creates multiple copies of slab caches for
> +	  normal kmalloc allocation and makes kmalloc randomly pick one based
> +	  on code address, which makes the attackers unable to spray vulnerable
> +	  memory objects on the heap for exploiting memory vulnerabilities.
> +
> +config RANDOM_KMALLOC_CACHES_NR
> +	int "Number of random slab caches copies"
> +	default 16
> +	range 4 16
> +	depends on RANDOM_KMALLOC_CACHES
> +	help
> +	  The number of copies of random slab caches. Bigger value makes the
> +	  potentially vulnerable memory object less likely to collide with
> +	  objects allocated from other subsystems or modules.
> +
>  endmenu # SLAB allocator options
>  
>  config SHUFFLE_PAGE_ALLOCATOR
> diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
> index b5d66a69200d..316d12af7202 100644
> --- a/mm/kfence/kfence_test.c
> +++ b/mm/kfence/kfence_test.c
> @@ -213,7 +213,7 @@ static void test_cache_destroy(void)
>  
>  static inline size_t kmalloc_cache_alignment(size_t size)
>  {
> -	return kmalloc_caches[kmalloc_type(GFP_KERNEL)][__kmalloc_index(size, false)]->align;
> +	return kmalloc_caches[kmalloc_type(GFP_KERNEL, _RET_IP_)][__kmalloc_index(size, false)]->align;
>  }
>  
>  /* Must always inline to match stack trace against caller. */
> @@ -284,7 +284,7 @@ static void *test_alloc(struct kunit *test, size_t size, gfp_t gfp, enum allocat
>  		if (is_kfence_address(alloc)) {
>  			struct slab *slab = virt_to_slab(alloc);
>  			struct kmem_cache *s = test_cache ?:
> -					kmalloc_caches[kmalloc_type(GFP_KERNEL)][__kmalloc_index(size, false)];
> +					kmalloc_caches[kmalloc_type(GFP_KERNEL, _RET_IP_)][__kmalloc_index(size, false)];
>  
>  			/*
>  			 * Verify that various helpers return the right values
> diff --git a/mm/slab.c b/mm/slab.c
> index dabc2a671fc6..8dc7e183dcc5 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -1675,7 +1675,7 @@ static size_t calculate_slab_order(struct kmem_cache *cachep,
>  			if (freelist_size > KMALLOC_MAX_CACHE_SIZE) {
>  				freelist_cache_size = PAGE_SIZE << get_order(freelist_size);
>  			} else {
> -				freelist_cache = kmalloc_slab(freelist_size, 0u);
> +				freelist_cache = kmalloc_slab(freelist_size, 0u, _RET_IP_);
>  				if (!freelist_cache)
>  					continue;
>  				freelist_cache_size = freelist_cache->size;
> diff --git a/mm/slab.h b/mm/slab.h
> index 43966aa5fadf..4f4caf422b77 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -280,7 +280,7 @@ void setup_kmalloc_cache_index_table(void);
>  void create_kmalloc_caches(slab_flags_t);
>  
>  /* Find the kmalloc slab corresponding for a certain size */
> -struct kmem_cache *kmalloc_slab(size_t, gfp_t);
> +struct kmem_cache *kmalloc_slab(size_t, gfp_t, unsigned long);
>  
>  void *__kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags,
>  			      int node, size_t orig_size,
> @@ -374,6 +374,7 @@ static inline bool is_kmalloc_cache(struct kmem_cache *s)
>  			      SLAB_TEMPORARY | \
>  			      SLAB_ACCOUNT | \
>  			      SLAB_KMALLOC | \
> +			      SLAB_RANDOMSLAB | \
>  			      SLAB_NO_USER_FLAGS)
>  
>  bool __kmem_cache_empty(struct kmem_cache *);
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index bf4e777cfe90..895a3edb82d4 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -47,6 +47,7 @@ static DECLARE_WORK(slab_caches_to_rcu_destroy_work,
>   */
>  #define SLAB_NEVER_MERGE (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER | \
>  		SLAB_TRACE | SLAB_TYPESAFE_BY_RCU | SLAB_NOLEAKTRACE | \
> +		SLAB_RANDOMSLAB | \
>  		SLAB_FAILSLAB | kasan_never_merge())
>  
>  #define SLAB_MERGE_SAME (SLAB_RECLAIM_ACCOUNT | SLAB_CACHE_DMA | \
> @@ -722,7 +723,7 @@ static inline unsigned int size_index_elem(unsigned int bytes)
>   * Find the kmem_cache structure that serves a given size of
>   * allocation
>   */
> -struct kmem_cache *kmalloc_slab(size_t size, gfp_t flags)
> +struct kmem_cache *kmalloc_slab(size_t size, gfp_t flags, unsigned long caller)
>  {
>  	unsigned int index;
>  
> @@ -737,7 +738,7 @@ struct kmem_cache *kmalloc_slab(size_t size, gfp_t flags)
>  		index = fls(size - 1);
>  	}
>  
> -	return kmalloc_caches[kmalloc_type(flags)][index];
> +	return kmalloc_caches[kmalloc_type(flags, caller)][index];
>  }
>  
>  size_t kmalloc_size_roundup(size_t size)
> @@ -755,7 +756,7 @@ size_t kmalloc_size_roundup(size_t size)
>  		return PAGE_SIZE << get_order(size);
>  
>  	/* The flags don't matter since size_index is common to all. */
> -	c = kmalloc_slab(size, GFP_KERNEL);
> +	c = kmalloc_slab(size, GFP_KERNEL, _RET_IP_);
>  	return c ? c->object_size : 0;
>  }
>  EXPORT_SYMBOL(kmalloc_size_roundup);
> @@ -778,12 +779,36 @@ EXPORT_SYMBOL(kmalloc_size_roundup);
>  #define KMALLOC_RCL_NAME(sz)
>  #endif
>  
> +#ifdef CONFIG_RANDOM_KMALLOC_CACHES
> +#define __KMALLOC_RANDOM_CONCAT(a, b, c) a ## b ## c
> +#define KMALLOC_RANDOM_NAME(N, sz) __KMALLOC_RANDOM_CONCAT(KMALLOC_RANDOM_, N, _NAME)(sz)
> +#define KMALLOC_RANDOM_1_NAME(sz)                             .name[KMALLOC_RANDOM_START +  0] = "kmalloc-random-01-" #sz,
> +#define KMALLOC_RANDOM_2_NAME(sz)  KMALLOC_RANDOM_1_NAME(sz)  .name[KMALLOC_RANDOM_START +  1] = "kmalloc-random-02-" #sz,
> +#define KMALLOC_RANDOM_3_NAME(sz)  KMALLOC_RANDOM_2_NAME(sz)  .name[KMALLOC_RANDOM_START +  2] = "kmalloc-random-03-" #sz,
> +#define KMALLOC_RANDOM_4_NAME(sz)  KMALLOC_RANDOM_3_NAME(sz)  .name[KMALLOC_RANDOM_START +  3] = "kmalloc-random-04-" #sz,
> +#define KMALLOC_RANDOM_5_NAME(sz)  KMALLOC_RANDOM_4_NAME(sz)  .name[KMALLOC_RANDOM_START +  4] = "kmalloc-random-05-" #sz,
> +#define KMALLOC_RANDOM_6_NAME(sz)  KMALLOC_RANDOM_5_NAME(sz)  .name[KMALLOC_RANDOM_START +  5] = "kmalloc-random-06-" #sz,
> +#define KMALLOC_RANDOM_7_NAME(sz)  KMALLOC_RANDOM_6_NAME(sz)  .name[KMALLOC_RANDOM_START +  6] = "kmalloc-random-07-" #sz,
> +#define KMALLOC_RANDOM_8_NAME(sz)  KMALLOC_RANDOM_7_NAME(sz)  .name[KMALLOC_RANDOM_START +  7] = "kmalloc-random-08-" #sz,
> +#define KMALLOC_RANDOM_9_NAME(sz)  KMALLOC_RANDOM_8_NAME(sz)  .name[KMALLOC_RANDOM_START +  8] = "kmalloc-random-09-" #sz,
> +#define KMALLOC_RANDOM_10_NAME(sz) KMALLOC_RANDOM_9_NAME(sz)  .name[KMALLOC_RANDOM_START +  9] = "kmalloc-random-10-" #sz,
> +#define KMALLOC_RANDOM_11_NAME(sz) KMALLOC_RANDOM_10_NAME(sz) .name[KMALLOC_RANDOM_START + 10] = "kmalloc-random-11-" #sz,
> +#define KMALLOC_RANDOM_12_NAME(sz) KMALLOC_RANDOM_11_NAME(sz) .name[KMALLOC_RANDOM_START + 11] = "kmalloc-random-12-" #sz,
> +#define KMALLOC_RANDOM_13_NAME(sz) KMALLOC_RANDOM_12_NAME(sz) .name[KMALLOC_RANDOM_START + 12] = "kmalloc-random-13-" #sz,
> +#define KMALLOC_RANDOM_14_NAME(sz) KMALLOC_RANDOM_13_NAME(sz) .name[KMALLOC_RANDOM_START + 13] = "kmalloc-random-14-" #sz,
> +#define KMALLOC_RANDOM_15_NAME(sz) KMALLOC_RANDOM_14_NAME(sz) .name[KMALLOC_RANDOM_START + 14] = "kmalloc-random-15-" #sz,
> +#define KMALLOC_RANDOM_16_NAME(sz) KMALLOC_RANDOM_15_NAME(sz) .name[KMALLOC_RANDOM_START + 15] = "kmalloc-random-16-" #sz,
> +#else
> +#define KMALLOC_RANDOM_NAME(N, sz)
> +#endif
> +
>  #define INIT_KMALLOC_INFO(__size, __short_size)			\
>  {								\
>  	.name[KMALLOC_NORMAL]  = "kmalloc-" #__short_size,	\
>  	KMALLOC_RCL_NAME(__short_size)				\
>  	KMALLOC_CGROUP_NAME(__short_size)			\
>  	KMALLOC_DMA_NAME(__short_size)				\
> +	KMALLOC_RANDOM_NAME(CONFIG_RANDOM_KMALLOC_CACHES_NR, __short_size)	\
>  	.size = __size,						\
>  }
>  
> @@ -879,6 +904,11 @@ new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
>  		flags |= SLAB_CACHE_DMA;
>  	}
>  
> +#ifdef CONFIG_RANDOM_KMALLOC_CACHES
> +	if (type >= KMALLOC_RANDOM_START && type <= KMALLOC_RANDOM_END)
> +		flags |= SLAB_RANDOMSLAB;
> +#endif
> +
>  	kmalloc_caches[type][idx] = create_kmalloc_cache(
>  					kmalloc_info[idx].name[type],
>  					kmalloc_info[idx].size, flags, 0,
> @@ -905,7 +935,7 @@ void __init create_kmalloc_caches(slab_flags_t flags)
>  	/*
>  	 * Including KMALLOC_CGROUP if CONFIG_MEMCG_KMEM defined
>  	 */
> -	for (type = KMALLOC_NORMAL; type < NR_KMALLOC_TYPES; type++) {
> +	for (type = KMALLOC_RANDOM_START; type < NR_KMALLOC_TYPES; type++) {
>  		for (i = KMALLOC_SHIFT_LOW; i <= KMALLOC_SHIFT_HIGH; i++) {
>  			if (!kmalloc_caches[type][i])
>  				new_kmalloc_cache(i, type, flags);
> @@ -958,7 +988,7 @@ void *__do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller
>  		return ret;
>  	}
>  
> -	s = kmalloc_slab(size, flags);
> +	s = kmalloc_slab(size, flags, caller);
>  
>  	if (unlikely(ZERO_OR_NULL_PTR(s)))
>  		return s;

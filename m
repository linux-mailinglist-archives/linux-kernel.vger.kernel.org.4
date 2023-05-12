Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E6A7004F5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 12:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240659AbjELKMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 06:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240474AbjELKLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 06:11:52 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CC111626;
        Fri, 12 May 2023 03:11:23 -0700 (PDT)
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QHkvD1jwhzqSHw;
        Fri, 12 May 2023 18:06:48 +0800 (CST)
Received: from [10.67.110.48] (10.67.110.48) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 12 May
 2023 18:11:02 +0800
Message-ID: <5f5a858a-7017-5424-0fa0-db3b79e5d95e@huawei.com>
Date:   Fri, 12 May 2023 18:11:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Gong Ruiqi <gongruiqi1@huawei.com>
Subject: Re: [PATCH RFC v2] Randomized slab caches for kmalloc()
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        <kasan-dev@googlegroups.com>,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20230508075507.1720950-1-gongruiqi1@huawei.com>
 <CAB=+i9QxWL6ENDz_r1jPbiZsTUj1EE3u-j0uP6y_MxFSM9RerQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAB=+i9QxWL6ENDz_r1jPbiZsTUj1EE3u-j0uP6y_MxFSM9RerQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.48]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/05/11 2:43, Hyeonggon Yoo wrote:
> On Mon, May 8, 2023 at 12:53 AM GONG, Ruiqi <gongruiqi1@huawei.com> wrote:
>>

[...]

>>
>> The overhead of performance has been tested on a 40-core x86 server by
>> comparing the results of `perf bench all` between the kernels with and
>> without this patch based on the latest linux-next kernel, which shows
>> minor difference. A subset of benchmarks are listed below:
>>
> 
> Please Cc maintainers/reviewers of corresponding subsystem in MAINTAINERS file.

Okay, I've appended maintainers/reviewers of linux-hardening and
security subsystem to the Cc list.

> 
> I dont think adding a hardening feature by sacrificing one digit
> percent performance
> (and additional complexity) is worth. Heap spraying can only occur
> when the kernel contains
> security vulnerabilities, and if there is no known ways of performing
> such an attack,
> then we would simply be paying a consistent cost.
> 
> Any opinions from hardening folks?

I did a more throughout performance test on the same machine in the same
way, and here are the results:

              sched/  sched/  syscall/       mem/         mem/
           messaging    pipe     basic     memcpy       memset
control1       0.019   5.459     0.733  15.258789    51.398026
control2       0.019   5.439     0.730  16.009221    48.828125
control3       0.019   5.282     0.735  16.009221    48.828125
control_avg    0.019   5.393     0.733  15.759077    49.684759

exp1           0.019   5.374     0.741	15.500992    46.502976
exp2           0.019   5.440     0.746	16.276042    51.398026
exp3           0.019   5.242     0.752	15.258789    51.398026
exp_avg        0.019   5.352     0.746	15.678608    49.766343

I believe the results show only minor differences and normal
fluctuation, and no substantial performance degradation.

As Pedro points out in his reply, unfortunately there are always
security vulnerabilities in the kernel, which is a fact that we have to
admit. Having a useful mitigation mechanism at the expense of a little
performance loss would be, in my opinion, quite a good deal in many
circumstances. And people can still choose not to have it by setting the
config to n.

> 
>>                         control         experiment (avg of 3 samples)
>> sched/messaging (sec)   0.019           0.019
>> sched/pipe (sec)        5.253           5.340
>> syscall/basic (sec)     0.741           0.742
>> mem/memcpy (GB/sec)     15.258789       14.860495
>> mem/memset (GB/sec)     48.828125       50.431069
>>
>> The overhead of memory usage was measured by executing `free` after boot
>> on a QEMU VM with 1GB total memory, and as expected, it's positively
>> correlated with # of cache copies:
>>
>>                 control         4 copies        8 copies        16 copies
>> total           969.8M          968.2M          968.2M          968.2M
>> used            20.0M           21.9M           24.1M           26.7M
>> free            936.9M          933.6M          931.4M          928.6M
>> available       932.2M          928.8M          926.6M          923.9M
>>
>> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
>> ---
>>
>> v2:
>>   - Use hash_64() and a per-boot random seed to select kmalloc() caches.
>>   - Change acceptable # of caches from [4,16] to {2,4,8,16}, which is
>> more compatible with hashing.
>>   - Supplement results of performance and memory overhead tests.
>>
>>  include/linux/percpu.h  | 12 ++++++---
>>  include/linux/slab.h    | 25 +++++++++++++++---
>>  mm/Kconfig              | 49 ++++++++++++++++++++++++++++++++++++
>>  mm/kfence/kfence_test.c |  4 +--
>>  mm/slab.c               |  2 +-
>>  mm/slab.h               |  3 ++-
>>  mm/slab_common.c        | 56 +++++++++++++++++++++++++++++++++++++----
>>  7 files changed, 135 insertions(+), 16 deletions(-)
>>
>> diff --git a/include/linux/percpu.h b/include/linux/percpu.h
>> index 1338ea2aa720..6cee6425951f 100644
>> --- a/include/linux/percpu.h
>> +++ b/include/linux/percpu.h
>> @@ -34,6 +34,12 @@
>>  #define PCPU_BITMAP_BLOCK_BITS         (PCPU_BITMAP_BLOCK_SIZE >>      \
>>                                          PCPU_MIN_ALLOC_SHIFT)
>>
>> +#ifdef CONFIG_RANDOM_KMALLOC_CACHES
>> +#define PERCPU_DYNAMIC_SIZE_SHIFT      13
>> +#else
>> +#define PERCPU_DYNAMIC_SIZE_SHIFT      10
>> +#endif
>> +
>>  /*
>>   * Percpu allocator can serve percpu allocations before slab is
>>   * initialized which allows slab to depend on the percpu allocator.
>> @@ -41,7 +47,7 @@
>>   * for this.  Keep PERCPU_DYNAMIC_RESERVE equal to or larger than
>>   * PERCPU_DYNAMIC_EARLY_SIZE.
>>   */
>> -#define PERCPU_DYNAMIC_EARLY_SIZE      (20 << 10)
>> +#define PERCPU_DYNAMIC_EARLY_SIZE      (20 << PERCPU_DYNAMIC_SIZE_SHIFT)
>>
>>  /*
>>   * PERCPU_DYNAMIC_RESERVE indicates the amount of free area to piggy
>> @@ -55,9 +61,9 @@
>>   * intelligent way to determine this would be nice.
>>   */
>>  #if BITS_PER_LONG > 32
>> -#define PERCPU_DYNAMIC_RESERVE         (28 << 10)
>> +#define PERCPU_DYNAMIC_RESERVE         (28 << PERCPU_DYNAMIC_SIZE_SHIFT)
>>  #else
>> -#define PERCPU_DYNAMIC_RESERVE         (20 << 10)
>> +#define PERCPU_DYNAMIC_RESERVE         (20 << PERCPU_DYNAMIC_SIZE_SHIFT)
>>  #endif
>>
>>  extern void *pcpu_base_addr;
>> diff --git a/include/linux/slab.h b/include/linux/slab.h
>> index 6b3e155b70bf..939c41c20600 100644
>> --- a/include/linux/slab.h
>> +++ b/include/linux/slab.h
>> @@ -18,6 +18,9 @@
>>  #include <linux/workqueue.h>
>>  #include <linux/percpu-refcount.h>
>>
>> +#ifdef CONFIG_RANDOM_KMALLOC_CACHES
>> +#include <linux/hash.h>
>> +#endif
>>
>>  /*
>>   * Flags to pass to kmem_cache_create().
>> @@ -106,6 +109,12 @@
>>  /* Avoid kmemleak tracing */
>>  #define SLAB_NOLEAKTRACE       ((slab_flags_t __force)0x00800000U)
>>
>> +#ifdef CONFIG_RANDOM_KMALLOC_CACHES
>> +# define SLAB_RANDOMSLAB       ((slab_flags_t __force)0x01000000U)
>> +#else
>> +# define SLAB_RANDOMSLAB       0
>> +#endif
>> +
>>  /* Fault injection mark */
>>  #ifdef CONFIG_FAILSLAB
>>  # define SLAB_FAILSLAB         ((slab_flags_t __force)0x02000000U)
>> @@ -331,7 +340,9 @@ static inline unsigned int arch_slab_minalign(void)
>>   * kmem caches can have both accounted and unaccounted objects.
>>   */
>>  enum kmalloc_cache_type {
>> -       KMALLOC_NORMAL = 0,
>> +       KMALLOC_RANDOM_START = 0,
>> +       KMALLOC_RANDOM_END = KMALLOC_RANDOM_START + CONFIG_RANDOM_KMALLOC_CACHES_NR - 1,
>> +       KMALLOC_NORMAL = KMALLOC_RANDOM_END,
>>  #ifndef CONFIG_ZONE_DMA
>>         KMALLOC_DMA = KMALLOC_NORMAL,
>>  #endif
>> @@ -363,14 +374,20 @@ kmalloc_caches[NR_KMALLOC_TYPES][KMALLOC_SHIFT_HIGH + 1];
>>         (IS_ENABLED(CONFIG_ZONE_DMA)   ? __GFP_DMA : 0) |       \
>>         (IS_ENABLED(CONFIG_MEMCG_KMEM) ? __GFP_ACCOUNT : 0))
>>
>> -static __always_inline enum kmalloc_cache_type kmalloc_type(gfp_t flags)
>> +extern unsigned long random_kmalloc_seed;
>> +
>> +static __always_inline enum kmalloc_cache_type kmalloc_type(gfp_t flags, unsigned long caller)
>>  {
>>         /*
>>          * The most common case is KMALLOC_NORMAL, so test for it
>>          * with a single branch for all the relevant flags.
>>          */
>>         if (likely((flags & KMALLOC_NOT_NORMAL_BITS) == 0))
>> +#ifdef CONFIG_RANDOM_KMALLOC_CACHES
>> +               return KMALLOC_RANDOM_START + hash_64(caller ^ random_kmalloc_seed, CONFIG_RANDOM_KMALLOC_CACHES_BITS);
>> +#else
>>                 return KMALLOC_NORMAL;
>> +#endif
>>
>>         /*
>>          * At least one of the flags has to be set. Their priorities in
>> @@ -557,7 +574,7 @@ static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
>>
>>                 index = kmalloc_index(size);
>>                 return kmalloc_trace(
>> -                               kmalloc_caches[kmalloc_type(flags)][index],
>> +                               kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
>>                                 flags, size);
>>         }
>>         return __kmalloc(size, flags);
>> @@ -573,7 +590,7 @@ static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t fla
>>
>>                 index = kmalloc_index(size);
>>                 return kmalloc_node_trace(
>> -                               kmalloc_caches[kmalloc_type(flags)][index],
>> +                               kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
>>                                 flags, node, size);
>>         }
>>         return __kmalloc_node(size, flags, node);
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index 7672a22647b4..e868da87d9cd 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -311,6 +311,55 @@ config SLUB_CPU_PARTIAL
>>           which requires the taking of locks that may cause latency spikes.
>>           Typically one would choose no for a realtime system.
>>
>> +config RANDOM_KMALLOC_CACHES
>> +       default n
>> +       depends on SLUB
>> +       bool "Random slab caches for normal kmalloc"
>> +       help
>> +         A hardening feature that creates multiple copies of slab caches for
>> +         normal kmalloc allocation and makes kmalloc randomly pick one based
>> +         on code address, which makes the attackers unable to spray vulnerable
>> +         memory objects on the heap for exploiting memory vulnerabilities.
>> +
>> +choice
>> +       prompt "Number of random slab caches copies"
>> +       depends on RANDOM_KMALLOC_CACHES
>> +       default RANDOM_KMALLOC_CACHES_16
>> +       help
>> +         The number of copies of random slab caches. Bigger value makes the
>> +         potentially vulnerable memory object less likely to collide with
>> +         objects allocated from other subsystems or modules.
>> +
>> +config RANDOM_KMALLOC_CACHES_2
>> +       bool "2"
>> +
>> +config RANDOM_KMALLOC_CACHES_4
>> +       bool "4"
>> +
>> +config RANDOM_KMALLOC_CACHES_8
>> +       bool "8"
>> +
>> +config RANDOM_KMALLOC_CACHES_16
>> +       bool "16"
>> +
>> +endchoice
>> +
>> +config RANDOM_KMALLOC_CACHES_BITS
>> +       int
>> +       default 0 if !RANDOM_KMALLOC_CACHES
>> +       default 1 if RANDOM_KMALLOC_CACHES_2
>> +       default 2 if RANDOM_KMALLOC_CACHES_4
>> +       default 3 if RANDOM_KMALLOC_CACHES_8
>> +       default 4 if RANDOM_KMALLOC_CACHES_16
>> +
>> +config RANDOM_KMALLOC_CACHES_NR
>> +       int
>> +       default 1 if !RANDOM_KMALLOC_CACHES
>> +       default 2 if RANDOM_KMALLOC_CACHES_2
>> +       default 4 if RANDOM_KMALLOC_CACHES_4
>> +       default 8 if RANDOM_KMALLOC_CACHES_8
>> +       default 16 if RANDOM_KMALLOC_CACHES_16
>> +
>>  endmenu # SLAB allocator options
>>
>>  config SHUFFLE_PAGE_ALLOCATOR
>> diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
>> index 6aee19a79236..8a95ef649d5e 100644
>> --- a/mm/kfence/kfence_test.c
>> +++ b/mm/kfence/kfence_test.c
>> @@ -213,7 +213,7 @@ static void test_cache_destroy(void)
>>
>>  static inline size_t kmalloc_cache_alignment(size_t size)
>>  {
>> -       return kmalloc_caches[kmalloc_type(GFP_KERNEL)][__kmalloc_index(size, false)]->align;
>> +       return kmalloc_caches[kmalloc_type(GFP_KERNEL, _RET_IP_)][__kmalloc_index(size, false)]->align;
>>  }
>>
>>  /* Must always inline to match stack trace against caller. */
>> @@ -284,7 +284,7 @@ static void *test_alloc(struct kunit *test, size_t size, gfp_t gfp, enum allocat
>>                 if (is_kfence_address(alloc)) {
>>                         struct slab *slab = virt_to_slab(alloc);
>>                         struct kmem_cache *s = test_cache ?:
>> -                                       kmalloc_caches[kmalloc_type(GFP_KERNEL)][__kmalloc_index(size, false)];
>> +                                       kmalloc_caches[kmalloc_type(GFP_KERNEL, _RET_IP_)][__kmalloc_index(size, false)];
>>
>>                         /*
>>                          * Verify that various helpers return the right values
>> diff --git a/mm/slab.c b/mm/slab.c
>> index bb57f7fdbae1..82e2a8d4cd9d 100644
>> --- a/mm/slab.c
>> +++ b/mm/slab.c
>> @@ -1674,7 +1674,7 @@ static size_t calculate_slab_order(struct kmem_cache *cachep,
>>                         if (freelist_size > KMALLOC_MAX_CACHE_SIZE) {
>>                                 freelist_cache_size = PAGE_SIZE << get_order(freelist_size);
>>                         } else {
>> -                               freelist_cache = kmalloc_slab(freelist_size, 0u);
>> +                               freelist_cache = kmalloc_slab(freelist_size, 0u, _RET_IP_);
>>                                 if (!freelist_cache)
>>                                         continue;
>>                                 freelist_cache_size = freelist_cache->size;
>> diff --git a/mm/slab.h b/mm/slab.h
>> index f01ac256a8f5..1e484af71c52 100644
>> --- a/mm/slab.h
>> +++ b/mm/slab.h
>> @@ -243,7 +243,7 @@ void setup_kmalloc_cache_index_table(void);
>>  void create_kmalloc_caches(slab_flags_t);
>>
>>  /* Find the kmalloc slab corresponding for a certain size */
>> -struct kmem_cache *kmalloc_slab(size_t, gfp_t);
>> +struct kmem_cache *kmalloc_slab(size_t, gfp_t, unsigned long);
>>
>>  void *__kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags,
>>                               int node, size_t orig_size,
>> @@ -319,6 +319,7 @@ static inline bool is_kmalloc_cache(struct kmem_cache *s)
>>                               SLAB_TEMPORARY | \
>>                               SLAB_ACCOUNT | \
>>                               SLAB_KMALLOC | \
>> +                             SLAB_RANDOMSLAB | \
>>                               SLAB_NO_USER_FLAGS)
>>
>>  bool __kmem_cache_empty(struct kmem_cache *);
>> diff --git a/mm/slab_common.c b/mm/slab_common.c
>> index 607249785c07..70899b20a9a7 100644
>> --- a/mm/slab_common.c
>> +++ b/mm/slab_common.c
>> @@ -47,6 +47,7 @@ static DECLARE_WORK(slab_caches_to_rcu_destroy_work,
>>   */
>>  #define SLAB_NEVER_MERGE (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER | \
>>                 SLAB_TRACE | SLAB_TYPESAFE_BY_RCU | SLAB_NOLEAKTRACE | \
>> +               SLAB_RANDOMSLAB | \
>>                 SLAB_FAILSLAB | kasan_never_merge())
>>
>>  #define SLAB_MERGE_SAME (SLAB_RECLAIM_ACCOUNT | SLAB_CACHE_DMA | \
>> @@ -679,6 +680,11 @@ kmalloc_caches[NR_KMALLOC_TYPES][KMALLOC_SHIFT_HIGH + 1] __ro_after_init =
>>  { /* initialization for https://bugs.llvm.org/show_bug.cgi?id=42570 */ };
>>  EXPORT_SYMBOL(kmalloc_caches);
>>
>> +#ifdef CONFIG_RANDOM_KMALLOC_CACHES
>> +unsigned long random_kmalloc_seed __ro_after_init;
>> +EXPORT_SYMBOL(random_kmalloc_seed);
>> +#endif
>> +
>>  /*
>>   * Conversion table for small slabs sizes / 8 to the index in the
>>   * kmalloc array. This is necessary for slabs < 192 since we have non power
>> @@ -721,7 +727,7 @@ static inline unsigned int size_index_elem(unsigned int bytes)
>>   * Find the kmem_cache structure that serves a given size of
>>   * allocation
>>   */
>> -struct kmem_cache *kmalloc_slab(size_t size, gfp_t flags)
>> +struct kmem_cache *kmalloc_slab(size_t size, gfp_t flags, unsigned long caller)
>>  {
>>         unsigned int index;
>>
>> @@ -736,7 +742,7 @@ struct kmem_cache *kmalloc_slab(size_t size, gfp_t flags)
>>                 index = fls(size - 1);
>>         }
>>
>> -       return kmalloc_caches[kmalloc_type(flags)][index];
>> +       return kmalloc_caches[kmalloc_type(flags, caller)][index];
>>  }
>>
>>  size_t kmalloc_size_roundup(size_t size)
>> @@ -754,7 +760,7 @@ size_t kmalloc_size_roundup(size_t size)
>>                 return PAGE_SIZE << get_order(size);
>>
>>         /* The flags don't matter since size_index is common to all. */
>> -       c = kmalloc_slab(size, GFP_KERNEL);
>> +       c = kmalloc_slab(size, GFP_KERNEL, _RET_IP_);
>>         return c ? c->object_size : 0;
>>  }
>>  EXPORT_SYMBOL(kmalloc_size_roundup);
>> @@ -777,12 +783,44 @@ EXPORT_SYMBOL(kmalloc_size_roundup);
>>  #define KMALLOC_RCL_NAME(sz)
>>  #endif
>>
>> +#ifdef CONFIG_RANDOM_KMALLOC_CACHES
>> +#define __KMALLOC_RANDOM_CONCAT(a, b, c) a ## b ## c
>> +#define KMALLOC_RANDOM_NAME(N, sz) __KMALLOC_RANDOM_CONCAT(KMALLOC_RANDOM_, N, _NAME)(sz)
>> +#if CONFIG_RANDOM_KMALLOC_CACHES_BITS >= 1
>> +#define KMALLOC_RANDOM_1_NAME(sz)                             .name[KMALLOC_RANDOM_START +  0] = "kmalloc-random-01-" #sz,
>> +#define KMALLOC_RANDOM_2_NAME(sz)  KMALLOC_RANDOM_1_NAME(sz)  .name[KMALLOC_RANDOM_START +  1] = "kmalloc-random-02-" #sz,
>> +#endif
>> +#if CONFIG_RANDOM_KMALLOC_CACHES_BITS >= 2
>> +#define KMALLOC_RANDOM_3_NAME(sz)  KMALLOC_RANDOM_2_NAME(sz)  .name[KMALLOC_RANDOM_START +  2] = "kmalloc-random-03-" #sz,
>> +#define KMALLOC_RANDOM_4_NAME(sz)  KMALLOC_RANDOM_3_NAME(sz)  .name[KMALLOC_RANDOM_START +  3] = "kmalloc-random-04-" #sz,
>> +#endif
>> +#if CONFIG_RANDOM_KMALLOC_CACHES_BITS >= 3
>> +#define KMALLOC_RANDOM_5_NAME(sz)  KMALLOC_RANDOM_4_NAME(sz)  .name[KMALLOC_RANDOM_START +  4] = "kmalloc-random-05-" #sz,
>> +#define KMALLOC_RANDOM_6_NAME(sz)  KMALLOC_RANDOM_5_NAME(sz)  .name[KMALLOC_RANDOM_START +  5] = "kmalloc-random-06-" #sz,
>> +#define KMALLOC_RANDOM_7_NAME(sz)  KMALLOC_RANDOM_6_NAME(sz)  .name[KMALLOC_RANDOM_START +  6] = "kmalloc-random-07-" #sz,
>> +#define KMALLOC_RANDOM_8_NAME(sz)  KMALLOC_RANDOM_7_NAME(sz)  .name[KMALLOC_RANDOM_START +  7] = "kmalloc-random-08-" #sz,
>> +#endif
>> +#if CONFIG_RANDOM_KMALLOC_CACHES_BITS >= 4
>> +#define KMALLOC_RANDOM_9_NAME(sz)  KMALLOC_RANDOM_8_NAME(sz)  .name[KMALLOC_RANDOM_START +  8] = "kmalloc-random-09-" #sz,
>> +#define KMALLOC_RANDOM_10_NAME(sz) KMALLOC_RANDOM_9_NAME(sz)  .name[KMALLOC_RANDOM_START +  9] = "kmalloc-random-10-" #sz,
>> +#define KMALLOC_RANDOM_11_NAME(sz) KMALLOC_RANDOM_10_NAME(sz) .name[KMALLOC_RANDOM_START + 10] = "kmalloc-random-11-" #sz,
>> +#define KMALLOC_RANDOM_12_NAME(sz) KMALLOC_RANDOM_11_NAME(sz) .name[KMALLOC_RANDOM_START + 11] = "kmalloc-random-12-" #sz,
>> +#define KMALLOC_RANDOM_13_NAME(sz) KMALLOC_RANDOM_12_NAME(sz) .name[KMALLOC_RANDOM_START + 12] = "kmalloc-random-13-" #sz,
>> +#define KMALLOC_RANDOM_14_NAME(sz) KMALLOC_RANDOM_13_NAME(sz) .name[KMALLOC_RANDOM_START + 13] = "kmalloc-random-14-" #sz,
>> +#define KMALLOC_RANDOM_15_NAME(sz) KMALLOC_RANDOM_14_NAME(sz) .name[KMALLOC_RANDOM_START + 14] = "kmalloc-random-15-" #sz,
>> +#define KMALLOC_RANDOM_16_NAME(sz) KMALLOC_RANDOM_15_NAME(sz) .name[KMALLOC_RANDOM_START + 15] = "kmalloc-random-16-" #sz,
>> +#endif
>> +#else // CONFIG_RANDOM_KMALLOC_CACHES
>> +#define KMALLOC_RANDOM_NAME(N, sz)
>> +#endif
>> +
>>  #define INIT_KMALLOC_INFO(__size, __short_size)                        \
>>  {                                                              \
>>         .name[KMALLOC_NORMAL]  = "kmalloc-" #__short_size,      \
>>         KMALLOC_RCL_NAME(__short_size)                          \
>>         KMALLOC_CGROUP_NAME(__short_size)                       \
>>         KMALLOC_DMA_NAME(__short_size)                          \
>> +       KMALLOC_RANDOM_NAME(CONFIG_RANDOM_KMALLOC_CACHES_NR, __short_size)      \
>>         .size = __size,                                         \
>>  }
>>
>> @@ -878,6 +916,11 @@ new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
>>                 flags |= SLAB_CACHE_DMA;
>>         }
>>
>> +#ifdef CONFIG_RANDOM_KMALLOC_CACHES
>> +       if (type >= KMALLOC_RANDOM_START && type <= KMALLOC_RANDOM_END)
>> +               flags |= SLAB_RANDOMSLAB;
>> +#endif
>> +
>>         kmalloc_caches[type][idx] = create_kmalloc_cache(
>>                                         kmalloc_info[idx].name[type],
>>                                         kmalloc_info[idx].size, flags, 0,
>> @@ -904,7 +947,7 @@ void __init create_kmalloc_caches(slab_flags_t flags)
>>         /*
>>          * Including KMALLOC_CGROUP if CONFIG_MEMCG_KMEM defined
>>          */
>> -       for (type = KMALLOC_NORMAL; type < NR_KMALLOC_TYPES; type++) {
>> +       for (type = KMALLOC_RANDOM_START; type < NR_KMALLOC_TYPES; type++) {
>>                 for (i = KMALLOC_SHIFT_LOW; i <= KMALLOC_SHIFT_HIGH; i++) {
>>                         if (!kmalloc_caches[type][i])
>>                                 new_kmalloc_cache(i, type, flags);
>> @@ -922,6 +965,9 @@ void __init create_kmalloc_caches(slab_flags_t flags)
>>                                 new_kmalloc_cache(2, type, flags);
>>                 }
>>         }
>> +#ifdef CONFIG_RANDOM_KMALLOC_CACHES
>> +       random_kmalloc_seed = get_random_u64();
>> +#endif
>>
>>         /* Kmalloc array is now usable */
>>         slab_state = UP;
>> @@ -957,7 +1003,7 @@ void *__do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller
>>                 return ret;
>>         }
>>
>> -       s = kmalloc_slab(size, flags);
>> +       s = kmalloc_slab(size, flags, caller);
>>
>>         if (unlikely(ZERO_OR_NULL_PTR(s)))
>>                 return s;
>> --
>> 2.25.1
>>

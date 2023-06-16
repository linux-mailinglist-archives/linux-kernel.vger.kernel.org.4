Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B4C732F9D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345324AbjFPLPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345309AbjFPLPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:15:12 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8C2AC;
        Fri, 16 Jun 2023 04:15:10 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QjGlt48Dhz4f3wt9;
        Fri, 16 Jun 2023 19:15:06 +0800 (CST)
Received: from ubuntu20.huawei.com (unknown [10.67.174.33])
        by APP1 (Coremail) with SMTP id cCh0CgDHLCcnRIxkwOG9LA--.4088S3;
        Fri, 16 Jun 2023 19:15:04 +0800 (CST)
From:   "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
To:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>, Tejun Heo <tj@kernel.org>,
        Dennis Zhou <dennis@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        gongruiqi1@huawei.com
Subject: [PATCH v3 1/1] Randomized slab caches for kmalloc()
Date:   Fri, 16 Jun 2023 19:18:43 +0800
Message-Id: <20230616111843.3677378-2-gongruiqi@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230616111843.3677378-1-gongruiqi@huaweicloud.com>
References: <20230616111843.3677378-1-gongruiqi@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDHLCcnRIxkwOG9LA--.4088S3
X-Coremail-Antispam: 1UD129KBjvAXoW3uw4ktw13XFWDGw4DKF1xXwb_yoW8Ar48Co
        WrCF1UZw1fKryxAF4UZFs3G3yDuF9YgrnxXFn8ZrZ5GFy8Z34DG34UtrWfWFy5GF1Iqrsx
        Ar12ga15K39Ivr95n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYG7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
        8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr
        4l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
        w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
        0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1cdbUUUUUU==
X-CM-SenderInfo: pjrqw2pxltxq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When exploiting memory vulnerabilities, "heap spraying" is a common
technique targeting those related to dynamic memory allocation (i.e. the
"heap"), and it plays an important role in a successful exploitation.
Basically, it is to overwrite the memory area of vulnerable object by
triggering allocation in other subsystems or modules and therefore
getting a reference to the targeted memory location. It's usable on
various types of vulnerablity including use after free (UAF), heap out-
of-bound write and etc.

There are (at least) two reasons why the heap can be sprayed: 1) generic
slab caches are shared among different subsystems and modules, and
2) dedicated slab caches could be merged with the generic ones.
Currently these two factors cannot be prevented at a low cost: the first
one is a widely used memory allocation mechanism, and shutting down slab
merging completely via `slub_nomerge` would be overkill.

To efficiently prevent heap spraying, we propose the following approach:
to create multiple copies of generic slab caches that will never be
merged, and random one of them will be used at allocation. The random
selection is based on the address of code that calls `kmalloc()`, which
means it is static at runtime (rather than dynamically determined at
each time of allocation, which could be bypassed by repeatedly spraying
in brute force). In other words, the randomness of cache selection will
be with respect to the code address rather than time, i.e. allocations
in different code paths would most likely pick different caches,
although kmalloc() at each place would use the same cache copy whenever
it is executed. In this way, the vulnerable object and memory allocated
in other subsystems and modules will (most probably) be on different
slab caches, which prevents the object from being sprayed.

Meanwhile, the static random selection is further enhanced with a
per-boot random seed, which prevents the attacker from finding a usable
kmalloc that happens to pick the same cache with the vulnerable
subsystem/module by analyzing the open source code.

The overhead of performance has been tested on a 40-core x86 server by
comparing the results of `perf bench all` between the kernels with and
without this patch based on the latest linux-next kernel, which shows
minor difference. A subset of benchmarks are listed below:

                sched/  sched/  syscall/       mem/       mem/
             messaging    pipe     basic     memcpy     memset
                 (sec)   (sec)     (sec)   (GB/sec)   (GB/sec)

control1         0.019   5.459     0.733  15.258789  51.398026
control2         0.019   5.439     0.730  16.009221  48.828125
control3         0.019   5.282     0.735  16.009221  48.828125
control_avg      0.019   5.393     0.733  15.759077  49.684759

experiment1      0.019   5.374     0.741  15.500992  46.502976
experiment2      0.019   5.440     0.746  16.276042  51.398026
experiment3      0.019   5.242     0.752  15.258789  51.398026
experiment_avg   0.019   5.352     0.746  15.678608  49.766343

The overhead of memory usage was measured by executing `free` after boot
on a QEMU VM with 1GB total memory, and as expected, it's positively
correlated with # of cache copies:

           control  4 copies  8 copies  16 copies

total       969.8M    968.2M    968.2M     968.2M
used         20.0M     21.9M     24.1M      26.7M
free        936.9M    933.6M    931.4M     928.6M
available   932.2M    928.8M    926.6M     923.9M

Signed-off-by: GONG, Ruiqi <gongruiqi@huaweicloud.com>
Co-developed-by: Xiu Jianfeng <xiujianfeng@huawei.com>
Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 include/linux/percpu.h  | 12 ++++++---
 include/linux/slab.h    | 20 ++++++++++++---
 mm/Kconfig              | 49 ++++++++++++++++++++++++++++++++++++
 mm/kfence/kfence_test.c |  6 +++--
 mm/slab.c               |  2 +-
 mm/slab.h               |  2 +-
 mm/slab_common.c        | 55 +++++++++++++++++++++++++++++++++++++----
 7 files changed, 130 insertions(+), 16 deletions(-)

diff --git a/include/linux/percpu.h b/include/linux/percpu.h
index 42125cf9c506..bdcfc988e6db 100644
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -34,6 +34,12 @@
 #define PCPU_BITMAP_BLOCK_BITS		(PCPU_BITMAP_BLOCK_SIZE >>	\
 					 PCPU_MIN_ALLOC_SHIFT)
 
+#ifdef CONFIG_RANDOM_KMALLOC_CACHES
+#define PERCPU_DYNAMIC_SIZE_SHIFT      13
+#else
+#define PERCPU_DYNAMIC_SIZE_SHIFT      10
+#endif
+
 /*
  * Percpu allocator can serve percpu allocations before slab is
  * initialized which allows slab to depend on the percpu allocator.
@@ -41,7 +47,7 @@
  * for this.  Keep PERCPU_DYNAMIC_RESERVE equal to or larger than
  * PERCPU_DYNAMIC_EARLY_SIZE.
  */
-#define PERCPU_DYNAMIC_EARLY_SIZE	(20 << 10)
+#define PERCPU_DYNAMIC_EARLY_SIZE	(20 << PERCPU_DYNAMIC_SIZE_SHIFT)
 
 /*
  * PERCPU_DYNAMIC_RESERVE indicates the amount of free area to piggy
@@ -55,9 +61,9 @@
  * intelligent way to determine this would be nice.
  */
 #if BITS_PER_LONG > 32
-#define PERCPU_DYNAMIC_RESERVE		(28 << 10)
+#define PERCPU_DYNAMIC_RESERVE		(28 << PERCPU_DYNAMIC_SIZE_SHIFT)
 #else
-#define PERCPU_DYNAMIC_RESERVE		(20 << 10)
+#define PERCPU_DYNAMIC_RESERVE		(20 << PERCPU_DYNAMIC_SIZE_SHIFT)
 #endif
 
 extern void *pcpu_base_addr;
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 791f7453a04f..b7a5387f0dad 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -19,6 +19,9 @@
 #include <linux/workqueue.h>
 #include <linux/percpu-refcount.h>
 
+#ifdef CONFIG_RANDOM_KMALLOC_CACHES
+#include <linux/hash.h>
+#endif
 
 /*
  * Flags to pass to kmem_cache_create().
@@ -351,7 +354,9 @@ static inline unsigned int arch_slab_minalign(void)
  * kmem caches can have both accounted and unaccounted objects.
  */
 enum kmalloc_cache_type {
-	KMALLOC_NORMAL = 0,
+	KMALLOC_RANDOM_START = 0,
+	KMALLOC_RANDOM_END = KMALLOC_RANDOM_START + CONFIG_RANDOM_KMALLOC_CACHES_NR - 1,
+	KMALLOC_NORMAL = KMALLOC_RANDOM_END,
 #ifndef CONFIG_ZONE_DMA
 	KMALLOC_DMA = KMALLOC_NORMAL,
 #endif
@@ -383,14 +388,21 @@ kmalloc_caches[NR_KMALLOC_TYPES][KMALLOC_SHIFT_HIGH + 1];
 	(IS_ENABLED(CONFIG_ZONE_DMA)   ? __GFP_DMA : 0) |	\
 	(IS_ENABLED(CONFIG_MEMCG_KMEM) ? __GFP_ACCOUNT : 0))
 
-static __always_inline enum kmalloc_cache_type kmalloc_type(gfp_t flags)
+extern unsigned long random_kmalloc_seed;
+
+static __always_inline enum kmalloc_cache_type kmalloc_type(gfp_t flags, unsigned long caller)
 {
 	/*
 	 * The most common case is KMALLOC_NORMAL, so test for it
 	 * with a single branch for all the relevant flags.
 	 */
 	if (likely((flags & KMALLOC_NOT_NORMAL_BITS) == 0))
+#ifdef CONFIG_RANDOM_KMALLOC_CACHES
+		return KMALLOC_RANDOM_START + hash_64(caller ^ random_kmalloc_seed,
+						      CONFIG_RANDOM_KMALLOC_CACHES_BITS);
+#else
 		return KMALLOC_NORMAL;
+#endif
 
 	/*
 	 * At least one of the flags has to be set. Their priorities in
@@ -577,7 +589,7 @@ static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
 
 		index = kmalloc_index(size);
 		return kmalloc_trace(
-				kmalloc_caches[kmalloc_type(flags)][index],
+				kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
 				flags, size);
 	}
 	return __kmalloc(size, flags);
@@ -593,7 +605,7 @@ static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t fla
 
 		index = kmalloc_index(size);
 		return kmalloc_node_trace(
-				kmalloc_caches[kmalloc_type(flags)][index],
+				kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
 				flags, node, size);
 	}
 	return __kmalloc_node(size, flags, node);
diff --git a/mm/Kconfig b/mm/Kconfig
index a3c95338cd3a..6150e9a946a7 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -337,6 +337,55 @@ config SLUB_CPU_PARTIAL
 	  which requires the taking of locks that may cause latency spikes.
 	  Typically one would choose no for a realtime system.
 
+config RANDOM_KMALLOC_CACHES
+	default n
+	depends on SLUB
+	bool "Random slab caches for normal kmalloc"
+	help
+	  A hardening feature that creates multiple copies of slab caches for
+	  normal kmalloc allocation and makes kmalloc randomly pick one based
+	  on code address, which makes the attackers unable to spray vulnerable
+	  memory objects on the heap for exploiting memory vulnerabilities.
+
+choice
+	prompt "Number of random slab caches copies"
+	depends on RANDOM_KMALLOC_CACHES
+	default RANDOM_KMALLOC_CACHES_16
+	help
+	  The number of copies of random slab caches. Bigger value makes the
+	  potentially vulnerable memory object less likely to collide with
+	  objects allocated from other subsystems or modules.
+
+config RANDOM_KMALLOC_CACHES_2
+	bool "2"
+
+config RANDOM_KMALLOC_CACHES_4
+	bool "4"
+
+config RANDOM_KMALLOC_CACHES_8
+	bool "8"
+
+config RANDOM_KMALLOC_CACHES_16
+	bool "16"
+
+endchoice
+
+config RANDOM_KMALLOC_CACHES_BITS
+	int
+	default 0 if !RANDOM_KMALLOC_CACHES
+	default 1 if RANDOM_KMALLOC_CACHES_2
+	default 2 if RANDOM_KMALLOC_CACHES_4
+	default 3 if RANDOM_KMALLOC_CACHES_8
+	default 4 if RANDOM_KMALLOC_CACHES_16
+
+config RANDOM_KMALLOC_CACHES_NR
+	int
+	default 1 if !RANDOM_KMALLOC_CACHES
+	default 2 if RANDOM_KMALLOC_CACHES_2
+	default 4 if RANDOM_KMALLOC_CACHES_4
+	default 8 if RANDOM_KMALLOC_CACHES_8
+	default 16 if RANDOM_KMALLOC_CACHES_16
+
 endmenu # SLAB allocator options
 
 config SHUFFLE_PAGE_ALLOCATOR
diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
index 9e008a336d9f..7f5ffb490328 100644
--- a/mm/kfence/kfence_test.c
+++ b/mm/kfence/kfence_test.c
@@ -212,7 +212,8 @@ static void test_cache_destroy(void)
 
 static inline size_t kmalloc_cache_alignment(size_t size)
 {
-	return kmalloc_caches[kmalloc_type(GFP_KERNEL)][__kmalloc_index(size, false)]->align;
+	enum kmalloc_cache_type type = kmalloc_type(GFP_KERNEL, _RET_IP_);
+	return kmalloc_caches[type][__kmalloc_index(size, false)]->align;
 }
 
 /* Must always inline to match stack trace against caller. */
@@ -282,8 +283,9 @@ static void *test_alloc(struct kunit *test, size_t size, gfp_t gfp, enum allocat
 
 		if (is_kfence_address(alloc)) {
 			struct slab *slab = virt_to_slab(alloc);
+			enum kmalloc_cache_type type = kmalloc_type(GFP_KERNEL, _RET_IP_);
 			struct kmem_cache *s = test_cache ?:
-					kmalloc_caches[kmalloc_type(GFP_KERNEL)][__kmalloc_index(size, false)];
+				kmalloc_caches[type][__kmalloc_index(size, false)];
 
 			/*
 			 * Verify that various helpers return the right values
diff --git a/mm/slab.c b/mm/slab.c
index 88194391d553..9ad3d0f2d1a5 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1670,7 +1670,7 @@ static size_t calculate_slab_order(struct kmem_cache *cachep,
 			if (freelist_size > KMALLOC_MAX_CACHE_SIZE) {
 				freelist_cache_size = PAGE_SIZE << get_order(freelist_size);
 			} else {
-				freelist_cache = kmalloc_slab(freelist_size, 0u);
+				freelist_cache = kmalloc_slab(freelist_size, 0u, _RET_IP_);
 				if (!freelist_cache)
 					continue;
 				freelist_cache_size = freelist_cache->size;
diff --git a/mm/slab.h b/mm/slab.h
index 6a5633b25eb5..4ebe3bdfc17c 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -282,7 +282,7 @@ void setup_kmalloc_cache_index_table(void);
 void create_kmalloc_caches(slab_flags_t);
 
 /* Find the kmalloc slab corresponding for a certain size */
-struct kmem_cache *kmalloc_slab(size_t, gfp_t);
+struct kmem_cache *kmalloc_slab(size_t size, gfp_t flags, unsigned long caller);
 
 void *__kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags,
 			      int node, size_t orig_size,
diff --git a/mm/slab_common.c b/mm/slab_common.c
index ca8b9e587a55..dc1ecf19afd3 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -678,6 +678,11 @@ kmalloc_caches[NR_KMALLOC_TYPES][KMALLOC_SHIFT_HIGH + 1] __ro_after_init =
 { /* initialization for https://bugs.llvm.org/show_bug.cgi?id=42570 */ };
 EXPORT_SYMBOL(kmalloc_caches);
 
+#ifdef CONFIG_RANDOM_KMALLOC_CACHES
+unsigned long random_kmalloc_seed __ro_after_init;
+EXPORT_SYMBOL(random_kmalloc_seed);
+#endif
+
 /*
  * Conversion table for small slabs sizes / 8 to the index in the
  * kmalloc array. This is necessary for slabs < 192 since we have non power
@@ -720,7 +725,7 @@ static inline unsigned int size_index_elem(unsigned int bytes)
  * Find the kmem_cache structure that serves a given size of
  * allocation
  */
-struct kmem_cache *kmalloc_slab(size_t size, gfp_t flags)
+struct kmem_cache *kmalloc_slab(size_t size, gfp_t flags, unsigned long caller)
 {
 	unsigned int index;
 
@@ -735,7 +740,7 @@ struct kmem_cache *kmalloc_slab(size_t size, gfp_t flags)
 		index = fls(size - 1);
 	}
 
-	return kmalloc_caches[kmalloc_type(flags)][index];
+	return kmalloc_caches[kmalloc_type(flags, caller)][index];
 }
 
 size_t kmalloc_size_roundup(size_t size)
@@ -753,7 +758,7 @@ size_t kmalloc_size_roundup(size_t size)
 		return PAGE_SIZE << get_order(size);
 
 	/* The flags don't matter since size_index is common to all. */
-	c = kmalloc_slab(size, GFP_KERNEL);
+	c = kmalloc_slab(size, GFP_KERNEL, _RET_IP_);
 	return c ? c->object_size : 0;
 }
 EXPORT_SYMBOL(kmalloc_size_roundup);
@@ -776,12 +781,44 @@ EXPORT_SYMBOL(kmalloc_size_roundup);
 #define KMALLOC_RCL_NAME(sz)
 #endif
 
+#ifdef CONFIG_RANDOM_KMALLOC_CACHES
+#define __KMALLOC_RANDOM_CONCAT(a, b) a ## b
+#define KMALLOC_RANDOM_NAME(N, sz) __KMALLOC_RANDOM_CONCAT(KMA_RAND_, N)(sz)
+#if CONFIG_RANDOM_KMALLOC_CACHES_BITS >= 1
+#define KMA_RAND_1(sz)                  .name[KMALLOC_RANDOM_START +  0] = "kmalloc-random-01-" #sz,
+#define KMA_RAND_2(sz)  KMA_RAND_1(sz)  .name[KMALLOC_RANDOM_START +  1] = "kmalloc-random-02-" #sz,
+#endif
+#if CONFIG_RANDOM_KMALLOC_CACHES_BITS >= 2
+#define KMA_RAND_3(sz)  KMA_RAND_1(sz)  .name[KMALLOC_RANDOM_START +  2] = "kmalloc-random-03-" #sz,
+#define KMA_RAND_4(sz)  KMA_RAND_3(sz)  .name[KMALLOC_RANDOM_START +  3] = "kmalloc-random-04-" #sz,
+#endif
+#if CONFIG_RANDOM_KMALLOC_CACHES_BITS >= 3
+#define KMA_RAND_5(sz)  KMA_RAND_4(sz)  .name[KMALLOC_RANDOM_START +  4] = "kmalloc-random-05-" #sz,
+#define KMA_RAND_6(sz)  KMA_RAND_5(sz)  .name[KMALLOC_RANDOM_START +  5] = "kmalloc-random-06-" #sz,
+#define KMA_RAND_7(sz)  KMA_RAND_6(sz)  .name[KMALLOC_RANDOM_START +  6] = "kmalloc-random-07-" #sz,
+#define KMA_RAND_8(sz)  KMA_RAND_7(sz)  .name[KMALLOC_RANDOM_START +  7] = "kmalloc-random-08-" #sz,
+#endif
+#if CONFIG_RANDOM_KMALLOC_CACHES_BITS >= 4
+#define KMA_RAND_9(sz)  KMA_RAND_8(sz)  .name[KMALLOC_RANDOM_START +  8] = "kmalloc-random-09-" #sz,
+#define KMA_RAND_10(sz) KMA_RAND_9(sz)  .name[KMALLOC_RANDOM_START +  9] = "kmalloc-random-10-" #sz,
+#define KMA_RAND_11(sz) KMA_RAND_10(sz) .name[KMALLOC_RANDOM_START + 10] = "kmalloc-random-11-" #sz,
+#define KMA_RAND_12(sz) KMA_RAND_11(sz) .name[KMALLOC_RANDOM_START + 11] = "kmalloc-random-12-" #sz,
+#define KMA_RAND_13(sz) KMA_RAND_12(sz) .name[KMALLOC_RANDOM_START + 12] = "kmalloc-random-13-" #sz,
+#define KMA_RAND_14(sz) KMA_RAND_13(sz) .name[KMALLOC_RANDOM_START + 13] = "kmalloc-random-14-" #sz,
+#define KMA_RAND_15(sz) KMA_RAND_14(sz) .name[KMALLOC_RANDOM_START + 14] = "kmalloc-random-15-" #sz,
+#define KMA_RAND_16(sz) KMA_RAND_15(sz) .name[KMALLOC_RANDOM_START + 15] = "kmalloc-random-16-" #sz,
+#endif
+#else // CONFIG_RANDOM_KMALLOC_CACHES
+#define KMALLOC_RANDOM_NAME(N, sz)
+#endif
+
 #define INIT_KMALLOC_INFO(__size, __short_size)			\
 {								\
 	.name[KMALLOC_NORMAL]  = "kmalloc-" #__short_size,	\
 	KMALLOC_RCL_NAME(__short_size)				\
 	KMALLOC_CGROUP_NAME(__short_size)			\
 	KMALLOC_DMA_NAME(__short_size)				\
+	KMALLOC_RANDOM_NAME(CONFIG_RANDOM_KMALLOC_CACHES_NR, __short_size)	\
 	.size = __size,						\
 }
 
@@ -890,6 +927,11 @@ new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
 		flags |= SLAB_CACHE_DMA;
 	}
 
+#ifdef CONFIG_RANDOM_KMALLOC_CACHES
+	if (type >= KMALLOC_RANDOM_START && type <= KMALLOC_RANDOM_END)
+		flags |= SLAB_NO_MERGE;
+#endif
+
 	if (minalign > ARCH_KMALLOC_MINALIGN) {
 		aligned_size = ALIGN(aligned_size, minalign);
 		aligned_idx = __kmalloc_index(aligned_size, false);
@@ -923,7 +965,7 @@ void __init create_kmalloc_caches(slab_flags_t flags)
 	/*
 	 * Including KMALLOC_CGROUP if CONFIG_MEMCG_KMEM defined
 	 */
-	for (type = KMALLOC_NORMAL; type < NR_KMALLOC_TYPES; type++) {
+	for (type = KMALLOC_RANDOM_START; type < NR_KMALLOC_TYPES; type++) {
 		for (i = KMALLOC_SHIFT_LOW; i <= KMALLOC_SHIFT_HIGH; i++) {
 			if (!kmalloc_caches[type][i])
 				new_kmalloc_cache(i, type, flags);
@@ -941,6 +983,9 @@ void __init create_kmalloc_caches(slab_flags_t flags)
 				new_kmalloc_cache(2, type, flags);
 		}
 	}
+#ifdef CONFIG_RANDOM_KMALLOC_CACHES
+	random_kmalloc_seed = get_random_u64();
+#endif
 
 	/* Kmalloc array is now usable */
 	slab_state = UP;
@@ -976,7 +1021,7 @@ void *__do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller
 		return ret;
 	}
 
-	s = kmalloc_slab(size, flags);
+	s = kmalloc_slab(size, flags, caller);
 
 	if (unlikely(ZERO_OR_NULL_PTR(s)))
 		return s;
-- 
2.25.1


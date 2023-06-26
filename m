Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D01F73D634
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 05:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjFZDP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 23:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjFZDPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 23:15:25 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132A610F;
        Sun, 25 Jun 2023 20:15:22 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QqCdf17c4z4f3nJX;
        Mon, 26 Jun 2023 11:15:18 +0800 (CST)
Received: from ubuntu20.huawei.com (unknown [10.67.174.33])
        by APP2 (Coremail) with SMTP id Syh0CgA33uumAplkXQblMQ--.6560S2;
        Mon, 26 Jun 2023 11:15:16 +0800 (CST)
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
        Markus Elfring <Markus.Elfring@web.de>,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        gongruiqi1@huawei.com
Subject: [PATCH v4] Randomized slab caches for kmalloc()
Date:   Mon, 26 Jun 2023 11:18:35 +0800
Message-Id: <20230626031835.2279738-1-gongruiqi@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgA33uumAplkXQblMQ--.6560S2
X-Coremail-Antispam: 1UD129KBjvAXoW3uw4ktw13XFWDGw4DKF1xXwb_yoW8AFykAo
        WfGF15Aw1fKry3AF4Uuan3GrWDuF9YgwnxZFn8ZrZ5GFyUX34DG3y5trWfWFy5GF1IqFsx
        Ar12ga1UG39Ivr93n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUY87kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
        8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
        AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF
        7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7
        CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
        rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
        IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k2
        0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIx
        AIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
        z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1c4S7UUUUU==
X-CM-SenderInfo: pjrqw2pxltxq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
subsystem/module by analyzing the open source code. In other words, with
the per-boot seed, the random selection is static during each time the
system starts and runs, but not across different system startups.

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

Co-developed-by: Xiu Jianfeng <xiujianfeng@huawei.com>
Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
Signed-off-by: GONG, Ruiqi <gongruiqi@huaweicloud.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---

v4:
  - Set # of cache copies to 16 and remove config selection.
  - Shorten "kmalloc-random-" to "kmalloc-rnd-".
  - Update commit log and config's help paragraph.
  - Fine-tune PERCPU_DYNAMIC_SIZE_SHIFT to 12 instead of 13 (enough to
    pass compilation with allmodconfig and CONFIG_SLUB_TINY=n).
  - Some cleanup and typo fixing.

v3:
  - Replace SLAB_RANDOMSLAB with the new existing SLAB_NO_MERGE flag.
  - Shorten long code lines by wrapping and renaming.
  - Update commit message with latest perf benchmark and additional
    theorectical explanation.
  - Remove "RFC" from patch title and make it a formal patch
  - Link: https://lore.kernel.org/all/20230616111843.3677378-1-gongruiqi@huaweicloud.com/

v2:
  - Use hash_64() and a per-boot random seed to select kmalloc() caches.
  - Change acceptable # of caches from [4,16] to {2,4,8,16}, which is
    more compatible with hashing.
  - Supplement results of performance and memory overhead tests.
  - Link: https://lore.kernel.org/all/20230508075507.1720950-1-gongruiqi1@huawei.com/

v1:
  - Link: https://lore.kernel.org/all/20230315095459.186113-1-gongruiqi1@huawei.com/

 include/linux/percpu.h  | 12 ++++++++---
 include/linux/slab.h    | 25 ++++++++++++++++++----
 mm/Kconfig              | 16 ++++++++++++++
 mm/kfence/kfence_test.c |  6 ++++--
 mm/slab.c               |  2 +-
 mm/slab.h               |  2 +-
 mm/slab_common.c        | 47 ++++++++++++++++++++++++++++++++++++-----
 7 files changed, 94 insertions(+), 16 deletions(-)

diff --git a/include/linux/percpu.h b/include/linux/percpu.h
index 42125cf9c506..7692b5559098 100644
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -34,6 +34,12 @@
 #define PCPU_BITMAP_BLOCK_BITS		(PCPU_BITMAP_BLOCK_SIZE >>	\
 					 PCPU_MIN_ALLOC_SHIFT)
 
+#ifdef CONFIG_RANDOM_KMALLOC_CACHES
+#define PERCPU_DYNAMIC_SIZE_SHIFT      12
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
index 791f7453a04f..747fc2587b56 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -18,6 +18,7 @@
 #include <linux/types.h>
 #include <linux/workqueue.h>
 #include <linux/percpu-refcount.h>
+#include <linux/hash.h>
 
 
 /*
@@ -342,6 +343,13 @@ static inline unsigned int arch_slab_minalign(void)
 #define SLAB_OBJ_MIN_SIZE      (KMALLOC_MIN_SIZE < 16 ? \
                                (KMALLOC_MIN_SIZE) : 16)
 
+#ifdef CONFIG_RANDOM_KMALLOC_CACHES
+#define RANDOM_KMALLOC_CACHES_NR	16 // # of cache copies
+#define RANDOM_KMALLOC_CACHES_BITS	4  // =log2(_NR), for hashing
+#else
+#define RANDOM_KMALLOC_CACHES_NR	1
+#endif
+
 /*
  * Whenever changing this, take care of that kmalloc_type() and
  * create_kmalloc_caches() still work as intended.
@@ -351,7 +359,9 @@ static inline unsigned int arch_slab_minalign(void)
  * kmem caches can have both accounted and unaccounted objects.
  */
 enum kmalloc_cache_type {
-	KMALLOC_NORMAL = 0,
+	KMALLOC_RANDOM_START = 0,
+	KMALLOC_RANDOM_END = KMALLOC_RANDOM_START + RANDOM_KMALLOC_CACHES_NR - 1,
+	KMALLOC_NORMAL = KMALLOC_RANDOM_END,
 #ifndef CONFIG_ZONE_DMA
 	KMALLOC_DMA = KMALLOC_NORMAL,
 #endif
@@ -383,14 +393,21 @@ kmalloc_caches[NR_KMALLOC_TYPES][KMALLOC_SHIFT_HIGH + 1];
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
+						      RANDOM_KMALLOC_CACHES_BITS);
+#else
 		return KMALLOC_NORMAL;
+#endif
 
 	/*
 	 * At least one of the flags has to be set. Their priorities in
@@ -577,7 +594,7 @@ static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
 
 		index = kmalloc_index(size);
 		return kmalloc_trace(
-				kmalloc_caches[kmalloc_type(flags)][index],
+				kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
 				flags, size);
 	}
 	return __kmalloc(size, flags);
@@ -593,7 +610,7 @@ static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t fla
 
 		index = kmalloc_index(size);
 		return kmalloc_node_trace(
-				kmalloc_caches[kmalloc_type(flags)][index],
+				kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
 				flags, node, size);
 	}
 	return __kmalloc_node(size, flags, node);
diff --git a/mm/Kconfig b/mm/Kconfig
index a3c95338cd3a..e9dc606c9317 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -337,6 +337,22 @@ config SLUB_CPU_PARTIAL
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
+	  memory objects on the heap for the purpose of exploiting memory
+	  vulnerabilities.
+
+	  Currently the number of copies is set to 16, a reasonably large value
+	  that effectively diverges the memory objects allocated for different
+	  subsystems or modules into different caches, at the expense of about
+	  7 MB of memory overhead.
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
index fe436d35f333..6f385956ef07 100644
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
@@ -776,12 +781,36 @@ EXPORT_SYMBOL(kmalloc_size_roundup);
 #define KMALLOC_RCL_NAME(sz)
 #endif
 
+#ifdef CONFIG_RANDOM_KMALLOC_CACHES
+#define __KMALLOC_RANDOM_CONCAT(a, b) a ## b
+#define KMALLOC_RANDOM_NAME(N, sz) __KMALLOC_RANDOM_CONCAT(KMA_RAND_, N)(sz)
+#define KMA_RAND_1(sz)                  .name[KMALLOC_RANDOM_START +  0] = "kmalloc-rnd-01-" #sz,
+#define KMA_RAND_2(sz)  KMA_RAND_1(sz)  .name[KMALLOC_RANDOM_START +  1] = "kmalloc-rnd-02-" #sz,
+#define KMA_RAND_3(sz)  KMA_RAND_2(sz)  .name[KMALLOC_RANDOM_START +  2] = "kmalloc-rnd-03-" #sz,
+#define KMA_RAND_4(sz)  KMA_RAND_3(sz)  .name[KMALLOC_RANDOM_START +  3] = "kmalloc-rnd-04-" #sz,
+#define KMA_RAND_5(sz)  KMA_RAND_4(sz)  .name[KMALLOC_RANDOM_START +  4] = "kmalloc-rnd-05-" #sz,
+#define KMA_RAND_6(sz)  KMA_RAND_5(sz)  .name[KMALLOC_RANDOM_START +  5] = "kmalloc-rnd-06-" #sz,
+#define KMA_RAND_7(sz)  KMA_RAND_6(sz)  .name[KMALLOC_RANDOM_START +  6] = "kmalloc-rnd-07-" #sz,
+#define KMA_RAND_8(sz)  KMA_RAND_7(sz)  .name[KMALLOC_RANDOM_START +  7] = "kmalloc-rnd-08-" #sz,
+#define KMA_RAND_9(sz)  KMA_RAND_8(sz)  .name[KMALLOC_RANDOM_START +  8] = "kmalloc-rnd-09-" #sz,
+#define KMA_RAND_10(sz) KMA_RAND_9(sz)  .name[KMALLOC_RANDOM_START +  9] = "kmalloc-rnd-10-" #sz,
+#define KMA_RAND_11(sz) KMA_RAND_10(sz) .name[KMALLOC_RANDOM_START + 10] = "kmalloc-rnd-11-" #sz,
+#define KMA_RAND_12(sz) KMA_RAND_11(sz) .name[KMALLOC_RANDOM_START + 11] = "kmalloc-rnd-12-" #sz,
+#define KMA_RAND_13(sz) KMA_RAND_12(sz) .name[KMALLOC_RANDOM_START + 12] = "kmalloc-rnd-13-" #sz,
+#define KMA_RAND_14(sz) KMA_RAND_13(sz) .name[KMALLOC_RANDOM_START + 13] = "kmalloc-rnd-14-" #sz,
+#define KMA_RAND_15(sz) KMA_RAND_14(sz) .name[KMALLOC_RANDOM_START + 14] = "kmalloc-rnd-15-" #sz,
+#define KMA_RAND_16(sz) KMA_RAND_15(sz) .name[KMALLOC_RANDOM_START + 15] = "kmalloc-rnd-16-" #sz,
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
+	KMALLOC_RANDOM_NAME(RANDOM_KMALLOC_CACHES_NR, __short_size)	\
 	.size = __size,						\
 }
 
@@ -890,6 +919,11 @@ new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
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
@@ -923,7 +957,7 @@ void __init create_kmalloc_caches(slab_flags_t flags)
 	/*
 	 * Including KMALLOC_CGROUP if CONFIG_MEMCG_KMEM defined
 	 */
-	for (type = KMALLOC_NORMAL; type < NR_KMALLOC_TYPES; type++) {
+	for (type = KMALLOC_RANDOM_START; type < NR_KMALLOC_TYPES; type++) {
 		for (i = KMALLOC_SHIFT_LOW; i <= KMALLOC_SHIFT_HIGH; i++) {
 			if (!kmalloc_caches[type][i])
 				new_kmalloc_cache(i, type, flags);
@@ -941,6 +975,9 @@ void __init create_kmalloc_caches(slab_flags_t flags)
 				new_kmalloc_cache(2, type, flags);
 		}
 	}
+#ifdef CONFIG_RANDOM_KMALLOC_CACHES
+	random_kmalloc_seed = get_random_u64();
+#endif
 
 	/* Kmalloc array is now usable */
 	slab_state = UP;
@@ -976,7 +1013,7 @@ void *__do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller
 		return ret;
 	}
 
-	s = kmalloc_slab(size, flags);
+	s = kmalloc_slab(size, flags, caller);
 
 	if (unlikely(ZERO_OR_NULL_PTR(s)))
 		return s;
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BC8615796
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 03:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiKBCbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 22:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiKBCbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 22:31:07 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E335DEF0
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 19:31:03 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id 4so15313184pli.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 19:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CuWtSmf4Qlv7AGLUp00LMbbHPRnO0zZp2srC3uiWl7c=;
        b=hOYAXXK87MRcWx/wy770qDTFJ4FQEO44kGY1Aj+D8GhNaHPSyumO97YhheB9tdD2KL
         1M9J13l+zOaAAvENBbl071h1uP7JVclrc24/TdtPLJY+n3TXwB1F/i5Wb6NMdlZznZqj
         vXPEBU/+E9Ko9iO8Yu34+iw9VTbcJtr37+j3fid+B8Sg/0Ym6h41m3xIEvL6YGR9SB+l
         7V9Yyl0rMuHuRjFVBAzUnuI/o0aLBNy1XrUfGUossOntZQ+IkPvPD45ebQfYzgieb+5y
         SYwygrKXcS1eMkAGAYuVbjYjjCmuJi1r4UgKRt01pHp9lshTJb5jyTPvW+tEQHEDqLzM
         USmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CuWtSmf4Qlv7AGLUp00LMbbHPRnO0zZp2srC3uiWl7c=;
        b=pnvaxYDEBDQlb+3yZA/HouCHSQnJVHcw+ABevqiDVNGXmoqdHp9cq+w1Ld2Y44JIa7
         uo1fqayWLlAZ2PnOXGIjvS0ybKdD7cVE3NmCIFNBx+ODya7nLexs49cuAVFXAqyO/Guw
         Yrr9ILtaYhXRvmfzny5AAT7Ox5MJRToisdVFReaM6ucV0MvfKtdWriLXbOhivGwEVcIz
         F7NRYPhBSOqcQL8ylZoZ2WKz53dc6QmUSIdY0khs4oundM9j0k7S/10uniPVaFjHTs73
         Wid9CrqlyPw9YG4uAdZmj/PMFTcjOccOhhYZdY2xThrLAg16vGpYgKvBtWd1Ulo846dA
         gBTA==
X-Gm-Message-State: ACrzQf2rXeTR69hc+uFlXtCpXSzkN7xGwceLwu/wEqlk6283QpCwyqVL
        2xsmp+zIJcJu6FVzCIa4HVN3SgKpf/51YQ==
X-Google-Smtp-Source: AMsMyM71pQB2HgbHZjjQuRiOyT+2Mi/twUG38KFlMSAC/v87MJnjEem5hxKbVIq0Uw7KHeezzvZOAQ==
X-Received: by 2002:a17:902:d38d:b0:186:9fc5:6c13 with SMTP id e13-20020a170902d38d00b001869fc56c13mr22534799pld.73.1667356262016;
        Tue, 01 Nov 2022 19:31:02 -0700 (PDT)
Received: from devtp.bytedance.net ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id t188-20020a625fc5000000b0056dae187730sm2962712pfb.96.2022.11.01.19.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 19:31:01 -0700 (PDT)
From:   wuqiang <wuqiang.matt@bytedance.com>
To:     mhiramat@kernel.org, davem@davemloft.net,
        anil.s.keshavamurthy@intel.com, naveen.n.rao@linux.ibm.com,
        rostedt@goodmis.org, peterz@infradead.org,
        akpm@linux-foundation.org, sander@svanheule.net,
        ebiggers@google.com, dan.j.williams@intel.com, jpoimboe@kernel.org
Cc:     linux-kernel@vger.kernel.org, mattwu@163.com,
        wuqiang <wuqiang.matt@bytedance.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v4] kprobes,lib: kretprobe scalability improvement
Date:   Wed,  2 Nov 2022 10:30:12 +0800
Message-Id: <20221102023012.6362-1-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221101014346.150812-1-wuqiang.matt@bytedance.com>
References: <20221101014346.150812-1-wuqiang.matt@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kretprobe is using freelist to manage return-instances, but freelist,
as LIFO queue based on singly linked list, scales badly and reduces
the overall throughput of kretprobed routines, especially for high
contention scenarios.

Here's a typical throughput test of sys_flock (counts in 10 seconds,
measured with perf stat -a -I 10000 -e syscalls:sys_enter_flock):

OS: Debian 10 X86_64, Linux 6.1rc2
HW: XEON 8336C x 2, 64 cores/128 threads, DDR4 3200MT/s

      1X       2X       4X       6X       8X      12X      16X
34762430 36546920 17949900 13101899 12569595 12646601 14729195
     24X      32X      48X      64X      72X      96X     128X
19263546 10102064  8985418 11936495 11493980  7127789  9330985

This patch implements a scalable, lock-less and numa-aware object pool,
which brings near-linear scalability to kretprobed routines. Tests of
kretprobe throughput show the biggest ratio as 333.9x of the original
freelist. Here's the comparison:

                  1X         2X         4X         8X        16X
freelist:   34762430   36546920   17949900   12569595   14729195
objpool:    35627544   72182095  144068494  287564688  576903916
                 32X        48X        64X        96X       128X
freelist:   10102064    8985418   11936495    7127789    9330985
objpool:  1158876372 1737828164 2324371724 2380310472 2463182819

Tests on 96-core ARM64 system output similarly, but with the biggest
ratio up to 642.2x:

OS: Debian 10 AARCH64, Linux 6.1rc2
HW: Kunpeng-920 96 cores/2 sockets/4 NUMA nodes, DDR4 2933 MT/s

                  1X         2X         4X         8X        16X
freelist:   17498299   10887037   10224710    8499132    6421751
objpool:    18715726   35549845   71615884  144258971  283707220
                 24X        32X        48X        64X        96X
freelist:    5339868    4819116    3593919    3121575    2687167
objpool:   419830913  571609748  877456139 1143316315 1725668029

The object pool, leveraging percpu ring-array to mitigate hot spots
of memory contention, could deliver near-linear scalability for high
parallel scenarios. The ring-array is compactly managed in a single
cacheline (64 bytes) to benefit from warmed L1 cache for most cases
(<= 4 instances per core) and objects are managed in the continuous
cachelines just after ring-array.

Changes since V3:
1) build warning: unused variable in fprobe_init_rethook
Reported-by: kernel test robot <lkp@intel.com>

Changes since V2:
1) the percpu-extended version of the freelist replaced by new percpu-
   ring-array. freelist has data-contention in freelist_node (refs and
   next) even after node is removed from freelist and the node could
   be polluted easily (with freelist_node defined in union)
2) routines split to objpool.h and objpool.c according to cold & hot
   pathes, and the latter moved to lib, as suggested by Masami
3) test module (test_objpool.ko) added to lib for functional testings

Changes since V1:
1) reformat to a single patch as Masami Hiramatsu suggested
2) use __vmalloc_node to replace vmalloc_node for vmalloc
3) a few minor fixes: typo and coding-style issues

Signed-off-by: wuqiang <wuqiang.matt@bytedance.com>
---
 include/linux/freelist.h |  129 -----
 include/linux/kprobes.h  |    9 +-
 include/linux/objpool.h  |  151 ++++++
 include/linux/rethook.h  |   15 +-
 kernel/kprobes.c         |   95 ++--
 kernel/trace/fprobe.c    |   17 +-
 kernel/trace/rethook.c   |   80 +--
 lib/Kconfig.debug        |   11 +
 lib/Makefile             |    4 +-
 lib/objpool.c            |  480 ++++++++++++++++++
 lib/test_objpool.c       | 1031 ++++++++++++++++++++++++++++++++++++++
 11 files changed, 1772 insertions(+), 250 deletions(-)
 delete mode 100644 include/linux/freelist.h
 create mode 100644 include/linux/objpool.h
 create mode 100644 lib/objpool.c
 create mode 100644 lib/test_objpool.c

diff --git a/include/linux/freelist.h b/include/linux/freelist.h
deleted file mode 100644
index fc1842b96469..000000000000
--- a/include/linux/freelist.h
+++ /dev/null
@@ -1,129 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
-#ifndef FREELIST_H
-#define FREELIST_H
-
-#include <linux/atomic.h>
-
-/*
- * Copyright: cameron@moodycamel.com
- *
- * A simple CAS-based lock-free free list. Not the fastest thing in the world
- * under heavy contention, but simple and correct (assuming nodes are never
- * freed until after the free list is destroyed), and fairly speedy under low
- * contention.
- *
- * Adapted from: https://moodycamel.com/blog/2014/solving-the-aba-problem-for-lock-free-free-lists
- */
-
-struct freelist_node {
-	atomic_t		refs;
-	struct freelist_node	*next;
-};
-
-struct freelist_head {
-	struct freelist_node	*head;
-};
-
-#define REFS_ON_FREELIST 0x80000000
-#define REFS_MASK	 0x7FFFFFFF
-
-static inline void __freelist_add(struct freelist_node *node, struct freelist_head *list)
-{
-	/*
-	 * Since the refcount is zero, and nobody can increase it once it's
-	 * zero (except us, and we run only one copy of this method per node at
-	 * a time, i.e. the single thread case), then we know we can safely
-	 * change the next pointer of the node; however, once the refcount is
-	 * back above zero, then other threads could increase it (happens under
-	 * heavy contention, when the refcount goes to zero in between a load
-	 * and a refcount increment of a node in try_get, then back up to
-	 * something non-zero, then the refcount increment is done by the other
-	 * thread) -- so if the CAS to add the node to the actual list fails,
-	 * decrese the refcount and leave the add operation to the next thread
-	 * who puts the refcount back to zero (which could be us, hence the
-	 * loop).
-	 */
-	struct freelist_node *head = READ_ONCE(list->head);
-
-	for (;;) {
-		WRITE_ONCE(node->next, head);
-		atomic_set_release(&node->refs, 1);
-
-		if (!try_cmpxchg_release(&list->head, &head, node)) {
-			/*
-			 * Hmm, the add failed, but we can only try again when
-			 * the refcount goes back to zero.
-			 */
-			if (atomic_fetch_add_release(REFS_ON_FREELIST - 1, &node->refs) == 1)
-				continue;
-		}
-		return;
-	}
-}
-
-static inline void freelist_add(struct freelist_node *node, struct freelist_head *list)
-{
-	/*
-	 * We know that the should-be-on-freelist bit is 0 at this point, so
-	 * it's safe to set it using a fetch_add.
-	 */
-	if (!atomic_fetch_add_release(REFS_ON_FREELIST, &node->refs)) {
-		/*
-		 * Oh look! We were the last ones referencing this node, and we
-		 * know we want to add it to the free list, so let's do it!
-		 */
-		__freelist_add(node, list);
-	}
-}
-
-static inline struct freelist_node *freelist_try_get(struct freelist_head *list)
-{
-	struct freelist_node *prev, *next, *head = smp_load_acquire(&list->head);
-	unsigned int refs;
-
-	while (head) {
-		prev = head;
-		refs = atomic_read(&head->refs);
-		if ((refs & REFS_MASK) == 0 ||
-		    !atomic_try_cmpxchg_acquire(&head->refs, &refs, refs+1)) {
-			head = smp_load_acquire(&list->head);
-			continue;
-		}
-
-		/*
-		 * Good, reference count has been incremented (it wasn't at
-		 * zero), which means we can read the next and not worry about
-		 * it changing between now and the time we do the CAS.
-		 */
-		next = READ_ONCE(head->next);
-		if (try_cmpxchg_acquire(&list->head, &head, next)) {
-			/*
-			 * Yay, got the node. This means it was on the list,
-			 * which means should-be-on-freelist must be false no
-			 * matter the refcount (because nobody else knows it's
-			 * been taken off yet, it can't have been put back on).
-			 */
-			WARN_ON_ONCE(atomic_read(&head->refs) & REFS_ON_FREELIST);
-
-			/*
-			 * Decrease refcount twice, once for our ref, and once
-			 * for the list's ref.
-			 */
-			atomic_fetch_add(-2, &head->refs);
-
-			return head;
-		}
-
-		/*
-		 * OK, the head must have changed on us, but we still need to decrement
-		 * the refcount we increased.
-		 */
-		refs = atomic_fetch_add(-1, &prev->refs);
-		if (refs == REFS_ON_FREELIST + 1)
-			__freelist_add(prev, list);
-	}
-
-	return NULL;
-}
-
-#endif /* FREELIST_H */
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index a0b92be98984..f13f01e600c2 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -27,7 +27,7 @@
 #include <linux/mutex.h>
 #include <linux/ftrace.h>
 #include <linux/refcount.h>
-#include <linux/freelist.h>
+#include <linux/objpool.h>
 #include <linux/rethook.h>
 #include <asm/kprobes.h>
 
@@ -141,6 +141,7 @@ static inline bool kprobe_ftrace(struct kprobe *p)
  */
 struct kretprobe_holder {
 	struct kretprobe	*rp;
+	struct objpool_head	oh;
 	refcount_t		ref;
 };
 
@@ -154,7 +155,6 @@ struct kretprobe {
 #ifdef CONFIG_KRETPROBE_ON_RETHOOK
 	struct rethook *rh;
 #else
-	struct freelist_head freelist;
 	struct kretprobe_holder *rph;
 #endif
 };
@@ -165,10 +165,7 @@ struct kretprobe_instance {
 #ifdef CONFIG_KRETPROBE_ON_RETHOOK
 	struct rethook_node node;
 #else
-	union {
-		struct freelist_node freelist;
-		struct rcu_head rcu;
-	};
+	struct rcu_head rcu;
 	struct llist_node llist;
 	struct kretprobe_holder *rph;
 	kprobe_opcode_t *ret_addr;
diff --git a/include/linux/objpool.h b/include/linux/objpool.h
new file mode 100644
index 000000000000..0b746187482a
--- /dev/null
+++ b/include/linux/objpool.h
@@ -0,0 +1,151 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LINUX_OBJPOOL_H
+#define _LINUX_OBJPOOL_H
+
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/atomic.h>
+
+/*
+ * objpool: ring-array based lockless MPMC/FIFO queues
+ *
+ * Copyright: wuqiang.matt@bytedance.com
+ *
+ * The object pool is a scalable implementaion of high performance queue
+ * for objects allocation and reclamation, such as kretprobe instances.
+ *
+ * With leveraging per-cpu ring-array to mitigate the hot spots of memory
+ * contention, it could deliver near-linear scalability for high parallel
+ * cases. Meanwhile, it also achieves high throughput with benifiting from
+ * warmed cache on each core.
+ *
+ * The object pool are best suited for the following cases:
+ * 1) memory allocation or reclamation is prohibited or too expensive
+ * 2) the objects are allocated/used/reclaimed very frequently
+ *
+ * Before using, you must be aware of it's limitations:
+ * 1) Maximum number of objects is determined during pool initializing
+ * 2) The memory of objects won't be freed until the poll is de-allocated
+ * 3) Both allocation and reclamation could be nested
+ */
+
+/*
+ * objpool_slot: per-cpu ring array
+ *
+ * Represents a cpu-local array-based ring buffer, its size is specialized
+ * during initialization of object pool.
+ *
+ * The objpool_slot is allocated from local memory for NUMA system, and to
+ * be kept compact in a single cacheline. ages[] is stored just after the
+ * body of objpool_slot, and ents[] is after ages[]. ages[] describes the
+ * revision of epoch of the item, solely used to avoid ABA. ents[] contains
+ * the object pointers.
+ *
+ * The default size of objpool_slot is a single cacheline, aka. 64 bytes.
+ *
+ * 64bit:
+ *        4      8      12     16        32                 64
+ * | head | tail | size | mask | ages[4] | ents[4]: (8 * 4) |
+ *
+ * 32bit:
+ *        4      8      12     16        32        48       64
+ * | head | tail | size | mask | ages[4] | ents[4] | unused |
+ *
+ */
+
+struct objpool_slot {
+	uint32_t                os_head;	/* head of ring array */
+	uint32_t                os_tail;	/* tail of ring array */
+	uint32_t                os_size;	/* max item slots, pow of 2 */
+	uint32_t                os_mask;	/* os_size - 1 */
+/*
+ *	uint32_t                os_ages[];	// ring epoch id
+ *	void                   *os_ents[];	// objects array
+ */
+};
+
+/* caller-specified object initial callback to setup each object, only called once */
+typedef int (*objpool_init_node_cb)(void *context, void *obj);
+
+/* caller-specified cleanup callback for private objects/pool/context */
+typedef int (*objpool_release_cb)(void *context, void *ptr, uint32_t flags);
+
+/* called for object releasing: ptr points to an object */
+#define OBJPOOL_FLAG_NODE        (0x00000001)
+/* for user pool and context releasing, ptr could be NULL */
+#define OBJPOOL_FLAG_POOL        (0x00001000)
+/* the object or pool to be released is user-managed */
+#define OBJPOOL_FLAG_USER        (0x00008000)
+
+/*
+ * objpool_head: object pooling metadata
+ */
+
+struct objpool_head {
+	uint32_t                oh_objsz;	/* object & element size */
+	uint32_t                oh_nobjs;	/* total objs (pre-allocated) */
+	uint32_t                oh_nents;	/* max objects per cpuslot */
+	uint32_t                oh_ncpus;	/* num of possible cpus */
+	uint32_t                oh_in_user:1;	/* user-specified buffer */
+	uint32_t                oh_in_slot:1;	/* objs alloced with slots */
+	uint32_t                oh_vmalloc:1;	/* alloc from vmalloc zone */
+	gfp_t                   oh_gfp;		/* k/vmalloc gfp flags */
+	uint32_t                oh_sz_pool;	/* user pool size in byes */
+	void                   *oh_pool;	/* user managed memory pool */
+	struct objpool_slot   **oh_slots;	/* array of percpu slots */
+	uint32_t               *oh_sz_slots;	/* size in bytes of slots */
+	objpool_release_cb      oh_release;	/* resource cleanup callback */
+	void                   *oh_context;	/* caller-provided context */
+};
+
+/* initialize object pool and pre-allocate objects */
+int objpool_init(struct objpool_head *oh,
+		int nobjs, int max, int objsz,
+		gfp_t gfp, void *context,
+		objpool_init_node_cb objinit,
+		objpool_release_cb release);
+
+/* add objects in batch from user provided pool */
+int objpool_populate(struct objpool_head *oh, void *buf,
+			int size, int objsz, void *context,
+			objpool_init_node_cb objinit);
+
+/* add pre-allocated object (managed by user) to objpool */
+int objpool_add(void *obj, struct objpool_head *oh);
+
+/* allocate an object from objects pool */
+void *objpool_pop(struct objpool_head *oh);
+
+/* reclaim an object and return it back to objects pool */
+int objpool_push(void *node, struct objpool_head *oh);
+
+/* cleanup the whole object pool (including all chained objects) */
+void objpool_fini(struct objpool_head *oh);
+
+/* whether the object is pre-allocated with percpu slots */
+static inline int objpool_is_inslot(void *obj, struct objpool_head *oh)
+{
+	void *slot;
+	int i;
+
+	if (!obj)
+		return 0;
+
+	for (i = 0; i < oh->oh_ncpus; i++) {
+		slot = oh->oh_slots[i];
+		if (obj >= slot && obj < slot + oh->oh_sz_slots[i])
+			return 1;
+	}
+
+	return 0;
+}
+
+/* whether the object is from user pool (batched adding) */
+static inline int objpool_is_inpool(void *obj, struct objpool_head *oh)
+{
+	return (obj && oh->oh_pool && obj >= oh->oh_pool &&
+		obj < oh->oh_pool + oh->oh_sz_pool);
+}
+
+#endif /* _LINUX_OBJPOOL_H */
diff --git a/include/linux/rethook.h b/include/linux/rethook.h
index c8ac1e5afcd1..278ec65e71fe 100644
--- a/include/linux/rethook.h
+++ b/include/linux/rethook.h
@@ -6,7 +6,7 @@
 #define _LINUX_RETHOOK_H
 
 #include <linux/compiler.h>
-#include <linux/freelist.h>
+#include <linux/objpool.h>
 #include <linux/kallsyms.h>
 #include <linux/llist.h>
 #include <linux/rcupdate.h>
@@ -30,14 +30,14 @@ typedef void (*rethook_handler_t) (struct rethook_node *, void *, struct pt_regs
 struct rethook {
 	void			*data;
 	rethook_handler_t	handler;
-	struct freelist_head	pool;
+	struct objpool_head	pool;
 	refcount_t		ref;
 	struct rcu_head		rcu;
 };
 
 /**
  * struct rethook_node - The rethook shadow-stack entry node.
- * @freelist: The freelist, linked to struct rethook::pool.
+ * @nod: The objpool node, linked to struct rethook::pool.
  * @rcu: The rcu_head for deferred freeing.
  * @llist: The llist, linked to a struct task_struct::rethooks.
  * @rethook: The pointer to the struct rethook.
@@ -48,19 +48,15 @@ struct rethook {
  * on each entry of the shadow stack.
  */
 struct rethook_node {
-	union {
-		struct freelist_node freelist;
-		struct rcu_head      rcu;
-	};
+	struct rcu_head		rcu;
 	struct llist_node	llist;
 	struct rethook		*rethook;
 	unsigned long		ret_addr;
 	unsigned long		frame;
 };
 
-struct rethook *rethook_alloc(void *data, rethook_handler_t handler);
+struct rethook *rethook_alloc(void *data, rethook_handler_t handler, gfp_t gfp, int size, int max);
 void rethook_free(struct rethook *rh);
-void rethook_add_node(struct rethook *rh, struct rethook_node *node);
 struct rethook_node *rethook_try_get(struct rethook *rh);
 void rethook_recycle(struct rethook_node *node);
 void rethook_hook(struct rethook_node *node, struct pt_regs *regs, bool mcount);
@@ -97,4 +93,3 @@ void rethook_flush_task(struct task_struct *tk);
 #endif
 
 #endif
-
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index b781dee3f552..42cb708c3248 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1865,10 +1865,12 @@ static struct notifier_block kprobe_exceptions_nb = {
 static void free_rp_inst_rcu(struct rcu_head *head)
 {
 	struct kretprobe_instance *ri = container_of(head, struct kretprobe_instance, rcu);
+	struct kretprobe_holder *rph = ri->rph;
 
-	if (refcount_dec_and_test(&ri->rph->ref))
-		kfree(ri->rph);
-	kfree(ri);
+	if (refcount_dec_and_test(&rph->ref)) {
+		objpool_fini(&rph->oh);
+		kfree(rph);
+	}
 }
 NOKPROBE_SYMBOL(free_rp_inst_rcu);
 
@@ -1877,7 +1879,7 @@ static void recycle_rp_inst(struct kretprobe_instance *ri)
 	struct kretprobe *rp = get_kretprobe(ri);
 
 	if (likely(rp))
-		freelist_add(&ri->freelist, &rp->freelist);
+		objpool_push(ri, &rp->rph->oh);
 	else
 		call_rcu(&ri->rcu, free_rp_inst_rcu);
 }
@@ -1914,23 +1916,19 @@ NOKPROBE_SYMBOL(kprobe_flush_task);
 
 static inline void free_rp_inst(struct kretprobe *rp)
 {
-	struct kretprobe_instance *ri;
-	struct freelist_node *node;
-	int count = 0;
-
-	node = rp->freelist.head;
-	while (node) {
-		ri = container_of(node, struct kretprobe_instance, freelist);
-		node = node->next;
-
-		kfree(ri);
-		count++;
-	}
+	struct kretprobe_holder *rph = rp->rph;
+	void *nod;
 
-	if (refcount_sub_and_test(count, &rp->rph->ref)) {
-		kfree(rp->rph);
-		rp->rph = NULL;
-	}
+	rp->rph = NULL;
+	do {
+		nod = objpool_pop(&rph->oh);
+		/* deref anyway since we've one extra ref grabbed */
+		if (refcount_dec_and_test(&rph->ref)) {
+			objpool_fini(&rph->oh);
+			kfree(rph);
+			break;
+		}
+	} while (nod);
 }
 
 /* This assumes the 'tsk' is the current task or the is not running. */
@@ -2072,19 +2070,17 @@ NOKPROBE_SYMBOL(__kretprobe_trampoline_handler)
 static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
 {
 	struct kretprobe *rp = container_of(p, struct kretprobe, kp);
+	struct kretprobe_holder *rph = rp->rph;
 	struct kretprobe_instance *ri;
-	struct freelist_node *fn;
 
-	fn = freelist_try_get(&rp->freelist);
-	if (!fn) {
+	ri = objpool_pop(&rph->oh);
+	if (!ri) {
 		rp->nmissed++;
 		return 0;
 	}
 
-	ri = container_of(fn, struct kretprobe_instance, freelist);
-
 	if (rp->entry_handler && rp->entry_handler(ri, regs)) {
-		freelist_add(&ri->freelist, &rp->freelist);
+		objpool_push(ri, &rph->oh);
 		return 0;
 	}
 
@@ -2174,10 +2170,19 @@ int kprobe_on_func_entry(kprobe_opcode_t *addr, const char *sym, unsigned long o
 	return 0;
 }
 
+#ifndef CONFIG_KRETPROBE_ON_RETHOOK
+static int kretprobe_init_inst(void *context, void *nod)
+{
+	struct kretprobe_instance *ri = nod;
+
+	ri->rph = context;
+	return 0;
+}
+#endif
+
 int register_kretprobe(struct kretprobe *rp)
 {
 	int ret;
-	struct kretprobe_instance *inst;
 	int i;
 	void *addr;
 
@@ -2215,20 +2220,12 @@ int register_kretprobe(struct kretprobe *rp)
 #endif
 	}
 #ifdef CONFIG_KRETPROBE_ON_RETHOOK
-	rp->rh = rethook_alloc((void *)rp, kretprobe_rethook_handler);
+	rp->rh = rethook_alloc((void *)rp, kretprobe_rethook_handler, GFP_KERNEL,
+				sizeof(struct kretprobe_instance) + rp->data_size,
+				rp->maxactive);
 	if (!rp->rh)
 		return -ENOMEM;
 
-	for (i = 0; i < rp->maxactive; i++) {
-		inst = kzalloc(sizeof(struct kretprobe_instance) +
-			       rp->data_size, GFP_KERNEL);
-		if (inst == NULL) {
-			rethook_free(rp->rh);
-			rp->rh = NULL;
-			return -ENOMEM;
-		}
-		rethook_add_node(rp->rh, &inst->node);
-	}
 	rp->nmissed = 0;
 	/* Establish function entry probe point */
 	ret = register_kprobe(&rp->kp);
@@ -2237,25 +2234,19 @@ int register_kretprobe(struct kretprobe *rp)
 		rp->rh = NULL;
 	}
 #else	/* !CONFIG_KRETPROBE_ON_RETHOOK */
-	rp->freelist.head = NULL;
 	rp->rph = kzalloc(sizeof(struct kretprobe_holder), GFP_KERNEL);
 	if (!rp->rph)
 		return -ENOMEM;
 
-	rp->rph->rp = rp;
-	for (i = 0; i < rp->maxactive; i++) {
-		inst = kzalloc(sizeof(struct kretprobe_instance) +
-			       rp->data_size, GFP_KERNEL);
-		if (inst == NULL) {
-			refcount_set(&rp->rph->ref, i);
-			free_rp_inst(rp);
-			return -ENOMEM;
-		}
-		inst->rph = rp->rph;
-		freelist_add(&inst->freelist, &rp->freelist);
+	if (objpool_init(&rp->rph->oh, rp->maxactive, rp->maxactive,
+			  rp->data_size + sizeof(struct kretprobe_instance),
+			  GFP_KERNEL, rp->rph, kretprobe_init_inst, NULL)) {
+		kfree(rp->rph);
+		rp->rph = NULL;
+		return -ENOMEM;
 	}
-	refcount_set(&rp->rph->ref, i);
-
+	refcount_set(&rp->rph->ref, rp->maxactive + 1);
+	rp->rph->rp = rp;
 	rp->nmissed = 0;
 	/* Establish function entry probe point */
 	ret = register_kprobe(&rp->kp);
diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index aac63ca9c3d1..99b4ab0f6468 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -125,7 +125,7 @@ static void fprobe_init(struct fprobe *fp)
 
 static int fprobe_init_rethook(struct fprobe *fp, int num)
 {
-	int i, size;
+	int size;
 
 	if (num < 0)
 		return -EINVAL;
@@ -140,18 +140,11 @@ static int fprobe_init_rethook(struct fprobe *fp, int num)
 	if (size < 0)
 		return -E2BIG;
 
-	fp->rethook = rethook_alloc((void *)fp, fprobe_exit_handler);
-	for (i = 0; i < size; i++) {
-		struct fprobe_rethook_node *node;
+	fp->rethook = rethook_alloc((void *)fp, fprobe_exit_handler, GFP_KERNEL,
+				sizeof(struct fprobe_rethook_node), size);
+	if (!fp->rethook)
+		return -ENOMEM;
 
-		node = kzalloc(sizeof(*node), GFP_KERNEL);
-		if (!node) {
-			rethook_free(fp->rethook);
-			fp->rethook = NULL;
-			return -ENOMEM;
-		}
-		rethook_add_node(fp->rethook, &node->node);
-	}
 	return 0;
 }
 
diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
index c69d82273ce7..01df98db2fbe 100644
--- a/kernel/trace/rethook.c
+++ b/kernel/trace/rethook.c
@@ -36,21 +36,17 @@ void rethook_flush_task(struct task_struct *tk)
 static void rethook_free_rcu(struct rcu_head *head)
 {
 	struct rethook *rh = container_of(head, struct rethook, rcu);
-	struct rethook_node *rhn;
-	struct freelist_node *node;
-	int count = 1;
+	struct rethook_node *nod;
 
-	node = rh->pool.head;
-	while (node) {
-		rhn = container_of(node, struct rethook_node, freelist);
-		node = node->next;
-		kfree(rhn);
-		count++;
-	}
-
-	/* The rh->ref is the number of pooled node + 1 */
-	if (refcount_sub_and_test(count, &rh->ref))
-		kfree(rh);
+	do {
+		nod = objpool_pop(&rh->pool);
+		/* deref anyway since we've one extra ref grabbed */
+		if (refcount_dec_and_test(&rh->ref)) {
+			objpool_fini(&rh->pool);
+			kfree(rh);
+			break;
+		}
+	} while (nod);
 }
 
 /**
@@ -70,16 +66,28 @@ void rethook_free(struct rethook *rh)
 	call_rcu(&rh->rcu, rethook_free_rcu);
 }
 
+static int rethook_init_node(void *context, void *nod)
+{
+	struct rethook_node *node = nod;
+
+	node->rethook = context;
+	return 0;
+}
+
 /**
  * rethook_alloc() - Allocate struct rethook.
  * @data: a data to pass the @handler when hooking the return.
  * @handler: the return hook callback function.
+ * @gfp: default gfp for objpool allocation
+ * @size: rethook node size
+ * @max: number of rethook nodes to be preallocated
  *
  * Allocate and initialize a new rethook with @data and @handler.
  * Return NULL if memory allocation fails or @handler is NULL.
  * Note that @handler == NULL means this rethook is going to be freed.
  */
-struct rethook *rethook_alloc(void *data, rethook_handler_t handler)
+struct rethook *rethook_alloc(void *data, rethook_handler_t handler, gfp_t gfp,
+			      int size, int max)
 {
 	struct rethook *rh = kzalloc(sizeof(struct rethook), GFP_KERNEL);
 
@@ -88,34 +96,26 @@ struct rethook *rethook_alloc(void *data, rethook_handler_t handler)
 
 	rh->data = data;
 	rh->handler = handler;
-	rh->pool.head = NULL;
-	refcount_set(&rh->ref, 1);
 
+	/* initialize the objpool for rethook nodes */
+	if (objpool_init(&rh->pool, max, max, size, gfp, rh, rethook_init_node,
+			NULL)) {
+		kfree(rh);
+		return NULL;
+	}
+	refcount_set(&rh->ref, max + 1);
 	return rh;
 }
 
-/**
- * rethook_add_node() - Add a new node to the rethook.
- * @rh: the struct rethook.
- * @node: the struct rethook_node to be added.
- *
- * Add @node to @rh. User must allocate @node (as a part of user's
- * data structure.) The @node fields are initialized in this function.
- */
-void rethook_add_node(struct rethook *rh, struct rethook_node *node)
-{
-	node->rethook = rh;
-	freelist_add(&node->freelist, &rh->pool);
-	refcount_inc(&rh->ref);
-}
-
 static void free_rethook_node_rcu(struct rcu_head *head)
 {
 	struct rethook_node *node = container_of(head, struct rethook_node, rcu);
+	struct rethook *rh = node->rethook;
 
-	if (refcount_dec_and_test(&node->rethook->ref))
-		kfree(node->rethook);
-	kfree(node);
+	if (refcount_dec_and_test(&rh->ref)) {
+		objpool_fini(&rh->pool);
+		kfree(rh);
+	}
 }
 
 /**
@@ -130,7 +130,7 @@ void rethook_recycle(struct rethook_node *node)
 	lockdep_assert_preemption_disabled();
 
 	if (likely(READ_ONCE(node->rethook->handler)))
-		freelist_add(&node->freelist, &node->rethook->pool);
+		objpool_push(node, &node->rethook->pool);
 	else
 		call_rcu(&node->rcu, free_rethook_node_rcu);
 }
@@ -146,7 +146,7 @@ NOKPROBE_SYMBOL(rethook_recycle);
 struct rethook_node *rethook_try_get(struct rethook *rh)
 {
 	rethook_handler_t handler = READ_ONCE(rh->handler);
-	struct freelist_node *fn;
+	struct rethook_node *nod;
 
 	lockdep_assert_preemption_disabled();
 
@@ -163,11 +163,11 @@ struct rethook_node *rethook_try_get(struct rethook *rh)
 	if (unlikely(!rcu_is_watching()))
 		return NULL;
 
-	fn = freelist_try_get(&rh->pool);
-	if (!fn)
+	nod = (struct rethook_node *)objpool_pop(&rh->pool);
+	if (!nod)
 		return NULL;
 
-	return container_of(fn, struct rethook_node, freelist);
+	return nod;
 }
 NOKPROBE_SYMBOL(rethook_try_get);
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 3fc7abffc7aa..b12cc71754cf 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2737,6 +2737,17 @@ config TEST_CLOCKSOURCE_WATCHDOG
 
 	  If unsure, say N.
 
+config TEST_OBJPOOL
+	tristate "Test module for correctness and stress of objpool"
+	default n
+       depends on m
+	help
+	  This builds the "test_objpool" module that should be used for
+	  correctness verification and concurrent testings of objects
+	  allocation and reclamation.
+
+	  If unsure, say N.
+
 endif # RUNTIME_TESTING_MENU
 
 config ARCH_USE_MEMTEST
diff --git a/lib/Makefile b/lib/Makefile
index 161d6a724ff7..4aa282fa0cfc 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -34,7 +34,7 @@ lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 is_single_threaded.o plist.o decompress.o kobject_uevent.o \
 	 earlycpio.o seq_buf.o siphash.o dec_and_lock.o \
 	 nmi_backtrace.o win_minmax.o memcat_p.o \
-	 buildid.o
+	 buildid.o objpool.o
 
 lib-$(CONFIG_PRINTK) += dump_stack.o
 lib-$(CONFIG_SMP) += cpumask.o
@@ -99,6 +99,8 @@ obj-$(CONFIG_KPROBES_SANITY_TEST) += test_kprobes.o
 obj-$(CONFIG_TEST_REF_TRACKER) += test_ref_tracker.o
 CFLAGS_test_fprobe.o += $(CC_FLAGS_FTRACE)
 obj-$(CONFIG_FPROBE_SANITY_TEST) += test_fprobe.o
+obj-$(CONFIG_TEST_OBJPOOL) += test_objpool.o
+
 #
 # CFLAGS for compiling floating point code inside the kernel. x86/Makefile turns
 # off the generation of FPU/SSE* instructions for kernel proper but FPU_FLAGS
diff --git a/lib/objpool.c b/lib/objpool.c
new file mode 100644
index 000000000000..51b3499ff9da
--- /dev/null
+++ b/lib/objpool.c
@@ -0,0 +1,480 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/objpool.h>
+
+/*
+ * objpool: ring-array based lockless MPMC/FIFO queues
+ *
+ * Copyright: wuqiang.matt@bytedance.com
+ */
+
+/* compute the suitable num of objects to be managed by slot */
+static inline uint32_t __objpool_num_of_objs(uint32_t size)
+{
+	return rounddown_pow_of_two((size - sizeof(struct objpool_slot)) /
+			(sizeof(uint32_t) + sizeof(void *)));
+}
+
+#define SLOT_AGES(s) ((uint32_t *)((char *)(s) + sizeof(struct objpool_slot)))
+#define SLOT_ENTS(s) ((void **)((char *)(s) + sizeof(struct objpool_slot) + \
+			sizeof(uint32_t) * (s)->os_size))
+#define SLOT_OBJS(s) ((void *)((char *)(s) + sizeof(struct objpool_slot) + \
+			(sizeof(uint32_t) + sizeof(void *)) * (s)->os_size))
+
+/* allocate and initialize percpu slots */
+static inline int
+__objpool_init_percpu_slots(struct objpool_head *oh, uint32_t nobjs,
+			void *context, objpool_init_node_cb objinit)
+{
+	uint32_t i, j, size, objsz, nents = oh->oh_nents;
+
+	/* aligned object size by sizeof(void *) */
+	objsz = ALIGN(oh->oh_objsz, sizeof(void *));
+	/* shall we allocate objects along with objpool_slot */
+	if (objsz)
+		oh->oh_in_slot = 1;
+
+	for (i = 0; i < oh->oh_ncpus; i++) {
+		struct objpool_slot *os;
+		uint32_t n;
+
+		/* compute how many objects to be managed by this slot */
+		n = nobjs / oh->oh_ncpus;
+		if (i < (nobjs % oh->oh_ncpus))
+			n++;
+		size = sizeof(struct objpool_slot) + sizeof(void *) * nents +
+		       sizeof(uint32_t) * nents + objsz * n;
+
+		/* decide which pool shall the slot be allocated from */
+		if (0 == i) {
+			if ((oh->oh_gfp & GFP_ATOMIC) || size < PAGE_SIZE / 2)
+				oh->oh_vmalloc = 0;
+			else
+				oh->oh_vmalloc = 1;
+		}
+
+		/* allocate percpu slot & objects from local memory */
+		if (oh->oh_vmalloc)
+			os = vmalloc_node(size, cpu_to_node(i));
+		else
+			os = kmalloc_node(size, oh->oh_gfp, cpu_to_node(i));
+		if (!os)
+			return -ENOMEM;
+
+		/* initialize percpu slot for the i-th cpu */
+		memset(os, 0, size);
+		os->os_size = oh->oh_nents;
+		os->os_mask = os->os_size - 1;
+		oh->oh_slots[i] = os;
+		oh->oh_sz_slots[i] = size;
+
+		/*
+		 * start from 2nd round to avoid conflict of 1st item.
+		 * we assume that the head item is ready for retrieval
+		 * iff head is equal to ages[head & mask]. but ages is
+		 * initialized as 0, so in view of the caller of pop(),
+		 * the 1st item (0th) is always ready, but fact could
+		 * be: push() is stalled before the final update, thus
+		 * the item being inserted will be lost forever.
+		 */
+		os->os_head = os->os_tail = oh->oh_nents;
+
+		for (j = 0; oh->oh_in_slot && j < n; j++) {
+			uint32_t *ages = SLOT_AGES(os);
+			void **ents = SLOT_ENTS(os);
+			void *obj = SLOT_OBJS(os) + j * objsz;
+			uint32_t ie = os->os_tail & os->os_mask;
+
+			/* perform object initialization */
+			if (objinit) {
+				int rc = objinit(context, obj);
+				if (rc)
+					return rc;
+			}
+
+			/* add obj into the ring array */
+			ents[ie] = obj;
+			ages[ie] = os->os_tail;
+			os->os_tail++;
+			oh->oh_nobjs++;
+		}
+	}
+
+	return 0;
+}
+
+/* cleanup all percpu slots of the object pool */
+static inline void __objpool_fini_percpu_slots(struct objpool_head *oh)
+{
+	uint32_t i;
+
+	if (!oh->oh_slots)
+		return;
+
+	for (i = 0; i < oh->oh_ncpus; i++) {
+		if (!oh->oh_slots[i])
+			continue;
+		if (oh->oh_vmalloc)
+			vfree(oh->oh_slots[i]);
+		else
+			kfree(oh->oh_slots[i]);
+	}
+	kfree(oh->oh_slots);
+	oh->oh_slots = NULL;
+	oh->oh_sz_slots = NULL;
+}
+
+/**
+ * objpool_init: initialize object pool and pre-allocate objects
+ *
+ * args:
+ * @oh:    the object pool to be initialized, declared by the caller
+ * @nojbs: total objects to be allocated by this object pool
+ * @max:   max objs this objpool could manage, use nobjs if 0
+ * @ojbsz: size of an object, to be pre-allocated if objsz is not 0
+ * @gfp:   gfp flags of caller's context for memory allocation
+ * @context: user context for object initialization callback
+ * @objinit: object initialization callback for extra setting-up
+ * @release: cleanup callback for private objects/pool/context
+ *
+ * return:
+ *         0 for success, otherwise error code
+ *
+ * All pre-allocated objects are to be zeroed. Caller could do extra
+ * initialization in objinit callback. The objinit callback will be
+ * called once and only once after the slot allocation
+ */
+int objpool_init(struct objpool_head *oh,
+		int nobjs, int max, int objsz,
+		gfp_t gfp, void *context,
+		objpool_init_node_cb objinit,
+		objpool_release_cb release)
+{
+	uint32_t nents, cpus = num_possible_cpus();
+	int rc;
+
+	/* calculate percpu slot size (rounded to pow of 2) */
+	if (max < nobjs)
+		max = nobjs;
+	nents = max / cpus;
+	if (nents < __objpool_num_of_objs(L1_CACHE_BYTES))
+		nents = __objpool_num_of_objs(L1_CACHE_BYTES);
+	nents = roundup_pow_of_two(nents);
+	while (nents * cpus < nobjs)
+		nents = nents << 1;
+
+	memset(oh, 0, sizeof(struct objpool_head));
+	oh->oh_ncpus = cpus;
+	oh->oh_objsz = objsz;
+	oh->oh_nents = nents;
+	oh->oh_gfp = gfp & ~__GFP_ZERO;
+	oh->oh_context = context;
+	oh->oh_release = release;
+
+	/* allocate array for percpu slots */
+	oh->oh_slots = kzalloc(oh->oh_ncpus * sizeof(void *) +
+			       oh->oh_ncpus * sizeof(uint32_t), oh->oh_gfp);
+	if (!oh->oh_slots)
+		return -ENOMEM;
+	oh->oh_sz_slots = (uint32_t *)&oh->oh_slots[oh->oh_ncpus];
+
+	/* initialize per-cpu slots */
+	rc = __objpool_init_percpu_slots(oh, nobjs, context, objinit);
+	if (rc)
+		__objpool_fini_percpu_slots(oh);
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(objpool_init);
+
+/* adding object to slot tail, the given slot mustn't be full */
+static inline int __objpool_add_slot(void *obj, struct objpool_slot *os)
+{
+	uint32_t *ages = SLOT_AGES(os);
+	void **ents = SLOT_ENTS(os);
+	uint32_t tail = atomic_inc_return((atomic_t *)&os->os_tail) - 1;
+
+	WRITE_ONCE(ents[tail & os->os_mask], obj);
+
+	/* order matters: obj must be updated before tail updating */
+	smp_store_release(&ages[tail & os->os_mask], tail);
+	return 0;
+}
+
+/* adding object to slot, abort if the slot was already full */
+static inline int __objpool_try_add_slot(void *obj, struct objpool_slot *os)
+{
+	uint32_t *ages = SLOT_AGES(os);
+	void **ents = SLOT_ENTS(os);
+	uint32_t head, tail;
+
+	do {
+		/* perform memory loading for both head and tail */
+		head = READ_ONCE(os->os_head);
+		tail = READ_ONCE(os->os_tail);
+		/* just abort if slot is full */
+		if (tail >= head + os->os_size)
+			return -ENOENT;
+		/* try to extend tail by 1 using CAS to avoid races */
+		if (try_cmpxchg_acquire(&os->os_tail, &tail, tail + 1))
+			break;
+	} while (1);
+
+	/* the tail-th of slot is reserved for the given obj */
+	WRITE_ONCE(ents[tail & os->os_mask], obj);
+	/* update epoch id to make this object available for pop() */
+	smp_store_release(&ages[tail & os->os_mask], tail);
+	return 0;
+}
+
+/**
+ * objpool_populate: add objects from user provided pool in batch
+ *
+ * args:
+ * @oh:  object pool
+ * @buf: user buffer for pre-allocated objects
+ * @size: size of user buffer
+ * @objsz: size of object & element
+ * @context: user context for objinit callback
+ * @objinit: object initialization callback
+ *
+ * return: 0 or error code
+ */
+int objpool_populate(struct objpool_head *oh, void *buf, int size, int objsz,
+		    void *context, objpool_init_node_cb objinit)
+{
+	int n = oh->oh_nobjs, used = 0, i;
+
+	if (oh->oh_pool || !buf || size < objsz)
+		return -EINVAL;
+	if (oh->oh_objsz && oh->oh_objsz != objsz)
+		return -EINVAL;
+	if (oh->oh_context && context && oh->oh_context != context)
+		return -EINVAL;
+	if (oh->oh_nobjs >= oh->oh_ncpus * oh->oh_nents)
+		return -ENOENT;
+
+	WARN_ON_ONCE(((unsigned long)buf) & (sizeof(void *) - 1));
+	WARN_ON_ONCE(((uint32_t)objsz) & (sizeof(void *) - 1));
+
+	/* align object size by sizeof(void *) */
+	oh->oh_objsz = objsz;
+	objsz = ALIGN(objsz, sizeof(void *));
+	if (objsz <= 0)
+		return -EINVAL;
+
+	while (used + objsz <= size) {
+		void *obj = buf + used;
+
+		/* perform object initialization */
+		if (objinit) {
+			int rc = objinit(context, obj);
+			if (rc)
+				return rc;
+		}
+
+		/* insert obj to its corresponding objpool slot */
+		i = (n + used * oh->oh_ncpus/size) % oh->oh_ncpus;
+		if (!__objpool_try_add_slot(obj, oh->oh_slots[i]))
+			oh->oh_nobjs++;
+
+		used += objsz;
+	}
+
+	if (!used)
+		return -ENOENT;
+
+	oh->oh_context = context;
+	oh->oh_pool = buf;
+	oh->oh_sz_pool = size;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(objpool_populate);
+
+/**
+ * objpool_add: add pre-allocated object to objpool during pool
+ * initialization
+ *
+ * args:
+ * @obj: object pointer to be added to objpool
+ * @oh:  object pool to be inserted into
+ *
+ * return:
+ *     0 or error code
+ *
+ * objpool_add_node doesn't handle race conditions, can only be
+ * called during objpool initialization
+ */
+int objpool_add(void *obj, struct objpool_head *oh)
+{
+	uint32_t i, cpu;
+
+	if (!obj)
+		return -EINVAL;
+	if (oh->oh_nobjs >= oh->oh_ncpus * oh->oh_nents)
+		return -ENOENT;
+
+	cpu = oh->oh_nobjs % oh->oh_ncpus;
+	for (i = 0; i < oh->oh_ncpus; i++) {
+		if (!__objpool_try_add_slot(obj, oh->oh_slots[cpu])) {
+			oh->oh_nobjs++;
+			return 0;
+		}
+
+		if (++cpu >= oh->oh_ncpus)
+			cpu = 0;
+	}
+
+	return -ENOENT;
+}
+EXPORT_SYMBOL_GPL(objpool_add);
+
+/**
+ * objpool_push: reclaim the object and return back to objects pool
+ *
+ * args:
+ * @obj: object pointer to be pushed to object pool
+ * @oh:  object pool
+ *
+ * return:
+ *     0 or error code: it fails only when objects pool are full
+ *
+ * objpool_push is non-blockable, and can be nested
+ */
+int objpool_push(void *obj, struct objpool_head *oh)
+{
+	uint32_t cpu = raw_smp_processor_id();
+
+	do {
+		if (oh->oh_nobjs > oh->oh_nents) {
+			if (!__objpool_try_add_slot(obj, oh->oh_slots[cpu]))
+				return 0;
+		} else {
+			if (!__objpool_add_slot(obj, oh->oh_slots[cpu]))
+				return 0;
+		}
+		if (++cpu >= oh->oh_ncpus)
+			cpu = 0;
+	} while (1);
+
+	return -ENOENT;
+}
+EXPORT_SYMBOL_GPL(objpool_push);
+
+/* try to retrieve object from slot */
+static inline void *__objpool_try_get_slot(struct objpool_slot *os)
+{
+	uint32_t *ages = SLOT_AGES(os);
+	void **ents = SLOT_ENTS(os);
+	/* do memory load of os_head to local head */
+	uint32_t head = smp_load_acquire(&os->os_head);
+
+	/* loop if slot isn't empty */
+	while (head != READ_ONCE(os->os_tail)) {
+		uint32_t id = head & os->os_mask, prev = head;
+
+		/* do prefetching of object ents */
+		prefetch(&ents[id]);
+
+		/*
+		 * check whether this item was ready for retrieval ? There's
+		 * possibility * in theory * we might retrieve wrong object,
+		 * in case ages[id] overflows when current task is sleeping,
+		 * but it will take very very long to overflow an uint32_t
+		 */
+		if (smp_load_acquire(&ages[id]) == head) {
+			/* node must have been udpated by push() */
+			void *node = READ_ONCE(ents[id]);
+			/* commit and move forward head of the slot */
+			if (try_cmpxchg_release(&os->os_head, &head, head + 1))
+				return node;
+		}
+
+		/* re-load head from memory continue trying */
+		head = READ_ONCE(os->os_head);
+		/*
+		 * head stays unchanged, so it's very likely current pop()
+		 * just preempted/interrupted an ongoing push() operation
+		 */
+		if (head == prev)
+			break;
+	}
+
+	return NULL;
+}
+
+/**
+ * objpool_pop: allocate an object from objects pool
+ *
+ * args:
+ * @oh:  object pool
+ *
+ * return:
+ *   object: NULL if failed (object pool is empty)
+ *
+ * objpool_pop can be nested, so can be used in any context.
+ */
+void *objpool_pop(struct objpool_head *oh)
+{
+	uint32_t i, cpu = raw_smp_processor_id();
+	void *obj = NULL;
+
+	for (i = 0; i < oh->oh_ncpus; i++) {
+		struct objpool_slot *slot = oh->oh_slots[cpu];
+		obj = __objpool_try_get_slot(slot);
+		if (obj)
+			break;
+		if (++cpu >= oh->oh_ncpus)
+			cpu = 0;
+	}
+
+	return obj;
+}
+EXPORT_SYMBOL_GPL(objpool_pop);
+
+/**
+ * objpool_fini: cleanup the whole object pool (releasing all objects)
+ *
+ * args:
+ * @head: object pool to be released
+ *
+ */
+void objpool_fini(struct objpool_head *oh)
+{
+	uint32_t i, flags;
+
+	if (!oh->oh_slots)
+		return;
+
+	if (!oh->oh_release) {
+		__objpool_fini_percpu_slots(oh);
+		return;
+	}
+
+	/* cleanup all objects remained in objpool */
+	for (i = 0; i < oh->oh_ncpus; i++) {
+		void *obj;
+		do {
+			flags = OBJPOOL_FLAG_NODE;
+			obj = __objpool_try_get_slot(oh->oh_slots[i]);
+			if (!obj)
+				break;
+			if (!objpool_is_inpool(obj, oh) &&
+			    !objpool_is_inslot(obj, oh)) {
+				flags |= OBJPOOL_FLAG_USER;
+			}
+			oh->oh_release(oh->oh_context, obj, flags);
+		} while (obj);
+	}
+
+	/* release percpu slots */
+	__objpool_fini_percpu_slots(oh);
+
+	/* cleanup user private pool and related context */
+	flags = OBJPOOL_FLAG_POOL;
+	if (oh->oh_pool)
+		flags |= OBJPOOL_FLAG_USER;
+	oh->oh_release(oh->oh_context, oh->oh_pool, flags);
+}
+EXPORT_SYMBOL_GPL(objpool_fini);
diff --git a/lib/test_objpool.c b/lib/test_objpool.c
new file mode 100644
index 000000000000..c1341ddf77b5
--- /dev/null
+++ b/lib/test_objpool.c
@@ -0,0 +1,1031 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Test module for lockless object pool
+ * (C) 2022 Matt Wu <wuqiang.matt@bytedance.com>
+ */
+
+#include <linux/version.h>
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/sched.h>
+#include <linux/cpumask.h>
+#include <linux/completion.h>
+#include <linux/kthread.h>
+#include <linux/cpu.h>
+#include <linux/cpuset.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/hrtimer.h>
+#include <linux/interrupt.h>
+#include <linux/objpool.h>
+
+#define OT_NR_MAX_BULK (16)
+
+struct ot_ctrl {
+	unsigned int mode;
+	unsigned int duration; /* ms */
+	unsigned int delay; /* ms */
+	unsigned int bulk_normal;
+	unsigned int bulk_irq;
+	unsigned long hrtimer; /* ms */
+	const char *name;
+};
+
+struct ot_stat {
+	unsigned long nhits;
+	unsigned long nmiss;
+};
+
+struct ot_item {
+	struct objpool_head *pool; /* pool head */
+	struct ot_ctrl *ctrl; /* ctrl parameters */
+
+	void (*worker)(struct ot_item *item, int irq);
+
+	/* hrtimer control */
+	ktime_t hrtcycle;
+	struct hrtimer hrtimer;
+
+	int bulk[2]; /* for thread and irq */
+	int delay;
+	u32 niters;
+
+	/* results summary */
+	struct ot_stat stat[2]; /* thread and irq */
+
+	u64 duration;
+};
+
+struct ot_mem_stat {
+	atomic_long_t alloc;
+	atomic_long_t free;
+};
+
+struct ot_data {
+	struct rw_semaphore start;
+	struct completion wait;
+	struct completion rcu;
+	atomic_t nthreads ____cacheline_aligned_in_smp;
+	atomic_t stop ____cacheline_aligned_in_smp;
+	struct ot_mem_stat kmalloc;
+	struct ot_mem_stat vmalloc;
+} g_ot_data;
+
+/*
+ * memory leakage checking
+ */
+
+void *ot_kzalloc(long size)
+{
+	void *ptr = kzalloc(size, GFP_KERNEL);
+
+	if (ptr)
+		atomic_long_add(size, &g_ot_data.kmalloc.alloc);
+	return ptr;
+}
+
+void ot_kfree(void *ptr, long size)
+{
+	if (!ptr)
+		return;
+	atomic_long_add(size, &g_ot_data.kmalloc.free);
+	kfree(ptr);
+}
+
+void *ot_vmalloc(long size)
+{
+	void *ptr = vmalloc(size);
+
+	if (ptr)
+		atomic_long_add(size, &g_ot_data.vmalloc.alloc);
+	return ptr;
+}
+
+void ot_vfree(void *ptr, long size)
+{
+	if (!ptr)
+		return;
+	atomic_long_add(size, &g_ot_data.vmalloc.free);
+	vfree(ptr);
+}
+
+static void ot_mem_report(struct ot_ctrl *ctrl)
+{
+	long alloc, free;
+
+	pr_info("memory allocation summary for %s\n", ctrl->name);
+
+	alloc = atomic_long_read(&g_ot_data.kmalloc.alloc);
+	free = atomic_long_read(&g_ot_data.kmalloc.free);
+	pr_info("  kmalloc: %lu - %lu = %lu\n", alloc, free, alloc - free);
+
+	alloc = atomic_long_read(&g_ot_data.vmalloc.alloc);
+	free = atomic_long_read(&g_ot_data.vmalloc.free);
+	pr_info("  vmalloc: %lu - %lu = %lu\n", alloc, free, alloc - free);
+}
+
+/*
+ * general structs & routines
+ */
+
+struct ot_node {
+	void *owner;
+	unsigned long data;
+	unsigned long refs;
+};
+
+struct ot_context {
+	struct objpool_head pool;
+	void *ptr;
+	unsigned long size;
+	refcount_t refs;
+	struct rcu_head rcu;
+};
+
+static DEFINE_PER_CPU(struct ot_item, ot_pcup_items);
+
+static int ot_init_data(struct ot_data *data)
+{
+	memset(data, 0, sizeof(*data));
+	init_rwsem(&data->start);
+	init_completion(&data->wait);
+	init_completion(&data->rcu);
+	atomic_set(&data->nthreads, 1);
+
+	return 0;
+}
+
+static void ot_reset_data(struct ot_data *data)
+{
+	reinit_completion(&data->wait);
+	reinit_completion(&data->rcu);
+	atomic_set(&data->nthreads, 1);
+	atomic_set(&data->stop, 0);
+	memset(&data->kmalloc, 0, sizeof(data->kmalloc));
+	memset(&data->vmalloc, 0, sizeof(data->vmalloc));
+}
+
+static int ot_init_node(void *context, void *nod)
+{
+	struct ot_context *sop = context;
+	struct ot_node *on = nod;
+
+	on->owner = &sop->pool;
+	return 0;
+}
+
+static enum hrtimer_restart ot_hrtimer_handler(struct hrtimer *hrt)
+{
+	struct ot_item *item = container_of(hrt, struct ot_item, hrtimer);
+
+	if (atomic_read_acquire(&g_ot_data.stop))
+		return HRTIMER_NORESTART;
+
+	/* do bulk-testings for objects pop/push */
+	item->worker(item, 1);
+
+	hrtimer_forward(hrt, hrt->base->get_time(), item->hrtcycle);
+	return HRTIMER_RESTART;
+}
+
+static void ot_start_hrtimer(struct ot_item *item)
+{
+	if (!item->ctrl->hrtimer)
+		return;
+	hrtimer_start(&item->hrtimer, item->hrtcycle, HRTIMER_MODE_REL);
+}
+
+static void ot_stop_hrtimer(struct ot_item *item)
+{
+	if (!item->ctrl->hrtimer)
+		return;
+	hrtimer_cancel(&item->hrtimer);
+}
+
+static int ot_init_hrtimer(struct ot_item *item, unsigned long hrtimer)
+{
+	struct hrtimer *hrt = &item->hrtimer;
+
+	if (!hrtimer)
+		return -ENOENT;
+
+	item->hrtcycle = ktime_set(0, hrtimer * 1000000UL);
+	hrtimer_init(hrt, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrt->function = ot_hrtimer_handler;
+	return 0;
+}
+
+static int ot_init_cpu_item(struct ot_item *item,
+			struct ot_ctrl *ctrl,
+			struct objpool_head *pool,
+			void (*worker)(struct ot_item *, int))
+{
+	memset(item, 0, sizeof(*item));
+	item->pool = pool;
+	item->ctrl = ctrl;
+	item->worker = worker;
+
+	item->bulk[0] = ctrl->bulk_normal;
+	item->bulk[1] = ctrl->bulk_irq;
+	item->delay = ctrl->delay;
+
+	/* initialize hrtimer */
+	ot_init_hrtimer(item, item->ctrl->hrtimer);
+	return 0;
+}
+
+static int ot_thread_worker(void *arg)
+{
+	struct ot_item *item = arg;
+	ktime_t start;
+
+	sched_set_normal(current, 50);
+
+	atomic_inc(&g_ot_data.nthreads);
+	down_read(&g_ot_data.start);
+	up_read(&g_ot_data.start);
+	start = ktime_get();
+	ot_start_hrtimer(item);
+	do {
+		if (atomic_read_acquire(&g_ot_data.stop))
+			break;
+		/* do bulk-testings for objects pop/push */
+		item->worker(item, 0);
+	} while (!kthread_should_stop());
+	ot_stop_hrtimer(item);
+	item->duration = (u64) ktime_us_delta(ktime_get(), start);
+	if (atomic_dec_and_test(&g_ot_data.nthreads))
+		complete(&g_ot_data.wait);
+
+	return 0;
+}
+
+static void ot_perf_report(struct ot_ctrl *ctrl, u64 duration)
+{
+	struct ot_stat total, normal = {0}, irq = {0};
+	int cpu, nthreads = 0;
+
+	pr_info("\n");
+	pr_info("Testing summary for %s\n", ctrl->name);
+
+	for_each_possible_cpu(cpu) {
+		struct ot_item *item = per_cpu_ptr(&ot_pcup_items, cpu);
+		if (!item->duration)
+			continue;
+		normal.nhits += item->stat[0].nhits;
+		normal.nmiss += item->stat[0].nmiss;
+		irq.nhits += item->stat[1].nhits;
+		irq.nmiss += item->stat[1].nmiss;
+		pr_info("CPU: %d  duration: %lluus\n", cpu, item->duration);
+		pr_info("\tthread:\t%16lu hits \t%16lu miss\n",
+			item->stat[0].nhits, item->stat[0].nmiss);
+		pr_info("\tirq:   \t%16lu hits \t%16lu miss\n",
+			item->stat[1].nhits, item->stat[1].nmiss);
+		pr_info("\ttotal: \t%16lu hits \t%16lu miss\n",
+			item->stat[0].nhits + item->stat[1].nhits,
+			item->stat[0].nmiss + item->stat[1].nmiss);
+		nthreads++;
+	}
+
+	total.nhits = normal.nhits + irq.nhits;
+	total.nmiss = normal.nmiss + irq.nmiss;
+
+	pr_info("ALL: \tnthreads: %d  duration: %lluus\n", nthreads, duration);
+	pr_info("SUM: \t%16lu hits \t%16lu miss\n",
+		total.nhits, total.nmiss);
+}
+
+/*
+ * synchronous test cases for objpool manipulation
+ */
+
+/* objpool manipulation for synchronous mode 0 (percpu objpool) */
+static struct ot_context *ot_init_sync_m0(void)
+{
+	struct ot_context *sop = NULL;
+	int max = num_possible_cpus() << 3;
+
+	sop = (struct ot_context *)ot_kzalloc(sizeof(*sop));
+	if (!sop)
+		return NULL;
+
+	if (objpool_init(&sop->pool, max, max, sizeof(struct ot_node),
+			GFP_KERNEL, sop, ot_init_node, NULL)) {
+		ot_kfree(sop, sizeof(*sop));
+		return NULL;
+	}
+	WARN_ON(max != sop->pool.oh_nobjs);
+
+	return sop;
+}
+
+static void ot_fini_sync_m0(struct ot_context *sop)
+{
+	objpool_fini(&sop->pool);
+	ot_kfree(sop, sizeof(*sop));
+}
+
+/* objpool manipulation for synchronous mode 1 (private pool) */
+static struct ot_context *ot_init_sync_m1(void)
+{
+	struct ot_context *sop = NULL;
+	unsigned long size;
+	int rc, szobj, max = num_possible_cpus() << 3;
+
+	sop = (struct ot_context *)ot_kzalloc(sizeof(*sop));
+	if (!sop)
+		return NULL;
+
+	size = sizeof(struct ot_node) * max;
+	sop->ptr = ot_vmalloc(size);
+	sop->size = size;
+	if (!sop->ptr) {
+		ot_kfree(sop, sizeof(*sop));
+		return NULL;
+	}
+	memset(sop->ptr, 0, size);
+
+	/* create and initialize objpool as empty (no objects) */
+	rc = objpool_init(&sop->pool, 0, max, 0, GFP_KERNEL, sop, NULL, NULL);
+	if (rc) {
+		ot_kfree(sop, sizeof(*sop));
+		return NULL;
+	}
+
+	/* populate given buffer to objpool */
+	rc = objpool_populate(&sop->pool, sop->ptr, size,
+		sizeof(struct ot_node), sop, ot_init_node);
+	if (rc) {
+		objpool_fini(&sop->pool);
+		ot_vfree(sop->ptr, size);
+		ot_kfree(sop, sizeof(*sop));
+		return NULL;
+	}
+	szobj = ALIGN(sizeof(struct ot_node), sizeof(void *));
+	WARN_ON((size / szobj) != sop->pool.oh_nobjs);
+
+	return sop;
+}
+
+static void ot_fini_sync_m1(struct ot_context *sop)
+{
+	objpool_fini(&sop->pool);
+
+	ot_vfree(sop->ptr, sop->size);
+	ot_kfree(sop, sizeof(*sop));
+}
+
+/* objpool manipulation for synchronous mode 2 (private objects) */
+static int ot_objpool_release(void *context, void *ptr, uint32_t flags)
+{
+	struct ot_context *sop = context;
+
+	/* here we need release all user-allocated objects */
+	if ((flags & OBJPOOL_FLAG_NODE) && (flags & OBJPOOL_FLAG_USER)) {
+		struct ot_node *on = ptr;
+		WARN_ON(on->data != 0xDEADBEEF);
+		ot_kfree(on, sizeof(struct ot_node));
+	} else if (flags & OBJPOOL_FLAG_POOL) {
+		/* release user preallocated pool */
+		if (sop->ptr) {
+			WARN_ON(sop->ptr != ptr);
+			WARN_ON(!(flags & OBJPOOL_FLAG_USER));
+			ot_vfree(sop->ptr, sop->size);
+		}
+		/* do context cleaning if needed */
+		ot_kfree(sop, sizeof(*sop));
+	}
+
+	return 0;
+}
+
+static struct ot_context *ot_init_sync_m2(void)
+{
+	struct ot_context *sop = NULL;
+	struct ot_node *on;
+	int rc, i, max = num_possible_cpus() << 3;
+
+	sop = (struct ot_context *)ot_kzalloc(sizeof(*sop));
+	if (!sop)
+		return NULL;
+
+	/* create and initialize objpool as empty (no objects) */
+	rc = objpool_init(&sop->pool, 0, max, 0, GFP_KERNEL, sop, NULL,
+			ot_objpool_release);
+	if (rc) {
+		ot_kfree(sop, sizeof(*sop));
+		return NULL;
+	}
+
+	/* allocate private objects and insert to objpool */
+	for (i = 0; i < max; i++) {
+		on = ot_kzalloc(sizeof(struct ot_node));
+		if (on) {
+			ot_init_node(sop, on);
+			on->data = 0xDEADBEEF;
+			objpool_add(on, &sop->pool);
+		}
+	}
+	WARN_ON(max != sop->pool.oh_nobjs);
+
+	return sop;
+}
+
+static void ot_fini_sync_m2(struct ot_context *sop)
+{
+	objpool_fini(&sop->pool);
+}
+
+/* objpool manipulation for synchronous mode 3 (mixed mode) */
+static struct ot_context *ot_init_sync_m3(void)
+{
+	struct ot_context *sop = NULL;
+	struct ot_node *on;
+	unsigned long size;
+	int rc, i, szobj, nobjs;
+	int max = num_possible_cpus() << 4;
+
+	sop = (struct ot_context *)ot_kzalloc(sizeof(*sop));
+	if (!sop)
+		return NULL;
+
+	/* create and initialize objpool as empty (no objects) */
+	nobjs = num_possible_cpus() * 2;
+	rc = objpool_init(&sop->pool, nobjs, max, sizeof(struct ot_node),
+			GFP_KERNEL, sop, ot_init_node, ot_objpool_release);
+	if (rc) {
+		ot_kfree(sop, sizeof(*sop));
+		return NULL;
+	}
+
+	size = sizeof(struct ot_node) * num_possible_cpus() * 4;
+	sop->ptr = ot_vmalloc(size);
+	if (!sop->ptr) {
+		objpool_fini(&sop->pool);
+		return NULL;
+	}
+	sop->size = size;
+	memset(sop->ptr, 0, size);
+
+	/* populate given buffer to objpool */
+	rc = objpool_populate(&sop->pool, sop->ptr, size,
+		sizeof(struct ot_node), sop, ot_init_node);
+	if (rc) {
+		objpool_fini(&sop->pool);
+		ot_vfree(sop->ptr, size);
+		return NULL;
+	}
+	szobj = ALIGN(sizeof(struct ot_node), sizeof(void *));
+	nobjs += size / szobj;
+
+	/* allocate private objects and insert to objpool */
+	for (i = 0; i < num_possible_cpus() * 2; i++) {
+		on = ot_kzalloc(sizeof(struct ot_node));
+		if (on) {
+			ot_init_node(sop, on);
+			on->data = 0xDEADBEEF;
+			if (!objpool_add(on, &sop->pool))
+				nobjs++;
+			else
+				ot_kfree(on, sizeof(struct ot_node));
+		}
+	}
+	WARN_ON(nobjs != sop->pool.oh_nobjs);
+
+	return sop;
+}
+
+static void ot_fini_sync_m3(struct ot_context *sop)
+{
+	objpool_fini(&sop->pool);
+}
+
+struct {
+	struct ot_context * (*init)(void);
+	void (*fini)(struct ot_context *sop);
+} g_ot_sync_ops[4] = {
+	{ot_init_sync_m0, ot_fini_sync_m0},
+	{ot_init_sync_m1, ot_fini_sync_m1},
+	{ot_init_sync_m2, ot_fini_sync_m2},
+	{ot_init_sync_m3, ot_fini_sync_m3},
+};
+
+/*
+ * synchronous test cases: performance mode
+ */
+
+static void ot_bulk_sync(struct ot_item *item, int irq)
+{
+	struct ot_node *nods[OT_NR_MAX_BULK];
+	int i;
+
+	for (i = 0; i < item->bulk[irq]; i++)
+		nods[i] = objpool_pop(item->pool);
+
+	if (!irq && (item->delay || !(++(item->niters) & 0x7FFF)))
+		msleep(item->delay);
+
+	while (i-- > 0) {
+		struct ot_node *on = nods[i];
+		if (on) {
+			on->refs++;
+			objpool_push(on, item->pool);
+			item->stat[irq].nhits++;
+		} else {
+			item->stat[irq].nmiss++;
+		}
+	}
+}
+
+static int ot_start_sync(struct ot_ctrl *ctrl)
+{
+	struct ot_context *sop;
+	ktime_t start;
+	u64 duration;
+	unsigned long timeout;
+	int cpu, rc;
+
+	/* initialize objpool for syncrhonous testcase */
+	sop = g_ot_sync_ops[ctrl->mode].init();
+	if (!sop)
+		return -ENOMEM;
+
+	/* grab rwsem to block testing threads */
+	down_write(&g_ot_data.start);
+
+	for_each_possible_cpu(cpu) {
+		struct ot_item *item = per_cpu_ptr(&ot_pcup_items, cpu);
+		struct task_struct *work;
+
+		ot_init_cpu_item(item, ctrl, &sop->pool, ot_bulk_sync);
+
+		/* skip offline cpus */
+		if (!cpu_online(cpu))
+			continue;
+
+		work = kthread_create_on_node(ot_thread_worker, item,
+				cpu_to_node(cpu), "ot_worker_%d", cpu);
+		if (IS_ERR(work)) {
+			pr_err("failed to create thread for cpu %d\n", cpu);
+		} else {
+			kthread_bind(work, cpu);
+			wake_up_process(work);
+		}
+	}
+
+	/* wait a while to make sure all threads waiting at start line */
+	msleep(20);
+
+	/* in case no threads were created: memory insufficient ? */
+	if (atomic_dec_and_test(&g_ot_data.nthreads))
+		complete(&g_ot_data.wait);
+
+	// sched_set_fifo_low(current);
+
+	/* start objpool testing threads */
+	start = ktime_get();
+	up_write(&g_ot_data.start);
+
+	/* yeild cpu to worker threads for duration ms */
+	timeout = msecs_to_jiffies(ctrl->duration);
+	rc = schedule_timeout_interruptible(timeout);
+
+	/* tell workers threads to quit */
+	atomic_set_release(&g_ot_data.stop, 1);
+
+	/* wait all workers threads finish and quit */
+	wait_for_completion(&g_ot_data.wait);
+	duration = (u64) ktime_us_delta(ktime_get(), start);
+
+	/* cleanup objpool */
+	g_ot_sync_ops[ctrl->mode].fini(sop);
+
+	/* report testing summary and performance results */
+	ot_perf_report(ctrl, duration);
+
+	/* report memory allocation summary */
+	ot_mem_report(ctrl);
+
+	return rc;
+}
+
+/*
+ * asynchronous test cases: pool lifecycle controlled by refcount
+ */
+
+static void ot_fini_async_rcu(struct rcu_head *rcu)
+{
+	struct ot_context *sop = container_of(rcu, struct ot_context, rcu);
+	struct ot_node *on;
+
+	/* here all cpus are aware of the stop event: g_ot_data.stop = 1 */
+	WARN_ON(!atomic_read_acquire(&g_ot_data.stop));
+
+	do {
+		/* release all objects remained in objpool */
+		on = objpool_pop(&sop->pool);
+		if (on && !objpool_is_inslot(on, &sop->pool) &&
+			!objpool_is_inpool(on, &sop->pool)) {
+			/* private object managed by user */
+			WARN_ON(on->data != 0xDEADBEEF);
+			ot_kfree(on, sizeof(struct ot_node));
+		}
+
+		/* deref anyway since we've one extra ref grabbed */
+		if (refcount_dec_and_test(&sop->refs)) {
+			objpool_fini(&sop->pool);
+			break;
+		}
+	} while (on);
+
+	complete(&g_ot_data.rcu);
+}
+
+static void ot_fini_async(struct ot_context *sop)
+{
+	/* make sure the stop event is acknowledged by all cores */
+	call_rcu(&sop->rcu, ot_fini_async_rcu);
+}
+
+static struct ot_context *ot_init_async_m0(void)
+{
+	struct ot_context *sop = NULL;
+	int max = num_possible_cpus() << 3;
+
+	sop = (struct ot_context *)ot_kzalloc(sizeof(*sop));
+	if (!sop)
+		return NULL;
+
+	if (objpool_init(&sop->pool, max, max, sizeof(struct ot_node),
+			GFP_KERNEL, sop, ot_init_node, ot_objpool_release)) {
+		ot_kfree(sop, sizeof(*sop));
+		return NULL;
+	}
+	WARN_ON(max != sop->pool.oh_nobjs);
+	refcount_set(&sop->refs, max + 1);
+
+	return sop;
+}
+
+static struct ot_context *ot_init_async_m1(void)
+{
+	struct ot_context *sop = NULL;
+	unsigned long size;
+	int szobj, rc, max = num_possible_cpus() << 3;
+
+	sop = (struct ot_context *)ot_kzalloc(sizeof(*sop));
+	if (!sop)
+		return NULL;
+
+	size = sizeof(struct ot_node) * max;
+	sop->ptr = ot_vmalloc(size);
+	sop->size = size;
+	if (!sop->ptr) {
+		ot_kfree(sop, sizeof(*sop));
+		return NULL;
+	}
+	memset(sop->ptr, 0, size);
+
+	/* create and initialize objpool as empty (no objects) */
+	rc = objpool_init(&sop->pool, 0, max, 0, GFP_KERNEL, sop, NULL,
+			ot_objpool_release);
+	if (rc) {
+		ot_kfree(sop, sizeof(*sop));
+		return NULL;
+	}
+
+	/* populate given buffer to objpool */
+	rc = objpool_populate(&sop->pool, sop->ptr, size,
+		sizeof(struct ot_node), sop, ot_init_node);
+	if (rc) {
+		objpool_fini(&sop->pool);
+		ot_vfree(sop->ptr, size);
+		return NULL;
+	}
+
+	/* calculate total number of objects stored in ptr */
+	szobj = ALIGN(sizeof(struct ot_node), sizeof(void *));
+	WARN_ON(size / szobj != sop->pool.oh_nobjs);
+	refcount_set(&sop->refs, size / szobj + 1);
+
+	return sop;
+}
+
+static struct ot_context *ot_init_async_m2(void)
+{
+	struct ot_context *sop = NULL;
+	struct ot_node *on;
+	int rc, i, nobjs = 0, max = num_possible_cpus() << 3;
+
+	sop = (struct ot_context *)ot_kzalloc(sizeof(*sop));
+	if (!sop)
+		return NULL;
+
+	/* create and initialize objpool as empty (no objects) */
+	rc = objpool_init(&sop->pool, 0, max, 0, GFP_KERNEL, sop, NULL,
+			ot_objpool_release);
+	if (rc) {
+		ot_kfree(sop, sizeof(*sop));
+		return NULL;
+	}
+
+	/* allocate private objects and insert to objpool */
+	for (i = 0; i < max; i++) {
+		on = ot_kzalloc(sizeof(struct ot_node));
+		if (on) {
+			ot_init_node(sop, on);
+			on->data = 0xDEADBEEF;
+			objpool_add(on, &sop->pool);
+			nobjs++;
+		}
+	}
+	WARN_ON(nobjs != sop->pool.oh_nobjs);
+	refcount_set(&sop->refs, nobjs + 1);
+
+	return sop;
+}
+
+/* objpool manipulation for synchronous mode 3 (mixed mode) */
+static struct ot_context *ot_init_async_m3(void)
+{
+	struct ot_context *sop = NULL;
+	struct ot_node *on;
+	unsigned long size;
+	int szobj, nobjs, rc, i, max = num_possible_cpus() << 4;
+
+	sop = (struct ot_context *)ot_kzalloc(sizeof(*sop));
+	if (!sop)
+		return NULL;
+
+	/* create and initialize objpool as empty (no objects) */
+	nobjs = num_possible_cpus() * 2;
+	rc = objpool_init(&sop->pool, nobjs, max, sizeof(struct ot_node),
+			GFP_KERNEL, sop, ot_init_node, ot_objpool_release);
+	if (rc) {
+		ot_kfree(sop, sizeof(*sop));
+		return NULL;
+	}
+
+	size = sizeof(struct ot_node) * num_possible_cpus() * 4;
+	sop->ptr = ot_vmalloc(size);
+	if (!sop->ptr) {
+		ot_kfree(sop, sizeof(*sop));
+		return NULL;
+	}
+	sop->size = size;
+	memset(sop->ptr, 0, size);
+
+	/* populate given buffer to objpool */
+	rc = objpool_populate(&sop->pool, sop->ptr, size,
+		sizeof(struct ot_node), sop, ot_init_node);
+	if (rc) {
+		objpool_fini(&sop->pool);
+		ot_vfree(sop->ptr, size);
+		return NULL;
+	}
+
+	/* calculate total number of objects stored in ptr */
+	szobj = ALIGN(sizeof(struct ot_node), sizeof(void *));
+	nobjs += size / szobj;
+
+	/* allocate private objects and insert to objpool */
+	for (i = 0; i < num_possible_cpus() * 2; i++) {
+		on = ot_kzalloc(sizeof(struct ot_node));
+		if (on) {
+			ot_init_node(sop, on);
+			on->data = 0xDEADBEEF;
+			objpool_add(on, &sop->pool);
+			nobjs++;
+		}
+	}
+	WARN_ON(nobjs != sop->pool.oh_nobjs);
+	refcount_set(&sop->refs, nobjs + 1);
+
+	return sop;
+}
+
+struct {
+	struct ot_context * (*init)(void);
+	void (*fini)(struct ot_context *sop);
+} g_ot_async_ops[4] = {
+	{ot_init_async_m0, ot_fini_async},
+	{ot_init_async_m1, ot_fini_async},
+	{ot_init_async_m2, ot_fini_async},
+	{ot_init_async_m3, ot_fini_async},
+};
+
+static void ot_nod_recycle(struct ot_node *on, struct objpool_head *pool,
+			int release)
+{
+	struct ot_context *sop;
+
+	on->refs++;
+
+	if (!release) {
+		/* push object back to opjpool for reuse */
+		objpool_push(on, pool);
+		return;
+	}
+
+	sop = container_of(pool, struct ot_context, pool);
+	WARN_ON(sop != pool->oh_context);
+
+	if (objpool_is_inslot(on, pool)) {
+		/* object is alloced from percpu slots */
+	} else if (objpool_is_inpool(on, pool)) {
+		/* object is alloced from user-manged pool */
+	} else {
+		/* private object managed by user */
+		WARN_ON(on->data != 0xDEADBEEF);
+		ot_kfree(on, sizeof(struct ot_node));
+	}
+
+	/* unref objpool with nod removed forever */
+	if (refcount_dec_and_test(&sop->refs))
+		objpool_fini(pool);
+}
+
+static void ot_bulk_async(struct ot_item *item, int irq)
+{
+	struct ot_node *nods[OT_NR_MAX_BULK];
+	int i, stop;
+
+	for (i = 0; i < item->bulk[irq]; i++)
+		nods[i] = objpool_pop(item->pool);
+
+	if (!irq) {
+		if (item->delay || !(++(item->niters) & 0x7FFF))
+			msleep(item->delay);
+		get_cpu();
+	}
+
+	stop = atomic_read_acquire(&g_ot_data.stop);
+
+	/* drop all objects and deref objpool */
+	while (i-- > 0) {
+		struct ot_node *on = nods[i];
+
+		if (on) {
+			on->refs++;
+			ot_nod_recycle(on, item->pool, stop);
+			item->stat[irq].nhits++;
+		} else {
+			item->stat[irq].nmiss++;
+		}
+	}
+
+	if (!irq)
+		put_cpu();
+}
+
+static int ot_start_async(struct ot_ctrl *ctrl)
+{
+	struct ot_context *sop;
+	ktime_t start;
+	u64 duration;
+	unsigned long timeout;
+	int cpu, rc;
+
+	/* initialize objpool for syncrhonous testcase */
+	sop = g_ot_async_ops[ctrl->mode].init();
+	if (!sop)
+		return -ENOMEM;
+
+	/* grab rwsem to block testing threads */
+	down_write(&g_ot_data.start);
+
+	for_each_possible_cpu(cpu) {
+		struct ot_item *item = per_cpu_ptr(&ot_pcup_items, cpu);
+		struct task_struct *work;
+
+		ot_init_cpu_item(item, ctrl, &sop->pool, ot_bulk_async);
+
+		/* skip offline cpus */
+		if (!cpu_online(cpu))
+			continue;
+
+		work = kthread_create_on_node(ot_thread_worker, item,
+				cpu_to_node(cpu), "ot_worker_%d", cpu);
+		if (IS_ERR(work)) {
+			pr_err("failed to create thread for cpu %d\n", cpu);
+		} else {
+			kthread_bind(work, cpu);
+			wake_up_process(work);
+		}
+	}
+
+	/* wait a while to make sure all threads waiting at start line */
+	msleep(20);
+
+	/* in case no threads were created: memory insufficient ? */
+	if (atomic_dec_and_test(&g_ot_data.nthreads))
+		complete(&g_ot_data.wait);
+
+	/* start objpool testing threads */
+	start = ktime_get();
+	up_write(&g_ot_data.start);
+
+	/* yeild cpu to worker threads for duration ms */
+	timeout = msecs_to_jiffies(ctrl->duration);
+	rc = schedule_timeout_interruptible(timeout);
+
+	/* tell workers threads to quit */
+	atomic_set_release(&g_ot_data.stop, 1);
+
+	/* do async-finalization */
+	g_ot_async_ops[ctrl->mode].fini(sop);
+
+	/* wait all workers threads finish and quit */
+	wait_for_completion(&g_ot_data.wait);
+	duration = (u64) ktime_us_delta(ktime_get(), start);
+
+	/* assure rcu callback is triggered */
+	wait_for_completion(&g_ot_data.rcu);
+
+	/*
+	 * now we are sure that objpool is finalized either
+	 * by rcu callback or by worker threads
+	 */
+
+	/* report testing summary and performance results */
+	ot_perf_report(ctrl, duration);
+
+	/* report memory allocation summary */
+	ot_mem_report(ctrl);
+
+	return rc;
+}
+
+/*
+ * predefined testing cases:
+ *   4 synchronous cases / 4 overrun cases / 2 async cases
+ *
+ * mode: unsigned int, could be 0/1/2/3, see name
+ * duration: unsigned int, total test time in ms
+ * delay: unsigned int, delay (in ms) between each iteration
+ * bulk_normal: unsigned int, repeat times for thread worker
+ * bulk_irq: unsigned int, repeat times for irq consumer
+ * hrtimer: unsigned long, hrtimer intervnal in ms
+ * name: char *, tag for current test ot_item
+ */
+
+struct ot_ctrl g_ot_sync[] = {
+	{0, 1000, 0,  1,  0,  0, "sync: percpu objpool"},
+	{1, 1000, 0,  1,  0,  0, "sync: user objpool"},
+	{2, 1000, 0,  1,  0,  0, "sync: user objects"},
+	{3, 1000, 0,  1,  0,  0, "sync: mixed pools & objs"},
+};
+
+struct ot_ctrl g_ot_miss[] = {
+	{0, 1000, 0, 16,  0,  0, "sync overrun: percpu objpool"},
+	{1, 1000, 0, 16,  0,  0, "sync overrun: user objpool"},
+	{2, 1000, 0, 16,  0,  0, "sync overrun: user objects"},
+	{3, 1000, 0, 16,  0,  0, "sync overrun: mixed pools & objs"},
+};
+
+struct ot_ctrl g_ot_async[] = {
+	{0, 1000, 4,  8,  8,  6, "async: percpu objpool"},
+	{1, 1000, 4,  8,  8,  6, "async: user objpool"},
+	{2, 1000, 4,  8,  8,  6, "async: user objects"},
+	{3, 1000, 4,  8,  8,  6, "async: mixed pools & objs"},
+};
+
+static int __init ot_mod_init(void)
+{
+	int i;
+
+	ot_init_data(&g_ot_data);
+
+	for (i = 0; i < ARRAY_SIZE(g_ot_sync); i++) {
+		if (ot_start_sync(&g_ot_sync[i]))
+			goto out;
+		ot_reset_data(&g_ot_data);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(g_ot_miss); i++) {
+		if (ot_start_sync(&g_ot_miss[i]))
+			goto out;
+		ot_reset_data(&g_ot_data);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(g_ot_async); i++) {
+		if (ot_start_async(&g_ot_async[i]))
+			goto out;
+		ot_reset_data(&g_ot_data);
+	}
+
+out:
+	return -EAGAIN;
+}
+
+static void __exit ot_mod_exit(void)
+{
+}
+
+module_init(ot_mod_init);
+module_exit(ot_mod_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Matt Wu");
-- 
2.34.1


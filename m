Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0E464FDA6
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 06:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiLRFDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 00:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiLRFDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 00:03:49 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2186CE1A
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 21:03:47 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d15so6074364pls.6
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 21:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=05x1ZopnWwBMtEdmV/JPYNRuKgulXaNLkHsmw7LTL4A=;
        b=YHcHjMmZckEqBWA7m14w0qpwpwaUreVKq3CZi9mWUo6UemdN2BkyYf9cz9YzlzuUar
         NDmY+yTHG/N2KuuF8amnaM3WEiT6Jsp+ztiafNr4wp4PxR213rIq7jpBz8tf9ieuINKQ
         y+9mkcEXjKi57eVOaT2QqnjzfpqgsogQV7MiBA88yjrsZoVxeyG00NnKx+Q5omGF4Tzq
         V3goGYVt92ENnDdrNn6znUdMzg9Sr0i/Ip43A80gUDBN+s+/OyOJSVZ1yzEwWgpEAWBM
         qne6Xk7JHTdSbMWbmVuw7+jrLn8ZMBeYHNU0A7bZFNt7SfnWsZsHtxGUidRFjBrH1Mg3
         VgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=05x1ZopnWwBMtEdmV/JPYNRuKgulXaNLkHsmw7LTL4A=;
        b=THfNK6TmnyYBnDOi4A6EWCwpc23+iuxQlY21p/c6NmmYd7Y3rAsE66Ae/Lz9WNPhn2
         KgKXuQFhlqrjUONm1OF4UKcDP3+8gMh+H4D6gU5iubZfi2rhg29x+ZAofMUt6DLCnu9X
         0vdlNyWMsAFocyvpZnNKCPY7f5ZwTVxMfsH3O7lel52NNskhP73xfftDeatjBYO79Hla
         RY0oL1hSbIvIEX4iUGk/oLgxx7JOYqs25Yj7CsftGtuSxQC8zAnAmVv4YJB0FA7KkJo3
         OwKs3yN5m2Xtk4YBe+alVWeaY2EtFEP2/WMuAriGxrmDGtZw0F7OjOoWxxmJsWVH6brg
         dapQ==
X-Gm-Message-State: ANoB5pl7C9qIMv0lGeHYhqLuUn/lvWgPMw7azVIqbPF3xEsf205csHxb
        UYH4F792EhOjC4vW036B6wDHmA==
X-Google-Smtp-Source: AA0mqf4FeaD9s83B2ZIeAICTbtjmHPM3K2cN7XI5irRdMFqsVzSNt4mMxeMZ/LnnPX2cBIv0vv979g==
X-Received: by 2002:a05:6a21:9188:b0:a4:3fc2:eb10 with SMTP id tp8-20020a056a21918800b000a43fc2eb10mr42409538pzb.37.1671339827060;
        Sat, 17 Dec 2022 21:03:47 -0800 (PST)
Received: from devtp.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id v20-20020a170902ca9400b001708c4ebbaesm4339348pld.309.2022.12.17.21.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Dec 2022 21:03:46 -0800 (PST)
From:   wuqiang <wuqiang.matt@bytedance.com>
To:     mhiramat@kernel.org, davem@davemloft.net,
        anil.s.keshavamurthy@intel.com, naveen.n.rao@linux.ibm.com,
        rostedt@goodmis.org, peterz@infradead.org,
        akpm@linux-foundation.org, sander@svanheule.net,
        ebiggers@google.com, dan.j.williams@intel.com, jpoimboe@kernel.org
Cc:     linux-kernel@vger.kernel.org, lkp@intel.com, mattwu@163.com,
        wuqiang <wuqiang.matt@bytedance.com>
Subject: [PATCH v8 1/5] lib: objpool added: ring-array based lockless MPMC queue
Date:   Sun, 18 Dec 2022 13:03:06 +0800
Message-Id: <20221218050310.1338630-2-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221218050310.1338630-1-wuqiang.matt@bytedance.com>
References: <20221218050310.1338630-1-wuqiang.matt@bytedance.com>
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

The object pool is a scalable implementaion of high performance queue
for objects allocation and reclamation, such as kretprobe instances.

With leveraging per-cpu ring-array to mitigate the hot spots of memory
contention, it could deliver near-linear scalability for high parallel
scenarios. The ring-array is compactly managed in a single cache-line
to benefit from warmed L1 cache for most cases (<= 4 objects per-core).
The body of pre-allocated objects is stored in continuous cache-lines
just after the ring-array.

The object pool is interrupt safe. Both allocation and reclamation
(object pop and push operations) can be preemptible or interruptable.

It's best suited for following cases:
1) Memory allocation or reclamation are prohibited or too expensive
2) Consumers are of different priorities, such as irqs and threads

Limitations:
1) Maximum objects (capacity) is determined during pool initializing
2) The memory of objects won't be freed until the poll is finalized
3) Object allocation (pop) may fail after trying all cpu slots
4) Object reclamation (push) won't fail but may take long time to
   finish for imbalanced scenarios. You can try larger max_entries
   to mitigate, or ( >= CPUS * nr_objs) to avoid

Signed-off-by: wuqiang <wuqiang.matt@bytedance.com>
---
 include/linux/objpool.h | 116 +++++++++++++
 lib/Makefile            |   2 +-
 lib/objpool.c           | 372 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 489 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/objpool.h
 create mode 100644 lib/objpool.c

diff --git a/include/linux/objpool.h b/include/linux/objpool.h
new file mode 100644
index 000000000000..d5da724b82f7
--- /dev/null
+++ b/include/linux/objpool.h
@@ -0,0 +1,116 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LINUX_OBJPOOL_H
+#define _LINUX_OBJPOOL_H
+
+#include <linux/types.h>
+#include <linux/refcount.h>
+
+/*
+ * objpool: ring-array based lockless MPMC queue
+ *
+ * Copyright: wuqiang.matt@bytedance.com
+ *
+ * The object pool is a scalable implementaion of high performance queue
+ * for objects allocation and reclamation, such as kretprobe instances.
+ *
+ * With leveraging per-cpu ring-array to mitigate the hot spots of memory
+ * contention, it could deliver near-linear scalability for high parallel
+ * scenarios. The ring-array is compactly managed in a single cache-line
+ * to benefit from warmed L1 cache for most cases (<= 4 objects per-core).
+ * The body of pre-allocated objects is stored in continuous cache-lines
+ * just after the ring-array.
+ *
+ * The object pool is interrupt safe. Both allocation and reclamation
+ * (object pop and push operations) can be preemptible or interruptable.
+ *
+ * It's best suited for following cases:
+ * 1) Memory allocation or reclamation are prohibited or too expensive
+ * 2) Consumers are of different priorities, such as irqs and threads
+ *
+ * Limitations:
+ * 1) Maximum objects (capacity) is determined during pool initializing
+ * 2) The memory of objects won't be freed until the poll is finalized
+ * 3) Object allocation (pop) may fail after trying all cpu slots
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
+ * body of objpool_slot, and then entries[]. The Array of ages[] describes
+ * revision of each item, solely used to avoid ABA. And array of entries[]
+ * contains the pointers of objects.
+ *
+ * The default size of objpool_slot is a single cache-line, aka. 64 bytes.
+ *
+ * 64bit:
+ *        4      8      12     16        32                 64
+ * | head | tail | bits | mask | ages[4] | ents[4]: (8 * 4) | objects
+ *
+ * 32bit:
+ *        4      8      12     16        32        48       64
+ * | head | tail | bits | mask | ages[4] | ents[4] | unused | objects
+ *
+ */
+
+struct objpool_slot {
+	uint32_t                head;	/* head of ring array */
+	uint32_t                tail;	/* tail of ring array */
+	uint32_t                bits;	/* log2 of capacity */
+	uint32_t                mask;	/* capacity - 1 */
+} __packed;
+
+struct objpool_head;
+
+/* caller-specified callback for object initial setup, only called once */
+typedef int (*objpool_init_obj_cb)(void *obj, void *context);
+
+/* caller-specified cleanup callback for objpool destruction */
+typedef int (*objpool_fini_cb)(struct objpool_head *head, void *context);
+
+/*
+ * objpool_head: object pooling metadata
+ */
+struct objpool_head {
+	int                     obj_size;	/* object & element size */
+	int                     nr_objs;	/* total objs (to be pre-allocated) */
+	int                     nr_cpus;	/* nr_cpu_ids */
+	int                     capacity;	/* max objects per cpuslot */
+	gfp_t                   gfp;		/* gfp flags for kmalloc & vmalloc */
+	refcount_t              ref;		/* refcount for objpool */
+	unsigned long           flags;		/* flags for objpool management */
+	struct objpool_slot   **cpu_slots;	/* array of percpu slots */
+	int                    *slot_sizes;	/* size in bytes of slots */
+	objpool_fini_cb         release;	/* resource cleanup callback */
+	void                   *context;	/* caller-provided context */
+};
+
+#define OBJPOOL_FROM_VMALLOC	(0x800000000)	/* objpool allocated from vmalloc area */
+#define OBJPOOL_HAVE_OBJECTS	(0x400000000)	/* objects allocated along with objpool */
+
+/* initialize object pool and pre-allocate objects */
+int objpool_init(struct objpool_head *head, int nr_objs, int object_size,
+		 gfp_t gfp, void *context, objpool_init_obj_cb objinit,
+		 objpool_fini_cb release);
+
+/* allocate an object from object pool */
+void *objpool_pop(struct objpool_head *head);
+
+/* reclaim an object to object pool */
+int objpool_push(void *obj, struct objpool_head *head);
+
+/* drop the allocated object, rather reclaim it to objpool */
+int objpool_drop(void *obj, struct objpool_head *head);
+
+/* release whole objpool forcely */
+void objpool_free(struct objpool_head *head);
+
+/* drop unused objects and defref objpool for releasing */
+void objpool_fini(struct objpool_head *head);
+
+#endif /* _LINUX_OBJPOOL_H */
diff --git a/lib/Makefile b/lib/Makefile
index 59bd7c2f793a..f23d9c4fe639 100644
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
diff --git a/lib/objpool.c b/lib/objpool.c
new file mode 100644
index 000000000000..8732689d328c
--- /dev/null
+++ b/lib/objpool.c
@@ -0,0 +1,372 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/objpool.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/atomic.h>
+#include <linux/prefetch.h>
+#include <linux/cpumask.h>
+#include <linux/log2.h>
+
+/*
+ * objpool: ring-array based lockless MPMC/FIFO queues
+ *
+ * Copyright: wuqiang.matt@bytedance.com
+ */
+
+/* compute the suitable num of objects to be managed by slot */
+static inline int objpool_nobjs(int size)
+{
+	return rounddown_pow_of_two((size - sizeof(struct objpool_slot)) /
+			(sizeof(uint32_t) + sizeof(void *)));
+}
+
+#define SLOT_AGES(s) ((uint32_t *)((char *)(s) + sizeof(struct objpool_slot)))
+#define SLOT_ENTS(s) ((void **)((char *)(s) + sizeof(struct objpool_slot) + \
+			(sizeof(uint32_t) << (s)->bits)))
+#define SLOT_OBJS(s) ((void *)((char *)(s) + sizeof(struct objpool_slot) + \
+			((sizeof(uint32_t) + sizeof(void *)) << (s)->bits)))
+#define SLOT_CORE(n) cpumask_nth((n) % num_possible_cpus(), cpu_possible_mask)
+
+/* allocate and initialize percpu slots */
+static inline int
+objpool_init_percpu_slots(struct objpool_head *head, int nobjs,
+			void *context, objpool_init_obj_cb objinit)
+{
+	int i, j, n, size, objsz, cpu = 0, nents = head->capacity;
+
+	/* aligned object size by sizeof(void *) */
+	objsz = ALIGN(head->obj_size, sizeof(void *));
+	/* shall we allocate objects along with objpool_slot */
+	if (objsz)
+		head->flags |= OBJPOOL_HAVE_OBJECTS;
+
+	for (i = 0; i < head->nr_cpus; i++) {
+		struct objpool_slot *os;
+
+		/* skip the cpus which could never be present */
+		if (!cpu_possible(i))
+			continue;
+
+		/* compute how many objects to be managed by this slot */
+		n = nobjs / num_possible_cpus();
+		if (cpu < (nobjs % num_possible_cpus()))
+			n++;
+		size = sizeof(struct objpool_slot) + sizeof(void *) * nents +
+		       sizeof(uint32_t) * nents + objsz * n;
+
+		/* decide memory area for cpu-slot allocation */
+		if (!cpu && !(head->gfp & GFP_ATOMIC) && size > PAGE_SIZE / 2)
+			head->flags |= OBJPOOL_FROM_VMALLOC;
+
+		/* allocate percpu slot & objects from local memory */
+		if (head->flags & OBJPOOL_FROM_VMALLOC)
+			os = __vmalloc_node(size, sizeof(void *), head->gfp,
+				cpu_to_node(i), __builtin_return_address(0));
+		else
+			os = kmalloc_node(size, head->gfp, cpu_to_node(i));
+		if (!os)
+			return -ENOMEM;
+
+		/* initialize percpu slot for the i-th slot */
+		memset(os, 0, size);
+		os->bits = ilog2(head->capacity);
+		os->mask = head->capacity - 1;
+		head->cpu_slots[i] = os;
+		head->slot_sizes[i] = size;
+		cpu = cpu + 1;
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
+		os->head = os->tail = head->capacity;
+
+		if (!objsz)
+			continue;
+
+		for (j = 0; j < n; j++) {
+			uint32_t *ages = SLOT_AGES(os);
+			void **ents = SLOT_ENTS(os);
+			void *obj = SLOT_OBJS(os) + j * objsz;
+			uint32_t ie = os->tail & os->mask;
+
+			/* perform object initialization */
+			if (objinit) {
+				int rc = objinit(obj, context);
+				if (rc)
+					return rc;
+			}
+
+			/* add obj into the ring array */
+			ents[ie] = obj;
+			ages[ie] = os->tail;
+			os->tail++;
+			head->nr_objs++;
+		}
+	}
+
+	return 0;
+}
+
+/* cleanup all percpu slots of the object pool */
+static inline void objpool_fini_percpu_slots(struct objpool_head *head)
+{
+	int i;
+
+	if (!head->cpu_slots)
+		return;
+
+	for (i = 0; i < head->nr_cpus; i++) {
+		if (!head->cpu_slots[i])
+			continue;
+		if (head->flags & OBJPOOL_FROM_VMALLOC)
+			vfree(head->cpu_slots[i]);
+		else
+			kfree(head->cpu_slots[i]);
+	}
+	kfree(head->cpu_slots);
+	head->cpu_slots = NULL;
+	head->slot_sizes = NULL;
+}
+
+/**
+ * objpool_init: initialize object pool and pre-allocate objects
+ *
+ * args:
+ * @head:    the object pool to be initialized, declared by caller
+ * @nr_objs: total objects to be pre-allocated by this object pool
+ * @object_size: size of an object, no objects pre-allocated if 0
+ * @gfp:     flags for memory allocation (via kmalloc or vmalloc)
+ * @context: user context for object initialization callback
+ * @objinit: object initialization callback for extra setting-up
+ * @release: cleanup callback for private objects/pool/context
+ *
+ * return:
+ *         0 for success, otherwise error code
+ *
+ * All pre-allocated objects are to be zeroed. Caller could do extra
+ * initialization in objinit callback. The objinit callback will be
+ * called once and only once after the slot allocation. Then objpool
+ * won't touch any content of the objects since then. It's caller's
+ * duty to perform reinitialization after object allocation (pop) or
+ * clearance before object reclamation (push) if required.
+ */
+int objpool_init(struct objpool_head *head, int nr_objs, int object_size,
+		gfp_t gfp, void *context, objpool_init_obj_cb objinit,
+		objpool_fini_cb release)
+{
+	int nents, rc;
+
+	/* check input parameters */
+	if (nr_objs <= 0 || object_size < 0)
+		return -EINVAL;
+
+	/* calculate percpu slot size (rounded to pow of 2) */
+	nents = max_t(int, roundup_pow_of_two(nr_objs),
+			objpool_nobjs(L1_CACHE_BYTES));
+
+	/* initialize objpool head */
+	memset(head, 0, sizeof(struct objpool_head));
+	head->nr_cpus = nr_cpu_ids;
+	head->obj_size = object_size;
+	head->capacity = nents;
+	head->gfp = gfp & ~__GFP_ZERO;
+	head->context = context;
+	head->release = release;
+
+	/* allocate array for percpu slots */
+	head->cpu_slots = kzalloc(head->nr_cpus * sizeof(void *) +
+			       head->nr_cpus * sizeof(uint32_t), head->gfp);
+	if (!head->cpu_slots)
+		return -ENOMEM;
+	head->slot_sizes = (uint32_t *)&head->cpu_slots[head->nr_cpus];
+
+	/* initialize per-cpu slots */
+	rc = objpool_init_percpu_slots(head, nr_objs, context, objinit);
+	if (rc)
+		objpool_fini_percpu_slots(head);
+	else
+		refcount_set(&head->ref, nr_objs + 1);
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(objpool_init);
+
+/* adding object to slot tail, the given slot must NOT be full */
+static inline int objpool_add_slot(void *obj, struct objpool_slot *os)
+{
+	uint32_t *ages = SLOT_AGES(os);
+	void **ents = SLOT_ENTS(os);
+	uint32_t tail = atomic_inc_return((atomic_t *)&os->tail) - 1;
+
+	WRITE_ONCE(ents[tail & os->mask], obj);
+
+	/* order matters: obj must be updated before tail updating */
+	smp_store_release(&ages[tail & os->mask], tail);
+	return 0;
+}
+
+/**
+ * objpool_push: reclaim the object and return back to object pool
+ *
+ * args:
+ * @obj:  object pointer to be pushed to object pool
+ * @head: object pool
+ *
+ * return:
+ *     0 or error code: it fails only when object pool is full
+ *
+ * objpool_push is non-blockable, and can be nested
+ */
+int objpool_push(void *obj, struct objpool_head *head)
+{
+	int cpu = raw_smp_processor_id();
+
+	return objpool_add_slot(obj, head->cpu_slots[cpu]);
+}
+EXPORT_SYMBOL_GPL(objpool_push);
+
+
+/**
+ * objpool_drop: discard the object and deref objpool
+ *
+ * args:
+ * @obj:  object pointer to be discarded
+ * @head: object pool
+ *
+ * return:
+ *     0 if objpool was released, or error codes
+ *
+ * objpool_push is non-blockable, and can be nested
+ */
+int objpool_drop(void *obj, struct objpool_head *head)
+{
+	if (!obj || !head)
+		return -EINVAL;
+
+	if (refcount_dec_and_test(&head->ref)) {
+		objpool_free(head);
+		return 0;
+	}
+
+	return -EAGAIN;
+}
+EXPORT_SYMBOL_GPL(objpool_drop);
+
+/* try to retrieve object from slot */
+static inline void *objpool_try_get_slot(struct objpool_slot *os)
+{
+	uint32_t *ages = SLOT_AGES(os);
+	void **ents = SLOT_ENTS(os);
+	/* do memory load of head to local head */
+	uint32_t head = smp_load_acquire(&os->head);
+
+	/* loop if slot isn't empty */
+	while (head != READ_ONCE(os->tail)) {
+		uint32_t id = head & os->mask, prev = head;
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
+			if (try_cmpxchg_release(&os->head, &head, head + 1))
+				return node;
+		}
+
+		/* re-load head from memory and continue trying */
+		head = READ_ONCE(os->head);
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
+ * objpool_pop: allocate an object from object pool
+ *
+ * args:
+ * @head: object pool
+ *
+ * return:
+ *   object: NULL if failed (object pool is empty)
+ *
+ * objpool_pop can be nested, so can be used in any context.
+ */
+void *objpool_pop(struct objpool_head *head)
+{
+	int i, cpu = raw_smp_processor_id();
+	void *obj = NULL;
+
+	for (i = 0; i < num_possible_cpus(); i++) {
+		obj = objpool_try_get_slot(head->cpu_slots[cpu]);
+		if (obj)
+			break;
+		cpu = cpumask_next_wrap(cpu, cpu_possible_mask, -1, 1);
+	}
+
+	return obj;
+}
+EXPORT_SYMBOL_GPL(objpool_pop);
+
+/**
+ * objpool_free: release objpool forcely (all objects to be freed)
+ *
+ * args:
+ * @head: object pool to be released
+ *
+ */
+void objpool_free(struct objpool_head *head)
+{
+	if (!head->cpu_slots)
+		return;
+
+	/* release percpu slots */
+	objpool_fini_percpu_slots(head);
+
+	/* call user's cleanup callback if provided */
+	if (head->release)
+		head->release(head, head->context);
+}
+EXPORT_SYMBOL_GPL(objpool_free);
+
+/**
+ * objpool_fini: deref object pool (also releasing unused objects)
+ *
+ * args:
+ * @head: object pool to be dereferenced
+ *
+ */
+void objpool_fini(struct objpool_head *head)
+{
+	void *nod;
+
+	do {
+		/* grab object from objpool and drop it */
+		nod = objpool_pop(head);
+
+		/* drop the extra ref of objpool */
+		if (refcount_dec_and_test(&head->ref))
+			objpool_free(head);
+	} while (nod);
+}
+EXPORT_SYMBOL_GPL(objpool_fini);
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CF261E061
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 06:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiKFFgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 01:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiKFFf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 01:35:59 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505D1631D
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 22:35:52 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id d59-20020a17090a6f4100b00213202d77e1so11733939pjk.2
        for <linux-kernel@vger.kernel.org>; Sat, 05 Nov 2022 22:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1o0y0M22tMTd/MZPMKvPlt8pJGvsR+EyYAekOcFvlM=;
        b=Mc4YEsBLLCoifWgLDOs+WUo6gDi0GdniBrjEZXZkXFaWCUCGh74GlanTzW1spxGPov
         qKQVVdvfUBgW74sU1CEPW+cQk9PhB3m1lF8iDcrmwjIshKmMcHwPPrTpasWB1TQA36e1
         PwBxKuyCewKrte3Ygx5yKdg26riOwgVLjZFcoCfDu2ycGDHUldaCs1ld6Z8eU+G5W4XE
         NOOts4QBukXhcrkxTAcM6zuN3PY6NJRVeA2WJCHChQSMsq7fg9KqXDiPTqcKj6xf58Ph
         Te00+qYruWRGCxo3T0eA6cPr72eT4gTZmAXn1dZ2enVa1IGVdPOcTk/7RPSUMMkqpJ24
         vpFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x1o0y0M22tMTd/MZPMKvPlt8pJGvsR+EyYAekOcFvlM=;
        b=Gdm+/bDInRswmpJa8Yqi2MoIucVdZHS0eFRJd/KuMJfOCh4FejAbCHKQbLGCSVRgFK
         0EXicz0D2Nh8YbodrZoKteImz5kF6oJRZ+80DTpskFS52MN0qtGq3xkg2COS9fXeyMSq
         QtXlEJdUeFaoXBwoKYdKR+KKsdY4Ey8KuKG1n1tlGZksGZdzfoUI+4VTP6IQ9lvPQ07T
         fWntq5htYPx25bRhaCu49eXdCnOvZBGF77SLk4zyTqXSLvhMMrIHFsf3hgyg7COLDw3U
         TRZDpJAM47qcE+uBhnnvH3MvlWnFRuW4IAnshXt1qzyrRA/oK2NTOJV9Wip60UamN0A/
         ZC8A==
X-Gm-Message-State: ACrzQf20Ai9Emn0eYbN9as2uk6+sQqMKrsf13gN3a5FxwDnwA5kwk4wW
        68mWxfoBds8Y18SSzM56Wyv1fw==
X-Google-Smtp-Source: AMsMyM4cWY9TMwfPtCQ4pbiHaYHjoGdIF3FS3U9gE1LLz6VvA99mv0TpIDGNn2CJ9p8aJWmsRHlt2w==
X-Received: by 2002:a17:90a:7e14:b0:210:dcec:ffe9 with SMTP id i20-20020a17090a7e1400b00210dcecffe9mr45570459pjl.157.1667712951432;
        Sat, 05 Nov 2022 22:35:51 -0700 (PDT)
Received: from devtp.bytedance.net ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id q27-20020aa7961b000000b0056bee236e9csm2127121pfg.142.2022.11.05.22.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 22:35:51 -0700 (PDT)
From:   wuqiang <wuqiang.matt@bytedance.com>
To:     mhiramat@kernel.org, davem@davemloft.net,
        anil.s.keshavamurthy@intel.com, naveen.n.rao@linux.ibm.com,
        rostedt@goodmis.org, peterz@infradead.org,
        akpm@linux-foundation.org, sander@svanheule.net,
        ebiggers@google.com, dan.j.williams@intel.com, jpoimboe@kernel.org
Cc:     linux-kernel@vger.kernel.org, lkp@intel.com, mattwu@163.com,
        wuqiang <wuqiang.matt@bytedance.com>
Subject: [PATCH v5 2/4] lib: objpool test module added
Date:   Sun,  6 Nov 2022 13:34:39 +0800
Message-Id: <20221106053441.103199-3-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221106053441.103199-1-wuqiang.matt@bytedance.com>
References: <20221102023012.6362-1-wuqiang.matt@bytedance.com>
 <20221106053441.103199-1-wuqiang.matt@bytedance.com>
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

The test_objpool module (test_objpool) will run serveral testcases
for objpool stress and performance evaluation. Each testcase will
have all available cpu cores involved to create a situation of high
parallel and high contention.

As of now there are 3 groups and 3 * 6 testcases in total:

1) group 1: synchronous mode
   objpool is managed synchronously, that is, all objects are to be
   reclaimed before objpool finalization and the objpool owner makes
   sure of it. All threads on different cores run in the same pace.
2) group 2: synchronous + miss mode
   This test group is mainly for performance evaluation of missing
   cases when pre-allocated objects are less than the requsted.
3) group 3: asynchronous mode
   This case is just an emulation of kretprobe. The objpool owner
   has no control of the object after it's allocated. hrtimer irq
   is introduced to stress objpool with thread preemption.

Signed-off-by: wuqiang <wuqiang.matt@bytedance.com>
---
 lib/Kconfig.debug  |   11 +
 lib/Makefile       |    2 +
 lib/test_objpool.c | 1052 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1065 insertions(+)
 create mode 100644 lib/test_objpool.c

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
index e938703a321f..4aa282fa0cfc 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -99,6 +99,8 @@ obj-$(CONFIG_KPROBES_SANITY_TEST) += test_kprobes.o
 obj-$(CONFIG_TEST_REF_TRACKER) += test_ref_tracker.o
 CFLAGS_test_fprobe.o += $(CC_FLAGS_FTRACE)
 obj-$(CONFIG_FPROBE_SANITY_TEST) += test_fprobe.o
+obj-$(CONFIG_TEST_OBJPOOL) += test_objpool.o
+
 #
 # CFLAGS for compiling floating point code inside the kernel. x86/Makefile turns
 # off the generation of FPU/SSE* instructions for kernel proper but FPU_FLAGS
diff --git a/lib/test_objpool.c b/lib/test_objpool.c
new file mode 100644
index 000000000000..006b79160e1d
--- /dev/null
+++ b/lib/test_objpool.c
@@ -0,0 +1,1052 @@
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
+#include <linux/vmalloc.h>
+#include <linux/delay.h>
+#include <linux/hrtimer.h>
+#include <linux/interrupt.h>
+#include <linux/objpool.h>
+
+#define OT_NR_MAX_BULK (16)
+
+struct ot_ctrl {
+	unsigned int mode; /* test no */
+	unsigned int objsz; /* object size */
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
+	unsigned long payload[32];
+};
+
+struct ot_context {
+	struct objpool_head pool; /* objpool head */
+	struct ot_ctrl *ctrl; /* ctrl parameters */
+	void *ptr; /* user pool buffer */
+	unsigned long size; /* buffer size */
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
+static struct ot_context *ot_init_sync_m0(struct ot_ctrl *ctrl)
+{
+	struct ot_context *sop = NULL;
+	int max = num_possible_cpus() << 3;
+
+	sop = (struct ot_context *)ot_kzalloc(sizeof(*sop));
+	if (!sop)
+		return NULL;
+	sop->ctrl = ctrl;
+
+	if (objpool_init(&sop->pool, max, max, ctrl->objsz,
+			GFP_KERNEL, sop, ot_init_node, NULL)) {
+		ot_kfree(sop, sizeof(*sop));
+		return NULL;
+	}
+	WARN_ON(max != sop->pool.nr_objs);
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
+static struct ot_context *ot_init_sync_m1(struct ot_ctrl *ctrl)
+{
+	struct ot_context *sop = NULL;
+	unsigned long size;
+	int rc, szobj, max = num_possible_cpus() << 3;
+
+	sop = (struct ot_context *)ot_kzalloc(sizeof(*sop));
+	if (!sop)
+		return NULL;
+	sop->ctrl = ctrl;
+
+	szobj = ALIGN(ctrl->objsz, sizeof(void *));
+	size = szobj * max;
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
+		ctrl->objsz, sop, ot_init_node);
+	if (rc) {
+		objpool_fini(&sop->pool);
+		ot_vfree(sop->ptr, size);
+		ot_kfree(sop, sizeof(*sop));
+		return NULL;
+	}
+	WARN_ON((size / szobj) != sop->pool.nr_objs);
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
+		ot_kfree(on, sop->ctrl->objsz);
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
+static struct ot_context *ot_init_sync_m2(struct ot_ctrl *ctrl)
+{
+	struct ot_context *sop = NULL;
+	struct ot_node *on;
+	int rc, i, max = num_possible_cpus() << 3;
+
+	sop = (struct ot_context *)ot_kzalloc(sizeof(*sop));
+	if (!sop)
+		return NULL;
+	sop->ctrl = ctrl;
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
+		on = ot_kzalloc(ctrl->objsz);
+		if (on) {
+			ot_init_node(sop, on);
+			on->data = 0xDEADBEEF;
+			objpool_add(on, &sop->pool);
+		}
+	}
+	WARN_ON(max != sop->pool.nr_objs);
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
+static struct ot_context *ot_init_sync_m3(struct ot_ctrl *ctrl)
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
+	sop->ctrl = ctrl;
+
+	/* create and initialize objpool as empty (no objects) */
+	nobjs = num_possible_cpus() * 2;
+	rc = objpool_init(&sop->pool, nobjs, max, ctrl->objsz, GFP_KERNEL,
+			sop, ot_init_node, ot_objpool_release);
+	if (rc) {
+		ot_kfree(sop, sizeof(*sop));
+		return NULL;
+	}
+
+	szobj = ALIGN(ctrl->objsz, sizeof(void *));
+	size = szobj * num_possible_cpus() * 4;
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
+		ctrl->objsz, sop, ot_init_node);
+	if (rc) {
+		objpool_fini(&sop->pool);
+		ot_vfree(sop->ptr, size);
+		return NULL;
+	}
+	nobjs += size / szobj;
+
+	/* allocate private objects and insert to objpool */
+	for (i = 0; i < num_possible_cpus() * 2; i++) {
+		on = ot_kzalloc(ctrl->objsz);
+		if (on) {
+			ot_init_node(sop, on);
+			on->data = 0xDEADBEEF;
+			if (!objpool_add(on, &sop->pool))
+				nobjs++;
+			else
+				ot_kfree(on, ctrl->objsz);
+		}
+	}
+	WARN_ON(nobjs != sop->pool.nr_objs);
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
+	struct ot_context * (*init)(struct ot_ctrl *);
+	void (*fini)(struct ot_context *sop);
+} g_ot_sync_ops[4] = {
+	{.init = ot_init_sync_m0, .fini = ot_fini_sync_m0},
+	{.init = ot_init_sync_m1, .fini = ot_fini_sync_m1},
+	{.init = ot_init_sync_m2, .fini = ot_fini_sync_m2},
+	{.init = ot_init_sync_m3, .fini = ot_fini_sync_m3},
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
+	sop = g_ot_sync_ops[ctrl->mode].init(ctrl);
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
+			ot_kfree(on, sop->ctrl->objsz);
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
+static struct ot_context *ot_init_async_m0(struct ot_ctrl *ctrl)
+{
+	struct ot_context *sop = NULL;
+	int max = num_possible_cpus() << 3;
+
+	sop = (struct ot_context *)ot_kzalloc(sizeof(*sop));
+	if (!sop)
+		return NULL;
+	sop->ctrl = ctrl;
+
+	if (objpool_init(&sop->pool, max, max, ctrl->objsz, GFP_KERNEL,
+			sop, ot_init_node, ot_objpool_release)) {
+		ot_kfree(sop, sizeof(*sop));
+		return NULL;
+	}
+	WARN_ON(max != sop->pool.nr_objs);
+	refcount_set(&sop->refs, max + 1);
+
+	return sop;
+}
+
+static struct ot_context *ot_init_async_m1(struct ot_ctrl *ctrl)
+{
+	struct ot_context *sop = NULL;
+	unsigned long size;
+	int szobj, rc, max = num_possible_cpus() << 3;
+
+	sop = (struct ot_context *)ot_kzalloc(sizeof(*sop));
+	if (!sop)
+		return NULL;
+	sop->ctrl = ctrl;
+
+	szobj = ALIGN(ctrl->objsz, sizeof(void *));
+	size = szobj * max;
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
+			ctrl->objsz, sop, ot_init_node);
+	if (rc) {
+		objpool_fini(&sop->pool);
+		ot_vfree(sop->ptr, size);
+		return NULL;
+	}
+
+	/* calculate total number of objects stored in ptr */
+	WARN_ON(size / szobj != sop->pool.nr_objs);
+	refcount_set(&sop->refs, size / szobj + 1);
+
+	return sop;
+}
+
+static struct ot_context *ot_init_async_m2(struct ot_ctrl *ctrl)
+{
+	struct ot_context *sop = NULL;
+	struct ot_node *on;
+	int rc, i, nobjs = 0, max = num_possible_cpus() << 3;
+
+	sop = (struct ot_context *)ot_kzalloc(sizeof(*sop));
+	if (!sop)
+		return NULL;
+	sop->ctrl = ctrl;
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
+		on = ot_kzalloc(ctrl->objsz);
+		if (on) {
+			ot_init_node(sop, on);
+			on->data = 0xDEADBEEF;
+			objpool_add(on, &sop->pool);
+			nobjs++;
+		}
+	}
+	WARN_ON(nobjs != sop->pool.nr_objs);
+	refcount_set(&sop->refs, nobjs + 1);
+
+	return sop;
+}
+
+/* objpool manipulation for synchronous mode 3 (mixed mode) */
+static struct ot_context *ot_init_async_m3(struct ot_ctrl *ctrl)
+{
+	struct ot_context *sop = NULL;
+	struct ot_node *on;
+	unsigned long size;
+	int szobj, nobjs, rc, i, max = num_possible_cpus() << 4;
+
+	sop = (struct ot_context *)ot_kzalloc(sizeof(*sop));
+	if (!sop)
+		return NULL;
+	sop->ctrl = ctrl;
+
+	/* create and initialize objpool as empty (no objects) */
+	nobjs = num_possible_cpus() * 2;
+	rc = objpool_init(&sop->pool, nobjs, max, ctrl->objsz, GFP_KERNEL,
+			sop, ot_init_node, ot_objpool_release);
+	if (rc) {
+		ot_kfree(sop, sizeof(*sop));
+		return NULL;
+	}
+
+	szobj = ALIGN(ctrl->objsz, sizeof(void *));
+	size = szobj * num_possible_cpus() * 4;
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
+			ctrl->objsz, sop, ot_init_node);
+	if (rc) {
+		objpool_fini(&sop->pool);
+		ot_vfree(sop->ptr, size);
+		return NULL;
+	}
+
+	/* calculate total number of objects stored in ptr */
+	nobjs += size / szobj;
+
+	/* allocate private objects and insert to objpool */
+	for (i = 0; i < num_possible_cpus() * 2; i++) {
+		on = ot_kzalloc(ctrl->objsz);
+		if (on) {
+			ot_init_node(sop, on);
+			on->data = 0xDEADBEEF;
+			objpool_add(on, &sop->pool);
+			nobjs++;
+		}
+	}
+	WARN_ON(nobjs != sop->pool.nr_objs);
+	refcount_set(&sop->refs, nobjs + 1);
+
+	return sop;
+}
+
+struct {
+	struct ot_context * (*init)(struct ot_ctrl *);
+	void (*fini)(struct ot_context *sop);
+} g_ot_async_ops[4] = {
+	{.init = ot_init_async_m0, .fini = ot_fini_async},
+	{.init = ot_init_async_m1, .fini = ot_fini_async},
+	{.init = ot_init_async_m2, .fini = ot_fini_async},
+	{.init = ot_init_async_m3, .fini = ot_fini_async},
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
+	WARN_ON(sop != pool->context);
+
+	if (objpool_is_inslot(on, pool)) {
+		/* object is alloced from percpu slots */
+	} else if (objpool_is_inpool(on, pool)) {
+		/* object is alloced from user-manged pool */
+	} else {
+		/* private object managed by user */
+		WARN_ON(on->data != 0xDEADBEEF);
+		ot_kfree(on, sop->ctrl->objsz);
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
+	sop = g_ot_async_ops[ctrl->mode].init(ctrl);
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
+#define NODE_COMPACT sizeof(struct ot_node)
+#define NODE_VMALLOC (512)
+
+struct ot_ctrl g_ot_sync[] = {
+	{0, NODE_COMPACT, 1000, 0,  1,  0,  0, "sync: percpu objpool"},
+	{0, NODE_VMALLOC, 1000, 0,  1,  0,  0, "sync: percpu objpool from vmalloc"},
+	{1, NODE_COMPACT, 1000, 0,  1,  0,  0, "sync: user objpool"},
+	{2, NODE_COMPACT, 1000, 0,  1,  0,  0, "sync: user objects"},
+	{3, NODE_COMPACT, 1000, 0,  1,  0,  0, "sync: mixed pools & objs"},
+	{3, NODE_VMALLOC, 1000, 0,  1,  0,  0, "sync: mixed pools & objs (vmalloc)"},
+};
+
+struct ot_ctrl g_ot_miss[] = {
+	{0, NODE_COMPACT, 1000, 0, 16,  0,  0, "sync overrun: percpu objpool"},
+	{0, NODE_VMALLOC, 1000, 0, 16,  0,  0, "sync overrun: percpu objpool from vmalloc"},
+	{1, NODE_COMPACT, 1000, 0, 16,  0,  0, "sync overrun: user objpool"},
+	{2, NODE_COMPACT, 1000, 0, 16,  0,  0, "sync overrun: user objects"},
+	{3, NODE_COMPACT, 1000, 0, 16,  0,  0, "sync overrun: mixed pools & objs"},
+	{3, NODE_VMALLOC, 1000, 0, 16,  0,  0, "sync overrun: mixed pools & objs (vmalloc)"},
+};
+
+struct ot_ctrl g_ot_async[] = {
+	{0, NODE_COMPACT, 1000, 4,  8,  8,  6, "async: percpu objpool"},
+	{0, NODE_VMALLOC, 1000, 4,  8,  8,  6, "async: percpu objpool from vmalloc"},
+	{1, NODE_COMPACT, 1000, 4,  8,  8,  6, "async: user objpool"},
+	{2, NODE_COMPACT, 1000, 4,  8,  8,  6, "async: user objects"},
+	{3, NODE_COMPACT, 1000, 4,  8,  8,  6, "async: mixed pools & objs"},
+	{3, NODE_VMALLOC, 1000, 4,  8,  8,  6, "async: mixed pools & objs (vmalloc)"},
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


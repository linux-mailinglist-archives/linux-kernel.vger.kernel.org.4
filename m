Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCAF649EAE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 13:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbiLLMdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 07:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbiLLMcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 07:32:47 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D925FF0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 04:32:46 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so15529717pjs.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 04:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cH/a1E8XhuTykeFjVwxRcwkScPTFoUzlEyI9omkgaFk=;
        b=Zg8+G9w5uvRtfwLQ7E8WIIIbSnIGXeJQ4h7M2yeyBBPH0HGXuaNH2i1GwVlGtQ/xVG
         CWszrXrYAHNyq6kO3+NwarNdScMhItuLPU0tCcLN3lTAsIgR4toML9wbk7q8nVp0hTcW
         hqGvuK1hlFCvv+CvBvwSZJq5xI8I3G2xvfv7kCdlMSlMaKdng4ho6/fr4lR4trFGyzyL
         Jh9ewc9He98ViIqDQUmMskTMcB2gCpWQJlUcHOo4bzP+7moJjGs4vB9iVRGegjGqrWIk
         52KQPbUUjM4jCZleFjn3RhDLv5jTMPFUw6RZlTbB4O/c2PQjILePJ+CruMTTNpDI/23I
         PTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cH/a1E8XhuTykeFjVwxRcwkScPTFoUzlEyI9omkgaFk=;
        b=QfNtkJoFfvXOP8418ejjSModTmZc+LtoJXNJxSHczM4TS8jj3PHOAIvjVlwBs7PJVY
         CvJL/sBWDHOkW9MeKCPbG0+YpXEmxI8odQ/2mKvxvi8BrcLAreHqsvl6FWye6iyT2Z1g
         AgEYrwfCLCMftUF6skrTQYwa47gtusz35V7+HqurTWaYyAUTFvtJgIJgwRE/ZwAdcfT9
         cm4esoViW/08nSFE5PVxd+C6TfIER4YOajHhpxc472kVhJVGnhayoVe6lT09f+8nQ0NR
         ucGhykxIphmskttoTwvg+CwlIEI9fxWnhkt9ZVPGGl0lGK+QvKtkanfBqVhZ6osvQrTx
         5Nog==
X-Gm-Message-State: ANoB5pnXgB0OC0j4pifdl2hU4NK7NaSEU73Hhcj63+1UAoYhCEwh7Vnu
        DixGf3nr9uxZjUnhE8ohH4CosA==
X-Google-Smtp-Source: AA0mqf4VZjXpcSPkfr1+8VtBMRC0HRRV8UGnH4s8kEAEBbUOQHUGOtcN0hQNho4eal40ObyZLpyj3Q==
X-Received: by 2002:a17:902:e8d8:b0:188:d405:63c0 with SMTP id v24-20020a170902e8d800b00188d40563c0mr15706265plg.6.1670848365390;
        Mon, 12 Dec 2022 04:32:45 -0800 (PST)
Received: from devtp.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id jw1-20020a170903278100b001869ba04c83sm6219987plb.245.2022.12.12.04.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 04:32:45 -0800 (PST)
From:   wuqiang <wuqiang.matt@bytedance.com>
To:     mhiramat@kernel.org, davem@davemloft.net,
        anil.s.keshavamurthy@intel.com, naveen.n.rao@linux.ibm.com,
        rostedt@goodmis.org, peterz@infradead.org,
        akpm@linux-foundation.org, sander@svanheule.net,
        ebiggers@google.com, dan.j.williams@intel.com, jpoimboe@kernel.org
Cc:     linux-kernel@vger.kernel.org, lkp@intel.com, mattwu@163.com,
        wuqiang <wuqiang.matt@bytedance.com>
Subject: [PATCH v7 2/5] lib: objpool test module added
Date:   Mon, 12 Dec 2022 20:31:50 +0800
Message-Id: <20221212123153.190888-3-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221212123153.190888-1-wuqiang.matt@bytedance.com>
References: <20221212123153.190888-1-wuqiang.matt@bytedance.com>
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

The test_objpool module (test_objpool) will run several testcases
for objpool stress and performance evaluation. Each testcase will
have all available cpu cores involved to create a situation of high
parallel and high contention.

As of now there are 3 groups and 3 * 2 testcases in total:

1) group 1: synchronous mode
   objpool is managed synchronously, that is, all objects are to be
   reclaimed before objpool finalization and the objpool owner makes
   sure of it. All threads on different cores run in the same pace.
2) group 2: synchronous + miss mode
   This test group is mainly for performance evaluation of missing
   cases when pre-allocated objects are less than the requested.
3) group 3: asynchronous mode
   This case is just an emulation of kretprobe. The objpool owner
   has no control of the object after it's allocated. hrtimer irq
   is introduced to stress objpool with thread preemption.

Signed-off-by: wuqiang <wuqiang.matt@bytedance.com>
---
 lib/Kconfig.debug  |  11 +
 lib/Makefile       |   2 +
 lib/test_objpool.c | 696 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 709 insertions(+)
 create mode 100644 lib/test_objpool.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 3638b3424be5..840903b51434 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2750,6 +2750,17 @@ config TEST_CLOCKSOURCE_WATCHDOG
 
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
index f23d9c4fe639..c078dc5f64ac 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -100,6 +100,8 @@ obj-$(CONFIG_KPROBES_SANITY_TEST) += test_kprobes.o
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
index 000000000000..733b557c25b1
--- /dev/null
+++ b/lib/test_objpool.c
@@ -0,0 +1,696 @@
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
+	int mode; /* test no */
+	int objsz; /* object size */
+	int duration; /* ms */
+	int delay; /* ms */
+	int bulk_normal;
+	int bulk_irq;
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
+static void *ot_kzalloc(long size)
+{
+	void *ptr = kzalloc(size, GFP_KERNEL);
+
+	if (ptr)
+		atomic_long_add(size, &g_ot_data.kmalloc.alloc);
+	return ptr;
+}
+
+static void ot_kfree(void *ptr, long size)
+{
+	if (!ptr)
+		return;
+	atomic_long_add(size, &g_ot_data.kmalloc.free);
+	kfree(ptr);
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
+static int ot_init_node(void *nod, void *context)
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
+	if (objpool_init(&sop->pool, max, ctrl->objsz,
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
+struct {
+	struct ot_context * (*init)(struct ot_ctrl *oc);
+	void (*fini)(struct ot_context *sop);
+} g_ot_sync_ops[] = {
+	{.init = ot_init_sync_m0, .fini = ot_fini_sync_m0},
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
+static int ot_objpool_release(struct objpool_head *head, void *context)
+{
+	struct ot_context *sop = context;
+
+	WARN_ON(!head || !sop || head != &sop->pool);
+
+	/* do context cleaning if needed */
+	if (sop)
+		ot_kfree(sop, sizeof(*sop));
+
+	return 0;
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
+	if (objpool_init(&sop->pool, max, ctrl->objsz, GFP_KERNEL,
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
+struct {
+	struct ot_context * (*init)(struct ot_ctrl *oc);
+	void (*fini)(struct ot_context *sop);
+} g_ot_async_ops[] = {
+	{.init = ot_init_async_m0, .fini = ot_fini_async},
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
+ *   synchronous case / overrun case / async case
+ *
+ * mode: int, currently only mode 0 is supoorted
+ * duration: int, total test time in ms
+ * delay: int, delay (in ms) between each iteration
+ * bulk_normal: int, repeat times for thread worker
+ * bulk_irq: int, repeat times for irq consumer
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
+};
+
+struct ot_ctrl g_ot_miss[] = {
+	{0, NODE_COMPACT, 1000, 0, 16,  0,  0, "sync overrun: percpu objpool"},
+	{0, NODE_VMALLOC, 1000, 0, 16,  0,  0, "sync overrun: percpu objpool from vmalloc"},
+};
+
+struct ot_ctrl g_ot_async[] = {
+	{0, NODE_COMPACT, 1000, 4,  8,  8,  6, "async: percpu objpool"},
+	{0, NODE_VMALLOC, 1000, 4,  8,  8,  6, "async: percpu objpool from vmalloc"},
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


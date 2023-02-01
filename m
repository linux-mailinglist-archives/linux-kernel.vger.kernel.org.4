Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2567C67F2F6
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 01:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbjA1ASe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 19:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbjA1AR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 19:17:58 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775308CE0A;
        Fri, 27 Jan 2023 16:17:19 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id m7-20020a17090a71c700b0022c0c070f2eso9527651pjs.4;
        Fri, 27 Jan 2023 16:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8Wg3buyUVmzj1nVU/xvoPwhExg5e4UIeqpe9oiGhGg=;
        b=X8uvBY94mm2kvvnum30Cu1CaasRa2fwjiL8LMXwyHLm9oPvchfCCa2Otvz2+JGOKt6
         AWYNeqDXICAE//Pr+CYhg/qgPLLf5xc6ox7lNAlw97cP9xealWRCiN8Uxztn64KXz5Hs
         gYxtmdbsecWGGqJDv4x8AulzmZEjDTV6OhfcNpuxMQSld8RuTJwPt5If+CzxhJh9fBqu
         IbwrYgsyeFTrE1yBOn9D0wniiTr4+uZqAvHHZneZfM2fSN49fL9aNuyT9rcr3P++28q1
         4Cw1TwtpaOmNPCOvLpOTEzu8mo+/Q+tgydXpwbnpfzVYMoBzWwJlAohx4QtdoP9EkMKt
         UDQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F8Wg3buyUVmzj1nVU/xvoPwhExg5e4UIeqpe9oiGhGg=;
        b=wvO/oEl5KxO3bH6RgJXYf0ToNU6r/QUOhSO2B2HIRInKPydZl3osG93/x89lBlLAJx
         Rj1Np8BqdtfTQK2M7RJ2FyHnruD5SuapZQFYn7Q3z5CkOrKcs6l4/mgOgCTFs0EF7LL2
         fIqEHnBM/NXBP0lYYWfWCFilEOqxLyjSz6xL/+UbHCdNpSUz7GsyYlq+QMegynBBNIKU
         pY1QOp9DZOOM17f/zbWly8b16q3+be2eXkdVBqiPC3qtNdB5XfbuhsXV9VNOaOZ+VM+m
         99MQfEP6ivFXanOD7WdqpGkgFN8TOHYFgoxgHdl6MND7cVLNite1VF3Sen1Zi1zBdYyV
         kV0g==
X-Gm-Message-State: AO0yUKU6PYBUWfjbplAAVCk7BDAiOBuSJAf9PlGy1gy8QDw0OtZF5eca
        9PhtIoT+jXT7WY9NuZq6ZFo=
X-Google-Smtp-Source: AK7set/GWjxvgH/hohCz03RIkp7L6QWgoIirYJ4aXNeRlvnmRszlrNhbOarWByUeV5gv2pD9G3kslg==
X-Received: by 2002:a17:903:3012:b0:196:3853:2926 with SMTP id o18-20020a170903301200b0019638532926mr8037208pla.9.1674865036019;
        Fri, 27 Jan 2023 16:17:16 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id z10-20020a170902ccca00b0019623858afbsm3431042ple.71.2023.01.27.16.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 16:17:15 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 13/30] sched_ext: Implement BPF extensible scheduler class
Date:   Fri, 27 Jan 2023 14:16:22 -1000
Message-Id: <20230128001639.3510083-14-tj@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230128001639.3510083-1-tj@kernel.org>
References: <20230128001639.3510083-1-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a new scheduler class sched_ext (SCX), which allows scheduling
policies to be implemented as BPF programs to achieve the following:

1. Ease of experimentation and exploration: Enabling rapid iteration of new
   scheduling policies.

2. Customization: Building application-specific schedulers which implement
   policies that are not applicable to general-purpose schedulers.

3. Rapid scheduler deployments: Non-disruptive swap outs of scheduling
   policies in production environments.

sched_ext leverages BPF’s struct_ops feature to define a structure which
exports function callbacks and flags to BPF programs that wish to implement
scheduling policies. The struct_ops structure exported by sched_ext is
struct sched_ext_ops, and is conceptually similar to struct sched_class. The
role of sched_ext is to map the complex sched_class callbacks to the more
simple and ergonomic struct sched_ext_ops callbacks.

For more detailed discussion on the motivations and overview, please refer
to the cover letter.

Later patches will also add several example schedulers and documentation.

This patch implements the minimum core framework to enable implementation of
BPF schedulers. Subsequent patches will gradually add functionalities
including safety guarantee mechanisms, nohz and cgroup support.

include/linux/sched/ext.h defines struct sched_ext_ops. With the comment on
top, each operation should be self-explanatory. The followings are worth
noting:

* Both "sched_ext" and its shorthand "scx" are used. If the identifier
  already has "sched" in it, "ext" is used; otherwise, "scx".

* In sched_ext_ops, only .name is mandatory. Every operation is optional and
  if omitted a simple but functional default behavior is provided.

* A new policy constant SCHED_EXT is added and a task can select sched_ext
  by invoking sched_setscheduler(2) with the new policy constant. However,
  if the BPF scheduler is not loaded, SCHED_EXT is the same as SCHED_NORMAL
  and the task is scheduled by CFS. When the BPF scheduler is loaded, all
  tasks which have the SCHED_EXT policy are switched to sched_ext.

* To bridge the workflow imbalance between the scheduler core and
  sched_ext_ops callbacks, sched_ext uses simple FIFOs called dispatch
  queues (dsq's). By default, there is one global dsq (SCX_DSQ_GLOBAL), and
  one local per-CPU dsq (SCX_DSQ_LOCAL). SCX_DSQ_GLOBAL is provided for
  convenience and need not be used by a scheduler that doesn't require it.
  SCX_DSQ_LOCAL is the per-CPU FIFO that sched_ext pulls from when putting
  the next task on the CPU. The BPF scheduler can manage an arbitrary number
  of dsq's using scx_bpf_create_dsq() and scx_bpf_destroy_dsq().

* sched_ext guarantees system integrity no matter what the BPF scheduler
  does. To enable this, each task's ownership is tracked through
  p->scx.ops_state and all tasks are put on scx_tasks list. The disable path
  can always recover and revert all tasks back to CFS. See p->scx.ops_state
  and scx_tasks.

* A task is not tied to its rq while enqueued. This decouples CPU selection
  from queueing and allows sharing a scheduling queue across an arbitrary
  subset of CPUs. This adds some complexities as a task may need to be
  bounced between rq's right before it starts executing. See
  dispatch_to_local_dsq() and move_task_to_local_dsq().

* One complication that arises from the above weak association between task
  and rq is that synchronizing with dequeue() gets complicated as dequeue()
  may happen anytime while the task is enqueued and the dispatch path might
  need to release the rq lock to transfer the task. Solving this requires a
  bit of complexity. See the logic around p->scx.sticky_cpu and
  p->scx.ops_qseq.

* Both enable and disable paths are a bit complicated. The enable path
  switches all tasks without blocking to avoid issues which can arise from
  partially switched states (e.g. the switching task itself being starved).
  The disable path can't trust the BPF scheduler at all, so it also has to
  guarantee forward progress without blocking. See scx_ops_enable() and
  scx_ops_disable_workfn().

* When sched_ext is disabled, static_branches are used to shut down the
  entry points from hot paths.

v2: * balance_scx_on_up() is dropped. Instead, on UP, balance_scx() is
      called from put_prev_taks_scx() and pick_next_task_scx() as necessary.
      To determine whether balance_scx() should be called from
      put_prev_task_scx(), SCX_TASK_DEQD_FOR_SLEEP flag is added. See the
      comment in put_prev_task_scx() for details.

    * sched_deq_and_put_task() / sched_enq_and_set_task() sequences replaced
      with SCHED_CHANGE_BLOCK().

    * Unused all_dsqs list removed. This was a left-over from previous
      iterations.

    * p->scx.kf_mask is added to track and enforce which kfunc helpers are
      allowed. Also, init/exit sequences are updated to make some kfuncs
      always safe to call regardless of the current BPF scheduler state.
      Combined, this should make all the kfuncs safe.

    * BPF now supports sleepable struct_ops operations. Hacky workaround
      removed and operations and kfunc helpers are tagged appropriately.

    * BPF now supports bitmask / cpumask helpers. scx_bpf_get_idle_cpumask()
      and friends are added so that BPF schedulers can use the idle masks
      with the generic helpers. This replaces the hacky kfunc helpers added
      by a separate patch in V1.

    * CONFIG_SCHED_CLASS_EXT can no longer be enabled if SCHED_CORE is
      enabled. This restriction will be removed by a later patch which adds
      core-sched support.

    * Add MAINTAINERS entries and other misc changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
Co-authored-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 MAINTAINERS                       |    3 +
 include/asm-generic/vmlinux.lds.h |    1 +
 include/linux/sched.h             |    5 +
 include/linux/sched/ext.h         |  389 +++-
 include/uapi/linux/sched.h        |    1 +
 init/init_task.c                  |   10 +
 kernel/Kconfig.preempt            |   22 +-
 kernel/bpf/bpf_struct_ops_types.h |    4 +
 kernel/sched/build_policy.c       |    4 +
 kernel/sched/core.c               |   26 +
 kernel/sched/debug.c              |    6 +
 kernel/sched/ext.c                | 2979 +++++++++++++++++++++++++++++
 kernel/sched/ext.h                |   97 +-
 kernel/sched/sched.h              |   15 +
 14 files changed, 3558 insertions(+), 4 deletions(-)
 create mode 100644 kernel/sched/ext.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 0f61b5d64716..678e511bc3ba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18588,6 +18588,8 @@ R:	Ben Segall <bsegall@google.com> (CONFIG_CFS_BANDWIDTH)
 R:	Mel Gorman <mgorman@suse.de> (CONFIG_NUMA_BALANCING)
 R:	Daniel Bristot de Oliveira <bristot@redhat.com> (SCHED_DEADLINE)
 R:	Valentin Schneider <vschneid@redhat.com> (TOPOLOGY)
+R:	Tejun Heo <tj@kernel.org> (SCHED_EXT)
+R:	David Vernet <void@manifault.com> (SCHED_EXT)
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
@@ -18596,6 +18598,7 @@ F:	include/linux/sched.h
 F:	include/linux/wait.h
 F:	include/uapi/linux/sched.h
 F:	kernel/sched/
+F:	tools/sched_ext/
 
 SCR24X CHIP CARD INTERFACE DRIVER
 M:	Lubomir Rintel <lkundrak@v3.sk>
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 659bf3b31c91..b9974e6eadd8 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -131,6 +131,7 @@
 	*(__dl_sched_class)			\
 	*(__rt_sched_class)			\
 	*(__fair_sched_class)			\
+	*(__ext_sched_class)			\
 	*(__idle_sched_class)			\
 	__sched_class_lowest = .;
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 853d08f7562b..9c0362e3be71 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -70,6 +70,8 @@ struct signal_struct;
 struct task_delay_info;
 struct task_group;
 
+#include <linux/sched/ext.h>
+
 /*
  * Task state bitmask. NOTE! These bits are also
  * encoded in fs/proc/array.c: get_task_state().
@@ -788,6 +790,9 @@ struct task_struct {
 	struct sched_entity		se;
 	struct sched_rt_entity		rt;
 	struct sched_dl_entity		dl;
+#ifdef CONFIG_SCHED_CLASS_EXT
+	struct sched_ext_entity		scx;
+#endif
 	const struct sched_class	*sched_class;
 
 #ifdef CONFIG_SCHED_CORE
diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index a05dfcf533b0..8894b6a9977d 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -1,9 +1,396 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
+ * Copyright (c) 2022 David Vernet <dvernet@meta.com>
+ */
 #ifndef _LINUX_SCHED_EXT_H
 #define _LINUX_SCHED_EXT_H
 
 #ifdef CONFIG_SCHED_CLASS_EXT
-#error "NOT IMPLEMENTED YET"
+
+#include <linux/rhashtable.h>
+#include <linux/llist.h>
+
+enum scx_consts {
+	SCX_OPS_NAME_LEN	= 128,
+	SCX_EXIT_REASON_LEN	= 128,
+	SCX_EXIT_BT_LEN		= 64,
+	SCX_EXIT_MSG_LEN	= 1024,
+
+	SCX_SLICE_DFL		= 20 * NSEC_PER_MSEC,
+};
+
+/*
+ * DSQ (dispatch queue) IDs are 64bit of the format:
+ *
+ *   Bits: [63] [62 ..  0]
+ *         [ B] [   ID   ]
+ *
+ *    B: 1 for IDs for built-in DSQs, 0 for ops-created user DSQs
+ *   ID: 63 bit ID
+ *
+ * Built-in IDs:
+ *
+ *   Bits: [63] [62] [61..32] [31 ..  0]
+ *         [ 1] [ L] [   R  ] [    V   ]
+ *
+ *    1: 1 for built-in DSQs.
+ *    L: 1 for LOCAL_ON DSQ IDs, 0 for others
+ *    V: For LOCAL_ON DSQ IDs, a CPU number. For others, a pre-defined value.
+ */
+enum scx_dsq_id_flags {
+	SCX_DSQ_FLAG_BUILTIN	= 1LLU << 63,
+	SCX_DSQ_FLAG_LOCAL_ON	= 1LLU << 62,
+
+	SCX_DSQ_INVALID		= SCX_DSQ_FLAG_BUILTIN | 0,
+	SCX_DSQ_GLOBAL		= SCX_DSQ_FLAG_BUILTIN | 1,
+	SCX_DSQ_LOCAL		= SCX_DSQ_FLAG_BUILTIN | 2,
+	SCX_DSQ_LOCAL_ON	= SCX_DSQ_FLAG_BUILTIN | SCX_DSQ_FLAG_LOCAL_ON,
+	SCX_DSQ_LOCAL_CPU_MASK	= 0xffffffffLLU,
+};
+
+enum scx_exit_type {
+	SCX_EXIT_NONE,
+	SCX_EXIT_DONE,
+
+	SCX_EXIT_UNREG = 64,	/* BPF unregistration */
+
+	SCX_EXIT_ERROR = 1024,	/* runtime error, error msg contains details */
+	SCX_EXIT_ERROR_BPF,	/* ERROR but triggered through scx_bpf_error() */
+};
+
+/*
+ * scx_exit_info is passed to ops.exit() to describe why the BPF scheduler is
+ * being disabled.
+ */
+struct scx_exit_info {
+	/* %SCX_EXIT_* - broad category of the exit reason */
+	enum scx_exit_type	type;
+	/* textual representation of the above */
+	char			reason[SCX_EXIT_REASON_LEN];
+	/* number of entries in the backtrace */
+	u32			bt_len;
+	/* backtrace if exiting due to an error */
+	unsigned long		bt[SCX_EXIT_BT_LEN];
+	/* extra message */
+	char			msg[SCX_EXIT_MSG_LEN];
+};
+
+/* sched_ext_ops.flags */
+enum scx_ops_flags {
+	/*
+	 * Keep built-in idle tracking even if ops.update_idle() is implemented.
+	 */
+	SCX_OPS_KEEP_BUILTIN_IDLE = 1LLU << 0,
+
+	/*
+	 * By default, if there are no other task to run on the CPU, ext core
+	 * keeps running the current task even after its slice expires. If this
+	 * flag is specified, such tasks are passed to ops.enqueue() with
+	 * %SCX_ENQ_LAST. See the comment above %SCX_ENQ_LAST for more info.
+	 */
+	SCX_OPS_ENQ_LAST	= 1LLU << 1,
+
+	/*
+	 * An exiting task may schedule after PF_EXITING is set. In such cases,
+	 * scx_bpf_find_task_by_pid() may not be able to find the task and if
+	 * the BPF scheduler depends on pid lookup for dispatching, the task
+	 * will be lost leading to various issues including RCU grace period
+	 * stalls.
+	 *
+	 * To mask this problem, by default, unhashed tasks are automatically
+	 * dispatched to the local DSQ on enqueue. If the BPF scheduler doesn't
+	 * depend on pid lookups and wants to handle these tasks directly, the
+	 * following flag can be used.
+	 */
+	SCX_OPS_ENQ_EXITING	= 1LLU << 2,
+
+	SCX_OPS_ALL_FLAGS	= SCX_OPS_KEEP_BUILTIN_IDLE |
+				  SCX_OPS_ENQ_LAST |
+				  SCX_OPS_ENQ_EXITING,
+};
+
+/* argument container for ops.enable() and friends */
+struct scx_enable_args {
+	/* empty for now */
+};
+
+/**
+ * struct sched_ext_ops - Operation table for BPF scheduler implementation
+ *
+ * Userland can implement an arbitrary scheduling policy by implementing and
+ * loading operations in this table.
+ */
+struct sched_ext_ops {
+	/**
+	 * select_cpu - Pick the target CPU for a task which is being woken up
+	 * @p: task being woken up
+	 * @prev_cpu: the cpu @p was on before sleeping
+	 * @wake_flags: SCX_WAKE_*
+	 *
+	 * Decision made here isn't final. @p may be moved to any CPU while it
+	 * is getting dispatched for execution later. However, as @p is not on
+	 * the rq at this point, getting the eventual execution CPU right here
+	 * saves a small bit of overhead down the line.
+	 *
+	 * If an idle CPU is returned, the CPU is kicked and will try to
+	 * dispatch. While an explicit custom mechanism can be added,
+	 * select_cpu() serves as the default way to wake up idle CPUs.
+	 */
+	s32 (*select_cpu)(struct task_struct *p, s32 prev_cpu, u64 wake_flags);
+
+	/**
+	 * enqueue - Enqueue a task on the BPF scheduler
+	 * @p: task being enqueued
+	 * @enq_flags: %SCX_ENQ_*
+	 *
+	 * @p is ready to run. Dispatch directly by calling scx_bpf_dispatch()
+	 * or enqueue on the BPF scheduler. If not directly dispatched, the bpf
+	 * scheduler owns @p and if it fails to dispatch @p, the task will
+	 * stall.
+	 */
+	void (*enqueue)(struct task_struct *p, u64 enq_flags);
+
+	/**
+	 * dequeue - Remove a task from the BPF scheduler
+	 * @p: task being dequeued
+	 * @deq_flags: %SCX_DEQ_*
+	 *
+	 * Remove @p from the BPF scheduler. This is usually called to isolate
+	 * the task while updating its scheduling properties (e.g. priority).
+	 *
+	 * The ext core keeps track of whether the BPF side owns a given task or
+	 * not and can gracefully ignore spurious dispatches from BPF side,
+	 * which makes it safe to not implement this method. However, depending
+	 * on the scheduling logic, this can lead to confusing behaviors - e.g.
+	 * scheduling position not being updated across a priority change.
+	 */
+	void (*dequeue)(struct task_struct *p, u64 deq_flags);
+
+	/**
+	 * dispatch - Dispatch tasks from the BPF scheduler and/or consume DSQs
+	 * @cpu: CPU to dispatch tasks for
+	 * @prev: previous task being switched out
+	 *
+	 * Called when a CPU's local dsq is empty. The operation should dispatch
+	 * one or more tasks from the BPF scheduler into the DSQs using
+	 * scx_bpf_dispatch() and/or consume user DSQs into the local DSQ using
+	 * scx_bpf_consume().
+	 *
+	 * The maximum number of times scx_bpf_dispatch() can be called without
+	 * an intervening scx_bpf_consume() is specified by
+	 * ops.dispatch_max_batch. See the comments on top of the two functions
+	 * for more details.
+	 *
+	 * When not %NULL, @prev is an SCX task with its slice depleted. If
+	 * @prev is still runnable as indicated by set %SCX_TASK_QUEUED in
+	 * @prev->scx.flags, it is not enqueued yet and will be enqueued after
+	 * ops.dispatch() returns. To keep executing @prev, return without
+	 * dispatching or consuming any tasks. Also see %SCX_OPS_ENQ_LAST.
+	 */
+	void (*dispatch)(s32 cpu, struct task_struct *prev);
+
+	/**
+	 * yield - Yield CPU
+	 * @from: yielding task
+	 * @to: optional yield target task
+	 *
+	 * If @to is NULL, @from is yielding the CPU to other runnable tasks.
+	 * The BPF scheduler should ensure that other available tasks are
+	 * dispatched before the yielding task. Return value is ignored in this
+	 * case.
+	 *
+	 * If @to is not-NULL, @from wants to yield the CPU to @to. If the bpf
+	 * scheduler can implement the request, return %true; otherwise, %false.
+	 */
+	bool (*yield)(struct task_struct *from, struct task_struct *to);
+
+	/**
+	 * set_cpumask - Set CPU affinity
+	 * @p: task to set CPU affinity for
+	 * @cpumask: cpumask of cpus that @p can run on
+	 *
+	 * Update @p's CPU affinity to @cpumask.
+	 */
+	void (*set_cpumask)(struct task_struct *p, struct cpumask *cpumask);
+
+	/**
+	 * update_idle - Update the idle state of a CPU
+	 * @cpu: CPU to udpate the idle state for
+	 * @idle: whether entering or exiting the idle state
+	 *
+	 * This operation is called when @rq's CPU goes or leaves the idle
+	 * state. By default, implementing this operation disables the built-in
+	 * idle CPU tracking and the following helpers become unavailable:
+	 *
+	 * - scx_bpf_select_cpu_dfl()
+	 * - scx_bpf_test_and_clear_cpu_idle()
+	 * - scx_bpf_pick_idle_cpu()
+	 * - scx_bpf_any_idle_cpu()
+	 *
+	 * The user also must implement ops.select_cpu() as the default
+	 * implementation relies on scx_bpf_select_cpu_dfl().
+	 *
+	 * If you keep the built-in idle tracking, specify the
+	 * %SCX_OPS_KEEP_BUILTIN_IDLE flag.
+	 */
+	void (*update_idle)(s32 cpu, bool idle);
+
+	/**
+	 * prep_enable - Prepare to enable BPF scheduling for a task
+	 * @p: task to prepare BPF scheduling for
+	 * @args: enable arguments, see the struct definition
+	 *
+	 * Either we're loading a BPF scheduler or a new task is being forked.
+	 * Prepare BPF scheduling for @p. This operation may block and can be
+	 * used for allocations.
+	 *
+	 * Return 0 for success, -errno for failure. An error return while
+	 * loading will abort loading of the BPF scheduler. During a fork, will
+	 * abort the specific fork.
+	 */
+	s32 (*prep_enable)(struct task_struct *p, struct scx_enable_args *args);
+
+	/**
+	 * enable - Enable BPF scheduling for a task
+	 * @p: task to enable BPF scheduling for
+	 * @args: enable arguments, see the struct definition
+	 *
+	 * Enable @p for BPF scheduling. @p will start running soon.
+	 */
+	void (*enable)(struct task_struct *p, struct scx_enable_args *args);
+
+	/**
+	 * cancel_enable - Cancel prep_enable()
+	 * @p: task being canceled
+	 * @args: enable arguments, see the struct definition
+	 *
+	 * @p was prep_enable()'d but failed before reaching enable(). Undo the
+	 * preparation.
+	 */
+	void (*cancel_enable)(struct task_struct *p,
+			      struct scx_enable_args *args);
+
+	/**
+	 * disable - Disable BPF scheduling for a task
+	 * @p: task to disable BPF scheduling for
+	 *
+	 * @p is exiting, leaving SCX or the BPF scheduler is being unloaded.
+	 * Disable BPF scheduling for @p.
+	 */
+	void (*disable)(struct task_struct *p);
+
+	/*
+	 * All online ops must come before ops.init().
+	 */
+
+	/**
+	 * init - Initialize the BPF scheduler
+	 */
+	s32 (*init)(void);
+
+	/**
+	 * exit - Clean up after the BPF scheduler
+	 * @info: Exit info
+	 */
+	void (*exit)(struct scx_exit_info *info);
+
+	/**
+	 * dispatch_max_batch - Max nr of tasks that dispatch() can dispatch
+	 */
+	u32 dispatch_max_batch;
+
+	/**
+	 * flags - %SCX_OPS_* flags
+	 */
+	u64 flags;
+
+	/**
+	 * name - BPF scheduler's name
+	 *
+	 * Must be a non-zero valid BPF object name including only isalnum(),
+	 * '_' and '.' chars. Shows up in kernel.sched_ext_ops sysctl while the
+	 * BPF scheduler is enabled.
+	 */
+	char name[SCX_OPS_NAME_LEN];
+};
+
+/*
+ * Dispatch queue (dsq) is a simple FIFO which is used to buffer between the
+ * scheduler core and the BPF scheduler. See the documentation for more details.
+ */
+struct scx_dispatch_q {
+	raw_spinlock_t		lock;
+	struct list_head	fifo;
+	u64			id;
+	u32			nr;
+	struct rhash_head	hash_node;
+	struct llist_node	free_node;
+	struct rcu_head		rcu;
+};
+
+/* scx_entity.flags */
+enum scx_ent_flags {
+	SCX_TASK_QUEUED		= 1 << 0, /* on ext runqueue */
+	SCX_TASK_BAL_KEEP	= 1 << 1, /* balance decided to keep current */
+	SCX_TASK_ENQ_LOCAL	= 1 << 2, /* used by scx_select_cpu_dfl() to set SCX_ENQ_LOCAL */
+
+	SCX_TASK_OPS_PREPPED	= 1 << 3, /* prepared for BPF scheduler enable */
+	SCX_TASK_OPS_ENABLED	= 1 << 4, /* task has BPF scheduler enabled */
+
+	SCX_TASK_DEQD_FOR_SLEEP	= 1 << 6, /* last dequeue was for SLEEP */
+
+	SCX_TASK_CURSOR		= 1 << 7, /* iteration cursor, not a task */
+};
+
+/*
+ * Mask bits for scx_entity.kf_mask. Not all kfuncs can be called from
+ * everywhere and the following bits track which kfunc sets are currently
+ * allowed for %current. This simple per-task tracking works because SCX ops
+ * nest in a limited way. BPF will likely implement a way to allow and disallow
+ * kfuncs depending on the calling context which will replace this manual
+ * mechanism. See scx_kf_allow().
+ */
+enum scx_kf_mask {
+	/* others may be nested inside INIT and SLEEPABLE */
+	SCX_KF_INIT		= 1 << 0, /* allowed from ops.init() */
+	SCX_KF_SLEEPABLE	= 1 << 1, /* from sleepable init operations */
+
+	SCX_KF_ENQUEUE_DISPATCH	= 1 << 3, /* from ops.enqueue() or .dispatch() */
+	SCX_KF_DISPATCH		= 1 << 4, /* from ops.dispatch() */
+};
+
+/*
+ * The following is embedded in task_struct and contains all fields necessary
+ * for a task to be scheduled by SCX.
+ */
+struct sched_ext_entity {
+	struct scx_dispatch_q	*dsq;
+	struct list_head	dsq_node;
+	u32			flags;		/* protected by rq lock */
+	u32			weight;
+	s32			sticky_cpu;
+	s32			holding_cpu;
+	u32			kf_mask;	/* see scx_kf_mask above */
+	atomic64_t		ops_state;
+
+	/* BPF scheduler modifiable fields */
+
+	/*
+	 * Runtime budget in nsecs. This is usually set through
+	 * scx_bpf_dispatch() but can also be modified directly by the BPF
+	 * scheduler. Automatically decreased by SCX as the task executes. On
+	 * depletion, a scheduling event is triggered.
+	 */
+	u64			slice;
+
+	/* cold fields */
+	struct list_head	tasks_node;
+};
+
+void sched_ext_free(struct task_struct *p);
+
 #else	/* !CONFIG_SCHED_CLASS_EXT */
 
 static inline void sched_ext_free(struct task_struct *p) {}
diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 3bac0a8ceab2..359a14cc76a4 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -118,6 +118,7 @@ struct clone_args {
 /* SCHED_ISO: reserved but not implemented yet */
 #define SCHED_IDLE		5
 #define SCHED_DEADLINE		6
+#define SCHED_EXT		7
 
 /* Can be ORed in to make sure the process is reverted back to SCHED_NORMAL on fork */
 #define SCHED_RESET_ON_FORK     0x40000000
diff --git a/init/init_task.c b/init/init_task.c
index ff6c4b9bfe6b..bdbc663107bf 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -6,6 +6,7 @@
 #include <linux/sched/sysctl.h>
 #include <linux/sched/rt.h>
 #include <linux/sched/task.h>
+#include <linux/sched/ext.h>
 #include <linux/init.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
@@ -101,6 +102,15 @@ struct task_struct init_task
 #endif
 #ifdef CONFIG_CGROUP_SCHED
 	.sched_task_group = &root_task_group,
+#endif
+#ifdef CONFIG_SCHED_CLASS_EXT
+	.scx		= {
+		.dsq_node	= LIST_HEAD_INIT(init_task.scx.dsq_node),
+		.sticky_cpu	= -1,
+		.holding_cpu	= -1,
+		.ops_state	= ATOMIC_INIT(0),
+		.slice		= SCX_SLICE_DFL,
+	},
 #endif
 	.ptraced	= LIST_HEAD_INIT(init_task.ptraced),
 	.ptrace_entry	= LIST_HEAD_INIT(init_task.ptrace_entry),
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index c2f1fd95a821..0afcda19bc50 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -133,4 +133,24 @@ config SCHED_CORE
 	  which is the likely usage by Linux distributions, there should
 	  be no measurable impact on performance.
 
-
+config SCHED_CLASS_EXT
+	bool "Extensible Scheduling Class"
+	depends on BPF_SYSCALL && BPF_JIT && !SCHED_CORE
+	help
+	  This option enables a new scheduler class sched_ext (SCX), which
+	  allows scheduling policies to be implemented as BPF programs to
+	  achieve the following:
+
+	  - Ease of experimentation and exploration: Enabling rapid
+	    iteration of new scheduling policies.
+	  - Customization: Building application-specific schedulers which
+	    implement policies that are not applicable to general-purpose
+	    schedulers.
+	  - Rapid scheduler deployments: Non-disruptive swap outs of
+	    scheduling policies in production environments.
+
+	  sched_ext leverages BPF’s struct_ops feature to define a structure
+	  which exports function callbacks and flags to BPF programs that
+	  wish to implement scheduling policies. The struct_ops structure
+	  exported by sched_ext is struct sched_ext_ops, and is conceptually
+	  similar to struct sched_class.
diff --git a/kernel/bpf/bpf_struct_ops_types.h b/kernel/bpf/bpf_struct_ops_types.h
index 5678a9ddf817..3618769d853d 100644
--- a/kernel/bpf/bpf_struct_ops_types.h
+++ b/kernel/bpf/bpf_struct_ops_types.h
@@ -9,4 +9,8 @@ BPF_STRUCT_OPS_TYPE(bpf_dummy_ops)
 #include <net/tcp.h>
 BPF_STRUCT_OPS_TYPE(tcp_congestion_ops)
 #endif
+#ifdef CONFIG_SCHED_CLASS_EXT
+#include <linux/sched/ext.h>
+BPF_STRUCT_OPS_TYPE(sched_ext_ops)
+#endif
 #endif
diff --git a/kernel/sched/build_policy.c b/kernel/sched/build_policy.c
index d9dc9ab3773f..4c658b21f603 100644
--- a/kernel/sched/build_policy.c
+++ b/kernel/sched/build_policy.c
@@ -28,6 +28,7 @@
 #include <linux/suspend.h>
 #include <linux/tsacct_kern.h>
 #include <linux/vtime.h>
+#include <linux/percpu-rwsem.h>
 
 #include <uapi/linux/sched/types.h>
 
@@ -52,3 +53,6 @@
 #include "cputime.c"
 #include "deadline.c"
 
+#ifdef CONFIG_SCHED_CLASS_EXT
+# include "ext.c"
+#endif
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6058042dcc3d..804aa291b837 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4421,6 +4421,18 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	p->rt.on_rq		= 0;
 	p->rt.on_list		= 0;
 
+#ifdef CONFIG_SCHED_CLASS_EXT
+	p->scx.dsq		= NULL;
+	INIT_LIST_HEAD(&p->scx.dsq_node);
+	p->scx.flags		= 0;
+	p->scx.weight		= 0;
+	p->scx.sticky_cpu	= -1;
+	p->scx.holding_cpu	= -1;
+	p->scx.kf_mask		= 0;
+	atomic64_set(&p->scx.ops_state, 0);
+	p->scx.slice		= SCX_SLICE_DFL;
+#endif
+
 #ifdef CONFIG_PREEMPT_NOTIFIERS
 	INIT_HLIST_HEAD(&p->preempt_notifiers);
 #endif
@@ -4668,6 +4680,10 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 		goto out_cancel;
 	} else if (rt_prio(p->prio)) {
 		p->sched_class = &rt_sched_class;
+#ifdef CONFIG_SCHED_CLASS_EXT
+	} else if (task_on_scx(p)) {
+		p->sched_class = &ext_sched_class;
+#endif
 	} else {
 		p->sched_class = &fair_sched_class;
 	}
@@ -6934,6 +6950,10 @@ void __setscheduler_prio(struct task_struct *p, int prio)
 		p->sched_class = &dl_sched_class;
 	else if (rt_prio(prio))
 		p->sched_class = &rt_sched_class;
+#ifdef CONFIG_SCHED_CLASS_EXT
+	else if (task_on_scx(p))
+		p->sched_class = &ext_sched_class;
+#endif
 	else
 		p->sched_class = &fair_sched_class;
 
@@ -8854,6 +8874,7 @@ SYSCALL_DEFINE1(sched_get_priority_max, int, policy)
 	case SCHED_NORMAL:
 	case SCHED_BATCH:
 	case SCHED_IDLE:
+	case SCHED_EXT:
 		ret = 0;
 		break;
 	}
@@ -8881,6 +8902,7 @@ SYSCALL_DEFINE1(sched_get_priority_min, int, policy)
 	case SCHED_NORMAL:
 	case SCHED_BATCH:
 	case SCHED_IDLE:
+	case SCHED_EXT:
 		ret = 0;
 	}
 	return ret;
@@ -9726,6 +9748,10 @@ void __init sched_init(void)
 	BUG_ON(!sched_class_above(&dl_sched_class, &rt_sched_class));
 	BUG_ON(!sched_class_above(&rt_sched_class, &fair_sched_class));
 	BUG_ON(!sched_class_above(&fair_sched_class, &idle_sched_class));
+#ifdef CONFIG_SCHED_CLASS_EXT
+	BUG_ON(!sched_class_above(&fair_sched_class, &ext_sched_class));
+	BUG_ON(!sched_class_above(&ext_sched_class, &idle_sched_class));
+#endif
 
 	wait_bit_init();
 
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 1637b65ba07a..814ed80b8ff6 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -338,6 +338,9 @@ static __init int sched_init_debug(void)
 
 	debugfs_create_file("debug", 0444, debugfs_sched, NULL, &sched_debug_fops);
 
+#ifdef CONFIG_SCHED_CLASS_EXT
+	debugfs_create_file("ext", 0444, debugfs_sched, NULL, &sched_ext_fops);
+#endif
 	return 0;
 }
 late_initcall(sched_init_debug);
@@ -1047,6 +1050,9 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 		P(dl.runtime);
 		P(dl.deadline);
 	}
+#ifdef CONFIG_SCHED_CLASS_EXT
+	__PS("ext.enabled", p->sched_class == &ext_sched_class);
+#endif
 #undef PN_SCHEDSTAT
 #undef P_SCHEDSTAT
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
new file mode 100644
index 000000000000..38786d36a356
--- /dev/null
+++ b/kernel/sched/ext.c
@@ -0,0 +1,2979 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
+ * Copyright (c) 2022 David Vernet <dvernet@meta.com>
+ */
+#define SCX_OP_IDX(op)		(offsetof(struct sched_ext_ops, op) / sizeof(void (*)(void)))
+
+enum scx_internal_consts {
+	SCX_NR_ONLINE_OPS	= SCX_OP_IDX(init),
+	SCX_DSP_DFL_MAX_BATCH	= 32,
+};
+
+enum scx_ops_enable_state {
+	SCX_OPS_PREPPING,
+	SCX_OPS_ENABLING,
+	SCX_OPS_ENABLED,
+	SCX_OPS_DISABLING,
+	SCX_OPS_DISABLED,
+};
+
+/*
+ * sched_ext_entity->ops_state
+ *
+ * Used to track the task ownership between the SCX core and the BPF scheduler.
+ * State transitions look as follows:
+ *
+ * NONE -> QUEUEING -> QUEUED -> DISPATCHING
+ *   ^              |                 |
+ *   |              v                 v
+ *   \-------------------------------/
+ *
+ * QUEUEING and DISPATCHING states can be waited upon. See wait_ops_state() call
+ * sites for explanations on the conditions being waited upon and why they are
+ * safe. Transitions out of them into NONE or QUEUED must store_release and the
+ * waiters should load_acquire.
+ *
+ * Tracking scx_ops_state enables sched_ext core to reliably determine whether
+ * any given task can be dispatched by the BPF scheduler at all times and thus
+ * relaxes the requirements on the BPF scheduler. This allows the BPF scheduler
+ * to try to dispatch any task anytime regardless of its state as the SCX core
+ * can safely reject invalid dispatches.
+ */
+enum scx_ops_state {
+	SCX_OPSS_NONE,		/* owned by the SCX core */
+	SCX_OPSS_QUEUEING,	/* in transit to the BPF scheduler */
+	SCX_OPSS_QUEUED,	/* owned by the BPF scheduler */
+	SCX_OPSS_DISPATCHING,	/* in transit back to the SCX core */
+
+	/*
+	 * QSEQ brands each QUEUED instance so that, when dispatch races
+	 * dequeue/requeue, the dispatcher can tell whether it still has a claim
+	 * on the task being dispatched.
+	 */
+	SCX_OPSS_QSEQ_SHIFT	= 2,
+	SCX_OPSS_STATE_MASK	= (1LLU << SCX_OPSS_QSEQ_SHIFT) - 1,
+	SCX_OPSS_QSEQ_MASK	= ~SCX_OPSS_STATE_MASK,
+};
+
+/*
+ * During exit, a task may schedule after losing its PIDs. When disabling the
+ * BPF scheduler, we need to be able to iterate tasks in every state to
+ * guarantee system safety. Maintain a dedicated task list which contains every
+ * task between its fork and eventual free.
+ */
+static DEFINE_SPINLOCK(scx_tasks_lock);
+static LIST_HEAD(scx_tasks);
+
+/* ops enable/disable */
+static struct kthread_worker *scx_ops_helper;
+static DEFINE_MUTEX(scx_ops_enable_mutex);
+DEFINE_STATIC_KEY_FALSE(__scx_ops_enabled);
+DEFINE_STATIC_PERCPU_RWSEM(scx_fork_rwsem);
+static atomic_t scx_ops_enable_state_var = ATOMIC_INIT(SCX_OPS_DISABLED);
+static struct sched_ext_ops scx_ops;
+static bool scx_warned_zero_slice;
+
+static DEFINE_STATIC_KEY_FALSE(scx_ops_enq_last);
+static DEFINE_STATIC_KEY_FALSE(scx_ops_enq_exiting);
+static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
+
+struct static_key_false scx_has_op[SCX_NR_ONLINE_OPS] =
+	{ [0 ... SCX_NR_ONLINE_OPS-1] = STATIC_KEY_FALSE_INIT };
+
+static atomic_t scx_exit_type = ATOMIC_INIT(SCX_EXIT_DONE);
+static struct scx_exit_info scx_exit_info;
+
+static atomic64_t scx_nr_rejected = ATOMIC64_INIT(0);
+
+/* idle tracking */
+#ifdef CONFIG_SMP
+#ifdef CONFIG_CPUMASK_OFFSTACK
+#define CL_ALIGNED_IF_ONSTACK
+#else
+#define CL_ALIGNED_IF_ONSTACK __cacheline_aligned_in_smp
+#endif
+
+static struct {
+	cpumask_var_t cpu;
+	cpumask_var_t smt;
+} idle_masks CL_ALIGNED_IF_ONSTACK;
+
+static bool __cacheline_aligned_in_smp scx_has_idle_cpus;
+#endif	/* CONFIG_SMP */
+
+/*
+ * Direct dispatch marker.
+ *
+ * Non-NULL values are used for direct dispatch from enqueue path. A valid
+ * pointer points to the task currently being enqueued. An ERR_PTR value is used
+ * to indicate that direct dispatch has already happened.
+ */
+static DEFINE_PER_CPU(struct task_struct *, direct_dispatch_task);
+
+/* dispatch queues */
+static struct scx_dispatch_q __cacheline_aligned_in_smp scx_dsq_global;
+
+static const struct rhashtable_params dsq_hash_params = {
+	.key_len		= 8,
+	.key_offset		= offsetof(struct scx_dispatch_q, id),
+	.head_offset		= offsetof(struct scx_dispatch_q, hash_node),
+};
+
+static struct rhashtable dsq_hash;
+static LLIST_HEAD(dsqs_to_free);
+
+/* dispatch buf */
+struct scx_dsp_buf_ent {
+	struct task_struct	*task;
+	u64			qseq;
+	u64			dsq_id;
+	u64			enq_flags;
+};
+
+static u32 scx_dsp_max_batch;
+static struct scx_dsp_buf_ent __percpu *scx_dsp_buf;
+
+struct scx_dsp_ctx {
+	struct rq		*rq;
+	struct rq_flags		*rf;
+	u32			buf_cursor;
+	u32			nr_tasks;
+};
+
+static DEFINE_PER_CPU(struct scx_dsp_ctx, scx_dsp_ctx);
+
+void scx_bpf_dispatch(struct task_struct *p, u64 dsq_id, u64 slice,
+		      u64 enq_flags);
+__printf(2, 3) static void scx_ops_error_type(enum scx_exit_type type,
+					      const char *fmt, ...);
+#define scx_ops_error(fmt, args...)						\
+	scx_ops_error_type(SCX_EXIT_ERROR, fmt, ##args)
+
+struct scx_task_iter {
+	struct sched_ext_entity		cursor;
+	struct task_struct		*locked;
+	struct rq			*rq;
+	struct rq_flags			rf;
+};
+
+#define SCX_HAS_OP(op)	static_branch_likely(&scx_has_op[SCX_OP_IDX(op)])
+
+/*
+ * scx_kf_mask enforcement. Some kfuncs can only be called from specific SCX
+ * ops. When invoking SCX ops, SCX_CALL_OP[_RET]() should be used to indicate
+ * the allowed kfuncs and those kfuncs should use scx_kf_allowed() to check
+ * whether it's running from an allowed context.
+ */
+static void scx_kf_allow(u32 mask)
+{
+	u32 allowed_nesters = 0;
+
+	/* INIT|SLEEPABLE can nest others but not themselves */
+	if (!(mask & (SCX_KF_INIT | SCX_KF_SLEEPABLE)))
+		allowed_nesters |= SCX_KF_INIT | SCX_KF_SLEEPABLE;
+
+	WARN_ONCE(current->scx.kf_mask & ~allowed_nesters,
+		  "invalid nesting current->scx.kf_mask=0x%x mask=0x%x allowed_nesters=0x%x\n",
+		  current->scx.kf_mask, mask, allowed_nesters);
+
+	current->scx.kf_mask |= mask;
+}
+
+static void scx_kf_disallow(u32 mask)
+{
+	current->scx.kf_mask &= ~mask;
+}
+
+#define SCX_CALL_OP(mask, op, args...)						\
+do {										\
+	scx_kf_allow(mask);							\
+	scx_ops.op(args);							\
+	scx_kf_disallow(mask);							\
+} while (0)
+
+#define SCX_CALL_OP_RET(mask, op, args...)					\
+({										\
+	__typeof__(scx_ops.op(args)) __ret;					\
+	scx_kf_allow(mask);							\
+	__ret = scx_ops.op(args);						\
+	scx_kf_disallow(mask);							\
+	__ret;									\
+})
+
+static bool scx_kf_allowed(u32 mask)
+{
+	if (unlikely(!(current->scx.kf_mask & mask))) {
+		scx_ops_error("kfunc with mask 0x%x called from an operation only allowing 0x%x",
+			      mask, current->scx.kf_mask);
+		return false;
+	}
+
+	if (unlikely((mask & SCX_KF_SLEEPABLE) && in_interrupt())) {
+		scx_ops_error("sleepable kfunc called from non-sleepable context");
+		return false;
+	}
+
+	return true;
+}
+
+/**
+ * scx_task_iter_init - Initialize a task iterator
+ * @iter: iterator to init
+ *
+ * Initialize @iter. Must be called with scx_tasks_lock held. Once initialized,
+ * @iter must eventually be exited with scx_task_iter_exit().
+ *
+ * scx_tasks_lock may be released between this and the first next() call or
+ * between any two next() calls. If scx_tasks_lock is released between two
+ * next() calls, the caller is responsible for ensuring that the task being
+ * iterated remains accessible either through RCU read lock or obtaining a
+ * reference count.
+ *
+ * All tasks which existed when the iteration started are guaranteed to be
+ * visited as long as they still exist.
+ */
+static void scx_task_iter_init(struct scx_task_iter *iter)
+{
+	lockdep_assert_held(&scx_tasks_lock);
+
+	iter->cursor = (struct sched_ext_entity){ .flags = SCX_TASK_CURSOR };
+	list_add(&iter->cursor.tasks_node, &scx_tasks);
+	iter->locked = NULL;
+}
+
+/**
+ * scx_task_iter_exit - Exit a task iterator
+ * @iter: iterator to exit
+ *
+ * Exit a previously initialized @iter. Must be called with scx_tasks_lock held.
+ * If the iterator holds a task's rq lock, that rq lock is released. See
+ * scx_task_iter_init() for details.
+ */
+static void scx_task_iter_exit(struct scx_task_iter *iter)
+{
+	struct list_head *cursor = &iter->cursor.tasks_node;
+
+	lockdep_assert_held(&scx_tasks_lock);
+
+	if (iter->locked) {
+		task_rq_unlock(iter->rq, iter->locked, &iter->rf);
+		iter->locked = NULL;
+	}
+
+	if (list_empty(cursor))
+		return;
+
+	list_del_init(cursor);
+}
+
+/**
+ * scx_task_iter_next - Next task
+ * @iter: iterator to walk
+ *
+ * Visit the next task. See scx_task_iter_init() for details.
+ */
+static struct task_struct *scx_task_iter_next(struct scx_task_iter *iter)
+{
+	struct list_head *cursor = &iter->cursor.tasks_node;
+	struct sched_ext_entity *pos;
+
+	lockdep_assert_held(&scx_tasks_lock);
+
+	list_for_each_entry(pos, cursor, tasks_node) {
+		if (&pos->tasks_node == &scx_tasks)
+			return NULL;
+		if (!(pos->flags & SCX_TASK_CURSOR)) {
+			list_move(cursor, &pos->tasks_node);
+			return container_of(pos, struct task_struct, scx);
+		}
+	}
+
+	/* can't happen, should always terminate at scx_tasks above */
+	BUG();
+}
+
+/**
+ * scx_task_iter_next_filtered - Next non-idle task
+ * @iter: iterator to walk
+ *
+ * Visit the next non-idle task. See scx_task_iter_init() for details.
+ */
+static struct task_struct *
+scx_task_iter_next_filtered(struct scx_task_iter *iter)
+{
+	struct task_struct *p;
+
+	while ((p = scx_task_iter_next(iter))) {
+		if (!is_idle_task(p))
+			return p;
+	}
+	return NULL;
+}
+
+/**
+ * scx_task_iter_next_filtered_locked - Next non-idle task with its rq locked
+ * @iter: iterator to walk
+ *
+ * Visit the next non-idle task with its rq lock held. See scx_task_iter_init()
+ * for details.
+ */
+static struct task_struct *
+scx_task_iter_next_filtered_locked(struct scx_task_iter *iter)
+{
+	struct task_struct *p;
+
+	if (iter->locked) {
+		task_rq_unlock(iter->rq, iter->locked, &iter->rf);
+		iter->locked = NULL;
+	}
+
+	p = scx_task_iter_next_filtered(iter);
+	if (!p)
+		return NULL;
+
+	iter->rq = task_rq_lock(p, &iter->rf);
+	iter->locked = p;
+	return p;
+}
+
+static enum scx_ops_enable_state scx_ops_enable_state(void)
+{
+	return atomic_read(&scx_ops_enable_state_var);
+}
+
+static enum scx_ops_enable_state
+scx_ops_set_enable_state(enum scx_ops_enable_state to)
+{
+	return atomic_xchg(&scx_ops_enable_state_var, to);
+}
+
+static bool scx_ops_tryset_enable_state(enum scx_ops_enable_state to,
+					enum scx_ops_enable_state from)
+{
+	int from_v = from;
+
+	return atomic_try_cmpxchg(&scx_ops_enable_state_var, &from_v, to);
+}
+
+static bool scx_ops_disabling(void)
+{
+	return unlikely(scx_ops_enable_state() == SCX_OPS_DISABLING);
+}
+
+/**
+ * wait_ops_state - Busy-wait the specified ops state to end
+ * @p: target task
+ * @opss: state to wait the end of
+ *
+ * Busy-wait for @p to transition out of @opss. This can only be used when the
+ * state part of @opss is %SCX_QUEUEING or %SCX_DISPATCHING. This function also
+ * has load_acquire semantics to ensure that the caller can see the updates made
+ * in the enqueueing and dispatching paths.
+ */
+static void wait_ops_state(struct task_struct *p, u64 opss)
+{
+	do {
+		cpu_relax();
+	} while (atomic64_read_acquire(&p->scx.ops_state) == opss);
+}
+
+/**
+ * ops_cpu_valid - Verify a cpu number
+ * @cpu: cpu number which came from a BPF ops
+ *
+ * @cpu is a cpu number which came from the BPF scheduler and can be any value.
+ * Verify that it is in range and one of the possible cpus.
+ */
+static bool ops_cpu_valid(s32 cpu)
+{
+	return likely(cpu >= 0 && cpu < nr_cpu_ids && cpu_possible(cpu));
+}
+
+/**
+ * ops_sanitize_err - Sanitize a -errno value
+ * @ops_name: operation to blame on failure
+ * @err: -errno value to sanitize
+ *
+ * Verify @err is a valid -errno. If not, trigger scx_ops_error() and return
+ * -%EPROTO. This is necessary because returning a rogue -errno up the chain can
+ * cause misbehaviors. For an example, a large negative return from
+ * ops.prep_enable() triggers an oops when passed up the call chain because the
+ * value fails IS_ERR() test after being encoded with ERR_PTR() and then is
+ * handled as a pointer.
+ */
+static int ops_sanitize_err(const char *ops_name, s32 err)
+{
+	if (err < 0 && err >= -MAX_ERRNO)
+		return err;
+
+	scx_ops_error("ops.%s() returned an invalid errno %d", ops_name, err);
+	return -EPROTO;
+}
+
+static void update_curr_scx(struct rq *rq)
+{
+	struct task_struct *curr = rq->curr;
+	u64 now = rq_clock_task(rq);
+	u64 delta_exec;
+
+	if (time_before_eq64(now, curr->se.exec_start))
+		return;
+
+	delta_exec = now - curr->se.exec_start;
+	curr->se.exec_start = now;
+	curr->se.sum_exec_runtime += delta_exec;
+	account_group_exec_runtime(curr, delta_exec);
+	cgroup_account_cputime(curr, delta_exec);
+
+	curr->scx.slice -= min(curr->scx.slice, delta_exec);
+}
+
+static void dispatch_enqueue(struct scx_dispatch_q *dsq, struct task_struct *p,
+			     u64 enq_flags)
+{
+	bool is_local = dsq->id == SCX_DSQ_LOCAL;
+
+	WARN_ON_ONCE(p->scx.dsq || !list_empty(&p->scx.dsq_node));
+
+	if (!is_local) {
+		raw_spin_lock(&dsq->lock);
+		if (unlikely(dsq->id == SCX_DSQ_INVALID)) {
+			scx_ops_error("attempting to dispatch to a destroyed dsq");
+			/* fall back to the global dsq */
+			raw_spin_unlock(&dsq->lock);
+			dsq = &scx_dsq_global;
+			raw_spin_lock(&dsq->lock);
+		}
+	}
+
+	if (enq_flags & SCX_ENQ_HEAD)
+		list_add(&p->scx.dsq_node, &dsq->fifo);
+	else
+		list_add_tail(&p->scx.dsq_node, &dsq->fifo);
+	dsq->nr++;
+	p->scx.dsq = dsq;
+
+	/*
+	 * We're transitioning out of QUEUEING or DISPATCHING. store_release to
+	 * match waiters' load_acquire.
+	 */
+	if (enq_flags & SCX_ENQ_CLEAR_OPSS)
+		atomic64_set_release(&p->scx.ops_state, SCX_OPSS_NONE);
+
+	if (is_local) {
+		struct rq *rq = container_of(dsq, struct rq, scx.local_dsq);
+
+		if (sched_class_above(&ext_sched_class, rq->curr->sched_class))
+			resched_curr(rq);
+	} else {
+		raw_spin_unlock(&dsq->lock);
+	}
+}
+
+static void dispatch_dequeue(struct scx_rq *scx_rq, struct task_struct *p)
+{
+	struct scx_dispatch_q *dsq = p->scx.dsq;
+	bool is_local = dsq == &scx_rq->local_dsq;
+
+	if (!dsq) {
+		WARN_ON_ONCE(!list_empty(&p->scx.dsq_node));
+		/*
+		 * When dispatching directly from the BPF scheduler to a local
+		 * DSQ, the task isn't associated with any DSQ but
+		 * @p->scx.holding_cpu may be set under the protection of
+		 * %SCX_OPSS_DISPATCHING.
+		 */
+		if (p->scx.holding_cpu >= 0)
+			p->scx.holding_cpu = -1;
+		return;
+	}
+
+	if (!is_local)
+		raw_spin_lock(&dsq->lock);
+
+	/*
+	 * Now that we hold @dsq->lock, @p->holding_cpu and @p->scx.dsq_node
+	 * can't change underneath us.
+	*/
+	if (p->scx.holding_cpu < 0) {
+		/* @p must still be on @dsq, dequeue */
+		WARN_ON_ONCE(list_empty(&p->scx.dsq_node));
+		list_del_init(&p->scx.dsq_node);
+		dsq->nr--;
+	} else {
+		/*
+		 * We're racing against dispatch_to_local_dsq() which already
+		 * removed @p from @dsq and set @p->scx.holding_cpu. Clear the
+		 * holding_cpu which tells dispatch_to_local_dsq() that it lost
+		 * the race.
+		 */
+		WARN_ON_ONCE(!list_empty(&p->scx.dsq_node));
+		p->scx.holding_cpu = -1;
+	}
+	p->scx.dsq = NULL;
+
+	if (!is_local)
+		raw_spin_unlock(&dsq->lock);
+}
+
+static struct scx_dispatch_q *find_non_local_dsq(u64 dsq_id)
+{
+	lockdep_assert(rcu_read_lock_any_held());
+
+	if (dsq_id == SCX_DSQ_GLOBAL)
+		return &scx_dsq_global;
+	else
+		return rhashtable_lookup_fast(&dsq_hash, &dsq_id,
+					      dsq_hash_params);
+}
+
+static struct scx_dispatch_q *find_dsq_for_dispatch(struct rq *rq, u64 dsq_id,
+						    struct task_struct *p)
+{
+	struct scx_dispatch_q *dsq;
+
+	if (dsq_id == SCX_DSQ_LOCAL)
+		return &rq->scx.local_dsq;
+
+	dsq = find_non_local_dsq(dsq_id);
+	if (unlikely(!dsq)) {
+		scx_ops_error("non-existent DSQ 0x%llx for %s[%d]",
+			      dsq_id, p->comm, p->pid);
+		return &scx_dsq_global;
+	}
+
+	return dsq;
+}
+
+static void direct_dispatch(struct task_struct *ddsp_task, struct task_struct *p,
+			    u64 dsq_id, u64 enq_flags)
+{
+	struct scx_dispatch_q *dsq;
+
+	/* @p must match the task which is being enqueued */
+	if (unlikely(p != ddsp_task)) {
+		if (IS_ERR(ddsp_task))
+			scx_ops_error("%s[%d] already direct-dispatched",
+				      p->comm, p->pid);
+		else
+			scx_ops_error("enqueueing %s[%d] but trying to direct-dispatch %s[%d]",
+				      ddsp_task->comm, ddsp_task->pid,
+				      p->comm, p->pid);
+		return;
+	}
+
+	/*
+	 * %SCX_DSQ_LOCAL_ON is not supported during direct dispatch because
+	 * dispatching to the local DSQ of a different CPU requires unlocking
+	 * the current rq which isn't allowed in the enqueue path. Use
+	 * ops.select_cpu() to be on the target CPU and then %SCX_DSQ_LOCAL.
+	 */
+	if (unlikely((dsq_id & SCX_DSQ_LOCAL_ON) == SCX_DSQ_LOCAL_ON)) {
+		scx_ops_error("SCX_DSQ_LOCAL_ON can't be used for direct-dispatch");
+		return;
+	}
+
+	dsq = find_dsq_for_dispatch(task_rq(p), dsq_id, p);
+	dispatch_enqueue(dsq, p, enq_flags | SCX_ENQ_CLEAR_OPSS);
+
+	/*
+	 * Mark that dispatch already happened by spoiling direct_dispatch_task
+	 * with a non-NULL value which can never match a valid task pointer.
+	 */
+	__this_cpu_write(direct_dispatch_task, ERR_PTR(-ESRCH));
+}
+
+static bool test_rq_online(struct rq *rq)
+{
+#ifdef CONFIG_SMP
+	return rq->online;
+#else
+	return true;
+#endif
+}
+
+static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
+			    int sticky_cpu)
+{
+	struct task_struct **ddsp_taskp;
+	u64 qseq;
+
+	WARN_ON_ONCE(!(p->scx.flags & SCX_TASK_QUEUED));
+
+	if (p->scx.flags & SCX_TASK_ENQ_LOCAL) {
+		enq_flags |= SCX_ENQ_LOCAL;
+		p->scx.flags &= ~SCX_TASK_ENQ_LOCAL;
+	}
+
+	/* rq migration */
+	if (sticky_cpu == cpu_of(rq))
+		goto local_norefill;
+
+	/*
+	 * If !rq->online, we already told the BPF scheduler that the CPU is
+	 * offline. We're just trying to on/offline the CPU. Don't bother the
+	 * BPF scheduler.
+	 */
+	if (unlikely(!test_rq_online(rq)))
+		goto local;
+
+	/* see %SCX_OPS_ENQ_EXITING */
+	if (!static_branch_unlikely(&scx_ops_enq_exiting) &&
+	    unlikely(p->flags & PF_EXITING))
+		goto local;
+
+	/* see %SCX_OPS_ENQ_LAST */
+	if (!static_branch_unlikely(&scx_ops_enq_last) &&
+	    (enq_flags & SCX_ENQ_LAST))
+		goto local;
+
+	if (!SCX_HAS_OP(enqueue)) {
+		if (enq_flags & SCX_ENQ_LOCAL)
+			goto local;
+		else
+			goto global;
+	}
+
+	/* DSQ bypass didn't trigger, enqueue on the BPF scheduler */
+	qseq = rq->scx.ops_qseq++ << SCX_OPSS_QSEQ_SHIFT;
+
+	WARN_ON_ONCE(atomic64_read(&p->scx.ops_state) != SCX_OPSS_NONE);
+	atomic64_set(&p->scx.ops_state, SCX_OPSS_QUEUEING | qseq);
+
+	ddsp_taskp = this_cpu_ptr(&direct_dispatch_task);
+	WARN_ON_ONCE(*ddsp_taskp);
+	*ddsp_taskp = p;
+
+	SCX_CALL_OP(SCX_KF_ENQUEUE_DISPATCH, enqueue, p, enq_flags);
+
+	/*
+	 * If not directly dispatched, QUEUEING isn't clear yet and dispatch or
+	 * dequeue may be waiting. The store_release matches their load_acquire.
+	 */
+	if (*ddsp_taskp == p)
+		atomic64_set_release(&p->scx.ops_state, SCX_OPSS_QUEUED | qseq);
+	*ddsp_taskp = NULL;
+	return;
+
+local:
+	p->scx.slice = SCX_SLICE_DFL;
+local_norefill:
+	dispatch_enqueue(&rq->scx.local_dsq, p, enq_flags);
+	return;
+
+global:
+	p->scx.slice = SCX_SLICE_DFL;
+	dispatch_enqueue(&scx_dsq_global, p, enq_flags);
+}
+
+static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags)
+{
+	int sticky_cpu = p->scx.sticky_cpu;
+
+	if (sticky_cpu >= 0)
+		p->scx.sticky_cpu = -1;
+
+	/*
+	 * Restoring a running task will be immediately followed by
+	 * set_next_task_scx() which expects the task to not be on the BPF
+	 * scheduler as tasks can only start running through local DSQs. Force
+	 * direct-dispatch into the local DSQ by setting the sticky_cpu.
+	 */
+	if (unlikely(enq_flags & ENQUEUE_RESTORE) && task_current(rq, p))
+		sticky_cpu = cpu_of(rq);
+
+	if (p->scx.flags & SCX_TASK_QUEUED)
+		return;
+
+	p->scx.flags |= SCX_TASK_QUEUED;
+	rq->scx.nr_running++;
+	add_nr_running(rq, 1);
+
+	do_enqueue_task(rq, p, enq_flags, sticky_cpu);
+}
+
+static void ops_dequeue(struct task_struct *p, u64 deq_flags)
+{
+	u64 opss;
+
+	/* acquire ensures that we see the preceding updates on QUEUED */
+	opss = atomic64_read_acquire(&p->scx.ops_state);
+
+	switch (opss & SCX_OPSS_STATE_MASK) {
+	case SCX_OPSS_NONE:
+		break;
+	case SCX_OPSS_QUEUEING:
+		/*
+		 * QUEUEING is started and finished while holding @p's rq lock.
+		 * As we're holding the rq lock now, we shouldn't see QUEUEING.
+		 */
+		BUG();
+	case SCX_OPSS_QUEUED:
+		if (SCX_HAS_OP(dequeue))
+			scx_ops.dequeue(p, deq_flags);
+
+		if (atomic64_try_cmpxchg(&p->scx.ops_state, &opss,
+					 SCX_OPSS_NONE))
+			break;
+		fallthrough;
+	case SCX_OPSS_DISPATCHING:
+		/*
+		 * If @p is being dispatched from the BPF scheduler to a DSQ,
+		 * wait for the transfer to complete so that @p doesn't get
+		 * added to its DSQ after dequeueing is complete.
+		 *
+		 * As we're waiting on DISPATCHING with the rq locked, the
+		 * dispatching side shouldn't try to lock the rq while
+		 * DISPATCHING is set. See dispatch_to_local_dsq().
+		 *
+		 * DISPATCHING shouldn't have qseq set and control can reach
+		 * here with NONE @opss from the above QUEUED case block.
+		 * Explicitly wait on %SCX_OPSS_DISPATCHING instead of @opss.
+		 */
+		wait_ops_state(p, SCX_OPSS_DISPATCHING);
+		BUG_ON(atomic64_read(&p->scx.ops_state) != SCX_OPSS_NONE);
+		break;
+	}
+}
+
+static void dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags)
+{
+	struct scx_rq *scx_rq = &rq->scx;
+
+	if (!(p->scx.flags & SCX_TASK_QUEUED))
+		return;
+
+	ops_dequeue(p, deq_flags);
+
+	if (deq_flags & SCX_DEQ_SLEEP)
+		p->scx.flags |= SCX_TASK_DEQD_FOR_SLEEP;
+	else
+		p->scx.flags &= ~SCX_TASK_DEQD_FOR_SLEEP;
+
+	p->scx.flags &= ~SCX_TASK_QUEUED;
+	scx_rq->nr_running--;
+	sub_nr_running(rq, 1);
+
+	dispatch_dequeue(scx_rq, p);
+}
+
+static void yield_task_scx(struct rq *rq)
+{
+	struct task_struct *p = rq->curr;
+
+	if (SCX_HAS_OP(yield))
+		scx_ops.yield(p, NULL);
+	else
+		p->scx.slice = 0;
+}
+
+static bool yield_to_task_scx(struct rq *rq, struct task_struct *to)
+{
+	struct task_struct *from = rq->curr;
+
+	if (SCX_HAS_OP(yield))
+		return scx_ops.yield(from, to);
+	else
+		return false;
+}
+
+#ifdef CONFIG_SMP
+/**
+ * move_task_to_local_dsq - Move a task from a different rq to a local DSQ
+ * @rq: rq to move the task into, currently locked
+ * @p: task to move
+ *
+ * Move @p which is currently on a different rq to @rq's local DSQ. The caller
+ * must:
+ *
+ * 1. Start with exclusive access to @p either through its DSQ lock or
+ *    %SCX_OPSS_DISPATCHING flag.
+ *
+ * 2. Set @p->scx.holding_cpu to raw_smp_processor_id().
+ *
+ * 3. Remember task_rq(@p). Release the exclusive access so that we don't
+ *    deadlock with dequeue.
+ *
+ * 4. Lock @rq and the task_rq from #3.
+ *
+ * 5. Call this function.
+ *
+ * Returns %true if @p was successfully moved. %false after racing dequeue and
+ * losing.
+ */
+static bool move_task_to_local_dsq(struct rq *rq, struct task_struct *p)
+{
+	struct rq *task_rq;
+
+	lockdep_assert_rq_held(rq);
+
+	/*
+	 * If dequeue got to @p while we were trying to lock both rq's, it'd
+	 * have cleared @p->scx.holding_cpu to -1. While other cpus may have
+	 * updated it to different values afterwards, as this operation can't be
+	 * preempted or recurse, @p->scx.holding_cpu can never become
+	 * raw_smp_processor_id() again before we're done. Thus, we can tell
+	 * whether we lost to dequeue by testing whether @p->scx.holding_cpu is
+	 * still raw_smp_processor_id().
+	 *
+	 * See dispatch_dequeue() for the counterpart.
+	 */
+	if (unlikely(p->scx.holding_cpu != raw_smp_processor_id()))
+		return false;
+
+	/* @p->rq couldn't have changed if we're still the holding cpu */
+	task_rq = task_rq(p);
+	lockdep_assert_rq_held(task_rq);
+
+	WARN_ON_ONCE(!cpumask_test_cpu(cpu_of(rq), p->cpus_ptr));
+	deactivate_task(task_rq, p, 0);
+	set_task_cpu(p, cpu_of(rq));
+	p->scx.sticky_cpu = cpu_of(rq);
+	activate_task(rq, p, 0);
+
+	return true;
+}
+
+/**
+ * dispatch_to_local_dsq_lock - Ensure source and desitnation rq's are locked
+ * @rq: current rq which is locked
+ * @rf: rq_flags to use when unlocking @rq
+ * @src_rq: rq to move task from
+ * @dst_rq: rq to move task to
+ *
+ * We're holding @rq lock and trying to dispatch a task from @src_rq to
+ * @dst_rq's local DSQ and thus need to lock both @src_rq and @dst_rq. Whether
+ * @rq stays locked isn't important as long as the state is restored after
+ * dispatch_to_local_dsq_unlock().
+ */
+static void dispatch_to_local_dsq_lock(struct rq *rq, struct rq_flags *rf,
+				       struct rq *src_rq, struct rq *dst_rq)
+{
+	rq_unpin_lock(rq, rf);
+
+	if (src_rq == dst_rq) {
+		raw_spin_rq_unlock(rq);
+		raw_spin_rq_lock(dst_rq);
+	} else if (rq == src_rq) {
+		double_lock_balance(rq, dst_rq);
+		rq_repin_lock(rq, rf);
+	} else if (rq == dst_rq) {
+		double_lock_balance(rq, src_rq);
+		rq_repin_lock(rq, rf);
+	} else {
+		raw_spin_rq_unlock(rq);
+		double_rq_lock(src_rq, dst_rq);
+	}
+}
+
+/**
+ * dispatch_to_local_dsq_unlock - Undo dispatch_to_local_dsq_lock()
+ * @rq: current rq which is locked
+ * @rf: rq_flags to use when unlocking @rq
+ * @src_rq: rq to move task from
+ * @dst_rq: rq to move task to
+ *
+ * Unlock @src_rq and @dst_rq and ensure that @rq is locked on return.
+ */
+static void dispatch_to_local_dsq_unlock(struct rq *rq, struct rq_flags *rf,
+					 struct rq *src_rq, struct rq *dst_rq)
+{
+	if (src_rq == dst_rq) {
+		raw_spin_rq_unlock(dst_rq);
+		raw_spin_rq_lock(rq);
+		rq_repin_lock(rq, rf);
+	} else if (rq == src_rq) {
+		double_unlock_balance(rq, dst_rq);
+	} else if (rq == dst_rq) {
+		double_unlock_balance(rq, src_rq);
+	} else {
+		double_rq_unlock(src_rq, dst_rq);
+		raw_spin_rq_lock(rq);
+		rq_repin_lock(rq, rf);
+	}
+}
+#endif	/* CONFIG_SMP */
+
+
+static bool consume_dispatch_q(struct rq *rq, struct rq_flags *rf,
+			       struct scx_dispatch_q *dsq)
+{
+	struct scx_rq *scx_rq = &rq->scx;
+	struct task_struct *p;
+	struct rq *task_rq;
+	bool moved = false;
+retry:
+	if (list_empty(&dsq->fifo))
+		return false;
+
+	raw_spin_lock(&dsq->lock);
+	list_for_each_entry(p, &dsq->fifo, scx.dsq_node) {
+		task_rq = task_rq(p);
+		if (rq == task_rq)
+			goto this_rq;
+		if (likely(test_rq_online(rq)) && !is_migration_disabled(p) &&
+		    cpumask_test_cpu(cpu_of(rq), p->cpus_ptr))
+			goto remote_rq;
+	}
+	raw_spin_unlock(&dsq->lock);
+	return false;
+
+this_rq:
+	/* @dsq is locked and @p is on this rq */
+	WARN_ON_ONCE(p->scx.holding_cpu >= 0);
+	list_move_tail(&p->scx.dsq_node, &scx_rq->local_dsq.fifo);
+	dsq->nr--;
+	scx_rq->local_dsq.nr++;
+	p->scx.dsq = &scx_rq->local_dsq;
+	raw_spin_unlock(&dsq->lock);
+	return true;
+
+remote_rq:
+#ifdef CONFIG_SMP
+	/*
+	 * @dsq is locked and @p is on a remote rq. @p is currently protected by
+	 * @dsq->lock. We want to pull @p to @rq but may deadlock if we grab
+	 * @task_rq while holding @dsq and @rq locks. As dequeue can't drop the
+	 * rq lock or fail, do a little dancing from our side. See
+	 * move_task_to_local_dsq().
+	 */
+	WARN_ON_ONCE(p->scx.holding_cpu >= 0);
+	list_del_init(&p->scx.dsq_node);
+	dsq->nr--;
+	p->scx.holding_cpu = raw_smp_processor_id();
+	raw_spin_unlock(&dsq->lock);
+
+	rq_unpin_lock(rq, rf);
+	double_lock_balance(rq, task_rq);
+	rq_repin_lock(rq, rf);
+
+	moved = move_task_to_local_dsq(rq, p);
+
+	double_unlock_balance(rq, task_rq);
+#endif /* CONFIG_SMP */
+	if (likely(moved))
+		return true;
+	goto retry;
+}
+
+enum dispatch_to_local_dsq_ret {
+	DTL_DISPATCHED,		/* successfully dispatched */
+	DTL_LOST,		/* lost race to dequeue */
+	DTL_NOT_LOCAL,		/* destination is not a local DSQ */
+	DTL_INVALID,		/* invalid local dsq_id */
+};
+
+/**
+ * dispatch_to_local_dsq - Dispatch a task to a local dsq
+ * @rq: current rq which is locked
+ * @rf: rq_flags to use when unlocking @rq
+ * @dsq_id: destination dsq ID
+ * @p: task to dispatch
+ * @enq_flags: %SCX_ENQ_*
+ *
+ * We're holding @rq lock and want to dispatch @p to the local DSQ identified by
+ * @dsq_id. This function performs all the synchronization dancing needed
+ * because local DSQs are protected with rq locks.
+ *
+ * The caller must have exclusive ownership of @p (e.g. through
+ * %SCX_OPSS_DISPATCHING).
+ */
+static enum dispatch_to_local_dsq_ret
+dispatch_to_local_dsq(struct rq *rq, struct rq_flags *rf, u64 dsq_id,
+		      struct task_struct *p, u64 enq_flags)
+{
+	struct rq *src_rq = task_rq(p);
+	struct rq *dst_rq;
+
+	/*
+	 * We're synchronized against dequeue through DISPATCHING. As @p can't
+	 * be dequeued, its task_rq and cpus_allowed are stable too.
+	 */
+	if (dsq_id == SCX_DSQ_LOCAL) {
+		dst_rq = rq;
+	} else if ((dsq_id & SCX_DSQ_LOCAL_ON) == SCX_DSQ_LOCAL_ON) {
+		s32 cpu = dsq_id & SCX_DSQ_LOCAL_CPU_MASK;
+
+		if (!ops_cpu_valid(cpu)) {
+			scx_ops_error("invalid cpu %d in SCX_DSQ_LOCAL_ON verdict for %s[%d]",
+				      cpu, p->comm, p->pid);
+			return DTL_INVALID;
+		}
+		dst_rq = cpu_rq(cpu);
+	} else {
+		return DTL_NOT_LOCAL;
+	}
+
+	/* if dispatching to @rq that @p is already on, no lock dancing needed */
+	if (rq == src_rq && rq == dst_rq) {
+		dispatch_enqueue(&dst_rq->scx.local_dsq, p,
+				 enq_flags | SCX_ENQ_CLEAR_OPSS);
+		return DTL_DISPATCHED;
+	}
+
+#ifdef CONFIG_SMP
+	if (cpumask_test_cpu(cpu_of(dst_rq), p->cpus_ptr)) {
+		struct rq *locked_dst_rq = dst_rq;
+		bool dsp;
+
+		/*
+		 * @p is on a possibly remote @src_rq which we need to lock to
+		 * move the task. If dequeue is in progress, it'd be locking
+		 * @src_rq and waiting on DISPATCHING, so we can't grab @src_rq
+		 * lock while holding DISPATCHING.
+		 *
+		 * As DISPATCHING guarantees that @p is wholly ours, we can
+		 * pretend that we're moving from a DSQ and use the same
+		 * mechanism - mark the task under transfer with holding_cpu,
+		 * release DISPATCHING and then follow the same protocol.
+		 */
+		p->scx.holding_cpu = raw_smp_processor_id();
+
+		/* store_release ensures that dequeue sees the above */
+		atomic64_set_release(&p->scx.ops_state, SCX_OPSS_NONE);
+
+		dispatch_to_local_dsq_lock(rq, rf, src_rq, locked_dst_rq);
+
+		/*
+		 * We don't require the BPF scheduler to avoid dispatching to
+		 * offline CPUs mostly for convenience but also because CPUs can
+		 * go offline between scx_bpf_dispatch() calls and here. If @p
+		 * is destined to an offline CPU, queue it on its current CPU
+		 * instead, which should always be safe. As this is an allowed
+		 * behavior, don't trigger an ops error.
+		 */
+		if (unlikely(!test_rq_online(dst_rq)))
+			dst_rq = src_rq;
+
+		if (src_rq == dst_rq) {
+			/*
+			 * As @p is staying on the same rq, there's no need to
+			 * go through the full deactivate/activate cycle.
+			 * Optimize by abbreviating the operations in
+			 * move_task_to_local_dsq().
+			 */
+			dsp = p->scx.holding_cpu == raw_smp_processor_id();
+			if (likely(dsp)) {
+				p->scx.holding_cpu = -1;
+				dispatch_enqueue(&dst_rq->scx.local_dsq, p,
+						 enq_flags);
+			}
+		} else {
+			dsp = move_task_to_local_dsq(dst_rq, p);
+		}
+
+		/* if the destination CPU is idle, wake it up */
+		if (dsp && p->sched_class > dst_rq->curr->sched_class)
+			resched_curr(dst_rq);
+
+		dispatch_to_local_dsq_unlock(rq, rf, src_rq, locked_dst_rq);
+
+		return dsp ? DTL_DISPATCHED : DTL_LOST;
+	}
+#endif /* CONFIG_SMP */
+
+	scx_ops_error("SCX_DSQ_LOCAL[_ON] verdict target cpu %d not allowed for %s[%d]",
+		      cpu_of(dst_rq), p->comm, p->pid);
+	return DTL_INVALID;
+}
+
+/**
+ * finish_dispatch - Asynchronously finish dispatching a task
+ * @rq: current rq which is locked
+ * @rf: rq_flags to use when unlocking @rq
+ * @p: task to finish dispatching
+ * @qseq_at_dispatch: qseq when @p started getting dispatched
+ * @dsq_id: destination DSQ ID
+ * @enq_flags: %SCX_ENQ_*
+ *
+ * Dispatching to local DSQs may need to wait for queueing to complete or
+ * require rq lock dancing. As we don't wanna do either while inside
+ * ops.dispatch() to avoid locking order inversion, we split dispatching into
+ * two parts. scx_bpf_dispatch() which is called by ops.dispatch() records the
+ * task and its qseq. Once ops.dispatch() returns, this function is called to
+ * finish up.
+ *
+ * There is no guarantee that @p is still valid for dispatching or even that it
+ * was valid in the first place. Make sure that the task is still owned by the
+ * BPF scheduler and claim the ownership before dispatching.
+ */
+static void finish_dispatch(struct rq *rq, struct rq_flags *rf,
+			    struct task_struct *p, u64 qseq_at_dispatch,
+			    u64 dsq_id, u64 enq_flags)
+{
+	struct scx_dispatch_q *dsq;
+	u64 opss;
+
+retry:
+	/*
+	 * No need for _acquire here. @p is accessed only after a successful
+	 * try_cmpxchg to DISPATCHING.
+	 */
+	opss = atomic64_read(&p->scx.ops_state);
+
+	switch (opss & SCX_OPSS_STATE_MASK) {
+	case SCX_OPSS_DISPATCHING:
+	case SCX_OPSS_NONE:
+		/* someone else already got to it */
+		return;
+	case SCX_OPSS_QUEUED:
+		/*
+		 * If qseq doesn't match, @p has gone through at least one
+		 * dispatch/dequeue and re-enqueue cycle between
+		 * scx_bpf_dispatch() and here and we have no claim on it.
+		 */
+		if ((opss & SCX_OPSS_QSEQ_MASK) != qseq_at_dispatch)
+			return;
+
+		/*
+		 * While we know @p is accessible, we don't yet have a claim on
+		 * it - the BPF scheduler is allowed to dispatch tasks
+		 * spuriously and there can be a racing dequeue attempt. Let's
+		 * claim @p by atomically transitioning it from QUEUED to
+		 * DISPATCHING.
+		 */
+		if (likely(atomic64_try_cmpxchg(&p->scx.ops_state, &opss,
+						SCX_OPSS_DISPATCHING)))
+			break;
+		goto retry;
+	case SCX_OPSS_QUEUEING:
+		/*
+		 * do_enqueue_task() is in the process of transferring the task
+		 * to the BPF scheduler while holding @p's rq lock. As we aren't
+		 * holding any kernel or BPF resource that the enqueue path may
+		 * depend upon, it's safe to wait.
+		 */
+		wait_ops_state(p, opss);
+		goto retry;
+	}
+
+	BUG_ON(!(p->scx.flags & SCX_TASK_QUEUED));
+
+	switch (dispatch_to_local_dsq(rq, rf, dsq_id, p, enq_flags)) {
+	case DTL_DISPATCHED:
+		break;
+	case DTL_LOST:
+		break;
+	case DTL_INVALID:
+		dsq_id = SCX_DSQ_GLOBAL;
+		fallthrough;
+	case DTL_NOT_LOCAL:
+		dsq = find_dsq_for_dispatch(cpu_rq(raw_smp_processor_id()),
+					    dsq_id, p);
+		dispatch_enqueue(dsq, p, enq_flags | SCX_ENQ_CLEAR_OPSS);
+		break;
+	}
+}
+
+static void flush_dispatch_buf(struct rq *rq, struct rq_flags *rf)
+{
+	struct scx_dsp_ctx *dspc = this_cpu_ptr(&scx_dsp_ctx);
+	u32 u;
+
+	for (u = 0; u < dspc->buf_cursor; u++) {
+		struct scx_dsp_buf_ent *ent = &this_cpu_ptr(scx_dsp_buf)[u];
+
+		finish_dispatch(rq, rf, ent->task, ent->qseq, ent->dsq_id,
+				ent->enq_flags);
+	}
+
+	dspc->nr_tasks += dspc->buf_cursor;
+	dspc->buf_cursor = 0;
+}
+
+static int balance_scx(struct rq *rq, struct task_struct *prev,
+		       struct rq_flags *rf)
+{
+	struct scx_rq *scx_rq = &rq->scx;
+	struct scx_dsp_ctx *dspc = this_cpu_ptr(&scx_dsp_ctx);
+	bool prev_on_scx = prev->sched_class == &ext_sched_class;
+
+	lockdep_assert_rq_held(rq);
+
+	if (prev_on_scx) {
+		WARN_ON_ONCE(prev->scx.flags & SCX_TASK_BAL_KEEP);
+		update_curr_scx(rq);
+
+		/*
+		 * If @prev is runnable & has slice left, it has priority and
+		 * fetching more just increases latency for the fetched tasks.
+		 * Tell put_prev_task_scx() to put @prev on local_dsq.
+		 *
+		 * See scx_ops_disable_workfn() for the explanation on the
+		 * disabling() test.
+		 */
+		if ((prev->scx.flags & SCX_TASK_QUEUED) &&
+		    prev->scx.slice && !scx_ops_disabling()) {
+			prev->scx.flags |= SCX_TASK_BAL_KEEP;
+			return 1;
+		}
+	}
+
+	/* if there already are tasks to run, nothing to do */
+	if (scx_rq->local_dsq.nr)
+		return 1;
+
+	if (consume_dispatch_q(rq, rf, &scx_dsq_global))
+		return 1;
+
+	if (!SCX_HAS_OP(dispatch))
+		return 0;
+
+	dspc->rq = rq;
+	dspc->rf = rf;
+
+	/*
+	 * The dispatch loop. Because flush_dispatch_buf() may drop the rq lock,
+	 * the local DSQ might still end up empty after a successful
+	 * ops.dispatch(). If the local DSQ is empty even after ops.dispatch()
+	 * produced some tasks, retry. The BPF scheduler may depend on this
+	 * looping behavior to simplify its implementation.
+	 */
+	do {
+		dspc->nr_tasks = 0;
+
+		SCX_CALL_OP(SCX_KF_ENQUEUE_DISPATCH | SCX_KF_DISPATCH,
+			    dispatch, cpu_of(rq), prev_on_scx ? prev : NULL);
+
+		flush_dispatch_buf(rq, rf);
+
+		if (scx_rq->local_dsq.nr)
+			return 1;
+		if (consume_dispatch_q(rq, rf, &scx_dsq_global))
+			return 1;
+	} while (dspc->nr_tasks);
+
+	return 0;
+}
+
+static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
+{
+	if (p->scx.flags & SCX_TASK_QUEUED) {
+		WARN_ON_ONCE(atomic64_read(&p->scx.ops_state) != SCX_OPSS_NONE);
+		dispatch_dequeue(&rq->scx, p);
+	}
+
+	p->se.exec_start = rq_clock_task(rq);
+}
+
+static void put_prev_task_scx(struct rq *rq, struct task_struct *p)
+{
+#ifndef CONFIG_SMP
+	/*
+	 * UP workaround.
+	 *
+	 * Because SCX may transfer tasks across CPUs during dispatch, dispatch
+	 * is performed from its balance operation which isn't called in UP.
+	 * Let's work around by calling it from the operations which come right
+	 * after.
+	 *
+	 * 1. If the prev task is on SCX, pick_next_task() calls
+	 *    .put_prev_task() right after. As .put_prev_task() is also called
+	 *    from other places, we need to distinguish the calls which can be
+	 *    done by looking at the previous task's state - if still queued or
+	 *    dequeued with %SCX_DEQ_SLEEP, the caller must be pick_next_task().
+	 *    This case is handled here.
+	 *
+	 * 2. If the prev task is not on SCX, the first following call into SCX
+	 *    will be .pick_next_task(), which is covered by calling
+	 *    balance_scx() from pick_next_task_scx().
+	 *
+	 * Note that we can't merge the first case into the second as
+	 * balance_scx() must be called before the previous SCX task goes
+	 * through put_prev_task_scx().
+	 *
+	 * As UP doesn't transfer tasks around, balance_scx() doesn't need @rf.
+	 * Pass in %NULL.
+	 */
+	if (p->scx.flags & (SCX_TASK_QUEUED | SCX_TASK_DEQD_FOR_SLEEP))
+		balance_scx(rq, p, NULL);
+#endif
+
+	update_curr_scx(rq);
+
+	/*
+	 * If we're being called from put_prev_task_balance(), balance_scx() may
+	 * have decided that @p should keep running.
+	 */
+	if (p->scx.flags & SCX_TASK_BAL_KEEP) {
+		p->scx.flags &= ~SCX_TASK_BAL_KEEP;
+		dispatch_enqueue(&rq->scx.local_dsq, p, SCX_ENQ_HEAD);
+		return;
+	}
+
+	if (p->scx.flags & SCX_TASK_QUEUED) {
+		/*
+		 * If @p has slice left and balance_scx() didn't tag it for
+		 * keeping, @p is getting preempted by a higher priority
+		 * scheduler class. Leave it at the head of the local DSQ.
+		 */
+		if (p->scx.slice && !scx_ops_disabling()) {
+			dispatch_enqueue(&rq->scx.local_dsq, p, SCX_ENQ_HEAD);
+			return;
+		}
+
+		/*
+		 * If we're in the pick_next_task path, balance_scx() should
+		 * have already populated the local DSQ if there are any other
+		 * available tasks. If empty, tell ops.enqueue() that @p is the
+		 * only one available for this cpu. ops.enqueue() should put it
+		 * on the local DSQ so that the subsequent pick_next_task_scx()
+		 * can find the task unless it wants to trigger a separate
+		 * follow-up scheduling event.
+		 */
+		if (list_empty(&rq->scx.local_dsq.fifo))
+			do_enqueue_task(rq, p, SCX_ENQ_LAST | SCX_ENQ_LOCAL, -1);
+		else
+			do_enqueue_task(rq, p, 0, -1);
+	}
+}
+
+static struct task_struct *first_local_task(struct rq *rq)
+{
+	return list_first_entry_or_null(&rq->scx.local_dsq.fifo,
+					struct task_struct, scx.dsq_node);
+}
+
+static struct task_struct *pick_next_task_scx(struct rq *rq)
+{
+	struct task_struct *p;
+
+#ifndef CONFIG_SMP
+	/* UP workaround - see the comment at the head of put_prev_task_scx() */
+	if (unlikely(rq->curr->sched_class != &ext_sched_class))
+		balance_scx(rq, rq->curr, NULL);
+#endif
+
+	p = first_local_task(rq);
+	if (!p)
+		return NULL;
+
+	if (unlikely(!p->scx.slice)) {
+		if (!scx_ops_disabling() && !scx_warned_zero_slice) {
+			printk_deferred(KERN_WARNING "sched_ext: %s[%d] has zero slice in pick_next_task_scx()\n",
+					p->comm, p->pid);
+			scx_warned_zero_slice = true;
+		}
+		p->scx.slice = SCX_SLICE_DFL;
+	}
+
+	set_next_task_scx(rq, p, true);
+
+	return p;
+}
+
+#ifdef CONFIG_SMP
+
+static bool test_and_clear_cpu_idle(int cpu)
+{
+	if (cpumask_test_and_clear_cpu(cpu, idle_masks.cpu)) {
+		if (cpumask_empty(idle_masks.cpu))
+			scx_has_idle_cpus = false;
+		return true;
+	} else {
+		return false;
+	}
+}
+
+static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed)
+{
+	int cpu;
+
+	do {
+		cpu = cpumask_any_and_distribute(idle_masks.smt, cpus_allowed);
+		if (cpu < nr_cpu_ids) {
+			const struct cpumask *sbm = topology_sibling_cpumask(cpu);
+
+			/*
+			 * If offline, @cpu is not its own sibling and we can
+			 * get caught in an infinite loop as @cpu is never
+			 * cleared from idle_masks.smt. Clear @cpu directly in
+			 * such cases.
+			 */
+			if (likely(cpumask_test_cpu(cpu, sbm)))
+				cpumask_andnot(idle_masks.smt, idle_masks.smt, sbm);
+			else
+				cpumask_andnot(idle_masks.smt, idle_masks.smt, cpumask_of(cpu));
+		} else {
+			cpu = cpumask_any_and_distribute(idle_masks.cpu, cpus_allowed);
+			if (cpu >= nr_cpu_ids)
+				return -EBUSY;
+		}
+	} while (!test_and_clear_cpu_idle(cpu));
+
+	return cpu;
+}
+
+static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags)
+{
+	s32 cpu;
+
+	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
+		scx_ops_error("built-in idle tracking is disabled");
+		return prev_cpu;
+	}
+
+	/*
+	 * If WAKE_SYNC and the machine isn't fully saturated, wake up @p to the
+	 * local DSQ of the waker.
+	 */
+	if ((wake_flags & SCX_WAKE_SYNC) && p->nr_cpus_allowed > 1 &&
+	    scx_has_idle_cpus && !(current->flags & PF_EXITING)) {
+		cpu = smp_processor_id();
+		if (cpumask_test_cpu(cpu, p->cpus_ptr)) {
+			p->scx.flags |= SCX_TASK_ENQ_LOCAL;
+			return cpu;
+		}
+	}
+
+	/* if the previous CPU is idle, dispatch directly to it */
+	if (test_and_clear_cpu_idle(prev_cpu)) {
+		p->scx.flags |= SCX_TASK_ENQ_LOCAL;
+		return prev_cpu;
+	}
+
+	if (p->nr_cpus_allowed == 1)
+		return prev_cpu;
+
+	cpu = scx_pick_idle_cpu(p->cpus_ptr);
+	if (cpu >= 0) {
+		p->scx.flags |= SCX_TASK_ENQ_LOCAL;
+		return cpu;
+	}
+
+	return prev_cpu;
+}
+
+static int select_task_rq_scx(struct task_struct *p, int prev_cpu, int wake_flags)
+{
+	if (SCX_HAS_OP(select_cpu)) {
+		s32 cpu;
+
+		cpu = scx_ops.select_cpu(p, prev_cpu, wake_flags);
+		if (ops_cpu_valid(cpu)) {
+			return cpu;
+		} else {
+			scx_ops_error("select_cpu returned invalid cpu %d", cpu);
+			return prev_cpu;
+		}
+	} else {
+		return scx_select_cpu_dfl(p, prev_cpu, wake_flags);
+	}
+}
+
+static void set_cpus_allowed_scx(struct task_struct *p,
+				 struct affinity_context *ac)
+{
+	set_cpus_allowed_common(p, ac);
+
+	/*
+	 * The effective cpumask is stored in @p->cpus_ptr which may temporarily
+	 * differ from the configured one in @p->cpus_mask. Always tell the bpf
+	 * scheduler the effective one.
+	 *
+	 * Fine-grained memory write control is enforced by BPF making the const
+	 * designation pointless. Cast it away when calling the operation.
+	 */
+	if (SCX_HAS_OP(set_cpumask))
+		scx_ops.set_cpumask(p, (struct cpumask *)p->cpus_ptr);
+}
+
+static void reset_idle_masks(void)
+{
+	/* consider all cpus idle, should converge to the actual state quickly */
+	cpumask_setall(idle_masks.cpu);
+	cpumask_setall(idle_masks.smt);
+	scx_has_idle_cpus = true;
+}
+
+void __scx_update_idle(struct rq *rq, bool idle)
+{
+	int cpu = cpu_of(rq);
+	struct cpumask *sib_mask = topology_sibling_cpumask(cpu);
+
+	if (SCX_HAS_OP(update_idle)) {
+		scx_ops.update_idle(cpu_of(rq), idle);
+		if (!static_branch_unlikely(&scx_builtin_idle_enabled))
+			return;
+	}
+
+	if (idle) {
+		cpumask_set_cpu(cpu, idle_masks.cpu);
+		if (!scx_has_idle_cpus)
+			scx_has_idle_cpus = true;
+
+		/*
+		 * idle_masks.smt handling is racy but that's fine as it's only
+		 * for optimization and self-correcting.
+		 */
+		for_each_cpu(cpu, sib_mask) {
+			if (!cpumask_test_cpu(cpu, idle_masks.cpu))
+				return;
+		}
+		cpumask_or(idle_masks.smt, idle_masks.smt, sib_mask);
+	} else {
+		cpumask_clear_cpu(cpu, idle_masks.cpu);
+		if (scx_has_idle_cpus && cpumask_empty(idle_masks.cpu))
+			scx_has_idle_cpus = false;
+
+		cpumask_andnot(idle_masks.smt, idle_masks.smt, sib_mask);
+	}
+}
+
+#else /* !CONFIG_SMP */
+
+static bool test_and_clear_cpu_idle(int cpu) { return false; }
+static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed) { return -EBUSY; }
+static void reset_idle_masks(void) {}
+
+#endif /* CONFIG_SMP */
+
+static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
+{
+	update_curr_scx(rq);
+
+	/*
+	 * While disabling, always resched as we can't trust the slice
+	 * management.
+	 */
+	if (scx_ops_disabling())
+		curr->scx.slice = 0;
+
+	if (!curr->scx.slice)
+		resched_curr(rq);
+}
+
+static int scx_ops_prepare_task(struct task_struct *p, struct task_group *tg)
+{
+	int ret;
+
+	WARN_ON_ONCE(p->scx.flags & SCX_TASK_OPS_PREPPED);
+
+	if (SCX_HAS_OP(prep_enable)) {
+		struct scx_enable_args args = { };
+
+		ret = SCX_CALL_OP_RET(SCX_KF_SLEEPABLE, prep_enable, p, &args);
+		if (unlikely(ret)) {
+			ret = ops_sanitize_err("prep_enable", ret);
+			return ret;
+		}
+	}
+
+	p->scx.flags |= SCX_TASK_OPS_PREPPED;
+	return 0;
+}
+
+static void scx_ops_enable_task(struct task_struct *p)
+{
+	lockdep_assert_rq_held(task_rq(p));
+	WARN_ON_ONCE(!(p->scx.flags & SCX_TASK_OPS_PREPPED));
+
+	if (SCX_HAS_OP(enable)) {
+		struct scx_enable_args args = { };
+		scx_ops.enable(p, &args);
+	}
+	p->scx.flags &= ~SCX_TASK_OPS_PREPPED;
+	p->scx.flags |= SCX_TASK_OPS_ENABLED;
+}
+
+static void scx_ops_disable_task(struct task_struct *p)
+{
+	lockdep_assert_rq_held(task_rq(p));
+
+	if (p->scx.flags & SCX_TASK_OPS_PREPPED) {
+		if (SCX_HAS_OP(cancel_enable)) {
+			struct scx_enable_args args = { };
+			scx_ops.cancel_enable(p, &args);
+		}
+		p->scx.flags &= ~SCX_TASK_OPS_PREPPED;
+	} else if (p->scx.flags & SCX_TASK_OPS_ENABLED) {
+		if (SCX_HAS_OP(disable))
+			scx_ops.disable(p);
+		p->scx.flags &= ~SCX_TASK_OPS_ENABLED;
+	}
+}
+
+/**
+ * refresh_scx_weight - Refresh a task's ext weight
+ * @p: task to refresh ext weight for
+ *
+ * @p->scx.weight carries the task's static priority in cgroup weight scale to
+ * enable easy access from the BPF scheduler. To keep it synchronized with the
+ * current task priority, this function should be called when a new task is
+ * created, priority is changed for a task on sched_ext, and a task is switched
+ * to sched_ext from other classes.
+ */
+static void refresh_scx_weight(struct task_struct *p)
+{
+	u32 weight = sched_prio_to_weight[p->static_prio - MAX_RT_PRIO];
+
+	p->scx.weight = sched_weight_to_cgroup(weight);
+}
+
+void scx_pre_fork(struct task_struct *p)
+{
+	/*
+	 * BPF scheduler enable/disable paths want to be able to iterate and
+	 * update all tasks which can become complex when racing forks. As
+	 * enable/disable are very cold paths, let's use a percpu_rwsem to
+	 * exclude forks.
+	 */
+	percpu_down_read(&scx_fork_rwsem);
+}
+
+int scx_fork(struct task_struct *p)
+{
+	percpu_rwsem_assert_held(&scx_fork_rwsem);
+
+	if (scx_enabled())
+		return scx_ops_prepare_task(p, task_group(p));
+	else
+		return 0;
+}
+
+void scx_post_fork(struct task_struct *p)
+{
+	refresh_scx_weight(p);
+
+	if (scx_enabled()) {
+		struct rq_flags rf;
+		struct rq *rq;
+
+		rq = task_rq_lock(p, &rf);
+		scx_ops_enable_task(p);
+		task_rq_unlock(rq, p, &rf);
+	}
+
+	spin_lock_irq(&scx_tasks_lock);
+	list_add_tail(&p->scx.tasks_node, &scx_tasks);
+	spin_unlock_irq(&scx_tasks_lock);
+
+	percpu_up_read(&scx_fork_rwsem);
+}
+
+void scx_cancel_fork(struct task_struct *p)
+{
+	if (scx_enabled())
+		scx_ops_disable_task(p);
+	percpu_up_read(&scx_fork_rwsem);
+}
+
+void sched_ext_free(struct task_struct *p)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&scx_tasks_lock, flags);
+	list_del_init(&p->scx.tasks_node);
+	spin_unlock_irqrestore(&scx_tasks_lock, flags);
+
+	/*
+	 * @p is off scx_tasks and wholly ours. scx_ops_enable()'s PREPPED ->
+	 * ENABLED transitions can't race us. Disable ops for @p.
+	 */
+	if (p->scx.flags & (SCX_TASK_OPS_PREPPED | SCX_TASK_OPS_ENABLED)) {
+		struct rq_flags rf;
+		struct rq *rq;
+
+		rq = task_rq_lock(p, &rf);
+		scx_ops_disable_task(p);
+		task_rq_unlock(rq, p, &rf);
+	}
+}
+
+static void reweight_task_scx(struct rq *rq, struct task_struct *p, int newprio)
+{
+	refresh_scx_weight(p);
+}
+
+static void prio_changed_scx(struct rq *rq, struct task_struct *p, int oldprio)
+{
+}
+
+static void switching_to_scx(struct rq *rq, struct task_struct *p)
+{
+	refresh_scx_weight(p);
+
+	/*
+	 * set_cpus_allowed_scx() is not called while @p is associated with a
+	 * different scheduler class. Keep the BPF scheduler up-to-date.
+	 */
+	if (SCX_HAS_OP(set_cpumask))
+		scx_ops.set_cpumask(p, (struct cpumask *)p->cpus_ptr);
+}
+
+static void check_preempt_curr_scx(struct rq *rq, struct task_struct *p,int wake_flags) {}
+static void switched_to_scx(struct rq *rq, struct task_struct *p) {}
+
+/*
+ * Omitted operations:
+ *
+ * - check_preempt_curr: NOOP as it isn't useful in the wakeup path because the
+ *   task isn't tied to the CPU at that point.
+ *
+ * - migrate_task_rq: Unncessary as task to cpu mapping is transient.
+ *
+ * - task_fork/dead: We need fork/dead notifications for all tasks regardless of
+ *   their current sched_class. Call them directly from sched core instead.
+ *
+ * - task_woken, switched_from: Unnecessary.
+ */
+DEFINE_SCHED_CLASS(ext) = {
+	.enqueue_task		= enqueue_task_scx,
+	.dequeue_task		= dequeue_task_scx,
+	.yield_task		= yield_task_scx,
+	.yield_to_task		= yield_to_task_scx,
+
+	.check_preempt_curr	= check_preempt_curr_scx,
+
+	.pick_next_task		= pick_next_task_scx,
+
+	.put_prev_task		= put_prev_task_scx,
+	.set_next_task          = set_next_task_scx,
+
+#ifdef CONFIG_SMP
+	.balance		= balance_scx,
+	.select_task_rq		= select_task_rq_scx,
+	.set_cpus_allowed	= set_cpus_allowed_scx,
+#endif
+
+	.task_tick		= task_tick_scx,
+
+	.switching_to		= switching_to_scx,
+	.switched_to		= switched_to_scx,
+	.reweight_task		= reweight_task_scx,
+	.prio_changed		= prio_changed_scx,
+
+	.update_curr		= update_curr_scx,
+
+#ifdef CONFIG_UCLAMP_TASK
+	.uclamp_enabled		= 0,
+#endif
+};
+
+static void init_dsq(struct scx_dispatch_q *dsq, u64 dsq_id)
+{
+	memset(dsq, 0, sizeof(*dsq));
+
+	raw_spin_lock_init(&dsq->lock);
+	INIT_LIST_HEAD(&dsq->fifo);
+	dsq->id = dsq_id;
+}
+
+static struct scx_dispatch_q *create_dsq(u64 dsq_id, int node)
+{
+	struct scx_dispatch_q *dsq;
+	int ret;
+
+	if (dsq_id & SCX_DSQ_FLAG_BUILTIN)
+		return ERR_PTR(-EINVAL);
+
+	dsq = kmalloc_node(sizeof(*dsq), GFP_KERNEL, node);
+	if (!dsq)
+		return ERR_PTR(-ENOMEM);
+
+	init_dsq(dsq, dsq_id);
+
+	ret = rhashtable_insert_fast(&dsq_hash, &dsq->hash_node,
+				     dsq_hash_params);
+	if (ret) {
+		kfree(dsq);
+		return ERR_PTR(ret);
+	}
+	return dsq;
+}
+
+static void free_dsq_irq_workfn(struct irq_work *irq_work)
+{
+	struct llist_node *to_free = llist_del_all(&dsqs_to_free);
+	struct scx_dispatch_q *dsq, *tmp_dsq;
+
+	llist_for_each_entry_safe(dsq, tmp_dsq, to_free, free_node)
+		kfree_rcu(dsq);
+}
+
+static DEFINE_IRQ_WORK(free_dsq_irq_work, free_dsq_irq_workfn);
+
+static void destroy_dsq(u64 dsq_id)
+{
+	struct scx_dispatch_q *dsq;
+	unsigned long flags;
+
+	rcu_read_lock();
+
+	dsq = rhashtable_lookup_fast(&dsq_hash, &dsq_id, dsq_hash_params);
+	if (!dsq)
+		goto out_unlock_rcu;
+
+	raw_spin_lock_irqsave(&dsq->lock, flags);
+
+	if (dsq->nr) {
+		scx_ops_error("attempting to destroy in-use dsq 0x%016llx (nr=%u)",
+			      dsq->id, dsq->nr);
+		goto out_unlock_dsq;
+	}
+
+	if (rhashtable_remove_fast(&dsq_hash, &dsq->hash_node, dsq_hash_params))
+		goto out_unlock_dsq;
+
+	/*
+	 * Mark dead by invalidating ->id to prevent dispatch_enqueue() from
+	 * queueing more tasks. As this function can be called from anywhere,
+	 * freeing is bounced through an irq work to avoid nesting RCU
+	 * operations inside scheduler locks.
+	 */
+	dsq->id = SCX_DSQ_INVALID;
+	llist_add(&dsq->free_node, &dsqs_to_free);
+	irq_work_queue(&free_dsq_irq_work);
+
+out_unlock_dsq:
+	raw_spin_unlock_irqrestore(&dsq->lock, flags);
+out_unlock_rcu:
+	rcu_read_unlock();
+}
+
+/*
+ * Used by sched_fork() and __setscheduler_prio() to pick the matching
+ * sched_class. dl/rt are already handled.
+ */
+bool task_on_scx(struct task_struct *p)
+{
+	if (!scx_enabled() || scx_ops_disabling())
+		return false;
+	return p->policy == SCHED_EXT;
+}
+
+static void scx_ops_fallback_enqueue(struct task_struct *p, u64 enq_flags)
+{
+	if (enq_flags & SCX_ENQ_LAST)
+		scx_bpf_dispatch(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, enq_flags);
+	else
+		scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+}
+
+static void scx_ops_fallback_dispatch(s32 cpu, struct task_struct *prev) {}
+
+static void scx_ops_disable_workfn(struct kthread_work *work)
+{
+	struct scx_exit_info *ei = &scx_exit_info;
+	struct scx_task_iter sti;
+	struct task_struct *p;
+	struct rhashtable_iter rht_iter;
+	struct scx_dispatch_q *dsq;
+	const char *reason;
+	int i, type;
+
+	type = atomic_read(&scx_exit_type);
+	while (true) {
+		/*
+		 * NONE indicates that a new scx_ops has been registered since
+		 * disable was scheduled - don't kill the new ops. DONE
+		 * indicates that the ops has already been disabled.
+		 */
+		if (type == SCX_EXIT_NONE || type == SCX_EXIT_DONE)
+			return;
+		if (atomic_try_cmpxchg(&scx_exit_type, &type, SCX_EXIT_DONE))
+			break;
+	}
+
+	switch (type) {
+	case SCX_EXIT_UNREG:
+		reason = "BPF scheduler unregistered";
+		break;
+	case SCX_EXIT_ERROR:
+		reason = "runtime error";
+		break;
+	case SCX_EXIT_ERROR_BPF:
+		reason = "scx_bpf_error";
+		break;
+	default:
+		reason = "<UNKNOWN>";
+	}
+
+	ei->type = type;
+	strlcpy(ei->reason, reason, sizeof(ei->reason));
+
+	switch (scx_ops_set_enable_state(SCX_OPS_DISABLING)) {
+	case SCX_OPS_DISABLED:
+		pr_warn("sched_ext: ops error detected without ops (%s)\n",
+			scx_exit_info.msg);
+		WARN_ON_ONCE(scx_ops_set_enable_state(SCX_OPS_DISABLED) !=
+			     SCX_OPS_DISABLING);
+		return;
+	case SCX_OPS_PREPPING:
+		goto forward_progress_guaranteed;
+	case SCX_OPS_DISABLING:
+		/* shouldn't happen but handle it like ENABLING if it does */
+		WARN_ONCE(true, "sched_ext: duplicate disabling instance?");
+		fallthrough;
+	case SCX_OPS_ENABLING:
+	case SCX_OPS_ENABLED:
+		break;
+	}
+
+	/*
+	 * DISABLING is set and ops was either ENABLING or ENABLED indicating
+	 * that the ops and static branches are set.
+	 *
+	 * We must guarantee that all runnable tasks make forward progress
+	 * without trusting the BPF scheduler. We can't grab any mutexes or
+	 * rwsems as they might be held by tasks that the BPF scheduler is
+	 * forgetting to run, which unfortunately also excludes toggling the
+	 * static branches.
+	 *
+	 * Let's work around by overriding a couple ops and modifying behaviors
+	 * based on the DISABLING state and then cycling the tasks through
+	 * dequeue/enqueue to force global FIFO scheduling.
+	 *
+	 * a. ops.enqueue() and .dispatch() are overridden for simple global
+	 *    FIFO scheduling.
+	 *
+	 * b. balance_scx() never sets %SCX_TASK_BAL_KEEP as the slice value
+	 *    can't be trusted. Whenever a tick triggers, the running task is
+	 *    rotated to the tail of the queue.
+	 *
+	 * c. pick_next_task() suppresses zero slice warning.
+	 */
+	scx_ops.enqueue = scx_ops_fallback_enqueue;
+	scx_ops.dispatch = scx_ops_fallback_dispatch;
+
+	spin_lock_irq(&scx_tasks_lock);
+	scx_task_iter_init(&sti);
+	while ((p = scx_task_iter_next_filtered_locked(&sti))) {
+		if (READ_ONCE(p->__state) != TASK_DEAD) {
+			SCHED_CHANGE_BLOCK(task_rq(p), p,
+					   DEQUEUE_SAVE | DEQUEUE_MOVE) {
+				/* cycling deq/enq is enough, see above */
+			}
+		}
+	}
+	scx_task_iter_exit(&sti);
+	spin_unlock_irq(&scx_tasks_lock);
+
+forward_progress_guaranteed:
+	/*
+	 * Here, every runnable task is guaranteed to make forward progress and
+	 * we can safely use blocking synchronization constructs. Actually
+	 * disable ops.
+	 */
+	mutex_lock(&scx_ops_enable_mutex);
+
+	/* avoid racing against fork */
+	cpus_read_lock();
+	percpu_down_write(&scx_fork_rwsem);
+
+	spin_lock_irq(&scx_tasks_lock);
+	scx_task_iter_init(&sti);
+	while ((p = scx_task_iter_next_filtered_locked(&sti))) {
+		const struct sched_class *old_class = p->sched_class;
+		struct rq *rq = task_rq(p);
+		bool alive = READ_ONCE(p->__state) != TASK_DEAD;
+
+		update_rq_clock(rq);
+
+		SCHED_CHANGE_BLOCK(rq, p, DEQUEUE_SAVE | DEQUEUE_MOVE |
+				   DEQUEUE_NOCLOCK) {
+			p->scx.slice = min_t(u64, p->scx.slice, SCX_SLICE_DFL);
+
+			__setscheduler_prio(p, p->prio);
+			if (alive)
+				check_class_changing(task_rq(p), p, old_class);
+		}
+
+		if (alive)
+			check_class_changed(task_rq(p), p, old_class, p->prio);
+
+		scx_ops_disable_task(p);
+	}
+	scx_task_iter_exit(&sti);
+	spin_unlock_irq(&scx_tasks_lock);
+
+	/* no task is on scx, turn off all the switches and flush in-progress calls */
+	static_branch_disable_cpuslocked(&__scx_ops_enabled);
+	for (i = 0; i < SCX_NR_ONLINE_OPS; i++)
+		static_branch_disable_cpuslocked(&scx_has_op[i]);
+	static_branch_disable_cpuslocked(&scx_ops_enq_last);
+	static_branch_disable_cpuslocked(&scx_ops_enq_exiting);
+	static_branch_disable_cpuslocked(&scx_builtin_idle_enabled);
+	synchronize_rcu();
+
+	percpu_up_write(&scx_fork_rwsem);
+	cpus_read_unlock();
+
+	if (ei->type >= SCX_EXIT_ERROR) {
+		printk(KERN_ERR "sched_ext: BPF scheduler \"%s\" errored, disabling\n", scx_ops.name);
+
+		if (ei->msg[0] == '\0')
+			printk(KERN_ERR "sched_ext: %s\n", ei->reason);
+		else
+			printk(KERN_ERR "sched_ext: %s (%s)\n", ei->reason, ei->msg);
+
+		stack_trace_print(ei->bt, ei->bt_len, 2);
+	}
+
+	if (scx_ops.exit)
+		scx_ops.exit(ei);
+
+	memset(&scx_ops, 0, sizeof(scx_ops));
+
+	rhashtable_walk_enter(&dsq_hash, &rht_iter);
+	do {
+		rhashtable_walk_start(&rht_iter);
+
+		while ((dsq = rhashtable_walk_next(&rht_iter)) && !IS_ERR(dsq))
+			destroy_dsq(dsq->id);
+
+		rhashtable_walk_stop(&rht_iter);
+	} while (dsq == ERR_PTR(-EAGAIN));
+	rhashtable_walk_exit(&rht_iter);
+
+	free_percpu(scx_dsp_buf);
+	scx_dsp_buf = NULL;
+	scx_dsp_max_batch = 0;
+
+	mutex_unlock(&scx_ops_enable_mutex);
+
+	WARN_ON_ONCE(scx_ops_set_enable_state(SCX_OPS_DISABLED) !=
+		     SCX_OPS_DISABLING);
+}
+
+static DEFINE_KTHREAD_WORK(scx_ops_disable_work, scx_ops_disable_workfn);
+
+static void schedule_scx_ops_disable_work(void)
+{
+	struct kthread_worker *helper = READ_ONCE(scx_ops_helper);
+
+	/*
+	 * We may be called spuriously before the first bpf_sched_ext_reg(). If
+	 * scx_ops_helper isn't set up yet, there's nothing to do.
+	 */
+	if (helper)
+		kthread_queue_work(helper, &scx_ops_disable_work);
+}
+
+static void scx_ops_disable(enum scx_exit_type type)
+{
+	int none = SCX_EXIT_NONE;
+
+	if (WARN_ON_ONCE(type == SCX_EXIT_NONE || type == SCX_EXIT_DONE))
+		type = SCX_EXIT_ERROR;
+
+	atomic_try_cmpxchg(&scx_exit_type, &none, type);
+
+	schedule_scx_ops_disable_work();
+}
+
+static void scx_ops_error_irq_workfn(struct irq_work *irq_work)
+{
+	schedule_scx_ops_disable_work();
+}
+
+static DEFINE_IRQ_WORK(scx_ops_error_irq_work, scx_ops_error_irq_workfn);
+
+__printf(2, 3) static void scx_ops_error_type(enum scx_exit_type type,
+					      const char *fmt, ...)
+{
+	struct scx_exit_info *ei = &scx_exit_info;
+	int none = SCX_EXIT_NONE;
+	va_list args;
+
+	if (!atomic_try_cmpxchg(&scx_exit_type, &none, type))
+		return;
+
+	ei->bt_len = stack_trace_save(ei->bt, ARRAY_SIZE(ei->bt), 1);
+
+	va_start(args, fmt);
+	vscnprintf(ei->msg, ARRAY_SIZE(ei->msg), fmt, args);
+	va_end(args);
+
+	irq_work_queue(&scx_ops_error_irq_work);
+}
+
+static struct kthread_worker *scx_create_rt_helper(const char *name)
+{
+	struct kthread_worker *helper;
+
+	helper = kthread_create_worker(0, name);
+	if (helper)
+		sched_set_fifo(helper->task);
+	return helper;
+}
+
+static int scx_ops_enable(struct sched_ext_ops *ops)
+{
+	struct scx_task_iter sti;
+	struct task_struct *p;
+	int i, ret;
+
+	mutex_lock(&scx_ops_enable_mutex);
+
+	if (!scx_ops_helper) {
+		WRITE_ONCE(scx_ops_helper,
+			   scx_create_rt_helper("sched_ext_ops_helper"));
+		if (!scx_ops_helper) {
+			ret = -ENOMEM;
+			goto err_unlock;
+		}
+	}
+
+	if (scx_ops_enable_state() != SCX_OPS_DISABLED) {
+		ret = -EBUSY;
+		goto err_unlock;
+	}
+
+	/*
+	 * Set scx_ops, transition to PREPPING and clear exit info to arm the
+	 * disable path. Failure triggers full disabling from here on.
+	 */
+	scx_ops = *ops;
+
+	WARN_ON_ONCE(scx_ops_set_enable_state(SCX_OPS_PREPPING) !=
+		     SCX_OPS_DISABLED);
+
+	memset(&scx_exit_info, 0, sizeof(scx_exit_info));
+	atomic_set(&scx_exit_type, SCX_EXIT_NONE);
+	scx_warned_zero_slice = false;
+
+	atomic64_set(&scx_nr_rejected, 0);
+
+	/*
+	 * Keep CPUs stable during enable so that the BPF scheduler can track
+	 * online CPUs by watching ->on/offline_cpu() after ->init().
+	 */
+	cpus_read_lock();
+
+	if (scx_ops.init) {
+		ret = SCX_CALL_OP_RET(SCX_KF_INIT | SCX_KF_SLEEPABLE, init);
+		if (ret) {
+			ret = ops_sanitize_err("init", ret);
+			goto err_disable;
+		}
+
+		/*
+		 * Exit early if ops.init() triggered scx_bpf_error(). Not
+		 * strictly necessary as we'll fail transitioning into ENABLING
+		 * later but that'd be after calling ops.prep_enable() on all
+		 * tasks and with -EBUSY which isn't very intuitive. Let's exit
+		 * early with success so that the condition is notified through
+		 * ops.exit() like other scx_bpf_error() invocations.
+		 */
+		if (atomic_read(&scx_exit_type) != SCX_EXIT_NONE)
+			goto err_disable;
+	}
+
+	WARN_ON_ONCE(scx_dsp_buf);
+	scx_dsp_max_batch = ops->dispatch_max_batch ?: SCX_DSP_DFL_MAX_BATCH;
+	scx_dsp_buf = __alloc_percpu(sizeof(scx_dsp_buf[0]) * scx_dsp_max_batch,
+				     __alignof__(scx_dsp_buf[0]));
+	if (!scx_dsp_buf) {
+		ret = -ENOMEM;
+		goto err_disable;
+	}
+
+	/*
+	 * Lock out forks before opening the floodgate so that they don't wander
+	 * into the operations prematurely.
+	 */
+	percpu_down_write(&scx_fork_rwsem);
+
+	for (i = 0; i < SCX_NR_ONLINE_OPS; i++)
+		if (((void (**)(void))ops)[i])
+			static_branch_enable_cpuslocked(&scx_has_op[i]);
+
+	if (ops->flags & SCX_OPS_ENQ_LAST)
+		static_branch_enable_cpuslocked(&scx_ops_enq_last);
+
+	if (ops->flags & SCX_OPS_ENQ_EXITING)
+		static_branch_enable_cpuslocked(&scx_ops_enq_exiting);
+
+	if (!ops->update_idle || (ops->flags & SCX_OPS_KEEP_BUILTIN_IDLE)) {
+		reset_idle_masks();
+		static_branch_enable_cpuslocked(&scx_builtin_idle_enabled);
+	} else {
+		static_branch_disable_cpuslocked(&scx_builtin_idle_enabled);
+	}
+
+	static_branch_enable_cpuslocked(&__scx_ops_enabled);
+
+	/*
+	 * Enable ops for every task. Fork is excluded by scx_fork_rwsem
+	 * preventing new tasks from being added. No need to exclude tasks
+	 * leaving as sched_ext_free() can handle both prepped and enabled
+	 * tasks. Prep all tasks first and then enable them with preemption
+	 * disabled.
+	 */
+	spin_lock_irq(&scx_tasks_lock);
+
+	scx_task_iter_init(&sti);
+	while ((p = scx_task_iter_next_filtered(&sti))) {
+		get_task_struct(p);
+		spin_unlock_irq(&scx_tasks_lock);
+
+		ret = scx_ops_prepare_task(p, task_group(p));
+		if (ret) {
+			put_task_struct(p);
+			spin_lock_irq(&scx_tasks_lock);
+			scx_task_iter_exit(&sti);
+			spin_unlock_irq(&scx_tasks_lock);
+			pr_err("sched_ext: ops.prep_enable() failed (%d) for %s[%d] while loading\n",
+			       ret, p->comm, p->pid);
+			goto err_disable_unlock;
+		}
+
+		put_task_struct(p);
+		spin_lock_irq(&scx_tasks_lock);
+	}
+	scx_task_iter_exit(&sti);
+
+	/*
+	 * All tasks are prepped but are still ops-disabled. Ensure that
+	 * %current can't be scheduled out and switch everyone.
+	 * preempt_disable() is necessary because we can't guarantee that
+	 * %current won't be starved if scheduled out while switching.
+	 */
+	preempt_disable();
+
+	/*
+	 * From here on, the disable path must assume that tasks have ops
+	 * enabled and need to be recovered.
+	 */
+	if (!scx_ops_tryset_enable_state(SCX_OPS_ENABLING, SCX_OPS_PREPPING)) {
+		preempt_enable();
+		spin_unlock_irq(&scx_tasks_lock);
+		ret = -EBUSY;
+		goto err_disable_unlock;
+	}
+
+	/*
+	 * We're fully committed and can't fail. The PREPPED -> ENABLED
+	 * transitions here are synchronized against sched_ext_free() through
+	 * scx_tasks_lock.
+	 */
+	scx_task_iter_init(&sti);
+	while ((p = scx_task_iter_next_filtered_locked(&sti))) {
+		if (READ_ONCE(p->__state) != TASK_DEAD) {
+			const struct sched_class *old_class = p->sched_class;
+			struct rq *rq = task_rq(p);
+
+			update_rq_clock(rq);
+
+			SCHED_CHANGE_BLOCK(rq, p, DEQUEUE_SAVE | DEQUEUE_MOVE |
+					   DEQUEUE_NOCLOCK) {
+				scx_ops_enable_task(p);
+				__setscheduler_prio(p, p->prio);
+				check_class_changing(task_rq(p), p, old_class);
+			}
+
+			check_class_changed(task_rq(p), p, old_class, p->prio);
+		} else {
+			scx_ops_disable_task(p);
+		}
+	}
+	scx_task_iter_exit(&sti);
+
+	spin_unlock_irq(&scx_tasks_lock);
+	preempt_enable();
+	percpu_up_write(&scx_fork_rwsem);
+
+	if (!scx_ops_tryset_enable_state(SCX_OPS_ENABLED, SCX_OPS_ENABLING)) {
+		ret = -EBUSY;
+		goto err_disable_unlock;
+	}
+
+	cpus_read_unlock();
+	mutex_unlock(&scx_ops_enable_mutex);
+
+	return 0;
+
+err_unlock:
+	mutex_unlock(&scx_ops_enable_mutex);
+	return ret;
+
+err_disable_unlock:
+	percpu_up_write(&scx_fork_rwsem);
+err_disable:
+	cpus_read_unlock();
+	mutex_unlock(&scx_ops_enable_mutex);
+	/* must be fully disabled before returning */
+	scx_ops_disable(SCX_EXIT_ERROR);
+	kthread_flush_work(&scx_ops_disable_work);
+	return ret;
+}
+
+#ifdef CONFIG_SCHED_DEBUG
+static const char *scx_ops_enable_state_str[] = {
+	[SCX_OPS_PREPPING]	= "prepping",
+	[SCX_OPS_ENABLING]	= "enabling",
+	[SCX_OPS_ENABLED]	= "enabled",
+	[SCX_OPS_DISABLING]	= "disabling",
+	[SCX_OPS_DISABLED]	= "disabled",
+};
+
+static int scx_debug_show(struct seq_file *m, void *v)
+{
+	mutex_lock(&scx_ops_enable_mutex);
+	seq_printf(m, "%-30s: %s\n", "ops", scx_ops.name);
+	seq_printf(m, "%-30s: %ld\n", "enabled", scx_enabled());
+	seq_printf(m, "%-30s: %s\n", "enable_state",
+		   scx_ops_enable_state_str[scx_ops_enable_state()]);
+	seq_printf(m, "%-30s: %llu\n", "nr_rejected",
+		   atomic64_read(&scx_nr_rejected));
+	mutex_unlock(&scx_ops_enable_mutex);
+	return 0;
+}
+
+static int scx_debug_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, scx_debug_show, NULL);
+}
+
+const struct file_operations sched_ext_fops = {
+	.open		= scx_debug_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+#endif
+
+/********************************************************************************
+ * bpf_struct_ops plumbing.
+ */
+#include <linux/bpf_verifier.h>
+#include <linux/bpf.h>
+#include <linux/btf.h>
+
+extern struct btf *btf_vmlinux;
+static const struct btf_type *task_struct_type;
+
+static bool bpf_scx_is_valid_access(int off, int size,
+				    enum bpf_access_type type,
+				    const struct bpf_prog *prog,
+				    struct bpf_insn_access_aux *info)
+{
+	if (off < 0 || off >= sizeof(__u64) * MAX_BPF_FUNC_ARGS)
+		return false;
+	if (type != BPF_READ)
+		return false;
+	if (off % size != 0)
+		return false;
+
+	return btf_ctx_access(off, size, type, prog, info);
+}
+
+static int bpf_scx_btf_struct_access(struct bpf_verifier_log *log,
+				     const struct bpf_reg_state *reg, int off,
+				     int size, enum bpf_access_type atype,
+				     u32 *next_btf_id, enum bpf_type_flag *flag)
+{
+	const struct btf_type *t;
+
+	t = btf_type_by_id(reg->btf, reg->btf_id);
+	if (t == task_struct_type) {
+		if (off >= offsetof(struct task_struct, scx.slice) &&
+		    off + size <= offsetofend(struct task_struct, scx.slice))
+			return SCALAR_VALUE;
+	}
+
+	if (atype == BPF_READ)
+		return btf_struct_access(log, reg, off, size, atype,
+					 next_btf_id, flag);
+
+	bpf_log(log, "only read is supported\n");
+	return -EACCES;
+}
+
+static const struct bpf_func_proto *
+bpf_scx_get_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
+{
+	switch (func_id) {
+	case BPF_FUNC_task_storage_get:
+		return &bpf_task_storage_get_proto;
+	case BPF_FUNC_task_storage_delete:
+		return &bpf_task_storage_delete_proto;
+	default:
+		return bpf_base_func_proto(func_id);
+	}
+}
+
+const struct bpf_verifier_ops bpf_scx_verifier_ops = {
+	.get_func_proto = bpf_scx_get_func_proto,
+	.is_valid_access = bpf_scx_is_valid_access,
+	.btf_struct_access = bpf_scx_btf_struct_access,
+};
+
+static int bpf_scx_init_member(const struct btf_type *t,
+			       const struct btf_member *member,
+			       void *kdata, const void *udata)
+{
+	const struct sched_ext_ops *uops = udata;
+	struct sched_ext_ops *ops = kdata;
+	u32 moff = __btf_member_bit_offset(t, member) / 8;
+	int ret;
+
+	switch (moff) {
+	case offsetof(struct sched_ext_ops, dispatch_max_batch):
+		if (*(u32 *)(udata + moff) > INT_MAX)
+			return -E2BIG;
+		ops->dispatch_max_batch = *(u32 *)(udata + moff);
+		return 1;
+	case offsetof(struct sched_ext_ops, flags):
+		if (*(u64 *)(udata + moff) & ~SCX_OPS_ALL_FLAGS)
+			return -EINVAL;
+		ops->flags = *(u64 *)(udata + moff);
+		return 1;
+	case offsetof(struct sched_ext_ops, name):
+		ret = bpf_obj_name_cpy(ops->name, uops->name,
+				       sizeof(ops->name));
+		if (ret < 0)
+			return ret;
+		if (ret == 0)
+			return -EINVAL;
+		return 1;
+	}
+
+	return 0;
+}
+
+static int bpf_scx_check_member(const struct btf_type *t,
+				const struct btf_member *member,
+				const struct bpf_prog *prog)
+{
+	u32 moff = __btf_member_bit_offset(t, member) / 8;
+
+	switch (moff) {
+	case offsetof(struct sched_ext_ops, prep_enable):
+	case offsetof(struct sched_ext_ops, init):
+	case offsetof(struct sched_ext_ops, exit):
+		break;
+	default:
+		if (prog->aux->sleepable)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int bpf_scx_reg(void *kdata)
+{
+	return scx_ops_enable(kdata);
+}
+
+static void bpf_scx_unreg(void *kdata)
+{
+	scx_ops_disable(SCX_EXIT_UNREG);
+	kthread_flush_work(&scx_ops_disable_work);
+}
+
+static int bpf_scx_init(struct btf *btf)
+{
+	u32 type_id;
+
+	type_id = btf_find_by_name_kind(btf, "task_struct", BTF_KIND_STRUCT);
+	if (type_id < 0)
+		return -EINVAL;
+	task_struct_type = btf_type_by_id(btf, type_id);
+
+	return 0;
+}
+
+/* "extern" to avoid sparse warning, only used in this file */
+extern struct bpf_struct_ops bpf_sched_ext_ops;
+
+struct bpf_struct_ops bpf_sched_ext_ops = {
+	.verifier_ops = &bpf_scx_verifier_ops,
+	.reg = bpf_scx_reg,
+	.unreg = bpf_scx_unreg,
+	.check_member = bpf_scx_check_member,
+	.init_member = bpf_scx_init_member,
+	.init = bpf_scx_init,
+	.name = "sched_ext_ops",
+};
+
+void __init init_sched_ext_class(void)
+{
+	int cpu;
+	u32 v;
+
+	/*
+	 * The following is to prevent the compiler from optimizing out the enum
+	 * definitions so that BPF scheduler implementations can use them
+	 * through the generated vmlinux.h.
+	 */
+	WRITE_ONCE(v, SCX_WAKE_EXEC | SCX_ENQ_WAKEUP | SCX_DEQ_SLEEP);
+
+	BUG_ON(rhashtable_init(&dsq_hash, &dsq_hash_params));
+	init_dsq(&scx_dsq_global, SCX_DSQ_GLOBAL);
+#ifdef CONFIG_SMP
+	BUG_ON(!alloc_cpumask_var(&idle_masks.cpu, GFP_KERNEL));
+	BUG_ON(!alloc_cpumask_var(&idle_masks.smt, GFP_KERNEL));
+#endif
+	for_each_possible_cpu(cpu) {
+		struct rq *rq = cpu_rq(cpu);
+
+		init_dsq(&rq->scx.local_dsq, SCX_DSQ_LOCAL);
+	}
+}
+
+
+/********************************************************************************
+ * Helpers that can be called from the BPF scheduler.
+ */
+#include <linux/btf_ids.h>
+
+/* Disables missing prototype warnings for kfuncs */
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+		  "Global functions as their definitions will be in vmlinux BTF");
+
+/**
+ * scx_bpf_create_dsq - Create a custom DSQ
+ * @dsq_id: DSQ to create
+ * @node: NUMA node to allocate from
+ *
+ * Create a custom DSQ identified by @dsq_id. Can be called from ops.init() and
+ * ops.prep_enable().
+ */
+s32 scx_bpf_create_dsq(u64 dsq_id, s32 node)
+{
+	if (!scx_kf_allowed(SCX_KF_SLEEPABLE))
+		return -EINVAL;
+
+	if (unlikely(node >= (int)nr_node_ids ||
+		     (node < 0 && node != NUMA_NO_NODE)))
+		return -EINVAL;
+	return PTR_ERR_OR_ZERO(create_dsq(dsq_id, node));
+}
+
+BTF_SET8_START(scx_kfunc_ids_sleepable)
+BTF_ID_FLAGS(func, scx_bpf_create_dsq, KF_SLEEPABLE)
+BTF_SET8_END(scx_kfunc_ids_sleepable)
+
+static const struct btf_kfunc_id_set scx_kfunc_set_sleepable = {
+	.owner			= THIS_MODULE,
+	.set			= &scx_kfunc_ids_sleepable,
+};
+
+/**
+ * scx_bpf_dispatch - Dispatch a task to a DSQ
+ * @p: task_struct to dispatch
+ * @dsq_id: DSQ to dispatch to
+ * @slice: duration @p can run for in nsecs
+ * @enq_flags: SCX_ENQ_*
+ *
+ * Dispatch @p to the DSQ identified by @dsq_id. It is safe to call this
+ * function spuriously. Can be called from ops.enqueue() and ops.dispatch().
+ *
+ * When called from ops.enqueue(), it's for direct dispatch and @p must match
+ * the task being enqueued. Also, %SCX_DSQ_LOCAL_ON can't be used to target the
+ * local DSQ of a CPU other than the enqueueing one. Use ops.select_cpu() to be
+ * on the target CPU in the first place.
+ *
+ * When called from ops.dispatch(), there are no restrictions on @p or @dsq_id
+ * and this function can be called upto ops.dispatch_max_batch times to dispatch
+ * multiple tasks. scx_bpf_dispatch_nr_slots() returns the number of the
+ * remaining slots. scx_bpf_consume() flushes the batch and resets the counter.
+ *
+ * This function doesn't have any locking restrictions and may be called under
+ * BPF locks (in the future when BPF introduces more flexible locking).
+ *
+ * @p is allowed to run for @slice. The scheduling path is triggered on slice
+ * exhaustion. If zero, the current residual slice is maintained. If
+ * %SCX_SLICE_INF, @p never expires and the BPF scheduler must kick the CPU with
+ * scx_bpf_kick_cpu() to trigger scheduling.
+ */
+void scx_bpf_dispatch(struct task_struct *p, u64 dsq_id, u64 slice,
+		      u64 enq_flags)
+{
+	struct task_struct *ddsp_task;
+	int idx;
+
+	if (!scx_kf_allowed(SCX_KF_ENQUEUE_DISPATCH))
+		return;
+
+	lockdep_assert_irqs_disabled();
+
+	if (unlikely(!p)) {
+		scx_ops_error("called with NULL task");
+		return;
+	}
+
+	if (unlikely(enq_flags & __SCX_ENQ_INTERNAL_MASK)) {
+		scx_ops_error("invalid enq_flags 0x%llx", enq_flags);
+		return;
+	}
+
+	if (slice)
+		p->scx.slice = slice;
+	else
+		p->scx.slice = p->scx.slice ?: 1;
+
+	ddsp_task = __this_cpu_read(direct_dispatch_task);
+	if (ddsp_task) {
+		direct_dispatch(ddsp_task, p, dsq_id, enq_flags);
+		return;
+	}
+
+	idx = __this_cpu_read(scx_dsp_ctx.buf_cursor);
+	if (unlikely(idx >= scx_dsp_max_batch)) {
+		scx_ops_error("dispatch buffer overflow");
+		return;
+	}
+
+	this_cpu_ptr(scx_dsp_buf)[idx] = (struct scx_dsp_buf_ent){
+		.task = p,
+		.qseq = atomic64_read(&p->scx.ops_state) & SCX_OPSS_QSEQ_MASK,
+		.dsq_id = dsq_id,
+		.enq_flags = enq_flags,
+	};
+	__this_cpu_inc(scx_dsp_ctx.buf_cursor);
+}
+
+BTF_SET8_START(scx_kfunc_ids_enqueue_dispatch)
+BTF_ID_FLAGS(func, scx_bpf_dispatch)
+BTF_SET8_END(scx_kfunc_ids_enqueue_dispatch)
+
+static const struct btf_kfunc_id_set scx_kfunc_set_enqueue_dispatch = {
+	.owner			= THIS_MODULE,
+	.set			= &scx_kfunc_ids_enqueue_dispatch,
+};
+
+/**
+ * scx_bpf_dispatch_nr_slots - Return the number of remaining dispatch slots
+ *
+ * Can only be called from ops.dispatch().
+ */
+u32 scx_bpf_dispatch_nr_slots(void)
+{
+	if (!scx_kf_allowed(SCX_KF_DISPATCH))
+		return 0;
+
+	return scx_dsp_max_batch - __this_cpu_read(scx_dsp_ctx.buf_cursor);
+}
+
+/**
+ * scx_bpf_consume - Transfer a task from a DSQ to the current CPU's local DSQ
+ * @dsq_id: DSQ to consume
+ *
+ * Consume a task from the non-local DSQ identified by @dsq_id and transfer it
+ * to the current CPU's local DSQ for execution. Can only be called from
+ * ops.dispatch().
+ *
+ * This function flushes the in-flight dispatches from scx_bpf_dispatch() before
+ * trying to consume the specified DSQ. It may also grab rq locks and thus can't
+ * be called under any BPF locks.
+ *
+ * Returns %true if a task has been consumed, %false if there isn't any task to
+ * consume.
+ */
+bool scx_bpf_consume(u64 dsq_id)
+{
+	struct scx_dsp_ctx *dspc = this_cpu_ptr(&scx_dsp_ctx);
+	struct scx_dispatch_q *dsq;
+
+	if (!scx_kf_allowed(SCX_KF_DISPATCH))
+		return false;
+
+	flush_dispatch_buf(dspc->rq, dspc->rf);
+
+	dsq = find_non_local_dsq(dsq_id);
+	if (unlikely(!dsq)) {
+		scx_ops_error("invalid DSQ ID 0x%016llx", dsq_id);
+		return false;
+	}
+
+	if (consume_dispatch_q(dspc->rq, dspc->rf, dsq)) {
+		/*
+		 * A successfully consumed task can be dequeued before it starts
+		 * running while the CPU is trying to migrate other dispatched
+		 * tasks. Bump nr_tasks to tell balance_scx() to retry on empty
+		 * local DSQ.
+		 */
+		dspc->nr_tasks++;
+		return true;
+	} else {
+		return false;
+	}
+}
+
+BTF_SET8_START(scx_kfunc_ids_dispatch)
+BTF_ID_FLAGS(func, scx_bpf_dispatch_nr_slots)
+BTF_ID_FLAGS(func, scx_bpf_consume)
+BTF_SET8_END(scx_kfunc_ids_dispatch)
+
+static const struct btf_kfunc_id_set scx_kfunc_set_dispatch = {
+	.owner			= THIS_MODULE,
+	.set			= &scx_kfunc_ids_dispatch,
+};
+
+/**
+ * scx_bpf_dsq_nr_queued - Return the number of queued tasks
+ * @dsq_id: id of the DSQ
+ *
+ * Return the number of tasks in the DSQ matching @dsq_id. If not found,
+ * -%ENOENT is returned. Can be called from any non-sleepable online scx_ops
+ * operations.
+ */
+s32 scx_bpf_dsq_nr_queued(u64 dsq_id)
+{
+	struct scx_dispatch_q *dsq;
+
+	lockdep_assert(rcu_read_lock_any_held());
+
+	if (dsq_id == SCX_DSQ_LOCAL) {
+		return this_rq()->scx.local_dsq.nr;
+	} else if ((dsq_id & SCX_DSQ_LOCAL_ON) == SCX_DSQ_LOCAL_ON) {
+		s32 cpu = dsq_id & SCX_DSQ_LOCAL_CPU_MASK;
+
+		if (ops_cpu_valid(cpu))
+			return cpu_rq(cpu)->scx.local_dsq.nr;
+	} else {
+		dsq = find_non_local_dsq(dsq_id);
+		if (dsq)
+			return dsq->nr;
+	}
+	return -ENOENT;
+}
+
+/**
+ * scx_bpf_test_and_clear_cpu_idle - Test and clear @cpu's idle state
+ * @cpu: cpu to test and clear idle for
+ *
+ * Returns %true if @cpu was idle and its idle state was successfully cleared.
+ * %false otherwise.
+ *
+ * Unavailable if ops.update_idle() is implemented and
+ * %SCX_OPS_KEEP_BUILTIN_IDLE is not set.
+ */
+bool scx_bpf_test_and_clear_cpu_idle(s32 cpu)
+{
+	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
+		scx_ops_error("built-in idle tracking is disabled");
+		return false;
+	}
+
+	if (ops_cpu_valid(cpu))
+		return test_and_clear_cpu_idle(cpu);
+	else
+		return false;
+}
+
+/**
+ * scx_bpf_pick_idle_cpu - Pick and claim an idle cpu
+ * @cpus_allowed: Allowed cpumask
+ *
+ * Pick and claim an idle cpu which is also in @cpus_allowed. Returns the picked
+ * idle cpu number on success. -%EBUSY if no matching cpu was found.
+ *
+ * Unavailable if ops.update_idle() is implemented and
+ * %SCX_OPS_KEEP_BUILTIN_IDLE is not set.
+ */
+s32 scx_bpf_pick_idle_cpu(const struct cpumask *cpus_allowed)
+{
+	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
+		scx_ops_error("built-in idle tracking is disabled");
+		return -EBUSY;
+	}
+
+	return scx_pick_idle_cpu(cpus_allowed);
+}
+
+/**
+ * scx_bpf_get_idle_cpumask - Get a referenced kptr to the idle-tracking
+ * per-CPU cpumask.
+ *
+ * Returns NULL if idle tracking is not enabled, or running on a UP kernel.
+ */
+const struct cpumask *scx_bpf_get_idle_cpumask(void)
+{
+	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
+		scx_ops_error("built-in idle tracking is disabled");
+		return cpu_none_mask;
+	}
+
+#ifdef CONFIG_SMP
+	return idle_masks.cpu;
+#else
+	return cpu_none_mask;
+#endif
+}
+
+/**
+ * scx_bpf_get_idle_smtmask - Get a referenced kptr to the idle-tracking,
+ * per-physical-core cpumask. Can be used to determine if an entire physical
+ * core is free.
+ *
+ * Returns NULL if idle tracking is not enabled, or running on a UP kernel.
+ */
+const struct cpumask *scx_bpf_get_idle_smtmask(void)
+{
+	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
+		scx_ops_error("built-in idle tracking is disabled");
+		return cpu_none_mask;
+	}
+
+#ifdef CONFIG_SMP
+	return idle_masks.smt;
+#else
+	return cpu_none_mask;
+#endif
+}
+
+/**
+ * scx_bpf_put_idle_cpumask - Release a previously acquired referenced kptr to
+ * either the percpu, or SMT idle-tracking cpumask.
+ */
+void scx_bpf_put_idle_cpumask(const struct cpumask *idle_mask)
+{
+	/*
+	 * Empty function body because we aren't actually acquiring or
+	 * releasing a reference to a global idle cpumask, which is read-only
+	 * in the caller and is never released. The acquire / release semantics
+	 * here are just used to make the cpumask is a trusted pointer in the
+	 * caller.
+	 */
+}
+
+struct scx_bpf_error_bstr_bufs {
+	u64			data[MAX_BPRINTF_VARARGS];
+	char			msg[SCX_EXIT_MSG_LEN];
+};
+
+static DEFINE_PER_CPU(struct scx_bpf_error_bstr_bufs, scx_bpf_error_bstr_bufs);
+
+/**
+ * scx_bpf_error_bstr - Indicate fatal error
+ * @fmt: error message format string
+ * @data: format string parameters packaged using ___bpf_fill() macro
+ * @data__sz: @data len, must end in '__sz' for the verifier
+ *
+ * Indicate that the BPF scheduler encountered a fatal error and initiate ops
+ * disabling.
+ */
+void scx_bpf_error_bstr(char *fmt, unsigned long long *data, u32 data__sz)
+{
+	struct bpf_bprintf_data bprintf_data = { .get_bin_args = true };
+	struct scx_bpf_error_bstr_bufs *bufs;
+	unsigned long flags;
+	int ret;
+
+	local_irq_save(flags);
+	bufs = this_cpu_ptr(&scx_bpf_error_bstr_bufs);
+
+	if (data__sz % 8 || data__sz > MAX_BPRINTF_VARARGS * 8 ||
+	    (data__sz && !data)) {
+		scx_ops_error("invalid data=%p and data__sz=%u",
+			      (void *)data, data__sz);
+		goto out_restore;
+	}
+
+	ret = copy_from_kernel_nofault(bufs->data, data, data__sz);
+	if (ret) {
+		scx_ops_error("failed to read data fields (%d)", ret);
+		goto out_restore;
+	}
+
+	ret = bpf_bprintf_prepare(fmt, UINT_MAX, bufs->data, data__sz / 8,
+				  &bprintf_data);
+	if (ret < 0) {
+		scx_ops_error("failed to format prepration (%d)", ret);
+		goto out_restore;
+	}
+
+	ret = bstr_printf(bufs->msg, sizeof(bufs->msg), fmt,
+			  bprintf_data.bin_args);
+	bpf_bprintf_cleanup(&bprintf_data);
+	if (ret < 0) {
+		scx_ops_error("scx_ops_error(\"%s\", %p, %u) failed to format",
+			      fmt, data, data__sz);
+		goto out_restore;
+	}
+
+	scx_ops_error_type(SCX_EXIT_ERROR_BPF, "%s", bufs->msg);
+out_restore:
+	local_irq_restore(flags);
+}
+
+/**
+ * scx_bpf_destroy_dsq - Destroy a custom DSQ
+ * @dsq_id: DSQ to destroy
+ *
+ * Destroy the custom DSQ identified by @dsq_id. Only DSQs created with
+ * scx_bpf_create_dsq() can be destroyed. The caller must ensure that the DSQ is
+ * empty and no further tasks are dispatched to it. Ignored if called on a DSQ
+ * which doesn't exist. Can be called from any online scx_ops operations.
+ */
+void scx_bpf_destroy_dsq(u64 dsq_id)
+{
+	destroy_dsq(dsq_id);
+}
+
+/**
+ * scx_bpf_task_running - Is task currently running?
+ * @p: task of interest
+ */
+bool scx_bpf_task_running(const struct task_struct *p)
+{
+	return task_rq(p)->curr == p;
+}
+
+/**
+ * scx_bpf_task_cpu - CPU a task is currently associated with
+ * @p: task of interest
+ */
+s32 scx_bpf_task_cpu(const struct task_struct *p)
+{
+	return task_cpu(p);
+}
+
+BTF_SET8_START(scx_kfunc_ids_any)
+BTF_ID_FLAGS(func, scx_bpf_dsq_nr_queued)
+BTF_ID_FLAGS(func, scx_bpf_test_and_clear_cpu_idle)
+BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, scx_bpf_get_idle_cpumask, KF_ACQUIRE)
+BTF_ID_FLAGS(func, scx_bpf_get_idle_smtmask, KF_ACQUIRE)
+BTF_ID_FLAGS(func, scx_bpf_put_idle_cpumask, KF_RELEASE)
+BTF_ID_FLAGS(func, scx_bpf_error_bstr, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, scx_bpf_destroy_dsq)
+BTF_ID_FLAGS(func, scx_bpf_task_running, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_TRUSTED_ARGS)
+BTF_SET8_END(scx_kfunc_ids_any)
+
+static const struct btf_kfunc_id_set scx_kfunc_set_any = {
+	.owner			= THIS_MODULE,
+	.set			= &scx_kfunc_ids_any,
+};
+
+__diag_pop();
+
+/*
+ * This can't be done from init_sched_ext_class() as register_btf_kfunc_id_set()
+ * needs most of the system to be up.
+ */
+static int __init register_ext_kfuncs(void)
+{
+	int ret;
+
+	/*
+	 * Some kfuncs are context-sensitive and can only be called from
+	 * specific SCX ops. They are grouped into BTF sets accordingly.
+	 * Unfortunately, BPF currently doesn't have a way of enforcing such
+	 * restrictions. Eventually, the verifier should be able to enforce
+	 * them. For now, register them the same and make each kfunc explicitly
+	 * check using scx_kf_allowed().
+	 */
+	if ((ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+					     &scx_kfunc_set_sleepable)) ||
+	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+					     &scx_kfunc_set_enqueue_dispatch)) ||
+	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+					     &scx_kfunc_set_dispatch)) ||
+	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+					     &scx_kfunc_set_any))) {
+		pr_err("sched_ext: failed to register kfunc sets (%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+__initcall(register_ext_kfuncs);
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index 6a93c4825339..f8d5682deacf 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -1,7 +1,94 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
+ * Copyright (c) 2022 David Vernet <dvernet@meta.com>
+ */
+enum scx_wake_flags {
+	/* expose select WF_* flags as enums */
+	SCX_WAKE_EXEC		= WF_EXEC,
+	SCX_WAKE_FORK		= WF_FORK,
+	SCX_WAKE_TTWU		= WF_TTWU,
+	SCX_WAKE_SYNC		= WF_SYNC,
+};
+
+enum scx_enq_flags {
+	/* expose select ENQUEUE_* flags as enums */
+	SCX_ENQ_WAKEUP		= ENQUEUE_WAKEUP,
+	SCX_ENQ_HEAD		= ENQUEUE_HEAD,
+
+	/* high 32bits are SCX specific */
+
+	/*
+	 * The task being enqueued is the only task available for the cpu. By
+	 * default, ext core keeps executing such tasks but when
+	 * %SCX_OPS_ENQ_LAST is specified, they're ops.enqueue()'d with
+	 * %SCX_ENQ_LAST and %SCX_ENQ_LOCAL flags set.
+	 *
+	 * If the BPF scheduler wants to continue executing the task,
+	 * ops.enqueue() should dispatch the task to %SCX_DSQ_LOCAL immediately.
+	 * If the task gets queued on a different dsq or the BPF side, the BPF
+	 * scheduler is responsible for triggering a follow-up scheduling event.
+	 * Otherwise, Execution may stall.
+	 */
+	SCX_ENQ_LAST		= 1LLU << 41,
+
+	/*
+	 * A hint indicating that it's advisable to enqueue the task on the
+	 * local dsq of the currently selected CPU. Currently used by
+	 * select_cpu_dfl() and together with %SCX_ENQ_LAST.
+	 */
+	SCX_ENQ_LOCAL		= 1LLU << 42,
+
+	/* high 8 bits are internal */
+	__SCX_ENQ_INTERNAL_MASK	= 0xffLLU << 56,
+
+	SCX_ENQ_CLEAR_OPSS	= 1LLU << 56,
+};
+
+enum scx_deq_flags {
+	/* expose select DEQUEUE_* flags as enums */
+	SCX_DEQ_SLEEP		= DEQUEUE_SLEEP,
+};
 
 #ifdef CONFIG_SCHED_CLASS_EXT
-#error "NOT IMPLEMENTED YET"
+
+extern const struct sched_class ext_sched_class;
+extern const struct bpf_verifier_ops bpf_sched_ext_verifier_ops;
+extern const struct file_operations sched_ext_fops;
+
+DECLARE_STATIC_KEY_FALSE(__scx_ops_enabled);
+#define scx_enabled()		static_branch_unlikely(&__scx_ops_enabled)
+
+bool task_on_scx(struct task_struct *p);
+void scx_pre_fork(struct task_struct *p);
+int scx_fork(struct task_struct *p);
+void scx_post_fork(struct task_struct *p);
+void scx_cancel_fork(struct task_struct *p);
+void init_sched_ext_class(void);
+
+static inline const struct sched_class *next_active_class(const struct sched_class *class)
+{
+	class++;
+	if (!scx_enabled() && class == &ext_sched_class)
+		class++;
+	return class;
+}
+
+#define for_active_class_range(class, _from, _to)				\
+	for (class = (_from); class != (_to); class = next_active_class(class))
+
+#define for_each_active_class(class)						\
+	for_active_class_range(class, __sched_class_highest, __sched_class_lowest)
+
+/*
+ * SCX requires a balance() call before every pick_next_task() call including
+ * when waking up from idle.
+ */
+#define for_balance_class_range(class, prev_class, end_class)			\
+	for_active_class_range(class, (prev_class) > &ext_sched_class ?		\
+			       &ext_sched_class : (prev_class), (end_class))
+
 #else	/* CONFIG_SCHED_CLASS_EXT */
 
 #define scx_enabled()		false
@@ -18,7 +105,13 @@ static inline void init_sched_ext_class(void) {}
 #endif	/* CONFIG_SCHED_CLASS_EXT */
 
 #if defined(CONFIG_SCHED_CLASS_EXT) && defined(CONFIG_SMP)
-#error "NOT IMPLEMENTED YET"
+void __scx_update_idle(struct rq *rq, bool idle);
+
+static inline void scx_update_idle(struct rq *rq, bool idle)
+{
+	if (scx_enabled())
+		__scx_update_idle(rq, idle);
+}
 #else
 static inline void scx_update_idle(struct rq *rq, bool idle) {}
 #endif
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d57d17d8ea6b..7778f4ce6b5b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -185,6 +185,10 @@ static inline int idle_policy(int policy)
 
 static inline int normal_policy(int policy)
 {
+#ifdef CONFIG_SCHED_CLASS_EXT
+	if (policy == SCHED_EXT)
+		return true;
+#endif
 	return policy == SCHED_NORMAL;
 }
 
@@ -680,6 +684,14 @@ struct cfs_rq {
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 };
 
+#ifdef CONFIG_SCHED_CLASS_EXT
+struct scx_rq {
+	struct scx_dispatch_q	local_dsq;
+	u64			ops_qseq;
+	u32			nr_running;
+};
+#endif /* CONFIG_SCHED_CLASS_EXT */
+
 static inline int rt_bandwidth_enabled(void)
 {
 	return sysctl_sched_rt_runtime >= 0;
@@ -1021,6 +1033,9 @@ struct rq {
 	struct cfs_rq		cfs;
 	struct rt_rq		rt;
 	struct dl_rq		dl;
+#ifdef CONFIG_SCHED_CLASS_EXT
+	struct scx_rq		scx;
+#endif
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	/* list of leaf cfs_rq on this CPU: */
-- 
2.39.1


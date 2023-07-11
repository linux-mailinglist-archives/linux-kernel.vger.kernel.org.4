Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FD474E34B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 03:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjGKBRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 21:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjGKBQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 21:16:48 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827001987;
        Mon, 10 Jul 2023 18:16:00 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1b0138963ffso4829639fac.0;
        Mon, 10 Jul 2023 18:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689038121; x=1691630121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GWMHTb2erharB+SCyjsPcfs+pv/YGBqrF6kx16ZL8E4=;
        b=DIhJVIEpuI/38oBL6Z6hf1JI53KEIkdZnZ2j/oadgwOD1oMKIm9/luhfNu3RvBgYKQ
         SzAHD0qbR965xaNm/c4xn9MWoiylLxWqpKfqP5fV6xbEv6Hw4JaJ/UYTEg4O/NsA04WQ
         xR73oRPiA6S7zEqe5q2tGtQh7i4sdyN0X5IFJeGX+TtCCD0MeDd8t5n427/tnHMI9IH+
         FWTyasjOIiTIY3AgdtA8IlDh530ou8Tmlwt3LOLqZJ//uABF0g4+UoVbZd6tXngi9DDI
         pp5K7z+NidC1fVWJ6hjWIdk30oeil9+2tHuRboRjbbekce/6kGSNn5xY1JYBlZpQpAJO
         wfRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689038121; x=1691630121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GWMHTb2erharB+SCyjsPcfs+pv/YGBqrF6kx16ZL8E4=;
        b=f9w/gsIJqkf2nr0fcOJv2YKoakTvRlR8ovUdIYJ5uFIyqoE3LivuAyRz1wnPkZOtmZ
         IOcasm5pf9JsaY1uGK64QxVjkvVTdLuY8UEiDRyVEvuyXSUrHgVTlt73h/aQj2SoM5G6
         A3IEoQXYC66LjSPTX2NAvBy4xW68iej92VTpIZWtbt89l6g3JFL/vCZWUe/blANq7Dt2
         IKSb+48GM1Klt/OFBVuc7R3keOABpzCzb7k3WIKDPJF+SnX4LSkST5h/ySl7hSxDiXTc
         HsjgNhBV+CZaCWHQDDNkRVK/iaVCqM2uT10AmX3waFlvIrSlb0vZUlxRQvZBTyo31V67
         YWpQ==
X-Gm-Message-State: ABy/qLYXPmrNlcSONeg2HOtfrYVR6dGV2b/0SloDmmLCAOP+QPOhp8UI
        ja9yNmnepeMWDGULMCE6Rco=
X-Google-Smtp-Source: APBJJlFV73O1BYDU+iKHXxxjPhnwRTqqOULI+VoGkE3hNrJRTyacYPDNvDe6Hf1R8a7OEl5VsAhQYQ==
X-Received: by 2002:a05:6870:4213:b0:1b0:648a:d9fa with SMTP id u19-20020a056870421300b001b0648ad9famr16578142oac.29.1689038120571;
        Mon, 10 Jul 2023 18:15:20 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:e2fe])
        by smtp.gmail.com with ESMTPSA id g12-20020a63ad0c000000b00553d42a7cb5sm311845pgf.68.2023.07.10.18.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 18:15:20 -0700 (PDT)
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
        kernel-team@meta.com, Tejun Heo <tj@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 32/34] sched_ext: Documentation: scheduler: Document extensible scheduler class
Date:   Mon, 10 Jul 2023 15:13:50 -1000
Message-ID: <20230711011412.100319-33-tj@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230711011412.100319-1-tj@kernel.org>
References: <20230711011412.100319-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Documentation/scheduler/sched-ext.rst which gives a high-level overview
and pointers to the examples.

v3: * Added tools/sched_ext/README.

    * Dropped _example prefix from scheduler names.

v2: * Apply minor edits suggested by Bagas. Caveats section dropped as all
      of them are addressed.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/scheduler/index.rst     |   1 +
 Documentation/scheduler/sched-ext.rst | 229 ++++++++++++++++++++++
 include/linux/sched/ext.h             |   2 +
 kernel/Kconfig.preempt                |   2 +
 kernel/sched/ext.c                    |   2 +
 kernel/sched/ext.h                    |   2 +
 tools/sched_ext/README                | 264 ++++++++++++++++++++++++++
 7 files changed, 502 insertions(+)
 create mode 100644 Documentation/scheduler/sched-ext.rst
 create mode 100644 tools/sched_ext/README

diff --git a/Documentation/scheduler/index.rst b/Documentation/scheduler/index.rst
index 3170747226f6..0b650bb550e6 100644
--- a/Documentation/scheduler/index.rst
+++ b/Documentation/scheduler/index.rst
@@ -19,6 +19,7 @@ Scheduler
     sched-nice-design
     sched-rt-group
     sched-stats
+    sched-ext
     sched-debug
 
     text_files
diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
new file mode 100644
index 000000000000..25ddb535c297
--- /dev/null
+++ b/Documentation/scheduler/sched-ext.rst
@@ -0,0 +1,229 @@
+==========================
+Extensible Scheduler Class
+==========================
+
+sched_ext is a scheduler class whose behavior can be defined by a set of BPF
+programs - the BPF scheduler.
+
+* sched_ext exports a full scheduling interface so that any scheduling
+  algorithm can be implemented on top.
+
+* The BPF scheduler can group CPUs however it sees fit and schedule them
+  together, as tasks aren't tied to specific CPUs at the time of wakeup.
+
+* The BPF scheduler can be turned on and off dynamically anytime.
+
+* The system integrity is maintained no matter what the BPF scheduler does.
+  The default scheduling behavior is restored anytime an error is detected,
+  a runnable task stalls, or on invoking the SysRq key sequence
+  :kbd:`SysRq-S`.
+
+Switching to and from sched_ext
+===============================
+
+``CONFIG_SCHED_CLASS_EXT`` is the config option to enable sched_ext and
+``tools/sched_ext`` contains the example schedulers.
+
+sched_ext is used only when the BPF scheduler is loaded and running.
+
+If a task explicitly sets its scheduling policy to ``SCHED_EXT``, it will be
+treated as ``SCHED_NORMAL`` and scheduled by CFS until the BPF scheduler is
+loaded. On load, such tasks will be switched to and scheduled by sched_ext.
+
+The BPF scheduler can choose to schedule all normal and lower class tasks by
+calling ``scx_bpf_switch_all()`` from its ``init()`` operation. In this
+case, all ``SCHED_NORMAL``, ``SCHED_BATCH``, ``SCHED_IDLE`` and
+``SCHED_EXT`` tasks are scheduled by sched_ext. In the example schedulers,
+this mode can be selected with the ``-a`` option.
+
+Terminating the sched_ext scheduler program, triggering :kbd:`SysRq-S`, or
+detection of any internal error including stalled runnable tasks aborts the
+BPF scheduler and reverts all tasks back to CFS.
+
+.. code-block:: none
+
+    # make -j16 -C tools/sched_ext
+    # tools/sched_ext/scx_simple
+    local=0 global=3
+    local=5 global=24
+    local=9 global=44
+    local=13 global=56
+    local=17 global=72
+    ^CEXIT: BPF scheduler unregistered
+
+If ``CONFIG_SCHED_DEBUG`` is set, the current status of the BPF scheduler
+and whether a given task is on sched_ext can be determined as follows:
+
+.. code-block:: none
+
+    # cat /sys/kernel/debug/sched/ext
+    ops                           : simple
+    enabled                       : 1
+    switching_all                 : 1
+    switched_all                  : 1
+    enable_state                  : enabled
+
+    # grep ext /proc/self/sched
+    ext.enabled                                  :                    1
+
+The Basics
+==========
+
+Userspace can implement an arbitrary BPF scheduler by loading a set of BPF
+programs that implement ``struct sched_ext_ops``. The only mandatory field
+is ``ops.name`` which must be a valid BPF object name. All operations are
+optional. The following modified excerpt is from
+``tools/sched/scx_simple.bpf.c`` showing a minimal global FIFO scheduler.
+
+.. code-block:: c
+
+    s32 BPF_STRUCT_OPS(simple_init)
+    {
+            if (!switch_partial)
+                    scx_bpf_switch_all();
+            return 0;
+    }
+
+    void BPF_STRUCT_OPS(simple_enqueue, struct task_struct *p, u64 enq_flags)
+    {
+            if (enq_flags & SCX_ENQ_LOCAL)
+                    scx_bpf_dispatch(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, enq_flags);
+            else
+                    scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+    }
+
+    void BPF_STRUCT_OPS(simple_exit, struct scx_exit_info *ei)
+    {
+            exit_type = ei->type;
+    }
+
+    SEC(".struct_ops")
+    struct sched_ext_ops simple_ops = {
+            .enqueue                = (void *)simple_enqueue,
+            .init                   = (void *)simple_init,
+            .exit                   = (void *)simple_exit,
+            .name                   = "simple",
+    };
+
+Dispatch Queues
+---------------
+
+To match the impedance between the scheduler core and the BPF scheduler,
+sched_ext uses DSQs (dispatch queues) which can operate as both a FIFO and a
+priority queue. By default, there is one global FIFO (``SCX_DSQ_GLOBAL``),
+and one local dsq per CPU (``SCX_DSQ_LOCAL``). The BPF scheduler can manage
+an arbitrary number of dsq's using ``scx_bpf_create_dsq()`` and
+``scx_bpf_destroy_dsq()``.
+
+A CPU always executes a task from its local DSQ. A task is "dispatched" to a
+DSQ. A non-local DSQ is "consumed" to transfer a task to the consuming CPU's
+local DSQ.
+
+When a CPU is looking for the next task to run, if the local DSQ is not
+empty, the first task is picked. Otherwise, the CPU tries to consume the
+global DSQ. If that doesn't yield a runnable task either, ``ops.dispatch()``
+is invoked.
+
+Scheduling Cycle
+----------------
+
+The following briefly shows how a waking task is scheduled and executed.
+
+1. When a task is waking up, ``ops.select_cpu()`` is the first operation
+   invoked. This serves two purposes. First, CPU selection optimization
+   hint. Second, waking up the selected CPU if idle.
+
+   The CPU selected by ``ops.select_cpu()`` is an optimization hint and not
+   binding. The actual decision is made at the last step of scheduling.
+   However, there is a small performance gain if the CPU
+   ``ops.select_cpu()`` returns matches the CPU the task eventually runs on.
+
+   A side-effect of selecting a CPU is waking it up from idle. While a BPF
+   scheduler can wake up any cpu using the ``scx_bpf_kick_cpu()`` helper,
+   using ``ops.select_cpu()`` judiciously can be simpler and more efficient.
+
+   Note that the scheduler core will ignore an invalid CPU selection, for
+   example, if it's outside the allowed cpumask of the task.
+
+2. Once the target CPU is selected, ``ops.enqueue()`` is invoked. It can
+   make one of the following decisions:
+
+   * Immediately dispatch the task to either the global or local DSQ by
+     calling ``scx_bpf_dispatch()`` with ``SCX_DSQ_GLOBAL`` or
+     ``SCX_DSQ_LOCAL``, respectively.
+
+   * Immediately dispatch the task to a custom DSQ by calling
+     ``scx_bpf_dispatch()`` with a DSQ ID which is smaller than 2^63.
+
+   * Queue the task on the BPF side.
+
+3. When a CPU is ready to schedule, it first looks at its local DSQ. If
+   empty, it then looks at the global DSQ. If there still isn't a task to
+   run, ``ops.dispatch()`` is invoked which can use the following two
+   functions to populate the local DSQ.
+
+   * ``scx_bpf_dispatch()`` dispatches a task to a DSQ. Any target DSQ can
+     be used - ``SCX_DSQ_LOCAL``, ``SCX_DSQ_LOCAL_ON | cpu``,
+     ``SCX_DSQ_GLOBAL`` or a custom DSQ. While ``scx_bpf_dispatch()``
+     currently can't be called with BPF locks held, this is being worked on
+     and will be supported. ``scx_bpf_dispatch()`` schedules dispatching
+     rather than performing them immediately. There can be up to
+     ``ops.dispatch_max_batch`` pending tasks.
+
+   * ``scx_bpf_consume()`` tranfers a task from the specified non-local DSQ
+     to the dispatching DSQ. This function cannot be called with any BPF
+     locks held. ``scx_bpf_consume()`` flushes the pending dispatched tasks
+     before trying to consume the specified DSQ.
+
+4. After ``ops.dispatch()`` returns, if there are tasks in the local DSQ,
+   the CPU runs the first one. If empty, the following steps are taken:
+
+   * Try to consume the global DSQ. If successful, run the task.
+
+   * If ``ops.dispatch()`` has dispatched any tasks, retry #3.
+
+   * If the previous task is an SCX task and still runnable, keep executing
+     it (see ``SCX_OPS_ENQ_LAST``).
+
+   * Go idle.
+
+Note that the BPF scheduler can always choose to dispatch tasks immediately
+in ``ops.enqueue()`` as illustrated in the above simple example. If only the
+built-in DSQs are used, there is no need to implement ``ops.dispatch()`` as
+a task is never queued on the BPF scheduler and both the local and global
+DSQs are consumed automatically.
+
+``scx_bpf_dispatch()`` queues the task on the FIFO of the target DSQ. Use
+``scx_bpf_dispatch_vtime()`` for the priority queue. See the function
+documentation and usage in ``tools/sched_ext/scx_simple.bpf.c`` for more
+information.
+
+Where to Look
+=============
+
+* ``include/linux/sched/ext.h`` defines the core data structures, ops table
+  and constants.
+
+* ``kernel/sched/ext.c`` contains sched_ext core implementation and helpers.
+  The functions prefixed with ``scx_bpf_`` can be called from the BPF
+  scheduler.
+
+* ``tools/sched_ext/`` hosts example BPF scheduler implementations.
+
+  * ``scx_simple[.bpf].c``: Minimal global FIFO scheduler example using a
+    custom DSQ.
+
+  * ``scx_qmap[.bpf].c``: A multi-level FIFO scheduler supporting five
+    levels of priority implemented with ``BPF_MAP_TYPE_QUEUE``.
+
+ABI Instability
+===============
+
+The APIs provided by sched_ext to BPF schedulers programs have no stability
+guarantees. This includes the ops table callbacks and constants defined in
+``include/linux/sched/ext.h``, as well as the ``scx_bpf_`` kfuncs defined in
+``kernel/sched/ext.c``.
+
+While we will attempt to provide a relatively stable API surface when
+possible, they are subject to change without warning between kernel
+versions.
diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 446821073bd1..26537b2f6c95 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -1,5 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
+ * BPF extensible scheduler class: Documentation/scheduler/sched-ext.rst
+ *
  * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
  * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
  * Copyright (c) 2022 David Vernet <dvernet@meta.com>
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index e12a057ead7b..bae49b743834 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -154,3 +154,5 @@ config SCHED_CLASS_EXT
 	  wish to implement scheduling policies. The struct_ops structure
 	  exported by sched_ext is struct sched_ext_ops, and is conceptually
 	  similar to struct sched_class.
+
+	  See Documentation/scheduler/sched-ext.rst for more details.
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 44ba457263bd..0db6d400d340 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1,5 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
+ * BPF extensible scheduler class: Documentation/scheduler/sched-ext.rst
+ *
  * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
  * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
  * Copyright (c) 2022 David Vernet <dvernet@meta.com>
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index 821515bb6580..405037a4e6ce 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -1,5 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
+ * BPF extensible scheduler class: Documentation/scheduler/sched-ext.rst
+ *
  * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
  * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
  * Copyright (c) 2022 David Vernet <dvernet@meta.com>
diff --git a/tools/sched_ext/README b/tools/sched_ext/README
new file mode 100644
index 000000000000..33f413f8a403
--- /dev/null
+++ b/tools/sched_ext/README
@@ -0,0 +1,264 @@
+		============================
+		SCHED_EXT EXAMPLE SCHEDULERS
+		============================
+
+Introduction
+============
+
+This directory contains a number of example sched_ext schedulers. These
+schedulers are meant to provide examples of different types of schedulers
+that can be built using sched_ext, and illustrate how various features of
+sched_ext can be used.
+
+Some of the examples are performant, production-ready schedulers. That is, for
+the correct workload and with the correct tuning, they may be deployed in a
+production environment with acceptable or possibly even improved performance.
+Others are just examples that in practice, would not provide acceptable
+performance (though they could be improved to get there).
+
+This README will describe these example schedulers, including describing the
+types of workloads or scenarios they're designed to accommodate, and whether or
+not they're production ready. For more details on any of these schedulers,
+please see the header comment in their .bpf.c file.
+
+
+Compiling the examples
+======================
+
+There are a few toolchain dependencies for compiling the example schedulers.
+
+Toolchain dependencies
+----------------------
+
+1. clang >= 17.0
+
+The schedulers are BPF programs, and therefore must be compiled with clang. gcc
+is actively working on adding a BPF backend compiler as well, but are still
+missing some features such as BTF type tags which are necessary for using
+kptrs.
+
+clang 17.0 has not yet been released, so you'll need to compile it yourself if
+you want to compile the benchmarks.
+
+2. rustup nightly
+
+Atropos's user space load balancing component is written in Rust, and uses
+nightly features. You'll need to use the nightly build from rustup in order to
+compile it.
+
+There are other requirements as well, such as make, but these are the main /
+non-trivial ones.
+
+Compiling the schedulers
+------------------------
+
+Once you have your toolchain setup, you can compile the schedulers as follows:
+
+$ make CC=clang LLVM=1 -j
+
+See Documentation/scheduler/sched-ext.rst for a description of the config
+options required to compile a sched_ext kernel.
+
+Schedulers
+==========
+
+This section lists, in alphabetical order, all of the current example
+schedulers.
+
+--------------------------------------------------------------------------------
+
+Atropos
+-------
+
+Overview
+~~~~~~~~
+
+A multi-domain, BPF / user space hybrid scheduler. The BPF portion of the
+scheduler does a simple round robin in each domain, and the user space portion
+(written in Rust) calculates the load factor of each domain, and informs BPF of
+how tasks should be load balanced accordingly.
+
+Typical Use Case
+~~~~~~~~~~~~~~~~
+
+Atropos is designed to be flexible, and accommodate different architectures and
+workloads. Various load balancing thresholds (e.g. greediness, frequenty, etc),
+as well as how Atropos should partition the system into scheduling domains, can
+be tuned to achieve the optimal configuration for any given system or workload.
+
+Production Ready?
+~~~~~~~~~~~~~~~~~
+
+Yes. If tuned correctly, Atropos should be performant across various CPU
+architectures and workloads.
+
+--------------------------------------------------------------------------------
+
+scx_central
+-----------
+
+Overview
+~~~~~~~~
+
+A "central" scheduler where scheduling decisions are made from a single CPU.
+This scheduler illustrates how scheduling decisions can be dispatched from a
+single CPU, allowing other cores to run with infinite slices, without timer
+ticks, and without having to incur the overhead of making scheduling decisions.
+
+Typical Use Case
+~~~~~~~~~~~~~~~~
+
+This scheduler could theoretically be useful for any workload that benefits
+from minimizing scheduling overhead and timer ticks. An example of where this
+could be particularly useful is running VMs, where running with infinite slices
+and no timer ticks allows the VM to avoid unnecessary expensive vmexits.
+
+Production Ready?
+~~~~~~~~~~~~~~~~~
+
+Not yet. While tasks are run with an infinite slice (SCX_SLICE_INF), they're
+preempted every 20ms in a timer callback. The scheduler also puts the core
+schedling logic inside of the central / scheduling CPU's ops.dispatch() path,
+and does not yet have any kind of priority mechanism.
+
+--------------------------------------------------------------------------------
+
+scx_flatcg
+----------
+
+Overview
+~~~~~~~~
+
+A flattened cgroup hierarchy scheduler. This scheduler implements hierarchical
+weight-based cgroup CPU control by flattening the cgroup hierarchy into a
+single layer, by compounding the active weight share at each level. The effect
+of this is a much more performant CPU controller, which does not need to
+descend down cgroup trees in order to properly compute a cgroup's share.
+
+Typical Use Case
+~~~~~~~~~~~~~~~~
+
+This scheduler could be useful for any typical workload requiring a CPU
+controller, but which cannot tolerate the higher overheads of the fair CPU
+controller.
+
+Production Ready?
+~~~~~~~~~~~~~~~~~
+
+Yes, though the scheduler (currently) does not adequately accommodate
+thundering herds of cgroups. If, for example, many cgroups which are nested
+behind a low-priority cgroup were to wake up around the same time, they may be
+able to consume more CPU cycles than they are entitled to.
+
+--------------------------------------------------------------------------------
+
+scx_pair
+--------
+
+Overview
+~~~~~~~~
+
+A sibling scheduler which ensures that tasks will only ever be co-located on a
+physical core if they're in the same cgroup. It illustrates how a scheduling
+policy could be implemented to mitigate CPU bugs, such as L1TF, and also shows
+how some useful kfuncs such as scx_bpf_kick_cpu() can be utilized.
+
+Typical Use Case
+~~~~~~~~~~~~~~~~
+
+While this scheduler is only meant to be used to illustrate certain sched_ext
+features, with a bit more work (e.g. by adding some form of priority handling
+inside and across cgroups), it could have been used as a way to quickly
+mitigate L1TF before core scheduling was implemented and rolled out.
+
+Production Ready?
+~~~~~~~~~~~~~~~~~
+
+No
+
+--------------------------------------------------------------------------------
+
+scx_qmap
+--------
+
+Overview
+~~~~~~~~
+
+Another simple, yet slightly more complex scheduler that provides an example of
+a basic weighted FIFO queuing policy. It also provides examples of some common
+useful BPF features, such as sleepable per-task storage allocation in the
+ops.prep_enable() callback, and using the BPF_MAP_TYPE_QUEUE map type to
+enqueue tasks. It also illustrates how core-sched support could be implemented.
+
+Typical Use Case
+~~~~~~~~~~~~~~~~
+
+Purely used to illustrate sched_ext features.
+
+**Production Ready?**
+
+No
+
+--------------------------------------------------------------------------------
+
+scx_simple
+----------
+
+Overview
+~~~~~~~~
+
+A simple scheduler that provides an example of a minimal sched_ext
+scheduler. scx_simple can be run in either global weighted vtime mode, or
+FIFO mode.
+
+Typical Use Case
+~~~~~~~~~~~~~~~~
+
+Though very simple, this scheduler should perform reasonably well on
+single-socket CPUs with a uniform L3 cache topology. Note that while running in
+global FIFO mode may work well for some workloads, saturating threads can
+easily drown out inactive ones.
+
+Production Ready?
+~~~~~~~~~~~~~~~~~
+
+This scheduler could be used in a production environment, assuming the hardware
+constraints enumerated above, and assuming the workload can accommodate a
+simple scheduling policy.
+
+--------------------------------------------------------------------------------
+
+scx_userland
+------------
+
+Overview
+~~~~~~~~
+
+A simple weighted vtime scheduler where all scheduling decisions take place in
+user space. This is in contrast to Atropos, where load balancing lives in user
+space, but scheduling decisions are still made in the kernel.
+
+Typical Use Case
+~~~~~~~~~~~~~~~~
+
+There are many advantages to writing schedulers in user space. For example, you
+can use a debugger, you can write the scheduler in Rust, and you can use data
+structures bundled with your favorite library.
+
+On the other hand, user space scheduling can be hard to get right. You can
+potentially deadlock due to not scheduling a task that's required for the
+scheduler itself to make forward progress (though the sched_ext watchdog will
+protect the system by unloading your scheduler after a timeout if that
+happens). You also have to bootstrap some communication protocol between the
+kernel and user space.
+
+A more robust solution to this would be building a user space scheduling
+framework that abstracts much of this complexity away from you.
+
+Production Ready?
+~~~~~~~~~~~~~~~~~
+
+No. This scheduler uses an ordered list for vtime scheduling, and is stricly
+less performant than just using something like `scx_simple`. It is purely
+meant to illustrate that it's possible to build a user space scheduler on
+top of sched_ext.
-- 
2.41.0


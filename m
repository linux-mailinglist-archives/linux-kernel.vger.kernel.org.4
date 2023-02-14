Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0753E696E2D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 20:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjBNTy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 14:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjBNTy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 14:54:56 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674672BF23;
        Tue, 14 Feb 2023 11:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1676404490;
        bh=VZgMqbpuN8icc1VuEtFjED8s4IZn2yWNHRHM+afa/SM=;
        h=From:To:Cc:Subject:Date:From;
        b=JYm98GIx1WYM9JC4LwZ3TXKVzYKqv/H4mG9by8X5DEMxO6OLpN4vTHjIJlTeSdMeu
         rbdhjIeEnoorF8OAwlXIUSs9VO4EHr/jS4GRiR41AG3Vd2XM/dHs7BgLRmnbmI0fJn
         OnG1vsnS58UBby90B3PfC7qhYzUk56kiC0vDFa4AFzHLxI5R5bELr0avtmoQUffeuj
         CTXaWLV3PR64znoBkRsR6etWGtOqn5iK6SIUztCmPwqfCfIAXvVTq2tUCjc/znVWme
         r8IqaCeb10sUby5LVkbo4Psk5pU3CPv365+rv20fqy3OwDmmtUiUHIB/qKFPEfEZuW
         to2azBv8prlCQ==
Received: from thinkos.internal.efficios.com (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4PGX3t3LpQzlnq;
        Tue, 14 Feb 2023 14:54:50 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Alejandro Colomar <alx.manpages@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 1/1] rseq.2: New man page for the rseq(2) API
Date:   Tue, 14 Feb 2023 14:54:42 -0500
Message-Id: <20230214195442.937586-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 man2/rseq.2 | 465 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 465 insertions(+)
 create mode 100644 man2/rseq.2

diff --git a/man2/rseq.2 b/man2/rseq.2
new file mode 100644
index 000000000..ad3215d1c
--- /dev/null
+++ b/man2/rseq.2
@@ -0,0 +1,465 @@
+.\" Copyright 2015-2023 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+.\"
+.\" SPDX-License-Identifier: Linux-man-pages-copyleft
+.\"
+.TH rseq 2 (date) "Linux man-pages (unreleased)"
+.SH NAME
+rseq \- restartable sequences system call
+.SH LIBRARY
+Standard C library
+.RI ( libc ", " \-lc )
+.SH SYNOPSIS
+.nf
+.PP
+.BR "#include <linux/rseq.h>" "       /* Definition of " RSEQ_* " constants */"
+.BR "#include <sys/syscall.h>" "      /* Definition of " SYS_* " constants */"
+.B #include <unistd.h>
+.PP
+.BI "int syscall(SYS_rseq, struct rseq *" rseq ", uint32_t " rseq_len ,
+.BI "            int " flags ", uint32_t " sig );
+.fi
+.PP
+.IR Note :
+glibc provides no wrapper for
+.BR rseq (),
+necessitating the use of
+.BR syscall (2).
+.SH DESCRIPTION
+The
+.BR rseq ()
+ABI accelerates specific user-space operations by registering a
+per-thread data structure shared between kernel and user-space.
+This data structure can be read from or written to by user-space to skip
+otherwise expensive system calls.
+.PP
+A restartable sequence is a sequence of instructions
+guaranteed to be executed atomically with respect to
+other threads and signal handlers on the current CPU.
+If its execution does not complete atomically,
+the kernel changes the execution flow by jumping to an abort handler
+defined by user-space for that restartable sequence.
+.PP
+Using restartable sequences requires to register a
+.BR rseq ()
+ABI per-thread data structure
+.RB ( "struct rseq" )
+through the
+.BR rseq ()
+system call.
+Only one
+.BR rseq ()
+ABI can be registered per thread, so user-space libraries and
+applications must follow a user-space ABI defining how to share this
+resource.
+The ABI defining how to share this resource between applications and
+libraries is defined by the C library.
+Allocation of the per-thread
+.BR rseq ()
+ABI and its registration to the kernel is handled by glibc since version
+2.35.
+.PP
+The
+.BR rseq ()
+ABI per-thread data structure contains a
+.I rseq_cs
+field which points to the currently executing critical section.
+For each thread, a single rseq critical section can run at any given
+point.
+Each critical section need to be implemented in assembly.
+.PP
+The
+.BR rseq ()
+ABI accelerates user-space operations on per-cpu data by defining a
+shared data structure ABI between each user-space thread and the kernel.
+.PP
+It allows user-space to perform update operations on per-cpu data
+without requiring heavy-weight atomic operations.
+.PP
+The term CPU used in this documentation refers to a hardware execution
+context.
+For instance, each CPU number returned by
+.BR sched_getcpu ()
+is a CPU.
+The current CPU means to the CPU on which the registered thread is
+running.
+.PP
+Restartable sequences are atomic with respect to preemption (making it
+atomic with respect to other threads running on the same CPU),
+as well as signal delivery (user-space execution contexts nested over
+the same thread).
+They either complete atomically with respect to preemption on the
+current CPU and signal delivery, or they are aborted.
+.PP
+Restartable sequences are suited for update operations on per-cpu data.
+.PP
+Restartable sequences can be used on data structures shared between threads
+within a process,
+and on data structures shared between threads across different
+processes.
+.PP
+Some examples of operations that can be accelerated or improved by this ABI:
+.IP \(bu 3
+Memory allocator per-cpu free-lists,
+.IP \(bu 3
+Querying the current CPU number,
+.IP \(bu 3
+Incrementing per-CPU counters,
+.IP \(bu 3
+Modifying data protected by per-CPU spinlocks,
+.IP \(bu 3
+Inserting/removing elements in per-CPU linked-lists,
+.IP \(bu 3
+Writing/reading per-CPU ring buffers content.
+.IP \(bu 3
+Accurately reading performance monitoring unit counters with respect to
+thread migration.
+.PP
+Restartable sequences must not perform system calls.
+Doing so may result in termination of the process by a segmentation
+fault.
+.PP
+The
+.I rseq
+argument is a pointer to the thread-local
+.B struct rseq
+to be shared between kernel and user-space.
+.PP
+The structure
+.B struct rseq
+is an extensible structure.
+Additional feature fields can be added in future kernel versions.
+Its layout is as follows:
+.TP
+.B Structure alignment
+This structure is aligned on either 32-byte boundary,
+or on the alignment value returned by
+.IR getauxval ()
+invoked with
+.B AT_RSEQ_ALIGN
+if the structure size differs from 32 bytes.
+.TP
+.B Structure size
+This structure size needs to be at least 32 bytes.
+It can be either 32 bytes,
+or it needs to be large enough to hold the result of
+.IR getauxval ()
+invoked with
+.BR AT_RSEQ_FEATURE_SIZE .
+Its size is passed as parameter to the
+.BR rseq ()
+system call.
+.in +4n
+.IP
+.EX
+#include <linux/rseq.h>
+
+struct rseq {
+    __u32 cpu_id_start;
+    __u32 cpu_id;
+    union {
+        /* ... */
+    } rseq_cs;
+    __u32 flags;
+    __u32 node_id;
+    __u32 mm_cid;
+} __attribute__((aligned(32)));
+.EE
+.in
+.TP
+.B Fields
+.RS
+.TP
+.I cpu_id_start
+Always-updated value of the CPU number on which the registered thread is
+running.
+Its value is guaranteed to always be a possible CPU number,
+even when
+.BR rseq ()
+is not registered.
+Its value should always be confirmed by reading the cpu_id field before
+user-space performs any side-effect
+(e.g. storing to memory).
+.IP
+This field is always guaranteed to hold a valid CPU number in the range
+[ 0 ..  nr_possible_cpus - 1 ].
+It can therefore be loaded by user-space
+and used as an offset in per-cpu data structures
+without having to check whether its value is within the valid bounds
+compared to the number of possible CPUs in the system.
+.IP
+Initialized by user-space to a possible CPU number (e.g., 0),
+updated by the kernel for threads registered with
+.BR rseq ().
+.IP
+For user-space applications executed on a kernel without
+.BR rseq ()
+support,
+the cpu_id_start field stays initialized at 0,
+which is indeed a valid CPU number.
+It is therefore valid to use it as an offset in per-cpu data structures,
+and only validate whether it's actually the current CPU number by
+comparing it with the cpu_id field within the rseq critical section.
+If the kernel does not provide
+.BR rseq ()
+support, that cpu_id field stays initialized at -1,
+so the comparison always fails, as intended.
+.IP
+This field should only be read by the thread which registered this data
+structure.
+Aligned on 32-bit.
+.IP
+It is up to user space to implement a fall-back mechanism for scenarios where
+.BR rseq ()
+is not available.
+.TP
+.I cpu_id
+Always-updated value of the CPU number on which the registered thread is
+running.
+Initialized by user-space to -1,
+updated by the kernel for threads registered with
+.BR rseq ().
+.IP
+This field should only be read by the thread which registered this data
+structure.
+Aligned on 32-bit.
+.TP
+.I rseq_cs
+The rseq_cs field is a pointer to a
+.BR "struct rseq_cs" .
+Is is NULL when no rseq assembly block critical section is active for
+the registered thread.
+Setting it to point to a critical section descriptor
+.RB ( "struct rseq_cs")
+marks the beginning of the critical section.
+.IP
+Initialized by user-space to NULL.
+.IP
+Updated by user-space, which sets the address of the currently
+active rseq_cs at the beginning of assembly instruction sequence
+block,
+and set to NULL by the kernel when it restarts an assembly instruction
+sequence block,
+as well as when the kernel detects that it is preempting or delivering a
+signal outside of the range targeted by the rseq_cs.
+Also needs to be set to NULL by user-space before reclaiming memory that
+contains the targeted
+.BR "struct rseq_cs" .
+.IP
+Read and set by the kernel.
+.IP
+This field should only be updated by the thread which registered this
+data structure.
+Aligned on 64-bit.
+.TP
+.I flags
+Flags indicating the restart behavior for the registered thread.
+This is mainly used for debugging purposes.
+Can be a combination of:
+.RS
+.TP
+.B RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT
+Inhibit instruction sequence block restart on preemption for this
+thread.
+This flag is deprecated since Linux 6.1.
+.TP
+.B RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL
+Inhibit instruction sequence block restart on signal delivery for this
+thread.
+This flag is deprecated since Linux 6.1.
+.TP
+.B RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE
+Inhibit instruction sequence block restart on migration for this thread.
+This flag is deprecated since Linux 6.1.
+.RE
+.IP
+Initialized by user-space, used by the kernel.
+.TP
+.I node_id
+Always-updated value of the current NUMA node ID.
+.IP
+Initialized by user-space to 0.
+.IP
+Updated by the kernel.
+Read by user-space with single-copy atomicity semantics.
+This field should only be read by the thread which registered
+this data structure.
+Aligned on 32-bit.
+.TP
+.I mm_cid
+Contains the current thread's concurrency ID
+(allocated uniquely within a memory map).
+.IP
+Updated by the kernel.
+Read by user-space with single-copy atomicity semantics.
+This field should only be read by the thread which registered this data
+structure.
+Aligned on 32-bit.
+.IP
+This concurrency ID is within the possible cpus range,
+and is temporarily (and uniquely) assigned while threads are actively
+running within a memory map.
+If a memory map has fewer threads than cores,
+or is limited to run on few cores concurrently through sched affinity or
+cgroup cpusets,
+the concurrency IDs will be values close to 0,
+thus allowing efficient use of user-space memory for per-cpu data
+structures.
+.RE
+.PP
+The layout of
+.B struct rseq_cs
+version 0 is as follows:
+.TP
+.B Structure alignment
+This structure is aligned on 32-byte boundary.
+.TP
+.B Structure size
+This structure has a fixed size of 32 bytes.
+.in +4n
+.IP
+.EX
+#include <linux/rseq.h>
+
+struct rseq_cs {
+    __u32   version;
+    __u32   flags;
+    __u64   start_ip;
+    __u64   post_commit_offset;
+    __u64   abort_ip;
+} __attribute__((aligned(32)));
+.EE
+.in
+.TP
+.B Fields
+.RS
+.TP
+.I version
+Version of this structure.
+Should be initialized to 0.
+.TP
+.I flags
+.RS
+Flags indicating the restart behavior of this structure.
+Can be a combination of:
+.TP
+.B RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT
+Inhibit instruction sequence block restart on preemption for this
+critical section.
+This flag is deprecated since Linux 6.1.
+.TP
+.B RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL
+Inhibit instruction sequence block restart on signal delivery for this
+critical section.
+This flag is deprecated since Linux 6.1.
+.TP
+.B RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE
+Inhibit instruction sequence block restart on migration for this
+critical section.
+This flag is deprecated since Linux 6.1.
+.RE
+.TP
+.I start_ip
+Instruction pointer address of the first instruction of the sequence of
+consecutive assembly instructions.
+.TP
+.I post_commit_offset
+Offset (from start_ip address) of the address after the last instruction
+of the sequence of consecutive assembly instructions.
+.TP
+.I abort_ip
+Instruction pointer address where to move the execution flow in case of
+abort of the sequence of consecutive assembly instructions.
+.RE
+.PP
+The
+.I rseq_len
+argument is the size of the
+.B struct rseq
+to register.
+.PP
+The
+.I flags
+argument is 0 for registration, and
+.B RSEQ_FLAG_UNREGISTER
+for unregistration.
+.PP
+The
+.I sig
+argument is the 32-bit signature to be expected before the abort
+handler code.
+.PP
+A single library per process should keep the
+.B struct rseq
+in a per-thread data structure.
+The
+.I cpu_id
+field should be initialized to -1, and the
+.I cpu_id_start
+field should be initialized to a possible CPU value (typically 0).
+.PP
+Each thread is responsible for registering and unregistering its
+.BR "struct rseq" .
+No more than one
+.B struct rseq
+address can be registered per thread at a given time.
+.PP
+Reclaim of
+.B struct rseq
+object's memory must only be done after either an explicit rseq
+unregistration is performed or after the thread exits.
+.PP
+In a typical usage scenario, the thread registering the
+.B struct rseq
+will be performing loads and stores from/to that structure.
+It is however also allowed to read that structure from other threads.
+The
+.B struct rseq
+field updates performed by the kernel provide relaxed atomicity
+semantics (atomic store, without memory ordering),
+which guarantee that other threads performing relaxed atomic reads
+(atomic load, without memory ordering) of the cpu number fields will
+always observe a consistent value.
+.SH RETURN VALUE
+A return value of 0 indicates success.
+On error, \-1 is returned, and
+.I errno
+is set appropriately.
+.SH ERRORS
+.TP
+.B EINVAL
+Either
+.I flags
+contains an invalid value, or
+.I rseq
+contains an address which is not appropriately aligned, or
+.I rseq_len
+contains an incorrect size.
+.TP
+.B ENOSYS
+The
+.BR rseq ()
+system call is not implemented by this kernel.
+.TP
+.B EFAULT
+.I rseq
+is an invalid address.
+.TP
+.B EBUSY
+Restartable sequence is already registered for this thread.
+.TP
+.B EPERM
+The
+.I sig
+argument on unregistration does not match the signature received
+on registration.
+.SH VERSIONS
+The
+.BR rseq ()
+system call was added in Linux 4.18.
+.SH STANDARDS
+.BR rseq ()
+is Linux-specific.
+.SH SEE ALSO
+.BR sched_getcpu (3) ,
+.BR membarrier (2) ,
+.BR getauxval (3)
-- 
2.30.2


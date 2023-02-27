Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA786A4BCC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 20:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjB0T4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 14:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjB0T4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 14:56:20 -0500
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7B528228;
        Mon, 27 Feb 2023 11:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1677527760;
        bh=fXYROZGirFu0E0AGmq0fzni7M06Y4AiSWJRUr/O6j+c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KhqXyu0pQHy5r/KjC7iCSrgQcxGm7IaODadv79/BwbzEBDWmsC9DO6IlSYQkJIIUa
         mlkOLmQ8zIWbCUXgMN/QcNpzf4NXD0472sTe/gZcqr0TquRYfBg1XiOI6FO4T2tFLh
         WK8Kop0kMhlDkOBfrFCZf/Bkaem3ZGqRPMaOsftvnxWpFKppwtNAdy5yLud5MrLSE5
         S//sSxkriIC+WJp9W8YXr9N+O75ut7o3hd3BVStJmqOI+nIOg2TK0l0sMh9gP/q482
         nJwbO2kPwX2PzQ9MegicBgtWweUz4zT4gXooZ895R8bHNoei1fzUqWFMdpDIUcWbz5
         Xd5kAU6Ou6dSA==
Received: from [172.16.0.188] (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4PQWTD46q0znd8;
        Mon, 27 Feb 2023 14:56:00 -0500 (EST)
Message-ID: <c9c6de36-ee6c-d633-0023-8723bf83007a@efficios.com>
Date:   Mon, 27 Feb 2023 14:56:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] rseq.2: New man page for the rseq(2) API
Content-Language: en-US
To:     Alex Colomar <alx.manpages@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        "linux-man @ vger . kernel . org" <linux-man@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
References: <20230215190858.958935-1-mathieu.desnoyers@efficios.com>
 <b59894e3-5a5e-0463-68ff-7dab0b3c5892@gmail.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <b59894e3-5a5e-0463-68ff-7dab0b3c5892@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-24 19:36, Alex Colomar wrote:
> Hi Mathieu,
> 
> On 2/15/23 20:08, Mathieu Desnoyers wrote:
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> ---
>>   man2/rseq.2 | 461 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 461 insertions(+)
>>   create mode 100644 man2/rseq.2
>>
>> diff --git a/man2/rseq.2 b/man2/rseq.2
>> new file mode 100644
>> index 000000000..1a7e4a893
>> --- /dev/null
>> +++ b/man2/rseq.2
>> @@ -0,0 +1,461 @@
>> +.\" Copyright 2015-2023 Mathieu Desnoyers 
>> <mathieu.desnoyers@efficios.com>
>> +.\"
>> +.\" SPDX-License-Identifier: Linux-man-pages-copyleft
>> +.\"
>> +.TH rseq 2 (date) "Linux man-pages (unreleased)"
>> +.SH NAME
>> +rseq \- restartable sequences system call
>> +.SH LIBRARY
>> +Standard C library
>> +.RI ( libc ", " \-lc )
>> +.SH SYNOPSIS
>> +.nf
>> +.PP
>> +.BR "#include <linux/rseq.h>" "       /* Definition of " RSEQ_* " 
>> constants */"
>> +.BR "#include <sys/syscall.h>" "      /* Definition of " SYS_* " 
>> constants */"
>> +.B #include <unistd.h>
>> +.PP
>> +.BI "int syscall(SYS_rseq, struct rseq *" rseq ", uint32_t " rseq_len ,
>> +.BI "            int " flags ", uint32_t " sig );
>> +.fi
>> +.PP
>> +.IR Note :
>> +glibc provides no wrapper for
>> +.BR rseq (),
>> +necessitating the use of
>> +.BR syscall (2).
>> +.SH DESCRIPTION
>> +The
>> +.BR rseq ()
>> +ABI accelerates specific user-space operations by registering a
>> +per-thread data structure shared between kernel and userspace.
> 
> s/userspace/user space/

ok

> 
>> +This data structure can be read from or written to by user-space to skip
> 
> s/user-space/user space/

ok

> 
>> +otherwise expensive system calls.
>> +.PP
>> +A restartable sequence is a sequence of instructions
>> +guaranteed to be executed atomically with respect to
>> +other threads and signal handlers on the current CPU.
>> +If its execution does not complete atomically,
>> +the kernel changes the execution flow by jumping to an abort handler
>> +defined by user-space for that restartable sequence.
> 
> s/user-space/user space/

ok

> 
>> +.PP
>> +Using restartable sequences requires to register a
>> +.BR rseq ()
>> +ABI per-thread data structure
>> +.RI ( "struct rseq" )
>> +through the
>> +.BR rseq ()
>> +system call.
>> +Only one
>> +.BR rseq ()
>> +ABI can be registered per thread,
>> +so user-space libraries and applications must follow a user-space ABI
>> +defining how to share this resource.
>> +The ABI defining how to share this resource between applications and
>> +libraries is defined by the C library.
> 
> Do you mean the standard C library (libc),
> or just an unspecified library?

What I mean here is that we expect the C library to implement this ABI.

Currently the GNU C library implements it, and other C libraries are 
expected to follow.

AFAIK this is not part of the standard C library specification though, 
so I suspect this falls under implementation-defined extension of 
specific C libraries ? Not sure how to phrase this accurately.

> 
>> +Allocation of the per-thread
>> +.BR rseq ()
>> +ABI and its registration to the kernel is handled by glibc since version
> 
> We say glibc 2.35 instead of version 2.35, so that it's easier to grep.
> Also, they should be connected by a single space in source code for the 
> same reason.
> 
> See commit b324e17d3208c940622ab192609b836928d5aa8d.

Updated:

Support for allocation of the per-thread
.BR rseq ()
ABI and its registration to the kernel is available since glibc 2.35.

> 
>> +2.35.
>> +.PP
>> +The
>> +.BR rseq ()
>> +ABI per-thread data structure contains a
>> +.I rseq_cs
>> +field which points to the currently executing critical section.
>> +For each thread, a single rseq critical section can run at any given
>> +point.
> 
> Please have another look regarding semantic newlines.  I'd prefer 
> breaking after commas, for example.

ok. Searched for ", " within the manual page and fixed a few spots where 
it makes more sense to insert a newline there.

> 
>> +Each critical section needs to be implemented in assembly.
>> +.PP
>> +The
>> +.BR rseq ()
>> +ABI accelerates user-space operations on per-cpu data by defining a
>> +shared data structure ABI between each user-space thread and the kernel.
>> +.PP
>> +It allows user-space to perform update operations on per-cpu data
>> +without requiring heavy-weight atomic operations.
>> +.PP
>> +The term CPU used in this documentation refers to a hardware execution
>> +context.
>> +For instance, each CPU number returned by
>> +.BR sched_getcpu ()
>> +is a CPU.
>> +The current CPU means to the CPU on which the registered thread is
> 
> s/means to/means/?

ok

> 
>> +running.
>> +.PP
>> +Restartable sequences are atomic with respect to preemption (making it
>> +atomic with respect to other threads running on the same CPU),
>> +as well as signal delivery (user-space execution contexts nested over
>> +the same thread).
>> +They either complete atomically with respect to preemption on the
>> +current CPU and signal delivery, or they are aborted.
>> +.PP
>> +Restartable sequences are suited for update operations on per-cpu data.
>> +.PP
>> +Restartable sequences can be used on data structures shared between 
>> threads
>> +within a process,
>> +and on data structures shared between threads across different
>> +processes.
>> +.PP
>> +Some examples of operations that can be accelerated or improved by 
>> this ABI:
>> +.IP \(bu 3
> 
> Please use \[bu] instead of \(bu.

ok

>> +Memory allocator per-cpu free-lists,
>> +.IP \(bu 3
>> +Querying the current CPU number,
>> +.IP \(bu 3
>> +Incrementing per-CPU counters,
>> +.IP \(bu 3
>> +Modifying data protected by per-CPU spinlocks,
>> +.IP \(bu 3
>> +Inserting/removing elements in per-CPU linked-lists,
>> +.IP \(bu 3
>> +Writing/reading per-CPU ring buffers content.
>> +.IP \(bu 3
>> +Accurately reading performance monitoring unit counters with respect to
>> +thread migration.
>> +.PP
>> +Restartable sequences must not perform system calls.
>> +Doing so may result in termination of the process by a segmentation
>> +fault.
>> +.PP
>> +The
>> +.I rseq
>> +argument is a pointer to the thread-local
>> +.I struct rseq
>> +to be shared between kernel and user-space.
>> +.PP
>> +The structure
>> +.I struct rseq
>> +is an extensible structure.
>> +Additional feature fields can be added in future kernel versions.
>> +Its layout is as follows:
>> +.TP
>> +.B Structure alignment
> 
> s/.B //

OK, I'll remove the ".B " for each of those items.

> 
>> +This structure is aligned on either 32-byte boundary,
>> +or on the alignment value returned by
>> +.IR getauxval ()
>> +invoked with
>> +.B AT_RSEQ_ALIGN
>> +if the structure size differs from 32 bytes.
>> +.TP
>> +.B Structure size
>> +This structure size needs to be at least 32 bytes.
>> +It can be either 32 bytes,
>> +or it needs to be large enough to hold the result of
>> +.IR getauxval ()
>> +invoked with
>> +.BR AT_RSEQ_FEATURE_SIZE .
> 
> Maybe?:
> 
> .I getauxval(AT_RSEQ_FEATURE_SIZE)
> 

I suspect we want:

.IR getauxval(AT_RSEQ_FEATURE_SIZE) .

To keep the punctuation.

And change the part about AT_RSEQ_ALIGN above in a similar fashion.

>> +Its size is passed as parameter to the
>> +.BR rseq ()
>> +system call.
>> +.in +4n
>> +.IP
>> +.EX
>> +#include <linux/rseq.h>
>> +
>> +struct rseq {
>> +    __u32 cpu_id_start;
>> +    __u32 cpu_id;
>> +    union {
>> +        /* ... */
>> +    } rseq_cs;
>> +    __u32 flags;
>> +    __u32 node_id;
>> +    __u32 mm_cid;
>> +} __attribute__((aligned(32)));
>> +.EE
>> +.in
>> +.TP
>> +.B Fields
>> +.RS
>> +.TP
>> +.I cpu_id_start
>> +Always-updated value of the CPU number on which the registered thread is
>> +running.
>> +Initialized by user-space to 0,
>> +updated by the kernel for threads registered with
>> +.BR rseq ().
>> +Its value is 0 when
>> +.BR rseq ()
>> +is not registered.
>> +Its value should always be confirmed by reading the
>> +.I cpu_id
>> +field before user-space performs any side-effect
>> +(e.g. storing to memory).
>> +.IP
>> +Because it is initialized to 0,
>> +this field can be loaded by user-space and
>> +used to index per-cpu data structures
>> +without having to check whether its value is within valid bounds.
>> +.IP
>> +For user-space applications executed on a kernel without
>> +.BR rseq ()
>> +support,
>> +the cpu_id_start field stays initialized at 0.
>> +It is therefore valid to use it as an offset in per-cpu data structures,
>> +and only validate whether it's actually the current CPU number by
>> +comparing it with the cpu_id field within the rseq critical section.
>> +If the kernel does not provide
>> +.BR rseq ()
>> +support, that cpu_id field stays initialized at -1,
>> +so the comparison always fails, as intended.
>> +.IP
>> +This field should only be read by the thread which registered this data
>> +structure.
>> +Aligned on 32-bit.
>> +.IP
>> +It is up to user space to implement a fall-back mechanism for 
>> scenarios where
>> +.BR rseq ()
>> +is not available.
>> +.TP
>> +.I cpu_id
>> +Always-updated value of the CPU number on which the registered thread is
>> +running.
>> +Initialized by user-space to -1,
>> +updated by the kernel for threads registered with
>> +.BR rseq ().
>> +.IP
>> +This field should only be read by the thread which registered this data
>> +structure.
>> +Aligned on 32-bit.
>> +.TP
>> +.I rseq_cs
>> +The rseq_cs field is a pointer to a
>> +.IR "struct rseq_cs" .
>> +Is is NULL when no rseq assembly block critical section is active for
>> +the registered thread.
>> +Setting it to point to a critical section descriptor
>> +.RI ( "struct rseq_cs")
>> +marks the beginning of the critical section.
>> +.IP
>> +Initialized by user-space to NULL.
>> +.IP
>> +Updated by user-space, which sets the address of the currently
>> +active rseq_cs at the beginning of assembly instruction sequence
> 
> rseq_cs and other identifiers should be in italics (.I).

ok

> 
>> +block,
>> +and set to NULL by the kernel when it restarts an assembly instruction
>> +sequence block,
>> +as well as when the kernel detects that it is preempting or delivering a
>> +signal outside of the range targeted by the rseq_cs.
>> +Also needs to be set to NULL by user-space before reclaiming memory that
>> +contains the targeted
>> +.IR "struct rseq_cs" .
>> +.IP
>> +Read and set by the kernel.
>> +.IP
>> +This field should only be updated by the thread which registered this
>> +data structure.
>> +Aligned on 64-bit.
>> +.TP
>> +.I flags
>> +Flags indicating the restart behavior for the registered thread.
>> +This is mainly used for debugging purposes.
>> +Can be a combination of:
>> +.RS
>> +.TP
>> +.B RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT
>> +Inhibit instruction sequence block restart on preemption for this
>> +thread.
>> +This flag is deprecated since Linux 6.1.
>> +.TP
>> +.B RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL
>> +Inhibit instruction sequence block restart on signal delivery for this
>> +thread.
>> +This flag is deprecated since Linux 6.1.
>> +.TP
>> +.B RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE
>> +Inhibit instruction sequence block restart on migration for this thread.
>> +This flag is deprecated since Linux 6.1.
>> +.RE
>> +.IP
>> +Initialized by user-space, used by the kernel.
>> +.TP
>> +.I node_id
>> +Always-updated value of the current NUMA node ID.
>> +.IP
>> +Initialized by user-space to 0.
>> +.IP
>> +Updated by the kernel.
>> +Read by user-space with single-copy atomicity semantics.
>> +This field should only be read by the thread which registered
>> +this data structure.
>> +Aligned on 32-bit.
>> +.TP
>> +.I mm_cid
>> +Contains the current thread's concurrency ID
>> +(allocated uniquely within a memory map).
>> +.IP
>> +Updated by the kernel.
>> +Read by user-space with single-copy atomicity semantics.
> 
> s/user-space/user space/

ok

> 
>> +This field should only be read by the thread which registered this data
>> +structure.
>> +Aligned on 32-bit.
>> +.IP
>> +This concurrency ID is within the possible cpus range,
>> +and is temporarily (and uniquely) assigned while threads are actively
>> +running within a memory map.
>> +If a memory map has fewer threads than cores,
>> +or is limited to run on few cores concurrently through sched affinity or
>> +cgroup cpusets,
>> +the concurrency IDs will be values close to 0,
>> +thus allowing efficient use of user-space memory for per-cpu data
>> +structures.
>> +.RE
>> +.PP
>> +The layout of
>> +.I struct rseq_cs
>> +version 0 is as follows:
>> +.TP
>> +.B Structure alignment
>> +This structure is aligned on 32-byte boundary.
>> +.TP
>> +.B Structure size
>> +This structure has a fixed size of 32 bytes.
>> +.in +4n
>> +.IP
> 
> Please use .IP then .in, not reversed (for consistency, since that's the 
> order documented in man-pages(7)).
> 

ok

Thanks,

Mathieu

> 
> Thanks,
> 
> Alex
> 
>> +.EX
>> +#include <linux/rseq.h>
>> +
>> +struct rseq_cs {
>> +    __u32   version;
>> +    __u32   flags;
>> +    __u64   start_ip;
>> +    __u64   post_commit_offset;
>> +    __u64   abort_ip;
>> +} __attribute__((aligned(32)));
>> +.EE
>> +.in
>> +.TP
>> +.B Fields
>> +.RS
>> +.TP
>> +.I version
>> +Version of this structure.
>> +Should be initialized to 0.
>> +.TP
>> +.I flags
>> +.RS
>> +Flags indicating the restart behavior of this structure.
>> +Can be a combination of:
>> +.TP
>> +.B RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT
>> +Inhibit instruction sequence block restart on preemption for this
>> +critical section.
>> +This flag is deprecated since Linux 6.1.
>> +.TP
>> +.B RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL
>> +Inhibit instruction sequence block restart on signal delivery for this
>> +critical section.
>> +This flag is deprecated since Linux 6.1.
>> +.TP
>> +.B RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE
>> +Inhibit instruction sequence block restart on migration for this
>> +critical section.
>> +This flag is deprecated since Linux 6.1.
>> +.RE
>> +.TP
>> +.I start_ip
>> +Instruction pointer address of the first instruction of the sequence of
>> +consecutive assembly instructions.
>> +.TP
>> +.I post_commit_offset
>> +Offset (from start_ip address) of the address after the last instruction
>> +of the sequence of consecutive assembly instructions.
>> +.TP
>> +.I abort_ip
>> +Instruction pointer address where to move the execution flow in case of
>> +abort of the sequence of consecutive assembly instructions.
>> +.RE
>> +.PP
>> +The
>> +.I rseq_len
>> +argument is the size of the
>> +.I struct rseq
>> +to register.
>> +.PP
>> +The
>> +.I flags
>> +argument is 0 for registration, and
>> +.B RSEQ_FLAG_UNREGISTER
>> +for unregistration.
>> +.PP
>> +The
>> +.I sig
>> +argument is the 32-bit signature to be expected before the abort
>> +handler code.
>> +.PP
>> +A single library per process should keep the
>> +.I struct rseq
>> +in a per-thread data structure.
>> +The
>> +.I cpu_id
>> +field should be initialized to -1, and the
>> +.I cpu_id_start
>> +field should be initialized to a possible CPU value (typically 0).
>> +.PP
>> +Each thread is responsible for registering and unregistering its
>> +.IR "struct rseq" .
>> +No more than one
>> +.I struct rseq
>> +address can be registered per thread at a given time.
>> +.PP
>> +Reclaim of
>> +.I struct rseq
>> +object's memory must only be done after either an explicit rseq
>> +unregistration is performed or after the thread exits.
>> +.PP
>> +In a typical usage scenario, the thread registering the
>> +.I struct rseq
>> +will be performing loads and stores from/to that structure.
>> +It is however also allowed to read that structure from other threads.
>> +The
>> +.I struct rseq
>> +field updates performed by the kernel provide relaxed atomicity
>> +semantics (atomic store, without memory ordering),
>> +which guarantee that other threads performing relaxed atomic reads
>> +(atomic load, without memory ordering) of the cpu number fields will
>> +always observe a consistent value.
>> +.SH RETURN VALUE
>> +A return value of 0 indicates success.
>> +On error, \-1 is returned, and
>> +.I errno
>> +is set appropriately.
>> +.SH ERRORS
>> +.TP
>> +.B EINVAL
>> +Either
>> +.I flags
>> +contains an invalid value, or
>> +.I rseq
>> +contains an address which is not appropriately aligned, or
>> +.I rseq_len
>> +contains an incorrect size.
>> +.TP
>> +.B ENOSYS
>> +The
>> +.BR rseq ()
>> +system call is not implemented by this kernel.
>> +.TP
>> +.B EFAULT
>> +.I rseq
>> +is an invalid address.
>> +.TP
>> +.B EBUSY
>> +Restartable sequence is already registered for this thread.
>> +.TP
>> +.B EPERM
>> +The
>> +.I sig
>> +argument on unregistration does not match the signature received
>> +on registration.
>> +.SH VERSIONS
>> +The
>> +.BR rseq ()
>> +system call was added in Linux 4.18.
>> +.SH STANDARDS
>> +.BR rseq ()
>> +is Linux-specific.
>> +.SH SEE ALSO
>> +.BR sched_getcpu (3) ,
>> +.BR membarrier (2) ,
>> +.BR getauxval (3)
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


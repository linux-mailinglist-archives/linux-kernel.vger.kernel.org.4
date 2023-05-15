Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58C7703BDF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 20:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244863AbjEOSHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 14:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244745AbjEOSGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 14:06:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AEADDA1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 11:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684173830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=pf9DjJNyvmax41S42SDvMdoRKYSjsTXeUTziqy36P8U=;
        b=aUhSKlfe63H3evORACExnPVcWvdKWzvU5TWN5Os0d/T6n5OZ8s4zbRYUphGDXmXgNJic5I
        0F54SbaC0Hlddr5AUQV327w4McIP9GsSPUTAVRc8OzCpF81gMjkyhYy15ULxN1WLUsIXf1
        qJJKck9lEmbdyvzYb2uLThOQOYJ8x+E=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-54-VK9Nhy0oMwuh0MWqo5vRbQ-1; Mon, 15 May 2023 14:03:44 -0400
X-MC-Unique: VK9Nhy0oMwuh0MWqo5vRbQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 903D63C0ED55;
        Mon, 15 May 2023 18:03:43 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-4.gru2.redhat.com [10.97.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 23D422166B26;
        Mon, 15 May 2023 18:03:43 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 3C0024133CFAB; Mon, 15 May 2023 15:02:17 -0300 (-03)
Message-ID: <20230515180015.016409657@redhat.com>
User-Agent: quilt/0.67
Date:   Mon, 15 May 2023 15:00:15 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Christoph Lameter <cl@linux.com>
Cc:     Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Russell King <linux@armlinux.org.uk>,
        Huacai Chen <chenhuacai@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH v8 00/13] fold per-CPU vmstats remotely
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URI_DOTEDU autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series addresses the following two problems:

1. A customer provided evidence indicating that a process
   was stalled in direct reclaim:

 - The process was trapped in throttle_direct_reclaim().
   The function wait_event_killable() was called to wait condition
   allow_direct_reclaim(pgdat) for current node to be true.
   The allow_direct_reclaim(pgdat) examined the number of free pages
   on the node by zone_page_state() which just returns value in
   zone->vm_stat[NR_FREE_PAGES].

 - On node #1, zone->vm_stat[NR_FREE_PAGES] was 0.
   However, the freelist on this node was not empty.

 - This inconsistent of vmstat value was caused by percpu vmstat on
   nohz_full cpus. Every increment/decrement of vmstat is performed
   on percpu vmstat counter at first, then pooled diffs are cumulated
   to the zone's vmstat counter in timely manner. However, on nohz_full
   cpus (in case of this customer's system, 48 of 52 cpus) these pooled
   diffs were not cumulated once the cpu had no event on it so that
   the cpu started sleeping infinitely.
   I checked percpu vmstat and found there were total 69 counts not
   cumulated to the zone's vmstat counter yet.

 - In this situation, kswapd did not help the trapped process.
   In pgdat_balanced(), zone_wakermark_ok_safe() examined the number
   of free pages on the node by zone_page_state_snapshot() which
   checks pending counts on percpu vmstat.
   Therefore kswapd could know there were 69 free pages correctly.
   Since zone->_watermark = {8, 20, 32}, kswapd did not work because
   69 was greater than 32 as high watermark.

 2. With a task that busy loops on a given CPU,
    the kworker interruption to execute vmstat_update
    is undesired and may exceed latency thresholds
    for certain applications.

By having vmstat_shepherd flush the per-CPU counters to the
global counters from remote CPUs.

This is done using cmpxchg to manipulate the counters,
both CPU locally (via the account functions),
and remotely (via cpu_vm_stats_fold).

Thanks to Aaron Tomlin for diagnosing issue 1 and writing
the initial patch series.


Performance details for the kworker interruption:

oslat   1094.456862: sys_mlock(start: 7f7ed0000b60, len: 1000)
oslat   1094.456971: workqueue_queue_work: ... function=vmstat_update ...
oslat   1094.456974: sched_switch: prev_comm=oslat ... ==> next_comm=kworker/5:1 ...
kworker 1094.456978: sched_switch: prev_comm=kworker/5:1 ==> next_comm=oslat ...
 
The example above shows an additional 7us for the

        oslat -> kworker -> oslat

switches. In the case of a virtualized CPU, and the vmstat_update
interruption in the host (of a qemu-kvm vcpu), the latency penalty
observed in the guest is higher than 50us, violating the acceptable
latency threshold for certain applications.

Follows a summary of the arguments against this patchset
and responses to them. They are numbered from 1 and 
start with "O-x)", where x is a number. A line with 
"*** Response: ***" precedes the response to each numbered
objection.


O-1) `echo 1 > /proc/sys/vm/stat_refresh' achieves essentially the same
without any kernel changes.

*** Response ***

The stat_refresh interface is not reliable as it triggers "queue_work_on" for all
CPUs which have dirty per-CPU mm counters. So if you have two threads that desire not to be
interrupted, starting one of the threads can interrupt an already executing
and isolated thread.

O-2) Why not always loop through all CPUs when reading the counters? 
(that is replace zone_page_state with zone_page_state_snapshot).

*** Response ***

Consider zone_watermark_fast, called from get_page_from_freelist.

https://lwn.net/Articles/684616/

On x86 systems, DMA is not usually the problem; instead, memory
allocation is. He is working with a target of 14.8 million packets (full
wire speed on a 10Gb/s link) per second; on a 3GHz system, that gives
the kernel about 200 cycles in which to process each packet. Allocating
a single page, though, takes 277 cycles on that system, making the
14.8Mpps rate unattainable. He pointed out Mel Gorman's recent work to
reduce memory-allocator overhead; that work reduced the cost to 230
cycles — a significant improvement, but nowhere near enough.

O-3) Also vmstat already has a concept of silencing - i.e. quiet_vmstat. IIRC
this is used by NOHZ. 

*** Response ***:

The quiet_vmstat mechanism is not reliable, as it is used by the NOHZ code to
synchronize the per-CPU mm stats to global counters (when entering NOHZ mode).

Any subsequent use of per-CPU mm counters will allow vmstat shepherd thread
to queue work (therefore waking up kwork thread) on a CPU.

/*
 * Switch off vmstat processing and then fold all the remaining differentials
 * until the diffs stay at zero. The function is used by NOHZ and can only be
 * invoked when tick processing is not active.
 */
void quiet_vmstat(void)

O-4) The only applications of interest are those that do not enter the kernel.

> > >  2. With a task that busy loops on a given CPU,
> > >     the kworker interruption to execute vmstat_update
> > >     is undesired and may exceed latency thresholds
> > >     for certain applications.
> >
> > Yes it can but why does that matter?
>
> It matters for the application that is executing and expects
> not to be interrupted.                                                                                                                                                      
Those workloads shouldn't enter the kernel in the first place, no?
Otherwise the in kernel execution with all the direct or indirect
dependencies (e.g. via locks) can throw any latency expectations off the
window.

*** Response ***: a common counter example is for latency sensitive applications 
to call sys_nanosleep (for example cyclictest or PLC programs do that).

O-5) Why not implement a syscall to flush all per-cpu caches.

> The practical problem we have been seeing is -RT app initialization.                                                                                                        
> For example:                                                                                                                                                                
>                                                                                                                                                                             
> 1) mlock();                                                                                                                                                                 
> 2) enter loop without system calls

OK, that is what I have kinda expected. Would have been better to
mention it explicitly.

I expect this to be a very common pattern and vmstat might not be the
only subsystem that could interfere later on. Would it make more sense
to address this by a more generic solution? E.g. a syscall to flush all
per-cpu caches so they won't interfere later unless userspace hits the
kernel path in some way (e.g. flush_cpu_caches(cpu_set_t cpumask, int flags)?
The above pattern could then be implemented as

        do_initial_setup()
        sched_setaffinity(getpid(), cpumask);
        flush_cpu_caches(cpumask, 0);
        do_userspace_loop()

*** Response ***:

A special mode, where flushing of caches has been attempted
before:

https://lwn.net/Articles/883940/

However it has a number of drawbacks:

1) If the application is in kernel mode, the interruption
will not be avoided (this patchset will avoid the interruption
even in kernel space).

2) It requires modification of applications.

3) Applications which attempt to use this mode in combination
with system call periods, for example:

https://lore.kernel.org/linux-mm/87im9d4ezq.fsf@nanos.tec.linutronix.de/

"In a real-world usecase we had the situation of compute bursts and an
unfortunate hw enforced requirement to go into the kernel between them
for synchronization between the compute threads and hardware (A quick
hardware assisted save/load).

Unmodified NOHZ full accumulated to more than 6% loss compared to a
fully undisturbed run. Most of it was caused by cache effects and not by
the actually used CPU time.

A full enforced quiescing upfront gained ~2-3%, but a lazy approach of
accepting that some stuff might happen once and does not happen again
gained almost 5%. In that particular scenario 5% _is_ a huge win."

Will suffer performance slowdowns.

O-7) There is a lack of examples where this change is required.

*** Response ***:

Example-1: MAC scheduler processing must occur every 1ms,                                                                                                         
and a certain amount of computation takes place (and must finish before                                                                                                     
the next 1ms timeframe). A > 50us latency spike as observed by cyclictest                                                                                                   
is considered a "failure".     

Performance details for the kworker interruption being solved:
                                                                                                                                                                    
oslat   1094.456862: sys_mlock(start: 7f7ed0000b60, len: 1000)
oslat   1094.456971: workqueue_queue_work: ... function=vmstat_update ...
oslat   1094.456974: sched_switch: prev_comm=oslat ... ==> next_comm=kworker/5:1 ...
kworker 1094.456978: sched_switch: prev_comm=kworker/5:1 ==> next_comm=oslat ...
                                                                                                                                                                    
The example above shows an additional 7us for the
                                                                                                                                                                    
        oslat -> kworker -> oslat                                                                                                                                   
                                                                                                                                                                    
switches. In the case of a virtualized CPU, and the vmstat_update                                                                                                   
interruption in the host (of a qemu-kvm vcpu), the latency penalty                                                                                                  
observed in the guest is higher than 50us, violating the acceptable                                                                                                 
latency threshold for certain applications.

Example-2: Based on the tracing data above, but a slight different
use case:

Nearly every telco we work with for 5G RAN is demanding <20 usec CPU latency
as measured by cyclictest & oslat.  We cannot achieve under 20 usec with the vmstats
interruption.

Example-3: 7us above has been measured on recent Intel Xeon processors.
There are use cases which use less powerful processors, such as embedded
ARM boards, where switching from kworker and back is much more expensive
(causing problems to a larger range of applications). For example, 3D printing:
https://scholarworks.sjsu.edu/cgi/viewcontent.cgi?article=2077&context=etd_projects

O-8) This is a general problem, therefore requires a general solution.

> But let me repeat, this is not just about vmstats. Just have a look at                                                                                                                        
> other queue_work_on users. You do not want to handy pick each and every                                                                                                                       
> one and do so in the future as well.                                                                                                                                                          

*** Response ***:

The ones that are problematic are being fixed for sometime now. For example:

commit 2de79ee27fdb52626ac4ac48ec6d8d52ba6f9047
Author: Paolo Abeni <pabeni@redhat.com>

    net: try to avoid unneeded backlog flush

    flush_all_backlogs() may cause deadlock on systems
    running processes with FIFO scheduling policy.

    The above is critical in -RT scenarios, where user-space
    specifically ensure no network activity is scheduled on
    the CPU running the mentioned FIFO process, but still get
    stuck.

    This commit tries to address the problem checking the
    backlog status on the remote CPUs before scheduling the
    flush operation. If the backlog is empty, we can skip it.

    v1 -> v2:
     - explicitly clear flushed cpu mask - Eric

    Signed-off-by: Paolo Abeni <pabeni@redhat.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>


And it has been a normal process so far.

I think what needs to be done is to avoid new queue_work_on()
users from being introduced in the tree (the number of
existing ones is finite and can therefore be fixed).

Agree with the criticism here, however, i can't see other
options than the following:

	1) Given an activity, which contains a sequence of instructions
	   to execute on a CPU, to change the algorithm
	   to execute that code remotely (therefore avoid interrupting a CPU),
	   or to avoid the interruption somehow (which must be dealt with 
	   on a case-by-case basis).

	2) To block that activity from happening in the first place,
	   for the sites where it can be blocked (that return errors to
	   userspace, for example).

	3) Completly isolate the CPU from the kernel (off-line it).

Working on patches to improve #2.

v8
- Add summary of discussion on -v7 to cover letter
- rebase

v7:
- Fix allow_direct_reclaim issue by using
  zone_page_state_snapshot				(Michal Hocko)

v6:
- Add more information on throttle_direct_reclaim problem 
  to commit logs	       			       (Michal Hocko)

v5:
- Drop "mm/vmstat: remove remote node draining"        (Vlastimil Babka)
- Implement remote node draining for cpu_vm_stats_fold (Vlastimil Babka)

v4:
- Switch per-CPU vmstat counters to s32, required 
  by RISC-V, ARC architectures			

v3:
- Removed unused drain_zone_pages and changes variable (David Hildenbrand)
- Use xchg instead of cmpxchg in refresh_cpu_vm_stats  (Peter Xu)
- Add drain_all_pages to vmstat_refresh to make
  stats more accurate				       (Peter Xu)
- Improve changelog of
  "mm/vmstat: switch counter modification to cmpxchg"  (Peter Xu / David)
- Improve changelog of
  "mm/vmstat: remove remote node draining"	       (David Hildenbrand)


v2:
- actually use LOCK CMPXCHG on counter mod/inc/dec functions
  (Christoph Lameter)
- use try_cmpxchg for cmpxchg loops
  (Uros Bizjak / Matthew Wilcox)

 arch/arm64/include/asm/percpu.h     |   16 ++
 arch/loongarch/include/asm/percpu.h |   23 +++-
 arch/s390/include/asm/percpu.h      |    5 
 arch/x86/include/asm/percpu.h       |   39 +++---
 include/asm-generic/percpu.h        |   17 ++
 include/linux/mmzone.h              |    8 -
 include/linux/percpu-defs.h         |    2 
 include/linux/vmstat.h              |    2 
 kernel/fork.c                       |    2 
 kernel/scs.c                        |    2 
 mm/page_alloc.c                     |    5 
 mm/vmscan.c                         |    2 
 mm/vmstat.c                         |  440 +++++++++++++++++++++++++++++++++++++++++++++++------------------------------
 13 files changed, 361 insertions(+), 202 deletions(-)



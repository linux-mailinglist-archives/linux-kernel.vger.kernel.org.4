Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F9674DEBC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 22:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbjGJUEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 16:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjGJUEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 16:04:04 -0400
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8280133
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 13:04:01 -0700 (PDT)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-635dccdf17dso33373386d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 13:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689019440; x=1691611440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WPBSsr2eiOgXjmOUkIUT4k+7ikad/s/kT7rleyjRkpM=;
        b=b920zJ/zw4ruP6fev9pWhiJBxCBf1J7TjfTIb997CzNRGw69SsYkLFy9hJmDgeSLzl
         S/ZvJ2yqECdqfy/6Me4uTXWx7Knc8OWZKc+xXT82+9+jq1pdmXUK3JSOxWlCtYFovVz/
         Iby+2tOpP92lutYFd0g86Vqi35hhcN9oPjoJzaMYU85w6ko1ZReqRxVy4nazHTp07mHj
         bw8+F52IVJsSqwzjtyZpw8F+e+8O/1gjCHGD4EE/BOOqH/kvT6AJRBaLEpRlVum7x5Za
         tDiXDclJkpfFrld94EE6oJpmTNrbYYIa+MCkfp86GIAGZoYIDFLjurtIK8qQ5RDscnmk
         I8gQ==
X-Gm-Message-State: ABy/qLbRIhJGFtbnyiNe/QESeR2IKwyyZTDZqOZ/fj8CMUbWND1nZ/ao
        0XhxpD6Yb0ZG45jkUtQVgvrGOsxi++bFTyx/
X-Google-Smtp-Source: APBJJlFpUYUgJqTDGH3yy33QlfxVom2EaKp+pMijQrwaEexFf7+YYYZPt8PSjnFpZHdFhuTsAODitg==
X-Received: by 2002:a0c:de0f:0:b0:621:1a4c:759b with SMTP id t15-20020a0cde0f000000b006211a4c759bmr11095367qvk.36.1689019440027;
        Mon, 10 Jul 2023 13:04:00 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:4850])
        by smtp.gmail.com with ESMTPSA id v14-20020a0cdd8e000000b005ef81cc63ccsm168752qvk.117.2023.07.10.13.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 13:03:59 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, gautham.shenoy@amd.com,
        kprateek.nayak@amd.com, aaron.lu@intel.com, clm@meta.com,
        tj@kernel.org, roman.gushchin@linux.dev, kernel-team@meta.com
Subject: [PATCH v2 0/7] sched: Implement shared runqueue in CFS
Date:   Mon, 10 Jul 2023 15:03:35 -0500
Message-Id: <20230710200342.358255-1-void@manifault.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes
-------

This is v2 of the shared wakequeue (now called shared runqueue)
patchset. The following are changes from the RFC v1 patchset
(https://lore.kernel.org/lkml/20230613052004.2836135-1-void@manifault.com/).

v1 -> v2 changes:
- Change name from swqueue to shared_runq (Peter)

- Sharded per-LLC shared runqueues to avoid contention on
  scheduler-heavy workloads (Peter)

- Pull tasks from the shared_runq in newidle_balance() rather than in
  pick_next_task_fair() (Peter and Vincent)

- Rename a few functions to reflect their actual purpose. For example,
  shared_runq_dequeue_task() instead of swqueue_remove_task() (Peter)

- Expose move_queued_task() from core.c rather than migrate_task_to()
  (Peter)

- Properly check is_cpu_allowed() when pulling a task from a shared_runq
  to ensure it can actually be migrated (Peter and Gautham)

- Dropped RFC tag

This patch set is based off of commit ebb83d84e49b ("sched/core: Avoid
multiple calling update_rq_clock() in __cfsb_csd_unthrottle()") on the
sched/core branch of tip.git.

Overview
========

The scheduler must constantly strike a balance between work
conservation, and avoiding costly migrations which harm performance due
to e.g. decreased cache locality. The matter is further complicated by
the topology of the system. Migrating a task between cores on the same
LLC may be more optimal than keeping a task local to the CPU, whereas
migrating a task between LLCs or NUMA nodes may tip the balance in the
other direction.

With that in mind, while CFS is by and large mostly a work conserving
scheduler, there are certain instances where the scheduler will choose
to keep a task local to a CPU, when it would have been more optimal to
migrate it to an idle core.

An example of such a workload is the HHVM / web workload at Meta. HHVM
is a VM that JITs Hack and PHP code in service of web requests. Like
other JIT / compilation workloads, it tends to be heavily CPU bound, and
exhibit generally poor cache locality. To try and address this, we set
several debugfs (/sys/kernel/debug/sched) knobs on our HHVM workloads:

- migration_cost_ns -> 0
- latency_ns -> 20000000
- min_granularity_ns -> 10000000
- wakeup_granularity_ns -> 12000000

These knobs are intended both to encourage the scheduler to be as work
conserving as possible (migration_cost_ns -> 0), and also to keep tasks
running for relatively long time slices so as to avoid the overhead of
context switching (the other knobs). Collectively, these knobs provide a
substantial performance win; resulting in roughly a 20% improvement in
throughput. Worth noting, however, is that this improvement is _not_ at
full machine saturation.

That said, even with these knobs, we noticed that CPUs were still going
idle even when the host was overcommitted. In response, we wrote the
"shared runqueue" (shared_runq) feature proposed in this patch set. The
idea behind shared_runq is simple: it enables the scheduler to be more
aggressively work conserving by placing a waking task into a sharded
per-LLC FIFO queue that can be pulled from by another core in the LLC
FIFO queue which can then be pulled from before it goes idle.

With this simple change, we were able to achieve a 1 - 1.6% improvement
in throughput, as well as a small, consistent improvement in p95 and p99
latencies, in HHVM. These performance improvements were in addition to
the wins from the debugfs knobs mentioned above, and to other benchmarks
outlined below in the Results section.

Design
======

The design of shared_runq is quite simple. A shared_runq is simply a
list of struct shared_runq_shards:

struct shared_runq_shard {
    struct list_head list;
    spinlock_t lock;
} ____cacheline_aligned;

struct shared_runq {
    u32 num_shards;
    struct shared_runq_shard shards[];
} ____cacheline_aligned;

We create a struct shared_runq per LLC, ensuring they're in their own
cachelines to avoid false sharing between CPUs on different LLCs. We
also create some number of shards per struct shared_runq, where runnable
tasks are inserted and pulled from.

When a task becomes runnable, it enqueues itself in the
shared_runq_shard of its current core. Enqueues only happen if the task
is not pinned to a specific CPU.

A core will pull a task from one of the shards in its LLC's shared_runq
at the beginning of newidle_balance().

Difference between shared_runq and SIS_NODE
===========================================

In [0] Peter proposed a patch that addresses Tejun's observations that
when workqueues are targeted towards a specific LLC on his Zen2 machine
with small CCXs, that there would be significant idle time due to
select_idle_sibling() not considering anything outside of the current
LLC.

This patch (SIS_NODE) is essentially the complement to the proposal
here. SID_NODE causes waking tasks to look for idle cores in neighboring
LLCs on the same die, whereas shared_runq causes cores about to go idle
to look for enqueued tasks. That said, in its current form, the two
features at are a different scope as SIS_NODE searches for idle cores
between LLCs, while shared_runq enqueues tasks within a single LLC.

The patch was since removed in [1], and we compared the results to
shared_runq (previously called "swqueue") in [2]. SIS_NODE did not
outperform shared_runq on any of the benchmarks, so we elect to not
compare against it again for this v2 patch set.

[0]: https://lore.kernel.org/all/20230530113249.GA156198@hirez.programming.kicks-ass.net/
[1]: https://lore.kernel.org/all/20230605175636.GA4253@hirez.programming.kicks-ass.net/
[2]: https://lore.kernel.org/lkml/20230613052004.2836135-1-void@manifault.com/

Results
=======

Note that the motivation for the shared runqueue feature was originally
arrived at using experiments in the sched_ext framework that's currently
being proposed upstream. The ~1 - 1.6% improvement in HHVM throughput
is similarly visible using work-conserving sched_ext schedulers (even
very simple ones like global FIFO).

In both single and multi socket / CCX hosts, this can measurably improve
performance. In addition to the performance gains observed on our
internal web workloads, we also observed an improvement in common
workloads such as kernel compile and hackbench, when running shared
runqueue.

On the other hand, some workloads suffer from shared_runq. Workloads
that hammer the runqueue hard, such as netperf UDP_RR, or ./schbench -L
-m 52 -p 512 -r 10 -t 1. This can be mitigated somewhat by sharding the
shared datastructures within a CCX, but it doesn't seem to eliminate all
contention in every scenario. On the positive side, it seems that
sharding does not materially harm the benchmarks run for this patch
series; and in fact seems to improve some workloads such as kernel
compile.

Note that for the kernel compile workloads below, the compilation was
done by running make -j$(nproc) built-in.a on several different types of
hosts configured with make allyesconfig on commit a27648c74210 ("afs:
Fix setting of mtime when creating a file/dir/symlink") on Linus' tree
(boost and turbo were disabled on all of these hosts when the
experiments were performed). Additionally, NO_SHARED_RUNQ refers to
SHARED_RUNQ being completely disabled, SHARED_RUNQ_WAKEUPS refers to
sharded SHARED_RUNQ where tasks are enqueued in the shared runqueue at
wakeup time, and SHARED_RUNQ_ALL refers to sharded SHARED_RUNQ where
tasks are enqueued in the shared runqueue on every enqueue. Results are
not included for unsharded shared runqueue, as the results here exceed
the unsharded results already outlined out in [2] as linked above.

=== Single-socket | 16 core / 32 thread | 2-CCX | AMD 7950X Zen4 ===

CPU max MHz: 5879.8818
CPU min MHz: 3000.0000

Command: make -j$(nproc) built-in.a
			    o____________o_______o
			    |    mean    | CPU   |
			    o------------o-------o
NO_SHARED_RUNQ:             | 582.46s    | 3101% |
SHARED_RUNQ_WAKEUPS:        | 581.22s    | 3117% |
SHARED_RUNQ_ALL:            | 578.41s    | 3141% |
			    o------------o-------o

Takeaway: SHARED_RUNQ_WAKEUPS performs roughly the same as
NO_SHARED_RUNQ, but SHARED_RUNQ_ALL results in a statistically
significant ~.7% improvement over NO_SHARED_RUNQ. This suggests that
enqueuing tasks in the shared runqueue on every enqueue improves work
conservation, and thanks to sharding, does not result in contention.

Note that I didn't collect data for kernel compile with SHARED_RUNQ_ALL
_without_ sharding. The reason for this is that we know that CPUs with
sufficiently large LLCs will contend, so if we've decided to accommodate
those CPUs with sharding, there's not much point in measuring the
results of not sharding on CPUs that we know won't contend.

Command: hackbench --loops 10000
			    o____________o_______o
			    |    mean    | CPU   |
			    o------------o-------o
NO_SHARED_RUNQ:             | 2.1912s    | 3117% |
SHARED_RUNQ_WAKEUP:         | 2.1080s    | 3155% |
SHARED_RUNQ_ALL:            | 1.9830s    | 3144% |
			    o------------o-------o

Takeaway: SHARED_RUNQ in both forms performs exceptionally well compared
to NO_SHARED_RUNQ here, with SHARED_RUNQ_ALL beating NO_SHARED_RUNQ by
almost 10%. This was a surprising result given that it seems
advantageous to err on the side of avoiding migration in hackbench given
that tasks are short lived in sending only 10k bytes worth of messages,
but the results of the benchmark would seem to suggest that minimizing
runqueue delays is preferable.

Command:
for i in `seq 128`; do
    netperf -6 -t UDP_RR -c -C -l $runtime &
done
			    o_______________________o
			    |   mean  (thoughput)   |
			    o-----------------------o
NO_SHARED_RUNQ:             | 25064.12              |
SHARED_RUNQ_WAKEUP:         | 24862.16              |
SHARED_RUNQ_ALL:            | 25287.73              |
			    o-----------------------o

Takeaway: No statistical significance, though it is worth noting that
there is no regression for shared runqueue on the 7950X, while there is
a small regression on the Skylake and Milan hosts for SHARED_RUNQ_WAKEUP
as described below.


=== Single-socket | 18 core / 36 thread | 1-CCX | Intel Skylake ===

CPU max MHz: 1601.0000
CPU min MHz: 800.0000

Command: make -j$(nproc) built-in.a
			    o____________o_______o
			    |    mean    | CPU   |
			    o------------o-------o
NO_SHARED_RUNQ:             | 1535.46s   | 3417% |
SHARED_RUNQ_WAKEUP:         | 1534.56s   | 3428% |
SHARED_RUNQ_ALL:            | 1531.95s   | 3429% |
			    o------------o-------o

Takeaway: SHARED_RUNQ_ALL results in a ~.23% improvement over
NO_SHARED_RUNQ. Not a huge improvement, but consistently measurable.
The cause of this gain is presumably the same as the 7950X: improved
work conservation, with sharding preventing excessive contention on the
shard lock.

Command: hackbench --loops 10000
			    o____________o_______o
			    |    mean    | CPU   |
			    o------------o-------o
NO_SHARED_RUNQ:             | 5.5750s    | 3369% |
SHARED_RUNQ_WAKEUP:         | 5.5764s    | 3495% |
SHARED_RUNQ_ALL:            | 5.4760s    | 3481% |
			    o------------o-------o

Takeaway: SHARED_RUNQ_ALL results in a ~1.6% improvement over
NO_SHARED_RUNQ. Also statistically significant, but smaller than the
almost 10% improvement observed on the 7950X.

Command: netperf -n $(nproc) -l 60 -t TCP_RR
for i in `seq 128`; do
	netperf -6 -t UDP_RR -c -C -l $runtime &
done
				o______________________o
				|   mean  (thoughput)  |
				o----------------------o
NO_SHARED_RUNQ:			| 11963.08             |
SHARED_RUNQ_WAKEUP:		| 11943.60             |
SHARED_RUNQ_ALL:		| 11554.32             |
				o----------------------o

Takeaway: NO_SHARED_RUNQ performs the same as SHARED_RUNQ_WAKEUP, but
beats SHARED_RUNQ_ALL by ~3.4%. This result makes sense -- the workload
is very heavy on the runqueue, so enqueuing tasks in the shared runqueue
in __enqueue_entity() would intuitively result in increased contention
on the shard lock.  The fact that we're at parity with
SHARED_RUNQ_WAKEUP suggests that sharding the shared runqueue has
significantly improved the contention that was observed in v1, but that
__enqueue_entity() puts it over the edge.

NOTE: Parity for SHARED_RUNQ_WAKEUP relies on choosing the correct shard
size. If we chose, for example, a shard size of 16, there would still be
a regression between NO_SHARED_RUNQ and SHARED_RUNQ_WAKEUP. As described
below, this suggests that we may want to add a debugfs tunable for the
shard size.


=== Single-socket | 72-core | 6-CCX | AMD Milan Zen3 ===

CPU max MHz: 700.0000
CPU min MHz: 700.0000

Command: make -j$(nproc) built-in.a
				o____________o_______o
				|    mean    | CPU   |
				o------------o-------o
NO_SHARED_RUNQ:			| 1601.81s   | 6476% |
SHARED_RUNQ_WAKEUP:		| 1602.55s   | 6472% |
SHARED_RUNQ_ALL:		| 1602.49s   | 6475% |
				o------------o-------o

Takeaway: No statistically significant variance. It might be worth
experimenting with work stealing in a follow-on patch set.

Command: hackbench --loops 10000
				o____________o_______o
				|    mean    | CPU   |
				o------------o-------o
NO_SHARED_RUNQ:			| 5.2672s    | 6463% |
SHARED_RUNQ_WAKEUP:		| 5.1476s    | 6583% |
SHARED_RUNQ_ALL:		| 5.1003s    | 6598% |
				o------------o-------o

Takeaway: SHARED_RUNQ_ALL again wins, by about 3% over NO_SHARED_RUNQ in
this case.

Command: netperf -n $(nproc) -l 60 -t TCP_RR
for i in `seq 128`; do
	netperf -6 -t UDP_RR -c -C -l $runtime &
done
				o_______________________o
				|   mean  (thoughput)   |
				o-----------------------o
NO_SHARED_RUNQ:			| 13819.08              |
SHARED_RUNQ_WAKEUP:		| 13907.74              |
SHARED_RUNQ_ALL:		| 13569.69              |
				o-----------------------o

Takeaway: Similar to the Skylake runs, NO_SHARED_RUNQ still beats
SHARED_RUNQ_ALL, though by a slightly lower margin of ~1.8%.


Finally, let's look at how sharding affects the following schbench
incantation suggested by Chris in [3]:

schbench -L -m 52 -p 512 -r 10 -t 1

[3]: https://lore.kernel.org/lkml/c8419d9b-2b31-2190-3058-3625bdbcb13d@meta.com/

The TL;DR is that sharding improves things a lot, but doesn't completely
fix the problem. Here are the results from running the schbench command
on the 18 core / 36 thread single CCX, single-socket Skylake:

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
class name         con-bounces    contentions       waittime-min   waittime-max waittime-total   waittime-avg    acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

&shard->lock:      31510503       31510711           0.08          19.98        168932319.64     5.36            31700383      31843851       0.03           17.50        10273968.33      0.32
------------
&shard->lock       15731657          [<0000000068c0fd75>] pick_next_task_fair+0x4dd/0x510
&shard->lock       15756516          [<000000001faf84f9>] enqueue_task_fair+0x459/0x530
&shard->lock          21766          [<00000000126ec6ab>] newidle_balance+0x45a/0x650
&shard->lock            772          [<000000002886c365>] dequeue_task_fair+0x4c9/0x540
------------
&shard->lock          23458          [<00000000126ec6ab>] newidle_balance+0x45a/0x650
&shard->lock       16505108          [<000000001faf84f9>] enqueue_task_fair+0x459/0x530
&shard->lock       14981310          [<0000000068c0fd75>] pick_next_task_fair+0x4dd/0x510
&shard->lock            835          [<000000002886c365>] dequeue_task_fair+0x4c9/0x540

These results are when we create only 3 shards (16 logical cores per
shard), so the contention may be a result of overly-coarse sharding. If
we run the schbench incantation with no sharding whatsoever, we see the
following significantly worse lock stats contention:

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
class name        con-bounces    contentions         waittime-min   waittime-max waittime-total         waittime-avg    acq-bounces   acquisitions   holdtime-min  holdtime-max holdtime-total   holdtime-avg
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

&shard->lock:     117868635      118361486           0.09           393.01       1250954097.25          10.57           119345882     119780601      0.05          343.35       38313419.51      0.32
------------
&shard->lock       59169196          [<0000000060507011>] __enqueue_entity+0xdc/0x110
&shard->lock       59084239          [<00000000f1c67316>] __dequeue_entity+0x78/0xa0
&shard->lock         108051          [<00000000084a6193>] newidle_balance+0x45a/0x650
------------
&shard->lock       60028355          [<0000000060507011>] __enqueue_entity+0xdc/0x110
&shard->lock         119882          [<00000000084a6193>] newidle_balance+0x45a/0x650
&shard->lock       58213249          [<00000000f1c67316>] __dequeue_entity+0x78/0xa0

The contention is ~3-4x worse if we don't shard at all. This roughly
matches the fact that we had 3 shards on the first workload run above.
If we make the shards even smaller, the contention is comparably much
lower:

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
class name    	   con-bounces    contentions   waittime-min  waittime-max waittime-total   waittime-avg   acq-bounces   acquisitions   holdtime-min  holdtime-max holdtime-total   holdtime-avg
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

&shard->lock:      13839849       13877596      0.08          13.23        5389564.95       0.39           46910241      48069307       0.06          16.40        16534469.35      0.34
------------
&shard->lock           3559          [<00000000ea455dcc>] newidle_balance+0x45a/0x650
&shard->lock        6992418          [<000000002266f400>] __dequeue_entity+0x78/0xa0
&shard->lock        6881619          [<000000002a62f2e0>] __enqueue_entity+0xdc/0x110
------------
&shard->lock        6640140          [<000000002266f400>] __dequeue_entity+0x78/0xa0
&shard->lock           3523          [<00000000ea455dcc>] newidle_balance+0x45a/0x650
&shard->lock        7233933          [<000000002a62f2e0>] __enqueue_entity+0xdc/0x110

Interestingly, SHARED_RUNQ performs worse than NO_SHARED_RUNQ on the schbench
benchmark on Milan as well, but we contend more on the rq lock than the
shard lock:

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
class name         con-bounces    contentions   waittime-min  waittime-max waittime-total   waittime-avg   acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

&rq->__lock:       9617614        9656091       0.10          79.64        69665812.00      7.21           18092700      67652829       0.11           82.38        344524858.87     5.09
-----------
&rq->__lock        6301611          [<000000003e63bf26>] task_rq_lock+0x43/0xe0
&rq->__lock        2530807          [<00000000516703f0>] __schedule+0x72/0xaa0
&rq->__lock         109360          [<0000000011be1562>] raw_spin_rq_lock_nested+0xa/0x10
&rq->__lock         178218          [<00000000c38a30f9>] sched_ttwu_pending+0x3d/0x170
-----------
&rq->__lock        3245506          [<00000000516703f0>] __schedule+0x72/0xaa0
&rq->__lock        1294355          [<00000000c38a30f9>] sched_ttwu_pending+0x3d/0x170
&rq->__lock        2837804          [<000000003e63bf26>] task_rq_lock+0x43/0xe0
&rq->__lock        1627866          [<0000000011be1562>] raw_spin_rq_lock_nested+0xa/0x10

..................................................................................................................................................................................................

&shard->lock:       7338558       7343244       0.10          35.97        7173949.14       0.98           30200858      32679623       0.08           35.59        16270584.52      0.50
------------
&shard->lock        2004142          [<00000000f8aa2c91>] __dequeue_entity+0x78/0xa0
&shard->lock        2611264          [<00000000473978cc>] newidle_balance+0x45a/0x650
&shard->lock        2727838          [<0000000028f55bb5>] __enqueue_entity+0xdc/0x110
------------
&shard->lock        2737232          [<00000000473978cc>] newidle_balance+0x45a/0x650
&shard->lock        1693341          [<00000000f8aa2c91>] __dequeue_entity+0x78/0xa0
&shard->lock        2912671          [<0000000028f55bb5>] __enqueue_entity+0xdc/0x110

...................................................................................................................................................................................................

If we look at the lock stats with SHARED_RUNQ disabled, the rq lock still
contends the most, but it's significantly less than with it enabled:

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
class name          con-bounces    contentions   waittime-min   waittime-max waittime-total   waittime-avg    acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

&rq->__lock:        791277         791690        0.12           110.54       4889787.63       6.18            1575996       62390275       0.13           112.66       316262440.56     5.07
-----------
&rq->__lock         263343          [<00000000516703f0>] __schedule+0x72/0xaa0
&rq->__lock          19394          [<0000000011be1562>] raw_spin_rq_lock_nested+0xa/0x10
&rq->__lock           4143          [<000000003b542e83>] __task_rq_lock+0x51/0xf0
&rq->__lock          51094          [<00000000c38a30f9>] sched_ttwu_pending+0x3d/0x170
-----------
&rq->__lock          23756          [<0000000011be1562>] raw_spin_rq_lock_nested+0xa/0x10
&rq->__lock         379048          [<00000000516703f0>] __schedule+0x72/0xaa0
&rq->__lock            677          [<000000003b542e83>] __task_rq_lock+0x51/0xf0

Worth noting is that increasing the granularity of the shards in general
improves very runqueue-heavy workloads such as netperf UDP_RR and this
schbench command, but it doesn't necessarily make a big difference for
every workload, or for sufficiently small CCXs such as the 7950X. It may
make sense to eventually allow users to control this with a debugfs
knob, but for now we'll elect to choose a default that resulted in good
performance for the benchmarks run for this patch series.

Conclusion
==========

shared_runq in this form provides statistically significant wins for
several types of workloads, and various CPU topologies. The reason for
this is roughly the same for all workloads: shared_runq encourages work
conservation inside of a CCX by having a CPU do an O(# per-LLC shards)
iteration over the shared_runq shards in an LLC. We could similarly do
an O(n) iteration over all of the runqueues in the current LLC when a
core is going idle, but that's quite costly (especially for larger
LLCs), and sharded shared_runq seems to provide a performant middle
ground between doing an O(n) walk, and doing an O(# shards) walk.

For the workloads above, kernel compile and hackbench were clear winners
for shared_runq (especially in __enqueue_entity()). The reason for the
improvement in kernel compile is of course that we have a heavily
CPU-bound workload where cache locality doesn't mean much; getting a CPU
is the #1 goal. As mentioned above, while I didn't expect to see an
improvement in hackbench, the results of the benchmark suggest that
minimizing runqueue delays is preferable to optimizing for L1/L2
locality.

Not all workloads benefit from shared_runq, however. Workloads that
hammer the runqueue hard, such as netperf UDP_RR, or schbench -L -m 52
-p 512 -r 10 -t 1, tend to run into contention on the shard locks;
especially when enqueuing tasks in __enqueue_entity(). This can be
mitigated significantly by sharding the shared datastructures within a
CCX, but it doesn't eliminate all contention, as described above.

Worth noting as well is that Gautham Shenoy ran some interesting
experiments on a few more ideas in [4], such as walking the shared_runq
on the pop path until a task is found that can be migrated to the
calling CPU. I didn't run those experiments in this patch set, but it
might be worth doing so.

[4]: https://lore.kernel.org/lkml/ZJkqeXkPJMTl49GB@BLR-5CG11610CF.amd.com/

Finally, while shared_runq in this form encourages work conservation, it
of course does not guarantee it given that we don't implement any kind
of work stealing between shared_runqs. In the future, we could
potentially push CPU utilization even higher by enabling work stealing
between shared_runqs, likely between CCXs on the same NUMA node.

Originally-by: Roman Gushchin <roman.gushchin@linux.dev>
Signed-off-by: David Vernet <void@manifault.com>

David Vernet (7):
  sched: Expose move_queued_task() from core.c
  sched: Move is_cpu_allowed() into sched.h
  sched: Check cpu_active() earlier in newidle_balance()
  sched/fair: Add SHARED_RUNQ sched feature and skeleton calls
  sched: Implement shared runqueue in CFS
  sched: Shard per-LLC shared runqueues
  sched: Move shared_runq to __{enqueue,dequeue}_entity()

 include/linux/sched.h   |   2 +
 kernel/sched/core.c     |  37 +-----
 kernel/sched/fair.c     | 254 +++++++++++++++++++++++++++++++++++++++-
 kernel/sched/features.h |   1 +
 kernel/sched/sched.h    |  37 ++++++
 5 files changed, 292 insertions(+), 39 deletions(-)

-- 
2.40.1

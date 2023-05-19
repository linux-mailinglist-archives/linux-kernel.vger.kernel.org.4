Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE165708CB6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 02:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjESARk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 20:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjESARi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:17:38 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9F5E0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:17:36 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1ab032d9266so27452055ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684455456; x=1687047456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=oCJDRKbKl3VcgUc89J7kT1mOpMzCCGRP0b6EITxm0zI=;
        b=ArUOvAmOSp+LrbdgxoMvkQhgsAExATcsA0HCcFeblKvaw9PDadM7E2coZlEe0Y+Pth
         WQ6WZZsmF/StuPou5FM67A0jiZPVgC6pORGHvZ6TAjEAzjmv2koD+kz/BaHu/txufKSa
         p+TkCbLxEKZMMYjYv9MRK6Xh89c+UztZojeXVXsvyxRhx9ydMtltJlPCIYqCe9R5DBPD
         2q/FOsmPb6HIZL9dhKSWv7+3xW7Q/I4JCUrI1snP487Qb6DD77XWiIT6HJLs3vlruHPr
         PdrjGyYLZLG0To+9LNxZFe/32esqbUTsEw/CLXlT1qaE4IatCc1WaD91uxXfPQzLStxQ
         nPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684455456; x=1687047456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oCJDRKbKl3VcgUc89J7kT1mOpMzCCGRP0b6EITxm0zI=;
        b=CJc2IZ+v1AXfkYBSNF14XHWfga55nzalYBQCNMjt49R30v3XdcvesA6vJew9iAjbbS
         xc4CesFPnT6SIQKMIlE8KJYnPsob+Pqa7L86HKdYCAqNUIF54LZ4wHec8ug8Yls/Th7s
         eJ/ckn7cdNxyuiRQ5NzKVGZViosRBx1ZQuuHl5tvVmYtAsUL+Ukm0XeMbBkhaovwI7Ic
         xKg2Jd2TjLCTCMu882QNWFFGyq0neb16zpOgvsL32Owf02AyIfZkxLZ2nmg5rHjlGNo5
         JCnFflPI0L1iCFF+/40+BND69FOa1AkiQ10qknv+BQRnLVAzSQCcyK5avYEr17Cmj0BT
         +EPA==
X-Gm-Message-State: AC+VfDyZ9z4k834kMOQs7jTs7/9r0v1MyZmHAv072kKWOItELyWIww1Q
        tMdSG3mQqxhQebSJ4ftLbcU=
X-Google-Smtp-Source: ACHHUZ6ZvgCYQvBU4dnaZqVU/321HYXYsaFICB+9Jt1paAg8kfKzZWuBBxMP9bOxlACSEncmhZ4BPw==
X-Received: by 2002:a17:902:d490:b0:1ae:6947:e617 with SMTP id c16-20020a170902d49000b001ae6947e617mr1110879plg.27.1684455455302;
        Thu, 18 May 2023 17:17:35 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id f5-20020a17090274c500b001ac6293577fsm2054104plt.110.2023.05.18.17.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 17:17:34 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        joshdon@google.com, brho@google.com, briannorris@chromium.org,
        nhuck@google.com, agk@redhat.com, snitzer@kernel.org,
        void@manifault.com
Subject: [PATCHSET v1 wq/for-6.5] workqueue: Improve unbound workqueue execution locality
Date:   Thu, 18 May 2023 14:16:45 -1000
Message-Id: <20230519001709.2563-1-tj@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

tl;dr
=====

Unbound workqueues used to spray work items inside each NUMA node, which
isn't great on CPUs w/ multiple L3 caches. This patchset implements
mechanisms to improve and configure execution locality.

Long patchset, so a bit of traffic control:

PeterZ
------

It uses p->wake_cpu to best-effort migrate workers on wake-ups. Migrating on
wake-ups fits the bill and it's cheaper and fits the semantics in that
workqueue is hinting the scheduler which CPU has the most continuity rather
than forcing the specific migration. However, p->wake_cpu is only used in
scheduler proper, so this would be introducing a new way of using the field.

Please see 0021 and 0024.

Linus, PeterZ
-------------

Most of the patchset are workqueue internal plumbing and probably aren't
terribly interesting. Howver, the performance picture turned out less
straight-forward than I had hoped, mostly likely due to loss of
work-conservation from scheduler in high fan-out scenarios. I'll describe it
in this cover letter. Please read on.

In terms of patches, 0021-0024 are probably the interesting ones.

Brian Norris, Nathan Huckleberry and others experiencing wq perf problems
-------------------------------------------------------------------------

Can you please test this patchset and see whether the performance problems
are resolved? After the patchset, unbound workqueues default to
soft-affining on cache boundaries, which should hopefully resolve the issues
that you guys have been seeing on recent kernels on heterogeneous CPUs.

If you want to try different settings, please read:

 https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/tree/Documentation/core-api/workqueue.rst?h=affinity-scopes-v1&id=e8f3505e69a526cc5fe40a4da5d443b7f9231016#n350

Alasdair Kergon, Mike Snitzer, DM folks
---------------------------------------

I ran fio on top of dm-crypt to compare performance of different
configurations. It mostly behaved as expected but please let me know if
anything doens't look right. Also, DM_CRYPT_SAME_CPU can now be implemented
by applying strict "cpu" scope on the unbound workqueue and it would make
sense to add WQ_SYSFS to the kcryptd workqueue so that users can tune the
settings on the fly.

Lai
---

I'd really appreciate if you could go over the series. 0003, 0007, 0009,
0018-0021, 0023-0024 are the interesting ones. 0003, 0019, 0020 and 0024 are
the potentially risky ones. I've been testing them pretty extensively for
over a week but the series can really use your eyes.


Introduction
============

Recently, IIRC, with chromeos moving to a newer kernel, there have been a
flurry of reports on unbound workqueues showing high execution latency and
low bandwidth. AFAICT, all were on heterogeneous CPUs with multiple L3
caches. Please see the discussions in the following threads.

 https://lkml.kernel.org/r/CAHk-=wgE9kORADrDJ4nEsHHLirqPCZ1tGaEPAZejHdZ03qCOGg@mail.gmail.com
 https://lkml.kernel.org/r/ZFvpJb9Dh0FCkLQA@google.com

While details from the second thread indicate that the problem is unlikely
to originate solely from workqueue, workqueue does have an underlying
problem that can be amplified through behavior changes in other subsystems.

Being an async execution mechanism, workqueue inherently disconnects issuer
and executor. Worker pools are shared across workqueues whenever possible
further severing the connection. While this disconnection is true for all
workqueues, for per-cpu workqueues, this doesn't harm locality because they
still all end up on the same CPU. For unbound workqueues tho, we end up
spraying work items across CPUs which blows away all locality.

This was already a noticeable issue with NUMA machines and 4c16bd327c74
("workqueue: implement NUMA affinity for unbound workqueues") implemented
NUMA support which segments unbound workqueues on NUMA node boundaries so
that each subset that's contained within a NUMA node is served by a separate
worker pool. Work items still get sprayed but they get sprayed only inside
its NUMA node.

This has been mostly fine but CPUs became a lot more complex with many more
cores and multiple L3 caches inside a single node with differeing distances
across them, and it looks like it's high time to improve workqueue's
locality awareness.


Design
======

There are two basic ideas.

1. Expand the segmenting so that unbound workqueues can be segmented on
   different boundaries including L3 caches.

2. The knoweldge about CPU topology is already in the scheduler. Instead of
   trying to steer things on its own, workqueue can inform the scheduler of
   the to-be-executed work item's locality and get out of its way. (Linus's
   suggestion)

#2 is nice in that it takes out workqueue out of the businness that it's not
good at. Even with #2, #1 is likely still useful as persistent locality of
workers affect cache hit ratio and memory distance on stack and shared data
structures.

Given the above, it could be that workqueue can do something like the
following and keep everyone more or less happy:

* Segment unbound workqueues according to L3 cache boundaries
  (cpus_share_cache()).

* Don't hard-affine workers but make a best-effort attempt to locate them on
  the same CPUs as the work items they are about to execute.

This way, the hot workers would stay mostly affine to the L3 cache domain
they're attached to and the scheduler would have the full knowledge of the
preferred locality when starting execution of a work item. As the workers
aren't strictly confined, the scheduler is free to move them outside that L3
cache domain or even across NUMA nodes according to the hardware
configuration and load situation. In short, we get both locality and
work-conservation.

Unfortunately, this didn't work out due to the pronounced inverse
correlation between locality and work-conservation, which will be
illustrated in the following "Results" section. As this meant that there is
not going to be one good enough behavior for everyone, I ended up
implementing a number of different behaviors that can be selected
dynamically per-workqueue.

There are three parameters:

* Affinity scope: Determines how unbound workqueues are segmented. Five
  possible values.

  CPU: Every CPU in its own scope. The unbound workqueue behaves like a
       per-cpu one.

  SMT: SMT siblings in the same scope.

  CACHE: cpus_share_cache() defines the scopes, usually on L3 boundaries.

  NUMA: NUMA nodes define the scopes. This is the same behavior as before
        this patchset.

  SYSTEM: A single scope across the whole system.

* Affinty strictness: If a scope is strict, every worker is confined inside
  its scope and the scheduler can't move it outside. If non-strict, a worker
  is brought back into its scope (called repatriation) when it starts to
  execute a work item but then can be moved outside the scope if the
  scheduler deems that the better course of action.

* Localization: If a workqueue enables localization, a worker is moved to
  the CPU that issued the work item at the start of execution. Afterwards,
  the scheduler can migrate the task according to the above affinity scope
  and strictness settings. Interestingly, this turned out to be not very
  useful in practice. It's implemented in the last two patches but they
  aren't for upstream inclusion, at least for now. See the "Results"
  section.

Combined, they allow a wide variety of configurations. It's easy to emulate
WQ_CPU_INTENSIVE per-cpu workqueues or the behavior before this patchset.
The settings can be changed anytime through both apply_workqueue_attrs() and
the sysfs interface allowing easy and flexible tuning.

Let's see how different configurations perform.


Experiment Setup
================

Here's the relevant part of the experiment setup.

* Ryzen 9 3900x - 12 cores / 24 threads spread across 4 L3 caches.
  Core-to-core latencies across L3 caches are ~2.6x worse than within each
  L3 cache. ie. it's worse but not hugely so. This means that the impact of
  L3 cache locality is noticeable in these experiments but may be subdued
  compared to other setups.

* The CPU's clock boost is disabled, so that all the clocks are running very
  close to the stock 3.8Ghz for test consistency.

* dm-crypt setup with default parameters on Samsung 980 PRO SSD.

* Each combination is run five times.

Three fio scenarios are run directly against the dm-crypt device.

  HIGH: Enough issuers and work spread across the machine

     fio --filename=/dev/dm-0 --direct=1 --rw=randrw --bs=32k \
     --ioengine=libaio --iodepth=64 --runtime=60 --numjobs=24 --time_based \
     --group_reporting --name=iops-test-job --verify=sha512

  MED: Fewer issuers, enough work for saturation

     fio --filename=/dev/dm-0 --direct=1 --rw=randrw --bs=32k \
     --ioengine=libaio --iodepth=64 --runtime=60 --numjobs=8 --time_based \
     --group_reporting --name=iops-test-job --verify=sha512

  LOW: Even fewer issuers, not enough work to saturate

     fio --filename=/dev/dm-0 --direct=1 --rw=randrw --bs=32k \
     --ioengine=libaio --iodepth=64 --runtime=60 --numjobs=4 --time_based \
     --group_reporting --name=iops-test-job --verify=sha512

  They are the same except for the number of issuers. The issuers generate
  data every time, write, read back and then verifiy the content. Each
  issuer can have 64 IOs in flight.

Five workqueue configurations are used:

  SYSTEM        A single scope across the system. All workers belong to the
                same pool and work items are sprayed all over. On this CPU,
		this is the same behavior as before this patchset.

  CACHE         Four scopes, each serving a L3 cache domain. The scopes are
                non-strict, so workers starts inside their scopes but the
		scheduler can move them outside as needed.

  CACHE+STRICT  The same as CACHE but the scopes are strict. Workers are
                confined within their scopes.

  SYSTEM+LOCAL  A single scope across the system but with localization
                turned on. A worker is moved to the issuing CPU of the work
                item it's about to execute.

  CACHE+LOCAL   Four scopes each serving a L3 cache domain with localization
                turned on. A worker is moved to the issuing CPU of the work
		item it's about to execute and is a lot more likely to
		be already inside the matching L3 cache domain.


Results
=======

1. HIGH: Enough issuers and work spread across the machine

                  Bandwidth (MiBps)    CPU util (%)    vs. SYSTEM BW (%)
  ----------------------------------------------------------------------
  SYSTEM              1159.40 ±1.34     99.31 ±0.02                 0.00
  CACHE               1166.40 ±0.89     99.34 ±0.01                +0.60
  CACHE+STRICT        1166.00 ±0.71     99.35 ±0.01                +0.57
  SYSTEM+LOCAL        1157.40 ±1.67     99.50 ±0.01                -0.17
  CACHE+LOCAL         1160.40 ±0.55     99.50 ±0.02                +0.09

The differences are small. Here are some observations.

* CACHE and CACHE+STRICT are clearly performing better. The difference is
  not big but consistent, which isn't too surprising given that these caches
  are pretty close. The CACHE ones are doing more work for the same number
  of CPU cycles compared to SYSTEM.

  This scenario is the best case for CACHE+STRICT, so it's encouraging that
  the non-strict variant can match.

* SYSTEM/CACHE+LOCAL aren't doing horribly but not better. They burned
  slightly more CPUs, possibly from the scheduler needing to move away the
  workers more frequently.


2. MED: Fewer issuers, enough work for saturation

                  Bandwidth (MiBps)    CPU util (%)    vs. SYSTEM BW (%)
  ----------------------------------------------------------------------
  SYSTEM             1155.40  ±0.89     97.41 ±0.05                 0.00
  CACHE              1154.40  ±1.14     96.15 ±0.09                -0.09
  CACHE+STRICT       1112.00  ±4.64     93.26 ±0.35                -3.76
  SYSTEM+LOCAL       1066.80  ±2.17     86.70 ±0.10                -7.67
  CACHE+LOCAL        1034.60  ±1.52     83.00 ±0.07               -10.46

There are still eight issuers and plenty of work to go around. However, now,
depending on the configuration, we're starting to see a significant loss of
work-conservation where CPUs sit idle while there's work to do.

* CACHE is doing okay. It's just a bit slower. Further testing may be needed
  to definitively confirm the bandwidth gap but the CPU util difference
  seems real, so while minute, it did lose a bit of work-conservation.
  Comparing it to CACHE+STRICT, it's starting to show the benefits of
  non-strict scopes.

* CACHE+STRICT's lower bw and utilization make sense. It'd be easy to
  mis-locate issuers so that some cache domains are temporarily underloaded.
  With scheduler not being allowed to move tasks around, there will be some
  utilization bubbles.

* SYSTEM/CACHE+LOCAL are not doing great with significantly lower
  utilizations. There are more than enough work to do in the system
  (changing --numjobs to 6, for example, doesn't change the picture much for
  SYSTEM) but the kernel is seemingly unable to dispatch workers to idle
  CPUs fast enough.


3. LOW: Even fewer issuers, not enough work to saturate

                  Bandwidth (MiBps)    CPU util (%)    vs. SYSTEM BW (%)
  ----------------------------------------------------------------------
  SYSTEM              993.60  ±1.82     75.49 ±0.06                 0.00
  CACHE               973.40  ±1.52     74.90 ±0.07                -2.03
  CACHE+STRICT        828.20  ±4.49     66.84 ±0.29               -16.65
  SYSTEM+LOCAL        884.20 ±18.39     64.14 ±1.12               -11.01
  CACHE+LOCAL         860.60  ±4.72     61.46 ±0.24               -13.39

Now, there isn't enough work to be done to saturate the whole system. This
amplifies the pattern which started to show up in the MED scenario.

* CACHE is now noticeably slower but not crazily so.

* CACHE+STRICT shows the severe work-conservation limitation of strict
  scopes.

* SYSTEM/CACHE+LOCAL show the same pattern as in the MED scenario but with
  larger work-conservation deficits.


Conclusions
===========

The tradeoff between efficiency gains from improved locality and bandwidth
loss from work-conservation deficit poses a conundrum. The scenarios used
for testing, while limited, are plausiable representations of what heavy
workqueue usage might look like in practice, and they clearly show that
there is no one straight-forward option which can cover all cases.

* The efficiency advantage of the CACHE over SYSTEM is, while consistent and
  noticeable, small. However, the impact is dependent on the distances
  between the scopes and may be more pronounced in processors with more
  complex topologies.

  While the loss of work-conservation in certain scenarios hurts, it is a
  lot better than CACHE+STRICT and maximizing workqueue utilization is
  unlikely to be the common case anyway. As such, CACHE is the default
  affinity scope for unbound pools.

  There's some risk to this decision and we might have to reassess depending
  on how this works out in the wild.

* In all three scenarios, +LOCAL didn't show any advantage. There may be
  scenarios where the boost from L1/2 cache locality is visible but the
  severe work-conservation deficits really hurt.

  I haven't looked into it too deeply here but the behavior where CPUs
  sitting idle while there's work to do is in line with what we (Meta) have
  been seeing with CFS across multiple workloads and I believe Google has
  similar experiences. Tuning load balancing and migration costs through
  debugfs helps but not fully. Deeper discussion on this topic is a bit out
  of scope here and there are on-going efforts on this front, so we can
  revisit later.

  So, at least in the current state, +LOCAL doesn't make sense. Let's table
  it for now. I put the two patches to implement it at the end of the series
  w/o SOB.


PATCHES
=======

This series contains the following patches.

 0001-workqueue-Drop-the-special-locking-rule-for-worker-f.patch
 0002-workqueue-Cleanups-around-process_scheduled_works.patch
 0003-workqueue-Not-all-work-insertion-needs-to-wake-up-a-.patch
 0004-workqueue-Rename-wq-cpu_pwqs-to-wq-cpu_pwq.patch
 0005-workqueue-Relocate-worker-and-work-management-functi.patch
 0006-workqueue-Remove-module-param-disable_numa-and-sysfs.patch
 0007-workqueue-Use-a-kthread_worker-to-release-pool_workq.patch
 0008-workqueue-Make-per-cpu-pool_workqueues-allocated-and.patch
 0009-workqueue-Make-unbound-workqueues-to-use-per-cpu-poo.patch
 0010-workqueue-Rename-workqueue_attrs-no_numa-to-ordered.patch
 0011-workqueue-Rename-NUMA-related-names-to-use-pod-inste.patch
 0012-workqueue-Move-wq_pod_init-below-workqueue_init.patch
 0013-workqueue-Initialize-unbound-CPU-pods-later-in-the-b.patch
 0014-workqueue-Generalize-unbound-CPU-pods.patch
 0015-workqueue-Add-tools-workqueue-wq_dump.py-which-print.patch
 0016-workqueue-Modularize-wq_pod_type-initialization.patch
 0017-workqueue-Add-multiple-affinity-scopes-and-interface.patch
 0018-workqueue-Factor-out-work-to-worker-assignment-and-c.patch
 0019-workqueue-Factor-out-need_more_worker-check-and-work.patch
 0020-workqueue-Add-workqueue_attrs-__pod_cpumask.patch
 0021-workqueue-Implement-non-strict-affinity-scope-for-un.patch
 0022-workqueue-Add-Affinity-Scopes-and-Performance-sectio.patch
 0023-workqueue-Add-pool_workqueue-cpu.patch
 0024-workqueue-Implement-localize-to-issuing-CPU-for-unbo.patch

This series is also available in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git affinity-scopes-v1

diffstat follows. Thanks.

 Documentation/admin-guide/kernel-parameters.txt |   21
 Documentation/core-api/workqueue.rst            |  379 ++++++++++-
 include/linux/workqueue.h                       |   82 ++
 init/main.c                                     |    1
 kernel/workqueue.c                              | 1613 +++++++++++++++++++++++++++-----------------------
 kernel/workqueue_internal.h                     |    2
 tools/workqueue/wq_dump.py                      |  180 +++++
 tools/workqueue/wq_monitor.py                   |   29
 8 files changed, 1525 insertions(+), 782 deletions(-)


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2066D34EA
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 01:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjDAXGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 19:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDAXGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 19:06:34 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6262549FC
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 16:06:31 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 205-20020a2503d6000000b00b7411408308so24904688ybd.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 16:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680390390;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SqS7NeIn9ZAaH2g5o2FlHKyRlUYa15nEI13JolGTGBc=;
        b=P3pzt+S6lHNbYUMaKhoLMzPnGJX2GUg/YTp9Z+XyNRWxr7wWYTgfhRMkUHj/YdB3IO
         DTfUdRPtbs6hLQVwWWuZ/iQ148IB2KoCfXFM5XHuppnERf8smS1qZM9vDbm4Q2SFQ3Mj
         5agGDMH+UDVY9vhWlLeMOcL58GmlUphcxXj1OUa5SGRb8YLms6fZY19OSgQT3qAtDn4l
         rE3zOVKhjxwctGYJywKqu/eA9KwWUyl73qN4LoRUU+wWpKsvRxiLRh3zU8DRNJjLQFra
         Wnn4pk2AkvMttCPe6u7nJy5HXsa7pfw/9MWVRSscVlZKm5JsiBdvU2otjVc/PgRmt2hJ
         lN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680390390;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SqS7NeIn9ZAaH2g5o2FlHKyRlUYa15nEI13JolGTGBc=;
        b=MHpuLDpAECVsEbVwWbTryHwNYOu6O8vwoAkGvtOoSKMX4yOhFx2NXVRtRkG1M9G7ts
         81hr7aqflWm+2Qa0JTRy7m+iLFMOSoytBSuA9zmlmo7QH6hoV1QFJBuounr233hKtcYy
         Pwk7GvUxzzz9ulE4W5v83EWkCqZq8t1JS7zDJF6HT5hIsWOO1jwZ2nGrs73T3zNzDtuZ
         r5wJgJpcjSPIW5UC2kJXdiLu/9qxBEHC1ZZM0YjiDAUANxrb5y6x84st1uJASTnaJMLw
         HI76orF0rMKLQaPqrwKqSnwg3LdN96RbBcFlEf0gk6lxEZbOh9VgrholUASCpSRT9GiQ
         bsvA==
X-Gm-Message-State: AAQBX9dMl9Og9OO3Yu7e+jzALu3jZvvHXKSW/Sq2RMNtJ2bQXkvXdnXn
        FKYEhJRsDrZfVdg2SSBrW2bPhh0N6cuuCbmov2vVx+/D+QYNoERIblufOotfuq1MIYAt9kM+fwn
        /8Dy+qb1e2eHyHDP5bbvUNglWtf/Ob5xZfJkRC62F8QS4FJI+CaNlMUo0RGuvsw==
X-Google-Smtp-Source: AKy350YLyunw2D5E3H9YhO54u8wkDxhyZVR6wO1PltYtEau9UBprXZgeL13rZ/KivDNtmz0/nUt9JXI=
X-Received: from hvdc.svl.corp.google.com ([2620:15c:2d4:203:b6c1:568c:89f6:f946])
 (user=xii job=sendgmr) by 2002:a81:ac0e:0:b0:541:6dce:50d6 with SMTP id
 k14-20020a81ac0e000000b005416dce50d6mr15851544ywh.1.1680390390350; Sat, 01
 Apr 2023 16:06:30 -0700 (PDT)
Date:   Sat,  1 Apr 2023 16:05:55 -0700
Message-Id: <20230401230556.2781604-1-xii@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH 0/1] [RFC] Morphing CFS into FDL, The Fair Deadline Scheduling Class
From:   Xi Wang <xii@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Xi Wang <xii@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is about putting every thread under some aggregated deadline.

Note: In draft status, one big patch, not always conforming to coding 
style etc. Only hooked to cgroup v1 at the moment. Based on 6.1.21.  
Usage case, scheduling model and sched policy are more important than 
the details.


Motivation:

Shared servers running multiple, often unrelated jobs in cgroup based 
containers. Ideally each job runs under the illusion that it has the 
whole machine or a slice of the machine, not affected by other jobs. 
A challenge is that we want to maintain the illusion while 
overcommitting cpu bandwidth for efficiency. Most of the time this is 
possible due to statistical multiplexing effect, at least in theory.

Another challenge is some jobs on the shared machines are by 
definition real time workloads, which often happens due to the 
fan-out pattern. An upper layer service may need to query many lower 
layer services before it can assemble the result and respond to a 
query resulting in amplified tail latency. The median latency of the 
upper layer query is determined by the tail latency of the lower 
layer queries. Bonded tail latency for lower layer services becomes 
much more important. We can end up running real-time servers without 
knowing it.


Main goals:

  - Sched latency guarantees
  - CPU bandwidth guarantees
  - Real time support for all workloads, be generic and scalable
  - Per cgroup policies
  - Hierarchical scheduling - typically real-time for first level 
    cgroups and best effort for lower cgroups
  - Seamless transition for existing workloads


Scheduling model:

FDL is based on my draining buckets model which still needs a more 
detailed definition. However the core idea should be intuitive. The 
model was inspired by media streaming applications. It might be 
considered a type of deadline scheduling and/or equivalent to some 
other models. If a device receives an audio stream, processes it and 
plays it through a speaker, the rx buffer can overflow if the cpu is 
on something else for too long, then we get audio glitches. To avoid 
buffer overflows, the receiving thread has to get enough cpu cycles 
and there cannot be off-cpu gaps too large, thus the requirements are 
on both latency and cpu bandwidth. If we model every workload this 
way we get the draining buckets model. The scheduler's job is 
simply about preventing any bucket from overflowing. This is a 
continuous model with no event arrival intervals or quota 
replenishment periods, etc. The round robin deadline is simply the 
time to fill up an empty bucket.

The model was designed to be resilient, backward compatible and 
natively support overcommit. It prefers graceful degradation over 
admission control.


Interface:

Each cpu cgroup controller has 3 new parameters (per thread control 
is not supported at the moment).

cpu.deadline_rr: round robin latency in ns
cpu.deadline_wakeup: optional wake up boost, latency in ns
cpu.guaranteed_shares: cpu bandwidth allocation, 1024 == 1 cpu for 
first level cgroups, relative for lower cgroups


Implementation:

Backward compatibility is a major challenge to a generic latency 
aware scheduling policy. Many applications have adapted to various 
CFS behaviors over the years. Moving all of them to a new sched class 
without causing a few performance regressions is rather difficult. 
Moving only the latency sensitive applications to a new sched class 
does not make the problem much easier - two scheduling classes can 
easily create priority inversion problems. Existing high priority 
scheduling classes do have mechanisms to yield to low priority sched 
classes to prevent starvation, yet these mechanisms are difficult to 
tune and they can hurt the tail latency of high priority sched 
classes. The dilemma is new low latency applications can be much 
better supported if all threads are put in a new sched class, but old 
applications have a much better chance of still working if they are 
still in the old sched class.

This patch might be an unexpected take on the tradeoffs. It took a 
shortcut by directly modifying CFS to add latency support. Individual 
cgroups can be flipped to FDL and the remaining cgroups should see 
minimal disruption. ("Real-time containers" might sound like a 
joke but FDL is actually supporting them.) It also reuses the 
recursive mechanisms of fair group scheduling to support hierarchical 
scheduling. I also do not expect moving to a clean sheet design later 
will be made more difficult by FDL.

CFS is already similar to a deadline scheduler in that it picks the 
next task from a vruntime based rb tree. A deadline based rb tree is 
added in parallel to the vruntime tree to support latency based 
scheduling. The deadline tree is examined before the vruntime tree on 
pick next.

CFS is not a global scheduler so some compromises were made for 
multi-core scheduling. The deadline based pick next is cpu local but 
deadline awareness was added to the wake up load balancing path to 
even out the deadline pressure. A feedback loop is used to 
dynamically adjust the cgroup cpu shares and provide cpu bandwidth 
guarantee.


Compared to EEVDF:

I only have a shallow understanding of EEVDF scheduler so the 
comparison is also limited. They have both similarities and 
differences. The most prominent similarity might be that both are 
latency aware, generic sched classes taking the place of CFS. Some 
differences are: FDL tries to be as real time as possible, supporting 
configurable deadlines down to microseconds. FDL also aims to be non 
disruptive to user applications. The threads not configured to run 
under FDL should still see CFS behavior with minimal change, which is 
a reason for modifying CFS instead of creating a completely new sched 
class.


Example:

The script below launches 4 workloads in 4 cgroups and run them 
concurrently: hackbench as the antagonist. 3 schbench with identical 
command line parameters but different cgroup configurations as 
workloads. One schbench instance runs under cfs and the other two 
instances run under fdl with different deadline parameters.

The schbench stats from one of the test runs (2 socket x 24 core / 96 
hyperthread cascadelake):

==== cfs ====
warmup done, zeroing stats
Latency percentiles (usec) runtime 30 (s) (8496 total samples)
	50.0th: 417 (4248 samples)
	75.0th: 2268 (2129 samples)
	90.0th: 5512 (1270 samples)
	95.0th: 9168 (429 samples)
	*99.0th: 19936 (337 samples)
	99.5th: 25440 (42 samples)
	99.9th: 37952 (35 samples)
	min=7, max=59690

==== fdl loose ====
warmup done, zeroing stats
Latency percentiles (usec) runtime 30 (s) (8544 total samples)
	50.0th: 52 (4304 samples)
	75.0th: 68 (2167 samples)
	90.0th: 84 (1240 samples)
	95.0th: 97 (411 samples)
	*99.0th: 1378 (338 samples)
	99.5th: 2428 (44 samples)
	99.9th: 5608 (32 samples)
	min=6, max=23616

==== fdl ====
warmup done, zeroing stats
Latency percentiles (usec) runtime 30 (s) (8534 total samples)
	50.0th: 48 (4325 samples)
	75.0th: 63 (2210 samples)
	90.0th: 76 (1204 samples)
	95.0th: 85 (387 samples)
	*99.0th: 115 (323 samples)
	99.5th: 725 (43 samples)
	99.9th: 5400 (35 samples)
	min=1, max=12046

Data extracted from 3 test runs with antagonist and 3 test runs 
without antagonist

                           p50 latency        p99 latency
cfs with antagonist        300, 280, 417      18528, 20960, 19339
fdl-loose with antagonist  52, 51, 52         1722, 1942, 1378
fdl with antagonist        51, 49, 48         609, 234, 115

cfs no antagonist          38, 85, 69         123, 129, 124
fdl-loose no antagonist    85, 54, 84         128, 129, 124
fdl no antagonist          53, 52, 63         129, 118, 128


The test script:

antagonist=true

CR=<cgroup root>

killall hackbench

if $antagonist; then
  mkdir -p $CR/antagonist
  echo $$ > $CR/antagonist
  hackbench -g 10 -f 10 -s 20000 --loops 1000000 > /dev/null&
  sleep 5
fi

mkdir -p $CR/cfs
echo $$ > $CR/cfs/tasks
echo 0 > $CR/cfs/cpu.deadline_rr
echo 0 > $CR/cfs/cpu.deadline_wakeup
echo 0 > $CR/cfs/cpu.guaranteed_shares
schbench -r 30 -i -1 &> log-cfs &

mkdir -p $CR/fdl-loose
echo $$ > $CR/fdl-loose/tasks
echo 5000000 > $CR/fdl-loose/cpu.deadline_rr
echo 2500000 > $CR/fdl-loose/cpu.deadline_wakeup
echo 7000 > $CR/fdl-loose/cpu.guaranteed_shares
schbench -r 30 -i -1 &> log-fdl-loose &

mkdir -p $CR/fdl
echo $$ > $CR/fdl/tasks
echo 200000 > $CR/fdl/cpu.deadline_rr
echo 100000 > $CR/fdl/cpu.deadline_wakeup
echo 7000 > $CR/fdl/cpu.guaranteed_shares
schbench -r 30 -i -1 &> log-fdl &


echo $$ > $CR/tasks

sleep 40

echo ==== cfs ====
cat log-cfs
echo
echo ==== fdl loose ====
cat log-fdl-loose
echo
echo ==== fdl ====
cat log-fdl
echo

killall hackbench




Xi Wang (1):
  [RFC] sched: Morphing CFS into FDL, The Fair Deadline Scheduling Class

 include/linux/sched.h     |   7 +
 kernel/sched/Makefile     |   1 +
 kernel/sched/core.c       | 162 ++++++-
 kernel/sched/cpuacct.c    |   5 +
 kernel/sched/debug.c      |  10 +
 kernel/sched/fair.c       | 927 +++++++++++++++++++++++++++++++++++++-
 kernel/sched/features.h   |   2 +-
 kernel/sched/qos.c        | 305 +++++++++++++
 kernel/sched/qos.h        | 135 ++++++
 kernel/sched/qos_params.h |  30 ++
 kernel/sched/sched.h      |  60 +++
 kernel/sched/stats.h      |  10 +
 12 files changed, 1620 insertions(+), 34 deletions(-)
 create mode 100644 kernel/sched/qos.c
 create mode 100644 kernel/sched/qos.h
 create mode 100644 kernel/sched/qos_params.h

-- 
2.40.0.348.gf938b09366-goog


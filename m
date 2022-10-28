Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605C2610B5D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 09:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiJ1Hgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 03:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiJ1Hgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 03:36:48 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5613C96EB
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 00:36:47 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l16-20020a05600c4f1000b003c6c0d2a445so2908938wmq.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 00:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ub7LESZm7rGS/9UKEkJLDWA05ykYnzAVHyB5ebjfxZc=;
        b=OjY8S+FBmg7OxN6bhH+Oo2FKf3O13U+qXzLQdcoNFCOodLb2mFKrLcbs1/j6l1Tlx2
         oWD/Hu9tDknJDxvCLryk5DVByjdKp4R2SmSZbuCZn2WDgndu5rF51FNKdvsmkGSiFSGa
         PtEzQEGPaFWtcwnGtttrOiYmUcDZ2nb+qlqnWrwcbfxUTakgeW7MfSw35BvNWyY5LnlH
         jJm2QHhEjt1Z8p8w0674/vsz27WKOZ6miy9SYlHftq2OkVHt+y3hk3ByRhSpSJpg0zpr
         Jty6rnBtEby1e46829P3kR4ZrCm6BQq7kb7CFjMlWP3kjzMHcg46EMQa9pKvndKriB0o
         7cGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ub7LESZm7rGS/9UKEkJLDWA05ykYnzAVHyB5ebjfxZc=;
        b=aCdzwSylJXmArDRZknxtbJ90iePiHT4ebNQ4LVNNWoLOf+BaSpvwNl2yEReAsDL2Xn
         l6xe8V9S/h9XZXMq6J8DwvGiLXUb2F/sedrZYJ+vv+vucdDNpXI3HLOvhxLNCqh8gpHj
         f54IMuxjl6Cnq0tH1o+fLUy7oQ6oxiOwF0PD3lM6XoR0UDsakzo8k5cuRlwN75SvN83Y
         q1s5vEdxu0cNGRjhYMqedOUX7kJFUzK//+rk34f387exLXnwh52ICOb/6JTL0qxQgbdN
         jBQd8SyYuiomHplED/04IAEOOOmBwYKZ+U4+yKSmEPd41peBOOdxzdjHhP1V0t227Egb
         BQFw==
X-Gm-Message-State: ACrzQf0H4tmljsjouWsUb+vHxj4tc0H50fCRQNRDA88afPGaB0qO2r/u
        ikRIhrxXOSAEHg/kbLKtoVdmcg==
X-Google-Smtp-Source: AMsMyM4RJ3OlB8AilYNz+9PEoA7P40xX7eKwRszqxB9RYq7dS+cc93bpua2tw9ElVh40izMFPvibuA==
X-Received: by 2002:a05:600c:502c:b0:3ce:794f:d664 with SMTP id n44-20020a05600c502c00b003ce794fd664mr8420904wmr.33.1666942606099;
        Fri, 28 Oct 2022 00:36:46 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:c12b:b448:f0a9:83ef])
        by smtp.gmail.com with ESMTPSA id j8-20020a05600c190800b003b47e8a5d22sm7783129wmq.23.2022.10.28.00.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 00:36:44 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com
Cc:     qais.yousef@arm.com, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v6 0/9] Add latency priority for CFS class
Date:   Fri, 28 Oct 2022 09:36:28 +0200
Message-Id: <20221028073637.31195-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset restarts the work about adding a latency priority to describe
the latency tolerance of cfs tasks.

Patch [1] is a new one that has been added with v6. It fixes an
unfairness for low prio tasks because of wakeup_gran() being bigger
than the maximum vruntime credit that a waking task can keep after
sleeping.

The patches [2-4] have been done by Parth:
https://lore.kernel.org/lkml/20200228090755.22829-1-parth@linux.ibm.com/

I have just rebased and moved the set of latency priority outside the
priority update. I have removed the reviewed tag because the patches
are 2 years old.

This aims to be a generic interface and the following patches is one use
of it to improve the scheduling latency of cfs tasks.

Patch [5] uses latency nice priority to define a latency offset
and then decide if a cfs task can or should preempt the current
running task. The patch gives some tests results with cyclictests and
hackbench to highlight the benefit of latency priority for short
interactive task or long intensive tasks.

Patch [6] adds the support of latency nice priority to task group by
adding a cpu.latency.nice field. The range is [-20:19] as for setting task
latency priority.

Patch [7] makes sched_core taking into account the latency offset.

Patch [8] adds a rb tree to cover some corner cases where the latency
sensitive task (priority < 0) is preempted by high priority task (RT/DL)
or fails to preempt them. This patch ensures that tasks will have at least
a slice of sched_min_granularity in priority at wakeup.

Patch [9] removes useless check after adding a latency rb tree.

I have also backported the patchset on a dragonboard RB3 with an android
mainline kernel based on v5.18 for a quick test. I have used the
TouchLatency app which is part of AOSP and described to be a very good
test to highlight jitter and jank frame sources of a system [1].
In addition to the app, I have added some short running tasks waking-up
regularly (to use the 8 cpus for 4 ms every 37777us) to stress the system
without overloading it (and disabling EAS). The 1st results shows that the
patchset helps to reduce the missed deadline frames from 5% to less than
0.1% when the cpu.latency.nice of task group are set. I haven't rerun the
test with latest version.

I have also tested the patchset with the modified version of the alsa
latency test that has been shared by Tim. The test quickly xruns with
default latency nice priority 0 but is able to run without underuns with
a latency -20 and hackbench running simultaneously.

[1] https://source.android.com/docs/core/debug/eval_perf#touchlatency

Change since v5:
- Add patch 1 to fix unfairness for low prio task. This has been
  discovered while studying Youssef's tests results with latency nice
  which were hitting the same problem.
- Fixed latency_offset computation to take into account
  GENTLE_FAIR_SLEEPERS. This has diseappeared with v2and has been raised
  by Youssef's tests.
- Reworked and optimized how latency_offset in used to check for
  preempting current task at wakeup and tick. This cover more cases too.
- Add patch 9 to remove check_preempt_from_others() which is not needed
  anymore with the rb tree.

Change since v4:
- Removed permission checks to set latency priority. This enables user
  without elevated privilege like audio application to set their latency
  priority as requested by Tim.
- Removed cpu.latency and replaced it by cpu.latency.nice so we keep a
  generic interface not tied to latency_offset which can be used to
  implement other latency features.
- Added an entry in Documentation/admin-guide/cgroup-v2.rst to describe
  cpu.latency.nice.
- Fix some typos.

Change since v3:
- Fix 2 compilation warnings raised by kernel test robot <lkp@intel.com>

Change since v2:
- Set a latency_offset field instead of saving a weight and computing it
  on the fly.
- Make latency_offset available for task group: cpu.latency
- Fix some corner cases to make latency sensitive tasks schedule first and
  add a rb tree for latency sensitive task.

Change since v1:
- fix typo
- move some codes in the right patch to make bisect happy
- simplify and fixed how the weight is computed
- added support of sched core patch 7

Parth Shah (3):
  sched: Introduce latency-nice as a per-task attribute
  sched/core: Propagate parent task's latency requirements to the child
    task
  sched: Allow sched_{get,set}attr to change latency_nice of the task

Vincent Guittot (6):
  sched/fair: fix unfairness at wakeup
  sched/fair: Take into account latency priority at wakeup
  sched/fair: Add sched group latency support
  sched/core: Support latency priority with sched core
  sched/fair: Add latency list
  sched/fair: remove check_preempt_from_others

 Documentation/admin-guide/cgroup-v2.rst |   8 +
 include/linux/sched.h                   |   5 +
 include/uapi/linux/sched.h              |   4 +-
 include/uapi/linux/sched/types.h        |  19 +++
 init/init_task.c                        |   1 +
 kernel/sched/core.c                     | 105 ++++++++++++
 kernel/sched/debug.c                    |   1 +
 kernel/sched/fair.c                     | 210 ++++++++++++++++++++----
 kernel/sched/sched.h                    |  65 +++++++-
 tools/include/uapi/linux/sched.h        |   4 +-
 10 files changed, 386 insertions(+), 36 deletions(-)

-- 
2.17.1


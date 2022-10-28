Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FDE610D60
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 11:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiJ1JfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 05:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiJ1Je7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 05:34:59 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD1859735
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 02:34:55 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id m29-20020a05600c3b1d00b003c6bf423c71so6158706wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 02:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2SR1GJNwi0ZTsIhXMdVd/To53jjHkf1X4Y3FfkRIlU=;
        b=VLZtiVBAbx3/CxG0O0DqiJtoilpnRFUgcs9BgWRYOPSbfWoaPhGaZzHzhE4yNDVDQk
         a89p79bcnKgY0U5HeeGDB0ekWeV6AZRM3W+S99F1XrM3e5xJt4LQ9pXjPE8OLoPnQXLM
         7MenFyxfOj0mJ4+mkJBMok/COhY9IwWgAdQDA33XYrzHWYpIo9UdpKky6e4VmPUZEzCU
         w5Sbvr2ZqthxdarMTIOPjGlVpN6QfgKbFHbFHDvkyDrB8N4CyAgaqHdfYq8QhKaPLL75
         oSSAOwzw9w3hCzS6cIOPwarItOd3ztkuQRyCtsB4f0hsoS4+irsZ+h8GnY9HfrL6l0va
         lX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h2SR1GJNwi0ZTsIhXMdVd/To53jjHkf1X4Y3FfkRIlU=;
        b=W7y/cgOka8sAasJqagosM3kylPtRkuxSvwajpQyKgBk+8teXHoTL2Gh93oLn32fdRc
         HvKPzhj4US7UWEN2j86ADcPN7mcq0gGQfIGjx58uvhseHG+SSKEnONFm2rKJhj28JyB2
         rop/vBPRQthhrVyfnkc0pt6xBEdGWQ4ivXg7pKGL1wi5FtzN6vJav9hQ/zbp7qgI1M/f
         EB85fsYWMGHLnpTjw8/CJiwNVF+g+lmiA8YRUlEzw55eh2z7dhRC+zeEWjitnaez/Bow
         fGPbAWdk4pSg2wDJ01/aq3MyNmsfmI99HNTWKLXH0vXVbsQcJltFnlcKP6EveMrHBodL
         qB+Q==
X-Gm-Message-State: ACrzQf3p0FYRgr+eWLpuZuc0w1r0iuzvG42UJdmj0DhIDFgW3MEQoT4P
        1VtoMbkrMqti06p4S6JBII4XIA==
X-Google-Smtp-Source: AMsMyM4BqRKPTSbx2BX1W7Z4D+dzTsD3JgHB+FSOXS63OLBXjSGphG+KVwJD2d3sdQDMauu7Ne3Z+g==
X-Received: by 2002:a05:6000:1c1a:b0:236:8321:d875 with SMTP id ba26-20020a0560001c1a00b002368321d875mr11103594wrb.45.1666949693722;
        Fri, 28 Oct 2022 02:34:53 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:c12b:b448:f0a9:83ef])
        by smtp.gmail.com with ESMTPSA id k3-20020a05600c1c8300b003c6b7f5567csm10909426wms.0.2022.10.28.02.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 02:34:52 -0700 (PDT)
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
Subject: [PATCH v7 0/9] Add latency priority for CFS class
Date:   Fri, 28 Oct 2022 11:33:54 +0200
Message-Id: <20221028093403.6673-1-vincent.guittot@linaro.org>
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

Change since v6:
- Fix compilation error for !CONFIG_SCHED_DEBUG

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


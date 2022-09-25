Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722E95E93AB
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 16:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbiIYOlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 10:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiIYOlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 10:41:16 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888972DE6
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 07:41:14 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id n12so6684346wrx.9
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 07:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Npocxvpr9TZgMWdDjzYbDm/3jhFMXbrb/YqHwxUq9pU=;
        b=e/ku+ctZ/WzQJwWcAwDsMAPcqV8N3StqL5zVorcdJwg6TvocKPxVvvcz6ygp4F1jY+
         s/bp3hPZUWE18bXXyrER1xxQJPIKiJaXGRkYj9vRXposrYaNrWkFwVTIRI1+OK1wGq1x
         W2/m0YvDV18s4EeKsYYMZtSH259GUAru+ewfSzA+VJxLPoRfZUq5EDH14qjzsdZar2Bb
         VXv3M7e7dxp2P97bkTkeufd15mq8/7DCX7dchpU/oggLZi9Z6kWq+U0JAd8wfJ+EQSzu
         PfiSg50jsMx/LGvY/1lmTKPcm3ZR6LZkkZFFiDMQfSUaPZ10WLxG3Y8hHeTpw0xIFKbj
         4hag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Npocxvpr9TZgMWdDjzYbDm/3jhFMXbrb/YqHwxUq9pU=;
        b=CAqLhy8MTyUNVPAafcCrxi7ATFVKw2/moPZAKUgeyVimJx32aH7Xy2MvsU3Zsv8RRF
         vvtUH2cF7hzjLHlhhi9BeNEbXWL9X3J1TBeMlrVrAkvydatGwTew/ozwIAkpBP8td6lG
         6fC/7L9Lp1BnNseobw9Tj9F+dATWyZiKdDG0Wqkx2DoLVgYlSWBq7rXghVVBERf7QBxP
         uCgdwe4HTJHNPrhQe8IT7UdKMcREhsJM1yFEQJfsLy8MRGchvMyFMY2/ca4+hH7o2Qgy
         alFEMukRc1ORdNtmogzlo8Ze3+LV8goT4q7FcBX2y2KQPWkCE05cMlXIJo+GiF+OF9Yt
         wupQ==
X-Gm-Message-State: ACrzQf37+dOPOnuf9JfjzDr9fOJcSWCJVzsQdPdKnornxVj0Q3cNQBxX
        DQgI2v60Z9kVT95fm4bX2dQfhw==
X-Google-Smtp-Source: AMsMyM6fLzIjom2/spigaatSVjPmV+ss/Yuew+5ILe3sB3w5bhqD1OYJt7C5GhlL4WWu6EBeOiNA7Q==
X-Received: by 2002:a5d:4b84:0:b0:228:7e07:115e with SMTP id b4-20020a5d4b84000000b002287e07115emr10600822wrt.168.1664116872960;
        Sun, 25 Sep 2022 07:41:12 -0700 (PDT)
Received: from localhost.localdomain (91-160-61-128.subs.proxad.net. [91.160.61.128])
        by smtp.gmail.com with ESMTPSA id m10-20020a05600c3b0a00b003b47b913901sm20774761wms.1.2022.09.25.07.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 07:41:12 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com
Cc:     qais.yousef@arm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v5 0/7]  Add latency priority for CFS class
Date:   Sun, 25 Sep 2022 16:39:01 +0200
Message-Id: <20220925143908.10846-1-vincent.guittot@linaro.org>
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

The patches [1-3] have been done by Parth:
https://lore.kernel.org/lkml/20200228090755.22829-1-parth@linux.ibm.com/

I have just rebased and moved the set of latency priority outside the
priority update. I have removed the reviewed tag because the patches
are 2 years old.

This aims to be a generic interface and the following patches is one use
of it to improve the scheduling latency of cfs tasks.

The patch [4] uses latency nice priority to define a latency offset
and then decide if a cfs task can or should preempt the current
running task. The patch gives some tests results with cyclictests and
hackbench to highlight the benefit of latency priority for short
interactive task or long intensive tasks.

Patch [5] adds the support of latency nice priority to task group by
adding a cpu.latency.nice field. The range is [-20:19] as for setting task
latency priority.

Patch [6] makes sched_core taking into account the latency offset.

Patch [7] adds a rb tree to cover some corner cases where the latency
sensitive task (priority < 0) is preempted by high priority task (RT/DL)
or fails to preempt them. This patch ensures that tasks will have at least
a slice of sched_min_granularity in priority at wakeup. The patch gives
results to show the benefit in addition to patch 4.

I have also backported the patchset on a dragonboard RB3 with an android
mainline kernel based on v5.18 for a quick test. I have used the
TouchLatency app which is part of AOSP and described to be a very good
test to highlight jitter and jank frame sources of a system [1].
In addition to the app, I have added some short running tasks waking-up
regularly (to use the 8 cpus for 4 ms every 37777us) to stress the system
without overloading it (and disabling EAS). The 1st results shows that the
patchset helps to reduce the missed deadline frames from 5% to less than
0.1% when the cpu.latency.nice of task group are set.

I have also tested the patchset with the modified version of the alsa
latency test that has been shared by Tim. The test quickly xruns with
default latency nice priority 0 but is able to run without underuns with
a latency -20 and hackbench running simultaneously.


[1] https://source.android.com/docs/core/debug/eval_perf#touchlatency

Change since v4:
- Removed permission checks to set latency priority. This enables user
  without elevated priviledge like audio application to set their latency
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

Vincent Guittot (4):
  sched/fair: Take into account latency priority at wakeup
  sched/fair: Add sched group latency support
  sched/core: Support latency priority with sched core
  sched/fair: Add latency list

 Documentation/admin-guide/cgroup-v2.rst |   8 +
 include/linux/sched.h                   |   5 +
 include/uapi/linux/sched.h              |   4 +-
 include/uapi/linux/sched/types.h        |  19 +++
 init/init_task.c                        |   1 +
 kernel/sched/core.c                     | 106 +++++++++++++
 kernel/sched/debug.c                    |   1 +
 kernel/sched/fair.c                     | 189 +++++++++++++++++++++++-
 kernel/sched/sched.h                    |  37 ++++-
 tools/include/uapi/linux/sched.h        |   4 +-
 10 files changed, 366 insertions(+), 8 deletions(-)

-- 
2.17.1


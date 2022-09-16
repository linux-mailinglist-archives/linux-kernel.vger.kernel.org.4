Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72245BA7B6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 10:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiIPIDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 04:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiIPIDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 04:03:15 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7AC901B1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 01:03:14 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id cc5so24864234wrb.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 01:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=w6vym5JlipCPdXPV7HoDw1p2fzEHGSNtSSFP9E2kLBA=;
        b=FGxhTU/xqJMdTY7mu/dyKiul/UMbDFVllXGVJTVdef8JiMIqGQ8D0kt7ABRyzqAhTi
         Xbyxmv2jlcXHJ/dxfhh9wdW3agvPQsxLPBDO7h9nLCUfaDXdtIfYIS/9p8nNN+KbYDTm
         u+6z9C6BSVzoiRCFAMV9kfCG10H4Qb6AtcZejdTIHpRv7T0yu71+bXmXXjXCcllf0xgW
         DcHaVq7+hxZZ1YvWA76fMma8QrU7o+yRt4x9jsEEFt6SQUP5ZmxDUIcBh8RfBWe1q8sJ
         uDVb2ufDHJgQXBuwrdHDLxS8qjI0FvQNCQnAmrK3ijRc74bTFz43ORfopzpHPVB63B23
         MFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=w6vym5JlipCPdXPV7HoDw1p2fzEHGSNtSSFP9E2kLBA=;
        b=a/CrCWRnqB4LkahHzrPGwarXGCcz+leI2ReEt/JCvy+I//EzAq5bLha6sv1jRxnYgt
         XBVzTyL818OwZrdKLURMrXKQ/6Lv/czPSocgqYH5sDUSYZBo+kmRXGrU3Tw6X5KV1dfx
         0Uizb90JLdKcIfuiAjWdoWmNKDBRSEnz1py0NjZ1WxLO9CloWJZglvfhfkoKnBaJrgr7
         c2KkwfSsOAy1l1IO50HLnMnDAO0LWVASnAODXTDOHmqumu4gYentRL+rv9LUfTHE1TKG
         Wvk3hBzNOqNVoDitCAoeaGKA2s3/uTBOoclpTvb8CyHQf3pWhGm6KK/pjBXCaz8kLdFq
         WVyg==
X-Gm-Message-State: ACrzQf0U1ld0dJtKoL6MxkB9BJ6or7oq0JmNkjSaLXtBq6My0GF226RK
        CFftSLlj/0D1/3UGYGBuUJ44MQ==
X-Google-Smtp-Source: AMsMyM4f09t0UUPta93pWwjPuotYFjIDO9bichlbyG4jJnMTLCrjL7j/NcyuY9ZMUPYiPKjD/1eiOw==
X-Received: by 2002:a5d:6daa:0:b0:22a:da94:abe4 with SMTP id u10-20020a5d6daa000000b0022ada94abe4mr1892173wrs.543.1663315392742;
        Fri, 16 Sep 2022 01:03:12 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:9ab:1164:827a:1548])
        by smtp.gmail.com with ESMTPSA id c9-20020adffb49000000b00228dbf15072sm4418116wrs.62.2022.09.16.01.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 01:03:11 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com
Cc:     qais.yousef@arm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v4 0/8]  Add latency priority for CFS class
Date:   Fri, 16 Sep 2022 10:02:57 +0200
Message-Id: <20220916080305.29574-1-vincent.guittot@linaro.org>
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

The patches [1-4] have been done by Parth:
https://lore.kernel.org/lkml/20200228090755.22829-1-parth@linux.ibm.com/

I have just rebased and moved the set of latency priority outside the
priority update. I have removed the reviewed tag because the patches
are 2 years old.

The patch [5] uses latency nice priority to define a latency offset
and then to decide if a cfs task can preempt the current running task. The
patch gives some tests results with cyclictests and hackbench to highlight
the benefit of latency priority for short interactive task or
long intensive tasks.

Patch [6] adds the support of latency_offset to task group by adding a
cpu.latency field. There were discussions for the last version about
using a real unit for the field so I decided to expose directly the
latency offset which reflects the time up to which we can preempt when the
value is negative, or up to which we can defer the preemption when the
value is positive.
The range is [-sysctl_sched_latency:sysctl_sched_latency]

Patch [7] makes sched_core taking into account the latency offset.

Patch [8] adds a rb tree to cover some corner cases where the latency
sensitive task is preempted by high priority task (RT/DL) or fails to
preempt them. This patch ensures that tasks will have at least a
slice of sched_min_granularity in priority at wakeup. The patch gives
results to show the benefit in addition to patch 5

I have also backported the patchset on a dragonboard RB3 with an android
mainline kernel based on v5.18 for a quick test. I have used
the TouchLatency app which is part of AOSP and described to be very good
test to highlight jitter and jank frame sources of a system [1].
In addition to the app, I have added some short running tasks waking-up
regularly (to use the 8 cpus for 4 ms every 37777us) to stress the system
without overloading it (and disabling EAS). The 1st results shows that the
patchset helps to reduce the missed deadline frames from 5% to less than
0.1% when the cpu.latency of task group are set.

[1] https://source.android.com/docs/core/debug/eval_perf#touchlatency

Change since v3:
- Fix 2 compilation issues raised by kernel test robot <lkp@intel.com>

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

Parth Shah (4):
  sched: Introduce latency-nice as a per-task attribute
  sched/core: Propagate parent task's latency requirements to the child
    task
  sched: Allow sched_{get,set}attr to change latency_nice of the task
  sched/core: Add permission checks for setting the latency_nice value

Vincent Guittot (4):
  sched/fair: Take into account latency priority at wakeup
  sched/fair: Add sched group latency support
  sched/core: support latency priority with sched core
  sched/fair: Add latency list

 include/linux/sched.h            |   5 +
 include/uapi/linux/sched.h       |   4 +-
 include/uapi/linux/sched/types.h |  19 ++++
 init/init_task.c                 |   1 +
 kernel/sched/core.c              |  81 +++++++++++++
 kernel/sched/debug.c             |   1 +
 kernel/sched/fair.c              | 189 ++++++++++++++++++++++++++++++-
 kernel/sched/sched.h             |  37 +++++-
 tools/include/uapi/linux/sched.h |   4 +-
 9 files changed, 333 insertions(+), 8 deletions(-)

-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359E85F37FD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 23:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiJCVpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 17:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiJCVpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 17:45:06 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E394813D1E
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 14:45:03 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id s16-20020a170902ea1000b00176cf52a348so8931875plg.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 14:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=jxnxcjrQAnNp9+hzwZxV2z0XbhXSs5CdxUJLCPmLcT0=;
        b=Z+siBCgnVJDuGcwsBfe+4FfsbltMMh6D2jlpgtliytNlmhafh0BNJXM+74vjuSiS8O
         zVLsUuLlIf3u6itZCx28kSYFMQdqMhuh2PEkadIF/lsdN3+ZDePbqxkWgqTpCmrJkIu0
         CxQEXh8hQ/Ggxo80ywWrnEzCwDgSk6UKDbjq1aGrmNBLoX4jXPKBA99SfsXRdRrm6iio
         KJapCvobuSsfSEevm2YSd4QLILA7URFmx1RSPcDYXPwgrhZm+an3933rgRXYV+x6k5U2
         Fhce1jDejxGB8wVW9Qo6nJSqV2RxPpbPjEqgw4Of2Wt3IZYjh75y1EawkxSU/ghIFStc
         NKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=jxnxcjrQAnNp9+hzwZxV2z0XbhXSs5CdxUJLCPmLcT0=;
        b=WV+ZYoOpa2IAeb+hdqrcEqSi6alAJzmqt4vb6L0bXY7y8iVfrEysnj+aPyhEIUSSTI
         O40lE8sf+fEzaqxvEu9d5+8cvXWAEbWxT7EkBss1QbwwzxdNnyqGMXCLhpuIEYDd0tHN
         +9UDYXAwFuuVltQe4I6hDdXWMqbpKYzLJj7LeYjg7o0Qwxu+vmr+fVkCoV3nHCrhYDcG
         Vy2DG1YHsKpRR5QOyr1ODuYxr2K1hOyFOJMxr4hj7TJ7Ht6L0D4zxOoqkOlHArJEftnz
         cf8Tt0t7S6DAxIfiUpm5nLUky18hehb5aIEhuHk0NI4pw9V5gj2tpjKyPj9MTlM7geki
         J45w==
X-Gm-Message-State: ACrzQf07PPvN54Dm5XYM8xc9YH5tZYjuOVWS3DOrO+A5gksGMkrhnOze
        mEHTFTRMj8h3fnwAFQdRm6ImONP9ZbbIzq56BvfgQFX5+4cAk7Ebm9oobfa+o64vd1NwM1Y5sbl
        F1HajeVFpKFQAQa6UFGmhYyHfE5Ck72vYJZ0CumFVZakuJfwXd4X9wtbYNiYilLJp0wLfjres
X-Google-Smtp-Source: AMsMyM6qs4y3G+aio7xSJvIOr2gBHa0RjuG6acOkUq6AAo/7s3bj2k4DYJky/Mat4OC1wvCj7iQacWdNp8yl
X-Received: from connoro.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:a99])
 (user=connoro job=sendgmr) by 2002:a17:902:ec8a:b0:178:488b:cbc2 with SMTP id
 x10-20020a170902ec8a00b00178488bcbc2mr24877226plg.114.1664833503242; Mon, 03
 Oct 2022 14:45:03 -0700 (PDT)
Date:   Mon,  3 Oct 2022 21:44:50 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221003214501.2050087-1-connoro@google.com>
Subject: [RFC PATCH 00/11] Reviving the Proxy Execution Series
From:   "Connor O'Brien" <connoro@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, John Stultz <jstultz@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Connor O'Brien" <connoro@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Proxy execution is an approach to implementing priority inheritance
based on distinguishing between a task's scheduler context (information
required in order to make scheduling decisions about when the task gets
to run, such as its scheduler class and priority) and its execution
context (information required to actually run the task, such as CPU
affinity). With proxy execution enabled, a task p1 that blocks on a
mutex remains on the runqueue, but its "blocked" status and the mutex on
which it blocks are recorded. If p1 is selected to run while still
blocked, the lock owner p2 can run "on its behalf", inheriting p1's
scheduler context. Execution context is not inherited, meaning that
e.g. the CPUs where p2 can run are still determined by its own affinity
and not p1's.

In practice a number of more complicated situations can arise: the mutex
owner might itself be blocked on another mutex, or it could be sleeping,
running on a different CPU, in the process of migrating between CPUs,
etc. Details on handling these various cases can be found in patch 7/11
("sched: Add proxy execution"), particularly in the implementation of
proxy() and accompanying comments.

Past discussions of proxy execution have often focused on the benefits
for deadline scheduling. Current interest for Android is based more on
desire for a broad solution to priority inversion on kernel mutexes,
including among CFS tasks. One notable scenario arises when cpu cgroups
are used to throttle less important background tasks. Priority inversion
can occur when an "important" unthrottled task blocks on a mutex held by
an "unimportant" task whose CPU time is constrained using cpu
shares. The result is higher worst case latencies for the unthrottled
task.[0] Testing by John Stultz with a simple reproducer [1] showed
promising results for this case, with proxy execution appearing to
eliminate the large latency spikes associated with priority
inversion.[2]

Proxy execution has been discussed over the past few years at several
conferences[3][4][5], but (as far as I'm aware) patches implementing the
concept have not been discussed on the list since Juri Lelli's RFC in
2018.[6] This series is an updated version of that patchset, seeking to
incorporate subsequent work by Juri[7], Valentin Schneider[8] and Peter
Zijlstra along with some new fixes.

Testing so far has focused on stability, mostly via mutex locktorture
with some tweaks to more quickly trigger proxy execution bugs. These
locktorture changes are included at the end of the series for
reference. The current series survives runs of >72 hours on QEMU without
crashes, deadlocks, etc. Testing on Pixel 6 with the android-mainline
kernel [9] yields similar results. In both cases, testing used >2 CPUs
and CONFIG_FAIR_GROUP_SCHED=y, a configuration Valentin Schneider
reported[10] showed stability problems with earlier versions of the
series.

That said, these are definitely still a work in progress, with some
known remaining issues (e.g. warnings while booting on Pixel 6,
suspicious looking min/max vruntime numbers) and likely others I haven't
found yet. I've done my best to eliminate checks and code paths made
redundant by new fixes but some probably remain. There's no attempt yet
to handle core scheduling. Performance testing so far has been limited
to the aforementioned priority inversion reproducer. The hope in sharing
now is to revive the discussion on proxy execution and get some early
input for continuing to revise & refine the patches.

[0] https://raw.githubusercontent.com/johnstultz-work/priority-inversion-demo/main/results/charts/6.0-rc7-throttling-starvation.png
[1] https://github.com/johnstultz-work/priority-inversion-demo
[2] https://raw.githubusercontent.com/johnstultz-work/priority-inversion-demo/main/results/charts/6.0-rc7-vanilla-vs-proxy.png
[3] https://lpc.events/event/2/contributions/62/
[4] https://lwn.net/Articles/793502/
[5] https://lwn.net/Articles/820575/
[6] https://lore.kernel.org/lkml/20181009092434.26221-1-juri.lelli@redhat.com/
[7] https://github.com/jlelli/linux/tree/experimental/deadline/proxy-rfc-v2
[8] https://gitlab.arm.com/linux-arm/linux-vs/-/tree/mainline/sched/proxy-rfc-v3/
[9] https://source.android.com/docs/core/architecture/kernel/android-common
[10] https://lpc.events/event/7/contributions/758/attachments/585/1036/lpc20-proxy.pdf#page=4

Connor O'Brien (2):
  torture: support randomized shuffling for proxy exec testing
  locktorture: support nested mutexes

Juri Lelli (3):
  locking/mutex: make mutex::wait_lock irq safe
  kernel/locking: Expose mutex_owner()
  sched: Fixup task CPUs for potential proxies.

Peter Zijlstra (4):
  locking/ww_mutex: Remove wakeups from under mutex::wait_lock
  locking/mutex: Rework task_struct::blocked_on
  sched: Split scheduler execution context
  sched: Add proxy execution

Valentin Schneider (2):
  kernel/locking: Add p->blocked_on wrapper
  sched/rt: Fix proxy/current (push,pull)ability

 include/linux/mutex.h        |   2 +
 include/linux/sched.h        |  15 +-
 include/linux/ww_mutex.h     |   3 +
 init/Kconfig                 |   7 +
 init/init_task.c             |   1 +
 kernel/Kconfig.locks         |   2 +-
 kernel/fork.c                |   6 +-
 kernel/locking/locktorture.c |  20 +-
 kernel/locking/mutex-debug.c |   9 +-
 kernel/locking/mutex.c       | 109 +++++-
 kernel/locking/ww_mutex.h    |  31 +-
 kernel/sched/core.c          | 679 +++++++++++++++++++++++++++++++++--
 kernel/sched/deadline.c      |  37 +-
 kernel/sched/fair.c          |  33 +-
 kernel/sched/rt.c            |  63 ++--
 kernel/sched/sched.h         |  42 ++-
 kernel/torture.c             |  10 +-
 17 files changed, 955 insertions(+), 114 deletions(-)

-- 
2.38.0.rc1.362.ged0d419d3c-goog


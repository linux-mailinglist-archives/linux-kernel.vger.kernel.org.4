Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8EEA73FA11
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 12:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjF0KUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 06:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjF0KTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 06:19:39 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDCD2D67
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 03:17:11 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fb7acaa7a5so2347382e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 03:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687861029; x=1690453029;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0KWIzZrsKr771aCPlbz1EsAxSnIWFArPsCSFIzAXGwo=;
        b=sYMfciVjl0CzrUHYj8KwUacc1qv52/vbUt9wfgYyv97x6RB4xxmbHXA+cB2GQBdfwu
         FNV/g9lt/d6i38QJSe1GrhmndC6qu88W0oe5pNTfE4xHZKxM8tIb3Iov4WmrGVjyYKJe
         cIbB9058nVC9P3YOFFTn4yPY4kFE989vaItV/8Ir2H5QWyUKxBOhmh5qt6r6KSRGqO4J
         1bbC2BIWVdjh/GBdZ5LNGCocwJerji3lqabCdUR5yIyUUG1Oc7rXgcSL8aWS0PPRk8Ek
         WCmWwCThqwIgeYavOUpr8945z6AnTjaeLGrh2ji9+UA2uZ5SeJDF3CoO2jut3k/qs/tw
         A8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687861029; x=1690453029;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0KWIzZrsKr771aCPlbz1EsAxSnIWFArPsCSFIzAXGwo=;
        b=hAlz7B2l+v4GIObulJ8p9ClF+y/1CkQzDnZlStiQUsE/C2MATUwy0Tq47yorqHjUlw
         14jVukevS09lg0UBtk0Rj4zZD6bCTz9a/n4ll16Ndn1zh7N3ex7xW/LCTHC0LDLRGamv
         CFJA9VUwshYjKgfvpbWRYoNNbvPrrSqofHPxwMBg8lB4LFuT/6KLoDHdhhGWGhOMgQtD
         /aYKtMh2tSNgzir7dIjFu3MULzwo6SJrDkFlseZGvF6NouMAwkyjD53/P6oUIwiBNu87
         Y0KjemkXrAOyaKxowDL6NDs1VxccTaCrh3WB/Zu6uCQ97FQ45CscxZZrfUpdyEZLUV/K
         ebcQ==
X-Gm-Message-State: AC+VfDylxmI87sQRwj2q1ZP31wQ3ccEVcpgT16NQg1dX5kufYdTvob27
        mr7aSNfvfUcJGkDqfnW9FfI8WDtOY1U=
X-Google-Smtp-Source: ACHHUZ54y+J8YEkg2yg+6SHrw1gMg5nr+cX/RiwdyaCSbdkowMDWdSyjt/NyrFZFlH6IBt9UtqEU6w==
X-Received: by 2002:a05:6512:3b0a:b0:4f8:6fe9:3c9c with SMTP id f10-20020a0565123b0a00b004f86fe93c9cmr11899929lfv.49.1687861029180;
        Tue, 27 Jun 2023 03:17:09 -0700 (PDT)
Received: from gmail.com ([31.46.247.226])
        by smtp.gmail.com with ESMTPSA id j4-20020adfea44000000b0030fa3567541sm10019067wrn.48.2023.06.27.03.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 03:17:08 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 27 Jun 2023 12:17:02 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: [GIT PULL] Scheduler changes for v6.5
Message-ID: <ZJq3HtUKZp2uMWLu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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

Linus,

Please pull the latest sched/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2023-06-27

   # HEAD: ebb83d84e49b54369b0db67136a5fe1087124dcc sched/core: Avoid multiple calling update_rq_clock() in __cfsb_csd_unthrottle()

NOTE:

  When merging this tree you'll get a new conflict in 
  drivers/clocksource/hyperv_timer.c, due to overlapping changes.

  In case you want to double check your conflict resolution, our -tip CI 
  conflict resolution can be found at the e31a421069a6 merge commit in the 
  core/merge -tip branch:

      git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/merge

Scheduler changes for v6.5:

- Scheduler SMP load-balancer improvements:

    - Avoid unnecessary migrations within SMT domains on hybrid systems.

      Problem:

        On hybrid CPU systems, (processors with a mixture of higher-frequency
	SMT cores and lower-frequency non-SMT cores), under the old code
	lower-priority CPUs pulled tasks from the higher-priority cores if
	more than one SMT sibling was busy - resulting in many unnecessary
	task migrations.

      Solution:

        The new code improves the load balancer to recognize SMT cores with more
        than one busy sibling and allows lower-priority CPUs to pull tasks, which
        avoids superfluous migrations and lets lower-priority cores inspect all SMT
        siblings for the busiest queue.

    - Implement the 'runnable boosting' feature in the EAS balancer: consider CPU
      contention in frequency, EAS max util & load-balance busiest CPU selection.

      This improves CPU utilization for certain workloads, while leaves other key
      workloads unchanged.

- Scheduler infrastructure improvements:

    - Rewrite the scheduler topology setup code by consolidating it
      into the build_sched_topology() helper function and building
      it dynamically on the fly.

    - Resolve the local_clock() vs. noinstr complications by rewriting
      the code: provide separate sched_clock_noinstr() and
      local_clock_noinstr() functions to be used in instrumentation code,
      and make sure it is all instrumentation-safe.

- Fixes:

    - Fix a kthread_park() race with wait_woken()

    - Fix misc wait_task_inactive() bugs unearthed by the -rt merge:
       - Fix UP PREEMPT bug by unifying the SMP and UP implementations.
       - Fix task_struct::saved_state handling.

    - Fix various rq clock update bugs, unearthed by turning on the rq clock
      debugging code.

    - Fix the PSI WINDOW_MIN_US trigger limit, which was easy to trigger by
      creating enough cgroups, by removing the warnign and restricting
      window size triggers to PSI file write-permission or CAP_SYS_RESOURCE.

    - Propagate SMT flags in the topology when removing degenerate domain

    - Fix grub_reclaim() calculation bug in the deadline scheduler code

    - Avoid resetting the min update period when it is unnecessary, in
      psi_trigger_destroy().

    - Don't balance a task to its current running CPU in load_balance(),
      which was possible on certain NUMA topologies with overlapping
      groups.

    - Fix the sched-debug printing of rq->nr_uninterruptible

- Cleanups:

    - Address various -Wmissing-prototype warnings, as a preparation
      to (maybe) enable this warning in the future.

    - Remove unused code

    - Mark more functions __init

    - Fix shadow-variable warnings

Signed-off-by: Ingo Molnar <mingo@kernel.org>
 Thanks,

	Ingo

------------------>
Arnd Bergmann (5):
      sched: Hide unused sched_update_scaling()
      sched: Add schedule_user() declaration
      sched/fair: Hide unused init_cfs_bandwidth() stub
      sched: Make task_vruntime_update() prototype visible
      sched/fair: Move unused stub functions to header

Arve Hjønnevåg (1):
      sched/wait: Fix a kthread_park race with wait_woken()

Chen Yu (1):
      x86/sched: Add the SD_ASYM_PACKING flag to the die domain of hybrid processors

Dietmar Eggemann (2):
      sched/fair: Refactor CPU utilization functions
      sched/fair, cpufreq: Introduce 'runnable boosting'

Hao Jia (3):
      sched/core: Fixed missing rq clock update before calling set_rq_offline()
      sched/core: Avoid double calling update_rq_clock() in __balance_push_cpu_stop()
      sched/core: Avoid multiple calling update_rq_clock() in __cfsb_csd_unthrottle()

Miaohe Lin (2):
      sched/deadline: remove unused dl_bandwidth
      sched/topology: Mark set_sched_topology() __init

Peter Zijlstra (17):
      sched: Unconditionally use full-fat wait_task_inactive()
      sched: Consider task_struct::saved_state in wait_task_inactive()
      x86/sched: Rewrite topology setup
      seqlock/latch: Provide raw_read_seqcount_latch_retry()
      time/sched_clock: Provide sched_clock_noinstr()
      arm64/io: Always inline all of __raw_{read,write}[bwlq]()
      arm64/arch_timer: Provide noinstr sched_clock_read() functions
      loongarch: Provide noinstr sched_clock_read()
      s390/time: Provide sched_clock_noinstr()
      math64: Always inline u128 version of mul_u64_u64_shr()
      x86/vdso: Fix gettimeofday masking
      clocksource: hyper-v: Adjust hv_read_tsc_page_tsc() to avoid special casing U64_MAX
      clocksource: hyper-v: Provide noinstr sched_clock()
      x86/tsc: Provide sched_clock_noinstr()
      sched/clock: Provide local_clock_noinstr()
      cpuidle: Use local_clock_noinstr()
      arm64/arch_timer: Fix MMIO byteswap

Ricardo Neri (11):
      sched/fair: Move is_core_idle() out of CONFIG_NUMA
      sched/fair: Only do asym_packing load balancing from fully idle SMT cores
      sched/fair: Simplify asym_packing logic for SMT cores
      sched/fair: Let low-priority cores help high-priority busy SMT cores
      sched/fair: Keep a fully_busy SMT sched group as busiest
      sched/fair: Use the busiest group to set prefer_sibling
      sched/fair: Do not even the number of busy CPUs via asym_packing
      sched/topology: Check SDF_SHARED_CHILD in highest_flag_domain()
      sched/topology: Remove SHARED_CHILD from ASYM_PACKING
      x86/sched: Remove SD_ASYM_PACKING from the SMT domain flags
      x86/sched/itmt: Give all SMT siblings of a core the same priority

Suren Baghdasaryan (1):
      psi: remove 500ms min window size limitation for triggers

Tim C Chen (1):
      sched/topology: Propagate SMT flags when removing degenerate domain

Tom Rix (1):
      sched/fair: Rename variable cpu_util eff_util

Vineeth Pillai (2):
      sched/deadline: Fix bandwidth reclaim equation in GRUB
      sched/deadline: Update GRUB description in the documentation

Yang Yang (1):
      sched/psi: Avoid resetting the min update period when it is unnecessary

Yicong Yang (1):
      sched/fair: Don't balance task to its current running CPU

晏艳(采苓) (1):
      sched/debug: Correct printing for rq->nr_uninterruptible


 Documentation/scheduler/sched-deadline.rst |   5 +-
 arch/arm64/include/asm/arch_timer.h        |   8 +-
 arch/arm64/include/asm/io.h                |  12 +-
 arch/loongarch/include/asm/loongarch.h     |   2 +-
 arch/loongarch/kernel/time.c               |   6 +-
 arch/s390/include/asm/timex.h              |  13 +-
 arch/s390/kernel/time.c                    |   5 +
 arch/x86/include/asm/mshyperv.h            |   5 +
 arch/x86/include/asm/vdso/gettimeofday.h   |  41 +++-
 arch/x86/kernel/itmt.c                     |  23 +-
 arch/x86/kernel/kvmclock.c                 |   4 +-
 arch/x86/kernel/smpboot.c                  | 102 +++++----
 arch/x86/kernel/tsc.c                      |  38 +++-
 arch/x86/kvm/x86.c                         |   7 +-
 arch/x86/xen/time.c                        |   3 +-
 drivers/clocksource/arm_arch_timer.c       |  54 +++--
 drivers/clocksource/hyperv_timer.c         |  44 ++--
 drivers/cpuidle/cpuidle.c                  |   8 +-
 drivers/cpuidle/poll_state.c               |   4 +-
 include/clocksource/hyperv_timer.h         |  24 +--
 include/linux/kthread.h                    |   1 +
 include/linux/math64.h                     |   2 +-
 include/linux/rbtree_latch.h               |   2 +-
 include/linux/sched.h                      |   7 +-
 include/linux/sched/clock.h                |  17 +-
 include/linux/sched/sd_flags.h             |   5 +-
 include/linux/sched/topology.h             |   2 +-
 include/linux/seqlock.h                    |  15 +-
 kernel/cgroup/cgroup.c                     |  12 ++
 kernel/kthread.c                           |  10 +
 kernel/printk/printk.c                     |   2 +-
 kernel/sched/clock.c                       |  19 +-
 kernel/sched/core.c                        | 278 +++++++++++++-----------
 kernel/sched/cpufreq_schedutil.c           |   3 +-
 kernel/sched/deadline.c                    |  57 ++---
 kernel/sched/debug.c                       |   2 +-
 kernel/sched/fair.c                        | 329 ++++++++++++++++++-----------
 kernel/sched/psi.c                         |  19 +-
 kernel/sched/sched.h                       | 105 +++++----
 kernel/sched/topology.c                    |  15 +-
 kernel/sched/wait.c                        |   7 +-
 kernel/time/sched_clock.c                  |  24 ++-
 kernel/time/timekeeping.c                  |   4 +-
 43 files changed, 777 insertions(+), 568 deletions(-)

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D0A5F74B3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 09:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiJGH20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 03:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJGH2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 03:28:23 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6337A99EF
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 00:28:21 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a26so9482229ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 00:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date;
        bh=1RP7fdLBistLFjYPIl8swtiL3Jz1YPdptqE/qVnA33I=;
        b=f8hbBmtBbWvyMLanFmbgXknnk1/9RWBHB8RUNXjAijlQJebV74+CP0PDgdPZLj3LGD
         /5cS6fZ/U1sa7rBqtUVrtJZETKeUQacGoOk+3Aqz6+xSZMSlEFLndIfXm+jTQ8wlpHeA
         eZuJLfiW1h2j89DZXqaFmNPdBydtZ2khp9xLqI3jgwtgsZhnx0updEZZ+ZkREdaIXeQg
         T0P8ASi51zj+wMJ95Ru/64j3Mf6qQFFy02fZ8rHwjdO+jnLj8CIer05HiUrm5Ae/ih01
         h8Qc3N4tfWqM8/aVquJbQT331YSgQAJrbd42TJZPgyxOpKmp5lwx//eSsRP/kJnnaUaO
         Mxaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date;
        bh=1RP7fdLBistLFjYPIl8swtiL3Jz1YPdptqE/qVnA33I=;
        b=RYOCwHsDKoYpjwhxivhXQ5uYdB1AlzH4GX+Q7P6H/5OwaL8YuqfWdG2psT0CyRhtXy
         u32qo+phuAy27Tii3x920cL04xd2nVdWS733CIsz1JrPF4J1hdOTtke1bdTH2sd61btB
         QGlxuYVVWSd/WznWtzimzjDzZ5T1R6Hn6Lz4zU0EN4QqcA1cjdkuUeGwl7gqNmbGGCVl
         pNX6L9egnU0BYVIrTLMO3lIMQ0PB0cImLJGdcwGPxHwO0OcWIlyhZPycDJT/D4T8mcAi
         EsaYLei+7M1aYz/Anhs/YNs78Nx8ZVEQipKT9E/q9X+4FYvLwy/Haykma2cHmmlPP1yZ
         cbuA==
X-Gm-Message-State: ACrzQf08J9o+xjT1XOafhkWbAFAtvGCCrYA0wPa9Ly3zaqNkQGfbtOn0
        DYv6wL1sefxYvPARTKMfR54=
X-Google-Smtp-Source: AMsMyM6U5diKelziR3l4iuPz4jiGCG1Lf0pGKeXjGeGRWfAawLa7UdgrkRbj7F+iwaD0Rwlp47upxw==
X-Received: by 2002:a17:907:785:b0:78d:250a:3725 with SMTP id xd5-20020a170907078500b0078d250a3725mr3043194ejb.588.1665127700165;
        Fri, 07 Oct 2022 00:28:20 -0700 (PDT)
Received: from gmail.com (1F2EF191.nat.pool.telekom.hu. [31.46.241.145])
        by smtp.gmail.com with ESMTPSA id b2-20020aa7c6c2000000b004587f9d3ce8sm893352eds.56.2022.10.07.00.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 00:28:19 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 7 Oct 2022 09:28:17 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mike Galbraith <efault@gmx.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: [GIT PULL] scheduler updates for v6.1
Message-ID: <Yz/VEcAmcUP/hLkn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the latest sched/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2022-10-07

   # HEAD: fdf756f7127185eeffe00e918e66dfee797f3625 sched: Fix more TASK_state comparisons

Scheduler changes for v6.1:

 - Scheduler debuggability:

     - Change most occurances of BUG_ON() to WARN_ON_ONCE()

     - Reorganize & fix TASK_ state comparisons, turn it into a bitmap

     - Update/fix misc scheduler debugging facilities

 - Load-balancing & regular scheduling:

     - Improve the behavior of the scheduler in presence of lot of
       SCHED_IDLE tasks - in particular they should not impact other
       scheduling classes.

     - Optimize task load tracking, cleanup & fixes

     - Clean up & simplify misc load-balancing code

 - Freezer:

     - Rewrite the core freezer to behave better wrt thawing and be simpler
       in general, by replacing PF_FROZEN with TASK_FROZEN & fixing/adjusting
       all the fallout.

 - Deadline scheduler:

     - Fix the DL capacity-aware code

     - Factor out dl_task_is_earliest_deadline() & replenish_dl_new_period()

     - Relax/optimize locking in task_non_contending()

 - Cleanups:

     - Factor out the update_current_exec_runtime() helper

     - Various cleanups, simplifications

 Thanks,

	Ingo

------------------>
Abel Wu (5):
      sched/fair: Remove redundant check in select_idle_smt()
      sched/fair: Avoid double search on same cpu
      sched/fair: Remove useless check in select_idle_core()
      sched/fair: Default to false in test_idle_cores()
      sched/fair: Cleanup for SIS_PROP

Bing Huang (1):
      sched/fair: Make per-cpu cpumasks static

Chengming Zhou (9):
      sched/fair: Maintain task se depth in set_task_rq()
      sched/fair: Remove redundant cpu_cgrp_subsys->fork()
      sched/fair: Reset sched_avg last_update_time before set_task_rq()
      sched/fair: Update comments in enqueue/dequeue_entity()
      sched/fair: Combine detach into dequeue when migrating task
      sched/fair: Fix another detach on unattached task corner case
      sched/fair: Allow changing cgroup of new forked task
      sched/fair: Move task sched_avg attach to enqueue_task_fair()
      sched/fair: Don't init util/runnable_avg for !fair task

Dietmar Eggemann (3):
      sched/core: Introduce sched_asym_cpucap_active()
      sched/deadline: Make dl_cpuset_cpumask_can_shrink() capacity-aware
      sched/deadline: Use sched_dl_entity's dl_density in dl_task_fits_capacity()

Hao Jia (1):
      sched/fair: Remove unused parameter idle of _nohz_idle_balance()

Ingo Molnar (1):
      sched/all: Change all BUG_ON() instances in the scheduler to WARN_ON_ONCE()

Peter Zijlstra (12):
      sched: Rename task_running() to task_on_cpu()
      freezer: Have {,un}lock_system_sleep() save/restore flags
      freezer,umh: Clean up freezer/initrd interaction
      sched: Change wait_task_inactive()s match_state
      sched: Add TASK_ANY for wait_task_inactive()
      sched/completion: Add wait_for_completion_state()
      sched/wait: Add wait_event_state()
      sched: Widen TAKS_state literals
      freezer,sched: Rewrite core freezer logic
      sched: Show PF_flag holes
      sched: Fix TASK_state comparisons
      sched: Fix more TASK_state comparisons

Shang XiaoJing (4):
      sched: Add update_current_exec_runtime helper
      sched/deadline: Add dl_task_is_earliest_deadline helper
      sched/deadline: Add replenish_dl_new_period helper
      sched/deadline: Move __dl_clear_params out of dl_bw lock

Vincent Guittot (3):
      sched/fair: Make sure to try to detach at least one movable task
      sched/fair: Cleanup loop_max and loop_break
      sched/fair: Move call to list_last_entry() in detach_tasks

Xin Gao (1):
      sched/core: Remove superfluous semicolon

Zhen Lei (1):
      sched/debug: Print each field value left-aligned in sched_show_task()


 drivers/acpi/x86/s2idle.c         |  12 +-
 drivers/android/binder.c          |   4 +-
 drivers/media/pci/pt3/pt3.c       |   4 +-
 drivers/powercap/idle_inject.c    |   2 +-
 drivers/scsi/scsi_transport_spi.c |   7 +-
 fs/cifs/inode.c                   |   4 +-
 fs/cifs/transport.c               |   5 +-
 fs/coredump.c                     |   7 +-
 fs/nfs/file.c                     |   3 +-
 fs/nfs/inode.c                    |  12 +-
 fs/nfs/nfs3proc.c                 |   3 +-
 fs/nfs/nfs4proc.c                 |  14 +--
 fs/nfs/nfs4state.c                |   3 +-
 fs/nfs/pnfs.c                     |   4 +-
 fs/xfs/xfs_trans_ail.c            |   8 +-
 include/linux/completion.h        |   1 +
 include/linux/freezer.h           | 245 ++------------------------------------
 include/linux/sched.h             |  50 +++++---
 include/linux/sunrpc/sched.h      |   7 +-
 include/linux/suspend.h           |   8 +-
 include/linux/umh.h               |   9 +-
 include/linux/wait.h              |  42 +++++--
 init/do_mounts_initrd.c           |  10 +-
 kernel/cgroup/legacy_freezer.c    |  23 ++--
 kernel/exit.c                     |   4 +-
 kernel/fork.c                     |   5 +-
 kernel/freezer.c                  | 133 +++++++++++++++------
 kernel/futex/waitwake.c           |   8 +-
 kernel/hung_task.c                |  16 ++-
 kernel/power/hibernate.c          |  35 ++++--
 kernel/power/main.c               |  18 +--
 kernel/power/process.c            |  10 +-
 kernel/power/suspend.c            |  12 +-
 kernel/power/user.c               |  24 ++--
 kernel/ptrace.c                   |   2 +-
 kernel/sched/autogroup.c          |   3 +-
 kernel/sched/completion.c         |  12 ++
 kernel/sched/core.c               | 103 +++++-----------
 kernel/sched/core_sched.c         |   4 +-
 kernel/sched/cpudeadline.c        |   2 +-
 kernel/sched/cpupri.c             |   2 +-
 kernel/sched/deadline.c           | 115 +++++++++---------
 kernel/sched/fair.c               | 227 +++++++++++++++++------------------
 kernel/sched/rt.c                 |  18 ++-
 kernel/sched/sched.h              |  65 ++++++----
 kernel/sched/stop_task.c          |  11 +-
 kernel/signal.c                   |  14 +--
 kernel/time/hrtimer.c             |   4 +-
 kernel/umh.c                      |  18 ++-
 mm/khugepaged.c                   |   4 +-
 net/sunrpc/sched.c                |  12 +-
 net/unix/af_unix.c                |   8 +-
 52 files changed, 616 insertions(+), 760 deletions(-)

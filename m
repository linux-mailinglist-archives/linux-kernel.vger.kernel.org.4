Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1576C7004F1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 12:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240287AbjELKLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 06:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240013AbjELKLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 06:11:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A12E911DA4
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 03:11:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B96DFEC;
        Fri, 12 May 2023 03:11:26 -0700 (PDT)
Received: from e125579.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 67C9D3F5A1;
        Fri, 12 May 2023 03:10:40 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Qais Yousef <qyousef@layalina.io>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Quentin Perret <qperret@google.com>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] sched: Consider CPU contention in frequency, EAS max util & load-balance busiest CPU selection
Date:   Fri, 12 May 2023 12:10:27 +0200
Message-Id: <20230512101029.342823-1-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the implementation of the idea to factor in CPU runnable_avg
into the CPU utilization getter functions (so called
'runnable boosting') as a way to consider CPU contention for:

  (a) CPU frequency
  (b) EAS' max util and
  (c) 'migrate_util' type load-balance busiest CPU selection.

Tests:

for (a) and (b):

Testcase is Jankbench (all subtests, 10 iterations) on Pixel6 (Android
12) with mainline v5.18 kernel and forward ported task scheduler
patches.

Uclamp has been deactivated so that the Android Dynamic Performance
Framework (ADPF) 'CPU performance hints' feature (Userspace task
boosting via uclamp_min) does not interfere.

Max_frame_duration:
+-----------------+------------+
|     kernel      | value [ms] |
+-----------------+------------+
|      base       | 163.061513 |
|    runnable     | 161.991705 |
+-----------------+------------+

Mean_frame_duration:
+-----------------+------------+----------+
|     kernel      | value [ms] | diff [%] |
+-----------------+------------+----------+
|      base       |    18.0    |    0.0   |
|    runnable     |    12.7    |  -29.43  |
+-----------------+------------+----------+

Jank percentage (Jank deadline 16ms):
+-----------------+------------+----------+
|     kernel      | value [%]  | diff [%] |
+-----------------+------------+----------+
|      base       |     3.6    |    0.0   |
|    runnable     |     1.0    |  -68.86  |
+-----------------+------------+----------+

Power usage [mW] (total - all CPUs):
+-----------------+------------+----------+
|     kernel      | value [mW] | diff [%] |
+-----------------+------------+----------+
|      base       |    129.5   |    0.0   |
|    runnable     |    134.3   |   3.71*  |
+-----------------+------------+----------+

* Power usage went up from 129.3 (-0.15%) in v1 to 134.3 (3.71%) whereas
all the other benchmark numbers stayed roughly the same. This is
probably because of using 'runnable boosting' for EAS max util now as
well and tasks more often end up running on non-little CPUs because of
that.

for (c):

Testcase is 'perf bench sched messaging' on Arm64 Ampere Altra with 160
CPUs (sched domains = {MC, DIE, NUMA}) which shows some small
improvement:

perf stat --null --repeat 10 -- perf bench sched messaging -t -g 1 -l 2000

0.4869 +- 0.0173 seconds time elapsed (+- 3.55%) ->
0.4377 +- 0.0147 seconds time elapsed (+- 3.36%)

Chen Yu tested v1** with schbench, hackbench, netperf and tbench on an
Intel Sapphire Rapids with 2x56C/112T = 224 CPUs which showed no obvious
difference and some small improvements on tbench:

https://lkml.kernel.org/r/ZFSr4Adtx1ZI8hoc@chenyu5-mobl1

** The implementation for (c) hasn't changed in v2.

v1 -> v2:

(1) Refactor CPU utilization getter functions, let cpu_util_cfs() call
    cpu_util_next() (now cpu_util()).

(2) Consider CPU contention in EAS (find_energy_efficient_cpu() ->
    eenv_pd_max_util()) next to schedutil (sugov_get_util()) as well so
    that EAS' and schedutil's views on CPU frequency selection are in
    sync.

(3) Move 'util_avg = max(util_avg, runnable_avg)' from
    cpu_boosted_util_cfs() to cpu_util_next() (now cpu_util()) so that
    EAS can use it too.

(4) Rework patch header.

(5) Add test results (JankbenchX on Pixel6 to test changes in schedutil
    and EAS) and 'perf bench sched messaging' on Arm64 Ampere Altra for
    CFS load-balance (find_busiest_queue()).


Dietmar Eggemann (2):
  sched/fair: Refactor CPU utilization functions
  sched/fair, cpufreq: Introduce 'runnable boosting'

 kernel/sched/core.c              |  2 +-
 kernel/sched/cpufreq_schedutil.c |  3 +-
 kernel/sched/fair.c              | 72 +++++++++++++++++++++++++-------
 kernel/sched/sched.h             | 49 +---------------------
 4 files changed, 63 insertions(+), 63 deletions(-)

-- 
2.25.1


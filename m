Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A022728462
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 17:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237091AbjFHP6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 11:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237597AbjFHP6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:58:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3739CE4A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 08:58:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 729EC615CE
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 15:58:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A8CC433D2;
        Thu,  8 Jun 2023 15:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686239910;
        bh=zkzDUTzoUvqPxa4+BDd44n0s0GRo5pLLUljGElyMJTQ=;
        h=From:To:Cc:Subject:Date:From;
        b=I/XVPf9KwS+UK39Ut9ernkLGRkSct1q+3ySsKSQzlNmJTYKDomT9q+FUo9d2GwFqw
         7PA4XotdT2u7dC6PJM+UG9xZPMF1VkM87H6c82OOOOF6YXnHT9xkJsAIINdqnJ9RAa
         3Haofq/ufI19Xr2nm2XnAmD9ZNKUw9wArOI52zN7paJkpZhT10RSMuBe/h+ZFa2O4Z
         sxgHqaIv1Ywwgn4pQDgI4RAtNBY9wg6yC1uG9RIPtk1WzVIbESi8WDnIbhvbdAQ96x
         bAzk8VOGhrLvF7+7qJZfWVSVCFkdUEgBrlctiF+cWkV2sFk39MWD9LqsYDiYd/2+6a
         JkiFqf7+a7ucw==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: [RFC PATCH V3 0/6] SCHED_DEADLINE server infrastructure
Date:   Thu,  8 Jun 2023 17:58:12 +0200
Message-Id: <cover.1686239016.git.bristot@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is RFC v3 of Peter's SCHED_DEADLINE server infrastructure
implementation [1].

SCHED_DEADLINE servers can help fixing starvation issues of low priority
tasks (e.g., SCHED_OTHER) when higher priority tasks monopolize CPU
cycles. Today we have RT Throttling; DEADLINE servers should be able to
replace and improve that.

I rebased Peter's patches (adding changelogs where needed) on
tip/sched/core as of today and incorporated fixes to issues discussed
during RFC v1 & v2.

In the v1 there was discussion raised about the consequence of using
deadline based servers on the fixed-priority workloads. For a demonstration
here is the baseline of timerlat** scheduling latency as-is, with kernel
build background workload:

 # rtla timerlat top -u -d 10m 
 
  --------------------- %< ------------------------                                                                                       
  0 01:00:01   |          IRQ Timer Latency (us)        |         Thread Timer Latency (us)      |    Ret user Timer Latency (us)
CPU COUNT      |      cur       min       avg       max |      cur       min       avg       max |      cur       min       avg       max
  0 #3599960   |        1         0         1        31 |        6         1         6        65 |        9         2         9        86
  1 #3599972   |        1         0         1        41 |        4         1         5        54 |        7         2         7        78
  2 #3599966   |        1         0         1        36 |        6         1         6        65 |        9         2         9        81
  3 #3599945   |        0         0         1        31 |        6         1         6        55 |        9         2         9        84
  4 #3599939   |        1         0         1        32 |        4         1         6        53 |        7         2         8        85
  5 #3599944   |        0         0         1        31 |        4         1         6        50 |        6         2         9        54
  6 #3599945   |        1         0         1        38 |        5         1         6        53 |        8         2         9        88
  7 #3599944   |        0         0         1        36 |        4         1         5        62 |        6         2         8        86
  --------------------- >% ------------------------

And this is the same tests with DL server activating without any delay*:
  --------------------- %< ------------------------                                                                                       
  0 00:10:01   |          IRQ Timer Latency (us)        |         Thread Timer Latency (us)      |    Ret user Timer Latency (us)
CPU COUNT      |      cur       min       avg       max |      cur       min       avg       max |      cur       min       avg       max
  0 #595748    |        1         0         1       254 |        8         1        31      1417 |       12         2        33      1422
  1 #597951    |        1         0         1       239 |        6         1        27      1435 |        9         2        30      1438
  2 #595060    |        1         0         1        24 |        5         1        28      1437 |        7         2        30      1441
  3 #595914    |        1         0         1       218 |        6         1        29      1382 |        9         2        32      1385
  4 #597829    |        1         0         1       233 |        8         1        26      1368 |       11         2        29      1427
  5 #596314    |        2         0         1        21 |        7         1        29      1442 |       10         2        32      1447
  6 #595532    |        1         0         1       238 |        6         1        31      1389 |        9         2        34      1392
  7 #595852    |        0         0         1        34 |        6         1        30      1481 |        9         2        33      1484
  --------------------- >% ------------------------

The problem with DL server only implementation is that FIFO tasks might
suffer preemption from NORMAL even when spare CPU cycles are available.
In fact, fair deadline server is enqueued right away when NORMAL tasks
wake up and they are first scheduled by the server, thus potentially
preempting a well behaving FIFO task. This is of course not ideal.

We had discussions about it, and one of the possibilities would be
using a different scheduling algorithm for this. But IMHO that is
an overkill. Juri and I discussed that, and that is why Juri added
the patch 6/6.

The patch 6/6 adds a PoC of an starvation monitor/watchdog that delays
enqueuing of deadline servers to the point when fair tasks might start
to actually suffer from starvation (just randomly picked HZ/2 for now).

With that in place, the results get better again*:

  --------------------- %< ------------------------                                                                                       
  0 01:00:01   |          IRQ Timer Latency (us)        |         Thread Timer Latency (us)      |    Ret user Timer Latency (us)
CPU COUNT      |      cur       min       avg       max |      cur       min       avg       max |      cur       min       avg       max
  0 #3600004   |        1         0         1        29 |        8         1         5        50 |       11         2         8        66
  1 #3600010   |        1         0         1        30 |        7         1         5        50 |       10         2         8        58
  2 #3600010   |        0         0         1        30 |        5         1         5        43 |        7         2         7        70
  3 #3600010   |        1         0         1        25 |        8         1         6        52 |       12         2         8        74
  4 #3600010   |        1         0         1        63 |        8         1         6        72 |       12         2         8        88
  5 #3600010   |        1         0         1        26 |        8         1         6        59 |       11         2         8        94
  6 #3600010   |        1         0         1        29 |        9         1         5        55 |       12         2         8        82
  7 #3600003   |        0         0         1       117 |        6         1         5       124 |        9         2         7       127
  --------------------- >% ------------------------

So, that is in the right direction but we can improve it. Here
are the next steps I am taking:

 - Getting parameters from the sysctl sched_rt...
 - Trying to delay the start of the server for the 0-laxity time
 	- Maybe starting the server throttled with replenish time
 	  at 0-laxity
 - Maybe implement a starvation monitor offload, where the DL server
   is started remotely, avoiding the overhead of its activation - like
   stalld does;
 - Test with micro-interference to measure overheads.

Here are some osnoise measurement, with osnoise threads running as FIFO:1 with
different setups*:
 - CPU 2 isolated
 - CPU 3 isolated shared with a CFS busy loop task
 - CPU 8 non-isolated
 - CPU 9 non-isolated shared with a CFS busy loop task

  --------------------- %< ------------------------                                                                                       
# osnoise -P f:1 -c 2,3,8,9 -T 1 -d 10m -H 1 -q
                                          Operating System Noise                                                                          
duration:   0 00:12:39 | time is in us
CPU Period       Runtime        Noise  % CPU Aval   Max Noise   Max Single          HW          NMI          IRQ      Softirq       Thread
  2 #757       757000000           49    99.99999          14            3           0            0          106            0            0
  3 #757       757001039     39322713    94.80546       52992         1103           0            0      3657933            0        59685
  8 #757       757000000       779821    99.89698        1513            4           0          113       794899            0          189
  9 #757       757001043     39922677    94.72620       53775         1105           0          112      4361243            0        49009
   --------------------- >% ------------------------

The results are promising, but there is a problem when no setting
HRTICK_DL... checking it. No splat on any of these scenarios.

* tests with throttling disabled, on the 6.3 stable RT. But also
on 6.4 and tip/sched/core.
** timerlat with user-space support under dev, you need these patch series:
   https://lore.kernel.org/all/cover.1686063934.git.bristot@kernel.org
   https://lore.kernel.org/all/cover.1686066600.git.bristot@kernel.org
   or just run without the -u option :-)   

Changes from v2:
  - rebased on 6.4-rc1 tip/sched/core

Juri Lelli (1):
  sched/fair: Implement starvation monitor

Peter Zijlstra (5):
  sched: Unify runtime accounting across classes
  sched/deadline: Collect sched_dl_entity initialization
  sched/deadline: Move bandwidth accounting into {en,de}queue_dl_entity
  sched/deadline: Introduce deadline servers
  sched/fair: Add trivial fair server

 include/linux/sched.h    |  24 +-
 kernel/sched/core.c      |  23 +-
 kernel/sched/deadline.c  | 497 +++++++++++++++++++++++++--------------
 kernel/sched/fair.c      | 143 +++++++++--
 kernel/sched/rt.c        |  15 +-
 kernel/sched/sched.h     |  60 +++--
 kernel/sched/stop_task.c |  13 +-
 7 files changed, 538 insertions(+), 237 deletions(-)

-- 
2.40.1


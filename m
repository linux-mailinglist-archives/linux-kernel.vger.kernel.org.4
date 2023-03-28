Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286716CBD1C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 13:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbjC1LHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 07:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbjC1LHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:07:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6D47DB1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 04:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=NzbG62uobVMsZ3xGs5rS1xl6qih3MWfTeL8gqcFyTAQ=; b=qf/LfnoUp2GyeYLC6TFxAh+5Fo
        uZwTfsDdPlWxGAtzbfFaZEkqMV31sgJOdbWMDdYbsuigUsGcPlcpxXHstik/C8DUvSRWmPSuz8QuV
        CZDRM5zp+uE2Z5RfOeny//z7xSXqz0RCCLvn6EZZXtGN46zSjW6C7lRmjm6ctldkXHuEOgfypPb2P
        +Vei5AUEZyRtDOSNFNvINg5rWu2A5utSgKeRNgDYUS9Lud5UI0QeJLpyyBXmii11UJjO+52yLDn6y
        5ymtM9f1IS/CAWIGV/opiq8Sp1CNVtHHhAwFPRNGT7qDXfUyThMAx9OImENVt4W47R3VXqjTbjlvv
        BwqX5DUw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ph79k-008MD2-Pj; Tue, 28 Mar 2023 11:06:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BE4F4300289;
        Tue, 28 Mar 2023 13:06:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A33372CB745AA; Tue, 28 Mar 2023 13:06:20 +0200 (CEST)
Message-ID: <20230328092622.062917921@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 28 Mar 2023 11:26:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, corbet@lwn.net, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org, efault@gmx.de
Subject: [PATCH 00/17] sched: EEVDF using latency-nice
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URI_DOTEDU autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Latest version of the EEVDF [1] patches.

Many changes since last time; most notably it now fully replaces CFS and uses
lag based placement for migrations. Smaller changes include:

 - uses scale_load_down() for avg_vruntime; I measured the max delta to be ~44
   bits on a system/cgroup based kernel build.
 - fixed a bunch of reweight / cgroup placement issues
 - adaptive placement strategy for smaller slices
 - rename se->lag to se->vlag

There's a bunch of RFC patches at the end and one DEBUG patch. Of those, the
PLACE_BONUS patch is a mixed bag of pain. A number of benchmarks regress
because EEVDF is actually fair and gives a 100% parent vs a 50% child a 67%/33%
split (stress-futex, stress-nanosleep, starve, etc..) instead of a 50%/50%
split that sleeper bonus achieves. Mostly I think these benchmarks are somewhat
artificial/daft but who knows.

The PLACE_BONUS thing horribly messes up things like hackbench and latency-nice
because it places things too far to the left in the tree. Basically it messes
with the whole 'when', by placing a task back in history you're putting a
burden on the now to accomodate catching up. More tinkering required.

But over-all the thing seems to be fairly usable and could do with more
extensive testing.

[1] https://citeseerx.ist.psu.edu/document?repid=rep1&type=pdf&doi=805acf7726282721504c8f00575d91ebfd750564

Results:

  hackbech -g $nr_cpu + cyclictest --policy other results:

			EEVDF			 CFS

		# Min Latencies: 00054
  LNICE(19)	# Avg Latencies: 00660
		# Max Latencies: 23103

		# Min Latencies: 00052		00053
  LNICE(0)	# Avg Latencies: 00318		00687
		# Max Latencies: 08593		13913

		# Min Latencies: 00054
  LNICE(-19)	# Avg Latencies: 00055
		# Max Latencies: 00061


Some preliminary results from Chen Yu on a slightly older version:

  schbench  (95% tail latency, lower is better)
  =================================================================================
  case                    nr_instance            baseline (std%)    compare% ( std%)
  normal                   25%                     1.00  (2.49%)    -81.2%   (4.27%)
  normal                   50%                     1.00  (2.47%)    -84.5%   (0.47%)
  normal                   75%                     1.00  (2.5%)     -81.3%   (1.27%)
  normal                  100%                     1.00  (3.14%)    -79.2%   (0.72%)
  normal                  125%                     1.00  (3.07%)    -77.5%   (0.85%)
  normal                  150%                     1.00  (3.35%)    -76.4%   (0.10%)
  normal                  175%                     1.00  (3.06%)    -76.2%   (0.56%)
  normal                  200%                     1.00  (3.11%)    -76.3%   (0.39%)
  ==================================================================================

  hackbench (throughput, higher is better)
  ==============================================================================
  case                    nr_instance            baseline(std%)  compare%( std%)
  threads-pipe              25%                      1.00 (<2%)    -17.5 (<2%)
  threads-socket            25%                      1.00 (<2%)    -1.9 (<2%)
  threads-pipe              50%                      1.00 (<2%)     +6.7 (<2%)
  threads-socket            50%                      1.00 (<2%)    -6.3  (<2%)
  threads-pipe              100%                     1.00 (3%)     +110.1 (3%)
  threads-socket            100%                     1.00 (<2%)    -40.2 (<2%)
  threads-pipe              150%                     1.00 (<2%)    +125.4 (<2%)
  threads-socket            150%                     1.00 (<2%)    -24.7 (<2%)
  threads-pipe              200%                     1.00 (<2%)    -89.5 (<2%)
  threads-socket            200%                     1.00 (<2%)    -27.4 (<2%)
  process-pipe              25%                      1.00 (<2%)    -15.0 (<2%)
  process-socket            25%                      1.00 (<2%)    -3.9 (<2%)
  process-pipe              50%                      1.00 (<2%)    -0.4  (<2%)
  process-socket            50%                      1.00 (<2%)    -5.3  (<2%)
  process-pipe              100%                     1.00 (<2%)    +62.0 (<2%)
  process-socket            100%                     1.00 (<2%)    -39.5  (<2%)
  process-pipe              150%                     1.00 (<2%)    +70.0 (<2%)
  process-socket            150%                     1.00 (<2%)    -20.3 (<2%)
  process-pipe              200%                     1.00 (<2%)    +79.2 (<2%)
  process-socket            200%                     1.00 (<2%)    -22.4  (<2%)
  ==============================================================================

  stress-ng (throughput, higher is better)
  ==============================================================================
  case                    nr_instance            baseline(std%)  compare%( std%)
  switch                  25%                      1.00 (<2%)    -6.5 (<2%)
  switch                  50%                      1.00 (<2%)    -9.2 (<2%)
  switch                  75%                      1.00 (<2%)    -1.2 (<2%)
  switch                  100%                     1.00 (<2%)    +11.1 (<2%)
  switch                  125%                     1.00 (<2%)    -16.7% (9%)
  switch                  150%                     1.00 (<2%)    -13.6 (<2%)
  switch                  175%                     1.00 (<2%)    -16.2 (<2%)
  switch                  200%                     1.00 (<2%)    -19.4% (<2%)
  fork                    50%                      1.00 (<2%)    -0.1 (<2%)
  fork                    75%                      1.00 (<2%)    -0.3 (<2%)
  fork                    100%                     1.00 (<2%)    -0.1 (<2%)
  fork                    125%                     1.00 (<2%)    -6.9 (<2%)
  fork                    150%                     1.00 (<2%)    -8.8 (<2%)
  fork                    200%                     1.00 (<2%)    -3.3 (<2%)
  futex                   25%                      1.00 (<2%)    -3.2 (<2%)
  futex                   50%                      1.00 (3%)     -19.9 (5%)
  futex                   75%                      1.00 (6%)     -19.1 (2%)
  futex                   100%                     1.00 (16%)    -30.5 (10%)
  futex                   125%                     1.00 (25%)    -39.3 (11%)
  futex                   150%                     1.00 (20%)    -27.2% (17%)
  futex                   175%                     1.00 (<2%)    -18.6 (<2%)
  futex                   200%                     1.00 (<2%)    -47.5 (<2%)
  nanosleep               25%                      1.00 (<2%)    -0.1 (<2%)
  nanosleep               50%                      1.00 (<2%)    -0.0% (<2%)
  nanosleep               75%                      1.00 (<2%)    +15.2% (<2%)
  nanosleep               100%                     1.00 (<2%)    -26.4 (<2%)
  nanosleep               125%                     1.00 (<2%)    -1.3 (<2%)
  nanosleep               150%                     1.00 (<2%)    +2.1  (<2%)
  nanosleep               175%                     1.00 (<2%)    +8.3 (<2%)
  nanosleep               200%                     1.00 (<2%)    +2.0% (<2%)
  ===============================================================================

  unixbench (throughput, higher is better)
  ==============================================================================
  case                    nr_instance            baseline(std%)  compare%( std%)
  spawn                   125%                      1.00 (<2%)    +8.1 (<2%)
  context1                100%                      1.00 (6%)     +17.4 (6%)
  context1                75%                       1.00 (13%)    +18.8 (8%)
  =================================================================================

  netperf  (throughput, higher is better)
  ===========================================================================
  case                    nr_instance          baseline(std%)  compare%( std%)
  UDP_RR                  25%                   1.00    (<2%)    -1.5%  (<2%)
  UDP_RR                  50%                   1.00    (<2%)    -0.3%  (<2%)
  UDP_RR                  75%                   1.00    (<2%)    +12.5% (<2%)
  UDP_RR                 100%                   1.00    (<2%)    -4.3%  (<2%)
  UDP_RR                 125%                   1.00    (<2%)    -4.9%  (<2%)
  UDP_RR                 150%                   1.00    (<2%)    -4.7%  (<2%)
  UDP_RR                 175%                   1.00    (<2%)    -6.1%  (<2%)
  UDP_RR                 200%                   1.00    (<2%)    -6.6%  (<2%)
  TCP_RR                  25%                   1.00    (<2%)    -1.4%  (<2%)
  TCP_RR                  50%                   1.00    (<2%)    -0.2%  (<2%)
  TCP_RR                  75%                   1.00    (<2%)    -3.9%  (<2%)
  TCP_RR                 100%                   1.00    (2%)     +3.6%  (5%)
  TCP_RR                 125%                   1.00    (<2%)    -4.2%  (<2%)
  TCP_RR                 150%                   1.00    (<2%)    -6.0%  (<2%)
  TCP_RR                 175%                   1.00    (<2%)    -7.4%  (<2%)
  TCP_RR                 200%                   1.00    (<2%)    -8.4%  (<2%)
  ==========================================================================


---
Also available at:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/eevdf

---
Parth Shah (1):
      sched: Introduce latency-nice as a per-task attribute

Peter Zijlstra (14):
      sched/fair: Add avg_vruntime
      sched/fair: Remove START_DEBIT
      sched/fair: Add lag based placement
      rbtree: Add rb_add_augmented_cached() helper
      sched/fair: Implement an EEVDF like policy
      sched: Commit to lag based placement
      sched/smp: Use lag to simplify cross-runqueue placement
      sched: Commit to EEVDF
      sched/debug: Rename min_granularity to base_slice
      sched: Merge latency_offset into slice
      sched/eevdf: Better handle mixed slice length
      sched/eevdf: Sleeper bonus
      sched/eevdf: Minimal vavg option
      sched/eevdf: Debug / validation crud

Vincent Guittot (2):
      sched/fair: Add latency_offset
      sched/fair: Add sched group latency support

 Documentation/admin-guide/cgroup-v2.rst |   10 +
 include/linux/rbtree_augmented.h        |   26 +
 include/linux/sched.h                   |    6 +
 include/uapi/linux/sched.h              |    4 +-
 include/uapi/linux/sched/types.h        |   19 +
 init/init_task.c                        |    3 +-
 kernel/sched/core.c                     |   65 +-
 kernel/sched/debug.c                    |   49 +-
 kernel/sched/fair.c                     | 1199 ++++++++++++++++---------------
 kernel/sched/features.h                 |   29 +-
 kernel/sched/sched.h                    |   23 +-
 tools/include/uapi/linux/sched.h        |    4 +-
 12 files changed, 794 insertions(+), 643 deletions(-)


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730EB6045B5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiJSMsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbiJSMrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:47:33 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0419CF4B
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:30:24 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id a5-20020a17090aa50500b002008eeb040eso737500pjq.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=00hqzPQ60wefKYMOhXC429UksHq3kwxJP8z9O6lm324=;
        b=MOjgelvdOpUz3hTkdT2hLaJgmsoNf4pMmZlcPSbRLd6dvofUiGAaVZZtr5/JC0p2Q/
         1JqYzhRFPeuM3biNvdYpbwtv428NyqVc3WyFV4Stc577+nAII0OmzfDUorGoGH43Xv2L
         qui08vC7vApFJVsqLX8i3emFeZei0ZmcMqvEqcNQ1IcLDo/MEbeXhV9NT9MGB/B/jMQ4
         7u4uyWnhd6PQAiwmytzgEyHaB1Y9kEtD25v1C8fXVGkDiczZmr2jkyqdUtczNtXudSb1
         3gxcTfN3uV1Z7663OkP1TNqpKtPjHpBkvpYd8nuJLtnxASr0HfAzs01koDty3H5Djtmm
         q4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=00hqzPQ60wefKYMOhXC429UksHq3kwxJP8z9O6lm324=;
        b=PpkysfGe7w61TJUnKmm7PDEUWdyH6r/bZfRJgyxOwuof/kv7mtJ/qRG2o1jqLI93In
         Q8ae1hXJ+WeTocsJd46jXMz0kBuPKitZS5UMTih4J950d4Bk20yeBIqeHHLN0zBLY92n
         o3mPYB5qHdd9tpBaiOzBgvNlZTDEdVkqZ9EgCj/IhH9P3bNUlWvSMPUQKAxfXap+GFn3
         H6fbaRqsZdWuwekp18sLkyDVbHTgzBn4O7hl0q/nBXVE54MQYgWP2vI9QpVO3MPta9fa
         9VnXNRyNz+6BGBm6rEbidoF8hqL9LMV+1R3Ns0SWWYXrra6eBhijveJUhmCB/j8MvglM
         f5aA==
X-Gm-Message-State: ACrzQf0WcPkLbawdK+GUzV3gMzQK6AMMCnip3rpXPEmDlE2Y5KvWppr1
        z+jOMRRpQUyCrh8Y+27nJ4eR3A==
X-Google-Smtp-Source: AMsMyM7DuFA66GEUBFlAXOlxY9CB5G/mp6mMckTWpwyn9mddRlsxxw6tio1OvceeFojzb4Rl390wxA==
X-Received: by 2002:a17:902:9b82:b0:183:fffb:1bfe with SMTP id y2-20020a1709029b8200b00183fffb1bfemr8265751plp.173.1666182569537;
        Wed, 19 Oct 2022 05:29:29 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id c21-20020a63da15000000b00439c6a4e1ccsm9881825pgh.62.2022.10.19.05.29.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Oct 2022 05:29:29 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Yicong Yang <yangyicong@huawei.com>,
        Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org,
        Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH v6 0/4] sched/fair: Improve scan efficiency of SIS
Date:   Wed, 19 Oct 2022 20:28:55 +0800
Message-Id: <20221019122859.18399-1-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset tries to improve SIS scan efficiency by recording idle
cpus in a cpumask for each LLC which will be used as a target cpuset
in the domain scan. The cpus are recorded at CORE granule to avoid
tasks being stack on same core.

v5 -> v6:
 - Rename SIS_FILTER to SIS_CORE as it can only be activated when
   SMT is enabled and better describes the behavior of CORE granule
   update & load delivery.
 - Removed the part of limited scan for idle cores since it might be
   better to open another thread to discuss the strategies such as
   limited or scaled depth. But keep the part of full scan for idle
   cores when LLC is overloaded because SIS_CORE can greatly reduce
   the overhead of full scan in such case.
 - Removed the state of sd_is_busy which indicates an LLC is fully
   busy and we can safely skip the SIS domain scan. I would prefer
   leave this to SIS_UTIL.
 - The filter generation mechanism is replaced by in-place updates
   during domain scan to better deal with partial scan failures.
 - Collect Reviewed-bys from Tim Chen

v4 -> v5:
 - Add limited scan for idle cores when overloaded, suggested by Mel
 - Split out several patches since they are irrelevant to this scope
 - Add quick check on ttwu_pending before core update
 - Wrap the filter into SIS_FILTER feature, suggested by Chen Yu
 - Move the main filter logic to the idle path, because the newidle
   balance can bail out early if rq->avg_idle is small enough and
   lose chances to update the filter.

v3 -> v4:
 - Update filter in load_balance rather than in the tick
 - Now the filter contains unoccupied cpus rather than overloaded ones
 - Added mechanisms to deal with the false positive cases

v2 -> v3:
 - Removed sched-idle balance feature and focus on SIS
 - Take non-CFS tasks into consideration
 - Several fixes/improvement suggested by Josh Don

v1 -> v2:
 - Several optimizations on sched-idle balancing
 - Ignore asym topos in can_migrate_task
 - Add more benchmarks including SIS efficiency
 - Re-organize patch as suggested by Mel Gorman

Abel Wu (4):
  sched/fair: Skip core update if task pending
  sched/fair: Ignore SIS_UTIL when has_idle_core
  sched/fair: Introduce SIS_CORE
  sched/fair: Deal with SIS scan failures

 include/linux/sched/topology.h |  15 ++++
 kernel/sched/fair.c            | 122 +++++++++++++++++++++++++++++----
 kernel/sched/features.h        |   7 ++
 kernel/sched/sched.h           |   3 +
 kernel/sched/topology.c        |   8 ++-
 5 files changed, 141 insertions(+), 14 deletions(-)

-- 
2.37.3


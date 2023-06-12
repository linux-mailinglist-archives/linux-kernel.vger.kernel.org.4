Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2561F72BA47
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjFLIXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjFLIWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:22:50 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8053CB0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 01:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686558160; x=1718094160;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2rgG2rKS+U3BDC47CyywE8OfkQ7iEr7xRn7WAqmb0O0=;
  b=TIWGhWwEYvO5GtqRPwOD8VXYfVM5AlI+Xo1uaa95IXkkiEnwvzyIfGNE
   ifdnUxGFXJHU7K9lGuii38+bj7ffzyJntvmTuVFKBoiJfrHU7njkkT+hi
   Y35KStbEFWG5xN9f347oI8UcAwfr9WXu/fPkAOibCMd7bJTHgyzF6w5mJ
   b63/+oCgiJt/zbjTzOq2HEOAfw9hx1AZ9IayJnenEqYnQV/hJNNjh4tUo
   I20DB3DwALeQ+q4EdYOsXcPluwfKmiffY09/9V6dKtMJVTBNaRcWcRhdH
   TuCDNdojYIHd1oks1yI1q+VhR9sKjewzPqBXB1CqXKsRAjWB6k/V8mwAu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="337612945"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="337612945"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 01:22:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="714315908"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="714315908"
Received: from chenyu-dev.sh.intel.com ([10.239.62.164])
  by fmsmga007.fm.intel.com with ESMTP; 12 Jun 2023 01:22:35 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
Subject: [RFC PATCH 0/4] Limit the scan depth to find the busiest sched group during newidle balance
Date:   Tue, 13 Jun 2023 00:17:53 +0800
Message-Id: <cover.1686554037.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is an attempt to reduce the cost of newidle balance which is
found to occupy noticeable CPU cycles on some high-core count systems.

For example, by running sqlite on Intel Sapphire Rapids, which has
2 x 56C/112T = 224 CPUs:

6.69%    0.09%  sqlite3     [kernel.kallsyms]   [k] newidle_balance
5.39%    4.71%  sqlite3     [kernel.kallsyms]   [k] update_sd_lb_stats

The main idea comes from the following question raised by Tim:
Do we always have to find the busiest group and pull from it? Would
a relatively busy group be enough?

The proposal ILB_UTIL mainly adjusts the newidle balance scan depth
within the current sched domain, based on the system utilization in
this domain. The more spare time there is in the domain, the more time
each newidle balance can spend on scanning for a busy group. Although
the newidle balance has per domain max_newidle_lb_cost to decide
whether to launch the balance or not, the ILB_UTIL provides a smaller
granularity to decide how many groups each newidle balance can scan.

patch 1/4 is code cleanup.

patch 2/4 is to introduce a new variable in sched domain to indicate the
          number of groups, and will be used by patch 3 and patch 4.

patch 3/4 is to calculate the scan depth in each periodic load balance.

patch 4/4 is to limit the scan depth based on the result of patch 3,
          and the depth will be used by newidle_balance()->
          find_busiest_group() -> update_sd_lb_stats()


According to the test result, netperf/tbench shows some improvements
when the system is underloaded, while no noticeable difference from
hackbench/schbench. While I'm trying to run more benchmarks including
some macro-benchmarks, I send this draft patch out and seek for suggestion
from the community if this is the right thing to do and if we are in the
right direction.

[We also have other wild ideas like sorting the groups by their load
in the periodic load balance, later newidle_balance() can fetch the
corresponding group in O(1). And this change seems to get improvement
too according to the test result].

Any comments would be appreciated.

Chen Yu (4):
  sched/fair: Extract the function to get the sd_llc_shared
  sched/topology: Introduce nr_groups in sched_domain to indicate the
    number of groups
  sched/fair: Calculate the scan depth for idle balance based on system
    utilization
  sched/fair: Throttle the busiest group scanning in idle load balance

 include/linux/sched/topology.h |  5 +++
 kernel/sched/fair.c            | 74 +++++++++++++++++++++++++++++-----
 kernel/sched/features.h        |  1 +
 kernel/sched/topology.c        | 10 ++++-
 4 files changed, 79 insertions(+), 11 deletions(-)

-- 
2.25.1


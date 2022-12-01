Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8ED363EB61
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 09:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiLAInx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 03:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiLAIn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 03:43:26 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959E32B60B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 00:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669884194; x=1701420194;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OP95VGQF4LTAa2ed4VObsXL9t73N0BVOPKgBRBowfmU=;
  b=j2w1WLHpxl0iTwV+ueIhXeLiC4AsUspe3C8C3NC5LakwXr8r/TO29HtG
   aw4mwM0I6KBOp6U+QScXb/Q6pNk4nzSlHJEj2mUvjWtAq+1Ki1y9LJTr7
   5mFjENAdPL/IiRaPpMTIH3emBhWFblKs2o/qpJHzAmF+l+b3f5zhdiqn0
   YqLjmE56by5tC17S1mzbpSHvCCRq09sHjDU2GMkyRZQlnAsYS/BPbtPNl
   MBzjARRxGtnUNo12Dzqn4fJg7vH9FxDnNtWAah/msCUpwAcy1vTeqsQCv
   UMR+c6UYKiGWwWpOGpkCqvK/1uoSVtYXy1lFDhxHrNnjVolNGDw2cyidb
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="313258657"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="313258657"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 00:43:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="769157706"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="769157706"
Received: from chenyu-dev.sh.intel.com ([10.239.158.170])
  by orsmga004.jf.intel.com with ESMTP; 01 Dec 2022 00:43:01 -0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        Honglei Wang <wanghonglei@didichuxing.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Don <joshdon@google.com>, linux-kernel@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH v3 0/2] sched/fair: Choose the CPU where short task is running during wake up
Date:   Thu,  1 Dec 2022 16:43:46 +0800
Message-Id: <cover.1669862147.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main purpose of this change is to avoid too many cross CPU
wake up when it is unnecessary. The frequent cross CPU wake up
brings significant damage to some workloads, especially on high
core count systems.

This patch set inhibits the cross CPU wake-up by placing the wakee
on waking CPU or previous CPU, if both the waker and wakee are
short-duration tasks.

The first patch is to introduce the definition of a short-duration
task. The second patch leverages the first patch to choose a local
or previous CPU for wakee.

This version is modified based on the following feedback on v2:

1. Peter suggested comparing the duration of waker and the cost to
   scan for an idle CPU: If the cost is higher than the task duration,
   do not waste time finding an idle CPU, choose the local or previous
   CPU directly. A prototype was created based on this suggestion.
   However, according to the test result, this prototype does not inhibit
   the cross CPU wakeup and did not bring improvement. Because the cost
   to find an idle CPU is small in the problematic scenario. The root
   cause of the problem is a race condition between scanning for an idle
   CPU and task enqueue(please refer to the commit log in PATCH 2/2).
   So v3 does not change the core logic of v2, with some refinement based
   on Peter's suggestion.

2. Simplify the logic to record the task duration per Peter and Abel's suggestion.

This change brings overall improvement on some microbenchmarks, both on
Intel and AMD platforms.

v2: https://lore.kernel.org/all/cover.1666531576.git.yu.c.chen@intel.com/
v1: https://lore.kernel.org/lkml/20220915165407.1776363-1-yu.c.chen@intel.com/

Chen Yu (2):
  sched/fair: Introduce short duration task check
  sched/fair: Choose the CPU where short task is running during wake up

 include/linux/sched.h   |  4 ++++
 kernel/sched/core.c     |  2 ++
 kernel/sched/fair.c     | 27 +++++++++++++++++++++++++++
 kernel/sched/features.h |  1 +
 4 files changed, 34 insertions(+)

-- 
2.25.1


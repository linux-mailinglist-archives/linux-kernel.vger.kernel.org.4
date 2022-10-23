Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3B8609465
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 17:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiJWPbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 11:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiJWPbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 11:31:47 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1569F748FB
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 08:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666539107; x=1698075107;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9rOfENj/Kam0ciZfrhO8XivyMo8Ezyxjf7KIXSWoW8o=;
  b=XSwUbqEoD14DXLi+TeoXIznyIeVvrIfPzda4s2en2uDYAxPo1lOgrRdn
   xL+OvMH2K2b9vgReQK+ex+ZUFAAmhJ5DeoTv/B+nxlfHdqYlLZRS8SMlS
   91+TIEBMnlDRkNP944z+DAw6s5reQGxYe9aAWRMAChKKCtk0pUfSgOPqj
   QV9ZK3aud1iz1akRyi9JZbw90zHZRDUqyxDdR3Hx3zj8OAo8ngzwAgEk9
   CDb5TOQa9aA+R8kyY9LXzevdYs+dDi6fDbL05duqDtBbduKTtRtyZRfaF
   aV6PdtFq40n5KqX3/jWXLX30MTMjRFBG9O4/sHEp2L2wrtiIMyo18AnWi
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="290580017"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="290580017"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2022 08:31:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="876201892"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="876201892"
Received: from chenyu-dev.sh.intel.com ([10.239.158.170])
  by fmsmga006.fm.intel.com with ESMTP; 23 Oct 2022 08:31:42 -0700
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
        Chen Yu <yu.chen.surf@gmail.com>, linux-kernel@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>
Subject: [RFC PATCH v2 0/2] sched/fair: Choose the CPU where short task is running during wake up
Date:   Sun, 23 Oct 2022 23:31:50 +0800
Message-Id: <cover.1666531576.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At LPC 2022 Real-time and Scheduling Micro Conference we presented
the cross CPU wakeup issue. This patch is a text version of the
talk, and hopefully, we can clarify the problem and appreciate any
feedback.

The main purpose of this change is to avoid too many crosses CPU
wake up when the system is busy. Please refer to the commit log
of [PATCH 2/2] for detail.

This patch set is composed of two parts. The first part is to introduce
the definition of a short-duration task. The second part leverages the
first part to choose a CPU where only one short-duration task is running
on. This CPU is chosen as the candidate to place a woken task.

This version is modified based on the following feedback on v1:
1. Tim suggested raising the bar to choose a CPU with a short-duration
   task, by checking if the short-duration task is the only runnable
   task on the target CPU.
2. To address Peter's concern: would this patch inhibit spreading the
   workload when there are idle CPUs around? The patch would only take
   effect when the system is relatively busy, and only choose the CPU
   where only one short-duration task is running.
3. Prateek, Honglwei and Hillf suggsted to prefer previous idle CPU to the
   CPU with short-duration task running.

v1 link: https://lore.kernel.org/lkml/20220915165407.1776363-1-yu.c.chen@intel.com/

Chen Yu (2):
  sched/fair: Introduce short duration task check
  sched/fair: Choose the CPU where short task is running during wake up

 include/linux/sched.h   |  8 ++++
 kernel/sched/core.c     |  2 +
 kernel/sched/fair.c     | 99 +++++++++++++++++++++++++++++++++++++++++
 kernel/sched/features.h |  1 +
 4 files changed, 110 insertions(+)

-- 
2.25.1


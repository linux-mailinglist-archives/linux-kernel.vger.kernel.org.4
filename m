Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1D7711E1F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 04:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235394AbjEZCtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 22:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjEZCtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 22:49:04 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA5D9C
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 19:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685069343; x=1716605343;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nKfvvNijiD3HGX1IG9gf/m7+0RqedZ9hxmzlg8rY6N0=;
  b=HlHSiCZ0c0TX/kumkaDUNmUXaCEZy4/npebsL9P5mBgtVxxJYxd2BmqM
   TQAh5UmRN0MgU0nXKnidUXHFc4Sl8NSkD8tg1wc06a8wHwEevKqYqn7gY
   dl/NNptNzRXVLogWMxT7vIb6nQKZjvDgP9ndLBRs2KUdG7HAJKbODzeSq
   GjmzoHtv0fTTGCOKL0lySgUyaAlF/KAhCDvvbKShJt+mZtvira13PClkg
   RznOeU2PCsSb5MYF0k9I8KDBvcUDF6vjjAWcsQn10df3bcv1nd3OHy7rz
   C0dch+1V4sYTrzYsqHdTsIMfNA1sAeLhRg01c4UrD9ZKIr/Y/RRlRcaBE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="351606649"
X-IronPort-AV: E=Sophos;i="6.00,192,1681196400"; 
   d="scan'208";a="351606649"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 19:49:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="699266269"
X-IronPort-AV: E=Sophos;i="6.00,192,1681196400"; 
   d="scan'208";a="699266269"
Received: from linux-pnp-server-22.sh.intel.com ([10.239.147.143])
  by orsmga007.jf.intel.com with ESMTP; 25 May 2023 19:49:00 -0700
From:   Deng Pan <pan.deng@intel.com>
To:     tim.c.chen@intel.com, peterz@infradead.org
Cc:     vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        tianyou.li@intel.com, yu.ma@intel.com, lipeng.zhu@intel.com,
        Deng Pan <pan.deng@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: [PATCH] sched/task_group: Re-layout structure to reduce false sharing
Date:   Fri, 26 May 2023 10:50:44 +0800
Message-Id: <20230526025044.1660438-1-pan.deng@intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running UnixBench/Pipe-based Context Switching case, we observed
high false sharing for accessing ‘load_avg’ against rt_se and rt_rq.

Pipe-based Context Switching case is a typical suspend/wakeup scenario,
in which load_avg is frequenly loaded and stored, at the meantime,
rt_se and rt_rq are frequently loaded. Unfortunately, they are in the
same cacheline.

This change re-layouts the structure:
1.  Move rt_se and rt_rq to a 2nd cacheline.
2.  Keep ‘parent’ field in the 2nd cacheline since it is also accessed
very often when cgroups are nested, thanks Tim Chen for providing the
insight.

With this change, on Intel Icelake 2 sockets 80C/160T platform, based
on v6.0-rc6, the 160 parallel score is improved ~5%, perf tool reported
rt_se and rt_rq access cycles are reduced from ~6.0% to ~0.1%.
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Deng Pan <pan.deng@intel.com>
---
 kernel/sched/sched.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ec7b3e0a2b20..a1dd289511b2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -389,6 +389,13 @@ struct task_group {
 #endif
 #endif
 
+	struct rcu_head		rcu;
+	struct list_head	list;
+
+	struct list_head	siblings;
+	struct list_head	children;
+	struct task_group	*parent;
+
 #ifdef CONFIG_RT_GROUP_SCHED
 	struct sched_rt_entity	**rt_se;
 	struct rt_rq		**rt_rq;
@@ -396,13 +403,6 @@ struct task_group {
 	struct rt_bandwidth	rt_bandwidth;
 #endif
 
-	struct rcu_head		rcu;
-	struct list_head	list;
-
-	struct task_group	*parent;
-	struct list_head	siblings;
-	struct list_head	children;
-
 #ifdef CONFIG_SCHED_AUTOGROUP
 	struct autogroup	*autogroup;
 #endif
-- 
2.39.1


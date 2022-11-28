Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E1263A93C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbiK1NOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbiK1NNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:13:41 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF74122D;
        Mon, 28 Nov 2022 05:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669641220; x=1701177220;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=p7BCBvy/ijiGArW5gb4LxSYPxM/Arci+QhS/bMOw9bo=;
  b=gSFrBgEqXr5rBXnI3IFSYy+cx+9uhnT4QhrkD3L0uF9xdrzRceWmNDjh
   ZKMKJJarF4v+ACLXe8Sh03JqoLVY8TjXdK2yU0sQZONt8nuVXGDSe4apo
   rMCVuxYe9m8XJw9xn4W49uNfPB2J2Sk9DZ0V6QfNNjlR37RAMisrOlJST
   iWwWrHksfFikdxNVa8UqgYtvEXKkVh2EaXDlzCMrFVJ3eLAYqq6KZqXws
   c5xI2L11dv4buBjsJwsTvn0AyDd0VoIaq6Vz4is3dg1nQBE+rKPV+VXBV
   2h9YaQnS9bR5/oDopZ3nPh2pflANk57kPXVFFnnMCKzINW1Zl8GrG2FFQ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="401117226"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="401117226"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 05:13:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="749381387"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="749381387"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga002.fm.intel.com with ESMTP; 28 Nov 2022 05:13:35 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Tim C . Chen" <tim.c.chen@intel.com>
Subject: [PATCH v2 17/22] sched/task_struct: Add helpers for IPC classification
Date:   Mon, 28 Nov 2022 05:20:55 -0800
Message-Id: <20221128132100.30253-18-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221128132100.30253-1-ricardo.neri-calderon@linux.intel.com>
References: <20221128132100.30253-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The unprocessed classification that hardware provides for a task may not
be usable by the scheduler: the classification may change too frequently or
architectures may want to consider extra factors. For instance, some
processors with Intel Thread Director need to consider the state of the SMT
siblings of a core.

Provide per-task helper variables that architectures can use to post-
process the classification that hardware provides.

Cc: Ben Segall <bsegall@google.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: Len Brown <len.brown@intel.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tim C. Chen <tim.c.chen@intel.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: x86@kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v1:
 * Used bit-fields to fit all the IPC class data in 4 bytes. (PeterZ)
 * Shortened names of the helpers.
 * Renamed helpers with the ipcc_ prefix.
 * Reworded commit message for clarity
---
 include/linux/sched.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index ddabc7449edd..8a99aa316c37 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1532,7 +1532,17 @@ struct task_struct {
 	 * A hardware-defined classification of task based on the number
 	 * of instructions per cycle.
 	 */
-	unsigned int			ipcc;
+	unsigned int			ipcc : 9;
+	/*
+	 * A candidate classification that arch-specific implementations
+	 * qualify for correctness.
+	 */
+	unsigned int			ipcc_tmp : 9;
+	/*
+	 * Counter to filter out transient the candidate classification
+	 * of a task
+	 */
+	unsigned int			ipcc_cntr : 14;
 #endif
 
 	/*
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8359C5B42CE
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 01:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbiIIXIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 19:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbiIIXGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 19:06:48 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66673112B05
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 16:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662764799; x=1694300799;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=J55eTet+/pIJBGUmidFc+Ug/avoVg22/mJRLCJ1cam4=;
  b=ME9YZxCK//c2TLvw8AJz1PLQdzgErrhejWqaUZO3p8R8soFVa77P62d6
   7+TYR4NWSq4ClKVsV4QotQ5gCwQXrxAwWiTx9JGcJ2tmiMW+/w9SV9K4j
   6f0qdGAPBs31ERkpz9aRmjEE0u97z7kb+6vSRaDRqEF5njq7EaB+TytnA
   LdXY92TM45Uhu/uLUdSMackcQjJfFvRXIx4ee1dXLuo+u224rxN05wQjX
   MgLeF8WyLtaxnp4pSf1OSxA6OcWs/nRavLVFh5uaIqSPM35cD5VoDaFCW
   QtOQToqIlYsEj5sbp0dsyyAD/nHz90KuNjUy3zJaEYkCtHZJngm9hq9SH
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="298386922"
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="298386922"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 16:06:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="677355037"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga008.fm.intel.com with ESMTP; 09 Sep 2022 16:06:35 -0700
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
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Tim C . Chen" <tim.c.chen@intel.com>
Subject: [RFC PATCH 18/23] sched/task_struct: Add helpers for task classification
Date:   Fri,  9 Sep 2022 16:12:00 -0700
Message-Id: <20220909231205.14009-19-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
References: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The unprocessed classification that hardware provides for a task may not
be usable by the scheduler. The classification may change too frequently.
An arch-specific implementation may want to consider other factors. For
instance, Intel Thread Director considers the state of the SMT siblings
of core.

Provide per-task helper variables that architectures can use to post-
process the classification that hardware provides.

Cc: Ben Segall <bsegall@google.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tim C. Chen <tim.c.chen@intel.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
signed char and unsigned char are both signed in riscv architecture.
Use a signed char to avoid compilation warnings.
---
 include/linux/sched.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 73f9e745d17d..6c8907622f00 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1517,6 +1517,16 @@ struct task_struct {
 #ifdef CONFIG_SCHED_TASK_CLASSES
 	/* Class of task that the scheduler uses for task placement decisions */
 	short				class;
+	/*
+	 * A candidate classification that arch-specific implementations
+	 * qualify for correctness.
+	 */
+	short				class_candidate;
+	/*
+	 * Counter to filter out transient the candidate classification
+	 * of a task
+	 */
+	char				class_debounce_counter;
 #endif
 
 	/*
-- 
2.25.1


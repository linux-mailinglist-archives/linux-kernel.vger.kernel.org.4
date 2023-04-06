Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7196DA288
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239196AbjDFUV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238977AbjDFUVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:21:04 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D1993E4
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 13:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680812462; x=1712348462;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=7BReSg2zsB5y0pHQ7AAJ8Y7mGqv5oVtV05dcWb8L9Pw=;
  b=N6rjBtfx65jWcCQmdQg2ssaKQfkguwVN4wsZi4TXcALhVZtpef6g+FVp
   iLebNQ2VJHiC2/Q9AuySYVZKTMRfpbhxQpFQU+sKPIg3NzJBX3DQHal2U
   BY2bpMOLc+ccxhbqUANIZvKWK0pmTEanH8Uj9VafZRymRshds2gSs/PjW
   kHPIe/rgjAWtySDEj5Q2Rwmc+VffbaFxceR2MTqKQgWRBQUipmAECz5jT
   T4Oy7q9KssoFsoVy4hoU81gtN/EwYoYB6B32SA4JATRd+AZxdJfYe0WcK
   9C0GhEQ2geELryEYBDauu2HO+1tTIH8wKRcAF5A+efuwetvozuF3Zpg+e
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="407957793"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="407957793"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 13:21:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="861529894"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="861529894"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga005.jf.intel.com with ESMTP; 06 Apr 2023 13:21:01 -0700
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
        Valentin Schneider <vschneid@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Tim C . Chen" <tim.c.chen@intel.com>
Subject: [PATCH v4 09/12] sched/topology: Remove SHARED_CHILD from ASYM_PACKING
Date:   Thu,  6 Apr 2023 13:31:45 -0700
Message-Id: <20230406203148.19182-10-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230406203148.19182-1-ricardo.neri-calderon@linux.intel.com>
References: <20230406203148.19182-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only x86 and Power7 use ASYM_PACKING. They use it differently.

Power7 has cores of equal priority, but the SMT siblings of a core have
different priorities. Parent scheduling domains do not need (nor have) the
ASYM_PACKING flag. SHARED_CHILD is not needed. Using SHARED_PARENT would
cause the topology debug code to complain.

X86 has cores of different priority, but all the SMT siblings of the core
have equal priority. It needs ASYM_PACKING at the MC level, but not at the
SMT level (it also needs it at upper levels if they have scheduling groups
of different priority). Removing ASYM_PACKING from the SMT domain causes
the topology debug code to complain.

Remove SHARED_CHILD for now. We still need a topology check that satisfies
both architectures.

Cc: Ben Segall <bsegall@google.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tim C. Chen <tim.c.chen@intel.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Tested-by: Zhang Rui <rui.zhang@intel.com>
Suggested-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v3:
 * Removed spurious space.

Changes since v2:
 * Introduced this patch.

Changes since v1:
 * N/A
---
 include/linux/sched/sd_flags.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
index 57bde66d95f7..fad77b5172e2 100644
--- a/include/linux/sched/sd_flags.h
+++ b/include/linux/sched/sd_flags.h
@@ -132,12 +132,9 @@ SD_FLAG(SD_SERIALIZE, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
 /*
  * Place busy tasks earlier in the domain
  *
- * SHARED_CHILD: Usually set on the SMT level. Technically could be set further
- *               up, but currently assumed to be set from the base domain
- *               upwards (see update_top_cache_domain()).
  * NEEDS_GROUPS: Load balancing flag.
  */
-SD_FLAG(SD_ASYM_PACKING, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
+SD_FLAG(SD_ASYM_PACKING, SDF_NEEDS_GROUPS)
 
 /*
  * Prefer to place tasks in a sibling domain
-- 
2.25.1


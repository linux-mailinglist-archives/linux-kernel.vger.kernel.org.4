Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D1872D88D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 06:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239610AbjFMEZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 00:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239412AbjFMEX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 00:23:57 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6342122;
        Mon, 12 Jun 2023 21:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686630128; x=1718166128;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=t17FqAhGdxt78i227uUsMAyQGoFX7gC6V9+9xUvlqks=;
  b=cw8fJ7dm2IkYXTUGRdF06uoKm7vBrYB7wLh5ROagYUOkbyGz2pLqKTuM
   Jxj+d2QGHWWR0KEvuO4gYvSvXzNpVwaBzJlJ8un8c+ma3lU2bLK6qawM4
   XOfWk0UapCEYggK2l5UwxM9VEzGdnFnP6vZoJFHMthAso84fUQ7wMico9
   +hk76Q++a2PPxAiae1FJBzZcg6y71ObVfdkQhzlni2Y0AV5cxkVJJ2hRO
   mvJd4x+KR0gLGwinQs1q5RBVCKyfzBxpduVOzfEiCkcAfUqEsgNIvyPWy
   Mqwytn/GT9x+ShT2Z6PXuWiBZp8hONg1lH1+Qo+Js5dviO/HVUdv8qiwL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="358222240"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="358222240"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 21:21:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="661854987"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="661854987"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga003.jf.intel.com with ESMTP; 12 Jun 2023 21:21:57 -0700
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
        Lukasz Luba <lukasz.luba@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Zhao Liu <zhao1.liu@intel.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>, x86@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Tim C . Chen" <tim.c.chen@intel.com>,
        Zhao Liu <zhao1.liu@linux.intel.com>
Subject: [PATCH v4 18/24] sched/task_struct: Add helpers for IPC classification
Date:   Mon, 12 Jun 2023 21:24:16 -0700
Message-Id: <20230613042422.5344-19-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230613042422.5344-1-ricardo.neri-calderon@linux.intel.com>
References: <20230613042422.5344-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The raw classification that hardware provides for a task may not
be directly usable by the scheduler: the classification may change too
frequently or architecture-specific implementations may need to consider
additional factors. For instance, some processors with Intel Thread
Director need to consider the state of the SMT siblings of a core.

Provide per-task helper variables that architectures can use to
postprocess the classification that hardware provides.

Cc: Ben Segall <bsegall@google.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: Len Brown <len.brown@intel.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Perry Yuan <Perry.Yuan@amd.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tim C. Chen <tim.c.chen@intel.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: x86@kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v3:
 * None

Changes since v2:
 * None

Changes since v1:
 * Used bit-fields to fit all the IPC class data in 4 bytes. (PeterZ)
 * Shortened names of the helpers.
 * Renamed helpers with the ipcc_ prefix.
 * Reworded commit message for clarity
---
 include/linux/sched.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 0e1c38ad09c2..719147460ca8 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1541,7 +1541,17 @@ struct task_struct {
 	 * A hardware-defined classification of task that reflects but is
 	 * not identical to the number of instructions per cycle.
 	 */
-	unsigned short			ipcc;
+	unsigned int			ipcc : 9;
+	/*
+	 * A candidate classification that arch-specific implementations
+	 * qualify for correctness.
+	 */
+	unsigned int			ipcc_tmp : 9;
+	/*
+	 * Counter to filter out transient candidate classifications
+	 * of a task.
+	 */
+	unsigned int			ipcc_cntr : 14;
 #endif
 
 	/*
-- 
2.25.1


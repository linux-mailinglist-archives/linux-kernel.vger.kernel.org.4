Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAEC26DA28B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239105AbjDFUVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239009AbjDFUVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:21:05 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409D3AD08
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 13:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680812464; x=1712348464;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=fREIBOaLcOx3UjPL9vIqpWDQZqUDKK+pIIzMkJlC+q8=;
  b=Ec51wwTxPUhClhh9H37bapFB0r3NlESithmxe4289PG1lTZhuBc07+RC
   jyvZp3X96U5syCVBJG74gArZS/fO3A+JInTxO/D5f/0oS6fZG2/uqb5Gp
   CP4Rl9mZLY71QU34nPTmoq4cfAbl1QqgYMWHe6RBYoNVhdWkeFdSGzJhB
   A8dNXOVVvS8fbHv9rMjf42zoh5a18CkIHsMl5UcydkV9U/XAG7dduXLv7
   8Yb1pM+0TsXKFqoo/5X/nt6CLTBra0IEhK6gOXfQuppVAz/4aR8iwl4dR
   HVOX0xoutMjrDNtrjnpZK91NbAJHmHJMQ9/gIbBhG4leh8lyKMCP2m8nh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="407957828"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="407957828"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 13:21:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="861529912"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="861529912"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga005.jf.intel.com with ESMTP; 06 Apr 2023 13:21:02 -0700
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
        linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>,
        "Tim C . Chen" <tim.c.chen@intel.com>
Subject: [PATCH v4 12/12] x86/sched: Add the SD_ASYM_PACKING flag to the die domain of hybrid processors
Date:   Thu,  6 Apr 2023 13:31:48 -0700
Message-Id: <20230406203148.19182-13-ricardo.neri-calderon@linux.intel.com>
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

From: Chen Yu <yu.c.chen@intel.com>

Intel Meteor Lake hybrid processors have cores in two separate dies. The
cores in one of the dies have higher maximum frequency. Use the SD_ASYM_
PACKING flag to give higher priority to the die with CPUs of higher maximum
frequency.

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
Suggested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
Changes since v3:
 * Introduced this patch.

Changes since v2:
 * N/A

Changes since v1:
 * N/A
---
 arch/x86/kernel/smpboot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index cf7f42189e86..8d966f618413 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -583,7 +583,7 @@ static struct sched_domain_topology_level x86_hybrid_topology[] = {
 #ifdef CONFIG_SCHED_MC
 	{ cpu_coregroup_mask, x86_core_flags, SD_INIT_NAME(MC) },
 #endif
-	{ cpu_cpu_mask, SD_INIT_NAME(DIE) },
+	{ cpu_cpu_mask, x86_sched_itmt_flags, SD_INIT_NAME(DIE) },
 	{ NULL, },
 };
 
-- 
2.25.1


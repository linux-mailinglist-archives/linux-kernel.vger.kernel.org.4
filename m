Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E86874B9BE
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 00:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbjGGW5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 18:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjGGW46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 18:56:58 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F011992
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 15:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688770617; x=1720306617;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=40RBK7UEzMfh6s+/yIJhkN9+deAVJi5T19wOPusP9aM=;
  b=OBYCgSmV8jNink+T4OFXEL4Qi4vKbSwNyZuOHGmpKgNohAztcWOzkbLJ
   QSyeQPjeLDh4+2RoTMd3/skmo9e2Oq1KRck+8pWfLu9qriFwh/X6GDkap
   l7Z9Iwap6xc5HvSgbOtCGWmD7vNoL7v0LARkkLM3hG21mFj8g6Jnk1U+3
   i4/dKeHs28Cuan0Gog0tEBf6FhPQ70KyGQ6JoYY040imVIClEFwqGlgft
   QUrTW9zZN+cyjrOm8q7moeL6Iq2i8kVJEZ9++Nxn3jdb8ZnQBYR7qVPwQ
   IS5bhvtbMrEDRTozvaYMswpLBw6JtF0/BILB2mjZBZ03vvRB5etr8QITE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="427683505"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="427683505"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 15:56:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="714176681"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="714176681"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by orsmga007.jf.intel.com with ESMTP; 07 Jul 2023 15:56:57 -0700
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tim C Chen <tim.c.chen@linux.intel.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        Yicong Yang <yangyicong@hisilicon.com>,
        Barry Song <v-songbaohua@oppo.com>,
        Chen Yu <yu.c.chen@intel.com>, Hillf Danton <hdanton@sina.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [Patch v3 5/6] sched/x86: Add cluster topology to hybrid CPU
Date:   Fri,  7 Jul 2023 15:57:04 -0700
Message-Id: <e64678a22c57d572dcac20a0d492d406d56bf881.1688770494.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1688770494.git.tim.c.chen@linux.intel.com>
References: <cover.1688770494.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tim C Chen <tim.c.chen@linux.intel.com>

Cluster topology was not enabled on hybrid x86 CPU as load balance
was not properly working for cluster domain.  That has been fixed and
cluster domain can be enabled for hybrid CPU.

Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 arch/x86/kernel/smpboot.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index cea297d97034..2489d767c398 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -575,6 +575,9 @@ static struct sched_domain_topology_level x86_hybrid_topology[] = {
 #ifdef CONFIG_SCHED_SMT
 	{ cpu_smt_mask, x86_smt_flags, SD_INIT_NAME(SMT) },
 #endif
+#ifdef CONFIG_SCHED_CLUSTER
+	{ cpu_clustergroup_mask, x86_cluster_flags, SD_INIT_NAME(CLS) },
+#endif
 #ifdef CONFIG_SCHED_MC
 	{ cpu_coregroup_mask, x86_core_flags, SD_INIT_NAME(MC) },
 #endif
-- 
2.32.0


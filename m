Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF09C728B26
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 00:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237186AbjFHWcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 18:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237218AbjFHWcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 18:32:31 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED742D78
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 15:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686263543; x=1717799543;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qV3Dw8igkVoKguLTu65QopHctrOrSlhGJhrK2Z67mn4=;
  b=Ultd5iGIcJyuXRxhPkEEjKokq/T4fHxBBKa30moIzItEGNLRPUMUmEsx
   Y3J1t9ExeQo8G+iEneZfW2RIabPpGFDpuo4tZdxpXjmbIBtCcWDVSbbEb
   kCj1qpTMZupAe9dVrL2lp+uRMxzH4eS2uKVDNGnpGGQZqpBjsAJ8dSzfg
   ycBSbvW55ccH1/Q257K9ZGNUHxnzEJjPrOVlpsGKG8/oDNq0dbVShKy06
   pbOhVcBOFlO7RTD5z7UuwKr4ryijdYqs2F+huBDksaIFScDGS55/SLUS4
   foWqt5+hGLz51TERdPnLlFQ331Bf7J9w+ctg9fXaTYTRipUUIHGaIwBDG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="347094808"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="347094808"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 15:32:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="956906460"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="956906460"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by fmsmga006.fm.intel.com with ESMTP; 08 Jun 2023 15:32:21 -0700
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
        Chen Yu <yu.c.chen@intel.com>, Hillf Danton <hdanton@sina.com>
Subject: [Patch v2 6/6] sched/debug: Dump domains' sched group flags
Date:   Thu,  8 Jun 2023 15:32:32 -0700
Message-Id: <6c92a6e1bee6217b4286e77136287699755859b0.1686263351.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1686263351.git.tim.c.chen@linux.intel.com>
References: <cover.1686263351.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tim C Chen <tim.c.chen@linux.intel.com>

From: Peter Zijlstra (Intel) <peterz@infradead.org>

There have been a case where the SD_SHARE_CPUCAPACITY sched group flag
in a parent domain were not set and propagated properly when a degenerate
domain is removed.

Add dump of domain0 sched group flags of a CPU to make debug easier
in the future.

Usage:
cat /debug/sched/domains/cpu0/domain1/groups_flags
to dump cpu0 domain1's sched group flags.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/debug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 1637b65ba07a..55b50f940feb 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -389,6 +389,7 @@ static void register_sd(struct sched_domain *sd, struct dentry *parent)
 #undef SDM
 
 	debugfs_create_file("flags", 0444, parent, &sd->flags, &sd_flags_fops);
+	debugfs_create_file("groups_flags", 0444, parent, &sd->groups->flags, &sd_flags_fops);
 }
 
 void update_sched_domain_debugfs(void)
-- 
2.32.0


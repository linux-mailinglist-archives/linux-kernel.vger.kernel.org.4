Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE0E74B9BF
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 00:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjGGW5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 18:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbjGGW47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 18:56:59 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0088419B7
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 15:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688770618; x=1720306618;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=862H8iEOdr8bBhkOKfZF+tLzXIXXbB5+ndLrLrloY0I=;
  b=gSTxPZ7sK6/tTXb4V1TnhFoIl+9cKmjAKlGUF/FyHvrJ66C35qHoYfle
   aBnDhCmw0MoWYmZdu6P2nK3GJk+7hYllOw0Ubf3qA0yZosb2wAfLOFddP
   0T2XYFnWrp8ToT0WInUzyn6QpSK3IxJaQIuRi5sbpg96cLVA3143lLvJu
   vmUcdi/oLvJf7gMYU6dgp1deRuyBzmYyW+wt360rGSUXPbxm79B2LNpkW
   qjBo2/fli9UVw9TG7dEmagP93W/y4LXAFzoBcJ4vzBvrcWDU8Dqay372N
   cy9vzyjHoH6Lk0gs2ZgIBpFTZepMJtMtfNgTnaVz44okQtHSXXAG8hqtk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="427683523"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="427683523"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 15:56:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="714176687"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="714176687"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by orsmga007.jf.intel.com with ESMTP; 07 Jul 2023 15:56:58 -0700
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
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
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        Yicong Yang <yangyicong@hisilicon.com>,
        Barry Song <v-songbaohua@oppo.com>,
        Chen Yu <yu.c.chen@intel.com>, Hillf Danton <hdanton@sina.com>
Subject: [Patch v3 6/6] sched/debug: Dump domains' sched group flags
Date:   Fri,  7 Jul 2023 15:57:05 -0700
Message-Id: <ed1749262d94d95a8296c86a415999eda90bcfe3.1688770494.git.tim.c.chen@linux.intel.com>
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

From: "Peter Zijlstra (Intel)" <peterz@infradead.org>

There have been a case where the SD_SHARE_CPUCAPACITY sched group flag
in a parent domain were not set and propagated properly when a degenerate
domain is removed.

Add dump of domain sched group flags of a CPU to make debug easier
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


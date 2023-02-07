Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C394668CE9C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 06:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjBGFDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 00:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjBGFCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 00:02:00 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0433F10ABF;
        Mon,  6 Feb 2023 21:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675746118; x=1707282118;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=MnwH95WqrXx0YKjXk9ndqrfgMIqXB+pUulyYTmcEQjs=;
  b=kYtZL5d7ayHswTaAQ5gMhx0Nug0SLsiXIVIDCSc6wbcXjqbAv0T8xaVL
   Pmtku8+ZXtdvlmlNDwu8OMjZcKjwqADLokBiQhzDqwCKuFJaiTaw+mUwm
   hadIQlc2SIrM7S2FBELUTkITH3xGmaaz9rgbpaPVvgFjBkfLc9BZRXekH
   7yakHEhYNbUfxxIEeZO2eB7/s7jzWB7UM1SpTmr6mLb09afy7TEsyDVDa
   kjv3sYUPGbHW0/r+3xRDB66MQCZj+cs/ntE+AtWo13n1X8I2p7uXgKdAH
   5algSyVlqMJM4m4IOKejY0wjCYxHZgPQYrvee/kCD+oPNnv0s4YU15FF6
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="415625938"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="415625938"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 21:01:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="668657768"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="668657768"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga007.fm.intel.com with ESMTP; 06 Feb 2023 21:01:45 -0800
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
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Tim C . Chen" <tim.c.chen@intel.com>
Subject: [PATCH v3 19/24] sched/core: Initialize helpers of task classification
Date:   Mon,  6 Feb 2023 21:11:00 -0800
Message-Id: <20230207051105.11575-20-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230207051105.11575-1-ricardo.neri-calderon@linux.intel.com>
References: <20230207051105.11575-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just as tasks start life unclassified, initialize the classification
auxiliar variables.

Cc: Ben Segall <bsegall@google.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: Len Brown <len.brown@intel.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>
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
Changes since v2:
 * None

Changes since v1:
 * None
---
 kernel/sched/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9f4e9cc16df8..71b4af7ae496 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4430,6 +4430,8 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	p->se.vruntime			= 0;
 #ifdef CONFIG_IPC_CLASSES
 	p->ipcc				= IPC_CLASS_UNCLASSIFIED;
+	p->ipcc_tmp			= IPC_CLASS_UNCLASSIFIED;
+	p->ipcc_cntr			= 0;
 #endif
 	INIT_LIST_HEAD(&p->se.group_node);
 
-- 
2.25.1


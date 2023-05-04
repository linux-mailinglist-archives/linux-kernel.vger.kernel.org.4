Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8706F6FA1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 18:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjEDQL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 12:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjEDQLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 12:11:46 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7D9618E
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 09:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683216705; x=1714752705;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LkjRqsC5V494jb9ZiKbdqZcVv6xc35gqFoVHEt0Y9iQ=;
  b=XaWAeOa6M7Yhk9SsK1AUdN41/txU+CnDx4kKa5opbJ1IaDpFCKErUxRt
   Y5r6MQjWV3YoSocypwzMuyo5QJF+l2Xq0O7RDmQXnyXlkerrALNCBwU7x
   J2luLzgmSECSv478G6iv9RzarTwQRVAgJEUwdDYaJKy/DPywdJqkETiK5
   AIdhPvUtGV0USpV4ZERELgCP4LnYJoonDPzy5G5BpZMAU6rIj+GXQ7iXo
   dzj1+LViLQF9EmHximXoQZ9Dqu2tLySe0IH0OkC6sjNex28Bl6Fg6VZuS
   WopH1Y1ucQX6D9j2ZVXWrAn16aNsTmlLc3N+szRylQ+/4n1ACjLxmcNBe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="377049091"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="377049091"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 09:09:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="766633540"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="766633540"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by fmsmga004.fm.intel.com with ESMTP; 04 May 2023 09:09:33 -0700
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
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH 4/6] sched/fair: Skip prefer sibling move between SMT group and non-SMT group
Date:   Thu,  4 May 2023 09:09:54 -0700
Message-Id: <b20517e3986bfdde8a605afa19d144ec411c7a42.1683156492.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1683156492.git.tim.c.chen@linux.intel.com>
References: <cover.1683156492.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tim C Chen <tim.c.chen@linux.intel.com>

Do not try to move tasks between non SMT sched group and SMT sched
group for "prefer sibling" load balance.
Let asym_active_balance_busiest() handle that case properly.
Otherwise we could get task bouncing back and forth between
the SMT sched group and non SMT sched group.

Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8a325db34b02..58ef7d529731 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10411,8 +10411,12 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 	/*
 	 * Try to move all excess tasks to a sibling domain of the busiest
 	 * group's child domain.
+	 *
+	 * Do not try to move between non smt sched group and smt sched
+	 * group. Let asym active balance properly handle that case.
 	 */
 	if (sds.prefer_sibling && local->group_type == group_has_spare &&
+	    !asymmetric_groups(sds.busiest, sds.local) &&
 	    busiest->sum_nr_running > local->sum_nr_running + 1)
 		goto force_balance;
 
-- 
2.32.0


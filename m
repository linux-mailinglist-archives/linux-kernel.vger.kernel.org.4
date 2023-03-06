Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E006AB6C0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 08:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjCFHE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 02:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjCFHE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 02:04:56 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E41EC5B
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 23:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678086296; x=1709622296;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HiBWe+mJWZoyI7lP9Om4uKfOcDtMjzEydEnd2XZv7rw=;
  b=EpoCwYJzV6pmz8/cg51Kojoh+GlwXPQEcsw2BB4hLUpT1JddRHpgTHju
   gPSNy8VQ0EQtE6OZo1txk2mPI3367zUggTZni56IeNrfOaqxGHt1WVOdB
   WHjMlq3UELzNX7xRdlgr+ORuvK3HiyOnU8tU4ismFqsfz++IO58MAY4Wo
   x8LEInoT82sLVASga0vRcvPbAIAuzulujaOzF8ssyYKs83fc/Bv+bBw6X
   DSGCU1vyrxUHqR+O48z5qvByZImwyWGzabCdoEZrnp4yg6alOcp+VxJm3
   ngRSqwnhv+B4PyAmwKYefWzsHu39hoWNAyD3vmVZzRGSFQHnlCHQ+I4Vc
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="315882209"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="315882209"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 23:04:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="850197278"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="850197278"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 23:04:52 -0800
From:   Zqiang <qiang1.zhang@intel.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        juri.lelli@redhat.com
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, qiang1.zhang@intel.com
Subject: [PATCH] sched/fair: Make hrtimer callback execute in the hard interrupt context
Date:   Mon,  6 Mar 2023 15:09:38 +0800
Message-Id: <20230306070938.3099273-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The scheduler related hrtimers callback will be executed in softirqd
context for PREEMPT_RT enabled kernel, this commit therefore mark
hrtimers as harded even on PREEMPT_RT enabled kernels, there is no
functional change.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/sched/fair.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c36aa54ae071..98c48d144089 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5610,7 +5610,7 @@ static void start_cfs_slack_bandwidth(struct cfs_bandwidth *cfs_b)
 
 	hrtimer_start(&cfs_b->slack_timer,
 			ns_to_ktime(cfs_bandwidth_slack_period),
-			HRTIMER_MODE_REL);
+			HRTIMER_MODE_REL_HARD);
 }
 
 /* we know any runtime found here is valid as update_curr() precedes return */
@@ -5813,9 +5813,9 @@ void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 	cfs_b->burst = 0;
 
 	INIT_LIST_HEAD(&cfs_b->throttled_cfs_rq);
-	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
+	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
 	cfs_b->period_timer.function = sched_cfs_period_timer;
-	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 	cfs_b->slack_timer.function = sched_cfs_slack_timer;
 	cfs_b->slack_started = false;
 }
@@ -5835,7 +5835,7 @@ void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 
 	cfs_b->period_active = 1;
 	hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
-	hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED);
+	hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED_HARD);
 }
 
 static void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
-- 
2.25.1


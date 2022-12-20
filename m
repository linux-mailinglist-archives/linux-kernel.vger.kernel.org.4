Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9CA65221C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233823AbiLTOLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233895AbiLTOLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:11:19 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9621CDEE7;
        Tue, 20 Dec 2022 06:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671545452; x=1703081452;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+CovmIj2Qxzr2m1kZzvu2XhklJ2GFoRQHFoqU6y1iWk=;
  b=Yn8aETjIetu0qqFW59a5eg7JLv3Tf9Tsln8JSQXANy1Ez/bjoIIKbDSf
   QCZn12ZLW3ZD1ThYXVevhc083t+Ew+7kxQghty4MJL2AGlxZIuvmHu/cV
   4vU1Lxnqk1IEvil+sNLpou/UMuywRd8QEDjq1CBQ7LNgCwl9b9ipI4STC
   2xRXr7CFE9JHD2i63ZxLcJEmoHGM2p9Z6wnPJVOY2YB6/f+uH+izC/MS8
   xARQIJCQe+lFg9qsaLndIIPa3RKBfizC0zuCKamHAH6JoG/WgawUmWj4J
   NrFJYs8nkyC9jxrh1+DPWWe5IU9/22QoBnTrXY3H5VkaEilXsxHchMFFQ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="299294511"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="299294511"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 06:10:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="739773833"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="739773833"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 06:10:50 -0800
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: Fix missing TICK_DEP_MASK_RCU_EXP dependency check
Date:   Tue, 20 Dec 2022 22:16:25 +0800
Message-Id: <20221220141625.3612085-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit add TICK_DEP_MASK_RCU_EXP dependency check in
check_tick_dependency(), fix commit df1e849ae4559 ("rcu: Enable
tick for nohz_full CPUs slow to provide expedited QS").

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 include/trace/events/timer.h | 3 ++-
 kernel/time/tick-sched.c     | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/timer.h b/include/trace/events/timer.h
index 2e713a7d9aa3..3e8619c72f77 100644
--- a/include/trace/events/timer.h
+++ b/include/trace/events/timer.h
@@ -371,7 +371,8 @@ TRACE_EVENT(itimer_expire,
 		tick_dep_name(PERF_EVENTS)		\
 		tick_dep_name(SCHED)			\
 		tick_dep_name(CLOCK_UNSTABLE)		\
-		tick_dep_name_end(RCU)
+		tick_dep_name(RCU)			\
+		tick_dep_name_end(RCU_EXP)
 
 #undef tick_dep_name
 #undef tick_dep_mask_name
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index b0e3c9205946..ba2ac1469d47 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -281,6 +281,11 @@ static bool check_tick_dependency(atomic_t *dep)
 		return true;
 	}
 
+	if (val & TICK_DEP_MASK_RCU_EXP) {
+		trace_tick_stop(0, TICK_DEP_MASK_RCU_EXP);
+		return true;
+	}
+
 	return false;
 }
 
-- 
2.25.1


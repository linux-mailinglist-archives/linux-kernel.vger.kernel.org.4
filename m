Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FF770EC5D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 06:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234535AbjEXEIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 00:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbjEXEIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 00:08:44 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740D3C1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 21:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684901323; x=1716437323;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hM5Ww2LUc5QkoUMUIffmMcOj0w8PxPRWz4J23Y6RJ20=;
  b=E5Rtrbp6kguhLNxJlr8+C7o+l6+Z72TIW/TwRs/TGrPwsiecXb6vKhZC
   K19bagBB0g2C9kiATNWcpWnge6RLh/g0SShKpnpovAMulgn6M1EN0OtIF
   8VzkEkqh/U+lCrrYkfR1qHJP4+PiQJiezzbBNs9Gnuv0ovOpkOQjmOW3U
   QkwPuuwBYBLxsJro+YqYg2Li4QimdIH8UFex3OY9abeXHGzG+OfxV9iow
   9CJxlpop2eiK6HnL3CQAfNDAPxrp+bGzUN256nJT5BfurpKDXVziXNN4g
   qN3hlb39UljMs6A2bZQaE0wZBxwGDzZs4NBGD2dmVer57phqpbsQ5Hwiq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="381690562"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="381690562"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 21:04:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="950836756"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="950836756"
Received: from shbuild999.sh.intel.com ([10.239.146.101])
  by fmsmga006.fm.intel.com with ESMTP; 23 May 2023 21:04:24 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Cc:     paulmck@kernel.org, Feng Tang <feng.tang@intel.com>
Subject: [PATCH] clocksource: Add a helper fucntion to reduce code duplication
Date:   Wed, 24 May 2023 12:07:33 +0800
Message-Id: <20230524040733.66946-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several places use the same pattern of 'clocksource_delta() +
clocksource_cyc2ns()' for calcualating the time delta in nanoseconds
from 2 counters read from a clocksource. Add a helper function to
simplify the code.

signe-off-by: Feng Tang <feng.tang@intel.com>
---
 kernel/time/clocksource.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 91836b727cef..9f9e25cf5b44 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -145,6 +145,18 @@ static inline void clocksource_watchdog_unlock(unsigned long *flags)
 	spin_unlock_irqrestore(&watchdog_lock, *flags);
 }
 
+
+/*
+ * Calculate the delta of 2 counters read from a clocksource, and convert
+ * it to nanoseconds. Intended only for short time interval calculation.
+ */
+static inline u64 calc_counters_to_delta_ns(u64 new, u64 old, struct clocksource *cs)
+{
+	u64 delta = clocksource_delta(new, old, cs->mask);
+
+	return clocksource_cyc2ns(delta, cs->mult, cs->shift);
+}
+
 static int clocksource_watchdog_kthread(void *data);
 static void __clocksource_change_rating(struct clocksource *cs, int rating);
 
@@ -223,7 +235,7 @@ enum wd_read_status {
 static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow, u64 *wdnow)
 {
 	unsigned int nretries;
-	u64 wd_end, wd_end2, wd_delta;
+	u64 wd_end, wd_end2;
 	int64_t wd_delay, wd_seq_delay;
 
 	for (nretries = 0; nretries <= max_cswd_read_retries; nretries++) {
@@ -234,9 +246,7 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
 		wd_end2 = watchdog->read(watchdog);
 		local_irq_enable();
 
-		wd_delta = clocksource_delta(wd_end, *wdnow, watchdog->mask);
-		wd_delay = clocksource_cyc2ns(wd_delta, watchdog->mult,
-					      watchdog->shift);
+		wd_delay = calc_counters_to_delta_ns(wd_end, *wdnow, watchdog);
 		if (wd_delay <= WATCHDOG_MAX_SKEW) {
 			if (nretries > 1 || nretries >= max_cswd_read_retries) {
 				pr_warn("timekeeping watchdog on CPU%d: %s retried %d times before success\n",
@@ -254,8 +264,8 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
 		 * report system busy, reinit the watchdog and skip the current
 		 * watchdog test.
 		 */
-		wd_delta = clocksource_delta(wd_end2, wd_end, watchdog->mask);
-		wd_seq_delay = clocksource_cyc2ns(wd_delta, watchdog->mult, watchdog->shift);
+
+		wd_seq_delay = calc_counters_to_delta_ns(wd_end2, wd_end, watchdog);
 		if (wd_seq_delay > WATCHDOG_MAX_SKEW/2)
 			goto skip_test;
 	}
@@ -366,8 +376,8 @@ void clocksource_verify_percpu(struct clocksource *cs)
 		delta = (csnow_end - csnow_mid) & cs->mask;
 		if (delta < 0)
 			cpumask_set_cpu(cpu, &cpus_ahead);
-		delta = clocksource_delta(csnow_end, csnow_begin, cs->mask);
-		cs_nsec = clocksource_cyc2ns(delta, cs->mult, cs->shift);
+
+		cs_nsec = calc_counters_to_delta_ns(csnow_end, csnow_begin, cs);
 		if (cs_nsec > cs_nsec_max)
 			cs_nsec_max = cs_nsec;
 		if (cs_nsec < cs_nsec_min)
@@ -398,7 +408,7 @@ static inline void clocksource_reset_watchdog(void)
 
 static void clocksource_watchdog(struct timer_list *unused)
 {
-	u64 csnow, wdnow, cslast, wdlast, delta;
+	u64 csnow, wdnow, cslast, wdlast;
 	int next_cpu, reset_pending;
 	int64_t wd_nsec, cs_nsec;
 	struct clocksource *cs;
@@ -456,14 +466,10 @@ static void clocksource_watchdog(struct timer_list *unused)
 			continue;
 		}
 
-		delta = clocksource_delta(wdnow, cs->wd_last, watchdog->mask);
-		wd_nsec = clocksource_cyc2ns(delta, watchdog->mult,
-					     watchdog->shift);
-
-		delta = clocksource_delta(csnow, cs->cs_last, cs->mask);
-		cs_nsec = clocksource_cyc2ns(delta, cs->mult, cs->shift);
 		wdlast = cs->wd_last; /* save these in case we print them */
 		cslast = cs->cs_last;
+		wd_nsec = calc_counters_to_delta_ns(wdnow, wdlast, watchdog);
+		cs_nsec = calc_counters_to_delta_ns(csnow, cslast, cs);
 		cs->cs_last = csnow;
 		cs->wd_last = wdnow;
 
-- 
2.27.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F26D6784E4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 19:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjAWS3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 13:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbjAWS3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 13:29:40 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC18D504
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 10:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674498558; x=1706034558;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JuOqPB3b9j39khhHERV2tl4VPEWAjvZVB/vliTmGgeo=;
  b=a+XwckuhDqdd1U61mlLqBb9D330VUgNCl3lTy8THdJgYiQ1cb3uP7wTt
   OtshmA5xpB42X+AKEep/qaVf2ZDeg9ADOUnL68yeb4camjpSA3+/2NWkH
   wdnWbEneK2W+SSsJWBRseDC+lcgl9IszwicXr6tlFMYYyp1h2kEa9TtsJ
   NB4GnHLriTnTI7t6nWHjk5Iul0+NKDaJbQvDsbqxex549EKeoymiOyUNT
   GdlVxn29OGlUGWY0qDFexIXQukEwM5PlfkP4fcNDMOAe6OgHsNyvQ4jO8
   pI3ymo3s979jM6L99NRioLv/a401yS9kaMCX2c5coHEmVxBxHgEPkR35N
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="328201782"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="328201782"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 10:27:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="661812073"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="661812073"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga002.jf.intel.com with ESMTP; 23 Jan 2023 10:27:42 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        jstultz@google.com, sboyd@kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, namhyung@kernel.org, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 1/3] timekeeping: NMI safe converter from a given time to monotonic
Date:   Mon, 23 Jan 2023 10:27:26 -0800
Message-Id: <20230123182728.825519-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230123182728.825519-1-kan.liang@linux.intel.com>
References: <20230123182728.825519-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

It's useful to provide a NMI safe function to convert a given time to
monotonic. For example, the perf_event subsystem wants to convert a TSC
of a PEBS record to a monotonic clock in a NMI handler.

Considered the below two existing functions, but none of them fulfill
the above requirements.
- The ktime_get_mono_fast_ns() is NMI safe, but it can only return the
  current clock monotonic rather than a given time's monotonic.
- The get_device_system_crosststamp() can calculate the system time from
  a given device time. But it's not fast and NMI safe.

The new function is a combination of the two existing functions. Use the
tk_fast_mono timekeeper to make the new function fast and NMI safe. Use
the get_time_fn callback to retrieve the given timestamp and its
clocksource. The history is not supported, since the perf case doesn't
really need it. It can be added later once there is a use case.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 include/linux/timekeeping.h |  9 +++++
 kernel/time/timekeeping.c   | 68 +++++++++++++++++++++++++++++++++++--
 2 files changed, 74 insertions(+), 3 deletions(-)

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index fe1e467ba046..234fa87a846b 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -289,6 +289,15 @@ extern int get_device_system_crosststamp(
 			struct system_time_snapshot *history,
 			struct system_device_crosststamp *xtstamp);
 
+/*
+ * Fast NMI safe way to convert a given timestamp to clock monotonic
+ */
+extern int get_mono_fast_from_given_time(int (*get_time_fn)
+					      (struct system_counterval_t *sys_counterval,
+					      void *ctx),
+					 void *ctx,
+					 u64 *mono_ns);
+
 /*
  * Simultaneously snapshot realtime and monotonic raw clocks
  */
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 5579ead449f2..5bd32b2981fd 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -431,14 +431,19 @@ static void update_fast_timekeeper(const struct tk_read_base *tkr,
 	memcpy(base + 1, base, sizeof(*base));
 }
 
-static __always_inline u64 fast_tk_get_delta_ns(struct tk_read_base *tkr)
+static __always_inline u64 fast_tk_get_delta_ns_from_cycles(struct tk_read_base *tkr,
+							    u64 cycles)
 {
-	u64 delta, cycles = tk_clock_read(tkr);
+	u64 delta = clocksource_delta(cycles, tkr->cycle_last, tkr->mask);
 
-	delta = clocksource_delta(cycles, tkr->cycle_last, tkr->mask);
 	return timekeeping_delta_to_ns(tkr, delta);
 }
 
+static __always_inline u64 fast_tk_get_delta_ns(struct tk_read_base *tkr)
+{
+	return fast_tk_get_delta_ns_from_cycles(tkr, tk_clock_read(tkr));
+}
+
 static __always_inline u64 __ktime_get_fast_ns(struct tk_fast *tkf)
 {
 	struct tk_read_base *tkr;
@@ -1303,6 +1308,63 @@ int get_device_system_crosststamp(int (*get_time_fn)
 }
 EXPORT_SYMBOL_GPL(get_device_system_crosststamp);
 
+/**
+ * get_mono_fast_from_given_time - Fast NMI safe access to convert a given
+ *				    timestamp to clock monotonic
+ * @get_time_fn:	Callback to get the given time and its clocksource
+ * @ctx:		Context passed to get_time_fn()
+ * @mono_ns:		The monotonic time of the given time
+ */
+int notrace get_mono_fast_from_given_time(int (*get_time_fn)
+						(struct system_counterval_t *sys_counterval,
+						void *ctx),
+					  void *ctx,
+					  u64 *mono_ns)
+{
+	struct system_counterval_t system_counterval;
+	struct tk_fast *tkf = &tk_fast_mono;
+	u64 cycles, now, interval_start;
+	struct tk_read_base *tkr;
+	unsigned int seq;
+	int ret;
+
+	do {
+		seq = raw_read_seqcount_latch(&tkf->seq);
+		tkr = tkf->base + (seq & 0x01);
+
+		ret = get_time_fn(&system_counterval, ctx);
+		if (ret)
+			return ret;
+
+		/*
+		 * Verify that the clocksource associated with the given
+		 * timestamp is the same as the currently installed
+		 * timekeeper clocksource
+		 */
+		if (tkr->clock != system_counterval.cs)
+			return -EOPNOTSUPP;
+		cycles = system_counterval.cycles;
+
+		/*
+		 * Check whether the given timestamp is on the current
+		 * timekeeping interval.
+		 */
+		now = tk_clock_read(tkr);
+		interval_start = tkr->cycle_last;
+		if (!cycle_between(interval_start, cycles, now))
+			return -EOPNOTSUPP;
+
+		now = ktime_to_ns(tkr->base);
+		now += fast_tk_get_delta_ns_from_cycles(tkr, cycles);
+
+	} while (read_seqcount_latch_retry(&tkf->seq, seq));
+
+	*mono_ns = now;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(get_mono_fast_from_given_time);
+
 /**
  * do_settimeofday64 - Sets the time of day.
  * @ts:     pointer to the timespec64 variable containing the new time
-- 
2.35.1


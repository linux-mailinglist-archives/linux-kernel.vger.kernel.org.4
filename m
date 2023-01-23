Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F906784EA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 19:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbjAWSap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 13:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbjAWSa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 13:30:26 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AA332E57
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 10:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674498598; x=1706034598;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ReP9kpyfBFbBhxCpPh596y2tC02v63s7zvaRoytHorM=;
  b=gkEa+JMG+7hyphJjnZF7brly+EIcgVpWc4pfqvqvpET1vqLbItOHDqjC
   zprKyv6ghy0Hx2+Z+2vy4yUrp9ZKMdWBMENZgMEizcqpJoXMKtmVq1biA
   w8qS5IX6OZi+xNFsweVshSvAmm4o1IlJ8Ej9RRU9jbOR1bQ+Ly8NzLOuC
   kRJn6hXYxUJv+alDQtmQFt6oIwTmdgf2iQJwx5R0cdn/ezvp9qo332BW5
   P+AappiZgn5DL+FRcGA4mSPr2+Y8pyBvwqf4c+Kqk1TQ2sqwdSJ2eE7f8
   Fya9hgxY/SFOSrvT42cID649Nkwh4zirOzkAeDFy69enEvjJBs915TgHG
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="328201807"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="328201807"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 10:27:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="661812076"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="661812076"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga002.jf.intel.com with ESMTP; 23 Jan 2023 10:27:43 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        jstultz@google.com, sboyd@kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, namhyung@kernel.org, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 3/3] perf/x86/intel/ds: Support monotonic clock for PEBS
Date:   Mon, 23 Jan 2023 10:27:28 -0800
Message-Id: <20230123182728.825519-4-kan.liang@linux.intel.com>
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

Users try to reconcile user samples with PEBS samples and require a
common clock source. However, the current PEBS codes only convert to
sched_clock, which is not available from the user space.

Only support converting to clock monotonic. Having one common clock
source is good enough to fulfill the requirement.

Enable the large PEBS for the monotonic clock to reduce the PEBS
overhead.

There are a few rare cases that may make the conversion fails. For
example, TSC overflows. The cycle_last may be changed between samples.
The time will fallback to the inaccurate SW times. But the cases are
extremely unlikely to happen.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

The patch has to be on top of the below patch
https://lore.kernel.org/all/20230123172027.125385-1-kan.liang@linux.intel.com/

 arch/x86/events/intel/core.c |  2 +-
 arch/x86/events/intel/ds.c   | 30 ++++++++++++++++++++++++++----
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 14f0a746257d..ea194556cc73 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3777,7 +3777,7 @@ static unsigned long intel_pmu_large_pebs_flags(struct perf_event *event)
 {
 	unsigned long flags = x86_pmu.large_pebs_flags;
 
-	if (event->attr.use_clockid)
+	if (event->attr.use_clockid && (event->attr.clockid != CLOCK_MONOTONIC))
 		flags &= ~PERF_SAMPLE_TIME;
 	if (!event->attr.exclude_kernel)
 		flags &= ~PERF_SAMPLE_REGS_USER;
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 7980e92dec64..d7f0eaf4405c 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1570,13 +1570,33 @@ static u64 get_data_src(struct perf_event *event, u64 aux)
 	return val;
 }
 
+static int pebs_get_synctime(struct system_counterval_t *system,
+			     void *ctx)
+{
+	*system = set_tsc_system_counterval(*(u64 *)ctx);
+	return 0;
+}
+
+static inline int pebs_clockid_time(clockid_t clk_id, u64 tsc, u64 *clk_id_time)
+{
+	/* Only support converting to clock monotonic */
+	if (clk_id != CLOCK_MONOTONIC)
+		return -EINVAL;
+
+	return get_mono_fast_from_given_time(pebs_get_synctime, &tsc, clk_id_time);
+}
+
 static void setup_pebs_time(struct perf_event *event,
 			    struct perf_sample_data *data,
 			    u64 tsc)
 {
-	/* Converting to a user-defined clock is not supported yet. */
-	if (event->attr.use_clockid != 0)
-		return;
+	u64 time;
+
+	if (event->attr.use_clockid != 0) {
+		if (pebs_clockid_time(event->attr.clockid, tsc, &time))
+			return;
+		goto done;
+	}
 
 	/*
 	 * Converting the TSC to perf time is only supported,
@@ -1587,8 +1607,10 @@ static void setup_pebs_time(struct perf_event *event,
 	 */
 	if (!using_native_sched_clock() || !sched_clock_stable())
 		return;
+	time = native_sched_clock_from_tsc(tsc) + __sched_clock_offset;
 
-	data->time = native_sched_clock_from_tsc(tsc) + __sched_clock_offset;
+done:
+	data->time = time;
 	data->sample_flags |= PERF_SAMPLE_TIME;
 }
 
-- 
2.35.1


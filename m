Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D719695067
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjBMTI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjBMTIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:08:14 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FE712F26
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676315289; x=1707851289;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MsZexMlSjxnKR+I1ycQ9RqJ26PCvPIyRW1Mj53H7MC4=;
  b=PIESye95aYFhcKpERBIKzGflt8OP70tCxvDAgmPOq7yseNcaxR5/AK1s
   qjtlvwRZiU5hBGSXaOwgANi/9Z6WqBXXrVZ67dxvlPsFD1oneMjOFPJrS
   gK5l5cOdvQi9wOGGLK1lbAPX20UBGXEKFaxo2z1Ny8S2RUnGrfro3ugAp
   TP7bC3mSOc4cLs7lcefGviVBAumyQYFocp1eXCmAdvKA8k36JorvZ0GDX
   0pvPA1hS5nCTdeH+UdlKFqKriW5XLGD3qE/7gsnPEiUVQC9nQc4qemA35
   ZlYRyFuFMFbDR4tUfLbcfRiLJOCrg6ItdpoAwi8sIj2rxscfuKFDsPIz1
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="333108781"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="333108781"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 11:08:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="668901959"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="668901959"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga002.jf.intel.com with ESMTP; 13 Feb 2023 11:08:08 -0800
From:   kan.liang@linux.intel.com
To:     tglx@linutronix.de, jstultz@google.com, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     sboyd@kernel.org, eranian@google.com, namhyung@kernel.org,
        ak@linux.intel.com, adrian.hunter@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [RFC PATCH V2 7/9] perf session: Support the monotonic raw clock conversion information
Date:   Mon, 13 Feb 2023 11:07:52 -0800
Message-Id: <20230213190754.1836051-8-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230213190754.1836051-1-kan.liang@linux.intel.com>
References: <20230213190754.1836051-1-kan.liang@linux.intel.com>
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

The monotonic raw clock conversion information can be retrieved from
the perf_event_mmap_page::cap_user_time_mono_raw ABI. Store the
information in the struct perf_record_time_conv for later usage.
Dump the information in TIME_CONV event as well.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/lib/perf/include/perf/event.h |  8 +++++++-
 tools/perf/util/session.c           |  8 ++++++++
 tools/perf/util/tsc.c               | 22 +++++++++++++++++++++-
 tools/perf/util/tsc.h               |  6 ++++++
 4 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index ad47d7b31046..20187a3d84c8 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -422,9 +422,15 @@ struct perf_record_time_conv {
 	__u64			 time_zero;
 	__u64			 time_cycles;
 	__u64			 time_mask;
+	__u64			 time_mono_last;
+	__u32			 time_mono_mult;
+	__u32			 time_mono_shift;
+	__u64			 time_mono_nsec;
+	__u64			 time_mono_base;
 	__u8			 cap_user_time_zero;
 	__u8			 cap_user_time_short;
-	__u8			 reserved[6];	/* For alignment */
+	__u8			 cap_user_time_mono_raw;
+	__u8			 reserved[5];	/* For alignment */
 };
 
 struct perf_record_header_feature {
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 7c021c6cedb9..189149a7012f 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -995,6 +995,14 @@ static void perf_event__time_conv_swap(union perf_event *event,
 		event->time_conv.time_cycles = bswap_64(event->time_conv.time_cycles);
 		event->time_conv.time_mask = bswap_64(event->time_conv.time_mask);
 	}
+
+	if (event_contains(event->time_conv, time_mono_last)) {
+		event->time_conv.time_mono_last = bswap_64(event->time_conv.time_mono_last);
+		event->time_conv.time_mono_mult = bswap_32(event->time_conv.time_mono_mult);
+		event->time_conv.time_mono_shift = bswap_32(event->time_conv.time_mono_shift);
+		event->time_conv.time_mono_nsec = bswap_64(event->time_conv.time_mono_nsec);
+		event->time_conv.time_mono_base = bswap_64(event->time_conv.time_mono_base);
+	}
 }
 
 typedef void (*perf_event__swap_op)(union perf_event *event,
diff --git a/tools/perf/util/tsc.c b/tools/perf/util/tsc.c
index f19791d46e99..0b59c0f815f9 100644
--- a/tools/perf/util/tsc.c
+++ b/tools/perf/util/tsc.c
@@ -54,8 +54,14 @@ int perf_read_tsc_conversion(const struct perf_event_mmap_page *pc,
 		tc->time_zero = pc->time_zero;
 		tc->time_cycles = pc->time_cycles;
 		tc->time_mask = pc->time_mask;
+		tc->time_mono_last = pc->time_mono_last;
+		tc->time_mono_mult = pc->time_mono_mult;
+		tc->time_mono_shift = pc->time_mono_shift;
+		tc->time_mono_nsec = pc->time_mono_nsec;
+		tc->time_mono_base = pc->time_mono_base;
 		tc->cap_user_time_zero = pc->cap_user_time_zero;
 		tc->cap_user_time_short	= pc->cap_user_time_short;
+		tc->cap_user_time_mono_raw = pc->cap_user_time_mono_raw;
 		rmb();
 		if (pc->lock == seq && !(seq & 1))
 			break;
@@ -65,7 +71,7 @@ int perf_read_tsc_conversion(const struct perf_event_mmap_page *pc,
 		}
 	}
 
-	if (!tc->cap_user_time_zero)
+	if (!tc->cap_user_time_zero && !tc->cap_user_time_mono_raw)
 		return -EOPNOTSUPP;
 
 	return 0;
@@ -102,8 +108,14 @@ int perf_event__synth_time_conv(const struct perf_event_mmap_page *pc,
 	event.time_conv.time_zero  = tc.time_zero;
 	event.time_conv.time_cycles = tc.time_cycles;
 	event.time_conv.time_mask = tc.time_mask;
+	event.time_conv.time_mono_last = tc.time_mono_last;
+	event.time_conv.time_mono_mult = tc.time_mono_mult;
+	event.time_conv.time_mono_shift = tc.time_mono_shift;
+	event.time_conv.time_mono_nsec = tc.time_mono_nsec;
+	event.time_conv.time_mono_base = tc.time_mono_base;
 	event.time_conv.cap_user_time_zero = tc.cap_user_time_zero;
 	event.time_conv.cap_user_time_short = tc.cap_user_time_short;
+	event.time_conv.cap_user_time_mono_raw = tc.cap_user_time_mono_raw;
 
 	return process(tool, &event, NULL, machine);
 }
@@ -138,5 +150,13 @@ size_t perf_event__fprintf_time_conv(union perf_event *event, FILE *fp)
 			       tc->cap_user_time_short);
 	}
 
+	ret += fprintf(fp, "... Cap Time Monotonic Raw  %" PRId32 "\n",
+		       tc->cap_user_time_mono_raw);
+	ret += fprintf(fp, "... Time Last       %" PRI_lu64 "\n", tc->time_mono_last);
+	ret += fprintf(fp, "... Time Multiplier %" PRId32 "\n", tc->time_mono_mult);
+	ret += fprintf(fp, "... Time Shift      %" PRId32 "\n", tc->time_mono_shift);
+	ret += fprintf(fp, "... Time Nsec       %" PRI_lu64 "\n", tc->time_mono_nsec);
+	ret += fprintf(fp, "... Time Base       %" PRI_lu64 "\n", tc->time_mono_base);
+
 	return ret;
 }
diff --git a/tools/perf/util/tsc.h b/tools/perf/util/tsc.h
index 88fd1c4c1cb8..6bacc450a14d 100644
--- a/tools/perf/util/tsc.h
+++ b/tools/perf/util/tsc.h
@@ -12,9 +12,15 @@ struct perf_tsc_conversion {
 	u64 time_zero;
 	u64 time_cycles;
 	u64 time_mask;
+	u64 time_mono_last;
+	u32 time_mono_mult;
+	u32 time_mono_shift;
+	u64 time_mono_nsec;
+	u64 time_mono_base;
 
 	bool cap_user_time_zero;
 	bool cap_user_time_short;
+	bool cap_user_time_mono_raw;
 };
 
 struct perf_event_mmap_page;
-- 
2.35.1


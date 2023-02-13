Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA28E695062
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjBMTIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjBMTH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:07:59 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14940CA1A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676315279; x=1707851279;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9lgoINWxU1sPPhF4j2mJcGx7Hoa3TJdaZRev5+44tes=;
  b=g2KxmUMVoIAHC1Crf3KbXVJOTw+tVN+7qO9huGhP9xjmfV1EuHY2esDs
   pTb5e5iKbXCiYdu4t29T65YaqNAdPf1l/YqGS0jhDMWB2/kRwOwOtMxAe
   sCLOFLlqTaRHSvuM+u+isJPB9xKuqVMVWEI0HFATCuXFTGIY9A+TeqRTi
   FYQvy2GxzNhq4y92D0GJWpUK0QP2FGTwfiLmJLie0lk+nCT+2SNQAaSEM
   uqC71kQ2y/A2qxb1lz/2jFIOjKtXJFEqtoU8Op510wiDc/76AluopGltm
   eHltr98S0PkhS7ON50ZI1GDrSyZr7Lsv2KAmEXbXP/qHCoIa/jOpiecFK
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="333108696"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="333108696"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 11:07:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="668901920"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="668901920"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga002.jf.intel.com with ESMTP; 13 Feb 2023 11:07:58 -0800
From:   kan.liang@linux.intel.com
To:     tglx@linutronix.de, jstultz@google.com, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     sboyd@kernel.org, eranian@google.com, namhyung@kernel.org,
        ak@linux.intel.com, adrian.hunter@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [RFC PATCH V2 2/9] perf: Extend ABI to support post-processing monotonic raw conversion
Date:   Mon, 13 Feb 2023 11:07:47 -0800
Message-Id: <20230213190754.1836051-3-kan.liang@linux.intel.com>
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

The monotonic raw clock is not affected by NTP/PTP correction. The
calculation of the monotonic raw clock can be done in the
post-processing, which can reduce the kernel overhead.

Add hw_time in the struct perf_event_attr to tell the kernel dump the
raw HW time to user space. The perf tool will calculate the HW time
in post-processing.
Currently, only supports the monotonic raw conversion.
Only dump the raw HW time with PERF_RECORD_SAMPLE, because the accurate
HW time can only be provided in a sample by HW. For other type of
records, the user requested clock should be returned as usual. Nothing
is changed.

Add perf_event_mmap_page::cap_user_time_mono_raw ABI to dump the
conversion information. The cap_user_time_mono_raw also indicates
whether the monotonic raw conversion information is available.
If yes, the clock monotonic raw can be calculated as
mono_raw = base + ((cyc - last) * mult + nsec) >> shift

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 include/uapi/linux/perf_event.h | 21 ++++++++++++++++++---
 kernel/events/core.c            |  7 +++++++
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index ccb7f5dad59b..9d56fe027f6c 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -455,7 +455,8 @@ struct perf_event_attr {
 				inherit_thread :  1, /* children only inherit if cloned with CLONE_THREAD */
 				remove_on_exec :  1, /* event is removed from task on exec */
 				sigtrap        :  1, /* send synchronous SIGTRAP on event */
-				__reserved_1   : 26;
+				hw_time        :  1, /* generate raw HW time for samples */
+				__reserved_1   : 25;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
@@ -615,7 +616,8 @@ struct perf_event_mmap_page {
 				cap_user_time		: 1, /* The time_{shift,mult,offset} fields are used */
 				cap_user_time_zero	: 1, /* The time_zero field is used */
 				cap_user_time_short	: 1, /* the time_{cycle,mask} fields are used */
-				cap_____res		: 58;
+				cap_user_time_mono_raw  : 1, /* The time_mono_* fields are used */
+				cap_____res		: 57;
 		};
 	};
 
@@ -692,11 +694,24 @@ struct perf_event_mmap_page {
 	__u64	time_cycles;
 	__u64	time_mask;
 
+	/*
+	 * If cap_user_time_mono_raw, the monotonic raw clock can be calculated
+	 * from the hardware clock (e.g. TSC) 'cyc'.
+	 *
+	 * mono_raw = base + ((cyc - last) * mult + nsec) >> shift
+	 *
+	 */
+	__u64	time_mono_last;
+	__u32	time_mono_mult;
+	__u32	time_mono_shift;
+	__u64	time_mono_nsec;
+	__u64	time_mono_base;
+
 		/*
 		 * Hole for extension of the self monitor capabilities
 		 */
 
-	__u8	__reserved[116*8];	/* align to 1k. */
+	__u8	__reserved[112*8];	/* align to 1k. */
 
 	/*
 	 * Control data for the mmap() data buffer.
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 380476a934e8..f062cce2dafc 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12135,6 +12135,13 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
 	if (attr->sigtrap && !attr->remove_on_exec)
 		return -EINVAL;
 
+	if (attr->use_clockid) {
+		/*
+		 * Only support post-processing for the monotonic raw clock
+		 */
+		if (attr->hw_time && (attr->clockid != CLOCK_MONOTONIC_RAW))
+			return -EINVAL;
+	}
 out:
 	return ret;
 
-- 
2.35.1


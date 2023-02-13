Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B3F695066
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjBMTIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjBMTIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:08:11 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB6C21A19
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676315288; x=1707851288;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ew5LHI5pCmCiUBMVzv2I8reY5qJGqW8V/hL9T+aryPM=;
  b=BBHEk5HPSfq9c+Jm60Gw/Ydm8f+79enTtISNBSd06JVpinuHb76jKCHo
   UPRQyFK8SgT0dx/ftqXrun8CVXP3Y1NLv78GP6/G2LoLQNJpuKYDfQut8
   bl4mC2XW09kR/sMVLrh/0zt951Gd5bh2S35MWTjZ6x4Mknp7Jp+5lO488
   Eig/p0xUMwbZ9c4DsSAIDMKcg4gr4eHtLucB7jlO0ZNyCSvWdmjUKZY2k
   7FzvN/GBjyhRwLDAKHLIMTyYO9lilwQMK3Rzhd5DT64fLDmZ0wPvuzkBD
   oKJTpEU+muyIEOsVb/NIV2WrWt8roRcox/ofsU64xFg/LrzR+vmUhOImz
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="333108766"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="333108766"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 11:08:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="668901955"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="668901955"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga002.jf.intel.com with ESMTP; 13 Feb 2023 11:08:07 -0800
From:   kan.liang@linux.intel.com
To:     tglx@linutronix.de, jstultz@google.com, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     sboyd@kernel.org, eranian@google.com, namhyung@kernel.org,
        ak@linux.intel.com, adrian.hunter@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [RFC PATCH V2 6/9] tools headers UAPI: Sync linux/perf_event.h with the kernel sources
Date:   Mon, 13 Feb 2023 11:07:51 -0800
Message-Id: <20230213190754.1836051-7-kan.liang@linux.intel.com>
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

The kernel ABI has been extended to support tool based monotonic raw
conversion.

This thus partially addresses this perf build warning:

Warning: Kernel ABI header at 'tools/include/uapi/linux/perf_event.h'
differs from latest version at 'include/uapi/linux/perf_event.h'
diff -u tools/include/uapi/linux/perf_event.h include/uapi/linux/perf_event.h

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/include/uapi/linux/perf_event.h | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index ccb7f5dad59b..9d56fe027f6c 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
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
-- 
2.35.1


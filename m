Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6F8695060
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjBMTIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjBMTH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:07:59 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE21FBB9C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676315277; x=1707851277;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nthHD7ORD3zn2LmHh/lLY5cOKkIBSk15uJqRpUpGiOc=;
  b=U9RvRuLY9cvI44iibSx2NrKWux7oU5di7PofNUO+4kj0Yh0QNlaLvH6V
   q/nTnE7+Upz+4CB9ADJWNi/rOVK6xkTj3gRHyHkG5k4zLWbP2cpysPzLs
   mYY9cI6nxGGvFTcoacLNmFHfGzsIazk5GVg5VlCqhqfUi5RZjfuPB4zjN
   G5Y0RC4xucxVYyRIcTnK0eN4Akdmd7tGJK1CjWu/FqNyyE0iMQqOE1Gmc
   IbLHc2PSYZ8Tl0vrrlD+H+r3xBb0KolHc3O8hxW3E+tAFukKqViU2p4H4
   mTZIXCwtSfFXit11r9yvYHdd7ovArQU7Te4W9R4X8dDC3V41lU36PgZG5
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="333108679"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="333108679"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 11:07:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="668901912"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="668901912"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga002.jf.intel.com with ESMTP; 13 Feb 2023 11:07:57 -0800
From:   kan.liang@linux.intel.com
To:     tglx@linutronix.de, jstultz@google.com, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     sboyd@kernel.org, eranian@google.com, namhyung@kernel.org,
        ak@linux.intel.com, adrian.hunter@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [RFC PATCH V2 1/9] timekeeping: Expose the conversion information of monotonic raw
Date:   Mon, 13 Feb 2023 11:07:46 -0800
Message-Id: <20230213190754.1836051-2-kan.liang@linux.intel.com>
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

The conversion information of monotonic raw is not affected by NTP/PTP
correction. The perf tool can utilize the information to correctly
calculate the monotonic raw via a TSC in each PEBS record in the
post-processing stage.

The current conversion information is hidden in the internal
struct tk_read_base. Add a new external struct ktime_conv to store and
share the conversion information with other subsystems.

Add a new interface ktime_get_fast_mono_raw_conv() to expose the
conversion information of monotonic raw.  The function probably be
invoked in a NMI. Use NMI safe tk_fast_raw to retrieve the conversion
information.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 include/linux/timekeeping.h | 18 ++++++++++++++++++
 kernel/time/timekeeping.c   | 24 ++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index fe1e467ba046..94ba02e7eb13 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -253,6 +253,21 @@ struct system_time_snapshot {
 	u8			cs_was_changed_seq;
 };
 
+/**
+ * struct ktime_conv - Timestamp conversion information
+ * @mult:	Multiplier for scaled math conversion
+ * @shift:	Shift value for scaled math conversion
+ * @xtime_nsec: Shifted (fractional) nano seconds offset for readout
+ * @base:	(nanoseconds) base time for readout
+ */
+struct ktime_conv {
+	u64			cycle_last;
+	u32			mult;
+	u32			shift;
+	u64			xtime_nsec;
+	u64			base;
+};
+
 /**
  * struct system_device_crosststamp - system/device cross-timestamp
  *				      (synchronized capture)
@@ -297,6 +312,9 @@ extern void ktime_get_snapshot(struct system_time_snapshot *systime_snapshot);
 /* NMI safe mono/boot/realtime timestamps */
 extern void ktime_get_fast_timestamps(struct ktime_timestamps *snap);
 
+/* NMI safe mono raw conv information */
+extern void ktime_get_fast_mono_raw_conv(struct ktime_conv *conv);
+
 /*
  * Persistent clock related interfaces
  */
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 5579ead449f2..a202b7a0a249 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -505,6 +505,30 @@ u64 notrace ktime_get_raw_fast_ns(void)
 }
 EXPORT_SYMBOL_GPL(ktime_get_raw_fast_ns);
 
+/**
+ * ktime_get_fast_mono_raw_conv - NMI safe access to get the conversion
+ *				  information of clock monotonic raw
+ *
+ * The conversion information is not affected by NTP/PTP correction.
+ */
+void ktime_get_fast_mono_raw_conv(struct ktime_conv *conv)
+{
+	struct tk_fast *tkf = &tk_fast_raw;
+	struct tk_read_base *tkr;
+	unsigned int seq;
+
+	do {
+		seq = raw_read_seqcount_latch(&tkf->seq);
+		tkr = tkf->base + (seq & 0x01);
+		conv->cycle_last = tkr->cycle_last;
+		conv->mult = tkr->mult;
+		conv->shift = tkr->shift;
+		conv->xtime_nsec = tkr->xtime_nsec;
+		conv->base = tkr->base;
+	} while (read_seqcount_latch_retry(&tkf->seq, seq));
+}
+EXPORT_SYMBOL_GPL(ktime_get_fast_mono_raw_conv);
+
 /**
  * ktime_get_boot_fast_ns - NMI safe and fast access to boot clock.
  *
-- 
2.35.1


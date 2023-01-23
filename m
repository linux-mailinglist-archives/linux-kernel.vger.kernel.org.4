Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D851F6784E8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 19:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbjAWSaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 13:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233779AbjAWS36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 13:29:58 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2278C32505
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 10:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674498580; x=1706034580;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GZL6mJd0i/S3LDHYVmccNX0nbILU1PkbcQaWVCINBiI=;
  b=O+A/WkcN5NEe5ldFwySfx/NTAlM7baocoTTsoe/Mb1HAtMqsUMyJJRR4
   tcC+n5q6J5B6VZ95SktEIMzDetvGf+11a6xeIYMj7DYFABajg3uD6ThRu
   2UZGB0/9v+EwjrRPQF9THQNk7WCHRHQf2GKNattzY8/qRcicEugld07T4
   6EG24kruXpBR6R8S1HFcgL+G3xrVAak1nMPKZES5s5/0TggMav+OBvAoD
   RMVx5TeXoE6OVKqH0J9zNMksb0IqVD47OPBuR392Rs+k0i7+vyxLksKmp
   H+Xpao3yQVt1AozvCIqLZq5u6T2QMNFc2JMPNRmx0qmTGw3m+eTzbKohO
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="328201788"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="328201788"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 10:27:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="661812074"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="661812074"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga002.jf.intel.com with ESMTP; 23 Jan 2023 10:27:42 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        jstultz@google.com, sboyd@kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, namhyung@kernel.org, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 2/3] x86/tsc: Add set_tsc_system_counterval
Date:   Mon, 23 Jan 2023 10:27:27 -0800
Message-Id: <20230123182728.825519-3-kan.liang@linux.intel.com>
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

The perf_event subsystem wants to convert a TSC of a PEBS record to a
monotonic clock. Introduce a new function to provide both the TSC
value and TSC clocksource information with the format required by the
callback function from the timekeeping code.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/include/asm/tsc.h | 1 +
 arch/x86/kernel/tsc.c      | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index fbdc3d951494..45aac88b5ce4 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -29,6 +29,7 @@ static inline cycles_t get_cycles(void)
 
 extern struct system_counterval_t convert_art_to_tsc(u64 art);
 extern struct system_counterval_t convert_art_ns_to_tsc(u64 art_ns);
+extern struct system_counterval_t set_tsc_system_counterval(u64 tsc);
 
 extern void tsc_early_init(void);
 extern void tsc_init(void);
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index a78e73da4a74..45803e65630e 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1311,6 +1311,12 @@ struct system_counterval_t convert_art_ns_to_tsc(u64 art_ns)
 }
 EXPORT_SYMBOL(convert_art_ns_to_tsc);
 
+struct system_counterval_t set_tsc_system_counterval(u64 tsc)
+{
+	return (struct system_counterval_t) { .cs = &clocksource_tsc,
+					      .cycles = tsc};
+}
+EXPORT_SYMBOL(set_tsc_system_counterval);
 
 static void tsc_refine_calibration_work(struct work_struct *work);
 static DECLARE_DELAYED_WORK(tsc_irqwork, tsc_refine_calibration_work);
-- 
2.35.1


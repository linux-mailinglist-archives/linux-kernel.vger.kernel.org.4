Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A644F6FDEA3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236640AbjEJNdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjEJNdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:33:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC1E61B2;
        Wed, 10 May 2023 06:33:42 -0700 (PDT)
Date:   Wed, 10 May 2023 13:33:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683725620;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=53DYRyYgi1d1SjVMdlxHIf2xem2K/RBtXiqOJgn1bv0=;
        b=Ao06wyF1H3m/nDUz7I5nK/6Q9C7KAUYnZcS2S8/BD/csMPEI9uoXU+Ewqj/mQvztxfk5r3
        YA63joMn9dgKm7Y/jXcNAyRj+5qpIe1bWpXlmyRyrZcS59MOJe2AHwLseXwSrqMyaqqIYI
        CdaA9AaEahcGrYVmQk4nvDdQ4h2EXYf2ilCYhBoGp6mC1UJf3ggUhrQkqgt6/xfeEylngD
        64UfZGzKlZaE/BHsUfsYeVF+kgi8tde8shHhdXXF7/4Vsfq7rMDmp/MGcD5B6mAjt1vqaP
        hm69xmT4F2KWwUAgAN1hxmKQvKBgCW1yBDBa5yrGRtXlZI9KJO0ALMEMP7sxcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683725620;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=53DYRyYgi1d1SjVMdlxHIf2xem2K/RBtXiqOJgn1bv0=;
        b=HA13omX32VFIM1PJOgonn5tWa0J50aD6lOD1lkBE+3Nr5m+Nfp/F1W8lVWSDHa/uhLxn15
        CKS9jSjH+K8yERDQ==
From:   "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Define bit macros for FixCntrCtl MSR
Cc:     Dapeng Mi <dapeng1.mi@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230504072128.3653470-1-dapeng1.mi@linux.intel.com>
References: <20230504072128.3653470-1-dapeng1.mi@linux.intel.com>
MIME-Version: 1.0
Message-ID: <168372562014.404.9870140299751145713.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     10d95a317ec12ec7dd4587a646c6bd6aa03c7ded
Gitweb:        https://git.kernel.org/tip/10d95a317ec12ec7dd4587a646c6bd6aa03c7ded
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Thu, 04 May 2023 15:21:28 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 08 May 2023 10:58:32 +02:00

perf/x86/intel: Define bit macros for FixCntrCtl MSR

Define bit macros for FixCntrCtl MSR and replace the bit hardcoding
with these bit macros. This would make code be more human-readable.

Perf commands 'perf stat -e "instructions,cycles,ref-cycles"' and
'perf record -e "instructions,cycles,ref-cycles"' pass.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230504072128.3653470-1-dapeng1.mi@linux.intel.com
---
 arch/x86/events/intel/core.c      | 18 +++++++++---------
 arch/x86/include/asm/perf_event.h | 10 ++++++++++
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 070cc4e..0d09245 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2451,7 +2451,7 @@ static void intel_pmu_disable_fixed(struct perf_event *event)
 
 	intel_clear_masks(event, idx);
 
-	mask = 0xfULL << ((idx - INTEL_PMC_IDX_FIXED) * 4);
+	mask = intel_fixed_bits_by_idx(idx - INTEL_PMC_IDX_FIXED, INTEL_FIXED_BITS_MASK);
 	cpuc->fixed_ctrl_val &= ~mask;
 }
 
@@ -2750,25 +2750,25 @@ static void intel_pmu_enable_fixed(struct perf_event *event)
 	 * if requested:
 	 */
 	if (!event->attr.precise_ip)
-		bits |= 0x8;
+		bits |= INTEL_FIXED_0_ENABLE_PMI;
 	if (hwc->config & ARCH_PERFMON_EVENTSEL_USR)
-		bits |= 0x2;
+		bits |= INTEL_FIXED_0_USER;
 	if (hwc->config & ARCH_PERFMON_EVENTSEL_OS)
-		bits |= 0x1;
+		bits |= INTEL_FIXED_0_KERNEL;
 
 	/*
 	 * ANY bit is supported in v3 and up
 	 */
 	if (x86_pmu.version > 2 && hwc->config & ARCH_PERFMON_EVENTSEL_ANY)
-		bits |= 0x4;
+		bits |= INTEL_FIXED_0_ANYTHREAD;
 
 	idx -= INTEL_PMC_IDX_FIXED;
-	bits <<= (idx * 4);
-	mask = 0xfULL << (idx * 4);
+	bits = intel_fixed_bits_by_idx(idx, bits);
+	mask = intel_fixed_bits_by_idx(idx, INTEL_FIXED_BITS_MASK);
 
 	if (x86_pmu.intel_cap.pebs_baseline && event->attr.precise_ip) {
-		bits |= ICL_FIXED_0_ADAPTIVE << (idx * 4);
-		mask |= ICL_FIXED_0_ADAPTIVE << (idx * 4);
+		bits |= intel_fixed_bits_by_idx(idx, ICL_FIXED_0_ADAPTIVE);
+		mask |= intel_fixed_bits_by_idx(idx, ICL_FIXED_0_ADAPTIVE);
 	}
 
 	cpuc->fixed_ctrl_val &= ~mask;
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index fc86248..7d16fcf 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -32,11 +32,21 @@
 #define ARCH_PERFMON_EVENTSEL_INV			(1ULL << 23)
 #define ARCH_PERFMON_EVENTSEL_CMASK			0xFF000000ULL
 
+#define INTEL_FIXED_BITS_MASK				0xFULL
+#define INTEL_FIXED_BITS_STRIDE			4
+#define INTEL_FIXED_0_KERNEL				(1ULL << 0)
+#define INTEL_FIXED_0_USER				(1ULL << 1)
+#define INTEL_FIXED_0_ANYTHREAD			(1ULL << 2)
+#define INTEL_FIXED_0_ENABLE_PMI			(1ULL << 3)
+
 #define HSW_IN_TX					(1ULL << 32)
 #define HSW_IN_TX_CHECKPOINTED				(1ULL << 33)
 #define ICL_EVENTSEL_ADAPTIVE				(1ULL << 34)
 #define ICL_FIXED_0_ADAPTIVE				(1ULL << 32)
 
+#define intel_fixed_bits_by_idx(_idx, _bits)			\
+	((_bits) << ((_idx) * INTEL_FIXED_BITS_STRIDE))
+
 #define AMD64_EVENTSEL_INT_CORE_ENABLE			(1ULL << 36)
 #define AMD64_EVENTSEL_GUESTONLY			(1ULL << 40)
 #define AMD64_EVENTSEL_HOSTONLY				(1ULL << 41)

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C039B6CF24A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 20:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjC2SiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 14:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjC2SiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 14:38:06 -0400
Received: from out-56.mta1.migadu.com (out-56.mta1.migadu.com [IPv6:2001:41d0:203:375::38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00C859F3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 11:38:02 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680115080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KXwl8tO7n70VCzS+2Z99ZqyN4ebAwCoCQirv2FwloPQ=;
        b=agGDWJ9xzHKORm0clngE5cybrY2NbiNiuT8Au3+SurJwSKOhd7350jBTyPn/yXpT9rTRV9
        BE7EEFNPLvmCxOGUcnuqPyNdnpttIko/We2eAOk+kYoVbjy2qrGk3zUJLFwLcwFmSyampp
        LtPeZOW+QWpuEawW1ooy7OC5yXZRZpE=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Weizhao Ouyang <ouyangweizhao@zeku.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v2 5/5] kasan: suppress recursive reports for HW_TAGS
Date:   Wed, 29 Mar 2023 20:37:48 +0200
Message-Id: <d14417c8bc5eea7589e99381203432f15c0f9138.1680114854.git.andreyknvl@google.com>
In-Reply-To: <dc432429a6d87f197eefb179f26012c6c1ec6cd9.1680114854.git.andreyknvl@google.com>
References: <dc432429a6d87f197eefb179f26012c6c1ec6cd9.1680114854.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

KASAN suppresses reports for bad accesses done by the KASAN reporting
code. The reporting code might access poisoned memory for reporting
purposes.

Software KASAN modes do this by suppressing reports during reporting
via current->kasan_depth, the same way they suppress reports during
accesses to poisoned slab metadata.

Hardware Tag-Based KASAN does not use current->kasan_depth, and instead
resets pointer tags for accesses to poisoned memory done by the reporting
code.

Despite that, a recursive report can still happen:

1. On hardware with faulty MTE support. This was observed by Weizhao
   Ouyang on a faulty hardware that caused memory tags to randomly change
   from time to time.

2. Theoretically, due to a previous MTE-undetected memory corruption.

A recursive report can happen via:

1. Accessing a pointer with a non-reset tag in the reporting code, e.g.
   slab->slab_cache, which is what Weizhao Ouyang observed.

2. Theoretically, via external non-annotated routines, e.g. stackdepot.

To resolve this issue, resetting tags for all of the pointers in the
reporting code and all the used external routines would be impractical.

Instead, disable tag checking done by the CPU for the duration of KASAN
reporting for Hardware Tag-Based KASAN.

Without this fix, Hardware Tag-Based KASAN reporting code might deadlock.

Fixes: 2e903b914797 ("kasan, arm64: implement HW_TAGS runtime")
Reported-by: Weizhao Ouyang <ouyangweizhao@zeku.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Considering that 1. the bug this patch fixes was only observed on faulty
MTE hardware, and 2. the patch depends on the other patches in this series,
I don't think it's worth backporting it into stable.

Changes v1->v2:
- Disable preemption instead of migration.
- Fix comment typo.
---
 mm/kasan/report.c | 59 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 48 insertions(+), 11 deletions(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 89078f912827..892a9dc9d4d3 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -72,10 +72,18 @@ static int __init kasan_set_multi_shot(char *str)
 __setup("kasan_multi_shot", kasan_set_multi_shot);
 
 /*
- * Used to suppress reports within kasan_disable/enable_current() critical
- * sections, which are used for marking accesses to slab metadata.
+ * This function is used to check whether KASAN reports are suppressed for
+ * software KASAN modes via kasan_disable/enable_current() critical sections.
+ *
+ * This is done to avoid:
+ * 1. False-positive reports when accessing slab metadata,
+ * 2. Deadlocking when poisoned memory is accessed by the reporting code.
+ *
+ * Hardware Tag-Based KASAN instead relies on:
+ * For #1: Resetting tags via kasan_reset_tag().
+ * For #2: Suppression of tag checks via CPU, see report_suppress_start/end().
  */
-static bool report_suppressed(void)
+static bool report_suppressed_sw(void)
 {
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 	if (current->kasan_depth)
@@ -84,6 +92,30 @@ static bool report_suppressed(void)
 	return false;
 }
 
+static void report_suppress_start(void)
+{
+#ifdef CONFIG_KASAN_HW_TAGS
+	/*
+	 * Disable preemption for the duration of printing a KASAN report, as
+	 * hw_suppress_tag_checks_start() disables checks on the current CPU.
+	 */
+	preempt_disable();
+	hw_suppress_tag_checks_start();
+#else
+	kasan_disable_current();
+#endif
+}
+
+static void report_suppress_stop(void)
+{
+#ifdef CONFIG_KASAN_HW_TAGS
+	hw_suppress_tag_checks_stop();
+	preempt_enable();
+#else
+	kasan_enable_current();
+#endif
+}
+
 /*
  * Used to avoid reporting more than one KASAN bug unless kasan_multi_shot
  * is enabled. Note that KASAN tests effectively enable kasan_multi_shot
@@ -174,7 +206,7 @@ static void start_report(unsigned long *flags, bool sync)
 	/* Do not allow LOCKDEP mangling KASAN reports. */
 	lockdep_off();
 	/* Make sure we don't end up in loop. */
-	kasan_disable_current();
+	report_suppress_start();
 	spin_lock_irqsave(&report_lock, *flags);
 	pr_err("==================================================================\n");
 }
@@ -192,7 +224,7 @@ static void end_report(unsigned long *flags, void *addr)
 		panic("kasan.fault=panic set ...\n");
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
 	lockdep_on();
-	kasan_enable_current();
+	report_suppress_stop();
 }
 
 static void print_error_description(struct kasan_report_info *info)
@@ -480,9 +512,13 @@ void kasan_report_invalid_free(void *ptr, unsigned long ip, enum kasan_report_ty
 	struct kasan_report_info info;
 
 	/*
-	 * Do not check report_suppressed(), as an invalid-free cannot be
-	 * caused by accessing slab metadata and thus should not be
-	 * suppressed by kasan_disable/enable_current() critical sections.
+	 * Do not check report_suppressed_sw(), as an invalid-free cannot be
+	 * caused by accessing poisoned memory and thus should not be suppressed
+	 * by kasan_disable/enable_current() critical sections.
+	 *
+	 * Note that for Hardware Tag-Based KASAN, kasan_report_invalid_free()
+	 * is triggered by explicit tag checks and not by the ones performed by
+	 * the CPU. Thus, reporting invalid-free is not suppressed as well.
 	 */
 	if (unlikely(!report_enabled()))
 		return;
@@ -517,7 +553,7 @@ bool kasan_report(unsigned long addr, size_t size, bool is_write,
 	unsigned long irq_flags;
 	struct kasan_report_info info;
 
-	if (unlikely(report_suppressed()) || unlikely(!report_enabled())) {
+	if (unlikely(report_suppressed_sw()) || unlikely(!report_enabled())) {
 		ret = false;
 		goto out;
 	}
@@ -549,8 +585,9 @@ void kasan_report_async(void)
 	unsigned long flags;
 
 	/*
-	 * Do not check report_suppressed(), as kasan_disable/enable_current()
-	 * critical sections do not affect Hardware Tag-Based KASAN.
+	 * Do not check report_suppressed_sw(), as
+	 * kasan_disable/enable_current() critical sections do not affect
+	 * Hardware Tag-Based KASAN.
 	 */
 	if (unlikely(!report_enabled()))
 		return;
-- 
2.25.1


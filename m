Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2938866973E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241202AbjAMMei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241322AbjAMMcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:32:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC3C5471E;
        Fri, 13 Jan 2023 04:31:12 -0800 (PST)
Date:   Fri, 13 Jan 2023 12:31:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673613069;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e7Y3l2KD9ved6+hCAgfs1PE3fvrgAFNWQxKHFlM7ro8=;
        b=HmVFt+QhXJXdKJSEattrs5ZfggVVMiN4synsLcw2WSR8y28rTZpsmnFxa3qh1cJUnF6nOi
        OWcOclkq/cN+YlocfEid9O56yKGVFBVLPPmyE/AwnCVIRKg1Vea+zA0neP4lWZXntqe19R
        Ev5FpteTk3gSVQePSRI4W40hK7wtR4bUgh6Tm6FDXi55b21ykGCPLYy+iHckGJBqOAW75P
        TNyeeQQdDI45KNGRc67IZze4LAXGIrRwWVQAKV2X7ue/ssIggnYM/Qky++7Oj/+6mGHakq
        M5fScBI6b319hav3K0PD4z/A7rR6p9pSuMBIuj9gym+qLlpSUrMmqQ9P+aB8Pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673613069;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e7Y3l2KD9ved6+hCAgfs1PE3fvrgAFNWQxKHFlM7ro8=;
        b=HtUNCyhFZJChujU/sVFvcVGANItEWjKat0uKGLAfnoItEB2ybXl/8s9u9DPvJkOaaov0Xj
        s39g60JsMF/pojBw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] cpuidle, ACPI: Make noinstr clean
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230112195541.294846301@infradead.org>
References: <20230112195541.294846301@infradead.org>
MIME-Version: 1.0
Message-ID: <167361306869.4906.9255375329309060578.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     6a123d6ae6ea930b9bb3c595ceac2b2f93039f67
Gitweb:        https://git.kernel.org/tip/6a123d6ae6ea930b9bb3c595ceac2b2f93039f67
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 12 Jan 2023 20:43:46 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jan 2023 11:48:16 +01:00

cpuidle, ACPI: Make noinstr clean

objtool found cases where ACPI methods called out into instrumentation code:

  vmlinux.o: warning: objtool: io_idle+0xc: call to __inb.isra.0() leaves .noinstr.text section
  vmlinux.o: warning: objtool: acpi_idle_enter+0xfe: call to num_online_cpus() leaves .noinstr.text section
  vmlinux.o: warning: objtool: acpi_idle_enter+0x115: call to acpi_idle_fallback_to_c1.isra.0() leaves .noinstr.text section

Fix this by: marking the IO in/out, acpi_idle_fallback_to_c1() and
num_online_cpus() methods as __always_inline.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20230112195541.294846301@infradead.org
---
 arch/x86/include/asm/shared/io.h | 4 ++--
 drivers/acpi/processor_idle.c    | 2 +-
 include/linux/cpumask.h          | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/shared/io.h b/arch/x86/include/asm/shared/io.h
index c0ef921..8009d78 100644
--- a/arch/x86/include/asm/shared/io.h
+++ b/arch/x86/include/asm/shared/io.h
@@ -5,13 +5,13 @@
 #include <linux/types.h>
 
 #define BUILDIO(bwl, bw, type)						\
-static inline void __out##bwl(type value, u16 port)			\
+static __always_inline void __out##bwl(type value, u16 port)		\
 {									\
 	asm volatile("out" #bwl " %" #bw "0, %w1"			\
 		     : : "a"(value), "Nd"(port));			\
 }									\
 									\
-static inline type __in##bwl(u16 port)					\
+static __always_inline type __in##bwl(u16 port)				\
 {									\
 	type value;							\
 	asm volatile("in" #bwl " %w1, %" #bw "0"			\
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 48fcd28..7f77710 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -607,7 +607,7 @@ static int acpi_idle_play_dead(struct cpuidle_device *dev, int index)
 	return 0;
 }
 
-static bool acpi_idle_fallback_to_c1(struct acpi_processor *pr)
+static __always_inline bool acpi_idle_fallback_to_c1(struct acpi_processor *pr)
 {
 	return IS_ENABLED(CONFIG_HOTPLUG_CPU) && !pr->flags.has_cst &&
 		!(acpi_gbl_FADT.flags & ACPI_FADT_C2_MP_SUPPORTED);
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index c2aa0aa..d45e5de 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -1017,9 +1017,9 @@ static inline const struct cpumask *get_cpu_mask(unsigned int cpu)
  * concurrent CPU hotplug operations unless invoked from a cpuhp_lock held
  * region.
  */
-static inline unsigned int num_online_cpus(void)
+static __always_inline unsigned int num_online_cpus(void)
 {
-	return atomic_read(&__num_online_cpus);
+	return arch_atomic_read(&__num_online_cpus);
 }
 #define num_possible_cpus()	cpumask_weight(cpu_possible_mask)
 #define num_present_cpus()	cpumask_weight(cpu_present_mask)

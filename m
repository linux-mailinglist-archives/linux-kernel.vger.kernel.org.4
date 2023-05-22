Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3168370BC2D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbjEVLtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233408AbjEVLta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:49:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4458A3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:49:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 716B86179D
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 11:49:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AADAC4339B;
        Mon, 22 May 2023 11:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684756168;
        bh=09RSAK353TjlZgFkK3E0PRiLI2ExOq5xZFRF9Hx0UP4=;
        h=From:To:Cc:Subject:Date:From;
        b=c0KqqmNuYsyt4bX1BLvfXqWPZCcBjtdh5HqKH68YbaY3HI4wEBOj7i0vTaevkB2Zf
         1MUuJOSzE95fw9E4IITgFHNfrUIV9jQ5R8tHCZak380ujmsa4BkNrnItvev24qZu8o
         yzQnEOpXEGXdTEuzWCFKqW0IyzoyXLmYGbsSUke1f5qghWfmPEtciIxciOfV+9476M
         zwW/0syTWrRo7saMFxsm5FELZdvqbMKqwFOgBxIRFDz3ED5oGE/T807hXFO/8fYzGT
         kb+nyc89Ci19CXWtC/qQdnG9/ERmvnEEAJBVLxfcHl1PTEXAoJvhVktaGsEmzFy4AU
         BK7+3DASuOMmQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Petr Mladek <pmladek@suse.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: watchdog_hld: provide arm_pmu_irq_is_nmi stub
Date:   Mon, 22 May 2023 13:48:19 +0200
Message-Id: <20230522114922.1052421-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The newly added arch_perf_nmi_is_available() function fails to build
when CONFIG_ARM_PMU is disabled:

arch/arm64/kernel/watchdog_hld.c: In function 'arch_perf_nmi_is_available':
arch/arm64/kernel/watchdog_hld.c:35:16: error: implicit declaration of function 'arm_pmu_irq_is_nmi' [-Werror=implicit-function-declaration]
   35 |         return arm_pmu_irq_is_nmi();

As it turns out, there is only one caller for that function anyway,
in the same file as the __weak definition, and this can only be called
if CONFIG_ARM_PMU is also enabled.

I tried a number of variants, but everything ended up with more
complexity from having both the __weak function and one or more
added #ifdef. Keeping it in watchdog_perf.c is a small layering
violation but otherwise the most robust.

Fixes: 7e61b33831bc ("arm64: enable perf events based hard lockup detector")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
---
 arch/arm64/kernel/watchdog_hld.c | 10 ----------
 include/linux/nmi.h              |  1 -
 include/linux/perf/arm_pmu.h     |  7 ++++---
 kernel/watchdog_perf.c           | 11 ++++++++++-
 4 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/kernel/watchdog_hld.c b/arch/arm64/kernel/watchdog_hld.c
index dcd25322127c..3d948e5c1c1e 100644
--- a/arch/arm64/kernel/watchdog_hld.c
+++ b/arch/arm64/kernel/watchdog_hld.c
@@ -24,13 +24,3 @@ u64 hw_nmi_get_sample_period(int watchdog_thresh)
 
 	return (u64)max_cpu_freq * watchdog_thresh;
 }
-
-bool __init arch_perf_nmi_is_available(void)
-{
-	/*
-	 * hardlockup_detector_perf_init() will success even if Pseudo-NMI turns off,
-	 * however, the pmu interrupts will act like a normal interrupt instead of
-	 * NMI and the hardlockup detector would be broken.
-	 */
-	return arm_pmu_irq_is_nmi();
-}
diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index d23902a2fd49..1fabf8c35d27 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -212,7 +212,6 @@ static inline bool trigger_single_cpu_backtrace(int cpu)
 
 #ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
 u64 hw_nmi_get_sample_period(int watchdog_thresh);
-bool arch_perf_nmi_is_available(void);
 #endif
 
 #if defined(CONFIG_HARDLOCKUP_CHECK_TIMESTAMP) && \
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 5b00f5cb4cf9..cbdd3533d843 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -12,10 +12,11 @@
 #include <linux/perf_event.h>
 #include <linux/platform_device.h>
 #include <linux/sysfs.h>
-#include <asm/cputype.h>
 
 #ifdef CONFIG_ARM_PMU
 
+#include <asm/cputype.h>
+
 /*
  * The ARMv7 CPU PMU supports up to 32 event counters.
  */
@@ -171,8 +172,6 @@ void kvm_host_pmu_init(struct arm_pmu *pmu);
 #define kvm_host_pmu_init(x)	do { } while(0)
 #endif
 
-bool arm_pmu_irq_is_nmi(void);
-
 /* Internal functions only for core arm_pmu code */
 struct arm_pmu *armpmu_alloc(void);
 void armpmu_free(struct arm_pmu *pmu);
@@ -184,6 +183,8 @@ void armpmu_free_irq(int irq, int cpu);
 
 #endif /* CONFIG_ARM_PMU */
 
+bool arm_pmu_irq_is_nmi(void);
+
 #define ARMV8_SPE_PDEV_NAME "arm,spe-v1"
 
 #endif /* __ARM_PMU_H__ */
diff --git a/kernel/watchdog_perf.c b/kernel/watchdog_perf.c
index 8ea00c4a24b2..ee7d3dcfdda2 100644
--- a/kernel/watchdog_perf.c
+++ b/kernel/watchdog_perf.c
@@ -19,6 +19,7 @@
 
 #include <asm/irq_regs.h>
 #include <linux/perf_event.h>
+#include <linux/perf/arm_pmu.h>
 
 static DEFINE_PER_CPU(struct perf_event *, watchdog_ev);
 static DEFINE_PER_CPU(struct perf_event *, dead_event);
@@ -234,8 +235,16 @@ void __init hardlockup_detector_perf_restart(void)
 	}
 }
 
-bool __weak __init arch_perf_nmi_is_available(void)
+static bool __init arch_perf_nmi_is_available(void)
 {
+	/*
+	 * hardlockup_detector_perf_init() will success even if Pseudo-NMI turns off,
+	 * however, the pmu interrupts will act like a normal interrupt instead of
+	 * NMI and the hardlockup detector would be broken.
+	 */
+	if (IS_ENABLED(CONFIG_ARM_PMU))
+		return arm_pmu_irq_is_nmi();
+
 	return true;
 }
 
-- 
2.39.2


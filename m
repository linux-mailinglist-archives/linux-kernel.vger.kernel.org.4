Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C05C6BF1F0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 20:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjCQTvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 15:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjCQTvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 15:51:07 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3CB3A4F2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 12:50:48 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-544570e6d82so57125107b3.23
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 12:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679082646;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XsHIhTjG1TgxkAKk4QKS7wpdAjljWDCWo7xglNbEXhM=;
        b=LcFFZwItiiLsdG2t2h3U0h68WAaRV582YutG8/qcggo0hfNhhSHU8Q4BMd/Esr7a7i
         wVGgaLXpjbdzo32oHiPbYgZvSn5/VziJgQ1ARIRBvbOmGGAzRqJ4nOHJzj5IB5IZovVF
         M0ezSG7qdkSM1Jx3BNDkh8X1PBBNRW95fb35ro/Ubm709ukx4WDz41xG5khGhm1WRrta
         PX4IVSl5XVn4IM8tihVvcGV44NodIBVYvQnD81sJbqgt/JRiXDyxZRtrfcJ3eWL1OFOV
         Q54usD3V4CHs5/9Dz7WoLroM9AhjTBMSBHJgBgwFaeWXLl4q9E8yI5dSO7NXlTaduVL0
         uS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679082646;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XsHIhTjG1TgxkAKk4QKS7wpdAjljWDCWo7xglNbEXhM=;
        b=TETZ2EGnz43lBuk3gn6Sx0PeUNWqIyq1nr+p4970RsCYL2utBTV3x2AhvvuctQq5Qi
         RNgxnFCuPJRq9WvlxnpiuG1IQa+76Wc7W56lv857L50nJNLQR9pp+koqF3BwwYYPurWJ
         kp3bcQv+C0/OLfcnhxHBcNqqTvgqI68zRQO7L6bGnkQTsIEsvU33ru8CjTwRYJFYV2R0
         M46I2LbYJ0X6NXC+gGzNRce9QJ4C8TqUxNy0t/sEK4HyWi9r+C4IcgbIX2HRsGL8hAC1
         nyPN6su+2Aj7VhltuBMh8CZkmbqkUa/XANJjm8GJN7TAE1KgXlQQiZYJyCLvzuQy/WVq
         MFCA==
X-Gm-Message-State: AO0yUKUeE2khNM6rEMtO7e0dMY5QIxbYZ9rNgztONwMz8wmN1uwpwidZ
        0sC/BFjm+eeHdNmrgvG1zVa/jzcgaPV2dYI=
X-Google-Smtp-Source: AK7set+0JFGEAofJw1Qxi5UNXe2u8Rwj1vDs0LU+u17GURMUimp/vYqbUGbONSLVchokfDAXirbr3+rtTWV7UnI=
X-Received: from zaidcloud.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5325])
 (user=zalbassam job=sendgmr) by 2002:a81:d84d:0:b0:543:9065:b225 with SMTP id
 n13-20020a81d84d000000b005439065b225mr5514547ywl.5.1679082646430; Fri, 17 Mar
 2023 12:50:46 -0700 (PDT)
Date:   Fri, 17 Mar 2023 15:50:26 -0400
In-Reply-To: <20230317195027.3746949-1-zalbassam@google.com>
Mime-Version: 1.0
References: <20230317195027.3746949-1-zalbassam@google.com>
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
Message-ID: <20230317195027.3746949-8-zalbassam@google.com>
Subject: [PATCH v4 7/8] ARM: perf: Allow the use of the PMUv3 driver on 32bit ARM
From:   Zaid Al-Bassam <zalbassam@google.com>
To:     Jesus Sanchez-Palencia <jesussanp@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, f.fainelli@gmail.com
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Zaid Al-Bassam <zalbassam@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Zyngier <marc.zyngier@arm.com>

The only thing stopping the PMUv3 driver from compiling on 32bit
is the lack of defined system registers names and the handful of
required helpers.

This is easily solved by providing the sysreg accessors and updating
the Kconfig entry.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Co-developed-by: Zaid Al-Bassam <zalbassam@google.com>
Signed-off-by: Zaid Al-Bassam <zalbassam@google.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm/include/asm/arm_pmuv3.h | 247 +++++++++++++++++++++++++++++++
 drivers/perf/Kconfig             |   5 +-
 drivers/perf/arm_pmuv3.c         |   5 +-
 3 files changed, 253 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/include/asm/arm_pmuv3.h

diff --git a/arch/arm/include/asm/arm_pmuv3.h b/arch/arm/include/asm/arm_pmuv3.h
new file mode 100644
index 000000000000..78d3d4b82c6c
--- /dev/null
+++ b/arch/arm/include/asm/arm_pmuv3.h
@@ -0,0 +1,247 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2012 ARM Ltd.
+ */
+
+#ifndef __ASM_PMUV3_H
+#define __ASM_PMUV3_H
+
+#include <asm/cp15.h>
+#include <asm/cputype.h>
+
+#define PMCCNTR			__ACCESS_CP15_64(0, c9)
+
+#define PMCR			__ACCESS_CP15(c9,  0, c12, 0)
+#define PMCNTENSET		__ACCESS_CP15(c9,  0, c12, 1)
+#define PMCNTENCLR		__ACCESS_CP15(c9,  0, c12, 2)
+#define PMOVSR			__ACCESS_CP15(c9,  0, c12, 3)
+#define PMSELR			__ACCESS_CP15(c9,  0, c12, 5)
+#define PMCEID0			__ACCESS_CP15(c9,  0, c12, 6)
+#define PMCEID1			__ACCESS_CP15(c9,  0, c12, 7)
+#define PMXEVTYPER		__ACCESS_CP15(c9,  0, c13, 1)
+#define PMXEVCNTR		__ACCESS_CP15(c9,  0, c13, 2)
+#define PMUSERENR		__ACCESS_CP15(c9,  0, c14, 0)
+#define PMINTENSET		__ACCESS_CP15(c9,  0, c14, 1)
+#define PMINTENCLR		__ACCESS_CP15(c9,  0, c14, 2)
+#define PMMIR			__ACCESS_CP15(c9,  0, c14, 6)
+#define PMCCFILTR		__ACCESS_CP15(c14, 0, c15, 7)
+
+#define PMEVCNTR0		__ACCESS_CP15(c14, 0, c8, 0)
+#define PMEVCNTR1		__ACCESS_CP15(c14, 0, c8, 1)
+#define PMEVCNTR2		__ACCESS_CP15(c14, 0, c8, 2)
+#define PMEVCNTR3		__ACCESS_CP15(c14, 0, c8, 3)
+#define PMEVCNTR4		__ACCESS_CP15(c14, 0, c8, 4)
+#define PMEVCNTR5		__ACCESS_CP15(c14, 0, c8, 5)
+#define PMEVCNTR6		__ACCESS_CP15(c14, 0, c8, 6)
+#define PMEVCNTR7		__ACCESS_CP15(c14, 0, c8, 7)
+#define PMEVCNTR8		__ACCESS_CP15(c14, 0, c9, 0)
+#define PMEVCNTR9		__ACCESS_CP15(c14, 0, c9, 1)
+#define PMEVCNTR10		__ACCESS_CP15(c14, 0, c9, 2)
+#define PMEVCNTR11		__ACCESS_CP15(c14, 0, c9, 3)
+#define PMEVCNTR12		__ACCESS_CP15(c14, 0, c9, 4)
+#define PMEVCNTR13		__ACCESS_CP15(c14, 0, c9, 5)
+#define PMEVCNTR14		__ACCESS_CP15(c14, 0, c9, 6)
+#define PMEVCNTR15		__ACCESS_CP15(c14, 0, c9, 7)
+#define PMEVCNTR16		__ACCESS_CP15(c14, 0, c10, 0)
+#define PMEVCNTR17		__ACCESS_CP15(c14, 0, c10, 1)
+#define PMEVCNTR18		__ACCESS_CP15(c14, 0, c10, 2)
+#define PMEVCNTR19		__ACCESS_CP15(c14, 0, c10, 3)
+#define PMEVCNTR20		__ACCESS_CP15(c14, 0, c10, 4)
+#define PMEVCNTR21		__ACCESS_CP15(c14, 0, c10, 5)
+#define PMEVCNTR22		__ACCESS_CP15(c14, 0, c10, 6)
+#define PMEVCNTR23		__ACCESS_CP15(c14, 0, c10, 7)
+#define PMEVCNTR24		__ACCESS_CP15(c14, 0, c11, 0)
+#define PMEVCNTR25		__ACCESS_CP15(c14, 0, c11, 1)
+#define PMEVCNTR26		__ACCESS_CP15(c14, 0, c11, 2)
+#define PMEVCNTR27		__ACCESS_CP15(c14, 0, c11, 3)
+#define PMEVCNTR28		__ACCESS_CP15(c14, 0, c11, 4)
+#define PMEVCNTR29		__ACCESS_CP15(c14, 0, c11, 5)
+#define PMEVCNTR30		__ACCESS_CP15(c14, 0, c11, 6)
+
+#define PMEVTYPER0		__ACCESS_CP15(c14, 0, c12, 0)
+#define PMEVTYPER1		__ACCESS_CP15(c14, 0, c12, 1)
+#define PMEVTYPER2		__ACCESS_CP15(c14, 0, c12, 2)
+#define PMEVTYPER3		__ACCESS_CP15(c14, 0, c12, 3)
+#define PMEVTYPER4		__ACCESS_CP15(c14, 0, c12, 4)
+#define PMEVTYPER5		__ACCESS_CP15(c14, 0, c12, 5)
+#define PMEVTYPER6		__ACCESS_CP15(c14, 0, c12, 6)
+#define PMEVTYPER7		__ACCESS_CP15(c14, 0, c12, 7)
+#define PMEVTYPER8		__ACCESS_CP15(c14, 0, c13, 0)
+#define PMEVTYPER9		__ACCESS_CP15(c14, 0, c13, 1)
+#define PMEVTYPER10		__ACCESS_CP15(c14, 0, c13, 2)
+#define PMEVTYPER11		__ACCESS_CP15(c14, 0, c13, 3)
+#define PMEVTYPER12		__ACCESS_CP15(c14, 0, c13, 4)
+#define PMEVTYPER13		__ACCESS_CP15(c14, 0, c13, 5)
+#define PMEVTYPER14		__ACCESS_CP15(c14, 0, c13, 6)
+#define PMEVTYPER15		__ACCESS_CP15(c14, 0, c13, 7)
+#define PMEVTYPER16		__ACCESS_CP15(c14, 0, c14, 0)
+#define PMEVTYPER17		__ACCESS_CP15(c14, 0, c14, 1)
+#define PMEVTYPER18		__ACCESS_CP15(c14, 0, c14, 2)
+#define PMEVTYPER19		__ACCESS_CP15(c14, 0, c14, 3)
+#define PMEVTYPER20		__ACCESS_CP15(c14, 0, c14, 4)
+#define PMEVTYPER21		__ACCESS_CP15(c14, 0, c14, 5)
+#define PMEVTYPER22		__ACCESS_CP15(c14, 0, c14, 6)
+#define PMEVTYPER23		__ACCESS_CP15(c14, 0, c14, 7)
+#define PMEVTYPER24		__ACCESS_CP15(c14, 0, c15, 0)
+#define PMEVTYPER25		__ACCESS_CP15(c14, 0, c15, 1)
+#define PMEVTYPER26		__ACCESS_CP15(c14, 0, c15, 2)
+#define PMEVTYPER27		__ACCESS_CP15(c14, 0, c15, 3)
+#define PMEVTYPER28		__ACCESS_CP15(c14, 0, c15, 4)
+#define PMEVTYPER29		__ACCESS_CP15(c14, 0, c15, 5)
+#define PMEVTYPER30		__ACCESS_CP15(c14, 0, c15, 6)
+
+#define RETURN_READ_PMEVCNTRN(n) \
+	return read_sysreg(PMEVCNTR##n)
+static unsigned long read_pmevcntrn(int n)
+{
+	PMEVN_SWITCH(n, RETURN_READ_PMEVCNTRN);
+	return 0;
+}
+
+#define WRITE_PMEVCNTRN(n) \
+	write_sysreg(val, PMEVCNTR##n)
+static void write_pmevcntrn(int n, unsigned long val)
+{
+	PMEVN_SWITCH(n, WRITE_PMEVCNTRN);
+}
+
+#define WRITE_PMEVTYPERN(n) \
+	write_sysreg(val, PMEVTYPER##n)
+static void write_pmevtypern(int n, unsigned long val)
+{
+	PMEVN_SWITCH(n, WRITE_PMEVTYPERN);
+}
+
+static inline unsigned long read_pmmir(void)
+{
+	return read_sysreg(PMMIR);
+}
+
+static inline u32 read_pmuver(void)
+{
+	/* PMUVers is not a signed field */
+	u32 dfr0 = read_cpuid_ext(CPUID_EXT_DFR0);
+
+	return (dfr0 >> 24) & 0xf;
+}
+
+static inline void write_pmcr(u32 val)
+{
+	write_sysreg(val, PMCR);
+}
+
+static inline u32 read_pmcr(void)
+{
+	return read_sysreg(PMCR);
+}
+
+static inline void write_pmselr(u32 val)
+{
+	write_sysreg(val, PMSELR);
+}
+
+static inline void write_pmccntr(u64 val)
+{
+	write_sysreg(val, PMCCNTR);
+}
+
+static inline u64 read_pmccntr(void)
+{
+	return read_sysreg(PMCCNTR);
+}
+
+static inline void write_pmxevcntr(u32 val)
+{
+	write_sysreg(val, PMXEVCNTR);
+}
+
+static inline u32 read_pmxevcntr(void)
+{
+	return read_sysreg(PMXEVCNTR);
+}
+
+static inline void write_pmxevtyper(u32 val)
+{
+	write_sysreg(val, PMXEVTYPER);
+}
+
+static inline void write_pmcntenset(u32 val)
+{
+	write_sysreg(val, PMCNTENSET);
+}
+
+static inline void write_pmcntenclr(u32 val)
+{
+	write_sysreg(val, PMCNTENCLR);
+}
+
+static inline void write_pmintenset(u32 val)
+{
+	write_sysreg(val, PMINTENSET);
+}
+
+static inline void write_pmintenclr(u32 val)
+{
+	write_sysreg(val, PMINTENCLR);
+}
+
+static inline void write_pmccfiltr(u32 val)
+{
+	write_sysreg(val, PMCCFILTR);
+}
+
+static inline void write_pmovsclr(u32 val)
+{
+	write_sysreg(val, PMOVSR);
+}
+
+static inline u32 read_pmovsclr(void)
+{
+	return read_sysreg(PMOVSR);
+}
+
+static inline void write_pmuserenr(u32 val)
+{
+	write_sysreg(val, PMUSERENR);
+}
+
+static inline u32 read_pmceid0(void)
+{
+	return read_sysreg(PMCEID0);
+}
+
+static inline u32 read_pmceid1(void)
+{
+	return read_sysreg(PMCEID1);
+}
+
+static inline void kvm_set_pmu_events(u32 set, struct perf_event_attr *attr) {}
+static inline void kvm_clr_pmu_events(u32 clr) {}
+static inline bool kvm_pmu_counter_deferred(struct perf_event_attr *attr)
+{
+	return false;
+}
+
+/* PMU Version in DFR Register */
+#define ARMV8_PMU_DFR_VER_NI        0
+#define ARMV8_PMU_DFR_VER_V3P4      0x5
+#define ARMV8_PMU_DFR_VER_V3P5      0x6
+#define ARMV8_PMU_DFR_VER_IMP_DEF   0xF
+
+static inline bool pmuv3_implemented(int pmuver)
+{
+	return !(pmuver == ARMV8_PMU_DFR_VER_IMP_DEF ||
+		 pmuver == ARMV8_PMU_DFR_VER_NI);
+}
+
+static inline bool is_pmuv3p4(int pmuver)
+{
+	return pmuver >= ARMV8_PMU_DFR_VER_V3P4;
+}
+
+static inline bool is_pmuv3p5(int pmuver)
+{
+	return pmuver >= ARMV8_PMU_DFR_VER_V3P5;
+}
+
+#endif
diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index defe6b47854b..711f82400086 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -101,15 +101,14 @@ config ARM_SMMU_V3_PMU
 	   based on the Stream ID of the corresponding master.
 
 config ARM_PMUV3
-	depends on HW_PERF_EVENTS && ARM64
+	depends on HW_PERF_EVENTS && ((ARM && CPU_V7) || ARM64)
 	bool "ARM PMUv3 support" if !ARM64
-	default y
+	default ARM64
 	  help
 	  Say y if you want to use the ARM performance monitor unit (PMU)
 	  version 3. The PMUv3 is the CPU performance monitors on ARMv8
 	  (aarch32 and aarch64) systems that implement the PMUv3
 	  architecture.
-	  Currently, PMUv3 is only supported on aarch64 (arm64)
 
 config ARM_DSU_PMU
 	tristate "ARM DynamIQ Shared Unit (DSU) PMU"
diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index fc8ed3cd0330..34ed0d5d7898 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -388,10 +388,13 @@ static const struct attribute_group armv8_pmuv3_caps_attr_group = {
  * We unconditionally enable ARMv8.5-PMU long event counter support
  * (64-bit events) where supported. Indicate if this arm_pmu has long
  * event counter support.
+ *
+ * On AArch32, long counters make no sense (you can't access the top
+ * bits), so we only enable this on AArch64.
  */
 static bool armv8pmu_has_long_event(struct arm_pmu *cpu_pmu)
 {
-	return (is_pmuv3p5(cpu_pmu->pmuver));
+	return (IS_ENABLED(CONFIG_ARM64) && is_pmuv3p5(cpu_pmu->pmuver));
 }
 
 static inline bool armv8pmu_event_has_user_read(struct perf_event *event)
-- 
2.40.0.rc2.332.ga46443480c-goog


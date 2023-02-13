Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2938769529B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 22:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjBMVDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 16:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjBMVDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 16:03:40 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED941C32B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 13:03:36 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id p4-20020a654904000000b004fb64e929f2so3144673pgs.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 13:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5KgxR8qARlL6EBlDQOoQPr60C1wPtTsGRFlh0ne/vcQ=;
        b=kZd3pFmb+p1AebajdEBhaPWFJdsLycH08PYfsnQA2I0Nvy53h2D31H0khCve88ri1W
         OHjJtXrD7+hVLu2BWU3yQn/ONOZ9//m1liQX8gD8KHmewpwfCDHYfM7wKT28aDh/rzLb
         d3nkhUJGz5YCQiIByP/PLbK6FSQEuqeeZUIzF2Tezdxaus3w26FfoWXntNYxCWmnhmKp
         uN+XKQ2A2BgRjEkDQINCdmnSQCRepyLXFJ4fr33UqSAd0a//rlnWU7SSwpily/fAPv5X
         MUU7DLvuiTDwTht/9aOYCrdsbX52U/xZfLy02d8ym8jWTsw7djWoZMHL94qreY9yC1QN
         Vu5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5KgxR8qARlL6EBlDQOoQPr60C1wPtTsGRFlh0ne/vcQ=;
        b=5m4INWPD1NlJS5Hz9a7qnyv+RiZ0tXocqyFTQjkzIJnVlk5JfcSsRRz/oMviwjJr2l
         f+aQf4ooH/syqF5c94ek/oU8/YpFq6719kDDcdVnnLuP1YN/EkuQ1j6zFHXv6ZpTuNjX
         FGWk8vtEjVwuRfFg76mJgeznQGxoJD6Kfr9Nc5XmXO0sviGeqvVIKsRnpTFIOcfWLiDZ
         Zr5Yq1IDgGA5bxo9iFn3eMpoUZ9rPeA4mQGvFrvx6E/Nt5PPIsNKzueySCA7p/RexaJ3
         Ug1wcM+AedkPAzgzr0wkt+LgI9ey51j5OsocANpH7ifsxTAGrsHGkqLK8eJj3lZqze4j
         gq2Q==
X-Gm-Message-State: AO0yUKVTaAJLO6UmygckSlCzx/v0WQVDZVB5I66uBLMLTl7x890q4SVu
        ZsFJopiFUJ4ZRcLP10Se2L9eI6P9kri/UDk=
X-Google-Smtp-Source: AK7set9kRyrGdtw/cG7vwTUMlv/Zl5ihZygdXUFkBj/SSzA5cTwsLtmzOaoEoopa9lKz5/a0qPDEDOkBFjKPeKk=
X-Received: from zaidcloud.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5325])
 (user=zalbassam job=sendgmr) by 2002:a17:903:25d4:b0:193:2bec:a3f2 with SMTP
 id jc20-20020a17090325d400b001932beca3f2mr68169plb.22.1676322215692; Mon, 13
 Feb 2023 13:03:35 -0800 (PST)
Date:   Mon, 13 Feb 2023 16:03:13 -0500
In-Reply-To: <20230213210319.1075872-1-zalbassam@google.com>
Mime-Version: 1.0
References: <20230213210319.1075872-1-zalbassam@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230213210319.1075872-3-zalbassam@google.com>
Subject: [PATCH v3 2/8] arm64: perf: Abstract system register accesses away
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
        kvmarm@lists.cs.columbia.edu
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Zaid Al-Bassam <zalbassam@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Zyngier <marc.zyngier@arm.com>

As we want to enable 32bit support, we need to distanciate the
PMUv3 driver from the AArch64 system register names.

This patch moves all system register accesses to an architecture
specific include file, allowing the 32bit counterpart to be
slotted in at a later time.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Co-developed-by: Zaid Al-Bassam <zalbassam@google.com>
Signed-off-by: Zaid Al-Bassam <zalbassam@google.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/arm_pmuv3.h | 137 +++++++++++++++++++++++++++++
 drivers/perf/arm_pmuv3.c           | 115 +++++-------------------
 include/linux/perf/arm_pmuv3.h     |  45 ++++++++++
 3 files changed, 205 insertions(+), 92 deletions(-)
 create mode 100644 arch/arm64/include/asm/arm_pmuv3.h

diff --git a/arch/arm64/include/asm/arm_pmuv3.h b/arch/arm64/include/asm/arm_pmuv3.h
new file mode 100644
index 0000000000000..c444cbfb3acd4
--- /dev/null
+++ b/arch/arm64/include/asm/arm_pmuv3.h
@@ -0,0 +1,137 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2012 ARM Ltd.
+ */
+
+#ifndef __ASM_PMUV3_H
+#define __ASM_PMUV3_H
+
+#include <asm/cpufeature.h>
+#include <asm/sysreg.h>
+
+#define RETURN_READ_PMEVCNTRN(n) \
+	return read_sysreg(pmevcntr##n##_el0)
+static unsigned long read_pmevcntrn(int n)
+{
+	PMEVN_SWITCH(n, RETURN_READ_PMEVCNTRN);
+	return 0;
+}
+
+#define WRITE_PMEVCNTRN(n) \
+	write_sysreg(val, pmevcntr##n##_el0)
+static void write_pmevcntrn(int n, unsigned long val)
+{
+	PMEVN_SWITCH(n, WRITE_PMEVCNTRN);
+}
+
+#define WRITE_PMEVTYPERN(n) \
+	write_sysreg(val, pmevtyper##n##_el0)
+static void write_pmevtypern(int n, unsigned long val)
+{
+	PMEVN_SWITCH(n, WRITE_PMEVTYPERN);
+}
+
+static inline unsigned long read_pmmir(void)
+{
+	return read_cpuid(PMMIR_EL1);
+}
+
+static inline u32 read_pmuver(void)
+{
+	u64 dfr0 = read_sysreg(id_aa64dfr0_el1);
+
+	return cpuid_feature_extract_unsigned_field(dfr0,
+			ID_AA64DFR0_EL1_PMUVer_SHIFT);
+}
+
+static inline void write_pmcr(u32 val)
+{
+	write_sysreg(val, pmcr_el0);
+}
+
+static inline u32 read_pmcr(void)
+{
+	return read_sysreg(pmcr_el0);
+}
+
+static inline void write_pmselr(u32 val)
+{
+	write_sysreg(val, pmselr_el0);
+}
+
+static inline void write_pmccntr(u64 val)
+{
+	write_sysreg(val, pmccntr_el0);
+}
+
+static inline u64 read_pmccntr(void)
+{
+	return read_sysreg(pmccntr_el0);
+}
+
+static inline void write_pmxevcntr(u32 val)
+{
+	write_sysreg(val, pmxevcntr_el0);
+}
+
+static inline u32 read_pmxevcntr(void)
+{
+	return read_sysreg(pmxevcntr_el0);
+}
+
+static inline void write_pmxevtyper(u32 val)
+{
+	write_sysreg(val, pmxevtyper_el0);
+}
+
+static inline void write_pmcntenset(u32 val)
+{
+	write_sysreg(val, pmcntenset_el0);
+}
+
+static inline void write_pmcntenclr(u32 val)
+{
+	write_sysreg(val, pmcntenclr_el0);
+}
+
+static inline void write_pmintenset(u32 val)
+{
+	write_sysreg(val, pmintenset_el1);
+}
+
+static inline void write_pmintenclr(u32 val)
+{
+	write_sysreg(val, pmintenclr_el1);
+}
+
+static inline void write_pmccfiltr(u32 val)
+{
+	write_sysreg(val, pmccfiltr_el0);
+}
+
+static inline void write_pmovsclr(u32 val)
+{
+	write_sysreg(val, pmovsclr_el0);
+}
+
+static inline u32 read_pmovsclr(void)
+{
+	return read_sysreg(pmovsclr_el0);
+}
+
+static inline void write_pmuserenr(u32 val)
+{
+	write_sysreg(val, pmuserenr_el0);
+}
+
+static inline u32 read_pmceid0(void)
+{
+	return read_sysreg(pmceid0_el0);
+}
+
+static inline u32 read_pmceid1(void)
+{
+	return read_sysreg(pmceid1_el0);
+}
+
+#endif
diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 781364bf3f417..94e4098b662d3 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -10,7 +10,6 @@
 
 #include <asm/irq_regs.h>
 #include <asm/perf_event.h>
-#include <asm/sysreg.h>
 #include <asm/virt.h>
 
 #include <clocksource/arm_arch_timer.h>
@@ -25,6 +24,8 @@
 #include <linux/sched_clock.h>
 #include <linux/smp.h>
 
+#include <asm/arm_pmuv3.h>
+
 /* ARMv8 Cortex-A53 specific event types. */
 #define ARMV8_A53_PERFCTR_PREF_LINEFILL				0xC2
 
@@ -425,83 +426,16 @@ static inline bool armv8pmu_event_is_chained(struct perf_event *event)
 #define	ARMV8_IDX_TO_COUNTER(x)	\
 	(((x) - ARMV8_IDX_COUNTER0) & ARMV8_PMU_COUNTER_MASK)
 
-/*
- * This code is really good
- */
-
-#define PMEVN_CASE(n, case_macro) \
-	case n: case_macro(n); break
-
-#define PMEVN_SWITCH(x, case_macro)				\
-	do {							\
-		switch (x) {					\
-		PMEVN_CASE(0,  case_macro);			\
-		PMEVN_CASE(1,  case_macro);			\
-		PMEVN_CASE(2,  case_macro);			\
-		PMEVN_CASE(3,  case_macro);			\
-		PMEVN_CASE(4,  case_macro);			\
-		PMEVN_CASE(5,  case_macro);			\
-		PMEVN_CASE(6,  case_macro);			\
-		PMEVN_CASE(7,  case_macro);			\
-		PMEVN_CASE(8,  case_macro);			\
-		PMEVN_CASE(9,  case_macro);			\
-		PMEVN_CASE(10, case_macro);			\
-		PMEVN_CASE(11, case_macro);			\
-		PMEVN_CASE(12, case_macro);			\
-		PMEVN_CASE(13, case_macro);			\
-		PMEVN_CASE(14, case_macro);			\
-		PMEVN_CASE(15, case_macro);			\
-		PMEVN_CASE(16, case_macro);			\
-		PMEVN_CASE(17, case_macro);			\
-		PMEVN_CASE(18, case_macro);			\
-		PMEVN_CASE(19, case_macro);			\
-		PMEVN_CASE(20, case_macro);			\
-		PMEVN_CASE(21, case_macro);			\
-		PMEVN_CASE(22, case_macro);			\
-		PMEVN_CASE(23, case_macro);			\
-		PMEVN_CASE(24, case_macro);			\
-		PMEVN_CASE(25, case_macro);			\
-		PMEVN_CASE(26, case_macro);			\
-		PMEVN_CASE(27, case_macro);			\
-		PMEVN_CASE(28, case_macro);			\
-		PMEVN_CASE(29, case_macro);			\
-		PMEVN_CASE(30, case_macro);			\
-		default: WARN(1, "Invalid PMEV* index\n");	\
-		}						\
-	} while (0)
-
-#define RETURN_READ_PMEVCNTRN(n) \
-	return read_sysreg(pmevcntr##n##_el0)
-static unsigned long read_pmevcntrn(int n)
-{
-	PMEVN_SWITCH(n, RETURN_READ_PMEVCNTRN);
-	return 0;
-}
-
-#define WRITE_PMEVCNTRN(n) \
-	write_sysreg(val, pmevcntr##n##_el0)
-static void write_pmevcntrn(int n, unsigned long val)
-{
-	PMEVN_SWITCH(n, WRITE_PMEVCNTRN);
-}
-
-#define WRITE_PMEVTYPERN(n) \
-	write_sysreg(val, pmevtyper##n##_el0)
-static void write_pmevtypern(int n, unsigned long val)
-{
-	PMEVN_SWITCH(n, WRITE_PMEVTYPERN);
-}
-
 static inline u32 armv8pmu_pmcr_read(void)
 {
-	return read_sysreg(pmcr_el0);
+	return read_pmcr();
 }
 
 static inline void armv8pmu_pmcr_write(u32 val)
 {
 	val &= ARMV8_PMU_PMCR_MASK;
 	isb();
-	write_sysreg(val, pmcr_el0);
+	write_pmcr(val);
 }
 
 static inline int armv8pmu_has_overflowed(u32 pmovsr)
@@ -576,7 +510,7 @@ static u64 armv8pmu_read_counter(struct perf_event *event)
 	u64 value;
 
 	if (idx == ARMV8_IDX_CYCLE_COUNTER)
-		value = read_sysreg(pmccntr_el0);
+		value = read_pmccntr();
 	else
 		value = armv8pmu_read_hw_counter(event);
 
@@ -611,7 +545,7 @@ static void armv8pmu_write_counter(struct perf_event *event, u64 value)
 	value = armv8pmu_bias_long_counter(event, value);
 
 	if (idx == ARMV8_IDX_CYCLE_COUNTER)
-		write_sysreg(value, pmccntr_el0);
+		write_pmccntr(value);
 	else
 		armv8pmu_write_hw_counter(event, value);
 }
@@ -642,7 +576,7 @@ static inline void armv8pmu_write_event_type(struct perf_event *event)
 		armv8pmu_write_evtype(idx, chain_evt);
 	} else {
 		if (idx == ARMV8_IDX_CYCLE_COUNTER)
-			write_sysreg(hwc->config_base, pmccfiltr_el0);
+			write_pmccfiltr(hwc->config_base);
 		else
 			armv8pmu_write_evtype(idx, hwc->config_base);
 	}
@@ -665,7 +599,7 @@ static inline void armv8pmu_enable_counter(u32 mask)
 	 * enable the counter.
 	 * */
 	isb();
-	write_sysreg(mask, pmcntenset_el0);
+	write_pmcntenset(mask);
 }
 
 static inline void armv8pmu_enable_event_counter(struct perf_event *event)
@@ -682,7 +616,7 @@ static inline void armv8pmu_enable_event_counter(struct perf_event *event)
 
 static inline void armv8pmu_disable_counter(u32 mask)
 {
-	write_sysreg(mask, pmcntenclr_el0);
+	write_pmcntenclr(mask);
 	/*
 	 * Make sure the effects of disabling the counter are visible before we
 	 * start configuring the event.
@@ -704,7 +638,7 @@ static inline void armv8pmu_disable_event_counter(struct perf_event *event)
 
 static inline void armv8pmu_enable_intens(u32 mask)
 {
-	write_sysreg(mask, pmintenset_el1);
+	write_pmintenset(mask);
 }
 
 static inline void armv8pmu_enable_event_irq(struct perf_event *event)
@@ -715,10 +649,10 @@ static inline void armv8pmu_enable_event_irq(struct perf_event *event)
 
 static inline void armv8pmu_disable_intens(u32 mask)
 {
-	write_sysreg(mask, pmintenclr_el1);
+	write_pmintenclr(mask);
 	isb();
 	/* Clear the overflow flag in case an interrupt is pending. */
-	write_sysreg(mask, pmovsclr_el0);
+	write_pmovsclr(mask);
 	isb();
 }
 
@@ -733,18 +667,18 @@ static inline u32 armv8pmu_getreset_flags(void)
 	u32 value;
 
 	/* Read */
-	value = read_sysreg(pmovsclr_el0);
+	value = read_pmovsclr();
 
 	/* Write to clear flags */
 	value &= ARMV8_PMU_OVSR_MASK;
-	write_sysreg(value, pmovsclr_el0);
+	write_pmovsclr(value);
 
 	return value;
 }
 
 static void armv8pmu_disable_user_access(void)
 {
-	write_sysreg(0, pmuserenr_el0);
+	write_pmuserenr(0);
 }
 
 static void armv8pmu_enable_user_access(struct arm_pmu *cpu_pmu)
@@ -755,13 +689,13 @@ static void armv8pmu_enable_user_access(struct arm_pmu *cpu_pmu)
 	/* Clear any unused counters to avoid leaking their contents */
 	for_each_clear_bit(i, cpuc->used_mask, cpu_pmu->num_events) {
 		if (i == ARMV8_IDX_CYCLE_COUNTER)
-			write_sysreg(0, pmccntr_el0);
+			write_pmccntr(0);
 		else
 			armv8pmu_write_evcntr(i, 0);
 	}
 
-	write_sysreg(0, pmuserenr_el0);
-	write_sysreg(ARMV8_PMU_USERENR_ER | ARMV8_PMU_USERENR_CR, pmuserenr_el0);
+	write_pmuserenr(0);
+	write_pmuserenr(ARMV8_PMU_USERENR_ER | ARMV8_PMU_USERENR_CR);
 }
 
 static void armv8pmu_enable_event(struct perf_event *event)
@@ -1143,14 +1077,11 @@ static void __armv8pmu_probe_pmu(void *info)
 {
 	struct armv8pmu_probe_info *probe = info;
 	struct arm_pmu *cpu_pmu = probe->pmu;
-	u64 dfr0;
 	u64 pmceid_raw[2];
 	u32 pmceid[2];
 	int pmuver;
 
-	dfr0 = read_sysreg(id_aa64dfr0_el1);
-	pmuver = cpuid_feature_extract_unsigned_field(dfr0,
-			ID_AA64DFR0_EL1_PMUVer_SHIFT);
+	pmuver = read_pmuver();
 	if (pmuver == ID_AA64DFR0_EL1_PMUVer_IMP_DEF ||
 	    pmuver == ID_AA64DFR0_EL1_PMUVer_NI)
 		return;
@@ -1165,8 +1096,8 @@ static void __armv8pmu_probe_pmu(void *info)
 	/* Add the CPU cycles counter */
 	cpu_pmu->num_events += 1;
 
-	pmceid[0] = pmceid_raw[0] = read_sysreg(pmceid0_el0);
-	pmceid[1] = pmceid_raw[1] = read_sysreg(pmceid1_el0);
+	pmceid[0] = pmceid_raw[0] = read_pmceid0();
+	pmceid[1] = pmceid_raw[1] = read_pmceid1();
 
 	bitmap_from_arr32(cpu_pmu->pmceid_bitmap,
 			     pmceid, ARMV8_PMUV3_MAX_COMMON_EVENTS);
@@ -1177,9 +1108,9 @@ static void __armv8pmu_probe_pmu(void *info)
 	bitmap_from_arr32(cpu_pmu->pmceid_ext_bitmap,
 			     pmceid, ARMV8_PMUV3_MAX_COMMON_EVENTS);
 
-	/* store PMMIR_EL1 register for sysfs */
+	/* store PMMIR register for sysfs */
 	if (pmuver >= ID_AA64DFR0_EL1_PMUVer_V3P4 && (pmceid_raw[1] & BIT(31)))
-		cpu_pmu->reg_pmmir = read_cpuid(PMMIR_EL1);
+		cpu_pmu->reg_pmmir = read_pmmir();
 	else
 		cpu_pmu->reg_pmmir = 0;
 }
diff --git a/include/linux/perf/arm_pmuv3.h b/include/linux/perf/arm_pmuv3.h
index 53173abfc0226..e3899bd77f5cc 100644
--- a/include/linux/perf/arm_pmuv3.h
+++ b/include/linux/perf/arm_pmuv3.h
@@ -255,4 +255,49 @@
 #define ARMV8_PMU_BUS_WIDTH_SHIFT 16
 #define ARMV8_PMU_BUS_WIDTH_MASK 0xf
 
+/*
+ * This code is really good
+ */
+
+#define PMEVN_CASE(n, case_macro) \
+	case n: case_macro(n); break
+
+#define PMEVN_SWITCH(x, case_macro)				\
+	do {							\
+		switch (x) {					\
+		PMEVN_CASE(0,  case_macro);			\
+		PMEVN_CASE(1,  case_macro);			\
+		PMEVN_CASE(2,  case_macro);			\
+		PMEVN_CASE(3,  case_macro);			\
+		PMEVN_CASE(4,  case_macro);			\
+		PMEVN_CASE(5,  case_macro);			\
+		PMEVN_CASE(6,  case_macro);			\
+		PMEVN_CASE(7,  case_macro);			\
+		PMEVN_CASE(8,  case_macro);			\
+		PMEVN_CASE(9,  case_macro);			\
+		PMEVN_CASE(10, case_macro);			\
+		PMEVN_CASE(11, case_macro);			\
+		PMEVN_CASE(12, case_macro);			\
+		PMEVN_CASE(13, case_macro);			\
+		PMEVN_CASE(14, case_macro);			\
+		PMEVN_CASE(15, case_macro);			\
+		PMEVN_CASE(16, case_macro);			\
+		PMEVN_CASE(17, case_macro);			\
+		PMEVN_CASE(18, case_macro);			\
+		PMEVN_CASE(19, case_macro);			\
+		PMEVN_CASE(20, case_macro);			\
+		PMEVN_CASE(21, case_macro);			\
+		PMEVN_CASE(22, case_macro);			\
+		PMEVN_CASE(23, case_macro);			\
+		PMEVN_CASE(24, case_macro);			\
+		PMEVN_CASE(25, case_macro);			\
+		PMEVN_CASE(26, case_macro);			\
+		PMEVN_CASE(27, case_macro);			\
+		PMEVN_CASE(28, case_macro);			\
+		PMEVN_CASE(29, case_macro);			\
+		PMEVN_CASE(30, case_macro);			\
+		default: WARN(1, "Invalid PMEV* index\n");	\
+		}						\
+	} while (0)
+
 #endif
-- 
2.39.1.581.gbfd45094c4-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76CA662C12
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 18:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237476AbjAIRC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 12:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237172AbjAIRCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:02:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6526140C3E;
        Mon,  9 Jan 2023 09:02:12 -0800 (PST)
Date:   Mon, 09 Jan 2023 17:02:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673283728;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OCFtZReMR4rIHRgKbX8dBhxZVMbjfofRNtsMQSMlfiU=;
        b=Vby5NodKBWbhIpqwbRBMP6jhfgSHM9VOHGPiNx+iyPmlqKbk/qWvj7ILUkJRdLG5p/E7JJ
        3OdA1glsjxXWKwSjxKdrLAj5I8ZJbWxl7DdgIFh1UzauQjapcqVl078wCwX3seu3bjXnXf
        TzBe6iQHe8+5m4jm1I/qSLzr437gQ8FdktGFssK9LtJmOQ1fgGb7lfXwZqvUWdEvEZ2G+3
        yJuaK6EF8C10H+k3h/MLDDnHmwJJGEyno0iP+JipXZtPBQOPGcJhthdY1sz1SdPYDek1jm
        2FoeRJuJRKDCDXGOGHaeDfuqRaVkLiLbeXuWpNtQDRPbW4BVVFYCqFdy/DfVTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673283728;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OCFtZReMR4rIHRgKbX8dBhxZVMbjfofRNtsMQSMlfiU=;
        b=UQyB+BBaPMJQfrhA7c/69L8oV1XWzGwFsYpB6PzRyLdliQIgNZDBUd7fV0nkIK7RDLezkr
        o1AT08IDDBo/0HDA==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Support Architectural PerfMon Extension leaf
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230104201349.1451191-5-kan.liang@linux.intel.com>
References: <20230104201349.1451191-5-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <167328372857.4906.17027265208278525066.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     eb467aaac21e133a3d01c48c0a6bf43756b06e78
Gitweb:        https://git.kernel.org/tip/eb467aaac21e133a3d01c48c0a6bf43756b06e78
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 04 Jan 2023 12:13:45 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 09 Jan 2023 12:22:08 +01:00

perf/x86/intel: Support Architectural PerfMon Extension leaf

The new CPUID leaf 0x23 reports the "true view" of PMU resources.

The sub-leaf 1 reports the available general-purpose counters and fixed
counters. Update the number of counters and fixed counters when the
sub-leaf is detected.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230104201349.1451191-5-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c      | 22 ++++++++++++++++++++++
 arch/x86/include/asm/perf_event.h |  8 ++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index a5678ab..29d2d04 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4588,6 +4588,25 @@ static void flip_smm_bit(void *data)
 	}
 }
 
+static void intel_pmu_check_num_counters(int *num_counters,
+					 int *num_counters_fixed,
+					 u64 *intel_ctrl, u64 fixed_mask);
+
+static void update_pmu_cap(struct x86_hybrid_pmu *pmu)
+{
+	unsigned int sub_bitmaps = cpuid_eax(ARCH_PERFMON_EXT_LEAF);
+	unsigned int eax, ebx, ecx, edx;
+
+	if (sub_bitmaps & ARCH_PERFMON_NUM_COUNTER_LEAF_BIT) {
+		cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_NUM_COUNTER_LEAF,
+			    &eax, &ebx, &ecx, &edx);
+		pmu->num_counters = fls(eax);
+		pmu->num_counters_fixed = fls(ebx);
+		intel_pmu_check_num_counters(&pmu->num_counters, &pmu->num_counters_fixed,
+					     &pmu->intel_ctrl, ebx);
+	}
+}
+
 static bool init_hybrid_pmu(int cpu)
 {
 	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
@@ -4613,6 +4632,9 @@ static bool init_hybrid_pmu(int cpu)
 	if (!cpumask_empty(&pmu->supported_cpus))
 		goto end;
 
+	if (this_cpu_has(X86_FEATURE_ARCH_PERFMON_EXT))
+		update_pmu_cap(pmu);
+
 	if (!check_hw_exists(&pmu->pmu, pmu->num_counters, pmu->num_counters_fixed))
 		return false;
 
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 5d0f689..6496bdb 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -160,6 +160,14 @@ union cpuid10_edx {
 };
 
 /*
+ * Intel "Architectural Performance Monitoring extension" CPUID
+ * detection/enumeration details:
+ */
+#define ARCH_PERFMON_EXT_LEAF			0x00000023
+#define ARCH_PERFMON_NUM_COUNTER_LEAF_BIT	0x1
+#define ARCH_PERFMON_NUM_COUNTER_LEAF		0x1
+
+/*
  * Intel Architectural LBR CPUID detection/enumeration details:
  */
 union cpuid28_eax {

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBEB6D1712
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 07:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjCaF47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 01:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjCaF4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 01:56:54 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582D0C17E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 22:56:53 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id u11-20020a05600c19cb00b003edcc414997so13137510wmq.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 22:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680242212;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4AhPs/edJoFMNccyq+OH3X2YnLzjhvBJwYKm7IHIpLk=;
        b=mYW5Z1t1FUd4p1UxyXSV5fRu2zFvP3CzrUoBZ/uUgRt/DSUk0gaYPduWEQ/UmEaOXK
         wpfYYcfeVkGh8C0BiRi3F3eCu+Ce3B0Ic+umn2H12JLP0YrVY7ieR8p5X9qq2k5qxTpN
         U7mlUoq7bA7D0FMJIL3YvQ/y40lxd24gUnpONeqZGqrQriPJNqKOwBemLAlsZjoglUO2
         QI6LyptJMPpLQ4Gse68Nf27fx7BqxhiQh1QWJyfmPjZQSQRISe3lfHZDZyfz0ID0luj6
         MsnCRd6yLVwhAtm5y15BXXwOrWJTDuMjpK88AWfWiN7IPu3ZMCOImFthmbJ+8sVWmP8r
         U9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680242212;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4AhPs/edJoFMNccyq+OH3X2YnLzjhvBJwYKm7IHIpLk=;
        b=T1yH7hc5fGp7lpo6SexLnD4cRTXVGkBO1Fo7XleiXBpnf+ISWgalbPf/DW9Zou/Uls
         JElZlhKqTULzIAkVEwyzqwWNujM6gTthYl1Pe+sKmXlk5i7QevDsacHl0NzCsSHJKp36
         wN/ry3Qw6Ebfd3DpLrbS4EqBv4e+sq7EmDTNwhpfx3BdfpowecEesZ6TaU/RYy9GSD+O
         k2OKtZ71WahrYh0yFYiiDHZcpInEsv/u8tUDTMAwoUUO5MHBbDFpqdzjsY1ZoRNKyVBl
         Yx7eJ23sKOzPKMlmqBQdSdu2ZVNIlKm2BOVBZxQOVgpFk6xe9mKYnf04S+82sl48UcAS
         ZGRw==
X-Gm-Message-State: AO0yUKWkPoQHn2adZaoET3NIl2IAQYt6IV3uPSHkBOTo8gw9sknzrUjr
        EoXYednV59rUefER10h27jBDsA==
X-Google-Smtp-Source: AK7set+bgSS4E8wYWdBimXSdhRxc/CWJbcU5gFntP0vy4DnmHxF1kpA5rDf4BM+UE+x/NOQL5HFwqw==
X-Received: by 2002:a1c:790b:0:b0:3ee:7022:5eda with SMTP id l11-20020a1c790b000000b003ee70225edamr19460719wme.7.1680242211636;
        Thu, 30 Mar 2023 22:56:51 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:680a:d01:24d4:5fa:d4b2:7c14])
        by smtp.gmail.com with ESMTPSA id iz5-20020a05600c554500b003ef67ac3846sm8464055wmb.24.2023.03.30.22.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 22:56:51 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, acme@kernel.org
Cc:     suzuki.poulose@arm.com, leo.yan@linaro.org, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, gankulkarni@os.amperecomputing.com,
        darren@os.amperecomputing.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v9 2/3] perf: cs-etm: Update record event to use new Trace ID protocol
Date:   Fri, 31 Mar 2023 06:56:44 +0100
Message-Id: <20230331055645.26918-3-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230331055645.26918-1-mike.leach@linaro.org>
References: <20230331055645.26918-1-mike.leach@linaro.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trace IDs are now dynamically allocated.

Previously used the static association algorithm that is no longer
used. The 'cpu * 2 + seed' was outdated and broken for systems with high
core counts (>46). as it did not scale and was broken for larger
core counts.

Trace ID will now be sent in PERF_RECORD_AUX_OUTPUT_HW_ID record.

Legacy ID algorithm renamed and retained for limited backward
compatibility use.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: James Clark <james.clark@arm.com>
Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 tools/include/linux/coresight-pmu.h | 29 +++++++++++++++++------------
 tools/perf/arch/arm/util/cs-etm.c   | 27 +++++++++++++++++----------
 2 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/tools/include/linux/coresight-pmu.h b/tools/include/linux/coresight-pmu.h
index db9c7c0abb6a..1760f9a574b0 100644
--- a/tools/include/linux/coresight-pmu.h
+++ b/tools/include/linux/coresight-pmu.h
@@ -10,11 +10,27 @@
 #include <linux/bits.h>
 
 #define CORESIGHT_ETM_PMU_NAME "cs_etm"
-#define CORESIGHT_ETM_PMU_SEED  0x10
+
+/*
+ * The legacy Trace ID system based on fixed calculation from the cpu
+ * number. This has been replaced by drivers using a dynamic allocation
+ * system - but need to retain the legacy algorithm for backward comparibility
+ * in certain situations:-
+ * a) new perf running on older systems that generate the legacy mapping
+ * b) older tools that may not update at the same time as the kernel.
+ */
+#define CORESIGHT_LEGACY_CPU_TRACE_ID(cpu)  (0x10 + (cpu * 2))
 
 /* CoreSight trace ID is currently the bottom 7 bits of the value */
 #define CORESIGHT_TRACE_ID_VAL_MASK	GENMASK(6, 0)
 
+/*
+ * perf record will set the legacy meta data values as unused initially.
+ * This allows perf report to manage the decoders created when dynamic
+ * allocation in operation.
+ */
+#define CORESIGHT_TRACE_ID_UNUSED_FLAG	BIT(31)
+
 /*
  * Below are the definition of bit offsets for perf option, and works as
  * arbitrary values for all ETM versions.
@@ -39,15 +55,4 @@
 #define ETM4_CFG_BIT_RETSTK	12
 #define ETM4_CFG_BIT_VMID_OPT	15
 
-static inline int coresight_get_trace_id(int cpu)
-{
-	/*
-	 * A trace ID of value 0 is invalid, so let's start at some
-	 * random value that fits in 7 bits and go from there.  Since
-	 * the common convention is to have data trace IDs be I(N) + 1,
-	 * set instruction trace IDs as a function of the CPU number.
-	 */
-	return (CORESIGHT_ETM_PMU_SEED + (cpu * 2));
-}
-
 #endif
diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 86b61ad74f90..e02a9bfc3d42 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -437,13 +437,16 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 	evlist__to_front(evlist, cs_etm_evsel);
 
 	/*
-	 * In the case of per-cpu mmaps, we need the CPU on the
-	 * AUX event.  We also need the contextID in order to be notified
+	 * get the CPU on the sample - need it to associate trace ID in the
+	 * AUX_OUTPUT_HW_ID event, and the AUX event for per-cpu mmaps.
+	 */
+	evsel__set_sample_bit(cs_etm_evsel, CPU);
+
+	/*
+	 * Also the case of per-cpu mmaps, need the contextID in order to be notified
 	 * when a context switch happened.
 	 */
 	if (!perf_cpu_map__empty(cpus)) {
-		evsel__set_sample_bit(cs_etm_evsel, CPU);
-
 		err = cs_etm_set_option(itr, cs_etm_evsel,
 					BIT(ETM_OPT_CTXTID) | BIT(ETM_OPT_TS));
 		if (err)
@@ -679,8 +682,10 @@ static void cs_etm_save_etmv4_header(__u64 data[], struct auxtrace_record *itr,
 
 	/* Get trace configuration register */
 	data[CS_ETMV4_TRCCONFIGR] = cs_etmv4_get_config(itr);
-	/* Get traceID from the framework */
-	data[CS_ETMV4_TRCTRACEIDR] = coresight_get_trace_id(cpu);
+	/* traceID set to legacy version, in case new perf running on older system */
+	data[CS_ETMV4_TRCTRACEIDR] =
+		CORESIGHT_LEGACY_CPU_TRACE_ID(cpu) | CORESIGHT_TRACE_ID_UNUSED_FLAG;
+
 	/* Get read-only information from sysFS */
 	data[CS_ETMV4_TRCIDR0] = cs_etm_get_ro(cs_etm_pmu, cpu,
 					       metadata_etmv4_ro[CS_ETMV4_TRCIDR0]);
@@ -711,8 +716,10 @@ static void cs_etm_save_ete_header(__u64 data[], struct auxtrace_record *itr, in
 
 	/* Get trace configuration register */
 	data[CS_ETE_TRCCONFIGR] = cs_etmv4_get_config(itr);
-	/* Get traceID from the framework */
-	data[CS_ETE_TRCTRACEIDR] = coresight_get_trace_id(cpu);
+	/* traceID set to legacy version, in case new perf running on older system */
+	data[CS_ETE_TRCTRACEIDR] =
+		CORESIGHT_LEGACY_CPU_TRACE_ID(cpu) | CORESIGHT_TRACE_ID_UNUSED_FLAG;
+
 	/* Get read-only information from sysFS */
 	data[CS_ETE_TRCIDR0] = cs_etm_get_ro(cs_etm_pmu, cpu,
 					     metadata_ete_ro[CS_ETE_TRCIDR0]);
@@ -768,9 +775,9 @@ static void cs_etm_get_metadata(int cpu, u32 *offset,
 		magic = __perf_cs_etmv3_magic;
 		/* Get configuration register */
 		info->priv[*offset + CS_ETM_ETMCR] = cs_etm_get_config(itr);
-		/* Get traceID from the framework */
+		/* traceID set to legacy value in case new perf running on old system */
 		info->priv[*offset + CS_ETM_ETMTRACEIDR] =
-						coresight_get_trace_id(cpu);
+			CORESIGHT_LEGACY_CPU_TRACE_ID(cpu) | CORESIGHT_TRACE_ID_UNUSED_FLAG;
 		/* Get read-only information from sysFS */
 		info->priv[*offset + CS_ETM_ETMCCER] =
 			cs_etm_get_ro(cs_etm_pmu, cpu,
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8A46CD83B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 13:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjC2LOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 07:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjC2LOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 07:14:32 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7952040EA
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 04:14:30 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id t4so10015549wra.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 04:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680088469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZkKsxifvpzrbY1sKIeX+ekvJgPBbTiP6xZY+McLGC0=;
        b=uwMR1MATpWaU9ka1o4fFdYFiZAoe8g9jl6+UNFhcx9D1tOSWrMd6pcYTuZkdAagbg/
         J8q4I997bdyeTYR8uc+YdBRdMGzt1jcondidvTYxhYmP1PCvKqLY5evqmI2B47zYkBXP
         Z9aMvPrft9Fhf3raWLlNd9sOgN31an2fuERhsH7eOCQmUchLuL6tU3KZoovp/SnrpxPA
         yoHn10Oza35PU/iyQwmtCzogThqXZs1TnCNkgbkk4P4qHpy12QgGuqX2kza/ruF8w4NU
         GweovYWGBaqnwQq3GDcBc5ynH8FYgGB5Kpmbi75H76Z4XNeJj8Ol+bIOsFaNKab4KwsX
         Je2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680088469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ZkKsxifvpzrbY1sKIeX+ekvJgPBbTiP6xZY+McLGC0=;
        b=R5zh7VYe5ozCDXibQ+dtWLvA6RQkynD/WNVn7sDporAmDnGHtZx9MRHb2aNCBFMKHw
         zbZe29M4N+OAec3z+beF0uvExMXEuequhNbXXQiWVHVET5rJnRd1kUNdKVbOmepK6hzU
         5AGHoGUaGkmh9rA06u4HJc1l9iThhuW1iDmv8IOihKA6Ak47WrojyAXVQL3XoNXENl8z
         aLWU2YF16nTquEtfp7fZlIfC7VSIhox/nWJkBVmts34icMoTa9kpWlRmMqtfaEzgMPTo
         c7xIPnypCySUZyDFV0nfz1Ii46jDrHVymSwi0YfWau3lZq8wPWSKkU47oaKET/YbnJPR
         rbYg==
X-Gm-Message-State: AAQBX9d8SB5cIDmhcOK41P26N0CHaG+GRsiE7SR6kDu+6XoTI0SXkQGJ
        ICNGTOExXJ6JbFwHPJ6RGj4tEQ==
X-Google-Smtp-Source: AKy350amB1qMcBXj4tYimkEG63qi9hk4DM9tLo6i3MT9ZvH6XEWMLZFQVjarLrqWRTfk1rRw9E3cUQ==
X-Received: by 2002:adf:f651:0:b0:2dc:f7a7:374e with SMTP id x17-20020adff651000000b002dcf7a7374emr15574331wrp.56.1680088468974;
        Wed, 29 Mar 2023 04:14:28 -0700 (PDT)
Received: from linaro.org (host86-131-79-192.range86-131.btcentralplus.com. [86.131.79.192])
        by smtp.gmail.com with ESMTPSA id m6-20020a056000008600b002cde25fba30sm30067163wrx.1.2023.03.29.04.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 04:14:28 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, acme@kernel.org,
        suzuki.poulose@arm.com
Cc:     leo.yan@linaro.org, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, john.garry@huawei.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, gankulkarni@os.amperecomputing.com,
        darren@os.amperecomputing.com, Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>
Subject: [PATCH v8 2/3] perf: cs-etm: Update record event to use new Trace ID protocol
Date:   Wed, 29 Mar 2023 12:14:21 +0100
Message-Id: <20230329111422.3693-3-mike.leach@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230329111422.3693-1-mike.leach@linaro.org>
References: <20230329111422.3693-1-mike.leach@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 tools/perf/arch/arm/util/cs-etm.c   | 21 +++++++++++++--------
 2 files changed, 30 insertions(+), 20 deletions(-)

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
index 86b61ad74f90..9cab5a05e7d7 100644
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
@@ -768,9 +773,9 @@ static void cs_etm_get_metadata(int cpu, u32 *offset,
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
2.32.0


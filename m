Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64ACF66BE2E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 13:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjAPMup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 07:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjAPMtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 07:49:49 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFAD1E9E3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:49:46 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id ay40so19923277wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JOkIyMrj9jAVnq1u2b/d95NeRDzS4KUPTPtP8tjZN5c=;
        b=JCWYeAnBNl1aj8s6McMHJuFzuniVzPmUKtFAlXM2zNUPKDmpEh5dUm1v76pvDap18Z
         lfhQQY9WNPKuYxLN36xpJJfAgBd88e38dzDtON/QPIb25J7eJkneH2p71/3rn9VrOg5R
         BnwuSzAjYAWqx5VRenlKDX5Z2Cgr8+ExiVmJH36O5bTColvwIw4cOKAg0KIWq1qfFpSD
         kPlvq1tW10Y6X7PWr3NzhfEtJcR1tKO3pB+I1EAz9AKw3pxtwOPMh0EdILua2VTXKOoD
         Ko3dzBLQy/1WHHfOaugIzsm8YNg/FygM7ic0Q39lM8fMieXXEqRaXtdZFa6cTEg73djX
         WK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JOkIyMrj9jAVnq1u2b/d95NeRDzS4KUPTPtP8tjZN5c=;
        b=PqqJzErEZnqkNv0zgnBsAQiERMUgGluB79un+2OdK8LHitnxL0R7Sk6I32ZVJXGZu7
         f5AvFAz4fsjZeBLGqDVHApZJ+UurFbc1iOM/SchxwrGKnGSMf0eBvknpQ1bJcoRML6xS
         fzwGp9uYaRO1VWnDtdKCOp8IP16R+k+fs5IoUhRZV9yO1YWDDmGHmPbWmU6bS1pBJQ4y
         2D8zsnN9OgDUMxj16pBZVya9cogrG3+EV5xPzAlYh7xez+xsxo0eOmSGR/qowXgFZF8O
         PExKvhFtdLxEQrCOcFxC3YEwzMJ1I4ztUAtoCq6k/iKoOmZOv+zR56Ylw2S//xPltFtJ
         yXqA==
X-Gm-Message-State: AFqh2krEduHFsZL5x+8XNIm96c0TeV1WvZS00FM9NEhgN7MBhkbCNHnG
        z3gYYQciHQ7HrZu+PHx3CAFPOw==
X-Google-Smtp-Source: AMrXdXubYrQOuZrpFj2z6HUARVjepeRLL6DQV0tuqOuqBsyGloACaORyytKdGuSx4grwNjdsq/s0kw==
X-Received: by 2002:a05:600c:3d12:b0:3d0:bd9:edd4 with SMTP id bh18-20020a05600c3d1200b003d00bd9edd4mr66606829wmb.0.1673873385513;
        Mon, 16 Jan 2023 04:49:45 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6809:2201:6c91:710d:9433:e868])
        by smtp.gmail.com with ESMTPSA id fl12-20020a05600c0b8c00b003dab40f9eafsm6896832wmb.35.2023.01.16.04.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 04:49:44 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v7 10/15] perf: cs-etm: Update record event to use new Trace ID protocol
Date:   Mon, 16 Jan 2023 12:49:23 +0000
Message-Id: <20230116124928.5440-11-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230116124928.5440-1-mike.leach@linaro.org>
References: <20230116124928.5440-1-mike.leach@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 tools/include/linux/coresight-pmu.h | 30 +++++++++++++++++------------
 tools/perf/arch/arm/util/cs-etm.c   | 21 ++++++++++++--------
 2 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/tools/include/linux/coresight-pmu.h b/tools/include/linux/coresight-pmu.h
index db9c7c0abb6a..307f357defe9 100644
--- a/tools/include/linux/coresight-pmu.h
+++ b/tools/include/linux/coresight-pmu.h
@@ -10,11 +10,28 @@
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
+ * b) older tools e.g. simpleperf in Android, that may not update at the same
+ *    time as the kernel.
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
@@ -39,15 +56,4 @@
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
index a346d5f3dafa..c7e4b543259f 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -421,13 +421,16 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
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
@@ -633,8 +636,10 @@ static void cs_etm_save_etmv4_header(__u64 data[], struct auxtrace_record *itr,
 
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
@@ -681,9 +686,9 @@ static void cs_etm_get_metadata(int cpu, u32 *offset,
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


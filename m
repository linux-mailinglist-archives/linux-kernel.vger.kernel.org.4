Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9044E6D1713
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 07:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjCaF5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 01:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjCaF44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 01:56:56 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F90BCA18
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 22:56:53 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id v6-20020a05600c470600b003f034269c96so2895721wmo.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 22:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680242213;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mN3w6GX389HXcLgiOXptgNDp1zW7cj4B8n/slgcn6bY=;
        b=t0WQLv4U3/0ElrPtMJspM+AyO2Zx3ojgCMOcPLxvAsL78qOGE7fwE1WT/qMXVEZ2FQ
         K2V6ofe2bmOBt1xkm/G8toBlaAK3OzTVnn93ZiusPyGJ0DVY2gaTb1/D1f7F0IwGvckz
         trX3tvqXlT3oZavEuK5NuPZcEifCX4Ra9h03pYECnM5HIpmH/SKypocRWps6vza/z5C4
         77CKPlAV+Y6z0764QEU4b9U7MR5tNcb+XkQc4QT2y8qwZ/z9v2JabaOv8EITVn8NLKmN
         ndIWxPS7CG4s0QWlSgRfSUwFA8913GItgB2IIFSAG/1hdDqAViXJ/t1J28S9hUZLPlcU
         xyig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680242213;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mN3w6GX389HXcLgiOXptgNDp1zW7cj4B8n/slgcn6bY=;
        b=NodJfP+5gWO8BgCZ6Slw/qtJnud6HeHP9bHwamX9JjA1YdkGqVinixb6tkREeqJJEJ
         8JV6yK0PW9AufLLWZ0fSqznCFnG8bnmjRJkXfL/J/sqkYAXxN+tyVCqkwVlWXdA0c9Uf
         Bp1uIz7rc+t3w/S2qltDFGIfrpwCzPL5zgLIM4OBUa/QvHt1BUMFo/KQEi9o5nLj1+LC
         cYayiqEQQuMv9CZrACWHNqp9FPc/Npz+sI2QpBGoqe9ZqHKVbCVBXDHyKySA9HKe2CLW
         YdQhVZqZbnQKwl9ZpDZNcFBbgJPbOCyrP/s7nGX3Im68YsYoOlfVT5Gu+AE0MlITYiqw
         0RAg==
X-Gm-Message-State: AAQBX9cYFCdrlT0kJFU4Vu9Wbp1hclTu55wo3wpDzq6Cp3Qna9Tg/h1T
        sJZu0A1LGt5dqaFAUgr2oAA7oQ==
X-Google-Smtp-Source: AKy350aXtTOpaATPWtYal1vn8b3mYalsNWGg2HUCVwL1NofktQ2VxNP0LqB9SHAIhpZxHznlle5Kww==
X-Received: by 2002:a05:600c:244:b0:3ef:76dc:4b92 with SMTP id 4-20020a05600c024400b003ef76dc4b92mr9089072wmj.28.1680242212945;
        Thu, 30 Mar 2023 22:56:52 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:680a:d01:24d4:5fa:d4b2:7c14])
        by smtp.gmail.com with ESMTPSA id iz5-20020a05600c554500b003ef67ac3846sm8464055wmb.24.2023.03.30.22.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 22:56:52 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, acme@kernel.org
Cc:     suzuki.poulose@arm.com, leo.yan@linaro.org, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, gankulkarni@os.amperecomputing.com,
        darren@os.amperecomputing.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v9 3/3] perf: cs-etm: Handle PERF_RECORD_AUX_OUTPUT_HW_ID packet
Date:   Fri, 31 Mar 2023 06:56:45 +0100
Message-Id: <20230331055645.26918-4-mike.leach@linaro.org>
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

When using dynamically assigned CoreSight trace IDs the drivers can output
the ID / CPU association as a PERF_RECORD_AUX_OUTPUT_HW_ID packet.

Update cs-etm decoder to handle this packet by setting the CPU/Trace ID
mapping.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: James Clark <james.clark@arm.com>
Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 tools/include/linux/coresight-pmu.h           |  15 ++
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c |   7 +
 tools/perf/util/cs-etm.c                      | 246 ++++++++++++++++--
 3 files changed, 250 insertions(+), 18 deletions(-)

diff --git a/tools/include/linux/coresight-pmu.h b/tools/include/linux/coresight-pmu.h
index 1760f9a574b0..cef3b1c25335 100644
--- a/tools/include/linux/coresight-pmu.h
+++ b/tools/include/linux/coresight-pmu.h
@@ -31,6 +31,9 @@
  */
 #define CORESIGHT_TRACE_ID_UNUSED_FLAG	BIT(31)
 
+/* Value to set for unused trace ID values */
+#define CORESIGHT_TRACE_ID_UNUSED_VAL	0x7F
+
 /*
  * Below are the definition of bit offsets for perf option, and works as
  * arbitrary values for all ETM versions.
@@ -55,4 +58,16 @@
 #define ETM4_CFG_BIT_RETSTK	12
 #define ETM4_CFG_BIT_VMID_OPT	15
 
+/*
+ * Interpretation of the PERF_RECORD_AUX_OUTPUT_HW_ID payload.
+ * Used to associate a CPU with the CoreSight Trace ID.
+ * [07:00] - Trace ID - uses 8 bits to make value easy to read in file.
+ * [59:08] - Unused (SBZ)
+ * [63:60] - Version
+ */
+#define CS_AUX_HW_ID_TRACE_ID_MASK	GENMASK_ULL(7, 0)
+#define CS_AUX_HW_ID_VERSION_MASK	GENMASK_ULL(63, 60)
+
+#define CS_AUX_HW_ID_CURR_VERSION 0
+
 #endif
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index d0e521dfcf35..82a27ab90c8b 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -668,6 +668,7 @@ cs_etm_decoder__create_etm_decoder(struct cs_etm_decoder_params *d_params,
 	switch (t_params->protocol) {
 	case CS_ETM_PROTO_ETMV3:
 	case CS_ETM_PROTO_PTM:
+		csid = (t_params->etmv3.reg_idr & CORESIGHT_TRACE_ID_VAL_MASK);
 		cs_etm_decoder__gen_etmv3_config(t_params, &config_etmv3);
 		decoder->decoder_name = (t_params->protocol == CS_ETM_PROTO_ETMV3) ?
 							OCSD_BUILTIN_DCD_ETMV3 :
@@ -675,11 +676,13 @@ cs_etm_decoder__create_etm_decoder(struct cs_etm_decoder_params *d_params,
 		trace_config = &config_etmv3;
 		break;
 	case CS_ETM_PROTO_ETMV4i:
+		csid = (t_params->etmv4.reg_traceidr & CORESIGHT_TRACE_ID_VAL_MASK);
 		cs_etm_decoder__gen_etmv4_config(t_params, &trace_config_etmv4);
 		decoder->decoder_name = OCSD_BUILTIN_DCD_ETMV4I;
 		trace_config = &trace_config_etmv4;
 		break;
 	case CS_ETM_PROTO_ETE:
+		csid = (t_params->ete.reg_traceidr & CORESIGHT_TRACE_ID_VAL_MASK);
 		cs_etm_decoder__gen_ete_config(t_params, &trace_config_ete);
 		decoder->decoder_name = OCSD_BUILTIN_DCD_ETE;
 		trace_config = &trace_config_ete;
@@ -688,6 +691,10 @@ cs_etm_decoder__create_etm_decoder(struct cs_etm_decoder_params *d_params,
 		return -1;
 	}
 
+	/* if the CPU has no trace ID associated, no decoder needed */
+	if (csid == CORESIGHT_TRACE_ID_UNUSED_VAL)
+		return 0;
+
 	if (d_params->operation == CS_ETM_OPERATION_DECODE) {
 		if (ocsd_dt_create_decoder(decoder->dcd_tree,
 					   decoder->decoder_name,
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 5fc9c288080b..94e2d02009eb 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -220,6 +220,143 @@ static int cs_etm__map_trace_id(u8 trace_chan_id, u64 *cpu_metadata)
 	return 0;
 }
 
+static int cs_etm__metadata_get_trace_id(u8 *trace_chan_id, u64 *cpu_metadata)
+{
+	u64 cs_etm_magic = cpu_metadata[CS_ETM_MAGIC];
+
+	switch (cs_etm_magic) {
+	case __perf_cs_etmv3_magic:
+		*trace_chan_id = (u8)(cpu_metadata[CS_ETM_ETMTRACEIDR] &
+				      CORESIGHT_TRACE_ID_VAL_MASK);
+		break;
+	case __perf_cs_etmv4_magic:
+	case __perf_cs_ete_magic:
+		*trace_chan_id = (u8)(cpu_metadata[CS_ETMV4_TRCTRACEIDR] &
+				      CORESIGHT_TRACE_ID_VAL_MASK);
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+/*
+ * update metadata trace ID from the value found in the AUX_HW_INFO packet.
+ * This will also clear the CORESIGHT_TRACE_ID_UNUSED_FLAG flag if present.
+ */
+static int cs_etm__metadata_set_trace_id(u8 trace_chan_id, u64 *cpu_metadata)
+{
+	u64 cs_etm_magic = cpu_metadata[CS_ETM_MAGIC];
+
+	switch (cs_etm_magic) {
+	case __perf_cs_etmv3_magic:
+		 cpu_metadata[CS_ETM_ETMTRACEIDR] = trace_chan_id;
+		break;
+	case __perf_cs_etmv4_magic:
+	case __perf_cs_ete_magic:
+		cpu_metadata[CS_ETMV4_TRCTRACEIDR] = trace_chan_id;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+/*
+ * FIELD_GET (linux/bitfield.h) not available outside kernel code,
+ * and the header contains too many dependencies to just copy over,
+ * so roll our own based on the original
+ */
+#define __bf_shf(x) (__builtin_ffsll(x) - 1)
+#define FIELD_GET(_mask, _reg)						\
+	({								\
+		(typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)); \
+	})
+
+/*
+ * Handle the PERF_RECORD_AUX_OUTPUT_HW_ID event.
+ *
+ * The payload associates the Trace ID and the CPU.
+ * The routine is tolerant of seeing multiple packets with the same association,
+ * but a CPU / Trace ID association changing during a session is an error.
+ */
+static int cs_etm__process_aux_output_hw_id(struct perf_session *session,
+					    union perf_event *event)
+{
+	struct cs_etm_auxtrace *etm;
+	struct perf_sample sample;
+	struct int_node *inode;
+	struct evsel *evsel;
+	u64 *cpu_data;
+	u64 hw_id;
+	int cpu, version, err;
+	u8 trace_chan_id, curr_chan_id;
+
+	/* extract and parse the HW ID */
+	hw_id = event->aux_output_hw_id.hw_id;
+	version = FIELD_GET(CS_AUX_HW_ID_VERSION_MASK, hw_id);
+	trace_chan_id = FIELD_GET(CS_AUX_HW_ID_TRACE_ID_MASK, hw_id);
+
+	/* check that we can handle this version */
+	if (version > CS_AUX_HW_ID_CURR_VERSION)
+		return -EINVAL;
+
+	/* get access to the etm metadata */
+	etm = container_of(session->auxtrace, struct cs_etm_auxtrace, auxtrace);
+	if (!etm || !etm->metadata)
+		return -EINVAL;
+
+	/* parse the sample to get the CPU */
+	evsel = evlist__event2evsel(session->evlist, event);
+	if (!evsel)
+		return -EINVAL;
+	err = evsel__parse_sample(evsel, event, &sample);
+	if (err)
+		return err;
+	cpu = sample.cpu;
+	if (cpu == -1) {
+		/* no CPU in the sample - possibly recorded with an old version of perf */
+		pr_err("CS_ETM: no CPU AUX_OUTPUT_HW_ID sample. Use compatible perf to record.");
+		return -EINVAL;
+	}
+
+	/* See if the ID is mapped to a CPU, and it matches the current CPU */
+	inode = intlist__find(traceid_list, trace_chan_id);
+	if (inode) {
+		cpu_data = inode->priv;
+		if ((int)cpu_data[CS_ETM_CPU] != cpu) {
+			pr_err("CS_ETM: map mismatch between HW_ID packet CPU and Trace ID\n");
+			return -EINVAL;
+		}
+
+		/* check that the mapped ID matches */
+		err = cs_etm__metadata_get_trace_id(&curr_chan_id, cpu_data);
+		if (err)
+			return err;
+		if (curr_chan_id != trace_chan_id) {
+			pr_err("CS_ETM: mismatch between CPU trace ID and HW_ID packet ID\n");
+			return -EINVAL;
+		}
+
+		/* mapped and matched - return OK */
+		return 0;
+	}
+
+	/* not one we've seen before - lets map it */
+	cpu_data = etm->metadata[cpu];
+	err = cs_etm__map_trace_id(trace_chan_id, cpu_data);
+	if (err)
+		return err;
+
+	/*
+	 * if we are picking up the association from the packet, need to plug
+	 * the correct trace ID into the metadata for setting up decoders later.
+	 */
+	err = cs_etm__metadata_set_trace_id(trace_chan_id, cpu_data);
+	return err;
+}
+
 void cs_etm__etmq_set_traceid_queue_timestamp(struct cs_etm_queue *etmq,
 					      u8 trace_chan_id)
 {
@@ -2668,11 +2805,16 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
 	}
 
 	/*
-	 * In per-thread mode, CPU is set to -1, but TID will be set instead. See
-	 * auxtrace_mmap_params__set_idx(). Return 'not found' if neither CPU nor TID match.
+	 * In per-thread mode, auxtrace CPU is set to -1, but TID will be set instead. See
+	 * auxtrace_mmap_params__set_idx(). However, the sample AUX event will contain a
+	 * CPU as we set this always for the AUX_OUTPUT_HW_ID event.
+	 * So now compare only TIDs if auxtrace CPU is -1, and CPUs if auxtrace CPU is not -1.
+	 * Return 'not found' if mismatch.
 	 */
-	if ((auxtrace_event->cpu == (__u32) -1 && auxtrace_event->tid != sample->tid) ||
-			auxtrace_event->cpu != sample->cpu)
+	if (auxtrace_event->cpu == (__u32) -1) {
+		if (auxtrace_event->tid != sample->tid)
+			return 1;
+	} else if (auxtrace_event->cpu != sample->cpu)
 		return 1;
 
 	if (aux_event->flags & PERF_AUX_FLAG_OVERWRITE) {
@@ -2721,6 +2863,17 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
 	return 1;
 }
 
+static int cs_etm__process_aux_hw_id_cb(struct perf_session *session, union perf_event *event,
+					u64 offset __maybe_unused, void *data __maybe_unused)
+{
+	/* look to handle PERF_RECORD_AUX_OUTPUT_HW_ID early to ensure decoders can be set up */
+	if (event->header.type == PERF_RECORD_AUX_OUTPUT_HW_ID) {
+		(*(int *)data)++; /* increment found count */
+		return cs_etm__process_aux_output_hw_id(session, event);
+	}
+	return 0;
+}
+
 static int cs_etm__queue_aux_records_cb(struct perf_session *session, union perf_event *event,
 					u64 offset __maybe_unused, void *data __maybe_unused)
 {
@@ -2839,13 +2992,13 @@ static int cs_etm__map_trace_ids_metadata(int num_cpu, u64 **metadata)
 		cs_etm_magic = metadata[i][CS_ETM_MAGIC];
 		switch (cs_etm_magic) {
 		case __perf_cs_etmv3_magic:
-			trace_chan_id = (u8)((metadata[i][CS_ETM_ETMTRACEIDR]) &
-					     CORESIGHT_TRACE_ID_VAL_MASK);
+			metadata[i][CS_ETM_ETMTRACEIDR] &= CORESIGHT_TRACE_ID_VAL_MASK;
+			trace_chan_id = (u8)(metadata[i][CS_ETM_ETMTRACEIDR]);
 			break;
 		case __perf_cs_etmv4_magic:
 		case __perf_cs_ete_magic:
-			trace_chan_id = (u8)((metadata[i][CS_ETMV4_TRCTRACEIDR]) &
-					      CORESIGHT_TRACE_ID_VAL_MASK);
+			metadata[i][CS_ETMV4_TRCTRACEIDR] &= CORESIGHT_TRACE_ID_VAL_MASK;
+			trace_chan_id = (u8)(metadata[i][CS_ETMV4_TRCTRACEIDR]);
 			break;
 		default:
 			/* unknown magic number */
@@ -2858,6 +3011,35 @@ static int cs_etm__map_trace_ids_metadata(int num_cpu, u64 **metadata)
 	return 0;
 }
 
+/*
+ * If we found AUX_HW_ID packets, then set any metadata marked as unused to the
+ * unused value to reduce the number of unneeded decoders created.
+ */
+static int cs_etm__clear_unused_trace_ids_metadata(int num_cpu, u64 **metadata)
+{
+	u64 cs_etm_magic;
+	int i;
+
+	for (i = 0; i < num_cpu; i++) {
+		cs_etm_magic = metadata[i][CS_ETM_MAGIC];
+		switch (cs_etm_magic) {
+		case __perf_cs_etmv3_magic:
+			if (metadata[i][CS_ETM_ETMTRACEIDR] & CORESIGHT_TRACE_ID_UNUSED_FLAG)
+				metadata[i][CS_ETM_ETMTRACEIDR] = CORESIGHT_TRACE_ID_UNUSED_VAL;
+			break;
+		case __perf_cs_etmv4_magic:
+		case __perf_cs_ete_magic:
+			if (metadata[i][CS_ETMV4_TRCTRACEIDR] & CORESIGHT_TRACE_ID_UNUSED_FLAG)
+				metadata[i][CS_ETMV4_TRCTRACEIDR] = CORESIGHT_TRACE_ID_UNUSED_VAL;
+			break;
+		default:
+			/* unknown magic number */
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
 int cs_etm__process_auxtrace_info_full(union perf_event *event,
 				       struct perf_session *session)
 {
@@ -2869,6 +3051,7 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	int priv_size = 0;
 	int num_cpu;
 	int err = 0;
+	int aux_hw_id_found;
 	int i, j;
 	u64 *ptr = NULL;
 	u64 **metadata = NULL;
@@ -3017,8 +3200,43 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	if (err)
 		goto err_delete_thread;
 
-	/* before aux records are queued, need to map metadata to trace IDs */
-	err = cs_etm__map_trace_ids_metadata(num_cpu, metadata);
+	/*
+	 * Map Trace ID values to CPU metadata.
+	 *
+	 * Trace metadata will always contain Trace ID values from the legacy algorithm. If the
+	 * files has been recorded by a "new" perf updated to handle AUX_HW_ID then the metadata
+	 * ID value will also have the CORESIGHT_TRACE_ID_UNUSED_FLAG set.
+	 *
+	 * The updated kernel drivers that use AUX_HW_ID to sent Trace IDs will attempt to use
+	 * the same IDs as the old algorithm as far as is possible, unless there are clashes
+	 * in which case a different value will be used. This means an older perf may still
+	 * be able to record and read files generate on a newer system.
+	 *
+	 * For a perf able to interpret AUX_HW_ID packets we first check for the presence of
+	 * those packets. If they are there then the values will be mapped and plugged into
+	 * the metadata. We then set any remaining metadata values with the used flag to a
+	 * value CORESIGHT_TRACE_ID_UNUSED_VAL - which indicates no decoder is required.
+	 *
+	 * If no AUX_HW_ID packets are present - which means a file recorded on an old kernel
+	 * then we map Trace ID values to CPU directly from the metadata - clearing any unused
+	 * flags if present.
+	 */
+
+	/* first scan for AUX_OUTPUT_HW_ID records to map trace ID values to CPU metadata */
+	aux_hw_id_found = 0;
+	err = perf_session__peek_events(session, session->header.data_offset,
+					session->header.data_size,
+					cs_etm__process_aux_hw_id_cb, &aux_hw_id_found);
+	if (err)
+		goto err_delete_thread;
+
+	/* if HW ID found then clear any unused metadata ID values */
+	if (aux_hw_id_found)
+		err = cs_etm__clear_unused_trace_ids_metadata(num_cpu, metadata);
+	/* otherwise, this is a file with metadata values only, map from metadata */
+	else
+		err = cs_etm__map_trace_ids_metadata(num_cpu, metadata);
+
 	if (err)
 		goto err_delete_thread;
 
@@ -3027,14 +3245,6 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 		goto err_delete_thread;
 
 	etm->data_queued = etm->queues.populated;
-	/*
-	 * Print warning in pipe mode, see cs_etm__process_auxtrace_event() and
-	 * cs_etm__queue_aux_fragment() for details relating to limitations.
-	 */
-	if (!etm->data_queued)
-		pr_warning("CS ETM warning: Coresight decode and TRBE support requires random file access.\n"
-			   "Continuing with best effort decoding in piped mode.\n\n");
-
 	return 0;
 
 err_delete_thread:
-- 
2.17.1


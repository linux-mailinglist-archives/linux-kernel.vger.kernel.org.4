Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B5A636A2A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 20:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238254AbiKWTvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 14:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239253AbiKWTuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 14:50:52 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84609A248
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:50:35 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id b12so17219012wrn.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c7iQq8Mwt/sVGt6PN9rItSMb/+0oa1SfCa+MBO3Q6QM=;
        b=M0bjV8rEwQ0nb/04NtKRFTbuosTRUyqj5Dz63zdGOBZyrT8+fXmdIJDWaZlAiBiM/G
         TAl3/aRslPoAUnJHk4o+0VwHUvNz0doh30IsIG07HwIaxGEN1NpXWlzdFri6tYUN/2Y5
         tNpjTJprt5wy6N/7/FOAGQH2aS0yh80NqZn6sMhWmweR8b+jq8Bq8yFzIW4PPyq/hiAG
         hejR1AbRChCJ08OzpQI5w3W+3Kujcrjlon5sgE6puhAUQ1Yvqd7x6w8LLvCc9oLkBdTA
         SI+xURMzXfIEh7pmEV1f9mGbWF71lIj92AtbYgyRz3qe0Vbn9fOEHDNensT84fDRqriY
         qG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c7iQq8Mwt/sVGt6PN9rItSMb/+0oa1SfCa+MBO3Q6QM=;
        b=fBoEB0TZCwV9lrsUa/lQNebbwxipRXX+4Fuo7nmAGUvbEI0rHhtbPE6KYpmGVHZ4KI
         K1mIRJBTUTm1RLM3RgEoQ2oxSfS3+UH8BohVGB/HJeZgpRocRQCqmraJhZY7xbs0ykLY
         0fD5RduaPg35KUyhPOMFmfx6PitQrq3fYYSMwvaiFPr9/Lq4xw+kCJUO51UHqDKwa4bR
         i8qyblmh70sNsfWD0aN+5VzNqpE5g4+UV8PPItKj6wW3sIIIbgQsId3YRFTHTbzKSmLn
         RbLTmiJzZVe8k4mOBdMI0V7n7eVYQiS/yQEXzTAacFA3bmx2EYF/KIGkjwlu+CULlGyn
         LSuA==
X-Gm-Message-State: ANoB5pl0I4tn0qbIAETc8BhrnuvcKEbUCw3ss2Ou3UqXPch4IT/lupPu
        eHFaGPCBHutVaRbJ++rU7PWtSg==
X-Google-Smtp-Source: AA0mqf4jGOVGgTsz19QhFucoTA/yK6jVY0Z95PBi3iBmi6N3+okUKMfUHYytIGryyVCQYXhuShvXFQ==
X-Received: by 2002:adf:e50e:0:b0:241:cce2:1af with SMTP id j14-20020adfe50e000000b00241cce201afmr13180455wrm.615.1669233034130;
        Wed, 23 Nov 2022 11:50:34 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6809:2201:fcbc:7b5d:8d6c:43a4])
        by smtp.gmail.com with ESMTPSA id w5-20020a5d6805000000b002364c77bcacsm7267414wru.38.2022.11.23.11.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 11:50:33 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v6 12/14] perf: cs-etm: Handle PERF_RECORD_AUX_OUTPUT_HW_ID packet
Date:   Wed, 23 Nov 2022 19:50:08 +0000
Message-Id: <20221123195010.6859-13-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221123195010.6859-1-mike.leach@linaro.org>
References: <20221123195010.6859-1-mike.leach@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 tools/perf/util/cs-etm.c                      | 248 ++++++++++++++++--
 3 files changed, 251 insertions(+), 19 deletions(-)

diff --git a/tools/include/linux/coresight-pmu.h b/tools/include/linux/coresight-pmu.h
index 307f357defe9..57ba1abf1224 100644
--- a/tools/include/linux/coresight-pmu.h
+++ b/tools/include/linux/coresight-pmu.h
@@ -32,6 +32,9 @@
  */
 #define CORESIGHT_TRACE_ID_UNUSED_FLAG	BIT(31)
 
+/* Value to set for unused trace ID values */
+#define CORESIGHT_TRACE_ID_UNUSED_VAL	0x7F
+
 /*
  * Below are the definition of bit offsets for perf option, and works as
  * arbitrary values for all ETM versions.
@@ -56,4 +59,16 @@
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
index 31fa3b45134a..fa3aa9c0fb2e 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -625,6 +625,7 @@ cs_etm_decoder__create_etm_decoder(struct cs_etm_decoder_params *d_params,
 	switch (t_params->protocol) {
 	case CS_ETM_PROTO_ETMV3:
 	case CS_ETM_PROTO_PTM:
+		csid = (t_params->etmv3.reg_idr & CORESIGHT_TRACE_ID_VAL_MASK);
 		cs_etm_decoder__gen_etmv3_config(t_params, &config_etmv3);
 		decoder->decoder_name = (t_params->protocol == CS_ETM_PROTO_ETMV3) ?
 							OCSD_BUILTIN_DCD_ETMV3 :
@@ -632,11 +633,13 @@ cs_etm_decoder__create_etm_decoder(struct cs_etm_decoder_params *d_params,
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
@@ -645,6 +648,10 @@ cs_etm_decoder__create_etm_decoder(struct cs_etm_decoder_params *d_params,
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
index 11026c9694a4..f9f7d16a55d1 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -217,6 +217,143 @@ static int cs_etm__map_trace_id(u8 trace_chan_id, u64 *cpu_metadata)
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
@@ -2662,7 +2799,7 @@ static void cs_etm__print_auxtrace_info(__u64 *val, int num)
 	for (i = CS_HEADER_VERSION_MAX; cpu < num; cpu++) {
 		if (version == 0)
 			err = cs_etm__print_cpu_metadata_v0(val, &i);
-		else if (version == 1)
+		else if (version == 1 || version == 2)
 			err = cs_etm__print_cpu_metadata_v1(val, &i);
 		if (err)
 			return;
@@ -2774,11 +2911,16 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
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
@@ -2827,6 +2969,17 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
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
@@ -2916,13 +3069,13 @@ static int cs_etm__map_trace_ids_metadata(int num_cpu, u64 **metadata)
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
@@ -2935,6 +3088,35 @@ static int cs_etm__map_trace_ids_metadata(int num_cpu, u64 **metadata)
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
 int cs_etm__process_auxtrace_info(union perf_event *event,
 				  struct perf_session *session)
 {
@@ -2947,6 +3129,7 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 	int priv_size = 0;
 	int num_cpu;
 	int err = 0;
+	int aux_hw_id_found;
 	int i, j;
 	u64 *ptr, *hdr = NULL;
 	u64 **metadata = NULL;
@@ -3113,8 +3296,43 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
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
 
@@ -3123,14 +3341,6 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
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


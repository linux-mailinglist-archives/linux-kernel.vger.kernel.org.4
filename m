Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2276D1711
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 07:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjCaF45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 01:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjCaF4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 01:56:53 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BFBCA0B
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 22:56:52 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id o32so12212529wms.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 22:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680242210;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CN8DfD9U8GMw8UwynuZ4gSaHcXpLbm/7yrjRkMpLMUY=;
        b=nmAV4mHZSQQ//NrWdYm22T6CGrbFMsAOaGn3nTR0xQS6hrNMdEVcRfknJMTeNjMJnj
         3PBjMwka0CJ2SACyHaG3hP7ua8K2m7RgOo4niEa+kKx9IMBtpbWSPChvbZ2OGKMQLEKt
         lOFzmBTzSRoI/gknWeTK8bKgSZ/uQJNtRJNmJGp38y2wz8wXrDX0y/4dfIqoQExnPRKs
         bANjUDV0E+vVgT7wqGSINv6ta3luST7qYhU2iyjstJ5YsgAxcwwAdQo4cWc4Q6UEjZ/+
         nUMX1cMKuTnhKGhIv0bvYg/gBmjMwDF4snlneRkKlxwHmj1bsa6jk+LSdcCUTfuP5vsU
         f+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680242210;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CN8DfD9U8GMw8UwynuZ4gSaHcXpLbm/7yrjRkMpLMUY=;
        b=O62iEcAHcEUopAlaRiudKViuDb3v9W6avxw/IvfNhqoNUjHuGpySyO/uB/60zFct9V
         sw1GYMWngxlr+V8sDKF6bVVzNzvgjaYpBWY3yyl7UcWPD94bcU3PXdksmIXDZePAoBnh
         injs9VBKFi7fE0r1xuI6txZUf/YPGibEUZYi6K2fGMKQAQMuBObortmVpOSjCkbrZhO3
         xeX/Jnux8cm0vIk9Z8NByOrv5r2qKbCf5XgTW5Awt5G7uLzK4c5DNwNTfiILsGfBnszE
         h48boSKI6fyo1ToSbvKe8g/GjSJ4HzE66TZWz/4+yejqRI4+tProF8AP1sSsAELdQ7qj
         QL/g==
X-Gm-Message-State: AO0yUKUcvqkAUkoQ8KOMIp7/vLe6ChJeLHRHWuv10ZgQyNQiNk+XSyHk
        XGL1HEkiywjGSbJmf20zMDYFPA==
X-Google-Smtp-Source: AK7set+o7FU5uf15XSL2cEVdsfbnS+OQaJLoT+GlD+Lfz7VPX0XNC06tscv4lKJkoKXTkLO5lFzpcQ==
X-Received: by 2002:a05:600c:2049:b0:3df:e6bb:768 with SMTP id p9-20020a05600c204900b003dfe6bb0768mr18872961wmg.24.1680242210416;
        Thu, 30 Mar 2023 22:56:50 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:680a:d01:24d4:5fa:d4b2:7c14])
        by smtp.gmail.com with ESMTPSA id iz5-20020a05600c554500b003ef67ac3846sm8464055wmb.24.2023.03.30.22.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 22:56:49 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, acme@kernel.org
Cc:     suzuki.poulose@arm.com, leo.yan@linaro.org, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, gankulkarni@os.amperecomputing.com,
        darren@os.amperecomputing.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v9 1/3] perf: cs-etm: Move mapping of Trace ID and cpu into helper function
Date:   Fri, 31 Mar 2023 06:56:43 +0100
Message-Id: <20230331055645.26918-2-mike.leach@linaro.org>
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

The information to associate Trace ID and CPU will be changing.

Drivers will start outputting this as a hardware ID packet in the data
file which if present will be used in preference to the AUXINFO values.

To prepare for this we provide a helper functions to do the individual ID
mapping, and one to extract the IDs from the completed metadata blocks.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: James Clark <james.clark@arm.com>
Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 tools/include/linux/coresight-pmu.h |  5 ++
 tools/perf/util/cs-etm-base.c       |  3 +-
 tools/perf/util/cs-etm.c            | 92 +++++++++++++++++++----------
 tools/perf/util/cs-etm.h            | 14 ++++-
 4 files changed, 79 insertions(+), 35 deletions(-)

diff --git a/tools/include/linux/coresight-pmu.h b/tools/include/linux/coresight-pmu.h
index 6c2fd6cc5a98..db9c7c0abb6a 100644
--- a/tools/include/linux/coresight-pmu.h
+++ b/tools/include/linux/coresight-pmu.h
@@ -7,9 +7,14 @@
 #ifndef _LINUX_CORESIGHT_PMU_H
 #define _LINUX_CORESIGHT_PMU_H
 
+#include <linux/bits.h>
+
 #define CORESIGHT_ETM_PMU_NAME "cs_etm"
 #define CORESIGHT_ETM_PMU_SEED  0x10
 
+/* CoreSight trace ID is currently the bottom 7 bits of the value */
+#define CORESIGHT_TRACE_ID_VAL_MASK	GENMASK(6, 0)
+
 /*
  * Below are the definition of bit offsets for perf option, and works as
  * arbitrary values for all ETM versions.
diff --git a/tools/perf/util/cs-etm-base.c b/tools/perf/util/cs-etm-base.c
index 5f48b756c4cf..4abe416e3feb 100644
--- a/tools/perf/util/cs-etm-base.c
+++ b/tools/perf/util/cs-etm-base.c
@@ -148,7 +148,8 @@ static void cs_etm__print_auxtrace_info(u64 *val, int num)
 	for (i = CS_HEADER_VERSION_MAX; cpu < num; cpu++) {
 		if (version == 0)
 			err = cs_etm__print_cpu_metadata_v0(val, &i);
-		else if (version == 1)
+		/* printing same for both, but value bit flags added on v2 */
+		else if ((version == 1) || (version == 2))
 			err = cs_etm__print_cpu_metadata_v1(val, &i);
 		if (err)
 			return;
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index f65bac5ddbdb..5fc9c288080b 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -196,6 +196,30 @@ int cs_etm__get_pid_fmt(u8 trace_chan_id, u64 *pid_fmt)
 	return 0;
 }
 
+static int cs_etm__map_trace_id(u8 trace_chan_id, u64 *cpu_metadata)
+{
+	struct int_node *inode;
+
+	/* Get an RB node for this CPU */
+	inode = intlist__findnew(traceid_list, trace_chan_id);
+
+	/* Something went wrong, no need to continue */
+	if (!inode)
+		return -ENOMEM;
+
+	/*
+	 * The node for that CPU should not be taken.
+	 * Back out if that's the case.
+	 */
+	if (inode->priv)
+		return -EINVAL;
+
+	/* All good, associate the traceID with the metadata pointer */
+	inode->priv = cpu_metadata;
+
+	return 0;
+}
+
 void cs_etm__etmq_set_traceid_queue_timestamp(struct cs_etm_queue *etmq,
 					      u8 trace_chan_id)
 {
@@ -2804,17 +2828,46 @@ static bool cs_etm__has_virtual_ts(u64 **metadata, int num_cpu)
 	return true;
 }
 
+/* map trace ids to correct metadata block, from information in metadata */
+static int cs_etm__map_trace_ids_metadata(int num_cpu, u64 **metadata)
+{
+	u64 cs_etm_magic;
+	u8 trace_chan_id;
+	int i, err;
+
+	for (i = 0; i < num_cpu; i++) {
+		cs_etm_magic = metadata[i][CS_ETM_MAGIC];
+		switch (cs_etm_magic) {
+		case __perf_cs_etmv3_magic:
+			trace_chan_id = (u8)((metadata[i][CS_ETM_ETMTRACEIDR]) &
+					     CORESIGHT_TRACE_ID_VAL_MASK);
+			break;
+		case __perf_cs_etmv4_magic:
+		case __perf_cs_ete_magic:
+			trace_chan_id = (u8)((metadata[i][CS_ETMV4_TRCTRACEIDR]) &
+					      CORESIGHT_TRACE_ID_VAL_MASK);
+			break;
+		default:
+			/* unknown magic number */
+			return -EINVAL;
+		}
+		err = cs_etm__map_trace_id(trace_chan_id, metadata[i]);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
 int cs_etm__process_auxtrace_info_full(union perf_event *event,
 				       struct perf_session *session)
 {
 	struct perf_record_auxtrace_info *auxtrace_info = &event->auxtrace_info;
 	struct cs_etm_auxtrace *etm = NULL;
-	struct int_node *inode;
 	struct perf_record_time_conv *tc = &session->time_conv;
 	int event_header_size = sizeof(struct perf_event_header);
 	int total_size = auxtrace_info->header.size;
 	int priv_size = 0;
-	int num_cpu, trcidr_idx;
+	int num_cpu;
 	int err = 0;
 	int i, j;
 	u64 *ptr = NULL;
@@ -2853,23 +2906,13 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 				cs_etm__create_meta_blk(ptr, &i,
 							CS_ETM_PRIV_MAX,
 							CS_ETM_NR_TRC_PARAMS_V0);
-
-			/* The traceID is our handle */
-			trcidr_idx = CS_ETM_ETMTRACEIDR;
-
 		} else if (ptr[i] == __perf_cs_etmv4_magic) {
 			metadata[j] =
 				cs_etm__create_meta_blk(ptr, &i,
 							CS_ETMV4_PRIV_MAX,
 							CS_ETMV4_NR_TRC_PARAMS_V0);
-
-			/* The traceID is our handle */
-			trcidr_idx = CS_ETMV4_TRCTRACEIDR;
 		} else if (ptr[i] == __perf_cs_ete_magic) {
 			metadata[j] = cs_etm__create_meta_blk(ptr, &i, CS_ETE_PRIV_MAX, -1);
-
-			/* ETE shares first part of metadata with ETMv4 */
-			trcidr_idx = CS_ETMV4_TRCTRACEIDR;
 		} else {
 			ui__error("CS ETM Trace: Unrecognised magic number %#"PRIx64". File could be from a newer version of perf.\n",
 				  ptr[i]);
@@ -2881,26 +2924,6 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 			err = -ENOMEM;
 			goto err_free_metadata;
 		}
-
-		/* Get an RB node for this CPU */
-		inode = intlist__findnew(traceid_list, metadata[j][trcidr_idx]);
-
-		/* Something went wrong, no need to continue */
-		if (!inode) {
-			err = -ENOMEM;
-			goto err_free_metadata;
-		}
-
-		/*
-		 * The node for that CPU should not be taken.
-		 * Back out if that's the case.
-		 */
-		if (inode->priv) {
-			err = -EINVAL;
-			goto err_free_metadata;
-		}
-		/* All good, associate the traceID with the metadata pointer */
-		inode->priv = metadata[j];
 	}
 
 	/*
@@ -2994,6 +3017,11 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	if (err)
 		goto err_delete_thread;
 
+	/* before aux records are queued, need to map metadata to trace IDs */
+	err = cs_etm__map_trace_ids_metadata(num_cpu, metadata);
+	if (err)
+		goto err_delete_thread;
+
 	err = cs_etm__queue_aux_records(session);
 	if (err)
 		goto err_delete_thread;
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index 98a4f7113d2f..661f029322e4 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -29,13 +29,17 @@ enum {
 /*
  * Update the version for new format.
  *
- * New version 1 format adds a param count to the per cpu metadata.
+ * Version 1: format adds a param count to the per cpu metadata.
  * This allows easy adding of new metadata parameters.
  * Requires that new params always added after current ones.
  * Also allows client reader to handle file versions that are different by
  * checking the number of params in the file vs the number expected.
+ *
+ * Version 2: Drivers will use PERF_RECORD_AUX_OUTPUT_HW_ID to output
+ * CoreSight Trace ID. ...TRACEIDR metadata will be set to legacy values
+ * but with addition flags.
  */
-#define CS_HEADER_CURRENT_VERSION 1
+#define CS_HEADER_CURRENT_VERSION	2
 
 /* Beginning of header common to both ETMv3 and V4 */
 enum {
@@ -97,6 +101,12 @@ enum {
 	CS_ETE_PRIV_MAX
 };
 
+/*
+ * Check for valid CoreSight trace ID. If an invalid value is present in the metadata,
+ * then IDs are present in the hardware ID packet in the data file.
+ */
+#define CS_IS_VALID_TRACE_ID(id) ((id > 0) && (id < 0x70))
+
 /*
  * ETMv3 exception encoding number:
  * See Embedded Trace Macrocell specification (ARM IHI 0014Q)
-- 
2.17.1


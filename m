Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17B96CD83A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 13:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjC2LOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 07:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjC2LOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 07:14:30 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F403C3A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 04:14:29 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id r11so15230721wrr.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 04:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680088467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uyeaC58A8+FcF7+31cthC/QAU3d09tnBEAhOls9+jMA=;
        b=t1hrWO6mSG0d6cHckyWzOaz7eSChTXmumyoLFpk7QKqoucc2CqTjyu4x6/GfqKat7R
         kQM9IsFezJo6XOX0rUykx1pMtK0WhnHKDcftimkiL2AScGMcGE7BrfmLGMviYicuN0Sb
         pAxeEvVyOf4n2Y1hEdlRASeoEhkn6mfY/vgQwgFHIXvONF9jCQIEeBOUWBlEtP149ejX
         MAx0ALccZ+g4QT5uK6brfU/RNh9h8DZjzPloF++8TTqJ6tGBAVfMLjLAM4698wsp9ZpE
         p4FYF5hgNQEUXEEkHjiKTgMdav7XFe1mCU44gDWDJGrnD/b8IISr8KXxSEfvdBzJ3GOC
         XavA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680088467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uyeaC58A8+FcF7+31cthC/QAU3d09tnBEAhOls9+jMA=;
        b=2yiz1UIw/XV+gPP4rD+Ch4daHrkdzIK68LdPWR493ecOxYT+HBvd26wGUew1oCIIj6
         KHMOaOL96w4BMfjAf+Fw7z1M+wmyIYsEQ9/8CnT17YYCRi7juCRBS7mbBBHaC+A3uKar
         +0K+BV20sX6f2CwsmmbFro/1XjLQDw3H2DwTNE6MLyz4AhXiIfHkwEnFIqctwB53TsCj
         olBt2OO6iUmC7xqNmtznENg3+d3Bqg0EuPtMUHAIvI4qj+Q8Vt040DtokaqJcUmpHNVx
         nU+cx88WO8uIWUO5fRmtYBaUO/ze6rQjrgf+g1o9T+WeOJrCe5VAST7l5z81HI3K8r8D
         +tvw==
X-Gm-Message-State: AAQBX9c0yXyolFFdCP1egYzsO3yWnw5lYbG9L1mwbWHrmuT2gbbZZa8i
        iWPak9PVUejf9bq+SaDarlHZBQ==
X-Google-Smtp-Source: AKy350agfXWd8fY1+WNXH3qljjjJFzUR+5sz6Zi6JSA7CJUTx6TWOs48IZBqWbxD0T6HfWbMWvp9dQ==
X-Received: by 2002:a5d:51c1:0:b0:2cf:ef9d:16a5 with SMTP id n1-20020a5d51c1000000b002cfef9d16a5mr14792134wrv.18.1680088467397;
        Wed, 29 Mar 2023 04:14:27 -0700 (PDT)
Received: from linaro.org (host86-131-79-192.range86-131.btcentralplus.com. [86.131.79.192])
        by smtp.gmail.com with ESMTPSA id m6-20020a056000008600b002cde25fba30sm30067163wrx.1.2023.03.29.04.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 04:14:26 -0700 (PDT)
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
Subject: [PATCH v8 1/3] perf: cs-etm: Move mapping of Trace ID and cpu into helper function
Date:   Wed, 29 Mar 2023 12:14:20 +0100
Message-Id: <20230329111422.3693-2-mike.leach@linaro.org>
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
 tools/perf/util/cs-etm.c            | 91 +++++++++++++++++++----------
 tools/perf/util/cs-etm.h            | 14 ++++-
 3 files changed, 77 insertions(+), 33 deletions(-)

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
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index f65bac5ddbdb..f6ca07f68b25 100644
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
@@ -2804,6 +2828,36 @@ static bool cs_etm__has_virtual_ts(u64 **metadata, int num_cpu)
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
@@ -2814,7 +2868,7 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	int event_header_size = sizeof(struct perf_event_header);
 	int total_size = auxtrace_info->header.size;
 	int priv_size = 0;
-	int num_cpu, trcidr_idx;
+	int num_cpu;
 	int err = 0;
 	int i, j;
 	u64 *ptr = NULL;
@@ -2853,23 +2907,13 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
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
@@ -2881,26 +2925,6 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
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
@@ -2994,6 +3018,11 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
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
index 98a4f7113d2f..6d3078e042b4 100644
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
+ * CoreSight Trace ID. ...TRACEIDR metadata will be set to unused ID.
  */
-#define CS_HEADER_CURRENT_VERSION 1
+#define CS_HEADER_CURRENT_VERSION	2
+#define CS_AUX_HW_ID_VERSION_MIN	2
 
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
2.32.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD7E66BE2C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 13:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjAPMug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 07:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjAPMtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 07:49:47 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119BE1E5E1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:49:44 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id o15so19899731wmr.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XPvSQ2akOg9lVFYLsk36HR8GI0OejzxG35eUcUs1NTE=;
        b=Go7EpvZDL5KdZqJRSWvi42j/10yJvz5yCDa9bfWfx+cuKLlgINAjC06DMTOFEw0DG7
         7ee+Uhm2/Gsn/wWBhIVdnk02W1d/i3hQom7RFg0tIj5kWE3v2CLwZNDGhGNsqnMqKbh7
         3/mvGkL7FG5ZyVoeebkBPGBorTP5KT63AdtuXTllWpJ4lgrJSi28SMQSmgbT/dWCWLOK
         0UctEviq7fW2q95SUD4rYRHdyxdr8WyvdfpcM2pPRHz6zcpI2SIR9aDC5q7oLT9cViDF
         n+EMYzgC3TrGun2KXtho4Xt1DBwHxqDpl2+AI6SNzMAll4F7/zHHYdjE7mkxtk2U8lQf
         oygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XPvSQ2akOg9lVFYLsk36HR8GI0OejzxG35eUcUs1NTE=;
        b=nJXZnJa4l4JUizGPPxwFpv6CzwRo5BCSFCxg6cbBWeO9PNcJJi0HaVD9sOlh0Dar+r
         l6xSmABbVTvaCAWFVTP9eFB7ZQTSgF0sYTIIjonZJ3yjrj5FogOBucFYEOzE4EVm4Mj+
         yE1tGA83QFtAeZz5jsQmp5vARxSsYf8eKUCATJ04gxlkWSepZ8tWOD2WboEhSNlqZkzW
         vgt3EzhyCsLIpignBqygsextcwHOI/s8N5ZSt/xIkgdpnij4vmKpALxeIFVRTfTXzJU+
         24+93knPyZ05aaAQccBR5OShNuaNFtVX36+Lwy7KAs2SrSbv+2tm7epKldMdLUyYW5Ij
         aSPg==
X-Gm-Message-State: AFqh2ko12Vj3gEq3N7ib8pGbZ8QIpNGk9si+tZlqUyc5zAIGakDklTis
        6JTznBU1yDHz03ZU4wXAjokUTg==
X-Google-Smtp-Source: AMrXdXuMijzCQsuEGb76/3RaU/WnZPbQFRAea6UQVFgxT5XQIU2RuuBD1XvdK5GHtEYcwetepCmbDQ==
X-Received: by 2002:a7b:c302:0:b0:3d3:5c9e:6b27 with SMTP id k2-20020a7bc302000000b003d35c9e6b27mr8152556wmj.12.1673873384375;
        Mon, 16 Jan 2023 04:49:44 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6809:2201:6c91:710d:9433:e868])
        by smtp.gmail.com with ESMTPSA id fl12-20020a05600c0b8c00b003dab40f9eafsm6896832wmb.35.2023.01.16.04.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 04:49:43 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v7 09/15] perf: cs-etm: Move mapping of Trace ID and cpu into helper function
Date:   Mon, 16 Jan 2023 12:49:22 +0000
Message-Id: <20230116124928.5440-10-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230116124928.5440-1-mike.leach@linaro.org>
References: <20230116124928.5440-1-mike.leach@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 33303d03c2fa..f77260b9253e 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -193,6 +193,30 @@ int cs_etm__get_pid_fmt(u8 trace_chan_id, u64 *pid_fmt)
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
@@ -2746,6 +2770,36 @@ static int cs_etm__queue_aux_records(struct perf_session *session)
 	return 0;
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
@@ -2755,7 +2809,7 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	int event_header_size = sizeof(struct perf_event_header);
 	int total_size = auxtrace_info->header.size;
 	int priv_size = 0;
-	int num_cpu, trcidr_idx;
+	int num_cpu;
 	int err = 0;
 	int i, j;
 	u64 *ptr = NULL;
@@ -2794,23 +2848,13 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
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
@@ -2822,26 +2866,6 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
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
@@ -2919,6 +2943,11 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
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
index 5da50d5dae6b..e0a5eb1f3ce7 100644
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
@@ -86,6 +90,12 @@ enum {
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2389966BE31
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 13:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjAPMvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 07:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjAPMuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 07:50:22 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509911F5C1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:49:50 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id bi26-20020a05600c3d9a00b003d3404a89faso3757132wmb.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yRqldm/FdfNyFbQj65h6UroAtQ4UGZzHEB+lTVOfKUo=;
        b=RTazewCDt7PYy4w/Wc5EYm3tsrt6KRpq2PkaAVUcWur8/UQtzYyyx+vg/1Ty6bkU6J
         rKXhstIpe7q7oRTp/E2S1u5RX8c9oRu1P9EWE9qVc6RY/9ARmVYwm9zbjOjfUzcw7M9L
         U+dkulDVVKrmO6k3lsDxZhkdnVUuOxiEHlYAoArnZ7AO/dDAw+UGI2Ywy2m9xesjdEdG
         jkCqpFDCT4uNcZB7aqya3x96sm5cYzXPMuPPiWTnuFmOEjLPCAOxal56mdUXfejySDnB
         Ppq+TWhoIC+TFHLruaIPKS4EdxuUnFe95o2F/Q5yKdpvOYbOrh4pPOYfiJ1UebTeqzEY
         lPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yRqldm/FdfNyFbQj65h6UroAtQ4UGZzHEB+lTVOfKUo=;
        b=i5G6+KX/Qw6RLGYxyV/CLO1vjlYfuWz+iUCdhSmXxQ6oOTT5WfEX0IGj8vBACevH0z
         zV+COpRSzKhAfQqWdx9N+a2NvNezgHgwxmhSTZEgCb2j4SnS8gcB3bVxY5W6oiLNO/nF
         rgJ8iIGDPiZQTcPGWOF5E452ioOPkeieDJ/MSS3ioivfug7P1nhIYW2IYFzRiJXvQDjO
         /nQXWyKVuXX7UICQ2scDWxRTh+itI8vScLnoTOSDT1fSp6WmRSU9SM+8UfmohPUQ7iGy
         8nVLA9SOxaRtk6DTGRByA5lgU7/N1Y+fMjhpDxAE2KoDJ0imS2dp+fTSMF3IIhAhHBQh
         lt3A==
X-Gm-Message-State: AFqh2kpQB/8jihbbJFpHYzcScCTN9oSTU0WXmtltqftzhqRNPOGBFdaj
        RTAaJFoZnus4/u4cmvRW7FfATg==
X-Google-Smtp-Source: AMrXdXs43SWhFn/7m7DB3+ZNzDpjKw8fEfKEbJIvF7MMXBjE24bq6qlX3joVhBO59EKBEtc41Glqcw==
X-Received: by 2002:a05:600c:8505:b0:3da:f89:bc46 with SMTP id gw5-20020a05600c850500b003da0f89bc46mr15180383wmb.17.1673873388912;
        Mon, 16 Jan 2023 04:49:48 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6809:2201:6c91:710d:9433:e868])
        by smtp.gmail.com with ESMTPSA id fl12-20020a05600c0b8c00b003dab40f9eafsm6896832wmb.35.2023.01.16.04.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 04:49:48 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v7 13/15] coresight: events: PERF_RECORD_AUX_OUTPUT_HW_ID used for Trace ID
Date:   Mon, 16 Jan 2023 12:49:26 +0000
Message-Id: <20230116124928.5440-14-mike.leach@linaro.org>
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

Use the perf_report_aux_output_id() call to output the CoreSight trace ID
and associated CPU as a PERF_RECORD_AUX_OUTPUT_HW_ID record in the
perf.data file.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c |  7 +++++++
 include/linux/coresight-pmu.h                    | 14 ++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index bdb9ab86173a..12fff661456e 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -4,6 +4,7 @@
  * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
  */
 
+#include <linux/bitfield.h>
 #include <linux/coresight.h>
 #include <linux/coresight-pmu.h>
 #include <linux/cpumask.h>
@@ -448,6 +449,7 @@ static void etm_event_start(struct perf_event *event, int flags)
 	struct perf_output_handle *handle = &ctxt->handle;
 	struct coresight_device *sink, *csdev = per_cpu(csdev_src, cpu);
 	struct list_head *path;
+	u64 hw_id;
 
 	if (!csdev)
 		goto fail;
@@ -493,6 +495,11 @@ static void etm_event_start(struct perf_event *event, int flags)
 	if (source_ops(csdev)->enable(csdev, event, CS_MODE_PERF))
 		goto fail_disable_path;
 
+	/* output cpu / trace ID in perf record */
+	hw_id = FIELD_PREP(CS_AUX_HW_ID_VERSION_MASK, CS_AUX_HW_ID_CURR_VERSION);
+	hw_id |= FIELD_PREP(CS_AUX_HW_ID_TRACE_ID_MASK, coresight_trace_id_read_cpu_id(cpu));
+	perf_report_aux_output_id(event, hw_id);
+
 out:
 	/* Tell the perf core the event is alive */
 	event->hw.state = 0;
diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
index 624f4843453e..51ac441a37c3 100644
--- a/include/linux/coresight-pmu.h
+++ b/include/linux/coresight-pmu.h
@@ -7,6 +7,8 @@
 #ifndef _LINUX_CORESIGHT_PMU_H
 #define _LINUX_CORESIGHT_PMU_H
 
+#include <linux/bits.h>
+
 #define CORESIGHT_ETM_PMU_NAME "cs_etm"
 
 /*
@@ -43,4 +45,16 @@
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
-- 
2.17.1


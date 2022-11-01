Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEA4614F55
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 17:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbiKAQcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 12:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiKAQbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 12:31:38 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C6D1CB26
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 09:31:37 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id bk15so20854322wrb.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 09:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/OkoZY2NT7ICxt6pxMECbhZ/ZuX+9qnqpKwLzS1JpjA=;
        b=EhKSmM7wPBsoMr34pTYH6e/an7N4hbVBb7+MUj8exfJTgPvysY4/RZ/sDw+5OrBp1p
         EynSFNVHCstaJbQYy2hP8Q7iA4BNFO8Qqeqth5aS0bVBLkskG/uYguNwOC9a8Q4YisQE
         dNbMTLuWaz1AWw2EzmmCfquCOG7n0z3+B/z9biojkID7rdx+Fl9abdhOKSUelYVcJGvY
         lGKrxIyztTx4DtiWTH8bPyeK93ov/+WlRt8zkm+qWoJ2f0oTSc6yIzOOuc5hEisQFouO
         ISJjntj9pUl484uzl2EoFCqW/83vLno6cGnH7KOx965AsNVq/1uX84YS8DSnu+UFvJH+
         FReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/OkoZY2NT7ICxt6pxMECbhZ/ZuX+9qnqpKwLzS1JpjA=;
        b=VCh/sbljnWo5Ury9oVYnNBYNXWwu74s2ZkwD5fh34RegltlYu1/JF1jHefPxfL4bT6
         QVRhai2tS3qiI7miRffMPS/NJk2xoLQdbsFsyWSLfXOdiiSZ3EwyPPnO2oqDAgqqYp6M
         68t776XWfITfcxoQuvNjTZa5v1HZJ7iG8VSSUTxWRbfQJq4Mluhar7zYwagQydqXoTVB
         f/NtZWPg5wan55SkC+bHQMH0SHZpOFOdcO/qMGP50LI4BUD+a2xQQQDdlIL4Rr/wLtS9
         7jM84X8EeDBtD64QoVjtKUjBLFgrtLrUJKX56zgTqMgzvWmMQsvS77in5pHhCHKNaC+T
         B3Hw==
X-Gm-Message-State: ACrzQf0rWC9sP77Ps+Nkc2FfF2MgBECTgmuFjUYzdjHM4yIHKw/1E3xT
        kxCxzP3AFdLCYrwGfa9AGWVxwA==
X-Google-Smtp-Source: AMsMyM77kln0fy1pQKA4tkqa0x+IGaKF48rLr+qQuFCXC+pvHrgYTw/Zh+Allkx6uCVtggLlSPQBWA==
X-Received: by 2002:a5d:5d09:0:b0:236:c650:e449 with SMTP id ch9-20020a5d5d09000000b00236c650e449mr8682046wrb.406.1667320296126;
        Tue, 01 Nov 2022 09:31:36 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:e844:18b6:fc5:bbc9])
        by smtp.gmail.com with ESMTPSA id bu15-20020a056000078f00b0022ac1be009esm8339844wrb.16.2022.11.01.09.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 09:31:35 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v5 13/14] coresight: events: PERF_RECORD_AUX_OUTPUT_HW_ID used for Trace ID
Date:   Tue,  1 Nov 2022 16:31:02 +0000
Message-Id: <20221101163103.17921-14-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221101163103.17921-1-mike.leach@linaro.org>
References: <20221101163103.17921-1-mike.leach@linaro.org>
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
---
 drivers/hwtracing/coresight/coresight-etm-perf.c |  7 +++++++
 include/linux/coresight-pmu.h                    | 14 ++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 6166f716a6ac..59a2ad95c1dc 100644
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
+	hw_id = FIELD_PREP(CS_AUX_HW_ID_VERSION_MASK, CS_AUX_HW_ID_CURR_VERSION) |
+		FIELD_PREP(CS_AUX_HW_ID_TRACE_ID_MASK, coresight_trace_id_read_cpu_id(cpu));
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


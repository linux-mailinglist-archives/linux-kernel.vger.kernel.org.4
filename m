Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D00614F54
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 17:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbiKAQcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 12:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiKAQbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 12:31:39 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE351CFEF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 09:31:38 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id m29-20020a05600c3b1d00b003c6bf423c71so13125314wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 09:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0n8UTexiHKIiqpxO27R+y1dDLs4IJMQEzjh508MgLvo=;
        b=yaj1GT32R5YeT6PCGvU+3mT8rNJSC2qLIIbQHgC/BYUsqpkbq1Q9VSRJ8UmoLUSoD2
         Y4zYirTlhSw973T18+XGoErAjVFlm+URZAAw16Vp8ZJK0Hm07xZcDvp2co/a7923PPw4
         ZDn4ALybUlW5O+TeiKNNHXg7HBckGDWJR0fsh1jEWwAHNWR9zz4ohgYkBRbVIRSe725T
         nh8joBpErWRxBScyuAGRawcbFq0EUHA3wvhoYjuoLsPKeaM6D4Ba42byW+et+dgTfprl
         zDV/SclwnF0gH3yiDUPcCSlwymVjcqSq9wZgWW0A3AT/QyUqQeeJOXw1IrCYaVbMWiYX
         0Q5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0n8UTexiHKIiqpxO27R+y1dDLs4IJMQEzjh508MgLvo=;
        b=tTQqrlfclxETAFelhpISH1xYNxTdijzUAmW2q+Wm0NigQgjnovnEoeU6d9yS1WbrPu
         CUPXN5fIs5UBZuMKG9scWi/L+FJ50hn0z6NVVHBgVq2AUddNdvvJstaI/CNozGsjmERl
         aWL1Q458IiGeHhmPcNYIE2Pwa085tp5k4iZbGgcYP68SGmLkO5FwsdL6d0GJR9nbjnKp
         o1FLJzg5BBM/HiuBppA4CeXkaClNu5bKQ5lW6y0dcLQ03coO9WwHHaH/bgKJBbHUOU3V
         /iOfMs5wu8gspLXNr8lkJGdUW6R55l77JtcLZvsdYErdfiqUL3n6ukp+npLy+8CbUDJs
         Xblw==
X-Gm-Message-State: ACrzQf3OCR7tGUTSMcShI9xCwMOXZiPeiDfF9a/AYfI2zEuZ2EwIvIht
        AxooYS1UkaIRsgQzQ1EsyGJycw==
X-Google-Smtp-Source: AMsMyM4Td2SohI4rtM2aYnAYL9xu3OhzOuaYsV6jOlUYEi0LO0g3cWi4idU+LyzhGQO2ByBb4fwQ0g==
X-Received: by 2002:a7b:c341:0:b0:3c4:552d:2ea7 with SMTP id l1-20020a7bc341000000b003c4552d2ea7mr12813263wmj.82.1667320297696;
        Tue, 01 Nov 2022 09:31:37 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:e844:18b6:fc5:bbc9])
        by smtp.gmail.com with ESMTPSA id bu15-20020a056000078f00b0022ac1be009esm8339844wrb.16.2022.11.01.09.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 09:31:36 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v5 14/14] coresight: trace-id: Add debug & test macros to Trace ID allocation
Date:   Tue,  1 Nov 2022 16:31:03 +0000
Message-Id: <20221101163103.17921-15-mike.leach@linaro.org>
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

Adds in a number of pr_debug macros to allow the debugging and test of
the trace ID allocation system.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 .../hwtracing/coresight/coresight-trace-id.c  | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-trace-id.c b/drivers/hwtracing/coresight/coresight-trace-id.c
index 8e05a244c9d6..1588bad60715 100644
--- a/drivers/hwtracing/coresight/coresight-trace-id.c
+++ b/drivers/hwtracing/coresight/coresight-trace-id.c
@@ -64,6 +64,27 @@ static void coresight_trace_id_set_pend_rel(int id, struct coresight_trace_id_ma
 	set_bit(id, id_map->pend_rel_ids);
 }
 
+/* #define TRACE_ID_DEBUG 1 */
+#ifdef TRACE_ID_DEBUG
+
+static void coresight_trace_id_dump_table(struct coresight_trace_id_map *id_map,
+					  const char *func_name)
+{
+	pr_debug("%s id_map::\n", func_name);
+	pr_debug("Avial= %*pb\n", CORESIGHT_TRACE_IDS_MAX, id_map->used_ids);
+	pr_debug("Pend = %*pb\n", CORESIGHT_TRACE_IDS_MAX, id_map->pend_rel_ids);
+}
+#define DUMP_ID_MAP(map)   coresight_trace_id_dump_table(map, __func__)
+#define DUMP_ID_CPU(cpu, id) pr_debug("%s called;  cpu=%d, id=%d\n", __func__, cpu, id)
+#define DUMP_ID(id)   pr_debug("%s called; id=%d\n", __func__, id)
+#define PERF_SESSION(n) pr_debug("%s perf count %d\n", __func__, n)
+#else
+#define DUMP_ID_MAP(map)
+#define DUMP_ID(id)
+#define DUMP_ID_CPU(cpu, id)
+#define PERF_SESSION(n)
+#endif
+
 /* release all pending IDs for all current maps & clear CPU associations */
 static void coresight_trace_id_release_all_pending(void)
 {
@@ -81,6 +102,7 @@ static void coresight_trace_id_release_all_pending(void)
 		clear_bit(cpu, cpu_id_release_pending);
 	}
 	spin_unlock_irqrestore(&id_map_lock, flags);
+	DUMP_ID_MAP(id_map);
 }
 
 static int coresight_trace_id_map_get_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
@@ -120,6 +142,8 @@ static int coresight_trace_id_map_get_cpu_id(int cpu, struct coresight_trace_id_
 get_cpu_id_out_unlock:
 	spin_unlock_irqrestore(&id_map_lock, flags);
 
+	DUMP_ID_CPU(cpu, id);
+	DUMP_ID_MAP(id_map);
 	return id;
 }
 
@@ -146,6 +170,8 @@ static void coresight_trace_id_map_put_cpu_id(int cpu, struct coresight_trace_id
 	}
 
 	spin_unlock_irqrestore(&id_map_lock, flags);
+	DUMP_ID_CPU(cpu, id);
+	DUMP_ID_MAP(id_map);
 }
 
 static int coresight_trace_id_map_get_system_id(struct coresight_trace_id_map *id_map)
@@ -157,6 +183,8 @@ static int coresight_trace_id_map_get_system_id(struct coresight_trace_id_map *i
 	id = coresight_trace_id_alloc_new_id(id_map, 0);
 	spin_unlock_irqrestore(&id_map_lock, flags);
 
+	DUMP_ID(id);
+	DUMP_ID_MAP(id_map);
 	return id;
 }
 
@@ -167,6 +195,9 @@ static void coresight_trace_id_map_put_system_id(struct coresight_trace_id_map *
 	spin_lock_irqsave(&id_map_lock, flags);
 	coresight_trace_id_free(id, id_map);
 	spin_unlock_irqrestore(&id_map_lock, flags);
+
+	DUMP_ID(id);
+	DUMP_ID_MAP(id_map);
 }
 
 /* API functions */
@@ -204,6 +235,7 @@ EXPORT_SYMBOL_GPL(coresight_trace_id_put_system_id);
 void coresight_trace_id_perf_start(void)
 {
 	atomic_inc(&perf_cs_etm_session_active);
+	PERF_SESSION(atomic_read(&perf_cs_etm_session_active));
 }
 EXPORT_SYMBOL_GPL(coresight_trace_id_perf_start);
 
@@ -211,6 +243,7 @@ void coresight_trace_id_perf_stop(void)
 {
 	if (!atomic_dec_return(&perf_cs_etm_session_active))
 		coresight_trace_id_release_all_pending();
+	PERF_SESSION(atomic_read(&perf_cs_etm_session_active));
 }
 EXPORT_SYMBOL_GPL(coresight_trace_id_perf_stop);
 
-- 
2.17.1


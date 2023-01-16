Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889EC66BE30
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 13:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjAPMvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 07:51:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjAPMu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 07:50:27 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746D21E5F7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:49:51 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id j16-20020a05600c1c1000b003d9ef8c274bso17711855wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7MmfeWQlT78drM8G0hOv804O+RJ2l1J7iO54NF0OyN8=;
        b=OG+yCtYVzaQodpp5T6SUkXT2vd5myZOrMNCUDO5yrofj+CGODUYrK/8xI2hIp2nRbd
         E3Qq3SKmVuG+EOosLDSbpA0nq0UX9H+BQsRsKPwcD7qNj/VYgANq7lQk+30QVWq7kGEq
         JTc6kL0nLQB0xTQi45E2H9rghaTildWKHE1gafYtESWuVhpRLSqSabilgprKvnVYnh9M
         WAIMERBv3Q7oLhafwPGM0UrRIwi4oiV/h9A2kQqA1OKRxfUgKMgdYJ5VoWF9+TIc0+pv
         LDx/4nUnQapRddV0hle2h4RW7Xt6fJQQWHWhkhqoVD4Dg/CYyayBTgzG16XkrIQwMe9D
         WO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7MmfeWQlT78drM8G0hOv804O+RJ2l1J7iO54NF0OyN8=;
        b=ywqnucPs1Km9FDanznpXLAyU/YXt47c3yySSclp3y4YvQ+kMg/fGCkDv9fObjNIocU
         EhIi52rdtf28Ann+Ofd22GBicGobRUrimMuqxz2XoZwzDERzVeFlt53PczCVCEluemvk
         WuHEHUzFdPU8Ag4iznjGtaK0oaS1jXS69TH2GVtIRccVM+JvrfYmrnak9DK3azjCYipk
         BN4FGVTHMUDJAEJKfT+JMTthxbBbghChgZwJoGKWPg/4yqwcfV3LbBFidXqwv9S3Yrdn
         yTD+g1GZFVOkpHFczBlTnlsl12aKBiiCDVy7mFtb3SV8jKI3ec4nkMdZDBc4vBEsGIih
         s6Qg==
X-Gm-Message-State: AFqh2kqa7EkX3S1+3I9k7s/IHlPPXL3Plxb/CIGJbz4V7qtgbUPjPotT
        4Qomi/qBUsabk3tclqzK6dHZ1w==
X-Google-Smtp-Source: AMrXdXsUtzGA3B42oEx1FBsS5xtHjmaXQ/esRd6b013xNmvEMEa51m+oASURT2mCnf/3KE+2CMsiMw==
X-Received: by 2002:a05:600c:35d6:b0:3da:17f5:57b9 with SMTP id r22-20020a05600c35d600b003da17f557b9mr13228767wmq.5.1673873390001;
        Mon, 16 Jan 2023 04:49:50 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6809:2201:6c91:710d:9433:e868])
        by smtp.gmail.com with ESMTPSA id fl12-20020a05600c0b8c00b003dab40f9eafsm6896832wmb.35.2023.01.16.04.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 04:49:49 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v7 14/15] coresight: trace-id: Add debug & test macros to Trace ID allocation
Date:   Mon, 16 Jan 2023 12:49:27 +0000
Message-Id: <20230116124928.5440-15-mike.leach@linaro.org>
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

Adds in a number of pr_debug macros to allow the debugging and test of
the trace ID allocation system.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 .../hwtracing/coresight/coresight-trace-id.c  | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-trace-id.c b/drivers/hwtracing/coresight/coresight-trace-id.c
index 9b85c376cb12..367bbfb4c213 100644
--- a/drivers/hwtracing/coresight/coresight-trace-id.c
+++ b/drivers/hwtracing/coresight/coresight-trace-id.c
@@ -24,6 +24,27 @@ static atomic_t perf_cs_etm_session_active = ATOMIC_INIT(0);
 /* lock to protect id_map and cpu data  */
 static DEFINE_SPINLOCK(id_map_lock);
 
+/* #define TRACE_ID_DEBUG 1 */
+#if defined(TRACE_ID_DEBUG) || defined(CONFIG_COMPILE_TEST)
+
+static void coresight_trace_id_dump_table(struct coresight_trace_id_map *id_map,
+					  const char *func_name)
+{
+	pr_debug("%s id_map::\n", func_name);
+	pr_debug("Used = %*pb\n", CORESIGHT_TRACE_IDS_MAX, id_map->used_ids);
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
 /* unlocked read of current trace ID value for given CPU */
 static int _coresight_trace_id_read_cpu_id(int cpu)
 {
@@ -127,6 +148,7 @@ static void coresight_trace_id_release_all_pending(void)
 		cpumask_clear_cpu(cpu, &cpu_id_release_pending);
 	}
 	spin_unlock_irqrestore(&id_map_lock, flags);
+	DUMP_ID_MAP(id_map);
 }
 
 static int coresight_trace_id_map_get_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
@@ -168,6 +190,8 @@ static int coresight_trace_id_map_get_cpu_id(int cpu, struct coresight_trace_id_
 get_cpu_id_out_unlock:
 	spin_unlock_irqrestore(&id_map_lock, flags);
 
+	DUMP_ID_CPU(cpu, id);
+	DUMP_ID_MAP(id_map);
 	return id;
 }
 
@@ -194,6 +218,8 @@ static void coresight_trace_id_map_put_cpu_id(int cpu, struct coresight_trace_id
 	}
 
 	spin_unlock_irqrestore(&id_map_lock, flags);
+	DUMP_ID_CPU(cpu, id);
+	DUMP_ID_MAP(id_map);
 }
 
 static int coresight_trace_id_map_get_system_id(struct coresight_trace_id_map *id_map)
@@ -206,6 +232,8 @@ static int coresight_trace_id_map_get_system_id(struct coresight_trace_id_map *i
 	id = coresight_trace_id_alloc_new_id(id_map, 0, true);
 	spin_unlock_irqrestore(&id_map_lock, flags);
 
+	DUMP_ID(id);
+	DUMP_ID_MAP(id_map);
 	return id;
 }
 
@@ -216,6 +244,9 @@ static void coresight_trace_id_map_put_system_id(struct coresight_trace_id_map *
 	spin_lock_irqsave(&id_map_lock, flags);
 	coresight_trace_id_free(id, id_map);
 	spin_unlock_irqrestore(&id_map_lock, flags);
+
+	DUMP_ID(id);
+	DUMP_ID_MAP(id_map);
 }
 
 /* API functions */
@@ -253,6 +284,7 @@ EXPORT_SYMBOL_GPL(coresight_trace_id_put_system_id);
 void coresight_trace_id_perf_start(void)
 {
 	atomic_inc(&perf_cs_etm_session_active);
+	PERF_SESSION(atomic_read(&perf_cs_etm_session_active));
 }
 EXPORT_SYMBOL_GPL(coresight_trace_id_perf_start);
 
@@ -260,6 +292,7 @@ void coresight_trace_id_perf_stop(void)
 {
 	if (!atomic_dec_return(&perf_cs_etm_session_active))
 		coresight_trace_id_release_all_pending();
+	PERF_SESSION(atomic_read(&perf_cs_etm_session_active));
 }
 EXPORT_SYMBOL_GPL(coresight_trace_id_perf_stop);
 
-- 
2.17.1


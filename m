Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF29A614F4D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 17:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiKAQcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 12:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiKAQbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 12:31:31 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF271CFED
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 09:31:25 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id i5-20020a1c3b05000000b003cf47dcd316so13094659wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 09:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2aaVV6pFHQQs3G0gqxThN1mgpQWRGOin990n6a0ouVg=;
        b=jZGfZj+rM3bPcMkMrDpWSq3/FcMrUDQpjptYvoqs3gDmYbbHjyRXEWxumCyDuEcLJr
         /QCkNRwZ0wgMqi8WCS9WmVAWERSDnpCol2QKgomWIDYj3Ri2wTgtZ3LZLGXFQ+kQvm0y
         Cht60DMMbw2fGvH8A5qGjzPK+PIE8cuBHNK1wVHLJE5scZCvZ9q5kh49IwmC5tema/Mh
         pCl1MYhlvla2pSBK0krCbS6idHxlZKg6kpkSgHUZ2CeZ7rjIPZiKjxILkOVDMU8Ca8cm
         HunKsVmh+WKMIvDCdhX630Gcxz0x0tol8UGxzTfbEkBCk2IiqSrb5UHPBviHzIU99cil
         9cxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2aaVV6pFHQQs3G0gqxThN1mgpQWRGOin990n6a0ouVg=;
        b=O0JSguiyn4DPdcjm+Jx3wxgMGtZuN3ToukOlqNeqxami4imF77JGcrT4d/lVgnUUZa
         r3f0A5517UwP7yxV1M8BBzkxAu7aRu8GiFzyRdUTgDX8G7HsS0Fvmq1tazIixw1pk4gp
         FMkK2Q4YtsG/wNpLYv7x1FGtQ1K/MksR38JRr82f4RiUp9FgOEwvb1xksw/bDm8LXBVG
         mihoF52tQ1H+iCY5IhYz5q7WBivAkO5r8L4aIaYL703acsJr+SakSTbtumle7WYSKCvj
         GCVDPExzFrOktL63T/raYxjmrY5c2CevwGKOqEntKuDJiQK5nvjlIvmQHU2U2TBYEIMC
         NwBg==
X-Gm-Message-State: ACrzQf1t66VQLk3Ns7WxHNqd4c5aMF0Y4fwKOHx84hVJpedHXZZPoPiK
        XRz55aLbcDMiMVrPgesZ6kejCg==
X-Google-Smtp-Source: AMsMyM6dh88kPLl+NvzXxrgse3p39GCv8Ek8adzfOcmlQka455lVxS4FRvQtPCzyHjhV2uvhchoy4w==
X-Received: by 2002:a05:600c:1e2a:b0:3c8:353b:253f with SMTP id ay42-20020a05600c1e2a00b003c8353b253fmr12596910wmb.51.1667320284399;
        Tue, 01 Nov 2022 09:31:24 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:e844:18b6:fc5:bbc9])
        by smtp.gmail.com with ESMTPSA id bu15-20020a056000078f00b0022ac1be009esm8339844wrb.16.2022.11.01.09.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 09:31:23 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v5 03/14] coresight: perf: traceid: Add perf ID allocation and notifiers
Date:   Tue,  1 Nov 2022 16:30:52 +0000
Message-Id: <20221101163103.17921-4-mike.leach@linaro.org>
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

Adds in calls to allocate and release Trace ID for the CPUs in use
by the perf session.

Adds in notifier calls to the trace ID allocator that perf
events are starting and stopping.

This ensures that Trace IDs associated with CPUs remain the same
throughout the perf session, and are only released when all perf
sessions are complete.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 43bbd5dc3d3b..6166f716a6ac 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -22,6 +22,7 @@
 #include "coresight-etm-perf.h"
 #include "coresight-priv.h"
 #include "coresight-syscfg.h"
+#include "coresight-trace-id.h"
 
 static struct pmu etm_pmu;
 static bool etm_perf_up;
@@ -228,8 +229,12 @@ static void free_event_data(struct work_struct *work)
 		if (!(IS_ERR_OR_NULL(*ppath)))
 			coresight_release_path(*ppath);
 		*ppath = NULL;
+		coresight_trace_id_put_cpu_id(cpu);
 	}
 
+	/* mark perf event as done for trace id allocator */
+	coresight_trace_id_perf_stop();
+
 	free_percpu(event_data->path);
 	kfree(event_data);
 }
@@ -300,6 +305,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 {
 	u32 id, cfg_hash;
 	int cpu = event->cpu;
+	int trace_id;
 	cpumask_t *mask;
 	struct coresight_device *sink = NULL;
 	struct coresight_device *user_sink = NULL, *last_sink = NULL;
@@ -316,6 +322,9 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 		sink = user_sink = coresight_get_sink_by_id(id);
 	}
 
+	/* tell the trace ID allocator that a perf event is starting up */
+	coresight_trace_id_perf_start();
+
 	/* check if user wants a coresight configuration selected */
 	cfg_hash = (u32)((event->attr.config2 & GENMASK_ULL(63, 32)) >> 32);
 	if (cfg_hash) {
@@ -388,6 +397,13 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 			continue;
 		}
 
+		/* ensure we can allocate a trace ID for this CPU */
+		trace_id = coresight_trace_id_get_cpu_id(cpu);
+		if (!IS_VALID_ID(trace_id)) {
+			cpumask_clear_cpu(cpu, mask);
+			continue;
+		}
+
 		*etm_event_cpu_path_ptr(event_data, cpu) = path;
 	}
 
-- 
2.17.1


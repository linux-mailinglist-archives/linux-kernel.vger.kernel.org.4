Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1D9636A10
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 20:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237523AbiKWTui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 14:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237248AbiKWTu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 14:50:26 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C17786F5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:50:25 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id g12so30986674wrs.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q+K11GrFOPMrxvDYNvmhX0YpDA/5RBsqSxpF+D0Uhgs=;
        b=SixwwV3AAy5lbGBsGKJ9ikQymchwRHfI5t4Re1DfkBoRpdTlEzLgRbaCYmlHWN0aS+
         b9k+Y3rXgw4fYKod3k1c5dGndJ4VpIi4LL45s0QKEiVsGRBcjrHOUcwTxD5HGD2mw+rl
         Rzj8wZoZOedq1+djO3f3iSsAGCa7PoTWQDm5RMcP3K9j7qqxcCYypOkHAFBgWr/54hOU
         Rr0CajOMcxEaciN51PYCjt4+9dJ+SmNmFhxnJsIyjl0QR6cP7DAHtKvMFTJxw9ZxBYIe
         qV+JO7MUGsWOE9MbQjU87Zp+Yu7alzy2Lf8OPo8TAqn7kwzrRrZ4bY97NbfdMtMvyywr
         cOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q+K11GrFOPMrxvDYNvmhX0YpDA/5RBsqSxpF+D0Uhgs=;
        b=lhiEbxJgsIasNcc5B+WZPGvURY3rnJosdNax5NEuXbe+4Wt1540PDNIg3YWDbnK0S/
         cdRg6XBPLM9ASXorCb8Ike50AkAnPpM1U4uuvg6ehWzSAHOPcyO6ffUIw/WpFO+Wk71o
         r26IgB1nF+OtisvEpJV+fghdvMlQL2OdY54Tkjcn75irlVFOMcTMb6F4Ngj4BWfzgId9
         W2ehlm8NDTMjCuUdKJTgmqXhI/idgJ1+o7qTJ7TQDyykFlRfTgKZc7FntjagzAcXKlTJ
         IUAues7xBnXuQdyhaO7e9oNQZZs+7tgjp7adGMv+RGL8m3fTsVkf68xheQHKXRHzbJ8d
         Ue1w==
X-Gm-Message-State: ANoB5pmgaOz9xa9PCXL/lSbdiMLv/t/nzvzcWHAYopb4lwTH1qelGKxF
        FYNHXv2RfDtI26ydxNCLK6P/rg==
X-Google-Smtp-Source: AA0mqf7ZbrFI/I145ojO0uyWGnlzcDBou29muNZCalcuOvcFuQaS4NMOOkfnimSafXEy/4QTi1EBmg==
X-Received: by 2002:adf:f544:0:b0:241:f85e:75c8 with SMTP id j4-20020adff544000000b00241f85e75c8mr1296002wrp.337.1669233023921;
        Wed, 23 Nov 2022 11:50:23 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6809:2201:fcbc:7b5d:8d6c:43a4])
        by smtp.gmail.com with ESMTPSA id w5-20020a5d6805000000b002364c77bcacsm7267414wru.38.2022.11.23.11.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 11:50:23 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v6 03/14] coresight: perf: traceid: Add perf ID allocation and notifiers
Date:   Wed, 23 Nov 2022 19:49:59 +0000
Message-Id: <20221123195010.6859-4-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221123195010.6859-1-mike.leach@linaro.org>
References: <20221123195010.6859-1-mike.leach@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 43bbd5dc3d3b..bdb9ab86173a 100644
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
+		if (!IS_VALID_CS_TRACE_ID(trace_id)) {
+			cpumask_clear_cpu(cpu, mask);
+			continue;
+		}
+
 		*etm_event_cpu_path_ptr(event_data, cpu) = path;
 	}
 
-- 
2.17.1


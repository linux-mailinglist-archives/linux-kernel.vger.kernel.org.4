Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F835FE8C5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 08:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiJNGQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 02:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiJNGQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 02:16:03 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60051905E7;
        Thu, 13 Oct 2022 23:16:01 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id x31-20020a17090a38a200b0020d2afec803so3915280pjb.2;
        Thu, 13 Oct 2022 23:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/EF52FtpTXq1+8QCY2XPc41r5d2NZu8hH5dtQWtwyk=;
        b=QtxezWOYGoDhOhgLJEbpMtp6kBjPn+vSPV3bIAEKbVsjJb6ew6WVcgDNzTG+SRd5RH
         GhIctA17MH8wjL+xGS4cvlS9rOtJU62jkanPGO12iDbCYHye86DzS7drXUowKizpsDOS
         I0N/C0IDionhipVUeXeNqvo7csI2zktQUqbQxucTtwNFWTrJj2wlnRxGF/idXGnFCY2P
         DtcRsJRPcFH4D8jZYfuFoOKlMqZlqLk/la5VfYQtybwV3WkxMSdbh1GU7K5iHhTzHUO9
         lK9wMeZCaB2gQpKuuzkQWTCeesvG/umgCAoi8MCF1LLku4ANAHnS0ckzi5GuXO8Ep611
         I/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U/EF52FtpTXq1+8QCY2XPc41r5d2NZu8hH5dtQWtwyk=;
        b=vqwalq51q8Nu30ia9TwVz4sr6WQv8bkrJZXbDoF7z2H48vEWt40JtIIbtrt3BYZMhz
         ao++Sz1xgisVB/4Dl+ItA4E9P9BFd4pCJBxBYM8YE85vbXB8/E2lcrTqDSa0nNQxWhGE
         8G1bos4JKsM6Lxl8IwsgI3X9qUcF7MPy46fOzUfkJiKOXcfF4HK4bwOgEKkpdI2eyKrV
         b27t+6Nc34bpdSiH1Jf5W0TFMz5+121sNK2HRGqeWF6luWxvD6Uys0tPZA5CWvWC6STg
         H6ng6Bu0qSxzoepglfYPsfklUokEbwG+DYRfoI6NC11kNB2holFCH4rW4RhCtr/Zd1MK
         j+ew==
X-Gm-Message-State: ACrzQf1/BTw+k+S1tf8cToAvTyf0CfJV2YOp4uXYVG2Fs5IUWSTHJNH+
        tZ7dZPHAgm+FpGtr1XqcmAU=
X-Google-Smtp-Source: AMsMyM6OmxacYp7Vf/ohiFjz4kgdCrQE085/iQYeUo1QT2lyPsVXTCJEgNYMohts+k4UWMTAZSv4JA==
X-Received: by 2002:a17:902:724b:b0:183:16f:fae4 with SMTP id c11-20020a170902724b00b00183016ffae4mr3830678pll.88.1665728160649;
        Thu, 13 Oct 2022 23:16:00 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:630:195c:38a7:a411])
        by smtp.gmail.com with ESMTPSA id 94-20020a17090a09e700b0020af2411721sm721942pjo.34.2022.10.13.23.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 23:16:00 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        James Clark <james.clark@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Subject: [PATCH 05/19] perf stat: Add cpu aggr id for no aggregation mode
Date:   Thu, 13 Oct 2022 23:15:36 -0700
Message-Id: <20221014061550.463644-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221014061550.463644-1-namhyung@kernel.org>
References: <20221014061550.463644-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Likewise, add an aggr_id for cpu for none aggregation mode.  This is not
used actually yet but later code will use to unify the aggregation code.

No functional change intended.

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-stat.c | 48 +++++++++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 75d16e9705a4..b03b530fe9a6 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1336,6 +1336,12 @@ static struct aggr_cpu_id perf_stat__get_global(struct perf_stat_config *config
 	return aggr_cpu_id__global(cpu, /*data=*/NULL);
 }
 
+static struct aggr_cpu_id perf_stat__get_cpu(struct perf_stat_config *config __maybe_unused,
+					     struct perf_cpu cpu)
+{
+	return aggr_cpu_id__cpu(cpu, /*data=*/NULL);
+}
+
 static struct aggr_cpu_id perf_stat__get_aggr(struct perf_stat_config *config,
 					      aggr_get_id_t get_id, struct perf_cpu cpu)
 {
@@ -1378,6 +1384,12 @@ static struct aggr_cpu_id perf_stat__get_global_cached(struct perf_stat_config *
 	return perf_stat__get_aggr(config, perf_stat__get_global, cpu);
 }
 
+static struct aggr_cpu_id perf_stat__get_cpu_cached(struct perf_stat_config *config,
+						    struct perf_cpu cpu)
+{
+	return perf_stat__get_aggr(config, perf_stat__get_cpu, cpu);
+}
+
 static bool term_percore_set(void)
 {
 	struct evsel *counter;
@@ -1404,8 +1416,7 @@ static aggr_cpu_id_get_t aggr_mode__get_aggr(enum aggr_mode aggr_mode)
 	case AGGR_NONE:
 		if (term_percore_set())
 			return aggr_cpu_id__core;
-
-		return NULL;
+		return aggr_cpu_id__cpu;
 	case AGGR_GLOBAL:
 		return aggr_cpu_id__global;
 	case AGGR_THREAD:
@@ -1428,10 +1439,9 @@ static aggr_get_id_t aggr_mode__get_id(enum aggr_mode aggr_mode)
 	case AGGR_NODE:
 		return perf_stat__get_node_cached;
 	case AGGR_NONE:
-		if (term_percore_set()) {
+		if (term_percore_set())
 			return perf_stat__get_core_cached;
-		}
-		return NULL;
+		return perf_stat__get_cpu_cached;
 	case AGGR_GLOBAL:
 		return perf_stat__get_global_cached;
 	case AGGR_THREAD:
@@ -1541,6 +1551,26 @@ static struct aggr_cpu_id perf_env__get_core_aggr_by_cpu(struct perf_cpu cpu, vo
 	return id;
 }
 
+static struct aggr_cpu_id perf_env__get_cpu_aggr_by_cpu(struct perf_cpu cpu, void *data)
+{
+	struct perf_env *env = data;
+	struct aggr_cpu_id id = aggr_cpu_id__empty();
+
+	if (cpu.cpu != -1) {
+		/*
+		 * core_id is relative to socket and die,
+		 * we need a global id. So we set
+		 * socket, die id and core id
+		 */
+		id.socket = env->cpu[cpu.cpu].socket_id;
+		id.die = env->cpu[cpu.cpu].die_id;
+		id.core = env->cpu[cpu.cpu].core_id;
+		id.cpu = cpu;
+	}
+
+	return id;
+}
+
 static struct aggr_cpu_id perf_env__get_node_aggr_by_cpu(struct perf_cpu cpu, void *data)
 {
 	struct aggr_cpu_id id = aggr_cpu_id__empty();
@@ -1576,6 +1606,12 @@ static struct aggr_cpu_id perf_stat__get_core_file(struct perf_stat_config *conf
 	return perf_env__get_core_aggr_by_cpu(cpu, &perf_stat.session->header.env);
 }
 
+static struct aggr_cpu_id perf_stat__get_cpu_file(struct perf_stat_config *config __maybe_unused,
+						  struct perf_cpu cpu)
+{
+	return perf_env__get_cpu_aggr_by_cpu(cpu, &perf_stat.session->header.env);
+}
+
 static struct aggr_cpu_id perf_stat__get_node_file(struct perf_stat_config *config __maybe_unused,
 						   struct perf_cpu cpu)
 {
@@ -1602,6 +1638,7 @@ static aggr_cpu_id_get_t aggr_mode__get_aggr_file(enum aggr_mode aggr_mode)
 	case AGGR_GLOBAL:
 		return perf_env__get_global_aggr_by_cpu;
 	case AGGR_NONE:
+		return perf_env__get_cpu_aggr_by_cpu;
 	case AGGR_THREAD:
 	case AGGR_UNSET:
 	case AGGR_MAX:
@@ -1624,6 +1661,7 @@ static aggr_get_id_t aggr_mode__get_id_file(enum aggr_mode aggr_mode)
 	case AGGR_GLOBAL:
 		return perf_stat__get_global_file;
 	case AGGR_NONE:
+		return perf_stat__get_cpu_file;
 	case AGGR_THREAD:
 	case AGGR_UNSET:
 	case AGGR_MAX:
-- 
2.38.0.413.g74048e4d9e-goog


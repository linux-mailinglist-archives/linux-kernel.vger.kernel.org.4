Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4B46020C4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiJRCDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiJRCCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:02:42 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329F389960;
        Mon, 17 Oct 2022 19:02:40 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id t12-20020a17090a3b4c00b0020b04251529so12621048pjf.5;
        Mon, 17 Oct 2022 19:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/EF52FtpTXq1+8QCY2XPc41r5d2NZu8hH5dtQWtwyk=;
        b=ZTrFRBXEC2zKC6kHIiLytn56MmdkparMQ87OCQoYHLrgs070ecDKWsGAnM38nYqqgz
         J8BJ6yLBzFfluljIm7H5mmL7K2dziL4FfbmoY9hj7Ny6nJxraQJqANt1x26KzZIvo0Wp
         /4tT5r8jjV82KNTqoyqo20jImmSYfLX07XOnwqfzGUcYczeFpZ3X2jx1KiWd0edXCSgC
         yZ7VfoYAeX5R4I1bajlmgB7qJ0G8IsJiSBouV61mwS8YQ3HPBkhtsrhb+fofYaaXS6Wc
         geVNMkyGYgmsYAnyw5pfft4iz5aRn6NlktCp6HNjZCagxHLR66wIYEsh4HN5PY/gGJ4h
         PzxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U/EF52FtpTXq1+8QCY2XPc41r5d2NZu8hH5dtQWtwyk=;
        b=5iw1fUXWCmyYdYri6V1OUt0u+ddPn7ALdjTXjqveYS36IYcnSjfot8xZvQPCUHqNA+
         kO9dVIJaY/hT3ZHBBLOBp++oBpd1LsBHoHJiHDXdLBdApXpNvDFWzFDowWmkVdptc2Xg
         sU2t3ZUV7tQM4kSnQrYLqmL94/w8nqoo+XdKKCJLC5fQvSlK+Q8Iu3KuK4HdbvTcxnyt
         Xjf+V1d6X0jYIaP/0wEJVZAJIr1GNNNNBo+LxCaFz8Cq7v8vhi5GhPye9kvred/gtFLu
         nfdfx26wsvXOi3JGiyAaMc1lXS0eQZrQcrahSiMJsdTD3/2N9HWZmDQr/H+zqs5rj2Ab
         nmxQ==
X-Gm-Message-State: ACrzQf32YRHb6R5iPLr3BaSu68t+8e9gjrDiOs3OVyJ+9yOd8dX0VaWZ
        9Fr0suWsam23KQWqNL/kjqc=
X-Google-Smtp-Source: AMsMyM5E1LBL1m9DpI/Mb2Im32bRq5qxDN3E3qPZniBWOswU2q1y8xVKly2CE8URjQX31PY2gW4koQ==
X-Received: by 2002:a17:90b:180f:b0:20d:4e7f:5f52 with SMTP id lw15-20020a17090b180f00b0020d4e7f5f52mr37194113pjb.119.1666058559549;
        Mon, 17 Oct 2022 19:02:39 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1f90:85c4:58f0:7a81:6bb5])
        by smtp.gmail.com with ESMTPSA id t4-20020a655544000000b00464858cf6b0sm6851564pgr.54.2022.10.17.19.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 19:02:39 -0700 (PDT)
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
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 05/20] perf stat: Add cpu aggr id for no aggregation mode
Date:   Mon, 17 Oct 2022 19:02:12 -0700
Message-Id: <20221018020227.85905-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221018020227.85905-1-namhyung@kernel.org>
References: <20221018020227.85905-1-namhyung@kernel.org>
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836AA5F97D5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 07:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbiJJFg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 01:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbiJJFgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 01:36:12 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD951CB2C;
        Sun,  9 Oct 2022 22:36:11 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id l1so9407913pld.13;
        Sun, 09 Oct 2022 22:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NPBgQNqRZtpAbQmaSkms1iOgPMJfmf2295vWcO4HGdg=;
        b=ApLJlc+Ix3qfcppeuD1PJdh2HOPpBlJxyvKb9/8rSwlQY/gaSWDcqLZifueX7kdAPN
         mAh1NPi+i+8YkPNF/fA+8eW13IZ/Sz1iSrYft/t55PIcYjwtD7yGD8c///ZPPYmf74Fm
         GsEt2ZPA1YSc7c06AJRZ12OarKTsyhDD5aDIcfR1Y7/5lFKRP8jznDof7SCW8HwWOSfb
         wpMAfbwngVdlARdRRj/+dy9e6/MZ0+LAZE+w6dI+Mi1dWIJTeimOT+1INTvv1r9H718K
         +inWassOkK1/lhOXNJ6XSNzsLOqPQvEZw8USUr/HK6LsvkD4PZhXGF5oMaXHErQ+RiSx
         dOXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NPBgQNqRZtpAbQmaSkms1iOgPMJfmf2295vWcO4HGdg=;
        b=AUvr6ot3owT3qkAvsImvYIJpDW0Gg5y8Gw1fXIEV3EFFssc+vfeZPF9uQ0YZJ8qFst
         93X+m0OPPYXvxO1MF0ERRb3mXsrBd2BIP6IA3MUmM8CqjoXKmHbiEltMQ78r0zegCrQw
         0LuMl3DswFX15YJgRaf93zo9x+aXllnahSXwHYHNdzJpgn5fvgde0KDkERt/uho1Qf8Y
         tOpJ+nqNHcVieYF5J9mgDRa2qP/Gkujsmmi5RswXl3hAf/F4T3dqrxKQnDF+nUDWhnIh
         ffJBZ681yK2LUgyFT7qWmZXv7DM9dc4enQOEE8sPAw2OlMoAikySPDqE8uezkxo2UKMa
         mcCA==
X-Gm-Message-State: ACrzQf2ikdroolmwDpDQPIOeUTxIBgWf7eUSKQ+QdSz9zzySCuywdAvl
        Aqs2llbO/5mY0lKGmXnP7n4=
X-Google-Smtp-Source: AMsMyM4G0Hdg4n7vniUkPHdmg2pwQ2u4cXhoXPU7Ky0/3Zsn6qsl50EE/4LMkU4Wk8QLHn/ZmFefSQ==
X-Received: by 2002:a17:902:db12:b0:178:1f91:74e6 with SMTP id m18-20020a170902db1200b001781f9174e6mr18073255plx.100.1665380170545;
        Sun, 09 Oct 2022 22:36:10 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:862f:cd0e:bf30:6d69])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902e80d00b0017f7e0f4a4esm5667594plg.35.2022.10.09.22.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 22:36:10 -0700 (PDT)
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
Date:   Sun,  9 Oct 2022 22:35:46 -0700
Message-Id: <20221010053600.272854-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221010053600.272854-1-namhyung@kernel.org>
References: <20221010053600.272854-1-namhyung@kernel.org>
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

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-stat.c | 48 +++++++++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 144bb3a657f2..b00ef20aef5b 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1339,6 +1339,12 @@ static struct aggr_cpu_id perf_stat__get_global(struct perf_stat_config *config
 	return id;
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
@@ -1381,6 +1387,12 @@ static struct aggr_cpu_id perf_stat__get_global_cached(struct perf_stat_config *
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
@@ -1407,8 +1419,7 @@ static aggr_cpu_id_get_t aggr_mode__get_aggr(enum aggr_mode aggr_mode)
 	case AGGR_NONE:
 		if (term_percore_set())
 			return aggr_cpu_id__core;
-
-		return NULL;
+		return aggr_cpu_id__cpu;;
 	case AGGR_GLOBAL:
 		return aggr_cpu_id__global;
 	case AGGR_THREAD:
@@ -1431,10 +1442,9 @@ static aggr_get_id_t aggr_mode__get_id(enum aggr_mode aggr_mode)
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
@@ -1544,6 +1554,26 @@ static struct aggr_cpu_id perf_env__get_core_aggr_by_cpu(struct perf_cpu cpu, vo
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
@@ -1579,6 +1609,12 @@ static struct aggr_cpu_id perf_stat__get_core_file(struct perf_stat_config *conf
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
@@ -1605,6 +1641,7 @@ static aggr_cpu_id_get_t aggr_mode__get_aggr_file(enum aggr_mode aggr_mode)
 	case AGGR_GLOBAL:
 		return perf_env__get_global_aggr_by_cpu;
 	case AGGR_NONE:
+		return perf_env__get_cpu_aggr_by_cpu;
 	case AGGR_THREAD:
 	case AGGR_UNSET:
 	case AGGR_MAX:
@@ -1627,6 +1664,7 @@ static aggr_get_id_t aggr_mode__get_id_file(enum aggr_mode aggr_mode)
 	case AGGR_GLOBAL:
 		return perf_stat__get_global_file;
 	case AGGR_NONE:
+		return perf_stat__get_cpu_file;
 	case AGGR_THREAD:
 	case AGGR_UNSET:
 	case AGGR_MAX:
-- 
2.38.0.rc1.362.ged0d419d3c-goog


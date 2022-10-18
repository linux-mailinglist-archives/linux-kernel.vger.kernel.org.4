Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1BE6020C3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbiJRCC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiJRCCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:02:39 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7DF8B2D6;
        Mon, 17 Oct 2022 19:02:38 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id t12-20020a17090a3b4c00b0020b04251529so12620994pjf.5;
        Mon, 17 Oct 2022 19:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbDmjiM+wxCKjeV/c/2pqTxL69Z7MugBph9/YEKmkSo=;
        b=ibsxQ4qBoZxH848d3SpvoFXpxXI2UgCDTV8wu9LIYcR8ZZh3CBW0lW1MfAV3EVXAEi
         jugMsD5VHEG3fp+tqbz2weVEpFBwQAMa/vQBwmeeSdXyevJXYmBB2rarrsmoT+nH5GJH
         JfKtypG3dvVntNsqJtqZEGCWfywwiE5dpoSEbm8qXzbFmlJtU5s9JRH9kzQi4zPdOwym
         1hORTtqD7NSOYNfJLcwz1Dt3G9fWo+YrzUlbHA7vEbAHZOt86weqtg5CCisUEkvOO5XX
         hOb9ZGNBYhhiekQBPuVgtaNGsYfUW6mf52SSxR50Wws64BbnQ7BbmCU1yHi02g8lI6cu
         iPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JbDmjiM+wxCKjeV/c/2pqTxL69Z7MugBph9/YEKmkSo=;
        b=rlYJQboyJeDfr3ewptmhFiBkkoaTGQF7ELfQrNwLgRyCd1vaU59+YlW/U69pmPkIyT
         nrDHXvd9gfACKJmjJdT1OMMgY0aK/3Ev3eHbo0QK6Y7t9aJu4x2FVrkPuHCrRZL8gCUI
         HphVpJuNdkTuancj9aO/wsgRbXSDathzqZNMf7libk33okOtWDxzvdsGMD1XPlxwlWvH
         aeuFvpBHdhDaDiakZ+43HZo4ATFRH9/+OWrRos+llKTETO0nZuVLYC4FHtx8h/s4z2cg
         QaxMR2xUC5hSW+smMy7oHfv2icNfUSRsEdJHRmGi+sy7Mi041BPfbxbH7oMllRl7KjTM
         xMcA==
X-Gm-Message-State: ACrzQf2UTwUXqXky4YTziJQ0QVwafUb6UInk+KigidUkR/228qEg09SH
        kDuAals57d809MMMo6Yaf8k=
X-Google-Smtp-Source: AMsMyM68lt5VArqBtWMNghjb/oz3sulqC3wj6/NSU6eEbZw2r4JIsEIh8d7NfmRyzAvJ3dQSjYqkPw==
X-Received: by 2002:a17:902:aa42:b0:17e:b779:dadb with SMTP id c2-20020a170902aa4200b0017eb779dadbmr622516plr.11.1666058557654;
        Mon, 17 Oct 2022 19:02:37 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1f90:85c4:58f0:7a81:6bb5])
        by smtp.gmail.com with ESMTPSA id t4-20020a655544000000b00464858cf6b0sm6851564pgr.54.2022.10.17.19.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 19:02:37 -0700 (PDT)
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
Subject: [PATCH 04/20] perf stat: Add aggr id for global mode
Date:   Mon, 17 Oct 2022 19:02:11 -0700
Message-Id: <20221018020227.85905-5-namhyung@kernel.org>
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

To make the code simpler, I'd like to use the same aggregation code for
the global mode.  We can simply add an id function to return cpu 0 and
use print_aggr().

No functional change intended.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-stat.c | 36 ++++++++++++++++++++++++++++++++++--
 tools/perf/util/cpumap.c  | 10 ++++++++++
 tools/perf/util/cpumap.h  |  6 +++++-
 3 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 265b05157972..75d16e9705a4 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1330,6 +1330,12 @@ static struct aggr_cpu_id perf_stat__get_node(struct perf_stat_config *config __
 	return aggr_cpu_id__node(cpu, /*data=*/NULL);
 }
 
+static struct aggr_cpu_id perf_stat__get_global(struct perf_stat_config *config __maybe_unused,
+						struct perf_cpu cpu)
+{
+	return aggr_cpu_id__global(cpu, /*data=*/NULL);
+}
+
 static struct aggr_cpu_id perf_stat__get_aggr(struct perf_stat_config *config,
 					      aggr_get_id_t get_id, struct perf_cpu cpu)
 {
@@ -1366,6 +1372,12 @@ static struct aggr_cpu_id perf_stat__get_node_cached(struct perf_stat_config *co
 	return perf_stat__get_aggr(config, perf_stat__get_node, cpu);
 }
 
+static struct aggr_cpu_id perf_stat__get_global_cached(struct perf_stat_config *config,
+						       struct perf_cpu cpu)
+{
+	return perf_stat__get_aggr(config, perf_stat__get_global, cpu);
+}
+
 static bool term_percore_set(void)
 {
 	struct evsel *counter;
@@ -1395,6 +1407,7 @@ static aggr_cpu_id_get_t aggr_mode__get_aggr(enum aggr_mode aggr_mode)
 
 		return NULL;
 	case AGGR_GLOBAL:
+		return aggr_cpu_id__global;
 	case AGGR_THREAD:
 	case AGGR_UNSET:
 	case AGGR_MAX:
@@ -1420,6 +1433,7 @@ static aggr_get_id_t aggr_mode__get_id(enum aggr_mode aggr_mode)
 		}
 		return NULL;
 	case AGGR_GLOBAL:
+		return perf_stat__get_global_cached;
 	case AGGR_THREAD:
 	case AGGR_UNSET:
 	case AGGR_MAX:
@@ -1535,6 +1549,16 @@ static struct aggr_cpu_id perf_env__get_node_aggr_by_cpu(struct perf_cpu cpu, vo
 	return id;
 }
 
+static struct aggr_cpu_id perf_env__get_global_aggr_by_cpu(struct perf_cpu cpu __maybe_unused,
+							   void *data __maybe_unused)
+{
+	struct aggr_cpu_id id = aggr_cpu_id__empty();
+
+	/* it always aggregates to the cpu 0 */
+	id.cpu = (struct perf_cpu){ .cpu = 0 };
+	return id;
+}
+
 static struct aggr_cpu_id perf_stat__get_socket_file(struct perf_stat_config *config __maybe_unused,
 						     struct perf_cpu cpu)
 {
@@ -1558,6 +1582,12 @@ static struct aggr_cpu_id perf_stat__get_node_file(struct perf_stat_config *conf
 	return perf_env__get_node_aggr_by_cpu(cpu, &perf_stat.session->header.env);
 }
 
+static struct aggr_cpu_id perf_stat__get_global_file(struct perf_stat_config *config __maybe_unused,
+						     struct perf_cpu cpu)
+{
+	return perf_env__get_global_aggr_by_cpu(cpu, &perf_stat.session->header.env);
+}
+
 static aggr_cpu_id_get_t aggr_mode__get_aggr_file(enum aggr_mode aggr_mode)
 {
 	switch (aggr_mode) {
@@ -1569,8 +1599,9 @@ static aggr_cpu_id_get_t aggr_mode__get_aggr_file(enum aggr_mode aggr_mode)
 		return perf_env__get_core_aggr_by_cpu;
 	case AGGR_NODE:
 		return perf_env__get_node_aggr_by_cpu;
-	case AGGR_NONE:
 	case AGGR_GLOBAL:
+		return perf_env__get_global_aggr_by_cpu;
+	case AGGR_NONE:
 	case AGGR_THREAD:
 	case AGGR_UNSET:
 	case AGGR_MAX:
@@ -1590,8 +1621,9 @@ static aggr_get_id_t aggr_mode__get_id_file(enum aggr_mode aggr_mode)
 		return perf_stat__get_core_file;
 	case AGGR_NODE:
 		return perf_stat__get_node_file;
-	case AGGR_NONE:
 	case AGGR_GLOBAL:
+		return perf_stat__get_global_file;
+	case AGGR_NONE:
 	case AGGR_THREAD:
 	case AGGR_UNSET:
 	case AGGR_MAX:
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 8486ca3bec75..60209fe87456 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -354,6 +354,16 @@ struct aggr_cpu_id aggr_cpu_id__node(struct perf_cpu cpu, void *data __maybe_unu
 	return id;
 }
 
+struct aggr_cpu_id aggr_cpu_id__global(struct perf_cpu cpu, void *data __maybe_unused)
+{
+	struct aggr_cpu_id id = aggr_cpu_id__empty();
+
+	/* it always aggregates to the cpu 0 */
+	cpu.cpu = 0;
+	id.cpu = cpu;
+	return id;
+}
+
 /* setup simple routines to easily access node numbers given a cpu number */
 static int get_max_num(char *path, int *max)
 {
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 4a6d029576ee..b2ff648bc417 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -133,5 +133,9 @@ struct aggr_cpu_id aggr_cpu_id__cpu(struct perf_cpu cpu, void *data);
  * cpu. The function signature is compatible with aggr_cpu_id_get_t.
  */
 struct aggr_cpu_id aggr_cpu_id__node(struct perf_cpu cpu, void *data);
-
+/**
+ * aggr_cpu_id__global - Create an aggr_cpu_id for global aggregation.
+ * The function signature is compatible with aggr_cpu_id_get_t.
+ */
+struct aggr_cpu_id aggr_cpu_id__global(struct perf_cpu cpu, void *data);
 #endif /* __PERF_CPUMAP_H */
-- 
2.38.0.413.g74048e4d9e-goog


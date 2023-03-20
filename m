Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57AA6C095F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 04:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjCTDjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 23:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCTDiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 23:38:54 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1EA1ABF7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 20:38:52 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-544781e30easo108370047b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 20:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679283532;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xrt9Ph5px6prAvTQhXAecI3U6Lfan0vmOke50ovWG1M=;
        b=SLm8pysaaJPDn3tarDhYFdN0EoWhscBYsdzIjuWTUUtB0j5tEwe9R6xoqXPNrT+h5K
         qKOSI+OR5Q//CyRQL5Y6rR4Tls8LUt0f2xYILflCtzDTTw6Vur94Fe97Ks5zz4Eawyz1
         lvxTNIpHcD/epo6xo2SUaNrFgX5A3JIn8sFS+kHVL9WNcJdiXjHODNVfbnVsGYg9IhBo
         g4MAGQT5FE1aYb8pbG9MqU7Pxjcm09dDr6JOyE0OASTf7Ogit8u8Bg++uq+JkKagUiXg
         o0ib7riT4+5/P3/WoHSyQinzMlXTvfshQjEhhHhn3+y5jiWSMlnMjrIj5eIR0pFeTPCG
         WEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679283532;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xrt9Ph5px6prAvTQhXAecI3U6Lfan0vmOke50ovWG1M=;
        b=FQ++Xf2K0JMY0GNGZiUutWK7SD1B3DZllbgXJ1LLpShOElMTFweOSQWgE10uu7bwtc
         fIU6ylDCrU6Lz4SvmiyaZPvaI4Gls+3pVB/K0HGPKRDRbPzy2K2wDHLvMPeOCdZChuc5
         xvtU318Vg4N2oF3gZVT3oRzTRWEhbboAlANhhdAdlD2pyQSTa1b9aen07BQESfCxHbWr
         fOp8Q9FKmN1B+zcx/wzR5kpem6/9CxpkGfzJyRhRFQM49GfGGWJtW0h7SeNE4Gd6qj97
         Cc25/Ig0B71URgRmP7dgvAdLA5a6HN9BjunoZn7zfVzhxUUkoFU1f55Z/eaQ6X/iOsMO
         nDZw==
X-Gm-Message-State: AO0yUKVZy7b5UY6ak7QynMEjRy4WGLWCWCdfxEn8cH4zkJLwPbCYXuhA
        9PNZZKunlN7TQnmpzf3sqhlAtnmFUroe
X-Google-Smtp-Source: AK7set9NhHU82JjZxbfhBgezTbXM9VYgl0aEqn4whSpWEHhQgRIw//AI/wwz8OmvRhylECrv+kV3c4/TOqdR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:1895:9fa0:27f5:cb71])
 (user=irogers job=sendgmr) by 2002:a05:6902:1002:b0:b4a:e062:3576 with SMTP
 id w2-20020a056902100200b00b4ae0623576mr3589232ybt.13.1679283531762; Sun, 19
 Mar 2023 20:38:51 -0700 (PDT)
Date:   Sun, 19 Mar 2023 20:37:50 -0700
In-Reply-To: <20230320033810.980165-1-irogers@google.com>
Message-Id: <20230320033810.980165-3-irogers@google.com>
Mime-Version: 1.0
References: <20230320033810.980165-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v4 02/22] perf bpf_counter: Use public cpumap accessors
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@collabora.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, Hao Luo <haoluo@google.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid the use of internal apis via the cpumap accessor functions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf_counter.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
index 1b77436e067e..76ee3e86824a 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -545,7 +545,7 @@ static int bperf__load(struct evsel *evsel, struct target *target)
 		    filter_type == BPERF_FILTER_TGID)
 			key = perf_thread_map__pid(evsel->core.threads, i);
 		else if (filter_type == BPERF_FILTER_CPU)
-			key = evsel->core.cpus->map[i].cpu;
+			key = perf_cpu_map__cpu(evsel->core.cpus, i).cpu;
 		else
 			break;
 
@@ -587,9 +587,9 @@ static int bperf_sync_counters(struct evsel *evsel)
 {
 	int num_cpu, i, cpu;
 
-	num_cpu = all_cpu_map->nr;
+	num_cpu = perf_cpu_map__nr(all_cpu_map);
 	for (i = 0; i < num_cpu; i++) {
-		cpu = all_cpu_map->map[i].cpu;
+		cpu = perf_cpu_map__cpu(all_cpu_map, i).cpu;
 		bperf_trigger_reading(evsel->bperf_leader_prog_fd, cpu);
 	}
 	return 0;
-- 
2.40.0.rc1.284.g88254d51c5-goog


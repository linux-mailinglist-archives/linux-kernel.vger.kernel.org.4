Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FB7628D1A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 00:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238061AbiKNXE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 18:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238122AbiKNXES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 18:04:18 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A1F1D31B;
        Mon, 14 Nov 2022 15:03:00 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id v28so12454107pfi.12;
        Mon, 14 Nov 2022 15:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4xN0opfJbQJnUhtmkfw3MqwhSTJXF+vfzMgniki+7E=;
        b=qp+2rjNM+J44UCbw2i7qNgQQzk43z/lronElv7ycCE0x0q3pB0H01Zu+XInPlr3cmO
         sdvCIDkGTMiM2xX06ojIfQgY3kfNbDU1fkd02QN1WVppq1OtZcJHbyuy1OoAbN0IUhyJ
         JxmPVqs1Na39z65j+J5QHOnBoks2WCbahhJP/iwJAB4RJIXbuG1e+9SiahttpSTcxoAL
         m+xamjwEljBP0Xs67NtjxDaOjH2pWsDh/UrqR0DCbuWdi8eSLj7uDD5OMa68htyWtCHG
         ipKnF+4OkUzovf81ZtzQ7f4O5AwZN4Q0kvV0trr6pJhrYHGX8aQOGgOgOpmhZjDxHUAV
         Va3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V4xN0opfJbQJnUhtmkfw3MqwhSTJXF+vfzMgniki+7E=;
        b=T9a71s3X6RFabSIv9Vs/sql/o1lj1SXeFznTQzdx4L1S9d7WB74CLh6dKgAYcXNJIK
         KPFF0nUSl9y20T/OUiNmARkgR0fXpRWWr2PoRQaabk9OWzJ1XuXc+8tMgli1vBQogzzd
         hK67eL4nleEzjG4p+TN/O6vG7d4Gkq3Cd2gY2l98FkWW3gxfqZo7TR/Ze8tbhekzSrm5
         YLjEt9bfEpo+R1fs4AC9Hgnc/oZ3s3thrfYN5SgSs8JwFLx8WmaVbfbYXHeHaOl+Hy7N
         xYu0hvJ/oBlVNE6ZswcgCHqNJrQY2O5B5axH4K9eoqmq6k9ktOZeK2XOAQhEd+4B4xhb
         dT0g==
X-Gm-Message-State: ANoB5pnCqkfg4hIjUpPy59uuEAIJBaKFy5BvInO5f55rUzEjUzSvsALy
        M+G6rAKHWS24dZgHwebYYq0=
X-Google-Smtp-Source: AA0mqf6chQrISyKGDSM8yTtWqC9coU7avrKK7VK5jxUBz0T8Xx+B1g2Cf8CKhjxGcJxwrPQMrIWkCA==
X-Received: by 2002:a63:a504:0:b0:456:4f9a:fbb6 with SMTP id n4-20020a63a504000000b004564f9afbb6mr13599960pgf.318.1668466979496;
        Mon, 14 Nov 2022 15:02:59 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:a80:cf9f:e038:c19b:797e])
        by smtp.gmail.com with ESMTPSA id 132-20020a62148a000000b0056c814a501dsm7534724pfu.10.2022.11.14.15.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 15:02:59 -0800 (PST)
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
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>
Subject: [PATCH 19/19] perf stat: Add print_aggr_cgroup() for --for-each-cgroup and --topdown
Date:   Mon, 14 Nov 2022 15:02:27 -0800
Message-Id: <20221114230227.1255976-20-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.1.493.g58b659f92b-goog
In-Reply-To: <20221114230227.1255976-1-namhyung@kernel.org>
References: <20221114230227.1255976-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Normally, --for-each-cgroup only works with AGGR_GLOBAL.  However
the --topdown on some cpu (e.g. Intel Skylake) converts it to the
AGGR_CORE internally.

To support those machines, add print_aggr_cgroup and handle the events
like in print_cgroup_events().

  $ perf stat -a --for-each-cgroup system.slice,user.slice --topdown sleep 1
  nmi_watchdog enabled with topdown. May give wrong results.
  Disable with echo 0 > /proc/sys/kernel/nmi_watchdog

   Performance counter stats for 'system wide':

                                                  retiring      bad speculation       frontend bound        backend bound
  S0-D0-C0              2  system.slice                   49.0%               -46.6%                31.4%
  S0-D0-C1              2  system.slice                   55.5%                 8.0%                45.5%                -9.0%
  S0-D0-C2              2  system.slice                   87.8%                22.1%                30.3%               -40.3%
  S0-D0-C3              2  system.slice                   53.3%               -11.9%                45.2%                13.4%
  S0-D0-C0              2  user.slice                    123.5%                 4.0%                48.5%               -75.9%
  S0-D0-C1              2  user.slice                     19.9%                 6.5%                89.9%               -16.3%
  S0-D0-C2              2  user.slice                     29.9%                 7.9%                71.3%                -9.1%
  S0-D0-C3              2  user.slice                     28.0%                 7.2%                43.3%                21.5%

         1.004136937 seconds time elapsed

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 41 +++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index cf25ed99b5df..f5501760ff2e 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -900,6 +900,42 @@ static void print_aggr(struct perf_stat_config *config,
 	}
 }
 
+static void print_aggr_cgroup(struct perf_stat_config *config,
+			      struct evlist *evlist,
+			      char *prefix)
+{
+	bool metric_only = config->metric_only;
+	struct evsel *counter, *evsel;
+	struct cgroup *cgrp = NULL;
+	int s;
+
+	if (!config->aggr_map || !config->aggr_get_id)
+		return;
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (cgrp == evsel->cgrp)
+			continue;
+
+		cgrp = evsel->cgrp;
+
+		for (s = 0; s < config->aggr_map->nr; s++) {
+			print_metric_begin(config, evlist, prefix, s, cgrp);
+
+			evlist__for_each_entry(evlist, counter) {
+				if (counter->merged_stat)
+					continue;
+
+				if (counter->cgrp != cgrp)
+					continue;
+
+				print_counter_aggrdata(config, counter, s, prefix,
+						       metric_only);
+			}
+			print_metric_end(config);
+		}
+	}
+}
+
 static void print_counter(struct perf_stat_config *config,
 			  struct evsel *counter, char *prefix)
 {
@@ -1361,7 +1397,10 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
 	case AGGR_DIE:
 	case AGGR_SOCKET:
 	case AGGR_NODE:
-		print_aggr(config, evlist, prefix);
+		if (config->cgroup_list)
+			print_aggr_cgroup(config, evlist, prefix);
+		else
+			print_aggr(config, evlist, prefix);
 		break;
 	case AGGR_THREAD:
 	case AGGR_GLOBAL:
-- 
2.38.1.493.g58b659f92b-goog


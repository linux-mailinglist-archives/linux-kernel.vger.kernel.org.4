Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6680A636827
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 19:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239186AbiKWSDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 13:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239376AbiKWSCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:02:24 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E841597361;
        Wed, 23 Nov 2022 10:02:22 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 62so17348211pgb.13;
        Wed, 23 Nov 2022 10:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5YlYwASYbZHVOyqMgrEDdQ4f+mzDqMyHGJNku61KwY=;
        b=T2I/KuoDwuUz9H2yYwNvWgGn38WayvSDn/DlKLrSa4DWYmZ3CdSxht/JVkV3izEfNK
         hq9e09W/D0d/gtZNDqU5MIlmrgM10cWrKJzTxvKqN17Uz/CTQklD8JK4uJWvlxXx8jTx
         XzQA9LCrZBeRJ+fwcmsmfkLt/PVIJQq9xt9Ltuz4vAuREgspV3q4orFF9pq6zVautPGK
         9D8M+mEpsNhrQ5ZVl83fCGqMSnntuMxI4yl1bljPeQI8Hq6HY/B9W4C4+Jp8gRXaF3/C
         doBLEzxRCz+QIcToOv6ajB6pFkF1feP4UW0lyUscZknSXOPKKBgSW5nObJeqG9NPIu0C
         UBMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e5YlYwASYbZHVOyqMgrEDdQ4f+mzDqMyHGJNku61KwY=;
        b=moxPuiz5/A4wp4O7LlJz/5PZYi5tUc/+58Kydp7h77vAO1t28gs9O9SAHuJVKr7gx8
         Zx7ODAx0XaCCMKKHLPPtRMAzI+wVWHNEwsnjDME4PLaj8pcJz4whNKvwvxYVqLPVzZsW
         9xlwZMe8Vn5P9BT7DBSoqtecortTR8n/so7HUHHVORKlxRi3K0mrltEp6NkgUx6yiA96
         UkrLNJKh6hS5CtUE/FqWYpsTK8kWlL/3ZDvf0OTeUkPBWNho9S0b8lL5lW+F5tvdO+7d
         mNCMKZ2+ZJSwPpAKIYEKaCGI3NDQWc8MkRLMF5d7EscKowPz7MdbOY5jGgKhpFTs9qRe
         e6Tg==
X-Gm-Message-State: ANoB5pmVJK6tIY3ofe/DrbIUWD1MN3kMOBrQGss5DyF1H7AMbOvS0wNc
        eQ5jzXJq2nIarwaRme+ZwGk=
X-Google-Smtp-Source: AA0mqf79lUC/Piotmvz67H0zUjbuTyt8Y77uGn9SM65ZBqwlT8d3FMY8Bmif+QejiSRTzciJzPCafA==
X-Received: by 2002:a63:3307:0:b0:477:8fed:80fa with SMTP id z7-20020a633307000000b004778fed80famr8898244pgz.96.1669226542349;
        Wed, 23 Nov 2022 10:02:22 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:a80:c968:76:254b:3790])
        by smtp.gmail.com with ESMTPSA id i15-20020a655b8f000000b00470275c8d6dsm10792364pgr.10.2022.11.23.10.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 10:02:22 -0800 (PST)
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
Subject: [PATCH 08/15] perf stat: Use struct outstate in evlist__print_counters()
Date:   Wed, 23 Nov 2022 10:02:01 -0800
Message-Id: <20221123180208.2068936-9-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
In-Reply-To: <20221123180208.2068936-1-namhyung@kernel.org>
References: <20221123180208.2068936-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparation for the later cleanup.  No functional changes
intended.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index d2894a519d61..70aebf359e16 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -1372,13 +1372,16 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
 	bool metric_only = config->metric_only;
 	int interval = config->interval;
 	struct evsel *counter;
-	char buf[64], *prefix = NULL;
+	char buf[64];
+	struct outstate os = {
+		.fh = config->output,
+	};
 
 	if (config->iostat_run)
 		evlist->selected = evlist__first(evlist);
 
 	if (interval) {
-		prefix = buf;
+		os.prefix = buf;
 		prepare_interval(config, buf, sizeof(buf), ts);
 	}
 
@@ -1390,35 +1393,35 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
 	case AGGR_SOCKET:
 	case AGGR_NODE:
 		if (config->cgroup_list)
-			print_aggr_cgroup(config, evlist, prefix);
+			print_aggr_cgroup(config, evlist, os.prefix);
 		else
-			print_aggr(config, evlist, prefix);
+			print_aggr(config, evlist, os.prefix);
 		break;
 	case AGGR_THREAD:
 	case AGGR_GLOBAL:
 		if (config->iostat_run) {
-			iostat_print_counters(evlist, config, ts, prefix = buf,
+			iostat_print_counters(evlist, config, ts, buf,
 					      print_counter);
 		} else if (config->cgroup_list) {
-			print_cgroup_counter(config, evlist, prefix);
+			print_cgroup_counter(config, evlist, os.prefix);
 		} else {
-			print_metric_begin(config, evlist, prefix,
+			print_metric_begin(config, evlist, os.prefix,
 					   /*aggr_idx=*/0, /*cgrp=*/NULL);
 			evlist__for_each_entry(evlist, counter) {
-				print_counter(config, counter, prefix);
+				print_counter(config, counter, os.prefix);
 			}
 			print_metric_end(config);
 		}
 		break;
 	case AGGR_NONE:
 		if (metric_only)
-			print_no_aggr_metric(config, evlist, prefix);
+			print_no_aggr_metric(config, evlist, os.prefix);
 		else {
 			evlist__for_each_entry(evlist, counter) {
 				if (counter->percore)
-					print_percore(config, counter, prefix);
+					print_percore(config, counter, os.prefix);
 				else
-					print_counter(config, counter, prefix);
+					print_counter(config, counter, os.prefix);
 			}
 		}
 		break;
-- 
2.38.1.584.g0f3c55d4c2-goog


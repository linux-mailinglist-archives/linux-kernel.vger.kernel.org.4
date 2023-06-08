Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A87C728BB0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 01:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237046AbjFHXYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 19:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjFHXYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 19:24:05 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A7730D3;
        Thu,  8 Jun 2023 16:24:04 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-662f0feafb2so894664b3a.1;
        Thu, 08 Jun 2023 16:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686266643; x=1688858643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9n2t88k5l25l+V1epjNXEK63vWDBxvkQoOlMhLNqLg=;
        b=SBSIUhPrRrc7qbYg1YEXXpBH7SlseeKKAdZu5PZyANs9ehltKLx93rcU4K/T2IoW8V
         VMkOv9UoLOZNzNxhiTKs9hualW+5WmRmRaScKP2n6jRjVmIjxkfazlqRtFKadnOlTT1m
         3/1JVx4JnBxwz6hmyhSMT7Psd1DuwnOuslVgjwi5UyteRZEZFcR0F5SkljtKupuq42To
         QUI3qg96CIHYKLiAPgYzKrwwOekFkiCzqOtmp6RryNbXe5mK++CzHlDBDyo5Jj7qXmsi
         DR+8pgB7QBxIkehKh5KgI8izK1E5930J73WVWBLdA8e22Q3znZ1E8xEY6TFJBwioic50
         YPpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686266643; x=1688858643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c9n2t88k5l25l+V1epjNXEK63vWDBxvkQoOlMhLNqLg=;
        b=ECjxD05B3fVpA3NjeDIn6pPdf7mKkqoYJ+zX2YJqZzZSvL3ymU8nT4cUbWD9HjkiOE
         SzhB8MV4dEFqUaHtzJisdN6a83EawGYZe5/hmqfb4G+3FrwRW4nKP1dyW+iP/AAQpDao
         0UrchXYaM9w+K0Rvk8IPPpBdgQm4fwintk0+IaF9whT9RaSyAYAKhrw7q4fdT+4RMgBF
         apcwbb3S3j0dTWf5lZ4G0EGT22JitG8k9mUhNfd3T3JUwzxH3MRKay3V/yW0zKnDchk3
         aks8Bnt1tGcSCIy8A+FPEBR5d0O8FuhlHXUqQ18EaEehHApM/ROJhcsaGdUKEhTBodsn
         blmA==
X-Gm-Message-State: AC+VfDxmZA185F8tjTgvjRjtzKTqBnmzbnswNnlBRiPhdS01er+RZ4qO
        mp8SiWB/mpXg6p7seM1mcec=
X-Google-Smtp-Source: ACHHUZ5KzPdFNXDFwLtrz6JBhE7MZHse+1u+WzpT+99I0KSQt8Slf73lo/uQ5vZ8nlza+SJfGMOvTQ==
X-Received: by 2002:a05:6a20:258b:b0:106:5dff:5db5 with SMTP id k11-20020a056a20258b00b001065dff5db5mr3887018pzd.1.1686266643452;
        Thu, 08 Jun 2023 16:24:03 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6700:7f00:c14c:6e39:cb7d:ad66])
        by smtp.gmail.com with ESMTPSA id e18-20020a656792000000b0053f1d55676fsm1618203pgr.2.2023.06.08.16.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 16:24:03 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 1/3] perf list: Check if libpfm4 event is supported
Date:   Thu,  8 Jun 2023 16:23:58 -0700
Message-ID: <20230608232400.3056312-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
In-Reply-To: <20230608232400.3056312-1-namhyung@kernel.org>
References: <20230608232400.3056312-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of its event info cannot be used directly due to missing default
attributes.  Let's check if the event is supported before printing
like we do for hw and cache events.

Cc: Stephane Eranian <eranian@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/pfm.c | 58 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 50 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/pfm.c b/tools/perf/util/pfm.c
index 076aecc22c16..4c1024c343dd 100644
--- a/tools/perf/util/pfm.c
+++ b/tools/perf/util/pfm.c
@@ -13,6 +13,8 @@
 #include "util/pmus.h"
 #include "util/pfm.h"
 #include "util/strbuf.h"
+#include "util/cpumap.h"
+#include "util/thread_map.h"
 
 #include <string.h>
 #include <linux/kernel.h>
@@ -123,6 +125,36 @@ int parse_libpfm_events_option(const struct option *opt, const char *str,
 	return -1;
 }
 
+static bool is_libpfm_event_supported(const char *name, struct perf_cpu_map *cpus,
+				      struct perf_thread_map *threads)
+{
+	struct perf_pmu *pmu;
+	struct evsel *evsel;
+	struct perf_event_attr attr = {};
+	bool result = true;
+	int ret;
+
+	ret = pfm_get_perf_event_encoding(name, PFM_PLM0|PFM_PLM3,
+					  &attr, NULL, NULL);
+	if (ret != PFM_SUCCESS)
+		return false;
+
+	pmu = perf_pmus__find_by_type((unsigned int)attr.type);
+	evsel = parse_events__add_event(0, &attr, name, /*metric_id=*/NULL, pmu);
+	if (evsel == NULL)
+		return false;
+
+	evsel->is_libpfm_event = true;
+
+	if (evsel__open(evsel, cpus, threads) < 0)
+		result = false;
+
+	evsel__close(evsel);
+	evsel__delete(evsel);
+
+	return result;
+}
+
 static const char *srcs[PFM_ATTR_CTRL_MAX] = {
 	[PFM_ATTR_CTRL_UNKNOWN] = "???",
 	[PFM_ATTR_CTRL_PMU] = "PMU",
@@ -146,6 +178,8 @@ print_libpfm_event(const struct print_callbacks *print_cb, void *print_state,
 {
 	int j, ret;
 	char topic[80], name[80];
+	struct perf_cpu_map *cpus = perf_cpu_map__empty_new(1);
+	struct perf_thread_map *threads = thread_map__new_by_tid(0);
 
 	strbuf_setlen(buf, 0);
 	snprintf(topic, sizeof(topic), "pfm %s", pinfo->name);
@@ -185,14 +219,15 @@ print_libpfm_event(const struct print_callbacks *print_cb, void *print_state,
 				    ainfo.name, ainfo.desc);
 		}
 	}
-	print_cb->print_event(print_state,
-			pinfo->name,
-			topic,
-			name, info->equiv,
-			/*scale_unit=*/NULL,
-			/*deprecated=*/NULL, "PFM event",
-			info->desc, /*long_desc=*/NULL,
-			/*encoding_desc=*/buf->buf);
+
+	if (is_libpfm_event_supported(name, cpus, threads)) {
+		print_cb->print_event(print_state, pinfo->name, topic,
+				      name, info->equiv,
+				      /*scale_unit=*/NULL,
+				      /*deprecated=*/NULL, "PFM event",
+				      info->desc, /*long_desc=*/NULL,
+				      /*encoding_desc=*/buf->buf);
+	}
 
 	pfm_for_each_event_attr(j, info) {
 		pfm_event_attr_info_t ainfo;
@@ -215,6 +250,10 @@ print_libpfm_event(const struct print_callbacks *print_cb, void *print_state,
 			print_attr_flags(buf, &ainfo);
 			snprintf(name, sizeof(name), "%s::%s:%s",
 				 pinfo->name, info->name, ainfo.name);
+
+			if (!is_libpfm_event_supported(name, cpus, threads))
+				continue;
+
 			print_cb->print_event(print_state,
 					pinfo->name,
 					topic,
@@ -225,6 +264,9 @@ print_libpfm_event(const struct print_callbacks *print_cb, void *print_state,
 					/*encoding_desc=*/buf->buf);
 		}
 	}
+
+	perf_cpu_map__put(cpus);
+	perf_thread_map__put(threads);
 }
 
 void print_libpfm_events(const struct print_callbacks *print_cb, void *print_state)
-- 
2.41.0.162.gfafddb0af9-goog


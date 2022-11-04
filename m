Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42300618FE4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 06:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbiKDFOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 01:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiKDFOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 01:14:43 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CF6126;
        Thu,  3 Nov 2022 22:14:42 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id u6so3891312plq.12;
        Thu, 03 Nov 2022 22:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=XPT0F7aWd1Zvy4cX41IUsDJJqvU5anaASodKHGZ1l1o=;
        b=EIDao6cwt3mt9nCyjMT/L1NDwSWnQbs6bH/fFjebn3rNpxboSUr9U4b4P/cEXehrLX
         suK0gI6I4gRkZIf/MkN/rguGWySFVxXolqN/HnmjsaeQ3lhKfsbiiZlsoceRQvE136Oi
         t5SqvyG89AVTGHtSNAfVDA0b2cJ61Ecsta58VLLTaQ7iWpTK3YW+9IRPKFA4cCNNGZFW
         cCXiXJT7M4ckSL4jf3ZFCRls/pEy9lXtKI20JVHdEez7smh+vx/m38ywv4xXmrPbUQpt
         /Qc2LFOgcsWRVTZPIVWeNLUK9RVkgIXMBMU993QsxFIbCVPv38klzQIfMydPUV13q7Zy
         zDqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPT0F7aWd1Zvy4cX41IUsDJJqvU5anaASodKHGZ1l1o=;
        b=g6nxC4vQ+mWhzaDmo535Fx9jullRSXbzPZkUA/7K97x5UgkK9nFpA12flzI+4UdIZS
         4Jy5orLfbRuvyMKnPU0/GI/biYhv05dkTmVulOKzNbV1NrAuq2eXmpPQhHWNRdAwrkI9
         Zo8JL4xAT5+gfh75rcnXf0cdqBMGknyNjvDeRyOm+YTi80zxssT3Tce3LNFlvSQE96vP
         7wP6VF6m6uMMyi82tQ5LsWsy7PuTRDgPnLwtXN3jpKel0+Rf7PsOEHTHrnvDT3F8zH8D
         1kNQa23E3RwYEuHAQGJnWDw4obFDrNtenUURNCamuJiz6/QY1F6+JX1d5M5mh0s9l8By
         OCog==
X-Gm-Message-State: ACrzQf1+K+hBHpl9hc5RqzXmErYhUspjUXxoRoo5GUXfQIKG8YK7P53d
        i+M5UtiiUj3ZGnEr9/vD3LfYiTm7f6U=
X-Google-Smtp-Source: AMsMyM65onVSq7q+e0vpzcWusfs84J6zPwyDIQIKmYnJnHS1dJd1GbZNYzoGCi007J0JvAfR39vR0A==
X-Received: by 2002:a17:903:2348:b0:186:970e:739e with SMTP id c8-20020a170903234800b00186970e739emr34339612plh.115.1667538882376;
        Thu, 03 Nov 2022 22:14:42 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:a80:db74:6cd1:5932:e363])
        by smtp.gmail.com with ESMTPSA id g8-20020a170902868800b0017ec1b1bf9fsm1546309plo.217.2022.11.03.22.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 22:14:41 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH] perf lock: Allow concurrent record and report
Date:   Thu,  3 Nov 2022 22:14:40 -0700
Message-Id: <20221104051440.220989-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
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

To support live monitoring of kernel lock contention without BPF,
it should support something like below:

  # perf lock record -a -o- sleep 1 | perf lock contention -i-
   contended   total wait     max wait     avg wait         type   caller

           2     10.27 us      6.17 us      5.13 us     spinlock   load_balance+0xc03
           1      5.29 us      5.29 us      5.29 us     rwlock:W   ep_scan_ready_list+0x54
           1      4.12 us      4.12 us      4.12 us     spinlock   smpboot_thread_fn+0x116
           1      3.28 us      3.28 us      3.28 us        mutex   pipe_read+0x50

To do that, it needs to handle HEAD_ATTR, HEADER_EVENT_UPDATE and
HEADER_TRACING_DATA which are generated only for the pipe mode.
And setting event handler also should be delayed until it gets the
event information.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-lock.c                 | 68 +++++++++++++++--------
 tools/perf/tests/shell/lock_contention.sh | 15 ++++-
 2 files changed, 60 insertions(+), 23 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 6f79175365a8..0d280093b19a 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1390,6 +1390,34 @@ static int dump_info(void)
 	return rc;
 }
 
+static const struct evsel_str_handler lock_tracepoints[] = {
+	{ "lock:lock_acquire",	 evsel__process_lock_acquire,   }, /* CONFIG_LOCKDEP */
+	{ "lock:lock_acquired",	 evsel__process_lock_acquired,  }, /* CONFIG_LOCKDEP, CONFIG_LOCK_STAT */
+	{ "lock:lock_contended", evsel__process_lock_contended, }, /* CONFIG_LOCKDEP, CONFIG_LOCK_STAT */
+	{ "lock:lock_release",	 evsel__process_lock_release,   }, /* CONFIG_LOCKDEP */
+};
+
+static const struct evsel_str_handler contention_tracepoints[] = {
+	{ "lock:contention_begin", evsel__process_contention_begin, },
+	{ "lock:contention_end",   evsel__process_contention_end,   },
+};
+
+static int process_event_update(struct perf_tool *tool,
+				union perf_event *event,
+				struct evlist **pevlist)
+{
+	int ret;
+
+	ret = perf_event__process_event_update(tool, event, pevlist);
+	if (ret < 0)
+		return ret;
+
+	/* this can return -EEXIST since we call it for each evsel */
+	perf_session__set_tracepoints_handlers(session, lock_tracepoints);
+	perf_session__set_tracepoints_handlers(session, contention_tracepoints);
+	return 0;
+}
+
 typedef int (*tracepoint_handler)(struct evsel *evsel,
 				  struct perf_sample *sample);
 
@@ -1545,28 +1573,19 @@ static void print_contention_result(struct lock_contention *con)
 	print_bad_events(bad, total);
 }
 
-static const struct evsel_str_handler lock_tracepoints[] = {
-	{ "lock:lock_acquire",	 evsel__process_lock_acquire,   }, /* CONFIG_LOCKDEP */
-	{ "lock:lock_acquired",	 evsel__process_lock_acquired,  }, /* CONFIG_LOCKDEP, CONFIG_LOCK_STAT */
-	{ "lock:lock_contended", evsel__process_lock_contended, }, /* CONFIG_LOCKDEP, CONFIG_LOCK_STAT */
-	{ "lock:lock_release",	 evsel__process_lock_release,   }, /* CONFIG_LOCKDEP */
-};
-
-static const struct evsel_str_handler contention_tracepoints[] = {
-	{ "lock:contention_begin", evsel__process_contention_begin, },
-	{ "lock:contention_end",   evsel__process_contention_end,   },
-};
-
 static bool force;
 
 static int __cmd_report(bool display_info)
 {
 	int err = -EINVAL;
 	struct perf_tool eops = {
+		.attr		 = perf_event__process_attr,
+		.event_update	 = process_event_update,
 		.sample		 = process_sample_event,
 		.comm		 = perf_event__process_comm,
 		.mmap		 = perf_event__process_mmap,
 		.namespaces	 = perf_event__process_namespaces,
+		.tracing_data	 = perf_event__process_tracing_data,
 		.ordered_events	 = true,
 	};
 	struct perf_data data = {
@@ -1585,17 +1604,19 @@ static int __cmd_report(bool display_info)
 	symbol_conf.sort_by_name = true;
 	symbol__init(&session->header.env);
 
-	if (!perf_session__has_traces(session, "lock record"))
-		goto out_delete;
+	if (!data.is_pipe) {
+		if (!perf_session__has_traces(session, "lock record"))
+			goto out_delete;
 
-	if (perf_session__set_tracepoints_handlers(session, lock_tracepoints)) {
-		pr_err("Initializing perf session tracepoint handlers failed\n");
-		goto out_delete;
-	}
+		if (perf_session__set_tracepoints_handlers(session, lock_tracepoints)) {
+			pr_err("Initializing perf session tracepoint handlers failed\n");
+			goto out_delete;
+		}
 
-	if (perf_session__set_tracepoints_handlers(session, contention_tracepoints)) {
-		pr_err("Initializing perf session tracepoint handlers failed\n");
-		goto out_delete;
+		if (perf_session__set_tracepoints_handlers(session, contention_tracepoints)) {
+			pr_err("Initializing perf session tracepoint handlers failed\n");
+			goto out_delete;
+		}
 	}
 
 	if (setup_output_field(false, output_fields))
@@ -1633,9 +1654,12 @@ static int __cmd_contention(int argc, const char **argv)
 {
 	int err = -EINVAL;
 	struct perf_tool eops = {
+		.attr		 = perf_event__process_attr,
+		.event_update	 = process_event_update,
 		.sample		 = process_sample_event,
 		.comm		 = perf_event__process_comm,
 		.mmap		 = perf_event__process_mmap,
+		.tracing_data	 = perf_event__process_tracing_data,
 		.ordered_events	 = true,
 	};
 	struct perf_data data = {
@@ -1698,7 +1722,7 @@ static int __cmd_contention(int argc, const char **argv)
 			pr_err("lock contention BPF setup failed\n");
 			goto out_delete;
 		}
-	} else {
+	} else if (!data.is_pipe) {
 		if (!perf_session__has_traces(session, "lock record"))
 			goto out_delete;
 
diff --git a/tools/perf/tests/shell/lock_contention.sh b/tools/perf/tests/shell/lock_contention.sh
index 04bf604e3c6f..f7bd0d8eb5c3 100755
--- a/tools/perf/tests/shell/lock_contention.sh
+++ b/tools/perf/tests/shell/lock_contention.sh
@@ -53,7 +53,7 @@ test_bpf()
 
 	if ! perf lock con -b true > /dev/null 2>&1 ; then
 		echo "[Skip] No BPF support"
-		exit
+		return
 	fi
 
 	# the perf lock contention output goes to the stderr
@@ -65,9 +65,22 @@ test_bpf()
 	fi
 }
 
+test_record_concurrent()
+{
+	echo "Testing perf lock record and perf lock contention at the same time"
+	perf lock record -o- -- perf bench sched messaging 2> /dev/null | \
+	perf lock contention -i- -E 1 -q 2> ${result}
+	if [ $(cat "${result}" | wc -l) != "1" ]; then
+		echo "[Fail] Recorded result count is not 1:" $(cat "${result}" | wc -l)
+		err=1
+		exit
+	fi
+}
+
 check
 
 test_record
 test_bpf
+test_record_concurrent
 
 exit ${err}
-- 
2.38.1.431.g37b22c650d-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003446020CE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbiJRCEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiJRCDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:03:25 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32588C017;
        Mon, 17 Oct 2022 19:02:57 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id t12-20020a17090a3b4c00b0020b04251529so12621481pjf.5;
        Mon, 17 Oct 2022 19:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vrftxqnxBQhQyNqtAur/XWhtXNA2wVab7OVanH9H7Pg=;
        b=J5s0GVmsqS7aVyRIl9LUJmVXMfrxqFVu5oso9YVMKcfFZrOeJ5gAksIn1s86O59zwS
         iHyML14kB57RNpwPGY5nIbzOYWlVuo6H3uoEnzghuPR/nfNPnilV62RM1tBTte3H0L/m
         z7P6bnTznAUrWOLQEZLCC5wq9zabCT6u1l7eoDBjhlWdDaET3Z36fnkJrlB8tJqUXDR6
         huc2RDDQEQh/LTi2E0NA41UsTWAj0QKW10GTtKJ2O4qArXFiORMNcbsge0ozGygAEDIH
         59D3KTj+WMzL+eFZ84k6AvXGLY5Fprjw/+52MdLQw5zWoiCvCxAzvJnFZUAwdLDO5T87
         5/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vrftxqnxBQhQyNqtAur/XWhtXNA2wVab7OVanH9H7Pg=;
        b=BtveAeEs/ku1bbU65sOCGTpdpMHdRno+JybVbdZh+W0usBJG9xFRrgT158i36Zew0D
         JEfFPYxI+ok3OfC4c8QCRHy9s8qSD6IMKd7lvOH5gabse/RcdZPrh2suIH9lSm2bgD5O
         WKlxhDgcnVBmoJlr26VbdQ+0i3yAbO9EJW4duBguHrTJRb6KNf5KtP0lVtOmtL2+IQL7
         Pd+7uAV66S2uLE6+mpd3lIL1nM6iYqWRjZNVyC4lQeNimJAf+bJcyVuiS8xfXdPfhVAs
         YMpQNbQxAb0AXaNM7gufwWxwJsGLJ/Gy7YzMxXrIc8MNm11RGZCRncNjKKdrTyxDIkny
         vCiw==
X-Gm-Message-State: ACrzQf1GSVHYkkhqDIko7KhPlIDP+m9UQF5wfAvzYe/ZFF77TCpB4Yej
        Owv04MhnWNu4rXg7u9/pbv0=
X-Google-Smtp-Source: AMsMyM7qjn9K5xvDS88FNqUg+5WQLHCspnaolwsFApuWUziDs4AkSoYcEfHTGhXgXXT+KrgW3gWLFw==
X-Received: by 2002:a17:902:f647:b0:183:cb8d:40a0 with SMTP id m7-20020a170902f64700b00183cb8d40a0mr864835plg.18.1666058575855;
        Mon, 17 Oct 2022 19:02:55 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1f90:85c4:58f0:7a81:6bb5])
        by smtp.gmail.com with ESMTPSA id t4-20020a655544000000b00464858cf6b0sm6851564pgr.54.2022.10.17.19.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 19:02:55 -0700 (PDT)
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
Subject: [PATCH 14/20] perf stat: Split process_counters()
Date:   Mon, 17 Oct 2022 19:02:21 -0700
Message-Id: <20221018020227.85905-15-namhyung@kernel.org>
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

It'd do more processing with aggregation.  Let's split the function so that it
can be shared with by process_stat_round_event() too.

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-stat.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index bff28a199dfd..838d29590bed 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -465,15 +465,19 @@ static int read_bpf_map_counters(void)
 	return 0;
 }
 
-static void read_counters(struct timespec *rs)
+static int read_counters(struct timespec *rs)
 {
-	struct evsel *counter;
-
 	if (!stat_config.stop_read_counter) {
 		if (read_bpf_map_counters() ||
 		    read_affinity_counters(rs))
-			return;
+			return -1;
 	}
+	return 0;
+}
+
+static void process_counters(void)
+{
+	struct evsel *counter;
 
 	evlist__for_each_entry(evsel_list, counter) {
 		if (counter->err)
@@ -494,7 +498,8 @@ static void process_interval(void)
 	perf_stat__reset_shadow_per_stat(&rt_stat);
 	evlist__reset_aggr_stats(evsel_list);
 
-	read_counters(&rs);
+	if (read_counters(&rs) == 0)
+		process_counters();
 
 	if (STAT_RECORD) {
 		if (WRITE_STAT_ROUND_EVENT(rs.tv_sec * NSEC_PER_SEC + rs.tv_nsec, INTERVAL))
@@ -980,7 +985,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	 * avoid arbitrary skew, we must read all counters before closing any
 	 * group leaders.
 	 */
-	read_counters(&(struct timespec) { .tv_nsec = t1-t0 });
+	if (read_counters(&(struct timespec) { .tv_nsec = t1-t0 }) == 0)
+		process_counters();
 
 	/*
 	 * We need to keep evsel_list alive, because it's processed
@@ -2099,13 +2105,11 @@ static int process_stat_round_event(struct perf_session *session,
 				    union perf_event *event)
 {
 	struct perf_record_stat_round *stat_round = &event->stat_round;
-	struct evsel *counter;
 	struct timespec tsh, *ts = NULL;
 	const char **argv = session->header.env.cmdline_argv;
 	int argc = session->header.env.nr_cmdline;
 
-	evlist__for_each_entry(evsel_list, counter)
-		perf_stat_process_counter(&stat_config, counter);
+	process_counters();
 
 	if (stat_round->type == PERF_STAT_ROUND_TYPE__FINAL)
 		update_stats(&walltime_nsecs_stats, stat_round->time);
-- 
2.38.0.413.g74048e4d9e-goog


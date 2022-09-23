Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D747C5E80BD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 19:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbiIWRcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 13:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiIWRcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 13:32:08 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900A014F2A1;
        Fri, 23 Sep 2022 10:32:07 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id b5so857695pgb.6;
        Fri, 23 Sep 2022 10:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=5PHrBpaLmFDY14A8P3/p/i6zli4t31/pKCbt5puH1sg=;
        b=qV8l3RPUZ3d79Gf0qgSnmAAsiSvRLHPF6OYAQnDsdUOXyMVzkRzRSsyUcWAfmWSprr
         D+6wYFBQQKtVP29ah1rr2mteTyA+ZsCp1bQdJHHLjpaCeCWhAewMRMzd3RebfE0clnTN
         RkMauZ6b1XqPS+vk+1+O0Teq4SSeHu1QOpCZRDhbGs158Z1dwLGC5jctL+LF4zUnMbDV
         MVI87qfeU+SYAJl97xaPBj4wGiVQQY9ELpqXcLV9v5844ID4v9eq2x0rh7AN7QskvsV9
         Ujybywk86X458hKW50GXHST1MplQJbaOLqOFXrQhuZye9PdQwWDhqMg8lDG0VD0LXV2o
         Jgkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=5PHrBpaLmFDY14A8P3/p/i6zli4t31/pKCbt5puH1sg=;
        b=ammSnC0xZ+A6Ak5Xhuz/TVdTJ1AuTezhjrLlHCD3PEv2hs9Xpza+QU8GJsKZmY4m3Z
         pKxkxFm+vz177hW+f2BZhTtGRLNOtCPS+KslMOUy+0On8RVYtsbQ+l1+iryal145m5AK
         S4L/hDJmbsFwJoJbTHpi/boiX5tCV+iNW+8gH+/KkvqhTsnQL/vTrIrYG57PKQP2HPYH
         voCW994YES+8SXC4Tz03RLmkTNZI5YO3Z1flZLmy8/ea6rYaNuBEAsUH1dP0J93sI0bz
         g7nLpLJfv3a5rLgt/2eXTcgL534iKHvaGR6jx1oMM7xQKYKWlmPBxssNM8qST+e/rlM5
         4FJw==
X-Gm-Message-State: ACrzQf1wn7jY5ZhU0nGXDTU6uFFE6PYwznlbcQSJVEQ/5IZXiUIdQ5Pe
        wCaauXnT4iK6Y4up/wcpfWc=
X-Google-Smtp-Source: AMsMyM4iOCuCbaT0xO9kB+pRgLvb4nBmRRmPzgdgDNJJbk5PvF7HxmWNrPX0oWjRINlVR9UAiRqJ4Q==
X-Received: by 2002:a63:8a4a:0:b0:438:6a17:f0bb with SMTP id y71-20020a638a4a000000b004386a17f0bbmr8352448pgd.267.1663954327019;
        Fri, 23 Sep 2022 10:32:07 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:c716:a857:50ee:f56e])
        by smtp.gmail.com with ESMTPSA id 9-20020a621409000000b0053e6eae9668sm6719499pfu.2.2022.09.23.10.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 10:32:06 -0700 (PDT)
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
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 3/4] perf tools: Add 'addr' sort key
Date:   Fri, 23 Sep 2022 10:31:41 -0700
Message-Id: <20220923173142.805896-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
In-Reply-To: <20220923173142.805896-1-namhyung@kernel.org>
References: <20220923173142.805896-1-namhyung@kernel.org>
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

Sometimes users want to see actual (virtual) address of sampled instructions.
Add a new 'addr' sort key to display the raw addresses.

  $ perf record -o- true | perf report -i- -s addr
  # To display the perf.data header info, please use --header/--header-only options.
  #
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.000 MB - ]
  #
  # Total Lost Samples: 0
  #
  # Samples: 12  of event 'cycles:u'
  # Event count (approx.): 252512
  #
  # Overhead  Address
  # ........  ..................
  #
      42.96%  0x7f96f08443d7
      29.55%  0x7f96f0859b50
      14.76%  0x7f96f0852e02
       8.30%  0x7f96f0855028
       4.43%  0xffffffff8de01087

Note that it just compares and displays the sample ip.  Each process can
have a different memory layout and the ip will be different even if they run
the same binary.  So this sort key is mostly meaningful for per-process
profile data.

Cc: Stephane Eranian <eranian@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-report.txt |  3 +-
 tools/perf/util/hist.c                   |  1 +
 tools/perf/util/hist.h                   |  1 +
 tools/perf/util/sort.c                   | 38 ++++++++++++++++++++++++
 tools/perf/util/sort.h                   |  1 +
 5 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 24efc0583c93..4533db2ee56b 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -73,7 +73,7 @@ OPTIONS
 	Sort histogram entries by given key(s) - multiple keys can be specified
 	in CSV format.  Following sort keys are available:
 	pid, comm, dso, symbol, parent, cpu, socket, srcline, weight,
-	local_weight, cgroup_id.
+	local_weight, cgroup_id, addr.
 
 	Each key has following meaning:
 
@@ -114,6 +114,7 @@ OPTIONS
 	- local_ins_lat: Local instruction latency version
 	- p_stage_cyc: On powerpc, this presents the number of cycles spent in a
 	  pipeline stage. And currently supported only on powerpc.
+	- addr: (Full) virtual address of the sampled instruction
 
 	By default, comm, dso and symbol keys are used.
 	(i.e. --sort comm,dso,symbol)
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 06f5dbf213ad..17a05e943b44 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -215,6 +215,7 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 	hists__new_col_len(hists, HISTC_GLOBAL_INS_LAT, 13);
 	hists__new_col_len(hists, HISTC_LOCAL_P_STAGE_CYC, 13);
 	hists__new_col_len(hists, HISTC_GLOBAL_P_STAGE_CYC, 13);
+	hists__new_col_len(hists, HISTC_ADDR, BITS_PER_LONG / 4 + 2);
 
 	if (symbol_conf.nanosecs)
 		hists__new_col_len(hists, HISTC_TIME, 16);
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index c7a7a3fa0b87..ebd8a8f783ee 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -79,6 +79,7 @@ enum hist_column {
 	HISTC_GLOBAL_P_STAGE_CYC,
 	HISTC_ADDR_FROM,
 	HISTC_ADDR_TO,
+	HISTC_ADDR,
 	HISTC_NR_COLS, /* Last entry */
 };
 
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 6d5588e80935..2e7330867e2e 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -1948,6 +1948,43 @@ struct sort_entry sort_dso_size = {
 	.se_width_idx	= HISTC_DSO_SIZE,
 };
 
+/* --sort dso_size */
+
+static int64_t
+sort__addr_cmp(struct hist_entry *left, struct hist_entry *right)
+{
+	u64 left_ip = left->ip;
+	u64 right_ip = right->ip;
+	struct map *left_map = left->ms.map;
+	struct map *right_map = right->ms.map;
+
+	if (left_map)
+		left_ip = left_map->unmap_ip(left_map, left_ip);
+	if (right_map)
+		right_ip = right_map->unmap_ip(right_map, right_ip);
+
+	return _sort__addr_cmp(left_ip, right_ip);
+}
+
+static int hist_entry__addr_snprintf(struct hist_entry *he, char *bf,
+				     size_t size, unsigned int width)
+{
+	u64 ip = he->ip;
+	struct map *map = he->ms.map;
+
+	if (map)
+		ip = map->unmap_ip(map, ip);
+
+	return repsep_snprintf(bf, size, "%-#*llx", width, ip);
+}
+
+struct sort_entry sort_addr = {
+	.se_header	= "Address",
+	.se_cmp		= sort__addr_cmp,
+	.se_snprintf	= hist_entry__addr_snprintf,
+	.se_width_idx	= HISTC_ADDR,
+};
+
 
 struct sort_dimension {
 	const char		*name;
@@ -1997,6 +2034,7 @@ static struct sort_dimension common_sort_dimensions[] = {
 	DIM(SORT_GLOBAL_INS_LAT, "ins_lat", sort_global_ins_lat),
 	DIM(SORT_LOCAL_PIPELINE_STAGE_CYC, "local_p_stage_cyc", sort_local_p_stage_cyc),
 	DIM(SORT_GLOBAL_PIPELINE_STAGE_CYC, "p_stage_cyc", sort_global_p_stage_cyc),
+	DIM(SORT_ADDR, "addr", sort_addr),
 };
 
 #undef DIM
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index af14eb46c2b6..04ff8b61a2a7 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -236,6 +236,7 @@ enum sort_type {
 	SORT_GLOBAL_INS_LAT,
 	SORT_LOCAL_PIPELINE_STAGE_CYC,
 	SORT_GLOBAL_PIPELINE_STAGE_CYC,
+	SORT_ADDR,
 
 	/* branch stack specific sort keys */
 	__SORT_BRANCH_STACK,
-- 
2.37.3.998.g577e59143f-goog


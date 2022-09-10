Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0F45B4380
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 03:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiIJBIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 21:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiIJBIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 21:08:35 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56788F7540;
        Fri,  9 Sep 2022 18:08:30 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id pj10so2969638pjb.2;
        Fri, 09 Sep 2022 18:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date;
        bh=E0zQ0wgtvLvPGvwKbWqlgBysADfyfAACYnsMMSrEBmM=;
        b=h+E5Zu1z93IojTLtyv6sClDG5YvE2NYT6N9r8zAgPtePlZj/spo7wVCWEHIlsgIM3A
         K676WV67a5stcp0tAEcZMvjLvM6JOcvtwtxOFr6N7vfNM4gBlJU9loRKMQiv9wUTbNP/
         PonZ4AkdZC7dKF4kr3U/yPavuH+Ulr126n4bloQg1LIWLHO5wqXQw0hs4MxMBmi5bcCW
         UbZiTena4uDt7zZ16m9q3qgQc3z0IAO82oK/JDe/zPXUfF6IfCPIYOn9YlIWRFsFnZsH
         wGBb2UlR4RjvWIQA2KsIbnRrG46uArWJEc7LCX2Y1ZGUwXLJinwyzjFluBFtbTtoJohm
         ORrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=E0zQ0wgtvLvPGvwKbWqlgBysADfyfAACYnsMMSrEBmM=;
        b=M40lnH4UrRTV0Kj1naHvwS0xAk0Dfo4Vm7cxKg9mqyuYkuudI55Hd4GBp6e3xfj4hg
         z7jhxlQck2p4rS47HfQrnMru3xNzG+D4sdsqpwf5xqZ6kct+Av3GA9gUY7k3myfC1EEJ
         2JPql9u63tTz2z/5hTVSc+h8H0Lh9nJmjXlCPG3elHkRL7r0dI4rPRTYPl6IPjVWNUDf
         foqYrAcVLrZB8GolasoBVdRRs2lwcU/x69H1J0L4IBfH1csc+22zmi26zNAiGkekutRf
         qI6oEt+ykkuP8jE0yCzH4k7+jqERKJSdQG2tozaJQmHsBDvJxaQUt8V5E6Art/6r/i9V
         J26Q==
X-Gm-Message-State: ACgBeo0LtXTwo9UxKWpHBsyrID2RN2EGZtJII3ERTJD4xgaSjI/DzX/+
        ntJxtCgg7/YtGoEkihBM04c=
X-Google-Smtp-Source: AA6agR7ycBD8yDYLiyXHygfhRUUmo8DhlbR8z1WKiTg+rdWcQxNG41z3noj8OB/veB1PkDpp4bt5SQ==
X-Received: by 2002:a17:90b:33cf:b0:202:5183:c1ab with SMTP id lk15-20020a17090b33cf00b002025183c1abmr12195572pjb.117.1662772109717;
        Fri, 09 Sep 2022 18:08:29 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:f2b:e437:9e3e:53ec])
        by smtp.gmail.com with ESMTPSA id x8-20020a170902a38800b00176c891c893sm1069493pla.131.2022.09.09.18.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 18:08:28 -0700 (PDT)
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
Subject: [PATCH] perf tools: Add 'addr' sort key
Date:   Fri,  9 Sep 2022 18:08:18 -0700
Message-Id: <20220910010818.318746-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
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
index 2ddc00d1c464..4023d8ea6b8e 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -237,6 +237,7 @@ enum sort_type {
 	SORT_GLOBAL_INS_LAT,
 	SORT_LOCAL_PIPELINE_STAGE_CYC,
 	SORT_GLOBAL_PIPELINE_STAGE_CYC,
+	SORT_ADDR,
 
 	/* branch stack specific sort keys */
 	__SORT_BRANCH_STACK,
-- 
2.37.2.789.g6183377224-goog


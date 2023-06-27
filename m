Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7156973F37E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 06:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjF0EgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 00:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbjF0Efw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 00:35:52 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA55419B6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 21:35:36 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-570022400b9so51021177b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 21:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687840536; x=1690432536;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KfqyfRtg18gIZYkUXiTLmJqcy7MrupNBHNFvvJ3kwbY=;
        b=uUa0GHDSmTdC1OY288qT6WujmCm8OaEDhIICStL9XgIsdCNTlQJfzsYSCny/Yl69Ug
         1r20WsIvi+jfhbRLaBDt8KIdlv/FtIFyXowN6v7uWGBQp8s6OZiDdba3hgdQ2k5QgDnD
         5dFqFNqnhK7MUUu97mk4a4LBBZw2lizgwTs4D/oEBQErrc+ooDbUozrUdXWItplTf/Va
         nXeVEU9Mhz5ttSmt27FXVF+vJuHgxXsz69qCckn/HPbhzvpG0qOx75cLP2Wy5kGwf7eM
         iAvVeNv9Uas8ykSCYCCsbyqFljDGHpLB7nEk6XhYWZGZNUmdTXH3MI8bjCYbgqZ/Aiav
         kfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687840536; x=1690432536;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KfqyfRtg18gIZYkUXiTLmJqcy7MrupNBHNFvvJ3kwbY=;
        b=TYuL3R+RxMW+JTuBhfakj+FEYFtWfPL41+ZC0hMl1Bk14sMSYtKLDzX0I1r3LMoW2H
         mYdfO3rBnSYuDPIjLfqwUE3vTkcc9BFVMHgVVSSgdyu98F6MhGRZ7Gi4+al8SKrHAgbk
         nffTNL8+J7xJC5SUwBznv+HwnqK6oa1gNiC/EO8LWWHvjanJE7Eod94uNbMApuq15FWa
         N1Nu+2lmnZNT5XwR51H+cNCeS3wZ26Mmlq70/yVUkGSMdBl0iCXuwy+4VabWvPsZzLMC
         enet65T/Dq+fC+OYWeYLTmlSOxObkX/MSz2Czz1qiG8Aujdf2b7VhdEplAl6VnT7mPtV
         BkzA==
X-Gm-Message-State: AC+VfDyQeZIG12xnVS83RHiI8lLBzFrfpoN72BBHmNTPVO0XxGMG+Dq6
        Sh61JJVGhpnHbhIiSwwp5RII2LxhRjjH
X-Google-Smtp-Source: ACHHUZ5C9OApc+1nfa0uBRBzoFtFmwI1Cy8S9CuTlc1BrPDpKqhgVpBn5tmZXQVKrunsgWHmGJvnSGXaIs3A
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:497e:a125:3cde:94f])
 (user=irogers job=sendgmr) by 2002:a81:d006:0:b0:573:9e16:2cca with SMTP id
 v6-20020a81d006000000b005739e162ccamr7436194ywi.0.1687840535819; Mon, 26 Jun
 2023 21:35:35 -0700 (PDT)
Date:   Mon, 26 Jun 2023 21:34:53 -0700
In-Reply-To: <20230627043458.662048-1-irogers@google.com>
Message-Id: <20230627043458.662048-9-irogers@google.com>
Mime-Version: 1.0
References: <20230627043458.662048-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v1 08/13] perf parse-events: Move instances of YYABORT to YYNOMEM
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Migration to improve error reporting as YYABORT cases should carry
event parsing errors.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.y | 58 +++++++++++++++++++++++-----------
 1 file changed, 40 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index d22866b97b76..eaf43bd8fe3f 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -390,7 +390,8 @@ value_sym '/' event_config '/'
 	bool wildcard = (type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE);
 
 	list = alloc_list();
-	ABORT_ON(!list);
+	if (!list)
+		YYNOMEM;
 	err = parse_events_add_numeric(_parse_state, list, type, config, $3, wildcard);
 	parse_events_terms__delete($3);
 	if (err) {
@@ -408,7 +409,8 @@ value_sym sep_slash_slash_dc
 	bool wildcard = (type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE);
 
 	list = alloc_list();
-	ABORT_ON(!list);
+	if (!list)
+		YYNOMEM;
 	ABORT_ON(parse_events_add_numeric(_parse_state, list, type, config,
 					  /*head_config=*/NULL, wildcard));
 	$$ = list;
@@ -419,7 +421,8 @@ PE_VALUE_SYM_TOOL sep_slash_slash_dc
 	struct list_head *list;
 
 	list = alloc_list();
-	ABORT_ON(!list);
+	if (!list)
+		YYNOMEM;
 	ABORT_ON(parse_events_add_tool(_parse_state, list, $1));
 	$$ = list;
 }
@@ -432,7 +435,9 @@ PE_LEGACY_CACHE opt_event_config
 	int err;
 
 	list = alloc_list();
-	ABORT_ON(!list);
+	if (!list)
+		YYNOMEM;
+
 	err = parse_events_add_cache(list, &parse_state->idx, $1, parse_state, $2);
 
 	parse_events_terms__delete($2);
@@ -451,7 +456,9 @@ PE_PREFIX_MEM PE_VALUE PE_BP_SLASH PE_VALUE PE_BP_COLON PE_MODIFIER_BP opt_event
 	int err;
 
 	list = alloc_list();
-	ABORT_ON(!list);
+	if (!list)
+		YYNOMEM;
+
 	err = parse_events_add_breakpoint(_parse_state, list,
 					  $2, $6, $4, $7);
 	parse_events_terms__delete($7);
@@ -469,7 +476,9 @@ PE_PREFIX_MEM PE_VALUE PE_BP_SLASH PE_VALUE opt_event_config
 	int err;
 
 	list = alloc_list();
-	ABORT_ON(!list);
+	if (!list)
+		YYNOMEM;
+
 	err = parse_events_add_breakpoint(_parse_state, list,
 					  $2, NULL, $4, $5);
 	parse_events_terms__delete($5);
@@ -486,7 +495,9 @@ PE_PREFIX_MEM PE_VALUE PE_BP_COLON PE_MODIFIER_BP opt_event_config
 	int err;
 
 	list = alloc_list();
-	ABORT_ON(!list);
+	if (!list)
+		YYNOMEM;
+
 	err = parse_events_add_breakpoint(_parse_state, list,
 					  $2, $4, 0, $5);
 	parse_events_terms__delete($5);
@@ -504,7 +515,8 @@ PE_PREFIX_MEM PE_VALUE opt_event_config
 	int err;
 
 	list = alloc_list();
-	ABORT_ON(!list);
+	if (!list)
+		YYNOMEM;
 	err = parse_events_add_breakpoint(_parse_state, list,
 					  $2, NULL, 0, $3);
 	parse_events_terms__delete($3);
@@ -524,7 +536,8 @@ tracepoint_name opt_event_config
 	int err;
 
 	list = alloc_list();
-	ABORT_ON(!list);
+	if (!list)
+		YYNOMEM;
 	if (error)
 		error->idx = @1.first_column;
 
@@ -556,7 +569,8 @@ PE_VALUE ':' PE_VALUE opt_event_config
 	int err;
 
 	list = alloc_list();
-	ABORT_ON(!list);
+	if (!list)
+		YYNOMEM;
 	err = parse_events_add_numeric(_parse_state, list, (u32)$1, $3, $4,
 				       /*wildcard=*/false);
 	parse_events_terms__delete($4);
@@ -575,7 +589,8 @@ PE_RAW opt_event_config
 	u64 num;
 
 	list = alloc_list();
-	ABORT_ON(!list);
+	if (!list)
+		YYNOMEM;
 	errno = 0;
 	num = strtoull($1 + 1, NULL, 16);
 	ABORT_ON(errno);
@@ -598,7 +613,8 @@ PE_BPF_OBJECT opt_event_config
 	int err;
 
 	list = alloc_list();
-	ABORT_ON(!list);
+	if (!list)
+		YYNOMEM;
 	err = parse_events_load_bpf(parse_state, list, $1, false, $2);
 	parse_events_terms__delete($2);
 	free($1);
@@ -615,7 +631,8 @@ PE_BPF_SOURCE opt_event_config
 	int err;
 
 	list = alloc_list();
-	ABORT_ON(!list);
+	if (!list)
+		YYNOMEM;
 	err = parse_events_load_bpf(_parse_state, list, $1, true, $2);
 	parse_events_terms__delete($2);
 	if (err) {
@@ -680,7 +697,8 @@ event_term
 	struct list_head *head = malloc(sizeof(*head));
 	struct parse_events_term *term = $1;
 
-	ABORT_ON(!head);
+	if (!head)
+		YYNOMEM;
 	INIT_LIST_HEAD(head);
 	list_add_tail(&term->list, head);
 	$$ = head;
@@ -857,7 +875,8 @@ PE_DRV_CFG_TERM
 	struct parse_events_term *term;
 	char *config = strdup($1);
 
-	ABORT_ON(!config);
+	if (!config)
+		YYNOMEM;
 	if (parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE_DRV_CFG,
 					config, $1, &@1, NULL)) {
 		free($1);
@@ -888,7 +907,8 @@ array_terms ',' array_term
 	new_array.ranges = realloc($1.ranges,
 				sizeof(new_array.ranges[0]) *
 				new_array.nr_ranges);
-	ABORT_ON(!new_array.ranges);
+	if (!new_array.ranges)
+		YYNOMEM;
 	memcpy(&new_array.ranges[$1.nr_ranges], $3.ranges,
 	       $3.nr_ranges * sizeof(new_array.ranges[0]));
 	free($3.ranges);
@@ -904,7 +924,8 @@ PE_VALUE
 
 	array.nr_ranges = 1;
 	array.ranges = malloc(sizeof(array.ranges[0]));
-	ABORT_ON(!array.ranges);
+	if (!array.ranges)
+		YYNOMEM;
 	array.ranges[0].start = $1;
 	array.ranges[0].length = 1;
 	$$ = array;
@@ -917,7 +938,8 @@ PE_VALUE PE_ARRAY_RANGE PE_VALUE
 	ABORT_ON($3 < $1);
 	array.nr_ranges = 1;
 	array.ranges = malloc(sizeof(array.ranges[0]));
-	ABORT_ON(!array.ranges);
+	if (!array.ranges)
+		YYNOMEM;
 	array.ranges[0].start = $1;
 	array.ranges[0].length = $3 - $1 + 1;
 	$$ = array;
-- 
2.41.0.162.gfafddb0af9-goog


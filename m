Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12AD710755
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 10:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239900AbjEYI3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 04:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239810AbjEYI3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 04:29:19 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C77B18C;
        Thu, 25 May 2023 01:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685003357; x=1716539357;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nOO6fuerbaV7gjlAnz/FGqZJGpg2JP7madlqfSgTrak=;
  b=YZJn7vskv6lCvRfgzIrcc7+8oR5DLMqWyBC7BOZDJigVZo6chxSNvPzu
   y/AW7YY7sKFO/dpeLnpKKZNLc+b19p7aMQJDYuy90QV86KUe3cOd43+Q8
   CfsHg6uhcmpmafld0fUlsDLhPBlFSj6aRGPmqPMtAdunZVjpeSMvLRZEI
   QnCXznRrwFjaLQyK524a5L5oWumRG3VK9496Bw7ISgdN/wk5p5FpHmw2p
   fNY8tPtsikTdNrxRKgXjk8yoDiN+BPeby8D4hf+kSHCgIezD5vlkBh0cJ
   j3Y2QJ9d4f5mGED58Yt0SkgYIhqlVW1jI+7FFTSrZsSdfINQ+VDi1jrW8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="338400399"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="338400399"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 01:29:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="707914648"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="707914648"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.208.63])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 01:29:14 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH V3 1/1] perf tools: Allow config terms with breakpoints
Date:   Thu, 25 May 2023 11:29:02 +0300
Message-Id: <20230525082902.25332-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525082902.25332-1-adrian.hunter@intel.com>
References: <20230525082902.25332-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add config terms to the parsing of breakpoint events. Extend "Test event
parsing" to also cover using a confg term.

This makes breakpoint events consistent with other events which already
support config terms.

Example:

  $ cat dr_test.c
  #include <unistd.h>
  #include <stdio.h>

  void func0(void)
  {
  }

  int main()
  {
          printf("func0 %p\n", &func0);
          while (1) {
                  func0();
                  usleep(100000);
          }
          return 0;
  }
  $ gcc -g -O0 -o dr_test dr_test.c
  $ ./dr_test &
  [2] 19646
  func0 0x55feb98dd169
  $ perf record -e mem:0x55feb98dd169:x/name=breakpoint/ -p 19646 -- sleep 0.5
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.017 MB perf.data (5 samples) ]
  $ perf script
      dr_test 19646  5632.956628:          1 breakpoint:      55feb98dd169 func0+0x0 (/home/ahunter/git/work/dr_test)
      dr_test 19646  5633.056866:          1 breakpoint:      55feb98dd169 func0+0x0 (/home/ahunter/git/work/dr_test)
      dr_test 19646  5633.157084:          1 breakpoint:      55feb98dd169 func0+0x0 (/home/ahunter/git/work/dr_test)
      dr_test 19646  5633.257309:          1 breakpoint:      55feb98dd169 func0+0x0 (/home/ahunter/git/work/dr_test)
      dr_test 19646  5633.357532:          1 breakpoint:      55feb98dd169 func0+0x0 (/home/ahunter/git/work/dr_test)
  $ sudo perf test "Test event parsing"
    6: Parse event definition strings                                  :
    6.1: Test event parsing                                            : Ok
  $ sudo perf test -v "Test event parsing" |& grep mem
  running test 8 'mem:0'
  running test 9 'mem:0:x'
  running test 10 'mem:0:r'
  running test 11 'mem:0:w'
  running test 19 'mem:0:u'
  running test 20 'mem:0:x:k'
  running test 21 'mem:0:r:hp'
  running test 22 'mem:0:w:up'
  running test 26 'mem:0:rw'
  running test 27 'mem:0:rw:kp'
  running test 42 'mem:0/1'
  running test 43 'mem:0/2:w'
  running test 44 'mem:0/4:rw:u'
  running test 58 'mem:0/name=breakpoint/'
  running test 59 'mem:0:x/name=breakpoint/'
  running test 60 'mem:0:r/name=breakpoint/'
  running test 61 'mem:0:w/name=breakpoint/'
  running test 62 'mem:0/name=breakpoint/u'
  running test 63 'mem:0:x/name=breakpoint/k'
  running test 64 'mem:0:r/name=breakpoint/hp'
  running test 65 'mem:0:w/name=breakpoint/up'
  running test 66 'mem:0:rw/name=breakpoint/'
  running test 67 'mem:0:rw/name=breakpoint/kp'
  running test 68 'mem:0/1/name=breakpoint/'
  running test 69 'mem:0/2:w/name=breakpoint/'
  running test 70 'mem:0/4:rw/name=breakpoint/u'
  running test 71 'mem:0/1/name=breakpoint1/,mem:0/4:rw/name=breakpoint2/'

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---


Changes in V3:

      Add Ian's Reviewed-by
      Re-base

Changes in V2:

      Add comments to tools/perf/util/parse-events.l
      Add a test for 2 mem events back to back with config terms


 tools/perf/tests/parse-events.c | 157 ++++++++++++++++++++++++++++++++
 tools/perf/util/parse-events.c  |  23 ++++-
 tools/perf/util/parse-events.h  |   6 +-
 tools/perf/util/parse-events.l  |  23 ++++-
 tools/perf/util/parse-events.y  |  42 +++++----
 5 files changed, 224 insertions(+), 27 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 72a10bed84fd..399f1bc12b0c 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -482,6 +482,93 @@ static int test__checkevent_breakpoint_rw_modifier(struct evlist *evlist)
 	return test__checkevent_breakpoint_rw(evlist);
 }
 
+static int test__checkevent_breakpoint_modifier_name(struct evlist *evlist)
+{
+	struct evsel *evsel = evlist__first(evlist);
+
+	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
+	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
+	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
+	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
+	TEST_ASSERT_VAL("wrong name",
+			!strcmp(evsel__name(evsel), "breakpoint"));
+
+	return test__checkevent_breakpoint(evlist);
+}
+
+static int test__checkevent_breakpoint_x_modifier_name(struct evlist *evlist)
+{
+	struct evsel *evsel = evlist__first(evlist);
+
+	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
+	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
+	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
+	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
+	TEST_ASSERT_VAL("wrong name",
+			!strcmp(evsel__name(evsel), "breakpoint"));
+
+	return test__checkevent_breakpoint_x(evlist);
+}
+
+static int test__checkevent_breakpoint_r_modifier_name(struct evlist *evlist)
+{
+	struct evsel *evsel = evlist__first(evlist);
+
+	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
+	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
+	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
+	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip);
+	TEST_ASSERT_VAL("wrong name",
+			!strcmp(evsel__name(evsel), "breakpoint"));
+
+	return test__checkevent_breakpoint_r(evlist);
+}
+
+static int test__checkevent_breakpoint_w_modifier_name(struct evlist *evlist)
+{
+	struct evsel *evsel = evlist__first(evlist);
+
+	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
+	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
+	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
+	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip);
+	TEST_ASSERT_VAL("wrong name",
+			!strcmp(evsel__name(evsel), "breakpoint"));
+
+	return test__checkevent_breakpoint_w(evlist);
+}
+
+static int test__checkevent_breakpoint_rw_modifier_name(struct evlist *evlist)
+{
+	struct evsel *evsel = evlist__first(evlist);
+
+	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
+	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
+	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
+	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip);
+	TEST_ASSERT_VAL("wrong name",
+			!strcmp(evsel__name(evsel), "breakpoint"));
+
+	return test__checkevent_breakpoint_rw(evlist);
+}
+
+static int test__checkevent_breakpoint_2_events(struct evlist *evlist)
+{
+	struct evsel *evsel = evlist__first(evlist);
+
+	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
+
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong name", !strcmp(evsel__name(evsel), "breakpoint1"));
+
+	evsel = evsel__next(evsel);
+
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong name", !strcmp(evsel__name(evsel), "breakpoint2"));
+
+	return TEST_OK;
+}
+
 static int test__checkevent_pmu(struct evlist *evlist)
 {
 
@@ -1901,6 +1988,76 @@ static const struct evlist_test test__events[] = {
 		.check = test__term_equal_legacy,
 		/* 9 */
 	},
+	{
+		.name  = "mem:0/name=breakpoint/",
+		.check = test__checkevent_breakpoint,
+		/* 0 */
+	},
+	{
+		.name  = "mem:0:x/name=breakpoint/",
+		.check = test__checkevent_breakpoint_x,
+		/* 1 */
+	},
+	{
+		.name  = "mem:0:r/name=breakpoint/",
+		.check = test__checkevent_breakpoint_r,
+		/* 2 */
+	},
+	{
+		.name  = "mem:0:w/name=breakpoint/",
+		.check = test__checkevent_breakpoint_w,
+		/* 3 */
+	},
+	{
+		.name  = "mem:0/name=breakpoint/u",
+		.check = test__checkevent_breakpoint_modifier_name,
+		/* 4 */
+	},
+	{
+		.name  = "mem:0:x/name=breakpoint/k",
+		.check = test__checkevent_breakpoint_x_modifier_name,
+		/* 5 */
+	},
+	{
+		.name  = "mem:0:r/name=breakpoint/hp",
+		.check = test__checkevent_breakpoint_r_modifier_name,
+		/* 6 */
+	},
+	{
+		.name  = "mem:0:w/name=breakpoint/up",
+		.check = test__checkevent_breakpoint_w_modifier_name,
+		/* 7 */
+	},
+	{
+		.name  = "mem:0:rw/name=breakpoint/",
+		.check = test__checkevent_breakpoint_rw,
+		/* 8 */
+	},
+	{
+		.name  = "mem:0:rw/name=breakpoint/kp",
+		.check = test__checkevent_breakpoint_rw_modifier_name,
+		/* 9 */
+	},
+	{
+		.name  = "mem:0/1/name=breakpoint/",
+		.check = test__checkevent_breakpoint_len,
+		/* 0 */
+	},
+	{
+		.name  = "mem:0/2:w/name=breakpoint/",
+		.check = test__checkevent_breakpoint_len_w,
+		/* 1 */
+	},
+	{
+		.name  = "mem:0/4:rw/name=breakpoint/u",
+		.check = test__checkevent_breakpoint_len_rw_modifier,
+		/* 2 */
+	},
+	{
+		.name  = "mem:0/1/name=breakpoint1/,mem:0/4:rw/name=breakpoint2/",
+		.check = test__checkevent_breakpoint_2_events,
+		/* 3 */
+	},
 };
 
 static const struct evlist_test test__events_pmu[] = {
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index b93264f8a37c..cfa25441a94d 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -939,10 +939,14 @@ do {					\
 	return 0;
 }
 
-int parse_events_add_breakpoint(struct list_head *list, int *idx,
-				u64 addr, char *type, u64 len)
+int parse_events_add_breakpoint(struct parse_events_state *parse_state,
+				struct list_head *list,
+				u64 addr, char *type, u64 len,
+				struct list_head *head_config __maybe_unused)
 {
 	struct perf_event_attr attr;
+	LIST_HEAD(config_terms);
+	const char *name;
 
 	memset(&attr, 0, sizeof(attr));
 	attr.bp_addr = addr;
@@ -963,8 +967,19 @@ int parse_events_add_breakpoint(struct list_head *list, int *idx,
 	attr.type = PERF_TYPE_BREAKPOINT;
 	attr.sample_period = 1;
 
-	return add_event(list, idx, &attr, /*name=*/NULL, /*mertic_id=*/NULL,
-			 /*config_terms=*/NULL);
+	if (head_config) {
+		if (config_attr(&attr, head_config, parse_state->error,
+				config_term_common))
+			return -EINVAL;
+
+		if (get_config_terms(head_config, &config_terms))
+			return -ENOMEM;
+	}
+
+	name = get_config_name(head_config);
+
+	return add_event(list, &parse_state->idx, &attr, name, /*mertic_id=*/NULL,
+			 &config_terms);
 }
 
 static int check_type_val(struct parse_events_term *term,
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 2021fe145410..b0eb95f93e9c 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -185,8 +185,10 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 			   struct parse_events_state *parse_state,
 			   struct list_head *head_config);
 int parse_events__decode_legacy_cache(const char *name, int pmu_type, __u64 *config);
-int parse_events_add_breakpoint(struct list_head *list, int *idx,
-				u64 addr, char *type, u64 len);
+int parse_events_add_breakpoint(struct parse_events_state *parse_state,
+				struct list_head *list,
+				u64 addr, char *type, u64 len,
+				struct list_head *head_config);
 int parse_events_add_pmu(struct parse_events_state *parse_state,
 			 struct list_head *list, char *name,
 			 struct list_head *head_config,
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 6deb70c25984..7629af3d5c7c 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -190,11 +190,16 @@ name		[a-zA-Z_*?\[\]][a-zA-Z0-9_*?.\[\]!\-]*
 name_tag	[\'][a-zA-Z_*?\[\]][a-zA-Z0-9_*?\-,\.\[\]:=]*[\']
 name_minus	[a-zA-Z_*?][a-zA-Z0-9\-_*?.:]*
 drv_cfg_term	[a-zA-Z0-9_\.]+(=[a-zA-Z0-9_*?\.:]+)?
-/* If you add a modifier you need to update check_modifier() */
+/*
+ * If you add a modifier you need to update check_modifier().
+ * Also, the letters in modifier_event must not be in modifier_bp.
+ */
 modifier_event	[ukhpPGHSDIWeb]+
 modifier_bp	[rwx]{1,3}
 lc_type 	(L1-dcache|l1-d|l1d|L1-data|L1-icache|l1-i|l1i|L1-instruction|LLC|L2|dTLB|d-tlb|Data-TLB|iTLB|i-tlb|Instruction-TLB|branch|branches|bpu|btb|bpc|node)
 lc_op_result	(load|loads|read|store|stores|write|prefetch|prefetches|speculative-read|speculative-load|refs|Reference|ops|access|misses|miss)
+digit		[0-9]
+non_digit	[^0-9]
 
 %%
 
@@ -304,8 +309,20 @@ r0x{num_raw_hex}	{ return str(yyscanner, PE_RAW); }
 
 <mem>{
 {modifier_bp}		{ return str(yyscanner, PE_MODIFIER_BP); }
-:			{ return ':'; }
-"/"			{ return '/'; }
+	/*
+	 * The colon before memory access modifiers can get mixed up with the
+	 * colon before event modifiers. Fortunately none of the option letters
+	 * are the same, so trailing context can be used disambiguate the two
+	 * cases.
+	 */
+":"/{modifier_bp}	{ return str(yyscanner, PE_BP_COLON); }
+	/*
+	 * The slash before memory length can get mixed up with the slash before
+	 * config terms. Fortunately config terms do not start with a numeric
+	 * digit, so trailing context can be used disambiguate the two cases.
+	 */
+"/"/{digit}		{ return str(yyscanner, PE_BP_SLASH); }
+"/"/{non_digit}		{ BEGIN(config); return '/'; }
 {num_dec}		{ return value(yyscanner, 10); }
 {num_hex}		{ return value(yyscanner, 16); }
 	/*
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 4e1f5de35be8..51944dd06115 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -58,7 +58,7 @@ static void free_list_evsel(struct list_head* list_evsel)
 %token PE_EVENT_NAME
 %token PE_RAW PE_NAME
 %token PE_BPF_OBJECT PE_BPF_SOURCE
-%token PE_MODIFIER_EVENT PE_MODIFIER_BP
+%token PE_MODIFIER_EVENT PE_MODIFIER_BP PE_BP_COLON PE_BP_SLASH
 %token PE_LEGACY_CACHE
 %token PE_PREFIX_MEM PE_PREFIX_RAW PE_PREFIX_GROUP
 %token PE_ERROR
@@ -79,6 +79,8 @@ static void free_list_evsel(struct list_head* list_evsel)
 %type <str> PE_LEGACY_CACHE
 %type <str> PE_MODIFIER_EVENT
 %type <str> PE_MODIFIER_BP
+%type <str> PE_BP_COLON
+%type <str> PE_BP_SLASH
 %type <str> PE_EVENT_NAME
 %type <str> PE_KERNEL_PMU_EVENT PE_PMU_EVENT_FAKE
 %type <str> PE_DRV_CFG_TERM
@@ -274,7 +276,7 @@ event_def
 event_def: event_pmu |
 	   event_legacy_symbol |
 	   event_legacy_cache sep_dc |
-	   event_legacy_mem |
+	   event_legacy_mem sep_dc |
 	   event_legacy_tracepoint sep_dc |
 	   event_legacy_numeric sep_dc |
 	   event_legacy_raw sep_dc |
@@ -502,16 +504,16 @@ PE_LEGACY_CACHE opt_event_config
 }
 
 event_legacy_mem:
-PE_PREFIX_MEM PE_VALUE '/' PE_VALUE ':' PE_MODIFIER_BP sep_dc
+PE_PREFIX_MEM PE_VALUE PE_BP_SLASH PE_VALUE PE_BP_COLON PE_MODIFIER_BP opt_event_config
 {
-	struct parse_events_state *parse_state = _parse_state;
 	struct list_head *list;
 	int err;
 
 	list = alloc_list();
 	ABORT_ON(!list);
-	err = parse_events_add_breakpoint(list, &parse_state->idx,
-					  $2, $6, $4);
+	err = parse_events_add_breakpoint(_parse_state, list,
+					  $2, $6, $4, $7);
+	parse_events_terms__delete($7);
 	free($6);
 	if (err) {
 		free(list);
@@ -520,31 +522,33 @@ PE_PREFIX_MEM PE_VALUE '/' PE_VALUE ':' PE_MODIFIER_BP sep_dc
 	$$ = list;
 }
 |
-PE_PREFIX_MEM PE_VALUE '/' PE_VALUE sep_dc
+PE_PREFIX_MEM PE_VALUE PE_BP_SLASH PE_VALUE opt_event_config
 {
-	struct parse_events_state *parse_state = _parse_state;
 	struct list_head *list;
+	int err;
 
 	list = alloc_list();
 	ABORT_ON(!list);
-	if (parse_events_add_breakpoint(list, &parse_state->idx,
-					$2, NULL, $4)) {
+	err = parse_events_add_breakpoint(_parse_state, list,
+					  $2, NULL, $4, $5);
+	parse_events_terms__delete($5);
+	if (err) {
 		free(list);
 		YYABORT;
 	}
 	$$ = list;
 }
 |
-PE_PREFIX_MEM PE_VALUE ':' PE_MODIFIER_BP sep_dc
+PE_PREFIX_MEM PE_VALUE PE_BP_COLON PE_MODIFIER_BP opt_event_config
 {
-	struct parse_events_state *parse_state = _parse_state;
 	struct list_head *list;
 	int err;
 
 	list = alloc_list();
 	ABORT_ON(!list);
-	err = parse_events_add_breakpoint(list, &parse_state->idx,
-					  $2, $4, 0);
+	err = parse_events_add_breakpoint(_parse_state, list,
+					  $2, $4, 0, $5);
+	parse_events_terms__delete($5);
 	free($4);
 	if (err) {
 		free(list);
@@ -553,15 +557,17 @@ PE_PREFIX_MEM PE_VALUE ':' PE_MODIFIER_BP sep_dc
 	$$ = list;
 }
 |
-PE_PREFIX_MEM PE_VALUE sep_dc
+PE_PREFIX_MEM PE_VALUE opt_event_config
 {
-	struct parse_events_state *parse_state = _parse_state;
 	struct list_head *list;
+	int err;
 
 	list = alloc_list();
 	ABORT_ON(!list);
-	if (parse_events_add_breakpoint(list, &parse_state->idx,
-					$2, NULL, 0)) {
+	err = parse_events_add_breakpoint(_parse_state, list,
+					  $2, NULL, 0, $3);
+	parse_events_terms__delete($3);
+	if (err) {
 		free(list);
 		YYABORT;
 	}
-- 
2.34.1


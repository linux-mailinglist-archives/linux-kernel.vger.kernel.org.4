Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E6673036A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343684AbjFNPSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343677AbjFNPSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:18:17 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50386198;
        Wed, 14 Jun 2023 08:18:14 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Qh8BL43ksztQlf;
        Wed, 14 Jun 2023 23:15:38 +0800 (CST)
Received: from localhost.localdomain (10.67.174.95) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 23:18:07 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH] perf top & record: Fix segfault when default cycles event is not supported
Date:   Wed, 14 Jun 2023 15:16:25 +0000
Message-ID: <20230614151625.2077-1-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.95]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The perf-record and perf-top call parse_event() to add a cycles event to
an empty evlist. For the system that does not support hardware cycles
event, such as QEMU, the evlist is empty due to the following code process:

  parse_event(evlist, "cycles:P" or ""cycles:Pu")
    parse_events(evlist, "cycles:P")
      __parse_events
        ...
        ret = parse_events__scanner(str, &parse_state);
        // ret = 0
        ...
        ret2 = parse_events__sort_events_and_fix_groups()
        if (ret2 < 0)
          return ret;
        // The cycles event is not supported, here ret2 = -EINVAL,
        // Here return 0.
        ...
        evlist__splice_list_tail(evlist)
        // The code here does not execute to, so the evlist is still empty.

A null pointer occurs when the content in the evlist is accessed later.

Before:

  # perf list hw

  List of pre-defined events (to be used in -e or -M):

  # perf record true
  libperf: Miscounted nr_mmaps 0 vs 1
  WARNING: No sample_id_all support, falling back to unordered processing
  perf: Segmentation fault
  Obtained 1 stack frames.
  [0xc5beff]
  Segmentation fault

Solution:
  If cycles event is not supported, try to fall back to cpu-clock event.

After:
  # perf record true
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.006 MB perf.data ]
  #

Fixes: 7b100989b4f6 ("perf evlist: Remove __evlist__add_default")
Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/builtin-record.c |  4 +---
 tools/perf/builtin-top.c    |  3 +--
 tools/perf/util/evlist.c    | 18 ++++++++++++++++++
 tools/perf/util/evlist.h    |  1 +
 4 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index aec18db7ff23..29ae2b84a63a 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -4161,9 +4161,7 @@ int cmd_record(int argc, const char **argv)
 		record.opts.tail_synthesize = true;
 
 	if (rec->evlist->core.nr_entries == 0) {
-		bool can_profile_kernel = perf_event_paranoid_check(1);
-
-		err = parse_event(rec->evlist, can_profile_kernel ? "cycles:P" : "cycles:Pu");
+		err = evlist__add_default(rec->evlist);
 		if (err)
 			goto out;
 	}
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index c363c04e16df..798cb9252a5f 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1665,8 +1665,7 @@ int cmd_top(int argc, const char **argv)
 		goto out_delete_evlist;
 
 	if (!top.evlist->core.nr_entries) {
-		bool can_profile_kernel = perf_event_paranoid_check(1);
-		int err = parse_event(top.evlist, can_profile_kernel ? "cycles:P" : "cycles:Pu");
+		int err = evlist__add_default(top.evlist);
 
 		if (err)
 			goto out_delete_evlist;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 7ef43f72098e..60efa762405e 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -287,6 +287,24 @@ struct evsel *evlist__add_aux_dummy(struct evlist *evlist, bool system_wide)
 	return evsel;
 }
 
+int evlist__add_default(struct evlist *evlist)
+{
+	bool can_profile_kernel;
+	int err;
+
+	can_profile_kernel = perf_event_paranoid_check(1);
+	err = parse_event(evlist, can_profile_kernel ? "cycles:P" : "cycles:Pu");
+	if (err)
+		return err;
+
+	if (!evlist->core.nr_entries) {
+		pr_debug("The cycles event is not supported, trying to fall back to cpu-clock event\n");
+		return parse_event(evlist, "cpu-clock");
+	}
+
+	return 0;
+}
+
 #ifdef HAVE_LIBTRACEEVENT
 struct evsel *evlist__add_sched_switch(struct evlist *evlist, bool system_wide)
 {
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 664c6bf7b3e0..47eea809ee91 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -116,6 +116,7 @@ int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs);
 
 int evlist__add_dummy(struct evlist *evlist);
 struct evsel *evlist__add_aux_dummy(struct evlist *evlist, bool system_wide);
+int evlist__add_default(struct evlist *evlist);
 static inline struct evsel *evlist__add_dummy_on_all_cpus(struct evlist *evlist)
 {
 	return evlist__add_aux_dummy(evlist, true);
-- 
2.30.GIT


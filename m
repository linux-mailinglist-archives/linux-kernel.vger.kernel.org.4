Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32260746AEF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbjGDHod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 03:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjGDHoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:44:30 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFDDE70;
        Tue,  4 Jul 2023 00:44:23 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QwF9s2S8YzLngn;
        Tue,  4 Jul 2023 15:42:09 +0800 (CST)
Received: from localhost.localdomain (10.67.174.95) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 4 Jul 2023 15:44:20 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH 1/5] perf evlist: Export perf_evlist__propagate_maps()
Date:   Tue, 4 Jul 2023 07:42:13 +0000
Message-ID: <20230704074217.240939-2-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
In-Reply-To: <20230704074217.240939-1-yangjihong1@huawei.com>
References: <20230704074217.240939-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.95]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For dummy events that keep tracking, we may need to modify its cpu_maps.
For example, change the cpu_maps to track side-band events for all CPUS.
Export perf_evlist__propagate_maps () to support this scenario.

No functional change.

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/lib/perf/evlist.c              | 23 +++++++++--------------
 tools/lib/perf/include/perf/evlist.h |  2 ++
 2 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index b8b066d0dc5e..a3057b692530 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -33,8 +33,8 @@ void perf_evlist__init(struct perf_evlist *evlist)
 	perf_evlist__reset_id_hash(evlist);
 }
 
-static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
-					  struct perf_evsel *evsel)
+void perf_evlist__propagate_maps(struct perf_evlist *evlist,
+				 struct perf_evsel *evsel)
 {
 	if (evsel->system_wide) {
 		/* System wide: set the cpu map of the evsel to all online CPUs. */
@@ -78,16 +78,6 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
 	evlist->all_cpus = perf_cpu_map__merge(evlist->all_cpus, evsel->cpus);
 }
 
-static void perf_evlist__propagate_maps(struct perf_evlist *evlist)
-{
-	struct perf_evsel *evsel;
-
-	evlist->needs_map_propagation = true;
-
-	perf_evlist__for_each_evsel(evlist, evsel)
-		__perf_evlist__propagate_maps(evlist, evsel);
-}
-
 void perf_evlist__add(struct perf_evlist *evlist,
 		      struct perf_evsel *evsel)
 {
@@ -96,7 +86,7 @@ void perf_evlist__add(struct perf_evlist *evlist,
 	evlist->nr_entries += 1;
 
 	if (evlist->needs_map_propagation)
-		__perf_evlist__propagate_maps(evlist, evsel);
+		perf_evlist__propagate_maps(evlist, evsel);
 }
 
 void perf_evlist__remove(struct perf_evlist *evlist,
@@ -175,6 +165,8 @@ void perf_evlist__set_maps(struct perf_evlist *evlist,
 			   struct perf_cpu_map *cpus,
 			   struct perf_thread_map *threads)
 {
+	struct perf_evsel *evsel;
+
 	/*
 	 * Allow for the possibility that one or another of the maps isn't being
 	 * changed i.e. don't put it.  Note we are assuming the maps that are
@@ -192,7 +184,10 @@ void perf_evlist__set_maps(struct perf_evlist *evlist,
 		evlist->threads = perf_thread_map__get(threads);
 	}
 
-	perf_evlist__propagate_maps(evlist);
+	evlist->needs_map_propagation = true;
+
+	perf_evlist__for_each_evsel(evlist, evsel)
+		perf_evlist__propagate_maps(evlist, evsel);
 }
 
 int perf_evlist__open(struct perf_evlist *evlist)
diff --git a/tools/lib/perf/include/perf/evlist.h b/tools/lib/perf/include/perf/evlist.h
index e894b770779e..d5a2569b2177 100644
--- a/tools/lib/perf/include/perf/evlist.h
+++ b/tools/lib/perf/include/perf/evlist.h
@@ -48,4 +48,6 @@ LIBPERF_API struct perf_mmap *perf_evlist__next_mmap(struct perf_evlist *evlist,
 
 LIBPERF_API void perf_evlist__set_leader(struct perf_evlist *evlist);
 LIBPERF_API int perf_evlist__nr_groups(struct perf_evlist *evlist);
+LIBPERF_API void perf_evlist__propagate_maps(struct perf_evlist *evlist,
+					     struct perf_evsel *evsel);
 #endif /* __LIBPERF_EVLIST_H */
-- 
2.30.GIT


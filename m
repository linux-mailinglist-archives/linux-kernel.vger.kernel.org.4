Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA385B5657
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 10:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbiILIfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 04:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiILIew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 04:34:52 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA20FB7F8;
        Mon, 12 Sep 2022 01:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662971688; x=1694507688;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SOQpKwgqrECdZMc2wnf3LEtxKsGqWRaf6i9weGpa8Hw=;
  b=BSPPsDbsqqfEkWIkWvr6V3TlCSCqtK1LJjp1W6b2S4MsuRdN/B5c20fE
   LuxdFSPadqMLJb/JE0NmnXeuQnJQVQVHnNmJlQ5Re5S/J8tOhS94Rg0Qd
   XrpaNKyKW9+qmlJQmQX57AyPLXuUUOIgeVzzhPQK8EnyxtQocFSkUggKN
   PMCt5rwJrXUwexsSXnb36ADgp/FEmGTSY0FZo+gkyR6VGrGSaY+ZoUp6p
   AuqrY/zsBnEoqE3R7mRSHzzyaRWsYeMGP/Yd9nNwUM9fum8W+mVAQBsIL
   XzN/okVEjJ6NnXZtihM0bSLRIyScdRLUYOy7p+0Kp1rL+FaP4Z3esV5Ng
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="299153662"
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="299153662"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 01:34:48 -0700
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="611688334"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.46.215])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 01:34:46 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 10/11] perf tools: Add debug messages and comments for testing
Date:   Mon, 12 Sep 2022 11:34:11 +0300
Message-Id: <20220912083412.7058-11-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220912083412.7058-1-adrian.hunter@intel.com>
References: <20220912083412.7058-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add debug messages to enable scripts to track aspects of perf record
behaviour. The messages will be consumed after perf record has run,
with the exception of "perf record has started" which is consequently
flushed.

Put comments so developers know which messages are also being used by test
scripts.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/lib/perf/evlist.c     | 2 ++
 tools/perf/builtin-record.c | 8 ++++++++
 tools/perf/util/evsel.c     | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 6b1bafe267a4..80cc810c5097 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -486,6 +486,7 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 			if (ops->idx)
 				ops->idx(evlist, evsel, mp, idx);
 
+			/* Debug message used by test scripts */
 			pr_debug("idx %d: mmapping fd %d\n", idx, *output);
 			if (ops->mmap(map, mp, *output, evlist_cpu) < 0)
 				return -1;
@@ -495,6 +496,7 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 			if (!idx)
 				perf_evlist__set_mmap_first(evlist, map, overwrite);
 		} else {
+			/* Debug message used by test scripts */
 			pr_debug("idx %d: set output fd %d -> %d\n", idx, fd, *output);
 			if (ioctl(fd, PERF_EVENT_IOC_SET_OUTPUT, *output) != 0)
 				return -1;
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 02e38f50a138..5b808ac7a281 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2428,10 +2428,14 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 
 	record__uniquify_name(rec);
 
+	/* Debug message used by test scripts */
+	pr_debug3("perf record opening and mmapping events\n");
 	if (record__open(rec) != 0) {
 		err = -1;
 		goto out_free_threads;
 	}
+	/* Debug message used by test scripts */
+	pr_debug3("perf record done opening and mmapping events\n");
 	session->header.env.comp_mmap_len = session->evlist->core.mmap_len;
 
 	if (rec->opts.kcore) {
@@ -2574,6 +2578,10 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	if (err)
 		goto out_child;
 
+	/* Debug message used by test scripts */
+	pr_debug3("perf record has started\n");
+	fflush(stderr);
+
 	trigger_ready(&auxtrace_snapshot_trigger);
 	trigger_ready(&switch_output_trigger);
 	perf_hooks__invoke_record_start();
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 5776bfa70f11..a27092339b81 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2089,6 +2089,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 
 			test_attr__ready();
 
+			/* Debug message used by test scripts */
 			pr_debug2_peo("sys_perf_event_open: pid %d  cpu %d  group_fd %d  flags %#lx",
 				pid, perf_cpu_map__cpu(cpus, idx).cpu, group_fd, evsel->open_flags);
 
@@ -2114,6 +2115,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 						fd, group_fd, evsel->open_flags);
 			}
 
+			/* Debug message used by test scripts */
 			pr_debug2_peo(" = %d\n", fd);
 
 			if (evsel->bpf_fd >= 0) {
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECE6746AF5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjGDHoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 03:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjGDHob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:44:31 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C088E76;
        Tue,  4 Jul 2023 00:44:24 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QwF8j0WSGzMqK8;
        Tue,  4 Jul 2023 15:41:09 +0800 (CST)
Received: from localhost.localdomain (10.67.174.95) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 4 Jul 2023 15:44:22 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH 5/5] perf record: All config tracking are integrated into record__config_tracking_events()
Date:   Tue, 4 Jul 2023 07:42:17 +0000
Message-ID: <20230704074217.240939-6-yangjihong1@huawei.com>
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
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current perf-record also config tracking events in record__open(),
move it to the record__config_tracking_events().

The sys_perf_event_open invoked is as follows:

  # perf --debug verbose=3 record -e cpu-clock -D 100 true
  <SNIP>
  Opening: cpu-clock
  ------------------------------------------------------------
  perf_event_attr:
    type                             1
    size                             136
    { sample_period, sample_freq }   4000
    sample_type                      IP|TID|TIME|ID|PERIOD
    read_format                      ID|LOST
    disabled                         1
    inherit                          1
    freq                             1
    sample_id_all                    1
    exclude_guest                    1
  ------------------------------------------------------------
  sys_perf_event_open: pid 3569  cpu 0  group_fd -1  flags 0x8 = 5
  sys_perf_event_open: pid 3569  cpu 1  group_fd -1  flags 0x8 = 6
  sys_perf_event_open: pid 3569  cpu 2  group_fd -1  flags 0x8 = 7
  sys_perf_event_open: pid 3569  cpu 3  group_fd -1  flags 0x8 = 9
  sys_perf_event_open: pid 3569  cpu 4  group_fd -1  flags 0x8 = 10
  sys_perf_event_open: pid 3569  cpu 5  group_fd -1  flags 0x8 = 11
  sys_perf_event_open: pid 3569  cpu 6  group_fd -1  flags 0x8 = 12
  sys_perf_event_open: pid 3569  cpu 7  group_fd -1  flags 0x8 = 13
  Opening: dummy:HG
  ------------------------------------------------------------
  perf_event_attr:
    type                             1
    size                             136
    config                           0x9
    { sample_period, sample_freq }   4000
    sample_type                      IP|TID|TIME|ID|PERIOD
    read_format                      ID|LOST
    disabled                         1
    inherit                          1
    mmap                             1
    comm                             1
    freq                             1
    enable_on_exec                   1
    task                             1
    sample_id_all                    1
    mmap2                            1
    comm_exec                        1
    ksymbol                          1
    bpf_event                        1
  ------------------------------------------------------------
  sys_perf_event_open: pid 3569  cpu 0  group_fd -1  flags 0x8 = 14
  sys_perf_event_open: pid 3569  cpu 1  group_fd -1  flags 0x8 = 15
  sys_perf_event_open: pid 3569  cpu 2  group_fd -1  flags 0x8 = 16
  sys_perf_event_open: pid 3569  cpu 3  group_fd -1  flags 0x8 = 17
  sys_perf_event_open: pid 3569  cpu 4  group_fd -1  flags 0x8 = 18
  sys_perf_event_open: pid 3569  cpu 5  group_fd -1  flags 0x8 = 19
  sys_perf_event_open: pid 3569  cpu 6  group_fd -1  flags 0x8 = 20
  sys_perf_event_open: pid 3569  cpu 7  group_fd -1  flags 0x8 = 21
  <SNIP>

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/builtin-record.c | 46 ++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 26 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 69e0d8c75aab..1e21f64e4cfa 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -915,15 +915,31 @@ static int record__config_tracking_events(struct record *rec)
 	struct record_opts *opts = &rec->opts;
 
 	/*
-	 * User space tasks can migrate between CPUs, so when tracing
-	 * selected CPUs, sideband for all CPUs is still needed.
+	 * For initial_delay, system wide or a hybrid system, we need to add a
+	 * dummy event so that we can track PERF_RECORD_MMAP to cover the delay
+	 * of waiting or event synthesis.
 	 */
-	if (opts->target.cpu_list) {
+	if (opts->target.initial_delay || target__has_cpu(&opts->target) ||
+	    perf_pmus__num_core_pmus() > 1) {
 		evsel = evlist__findnew_tracking_event(evlist);
 		if (!evsel)
 			return -ENOMEM;
 
-		if (!evsel->core.system_wide) {
+		/*
+		 * Enable the dummy event when the process is forked for
+		 * initial_delay, immediately for system wide.
+		 */
+		if (opts->target.initial_delay && !evsel->immediate &&
+		    !target__has_cpu(&opts->target))
+			evsel->core.attr.enable_on_exec = 1;
+		else
+			evsel->immediate = 1;
+
+		/*
+		 * User space tasks can migrate between CPUs, so when tracing
+		 * selected CPUs, sideband for all CPUs is still needed.
+		 */
+		if (opts->target.cpu_list && !evsel->core.system_wide) {
 			evsel->core.system_wide = true;
 			evsel__set_sample_bit(evsel, TIME);
 			perf_evlist__propagate_maps(&evlist->core, &evsel->core);
@@ -1313,28 +1329,6 @@ static int record__open(struct record *rec)
 	struct record_opts *opts = &rec->opts;
 	int rc = 0;
 
-	/*
-	 * For initial_delay, system wide or a hybrid system, we need to add a
-	 * dummy event so that we can track PERF_RECORD_MMAP to cover the delay
-	 * of waiting or event synthesis.
-	 */
-	if (opts->target.initial_delay || target__has_cpu(&opts->target) ||
-	    perf_pmus__num_core_pmus() > 1) {
-		pos = evlist__findnew_tracking_event(evlist);
-		if (!pos)
-			return -ENOMEM;
-
-		/*
-		 * Enable the dummy event when the process is forked for
-		 * initial_delay, immediately for system wide.
-		 */
-		if (opts->target.initial_delay && !pos->immediate &&
-		    !target__has_cpu(&opts->target))
-			pos->core.attr.enable_on_exec = 1;
-		else
-			pos->immediate = 1;
-	}
-
 	evlist__config(evlist, opts, &callchain_param);
 
 	evlist__for_each_entry(evlist, pos) {
-- 
2.30.GIT


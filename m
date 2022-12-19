Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D086506A6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 03:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbiLSCwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 21:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiLSCwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 21:52:02 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554C16474;
        Sun, 18 Dec 2022 18:52:00 -0800 (PST)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Nb42q6KpWzJqZv;
        Mon, 19 Dec 2022 10:50:59 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.61) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 19 Dec 2022 10:51:57 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
        <kim.phillips@amd.com>, <german.gomez@arm.com>,
        <ravi.bangoria@amd.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH] perf tool: Fix output unexpected messages in quiet mode
Date:   Mon, 19 Dec 2022 10:49:11 +0800
Message-ID: <20221219024911.62741-1-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.61]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When perf uses quiet mode, perf_quiet_option sets debug_peo_args to -1,
and display_attr incorrectly determines the value of debug_peo_args.
As a result, unexpected information is displayed.

Before:
  # perf record --quiet -- ls > /dev/null
  ------------------------------------------------------------
  perf_event_attr:
    size                             128
    { sample_period, sample_freq }   4000
    sample_type                      IP|TID|TIME|PERIOD
    read_format                      ID|LOST
    disabled                         1
    inherit                          1
    mmap                             1
    comm                             1
    freq                             1
    enable_on_exec                   1
    task                             1
    precise_ip                       3
    sample_id_all                    1
    exclude_guest                    1
    mmap2                            1
    comm_exec                        1
    ksymbol                          1
    bpf_event                        1
  ------------------------------------------------------------
  ...

After:
  # perf record --quiet -- ls > /dev/null
  #

Fixes: ccd26741f5e6 ("perf tool: Provide an option to print perf_event_open args and return value")
Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/util/debug.h | 2 +-
 tools/perf/util/evsel.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/debug.h b/tools/perf/util/debug.h
index f99468a7f681..f6ab84c93ec0 100644
--- a/tools/perf/util/debug.h
+++ b/tools/perf/util/debug.h
@@ -41,7 +41,7 @@ extern int debug_data_convert;
 
 /* Special macro to print perf_event_open arguments/return value. */
 #define pr_debug2_peo(fmt, ...) {				\
-	if (debug_peo_args)						\
+	if (debug_peo_args > 0)						\
 		pr_debugN(0, pr_fmt(fmt), ##__VA_ARGS__);	\
 	else							\
 		pr_debugN(2, pr_fmt(fmt), ##__VA_ARGS__);	\
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 999dd1700502..45cf144c5d5d 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1775,7 +1775,7 @@ static int __open_attr__fprintf(FILE *fp, const char *name, const char *val,
 
 static void display_attr(struct perf_event_attr *attr)
 {
-	if (verbose >= 2 || debug_peo_args) {
+	if (verbose >= 2 || debug_peo_args > 0) {
 		fprintf(stderr, "%.60s\n", graph_dotted_line);
 		fprintf(stderr, "perf_event_attr:\n");
 		perf_event_attr__fprintf(stderr, attr, __open_attr__fprintf, NULL);
-- 
2.30.GIT


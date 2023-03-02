Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873196A79D3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 04:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjCBDMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 22:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjCBDM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 22:12:27 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FF6532BD;
        Wed,  1 Mar 2023 19:12:25 -0800 (PST)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PRx335ky4zrS3t;
        Thu,  2 Mar 2023 11:11:43 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 11:12:22 +0800
From:   Changbin Du <changbin.du@huawei.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hui Wang <hw.huiwang@huawei.com>,
        Changbin Du <changbin.du@huawei.com>
Subject: [PATCH v2 3/3] perf: ftrace: reuse target::initial_delay
Date:   Thu, 2 Mar 2023 11:11:46 +0800
Message-ID: <20230302031146.2801588-4-changbin.du@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230302031146.2801588-1-changbin.du@huawei.com>
References: <20230302031146.2801588-1-changbin.du@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.110.54.157]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace perf_ftrace::initial_delay with target::initial_delay. Specifying
a negative initial_delay is meaningless for ftrace in practice but allowed
here.

Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 tools/perf/builtin-ftrace.c | 10 +++++-----
 tools/perf/util/ftrace.h    |  1 -
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index d7fe00f66b83..73d51ce84c3a 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -623,7 +623,7 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 	/* display column headers */
 	read_tracing_file_to_stdout("trace");
 
-	if (!ftrace->initial_delay) {
+	if (!ftrace->target.initial_delay) {
 		if (write_tracing_file("tracing_on", "1") < 0) {
 			pr_err("can't enable tracing\n");
 			goto out_close_fd;
@@ -632,8 +632,8 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 
 	evlist__start_workload(ftrace->evlist);
 
-	if (ftrace->initial_delay) {
-		usleep(ftrace->initial_delay * 1000);
+	if (ftrace->target.initial_delay > 0) {
+		usleep(ftrace->target.initial_delay * 1000);
 		if (write_tracing_file("tracing_on", "1") < 0) {
 			pr_err("can't enable tracing\n");
 			goto out_close_fd;
@@ -1164,8 +1164,8 @@ int cmd_ftrace(int argc, const char **argv)
 		     "Size of per cpu buffer, needs to use a B, K, M or G suffix.", parse_buffer_size),
 	OPT_BOOLEAN(0, "inherit", &ftrace.inherit,
 		    "Trace children processes"),
-	OPT_UINTEGER('D', "delay", &ftrace.initial_delay,
-		     "Number of milliseconds to wait before starting tracing after program start"),
+	OPT_INTEGER('D', "delay", &ftrace.target.initial_delay,
+		    "Number of milliseconds to wait before starting tracing after program start"),
 	OPT_PARENT(common_options),
 	};
 	const struct option latency_options[] = {
diff --git a/tools/perf/util/ftrace.h b/tools/perf/util/ftrace.h
index a34cd15733b8..558efcb98d25 100644
--- a/tools/perf/util/ftrace.h
+++ b/tools/perf/util/ftrace.h
@@ -25,7 +25,6 @@ struct perf_ftrace {
 	int			graph_noirqs;
 	int			graph_verbose;
 	int			graph_thresh;
-	unsigned int		initial_delay;
 };
 
 struct filter_entry {
-- 
2.25.1


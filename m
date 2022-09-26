Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF125E9830
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 05:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbiIZDTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 23:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbiIZDSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 23:18:35 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E8E2657E;
        Sun, 25 Sep 2022 20:18:32 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MbSWs2YlBzHtgw;
        Mon, 26 Sep 2022 11:13:45 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 11:18:31 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 11:18:30 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <john.garry@huawei.com>, <adrian.hunter@intel.com>,
        <ak@linux.intel.com>, <florian.fischer@muhq.space>,
        <chenzhongjin@huawei.com>
Subject: [PATCH -next 3/5] perf: Remove duplicate errbuf
Date:   Mon, 26 Sep 2022 11:14:38 +0800
Message-ID: <20220926031440.28275-4-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220926031440.28275-1-chenzhongjin@huawei.com>
References: <20220926031440.28275-1-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

char errbuf[BUFSIZ] is defined twice in trace__run.

However out_error_open is not cross to other out_error path, they can
share one errbuf together.

Define the errbuf[BUFSIZ] at the beginning of function, and remove the
redefinations of them for code cleaning.

Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 tools/perf/builtin-trace.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 7ecd76428440..5660c0ee3507 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3937,6 +3937,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	unsigned long before;
 	const bool forks = argc > 0;
 	bool draining = false;
+	char errbuf[BUFSIZ];
 
 	trace->live = true;
 
@@ -4027,8 +4028,6 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 
 	err = bpf__apply_obj_config();
 	if (err) {
-		char errbuf[BUFSIZ];
-
 		bpf__strerror_apply_obj_config(err, errbuf, sizeof(errbuf));
 		pr_err("ERROR: Apply config to BPF failed: %s\n",
 			 errbuf);
@@ -4185,8 +4184,6 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	trace->evlist = NULL;
 	trace->live = false;
 	return err;
-{
-	char errbuf[BUFSIZ];
 
 out_error_sched_stat_runtime:
 	tracing_path__strerror_open_tp(errno, errbuf, sizeof(errbuf), "sched", "sched_stat_runtime");
@@ -4213,7 +4210,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		evsel->filter, evsel__name(evsel), errno,
 		str_error_r(errno, errbuf, sizeof(errbuf)));
 	goto out_delete_evlist;
-}
+
 out_error_mem:
 	fprintf(trace->output, "Not enough memory to run!\n");
 	goto out_delete_evlist;
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF785E9831
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 05:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbiIZDTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 23:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbiIZDSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 23:18:34 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6113526573;
        Sun, 25 Sep 2022 20:18:32 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MbSXg6ZmJzWgrs;
        Mon, 26 Sep 2022 11:14:27 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 11:18:30 +0800
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
Subject: [PATCH -next 1/5] perf: Fix show_arg_names not working for tp arg names
Date:   Mon, 26 Sep 2022 11:14:36 +0800
Message-ID: <20220926031440.28275-2-chenzhongjin@huawei.com>
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

trace__fprintf_tp_fields() will always print arg names because when
implemented it is forced to print arg_names with:
(1 || trace->show_arg_names)

So the printing looks like:

> cat ~/.perfconfig
    [trace]
        show_arg_names = no

> perf trace -e syscalls:*mmap sleep 1
    0.000 sleep/1119 syscalls:sys_enter_mmap(NULL, 8192, READ|WRITE, PRIVATE|ANONYMOUS)
    0.179 sleep/1119 syscalls:sys_exit_mmap(__syscall_nr: 9, ret: 140535426170880)
    ...

Although the comment said that perhaps we need a show_tp_arg_names.
I don't think it's necessary to control them separately because
it's not so clean that part of the log shows arg names but other not.
Also when we are tracing functions it's rare to especially distinguish
syscalls and tp trace.

Only use one option to control arg names printing is more resonable
and simple. So remove the force condition and commit.

After fix:

> perf trace -e syscalls:*mmap sleep 1
    0.000 sleep/1121 syscalls:sys_enter_mmap(NULL, 8192, READ|WRITE, PRIVATE|ANONYMOUS)
    0.163 sleep/1121 syscalls:sys_exit_mmap(9, 140454467661824)
    ...

Fixes: f11b2803bb88 ("perf trace: Allow choosing how to augment the tracepoint arguments")
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 tools/perf/builtin-trace.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 0bd9d01c0df9..c7bb7a8222a6 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2762,11 +2762,7 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
 
 		printed += scnprintf(bf + printed, size - printed, "%s", printed ? ", " : "");
 
-		/*
-		 * XXX Perhaps we should have a show_tp_arg_names,
-		 * leaving show_arg_names just for syscalls?
-		 */
-		if (1 || trace->show_arg_names)
+		if (trace->show_arg_names)
 			printed += scnprintf(bf + printed, size - printed, "%s: ", field->name);
 
 		printed += syscall_arg_fmt__scnprintf_val(arg, bf + printed, size - printed, &syscall_arg, val);
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BA76DC73B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 15:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjDJNWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 09:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjDJNWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 09:22:48 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8051C5B86;
        Mon, 10 Apr 2023 06:22:46 -0700 (PDT)
Received: from kwepemi500007.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Pw8gz1J8Zz17Rv0;
        Mon, 10 Apr 2023 21:19:11 +0800 (CST)
Received: from huawei.com (10.174.179.93) by kwepemi500007.china.huawei.com
 (7.221.188.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 10 Apr
 2023 21:22:41 +0800
From:   Hangliang Lai <laihangliang1@huawei.com>
To:     <namhyung@kernel.org>
CC:     <acme@kernel.org>, <adrian.hunter@intel.com>,
        <alexander.shishkin@linux.intel.com>, <brauner@kernel.org>,
        <hewenliang4@huawei.com>, <irogers@google.com>, <jolsa@kernel.org>,
        <laihangliang1@huawei.com>, <linfeilong@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <liuwenyu7@huawei.com>, <mark.rutland@arm.com>, <mingo@redhat.com>,
        <yeyunfeng@huawei.com>
Subject: [PATCH v3] perf top: expand the range of multithreaded phase
Date:   Mon, 10 Apr 2023 21:22:39 +0800
Message-ID: <20230410132239.2062-1-laihangliang1@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <CAM9d7cgK-P5KuDy7hkAR4j7oB4ydE6Mw3KexqgwPPhJF6MKtXQ@mail.gmail.com>
References: <CAM9d7cgK-P5KuDy7hkAR4j7oB4ydE6Mw3KexqgwPPhJF6MKtXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.179.93]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500007.china.huawei.com (7.221.188.207)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In __cmd_top, perf_set_multithreaded is used to enable pthread_rwlock, thus
donw_read and down_write can work to handle concurrency problems. Then top
use perf_set_singlethreaded and switch to single threaded phase, assuming
that no thread concurrency will happen later.
However, a UAF problem could occur in perf top in single threaded phase,
The concurrent procedure is like this:
display_thread                              process_thread
--------------                              --------------
thread__comm_len
  -> thread__comm_str
    -> __thread__comm_str(thread)
                                            thread__delete
                                             -> comm__free
                                              -> comm_str__put
                                               -> zfree(&cs->str)
    -> thread->comm_len = strlen(comm);
Since in single thread phase, perf_singlethreaded is true, down_read and
down_write can not work to avoid concurrency problems.
This patch put perf_set_singlethreaded to the function tail to expand the
multithreaded phase range, make display_thread and process_thread run
safe.

Signed-off-by: Hangliang Lai  <laihangliang1@huawei.com>
Reviewed-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
v2 -> v3
 - Sorry for my misunderstanding, patch v3 makes perf_set_multithreaded
   unconditional after synthesis and set_singlethread in the end.

 tools/perf/builtin-top.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index d4b5b02bab73..ae96ddaf85c4 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1273,8 +1273,7 @@ static int __cmd_top(struct perf_top *top)
 				    top->evlist->core.threads, true, false,
 				    top->nr_threads_synthesize);
 
-	if (top->nr_threads_synthesize > 1)
-		perf_set_singlethreaded();
+	perf_set_multithreaded();
 
 	if (perf_hpp_list.socket) {
 		ret = perf_env__read_cpu_topology_map(&perf_env);
@@ -1352,6 +1351,7 @@ static int __cmd_top(struct perf_top *top)
 out_join_thread:
 	cond_signal(&top->qe.cond);
 	pthread_join(thread_process, NULL);
+	perf_set_singlethreaded();
 	return ret;
 }
 
-- 
2.33.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69AF86BE62E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 11:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjCQKFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 06:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjCQKFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 06:05:51 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8373962FFB;
        Fri, 17 Mar 2023 03:05:49 -0700 (PDT)
Received: from kwepemi500007.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PdKW15tLFzKnWN;
        Fri, 17 Mar 2023 18:05:01 +0800 (CST)
Received: from huawei.com (10.174.179.93) by kwepemi500007.china.huawei.com
 (7.221.188.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 17 Mar
 2023 18:05:17 +0800
From:   Hangliang Lai <laihangliang1@huawei.com>
To:     <liuwenyu7@huawei.com>, <acme@kernel.org>,
        <adrian.hunter@intel.com>, <alexander.shishkin@linux.intel.com>,
        <brauner@kernel.org>, <hewenliang4@huawei.com>,
        <irogers@google.com>, <jolsa@kernel.org>, <linfeilong@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <mark.rutland@arm.com>, <mingo@redhat.com>, <namhyung@kernel.org>,
        <yeyunfeng@huawei.com>
Subject: [PATCH] perf top: expand the range of multithreaded phase
Date:   Fri, 17 Mar 2023 18:05:14 +0800
Message-ID: <20230317100514.1373-1-laihangliang1@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.179.93]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500007.china.huawei.com (7.221.188.207)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Reported-by: Wenyu Liu <liuwenyu7@huawei.com>
Reviewed-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 tools/perf/builtin-top.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 7c6413447..74239940b 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1280,9 +1280,6 @@ static int __cmd_top(struct perf_top *top)
 				    top->evlist->core.threads, false,
 				    top->nr_threads_synthesize);
 
-	if (top->nr_threads_synthesize > 1)
-		perf_set_singlethreaded();
-
 	if (perf_hpp_list.socket) {
 		ret = perf_env__read_cpu_topology_map(&perf_env);
 		if (ret < 0) {
@@ -1359,6 +1356,10 @@ out_join:
 out_join_thread:
 	pthread_cond_signal(&top->qe.cond);
 	pthread_join(thread_process, NULL);
+
+	if (top->nr_threads_synthesize > 1)
+		perf_set_singlethreaded();
+
 	return ret;
 }
 
-- 
2.33.0


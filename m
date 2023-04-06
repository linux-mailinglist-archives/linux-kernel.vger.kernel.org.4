Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB976D8DBD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 04:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbjDFCy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 22:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235107AbjDFCxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 22:53:46 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884026A45;
        Wed,  5 Apr 2023 19:53:43 -0700 (PDT)
Received: from kwepemi500007.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PsQx871ppzKwlc;
        Thu,  6 Apr 2023 10:51:08 +0800 (CST)
Received: from huawei.com (10.174.179.93) by kwepemi500007.china.huawei.com
 (7.221.188.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 6 Apr
 2023 10:53:31 +0800
From:   Hangliang Lai <laihangliang1@huawei.com>
To:     <namhyung@kernel.org>
CC:     <acme@kernel.org>, <adrian.hunter@intel.com>,
        <alexander.shishkin@linux.intel.com>, <brauner@kernel.org>,
        <hewenliang4@huawei.com>, <irogers@google.com>, <jolsa@kernel.org>,
        <laihangliang1@huawei.com>, <linfeilong@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <liuwenyu7@huawei.com>, <mark.rutland@arm.com>, <mingo@redhat.com>,
        <yeyunfeng@huawei.com>
Subject: [PATCH v2] perf top: expand the range of multithreaded phase
Date:   Thu, 6 Apr 2023 10:53:29 +0800
Message-ID: <20230406025329.1888-1-laihangliang1@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <CAM9d7cjrkWdg18wTA_tRch8oN0YUEy3ZJ2mhrYtk23iLqd1XPw@mail.gmail.com>
References: <CAM9d7cjrkWdg18wTA_tRch8oN0YUEy3ZJ2mhrYtk23iLqd1XPw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.179.93]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500007.china.huawei.com (7.221.188.207)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
v1 -> v2
 - Since perf top is always multi-threaded, remove top->nr_threads_synthesize judgment.

 tools/perf/builtin-top.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index d4b5b02bab73..a18db1ee87fa 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1242,8 +1242,7 @@ static int __cmd_top(struct perf_top *top)
 	if (perf_session__register_idle_thread(top->session) < 0)
 		return ret;
 
-	if (top->nr_threads_synthesize > 1)
-		perf_set_multithreaded();
+	perf_set_multithreaded();
 
 	init_process_thread(top);
 
@@ -1273,9 +1272,6 @@ static int __cmd_top(struct perf_top *top)
 				    top->evlist->core.threads, true, false,
 				    top->nr_threads_synthesize);
 
-	if (top->nr_threads_synthesize > 1)
-		perf_set_singlethreaded();
-
 	if (perf_hpp_list.socket) {
 		ret = perf_env__read_cpu_topology_map(&perf_env);
 		if (ret < 0) {
@@ -1352,6 +1348,9 @@ static int __cmd_top(struct perf_top *top)
 out_join_thread:
 	cond_signal(&top->qe.cond);
 	pthread_join(thread_process, NULL);
+
+	perf_set_singlethreaded();
+
 	return ret;
 }
 
-- 
2.33.0


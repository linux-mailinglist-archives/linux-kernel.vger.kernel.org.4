Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C45E5E765F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 11:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbiIWJAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 05:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbiIWJAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 05:00:17 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4C3FFA70
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 02:00:15 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MYmJV2fhdzHpjW;
        Fri, 23 Sep 2022 16:58:02 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 17:00:13 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <rostedt@goodmis.org>, <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <bsegall@google.com>,
        <mgorman@suse.de>, <bristot@redhat.com>, <vschneid@redhat.com>,
        <cuigaosheng1@huawei.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] ftrace: Remove obsoleted code from ftrace and task_struct
Date:   Fri, 23 Sep 2022 17:00:12 +0800
Message-ID: <20220923090012.505990-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The trace of "struct task_struct" was no longer used since
commit 345ddcc882d8 ("ftrace: Have set_ftrace_pid use the
bitmap like events do"), and the functions about flags for
current->trace is useless, so remove them.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 include/linux/ftrace.h | 41 -----------------------------------------
 include/linux/sched.h  |  3 ---
 2 files changed, 44 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 0b61371e287b..62557d4bffc2 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1122,47 +1122,6 @@ static inline void unpause_graph_tracing(void) { }
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
 
 #ifdef CONFIG_TRACING
-
-/* flags for current->trace */
-enum {
-	TSK_TRACE_FL_TRACE_BIT	= 0,
-	TSK_TRACE_FL_GRAPH_BIT	= 1,
-};
-enum {
-	TSK_TRACE_FL_TRACE	= 1 << TSK_TRACE_FL_TRACE_BIT,
-	TSK_TRACE_FL_GRAPH	= 1 << TSK_TRACE_FL_GRAPH_BIT,
-};
-
-static inline void set_tsk_trace_trace(struct task_struct *tsk)
-{
-	set_bit(TSK_TRACE_FL_TRACE_BIT, &tsk->trace);
-}
-
-static inline void clear_tsk_trace_trace(struct task_struct *tsk)
-{
-	clear_bit(TSK_TRACE_FL_TRACE_BIT, &tsk->trace);
-}
-
-static inline int test_tsk_trace_trace(struct task_struct *tsk)
-{
-	return tsk->trace & TSK_TRACE_FL_TRACE;
-}
-
-static inline void set_tsk_trace_graph(struct task_struct *tsk)
-{
-	set_bit(TSK_TRACE_FL_GRAPH_BIT, &tsk->trace);
-}
-
-static inline void clear_tsk_trace_graph(struct task_struct *tsk)
-{
-	clear_bit(TSK_TRACE_FL_GRAPH_BIT, &tsk->trace);
-}
-
-static inline int test_tsk_trace_graph(struct task_struct *tsk)
-{
-	return tsk->trace & TSK_TRACE_FL_GRAPH;
-}
-
 enum ftrace_dump_mode;
 
 extern enum ftrace_dump_mode ftrace_dump_on_oops;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 5cdf746988a1..77f68f8b795c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1402,9 +1402,6 @@ struct task_struct {
 #endif
 
 #ifdef CONFIG_TRACING
-	/* State flags for use by tracers: */
-	unsigned long			trace;
-
 	/* Bitmask and counter of trace recursion: */
 	unsigned long			trace_recursion;
 #endif /* CONFIG_TRACING */
-- 
2.25.1


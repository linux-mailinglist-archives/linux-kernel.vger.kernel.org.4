Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03EE55EC8ED
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbiI0QCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbiI0QBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:01:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3145EF087
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:01:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96B12B81C64
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 16:01:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65225C433D7;
        Tue, 27 Sep 2022 16:01:40 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1odD2o-00G2wt-2j;
        Tue, 27 Sep 2022 12:02:50 -0400
Message-ID: <20220927160250.439945082@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 27 Sep 2022 12:02:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Gaosheng Cui <cuigaosheng1@huawei.com>
Subject: [for-next][PATCH 17/20] ftrace: Remove obsoleted code from ftrace and task_struct
References: <20220927160216.349640304@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gaosheng Cui <cuigaosheng1@huawei.com>

The trace of "struct task_struct" was no longer used since
commit 345ddcc882d8 ("ftrace: Have set_ftrace_pid use the
bitmap like events do"), and the functions about flags for
current->trace is useless, so remove them.

Link: https://lkml.kernel.org/r/20220923090012.505990-1-cuigaosheng1@huawei.com

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
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
index e7b2f8a5c711..c7ee04e9147a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1381,9 +1381,6 @@ struct task_struct {
 #endif
 
 #ifdef CONFIG_TRACING
-	/* State flags for use by tracers: */
-	unsigned long			trace;
-
 	/* Bitmask and counter of trace recursion: */
 	unsigned long			trace_recursion;
 #endif /* CONFIG_TRACING */
-- 
2.35.1

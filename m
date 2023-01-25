Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B66867B829
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 18:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235769AbjAYRNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 12:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235172AbjAYRNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 12:13:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E92565BE
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 09:13:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD24461586
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 17:13:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92397C43443;
        Wed, 25 Jan 2023 17:13:41 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pKjLA-004NvF-2F;
        Wed, 25 Jan 2023 12:13:40 -0500
Message-ID: <20230125171340.510349637@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 25 Jan 2023 12:13:03 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linyu Yuan <quic_linyyuan@quicinc.com>
Subject: [for-next][PATCH 11/12] perf/tracing: Use stage6 of tracing to not duplicate macros
References: <20230125171252.431857411@goodmis.org>
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

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The perf events are created by the same macro magic as tracefs trace
events are. But to hook into perf, it has its own code. It duplicates many
of the same macros as the tracefs macros and this is an issue because it
misses bug fixes as well as any new enhancements that come with the other
trace macros.

As the trace macros have been put into their own staging files, have perf
take advantage of this and use the tracefs stage 6 macros that the "fast
assign" portion of the trace event macro uses.

Link: https://lkml.kernel.org/r/20230124202515.716458410@goodmis.org
Link: https://lore.kernel.org/lkml/1671181385-5719-1-git-send-email-quic_linyyuan@quicinc.com/

Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reported-by: Linyu Yuan <quic_linyyuan@quicinc.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/perf.h                         | 46 +-------------------
 include/trace/stages/stage6_event_callback.h |  3 ++
 2 files changed, 4 insertions(+), 45 deletions(-)

diff --git a/include/trace/perf.h b/include/trace/perf.h
index 8f3bf1e17707..2c11181c82e0 100644
--- a/include/trace/perf.h
+++ b/include/trace/perf.h
@@ -4,51 +4,7 @@
 
 #ifdef CONFIG_PERF_EVENTS
 
-#undef __entry
-#define __entry entry
-
-#undef __get_dynamic_array
-#define __get_dynamic_array(field)	\
-		((void *)__entry + (__entry->__data_loc_##field & 0xffff))
-
-#undef __get_dynamic_array_len
-#define __get_dynamic_array_len(field)	\
-		((__entry->__data_loc_##field >> 16) & 0xffff)
-
-#undef __get_str
-#define __get_str(field) ((char *)__get_dynamic_array(field))
-
-#undef __get_bitmask
-#define __get_bitmask(field) (char *)__get_dynamic_array(field)
-
-#undef __get_cpumask
-#define __get_cpumask(field) (char *)__get_dynamic_array(field)
-
-#undef __get_sockaddr
-#define __get_sockaddr(field) ((struct sockaddr *)__get_dynamic_array(field))
-
-#undef __get_rel_dynamic_array
-#define __get_rel_dynamic_array(field)	\
-		((void *)__entry +					\
-		 offsetof(typeof(*__entry), __rel_loc_##field) +	\
-		 sizeof(__entry->__rel_loc_##field) +			\
-		 (__entry->__rel_loc_##field & 0xffff))
-
-#undef __get_rel_dynamic_array_len
-#define __get_rel_dynamic_array_len(field)	\
-		((__entry->__rel_loc_##field >> 16) & 0xffff)
-
-#undef __get_rel_str
-#define __get_rel_str(field) ((char *)__get_rel_dynamic_array(field))
-
-#undef __get_rel_bitmask
-#define __get_rel_bitmask(field) (char *)__get_rel_dynamic_array(field)
-
-#undef __get_rel_cpumask
-#define __get_rel_cpumask(field) (char *)__get_rel_dynamic_array(field)
-
-#undef __get_rel_sockaddr
-#define __get_rel_sockaddr(field) ((struct sockaddr *)__get_rel_dynamic_array(field))
+#include "stages/stage6_event_callback.h"
 
 #undef __perf_count
 #define __perf_count(c)	(__count = (c))
diff --git a/include/trace/stages/stage6_event_callback.h b/include/trace/stages/stage6_event_callback.h
index 49c32394b53f..919b1a4da980 100644
--- a/include/trace/stages/stage6_event_callback.h
+++ b/include/trace/stages/stage6_event_callback.h
@@ -2,6 +2,9 @@
 
 /* Stage 6 definitions for creating trace events */
 
+/* Reuse some of the stage 3 macros */
+#include "stage3_trace_output.h"
+
 #undef __entry
 #define __entry entry
 
-- 
2.39.0

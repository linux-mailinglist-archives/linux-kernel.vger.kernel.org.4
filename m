Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E06072EEDD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 00:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237967AbjFMWIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 18:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbjFMWIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 18:08:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922BE10E6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 15:08:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AA3963B7D
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 22:08:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A4DC433B6;
        Tue, 13 Jun 2023 22:08:25 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1q9CBc-000EFG-2Y;
        Tue, 13 Jun 2023 18:08:24 -0400
Message-ID: <20230613220824.617067894@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 13 Jun 2023 18:07:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        William White <chwhite@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [for-next][PATCH 07/11] rtla: Start the tracers after creating all instances
References: <20230613220750.330146797@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Bristot de Oliveira <bristot@kernel.org>

Group all start tracing after finishing creating all instances.

The tracing instance starts first for the case of hitting a stop
tracing while enabling other instances. The trace instance is the
one with most valuable information.

Link: https://lkml.kernel.org/r/67da7a703a56f75d7cd46568525145a65501a7e8.1686066600.git.bristot@kernel.org

Cc: William White <chwhite@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Tested-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/src/osnoise_hist.c  | 14 +++++++++++---
 tools/tracing/rtla/src/osnoise_top.c   | 13 ++++++++++---
 tools/tracing/rtla/src/timerlat_hist.c | 17 ++++++++++++-----
 tools/tracing/rtla/src/timerlat_top.c  | 19 +++++++++++++------
 4 files changed, 46 insertions(+), 17 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index dfbcb5ca7ecb..8f81fa007364 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -870,8 +870,6 @@ int osnoise_hist_main(int argc, char *argv[])
 		}
 	}
 
-	trace_instance_start(trace);
-
 	if (params->trace_output) {
 		record = osnoise_init_trace_tool("osnoise");
 		if (!record) {
@@ -885,9 +883,19 @@ int osnoise_hist_main(int argc, char *argv[])
 				goto out_hist;
 		}
 
-		trace_instance_start(&record->trace);
 	}
 
+	/*
+	 * Start the tracer here, after having set all instances.
+	 *
+	 * Let the trace instance start first for the case of hitting a stop
+	 * tracing while enabling other instances. The trace instance is the
+	 * one with most valuable information.
+	 */
+	if (params->trace_output)
+		trace_instance_start(&record->trace);
+	trace_instance_start(trace);
+
 	tool->start_time = time(NULL);
 	osnoise_hist_set_signals(params);
 
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 0833537bb2eb..85abba568faf 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -697,8 +697,6 @@ int osnoise_top_main(int argc, char **argv)
 		}
 	}
 
-	trace_instance_start(trace);
-
 	if (params->trace_output) {
 		record = osnoise_init_trace_tool("osnoise");
 		if (!record) {
@@ -711,9 +709,18 @@ int osnoise_top_main(int argc, char **argv)
 			if (retval)
 				goto out_top;
 		}
+	}
 
+	/*
+	 * Start the tracer here, after having set all instances.
+	 *
+	 * Let the trace instance start first for the case of hitting a stop
+	 * tracing while enabling other instances. The trace instance is the
+	 * one with most valuable information.
+	 */
+	if (params->trace_output)
 		trace_instance_start(&record->trace);
-	}
+	trace_instance_start(trace);
 
 	tool->start_time = time(NULL);
 	osnoise_top_set_signals(params);
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index e720c8908906..f431cf43246c 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -922,8 +922,6 @@ int timerlat_hist_main(int argc, char *argv[])
 		}
 	}
 
-	trace_instance_start(trace);
-
 	if (params->trace_output) {
 		record = osnoise_init_trace_tool("timerlat");
 		if (!record) {
@@ -936,8 +934,6 @@ int timerlat_hist_main(int argc, char *argv[])
 			if (retval)
 				goto out_hist;
 		}
-
-		trace_instance_start(&record->trace);
 	}
 
 	if (!params->no_aa) {
@@ -956,9 +952,20 @@ int timerlat_hist_main(int argc, char *argv[])
 			err_msg("Failed to enable timerlat tracer\n");
 			goto out_hist;
 		}
+	}
 
+	/*
+	 * Start the tracers here, after having set all instances.
+	 *
+	 * Let the trace instance start first for the case of hitting a stop
+	 * tracing while enabling other instances. The trace instance is the
+	 * one with most valuable information.
+	 */
+	if (params->trace_output)
+		trace_instance_start(&record->trace);
+	if (!params->no_aa)
 		trace_instance_start(&aa->trace);
-	}
+	trace_instance_start(trace);
 
 	tool->start_time = time(NULL);
 	timerlat_hist_set_signals(params);
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index d6b5a382569e..02cff4948981 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -743,8 +743,6 @@ int timerlat_top_main(int argc, char *argv[])
 		}
 	}
 
-	trace_instance_start(trace);
-
 	if (params->trace_output) {
 		record = osnoise_init_trace_tool("timerlat");
 		if (!record) {
@@ -757,8 +755,6 @@ int timerlat_top_main(int argc, char *argv[])
 			if (retval)
 				goto out_top;
 		}
-
-		trace_instance_start(&record->trace);
 	}
 
 	if (!params->no_aa) {
@@ -785,11 +781,22 @@ int timerlat_top_main(int argc, char *argv[])
 				err_msg("Failed to enable timerlat tracer\n");
 				goto out_top;
 			}
-
-			trace_instance_start(&aa->trace);
 		}
 	}
 
+	/*
+	 * Start the tracers here, after having set all instances.
+	 *
+	 * Let the trace instance start first for the case of hitting a stop
+	 * tracing while enabling other instances. The trace instance is the
+	 * one with most valuable information.
+	 */
+	if (params->trace_output)
+		trace_instance_start(&record->trace);
+	if (!params->no_aa && aa != top)
+		trace_instance_start(&aa->trace);
+	trace_instance_start(trace);
+
 	top->start_time = time(NULL);
 	timerlat_top_set_signals(params);
 
-- 
2.39.2

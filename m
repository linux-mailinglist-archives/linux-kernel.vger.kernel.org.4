Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D056A7248A7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 18:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238496AbjFFQNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 12:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238005AbjFFQNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 12:13:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E7610F7;
        Tue,  6 Jun 2023 09:12:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DD4562F50;
        Tue,  6 Jun 2023 16:12:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 809E2C4339C;
        Tue,  6 Jun 2023 16:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686067973;
        bh=Lo8FZAWJl35tTJ74PxG2G+/6DGoIbw32r9OQUCYExV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WUTmYS4IjWAARaoZj47S3OMBdIkMIy4AFeXoGo1OQwm4USgCVNpDruk3/KcafRB5V
         F1r2C+m8R3jU3/tlhsD25e0kR5/p9BBls01cOqtCYm79QXkFaLKT5F2dPpffz28976
         JXWa0v0WvyEPN/NrrpRPvvvB1pNgCIcUj9kxM9713cYw+Fc8LNGma1ppAhyPoCjy7A
         0NRkeaQVhMc8Ytj3uoytQyIszLTLWyogentxYPJdY0HDvQ+vm5ZAJZvdGaa6Vrp8Uu
         tDeaPl8WlYy2E0L9apxGagMEvQaFPGza1Kw1WWh8M1wpQdCPIEwpCMW7aTUUVFdL98
         s98jaj9lYILBA==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-doc@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        William White <chwhite@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH V3 07/11] rtla: Start the tracers after creating all instances
Date:   Tue,  6 Jun 2023 18:12:21 +0200
Message-Id: <67da7a703a56f75d7cd46568525145a65501a7e8.1686066600.git.bristot@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1686066600.git.bristot@kernel.org>
References: <cover.1686066600.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Group all start tracing after finishing creating all instances.

The tracing instance starts first for the case of hitting a stop
tracing while enabling other instances. The trace instance is the
one with most valuable information.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
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
2.38.1


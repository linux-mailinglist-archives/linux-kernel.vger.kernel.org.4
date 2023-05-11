Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18B66FF94E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 20:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239243AbjEKSGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 14:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239192AbjEKSFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 14:05:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F10F7EE8;
        Thu, 11 May 2023 11:05:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C69B36508A;
        Thu, 11 May 2023 18:04:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 230A2C433EF;
        Thu, 11 May 2023 18:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683828294;
        bh=Lo8FZAWJl35tTJ74PxG2G+/6DGoIbw32r9OQUCYExV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gDAaOvOXleWWT2ML7LXmA8ekn0u/RfTKJUzNBlMz6T14g2GBEVRy3Ry9FUjyV037G
         iTF7Z4RFxIecX2JsMnOy7QWzL2y3ixKppJK6/kGZzuxVtVuvyf8KUJ1yMWdwHp5nm8
         4egfFbvbUO7ZoAPvrm2DlJBcfhHrkymxgLnX2m8LTPrR3C0hcp0eaSVIcXu0Olpcpj
         3rEM2lQ/nuLOsWnSSTPVedmj93CKQWNGlPmkLNoPpSl9XsA9QXuOLKZFm9t6Rbs66/
         cGgnIoyo2fw4BkIm+FnKQE7EVcjg+3GxW8mrzvwN8mZdCrU3H1wPmS/a0HTLrdWahy
         fUe7c6w4lFnsw==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     linux-trace-devel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        William White <chwhite@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 7/8] rtla: Start the tracers after creating all instances
Date:   Thu, 11 May 2023 20:04:25 +0200
Message-Id: <26d837baec9e9e261a1352fba6ffe9be8967ba25.1683827510.git.bristot@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1683827510.git.bristot@kernel.org>
References: <cover.1683827510.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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


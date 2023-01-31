Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE476832B6
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 17:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjAaQbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 11:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbjAaQa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 11:30:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9347359261;
        Tue, 31 Jan 2023 08:30:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01668615A6;
        Tue, 31 Jan 2023 16:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E7EDC4339C;
        Tue, 31 Jan 2023 16:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675182623;
        bh=f7t2Tb6aVa91WI4iN6vlSINZLT/DS+dzcmYkQKr3WX8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oCk475dtN9rTBYgLQJIkhxk0pOIAV4ZOz4S9zA6v7zGCpwx2wXNoWn5GIOHDfTg/q
         xbzIuavw9Dj4CfFal7TjvmwgbRWn/IC3B1jfR65zBBydOQsV6ohYQTRuGrNwMBjMgt
         XS2VjyK8r29dv1sdmBjuGzuktSfdsN5V49b74Kda5jekU3FA8VLsYNWOS/AdBG792s
         4Q2n1im+XAtdmQL2pZheAiblT8CYxHyR25EitoYU4f2oYJn95ldGCpgdvO14K7TpDg
         IZbuREEr9aXNZQoV63nhgOFOF3jTEuzV3APzV6DFgO1Ope046os+MtCDjE34DM1UKP
         n3EXJ2LyX/1xQ==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-trace-devel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 4/6] rtla/osnoise_top: Pass the params to the usage function
Date:   Tue, 31 Jan 2023 17:30:05 +0100
Message-Id: <ef1d201894317f9bd32dff6a9aa60ff6ad8e4a58.1675181734.git.bristot@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1675181734.git.bristot@kernel.org>
References: <cover.1675181734.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to the hwnoise tool, pass the osnoise top params to the
usage function so it can be adapted according to the mode of the tool.

Also make it static, as it is only used in this file.

Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Jonathan Corbet <corbet@lwn.net>
---
 tools/tracing/rtla/src/osnoise_top.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index d7bbd73e1a78..fd2104050e3c 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -246,7 +246,7 @@ osnoise_print_stats(struct osnoise_top_params *params, struct osnoise_tool *top)
 /*
  * osnoise_top_usage - prints osnoise top usage message
  */
-void osnoise_top_usage(char *usage)
+static void osnoise_top_usage(struct osnoise_top_params *params, char *usage)
 {
 	int i;
 
@@ -350,7 +350,7 @@ struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
 		case 'c':
 			retval = parse_cpu_list(optarg, &params->monitored_cpus);
 			if (retval)
-				osnoise_top_usage("\nInvalid -c cpu list\n");
+				osnoise_top_usage(params, "\nInvalid -c cpu list\n");
 			params->cpus = optarg;
 			break;
 		case 'D':
@@ -359,7 +359,7 @@ struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
 		case 'd':
 			params->duration = parse_seconds_duration(optarg);
 			if (!params->duration)
-				osnoise_top_usage("Invalid -D duration\n");
+				osnoise_top_usage(params, "Invalid -D duration\n");
 			break;
 		case 'e':
 			tevent = trace_event_alloc(optarg);
@@ -375,17 +375,17 @@ struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
 			break;
 		case 'h':
 		case '?':
-			osnoise_top_usage(NULL);
+			osnoise_top_usage(params, NULL);
 			break;
 		case 'p':
 			params->period = get_llong_from_str(optarg);
 			if (params->period > 10000000)
-				osnoise_top_usage("Period longer than 10 s\n");
+				osnoise_top_usage(params, "Period longer than 10 s\n");
 			break;
 		case 'P':
 			retval = parse_prio(optarg, &params->sched_param);
 			if (retval == -1)
-				osnoise_top_usage("Invalid -P priority");
+				osnoise_top_usage(params, "Invalid -P priority");
 			params->set_sched = 1;
 			break;
 		case 'q':
@@ -394,7 +394,7 @@ struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
 		case 'r':
 			params->runtime = get_llong_from_str(optarg);
 			if (params->runtime < 100)
-				osnoise_top_usage("Runtime shorter than 100 us\n");
+				osnoise_top_usage(params, "Runtime shorter than 100 us\n");
 			break;
 		case 's':
 			params->stop_us = get_llong_from_str(optarg);
@@ -420,7 +420,7 @@ struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
 					exit(EXIT_FAILURE);
 				}
 			} else {
-				osnoise_top_usage("--trigger requires a previous -e\n");
+				osnoise_top_usage(params, "--trigger requires a previous -e\n");
 			}
 			break;
 		case '1': /* filter */
@@ -431,11 +431,11 @@ struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
 					exit(EXIT_FAILURE);
 				}
 			} else {
-				osnoise_top_usage("--filter requires a previous -e\n");
+				osnoise_top_usage(params, "--filter requires a previous -e\n");
 			}
 			break;
 		default:
-			osnoise_top_usage("Invalid option");
+			osnoise_top_usage(params, "Invalid option");
 		}
 	}
 
-- 
2.38.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA89863D022
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 09:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbiK3IJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 03:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiK3IJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 03:09:43 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B516598
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 00:09:42 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NMX1K4Lmhz4xVnd;
        Wed, 30 Nov 2022 16:09:41 +0800 (CST)
Received: from szxlzmapp02.zte.com.cn ([10.5.231.79])
        by mse-fl2.zte.com.cn with SMTP id 2AU89YZ2031869;
        Wed, 30 Nov 2022 16:09:34 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp02[null])
        by mapi (Zmail) with MAPI id mid14;
        Wed, 30 Nov 2022 16:09:36 +0800 (CST)
Date:   Wed, 30 Nov 2022 16:09:36 +0800 (CST)
X-Zmail-TransId: 2b0463870fc0ffffffffcbc4aed9
X-Mailer: Zmail v1.0
Message-ID: <202211301609369309377@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <rostedt@goodmis.org>
Cc:     <mhiramat@kernel.org>, <linux-kernel@vger.kernel.org>,
        <xu.panda@zte.com.cn>, <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHRyYWNpbmc6IHJlcGxhY2Ugc3RybmNweSgpIHdpdGggc3Ryc2NweSgp?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2AU89YZ2031869
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 63870FC5.000 by FangMail milter!
X-FangMail-Envelope: 1669795781/4NMX1K4Lmhz4xVnd/63870FC5.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63870FC5.000/4NMX1K4Lmhz4xVnd
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu Panda <xu.panda@zte.com.cn>

The implementation of strscpy() is more robust and safer.
That's now the recommended way to copy NUL terminated strings.

Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
Signed-off-by: Yang Yang <yang.yang29@zte.com>
---
 kernel/trace/trace.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 93a75a97118f..d6d2228eb67d 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -189,7 +189,7 @@ static bool snapshot_at_boot;

 static int __init set_cmdline_ftrace(char *str)
 {
-	strlcpy(bootup_tracer_buf, str, MAX_TRACER_SIZE);
+	strscpy(bootup_tracer_buf, str, MAX_TRACER_SIZE);
 	default_bootup_tracer = bootup_tracer_buf;
 	/* We are using ftrace early, expand it */
 	ring_buffer_expanded = true;
@@ -244,7 +244,7 @@ static char trace_boot_options_buf[MAX_TRACER_SIZE] __initdata;

 static int __init set_trace_boot_options(char *str)
 {
-	strlcpy(trace_boot_options_buf, str, MAX_TRACER_SIZE);
+	strscpy(trace_boot_options_buf, str, MAX_TRACER_SIZE);
 	return 1;
 }
 __setup("trace_options=", set_trace_boot_options);
@@ -254,7 +254,7 @@ static char *trace_boot_clock __initdata;

 static int __init set_trace_boot_clock(char *str)
 {
-	strlcpy(trace_boot_clock_buf, str, MAX_TRACER_SIZE);
+	strscpy(trace_boot_clock_buf, str, MAX_TRACER_SIZE);
 	trace_boot_clock = trace_boot_clock_buf;
 	return 1;
 }
@@ -2476,7 +2476,7 @@ static void __trace_find_cmdline(int pid, char comm[])
 	if (map != NO_CMDLINE_MAP) {
 		tpid = savedcmd->map_cmdline_to_pid[map];
 		if (tpid == pid) {
-			strlcpy(comm, get_saved_cmdlines(map), TASK_COMM_LEN);
+			strscpy(comm, get_saved_cmdlines(map), TASK_COMM_LEN);
 			return;
 		}
 	}
-- 
2.15.2

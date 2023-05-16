Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791717050FA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 16:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbjEPOkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 10:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjEPOkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 10:40:14 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287BFBC;
        Tue, 16 May 2023 07:40:13 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-76c75d32005so178578239f.1;
        Tue, 16 May 2023 07:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684248012; x=1686840012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=olj+p3bMizlMNR7MFic+0JE4td7cj29Rf08MzL18JhQ=;
        b=m7D15QAhIAeAnF89+z86YuAN3rmM45++XJq1/PN6mlMRn1XG8OTM1JDo/40W46iLQh
         2Iw39K2+puJBVAJ6UvpkHhZB7kdqpiwEd/9OuswJZeLyMnaNh1qi36ZlXy38zZWJwUtL
         QYj4amxh3RN5StFogK83VKcw6xqyo7KGm4i7MvHbjaTI04V4HxkUnLbaBI5Pkm7n2LPQ
         N//bMs9khHeH1um4RqQPet2wfVsQqzj6hY6FyVbIQkqqapRVVrLfalJOSx4aOrb1tRF0
         lowef7czxMi/gKipR6F7qb5hl8W9dJS85JyQa+FbXL/roR9q40Gtvpr8UorQfsnQjCxF
         1BWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684248012; x=1686840012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=olj+p3bMizlMNR7MFic+0JE4td7cj29Rf08MzL18JhQ=;
        b=iIoXba/qyfP0geISv7rIEuZK9sjq3UNlcTJzbP/okPmvM7Nmn8CVhKqEVhnGEC4HHV
         ZsNWFKFR7ZOvgVm4rRfsDdj1k5dLDimqFZiOkDUFyHcG7OanD/iBIz2TkwVkjf5DUVXt
         MHKlRlBJf6SI5Ka/t6Ov94DPvMKX1xALv0SPMgn4l+8PZEGC5sr2I6rxiL36rvN+0RMp
         HkBlDgs8DLOWyA54bu+SWTFaTxOagQR3otZn3qsFDEoBAriggMJsRL3qYBaHeJm7mv+a
         cnX5b+rgvKjnlO59mb/DcAx+wg2aAVKT0Vw8PvH6r0fWeCDoBiyyPMvBH2Mz+5/IFqdN
         0Pcg==
X-Gm-Message-State: AC+VfDxeQJKpDIRHNfbkOCEu+s1QmA0noG7pogiTmhXsRKn8x39o6F56
        NBHn/kf8bin4iqPvppAGQEPbl1xjb9ZU6Q==
X-Google-Smtp-Source: ACHHUZ7OVfR2fUD0iUAGiw/FCC+MaKGdxASAQiYCMxFP18MkhOIcvZjsT3C1f+M1jhDSV4XrM7b8QQ==
X-Received: by 2002:a92:cb4f:0:b0:334:f662:6406 with SMTP id f15-20020a92cb4f000000b00334f6626406mr23362626ilq.25.1684248012304;
        Tue, 16 May 2023 07:40:12 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id f66-20020a0284c8000000b00411af6e8091sm8086349jai.66.2023.05.16.07.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 07:40:11 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2] tracing: Replace all non-returning strlcpy with strscpy
Date:   Tue, 16 May 2023 14:39:56 +0000
Message-ID: <20230516143956.1367827-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().

No return values were used, so direct replacement with strlcpy is safe.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
v1: https://lore.kernel.org/all/20230516043943.5234-1-azeemshaikh38@gmail.com/
Changes from v1:
 - Removed subsystem specific files.
 - Minor update to commit log.

 kernel/trace/trace.c               |    8 ++++----
 kernel/trace/trace_events.c        |    4 ++--
 kernel/trace/trace_events_inject.c |    4 ++--
 kernel/trace/trace_kprobe.c        |    2 +-
 kernel/trace/trace_probe.c         |    2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ebc59781456a..28ccd0c9bdf0 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -196,7 +196,7 @@ static int boot_snapshot_index;
 
 static int __init set_cmdline_ftrace(char *str)
 {
-	strlcpy(bootup_tracer_buf, str, MAX_TRACER_SIZE);
+	strscpy(bootup_tracer_buf, str, MAX_TRACER_SIZE);
 	default_bootup_tracer = bootup_tracer_buf;
 	/* We are using ftrace early, expand it */
 	ring_buffer_expanded = true;
@@ -281,7 +281,7 @@ static char trace_boot_options_buf[MAX_TRACER_SIZE] __initdata;
 
 static int __init set_trace_boot_options(char *str)
 {
-	strlcpy(trace_boot_options_buf, str, MAX_TRACER_SIZE);
+	strscpy(trace_boot_options_buf, str, MAX_TRACER_SIZE);
 	return 1;
 }
 __setup("trace_options=", set_trace_boot_options);
@@ -291,7 +291,7 @@ static char *trace_boot_clock __initdata;
 
 static int __init set_trace_boot_clock(char *str)
 {
-	strlcpy(trace_boot_clock_buf, str, MAX_TRACER_SIZE);
+	strscpy(trace_boot_clock_buf, str, MAX_TRACER_SIZE);
 	trace_boot_clock = trace_boot_clock_buf;
 	return 1;
 }
@@ -2521,7 +2521,7 @@ static void __trace_find_cmdline(int pid, char comm[])
 	if (map != NO_CMDLINE_MAP) {
 		tpid = savedcmd->map_cmdline_to_pid[map];
 		if (tpid == pid) {
-			strlcpy(comm, get_saved_cmdlines(map), TASK_COMM_LEN);
+			strscpy(comm, get_saved_cmdlines(map), TASK_COMM_LEN);
 			return;
 		}
 	}
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 654ffa40457a..dc83a259915b 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2831,7 +2831,7 @@ static __init int setup_trace_triggers(char *str)
 	char *buf;
 	int i;
 
-	strlcpy(bootup_trigger_buf, str, COMMAND_LINE_SIZE);
+	strscpy(bootup_trigger_buf, str, COMMAND_LINE_SIZE);
 	ring_buffer_expanded = true;
 	disable_tracing_selftest("running event triggers");
 
@@ -3621,7 +3621,7 @@ static char bootup_event_buf[COMMAND_LINE_SIZE] __initdata;
 
 static __init int setup_trace_event(char *str)
 {
-	strlcpy(bootup_event_buf, str, COMMAND_LINE_SIZE);
+	strscpy(bootup_event_buf, str, COMMAND_LINE_SIZE);
 	ring_buffer_expanded = true;
 	disable_tracing_selftest("running event tracing");
 
diff --git a/kernel/trace/trace_events_inject.c b/kernel/trace/trace_events_inject.c
index d6b4935a78c0..abe805d471eb 100644
--- a/kernel/trace/trace_events_inject.c
+++ b/kernel/trace/trace_events_inject.c
@@ -217,7 +217,7 @@ static int parse_entry(char *str, struct trace_event_call *call, void **pentry)
 			char *addr = (char *)(unsigned long) val;
 
 			if (field->filter_type == FILTER_STATIC_STRING) {
-				strlcpy(entry + field->offset, addr, field->size);
+				strscpy(entry + field->offset, addr, field->size);
 			} else if (field->filter_type == FILTER_DYN_STRING ||
 				   field->filter_type == FILTER_RDYN_STRING) {
 				int str_len = strlen(addr) + 1;
@@ -232,7 +232,7 @@ static int parse_entry(char *str, struct trace_event_call *call, void **pentry)
 				}
 				entry = *pentry;
 
-				strlcpy(entry + (entry_size - str_len), addr, str_len);
+				strscpy(entry + (entry_size - str_len), addr, str_len);
 				str_item = (u32 *)(entry + field->offset);
 				if (field->filter_type == FILTER_RDYN_STRING)
 					str_loc -= field->offset + field->size;
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 59cda19a9033..1b3fa7b854aa 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -30,7 +30,7 @@ static char kprobe_boot_events_buf[COMMAND_LINE_SIZE] __initdata;
 
 static int __init set_kprobe_boot_events(char *str)
 {
-	strlcpy(kprobe_boot_events_buf, str, COMMAND_LINE_SIZE);
+	strscpy(kprobe_boot_events_buf, str, COMMAND_LINE_SIZE);
 	disable_tracing_selftest("running kprobe events");
 
 	return 1;
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 2d2616678295..73055ba8d8ef 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -254,7 +254,7 @@ int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
 			trace_probe_log_err(offset, GROUP_TOO_LONG);
 			return -EINVAL;
 		}
-		strlcpy(buf, event, slash - event + 1);
+		strscpy(buf, event, slash - event + 1);
 		if (!is_good_system_name(buf)) {
 			trace_probe_log_err(offset, BAD_GROUP_NAME);
 			return -EINVAL;
-- 
2.40.1.606.ga4b1b128d6-goog



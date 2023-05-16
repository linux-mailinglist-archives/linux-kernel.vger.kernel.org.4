Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4836570445A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 06:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjEPEkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 00:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjEPEkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 00:40:09 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F5AF7;
        Mon, 15 May 2023 21:40:07 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-76c791e2d8dso458282239f.3;
        Mon, 15 May 2023 21:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684212007; x=1686804007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d0A9jG155+N7DfNeprAdiNAMCHTG4dLeowTVhFJUKMQ=;
        b=ZMRgghfjEU78PwqQUfLS7A7fu4z8Rnop2YIarel2UXUCFZX2oVBQ75+da5G+BgI+Te
         LGj3ZUEAhyDFTm8m4486QZsnf9n3RfojxEh+wF55+yeKfdbr7pN8ttkrrpsxU/sQSbE9
         FNGeSRa6K4UKSgnnzlZz3whtqLSWFeFa93pONj+uIdpKBeqLiSu1V1z3Obvsf0e4a3n/
         d1eQmbC2PVFxJRVQ3mSpRRXDsieQj7BH051LNa6bu6g8W/gRdDR5qTX262PCNSqeUDia
         Ct9ZnLA91SqwXHQbc1prr+vumqC3aPQuxJ7WkMnierNHZA/DPVUTwuOjckYyX8/HUK+e
         b66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684212007; x=1686804007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d0A9jG155+N7DfNeprAdiNAMCHTG4dLeowTVhFJUKMQ=;
        b=VKRo5U7PRL2LjRWIBQ8nJYOd43R9Mrdrrb0AjfoctFPSiPLOBeRjQZ7QVGkPmXhSPA
         1pw98Dtoa6OfpwkQ2mf74LIWKjsFZOr6K6T91REG/J05AHYUeaiy9HZ/whPBhGD4rwa7
         G2edEfpdhSzH1Km5JLl4FzcSLybKPv7K9RR/f9aAkzpHr+jAqnJf4jOVsPQF9uTTmlpR
         +jGa3xsrybONwVEoLFJEsLg0ZNhe4ZzIa5uRjh4RS9fJXlcAhgzGpJyQE7T2oNOUsumm
         UkIvxiKTmPC19bnmWGyE/GWXco3JUz3ieyYIoHFNjeIMLGeov8AQ/5oUW/TtEYHH+mq4
         FiHg==
X-Gm-Message-State: AC+VfDwhfRB8gX16YIF5PPjsIRKTWJ9O7hbtP7QZrs3kJ53m/FVO3IjX
        8nG/7HsL6S2ExWls3Vk0V/78pEM1HuNiKg==
X-Google-Smtp-Source: ACHHUZ7C7n5Ral8WPD/U8jNYuyRFPtsWFI2xDwwTD0Qdlf5+m9krgpqQ89yczPsivrqjFqiTPBXihg==
X-Received: by 2002:a5d:938f:0:b0:770:1978:7ec2 with SMTP id c15-20020a5d938f000000b0077019787ec2mr56445iol.5.1684212006666;
        Mon, 15 May 2023 21:40:06 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id a63-20020a029445000000b0040bbf478147sm7613724jai.163.2023.05.15.21.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 21:40:06 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        David Ahern <dsahern@kernel.org>,
        Mark Bloch <mbloch@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH] tracing: Replace all non-returning strlcpy with strscpy
Date:   Tue, 16 May 2023 04:39:43 +0000
Message-ID: <20230516043943.5234-1-azeemshaikh38@gmail.com>
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
Occurences of strlcpy within TRACE_EVENT macros were replaced with
__string() and __assign_str() macro helpers instead.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 include/trace/events/fib.h         |    2 +-
 include/trace/events/fib6.h        |    2 +-
 include/trace/events/kyber.h       |   24 ++++++++++++------------
 include/trace/events/task.h        |    6 +++---
 include/trace/events/wbt.h         |   28 ++++++++++++----------------
 kernel/trace/trace.c               |    8 ++++----
 kernel/trace/trace_events.c        |    4 ++--
 kernel/trace/trace_events_inject.c |    4 ++--
 kernel/trace/trace_kprobe.c        |    2 +-
 kernel/trace/trace_probe.c         |    2 +-
 10 files changed, 39 insertions(+), 43 deletions(-)

diff --git a/include/trace/events/fib.h b/include/trace/events/fib.h
index 76297ecd4935..20b914250ce9 100644
--- a/include/trace/events/fib.h
+++ b/include/trace/events/fib.h
@@ -65,7 +65,7 @@ TRACE_EVENT(fib_table_lookup,
 		}
 
 		dev = nhc ? nhc->nhc_dev : NULL;
-		strlcpy(__entry->name, dev ? dev->name : "-", IFNAMSIZ);
+		strscpy(__entry->name, dev ? dev->name : "-", IFNAMSIZ);
 
 		if (nhc) {
 			if (nhc->nhc_gw_family == AF_INET) {
diff --git a/include/trace/events/fib6.h b/include/trace/events/fib6.h
index 4d3e607b3cde..5d7ee2610728 100644
--- a/include/trace/events/fib6.h
+++ b/include/trace/events/fib6.h
@@ -63,7 +63,7 @@ TRACE_EVENT(fib6_table_lookup,
 		}
 
 		if (res->nh && res->nh->fib_nh_dev) {
-			strlcpy(__entry->name, res->nh->fib_nh_dev->name, IFNAMSIZ);
+			strscpy(__entry->name, res->nh->fib_nh_dev->name, IFNAMSIZ);
 		} else {
 			strcpy(__entry->name, "-");
 		}
diff --git a/include/trace/events/kyber.h b/include/trace/events/kyber.h
index bf7533f171ff..d4db2fa60e7b 100644
--- a/include/trace/events/kyber.h
+++ b/include/trace/events/kyber.h
@@ -21,8 +21,8 @@ TRACE_EVENT(kyber_latency,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev				)
-		__array(	char,	domain,	DOMAIN_LEN		)
-		__array(	char,	type,	LATENCY_TYPE_LEN	)
+		__string(	domain,	domain				)
+		__string(	type,	type				)
 		__field(	u8,	percentile			)
 		__field(	u8,	numerator			)
 		__field(	u8,	denominator			)
@@ -31,8 +31,8 @@ TRACE_EVENT(kyber_latency,
 
 	TP_fast_assign(
 		__entry->dev		= dev;
-		strlcpy(__entry->domain, domain, sizeof(__entry->domain));
-		strlcpy(__entry->type, type, sizeof(__entry->type));
+		__assign_str(domain, domain);
+		__assign_str(type, type);
 		__entry->percentile	= percentile;
 		__entry->numerator	= numerator;
 		__entry->denominator	= denominator;
@@ -40,8 +40,8 @@ TRACE_EVENT(kyber_latency,
 	),
 
 	TP_printk("%d,%d %s %s p%u %u/%u samples=%u",
-		  MAJOR(__entry->dev), MINOR(__entry->dev), __entry->domain,
-		  __entry->type, __entry->percentile, __entry->numerator,
+		  MAJOR(__entry->dev), MINOR(__entry->dev), __get_str(domain),
+		  __get_str(type), __entry->percentile, __entry->numerator,
 		  __entry->denominator, __entry->samples)
 );
 
@@ -53,18 +53,18 @@ TRACE_EVENT(kyber_adjust,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
-		__array(	char,	domain,	DOMAIN_LEN	)
+		__string(	domain,	domain			)
 		__field(	unsigned int,	depth		)
 	),
 
 	TP_fast_assign(
 		__entry->dev		= dev;
-		strlcpy(__entry->domain, domain, sizeof(__entry->domain));
+		__assign_str(domain, domain);
 		__entry->depth		= depth;
 	),
 
 	TP_printk("%d,%d %s %u",
-		  MAJOR(__entry->dev), MINOR(__entry->dev), __entry->domain,
+		  MAJOR(__entry->dev), MINOR(__entry->dev), __get_str(domain),
 		  __entry->depth)
 );
 
@@ -76,16 +76,16 @@ TRACE_EVENT(kyber_throttled,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
-		__array(	char,	domain,	DOMAIN_LEN	)
+		__string(	domain,	domain			)
 	),
 
 	TP_fast_assign(
 		__entry->dev		= dev;
-		strlcpy(__entry->domain, domain, sizeof(__entry->domain));
+		__assign_str(domain, domain);
 	),
 
 	TP_printk("%d,%d %s", MAJOR(__entry->dev), MINOR(__entry->dev),
-		  __entry->domain)
+		  __get_str(domain))
 );
 
 #define _TRACE_KYBER_H
diff --git a/include/trace/events/task.h b/include/trace/events/task.h
index 64d160930b0d..48b1bb868a86 100644
--- a/include/trace/events/task.h
+++ b/include/trace/events/task.h
@@ -40,20 +40,20 @@ TRACE_EVENT(task_rename,
 	TP_STRUCT__entry(
 		__field(	pid_t,	pid)
 		__array(	char, oldcomm,  TASK_COMM_LEN)
-		__array(	char, newcomm,  TASK_COMM_LEN)
+		__string(	newcomm,	comm)
 		__field(	short,	oom_score_adj)
 	),
 
 	TP_fast_assign(
 		__entry->pid = task->pid;
 		memcpy(entry->oldcomm, task->comm, TASK_COMM_LEN);
-		strlcpy(entry->newcomm, comm, TASK_COMM_LEN);
+		__assign_str(newcomm, comm);
 		__entry->oom_score_adj = task->signal->oom_score_adj;
 	),
 
 	TP_printk("pid=%d oldcomm=%s newcomm=%s oom_score_adj=%hd",
 		__entry->pid, __entry->oldcomm,
-		__entry->newcomm, __entry->oom_score_adj)
+		__get_str(newcomm), __entry->oom_score_adj)
 );
 
 #endif
diff --git a/include/trace/events/wbt.h b/include/trace/events/wbt.h
index 9c66e59d859c..874404822575 100644
--- a/include/trace/events/wbt.h
+++ b/include/trace/events/wbt.h
@@ -19,7 +19,7 @@ TRACE_EVENT(wbt_stat,
 	TP_ARGS(bdi, stat),
 
 	TP_STRUCT__entry(
-		__array(char, name, 32)
+		__string(name, bdi_dev_name(bdi))
 		__field(s64, rmean)
 		__field(u64, rmin)
 		__field(u64, rmax)
@@ -33,8 +33,7 @@ TRACE_EVENT(wbt_stat,
 	),
 
 	TP_fast_assign(
-		strlcpy(__entry->name, bdi_dev_name(bdi),
-			ARRAY_SIZE(__entry->name));
+		__assign_str(name, bdi_dev_name(bdi));
 		__entry->rmean		= stat[0].mean;
 		__entry->rmin		= stat[0].min;
 		__entry->rmax		= stat[0].max;
@@ -47,7 +46,7 @@ TRACE_EVENT(wbt_stat,
 
 	TP_printk("%s: rmean=%llu, rmin=%llu, rmax=%llu, rsamples=%llu, "
 		  "wmean=%llu, wmin=%llu, wmax=%llu, wsamples=%llu",
-		  __entry->name, __entry->rmean, __entry->rmin, __entry->rmax,
+		  __get_str(name), __entry->rmean, __entry->rmin, __entry->rmax,
 		  __entry->rnr_samples, __entry->wmean, __entry->wmin,
 		  __entry->wmax, __entry->wnr_samples)
 );
@@ -63,17 +62,16 @@ TRACE_EVENT(wbt_lat,
 	TP_ARGS(bdi, lat),
 
 	TP_STRUCT__entry(
-		__array(char, name, 32)
+		__string(name, bdi_dev_name(bdi))
 		__field(unsigned long, lat)
 	),
 
 	TP_fast_assign(
-		strlcpy(__entry->name, bdi_dev_name(bdi),
-			ARRAY_SIZE(__entry->name));
+		__assign_str(name, bdi_dev_name(bdi));
 		__entry->lat = div_u64(lat, 1000);
 	),
 
-	TP_printk("%s: latency %lluus", __entry->name,
+	TP_printk("%s: latency %lluus", __get_str(name),
 			(unsigned long long) __entry->lat)
 );
 
@@ -95,7 +93,7 @@ TRACE_EVENT(wbt_step,
 	TP_ARGS(bdi, msg, step, window, bg, normal, max),
 
 	TP_STRUCT__entry(
-		__array(char, name, 32)
+		__string(name, bdi_dev_name(bdi))
 		__field(const char *, msg)
 		__field(int, step)
 		__field(unsigned long, window)
@@ -105,8 +103,7 @@ TRACE_EVENT(wbt_step,
 	),
 
 	TP_fast_assign(
-		strlcpy(__entry->name, bdi_dev_name(bdi),
-			ARRAY_SIZE(__entry->name));
+		__assign_str(name, bdi_dev_name(bdi));
 		__entry->msg	= msg;
 		__entry->step	= step;
 		__entry->window	= div_u64(window, 1000);
@@ -116,7 +113,7 @@ TRACE_EVENT(wbt_step,
 	),
 
 	TP_printk("%s: %s: step=%d, window=%luus, background=%u, normal=%u, max=%u",
-		  __entry->name, __entry->msg, __entry->step, __entry->window,
+		  __get_str(name), __entry->msg, __entry->step, __entry->window,
 		  __entry->bg, __entry->normal, __entry->max)
 );
 
@@ -134,21 +131,20 @@ TRACE_EVENT(wbt_timer,
 	TP_ARGS(bdi, status, step, inflight),
 
 	TP_STRUCT__entry(
-		__array(char, name, 32)
+		__string(name, bdi_dev_name(bdi))
 		__field(unsigned int, status)
 		__field(int, step)
 		__field(unsigned int, inflight)
 	),
 
 	TP_fast_assign(
-		strlcpy(__entry->name, bdi_dev_name(bdi),
-			ARRAY_SIZE(__entry->name));
+		__assign_str(name, bdi_dev_name(bdi));
 		__entry->status		= status;
 		__entry->step		= step;
 		__entry->inflight	= inflight;
 	),
 
-	TP_printk("%s: status=%u, step=%d, inflight=%u", __entry->name,
+	TP_printk("%s: status=%u, step=%d, inflight=%u", __get_str(name),
 		  __entry->status, __entry->step, __entry->inflight)
 );
 
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


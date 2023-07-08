Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17B174BB7A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 04:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbjGHCtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 22:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbjGHCs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 22:48:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D7A211E;
        Fri,  7 Jul 2023 19:48:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F58E61AD8;
        Sat,  8 Jul 2023 02:48:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E12C433C8;
        Sat,  8 Jul 2023 02:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688784534;
        bh=dyGyLJr8vd+bW4LxAKW9oZijQiFuiaTQ8/8k42bABvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kS5tRiIkiXcUvU1M+ONWsKfHUTr33ioXsv2t56O9KBx5kQ6WYeyj60/UTNNGW7TJ5
         BzEqGR6Sw18NtcwM16ecNnOf+OZc05P8NZ6B5qT6Nrl2XBsnHlfjEsSK3hzdrZd1Rn
         srD6aJDZdFXg+J04tm68WjQTrkTQnHXdAL/epTdARkttlLP7Q+braTVIxyu+Gl4AUU
         xa+9upnM43pomfv0wqKZT+SxgmW3MzylNWIkm2SupQ0b2+UM0Bsn2+f0SyMomg/0p0
         NZ5s4MIRQuo4pZUqLMtJEPK65C5QoJIPXvwPj8m+EkUtQUOB4hEMU0nWvX3/tRNQQk
         Gd8Q1nGXhBswA==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v3 3/4] Revert "tracing: Add "(fault)" name injection to kernel probes"
Date:   Sat,  8 Jul 2023 11:48:49 +0900
Message-ID:  <168878452929.2721251.16117401906019189239.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
In-Reply-To:  <168878450334.2721251.3030778817503575503.stgit@mhiramat.roam.corp.google.com>
References:  <168878450334.2721251.3030778817503575503.stgit@mhiramat.roam.corp.google.com>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

This reverts commit 2e9906f84fc7c99388bb7123ade167250d50f1c0.

It was turned out that commit 2e9906f84fc7 ("tracing: Add "(fault)"
name injection to kernel probes") did not work correctly and probe
events still show just '(fault)' (instead of '"(fault)"'). Also,
current '(fault)' is more explicit that it faulted.

This also moves FAULT_STRING macro to trace.h so that synthetic
event can keep using it, and uses it in trace_probe.c too.

Link: https://lore.kernel.org/all/20230706230642.3793a593@rorschach.local.home/

Cc: stable@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v3:
  - Move FAULT_STRING macro to trace.h so that synthetic event can keep using it.
  - Use FAULT_STRING in trace_probe.c.
---
 kernel/trace/trace.h              |    2 ++
 kernel/trace/trace_probe.c        |    2 +-
 kernel/trace/trace_probe_kernel.h |   31 ++++++-------------------------
 3 files changed, 9 insertions(+), 26 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 79bdefe9261b..eee1f3ca4749 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -113,6 +113,8 @@ enum trace_type {
 #define MEM_FAIL(condition, fmt, ...)					\
 	DO_ONCE_LITE_IF(condition, pr_err, "ERROR: " fmt, ##__VA_ARGS__)
 
+#define FAULT_STRING "(fault)"
+
 #define HIST_STACKTRACE_DEPTH	16
 #define HIST_STACKTRACE_SIZE	(HIST_STACKTRACE_DEPTH * sizeof(unsigned long))
 #define HIST_STACKTRACE_SKIP	5
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 2d2616678295..591399ddcee5 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -65,7 +65,7 @@ int PRINT_TYPE_FUNC_NAME(string)(struct trace_seq *s, void *data, void *ent)
 	int len = *(u32 *)data >> 16;
 
 	if (!len)
-		trace_seq_puts(s, "(fault)");
+		trace_seq_puts(s, FAULT_STRING);
 	else
 		trace_seq_printf(s, "\"%s\"",
 				 (const char *)get_loc_data(data, ent));
diff --git a/kernel/trace/trace_probe_kernel.h b/kernel/trace/trace_probe_kernel.h
index c4e1d4c03a85..6deae2ce34f8 100644
--- a/kernel/trace/trace_probe_kernel.h
+++ b/kernel/trace/trace_probe_kernel.h
@@ -2,8 +2,6 @@
 #ifndef __TRACE_PROBE_KERNEL_H_
 #define __TRACE_PROBE_KERNEL_H_
 
-#define FAULT_STRING "(fault)"
-
 /*
  * This depends on trace_probe.h, but can not include it due to
  * the way trace_probe_tmpl.h is used by trace_kprobe.c and trace_eprobe.c.
@@ -15,16 +13,8 @@ static nokprobe_inline int
 fetch_store_strlen_user(unsigned long addr)
 {
 	const void __user *uaddr =  (__force const void __user *)addr;
-	int ret;
 
-	ret = strnlen_user_nofault(uaddr, MAX_STRING_SIZE);
-	/*
-	 * strnlen_user_nofault returns zero on fault, insert the
-	 * FAULT_STRING when that occurs.
-	 */
-	if (ret <= 0)
-		return strlen(FAULT_STRING) + 1;
-	return ret;
+	return strnlen_user_nofault(uaddr, MAX_STRING_SIZE);
 }
 
 /* Return the length of string -- including null terminal byte */
@@ -44,18 +34,7 @@ fetch_store_strlen(unsigned long addr)
 		len++;
 	} while (c && ret == 0 && len < MAX_STRING_SIZE);
 
-	/* For faults, return enough to hold the FAULT_STRING */
-	return (ret < 0) ? strlen(FAULT_STRING) + 1 : len;
-}
-
-static nokprobe_inline void set_data_loc(int ret, void *dest, void *__dest, void *base, int len)
-{
-	if (ret >= 0) {
-		*(u32 *)dest = make_data_loc(ret, __dest - base);
-	} else {
-		strscpy(__dest, FAULT_STRING, len);
-		ret = strlen(__dest) + 1;
-	}
+	return (ret < 0) ? ret : len;
 }
 
 /*
@@ -76,7 +55,8 @@ fetch_store_string_user(unsigned long addr, void *dest, void *base)
 	__dest = get_loc_data(dest, base);
 
 	ret = strncpy_from_user_nofault(__dest, uaddr, maxlen);
-	set_data_loc(ret, dest, __dest, base, maxlen);
+	if (ret >= 0)
+		*(u32 *)dest = make_data_loc(ret, __dest - base);
 
 	return ret;
 }
@@ -107,7 +87,8 @@ fetch_store_string(unsigned long addr, void *dest, void *base)
 	 * probing.
 	 */
 	ret = strncpy_from_kernel_nofault(__dest, (void *)addr, maxlen);
-	set_data_loc(ret, dest, __dest, base, maxlen);
+	if (ret >= 0)
+		*(u32 *)dest = make_data_loc(ret, __dest - base);
 
 	return ret;
 }


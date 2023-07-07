Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A0974B1F7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 15:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbjGGNl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 09:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjGGNlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 09:41:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BE6211B;
        Fri,  7 Jul 2023 06:41:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3719C61995;
        Fri,  7 Jul 2023 13:41:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35533C433C8;
        Fri,  7 Jul 2023 13:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688737275;
        bh=Bqoptaj/wUu7wStZpGPp5Ch4xmPXV7EaEVDxa/WZ7JQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BFWMNqnCyVDFNrVIM+D2JPyDG0NRyEcur/1tl1Aq+5i5HyHwo/+49T0mVZUEWpZSh
         Hgvxf9fEhJkS+pRQhaL7ydh5sK4aWpLA4XWA88N0FOlZic6BXCCByIXpLXnxGTWD3Q
         3JfKfoAzL0QoCL+x4juSbZSojt+7AXt0nFnHG8qykF7JbOtylidB0lOEyTK5PxyZfL
         4B1iO5/wEng6y4Bo8mf5+PUU4AVqp+MBSPdVTAzzblz+/7vHJC5DvWgqC/NKNJKgfN
         Zaom3710JIH2HO2YRZtAEb56HRTQWhnTsyFtY+GeyDdpKMHsUjYscxDYoBGlZgRhgg
         Ww2fJ4isrSvvw==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v2 3/4] Revert "tracing: Add "(fault)" name injection to kernel probes"
Date:   Fri,  7 Jul 2023 22:41:12 +0900
Message-ID:  <168873727209.2687993.6806850187024303094.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
In-Reply-To:  <168873724526.2687993.15242662075324919195.stgit@mhiramat.roam.corp.google.com>
References:  <168873724526.2687993.15242662075324919195.stgit@mhiramat.roam.corp.google.com>
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
events still show just '(fault)' (instead of '"(fault)"').
Also, current '(fault)' is more explicit that it faulted.

Link: https://lore.kernel.org/all/20230706230642.3793a593@rorschach.local.home/

Cc: stable@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_events_synth.c |    2 +-
 kernel/trace/trace_probe_kernel.h |   31 ++++++-------------------------
 2 files changed, 7 insertions(+), 26 deletions(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index d6a70aff2410..23416ec8e1da 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -478,7 +478,7 @@ static unsigned int trace_string(struct synth_trace_event *entry,
 			ret = strncpy_from_kernel_nofault(str_field, str_val, STR_VAR_LEN_MAX);
 
 		if (ret < 0)
-			strcpy(str_field, FAULT_STRING);
+			strcpy(str_field, "(fault)");
 
 		(*n_u64) += STR_VAR_LEN_MAX / sizeof(u64);
 	}
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


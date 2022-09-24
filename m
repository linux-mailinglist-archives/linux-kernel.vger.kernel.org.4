Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6755E86CF
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 02:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiIXAma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 20:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbiIXAm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 20:42:26 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D1F115BCC;
        Fri, 23 Sep 2022 17:42:26 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d82so1569022pfd.10;
        Fri, 23 Sep 2022 17:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=+v3yE0wWE49NqNIeqeicpRAPLJhDqR/nFIdPn+1DxBU=;
        b=SsdwqMSJRsG+1G0OIsHufweHBGomqI88q+Ar5ZR8JIuzYBvUn4gfgi4ignCpfNiUbq
         Ay6yB86z+z0g+8r1fFTIcmpW3wm3WAJU4d0xkUC6ED69IoRzA0vYhMmHoaS2UuHQK0FB
         eei/dp17iGSopw2RYfTdAemRHr0VTe3UPg/GadnDejXfYzYWVG1/Zw8RbpG35ZJIfhyb
         uoUBmemRclFgWpBCkQbCw24PhRCGMFVzLIhw5vufyj2dqRbYY3Z9462l3xt3s+HaFLGU
         A6HzRRl4tWDwYYdOk2Z5pXs2OR4SrTKmzzq9m3vB7BbtakEvKH83mOpTbsJfAqx/8NFB
         YIOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=+v3yE0wWE49NqNIeqeicpRAPLJhDqR/nFIdPn+1DxBU=;
        b=HLn18E1jNKoX/A3gO4Cw22OxFUkWOeYSiijREcR7FfByVk94rO2LRUqfyGhQMwiiFf
         EA19MLTDKUIpF8DND+TFcqBWFo1KtS9E5dQmo71tzJ+KCfg0POQpGlNT+j+qifSpsd/K
         pelf9+erLF/Z4pdtiLPYLooUJTonMeBPsrjHdsITq88J19XS9GV33aNigt8IyXCmjUh+
         z57J0LSZYJ9GYjCwe1eANf9lMuTeA5lC2t3tXeDYNKlD1WsU7V+XjYw8IAMQFkBWi0/N
         9NNcr4OYnYwnrn4OC/l/M2nYiwgqvilIZ8nwAZS7tFX4uv1hKyDCvtTQpudEoOirmsxT
         Y2EA==
X-Gm-Message-State: ACrzQf0eXBBBILLwLr5CtPqwZpv5kO0wHO88lBtwE6V45o0kXJ5jKHwj
        faTVKhjt6BXpVwrJMySfmCU=
X-Google-Smtp-Source: AMsMyM7by9Pti91NLmeVFFWJpmi5CuOnNfH4k7lDpaVv1+TtA3c5AiMGJQAhRJnclmclkzbtepYWcg==
X-Received: by 2002:a05:6a00:24d4:b0:544:abd7:c944 with SMTP id d20-20020a056a0024d400b00544abd7c944mr11971435pfv.44.1663980145566;
        Fri, 23 Sep 2022 17:42:25 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:9987:f0b9:ad5:1fe7])
        by smtp.gmail.com with ESMTPSA id j6-20020a170902da8600b00176acc23a73sm6639516plx.281.2022.09.23.17.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 17:42:25 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 2/3] perf lock: Add -q/--quiet option
Date:   Fri, 23 Sep 2022 17:42:20 -0700
Message-Id: <20220924004221.841024-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
In-Reply-To: <20220924004221.841024-1-namhyung@kernel.org>
References: <20220924004221.841024-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like perf report, this option is to suppress header and debug messages.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-lock.txt |  4 ++++
 tools/perf/builtin-lock.c              | 27 +++++++++++++++-----------
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
index b23e76200ac2..3b1e16563b79 100644
--- a/tools/perf/Documentation/perf-lock.txt
+++ b/tools/perf/Documentation/perf-lock.txt
@@ -40,6 +40,10 @@ COMMON OPTIONS
 --verbose::
         Be more verbose (show symbol address, etc).
 
+-q::
+--quiet::
+	Do not show any message. (Suppress -v)
+
 -D::
 --dump-raw-trace::
         Dump raw trace in ASCII.
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 1c0d52384d9e..9722d4ab2e55 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1250,7 +1250,7 @@ static void print_bad_events(int bad, int total)
 	for (i = 0; i < BROKEN_MAX; i++)
 		broken += bad_hist[i];
 
-	if (broken == 0 && !verbose)
+	if (quiet || (broken == 0 && !verbose))
 		return;
 
 	pr_info("\n=== output for debug===\n\n");
@@ -1269,10 +1269,12 @@ static void print_result(void)
 	char cut_name[20];
 	int bad, total, printed;
 
-	pr_info("%20s ", "Name");
-	list_for_each_entry(key, &lock_keys, list)
-		pr_info("%*s ", key->len, key->header);
-	pr_info("\n\n");
+	if (!quiet) {
+		pr_info("%20s ", "Name");
+		list_for_each_entry(key, &lock_keys, list)
+			pr_info("%*s ", key->len, key->header);
+		pr_info("\n\n");
+	}
 
 	bad = total = printed = 0;
 	while ((st = pop_from_result())) {
@@ -1482,13 +1484,15 @@ static void print_contention_result(struct lock_contention *con)
 	struct lock_key *key;
 	int bad, total, printed;
 
-	list_for_each_entry(key, &lock_keys, list)
-		pr_info("%*s ", key->len, key->header);
+	if (!quiet) {
+		list_for_each_entry(key, &lock_keys, list)
+			pr_info("%*s ", key->len, key->header);
 
-	if (show_thread_stats)
-		pr_info("  %10s   %s\n\n", "pid", "comm");
-	else
-		pr_info("  %10s   %s\n\n", "type", "caller");
+		if (show_thread_stats)
+			pr_info("  %10s   %s\n\n", "pid", "comm");
+		else
+			pr_info("  %10s   %s\n\n", "type", "caller");
+	}
 
 	bad = total = printed = 0;
 	if (use_bpf)
@@ -1865,6 +1869,7 @@ int cmd_lock(int argc, const char **argv)
 		   "file", "vmlinux pathname"),
 	OPT_STRING(0, "kallsyms", &symbol_conf.kallsyms_name,
 		   "file", "kallsyms pathname"),
+	OPT_BOOLEAN('q', "quiet", &quiet, "Do not show any message"),
 	OPT_END()
 	};
 
-- 
2.37.3.998.g577e59143f-goog


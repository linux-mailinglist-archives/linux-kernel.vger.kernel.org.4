Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C346C0960
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 04:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjCTDjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 23:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjCTDjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 23:39:06 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EE42203E
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 20:39:00 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e129-20020a251e87000000b00b56598237f5so11781649ybe.16
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 20:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679283539;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rHDC7UBXOWCAEPbdLzihWokj+UpLxvZZidURX978WmE=;
        b=DD409jiJybjs9fQX7q7fqtCmw5nuGC5eXy8D6ZSD5O4pmYcN72p7hTEODVgBYZEhih
         BQ8Zkql4EPpaB/c9OmfzRn1pSmg46M89b8K41d3wbmu47kPetePp5bOjXNfKJ0uMuEVZ
         RbR5wRXgwvyBsjPdXzI2qrEcdwA1LaGDzHzRu7x6Q9/UMO88nh71PpsoMZsuOtW5tz/m
         BfsDjqHvt6vwK4UyqTSn7GTf9BTLFViOVkKIfsuWxt75dvaC4f8JP84RfzUVfiA3I1Nu
         hCJB5Fwv5gfaeAYFx+rQPgC1/9V5eGmTaMDpqoo0mAIcyEDjLbgzy7q1+Ej9yM6pdkT9
         6xnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679283539;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rHDC7UBXOWCAEPbdLzihWokj+UpLxvZZidURX978WmE=;
        b=0X9S5r8cmuxxN0XZXSobmxAUJmdMEFDI4jwy0evQ5NJn/yw1hCXgnjk/6GwBlV1Flf
         I3IxrD0bWHz00SOrWaGuKv91WgpgzfiqD6TPHOBavOQgjTPkM2LlDCMdbrulhCXP9zwu
         PB5e1aYuwvO6ZFZ5WBev90PuZpTvAl1YAMP3taEdX1CmHOJsrPDrTW3TY3wC/yYttVnR
         TP3xijq2a686fWZrPSdcY6FT3CDyizlqqGrjAWFwSkr8i0aaZD3gmJKfvWQHOopyUgSd
         gImyVUGQn9tanofbJn9fdf4Ad5VYHVfMt9j7nzwm0htC6Z+/HlfyG+XAL0+HT4P1qj8z
         dSxA==
X-Gm-Message-State: AO0yUKV488bsxUlG7eRqPnvpkDAsZ8g/hlqZHiru/HH49GG6g3J9Vs1V
        SZa5JzMrg0PQu2umANn+4/c/xoExPNET
X-Google-Smtp-Source: AK7set84I3Q5yq7Mc89TIl7TiUOtm8jwsNnxNmJCd6t1yy+aYw75XLnXCrbdgrXYoaHB+1L/4SUHw0NpECCk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:1895:9fa0:27f5:cb71])
 (user=irogers job=sendgmr) by 2002:a05:6902:150e:b0:b43:8424:2a4c with SMTP
 id q14-20020a056902150e00b00b4384242a4cmr4773681ybu.10.1679283539572; Sun, 19
 Mar 2023 20:38:59 -0700 (PDT)
Date:   Sun, 19 Mar 2023 20:37:51 -0700
In-Reply-To: <20230320033810.980165-1-irogers@google.com>
Message-Id: <20230320033810.980165-4-irogers@google.com>
Mime-Version: 1.0
References: <20230320033810.980165-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v4 03/22] perf tests: Add common error route for code-reading
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@collabora.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, Hao Luo <haoluo@google.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A later change will enforce that the map is put on this path
regardless of success or error.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/code-reading.c | 39 +++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index cb8cd09938d5..fb67fd5ebd9f 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -236,18 +236,19 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 	const char *objdump_name;
 	char decomp_name[KMOD_DECOMP_LEN];
 	bool decomp = false;
-	int ret;
+	int ret, err = 0;
 
 	pr_debug("Reading object code for memory address: %#"PRIx64"\n", addr);
 
 	if (!thread__find_map(thread, cpumode, addr, &al) || !al.map->dso) {
 		if (cpumode == PERF_RECORD_MISC_HYPERVISOR) {
 			pr_debug("Hypervisor address can not be resolved - skipping\n");
-			return 0;
+			goto out;
 		}
 
 		pr_debug("thread__find_map failed\n");
-		return -1;
+		err = -1;
+		goto out;
 	}
 
 	pr_debug("File is: %s\n", al.map->dso->long_name);
@@ -255,7 +256,7 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 	if (al.map->dso->symtab_type == DSO_BINARY_TYPE__KALLSYMS &&
 	    !dso__is_kcore(al.map->dso)) {
 		pr_debug("Unexpected kernel address - skipping\n");
-		return 0;
+		goto out;
 	}
 
 	pr_debug("On file address is: %#"PRIx64"\n", al.addr);
@@ -272,15 +273,18 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 					al.addr, buf1, len);
 	if (ret_len != len) {
 		pr_debug("dso__data_read_offset failed\n");
-		return -1;
+		err = -1;
+		goto out;
 	}
 
 	/*
 	 * Converting addresses for use by objdump requires more information.
 	 * map__load() does that.  See map__rip_2objdump() for details.
 	 */
-	if (map__load(al.map))
-		return -1;
+	if (map__load(al.map)) {
+		err = -1;
+		goto out;
+	}
 
 	/* objdump struggles with kcore - try each map only once */
 	if (dso__is_kcore(al.map->dso)) {
@@ -290,12 +294,12 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 			if (state->done[d] == al.map->start) {
 				pr_debug("kcore map tested already");
 				pr_debug(" - skipping\n");
-				return 0;
+				goto out;
 			}
 		}
 		if (state->done_cnt >= ARRAY_SIZE(state->done)) {
 			pr_debug("Too many kcore maps - skipping\n");
-			return 0;
+			goto out;
 		}
 		state->done[state->done_cnt++] = al.map->start;
 	}
@@ -306,7 +310,8 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 						 decomp_name,
 						 sizeof(decomp_name)) < 0) {
 			pr_debug("decompression failed\n");
-			return -1;
+			err = -1;
+			goto out;
 		}
 
 		decomp = true;
@@ -337,15 +342,16 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 				 */
 				pr_debug("objdump failed for kcore");
 				pr_debug(" - skipping\n");
-				return 0;
 			} else {
-				return -1;
+				err = -1;
 			}
+			goto out;
 		}
 	}
 	if (ret < 0) {
 		pr_debug("read_via_objdump failed\n");
-		return -1;
+		err = -1;
+		goto out;
 	}
 
 	/* The results should be identical */
@@ -355,11 +361,12 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 		dump_buf(buf1, len);
 		pr_debug("buf2 (objdump):\n");
 		dump_buf(buf2, len);
-		return -1;
+		err = -1;
+		goto out;
 	}
 	pr_debug("Bytes read match those read by objdump\n");
-
-	return 0;
+out:
+	return err;
 }
 
 static int process_sample_event(struct machine *machine,
-- 
2.40.0.rc1.284.g88254d51c5-goog


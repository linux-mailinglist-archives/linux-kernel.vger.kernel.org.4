Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5194372EBC5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 21:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjFMTQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbjFMTQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:16:49 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBAE10F7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:16:48 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-56fffdea2d0so1671897b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686683807; x=1689275807;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5I02Mxr8dEB2Fb/343TSS1xBJ+pa6R95MYlZ68AlcGA=;
        b=6iM1g2V9GAkT4U8h/tzhArE5k9Yifetlf+FlODL6ab+YQJCBWSX9I/F/nlM2c5033p
         6cU/fw6PIWGvlyuc+m2QsTNLsiQtkceOpqkTmJMPqXfAldJV7TVoL1bw+QJAQeOObKqp
         O6hS0tHGW1fVuBsqTzQjveswh3FMPoq10dV8O7x7Wh6wYxGWATcoLbynK0livHk8TOhj
         n5Wi3Mr2dnzAsWgc60yUuQTf6btWXAhWeNocjbyaBT/wnLcf14zjfaa2iCOBpF0gdGUe
         1W5VhdxWNNgEni6zGzEnQACYIz65hAoD5u1rxUQG6rI+ETsH2/MgyezAq65623WtdDVr
         SMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686683807; x=1689275807;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5I02Mxr8dEB2Fb/343TSS1xBJ+pa6R95MYlZ68AlcGA=;
        b=i+VRijpuLp06sfM8co20AExkM167gGheB22XMG27ue21Y+/sPy/HRmlrxEbs/6/J/u
         //pi1JSjLr7Y2KAlJJuc/hut87Fv9d4FvBepfIWV66eXF6jopwDQ+kviI74nmR2mU74R
         jMRr+KHHkMsujQ23zd07SRFr8aA5L68sb/X+Bh55aZHdFrPwQma4Nb/epORHqQBBMprX
         olYO3c9P1dOBxGJJC3PAXGd5jVShVag7fXLpLlXZWdQkOq/xhBC19/Eeths6Ym/t8iDT
         CDDeoOI6MMKipLsogmP9HETxOCziHXcTSxX4Fp06GD9dFEb8yI/2mwifD7oV69ULysMh
         Q/TQ==
X-Gm-Message-State: AC+VfDzIU6ySTshNnXThach3JNCOQ72iF4/HZf1EK+bXRu//6Tvsxagb
        AYyOSEJn7+iFEiWSOGQp1qJPIUfL6Isl
X-Google-Smtp-Source: ACHHUZ7X6K8DA/1fzwdBW/Rnk8QVBeGKLKagCC3TlSFf4YVjLObHwYf6u2SdQactQSWQ33qRDRQpFO/kXBHm
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a704:56d6:f79d:33e7])
 (user=irogers job=sendgmr) by 2002:a81:c905:0:b0:56f:f65f:53e5 with SMTP id
 o5-20020a81c905000000b0056ff65f53e5mr612110ywi.4.1686683807408; Tue, 13 Jun
 2023 12:16:47 -0700 (PDT)
Date:   Tue, 13 Jun 2023 12:16:38 -0700
Message-Id: <20230613191639.1547925-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [RFC PATCH] perf util: asprintf helper for leak sanitizer
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

asprintf is a source of memory leaks but produces bad stack traces on
my Debian linux. This patch adds a simple asprintf implementation to
util.c that works around it.

Before output:
```
==1541752==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 10 byte(s) in 1 object(s) allocated from:
    #0 0x7f90c76b89cf in __interceptor_malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x7f90c649d2c7 in __vasprintf_internal libio/vasprintf.c:71
    #2 0x55ad9b79afbf  (/tmp/perf/perf+0x850fbf)

SUMMARY: AddressSanitizer: 10 byte(s) leaked in 1 allocation(s).
```

After output:
```
==1545918==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 10 byte(s) in 1 object(s) allocated from:
    #0 0x7f2755a7077b in __interceptor_strdup ../../../../src/libsanitizer/asan/asan_interceptors.cpp:439
    #1 0x564986a8df31 in asprintf util/util.c:566
    #2 0x5649869b5901 in metricgroup__lookup_default_metricgroup util/metricgroup.c:1520
    #3 0x5649869b5e57 in metricgroup__lookup_create util/metricgroup.c:1579
    #4 0x5649869b6ddc in parse_groups util/metricgroup.c:1698
    #5 0x5649869b7714 in metricgroup__parse_groups util/metricgroup.c:1771
    #6 0x5649867da9d5 in add_default_attributes tools/perf/builtin-stat.c:2164
    #7 0x5649867ddbfb in cmd_stat tools/perf/builtin-stat.c:2707
    #8 0x5649868fa5a2 in run_builtin tools/perf/perf.c:323
    #9 0x5649868fab13 in handle_internal_command tools/perf/perf.c:377
    #10 0x5649868faedb in run_argv tools/perf/perf.c:421
    #11 0x5649868fb443 in main tools/perf/perf.c:537
    #12 0x7f2754846189 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58

SUMMARY: AddressSanitizer: 10 byte(s) leaked in 1 allocation(s).
```

RFC: is this useful for others? Should we have a build flag for it?
---
 tools/perf/util/util.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index c1fd9ba6d697..57eb528c5fed 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -552,3 +552,22 @@ int sched_getcpu(void)
 	return -1;
 }
 #endif
+
+int asprintf(char **restrict strp, const char *restrict fmt, ...)
+{
+	char buf[1024];
+	va_list ap;
+	int size;
+	char *result;
+
+	va_start(ap, fmt);
+	size = vsnprintf(buf, sizeof(buf), fmt, ap);
+	if (size < (int)sizeof(buf))
+		result = strdup(buf);
+	else
+		size = vasprintf(&result, fmt, ap);
+
+	*strp = result;
+	va_end(ap);
+	return size;
+}
-- 
2.41.0.162.gfafddb0af9-goog


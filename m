Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E78774E21B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 01:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjGJXN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 19:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjGJXNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 19:13:49 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7ABB9E;
        Mon, 10 Jul 2023 16:13:48 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-262e66481c4so2395506a91.1;
        Mon, 10 Jul 2023 16:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689030828; x=1691622828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nkq4D9xPcGffxrWboWnEtYoPxH3qm7wLImoo2iq2oVo=;
        b=TcEJFTldAGYmOwZJM0VtK1sxEAYhc3DH8xF2LIP8d9rXlrXRItrQmp50lOQScm730o
         J/8WpLWSb+2UkZ8twUnXZwm+eTBe2Rgux6GSI94a87sK9zYCsIRVGaSAVloCh5URJ+pC
         2//YV+SyLfo6m+kznHuAJNvfJhxjggbGwtxeKpkKJSLe4XYr/hLs9TWAXnWqWmlD1cRl
         yk9/5BR6ipwSd1EzLMWtYzF9QCuCPlyVBdpEbAQSZqwI78KTVz70qKa5890aGwG3OaeR
         ORLY0ktlwb1URqza7X9n/v5h05rMIlzWx4UKOdJH4kqmD4yalUELBGhZOU8UWSIeijv/
         AVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689030828; x=1691622828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nkq4D9xPcGffxrWboWnEtYoPxH3qm7wLImoo2iq2oVo=;
        b=l0ywbY9RD1xDuQEfoncAuQD9wiGDROoaH8I2+YS/wfkASXify066+O0+g+xx1VbhZd
         1JYjlArCc7iubvazajHlB7rRxIRQeHm42+VVqTGf4SoFYK2axqDi0qtvqCf5UViXlg6R
         ij0PfxctLmObOnUmJn4V+WCXytUzv8m/DjQXn0Irm8yctKWgLwSBx17zYK92jgENZYyp
         ymCTe85DeOe9Cv7031t7nRFRdJJ5JOjMX3ZWdGj29gnev9nOQ5mk3hoTj6qbPeL37/Aq
         ekyenX3SlhvPHvmcufsDaTIOhShaMHFngcy142w5NoHb1wbVPYIaWaxb6qqFijgiXAFm
         nyng==
X-Gm-Message-State: ABy/qLb3qu6Q/yDU0QFj0IkXUDoD7FmaOtned4Vl749SwduFKBustOd2
        aR9sYN36tKuUjdqA1GkoVF8=
X-Google-Smtp-Source: APBJJlHzh9FTPyE9kL1HOB2Il09oaQYGfAGYRwKgGdi4LYSXdL7Bhv9GN5zmlgWT6HYc09cDj8Vyfw==
X-Received: by 2002:a17:90a:d916:b0:261:631:95c2 with SMTP id c22-20020a17090ad91600b00261063195c2mr10054850pjv.27.1689030828296;
        Mon, 10 Jul 2023 16:13:48 -0700 (PDT)
Received: from yoga ([2400:1f00:13:76f2:868d:bc7d:562b:a5bb])
        by smtp.gmail.com with ESMTPSA id 30-20020a17090a191e00b002640b7073cfsm7300485pjg.14.2023.07.10.16.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 16:13:48 -0700 (PDT)
Date:   Tue, 11 Jul 2023 04:43:40 +0530
From:   Anup Sharma <anupnewsmail@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Anup Sharma <anupnewsmail@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/6] scripts: python: Add trace end processing and JSON
 output
Message-ID: <11543b39f97a7e2f9eac76c1233f1b1caa3f2c48.1689024635.git.anupnewsmail@gmail.com>
References: <cover.1689024635.git.anupnewsmail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689024635.git.anupnewsmail@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inside the trace end function the final output will be dumped
to standard output in JSON gecko format. Additionally, constants
such as USER_CATEGORY_INDEX, KERNEL_CATEGORY_INDEX, CATEGORIES, and
PRODUCT are defined to provide contextual information.

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
---
 .../scripts/python/firefox-gecko-converter.py | 34 ++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools/perf/scripts/python/firefox-gecko-converter.py
index 0b8a86bdcab1..39818a603265 100644
--- a/tools/perf/scripts/python/firefox-gecko-converter.py
+++ b/tools/perf/scripts/python/firefox-gecko-converter.py
@@ -24,8 +24,40 @@ from Core import *
 thread_map = {}
 start_time = None
 
+# Follow Brendan Gregg's Flamegraph convention: orange for kernel and yellow for user
+CATEGORIES = [
+    {'name': 'User', 'color': 'yellow', 'subcategories': ['Other']},
+    {'name': 'Kernel', 'color': 'orange', 'subcategories': ['Other']}
+]
+
+# The product name is used by the profiler UI to show the Operating system and Processor.
+PRODUCT = os.popen('uname -op').read().strip()
+
 def trace_end():
-	pass
+    thread_array = thread_map.values()))
+
+    result = {
+        'meta': {
+            'interval': 1,
+            'processType': 0,
+            'product': PRODUCT,
+            'stackwalk': 1,
+            'debug': 0,
+            'gcpoison': 0,
+            'asyncstack': 1,
+            'startTime': start_time,
+            'shutdownTime': None,
+            'version': 24,
+            'presymbolicated': True,
+            'categories': CATEGORIES,
+            'markerSchema': []
+            },
+        'libs': [],
+        'threads': thread_array,
+        'processes': [],
+        'pausedRanges': []
+    }
+    json.dump(result, sys.stdout, indent=2)
 
 def process_event(param_dict):
 	global start_time
-- 
2.34.1


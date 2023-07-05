Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2344F748E3F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 21:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbjGETuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 15:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233637AbjGETuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:50:03 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC119172B;
        Wed,  5 Jul 2023 12:50:02 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-53fa455cd94so3383720a12.2;
        Wed, 05 Jul 2023 12:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688586602; x=1691178602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8tyoCCM37OnwHyJMTXYnRXAELsPqSydQwA/qPcmdHVo=;
        b=FVviDHXA0yGiBRWeFvNZ6ueAyefkaEwuzhg5cADlfy3G2sIIFHnJrjmzsiHQS2lyYT
         0KqXT8Vb+xu6y95CHbTY6nKr3FsYAuzrPYr4BmCWwbmwNFE7NzI3F4WNNSazySAVmHv3
         7HeFEDq5zqiiL8RqNI0CtepU3kCaQ9km/DMbVvgANAiVfs1GlvapnjwAXFmzqxvx/E2V
         HgudjYIwo4P/VQHRCs+UwEws4eRKtGEONVO7liz8qMbzXuhs1PzmKH/eVrHl66Iddefx
         EvbZI0137mSGCzUk2YQ+CZdgts2QMzDPaHcZbwEbycqelsikp7tHrKkiKNNPrBULyA/4
         H/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688586602; x=1691178602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8tyoCCM37OnwHyJMTXYnRXAELsPqSydQwA/qPcmdHVo=;
        b=M4XIA8ywtR1qT6+FuNZaMnlgj0kVOPFim4/C7h8XsciTFxLIojRpzF+G8v9labAXwb
         h/GO0n6dXgd4vDwrsYu0OaHC68jBQP40TMy1lWF3QRzzQ8W2H0S1glNRLm4kIJ8DOe7Z
         6Zw1ktwh0zjsifRpo8Emm4HK9PAGP1ZtmtIa8iEjguu6POcFmkQEGyc5JhjVqF6/u7ec
         w7usTA3k6dmiaJLzAIlNiIGsBUvHvCM4gtP7qEKllzmAOfDCe+PwOMepK/taqMHYVYPs
         OpqVlVmnts9dboiAShBF9YuXsrq9y8of9MKXTkSDj0vaSuM+H2+mEts+g39XmxDv7m2T
         eKsg==
X-Gm-Message-State: ABy/qLbJW9Zi2AFJ/owGwoZ9mK4OVYQbS+ixJGKVbODWa5t0/OdVvfxL
        q93fjDkdYf4AoXV438T27d8=
X-Google-Smtp-Source: APBJJlHeLo3E50/tqH2jihcjnkuXjQBe9KohXjXTPE+lSDxOcA1T+QQDhm5ScmIESeySqsUaB2K7Aw==
X-Received: by 2002:a05:6a20:2583:b0:12e:4496:c063 with SMTP id k3-20020a056a20258300b0012e4496c063mr11786012pzd.2.1688586602055;
        Wed, 05 Jul 2023 12:50:02 -0700 (PDT)
Received: from yoga ([2400:1f00:13:c628:31be:68ae:86f5:48b9])
        by smtp.gmail.com with ESMTPSA id u15-20020a17090341cf00b001b8a85489a3sm3275110ple.262.2023.07.05.12.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 12:50:01 -0700 (PDT)
Date:   Thu, 6 Jul 2023 01:19:54 +0530
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
Subject: [PATCH v2 7/7] scripts: python: Add trace end processing and JSON
 output
Message-ID: <d225862cdbc84cf5aba365f29886cb39b041cabc.1688585597.git.anupnewsmail@gmail.com>
References: <cover.1688585597.git.anupnewsmail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1688585597.git.anupnewsmail@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inside the trace end function the final output will be dumped
to standard output in JSON gecko format. Additionally, constants
such as USER_CATEGORY_INDEX, KERNEL_CATEGORY_INDEX, CATEGORIES, and
PRODUCT are defined to provide contextual information.
Also added _addThreadSample call which was missing.

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
---
 .../scripts/python/firefox-gecko-converter.py | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools/perf/scripts/python/firefox-gecko-converter.py
index 910e598c743f..6a2a4d816799 100644
--- a/tools/perf/scripts/python/firefox-gecko-converter.py
+++ b/tools/perf/scripts/python/firefox-gecko-converter.py
@@ -18,9 +18,47 @@ sys.path.append(os.environ['PERF_EXEC_PATH'] + \
 from perf_trace_context import *
 from Core import *
 
+USER_CATEGORY_INDEX = 0
+KERNEL_CATEGORY_INDEX = 1
 thread_map = {}
 start_time = None
 
+CATEGORIES = [
+    {'name': 'User', 'color': 'yellow', 'subcategories': ['Other']},
+    {'name': 'Kernel', 'color': 'orange', 'subcategories': ['Other']}
+]
+
+PRODUCT = os.popen('uname -op').read().strip()
+
+def trace_end():
+    thread_array = list(map(lambda thread: thread['finish'](), thread_map.values()))
+    for thread in thread_array:
+        key = thread['samples']['schema']['time']
+        thread['samples']['data'].sort(key=lambda data : float(data[key]))
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
+
 def process_event(param_dict):
 	global start_time
 	global thread_map
@@ -159,6 +197,8 @@ def process_event(param_dict):
 			stack.append(call['sym']['name'] + f' (in {call["dso"]})')
 		if len(stack) != 0:
 			stack = stack[::-1]
+			_addThreadSample(pid, tid, thread_name, time_stamp, stack)
 	else:
 		mod = param_dict['symbol'] if 'symbol' in param_dict else '[unknown]'
 		dso = param_dict['dso'] if 'dso' in param_dict else '[unknown]'
+		_addThreadSample(pid, tid, thread_name, time_stamp, [mod + f' (in {dso})'])
-- 
2.34.1


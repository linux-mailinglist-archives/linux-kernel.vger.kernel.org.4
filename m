Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4EC6A0341
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 08:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbjBWHSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 02:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbjBWHSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 02:18:43 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1851E2E0CA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 23:18:42 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536c8bcae3bso102993977b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 23:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AEITOwn2BL7QlWmho9xFVXjSJaA3cXxb4gMVl1pbdN8=;
        b=ro2mkONciMYnRbe1HJWJGrp2vpzeGVrJPHTH0cuW97WIMIz6XoZWxyV/QwwFsnFrqU
         fO7gQem9BPzLBPMidesutaLNNrtgq2DYomHheyO3EvUSnHApt91FTIn91sl4xmtF5m3q
         2rQ6yYiGdkCwYNAE+NreDYCriRmN6pbdBTKAh8FW5eIu8qHZFX8sa8O4MkQcaHtucBYm
         rqQLL6wcJi+XbHOIzYUAGvJdUQ00WfqKutCtVMqBl7hTq0w1cnvtcx3jgadykLWsOhdL
         yOfcSlhKgtZgZzay4RUuIpP85dFV08UlOcwTEAO+kCoaLswIGsEVOXbwZoijmz7JnsHD
         naKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AEITOwn2BL7QlWmho9xFVXjSJaA3cXxb4gMVl1pbdN8=;
        b=RYT3eEvD1Bcx/FZ5n+MH2yUIfmOKpruCUBXBpLrVVj7G509dt+XsL4kkRBHNqufVRW
         q1O3Kl6wiKGU3WvyEnrIUKDDBeJvIcfSLVfEZOhPjHwyS3tT9Z4ZEPJB4wyDWSXpruIA
         k2f1mxs0TArIuiEkIdEeV5rGQA343Jmz5VjJYe47BuU+OJ9zpc2igq80tN9c14Swwdcw
         qfk/teozKH5oZkiU6ooB7OkHiL5NQOcCfmttekZVGPHd0QP9tHZdRk6KumIvLkDXMtvl
         79edf7g6OOc9Oz2oAokSaRk/41vA4pw+3tZmE3c6iajVlY3cQVpDsXnwN3ye8ygXl0RW
         2D+w==
X-Gm-Message-State: AO0yUKWOccPapnfRdrsF+zbJeOXqprm18SQsM97SbtqqDm6wGOGxbOJG
        S2B1EcJcLvE4up3uijG0RjO30C+cY9tM
X-Google-Smtp-Source: AK7set/OomecmZJRH6xelWBVPgDS7F59Tq1kX/SgFdZSmjh0NKYpROZdEyPKhLJ6m3ydc7C7HA3tDUJHDEEF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:9002:67cd:9e6b:7083])
 (user=irogers job=sendgmr) by 2002:a05:6902:1028:b0:a27:3ecd:6 with SMTP id
 x8-20020a056902102800b00a273ecd0006mr1126444ybt.1.1677136721353; Wed, 22 Feb
 2023 23:18:41 -0800 (PST)
Date:   Wed, 22 Feb 2023 23:18:18 -0800
In-Reply-To: <20230223071818.329671-1-irogers@google.com>
Message-Id: <20230223071818.329671-2-irogers@google.com>
Mime-Version: 1.0
References: <20230223071818.329671-1-irogers@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [PATCH v1 2/2] perf test: Avoid counting commas in json linter
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Claire Jensen <cjense@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

Commas may appear in events like:
cpu/INT_MISC.RECOVERY_CYCLES,cmask=1,edge/
which causes the count of commas to see more items than
expected. Switch to counting the entries in the dictionary, which is 1
more than the number of commas.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../tests/shell/lib/perf_json_output_lint.py  | 29 +++++++++----------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/perf/tests/shell/lib/perf_json_output_lint.py
index d90f8d102eb9..97598d14e532 100644
--- a/tools/perf/tests/shell/lib/perf_json_output_lint.py
+++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
@@ -40,19 +40,6 @@ def is_counter_value(num):
   return isfloat(num) or num == '<not counted>' or num == '<not supported>'
 
 def check_json_output(expected_items):
-  if expected_items != -1:
-    for line in Lines:
-      if 'failed' not in line:
-        count = 0
-        count = line.count(',')
-        if count != expected_items and count >= 1 and count <= 3 and 'metric-value' in line:
-          # Events that generate >1 metric may have isolated metric
-          # values and possibly other prefixes like interval, core and
-          # aggregate-number.
-          continue
-        if count != expected_items:
-          raise RuntimeError(f'wrong number of fields. counted {count} expected {expected_items}'
-                             f' in \'{line}\'')
   checks = {
       'aggregate-number': lambda x: isfloat(x),
       'core': lambda x: True,
@@ -73,6 +60,16 @@ def check_json_output(expected_items):
   }
   input = '[\n' + ','.join(Lines) + '\n]'
   for item in json.loads(input):
+    if expected_items != -1:
+      count = len(item)
+      if count != expected_items and count >= 1 and count <= 4 and 'metric-value' in item:
+        # Events that generate >1 metric may have isolated metric
+        # values and possibly other prefixes like interval, core and
+        # aggregate-number.
+        pass
+      elif count != expected_items:
+        raise RuntimeError(f'wrong number of fields. counted {count} expected {expected_items}'
+                           f' in \'{item}\'')
     for key, value in item.items():
       if key not in checks:
         raise RuntimeError(f'Unexpected key: key={key} value={value}')
@@ -82,11 +79,11 @@ def check_json_output(expected_items):
 
 try:
   if args.no_args or args.system_wide or args.event:
-    expected_items = 6
-  elif args.interval or args.per_thread or args.system_wide_no_aggr:
     expected_items = 7
-  elif args.per_core or args.per_socket or args.per_node or args.per_die:
+  elif args.interval or args.per_thread or args.system_wide_no_aggr:
     expected_items = 8
+  elif args.per_core or args.per_socket or args.per_node or args.per_die:
+    expected_items = 9
   else:
     # If no option is specified, don't check the number of items.
     expected_items = -1
-- 
2.39.2.637.g21b0678d19-goog


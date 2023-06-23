Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D2373ADD2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 02:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjFWAdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 20:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjFWAdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 20:33:45 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8152105
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 17:33:42 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-573d70da2afso10440717b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 17:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687480422; x=1690072422;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hhUg6THmJuFZLCBhVQKBQ1G3lLVIgP2+QL9ajb1oVfg=;
        b=k3LCLn/+kUr/ufttzlkARrHkWSYCCgeTY5Q3rgoI/4g3L+JThSuVNw88TzXpttbj+l
         sa3AjymwWUHQ+r/FA+QBm9oGt/rCs1itvI32kizQ2S5gqe9b5o5kO55dsLWwcZHU7PAL
         H5ltXALURZLfFwAa7jm6wrcaEhdcu1ZuOj2NyQtLyyZbncUfeyAWVoLXqYLeOVlimYLT
         ZkJu/jQRvXtdQ1iwKW5j6nzjTJK15R05XA+9V1LLejMxkGFfe5m2iK92RlpnClRLtwid
         GNqNFZ3kop4hbm5vb1io3mMzq+Oshc5KubBqz6ZinM1NYk1HEhvSp/ecNPSDHg3HS0qZ
         5b/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687480422; x=1690072422;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hhUg6THmJuFZLCBhVQKBQ1G3lLVIgP2+QL9ajb1oVfg=;
        b=XWhcZQmEf9Nht/rS2L9UgWtMv7HRkY0e72TMZBsWYrTizCPVmSPjOOrjd2xqKkWKzF
         9EgV9AnKnZ+CcPRunh63VgsJlCvqJG++mTwtDzgph14CFn0QuMF8dWS/MIhj+q8bvpG3
         aINVjDk+NCFdvMfXVJHAMOFm4aOade8SXvjrTLp8jeLvJ08GrOw3vkS19dJ48byslWPB
         y3IWzTUOzbNkC/1QEnAwPH+R3hZS3acL7IrJffXcH7i1SF87KRymPCYG2Z08QpM3Fo4o
         NkaFpaRAKCyu0Zy8wiVGFAX8+Hdf0zZL0GsqpnLGV6YbOG7ySFOXrN4+eEvhB7n/MH6S
         Mrsg==
X-Gm-Message-State: AC+VfDzlxC/Ayc213JNs47YZfmMJ0brPLSLNcLfbp9WToWur6147rJCc
        9bkCiTujNAY9aSzzz77z4ER85rQMk+8V
X-Google-Smtp-Source: ACHHUZ6uJb46O9f34KF58iFEzOSuzO05TB19ys9fiE8YI0cbFUQYoV3M0i7ChEpkCxKYBXpp93a8ZkKb3U/Y
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6559:8968:cdfe:35b6])
 (user=irogers job=sendgmr) by 2002:a25:69d2:0:b0:bab:a276:caac with SMTP id
 e201-20020a2569d2000000b00baba276caacmr8512729ybc.3.1687480422105; Thu, 22
 Jun 2023 17:33:42 -0700 (PDT)
Date:   Thu, 22 Jun 2023 17:33:03 -0700
In-Reply-To: <20230623003312.3981075-1-irogers@google.com>
Message-Id: <20230623003312.3981075-4-irogers@google.com>
Mime-Version: 1.0
References: <20230623003312.3981075-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v1 03/12] perf vendor metrics intel: Make transaction metrics conditional
From:   Ian Rogers <irogers@google.com>
To:     eter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Sohom Datta <sohomdatta1@gmail.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>
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

Make the transaction metrics conditional on the cycles-tx event being
present. This event may not be present when TSX extensions have been
disabled.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json | 8 ++++----
 .../pmu-events/arch/x86/cascadelakex/clx-metrics.json     | 8 ++++----
 tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json   | 8 ++++----
 tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json  | 8 ++++----
 .../pmu-events/arch/x86/sapphirerapids/spr-metrics.json   | 8 ++++----
 tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json   | 8 ++++----
 tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json  | 8 ++++----
 tools/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json | 8 ++++----
 8 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json b/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
index 85fb975b6f56..daf9458f0b77 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
@@ -92,28 +92,28 @@
     },
     {
         "BriefDescription": "Percentage of cycles in aborted transactions.",
-        "MetricExpr": "max(cpu@cycles\\-t@ - cpu@cycles\\-ct@, 0) / cycles",
+        "MetricExpr": "(max(cycles\\-t - cycles\\-ct, 0) / cycles if has_event(cycles\\-t) else 0)",
         "MetricGroup": "transaction",
         "MetricName": "tsx_aborted_cycles",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Number of cycles within a transaction divided by the number of elisions.",
-        "MetricExpr": "cpu@cycles\\-t@ / cpu@el\\-start@",
+        "MetricExpr": "(cycles\\-t / el\\-start if has_event(cycles\\-t) else 0)",
         "MetricGroup": "transaction",
         "MetricName": "tsx_cycles_per_elision",
         "ScaleUnit": "1cycles / elision"
     },
     {
         "BriefDescription": "Number of cycles within a transaction divided by the number of transactions.",
-        "MetricExpr": "cpu@cycles\\-t@ / cpu@tx\\-start@",
+        "MetricExpr": "(cycles\\-t / tx\\-start if has_event(cycles\\-t) else 0)",
         "MetricGroup": "transaction",
         "MetricName": "tsx_cycles_per_transaction",
         "ScaleUnit": "1cycles / transaction"
     },
     {
         "BriefDescription": "Percentage of cycles within a transaction region.",
-        "MetricExpr": "cpu@cycles\\-t@ / cycles",
+        "MetricExpr": "(cycles\\-t / cycles if has_event(cycles\\-t) else 0)",
         "MetricGroup": "transaction",
         "MetricName": "tsx_transactional_cycles",
         "ScaleUnit": "100%"
diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
index 0e2e446ced7a..fbb111e40829 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
@@ -1830,28 +1830,28 @@
     },
     {
         "BriefDescription": "Percentage of cycles in aborted transactions.",
-        "MetricExpr": "max(cpu@cycles\\-t@ - cpu@cycles\\-ct@, 0) / cycles",
+        "MetricExpr": "(max(cycles\\-t - cycles\\-ct, 0) / cycles if has_event(cycles\\-t) else 0)",
         "MetricGroup": "transaction",
         "MetricName": "tsx_aborted_cycles",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Number of cycles within a transaction divided by the number of elisions.",
-        "MetricExpr": "cpu@cycles\\-t@ / cpu@el\\-start@",
+        "MetricExpr": "(cycles\\-t / el\\-start if has_event(cycles\\-t) else 0)",
         "MetricGroup": "transaction",
         "MetricName": "tsx_cycles_per_elision",
         "ScaleUnit": "1cycles / elision"
     },
     {
         "BriefDescription": "Number of cycles within a transaction divided by the number of transactions.",
-        "MetricExpr": "cpu@cycles\\-t@ / cpu@tx\\-start@",
+        "MetricExpr": "(cycles\\-t / tx\\-start if has_event(cycles\\-t) else 0)",
         "MetricGroup": "transaction",
         "MetricName": "tsx_cycles_per_transaction",
         "ScaleUnit": "1cycles / transaction"
     },
     {
         "BriefDescription": "Percentage of cycles within a transaction region.",
-        "MetricExpr": "cpu@cycles\\-t@ / cycles",
+        "MetricExpr": "(cycles\\-t / cycles if has_event(cycles\\-t) else 0)",
         "MetricGroup": "transaction",
         "MetricName": "tsx_transactional_cycles",
         "ScaleUnit": "100%"
diff --git a/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json b/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json
index cc4edf855064..8fcc05c4e0a1 100644
--- a/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json
@@ -1516,28 +1516,28 @@
     },
     {
         "BriefDescription": "Percentage of cycles in aborted transactions.",
-        "MetricExpr": "max(cpu@cycles\\-t@ - cpu@cycles\\-ct@, 0) / cycles",
+        "MetricExpr": "(max(cycles\\-t - cycles\\-ct, 0) / cycles if has_event(cycles\\-t) else 0)",
         "MetricGroup": "transaction",
         "MetricName": "tsx_aborted_cycles",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Number of cycles within a transaction divided by the number of elisions.",
-        "MetricExpr": "cpu@cycles\\-t@ / cpu@el\\-start@",
+        "MetricExpr": "(cycles\\-t / el\\-start if has_event(cycles\\-t) else 0)",
         "MetricGroup": "transaction",
         "MetricName": "tsx_cycles_per_elision",
         "ScaleUnit": "1cycles / elision"
     },
     {
         "BriefDescription": "Number of cycles within a transaction divided by the number of transactions.",
-        "MetricExpr": "cpu@cycles\\-t@ / cpu@tx\\-start@",
+        "MetricExpr": "(cycles\\-t / tx\\-start if has_event(cycles\\-t) else 0)",
         "MetricGroup": "transaction",
         "MetricName": "tsx_cycles_per_transaction",
         "ScaleUnit": "1cycles / transaction"
     },
     {
         "BriefDescription": "Percentage of cycles within a transaction region.",
-        "MetricExpr": "cpu@cycles\\-t@ / cycles",
+        "MetricExpr": "(cycles\\-t / cycles if has_event(cycles\\-t) else 0)",
         "MetricGroup": "transaction",
         "MetricName": "tsx_transactional_cycles",
         "ScaleUnit": "100%"
diff --git a/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json b/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
index 6f25b5b7aaf6..9bb7e3f20f7f 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
@@ -1812,28 +1812,28 @@
     },
     {
         "BriefDescription": "Percentage of cycles in aborted transactions.",
-        "MetricExpr": "max(cpu@cycles\\-t@ - cpu@cycles\\-ct@, 0) / cycles",
+        "MetricExpr": "(max(cycles\\-t - cycles\\-ct, 0) / cycles if has_event(cycles\\-t) else 0)",
         "MetricGroup": "transaction",
         "MetricName": "tsx_aborted_cycles",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Number of cycles within a transaction divided by the number of elisions.",
-        "MetricExpr": "cpu@cycles\\-t@ / cpu@el\\-start@",
+        "MetricExpr": "(cycles\\-t / el\\-start if has_event(cycles\\-t) else 0)",
         "MetricGroup": "transaction",
         "MetricName": "tsx_cycles_per_elision",
         "ScaleUnit": "1cycles / elision"
     },
     {
         "BriefDescription": "Number of cycles within a transaction divided by the number of transactions.",
-        "MetricExpr": "cpu@cycles\\-t@ / cpu@tx\\-start@",
+        "MetricExpr": "(cycles\\-t / tx\\-start if has_event(cycles\\-t) else 0)",
         "MetricGroup": "transaction",
         "MetricName": "tsx_cycles_per_transaction",
         "ScaleUnit": "1cycles / transaction"
     },
     {
         "BriefDescription": "Percentage of cycles within a transaction region.",
-        "MetricExpr": "cpu@cycles\\-t@ / cycles",
+        "MetricExpr": "(cycles\\-t / cycles if has_event(cycles\\-t) else 0)",
         "MetricGroup": "transaction",
         "MetricName": "tsx_transactional_cycles",
         "ScaleUnit": "100%"
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json b/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
index c732982f70b5..c207c851a9f9 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
@@ -1938,28 +1938,28 @@
     },
     {
         "BriefDescription": "Percentage of cycles in aborted transactions.",
-        "MetricExpr": "max(cpu@cycles\\-t@ - cpu@cycles\\-ct@, 0) / cycles",
+        "MetricExpr": "(max(cycles\\-t - cycles\\-ct, 0) / cycles if has_event(cycles\\-t) else 0)",
         "MetricGroup": "transaction",
         "MetricName": "tsx_aborted_cycles",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Number of cycles within a transaction divided by the number of elisions.",
-        "MetricExpr": "cpu@cycles\\-t@ / cpu@el\\-start@",
+        "MetricExpr": "(cycles\\-t / el\\-start if has_event(cycles\\-t) else 0)",
         "MetricGroup": "transaction",
         "MetricName": "tsx_cycles_per_elision",
         "ScaleUnit": "1cycles / elision"
     },
     {
         "BriefDescription": "Number of cycles within a transaction divided by the number of transactions.",
-        "MetricExpr": "cpu@cycles\\-t@ / cpu@tx\\-start@",
+        "MetricExpr": "(cycles\\-t / tx\\-start if has_event(cycles\\-t) else 0)",
         "MetricGroup": "transaction",
         "MetricName": "tsx_cycles_per_transaction",
         "ScaleUnit": "1cycles / transaction"
     },
     {
         "BriefDescription": "Percentage of cycles within a transaction region.",
-        "MetricExpr": "cpu@cycles\\-t@ / cycles",
+        "MetricExpr": "(cycles\\-t / cycles if has_event(cycles\\-t) else 0)",
         "MetricGroup": "transaction",
         "MetricName": "tsx_transactional_cycles",
         "ScaleUnit": "100%"
diff --git a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
index 2ed88842b880..94cb38540b5a 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
@@ -1466,28 +1466,28 @@
     },
     {
         "BriefDescription": "Percentage of cycles in aborted transactions.",
-        "MetricExpr": "max(cpu@cycles\\-t@ - cpu@cycles\\-ct@, 0) / cycles",
+        "MetricExpr": "(max(cycles\\-t - cycles\\-ct, 0) / cycles if has_event(cycles\\-t) else 0)",
         "MetricGroup": "transaction",
         "MetricName": "tsx_aborted_cycles",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Number of cycles within a transaction divided by the number of elisions.",
-        "MetricExpr": "cpu@cycles\\-t@ / cpu@el\\-start@",
+        "MetricExpr": "(cycles\\-t / el\\-start if has_event(cycles\\-t) else 0)",
         "MetricGroup": "transaction",
         "MetricName": "tsx_cycles_per_elision",
         "ScaleUnit": "1cycles / elision"
     },
     {
         "BriefDescription": "Number of cycles within a transaction divided by the number of transactions.",
-        "MetricExpr": "cpu@cycles\\-t@ / cpu@tx\\-start@",
+        "MetricExpr": "(cycles\\-t / tx\\-start if has_event(cycles\\-t) else 0)",
         "MetricGroup": "transaction",
         "MetricName": "tsx_cycles_per_transaction",
         "ScaleUnit": "1cycles / transaction"
     },
     {
         "BriefDescription": "Percentage of cycles within a transaction region.",
-        "MetricExpr": "cpu@cycles\\-t@ / cycles",
+        "MetricExpr": "(cycles\\-t / cycles if has_event(cycles\\-t) else 0)",
         "MetricGroup": "transaction",
         "MetricName": "tsx_transactional_cycles",
         "ScaleUnit": "100%"
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
index 507d39efacc8..fa4209809c57 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
@@ -1774,28 +1774,28 @@
     },
     {
         "BriefDescription": "Percentage of cycles in aborted transactions.",
-        "MetricExpr": "max(cpu@cycles\\-t@ - cpu@cycles\\-ct@, 0) / cycles",
+        "MetricExpr": "(max(cycles\\-t - cycles\\-ct, 0) / cycles if has_event(cycles\\-t) else 0)",
         "MetricGroup": "transaction",
         "MetricName": "tsx_aborted_cycles",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Number of cycles within a transaction divided by the number of elisions.",
-        "MetricExpr": "cpu@cycles\\-t@ / cpu@el\\-start@",
+        "MetricExpr": "(cycles\\-t / el\\-start if has_event(cycles\\-t) else 0)",
         "MetricGroup": "transaction",
         "MetricName": "tsx_cycles_per_elision",
         "ScaleUnit": "1cycles / elision"
     },
     {
         "BriefDescription": "Number of cycles within a transaction divided by the number of transactions.",
-        "MetricExpr": "cpu@cycles\\-t@ / cpu@tx\\-start@",
+        "MetricExpr": "(cycles\\-t / tx\\-start if has_event(cycles\\-t) else 0)",
         "MetricGroup": "transaction",
         "MetricName": "tsx_cycles_per_transaction",
         "ScaleUnit": "1cycles / transaction"
     },
     {
         "BriefDescription": "Percentage of cycles within a transaction region.",
-        "MetricExpr": "cpu@cycles\\-t@ / cycles",
+        "MetricExpr": "(cycles\\-t / cycles if has_event(cycles\\-t) else 0)",
         "MetricGroup": "transaction",
         "MetricName": "tsx_transactional_cycles",
         "ScaleUnit": "100%"
diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json b/tools/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json
index 83346911aa63..c7c2d6ab1a93 100644
--- a/tools/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json
@@ -1530,28 +1530,28 @@
     },
     {
         "BriefDescription": "Percentage of cycles in aborted transactions.",
-        "MetricExpr": "max(cpu@cycles\\-t@ - cpu@cycles\\-ct@, 0) / cycles",
+        "MetricExpr": "(max(cycles\\-t - cycles\\-ct, 0) / cycles if has_event(cycles\\-t) else 0)",
         "MetricGroup": "transaction",
         "MetricName": "tsx_aborted_cycles",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Number of cycles within a transaction divided by the number of elisions.",
-        "MetricExpr": "cpu@cycles\\-t@ / cpu@el\\-start@",
+        "MetricExpr": "(cycles\\-t / el\\-start if has_event(cycles\\-t) else 0)",
         "MetricGroup": "transaction",
         "MetricName": "tsx_cycles_per_elision",
         "ScaleUnit": "1cycles / elision"
     },
     {
         "BriefDescription": "Number of cycles within a transaction divided by the number of transactions.",
-        "MetricExpr": "cpu@cycles\\-t@ / cpu@tx\\-start@",
+        "MetricExpr": "(cycles\\-t / tx\\-start if has_event(cycles\\-t) else 0)",
         "MetricGroup": "transaction",
         "MetricName": "tsx_cycles_per_transaction",
         "ScaleUnit": "1cycles / transaction"
     },
     {
         "BriefDescription": "Percentage of cycles within a transaction region.",
-        "MetricExpr": "cpu@cycles\\-t@ / cycles",
+        "MetricExpr": "(cycles\\-t / cycles if has_event(cycles\\-t) else 0)",
         "MetricGroup": "transaction",
         "MetricName": "tsx_transactional_cycles",
         "ScaleUnit": "100%"
-- 
2.41.0.162.gfafddb0af9-goog


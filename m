Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C1B69BFD7
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 10:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjBSJr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 04:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjBSJrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 04:47:24 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC7112BC4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:46:52 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id f33-20020a25b0a1000000b009433a21be0dso2123448ybj.19
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8oK06fVQN6LXVRqRBpBf6uq7iBLthLemaenQUOot5L0=;
        b=c/IhxSXdMkvdWRTmNwDGCw1H+VDaY0b3orkL+EP+I6StfnTz8H8pSrT5peoX5iGhyL
         aZJVTGxQcotqY/9XbrXu5W8a7dwuTOKV2N61EKGNWX+G6n+kxuWgzbZDVX14qVNHNX+s
         fs5RmxJ4NrWIuhyym0Yg7NUOknjeXIWnd1ZkQeNcEc6sxObdx3t563ad/6YllU0XSRVH
         fEBlJh6xYkiCZVrIz2FJ28m1/wK+9QXfHWnY7uNt0V/Brg7V6nAD5888J6y3CRDbKjZN
         b08tJOGA3QuQgVGwsV5oJ+JxevsQJNE5g65XNpdn5E/qZEfMghvi8DBRe4DWYkzPbiRl
         Q1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8oK06fVQN6LXVRqRBpBf6uq7iBLthLemaenQUOot5L0=;
        b=wdWNjv6xteuc8VFUp/oGNOEQxldgKDUnVW3PvOzsFOr7+NrhnBfvxiXAyCslrEvfEt
         TSS2zF0Ug3eJSZwdw66IN0VZAH8dsmNgbjZzF9fw18NEP2ee1kYhhC6/UAphCpuhIbTR
         7ElVgUv1IU0v0w5pAdBpgiGtNI7GlMa48aJr84JGMY0YiJLL6qEJal3tNKLMnLHdGhjG
         3rExR9DFXamJaqgx3aF7dTNXVIqQfFyecMk5A4TZs6J50djjhQ+nvXgG94vst99OYere
         CK9YzfyzzaMmOYPXlBOyYev+C5EEoDGN3G8dK64AXjFlFPhyQHmmuGObJr56sNbIX5fE
         /4ow==
X-Gm-Message-State: AO0yUKX05eYmhopCtakjyEokzRaTIHsojDLxHN8ofMXh5ajnWbzncIRt
        +zA5zyC2Ghkl+aoVOEsFURSSoPpHijVq
X-Google-Smtp-Source: AK7set+LQd+T0aRT1nOHEm7j8W4E/K6xfWruqyX18mazS98+efqvDllhLIgDjt9Oib0BQaMgkUONzQILaLjH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cde9:3fbc:e1f1:6e3b])
 (user=irogers job=sendgmr) by 2002:a25:9ac4:0:b0:967:e782:c03 with SMTP id
 t4-20020a259ac4000000b00967e7820c03mr884748ybo.430.1676799216733; Sun, 19 Feb
 2023 01:33:36 -0800 (PST)
Date:   Sun, 19 Feb 2023 01:28:30 -0800
In-Reply-To: <20230219092848.639226-1-irogers@google.com>
Message-Id: <20230219092848.639226-34-irogers@google.com>
Mime-Version: 1.0
References: <20230219092848.639226-1-irogers@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [PATCH v1 33/51] perf jevent: Parse metric thresholds
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Sean Christopherson <seanjc@google.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parse the metric threshold and add to the pmu-events.c file. The
metric isn't parsed as the parser uses python's parser and will break
the operator precedence.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py   | 7 ++++++-
 tools/perf/pmu-events/pmu-events.h | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index e82dff3a1228..40b9e626fc15 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -51,7 +51,7 @@ _json_event_attributes = [
 
 # Attributes that are in pmu_metric rather than pmu_event.
 _json_metric_attributes = [
-    'metric_name', 'metric_group', 'metric_expr', 'desc',
+    'metric_name', 'metric_group', 'metric_expr', 'metric_threshold', 'desc',
     'long_desc', 'unit', 'compat', 'aggr_mode', 'event_grouping'
 ]
 # Attributes that are bools or enum int values, encoded as '0', '1',...
@@ -306,6 +306,9 @@ class JsonEvent:
     self.metric_expr = None
     if 'MetricExpr' in jd:
       self.metric_expr = metric.ParsePerfJson(jd['MetricExpr']).Simplify()
+    # Note, the metric formula for the threshold isn't parsed as the &
+    # and > have incorrect precedence.
+    self.metric_threshold = jd.get('MetricThreshold')
 
     arch_std = jd.get('ArchStdEvent')
     if precise and self.desc and '(Precise Event)' not in self.desc:
@@ -362,6 +365,8 @@ class JsonEvent:
         # Convert parsed metric expressions into a string. Slashes
         # must be doubled in the file.
         x = x.ToPerfJson().replace('\\', '\\\\')
+      if metric and x and attr == 'metric_threshold':
+        x = x.replace('\\', '\\\\')
       if attr in _json_enum_attributes:
         s += x if x else '0'
       else:
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index 57a38e3e5c32..b7dff8f1021f 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -54,6 +54,7 @@ struct pmu_metric {
 	const char *metric_name;
 	const char *metric_group;
 	const char *metric_expr;
+	const char *metric_threshold;
 	const char *unit;
 	const char *compat;
 	const char *desc;
-- 
2.39.2.637.g21b0678d19-goog

